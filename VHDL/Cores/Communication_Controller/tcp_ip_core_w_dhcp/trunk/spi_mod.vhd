----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:40:35 12/04/2014 
-- Design Name: 
-- Module Name:    spi_mod - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi_mod is
   Port ( 	CLK_IN 							: in  STD_LOGIC;
				RST_IN 							: in  STD_LOGIC;
				
				WR_CONTINUOUS_IN 				: in  STD_LOGIC;
				WE_IN 							: in  STD_LOGIC;
				WR_ADDR_IN						: in 	STD_LOGIC_VECTOR (7 downto 0);
				WR_DATA_IN 						: in  STD_LOGIC_VECTOR (7 downto 0);
				WR_DATA_CMPLT_OUT				: out STD_LOGIC;

				RD_CONTINUOUS_IN 				: in  STD_LOGIC;
				RD_IN								: in	STD_LOGIC;
				RD_WIDTH_IN 					: in  STD_LOGIC;
				RD_ADDR_IN 						: in  STD_LOGIC_VECTOR (7 downto 0);
				RD_DATA_OUT 					: out STD_LOGIC_VECTOR (7 downto 0);
				RD_DATA_CMPLT_OUT				: out STD_LOGIC;
				
				SLOW_CS_EN_IN					: in STD_LOGIC;
				OPER_CMPLT_POST_CS_OUT 		: out STD_LOGIC;
				
				SDI_OUT				: out STD_LOGIC;
				SDO_IN				: in 	STD_LOGIC;
				SCLK_OUT				: out STD_LOGIC;
				CS_OUT				: out STD_LOGIC);
end spi_mod;

architecture Behavioral of spi_mod is

constant C_clk_div 				: unsigned(7 downto 0) := X"02";
constant C_spi_clk_polarity 	: std_logic := '0';
constant C_wr_len					: unsigned(3 downto 0) := X"F";
constant C_rd_8len				: unsigned(7 downto 0) := X"0F"; -- 8 bit addr, 8 bit data
constant C_rd_16len				: unsigned(7 downto 0) := X"17"; -- 8 bit addr, 16 bit data
constant C_wr_cont_len			: unsigned(3 downto 0) := X"7";
constant C_rd_cont_len			: unsigned(7 downto 0) := X"07";
constant C_oper_cmplt_init		: unsigned(7 downto 0) := X"00";

signal clk_counter : unsigned(7 downto 0) := C_clk_div;
signal clk_div, spi_clk, spi_clk_o : std_logic := '0';
signal cs, cs_p, cs_pp, cs_ppp : std_logic := '1';
signal wr_data_cmplt, rd_data_cmplt : std_logic := '0';

signal wr_bit_counter : unsigned(3 downto 0);
signal rd_bit_counter : unsigned(7 downto 0);

signal we_ini, we_ini_p, rd_ini, rd_ini_p, doing_wr, doing_rd : std_logic := '0';
signal operation_cmplt : std_logic := '0';
signal operation_cmplt_reg : std_logic_vector(31 downto 0);
signal wr_data_buf, wr_data_buf2 : std_logic_vector(7 downto 0);
signal rd_addr_buf, rd_data_buf : std_logic_vector(7 downto 0) := (others => '0');
signal doing_wr_p, doing_rd_p, load_countinous_wr : std_logic := '0';
signal sdi_p : std_logic := '0';

signal operation_cmplt_cntr : unsigned(7 downto 0) := C_oper_cmplt_init;
signal oper_cmplt_post_cs : std_logic := '0';

begin

	CS_OUT <= cs;
	SCLK_OUT <= spi_clk_o;
	SDI_OUT <= rd_addr_buf(7) when doing_rd = '1' else wr_data_buf(7);

	WR_DATA_CMPLT_OUT <= wr_data_cmplt;
	RD_DATA_CMPLT_OUT <= rd_data_cmplt;
	
	OPER_CMPLT_POST_CS_OUT <= oper_cmplt_post_cs;

	spi_clk_o <= spi_clk when (cs = '0' and (doing_wr = '1' or doing_rd = '1'))  else C_spi_clk_polarity;

	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			clk_counter <= clk_counter - 1;
			if clk_counter = X"00" then
				clk_counter <= C_clk_div;
			end if;
			if clk_counter = X"00" then
				clk_div <= '1';
			else
				clk_div <= '0';
			end if;
		end if;
	end process;

	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if clk_div = '1' then
				spi_clk <= not(spi_clk);
			end if;
		end if;
	end process;

	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			we_ini_p <= we_ini;
			rd_ini_p <= rd_ini;
			if operation_cmplt = '1' then
				we_ini <= '0';
				rd_ini <= '0';
			elsif we_ini = '0' and rd_ini = '0' then
				if WE_IN = '1' then
					we_ini <= '1';
				elsif WE_IN = '0' and RD_IN = '1' then
					rd_ini <= '1';
				end if;
			end if;
		end if;
	end process;

	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			doing_wr_p <= doing_wr;
			doing_rd_p <= doing_rd;
			if we_ini = '1' and clk_div = '1' and spi_clk = '1' then -- start on next falling edge of spi clk
				doing_wr <= '1';
			elsif operation_cmplt = '1' then
				doing_wr <= '0';
			end if;
			if rd_ini = '1' and clk_div = '1' and spi_clk = '1' then -- start on next falling edge of spi clk
				doing_rd <= '1';
			elsif operation_cmplt = '1' then
				doing_rd <= '0';
			end if;
		end if;
	end process;

	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if we_ini_p = '0' and we_ini = '1' then
				wr_data_buf <= WR_ADDR_IN;
				wr_data_buf2 <= WR_DATA_IN;
			elsif load_countinous_wr = '1' then
				wr_data_buf <= WR_DATA_IN;
			elsif doing_wr = '1' and clk_div = '1' and spi_clk_o = '1' then -- shift on falling edge
				wr_data_buf(7 downto 1) <= wr_data_buf(6 downto 0);
				wr_data_buf(0) <= wr_data_buf2(7);
				wr_data_buf2(7 downto 1) <= wr_data_buf2(6 downto 0);
				wr_data_buf2(0) <= '0';
			end if;
			if doing_wr = '1' and clk_div = '1' and spi_clk_o = '1' then
				if wr_bit_counter = X"0" then
					if WR_CONTINUOUS_IN = '1' then
						wr_bit_counter <= C_wr_cont_len;
					end if;
				else
					wr_bit_counter <= wr_bit_counter - 1;
				end if;
			elsif doing_wr = '0' then
				wr_bit_counter <= C_wr_len;
			end if;
			if doing_wr = '1' and clk_div = '1' and spi_clk_o = '1' then
				if wr_bit_counter = X"0" then
					if WR_CONTINUOUS_IN = '1' then
						load_countinous_wr <= '1';
					end if;
				end if;
			else
				load_countinous_wr <= '0';
			end if;
		end if;
	end process;

	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if doing_wr = '1' and clk_div = '1' and spi_clk_o = '0' and wr_bit_counter = X"0" then -- final rising edge of spi clk
				wr_data_cmplt <= '1';
			else
				wr_data_cmplt <= '0';
			end if;
		end if;
	end process;
	
	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			operation_cmplt_reg(0) <= operation_cmplt;
			operation_cmplt_reg(31 downto 1) <= operation_cmplt_reg(30 downto 0);
			if doing_wr = '1' and clk_div = '1' and spi_clk_o = '1' and wr_bit_counter = X"0" and WR_CONTINUOUS_IN = '0' then
				operation_cmplt <= '1';
			elsif doing_rd = '1' and clk_div = '1' and spi_clk_o = '1' and rd_bit_counter = X"00" and RD_CONTINUOUS_IN = '0' then
				operation_cmplt <= '1';
			else
				operation_cmplt <= '0';
			end if;
			if operation_cmplt = '1' or doing_wr = '1' or doing_rd = '1' then
				operation_cmplt_cntr <= C_oper_cmplt_init;
			else
				operation_cmplt_cntr <= operation_cmplt_cntr - 1;
			end if;
			if WE_IN = '1' then
				cs <= '0';
			elsif RD_IN = '1' then
				cs <= '0';
			elsif operation_cmplt_reg(3) = '1' and SLOW_CS_EN_IN = '0' then
				cs <= '1';
			elsif operation_cmplt_reg(19) = '1' and SLOW_CS_EN_IN = '1' then
				cs <= '1';
			end if;
		end if;
	end process;

	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			cs_p <= cs;
			cs_pp <= cs_p;
			cs_ppp <= cs_pp;
			if cs_ppp = '0' and cs_pp = '1' then
				oper_cmplt_post_cs <= '1';
			else
				oper_cmplt_post_cs <= '0';
			end if;
		end if;
	end process;

	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if rd_ini_p = '0' and rd_ini = '1' then
				rd_addr_buf <= RD_ADDR_IN;
			elsif doing_rd = '1' and clk_div = '1' and spi_clk_o = '1' then -- shift on falling edge
				rd_addr_buf(7 downto 1) <= rd_addr_buf(6 downto 0);
				rd_addr_buf(0) <= '0';
			end if;
			if doing_rd = '1' and clk_div = '1' and spi_clk_o = '1' then
				if rd_bit_counter = X"00" then
					if RD_CONTINUOUS_IN = '1' then
						rd_bit_counter <= C_rd_cont_len;
					end if;
				else
					rd_bit_counter <= rd_bit_counter - 1;
				end if;
			elsif doing_rd = '0' then
				if RD_WIDTH_IN = '0' then
					rd_bit_counter <= C_rd_8len;
				else
					rd_bit_counter <= C_rd_16len;
				end if;
			end if;
			if doing_rd = '1' and clk_div = '1' and spi_clk_o = '0' then 
				if rd_bit_counter < C_rd_8len then
					rd_data_buf(7 downto 1) <= rd_data_buf(6 downto 0);
					rd_data_buf(0) <= SDO_IN;
				end if;
			end if;
		end if;
	end process;

	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if doing_rd = '1' and clk_div = '1' and spi_clk_o = '1' and rd_bit_counter = X"00" then -- final falling edge of spi clk
				rd_data_cmplt <= '1';
			else
				rd_data_cmplt <= '0';
			end if;
			if doing_rd = '1' and clk_div = '1' and spi_clk_o = '1' and rd_bit_counter = X"00" then -- final falling edge of spi clk
				RD_DATA_OUT <= rd_data_buf;
			end if;
		end if;
	end process;

end Behavioral;


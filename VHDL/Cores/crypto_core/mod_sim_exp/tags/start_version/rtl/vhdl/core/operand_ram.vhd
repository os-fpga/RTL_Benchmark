------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	operand_mem.vhd / entity operand_mem
-- 
-- Last Modified:	25/04/2012 
-- 
-- Description: 	BRAM memory and logic to the store 4 (1536-bit) operands and the
--                modulus for the montgomery multiplier
--
--
-- Dependencies: operand_dp (coregen)
--
-- Revision: 
-- Revision 1.01 - added "result_dest_op" input
-- Revision 1.00 - Architecture
-- Revision 0.01 - File Created
-- Additional Comments: 
--
--
------------------------------------------------------------------------------------
--
-- NOTICE:
--
-- Copyright DraMCo research group. 2011. This code may be contain portions patented
-- by other third parties!
--
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity operand_ram is
	port( -- write_operand_ack voorzien?
		-- global ports
		clk : in std_logic;
		collision : out std_logic;
		-- bus side connections (32-bit serial)
		operand_addr : in std_logic_vector(5 downto 0);
		operand_in : in std_logic_vector(31 downto 0);
		operand_in_sel : in std_logic_vector(1 downto 0);
		result_out : out std_logic_vector(31 downto 0);
		write_operand : in std_logic;
		-- multiplier side connections (+1024 bit parallel)
		result_dest_op : in std_logic_vector(1 downto 0);
		operand_out : out std_logic_vector(1535 downto 0);
		operand_out_sel : in std_logic_vector(1 downto 0); -- controlled by bus side :)
		write_result : in std_logic;
		result_in : in std_logic_vector(1535 downto 0)
	);
end operand_ram;

architecture Behavioral of operand_ram is
	-- dual port blockram to store and update operands
	component operand_dp
		port (
		clka: in std_logic;
		wea: in std_logic_vector(0 downto 0);
		addra: in std_logic_vector(5 downto 0);
		dina: in std_logic_vector(31 downto 0);
		douta: out std_logic_vector(511 downto 0);
		clkb: in std_logic;
		web: IN std_logic_VECTOR(0 downto 0);
		addrb: IN std_logic_VECTOR(5 downto 0);
		dinb: IN std_logic_VECTOR(511 downto 0);
		doutb: OUT std_logic_VECTOR(31 downto 0));
	end component;
	
	-- port a signals
	signal addra : std_logic_vector(5 downto 0);
	signal part_enable : std_logic_vector(3 downto 0);
	signal wea : std_logic_vector(3 downto 0);
	signal write_operand_i : std_logic;
	
	-- port b signals
	signal addrb : std_logic_vector(5 downto 0);
	signal web : std_logic_vector(0 downto 0);
	signal doutb0 : std_logic_vector(31 downto 0);
	signal doutb1 : std_logic_vector(31 downto 0);
	signal doutb2 : std_logic_vector(31 downto 0);
	signal doutb3 : std_logic_vector(31 downto 0);
	
begin
	-- WARNING: Very Important!
	-- wea & web signals must never be high at the same time !!
	-- web has priority 
	write_operand_i <= write_operand and not write_result;
	web(0) <= write_result;
	collision <= write_operand and write_result;
	
	-- the dual port ram has a depth of 4 (each layer contains an operand)
	-- result is always stored in position 3
	-- doutb is always result
	with write_operand_i select
		addra <= operand_in_sel & operand_addr(3 downto 0) when '1',
		         operand_out_sel & "0000" when others;
	
	with operand_addr(5 downto 4) select
		part_enable <= "0001" when "00",
		               "0010" when "01",
				         "0100" when "10",
				         "1000" when others;

	with write_operand_i select
		wea <= part_enable when '1',
		       "0000" when others;
	
	-- we can only read back from the result (stored in result_dest_op)
	addrb <= result_dest_op & operand_addr(3 downto 0);
	
--	register_output_proc: process(clk)
--	begin
--		if rising_edge(clk) then
--			case operand_addr(5 downto 4) is
--				when "00" =>
--					result_out <= doutb0;
--				when "01" =>
--					result_out <= doutb1;
--				when "10" =>
--					result_out <= doutb2;
--				when others =>
--					result_out <= doutb3;
--			end case;
--		end if;
--	end process;
	with operand_addr(5 downto 4) select
		result_out <= doutb0 when "00",
		              doutb1 when "01",
				        doutb2 when "10",
				        doutb3 when others;
	
	-- 4 instances of a dual port ram to store the parts of the operand
	op_0 : operand_dp
	port map (
		clka => clk,
		wea => wea(0 downto 0),
		addra => addra,
		dina => operand_in,
		douta => operand_out(511 downto 0),
		clkb => clk,
		web => web,
		addrb => addrb, 
		dinb => result_in(511 downto 0),
		doutb => doutb0
	);
	
	op_1 : operand_dp
	port map (
		clka => clk,
		wea => wea(1 downto 1),
		addra => addra,
		dina => operand_in,
		douta => operand_out(1023 downto 512),
		clkb => clk,
		web => web,
		addrb => addrb,
		dinb => result_in(1023 downto 512),
		doutb => doutb1
	);
	
	op_2 : operand_dp
	port map (
		clka => clk,
		wea => wea(2 downto 2),
		addra => addra,
		dina => operand_in,
		douta => operand_out(1535 downto 1024),
		clkb => clk,
		web => web,
		addrb => addrb,
		dinb => result_in(1535 downto 1024),
		doutb => doutb2
	);
	
--	op_3 : operand_dp
--	port map (
--		clka => clk,
--		wea => wea(3 downto 3),
--		addra => addra,
--		dina => operand_in,
--		douta => operand_out(2047 downto 1536),
--		clkb => clk,
--		web => web,
--		addrb => addrb,
--		dinb => result_in(2047 downto 1536),
--		doutb => doutb3
--	);

end Behavioral;


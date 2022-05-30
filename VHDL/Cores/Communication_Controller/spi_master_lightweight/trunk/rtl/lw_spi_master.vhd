library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lw_spi_master is
generic (
	c_clkfreq 			: integer := 50_000_000;
	c_sclkfreq 			: integer := 5_000_000;
	c_cpol				: std_logic := '0';
	c_cpha				: std_logic := '0'
);
Port ( 
	clk_i 			: in  STD_LOGIC;
	en_i 			: in  STD_LOGIC;
	mosi_data_i 	: in  STD_LOGIC_VECTOR (7 downto 0);
	miso_data_o 	: out STD_LOGIC_VECTOR (7 downto 0);
	data_ready_o 	: out STD_LOGIC;
	cs_o 			: out STD_LOGIC;
	sclk_o 			: out STD_LOGIC;
	mosi_o 			: out STD_LOGIC;
	miso_i 			: in  STD_LOGIC
);
end lw_spi_master;

architecture Behavioral of lw_spi_master is

signal write_reg	: std_logic_vector (7 downto 0) 	:= (others => '0');	
signal read_reg		: std_logic_vector (7 downto 0) 	:= (others => '0');	

signal sclk_en		: std_logic := '0';
signal sclk			: std_logic := '0';
signal sclk_prev	: std_logic := '0';
signal sclk_rise	: std_logic := '0';
signal sclk_fall	: std_logic := '0';

signal pol_phase	: std_logic_vector (1 downto 0) := (others => '0');
signal mosi_en		: std_logic := '0';
signal miso_en		: std_logic := '0';

constant c_edgecntrlimdiv2	: integer := c_clkfreq/(c_sclkfreq*2);
signal edgecntr			: integer range 0 to c_edgecntrlimdiv2 := 0;

signal cntr 	: integer range 0 to 15 := 0;

type states is (S_IDLE, S_TRANSFER);
signal state : states := S_IDLE;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
begin

pol_phase <= c_cpol & c_cpha;

P_SAMPLE_EN : process (pol_phase, sclk_fall, sclk_rise) begin

	case pol_phase is
	
		when "00" =>
			
			mosi_en <= sclk_fall;
			miso_en	<= sclk_rise;
			
		when "01" =>
			
			mosi_en <= sclk_rise;
			miso_en	<= sclk_fall;		

		when "10" =>
			
			mosi_en <= sclk_rise;
			miso_en	<= sclk_fall;			

		when "11" =>

			mosi_en <= sclk_fall;
			miso_en	<= sclk_rise;	

		when others =>
	
	end case;

end process;

P_RISEFALL_DETECT : process (sclk, sclk_prev) begin

	if (sclk = '1' and sclk_prev = '0') then
		sclk_rise <= '1';
	else
		sclk_rise <= '0';
	end if;
	
	if (sclk = '0' and sclk_prev = '1') then
		sclk_fall <= '1';
	else
		sclk_fall <= '0';
	end if;	

end process;


P_MAIN : process (clk_i) begin
if (rising_edge(clk_i)) then

	sclk_prev	<= sclk;
	
	case state is
	
		when S_IDLE =>	
		
			cs_o			<= '1';
			mosi_o			<= '0';
			data_ready_o	<= '0';			
			sclk_en			<= '0';
			cntr			<= 0; 
			
			if (c_cpol = '0') then
				sclk_o	<= '0';
			else
				sclk_o	<= '1';
			end if;	
		
			if (en_i = '1') then
				state		<= S_TRANSFER;
				sclk_en		<= '1';
				write_reg	<= mosi_data_i;
				mosi_o		<= mosi_data_i(7);
				read_reg	<= x"00";
			end if;
		
		when S_TRANSFER =>		
		
			cs_o	<= '0';
			mosi_o	<= write_reg(7);

		
			if (c_cpha = '1') then	
			
				if (cntr = 0) then
					sclk_o	<= sclk;
					if (miso_en = '1') then
						read_reg(0)				<= miso_i;
						read_reg(7 downto 1) 	<= read_reg(6 downto 0);
						cntr					<= cntr + 1;
					end if;				
				elsif (cntr = 8) then
					data_ready_o	<= '1';
					miso_data_o		<= read_reg;
					if (mosi_en = '1') then
						data_ready_o	<= '0';
						if (en_i = '1') then
							write_reg	<= mosi_data_i;
							mosi_o		<= mosi_data_i(7);	
							sclk_o		<= sclk;							
							cntr		<= 0;
						else
							state	<= S_IDLE;
							cs_o	<= '1';								
						end if;	
					end if;
				elsif (cntr = 9) then
					if (miso_en = '1') then
						state	<= S_IDLE;
						cs_o	<= '1';
					end if;						
				else
					sclk_o	<= sclk;
					if (miso_en = '1') then
						read_reg(0)				<= miso_i;
						read_reg(7 downto 1) 	<= read_reg(6 downto 0);
						cntr					<= cntr + 1;
					end if;
					if (mosi_en = '1') then
						mosi_o	<= write_reg(7);
						write_reg(7 downto 1) 	<= write_reg(6 downto 0);
					end if;
				end if;
				
			else	-- c_cpha = '0'
			
				if (cntr = 0) then
					sclk_o	<= sclk;					
					if (miso_en = '1') then
						read_reg(0)				<= miso_i;
						read_reg(7 downto 1) 	<= read_reg(6 downto 0);
						cntr					<= cntr + 1;
					end if;
				elsif (cntr = 8) then
				
					data_ready_o	<= '1';
					miso_data_o		<= read_reg;
					sclk_o			<= sclk;
					if (mosi_en = '1') then
						data_ready_o	<= '0';
						if (en_i = '1') then
							write_reg	<= mosi_data_i;
							mosi_o		<= mosi_data_i(7);		
							cntr		<= 0;
						else
							cntr	<= cntr + 1;
						end if;	
						if (miso_en = '1') then
							state	<= S_IDLE;
							cs_o	<= '1';							
						end if;
					end if;		
				elsif (cntr = 9) then
					if (miso_en = '1') then
						state	<= S_IDLE;
						cs_o	<= '1';
					end if;
				else
					sclk_o	<= sclk;
					if (miso_en = '1') then
						read_reg(0)				<= miso_i;
						read_reg(7 downto 1) 	<= read_reg(6 downto 0);
						cntr					<= cntr + 1;
					end if;
					if (mosi_en = '1') then
						write_reg(7 downto 1) 	<= write_reg(6 downto 0);
					end if;
				end if;			
				
			end if;
		
	end case;
	
end if;
end process;

P_SCLK_GEN : process (clk_i) begin
if (rising_edge(clk_i)) then

	if (sclk_en = '1') then
		if edgecntr = c_edgecntrlimdiv2-1 then
			sclk 		<= not sclk;
			edgecntr	<= 0;
		else
			edgecntr	<= edgecntr + 1;
		end if;	
	else
		edgecntr	<= 0;
		if (c_cpol = '0') then
			sclk	<= '0';
		else
			sclk	<= '1';
		end if;
	end if;

end if;
end process;

end Behavioral;
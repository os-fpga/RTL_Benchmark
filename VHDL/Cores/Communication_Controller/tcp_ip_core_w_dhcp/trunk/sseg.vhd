library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sseg is
 Port (	
			CLK    	: in STD_LOGIC;
			
			VAL_IN  	: in STD_LOGIC_VECTOR (15 downto 0);
			
			SSEG_OUT	: out STD_LOGIC_VECTOR(7 downto 0);
			AN_OUT   : out STD_LOGIC_VECTOR(3 downto 0));
   
end sseg;

architecture Behavioral of sseg is

constant C_clk_div_400hz : std_logic_vector(19 downto 0) := X"1E847";

signal clk_div_counter 		: std_logic_vector(19 downto 0) := (others => '0');
signal clk_400hz				: std_logic := '0';
signal digit_pattern_array : std_logic_vector(7 downto 0) := "00000000";
signal current_segment   	: std_logic_vector(1 downto 0) := "00";
signal cathode_select   	: std_logic_vector(3 downto 0) := "0000";
signal sseg_dr    			: std_logic := '0'; 
signal current_digit			: std_logic_vector(3 downto 0) := "0000";

begin

	SSEG_OUT <= digit_pattern_array;
	AN_OUT <= cathode_select;

  -- Slows up CLK from 50MHz to MUX_CLK 400Hz.
	process(CLK)
	begin 
		if rising_edge(CLK) then
			if clk_div_counter = C_clk_div_400hz then
				clk_div_counter <= (others => '0');
				clk_400hz <= '1';
			else
				clk_div_counter <= clk_div_counter + 1;
				clk_400hz <= '0';
			end if;
		end if;
	end process;

	process(CLK)
	begin
		if rising_edge(CLK) then
			case current_digit is
				when "0000" => digit_pattern_array <= "00000011";
				when "0001" => digit_pattern_array <= "10011111";
				when "0010" => digit_pattern_array <= "00100101";
				when "0011" => digit_pattern_array <= "00001101";
				when "0100" => digit_pattern_array <= "10011001";
				when "0101" => digit_pattern_array <= "01001001";
				when "0110" => digit_pattern_array <= "01000001";
				when "0111" => digit_pattern_array <= "00011111";
				when "1000" => digit_pattern_array <= "00000001";
				when "1001" => digit_pattern_array <= "00011001";
				when "1010" => digit_pattern_array <= "00010001";
				when "1011" => digit_pattern_array <= "11000001";
				when "1100" => digit_pattern_array <= "01100011";
				when "1101" => digit_pattern_array <= "10000101";
				when "1110" => digit_pattern_array <= "01100001";
				when "1111" => digit_pattern_array <= "01110001";
				when others => null;
			end case;
		end if;
	end process;

	process(CLK)
	begin
		if rising_edge(CLK) then
			if clk_400hz = '1' then
				current_segment <= current_segment + 1;
				
				case current_segment is
					when "00" =>
						cathode_select <= "1110";
						current_digit <= VAL_IN(3 downto 0);
					when "01" =>
						cathode_select <= "1101"; 
						current_digit <= VAL_IN(7 downto 4);
					when "10" =>
						cathode_select <= "1011";
						current_digit <= VAL_IN(11 downto 8);
					when "11" =>
						cathode_select <= "0111";
						current_digit <= VAL_IN(15 downto 12);
					when others => null;     
				end case;					
			end if;
		end if;
	end process;
 
end Behavioral;


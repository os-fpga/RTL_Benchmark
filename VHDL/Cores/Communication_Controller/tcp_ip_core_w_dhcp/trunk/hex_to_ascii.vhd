----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:54:41 01/21/2015 
-- Design Name: 
-- Module Name:    hex_to_ascii - Behavioral 
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

entity hex_to_ascii is
    Port ( CLK_IN 			: in  STD_LOGIC;
           CONV_IN 			: in  STD_LOGIC;
           HEX_IN 			: in  STD_LOGIC_VECTOR (3 downto 0);
           ASCII_OUT 		: out  STD_LOGIC_VECTOR (7 downto 0);
           CONV_DONE_OUT 	: out  STD_LOGIC);
end hex_to_ascii;

architecture Behavioral of hex_to_ascii is

signal state : std_logic_vector(1 downto 0) := "00";
signal ascii : unsigned(7 downto 0);

begin

	ASCII_OUT <= std_logic_vector(ascii);

	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if state = "00" then
				if CONV_IN = '1' then
					state <= "01";
				end if;
			elsif state = "01" then
				if HEX_IN > X"9" then
					state <= "10";
				else
					state <= "11";
				end if;
			else
				state <= "00";
			end if;
		end if;
	end process;
	
	process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if state = "10" then
				ascii <= RESIZE(unsigned(HEX_IN), 8) + X"37";
			elsif state = "11" then
				ascii <= RESIZE(unsigned(HEX_IN), 8) + X"30";
			end if;
			if state = "10" then
				CONV_DONE_OUT <= '1';
			elsif state = "11" then
				CONV_DONE_OUT <= '1';
			else
				CONV_DONE_OUT <= '0';
			end if;
		end if;
	end process;
	
end Behavioral;


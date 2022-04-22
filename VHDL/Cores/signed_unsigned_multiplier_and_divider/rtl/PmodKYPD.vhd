----------------------------------------------------------------------------------
-- Company: @Home
-- Engineer: Zoltan Pekic (zpekic@hotmail.com)
-- 
-- Create Date:    23:44:29 03/08/2016 
-- Design Name: 
-- Module Name:    PmodKYPD - Behavioral (http://store.digilentinc.com/pmodkypd-16-button-keypad/)
-- Project Name:   Alarm Clock
-- Target Devices: Mercury FPGA + Baseboard (http://www.micro-nova.com/mercury/)
-- Tool versions:  Xilinx ISE 14.7 (nt64)
-- Description:    Hex keyboard driver
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PmodKYPD is
    Port ( 
           clk : in  STD_LOGIC;
			  reset: in STD_LOGIC;
			  bcdmode: in STD_LOGIC;
           Col : out  STD_LOGIC_VECTOR (3 downto 0);
			  Row : in  STD_LOGIC_VECTOR (3 downto 0);
			  key_code: out  STD_LOGIC_VECTOR (3 downto 0);
			  key_down: out STD_LOGIC
         );
end PmodKYPD;

use work.debouncer;

architecture Behavioral of PmodKYPD is

component debouncer is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           signal_in : in  STD_LOGIC;
           signal_out : out  STD_LOGIC);
end component;

signal counter: unsigned(5 downto 0);
signal key_pressed: std_logic;

begin

scan_key: process(reset, bcdmode, clk, key_pressed)
begin
   if (reset = '1') then
		counter <= "000000";
	else
		if (rising_edge(clk)) then
			if (bcdmode = '1' and counter = "100111") then
				counter <= "000000";
			else
				counter <= counter + 1;
			end if;
			if (key_pressed = '0') then
				key_code <= std_logic_vector(counter(5 downto 2));
				key_down <= '1';
			else
				key_down <= '0';
			end if;
		end if;
	end if;
end process;

-- scanning rows and cols
drive_kbd: process(counter)
begin
	case counter(5 downto 2) is
		when X"0" =>
			col <= "1110";
			key_pressed <= row(3);
		when X"1" =>
			col <= "1110";
			key_pressed <= row(0);
		when X"2" =>
			col <= "1101";
			key_pressed <= row(0);
		when X"3" =>
			col <= "1011";
			key_pressed <= row(0);
		when X"4" =>
			col <= "1110";
			key_pressed <= row(1);
		when X"5" =>
			col <= "1101";
			key_pressed <= row(1);
		when X"6" =>
			col <= "1011";
			key_pressed <= row(1);
		when X"7" =>
			col <= "1110";
			key_pressed <= row(2);
		when X"8" =>
			col <= "1101";
			key_pressed <= row(2);
		when X"9" =>
			col <= "1011";
			key_pressed <= row(2);
		when X"A" =>
			col <= "0111";
			key_pressed <= row(0);
		when X"B" =>
			col <= "0111";
			key_pressed <= row(1);
		when X"C" =>
			col <= "0111";
			key_pressed <= row(2);
		when X"D" =>
			col <= "0111";
			key_pressed <= row(3);
		when X"E" =>
			col <= "1011";
			key_pressed <= row(3);
		when X"F" =>
			col <= "1101";
			key_pressed <= row(3);
		when others =>
			key_pressed <= '1';
	end case;
end process;

end Behavioral;


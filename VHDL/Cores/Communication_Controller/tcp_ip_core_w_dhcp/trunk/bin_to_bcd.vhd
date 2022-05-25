----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:14:45 01/21/2015 
-- Design Name: 
-- Module Name:    bin_to_bcd - Behavioral 
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

entity bin_to_bcd is
    Port ( CLK_IN 			: in  STD_LOGIC;
           CONV_IN 			: in  STD_LOGIC;
           BIN_IN 			: in  STD_LOGIC_VECTOR (7 downto 0);
           BCD_OUT 			: out  STD_LOGIC_VECTOR (11 downto 0);
           CONV_DONE_OUT 	: out  STD_LOGIC);
end bin_to_bcd;

architecture Behavioral of bin_to_bcd is

signal export_bcd : std_logic := '0';
signal state : unsigned(3 downto 0) := X"0";

signal hex_src : unsigned(7 downto 0);
signal bcd, bcd_calcd : unsigned(11 downto 0);

begin

	BCD_OUT <= std_logic_vector(bcd_calcd);

	process (CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if state = X"0" then
				if CONV_IN = '1' then
					state <= X"1";
				end if;
			else
				state <= state + 1;
			end if;
			if state = X"F" then
				export_bcd <= '1';
			else
				export_bcd <= '0';
			end if;
			if export_bcd = '1' then
				CONV_DONE_OUT <= '1';
			else
				CONV_DONE_OUT <= '0';
			end if;
			if export_bcd = '1' then
				bcd_calcd <= bcd;
			end if;
		end if;
	end process;

	process (CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if CONV_IN = '1' then
				hex_src <= unsigned(BIN_IN);
				bcd <= (others => '0');
			elsif state(0) = '0' then
				if bcd(3 downto 0) > "0100" then
					bcd(3 downto 0) <= bcd(3 downto 0) + "0011";
				end if;
				if bcd(7 downto 4) > "0100" then
					bcd(7 downto 4) <= bcd(7 downto 4) + "0011";
				end if;
				if bcd(11 downto 8) > "0100" then
					bcd(11 downto 8) <= bcd(11 downto 8) + "0011";
				end if;
			else
				bcd <= bcd(10 downto 0) & hex_src(7);
				hex_src <= hex_src(6 downto 0) & '0';
			end if;
		end if;
	end process ;

end Behavioral;


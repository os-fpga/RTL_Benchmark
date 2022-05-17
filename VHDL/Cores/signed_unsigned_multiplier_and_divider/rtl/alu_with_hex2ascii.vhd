----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:32:07 03/05/2018 
-- Design Name: 
-- Module Name:    alu_with_hex2ascii - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_with_hex2ascii is
    Port ( a : in  STD_LOGIC_VECTOR (15 downto 0);
           b : in  STD_LOGIC_VECTOR (15 downto 0);
			  bcdmode: in STD_LOGIC;
           operation : in  STD_LOGIC_VECTOR (2 downto 0);
           carry_in : in  STD_LOGIC;
           carry_out : out  STD_LOGIC;
           zero : out  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR (15 downto 0));
end alu_with_hex2ascii;

architecture Behavioral of alu_with_hex2ascii is

signal hexchar, ascii, offset: std_logic_vector(7 downto 0);
signal y_out, a_padded, b_padded, a_plus_b, a_minus_b, b_2compl: std_logic_vector(17 downto 0);

begin

-- select hex digit to convert to ASCII code
	with bcdmode & operation(1 downto 0) select
		hexchar <=  X"3" & b(3 downto 0) when "000",		-- hex is coming through input B
						X"3" & b(7 downto 4) when "001",
						X"3" & b(11 downto 8) when "010",
						X"3" & b(15 downto 12) when "011",
						X"3" & a(3 downto 0) when "100",		-- bcd is coming through input A
						X"3" & a(7 downto 4) when "101",
						X"3" & a(11 downto 8) when "110",
						X"3" & a(15 downto 12) when others;

-- convert to ASCII
	offset <= X"07" when hexchar(3) = '1' and (hexchar(2) = '1' or hexchar(1) = '1') else X"00";
   ascii <= std_logic_vector(unsigned(hexchar) + unsigned(offset));
					
-- 2's complement add and substract
	a_padded <= '0' & a & carry_in;
	b_padded <= '0' & b & carry_in;
	--b_2compl <= ('0', not b(15), not b(14), not b(13), not b(12), not b(11), not b(10), not b(9), not b(8), not b(7), not b(6), not b(5), not b(4), not b(3), not b(2), not b(1), not b(0), carry_in);
	a_minus_b <= std_logic_vector(unsigned(a_padded) + unsigned(b_padded xor "011111111111111110"));
	a_plus_b <= std_logic_vector(unsigned(a_padded) + unsigned(b_padded));

-- result is either +/- or ASCII code

with operation(2 downto 0) select
	y_out <= a_plus_b		when "000",
				a_minus_b	when "001",
				a_padded		when "010", -- for possible future use
				b_padded		when "011", -- for possible future use
				'0' & X"00" & ascii & '0' when others;
				
-- generate outputs
	y <= y_out(16 downto 1);
	carry_out <= y_out(17);
	zero <= '1' when y_out(16 downto 1) = X"0000" else '0';

end Behavioral;


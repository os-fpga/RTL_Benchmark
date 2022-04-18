----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:08:09 03/28/2018 
-- Design Name: 
-- Module Name:    bcddigitadder - Behavioral 
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

entity bcddigitadder is
    Port ( ci : in  STD_LOGIC;
           a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           y : out  STD_LOGIC_VECTOR (3 downto 0);
           cout : inout  STD_LOGIC);
end bcddigitadder;

architecture Behavioral of bcddigitadder is

signal binarysum: std_logic_vector(5 downto 0);
signal adjustedsum: std_logic_vector(4 downto 0);
alias adjust: std_logic is cout;

begin

binarysum <= std_logic_vector(unsigned('0' & a & ci) + unsigned('0' & b & ci));
adjustedsum <= std_logic_vector(unsigned('0' & binarysum(4 downto 1)) + "00110");
adjust <= '1' when (binarysum(4 downto 2) = "101" or binarysum(4 downto 3) = "11") else binarysum(5);

y <= adjustedsum(3 downto 0) when adjust = '1' else binarysum(4 downto 1);

end Behavioral;
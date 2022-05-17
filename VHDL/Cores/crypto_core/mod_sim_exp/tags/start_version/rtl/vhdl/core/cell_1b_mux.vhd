------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	cell_1b_mux.vhd / entity cell_1b_mux
-- 
-- Last Modified:	14/11/2011 
-- 
-- Description: 	mux for use in the montgommery multiplier systolic array
--						currently a behavioral description
--
--
-- Dependencies: 	none
--
-- Revision:
--	Revision 1.00 - Architecture
--	Revision 0.01 - File Created
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

entity cell_1b_mux is
    Port ( my : in  STD_LOGIC;
           y : in  STD_LOGIC;
           m : in  STD_LOGIC;
           x : in  STD_LOGIC;
           q : in  STD_LOGIC;
           result : out  STD_LOGIC);
end cell_1b_mux;

architecture Behavioral of cell_1b_mux is
	signal sel : std_logic_vector(1 downto 0);
begin
	
	sel <= x & q;
	
	with sel select
		result <= my when "11",
		          y when "10",
					 m when "01",
					 '0' when others;

end Behavioral;


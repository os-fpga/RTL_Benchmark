------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	cell_1b_adder.vhd / entity cell_1b_adder
-- 
-- Last Modified:	18/11/2011 
-- 
-- Description: 	full adder for use in the montgommery multiplier systolic array
--						currently a behavioral description
--
--
-- Dependencies: 	none
--
-- Revision:
-- Revision 2.00 - Major error resolved (carry & sum output were switched)
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

entity cell_1b_adder is
    Port ( a : in  STD_LOGIC;
           mux_result : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           cout : out  STD_LOGIC;
           r : out  STD_LOGIC);
end cell_1b_adder;

architecture Behavioral of cell_1b_adder is
	signal a_xor_mux_result: std_logic;
begin
	a_xor_mux_result <= a xor mux_result;
	r <= a_xor_mux_result xor cin;
	cout <= (a and mux_result) or (cin and a_xor_mux_result);
end Behavioral;


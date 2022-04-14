------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	cell_1b.vhd / entity cell_1b
-- 
-- Last Modified:	14/11/2011 
-- 
-- Description: 	cell for use in the montgommery multiplier systolic array
--
--
-- Dependencies: 	cell_1b_adder
--						cell_1b_mux
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

entity cell_1b is
    Port ( my : in  STD_LOGIC;
           y : in  STD_LOGIC;
           m : in  STD_LOGIC;
           x : in  STD_LOGIC;
           q : in  STD_LOGIC;
			  a : in  STD_LOGIC;
			  cin : in STD_LOGIC;
			  cout : out STD_LOGIC;
           r : out  STD_LOGIC);
end cell_1b;

architecture Structural of cell_1b is
	component cell_1b_mux
		 Port ( my : in  STD_LOGIC;
				  y : in  STD_LOGIC;
				  m : in  STD_LOGIC;
				  x : in  STD_LOGIC;
				  q : in  STD_LOGIC;
				  result : out  STD_LOGIC);
	end component;
	
	component cell_1b_adder
		 Port ( a : in  STD_LOGIC;
				  mux_result : in  STD_LOGIC;
				  cin : in  STD_LOGIC;
				  cout : out  STD_LOGIC;
				  r : out  STD_LOGIC);
	end component;

	signal mux2adder : std_logic;
begin
	
	cell_mux: cell_1b_mux
	port map( my => my,
				  y => y,
				  m => m,
				  x => x,
				  q => q,
				  result => mux2adder
	);

	cell_adder: cell_1b_adder
	port map(a => a,
				  mux_result => mux2adder,
				  cin => cin,
				  cout => cout,
				  r => r
	);

end Structural;
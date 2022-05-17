------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	standard_cell_block.vhd / entity standard_cell_block
-- 
-- Last Modified:	14/11/2011 
-- 
-- Description: 	cell_block for use in the montgommery multiplier systolic array
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

entity standard_cell_block is
	generic ( width : integer := 16
	);
   Port ( my : in  STD_LOGIC_VECTOR((width-1) downto 0);
           y : in  STD_LOGIC_VECTOR((width-1) downto 0);
           m : in  STD_LOGIC_VECTOR((width-1) downto 0);
           x : in  STD_LOGIC;
           q : in  STD_LOGIC;
			  a : in  STD_LOGIC_VECTOR((width-1) downto 0);
			  cin : in STD_LOGIC;
			  cout : out STD_LOGIC;
           r : out  STD_LOGIC_VECTOR((width-1) downto 0));
end standard_cell_block;

architecture Structural of standard_cell_block is
	component cell_1b
		 Port ( my : in  STD_LOGIC;
           y : in  STD_LOGIC;
           m : in  STD_LOGIC;
           x : in  STD_LOGIC;
           q : in  STD_LOGIC;
			  a : in  STD_LOGIC;
			  cin : in STD_LOGIC;
			  cout : out STD_LOGIC;
           r : out  STD_LOGIC);
	end component;

	signal carry : std_logic_vector(width downto 0);
begin
	
	carry(0) <= cin;
	
	cell_block: for i in 0 to (width-1) generate
		cells: cell_1b
			port map( my => my(i),
						  y => y(i),
						  m => m(i),
						  x => x,
						  q => q,
						  a => a(i),
						  cin => carry(i),
						  cout => carry(i+1),
						  r => r(i)
			);
	end generate;

	cout <= carry(width);
end Structural;
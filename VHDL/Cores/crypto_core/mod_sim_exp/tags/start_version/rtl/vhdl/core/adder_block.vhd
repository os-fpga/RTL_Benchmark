------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	adder_block.vhd / entity adder_block
-- 
-- Last Modified:	25/11/2011 
-- 
-- Description: 	adder block for use in the montgommery multiplier pre- and post-
--						computation adders
--
--
-- Dependencies: 	cell_1b_adder,
--						d_flip_flop
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

entity adder_block is
	generic ( width : integer := 32
	);
   Port ( core_clk : in STD_LOGIC;
			  a : in  STD_LOGIC_VECTOR((width-1) downto 0);
           b : in  STD_LOGIC_VECTOR((width-1) downto 0);
			  cin : in STD_LOGIC;
			  cout : out STD_LOGIC;
           s : out  STD_LOGIC_VECTOR((width-1) downto 0)
	);
end adder_block;

architecture Structural of adder_block is
	component cell_1b_adder
		 Port ( a : in  STD_LOGIC;
				  mux_result : in  STD_LOGIC;
				  cin : in  STD_LOGIC;
				  cout : out  STD_LOGIC;
				  r : out  STD_LOGIC);
	end component;
	
	component d_flip_flop
   port(core_clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			    din : in  STD_LOGIC;
		      dout : out STD_LOGIC
	);
	end component;
	
	signal carry : std_logic_vector(width downto 0);
begin
	
	carry(0) <= cin;
	
	adder_chain: for i in 0 to (width-1) generate
		adders: cell_1b_adder
		port map(a => a(i),
					mux_result => b(i),
					cin => carry(i),
					cout => carry(i+1),
					r => s(i)
		);
	end generate;
	
	delay_1_cycle: d_flip_flop
   port map(core_clk => core_clk,
			  reset => '0',
			    din => carry(width),
		      dout => cout
	);
	
end Structural;
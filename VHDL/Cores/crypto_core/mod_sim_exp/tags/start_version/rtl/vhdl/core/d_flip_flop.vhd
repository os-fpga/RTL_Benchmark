------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	d_flip_flop.vhd / entity d_flip_flop
-- 
-- Last Modified:	24/11/2011 
-- 
-- Description: 	1 bit D flip-flop
--
--
-- Dependencies: 	LDCE
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
library UNISIM;
use UNISIM.VComponents.all;

entity d_flip_flop is
   port(core_clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			    din : in  STD_LOGIC;
		      dout : out STD_LOGIC
	);
end d_flip_flop;

architecture Structural of d_flip_flop is
	signal dout_i : std_logic;
begin
	
	dout <= dout_i;
	
	FDCE_inst : FDCE
	generic map (
		INIT => '0')     -- Initial value of latch ('0' or '1')  
	port map (
		Q => dout_i,     -- Data output
		CLR => reset,    -- Asynchronous clear/reset input
		D => din,        -- Data input
		C => core_clk,   -- Gate input
		CE => '1'        -- Gate enable input
	);	
	
end Structural;
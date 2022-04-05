------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	register_1b.vhd / entity register_1b
-- 
-- Last Modified:	24/11/2011 
-- 
-- Description: 	1 bit register
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

entity register_1b is
   port(core_clk : in  STD_LOGIC;
			     ce : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			    din : in  STD_LOGIC;
		      dout : out STD_LOGIC
	);
end register_1b;

architecture Structural of register_1b is
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
		CE => ce         -- Gate enable input
	);	
	
end Structural;
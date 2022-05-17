------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	register_n.vhd / entity register_n
-- 
-- Last Modified:	24/11/2011 
-- 
-- Description: 	n bit register
--
--
-- Dependencies: 	FDCE
--
-- Revision:
-- Revision 3.00 - Replaced LDCE primitive with FDCE primitive
-- Revision 2.00 - Replaced behavioral architecture with structural using FPGA
--                 primitives.
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

entity register_n is
	generic( n : integer := 4
	);
   port(core_clk : in  STD_LOGIC;
			     ce : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			    din : in  STD_LOGIC_VECTOR((n-1) downto 0);
		      dout : out STD_LOGIC_VECTOR((n-1) downto 0)
	);
end register_n;

architecture Structural of register_n is
	signal dout_i : std_logic_vector((n-1) downto 0) := (others => '0');
begin
	
	dout <= dout_i;
	
	N_REGS: for i in 0 to n-1 generate
		FDCE_inst : FDCE
		generic map (
			INIT => '0')     -- Initial value of latch ('0' or '1')  
		port map (
			Q => dout_i(i),  -- Data output
			CLR => reset,    -- Asynchronous clear/reset input
			D => din(i),     -- Data input
			C => core_clk,   -- Gate input
			CE => ce         -- Gate enable input
		);
	end generate;
	
	
end Structural;
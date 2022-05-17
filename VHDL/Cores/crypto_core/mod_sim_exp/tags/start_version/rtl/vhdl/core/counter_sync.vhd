------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	counter_sync.vhd / entity counter_sync
-- 
-- Last Modified:	23/01/2012 
-- 
-- Description: 	counter with synchronous count enable. It generates an
--						overflow when max_value is reached
--
--
-- Dependencies: 	none
--
-- Revision:
-- Revision 2.00 - moved max_value from generic to port so it is changeable in runtime
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

entity counter_sync is
	generic(max_value : integer := 1024
	);
   port(reset_value : in integer;
			core_clk : in  STD_LOGIC;
			     ce : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
		  overflow : out STD_LOGIC
	);
end counter_sync;

architecture Behavioral of counter_sync is
	
	signal overflow_i : std_logic := '0';
begin
	
	overflow <= overflow_i;
	
	COUNT_PROC: process(core_clk, ce, reset)
		variable steps_counter : integer range 0 to max_value-1 := 0;
	begin
		if reset = '1' then  -- reset counter
			steps_counter := 0;
			overflow_i <= '0';
		elsif rising_edge(core_clk) then
			if ce = '1' then -- count
				if steps_counter = (reset_value-1) then -- generate overflow and reset counter
					steps_counter := 0;
					overflow_i <= '1';
				else	-- just count
					steps_counter := steps_counter + 1;
					overflow_i <= '0';
				end if;
			else
				overflow_i <= '0';
				steps_counter := steps_counter;
			end if;
		end if;
	end process;
	
end Behavioral;
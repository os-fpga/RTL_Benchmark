------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	stepping_logic.vhd / entity stepping_logic
-- 
-- Last Modified:	23/01/2012 
-- 
-- Description: 	stepping logic for the pipelined montgomery multiplier
--
--
-- Dependencies: 	counter_sync
--
-- Revision:
-- Revision 5.01 - defined integer range for t_sel and n_sel resulting in less LUTs
-- Revision 5.00 - made the reset value changeable in runtime
-- Revision 4.01 - Delayed ready pulse with 1 clk cylce. This delay is necessary
--                 for the reduction to complete.
-- Revision 4.00 - Changed design to fit new pipeline-architecture
--                 (i.e. 1 clock cycle / stage)
-- Revision 3.00 - Removed second delay on next_x
-- Revision 2.00 - Changed operation to give a pulse on stepping_done when pipeline
--                 operation has finished
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

entity stepping_logic is
	generic( n : integer := 1536; -- max nr of steps required to complete a multiplication
				t : integer := 192 -- total nr of steps in the pipeline
	);
   port(    core_clk : in  STD_LOGIC;
			      start : in  STD_LOGIC;
			      reset : in  STD_LOGIC;
					t_sel : in integer range 0 to t; -- nr of stages in the pipeline piece
					n_sel : in integer range 0 to n; -- nr of steps required for a complete multiplication
	start_first_stage : out STD_LOGIC;
       stepping_done : out STD_LOGIC
	);
end stepping_logic;

architecture Behavioral of stepping_logic is
	component d_flip_flop
   port(core_clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			    din : in  STD_LOGIC;
		      dout : out STD_LOGIC
	);
	end component;
	
	component counter_sync
	generic(max_value : integer := 16
	);
   port(reset_value : in integer;
	     core_clk : in  STD_LOGIC;
			     ce : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
		  overflow : out STD_LOGIC
	);
	end component;

	signal laststeps_in_i : std_logic := '0';
	signal laststeps_out_i : std_logic := '0';
	signal start_stop_in_i : std_logic := '0';
	signal start_stop_out_i : std_logic := '0';
	signal steps_in_i : std_logic := '0';	
	signal steps_out_i : std_logic := '0';
	signal substeps_in_i : std_logic := '0';	
	signal substeps_out_i : std_logic := '0';
	signal done_reg_in_i : std_logic := '0';	
	signal done_reg_out_i : std_logic := '0';
	signal start_first_stage_i : std_logic := '0';
	signal start_i : std_logic := '0';

begin
	start_i <= start;

	-- map outputs
	start_first_stage <= start_first_stage_i;
	stepping_done <= laststeps_out_i;
	
	-- internal signals
	start_stop_in_i <= start_i or (start_stop_out_i and not steps_out_i);
	substeps_in_i <= start_stop_in_i;
	steps_in_i <= substeps_out_i;
	done_reg_in_i <= steps_out_i or (done_reg_out_i and not laststeps_out_i);
	laststeps_in_i <= done_reg_in_i;
	start_first_stage_i <= start_i or steps_in_i;
	--start_first_stage_i <= steps_in_i;
	
	done_reg: d_flip_flop
   port map(core_clk => core_clk,
			  reset => reset,
			    din => done_reg_in_i,
		      dout => done_reg_out_i
	);
	
	start_stop_reg: d_flip_flop
   port map(core_clk => core_clk,
			  reset => reset,
			    din => start_stop_in_i,
		      dout => start_stop_out_i
	);
	
	-- for counting the last steps
	laststeps_counter: counter_sync
	generic map(max_value => t
	)
   port map(reset_value => t_sel,
			core_clk => core_clk,
			     ce => laststeps_in_i,
			  reset => reset,
		  overflow => laststeps_out_i
	);
	
	-- counter for keeping track of the steps
	steps_counter: counter_sync
	generic map(max_value => n
	)
   port map(reset_value => (n_sel),
			core_clk => core_clk,
			     ce => steps_in_i,
			  reset => reset,
		  overflow => steps_out_i
	);
	
	-- makes sure we don't start too early with a new step
	substeps_counter: counter_sync
	generic map(max_value => 2
	)
   port map(reset_value => 2,
			core_clk => core_clk,
			     ce => substeps_in_i,
			  reset => reset,
		  overflow => substeps_out_i
	);
	
end Behavioral;
------------------------------------------------------------------------------------ 
--			
-- Geoffrey Ottoy - DraMCo research group
--
-- Module Name:	multiplier_core.vhd / entity multiplier_core
-- 
-- Last Modified:	18/06/2012 
-- 
-- Description: 	a pipelined montgomery multiplier, with split
--                pipeline operation and "auto-run" support
--
--
-- Dependencies: 	mont_mult_sys_pipeline, operand_mem, fifo_primitive, mont_cntrl
--
-- Revision:
-- Revision 6.00 - created seperate module for x-operand (x_shift_reg)
-- Revision 5.00 - moved fifo interface to shared memory
-- Revision 4.00 - added dest_op_single input
-- Revision 3.00 - added auto-run control
-- Revision 2.01 - Split ctrl_reg input to separate inputs with more descriptive
--                 names
-- Revision 2.00 - Control logic moved to separate design module and added fifo
--	Revision 1.00 - Architecture based on multiplier IP core "mont_mult1536_v1_00_a"
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

entity multiplier_core is
    port(          clk : in  std_logic;
	              reset : in  std_logic;
			-- operand memory interface (plb shared memory)
			 write_enable : in  std_logic;
               data_in : in  std_logic_vector (31 downto 0);
            rw_address : in  std_logic_vector (8 downto 0);
              data_out : out std_logic_vector (31 downto 0);
				 collision : out std_logic;
			-- op_sel fifo interface
			     fifo_din : in  std_logic_vector (31 downto 0);
			    fifo_push : in  std_logic;
			    fifo_full : out std_logic;
			  fifo_nopush : out std_logic;
			-- ctrl signals
			        start : in  std_logic;
			     run_auto : in  std_logic;
			        ready : out std_logic;
		    x_sel_single : in  std_logic_vector (1 downto 0);
		    y_sel_single : in  std_logic_vector (1 downto 0);
		  dest_op_single : in  std_logic_vector (1 downto 0);
                 p_sel : in  std_logic_vector (1 downto 0);
				 calc_time : out std_logic
	);
end multiplier_core;

architecture Behavioral of multiplier_core is
	component mont_mult_sys_pipeline
	generic ( n : integer := 32;
		nr_stages : integer := 8; --(divides n, bits_low & (n-bits_low))
		stages_low : integer := 3
	);
   Port ( core_clk : in STD_LOGIC;
           xy : in  STD_LOGIC_VECTOR((n-1) downto 0);
           m : in  STD_LOGIC_VECTOR((n-1) downto 0);
           r : out  STD_LOGIC_VECTOR((n-1) downto 0);
			  start : in STD_LOGIC;
			  reset : in STD_LOGIC;
			  p_sel : in  STD_LOGIC_VECTOR(1 downto 0);
			  load_x : in std_logic;
			  ready : out STD_LOGIC
	);
	end component;
	
	component operand_mem
	port(
		data_in : in  std_logic_vector(31 downto 0);
		data_out : out  std_logic_vector(31 downto 0);
		rw_address : in  std_logic_vector(8 downto 0);
		op_sel : in  std_logic_vector(1 downto 0);
		xy_out : out  std_logic_vector(1535 downto 0);
		m : out  std_logic_vector(1535 downto 0);
		result_in : in std_logic_vector(1535 downto 0);
		load_op : in std_logic;
		load_m : in std_logic;
		load_result : in std_logic;
		result_dest_op : in std_logic_vector(1 downto 0);
		collision : out std_logic;
		clk : in  std_logic
	);
	end component;
	
	component fifo_primitive
	port(
		clk : in std_logic;
		din : in std_logic_vector(31 downto 0);
		push : in std_logic;
		pop : in std_logic;
		reset : in std_logic;          
		dout : out std_logic_vector(31 downto 0);
		empty : out std_logic;
		full : out std_logic;
		nopop : out std_logic;
		nopush : out std_logic
		);
	end component;
	
	component mont_ctrl
	port(
		clk : in std_logic;
		reset : in std_logic;
		start : in std_logic;
		x_sel_single : in std_logic_vector(1 downto 0);
		y_sel_single : in std_logic_vector(1 downto 0);
		run_auto : in std_logic;
		op_sel_buffer : in std_logic_vector(31 downto 0);
		read_buffer : out std_logic;
		multiplier_ready : in std_logic;          
		op_buffer_empty : in std_logic;
		buffer_noread : in std_logic;
		done : out std_logic;
		calc_time : out std_logic;
		op_sel : out std_logic_vector(1 downto 0);
		load_x : out std_logic;
		load_result : out std_logic;
		start_multiplier : out std_logic
		);
	end component;
	
	signal xy_i : std_logic_vector(1535 downto 0);
	signal x_i : std_logic;
	signal m : std_logic_vector(1535 downto 0);
	signal r : std_logic_vector(1535 downto 0);
	
	signal op_sel : std_logic_vector(1 downto 0);
	signal result_dest_op_i : std_logic_vector(1 downto 0);
	signal mult_ready : std_logic;
	signal start_mult : std_logic;
	signal load_op : std_logic;
	signal load_x_i : std_logic;
	signal load_m : std_logic;
	signal load_result : std_logic;
	
	signal fifo_empty : std_logic;
	signal fifo_pop : std_logic;
	signal fifo_nopop : std_logic;
	signal fifo_dout : std_logic_vector(31 downto 0);
	--signal fifo_push : std_logic;
	
	constant n : integer := 1536;
	constant t : integer := 96;
	constant tl : integer := 32;
begin

	-- The actual multiplier
	the_multiplier: mont_mult_sys_pipeline generic map(
		n => n,
		nr_stages => t, --(divides n, bits_low & (n-bits_low))
		stages_low => tl
	)
	port map(
		core_clk => clk,
		xy => xy_i,
		m => m,
		r => r,
		start => start_mult,
		reset => reset,
		p_sel => p_sel,
		load_x => load_x_i,
		ready => mult_ready
	);
	
	-- Block ram memory for storing the operands and the modulus
	the_memory: operand_mem port map(
		data_in => data_in,
		data_out => data_out,
		rw_address => rw_address,
		op_sel => op_sel,
		xy_out => xy_i,
		m => m,
		result_in => r,
		load_op => load_op,
		load_m => load_m,
		load_result => load_result,
		result_dest_op => result_dest_op_i,
		collision => collision,
		clk => clk
	);
	load_op <= write_enable when (rw_address(8) = '0') else '0';
	load_m <= write_enable when (rw_address(8) = '1') else '0';
	result_dest_op_i <= dest_op_single when run_auto = '0' else "11"; -- in autorun mode we always store the result in operand3
	
	-- A fifo for auto-run operand selection
	the_exponent_fifo: fifo_primitive port map(
		clk => clk,
		din => fifo_din,
		dout => fifo_dout,
		empty => fifo_empty,
		full => fifo_full,
		push => fifo_push,
		pop => fifo_pop,
		reset => reset,
		nopop => fifo_nopop,
		nopush => fifo_nopush
	);
	
	-- The control logic for the core
	the_control_unit: mont_ctrl port map(
		clk => clk,
		reset => reset,
		start => start,
		x_sel_single => x_sel_single,
		y_sel_single => y_sel_single,
		run_auto => run_auto,
		op_buffer_empty => fifo_empty,
		op_sel_buffer => fifo_dout,
		read_buffer => fifo_pop,
		buffer_noread => fifo_nopop,
		done => ready,
		calc_time => calc_time,
		op_sel => op_sel,
		load_x => load_x_i,
		load_result => load_result,
		start_multiplier => start_mult,
		multiplier_ready => mult_ready
	);

	
end Behavioral;


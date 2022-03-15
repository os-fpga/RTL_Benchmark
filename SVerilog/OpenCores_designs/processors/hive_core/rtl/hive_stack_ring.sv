/*
--------------------------------------------------------------------------------

Module : hive_stack_ring.sv

--------------------------------------------------------------------------------

Function:
- 8 stage pipelined BRAM based LIFOs.

Instantiates:
- (1x) hive_level_ring.sv
- (1x) ram_dq.sv

Dependencies:
- hive_pkg.sv

Notes:
- Forms 8 LIFOs, one per thread.
- Level logic services 8 separate LIFOs via pipelining.
- Single BRAM services 8 separate LIFOs via address partitioning (id).

--------------------------------------------------------------------------------
*/
module hive_stack_ring
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// inputs
	input			logic								cls_i,						// stack clear
	input			logic								pop_1_i,						// stack pop
	input			logic								psh_5_i,						// stack push
	input			logic	[THD_W-1:0]				id_6_i,						// ID
	input			logic	[ALU_W-1:0]				data_6_i,					// data
	// outputs
	output		logic	[ALU_W-1:0]				data_o,						// data
	output		logic								pop_er_2_o,					// pop when empty, active high 
	output		logic								psh_er_5_o					// push when full, active high
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*;
	//
	logic					[STK_LVL_W-1:0]		level_6;
	logic												wr_6;


	/*
	================
	== code start ==
	================
	*/


	hive_level_ring	hive_level_ring
	(
	.*,
	.level_6_o		( level_6 ),
	.wr_6_o			( wr_6 )
	);


	ram_dq
	#(
	.REG_OUT			( 1 ),
	.DATA_W			( ALU_W ),
	.ADDR_W			( THD_W+STK_PTR_W ),
	.MODE 			( "WAR" )
	)
	hive_stacks_mem
	(
	.*,
	.addr_i			( { id_6_i, level_6[STK_PTR_W-1:0] } ),
	.wr_i				( wr_6 ),
	.data_i			( data_6_i ),
	.data_o			( data_o )
	);

	
endmodule

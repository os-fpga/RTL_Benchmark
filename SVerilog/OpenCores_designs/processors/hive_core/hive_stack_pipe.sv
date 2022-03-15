/*
--------------------------------------------------------------------------------

Module : hive_stack_pipe.sv

--------------------------------------------------------------------------------

Function:
- Processor stack pipe.

Instantiates:
- (1x) hive_stack_level.sv
- (2x) pipe.sv
- (1x) dq_ram.sv

Dependencies:
- hive_pkg.sv

Notes:
- 8 stage pipelined BRAM based LIFOs.

--------------------------------------------------------------------------------
*/
module hive_stack_pipe
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// inputs
	input			logic								cls_i,						// stack clear
	input			logic								pop_i,						// stack pop
	input			logic								psh_i,						// stack push
	input			logic	[ID_W-1:0]				id_6_i,						// ID
	input			logic	[ALU_W-1:0]				data_6_i,					// data
	input			logic	[STKLVL_W-1:0]			level_0_i,					// stack level
	// outputs
	output		logic	[STKLVL_W-1:0]			level_0_o,					// loop this back externally!
	output		logic	[ALU_W-1:0]				data_0_o,					// data
	output		logic								pop_er_2_o,					// pop when empty, active high 
	output		logic								psh_er_2_o					// push when full, active high
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*;
	//
	logic					[STKLVL_W-1:0]			level_3, level_6;
	logic												wr_3, wr_6;


	/*
	================
	== code start ==
	================
	*/


	hive_stack_level	hive_stack_level
	(
	.*,
	.level_i			( level_0_i ),
	.level_3_o		( level_3 ),
	.wr_3_o			( wr_3 )
	);


	// 3:6 pipe
	pipe
	#(
	.DEPTH		( 3 ),
	.WIDTH		( 1+STKLVL_W ),
	.RESET_VAL	( 0 )
	)
	pipe_3_6
	(
	.*,
	.data_i		( { wr_3, level_3 } ),
	.data_o		( { wr_6, level_6 } )
	);


	dq_ram
	#(
	.REG_OUT			( 1 ),
	.DATA_W			( ALU_W ),
	.ADDR_W			( ID_W+STKPTR_W ),
	.MODE 			( "RAW" )
	)
	hive_stacks_mem
	(
	.*,
	.addr_i			( { id_6_i, level_6[STKPTR_W-1:0] } ),
	.wr_i				( wr_6 ),
	.data_i			( data_6_i ),
	.data_o			( data_0_o )
	);


	// 6:0 pipe
	pipe
	#(
	.DEPTH		( 2 ),
	.WIDTH		( STKLVL_W ),
	.RESET_VAL	( 0 )
	)
	pipe_6_0
	(
	.*,
	.data_i		( level_6 ),
	.data_o		( level_0_o )
	);

	
endmodule

/*
--------------------------------------------------------------------------------

Module: hive_error

Function: 
- Track errors in the core.

Instantiates:
- (1x) hive_base_reg.sv

Notes:
- Register set interface is COW1.

--------------------------------------------------------------------------------
*/

module hive_error
	(
	// clocks & resets
	input		logic							clk_i,							// clock
	input		logic							rst_i,							// async. reset, active hi
	// rbus interface
	input		logic	[RBUS_ADDR_W-1:0]	rbus_addr_i,					// address
	input		logic							rbus_wr_i,						// data write enable, active high
	input		logic							rbus_rd_i,						// data read enable, active high
	input		logic	[ALU_W-1:0]			rbus_wr_data_i,				// write data
	output	logic	[ALU_W-1:0]			rbus_rd_data_o,				// read data
	// errors
	input		logic							op_er_i,							// 1=illegal op code encountered
	input		logic							pop_er_i,						// 1=pop when empty
	input		logic							psh_er_i,						// 1=push when full
	// id
	input		ID_T							id_i								// id
	);


	/*
	----------------------
	-- internal signals --
	----------------------
	*/	
	import hive_params::*; 
	import hive_defines::*; 
	import hive_types::*;
	//
	logic												op_er_1, psh_er_1, pop_er_1;
	logic					[THREADS-1:0]			op_er, psh_er, pop_er;

	
	/*
	================
	== code start ==
	================
	*/



	// delay regs
	pipe
	#(
	.DEPTH		( 1 ),
	.WIDTH		( 1+1+1 ),
	.RESET_VAL	( 0 )
	)
	regs_0_1
	(
	.*,
	.data_i		( { op_er_i, psh_er_i, pop_er_i } ),
	.data_o		( { op_er_1, psh_er_1, pop_er_1 } )
	);


	// decode errors
	always_comb op_er  = op_er_1  << id_i[1];
	always_comb psh_er = psh_er_1 << id_i[1];
	always_comb pop_er = pop_er_1 << id_i[1];


	// rbus registers
	hive_base_reg
	#(
	.DATA_W			( ALU_W ),
	.ADDR_W			( RBUS_ADDR_W ),
	.ADDR				( `ERROR_ADDR ),
	.WR_MODE			( "COW1" ),
	.RD_MODE			( "LOOP" ),
	.WR_MASK			( { (THREADS+THREADS+THREADS){ 1'b1 } } ),
	.RD_MASK			( { (THREADS+THREADS+THREADS){ 1'b1 } } )
	)
	error_reg
	(
	.*,
	.reg_wr_o		(  ),
	.reg_rd_o		(  ),
	.reg_data_o		(  ),
	.reg_data_i		( { op_er, psh_er, pop_er } )
	);


endmodule

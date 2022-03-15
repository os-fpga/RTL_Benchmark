/*
--------------------------------------------------------------------------------

Module : hive_alu_top.sv

--------------------------------------------------------------------------------

Function:
- Processor ALU top level.

Instantiates (at this level):
- (1x) hive_alu_logical.sv
- (1x) hive_alu_add_sub.sv
- (1x) hive_alu_mult_shift.sv
- (1x) hive_alu_mux.sv

Dependencies:
- hive_pkg.sv

Notes:
- I/O registered.
- Multi-stage pipeline.

--------------------------------------------------------------------------------
*/
//`include "hive_pkg.sv"
module hive_alu_top
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// control I/O
	input			logic								sgn_i,						// 1=signed
	input			logic								ext_i,						// 1=extended result
	input			logic								low_i,						// 1=low
	input			LG_T								lg_i,							// logic operation
	input			logic								add_i,						// 1=add
	input			logic								sub_i,						// 1=subtract
	input			logic								mul_i,						// 1=multiply
	input			logic								shl_i,						// 1=shift left
	input			logic								pow_i,						// 1=power of 2
	input			logic								pgc_i,						// 1=return pc
	input			logic								mem_rd_i,					// 1=read
	input			logic								reg_rd_i,					// 1=read
	// data I/O
	input			logic	[ALU_W-1:0]				a_i,							// operand
	input			logic	[ALU_W-1:0]				b_i,							// operand
	input			logic	[PC_W-1:0]				pc_2_i,						// program counter
	input			logic	[ALU_W-1:0]				rbus_rd_data_i,			// rbus read data
	input			logic	[ALU_W-1:0]				mem_4_i,						// mem read data
	output		logic	[ALU_W-1:0]				result_6_o,					// result
	// flags
	output		logic								flg_nz_2_o,					//	a != 0
	output		logic								flg_lz_2_o,					//	a < 0
	output		logic								flg_od_2_o,					//	a odd
	output		logic								flg_ne_2_o,					//	a != b
	output		logic								flg_lt_2_o					//	a < b
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*;
	import hive_types::*;
	//
	logic					[ALU_W-1:0]				res_lg_2, res_as_2, res_ms_5;


	/*
	================
	== code start ==
	================
	*/


	// logical unit
	hive_alu_logical
	#(
	.REGS_IN				( 1 ),
	.REGS_MID			( 1 ),
	.REGS_OUT			( 0 ),
	.REGS_FLG			( 1 )
	)
	hive_alu_logical
	(
	.*,
	.result_o			( res_lg_2 ),
	.flg_nz_o			( flg_nz_2_o ),
	.flg_lz_o			( flg_lz_2_o ),
	.flg_od_o			( flg_od_2_o )
	);


	// add & subtract unit
	hive_alu_add_sub
	#(
	.REGS_IN				( 1 ),
	.REGS_MID			( 1 ),
	.REGS_OUT			( 0 ),
	.REGS_FLG			( 1 )
	)
	hive_alu_add_sub
	(
	.*,
	.result_o			( res_as_2 ),
	.flg_ne_o			( flg_ne_2_o ),
	.flg_lt_o			( flg_lt_2_o )
	);


	// multiply & shift unit
	hive_alu_mult_shift
	#(
	.REGS_IN				( 1 ),
	.REGS_OUT			( 0 )
	)
	hive_alu_mult_shift
	(
	.*,
	.result_o			( res_ms_5 )
	);


	// multiplexer
	hive_alu_mux	hive_alu_mux
	(
	.*,
	.as_i					( add_i | sub_i ),
	.ms_i					( mul_i | shl_i | pow_i ),
	.res_lg_2_i			( res_lg_2 ),
	.res_as_2_i			( res_as_2 ),
	.res_ms_5_i			( res_ms_5 ),
	.data_6_o			( result_6_o )
	);


endmodule

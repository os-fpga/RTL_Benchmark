/*
--------------------------------------------------------------------------------

Module : hive_data_ring.sv

--------------------------------------------------------------------------------

Function:
- Processor data path & data stacks.

Instantiates (at this level):
- (1x) hive_alu_top.sv
- (1x) hive_stack.sv
- (1x) pipe.sv

Dependencies:
- hive_pkg.sv

Notes:
- 8 stage data pipeline beginning and ending on 8*8 BRAM based LIFOs.

--------------------------------------------------------------------------------
*/

module hive_data_ring
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// control I/O
	input			logic	[STK_W-1:0]				sa_i,							// stack selector
	input			logic	[STK_W-1:0]				sb_i,							// stack selector
	input			logic								imda_i,						// 1=immediate data
	input			logic								sgn_i,						// 1=signed
	input			logic								ext_i,						// 1=extended result
	input			logic								low_i,						// 1=low
	input			logic								lg_i,							// lg op
	input			logic								add_i,						// 1=add
	input			logic								sub_i,						// 1=subtract
	input			logic								mul_i,						// 1=multiply
	input			logic								shl_i,						// 1=shift left
	input			logic								pow_i,						// 1=power of 2
	input			logic								pgc_i,						// 1=return pc
	input			logic								mem_rd_i,					// 1=read
	input			logic								reg_rd_i,					// 1=read
	input			logic								reg_wr_i,					// 1=write
	// stack I/O
	input			logic	[STACKS-1:0]			stk_im_i,					// stack immediate
	input			logic								cls_im_i,					// stack clear (stk_im_o)
	input			logic								pop_im_i,					// stack pop (from stk_im_o)
	input			logic								pop_a_i,						// stack a pop (from sa_o)
	input			logic								pop_b_i,						// stack b pop (from sb_o)
	input			logic								psh_a_i,						// stack push (to sa_o)
	input			ID_T								id_i,							// id
	// data I/O
	input			logic	[ALU_W-1:0]				alu_im_i,					// alu immediate
	input			logic	[PC_W-1:0]				pc_2_i,						// program counter
	input			logic	[ALU_W-1:0]				mem_4_i,						// mem read data
	output		logic	[ALU_W-1:0]				a_o,							// a
	output		logic	[ALU_W-1:0]				b_o,							// b 
	// rbus I/O
	output		logic	[RBUS_ADDR_W-1:0]		rbus_addr_o,				// address
	output		logic								rbus_wr_o,					// data write enable, active high
	output		logic								rbus_rd_o,					// data read enable, active high
	output		logic	[ALU_W-1:0]				rbus_wr_data_o,			// write data
	input			logic	[ALU_W-1:0]				rbus_rd_data_i,			// read data
	// flags
	output		logic								flg_nz_2_o,					//	a != 0
	output		logic								flg_lz_2_o,					//	a < 0
	output		logic								flg_od_2_o,					//	a odd
	output		logic								flg_ne_2_o,					//	a != b
	output		logic								flg_lt_2_o,					//	a < b
	// errors
	output		logic								pop_er_o,					// pop when empty, active high 
	output		logic								psh_er_o						// push when full, active high
	);


	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*;
	import hive_types::*;
	//
	logic					[ALU_W-1:0]				b_im;
	logic					[ALU_W-1:0]				data_6;



	/*
	================
	== code start ==
	================
	*/


	// select data
	always_comb b_im = ( imda_i ) ? alu_im_i : b_o;


	// ALU
/*	hive_alu_top		hive_alu_top
	(
	.*,
	.a_i					( a_o ),
	.b_i					( b_im ),
	.result_6_o			( data_6 )
	);

*/
	// stacks
	hive_stacks	hive_stacks
	(
	.*,
	.data_6_i			( data_6 )
	);


	// rbus registering
	pipe
	#(
	.DEPTH		( 1 ),
	.WIDTH		( 2+RBUS_ADDR_W+ALU_W ),
	.RESET_VAL	( 0 )
	)
	rbus_regs
	(
	.*,
	.data_i		( { reg_wr_i,   reg_rd_i, alu_im_i[RBUS_ADDR_W-1:0], a_o } ),
	.data_o		( { rbus_wr_o, rbus_rd_o, rbus_addr_o,    rbus_wr_data_o } )
	);


endmodule

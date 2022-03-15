/*
--------------------------------------------------------------------------------

Module : hive_control_ring.sv

--------------------------------------------------------------------------------

Function:
- Processor control path.

Instantiates (at this level):
- (1x) hive_id_ring.sv
- (1x) hive_tst_decode.sv
- (1x) hive_op_decode.sv
- (1x) hive_pc_ring.sv
- (1x) hive_vector_pipe.sv

Dependencies:
- hive_pkg.sv

Notes:
- 8 stage pipeline consisting of several storage rings.

--------------------------------------------------------------------------------
*/
//`include "hive_pkg.sv"
import hive_params::*;
import hive_types::*;
module hive_control_ring
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// control I/O
	input			logic								cla_i,						// clear all threads, active high
	input			logic	[THREADS-1:0]			xsr_i,						// external IRQ request
	input			logic	[CODE_W-1:0]			opcode_i,					// opcode
	output		logic								op_er_o,						// 1=illegal op code encountered
	// alu I/O
	input			logic	[PC_W-1:0]				b_i,							// b | im
	output		logic	[ALU_W-1:0]				alu_im_o,					// alu immediate
	output		logic	[STK_W-1:0]				sa_o,							// stack selector
	output		logic	[STK_W-1:0]				sb_o,							// stack selector
	output		logic								imda_o,						// 1=immediate data
	output		logic								sgn_o,						// 1=signed
	output		logic								ext_o,						// 1=extended
	output		logic								low_o,						// 1=low
	output		logic								lg_o,							// logic op
	output		logic								add_o,						// 1=add
	output		logic								sub_o,						// 1=subtract
	output		logic								mul_o,						// 1=multiply
	output		logic								shl_o,						// 1=shift left
	output		logic								pow_o,						// 1=power of 2
	output		logic								pgc_o,						// 1=return pc
	output		logic								lit_o,						// 1=literal data
	// mem & reg I/O
	output		logic	[MEM_IM_W-1:0]			mem_im_o,					// mem immediate
	output		logic								mem_rd_o,					// 1=read
	output		logic								mem_wr_o,					// 1=write
	output		logic								reg_rd_o,					// 1=read
	output		logic								reg_wr_o,					// 1=write
	// stack I/O
	output		logic	[STACKS-1:0]			stk_im_o,					// stack immediate
	output		logic								cls_im_o,					// stack clear (stk_im_o)
	output		logic								pop_im_o,					// stack pop (from stk_im_o)
	output		logic								pop_a_o,						// stack a pop (from sa_o)
	output		logic								pop_b_o,						// stack b pop (from sb_o)
	output		logic								psh_a_o,						// stack push (to sa_o)
	// flags
	input			logic								flg_nz_2_i,					//	a != 0
	input			logic								flg_lz_2_i,					//	a < 0
	input			logic								flg_od_2_i,					//	a odd
	input			logic								flg_ne_2_i,					//	a != b
	input			logic								flg_lt_2_i,					//	a < b
	// thread IDs
	output		ID_T								id_o,
	// addresses
	output		PC_T								pc_o,
	// rbus interface
	input			logic	[RBUS_ADDR_W-1:0]		rbus_addr_i,				// address
	input			logic								rbus_wr_i,					// data write enable, active high
	input			logic								rbus_rd_i,					// data read enable, active high
	input			logic	[ALU_W-1:0]				rbus_wr_data_i,			// write data
	output		logic	[ALU_W-1:0]				time_rd_data_o,			// read data
	output		logic	[ALU_W-1:0]				vect_rd_data_o				// read data
	);


	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	
	//
	logic												cnd, jmp, gto, tst_res_3, imad;
	TST_T												tst;
	logic					[PC_W-1:0]				pc_im, b_im;
	logic												clt, irq, irt, clt_6, irq_6;



	/*
	================
	== code start ==
	================
	*/


	// establish thread IDs
	hive_id_ring	hive_id_ring
	(
	.*,
	.rbus_rd_data_o	( time_rd_data_o )
	);


	// conditional jump etc. testing
	hive_tst_decode
	#(
	.REGS_TST		( 2 ),
	.REGS_OUT		( 1 )
	)
	hive_tst_decode
	(
	.*,
	.flg_nz_i		( flg_nz_2_i ),
	.flg_lz_i		( flg_lz_2_i ),
	.flg_od_i		( flg_od_2_i ),
	.flg_ne_i		( flg_ne_2_i ),
	.flg_lt_i		( flg_lt_2_i ),
	.cnd_i			( cnd ),
	.tst_i			( tst ),
	.result_o		( tst_res_3 )
	);


	// opcode decoding
	hive_op_decode	hive_op_decode
	(
	.*,
	.clt_i			( clt_6 ),
	.clt_o			( clt ),
	.irq_i			( irq_6 ),
	.irq_o			( irq ),
	.irt_o			( irt ),
	.pc_im_o			( pc_im ),
	.cnd_o			( cnd ),
	.jmp_o			( jmp ),
	.gto_o			( gto ),
	.tst_o			( tst ),
	.imad_o			( imad )
	);


	// address selection
	always_comb b_im = ( imad ) ? pc_im : b_i;


	// pc generation & storage
	hive_pc_ring	hive_pc_ring
	(
	.*,
	.id_i				( id_o ),
	.clt_i			( clt ),
	.irq_i			( irq ),
	.jmp_i			( jmp ),
	.gto_i			( gto ),
	.tst_res_3_i	( tst_res_3 ),
	.b_im_i			( b_im )
	);


	// vector handling
	hive_vector_pipe  hive_vector_pipe
	(
	.*,
	.rbus_rd_data_o	( vect_rd_data_o ),
	.id_i					( id_o ),
	.clt_i				( clt ),
	.irt_i				( irt ),
	.clt_6_o				( clt_6 ),
	.irq_6_o				( irq_6 )
	);


endmodule

/*
--------------------------------------------------------------------------------

Module: hive_vector_pipe.sv

Function: 
- Vector (clear & interrupt) control for multiple processor threads.

Instantiates: 
- (1x) in_cond.sv
- (8x) hive_vector_ctl.sv
- (3x) pipe.sv
- (1x) hive_base_reg.sv

Dependencies:
- hive_pkg.sv

Notes:
- See hive_vector_ctl.sv for details.
- Internally pipelined from opcode decoder output to input.

--------------------------------------------------------------------------------
*/
import hive_params::*;
import hive_types::*; 
import hive_defines::*;
module hive_vector_pipe
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// external interface
	input			logic								cla_i,						// clear all, active high
	input			logic	[THREADS-1:0]			xsr_i,						// external interrupt edge(s)
	// rbus interface
	input			logic	[RBUS_ADDR_W-1:0]		rbus_addr_i,				// address
	input			logic								rbus_wr_i,					// data write enable, active high
	input			logic								rbus_rd_i,					// data read enable, active high
	input			logic	[ALU_W-1:0]				rbus_wr_data_i,			// write data
	output		logic	[ALU_W-1:0]				rbus_rd_data_o,			// read data
	// multiplexed serial interface
	input			ID_T								id_i,							// thread ID
	input			logic								clt_i,						// clear thread, active high
	input			logic								irt_i,						// irq return, active high
	output		logic								clt_6_o,						// clear thread, active high
	output		logic								irq_6_o						// irq, active high
	);


	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	
	//
	logic						[THREADS-1:0]		xsr;
	logic												clt_1, irt_1;
	logic						[THREADS-1:0]		clt_2, irq_2;
	logic												clt_or_2, irq_or_2;
	logic						[THREADS-1:0]		en_oh_1;
	logic												reg_wr;
	logic						[THREADS-1:0]		reg_arm, reg_dis, reg_isr, reg_clt, reg_armed, reg_isv;
	//
	genvar											g;


	/*
	================
	== code start ==
	================
	*/


	// input conditioning
	in_cond
	#(
	.DATA_W			( THREADS ),
	.SYNC_W			( SYNC_W ),
	.LIVE_MASK		( XSR_LIVE_MASK ),
	.SYNC_MASK		( XSR_SYNC_MASK ),
	.RISE_MASK		( XSR_RISE_MASK ),
	.FALL_MASK		( XSR_FALL_MASK )
	)
	xsr_in_cond
	(
	.*,
	.data_i			( xsr_i ),
	.data_o			( xsr )
	);


	// 0:1 pipe
	pipe
	#(
	.DEPTH		( 1 ),
	.WIDTH		( 1+1 ),
	.RESET_VAL	( 0 )
	)
	pipe_0_1
	(
	.*,
	.data_i		( { irt_i, clt_i } ),
	.data_o		( { irt_1, clt_1 } )
	);


	// encode one-hot inputs
	always_comb en_oh_1 = 1'b1 << id_i[1];

	// per thread state machines
	generate
		for ( g=0; g<THREADS; g=g+1 ) begin : ctl_loop
			hive_vector_ctl  inst_hive_vector_ctl
			(
			.*,
			.xsr_i			( xsr[g] ),
			.reg_wr_i		( reg_wr ),
			.reg_arm_i		( reg_arm[g] ),
			.reg_dis_i		( reg_dis[g] ),
			.reg_clt_i		( reg_clt[g] ),
			.reg_isr_i		( reg_isr[g] ),
			.reg_armed_o	( reg_armed[g] ),
			.reg_isv_o		( reg_isv[g] ),
			.en_1_i			( en_oh_1[g] ),
			.clt_1_i			( clt_1 ),
			.irt_1_i			( irt_1 ),
			.clt_2_o			( clt_2[g] ),
			.irq_2_o			( irq_2[g] )
			);
		end  // endfor
	endgenerate

	// combine one-hot outputs
	always_comb clt_or_2 = |clt_2;
	always_comb irq_or_2 = |irq_2;


	// 2:6 pipe
	pipe
	#(
	.DEPTH		( 4 ),
	.WIDTH		( 1+1 ),
	.RESET_VAL	( 2'b01 )  // note: assert clear @ async reset!
	)
	pipe_2_6
	(
	.*,
	.data_i		( { irq_or_2, clt_or_2 } ),
	.data_o		( { irq_6_o,  clt_6_o  } )
	);


	// rbus registers
	hive_base_reg
	#(
	.DATA_W			( ALU_W ),
	.ADDR_W			( RBUS_ADDR_W ),
	.ADDR				( `VECT_ADDR ),
	.WR_MODE			( "THRU" ),
	.RD_MODE			( "THRU" ),
	.WR_MASK			( { (THREADS+THREADS+THREADS+THREADS){ 1'b1 } } ),
	.RD_MASK			( { (THREADS+THREADS+THREADS){ 1'b1 } } )
	)
	vect_reg
	(
	.*,
	.reg_wr_o		( reg_wr ),
	.reg_rd_o		(  ),
	.reg_data_o		( { reg_clt, reg_isr, reg_arm,    reg_dis   } ),
	.reg_data_i		( {          reg_isv, reg_armed, ~reg_armed } )
	);



endmodule

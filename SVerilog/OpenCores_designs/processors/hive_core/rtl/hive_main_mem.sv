/*
--------------------------------------------------------------------------------

Module: hive_main_mem.sv

Function: 
- Main memory.

Instantiates: 
- (1x) ram_dp_dual.sv
- (4x) pipe.sv

Dependencies:
- hive_pkg.sv

Notes:
- Inputs registered.
- Size ADDR_W for desired memory depth.
- Reads and writes work for 16 bit and aligned / unaligned 32 bit I/O.

--------------------------------------------------------------------------------
*/

module hive_main_mem
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// data port
	input			logic								lit_i,						// 1=literal data
	input			logic								low_i,						// 1=low
	input			logic								wr_i,							// write, active high
	input			logic	[PC_W-1:0]				pc_1_i,						// program counter
	input			logic	[MEM_IM_W-1:0]			im_i,							// immediate address offset
	input			logic	[MEM_ADDR_W-1:0]		b_i,							// address
	input			logic	[ALU_W-1:0]				a_i,							// write data
	output		logic	[ALU_W-1:0]				mem_4_o,						// read data
	// opcode port
	input			logic	[PC_W-1:0]				pc_4_i,						// program counter
	output		logic	[CODE_W-1:0]			opcode_6_o					// opcode
	);


	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*;
	//
	logic												lit_1, low_1, wr_1, wr_en_1, wr_lo_1, wr_hi_1;
	logic					[1:0]						wr_mux_1, wr_2, wr_en_2;
	logic												b_hi_4_lsb, pc_6_lsb;
	logic					[MEM_ADDR_W-1:0]		b_1, b_hi_1, b_hi_2, b_lo_2;
	logic					[MEM_IM_W-1:0]			im_1;
	logic					[ALU_W-1:0]				a_mux_1;
	logic					[LOW_W-1:0]				a_hi_1, a_hi_2, mem_hi_4;
	logic					[LOW_W-1:0]				a_lo_1, a_lo_2, mem_lo_4;
	logic					[CODE_W-1:0]			opcode_hi_6, opcode_lo_6;


	/*
	================
	== code start ==
	================
	*/


	// in to 1 regs
	pipe
	#(
	.DEPTH		( 1 ),
	.WIDTH		( 2+MEM_IM_W+1+MEM_ADDR_W+ALU_W ),
	.RESET_VAL	( 0 )
	)
	regs_0_1
	(
	.*,
	.data_i		( { lit_i, low_i, im_i, wr_i, b_i, a_i } ),
	.data_o		( { lit_1, low_1, im_1, wr_1, b_1, a_hi_1, a_lo_1 } )
	);


	// select pc or offset address
	always_comb b_hi_1 = ( lit_1 ) ? pc_1_i[MEM_ADDR_W-1:0] : b_1 + im_1;

	// select straight or swapped write data
	always_comb a_mux_1 = ( b_hi_1[0] ) ? { a_lo_1, a_hi_1 } : { a_hi_1, a_lo_1 };
	
	// decode writes
	always_comb wr_hi_1 = ( low_1 ) ? '0 : wr_1;  // don't write high if low
	always_comb wr_lo_1 = wr_1;  // follow write

	// select straight or swapped write enables
	always_comb wr_mux_1 = ( b_hi_1[0] ) ? { wr_lo_1, wr_hi_1 } : { wr_hi_1, wr_lo_1 };


	// 1 to 2 regs
	pipe
	#(
	.DEPTH		( 1 ),
	.WIDTH		( 2+MEM_ADDR_W+ALU_W ),
	.RESET_VAL	( 0 )
	)
	regs_1_2
	(
	.*,
	.data_i		( { wr_mux_1, b_hi_1, a_mux_1 } ),
	.data_o		( { wr_2,     b_hi_2, a_hi_2, a_lo_2  } )
	);


	// always inc low addr
	always_comb b_lo_2 = b_hi_2 + 1'b1;

	// decode write enables
	always_comb wr_en_2[1] = ( MEM_ROM_W ) ? |b_hi_2[MEM_ADDR_W-1:MEM_ROM_W] : '1;  // don't write in rom area.
	always_comb wr_en_2[0] = ( MEM_ROM_W ) ? |b_lo_2[MEM_ADDR_W-1:MEM_ROM_W] : '1;  // don't write in rom area.


	// instruction and data memory
	ram_dp_dual
	#(
	.DATA_W				( CODE_W ),
	.ADDR_W				( MEM_ADDR_W-1 ),  // -1 due to dual mems
	.A_REG				( 1 ),
	.B_REG				( 1 ),
	.A_MODE 				( "RAW" ),  // functional don't care
	.B_MODE 				( "RAW" )  // functional don't care
	)
	mem
	(
	.*,
	//
	.a1_addr_i			( b_hi_2[MEM_ADDR_W-1:1] ),
	.a0_addr_i			( b_lo_2[MEM_ADDR_W-1:1] ),
	.a1_wr_i				( wr_2[1] & wr_en_2[1] ),
	.a0_wr_i				( wr_2[0] & wr_en_2[0] ),
	.a1_i					( a_hi_2 ),
	.a0_i					( a_lo_2 ),
	.a1_o					( mem_hi_4 ),
	.a0_o					( mem_lo_4 ),
	//
	.b1_addr_i			( pc_4_i[MEM_ADDR_W-1:1] ),
	.b0_addr_i			( pc_4_i[MEM_ADDR_W-1:1] ),
	.b1_wr_i				( 1'b0 ),  // unused
	.b0_wr_i				( 1'b0 ),  // unused
	.b1_i					(  ),  // unused
	.b0_i					(  ),  // unused
	.b1_o					( opcode_hi_6 ),
	.b0_o					( opcode_lo_6 )
	);


	// 2 to 4 regs
	pipe
	#(
	.DEPTH		( 2 ),
	.WIDTH		( 1 ),
	.RESET_VAL	( 0 )
	)
	regs_2_4
	(
	.*,
	.data_i		( b_hi_2[0] ),
	.data_o		( b_hi_4_lsb )
	);


	// swap output
	always_comb mem_4_o = ( b_hi_4_lsb ) ? { mem_lo_4, mem_hi_4 } : { mem_hi_4, mem_lo_4 };


	// 4 to 6 regs
	pipe
	#(
	.DEPTH		( 2 ),
	.WIDTH		( 1 ),
	.RESET_VAL	( 0 )
	)
	regs_4_6
	(
	.*,
	.data_i		( pc_4_i[0] ),
	.data_o		( pc_6_lsb )
	);


	// pick output
	always_comb opcode_6_o = ( pc_6_lsb ) ? opcode_hi_6 : opcode_lo_6;


endmodule

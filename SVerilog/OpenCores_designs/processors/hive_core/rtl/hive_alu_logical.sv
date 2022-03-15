/*
--------------------------------------------------------------------------------

Module : hive_alu_logical

--------------------------------------------------------------------------------

Function:
- Logic unit for a processor ALU.

Instantiates:
- (4x) pipe.sv

Dependencies:
- hive_pkg.sv

Notes:
- IN/MID/OUT/FLG optionally registered.
- Default path through is don't care.

--------------------------------------------------------------------------------
*/
//`include "hive_pkg.sv"
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*;
	import hive_types::*;
	import hive_funcs::*;
	//
module hive_alu_logical
	#(
	parameter										REGS_IN			= 1,		// register option for inputs
	parameter										REGS_MID			= 1,		// mid register option
	parameter										REGS_OUT			= 1,		// register option for outputs
	parameter										REGS_FLG			= 1		// register option for flag outputs
	)
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// control I/O
	input			LG_T								lg_i,							// logic op
	// data I/O
	input			logic	[ALU_W-1:0]				a_i,							// operand
	input			logic	[ALU_W-1:0]				b_i,							// operand
	output		logic	[ALU_W-1:0]				result_o,					// logical result
	// flags
	output		logic								flg_nz_o,					//	a != 0
	output		logic								flg_lz_o,					//	a < 0
	output		logic								flg_od_o						//	a odd
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*;
	import hive_types::*;
	import hive_funcs::*;
	//
	localparam										LZC_W			= $clog2( ALU_W ) + 1;
	//
	LG_T												lg, lg_m;
	logic					[ALU_W-1:0]				a, b;
	logic					[ALU_W-1:0]				res_1, res_1_m;
	logic					[ALU_W-1:0]				res_2, res_2_m;
	logic												res_bra, res_bra_m;
	logic												res_bro, res_bro_m;
	logic												res_brx, res_brx_m;
	logic					[ALU_W-1:0]				result;
	logic												flg_nz, flg_lz, flg_od;


	/*
	================
	== code start ==
	================
	*/


	// optional input registers
	pipe
	#(
	.DEPTH		( REGS_IN ),
	.WIDTH		( LG_W+ALU_W+ALU_W ),
	.RESET_VAL	( 0 )
	)
	in_regs
	(
	.*,
	.data_i		( { lg_i, b_i, a_i } ),
	.data_o		( { lg,   b,   a   } )
	);


	// flags
	always_comb flg_nz = |a;
	always_comb flg_lz = a[ALU_W-1];
	always_comb flg_od = a[0];
	
	// one operand bit reduction results
	always_comb res_bra = &b;
	always_comb res_bro = |b;
	always_comb res_brx = ^b;


	// multiplex results
	always_comb begin
		unique case ( lg )
			lg_cpy  : res_1 <= b;
			lg_bnh  : res_1 <= { ~b[ALU_W-1], b[ALU_W-2:0] };
			lg_not  : res_1 <= ~b;
			lg_and  : res_1 <= a & b;
			lg_orr  : res_1 <= a | b;
			lg_xor  : res_1 <= a ^ b;
			default : res_1 <= 'x;  // default is don't care
		endcase
	end

	// multiplex results
	always_comb begin
		unique case ( lg )
			lg_flp  : res_2 <= flip( b );
			lg_lzc  : res_2 <= lzc( b );
			default : res_2 <= 'x;  // default is don't care
		endcase
	end


	// optional flag regs
	pipe
	#(
	.DEPTH		( REGS_FLG ),
	.WIDTH		( 3 ),
	.RESET_VAL	( 0 )
	)
	regs_flags
	(
	.*,
	.data_i		( { flg_od,   flg_nz,   flg_lz   } ),
	.data_o		( { flg_od_o, flg_nz_o, flg_lz_o } )
	);


	// optional mid regs
	pipe
	#(
	.DEPTH		( REGS_MID ),
	.WIDTH		( LG_W+3+ALU_W+ALU_W ),
	.RESET_VAL	( 0 )
	)
	mid_regs
	(
	.*,
	.data_i		( { lg,   res_bra,   res_bro,   res_brx,   res_2,   res_1   } ),
	.data_o		( { lg_m, res_bra_m, res_bro_m, res_brx_m, res_2_m, res_1_m } )
	);


	// multiplex all results
	always_comb begin
		unique case ( lg_m )
			lg_cpy  : result <= res_1_m;
			lg_bnh  : result <= res_1_m;
			lg_not  : result <= res_1_m;
			lg_and  : result <= res_1_m;
			lg_orr  : result <= res_1_m;
			lg_xor  : result <= res_1_m;
			lg_bra  : result <= res_bra_m;
			lg_bro  : result <= res_bro_m;
			lg_brx  : result <= res_brx_m;
			lg_lzc  : result <= res_2_m;
			lg_flp  : result <= res_2_m;
			default : result <= 'x; // default is don't care
		endcase
	end


	// optional output regs
	pipe
	#(
	.DEPTH		( REGS_OUT ),
	.WIDTH		( ALU_W ),
	.RESET_VAL	( 0 )
	)
	out_regs
	(
	.*,
	.data_i		( result ),
	.data_o		( result_o )
	);


endmodule

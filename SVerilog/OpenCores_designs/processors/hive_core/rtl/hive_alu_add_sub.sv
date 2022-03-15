/*
--------------------------------------------------------------------------------

Module : hive_alu_add_sub.sv

--------------------------------------------------------------------------------

Function:
- Add & subtract unit for a processor ALU.

Instantiates:
- (4x) pipe.sv

Dependencies:
- hive_pkg.sv

Notes:
- IN/MID/OUT/FLG optionally registered.

--------------------------------------------------------------------------------
*/

module hive_alu_add_sub
	#(
	parameter										REGS_IN			= 1,		// in register option
	parameter										REGS_MID			= 1,		// mid register option
	parameter										REGS_OUT			= 1,		// out register option
	parameter										REGS_FLG			= 1		// flag register option
	)
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// control I/O
	input			logic								sgn_i,						// 1=signed
	input			logic								ext_i,						// 1=extended result
	input			logic								sub_i,						// 1=subtract; 0=add
	// data I/O
	input			logic	[ALU_W-1:0]				a_i,							// operand
	input			logic	[ALU_W-1:0]				b_i,							// operand
	output		logic	[ALU_W-1:0]				result_o,					// = ( a +/- b )
	// flags
	output		logic								flg_ne_o,					//	a != b
	output		logic								flg_lt_o						//	a < b
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*;
	//
	localparam										ADD_SUB_W		= ALU_W+2;  // +2 extra bits
	//
	logic												sgn, sub, ext, sub_m, ext_m;
	logic	signed		[ALU_W-1:0]				a, b;
	logic	signed		[ZSX_W-1:0]				a_zsx, b_zsx;
	logic	signed		[ADD_SUB_W-1:0]		ab_add, ab_sub, ab_add_m, ab_sub_m;
	logic	signed		[DBL_W-1:0]				res_dbl;
	logic	signed		[ALU_W-1:0]				result;
	logic												flg_ne, flg_lt;


	/*
	================
	== code start ==
	================
	*/


	// optional input regs
	pipe
	#(
	.DEPTH		( REGS_IN ),
	.WIDTH		( 3+ALU_W+ALU_W ),
	.RESET_VAL	( 0 )
	)
	in_regs
	(
	.*,
	.data_i		( { sub_i, ext_i, sgn_i, b_i, a_i } ),
	.data_o		( { sub,   ext,   sgn,   b,   a   } )
	);

	
	// zero|sign extend results
	always_comb a_zsx = { ( sgn & a[ALU_W-1] ), a };
	always_comb b_zsx = { ( sgn & b[ALU_W-1] ), b };

	// arithmetic results (signed)
	always_comb ab_add = a_zsx + b_zsx;
	always_comb ab_sub = a_zsx - b_zsx;
	
	// flags
	always_comb flg_ne = ( a != b );
	always_comb flg_lt = ab_sub[ZSX_W-1];


	// optional flag regs
	pipe
	#(
	.DEPTH		( REGS_FLG ),
	.WIDTH		( 2 ),
	.RESET_VAL	( 0 )
	)
	regs_flags
	(
	.*,
	.data_i		( { flg_ne,   flg_lt   } ),
	.data_o		( { flg_ne_o, flg_lt_o } )
	);


	// optional mid regs
	pipe
	#(
	.DEPTH		( REGS_MID ),
	.WIDTH		( 2+ADD_SUB_W+ADD_SUB_W ),
	.RESET_VAL	( 0 )
	)
	mid_regs
	(
	.*,
	.data_i		( { sub,   ext,   ab_sub,   ab_add   } ),
	.data_o		( { sub_m, ext_m, ab_sub_m, ab_add_m } )
	);


	// multiplex
	always_comb begin
		unique case ( sub_m )
			'b1     : res_dbl <= ab_sub_m;
			default : res_dbl <= ab_add_m;
		endcase
	end

	// multiplex & extend
	always_comb begin
		unique case ( ext_m )
			'b1     : result <= res_dbl[DBL_W-1:ALU_W];
			default : result <= res_dbl[ALU_W-1:0];
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

/*
--------------------------------------------------------------------------------

Module : hive_alu_mult_shift.sv

--------------------------------------------------------------------------------

Function:
- Multiply & shift unit for a processor ALU.

Instantiates (at this level):
- (1x) hive_alu_multiply.sv
- (4x) pipe.sv

Dependencies:
- hive_pkg.sv

Notes:
- I/O optionally registered.
- 5 stage pipeline w/ 4 mid registers (not counting I/O registering).
- (pow=0 & shl=0) gives unsigned (sgn=0) and signed (sgn=1) A*B.
- (pow=0 & shl=1) gives A unsigned (sgn=0) and A signed (sgn=1) A<<B.
- (pow=1 & shl=0) gives 1<<B (sgn=x).
- (pow=1 & shl=1) and (B>=0) gives 1<<B, (B<0) gives A<<B (A sign neutral).
- Note that the A shift direction is based on the sign of B BEFORE the modulo
  operation (i.e. the MSB of b_i) rather than post modulo B.  This gives
  different modulo B results based on negative and non-negative B values.
- Note that power of 2 is NOT INFLUENCED by the sign of B.

--------------------------------------------------------------------------------
*/

module hive_alu_mult_shift
	#(
	parameter										REGS_IN			= 1,		// in register option
	parameter										REGS_OUT			= 1		// out register option
	)
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// control I/O
	input			logic								sgn_i,						// 1=signed
	input			logic								ext_i,						// 1=extended result
	input			logic								shl_i,						// 1=shift left
	input			logic								pow_i,						// 1=power of 2
	// data I/O
	input			logic	[ALU_W-1:0]				a_i,							// operand
	input			logic	[ALU_W-1:0]				b_i,							// operand
	output		logic	[ALU_W-1:0]				result_o						// result
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*;
	//
	localparam										SH_SEL_W			= $clog2( ALU_W );
	//
	logic					[ALU_W-1:0]				a, b;
	logic												ext, pow, shl, sgn;
	logic												b_neg;
	logic					[ALU_W-1:0]				b_pow;
	logic					[ZSX_W-1:0]				a_sex, b_sex;
	logic					[ZSX_W-1:0]				a_mux, b_mux;
	logic												ext_mux;
	logic												ext_mux_r;
	logic					[DBL_W-1:0]				res_dbl;
	logic					[ALU_W-1:0]				result;


	/*
	================
	== code start ==
	================
	*/


	// optional input data regs
	pipe
	#(
	.DEPTH		( REGS_IN ),
	.WIDTH		( ALU_W+ALU_W ),
	.RESET_VAL	( 0 )
	)
	in_data_regs
	(
	.*,
	.data_i		( { b_i, a_i } ),
	.data_o		( { b,   a   } )
	);

	
	// optional input control regs
	pipe
	#(
	.DEPTH		( REGS_IN ),
	.WIDTH		( 4 ),
	.RESET_VAL	( 0 )
	)
	in_ctrl_regs
	(
	.*,
	.data_i		( { ext_i, pow_i, shl_i, sgn_i } ),
	.data_o		( { ext,   pow,   shl,   sgn   } )
	);


	// some results pre-mux
	always_comb a_sex = { a[ALU_W-1], a };
	always_comb b_sex = { b[ALU_W-1], b };
	always_comb b_pow = 1'b1 << b[SH_SEL_W-1:0];
	always_comb b_neg = b[ALU_W-1];


	// mux inputs and extended result selector
	always_comb begin
		unique casex ( { pow, shl, sgn } )
			'b000 : begin  // unsigned multiply
				a_mux <= a;
				b_mux <= b;
				ext_mux <= ext;
			end
			'b001 : begin  // signed multiply
				a_mux <= a_sex;
				b_mux <= b_sex;
				ext_mux <= ext;
			end
			'b010 : begin  // unsigned shift
				a_mux <= a;
				b_mux <= b_pow;
				ext_mux <= b_neg;
			end
			'b011 : begin  // signed shift
				a_mux <= a_sex;
				b_mux <= b_pow;
				ext_mux <= b_neg;
			end
			'b10x : begin  // pow
				a_mux <= 1'b1;
				b_mux <= b_pow;
				ext_mux <= '0;
			end
			'b110 : begin  // pow (b>=0) | unsigned shift (b<0)
				a_mux <= ( b_neg ) ? a : 1'b1;
				b_mux <= b_pow;
				ext_mux <= b_neg;
			end
			'b111 : begin  // pow (b>=0) | signed shift (b<0)
				a_mux <= ( b_neg ) ? a_sex : 1'b1;
				b_mux <= b_pow;
				ext_mux <= b_neg;
			end
		endcase
	end


	// signed multiplier (4 registers deep)
	hive_alu_multiply
	#(
	.DEBUG_MODE		( 0 )
	)
	hive_alu_multiply
	(
	.*,
	.a_i				( a_mux ),
	.b_i				( b_mux ),
	.result_o		( res_dbl ),
	.debug_o			(  )  // no connect
	);


	// pipeline extended result selector to match multiply
	pipe
	#(
	.DEPTH		( 4 ),
	.WIDTH		( 1 ),
	.RESET_VAL	( 0 )
	)
	regs_ext
	(
	.*,
	.data_i		( ext_mux ),
	.data_o		( ext_mux_r )
	);


	// multiplex
	always_comb begin
		unique case ( ext_mux_r )
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

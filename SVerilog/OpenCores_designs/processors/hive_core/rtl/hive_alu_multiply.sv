/*
--------------------------------------------------------------------------------

Module : hive_alu_multiply.sv

--------------------------------------------------------------------------------

Function:
- Signed multiply unit for a processor ALU.

Instantiates:
- (1x) pipe.sv (debug mode only)

Dependencies:
- Nothing.

Notes:
- 3 stage 4 register pipeline.
- Multiply stage I/O registers are likely free (part of multiplier block).
- Debug mode for comparison to native signed multiplication, only use for 
  simulation / verification as it consumes resources and negatively impacts 
  top speed. 

--------------------------------------------------------------------------------
*/

module hive_alu_multiply
	#(
	parameter										DEBUG_MODE		= 1		// 1=debug mode; 0=normal mode
	)
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// data I/O
	input			logic	[ZSX_W-1:0]				a_i,							// operand
	input			logic	[ZSX_W-1:0]				b_i,							// operand
	output		logic	[DBL_W-1:0]				result_o,					// = ( a_i * b_i )
	// debug
	output		logic								debug_o						// 1=bad match
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*;
	//
	localparam										HS_W				= ZSX_W/2;		// 16
	localparam										LO_W				= ZSX_W-HS_W;	// 17
	localparam										LU_W				= LO_W+1;		// 18
	//
	logic	signed		[ZSX_W-1:0]				a, b;
	logic	signed		[HS_W-1:0]				a_hs, b_hs;
	logic	signed		[LU_W-1:0]				a_lu, b_lu;
	logic	signed		[HS_W*2-1:0]			mult_hs_hs;
	logic	signed		[HS_W+LU_W-1:0]		mult_hs_lu, mult_lu_hs;
	logic	signed		[LO_W*2-1:0]			mult_lu_lu;
	logic	signed		[DBL_W-1:0]				inner_sum, outer_cat;


	/*
	================
	== code start ==
	================
	*/


	// input registering (likely free)
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			a <= '0;
			b <= '0;
		end else begin
			a <= a_i;
			b <= b_i;
		end
	end
	
	// break out & zero extend inputs
	always_comb a_hs = a[ZSX_W-1:LO_W];
	always_comb b_hs = b[ZSX_W-1:LO_W];
	always_comb a_lu = { 1'b0, a[LO_W-1:0] };
	always_comb b_lu = { 1'b0, b[LO_W-1:0] };

	// do all multiplies & register (registers are likely free)
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			mult_hs_hs <= '0;
			mult_hs_lu <= '0;
			mult_lu_hs <= '0;
			mult_lu_lu <= '0;
		end else begin
			mult_hs_hs <= a_hs * b_hs;
			mult_hs_lu <= a_hs * b_lu;
			mult_lu_hs <= a_lu * b_hs;
			mult_lu_lu <= a_lu * b_lu;
		end
	end

	// add and shift inner terms, concatenate outer terms, register
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			inner_sum <= '0;
			outer_cat <= '0;
		end else begin
			inner_sum <= ( mult_hs_lu + mult_lu_hs ) << LO_W;
			outer_cat <= DBL_W'( { mult_hs_hs, mult_lu_lu } );
		end
	end

	// final add & register
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			result_o <= '0;
		end else begin
			result_o <= outer_cat + inner_sum;
		end
	end


	// optional debug mode
	generate
		if ( DEBUG_MODE ) begin
			logic signed [ZSX_W*2-1:0] debug_mult;
			logic signed [DBL_W-1:0] debug_mult_r;
			logic debug;
			always_comb debug_mult = a * b;
			// delay regs
			pipe
			#(
			.DEPTH		( 3 ),
			.WIDTH		( DBL_W ),
			.RESET_VAL	( 0 )
			)
			regs_debug
			(
			.*,
			.data_i		( DBL_W'(debug_mult) ),
			.data_o		( debug_mult_r )
			);
			// compare & register
			always_ff @ ( posedge clk_i or posedge rst_i ) begin
				if ( rst_i ) begin
					debug <= '0;
				end else begin
					debug <= ( debug_mult_r != result_o );
				end
			end
			//
			always_comb debug_o = debug;
		end else begin
			always_comb debug_o = '0;
		end
	endgenerate


endmodule

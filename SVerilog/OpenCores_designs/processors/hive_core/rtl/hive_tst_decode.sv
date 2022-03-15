/*
--------------------------------------------------------------------------------

Module : hive_tst_decode.sv

--------------------------------------------------------------------------------

Function:
- Processor test decoding for conditional jumps, etc.

Instantiates:
- (2x) pipe.sv

Dependencies:
- hive_pkg.sv

Notes:
- Parameterized register(s) @ test inputs.
- Parameterized register(s) @ output.

--------------------------------------------------------------------------------
*/

module hive_tst_decode
	#(
	parameter										REGS_TST			= 0,		// reg option input to test
	parameter										REGS_OUT			= 0		// reg option test to output
	)
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// flags (combinatorial)
	input			logic								flg_nz_i,					//	a != 0
	input			logic								flg_lz_i,					//	a < 0
	input			logic								flg_od_i,					//	a odd
	input			logic								flg_ne_i,					//	a != b
	input			logic								flg_lt_i,					//	a < b
	// tests (optionally registered)
	input			logic								cnd_i,						// 1=conditional
	input			TST_T								tst_i,						// test field
	// output (optionally registered)
	output		logic								result_o						// 1=true; 0=false
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*;
	import hive_types::*;
	//
	logic												cnd;
	TST_T												tst;
	logic												res;
	logic												result;
	


	/*
	================
	== code start ==
	================
	*/


	// input to test regs
	pipe
	#(
	.DEPTH		( REGS_TST ),
	.WIDTH		( 1+TST_W ),
	.RESET_VAL	( 0 )
	)
	tst_regs
	(
	.*,
	.data_i		( { cnd_i, tst_i } ),
	.data_o		( { cnd,   tst   } )
	);


	// mux
	always_comb begin
		unique case ( tst )
			tst_z   : res <= ~flg_nz_i;
			tst_nz  : res <=  flg_nz_i;
			tst_lz  : res <=  flg_lz_i;
			tst_nlz : res <= ~flg_lz_i;
			tst_e   : res <= ~flg_ne_i;
			tst_ne  : res <=  flg_ne_i;
			tst_ls  : res <=  flg_lt_i;
			tst_nls : res <= ~flg_lt_i;
			tst_o   : res <=  flg_od_i;
			tst_no  : res <= ~flg_od_i;
			tst_lu  : res <=  flg_lt_i;
			tst_nlu : res <= ~flg_lt_i;
			default : res <= 1'b1;  // benign default
		endcase
	end

	// output result if conditional, output 1 if not
	always_comb result = ( cnd ) ? res : 1'b1;
	

	// result to output regs
	pipe
	#(
	.DEPTH		( REGS_OUT ),
	.WIDTH		( 1 ),
	.RESET_VAL	( 0 )
	)
	out_regs
	(
	.*,
	.data_i		( result ),
	.data_o		( result_o )
	);


endmodule

/*
--------------------------------------------------------------------------------

Module : hive_level_ring.sv

--------------------------------------------------------------------------------

Function:
- Processor stack level logic & storage ring.

Instantiates:
- (2x) pipe.sv

Dependencies:
- hive_pkg.sv

Notes:
- 8 stage pipelined level ring for BRAM based LIFOs:
  0 : clear decoded & applied, pop decoded
  1 : pop applied
  2 : pop error output
  4 : push decoded
  5 : push applied, push error output
  6 : level / write output 
- Empty push is to mem addr 1, full push is to mem addr 0.
- Combo pop & push is conveniently accomodated with no net level change.
- Pop when empty is a pop error.
- Push when full is a push error.
- Pop & push when full is NOT an error.
- Pop & push when empty is a pop error ONLY.
- Parameterized level error handling.  If the associated protection is turned 
  on then pop/push errors are reported but otherwise not acted upon, i.e. 
  errors will not corrupt the level.  If the associated protection is turned 
  off then errors are still reported but the level may be corrupted.

--------------------------------------------------------------------------------
*/
module hive_level_ring
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// inputs
	input			logic								cls_i,						// stack clear
	input			logic								pop_1_i,						// stack pop
	input			logic								psh_5_i,						// stack push
	// outputs
	output		logic	[STK_LVL_W-1:0]		level_6_o,					// stack level
	output		logic								wr_6_o,						// write enable
	output		logic								pop_er_2_o,					// pop when empty, active high 
	output		logic								psh_er_5_o					// push when full, active high
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*;
	//
	logic					[STK_LVL_W-1:0]		level_0, level_1, level_2, level_5;
	logic												empty_1, dec_1;
	logic												full_5, inc_5;


	/*
	================
	== code start ==
	================
	*/



	// 0:1 mux & register
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			level_1 <= '0;
		end else begin
			level_1 <= ( cls_i ) ? '0 : level_0;  // clear
		end
	end

	// decode watermark
	always_comb empty_1 = ~|level_1;

	// prohibit pointer changes @ errors if configured to do so
	always_comb dec_1 = ( PROT_POP ) ? pop_1_i & ~empty_1 : pop_1_i;

	// 1:2 mux & register
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			pop_er_2_o <= '0;
			level_2 <= '0;
		end else begin
			pop_er_2_o <= ( pop_1_i & empty_1 );  // pop when empty
			level_2 <= ( dec_1 ) ? level_1 - 1'b1 : level_1;  // pop
		end
	end


	// 2:5 pipe
	pipe
	#(
	.DEPTH		( 3 ),
	.WIDTH		( STK_LVL_W ),
	.RESET_VAL	( 0 )
	)
	pipe_2_5
	(
	.*,
	.data_i		( level_2 ),
	.data_o		( level_5 )
	);


	// decode watermarks
	always_comb full_5 = level_5[STK_LVL_W-1];
	
	// prohibit pointer changes @ errors if configured to do so
	always_comb inc_5 = ( PROT_PSH ) ? psh_5_i & ~full_5 : psh_5_i;

	// output errors
	always_comb psh_er_5_o = ( psh_5_i & full_5 );

	// 2:3 mux & register
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			wr_6_o <= '0;
			level_6_o <= '0;
		end else begin
			wr_6_o <= inc_5;
			level_6_o <= ( inc_5 ) ? level_5 + 1'b1 : level_5;  // push
		end
	end

	// 6:0 pipe
	pipe
	#(
	.DEPTH		( 2 ),
	.WIDTH		( STK_LVL_W ),
	.RESET_VAL	( 0 )
	)
	pipe_6_0
	(
	.*,
	.data_i		( level_6_o ),
	.data_o		( level_0 )
	);

	
endmodule

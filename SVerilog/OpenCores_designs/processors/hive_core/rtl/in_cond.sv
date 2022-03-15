/*
--------------------------------------------------------------------------------

Module: in_cond.sv

Function: 
- Input conditioning.

Instantiates: 
- Nothing.

Notes:
- Optional live/dead I/O.
- Optional resync (registering) of inputs.
- Optional edge detection (none/rise/fall/change) of inputs.

--------------------------------------------------------------------------------
*/


module in_cond
	#(
	parameter										DATA_W			= 8,		// data width (bits)
	parameter										SYNC_W			= 2,		// resync registers, 1 min
	parameter	[DATA_W-1:0]					LIVE_MASK		= '1,		// 1=live bit, 0=dead (0)
	parameter	[DATA_W-1:0]					SYNC_MASK		= '0,		// 1=sync input bit, 0=no resync
	parameter	[DATA_W-1:0]					RISE_MASK		= '0,		// 1=rising edge sensitive input bit
	parameter	[DATA_W-1:0]					FALL_MASK		= '0		// 1=falling edge sensitive input bit
	)
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// I/O
	input			logic	[DATA_W-1:0]			data_i,						// data in
	output		logic	[DATA_W-1:0]			data_o						// data out
	);


	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	genvar											i;


	/*
	================
	== code start ==
	================
	*/


	// loop through bits
	generate
		for ( i=0; i<DATA_W; i=i+1 ) begin : input_processing_loop
			if ( LIVE_MASK[i] ) begin  // live bit
				logic in_0;
				if ( SYNC_MASK[i] ) begin  // resync
					logic [SYNC_W-1:0] in_sr;
					always_ff @ ( posedge clk_i or posedge rst_i ) begin
						if ( rst_i ) begin
							in_sr <= '0;
						end else begin
							in_sr <= SYNC_W'( { in_sr, data_i[i] } );
						end
					end
					always_comb in_0 = in_sr[SYNC_W-1];
				end else begin  // no resync
					always_comb in_0 = data_i[i];
				end
				// detect edges
				if ( RISE_MASK[i] | FALL_MASK[i] ) begin
					logic in_1;
					always_ff @ ( posedge clk_i or posedge rst_i ) begin
						if ( rst_i ) begin
							in_1 <= '0;
						end else begin
							in_1 <= in_0;
						end
					end
					case ( { FALL_MASK[i], RISE_MASK[i] } )
						2'b01 : begin  // rising edge detect
							always_comb data_o[i] = ( ~in_1 & in_0 );
						end
						2'b10 : begin  // falling edge detect
							always_comb data_o[i] = ( in_1 & ~in_0 );
						end
						default : begin  // both edges detect
							always_comb data_o[i] = ( in_1 ^ in_0 );
						end
					endcase
				end else begin  // no edge detect
					always_comb data_o[i] = in_0;
				end
			end else begin  // dead bit
				always_comb data_o[i] = '0;
			end  // endif
		end  // endfor
	endgenerate


endmodule

/*
--------------------------------------------------------------------------------

Module: rst_bridge.sv

Function: 
- A reset bridge providing async assert / sync de-assert of reset.

Instantiates: 
- Nothing.

Notes:
- Active high I/O : 1=assert, 0=de-assert.
- Parameterized resync shift register stages.
    
--------------------------------------------------------------------------------
*/

module rst_bridge
	#(
	parameter										SYNC_W			= 2	// resync FF stages (1 min)
	)
	(
	input		logic									clk_i,					// clock
	input		logic									rst_i,					// async reset, active hi
	output	logic									rst_o						// sync reset, active hi
	);


	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	logic					[SYNC_W-1:0]			rst_sr;


	/*
	================
	== code start ==
	================
	*/


	// shift register with async rise, sync fall
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			rst_sr <= '1;
		end else begin
			rst_sr <= SYNC_W'( { rst_sr, 1'b0 } );
		end
	end

	// output MSB
	always_comb rst_o = rst_sr[SYNC_W-1];


endmodule

/*
--------------------------------------------------------------------------------

Module: ramp_tri_sq.sv

Function: 
- Generates ramp, triangle, and square waveforms via phase accumulation.

Instantiates: 
- Nothing.

Notes:
- clk_o = clk_i * freq_i / 2^RAMP_W.
- Sync requires active enable.
- Ramp and triangle outputs are optionally signed or unsigned.
- Hint: set freq_i LSB permanently to a '1' to reduce spectral spurs.
    
--------------------------------------------------------------------------------
*/

module ramp_tri_sq
	#(
	parameter										FREQ_W			= 4,	// freq_i width
	parameter										RAMP_W			= 8,	// ramp_o width
	parameter										SGN_O				= 1	// 1=signed outputs, 0=unsigned
	)
	(
	// clocks & resets
	input		logic									clk_i,					// clock
	input		logic									rst_i,					// async reset, active hi
	// I/O
	input		logic									en_i,						// accumulate enable, active hi
	input		logic									sync_i,					// restart if enabled, active hi
	input		logic		[FREQ_W-1:0]			freq_i,					// frequency (mult) input
	output	logic		[RAMP_W-1:0]			ramp_o,					// ramp output
	output	logic		[RAMP_W-2:0]			tri_o,					// triangle output
	output	logic									sq_o						// square output
	);


	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	logic					[RAMP_W-1:0]			ramp_u;
	logic					[RAMP_W-2:0]			tri_u;  // note: one bit less


	/*
	================
	== code start ==
	================
	*/


	// unsigned accumulate / enable / sync
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			ramp_u <= '0;
		end else begin
			if ( en_i ) begin
				if ( sync_i ) begin
					ramp_u <= '0;
				end else begin
					ramp_u <= ramp_u + freq_i;
				end
			end
		end
	end

	// output ramp (flip MSB for signed)
	always_comb ramp_o = ( SGN_O ) ? { ~ramp_u[RAMP_W-1], ramp_u[RAMP_W-2:0] } : ramp_u;

	// unsigned triangle (flip LSBs if MSB=1)
	always_comb tri_u = ( ramp_u[RAMP_W-1] ) ? ~ramp_u[RAMP_W-2:0] : ramp_u[RAMP_W-2:0];
	
	// output triangle (flip MSB for signed)
	always_comb tri_o = ( SGN_O ) ? { ~tri_u[RAMP_W-2], tri_u[RAMP_W-3:0] } : tri_u;

	// output square (unsigned ramp MSB)
	always_comb sq_o = ramp_u[RAMP_W-1];


endmodule

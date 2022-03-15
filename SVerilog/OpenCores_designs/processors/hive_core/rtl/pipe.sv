/*
--------------------------------------------------------------------------------

Module: pipe.sv

Function: 
- Vector I/O shift register.

Instantiates: 
- Nothing.

Notes:
- Parameters for depth (register stages), data width, and async reset value.
- DEPTH=0 generates a wire.

--------------------------------------------------------------------------------
*/


module pipe
	#(
	parameter								DEPTH					= 4,			// register stages
	parameter								WIDTH					= 2,			// I/O data width
	parameter		[WIDTH-1:0]			RESET_VAL			= 0			// regs async reset value
	)
	(
	// clocks & resets
	input		logic							clk_i,								// clock
	input		logic							rst_i,								// async. reset, active high
	// I/O
	input		logic	[WIDTH-1:0]			data_i,								// data in
	output	logic	[WIDTH-1:0]			data_o								// data out
	);


	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	genvar									g;


	/*
	================
	== code start ==
	================
	*/


	// generate regs pipeline
	generate
		if ( DEPTH == 0 ) begin
			always_comb data_o = data_i;
		end else begin
			logic [WIDTH-1:0] stage[0:DEPTH-1];
			for ( g=DEPTH-1; g>=0; g=g-1 ) begin : loop
				always_ff @ ( posedge clk_i or posedge rst_i ) begin
					if ( rst_i ) begin
						stage[g] <= RESET_VAL;
					end else begin
						stage[g] <= ( g ) ? stage[g-1] : data_i;
					end
				end
			end  // endfor : loop
			always_comb data_o = stage[DEPTH-1];
		end
	endgenerate


endmodule

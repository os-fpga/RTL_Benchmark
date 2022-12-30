/*
Bit-reversal permutation module
Delay 1 clock
*/

`ifndef _bitrev_
`define _bitrev_

module bitrev #(
	parameter WIDTH = 14, // max data width
	parameter BIT_WIDTH = (2**$clog2(WIDTH) > WIDTH - 1) ? $clog2(WIDTH) : $clog2(WIDTH) + 1
)(
	input clk,
	input [BIT_WIDTH-1:0] width, // current data width
	input [WIDTH-1:0] x, // input data
	output [WIDTH-1:0] y // result
);

	wire [WIDTH-1:0] yy;

	genvar i;
	generate for (i = 0; i < WIDTH; i++)
		begin :gen
			assign yy[WIDTH-1-i] = x[i];
		end
	endgenerate
	
	always_ff @(posedge clk)
		y <= yy >> (WIDTH - width);
	
endmodule :bitrev

`endif

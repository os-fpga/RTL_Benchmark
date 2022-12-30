`ifndef _bitrev_
`define _bitrev_

module bitrev #(parameter WIDTH)(input [WIDTH-1:0] x, output [WIDTH-1:0] y);
	genvar i;
	generate for (i = 0; i < WIDTH; i++)
		begin :gen
			assign y[WIDTH-1-i] = x[i];
		end
	endgenerate
endmodule :bitrev

`endif

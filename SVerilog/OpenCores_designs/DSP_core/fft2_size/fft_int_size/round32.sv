`ifndef _round32_
`define _round32_

// Round cut value
module round32 #(parameter WIDTH)(input signed [31:0] x, output signed [WIDTH-1:0] y);
	generate
		if (WIDTH == 32)
			begin				
				assign y = x;
			end
		else
			begin				
				 // overflow check don't need
				assign y = (x < 'sh0) ? x[31-:WIDTH] - x[31-WIDTH] : x[31-:WIDTH] + x[31-WIDTH];
			end
	endgenerate
endmodule :round32

`endif

`ifndef _bitrev_cnt_
`define _bitrev_cnt_

module bitrev_cnt #(
	parameter WIDTH = 7,
	parameter WIDTH_WIDTH = (2**$clog2(WIDTH) > WIDTH - 1) ? $clog2(WIDTH) : $clog2(WIDTH) + 1
)(
	input clk, aclr,
	input clk_ena, sclr,
	input [WIDTH_WIDTH-1:0] width,
	input [WIDTH-1:0] cnt_max,
	output reg [WIDTH-1:0] cnt, cnt_rev
);	
	wire [WIDTH-1:0] _cnt_rev;
	
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			cnt <= '0;
		else if (clk_ena)
			if (sclr || cnt == cnt_max)
				cnt <= '0;
			else
				cnt <= cnt + 1'b1;
	
	bitrev #(.WIDTH(WIDTH)) bitrev_inst(.x(cnt + 1'b1), .y(_cnt_rev));
	
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			cnt_rev <= '0;
		else if (clk_ena)
			if (sclr || cnt == cnt_max)
				cnt_rev <= '0;
			else
				cnt_rev <= _cnt_rev >> (WIDTH - width);
	
endmodule :bitrev_cnt

// Fix width bit reversial. It dont need any logic
module bitrev #(parameter WIDTH)(input [WIDTH-1:0] x, output [WIDTH-1:0] y);
	genvar i;
	generate for (i = 0; i < WIDTH; i++)
		begin :gen
			assign y[WIDTH-1-i] = x[i];
		end
	endgenerate
endmodule :bitrev

`endif

// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module atcexmon300_pending_cnt (
	  clk,
	  reset_n,
	  increase,
	  decrease,
	  full,
	  zero
);

parameter WIDTH = 4;

input                            clk;
input                            reset_n;
input                            increase;
input                            decrease;
output                           zero;
output                           full;

wire				 s0;
reg		     [WIDTH-1:0] s1;

assign zero = ~(|s1);
assign s0 = (increase & decrease);
assign full = (&s1);

always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
		s1 <= {WIDTH{1'b0}};
	else if (s0)
		s1 <= s1;
	else if (increase)
		s1 <= s1 + {{(WIDTH-1){1'b0}},{1'b1}};
	else if (decrease)
		s1 <= s1 - {{(WIDTH-1){1'b0}},{1'b1}};
end

endmodule


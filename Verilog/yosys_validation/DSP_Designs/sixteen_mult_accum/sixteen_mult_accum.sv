// sixteen_mult_accum 

module sixteen_mult_accum (clk, areset, a0, b0, a1, b1, a2, b2, a3, b3, w);
	parameter WIDTH = 18; 
	input clk;
	input areset;
	input signed [WIDTH-1:0] a0;
	input signed [WIDTH-1:0] b0;
	input signed [WIDTH-1:0] a1;
	input signed [WIDTH-1:0] b1;
	input signed [WIDTH-1:0] a2;
	input signed [WIDTH-1:0] b2;
	input signed [WIDTH-1:0] a3;
	input signed [WIDTH-1:0] b3;
	output signed [2*WIDTH+2:0] w;

	reg signed [WIDTH-1:0] a0_reg;
	reg signed [WIDTH-1:0] b0_reg;
	reg signed [WIDTH-1:0] a1_reg;
	reg signed [WIDTH-1:0] b1_reg;
	reg signed [WIDTH-1:0] a2_reg;
	reg signed [WIDTH-1:0] b2_reg;
	reg signed [WIDTH-1:0] a3_reg;
	reg signed [WIDTH-1:0] b3_reg;

	reg signed [2*WIDTH:0] p0;
	reg signed [2*WIDTH:0] p1;
	reg signed [2*WIDTH:0] p2;
	reg signed [2*WIDTH:0] p3;
	reg signed [2*WIDTH:0] p4;
	reg signed [2*WIDTH:0] p5;
	reg signed [2*WIDTH:0] p6;
	reg signed [2*WIDTH:0] p7;

	reg signed [2*WIDTH+2:0] w;	
	
	always @ (posedge clk or posedge areset) begin
		if(areset) begin
			a0_reg <= 0;
			b0_reg <= 0;
			a1_reg <= 0;
			b1_reg <= 0;
			a2_reg <= 0;
			b2_reg <= 0;
			a3_reg <= 0;
			b3_reg <= 0;
			p0 	   <= 0;
			p1     <= 0;
			p2 	   <= 0;
			p3     <= 0;
			p4 	   <= 0;
			p5     <= 0;
			p6 	   <= 0;
			p7     <= 0;
			w      <= 0;
		end
		else begin
		    a0_reg <= a0;	 
		    b0_reg <= b0;
		    a1_reg <= a1;
		    b1_reg <= b1;
		    a2_reg <= a2;
		    b2_reg <= b2;
		    a3_reg <= a3;
		    b3_reg <= b3;
			p0     <= a0_reg * b0_reg + a1_reg * b1_reg;
			p1     <= a2_reg * b2_reg + a3_reg * b3_reg;
			p2     <= a0_reg * b1_reg + a1_reg * b0_reg;
			p3     <= a0_reg * b2_reg + a1_reg * b2_reg;
			p4     <= a0_reg * b3_reg + a1_reg * b3_reg;
			p5     <= a2_reg * b0_reg + a3_reg * b0_reg;
			p6     <= a2_reg * b1_reg + a3_reg * b1_reg;
			p7     <= a2_reg * b3_reg + a3_reg * b2_reg;
			w	   <= w + (p0 + p1 + p2 + p3 + p4 + p5 + p6 +p7);	 
		end
	end

endmodule
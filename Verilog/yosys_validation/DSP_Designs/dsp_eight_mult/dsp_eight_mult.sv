
module dsp_eight_mult (clk, areset, a0, b0, a1, b1, a2, b2, a3, b3, 
			      a4, b4, a5, b5, a6, b6, a7, b7, result);
	parameter WIDTH = 9; 
	input clk;
	input areset;
	input signed [WIDTH-1:0] a0, a1, a2, a3;
	input signed [WIDTH-1:0] b0, b1, b2, b3;
	input signed [WIDTH-1:0] a4, a5, a6, a7;
	input signed [WIDTH-1:0] b4, b5, b6, b7;
	output signed [2*WIDTH+2:0] result;

	wire signed [2*WIDTH+1:0] w0;	
	wire signed [2*WIDTH+1:0] w1;	
	reg signed [2*WIDTH+2:0] result;

	four_mult d1
	(
		.clk(clk),
		.areset(areset),
		.a0(a0),
		.b0(b0),
		.a1(a1),
		.b1(b1),
		.a2(a2),
		.b2(b2),
		.a3(a3),
		.b3(b3),
		.w(w0)
	);
	four_mult d2
	(
		.clk(clk),
		.areset(areset),
		.a0(a4),
		.b0(b4),
		.a1(a5),
		.b1(b5),
		.a2(a6),
		.b2(b6),
		.a3(a7),
		.b3(b7),
		.w(w1)
	);
	always @ (posedge clk or posedge areset) begin
		if(areset) begin
			result <= 0;
		end
        else begin
			result   <= w0 + w1;
		end
	end

endmodule

module four_mult (clk, areset, a0, b0, a1, b1, a2, b2, a3, b3, w);
	parameter WIDTH = 9; 
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
	output signed [2*WIDTH+1:0] w;

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

	reg signed [2*WIDTH+1:0] w;	

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
			w 	   <= p0 + p1;
		end
	end

endmodule
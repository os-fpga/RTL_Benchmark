module multiplier (clk, reset, subtract_i, A, B, reg_in, P);
	input clk, reset, subtract_i;
	input signed [19:0] A;
	input signed [17:0] B;
    input reg_in;
	output reg signed [37:0] P;
	reg signed [19:0] i1;
	reg signed [17:0] i2;
	reg signed [37:0] mul, add_or_sub;
	always @(posedge clk) begin
		if(reset == 1) begin
			P  <= 0;
		end
		else begin
			P  <= add_or_sub;
		end
	end
    LATCHNR latch_a (.D(A), .G(reg_in), .Q(i1), .R(reset));
    LATCHNR latch_b (.D(B), .G(reg_in), .Q(i2), .R(reset));

	always @ (*)  begin
		mul  = i1 * i2;
		if (subtract_i)
			add_or_sub =  P + mul;
		else
			add_or_sub =  P - mul;
	end
endmodule
module dsp_mul_signed_accum_add_only (clk, reset, A, B, P);
	input clk, reset;
	input signed [19:0] A;
	input signed [17:0] B;
	output reg signed [37:0] P;
	reg signed [37:0] mul, adder;

	always @(posedge clk) begin
		if (reset ==1 )
			P <= 0;
		else 
			P <= adder;

	end

	always @ (*)  begin
		mul  = A * B;
	end

	always @ (*)  begin
			adder = P + mul;
	end
endmodule

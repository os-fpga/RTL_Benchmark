module dsp_mul_signed_reg_with_accum (clk, reset, subtract_i, A, B, P);
	input clk, reset, subtract_i;
	input signed [19:0] A;
	input signed [17:0] B;
	output reg signed [37:0] P;
	reg signed [37:0] mul, add_or_sub;
	always @(posedge clk) begin
		if(reset == 1) begin
			P  <= 0;
		end
		else begin
			P  <= add_or_sub;
		end
	end

	always @ (*)  begin
		mul  = A * B;
		if (!subtract_i)
			add_or_sub =   mul;
		else
			add_or_sub =  P + mul;
	end
endmodule
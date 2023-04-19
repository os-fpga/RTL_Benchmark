module dsp_mul_signed_in_not_reg_out_is_reg (clk, reset, A, B, P);
	input clk, reset;
	input signed [19:0] A;
	input signed [17:0] B;
	output reg signed [37:0] P;
	reg signed [37:0] mul;
	
	always @(posedge clk) begin
		if (reset ==1 )
			P <= 0;
		else
			P <= mul;
	end

	always @ (*)  begin
		mul  = A * B;
	end
endmodule
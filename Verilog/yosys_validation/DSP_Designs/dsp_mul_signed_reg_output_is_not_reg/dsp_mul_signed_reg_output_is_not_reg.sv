module dsp_mul_signed_reg_output_is_not_reg (clk, reset, A, B, P);
	input clk, reset;
	input signed [19:0] A;
	input signed [17:0] B;
	output signed [37:0] P;
	reg signed [19:0] i1;
	reg signed [17:0] i2;
	always @(posedge clk) begin
		if(reset == 1) begin
			i1 <= 0;
			i2 <= 0;
		end
		else begin
			i1 <= A;
			i2 <= B;
		end
	end
	assign P = i1 * i2;
endmodule
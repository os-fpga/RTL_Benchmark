module dsp_add_shifted_input_to_the_mul_coeff0_output (clk, reset, subtract_i, A, B, acc_fir, P);
	input clk, reset, subtract_i;
	input signed [19:0] A;
	input signed [17:0] B;
	input [3:0] acc_fir;
	output reg signed [37:0] P;
	reg signed [37:0] mul, add_or_sub;
	wire [37:0] shift_out;
	
	parameter [19:0] coeff0 = 20'hfaaa1;

	always @(posedge clk) begin
		if (reset ==1 )
			P <= 0;
		else
			P <= add_or_sub;
	end

	always @ (*)  begin
		mul  = coeff0 * B;
	end
	assign shift_out = A << acc_fir;
	always @ (*)  begin
		if (subtract_i)
			add_or_sub = shift_out - mul;
		else
			add_or_sub = shift_out + mul;
	end
endmodule
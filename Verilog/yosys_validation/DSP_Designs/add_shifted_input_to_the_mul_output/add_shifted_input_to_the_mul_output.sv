module add_shifted_input_to_the_mul_output (clk, reset, subtract_i, A, B, acc_fir, P);
	input clk, reset, subtract_i;
	input signed [19:0] A;
	input signed [17:0] B;
	input [3:0] acc_fir;
	output reg signed [37:0] P;
	reg signed [19:0] i1;
	reg signed [17:0] i2;
	reg [3:0] acc_fir_reg;
	reg signed [37:0] mul, add_or_sub;
	wire signed [37:0] shift_out;
	always @(posedge clk) begin
		if(reset == 1) begin
			i1 <= 0;
			i2 <= 0;
			acc_fir_reg <= 0;
		end
		else begin
			i1 <= A;
			i2 <= B;
			acc_fir_reg <= acc_fir;
		end
	end
	always @(posedge clk) begin
		if (reset ==1 )
			P <= 0;
		else
			P <= add_or_sub;
	end

	always @ (*)  begin
		mul  = i1 * i2;
	end
	assign shift_out = A << acc_fir_reg;
	always @ (*)  begin
		if (subtract_i)
			add_or_sub = shift_out - mul;
		else
			add_or_sub = shift_out + mul;
	end
endmodule
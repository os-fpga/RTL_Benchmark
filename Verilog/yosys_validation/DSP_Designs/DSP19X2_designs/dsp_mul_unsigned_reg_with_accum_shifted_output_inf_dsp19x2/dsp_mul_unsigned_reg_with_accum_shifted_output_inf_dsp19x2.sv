module dsp_mul_unsigned_reg_with_accum_shifted_output_inf_dsp19x2 (clk, reset, subtract, A, A1, B, B1, shift_right, P);
	input clk, reset, subtract;
	input [9:0] A, A1;
	input [8:0] B, B1;
	input [5:0] shift_right;
	output reg [37:0] P;
	reg [5:0] shift_right_reg;
	reg [18:0] P1, P2;
	reg [9:0] i1, i3;
	reg [8:0] i2, i4;
	reg [18:0] add_or_sub, add_or_sub1, mul1, mul2;
	always @(posedge clk) begin
		if(reset == 1) begin
			i1 <= 0;
			i2 <= 0;
			i3 <= 0;
			i4 <= 0;
			shift_right_reg <= 0;
		end
		else begin
			i1 <= A;
			i2 <= B;
			i3 <= A1;
			i4 <= B1;
			shift_right_reg <= shift_right;
		end
	end
	always @(posedge clk) begin
		if (reset ==1) begin
			P <= 0;
			P1 <= 0;
			P2 <= 0;
		end
		else begin
			P1 <= add_or_sub >> shift_right_reg;
			P2 <= add_or_sub1 >> shift_right_reg;
			P <= {P1, P2};
		end

	end

	always @ (*)  begin
		mul1 = i1 * i2;
		mul2 = i3 * i4;
	end

	always @ (*)  begin
		if (subtract) begin
			add_or_sub = P1 - mul1;
			add_or_sub1 = P2 - mul2;
		end
		else begin
			add_or_sub = P1 + mul1;
			add_or_sub1 = P2 + mul2;
		end
	end
endmodule
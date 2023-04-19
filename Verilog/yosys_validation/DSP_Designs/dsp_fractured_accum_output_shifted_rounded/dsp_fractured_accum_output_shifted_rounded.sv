module dsp_fractured_accum_output_shifted_rounded (clk, reset, subtract_i, load_acc_i, shift_right_i, round_i, A, A_fmode, B, B_fmode, P);

	input clk, reset, subtract_i, load_acc_i;
	input [5:0] shift_right_i;
	input round_i;
	input signed [9:0] A , A_fmode;
	input signed [8:0] B , B_fmode;
	output reg signed [63:0] P;
	reg signed [31:0] P_f1, P_f2;
	reg signed [31:0] out_f1, out_f2, out_shift_f1, out_shift_f2;
	reg signed [9:0] i1, i1_fmode;
	reg signed [8:0] i2, i2_fmode;
	reg subtract_i_reg;
	reg [5:0] shift_right_i_reg;
	reg round_i_reg;
	reg signed [31:0] mul_f1, mul_f2, add_or_sub_f1, add_or_sub_f2;
	always @(posedge clk) begin
		if(reset == 1) begin
			i1 <= 0;
			i2 <= 0;
			subtract_i_reg <= 0;
			shift_right_i_reg <= 0;
			round_i_reg <= 0;
		end
		else begin
			i1 <= A;
			i2 <= B;
			i1_fmode <= A;
			i2_fmode <= B;
			subtract_i_reg <= subtract_i;
			shift_right_i_reg <= shift_right_i;
			round_i_reg <= round_i;
		end
	end
	always @(posedge clk) begin
		if (reset ==1 ) begin
			P <= 0;
			P_f1 <= 0;
			P_f2 <= 0;
		end
		else if (load_acc_i) begin
			P_f1 <= out_f1;
			P_f2 <= out_f2;
			P <= {P_f1, P_f2};
		end
		else begin
			P <= P;
		end
	end

	always @ (*)  begin
		mul_f1  = i1 * i2;
		mul_f2  = i1_fmode * i2_fmode;
	end

	always @ (posedge clk)  begin
		if (reset) begin
			add_or_sub_f1 <= 0;
			add_or_sub_f2 <= 0;
		end
		else if (load_acc_i) begin
			if (subtract_i_reg) begin
				add_or_sub_f1 <= P_f1 - mul_f1;
				add_or_sub_f2 <= P_f2 - mul_f2;
			end
			else begin
				add_or_sub_f1 <= P_f1 + mul_f1;
				add_or_sub_f2 <= P_f2 + mul_f2;
			end
		end
		else begin
			add_or_sub_f1 <= add_or_sub_f1;
			add_or_sub_f2 <= add_or_sub_f2;
		end
	end

	always @ (*)  begin
		out_shift_f1 = add_or_sub_f1 >>> shift_right_i_reg;
		out_shift_f2 = add_or_sub_f2 >>> shift_right_i_reg;
		if (shift_right_i_reg != 0) begin
			if (round_i_reg == 1 && add_or_sub_f1[shift_right_i_reg -1]==1) begin
				out_f1 = out_shift_f1 + 1'b1;
			end
			else begin
				out_f1 = out_shift_f1;
			end

			if (round_i_reg == 1 && add_or_sub_f2[shift_right_i_reg -1]==1) begin
				out_f2 = out_shift_f2 + 1'b1;
			end
			else begin
				out_f2 = out_shift_f2;
			end
			
		end
		else begin
			out_f1 = out_shift_f1;
			out_f2 = out_shift_f2;
		end

	end

endmodule
module input_to_adder_and_mul_A_input_wrt_feedback_i (clk, reset, subtract_i,feedback_i, coef_0_i, coef_1_i, coef_2_i, coef_3_i, acc_fir, A, B, P);
	input clk, reset, subtract_i;
	input [2:0] feedback_i;
	input signed [19:0] A, coef_0_i, coef_1_i, coef_2_i, coef_3_i;
	input [3:0] acc_fir;
	input signed [17:0] B;
	output signed [37:0] P;
	reg signed [19:0] i1;
	reg signed [17:0] i2;
	reg [3:0] acc_fir_reg;
	reg subtract_i_reg;
	reg [2:0] feedback_i_reg;
	reg signed [37:0] mul, add_or_sub;
	wire signed [19:0] shift_out;
	always @(posedge clk) begin
		if(reset == 1) begin
			i1 <= 0;
			i2 <= 0;
			subtract_i_reg <= 0;
			feedback_i_reg <= 0;
			acc_fir_reg <= 0;
		end
		else begin
			i1 <= A;
			i2 <= B;
			subtract_i_reg <= subtract_i;
			feedback_i_reg <= feedback_i;
			acc_fir_reg <= acc_fir;
		end
	end

	assign P = add_or_sub;

	always @ (*)  begin
		case (feedback_i_reg)
			3'd0, 3'd1, 3'd2: 
				mul  = i1 * i2;
			3'd3:
				mul  = add_or_sub * i2;
			3'd4:
				mul  = coef_0_i * i2;
			3'd5:
				mul  = coef_1_i * i2;
			3'd6:
				mul  = coef_2_i * i2;
			3'd7:
				mul  = coef_3_i * i2;
			default:
				mul  = i1 * i2;
		endcase
	end
	
assign shift_out = i1 << acc_fir_reg;

	always @(posedge clk)  begin
		if(reset == 1) begin
			add_or_sub <= 0;
		end
		else if (subtract_i_reg) begin
			case (feedback_i_reg)
				3'd0: 
					add_or_sub <= P - mul;
				3'd1 :
					add_or_sub <= 1'b0 - mul;
				3'd2, 3'd3, 3'd4, 3'd5, 3'd6, 3'd7:
					add_or_sub <= shift_out - mul;
				default: 
					add_or_sub <= shift_out - mul;
			endcase
		end
		else begin
			case (feedback_i_reg)
				3'd0: 
					add_or_sub <= P + mul;
				3'd1 :
					add_or_sub <= 1'b0 + mul;
				3'd2, 3'd3, 3'd4, 3'd5, 3'd6, 3'd7:
					add_or_sub <= shift_out + mul;
				default: 
					add_or_sub <= shift_out + mul;
			endcase
		end
	end

endmodule
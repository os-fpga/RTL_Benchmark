module dsp_z_o_wrt_out_select_i (clk, reset, subtract_i, Reg_input_i, A, B, z_o, out_select_i);
	input clk, reset, subtract_i, Reg_input_i;
	input signed [19:0] A;
	input signed [17:0] B;
	input [2:0] out_select_i;
	output reg signed [37:0] z_o;
	reg signed [37:0] P;
	reg signed [19:0] i1;
	reg signed [17:0] i2;
	reg subtract_i_reg;
	reg signed [37:0] mul, add_or_sub, accum;
	always @(posedge clk) begin
		if(reset == 1) begin
			i1 <= 0;
			i2 <= 0;
			subtract_i_reg <= 0;
		end
		else begin
			i1 <= A;
			i2 <= B;
			subtract_i_reg <= subtract_i;
		end
	end
	always @(posedge clk) begin
		if (reset ==1 )
			P <= 0;
		else
			P <= add_or_sub;
	end

	always @ (*)  begin
		if (Reg_input_i)
			mul  = i1 * i2;
		else
			mul  = A * B;
	end
	//assign shift_out = Reg_input_i ? (A << acc_fir_reg) : (A << acc_fir);

	always @ (posedge clk)  begin
		if (reset)
			accum <= 0;
		else begin
			accum <= add_or_sub;
		end		
	end

	always @ (*)  begin
		if (subtract_i_reg ==1)
			add_or_sub = accum - mul;
		else
			add_or_sub = accum + mul;
	end

	always @ (*) begin
		case (out_select_i)
			3'd0, 3'd4:
				z_o = mul;
			3'd1, 3'd5:
				z_o = accum;
			3'd2, 3'd3:
				z_o = add_or_sub;
			3'd6, 3'd7:
				z_o = P;
			default: 
				z_o = P;
		endcase
	end
endmodule
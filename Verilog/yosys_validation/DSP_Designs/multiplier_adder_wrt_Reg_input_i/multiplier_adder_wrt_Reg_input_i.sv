module multiplier_adder_wrt_Reg_input_i (clk, reset, subtract_i, Reg_input_i, A, B, acc_fir, P);
	input clk, reset, subtract_i, Reg_input_i;
	input signed [19:0] A;
	input signed [17:0] B;
	input [3:0] acc_fir;
	output reg signed [37:0] P;
	reg signed [19:0] i1;
	reg signed [17:0] i2;
	reg [3:0] acc_fir_reg;
	reg subtract_i_reg;
	reg signed [37:0] mul, add_or_sub;
	wire signed [19:0] shift_out;
	always @(posedge clk) begin
		if(reset == 1) begin
			i1 <= 0;
			i2 <= 0;
			acc_fir_reg <= 0;
			subtract_i_reg <= 0;
		end
		else begin
			i1 <= A;
			i2 <= B;
			acc_fir_reg <= acc_fir;
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
	assign shift_out = Reg_input_i ? (A << acc_fir_reg) : (A << acc_fir);
	always @ (*)  begin
		if (Reg_input_i ==1 && subtract_i_reg ==1)
				add_or_sub = shift_out - mul;
		else if (Reg_input_i ==1 && subtract_i_reg ==0)
				add_or_sub = shift_out + mul;
		else if (Reg_input_i ==0 && subtract_i ==1)
			add_or_sub = shift_out - mul;
		else
			add_or_sub = shift_out + mul;
		//if (Reg_input_i) begin
		//	if (subtract_i_reg)
		//	add_or_sub = shift_out - mul;
		//	else
		//	add_or_sub = shift_out + mul;
		//end
		//else begin
		//	if (subtract_i)
		//	add_or_sub = shift_out - mul;
		//	else
		//	add_or_sub = shift_out + mul;
		//end

	end
endmodule
module dsp_mul_signed_reg_with_accum_output_is_not_reg (clk, reset, subtract_i, A, B, P);
	input clk, reset, subtract_i;
	input signed [19:0] A;
	input signed [17:0] B;
	output signed [37:0] P;
	reg signed [19:0] i1;
	reg signed [17:0] i2;
	reg signed [37:0] mul, add_or_sub;
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

	always @ (*)  begin
		mul  = i1 * i2;
	end
	
	always @(posedge clk)  begin
		if(reset == 1) begin
			add_or_sub <= 0;
		end
		else if (subtract_i)
			add_or_sub <= P - mul;
		else
			add_or_sub <= P + mul;
	end

	assign P = add_or_sub;
	
endmodule 
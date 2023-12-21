module dsp_mul_signed_reg_with_accum_inf_dsp19x2 (clk, reset, subtract, A, A1, B, B1, P);
	input clk, reset, subtract;
	input signed [9:0] A, A1;
	input signed [8:0] B, B1;
	output reg signed [37:0] P;
	reg signed [9:0] i1, i3;
	reg signed [8:0] i2, i4;
	reg signed [18:0] add_or_sub, add_or_sub1, mul1, mul2;
	always @(posedge clk) begin
		if(reset == 1) begin
			i1 <= 0;
			i2 <= 0;
			i3 <= 0;
			i4 <= 0;
		end
		else begin
			i1 <= A;
			i2 <= B;
			i3 <= A1;
			i4 <= B1;
		end
	end
	always @(posedge clk) begin
		if (reset ==1 )
			P <= 0;
		else 
			P <= {add_or_sub, add_or_sub1};

	end

	always @ (*)  begin
		mul1 = i1 * i2;
		mul2 = i3 * i4;
	end

	always @ (*)  begin
		if (subtract) begin
			add_or_sub = P - mul1;
			add_or_sub1 = P - mul2;
		end
		else begin
			add_or_sub = P + mul1;
			add_or_sub1 = P + mul2;
		end
	end
endmodule
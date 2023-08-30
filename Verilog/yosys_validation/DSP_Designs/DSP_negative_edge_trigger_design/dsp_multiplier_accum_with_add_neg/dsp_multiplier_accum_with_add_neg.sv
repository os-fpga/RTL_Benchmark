module dsp_multiplier_accum_with_add_neg (clk, reset, sel_c_or_p, A, B, C, D, P);
	input clk, reset, sel_c_or_p;
	input signed [31:0] A, B, C, D;
	output reg signed [63:0] P;
	reg signed [31:0] i1, i2, i3, i4;
	reg signed [63:0] mul, add, add2;
	always @(negedge clk) begin
		if(reset == 1) begin
			i1 <= 0;
			i2 <= 0;
			i3 <= 0;
			i4 <= 0;
		end
		else begin
			i1 <= A;
			i2 <= B;
			i3 <= C;
			i4 <= D;
		end
	end
	always @(negedge clk) begin
		if (reset ==1 )
			P <= 0;
		else
			P<= add2;
	end

	always @ (*)  begin
		add = i1 + i4;
		mul  = add * i2;
	end
	always @ (*)  begin
		if (sel_c_or_p)
			add2 = mul + i3;
		else
			add2 = mul + P;
	end
endmodule
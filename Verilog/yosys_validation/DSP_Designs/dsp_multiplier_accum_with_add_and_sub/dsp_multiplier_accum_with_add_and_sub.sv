module dsp_multiplier_accum_with_add_and_sub (clk, reset, sel_c_or_p, INMODE, ALUMODE, A, B, C, D, P);
	input clk, reset, sel_c_or_p;
	input INMODE;
	input ALUMODE;
	input signed [29:0] A;
	input signed [17:0] B;
	input signed [47:0] C;
	input signed [26:0] D;
	output reg signed [47:0] P;
	reg signed [29:0] i1;
	reg signed [17:0] i2;
	reg signed [47:0] i3;
	reg signed [26:0] i4;
	reg signed [47:0] mul, add_or_sub, add_or_sub2;
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
			i3 <= C;
			i4 <= D;
		end
	end
	always @(posedge clk) begin
		if (reset ==1 )
			P <= 0;
		else
			P<= add_or_sub2;
		
	end

	always @ (*)  begin
		if (INMODE) begin
			add_or_sub = i1 + i4;
			mul  = add_or_sub * i2;
		end
		else begin
			add_or_sub = i1 - i4;
			mul  = add_or_sub * i2;
		end
	end
	always @ (*)  begin
		if (sel_c_or_p) begin
			if (ALUMODE)
				add_or_sub2 = mul + i3;
			else
				add_or_sub2 = mul - i3;
		end
		else begin
			if (ALUMODE)
				add_or_sub2 = P + mul;
			else
				add_or_sub2 = P - mul;
		end
	end
endmodule
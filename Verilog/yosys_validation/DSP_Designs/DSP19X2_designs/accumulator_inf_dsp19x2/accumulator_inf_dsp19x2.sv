module accumulator_inf_dsp19x2 (clk, reset, subtract, A, P);
	input clk, reset, subtract;
	input signed [9:0] A;
	output reg signed [37:0] P;
	reg signed [9:0] i1;
	reg signed [31:0] mul, add_or_sub;
	always @(posedge clk) begin
		if(reset == 1) begin
			i1 <= 0;
		end
		else begin
			i1 <= A;
		end
	end
	always @(posedge clk) begin
		if (reset ==1 )
			P <= 0;
		else 
			P<= add_or_sub;

	end

	always @ (*)  begin
		if (subtract)
			add_or_sub = P - i1;
		else
			add_or_sub = P + i1;
	end
endmodule
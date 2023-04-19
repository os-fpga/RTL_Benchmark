module accumulator (clk, reset, subtract_i, A, P);
	input clk, reset, subtract_i;
	input signed [19:0] A;
	output reg signed [37:0] P;
	reg signed [19:0] i1;
	reg signed [37:0] mul, add_or_sub;
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
		if (subtract_i)
			add_or_sub = P - i1;
		else
			add_or_sub = P + i1;
	end
endmodule
module dsp_mult_5x5_inf_dsp19x2 (clk, reset, A, B, P);
	input clk, reset;
	input  [4:0] A;
	input  [4:0] B;
	output reg  [37:0] P;
	reg  [4:0] i1;
	reg  [4:0] i2;
	reg  [31:0] mul;
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
	always @(posedge clk) begin
		if (reset ==1 )
			P <= 0;
		else
			P<= mul;
	end

	always @ (*)  begin
		mul  = i1 * i2;
	end
endmodule
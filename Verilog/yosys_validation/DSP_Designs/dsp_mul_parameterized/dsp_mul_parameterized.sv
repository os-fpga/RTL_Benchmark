module dsp_mul_parameterized #(parameter A_WIDTH = 64, B_WIDTH = 64) (clk, reset, A, B, P);
	input clk, reset;
	input signed [A_WIDTH-1:0] A;
	input signed [B_WIDTH-1:0] B;
	output reg signed [A_WIDTH + B_WIDTH-1 :0] P;
	reg signed [A_WIDTH-1:0] i1;
	reg signed [B_WIDTH-1:0] i2;
	reg signed [A_WIDTH + B_WIDTH-1:0] mul;
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
			P <= mul;
	end

	always @ (*)  begin
		mul  = i1 * i2;
	end
endmodule
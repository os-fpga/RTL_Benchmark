module dsp_mul_unsigned_reg_inf_dsp19x2 (clk, reset, A1, B1, A2, B2, P);
	input clk, reset;
	input  [9:0] A1;
	input  [9:0] A2;
	input  [8:0] B1;
	input  [8:0] B2;
	output reg  [37:0] P;
	reg  [9:0] i1;
	reg  [9:0] i3;
	reg  [8:0] i2;
	reg  [8:0] i4;
	reg  [31:0] mul1;
	reg  [31:0] mul2;
	always @(posedge clk) begin
		if(reset == 1) begin
			i1 <= 0;
			i2 <= 0;
			i3 <= 0;
			i4 <= 0;
		end
		else begin
			i1 <= A1;
			i2 <= B1;
			i3 <= A2;
			i4 <= B2;
		end
	end
	always @(posedge clk) begin
		if (reset ==1 )
			P <= 0;
		else
			P<= {mul2,mul1};
	end

	always @ (*)  begin
		mul1  = i1 * i2;
		mul2  = i3 * i4; 
	end
endmodule
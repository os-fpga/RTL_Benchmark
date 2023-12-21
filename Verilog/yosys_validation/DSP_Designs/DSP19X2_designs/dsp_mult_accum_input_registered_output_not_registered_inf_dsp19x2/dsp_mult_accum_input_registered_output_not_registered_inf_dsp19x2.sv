module dsp_mult_accum_input_registered_output_not_registered_inf_dsp19x2 (clk, reset, subtract, A1, A2, B1, B2, P);
	input clk, reset, subtract;
	input  [9:0] A1;
	input  [9:0] A2;
	input  [8:0] B1;
	input  [8:0] B2;
	output reg  [37:0] P;
	reg    [9:0] A1_reg;
	reg    [9:0] A2_reg;
	reg    [8:0] B1_reg;
	reg    [8:0] B2_reg;
	reg    [31:0] mult1, mult2;
	reg    [63:0] add_or_sub;

	always @(posedge clk) begin
		if(reset == 1) begin
			A1_reg <= 0;
			A2_reg <= 0;
			B1_reg <= 0;
			B2_reg <= 0;
		end
		else begin
			A1_reg <= A1;
			A2_reg <= A2;
			B1_reg <= B1;
			B2_reg <= B2;
		end
	end

	always @ (*)  begin
		mult1 <= A1_reg*B1_reg;
		mult2 <= A2_reg*B2_reg;
	end

	always @ (*)  begin
		if (subtract)
			add_or_sub = {(add_or_sub[63:0] - mult2),(add_or_sub[31:0] - mult1)};
		else
			add_or_sub = {(add_or_sub[63:0] - mult2),(add_or_sub[31:0] - mult1)};
	end

	assign P = {add_or_sub[50:32],add_or_sub[18:0]};
	
endmodule
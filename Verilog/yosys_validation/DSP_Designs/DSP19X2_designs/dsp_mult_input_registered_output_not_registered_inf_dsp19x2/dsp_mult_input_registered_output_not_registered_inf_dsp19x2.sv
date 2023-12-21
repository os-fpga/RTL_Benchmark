 
module dsp_mult_input_registered_output_not_registered_inf_dsp19x2(clk, reset, A1, A2, B1, B2, P);
	input  clk, reset;
	input  [9:0] A1;
	input  [9:0] A2;
	input  [8:0] B1;
	input  [8:0] B2;
	output [37:0] P;
	reg    [9:0] A1_reg;
	reg    [9:0] A2_reg;
	reg    [8:0] B1_reg;
	reg    [8:0] B2_reg;
	reg    [31:0] mult1;
	reg    [31:0] mult2;

	always@(posedge clk)
	 begin
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
		mult1  = A1_reg * B1_reg;
        mult2  = A2_reg * B2_reg;
	end

    assign P = {mult2[18:0],mult1[18:0]};

endmodule 
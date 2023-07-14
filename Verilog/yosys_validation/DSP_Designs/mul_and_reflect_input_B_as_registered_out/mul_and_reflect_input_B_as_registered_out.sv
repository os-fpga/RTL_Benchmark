module mul_and_reflect_input_B_as_registered_out (clk, reset, A, B, P, DlyB_o);
	input clk, reset;
	input signed [19:0] A;
	input signed [17:0] B;
	output reg signed [37:0] P;
	output reg [17:0] DlyB_o;
	reg signed [19:0] i1;
	reg signed [17:0] i2;
	reg signed [37:0] mul;
	always @(posedge clk) begin
		if(reset == 1) begin
			i1 <= 0;
			i2 <= 0;
			DlyB_o <= 0;
		end
		else begin
			i1 <= A;
			i2 <= B;
			DlyB_o <= B;
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
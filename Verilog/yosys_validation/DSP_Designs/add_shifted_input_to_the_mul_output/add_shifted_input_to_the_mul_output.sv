// module add_shifted_input_to_the_mul_output (clk, reset, subtract_i, A, B, acc_fir, P);
// 	input clk, reset, subtract_i;
// 	input signed [19:0] A;
// 	input signed [17:0] B;
// 	input [3:0] acc_fir;
// 	output reg signed [37:0] P;
// 	reg signed [19:0] i1;
// 	reg signed [17:0] i2;
// 	reg [3:0] acc_fir_reg;
// 	reg signed [37:0] mul, add_or_sub;
// 	wire signed [37:0] shift_out;
// 	always @(posedge clk) begin
// 		if(reset == 1) begin
// 			i1 <= 0;
// 			i2 <= 0;
// 			acc_fir_reg <= 0;
// 		end
// 		else begin
// 			i1 <= A;
// 			i2 <= B;
// 			acc_fir_reg <= acc_fir;
// 		end
// 	end
// 	always @(posedge clk) begin
// 		if (reset ==1 )
// 			P <= 0;
// 		else
// 			P <= add_or_sub;
// 	end

// 	always @ (*)  begin
// 		mul  = P[19:0] * i2;
// 	end
// 	assign shift_out = A << acc_fir_reg;
// 	always @ (*)  begin
// 		add_or_sub = shift_out + mul;
// 	end
// endmodule


module add_shifted_input_to_the_mul_output (clk, reset, subtract_i, A, B, acc_fir, P);
	input clk, reset, subtract_i;
	input signed [19:0] A;
	input signed [17:0] B;
	input [3:0] acc_fir;
	output reg [37:0] P;

	wire [37:0] shift_out, mul_out;
	reg signed [19:0] i1;
	reg signed [17:0] i2;
	reg [3:0] acc_fir_reg;
	reg signed [37:0] mul, add_or_sub;
	wire signed [37:0] shift_out;
	assign mul_out = i2*20'hde433;
	assign shift_out = i1<<acc_fir;

	always @(posedge clk)begin
		if (reset)begin
			i1<=0;
			i2<=0;
			P<=0;
		end
		else begin
			i1 <= A;
			i2 <= B;
			P<=mul_out+shift_out;
		end
	end	
endmodule

// module add_shifted_input_to_the_mul_output (clk, reset, subtract_i, A, B, acc_fir, P);
// 	input clk, reset, subtract_i;
// 	input signed [19:0] A;
// 	input signed [17:0] B;
// 	input [5:0] acc_fir;
// 	output [37:0] P;
// 	reg signed [19:0] i1;
// 	reg signed [17:0] i2;
// 	reg [5:0] acc_fir_reg;
// 	reg signed [37:0] mul, add_or_sub;
// 	wire signed [37:0] shift_out;
// 	assign P = A<<acc_fir;
// endmodule
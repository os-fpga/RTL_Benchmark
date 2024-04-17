module dsp_mul_signed_reg_active_low_async_reset (clk, reset, A, B, P);
	input clk, reset;
	input signed [19:0] A;
	input signed [17:0] B;
	output wire signed [37:0] P;
	reg signed [19:0] i1;
	reg signed [17:0] i2;
	wire  [37:0] mul;
	wire [63:0] sign_extend;
	reg [63:0] out;
	always @(posedge clk or negedge reset) begin
		if(reset == 1'b0) begin
			i1 <= 0;
			i2 <= 0;
		end
		else begin
			i1 <= A;
			i2 <= B;
		end
	end
	always @(posedge clk or negedge reset) begin
		if (reset ==1'b0 )
			out <= 0;
		else
			out <= sign_extend;
	end

	assign P = out;

	assign mul  = i1 * i2;
	assign sign_extend = {{26{mul[37]}}, mul};

endmodule
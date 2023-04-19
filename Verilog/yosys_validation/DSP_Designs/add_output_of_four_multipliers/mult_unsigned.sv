module mult_unsigned #(
    parameter INPUT_WIDTH = 14,
    parameter OUTPUT_WIDTH = 28
  ) (A, B, Y);
	input wire  [INPUT_WIDTH-1:0] A;
	input wire  [INPUT_WIDTH-1:0] B;
	output wire [OUTPUT_WIDTH-1:0] Y;

		assign Y = A * B;
endmodule

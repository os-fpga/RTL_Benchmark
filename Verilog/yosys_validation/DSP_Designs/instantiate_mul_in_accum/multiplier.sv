module multiplier (A, B, mul);
	input signed [19:0] A;
	input signed [17:0] B;
	output signed [37:0] mul;

		assign mul   = A * B;
endmodule
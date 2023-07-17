module dsp_mul_unsigned_comb (A, B, P);
	input  [19:0] A;
	input  [17:0] B;
	output [37:0] P;

		assign P   = A * B;
endmodule
module dsp_fractured_signed_mul_comb (A, B, A_fmode, B_fmode, P);
	input signed [9:0] A, A_fmode;
	input signed [8:0] B, B_fmode;
	output signed [37:0] P;
	wire [18:0] f1, f2;

		assign f1 = A * B;
		assign f2 = A_fmode * B_fmode;
		assign P  = {f1, f2};

endmodule
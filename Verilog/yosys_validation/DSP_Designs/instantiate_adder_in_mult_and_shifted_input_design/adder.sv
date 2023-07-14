module adder (A, B, out);
	input signed [63:0] A;
	input signed [63:0] B;
	output signed [63:0] out;

	assign out   = A + B;
    
endmodule
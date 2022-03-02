module ripple_adder_8bit(input [7:0] a,b, input cin, output [7:0] sum, output cout);

	wire carry;

	ripple_adder_4bit RA0(a[3:0],b[3:0],cin,sum[3:0],carry);
	ripple_adder_4bit RA1(a[7:4],b[7:4],carry,sum[7:4],cout);

endmodule

module ripple_adder_12bit(input [11:0] a,b, input cin, output [11:0] sum, output cout);

	wire carry;

	ripple_adder_6bit RA0(a[5:0],b[5:0],cin,sum[5:0],carry);
	ripple_adder_6bit RA1(a[11:6],b[11:6],carry,sum[11:6],cout);

endmodule

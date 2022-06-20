module ripple_adder_6bit(input [5:0] a,b, input cin, output [5:0] sum, output cout);

	wire carry1, carry2, carry3, carry4, carry5;

	full_adder FA0(a[0],b[0],cin,sum[0],carry1);
	full_adder FA1(a[1],b[1],carry1,sum[1],carry2);
	full_adder FA2(a[2],b[2],carry2,sum[2],carry3);
	full_adder FA3(a[3],b[3],carry3,sum[3],carry4);
	full_adder FA4(a[4],b[4],carry4,sum[4],carry5);
	full_adder FA5(a[5],b[5],carry5,sum[5],cout);

endmodule

module vedic8x8(input [7:0] a,b, output [15:0] prod);

	wire [7:0] mult0, mult1, mult2, mult3;
	wire [7:0] sum0;
	wire [11:0] sum1, sum2;
	wire carry0, carry2, carry3;

	vedic4x4 VD0(a[3:0],b[3:0],mult0);
	vedic4x4 VD1(a[3:0],b[7:4],mult1);
	vedic4x4 VD2(a[7:4],b[3:0],mult2);
	vedic4x4 VD3(a[7:4],b[7:4],mult3);

	ripple_adder_8bit RA0({4'b0,mult0[7:4]},mult2,1'b0,sum0,carry0);
	ripple_adder_12bit RA1({4'b0,mult1},{mult3,4'b0},1'b0,sum1,carry1);
	ripple_adder_12bit RA2({4'b0,sum0},sum1,1'b0,sum2,carry2);

	assign prod = {sum2,mult0[3:0]};

endmodule

module vedic4x4(input [3:0] a,b, output [7:0] prod);

	wire [3:0] mult0, mult1, mult2, mult3;
	wire [3:0] sum0;
	wire [5:0] sum1, sum2;
	wire carry0, carry1, carry2;

	vedic2x2 VD0(a[1:0],b[1:0],mult0);
	vedic2x2 VD1(a[1:0],b[3:2],mult1);
	vedic2x2 VD2(a[3:2],b[1:0],mult2);
	vedic2x2 VD3(a[3:2],b[3:2],mult3);

	ripple_adder_4bit RA0({2'b0,mult0[3:2]},mult2,1'b0,sum0,carry0);
	ripple_adder_6bit RA1({2'b0,mult1},{mult3,2'b0},1'b0,sum1,carry1);
	ripple_adder_6bit RA2({2'b0,sum0},sum1,1'b0,sum2,carry2);
	
	assign prod = {sum2,mult0[1:0]};

endmodule

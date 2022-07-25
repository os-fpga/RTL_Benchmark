module mux_8x1 (
	input [31:0] in0,
	input [31:0] in1,
	input [31:0] in2,
	input [31:0] in3,
	input [31:0] in4,
	input [31:0] in5,
	input [31:0] in6,
	input [31:0] in7,
	input [2:0]sel,
	output [31:0] out);
	wire [31:0] out0_w, out1_w;
	
	mux_4x1 m8_0(.in0(in0) ,.in1(in1),. in2(in2) ,.in3(in3),.sel(sel[1:0]),.out(out0_w));
	mux_4x1 m8_1(.in0(in4) ,.in1(in5),. in2(in6) ,.in3(in7),.sel(sel[1:0]),.out(out1_w));
	mux_2x1 m8_2(.a(out0_w),.b(out1_w),.sel(sel[2]),.out(out));
	
	endmodule
module mux_4x1 (
    input [31:0]in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
	input [1:0]sel,
	output [31:0] out);
	wire [31:0] out0_w, out1_w;
	
	mux_2x1 m4_0(.a(in0),.b(in1),.sel(sel[0]),.out(out0_w));
	mux_2x1 m4_1(.a(in2),.b(in3),.sel(sel[0]),.out(out1_w));
	mux_2x1 m4_2(.a(out0_w),.b(out1_w),.sel(sel[1]),.out(out));
	
endmodule 
	
module mux_2x1 (
	input [31:0] a,
	input [31:0] b,
	input sel,
	output [31:0] out);
	assign out = sel ? b : a;
	
endmodule 
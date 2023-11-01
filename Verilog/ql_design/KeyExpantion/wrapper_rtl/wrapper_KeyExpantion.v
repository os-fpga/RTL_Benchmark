//Wrapper Design

`timescale 1 ns/1 ps

module wrapper_KeyExpantion
#
(
parameter DATA_W = 128,               //data width
parameter KEY_L = 128,                //key length
parameter NO_ROUNDS = 10              //number of rounds
)
(
input clk,                            //system clock
input reset,                          //async reset               
input valid_in,                       //input valid in
input [KEY_L-1:0] cipher_key,         //cipher key
output [(NO_ROUNDS*DATA_W)/16-1:0] w,    //contains all generated round keys
input [3:0] sel_mux_w,
output [NO_ROUNDS-1:0] valid_out      //output valid signal
);
wire [31:0] RCON [0:9];                       //round constant array of words
wire [NO_ROUNDS-1:0] keygen_valid_out;        //every bit represens output valid signal for every RoundKeyGen module 
wire [DATA_W-1:0] W_array  [0:NO_ROUNDS-1];   //array of round keys to form W output 

wire [1279:0] w_temp;

KeyExpantion #() ke(.clk(clk),.reset(reset),.valid_in(valid_in),.cipher_key(cipher_key),.W(w_temp),.valid_out(valid_out) );
mux_16x1 mux(.in0(w_temp[79:0]),. in1(w_temp[159:80]),. in2(w_temp[239:160]),. in3(w_temp[319:240]),. in4(w_temp[399:320]),. in5(w_temp[479:400]),. in6(w_temp[559:480]),. in7(w_temp[639:560]),.in8(w_temp[719:640]),. in9(w_temp[799:720]),. in10(w_temp[879:800]),. in11(w_temp[959:880]),. in12(w_temp[1039:960]),. in13(w_temp[1119:1040]),. in14(w_temp[1199:1120]),. in15(w_temp[1279:1200]),.sel(sel_mux_w),.out(w));
                    
endmodule

module mux_16x1 (
	input [79:0] in0, in1, in2, in3, in4, in5, in6,in7,
    input [79:0] in8, in9, in10, in11, in12, in13, in14,in15,
	input [3:0]sel,
	output [79:0] out);
	wire [79:0] out0_w, out1_w;
	
	mux_8x1 m16_0(.in0(in0) ,.in1(in1),. in2(in2) ,.in3(in3) ,.in4(in4) ,.in5(in5),. in6(in6) ,.in7(in7),.sel(sel[2:0]),.out(out0_w));
	mux_8x1 m16_1(.in0(in0) ,.in1(in1),. in2(in2) ,.in3(in3) ,.in4(in4) ,.in5(in5),. in6(in6) ,.in7(in7),.sel(sel[2:0]),.out(out1_w));
	mux_2x1 m16_2(.a(out0_w),.b(out1_w),.sel(sel[3]),.out(out));
	
	endmodule

module mux_8x1 (
	input [79:0] in0,
	input [79:0] in1,
	input [79:0] in2,
	input [79:0] in3,
	input [79:0] in4,
	input [79:0] in5,
	input [79:0] in6,
	input [79:0] in7,
	input [2:0]sel,
	output [79:0] out);
	wire [79:0] out0_w, out1_w;
	
	mux_4x1 m8_0(.in0(in0) ,.in1(in1),. in2(in2) ,.in3(in3),.sel(sel[1:0]),.out(out0_w));
	mux_4x1 m8_1(.in0(in4) ,.in1(in5),. in2(in6) ,.in3(in7),.sel(sel[1:0]),.out(out1_w));
	mux_2x1 m8_2(.a(out0_w),.b(out1_w),.sel(sel[2]),.out(out));
	
	endmodule
module mux_4x1 (
    input [79:0]in0,
    input [79:0] in1,
    input [79:0] in2,
    input [79:0] in3,
	input [1:0]sel,
	output [79:0] out);
	wire [79:0] out0_w, out1_w;
	
	mux_2x1 m4_0(.a(in0),.b(in1),.sel(sel[0]),.out(out0_w));
	mux_2x1 m4_1(.a(in2),.b(in3),.sel(sel[0]),.out(out1_w));
	mux_2x1 m4_2(.a(out0_w),.b(out1_w),.sel(sel[1]),.out(out));
	
endmodule 
	
	module mux_2x1 (
	input [79:0] a,
	input [79:0] b,
	input sel,
	output [79:0] out);
	assign out = sel ? b : a;
	
endmodule 
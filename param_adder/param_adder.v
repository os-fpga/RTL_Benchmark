//-------------------------------------------------------
//  Functionality: An n-bit adder circuit
//  Author:        Laraib Khan
//-------------------------------------------------------

`timescale 1ns / 1ps
`define size 10
module param_adder(cout, sum, a, b, cin);

output cout;
output [`size-1:0] sum; 	 // sum uses the size parameter
input cin;
input [`size-1:0] a, b;  // 'a' and 'b' use the size parameter

assign {cout, sum} = a + b + cin;

endmodule
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  AES RCON Block                                             ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////


`timescale 1 ns/1 ps

module aes_rcon(clk,out,out2,out3,out4,out5,out6,out7,out8,out9,out10);

input		clk;

output [7:0] out,out2,out3,out4,out5,out6,out7,out8,out9,out10;



assign		out  = frcon(0);
assign		out2 = frcon(1); 
assign		out3 = frcon(2);
assign		out4 = frcon(3);
assign		out5 = frcon(4);
assign		out6 = frcon(5);
assign		out7 = frcon(6); 
assign		out8 = frcon(7);
assign		out9 = frcon(8);
assign		out10 = frcon(9);		 

function [7:0]	frcon;

input	[3:0]	i;

case(i)	// synopsys parallel_case
   4'h0: frcon=8'h01;		//1
   4'h1: frcon=8'h02;		//x
   4'h2: frcon=8'h04;		//x^2
   4'h3: frcon=8'h08;		//x^3
   4'h4: frcon=8'h10;		//x^4
   4'h5: frcon=8'h20;		//x^5
   4'h6: frcon=8'h40;		//x^6
   4'h7: frcon=8'h80;		//x^7
   4'h8: frcon=8'h1b;		//x^8
   4'h9: frcon=8'h36;		//x^9
   default: frcon=8'h00;
endcase

endfunction



endmodule

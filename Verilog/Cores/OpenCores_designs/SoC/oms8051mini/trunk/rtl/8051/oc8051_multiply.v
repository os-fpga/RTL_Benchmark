//////////////////////////////////////////////////////////////////////
//// 								  ////
//// multiply for 8051 Core 				  	  ////
//// 								  ////
//// This file is part of the 8051 cores project 		  ////
////  http://www.opencores.org/cores/oms8051mini/                 ////
//// 								  ////
//// Description 						  ////
//// Implementation of multipication used in alu.v 		  ////
//// 								  ////
//// To Do: 							  ////
////  Nothing							  ////
//// 								  ////
//// Author(s): 						  ////
//// - Simon Teran, simont@opencores.org 			  ////
//// - Marko Mlinar, markom@opencores.org 			  ////
//// - Dinesh Annayya, dinesha@opencores.org 			  ////
//// 								  ////
//////////////////////////////////////////////////////////////////////
////   v0.0 - Dinesh A, 5th Jan 2017
////        1. Active edge of reset changed from High to Low
//////////////////////////////////////////////////////////////////////
//// 								  ////
//// Copyright (C) 2001 Authors and OPENCORES.ORG 		  ////
//// 								  ////
//// This source file may be used and distributed without 	  ////
//// restriction provided that this copyright statement is not 	  ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
//// 								  ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version. 						  ////
//// 								  ////
//// This source is distributed in the hope that it will be 	  ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 	  ////
//// PURPOSE. See the GNU Lesser General Public License for more  ////
//// details. 							  ////
//// 								  ////
//// You should have received a copy of the GNU Lesser General 	  ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml 			  ////
//// 								  ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
// Revision 1.8  2002/09/30 17:33:59  simont
// prepared header
//
//
// ver: 2 markom
// changed to two cycle multiplication, to save resources and
// increase speed
//
// ver: 3 markom
// changed to four cycle multiplication, to save resources and
// increase speed



module oc8051_multiply (clk, resetn, enable, src1, src2, des1, des2, desOv);
//
// this module is part of alu
// clk          (in)
// resetn          (in)
// enable       (in)
// src1         (in)  first operand
// src2         (in)  second operand
// des1         (out) first result
// des2         (out) second result
// desOv        (out) Overflow output
//

input clk, resetn, enable;
input [7:0] src1, src2;
output desOv;
output [7:0] des1, des2;

// wires
wire [15:0] mul_result1, mul_result, shifted;

// real registers
reg [1:0] cycle;
reg [15:0] tmp_mul;

assign mul_result1 = src1 * (cycle == 2'h0 ? src2[7:6] 
                           : cycle == 2'h1 ? src2[5:4]
                           : cycle == 2'h2 ? src2[3:2]
                           : src2[1:0]);

assign shifted = (cycle == 2'h0 ? 16'h0 : {tmp_mul[13:0], 2'b00});
assign mul_result = mul_result1 + shifted;
assign des1 = mul_result[15:8];
assign des2 = mul_result[7:0];
assign desOv = | des1;

always @(posedge clk or negedge resetn)
begin
  if (resetn == 1'b0) begin
    cycle <= 2'b0;
    tmp_mul <= 16'b0;
  end else begin
    if (enable) cycle <= cycle + 2'b1;
    tmp_mul <= mul_result;
  end
end

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Low Pass Filter FIR IP Core                                 ////
////                                                              ////
////  This file is part of the LPFFIR project                     ////
////  https://opencores.org/projects/lpffir                       ////
////                                                              ////
////  Description                                                 ////
////  Implementation of LPFFIR IP core according to               ////
////  LPFFIR IP core specification document.                      ////
////                                                              ////
////  To Do:                                                      ////
////  -                                                           ////
////                                                              ////
////  Author:                                                     ////
////  - Vladimir Armstrong, vladimirarmstrong@opencores.org       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2019 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

// Ripple Carry Adder: adds two 16-bit numbers
module rca(
           input [15:0]        a,
           input [15:0]        b,
           input               ci, // Carry Input

           output logic        co, // Carry Output
           output logic [15:0] s // Sum
           );

   logic                       a0,a1,a2,a3,a4,a5,a6,a7;
   logic                       a8,a9,a10,a11,a12,a13,a14,a15;
   logic                       b0,b1,b2,b3,b4,b5,b6,b7;
   logic                       b8,b9,b10,b11,b12,b13,b14,b15;
   logic                       c0,c1,c2,c3,c4,c5,c6,c7;
   logic                       c8,c9,c10,c11,c12,c13,c14;
   logic                       s0,s1,s2,s3,s4,s5,s6,s7;
   logic                       s8,s9,s10,s11,s12,s13,s14,s15;

   assign a0 = a[0], a1 = a[1], a2 = a[2], a3 = a[3];
   assign a4 = a[4], a5 = a[5], a6 = a[6], a7 = a[7];
   assign a8 = a[8], a9 = a[9], a10 = a[10];
   assign a11 = a[11], a12 = a[12], a13 = a[13];
   assign a14 = a[14], a15 = a[15];
   assign b0 = b[0], b1 = b[1], b2 = b[2], b3 = b[3];
   assign b4 = b[4], b5 = b[5], b6 = b[6], b7 = b[7];
   assign b8 = b[8], b9 = b[9], b10 = b[10], b11 = b[11];
   assign b12 = b[12], b13 = b[13], b14 = b[14], b15 = b[15];
   assign s[0] = s0, s[1] = s1, s[2] = s2, s[3] = s3;
   assign s[4] = s4, s[5] = s5,s[6] = s6, s[7] = s7;
   assign s[8] = s8, s[9] = s9, s[10] = s10, s[11] = s11;
   assign s[12] = s12, s[13] = s13, s[14] = s14, s[15] = s15;

   fa fa_inst0(.a(a0),.b(b0),.ci(ci),.co(c0),.s(s0));
   fa fa_inst1(.a(a1),.b(b1),.ci(c0),.co(c1),.s(s1));
   fa fa_inst2(.a(a2),.b(b2),.ci(c1),.co(c2),.s(s2));
   fa fa_inst3(.a(a3),.b(b3),.ci(c2),.co(c3),.s(s3));
   fa fa_inst4(.a(a4),.b(b4),.ci(c3),.co(c4),.s(s4));
   fa fa_inst5(.a(a5),.b(b5),.ci(c4),.co(c5),.s(s5));
   fa fa_inst6(.a(a6),.b(b6),.ci(c5),.co(c6),.s(s6));
   fa fa_inst7(.a(a7),.b(b7),.ci(c6),.co(c7),.s(s7));
   fa fa_inst8(.a(a8),.b(b8),.ci(c7),.co(c8),.s(s8));
   fa fa_inst9(.a(a9),.b(b9),.ci(c8),.co(c9),.s(s9));
   fa fa_inst10(.a(a10),.b(b10),.ci(c9),.co(c10),.s(s10));
   fa fa_inst11(.a(a11),.b(b11),.ci(c10),.co(c11),.s(s11));
   fa fa_inst12(.a(a12),.b(b12),.ci(c11),.co(c12),.s(s12));
   fa fa_inst13(.a(a13),.b(b13),.ci(c12),.co(c13),.s(s13));
   fa fa_inst14(.a(a14),.b(b14),.ci(c13),.co(c14),.s(s14));
   fa fa_inst15(.a(a15),.b(b15),.ci(c14),.co(co),.s(s15));

endmodule

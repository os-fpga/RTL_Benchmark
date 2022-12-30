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

module lpffir_core (
                    input               clk_i,
                    input               rstn_i,
                    input               en_i,
                    input [15:0]        x_i,
                    output logic [15:0] y_o
                    );

   reg [15:0]                           x1;
   reg [15:0]                           x2;
   reg [15:0]                           x3;
   reg [15:0]                           x4;
   reg [15:0]                           x5;

   logic [15:0]                         h0;
   logic [15:0]                         h1;
   logic [15:0]                         h2;
   logic [15:0]                         h01;

   logic                                co0;
   logic                                co1;
   logic                                co2;
   logic                                co3;
   logic                                co4;

   // Linear-phase FIR structure
   rca rca_inst0 (.a(x_i),.b(x5),.ci(0),.co(co0),.s(h0));
   rca rca_inst1 (.a(x1),.b(x4),.ci(0),.co(co1),.s(h1));
   rca rca_inst2 (.a(x2),.b(x3),.ci(0),.co(co2),.s(h2));
   rca rca_inst3 (.a(h0),.b(h1),.ci(0),.co(co3),.s(h01));
   rca rca_inst4 (.a(h01),.b(h2),.ci(0),.co(co4),.s(y_o));

   always_ff @(posedge clk_i or posedge rstn_i)
     if(!rstn_i)
       begin
          x1 <= 0;
          x2 <= 0;
          x3 <= 0;
          x4 <= 0;
          x5 <= 0;
       end
     else if (en_i)
       begin
          x1 <= x_i;
          x2 <= x1;
          x3 <= x2;
          x4 <= x3;
          x5 <= x4;
       end

endmodule

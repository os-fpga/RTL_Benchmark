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

// Verilog test bench
module bench (
              input clk,
              input rstn
              );

   logic            rx_tready;
   logic            tx_tlast;
   logic            tx_tvalid;
   logic [15:0]     in = (count == 1) ? 1:0;
   logic [15:0]     out;
   reg [31:0]       count;

   always_ff @(posedge clk or posedge rstn)
     if (!rstn)
       count <= 0;
     else
       count <= count + 1;

   // unit under test(UUT)
   lpffir_axis lpffir_axis (
                            .aclk_i(clk),
                            .aresetn_i(rstn),
                            .rx_tlast_i(0),
                            .rx_tvalid_i(1),
                            .rx_tready_o(rx_tready),
                            .rx_tdata_i(in),
                            .tx_tlast_o(tx_tlast),
                            .tx_tvalid_o(tx_tvalid),
                            .tx_tready_i(1),
                            .tx_tdata_o(out)
                            );

   // Test case log
   initial begin
      $display("Test Case #1:");
      $display("Check impulse response of low-pass filter.");
      $display("RTL simulation results:");
      $display("Input Output");
      $display("----- ------");
   end

   always_ff @(posedge clk or posedge rstn)
     if(rstn)
       $display("  %0d     %0d", in, out);

endmodule

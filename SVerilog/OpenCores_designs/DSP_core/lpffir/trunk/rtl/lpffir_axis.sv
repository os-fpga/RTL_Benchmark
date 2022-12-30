//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Low Pass Filter FIR  with AXI-Stream Interface              ////
////                                                              ////
////  This file is part of the LPFFIR project                     ////
////  https://opencores.org/projects/lpffir                       ////
////                                                              ////
////  Description                                                 ////
////  Implementation of AXI-Stream (AXIS) protocol rapper         ////
///   of LPFFIR IP core according to                              ////
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

module lpffir_axis (
                    input               aclk_i,
                    input               aresetn_i,
                    // AXI-Stream RX interface
                    input               rx_tlast_i,
                    input               rx_tvalid_i,
                    output logic        rx_tready_o,
                    input [15:0]        rx_tdata_i,
                    // AXI-Stream TX interface
                    output logic        tx_tlast_o,
                    output reg          tx_tvalid_o,
                    input               tx_tready_i,
                    output logic [15:0] tx_tdata_o
                    );

   logic                                lpffir_en = rx_tvalid_i && tx_tready_i;

   // AXI-Stream interface
   assign rx_tready_o = lpffir_en;
   assign tx_tvalid_o = lpffir_en;
   assign tx_tlast_o  = rx_tlast_i;

   // LPFFIR
   lpffir_core lpffir_core(
                           .clk_i(aclk_i),
                           .rstn_i(aresetn_i),
                           .en_i(lpffir_en),
                           .x_i(rx_tdata_i),
                           .y_o(tx_tdata_o)
                           );

endmodule

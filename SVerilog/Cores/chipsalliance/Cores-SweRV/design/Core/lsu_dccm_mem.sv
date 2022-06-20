// SPDX-License-Identifier: Apache-2.0
// Copyright 2019 Western Digital Corporation or its affiliates.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//********************************************************************************
// $Id$
//
//
// Owner:
// Function: DCCM for LSU pipe
// Comments: Single ported memory
//
//
// DC1 -> DC2 -> DC3 -> DC4 (Commit)
//
// //********************************************************************************

module lsu_dccm_mem
   import swerv_types::*;
(
   input logic         clk,                                              // clock
   input logic         free_clk,                                         // clock
   input logic         rst_l,
   input logic         lsu_freeze_dc3,                                   // freeze
   input logic         clk_override,                                     // clock override

   input logic         dccm_wren,                                        // write enable
   input logic         dccm_rden,                                        // read enable
   input logic [16-1:0]  dccm_wr_addr,                        // write address
   input logic [16-1:0]  dccm_rd_addr_lo,                     // read address
   input logic [16-1:0]  dccm_rd_addr_hi,                     // read address for the upper bank in case of a misaligned access
   input logic [39-1:0]  dccm_wr_data,                 // write data

   output logic [39-1:0] dccm_rd_data_lo,              // read data from the lo bank
   output logic [39-1:0] dccm_rd_data_hi,              // read data from the hi bank

   input  logic         scan_mode
);

// `include "global.h"

   localparam DCCM_WIDTH_BITS = $clog2(4);
   localparam DCCM_INDEX_BITS = (16 - 3 - DCCM_WIDTH_BITS);

   logic [8-1:0]         wren_bank;
   logic [8-1:0]         rden_bank;
   logic [8-1:0] [16-1:(3+2)]   addr_bank;
   logic [16-1:(3+DCCM_WIDTH_BITS)] rd_addr_even, rd_addr_odd;
   logic                              rd_unaligned;
   logic [8-1:0] [39-1:0]   dccm_bank_dout;
   logic [39-1:0]       wrdata;

   logic [8-1:0]         wren_bank_q;
   logic [8-1:0]         rden_bank_q;
   logic [8-1:0][16-1:(3+2)]    addr_bank_q;
   logic [39-1:0]       dccm_wr_data_q;

   logic [(DCCM_WIDTH_BITS+3-1):DCCM_WIDTH_BITS]      dccm_rd_addr_lo_q;
   logic [(DCCM_WIDTH_BITS+3-1):DCCM_WIDTH_BITS]      dccm_rd_addr_hi_q;

   logic [8-1:0]            dccm_clk;
   logic [8-1:0]            dccm_clken;

   logic [39-1:0]          dccm_rd_data_lo_q, dccm_rd_data_hi_q;
   logic                                 lsu_freeze_dc3_q;

   assign rd_unaligned = (dccm_rd_addr_lo[DCCM_WIDTH_BITS+:3] != dccm_rd_addr_hi[DCCM_WIDTH_BITS+:3]);

`ifdef RV_FPGA_OPTIMIZE
   // Align the read data
   assign dccm_rd_data_lo[39-1:0]  = lsu_freeze_dc3_q ? dccm_rd_data_lo_q[39-1:0] : dccm_bank_dout[dccm_rd_addr_lo_q[DCCM_WIDTH_BITS+:3]][39-1:0];
   assign dccm_rd_data_hi[39-1:0]  = lsu_freeze_dc3_q ? dccm_rd_data_hi_q[39-1:0] : dccm_bank_dout[dccm_rd_addr_hi_q[DCCM_WIDTH_BITS+:3]][39-1:0];

   rvdff  #(1) lsu_freeze_dc3ff(.din(lsu_freeze_dc3), .dout(lsu_freeze_dc3_q), .clk(free_clk), .*);
   rvdffe #(39) dccm_rd_data_loff(.din(dccm_rd_data_lo), .dout(dccm_rd_data_lo_q), .en(~lsu_freeze_dc3_q), .*);
   rvdffe #(39) dccm_rd_data_hiff(.din(dccm_rd_data_hi), .dout(dccm_rd_data_hi_q), .en(~lsu_freeze_dc3_q), .*);
`else
   // Align the read data
   assign dccm_rd_data_lo[39-1:0]  = dccm_bank_dout[dccm_rd_addr_lo_q[DCCM_WIDTH_BITS+:3]][39-1:0];
   assign dccm_rd_data_hi[39-1:0]  = dccm_bank_dout[dccm_rd_addr_hi_q[DCCM_WIDTH_BITS+:3]][39-1:0];
`endif

   // Generate even/odd address
   // assign rd_addr_even[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS] = dccm_rd_addr_lo[2] ? dccm_rd_addr_hi[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS] :
   //                                                                                               dccm_rd_addr_lo[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS];

   // assign rd_addr_odd[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS]  = dccm_rd_addr_lo[2] ? dccm_rd_addr_lo[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS] :
   //                                                                                               dccm_rd_addr_hi[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS];

   // 8 Banks, 16KB each (2048 x 72)
   for (genvar i=0; i<8; i++) begin: mem_bank
      assign  wren_bank[i]        = dccm_wren & (dccm_wr_addr[2+:3] == i);
      assign  rden_bank[i]        = dccm_rden & ((dccm_rd_addr_hi[2+:3] == i) | (dccm_rd_addr_lo[2+:3] == i));
      assign  addr_bank[i][(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS] = wren_bank[i] ? dccm_wr_addr[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS] :
                                                                                (((dccm_rd_addr_hi[2+:3] == i) & rd_unaligned) ?
                                                                                                    dccm_rd_addr_hi[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS] :
                                                                                                    dccm_rd_addr_lo[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS]);

      // if (i%2 == 0) begin
      //    assign  addr_bank[i][(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS] = wren_bank[i] ? dccm_wr_addr[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS] :
      //                                                                                             rd_addr_even[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS];
      // end else begin
      //    assign  addr_bank[i][(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS] = wren_bank[i] ? dccm_wr_addr[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS] :
      //                                                                                             rd_addr_odd[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS];
      // end

      // clock gating section
      assign  dccm_clken[i] = (wren_bank[i] | rden_bank[i] | clk_override) & ~lsu_freeze_dc3;
      rvoclkhdr lsu_dccm_cgc (.en(dccm_clken[i]), .l1clk(dccm_clk[i]), .*);
      // end clock gating section

      ram_2048x39  dccm_bank (
                                     // Primary ports
                                     .CLK(dccm_clk[i]),
                                     .WE(wren_bank[i]),
                                     .ADR(addr_bank[i]),
                                     .D(dccm_wr_data[39-1:0]),
                                     .Q(dccm_bank_dout[i][39-1:0])

                                    );

   end : mem_bank

   // Flops
   rvdffs  #(3) rd_addr_lo_ff (.*, .din(dccm_rd_addr_lo[DCCM_WIDTH_BITS+:3]), .dout(dccm_rd_addr_lo_q[DCCM_WIDTH_BITS+:3]), .en(~lsu_freeze_dc3), .clk(free_clk));
   rvdffs  #(3) rd_addr_hi_ff (.*, .din(dccm_rd_addr_hi[DCCM_WIDTH_BITS+:3]), .dout(dccm_rd_addr_hi_q[DCCM_WIDTH_BITS+:3]), .en(~lsu_freeze_dc3), .clk(free_clk));

endmodule // lsu_dccm_mem



// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Western Digital Corporation or its affiliates.
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


`define EH2_LOCAL_DCCM_RAM_TEST_PORTS    .TEST1(dccm_ext_in_pkt[i].TEST1),                      \
                                     .RME(dccm_ext_in_pkt[i].RME),                      \
                                     .RM(dccm_ext_in_pkt[i].RM),                        \
                                     .LS(dccm_ext_in_pkt[i].LS),                        \
                                     .DS(dccm_ext_in_pkt[i].DS),                        \
                                     .SD(dccm_ext_in_pkt[i].SD),                        \
                                     .TEST_RNM(dccm_ext_in_pkt[i].TEST_RNM),            \
                                     .BC1(dccm_ext_in_pkt[i].BC1),                      \
                                     .BC2(dccm_ext_in_pkt[i].BC2),                      \



module eh2_lsu_dccm_mem
import eh2_pkg::*;
//#(
//`include "eh2_param.vh"
 //)
 (
   input logic         clk,                                             // clock
   input logic         active_clk,                                        // clock
   input logic         rst_l,
   input logic         clk_override,                                    // clock override

   input logic         dccm_wren,                                       // write enable
   input logic         dccm_rden,                                       // read enable
   input logic [16-1:0]  dccm_wr_addr_lo,                     // write address
   input logic [16-1:0]  dccm_wr_addr_hi,                     // write address
   input logic [16-1:0]  dccm_rd_addr_lo,                     // read address
   input logic [16-1:0]  dccm_rd_addr_hi,                     // read address for the upper bank in case of a misaligned access
   input logic [39-1:0]  dccm_wr_data_lo,              // write data
   input logic [39-1:0]  dccm_wr_data_hi,              // write data
   input eh2_dccm_ext_in_pkt_t  [8-1:0] dccm_ext_in_pkt,    // the dccm packet from the soc

   output logic [39-1:0] dccm_rd_data_lo,              // read data from the lo bank
   output logic [39-1:0] dccm_rd_data_hi,              // read data from the hi bank

   input  logic         scan_mode
);


   localparam DCCM_WIDTH_BITS = $clog2(4);
   localparam DCCM_INDEX_BITS = (16 - 3 - DCCM_WIDTH_BITS);
   localparam DCCM_INDEX_DEPTH = (((64)*1024)>>($clog2(4)))>>$clog2((8));  // Depth of memory bank


   logic [8-1:0]                                        wren_bank;
   logic [8-1:0]                                        rden_bank;
   logic [8-1:0] [16-1:(3+2)] addr_bank;
   logic [16-1:(3+DCCM_WIDTH_BITS)]           rd_addr_even, rd_addr_odd;
   logic                                                                rd_unaligned, wr_unaligned;
   logic [8-1:0] [39-1:0]              dccm_bank_dout;
   logic [39-1:0]                                      wrdata;

   logic [8-1:0][39-1:0]               wr_data_bank;

   logic [8-1:0]                                        dccm_rd_data_bank_hi, dccm_rd_data_bank_lo;

   logic [(DCCM_WIDTH_BITS+3-1):DCCM_WIDTH_BITS]        dccm_rd_addr_lo_q;
   logic [(DCCM_WIDTH_BITS+3-1):DCCM_WIDTH_BITS]        dccm_rd_addr_hi_q;

   logic [8-1:0]                                        dccm_clken;

   logic                                                                dccm_rd_addr_lo_q2;
   logic                                                                dccm_rd_addr_hi_q2;


   assign rd_unaligned = (dccm_rd_addr_lo[DCCM_WIDTH_BITS+:3] != dccm_rd_addr_hi[DCCM_WIDTH_BITS+:3]);
   assign wr_unaligned = (dccm_wr_addr_lo[DCCM_WIDTH_BITS+:3] != dccm_wr_addr_hi[DCCM_WIDTH_BITS+:3]);


   // 8 Banks, 16KB each (2048 x 72)
   for (genvar i=0; i<8; i++) begin: mem_bank
      assign  wren_bank[i]        = dccm_wren & ((dccm_wr_addr_hi[2+:3] == i) | (dccm_wr_addr_lo[2+:3] == i));
      assign  rden_bank[i]        = dccm_rden & ((dccm_rd_addr_hi[2+:3] == i) | (dccm_rd_addr_lo[2+:3] == i));
      assign  addr_bank[i][(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS] = rden_bank[i] ? (((dccm_rd_addr_hi[2+:3] == i) & rd_unaligned) ?
                                                                                                        dccm_rd_addr_hi[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS] :
                                                                                                        dccm_rd_addr_lo[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS]) :
                                                                                                  (((dccm_wr_addr_hi[2+:3] == i) & wr_unaligned) ?
                                                                                                        dccm_wr_addr_hi[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS] :
                                                                                                        dccm_wr_addr_lo[(3+DCCM_WIDTH_BITS)+:DCCM_INDEX_BITS]);


      assign wr_data_bank[i]     = ((dccm_wr_addr_hi[2+:3] == i) & wr_unaligned) ? dccm_wr_data_hi[39-1:0] : dccm_wr_data_lo[39-1:0];

      // clock gating section
      assign  dccm_clken[i] = (wren_bank[i] | rden_bank[i] | clk_override) ;
      // end clock gating section

`ifdef VERILATOR
        eh2_ram #(DCCM_INDEX_DEPTH,39)  ram (
                                  // Primary ports
                                  .ME(dccm_clken[i]),
                                  .CLK(clk),
                                  .WE(wren_bank[i]),
                                  .ADR(addr_bank[i]),
                                  .D(wr_data_bank[i][39-1:0]),
                                  .Q(dccm_bank_dout[i][39-1:0]),
                                  .ROP ( ),
                                  // These are used by SoC
                                  `EH2_LOCAL_DCCM_RAM_TEST_PORTS
                                  .*
                                  );

`else
      if (DCCM_INDEX_DEPTH == 32768) begin : dccm
         ram_32768x39  dccm_bank (
                                  // Primary ports
                                  .ME(dccm_clken[i]),
                                  .CLK(clk),
                                  .WE(wren_bank[i]),
                                  .ADR(addr_bank[i]),
                                  .D(wr_data_bank[i][39-1:0]),
                                  .Q(dccm_bank_dout[i][39-1:0]),
                                  .ROP ( ),
                                  // These are used by SoC
                                  `EH2_LOCAL_DCCM_RAM_TEST_PORTS
                                  .*
                                  );
      end
      else if (DCCM_INDEX_DEPTH == 16384) begin : dccm
         ram_16384x39  dccm_bank (
                                  // Primary ports
                                  .ME(dccm_clken[i]),
                                  .CLK(clk),
                                  .WE(wren_bank[i]),
                                  .ADR(addr_bank[i]),
                                  .D(wr_data_bank[i][39-1:0]),
                                  .Q(dccm_bank_dout[i][39-1:0]),
                                  .ROP ( ),
                                  // These are used by SoC
                                  `EH2_LOCAL_DCCM_RAM_TEST_PORTS
                                  .*
                                  );
      end
      else if (DCCM_INDEX_DEPTH == 8192) begin : dccm
         ram_8192x39  dccm_bank (
                                 // Primary ports
                                 .ME(dccm_clken[i]),
                                 .CLK(clk),
                                 .WE(wren_bank[i]),
                                 .ADR(addr_bank[i]),
                                 .D(wr_data_bank[i][39-1:0]),
                                 .Q(dccm_bank_dout[i][39-1:0]),
                                 .ROP ( ),
                                 // These are used by SoC
                                 `EH2_LOCAL_DCCM_RAM_TEST_PORTS
                                 .*
                                 );
      end
      else if (DCCM_INDEX_DEPTH == 4096) begin : dccm
         ram_4096x39  dccm_bank (
                                 // Primary ports
                                 .ME(dccm_clken[i]),
                                 .CLK(clk),
                                 .WE(wren_bank[i]),
                                 .ADR(addr_bank[i]),
                                 .D(wr_data_bank[i][39-1:0]),
                                 .Q(dccm_bank_dout[i][39-1:0]),
                                 .ROP ( ),
                                 // These are used by SoC
                                 `EH2_LOCAL_DCCM_RAM_TEST_PORTS
                                 .*
                                 );
      end
      else if (DCCM_INDEX_DEPTH == 3072) begin : dccm
         ram_3072x39  dccm_bank (
                                 // Primary ports
                                 .ME(dccm_clken[i]),
                                 .CLK(clk),
                                 .WE(wren_bank[i]),
                                 .ADR(addr_bank[i]),
                                 .D(wr_data_bank[i][39-1:0]),
                                 .Q(dccm_bank_dout[i][39-1:0]),
                                 .ROP ( ),
                                 // These are used by SoC
                                 `EH2_LOCAL_DCCM_RAM_TEST_PORTS
                                 .*
                                 );
      end
      else if (DCCM_INDEX_DEPTH == 2048) begin : dccm
         ram_2048x39  dccm_bank (
                                 // Primary ports
                              //   .ME(dccm_clken[i]),
                                 .CLK(clk),
                                 .WE(wren_bank[i]),
                                 .ADR(addr_bank[i]),
                                 .D(wr_data_bank[i][39-1:0]),
                                 .Q(dccm_bank_dout[i][39-1:0]),
                           //      .ROP ( ),
                                 // These are used by SoC
                            //        `EH2_LOCAL_DCCM_RAM_TEST_PORTS
                                 .*
                                 );
      end
      else if (DCCM_INDEX_DEPTH == 1024) begin : dccm
         ram_1024x39  dccm_bank (
                                 // Primary ports
                                 .ME(dccm_clken[i]),
                                 .CLK(clk),
                                 .WE(wren_bank[i]),
                                 .ADR(addr_bank[i]),
                                 .D(wr_data_bank[i][39-1:0]),
                                 .Q(dccm_bank_dout[i][39-1:0]),
                                 .ROP ( ),
                                 // These are used by SoC
                                 `EH2_LOCAL_DCCM_RAM_TEST_PORTS
                                 .*
                                 );
      end
      else if (DCCM_INDEX_DEPTH == 512) begin : dccm
         ram_512x39  dccm_bank (
                                // Primary ports
                                .ME(dccm_clken[i]),
                                .CLK(clk),
                                .WE(wren_bank[i]),
                                .ADR(addr_bank[i]),
                                .D(wr_data_bank[i][39-1:0]),
                                .Q(dccm_bank_dout[i][39-1:0]),
                                .ROP ( ),
                                // These are used by SoC
                                `EH2_LOCAL_DCCM_RAM_TEST_PORTS
                                .*
                                );
      end
      else if (DCCM_INDEX_DEPTH == 256) begin : dccm
         ram_256x39  dccm_bank (
                                // Primary ports
                                .ME(dccm_clken[i]),
                                .CLK(clk),
                                .WE(wren_bank[i]),
                                .ADR(addr_bank[i]),
                                .D(wr_data_bank[i][39-1:0]),
                                .Q(dccm_bank_dout[i][39-1:0]),
                                .ROP ( ),
                                // These are used by SoC
                                `EH2_LOCAL_DCCM_RAM_TEST_PORTS
                                .*
                                );
      end
      else if (DCCM_INDEX_DEPTH == 128) begin : dccm
         ram_128x39  dccm_bank (
                                // Primary ports
                                .ME(dccm_clken[i]),
                                .CLK(clk),
                                .WE(wren_bank[i]),
                                .ADR(addr_bank[i]),
                                .D(wr_data_bank[i][39-1:0]),
                                .Q(dccm_bank_dout[i][39-1:0]),
                                .ROP ( ),
                                // These are used by SoC
                                `EH2_LOCAL_DCCM_RAM_TEST_PORTS
                                .*
                                );
      end
`endif // VERILATOR
   end : mem_bank

   // Flops
   rvdffs  #(3) rd_addr_lo_ff (.*, .din(dccm_rd_addr_lo[DCCM_WIDTH_BITS+:3]), .dout(dccm_rd_addr_lo_q[DCCM_WIDTH_BITS+:3]), .en(1'b1), .clk(active_clk));
   rvdffs  #(3) rd_addr_hi_ff (.*, .din(dccm_rd_addr_hi[DCCM_WIDTH_BITS+:3]), .dout(dccm_rd_addr_hi_q[DCCM_WIDTH_BITS+:3]), .en(1'b1), .clk(active_clk));

   // For Plus1 --> Read data comes out 2 cycle after dccm_rden since we need to flop the bank data and then mux between the banks
   
   localparam LOAD_TO_USE_PLUS1=1;
   if (LOAD_TO_USE_PLUS1 == 1) begin: GenL2U_1
      logic                                                          dccm_rden_q;
      logic [8-1:0] [39-1:0]        dccm_bank_dout_q;
      logic [(DCCM_WIDTH_BITS+3-1):DCCM_WIDTH_BITS]  dccm_rd_addr_lo_q2;
      logic [(DCCM_WIDTH_BITS+3-1):DCCM_WIDTH_BITS]  dccm_rd_addr_hi_q2;

      // Mux out the read data
      assign dccm_rd_data_lo[39-1:0]  = dccm_bank_dout_q[dccm_rd_addr_lo_q2[DCCM_WIDTH_BITS+:3]][39-1:0];
      assign dccm_rd_data_hi[39-1:0]  = dccm_bank_dout_q[dccm_rd_addr_hi_q2[DCCM_WIDTH_BITS+:3]][39-1:0];

      for (genvar i=0; i<8; i++) begin: GenBanks
         rvdffe #(39) dccm_bank_dout_ff(.*, .din(dccm_bank_dout[i]), .dout(dccm_bank_dout_q[i]), .en(dccm_rden_q | clk_override));
      end

      rvdff  #(1)                  dccm_rden_ff  (.*, .din(dccm_rden), .dout(dccm_rden_q), .clk(active_clk));
      rvdffs  #(3) rd_addr_lo_ff (.*, .din(dccm_rd_addr_lo_q[DCCM_WIDTH_BITS+:3]), .dout(dccm_rd_addr_lo_q2[DCCM_WIDTH_BITS+:3]), .en(1'b1), .clk(active_clk));
      rvdffs  #(3) rd_addr_hi_ff (.*, .din(dccm_rd_addr_hi_q[DCCM_WIDTH_BITS+:3]), .dout(dccm_rd_addr_hi_q2[DCCM_WIDTH_BITS+:3]), .en(1'b1), .clk(active_clk));
   end else begin
      // mux out the read data
      assign dccm_rd_data_lo[39-1:0]  = dccm_bank_dout[dccm_rd_addr_lo_q[DCCM_WIDTH_BITS+:3]][39-1:0];
      assign dccm_rd_data_hi[39-1:0]  = dccm_bank_dout[dccm_rd_addr_hi_q[DCCM_WIDTH_BITS+:3]][39-1:0];

      assign dccm_rd_addr_lo_q2 = '0;
      assign dccm_rd_addr_hi_q2 = '0;
   end
`undef EH2_LOCAL_DCCM_RAM_TEST_PORTS

endmodule // eh2_lsu_dccm_mem

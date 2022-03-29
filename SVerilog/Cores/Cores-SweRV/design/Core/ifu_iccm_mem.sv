//********************************************************************************
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

//********************************************************************************
// Icache closely coupled memory --- ICCM
//********************************************************************************

module ifu_iccm_mem
   import swerv_types::*;

(
   input logic         clk,
   input logic         free_clk,
   input logic         rst_l,
   input logic         clk_override,

   input logic          iccm_wren,
   input logic          iccm_rden,
   input logic [19-1:2]   iccm_rw_addr,

   input logic [2:0]    iccm_wr_size,
   input logic [77:0]   iccm_wr_data,


   output logic [155:0] iccm_rd_data,
   input  logic         scan_mode

);

//`include "global.h"


   logic [8/4-1:0]               wren_bank;
   logic [8/4-1:0]               rden_bank;
   logic [8/4-1:0]               iccm_hi0_clken;
   logic [8/4-1:0]               iccm_hi1_clken;
   logic [8/4-1:0]               iccm_lo0_clken;
   logic [8/4-1:0]               iccm_lo1_clken;
   logic [8/4-1:0]               iccm_hi0_clk  ;
   logic [8/4-1:0]               iccm_hi1_clk  ;
   logic [8/4-1:0]               iccm_lo0_clk  ;
   logic [8/4-1:0]               iccm_lo1_clk  ;


   logic [8/4-1:0]               wren_bank_hi0;
   logic [8/4-1:0]               wren_bank_lo0;
   logic [8/4-1:0]               wren_bank_hi1;
   logic [8/4-1:0]               wren_bank_lo1;
   logic [8/4-1:0] [14-1:0] addr_bank;



   logic [8/4-1:0] [77:0]   iccm_bank_dout_hi;
   logic [8/4-1:0] [77:0]   iccm_bank_dout_lo;
   logic [5:4]                           iccm_rw_addr_q;
   localparam ICCM_BANK_BITS =3;
    // assign CLK = clk ;


   for (genvar i=0; i<8/4; i++) begin: mem_bank
      assign  wren_bank[i]         = iccm_wren & ( (iccm_rw_addr[5:4] == i) | (ICCM_BANK_BITS == 2));
      assign  rden_bank[i]         = iccm_rden & ( (iccm_rw_addr[5:4] == i) | (ICCM_BANK_BITS == 2));
      assign  wren_bank_hi0[i]      = wren_bank[i] &  iccm_rw_addr[3] & (~iccm_rw_addr[2] | (iccm_wr_size[1:0] == 2'b11));
      assign  wren_bank_hi1[i]      = wren_bank[i] &  iccm_rw_addr[3] & ( iccm_rw_addr[2] | (iccm_wr_size[1:0] == 2'b11));
      assign  wren_bank_lo0[i]      = wren_bank[i] & ~iccm_rw_addr[3] & (~iccm_rw_addr[2] | (iccm_wr_size[1:0] == 2'b11));
      assign  wren_bank_lo1[i]      = wren_bank[i] & ~iccm_rw_addr[3] & ( iccm_rw_addr[2] | (iccm_wr_size[1:0] == 2'b11));

      assign iccm_hi0_clken[i]      =  wren_bank_hi0[i] |  (rden_bank[i] | clk_override);   // Do not override the writes
      assign iccm_hi1_clken[i]      =  wren_bank_hi1[i] |  (rden_bank[i] | clk_override);   // Do not override the writes
      assign iccm_lo0_clken[i]      =  wren_bank_lo0[i] |  (rden_bank[i] | clk_override);   // Do not override the writes
      assign iccm_lo1_clken[i]      =  wren_bank_lo1[i] |  (rden_bank[i] | clk_override);   // Do not override the writes

      rvoclkhdr iccm_hi0_c1_cgc  ( .en(iccm_hi0_clken[i]), .l1clk(iccm_hi0_clk[i]), .* );
      rvoclkhdr iccm_hi1_c1_cgc  ( .en(iccm_hi1_clken[i]), .l1clk(iccm_hi1_clk[i]), .* );
      rvoclkhdr iccm_lo0_c1_cgc  ( .en(iccm_lo0_clken[i]), .l1clk(iccm_lo0_clk[i]), .* );
      rvoclkhdr iccm_lo1_c1_cgc  ( .en(iccm_lo1_clken[i]), .l1clk(iccm_lo1_clk[i]), .* );


      assign  addr_bank[i][14-1:0] = iccm_rw_addr[5-1:(3+2)];

         ram_16384x39 iccm_bank_hi0 (
                                     // Primary ports
                                     .CLK(iccm_hi0_clk[i]),
                                     .WE(wren_bank_hi0[i]),
                                     .ADR(addr_bank[i]),
                                     .D(iccm_wr_data[38:0]),
                                     .Q(iccm_bank_dout_hi[i][38:0])
                                      );
          ram_16384x39 iccm_bank_hi1 (
                                     // Primary ports
                                     .CLK(iccm_hi1_clk[i]),
                                     .WE(wren_bank_hi1[i]),
                                     .ADR(addr_bank[i]),
                                     .D(iccm_wr_data[77:39]),
                                     .Q(iccm_bank_dout_hi[i][77:39])
                                      );
          ram_16384x39 iccm_bank_lo0 (
                                     // Primary ports
                                     .CLK(iccm_lo0_clk[i]),
                                     .WE(wren_bank_lo0[i]),
                                     .ADR(addr_bank[i]),
                                     .D(iccm_wr_data[38:0]),
                                     .Q(iccm_bank_dout_lo[i][38:0])
                                      );
         ram_16384x39 iccm_bank_lo1 (
                                     // Primary ports
                                     .CLK(iccm_lo1_clk[i]),
                                     .WE(wren_bank_lo1[i]),
                                     .ADR(addr_bank[i]),
                                     .D(iccm_wr_data[77:39]),
                                     .Q(iccm_bank_dout_lo[i][77:39])
                                      );


   end : mem_bank


   assign iccm_rd_data[155:0] = (ICCM_BANK_BITS == 2) ?  {iccm_bank_dout_hi[0][77:0], iccm_bank_dout_lo[0][77:0]}   :
                                                           { iccm_bank_dout_hi[iccm_rw_addr_q[5:4]][77:0], iccm_bank_dout_lo[iccm_rw_addr_q[5:4]][77:0] };


 if (ICCM_BANK_BITS == 2) begin
    assign iccm_rw_addr_q[5:4] = 1'b0;
 end
   // 8 banks, each bank 8B, we index as 4 banks
 else begin
  rvdff  #(2) rd_addr_ff (.*, .clk(free_clk), .din(iccm_rw_addr[5:4]), .dout(iccm_rw_addr_q[5:4]) );
 end
endmodule // ifu_iccm_mem



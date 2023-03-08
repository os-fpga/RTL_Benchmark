//------------------------------------------------------------------------------
// Copyright (c) 2013-2017 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           edma_gen_async_fifo_look_ahead.v
//   Module Name:        edma_gen_async_fifo_look_ahead
//
//   Release Revision:   r1p12
//   Release SVN Tag:    gem_gxl_det0102_r1p12
//
//   IP Name:            GEM Gigabit Ethernet MAC
//   IP Part Number:     IP7014
//
//   Product Type:       Off-the-shelf
//   IP Type:            Soft
//   IP Family:          Ethernet Controller
//   Technology:         N/A
//   Protocol:           Ethernet
//   Architecture:       N/A
//   Licensable IP:      SIP-Ethernet-MAC+DMA+1588+TSN+PCS-10M/100M/1G-IP7014
//
//------------------------------------------------------------------------------
//   Description    :
//
// Generic Asynchonous flop based FIFO.
// This FIFO is very similar to the original edma_gen_async_fifo but has an
// additional "look ahead" feature where the contents of the FIFO can be
// matched for a particulare value.  This is necessary for XGM/GEM when this
// FIFO is instantiated in the edma_spram_controller, where the contents of
// this FIFO can be checked for a pending address write for a read address
// that is currently happening.
//
//------------------------------------------------------------------------------


module edma_gen_async_fifo_look_ahead # (

   parameter DATA_W = 8,    // Data width
   parameter ADDR_W = 4'd2, // Address width
   parameter RAM_ADDR_WIDTH = 10,    // Width of ram_addr
   parameter RAM_ADDR_POSITION = 128 // Position of the RAM address within each FIFO word

)(

   // Clock and Reset
   input clk_push,
   input clk_pop,
   input rst_push_n,
   input rst_pop_n,

   // Push Interface
   input push, // Push Data to the FIFO
   input [DATA_W-1:0] pushd, // Push Data
   output push_full, // Full (push side)
   output push_overflow, // Overflow
   output [ADDR_W:0] push_size, // Number of entries (push side) in FIFO

   // Pop Interface
   input pop, // Pop Data from the FIFO
   output [DATA_W-1:0] popd,
   output pop_empty, // Empty (pop side)
   output pop_underflow,
   output [ADDR_W:0] pop_size, // Number of entries (push side) in FIFO

   // Ram inputs (pop_clk) domain
   input                   ram_en,    // RAM Enable
   input                   ram_we,    // RAM Write Enable
   input [RAM_ADDR_WIDTH-1:0] ram_addr,  // Current ram read address
   output reg [RAM_ADDR_POSITION-1:0] ram_do, // Read data for the address at ram_addr
   output                  ram_addr_match  // The FIFO has a pending write for the ram_addr location

   );



   // -----------------------------------------------------------------------
   //
   //                    Internal Signals
   //
   // -----------------------------------------------------------------------



   // Memory array
   reg [DATA_W-1:0] mem [2**ADDR_W-1:0];

   // Pointers. MSB extended to help with wrap-around detecton for
   // full and empty generation
   wire [ADDR_W:0] wr_ptr, wr_ptr_sync;
   wire [ADDR_W:0] rd_ptr, rd_ptr_sync;
   reg [ADDR_W:0] wr_ptr_gray, rd_ptr_gray ;
   wire [ADDR_W:0] wr_ptr_gray_sync, rd_ptr_gray_sync;
   integer j;

   reg [2**ADDR_W-1:0] ram_addr_match_array;
   reg [RAM_ADDR_POSITION-1:0] ram_do_array_nxt  [0:2**ADDR_W-1];


   // -----------------------------------------------------------------------
   //
   //                    Clock Domain Synchronisation
   //
   // -----------------------------------------------------------------------



   cdnsdru_datasync_v1 #(
      .CDNSDRU_DATASYNC_DIN_W(ADDR_W+1)
   ) i_cdnsdru_datasync_v1_wr_ptr_gray (
      .clk(clk_pop),
      .reset_n(rst_pop_n),
      .din(wr_ptr_gray),
      .dout(wr_ptr_gray_sync));

   cdnsdru_datasync_v1 #(
      .CDNSDRU_DATASYNC_DIN_W(ADDR_W+1)
   ) i_cdnsdru_datasync_v1_rd_ptr_gray (
      .clk(clk_push),
      .reset_n(rst_push_n),
      .din(rd_ptr_gray),
      .dout(rd_ptr_gray_sync));

   assign wr_ptr_sync = gray2binary(wr_ptr_gray_sync); // Write pointer in pop domain
   assign rd_ptr_sync = gray2binary(rd_ptr_gray_sync); // Read pointer in push domain



   // -----------------------------------------------------------------------
   //
   //                    Pop Interface
   //
   // -----------------------------------------------------------------------



   // Increment the read pointer at a pop, assuming not empty
   always @ (posedge clk_pop or negedge rst_pop_n)
      if (!rst_pop_n)
         rd_ptr_gray <= {ADDR_W+1{1'b0}};
      else
         // Pop the FIFO, assuming the FIFO is not empty
         if (pop && !pop_empty)
            rd_ptr_gray <= binary2gray(rd_ptr + {{ADDR_W{1'b0}},1'b1});


   assign rd_ptr = gray2binary(rd_ptr_gray);

   // Assign the output Data
   assign popd = mem[rd_ptr[ADDR_W-1:0]];


   // -----------------------------------------------------------------------
   //
   //                    Push Interface
   //
   // -----------------------------------------------------------------------



   always @ (posedge clk_push or negedge rst_push_n)
      if (!rst_push_n) begin
         wr_ptr_gray <= {ADDR_W+1{1'b0}};
         for (j=0; j<2**ADDR_W; j=j+1)
            mem[j] <= {DATA_W{1'b0}};
      end
      else begin
         // Write data and increment the counters when we are not full
         if (push && !push_full) begin
            wr_ptr_gray             <= binary2gray(wr_ptr + {{ADDR_W{1'b0}},1'b1});
            mem[wr_ptr[ADDR_W-1:0]] <= pushd;
         end
      end

   assign wr_ptr = gray2binary(wr_ptr_gray);



   // -----------------------------------------------------------------------
   //
   //                    Status Flags
   //
   // -----------------------------------------------------------------------


   assign push_full = (wr_ptr[ADDR_W-1:0] == rd_ptr_sync[ADDR_W-1:0]) &&
                      (wr_ptr[ADDR_W]     != rd_ptr_sync[ADDR_W]);
   assign pop_empty = (rd_ptr[ADDR_W-1:0] == wr_ptr_sync[ADDR_W-1:0]) &&
                      (rd_ptr[ADDR_W]     == wr_ptr_sync[ADDR_W]);

   assign push_size = wr_ptr - rd_ptr_sync;
   assign pop_size = wr_ptr_sync - rd_ptr;


   assign push_overflow = push_full & push;

   assign pop_underflow = pop_empty & pop;



   // -----------------------------------------------------------------------
   //
   //                    Binary & Gray Converter Functions
   //
   // -----------------------------------------------------------------------


   function [ADDR_W:0] binary2gray; // Binary to Gray code conversion
      input [ADDR_W:0] bin;

      binary2gray = (bin>>1) ^ bin;

   endfunction


   function [ADDR_W:0] gray2binary; // Gray to Binary code conversion
      input [ADDR_W:0] gray;

      integer i;
      reg result;

      for (i=0; i<=ADDR_W; i=i+1) begin
        result = ^(gray>>i);
        gray2binary[i] = result;
      end

   endfunction


   // -----------------------------------------------------------------------
   //
   //                    RAM Address Matching
   //
   // -----------------------------------------------------------------------


   // RAM Address matching - does the FIFO contain a pending data write for
   // the ram read currenlty taking place at ram_addr

   genvar I;
   generate for (I=0; I<2**ADDR_W; I=I+1) begin : gen_ram_addr_match
     integer rd_ptr_p_addr;
     wire [31:0] index_p1;
     assign      index_p1 = I + {{(ADDR_W-1){1'b0}}, 1'b1};
     
     always @(*) rd_ptr_p_addr = (rd_ptr+I) & {{(32-ADDR_W){1'b0}},{ADDR_W{1'b1}}};
     always @(*) begin

         //default to non-matching
         ram_addr_match_array[I] = 1'b0;
         ram_do_array_nxt[I] = {RAM_ADDR_POSITION{1'b0}};

         // Ensure the RAM has valid entries as we don't want to check empty locations
         if (pop_size >= index_p1[ADDR_W:0])
            // Do we have a pending write for the current read address
            if (mem [rd_ptr_p_addr[ADDR_W-1:0]][RAM_ADDR_POSITION+RAM_ADDR_WIDTH-1:RAM_ADDR_POSITION] == ram_addr) begin
               ram_addr_match_array[I] = 1'b1;
               ram_do_array_nxt[I] = mem [rd_ptr_p_addr[ADDR_W-1:0]] [RAM_ADDR_POSITION-1:0];
            end
     end

   end
   endgenerate

   assign ram_addr_match = (ram_en && !ram_we) ? |ram_addr_match_array : 1'b0;

   always @(posedge clk_pop or negedge rst_pop_n)
   begin
     if (~rst_pop_n)
        ram_do <= {RAM_ADDR_POSITION{1'b0}};
     else
        ram_do <= ram_do_array_nxt[3] | ram_do_array_nxt[2] | ram_do_array_nxt[1] | ram_do_array_nxt[0];
   end


  `ifdef ABV_ON

  // Assertions to check that the counters to synchronise really are gray coded.
  // i.e. ensure that each cycle no more than 1 bit changes. Note that there can
  // be 0 bit changes.
  property wptr_is_gray;
    @(posedge clk_push) disable iff ((rst_push_n != 1'b1))
      $countones(wr_ptr_gray ^ $past(wr_ptr_gray)) <= 1;
  endproperty
  a_wptr_is_gray  : assert property (wptr_is_gray);

  property rptr_is_gray;
    @(posedge clk_pop) disable iff ((rst_pop_n != 1'b1))
      $countones(rd_ptr_gray ^ $past(rd_ptr_gray)) <= 1;
  endproperty
  a_rptr_is_gray  : assert property (rptr_is_gray);

  `endif

endmodule

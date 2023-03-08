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
//   Filename:           edma_gen_async_fifo.v
//   Module Name:        edma_gen_async_fifo
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
//
//------------------------------------------------------------------------------


module edma_gen_async_fifo # (

   parameter DATA_W = 32'd8, // Data width
   parameter ADDR_W = 32'd2, // Address width. Note. If a single location FIFO
                             // is required then set this to 0.
   parameter DEPTH = 2**ADDR_W, // Note. Depth should only be used in the case
                                // when a 1 deep FIFO is need - i.e. when ADDR_W
                                // is set to 0. In this case depth should be set to
                                // 1. Otherwise depth is the default 2**ADDR_w
   parameter REG_OUTPUT_STAGE = 1'b0, // Create an additional register stage on the
                                      // output of the FIFO. When a read takes place
                                      // the ouptut will be placed in this register
                                      // until another read takes place.
   parameter RESET_VAL = {DATA_W{1'b0}} // Only valid when ADD_REG_OUTPUT_STAGE is set. Sets
                                        // the reset value of the output register
                                        // when this option is set.


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
   output reg [DATA_W-1:0] popd, // Pop Data
   output pop_empty, // Empty (pop side)
   output pop_underflow,
   output [ADDR_W:0] pop_size // Number of entries (push side) in FIFO

   );



   // -----------------------------------------------------------------------
   //
   //                    Internal Signals
   //
   // -----------------------------------------------------------------------



   // Memory array
   reg [DATA_W-1:0] mem [DEPTH-1:0];

   // Pointers. MSB extended to help with wrap-around detecton for
   // full and empty generation
   wire [ADDR_W:0] wptr, wptr_sync,wptr_p1;
   wire [ADDR_W:0] rptr, rptr_sync,rptr_p1;
   reg  [ADDR_W:0] wptr_gray;
   wire [ADDR_W:0] wptr_gray_sync;
   reg [ADDR_W:0] rptr_gray;
   wire [ADDR_W:0] rptr_gray_sync;


   // -----------------------------------------------------------------------
   //
   //                    Clock Domain Synchronisation
   //
   // -----------------------------------------------------------------------



   cdnsdru_datasync_v1 #(
      .CDNSDRU_DATASYNC_DIN_W(ADDR_W+1)
   ) i_cdnsdru_datasync_v1_wptr_gray (
      .clk(clk_pop),
      .reset_n(rst_pop_n),
      .din(wptr_gray),
      .dout(wptr_gray_sync));

   cdnsdru_datasync_v1 #(
      .CDNSDRU_DATASYNC_DIN_W(ADDR_W+1)
   ) i_cdnsdru_datasync_v1_rptr_gray (
      .clk(clk_push),
      .reset_n(rst_push_n),
      .din(rptr_gray),
      .dout(rptr_gray_sync));

   assign wptr_sync = (ADDR_W == 32'd0) ? wptr_gray_sync : gray2binary(wptr_gray_sync); // Write pointer in pop domain
   assign rptr_sync = (ADDR_W == 32'd0) ? rptr_gray_sync : gray2binary(rptr_gray_sync); // Read pointer in push domain



   // -----------------------------------------------------------------------
   //
   //                    Pop Interface
   //
   // -----------------------------------------------------------------------


   // Increment the read pointer at a pop, assuming not empty
   always @ (posedge clk_pop or negedge rst_pop_n)
      if (!rst_pop_n)
         rptr_gray <= {(ADDR_W+1){1'b0}};
      // Pop the FIFO, assuming the FIFO is not empty
      else if (pop && !pop_empty) begin
        if (ADDR_W == 32'd0)
         rptr_gray <= rptr_p1;
        else
         rptr_gray <= binary2gray(rptr_p1);
      end

   assign rptr = (ADDR_W == 32'd0) ? rptr_gray : gray2binary(rptr_gray);

   // Assign the output Data. Also need to take into account the
   // special case when the fifo is only 1 location deep and
   // add an ouput staage if selected
   generate if (ADDR_W == 32'd0 && REG_OUTPUT_STAGE == 1'b0) 
   begin : gen_addrw0_out_reg0
    always @(*) popd = mem[0];
   end
   else if (REG_OUTPUT_STAGE == 1'b0) begin: gen_out_reg0
    always @(*) popd = mem[rptr[ADDR_W-1:0]];
   end
   else if (ADDR_W == 32'd0 && REG_OUTPUT_STAGE == 1'b1) begin: gen_addrw0_out_reg1
    always @ (posedge clk_pop or negedge rst_pop_n)
    begin
      if (!rst_pop_n)
         popd <= RESET_VAL;
      // Populate the output buffer at a valid read.
      else if (pop && !pop_empty)
         popd <= mem[0];
    end      
   end
   else if (REG_OUTPUT_STAGE == 1'b1) begin: gen_out_reg1
    always @ (posedge clk_pop or negedge rst_pop_n)
    begin
      if (!rst_pop_n)
         popd <= RESET_VAL;
      // Populate the output buffer at a valid read.
      else if (pop && !pop_empty)
         popd <= mem[rptr[ADDR_W-1:0]];
    end      
   end
   endgenerate



   // -----------------------------------------------------------------------
   //
   //                    Push Interface
   //
   // -----------------------------------------------------------------------


   // Increment the write pointer at a push, assuming not full
   always @ (posedge clk_push or negedge rst_push_n)
      if (!rst_push_n)
         wptr_gray <= {(ADDR_W+1){1'b0}};
      // Write data and increment the counters when we are not full
      else if (push && !push_full) begin
        if (ADDR_W == 32'd0)
         wptr_gray <= wptr_p1;
        else
         wptr_gray <= binary2gray(wptr_p1);
      end

   assign wptr = (ADDR_W == 32'd0) ? wptr_gray : gray2binary(wptr_gray);

   generate if (ADDR_W == 32'd0) begin : gen_p1_ptrs_addrw0
     assign wptr_p1 = wptr+1'b1;
     assign rptr_p1 = rptr+1'b1;
   end
   else begin: gen_p1_ptrs_addrw_not0
     assign wptr_p1 = wptr+{{ADDR_W{1'b0}},1'b1};
     assign rptr_p1 = rptr+{{ADDR_W{1'b0}},1'b1};
   end
   endgenerate


   // Assign the output Data. Also need to take into account the
   // special case when the fifo is only 1 location deep
   generate if (ADDR_W == 32'd0) begin : gen_mem_single_depth

      always @ (posedge clk_push or negedge rst_push_n)
         if (!rst_push_n)
            mem[0] <= {DATA_W{1'b0}};
         // Write data and increment the counters when we are not full
         else if (push && !push_full)
            mem[0] <= pushd;

   end
   else begin : gen_mem
      integer j;

      always @ (posedge clk_push or negedge rst_push_n)
         if (!rst_push_n)
            for (j=0; j<DEPTH; j=j+1)
               mem[j] <= {DATA_W{1'b0}};
         // Write data and increment the counters when we are not full
         else if (push && !push_full)
            mem[wptr[ADDR_W-1:0]] <= pushd;

   end
   endgenerate


   // -----------------------------------------------------------------------
   //
   //                    Status Flags
   //
   // -----------------------------------------------------------------------


   // Generate the output flags but also take into account the corner case
   // where the FIFO is only one deep.
   generate if (ADDR_W == 32'd0) begin: gen_flags_addrw0
      assign push_full = (wptr[ADDR_W]     != rptr_sync[ADDR_W]);
      assign pop_empty = (rptr[ADDR_W]     == wptr_sync[ADDR_W]);
   end
   else begin: gen_flags_addrw_not0
      assign push_full = (wptr[ADDR_W-1:0] == rptr_sync[ADDR_W-1:0]) &&
                         (wptr[ADDR_W]     != rptr_sync[ADDR_W]);
      assign pop_empty = (rptr[ADDR_W-1:0] == wptr_sync[ADDR_W-1:0]) &&
                         (rptr[ADDR_W]     == wptr_sync[ADDR_W]);
   end
   endgenerate


   assign push_size = wptr - rptr_sync;
   assign pop_size = wptr_sync - rptr;


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


  `ifdef ABV_ON

  // Assertions to check that the counters to synchronise really are gray coded.
  // i.e. ensure that each cycle no more than 1 bit changes. Note that there can
  // be 0 bit changes.
  property wptr_is_gray;
    @(posedge clk_push) disable iff ((rst_push_n != 1'b1))
      $countones(wptr_gray ^ $past(wptr_gray)) <= 1;
  endproperty
  a_wptr_is_gray  : assert property (wptr_is_gray);

  property rptr_is_gray;
    @(posedge clk_pop) disable iff ((rst_pop_n != 1'b1))
      $countones(rptr_gray ^ $past(rptr_gray)) <= 1;
  endproperty
  a_rptr_is_gray  : assert property (rptr_is_gray);

  `endif

endmodule


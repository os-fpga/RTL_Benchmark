//------------------------------------------------------------------------------
// Copyright (c) 2006-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_pbuf_dpram_width_upsize.v
//   Module Name:        edma_pbuf_dpram_width_upsize
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
// Description    :
//
// Very simple block that upsizes the input data width to the width of the
// output data.
// This block was initially used in the pbuf_tx_wr block to upsize the ahb/axi
// data bus width to the dpram data width - i.e. the ahb could have a width
// of 64 bits and the dpram could have a width of 128 bits. In this case this
// block produces one 128 bit write for 2 64 bit writes, with the first 64 bit
// access being stored locally and at the second 64 bit access, both the first
// (stored) and second accesses are written out simultaneously.
//
// Note. The fact that the input width is configured on a port and the output
// width is configured via a parameter is down to the pbuf dma
// inmplementation, as the dma_bus_width is configured via register access and
// is not hard coded.
//
//------------------------------------------------------------------------------
// Limitations    :
//
// The block currenlty only upsizes from the input to the output data
// width....it will not downsize if the output data width is greater
// than the input data width.
//
//----------------------------------------------------------------------------


module edma_pbuf_dpram_width_upsize # (

   parameter       ODATA_W      = 32'd128,
   parameter [7:0] ODATA_W_PAR  = ODATA_W/8

   ) (

      input clk,
      input reset_n,

      input iwr,
      input [143:0] idata,  // 128 bits of data
                            // 16 bits of parity
      input [1:0] iwidth,
      input [3:0] imod, // Number of valid bytes at incoming write.
                        // 0-indicates that all bytes are valid.
      input ieop,
      input isop,
      input iflush,

      output owr,
      output osop, // The current word write contains a sop
      output [ODATA_W_PAR+ODATA_W-1:0] odata,  // ODATA_W bits of data
                                               // ODATA_W_PAR bits of parity
      output reg [3:0] omod // Number of valid bytes at incoming write

   );


   // -----------------------------------------------------------------------
   //
   //                Internal Signals & Definitions
   //
   // -----------------------------------------------------------------------


   localparam WIDTH_32 = 2'b00;
   localparam WIDTH_64 = 2'b01;
   localparam WIDTH_128 = 2'b10;

   reg  [3:0]   mod_previous;
   wire [5:0]   mod_current;
   reg  [4:0]   imod_normalized;
   reg  [3:0]   omod_reg;
   reg          osop_next;
   reg  [143:0] odata_pad;  // 128 bits data
                            // 16 bits of parity
   wire         full;



   // -----------------------------------------------------------------------
   //
   //                Number of valid bytes at current write
   //
   // -----------------------------------------------------------------------

   // A 0 indicates that all bytes are valid at the current write. We need a
   // count of how many bytes are valid without the 0 factor, so generate
   // a raw count value.

   always @(*)
      case (iwidth)
         WIDTH_32  : if (imod==4'h0) imod_normalized = 5'd4; else imod_normalized = {1'b0, imod};
         WIDTH_64  : if (imod==4'h0) imod_normalized = 5'd8; else imod_normalized = {1'b0, imod};
         default   : if (imod==4'h0) imod_normalized = 5'd16; else imod_normalized = {1'b0, imod};
      endcase



   // -----------------------------------------------------------------------
   //
   //     Count number of valid bytes in the word and perform a write
   //
   // -----------------------------------------------------------------------

   // Simple process to count the number of bytes valid at the last buffer
   // write

   assign mod_current = mod_previous + imod_normalized;
   // When the output width is not 128 we always do a write on each
   // access and don't have to do a width adjustment. Otherwise we
   // always do a write when full - i.e. when we have 16 bytes
   // (mod_current[4]) ready to be written.
   assign full = mod_current[4] | ODATA_W != 32'd128;

   always @(posedge clk or negedge reset_n)

      if (~reset_n)
         mod_previous <= 4'd0;
      else
         if (ieop | iflush)
            mod_previous <= 4'd0;
         else if (iwr) begin
            // If the current write fills the buffer then reset
            // the counter.
            if (full)
               mod_previous <= 4'd0;
            else
               mod_previous <= mod_current[3:0];
         end
   assign owr = (full | ieop) & iwr;



   // -----------------------------------------------------------------------
   //
   //      Determine the number of valid bytes in the 128b word
   //
   // -----------------------------------------------------------------------


   // For omod we want to identify the number of validy bytes in the
   // current word and to hold that value after the access, assuming another
   // access does not come in immediately after the current access.
   always @(posedge clk or negedge reset_n)
      if (~reset_n)
         omod_reg <= 4'd0;
      else if (iwr)
         omod_reg <= mod_current[3:0];
   // Set the output mod data and mask off the top bits when in
   // low bus widths.
   wire [3:0] omod_local = (iwr) ? mod_current[3:0] : omod_reg;
   // Mask off the top bits when we are in a mode that is not 128b mode.

   always @(*)
   begin
    if (ODATA_W == 32'd128)
      omod = omod_local;
    else if (iwidth == WIDTH_32)
      omod = {2'b00, omod_local[1:0]};
    else if (iwidth == WIDTH_64)
      omod = { 1'b0, omod_local[2:0]};
    else
      omod = omod_local;
   end


   // -----------------------------------------------------------------------
   //
   // Store the incomding data if it's not written out and write out aligned
   //
   // -----------------------------------------------------------------------

  generate if (ODATA_W == 32'd128) begin : gen_odata_w_128

   reg  [107:0]  idata_buffer;  // 96 bits data
                                // 12 bits of parity

   // We will do one large 128 bit write at the end, so store the incoming
   // data (either 32 or 64 bits at at time) until we can do a full 128b
   // write.
   always @(posedge clk or negedge reset_n)
      if (~reset_n)
         idata_buffer <= {12'h000,96'd0};
      else
         if (iwr) begin
            if (iwidth == WIDTH_64) begin
               idata_buffer[63:0]   <= idata[63:0];
               idata_buffer[103:96] <= idata[135:128]; // parity of idata[63:0]
            end else
               case (mod_previous[3:2])
                  2'b00   : begin
                              idata_buffer[31:0]    <= idata[31:0];
                              idata_buffer[99:96]   <= idata[131:128];      // parity of idata[31:0]
                            end
                  2'b01   : begin
                              idata_buffer[63:32]    <= idata[31:0];
                              idata_buffer[103:100]  <= idata[131:128];     // parity of idata[31:0]
                            end
                  default : begin
                              idata_buffer[95:64]    <= idata[31:0];
                              idata_buffer[107:104]  <= idata[131:128];     // parity of idata[31:0]
                            end
               endcase
         end


   // Depending on the currenct number of bytes stored, align the input data
   // to the appropriate output slice.
   always @(*)
        if (iwidth == WIDTH_32)
         casex (mod_current[4:0]-5'd1)
            5'b000XX : odata_pad = {12'h000,idata[131:128],96'd0, idata[31:0]};
            5'b001XX : odata_pad = {8'h00, idata[131:128], idata_buffer[99:96],64'd0, idata[31:0], idata_buffer[31:0]};
            5'b010XX : odata_pad = {4'h0, idata[131:128], idata_buffer[103:96],32'd0, idata[31:0], idata_buffer[63:0]};
            default  : odata_pad = {idata[131:128], idata_buffer[107:96],idata[31:0], idata_buffer[95:0]};
         endcase
      else if (iwidth == WIDTH_64)
         casex (mod_current[4:0]-5'd1)
            5'b00XXX : odata_pad = {8'h00,idata[135:128],64'd0,idata[63:0]};
            default  : odata_pad = {idata[135:128], idata_buffer[103:96],idata[63:0], idata_buffer[63:0]};
         endcase
      else // Can't happen
         odata_pad = idata;
  end else begin : gen_no_odata_w_128
    always @(*) odata_pad = idata;
  end
  endgenerate

  generate if (ODATA_W_PAR == 8'd0) begin : gen_no_parity
    assign odata = odata_pad[ODATA_W-1:0];
  end else begin : gen_parity
    assign odata[ODATA_W-1:0] = odata_pad[ODATA_W-1:0];
    assign odata[ODATA_W_PAR+ODATA_W-1:ODATA_W] = odata_pad[ODATA_W_PAR+128-1:128];
  end
  endgenerate

   // -----------------------------------------------------------------------
   //
   //              Does the output word contain a sop
   //
   // -----------------------------------------------------------------------

   always @(posedge clk or negedge reset_n)
      if (~reset_n)
         osop_next <= 1'b0;
      else
         if (iwr & ~owr & isop)
            osop_next <= 1'b1;
         else if (owr)
            osop_next <= 1'b0;

   assign osop = (owr&isop) | osop_next;


endmodule

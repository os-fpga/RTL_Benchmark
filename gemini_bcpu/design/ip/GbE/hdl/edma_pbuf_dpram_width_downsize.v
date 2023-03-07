//------------------------------------------------------------------------------
// Copyright (c) 2012-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_pbuf_dpram_width_downsize.v
//   Module Name:        edma_pbuf_dpram_width_downsize
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
// The purpose of this block is to downsize the input data to the output data
// width - i.e. the typically scenario for the block is for an input data
// width of 128 and the block will downsize to an output width of 32/64.
//
// To aid the understanding of this block the internal timings are as follows
// (note. the diagram uses a 32 bit dma bus width and has the eop at the 70th
// byte for example....i.e. on the second 32 bit word of a 4,32 bit word read):
//               _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _
// clk         _| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_
//                       ___         ___         ___         ___         ___
// ird         _________|   |_______|   |_______|   |_______|   |_______|   |___
//                       ___                                             ___
// dpram read  _________|   |___________________________________________|   |___
// (external)  _____________ ___________ ___________ ___________ ___________ ___
// word_ptr    _____4_______X_____0_____X_____1_____X____2______X____3______X___3
// (init'd to 4)                         ___________
// oeop        _________________________|           |___________________________
//             _____________                                     ___________
// oempty                   |___________________________________|           |___
//             _________________-_______________________________________________
// idata       _________________X___________AAAABBBBCCCCDDDD____________________
//             _________________-_______ ___________ ___________ ___________ ___
// odata       _________________X_DDDD__X____CCCC___X____BBBB___X___AAAA____X___
//             _____________ ___________ ___________ ___________ ___________ ___
// size        _____4_______X_____3_____X_____2_____X____1______X____0______X___3
//
// Note. In the above diagram a dpram read is assumed to happen when the
// oempty signal is active.
//
// For a dma bus width of 64 we have the following operation:
//               _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _
// clk         _| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_
//                       ___         ___         ___         ___         ___
// ird         _________|   |_______|   |_______|   |_______|   |_______|   |___
//                       ___                     ___                     ___
// dpram read  _________|   |___________________|   |___________________|   |___
// (external)  _____________ ___________ ___________ ___________ ___________ ___
// word_ptr    _____4_______X_____0_____X_____2_____X____0______X____2______X___
// (init'd to 4)                         ___________             ___________
// oeop        _________________________|           |___________|           |___
//             _____________                                     ___________
// oempty                   |___________________________________|           |___
//             _________________-_______________________ _______________________
// idata       _________________X_0011223344556677______X_8899AABBCCDDEEFF______
//             _________________-_______ _______________ _______ ___________ ___
// odata       _________________X_0..3__X__44556677_____X_8..B__X_CCDDEEFF__X___
//             _____________ ___________ ___________ ___________ ___________ ___
// size        _____2_______X_____1_____X_____0_____X____1______X____0______X___
//
//
//------------------------------------------------------------------------------


module edma_pbuf_dpram_width_downsize # (

   parameter IDATA_W     = 32'd128,
   parameter IDATA_W_PAR = 8'd16,
   parameter ODATA_W     = 32'd64,
   parameter ODATA_W_PAR = 8'd8,
   parameter IDATA_PIPELINE_DEPTH = 32'd2 // Determine the number of cycles after
                                          // ird (at a read) that the input data is
                                          // valid.

   ) (

   input clk,
   input reset_n,

   input [1:0] dma_bus_width,

   input ird,
   input [IDATA_W_PAR+IDATA_W-1:0] idata, // data at bits  : IDATA_W-1:0
                                          // parity at bits: IDATA_W_PAR+IDATA_W-1:IDATA_W
   input [3:0] imod, // Number of bytes at the eop. 0=16, 1=1, 2=2, etc
   input iflush,
   input iflush_nxt,

   output [2:0] size, // Number of 32/64 bit words currently in the buffer.
                      // Note. Initialised to 2 or 4 (bus widh depending)
                      // after a reset or flush (see timing diagram for more
                      // details.
   output ord,
   output [ODATA_W_PAR+ODATA_W-1:0] odata, // data at bits  : ODATA_W-1:0
                                           // parity at bits: ODATA_W_PAR+ODATA_W-1:ODATA_W
   output oempty, // The local buffer is currently empty
   output oempty_next, // The next read will take the buffer to empty
   output reg oeop, /// The current data contains the eop for the packet. Note.
                    /// oeop is signalled at the pertinent slice within each
                    /// 128b access and is not signalled on the very last 128b
                    /// only. It's up to external logic to determine what 128b
                    /// is the last access. This can be seen clearly in the 64b
                    /// timing diagram above.
   output reg oeop_next
);



   // -----------------------------------------------------------------------
   //
   //                Internal Signals & Definitions
   //
   // -----------------------------------------------------------------------

   localparam WIDTH_32 = 2'b00;
   localparam WIDTH_64 = 2'b01;
   localparam WIDTH_128 = 2'b10;

   reg [2:0] word_ptr [IDATA_PIPELINE_DEPTH-1:0];
   reg [2:0] word_ptr_0_next;
   reg [IDATA_PIPELINE_DEPTH-1:0] ird_reg, oempty_reg;
   reg [107:0] idata_buffer; // 96 data bits
                             // 16 parity bits
   wire [109:0] idata_pad; // 96 data bits (bit 96 unused)
                           // 16 parity bits (bit 109 unused)
   reg  [145:0] odata_pad; // 128 data bits (bit 128 unused)
                           // 16 parity bits (bit 145 unused)

   wire bypassed;
   // -----------------------------------------------------------------------
   //
   //                Point to the current valid word
   //
   // -----------------------------------------------------------------------

   // Is this block bypassed - i.e. is the input data width the same as the
   // output data width so there is no need to downsize
   assign bypassed = IDATA_W != 32'd128 || dma_bus_width == WIDTH_128;

   // The input 128 bit data can be split up into a maximum of 4 words - 4
   // words for 32 bit output mode and 2 words for 64 bit output mode. The
   // pointer (word_ptr) points to these 4 words using 0,1,2,3 for 32 bit mode
   // and 0, 2 for 64 bit mode. The counter is also initialised to 4 as there
   // are effectivley to cases where emtpy (or a new read) occurs - i.e. when,
   // using 32 bit mode as an example, 4 words have been read or when we have
   // been reset or flushed. We want to distinguish between the modes to avoid
   // and false eop signalling.

   always @(*)
      if (bypassed)
         word_ptr_0_next = 3'b100;
      else if (iflush) begin
         if (ird)
            word_ptr_0_next = 3'd0;
         else
            word_ptr_0_next = 3'b100;
      end
      else if (ird) begin
         // Add 1 or 2 depending on the bus width
         if (dma_bus_width == WIDTH_64)
            word_ptr_0_next = (word_ptr[0] == 3'd2 || word_ptr[0] == 3'd4) ? 3'd0 : 3'd2;
         else
            word_ptr_0_next = (word_ptr[0] == 3'd3 || word_ptr[0] == 3'd4) ? 3'd0 : word_ptr[0]+3'd1;
      end
      else
         word_ptr_0_next = word_ptr[0];

   always@(posedge clk or negedge reset_n)
      if (~reset_n)
         word_ptr[0] <= 3'd4;
      else
         word_ptr[0] <= word_ptr_0_next;

   // As above, 0 acts as as initialisation, so 0 or 4 indicatedthat a new read
   // is necessary.
   assign oempty      = word_ptr[0]     == 3'd4 || word_ptr[0]     == 3'd3 || (word_ptr[0]==3'd2     && dma_bus_width==WIDTH_64) || bypassed || iflush;
   assign oempty_next = word_ptr_0_next == 3'd4 || word_ptr_0_next == 3'd3 || (word_ptr_0_next==3'd2 && dma_bus_width==WIDTH_64) || bypassed || iflush_nxt;

   // When we do a read we wil always get output data
   assign ord = ird;


   // -----------------------------------------------------------------------
   //
   //             Buffer input data and select output slice
   //
   // -----------------------------------------------------------------------


   // Buffer the input data.
   generate if (IDATA_W>32'd32) begin : gen_idata_pad_gt32
     if(IDATA_W_PAR == 8'd0) begin : gen_no_parity
       // no parity generation
       assign idata_pad = {13'd0,                                  // the parity bits padded to 13 bits (bit 13) unused
                          {(129-IDATA_W){1'b0}}, idata[IDATA_W-1:32]};  // the data bits padded to 97 bits (bit 97) unused.
     end else begin : gen_parity
       // The parity is included
       assign idata_pad = {{(17-IDATA_W_PAR){1'b0}}, idata[IDATA_W_PAR+IDATA_W-1:IDATA_W+4], // the parity bits padded to 13 bits (bit 13) unused
                            {(129-IDATA_W){1'b0}}, idata[IDATA_W-1:32]};                     // the data bits padded to 97 bits (bit 97) unused.
     end
   end
   endgenerate
   generate if (IDATA_W<=32) begin : gen_idata_pad_lt32
     assign idata_pad = {13'd0,    // the parity bits padded to 13 bits (bit 13) unused
                          97'd0};  // the data bits padded to 97 bits (bit 97) unused.
   end
   endgenerate
   always @(posedge clk or negedge reset_n)
      if (~reset_n) begin
         idata_buffer <= {12'd0,96'd0};                      // reset value for parity + data
      end
      else begin
         if (bypassed)
            idata_buffer <= {12'd0,96'd0};                    // reset value for parity + data
         else if (ird_reg[IDATA_PIPELINE_DEPTH-1] & oempty_reg[IDATA_PIPELINE_DEPTH-1])
            idata_buffer <= {idata_pad[108:97],                // only 12 parity bits passed
                             idata_pad[95:0]};                 // only 96 data bits passed
      end

   generate if (IDATA_PIPELINE_DEPTH>32'd1) begin : gen_ird_reg_depth_gt1
      always @(posedge clk or negedge reset_n)
         if (~reset_n) begin
            ird_reg <= {IDATA_PIPELINE_DEPTH{1'b0}};
            oempty_reg <= {IDATA_PIPELINE_DEPTH{1'b0}};
         end
         else begin
            ird_reg <= {ird_reg[IDATA_PIPELINE_DEPTH-2:0], ird};
            oempty_reg <= {oempty_reg[IDATA_PIPELINE_DEPTH-2:0], oempty};
         end
   end
   endgenerate

   generate if (IDATA_PIPELINE_DEPTH==32'd1) begin : gen_ird_reg_depth_eq1
      always @(posedge clk or negedge reset_n)
         if (~reset_n) begin
            ird_reg <= 1'b0;
            oempty_reg <= 1'b0;
         end
         else begin
            ird_reg <= ird;
            oempty_reg <= oempty;
         end
   end
   endgenerate

   // Generate the pipelined word pointers
   generate if (IDATA_PIPELINE_DEPTH>32'd1) begin : gen_word_ptr_pipeline
     integer i;
      always @(posedge clk or negedge reset_n)
         if (~reset_n)
            for (i=1; i<IDATA_PIPELINE_DEPTH; i=i+1)
               word_ptr[i] <= 3'b000;
         else
            for (i=1; i<IDATA_PIPELINE_DEPTH; i=i+1)
               word_ptr[i] <= word_ptr[i-1];
   end
   endgenerate

   wire  [145:0] odata_pad_bypassed;
   wire  [145:0] odata_pad_WIDTH_64_word_ptr_non_zero;
   wire  [145:0] odata_pad_case_zero;
   generate if(IDATA_W_PAR == 8'd0) begin : gen_odata_pad_nz_noparity
     // Only data path (reset are zeros)
     // the bits of the parity are zero
     assign odata_pad_bypassed = { 17'd0,                                                 // no parity protection: the parity pad is zero
                                   {(129-IDATA_W){1'b0}},idata[IDATA_W-1:0]};             // the data bits padded to 128 bits (bit 128 unused).
     assign odata_pad_WIDTH_64_word_ptr_non_zero =  { 17'd0,                              // no parity protection: the parity pad is zero
                                                      65'd0,idata_buffer[95:32]};         // 64 bits of data passed
                                                                                          // the data bits padded to 128 bits (bit 128 unused).
     assign odata_pad_case_zero = { 17'd0,                                                // no parity protection: the parity pad is zero
                                    97'd0,idata[31:0]};                                   // 32 bits of data passed
                                                                                          // the data bits padded to 128 bits (bit 128 unused).
   end else begin : gen_odata_pad_nz_parity
    // data and parity is passed
    assign odata_pad_bypassed = { {(17-IDATA_W_PAR){1'b0}},idata[IDATA_W_PAR+IDATA_W-1:IDATA_W],       // the parity bits padded to 17 bits (bit 145) unused
                                  {(129-IDATA_W){1'b0}},idata[IDATA_W-1:0]};                           // the data bits padded to 128 bits (bit 128) unused.
    assign odata_pad_WIDTH_64_word_ptr_non_zero = { 9'd0,idata_buffer[107:100],                        // 8 bits of the parity bits padded to 17 bits (bit 145 unused)
                                                    65'd0,idata_buffer[95:32]};                        // 64 bits of the data bits padded to 128 bits (bit 128 unused).
    assign odata_pad_case_zero = { 13'd0,idata[IDATA_W+4-1:IDATA_W],                                   // 4 bits of the parity bits padded to 17 bits (bit 145 unused)
                                   97'd0,idata[31:0]};                                                 // 32 bits of the data bits padded to 128 bits (bit 128 unused).
   end
   endgenerate

   wire  [145:0] odata_pad_WIDTH_64_word_ptr_zero;
   generate if (ODATA_W_PAR == 8'd0) begin : gen_odata_pad_noparity
     assign odata_pad_WIDTH_64_word_ptr_zero =  { 17'd0,                                             // no parity protection: the parity pad is zero
                                                  {(129-ODATA_W){1'b0}},idata[ODATA_W-1:0]};         // the data bits padded to 128 bits (bit 128 unused).
   end else begin : gen_odata_pad_parity
     assign odata_pad_WIDTH_64_word_ptr_zero =
                        { {(17-ODATA_W_PAR){1'b0}},idata[IDATA_W+ODATA_W_PAR-1:IDATA_W],             // the parity bits padded to 17 bits (bit 145) unused
                          {(129-ODATA_W){1'b0}},idata[ODATA_W-1:0]                                  // the data bits padded to 128 bits (bit 128 unused).
                        };
   end
   endgenerate

   // Assign the output data
   always @(*)
      if (bypassed)
         odata_pad = odata_pad_bypassed;
      else if (dma_bus_width == WIDTH_64)
          odata_pad = (word_ptr[IDATA_PIPELINE_DEPTH-1]==3'd0) ?
                                           odata_pad_WIDTH_64_word_ptr_zero
                                         : odata_pad_WIDTH_64_word_ptr_non_zero;
      else
         case (word_ptr[IDATA_PIPELINE_DEPTH-1])
            3'b000  : odata_pad = odata_pad_case_zero;
            3'b001  : odata_pad = {13'd0,idata_buffer[99:96],          // 4 bits of the parity bits padded to 17 bits (bit 145 unused)
                                   97'd0,idata_buffer[31:0]};          // 32 bits of the data bits padded to 128 bits (bit 128 unused).
            3'b010  : odata_pad = {13'd0,idata_buffer[103:100],        // 4 bits of the parity bits padded to 17 bits (bit 145 unused)
                                   97'd0,idata_buffer[63:32]};         // 32 bits of the data bits padded to 128 bits (bit 128 unused).
            default : odata_pad = {13'd0,idata_buffer[107:104],        // 4 bits of the parity bits padded to 17 bits (bit 145 unused)
                                   97'd0,idata_buffer[95:64]};         // 32 bits of the data bits padded to 128 bits (bit 128 unused).
         endcase

  generate if(ODATA_W_PAR == 8'd0) begin : gen_odata_nopar
    assign odata = odata_pad[ODATA_W-1:0];
  end else begin : gen_odata_par
    assign odata = { odata_pad[ODATA_W_PAR-1+129:129],    // passing the parity from padded signal (start at bit 129)
                                                          // (bits 145 unused)
                     odata_pad[ODATA_W-1:0]               // passing the data from padded signal
                   };                                     // (bits 128 unused)

  end
  endgenerate

   // -----------------------------------------------------------------------
   //
   //             Determine when an eop word is being read
   //
   // -----------------------------------------------------------------------

   // If the current word matches the eop slice then highligh that we have
   // an eop.

   wire [3:0] imod_minus1 = imod-4'd1;
   always @(*)
      if (bypassed)
         oeop = 1'b1;
      else if (dma_bus_width==WIDTH_64)
         if      (word_ptr[0]==3'd0 && imod_minus1<=4'd7) oeop = 1'b1;
         else if (word_ptr[0]==3'd2 && imod_minus1>=4'd7) oeop = 1'b1;
         else                                             oeop = 1'b0;
      else
         if      (word_ptr[0]==3'd0 && imod_minus1>=4'd0  && imod_minus1<=4'd3)  oeop = 1'b1;
         else if (word_ptr[0]==3'd1 && imod_minus1>=4'd4  && imod_minus1<=4'd7)  oeop = 1'b1;
         else if (word_ptr[0]==3'd2 && imod_minus1>=4'd8  && imod_minus1<=4'd11) oeop = 1'b1;
         else if (word_ptr[0]==3'd3 && imod_minus1>=4'd12 && imod_minus1<=4'd15) oeop = 1'b1;
         else                                                                    oeop = 1'b0;

   always @(*)
      if (bypassed)
         oeop_next = 1'b1;
      else if (dma_bus_width==WIDTH_64)
         if      (word_ptr[0]==3'd4 && imod_minus1 <=4'd7) oeop_next = 1'b1;
         else if (word_ptr[0]==3'd2 && imod_minus1 <=4'd7) oeop_next = 1'b1;
         else if (word_ptr[0]==3'd0 && imod_minus1>=4'd7)  oeop_next = 1'b1;
         else                                        oeop_next = 1'b0;
      else
         if      (word_ptr[0]==3'd4 && imod_minus1>=4'd0 && imod_minus1<=4'd3)   oeop_next = 1'b1;
         else if (word_ptr[0]==3'd3 && imod_minus1>=4'd0 && imod_minus1<=4'd3)   oeop_next = 1'b1;
         else if (word_ptr[0]==3'd0 && imod_minus1>=4'd4 && imod_minus1<=4'd7)   oeop_next = 1'b1;
         else if (word_ptr[0]==3'd1 && imod_minus1>=4'd8 && imod_minus1<=4'd11)  oeop_next = 1'b1;
         else if (word_ptr[0]==3'd2 && imod_minus1>=4'd12 && imod_minus1<=4'd15) oeop_next = 1'b1;
         else                                                                    oeop_next = 1'b0;



   // -----------------------------------------------------------------------
   //
   //             Current size of output buffer
   //
   // -----------------------------------------------------------------------

   // Size has slightly funny numbering, as it's initialised to being 4
   // after a flush (i.e. word_ptr is 4). Thereafter it has normal counting
   // from 0 to 3. The initialisation of 4 is need to help some calculations
   // in the pbuf_rx_rd block.

   assign size = (dma_bus_width == WIDTH_64)
                 ? (word_ptr[0]==3'd4) ? 3'd2 : {2'b00, ~word_ptr[0][1]}
                 : (word_ptr[0]==3'd4) ? 3'd4 : {1'b0, ~word_ptr[0][1:0]};


endmodule


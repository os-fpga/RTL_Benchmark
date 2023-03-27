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
//   Filename:           edma_spram_controller.v
//   Module Name:        edma_spram_controller
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
// The purpose of this block is act as a direct replacement for the DPRAM,
// using a single port RAM (SPRAM) instead. The underlying eDMA design will
// remain with the DPRAM connections and will function as normal.
//
// A block diagram for this module is shown below:
//
//                         +---------------+
//                         |     SPRAM     |
//                         +---------------+
//                               ^    ^
//                          clkb |    | SPRAM Connections
//                               |    |
//                               |    V
//               +-------------------------------------+
//               |                                     |
//          <--->| dprama        SPRAM          dpramb |<--->
//          ---->| clka        Controller         clkb |<----
//               |                                     |
//               +-------------------------------------+
//
// From the block diagram above it can be seen that the DPRAM connections
// exist either side to connect to existing logic, and a new SPRAM interface
// is introduced by this block.
//
// This design must give the read side priority, to avoid under running the TX
// MAC and to avoid changing the eDMA RX RD side to insert idles on the
// AHB/AXI bus. A FIFO therefore exists to buffer writes when the write cannot
// happen, owing to a higher priority read taking place. Each FIFO buffers data
// and address and the write will take place when a read is not taking place.
// The FIFO depth is anticipated at 4 and 2 for the RX and TX path
// respectively.
//
// The TX and RX path differ slightly in their design, as the TX path uses a
// single clock domain and for the RX path the data passes from the receive
// clock to the AHB/AXI clock using an asynchronous FIFO. This module is
// therefore configurable to instantiate a synchronous or asynchronous FIFO.
// For the synchronous version clka and clkb are the same clocks.
//
// This module uses standard re-usable FIFOs from the Brunton project and
// associated logic to prioritize reads is relatively straightforward. There is
// however one noteworthy point regarding the TX path. Data flow in the TX
// path is controlled by the AXI fabric (AXI implementation) and data bursts
// can come in at such a rate, potentially coinciding with a read burst, to be
// larger than the depth of the FIFO. In this instance back pressure has to be
// signalled to the TX WR block, indicating that the write cannot
// take place and idles must be inserted on the AXI bus. A new txdpram_busya
// has been introduced for this purpose.
//
// The edma_spram_controller instantiated in the RX path has a speacial feature
// where the contents of the Aysnc FIFO can be checked for a pending write to
// the current read address, assuming a read is in operation. If a pending write
// exists then the ram read will be ignored and data will instead be taken from
// the async FIFO.
// The edma_spram_controller has a further special feature that was added at a
// much later date as a result of issues seen in the SOC testbench. The eDMA
// RX RD block will read continually (back to back cycles) when between frame
// transmission and waiting for a new buffer. This only happens in priority mode
// as the read data is needed for speed up. Reading continuosly breask the
// fundamental principles of SPRAM operation as gaps are needed to let the
// write side in. The eDMA RX RD side however reads to the same address
// continually, which is detected and every second access is blocked, and a
// registered version of the data is returned. This would have ideally be fixed
// in the eDMA RX RD block (this fix adds a lot of registers) but it was a late
// fix and too risk at this point.
//
//------------------------------------------------------------------------------


module edma_spram_controller # (

   parameter ADDR_W = 32'd10,     // DPRAM/SPRAM Address Width
   parameter DATA_W = 32'd128,    // DPRAM/SPRAM Data Width. Note. The default is 128
                                  // bits and is very unlikely to need changed
   parameter DATA_W_PAR  = 8'd16, // parity protection bits
   parameter FIFO_DEPTH  = 32'd4, // Depth of the internal FIFO
   parameter FIFO_ADDR_W = 4'd2,  // FIFO_DEPTH = 2^FIFO_ADDR_W;
   parameter SYNCHRONOUS = 1'b1   // Are the DPRAM A & B interfaces synchronous - i.e.
                                  // are clka and clkb the same clock, or are clka and
                                  // clkb asynchronous clocks.
   ) (

   // DPRAMA (Write Only Interface)
   input clka,
   input rsta_n,
   input dpram_wea,
   input dpram_ena,
   input [ADDR_W-1:0] dpram_addra,
   input [DATA_W_PAR+DATA_W-1:0] dpram_dia,
   output dpram_busya, // The write curently cannot be completed

   // DPRAMB (Read Only Interface)
   input clkb,
   input rstb_n,
   input dpram_web, // Not actually used, but present to maintain the interface connections
   input dpram_enb,
   input [ADDR_W-1:0] dpram_addrb,
   output reg [DATA_W_PAR+DATA_W-1:0] dpram_dob,

   // SPRAM Interface
   output reg spram_we,
   output reg spram_en,
   output reg [ADDR_W-1:0] spram_addr,
   output [DATA_W_PAR+DATA_W-1:0] spram_di,
   input [DATA_W_PAR+DATA_W-1:0] spram_do

);

   // -----------------------------------------------------------------------
   //
   //                    Internal Signals & Definitions
   //
   // -----------------------------------------------------------------------

   wire push;
   reg pop;
   wire [ADDR_W+DATA_W_PAR+DATA_W-1:0] popd; // Pop data
   wire [ADDR_W+DATA_W_PAR+DATA_W-1:0] pushd; // Push data
   wire full;
   wire empty;
   wire ram_addr_match;
   wire [DATA_W_PAR+DATA_W-1:0] ram_do;
   wire dpram_enb_blocked;

   // -----------------------------------------------------------------------
   //
   //                           SPRAM Interface
   //
   // -----------------------------------------------------------------------

   // Prioritise reads - if a read is taking place then let it in immediately,
   // assuming the local Async FIFO does not have a pending write for the
   // current read address.
   // Otherwise do a write if a pending write is waiting.
   // Also mux the spram address, depending on who is accessing the SRAM.

   assign spram_di = popd[DATA_W_PAR+DATA_W-1:0];

   always @(*) begin

      // defaults
      pop = 1'b0;
      spram_en = 1'b0;
      spram_we = 1'b0;
      spram_addr = dpram_addrb;

      // Read has prioirty
      if (dpram_enb && !ram_addr_match && !dpram_enb_blocked)
         spram_en = 1'b1;
      // If there is data to write then write it while we are not doing a
      // read
      else if (~empty) begin
         pop = 1'b1;
         spram_en = 1'b1;
         spram_we = 1'b1;
         spram_addr = popd[ADDR_W+DATA_W_PAR+DATA_W-1:DATA_W_PAR+DATA_W];
      end

   end

   // -----------------------------------------------------------------------
   //
   //                          DPRAMA Interface
   //
   // -----------------------------------------------------------------------

   // Write data to the internal FIFO assuming space is available. If
   // space is not available then flag busy.

   assign dpram_busya = full; // Flah that a write cannot take place if the FIFO is full
   assign push = (full) ? 1'b0 : dpram_wea & dpram_ena;
   assign pushd = {dpram_addra, dpram_dia}; // Local fifo contents contains address and data

   // -----------------------------------------------------------------------
   //
   //                          DPRAMB Interface
   //
   // -----------------------------------------------------------------------

   // If we see back 2 back reads to the same address then block every
   // second access and return a registered copy of the data. See description
   // above as to why this is necessary.

   generate if (SYNCHRONOUS==1'b0) begin : gen_rx_rd_fix

      reg  ram_addr_match_reg;
      reg [ADDR_W-1:0] dpram_addrb_reg;
      reg dpram_enb_reg, dpram_enb_blocked_reg;
      reg [DATA_W_PAR+DATA_W-1:0] dpram_dob_reg;
      always @(posedge clkb or negedge rstb_n)
         if (!rstb_n) begin
            dpram_addrb_reg <= {ADDR_W{1'b0}};
            dpram_dob_reg <= {(DATA_W_PAR+DATA_W){1'b0}};
            dpram_enb_blocked_reg <= 1'd0;
            dpram_enb_reg <= 1'd0;
         end
         else begin
            dpram_addrb_reg <= dpram_addrb;
            dpram_dob_reg <= dpram_dob;
            dpram_enb_blocked_reg <= dpram_enb_blocked;
            dpram_enb_reg <= dpram_enb;
         end

      // Detect back to back reads and block the second read if it is to
      // the same address.

      assign dpram_enb_blocked = (dpram_enb_reg &&
                                  dpram_enb &&
                                  (dpram_addrb == dpram_addrb_reg) &&
                                  !dpram_enb_blocked_reg) ? 1'b1 : 1'b0;

   // Register RAM Address Match
   always @(posedge clkb or negedge rstb_n)
      if (!rstb_n)
         ram_addr_match_reg <= 1'b0;
      else
         ram_addr_match_reg <= ram_addr_match;

      // Not much to do here - just asssign the ouput data to the SPRAM data or
      // the local async FIFO data ouptut if a pending write exists for the
      // current read. Additionally, if there was a blocked access return the
      // registered version of the data.
      always @(*)
         if (ram_addr_match_reg)
            dpram_dob = ram_do;
         else if (dpram_enb_blocked_reg)
            dpram_dob = dpram_dob_reg;
         else
            dpram_dob = spram_do;

   end else begin : gen_no_rx_rd_fix

       // Not much to do here - just asssign the ouput data to the SPRAM data or
       // the local async FIFO data ouptut if a pending write exists for the
       // current read.
       always @(*)
//          if (ram_addr_match_reg)
//             dpram_dob = ram_do;
//          else
             dpram_dob = spram_do;

       assign dpram_enb_blocked = 1'b0;

   end
   endgenerate

   // -----------------------------------------------------------------------
   //
   //                      Instantiate the internal FIFO
   //
   // -----------------------------------------------------------------------

   generate if (SYNCHRONOUS==1'b1) begin : gen_fifo

      // Synchronous FIFO
      edma_gen_fifo #(

         .FIFO_WIDTH     (ADDR_W+DATA_W_PAR+DATA_W),
         .FIFO_DEPTH     (FIFO_DEPTH),
         .FIFO_ADDR_WIDTH(FIFO_ADDR_W)

      ) i_edma_gen_fifo (
        .clk_pcie(clka),
        .rst_n   (rsta_n),
        .flush   (1'b0),
        .push    (push),
        .din     (pushd),
        .qfull   (full),
        .pop     (pop),
        .qout    (popd),
        .qempty  (empty),
        .qlevel  ()
      );

      assign ram_addr_match = 1'b0;
      if(DATA_W_PAR == 8'd0) begin : gen_ram_do
        assign ram_do = {DATA_W{1'b0}};
      end else begin : gen_ram_dp
        assign ram_do = { {DATA_W_PAR{1'b0}},  // parity
                          {DATA_W{1'b0}} };
      end
   end
   else begin : gen_nonsync_fifo

      // Asynchronous FIFO
      edma_gen_async_fifo_look_ahead #(

         .ADDR_W           (FIFO_ADDR_W),
         .DATA_W           (ADDR_W+DATA_W_PAR+DATA_W),
         .RAM_ADDR_WIDTH   (ADDR_W),
         .RAM_ADDR_POSITION(DATA_W_PAR+DATA_W)

      ) i_edma_gen_async_fifo_look_ahead (

         .clk_push      (clka),
         .rst_push_n    (rsta_n),
         .push          (push),
         .pushd         (pushd),
         .push_size     (),
         .push_full     (full),
         .push_overflow (),
         .clk_pop       (clkb),
         .rst_pop_n     (rstb_n),
         .pop           (pop),
         .popd          (popd),
         .pop_size      (),
         .pop_empty     (empty),
         .pop_underflow (),
         .ram_en        (dpram_enb),
         .ram_we        (dpram_web),
         .ram_addr      (dpram_addrb),
         .ram_do        (ram_do),
         .ram_addr_match(ram_addr_match));

   end
   endgenerate

endmodule


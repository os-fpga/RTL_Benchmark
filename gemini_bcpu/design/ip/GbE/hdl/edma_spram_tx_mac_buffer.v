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
//   Filename:           edma_spram_tx_mac_buffer.v
//   Module Name:        edma_spram_tx_mac_buffer
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
//   Description :
//
// The purpose of this module is for SPRAM operation to provide a buffer between
// the TX RD and TX MAC blocks. To support SPRAM operation the TX eDMA design is
// now solely clocked from the AHB/AXI clock and data is transferred into the
// MAC clock domain using this block, which has an Async FIFO internally to
// facilitate crossing clock domains.
//
// A block diagram with associated connections is shown below:
//
//  +-----------------+           +----------------+           +----------------+
//  |                 |   MAC     |                |   MAC     |                |
//  | edma_pbuf_tx_rd |<--------->| edma_spram_tx_ |<--------->|     tx_mac     |
//  |                 | Interface |   mac_buffer   | Interface |                |
//  +-----------------+           +----------------+           +----------------+
//
//
// One aim of this block is to minimize the impact to existing designs. With this
// in mind this module has a MAC interface at either side to interface with the
// edma_pbuf_tx_rd and tx_mac blocks. The interface to these blocks should
// therefore remain unchanged and will function as normal. There however may be
// complications due to the latency increase but these should hopefully be
// minimal.
//
// For the edma_pbuf_tx_rd interface, this block will monitor tx_r_data_rdy and
// when this is high will provide tx_r_rd and tx_r_rd_int signals, assuming space
// is available within the FIFO. Data will be written to the FIFO when tx_r_valid
// is active. A 2 cycle inertia exists between tx_r_rd_int and tx_r_valid so this
// additionally is taken into account.
//
// For the other interface (tx_mac) the opposite will happen - this block will
// provide tx_r_data_rdy if the FIFO is not empty and will respond accordingly
// with tx_r_data and tx_r_valid after tx_r_rd has been raised. The tx_r_sop and
// tx_r_eop signals will also be provided. Again the 2 cycle inertia will be
// taken into account.
//
// Note. The Async FIFO within this block will store all related MAC signals -
// i.e. data alone won't be recorded and tx_r_sop, tx_r_eop, tx_rmod, tx_err, etc
// will all need to be recorded.
//
// There is a slight caveat to this module for half duplex mode, as the MAC's
// half duplex mode operation is slightly untidy - when a collision occurs
// the fifo within this module may have a number of entries but the MAC will
// not take these entries, it instead goes into a state where it requires a
// a flush. Flush is written by the tx_wr side but as there are a number of entries
// in the local fifo the MAC won't see the flush as there are entries in the
// way and the MAC won't read them. We therefore have a small state-machine in
// this module to flush the contents of the FIFO when a collision occurs. A generic
// signalled called tx_r_flush_mac_request is used which encompasies more than just
// collision and also inclused late_coll_occured and too_many_retries
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_spram_tx_mac_buffer # (
   parameter p_emac_bus_width    = 0,
   parameter p_emac_parity_width = 8'd0,
   parameter DATA_W              = 32'd64, // MAC Data Width
   parameter DATA_W_PAR          = 8'd8,   // MAC Data Width
   parameter FIFO_ADDR_W         = 32'd2,  // FIFO_DEPTH = 2^FIFO_ADDR_W
   parameter p_edma_asf_dap_prot = 1'b0

   ) (

   // eDMA TX WR Interface
   input clk_edma,
   input rst_edma_n,
   output reg tx_r_rd_edma,
   output reg tx_r_rd_int_edma,
   input tx_r_valid_edma,
   input [p_emac_parity_width+p_emac_bus_width-1:0] tx_r_data_edma,
   input tx_r_eop_edma,
   input tx_r_sop_edma,
   input [3:0] tx_r_mod_edma,
   input tx_r_err_edma,
   input tx_r_flushed_edma,
   input tx_r_underflow_edma,
   input tx_r_data_rdy_edma,
   input tx_r_control_edma,
   input [13:0] tx_r_frame_size_edma,

   // TX MAC Interface
   input clk_mac,
   input rst_mac_n,
   input tx_r_rd_mac,
   output reg tx_r_valid_mac,
   output [p_emac_parity_width+p_emac_bus_width-1:0] tx_r_data_mac,
   output tx_r_eop_mac,
   output tx_r_sop_mac,
   output [3:0] tx_r_mod_mac,
   output tx_r_err_mac,
   output tx_r_flushed_mac,
   output tx_r_underflow_mac,
   output reg tx_r_data_rdy_mac,
   output tx_r_control_mac,
   output [13:0] tx_r_frame_size_mac,
   input tx_r_flush_mac_request,

   output block_sram_ecc_check

);


   // -----------------------------------------------------------------------
   //
   //                    Internal Signals & Definitions
   //
   // -----------------------------------------------------------------------

   // Positions of various MAC signals within the local FIFO
   localparam FIFO_DATA_W = DATA_W_PAR+DATA_W+32'd24; // 24 for frame length(14) and other control signals
   localparam EOP = DATA_W_PAR+DATA_W + 32'd0;
   localparam SOP = DATA_W_PAR+DATA_W + 32'd1;
   localparam ERR = DATA_W_PAR+DATA_W + 32'd2;
   localparam UNDERFLOW = DATA_W_PAR+DATA_W + 32'd3;
   localparam FLUSHED   = FIFO_DATA_W-32'd1;

   // eDMA interface signals
   reg [FIFO_ADDR_W:0] pending_read_count; // Number of pending reads that have been issued.
   wire [FIFO_ADDR_W + 1:0] sum_size; // Fifo fill level plus pending_read_count
   reg tx_r_data_rdy_edma_reg;
   wire [FIFO_ADDR_W:0] push_size; // Current fill level of the FIFO (push side)
   wire push_full;

   // MAC interface signals
   reg tx_r_rd_mac_reg;
   wire [FIFO_ADDR_W:0] pop_size; // Current fill level of the FIFO (pop side)
   wire pop_empty;
   wire [FIFO_DATA_W-1:0] popd;
   reg [FIFO_DATA_W-2:0] popd_reg;

   // Delayed versions of tx_r_rd_edma an a mock version of valid, which is used
   // to decrement the pending read counter, if for example, the tx_rd block's
   // pipe runs dry and there is no response to the tx_r_rd.
   reg tx_r_rd_edma_reg;
   reg tx_r_valid_edma_mock;

   // A pending underflow or flush write is present
   reg tx_r_underflow_edma_pending, tx_r_flushed_edma_pending;

   // Half Duplext (HD) State Machine
   localparam HD_IDLE = 1'b0;
   localparam HD_FLUSH = 1'b1;
   reg current_state, current_state_nxt;
   reg pop_hd_override, pop_hd_flush;

   reg pip_edma_r;
   wire pip_edma;

   // -----------------------------------------------------------------------
   //
   //                           eDMA Interface
   //
   // -----------------------------------------------------------------------

   // The edma_pbuf_tx_rd block is designed to work with an inertia (an XGM term) of
   // 2. This means that tx_r_valid will be present 2 cycles after tx_r_rd. In actual
   // fact tx_r_rd_int is also used so in reality there is an inertia delay of 3.
   // This block therefore has to monitor the number of reads that have been issued when
   // tx_r_data_rdy drops, as these are cancelled and a subsequent tx_r_valid will not occur.
   // To determine when to do a read the number of pending reads is added to the current
   // FIFO fill level. A new read will not be issued if the number of pending reads + the
   // current fill level equates to a full FIFO. Clearing of tx_r_data_rdy is quite
   // crucial as this block may have requested reads but there will be no tx_r_valid
   // response as the tx_rd's pipe has run dry. We therefore create a "mock" signal
   // that is always generated in place of tx_r_valid, in case tx_r_valid doesn't
   // occur. This "mock" singal is used to decrement the pending read counter.
   //
   // tx_r_valid is used to push data into the FIFO.
   //
   // The timing diagram below attempts to capture various scenarios for this block, such as
   // hitting full and backing off, tx_r_data_rdy going low, etc.
   //
   // Note. All signals are "_edma" signals but "_edma" hasn't been added
   //                   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _
   // clk             _| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_
   //                   ___________________________________________
   // tx_r_data_rdy   _|                                           |___________________
   //                       ___________________________________________
   // tx_r_data_rdy_reg ___|                                           |_______________
   //                       _______________         ___     ___________
   // tx_r_rd_int     _____|               |_______|   |___|           |_______________
   //                           _______________         ___     ___________
   // tx_r_rd         _________|               |_______|   |___|           |___________
   //                   _______ ___ ___ _______ ___ ___ _______ ___________ ___ _______
   // pending_read_count___0___X_1_X_2_X___3___X_2_X___1_______X___2_______X_1_X_0_____
   //                                   _______________         ___
   // tx_r_rd_valid   _________________|               |_______|   |___________________
   //                                   _______________         ___     _______
   // tx_r_rd_valid_mock ______________|               |_______|   |___|       |_______
   //                 _____________________ ___ _______ ___ ___ _______ _______________
   // push_size       _____0_______________X_1_X___2___X_3_X_2_X___1___X________0______
   //                                           ___     _______________
   // pop             _________________________|   |___|               |_______________
   //
   //
   // Note. In the above diagram pop has been shown as sycnhronous for conceptual purposes,
   // but in relaity it comes from a separate clock domain

   wire tx_r_end_edma;
   assign tx_r_end_edma = ((tx_r_eop_edma && tx_r_valid_edma) || tx_r_underflow_edma || tx_r_flushed_edma);

   // Register tx_r_data_rdy and tx_r_rd (just a one cycle delayed version of tx_r_rd)
   always @(posedge clk_edma or negedge rst_edma_n)
   begin
     if (!rst_edma_n) begin
        tx_r_data_rdy_edma_reg <= 1'b0;
        tx_r_rd_edma <= 1'b0;
        tx_r_rd_edma_reg <= 1'b0;
        tx_r_valid_edma_mock <= 1'b0;
     end
     else begin
        if (tx_r_end_edma && !tx_r_data_rdy_edma)
          tx_r_data_rdy_edma_reg <= 1'b0;
        else if (!tx_r_data_rdy_edma_reg && tx_r_data_rdy_edma)
          tx_r_data_rdy_edma_reg <= 1'b1;
        tx_r_rd_edma <= tx_r_rd_int_edma;
        tx_r_rd_edma_reg <= tx_r_rd_edma ;
        tx_r_valid_edma_mock <= tx_r_rd_edma_reg ;
     end
   end

   // The tx_r_rd_int_edma signal may generate a redundant read from an unitialised memory location
   // because tx_r_data_rdy_edma_reg does not immediately go low on (tx_r_end_edma && !tx_r_data_rdy_edma)
   // condition so generate block_sram_ecc_check to prevent an error being reported by the ECC logic 
   // the instantiation in gem_top if SRAM parity protection is enabled
   if (p_edma_asf_dap_prot) begin : gen_block_ecc
     reg block_sram_ecc_check_r;
     reg block_sram_ecc_check_s;
     always @(posedge clk_edma or negedge rst_edma_n)
     begin
       if (!rst_edma_n) begin
          block_sram_ecc_check_r <= 1'b0;
          block_sram_ecc_check_s <= 1'b0;
       end
       else if (tx_r_end_edma && !tx_r_data_rdy_edma) begin
          // it takes a cycle for tx_r_data_rdy_edma_reg to go low so generate ECC block signal
          block_sram_ecc_check_r <= 1'b1;
          block_sram_ecc_check_s <= 1'b0;
       end
       else if (block_sram_ecc_check_s) begin
          block_sram_ecc_check_r <= 1'b0;
          block_sram_ecc_check_s <= 1'b0;
       end
       else begin
          block_sram_ecc_check_r <= block_sram_ecc_check_r;
          block_sram_ecc_check_s <= block_sram_ecc_check_r;
       end
     end
     assign block_sram_ecc_check = block_sram_ecc_check_r;
   end else begin : gen_no_block_ecc
     assign block_sram_ecc_check = 1'b0;
   end

   // Determine the "sum" fill level - i.e. the pending_read_count + the fifo fill level
   assign sum_size = pending_read_count + push_size;

   wire  [31:0] two_pwr_fifo_addr_w;
   assign       two_pwr_fifo_addr_w = 2**FIFO_ADDR_W;

   // Generate tx_rd_int if tx_r_data_rdy is active and there is enough space in the
   // FIFO, assuming a flush write is not pending.
   always @(*)
   begin
     if (!tx_r_data_rdy_edma_reg)
       tx_r_rd_int_edma = 1'b0;
     else if (sum_size < two_pwr_fifo_addr_w[FIFO_ADDR_W+1:0] && !tx_r_flushed_edma && !tx_r_flushed_edma_pending)
       tx_r_rd_int_edma = 1'b1;
     else
       tx_r_rd_int_edma = 1'b0;
   end

   // Generate a count of the number of pending reads
   always @(posedge clk_edma or negedge rst_edma_n)
   begin
     if (!rst_edma_n)
        pending_read_count <= {FIFO_ADDR_W+1{1'b0}};
     else
        // If have issued a read increment by 1 and if we have seen a valid
        // decrement by 1
        case ({tx_r_valid_edma_mock, tx_r_rd_int_edma})
           2'b01   : pending_read_count <= pending_read_count + {{FIFO_ADDR_W{1'b0}}, 1'b1}; // Plus 1
           2'b10   : pending_read_count <= pending_read_count - {{FIFO_ADDR_W{1'b0}}, 1'b1}; // Minus 1
           default : pending_read_count <= pending_read_count;
        endcase
   end

   // Create a stored copy of tx_r_underflow_edma in case the tx_rd block
   // indicates underflow when the fifo is full. This can happen as underflow
   // does not follow the tx_r_rd/tx_r_valid protocol and simplify flags
   // underflow when it happens. When the underflow happens the fifo may well
   // be full, so we need to ensure we store a copy until it can be written
   // to the FIFO. The same rule also applies to the tx_r_flushed_edma signal.

   always @(posedge clk_edma or negedge rst_edma_n)
   begin
     if (!rst_edma_n)
        tx_r_underflow_edma_pending <= 1'b0;
     else
        if (push_full && tx_r_underflow_edma)
           tx_r_underflow_edma_pending <= 1'b1;
        else if (!push_full)
           tx_r_underflow_edma_pending <= 1'b0;
   end

   always @(posedge clk_edma or negedge rst_edma_n)
   begin
     if (!rst_edma_n)
        tx_r_flushed_edma_pending <= 1'b0;
     else
        if (push_full && tx_r_flushed_edma)
           tx_r_flushed_edma_pending <= 1'b1;
        else if (!push_full)
           tx_r_flushed_edma_pending <= 1'b0;
   end
   // Its possible this module will request data from the EDMA after the EOP has been read out and there
   // is nothing left for the EDMA to fetch. This will result in rubbish data (possibly X in simulation)
   // being passed through. Rather than pass this rubbish data through to the MAC, we gate it out to
   // ensure there is no X propagation. Not 100% necessary, but it is only a gate and does tidy up simulations somewhat.
   always @(posedge clk_edma or negedge rst_edma_n)
   begin
     if (!rst_edma_n)
        pip_edma_r <= 1'b0;
     else
       if (tx_r_end_edma)
          pip_edma_r <= 1'b0;
       else if (tx_r_sop_edma && tx_r_valid_edma)
          pip_edma_r <= 1'b1;
   end

   assign pip_edma = (tx_r_sop_edma && tx_r_valid_edma) | pip_edma_r;

   // -----------------------------------------------------------------------
   //
   //                           TX MAC Interface
   //
   // -----------------------------------------------------------------------

   // The TX MAC interface is fairly straightfoward - simply issue tx_r_data_rdy_mac
   // when the FIFO is not empty and respond with tx_r_valid_mac a couple of
   // cycles after the read. This isn't actually strictly true as at a sop we will
   // wait for 2 locations to be present in the FIFO before starting a packet, to
   // ensure the FIFO doesn't underrun once started.
   // There is again a small complexity on the inertia delay, as the tx_r_rd_mac
   // signal can go beyond the FIFO being empty because of the inertia. In this
   // case we gate a FIFO read and the corresponding tx_r_valid_mac going back
   // with the fifo being empty.

   // Register tx_r_rd_mac signal
   always @(posedge clk_mac or negedge rst_mac_n)
   begin
     if (!rst_mac_n)
        tx_r_rd_mac_reg <= 1'b0;
     else
        tx_r_rd_mac_reg <= tx_r_rd_mac;
   end

   // The valid signal is straightforward - it simply follows read, assuming
   // the local FIFO does not hit empty.
   always @(posedge clk_mac or negedge rst_mac_n)
   begin
     if (!rst_mac_n)
        tx_r_valid_mac <= 1'b0;
     else
        tx_r_valid_mac <= tx_r_rd_mac_reg & ~pop_empty;
   end

   // Assign tx_r_data_rdy_mac when the FIFO has data and it's not just an
   // sop in the FIFO. If it's just a sop then we will wait for more data
   // to enter the local FIFO to ensure an underrun doesn't happen.
   //

   always @(*)
   begin
     // If the FIFO is empty then drop ready.
     // Alternatively if we are signalling a flush don't flag read
     if (pop_empty | tx_r_flushed_mac)
        tx_r_data_rdy_mac = 1'b0;
     else
        // If it's just a sop in the FIFO then hold off signalling ready
        // until another word is in the FIFO, to avoid an underflow
        if ( !pop_empty &&
             pop_size == {{FIFO_ADDR_W{1'b0}},1'b1} && // 1
             popd[SOP] &&
             ~|{popd[EOP], popd[ERR], popd[FLUSHED], popd[UNDERFLOW]})
           tx_r_data_rdy_mac = 1'b0;
        else
           tx_r_data_rdy_mac = 1'b1;
   end

   // Create a registed copy of the pop data to align with the MAC intertia
   always @(posedge clk_mac or negedge rst_mac_n)
   begin
     if (!rst_mac_n)
        popd_reg <= {FIFO_DATA_W-1{1'b0}};
     else
        popd_reg <= popd[FIFO_DATA_W-2:0];
   end

   // If the fifo is not empty and we have a flush then create a 1 shot
   // pulse on the flush output. This same signal also pops the fifo.
   assign tx_r_flushed_mac = !pop_empty && popd[FLUSHED];


   // Assign the output data (Note. We don't include the flush, hence
   // the FIFO_DATA_W-2 setting)
   assign {tx_r_frame_size_mac,
           tx_r_mod_mac,
           tx_r_control_mac,
           tx_r_underflow_mac,
           tx_r_err_mac,
           tx_r_sop_mac,
           tx_r_eop_mac,
           tx_r_data_mac} = popd_reg[FIFO_DATA_W-2:0];

   // -----------------------------------------------------------------------
   //
   //                      Half Duplex FLush State Machine
   //
   // -----------------------------------------------------------------------

   // When we see a collision flush the contents of the async fifo until we
   // see the flush. See the module description on why this is necessary.
   wire tx_r_flush_request_rise_edge;
   edma_toggle_detect i_edma_toggle_detect(
      .clk(clk_mac),
      .reset_n(rst_mac_n),
      .din(tx_r_flush_mac_request),
      .rise_edge(tx_r_flush_request_rise_edge),
      .fall_edge(),
      .any_edge());

   always @(*)
   begin
      // Defaults
      pop_hd_override = 1'b0;
      pop_hd_flush = 1'b0;
      current_state_nxt = current_state;
      if (current_state == HD_IDLE)
      begin
            if (tx_r_flush_request_rise_edge) begin
               // if there is only one location in the FIFO and it contains the flush
               // then we don't need to flush the contents of the FIFO, as the current
               // flush word will flush the FIFO.
               if (tx_r_flushed_mac)
                  current_state_nxt = HD_IDLE; // Do nothing
               // Additionally if we are empty the flush has made its way
               // through or will soon be there, so no need to wait until the
               // pending entries have been flushed.
               else if (pop_empty)
                  current_state_nxt = HD_IDLE; // Do nothing
               else
                  current_state_nxt = HD_FLUSH;
            end
      end
      else
      begin // HD_FLUSH

            pop_hd_override = 1'b1;

            // When we see a flush going to the MAC go back to idle
            if (tx_r_flushed_mac)
               current_state_nxt = HD_IDLE;

            // If the fifo has data in it then pop. We will automatically
            // stop popping when we see the flush as the fsm will go back
            // to idle.
            if (!pop_empty)
               pop_hd_flush = 1'b1;


      end

   end

   always @(posedge clk_mac or negedge rst_mac_n)
   begin
     if (!rst_mac_n)
        current_state <= HD_IDLE;
     else
        current_state <= current_state_nxt;
   end


   // -----------------------------------------------------------------------
   //
   //                      Instantiate the Async FIFO
   //
   // -----------------------------------------------------------------------

   wire   push;
   wire   pop;
   assign pop  = pop_hd_override ? pop_hd_flush : tx_r_rd_mac_reg | tx_r_flushed_mac;
   assign push = tx_r_valid_edma | tx_r_underflow_edma | tx_r_underflow_edma_pending | tx_r_flushed_edma | tx_r_flushed_edma_pending;

   edma_gen_async_fifo #(

      .ADDR_W(FIFO_ADDR_W),
      .DATA_W(FIFO_DATA_W)

   ) i_edma_gen_async_fifo (

      .clk_push(clk_edma),
      .rst_push_n(rst_edma_n),
      .push(push),
      .pushd({tx_r_flushed_edma | tx_r_flushed_edma_pending,
              tx_r_frame_size_edma,
              tx_r_mod_edma,
              tx_r_control_edma,
              tx_r_underflow_edma | tx_r_underflow_edma_pending,
              tx_r_err_edma,
              tx_r_sop_edma,
              tx_r_eop_edma,
              (tx_r_data_edma & {p_emac_parity_width+p_emac_bus_width{pip_edma}})
             }),
      .push_full(push_full),
      .push_size(push_size),
      .push_overflow(),

      .clk_pop(clk_mac),
      .rst_pop_n(rst_mac_n),
      .pop(pop),
      .popd(popd),
      .pop_size(pop_size),
      .pop_empty(pop_empty),
      .pop_underflow()
   );

endmodule

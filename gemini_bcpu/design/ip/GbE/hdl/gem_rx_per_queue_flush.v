//------------------------------------------------------------------------------
// Copyright (c) 2016-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_rx_per_queue_flush.v
//   Module Name:        gem_rx_per_queue_flush
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
//   Description :      Implements the per queue flushing feature
//
//------------------------------------------------------------------------------


module gem_rx_per_queue_flush (

  n_rxreset,
  rx_clk,
  enable_receive_rck,
  max_val_pclk,
  drop_all_frames_rx_clk,
  limit_frames_size_rx_clk,
  queue_ptr_rx,
  final_eop_push,
  frame_length,
  fill_lvl_breached,
  rx_drop_frame,
  frame_flushed_tog
  );

   parameter [1363:0] grouped_params = {1364{1'b0}};
   parameter          SFSM_STATUS1   = 3'b011;
  `include "ungroup_params.v"

  input                          n_rxreset;                    // reset
  input                          rx_clk;                       // clock
  input                          enable_receive_rck;           // soft reset
  input [(16*p_edma_queues)-1:0] max_val_pclk;                 // bits 31:16 of rx_q_flush register (for each queue)
  input      [p_edma_queues-1:0] limit_frames_size_rx_clk;     // bit 3
  input      [p_edma_queues-1:0] drop_all_frames_rx_clk;       // bit 0
  input                    [3:0] queue_ptr_rx;                 // queue pointer when pushing data in the RAM
  input                          final_eop_push;               // early end of packet strobe
  input                   [13:0] frame_length;                 // it counts the frame's length expressed in bytes
  input      [p_edma_queues-1:0] fill_lvl_breached;            // Coming from EDMA RX-RD, signalling a breach on the dpram fill lvl
  output                         rx_drop_frame;                // output of the module
  output reg                     frame_flushed_tog;            // toggle to stats, indicating a frame has been flushed
                                                               // because a limit has been breached in mode 2 or 3
  // -----------------------------------------------------------------------------
  // Wire and registers declaration
  // -----------------------------------------------------------------------------
  wire [p_edma_queues-1:0] limit_mode2_breached;
  reg  [p_edma_queues-1:0] limit_mode3_breached;
  wire                     max_val_queue_reached;
  wire                     drop_frame_q_mode0;
  wire              [16:0] drop_all_frames_rx_clk_pad;
  wire              [16:0] limit_mode2_breached_pad;
  wire              [16:0] limit_mode3_breached_pad;
  wire [p_edma_queues-1:0] fill_lvl_breached_rx;
  wire              [16:0] fill_lvl_breached_rx_pad;

  // -----------------------------------------------------------------------------
  // Start of the Hardware Description
  // Mode 0 implementation
  // -----------------------------------------------------------------------------
  // We want to drop a frame regardless of everything
  // if bit 0 of the per queue rx flush register is set for the current queue

  assign drop_all_frames_rx_clk_pad = {{(17-p_edma_queues){1'b0}},drop_all_frames_rx_clk};
  assign drop_frame_q_mode0         = (drop_all_frames_rx_clk_pad[queue_ptr_rx]);

  // -----------------------------------------------------------------------------
  // Mode 2 implementation
  // -----------------------------------------------------------------------------
  // The drop signal to the output will be driven continously whenever the queue
  // specific fill level of the DPRAM will be over the limit. If by the time the
  // signal final_eop_push will come the limit will be still breached, then the
  // frame will be errored.
  assign fill_lvl_breached_rx_pad = {{(17-p_edma_queues){1'b0}},fill_lvl_breached_rx};

  genvar i;
  generate for(i=0; i<p_edma_queues[4:0]; i=i+1) begin: gen_fill_lvl_breached_sync
    cdnsdru_datasync_v1 i_fill_lvl_breached_sync_rx (
      .clk    (rx_clk),
      .reset_n(n_rxreset),
      .din    (fill_lvl_breached[i]),
      .dout   (fill_lvl_breached_rx[i])
    );

    assign limit_mode2_breached[i] = fill_lvl_breached_rx_pad[queue_ptr_rx];

  end
  endgenerate

  // -----------------------------------------------------------------------------
  // Mode 3 implementation
  // -----------------------------------------------------------------------------
  // This will implement a system which will drop the frame because of the length
  // of the frame for a queue is exceeding the maximum value set in the registers
  // Note: max_val_pclk must not exceed 14 bits, because frame_length is 14 bits.
  genvar g;
  generate for(g=0; g<p_edma_queues[4:0]; g=g+1)
  begin: gen_mode3
    wire [15:0] max_val_pclk_q;
    assign      max_val_pclk_q = max_val_pclk[(15+(16*g)):(16*g)];
    always @ *
    begin
      if(queue_ptr_rx == g[3:0])
        begin
          if((frame_length > max_val_pclk_q[13:0]) && limit_frames_size_rx_clk[g])
            limit_mode3_breached[g] = 1'b1;
          else
            limit_mode3_breached[g] = 1'b0;
        end
      else
        limit_mode3_breached[g] = 1'b0;
    end
  end
  endgenerate

  // if one of limits have been breached in Mode2 or Mode3
  // then max_val_queue_reached will be asserted.
  assign limit_mode2_breached_pad = {{(17-p_edma_queues){1'b0}},limit_mode2_breached};
  assign limit_mode3_breached_pad = {{(17-p_edma_queues){1'b0}},limit_mode3_breached};
  assign max_val_queue_reached    = (limit_mode2_breached_pad[queue_ptr_rx]||
                                     limit_mode3_breached_pad[queue_ptr_rx]);

  // Driving the output
  assign rx_drop_frame = max_val_queue_reached | drop_frame_q_mode0;

  // Generating a toggle every time a frame is discarded
  // due to mode3 and 2. Mode 0 doesn't contribute and Mode 1 contributes
  // the same way force_discard_on_err does, in the edma Rx-Rd module
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      frame_flushed_tog <= 1'b0;
    else
      begin
        if(~enable_receive_rck)
          frame_flushed_tog <= 1'b0;
        else if(final_eop_push & max_val_queue_reached)
          frame_flushed_tog <= ~frame_flushed_tog;
      end
  end

endmodule

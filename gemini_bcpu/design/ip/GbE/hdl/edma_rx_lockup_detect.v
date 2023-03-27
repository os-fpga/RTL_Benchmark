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
//   Filename:           edma_rx_lockup_detect.v
//   Module Name:        edma_rx_lockup_detect
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
//   Description    : Lockup detection of GEM DMA RX path. This is instantiated
//                    once and is queue independent.
//
//                    Part 1  - Generic packet counter with a timeout if no
//                              packets are taken out of the SRAM within a
//                              certain time.
//                              Packets fully in SRAM when end of packet has
//                              been written and it didn't overflow.
//                              Packets fully out of the SRAM when DMA finishes
//                              writing to memory or it is flushed.
//
//------------------------------------------------------------------------------


module edma_rx_lockup_detect (

  input             hclk,                 // AMBA clock
  input             n_hreset,             // Asynchronous reset

  input             lockup_count_en,      // Synchronised prescaler enable
  input   [10:0]    lockup_time,          // Timeout for lockup check
  input             lockup_detect_en_s,   // Enable for lockup detection.
  input             rx_enable_s,          // Enable for receive datapath

  input             rx_fifo_if_pkt_inc_e, // Packet fully written from FIFO i/f
  input             rx_dma_pkt_flushed_e, // Packet flushed out of DMA
  input             rx_dma_complete_ok_e, // Packet fully written to memory

  output  reg       lockup_detected       // Lockup has occurred.

);

  // ---------------------------------------------------------------------------
  // Part 1 of the lockup detection mechanism...
  //
  // Use the generic transaction count timer module
  //
  // ---------------------------------------------------------------------------
  wire  lu1_en;       // Enable lockup detection for part 1
  wire  lu1_cnt_en;   // Timer count enable for prescaler
  wire  lu1_inc;      // Increment number of packets
  wire  lu1_dec;      // Decrement number of packets
  wire  lu1_to;       // Timeout occurred for part 1

  // Enable lockup detection when RX and lockup monitoring are enabled
  assign lu1_en = rx_enable_s & lockup_detect_en_s;

  // Prescaler is used to scale the counter range.
  assign lu1_cnt_en = lockup_count_en;

  // Increment the packet count based on rx_fifo_if_pkt_inc_e
  assign lu1_inc  = rx_fifo_if_pkt_inc_e;

  // Decrement when passed taken out of SRAM
  assign lu1_dec  = rx_dma_complete_ok_e | rx_dma_pkt_flushed_e;

  // Generic module
  edma_gen_cnt_to #(
    .p_cnt_wid(8),  // Maximum 255 packets.
    .p_to_wid (11)
  ) i_lu2_timer (
    .clock          (hclk),
    .reset_n        (n_hreset),
    .timeout_val    (lockup_time),
    .enable         (lu1_en),
    .timer_cnt_en   (lu1_cnt_en),
    .cnt_inc        (lu1_inc),
    .cnt_dec        (lu1_dec),
    .count          (),
    .to_err         (lu1_to)
  );

  // Generate signal for interrupt generation, will only clear when datapath is disabled.
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      lockup_detected  <= 1'b0;
    else
      if (~rx_enable_s | ~lockup_detect_en_s)
        lockup_detected <= 1'b0;
      else
        if (lu1_to)
          lockup_detected  <= 1'b1;
  end

endmodule


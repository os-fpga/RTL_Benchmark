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
//   Filename:           edma_tx_lockup_detect.v
//   Module Name:        edma_tx_lockup_detect
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
//   Description    : Lockup detection of GEM DMA TX path. This is instantiated
//                    per queue since there is only one tx start trigger, it is
//                    not possible to know for which queue the software was
//                    actually wanting to transmit from so each timer will be
//                    triggered but will be subsequently aborted based on either
//                    a per-queue disable or aborted via a per-queue 'used bit
//                    read' indication.
//
//                    There are several parts to this module each monitoring a
//                    different aspect...
//                    Operation is as follows:
//
//                    Part 1 - Timeout to packet write DMA side.
//                      - Trigger on combination of start (hard and soft)
//                      - Clear when a packet is fully written to SRAM
//                      - Abort on detectable errors, e.g. used bit read etc
//
//                    Part 2 - Timeout of packet count for queue in DMA
//                      - Trigger on packet fully written to SRAM and count
//                        whenever packet counter is non-zero.
//                      - Reset each time a packet is passed to the MAC.
//                      - Abort on major errors
//
//------------------------------------------------------------------------------


module edma_tx_lockup_detect (

  input             hclk,                 // AMBA clock
  input             n_hreset,             // Asynchronous reset

  input             lockup_count_en,      // Synchronised enable from prescaler
  input             lockup_timer_en,      // Enable timer, not synchronised
  input   [10:0]    lockup_time,          // Timeout for lockup check
  input             lockup_detect_en_s,   // Enable for lockup detection.
  input             tx_enable_s,          // Enable for transmit datapath
  input             tx_disable_queue,     // Disable this queue.
  input             tx_start_trig_s,      // DMA start pulse from hw or sw.
  input             tx_edma_full_pkt_inc, // Full packet stored to SRAM
  input             tx_edma_used_bit_vec, // Used bit read
  input             tx_edma_lockup_flush, // Major error occurred
  input             tx_fif_full_pkt_inc_s,// Full packet passed to MAC

  output  reg       lockup_detected     // Lockup has occurred.

);

  wire  lockup_timer_en_s;
  cdnsdru_datasync_v1 i_sync_lockup_timer_en (
    .clk    (hclk),
    .reset_n(n_hreset),
    .din    (lockup_timer_en),
    .dout   (lockup_timer_en_s)
  );

  // ---------------------------------------------------------------------------
  // Part 1 of the lockup detection mechanism...
  //
  // Count from when start is triggered and stops when either a new packet has
  // been stored for this queue or used bit has been read.
  // If a major error occurs, also stop the count.
  // ---------------------------------------------------------------------------
  wire  lu1_en;       // Enable lockup detection for part 1
  wire  lu1_cnt_en;   // Timer count enable for prescaler
  wire  lu1_start;    // Start counting, once started will continue until to or
  wire  lu1_stop;     // stop is signalled.
  wire  lu1_to;       // Timeout occurred for part 1.

  // Enable lockup detection when TX and lockup monitoring are enabled
  // Force clear down when major error occurs.
  // Also check that queue is enabled, this should be a static configuration.
  assign lu1_en = tx_enable_s & ~tx_disable_queue & lockup_detect_en_s & ~tx_edma_lockup_flush;

  // Prescaler is used to scale the counter range.
  // Combine with start trigger to ensure initial count starts
  assign lu1_cnt_en = lockup_count_en | tx_start_trig_s;

  // Start counting when tx_start_trig_s
  assign lu1_start  = tx_start_trig_s;

  // Stop when major error occurs or packet has finished storing into SRAM or
  // a used bit is read.
  assign lu1_stop   = tx_edma_lockup_flush | tx_edma_full_pkt_inc | tx_edma_used_bit_vec;

  cdnsdru_asf_trans_timeout_v1 #(.p_count_width(11)) i_lu1_timer (
    .clock          (hclk),
    .reset_n        (n_hreset),
    .timeout_val    (lockup_time),
    .enable         (lu1_en),
    .timer_cnt_en   (lu1_cnt_en),
    .trans_req      (lu1_start),
    .trans_resp     (lu1_stop),
    .trans_timeout  (lu1_to)
  );

  // ---------------------------------------------------------------------------
  // Part 2 of the lockup detection mechanism...
  //
  // This continues on from the previous part and keeps track of the number of
  // packets in flight across the DMA.
  // The number of packets is incremented each time tx_edma_full_pkt_inc is
  // active and decremented each time tx_fif_full_pkt_inc is seen indicating that
  // a full packet has passed the FIFO interface towards the MAC.
  // Note that for cases where half duplex operation is used and collisions
  // occurs, this mechanism may not be accurate due to retries that may
  // cause additional frames to be transmitted. In such cases the lockup mechanism
  // should not be enabled.
  wire  lu2_en;       // Enable lockup detection for part 2
  wire  lu2_cnt_en;   // Timer count enable for prescaler
  wire  lu2_inc;      // Increment number of packets
  wire  lu2_dec;      // Decrement number of packets
  wire  lu2_to;       // Timeout occurred for part 2

  // Enable lockup detection when TX and lockup monitoring are enabled
  // Force clear down when major error occurs.
  // Also check that the queue is enabled, this is a static configuration option.
  assign lu2_en = tx_enable_s & ~tx_disable_queue & lockup_detect_en_s & ~tx_edma_lockup_flush;

  // Prescaler is used to scale the counter range.
  assign lu2_cnt_en = lockup_count_en & lockup_timer_en_s;

  // Increment the packet count based on tx_edma_full_pkt_inc
  assign lu2_inc  = tx_edma_full_pkt_inc;

  // Decrement when passed the FIFO interface
  assign lu2_dec  = tx_fif_full_pkt_inc_s;

  edma_gen_cnt_to #(
    .p_cnt_wid(8),
    .p_to_wid (11)
  ) i_lu2_timer (
    .clock          (hclk),
    .reset_n        (n_hreset),
    .timeout_val    (lockup_time),
    .enable         (lu2_en),
    .timer_cnt_en   (lu2_cnt_en),
    .cnt_inc        (lu2_inc),
    .cnt_dec        (lu2_dec),
    .count          (),
    .to_err         (lu2_to)
  );


  // ---------------------------------------------------------------------------
  // Generate signal for interrupt generation, will only clear when datapath is disabled.
  // ---------------------------------------------------------------------------
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      lockup_detected  <= 1'b0;
    else
      if (~tx_enable_s | ~lockup_detect_en_s | tx_disable_queue)
        lockup_detected <= 1'b0;
      else
        if (lu1_to | lu2_to)
          lockup_detected  <= 1'b1;
  end


endmodule

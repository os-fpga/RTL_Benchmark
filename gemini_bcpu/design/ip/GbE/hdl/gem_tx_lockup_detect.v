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
//   Filename:           gem_tx_lockup_detect.v
//   Module Name:        gem_tx_lockup_detect
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
//   Description    : Lockup detection for the GEM MAC TX.
//                    Implements the following functions:
//                      - If a complete packet is written to the FIFO interface
//                        i.e. a 'eop' was written, then we expect a related
//                        eop to be signalled downstream by the MII bridge
//
//                    Note that if the DMA is also instantiated, there is a
//                    separate lockup detection to check that the FIFO interface
//                    is initiated within a certain time. Both these modules
//                    will be looking at the same FIFO i/f signal so if there
//                    is a fault then either this or the other lockup detect
//                    module should trigger.
//
//------------------------------------------------------------------------------


module gem_tx_lockup_detect (

  input           tx_clk,           // Transmit data clock
  input           n_txreset,        // Async reset

  input           tx_enable,        // Enable TX datapath
  input           lockup_detect_en, // Enable for lockup detection.
  input   [10:0]  tx_lockup_time,   // Timeout value
  input           lockup_cnt_tog,   // Prescaler enable
  
  //input         tx_fifo_if_start, // Start condition of packet. Commented and not deleted for future enhancements
  input           tx_fifo_if_end,   // End condition of packet.
  //input         tx_sop_pulse,     // Feedback from MII bridge. Commented and not deleted for future enhancements
  input           tx_eop_pulse,     // Feedback from MII bridge

  output  reg     lockup_detected   // Indicate lockup detected.

);

  wire          tx_enable_s;
  wire          lockup_detect_en_s;
  wire          tx_fifo_if_end_re;
  wire          lockup_cnt_en;

  // Hookups to generic transaction timeout module
  wire          lu1_en;
  wire          lu1_cnt_en;
  wire          lu1_start;
  wire          lu1_stop;
  wire          lu1_to;

  // Synchronise tx_enable
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tx_enable (
    .clk    (tx_clk),
    .reset_n(n_txreset),
    .din    (tx_enable),
    .dout   (tx_enable_s)
  );

  // Synchronise the lockup_detect_en signal.
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_en_lockup_det (
    .clk    (tx_clk),
    .reset_n(n_txreset),
    .din    (lockup_detect_en),
    .dout   (lockup_detect_en_s)
  );

  // Rising edge detect of FIFO i/f signal
  edma_toggle_detect i_edma_sync_toggle_detect_tx_if_re (
    .clk      (tx_clk),
    .reset_n  (n_txreset),
    .din      (tx_fifo_if_end),
    .rise_edge(tx_fifo_if_end_re),
    .fall_edge(),
    .any_edge ()
  );

  // Edge detect of prescaler
  edma_toggle_detect i_edma_sync_toggle_detect_lockup_cnt_en (
    .clk      (tx_clk),
    .reset_n  (n_txreset),
    .din      (lockup_cnt_tog),
    .rise_edge(lockup_cnt_en),
    .fall_edge(),
    .any_edge ()
  );

  // Enable lockup detection when TX and lockup monitoring are enabled
  assign lu1_en = tx_enable_s & lockup_detect_en_s;

  // Prescaler is used to scale the counter range.
  // Combine with start trigger to ensure initial count starts
  assign lu1_cnt_en = lockup_cnt_en | lu1_start;

  // Start counting when EOP passed FIFO i/f
  assign lu1_start  = tx_fifo_if_end_re;

  // Stop when EOP is seen at MII bridge
  assign lu1_stop   = tx_eop_pulse;

  // Generic timer
  cdnsdru_asf_trans_timeout_v1 #(.p_count_width(11)) i_lu1_timer (
    .clock          (tx_clk),
    .reset_n        (n_txreset),
    .timeout_val    (tx_lockup_time),
    .enable         (lu1_en),
    .timer_cnt_en   (lu1_cnt_en),
    .trans_req      (lu1_start),
    .trans_resp     (lu1_stop),
    .trans_timeout  (lu1_to)
  );

  // Generate signal for interrupt generation, will only clear when datapath is disabled.
  always@(posedge tx_clk or negedge n_txreset)
  begin
    if (~n_txreset)
      lockup_detected  <= 1'b0;
    else
      if (~lockup_detect_en_s | ~tx_enable_s)
        lockup_detected <= 1'b0;
      else
        if (lu1_to)
          lockup_detected  <= 1'b1;
  end


endmodule

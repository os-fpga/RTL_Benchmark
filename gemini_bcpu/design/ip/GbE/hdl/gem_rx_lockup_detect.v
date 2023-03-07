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
//   Filename:           gem_rx_lockup_detect.v
//   Module Name:        gem_rx_lockup_detect
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
//   Description    : Lockup detection for the GEM MAC RX.
//                    Implements the following functions:
//                      - Checks time interval between receiving good end of
//                        packets on RX FIFO i/f. Relies on system integrator to
//                        ensure that receive frames are injected regularly. This
//                        starts counting from when receive datapath is enabled.
//
//                    Note that if the DMA is also instantiated, there is a
//                    separate lockup detection to check that the DMA state
//                    machines progresses within a certain time. Both these
//                    modules will be looking at the same FIFO i/f signals so if
//                    there is a fault then either this or the other lockup
//                    detect module should trigger.
//
//------------------------------------------------------------------------------


module gem_rx_lockup_detect (

  input           rx_clk,             // Receive data clock
  input           n_rxreset,          // Async reset
  input           rx_enable_s,        // Enable receive data path
  input           lockup_detect_en_s, // Enable for lockup detection.
  input   [15:0]  lockup_time,        // Timeout for lockup check
  input           lockup_cnt_tog,     // Prescaler toggle
  input           rx_fifo_if_end,     // Good end indicator on RX FIFO i/f.
  output  reg     lockup_detected     // Indicate lockup detected.

);

  wire          rx_fifo_if_end_re;    // Rising edge detect, not synchronised
  wire          lockup_cnt_tog_e;     // Edge detect, synchronised

  // Hookups to generic transaction timeout module
  wire          lu1_en;
  wire          lu1_cnt_en;
  wire          lu1_start;
  wire          lu1_stop;
  wire          lu1_to;

  // Edge detection of rx_fifo_if_end
  // This is a good end only.
  edma_toggle_detect i_edma_toggle_detect_rx_end (
    .clk      (rx_clk),
    .reset_n  (n_rxreset),
    .din      (rx_fifo_if_end),
    .rise_edge(rx_fifo_if_end_re),
    .fall_edge(),
    .any_edge ()
  );

  // Edge detection of lockup_cnt_tog
  edma_sync_toggle_detect i_edma_sync_toggle_detect_cnt_tog (
    .clk      (rx_clk),
    .reset_n  (n_rxreset),
    .din      (lockup_cnt_tog),
    .rise_edge(),
    .fall_edge(),
    .any_edge (lockup_cnt_tog_e)
  );

  // Enable lockup detection when RX and lockup monitoring are enabled
  assign lu1_en = rx_enable_s & lockup_detect_en_s;

  // Prescaler is used to scale the counter range.
  assign lu1_cnt_en = lockup_cnt_tog_e;

  // Start counting when ever the prescaler toggles
  assign lu1_start  = lu1_cnt_en;

  // Stop when good end is seen
  assign lu1_stop   = rx_fifo_if_end_re;

  cdnsdru_asf_trans_timeout_v1 #(.p_count_width(16)) i_lu1_timer (
    .clock          (rx_clk),
    .reset_n        (n_rxreset),
    .timeout_val    (lockup_time),
    .enable         (lu1_en),
    .timer_cnt_en   (lu1_cnt_en),
    .trans_req      (lu1_start),
    .trans_resp     (lu1_stop),
    .trans_timeout  (lu1_to)
  );

  // Generate signal for interrupt generation, will only clear when datapath is disabled.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      lockup_detected  <= 1'b0;
    else
      if (~lockup_detect_en_s | ~rx_enable_s)
        lockup_detected <= 1'b0;
      else
        if (lu1_to)
          lockup_detected  <= 1'b1;
  end


endmodule

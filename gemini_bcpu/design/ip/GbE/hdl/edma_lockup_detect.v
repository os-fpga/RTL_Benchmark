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
//   Filename:           edma_lockup_detect.v
//   Module Name:        edma_lockup_detect
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
//   Description    : Top level lockup detection module for the GEM DMA.
//                    Instantiates the TX and RX lockup detection modules which
//                    will be monitoring up to the FIFO interface.
//
//------------------------------------------------------------------------------


module edma_lockup_detect #(
  parameter p_edma_queues       = 32'd1,
  parameter p_edma_spram        = 1'b0
) (

  input             hclk,                 // AMBA clock
  input             n_hreset,             // Asynchronous reset
  input             pclk,                 // APB clock
  input             n_preset,             // Asynchronous reset
  input             tx_clk,               // TX clock
  input             n_txreset,            // Async reset
  input             rx_clk,               // RX clock
  input             n_rxreset,            // Async reset

  input             lockup_prescale_tog,  // Prescaler
  input   [10:0]    lockup_time,          // Timeout for lockup check
  input             full_duplex,          // Configured for full duplex operation
  input             rsc_en,               // Receive side coalescing enable
  input             tx_cutthru,           // TX cutthru enable
  input             rx_cutthru,           // RX cutthru enable
  input             tx_lockup_mon_en,     // Enable for lockup detection.
  input             rx_lockup_mon_en,     // Enable for lockup detection
  input   [p_edma_queues-1:0]
                    tx_lockup_q_en,       // Per queue enable
  input             tx_enable,            // Enable for transmit datapath
  input             rx_enable,            // Enable for receive datapath
  input   [p_edma_queues-1:0]
                    tx_disable_queue,     // Per-queue disable
  input             tx_start_pclk,        // Register control start TX

  // Signals from edma_pbuf_tx_wr
  input   [p_edma_queues-1:0]
                    tx_edma_full_pkt_inc, // Full packet stored
  input   [p_edma_queues-1:0]
                    tx_edma_used_bit_vec, // Used bit read for each queue
  input             tx_edma_lockup_flush, // Major error flush
  input   [p_edma_queues-1:0]
                    tx_fif_full_pkt_inc,  // FIFO interface full packet passed

  input             rx_w_wr,              // RX FIFO interface
  input             rx_w_eop,
  input             rx_w_err,
  input             rx_edma_overflow,     // Overflow of SRAM, packet discarded
  input             rx_dma_pkt_flushed,   // Toggle packet was flushed due to error
  input             rx_dma_complete_ok,   // Packet processed through DMA ok

  output            tx_lockup_detected,   // Lockup has occurred.
  output            rx_lockup_detected    // Lockup has occurred.

);

  wire              lockup_count_en;
  wire              tx_lockup_mon_en_s;
  wire              tx_enable_s;
  wire              tx_start_trig_s;

  wire              rx_lockup_mon_en_s;
  wire              rx_enable_s;
  wire              rx_fifo_if_end;       // End of packet ok in rx_clk
  wire              rx_fifo_if_pkt_inc_e; // Synchronised pulse in hclk
  wire              rx_dma_pkt_flushed_e; // Packet flush due to error, edge det
  wire              rx_dma_complete_ok_e; // Rising edge detected

  wire  [p_edma_queues-1:0] tx_lockup_detected_int;
  wire                      rx_lockup_detected_int;

  genvar g_tx_queue;


  // ---------------------------------------------------------------------------
  // Generic synchronisation and common logic
  // ---------------------------------------------------------------------------

  // Synchronise the lockup_detect_en signal. This also qualifies the
  // frame_cycles_max signal so software should ensure that the lockup detection
  // is not enabled until the signals have been correctly setup.
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tx_en_lockup_det (
    .clk    (hclk),
    .reset_n(n_hreset),
    .din    (tx_lockup_mon_en),
    .dout   (tx_lockup_mon_en_s)
  );
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_rx_en_lockup_det (
    .clk    (hclk),
    .reset_n(n_hreset),
    .din    (rx_lockup_mon_en),
    .dout   (rx_lockup_mon_en_s)
  );

  // Synchronise the transmit datapath enable to be used for clearing down the
  // lockup detection event
  // Note that only full duplex is supported to ensure that packet counting is
  // accurate and not affected by collisions causing frame replays.
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tx_enable (
    .clk    (hclk),
    .reset_n(n_hreset),
    .din    (tx_enable & full_duplex & ~tx_cutthru),
    .dout   (tx_enable_s)
  );
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_rx_enable (
    .clk    (hclk),
    .reset_n(n_hreset),
    .din    (rx_enable & ~rsc_en & ~rx_cutthru),
    .dout   (rx_enable_s)
  );


  // The count value is synchronised to the AMBA domain to generate pulses.
  edma_sync_toggle_detect i_edma_sync_toggle_detect_lockup_count_en (
    .clk      (hclk),
    .reset_n  (n_hreset),
    .din      (lockup_prescale_tog),
    .rise_edge(),
    .fall_edge(),
    .any_edge (lockup_count_en)
  );


  // ---------------------------------------------------------------------------
  // TX Lockup Detection
  // ---------------------------------------------------------------------------

  // Generate a start trigger pulse in hclk domain
  // The start is actually a toggle and changes everytime software writes to that
  // register. Assumes software write rate slower than hclk rate.
  edma_sync_toggle_detect i_edma_sync_toggle_detect_tx_start (
    .clk      (hclk),
    .reset_n  (n_hreset),
    .din      (tx_start_pclk),
    .rise_edge(),
    .fall_edge(),
    .any_edge (tx_start_trig_s)
  );

  // If in DPRAM mode, the tx_fif_full_pkt_inc signals needs to be synchronised
  // to the DMA clock domain.
  wire  [p_edma_queues-1:0] tx_fif_full_pkt_inc_s;
  generate if (p_edma_spram == 1) begin : gen_spram_fifo_if
    edma_toggle_detect i_toggle_detect_tx_pkt_inc[p_edma_queues-1:0] (
      .clk      (hclk),
      .reset_n  (n_hreset),
      .din      (tx_fif_full_pkt_inc),
      .rise_edge(tx_fif_full_pkt_inc_s),
      .fall_edge(),
      .any_edge ()
    );
  end else begin : gen_dpram_fifo_if
    gem_pulse_tsync i_psync_tx_pkt_inc[p_edma_queues-1:0] (
      .src_clk    (tx_clk),
      .src_rst_n  (n_txreset),
      .dest_clk   (hclk),
      .dest_rst_n (n_hreset),
      .src_in     (tx_fif_full_pkt_inc),
      .dest_pulse (tx_fif_full_pkt_inc_s)
    );
  end
  endgenerate


  // Instantiate the TX lockup detection for each queue
  edma_tx_lockup_detect i_tx_lockup_det[p_edma_queues-1:0] (
    .hclk                 (hclk),
    .n_hreset             (n_hreset),
    .lockup_count_en      (lockup_count_en),
    .lockup_time          (lockup_time),
    .lockup_detect_en_s   (tx_lockup_mon_en_s & full_duplex & ~tx_cutthru),
    .lockup_timer_en      (tx_lockup_q_en),
    .tx_enable_s          (tx_enable_s),
    .tx_disable_queue     (tx_disable_queue),
    .tx_start_trig_s      (tx_start_trig_s),
    .tx_edma_full_pkt_inc (tx_edma_full_pkt_inc),
    .tx_edma_used_bit_vec (tx_edma_used_bit_vec),
    .tx_edma_lockup_flush (tx_edma_lockup_flush),
    .tx_fif_full_pkt_inc_s(tx_fif_full_pkt_inc_s),
    .lockup_detected      (tx_lockup_detected_int)
  );

  wire tx_lockup_detected_int_c;
  generate if (p_edma_queues > 32'd1) begin : gen_reg_tx_lockup_det
    reg tx_lockup_detected_int_r;
    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        tx_lockup_detected_int_r  <= 1'b0;
      else
        tx_lockup_detected_int_r  <= |tx_lockup_detected_int;
    end
    assign tx_lockup_detected_int_c = tx_lockup_detected_int_r;
  end else begin : gen_no_reg_tx_lockup_det
    assign tx_lockup_detected_int_c = tx_lockup_detected_int;
  end
  endgenerate

  // Synchronise the tx_lockup_detected signal to pclk
  // The source is long time stable as only clears down when software writes to disable TX.
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tx_lockup_det (
    .clk    (pclk),
    .reset_n(n_preset),
    .din    (tx_lockup_detected_int_c),
    .dout   (tx_lockup_detected)
  );


  // ---------------------------------------------------------------------------
  // RX Lockup Detection
  // ---------------------------------------------------------------------------

  // The FIFO interface is in a different clock domain so we need to signal it to the DMA domain through a toggle.
  assign rx_fifo_if_end = rx_w_wr & rx_w_eop & ~rx_w_err & ~rx_edma_overflow;
  gem_pulse_tsync i_psync_rx_pkt_inc (
    .src_clk    (rx_clk),
    .src_rst_n  (n_rxreset),
    .dest_clk   (hclk),
    .dest_rst_n (n_hreset),
    .src_in     (rx_fifo_if_end),
    .dest_pulse (rx_fifo_if_pkt_inc_e)
  );

  // The rx_dma_pkt_flushed is actually a toggle signal, so edge detect it.
  edma_toggle_detect i_edma_sync_toggle_detect_rx_dma_pkt_flushed (
    .clk      (hclk),
    .reset_n  (n_hreset),
    .din      (rx_dma_pkt_flushed),
    .rise_edge(),
    .fall_edge(),
    .any_edge (rx_dma_pkt_flushed_e)
  );

  // The rx_dma_complete_ok is a rising edge signal
  edma_toggle_detect i_edma_sync_toggle_detect_rx_dma_complete_ok_e (
    .clk      (hclk),
    .reset_n  (n_hreset),
    .din      (rx_dma_complete_ok),
    .rise_edge(rx_dma_complete_ok_e),
    .fall_edge(),
    .any_edge ()
  );

  // Instantiate RX lockup detection
  edma_rx_lockup_detect i_rx_lockup_det (
    .hclk                 (hclk),
    .n_hreset             (n_hreset),
    .lockup_count_en      (lockup_count_en),
    .lockup_time          (lockup_time),
    .lockup_detect_en_s   (rx_lockup_mon_en_s),
    .rx_enable_s          (rx_enable_s),
    .rx_fifo_if_pkt_inc_e (rx_fifo_if_pkt_inc_e),
    .rx_dma_pkt_flushed_e (rx_dma_pkt_flushed_e),
    .rx_dma_complete_ok_e (rx_dma_complete_ok_e),
    .lockup_detected      (rx_lockup_detected_int)
  );


  // Synchronise the rx_lockup_detected signal to pclk
  // The source is long time stable as only clears down when software writes to disable RX.
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_rx_lockup_det (
    .clk    (pclk),
    .reset_n(n_preset),
    .din    (rx_lockup_detected_int),
    .dout   (rx_lockup_detected)
  );


endmodule

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
//   Filename:           gem_mac_lockup_detect.v
//   Module Name:        gem_mac_lockup_detect
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
//   Description    : Top level lockup detection module for the GEM MAC.
//                    Instantiates the TX and RX lockup detection modules which
//                    will be monitoring from the FIFO interface.
//
//------------------------------------------------------------------------------


module gem_mac_lockup_detect (

  input           tx_clk,             // Transmit data clock
  input           n_txreset,          // Async reset
  input           rx_clk,             // Receive data clock
  input           n_rxreset,          // Async reset

  input           pclk,               // APB clock
  input           n_preset,           // Async reset

  input   [15:0]  lockup_prescale_val,// TX clock cycle count for prescaler
  input   [10:0]  tx_lockup_time,     // Lockup timeout for TX
  input   [15:0]  rx_lockup_time,     // Lockup timeout for RX activity check
  input           tx_enable,          // Enable TX datapath
  input           rx_enable,          // Enable RX datapath

  input           tx_r_valid,         // FIFO i/f to MAC
  //input         tx_r_sop,           // Commented and not deleted for future enhancements
  input           tx_r_eop,
  //input         tx_sop_pulse,       // New packet start at MII bridge. Commented and not deleted for future enhancements
  input           tx_eop_pulse,       // New packet end at MII bridge

  input           rx_w_wr,            // RX FIFO from MAC
  //input         rx_w_sop,           // Commented and not deleted for future enhancements
  input           rx_w_eop,       
  input           rx_w_err,
  input           rx_w_bad_frame,

  input           tx_lockup_mon_en,   // Enable for lockup detection.
  input           rx_lockup_mon_en,   // Enable for lockup detection.

  output  reg     lockup_prescale_tog,// Toggle for prescaler
  output          tx_lockup_detected, // Indicate lockup detected.
  output          rx_lockup_detected  // Indicate lockup detected.

);

  wire  [15:0]  last_prescale_val;    // Last value that was sync'd
  wire  [15:0]  lockup_prescale_val_s;// Prescale in tx_clk
  wire          new_prescale_val;     // New value synchronised
  reg   [15:0]  prescale_count;       // Local prescaler
  wire          count_zero;           // Count reached 0


  // Synchronise the prescaler value to tx_clk domain
  gem_bus_sync #(.p_dwidth(16), .p_reg_out(1)) i_bus_sync_prescaler (
    .src_clk      (pclk),
    .src_rst_n    (n_preset),
    .dest_clk     (tx_clk),
    .dest_rst_n   (n_txreset),
    .src_data     (lockup_prescale_val),
    .src_xfer_en  (lockup_prescale_val != last_prescale_val),
    .src_data_last(last_prescale_val),
    .src_rdy      (),
    .dest_data    (lockup_prescale_val_s),
    .dest_val     (new_prescale_val)
  );

  // Prescaler
  assign count_zero = ~(|prescale_count);
  always@(posedge tx_clk or negedge n_txreset)
  begin
    if (~n_txreset)
    begin
      prescale_count      <= 16'h0000;
      lockup_prescale_tog <= 1'b0;
    end
    else
    begin
      if (new_prescale_val | count_zero)
        prescale_count  <= lockup_prescale_val_s;
      else
        prescale_count  <= prescale_count - 16'd1;

      lockup_prescale_tog <= count_zero ^ lockup_prescale_tog;
    end
  end


  //----------------------------------------------------------------------------
  // TX lockup detection
  //----------------------------------------------------------------------------
  // Commented and not deleted for future enhancements
  //  wire      tx_fifo_if_start;
  //  assign tx_fifo_if_start = tx_r_valid & tx_r_sop;

  wire      tx_fifo_if_end;
  wire      tx_lockup_detected_int;


  // Decode FIFO interface
  assign tx_fifo_if_end   = tx_r_valid & tx_r_eop;

  // Instantiate TX lockup detection
  gem_tx_lockup_detect i_tx_lockup_detect (
    .tx_clk           (tx_clk),
    .n_txreset        (n_txreset),
    .tx_enable        (tx_enable),
    .lockup_detect_en (tx_lockup_mon_en),
    .tx_lockup_time   (tx_lockup_time),
    .lockup_cnt_tog   (lockup_prescale_tog),
    //.tx_fifo_if_start (tx_fifo_if_start), Commented and not deleted for future enhancements
    .tx_fifo_if_end   (tx_fifo_if_end),
    //.tx_sop_pulse   (tx_sop_pulse), Commented and not deleted for future enhancements
    .tx_eop_pulse     (tx_eop_pulse),
    .lockup_detected  (tx_lockup_detected_int)
  );

  // Synchronise the tx_lockup_detected signal to pclk
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tx_lockup_det (
    .clk    (pclk),
    .reset_n(n_preset),
    .din    (tx_lockup_detected_int),
    .dout   (tx_lockup_detected)
  );


  //----------------------------------------------------------------------------
  // RX lockup detection
  //----------------------------------------------------------------------------
  wire      rx_lockup_mon_en_s;
  wire      rx_enable_s;
  wire      rx_fifo_if_eop;
  wire      rx_fifo_if_end;
  wire      rx_lockup_detected_int;

  // Synchronise the lockup_detect_en signal.
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_en_lockup_det (
    .clk    (rx_clk),
    .reset_n(n_rxreset),
    .din    (rx_lockup_mon_en),
    .dout   (rx_lockup_mon_en_s)
  );

  // Synchronise rx_enable
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_rx_enable (
    .clk    (rx_clk),
    .reset_n(n_rxreset),
    .din    (rx_enable),
    .dout   (rx_enable_s)
  );

  // Decode FIFO i/f signals
  // Commented this wire to avoid annoying
  // LINT warnings but kept here for
  // possible future use
  // wire   rx_fifo_if_start;
  // assign rx_fifo_if_start = rx_w_wr & rx_w_sop;

  assign rx_fifo_if_eop   = rx_w_wr & rx_w_eop;
  assign rx_fifo_if_end   = rx_fifo_if_eop & ~rx_w_err & ~rx_w_bad_frame;

  // Instantiate RX lockup detection
  gem_rx_lockup_detect  i_rx_lockup_detect (
    .rx_clk             (rx_clk),
    .n_rxreset          (n_rxreset),
    .rx_enable_s        (rx_enable_s),
    .lockup_time        (rx_lockup_time),
    .lockup_detect_en_s (rx_lockup_mon_en_s),
    .lockup_cnt_tog     (lockup_prescale_tog),
    .rx_fifo_if_end     (rx_fifo_if_end),
    .lockup_detected    (rx_lockup_detected_int)
  );

  // Synchronise the rx_lockup_detected signal to pclk
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_rx_lockup_det (
    .clk    (pclk),
    .reset_n(n_preset),
    .din    (rx_lockup_detected_int),
    .dout   (rx_lockup_detected)
  );


endmodule

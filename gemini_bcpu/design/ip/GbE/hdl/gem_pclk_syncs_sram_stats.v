//------------------------------------------------------------------------------
// Copyright (c) 2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_pclk_syncs_sram_stats.v
//   Module Name:        gem_pclk_syncs_sram_stats
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
//   Description    : Handle statistics and status clock synchronisation if
//                    ASF is used. This module will not be instantiated if the
//                    SRAM has no protection.
//
//------------------------------------------------------------------------------
//   Limitations    : Assumption is that the clock frequencies are such that
//                    the accumulator should never saturate so there is not an
//                    explicit check condition for saturation.
//
//------------------------------------------------------------------------------


module gem_pclk_syncs_sram_stats #(
  parameter p_tx_addr_width = 16,
  parameter p_rx_addr_width = 16,
  parameter p_corr_stats    = 1'b1
)(
  input                   pclk,           // Destination clock domain
  input                   n_preset,       // Async reset
  input                   tx_rd_clk,      // Clock for TX SRAM read interface
  input                   tx_rd_rst_n,    // Async reset
  input                   rx_rd_clk,      // Clock for RX SRAM read interface
  input                   rx_rd_rst_n,    // Async reset
  input                   tx_corr_err,    // Correctable error for TX SRAM
  input                   tx_uncorr_err,  // Uncorrectable error for TX SRAM
  input   [p_tx_addr_width-1:0]
                          tx_err_addr,    // Address of TX SRAM error
  input                   rx_corr_err,    // Correctable error for RX SRAM
  input                   rx_uncorr_err,  // Uncorrectable error for RX SRAM
  input   [p_rx_addr_width-1:0]
                          rx_err_addr,    // Address of RX SRAM error
  output                  asf_sram_corr_fault,
  output  [7:0]           asf_sram_corr_fault_stats_upd,
  output  [31:0]          asf_sram_corr_fault_status,
  output                  asf_sram_uncorr_fault,
  output  [31:0]          asf_sram_uncorr_fault_status

);

  // Internal signals
  wire  [p_tx_addr_width-1:0]
                tx_uncorr_dat_pclk; // Value that can be used in pclk domain
  wire          tx_uncorr_val_pclk; // Qualifier for above tx_corr_dat_pclk
  wire  [p_rx_addr_width-1:0]
                rx_uncorr_dat_pclk; // Value that can be used in pclk domain
  wire          rx_uncorr_val_pclk; // Qualifier for above tx_corr_dat_pclk
  wire  [31:0]  tx_uncorr_addr;   // Pad to 32-bit for easier access
  wire  [31:0]  rx_uncorr_addr;   // ""

  generate if (p_corr_stats == 1) begin : gen_corr_stats
    reg   [6:0]   tx_accum;         // Accumulator for count to be transferred
    wire  [7:0]   tx_accum_nxt;     // Addition.
    reg   [p_tx_addr_width-1:0]
                  tx_addr_store;    // Store address until transfer window
    wire          tx_new_corr_stat; // New statistics transfer when accum > 0.
    wire  [p_tx_addr_width+6:0]
                  tx_corr_xfer_dat; // Value to transfer to pclk
    wire          tx_src_rdy;       // Ready to transfer new value
    wire  [p_tx_addr_width+6:0]
                  tx_corr_dat_pclk; // Value that can be used in pclk domain
    wire          tx_corr_val_pclk; // Qualifier for above tx_corr_dat_pclk

    // Similarly for RX SRAM information
    reg   [6:0]   rx_accum;         // Accumulator for count to be transferred
    wire  [7:0]   rx_accum_nxt;     // Addition.
    reg   [p_rx_addr_width-1:0]
                  rx_addr_store;    // Store address until transfer window
    wire          rx_new_corr_stat; // New statistics transfer when accum > 0.
    wire  [p_rx_addr_width+6:0]
                  rx_corr_xfer_dat; // Value to transfer to pclk
    wire          rx_src_rdy;       // Ready to transfer new value
    wire  [p_rx_addr_width+6:0]
                  rx_corr_dat_pclk; // Value that can be used in pclk domain
    wire          rx_corr_val_pclk; // Qualifier for above tx_corr_dat_pclk

    wire  [31:0]  tx_corr_addr;     // Pad to 32-bit for easier access
    wire  [31:0]  rx_corr_addr;     // ""

    // Only signal something if accumulator is non-zero.
    // Note that we could've had the error signal the transfer directly rather
    // than first incrementing the accumulator. However the accumulator and
    // address store is always required either way so implementing this way
    // is simpler.
    assign tx_new_corr_stat = |tx_accum;

    assign tx_accum_nxt = tx_accum + {6'h00,tx_corr_err};

    // Update accumulator and store address.
    // For the first error, the stored address would be the value transferred.
    // For subsequent errors, if a transfer is already taking place, then the next
    // address that is transferred would be the last address that had an error.
    always@(posedge tx_rd_clk or negedge tx_rd_rst_n)
    begin
      if (~tx_rd_rst_n)
      begin
        tx_accum      <= 7'h00;
        tx_addr_store <= {p_tx_addr_width{1'b0}};
      end
      else
      begin
        if (tx_corr_err)
          tx_addr_store <= tx_err_addr;
        if (tx_src_rdy)
          tx_accum  <= {6'h00,tx_corr_err};
        else
          tx_accum  <= tx_accum_nxt[6:0] | {7{tx_accum_nxt[7]}};  // Saturate at max no rollover
      end
    end

    // The data to transfer to the fault logging module is accumulator value and
    // address.
    assign tx_corr_xfer_dat = {tx_addr_store,tx_accum};

    gem_bus_sync #(
      .p_dwidth   (p_tx_addr_width+7),
      .p_reg_out  (1)
    ) i_bus_sync_tx_corr (
      .src_clk      (tx_rd_clk),
      .src_rst_n    (tx_rd_rst_n),
      .dest_clk     (pclk),
      .dest_rst_n   (n_preset),
      .src_data     (tx_corr_xfer_dat),
      .src_xfer_en  (tx_new_corr_stat),
      .src_data_last(),
      .src_rdy      (tx_src_rdy),
      .dest_data    (tx_corr_dat_pclk),
      .dest_val     (tx_corr_val_pclk)
    );

    // Repeat for RX information
    assign rx_new_corr_stat = |rx_accum;
    assign rx_accum_nxt     = rx_accum + {6'h00,rx_corr_err};
    always@(posedge rx_rd_clk or negedge rx_rd_rst_n)
    begin
      if (~rx_rd_rst_n)
      begin
        rx_accum      <= 7'h00;
        rx_addr_store <= {p_rx_addr_width{1'b0}};
      end
      else
      begin
        if (rx_corr_err)
          rx_addr_store <= rx_err_addr;
        if (rx_src_rdy)
          rx_accum  <= {6'h00,rx_corr_err};
        else
          rx_accum  <= rx_accum_nxt[6:0] | {7{rx_accum_nxt[7]}};  // Saturate at max no rollover
      end
    end
    assign rx_corr_xfer_dat = {rx_addr_store,rx_accum};
    gem_bus_sync #(
      .p_dwidth   (p_rx_addr_width+7),
      .p_reg_out  (1)
    ) i_bus_sync_rx_corr (
      .src_clk      (rx_rd_clk),
      .src_rst_n    (rx_rd_rst_n),
      .dest_clk     (pclk),
      .dest_rst_n   (n_preset),
      .src_data     (rx_corr_xfer_dat),
      .src_xfer_en  (rx_new_corr_stat),
      .src_data_last(),
      .src_rdy      (rx_src_rdy),
      .dest_data    (rx_corr_dat_pclk),
      .dest_val     (rx_corr_val_pclk)
    );

    // Combine the information from both sources to provide to the fault logging block.
    // Currently a fault in the TX will have higher priority in terms of logging the address

    assign tx_corr_addr = {{(32-p_tx_addr_width){1'b0}},
                            tx_corr_dat_pclk[p_tx_addr_width+6:7]};
    assign rx_corr_addr = {{(32-p_rx_addr_width){1'b0}},
                            rx_corr_dat_pclk[p_rx_addr_width+6:7]};

    assign asf_sram_corr_fault  = tx_corr_val_pclk | rx_corr_val_pclk;
    assign asf_sram_corr_fault_stats_upd  = ({7{tx_corr_val_pclk}} & tx_corr_dat_pclk[6:0]) +
                                            ({7{rx_corr_val_pclk}} & rx_corr_dat_pclk[6:0]);
    assign asf_sram_corr_fault_status     = tx_corr_val_pclk  ? {8'h00,tx_corr_addr[23:0]}
                                                              : {8'h01,rx_corr_addr[23:0]};

  end else begin : gen_no_corr_stats
    assign asf_sram_corr_fault            = 1'b0;
    assign asf_sram_corr_fault_stats_upd  = 8'h00;
    assign asf_sram_corr_fault_status     = 32'd0;
  end
  endgenerate

  // For the uncorrectable information, we transfer the address and only really interested in the first
  // time the error occurred.
  gem_bus_sync #(
    .p_dwidth   (p_tx_addr_width),
    .p_reg_out  (1)
  ) i_bus_sync_tx_uncorr (
    .src_clk      (tx_rd_clk),
    .src_rst_n    (tx_rd_rst_n),
    .dest_clk     (pclk),
    .dest_rst_n   (n_preset),
    .src_data     (tx_err_addr),
    .src_xfer_en  (tx_uncorr_err),
    .src_data_last(),
    .src_rdy      (),
    .dest_data    (tx_uncorr_dat_pclk),
    .dest_val     (tx_uncorr_val_pclk)
  );
  gem_bus_sync #(
    .p_dwidth   (p_rx_addr_width),
    .p_reg_out  (1)
  ) i_bus_sync_rx_uncorr (
    .src_clk      (rx_rd_clk),
    .src_rst_n    (rx_rd_rst_n),
    .dest_clk     (pclk),
    .dest_rst_n   (n_preset),
    .src_data     (rx_err_addr),
    .src_xfer_en  (rx_uncorr_err),
    .src_data_last(),
    .src_rdy      (),
    .dest_data    (rx_uncorr_dat_pclk),
    .dest_val     (rx_uncorr_val_pclk)
  );

  // Pad addresses for easier access
  assign tx_uncorr_addr = {{(32-p_tx_addr_width){1'b0}},
                            tx_uncorr_dat_pclk[p_tx_addr_width-1:0]};
  assign rx_uncorr_addr = {{(32-p_rx_addr_width){1'b0}},
                            rx_uncorr_dat_pclk[p_rx_addr_width-1:0]};

  assign asf_sram_uncorr_fault        = tx_uncorr_val_pclk | rx_uncorr_val_pclk;
  assign asf_sram_uncorr_fault_status = tx_uncorr_val_pclk  ? {8'h00,tx_uncorr_addr[23:0]}
                                                            : {8'h01,rx_uncorr_addr[23:0]};

endmodule

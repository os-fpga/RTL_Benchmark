//------------------------------------------------------------------------------
// Copyright (c) 2001-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_pcs_pclk_sync.v
//   Module Name:        gem_pcs_pclk_sync
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
//   Description    :   Perform double syncing of signals coming from other
//                      clock domains to the pclk domain.
//                      Necessary for protection against metastability.
//
//------------------------------------------------------------------------------


module gem_pcs_pclk_sync (

   // Inputs
   pclk,
   n_preset,
   gtx_clk,
   n_gtxreset,
   rx_clk,
   n_rxreset,
   mr_page_rx,
   mr_link_status,
   mr_an_complete,
   mr_lp_adv_ability,
   mr_lp_np_rx,
   mr_np_loaded_clr,
   mr_base_rf_clear,
   an_full_duplex_mode,
   an_restarted,
   an_pause_tx_en,
   an_pause_rx_en,
   sync_reset_rx,
   sync_reset_txclk,
   tx_dap_err,
   rx_dap_err,

   // Outputs
   mr_page_rx_s,
   mr_link_status_s,
   mr_an_complete_s,
   mr_lp_adv_ability_s,
   mr_lp_np_rx_s,
   mr_np_loaded_clr_s,
   mr_base_rf_clear_s,
   an_full_duplex_mode_s,
   an_restarted_s,
   an_pause_tx_en_s,
   an_pause_rx_en_s,
   sync_reset_rx_s,
   sync_reset_txclk_s,
   tx_dap_err_s,
   rx_dap_err_s
   );

   parameter  p_edma_asf_dap_prot = 1'b0;  // If parity protected.

   // Port declarations

   // Inputs
   input          pclk;                // Sync clock.
   input          n_preset;            // Async reset.
   input          gtx_clk;             // TX datapath clock
   input          n_gtxreset;          // Async reset
   input          rx_clk;              // RX datapath clock
   input          n_rxreset;           // Async reset
   input          mr_page_rx;          // LP page received.
   input          mr_link_status;      // link status.
   input          mr_an_complete;      // Auto neg done.
   input [15:0]   mr_lp_adv_ability;   // LP base page.
   input [15:0]   mr_lp_np_rx;         // LP next page.
   input          mr_np_loaded_clr;    // Clear next page loaded.
   input          mr_base_rf_clear;    // Clear base RF registers
   input          an_full_duplex_mode; // Negotiated to full duplex
   input          an_restarted;        // Autonegotiation restarted
   input          an_pause_tx_en;      // Enable pause tx
   input          an_pause_rx_en;      // Enable pause rx
   input          sync_reset_rx;       // Synchronous reset in rx_clk domain
   input          sync_reset_txclk;    // Synchronous reset in tx_clk domain
   input          tx_dap_err;          // TX datapath error
   input          rx_dap_err;          // RX datapath error

   // Outputs
   output         mr_page_rx_s;        // LP page received.
   output         mr_link_status_s;    // link status.
   output         mr_an_complete_s;    // Auto neg done.
   output [15:0]  mr_lp_adv_ability_s; // LP base page.
   output [15:0]  mr_lp_np_rx_s;       // LP next page.
   output         mr_np_loaded_clr_s;  // Clear next page loaded.
   output         mr_base_rf_clear_s;  // Clear base RF registers
   output         an_full_duplex_mode_s;// Negotiated to full duplex
   output         an_restarted_s;      // Synced an_restarted
   output         an_pause_tx_en_s;    // Enable pause tx
   output         an_pause_rx_en_s;    // Enable pause rx
   output         sync_reset_rx_s;     // Synchronous reset in rx_clk domain
   output         sync_reset_txclk_s;  // Synchronous reset in tx_clk domain
   output         tx_dap_err_s;        // Pulse in pclk domain
   output         rx_dap_err_s;        // Pulse in pclk domain


   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_an_pause_tx_en (
      .clk(pclk),
      .reset_n(n_preset),
      .din(an_pause_tx_en),
      .dout(an_pause_tx_en_s));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_an_pause_rx_en (
      .clk(pclk),
      .reset_n(n_preset),
      .din(an_pause_rx_en),
      .dout(an_pause_rx_en_s));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_an_full_duplex_mode (
      .clk(pclk),
      .reset_n(n_preset),
      .din(an_full_duplex_mode),
      .dout(an_full_duplex_mode_s));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_mr_base_rf_clear (
      .clk(pclk),
      .reset_n(n_preset),
      .din(mr_base_rf_clear),
      .dout(mr_base_rf_clear_s));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_an_restarted (
      .clk(pclk),
      .reset_n(n_preset),
      .din(an_restarted),
      .dout(an_restarted_s));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_mr_page_rx (
      .clk(pclk),
      .reset_n(n_preset),
      .din(mr_page_rx),
      .dout(mr_page_rx_s));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_mr_link_status (
      .clk(pclk),
      .reset_n(n_preset),
      .din(mr_link_status),
      .dout(mr_link_status_s));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_mr_an_complete (
      .clk(pclk),
      .reset_n(n_preset),
      .din(mr_an_complete),
      .dout(mr_an_complete_s));

   cdnsdru_datasync_v1 #(
      .CDNSDRU_DATASYNC_DIN_W(32'd16)
   ) i_cdnsdru_datasync_v1_mr_lp_adv_ability (
      .clk(pclk),
      .reset_n(n_preset),
      .din(mr_lp_adv_ability),
      .dout(mr_lp_adv_ability_s));

   cdnsdru_datasync_v1 #(
      .CDNSDRU_DATASYNC_DIN_W(32'd16)
   ) i_cdnsdru_datasync_v1_mr_lp_np_rx (
      .clk(pclk),
      .reset_n(n_preset),
      .din(mr_lp_np_rx),
      .dout(mr_lp_np_rx_s));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_mr_np_loaded_clr (
      .clk(pclk),
      .reset_n(n_preset),
      .din(mr_np_loaded_clr),
      .dout(mr_np_loaded_clr_s));

   cdnsdru_datasync_v1 #(
      .CDNSDRU_DATASYNC_RESET_STATE(1'b1)
   ) i_cdnsdru_datasync_v1_sync_reset_rx (
      .clk(pclk),
      .reset_n(n_preset),
      .din(sync_reset_rx),
      .dout(sync_reset_rx_s));

   cdnsdru_datasync_v1 #(
      .CDNSDRU_DATASYNC_RESET_STATE(1'b1)
   ) i_cdnsdru_datasync_v1_sync_reset_txclk (
      .clk(pclk),
      .reset_n(n_preset),
      .din(sync_reset_txclk),
      .dout(sync_reset_txclk_s));

   // Synchronise optional datapath parity error indication.
   // This needs to sample in the source domain to generate pulse
   // in the target pclk domain.
   generate if (p_edma_asf_dap_prot == 1) begin : gen_asf_dap_prot
      gem_pulse_tsync i_tsync_tx_dap_err (
         .src_clk   (gtx_clk),
         .src_rst_n (n_gtxreset),
         .dest_clk  (pclk),
         .dest_rst_n(n_preset),
         .src_in    (tx_dap_err),
         .dest_pulse(tx_dap_err_s)
      );
      gem_pulse_tsync i_tsync_rx_dap_err (
         .src_clk   (rx_clk),
         .src_rst_n (n_rxreset),
         .dest_clk  (pclk),
         .dest_rst_n(n_preset),
         .src_in    (rx_dap_err),
         .dest_pulse(rx_dap_err_s)
      );
   end else begin : gen_no_asf_dap_prot
      assign tx_dap_err_s = 1'b0;
      assign rx_dap_err_s = 1'b0;
   end
   endgenerate

endmodule

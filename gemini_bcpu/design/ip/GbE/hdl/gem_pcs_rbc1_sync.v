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
//   Filename:           gem_pcs_rbc1_sync.v
//   Module Name:        gem_pcs_rbc1_sync
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
//                      clock domains to the rbc1 clk domain.
//                      Necessary for protection against metastability.
//
//------------------------------------------------------------------------------


module gem_pcs_rbc1_sync (

   // Inputs
   rbc1_clk,
   n_reset,

   mr_an_enable,
   mr_an_restart,
   mr_adv_ability,
   mr_np_tx,
   mr_np_loaded,
   loopback,
   signal_detect,
   retry_test,
   mr_lp_np_read,

   // Outputs
   mr_an_enable_s,
   mr_an_restart_s,
   mr_adv_ability_s,
   mr_np_tx_s,
   mr_np_loaded_s,
   loopback_s,
   signal_detect_s,
   retry_test_s,
   mr_lp_np_read_s
   );

   // Port declarations

   // Inputs
   input          rbc1_clk;         // Sync clock.
   input          n_reset;          // Async reset.
   input          mr_an_enable;     // Enable auto negotiation.
   input          mr_an_restart;    // Restart auto negotiation.
   input [15:0]   mr_adv_ability;   // Base page to tx.
   input [15:0]   mr_np_tx;         // Next page.
   input          mr_np_loaded;     // Next page available.
   input          loopback;         // Loop back.
   input          signal_detect;    // PMA signal detect
   input          retry_test;       // Debug signal to shorten timer.
   input          mr_lp_np_read;    // Link partner's np read.

   // Outputs
   output         mr_an_enable_s;   // Enable auto negotiation.
   output         mr_an_restart_s;  // Restart auto negotiation.
   output [15:0]  mr_adv_ability_s; // Base page to tx.
   output [15:0]  mr_np_tx_s;       // Next page.
   output         mr_np_loaded_s;   // Next page available.
   output         loopback_s;       // loop back.
   output         signal_detect_s;  // PMA signal detect
   output         retry_test_s;     // Synced version of retry_test
   output         mr_lp_np_read_s;  // Synced ver of mr_lp_np_read

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_mr_an_enable (
      .clk(rbc1_clk),
      .reset_n(n_reset),
      .din(mr_an_enable),
      .dout(mr_an_enable_s));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_mr_an_restart (
      .clk(rbc1_clk),
      .reset_n(n_reset),
      .din(mr_an_restart),
      .dout(mr_an_restart_s));

   cdnsdru_datasync_v1 #(
      .CDNSDRU_DATASYNC_DIN_W(32'd16)
   ) i_cdnsdru_datasync_v1_mr_adv_ability (
      .clk(rbc1_clk),
      .reset_n(n_reset),
      .din(mr_adv_ability),
      .dout(mr_adv_ability_s));

   cdnsdru_datasync_v1 #(
      .CDNSDRU_DATASYNC_DIN_W(32'd16)
   ) i_cdnsdru_datasync_v1_mr_np_tx (
      .clk(rbc1_clk),
      .reset_n(n_reset),
      .din(mr_np_tx),
      .dout(mr_np_tx_s));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_mr_np_loaded (
      .clk(rbc1_clk),
      .reset_n(n_reset),
      .din(mr_np_loaded),
      .dout(mr_np_loaded_s));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_loopback (
      .clk(rbc1_clk),
      .reset_n(n_reset),
      .din(loopback),
      .dout(loopback_s));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_signal_detect (
      .clk(rbc1_clk),
      .reset_n(n_reset),
      .din(signal_detect),
      .dout(signal_detect_s));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_retry_test (
      .clk(rbc1_clk),
      .reset_n(n_reset),
      .din(retry_test),
      .dout(retry_test_s));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_mr_lp_np_read (
      .clk(rbc1_clk),
      .reset_n(n_reset),
      .din(mr_lp_np_read),
      .dout(mr_lp_np_read_s));


endmodule

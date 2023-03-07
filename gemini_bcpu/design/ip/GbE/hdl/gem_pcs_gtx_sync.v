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
//   Filename:           gem_pcs_gtx_sync.v
//   Module Name:        gem_pcs_gtx_sync
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
//                      clock domains to the gtx clk domain.
//                      Necessary for protection against metastability.
//
//------------------------------------------------------------------------------


module gem_pcs_gtx_sync (

   // Inputs.
   gtx_clk,
   n_gtxreset,
   rx_clk,
   n_rxreset,
   tx_config_reg,
   tx_config_reg_par,
   xmit,
   xmit_change_rx,
   col_test,
   sync_reset_pclk,
   link_fault_status,

   // Outputs
   tx_config_reg_s,
   tx_config_reg_par_s,
   xmit_s,
   xmit_change_rx_s,
   col_test_s,
   sync_reset_txclk,
   link_fault_status_s

   );

   // Port declarations

   // Inputs
   input             gtx_clk;          // Sync clock.
   input             n_gtxreset;       // Async reset.
   input             rx_clk;           // RX clock .
   input             n_rxreset;        // Async reset.
   input [15:0]      tx_config_reg;    // Transmit configuration data.
   input [1:0]       tx_config_reg_par;
   input [1:0]       xmit;             // AN type.
   input             xmit_change_rx;   // xmit_change from AN block this
                                       // toggles one rx_clk after when xmit
                                       // changes
   input             col_test;         // Perform collision testing.
   input             sync_reset_pclk;  // Synchronous reset in pclk domain
   input [1:0]       link_fault_status; // 00 - OK; 01 - local fault; 10 - remote fault; 11 - link interruption

   // Outputs
   output [15:0]     tx_config_reg_s;  // Synchronised output signals,
   output [1:0]      tx_config_reg_par_s;
   output [1:0]      xmit_s;           // xmit
   output            xmit_change_rx_s; // xmit_change synchronized to tx_clk
                                       // this toggles a cycle after xmit
                                       // changes to make sure xmit is stable
                                       // when it is used in gem_pcs_txstate.
   output            col_test_s;       // col_test.
   output            sync_reset_txclk; // Synchronous reset in tx_clk domain
   output [1:0]      link_fault_status_s;   // Link Fault status (synchronized)

   // Reg declarations.
   reg [1:0]         xmit_s;           // this is now single synced. It is
                                       // enabled by xmit_change_rx_s which
                                       // toggles a cycle after xmit_s changes


   // Perform the double syncing..

   always@(posedge gtx_clk or negedge n_gtxreset)
      if (~n_gtxreset)
         xmit_s <= 2'b11;
      else
         xmit_s <= xmit;


   // Synchronize inputs into the gtx_clk domain

   cdnsdru_datasync_v1 # (
      .CDNSDRU_DATASYNC_DIN_W(32'd20)
   ) i_cdnsdru_datasync_v1 (
      .clk(gtx_clk),
      .reset_n(n_gtxreset),
      .din( {xmit_change_rx,  col_test,  tx_config_reg_par,   tx_config_reg}),
      .dout({xmit_change_rx_s,col_test_s,tx_config_reg_par_s, tx_config_reg_s}));

   cdnsdru_datasync_v1 # (
      .CDNSDRU_DATASYNC_RESET_STATE(1'b1)
   ) i_cdnsdru_datasync_v1_sync_reset_pclk (
      .clk(gtx_clk),
      .reset_n(n_gtxreset),
      .din(sync_reset_pclk),
      .dout(sync_reset_txclk));

  gem_bus_sync #(
      .p_dwidth (32'd2),
      .p_reg_out(32'd2)
    ) i_bus_sync_link_fault (
      .src_clk      (rx_clk),
      .src_rst_n    (n_rxreset),
      .dest_clk     (gtx_clk),
      .dest_rst_n   (n_gtxreset),
      .src_data     (link_fault_status),
      .src_xfer_en  (1'b1),
      .src_data_last(),
      .src_rdy      (),
      .dest_data    (link_fault_status_s),
      .dest_val     ()
  );

endmodule

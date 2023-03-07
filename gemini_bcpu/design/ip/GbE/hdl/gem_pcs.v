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
//   Filename:           gem_pcs.v
//   Module Name:        gem_pcs
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
//   Description    :   This is the top level block for the Gigabit Ethernet MAC
//                      PCS module. This block instantiates the necessary
//                      transmit, receive, auto-negotiation and register
//                      interface required as well as synchronisation blocks.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_pcs

(
   // AMBA APB interface.
   pclk,
   n_preset,

   paddr,
   pwdata,
   pwdata_par,
   pwrite,
   penable,
   psel,
   prdata,
   prdata_par,
   perr,

   // MAC interface.
   gtx_clk,
   n_gtxreset,

   txd,
   txd_par,
   tx_en,
   tx_er,
   col,
   crs,
   rxd,
   rxd_par,
   rx_er,
   rx_dv,

   cal_bypass,
   cgalign_bypass,

   retry_test,
   alt_sgmii_mode,
   sgmii_mode,
   uni_direct_en,
   tbi,
   full_duplex,
   two_pt_five_gig,
   pcs_link_state,
   pcs_an_complete,
   np_data_int,

   mac_pause_tx_en,
   mac_pause_rx_en,
   mac_full_duplex,

   // TBI signals
   gtx20_clk,
   n_gtx20reset,
   rx_clk,
   n_rxreset,
   rx10_clk,
   n_rx10reset,
   rbc0,
   rbc1,
   n_rbc0reset,
   n_rbc1reset,

   tx_code_group,
   rx_code_group,
   ewrap,
   en_cdet,
   signal_detect,

   // ASF error status
   asf_csr_pcs_err,
   asf_dap_pcs_tx_err,
   asf_dap_pcs_rx_err,

   // Link Fault Status,
   link_fault_signal_en,
   link_fault_status

   );

   parameter [1363:0] grouped_params = {1364{1'b0}};

   `include "ungroup_params.v"

   // Port declarations.

   // test interface.
   // AMBA APB interface.
   input          pclk;             // AMBA APB clock.
   input          n_preset;         // AMBA reset.
   input [11:2]   paddr;            // address bus of selected master
   input  [1:0]   pwdata_par;       // Parity for write data
   input [15:0]   pwdata;           // write data
   input          pwrite;           // peripheral write strobe
   input          penable;          // peripheral enable
   input          psel;             // peripheral select for GPIO
   output [15:0]  prdata;           // read data
   output [1:0]   prdata_par;       // Parity for read data
   output         perr;             // peripheral address decode error

   // MAC interface.
   input          gtx_clk;          // Gigabit tx clock.
   input          n_gtxreset;       // Reset in tx domain.
   input [7:0]    txd;              // GMII transmit data.
   input          txd_par;          // Optional parity
   input          tx_en;            // GMII transmit enable.
   input          tx_er;            // GMII transmit error.
   output         col;              // GMII collision signal.
   output         crs;              // GMII carrier sense.
   output [15:0]  rxd;              // Receive data.
   output [1:0]   rxd_par;          // Optional parity
   output [1:0]   rx_er;            // Receive error.
   output [1:0]   rx_dv;            // Receive data valid.

   input          cal_bypass;       // Bypass optional comma align function
   input          cgalign_bypass;   // Bypass optional codegroup align function

   input          retry_test;       // Debug signal to shorten timer.
   input          alt_sgmii_mode;   // alternative tx config for SGMII
   input          sgmii_mode;       // PCS is configured for SGMII
   input          uni_direct_en;    // when set PCS transmits data rather
                                    // than idle when rx link is down
   input          tbi;              // PCS TBI enable indication.
   input          full_duplex;      // duplex signal from the network config reg
   input          two_pt_five_gig;  // indicates 2.5G operation
   output         pcs_link_state;   // current link state of PCS (pclk timed)
   output         pcs_an_complete;  // PCS autonegotiation complete
   output         np_data_int;      // Interrupt to request more np data.

   output         mac_pause_tx_en;  // Enable pause tx
   output         mac_pause_rx_en;  // Enable pause rx
   output         mac_full_duplex;  // Full duplex mode

   output         link_fault_signal_en; // 802.3cb link fault signalling enabled
   output [1:0]   link_fault_status;    // Link Fault Status needs to be passed back to GEM

   // TBI signals
   input          gtx20_clk;        // Optional 20-bit TX clock for 20-bit if
   input          n_gtx20reset;     // Async reset
   input          rx_clk;           // Receive clock
   input          n_rxreset;        // rx_clk domain reset.
   input          rx10_clk;         // Optional 10-bit interface clock
   input          n_rx10reset;      // Async reset
   input          rbc0;             // RBC 0 clock for legacy interface
   input          rbc1;             // RBC 1 clock for legacy interface
   input          n_rbc0reset;      // Async reset
   input          n_rbc1reset;      // Async reset

   input  [19:0]  rx_code_group;    // Received data from SerDes
   output [19:0]  tx_code_group;    // Code group to transmit.
   output         ewrap;            // Control whether PMA should loopback.
   output         en_cdet;          // Enable comma alignment in PMA.
   input          signal_detect;    // Valid link detected from PMD.

   // ASF error status
   output         asf_csr_pcs_err;  // Error in PCS registers
   output         asf_dap_pcs_tx_err; // Error in TX datapath parity
   output         asf_dap_pcs_rx_err; // Error in RX datapath parity

   // Wire and reg declarations.

   wire           pclk;             // AMBA APB clock.
   wire           n_preset;         // AMBA reset.
   wire [11:2]    paddr;            // address bus of selected master
   wire [15:0]    pwdata;           // write data
   wire           pwrite;           // peripheral write strobe
   wire           penable;          // peripheral enable
   wire           psel;             // peripheral select for GPIO
   wire [15:0]    prdata;           // read data
   wire           perr;             // peripheral address decode error
   wire           gtx_clk;          // Gigabit tx clock.
   wire           n_gtxreset;       // Reset in tx domain.
   wire [7:0]     txd;              // GMII transmit data.
   wire           tx_en;            // GMII transmit enable.
   wire           tx_er;            // GMII transmit error.
   wire           col;              // GMII collision signal.
   wire           crs;              // GMII carrier sense.
   wire [15:0]    rxd;              // Receive data.
   wire [1:0]     rx_er;            // Receive error.
   wire [1:0]     rx_dv;            // Receive data valid.
   wire           tbi;              // PCS TBI enable indication.
   wire           pcs_link_state;   // current link state of PCS (pclk timed)
   wire           pcs_an_complete;  // PCS autonegotiation complete
   wire           rx_clk;           // Receive clock
   wire           n_rxreset;        // rx_clk domain reset.
   wire [19:0]    rx_code_group;    // Received code group
   wire [19:0]    tx_code_group;    // Code group to transmit.
   wire           ewrap;            // Control whether PMA should loopback.
   wire           en_cdet;          // Enable comma alignment in PMA.
   wire           signal_detect;    // Valid link detected from PMD.

   wire [1:0]     xmit;             // data type output from Auto negotiation.
   wire           xmit_change_rx;   // XMIT changed
   wire [15:0]    tx_config_reg;    // Transmit configuration.
   wire [1:0]     tx_config_reg_par;// Optional parity
   wire           an_restarted;     // Autonegotiation restarted
   wire           receiving;        // Data receive in progress.
   wire           col_test;         // Perform collision test.
   wire           loopback;         // Loopback the PMA.

   wire           sync_status;      // Synchronisation status.
   wire [1:0]     rx_indicate;      // Type of received data.
   wire [15:0]    rx_config_reg;    // Configuration received.

   wire           mr_an_enable;     // Auto negotiation enable.
   wire           mr_an_restart;    // Restart auto negotiation.
   wire           mr_np_loaded;     // Next page loaded.
   wire [7:0]     mr_adv_ability;   // Local device abilities.
   wire           mr_adv_ability_par;
   wire [15:0]    mr_np_tx;         // Local device next page.
   wire [1:0]     mr_np_tx_par;     // Optional parity
   wire           mr_page_rx;       // Page received.
   wire           mr_np_loaded_clr; // Clear next page loaded.
   wire           mr_link_status;   // Link status.
   wire           mr_an_complete;   // Auto-negotiation complete.
   wire           mr_base_rf_clear; // Clear Base RF
   wire           an_full_duplex_mode; // Full duplex mode
   wire           an_pause_tx_en;   // Enable pause tx
   wire           an_pause_rx_en;   // Enable pause rx
   wire           np_data_int;      // More np data required.

   wire [15:0]    mr_lp_adv_ability;// Link partner ability.
   wire [15:0]    mr_lp_np_rx;      // Link partner next page.

   wire           sync_reset_pclk;  // Synchronous reset in pclk domain
   wire           sync_reset_rx;    // Synchronous reset in rx_clk domain
   wire           sync_reset_txclk; // Synchronous reset in gtx_clk domain

   wire [15:0]    tx_config_reg_s;  // The following signals are synchronised to
   wire [1:0]     tx_config_reg_par_s;
   wire [1:0]     xmit_s;           // the tx clock domain.
   wire           xmit_change_rx_s; //
   wire           loopback_s;       // loopback
   wire           signal_detect_s;  // signal_detect
   wire           col_test_s;       // col_test

   wire           mr_an_enable_s;   // The following signals are synchronised to
   wire           mr_an_restart_s;  // the rx_clk domain.
   wire [7:0]     mr_adv_ability_s; // advertised ability
   wire           mr_adv_ability_par_s;
   wire [15:0]    mr_np_tx_s;       // next page
   wire [1:0]     mr_np_tx_par_s;
   wire           mr_np_loaded_s;   // next page loaded

   wire           mr_page_rx_s;     // The following signals are synchronised
   wire           mr_an_complete_s; // autoneg complete
   wire [15:0]    mr_lp_adv_ability_s; // link partner's ability
   wire [15:0]    mr_lp_np_rx_s;       // link partner's next page
   wire           mr_np_loaded_clr_s;  // next page loaded clear
   wire           sync_reset_rx_s;     // Sync reset synchronised to rx_clk
   wire           sync_reset_txclk_s;  // and txclk domains
   wire           retry_test;       // Debug signal to shorten timer.
   wire           retry_test_s;     // Debug signal to shorten timer.
   wire           alt_sgmii_mode;   // alternative tx config for SGMII
   wire           sgmii_mode;       // PCS is configured for SGMII
   wire           uni_direct_en;    // when set PCS transmits data rather
                                    // than idle when rx link is down
   wire           an_restarted_s;   // Autonegotiation restarted
   wire           mr_base_rf_clear_s;  // Clear Base RF

   wire           mr_lp_np_read;    // link partner next page register read
   wire           mr_lp_np_read_s;  // link partner next page reg read sync

   wire [1:0]     link_fault_status_s; // link_fault_status synchronized to gtx_clk
   wire           tx_local_fault;   // Local fault was received so transmit remote fault
   wire           tx_remote_fault;  // Remote fault or link interruption was received so transmit idle
   wire           tx_dap_err;       // transmit datapath error
   wire           rx_dap_err;       // receive datapath error

   // link_fault_status
   // For 2.5GBASE-X operation these two bits return the state of link_fault in the LFSM defined in Figure 46-11 of IEEE 802.3.
   // 00  OK
   // 01  local fault
   // 10  remote fault
   // 11  link interruption

   // Autonegotiation and link fault signalling cannot work together.
   // The LFSM added to GEM shall only be active if the following control bits are all as follows:
   // 1.  Bit 29 two_pt_five_gig is high in the network control register (at 0x0000)
   // 2.  Bit 12 enable_auto_neg is low in the pcs_control register (at 0x0200)
   // 3.  Bit 31 uni direction enable is low in the network_config register (at 0x0004)
   // 4.  Bit 11 pcs_select (tbi) is high in the network_config register (at 0x0004)
   // This needs to be receive clock timed
   // Assumption is uni_direct_en is completely static
   assign link_fault_signal_en = two_pt_five_gig && !mr_an_enable && !uni_direct_en && tbi;
   assign tx_local_fault  = (link_fault_status_s == 2'b01) & link_fault_signal_en; // Local fault was received so transmit remote fault
   assign tx_remote_fault = link_fault_status_s[1] & link_fault_signal_en; // Remote fault or link interruption was received so transmit idle

   // Instantiate the tx block..

   gem_pcs_tx #(.grouped_params(grouped_params))

   i_pcs_tx (
   .gtx_clk           (gtx_clk),
   .n_gtxreset        (n_gtxreset),
   .gtx20_clk         (gtx20_clk),
   .n_gtx20reset      (n_gtx20reset),
   .sync_reset_txclk  (sync_reset_txclk),
   .tx_local_fault    (tx_local_fault),
   .tx_remote_fault   (tx_remote_fault),
   .tx_en             (tx_en),
   .tx_er             (tx_er),
   .txd               (txd),
   .txd_par           (txd_par),
   .xmit              (xmit_s),
   .xmit_change_rx_s  (xmit_change_rx_s),
   .tx_config_reg     (tx_config_reg_s),
   .tx_config_reg_par (tx_config_reg_par_s),
   .receiving         (receiving),
   .col_test          (col_test_s),
   .col               (col),
   .crs               (crs),
   .code_group        (tx_code_group),
   .tx_dap_err        (tx_dap_err)
   );

   // Instantiate the rx block.

   gem_pcs_rx #(.grouped_params(grouped_params))

    i_pcs_rx (
   .rx_clk              (rx_clk),
   .n_reset             (n_rxreset),
   .rx10_clk            (rx10_clk),
   .n_rx10reset         (n_rx10reset),
   .rbc0                (rbc0),
   .rbc1                (rbc1),
   .n_rbc0reset         (n_rbc0reset),
   .n_rbc1reset         (n_rbc1reset),
   .cal_bypass          (cal_bypass),
   .cgalign_bypass      (cgalign_bypass),
   .sync_reset_pclk     (sync_reset_pclk),
   .rx_code_group       (rx_code_group),
   .signal_detect       (signal_detect_s),
   .loop_back           (loopback_s),
   .xmit                (xmit),
   .receiving           (receiving),
   .sync_status         (sync_status),
   .en_cdet             (en_cdet),
   .rx_indicate         (rx_indicate),
   .rx_config_reg       (rx_config_reg),
   .rx_dv               (rx_dv),
   .rx_er               (rx_er),
   .rxd                 (rxd),
   .rxd_par             (rxd_par),
   .sync_reset_rx       (sync_reset_rx),
   .rx_dap_err          (rx_dap_err),
   .link_fault_signal_en(link_fault_signal_en),
   .link_fault_status   (link_fault_status)
   );

   // Instantiate the auto-negotiation block.

   gem_pcs_an #(.p_edma_asf_dap_prot(p_edma_asf_dap_prot)) i_pcs_an(
   .rx_clk              (rx_clk),
   .n_reset             (n_rxreset),
   .sync_reset          (sync_reset_rx),
   .rx_indicate         (rx_indicate),
   .sync_status         (sync_status),
   .rx_config_reg       (rx_config_reg),
   .retry_test          (retry_test_s),
   .alt_sgmii_mode      (alt_sgmii_mode),
   .sgmii_mode          (sgmii_mode),
   .uni_direct_en       (uni_direct_en),
   .two_pt_five_gig     (two_pt_five_gig),
   .mr_an_enable        (mr_an_enable_s),
   .mr_an_restart       (mr_an_restart_s),
   .mr_adv_ability      (mr_adv_ability_s),
   .mr_adv_ability_par  (mr_adv_ability_par_s),
   .mr_np_tx            (mr_np_tx_s),
   .mr_np_tx_par        (mr_np_tx_par_s),
   .mr_np_loaded        (mr_np_loaded_s),
   .mr_lp_np_read       (mr_lp_np_read_s),
   .tx_config_reg       (tx_config_reg),
   .tx_config_reg_par   (tx_config_reg_par),
   .xmit                (xmit),
   .xmit_change_rx      (xmit_change_rx),
   .an_restarted        (an_restarted),
   .mr_page_rx          (mr_page_rx),
   .mr_np_loaded_clr    (mr_np_loaded_clr),
   .mr_link_status      (mr_link_status),
   .mr_an_complete      (mr_an_complete),
   .mr_lp_adv_ability   (mr_lp_adv_ability),
   .mr_lp_np_rx         (mr_lp_np_rx),
   .mr_base_rf_clear    (mr_base_rf_clear),
   .an_full_duplex_mode (an_full_duplex_mode),
   .an_pause_tx_en      (an_pause_tx_en),
   .an_pause_rx_en      (an_pause_rx_en)
   );

   // Instantiate the registers block.

   gem_pcs_registers #(
   .p_edma_asf_csr_prot(p_edma_asf_csr_prot),
   .p_edma_asf_host_par(p_edma_asf_host_par)
   ) i_pcs_registers(
   .pclk              (pclk),
   .n_preset          (n_preset),
   .mr_page_rx        (mr_page_rx_s),
   .mr_np_loaded_clr  (mr_np_loaded_clr_s),
   .pcs_link_state    (pcs_link_state),
   .mr_an_complete    (mr_an_complete_s),
   .mr_lp_adv_ability (mr_lp_adv_ability_s),
   .mr_lp_np_rx       (mr_lp_np_rx_s),
   .mr_base_rf_clear  (mr_base_rf_clear_s),
   .an_restarted      (an_restarted_s),
   .tbi               (tbi),
   .sgmii_mode        (sgmii_mode),
   .full_duplex       (full_duplex),
   .sync_reset_rx     (sync_reset_rx_s),
   .sync_reset_txclk  (sync_reset_txclk_s),
   .mr_an_enable      (mr_an_enable),
   .mr_an_restart     (mr_an_restart),
   .mr_adv_ability    (mr_adv_ability),
   .mr_adv_ability_par(mr_adv_ability_par),
   .mr_np_tx          (mr_np_tx),
   .mr_np_tx_par      (mr_np_tx_par),
   .mr_np_loaded      (mr_np_loaded),
   .mr_lp_np_read     (mr_lp_np_read),
   .mr_loopback       (loopback),
   .mr_col_test       (col_test),
   .ewrap             (ewrap),
   .pcs_an_complete   (pcs_an_complete),
   .np_data_int       (np_data_int),
   .sync_reset_pclk   (sync_reset_pclk),
   .paddr             (paddr),
   .prdata            (prdata),
   .prdata_par        (prdata_par),
   .pwdata            (pwdata),
   .pwdata_par        (pwdata_par),
   .pwrite            (pwrite),
   .penable           (penable),
   .psel              (psel),
   .perr              (perr),
   .asf_csr_pcs_err   (asf_csr_pcs_err)
   );

   // Now for the synchronisation blocks.

   gem_pcs_rx_sync i_pcs_rxsync(
   .rx_clk              (rx_clk),
   .n_reset             (n_rxreset),
   .mr_an_enable        (mr_an_enable),
   .mr_an_restart       (mr_an_restart),
   .mr_adv_ability      (mr_adv_ability),
   .mr_adv_ability_par  (mr_adv_ability_par),
   .mr_np_tx            (mr_np_tx),
   .mr_np_tx_par        (mr_np_tx_par),
   .mr_np_loaded        (mr_np_loaded),
   .loopback            (loopback),
   .signal_detect       (signal_detect),
   .retry_test          (retry_test),
   .mr_lp_np_read       (mr_lp_np_read),
   .mr_an_enable_s      (mr_an_enable_s),
   .mr_an_restart_s     (mr_an_restart_s),
   .mr_adv_ability_s    (mr_adv_ability_s),
   .mr_adv_ability_par_s(mr_adv_ability_par_s),
   .mr_np_tx_s          (mr_np_tx_s),
   .mr_np_tx_par_s      (mr_np_tx_par_s),
   .mr_np_loaded_s      (mr_np_loaded_s),
   .loopback_s          (loopback_s),
   .signal_detect_s     (signal_detect_s),
   .retry_test_s        (retry_test_s),
   .mr_lp_np_read_s     (mr_lp_np_read_s)
   );

   gem_pcs_pclk_sync #(.p_edma_asf_dap_prot(p_edma_asf_dap_prot)) i_pcs_pclksync(
   .pclk                  (pclk),
   .n_preset              (n_preset),
   .gtx_clk               (gtx_clk),
   .n_gtxreset            (n_gtxreset),
   .rx_clk                (rx_clk),
   .n_rxreset             (n_rxreset),
   .mr_page_rx            (mr_page_rx),
   .mr_link_status        (mr_link_status),
   .mr_an_complete        (mr_an_complete),
   .mr_lp_adv_ability     (mr_lp_adv_ability),
   .mr_lp_np_rx           (mr_lp_np_rx),
   .mr_np_loaded_clr      (mr_np_loaded_clr),
   .sync_reset_rx         (sync_reset_rx),
   .sync_reset_txclk      (sync_reset_txclk),
   .mr_base_rf_clear      (mr_base_rf_clear),
   .an_full_duplex_mode   (an_full_duplex_mode),
   .an_restarted          (an_restarted),
   .an_pause_tx_en        (an_pause_tx_en),
   .an_pause_rx_en        (an_pause_rx_en),
   .mr_page_rx_s          (mr_page_rx_s),
   .tx_dap_err            (tx_dap_err),
   .rx_dap_err            (rx_dap_err),
   .mr_link_status_s      (pcs_link_state),
   .mr_an_complete_s      (mr_an_complete_s),
   .mr_lp_adv_ability_s   (mr_lp_adv_ability_s),
   .mr_lp_np_rx_s         (mr_lp_np_rx_s),
   .mr_np_loaded_clr_s    (mr_np_loaded_clr_s),
   .mr_base_rf_clear_s    (mr_base_rf_clear_s),
   .an_full_duplex_mode_s (mac_full_duplex),
   .an_restarted_s        (an_restarted_s),
   .an_pause_tx_en_s      (mac_pause_tx_en),
   .an_pause_rx_en_s      (mac_pause_rx_en),
   .sync_reset_rx_s       (sync_reset_rx_s),
   .sync_reset_txclk_s    (sync_reset_txclk_s),
   .tx_dap_err_s          (asf_dap_pcs_tx_err),
   .rx_dap_err_s          (asf_dap_pcs_rx_err)
   );

   gem_pcs_gtx_sync i_pcs_gtxsync(
   .gtx_clk             (gtx_clk),
   .n_gtxreset          (n_gtxreset),
   .rx_clk              (rx_clk),
   .n_rxreset           (n_rxreset),
   .tx_config_reg       (tx_config_reg),
   .tx_config_reg_par   (tx_config_reg_par),
   .xmit                (xmit),
   .xmit_change_rx      (xmit_change_rx),
   .col_test            (col_test),
   .sync_reset_pclk     (sync_reset_pclk),
   .link_fault_status   (link_fault_status),
   .tx_config_reg_s     (tx_config_reg_s),
   .tx_config_reg_par_s (tx_config_reg_par_s),
   .xmit_s              (xmit_s),
   .xmit_change_rx_s    (xmit_change_rx_s),
   .col_test_s          (col_test_s),
   .sync_reset_txclk    (sync_reset_txclk),
   .link_fault_status_s (link_fault_status_s)
   );

endmodule

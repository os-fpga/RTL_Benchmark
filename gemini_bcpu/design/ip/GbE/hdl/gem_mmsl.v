//------------------------------------------------------------------------------
// Copyright (c) 2016-2022 Cadence Design Systems, Inc.
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
//   Filename:           gem_mmsl.v
//   Module Name:        gem_mmsl
//
//   Release Revision:   r1p12f7
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
//   Description :      Top Level MMSL (MAC Merge Sub Layer)
//
//------------------------------------------------------------------------------


module gem_mmsl (

  // Clocks and resets
  input              pclk,               // APB clock
  input              tx_clk,             // Transmit clock
  input              rx_clk,             // Receive clock
  input              n_preset,           // APB reset
  input              n_txreset,          // Transmit reset
  input              n_rxreset,          // Receive reset

  // APB Interface signals
  input              psel,               // Select signal
  input              penable,            // Enable signal
  input        [7:2] paddr,              // APB Address bus
  input              pwrite,             // Write strobe
  input       [31:0] pwdata,             // Write Data
  input       [3:0]  pwdata_par,         // Parity for write data
  output      [31:0] prdata,             // Read Data
  output      [3:0]  prdata_par,         // Parity for read data
  output             pslverr,            // Error signal from the MMSL

  // GMII Interface signals on the Express MAC (eMAC) side
  input              tx_enable,          // Soft reset for the TX side (pclk domain)
  input              rx_enable,          // Soft reset for the RX side (pclk domain)
  input              emac_tx_en,         // TX enable from the eMAC
  input              emac_tx_en_extended,// TX enable from the eMAC, extended version
  input              emac_tx_er,         // TX error from the eMAC
  input        [7:0] emac_txd,           // TX data from the eMAC
  input              emac_txd_par,       // optional parity
  output             emac_tx_rdy,        // TX backpressure signal to the eMAC
  output             emac_rx_dv,         // RX Data Valid to the eMAC
  output             emac_rx_er,         // RX error to the eMAC
  output       [7:0] emac_rxd,           // RX data to the eMAC
  output             emac_rxd_par,       // Optional parity
  output       [1:0] emac_rx_dv_pcs,     // RX data valid to the eMAC if using PCS
  output       [1:0] emac_rx_er_pcs,     // RX error to the eMAC if using PCS
  output      [15:0] emac_rxd_pcs,       // RX data to the eMAC if using PCS
  output       [1:0] emac_rxd_par_pcs,   // optional parity

  // GMII Interface signals on the pre-emptible MAC (pMAC) side
  input              pmac_tx_en,         // TX enable from the pMAC
  input              pmac_tx_en_extended,// TX enable from the pMAC, extended version
  input              pmac_tx_er,         // TX error from the pMAC
  input        [7:0] pmac_txd,           // TX data from the pMAC
  input              pmac_txd_par,       // optional parity
  input       [13:0] pmac_tx_frame_len,  // TX frame length from the pMAC
  output             pmac_rx_halt,       // HALT signal from the RX proc block
  output             pmac_tx_rdy,        // TX backpressure signal to the pMAC
  output             pmac_rx_dv,         // RX Data Valid to the pMAC
  output             pmac_rx_er,         // RX error to the pMAC
  output       [7:0] pmac_rxd,           // RX data to the pMAC
  output             pmac_rxd_par,       // optional parity
  output       [1:0] pmac_rx_dv_pcs,     // RX data valid to the pMAC if using PCS
  output       [1:0] pmac_rx_er_pcs,     // RX error to the pMAC if using PCS
  output      [15:0] pmac_rxd_pcs,       // RX data to the pMAC if using PCS
  output       [1:0] pmac_rxd_par_pcs,   // optional parity

  // GMII Interface signals to the GMII
  input              rx_dv,              // RX Data Valid from the PHY
  input              rx_dv_extended,     // RX Data Valid from the PHY, extended to the extend carrier signaling
  input              rx_er,              // RX error to the PHY
  input        [7:0] rxd,                // RX data to the PHY
  input              rxd_par,            // parity
  input        [1:0] rx_dv_pcs,          // RX Data Valid from the PHY if using PCS
  input        [1:0] rx_dv_pcs_extended, // RX Data Valid from the PHY if using PCS, extended to the extend carrier signaling
  input        [1:0] rx_er_pcs,          // RX error to the PHY if using PCS
  input       [15:0] rxd_pcs,            // RX data to the PHY if using PCS
  input        [1:0] rxd_par_pcs,        // Optional parity

  output             tx_en,              // TX enable from the MMSL
  output             tx_er,              // TX error from the MMSL
  output       [7:0] txd,                // TX data from the MMSL
  output             txd_par,            // optional parity

  // Other interface signals
  input              hold,               // hold signal from the EnST module
  input        [3:0] speed_mode,         // speed_mode specifying the rate and the type of Media Independent Interface
  input        [3:0] min_ifg,            // minimum transmit IFG divided by four
  output       [1:0] add_frag_size,      // Encoding the number of bytes to transmit prior the preemption
  output             mmsl_int,           // Interrupt issued
  output  reg        switch_rx_pmac_emac,// Switch output driver (does during initialisation)

  // Signals for ASF and lockup detection
  output             asf_csr_mmsl_err,   // Parity error in MMSL registers
  output             asf_dap_mmsl_tx_err,// Parity error in TX datapath
  output             asf_dap_mmsl_rx_err,// Parity error in RX datapath
  output             e_pip,              // eMAC packet is in progress
  output             p_pip,              // pMAC packet is in progress (may be halted)
  output             p_sop_gate,         // Start of packet detect gate for pMAC
  output             p_eop_gate          // End of packet detect gate for pMAC

);

  parameter p_edma_asf_dap_prot   = 1'b0; // Optional parity protection
  parameter p_edma_asf_csr_prot   = 1'b0; // Optional register parity protection
  parameter p_edma_asf_host_par   = 1'b0; // Generate parity on prdata
  parameter p_edma_irq_read_clear = 1'b0; // Clear interrupts on read

  // -----------------------------------------------------------------------------
  // Declaration of the signals and parameters
  // -----------------------------------------------------------------------------

  wire  [2:0] v_state;
  wire  [2:0] v_state_pclk;
  wire  [7:0] v_txd;
  wire        v_txd_par;
  wire  [7:0] r_txd;
  wire        r_txd_par;
  wire        p_active_rx;
  wire        p_active_rx_sync;
  wire        route_rx_to_pmac;
  wire        route_rx_to_pmac_sync;
  wire        mmsl_debug_mode;
  wire        mmsl_debug_mode_tx;
  wire        tx_enable_txclk;
  wire        rx_enable_rxclk;
  wire        asf_dap_mmsl_rx_exp_err;
  wire        asf_dap_mmsl_rx_p_err;
  wire        invert_mcrc;
  wire        smd_error_toggle;
  wire        smd_error_td_pclk;
  wire        smdc_error_toggle;
  wire        smdc_error_td_pclk;
  wire        smds_error_toggle;
  wire        smds_error_td_pclk;
  wire        fr_count_error_toggle;
  wire        fr_count_error_td_pclk;
  wire        frag_count_rx_toggle;
  wire        frag_count_rx_td_pclk;
  wire        ass_ok_count_toggle;
  wire        ass_ok_count_td_pclk;
  wire        smd_error_count_toggle;
  wire        smd_error_count_td_pclk;
  wire        ass_error_count_toggle;
  wire        ass_error_count_td_pclk;
  wire        rcv_r_set_rx_clk;
  wire        rcv_v_set_rx_clk;
  wire        rcv_r_set_tx_clk;
  wire        rcv_v_set_tx_clk;
  wire        rcv_v_err_toggle;
  wire        rcv_r_err_toggle;
  wire        rcv_v_err_td_pclk;
  wire        rcv_r_err_td_pclk;
  wire        r_tx_rdy;
  wire        v_tx_rdy;
  wire        frag_count_tx_toggle;
  wire        p_active;
  wire        verified;
  wire        send_r;
  wire        send_v;
  wire        disable_verify_tx_clk;
  wire        pre_enable_tx_clk;
  wire        r_tx_en;
  wire        v_tx_en;
  wire        p_active_pclk;
  wire        frag_count_tx_td_pclk;
  wire        r_state;
  wire        restart_ver_tx_clk;
  wire        r_state_pclk;
  wire        disable_verify_pclk;
  wire        restart_ver_tog_pclk;
  wire        pre_enable_pclk;

  // -----------------------------------------------------------------------------
  // Beginning of the Hardware description
  // -----------------------------------------------------------------------------
  cdnsdru_datasync_v1 i_sync_p_active_rx (
  .clk     (rx_clk),
  .reset_n (n_rxreset),
  .din     (p_active_rx),
  .dout    (p_active_rx_sync)
  );

  cdnsdru_datasync_v1 i_sync_route_rx_to_pmac (
  .clk     (rx_clk),
  .reset_n (n_rxreset),
  .din     (route_rx_to_pmac),
  .dout    (route_rx_to_pmac_sync)
  );

  cdnsdru_datasync_v1 i_sync_mmsl_debug_mode (
  .clk     (tx_clk),
  .reset_n (n_txreset),
  .din     (mmsl_debug_mode),
  .dout    (mmsl_debug_mode_tx)
  );

  // Control MUX for RX traffic such that if pre-emption is not enabled, then
  // traffic is routed to the pmac.
  // The switch over must only happen while the eMAC is idle.
  // When this signal is high, all eMAC traffic is routed to the pMAC. No pMAC
  // traffic should be getting received on the line until pre-emption is enabled.
  // When this signal is low, it should operate in accordance to the IEEE spec.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      switch_rx_pmac_emac <= 1'b1;
    else
      if (~rx_enable_rxclk)
        switch_rx_pmac_emac <= 1'b1;
      else
        if ((emac_rx_dv == 1'b0) && (emac_rx_dv_pcs[1] == 1'b0))
        begin
          if ((route_rx_to_pmac_sync && p_active_rx_sync) || ~route_rx_to_pmac_sync)
            switch_rx_pmac_emac <= 1'b0;
        end
  end

  gem_mmsl_rx_exp_flt #(.p_edma_asf_dap_prot(p_edma_asf_dap_prot)) i_gem_mmsl_rx_exp_flt (
  .rx_clk              (rx_clk),
  .n_rxreset           (n_rxreset),
  .rx_enable           (rx_enable_rxclk),
  .rx_dv               (rx_dv),
  .rx_dv_extended      (rx_dv_extended),
  .rx_er               (rx_er),
  .rxd                 (rxd),
  .rxd_par             (rxd_par),
  .rx_dv_pcs           (rx_dv_pcs),
  .rx_dv_pcs_extended  (rx_dv_pcs_extended),
  .rx_er_pcs           (rx_er_pcs),
  .rxd_pcs             (rxd_pcs),
  .rxd_par_pcs         (rxd_par_pcs),
  .speed_mode          (speed_mode),
  .rcv_v_err_toggle    (rcv_v_err_toggle), // Toggle going to gem_mmsl_reg
  .rcv_r_err_toggle    (rcv_r_err_toggle), // Toggle going to gem_mmsl_reg
  .rcv_v_set           (rcv_v_set_rx_clk), // Toggle going to gem_mmsl_ver
  .rcv_r_set           (rcv_r_set_rx_clk), // Toggle going to gem_mmsl_ver
  .invert_mcrc         (invert_mcrc),      // Coming from the MMSL control register
  .emac_rx_dv          (emac_rx_dv),
  .emac_rx_er          (emac_rx_er),
  .emac_rxd            (emac_rxd),
  .emac_rxd_par        (emac_rxd_par),
  .emac_rx_dv_pcs      (emac_rx_dv_pcs),
  .emac_rx_er_pcs      (emac_rx_er_pcs),
  .emac_rxd_pcs        (emac_rxd_pcs),
  .emac_rxd_par_pcs    (emac_rxd_par_pcs),
  .asf_dap_mmsl_rx_err (asf_dap_mmsl_rx_exp_err)
  );

  // rcv_v_set coming from the express filter
  // going to the verification block
  cdnsdru_datasync_v1 i_rcv_v_set_tx_clk (
  .clk     (tx_clk),
  .reset_n (n_txreset),
  .din     (rcv_v_set_rx_clk),
  .dout    (rcv_v_set_tx_clk)
  );

  // rcv_r_set coming from the express filter
  // going to the verification block
  cdnsdru_datasync_v1 i_rcv_r_set_tx_clk (
  .clk     (tx_clk),
  .reset_n (n_txreset),
  .din     (rcv_r_set_rx_clk),
  .dout    (rcv_r_set_tx_clk)
  );

  // Synchronizing to pclk and detecting the toggle
  // to pass rcv_v_err to gem_mmsl_reg
  edma_sync_toggle_detect i_rcv_v_err_pclk (
  .clk        (pclk),
  .reset_n    (n_preset),
  .din        (rcv_v_err_toggle),
  .any_edge   (rcv_v_err_td_pclk),
  .rise_edge  (),
  .fall_edge  ()
  );

  // Synchronizing to pclk and detecting the toggle
  // to pass rcv_r_err to gem_mmsl_reg
  edma_sync_toggle_detect i_rcv_r_err_pclk (
  .clk        (pclk),
  .reset_n    (n_preset),
  .din        (rcv_r_err_toggle),
  .any_edge   (rcv_r_err_td_pclk),
  .rise_edge  (),
  .fall_edge  ()
  );

  gem_mmsl_rx_proc #(.p_edma_asf_dap_prot(p_edma_asf_dap_prot)) i_gem_mmsl_rx_proc (
  .rx_clk                (rx_clk),
  .n_rxreset             (n_rxreset),
  .rx_dv                 (rx_dv),
  .rx_dv_extended        (rx_dv_extended),
  .rx_er                 (rx_er),
  .rx_enable             (rx_enable_rxclk),
  .rxd                   (rxd),
  .rxd_par               (rxd_par),
  .rx_dv_pcs             (rx_dv_pcs),
  .rx_dv_pcs_extended    (rx_dv_pcs_extended),
  .rx_er_pcs             (rx_er_pcs),
  .speed_mode            (speed_mode),
  .rxd_pcs               (rxd_pcs),
  .rxd_par_pcs           (rxd_par_pcs),
  .pmac_rx_dv            (pmac_rx_dv),
  .pmac_rx_er            (pmac_rx_er),
  .pmac_rxd              (pmac_rxd),
  .pmac_rxd_par          (pmac_rxd_par),
  .pmac_rx_dv_pcs        (pmac_rx_dv_pcs),
  .pmac_rx_er_pcs        (pmac_rx_er_pcs),
  .pmac_rxd_pcs          (pmac_rxd_pcs),
  .pmac_rxd_par_pcs      (pmac_rxd_par_pcs),
  .pmac_rx_halt          (pmac_rx_halt),
  .invert_mcrc           (invert_mcrc),            // Coming from gem_mmsl_reg
  .frag_count_rx_toggle  (frag_count_rx_toggle),   // Toggles when a fragment has been rebuilt in rx, going to gem_mmsl_reg
  .ass_ok_count_toggle   (ass_ok_count_toggle),    // Toggles when a frame has been completed to be rebuilt in rx
  .smd_error_count_toggle(smd_error_count_toggle), // Toggles when an smd error has been detected
  .ass_error_count_toggle(ass_error_count_toggle), // Toggles when an assembly_error has been detected
  .fr_count_error_toggle (fr_count_error_toggle),  // Toggles when a frame/fragment error has been detected
  .smd_error_toggle      (smd_error_toggle),       // Toggles when an smd_error has been detected
  .smdc_error_toggle     (smdc_error_toggle),      // Toggles when an smdc_error has been detected
  .smds_error_toggle     (smds_error_toggle),      // Toggles when an smds_error has been detected
  .asf_dap_mmsl_rx_err   (asf_dap_mmsl_rx_p_err)
  );

  // Synchronizing smd_error_toggle, smdc_error_toggle,
  // smds_error_toggle and
  // detecting the toggle before sending it to
  // gem_mmsl_reg
  edma_sync_toggle_detect i_smd_error_td_pclk (
  .clk      (pclk),
  .reset_n  (n_preset),
  .din      (smd_error_toggle),
  .any_edge (smd_error_td_pclk),
  .rise_edge(),
  .fall_edge()
  );

  edma_sync_toggle_detect i_smdc_error_td_pclk (
  .clk      (pclk),
  .reset_n  (n_preset),
  .din      (smdc_error_toggle),
  .any_edge (smdc_error_td_pclk),
  .rise_edge(),
  .fall_edge()
  );

  edma_sync_toggle_detect i_smds_error_td_pclk (
  .clk      (pclk),
  .reset_n  (n_preset),
  .din      (smds_error_toggle),
  .any_edge (smds_error_td_pclk),
  .rise_edge(),
  .fall_edge()
  );

  // Synchronizing fr_count_error_toggle and
  // detecting the toggle before sending it to
  // gem_mmsl_reg
  edma_sync_toggle_detect i_fr_count_error_td_pclk (
  .clk      (pclk),
  .reset_n  (n_preset),
  .din      (fr_count_error_toggle),
  .any_edge (fr_count_error_td_pclk),
  .rise_edge(),
  .fall_edge()
  );

  // Synchronizing frag_count_rx_toggle to the pclk domain
  // and detecting the toggle before feeding gem_mmsl_reg
  edma_sync_toggle_detect i_frag_count_rx_td (
  .clk      (pclk),
  .reset_n  (n_preset),
  .din      (frag_count_rx_toggle),
  .any_edge (frag_count_rx_td_pclk),
  .rise_edge(),
  .fall_edge()
  );

  // Synchronizing ass_ok_count_toggle and
  // detecting the toggle before sending it to
  // gem_mmsl_reg
  edma_sync_toggle_detect i_ass_count_td (
  .clk      (pclk),
  .reset_n  (n_preset),
  .din      (ass_ok_count_toggle),
  .any_edge (ass_ok_count_td_pclk),
  .rise_edge(),
  .fall_edge()
  );

  // Synchronizing smd_error_count_toggle and
  // detecting the toggle before sending it to
  // gem_mmsl_reg
  edma_sync_toggle_detect i_smd_error_count_td (
  .clk      (pclk),
  .reset_n  (n_preset),
  .din      (smd_error_count_toggle),
  .any_edge (smd_error_count_td_pclk),
  .rise_edge(),
  .fall_edge()
  );

  // Synchronizing ass_error_count_toggle and
  // detecting the toggle before sending it to
  // gem_mmsl_reg
  edma_sync_toggle_detect i_ass_error_count_td (
  .clk      (pclk),
  .reset_n  (n_preset),
  .din      (ass_error_count_toggle),
  .any_edge (ass_error_count_td_pclk),
  .rise_edge(),
  .fall_edge()
  );

  gem_mmsl_tx_proc #(.p_edma_asf_dap_prot(p_edma_asf_dap_prot)) i_gem_mmsl_tx_proc (
  .tx_clk              (tx_clk),
  .n_txreset           (n_txreset),
  .tx_enable           (tx_enable_txclk),
  .emac_tx_en          (emac_tx_en),
  .emac_tx_en_extended (emac_tx_en_extended),
  .emac_tx_er          (emac_tx_er),
  .emac_txd            (emac_txd),
  .emac_txd_par        (emac_txd_par),
  .pmac_tx_en          (pmac_tx_en),
  .pmac_tx_en_extended (pmac_tx_en_extended),
  .pmac_tx_er          (pmac_tx_er),
  .pmac_txd            (pmac_txd),
  .pmac_txd_par        (pmac_txd_par),
  .pmac_tx_frame_len   (pmac_tx_frame_len),
  .v_tx_en             (v_tx_en),
  .v_txd               (v_txd),
  .v_txd_par           (v_txd_par),
  .r_tx_en             (r_tx_en),
  .r_txd               (r_txd),
  .r_txd_par           (r_txd_par),
  .hold                (hold),
  .pre_enable          (pre_enable_tx_clk),     // Coming from gem_mmsl_reg
  .disable_verify      (disable_verify_tx_clk), // Coming from gem_mmsl_reg
  .add_frag_size       (add_frag_size),         // Coming from gem_mmsl_reg
  .speed_mode          (speed_mode),            // Coming from gem_mmsl_reg
  .min_ifg             (min_ifg),
  .invert_mcrc         (invert_mcrc),           // Coming from gem_mmsl_reg
  .send_v              (send_v),                // Coming from the verification block
  .send_r              (send_r),                // Coming from the verification block
  .verified            (verified),              // Coming from gem_ver
  .p_active            (p_active),              // Going to gem_mmsl_reg
  .p_active_rx         (p_active_rx),           // Controls local RX mux
  .frag_count_tx_toggle(frag_count_tx_toggle),  // Going to gem_mmsl_reg
  .pmac_tx_rdy         (pmac_tx_rdy),
  .emac_tx_rdy         (emac_tx_rdy),
  .v_tx_rdy            (v_tx_rdy),
  .r_tx_rdy            (r_tx_rdy),
  .tx_en               (tx_en),
  .tx_er               (tx_er),
  .txd                 (txd),
  .txd_par             (txd_par),
  .asf_dap_mmsl_tx_err (asf_dap_mmsl_tx_err),
  .e_pip               (e_pip),
  .p_pip               (p_pip),
  .p_sop_gate          (p_sop_gate),
  .p_eop_gate          (p_eop_gate)
  );

  // Synchronizing
  // before passing p_active to the pclk domain
  cdnsdru_datasync_v1 i_p_active_pclk (
  .clk      (pclk),
  .reset_n  (n_preset),
  .din      (p_active),
  .dout     (p_active_pclk)
  );

  // Synchronizing and detecting the toggle
  // before passing frag_count_tx to the pclk domain
  edma_sync_toggle_detect i_frag_count_tx_td_pclk (
  .clk      (pclk),
  .reset_n  (n_preset),
  .din      (frag_count_tx_toggle),
  .any_edge (frag_count_tx_td_pclk),
  .rise_edge(),
  .fall_edge()
  );

  // Synchronizing tx_enable from pclk domain to tx_clk
  cdnsdru_datasync_v1 i_tx_enable_txclk (
  .clk      (tx_clk),
  .reset_n  (n_txreset),
  .din      (tx_enable),
  .dout     (tx_enable_txclk)
  );

  // Synchronizing rx_enable from pclk domain to rx_clk
  cdnsdru_datasync_v1 i_rx_enable_rxclk (
  .clk      (rx_clk),
  .reset_n  (n_rxreset),
  .din      (rx_enable),
  .dout     (rx_enable_rxclk)
  );

  gem_mmsl_ver i_gem_mmsl_ver (
  .tx_clk            (tx_clk),
  .n_txreset         (n_txreset),
  .tx_enable         (tx_enable_txclk),
  .v_tx_rdy          (v_tx_rdy),
  .r_tx_rdy          (r_tx_rdy),
  .pre_enable        (pre_enable_tx_clk),     // Coming from gem_mmsl_reg
  .disable_verify    (disable_verify_tx_clk), // Coming from gem_mmsl_reg
  .invert_mcrc       (invert_mcrc),           // Coming from gem_mmsl_reg
  .mmsl_debug_mode_tx(mmsl_debug_mode_tx),    // Coming from gem_mmsl_reg
  .restart_ver       (restart_ver_tx_clk),    // Coming from gem_mmsl_reg
  .rcv_v_set         (rcv_v_set_tx_clk),      // Coming from gem_rx_exp_flt
  .rcv_r_set         (rcv_r_set_tx_clk),      // Coming from gem_rx_exp_flt
  .speed_mode        (speed_mode),
  .verified          (verified),
  .v_tx_en           (v_tx_en),
  .r_tx_en           (r_tx_en),
  .v_txd             ({v_txd_par,v_txd}),
  .r_txd             ({r_txd_par,r_txd}),
  .send_r            (send_r),  // Strobe to the TX proc block
  .send_v            (send_v),  // Strobe to the TX proc block
  .v_state           (v_state), // Going to gem_mmsl_reg using an async FIFO
  .r_state           (r_state)  // Going to gem_mmsl_reg using a synchronizer
  );


  // Safely synchronise v_state to pclk. A bus synchroniser is used since this is 3-bits
  // wide and the output is registered to pclk to allow it to be used directly.
  gem_bus_sync #(
    .p_dwidth (3),
    .p_reg_out(1)
  ) i_sync_v_state_pclk (
    .src_clk      (tx_clk),
    .src_rst_n    (n_txreset),
    .dest_clk     (pclk),
    .dest_rst_n   (n_preset),
    .src_data     (v_state),
    .src_xfer_en  (1'b1),
    .src_data_last(),
    .src_rdy      (),
    .dest_data    (v_state_pclk),
    .dest_val     ()
  );

  // Sync r_state to pass it to
  // gem_mmsl_reg
  cdnsdru_datasync_v1 i_r_state_pclk (
  .clk    (pclk),
  .reset_n(n_preset),
  .din    (r_state),
  .dout   (r_state_pclk)
  );

  gem_mmsl_reg #(
    .p_edma_irq_read_clear(p_edma_irq_read_clear),
    .p_edma_asf_csr_prot  (p_edma_asf_csr_prot),
    .p_edma_asf_host_par  (p_edma_asf_host_par)
  ) i_gem_mmsl_reg (
  .pclk               (pclk),
  .n_preset           (n_preset),
  .psel               (psel),
  .penable            (penable),
  .paddr              (paddr),
  .pwrite             (pwrite),
  .pwdata             (pwdata),
  .pwdata_par         (pwdata_par),
  .pslverr            (pslverr),
  .prdata             (prdata),
  .prdata_par         (prdata_par),
  .p_active           (p_active_pclk),
  .verify_status      (v_state_pclk),
  .respond_status     (r_state_pclk),
  .smd_error          (smd_error_td_pclk),
  .smdc_error         (smdc_error_td_pclk),
  .smds_error         (smds_error_td_pclk),
  .fr_count_error     (fr_count_error_td_pclk),
  .frag_count_rx_td   (frag_count_rx_td_pclk),
  .frag_count_tx_td   (frag_count_tx_td_pclk),
  .ass_ok_count_td    (ass_ok_count_td_pclk),
  .smd_error_count_td (smd_error_count_td_pclk),
  .ass_error_count_td (ass_error_count_td_pclk),
  .rcv_v_error        (rcv_v_err_td_pclk),
  .rcv_r_error        (rcv_r_err_td_pclk),
  .pre_enable         (pre_enable_pclk),
  .route_rx_to_pmac   (route_rx_to_pmac),
  .invert_mcrc        (invert_mcrc),
  .mmsl_debug_mode    (mmsl_debug_mode),
  .restart_ver_tog    (restart_ver_tog_pclk),
  .disable_verify     (disable_verify_pclk),
  .add_frag_size      (add_frag_size),
  .mmsl_int           (mmsl_int),
  .asf_csr_mmsl_err   (asf_csr_mmsl_err)
  );

  // Synchronizing disable_verify_pclk, which
  // is already a toggle by definition
  cdnsdru_datasync_v1 i_disable_verify_tx_clk (
  .clk    (tx_clk),
  .reset_n(n_txreset),
  .din    (disable_verify_pclk),
  .dout   (disable_verify_tx_clk)
  );

  // Synchronizing pre_enable_pclk, which
  // is already a toggle by definition
  cdnsdru_datasync_v1 i_pre_enable_tx_clk (
  .clk    (tx_clk),
  .reset_n(n_txreset),
  .din    (pre_enable_pclk),
  .dout   (pre_enable_tx_clk)
  );

  // Sync and toggle detect before passing it
  // to the verification block
  edma_sync_toggle_detect i_restart_ver_tx_clk (
  .clk      (tx_clk),
  .reset_n  (n_txreset),
  .din      (restart_ver_tog_pclk),
  .any_edge (restart_ver_tx_clk),
  .rise_edge(),
  .fall_edge()
  );

  // Signal asf_dap_mmsl_rx_err if error in eMAC or pMAC paths
  assign asf_dap_mmsl_rx_err  = asf_dap_mmsl_rx_exp_err | asf_dap_mmsl_rx_p_err;

endmodule

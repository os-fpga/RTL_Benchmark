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
//   Filename:           gem_pcs_tx.v
//   Module Name:        gem_pcs_tx
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
//   Description    :   This is the transmit block for the Gigabit PCS layer.
//                      This module will instantiate the transmit state machine
//                      gem_pcs_txstate and the 8b10b encoder.
//                      The incoming GMII signals are not registered as they are
//                      assumed to be registered and synchronised to the gtx_clk
//                      domain by the Gigabit MAC before being passed via GMII.
//                      The main output of this block is the encoded code group
//                      which will be sent directly to the PMA layer.  Output of
//                      the encoder is fully synchronous to gtx_clk.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_pcs_tx

(

  // System inputs
  input             gtx_clk,          // The Gigabit transmit clock.
  input             gtx20_clk,        // Optional 62.5MHz transmit clock
  input             n_gtxreset,       // Active low asynchronous reset.
  input             n_gtx20reset,     // Active low asynchronous reset
  input             sync_reset_txclk, // Synchronous reset in tx_clk domain

  // GMII inputs (from MAC)
  input             tx_en,            // GMII transmit enable signal.
  input     [7:0]   txd,              // GMII transmit data.
  input             txd_par,          // Optional parity
  input             tx_er,            // GMII transmit error signal.

  // Input from RX fault detection
  input             tx_local_fault,   // Local fault was received so transmit remote fault
  input             tx_remote_fault,  // Remote fault or link interruption was received so transmit idle

  // Inputs from auto-neg block.  Registered outputs from gem_pcs_an
  // and double synced through gem_pcs_gtx_sync.
  input     [1:0]   xmit,             // Auto negotiation output indicating
                                      // type of data.
  input             xmit_change_rx_s, // xmit_change synchronized to tx_clk
                                      // this is slightly delayed to give xmit
                                      // a chance to settle.
  input     [15:0]  tx_config_reg,    // Configuration data to be transmitted
                                      // to link partner.  Comes from autoneg.
  input     [1:0]   tx_config_reg_par,// Optional parity

  // Input from receive block.
  input             receiving,        // Input from rx block used for col
                                      // generation. (asynchronous)

  // Register interface inputs.  Registered outputs from gem_pcs_registers
  // and double synced through gem_pcs_gtx_sync
  input             col_test,         // Enable collision testing.

  // Outputs
  output            col,              // GMII collision signal (async)
  output            crs,              // GMII carrier sense (async)
  output    [19:0]  code_group,       // Encoded 10-bit code group.

  // ASF error outputs
  output            tx_dap_err        // Datapath parity error

);

   parameter [1363:0] grouped_params = {1364{1'b0}};

   `include "ungroup_params.v"

  // Internal wire and reg declarations
  wire          col_int;          // col signal from state machine.
  wire          transmitting;     // Signal used to generate carrier sense.
  wire  [8:0]   tx_code;          // Code to be encoded from tx state machine
                                  // Top bit is parity
  wire          tx_control;       // Specify whether to encode data or
                                  // control.
  reg           reset_disparity;  // Hold encoder disparity negative on
                                  // reset.
  wire          force_disp_val;   // Disparity to use when reset_disparity.
  wire          tx_disparity;     // Disparity of last output code.
  wire  [9:0]   tbi_code_int;     // Ten bit code from encoder

  // Instantiate the state machine
  gem_pcs_txstate i_txstate(

    .gtx_clk          (gtx_clk),
    .n_gtxreset       (n_gtxreset),
    .sync_reset       (sync_reset_txclk),
    .tx_en            (tx_en),
    .txd              (txd),
    .txd_par          (txd_par),
    .tx_er            (tx_er),
    .tx_config_reg    (tx_config_reg),
    .tx_config_reg_par(tx_config_reg_par),
    .tx_disparity     (tx_disparity),
    .xmit             (xmit),
    .xmit_change_rx_s (xmit_change_rx_s),
    .receiving        (receiving),
    .col              (col_int),
    .tx_code          (tx_code),
    .tx_control       (tx_control),
    .transmitting     (transmitting),
    .tx_local_fault   (tx_local_fault),
    .tx_remote_fault  (tx_remote_fault)

  );


  // Instantiate the encoder.
  gem_pcs_enc8b10b i_encoder(

    .clk              (gtx_clk),
    .n_reset          (n_gtxreset),
    .din              (tx_code[7:0]), // Drop parity bit.
    .cont             (tx_control),
    .force_disp       (reset_disparity),
    .disp             (force_disp_val),
    .dout             (tbi_code_int),
    .err              (),
    .r_disp_out       (tx_disparity)

  );

  // Always set disparity to negative when we are 'forcing' the disparity.
  assign force_disp_val = 1'b0;

  // Process to force encoder into negative disparity state on reset.
  always@(posedge gtx_clk or negedge n_gtxreset)
  begin
    if (~n_gtxreset)
      reset_disparity <= 1'b1;
    else
      reset_disparity <= sync_reset_txclk;
  end


  // Assign asynchronous GMII signals.  These would be double synced in the
  // appropriate receiving domain, however they are treated as asynchronous
  // on the GMII interface.

  // Assert GMII col signal whenever tx_en goes high when in collision test
  // mode.  Set through register interface.
  assign col = col_int | (tx_en & col_test);

  // Assert GMII carrier sense whenever transmission or reception is
  // occurring.
  assign crs = transmitting | receiving;

  // TOIMPRV instantiate 8B10B decoder and generate signals for lockup detection
  // as well as ensuring decoder error is never set.
  // Alternatively duplicate the encoder as it is relatively small.

  // TOIMPRV tag parity through the gearbox.

  // Output assignment towards SerDes.
  // Instantiate optional TX gearbox if SerDes width is 20-bits.
  generate
    if (p_edma_srd_width > 32'd10)
    begin: GEN_GRBX
      gem_pcs_grbx  i_pcs_tx_grbx (
        .in_clk     (gtx_clk),
        .in_rst_n   (n_gtxreset),
        .out_clk    (gtx20_clk),
        .out_rst_n  (n_gtx20reset),
        .grbx_en    (~sync_reset_txclk),
        .in_data    (tbi_code_int),
        .out_data   (code_group)
      );
    end
    else
    begin: GEN_NO_GRBX
      assign code_group = {10'h000,tbi_code_int};
    end
  endgenerate


  // ASF Parity checking
  generate if (p_edma_asf_dap_prot == 1) begin : gen_par_chk
    cdnsdru_asf_parity_check_v1 #(.p_data_width(8)) i_par_chk (
      .odd_par    (1'b0),
      .data_in    (tx_code[7:0]),
      .parity_in  (tx_code[8]),
      .parity_err (tx_dap_err)
    );
  end else begin : gen_no_par_chk
    assign tx_dap_err = 1'b0;
  end
  endgenerate

endmodule

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
//   Filename:           gem_pcs_rx.v
//   Module Name:        gem_pcs_rx
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
//   Description    :   This module instantiates the required receive modules
//                      and generates the required signals for the PCS rx sub-
//                      system.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_pcs_rx
(

  // System Inputs
  input         rx_clk,           // Receive clock
  input         rx10_clk,         // Receive clock for 10-bit interface
  input         n_reset,          // Active low reset.
  input         n_rx10reset,      // Active low reset.
  input         rbc0,             // receive clock 0 from phy for legacy if
  input         rbc1,             // receive clock 1 from phy for legacy if
  input         n_rbc0reset,      // rbc0 domain reset
  input         n_rbc1reset,      // rbc1 domain reset

  input         signal_detect,    // PMD signal detect.

  input         cal_bypass,       // Bypass optional comma alignment function
  input         cgalign_bypass,   // Bypass optional codegroup align function

  // Register interface inputs.
  input         link_fault_signal_en, // 802.3cb link fault signalling enabled
  input         sync_reset_pclk,  // Synchronous reset in pclk domain
  input         loop_back,        // Register interface input enabling
                                  // loop back.

  // Input from gem_pcs_an
  input [1:0]   xmit,             // Auto-negotiate data type.

  // TBI input code group
  input [19:0]  rx_code_group,    // Receive data

  // Output to gem_pcs_tx
  output        receiving,        // Signal for carrier sense generation.

  // Outputs to gem_pcs_an
  output        sync_status,      // Sync status to auto neg.
  output [1:0]  rx_indicate,      // Receive type indicator to the auto-neg
  output [15:0] rx_config_reg,    // Received configuration data.

  // Outputs to top level
  output        en_cdet,          // Enable comma alignment in PMA.

  // Custom GMII interface to MAC
  output [1:0]  rx_dv,            // Signals going to the Gigabit MAC
  output [1:0]  rx_er,            // interface, that is twice the width of
  output [15:0] rxd,              // standard GMII at half the clock speed.
  output [1:0]  rxd_par,          // Optional parity to pass to MAC.

  // Reset detect signals back to registers block.
  output        sync_reset_rx,    // Synchronous reset in rx_clk domain

  // ASF error outputs
  output        rx_dap_err,       // Datapath parity error

  // link fault outuputs
  output [1:0]  link_fault_status // 00 - OK; 01 - local fault; 10 - remote fault; 11 - link interruption

);

   parameter [1363:0] grouped_params = {1364{1'b0}};

   `include "ungroup_params.v"

  // Internal signals
  wire  [19:0]    rx_cg_aligned;        // Aligned 20-bit data
  wire  [7:0]     doutA;                // Decoder A output
  wire  [7:0]     doutB;                // Decoder B output
  wire            contA;                // Decoder A control
  wire            contB;                // Decoder B control
  wire            errA;                 // Decoder A error
  wire            errB;                 // Decoder B error
  wire            disp_out_A;           // Decoder A disparity.
  wire            disp_out_B;           // Decoder B disparity.

  wire  [15:0]    rx_code_future;       // The decoded data, control and
  wire  [1:0]     rx_code_future_par;   // Optional generated parity
  wire  [1:0]     rx_control_future;    // error signals are delayed such
  wire  [1:0]     rx_dec_error_future;  // that we generate 32-bits of
                                        // data consisting of the current
  reg   [15:0]    rx_code_current;      // working set and the next working
  wire  [1:0]     rx_code_current_par;  // Optional parity
  reg   [1:0]     rx_control_current;   // set.  The next working set will
  reg   [1:0]     rx_dec_error_current; // become current on next clock.

  reg             force_disparity;      // Force initial disparity on reset.

  wire            carrier_detect;       // Carrier detected.
  reg             carrier;              // Signal delayed to align with data.

  wire  [31:0]    rx_code;              // Concatenation of the current and
  wire  [3:0]     rx_code_par;          // Optional parity
  wire  [3:0]     rx_dec_error;         // future working set of decoded
  wire  [3:0]     rx_control;           // signals.

  reg             disp_in_A;            // Disparity input to decoder A.
  reg             disp_in_B;            // Disparity input to decoder B.
  wire  [19:0]    rx_code_group_int;    // Internal 20-bit code group


  // detect active high synchronous reset from pclk into rx_clk
  cdnsdru_datasync_v1 #(.CDNSDRU_DATASYNC_RESET_STATE(1'b1),.CDNSDRU_DATASYNC_NUM_FLOPS(32'd2)) i_sync_reset_pclk (
     .clk(rx_clk),
     .reset_n(n_reset),
     .din(sync_reset_pclk),
     .dout(sync_reset_rx));


  // If interface is legacy, generate rx_code_group_int from rx_code_group
  // by capturing on both rbc0 and rbc1 clocks.
  generate
    if (p_edma_pcs_legacy_if == 1)
    begin: GEN_LEGACY
      // A set of registers to transfer rbc0/rbc1 data to single bank of
      // flops on rbc1...
      reg  [9:0]   rx_code_rbc0;   // rx_code_group sampled on rbc0
      reg  [9:0]   rx_code_rbc1;   // rx_code_group sampled on rbc1
      reg  [19:0]  rx_code_20;     // Pipeline register
      always@(posedge rbc0 or negedge n_rbc0reset)
      begin
        if (~n_rbc0reset)
          rx_code_rbc0 <= 10'h000;
        else
          rx_code_rbc0 <= rx_code_group[9:0];
      end

      always@(posedge rbc1 or negedge n_rbc1reset)
      begin
        if (~n_rbc1reset)
          rx_code_rbc1 <= 10'h000;
        else
          rx_code_rbc1 <= rx_code_group[9:0];
      end

      // Pipeline register for better timing
      // Note that rx_clk and rbc1 should be tied together at higher level
      always@(posedge rx_clk or negedge n_reset)
      begin
        if (~n_reset)
          rx_code_20  <= 20'h00000;
        else
          rx_code_20  <= {rx_code_rbc0,rx_code_rbc1};
      end

      assign rx_code_group_int  = rx_code_20;
    end
    else if (p_edma_srd_width < 32'd20)
    // Instantiate optional gearbox if not legacy and 10-bit interface
    begin: GEN_GRBX
      gem_pcs_grbx  i_grbx (
        .in_clk     (rx10_clk),
        .in_rst_n   (n_rx10reset),
        .out_clk    (rx_clk),
        .out_rst_n  (n_reset),
        .grbx_en    (~sync_reset_rx),
        .in_data    (rx_code_group[9:0]),
        .out_data   (rx_code_group_int)
      );
    end
    else
    begin: GEN_NO_GRBX
      assign rx_code_group_int  = rx_code_group;
    end
  endgenerate

  // Instantiate optional comma and code group alignment.
  generate
    if (p_edma_pcs_code_align > 0)
    begin: GEN_RX_ALIGN
      wire  [19:0]  rx_comma_aligned;

      // Instantiate comma alignment module.
      gem_pcs_rx_cal  i_cal (
        .clk          (rx_clk),
        .rst_n        (n_reset),
        .pma_rd       (rx_code_group_int),
        .bypass       (cal_bypass),
        .en_cal       (en_cdet),
        .polarity_inv (1'b0),
        .rcal_rx_data (rx_comma_aligned)
      );

      // Instantiate optional code group alignment.
      gem_pcs_rx_cg_align i_cg_align (
        .rx_clk       (rx_clk),
        .n_rxreset    (n_reset),
        .bypass       (cgalign_bypass),
        .rx_code      (rx_comma_aligned),
        .rx_aligned   (rx_cg_aligned)
      );

    end
    else
    begin: GEN_NO_ALIGN
      assign rx_cg_aligned  = rx_code_group_int;
    end
  endgenerate


  // Instantiate the two decoders.

  // Decoder A. Should contain even code.
  gem_pcs_dec8b10b i_decoderA (
    .clk          (rx_clk),
    .n_reset      (n_reset),
    .din          (rx_cg_aligned[9:0]),
    .force_disp   (1'b1),
    .disp         (disp_in_A),
    .dout         (doutA),
    .cont         (contA),
    .err          (errA),
    .r_disp_out   (disp_out_A),
    .r_disp       ()
  );

  // Decoder B. Should contain odd code words.
  gem_pcs_dec8b10b i_decoderB(
    .clk          (rx_clk),
    .n_reset      (n_reset),
    .din          (rx_cg_aligned[19:10]),
    .force_disp   (1'b1),
    .disp         (disp_in_B),
    .dout         (doutB),
    .cont         (contB),
    .err          (errB),
    .r_disp_out   (),
    .r_disp       (disp_out_B)
  );

  // force_disparity used for gating to allow initial disparity to be set
  // to negative on reset.
  always@(*)
  begin
    if (force_disparity)
    begin
      disp_in_A = 1'b0;
      disp_in_B = 1'b0;
    end
    else
    begin
      disp_in_A = disp_out_B;
      disp_in_B = disp_out_A;
    end
  end


  // Concatenate to form 16-bit future values.
  assign rx_code_future = {doutB, doutA};
  assign rx_control_future = {contB, contA};
  assign rx_dec_error_future = {errB, errA};

  generate if (p_edma_asf_dap_prot == 1) begin : gen_par_code_fut
    cdnsdru_asf_parity_gen_v1 #(.p_data_width(16)) i_par_code_fut (
      .odd_par    (1'b0),
      .data_in    (rx_code_future),
      .data_out   (),
      .parity_out (rx_code_future_par)
    );

  end else begin : gen_no_par_code_fut
    assign rx_code_future_par = 2'b00;
  end
  endgenerate

  // Perform asynchronous reset to force decoder disparity to negative, also
  // to delay the decoder outputs to generate current and future code values.
  // Clocked on rx_clk so should sample code sequences correctly starting
  // with even code on decoder A.
  // Note that the carrier detected signal is also delayed to ensure it
  // remains properly aligned.
  always@(posedge rx_clk or negedge n_reset)
  begin
    if (~n_reset)
    begin
      rx_code_current       <= 16'h0000;
      rx_control_current    <= 2'b00;
      rx_dec_error_current  <= 2'b00;
      force_disparity       <= 1'b1;
      carrier               <= 1'b0;
    end
    else
      if (sync_reset_rx)
      begin
        rx_code_current       <= 16'h0000;
        rx_control_current    <= 2'b00;
        rx_dec_error_current  <= 2'b00;
        force_disparity       <= 1'b1;
        carrier               <= 1'b0;
      end
      else
      begin
        rx_code_current       <= rx_code_future;
        rx_control_current    <= rx_control_future;
        rx_dec_error_current  <= rx_dec_error_future;
        force_disparity       <= 1'b0;
        carrier               <= carrier_detect;
      end
  end


  generate if (p_edma_asf_dap_prot == 1) begin : gen_par_code_cur
    reg [1:0] rx_code_current_par_r;
    always@(posedge rx_clk or negedge n_reset)
    begin
      if (~n_reset)
        rx_code_current_par_r <= 2'b00;
      else if (sync_reset_rx)
        rx_code_current_par_r <= 2'b00;
      else
        rx_code_current_par_r <= rx_code_future_par;
    end
    assign rx_code_current_par  = rx_code_current_par_r;
  end else begin : gen_no_par_code_cur
    assign rx_code_current_par  = 2'b00;
  end
  endgenerate

  // Concatenate to form 32-bit working code set to state machines
  assign rx_code      = {rx_code_future, rx_code_current};
  assign rx_code_par  = {rx_code_future_par, rx_code_current_par};
  assign rx_control   = {rx_control_future, rx_control_current};
  assign rx_dec_error = {rx_dec_error_future, rx_dec_error_current};


  // Instantiate the link fault state machine (part of RS) ..
  gem_pcs_rx_fault i_gem_pcs_rx_fault (
    // System Signals
    .rx_clk               (rx_clk),
    .n_rx_reset           (n_reset),
    .link_fault_signal_en (link_fault_signal_en),
    .sync_status          (sync_status),

    // signals coming from pipeline
    .rx_code              (rx_code[15:0]),
    .rx_control           (rx_control[1:0]),

    // Output signals
    .link_fault_status    (link_fault_status)

  );

  // Instantiate the gem_pcs_rx_sync state machine
  gem_pcs_rxsync i_rxsync_state(
    .rx_clk         (rx_clk),
    .n_reset        (n_reset),
    .sync_reset     (sync_reset_rx),
    .rx_code        (rx_code[15:0]),
    .rx_control     (rx_control[1:0]),
    .rx_dec_error   (rx_dec_error[1:0]),
    .signal_detect  (signal_detect),
    .loop_back      (loop_back),
    .sync_status    (sync_status),
    .en_cdet        (en_cdet)
  );

  // Instantiate the carrier detect module.
  gem_pcs_carrier_det i_carrier_det(
    .rx_clk         (rx_clk),
    .n_reset        (n_reset),
    .sync_reset     (sync_reset_rx),
    .tbi_code       (rx_cg_aligned[9:0]),
//    .rdisp_odd      (disp_out_B),
    .carrier        (carrier_detect)
  );

  // Finally instantiate the state machine.
  gem_pcs_rxstate i_rxstate(
    .rx_clk         (rx_clk),
    .n_reset        (n_reset),
    .sync_reset     (sync_reset_rx),
    .rx_code        (rx_code),
    .rx_code_par    (rx_code_par),
    .rx_dec_error   (rx_dec_error),
    .rx_control     (rx_control),
    .xmit           (xmit),
    .sync_status    (sync_status),
    .carrier_detect (carrier),
    .rx_dv          (rx_dv),
    .rx_er          (rx_er),
    .rxd            (rxd),
    .rxd_par        (rxd_par),
    .receiving      (receiving),
    .rx_config_reg  (rx_config_reg),
    .rx_indicate    (rx_indicate)
  );

  // Optional parity check for rxd
  generate if (p_edma_asf_dap_prot == 1) begin : gen_par_chk
    cdnsdru_asf_parity_check_v1 #(.p_data_width(16)) i_par_chk (
      .odd_par    (1'b0),
      .data_in    (rxd),
      .parity_in  (rxd_par),
      .parity_err (rx_dap_err)
    );
  end else begin : gen_no_par_chk
    assign rx_dap_err = 1'b0;
  end
  endgenerate


endmodule

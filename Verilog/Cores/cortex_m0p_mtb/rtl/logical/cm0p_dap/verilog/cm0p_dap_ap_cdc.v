//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2008-2012 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//   Checked In : $Date: 2011-12-30 10:51:05 +0000 (Fri, 30 Dec 2011) $
//   Revision   : $Revision: 196368 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

module cm0p_dap_ap_cdc
  #(parameter CBAW    = 0,
    parameter RAR     = 0
    )
   (input  wire        dclk,
    input  wire        apreset_n,
    input  wire        dp_rnw_i,
    input  wire  [3:0] dp_regaddr_i,
    input  wire [31:0] dp_data_i,
    output wire [31:0] ap_data_o,
    output wire        ap_err_o,
    input  wire [31:0] ap_data_ap_i,
    input  wire        ap_err_ap_i,
    output wire [31:0] dp_data_ap_o,
    output wire  [3:0] dp_regaddr_ap_o,
    output wire        dp_rnw_ap_o,
    input  wire        ap_wr_en_i,
    input  wire        ap_out_en_i,
    input  wire        dp_req_dp_i,
    output wire        dp_req_ap_o,
    output wire        ap_ack_ap_o,
    input  wire        ap_ack_load_i,
    input  wire        DFTSE
  );

// ----------------------------------------------------------------------------
// Handshake Signals
  //The dp_req_dp signal comes from the DP. The signal needs to be synchronised
  //into the AP's clock domain before it can safely be used in the AP.
  //The ap_ack_ap_o signal is to be sent to the DP and needs to be driven by
  //a CDC-safe launch flop.
// ----------------------------------------------------------------------------
  cm0p_dap_cdc_capt_sync
    u_dp_req_sync
    ( .SYNCRSTn   (apreset_n),
      .SYNCCLK    (dclk),
      .SYNCDI     (dp_req_dp_i),
      .DFTSE      (DFTSE),
      .SYNCDO     (dp_req_ap_o)
    );

  cm0p_dap_cdc_send_reset
    u_reg_ap_ack
    ( .REGCLK     (dclk),
      .REGRESETn  (apreset_n),
      .REGEN      (ap_ack_load_i),
      .REGDI      (dp_req_ap_o),
      .DFTSE      (DFTSE),
      .REGDO      (ap_ack_ap_o) );

// ----------------------------------------------------------------------------
// Registers
  //NB The registers are not reset, as by definition they are only used to
  //transfer data and must therefore have been loaded with useful data before
  //they are read.
  //The registers will have their output connected to logic in the other
  //clock domain, so care must be taken that the output does not glitch when
  //the input is not enabled. To ensure this, specific "CDC-Safe" registers
  //are used which are instantiated as a separate module.
// ----------------------------------------------------------------------------

  // - ap_data Launch
  cm0p_dap_cdc_send_data
    #(.CBAW     (CBAW),
      .RAR      (RAR))
    u_reg_ap_data
    ( .REGCLK        (dclk),
      .REGRESETn     (apreset_n),
      .REGEN         (ap_wr_en_i),
      .REGDI         (ap_data_ap_i),
      .DFTSE         (DFTSE),
      .REGDO         (ap_data_o) );

  // - ap_err
  cm0p_dap_cdc_send
    #(.CBAW     (CBAW),
      .RAR      (RAR))
    u_reg_ap_err
    ( .REGCLK        (dclk),
      .REGRESETn     (apreset_n),
      .REGEN         (ap_wr_en_i),
      .REGDI         (ap_err_ap_i),
      .DFTSE         (DFTSE),
      .REGDO         (ap_err_o) );

// ----------------------------------------------------------------------------
// Assign Outputs
  //Note that because AP domain outputs are connected to DP domain inputs
  //(and vice-versa), the outputs are masked by a control signal in the
  //output domain to avoid glitches. This masking is performed by
  //a "CDC-Safe" AND gate, i.e. one which ensures that if one of the inputs
  //is low, then changes on the other input do not cause glitches on the
  //outputs. To ensure that this requirement can be met in implementation,
  //the mask is instantiated as a separate module.
// ----------------------------------------------------------------------------

  //AP Outputs
  // - dp_data_ap
  cm0p_dap_cdc_comb_and_data
    u_mask_dp_data
    ( .DATAIN   (dp_data_i),
      .MASKn    (ap_out_en_i),
      .DATAOUT  (dp_data_ap_o));

  // - dp_regaddr_ap
  cm0p_dap_cdc_comb_and_addr
    u_mask_dp_regaddr
    ( .DATAIN   (dp_regaddr_i),
      .MASKn    (ap_out_en_i),
      .DATAOUT  (dp_regaddr_ap_o));

  // - dp_rnw_ap
  cm0p_dap_cdc_comb_and
    u_mask_dp_rnw
    ( .DATAIN   (dp_rnw_i),
      .MASKn    (ap_out_en_i),
      .DATAOUT  (dp_rnw_ap_o));

// ----------------------------------------------------------------------------
// Assertions
// ----------------------------------------------------------------------------
`ifdef ARM_ASSERT_ON
  `include "std_ovl_defines.h"

  // - ap_wr_en_i[3:0]
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
       .width               (1),
       .property_type       (`OVL_ASSERT),
       .msg                 ("ap_wr_en_i must never be x"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_x_check_ap_wr_en
    ( .clock      (dclk),
      .reset      (apreset_n),
      .enable     (1'b1),
      .qualifier  (1'b1),
      .test_expr  (ap_wr_en_i),
      .fire       ());

`endif
endmodule

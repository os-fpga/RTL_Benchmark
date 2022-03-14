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

module cm0p_dap_dp_cdc
  #(parameter CBAW    = 0,
    parameter RAR     = 0
    )
    (// Inputs
     input  wire        swclktck,
     input  wire        dpreset_n,
     input  wire        dp_wr_en_i,
     input  wire        dp_rnw_dp_i,
     input  wire  [3:0] dp_regaddr_dp_i,
     input  wire [31:0] dp_data_dp_i,
     input  wire        dp_out_en_i,
     input  wire        dp_err_out_en_i,
     input  wire [31:0] ap_data_i,
     input  wire        ap_err_i,
     input  wire        ap_ack_ap_i,
     input  wire        dp_req_dp_load_i,
     input  wire        DFTSE,

     // Outputs
     output wire [31:0] ap_data_dp_o,
     output wire        ap_err_dp_o,
     output wire        ap_ack_dp_o,
     output wire        dp_rnw_o,
     output wire  [3:0] dp_regaddr_o,
     output wire [31:0] dp_data_o,
     output wire        dp_req_dp_o
     );

// ----------------------------------------------------------------------------
// Signal Declarations
// ----------------------------------------------------------------------------

  wire          dp_req_dp;
  wire          dp_req_dp_next;

  // Outputs
  assign dp_req_dp_o        = dp_req_dp;

// ----------------------------------------------------------------------------
// Handshake Signal
// The ap_ack_ap_i signal comes from the AP. The signal needs to be synchronised
// into the DP clock domain before it can be used in the DP block.
// The dp_req_dp signal goes to the AP and needs to be driven by a CDC-safe
// launch flop.
// ----------------------------------------------------------------------------
  cm0p_dap_cdc_capt_sync
    u_ap_ack_sync
    (
      .SYNCRSTn   (dpreset_n),
      .SYNCCLK    (swclktck),
      .SYNCDI     (ap_ack_ap_i),
      .DFTSE      (DFTSE),
      .SYNCDO     (ap_ack_dp_o)
  );

  // Handshake logic - invert request on load
  assign dp_req_dp_next = ~dp_req_dp;

  cm0p_dap_cdc_send_reset
    u_reg_dp_req_dp (
      .REGCLK     (swclktck),
      .REGRESETn  (dpreset_n),
      .REGEN      (dp_req_dp_load_i),
      .REGDI      (dp_req_dp_next),
      .DFTSE      (DFTSE),
      .REGDO      (dp_req_dp)
  );

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

  // - dp_data_o Launch
  cm0p_dap_cdc_send_data
    #(.CBAW      (CBAW),
      .RAR       (RAR))
    u_reg_dp_data
    ( .REGCLK    (swclktck),
      .REGRESETn (dpreset_n),
      .REGEN     (dp_wr_en_i),
      .REGDI     (dp_data_dp_i),
      .DFTSE     (DFTSE),
      .REGDO     (dp_data_o));

  // - dp_regaddr_o Launch
  cm0p_dap_cdc_send_addr
    #(.CBAW      (CBAW),
      .RAR       (RAR))
    u_reg_dp_regaddr
    ( .REGCLK    (swclktck),
      .REGRESETn (dpreset_n),
      .REGEN     (dp_wr_en_i),
      .REGDI     (dp_regaddr_dp_i),
      .DFTSE     (DFTSE),
      .REGDO     (dp_regaddr_o));

  // - dp_rnw_o Launch
  cm0p_dap_cdc_send
    #(.CBAW      (CBAW),
      .RAR       (RAR))
    u_reg_dp_rnw
    ( .REGCLK    (swclktck),
      .REGRESETn (dpreset_n),
      .REGEN     (dp_wr_en_i),
      .REGDI     (dp_rnw_dp_i),
      .DFTSE     (DFTSE),
      .REGDO     (dp_rnw_o));

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

  //DP Outputs
  // - ap_data_dp_o
  cm0p_dap_cdc_comb_and_data
    u_mask_ap_data_ap
    ( .DATAIN   (ap_data_i),
      .MASKn    (dp_out_en_i),
      .DATAOUT  (ap_data_dp_o));

  // - ap_err_dp_o
  cm0p_dap_cdc_comb_and
    u_mask_ap_err_ap
    ( .DATAIN   (ap_err_i),
      .MASKn    (dp_err_out_en_i),
      .DATAOUT  (ap_err_dp_o));


// ----------------------------------------------------------------------------
// Assertions
// ----------------------------------------------------------------------------
`ifdef ARM_ASSERT_ON
  `include "std_ovl_defines.h"

  //Check enable terms to flops are never unknown
  // - dp_wr_en_i
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("dp_wr_en_i must never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
   u_asrt_x_check_dp_wr_en
     ( .clock      (swclktck),
       .reset      (dpreset_n),
       .enable     (1'b1),
       .qualifier  (1'b1),
       .test_expr  (dp_wr_en_i),
       .fire       ());

`endif

endmodule

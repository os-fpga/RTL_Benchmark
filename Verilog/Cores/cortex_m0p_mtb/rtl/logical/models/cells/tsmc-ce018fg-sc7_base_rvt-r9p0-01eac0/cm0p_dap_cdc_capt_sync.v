//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited or its affiliates.
//
//            (C) COPYRIGHT 2008-2016 ARM Limited or its affiliates.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited or its affiliates.
//
//   Checked In : $Date: 2011-12-30 10:51:05 +0000 (Fri, 30 Dec 2011) $
//   Revision   : $Revision: 196368 $
//   Release    : Cortex-M0+ AT590-r0p1-01rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

module cm0p_dap_cdc_capt_sync
          (input  wire SYNCRSTn,   // Synchronising Reset
           input  wire SYNCCLK,    // Synchronising Clock
           input  wire SYNCDI,     // Synchronising Data In
           input  wire DFTSE,      // Scan Enable for DFT
           output wire SYNCDO);    // Synchronising Data Out

  // --------------------------------------------------------------------------
  // This module is instantiated where a CDC-safe synchroniser is required,
  // i.e. where the input is from a different clock domain. The signal is
  // sampled using a series of two registers to minimise the chance of
  // metastability being introduced if the input changes around the time it
  // is sampled.
  //
  // The implementation of this module must ensure that this requirement is
  // met.
  // --------------------------------------------------------------------------

  // --------------------------------------------------------------------------
  // In this example for the RM, 2 back to back SDFFR flops are used to implement
  // the synchroniser. The synthesis tool should be configured so that these gates
  // arent resynthesised into alternative gates, though resizing is allowed.
  // --------------------------------------------------------------------------

  // --------------------------------------------------------------------------
  // Signal Declarations
  // --------------------------------------------------------------------------

     wire sync_q0;  // output of 1st synchroniser

  //----------------------------------------------------------------------------
  // Beginning of main code
  //----------------------------------------------------------------------------

  // synchroniser


  SDFFRQ_X2_A7TULL HANDINST_sync_q0_reg
     (.CK (SYNCCLK),
      .RN (SYNCRSTn),
      .D  (SYNCDI),
      .SI (),
      .SE (DFTSE),
      .Q  (sync_q0));

  SDFFRQ_X2_A7TULL HANDINST_sync_q1_reg
     (.CK (SYNCCLK),
      .RN (SYNCRSTn),
      .D  (sync_q0),
      .SI (),
      .SE (DFTSE),
      .Q  (SYNCDO));



`ifdef ARM_ASSERT_ON
  `include "std_ovl_defines.h"

  // Glitching Input - valid waveform, but undesirable in handshake design.
  ovl_never
    #(.severity_level(`OVL_WARNING),
      .property_type(`OVL_ASSERT),
      .msg("Glitching Input - valid waveform, but undesirable in handshake design."),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_warning_sync_glitch
     (
      .clock     (SYNCCLK),
      .reset     (SYNCRSTn),
      .enable    (1'b1),
      .test_expr ((sync_q0!=SYNCDI)&&(sync_q0!=sync_q1)),
      .fire      ());

  // Input X not allowed - halt propogation at synchroniser level.
  ovl_never_unknown
    #(.severity_level(`OVL_FATAL),
      .width(1),
      .property_type(`OVL_ASSERT),
      .msg("Input X not allowed - halt propogation at synchroniser level."),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_sync_xprop
     (
      .clock     (SYNCCLK),
      .reset     (SYNCRSTn),
      .enable    (1'b1),
      .qualifier (1'b1),
      .test_expr (SYNCDI),
      .fire      ());

`endif //  `ifdef ARM_ASSERT_ON


endmodule

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

module cm0p_pmu_sync_set
          (input  wire SYNCSETn,   // Synchronising Set
           input  wire SYNCCLK,    // Synchronising Clock
           input  wire SYNCDI,     // Synchronising Data In
           output wire SYNCDO);    // Synchronising Data Out

  // --------------------------------------------------------------------------
  // NOTE: THIS MODULE IS NOT INTENDED FOR USE IN SYNTHESIS
  // IT IS STRONGLY RECOMMENDED THAT AN EQUIVALENT MODULE
  // DIRECTLY INSTANTIATING CELLS FROM YOUR LIBRARY THAT MEET
  // THE REQUIREMENTS DETAILED BELOW IS USED INSTEAD
  // --------------------------------------------------------------------------

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
  // Signal Declarations
  // --------------------------------------------------------------------------

  reg           SyncQ;      // 1st synchroniser DFF
  reg           SyncQQ;     // 2nd synchroniser DFF

  //----------------------------------------------------------------------------
  // Beginning of main code
  //----------------------------------------------------------------------------

  // synchroniser
  always @ (posedge SYNCCLK or negedge SYNCSETn)
    if (!SYNCSETn)
      begin
       SyncQQ <= 1'b1;
       SyncQ  <= 1'b1;
      end
    else
      begin
        SyncQQ <= SyncQ;
        SyncQ  <= SYNCDI;
      end

  assign SYNCDO = SyncQQ;

`ifdef ARM_ASSERT_ON
  `include "std_ovl_defines.h"

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
  u_pmu_sync_xprop
    (
     .clock     (SYNCCLK),
     .reset     (SYNCSETn),
     .enable    (1'b1),
     .qualifier (1'b1),
     .test_expr (SYNCDI),
     .fire      ());

`endif //  `ifdef ARM_ASSERT_ON


endmodule

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

module cm0p_dap_cdc_send
         #(parameter   CBAW    = 0,
           parameter   RAR     = 0
           )
          (input  wire REGCLK,    // Register Clock
           input  wire REGRESETn, // Reset (if RAR enabled)
           input  wire REGEN,     // Register Load Enable
           input  wire REGDI,     // Data Input
           input  wire DFTSE,     // Scan Enable for DFT
           output wire REGDO);    // Data Output

  // --------------------------------------------------------------------------
  // NOTE: THIS MODULE IS NOT INTENDED FOR USE IN SYNTHESIS
  // IT IS STRONGLY RECOMMENDED THAT AN EQUIVALENT MODULE
  // DIRECTLY INSTANTIATING CELLS FROM YOUR LIBRARY THAT MEET
  // THE REQUIREMENTS DETAILED BELOW IS USED INSTEAD
  // --------------------------------------------------------------------------

  // --------------------------------------------------------------------------
  // This module is instantiated where a CDC-safe send (launch) register is
  // required, i.e. where the output of the register is used in a different
  // clock domain to the register. In this case, it is necesssary to ensure
  // that the output of the register does not glitch when the register enable
  // signal, REGEN, is low.
  //
  // REGRESETn is only asserted in the "Reset All Registers" configuration.
  // In the non-RAR configuration this input may be left unconnected and
  // registers without an asynchronous reset instantiated instead.
  //
  // The implementation of this module must ensure that this requirement is
  // met.
  // --------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// Configurablility
// ----------------------------------------------------------------------------
  wire     cfg_rar;

  generate
    if (CBAW == 0) begin : gen_cbaw
      assign cfg_rar    = (RAR != 0);
    end
  endgenerate

  reg iregdo;  // Output of Register

  generate
    if ((CBAW != 0) || (RAR != 0)) begin : gen_rar

      wire rar_resetn = cfg_rar ? REGRESETn : 1'b1;

      always @ (posedge REGCLK or negedge rar_resetn)
        if (!rar_resetn)
          iregdo <= 1'b0;
        else if (REGEN)
          iregdo <= REGDI;

    end else begin : gen_non_rar

      wire unused = REGRESETn;

      always @ (posedge REGCLK)
        if (REGEN)
          iregdo <= REGDI;

    end
  endgenerate

  assign REGDO = iregdo;

  `ifdef ARM_ASSERT_ON
    `include "std_ovl_defines.h"

    ovl_never_unknown
      #(.severity_level(`OVL_FATAL),
        .width(1),
        .property_type(`OVL_ASSERT),
        .msg("CDC Register Enable must never be X"),
        .coverage_level(`OVL_COVER_DEFAULT),
        .clock_edge(`OVL_POSEDGE),
        .reset_polarity(`OVL_ACTIVE_LOW),
        .gating_type(`OVL_GATE_NONE))
   u_asrt_x_check_cdc_reg_en
     (
      .clock      (REGCLK),
      .reset      (REGRESETn),
      .enable     (1'b1),
      .qualifier  (1'b1),
      .test_expr  (REGEN),
      .fire       ()
      );

  `endif

endmodule

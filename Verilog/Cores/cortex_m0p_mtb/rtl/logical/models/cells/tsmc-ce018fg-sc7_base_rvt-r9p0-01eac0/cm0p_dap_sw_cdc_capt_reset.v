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

module cm0p_dap_sw_cdc_capt_reset
          (input  wire REGCLK,     // Register Clock
           input  wire REGRESETn,  // Reset
           input  wire REGDI,      // Data Input
           input  wire DFTSE,      // Scan Enable for DFT
           output wire REGDO);     // Data Output

  // --------------------------------------------------------------------------
  // This module is instantiated where a CDC signal is sampled. The register
  // output may become metastable when the input signal was not stable at
  // a clock edge but must resolve this condition at the next clock edge
  // when the input is stable.
  //
  // The reset state of this register must be 1 for correct operation.
  //
  // The implementation of this module must ensure that this requirement is
  // met.
  // --------------------------------------------------------------------------

  // --------------------------------------------------------------------------
  // In this example, the above behaviour is ensured by using a "set" capture
  // register (SDFFS). The synthesis tool should be configured so that
  // these gates arent resynthesised into alternative gates, though resizing
  // is allowed.
  // --------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Beginning of main code
  //----------------------------------------------------------------------------

      SDFFSQ_X2_A7TULL HANDINST_iregdo_reg
        (.CK  (REGCLK),
         .SN  (REGRESETn),
         .D   (REGDI),
         .SI  (),
         .SE  (DFTSE),
         .Q   (REGDO));

endmodule

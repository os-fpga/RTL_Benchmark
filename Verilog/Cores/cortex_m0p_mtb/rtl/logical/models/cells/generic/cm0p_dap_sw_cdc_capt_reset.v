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

module cm0p_dap_sw_cdc_capt_reset
          (input  wire REGCLK,     // Register Clock
           input  wire REGRESETn,  // Reset
           input  wire REGDI,      // Data Input
           input  wire DFTSE,      // Scan Enable for DFT
           output wire REGDO);     // Data Output

  // --------------------------------------------------------------------------
  // NOTE: THIS MODULE IS NOT INTENDED FOR USE IN SYNTHESIS
  // IT IS STRONGLY RECOMMENDED THAT AN EQUIVALENT MODULE
  // DIRECTLY INSTANTIATING CELLS FROM YOUR LIBRARY THAT MEET
  // THE REQUIREMENTS DETAILED BELOW IS USED INSTEAD
  // --------------------------------------------------------------------------

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
  // Signal Declarations
  // --------------------------------------------------------------------------

  reg iregdo;  // Output of Register

  //----------------------------------------------------------------------------
  // Beginning of main code
  //----------------------------------------------------------------------------

  //Register
  always @ (posedge REGCLK or negedge REGRESETn)
    if (!REGRESETn)
      iregdo <= 1'b1;   // The register MUST reset to 1
    else
      iregdo <= REGDI;

  // The output from the first register must only be sampled when the input
  // sequence was known to be synchronous.
  assign REGDO = iregdo;

endmodule

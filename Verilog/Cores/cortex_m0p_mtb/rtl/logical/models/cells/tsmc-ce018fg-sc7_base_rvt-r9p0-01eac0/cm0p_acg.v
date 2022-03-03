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
//   Checked In : $Date: 2011-12-30 17:59:54 +0000 (Fri, 30 Dec 2011) $
//   Revision   : $Revision: 196408 $
//   Release    : Cortex-M0+ AT590-r0p1-01rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

module cm0p_acg
  (input  wire CLKIN,
   input  wire ENABLE,
   input  wire DFTSE,
   output wire CLKOUT);

   // ------------------------------------------------------------
   // NOTE: THIS FILE PROVIDES AN EXAMPLE LIBRARY SPECIFIC ICG
   //       CELL INSTANTIATION. SIGNALS USED ARE AS FOLLOWS:
   //
   //          CLKIN  - CLOCK INPUT
   //          ENABLE - ACTIVE HIGH CLOCK ENABLE INPUT
   //          DFTSE  - ENABLE BYPASS FOR SCAN TEST PURPOSES
   //          CLKOUT - CLOCK OUTPUT OF CLOCK GATE CELL
   //
   // ------------------------------------------------------------

   // ------------------------------------------------------------
   // Library specific clock gate cell instantiation
   // ------------------------------------------------------------

  // TLATNTSCA_X8_A7TULL uICGCell
  //   (.ECK (CLKOUT),
   //   .E   (ENABLE),
    //  .SE  (DFTSE),
    //  .CK  (CLKIN));

endmodule

// ----------------------------------------------------------------------------
// EOF
// ----------------------------------------------------------------------------

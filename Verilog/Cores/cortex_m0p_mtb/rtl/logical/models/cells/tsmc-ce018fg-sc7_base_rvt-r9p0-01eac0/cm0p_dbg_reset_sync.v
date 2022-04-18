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

module cm0p_dbg_reset_sync
             (input  wire RSTIN,
              input  wire CLK,
              input  wire DFTSE,
              input  wire DFTRSTDISABLE,
              output wire RSTOUT);

  // This module is instantiated where a reset synchroniser is required.
  // The purpose of this module is to produce a reset which is asynchronously
  // asserted and synchronously deasserted from a reset that is both asserted
  // and deasserted asynchronously. Note that it is assumed here that
  // the resets in question are active LOW

  // Requirements
  // -------------

  // 1 - The final D-type in the synchroniser must be guaranteed to
  // change cleanly (i.e. never glitch) whilst reset is held
  // inactive

  // --------------------------------------------------------------------------
  // In this example for the RM, 3 SDFFR flops are used to implement
  // the reset synchroniser, with a 2 input OR to allow the reset to be
  // supressed. A large OR is chosen in order to better drive a high fanout reset
  // tree. The synthesis tool should be configured so that these gates arent
  // resynthesised into alternative gates, though resizing is allowed.
  // --------------------------------------------------------------------------

  // ------------------------------------------------------------
  // Reference model for reset synchroniser
  // ------------------------------------------------------------

      wire  rst_sync0, rst_sync1, rst_sync2;

      SDFFRQ_X1_A7TULL HANDINST_rst_sync0_reg
        (.CK (CLK),
         .RN (RSTIN),
         .D  (1'b1),
         .SI (),
         .SE (DFTSE),
         .Q  (rst_sync0));

      SDFFRQ_X1_A7TULL HANDINST_rst_sync1_reg
        (.CK (CLK),
         .RN (RSTIN),
         .D  (rst_sync0),
         .SI (),
         .SE (DFTSE),
         .Q  (rst_sync1));

      SDFFRQ_X4_A7TULL HANDINST_rst_sync2_reg
        (.CK (CLK),
         .RN (RSTIN),
         .D  (rst_sync1),
         .SI (),
         .SE (DFTSE),
         .Q  (rst_sync2));

      OR2_X4_A7TULL HANDINST_RSTOUT
        (.A  (rst_sync2),
         .B  (DFTRSTDISABLE),
         .Y  (RSTOUT));

endmodule

// ---------------------------------------------------------------
// EOF
// ---------------------------------------------------------------

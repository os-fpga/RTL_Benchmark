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

  // ------------------------------------------------------------
  // NOTE: THIS MODULE IS NOT INTENDED FOR USE IN SYNTHESIS
  // IT IS STRONGLY RECOMMENDED THAT AN EQUIVALENT MODULE
  // DIRECTLY INSTANTIATING CELLS FROM YOUR LIBRARY THAT MEET
  // THE REQUIREMENTS DETAILED BELOW IS USED INSTEAD
  // ------------------------------------------------------------

  // Requirements
  // -------------

  // 1 - The final D-type in the synchroniser must be guaranteed to
  // change cleanly (i.e. never glitch) whilst reset is held
  // inactive

  // ------------------------------------------------------------
  // Reference model for reset synchroniser
  // ------------------------------------------------------------

  reg  rst_sync0, rst_sync1, rst_sync2;

  always @(posedge CLK or negedge RSTIN)
    if (~RSTIN) begin
      rst_sync0 <= 1'b0;
      rst_sync1 <= 1'b0;
      rst_sync2 <= 1'b0;
    end else  begin
      rst_sync0 <= 1'b1;
      rst_sync1 <= rst_sync0;
      rst_sync2 <= rst_sync1;
    end

  assign RSTOUT = rst_sync2 | DFTRSTDISABLE;

endmodule

// ---------------------------------------------------------------
// EOF
// ---------------------------------------------------------------

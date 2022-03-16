//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2009-2012 ARM Limited.
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

module cm0p_rst_sync  (input  wire RSTINn,         // Active LOW reset
                     input  wire RSTREQ,         // Active HIGH synchronous reset request
                     input  wire CLK,            // Clock
                     input  wire DFTSE,          // Scan Enable (for DFT)
                     input  wire DFTRSTDISABLE,  // Reset synchroniser bypass (for DFT)
                     output wire RSTOUTn);       // Synchronised reset output

  // This module is instantiated where a reset synchroniser is required.
  // The purpose of this module is to produce a reset which is asynchronously
  // asserted and synchronously deasserted when an asynchronous reset input
  // is asserted. It will produce a synchronously asserted and deasserted reset
  // in response to a synchronous reset request.

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

  // Assumptions
  // -------------

  // 1 - RSTREQ is a non-glitching input synchronous to CLK

  // ------------------------------------------------------------
  // Reference model for reset synchroniser
  // ------------------------------------------------------------

  wire comb_rst_n = RSTINn & ~RSTREQ;

  reg  rst_sync0_n, rst_sync1_n, rst_sync2_n;

  always @(posedge CLK or negedge comb_rst_n)
    if (~comb_rst_n) begin
      rst_sync0_n <= 1'b0;
      rst_sync1_n <= 1'b0;
      rst_sync2_n <= 1'b0;
    end else begin
      rst_sync0_n <= 1'b1;
      rst_sync1_n <= rst_sync0_n;
      rst_sync2_n <= rst_sync1_n;
    end

  assign RSTOUTn = rst_sync2_n | DFTRSTDISABLE;

endmodule

// ---------------------------------------------------------------
// EOF
// ---------------------------------------------------------------

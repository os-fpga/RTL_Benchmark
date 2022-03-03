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
//   Checked In : $Date: 2011-12-30 17:59:54 +0000 (Fri, 30 Dec 2011) $
//   Revision   : $Revision: 196408 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

module cm0p_acg
  (input  wire CLKIN,
   input  wire ENABLE,
   input  wire DFTSE,
   output wire CLKOUT);

   // -------------------------------------------------------------------------
   // NOTE: THIS MODULE IS NOT INTENDED FOR USE IN SYNTHESIS.
   //       IF ARCHITECTURAL CLOCK GATING IS REQUIRED, THEN IT IS STRONGLY
   //       RECOMMENDED THAT AN EQUIVALENT MODULE DIRECTLY INSTANTIATING YOUR
   //       TARGET LIBRARY'S ICG CELL IS USED IN PLACE OF THIS SIMULATION
   //       MODEL.
   //
   //       If architectural clock gating is not required, configured by the
   //       processor ACG parameter being 0, then this module will not be used.
   // -------------------------------------------------------------------------

   // -------------------------------------------------------------------------
   // Simulation model of clock gate cell
   // -------------------------------------------------------------------------

   reg         clk_en;
   wire        enabled = ENABLE | DFTSE;

   always @(CLKIN or enabled)
     if(~CLKIN)
       clk_en <= enabled;

   assign      CLKOUT = CLKIN & clk_en;


endmodule

// ----------------------------------------------------------------------------
// EOF
// ----------------------------------------------------------------------------

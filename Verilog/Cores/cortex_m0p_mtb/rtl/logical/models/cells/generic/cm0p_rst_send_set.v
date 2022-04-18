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
//   Checked In : $Date: 2012-12-07 12:53:59 +0000 (Fri, 07 Dec 2012) $
//   Revision   : $Revision: 230921 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

module cm0p_rst_send_set
          (input  wire RSTn,       // Reset
           input  wire CLK,        // Clock
           input  wire CLKEN,      // Clock enable
           input  wire RSTREQIN,   // Input reset request
           output wire RSTREQOUT); // Output reset request

  // This module is instantiated where a glitch-free send (launch) register is
  // required i.e. where the output of the register is used to drive an
  // asynchronous reset signal

  // --------------------------------------------------------------------------
  // NOTE: THIS MODULE IS NOT INTENDED FOR USE IN SYNTHESIS
  // IT IS STRONGLY RECOMMENDED THAT AN EQUIVALENT MODULE
  // DIRECTLY INSTANTIATING CELLS FROM YOUR LIBRARY THAT MEET
  // THE REQUIREMENTS DETAILED BELOW IS USED INSTEAD
  // --------------------------------------------------------------------------

  // Requirements
  // -------------

  // 1 - The D-type in the synchroniser must be guaranteed
  // not to glitch while RSTREQIN is LOW.

  //----------------------------------------------------------------------------
  // Reference model for a send D-type
  //----------------------------------------------------------------------------

  reg iRSTREQOUT;

  //Register
  always @ (posedge CLK or negedge RSTn)
    if (~RSTn)
      iRSTREQOUT <= 1'b1;
    else if (CLKEN)
      iRSTREQOUT <= RSTREQIN;

  assign RSTREQOUT = iRSTREQOUT;

endmodule

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

module cm0p_dap_cdc_comb_and_addr
          (input  wire [3:0]  DATAIN,   // Data to be Masked
           input  wire        MASKn,    // Mask Enable
           output wire [3:0]  DATAOUT); // Masked Data Output

  // --------------------------------------------------------------------------
  // This module is instantiated where a 4-bit AND mask is required on a CDC
  // interface. In this case, it is necesssary to ensure that the output of
  // the mask does not glitch when the mask input is low.
  //
  // The implementation of this module must ensure that this requirement is
  // met.
  // --------------------------------------------------------------------------

  // --------------------------------------------------------------------------
  // In this example, the above behaviour is ensured by using an AND2 gate
  // To mask the data signal. The synthesis tool should be configured so that
  // these gates arent resynthesised into alternative gates, though resizing
  // is allowed.
  // --------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Beginning of main code
  //----------------------------------------------------------------------------

  // AND Gate Mask
  AND2_X2_A7TULL HANDINST_Mask[3:0]
    (.A (DATAIN),
     .B (MASKn),
     .Y (DATAOUT));

endmodule

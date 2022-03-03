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
//      SVN Information
//
//      Checked In          : $Date: 2011-12-30 10:52:14 +0000 (Fri, 30 Dec 2011) $
//
//      Revision            : $Revision: 196369 $
//
//      Release Information : Cortex-M0+ AT590-r0p1-00rel0
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//     Signal delay block used in Miscellaneous logic block
//-----------------------------------------------------------------------------
//
// This block is used to facilitate testing in the Cortex-M0+ Integration Kit
// o    Delays input signal i by 24 fclk ticks before returning as output o
//-----------------------------------------------------------------------------
module cm0p_ik_misc_delay
  (input  wire  fclk,
   input  wire  hresetn,
   input  wire  i,
   output wire  o);

  reg [23:0] d;

  always@(posedge fclk or negedge hresetn)
    if(~hresetn)
      d <= {24{1'b0}};
    else
      d <= {d[22:0], i};

  assign    o = d[23];

endmodule

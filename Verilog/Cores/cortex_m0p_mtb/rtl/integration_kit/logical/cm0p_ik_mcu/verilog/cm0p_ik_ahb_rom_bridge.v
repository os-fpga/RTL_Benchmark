//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2012 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//      SVN Information
//
//      Checked In          : $Date: 2012-12-13 13:59:25 +0000 (Thu, 13 Dec 2012) $
//
//      Revision            : $Revision: 231538 $
//
//      Release Information : Cortex-M0+ AT590-r0p1-00rel0
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//      CORTEX-M0+ Integration Kit ROM Bridge
//-----------------------------------------------------------------------------
//
// CORTEX-M0+ AMBA-3 AHB-LITE TO EMBEDDED ROM INTERFACE
// ----------------------------------------------------------------------------
// This block implements an AHB to ROM bridge interface with zero-wait states
//-----------------------------------------------------------------------------

module cm0p_ik_ahb_rom_bridge
  #(parameter AWIDTH = 18)                    //Address Width
   (// AHB INTERFACE --------------------------------------------
    input  wire              HCLK,
    input  wire              HSEL,
    input  wire [31:0]       HADDR,
    input  wire [1:0]        HTRANS,
    input  wire              HREADY,

    output wire [31:0]       HRDATA,
    output wire              HREADYOUT,
    output wire              HRESP,

    // EMBEDDED ROM INTERFACE ----------------------------------
    input  wire [31:0]       ROMRD,           // Read Data Bus
    output wire [AWIDTH-3:0] ROMAD,           // Address Bus
    output wire              ROMCS            // Chip Select
   );

   // ----------------------------------------------------------
   // Internal state
   // ----------------------------------------------------------

    //Wire/Reg declarations

    wire trans_valid = HSEL & HTRANS[1] & HREADY;

    assign ROMCS  = trans_valid;
    assign ROMAD  = HADDR[AWIDTH-1:2];
    assign HRDATA = ROMRD;

    assign HREADYOUT = 1'b1;
    assign HRESP     = 1'b0;

endmodule

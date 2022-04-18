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
//      Checked In          : $Date: 2012-07-27 18:23:33 +0100 (Fri, 27 Jul 2012) $
//
//      Revision            : $Revision: 216753 $
//
//      Release Information : Cortex-M0+ AT590-r0p1-00rel0
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//     IOP interconnect for CORTEX-M0+ Integration Kit
//-----------------------------------------------------------------------------
//
// This block contains IOP match logic and IOP read data multiplexors. It has
// 1 slave port and 3 master ports:
// Slave port    -   IOP from CORTEX-M0+ MTB Integration
// Master 0 port -   GPIO 0
// Master 1 port -   GPIO 1
// Master 2 port -   GPIO 2
//-----------------------------------------------------------------------------

module cm0p_ik_iop_interconnect
 #(parameter BASEADDR_GPIO0 = 32'h40000000,
   parameter BASEADDR_GPIO1 = 32'h40000800,
   parameter BASEADDR_GPIO2 = 32'h40001000)
  (// Inputs
   input wire [31:0]  IOADDRS,
   input wire [31:0]  IOCHECKS,    // I/O Address query
   input wire [31:0]  IORDATAM0,
   input wire [31:0]  IORDATAM1,
   input wire [31:0]  IORDATAM2,
   // Output wires
   output wire        IOSEL0,
   output wire        IOSEL1,
   output wire        IOSEL2,
   output wire        IOMATCHS,
   output wire [31:0] IORDATAS
   );

//-----------------------------------------------------------------------------
// I/O Port Peripheral Target Hit
//-----------------------------------------------------------------------------

   wire   IOMATCH0 = (IOCHECKS[31:11] == BASEADDR_GPIO0[31:11]);
   wire   IOMATCH1 = (IOCHECKS[31:11] == BASEADDR_GPIO1[31:11]);
   wire   IOMATCH2 = (IOCHECKS[31:11] == BASEADDR_GPIO2[31:11]);

//-----------------------------------------------------------------------------
// I/O Port register address control
//-----------------------------------------------------------------------------

   assign IOSEL0   = (IOADDRS[31:11] == BASEADDR_GPIO0[31:11]);
   assign IOSEL1   = (IOADDRS[31:11] == BASEADDR_GPIO1[31:11]);
   assign IOSEL2   = (IOADDRS[31:11] == BASEADDR_GPIO2[31:11]);


   assign IOMATCHS = IOMATCH0 |
                     IOMATCH1 |
                     IOMATCH2;

   assign IORDATAS = ({32{IOSEL0}} & IORDATAM0) |
                     ({32{IOSEL1}} & IORDATAM1) |
                     ({32{IOSEL2}} & IORDATAM2);

endmodule

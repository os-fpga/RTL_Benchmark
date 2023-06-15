//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Generic Two-Port Synchronous RAM                            ////
////                                                              ////
////  This file is part of memory library available from          ////
////  http://www.opencores.org/cvsweb.shtml/generic_memories/     ////
////                                                              ////
////  Description                                                 ////
////  This block is a wrapper with common two-port                ////
////  synchronous memory interface for different                  ////
////  types of ASIC and FPGA RAMs. Beside universal memory        ////
////  interface it also provides behavioral model of generic      ////
////  two-port synchronous RAM.                                   ////
////  It should be used in all OPENCORES designs that want to be  ////
////  portable accross different target technologies and          ////
////  independent of target memory.                               ////
////                                                              ////
////  Supported ASIC RAMs are:                                    ////
////  - Artisan Double-Port Sync RAM                              ////
////  - Avant! Two-Port Sync RAM (*)                              ////
////  - Virage 2-port Sync RAM                                    ////
////                                                              ////
////  Supported FPGA RAMs are:                                    ////
////  - Xilinx Virtex RAMB16                                      ////
////  - Xilinx Virtex RAMB4                                       ////
////  - Altera LPM                                                ////
////                                                              ////
////  To Do:                                                      ////
////   - fix Avant!                                               ////
////   - xilinx rams need external tri-state logic                ////
////   - add additional RAMs (VS etc)                             ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_tpram_32x32.v,v $
// Revision 1.5  2005/10/19 11:37:56  jcastillo
// Added support for RAMB16 Xilinx4/Spartan3 primitives
//
// Revision 1.4  2004/06/08 18:15:48  lampret
// Changed behavior of the simulation generic models
//
// Revision 1.3  2004/04/05 08:29:57  lampret
// Merged branch_qmem into main tree.
//
// Revision 1.2.4.1  2003/07/08 15:36:37  lampret
// Added embedded memory QMEM.
//
// Revision 1.2  2003/04/07 01:19:07  lampret
// Added Altera LPM RAMs. Changed generic RAM output when OE inactive.
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.7  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.6  2001/10/14 13:12:09  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:36  igorm
// no message
//
// Revision 1.1  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.2  2001/07/30 05:38:02  lampret
// Adding empty directories required by HDL coding guidelines
//
//

// synopsys translate_off
`include "timescale.v"
// synopsys translate_on
`include "or1200_defines.v"

module or1200_tpram_32x32(
	// Generic synchronous two-port RAM interface
	clk_a, rst_a, ce_a, we_a, oe_a, addr_a, di_a, do_a,
	clk_b, rst_b, ce_b, we_b, oe_b, addr_b, di_b, do_b
);

//
// Default address and data buses width
//
parameter aw = 5;
parameter dw = 32;

//
// Generic synchronous two-port RAM interface
//
input			clk_a;	// Clock
input			rst_a;	// Reset
input			ce_a;	// Chip enable input
input			we_a;	// Write enable input
input			oe_a;	// Output enable input
input 	[aw-1:0]	addr_a;	// address bus inputs
input	[dw-1:0]	di_a;	// input data bus
output	[dw-1:0]	do_a;	// output data bus
input			clk_b;	// Clock
input			rst_b;	// Reset
input			ce_b;	// Chip enable input
input			we_b;	// Write enable input
input			oe_b;	// Output enable input
input 	[aw-1:0]	addr_b;	// address bus inputs
input	[dw-1:0]	di_b;	// input data bus
output	[dw-1:0]	do_b;	// output data bus

//
// Internal wires and registers
//


//
reg	[dw-1:0]	mem [(1<<aw)-1:0];	// RAM content
reg	[aw-1:0]	addr_a_reg;		// RAM read address register
reg	[aw-1:0]	addr_b_reg;		// RAM read address register

//
// Data output drivers
//
assign do_a = (oe_a) ? mem[addr_a_reg] : {dw{1'b0}};
assign do_b = (oe_b) ? mem[addr_b_reg] : {dw{1'b0}};

//
// RAM write
//
always @(posedge clk_a)
	if (ce_a && we_a)
		mem[addr_a] <= #1 di_a;

//
// RAM write
//
always @(posedge clk_b)
	if (ce_b && we_b)
		mem[addr_b] <= #1 di_b;

//
// RAM read address register
//
always @(posedge clk_a or posedge rst_a)
	if (rst_a)
		addr_a_reg <= #1 {aw{1'b0}};
	else if (ce_a)
		addr_a_reg <= #1 addr_a;

//
// RAM read address register
//
always @(posedge clk_b or posedge rst_b)
	if (rst_b)
		addr_b_reg <= #1 {aw{1'b0}};
	else if (ce_b)
		addr_b_reg <= #1 addr_b;



endmodule

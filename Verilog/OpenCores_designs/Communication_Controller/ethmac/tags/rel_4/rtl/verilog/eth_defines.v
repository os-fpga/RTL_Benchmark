//////////////////////////////////////////////////////////////////////
////                                                              ////
////  eth_defines.v                                               ////
////                                                              ////
////  This file is part of the Ethernet IP core project           ////
////  http://www.opencores.org/projects/ethmac/                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Igor Mohor (igorM@opencores.org)                      ////
////                                                              ////
////  All additional information is avaliable in the Readme.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2001 Authors                                   ////
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
// $Log: not supported by cvs2svn $
// Revision 1.21  2002/08/16 22:09:47  mohor
// Defines for register width added. mii_rst signal in MIIMODER register
// changed.
//
// Revision 1.20  2002/08/14 19:31:48  mohor
// Register TX_BD_NUM is changed so it contains value of the Tx buffer descriptors. No
// need to multiply or devide any more.
//
// Revision 1.19  2002/07/23 15:28:31  mohor
// Ram , used for BDs changed from generic_spram to eth_spram_256x32.
//
// Revision 1.18  2002/05/03 10:15:50  mohor
// Outputs registered. Reset changed for eth_wishbone module.
//
// Revision 1.17  2002/04/24 08:52:19  mohor
// Compiler directives added. Tx and Rx fifo size incremented. A "late collision"
// bug fixed.
//
// Revision 1.16  2002/03/19 12:53:29  mohor
// Some defines that are used in testbench only were moved to tb_eth_defines.v
// file.
//
// Revision 1.15  2002/02/26 16:11:32  mohor
// Number of interrupts changed
//
// Revision 1.14  2002/02/16 14:03:44  mohor
// Registered trimmed. Unused registers removed.
//
// Revision 1.13  2002/02/16 13:06:33  mohor
// EXTERNAL_DMA used instead of WISHBONE_DMA.
//
// Revision 1.12  2002/02/15 10:58:31  mohor
// Changed that were lost with last update put back to the file.
//
// Revision 1.11  2002/02/14 20:19:41  billditt
// Modified for Address Checking,
// addition of eth_addrcheck.v
//
// Revision 1.10  2002/02/12 17:01:19  mohor
// HASH0 and HASH1 registers added. 

// Revision 1.9  2002/02/08 16:21:54  mohor
// Rx status is written back to the BD.
//
// Revision 1.8  2002/02/05 16:44:38  mohor
// Both rx and tx part are finished. Tested with wb_clk_i between 10 and 200
// MHz. Statuses, overrun, control frame transmission and reception still  need
// to be fixed.
//
// Revision 1.7  2002/01/23 10:28:16  mohor
// Link in the header changed.
//
// Revision 1.6  2001/12/05 15:00:16  mohor
// RX_BD_NUM changed to TX_BD_NUM (holds number of TX descriptors
// instead of the number of RX descriptors).
//
// Revision 1.5  2001/12/05 10:21:37  mohor
// ETH_RX_BD_ADR register deleted. ETH_RX_BD_NUM is used instead.
//
// Revision 1.4  2001/11/13 14:23:56  mohor
// Generic memory model is used. Defines are changed for the same reason.
//
// Revision 1.3  2001/10/18 12:07:11  mohor
// Status signals changed, Adress decoding changed, interrupt controller
// added.
//
// Revision 1.2  2001/09/24 15:02:56  mohor
// Defines changed (All precede with ETH_). Small changes because some
// tools generate warnings when two operands are together. Synchronization
// between two clocks domains in eth_wishbonedma.v is changed (due to ASIC
// demands).
//
// Revision 1.1  2001/08/06 14:44:29  mohor
// A define FPGA added to select between Artisan RAM (for ASIC) and Block Ram (For Virtex).
// Include files fixed to contain no path.
// File names and module names changed ta have a eth_ prologue in the name.
// File eth_timescale.v is used to define timescale
// All pin names on the top module are changed to contain _I, _O or _OE at the end.
// Bidirectional signal MDIO is changed to three signals (Mdc_O, Mdi_I, Mdo_O
// and Mdo_OE. The bidirectional signal must be created on the top level. This
// is done due to the ASIC tools.
//
// Revision 1.1  2001/07/30 21:23:42  mohor
// Directory structure changed. Files checked and joind together.
//
//
//
//
//


//`define ETH_FIFO_XILINX               // Use Xilinx distributed ram for tx and rx fifo


// Selection of the used memory for Buffer descriptors
//`define ETH_XILINX_RAMB4            // Core is going to be implemented in Virtex FPGA and contains Virtex 
                                      // specific elements. 



`define ETH_MODER_ADR         8'h0    // 0x0 
`define ETH_INT_SOURCE_ADR    8'h1    // 0x4 
`define ETH_INT_MASK_ADR      8'h2    // 0x8 
`define ETH_IPGT_ADR          8'h3    // 0xC 
`define ETH_IPGR1_ADR         8'h4    // 0x10
`define ETH_IPGR2_ADR         8'h5    // 0x14
`define ETH_PACKETLEN_ADR     8'h6    // 0x18
`define ETH_COLLCONF_ADR      8'h7    // 0x1C
`define ETH_TX_BD_NUM_ADR     8'h8    // 0x20
`define ETH_CTRLMODER_ADR     8'h9    // 0x24
`define ETH_MIIMODER_ADR      8'hA    // 0x28
`define ETH_MIICOMMAND_ADR    8'hB    // 0x2C
`define ETH_MIIADDRESS_ADR    8'hC    // 0x30
`define ETH_MIITX_DATA_ADR    8'hD    // 0x34
`define ETH_MIIRX_DATA_ADR    8'hE    // 0x38
`define ETH_MIISTATUS_ADR     8'hF    // 0x3C
`define ETH_MAC_ADDR0_ADR     8'h10   // 0x40
`define ETH_MAC_ADDR1_ADR     8'h11   // 0x44
`define ETH_HASH0_ADR         8'h12   // 0x48
`define ETH_HASH1_ADR         8'h13   // 0x4C
`define ETH_TX_CTRL_ADR       8'h14   // 0x50
`define ETH_RX_CTRL_ADR       8'h15   // 0x54


`define ETH_MODER_DEF         17'h0A800
`define ETH_INT_MASK_DEF      7'h0
`define ETH_IPGT_DEF          7'h12
`define ETH_IPGR1_DEF         7'h0C
`define ETH_IPGR2_DEF         7'h12
`define ETH_PACKETLEN_DEF     32'h00400600
`define ETH_COLLCONF0_DEF     6'h3f
`define ETH_COLLCONF1_DEF     4'hF
`define ETH_TX_BD_NUM_DEF     8'h40
`define ETH_CTRLMODER_DEF     3'h0
`define ETH_MIIMODER_DEF      10'h064
`define ETH_MIIADDRESS0_DEF   5'h00
`define ETH_MIIADDRESS1_DEF   5'h00
`define ETH_MIITX_DATA_DEF    16'h0000
`define ETH_MIIRX_DATA_DEF    16'h0000
`define ETH_MIISTATUS_DEF     32'h00000000
`define ETH_MAC_ADDR0_DEF     32'h00000000
`define ETH_MAC_ADDR1_DEF     16'h0000
`define ETH_HASH0_DEF         32'h00000000
`define ETH_HASH1_DEF         32'h00000000
`define ETH_RX_CTRL_DEF       16'h0


`define ETH_MODER_WIDTH       17
`define ETH_INT_SOURCE_WIDTH  7
`define ETH_INT_MASK_WIDTH    7
`define ETH_IPGT_WIDTH        7
`define ETH_IPGR1_WIDTH       7
`define ETH_IPGR2_WIDTH       7
`define ETH_PACKETLEN_WIDTH   32
`define ETH_TX_BD_NUM_WIDTH   8
`define ETH_CTRLMODER_WIDTH   3
`define ETH_MIIMODER_WIDTH    10
`define ETH_MIITX_DATA_WIDTH  16
`define ETH_MIIRX_DATA_WIDTH  16
`define ETH_MIISTATUS_WIDTH   3
`define ETH_MAC_ADDR0_WIDTH   32
`define ETH_MAC_ADDR1_WIDTH   16
`define ETH_HASH0_WIDTH       32
`define ETH_HASH1_WIDTH       32
`define ETH_TX_CTRL_WIDTH     17
`define ETH_RX_CTRL_WIDTH     16


// Outputs are registered (uncomment when needed)
`define ETH_REGISTERED_OUTPUTS

`define TX_FIFO_CNT_WIDTH      5
`define TX_FIFO_DEPTH         16
`define TX_FIFO_DATA_WIDTH    32

`define RX_FIFO_CNT_WIDTH      5
`define RX_FIFO_DEPTH         16
`define RX_FIFO_DATA_WIDTH    32

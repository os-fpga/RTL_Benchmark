//////////////////////////////////////////////////////////////////////
////                                                              ////
////  eth_registers.v                                             ////
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
//// Copyright (C) 2001, 2002 Authors                             ////
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
// Revision 1.20  2002/09/04 18:40:25  mohor
// ETH_TXCTRL and ETH_RXCTRL registers added. Interrupts related to
// the control frames connected.
//
// Revision 1.19  2002/08/19 16:01:40  mohor
// Only values smaller or equal to 0x80 can be written to TX_BD_NUM register.
// r_TxEn and r_RxEn depend on the limit values of the TX_BD_NUMOut.
//
// Revision 1.18  2002/08/16 22:28:23  mohor
// Syntax error fixed.
//
// Revision 1.17  2002/08/16 22:23:03  mohor
// Syntax error fixed.
//
// Revision 1.16  2002/08/16 22:14:22  mohor
// Synchronous reset added to all registers. Defines used for width. r_MiiMRst
// changed from bit position 10 to 9.
//
// Revision 1.15  2002/08/14 18:26:37  mohor
// LinkFailRegister is reflecting the status of the PHY's link fail status bit.
//
// Revision 1.14  2002/04/22 14:03:44  mohor
// Interrupts are visible in the ETH_INT_SOURCE regardless if they are enabled
// or not.
//
// Revision 1.13  2002/02/26 16:18:09  mohor
// Reset values are passed to registers through parameters
//
// Revision 1.12  2002/02/17 13:23:42  mohor
// Define missmatch fixed.
//
// Revision 1.11  2002/02/16 14:03:44  mohor
// Registered trimmed. Unused registers removed.
//
// Revision 1.10  2002/02/15 11:08:25  mohor
// File format fixed a bit.
//
// Revision 1.9  2002/02/14 20:19:41  billditt
// Modified for Address Checking,
// addition of eth_addrcheck.v
//
// Revision 1.8  2002/02/12 17:01:19  mohor
// HASH0 and HASH1 registers added. 

// Revision 1.7  2002/01/23 10:28:16  mohor
// Link in the header changed.
//
// Revision 1.6  2001/12/05 15:00:16  mohor
// RX_BD_NUM changed to TX_BD_NUM (holds number of TX descriptors
// instead of the number of RX descriptors).
//
// Revision 1.5  2001/12/05 10:22:19  mohor
// ETH_RX_BD_ADR register deleted. ETH_RX_BD_NUM is used instead.
//
// Revision 1.4  2001/10/19 08:43:51  mohor
// eth_timescale.v changed to timescale.v This is done because of the
// simulation of the few cores in a one joined project.
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
// Revision 1.2  2001/08/02 09:25:31  mohor
// Unconnected signals are now connected.
//
// Revision 1.1  2001/07/30 21:23:42  mohor
// Directory structure changed. Files checked and joind together.
//
//
//
//
//
//

`include "eth_defines.v"
`include "timescale.v"


module eth_registers( DataIn, Address, Rw, Cs, Clk, Reset, DataOut, 
                      r_RecSmall, r_Pad, r_HugEn, r_CrcEn, r_DlyCrcEn, 
                      r_Rst, r_FullD, r_ExDfrEn, r_NoBckof, r_LoopBck, r_IFG, 
                      r_Pro, r_Iam, r_Bro, r_NoPre, r_TxEn, r_RxEn, 
                      TxB_IRQ, TxE_IRQ, RxB_IRQ, RxE_IRQ, Busy_IRQ, 
                      r_IPGT, r_IPGR1, r_IPGR2, r_MinFL, r_MaxFL, r_MaxRet, 
                      r_CollValid, r_TxFlow, r_RxFlow, r_PassAll, 
                      r_MiiMRst, r_MiiNoPre, r_ClkDiv, r_WCtrlData, r_RStat, r_ScanStat, 
                      r_RGAD, r_FIAD, r_CtrlData, NValid_stat, Busy_stat, 
                      LinkFail, r_MAC, WCtrlDataStart, RStatStart,
                      UpdateMIIRX_DATAReg, Prsd, r_TxBDNum, TX_BD_NUM_Wr, int_o,
                      r_HASH0, r_HASH1, r_TxPauseTV, r_TxPauseRq, RstTxPauseRq, TxCtrlEndFrm, 
                      StartTxDone, TxClk, RxClk, ReceivedPauseFrm
                    );

parameter Tp = 1;

input [31:0] DataIn;
input [7:0] Address;

input Rw;
input Cs;
input Clk;
input Reset;

input WCtrlDataStart;
input RStatStart;

input UpdateMIIRX_DATAReg;
input [15:0] Prsd;

output [31:0] DataOut;
reg    [31:0] DataOut;

output r_RecSmall;
output r_Pad;
output r_HugEn;
output r_CrcEn;
output r_DlyCrcEn;
output r_Rst;
output r_FullD;
output r_ExDfrEn;
output r_NoBckof;
output r_LoopBck;
output r_IFG;
output r_Pro;
output r_Iam;
output r_Bro;
output r_NoPre;
output r_TxEn;
output r_RxEn;
output [31:0] r_HASH0;
output [31:0] r_HASH1;

input TxB_IRQ;
input TxE_IRQ;
input RxB_IRQ;
input RxE_IRQ;
input Busy_IRQ;

output [6:0] r_IPGT;

output [6:0] r_IPGR1;

output [6:0] r_IPGR2;

output [15:0] r_MinFL;
output [15:0] r_MaxFL;

output [3:0] r_MaxRet;
output [5:0] r_CollValid;

output r_TxFlow;
output r_RxFlow;
output r_PassAll;

output r_MiiMRst;
output r_MiiNoPre;
output [7:0] r_ClkDiv;

output r_WCtrlData;
output r_RStat;
output r_ScanStat;

output [4:0] r_RGAD;
output [4:0] r_FIAD;

output [15:0]r_CtrlData;


input NValid_stat;
input Busy_stat;
input LinkFail;

output [47:0]r_MAC;
output [7:0] r_TxBDNum;
output       TX_BD_NUM_Wr;
output       int_o;
output [15:0]r_TxPauseTV;
output       r_TxPauseRq;
input        RstTxPauseRq;
input        TxCtrlEndFrm;
input        StartTxDone;
input        TxClk;
input        RxClk;
input        ReceivedPauseFrm;      // sinhroniziraj tale shit da bo delal interrupt. Pazi na PassAll bit

reg          irq_txb;
reg          irq_txe;
reg          irq_rxb;
reg          irq_rxe;
reg          irq_busy;
reg          irq_txc;
reg          irq_rxc;

reg SetTxCIrq_txclk;
reg SetTxCIrq_sync1, SetTxCIrq_sync2, SetTxCIrq_sync3;
reg SetTxCIrq;
reg ResetTxCIrq_sync1, ResetTxCIrq_sync2;

reg SetRxCIrq_rxclk;
reg SetRxCIrq_sync1, SetRxCIrq_sync2, SetRxCIrq_sync3;
reg SetRxCIrq;
reg ResetRxCIrq_sync1, ResetRxCIrq_sync2;

wire Write = Cs &  Rw;
wire Read  = Cs & ~Rw;

wire MODER_Wr       = (Address == `ETH_MODER_ADR       )  & Write;
wire INT_SOURCE_Wr  = (Address == `ETH_INT_SOURCE_ADR  )  & Write;
wire INT_MASK_Wr    = (Address == `ETH_INT_MASK_ADR    )  & Write;
wire IPGT_Wr        = (Address == `ETH_IPGT_ADR        )  & Write;
wire IPGR1_Wr       = (Address == `ETH_IPGR1_ADR       )  & Write;
wire IPGR2_Wr       = (Address == `ETH_IPGR2_ADR       )  & Write;
wire PACKETLEN_Wr   = (Address == `ETH_PACKETLEN_ADR   )  & Write;
wire COLLCONF_Wr    = (Address == `ETH_COLLCONF_ADR    )  & Write;
     
wire CTRLMODER_Wr   = (Address == `ETH_CTRLMODER_ADR   )  & Write;
wire MIIMODER_Wr    = (Address == `ETH_MIIMODER_ADR    )  & Write;
wire MIICOMMAND_Wr  = (Address == `ETH_MIICOMMAND_ADR  )  & Write;
wire MIIADDRESS_Wr  = (Address == `ETH_MIIADDRESS_ADR  )  & Write;
wire MIITX_DATA_Wr  = (Address == `ETH_MIITX_DATA_ADR  )  & Write;
wire MIIRX_DATA_Wr  = UpdateMIIRX_DATAReg;     
wire MAC_ADDR0_Wr   = (Address == `ETH_MAC_ADDR0_ADR   )  & Write;
wire MAC_ADDR1_Wr   = (Address == `ETH_MAC_ADDR1_ADR   )  & Write;
wire HASH0_Wr       = (Address == `ETH_HASH0_ADR       )  & Write;
wire HASH1_Wr       = (Address == `ETH_HASH1_ADR       )  & Write;
wire TXCTRL_Wr      = (Address == `ETH_TX_CTRL_ADR     )  & Write;
wire RXCTRL_Wr      = (Address == `ETH_RX_CTRL_ADR     )  & Write;
assign TX_BD_NUM_Wr = (Address == `ETH_TX_BD_NUM_ADR   )  & Write;



wire [31:0] MODEROut;
wire [31:0] INT_SOURCEOut;
wire [31:0] INT_MASKOut;
wire [31:0] IPGTOut;
wire [31:0] IPGR1Out;
wire [31:0] IPGR2Out;
wire [31:0] PACKETLENOut;
wire [31:0] COLLCONFOut;
wire [31:0] CTRLMODEROut;
wire [31:0] MIIMODEROut;
wire [31:0] MIICOMMANDOut;
wire [31:0] MIIADDRESSOut;
wire [31:0] MIITX_DATAOut;
wire [31:0] MIIRX_DATAOut;
wire [31:0] MIISTATUSOut;
wire [31:0] MAC_ADDR0Out;
wire [31:0] MAC_ADDR1Out;
wire [31:0] TX_BD_NUMOut;
wire [31:0] HASH0Out;
wire [31:0] HASH1Out;
wire [31:0] TXCTRLOut;
wire [31:0] RXCTRLOut;


// MODER Register
eth_register #(`ETH_MODER_WIDTH, `ETH_MODER_DEF)        MODER
  (
   .DataIn    (DataIn[`ETH_MODER_WIDTH-1:0]),
   .DataOut   (MODEROut[`ETH_MODER_WIDTH-1:0]),
   .Write     (MODER_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign MODEROut[31:`ETH_MODER_WIDTH] = 0;

// INT_MASK Register
eth_register #(`ETH_INT_MASK_WIDTH, `ETH_INT_MASK_DEF)  INT_MASK
  (
   .DataIn    (DataIn[`ETH_INT_MASK_WIDTH-1:0]),  
   .DataOut   (INT_MASKOut[`ETH_INT_MASK_WIDTH-1:0]),
   .Write     (INT_MASK_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign INT_MASKOut[31:`ETH_INT_MASK_WIDTH] = 0;

// IPGT Register
eth_register #(`ETH_IPGT_WIDTH, `ETH_IPGT_DEF)          IPGT
  (
   .DataIn    (DataIn[`ETH_IPGT_WIDTH-1:0]),
   .DataOut   (IPGTOut[`ETH_IPGT_WIDTH-1:0]),
   .Write     (IPGT_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign IPGTOut[31:`ETH_IPGT_WIDTH] = 0;

// IPGR1 Register
eth_register #(`ETH_IPGR1_WIDTH, `ETH_IPGR1_DEF)        IPGR1
  (
   .DataIn    (DataIn[`ETH_IPGR1_WIDTH-1:0]),
   .DataOut   (IPGR1Out[`ETH_IPGR1_WIDTH-1:0]),
   .Write     (IPGR1_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign IPGR1Out[31:`ETH_IPGR1_WIDTH] = 0;

// IPGR2 Register
eth_register #(`ETH_IPGR2_WIDTH, `ETH_IPGR2_DEF)        IPGR2
  (
   .DataIn    (DataIn[`ETH_IPGR2_WIDTH-1:0]),
   .DataOut   (IPGR2Out[`ETH_IPGR2_WIDTH-1:0]),
   .Write     (IPGR2_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign IPGR2Out[31:`ETH_IPGR2_WIDTH] = 0;

// PACKETLEN Register
eth_register #(`ETH_PACKETLEN_WIDTH, `ETH_PACKETLEN_DEF) PACKETLEN
  (
   .DataIn    (DataIn),
   .DataOut   (PACKETLENOut),
   .Write     (PACKETLEN_Wr),
   .Clk       (Clk), 
   .Reset     (Reset),
   .SyncReset (1'b0)
  );

// COLLCONF Register
eth_register #(6, `ETH_COLLCONF0_DEF)                   COLLCONF0
  (
   .DataIn    (DataIn[5:0]),
   .DataOut   (COLLCONFOut[5:0]),
   .Write     (COLLCONF_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign COLLCONFOut[15:6] = 0;

eth_register #(4, `ETH_COLLCONF1_DEF)                   COLLCONF1
  (
   .DataIn    (DataIn[19:16]),
   .DataOut   (COLLCONFOut[19:16]),
   .Write     (COLLCONF_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign COLLCONFOut[31:20] = 0;

// TX_BD_NUM Register
eth_register #(`ETH_TX_BD_NUM_WIDTH, `ETH_TX_BD_NUM_DEF) TX_BD_NUM
  (
   .DataIn    (DataIn[`ETH_TX_BD_NUM_WIDTH-1:0]),
   .DataOut   (TX_BD_NUMOut[`ETH_TX_BD_NUM_WIDTH-1:0]),
   .Write     (TX_BD_NUM_Wr & (DataIn<='h80)),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign TX_BD_NUMOut[31:`ETH_TX_BD_NUM_WIDTH] = 0;

// CTRLMODER Register
eth_register #(`ETH_CTRLMODER_WIDTH, `ETH_CTRLMODER_DEF)  CTRLMODER2
  (
   .DataIn    (DataIn[`ETH_CTRLMODER_WIDTH-1:0]),
   .DataOut   (CTRLMODEROut[`ETH_CTRLMODER_WIDTH-1:0]),
   .Write     (CTRLMODER_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign CTRLMODEROut[31:`ETH_CTRLMODER_WIDTH] = 0;

// MIIMODER Register
eth_register #(`ETH_MIIMODER_WIDTH, `ETH_MIIMODER_DEF)    MIIMODER
  (
   .DataIn    (DataIn[`ETH_MIIMODER_WIDTH-1:0]),
   .DataOut   (MIIMODEROut[`ETH_MIIMODER_WIDTH-1:0]),
   .Write     (MIIMODER_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign MIIMODEROut[31:`ETH_MIIMODER_WIDTH] = 0;

// MIICOMMAND Register
eth_register #(1, 0)                                      MIICOMMAND0
  (
   .DataIn    (DataIn[0]),
   .DataOut   (MIICOMMANDOut[0]),
   .Write     (MIICOMMAND_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );

eth_register #(1, 0)                                      MIICOMMAND1
  (
   .DataIn    (DataIn[1]),
   .DataOut   (MIICOMMANDOut[1]),
   .Write     (MIICOMMAND_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (RStatStart)
  );

eth_register #(1, 0)                                      MIICOMMAND2
  (
   .DataIn    (DataIn[2]),
   .DataOut   (MIICOMMANDOut[2]),
   .Write     (MIICOMMAND_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (WCtrlDataStart)
  );
assign MIICOMMANDOut[31:3] = 29'h0;

// MIIADDRESSRegister
eth_register #(5, `ETH_MIIADDRESS0_DEF)                   MIIADDRESS0
  (
   .DataIn    (DataIn[4:0]),
   .DataOut   (MIIADDRESSOut[4:0]),
   .Write     (MIIADDRESS_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign MIIADDRESSOut[7:5] = 0;

eth_register #(5, `ETH_MIIADDRESS1_DEF)                   MIIADDRESS1
  (
   .DataIn    (DataIn[12:8]),
   .DataOut   (MIIADDRESSOut[12:8]),
   .Write     (MIIADDRESS_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign MIIADDRESSOut[31:13] = 0;

// MIITX_DATA Register
eth_register #(`ETH_MIITX_DATA_WIDTH, `ETH_MIITX_DATA_DEF) MIITX_DATA
  (
   .DataIn    (DataIn[`ETH_MIITX_DATA_WIDTH-1:0]),
   .DataOut   (MIITX_DATAOut[`ETH_MIITX_DATA_WIDTH-1:0]), 
   .Write     (MIITX_DATA_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign MIITX_DATAOut[31:`ETH_MIITX_DATA_WIDTH] = 0;

// MIIRX_DATA Register
eth_register #(`ETH_MIIRX_DATA_WIDTH, `ETH_MIIRX_DATA_DEF) MIIRX_DATA
  (
   .DataIn    (Prsd[`ETH_MIIRX_DATA_WIDTH-1:0]),
   .DataOut   (MIIRX_DATAOut[`ETH_MIIRX_DATA_WIDTH-1:0]),
   .Write     (MIIRX_DATA_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign MIIRX_DATAOut[31:`ETH_MIIRX_DATA_WIDTH] = 0;

// MAC_ADDR0 Register
eth_register #(`ETH_MAC_ADDR0_WIDTH, `ETH_MAC_ADDR0_DEF)  MAC_ADDR0
  (
   .DataIn    (DataIn),
   .DataOut   (MAC_ADDR0Out),
   .Write     (MAC_ADDR0_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );

// MAC_ADDR1 Register
eth_register #(`ETH_MAC_ADDR1_WIDTH, `ETH_MAC_ADDR1_DEF)  MAC_ADDR1
  (
   .DataIn    (DataIn[`ETH_MAC_ADDR1_WIDTH-1:0]),
   .DataOut   (MAC_ADDR1Out[`ETH_MAC_ADDR1_WIDTH-1:0]),
   .Write     (MAC_ADDR1_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign MAC_ADDR1Out[31:`ETH_MAC_ADDR1_WIDTH] = 0;

// RXHASH0 Register
eth_register #(`ETH_HASH0_WIDTH, `ETH_HASH0_DEF)          RXHASH0
  (
   .DataIn    (DataIn),
   .DataOut   (HASH0Out),
   .Write     (HASH0_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );

// RXHASH1 Register
eth_register #(`ETH_HASH1_WIDTH, `ETH_HASH1_DEF)          RXHASH1
  (
   .DataIn    (DataIn),
   .DataOut   (HASH1Out),
   .Write     (HASH1_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );


// TXCTRL Register
eth_register #((`ETH_TX_CTRL_WIDTH-1), {(`ETH_TX_CTRL_WIDTH-1){1'b0}})      TXCTRL0
  (
   .DataIn    (DataIn[`ETH_TX_CTRL_WIDTH-2:0]),
   .DataOut   (TXCTRLOut[`ETH_TX_CTRL_WIDTH-2:0]),
   .Write     (TXCTRL_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );

eth_register #(1, 1'b0)                                   TXCTRL1     // Request bit is synchronously reset
  (
   .DataIn    (DataIn[16]),
   .DataOut   (TXCTRLOut[16]),
   .Write     (TXCTRL_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (RstTxPauseRq)
  );
assign TXCTRLOut[31:`ETH_TX_CTRL_WIDTH] = 0;


// RXCTRL Register
eth_register #(`ETH_RX_CTRL_WIDTH, `ETH_RX_CTRL_DEF)      RXCTRL
  (
   .DataIn    (DataIn[`ETH_RX_CTRL_WIDTH-1:0]),
   .DataOut   (RXCTRLOut[`ETH_RX_CTRL_WIDTH-1:0]),
   .Write     (RXCTRL_Wr),
   .Clk       (Clk),
   .Reset     (Reset),
   .SyncReset (1'b0)
  );
assign RXCTRLOut[31:`ETH_RX_CTRL_WIDTH] = 0;


// Reading data from registers
always @ (Address       or Read           or MODEROut       or INT_SOURCEOut  or
          INT_MASKOut   or IPGTOut        or IPGR1Out       or IPGR2Out       or
          PACKETLENOut  or COLLCONFOut    or CTRLMODEROut   or MIIMODEROut    or
          MIICOMMANDOut or MIIADDRESSOut  or MIITX_DATAOut  or MIIRX_DATAOut  or 
          MIISTATUSOut  or MAC_ADDR0Out   or MAC_ADDR1Out   or TX_BD_NUMOut   or
          HASH0Out      or HASH1Out       or TXCTRLOut      or RXCTRLOut
         )
begin
  if(Read)  // read
    begin
      case(Address)
        `ETH_MODER_ADR        :  DataOut<=MODEROut;
        `ETH_INT_SOURCE_ADR   :  DataOut<=INT_SOURCEOut;
        `ETH_INT_MASK_ADR     :  DataOut<=INT_MASKOut;
        `ETH_IPGT_ADR         :  DataOut<=IPGTOut;
        `ETH_IPGR1_ADR        :  DataOut<=IPGR1Out;
        `ETH_IPGR2_ADR        :  DataOut<=IPGR2Out;
        `ETH_PACKETLEN_ADR    :  DataOut<=PACKETLENOut;
        `ETH_COLLCONF_ADR     :  DataOut<=COLLCONFOut;
        `ETH_CTRLMODER_ADR    :  DataOut<=CTRLMODEROut;
        `ETH_MIIMODER_ADR     :  DataOut<=MIIMODEROut;
        `ETH_MIICOMMAND_ADR   :  DataOut<=MIICOMMANDOut;
        `ETH_MIIADDRESS_ADR   :  DataOut<=MIIADDRESSOut;
        `ETH_MIITX_DATA_ADR   :  DataOut<=MIITX_DATAOut;
        `ETH_MIIRX_DATA_ADR   :  DataOut<=MIIRX_DATAOut;
        `ETH_MIISTATUS_ADR    :  DataOut<=MIISTATUSOut;
        `ETH_MAC_ADDR0_ADR    :  DataOut<=MAC_ADDR0Out;
        `ETH_MAC_ADDR1_ADR    :  DataOut<=MAC_ADDR1Out;
        `ETH_TX_BD_NUM_ADR    :  DataOut<=TX_BD_NUMOut;
        `ETH_HASH0_ADR        :  DataOut<=HASH0Out;
        `ETH_HASH1_ADR        :  DataOut<=HASH1Out;
        `ETH_TX_CTRL_ADR      :  DataOut<=TXCTRLOut;
        `ETH_RX_CTRL_ADR      :  DataOut<=RXCTRLOut;

        default:             DataOut<=32'h0;
      endcase
    end
  else
    DataOut<=32'h0;
end


assign r_RecSmall         = MODEROut[16];
assign r_Pad              = MODEROut[15];
assign r_HugEn            = MODEROut[14];
assign r_CrcEn            = MODEROut[13];
assign r_DlyCrcEn         = MODEROut[12];
assign r_Rst              = MODEROut[11];
assign r_FullD            = MODEROut[10];
assign r_ExDfrEn          = MODEROut[9];
assign r_NoBckof          = MODEROut[8];
assign r_LoopBck          = MODEROut[7];
assign r_IFG              = MODEROut[6];
assign r_Pro              = MODEROut[5];
assign r_Iam              = MODEROut[4];
assign r_Bro              = MODEROut[3];
assign r_NoPre            = MODEROut[2];
assign r_TxEn             = MODEROut[1] & (TX_BD_NUMOut>0);     // Transmission is enabled when there is at least one TxBD.
assign r_RxEn             = MODEROut[0] & (TX_BD_NUMOut<'h80);  // Reception is enabled when there is  at least one RxBD.

assign r_IPGT[6:0]        = IPGTOut[6:0];

assign r_IPGR1[6:0]       = IPGR1Out[6:0];

assign r_IPGR2[6:0]       = IPGR2Out[6:0];

assign r_MinFL[15:0]      = PACKETLENOut[31:16];
assign r_MaxFL[15:0]      = PACKETLENOut[15:0];

assign r_MaxRet[3:0]      = COLLCONFOut[19:16];
assign r_CollValid[5:0]   = COLLCONFOut[5:0];

assign r_TxFlow           = CTRLMODEROut[2];
assign r_RxFlow           = CTRLMODEROut[1];
assign r_PassAll          = CTRLMODEROut[0];

assign r_MiiMRst          = MIIMODEROut[9];
assign r_MiiNoPre         = MIIMODEROut[8];
assign r_ClkDiv[7:0]      = MIIMODEROut[7:0];

assign r_WCtrlData        = MIICOMMANDOut[2];
assign r_RStat            = MIICOMMANDOut[1];
assign r_ScanStat         = MIICOMMANDOut[0];

assign r_RGAD[4:0]        = MIIADDRESSOut[12:8];
assign r_FIAD[4:0]        = MIIADDRESSOut[4:0];

assign r_CtrlData[15:0]   = MIITX_DATAOut[15:0];

assign MIISTATUSOut[31:`ETH_MIISTATUS_WIDTH] = 0; 
assign MIISTATUSOut[2]    = NValid_stat         ; 
assign MIISTATUSOut[1]    = Busy_stat           ; 
assign MIISTATUSOut[0]    = LinkFail            ; 

assign r_MAC[31:0]        = MAC_ADDR0Out[31:0];
assign r_MAC[47:32]       = MAC_ADDR1Out[15:0];
assign r_HASH1[31:0]      = HASH1Out;
assign r_HASH0[31:0]      = HASH0Out;

assign r_TxBDNum[7:0]     = TX_BD_NUMOut[7:0];

assign r_TxPauseTV[15:0]  = TXCTRLOut[15:0];
assign r_TxPauseRq        = TXCTRLOut[16];


// Synchronizing TxC Interrupt
always @ (posedge TxClk or posedge Reset)
begin
  if(Reset)
    SetTxCIrq_txclk <=#Tp 1'b0;
  else
  if(TxCtrlEndFrm & StartTxDone & r_TxFlow)
    SetTxCIrq_txclk <=#Tp 1'b1;
  else
  if(ResetTxCIrq_sync2)
    SetTxCIrq_txclk <=#Tp 1'b0;
end


always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    SetTxCIrq_sync1 <=#Tp 1'b0;
  else
    SetTxCIrq_sync1 <=#Tp SetTxCIrq_txclk;
end

always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    SetTxCIrq_sync2 <=#Tp 1'b0;
  else
    SetTxCIrq_sync2 <=#Tp SetTxCIrq_sync1;
end

always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    SetTxCIrq_sync3 <=#Tp 1'b0;
  else
    SetTxCIrq_sync3 <=#Tp SetTxCIrq_sync2;
end

always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    SetTxCIrq <=#Tp 1'b0;
  else
    SetTxCIrq <=#Tp SetTxCIrq_sync2 & ~SetTxCIrq_sync3;
end

always @ (posedge TxClk or posedge Reset)
begin
  if(Reset)
    ResetTxCIrq_sync1 <=#Tp 1'b0;
  else
    ResetTxCIrq_sync1 <=#Tp SetTxCIrq_sync2;
end

always @ (posedge TxClk or posedge Reset)
begin
  if(Reset)
    ResetTxCIrq_sync2 <=#Tp 1'b0;
  else
    ResetTxCIrq_sync2 <=#Tp SetTxCIrq_sync1;
end


// Synchronizing RxC Interrupt
always @ (posedge RxClk or posedge Reset)
begin
  if(Reset)
    SetRxCIrq_rxclk <=#Tp 1'b0;
  else
  if(ReceivedPauseFrm & r_RxFlow)
    SetRxCIrq_rxclk <=#Tp 1'b1;
  else
  if(ResetRxCIrq_sync2)
    SetRxCIrq_rxclk <=#Tp 1'b0;
end


always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    SetRxCIrq_sync1 <=#Tp 1'b0;
  else
    SetRxCIrq_sync1 <=#Tp SetRxCIrq_rxclk;
end

always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    SetRxCIrq_sync2 <=#Tp 1'b0;
  else
    SetRxCIrq_sync2 <=#Tp SetRxCIrq_sync1;
end

always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    SetRxCIrq_sync3 <=#Tp 1'b0;
  else
    SetRxCIrq_sync3 <=#Tp SetRxCIrq_sync2;
end

always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    SetRxCIrq <=#Tp 1'b0;
  else
    SetRxCIrq <=#Tp SetRxCIrq_sync2 & ~SetRxCIrq_sync3;
end

always @ (posedge RxClk or posedge Reset)
begin
  if(Reset)
    ResetRxCIrq_sync1 <=#Tp 1'b0;
  else
    ResetRxCIrq_sync1 <=#Tp SetRxCIrq_sync2;
end

always @ (posedge TxClk or posedge Reset)
begin
  if(Reset)
    ResetRxCIrq_sync2 <=#Tp 1'b0;
  else
    ResetRxCIrq_sync2 <=#Tp SetRxCIrq_sync1;
end







// Interrupt generation
always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    irq_txb <= 1'b0;
  else
  if(TxB_IRQ)
    irq_txb <= #Tp 1'b1;
  else
  if(INT_SOURCE_Wr & DataIn[0])
    irq_txb <= #Tp 1'b0;
end

always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    irq_txe <= 1'b0;
  else
  if(TxE_IRQ)
    irq_txe <= #Tp 1'b1;
  else
  if(INT_SOURCE_Wr & DataIn[1])
    irq_txe <= #Tp 1'b0;
end

always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    irq_rxb <= 1'b0;
  else
  if(RxB_IRQ)
    irq_rxb <= #Tp 1'b1;
  else
  if(INT_SOURCE_Wr & DataIn[2])
    irq_rxb <= #Tp 1'b0;
end

always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    irq_rxe <= 1'b0;
  else
  if(RxE_IRQ)
    irq_rxe <= #Tp 1'b1;
  else
  if(INT_SOURCE_Wr & DataIn[3])
    irq_rxe <= #Tp 1'b0;
end

always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    irq_busy <= 1'b0;
  else
  if(Busy_IRQ)
    irq_busy <= #Tp 1'b1;
  else
  if(INT_SOURCE_Wr & DataIn[4])
    irq_busy <= #Tp 1'b0;
end

always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    irq_txc <= 1'b0;
  else
  if(SetTxCIrq)
    irq_txc <= #Tp 1'b1;
  else
  if(INT_SOURCE_Wr & DataIn[5])
    irq_txc <= #Tp 1'b0;
end

always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    irq_rxc <= 1'b0;
  else
  if(SetRxCIrq)
    irq_rxc <= #Tp 1'b1;
  else
  if(INT_SOURCE_Wr & DataIn[6])
    irq_rxc <= #Tp 1'b0;
end

// Generating interrupt signal
assign int_o = irq_txb  & INT_MASKOut[0] | 
               irq_txe  & INT_MASKOut[1] | 
               irq_rxb  & INT_MASKOut[2] | 
               irq_rxe  & INT_MASKOut[3] | 
               irq_busy & INT_MASKOut[4] | 
               irq_txc  & INT_MASKOut[5] | 
               irq_rxc  & INT_MASKOut[6] ;

// For reading interrupt status
assign INT_SOURCEOut = {{(32-`ETH_INT_SOURCE_WIDTH){1'b0}}, irq_rxc, irq_txc, irq_busy, irq_rxe, irq_rxb, irq_txe, irq_txb};



endmodule

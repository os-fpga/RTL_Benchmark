//////////////////////////////////////////////////////////////////////
////                                                              ////
////  eth_wishbone.v                                              ////
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
// Revision 1.29  2002/07/20 00:41:32  mohor
// ShiftEnded synchronization changed.
//
// Revision 1.28  2002/07/18 16:11:46  mohor
// RxBDAddress takes `ETH_TX_BD_NUM_DEF value after reset.
//
// Revision 1.27  2002/07/11 02:53:20  mohor
// RxPointer bug fixed.
//
// Revision 1.26  2002/07/10 13:12:38  mohor
// Previous bug wasn't succesfully removed. Now fixed.
//
// Revision 1.25  2002/07/09 23:53:24  mohor
// Master state machine had a bug when switching from master write to
// master read.
//
// Revision 1.24  2002/07/09 20:44:41  mohor
// m_wb_cyc_o signal released after every single transfer.
//
// Revision 1.23  2002/05/03 10:15:50  mohor
// Outputs registered. Reset changed for eth_wishbone module.
//
// Revision 1.22  2002/04/24 08:52:19  mohor
// Compiler directives added. Tx and Rx fifo size incremented. A "late collision"
// bug fixed.
//
// Revision 1.21  2002/03/29 16:18:11  lampret
// Small typo fixed.
//
// Revision 1.20  2002/03/25 16:19:12  mohor
// Any address can be used for Tx and Rx BD pointers. Address does not need
// to be aligned.
//
// Revision 1.19  2002/03/19 12:51:50  mohor
// Comments in Slovene language removed.
//
// Revision 1.18  2002/03/19 12:46:52  mohor
// casex changed with case, fifo reset changed.
//
// Revision 1.17  2002/03/09 16:08:45  mohor
// rx_fifo was not always cleared ok. Fixed.
//
// Revision 1.16  2002/03/09 13:51:20  mohor
// Status was not latched correctly sometimes. Fixed.
//
// Revision 1.15  2002/03/08 06:56:46  mohor
// Big Endian problem when sending frames fixed.
//
// Revision 1.14  2002/03/02 19:12:40  mohor
// Byte ordering changed (Big Endian used). casex changed with case because
// Xilinx Foundation had problems. Tested in HW. It WORKS.
//
// Revision 1.13  2002/02/26 16:59:55  mohor
// Small fixes for external/internal DMA missmatches.
//
// Revision 1.12  2002/02/26 16:22:07  mohor
// Interrupts changed
//
// Revision 1.11  2002/02/15 17:07:39  mohor
// Status was not written correctly when frames were discarted because of
// address mismatch.
//
// Revision 1.10  2002/02/15 12:17:39  mohor
// RxStartFrm cleared when abort or retry comes.
//
// Revision 1.9  2002/02/15 11:59:10  mohor
// Changes that were lost when updating from 1.5 to 1.8 fixed.
//
// Revision 1.8  2002/02/14 20:54:33  billditt
// Addition  of new module eth_addrcheck.v
//
// Revision 1.7  2002/02/12 17:03:47  mohor
// RxOverRun added to statuses.
//
// Revision 1.6  2002/02/11 09:18:22  mohor
// Tx status is written back to the BD.
//
// Revision 1.5  2002/02/08 16:21:54  mohor
// Rx status is written back to the BD.
//
// Revision 1.4  2002/02/06 14:10:21  mohor
// non-DMA host interface added. Select the right configutation in eth_defines.
//
// Revision 1.3  2002/02/05 16:44:39  mohor
// Both rx and tx part are finished. Tested with wb_clk_i between 10 and 200
// MHz. Statuses, overrun, control frame transmission and reception still  need
// to be fixed.
//
// Revision 1.2  2002/02/01 12:46:51  mohor
// Tx part finished. TxStatus needs to be fixed. Pause request needs to be
// added.
//
// Revision 1.1  2002/01/23 10:47:59  mohor
// Initial version. Equals to eth_wishbonedma.v at this moment.
//
//
//
//

// Build pause frame
// Check GotData and evaluate data (abort or something like that comes before StartFrm)
// m_wb_err_i should start status underrun or uverrun
// r_RecSmall not used

`include "eth_defines.v"
`include "timescale.v"


module eth_wishbone
   (

    // WISHBONE common
    WB_CLK_I, WB_DAT_I, WB_DAT_O, 

    // WISHBONE slave
 		WB_ADR_I, WB_WE_I, WB_ACK_O, 
    BDCs, 

    Reset, 

    // WISHBONE master
    m_wb_adr_o, m_wb_sel_o, m_wb_we_o, 
    m_wb_dat_o, m_wb_dat_i, m_wb_cyc_o, 
    m_wb_stb_o, m_wb_ack_i, m_wb_err_i, 

    //TX
    MTxClk, TxStartFrm, TxEndFrm, TxUsedData, TxData, 
    TxRetry, TxAbort, TxUnderRun, TxDone, TPauseRq, TxPauseTV, PerPacketCrcEn, 
    PerPacketPad, 

    //RX
    MRxClk, RxData, RxValid, RxStartFrm, RxEndFrm, RxAbort, 
    
    // Register
    r_TxEn, r_RxEn, r_TxBDNum, TX_BD_NUM_Wr, r_RecSmall, 

    WillSendControlFrame, TxCtrlEndFrm, // WillSendControlFrame out ?
    
    // Interrupts
    TxB_IRQ, TxE_IRQ, RxB_IRQ, RxE_IRQ, Busy_IRQ, TxC_IRQ, RxC_IRQ, 
    
    // Rx Status
    InvalidSymbol, LatchedCrcError, RxLateCollision, ShortFrame, DribbleNibble,
    ReceivedPacketTooBig, RxLength, LoadRxStatus, ReceivedPacketGood, 
    
    // Tx Status
    RetryCntLatched, RetryLimit, LateCollLatched, DeferLatched, CarrierSenseLost
    
		);


parameter Tp = 1;

// WISHBONE common
input           WB_CLK_I;       // WISHBONE clock
input  [31:0]   WB_DAT_I;       // WISHBONE data input
output [31:0]   WB_DAT_O;       // WISHBONE data output

// WISHBONE slave
input   [9:2]   WB_ADR_I;       // WISHBONE address input
input           WB_WE_I;        // WISHBONE write enable input
input           BDCs;           // Buffer descriptors are selected
output          WB_ACK_O;       // WISHBONE acknowledge output

// WISHBONE master
output  [31:0]  m_wb_adr_o;     // 
output   [3:0]  m_wb_sel_o;     // 
output          m_wb_we_o;      // 
output  [31:0]  m_wb_dat_o;     // 
output          m_wb_cyc_o;     // 
output          m_wb_stb_o;     // 
input   [31:0]  m_wb_dat_i;     // 
input           m_wb_ack_i;     // 
input           m_wb_err_i;     // 

input           Reset;       // Reset signal

// Rx Status signals
input           InvalidSymbol;    // Invalid symbol was received during reception in 100 Mbps mode
input           LatchedCrcError;  // CRC error
input           RxLateCollision;  // Late collision occured while receiving frame
input           ShortFrame;       // Frame shorter then the minimum size (r_MinFL) was received while small packets are enabled (r_RecSmall)
input           DribbleNibble;    // Extra nibble received
input           ReceivedPacketTooBig;// Received packet is bigger than r_MaxFL
input    [15:0] RxLength;         // Length of the incoming frame
input           LoadRxStatus;     // Rx status was loaded
input           ReceivedPacketGood;// Received packet's length and CRC are good

// Tx Status signals
input     [3:0] RetryCntLatched;  // Latched Retry Counter
input           RetryLimit;       // Retry limit reached (Retry Max value + 1 attempts were made)
input           LateCollLatched;  // Late collision occured
input           DeferLatched;     // Defer indication (Frame was defered before sucessfully sent)
input           CarrierSenseLost; // Carrier Sense was lost during the frame transmission

// Tx
input           MTxClk;         // Transmit clock (from PHY)
input           TxUsedData;     // Transmit packet used data
input           TxRetry;        // Transmit packet retry
input           TxAbort;        // Transmit packet abort
input           TxDone;         // Transmission ended
output          TxStartFrm;     // Transmit packet start frame
output          TxEndFrm;       // Transmit packet end frame
output  [7:0]   TxData;         // Transmit packet data byte
output          TxUnderRun;     // Transmit packet under-run
output          PerPacketCrcEn; // Per packet crc enable
output          PerPacketPad;   // Per packet pading
output          TPauseRq;       // Tx PAUSE control frame
output [15:0]   TxPauseTV;      // PAUSE timer value
input           WillSendControlFrame;
input           TxCtrlEndFrm;

// Rx
input           MRxClk;         // Receive clock (from PHY)
input   [7:0]   RxData;         // Received data byte (from PHY)
input           RxValid;        // 
input           RxStartFrm;     // 
input           RxEndFrm;       // 
input           RxAbort;        // This signal is set when address doesn't match.

//Register
input           r_TxEn;         // Transmit enable
input           r_RxEn;         // Receive enable
input   [7:0]   r_TxBDNum;      // Receive buffer descriptor number
input           TX_BD_NUM_Wr;   // RxBDNumber written
input           r_RecSmall;     // Receive small frames igor !!! tega uporabi

// Interrupts
output TxB_IRQ;
output TxE_IRQ;
output RxB_IRQ;
output RxE_IRQ;
output Busy_IRQ;
output TxC_IRQ;
output RxC_IRQ;


reg TxB_IRQ;
reg TxE_IRQ;
reg RxB_IRQ;
reg RxE_IRQ;


reg             TxStartFrm;
reg             TxEndFrm;
reg     [7:0]   TxData;

reg             TxUnderRun;
reg             TxUnderRun_wb;

reg             TxBDRead;
wire            TxStatusWrite;

reg     [1:0]   TxValidBytesLatched;

reg    [15:0]   TxLength;
reg    [15:0]   LatchedTxLength;
reg   [14:11]   TxStatus;

reg   [14:13]   RxStatus;

reg             TxStartFrm_wb;
reg             TxRetry_wb;
reg             TxAbort_wb;
reg             TxDone_wb;

reg             TxDone_wb_q;
reg             TxAbort_wb_q;
reg             TxRetry_wb_q;
reg             TxDone_wb_q2;
reg             TxAbort_wb_q2;
reg             TxRetry_wb_q2;
reg             RxBDReady;
reg             TxBDReady;

reg             RxBDRead;
wire            RxStatusWrite;

reg    [31:0]   TxDataLatched;
reg     [1:0]   TxByteCnt;
reg             LastWord;
reg             ReadTxDataFromFifo_tck;

reg             BlockingTxStatusWrite;
reg             BlockingTxBDRead;

reg             Flop;

reg     [7:0]   TxBDAddress;
reg     [7:0]   RxBDAddress;

reg             TxRetrySync1;
reg             TxAbortSync1;
reg             TxDoneSync1;

reg             TxAbort_q;
reg             TxRetry_q;
reg             TxUsedData_q;

reg    [31:0]   RxDataLatched2;

// reg    [23:0]   RxDataLatched1;
reg    [31:8]   RxDataLatched1;     // Big Endian Byte Ordering

reg     [1:0]   RxValidBytes;
reg     [1:0]   RxByteCnt;
reg             LastByteIn;
reg             ShiftWillEnd;

reg             WriteRxDataToFifo;
reg    [15:0]   LatchedRxLength;
reg             RxAbortLatched;

reg             ShiftEnded;
reg             RxOverrun;

reg             BDWrite;                    // BD Write Enable for access from WISHBONE side
reg             BDRead;                     // BD Read access from WISHBONE side
wire   [31:0]   RxBDDataIn;                 // Rx BD data in
wire   [31:0]   TxBDDataIn;                 // Tx BD data in

reg             TxEndFrm_wb;

wire            TxRetryPulse;
wire            TxDonePulse;
wire            TxAbortPulse;
wire            TxRetryPulse_q;
wire            TxDonePulse_q;
wire            TxAbortPulse_q;

wire            StartRxBDRead;

wire            StartTxBDRead;

wire            TxIRQEn;
wire            WrapTxStatusBit;

wire            RxIRQEn;
wire            WrapRxStatusBit;

wire    [1:0]   TxValidBytes;

wire    [7:0]   TempTxBDAddress;
wire    [7:0]   TempRxBDAddress;

wire            SetGotData;
wire            GotDataEvaluate;

reg             WB_ACK_O;

wire    [6:0]   RxStatusIn;
reg     [6:0]   RxStatusInLatched;

reg WbEn, WbEn_q;
reg RxEn, RxEn_q;
reg TxEn, TxEn_q;

wire ram_ce;
wire ram_we;
wire ram_oe;
reg [7:0]   ram_addr;
reg [31:0]  ram_di;
wire [31:0] ram_do;

wire StartTxPointerRead;
reg  TxPointerRead;
reg TxEn_needed;
reg RxEn_needed;

wire StartRxPointerRead;
reg RxPointerRead; 


always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    begin
      WB_ACK_O <=#Tp 1'b0;
    end
  else
    begin
      WB_ACK_O <=#Tp BDWrite & WbEn & WbEn_q | BDRead & WbEn & ~WbEn_q;
    end
end

assign WB_DAT_O = ram_do;

// Generic synchronous single-port RAM interface
eth_spram_256x32 bd_ram (
	// Generic synchronous single-port RAM interface
	.clk(WB_CLK_I), .rst(Reset), .ce(ram_ce), .we(ram_we), .oe(ram_oe), .addr(ram_addr), .di(ram_di), .do(ram_do)
);

assign ram_ce = 1'b1;
assign ram_we = BDWrite & WbEn & WbEn_q | TxStatusWrite | RxStatusWrite;
assign ram_oe = BDRead & WbEn & WbEn_q | TxEn & TxEn_q & (TxBDRead | TxPointerRead) | RxEn & RxEn_q & (RxBDRead | RxPointerRead);


always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxEn_needed <=#Tp 1'b0;
  else
  if(~TxBDReady & r_TxEn & WbEn & ~WbEn_q)
    TxEn_needed <=#Tp 1'b1;
  else
  if(TxPointerRead & TxEn & TxEn_q)
    TxEn_needed <=#Tp 1'b0;
end

// Enabling access to the RAM for three devices.
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    begin
      WbEn <=#Tp 1'b1;
      RxEn <=#Tp 1'b0;
      TxEn <=#Tp 1'b0;
      ram_addr <=#Tp 8'h0;
      ram_di <=#Tp 32'h0;
      BDRead <=#Tp 1'b0;
      BDWrite <=#Tp 1'b0;
    end
  else
    begin
      // Switching between three stages depends on enable signals
      case ({WbEn_q, RxEn_q, TxEn_q, RxEn_needed, TxEn_needed})  // synopsys parallel_case
        5'b100_10, 5'b100_11 :
          begin
            WbEn <=#Tp 1'b0;
            RxEn <=#Tp 1'b1;  // wb access stage and r_RxEn is enabled
            TxEn <=#Tp 1'b0;
            ram_addr <=#Tp RxBDAddress + RxPointerRead;
            ram_di <=#Tp RxBDDataIn;
          end
        5'b100_01 :
          begin
            WbEn <=#Tp 1'b0;
            RxEn <=#Tp 1'b0;
            TxEn <=#Tp 1'b1;  // wb access stage, r_RxEn is disabled but r_TxEn is enabled
            ram_addr <=#Tp TxBDAddress + TxPointerRead;
            ram_di <=#Tp TxBDDataIn;
          end
        5'b010_00, 5'b010_10 :
          begin
            WbEn <=#Tp 1'b1;  // RxEn access stage and r_TxEn is disabled
            RxEn <=#Tp 1'b0;
            TxEn <=#Tp 1'b0;
            ram_addr <=#Tp WB_ADR_I[9:2];
            ram_di <=#Tp WB_DAT_I;
            BDWrite <=#Tp BDCs & WB_WE_I;
            BDRead <=#Tp BDCs & ~WB_WE_I;
          end
        5'b010_01, 5'b010_11 :
          begin
            WbEn <=#Tp 1'b0;
            RxEn <=#Tp 1'b0;
            TxEn <=#Tp 1'b1;  // RxEn access stage and r_TxEn is enabled
            ram_addr <=#Tp TxBDAddress + TxPointerRead;
            ram_di <=#Tp TxBDDataIn;
          end
        5'b001_00, 5'b001_01, 5'b001_10, 5'b001_11 :
          begin
            WbEn <=#Tp 1'b1;  // TxEn access stage (we always go to wb access stage)
            RxEn <=#Tp 1'b0;
            TxEn <=#Tp 1'b0;
            ram_addr <=#Tp WB_ADR_I[9:2];
            ram_di <=#Tp WB_DAT_I;
            BDWrite <=#Tp BDCs & WB_WE_I;
            BDRead <=#Tp BDCs & ~WB_WE_I;
          end
        5'b100_00 :
          begin
            WbEn <=#Tp 1'b0;  // WbEn access stage and there is no need for other stages. WbEn needs to be switched off for a bit
          end
        5'b000_00 :
          begin
            WbEn <=#Tp 1'b1;  // Idle state. We go to WbEn access stage.
            RxEn <=#Tp 1'b0;
            TxEn <=#Tp 1'b0;
            ram_addr <=#Tp WB_ADR_I[9:2];
            ram_di <=#Tp WB_DAT_I;
            BDWrite <=#Tp BDCs & WB_WE_I;
            BDRead <=#Tp BDCs & ~WB_WE_I;
          end
      endcase
    end
end


// Delayed stage signals
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    begin
      WbEn_q <=#Tp 1'b0;
      RxEn_q <=#Tp 1'b0;
      TxEn_q <=#Tp 1'b0;
    end
  else
    begin
      WbEn_q <=#Tp WbEn;
      RxEn_q <=#Tp RxEn;
      TxEn_q <=#Tp TxEn;
    end
end

// Changes for tx occur every second clock. Flop is used for this manner.
always @ (posedge MTxClk or posedge Reset)
begin
  if(Reset)
    Flop <=#Tp 1'b0;
  else
  if(TxDone | TxAbort | TxRetry_q)
    Flop <=#Tp 1'b0;
  else
  if(TxUsedData)
    Flop <=#Tp ~Flop;
end

wire ResetTxBDReady;
assign ResetTxBDReady = TxDonePulse | TxAbortPulse | TxRetryPulse;

// Latching READY status of the Tx buffer descriptor
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxBDReady <=#Tp 1'b0;
  else
  if(TxEn & TxEn_q & TxBDRead)
    TxBDReady <=#Tp ram_do[15] & (ram_do[31:16] > 4); // TxBDReady is sampled only once at the beginning.
  else                                                // Only packets larger then 4 bytes are transmitted.
  if(ResetTxBDReady)
    TxBDReady <=#Tp 1'b0;
end


// Reading the Tx buffer descriptor
assign StartTxBDRead = (TxRetry_wb | TxStatusWrite) & ~BlockingTxBDRead & ~TxBDReady;

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxBDRead <=#Tp 1'b1;
  else
  if(StartTxBDRead)
    TxBDRead <=#Tp 1'b1;
  else
  if(TxBDReady)
    TxBDRead <=#Tp 1'b0;
end


// Reading Tx BD pointer
assign StartTxPointerRead = TxBDRead & TxBDReady;

// Reading Tx BD Pointer
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxPointerRead <=#Tp 1'b0;
  else
  if(StartTxPointerRead)
    TxPointerRead <=#Tp 1'b1;
  else
  if(TxEn_q)
    TxPointerRead <=#Tp 1'b0;
end


// Writing status back to the Tx buffer descriptor
assign TxStatusWrite = (TxDone_wb | TxAbort_wb) & TxEn & TxEn_q & ~BlockingTxStatusWrite;



// Status writing must occur only once. Meanwhile it is blocked.
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    BlockingTxStatusWrite <=#Tp 1'b0;
  else
  if(TxStatusWrite)
    BlockingTxStatusWrite <=#Tp 1'b1;
  else
  if(~TxDone_wb & ~TxAbort_wb)
    BlockingTxStatusWrite <=#Tp 1'b0;
end


// TxBDRead state is activated only once. 
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    BlockingTxBDRead <=#Tp 1'b0;
  else
  if(StartTxBDRead)
    BlockingTxBDRead <=#Tp 1'b1;
  else
  if(~StartTxBDRead & ~TxBDReady)
    BlockingTxBDRead <=#Tp 1'b0;
end


// Latching status from the tx buffer descriptor
// Data is avaliable one cycle after the access is started (at that time signal TxEn is not active)
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxStatus <=#Tp 4'h0;
  else
  if(TxEn & TxEn_q & TxBDRead)
    TxStatus <=#Tp ram_do[14:11];
end

reg ReadTxDataFromMemory;
wire WriteRxDataToMemory;

reg MasterWbTX;
reg MasterWbRX;

reg [31:0] m_wb_adr_o;
reg        m_wb_cyc_o;
reg        m_wb_stb_o;
reg  [3:0] m_wb_sel_o;
reg        m_wb_we_o;

wire TxLengthEq0;
wire TxLengthLt4;

wire WordAccFinished;
wire HalfAccFinished;

//Latching length from the buffer descriptor;
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxLength <=#Tp 16'h0;
  else
  if(TxEn & TxEn_q & TxBDRead)
    TxLength <=#Tp ram_do[31:16];
  else
  if(MasterWbTX & m_wb_ack_i)
    begin
      if(TxLengthLt4)
        TxLength <=#Tp 16'h0;
      else if(WordAccFinished)
        TxLength <=#Tp TxLength - 3'h4;    // Length is subtracted at the data request
      else if(HalfAccFinished)
        TxLength <=#Tp TxLength - 2'h2;    // Length is subtracted at the data request
      else
        TxLength <=#Tp TxLength - 1'h1;    // Length is subtracted at the data request
    end
end

assign WordAccFinished = &m_wb_sel_o[3:0];
assign HalfAccFinished = &m_wb_sel_o[1:0];



//Latching length from the buffer descriptor;
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    LatchedTxLength <=#Tp 16'h0;
  else
  if(TxEn & TxEn_q & TxBDRead)
    LatchedTxLength <=#Tp ram_do[31:16];
end

assign TxLengthEq0 = TxLength == 0;
assign TxLengthLt4 = TxLength < 4;


reg BlockingIncrementTxPointer;

reg [31:0] TxPointer;
reg [1:0]  TxPointerLatched;
reg [31:0] RxPointer;
reg [1:0]  RxPointerLatched;

wire TxBurstAcc;
wire TxWordAcc;
wire TxHalfAcc;
wire TxByteAcc;

wire RxBurstAcc;
wire RxWordAcc;
wire RxHalfAcc;
wire RxByteAcc;


//Latching Tx buffer pointer from buffer descriptor;
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxPointer <=#Tp 0;
  else
  if(TxEn & TxEn_q & TxPointerRead)
    TxPointer <=#Tp ram_do;
  else
  if(MasterWbTX & ~BlockingIncrementTxPointer)
    if(TxWordAcc)
      TxPointer <=#Tp TxPointer + 3'h4; // Word access
    else if(TxHalfAcc)
      TxPointer <=#Tp TxPointer + 2'h2; // Half access
    else
      TxPointer <=#Tp TxPointer + 1'h1; // Byte access
end



//Latching last addresses from buffer descriptor (used as byte-half-word indicator);
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxPointerLatched[1:0] <=#Tp 0;
  else
  if(TxEn & TxEn_q & TxPointerRead)
    TxPointerLatched[1:0] <=#Tp ram_do[1:0];
end


assign TxBurstAcc = ~TxPointer[3] & ~TxPointer[2] & ~TxPointer[1] & ~TxPointer[0]; // Add a counter that count burst to 4
assign TxWordAcc  = ~TxPointer[1] & ~TxPointer[0];
assign TxHalfAcc  =  TxPointer[1] & ~TxPointer[0];
assign TxByteAcc  =  TxPointer[0];

wire [3:0] m_wb_sel_tmp_tx;
reg  [3:0] m_wb_sel_tmp_rx;


assign m_wb_sel_tmp_tx[0] = TxWordAcc | TxHalfAcc | TxByteAcc &  TxPointer[1];
assign m_wb_sel_tmp_tx[1] = TxWordAcc | TxHalfAcc;
assign m_wb_sel_tmp_tx[2] = TxWordAcc |             TxByteAcc & ~TxPointer[1];
assign m_wb_sel_tmp_tx[3] = TxWordAcc;


wire MasterAccessFinished;


always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    BlockingIncrementTxPointer <=#Tp 0;
  else
  if(MasterAccessFinished)
    BlockingIncrementTxPointer <=#Tp 0;
  else
  if(MasterWbTX)
    BlockingIncrementTxPointer <=#Tp 1'b1;
end


wire TxBufferAlmostFull;
wire TxBufferFull;
wire TxBufferEmpty;
wire TxBufferAlmostEmpty;
wire ResetReadTxDataFromMemory;
wire SetReadTxDataFromMemory;

reg BlockReadTxDataFromMemory;

assign ResetReadTxDataFromMemory = (TxLengthEq0) | TxAbortPulse_q | TxRetryPulse_q;
assign SetReadTxDataFromMemory = TxEn & TxEn_q & TxPointerRead;

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    ReadTxDataFromMemory <=#Tp 1'b0;
  else
  if(ResetReadTxDataFromMemory)
    ReadTxDataFromMemory <=#Tp 1'b0;
  else
  if(SetReadTxDataFromMemory)
    ReadTxDataFromMemory <=#Tp 1'b1;
end

wire ReadTxDataFromMemory_2 = ReadTxDataFromMemory & ~BlockReadTxDataFromMemory;
wire [31:0] TxData_wb;
wire ReadTxDataFromFifo_wb;

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    BlockReadTxDataFromMemory <=#Tp 1'b0;
  else
  if(ReadTxDataFromFifo_wb | ResetReadTxDataFromMemory)
    BlockReadTxDataFromMemory <=#Tp 1'b0;
  else
  if((TxBufferAlmostFull | TxLength <= 4)& MasterWbTX)
    BlockReadTxDataFromMemory <=#Tp 1'b1;
end



assign MasterAccessFinished = m_wb_ack_i | m_wb_err_i;
reg cyc_cleared;

// Enabling master wishbone access to the memory for two devices TX and RX.
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    begin
      MasterWbTX <=#Tp 1'b0;
      MasterWbRX <=#Tp 1'b0;
      m_wb_adr_o <=#Tp 32'h0;
      m_wb_cyc_o <=#Tp 1'b0;
      m_wb_stb_o <=#Tp 1'b0;
      m_wb_we_o  <=#Tp 1'b0;
      m_wb_sel_o <=#Tp 4'h0;
      cyc_cleared<=#Tp 1'b0;
    end
  else
    begin
      // Switching between two stages depends on enable signals
      casex ({MasterWbTX, MasterWbRX, ReadTxDataFromMemory_2, WriteRxDataToMemory, MasterAccessFinished, cyc_cleared})  // synopsys parallel_case
        6'b00_01_0_x, 6'b00_11_0_x :
          begin
            MasterWbTX <=#Tp 1'b0;  // idle and master write is needed (data write to rx buffer)
            MasterWbRX <=#Tp 1'b1;
            m_wb_adr_o <=#Tp RxPointer;
            m_wb_cyc_o <=#Tp 1'b1;
            m_wb_stb_o <=#Tp 1'b1;
            m_wb_we_o  <=#Tp 1'b1;
            m_wb_sel_o <=#Tp m_wb_sel_tmp_rx;
          end
        6'b00_10_0_x, 6'b00_10_1_x :
          begin
            MasterWbTX <=#Tp 1'b1;  // idle and master read is needed (data read from tx buffer)
            MasterWbRX <=#Tp 1'b0;
            m_wb_adr_o <=#Tp TxPointer;
            m_wb_cyc_o <=#Tp 1'b1;
            m_wb_stb_o <=#Tp 1'b1;
            m_wb_we_o  <=#Tp 1'b0;
            m_wb_sel_o <=#Tp m_wb_sel_tmp_tx;
          end
        6'b10_10_0_1 :
          begin
            MasterWbTX <=#Tp 1'b1;  // master read and master read is needed (data read from tx buffer)
            MasterWbRX <=#Tp 1'b0;
            m_wb_adr_o <=#Tp TxPointer;
            m_wb_cyc_o <=#Tp 1'b1;
            m_wb_stb_o <=#Tp 1'b1;
            m_wb_we_o  <=#Tp 1'b0;
            m_wb_sel_o <=#Tp m_wb_sel_tmp_tx;
            cyc_cleared<=#Tp 1'b0;
          end
        6'b01_01_0_1 :
          begin
            MasterWbTX <=#Tp 1'b0;  // master write and master write is needed (data write to rx buffer)
            MasterWbRX <=#Tp 1'b1;
            m_wb_adr_o <=#Tp RxPointer;
            m_wb_cyc_o <=#Tp 1'b1;
            m_wb_stb_o <=#Tp 1'b1;
            m_wb_we_o  <=#Tp 1'b1;
            m_wb_sel_o <=#Tp m_wb_sel_tmp_rx;
            cyc_cleared<=#Tp 1'b0;
          end
        6'b10_01_0_1, 6'b10_11_0_1 :
          begin
            MasterWbTX <=#Tp 1'b0;  // master read and master write is needed (data write to rx buffer)
            MasterWbRX <=#Tp 1'b1;
            m_wb_adr_o <=#Tp RxPointer;
            m_wb_cyc_o <=#Tp 1'b1;
            m_wb_stb_o <=#Tp 1'b1;
            m_wb_we_o  <=#Tp 1'b1;
            m_wb_sel_o <=#Tp m_wb_sel_tmp_rx;
            cyc_cleared<=#Tp 1'b0;
          end
        6'b01_10_0_1, 6'b01_11_0_1 :
          begin
            MasterWbTX <=#Tp 1'b1;  // master write and master read is needed (data read from tx buffer)
            MasterWbRX <=#Tp 1'b0;
            m_wb_adr_o <=#Tp TxPointer;
            m_wb_cyc_o <=#Tp 1'b1;
            m_wb_stb_o <=#Tp 1'b1;
            m_wb_we_o  <=#Tp 1'b0;
            m_wb_sel_o <=#Tp m_wb_sel_tmp_tx;
            cyc_cleared<=#Tp 1'b0;
          end
        6'b10_10_1_0, 6'b01_01_1_0, 6'b10_01_1_0, 6'b10_11_1_0, 6'b01_10_1_0, 6'b01_11_1_0 :
          begin
            m_wb_cyc_o <=#Tp 1'b0;  // whatever and master read or write is needed. We need to clear m_wb_cyc_o before next access is started
            m_wb_stb_o <=#Tp 1'b0;
            cyc_cleared<=#Tp 1'b1;
          end
        6'b10_00_1_x, 6'b01_00_1_x :
          begin
            MasterWbTX <=#Tp 1'b0;  // whatever and no master read or write is needed (ack or err comes finishing previous access)
            MasterWbRX <=#Tp 1'b0;
            m_wb_cyc_o <=#Tp 1'b0;
            m_wb_stb_o <=#Tp 1'b0;
          end
        default:                            // Don't touch
          begin
            MasterWbTX <=#Tp MasterWbTX;
            MasterWbRX <=#Tp MasterWbRX;
            m_wb_cyc_o <=#Tp m_wb_cyc_o;
            m_wb_stb_o <=#Tp m_wb_stb_o;
            m_wb_sel_o <=#Tp m_wb_sel_o;
          end
      endcase
    end
end



wire TxFifoClear;
wire [31:0] tx_fifo_dat_i;

assign TxFifoClear = (TxAbort_wb | TxRetry_wb) & ~TxBDReady;

reg  [23:16] LatchedData;
wire [23:16] TempData;

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    LatchedData[23:16] <=#Tp 0;
  else
  if(MasterWbTX & m_wb_ack_i & m_wb_sel_o[2])
    LatchedData[23:16] <=#Tp m_wb_dat_i[23:16];
end

assign TempData[23:16] = m_wb_sel_o[2]? m_wb_dat_i[23:16] : LatchedData[23:16];

assign tx_fifo_dat_i[31:0] = {m_wb_dat_i[31:24], TempData[23:16], m_wb_dat_i[15:8], m_wb_dat_i[7:0]};


eth_fifo #(`TX_FIFO_DATA_WIDTH, `TX_FIFO_DEPTH, `TX_FIFO_CNT_WIDTH)
tx_fifo ( .data_in(tx_fifo_dat_i),                          .data_out(TxData_wb), 
          .clk(WB_CLK_I),                                   .reset(Reset), 
          .write(MasterWbTX & m_wb_ack_i & m_wb_sel_o[0]),  .read(ReadTxDataFromFifo_wb), 
          .clear(TxFifoClear),                              .full(TxBufferFull), 
          .almost_full(TxBufferAlmostFull),                 .almost_empty(TxBufferAlmostEmpty), 
          .empty(TxBufferEmpty),                            .cnt()
        );


reg StartOccured;
reg TxStartFrm_sync1;
reg TxStartFrm_sync2;
reg TxStartFrm_syncb1;
reg TxStartFrm_syncb2;



// Start: Generation of the TxStartFrm_wb which is then synchronized to the MTxClk
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxStartFrm_wb <=#Tp 1'b0;
  else
  if(TxBDReady & ~StartOccured & (TxBufferFull | TxLengthEq0))
    TxStartFrm_wb <=#Tp 1'b1;
  else
  if(TxStartFrm_syncb2)
    TxStartFrm_wb <=#Tp 1'b0;
end

// StartOccured: TxStartFrm_wb occurs only ones at the beginning. Then it's blocked.
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    StartOccured <=#Tp 1'b0;
  else
  if(TxStartFrm_wb)
    StartOccured <=#Tp 1'b1;
  else
  if(ResetTxBDReady)
    StartOccured <=#Tp 1'b0;
end

// Synchronizing TxStartFrm_wb to MTxClk
always @ (posedge MTxClk or posedge Reset)
begin
  if(Reset)
    TxStartFrm_sync1 <=#Tp 1'b0;
  else
    TxStartFrm_sync1 <=#Tp TxStartFrm_wb;
end

always @ (posedge MTxClk or posedge Reset)
begin
  if(Reset)
    TxStartFrm_sync2 <=#Tp 1'b0;
  else
    TxStartFrm_sync2 <=#Tp TxStartFrm_sync1;
end

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxStartFrm_syncb1 <=#Tp 1'b0;
  else
    TxStartFrm_syncb1 <=#Tp TxStartFrm_sync2;
end

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxStartFrm_syncb2 <=#Tp 1'b0;
  else
    TxStartFrm_syncb2 <=#Tp TxStartFrm_syncb1;
end

always @ (posedge MTxClk or posedge Reset)
begin
  if(Reset)
    TxStartFrm <=#Tp 1'b0;
  else
  if(TxStartFrm_sync2)
    TxStartFrm <=#Tp 1'b1;
  else
  if(TxUsedData_q | ~TxStartFrm_sync2 & (TxRetry | TxAbort))
    TxStartFrm <=#Tp 1'b0;
end
// End: Generation of the TxStartFrm_wb which is then synchronized to the MTxClk


// TxEndFrm_wb: indicator of the end of frame
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxEndFrm_wb <=#Tp 1'b0;
  else
  if(TxLengthLt4 & TxBufferAlmostEmpty & TxUsedData)
    TxEndFrm_wb <=#Tp 1'b1;
  else
  if(TxRetryPulse | TxDonePulse | TxAbortPulse)
    TxEndFrm_wb <=#Tp 1'b0;
end


// Marks which bytes are valid within the word.
assign TxValidBytes = TxLengthLt4 ? TxLength[1:0] : 2'b0;

reg LatchValidBytes;
reg LatchValidBytes_q;

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    LatchValidBytes <=#Tp 1'b0;
  else
  if(TxLengthLt4 & TxBDReady)
    LatchValidBytes <=#Tp 1'b1;
  else
    LatchValidBytes <=#Tp 1'b0;
end

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    LatchValidBytes_q <=#Tp 1'b0;
  else
    LatchValidBytes_q <=#Tp LatchValidBytes;
end


// Latching valid bytes
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxValidBytesLatched <=#Tp 2'h0;
  else
  if(LatchValidBytes & ~LatchValidBytes_q)
    TxValidBytesLatched <=#Tp TxValidBytes;
  else
  if(TxRetryPulse | TxDonePulse | TxAbortPulse)
    TxValidBytesLatched <=#Tp 2'h0;
end


assign TxIRQEn          = TxStatus[14];
assign WrapTxStatusBit  = TxStatus[13];
assign PerPacketPad     = TxStatus[12];
assign PerPacketCrcEn   = TxStatus[11];


assign RxIRQEn         = RxStatus[14];
assign WrapRxStatusBit = RxStatus[13];


// Temporary Tx and Rx buffer descriptor address 
assign TempTxBDAddress[7:0] = {8{ TxStatusWrite     & ~WrapTxStatusBit}} & (TxBDAddress + 2'h2) ; // Tx BD increment or wrap (last BD)
assign TempRxBDAddress[7:0] = {8{ WrapRxStatusBit}} & (r_TxBDNum)       | // Using first Rx BD
                              {8{~WrapRxStatusBit}} & (RxBDAddress + 2'h2) ; // Using next Rx BD (incremenrement address)


// Latching Tx buffer descriptor address
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxBDAddress <=#Tp 8'h0;
  else
  if(TxStatusWrite)
    TxBDAddress <=#Tp TempTxBDAddress;
end


// Latching Rx buffer descriptor address
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    RxBDAddress <=#Tp `ETH_TX_BD_NUM_DEF;
  else
  if(TX_BD_NUM_Wr)                        // When r_TxBDNum is updated, RxBDAddress is also
    RxBDAddress <=#Tp WB_DAT_I[7:0];
  else
  if(RxStatusWrite)
    RxBDAddress <=#Tp TempRxBDAddress;
end

wire [8:0] TxStatusInLatched = {TxUnderRun, RetryCntLatched[3:0], RetryLimit, LateCollLatched, DeferLatched, CarrierSenseLost};

assign RxBDDataIn = {LatchedRxLength, 1'b0, RxStatus, 6'h0, RxStatusInLatched};
assign TxBDDataIn = {LatchedTxLength, 1'b0, TxStatus, 2'h0, TxStatusInLatched};


// Signals used for various purposes
assign TxRetryPulse   = TxRetry_wb   & ~TxRetry_wb_q;
assign TxDonePulse    = TxDone_wb    & ~TxDone_wb_q;
assign TxAbortPulse   = TxAbort_wb   & ~TxAbort_wb_q;
assign TxRetryPulse_q = TxRetry_wb_q & ~TxRetry_wb_q2;
assign TxDonePulse_q  = TxDone_wb_q  & ~TxDone_wb_q2;
assign TxAbortPulse_q = TxAbort_wb_q & ~TxAbort_wb_q2;


assign TPauseRq = 0;
assign TxPauseTV[15:0] = TxLength[15:0];


// Generating delayed signals
always @ (posedge MTxClk or posedge Reset)
begin
  if(Reset)
    begin
      TxAbort_q      <=#Tp 1'b0;
      TxRetry_q      <=#Tp 1'b0;
      TxUsedData_q   <=#Tp 1'b0;
    end
  else
    begin
      TxAbort_q      <=#Tp TxAbort;
      TxRetry_q      <=#Tp TxRetry;
      TxUsedData_q   <=#Tp TxUsedData;
    end
end

// Generating delayed signals
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    begin
      TxDone_wb_q   <=#Tp 1'b0;
      TxAbort_wb_q  <=#Tp 1'b0;
      TxRetry_wb_q  <=#Tp 1'b0;
      TxDone_wb_q2  <=#Tp 1'b0;
      TxAbort_wb_q2 <=#Tp 1'b0;
      TxRetry_wb_q2 <=#Tp 1'b0;
    end
  else
    begin
      TxDone_wb_q   <=#Tp TxDone_wb;
      TxAbort_wb_q  <=#Tp TxAbort_wb;
      TxRetry_wb_q  <=#Tp TxRetry_wb;
      TxDone_wb_q2  <=#Tp TxDone_wb_q;
      TxAbort_wb_q2 <=#Tp TxAbort_wb_q;
      TxRetry_wb_q2 <=#Tp TxRetry_wb_q;
    end
end


// Sinchronizing and evaluating tx data
//assign SetGotData = (TxStartFrm_wb | NewTxDataAvaliable_wb & ~TxAbort_wb & ~TxRetry_wb) & ~WB_CLK_I;
assign SetGotData = (TxStartFrm_wb); // igor namesto zgornje

// Evaluating data. If abort or retry occured meanwhile than data is ignored.
//assign GotDataEvaluate = GotDataSync3 & ~GotData & (~TxRetry & ~TxAbort | (TxRetry | TxAbort) & (TxStartFrm));
assign GotDataEvaluate = (~TxRetry & ~TxAbort | (TxRetry | TxAbort) & (TxStartFrm));


// Indication of the last word
always @ (posedge MTxClk or posedge Reset)
begin
  if(Reset)
    LastWord <=#Tp 1'b0;
  else
  if((TxEndFrm | TxAbort | TxRetry) & Flop)
    LastWord <=#Tp 1'b0;
  else
  if(TxUsedData & Flop & TxByteCnt == 2'h3)
    LastWord <=#Tp TxEndFrm_wb;
end


// Tx end frame generation
always @ (posedge MTxClk or posedge Reset)
begin
  if(Reset)
    TxEndFrm <=#Tp 1'b0;
  else
  if(Flop & TxEndFrm | TxAbort | TxRetry_q)
    TxEndFrm <=#Tp 1'b0;        
  else
  if(Flop & LastWord)
    begin
      case (TxValidBytesLatched)  // synopsys parallel_case
        1 : TxEndFrm <=#Tp TxByteCnt == 2'h0;
        2 : TxEndFrm <=#Tp TxByteCnt == 2'h1;
        3 : TxEndFrm <=#Tp TxByteCnt == 2'h2;
        0 : TxEndFrm <=#Tp TxByteCnt == 2'h3;
        default : TxEndFrm <=#Tp 1'b0;
      endcase
    end
end


// Tx data selection (latching)
always @ (posedge MTxClk or posedge Reset)
begin
  if(Reset)
    TxData <=#Tp 0;
  else
  if(TxStartFrm_sync2 & ~TxStartFrm)
    case(TxPointerLatched)  // synopsys parallel_case
      2'h0 : TxData <=#Tp TxData_wb[31:24];                  // Big Endian Byte Ordering
      2'h1 : TxData <=#Tp TxData_wb[23:16];                  // Big Endian Byte Ordering
      2'h2 : TxData <=#Tp TxData_wb[15:08];                  // Big Endian Byte Ordering
      2'h3 : TxData <=#Tp TxData_wb[07:00];                  // Big Endian Byte Ordering
    endcase
  else
  if(TxStartFrm & TxUsedData & TxPointerLatched==2'h3)
    TxData <=#Tp TxData_wb[31:24];                           // Big Endian Byte Ordering
  else
  if(TxUsedData & Flop)
    begin
      case(TxByteCnt)  // synopsys parallel_case
        0 : TxData <=#Tp TxDataLatched[31:24];      // Big Endian Byte Ordering
        1 : TxData <=#Tp TxDataLatched[23:16];
        2 : TxData <=#Tp TxDataLatched[15:8];
        3 : TxData <=#Tp TxDataLatched[7:0];
      endcase
    end
end


// Latching tx data
always @ (posedge MTxClk or posedge Reset)
begin
  if(Reset)
    TxDataLatched[31:0] <=#Tp 32'h0;
  else
 if(TxStartFrm_sync2 & ~TxStartFrm | TxUsedData & Flop & TxByteCnt == 2'h3 | TxStartFrm & TxUsedData & Flop & TxByteCnt == 2'h0)
    TxDataLatched[31:0] <=#Tp TxData_wb[31:0];
end


// Tx under run
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxUnderRun_wb <=#Tp 1'b0;
  else
  if(TxAbortPulse)
    TxUnderRun_wb <=#Tp 1'b0;
  else
  if(TxBufferEmpty & ReadTxDataFromFifo_wb)
    TxUnderRun_wb <=#Tp 1'b1;
end


// Tx under run
always @ (posedge MTxClk or posedge Reset)
begin
  if(Reset)
    TxUnderRun <=#Tp 1'b0;
  else
  if(TxUnderRun_wb)
    TxUnderRun <=#Tp 1'b1;
  else
  if(BlockingTxStatusWrite)
    TxUnderRun <=#Tp 1'b0;
end


// Tx Byte counter
always @ (posedge MTxClk or posedge Reset)
begin
  if(Reset)
    TxByteCnt <=#Tp 2'h0;
  else
  if(TxAbort_q | TxRetry_q)
    TxByteCnt <=#Tp 2'h0;
  else
  if(TxStartFrm & ~TxUsedData)
    case(TxPointerLatched)  // synopsys parallel_case
      2'h0 : TxByteCnt <=#Tp 2'h1;
      2'h1 : TxByteCnt <=#Tp 2'h2;
      2'h2 : TxByteCnt <=#Tp 2'h3;
      2'h3 : TxByteCnt <=#Tp 2'h0;
    endcase
  else
  if(TxUsedData & Flop)
    TxByteCnt <=#Tp TxByteCnt + 1'b1;
end


// Start: Generation of the ReadTxDataFromFifo_tck signal and synchronization to the WB_CLK_I
reg ReadTxDataFromFifo_sync1;
reg ReadTxDataFromFifo_sync2;
reg ReadTxDataFromFifo_sync3;
reg ReadTxDataFromFifo_syncb1;
reg ReadTxDataFromFifo_syncb2;


always @ (posedge MTxClk or posedge Reset)
begin
  if(Reset)
    ReadTxDataFromFifo_tck <=#Tp 1'b0;
  else
  if(ReadTxDataFromFifo_syncb2)
    ReadTxDataFromFifo_tck <=#Tp 1'b0;
  else
  if(TxStartFrm_sync2 & ~TxStartFrm | TxUsedData & Flop & TxByteCnt == 2'h3 & ~LastWord | TxStartFrm & TxUsedData & Flop & TxByteCnt == 2'h0)
     ReadTxDataFromFifo_tck <=#Tp 1'b1;
end

// Synchronizing TxStartFrm_wb to MTxClk
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    ReadTxDataFromFifo_sync1 <=#Tp 1'b0;
  else
    ReadTxDataFromFifo_sync1 <=#Tp ReadTxDataFromFifo_tck;
end

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    ReadTxDataFromFifo_sync2 <=#Tp 1'b0;
  else
    ReadTxDataFromFifo_sync2 <=#Tp ReadTxDataFromFifo_sync1;
end

always @ (posedge MTxClk or posedge Reset)
begin
  if(Reset)
    ReadTxDataFromFifo_syncb1 <=#Tp 1'b0;
  else
    ReadTxDataFromFifo_syncb1 <=#Tp ReadTxDataFromFifo_sync2;
end

always @ (posedge MTxClk or posedge Reset)
begin
  if(Reset)
    ReadTxDataFromFifo_syncb2 <=#Tp 1'b0;
  else
    ReadTxDataFromFifo_syncb2 <=#Tp ReadTxDataFromFifo_syncb1;
end

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    ReadTxDataFromFifo_sync3 <=#Tp 1'b0;
  else
    ReadTxDataFromFifo_sync3 <=#Tp ReadTxDataFromFifo_sync2;
end

assign ReadTxDataFromFifo_wb = ReadTxDataFromFifo_sync2 & ~ReadTxDataFromFifo_sync3;
// End: Generation of the ReadTxDataFromFifo_tck signal and synchronization to the WB_CLK_I


// Synchronizing TxRetry signal (synchronized to WISHBONE clock)
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxRetrySync1 <=#Tp 1'b0;
  else
    TxRetrySync1 <=#Tp TxRetry;
end

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxRetry_wb <=#Tp 1'b0;
  else
    TxRetry_wb <=#Tp TxRetrySync1;
end


// Synchronized TxDone_wb signal (synchronized to WISHBONE clock)
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxDoneSync1 <=#Tp 1'b0;
  else
    TxDoneSync1 <=#Tp TxDone;
end

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxDone_wb <=#Tp 1'b0;
  else
    TxDone_wb <=#Tp TxDoneSync1;
end

// Synchronizing TxAbort signal (synchronized to WISHBONE clock)
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxAbortSync1 <=#Tp 1'b0;
  else
    TxAbortSync1 <=#Tp TxAbort;
end

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxAbort_wb <=#Tp 1'b0;
  else
    TxAbort_wb <=#Tp TxAbortSync1;
end


assign StartRxBDRead = RxStatusWrite | RxAbortLatched;

// Reading the Rx buffer descriptor
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    RxBDRead <=#Tp 1'b1;
  else
  if(StartRxBDRead & ~RxBDReady)
    RxBDRead <=#Tp 1'b1;
  else
  if(RxBDReady)
    RxBDRead <=#Tp 1'b0;
end


// Reading of the next receive buffer descriptor starts after reception status is
// written to the previous one.

// Latching READY status of the Rx buffer descriptor
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    RxBDReady <=#Tp 1'b0;
  else
  if(RxEn & RxEn_q & RxBDRead)
    RxBDReady <=#Tp ram_do[15]; // RxBDReady is sampled only once at the beginning
  else
  if(ShiftEnded | RxAbort)
    RxBDReady <=#Tp 1'b0;
end

// Latching Rx buffer descriptor status
// Data is avaliable one cycle after the access is started (at that time signal RxEn is not active)
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    RxStatus <=#Tp 2'h0;
  else
  if(RxEn & RxEn_q & RxBDRead)
    RxStatus <=#Tp ram_do[14:13];
end




// Reading Rx BD pointer


assign StartRxPointerRead = RxBDRead & RxBDReady;

// Reading Tx BD Pointer
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    RxPointerRead <=#Tp 1'b0;
  else
  if(StartRxPointerRead)
    RxPointerRead <=#Tp 1'b1;
  else
  if(RxEn_q)
    RxPointerRead <=#Tp 1'b0;
end


//Latching Rx buffer pointer from buffer descriptor;
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    RxPointer <=#Tp 32'h0;
  else
  if(RxEn & RxEn_q & RxPointerRead)
    RxPointer <=#Tp {ram_do[31:2], 2'h0};
  else
  if(MasterWbRX & m_wb_ack_i)
      RxPointer <=#Tp RxPointer + 3'h4; // Word access  (always word access. m_wb_sel_o are used for selecting bytes)
end


//Latching last addresses from buffer descriptor (used as byte-half-word indicator);
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    RxPointerLatched[1:0] <=#Tp 0;
  else
  if(MasterWbRX & m_wb_ack_i)                 // After first write all m_wb_sel_tmp_rx are active
    RxPointerLatched[1:0] <=#Tp 0;
  else
  if(RxEn & RxEn_q & RxPointerRead)
    RxPointerLatched[1:0] <=#Tp ram_do[1:0];
end


always @ (RxPointerLatched)
begin
  case(RxPointerLatched[1:0])  // synopsys parallel_case
    2'h0 : m_wb_sel_tmp_rx[3:0] = 4'hf;
    2'h1 : m_wb_sel_tmp_rx[3:0] = 4'h7;
    2'h2 : m_wb_sel_tmp_rx[3:0] = 4'h3;
    2'h3 : m_wb_sel_tmp_rx[3:0] = 4'h1;
  endcase
end


always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    RxEn_needed <=#Tp 1'b0;
  else
  if(~RxBDReady & r_RxEn & WbEn & ~WbEn_q)
    RxEn_needed <=#Tp 1'b1;
  else
  if(RxPointerRead & RxEn & RxEn_q)
    RxEn_needed <=#Tp 1'b0;
end


// Reception status is written back to the buffer descriptor after the end of frame is detected.
assign RxStatusWrite = ShiftEnded & RxEn & RxEn_q;

reg RxStatusWriteLatched;
reg RxStatusWrite_rck;

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    RxStatusWriteLatched <=#Tp 1'b0;
  else
  if(RxStatusWrite & ~RxStatusWrite_rck)
    RxStatusWriteLatched <=#Tp 1'b1;
  else
  if(RxStatusWrite_rck)
    RxStatusWriteLatched <=#Tp 1'b0;
end


always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    RxStatusWrite_rck <=#Tp 1'b0;
  else
  if(RxStatusWriteLatched)
    RxStatusWrite_rck <=#Tp 1'b1;
  else
    RxStatusWrite_rck <=#Tp 1'b0;
end


reg RxEnableWindow;

// Indicating that last byte is being reveived
always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    LastByteIn <=#Tp 1'b0;
  else
  if(ShiftWillEnd & (&RxByteCnt) | RxAbort)
    LastByteIn <=#Tp 1'b0;
  else
  if(RxValid & RxBDReady & RxEndFrm & ~(&RxByteCnt) & RxEnableWindow)
    LastByteIn <=#Tp 1'b1;
end

reg ShiftEnded_tck;
reg ShiftEndedSync1;
reg ShiftEndedSync2;
reg ShiftEndedSync3;
reg ShiftEndedSync_c1;
reg ShiftEndedSync_c2;

wire StartShiftWillEnd;
//assign StartShiftWillEnd = LastByteIn & (&RxByteCnt) | RxValid & RxEndFrm & (&RxByteCnt) & RxEnableWindow;
assign StartShiftWillEnd = LastByteIn  | RxValid & RxEndFrm & (&RxByteCnt) & RxEnableWindow;

// Indicating that data reception will end
always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    ShiftWillEnd <=#Tp 1'b0;
  else
  if(ShiftEnded_tck | RxAbort)
    ShiftWillEnd <=#Tp 1'b0;
  else
  if(StartShiftWillEnd)
    ShiftWillEnd <=#Tp 1'b1;
end



// Receive byte counter
always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    RxByteCnt <=#Tp 2'h0;
  else
  if(ShiftEnded_tck | RxAbort)
    RxByteCnt <=#Tp 2'h0;
  else
  if(RxValid & RxStartFrm & RxBDReady)
    case(RxPointerLatched)  // synopsys parallel_case
      2'h0 : RxByteCnt <=#Tp 2'h1;
      2'h1 : RxByteCnt <=#Tp 2'h2;
      2'h2 : RxByteCnt <=#Tp 2'h3;
      2'h3 : RxByteCnt <=#Tp 2'h0;
    endcase
  else
  if(RxValid & RxEnableWindow & RxBDReady | LastByteIn)
    RxByteCnt <=#Tp RxByteCnt + 1'b1;
end


// Indicates how many bytes are valid within the last word
always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    RxValidBytes <=#Tp 2'h1;
  else
  if(RxValid & RxStartFrm)
    case(RxPointerLatched)  // synopsys parallel_case
      2'h0 : RxValidBytes <=#Tp 2'h1;
      2'h1 : RxValidBytes <=#Tp 2'h2;
      2'h2 : RxValidBytes <=#Tp 2'h3;
      2'h3 : RxValidBytes <=#Tp 2'h0;
    endcase
  else
  if(RxValid & ~LastByteIn & ~RxStartFrm & RxEnableWindow)
    RxValidBytes <=#Tp RxValidBytes + 1;
end


always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    RxDataLatched1       <=#Tp 24'h0;
  else
  if(RxValid & RxBDReady & ~LastByteIn)
    if(RxStartFrm)
    begin
      case(RxPointerLatched)     // synopsys parallel_case
        2'h0:        RxDataLatched1[31:24] <=#Tp RxData;            // Big Endian Byte Ordering
        2'h1:        RxDataLatched1[23:16] <=#Tp RxData;
        2'h2:        RxDataLatched1[15:8]  <=#Tp RxData;
        2'h3:        RxDataLatched1        <=#Tp RxDataLatched1;
      endcase
    end
    else if (RxEnableWindow)
    begin
      case(RxByteCnt)     // synopsys parallel_case
        2'h0:        RxDataLatched1[31:24] <=#Tp RxData;            // Big Endian Byte Ordering
        2'h1:        RxDataLatched1[23:16] <=#Tp RxData;
        2'h2:        RxDataLatched1[15:8]  <=#Tp RxData;
        2'h3:        RxDataLatched1        <=#Tp RxDataLatched1;
      endcase
    end
end

wire SetWriteRxDataToFifo;

// Assembling data that will be written to the rx_fifo
always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    RxDataLatched2 <=#Tp 32'h0;
  else
  if(SetWriteRxDataToFifo & ~ShiftWillEnd)
    RxDataLatched2 <=#Tp {RxDataLatched1[31:8], RxData};              // Big Endian Byte Ordering
  else
  if(SetWriteRxDataToFifo & ShiftWillEnd)
    case(RxValidBytes)  // synopsys parallel_case
//      0 : RxDataLatched2 <=#Tp {RxDataLatched1[31:8],  RxData};       // Big Endian Byte Ordering
//      1 : RxDataLatched2 <=#Tp {RxDataLatched1[31:24], 24'h0};
//      2 : RxDataLatched2 <=#Tp {RxDataLatched1[31:16], 16'h0};
//      3 : RxDataLatched2 <=#Tp {RxDataLatched1[31:8],   8'h0};
      0 : RxDataLatched2 <=#Tp {RxDataLatched1[31:8],  RxData};       // Big Endian Byte Ordering
      1 : RxDataLatched2 <=#Tp {RxDataLatched1[31:24], 24'h0};
      2 : RxDataLatched2 <=#Tp {RxDataLatched1[31:16], 16'h0};
      3 : RxDataLatched2 <=#Tp {RxDataLatched1[31:8],   8'h0};
    endcase
end


reg WriteRxDataToFifoSync1;
reg WriteRxDataToFifoSync2;


// Indicating start of the reception process
//assign SetWriteRxDataToFifo = (RxValid & RxBDReady & ~RxStartFrm & RxEnableWindow & (&RxByteCnt)) | (ShiftWillEnd & LastByteIn & (&RxByteCnt));
assign SetWriteRxDataToFifo = (RxValid & RxBDReady & ~RxStartFrm & RxEnableWindow & (&RxByteCnt)) | (RxValid & RxBDReady & RxStartFrm & (&RxPointerLatched)) | (ShiftWillEnd & LastByteIn & (&RxByteCnt));

always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    WriteRxDataToFifo <=#Tp 1'b0;
  else
  if(SetWriteRxDataToFifo & ~RxAbort)
    WriteRxDataToFifo <=#Tp 1'b1;
  else
  if(WriteRxDataToFifoSync1 | RxAbort)
    WriteRxDataToFifo <=#Tp 1'b0;
end



always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    WriteRxDataToFifoSync1 <=#Tp 1'b0;
  else
  if(WriteRxDataToFifo)
    WriteRxDataToFifoSync1 <=#Tp 1'b1;
  else
    WriteRxDataToFifoSync1 <=#Tp 1'b0;
end

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    WriteRxDataToFifoSync2 <=#Tp 1'b0;
  else
    WriteRxDataToFifoSync2 <=#Tp WriteRxDataToFifoSync1;
end

wire WriteRxDataToFifo_wb;
assign WriteRxDataToFifo_wb = WriteRxDataToFifoSync1 & ~WriteRxDataToFifoSync2;

reg RxAbortSync1;
reg RxAbortSync2;
reg RxAbortSyncb1;
reg RxAbortSyncb2;

reg LatchedRxStartFrm;
reg SyncRxStartFrm;
reg SyncRxStartFrm_q;
wire RxFifoReset;

always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    LatchedRxStartFrm <=#Tp 0;
  else
  if(RxStartFrm & ~SyncRxStartFrm)
    LatchedRxStartFrm <=#Tp 1;
  else
  if(SyncRxStartFrm)
    LatchedRxStartFrm <=#Tp 0;
end


always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    SyncRxStartFrm <=#Tp 0;
  else
  if(LatchedRxStartFrm)
    SyncRxStartFrm <=#Tp 1;
  else
    SyncRxStartFrm <=#Tp 0;
end


always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    SyncRxStartFrm_q <=#Tp 0;
  else
    SyncRxStartFrm_q <=#Tp SyncRxStartFrm;
end


assign RxFifoReset = SyncRxStartFrm & ~SyncRxStartFrm_q;


eth_fifo #(`RX_FIFO_DATA_WIDTH, `RX_FIFO_DEPTH, `RX_FIFO_CNT_WIDTH)
rx_fifo (.data_in(RxDataLatched2),                      .data_out(m_wb_dat_o), 
         .clk(WB_CLK_I),                                .reset(Reset), 
         .write(WriteRxDataToFifo_wb),                  .read(MasterWbRX & m_wb_ack_i), 
         .clear(RxFifoReset),                           .full(RxBufferFull), 
         .almost_full(),                                .almost_empty(RxBufferAlmostEmpty), 
         .empty(RxBufferEmpty),                         .cnt()
        );

assign WriteRxDataToMemory = ~RxBufferEmpty & (~MasterWbRX | ~RxBufferAlmostEmpty);



// Generation of the end-of-frame signal
always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    ShiftEnded_tck <=#Tp 1'b0;
  else
  if(~RxAbort & SetWriteRxDataToFifo & StartShiftWillEnd)
    ShiftEnded_tck <=#Tp 1'b1;
  else
  if(RxAbort | ShiftEndedSync_c1 & ShiftEndedSync_c2)
    ShiftEnded_tck <=#Tp 1'b0;
end

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    ShiftEndedSync1 <=#Tp 1'b0;
  else
    ShiftEndedSync1 <=#Tp ShiftEnded_tck;
end

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    ShiftEndedSync2 <=#Tp 1'b0;
  else
    ShiftEndedSync2 <=#Tp ShiftEndedSync1;
end

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    ShiftEndedSync3 <=#Tp 1'b0;
  else
  if(ShiftEndedSync1 & ~ShiftEndedSync2)
    ShiftEndedSync3 <=#Tp 1'b1;
  else
  if(ShiftEnded)
    ShiftEndedSync3 <=#Tp 1'b0;
end

// Generation of the end-of-frame signal
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    ShiftEnded <=#Tp 1'b0;
  else
  if(ShiftEndedSync3 & MasterWbRX & m_wb_ack_i & RxBufferAlmostEmpty & ~ShiftEnded)
    ShiftEnded <=#Tp 1'b1;
  else
  if(RxStatusWrite)
    ShiftEnded <=#Tp 1'b0;
end

always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    ShiftEndedSync_c1 <=#Tp 1'b0;
  else
    ShiftEndedSync_c1 <=#Tp ShiftEndedSync2;
end

always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    ShiftEndedSync_c2 <=#Tp 1'b0;
  else
    ShiftEndedSync_c2 <=#Tp ShiftEndedSync_c1;
end

// Generation of the end-of-frame signal
always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    RxEnableWindow <=#Tp 1'b0;
  else
  if(RxStartFrm)
    RxEnableWindow <=#Tp 1'b1;
  else
  if(RxEndFrm | RxAbort)
    RxEnableWindow <=#Tp 1'b0;
end


always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    RxAbortSync1 <=#Tp 1'b0;
  else
    RxAbortSync1 <=#Tp RxAbort;
end

always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    RxAbortSync2 <=#Tp 1'b0;
  else
    RxAbortSync2 <=#Tp RxAbortSync1;
end

always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    RxAbortSyncb1 <=#Tp 1'b0;
  else
    RxAbortSyncb1 <=#Tp RxAbortSync2;
end

always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    RxAbortSyncb2 <=#Tp 1'b0;
  else
    RxAbortSyncb2 <=#Tp RxAbortSyncb1;
end


always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    RxAbortLatched <=#Tp 1'b0;
  else
  if(RxAbort)
    RxAbortLatched <=#Tp 1'b1;
  else
  if(RxStartFrm)
    RxAbortLatched <=#Tp 1'b0;
end


reg LoadStatusBlocked;

always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    LoadStatusBlocked <=#Tp 1'b0;
  else
  if(LoadRxStatus & ~RxAbortLatched)
    LoadStatusBlocked <=#Tp 1'b1;
  else
  if(RxStatusWrite_rck | RxStartFrm)
    LoadStatusBlocked <=#Tp 1'b0;
end

// LatchedRxLength[15:0]
always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    LatchedRxLength[15:0] <=#Tp 16'h0;
  else
  if(LoadRxStatus & ~RxAbortLatched & ~LoadStatusBlocked)
    LatchedRxLength[15:0] <=#Tp RxLength[15:0];
end


assign RxStatusIn = {RxOverrun, InvalidSymbol, DribbleNibble, ReceivedPacketTooBig, ShortFrame, LatchedCrcError, RxLateCollision};

always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    RxStatusInLatched <=#Tp 'h0;
  else
  if(LoadRxStatus & ~RxAbortLatched & ~LoadStatusBlocked)
    RxStatusInLatched <=#Tp RxStatusIn;
end


// Rx overrun
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    RxOverrun <=#Tp 1'b0;
  else
  if(RxStatusWrite)
    RxOverrun <=#Tp 1'b0;
  else
  if(RxBufferFull & WriteRxDataToFifo_wb)
    RxOverrun <=#Tp 1'b1;
end



wire TxError;
assign TxError = TxUnderRun | RetryLimit | LateCollLatched | CarrierSenseLost;

wire RxError;
assign RxError = |RxStatusInLatched[6:0];

// Tx Done Interrupt
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxB_IRQ <=#Tp 1'b0;
  else
  if(TxStatusWrite & TxIRQEn)
    TxB_IRQ <=#Tp ~TxError;
  else
    TxB_IRQ <=#Tp 1'b0;
end


// Tx Error Interrupt
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    TxE_IRQ <=#Tp 1'b0;
  else
  if(TxStatusWrite & TxIRQEn)
    TxE_IRQ <=#Tp TxError;
  else
    TxE_IRQ <=#Tp 1'b0;
end


// Rx Done Interrupt
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    RxB_IRQ <=#Tp 1'b0;
  else
  if(RxStatusWrite & RxIRQEn)
    RxB_IRQ <=#Tp ReceivedPacketGood;
  else
    RxB_IRQ <=#Tp 1'b0;
end


// Rx Error Interrupt
always @ (posedge WB_CLK_I or posedge Reset)
begin
  if(Reset)
    RxE_IRQ <=#Tp 1'b0;
  else
  if(RxStatusWrite & RxIRQEn)
    RxE_IRQ <=#Tp RxError;
  else
    RxE_IRQ <=#Tp 1'b0;
end


assign RxC_IRQ = 1'b0;
assign TxC_IRQ = 1'b0;
assign Busy_IRQ = 1'b0;




         
// TX
// bit 15 ready
// bit 14 interrupt
// bit 13 wrap
// bit 12 pad
// bit 11 crc
// bit 10 last
// bit 9  pause request (control frame)
// bit 8  TxUnderRun          
// bit 7-4 RetryCntLatched    
// bit 3  retransmittion limit
// bit 2  LateCollLatched        
// bit 1  DeferLatched        
// bit 0  CarrierSenseLost    


// RX
// bit 15 od rx je empty
// bit 14 od rx je interrupt
// bit 13 od rx je wrap
// bit 12 od rx je reserved
// bit 11 od rx je reserved
// bit 10 od rx je reserved
// bit 9  od rx je reserved
// bit 8  od rx je reserved
// bit 7  od rx je Miss
// bit 6  od rx je RxOverrun
// bit 5  od rx je InvalidSymbol
// bit 4  od rx je DribbleNibble
// bit 3  od rx je ReceivedPacketTooBig
// bit 2  od rx je ShortFrame
// bit 1  od rx je LatchedCrcError
// bit 0  od rx je RxLateCollision



endmodule


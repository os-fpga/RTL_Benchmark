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
//   Checked In : $Date: 2011-12-30 10:51:05 +0000 (Fri, 30 Dec 2011) $
//   Revision   : $Revision: 196368 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------
//Constants
localparam [31:0] JTAG_DEVICE_ID      = 32'h0BA01477;    //JTAG IDCODE
localparam [31:0] JTAG_DPIDR_REG_VAL  = 32'h0BC11477;    //DP DPIDR

//JTAG State Machine
// - The encodings have been designed to give the lowest area implementation
localparam [3:0] JTAG_TLR  = 4'b1111;   //Test Logic Reset
localparam [3:0] JTAG_RTI  = 4'b1100;   //Run-Test/Idle
localparam [3:0] JTAG_SDS  = 4'b0111;   //Select-DR-Scan
localparam [3:0] JTAG_CDR  = 4'b0110;   //Capture-DR
localparam [3:0] JTAG_SDR  = 4'b0010;   //Shift-DR
localparam [3:0] JTAG_E1D  = 4'b0001;   //Exit1-DR
localparam [3:0] JTAG_PDR  = 4'b0011;   //Pause-DR
localparam [3:0] JTAG_E2D  = 4'b0000;   //Exit2-DR
localparam [3:0] JTAG_UDR  = 4'b0101;   //Update-DR
localparam [3:0] JTAG_SIS  = 4'b0100;   //Select-IR-Scan
localparam [3:0] JTAG_CIR  = 4'b1110;   //Capture-IR
localparam [3:0] JTAG_SIR  = 4'b1010;   //Shift-IR
localparam [3:0] JTAG_E1I  = 4'b1001;   //Exit1-IR
localparam [3:0] JTAG_PIR  = 4'b1011;   //Pause-IR
localparam [3:0] JTAG_E2I  = 4'b1000;   //Exit2-IR
localparam [3:0] JTAG_UIR  = 4'b1101;   //Update-IR

//JTAG Instruction Set
//NB - These 4 bit op-codes are encoded into three bits and stored in
//a 3 bit register to save area
localparam [3:0] JTAG_ABORT  = 4'b1000;   //Selects Abort Scan Chain
localparam [3:0] JTAG_DPACC  = 4'b1010;   //Selects DP Scan Chain
localparam [3:0] JTAG_APACC  = 4'b1011;   //Selects AP Scan Chain
localparam [3:0] JTAG_IDCODE = 4'b1110;   //Selects IDCODE Scan Chain
localparam [3:0] JTAG_BYPASS = 4'b1111;   //Selects Bypass Scan Chain

localparam [3:0] JTAG_UNSUP0 = 4'b0000;   //Unsupported op-codes Bypass Scan Chain
localparam [3:0] JTAG_UNSUP1 = 4'b0001;
localparam [3:0] JTAG_UNSUP2 = 4'b0010;
localparam [3:0] JTAG_UNSUP3 = 4'b0011;
localparam [3:0] JTAG_UNSUP4 = 4'b0100;
localparam [3:0] JTAG_UNSUP5 = 4'b0101;
localparam [3:0] JTAG_UNSUP6 = 4'b0110;
localparam [3:0] JTAG_UNSUP7 = 4'b0111;
localparam [3:0] JTAG_UNSUP9 = 4'b1001;
localparam [3:0] JTAG_UNSUPC = 4'b1100;
localparam [3:0] JTAG_UNSUPD = 4'b1101;

//3 Bit Encoded JTAG Instruction Set
//These are the JTAG instructions with the top bit removed.
//NB - Encodings MUST NOT be changed for correct DP function
localparam [2:0] JTAG_3_ABORT  = 3'b000;  // 3 Bit Encoded ABORT Instruction Opcode
localparam [2:0] JTAG_3_DPACC  = 3'b010;  // 3 Bit Encoded DPACC Instruction Opcode
localparam [2:0] JTAG_3_APACC  = 3'b011;  // 3 Bit Encoded APACC Instruction Opcode
localparam [2:0] JTAG_3_IDCODE = 3'b110;  // 3 Bit Encoded IDCODE Instruction Opcode
localparam [2:0] JTAG_3_BYPASS = 3'b111;  // 3 Bit Encoded BYPASS Instruction Opcode

//DP Registers
localparam [1:0] JTAG_REGADDR_DPIDR    = 2'b00; //DP ID Register (on Reads)
localparam [1:0] JTAG_REGADDR_ABORT    = 2'b00; //DP Abort Register (on Writes)
localparam [1:0] JTAG_REGADDR_DPBANK   = 2'b01; //DP Banked Registers
localparam [1:0] JTAG_REGADDR_SELECT   = 2'b10; //AP Select Register
localparam [1:0] JTAG_REGADDR_RDBUFF   = 2'b11; //Read Buffer

//DP Banksel Decode
localparam [1:0] JTAG_DPBANK_CTRLSTAT  = 2'b00;
localparam [1:0] JTAG_DPBANK_EVSTAT    = 2'b10;
localparam [1:0] JTAG_DPBANK_RESERVED  = 2'b11;

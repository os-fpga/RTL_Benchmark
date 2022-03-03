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

// Constants
localparam [31:0] SW_DPIDR_REG_VAL1 = 32'h0BC11477; // DP Architecture 1
localparam [31:0] SW_DPIDR_REG_VAL2 = 32'h0BC12477; // DP Architecture 2

// SW State Machine Defs
// State encodings on adjacent lines rely on sequential encoding
// by using an incrementer for the low order 6 bits by default
//
// Top 3 bits are encoded as:
// 000 - normal operation
// 001 - line reset detection
// 010 - dormant state entry detection
// 011 - unused
// 10x - dormant state exit detection (bit 6 is part of lfsr)
// 110 - unused
// 111 - unused
//
// This encoding allows all states for Serial Wire protocol 1
// to be encoded with the top two bits as 2'b00 to minimise area
//
// All unused states should go to line reset detection to maximise the
// chance of being able to continue operation in the unlikely event
// that inputs sampling results in metastability

// Top
localparam [8:0] SW_ST_DATAPARITY  = 9'b000000000;
localparam [8:0] SW_ST_ENDTRN0     = 9'b000000001;
localparam [8:0] SW_ST_ENDTRN1     = 9'b000000010;
localparam [8:0] SW_ST_START       = 9'b000000011;
localparam [8:0] SW_ST_APnDP       = 9'b000000100;
localparam [8:0] SW_ST_RnW         = 9'b000000101;
localparam [8:0] SW_ST_A0          = 9'b000000110;
localparam [8:0] SW_ST_A1          = 9'b000000111;
localparam [8:0] SW_ST_PARITY      = 9'b000001000;
localparam [8:0] SW_ST_STOP        = 9'b000001001;
localparam [8:0] SW_ST_PARK        = 9'b000001010;
localparam [8:0] SW_ST_ACK0        = 9'b000001011;
localparam [8:0] SW_ST_ACK1        = 9'b000001100;
localparam [8:0] SW_ST_ACK2        = 9'b000001101;
localparam [8:0] SW_ST_ACKTRN0     = 9'b000001110;
localparam [8:0] SW_ST_ACKTRN1     = 9'b000001111;

localparam [8:0] SW_ST_UNUSED0     = 9'b000010000;
localparam [8:0] SW_ST_UNUSED1     = 9'b000010001;
localparam [8:0] SW_ST_UNUSED2     = 9'b000010010;

// Encodings should only differ by 1 bit from SW_ST_START etc.
localparam [8:0] SW_ST_RST_START   = 9'b000010011;
localparam [8:0] SW_ST_RST_APnDP   = 9'b000010100;
localparam [8:0] SW_ST_RST_RnW     = 9'b000010101;
localparam [8:0] SW_ST_RST_A0      = 9'b000010110;
localparam [8:0] SW_ST_RST_A1      = 9'b000010111;
localparam [8:0] SW_ST_RST_PARITY  = 9'b000011000;

localparam [8:0] SW_ST_UNUSED3     = 9'b000011001;
localparam [8:0] SW_ST_UNUSED4     = 9'b000011010;

// Encodings should only differ by 1 bit from SW_ST_ACK0-3 - see below
localparam [8:0] SW_ST_ACK0_NODAT  = 9'b000011011;
localparam [8:0] SW_ST_ACK1_NODAT  = 9'b000011100;
localparam [8:0] SW_ST_ACK2_NODAT  = 9'b000011101;

localparam [8:0] SW_ST_UNUSED5     = 9'b000011110;
localparam [8:0] SW_ST_UNUSED6     = 9'b000011111;

localparam [8:0] SW_ST_DATA0       = 9'b000100000;
localparam [8:0] SW_ST_DATA1       = 9'b000100001;
localparam [8:0] SW_ST_DATA2       = 9'b000100010;
localparam [8:0] SW_ST_DATA3       = 9'b000100011;
localparam [8:0] SW_ST_DATA4       = 9'b000100100;
localparam [8:0] SW_ST_DATA5       = 9'b000100101;
localparam [8:0] SW_ST_DATA6       = 9'b000100110;
localparam [8:0] SW_ST_DATA7       = 9'b000100111;
localparam [8:0] SW_ST_DATA8       = 9'b000101000;
localparam [8:0] SW_ST_DATA9       = 9'b000101001;
localparam [8:0] SW_ST_DATA10      = 9'b000101010;
localparam [8:0] SW_ST_DATA11      = 9'b000101011;
localparam [8:0] SW_ST_DATA12      = 9'b000101100;
localparam [8:0] SW_ST_DATA13      = 9'b000101101;
localparam [8:0] SW_ST_DATA14      = 9'b000101110;
localparam [8:0] SW_ST_DATA15      = 9'b000101111;
localparam [8:0] SW_ST_DATA16      = 9'b000110000;
localparam [8:0] SW_ST_DATA17      = 9'b000110001;
localparam [8:0] SW_ST_DATA18      = 9'b000110010;
localparam [8:0] SW_ST_DATA19      = 9'b000110011;
localparam [8:0] SW_ST_DATA20      = 9'b000110100;
localparam [8:0] SW_ST_DATA21      = 9'b000110101;
localparam [8:0] SW_ST_DATA22      = 9'b000110110;
localparam [8:0] SW_ST_DATA23      = 9'b000110111;
localparam [8:0] SW_ST_DATA24      = 9'b000111000;
localparam [8:0] SW_ST_DATA25      = 9'b000111001;
localparam [8:0] SW_ST_DATA26      = 9'b000111010;
localparam [8:0] SW_ST_DATA27      = 9'b000111011;
localparam [8:0] SW_ST_DATA28      = 9'b000111100;
localparam [8:0] SW_ST_DATA29      = 9'b000111101;
localparam [8:0] SW_ST_DATA30      = 9'b000111110;
localparam [8:0] SW_ST_DATA31      = 9'b000111111;

localparam [8:0] SW_ST_RST_0       = 9'b001000000;
localparam [8:0] SW_ST_RST_1       = 9'b001000001;
localparam [8:0] SW_ST_RST_2       = 9'b001000010;
localparam [8:0] SW_ST_RST_3       = 9'b001000011;
localparam [8:0] SW_ST_RST_4       = 9'b001000100;
localparam [8:0] SW_ST_RST_5       = 9'b001000101;
localparam [8:0] SW_ST_RST_6       = 9'b001000110;
localparam [8:0] SW_ST_RST_7       = 9'b001000111;
localparam [8:0] SW_ST_RST_8       = 9'b001001000;
localparam [8:0] SW_ST_RST_9       = 9'b001001001;
localparam [8:0] SW_ST_RST_10      = 9'b001001010;
localparam [8:0] SW_ST_RST_11      = 9'b001001011;
localparam [8:0] SW_ST_RST_12      = 9'b001001100;
localparam [8:0] SW_ST_RST_13      = 9'b001001101;
localparam [8:0] SW_ST_RST_14      = 9'b001001110;
localparam [8:0] SW_ST_RST_15      = 9'b001001111;
localparam [8:0] SW_ST_RST_16      = 9'b001010000;
localparam [8:0] SW_ST_RST_17      = 9'b001010001;
localparam [8:0] SW_ST_RST_18      = 9'b001010010;
localparam [8:0] SW_ST_RST_19      = 9'b001010011;
localparam [8:0] SW_ST_RST_20      = 9'b001010100;
localparam [8:0] SW_ST_RST_21      = 9'b001010101;
localparam [8:0] SW_ST_RST_22      = 9'b001010110;
localparam [8:0] SW_ST_RST_23      = 9'b001010111;
localparam [8:0] SW_ST_RST_24      = 9'b001011000;
localparam [8:0] SW_ST_RST_25      = 9'b001011001;
localparam [8:0] SW_ST_RST_26      = 9'b001011010;
localparam [8:0] SW_ST_RST_27      = 9'b001011011;
localparam [8:0] SW_ST_RST_28      = 9'b001011100;
localparam [8:0] SW_ST_RST_29      = 9'b001011101;
localparam [8:0] SW_ST_RST_30      = 9'b001011110;
localparam [8:0] SW_ST_RST_31      = 9'b001011111;
localparam [8:0] SW_ST_RST_32      = 9'b001100000;
localparam [8:0] SW_ST_RST_33      = 9'b001100001;
localparam [8:0] SW_ST_RST_34      = 9'b001100010;
localparam [8:0] SW_ST_RST_35      = 9'b001100011;
localparam [8:0] SW_ST_RST_36      = 9'b001100100;
localparam [8:0] SW_ST_RST_37      = 9'b001100101;
localparam [8:0] SW_ST_RST_38      = 9'b001100110;
localparam [8:0] SW_ST_RST_39      = 9'b001100111;
localparam [8:0] SW_ST_RST_40      = 9'b001101000;
localparam [8:0] SW_ST_RST_41      = 9'b001101001;
localparam [8:0] SW_ST_RST_42      = 9'b001101010;
localparam [8:0] SW_ST_RST_43      = 9'b001101011;
localparam [8:0] SW_ST_RST_44      = 9'b001101100;
localparam [8:0] SW_ST_RST_45      = 9'b001101101;
localparam [8:0] SW_ST_RST_46      = 9'b001101110;
localparam [8:0] SW_ST_RST_47      = 9'b001101111;
localparam [8:0] SW_ST_RST_48      = 9'b001110000;
localparam [8:0] SW_ST_RST_49      = 9'b001110001;
localparam [8:0] SW_ST_RST_50      = 9'b001110010;

// Dormant State Entry sequence recognition
localparam [8:0] SW_ST_DENT_0      = 9'b010000000;
localparam [8:0] SW_ST_DENT_1      = 9'b010000001; // START
localparam [8:0] SW_ST_DENT_2      = 9'b010000010; // APnDP
localparam [8:0] SW_ST_DENT_3      = 9'b010000011;
localparam [8:0] SW_ST_DENT_4      = 9'b010000100;
localparam [8:0] SW_ST_DENT_5      = 9'b010000101;
localparam [8:0] SW_ST_DENT_6      = 9'b010000110;
localparam [8:0] SW_ST_DENT_7      = 9'b010000111;
localparam [8:0] SW_ST_DENT_8      = 9'b010001000;
localparam [8:0] SW_ST_DENT_9      = 9'b010001001;
localparam [8:0] SW_ST_DENT_A      = 9'b010001010;
localparam [8:0] SW_ST_DENT_B      = 9'b010001011;
localparam [8:0] SW_ST_DENT_C      = 9'b010001100;
localparam [8:0] SW_ST_DENT_D      = 9'b010001101;
localparam [8:0] SW_ST_DENT_E      = 9'b010001110;

localparam [8:0] SW_ST_UNUSED8     = 9'b010001111;
localparam [8:0] SW_ST_UNUSED9     = 9'b010010000;
localparam [8:0] SW_ST_UNUSED10    = 9'b010010001;
localparam [8:0] SW_ST_UNUSED11    = 9'b010010010;
localparam [8:0] SW_ST_UNUSED12    = 9'b010010011;
localparam [8:0] SW_ST_UNUSED13    = 9'b010010100;

// Selection Alert sequence SWDI low period
localparam [8:0] SW_ST_ALRT0_0     = 9'b010010101;
localparam [8:0] SW_ST_ALRT0_1     = 9'b010010110;
localparam [8:0] SW_ST_ALRT0_2     = 9'b010010111;
// Dormant State Serial Wire Activation sequence
localparam [8:0] SW_ST_SWACT_0     = 9'b010011000;
localparam [8:0] SW_ST_SWACT_1     = 9'b010011001;
localparam [8:0] SW_ST_SWACT_2     = 9'b010011010;
localparam [8:0] SW_ST_SWACT_3     = 9'b010011011;
localparam [8:0] SW_ST_SWACT_4     = 9'b010011100;
localparam [8:0] SW_ST_SWACT_5     = 9'b010011101;
localparam [8:0] SW_ST_SWACT_6     = 9'b010011110;
localparam [8:0] SW_ST_SWACT_7     = 9'b010011111;

// Dormant activation lfsr states
// Use 0 encoding (not used by lfsr) as initial state
localparam [8:0] SW_ST_DLFSR_WAIT  = 9'b100000000;
localparam [8:0] SW_ST_DLFSR_START = 9'b101001001;
localparam [8:0] SW_ST_DLFSR_END   = 9'b100010010;

// Mask to optimise check for ACK states with or without data phase
localparam [8:0] SW_ST_ACK_MASK    = 9'b111101111;

// Mask to optimise check for HDR states with or without reset
localparam [8:0] SW_ST_HDR_MASK    = 9'b111101111;

//Register Addresses
localparam [1:0] SW_REGADDR_DPIDR     = 2'b00;
localparam [1:0] SW_REGADDR_ABORT     = 2'b00;
localparam [1:0] SW_REGADDR_DPBANK    = 2'b01;
localparam [1:0] SW_REGADDR_RESEND    = 2'b10;
localparam [1:0] SW_REGADDR_SELECT    = 2'b10;
localparam [1:0] SW_REGADDR_RDBUFF    = 2'b11;
localparam [1:0] SW_REGADDR_TARGETSEL = 2'b11; // Serial Wire protocol 2

//DP Banksel Decode
//Encodings chosen so DP Architecture 1 registers
//can be encoded with [0] or [1:0] bits of register
//depending on the presence of EVENTSTAT
localparam [2:0] SW_DPBANK_CTRLSTAT  = 3'b000;
localparam [2:0] SW_DPBANK_DLCR      = 3'b001;
localparam [2:0] SW_DPBANK_TARGETID  = 3'b100;
localparam [2:0] SW_DPBANK_DLPIDR    = 3'b101;
localparam [2:0] SW_DPBANK_EVSTAT    = 3'b010;
localparam [2:0] SW_DPBANK_RESERVED  = 3'b011;

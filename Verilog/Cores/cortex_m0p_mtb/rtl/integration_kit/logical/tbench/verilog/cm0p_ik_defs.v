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
//      Checked In          : $Date: 2012-08-31 12:34:14 +0100 (Fri, 31 Aug 2012) $
//
//      Revision            : $Revision: 220755 $
//
//      Release Information : Cortex-M0+ AT590-r0p1-00rel0
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//      Cortex-M0+ Integration Kit Definitions file
//-----------------------------------------------------------------------------

//
// Integration Kit configuration defines
//

// I/O Port Interface - default value: 0
// Integration Kit supports the Cortex-M0+ I/O Port if
// this define is set
`define  ARM_CM0PIK_IOP 0

// Micro Trace Buffer - default value: 0
// Integration Kit supports the CoreSight MTB-M0+ if
// this define is set
`define  ARM_CM0PIK_MTB 0

// Micro Trace Buffer address width - default value: 12
// Integration Kit's AHB Interconnect supports upto 4KB
// of CoreSight MTB-M0+ SRAM (min 5, max 12). For larger SRAM
// sizes the AHB Interconnect needs to be modified
`define  ARM_CM0PIK_MTBAWIDTH 12

// DAP ROM Table Base Address
//   32'hF0100003 = System Level ROM Table (default)
//   32'hE00FF003 = Cortex-M0+ ROM Table
`define  ARM_CM0PIK_BASEADDR  32'hF0100003

// Endianness of processor in MCU and Debug Driver system - default value: 0 (LE)
`define  ARM_CM0PIK_BE  0

//
// Implementation level pin configuration defines
//

// STCALIB value for 50Mhz SCLK: ((50MHz x 10ms)/3 - 1) = 166666 (with skew) = 0x1028B0A
`define  ARM_CM0PIK_STCALIB 26'h1028B0A

// Interrupt Latency - 9 cycles
`define  ARM_CM0PIK_IRQLATENCY 8'h9

// INSTANCEID for DAP
`define  ARM_CM0PIK_INSTANCEID 4'h0

//
// Testbench defines
//

// Primary clock cycle (in ns) 50 MHz
`define  ARM_CM0PIK_CLK_PERIOD 20.0

// Power-On-Reset assertion factor - 3 cycles
`define  ARM_CM0PIK_POR_CYCLES 3

// Simulation Runaway Time Out factor - 2 million cycles
`define  ARM_CM0PIK_TIMEOUT_CYCLES 2000000

// Power-On-Reset assertion time
`define  ARM_CM0PIK_POR_LENGTH  (`ARM_CM0PIK_POR_CYCLES*`ARM_CM0PIK_CLK_PERIOD)

// Timeout
`define  ARM_CM0PIK_SIM_TIMEOUT (`ARM_CM0PIK_TIMEOUT_CYCLES*`ARM_CM0PIK_CLK_PERIOD)

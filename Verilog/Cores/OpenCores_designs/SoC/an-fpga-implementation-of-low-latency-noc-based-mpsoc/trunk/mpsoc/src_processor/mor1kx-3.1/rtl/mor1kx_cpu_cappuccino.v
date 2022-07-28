/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: "Cappuccino" pipeline CPU module

  Copyright (C) 2012 Authors

   Author(s): Julius Baxter <juliusbaxter@gmail.com>

***************************************************************************** */

 `timescale     1ns/1ps
/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: mor1kx defines

  Copyright (C) 2012 Authors

  Author(s): Julius Baxter <juliusbaxter@gmail.com>

***************************************************************************** */



/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: SPR definitions

  Copyright (C) 2012 Authors

  Author(s): Julius Baxter <juliusbaxter@gmail.com>

***************************************************************************** */
`define SPR_BASE(x)   (x/(2**11))
`define SPR_OFFSET(x) (x%(2**11))

//
// Addresses
//
`define OR1K_SPR_SYS_BASE       {5'd0}
`define OR1K_SPR_VR_ADDR        {5'd0,11'd0}
`define OR1K_SPR_UPR_ADDR       {5'd0,11'd1}
`define OR1K_SPR_CPUCFGR_ADDR   {5'd0,11'd2}
`define OR1K_SPR_DMMUCFGR_ADDR  {5'd0,11'd3}
`define OR1K_SPR_IMMUCFGR_ADDR  {5'd0,11'd4}
`define OR1K_SPR_DCCFGR_ADDR    {5'd0,11'd5}
`define OR1K_SPR_ICCFGR_ADDR    {5'd0,11'd6}
`define OR1K_SPR_DCFGR_ADDR     {5'd0,11'd7}
`define OR1K_SPR_PCCFGR_ADDR    {5'd0,11'd8}
`define OR1K_SPR_VR2_ADDR       {5'd0,11'd9}
`define OR1K_SPR_AVR_ADDR       {5'd0,11'd10}
`define OR1K_SPR_EVBAR_ADDR     {5'd0,11'd11}
`define OR1K_SPR_AECR_ADDR      {5'd0,11'd12}
`define OR1K_SPR_AESR_ADDR      {5'd0,11'd13}
`define OR1K_SPR_NPC_ADDR       {5'd0,11'd16}
`define OR1K_SPR_SR_ADDR        {5'd0,11'd17}
`define OR1K_SPR_PPC_ADDR       {5'd0,11'd18}
`define OR1K_SPR_FPCSR_ADDR     {5'd0,11'd20}
`define OR1K_SPR_ISR0_ADDR      {5'd0,11'd21}
`define OR1K_SPR_EPCR0_ADDR     {5'd0,11'd32}
`define OR1K_SPR_EEAR0_ADDR     {5'd0,11'd48}
`define OR1K_SPR_ESR0_ADDR      {5'd0,11'd64}
`define OR1K_SPR_COREID_ADDR    {5'd0,11'd128}
`define OR1K_SPR_NUMCORES_ADDR  {5'd0,11'd129}
`define OR1K_SPR_GPR0_ADDR      {5'd0,11'd1024}

`define OR1K_SPR_DMMU_BASE      {5'd1}
`define OR1K_SPR_DMMUCR_ADDR    {5'd1,11'd0}
`define OR1K_SPR_DMMUPR_ADDR    {5'd1,11'd1}
`define OR1K_SPR_DTLBEIR_ADDR   {5'd1,11'd2}
`define OR1K_SPR_DATBMR0_ADDR   {5'd1,11'd4}
`define OR1K_SPR_DATBTR0_ADDR   {5'd1,11'd8}
`define OR1K_SPR_DTLBW0MR0_ADDR {5'd1,11'd512}
`define OR1K_SPR_DTLBW0TR0_ADDR {5'd1,11'd640}
`define OR1K_SPR_DTLBW1MR0_ADDR {5'd1,11'd768}
`define OR1K_SPR_DTLBW1TR0_ADDR {5'd1,11'd896}
`define OR1K_SPR_DTLBW2MR0_ADDR {5'd1,11'd1024}
`define OR1K_SPR_DTLBW2TR0_ADDR {5'd1,11'd1152}
`define OR1K_SPR_DTLBW3MR0_ADDR {5'd1,11'd1280}
`define OR1K_SPR_DTLBW3TR0_ADDR {5'd1,11'd1408}

`define OR1K_SPR_IMMU_BASE      {5'd2}
`define OR1K_SPR_IMMUCR_ADDR    {5'd2,11'd0}
`define OR1K_SPR_IMMUPR_ADDR    {5'd2,11'd1}
`define OR1K_SPR_ITLBEIR_ADDR   {5'd2,11'd2}
`define OR1K_SPR_IATBMR0_ADDR   {5'd2,11'd4}
`define OR1K_SPR_IATBTR0_ADDR   {5'd2,11'd8}
`define OR1K_SPR_ITLBW0MR0_ADDR {5'd2,11'd512}
`define OR1K_SPR_ITLBW0TR0_ADDR {5'd2,11'd640}
`define OR1K_SPR_ITLBW1MR0_ADDR {5'd2,11'd768}
`define OR1K_SPR_ITLBW1TR0_ADDR {5'd2,11'd896}
`define OR1K_SPR_ITLBW2MR0_ADDR {5'd2,11'd1024}
`define OR1K_SPR_ITLBW2TR0_ADDR {5'd2,11'd1152}
`define OR1K_SPR_ITLBW3MR0_ADDR {5'd2,11'd1280}
`define OR1K_SPR_ITLBW3TR0_ADDR {5'd2,11'd1408}

`define OR1K_SPR_DC_BASE        {5'd3}
`define OR1K_SPR_DCCR_ADDR      {5'd3,11'd0}
`define OR1K_SPR_DCBPR_ADDR     {5'd3,11'd1}
`define OR1K_SPR_DCBFR_ADDR     {5'd3,11'd2}
`define OR1K_SPR_DCBIR_ADDR     {5'd3,11'd3}
`define OR1K_SPR_DCBWR_ADDR     {5'd3,11'd4}
`define OR1K_SPR_DCBLR_ADDR     {5'd3,11'd5}

`define OR1K_SPR_IC_BASE        {5'd4}
`define OR1K_SPR_ICCR_ADDR      {5'd4,11'd0}
`define OR1K_SPR_ICBPR_ADDR     {5'd4,11'd1}
`define OR1K_SPR_ICBIR_ADDR     {5'd4,11'd2}
`define OR1K_SPR_ICBLR_ADDR     {5'd4,11'd3}

`define OR1K_SPR_MAC_BASE       {5'd5}
`define OR1K_SPR_MACLO_ADDR     {5'd5,11'd1}
`define OR1K_SPR_MACHI_ADDR     {5'd5,11'd2}

`define OR1K_SPR_DU_BASE        {5'd6}
`define OR1K_SPR_DVR0_ADDR      {5'd6,11'd0}
`define OR1K_SPR_DCR0_ADDR      {5'd6,11'd8}
`define OR1K_SPR_DMR1_ADDR      {5'd6,11'd16}
`define OR1K_SPR_DMR2_ADDR      {5'd6,11'd17}
`define OR1K_SPR_DCWR0_ADDR     {5'd6,11'd18}
`define OR1K_SPR_DSR_ADDR       {5'd6,11'd20}
`define OR1K_SPR_DRR_ADDR       {5'd6,11'd21}

`define OR1K_SPR_PC_BASE        {5'd7}
`define OR1K_SPR_PCCR0_ADDR     {5'd7,11'd0}
`define OR1K_SPR_PCMR0_ADDR     {5'd7,11'd8}

`define OR1K_SPR_PM_BASE        {5'd8}
`define OR1K_SPR_PMR_ADDR       {5'd8,11'd0}

`define OR1K_SPR_PIC_BASE       {5'd9}
`define OR1K_SPR_PICMR_ADDR     {5'd9,11'd0}
`define OR1K_SPR_PICSR_ADDR     {5'd9,11'd2}

`define OR1K_SPR_TT_BASE        {5'd10}
`define OR1K_SPR_TTMR_ADDR      {5'd10,11'd0}
`define OR1K_SPR_TTCR_ADDR      {5'd10,11'd1}

`define OR1K_SPR_FPU_BASE       {5'd11}

//
// Register bit defines
//

// Supervision Register
`define OR1K_SPR_SR_SM     0  /* Supervisor mode */
`define OR1K_SPR_SR_TEE    1  /* Timer exception enable */
`define OR1K_SPR_SR_IEE    2  /* Interrupt exception enable */
`define OR1K_SPR_SR_DCE    3  /* Data cache enable */
`define OR1K_SPR_SR_ICE    4  /* Instruction cache enable */
`define OR1K_SPR_SR_DME    5  /* Data MMU enable */
`define OR1K_SPR_SR_IME    6  /* Instruction MMU enable */
`define OR1K_SPR_SR_LEE    7  /* Little-endian enable */
`define OR1K_SPR_SR_CE     8  /* CID enable */
`define OR1K_SPR_SR_F      9  /* Flag */
`define OR1K_SPR_SR_CY    10  /* Carry flag */
`define OR1K_SPR_SR_OV    11  /* Overflow flag */
`define OR1K_SPR_SR_OVE   12  /* Overflow exception enable */
`define OR1K_SPR_SR_DSX   13  /* Delay slot exception */
`define OR1K_SPR_SR_EPH   14  /* Exception prefix high */
`define OR1K_SPR_SR_FO    15  /* Fixed to one */
`define OR1K_SPR_SR_SUMRA 16  /* SPR user read mode access */
`define OR1K_SPR_SR_RESERVED 27:17 /* Reserved */
`define OR1K_SPR_SR_CID      31:28 /* Context ID */

// Version register - DEPRECATED
`define OR1K_SPR_VR_REV   5:0  /* Revision */
`define OR1K_SPR_VR_UVRP  6  /* Updated Version Registers Present */
`define OR1K_SPR_VR_RESERVED 15:7 /* Reserved */
`define OR1K_SPR_VR_CFG   23:16  /* Configuration Template */
`define OR1K_SPR_VR_VER   31:24  /* Version */


// Unit Present register
`define OR1K_SPR_UPR_UP    0
`define OR1K_SPR_UPR_DCP   1
`define OR1K_SPR_UPR_ICP   2
`define OR1K_SPR_UPR_DMP   3
`define OR1K_SPR_UPR_IMP   4
`define OR1K_SPR_UPR_MP    5
`define OR1K_SPR_UPR_DUP   6
`define OR1K_SPR_UPR_PCUP  7
`define OR1K_SPR_UPR_PICP  8
`define OR1K_SPR_UPR_PMP   9
`define OR1K_SPR_UPR_TTP  10
`define OR1K_SPR_UPR_RESERVED 23:11
`define OR1K_SPR_UPR_CUP   31:24

// CPU Configuration register
`define OR1K_SPR_CPUCFGR_NSGF   3:0 /* Number of shadow GPRs */
`define OR1K_SPR_CPUCFGR_CFG    4
`define OR1K_SPR_CPUCFGR_OB32S  5
`define OR1K_SPR_CPUCFGR_OB64S  6
`define OR1K_SPR_CPUCFGR_OF32S  7
`define OR1K_SPR_CPUCFGR_OF64S  8
`define OR1K_SPR_CPUCFGR_OV64S  9
`define OR1K_SPR_CPUCFGR_ND     10 /* No delay-slot implementation */
`define OR1K_SPR_CPUCFGR_AVRP   11 /* Arch. version registers */
`define OR1K_SPR_CPUCFGR_EVBARP 12 /* Exception vector base addr reg */
`define OR1K_SPR_CPUCFGR_ISRP   13 /* Implementation specific regs */
`define OR1K_SPR_CPUCFGR_AECSRP 14 /* Arith. exception regs */
`define OR1K_SPR_CPUCFGR_RESERVED 31:15

// Version register 2 (new with OR1K 1.0)
`define OR1K_SPR_VR2_VER 23:0
`define OR1K_SPR_VR2_CPUID 31:24

// Architecture Version register
`define OR1K_SPR_AVR_RESERVED 7:0
`define OR1K_SPR_AVR_REV 15:8
`define OR1K_SPR_AVR_MIN 23:16
`define OR1K_SPR_AVR_MAJ 31:24

// Exception Vector Base Address register
`define OR1K_SPR_EVBAR_RESERVED 12:0
`define OR1K_SPR_EVBAR_EVBA 31:13

// Arithmetic Exception Control register
`define OR1K_SPR_AECR_CYADDE    0
`define OR1K_SPR_AECR_OVADDE    1
`define OR1K_SPR_AECR_CYMULE    2
`define OR1K_SPR_AECR_OVMULE    3
`define OR1K_SPR_AECR_DBZE      4
`define OR1K_SPR_AECR_CYMACADDE 5
`define OR1K_SPR_AECR_OVMACADDE 6
`define OR1K_SPR_AECR_RESERVED  31:7

// Arithmetic Exception Status register
`define OR1K_SPR_AESR_CYADDE    0
`define OR1K_SPR_AESR_OVADDE    1
`define OR1K_SPR_AESR_CYMULE    2
`define OR1K_SPR_AESR_OVMULE    3
`define OR1K_SPR_AESR_DBZE      4
`define OR1K_SPR_AESR_CYMACADDE 5
`define OR1K_SPR_AESR_OVMACADDE 6
`define OR1K_SPR_AESR_RESERVED  31:7

// Tick timer registers
`define OR1K_SPR_TTMR_TP   27:0 /* Time period */
`define OR1K_SPR_TTMR_IP   28   /* Interrupt pending */
`define OR1K_SPR_TTMR_IE   29   /* Interrupt enable */
`define OR1K_SPR_TTMR_M    31:30 /* Mode */
// Tick timer mode values
`define OR1K_SPR_TTMR_M_DIS 2'b00  /* Disabled */
`define OR1K_SPR_TTMR_M_RST 2'b01  /* Restart-on-match mode */
`define OR1K_SPR_TTMR_M_STP 2'b10  /* Stop-on-match mode */
`define OR1K_SPR_TTMR_M_CNT 2'b11  /* Continue counting mode */

// Data Cache Configuration register
`define OR1K_SPR_DCCFGR_NCW   2:0 /* Number of Cache Ways */
`define OR1K_SPR_DCCFGR_NCS   6:3 /* Number of Cache Sets */
`define OR1K_SPR_DCCFGR_CBS   7   /* Cache Block Size */
`define OR1K_SPR_DCCFGR_CWS   8   /* Cache Write Strategy */
`define OR1K_SPR_DCCFGR_CCRI  9   /* Cache Control Register Implemented */
`define OR1K_SPR_DCCFGR_CBIRI 10  /* Cache Block Invalidate Register Implemented */
`define OR1K_SPR_DCCFGR_CBPRI 11  /* Cache Block Prefetch Register Implemented */
`define OR1K_SPR_DCCFGR_CBLRI 12  /* Cache Block Lock Register Implemented */
`define OR1K_SPR_DCCFGR_CBFRI 13  /* Cache Block Flush Register Implemented */
`define OR1K_SPR_DCCFGR_CBWBRI 14 /* Cache Block Write-Back Register Implemented */

// Instruction Cache Configuration register
`define OR1K_SPR_ICCFGR_NCW   2:0 /* Number of Cache Ways */
`define OR1K_SPR_ICCFGR_NCS   6:3 /* Number of Cache Sets */
`define OR1K_SPR_ICCFGR_CBS   7   /* Cache Block Size */
`define OR1K_SPR_ICCFGR_CCRI  9   /* Cache Control Register Implemented */
`define OR1K_SPR_ICCFGR_CBIRI 10  /* Cache Block Invalidate Register Implemented */
`define OR1K_SPR_ICCFGR_CBPRI 11  /* Cache Block Prefetch Register Implemented */
`define OR1K_SPR_ICCFGR_CBLRI 12  /* Cache Block Lock Register Implemented */

// Data MMU Configuration register
`define OR1K_SPR_DMMUFGR_NTW   1:0 /* Number of TLB ways */
`define OR1K_SPR_DMMUFGR_NTS   4:2 /* Number of TLB sets */
`define OR1K_SPR_DMMUFGR_NAE   7:5 /* Number of ATB entries */
`define OR1K_SPR_DMMUFGR_CRI   8   /* Control Register Implemented */
`define OR1K_SPR_DMMUFGR_PRI   9   /* Protection Register Implemented */
`define OR1K_SPR_DMMUFGR_TEIRI 10  /* TLB Entry Invalidate Register Implemented */
`define OR1K_SPR_DMMUFGR_HTR   11  /* Hardware TLB Reload */

// Instruction MMU Configuration register
`define OR1K_SPR_IMMUFGR_NTW   1:0 /* Number of TLB ways */
`define OR1K_SPR_IMMUFGR_NTS   4:2 /* Number of TLB sets */
`define OR1K_SPR_IMMUFGR_NAE   7:5 /* Number of ATB entries */
`define OR1K_SPR_IMMUFGR_CRI   8   /* Control Register Implemented */
`define OR1K_SPR_IMMUFGR_PRI   9   /* Protection Register Implemented */
`define OR1K_SPR_IMMUFGR_TEIRI 10  /* TLB Entry Invalidate Register Implemented */
`define OR1K_SPR_IMMUFGR_HTR   11  /* Hardware TLB Reload */

// Debug Mode Register 1
`define OR1K_SPR_DMR1_ST 22
`define OR1K_SPR_DMR1_BT 23

// Debug Stop Register
`define OR1K_SPR_DSR_RSTE  0
`define OR1K_SPR_DSR_BUSEE 1
`define OR1K_SPR_DSR_DPFE  2
`define OR1K_SPR_DSR_IPFE  3
`define OR1K_SPR_DSR_TTE   4
`define OR1K_SPR_DSR_AE    5
`define OR1K_SPR_DSR_IIE   6
`define OR1K_SPR_DSR_INTE  7
`define OR1K_SPR_DSR_DME   8
`define OR1K_SPR_DSR_IME   9
`define OR1K_SPR_DSR_RE   10
`define OR1K_SPR_DSR_SCE  11
`define OR1K_SPR_DSR_FPE  12
`define OR1K_SPR_DSR_TE   13

`define OR1K_SPR_DRR_RSTE  0
`define OR1K_SPR_DRR_BUSEE 1
`define OR1K_SPR_DRR_DPFE  2
`define OR1K_SPR_DRR_IPFE  3
`define OR1K_SPR_DRR_TTE   4
`define OR1K_SPR_DRR_AE    5
`define OR1K_SPR_DRR_IIE   6
`define OR1K_SPR_DRR_IE    7
`define OR1K_SPR_DRR_DME   8
`define OR1K_SPR_DRR_IME   9
`define OR1K_SPR_DRR_RE   10
`define OR1K_SPR_DRR_SCE  11
`define OR1K_SPR_DRR_FPE  12
`define OR1K_SPR_DRR_TE   13

// Implementation-specific SPR defines
`define MOR1KX_SPR_SR_WIDTH 16
`define MOR1KX_SPR_SR_RESET_VALUE `MOR1KX_SPR_SR_WIDTH'h8001


/* ORBIS32 opcodes - top 6 bits */

`define OR1K_INSN_WIDTH 32

`define OR1K_RD_SELECT 25:21
`define OR1K_RA_SELECT 20:16
`define OR1K_RB_SELECT 15:11

`define OR1K_IMM_WIDTH 16
`define OR1K_IMM_SELECT 15:0

`define OR1K_ALU_OPC_WIDTH 4
`define OR1K_ALU_OPC_SELECT 3:0

`define OR1K_ALU_OPC_ADD   `OR1K_ALU_OPC_WIDTH'h0
`define OR1K_ALU_OPC_ADDC  `OR1K_ALU_OPC_WIDTH'h1
`define OR1K_ALU_OPC_SUB   `OR1K_ALU_OPC_WIDTH'h2
`define OR1K_ALU_OPC_AND   `OR1K_ALU_OPC_WIDTH'h3
`define OR1K_ALU_OPC_OR    `OR1K_ALU_OPC_WIDTH'h4
`define OR1K_ALU_OPC_XOR   `OR1K_ALU_OPC_WIDTH'h5
`define OR1K_ALU_OPC_MUL   `OR1K_ALU_OPC_WIDTH'h6
`define OR1K_ALU_OPC_RESV  `OR1K_ALU_OPC_WIDTH'h7
`define OR1K_ALU_OPC_SHRT  `OR1K_ALU_OPC_WIDTH'h8
`define OR1K_ALU_OPC_DIV   `OR1K_ALU_OPC_WIDTH'h9
`define OR1K_ALU_OPC_DIVU  `OR1K_ALU_OPC_WIDTH'ha
`define OR1K_ALU_OPC_MULU  `OR1K_ALU_OPC_WIDTH'hb
`define OR1K_ALU_OPC_EXTBH `OR1K_ALU_OPC_WIDTH'hc
`define OR1K_ALU_OPC_EXTW  `OR1K_ALU_OPC_WIDTH'hd
`define OR1K_ALU_OPC_CMOV  `OR1K_ALU_OPC_WIDTH'he
`define OR1K_ALU_OPC_FFL1  `OR1K_ALU_OPC_WIDTH'hf

`define OR1K_ALU_OPC_SECONDARY_WIDTH 3
`define OR1K_ALU_OPC_SECONDARY_SELECT 8:6

`define OR1K_ALU_OPC_SECONDARY_SHRT_SLL `OR1K_ALU_OPC_SECONDARY_WIDTH'h0
`define OR1K_ALU_OPC_SECONDARY_SHRT_SRL `OR1K_ALU_OPC_SECONDARY_WIDTH'h1
`define OR1K_ALU_OPC_SECONDARY_SHRT_SRA `OR1K_ALU_OPC_SECONDARY_WIDTH'h2
`define OR1K_ALU_OPC_SECONDARY_SHRT_ROR `OR1K_ALU_OPC_SECONDARY_WIDTH'h3

`define OR1K_COMP_OPC_WIDTH 4
`define OR1K_COMP_OPC_SELECT 24:21
`define OR1K_COMP_OPC_EQ  `OR1K_COMP_OPC_WIDTH'h0
`define OR1K_COMP_OPC_NE  `OR1K_COMP_OPC_WIDTH'h1
`define OR1K_COMP_OPC_GTU `OR1K_COMP_OPC_WIDTH'h2
`define OR1K_COMP_OPC_GEU `OR1K_COMP_OPC_WIDTH'h3
`define OR1K_COMP_OPC_LTU `OR1K_COMP_OPC_WIDTH'h4
`define OR1K_COMP_OPC_LEU `OR1K_COMP_OPC_WIDTH'h5
`define OR1K_COMP_OPC_GTS `OR1K_COMP_OPC_WIDTH'ha
`define OR1K_COMP_OPC_GES `OR1K_COMP_OPC_WIDTH'hb
`define OR1K_COMP_OPC_LTS `OR1K_COMP_OPC_WIDTH'hc
`define OR1K_COMP_OPC_LES `OR1K_COMP_OPC_WIDTH'hd

`define OR1K_JUMPBRANCH_IMMEDIATE_SELECT 25:0

`define OR1K_SYSTRAPSYNC_OPC_WIDTH 3
`define OR1K_SYSTRAPSYNC_OPC_SELECT 25:23
`define OR1K_SYSTRAPSYNC_OPC_SYSCALL `OR1K_SYSTRAPSYNC_OPC_WIDTH'h0
`define OR1K_SYSTRAPSYNC_OPC_TRAP `OR1K_SYSTRAPSYNC_OPC_WIDTH'h2
`define OR1K_SYSTRAPSYNC_OPC_MSYNC `OR1K_SYSTRAPSYNC_OPC_WIDTH'h4
`define OR1K_SYSTRAPSYNC_OPC_PSYNC `OR1K_SYSTRAPSYNC_OPC_WIDTH'h5
`define OR1K_SYSTRAPSYNC_OPC_CSYNC `OR1K_SYSTRAPSYNC_OPC_WIDTH'h6

`define OR1K_OPCODE_WIDTH 6
`define OR1K_OPCODE_SELECT 31:26

`define OR1K_OPCODE_J       {2'b00, 4'h0}
`define OR1K_OPCODE_JAL     {2'b00, 4'h1}
`define OR1K_OPCODE_BNF     {2'b00, 4'h3}
`define OR1K_OPCODE_BF      {2'b00, 4'h4}
`define OR1K_OPCODE_NOP     {2'b00, 4'h5}
`define OR1K_OPCODE_MOVHI   {2'b00, 4'h6}
`define OR1K_OPCODE_MACRC   {2'b00, 4'h6}

/*
`define OR1K_OPCODE_SYS     {2'b00, 4'h8}
`define OR1K_OPCODE_TRAP    {2'b00, 4'h8}
`define OR1K_OPCODE_MSYNC   {2'b00, 4'h8}
`define OR1K_OPCODE_PSYNC   {2'b00, 4'h8}
`define OR1K_OPCODE_CSYNC   {2'b00, 4'h8}
 */
`define OR1K_OPCODE_SYSTRAPSYNC {2'b00, 4'h8}
`define OR1K_OPCODE_RFE     {2'b00, 4'h9}

`define OR1K_OPCODE_JR      {2'b01, 4'h1}
`define OR1K_OPCODE_JALR    {2'b01, 4'h2}
`define OR1K_OPCODE_MACI    {2'b01, 4'h3}
`define OR1K_OPCODE_LWA     {2'b01, 4'hB}
`define OR1K_OPCODE_CUST1   {2'b01, 4'hC}
`define OR1K_OPCODE_CUST2   {2'b01, 4'hD}
`define OR1K_OPCODE_CUST3   {2'b01, 4'hE}
`define OR1K_OPCODE_CUST4   {2'b01, 4'hF}

`define OR1K_OPCODE_LD      {2'b10, 4'h0}
`define OR1K_OPCODE_LWZ     {2'b10, 4'h1}
`define OR1K_OPCODE_LWS     {2'b10, 4'h2}
`define OR1K_OPCODE_LBZ     {2'b10, 4'h3}
`define OR1K_OPCODE_LBS     {2'b10, 4'h4}
`define OR1K_OPCODE_LHZ     {2'b10, 4'h5}
`define OR1K_OPCODE_LHS     {2'b10, 4'h6}

`define OR1K_OPCODE_ADDI    {2'b10, 4'h7}
`define OR1K_OPCODE_ADDIC   {2'b10, 4'h8}
`define OR1K_OPCODE_ANDI    {2'b10, 4'h9}
`define OR1K_OPCODE_ORI     {2'b10, 4'hA}
`define OR1K_OPCODE_XORI    {2'b10, 4'hB}
`define OR1K_OPCODE_MULI    {2'b10, 4'hC}
`define OR1K_OPCODE_MFSPR   {2'b10, 4'hD}
/*
`define OR1K_OPCODE_SLLI    {2'b10, 4'hE}
`define OR1K_OPCODE_SRLI    {2'b10, 4'hE}
`define OR1K_OPCODE_SRAI    {2'b10, 4'hE}
`define OR1K_OPCODE_RORI    {2'b10, 4'hE}
*/
`define OR1K_OPCODE_SHRTI    {2'b10, 4'hE}

/*
`define OR1K_OPCODE_SFEQI   {2'b10, 4'hF}
`define OR1K_OPCODE_SFNEI   {2'b10, 4'hF}
`define OR1K_OPCODE_SFGTUI  {2'b10, 4'hF}
`define OR1K_OPCODE_SFGEUI  {2'b10, 4'hF}
`define OR1K_OPCODE_SFLTUI  {2'b10, 4'hF}
`define OR1K_OPCODE_SFLEUI  {2'b10, 4'hF}
`define OR1K_OPCODE_SFGTSI  {2'b10, 4'hF}
`define OR1K_OPCODE_SFGESI  {2'b10, 4'hF}
`define OR1K_OPCODE_SFLTSI  {2'b10, 4'hF}
`define OR1K_OPCODE_SFLESI  {2'b10, 4'hF}
*/
`define OR1K_OPCODE_SFIMM   {2'b10, 4'hF}

`define OR1K_OPCODE_MTSPR   {2'b11, 4'h0}
`define OR1K_OPCODE_MAC     {2'b11, 4'h1}
`define OR1K_OPCODE_MSB     {2'b11, 4'h1}

`define OR1K_OPCODE_SWA     {2'b11, 4'h3}
`define OR1K_OPCODE_SD      {2'b11, 4'h4}
`define OR1K_OPCODE_SW      {2'b11, 4'h5}
`define OR1K_OPCODE_SB      {2'b11, 4'h6}
`define OR1K_OPCODE_SH      {2'b11, 4'h7}

/*
`define OR1K_OPCODE_ADD     {2'b11, 4'h8}
`define OR1K_OPCODE_ADDC    {2'b11, 4'h8}
`define OR1K_OPCODE_SUB     {2'b11, 4'h8}
`define OR1K_OPCODE_AND     {2'b11, 4'h8}
`define OR1K_OPCODE_OR      {2'b11, 4'h8}
`define OR1K_OPCODE_XOR     {2'b11, 4'h8}
`define OR1K_OPCODE_MUL     {2'b11, 4'h8}

`define OR1K_OPCODE_SLL     {2'b11, 4'h8}
`define OR1K_OPCODE_SRL     {2'b11, 4'h8}
`define OR1K_OPCODE_SRA     {2'b11, 4'h8}
`define OR1K_OPCODE_ROR     {2'b11, 4'h8}
`define OR1K_OPCODE_DIV     {2'b11, 4'h8}
`define OR1K_OPCODE_DIVU    {2'b11, 4'h8}
`define OR1K_OPCODE_MULU    {2'b11, 4'h8}
`define OR1K_OPCODE_EXTBS   {2'b11, 4'h8}
`define OR1K_OPCODE_EXTHS   {2'b11, 4'h8}
`define OR1K_OPCODE_EXTWS   {2'b11, 4'h8}
`define OR1K_OPCODE_EXTBZ   {2'b11, 4'h8}
`define OR1K_OPCODE_EXTHZ   {2'b11, 4'h8}
`define OR1K_OPCODE_EXTWZ   {2'b11, 4'h8}
`define OR1K_OPCODE_CMOV    {2'b11, 4'h8}
`define OR1K_OPCODE_FF1     {2'b11, 4'h8}
`define OR1K_OPCODE_FL1     {2'b11, 4'h8}
*/
`define OR1K_OPCODE_ALU     {2'b11, 4'h8}

/*
`define OR1K_OPCODE_SFEQ    {2'b11, 4'h9}
`define OR1K_OPCODE_SFNE    {2'b11, 4'h9}
`define OR1K_OPCODE_SFGTU   {2'b11, 4'h9}
`define OR1K_OPCODE_SFGEU   {2'b11, 4'h9}
`define OR1K_OPCODE_SFLTU   {2'b11, 4'h9}
`define OR1K_OPCODE_SFLEU   {2'b11, 4'h9}
`define OR1K_OPCODE_SFGTS   {2'b11, 4'h9}
`define OR1K_OPCODE_SFGES   {2'b11, 4'h9}
`define OR1K_OPCODE_SFLTS   {2'b11, 4'h9}
`define OR1K_OPCODE_SFLES   {2'b11, 4'h9}
*/
`define OR1K_OPCODE_SF      {2'b11, 4'h9}

`define OR1K_OPCODE_CUST5   {2'b11, 4'hC}
`define OR1K_OPCODE_CUST6   {2'b11, 4'hD}
`define OR1K_OPCODE_CUST7   {2'b11, 4'hE}
`define OR1K_OPCODE_CUST8   {2'b11, 4'hF}

//
// OR1K SPR defines
//
//`include "mor1kx_sprs.v"

/* Exception addresses */
`define OR1K_RESET_VECTOR    5'h01
`define OR1K_BERR_VECTOR     5'h02
`define OR1K_DPF_VECTOR      5'h03
`define OR1K_IPF_VECTOR      5'h04
`define OR1K_TT_VECTOR       5'h05
`define OR1K_ALIGN_VECTOR    5'h06
`define OR1K_ILLEGAL_VECTOR  5'h07
`define OR1K_INT_VECTOR      5'h08
`define OR1K_DTLB_VECTOR     5'h09
`define OR1K_ITLB_VECTOR     5'h0a
`define OR1K_RANGE_VECTOR    5'h0b
`define OR1K_SYSCALL_VECTOR  5'h0c
`define OR1K_FP_VECTOR       5'h0d
`define OR1K_TRAP_VECTOR     5'h0e

// Whether we'll allow things using AYNC reset to have it:
//`define OR_ASYNC_RST or posedge rst
`define OR_ASYNC_RST

// Implementation version defines
`define MOR1KX_CPUID 8'h01
// mor1kx breaks up the VR2 version register to be 3 8-bit fields
// MSB is major version, middle byte is minor version number
// and final byte is the pipeline identifier.
`define MOR1KX_VERSION_MAJOR 8'd3
`define MOR1KX_VERSION_MINOR 8'd1

// mor1kx implementation-specific register definitions
`define MOR1KX_PIPEID_CAPPUCCINO 8'd1
`define MOR1KX_PIPEID_ESPRESSO   8'd2
`define MOR1KX_PIPEID_PRONTOESPRESSO 8'd3


module mor1kx_cpu_cappuccino
  #(
    parameter OPTION_OPERAND_WIDTH = 32,

    parameter FEATURE_DATACACHE = "NONE",
    parameter OPTION_DCACHE_BLOCK_WIDTH = 5,
    parameter OPTION_DCACHE_SET_WIDTH = 9,
    parameter OPTION_DCACHE_WAYS = 2,
    parameter OPTION_DCACHE_LIMIT_WIDTH = 32,
    parameter OPTION_DCACHE_SNOOP = "NONE",
    parameter FEATURE_DMMU = "NONE",
    parameter FEATURE_DMMU_HW_TLB_RELOAD = "NONE",
    parameter OPTION_DMMU_SET_WIDTH = 6,
    parameter OPTION_DMMU_WAYS = 1,
    parameter FEATURE_INSTRUCTIONCACHE = "NONE",
    parameter OPTION_ICACHE_BLOCK_WIDTH = 5,
    parameter OPTION_ICACHE_SET_WIDTH = 9,
    parameter OPTION_ICACHE_WAYS = 2,
    parameter OPTION_ICACHE_LIMIT_WIDTH = 32,
    parameter FEATURE_IMMU = "NONE",
    parameter FEATURE_IMMU_HW_TLB_RELOAD = "NONE",
    parameter OPTION_IMMU_SET_WIDTH = 6,
    parameter OPTION_IMMU_WAYS = 1,
    parameter FEATURE_TIMER = "ENABLED",
    parameter FEATURE_DEBUGUNIT = "NONE",
    parameter FEATURE_PERFCOUNTERS = "NONE",
    parameter FEATURE_MAC = "NONE",

    parameter FEATURE_SYSCALL = "ENABLED",
    parameter FEATURE_TRAP = "ENABLED",
    parameter FEATURE_RANGE = "ENABLED",

    parameter FEATURE_PIC = "ENABLED",
    parameter OPTION_PIC_TRIGGER = "LEVEL",
    parameter OPTION_PIC_NMI_WIDTH = 0,

    parameter FEATURE_DSX = "NONE",
    parameter FEATURE_OVERFLOW = "NONE",
    parameter FEATURE_CARRY_FLAG = "ENABLED",

    parameter FEATURE_FASTCONTEXTS = "NONE",
    parameter OPTION_RF_NUM_SHADOW_GPR = 0,
    parameter OPTION_RF_ADDR_WIDTH = 5,
    parameter OPTION_RF_WORDS = 32,

    parameter OPTION_RESET_PC = {{(OPTION_OPERAND_WIDTH-13){1'b0}},
				 `OR1K_RESET_VECTOR,8'd0},

    parameter FEATURE_MULTIPLIER = "THREESTAGE",
    parameter FEATURE_DIVIDER = "NONE",

    parameter OPTION_SHIFTER = "BARREL",

    parameter FEATURE_ADDC = "NONE",
    parameter FEATURE_SRA = "ENABLED",
    parameter FEATURE_ROR = "NONE",
    parameter FEATURE_EXT = "NONE",
    parameter FEATURE_CMOV = "NONE",
    parameter FEATURE_FFL1 = "NONE",
    parameter FEATURE_MSYNC = "NONE",
    parameter FEATURE_PSYNC = "NONE",
    parameter FEATURE_CSYNC = "NONE",

    parameter FEATURE_ATOMIC = "ENABLED",


    parameter FEATURE_CUST1 = "NONE",
    parameter FEATURE_CUST2 = "NONE",
    parameter FEATURE_CUST3 = "NONE",
    parameter FEATURE_CUST4 = "NONE",
    parameter FEATURE_CUST5 = "NONE",
    parameter FEATURE_CUST6 = "NONE",
    parameter FEATURE_CUST7 = "NONE",
    parameter FEATURE_CUST8 = "NONE",

    parameter FEATURE_STORE_BUFFER = "ENABLED",
    parameter OPTION_STORE_BUFFER_DEPTH_WIDTH = 8,

    parameter FEATURE_MULTICORE = "NONE",

    parameter FEATURE_TRACEPORT_EXEC = "NONE"
    )
   (
    input 			      clk,
    input 			      rst,

    // Instruction bus
    input 			      ibus_err_i,
    input 			      ibus_ack_i,
    input [`OR1K_INSN_WIDTH-1:0]      ibus_dat_i,
    output [OPTION_OPERAND_WIDTH-1:0] ibus_adr_o,
    output 			      ibus_req_o,
    output 			      ibus_burst_o,

    // Data bus
    input 			      dbus_err_i,
    input 			      dbus_ack_i,
    input [OPTION_OPERAND_WIDTH-1:0]  dbus_dat_i,
    output [OPTION_OPERAND_WIDTH-1:0] dbus_adr_o,
    output [OPTION_OPERAND_WIDTH-1:0] dbus_dat_o,
    output 			      dbus_req_o,
    output [3:0] 		      dbus_bsel_o,
    output 			      dbus_we_o,
    output 			      dbus_burst_o,

    // Interrupts
    input [31:0] 		      irq_i,

    // Debug interface
    input [15:0] 		      du_addr_i,
    input 			      du_stb_i,
    input [OPTION_OPERAND_WIDTH-1:0]  du_dat_i,
    input 			      du_we_i,
    output [OPTION_OPERAND_WIDTH-1:0] du_dat_o,
    output 			      du_ack_o,
    // Stall control from debug interface
    input 			      du_stall_i,
    output 			      du_stall_o,

    output reg	                      traceport_exec_valid_o,
    output reg [31:0]                 traceport_exec_pc_o,
    output reg [`OR1K_INSN_WIDTH-1:0] traceport_exec_insn_o,
    output [OPTION_OPERAND_WIDTH-1:0] traceport_exec_wbdata_o,
    output [OPTION_RF_ADDR_WIDTH-1:0] traceport_exec_wbreg_o,
    output                            traceport_exec_wben_o,

    // SPR accesses to external units (cache, mmu, etc.)
    output [15:0] 		      spr_bus_addr_o,
    output 			      spr_bus_we_o,
    output 			      spr_bus_stb_o,
    output [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_o,
    input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_mac_i,
    input 			      spr_bus_ack_mac_i,
    input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_pmu_i,
    input 			      spr_bus_ack_pmu_i,
    input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_pcu_i,
    input 			      spr_bus_ack_pcu_i,
    input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_fpu_i,
    input 			      spr_bus_ack_fpu_i,
    output [15:0] 		      spr_sr_o,

    input [OPTION_OPERAND_WIDTH-1:0]  multicore_coreid_i,
    input [OPTION_OPERAND_WIDTH-1:0]  multicore_numcores_i,

    input [31:0] 		     snoop_adr_i,
    input 			     snoop_en_i
    );

   wire [OPTION_OPERAND_WIDTH-1:0]   pc_fetch_to_decode;
   wire [`OR1K_INSN_WIDTH-1:0] 	     insn_fetch_to_decode;
   wire [OPTION_OPERAND_WIDTH-1:0]   pc_decode_to_execute;
   wire [OPTION_OPERAND_WIDTH-1:0]   pc_execute_to_ctrl;

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [OPTION_OPERAND_WIDTH-1:0] adder_result_o;// From mor1kx_execute_alu of mor1kx_execute_alu.v
   wire [OPTION_OPERAND_WIDTH-1:0] alu_result_o;// From mor1kx_execute_alu of mor1kx_execute_alu.v
   wire			alu_valid_o;		// From mor1kx_execute_alu of mor1kx_execute_alu.v
   wire			atomic_flag_clear_o;	// From mor1kx_lsu_cappuccino of mor1kx_lsu_cappuccino.v
   wire			atomic_flag_set_o;	// From mor1kx_lsu_cappuccino of mor1kx_lsu_cappuccino.v
   wire			branch_mispredict_o;	// From mor1kx_branch_prediction of mor1kx_branch_prediction.v
   wire			carry_clear_o;		// From mor1kx_execute_alu of mor1kx_execute_alu.v
   wire			carry_set_o;		// From mor1kx_execute_alu of mor1kx_execute_alu.v
   wire [OPTION_OPERAND_WIDTH-1:0] ctrl_alu_result_o;// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] ctrl_branch_except_pc_o;// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			ctrl_branch_exception_o;// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			ctrl_bubble_o;		// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			ctrl_carry_clear_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_carry_o;		// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			ctrl_carry_set_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] ctrl_epcr_o;	// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			ctrl_except_align_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_except_dbus_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_except_dpagefault_o;// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_except_dtlb_miss_o;// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_except_ibus_align_o;// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_except_ibus_err_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_except_illegal_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_except_ipagefault_o;// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_except_itlb_miss_o;// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_except_syscall_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_except_trap_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_flag_clear_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_flag_o;		// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			ctrl_flag_set_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] ctrl_lsu_adr_o;// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire [1:0]		ctrl_lsu_length_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_lsu_zext_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_mfspr_ack_o;	// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			ctrl_mtspr_ack_o;	// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			ctrl_op_lsu_atomic_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_op_lsu_load_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_op_lsu_store_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_op_mfspr_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_op_mtspr_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_op_mul_o;		// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_op_rfe_o;		// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_overflow_clear_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_overflow_set_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_rf_wb_o;		// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] ctrl_rfb_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire [OPTION_RF_ADDR_WIDTH-1:0] ctrl_rfd_adr_o;// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			ctrl_valid_o;		// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			decode_adder_do_carry_o;// From mor1kx_decode of mor1kx_decode.v
   wire			decode_adder_do_sub_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_branch_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] decode_branch_target_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			decode_bubble_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			decode_except_ibus_err_o;// From mor1kx_fetch_cappuccino of mor1kx_fetch_cappuccino.v
   wire			decode_except_illegal_o;// From mor1kx_decode of mor1kx_decode.v
   wire			decode_except_ipagefault_o;// From mor1kx_fetch_cappuccino of mor1kx_fetch_cappuccino.v
   wire			decode_except_itlb_miss_o;// From mor1kx_fetch_cappuccino of mor1kx_fetch_cappuccino.v
   wire			decode_except_syscall_o;// From mor1kx_decode of mor1kx_decode.v
   wire			decode_except_trap_o;	// From mor1kx_decode of mor1kx_decode.v
   wire [`OR1K_IMM_WIDTH-1:0] decode_imm16_o;	// From mor1kx_decode of mor1kx_decode.v
   wire [OPTION_OPERAND_WIDTH-1:0] decode_immediate_o;// From mor1kx_decode of mor1kx_decode.v
   wire			decode_immediate_sel_o;	// From mor1kx_decode of mor1kx_decode.v
   wire [9:0]		decode_immjbr_upper_o;	// From mor1kx_decode of mor1kx_decode.v
   wire [1:0]		decode_lsu_length_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_lsu_zext_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_add_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_alu_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_bf_o;		// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_bnf_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_branch_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_brcond_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_div_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_div_signed_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_div_unsigned_o;// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_ffl1_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_jal_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_jbr_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_jr_o;		// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_lsu_atomic_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_lsu_load_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_lsu_store_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_mfspr_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_movhi_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_mtspr_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_mul_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_mul_signed_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_mul_unsigned_o;// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_rfe_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_setflag_o;	// From mor1kx_decode of mor1kx_decode.v
   wire			decode_op_shift_o;	// From mor1kx_decode of mor1kx_decode.v
   wire [`OR1K_ALU_OPC_WIDTH-1:0] decode_opc_alu_o;// From mor1kx_decode of mor1kx_decode.v
   wire [`OR1K_ALU_OPC_WIDTH-1:0] decode_opc_alu_secondary_o;// From mor1kx_decode of mor1kx_decode.v
   wire [`OR1K_OPCODE_WIDTH-1:0] decode_opc_insn_o;// From mor1kx_decode of mor1kx_decode.v
   wire			decode_rf_wb_o;		// From mor1kx_decode of mor1kx_decode.v
   wire [OPTION_RF_ADDR_WIDTH-1:0] decode_rfa_adr_o;// From mor1kx_decode of mor1kx_decode.v
   wire [OPTION_OPERAND_WIDTH-1:0] decode_rfa_o;// From mor1kx_rf_cappuccino of mor1kx_rf_cappuccino.v
   wire [OPTION_RF_ADDR_WIDTH-1:0] decode_rfb_adr_o;// From mor1kx_decode of mor1kx_decode.v
   wire [OPTION_OPERAND_WIDTH-1:0] decode_rfb_o;// From mor1kx_rf_cappuccino of mor1kx_rf_cappuccino.v
   wire [OPTION_RF_ADDR_WIDTH-1:0] decode_rfd_adr_o;// From mor1kx_decode of mor1kx_decode.v
   wire			decode_valid_o;		// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			doing_rfe_o;		// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			du_restart_o;		// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] du_restart_pc_o;// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			execute_adder_do_carry_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_adder_do_sub_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_bubble_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_except_ibus_align_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_except_ibus_err_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_except_illegal_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_except_ipagefault_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_except_itlb_miss_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_except_syscall_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_except_trap_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire [`OR1K_IMM_WIDTH-1:0] execute_imm16_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] execute_immediate_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_immediate_sel_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire [9:0]		execute_immjbr_upper_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] execute_jal_result_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire [1:0]		execute_lsu_length_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_lsu_zext_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] execute_mispredict_target_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_add_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_alu_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_branch_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_brcond_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_div_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_div_signed_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_div_unsigned_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_ffl1_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_jal_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_jbr_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_jr_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_lsu_atomic_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_lsu_load_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_lsu_store_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_mfspr_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_movhi_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_mtspr_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_mul_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_mul_signed_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_mul_unsigned_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_rfe_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_setflag_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_op_shift_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire [`OR1K_ALU_OPC_WIDTH-1:0] execute_opc_alu_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire [`OR1K_ALU_OPC_WIDTH-1:0] execute_opc_alu_secondary_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire [`OR1K_OPCODE_WIDTH-1:0] execute_opc_insn_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_predicted_flag_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_rf_wb_o;	// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] execute_rfa_o;// From mor1kx_rf_cappuccino of mor1kx_rf_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] execute_rfb_o;// From mor1kx_rf_cappuccino of mor1kx_rf_cappuccino.v
   wire [OPTION_RF_ADDR_WIDTH-1:0] execute_rfd_adr_o;// From mor1kx_decode_execute_cappuccino of mor1kx_decode_execute_cappuccino.v
   wire			execute_valid_o;	// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire			fetch_exception_taken_o;// From mor1kx_fetch_cappuccino of mor1kx_fetch_cappuccino.v
   wire			fetch_rf_adr_valid_o;	// From mor1kx_fetch_cappuccino of mor1kx_fetch_cappuccino.v
   wire [OPTION_RF_ADDR_WIDTH-1:0] fetch_rfa_adr_o;// From mor1kx_fetch_cappuccino of mor1kx_fetch_cappuccino.v
   wire [OPTION_RF_ADDR_WIDTH-1:0] fetch_rfb_adr_o;// From mor1kx_fetch_cappuccino of mor1kx_fetch_cappuccino.v
   wire			fetch_valid_o;		// From mor1kx_fetch_cappuccino of mor1kx_fetch_cappuccino.v
   wire			flag_clear_o;		// From mor1kx_execute_alu of mor1kx_execute_alu.v
   wire			flag_set_o;		// From mor1kx_execute_alu of mor1kx_execute_alu.v
   wire			lsu_except_align_o;	// From mor1kx_lsu_cappuccino of mor1kx_lsu_cappuccino.v
   wire			lsu_except_dbus_o;	// From mor1kx_lsu_cappuccino of mor1kx_lsu_cappuccino.v
   wire			lsu_except_dpagefault_o;// From mor1kx_lsu_cappuccino of mor1kx_lsu_cappuccino.v
   wire			lsu_except_dtlb_miss_o;	// From mor1kx_lsu_cappuccino of mor1kx_lsu_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] lsu_result_o;// From mor1kx_lsu_cappuccino of mor1kx_lsu_cappuccino.v
   wire			lsu_valid_o;		// From mor1kx_lsu_cappuccino of mor1kx_lsu_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] mfspr_dat_o;	// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] mul_result_o;// From mor1kx_execute_alu of mor1kx_execute_alu.v
   wire			overflow_clear_o;	// From mor1kx_execute_alu of mor1kx_execute_alu.v
   wire			overflow_set_o;		// From mor1kx_execute_alu of mor1kx_execute_alu.v
   wire			padv_ctrl_o;		// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			padv_decode_o;		// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			padv_execute_o;		// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			padv_fetch_o;		// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			pipeline_flush_o;	// From mor1kx_ctrl_cappuccino of mor1kx_ctrl_cappuccino.v
   wire			predicted_flag_o;	// From mor1kx_branch_prediction of mor1kx_branch_prediction.v
   wire [OPTION_OPERAND_WIDTH-1:0] rf_result_o;	// From mor1kx_wb_mux_cappuccino of mor1kx_wb_mux_cappuccino.v
   wire			spr_bus_ack_dc_i;	// From mor1kx_lsu_cappuccino of mor1kx_lsu_cappuccino.v
   wire			spr_bus_ack_dmmu_i;	// From mor1kx_lsu_cappuccino of mor1kx_lsu_cappuccino.v
   wire			spr_bus_ack_ic_i;	// From mor1kx_fetch_cappuccino of mor1kx_fetch_cappuccino.v
   wire			spr_bus_ack_immu_i;	// From mor1kx_fetch_cappuccino of mor1kx_fetch_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_dc_i;// From mor1kx_lsu_cappuccino of mor1kx_lsu_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_dmmu_i;// From mor1kx_lsu_cappuccino of mor1kx_lsu_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_ic_i;// From mor1kx_fetch_cappuccino of mor1kx_fetch_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_immu_i;// From mor1kx_fetch_cappuccino of mor1kx_fetch_cappuccino.v
   wire			spr_gpr_ack_o;		// From mor1kx_rf_cappuccino of mor1kx_rf_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] spr_gpr_dat_o;// From mor1kx_rf_cappuccino of mor1kx_rf_cappuccino.v
   wire [OPTION_OPERAND_WIDTH-1:0] store_buffer_epcr_o;// From mor1kx_lsu_cappuccino of mor1kx_lsu_cappuccino.v
   wire			store_buffer_err_o;	// From mor1kx_lsu_cappuccino of mor1kx_lsu_cappuccino.v
   wire			wb_rf_wb_o;		// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   wire [OPTION_RF_ADDR_WIDTH-1:0] wb_rfd_adr_o;// From mor1kx_execute_ctrl_cappuccino of mor1kx_execute_ctrl_cappuccino.v
   // End of automatics

   /* mor1kx_fetch_cappuccino AUTO_TEMPLATE (
    .padv_i				(padv_fetch_o),
    .padv_ctrl_i			(padv_ctrl_o),
    .decode_branch_i			(decode_branch_o),
    .decode_branch_target_i		(decode_branch_target_o),
    .ctrl_branch_exception_i		(ctrl_branch_exception_o),
    .ctrl_branch_except_pc_i		(ctrl_branch_except_pc_o),
    .doing_rfe_i			(doing_rfe_o),
    .pipeline_flush_i			(pipeline_flush_o),
    .pc_decode_o			(pc_fetch_to_decode),
    .decode_insn_o			(insn_fetch_to_decode),
    .du_restart_pc_i			(du_restart_pc_o),
    .du_restart_i			(du_restart_o),
    .decode_op_brcond_i			(decode_op_brcond_o),
    .branch_mispredict_i		(branch_mispredict_o),
    .execute_mispredict_target_i	(execute_mispredict_target_o),
    .spr_bus_dat_ic_o			(spr_bus_dat_ic_i[OPTION_OPERAND_WIDTH-1:0]),
    .spr_bus_ack_ic_o			(spr_bus_ack_ic_i),
    .spr_bus_dat_immu_o			(spr_bus_dat_immu_i[OPTION_OPERAND_WIDTH-1:0]),
    .spr_bus_ack_immu_o			(spr_bus_ack_immu_i),
    .spr_bus_addr_i			(spr_bus_addr_o[15:0]),
    .spr_bus_we_i			(spr_bus_we_o),
    .spr_bus_stb_i			(spr_bus_stb_o),
    .spr_bus_dat_i			(spr_bus_dat_o[OPTION_OPERAND_WIDTH-1:0]),
    .ic_enable				(spr_sr_o[`OR1K_SPR_SR_ICE]),
    .immu_enable_i			(spr_sr_o[`OR1K_SPR_SR_IME]),
    .supervisor_mode_i			(spr_sr_o[`OR1K_SPR_SR_SM]),
    ); */
   mor1kx_fetch_cappuccino
     #(
       .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH),
       .OPTION_RESET_PC(OPTION_RESET_PC),
       .FEATURE_INSTRUCTIONCACHE(FEATURE_INSTRUCTIONCACHE),
       .OPTION_ICACHE_BLOCK_WIDTH(OPTION_ICACHE_BLOCK_WIDTH),
       .OPTION_ICACHE_SET_WIDTH(OPTION_ICACHE_SET_WIDTH),
       .OPTION_ICACHE_WAYS(OPTION_ICACHE_WAYS),
       .OPTION_ICACHE_LIMIT_WIDTH(OPTION_ICACHE_LIMIT_WIDTH),
       .FEATURE_IMMU(FEATURE_IMMU),
       .FEATURE_IMMU_HW_TLB_RELOAD(FEATURE_IMMU_HW_TLB_RELOAD),
       .OPTION_IMMU_SET_WIDTH(OPTION_IMMU_SET_WIDTH),
       .OPTION_IMMU_WAYS(OPTION_IMMU_WAYS)
       )
     mor1kx_fetch_cappuccino
     (/*AUTOINST*/
      // Outputs
      .spr_bus_dat_ic_o			(spr_bus_dat_ic_i[OPTION_OPERAND_WIDTH-1:0]), // Templated
      .spr_bus_ack_ic_o			(spr_bus_ack_ic_i),	 // Templated
      .spr_bus_dat_immu_o		(spr_bus_dat_immu_i[OPTION_OPERAND_WIDTH-1:0]), // Templated
      .spr_bus_ack_immu_o		(spr_bus_ack_immu_i),	 // Templated
      .ibus_req_o			(ibus_req_o),
      .ibus_adr_o			(ibus_adr_o[OPTION_OPERAND_WIDTH-1:0]),
      .ibus_burst_o			(ibus_burst_o),
      .pc_decode_o			(pc_fetch_to_decode),	 // Templated
      .decode_insn_o			(insn_fetch_to_decode),	 // Templated
      .fetch_valid_o			(fetch_valid_o),
      .fetch_rfa_adr_o			(fetch_rfa_adr_o[OPTION_RF_ADDR_WIDTH-1:0]),
      .fetch_rfb_adr_o			(fetch_rfb_adr_o[OPTION_RF_ADDR_WIDTH-1:0]),
      .fetch_rf_adr_valid_o		(fetch_rf_adr_valid_o),
      .decode_except_ibus_err_o		(decode_except_ibus_err_o),
      .decode_except_itlb_miss_o	(decode_except_itlb_miss_o),
      .decode_except_ipagefault_o	(decode_except_ipagefault_o),
      .fetch_exception_taken_o		(fetch_exception_taken_o),
      // Inputs
      .clk				(clk),
      .rst				(rst),
      .spr_bus_addr_i			(spr_bus_addr_o[15:0]),	 // Templated
      .spr_bus_we_i			(spr_bus_we_o),		 // Templated
      .spr_bus_stb_i			(spr_bus_stb_o),	 // Templated
      .spr_bus_dat_i			(spr_bus_dat_o[OPTION_OPERAND_WIDTH-1:0]), // Templated
      .ic_enable			(spr_sr_o[`OR1K_SPR_SR_ICE]), // Templated
      .immu_enable_i			(spr_sr_o[`OR1K_SPR_SR_IME]), // Templated
      .supervisor_mode_i		(spr_sr_o[`OR1K_SPR_SR_SM]), // Templated
      .ibus_err_i			(ibus_err_i),
      .ibus_ack_i			(ibus_ack_i),
      .ibus_dat_i			(ibus_dat_i[`OR1K_INSN_WIDTH-1:0]),
      .padv_i				(padv_fetch_o),		 // Templated
      .padv_ctrl_i			(padv_ctrl_o),		 // Templated
      .decode_branch_i			(decode_branch_o),	 // Templated
      .decode_branch_target_i		(decode_branch_target_o), // Templated
      .ctrl_branch_exception_i		(ctrl_branch_exception_o), // Templated
      .ctrl_branch_except_pc_i		(ctrl_branch_except_pc_o), // Templated
      .du_restart_i			(du_restart_o),		 // Templated
      .du_restart_pc_i			(du_restart_pc_o),	 // Templated
      .decode_op_brcond_i		(decode_op_brcond_o),	 // Templated
      .branch_mispredict_i		(branch_mispredict_o),	 // Templated
      .execute_mispredict_target_i	(execute_mispredict_target_o), // Templated
      .pipeline_flush_i			(pipeline_flush_o),	 // Templated
      .doing_rfe_i			(doing_rfe_o));		 // Templated

   /* mor1kx_decode AUTO_TEMPLATE (
    .decode_insn_i			(insn_fetch_to_decode),
    ); */
   mor1kx_decode
     #(
       .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH),
       .OPTION_RESET_PC(OPTION_RESET_PC),
       .OPTION_RF_ADDR_WIDTH(OPTION_RF_ADDR_WIDTH),
       .FEATURE_SYSCALL(FEATURE_SYSCALL),
       .FEATURE_TRAP(FEATURE_TRAP),
       .FEATURE_RANGE(FEATURE_RANGE),
       .FEATURE_MAC(FEATURE_MAC),
       .FEATURE_MULTIPLIER(FEATURE_MULTIPLIER),
       .FEATURE_DIVIDER(FEATURE_DIVIDER),
       .FEATURE_ADDC(FEATURE_ADDC),
       .FEATURE_SRA(FEATURE_SRA),
       .FEATURE_ROR(FEATURE_ROR),
       .FEATURE_EXT(FEATURE_EXT),
       .FEATURE_CMOV(FEATURE_CMOV),
       .FEATURE_FFL1(FEATURE_FFL1),
       .FEATURE_MSYNC(FEATURE_MSYNC),
       .FEATURE_PSYNC(FEATURE_PSYNC),
       .FEATURE_CSYNC(FEATURE_CSYNC),
       .FEATURE_ATOMIC(FEATURE_ATOMIC),
       .FEATURE_CUST1(FEATURE_CUST1),
       .FEATURE_CUST2(FEATURE_CUST2),
       .FEATURE_CUST3(FEATURE_CUST3),
       .FEATURE_CUST4(FEATURE_CUST4),
       .FEATURE_CUST5(FEATURE_CUST5),
       .FEATURE_CUST6(FEATURE_CUST6),
       .FEATURE_CUST7(FEATURE_CUST7),
       .FEATURE_CUST8(FEATURE_CUST8)
       )
     mor1kx_decode
     (/*AUTOINST*/
      // Outputs
      .decode_opc_alu_o			(decode_opc_alu_o[`OR1K_ALU_OPC_WIDTH-1:0]),
      .decode_opc_alu_secondary_o	(decode_opc_alu_secondary_o[`OR1K_ALU_OPC_WIDTH-1:0]),
      .decode_imm16_o			(decode_imm16_o[`OR1K_IMM_WIDTH-1:0]),
      .decode_immediate_o		(decode_immediate_o[OPTION_OPERAND_WIDTH-1:0]),
      .decode_immediate_sel_o		(decode_immediate_sel_o),
      .decode_immjbr_upper_o		(decode_immjbr_upper_o[9:0]),
      .decode_rfd_adr_o			(decode_rfd_adr_o[OPTION_RF_ADDR_WIDTH-1:0]),
      .decode_rfa_adr_o			(decode_rfa_adr_o[OPTION_RF_ADDR_WIDTH-1:0]),
      .decode_rfb_adr_o			(decode_rfb_adr_o[OPTION_RF_ADDR_WIDTH-1:0]),
      .decode_rf_wb_o			(decode_rf_wb_o),
      .decode_op_jbr_o			(decode_op_jbr_o),
      .decode_op_jr_o			(decode_op_jr_o),
      .decode_op_jal_o			(decode_op_jal_o),
      .decode_op_bf_o			(decode_op_bf_o),
      .decode_op_bnf_o			(decode_op_bnf_o),
      .decode_op_brcond_o		(decode_op_brcond_o),
      .decode_op_branch_o		(decode_op_branch_o),
      .decode_op_alu_o			(decode_op_alu_o),
      .decode_op_lsu_load_o		(decode_op_lsu_load_o),
      .decode_op_lsu_store_o		(decode_op_lsu_store_o),
      .decode_op_lsu_atomic_o		(decode_op_lsu_atomic_o),
      .decode_lsu_length_o		(decode_lsu_length_o[1:0]),
      .decode_lsu_zext_o		(decode_lsu_zext_o),
      .decode_op_mfspr_o		(decode_op_mfspr_o),
      .decode_op_mtspr_o		(decode_op_mtspr_o),
      .decode_op_rfe_o			(decode_op_rfe_o),
      .decode_op_setflag_o		(decode_op_setflag_o),
      .decode_op_add_o			(decode_op_add_o),
      .decode_op_mul_o			(decode_op_mul_o),
      .decode_op_mul_signed_o		(decode_op_mul_signed_o),
      .decode_op_mul_unsigned_o		(decode_op_mul_unsigned_o),
      .decode_op_div_o			(decode_op_div_o),
      .decode_op_div_signed_o		(decode_op_div_signed_o),
      .decode_op_div_unsigned_o		(decode_op_div_unsigned_o),
      .decode_op_shift_o		(decode_op_shift_o),
      .decode_op_ffl1_o			(decode_op_ffl1_o),
      .decode_op_movhi_o		(decode_op_movhi_o),
      .decode_adder_do_sub_o		(decode_adder_do_sub_o),
      .decode_adder_do_carry_o		(decode_adder_do_carry_o),
      .decode_except_illegal_o		(decode_except_illegal_o),
      .decode_except_syscall_o		(decode_except_syscall_o),
      .decode_except_trap_o		(decode_except_trap_o),
      .decode_opc_insn_o		(decode_opc_insn_o[`OR1K_OPCODE_WIDTH-1:0]),
      // Inputs
      .clk				(clk),
      .rst				(rst),
      .decode_insn_i			(insn_fetch_to_decode));	 // Templated

   /* mor1kx_decode_execute_cappuccino AUTO_TEMPLATE (
      .padv_i				(padv_decode_o),
      .pc_decode_i			(pc_fetch_to_decode),
      .decode_rfb_i			(decode_rfb_o),
      .execute_rfb_i			(execute_rfb_o),
      .predicted_flag_i			(predicted_flag_o),
      .flag_i				(ctrl_flag_o),
      .pc_execute_o			(pc_decode_to_execute),
      .pipeline_flush_i			(pipeline_flush_o),
      .decode_opc_alu_i			(decode_opc_alu_o),
      .decode_opc_alu_secondary_i	(decode_opc_alu_secondary_o),
      .decode_imm16_i			(decode_imm16_o),
      .decode_immediate_i		(decode_immediate_o),
      .decode_immediate_sel_i		(decode_immediate_sel_o),
      .decode_immjbr_upper_i		(decode_immjbr_upper_o),
      .decode_adder_do_sub_i		(decode_adder_do_sub_o),
      .decode_adder_do_carry_i		(decode_adder_do_carry_o),
      .decode_rfd_adr_i			(decode_rfd_adr_o),
      .decode_rfa_adr_i			(decode_rfa_adr_o),
      .decode_rfb_adr_i			(decode_rfb_adr_o),
      .ctrl_rfd_adr_i			(ctrl_rfd_adr_o),
      .ctrl_op_lsu_load_i		(ctrl_op_lsu_load_o),
      .ctrl_op_mfspr_i			(ctrl_op_mfspr_o),
      .ctrl_op_mul_i			(ctrl_op_mul_o),
      .decode_rf_wb_i			(decode_rf_wb_o),
      .decode_op_alu_i			(decode_op_alu_o),
      .decode_op_setflag_i		(decode_op_setflag_o),
      .decode_op_jbr_i			(decode_op_jbr_o),
      .decode_op_jr_i			(decode_op_jr_o),
      .decode_op_jal_i			(decode_op_jal_o),
      .decode_op_bf_i			(decode_op_bf_o),
      .decode_op_bnf_i			(decode_op_bnf_o),
      .decode_op_brcond_i		(decode_op_brcond_o),
      .decode_op_branch_i		(decode_op_branch_o),
      .decode_op_lsu_load_i		(decode_op_lsu_load_o),
      .decode_op_lsu_store_i		(decode_op_lsu_store_o),
      .decode_op_lsu_atomic_i		(decode_op_lsu_atomic_o),
      .decode_lsu_length_i		(decode_lsu_length_o[1:0]),
      .decode_lsu_zext_i		(decode_lsu_zext_o),
      .decode_op_mfspr_i		(decode_op_mfspr_o),
      .decode_op_mtspr_i		(decode_op_mtspr_o),
      .decode_op_rfe_i			(decode_op_rfe_o),
      .decode_op_add_i			(decode_op_add_o),
      .decode_op_mul_i			(decode_op_mul_o),
      .decode_op_mul_signed_i		(decode_op_mul_signed_o),
      .decode_op_mul_unsigned_i		(decode_op_mul_unsigned_o),
      .decode_op_div_i			(decode_op_div_o),
      .decode_op_div_signed_i		(decode_op_div_signed_o),
      .decode_op_div_unsigned_i		(decode_op_div_unsigned_o),
      .decode_op_shift_i		(decode_op_shift_o),
      .decode_op_ffl1_i			(decode_op_ffl1_o),
      .decode_op_movhi_i		(decode_op_movhi_o),
      .decode_opc_insn_i		(decode_opc_insn_o[`OR1K_OPCODE_WIDTH-1:0]),
      .decode_except_ibus_err_i		(decode_except_ibus_err_o),
      .decode_except_itlb_miss_i	(decode_except_itlb_miss_o),
      .decode_except_ipagefault_i	(decode_except_ipagefault_o),
      .decode_except_illegal_i		(decode_except_illegal_o),
      .decode_except_syscall_i		(decode_except_syscall_o),
      .decode_except_trap_i		(decode_except_trap_o),
    ); */
   mor1kx_decode_execute_cappuccino
     #(
       .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH),
       .OPTION_RESET_PC(OPTION_RESET_PC),
       .OPTION_RF_ADDR_WIDTH(OPTION_RF_ADDR_WIDTH),
       .FEATURE_SYSCALL(FEATURE_SYSCALL),
       .FEATURE_TRAP(FEATURE_TRAP),
       .FEATURE_MULTIPLIER(FEATURE_MULTIPLIER)
       )
     mor1kx_decode_execute_cappuccino
     (/*AUTOINST*/
      // Outputs
      .execute_predicted_flag_o		(execute_predicted_flag_o),
      .execute_mispredict_target_o	(execute_mispredict_target_o[OPTION_OPERAND_WIDTH-1:0]),
      .execute_opc_alu_o		(execute_opc_alu_o[`OR1K_ALU_OPC_WIDTH-1:0]),
      .execute_opc_alu_secondary_o	(execute_opc_alu_secondary_o[`OR1K_ALU_OPC_WIDTH-1:0]),
      .execute_imm16_o			(execute_imm16_o[`OR1K_IMM_WIDTH-1:0]),
      .execute_immediate_o		(execute_immediate_o[OPTION_OPERAND_WIDTH-1:0]),
      .execute_immediate_sel_o		(execute_immediate_sel_o),
      .execute_adder_do_sub_o		(execute_adder_do_sub_o),
      .execute_adder_do_carry_o		(execute_adder_do_carry_o),
      .execute_immjbr_upper_o		(execute_immjbr_upper_o[9:0]),
      .execute_rfd_adr_o		(execute_rfd_adr_o[OPTION_RF_ADDR_WIDTH-1:0]),
      .execute_rf_wb_o			(execute_rf_wb_o),
      .execute_op_alu_o			(execute_op_alu_o),
      .execute_op_setflag_o		(execute_op_setflag_o),
      .execute_op_jbr_o			(execute_op_jbr_o),
      .execute_op_jr_o			(execute_op_jr_o),
      .execute_op_jal_o			(execute_op_jal_o),
      .execute_op_brcond_o		(execute_op_brcond_o),
      .execute_op_branch_o		(execute_op_branch_o),
      .execute_op_lsu_load_o		(execute_op_lsu_load_o),
      .execute_op_lsu_store_o		(execute_op_lsu_store_o),
      .execute_op_lsu_atomic_o		(execute_op_lsu_atomic_o),
      .execute_lsu_length_o		(execute_lsu_length_o[1:0]),
      .execute_lsu_zext_o		(execute_lsu_zext_o),
      .execute_op_mfspr_o		(execute_op_mfspr_o),
      .execute_op_mtspr_o		(execute_op_mtspr_o),
      .execute_op_rfe_o			(execute_op_rfe_o),
      .execute_op_add_o			(execute_op_add_o),
      .execute_op_mul_o			(execute_op_mul_o),
      .execute_op_mul_signed_o		(execute_op_mul_signed_o),
      .execute_op_mul_unsigned_o	(execute_op_mul_unsigned_o),
      .execute_op_div_o			(execute_op_div_o),
      .execute_op_div_signed_o		(execute_op_div_signed_o),
      .execute_op_div_unsigned_o	(execute_op_div_unsigned_o),
      .execute_op_shift_o		(execute_op_shift_o),
      .execute_op_ffl1_o		(execute_op_ffl1_o),
      .execute_op_movhi_o		(execute_op_movhi_o),
      .execute_jal_result_o		(execute_jal_result_o[OPTION_OPERAND_WIDTH-1:0]),
      .execute_opc_insn_o		(execute_opc_insn_o[`OR1K_OPCODE_WIDTH-1:0]),
      .decode_branch_o			(decode_branch_o),
      .decode_branch_target_o		(decode_branch_target_o[OPTION_OPERAND_WIDTH-1:0]),
      .execute_except_ibus_err_o	(execute_except_ibus_err_o),
      .execute_except_itlb_miss_o	(execute_except_itlb_miss_o),
      .execute_except_ipagefault_o	(execute_except_ipagefault_o),
      .execute_except_illegal_o		(execute_except_illegal_o),
      .execute_except_ibus_align_o	(execute_except_ibus_align_o),
      .execute_except_syscall_o		(execute_except_syscall_o),
      .execute_except_trap_o		(execute_except_trap_o),
      .pc_execute_o			(pc_decode_to_execute),	 // Templated
      .decode_valid_o			(decode_valid_o),
      .decode_bubble_o			(decode_bubble_o),
      .execute_bubble_o			(execute_bubble_o),
      // Inputs
      .clk				(clk),
      .rst				(rst),
      .padv_i				(padv_decode_o),	 // Templated
      .pc_decode_i			(pc_fetch_to_decode),	 // Templated
      .decode_rfb_i			(decode_rfb_o),		 // Templated
      .execute_rfb_i			(execute_rfb_o),	 // Templated
      .predicted_flag_i			(predicted_flag_o),	 // Templated
      .pipeline_flush_i			(pipeline_flush_o),	 // Templated
      .decode_opc_alu_i			(decode_opc_alu_o),	 // Templated
      .decode_opc_alu_secondary_i	(decode_opc_alu_secondary_o), // Templated
      .decode_imm16_i			(decode_imm16_o),	 // Templated
      .decode_immediate_i		(decode_immediate_o),	 // Templated
      .decode_immediate_sel_i		(decode_immediate_sel_o), // Templated
      .decode_adder_do_sub_i		(decode_adder_do_sub_o), // Templated
      .decode_adder_do_carry_i		(decode_adder_do_carry_o), // Templated
      .decode_immjbr_upper_i		(decode_immjbr_upper_o), // Templated
      .decode_rfd_adr_i			(decode_rfd_adr_o),	 // Templated
      .decode_rfa_adr_i			(decode_rfa_adr_o),	 // Templated
      .decode_rfb_adr_i			(decode_rfb_adr_o),	 // Templated
      .ctrl_rfd_adr_i			(ctrl_rfd_adr_o),	 // Templated
      .ctrl_op_lsu_load_i		(ctrl_op_lsu_load_o),	 // Templated
      .ctrl_op_mfspr_i			(ctrl_op_mfspr_o),	 // Templated
      .ctrl_op_mul_i			(ctrl_op_mul_o),	 // Templated
      .decode_rf_wb_i			(decode_rf_wb_o),	 // Templated
      .decode_op_alu_i			(decode_op_alu_o),	 // Templated
      .decode_op_setflag_i		(decode_op_setflag_o),	 // Templated
      .decode_op_jbr_i			(decode_op_jbr_o),	 // Templated
      .decode_op_jr_i			(decode_op_jr_o),	 // Templated
      .decode_op_jal_i			(decode_op_jal_o),	 // Templated
      .decode_op_bf_i			(decode_op_bf_o),	 // Templated
      .decode_op_bnf_i			(decode_op_bnf_o),	 // Templated
      .decode_op_brcond_i		(decode_op_brcond_o),	 // Templated
      .decode_op_branch_i		(decode_op_branch_o),	 // Templated
      .decode_op_lsu_load_i		(decode_op_lsu_load_o),	 // Templated
      .decode_op_lsu_store_i		(decode_op_lsu_store_o), // Templated
      .decode_op_lsu_atomic_i		(decode_op_lsu_atomic_o), // Templated
      .decode_lsu_length_i		(decode_lsu_length_o[1:0]), // Templated
      .decode_lsu_zext_i		(decode_lsu_zext_o),	 // Templated
      .decode_op_mfspr_i		(decode_op_mfspr_o),	 // Templated
      .decode_op_mtspr_i		(decode_op_mtspr_o),	 // Templated
      .decode_op_rfe_i			(decode_op_rfe_o),	 // Templated
      .decode_op_add_i			(decode_op_add_o),	 // Templated
      .decode_op_mul_i			(decode_op_mul_o),	 // Templated
      .decode_op_mul_signed_i		(decode_op_mul_signed_o), // Templated
      .decode_op_mul_unsigned_i		(decode_op_mul_unsigned_o), // Templated
      .decode_op_div_i			(decode_op_div_o),	 // Templated
      .decode_op_div_signed_i		(decode_op_div_signed_o), // Templated
      .decode_op_div_unsigned_i		(decode_op_div_unsigned_o), // Templated
      .decode_op_shift_i		(decode_op_shift_o),	 // Templated
      .decode_op_ffl1_i			(decode_op_ffl1_o),	 // Templated
      .decode_op_movhi_i		(decode_op_movhi_o),	 // Templated
      .decode_opc_insn_i		(decode_opc_insn_o[`OR1K_OPCODE_WIDTH-1:0]), // Templated
      .decode_except_ibus_err_i		(decode_except_ibus_err_o), // Templated
      .decode_except_itlb_miss_i	(decode_except_itlb_miss_o), // Templated
      .decode_except_ipagefault_i	(decode_except_ipagefault_o), // Templated
      .decode_except_illegal_i		(decode_except_illegal_o), // Templated
      .decode_except_syscall_i		(decode_except_syscall_o), // Templated
      .decode_except_trap_i		(decode_except_trap_o));	 // Templated

   /* mor1kx_branch_prediction AUTO_TEMPLATE (
      .op_bf_i				(decode_op_bf_o),
      .op_bnf_i				(decode_op_bnf_o),
      .immjbr_upper_i			(decode_immjbr_upper_o),
      .prev_op_brcond_i			(execute_op_brcond_o),
      .prev_predicted_flag_i		(execute_predicted_flag_o),
      .flag_i				(ctrl_flag_o),
    );*/
   mor1kx_branch_prediction
     #(
       .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH)
       )
   mor1kx_branch_prediction
     (/*AUTOINST*/
      // Outputs
      .predicted_flag_o			(predicted_flag_o),
      .branch_mispredict_o		(branch_mispredict_o),
      // Inputs
      .clk				(clk),
      .rst				(rst),
      .op_bf_i				(decode_op_bf_o),	 // Templated
      .op_bnf_i				(decode_op_bnf_o),	 // Templated
      .immjbr_upper_i			(decode_immjbr_upper_o), // Templated
      .prev_op_brcond_i			(execute_op_brcond_o),	 // Templated
      .prev_predicted_flag_i		(execute_predicted_flag_o), // Templated
      .flag_i				(ctrl_flag_o));		 // Templated

   /* mor1kx_execute_alu AUTO_TEMPLATE (
    .padv_decode_i			(padv_decode_o),
    .padv_execute_i			(padv_execute_o),
    .padv_ctrl_i			(padv_ctrl_o),
    .opc_alu_i			        (execute_opc_alu_o),
    .opc_alu_secondary_i		(execute_opc_alu_secondary_o),
    .imm16_i				(execute_imm16_o),
    .decode_immediate_i			(decode_immediate_o),
    .decode_immediate_sel_i		(decode_immediate_sel_o),
    .immediate_i			(execute_immediate_o),
    .immediate_sel_i			(execute_immediate_sel_o),
    .decode_valid_i			(decode_valid_o),
    .decode_op_mul_i			(decode_op_mul_o),
    .op_alu_i				(execute_op_alu_o),
    .op_add_i				(execute_op_add_o),
    .op_mul_i				(execute_op_mul_o),
    .op_mul_signed_i			(execute_op_mul_signed_o),
    .op_mul_unsigned_i			(execute_op_mul_unsigned_o),
    .op_div_i				(execute_op_div_o),
    .op_div_signed_i			(execute_op_div_signed_o),
    .op_div_unsigned_i			(execute_op_div_unsigned_o),
    .op_shift_i				(execute_op_shift_o),
    .op_ffl1_i				(execute_op_ffl1_o),
    .op_setflag_i			(execute_op_setflag_o),
    .op_mtspr_i				(execute_op_mtspr_o),
    .op_mfspr_i				(execute_op_mfspr_o),
    .op_movhi_i				(execute_op_movhi_o),
    .op_jbr_i				(execute_op_jbr_o),
    .op_jr_i				(execute_op_jr_o),
    .immjbr_upper_i			(execute_immjbr_upper_o),
    .pc_execute_i			(pc_decode_to_execute),
    .adder_do_sub_i			(execute_adder_do_sub_o),
    .adder_do_carry_i			(execute_adder_do_carry_o),
    .decode_rfa_i			(decode_rfa_o),
    .decode_rfb_i			(decode_rfb_o),
    .rfa_i				(execute_rfa_o),
    .rfb_i				(execute_rfb_o),
    .flag_i				(ctrl_flag_o),
    .carry_i                            (ctrl_carry_o),
    ); */
   mor1kx_execute_alu
     #(
       .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH),
       .FEATURE_OVERFLOW(FEATURE_OVERFLOW),
       .FEATURE_CARRY_FLAG(FEATURE_CARRY_FLAG),
       .FEATURE_MULTIPLIER(FEATURE_MULTIPLIER),
       .FEATURE_DIVIDER(FEATURE_DIVIDER),
       .FEATURE_ADDC(FEATURE_ADDC),
       .FEATURE_SRA(FEATURE_SRA),
       .FEATURE_ROR(FEATURE_ROR),
       .FEATURE_EXT(FEATURE_EXT),
       .FEATURE_CMOV(FEATURE_CMOV),
       .FEATURE_FFL1(FEATURE_FFL1),
       .FEATURE_CUST1(FEATURE_CUST1),
       .FEATURE_CUST2(FEATURE_CUST2),
       .FEATURE_CUST3(FEATURE_CUST3),
       .FEATURE_CUST4(FEATURE_CUST4),
       .FEATURE_CUST5(FEATURE_CUST5),
       .FEATURE_CUST6(FEATURE_CUST6),
       .FEATURE_CUST7(FEATURE_CUST7),
       .FEATURE_CUST8(FEATURE_CUST8),
       .OPTION_SHIFTER(OPTION_SHIFTER),
       .CALCULATE_BRANCH_DEST("FALSE")
       )
     mor1kx_execute_alu
     (/*AUTOINST*/
      // Outputs
      .flag_set_o			(flag_set_o),
      .flag_clear_o			(flag_clear_o),
      .carry_set_o			(carry_set_o),
      .carry_clear_o			(carry_clear_o),
      .overflow_set_o			(overflow_set_o),
      .overflow_clear_o			(overflow_clear_o),
      .alu_result_o			(alu_result_o[OPTION_OPERAND_WIDTH-1:0]),
      .alu_valid_o			(alu_valid_o),
      .mul_result_o			(mul_result_o[OPTION_OPERAND_WIDTH-1:0]),
      .adder_result_o			(adder_result_o[OPTION_OPERAND_WIDTH-1:0]),
      // Inputs
      .clk				(clk),
      .rst				(rst),
      .padv_decode_i			(padv_decode_o),	 // Templated
      .padv_execute_i			(padv_execute_o),	 // Templated
      .padv_ctrl_i			(padv_ctrl_o),		 // Templated
      .opc_alu_i			(execute_opc_alu_o),	 // Templated
      .opc_alu_secondary_i		(execute_opc_alu_secondary_o), // Templated
      .imm16_i				(execute_imm16_o),	 // Templated
      .immediate_i			(execute_immediate_o),	 // Templated
      .immediate_sel_i			(execute_immediate_sel_o), // Templated
      .decode_immediate_i		(decode_immediate_o),	 // Templated
      .decode_immediate_sel_i		(decode_immediate_sel_o), // Templated
      .decode_valid_i			(decode_valid_o),	 // Templated
      .decode_op_mul_i			(decode_op_mul_o),	 // Templated
      .op_alu_i				(execute_op_alu_o),	 // Templated
      .op_add_i				(execute_op_add_o),	 // Templated
      .op_mul_i				(execute_op_mul_o),	 // Templated
      .op_mul_signed_i			(execute_op_mul_signed_o), // Templated
      .op_mul_unsigned_i		(execute_op_mul_unsigned_o), // Templated
      .op_div_i				(execute_op_div_o),	 // Templated
      .op_div_signed_i			(execute_op_div_signed_o), // Templated
      .op_div_unsigned_i		(execute_op_div_unsigned_o), // Templated
      .op_shift_i			(execute_op_shift_o),	 // Templated
      .op_ffl1_i			(execute_op_ffl1_o),	 // Templated
      .op_setflag_i			(execute_op_setflag_o),	 // Templated
      .op_mtspr_i			(execute_op_mtspr_o),	 // Templated
      .op_mfspr_i			(execute_op_mfspr_o),	 // Templated
      .op_movhi_i			(execute_op_movhi_o),	 // Templated
      .op_jbr_i				(execute_op_jbr_o),	 // Templated
      .op_jr_i				(execute_op_jr_o),	 // Templated
      .immjbr_upper_i			(execute_immjbr_upper_o), // Templated
      .pc_execute_i			(pc_decode_to_execute),	 // Templated
      .adder_do_sub_i			(execute_adder_do_sub_o), // Templated
      .adder_do_carry_i			(execute_adder_do_carry_o), // Templated
      .decode_rfa_i			(decode_rfa_o),		 // Templated
      .decode_rfb_i			(decode_rfb_o),		 // Templated
      .rfa_i				(execute_rfa_o),	 // Templated
      .rfb_i				(execute_rfb_o),	 // Templated
      .flag_i				(ctrl_flag_o),		 // Templated
      .carry_i				(ctrl_carry_o));		 // Templated


   /* mor1kx_lsu_cappuccino AUTO_TEMPLATE (
    .padv_execute_i			(padv_execute_o),
    .padv_ctrl_i			(padv_ctrl_o),
    .decode_valid_i			(decode_valid_o),
    .exec_lsu_adr_i			(adder_result_o),
    .ctrl_lsu_adr_i			(ctrl_lsu_adr_o),
    .ctrl_rfb_i				(ctrl_rfb_o),
    .exec_op_lsu_load_i			(execute_op_lsu_load_o),
    .exec_op_lsu_store_i		(execute_op_lsu_store_o),
    .exec_op_lsu_atomic_i		(execute_op_lsu_atomic_o),
    .ctrl_op_lsu_load_i			(ctrl_op_lsu_load_o),
    .ctrl_op_lsu_store_i		(ctrl_op_lsu_store_o),
    .ctrl_op_lsu_atomic_i		(ctrl_op_lsu_atomic_o),
    .ctrl_lsu_length_i			(ctrl_lsu_length_o),
    .ctrl_lsu_zext_i			(ctrl_lsu_zext_o),
    .ctrl_epcr_i			(ctrl_epcr_o),
    .pipeline_flush_i			(pipeline_flush_o),
    .dc_enable_i			(spr_sr_o[`OR1K_SPR_SR_DCE]),
    .dmmu_enable_i			(spr_sr_o[`OR1K_SPR_SR_DME]),
    .supervisor_mode_i			(spr_sr_o[`OR1K_SPR_SR_SM]),
    .spr_bus_dat_dc_o			(spr_bus_dat_dc_i[OPTION_OPERAND_WIDTH-1:0]),
    .spr_bus_ack_dc_o			(spr_bus_ack_dc_i),
    .spr_bus_dat_dmmu_o			(spr_bus_dat_dmmu_i[OPTION_OPERAND_WIDTH-1:0]),
    .spr_bus_ack_dmmu_o			(spr_bus_ack_dmmu_i),
    .spr_bus_addr_i			(spr_bus_addr_o[15:0]),
    .spr_bus_we_i			(spr_bus_we_o),
    .spr_bus_stb_i			(spr_bus_stb_o),
    .spr_bus_dat_i			(spr_bus_dat_o[OPTION_OPERAND_WIDTH-1:0]),
    ); */
   mor1kx_lsu_cappuccino
     #(
       .FEATURE_DATACACHE(FEATURE_DATACACHE),
       .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH),
       .OPTION_DCACHE_BLOCK_WIDTH(OPTION_DCACHE_BLOCK_WIDTH),
       .OPTION_DCACHE_SET_WIDTH(OPTION_DCACHE_SET_WIDTH),
       .OPTION_DCACHE_WAYS(OPTION_DCACHE_WAYS),
       .OPTION_DCACHE_LIMIT_WIDTH(OPTION_DCACHE_LIMIT_WIDTH),
       .OPTION_DCACHE_SNOOP(OPTION_DCACHE_SNOOP),
       .FEATURE_DMMU(FEATURE_DMMU),
       .FEATURE_DMMU_HW_TLB_RELOAD(FEATURE_DMMU_HW_TLB_RELOAD),
       .OPTION_DMMU_SET_WIDTH(OPTION_DMMU_SET_WIDTH),
       .OPTION_DMMU_WAYS(OPTION_DMMU_WAYS),
       .FEATURE_STORE_BUFFER(FEATURE_STORE_BUFFER),
       .OPTION_STORE_BUFFER_DEPTH_WIDTH(OPTION_STORE_BUFFER_DEPTH_WIDTH),
       .FEATURE_ATOMIC(FEATURE_ATOMIC)
       )
     mor1kx_lsu_cappuccino
     (/*AUTOINST*/
      // Outputs
      .store_buffer_epcr_o		(store_buffer_epcr_o[OPTION_OPERAND_WIDTH-1:0]),
      .lsu_result_o			(lsu_result_o[OPTION_OPERAND_WIDTH-1:0]),
      .lsu_valid_o			(lsu_valid_o),
      .lsu_except_dbus_o		(lsu_except_dbus_o),
      .lsu_except_align_o		(lsu_except_align_o),
      .lsu_except_dtlb_miss_o		(lsu_except_dtlb_miss_o),
      .lsu_except_dpagefault_o		(lsu_except_dpagefault_o),
      .store_buffer_err_o		(store_buffer_err_o),
      .atomic_flag_set_o		(atomic_flag_set_o),
      .atomic_flag_clear_o		(atomic_flag_clear_o),
      .spr_bus_dat_dc_o			(spr_bus_dat_dc_i[OPTION_OPERAND_WIDTH-1:0]), // Templated
      .spr_bus_ack_dc_o			(spr_bus_ack_dc_i),	 // Templated
      .spr_bus_dat_dmmu_o		(spr_bus_dat_dmmu_i[OPTION_OPERAND_WIDTH-1:0]), // Templated
      .spr_bus_ack_dmmu_o		(spr_bus_ack_dmmu_i),	 // Templated
      .dbus_adr_o			(dbus_adr_o[OPTION_OPERAND_WIDTH-1:0]),
      .dbus_req_o			(dbus_req_o),
      .dbus_dat_o			(dbus_dat_o[OPTION_OPERAND_WIDTH-1:0]),
      .dbus_bsel_o			(dbus_bsel_o[3:0]),
      .dbus_we_o			(dbus_we_o),
      .dbus_burst_o			(dbus_burst_o),
      // Inputs
      .clk				(clk),
      .rst				(rst),
      .padv_execute_i			(padv_execute_o),	 // Templated
      .padv_ctrl_i			(padv_ctrl_o),		 // Templated
      .decode_valid_i			(decode_valid_o),	 // Templated
      .exec_lsu_adr_i			(adder_result_o),	 // Templated
      .ctrl_lsu_adr_i			(ctrl_lsu_adr_o),	 // Templated
      .ctrl_rfb_i			(ctrl_rfb_o),		 // Templated
      .exec_op_lsu_load_i		(execute_op_lsu_load_o), // Templated
      .exec_op_lsu_store_i		(execute_op_lsu_store_o), // Templated
      .exec_op_lsu_atomic_i		(execute_op_lsu_atomic_o), // Templated
      .ctrl_op_lsu_load_i		(ctrl_op_lsu_load_o),	 // Templated
      .ctrl_op_lsu_store_i		(ctrl_op_lsu_store_o),	 // Templated
      .ctrl_op_lsu_atomic_i		(ctrl_op_lsu_atomic_o),	 // Templated
      .ctrl_lsu_length_i		(ctrl_lsu_length_o),	 // Templated
      .ctrl_lsu_zext_i			(ctrl_lsu_zext_o),	 // Templated
      .ctrl_epcr_i			(ctrl_epcr_o),		 // Templated
      .spr_bus_addr_i			(spr_bus_addr_o[15:0]),	 // Templated
      .spr_bus_we_i			(spr_bus_we_o),		 // Templated
      .spr_bus_stb_i			(spr_bus_stb_o),	 // Templated
      .spr_bus_dat_i			(spr_bus_dat_o[OPTION_OPERAND_WIDTH-1:0]), // Templated
      .dc_enable_i			(spr_sr_o[`OR1K_SPR_SR_DCE]), // Templated
      .dmmu_enable_i			(spr_sr_o[`OR1K_SPR_SR_DME]), // Templated
      .supervisor_mode_i		(spr_sr_o[`OR1K_SPR_SR_SM]), // Templated
      .dbus_err_i			(dbus_err_i),
      .dbus_ack_i			(dbus_ack_i),
      .dbus_dat_i			(dbus_dat_i[OPTION_OPERAND_WIDTH-1:0]),
      .pipeline_flush_i			(pipeline_flush_o),	 // Templated
      .snoop_adr_i			(snoop_adr_i[31:0]),
      .snoop_en_i			(snoop_en_i));


   /* mor1kx_wb_mux_cappuccino AUTO_TEMPLATE (
    .alu_result_i			(ctrl_alu_result_o),
    .lsu_result_i			(lsu_result_o),
    .mul_result_i			(mul_result_o),
    .spr_i				(mfspr_dat_o),
    .op_mul_i				(ctrl_op_mul_o),
    .op_lsu_load_i			(ctrl_op_lsu_load_o),
    .pc_i				(pc_execute_to_ctrl),
    .op_mfspr_i			        (ctrl_op_mfspr_o),
    ); */
   mor1kx_wb_mux_cappuccino
     #(
       .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH)
       )
     mor1kx_wb_mux_cappuccino
     (/*AUTOINST*/
      // Outputs
      .rf_result_o			(rf_result_o[OPTION_OPERAND_WIDTH-1:0]),
      // Inputs
      .clk				(clk),
      .rst				(rst),
      .alu_result_i			(ctrl_alu_result_o),	 // Templated
      .lsu_result_i			(lsu_result_o),		 // Templated
      .mul_result_i			(mul_result_o),		 // Templated
      .spr_i				(mfspr_dat_o),		 // Templated
      .op_mul_i				(ctrl_op_mul_o),	 // Templated
      .op_lsu_load_i			(ctrl_op_lsu_load_o),	 // Templated
      .op_mfspr_i			(ctrl_op_mfspr_o));	 // Templated


   /* mor1kx_rf_cappuccino AUTO_TEMPLATE (
    .padv_decode_i			(padv_decode_o),
    .padv_execute_i			(padv_execute_o),
    .padv_ctrl_i			(padv_ctrl_o),
    .fetch_rf_adr_valid_i		(fetch_rf_adr_valid_o),
    .fetch_rfa_adr_i			(fetch_rfa_adr_o),
    .fetch_rfb_adr_i			(fetch_rfb_adr_o),
    .decode_valid_i			(decode_valid_o),
    .decode_rfa_adr_i  			(decode_rfa_adr_o),
    .decode_rfb_adr_i  			(decode_rfb_adr_o),
    .execute_rfd_adr_i			(execute_rfd_adr_o),
    .ctrl_rfd_adr_i			(ctrl_rfd_adr_o),
    .wb_rfd_adr_i  			(wb_rfd_adr_o),
    .spr_bus_addr_i			(spr_bus_addr_o[15:0]),
    .spr_bus_stb_i			(spr_bus_stb_o),
    .spr_bus_we_i			(spr_bus_we_o),
    .spr_bus_dat_i			(spr_bus_dat_o),
    .execute_rf_wb_i			(execute_rf_wb_o),
    .ctrl_rf_wb_i			(ctrl_rf_wb_o),
    .wb_rf_wb_i				(wb_rf_wb_o),
    .result_i				(rf_result_o),
    .ctrl_alu_result_i			(ctrl_alu_result_o),
    .pipeline_flush_i			(pipeline_flush_o),
    ); */
   mor1kx_rf_cappuccino
     #(
       .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH),
       .FEATURE_FASTCONTEXTS(FEATURE_FASTCONTEXTS),
       .OPTION_RF_NUM_SHADOW_GPR(OPTION_RF_NUM_SHADOW_GPR),
       .OPTION_RF_ADDR_WIDTH(OPTION_RF_ADDR_WIDTH),
       .OPTION_RF_WORDS(OPTION_RF_WORDS),
       .FEATURE_DEBUGUNIT(FEATURE_DEBUGUNIT)
       )
     mor1kx_rf_cappuccino
     (/*AUTOINST*/
      // Outputs
      .spr_gpr_ack_o			(spr_gpr_ack_o),
      .spr_gpr_dat_o			(spr_gpr_dat_o[OPTION_OPERAND_WIDTH-1:0]),
      .decode_rfa_o			(decode_rfa_o[OPTION_OPERAND_WIDTH-1:0]),
      .decode_rfb_o			(decode_rfb_o[OPTION_OPERAND_WIDTH-1:0]),
      .execute_rfa_o			(execute_rfa_o[OPTION_OPERAND_WIDTH-1:0]),
      .execute_rfb_o			(execute_rfb_o[OPTION_OPERAND_WIDTH-1:0]),
      // Inputs
      .clk				(clk),
      .rst				(rst),
      .padv_decode_i			(padv_decode_o),	 // Templated
      .padv_execute_i			(padv_execute_o),	 // Templated
      .padv_ctrl_i			(padv_ctrl_o),		 // Templated
      .decode_valid_i			(decode_valid_o),	 // Templated
      .fetch_rf_adr_valid_i		(fetch_rf_adr_valid_o),	 // Templated
      .fetch_rfa_adr_i			(fetch_rfa_adr_o),	 // Templated
      .fetch_rfb_adr_i			(fetch_rfb_adr_o),	 // Templated
      .decode_rfa_adr_i			(decode_rfa_adr_o),	 // Templated
      .decode_rfb_adr_i			(decode_rfb_adr_o),	 // Templated
      .execute_rfd_adr_i		(execute_rfd_adr_o),	 // Templated
      .ctrl_rfd_adr_i			(ctrl_rfd_adr_o),	 // Templated
      .wb_rfd_adr_i			(wb_rfd_adr_o),		 // Templated
      .spr_bus_addr_i			(spr_bus_addr_o[15:0]),	 // Templated
      .spr_bus_stb_i			(spr_bus_stb_o),	 // Templated
      .spr_bus_we_i			(spr_bus_we_o),		 // Templated
      .spr_bus_dat_i			(spr_bus_dat_o),	 // Templated
      .execute_rf_wb_i			(execute_rf_wb_o),	 // Templated
      .ctrl_rf_wb_i			(ctrl_rf_wb_o),		 // Templated
      .wb_rf_wb_i			(wb_rf_wb_o),		 // Templated
      .result_i				(rf_result_o),		 // Templated
      .ctrl_alu_result_i		(ctrl_alu_result_o),	 // Templated
      .pipeline_flush_i			(pipeline_flush_o));	 // Templated


`ifndef SYNTHESIS
// synthesis translate_off
   /* Debug signals required for the debug monitor */
   function [OPTION_OPERAND_WIDTH-1:0] get_gpr;
      // verilator public
      input [4:0] 		   gpr_num;
      begin
	 // TODO: handle load ops
	 if ((mor1kx_rf_cappuccino.execute_rfd_adr_i == gpr_num) &
	     mor1kx_rf_cappuccino.execute_rf_wb_i)
	   get_gpr = alu_result_o;
	 else if ((mor1kx_rf_cappuccino.ctrl_rfd_adr_i == gpr_num) &
		  mor1kx_rf_cappuccino.ctrl_rf_wb_i)
	   get_gpr = ctrl_alu_result_o;
	 else if ((mor1kx_rf_cappuccino.wb_rfd_adr_i == gpr_num) &
		  mor1kx_rf_cappuccino.wb_rf_wb_i)
	   get_gpr = mor1kx_rf_cappuccino.result_i;
	 else
	   get_gpr = mor1kx_rf_cappuccino.rfa.mem[gpr_num];
      end
   endfunction //


   task set_gpr;
      // verilator public
      input [4:0] gpr_num;
      input [OPTION_OPERAND_WIDTH-1:0] gpr_value;
      begin
	 mor1kx_rf_cappuccino.rfa.mem[gpr_num] = gpr_value;
	 mor1kx_rf_cappuccino.rfb.mem[gpr_num] = gpr_value;
      end
   endtask
// synthesis translate_on
`endif


   /* mor1kx_execute_ctrl_cappuccino AUTO_TEMPLATE (
    .padv_i				(padv_execute_o),
    .padv_ctrl_i			(padv_ctrl_o),
    .execute_except_ibus_err_i		(execute_except_ibus_err_o),
    .execute_except_itlb_miss_i		(execute_except_itlb_miss_o),
    .execute_except_ipagefault_i	(execute_except_ipagefault_o),
    .execute_except_illegal_i		(execute_except_illegal_o),
    .execute_except_ibus_align_i	(execute_except_ibus_align_o),
    .execute_except_syscall_i		(execute_except_syscall_o),
    .execute_except_trap_i		(execute_except_trap_o),
    .lsu_except_dbus_i  		(lsu_except_dbus_o),
    .lsu_except_align_i			(lsu_except_align_o),
    .lsu_except_dtlb_miss_i		(lsu_except_dtlb_miss_o),
    .lsu_except_dpagefault_i		(lsu_except_dpagefault_o),
    .op_mul_i				(execute_op_mul_o),
    .op_lsu_load_i			(execute_op_lsu_load_o),
    .op_lsu_store_i			(execute_op_lsu_store_o),
    .op_lsu_atomic_i			(execute_op_lsu_atomic_o),
    .lsu_length_i			(execute_lsu_length_o),
    .lsu_zext_i				(execute_lsu_zext_o),
    .op_mfspr_i				(execute_op_mfspr_o),
    .op_mtspr_i				(execute_op_mtspr_o),
    .alu_valid_i			(alu_valid_o),
    .lsu_valid_i			(lsu_valid_o),
    .alu_result_i			(alu_result_o),
    .adder_result_i			(adder_result_o),
    .execute_jal_result_i		(execute_jal_result_o),
    .op_jr_i				(execute_op_jr_o),
    .op_jal_i				(execute_op_jal_o),
    .op_rfe_i				(execute_op_rfe_o),
    .rfb_i				(execute_rfb_o),
    .flag_set_i 			(flag_set_o),
    .flag_clear_i			(flag_clear_o),
    .pc_execute_i			(pc_decode_to_execute),
    .execute_rf_wb_i			(execute_rf_wb_o),
    .execute_rfd_adr_i			(execute_rfd_adr_o),
    .ctrl_mfspr_ack_i			(ctrl_mfspr_ack_o),
    .ctrl_mtspr_ack_i			(ctrl_mtspr_ack_o),
    .pipeline_flush_i			(pipeline_flush_o),
    .pc_ctrl_o				(pc_execute_to_ctrl),
    .execute_bubble_i			(execute_bubble_o),
    .carry_set_i		        (carry_set_o),
    .carry_clear_i		        (carry_clear_o),
    .overflow_set_i		        (overflow_set_o),
    .overflow_clear_i		        (overflow_clear_o),
    ); */
   mor1kx_execute_ctrl_cappuccino
     #(
       .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH),
       .OPTION_RESET_PC(OPTION_RESET_PC),
       .FEATURE_MULTIPLIER(FEATURE_MULTIPLIER)
       )
     mor1kx_execute_ctrl_cappuccino
     (/*AUTOINST*/
      // Outputs
      .ctrl_rf_wb_o			(ctrl_rf_wb_o),
      .wb_rf_wb_o			(wb_rf_wb_o),
      .ctrl_rfd_adr_o			(ctrl_rfd_adr_o[OPTION_RF_ADDR_WIDTH-1:0]),
      .wb_rfd_adr_o			(wb_rfd_adr_o[OPTION_RF_ADDR_WIDTH-1:0]),
      .ctrl_alu_result_o		(ctrl_alu_result_o[OPTION_OPERAND_WIDTH-1:0]),
      .ctrl_lsu_adr_o			(ctrl_lsu_adr_o[OPTION_OPERAND_WIDTH-1:0]),
      .ctrl_rfb_o			(ctrl_rfb_o[OPTION_OPERAND_WIDTH-1:0]),
      .ctrl_flag_set_o			(ctrl_flag_set_o),
      .ctrl_flag_clear_o		(ctrl_flag_clear_o),
      .ctrl_carry_set_o			(ctrl_carry_set_o),
      .ctrl_carry_clear_o		(ctrl_carry_clear_o),
      .ctrl_overflow_set_o		(ctrl_overflow_set_o),
      .ctrl_overflow_clear_o		(ctrl_overflow_clear_o),
      .pc_ctrl_o			(pc_execute_to_ctrl),	 // Templated
      .ctrl_op_mul_o			(ctrl_op_mul_o),
      .ctrl_op_lsu_load_o		(ctrl_op_lsu_load_o),
      .ctrl_op_lsu_store_o		(ctrl_op_lsu_store_o),
      .ctrl_op_lsu_atomic_o		(ctrl_op_lsu_atomic_o),
      .ctrl_lsu_length_o		(ctrl_lsu_length_o[1:0]),
      .ctrl_lsu_zext_o			(ctrl_lsu_zext_o),
      .ctrl_op_mfspr_o			(ctrl_op_mfspr_o),
      .ctrl_op_mtspr_o			(ctrl_op_mtspr_o),
      .ctrl_op_rfe_o			(ctrl_op_rfe_o),
      .ctrl_except_ibus_err_o		(ctrl_except_ibus_err_o),
      .ctrl_except_itlb_miss_o		(ctrl_except_itlb_miss_o),
      .ctrl_except_ipagefault_o		(ctrl_except_ipagefault_o),
      .ctrl_except_ibus_align_o		(ctrl_except_ibus_align_o),
      .ctrl_except_illegal_o		(ctrl_except_illegal_o),
      .ctrl_except_syscall_o		(ctrl_except_syscall_o),
      .ctrl_except_dbus_o		(ctrl_except_dbus_o),
      .ctrl_except_dtlb_miss_o		(ctrl_except_dtlb_miss_o),
      .ctrl_except_dpagefault_o		(ctrl_except_dpagefault_o),
      .ctrl_except_align_o		(ctrl_except_align_o),
      .ctrl_except_trap_o		(ctrl_except_trap_o),
      .execute_valid_o			(execute_valid_o),
      .ctrl_valid_o			(ctrl_valid_o),
      // Inputs
      .clk				(clk),
      .rst				(rst),
      .padv_i				(padv_execute_o),	 // Templated
      .padv_ctrl_i			(padv_ctrl_o),		 // Templated
      .execute_except_ibus_err_i	(execute_except_ibus_err_o), // Templated
      .execute_except_itlb_miss_i	(execute_except_itlb_miss_o), // Templated
      .execute_except_ipagefault_i	(execute_except_ipagefault_o), // Templated
      .execute_except_illegal_i		(execute_except_illegal_o), // Templated
      .execute_except_ibus_align_i	(execute_except_ibus_align_o), // Templated
      .execute_except_syscall_i		(execute_except_syscall_o), // Templated
      .lsu_except_dbus_i		(lsu_except_dbus_o),	 // Templated
      .lsu_except_align_i		(lsu_except_align_o),	 // Templated
      .lsu_except_dtlb_miss_i		(lsu_except_dtlb_miss_o), // Templated
      .lsu_except_dpagefault_i		(lsu_except_dpagefault_o), // Templated
      .execute_except_trap_i		(execute_except_trap_o), // Templated
      .pipeline_flush_i			(pipeline_flush_o),	 // Templated
      .op_mul_i				(execute_op_mul_o),	 // Templated
      .op_lsu_load_i			(execute_op_lsu_load_o), // Templated
      .op_lsu_store_i			(execute_op_lsu_store_o), // Templated
      .op_lsu_atomic_i			(execute_op_lsu_atomic_o), // Templated
      .lsu_length_i			(execute_lsu_length_o),	 // Templated
      .lsu_zext_i			(execute_lsu_zext_o),	 // Templated
      .op_mfspr_i			(execute_op_mfspr_o),	 // Templated
      .op_mtspr_i			(execute_op_mtspr_o),	 // Templated
      .alu_valid_i			(alu_valid_o),		 // Templated
      .lsu_valid_i			(lsu_valid_o),		 // Templated
      .op_jr_i				(execute_op_jr_o),	 // Templated
      .op_jal_i				(execute_op_jal_o),	 // Templated
      .op_rfe_i				(execute_op_rfe_o),	 // Templated
      .alu_result_i			(alu_result_o),		 // Templated
      .adder_result_i			(adder_result_o),	 // Templated
      .rfb_i				(execute_rfb_o),	 // Templated
      .execute_jal_result_i		(execute_jal_result_o),	 // Templated
      .flag_set_i			(flag_set_o),		 // Templated
      .flag_clear_i			(flag_clear_o),		 // Templated
      .carry_set_i			(carry_set_o),		 // Templated
      .carry_clear_i			(carry_clear_o),	 // Templated
      .overflow_set_i			(overflow_set_o),	 // Templated
      .overflow_clear_i			(overflow_clear_o),	 // Templated
      .pc_execute_i			(pc_decode_to_execute),	 // Templated
      .execute_rf_wb_i			(execute_rf_wb_o),	 // Templated
      .execute_rfd_adr_i		(execute_rfd_adr_o),	 // Templated
      .execute_bubble_i			(execute_bubble_o),	 // Templated
      .ctrl_mfspr_ack_i			(ctrl_mfspr_ack_o),	 // Templated
      .ctrl_mtspr_ack_i			(ctrl_mtspr_ack_o));	 // Templated

   /* mor1kx_ctrl_cappuccino AUTO_TEMPLATE (
    .ctrl_alu_result_i		(ctrl_alu_result_o),
    .ctrl_lsu_adr_i		(ctrl_lsu_adr_o),
    .ctrl_rfb_i			(ctrl_rfb_o),
    .ctrl_flag_set_i		(ctrl_flag_set_o),
    .ctrl_flag_clear_i		(ctrl_flag_clear_o),
    .atomic_flag_set_i		(atomic_flag_set_o),
    .atomic_flag_clear_i	(atomic_flag_clear_o),
    .pc_ctrl_i			(pc_execute_to_ctrl),
    .pc_execute_i		(pc_decode_to_execute),
    .execute_op_branch_i	(execute_op_branch_o),
    .ctrl_op_mfspr_i		(ctrl_op_mfspr_o),
    .ctrl_op_mtspr_i		(ctrl_op_mtspr_o),
    .ctrl_op_rfe_i		(ctrl_op_rfe_o),
    .decode_branch_i		(decode_branch_o),
    .decode_branch_target_i	(decode_branch_target_o),
    .branch_mispredict_i	(branch_mispredict_o),
    .execute_mispredict_target_i	(execute_mispredict_target_o),
    .except_ibus_err_i		(ctrl_except_ibus_err_o),
    .except_itlb_miss_i		(ctrl_except_itlb_miss_o),
    .except_ipagefault_i	(ctrl_except_ipagefault_o),
    .except_ibus_align_i	(ctrl_except_ibus_align_o),
    .except_illegal_i		(ctrl_except_illegal_o),
    .except_syscall_i		(ctrl_except_syscall_o),
    .except_dbus_i		(ctrl_except_dbus_o),
    .except_dtlb_miss_i		(ctrl_except_dtlb_miss_o),
    .except_dpagefault_i	(ctrl_except_dpagefault_o),
    .except_trap_i		(ctrl_except_trap_o),
    .except_align_i		(ctrl_except_align_o),
    .fetch_valid_i		(fetch_valid_o),
    .decode_valid_i		(decode_valid_o),
    .execute_valid_i		(execute_valid_o),
    .ctrl_valid_i		(ctrl_valid_o),
    .fetch_exception_taken_i	(fetch_exception_taken_o),
    .decode_bubble_i		(decode_bubble_o),
    .execute_bubble_i		(execute_bubble_o),
    .store_buffer_epcr_i	(store_buffer_epcr_o),
    .store_buffer_err_i		(store_buffer_err_o),
    .ctrl_carry_set_i		(ctrl_carry_set_o),
    .ctrl_carry_clear_i		(ctrl_carry_clear_o),
    .ctrl_overflow_set_i       (ctrl_overflow_set_o),
    .ctrl_overflow_clear_i	(ctrl_overflow_clear_o),
    .spr_gpr_ack_i		(spr_gpr_ack_o),
    .spr_gpr_dat_i		(spr_gpr_dat_o),
    ) */
   mor1kx_ctrl_cappuccino
     #(
       .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH),
       .OPTION_RESET_PC(OPTION_RESET_PC),
       .FEATURE_PIC(FEATURE_PIC),
       .FEATURE_TIMER(FEATURE_TIMER),
       .OPTION_PIC_TRIGGER(OPTION_PIC_TRIGGER),
       .OPTION_PIC_NMI_WIDTH(OPTION_PIC_NMI_WIDTH),
       .FEATURE_DATACACHE(FEATURE_DATACACHE),
       .OPTION_DCACHE_BLOCK_WIDTH(OPTION_DCACHE_BLOCK_WIDTH),
       .OPTION_DCACHE_SET_WIDTH(OPTION_DCACHE_SET_WIDTH),
       .OPTION_DCACHE_WAYS(OPTION_DCACHE_WAYS),
       .FEATURE_DMMU(FEATURE_DMMU),
       .OPTION_DMMU_SET_WIDTH(OPTION_DMMU_SET_WIDTH),
       .OPTION_DMMU_WAYS(OPTION_DMMU_WAYS),
       .FEATURE_INSTRUCTIONCACHE(FEATURE_INSTRUCTIONCACHE),
       .OPTION_ICACHE_BLOCK_WIDTH(OPTION_ICACHE_BLOCK_WIDTH),
       .OPTION_ICACHE_SET_WIDTH(OPTION_ICACHE_SET_WIDTH),
       .OPTION_ICACHE_WAYS(OPTION_ICACHE_WAYS),
       .FEATURE_IMMU(FEATURE_IMMU),
       .OPTION_IMMU_SET_WIDTH(OPTION_IMMU_SET_WIDTH),
       .OPTION_IMMU_WAYS(OPTION_IMMU_WAYS),
       .FEATURE_DEBUGUNIT(FEATURE_DEBUGUNIT),
       .FEATURE_PERFCOUNTERS(FEATURE_PERFCOUNTERS),
       .FEATURE_MAC(FEATURE_MAC),
       .FEATURE_MULTICORE(FEATURE_MULTICORE),
       .FEATURE_SYSCALL(FEATURE_SYSCALL),
       .FEATURE_TRAP(FEATURE_TRAP),
       .FEATURE_RANGE(FEATURE_RANGE),
       .FEATURE_DSX(FEATURE_DSX),
       .FEATURE_FASTCONTEXTS(FEATURE_FASTCONTEXTS),
       .OPTION_RF_NUM_SHADOW_GPR(OPTION_RF_NUM_SHADOW_GPR),
       .FEATURE_OVERFLOW(FEATURE_OVERFLOW),
       .FEATURE_CARRY_FLAG(FEATURE_CARRY_FLAG)
       )
     mor1kx_ctrl_cappuccino
     (/*AUTOINST*/
      // Outputs
      .ctrl_epcr_o			(ctrl_epcr_o[OPTION_OPERAND_WIDTH-1:0]),
      .mfspr_dat_o			(mfspr_dat_o[OPTION_OPERAND_WIDTH-1:0]),
      .ctrl_mfspr_ack_o			(ctrl_mfspr_ack_o),
      .ctrl_mtspr_ack_o			(ctrl_mtspr_ack_o),
      .ctrl_flag_o			(ctrl_flag_o),
      .ctrl_carry_o			(ctrl_carry_o),
      .ctrl_branch_exception_o		(ctrl_branch_exception_o),
      .ctrl_branch_except_pc_o		(ctrl_branch_except_pc_o[OPTION_OPERAND_WIDTH-1:0]),
      .pipeline_flush_o			(pipeline_flush_o),
      .doing_rfe_o			(doing_rfe_o),
      .padv_fetch_o			(padv_fetch_o),
      .padv_decode_o			(padv_decode_o),
      .padv_execute_o			(padv_execute_o),
      .padv_ctrl_o			(padv_ctrl_o),
      .du_dat_o				(du_dat_o[OPTION_OPERAND_WIDTH-1:0]),
      .du_ack_o				(du_ack_o),
      .du_stall_o			(du_stall_o),
      .du_restart_pc_o			(du_restart_pc_o[OPTION_OPERAND_WIDTH-1:0]),
      .du_restart_o			(du_restart_o),
      .spr_bus_addr_o			(spr_bus_addr_o[15:0]),
      .spr_bus_we_o			(spr_bus_we_o),
      .spr_bus_stb_o			(spr_bus_stb_o),
      .spr_bus_dat_o			(spr_bus_dat_o[OPTION_OPERAND_WIDTH-1:0]),
      .spr_sr_o				(spr_sr_o[15:0]),
      .ctrl_bubble_o			(ctrl_bubble_o),
      // Inputs
      .clk				(clk),
      .rst				(rst),
      .ctrl_alu_result_i		(ctrl_alu_result_o),	 // Templated
      .ctrl_lsu_adr_i			(ctrl_lsu_adr_o),	 // Templated
      .ctrl_rfb_i			(ctrl_rfb_o),		 // Templated
      .ctrl_flag_set_i			(ctrl_flag_set_o),	 // Templated
      .ctrl_flag_clear_i		(ctrl_flag_clear_o),	 // Templated
      .atomic_flag_set_i		(atomic_flag_set_o),	 // Templated
      .atomic_flag_clear_i		(atomic_flag_clear_o),	 // Templated
      .pc_ctrl_i			(pc_execute_to_ctrl),	 // Templated
      .ctrl_op_mfspr_i			(ctrl_op_mfspr_o),	 // Templated
      .ctrl_op_mtspr_i			(ctrl_op_mtspr_o),	 // Templated
      .ctrl_op_rfe_i			(ctrl_op_rfe_o),	 // Templated
      .decode_branch_i			(decode_branch_o),	 // Templated
      .decode_branch_target_i		(decode_branch_target_o), // Templated
      .branch_mispredict_i		(branch_mispredict_o),	 // Templated
      .execute_mispredict_target_i	(execute_mispredict_target_o), // Templated
      .pc_execute_i			(pc_decode_to_execute),	 // Templated
      .execute_op_branch_i		(execute_op_branch_o),	 // Templated
      .except_ibus_err_i		(ctrl_except_ibus_err_o), // Templated
      .except_itlb_miss_i		(ctrl_except_itlb_miss_o), // Templated
      .except_ipagefault_i		(ctrl_except_ipagefault_o), // Templated
      .except_ibus_align_i		(ctrl_except_ibus_align_o), // Templated
      .except_illegal_i			(ctrl_except_illegal_o), // Templated
      .except_syscall_i			(ctrl_except_syscall_o), // Templated
      .except_dbus_i			(ctrl_except_dbus_o),	 // Templated
      .except_dtlb_miss_i		(ctrl_except_dtlb_miss_o), // Templated
      .except_dpagefault_i		(ctrl_except_dpagefault_o), // Templated
      .except_trap_i			(ctrl_except_trap_o),	 // Templated
      .except_align_i			(ctrl_except_align_o),	 // Templated
      .fetch_valid_i			(fetch_valid_o),	 // Templated
      .decode_valid_i			(decode_valid_o),	 // Templated
      .execute_valid_i			(execute_valid_o),	 // Templated
      .ctrl_valid_i			(ctrl_valid_o),		 // Templated
      .fetch_exception_taken_i		(fetch_exception_taken_o), // Templated
      .decode_bubble_i			(decode_bubble_o),	 // Templated
      .execute_bubble_i			(execute_bubble_o),	 // Templated
      .irq_i				(irq_i[31:0]),
      .store_buffer_epcr_i		(store_buffer_epcr_o),	 // Templated
      .store_buffer_err_i		(store_buffer_err_o),	 // Templated
      .ctrl_carry_set_i			(ctrl_carry_set_o),	 // Templated
      .ctrl_carry_clear_i		(ctrl_carry_clear_o),	 // Templated
      .ctrl_overflow_set_i		(ctrl_overflow_set_o),	 // Templated
      .ctrl_overflow_clear_i		(ctrl_overflow_clear_o), // Templated
      .du_addr_i			(du_addr_i[15:0]),
      .du_stb_i				(du_stb_i),
      .du_dat_i				(du_dat_i[OPTION_OPERAND_WIDTH-1:0]),
      .du_we_i				(du_we_i),
      .du_stall_i			(du_stall_i),
      .spr_bus_dat_dc_i			(spr_bus_dat_dc_i[OPTION_OPERAND_WIDTH-1:0]),
      .spr_bus_ack_dc_i			(spr_bus_ack_dc_i),
      .spr_bus_dat_ic_i			(spr_bus_dat_ic_i[OPTION_OPERAND_WIDTH-1:0]),
      .spr_bus_ack_ic_i			(spr_bus_ack_ic_i),
      .spr_bus_dat_dmmu_i		(spr_bus_dat_dmmu_i[OPTION_OPERAND_WIDTH-1:0]),
      .spr_bus_ack_dmmu_i		(spr_bus_ack_dmmu_i),
      .spr_bus_dat_immu_i		(spr_bus_dat_immu_i[OPTION_OPERAND_WIDTH-1:0]),
      .spr_bus_ack_immu_i		(spr_bus_ack_immu_i),
      .spr_bus_dat_mac_i		(spr_bus_dat_mac_i[OPTION_OPERAND_WIDTH-1:0]),
      .spr_bus_ack_mac_i		(spr_bus_ack_mac_i),
      .spr_bus_dat_pmu_i		(spr_bus_dat_pmu_i[OPTION_OPERAND_WIDTH-1:0]),
      .spr_bus_ack_pmu_i		(spr_bus_ack_pmu_i),
      .spr_bus_dat_pcu_i		(spr_bus_dat_pcu_i[OPTION_OPERAND_WIDTH-1:0]),
      .spr_bus_ack_pcu_i		(spr_bus_ack_pcu_i),
      .spr_bus_dat_fpu_i		(spr_bus_dat_fpu_i[OPTION_OPERAND_WIDTH-1:0]),
      .spr_bus_ack_fpu_i		(spr_bus_ack_fpu_i),
      .spr_gpr_dat_i			(spr_gpr_dat_o),	 // Templated
      .spr_gpr_ack_i			(spr_gpr_ack_o),	 // Templated
      .multicore_coreid_i		(multicore_coreid_i[OPTION_OPERAND_WIDTH-1:0]),
      .multicore_numcores_i		(multicore_numcores_i[OPTION_OPERAND_WIDTH-1:0]));

   reg [`OR1K_INSN_WIDTH-1:0] traceport_stage_decode_insn;
   reg [`OR1K_INSN_WIDTH-1:0] traceport_stage_exec_insn;

   reg 			      traceport_waitexec;

   always @(posedge clk) begin
      if (FEATURE_TRACEPORT_EXEC != "NONE") begin
	 if (rst) begin
	    traceport_waitexec <= 0;
	 end else begin
	    if (padv_decode_o) begin
	       traceport_stage_decode_insn <= insn_fetch_to_decode;
	    end

	    if (padv_execute_o) begin
	       traceport_stage_exec_insn <= traceport_stage_decode_insn;
	    end

	    if (padv_ctrl_o) begin
	       traceport_exec_insn_o <= traceport_stage_exec_insn;
	    end

	    traceport_exec_pc_o <= pc_execute_to_ctrl;
	    if (!traceport_waitexec) begin
	       if (padv_ctrl_o & !ctrl_bubble_o) begin
		  if (execute_valid_o) begin
		     traceport_exec_valid_o <= 1'b1;
		  end else begin
		     traceport_exec_valid_o <= 1'b0;
		     traceport_waitexec <= 1'b1;
		  end
	       end else begin
		  traceport_exec_valid_o <= 1'b0;
	       end
	    end else begin
	       if (execute_valid_o) begin
		  traceport_exec_valid_o <= 1'b1;
		  traceport_waitexec <= 1'b0;
	       end else begin
		  traceport_exec_valid_o <= 1'b0;
	       end
	    end // else: !if(!traceport_waitexec)
	 end // else: !if(rst)
      end else begin // if (FEATURE_TRACEPORT_EXEC != "NONE")
	 traceport_stage_decode_insn <= {`OR1K_INSN_WIDTH{1'b0}};
	 traceport_stage_exec_insn <= {`OR1K_INSN_WIDTH{1'b0}};
	 traceport_exec_insn_o <= {`OR1K_INSN_WIDTH{1'b0}};
	 traceport_exec_pc_o <= 32'h0;
	 traceport_exec_valid_o <= 1'b0;
      end
   end

   generate
      if (FEATURE_TRACEPORT_EXEC != "NONE") begin
	 assign traceport_exec_wbreg_o = wb_rfd_adr_o;
	 assign traceport_exec_wben_o = wb_rf_wb_o;
	 assign traceport_exec_wbdata_o = rf_result_o;
      end else begin
	 assign traceport_exec_wbreg_o = {OPTION_RF_ADDR_WIDTH{1'b0}};
	 assign traceport_exec_wben_o = 1'b0;
	 assign traceport_exec_wbdata_o = {OPTION_OPERAND_WIDTH{1'b0}};
      end
   endgenerate

endmodule // mor1kx_cpu_cappuccino

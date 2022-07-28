/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: mor1kx pronto espresso pipeline control unit

  inputs from execute stage

  generate pipeline controls

  manage SPRs

  issue addresses for exceptions to fetch stage
  control branches going to fetch stage

  contains tick timer

  contains PIC logic

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


module mor1kx_ctrl_prontoespresso
  (/*AUTOARG*/
   // Outputs
   spr_npc_o, spr_ppc_o, link_addr_o, mfspr_dat_o, ctrl_mfspr_we_o,
   flag_o, carry_o, pipeline_flush_o, padv_fetch_o, padv_decode_o,
   padv_execute_o, fetch_take_exception_branch_o, exception_taken_o,
   execute_waiting_o, stepping_o, du_dat_o, du_ack_o, du_stall_o,
   du_restart_pc_o, du_restart_o, spr_bus_addr_o, spr_bus_we_o,
   spr_bus_stb_o, spr_bus_dat_o, spr_sr_o, ctrl_branch_target_o,
   ctrl_insn_done_o, ctrl_branch_occur_o, rf_we_o,
   // Inputs
   clk, rst, ctrl_alu_result_i, ctrl_rfb_i, ctrl_flag_set_i,
   ctrl_flag_clear_i, ctrl_opc_insn_i, fetch_ppc_i, pc_fetch_next_i,
   fetch_sleep_i, except_ibus_err_i, except_illegal_i,
   except_syscall_i, except_dbus_i, except_trap_i, except_align_i,
   fetch_ready_i, fetch_quick_branch_i, alu_valid_i, lsu_valid_i,
   op_lsu_load_i, op_lsu_store_i, op_jr_i, op_jbr_i, irq_i,
   carry_set_i, carry_clear_i, overflow_set_i, overflow_clear_i,
   du_addr_i, du_stb_i, du_dat_i, du_we_i, du_stall_i,
   spr_bus_dat_dc_i, spr_bus_ack_dc_i, spr_bus_dat_ic_i,
   spr_bus_ack_ic_i, spr_bus_dat_dmmu_i, spr_bus_ack_dmmu_i,
   spr_bus_dat_immu_i, spr_bus_ack_immu_i, spr_bus_dat_mac_i,
   spr_bus_ack_mac_i, spr_bus_dat_pmu_i, spr_bus_ack_pmu_i,
   spr_bus_dat_pcu_i, spr_bus_ack_pcu_i, spr_bus_dat_fpu_i,
   spr_bus_ack_fpu_i, multicore_coreid_i, rf_wb_i
   );

   parameter OPTION_OPERAND_WIDTH       = 32;
   parameter OPTION_RESET_PC            = {{(OPTION_OPERAND_WIDTH-13){1'b0}},
					   `OR1K_RESET_VECTOR,8'd0};

   parameter FEATURE_SYSCALL            = "ENABLED";
   parameter FEATURE_TRAP               = "ENABLED";
   parameter FEATURE_RANGE              = "ENABLED";

   parameter FEATURE_DATACACHE          = "NONE";
   parameter OPTION_DCACHE_BLOCK_WIDTH  = 5;
   parameter OPTION_DCACHE_SET_WIDTH    = 9;
   parameter OPTION_DCACHE_WAYS         = 2;
   parameter FEATURE_DMMU               = "NONE";
   parameter FEATURE_INSTRUCTIONCACHE   = "NONE";
   parameter OPTION_ICACHE_BLOCK_WIDTH  = 5;
   parameter OPTION_ICACHE_SET_WIDTH    = 9;
   parameter OPTION_ICACHE_WAYS         = 2;
   parameter FEATURE_IMMU               = "NONE";
   parameter FEATURE_TIMER              = "ENABLED";
   parameter FEATURE_DEBUGUNIT          = "NONE";
   parameter FEATURE_PERFCOUNTERS       = "NONE";
   parameter FEATURE_PMU                = "NONE";
   parameter FEATURE_MAC                = "NONE";
   parameter FEATURE_FPU                = "NONE";

   parameter FEATURE_MULTICORE          = "NONE";

   parameter FEATURE_PIC                = "ENABLED";
   parameter OPTION_PIC_TRIGGER         = "LEVEL";
   parameter OPTION_PIC_NMI_WIDTH       = 0;

   parameter FEATURE_DSX                = "NONE";
   parameter FEATURE_FASTCONTEXTS       = "NONE";
   parameter FEATURE_OVERFLOW           = "NONE";

   parameter SPR_SR_WIDTH               = 16;
   parameter SPR_SR_RESET_VALUE         = 16'h8001;

   parameter FEATURE_INBUILT_CHECKERS = "ENABLED";

   input clk, rst;

   // ALU result - either jump target, SPR address
   input [OPTION_OPERAND_WIDTH-1:0] ctrl_alu_result_i;

   // Operand B from RF might be jump address, might be value for SPR
   input [OPTION_OPERAND_WIDTH-1:0] ctrl_rfb_i;

   input                            ctrl_flag_set_i, ctrl_flag_clear_i;

   output [OPTION_OPERAND_WIDTH-1:0] spr_npc_o;
   output [OPTION_OPERAND_WIDTH-1:0] spr_ppc_o;

   // Link address, to writeback stage
   output [OPTION_OPERAND_WIDTH-1:0] link_addr_o;

   input [`OR1K_OPCODE_WIDTH-1:0]    ctrl_opc_insn_i;

   // PCs from the fetch stage
   // PC of the instruction from fetch stage
   input [OPTION_OPERAND_WIDTH-1:0]  fetch_ppc_i;
   // Next PC we're going to deliver
   input [OPTION_OPERAND_WIDTH-1:0]  pc_fetch_next_i;

   // Input from fetch stage, indicating it's "sleeping", or not fetching
   // anymore.
   input 			     fetch_sleep_i;


   // Exception inputs, registered on output of execute stage
   input                             except_ibus_err_i, 
                                     except_illegal_i, 
                                     except_syscall_i, except_dbus_i, 
                                     except_trap_i, except_align_i;

   // Inputs from two units that can stall proceedings
   input 			     fetch_ready_i;
   input 			     fetch_quick_branch_i;

   input 			     alu_valid_i, lsu_valid_i;

   input 			     op_lsu_load_i, op_lsu_store_i;
   input 			     op_jr_i, op_jbr_i;

   // External IRQ lines in
   input [31:0] 		     irq_i;

   // SPR data out
   output [OPTION_OPERAND_WIDTH-1:0] mfspr_dat_o;

   // WE to RF for l.mfspr
   output                            ctrl_mfspr_we_o;

   // Flag out to branch control, combinatorial
   output 			     flag_o;

   // Arithmetic flags to and from ALU
   output 			     carry_o;
   input 			     carry_set_i;
   input 			     carry_clear_i;
   input 			     overflow_set_i;
   input 			     overflow_clear_i;

   // Branch indicator from control unit (l.rfe/exception)
   wire                              ctrl_branch_exception;
   // PC out to fetch stage for l.rfe, exceptions
   wire [OPTION_OPERAND_WIDTH-1:0]   ctrl_branch_except_pc;

   // Clear instructions from decode and fetch stage
   output                            pipeline_flush_o;

   output                            padv_fetch_o;
   output                            padv_decode_o;
   output                            padv_execute_o;

   // This indicates to the fetch unit only that it should basically interrupt
   // whatever it's doing and start fetching the exception
   output                            fetch_take_exception_branch_o;
   // This indicates to other parts of the CPU that we've handled an excption
   // so can be used to clear exception indication registers
   output                            exception_taken_o;

   output                            execute_waiting_o;
   output                            stepping_o;

   // Debug bus
   input [15:0] 		     du_addr_i;
   input                             du_stb_i;
   input [OPTION_OPERAND_WIDTH-1:0]  du_dat_i;
   input                             du_we_i;
   output [OPTION_OPERAND_WIDTH-1:0] du_dat_o;
   output                            du_ack_o;
   // Stall control from debug interface
   input                             du_stall_i;
   output                            du_stall_o;
   output [OPTION_OPERAND_WIDTH-1:0] du_restart_pc_o;
   output                            du_restart_o;

   // SPR accesses to external units (cache, mmu, etc.)
   output [15:0] 		     spr_bus_addr_o;
   output                            spr_bus_we_o;
   output                            spr_bus_stb_o;
   output [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_o;
   input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_dc_i;
   input                             spr_bus_ack_dc_i;
   input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_ic_i;
   input                             spr_bus_ack_ic_i;
   input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_dmmu_i;
   input                             spr_bus_ack_dmmu_i;
   input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_immu_i;
   input                             spr_bus_ack_immu_i;
   input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_mac_i;
   input                             spr_bus_ack_mac_i;
   input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_pmu_i;
   input                             spr_bus_ack_pmu_i;
   input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_pcu_i;
   input                             spr_bus_ack_pcu_i;
   input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_fpu_i;
   input                             spr_bus_ack_fpu_i;
   output [15:0] 		     spr_sr_o;

   // The multicore core identifier
   input [OPTION_OPERAND_WIDTH-1:0] multicore_coreid_i;

   // Internal signals
   reg 				     flag;
   reg [SPR_SR_WIDTH-1:0] 	     spr_sr;
   reg [SPR_SR_WIDTH-1:0] 	     spr_esr;
   reg [OPTION_OPERAND_WIDTH-1:0]    spr_epcr;
   reg [OPTION_OPERAND_WIDTH-1:0]    spr_eear;

   // Programmable Interrupt Control SPRs
   wire [31:0] 			     spr_picmr;
   wire [31:0] 			     spr_picsr;

   // Tick Timer SPRs
   wire [31:0] 			     spr_ttmr;
   wire [31:0] 			     spr_ttcr;

   reg [OPTION_OPERAND_WIDTH-1:0]    spr_ppc;
   reg [OPTION_OPERAND_WIDTH-1:0]    spr_npc;

   output [OPTION_OPERAND_WIDTH-1:0] ctrl_branch_target_o;

   reg                               execute_go;
   wire                              execute_done;

   output 			     ctrl_insn_done_o;

   reg                               execute_waiting_r;

   reg                               decode_execute_halt;

   reg                               exception_taken;

   reg                               take_exception;
   reg                               exception_r;

   reg [OPTION_OPERAND_WIDTH-1:0]    exception_pc_addr;

   reg                               waiting_for_fetch;

   reg                               doing_rfe_r;
   wire                              doing_rfe;
   wire                              deassert_doing_rfe;

   wire                              exception, exception_pending;

   wire                              execute_stage_exceptions;
   wire                              decode_stage_exceptions;

   wire                              exception_re;

   wire [31:0] 			     irq_unmasked;

   wire                              except_ticktimer;
   wire                              except_pic;

   wire                              except_ticktimer_nonsrmasked;
   wire                              except_pic_nonsrmasked;

   wire                              except_range;

   wire [15:0]                       spr_addr;

   wire                              op_mtspr;
   wire                              op_mfspr;
   wire                              op_rfe;

   wire [OPTION_OPERAND_WIDTH-1:0]   b;

   wire                              execute_waiting;

   wire                              execute_valid;

   wire                              deassert_decode_execute_halt;

   wire                              ctrl_branch_occur;
   wire                              new_branch;
   output                            ctrl_branch_occur_o;
   output                            rf_we_o;
   input                             rf_wb_i;
   wire                              except_ibus_align;
   wire                              fetch_advance;
   wire                              rfete;
   wire 			     stall_on_trap;

   /* Debug SPRs */
   reg [31:0] 			     spr_dmr1;
   reg [31:0] 			     spr_dmr2;
   reg [31:0] 			     spr_dsr;
   reg [31:0] 			     spr_drr;

   /* DU internal control signals */
   wire                              du_access;
   reg                               cpu_stall;
   wire                              du_restart_from_stall;
   wire [1:0] 			     pstep;
   wire                              stepping;
   wire                              du_npc_write;

   /* Wires for SPR management */
   wire                              spr_group_present;
   wire [3:0] 			     spr_group;
   wire                              spr_we;
   wire                              spr_read;
   wire [OPTION_OPERAND_WIDTH-1:0]   spr_write_dat;
   wire [11:0] 			     spr_access_ack;
   wire [31:0] 			     spr_internal_read_dat [0:12];
   wire                              spr_read_access;
   wire                              spr_write_access;
   wire                              spr_bus_access;
   reg [OPTION_OPERAND_WIDTH-1:0]    spr_sys_group_read;

   /* Wires from mor1kx_cfgrs module */
   wire [31:0] 			     spr_vr;
   wire [31:0] 			     spr_vr2;
   wire [31:0] 			     spr_avr;
   wire [31:0] 			     spr_upr;
   wire [31:0] 			     spr_cpucfgr;
   wire [31:0] 			     spr_dmmucfgr;
   wire [31:0] 			     spr_immucfgr;
   wire [31:0] 			     spr_dccfgr;
   wire [31:0] 			     spr_iccfgr;
   wire [31:0] 			     spr_dcfgr;
   wire [31:0] 			     spr_pccfgr;
   wire [31:0] 			     spr_fpcsr;
   wire [31:0] 			     spr_isr [0:7];

   assign b = ctrl_rfb_i;

   assign ctrl_branch_exception = (exception_r | (op_rfe | doing_rfe)) &
                                  !exception_taken;

   assign exception_pending = (except_ibus_err_i | except_ibus_align |
                               except_illegal_i | except_syscall_i |
                               except_dbus_i | except_align_i |
                               except_ticktimer | except_range |
                               except_pic | except_trap_i );

   assign exception = exception_pending;

   assign fetch_take_exception_branch_o =  (take_exception | op_rfe) &
                                           !stepping;

   assign execute_stage_exceptions = except_dbus_i | except_align_i |
				     except_range;
   assign decode_stage_exceptions = except_trap_i | except_illegal_i;

   assign exception_re = exception & !exception_r & !exception_taken;

   assign deassert_decode_execute_halt = ctrl_branch_occur &
                                         decode_execute_halt;

   assign ctrl_branch_except_pc = (op_rfe | doing_rfe) & !rfete ? spr_epcr :
                                  exception_pc_addr;

   // Exceptions take precedence
   assign ctrl_branch_occur = // instruction is branch, and flag is right
                              (op_jbr_i &
                               // is l.j or l.jal
                               (!(|ctrl_opc_insn_i[2:1]) |
                                // is l.bf/bnf and flag is right
                                (ctrl_opc_insn_i[2]==flag))) |
                              (op_jr_i & !(except_ibus_align));

   assign ctrl_branch_occur_o = // Usual branch signaling
                                ((ctrl_branch_occur/* | ctrl_branch_exception*/) &
                                fetch_advance);

   assign ctrl_branch_target_o = ctrl_branch_exception ?
                                 ctrl_branch_except_pc :
                                 // jump or branch?
                                 op_jbr_i ? ctrl_alu_result_i :
                                 ctrl_rfb_i;

   // Do writeback when we register our output to the next stage, or if
   // we're doing mfspr
   assign rf_we_o = (execute_done /*& !delay_slot_rf_we_done*/) &
                    ((rf_wb_i & !op_mfspr
                      & !((op_lsu_load_i | op_lsu_store_i) &
                          except_dbus_i | except_align_i)) |
                     (op_mfspr));

   assign except_range = (FEATURE_RANGE!="NONE") ? spr_sr[`OR1K_SPR_SR_OVE] &&
			 (spr_sr[`OR1K_SPR_SR_OV] | overflow_set_i & 
			  execute_done)  & !doing_rfe: 0;

   // Check for unaligned jump address from register
   assign except_ibus_align = op_jr_i & (|ctrl_rfb_i[1:0]);

   // Return from exception to exception (if pending tick or PIC ints)
   assign rfete = (spr_esr[`OR1K_SPR_SR_IEE] & except_pic_nonsrmasked) |
                  (spr_esr[`OR1K_SPR_SR_TEE] & except_ticktimer_nonsrmasked);

   always @(posedge clk)
     if (rst)
       exception_pc_addr <= OPTION_RESET_PC;
     else if (exception_re | (rfete & execute_done))
       casez(
             {except_ibus_err_i,
              except_illegal_i,
              except_align_i,
              except_ibus_align,
              except_syscall_i,
              except_trap_i,
              except_dbus_i,
	      except_range,
              except_pic_nonsrmasked,
              except_ticktimer_nonsrmasked
              }
             )
         10'b1?????????:
           exception_pc_addr <= {19'd0,`OR1K_BERR_VECTOR,8'd0};
         10'b01????????:
           exception_pc_addr <= {19'd0,`OR1K_ILLEGAL_VECTOR,8'd0};
         10'b001???????,
           10'b0001??????:
             exception_pc_addr <= {19'd0,`OR1K_ALIGN_VECTOR,8'd0};
         10'b00001?????:
           exception_pc_addr <= {19'd0,`OR1K_SYSCALL_VECTOR,8'd0};
         10'b000001????:
           exception_pc_addr <= {19'd0,`OR1K_TRAP_VECTOR,8'd0};
         10'b0000001???:
           exception_pc_addr <= {19'd0,`OR1K_BERR_VECTOR,8'd0};
         10'b00000001??:
           exception_pc_addr <= {19'd0,`OR1K_RANGE_VECTOR,8'd0};
         10'b000000001?:
           exception_pc_addr <= {19'd0,`OR1K_INT_VECTOR,8'd0};
         //10'b00000000001:
         default:
           exception_pc_addr <= {19'd0,`OR1K_TT_VECTOR,8'd0};
       endcase // casex (...

   assign op_mtspr = ctrl_opc_insn_i==`OR1K_OPCODE_MTSPR;
   assign op_mfspr = ctrl_opc_insn_i==`OR1K_OPCODE_MFSPR;
   assign op_rfe = ctrl_opc_insn_i==`OR1K_OPCODE_RFE;

   reg                               waiting_for_except_fetch;
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       waiting_for_except_fetch <= 0;
     else if (waiting_for_except_fetch & fetch_ready_i)
       waiting_for_except_fetch <= 0;
     else if (fetch_take_exception_branch_o)
       waiting_for_except_fetch <= 1;

   assign fetch_advance = (fetch_ready_i | except_ibus_err_i) &
                          !execute_waiting & !cpu_stall &
                          (!stepping |
                           (stepping & pstep[0] & !fetch_ready_i));

   assign padv_fetch_o = fetch_advance & !exception_pending & !doing_rfe_r &
                         !cpu_stall;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       take_exception <= 0;
     else
       take_exception <= (exception_pending/* | doing_rfe_r*/) &
                         (((fetch_advance & waiting_for_fetch) | execute_done |
			   fetch_sleep_i) |
                          // Cause exception to always be 'taken' if stepping
                          (stepping & execute_done)
                          ) &
                         // Would like this as only a single pulse
                         !take_exception;

   reg                               padv_decode_r;
   // Some bits of the pipeline (execute_alu for instance) require a falling
   // edge of the decode signal to start work on multi-cycle ops.
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       padv_decode_r <= 0;
     else
       padv_decode_r <= padv_fetch_o;

   assign padv_decode_o = padv_decode_r;

   reg 				     ctrl_branch_occur_r;
   wire 			     ctrl_branch_occur_re;
   assign ctrl_branch_occur_re = ctrl_branch_occur & !ctrl_branch_occur_r;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       ctrl_branch_occur_r <= 0;
     else
       ctrl_branch_occur_r <= ctrl_branch_occur;


   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       execute_go <= 0;
     else
       // Note: turned padv_fetch_o here into (padv_fetch_o &
       // !ctrl_branch_occur) for pronto version. This may have implications
       // for exeception handling.
       execute_go <= (padv_fetch_o & !(ctrl_branch_occur_re | op_rfe)) |
		     execute_waiting | (stepping & fetch_ready_i);

   assign execute_done = (execute_go | fetch_quick_branch_i) &
			 !execute_waiting & !cpu_stall;
   // Note: we gate on cpu_stall here because a case was observed where
   // the stall came during a multicycle instruction, and the rest of the
   // pipeline had stalled and execute_done strobed, indicating the
   // instruction completed but the PCs were not advanced. So it's best to
   // just stop this signal asserting, meaning we don't allow  the
   // instruction to officially complete (result is not written to RF).

   assign ctrl_insn_done_o = execute_done;

   // ALU or LSU stall execution, nothing else can
   assign execute_valid = !((op_lsu_load_i | op_lsu_store_i) & !lsu_valid_i |
			    !alu_valid_i);

   assign execute_waiting = !execute_valid & !waiting_for_fetch;
   assign execute_waiting_o = execute_waiting;

   assign padv_execute_o = execute_done;

   assign spr_addr = du_access ? du_addr_i : ctrl_alu_result_i[15:0];
   assign ctrl_mfspr_we_o = op_mfspr & execute_go;

   // Pipeline flush
   assign pipeline_flush_o = (execute_done & op_rfe) |
                             (exception_re) |
                             cpu_stall;

   // Flag
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       flag <= 0;
     else if (execute_done)
       flag <= ctrl_flag_clear_i ? 0 :
               ctrl_flag_set_i ? 1 : flag;

   assign flag_o = flag;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       execute_waiting_r <= 0;
     else if (!execute_waiting)
       execute_waiting_r <= 0;
     else if (execute_waiting)
       execute_waiting_r <= 1;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       decode_execute_halt <= 0;
     else if (du_restart_from_stall)
       decode_execute_halt <= 0;
     else if (decode_execute_halt & deassert_decode_execute_halt)
       decode_execute_halt <= 0;
     else if ((op_rfe | exception) & !decode_execute_halt & !exception_taken)
       decode_execute_halt <= 1;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       exception_r <= 0;
     else if (exception_taken | du_restart_from_stall)
       exception_r <= 0;
     else if (exception & !exception_r)
       exception_r <= 1;

   // Signal to indicate that the incoming exception or l.rfe has been taken
   // and we're waiting for it to propagate through the pipeline.
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       exception_taken <= 0;
     else if (exception_taken)
       exception_taken <= 0;
     else if (exception_r & take_exception)
       exception_taken <= 1;

   assign exception_taken_o = exception_r & take_exception;//exception_taken;

   // Used to gate execute stage's advance signal in the case where a LSU op has
   // finished before the next instruction has been fetched. Typically this
   // occurs when not using icache and doing lots of memory accesses.
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       waiting_for_fetch <= 0;
     else if (fetch_ready_i)
       waiting_for_fetch <= 0;
     // Whenever execute not waiting and fetch not ready
     else if (!execute_waiting /*& execute_waiting_r*/ & !fetch_ready_i)
       waiting_for_fetch <= 1;
     else if (execute_done & !fetch_ready_i)
       waiting_for_fetch <= 1;

   assign doing_rfe = ((execute_done & op_rfe) | doing_rfe_r) &
                      !deassert_doing_rfe;

   // Basically, the fetch stage should always take the rfe immediately
   assign deassert_doing_rfe =  doing_rfe_r;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       doing_rfe_r <= 0;
     else if (deassert_doing_rfe)
       doing_rfe_r <= 0;
     else if (execute_done)
       doing_rfe_r <= op_rfe;

   assign spr_sr_o = spr_sr;

   // Supervision register
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       spr_sr <= SPR_SR_RESET_VALUE;
     else if (fetch_take_exception_branch_o)
       begin
          if (op_rfe & !rfete)
            begin
               spr_sr <= spr_esr;
            end
          else
            begin
               // Go into supervisor mode, disable interrupts, MMUs
               spr_sr[`OR1K_SPR_SR_SM  ] <= 1'b1;
               if (FEATURE_TIMER!="NONE")
                 spr_sr[`OR1K_SPR_SR_TEE ] <= 1'b0;
               if (FEATURE_PIC!="NONE")
                 spr_sr[`OR1K_SPR_SR_IEE ] <= 1'b0;
               if (FEATURE_DMMU!="NONE")
                 spr_sr[`OR1K_SPR_SR_DME ] <= 1'b0;
               if (FEATURE_IMMU!="NONE")
                 spr_sr[`OR1K_SPR_SR_IME ] <= 1'b0;
	       if (FEATURE_OVERFLOW!="NONE")
		 spr_sr[`OR1K_SPR_SR_OVE ] <= 1'b0;
            end
       end
     else if (execute_done)
       begin
	  spr_sr[`OR1K_SPR_SR_F   ] <= ctrl_flag_set_i ? 1 :
				       ctrl_flag_clear_i ? 0 :
				       spr_sr[`OR1K_SPR_SR_F   ];
	  spr_sr[`OR1K_SPR_SR_CY   ] <= carry_set_i ? 1 :
					carry_clear_i ? 0 :
					spr_sr[`OR1K_SPR_SR_CY   ];
	  if (FEATURE_OVERFLOW!="NONE")
	    spr_sr[`OR1K_SPR_SR_OV   ] <= overflow_set_i ? 1 :
				overflow_clear_i ? 0 :
				spr_sr[`OR1K_SPR_SR_OV   ];

	  if ((spr_we & (spr_sr[`OR1K_SPR_SR_SM] | du_access)) &&
              spr_addr==`OR1K_SPR_SR_ADDR)
            begin
               spr_sr[`OR1K_SPR_SR_SM  ] <= spr_write_dat[`OR1K_SPR_SR_SM  ];

	       spr_sr[`OR1K_SPR_SR_F  ] <= spr_write_dat[`OR1K_SPR_SR_F  ];

               if (FEATURE_TIMER!="NONE")
                 spr_sr[`OR1K_SPR_SR_TEE ] <= spr_write_dat[`OR1K_SPR_SR_TEE ];

               if (FEATURE_PIC!="NONE")
                 spr_sr[`OR1K_SPR_SR_IEE ] <= spr_write_dat[`OR1K_SPR_SR_IEE ];

               if (FEATURE_DATACACHE!="NONE")
                 spr_sr[`OR1K_SPR_SR_DCE ] <= spr_write_dat[`OR1K_SPR_SR_DCE ];

               if (FEATURE_INSTRUCTIONCACHE!="NONE")
                 spr_sr[`OR1K_SPR_SR_ICE ] <= spr_write_dat[`OR1K_SPR_SR_ICE ];

               if (FEATURE_DMMU!="NONE")
                 spr_sr[`OR1K_SPR_SR_DME ] <= spr_write_dat[`OR1K_SPR_SR_DME ];

               if (FEATURE_IMMU!="NONE")
                 spr_sr[`OR1K_SPR_SR_IME ] <= spr_write_dat[`OR1K_SPR_SR_IME ];

               if (FEATURE_FASTCONTEXTS!="NONE")
                 spr_sr[`OR1K_SPR_SR_CE  ] <= spr_write_dat[`OR1K_SPR_SR_CE  ];

               spr_sr[`OR1K_SPR_SR_CY  ] <= spr_write_dat[`OR1K_SPR_SR_CY  ];

               if (FEATURE_OVERFLOW!="NONE") begin
                  spr_sr[`OR1K_SPR_SR_OV  ] <= spr_write_dat[`OR1K_SPR_SR_OV  ];
                  spr_sr[`OR1K_SPR_SR_OVE ] <= spr_write_dat[`OR1K_SPR_SR_OVE ];
               end

               if (FEATURE_DSX!="NONE")
                 spr_sr[`OR1K_SPR_SR_DSX ] <= spr_write_dat[`OR1K_SPR_SR_DSX ];

               spr_sr[`OR1K_SPR_SR_EPH ] <= spr_write_dat[`OR1K_SPR_SR_EPH ];

            end // if ((spr_we & (spr_sr[`OR1K_SPR_SR_SM] | du_access)) &&...

       end // if (execute_done)

   assign carry_o = spr_sr[`OR1K_SPR_SR_CY];

   // Exception SR
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       spr_esr <= SPR_SR_RESET_VALUE;
     else if (exception_re)
       begin
          spr_esr <= spr_sr;
          /*
           A bit odd, but if we had a l.sf instruction on an exception rising
           edge, EPCR will point to the insn past the l.sf but the flag will
           not have been saved to the SR properly. So we must put it in here
           so it can be restored correctly.
	   Ditto for the other flags which may have been changed in a similar
	   fashion.
           */
          if (execute_done)
	    begin
               if (ctrl_flag_set_i)
		 spr_esr[`OR1K_SPR_SR_F   ] <= 1'b1;
               else if (ctrl_flag_clear_i)
		 spr_esr[`OR1K_SPR_SR_F   ] <= 1'b0;
	       if (FEATURE_OVERFLOW!="NONE")
		 begin
		    if (overflow_set_i)
		      spr_esr[`OR1K_SPR_SR_OV   ] <= 1'b1;
		    else if (overflow_clear_i)
		      spr_esr[`OR1K_SPR_SR_OV   ] <= 1'b0;
		 end
	       if (carry_set_i)
		 spr_esr[`OR1K_SPR_SR_CY   ] <= 1'b1;
	       else if (carry_clear_i)
		 spr_esr[`OR1K_SPR_SR_CY   ] <= 1'b0;
	    end
       end
     else if (spr_we & spr_addr==`OR1K_SPR_ESR0_ADDR)
       spr_esr <= spr_write_dat[SPR_SR_WIDTH-1:0];

   // Exception PC
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       spr_epcr <= OPTION_RESET_PC;
     else if (exception_re & !(rfete & (op_rfe | deassert_doing_rfe)))
       begin
          if (except_ibus_err_i)
            spr_epcr <= spr_ppc;
          else if (except_syscall_i)
            // EPCR after syscall is address of next not executed insn.
            spr_epcr <= spr_npc;
          else if (except_ticktimer | except_pic)
            spr_epcr <= ctrl_branch_occur ? spr_ppc : spr_npc;
          else if (execute_stage_exceptions |
		   // Don't update EPCR on software breakpoint
		   (decode_stage_exceptions & !(stall_on_trap & except_trap_i)))
            spr_epcr <= spr_ppc;
          else if (!(stall_on_trap & except_trap_i))
            spr_epcr <= spr_ppc;
       end
     else if (spr_we && spr_addr==`OR1K_SPR_EPCR0_ADDR)
       spr_epcr <= spr_write_dat;

   // Exception Effective Address
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       spr_eear <= {OPTION_OPERAND_WIDTH{1'b0}};
     else if (exception_re)
       begin
          if (except_ibus_err_i)
            spr_eear <= fetch_ppc_i;
          else
            spr_eear <= ctrl_alu_result_i;
       end

   // Next PC (NPC)
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       spr_npc <= OPTION_RESET_PC;
     else if (deassert_doing_rfe)
       spr_npc <= rfete ? exception_pc_addr : spr_epcr;
     else if (du_npc_write)
       spr_npc <= du_restart_pc_o;
     else if (stepping & ctrl_branch_occur)
       spr_npc <= ctrl_branch_target_o;
     else if (stepping & fetch_ready_i)
       spr_npc <= pc_fetch_next_i;
     else if (stepping & exception_r)
       spr_npc <= exception_pc_addr;
     else if (stepping & execute_done & ctrl_branch_occur)
       // The case where we stepped into a jump
       spr_npc <= ctrl_branch_target_o;
     else if (((fetch_advance & exception) | fetch_take_exception_branch_o) |
	      padv_fetch_o)
       // PC we're now executing
       spr_npc <= (fetch_take_exception_branch_o |(fetch_advance & exception)) ?
		  exception_pc_addr : (ctrl_branch_occur & !fetch_quick_branch_i) ? 
		  ctrl_branch_target_o : pc_fetch_next_i;

   // Previous PC (PPC)
   always @*
     spr_ppc = fetch_ppc_i;

   assign spr_npc_o = spr_npc;
   assign spr_ppc_o = spr_ppc;

   // This is for the writeback stage, when we have l.jal[r] instructions.
   // Annoyingly, we can't rely on the link address being
   // available without a dedicated bit of logic to calculate it,
   // so do so here.
   assign link_addr_o = spr_ppc + 4;

   mor1kx_cfgrs
     #(.FEATURE_PIC			(FEATURE_PIC),
       .FEATURE_TIMER			(FEATURE_TIMER),
       .OPTION_PIC_TRIGGER		(OPTION_PIC_TRIGGER),
       .FEATURE_DSX			(FEATURE_DSX),
       .FEATURE_FASTCONTEXTS		(FEATURE_FASTCONTEXTS),
       .FEATURE_OVERFLOW		(FEATURE_OVERFLOW),
       .FEATURE_DATACACHE		(FEATURE_DATACACHE),
       .OPTION_DCACHE_BLOCK_WIDTH	(OPTION_DCACHE_BLOCK_WIDTH),
       .OPTION_DCACHE_SET_WIDTH		(OPTION_DCACHE_SET_WIDTH),
       .OPTION_DCACHE_WAYS		(OPTION_DCACHE_WAYS),
       .FEATURE_DMMU			(FEATURE_DMMU),
       .FEATURE_INSTRUCTIONCACHE	(FEATURE_INSTRUCTIONCACHE),
       .OPTION_ICACHE_BLOCK_WIDTH	(OPTION_ICACHE_BLOCK_WIDTH),
       .OPTION_ICACHE_SET_WIDTH		(OPTION_ICACHE_SET_WIDTH),
       .OPTION_ICACHE_WAYS		(OPTION_ICACHE_WAYS),
       .FEATURE_IMMU			(FEATURE_IMMU),
       .FEATURE_DEBUGUNIT		(FEATURE_DEBUGUNIT),
       .FEATURE_PERFCOUNTERS		(FEATURE_PERFCOUNTERS),
       .FEATURE_MAC			(FEATURE_MAC),
       .FEATURE_SYSCALL			(FEATURE_SYSCALL),
       .FEATURE_TRAP			(FEATURE_TRAP),
       .FEATURE_RANGE			(FEATURE_RANGE)
       )
   mor1kx_cfgrs
     (/*AUTOINST*/
      // Outputs
      .spr_vr				(spr_vr[31:0]),
      .spr_vr2				(spr_vr2[31:0]),
      .spr_upr				(spr_upr[31:0]),
      .spr_cpucfgr			(spr_cpucfgr[31:0]),
      .spr_dmmucfgr			(spr_dmmucfgr[31:0]),
      .spr_immucfgr			(spr_immucfgr[31:0]),
      .spr_dccfgr			(spr_dccfgr[31:0]),
      .spr_iccfgr			(spr_iccfgr[31:0]),
      .spr_dcfgr			(spr_dcfgr[31:0]),
      .spr_pccfgr			(spr_pccfgr[31:0]),
      .spr_fpcsr			(spr_fpcsr[31:0]),
      .spr_avr				(spr_avr[31:0]));

   /* Implementation-specific registers */
   assign spr_isr[0] = 0;
   assign spr_isr[1] = 0;
   assign spr_isr[2] = 0;
   assign spr_isr[3] = 0;
   assign spr_isr[4] = 0;
   assign spr_isr[5] = 0;
   assign spr_isr[6] = 0;
   assign spr_isr[7] = 0;

   // System group (0) SPR data out
   always @*
     case(spr_addr)
       `OR1K_SPR_VR_ADDR:
         spr_sys_group_read = spr_vr;
       `OR1K_SPR_VR2_ADDR:
	 spr_sys_group_read = {spr_vr2[31:8], `MOR1KX_PIPEID_PRONTOESPRESSO};
       `OR1K_SPR_AVR_ADDR:
	 spr_sys_group_read = spr_avr;
       `OR1K_SPR_UPR_ADDR:
         spr_sys_group_read = spr_upr;
       `OR1K_SPR_CPUCFGR_ADDR:
         spr_sys_group_read = spr_cpucfgr;
       `OR1K_SPR_DMMUCFGR_ADDR:
         spr_sys_group_read = spr_dmmucfgr;
       `OR1K_SPR_IMMUCFGR_ADDR:
         spr_sys_group_read = spr_immucfgr;
       `OR1K_SPR_DCCFGR_ADDR:
         spr_sys_group_read = spr_dccfgr;
       `OR1K_SPR_ICCFGR_ADDR:
         spr_sys_group_read = spr_iccfgr;
       `OR1K_SPR_DCFGR_ADDR:
         spr_sys_group_read = spr_dcfgr;
       `OR1K_SPR_PCCFGR_ADDR:
         spr_sys_group_read = spr_pccfgr;
       `OR1K_SPR_NPC_ADDR:
         spr_sys_group_read = spr_npc;
       `OR1K_SPR_SR_ADDR:
         spr_sys_group_read = {{(OPTION_OPERAND_WIDTH-SPR_SR_WIDTH){1'b0}},
                               spr_sr};

       `OR1K_SPR_PPC_ADDR:
         spr_sys_group_read = spr_ppc;
       `OR1K_SPR_FPCSR_ADDR:
         spr_sys_group_read = spr_fpcsr;
       `OR1K_SPR_EPCR0_ADDR:
         spr_sys_group_read = spr_epcr;
       `OR1K_SPR_EEAR0_ADDR:
         spr_sys_group_read = spr_eear;
       `OR1K_SPR_ESR0_ADDR:
         spr_sys_group_read = {{(OPTION_OPERAND_WIDTH-SPR_SR_WIDTH){1'b0}},
                               spr_esr};
       `OR1K_SPR_ISR0_ADDR:
	 spr_sys_group_read = spr_isr[0];
       `OR1K_SPR_ISR0_ADDR +1:
	 spr_sys_group_read = spr_isr[1];
       `OR1K_SPR_ISR0_ADDR +2:
	 spr_sys_group_read = spr_isr[2];
       `OR1K_SPR_ISR0_ADDR +3:
	 spr_sys_group_read = spr_isr[3];
       `OR1K_SPR_ISR0_ADDR +4:
	 spr_sys_group_read = spr_isr[4];
       `OR1K_SPR_ISR0_ADDR +5:
	 spr_sys_group_read = spr_isr[5];
       `OR1K_SPR_ISR0_ADDR +6:
	 spr_sys_group_read = spr_isr[6];
       `OR1K_SPR_ISR0_ADDR +7:
	 spr_sys_group_read = spr_isr[7];

       `OR1K_SPR_COREID_ADDR:
	 // If the multicore feature is activated this address returns the
	 // core identifier, 0 otherwise
	 spr_sys_group_read = (FEATURE_MULTICORE != "NONE") ? multicore_coreid_i : 0;

       default: begin
          /* GPR read */
          if (spr_addr >= `OR1K_SPR_GPR0_ADDR &&
              spr_addr <= (`OR1K_SPR_GPR0_ADDR + 32))
            spr_sys_group_read = b; /* Register file */
          else
            /* Invalid address - read as zero*/
            spr_sys_group_read = 0;
       end
     endcase // case (spr_addr)

   /* System group read data MUX in */
   assign spr_internal_read_dat[0] = spr_sys_group_read;
   /* System group ack generation */
   /* TODO - might be delay for register file reads! */
   assign spr_access_ack[0] = 1;



   /* Generate data to the register file for mfspr operations */
   assign mfspr_dat_o = spr_internal_read_dat[spr_addr[14:11]];

   // PIC SPR control
   generate
      if (FEATURE_PIC !="NONE") begin : pic

	 /* mor1kx_pic AUTO_TEMPLATE (
	  .spr_picsr_o		(spr_picsr),
	  .spr_picmr_o		(spr_picmr),
	  .spr_bus_ack		(spr_access_ack[9]),
	  .spr_dat_o		(spr_internal_read_dat[9]),
	  // Inputs
	  .spr_we_i		(spr_we),
	  .spr_addr_i		(spr_addr),
	  .spr_dat_i		(spr_write_dat),
	  );*/
	 mor1kx_pic
	  #(
	    .OPTION_PIC_TRIGGER(OPTION_PIC_TRIGGER),
	    .OPTION_PIC_NMI_WIDTH(OPTION_PIC_NMI_WIDTH)
	    )
	 mor1kx_pic
	   (/*AUTOINST*/
	    // Outputs
	    .spr_picmr_o		(spr_picmr),		 // Templated
	    .spr_picsr_o		(spr_picsr),		 // Templated
	    .spr_bus_ack		(spr_access_ack[9]),	 // Templated
	    .spr_dat_o			(spr_internal_read_dat[9]), // Templated
	    // Inputs
	    .clk			(clk),
	    .rst			(rst),
	    .irq_i			(irq_i[31:0]),
	    .spr_we_i			(spr_we),		 // Templated
	    .spr_addr_i			(spr_addr),		 // Templated
	    .spr_dat_i			(spr_write_dat));	 // Templated

         assign except_pic_nonsrmasked = (|spr_picsr) &
                             !op_mtspr &
                             // Stops back-to-back branch addresses going to
                             // fetch stage
                             !ctrl_branch_occur;

         assign except_pic = spr_sr[`OR1K_SPR_SR_IEE] & except_pic_nonsrmasked &
                             !doing_rfe;

      end
      else begin
	 assign except_pic_nonsrmasked = 0;
	 assign except_pic = 0;
	 assign spr_picsr = 0;
	 assign spr_picmr = 0;
	 assign spr_access_ack[9] = 0;
	 assign spr_internal_read_dat[9] = 0;
      end // else: !if(FEATURE_PIC !="NONE")
   endgenerate


   generate
      if (FEATURE_TIMER!="NONE") begin : tt

	 /* mor1kx_ticktimer AUTO_TEMPLATE (
	  .spr_ttmr_o		(spr_ttmr),
	  .spr_ttcr_o		(spr_ttcr),
	  .spr_bus_ack		(spr_access_ack[10]),
	  .spr_dat_o		(spr_internal_read_dat[10]),
	  // Inputs
	  .spr_we_i		(spr_we),
	  .spr_addr_i		(spr_addr),
	  .spr_dat_i		(spr_write_dat),
	  );*/
	 mor1kx_ticktimer mor1kx_ticktimer
			 (/*AUTOINST*/
			  // Outputs
			  .spr_ttmr_o		(spr_ttmr),	 // Templated
			  .spr_ttcr_o		(spr_ttcr),	 // Templated
			  .spr_bus_ack		(spr_access_ack[10]), // Templated
			  .spr_dat_o		(spr_internal_read_dat[10]), // Templated
			  // Inputs
			  .clk			(clk),
			  .rst			(rst),
			  .spr_we_i		(spr_we),	 // Templated
			  .spr_addr_i		(spr_addr),	 // Templated
			  .spr_dat_i		(spr_write_dat)); // Templated

         assign except_ticktimer_nonsrmasked = spr_ttmr[28] &
                    !(op_mtspr & !(spr_esr[`OR1K_SPR_SR_TEE] & execute_done)) &
                                   // Stops back-to-back branch addresses to
                                   // fetch  stage.
                                   !ctrl_branch_occur;

         assign except_ticktimer = except_ticktimer_nonsrmasked &
                                   spr_sr[`OR1K_SPR_SR_TEE] & !doing_rfe;
      end // if (FEATURE_TIMER!="NONE")
      else begin
	 assign except_ticktimer_nonsrmasked = 0;
	 assign except_ticktimer = 0;
	 assign spr_ttmr = 0;
	 assign spr_ttcr = 0;
	 assign spr_access_ack[10] = 0;
	 assign spr_internal_read_dat[10] = 0;
      end // else: !if(FEATURE_TIMER!="NONE")
   endgenerate

   /* SPR access control - allow accesses from either the instructions or from
    the debug interface */
   assign spr_read_access = (op_mfspr | (du_access & !du_we_i));
   assign spr_write_access = ((execute_done & op_mtspr) | (du_access & du_we_i));

   assign spr_write_dat = du_access ? du_dat_i : b;
   assign spr_we = spr_write_access & spr_group_present;
   assign spr_read = spr_read_access & spr_group_present;

   /* A bus out to other units that live outside of the control unit */
   assign spr_bus_addr_o = spr_addr;
   assign spr_bus_we_o = spr_write_access & spr_group_present & spr_bus_access;
   assign spr_bus_stb_o = (spr_read_access | spr_write_access) &
                          spr_group_present & spr_bus_access;
   assign spr_bus_dat_o = spr_write_dat;

   /* Is the SPR in the design? */
   assign spr_group_present = (// System group
                               (spr_addr[15:11]==5'h00) ||
                               // DMMU
                               (spr_addr[15:11]==5'h01 &&
                                FEATURE_DMMU!="NONE") ||
                               // IMMU
                               (spr_addr[15:11]==5'h02 &&
                                FEATURE_IMMU!="NONE") ||
                               // Data cache
                               (spr_addr[15:11]==5'h03 &&
                                FEATURE_DATACACHE!="NONE") ||
                               // Instruction cache
                               (spr_addr[15:11]==5'h04 &&
                                FEATURE_INSTRUCTIONCACHE!= "NONE") ||
                               // MAC unit
                               (spr_addr[15:11]==5'h05 &&
                                FEATURE_MAC!="NONE") ||
                               // Debug unit
                               (spr_addr[15:11]==5'h06 &&
                                FEATURE_DEBUGUNIT!="NONE") ||
                               // Performance counters
                               (spr_addr[15:11]==5'h07 &&
                                FEATURE_PERFCOUNTERS!="NONE") ||
                               // Power Management
                               (spr_addr[15:11]==5'h08 &&
                                FEATURE_PMU!="NONE") ||
                               // PIC
                               (spr_addr[15:11]==5'h09 &&
                                FEATURE_PIC!="NONE") ||
                               // Tick timer
                               (spr_addr[15:11]==5'h0a &&
                                FEATURE_TIMER!="NONE") ||
                               // FPU
                               (spr_addr[15:11]==5'h0b &&
                                FEATURE_FPU!="NONE")
                               );

   /* Generate a SPR group signal - generate invalid if the group is not
    present in the design */
   assign spr_group = (spr_group_present) ? spr_addr[14:11] : 4'd12;

   /* Default group when a selected one is not present - it reads as zero */
   assign spr_internal_read_dat[12] = 0;

   /* Is a SPR bus access needed, or is the requested SPR in this file? */
   assign spr_bus_access = /* Any of the units we don't have in this file */
                           /* System group */
                           !(spr_addr[15:11]==5'h00 ||
                             /* Debug Group */
                             spr_addr[15:11]==5'h06 ||
                             /* PIC Group */
                             spr_addr[15:11]==5'h09 ||
                             /* Tick Group */
                             spr_addr[15:11]==5'h0a);

   assign stepping_o = stepping;

   generate
      if (FEATURE_DEBUGUNIT!="NONE") begin : du

         reg [OPTION_OPERAND_WIDTH-1:0] du_read_dat;

         reg                            du_ack;
         reg                            du_stall_r;
         reg [1:0]                      pstep_r;
         reg [1:0]                      branch_step;
         reg                            stepped_into_exception;
         reg                            stepped_into_rfe;

         assign du_access = du_stb_i;

         // Generate ack back to the debug interface bus
         always @(posedge clk `OR_ASYNC_RST)
           if (rst)
             du_ack <= 0;
           else if (du_ack)
             du_ack <= 0;
           else if (du_stb_i) begin
              if (!spr_group_present)
                /* Unit doesn't exist, ACK to clear the access, nothing done */
                du_ack <= 1;
              else if (spr_access_ack[spr_group])
                /* actual access occurred */
                du_ack <= 1;
           end

         assign du_ack_o = du_ack;

         /* Data back to the debug bus */
         always @(posedge clk `OR_ASYNC_RST)
           if (rst)
             du_read_dat <= 0;
           else if (spr_access_ack[spr_group]) begin
              du_read_dat <= spr_internal_read_dat[spr_group];
           end

         assign du_dat_o = du_read_dat;
         /* TODO: check into only letting stall go high when we've gracefully
          completed the instruction currently in the ctrl stage.
          Why? Potentially an instruction like l.mfspr from an external unit
          hasn't completed fully, gets interrupted, and it's assumed it's
          completed, but actually hasn't. */

	 always @(posedge clk)
	   cpu_stall <= du_stall_i | du_restart_from_stall;

         /* goes out to the debug interface and comes back 1 cycle later
          via du_stall_i */
         assign du_stall_o = (stepping & execute_done) |
			     (stall_on_trap & execute_done & except_trap_i);

         /* Pulse to indicate we're restarting after a stall */
         assign du_restart_from_stall = du_stall_r & !du_stall_i;

         /* NPC debug control logic */
         assign du_npc_write = (du_we_i && du_addr_i==`OR1K_SPR_NPC_ADDR &&
                                du_ack_o);

	 /* Pick the traps-cause-stall bit out of the DSR */
	 assign stall_on_trap = spr_dsr[`OR1K_SPR_DSR_TE];

         always @(posedge clk `OR_ASYNC_RST)
           if (rst)
             stepped_into_exception <= 0;
           else if (du_restart_from_stall)
             stepped_into_exception <= 0;
           else if (stepping & execute_done)
             stepped_into_exception <= exception;

         always @(posedge clk `OR_ASYNC_RST)
           if (rst)
             stepped_into_rfe <= 0;
           else if (du_restart_from_stall)
             stepped_into_rfe <= 0;
           else if (stepping & execute_done)
             stepped_into_rfe <= op_rfe;

         assign du_restart_pc_o = du_npc_write ? du_dat_i :
                                  stepped_into_rfe ? spr_epcr : spr_npc;

         assign du_restart_o = du_restart_from_stall;

         /* Indicate when we're stepping */
         assign stepping = spr_dmr1[`OR1K_SPR_DMR1_ST] &
                           spr_dsr[`OR1K_SPR_DSR_TE];

         always @(posedge clk `OR_ASYNC_RST)
           if (rst)
             pstep_r <= 0;
           else if (du_restart_from_stall & stepping)
             pstep_r <= 2'd1;
           else if ((pstep[0] & fetch_ready_i) |
                    /* decode is always single cycle */
                    (pstep[1] & execute_done))
             pstep_r <= {pstep_r[0],1'b0};

         assign pstep = pstep_r;

         always @(posedge clk `OR_ASYNC_RST)
           if (rst)
             branch_step <= 0;
           else if (stepping & pstep[1])
             branch_step <= {branch_step[0], ctrl_branch_occur};
           else if (!stepping & execute_done)
             branch_step <= {branch_step[0], /*execute_delay_slot*/ 1'b0};

         /* Signals for waveform debuging */
         wire [31:0] spr_read_data_group_0;
         assign spr_read_data_group_0 = spr_internal_read_dat[0];
         wire [31:0] spr_read_data_group_1;
         assign spr_read_data_group_1 = spr_internal_read_dat[1];
         wire [31:0] spr_read_data_group_2;
         assign spr_read_data_group_2 = spr_internal_read_dat[2];
         wire [31:0] spr_read_data_group_3;
         assign spr_read_data_group_3 = spr_internal_read_dat[3];
         wire [31:0] spr_read_data_group_4;
         assign spr_read_data_group_4 = spr_internal_read_dat[4];
         wire [31:0] spr_read_data_group_5;
         assign spr_read_data_group_5 = spr_internal_read_dat[5];
         wire [31:0] spr_read_data_group_6;
         assign spr_read_data_group_6 = spr_internal_read_dat[6];
         wire [31:0] spr_read_data_group_7;
         assign spr_read_data_group_7 = spr_internal_read_dat[7];
         wire [31:0] spr_read_data_group_8;
         assign spr_read_data_group_8 = spr_internal_read_dat[8];
         wire [31:0] spr_read_data_group_9;
         assign spr_read_data_group_9 = spr_internal_read_dat[9];


         /* always single cycle access */
         assign spr_access_ack[6] = 1;
         assign spr_internal_read_dat[6] = (spr_addr==`OR1K_SPR_DMR1_ADDR) ?
                                           spr_dmr1 :
                                           (spr_addr==`OR1K_SPR_DMR2_ADDR) ?
                                           spr_dmr2 :
                                           (spr_addr==`OR1K_SPR_DSR_ADDR) ?
                                           spr_dsr :
                                           (spr_addr==`OR1K_SPR_DRR_ADDR) ?
                                           spr_drr : 0;

         /* Put the incoming stall signal through a register to detect FE */
         always @(posedge clk `OR_ASYNC_RST)
           if (rst)
             du_stall_r <= 0;
           else
             du_stall_r <= du_stall_i;

         /* DMR1 */
         always @(posedge clk `OR_ASYNC_RST)
           if (rst)
             spr_dmr1 <= 0;
           else if (spr_we && spr_addr==`OR1K_SPR_DMR1_ADDR)
             spr_dmr1[23:0] <= spr_write_dat[23:0];

         /* DMR2 */
         always @(posedge clk)
           spr_dmr2 <= 0;

         /* DSR */
         always @(posedge clk `OR_ASYNC_RST)
           if (rst)
             spr_dsr <= 0;
           else if (spr_we && spr_addr==`OR1K_SPR_DSR_ADDR)
             spr_dsr[13:0] <= spr_write_dat[13:0];

         /* DRR */
         always @(posedge clk `OR_ASYNC_RST)
           if (rst)
             spr_drr <= 0;
           else if (spr_we && spr_addr==`OR1K_SPR_DRR_ADDR)
             spr_drr[13:0] <= spr_write_dat[13:0];
	   else if (stall_on_trap & execute_done & except_trap_i)
	     spr_drr[`OR1K_SPR_DRR_TE] <= 1;


      end // block: du
      else
        begin : no_du
           assign du_access = 0;
           assign du_stall_o = 0;
           assign du_ack_o = 0;
           assign du_restart_o = 0;
           assign du_restart_pc_o = 0;
           assign stepping = 0;
           assign du_npc_write = 0;
           assign du_dat_o = 0;
           assign du_restart_from_stall = 0;
           assign spr_access_ack[6] = 0;

	   always @(posedge clk)
	     begin
		cpu_stall <= 0;
		spr_dmr1 <= 0;
		spr_dmr2 <= 0;
		spr_dsr <= 0;
		spr_drr <= 0;
	     end
        end
   endgenerate

   /* Controls to generate ACKs from units that are external to this module */
   generate
      if (FEATURE_DMMU!="NONE") begin : dmmu_ctrl
         assign spr_access_ack[1] = spr_bus_ack_dmmu_i;
         assign spr_internal_read_dat[1] = spr_bus_dat_dmmu_i;
      end
      else begin
         assign spr_access_ack[1] = 0;
         assign spr_internal_read_dat[1] = 0;
      end
   endgenerate

   generate
      if (FEATURE_IMMU!="NONE") begin : immu_ctrl
         assign spr_access_ack[2] = spr_bus_ack_immu_i;
         assign spr_internal_read_dat[2] = spr_bus_dat_immu_i;
      end
      else begin
         assign spr_access_ack[2] = 0;
         assign spr_internal_read_dat[2] = 0;
      end
   endgenerate

   generate
      if (FEATURE_DATACACHE!="NONE") begin : datacache_ctrl
         assign spr_access_ack[3] = spr_bus_ack_dc_i;
         assign spr_internal_read_dat[3] = spr_bus_dat_dc_i;
      end
      else begin
         assign spr_access_ack[3] = 0;
         assign spr_internal_read_dat[3] = 0;
      end
   endgenerate

   generate
      if (FEATURE_INSTRUCTIONCACHE!="NONE") begin : instructioncache_ctrl
         assign spr_access_ack[4] = spr_bus_ack_ic_i;
         assign spr_internal_read_dat[4] = spr_bus_dat_ic_i;
      end
      else begin
         assign spr_access_ack[4] = 0;
         assign spr_internal_read_dat[4] = 0;
      end
   endgenerate

   generate
      if (FEATURE_MAC!="NONE") begin : mac_ctrl
         assign spr_access_ack[5] = spr_bus_ack_mac_i;
         assign spr_internal_read_dat[5] = spr_bus_dat_mac_i;
      end
      else begin
         assign spr_access_ack[5] = 0;
         assign spr_internal_read_dat[5] = 0;
      end
   endgenerate

   generate
      if (FEATURE_PERFCOUNTERS!="NONE") begin : perfcounters_ctrl
         assign spr_access_ack[7] = spr_bus_ack_pcu_i;
         assign spr_internal_read_dat[7] = spr_bus_dat_pcu_i;
      end
      else begin
         assign spr_access_ack[7] = 0;
         assign spr_internal_read_dat[7] = 0;
      end
   endgenerate

   generate
      if (FEATURE_PMU!="NONE") begin : pmu_ctrl
         assign spr_access_ack[8] = spr_bus_ack_pmu_i;
         assign spr_internal_read_dat[8] = spr_bus_dat_pcu_i;
      end
      else begin
         assign spr_access_ack[8] = 0;
         assign spr_internal_read_dat[8] = 0;
      end
   endgenerate

   generate
      if (FEATURE_FPU!="NONE") begin : fpu_ctrl
         assign spr_access_ack[11] = spr_bus_ack_fpu_i;
         assign spr_internal_read_dat[11] = spr_bus_dat_fpu_i;
      end
      else begin
         assign spr_access_ack[11] = 0;
         assign spr_internal_read_dat[11] = 0;
      end
   endgenerate

   // synthesis translate_off

   generate
      if (FEATURE_INBUILT_CHECKERS != "NONE") begin : execute_checker

	 reg [OPTION_OPERAND_WIDTH-1:0] last_execute_pc;
	 reg 				just_branched = 1;
	 reg                            had_rfe = 0;
	 integer 			insns = 0;


	 // A monitor to do a rudimentary check of the processor's PC
	 // progression
	 always @(negedge clk) begin

	    if (op_rfe)
	      had_rfe = 1;

	    if (execute_done & !stepping) begin

	       // First instruction of an exception vector, ie.
	       // 0x100, 0x200, 0x300 ... 0x2000
	       if (~|spr_ppc[31:14] && ~|spr_ppc[7:0])
		 just_branched = 1;

	       if (!just_branched && spr_ppc != (last_execute_pc+4) && 
		   (insns > 2))
		 begin
		    /* verilator lint_off STMTDLY */
		    #5;
		    /* verilator lint_on STMTDLY */
		    $display("CPU didn't execute in correct order");
		    $display("went: %08h, %08h",last_execute_pc, spr_ppc);
		    $finish();
		 end

	       insns = insns + 1;
	       last_execute_pc = spr_ppc;

	       case (ctrl_opc_insn_i)
		 `OR1K_OPCODE_J,
		 `OR1K_OPCODE_JAL,
		 `OR1K_OPCODE_JALR,
		 `OR1K_OPCODE_JR,
		 `OR1K_OPCODE_BNF,
		 `OR1K_OPCODE_BF,
		 `OR1K_OPCODE_RFE,
		 `OR1K_OPCODE_SYSTRAPSYNC:
		   just_branched = 1;
		 default:
		   just_branched = 0;
	       endcase // case (`EXECUTE_STAGE_INSN[`OR1K_OPCODE_POS])

	       if (had_rfe)
		 begin
		    // Sometimes the RFE will pulse high, and the
		    // branch logic in the fetch stage will acknowledge
		    // it but the instruction isn't "acked" in the
		    // control stage.
		    just_branched = 1;
		    had_rfe = 0;
		 end

	    end // if (execute_done & !stepping)
	    else if (du_npc_write)
	      just_branched = 1;
	 end // always @ (posedge `CPU_clk)
      end
   endgenerate
   // synthesis translate_on

endmodule // mor1kx_ctrl

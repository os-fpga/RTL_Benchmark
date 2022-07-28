 /* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: mor1kx pronto espresso fetch unit

  Fetch insn, advance PC (or take new branch address) on padv_i.

  What we might want to do is have a 1-insn buffer here, so when the current
  insn is fetched, but the main pipeline doesn't want it yet

  indicate ibus errors

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


module mor1kx_fetch_prontoespresso
  (/*AUTOARG*/
   // Outputs
   ibus_adr_o, ibus_req_o, ibus_burst_o, decode_insn_o, fetched_pc_o,
   fetch_ready_o, fetch_rfa_adr_o, fetch_rfb_adr_o, fetch_rf_re_o,
   pc_fetch_next_o, decode_except_ibus_err_o, fetch_sleep_o,
   fetch_quick_branch_o, spr_bus_dat_ic_o, spr_bus_ack_ic_o,
   // Inputs
   clk, rst, ibus_err_i, ibus_ack_i, ibus_dat_i, ic_enable, padv_i,
   branch_occur_i, branch_dest_i, ctrl_insn_done_i, du_restart_i,
   du_restart_pc_i, fetch_take_exception_branch_i, execute_waiting_i,
   du_stall_i, stepping_i, flag_i, flag_clear_i, flag_set_i,
   spr_bus_addr_i, spr_bus_we_i, spr_bus_stb_i, spr_bus_dat_i
   );

   parameter OPTION_OPERAND_WIDTH = 32;
   parameter OPTION_RF_ADDR_WIDTH = 5;
   parameter OPTION_RESET_PC = {{(OPTION_OPERAND_WIDTH-13){1'b0}},
				`OR1K_RESET_VECTOR,8'd0};
   // Mini cache registers, signals
   parameter FEATURE_INSTRUCTIONCACHE = "NONE";
   parameter OPTION_ICACHE_BLOCK_WIDTH = 3; // 3 for 8 words
   parameter FEATURE_QUICK_BRANCH_DETECTION = "NONE";

   input clk, rst;

   // interface to ibus
   output [OPTION_OPERAND_WIDTH-1:0] ibus_adr_o;
   output 			     ibus_req_o;
   output 			     ibus_burst_o;
   input 			     ibus_err_i;
   input 			     ibus_ack_i;
   input [`OR1K_INSN_WIDTH-1:0]      ibus_dat_i;
   input 			     ic_enable;

   // pipeline control input
   input 			      padv_i;

   // interface to decode unit
   output reg [`OR1K_INSN_WIDTH-1:0]  decode_insn_o;

   // PC of the current instruction, SPR_PPC basically
   output     [OPTION_OPERAND_WIDTH-1:0] fetched_pc_o;

   // Indication to pipeline control that the fetch stage is ready
   output 				 fetch_ready_o;

   // Signals going to register file to do the read access as we
   // register the instruction out to the decode stage
   output [OPTION_RF_ADDR_WIDTH-1:0] 	 fetch_rfa_adr_o;
   output [OPTION_RF_ADDR_WIDTH-1:0] 	 fetch_rfb_adr_o;
   output 				 fetch_rf_re_o;

   // Signal back to the control
   output [OPTION_OPERAND_WIDTH-1:0] 	 pc_fetch_next_o;


   // branch/jump indication
   input 				  branch_occur_i;
   input [OPTION_OPERAND_WIDTH-1:0] 	  branch_dest_i;

   // Instruction "retire" indication from control stage
   input 				  ctrl_insn_done_i;

   // restart signals from debug unit
   input 				  du_restart_i;
   input [OPTION_OPERAND_WIDTH-1:0] 	  du_restart_pc_i;

   input 				  fetch_take_exception_branch_i;

   input 				  execute_waiting_i;

   // CPU is stalled
   input 				  du_stall_i;

   // We're single stepping - this should cause us to fetch only a single insn
   input 				  stepping_i;

   // Flag status information
   input 				  flag_i, flag_clear_i, flag_set_i;

   // instruction ibus error indication out
   output reg 				  decode_except_ibus_err_o;

   // fetch sleep mode enabled (due to jump-to-self instruction
   output 				  fetch_sleep_o;

   // Indicate to the control stage that we had zero delay fetching
   // the branch target address
   output 				  fetch_quick_branch_o;

   // SPR interface
   input [15:0] 			  spr_bus_addr_i;
   input 				  spr_bus_we_i;
   input 				  spr_bus_stb_i;
   input [OPTION_OPERAND_WIDTH-1:0] 	  spr_bus_dat_i;
   output [OPTION_OPERAND_WIDTH-1:0] 	  spr_bus_dat_ic_o;
   output 				  spr_bus_ack_ic_o;


   // Registers
   reg [OPTION_OPERAND_WIDTH-1:0] 	  pc;
   reg [OPTION_OPERAND_WIDTH-1:0]         fetched_pc;
   reg 					  fetch_req;
   reg 					  next_insn_will_branch;
   reg 					  have_early_pc_next;
   reg 					  jump_insn_in_decode;
   reg 					  took_early_calc_pc;
   reg [1:0]				  took_early_calc_pc_r;
   reg 					  padv_r;
   reg 					  took_branch;
   reg 					  took_branch_r;
   reg 					  execute_waiting_r;
   reg 					  sleep;
   reg 					  complete_current_req;
   reg   				  no_rf_read;
   reg 					  new_insn_wasnt_ready;
   reg 					  took_early_pc_onto_cache_hit;
   reg 					  waited_with_early_pc_onto_cache_hit;

   // Wires
   wire [`OR1K_INSN_WIDTH-1:0] 		  new_insn;
   wire 				  new_insn_ready;
   wire [OPTION_OPERAND_WIDTH-1:0] 	  pc_fetch_next;
   wire [OPTION_OPERAND_WIDTH-1:0] 	  pc_plus_four;
   wire [OPTION_OPERAND_WIDTH-1:0] 	  early_pc_next;
   wire 				  padv_deasserted;
   wire 				  padv_asserted;
   wire [`OR1K_OPCODE_WIDTH-1:0] 	  next_insn_opcode;
   wire 				  will_go_to_sleep;
   wire 				  mini_cache_hit;
   wire 				  mini_cache_hit_ungated;
   wire [`OR1K_INSN_WIDTH-1:0] 		  mini_cache_insn;
   wire 				  hold_decode_output;
   wire 				  next_instruction_to_decode_condition;

   assign pc_plus_four		= pc + 4;

   assign pc_fetch_next         = have_early_pc_next ?
				  early_pc_next : pc_plus_four;

   assign ibus_adr_o		= pc;
   assign ibus_req_o		= (fetch_req & !(fetch_take_exception_branch_i/* | branch_occur_i*/)
				  // This is needed in the case that:
				  // 1. a burst just finished and ack in went low because of this
				  // 2. the instruction we just ACKed is a multicycle insn so the
				  //    execute_waiting_i goes high, but the bus interface will have
				  //    already put out the request onto the bus. It causes a bug
				  //    if we deassert the req from here 1 cycle later, so put this
				  //    signal into the assign logic so that the first cycle of it
				  //    causes req to go low, after which fetch_req is deasserted
				  //    and should handle it
				  & !(execute_waiting_i & fetch_req)
				  & !mini_cache_hit_ungated) |
				  complete_current_req;
   assign ibus_burst_o		= 0;

   assign fetch_ready_o		= new_insn_ready | jump_insn_in_decode | ibus_err_i;

   assign pc_fetch_next_o       = pc_fetch_next;

   assign new_insn              = mini_cache_hit ? mini_cache_insn : ibus_dat_i;

   assign new_insn_ready        = mini_cache_hit | ibus_ack_i;

   // Register file control
   assign fetch_rfa_adr_o	= new_insn_ready ? new_insn[`OR1K_RA_SELECT] : 0;
   assign fetch_rfb_adr_o	= new_insn_ready ? new_insn[`OR1K_RB_SELECT] : 0;
   assign fetch_rf_re_o		= new_insn_ready & (padv_i | stepping_i) &
				  !(no_rf_read | hold_decode_output);

   // Pick out opcode of next instruction to go to decode stage
   assign next_insn_opcode      = new_insn[`OR1K_OPCODE_SELECT];

   // Can calculate next PC based on instruction coming in
   assign early_pc_next = {OPTION_OPERAND_WIDTH{have_early_pc_next}} &
			  ({{4{new_insn[25]}},
			    new_insn[`OR1K_JUMPBRANCH_IMMEDIATE_SELECT],
			    2'b00} + pc);

   assign will_go_to_sleep = have_early_pc_next &
			     (early_pc_next == pc);

   assign fetch_sleep_o = sleep;

   // The pipeline advance signal deasserted for the instruction
   // we just put out, and we're still attempting to fetch. This should
   // result in a deassert cycle on the request signal out to the bus.
   // But, we don't want this to indicate when padv_i was deasserted for
   // a branch, because we will know about that, we just want this to
   // indicate it was deasserted for other reasons.
   assign padv_deasserted = padv_r & !padv_i & fetch_req & !took_branch;

   assign padv_asserted = !padv_r & padv_i;

   // This makes us hold the decode stage output for an additional
   // cycle when we've already got the next instruction in the
   // register output to the decode stage, but the pipeline has
   // stalled.
   assign hold_decode_output = (padv_asserted &
				mini_cache_hit & took_branch_r &
				!new_insn_wasnt_ready &
				took_early_calc_pc_r[1]) ||
			       waited_with_early_pc_onto_cache_hit;
   always @*
     if (new_insn_ready)
       case (next_insn_opcode)
	 `OR1K_OPCODE_J,
	 `OR1K_OPCODE_JAL: begin
	    have_early_pc_next		= 1;
	    next_insn_will_branch	= 1;
	    no_rf_read                  = 1;
	 end
	 `OR1K_OPCODE_JR,
	 `OR1K_OPCODE_JALR: begin
	    have_early_pc_next		= 0;
	    next_insn_will_branch	= 1;
	    no_rf_read                  = 0;
	 end
	 `OR1K_OPCODE_BNF: begin
	    have_early_pc_next		= !(flag_i | flag_set_i) | flag_clear_i;
	    next_insn_will_branch	= !(flag_i | flag_set_i) | flag_clear_i;
	    no_rf_read                  = 1;
	 end
	 `OR1K_OPCODE_BF: begin
	    have_early_pc_next		= !(!flag_i | flag_clear_i) |flag_set_i;
	    next_insn_will_branch	= !(!flag_i | flag_clear_i) |flag_set_i;
	    no_rf_read                  = 1;
	 end
	 `OR1K_OPCODE_SYSTRAPSYNC,
	 `OR1K_OPCODE_RFE: begin
	    have_early_pc_next		= 0;
	    next_insn_will_branch	= 1;
	    no_rf_read                  = 1;
	 end
	 default: begin
	   have_early_pc_next		= 0;
	   next_insn_will_branch	= 0;
	   no_rf_read                   = 0;
	 end
       endcase // case (next_insn_opcode)
     else
       begin
	  have_early_pc_next		= 0;
	  next_insn_will_branch		= 0;
	  no_rf_read                    = 0;
       end

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       begin
	  pc		<= OPTION_RESET_PC;
	  fetched_pc  	<= OPTION_RESET_PC;
       end
     else if (branch_occur_i & !took_early_calc_pc)
       begin
	  pc		<= branch_dest_i;
       end
     else if (fetch_take_exception_branch_i & !du_stall_i)
       begin
	  pc		<= branch_dest_i;
       end
     else if (new_insn_ready & (padv_i | stepping_i) &
	      !hold_decode_output)
       begin
	  pc		<= pc_fetch_next_o;
	  fetched_pc  	<= pc;
       end
     else if (du_restart_i)
       begin
	  pc		<= du_restart_pc_i;
       end
     else if (fetch_take_exception_branch_i & du_stall_i)
       begin
	  pc		<= du_restart_pc_i;
       end

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       new_insn_wasnt_ready <= 0;
     else if (branch_occur_i & !took_early_calc_pc)
       new_insn_wasnt_ready <= !new_insn_ready;
     else if (new_insn_ready & (padv_i | stepping_i) & !padv_deasserted)
       new_insn_wasnt_ready <= 0;

   assign fetched_pc_o = fetched_pc;

   assign next_instruction_to_decode_condition = new_insn_ready &
						 (padv_i | stepping_i) &
						 !padv_deasserted &
						 !hold_decode_output &
						 !((branch_occur_i & padv_i &
						    !took_early_calc_pc) |
						   fetch_take_exception_branch_i);


   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       decode_insn_o <= {`OR1K_OPCODE_NOP,26'd0};
     else if (sleep | du_stall_i)
       decode_insn_o <= {`OR1K_OPCODE_NOP,26'd0};
     else if (next_instruction_to_decode_condition)
       decode_insn_o <= new_insn;
     else if (branch_occur_i & padv_i)
       // We've just taken a branch, put a nop on the
       // instruction to the rest of the pipeline
       decode_insn_o <= {`OR1K_OPCODE_NOP,26'd0};
     else if (fetch_take_exception_branch_i)
       // Exception was just taken, get rid of whatever
       // we're outputting
       decode_insn_o <= {`OR1K_OPCODE_NOP,26'd0};
     else if (took_early_calc_pc)
       // This covers the case where, for some reason,
       // we don't get the branch_occur_i
       decode_insn_o <= {`OR1K_OPCODE_NOP,26'd0};
     else if (ctrl_insn_done_i & !new_insn_ready)
       // If the current instruction in the decode stage is retired
       // then let's put a no-op back in the pipeline
       decode_insn_o <= {`OR1K_OPCODE_NOP,26'd0};

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       fetch_req <= 1'b1;
     else if (fetch_req & stepping_i & new_insn_ready)
       // Deassert on ack
       fetch_req <= 1'b0;
     else if (!fetch_req & du_stall_i)
       fetch_req <= 1'b0;
     else if (ibus_err_i)
       fetch_req <= 1'b0;
     else if (sleep)
       fetch_req <= 1'b0;
     else if (next_insn_will_branch)
       fetch_req <= 1'b0;
     else if (execute_waiting_i)
       /*
        Put the execute wait signal through this register to break any long
        chains of logic from the execute stage (LSU, ALU) which could result
        from using it to just gate the req signal out.
        TODO - actually check the impact of gating fetch_req_o with
               execute_waiting_i
        */
       fetch_req <= 1'b0;
     else if (padv_deasserted)
       fetch_req <= 1'b0;
     else if (mini_cache_hit_ungated)
       // We'll get this ungated signal immediately after we've
       // terminated a burst, so we'll know if we really should
       // fetch the branch target or whether it's in cache.
       fetch_req <= 1'b0;
     else
       fetch_req <= 1'b1;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       took_early_pc_onto_cache_hit <= 0;
     else if (padv_i)
       took_early_pc_onto_cache_hit <= took_early_calc_pc & mini_cache_hit &
					!fetch_take_exception_branch_i;
     else if (ctrl_insn_done_i)
       took_early_pc_onto_cache_hit <= 0;

   // This register signifies when:
   // a) we had a branch to somewhere where we took the early calculated PC and
   //    that branch location was a hit in the cache
   // b) the subsequent instruction wasn't in the cache, so we put the
   //    insn out to the decode stage, but wasn't immediately retired by the
   //    control stage, so we must wait until the next instruction is ready
   //    before it will be completed by the control stage
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       waited_with_early_pc_onto_cache_hit <= 0;
     else if (took_branch_r | padv_i)
       waited_with_early_pc_onto_cache_hit <= took_early_pc_onto_cache_hit &
					       !fetch_ready_o;
     else if (ctrl_insn_done_i)
       waited_with_early_pc_onto_cache_hit <= 0;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       jump_insn_in_decode <= 0;
     else if (sleep)
       jump_insn_in_decode <= 0;
     else if (!jump_insn_in_decode & next_insn_will_branch & new_insn_ready & padv_i)
       jump_insn_in_decode <= 1;
     else
       jump_insn_in_decode <= 0;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       took_early_calc_pc <= 0;
     else if (sleep)
       took_early_calc_pc <= 0;
     else if (next_insn_will_branch & have_early_pc_next & padv_i)
       took_early_calc_pc <= 1;
     else
       took_early_calc_pc <= 0;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       took_early_calc_pc_r <= 0;
     else
       took_early_calc_pc_r <= {took_early_calc_pc_r[0], took_early_calc_pc};

   always @(posedge clk)
     padv_r <= padv_i;

   /* Whether it was early branch or not, we've branched, and this
    signal will be asserted the cycle after. */
   always @(posedge clk)
     begin
        took_branch <= (branch_occur_i | fetch_take_exception_branch_i) &
                       fetch_ready_o;
        took_branch_r <= took_branch;
     end

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       decode_except_ibus_err_o <= 0;
     else if ((padv_i | fetch_take_exception_branch_i) &
	      branch_occur_i | du_stall_i)
       decode_except_ibus_err_o <= 0;
     else if (fetch_req)
       decode_except_ibus_err_o <= ibus_err_i;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       sleep <= 1'b0;
     else if (fetch_take_exception_branch_i | du_stall_i)
       sleep <= 1'b0;
     else if (will_go_to_sleep & !stepping_i)
       sleep <= 1'b1;

   // A signal to make sure the request out line stays high
   // if we've already issued an instruction request and padv_i
   // goes low.
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       complete_current_req <= 0;
     else if (fetch_req & padv_deasserted & !new_insn_ready)
      complete_current_req  <= 1;
     else if (new_insn_ready & complete_current_req)
       complete_current_req <= 0;

   // Mini cache logic
   genvar 					     i;
   generate
      /* verilator lint_off WIDTH */
      if (FEATURE_INSTRUCTIONCACHE != "ENABLED")
      /* verilator lint_on WIDTH */
	begin : no_mini_cache
	   assign mini_cache_hit = 0;
	   assign mini_cache_hit_ungated = 0;
	   assign mini_cache_insn = {`OR1K_INSN_WIDTH{1'b0}};
	   assign fetch_quick_branch_o = 0;
	end
      else
	begin : mini_cache
	   localparam NUMBER_MINI_CACHE_WORDS =  (1<<OPTION_ICACHE_BLOCK_WIDTH);
	   localparam MINI_CACHE_TAG_END      = OPTION_ICACHE_BLOCK_WIDTH+2;

	   reg mini_cache_tag_valid [0:NUMBER_MINI_CACHE_WORDS-1];
	   wire mini_cache_fill_condition;
	   wire invalidate;
	   reg [`OR1K_INSN_WIDTH-1:0] mini_cache [0:NUMBER_MINI_CACHE_WORDS-1];
	   reg [OPTION_OPERAND_WIDTH-1:MINI_CACHE_TAG_END] mini_cache_tag [0:NUMBER_MINI_CACHE_WORDS-1];
	   wire [OPTION_OPERAND_WIDTH-1:MINI_CACHE_TAG_END] pc_tag;
	   wire [OPTION_ICACHE_BLOCK_WIDTH-1:0] 	    pc_word_sel;
	   wire [`OR1K_INSN_WIDTH-1:0] 		    mini_cache_branch_dest_insn;

	   // This is the address we'll write into the tag
	   assign pc_word_sel    = pc[OPTION_ICACHE_BLOCK_WIDTH+1:2];
	   assign pc_tag         = pc[OPTION_OPERAND_WIDTH-1:MINI_CACHE_TAG_END];

	   assign mini_cache_hit_ungated = mini_cache_tag_valid[pc_word_sel] &
					   mini_cache_tag[pc_word_sel]==pc_tag;

	   assign mini_cache_hit      = mini_cache_hit_ungated & !took_branch &
					!fetch_take_exception_branch_i;

	   assign mini_cache_insn     = mini_cache[pc_word_sel];

	   assign mini_cache_fill_condition = ibus_ack_i & !ibus_err_i &
					      !will_go_to_sleep;

	   assign invalidate = spr_bus_stb_i & spr_bus_we_i &
			       (spr_bus_addr_i == `OR1K_SPR_ICBIR_ADDR);

	   assign fetch_quick_branch_o = took_branch & mini_cache_hit;

	   assign spr_bus_ack_ic_o     = 1'b1;

	   for (i=0;i<NUMBER_MINI_CACHE_WORDS;i=i+1)
	     begin : flop_cache_control
		always @(posedge clk `OR_ASYNC_RST)
		  if (rst)
		    begin
		       mini_cache_tag[i]	<= 'd0;
		       mini_cache_tag_valid[i]	<= 1'b0;
		    end
		  else if (invalidate/* | !ic_enable*/ | du_stall_i)
		    begin
		       // Invalidate all tags on:
		       // 1) any write to the block-invalidate register
		       // 2) when the cache isn't enabled
		       // 3) whenever we're stalled - things may change
		       //    under our feet and it helps make things
		       //    easy when coming out of stall or stepping
		       mini_cache_tag_valid[i]	<= 1'b0;
		    end
		  else if (mini_cache_fill_condition &
			   pc_word_sel==i[OPTION_ICACHE_BLOCK_WIDTH-1:0])
		    begin
		       mini_cache_tag[i]	<= pc_tag;
		       mini_cache_tag_valid[i]	<= 1'b1;
		       mini_cache[i]		<= ibus_dat_i;
		    end
	     end

	end // block: mini_cache
   endgenerate

   assign spr_bus_ack_ic_o = 1'b1;
   assign spr_bus_dat_ic_o = {OPTION_OPERAND_WIDTH{1'b0}};

endmodule // mor1kx_fetch_prontoespresso

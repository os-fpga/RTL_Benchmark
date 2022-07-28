/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description:  Data bus interface

  All combinatorial outputs to pipeline
  Dbus interface request signal out synchronous

  32-bit specific

  Copyright (C) 2012 Julius Baxter <juliusbaxter@gmail.com>
  Copyright (C) 2013 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

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


module mor1kx_lsu_cappuccino
  #(
    parameter FEATURE_DATACACHE	= "NONE",
    parameter OPTION_OPERAND_WIDTH = 32,
    parameter OPTION_DCACHE_BLOCK_WIDTH = 5,
    parameter OPTION_DCACHE_SET_WIDTH = 9,
    parameter OPTION_DCACHE_WAYS = 2,
    parameter OPTION_DCACHE_LIMIT_WIDTH = 32,
    parameter OPTION_DCACHE_SNOOP = "NONE",
    parameter FEATURE_DMMU = "NONE",
    parameter FEATURE_DMMU_HW_TLB_RELOAD = "NONE",
    parameter OPTION_DMMU_SET_WIDTH = 6,
    parameter OPTION_DMMU_WAYS = 1,
    parameter FEATURE_STORE_BUFFER = "ENABLED",
    parameter OPTION_STORE_BUFFER_DEPTH_WIDTH = 8,
    parameter FEATURE_ATOMIC = "ENABLED"
    )
   (
    input 			      clk,
    input 			      rst,

    input 			      padv_execute_i,
    input 			      padv_ctrl_i, // needed for dmmu spr
    input 			      decode_valid_i,
    // calculated address from ALU
    input [OPTION_OPERAND_WIDTH-1:0]  exec_lsu_adr_i,
    input [OPTION_OPERAND_WIDTH-1:0]  ctrl_lsu_adr_i,

    // register file B in (store operand)
    input [OPTION_OPERAND_WIDTH-1:0]  ctrl_rfb_i,

    // from decode stage regs, indicate if load or store
    input 			      exec_op_lsu_load_i,
    input 			      exec_op_lsu_store_i,
    input 			      exec_op_lsu_atomic_i,
    input 			      ctrl_op_lsu_load_i,
    input 			      ctrl_op_lsu_store_i,
    input 			      ctrl_op_lsu_atomic_i,
    input [1:0] 		      ctrl_lsu_length_i,
    input 			      ctrl_lsu_zext_i,

    // From control stage, exception PC for the store buffer input
    input [OPTION_OPERAND_WIDTH-1:0]  ctrl_epcr_i,
    // The exception PC as it has went through the store buffer
    output [OPTION_OPERAND_WIDTH-1:0] store_buffer_epcr_o,

    output [OPTION_OPERAND_WIDTH-1:0] lsu_result_o,
    output 			      lsu_valid_o,
    // exception output
    output 			      lsu_except_dbus_o,
    output 			      lsu_except_align_o,
    output 			      lsu_except_dtlb_miss_o,
    output 			      lsu_except_dpagefault_o,

    // Indicator that the dbus exception came via the store buffer
    output reg 			      store_buffer_err_o,

    // Atomic operation flag set/clear logic
    output 			      atomic_flag_set_o,
    output 			      atomic_flag_clear_o,

    // SPR interface
    input [15:0] 		      spr_bus_addr_i,
    input 			      spr_bus_we_i,
    input 			      spr_bus_stb_i,
    input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_i,
    output [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_dc_o,
    output 			      spr_bus_ack_dc_o,
    output [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_dmmu_o,
    output 			      spr_bus_ack_dmmu_o,

    input 			      dc_enable_i,
    input 			      dmmu_enable_i,
    input 			      supervisor_mode_i,

    // interface to data bus
    output [OPTION_OPERAND_WIDTH-1:0] dbus_adr_o,
    output reg			      dbus_req_o,
    output [OPTION_OPERAND_WIDTH-1:0] dbus_dat_o,
    output reg [3:0] 		      dbus_bsel_o,
    output 			      dbus_we_o,
    output 			      dbus_burst_o,
    input 			      dbus_err_i,
    input 			      dbus_ack_i,
    input [OPTION_OPERAND_WIDTH-1:0]  dbus_dat_i,
    input 			      pipeline_flush_i,

    input [31:0] 		      snoop_adr_i,
    input 			      snoop_en_i
    );

   reg [OPTION_OPERAND_WIDTH-1:0]    dbus_dat_aligned;  // comb.
   reg [OPTION_OPERAND_WIDTH-1:0]    dbus_dat_extended; // comb.

   reg 				     access_done;

   wire 			     align_err_word;
   wire 			     align_err_short;

   wire 			     align_err;

   wire 			     except_align;

   reg 				     except_dbus;

   reg 				     dbus_ack;
   reg 				     dbus_err;
   reg [OPTION_OPERAND_WIDTH-1:0]    dbus_dat;
   reg [OPTION_OPERAND_WIDTH-1:0]    dbus_adr;
   wire [OPTION_OPERAND_WIDTH-1:0]   next_dbus_adr;
   reg 				     dbus_we;
   reg [3:0] 			     dbus_bsel;
   wire 			     dbus_access;
   wire 			     dbus_stall;

   wire [OPTION_OPERAND_WIDTH-1:0]   lsu_ldat;
   wire [OPTION_OPERAND_WIDTH-1:0]   lsu_sdat;
   wire				     lsu_ack;

   wire 			     dc_err;
   wire 			     dc_ack;
   wire [31:0] 			     dc_ldat;
   wire [31:0] 			     dc_sdat;
   wire [31:0] 			     dc_adr;
   wire [31:0] 			     dc_adr_match;
   wire 			     dc_req;
   wire 			     dc_we;
   wire [3:0] 			     dc_bsel;

   wire 			     dc_access;
   wire 			     dc_refill_allowed;
   wire 			     dc_refill;
   wire 			     dc_refill_req;
   wire 			     dc_refill_done;

   reg 				     dc_enable_r;
   wire 			     dc_enabled;

   wire 			     ctrl_op_lsu;

   // DMMU
   wire 			     tlb_miss;
   wire 			     pagefault;
   wire [OPTION_OPERAND_WIDTH-1:0]   dmmu_phys_addr;
   wire				     except_dtlb_miss;
   reg 				     except_dtlb_miss_r;
   wire 			     except_dpagefault;
   reg 				     except_dpagefault_r;
   wire 			     dmmu_cache_inhibit;

   wire 			     tlb_reload_req;
   wire 			     tlb_reload_busy;
   wire [OPTION_OPERAND_WIDTH-1:0]   tlb_reload_addr;
   wire 			     tlb_reload_pagefault;
   reg 				     tlb_reload_ack;
   reg [OPTION_OPERAND_WIDTH-1:0]    tlb_reload_data;
   wire				     tlb_reload_pagefault_clear;
   reg 				     tlb_reload_done;

   // Store buffer
   wire 			     store_buffer_write;
   wire				     store_buffer_read;
   wire 			     store_buffer_full;
   wire 			     store_buffer_empty;
   wire [OPTION_OPERAND_WIDTH-1:0]   store_buffer_radr;
   wire [OPTION_OPERAND_WIDTH-1:0]   store_buffer_wadr;
   wire [OPTION_OPERAND_WIDTH-1:0]   store_buffer_dat;
   wire [OPTION_OPERAND_WIDTH/8-1:0] store_buffer_bsel;
   wire 			     store_buffer_atomic;
   reg 				     store_buffer_write_pending;

   reg 				     dbus_atomic;

   reg 				     last_write;
   reg 				     write_done;

   // Atomic operations
   reg [OPTION_OPERAND_WIDTH-1:0]    atomic_addr;
   reg 				     atomic_reserve;
   wire				     swa_success;

   wire 			     snoop_valid;
   wire 			     dc_snoop_hit;

   // We have to mask out our snooped bus accesses
   assign snoop_valid = snoop_en_i &
			!((snoop_adr_i == dbus_adr_o) & dbus_ack_i);

   assign ctrl_op_lsu = ctrl_op_lsu_load_i | ctrl_op_lsu_store_i;

   assign lsu_sdat = (ctrl_lsu_length_i == 2'b00) ? // byte access
		     {ctrl_rfb_i[7:0],ctrl_rfb_i[7:0],
		      ctrl_rfb_i[7:0],ctrl_rfb_i[7:0]} :
		     (ctrl_lsu_length_i == 2'b01) ? // halfword access
		     {ctrl_rfb_i[15:0],ctrl_rfb_i[15:0]} :
		     ctrl_rfb_i;                    // word access

   assign align_err_word = |ctrl_lsu_adr_i[1:0];
   assign align_err_short = ctrl_lsu_adr_i[0];


   assign lsu_valid_o = (lsu_ack | access_done) & !tlb_reload_busy & !dc_snoop_hit;

   assign lsu_except_dbus_o = except_dbus | store_buffer_err_o;

   assign align_err = (ctrl_lsu_length_i == 2'b10) & align_err_word |
		      (ctrl_lsu_length_i == 2'b01) & align_err_short;

   assign except_align = ctrl_op_lsu & align_err;

   assign lsu_except_align_o = except_align & !pipeline_flush_i;

   assign except_dtlb_miss = ctrl_op_lsu & tlb_miss & dmmu_enable_i &
			     !tlb_reload_busy;

   assign lsu_except_dtlb_miss_o = except_dtlb_miss & !pipeline_flush_i;

   assign except_dpagefault = ctrl_op_lsu & pagefault & dmmu_enable_i &
			      !tlb_reload_busy | tlb_reload_pagefault;

   assign lsu_except_dpagefault_o = except_dpagefault & !pipeline_flush_i;


   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       access_done <= 0;
     else if (padv_execute_i)
       access_done <= 0;
     else if (lsu_ack)
       access_done <= 1;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       except_dbus <= 0;
     else if (padv_execute_i | pipeline_flush_i)
       except_dbus <= 0;
     else if (dbus_err_i)
       except_dbus <= 1;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       except_dtlb_miss_r <= 0;
     else if (padv_execute_i)
       except_dtlb_miss_r <= 0;
     else if (except_dtlb_miss)
       except_dtlb_miss_r <= 1;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       except_dpagefault_r <= 0;
     else if (padv_execute_i)
       except_dpagefault_r <= 0;
     else if (except_dpagefault)
       except_dpagefault_r <= 1;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       store_buffer_err_o <= 0;
     else if (pipeline_flush_i)
       store_buffer_err_o <= 0;
     else if (dbus_err_i & dbus_we_o)
       store_buffer_err_o <= 1;

   // Big endian bus mapping
   always @(*)
     case (ctrl_lsu_length_i)
       2'b00: // byte access
	 case(ctrl_lsu_adr_i[1:0])
	   2'b00:
	     dbus_bsel = 4'b1000;
	   2'b01:
	     dbus_bsel = 4'b0100;
	   2'b10:
	     dbus_bsel = 4'b0010;
	   2'b11:
	     dbus_bsel = 4'b0001;
	 endcase
       2'b01: // halfword access
	    case(ctrl_lsu_adr_i[1])
	      1'b0:
		dbus_bsel = 4'b1100;
	      1'b1:
		dbus_bsel = 4'b0011;
	    endcase
       2'b10,
       2'b11:
	 dbus_bsel = 4'b1111;
     endcase

   // Select part of read word
   always @*
     case(ctrl_lsu_adr_i[1:0])
       2'b00:
	 dbus_dat_aligned = lsu_ldat;
       2'b01:
	 dbus_dat_aligned = {lsu_ldat[23:0],8'd0};
       2'b10:
	 dbus_dat_aligned = {lsu_ldat[15:0],16'd0};
       2'b11:
	 dbus_dat_aligned = {lsu_ldat[7:0],24'd0};
     endcase // case (ctrl_lsu_adr_i[1:0])

   // Do appropriate extension
   always @(*)
     case({ctrl_lsu_zext_i, ctrl_lsu_length_i})
       3'b100: // lbz
	 dbus_dat_extended = {24'd0,dbus_dat_aligned[31:24]};
       3'b101: // lhz
	 dbus_dat_extended = {16'd0,dbus_dat_aligned[31:16]};
       3'b000: // lbs
	 dbus_dat_extended = {{24{dbus_dat_aligned[31]}},
			      dbus_dat_aligned[31:24]};
       3'b001: // lhs
	 dbus_dat_extended = {{16{dbus_dat_aligned[31]}},
			      dbus_dat_aligned[31:16]};
       default:
	 dbus_dat_extended = dbus_dat_aligned;
     endcase

   assign lsu_result_o = dbus_dat_extended;

   // Bus access logic
   localparam [2:0]
     IDLE		= 3'd0,
     READ		= 3'd1,
     WRITE		= 3'd2,
     TLB_RELOAD		= 3'd3,
     DC_REFILL		= 3'd4;

   reg [2:0] state;

   assign dbus_access = (!dc_access | tlb_reload_busy | ctrl_op_lsu_store_i) &
			(state != DC_REFILL) | (state == WRITE);
   reg      dc_refill_r;

   always @(posedge clk)
     dc_refill_r <= dc_refill;

   wire     store_buffer_ack;
   assign store_buffer_ack = (FEATURE_STORE_BUFFER!="NONE") ?
			     store_buffer_write :
			     write_done;

   assign lsu_ack = (ctrl_op_lsu_store_i | state == WRITE) ?
		    (store_buffer_ack & !ctrl_op_lsu_atomic_i |
		     write_done & ctrl_op_lsu_atomic_i) :
		    (dbus_access ? dbus_ack : dc_ack);

   assign lsu_ldat = dbus_access ? dbus_dat : dc_ldat;
   assign dbus_adr_o = dbus_adr;

   assign dbus_dat_o = dbus_dat;

   assign dbus_burst_o = (state == DC_REFILL) & !dc_refill_done;

   //
   // Slightly subtle, but if there is an atomic store coming out from the
   // store buffer, and the link has been broken while it was waiting there,
   // the bus access is still performed as a (discarded) read.
   //
   assign dbus_we_o = dbus_we & (!dbus_atomic | atomic_reserve);

   assign next_dbus_adr = (OPTION_DCACHE_BLOCK_WIDTH == 5) ?
			  {dbus_adr[31:5], dbus_adr[4:0] + 5'd4} : // 32 byte
			  {dbus_adr[31:4], dbus_adr[3:0] + 4'd4};  // 16 byte

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       dbus_err <= 0;
     else
       dbus_err <= dbus_err_i;

   always @(posedge clk) begin
      dbus_ack <= 0;
      write_done <= 0;
      tlb_reload_ack <= 0;
      tlb_reload_done <= 0;
      case (state)
	IDLE: begin
	   dbus_req_o <= 0;
	   dbus_we <= 0;
	   dbus_adr <= 0;
	   dbus_bsel_o <= 4'hf;
	   dbus_atomic <= 0;
	   last_write <= 0;
	   if (store_buffer_write | !store_buffer_empty) begin
	      state <= WRITE;
	   end else if (ctrl_op_lsu & dbus_access & !dc_refill & !dbus_ack &
			!dbus_err & !except_dbus & !access_done &
			!pipeline_flush_i) begin
	      if (tlb_reload_req) begin
		 dbus_adr <= tlb_reload_addr;
		 dbus_req_o <= 1;
		 state <= TLB_RELOAD;
	      end else if (dmmu_enable_i) begin
		 dbus_adr <= dmmu_phys_addr;
		 if (!tlb_miss & !pagefault & !except_align) begin
		    if (ctrl_op_lsu_load_i) begin
		       dbus_req_o <= 1;
		       dbus_bsel_o <= dbus_bsel;
		       state <= READ;
		    end
		 end
	      end else if (!except_align) begin
		 dbus_adr <= ctrl_lsu_adr_i;
		 if (ctrl_op_lsu_load_i) begin
		    dbus_req_o <= 1;
		    dbus_bsel_o <= dbus_bsel;
		    state <= READ;
		 end
	      end
	   end else if (dc_refill_req) begin
	      dbus_req_o <= 1;
	      dbus_adr <= dc_adr_match;
	      state <= DC_REFILL;
	   end
	end

	DC_REFILL: begin
	   dbus_req_o <= 1;
	   if (dbus_ack_i) begin
	      dbus_adr <= next_dbus_adr;
	      if (dc_refill_done) begin
		 dbus_req_o <= 0;
		 state <= IDLE;
	      end
	   end

	   // TODO: only abort on snoop-hits to refill address
	   if (dbus_err_i | dc_snoop_hit) begin
	      dbus_req_o <= 0;
	      state <= IDLE;
	   end
	end

	READ: begin
	   dbus_ack <= dbus_ack_i;
	   dbus_dat <= dbus_dat_i;
	   if (dbus_ack_i | dbus_err_i) begin
	      dbus_req_o <= 0;
	      state <= IDLE;
	   end
	end

	WRITE: begin
	   dbus_req_o <= 1;
	   dbus_we <= 1;

	   if (!dbus_req_o | dbus_ack_i & !last_write) begin
	      dbus_bsel_o <= store_buffer_bsel;
	      dbus_adr <= store_buffer_radr;
	      dbus_dat <= store_buffer_dat;
	      dbus_atomic <= store_buffer_atomic;
	      last_write <= store_buffer_empty;
	   end

	   if (store_buffer_write)
	     last_write <= 0;

	   if (last_write & dbus_ack_i | dbus_err_i) begin
	      dbus_req_o <= 0;
	      dbus_we <= 0;
	      if (!store_buffer_write) begin
		 state <= IDLE;
		 write_done <= 1;
	      end
	   end
	end

	TLB_RELOAD: begin
	   dbus_adr <= tlb_reload_addr;
	   tlb_reload_data <= dbus_dat_i;
	   tlb_reload_ack <= dbus_ack_i & tlb_reload_req;

	   if (!tlb_reload_req | dbus_err_i) begin
	      state <= IDLE;
	      tlb_reload_done <= 1;
	   end

	   dbus_req_o <= tlb_reload_req;
	   if (dbus_ack_i | tlb_reload_ack)
	     dbus_req_o <= 0;
	end

	default:
	  state <= IDLE;
      endcase

      if (rst)
	state <= IDLE;
   end

   assign dbus_stall = tlb_reload_busy | except_align | except_dbus |
		       except_dtlb_miss | except_dpagefault |
		       pipeline_flush_i;

generate
if (FEATURE_ATOMIC!="NONE") begin : atomic_gen
   // Atomic operations logic
   reg atomic_flag_set;
   reg atomic_flag_clear;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       atomic_reserve <= 0;
     else if (pipeline_flush_i)
       atomic_reserve <= 0;
     else if (ctrl_op_lsu_store_i & ctrl_op_lsu_atomic_i & write_done ||
	      !ctrl_op_lsu_atomic_i & store_buffer_write &
	      (store_buffer_wadr == atomic_addr) ||
	      (snoop_valid & (snoop_adr_i == atomic_addr)))
       atomic_reserve <= 0;
     else if (ctrl_op_lsu_load_i & ctrl_op_lsu_atomic_i & padv_ctrl_i)
       atomic_reserve <= !(snoop_valid & (snoop_adr_i == dc_adr_match));

   always @(posedge clk)
     if (ctrl_op_lsu_load_i & ctrl_op_lsu_atomic_i & padv_ctrl_i)
       atomic_addr <= dc_adr_match;

   assign swa_success = ctrl_op_lsu_store_i & ctrl_op_lsu_atomic_i &
			atomic_reserve & (dbus_adr == atomic_addr);

   always @(posedge clk)
     if (padv_ctrl_i)
       atomic_flag_set <= 0;
     else if (write_done)
       atomic_flag_set <= swa_success & lsu_valid_o;

   always @(posedge clk)
     if (padv_ctrl_i)
       atomic_flag_clear <= 0;
     else if (write_done)
       atomic_flag_clear <= !swa_success & lsu_valid_o &
			    ctrl_op_lsu_atomic_i & ctrl_op_lsu_store_i;

   assign atomic_flag_set_o = atomic_flag_set;
   assign atomic_flag_clear_o = atomic_flag_clear;

end else begin
   assign atomic_flag_set_o = 0;
   assign atomic_flag_clear_o = 0;
   assign swa_success = 0;
   always @(posedge clk) begin
      atomic_addr <= 0;
      atomic_reserve <= 0;
   end
end
endgenerate

   // Store buffer logic
   always @(posedge clk)
     if (rst)
       store_buffer_write_pending <= 0;
     else if (store_buffer_write | pipeline_flush_i)
       store_buffer_write_pending <= 0;
     else if (ctrl_op_lsu_store_i & padv_ctrl_i & !dbus_stall &
	      (store_buffer_full | dc_refill | dc_refill_r | dc_snoop_hit))
       store_buffer_write_pending <= 1;

   assign store_buffer_write = (ctrl_op_lsu_store_i &
				(padv_ctrl_i | tlb_reload_done) |
				store_buffer_write_pending) &
			       !store_buffer_full & !dc_refill & !dc_refill_r &
			       !dbus_stall & !dc_snoop_hit;

generate
if (FEATURE_STORE_BUFFER!="NONE") begin : store_buffer_gen
   assign store_buffer_read = (state == IDLE) & store_buffer_write |
			      (state == IDLE) & !store_buffer_empty |
			      (state == WRITE) & (dbus_ack_i | !dbus_req_o) &
			      (!store_buffer_empty | store_buffer_write) &
			      !last_write |
			      (state == WRITE) & last_write &
			      store_buffer_write;

   mor1kx_store_buffer
     #(
       .DEPTH_WIDTH(OPTION_STORE_BUFFER_DEPTH_WIDTH),
       .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH)
       )
   mor1kx_store_buffer
     (
      .clk	(clk),
      .rst	(rst),

      .pc_i	(ctrl_epcr_i),
      .adr_i	(store_buffer_wadr),
      .dat_i	(lsu_sdat),
      .bsel_i	(dbus_bsel),
      .atomic_i	(ctrl_op_lsu_atomic_i),
      .write_i	(store_buffer_write),

      .pc_o	(store_buffer_epcr_o),
      .adr_o	(store_buffer_radr),
      .dat_o	(store_buffer_dat),
      .bsel_o	(store_buffer_bsel),
      .atomic_o	(store_buffer_atomic),
      .read_i	(store_buffer_read),

      .full_o	(store_buffer_full),
      .empty_o	(store_buffer_empty)
      );
end else begin
   assign store_buffer_epcr_o = ctrl_epcr_i;
   assign store_buffer_radr = store_buffer_wadr;
   assign store_buffer_dat = lsu_sdat;
   assign store_buffer_bsel = dbus_bsel;
   assign store_buffer_empty = 1'b1;

   reg store_buffer_full_r;
   always @(posedge clk)
     if (store_buffer_write)
       store_buffer_full_r <= 1;
     else if (write_done)
       store_buffer_full_r <= 0;

   assign store_buffer_full = store_buffer_full_r & !write_done;
end
endgenerate
   assign store_buffer_wadr = dc_adr_match;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       dc_enable_r <= 0;
     else if (dc_enable_i & !dbus_req_o)
       dc_enable_r <= 1;
     else if (!dc_enable_i & !dc_refill)
       dc_enable_r <= 0;

   assign dc_enabled = dc_enable_i & dc_enable_r;
   assign dc_adr = padv_execute_i &
		   (exec_op_lsu_load_i | exec_op_lsu_store_i) ?
		   exec_lsu_adr_i : ctrl_lsu_adr_i;
   assign dc_adr_match = dmmu_enable_i ?
			 {dmmu_phys_addr[OPTION_OPERAND_WIDTH-1:2],2'b0} :
			 {ctrl_lsu_adr_i[OPTION_OPERAND_WIDTH-1:2],2'b0};

   assign dc_req = ctrl_op_lsu & dc_access & !access_done & !dbus_stall &
		   !(dbus_atomic & dbus_we & !atomic_reserve);
   assign dc_refill_allowed = !(ctrl_op_lsu_store_i | state == WRITE) &
			      !dc_snoop_hit & !snoop_valid;

generate
if (FEATURE_DATACACHE!="NONE") begin : dcache_gen
   if (OPTION_DCACHE_LIMIT_WIDTH == OPTION_OPERAND_WIDTH) begin
      assign dc_access =  ctrl_op_lsu_store_i | dc_enabled &
			 !(dmmu_cache_inhibit & dmmu_enable_i);
   end else if (OPTION_DCACHE_LIMIT_WIDTH < OPTION_OPERAND_WIDTH) begin
      assign dc_access = ctrl_op_lsu_store_i | dc_enabled &
			 dc_adr_match[OPTION_OPERAND_WIDTH-1:
				      OPTION_DCACHE_LIMIT_WIDTH] == 0 &
			 !(dmmu_cache_inhibit & dmmu_enable_i);
   end else begin
      initial begin
	 $display("ERROR: OPTION_DCACHE_LIMIT_WIDTH > OPTION_OPERAND_WIDTH");
	 $finish();
      end
   end

   wire dc_rst = rst | dbus_err;

   assign dc_bsel = dbus_bsel;
   assign dc_we = exec_op_lsu_store_i & !exec_op_lsu_atomic_i & padv_execute_i |
		  dbus_atomic & dbus_we_o & !write_done |
		  ctrl_op_lsu_store_i & tlb_reload_busy & !tlb_reload_req;

   /* mor1kx_dcache AUTO_TEMPLATE (
	    .refill_o			(dc_refill),
	    .refill_req_o		(dc_refill_req),
	    .refill_done_o		(dc_refill_done),
	    .cpu_err_o			(dc_err),
	    .cpu_ack_o			(dc_ack),
	    .cpu_dat_o			(dc_ldat),
	    .spr_bus_dat_o		(spr_bus_dat_dc_o),
	    .spr_bus_ack_o		(spr_bus_ack_dc_o),
            .snoop_hit_o                (dc_snoop_hit),
	    // Inputs
	    .clk			(clk),
	    .rst			(dc_rst),
	    .dc_enable_i		(dc_enabled),
	    .dc_access_i		(dc_access),
	    .cpu_dat_i			(lsu_sdat),
	    .cpu_adr_i			(dc_adr),
	    .cpu_adr_match_i		(dc_adr_match),
	    .cpu_req_i			(dc_req),
	    .cpu_we_i			(dc_we),
	    .cpu_bsel_i			(dc_bsel),
	    .refill_allowed		(dc_refill_allowed),
	    .wradr_i			(dbus_adr),
	    .wrdat_i			(dbus_dat_i),
	    .we_i			(dbus_ack_i),
            .snoop_valid_i              (snoop_valid),
    );*/

   mor1kx_dcache
     #(
       .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH),
       .OPTION_DCACHE_BLOCK_WIDTH(OPTION_DCACHE_BLOCK_WIDTH),
       .OPTION_DCACHE_SET_WIDTH(OPTION_DCACHE_SET_WIDTH),
       .OPTION_DCACHE_WAYS(OPTION_DCACHE_WAYS),
       .OPTION_DCACHE_LIMIT_WIDTH(OPTION_DCACHE_LIMIT_WIDTH),
       .OPTION_DCACHE_SNOOP(OPTION_DCACHE_SNOOP)
       )
   mor1kx_dcache
	   (/*AUTOINST*/
	    // Outputs
	    .refill_o			(dc_refill),		 // Templated
	    .refill_req_o		(dc_refill_req),	 // Templated
	    .refill_done_o		(dc_refill_done),	 // Templated
	    .cpu_err_o			(dc_err),		 // Templated
	    .cpu_ack_o			(dc_ack),		 // Templated
	    .cpu_dat_o			(dc_ldat),		 // Templated
	    .snoop_hit_o		(dc_snoop_hit),		 // Templated
	    .spr_bus_dat_o		(spr_bus_dat_dc_o),	 // Templated
	    .spr_bus_ack_o		(spr_bus_ack_dc_o),	 // Templated
	    // Inputs
	    .clk			(clk),			 // Templated
	    .rst			(dc_rst),		 // Templated
	    .dc_enable_i		(dc_enabled),		 // Templated
	    .dc_access_i		(dc_access),		 // Templated
	    .cpu_dat_i			(lsu_sdat),		 // Templated
	    .cpu_adr_i			(dc_adr),		 // Templated
	    .cpu_adr_match_i		(dc_adr_match),		 // Templated
	    .cpu_req_i			(dc_req),		 // Templated
	    .cpu_we_i			(dc_we),		 // Templated
	    .cpu_bsel_i			(dc_bsel),		 // Templated
	    .refill_allowed		(dc_refill_allowed),	 // Templated
	    .wradr_i			(dbus_adr),		 // Templated
	    .wrdat_i			(dbus_dat_i),		 // Templated
	    .we_i			(dbus_ack_i),		 // Templated
	    .snoop_adr_i		(snoop_adr_i[31:0]),
	    .snoop_valid_i		(snoop_valid),		 // Templated
	    .spr_bus_addr_i		(spr_bus_addr_i[15:0]),
	    .spr_bus_we_i		(spr_bus_we_i),
	    .spr_bus_stb_i		(spr_bus_stb_i),
	    .spr_bus_dat_i		(spr_bus_dat_i[OPTION_OPERAND_WIDTH-1:0]));
end else begin
   assign dc_access = 0;
   assign dc_refill = 0;
   assign dc_refill_done = 0;
   assign dc_refill_req = 0;
   assign dc_err = 0;
   assign dc_ack = 0;
   assign dc_bsel = 0;
   assign dc_we = 0;
   assign dc_snoop_hit = 0;
end

endgenerate

generate
if (FEATURE_DMMU!="NONE") begin : dmmu_gen
   wire  [OPTION_OPERAND_WIDTH-1:0] virt_addr;
   wire 			    dmmu_spr_bus_stb;
   wire 			    dmmu_enable;

   assign virt_addr = dc_adr;

   // small hack to delay dmmu spr reads by one cycle
   // ideally the spr accesses should work so that the address is presented
   // in execute stage and the delayed data should be available in control
   // stage, but this is not how things currently work.
   assign dmmu_spr_bus_stb = spr_bus_stb_i & (!padv_ctrl_i | spr_bus_we_i);

   assign tlb_reload_pagefault_clear = !ctrl_op_lsu; // use pipeline_flush_i?

   assign dmmu_enable = dmmu_enable_i & !pipeline_flush_i;

   /* mor1kx_dmmu AUTO_TEMPLATE (
    .enable_i				(dmmu_enable),
    .phys_addr_o			(dmmu_phys_addr),
    .cache_inhibit_o			(dmmu_cache_inhibit),
    .op_store_i				(ctrl_op_lsu_store_i),
    .op_load_i				(ctrl_op_lsu_load_i),
    .tlb_miss_o				(tlb_miss),
    .pagefault_o			(pagefault),
    .tlb_reload_req_o			(tlb_reload_req),
    .tlb_reload_busy_o			(tlb_reload_busy),
    .tlb_reload_addr_o			(tlb_reload_addr),
    .tlb_reload_pagefault_o		(tlb_reload_pagefault),
    .tlb_reload_ack_i			(tlb_reload_ack),
    .tlb_reload_data_i			(tlb_reload_data),
    .tlb_reload_pagefault_clear_i	(tlb_reload_pagefault_clear),
    .spr_bus_dat_o			(spr_bus_dat_dmmu_o),
    .spr_bus_ack_o			(spr_bus_ack_dmmu_o),
    .spr_bus_stb_i			(dmmu_spr_bus_stb),
    .virt_addr_i			(virt_addr),
    .virt_addr_match_i			(ctrl_lsu_adr_i),
    ); */
   mor1kx_dmmu
     #(
       .FEATURE_DMMU_HW_TLB_RELOAD(FEATURE_DMMU_HW_TLB_RELOAD),
       .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH),
       .OPTION_DMMU_SET_WIDTH(OPTION_DMMU_SET_WIDTH),
       .OPTION_DMMU_WAYS(OPTION_DMMU_WAYS)
       )
   mor1kx_dmmu
     (/*AUTOINST*/
      // Outputs
      .phys_addr_o			(dmmu_phys_addr),	 // Templated
      .cache_inhibit_o			(dmmu_cache_inhibit),	 // Templated
      .tlb_miss_o			(tlb_miss),		 // Templated
      .pagefault_o			(pagefault),		 // Templated
      .tlb_reload_req_o			(tlb_reload_req),	 // Templated
      .tlb_reload_busy_o		(tlb_reload_busy),	 // Templated
      .tlb_reload_addr_o		(tlb_reload_addr),	 // Templated
      .tlb_reload_pagefault_o		(tlb_reload_pagefault),	 // Templated
      .spr_bus_dat_o			(spr_bus_dat_dmmu_o),	 // Templated
      .spr_bus_ack_o			(spr_bus_ack_dmmu_o),	 // Templated
      // Inputs
      .clk				(clk),
      .rst				(rst),
      .enable_i				(dmmu_enable),		 // Templated
      .virt_addr_i			(virt_addr),		 // Templated
      .virt_addr_match_i		(ctrl_lsu_adr_i),	 // Templated
      .op_store_i			(ctrl_op_lsu_store_i),	 // Templated
      .op_load_i			(ctrl_op_lsu_load_i),	 // Templated
      .supervisor_mode_i		(supervisor_mode_i),
      .tlb_reload_ack_i			(tlb_reload_ack),	 // Templated
      .tlb_reload_data_i		(tlb_reload_data),	 // Templated
      .tlb_reload_pagefault_clear_i	(tlb_reload_pagefault_clear), // Templated
      .spr_bus_addr_i			(spr_bus_addr_i[15:0]),
      .spr_bus_we_i			(spr_bus_we_i),
      .spr_bus_stb_i			(dmmu_spr_bus_stb),	 // Templated
      .spr_bus_dat_i			(spr_bus_dat_i[OPTION_OPERAND_WIDTH-1:0]));
end else begin
   assign dmmu_cache_inhibit = 0;
   assign tlb_miss = 0;
   assign pagefault = 0;
   assign tlb_reload_busy = 0;
   assign tlb_reload_req = 0;
   assign tlb_reload_pagefault = 0;
end
endgenerate

endmodule // mor1kx_lsu_cappuccino

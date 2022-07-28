/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: mor1kx processor top level

  Copyright (C) 2012 Authors

  Author(s): Julius Baxter <juliusbaxter@gmail.com>
             Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

***************************************************************************** */

//`include "mor1kx-defines.v"
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

module mor1kx
  #(
    parameter OPTION_OPERAND_WIDTH	= 32,

    parameter OPTION_CPU0		= "CAPPUCCINO",

    parameter FEATURE_DATACACHE		= "NONE",
    parameter OPTION_DCACHE_BLOCK_WIDTH	= 5,
    parameter OPTION_DCACHE_SET_WIDTH	= 9,
    parameter OPTION_DCACHE_WAYS	= 2,
    parameter OPTION_DCACHE_LIMIT_WIDTH	= 32,
    parameter OPTION_DCACHE_SNOOP = "NONE",
    parameter FEATURE_DMMU		= "NONE",
    parameter FEATURE_DMMU_HW_TLB_RELOAD = "NONE",
    parameter OPTION_DMMU_SET_WIDTH	= 6,
    parameter OPTION_DMMU_WAYS		= 1,
    parameter FEATURE_INSTRUCTIONCACHE	= "NONE",
    parameter OPTION_ICACHE_BLOCK_WIDTH	= 5,
    parameter OPTION_ICACHE_SET_WIDTH	= 9,
    parameter OPTION_ICACHE_WAYS	= 2,
    parameter OPTION_ICACHE_LIMIT_WIDTH	= 32,
    parameter FEATURE_IMMU		= "NONE",
    parameter FEATURE_IMMU_HW_TLB_RELOAD = "NONE",
    parameter OPTION_IMMU_SET_WIDTH	= 6,
    parameter OPTION_IMMU_WAYS		= 1,
    parameter FEATURE_TIMER		= "ENABLED",
    parameter FEATURE_DEBUGUNIT		= "NONE",
    parameter FEATURE_PERFCOUNTERS	= "NONE",
    parameter FEATURE_MAC		= "NONE",

    parameter FEATURE_SYSCALL		= "ENABLED",
    parameter FEATURE_TRAP		= "ENABLED",
    parameter FEATURE_RANGE		= "ENABLED",

    parameter FEATURE_PIC		= "ENABLED",
    parameter OPTION_PIC_TRIGGER	= "LEVEL",
    parameter OPTION_PIC_NMI_WIDTH	= 0,

    parameter FEATURE_DSX		= "ENABLED",
    parameter FEATURE_OVERFLOW		= "ENABLED",
    parameter FEATURE_CARRY_FLAG	= "ENABLED",

    parameter FEATURE_FASTCONTEXTS	= "NONE",
    parameter OPTION_RF_NUM_SHADOW_GPR	= 0,
    parameter OPTION_RF_ADDR_WIDTH	= 5,
    parameter OPTION_RF_WORDS		= 32,

    parameter OPTION_RESET_PC		= {{(OPTION_OPERAND_WIDTH-13){1'b0}},
					   `OR1K_RESET_VECTOR,8'd0},

    parameter FEATURE_MULTIPLIER	= "THREESTAGE",
    parameter FEATURE_DIVIDER		= "SERIAL",

    parameter FEATURE_ADDC		= "ENABLED",
    parameter FEATURE_SRA		= "ENABLED",
    parameter FEATURE_ROR		= "NONE",
    parameter FEATURE_EXT		= "NONE",
    parameter FEATURE_CMOV		= "ENABLED",
    parameter FEATURE_FFL1		= "ENABLED",
    parameter FEATURE_ATOMIC		= "ENABLED",

    parameter FEATURE_CUST1		= "NONE",
    parameter FEATURE_CUST2		= "NONE",
    parameter FEATURE_CUST3		= "NONE",
    parameter FEATURE_CUST4		= "NONE",
    parameter FEATURE_CUST5		= "NONE",
    parameter FEATURE_CUST6		= "NONE",
    parameter FEATURE_CUST7		= "NONE",
    parameter FEATURE_CUST8		= "NONE",

    parameter OPTION_SHIFTER		= "BARREL",

    parameter FEATURE_STORE_BUFFER	= "ENABLED",
    parameter OPTION_STORE_BUFFER_DEPTH_WIDTH = 8,

    parameter FEATURE_MULTICORE = "NONE",

    parameter FEATURE_TRACEPORT_EXEC = "NONE",

    parameter BUS_IF_TYPE		= "WISHBONE32",

    parameter IBUS_WB_TYPE		= "B3_READ_BURSTING",
    parameter DBUS_WB_TYPE		= "CLASSIC"
    )
   (
    input 			      clk,
    input 			      rst,

    // Wishbone interface
    output [31:0] 		      iwbm_adr_o,
    output 			      iwbm_stb_o,
    output 			      iwbm_cyc_o,
    output [3:0] 		      iwbm_sel_o,
    output 			      iwbm_we_o,
    output [2:0] 		      iwbm_cti_o,
    output [1:0] 		      iwbm_bte_o,
    output [31:0] 		      iwbm_dat_o,
    input 			      iwbm_err_i,
    input 			      iwbm_ack_i,
    input [31:0] 		      iwbm_dat_i,
    input 			      iwbm_rty_i,

    output [31:0] 		      dwbm_adr_o,
    output 			      dwbm_stb_o,
    output 			      dwbm_cyc_o,
    output [3:0] 		      dwbm_sel_o,
    output 			      dwbm_we_o,
    output [2:0] 		      dwbm_cti_o,
    output [1:0] 		      dwbm_bte_o,
    output [31:0] 		      dwbm_dat_o,
    input 			      dwbm_err_i,
    input 			      dwbm_ack_i,
    input [31:0] 		      dwbm_dat_i,
    input 			      dwbm_rty_i,

    // Avalon interface
    output [31:0] 		      avm_d_address_o,
    output [3:0] 		      avm_d_byteenable_o,
    output 			      avm_d_read_o,
    input [31:0] 		      avm_d_readdata_i,
    output [3:0] 		      avm_d_burstcount_o,
    output 			      avm_d_write_o,
    output [31:0] 		      avm_d_writedata_o,
    input 			      avm_d_waitrequest_i,
    input 			      avm_d_readdatavalid_i,

    output [31:0] 		      avm_i_address_o,
    output [3:0] 		      avm_i_byteenable_o,
    output 			      avm_i_read_o,
    input [31:0] 		      avm_i_readdata_i,
    output [3:0] 		      avm_i_burstcount_o,
    input 			      avm_i_waitrequest_i,
    input 			      avm_i_readdatavalid_i,

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

    output 			     traceport_exec_valid_o,
    output [31:0] 		     traceport_exec_pc_o,
    output [`OR1K_INSN_WIDTH-1:0]     traceport_exec_insn_o,
    output [OPTION_OPERAND_WIDTH-1:0] traceport_exec_wbdata_o,
    output [OPTION_RF_ADDR_WIDTH-1:0] traceport_exec_wbreg_o,
    output 			     traceport_exec_wben_o,

    // The multicore core identifier
    input [OPTION_OPERAND_WIDTH-1:0]  multicore_coreid_i,
    // The number of cores
    input [OPTION_OPERAND_WIDTH-1:0]  multicore_numcores_i,

    input [31:0] 		     snoop_adr_i,
    input 			     snoop_en_i
    );

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			avm_i_write_o;		// From ibus_bridge of mor1kx_bus_if_avalon.v
   wire			avm_i_writedata_o;	// From ibus_bridge of mor1kx_bus_if_avalon.v
   wire [OPTION_OPERAND_WIDTH-1:0] dbus_adr_o;	// From mor1kx_cpu of mor1kx_cpu.v
   wire [3:0]		dbus_bsel_o;		// From mor1kx_cpu of mor1kx_cpu.v
   wire			dbus_burst_o;		// From mor1kx_cpu of mor1kx_cpu.v
   wire [OPTION_OPERAND_WIDTH-1:0] dbus_dat_o;	// From mor1kx_cpu of mor1kx_cpu.v
   wire			dbus_req_o;		// From mor1kx_cpu of mor1kx_cpu.v
   wire			dbus_we_o;		// From mor1kx_cpu of mor1kx_cpu.v
   wire [OPTION_OPERAND_WIDTH-1:0] ibus_adr_o;	// From mor1kx_cpu of mor1kx_cpu.v
   wire			ibus_burst_o;		// From mor1kx_cpu of mor1kx_cpu.v
   wire			ibus_req_o;		// From mor1kx_cpu of mor1kx_cpu.v
   wire [15:0]		spr_bus_addr_o;		// From mor1kx_cpu of mor1kx_cpu.v
   wire [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_o;// From mor1kx_cpu of mor1kx_cpu.v
   wire			spr_bus_stb_o;		// From mor1kx_cpu of mor1kx_cpu.v
   wire			spr_bus_we_o;		// From mor1kx_cpu of mor1kx_cpu.v
   wire [15:0]		spr_sr_o;		// From mor1kx_cpu of mor1kx_cpu.v
   // End of automatics

   wire 			   ibus_ack_i;
   wire [OPTION_OPERAND_WIDTH-1:0] ibus_dat_i;
   wire 			   ibus_err_i;

   wire 			   dbus_ack_i;
   wire [OPTION_OPERAND_WIDTH-1:0] dbus_dat_i;
   wire 			   dbus_err_i;

   generate
      if (BUS_IF_TYPE=="WISHBONE32") begin : bus_gen

	 /* mor1kx_bus_if_wb32 AUTO_TEMPLATE (
	  .cpu_err_o			(ibus_err_i),
	  .cpu_ack_o			(ibus_ack_i),
	  .cpu_dat_o			(ibus_dat_i[`OR1K_INSN_WIDTH-1:0]),
	  .wbm_adr_o			(iwbm_adr_o),
	  .wbm_stb_o			(iwbm_stb_o),
	  .wbm_cyc_o			(iwbm_cyc_o),
	  .wbm_sel_o			(iwbm_sel_o),
	  .wbm_we_o			(iwbm_we_o),
	  .wbm_cti_o			(iwbm_cti_o),
	  .wbm_bte_o			(iwbm_bte_o),
	  .wbm_dat_o			(iwbm_dat_o),
	  // Inputs
	  .cpu_adr_i			(ibus_adr_o),
	  .cpu_dat_i			({OPTION_OPERAND_WIDTH{1'b0}}),
	  .cpu_req_i			(ibus_req_o),
	  .cpu_we_i			(1'b0),
	  .cpu_bsel_i			(4'b1111),
	  .cpu_burst_i			(ibus_burst_o),
	  .wbm_err_i			(iwbm_err_i),
	  .wbm_ack_i			(iwbm_ack_i),
	  .wbm_dat_i			(iwbm_dat_i),
	  .wbm_rty_i			(iwbm_rty_i),
	  ); */

	 mor1kx_bus_if_wb32
	   #(.BUS_IF_TYPE(IBUS_WB_TYPE),
	     .BURST_LENGTH((FEATURE_INSTRUCTIONCACHE != "NONE") ?
			   ((OPTION_ICACHE_BLOCK_WIDTH == 4) ? 4 :
			    ((OPTION_ICACHE_BLOCK_WIDTH == 5) ? 8 : 1))
			   : 1 ))
	 ibus_bridge
		      (/*AUTOINST*/
		       // Outputs
		       .cpu_err_o	(ibus_err_i),		 // Templated
		       .cpu_ack_o	(ibus_ack_i),		 // Templated
		       .cpu_dat_o	(ibus_dat_i[`OR1K_INSN_WIDTH-1:0]), // Templated
		       .wbm_adr_o	(iwbm_adr_o),		 // Templated
		       .wbm_stb_o	(iwbm_stb_o),		 // Templated
		       .wbm_cyc_o	(iwbm_cyc_o),		 // Templated
		       .wbm_sel_o	(iwbm_sel_o),		 // Templated
		       .wbm_we_o	(iwbm_we_o),		 // Templated
		       .wbm_cti_o	(iwbm_cti_o),		 // Templated
		       .wbm_bte_o	(iwbm_bte_o),		 // Templated
		       .wbm_dat_o	(iwbm_dat_o),		 // Templated
		       // Inputs
		       .clk		(clk),
		       .rst		(rst),
		       .cpu_adr_i	(ibus_adr_o),		 // Templated
		       .cpu_dat_i	({OPTION_OPERAND_WIDTH{1'b0}}), // Templated
		       .cpu_req_i	(ibus_req_o),		 // Templated
		       .cpu_bsel_i	(4'b1111),		 // Templated
		       .cpu_we_i	(1'b0),			 // Templated
		       .cpu_burst_i	(ibus_burst_o),		 // Templated
		       .wbm_err_i	(iwbm_err_i),		 // Templated
		       .wbm_ack_i	(iwbm_ack_i),		 // Templated
		       .wbm_dat_i	(iwbm_dat_i),		 // Templated
		       .wbm_rty_i	(iwbm_rty_i));		 // Templated

	 /* mor1kx_bus_if_wb32 AUTO_TEMPLATE (
	  .cpu_err_o			(dbus_err_i),
	  .cpu_ack_o			(dbus_ack_i),
	  .cpu_dat_o			(dbus_dat_i[OPTION_OPERAND_WIDTH-1:0]),
	  .wbm_adr_o			(dwbm_adr_o),
	  .wbm_stb_o			(dwbm_stb_o),
	  .wbm_cyc_o			(dwbm_cyc_o),
	  .wbm_sel_o			(dwbm_sel_o),
	  .wbm_we_o			(dwbm_we_o),
	  .wbm_cti_o			(dwbm_cti_o),
	  .wbm_bte_o			(dwbm_bte_o),
	  .wbm_dat_o			(dwbm_dat_o),
	  // Inputs
	  .cpu_adr_i			(dbus_adr_o[31:0]),
	  .cpu_dat_i			(dbus_dat_o),
	  .cpu_req_i			(dbus_req_o),
	  .cpu_we_i			(dbus_we_o),
	  .cpu_bsel_i			(dbus_bsel_o),
	  .cpu_burst_i			(dbus_burst_o),
	  .wbm_err_i			(dwbm_err_i),
	  .wbm_ack_i			(dwbm_ack_i),
	  .wbm_dat_i			(dwbm_dat_i),
	  .wbm_rty_i			(dwbm_rty_i),
	  ); */

	 mor1kx_bus_if_wb32
	   #(.BUS_IF_TYPE(DBUS_WB_TYPE),
	     .BURST_LENGTH((FEATURE_DATACACHE != "NONE") ?
			   ((OPTION_DCACHE_BLOCK_WIDTH == 4) ? 4 :
			    ((OPTION_DCACHE_BLOCK_WIDTH == 5) ? 8 : 1))
			   : 1 ))
	 dbus_bridge
	   (/*AUTOINST*/
	    // Outputs
	    .cpu_err_o			(dbus_err_i),		 // Templated
	    .cpu_ack_o			(dbus_ack_i),		 // Templated
	    .cpu_dat_o			(dbus_dat_i[OPTION_OPERAND_WIDTH-1:0]), // Templated
	    .wbm_adr_o			(dwbm_adr_o),		 // Templated
	    .wbm_stb_o			(dwbm_stb_o),		 // Templated
	    .wbm_cyc_o			(dwbm_cyc_o),		 // Templated
	    .wbm_sel_o			(dwbm_sel_o),		 // Templated
	    .wbm_we_o			(dwbm_we_o),		 // Templated
	    .wbm_cti_o			(dwbm_cti_o),		 // Templated
	    .wbm_bte_o			(dwbm_bte_o),		 // Templated
	    .wbm_dat_o			(dwbm_dat_o),		 // Templated
	    // Inputs
	    .clk			(clk),
	    .rst			(rst),
	    .cpu_adr_i			(dbus_adr_o[31:0]),	 // Templated
	    .cpu_dat_i			(dbus_dat_o),		 // Templated
	    .cpu_req_i			(dbus_req_o),		 // Templated
	    .cpu_bsel_i			(dbus_bsel_o),		 // Templated
	    .cpu_we_i			(dbus_we_o),		 // Templated
	    .cpu_burst_i		(dbus_burst_o),		 // Templated
	    .wbm_err_i			(dwbm_err_i),		 // Templated
	    .wbm_ack_i			(dwbm_ack_i),		 // Templated
	    .wbm_dat_i			(dwbm_dat_i),		 // Templated
	    .wbm_rty_i			(dwbm_rty_i));		 // Templated

      end else if (BUS_IF_TYPE=="AVALON") begin // block: bus_gen
	 /* mor1kx_bus_if_avalon AUTO_TEMPLATE (
	  .cpu_err_o			(ibus_err_i),
	  .cpu_ack_o			(ibus_ack_i),
	  .cpu_dat_o			(ibus_dat_i),
	  .avm_address_o		(avm_i_address_o),
	  .avm_byteenable_o		(avm_i_byteenable_o),
	  .avm_read_o			(avm_i_read_o),
	  .avm_burstcount_o		(avm_i_burstcount_o),
	  .avm_write_o			(avm_i_write_o),
	  .avm_writedata_o		(avm_i_writedata_o),
	  // Inputs
	  .cpu_adr_i			(ibus_adr_o),
	  .cpu_dat_i			({OPTION_OPERAND_WIDTH{1'b0}}),
	  .cpu_req_i			(ibus_req_o),
	  .cpu_we_i			(1'b0),
	  .cpu_bsel_i			(4'b1111),
	  .cpu_burst_i			(ibus_burst_o),
	  .avm_readdata_i		(avm_i_readdata_i),
	  .avm_waitrequest_i		(avm_i_waitrequest_i),
	  .avm_readdatavalid_i		(avm_i_readdatavalid_i),
	  ); */

	 mor1kx_bus_if_avalon
	   #(.OPTION_AVALON_BURST_LENGTH((1<<OPTION_ICACHE_BLOCK_WIDTH)/4))
	 ibus_bridge
	   (/*AUTOINST*/
	    // Outputs
	    .cpu_err_o			(ibus_err_i),		 // Templated
	    .cpu_ack_o			(ibus_ack_i),		 // Templated
	    .cpu_dat_o			(ibus_dat_i),		 // Templated
	    .avm_address_o		(avm_i_address_o),	 // Templated
	    .avm_byteenable_o		(avm_i_byteenable_o),	 // Templated
	    .avm_read_o			(avm_i_read_o),		 // Templated
	    .avm_burstcount_o		(avm_i_burstcount_o),	 // Templated
	    .avm_write_o		(avm_i_write_o),	 // Templated
	    .avm_writedata_o		(avm_i_writedata_o),	 // Templated
	    // Inputs
	    .clk			(clk),
	    .rst			(rst),
	    .cpu_adr_i			(ibus_adr_o),		 // Templated
	    .cpu_dat_i			({OPTION_OPERAND_WIDTH{1'b0}}), // Templated
	    .cpu_req_i			(ibus_req_o),		 // Templated
	    .cpu_bsel_i			(4'b1111),		 // Templated
	    .cpu_we_i			(1'b0),			 // Templated
	    .cpu_burst_i		(ibus_burst_o),		 // Templated
	    .avm_readdata_i		(avm_i_readdata_i),	 // Templated
	    .avm_waitrequest_i		(avm_i_waitrequest_i),	 // Templated
	    .avm_readdatavalid_i	(avm_i_readdatavalid_i)); // Templated

	 /* mor1kx_bus_if_avalon AUTO_TEMPLATE (
	  .cpu_err_o			(dbus_err_i),
	  .cpu_ack_o			(dbus_ack_i),
	  .cpu_dat_o			(dbus_dat_i),
	  .avm_address_o		(avm_d_address_o),
	  .avm_byteenable_o		(avm_d_byteenable_o),
	  .avm_read_o			(avm_d_read_o),
	  .avm_burstcount_o		(avm_d_burstcount_o),
	  .avm_write_o			(avm_d_write_o),
	  .avm_writedata_o		(avm_d_writedata_o),
	  // Inputs
	  .cpu_adr_i			(dbus_adr_o),
	  .cpu_dat_i			(dbus_dat_o),
	  .cpu_req_i			(dbus_req_o),
	  .cpu_we_i			(dbus_we_o),
	  .cpu_bsel_i			(dbus_bsel_o),
	  .cpu_burst_i			(dbus_burst_o),
	  .avm_readdata_i		(avm_d_readdata_i),
	  .avm_waitrequest_i		(avm_d_waitrequest_i),
	  .avm_readdatavalid_i		(avm_d_readdatavalid_i),
	  ); */

	 mor1kx_bus_if_avalon
	   #(.OPTION_AVALON_BURST_LENGTH((1<<OPTION_DCACHE_BLOCK_WIDTH)/4))
	 dbus_bridge
	   (/*AUTOINST*/
	    // Outputs
	    .cpu_err_o			(dbus_err_i),		 // Templated
	    .cpu_ack_o			(dbus_ack_i),		 // Templated
	    .cpu_dat_o			(dbus_dat_i),		 // Templated
	    .avm_address_o		(avm_d_address_o),	 // Templated
	    .avm_byteenable_o		(avm_d_byteenable_o),	 // Templated
	    .avm_read_o			(avm_d_read_o),		 // Templated
	    .avm_burstcount_o		(avm_d_burstcount_o),	 // Templated
	    .avm_write_o		(avm_d_write_o),	 // Templated
	    .avm_writedata_o		(avm_d_writedata_o),	 // Templated
	    // Inputs
	    .clk			(clk),
	    .rst			(rst),
	    .cpu_adr_i			(dbus_adr_o),		 // Templated
	    .cpu_dat_i			(dbus_dat_o),		 // Templated
	    .cpu_req_i			(dbus_req_o),		 // Templated
	    .cpu_bsel_i			(dbus_bsel_o),		 // Templated
	    .cpu_we_i			(dbus_we_o),		 // Templated
	    .cpu_burst_i		(dbus_burst_o),		 // Templated
	    .avm_readdata_i		(avm_d_readdata_i),	 // Templated
	    .avm_waitrequest_i		(avm_d_waitrequest_i),	 // Templated
	    .avm_readdatavalid_i	(avm_d_readdatavalid_i)); // Templated

      end else begin
	   initial begin
	      $display("Error: BUS_IF_TYPE not correct");
	      $finish();
	   end
	end // else: !if(BUS_IF_TYPE=="WISHBONE32")
   endgenerate

   /* mor1kx_cpu AUTO_TEMPLATE
    (
    .spr_bus_dat_dmmu_i		(),
    .spr_bus_ack_dmmu_i		(),
    .spr_bus_dat_immu_i		(),
    .spr_bus_ack_immu_i		(),
    .spr_bus_dat_mac_i		(),
    .spr_bus_ack_mac_i		(),
    .spr_bus_dat_pmu_i		(),
    .spr_bus_ack_pmu_i		(),
    .spr_bus_dat_pcu_i		(),
    .spr_bus_ack_pcu_i		(),
    .spr_bus_dat_fpu_i		(),
    .spr_bus_ack_fpu_i		(),
    ); */
   mor1kx_cpu
     	   #(
	     .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH),
	     .OPTION_CPU(OPTION_CPU0),
	     .FEATURE_DATACACHE(FEATURE_DATACACHE),
	     .OPTION_DCACHE_BLOCK_WIDTH(OPTION_DCACHE_BLOCK_WIDTH),
	     .OPTION_DCACHE_SET_WIDTH(OPTION_DCACHE_SET_WIDTH),
	     .OPTION_DCACHE_WAYS(OPTION_DCACHE_WAYS),
	     .OPTION_DCACHE_LIMIT_WIDTH(OPTION_DCACHE_LIMIT_WIDTH),
             .OPTION_DCACHE_SNOOP(OPTION_DCACHE_SNOOP),
	     .FEATURE_DMMU(FEATURE_DMMU),
	     .FEATURE_DMMU_HW_TLB_RELOAD(FEATURE_DMMU_HW_TLB_RELOAD),
	     .OPTION_DMMU_SET_WIDTH(OPTION_DMMU_SET_WIDTH),
	     .OPTION_DMMU_WAYS(OPTION_DMMU_WAYS),
	     .FEATURE_INSTRUCTIONCACHE(FEATURE_INSTRUCTIONCACHE),
	     .OPTION_ICACHE_BLOCK_WIDTH(OPTION_ICACHE_BLOCK_WIDTH),
	     .OPTION_ICACHE_SET_WIDTH(OPTION_ICACHE_SET_WIDTH),
	     .OPTION_ICACHE_WAYS(OPTION_ICACHE_WAYS),
	     .OPTION_ICACHE_LIMIT_WIDTH(OPTION_ICACHE_LIMIT_WIDTH),
	     .FEATURE_IMMU(FEATURE_IMMU),
	     .FEATURE_IMMU_HW_TLB_RELOAD(FEATURE_IMMU_HW_TLB_RELOAD),
	     .OPTION_IMMU_SET_WIDTH(OPTION_IMMU_SET_WIDTH),
	     .OPTION_IMMU_WAYS(OPTION_IMMU_WAYS),
	     .FEATURE_PIC(FEATURE_PIC),
	     .FEATURE_TIMER(FEATURE_TIMER),
	     .FEATURE_DEBUGUNIT(FEATURE_DEBUGUNIT),
	     .FEATURE_PERFCOUNTERS(FEATURE_PERFCOUNTERS),
	     .FEATURE_MAC(FEATURE_MAC),
	     .FEATURE_SYSCALL(FEATURE_SYSCALL),
	     .FEATURE_TRAP(FEATURE_TRAP),
	     .FEATURE_RANGE(FEATURE_RANGE),
	     .OPTION_PIC_TRIGGER(OPTION_PIC_TRIGGER),
	     .OPTION_PIC_NMI_WIDTH(OPTION_PIC_NMI_WIDTH),
	     .FEATURE_DSX(FEATURE_DSX),
	     .FEATURE_OVERFLOW(FEATURE_OVERFLOW),
	     .FEATURE_CARRY_FLAG(FEATURE_CARRY_FLAG),
	     .FEATURE_FASTCONTEXTS(FEATURE_FASTCONTEXTS),
	     .OPTION_RF_NUM_SHADOW_GPR(OPTION_RF_NUM_SHADOW_GPR),
	     .OPTION_RF_ADDR_WIDTH(OPTION_RF_ADDR_WIDTH),
	     .OPTION_RF_WORDS(OPTION_RF_WORDS),
	     .OPTION_RESET_PC(OPTION_RESET_PC),
	     .FEATURE_MULTIPLIER(FEATURE_MULTIPLIER),
	     .FEATURE_DIVIDER(FEATURE_DIVIDER),
	     .FEATURE_ADDC(FEATURE_ADDC),
	     .FEATURE_SRA(FEATURE_SRA),
	     .FEATURE_ROR(FEATURE_ROR),
	     .FEATURE_EXT(FEATURE_EXT),
	     .FEATURE_CMOV(FEATURE_CMOV),
	     .FEATURE_FFL1(FEATURE_FFL1),
	     .FEATURE_ATOMIC(FEATURE_ATOMIC),
	     .FEATURE_CUST1(FEATURE_CUST1),
	     .FEATURE_CUST2(FEATURE_CUST2),
	     .FEATURE_CUST3(FEATURE_CUST3),
	     .FEATURE_CUST4(FEATURE_CUST4),
	     .FEATURE_CUST5(FEATURE_CUST5),
	     .FEATURE_CUST6(FEATURE_CUST6),
	     .FEATURE_CUST7(FEATURE_CUST7),
	     .FEATURE_CUST8(FEATURE_CUST8),
	     .OPTION_SHIFTER(OPTION_SHIFTER),
	     .FEATURE_STORE_BUFFER(FEATURE_STORE_BUFFER),
	     .OPTION_STORE_BUFFER_DEPTH_WIDTH(OPTION_STORE_BUFFER_DEPTH_WIDTH),
	     .FEATURE_MULTICORE(FEATURE_MULTICORE),
	     .FEATURE_TRACEPORT_EXEC(FEATURE_TRACEPORT_EXEC)
	     )
   mor1kx_cpu
     (/*AUTOINST*/
      // Outputs
      .ibus_adr_o			(ibus_adr_o[OPTION_OPERAND_WIDTH-1:0]),
      .ibus_req_o			(ibus_req_o),
      .ibus_burst_o			(ibus_burst_o),
      .dbus_adr_o			(dbus_adr_o[OPTION_OPERAND_WIDTH-1:0]),
      .dbus_dat_o			(dbus_dat_o[OPTION_OPERAND_WIDTH-1:0]),
      .dbus_req_o			(dbus_req_o),
      .dbus_bsel_o			(dbus_bsel_o[3:0]),
      .dbus_we_o			(dbus_we_o),
      .dbus_burst_o			(dbus_burst_o),
      .du_dat_o				(du_dat_o[OPTION_OPERAND_WIDTH-1:0]),
      .du_ack_o				(du_ack_o),
      .du_stall_o			(du_stall_o),
      .traceport_exec_valid_o		(traceport_exec_valid_o),
      .traceport_exec_pc_o		(traceport_exec_pc_o[31:0]),
      .traceport_exec_insn_o		(traceport_exec_insn_o[`OR1K_INSN_WIDTH-1:0]),
      .traceport_exec_wbdata_o		(traceport_exec_wbdata_o[OPTION_OPERAND_WIDTH-1:0]),
      .traceport_exec_wbreg_o		(traceport_exec_wbreg_o[OPTION_RF_ADDR_WIDTH-1:0]),
      .traceport_exec_wben_o		(traceport_exec_wben_o),
      .spr_bus_addr_o			(spr_bus_addr_o[15:0]),
      .spr_bus_we_o			(spr_bus_we_o),
      .spr_bus_stb_o			(spr_bus_stb_o),
      .spr_bus_dat_o			(spr_bus_dat_o[OPTION_OPERAND_WIDTH-1:0]),
      .spr_sr_o				(spr_sr_o[15:0]),
      // Inputs
      .clk				(clk),
      .rst				(rst),
      .ibus_err_i			(ibus_err_i),
      .ibus_ack_i			(ibus_ack_i),
      .ibus_dat_i			(ibus_dat_i[`OR1K_INSN_WIDTH-1:0]),
      .dbus_err_i			(dbus_err_i),
      .dbus_ack_i			(dbus_ack_i),
      .dbus_dat_i			(dbus_dat_i[OPTION_OPERAND_WIDTH-1:0]),
      .irq_i				(irq_i[31:0]),
      .du_addr_i			(du_addr_i[15:0]),
      .du_stb_i				(du_stb_i),
      .du_dat_i				(du_dat_i[OPTION_OPERAND_WIDTH-1:0]),
      .du_we_i				(du_we_i),
      .du_stall_i			(du_stall_i),
      .spr_bus_dat_dmmu_i		(),			 // Templated
      .spr_bus_ack_dmmu_i		(),			 // Templated
      .spr_bus_dat_immu_i		(),			 // Templated
      .spr_bus_ack_immu_i		(),			 // Templated
      .spr_bus_dat_mac_i		(),			 // Templated
      .spr_bus_ack_mac_i		(),			 // Templated
      .spr_bus_dat_pmu_i		(),			 // Templated
      .spr_bus_ack_pmu_i		(),			 // Templated
      .spr_bus_dat_pcu_i		(),			 // Templated
      .spr_bus_ack_pcu_i		(),			 // Templated
      .spr_bus_dat_fpu_i		(),			 // Templated
      .spr_bus_ack_fpu_i		(),			 // Templated
      .multicore_coreid_i		(multicore_coreid_i[OPTION_OPERAND_WIDTH-1:0]),
      .multicore_numcores_i		(multicore_numcores_i[OPTION_OPERAND_WIDTH-1:0]),
      .snoop_adr_i			(snoop_adr_i[31:0]),
      .snoop_en_i			(snoop_en_i));

endmodule // mor1kx

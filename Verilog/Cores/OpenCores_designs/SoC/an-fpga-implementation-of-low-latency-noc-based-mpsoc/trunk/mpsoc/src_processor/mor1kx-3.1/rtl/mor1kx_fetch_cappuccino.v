/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: mor1kx fetch/address stage unit

  basically an interface to the ibus/icache subsystem that can react to
  exception and branch signals.

  Copyright (C) 2012 Authors

  Author(s): Julius Baxter <juliusbaxter@gmail.com>
             Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

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


module mor1kx_fetch_cappuccino
  #(
    parameter OPTION_OPERAND_WIDTH = 32,
    parameter OPTION_RESET_PC = {{(OPTION_OPERAND_WIDTH-13){1'b0}},
				 `OR1K_RESET_VECTOR,8'd0},
    parameter OPTION_RF_ADDR_WIDTH = 5,
    parameter FEATURE_INSTRUCTIONCACHE = "NONE",
    parameter OPTION_ICACHE_BLOCK_WIDTH = 5,
    parameter OPTION_ICACHE_SET_WIDTH = 9,
    parameter OPTION_ICACHE_WAYS = 2,
    parameter OPTION_ICACHE_LIMIT_WIDTH = 32,
    parameter FEATURE_IMMU = "NONE",
    parameter FEATURE_IMMU_HW_TLB_RELOAD = "NONE",
    parameter OPTION_IMMU_SET_WIDTH = 6,
    parameter OPTION_IMMU_WAYS = 1
    )
   (
    input 				  clk,
    input 				  rst,

    // SPR interface
    input [15:0] 			  spr_bus_addr_i,
    input 				  spr_bus_we_i,
    input 				  spr_bus_stb_i,
    input [OPTION_OPERAND_WIDTH-1:0] 	  spr_bus_dat_i,
    output [OPTION_OPERAND_WIDTH-1:0] 	  spr_bus_dat_ic_o,
    output 				  spr_bus_ack_ic_o,
    output [OPTION_OPERAND_WIDTH-1:0] 	  spr_bus_dat_immu_o,
    output 				  spr_bus_ack_immu_o,

    input 				  ic_enable,
    input 				  immu_enable_i,
    input 				  supervisor_mode_i,

    // interface to ibus
    input 				  ibus_err_i,
    input 				  ibus_ack_i,
    input [`OR1K_INSN_WIDTH-1:0] 	  ibus_dat_i,
    output 				  ibus_req_o,
    output [OPTION_OPERAND_WIDTH-1:0] 	  ibus_adr_o,
    output 				  ibus_burst_o,

    // pipeline control input
    input 				  padv_i,
    input 				  padv_ctrl_i, // needed for immu spr

    // interface to decode unit
    output reg [OPTION_OPERAND_WIDTH-1:0] pc_decode_o,
    output reg [`OR1K_INSN_WIDTH-1:0] 	  decode_insn_o,
    output reg 				  fetch_valid_o,
    output [OPTION_RF_ADDR_WIDTH-1:0] 	  fetch_rfa_adr_o,
    output [OPTION_RF_ADDR_WIDTH-1:0] 	  fetch_rfb_adr_o,
    output 				  fetch_rf_adr_valid_o,

    // branch/jump indication
    input 				  decode_branch_i,
    input [OPTION_OPERAND_WIDTH-1:0] 	  decode_branch_target_i,
    input 				  ctrl_branch_exception_i,
    input [OPTION_OPERAND_WIDTH-1:0] 	  ctrl_branch_except_pc_i,
    input 				  du_restart_i,
    input [OPTION_OPERAND_WIDTH-1:0] 	  du_restart_pc_i,
    input 				  decode_op_brcond_i,
    input 				  branch_mispredict_i,
    input [OPTION_OPERAND_WIDTH-1:0] 	  execute_mispredict_target_i,

    // pipeline flush input from control unit
    input 				  pipeline_flush_i,

    // rfe instruction is being performed
    input 				  doing_rfe_i,

    // instruction ibus error indication out
    output reg 				  decode_except_ibus_err_o,

    // IMMU exceptions
    output reg 				  decode_except_itlb_miss_o,
    output reg 				  decode_except_ipagefault_o,

    output reg 				  fetch_exception_taken_o
   );

   // registers
   reg [OPTION_OPERAND_WIDTH-1:0] 	  pc_fetch;
   reg [OPTION_OPERAND_WIDTH-1:0] 	  pc_addr;
   reg 					  ctrl_branch_exception_r;

   wire 				  bus_access_done;
   wire 				  ctrl_branch_exception_edge;
   wire					  stall_fetch_valid;
   wire 				  addr_valid;
   reg 					  flush;
   wire					  flushing;

   reg 					  nop_ack;

   reg 					  imem_err;
   wire 				  imem_ack;
   wire [`OR1K_INSN_WIDTH-1:0] 		  imem_dat;

   wire 				  ic_ack;
   wire [`OR1K_INSN_WIDTH-1:0] 		  ic_dat;

   wire 				  ic_req;
   wire 				  ic_refill_allowed;
   wire 				  ic_refill;
   wire 				  ic_refill_req;
   wire 				  ic_refill_done;
   wire 				  ic_invalidate;
   wire [OPTION_OPERAND_WIDTH-1:0] 	  ic_addr;
   wire [OPTION_OPERAND_WIDTH-1:0] 	  ic_addr_match;

   wire 				  ic_access;

   reg 					  ic_enable_r;
   wire 				  ic_enabled;

   wire [OPTION_OPERAND_WIDTH-1:0] 	  immu_phys_addr;
   wire 				  immu_cache_inhibit;
   wire 				  pagefault;
   wire 				  tlb_miss;
   wire 				  except_itlb_miss;
   wire 				  except_ipagefault;

   wire 				  immu_busy;

   wire 				  tlb_reload_req;
   reg 					  tlb_reload_ack;
   wire [OPTION_OPERAND_WIDTH-1:0] 	  tlb_reload_addr;
   reg [OPTION_OPERAND_WIDTH-1:0] 	  tlb_reload_data;
   wire 				  tlb_reload_pagefault;
   wire 				  tlb_reload_busy;

   reg 					  fetching_brcond;
   reg 					  fetching_mispredicted_branch;
   wire 				  mispredict_stall;

   reg 					  exception_while_tlb_reload;
   wire 				  except_ipagefault_clear;

   assign bus_access_done = (imem_ack | imem_err | nop_ack) & !immu_busy &
			    !tlb_reload_busy;
   assign ctrl_branch_exception_edge = ctrl_branch_exception_i &
				       !ctrl_branch_exception_r;

   /* used to keep fetch_valid_o high during stall */
   assign stall_fetch_valid = !padv_i & fetch_valid_o;

   assign addr_valid = bus_access_done & padv_i &
		       !(except_itlb_miss | except_ipagefault) |
		       decode_except_itlb_miss_o & ctrl_branch_exception_i |
		       decode_except_ipagefault_o & ctrl_branch_exception_i |
		       doing_rfe_i;

   assign except_itlb_miss = tlb_miss & immu_enable_i & bus_access_done &
			     !mispredict_stall & !doing_rfe_i;
   assign except_ipagefault = pagefault & immu_enable_i & bus_access_done &
			      !mispredict_stall & !doing_rfe_i |
			      tlb_reload_pagefault;

   assign fetch_rfa_adr_o = imem_dat[`OR1K_RA_SELECT];
   assign fetch_rfb_adr_o = imem_dat[`OR1K_RB_SELECT];
   assign fetch_rf_adr_valid_o = bus_access_done & padv_i;

   // Signal to indicate that the ongoing bus access should be flushed
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       flush <= 0;
     else if (bus_access_done & padv_i | du_restart_i)
       flush <= 0;
     else if (pipeline_flush_i)
       flush <= 1;

   // pipeline_flush_i comes on the same edge as branch_except_occur during
   // rfe, but on an edge later when an exception occurs, but we always need
   // to keep on flushing when the branch signal comes in.
   assign flushing = pipeline_flush_i | ctrl_branch_exception_edge | flush;

   // Branch misprediction stall logic
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       fetching_brcond <= 0;
     else if (pipeline_flush_i)
       fetching_brcond <= 0;
     else if (decode_op_brcond_i & addr_valid)
       fetching_brcond <= 1;
     else if (bus_access_done & padv_i | du_restart_i)
       fetching_brcond <= 0;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       fetching_mispredicted_branch <= 0;
     else if (pipeline_flush_i)
       fetching_mispredicted_branch <= 0;
     else if (bus_access_done & padv_i | du_restart_i)
       fetching_mispredicted_branch <= 0;
     else if (fetching_brcond & branch_mispredict_i & padv_i)
       fetching_mispredicted_branch <= 1;

   assign mispredict_stall = fetching_mispredicted_branch |
			     branch_mispredict_i & fetching_brcond;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       ctrl_branch_exception_r <= 1'b0;
     else
       ctrl_branch_exception_r <= ctrl_branch_exception_i;

   // calculate address stage pc
   always @(*)
      if (rst)
	pc_addr = OPTION_RESET_PC;
      else if (du_restart_i)
	pc_addr = du_restart_pc_i;
      else if (ctrl_branch_exception_i & !fetch_exception_taken_o)
	pc_addr = ctrl_branch_except_pc_i;
      else if (branch_mispredict_i | fetching_mispredicted_branch)
	pc_addr = execute_mispredict_target_i;
      else if (decode_branch_i)
	pc_addr = decode_branch_target_i;
      else
	pc_addr = pc_fetch + 4;

   // Register fetch pc from address stage
   always @(posedge clk `OR_ASYNC_RST)
      if (rst)
	pc_fetch <= OPTION_RESET_PC;
      else if (addr_valid | du_restart_i)
	pc_fetch <= pc_addr;

   // fetch_exception_taken_o generation
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       fetch_exception_taken_o <= 1'b0;
     else if (fetch_exception_taken_o)
       fetch_exception_taken_o <= 1'b0;
     else if (ctrl_branch_exception_i & bus_access_done & padv_i)
       fetch_exception_taken_o <= 1'b1;
     else
       fetch_exception_taken_o <= 1'b0;

   // fetch_valid_o generation
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       fetch_valid_o <= 1'b0;
     else if (pipeline_flush_i)
       fetch_valid_o <= 1'b0;
     else if (bus_access_done & padv_i & !mispredict_stall & !immu_busy &
	      !tlb_reload_busy | stall_fetch_valid)
       fetch_valid_o <= 1'b1;
     else
       fetch_valid_o <= 1'b0;

   // Register instruction coming in
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       decode_insn_o <= {`OR1K_OPCODE_NOP,26'd0};
     else if (imem_err | flushing)
       decode_insn_o <= {`OR1K_OPCODE_NOP,26'd0};
     else if (bus_access_done & padv_i & !mispredict_stall)
       decode_insn_o <= imem_dat;

   // Register PC for later stages
   always @(posedge clk)
     if (bus_access_done & padv_i & !mispredict_stall)
       pc_decode_o <= pc_fetch;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       decode_except_ibus_err_o <= 0;
     else if (du_restart_i)
       decode_except_ibus_err_o <= 0;
     else if (imem_err)
       decode_except_ibus_err_o <= 1;
     else if (decode_except_ibus_err_o & ctrl_branch_exception_i)
       decode_except_ibus_err_o <= 0;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       decode_except_itlb_miss_o <= 0;
     else if (du_restart_i)
       decode_except_itlb_miss_o <= 0;
     else if (tlb_reload_busy)
       decode_except_itlb_miss_o <= 0;
     else if (except_itlb_miss)
       decode_except_itlb_miss_o <= 1;
     else if (decode_except_itlb_miss_o & ctrl_branch_exception_i)
       decode_except_itlb_miss_o <= 0;

   assign except_ipagefault_clear = decode_except_ipagefault_o &
				    ctrl_branch_exception_i;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       decode_except_ipagefault_o <= 0;
     else if (du_restart_i)
       decode_except_ipagefault_o <= 0;
     else if (except_ipagefault)
       decode_except_ipagefault_o <= 1;
     else if (except_ipagefault_clear)
       decode_except_ipagefault_o <= 0;

   // Bus access logic
   localparam [2:0]
     IDLE		= 0,
     READ		= 1,
     TLB_RELOAD		= 2,
     IC_REFILL		= 3;

   reg [2:0] state;

   reg [OPTION_OPERAND_WIDTH-1:0] ibus_adr;
   wire [OPTION_OPERAND_WIDTH-1:0] next_ibus_adr;
   reg [`OR1K_INSN_WIDTH-1:0] 	  ibus_dat;
   reg 				  ibus_req;
   reg 				  ibus_ack;

   wire 			  ibus_access;

   //
   // Under certain circumstances, there is a need to insert an nop
   // into the pipeline in order for it to move forward.
   // Here those conditions are handled and an acknowledged signal
   // is generated.
   //
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       nop_ack <= 0;
     else
       nop_ack <= padv_i & !bus_access_done & !(ibus_req & ibus_access) &
		  ((immu_enable_i & (tlb_miss | pagefault) &
		    !tlb_reload_busy) |
		   ctrl_branch_exception_edge & !tlb_reload_busy |
		   exception_while_tlb_reload & !tlb_reload_busy |
		   tlb_reload_pagefault |
		   mispredict_stall);

   assign ibus_access = (!ic_access | tlb_reload_busy | ic_invalidate) &
			!ic_refill |
			(state != IDLE) & (state != IC_REFILL) |
			ibus_ack;
   assign imem_ack = ibus_access ? ibus_ack : ic_ack;
   assign imem_dat = (nop_ack | except_itlb_miss | except_ipagefault) ?
		     {`OR1K_OPCODE_NOP,26'd0} :
		     ibus_access ? ibus_dat : ic_dat;
   assign ibus_adr_o = ibus_adr;
   assign ibus_req_o = ibus_req;
   assign ibus_burst_o = !ibus_access & ic_refill & !ic_refill_done;

   assign next_ibus_adr = (OPTION_ICACHE_BLOCK_WIDTH == 5) ?
			  {ibus_adr[31:5], ibus_adr[4:0] + 5'd4} : // 32 byte
			  {ibus_adr[31:4], ibus_adr[3:0] + 4'd4};  // 16 byte

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       imem_err <= 0;
     else
       imem_err <= ibus_err_i;

   always @(posedge clk) begin
      ibus_ack <= 0;
      exception_while_tlb_reload <= 0;
      tlb_reload_ack <= 0;

      case (state)
	IDLE: begin
	   ibus_req <= 0;
	   if (padv_i & ibus_access & !ibus_ack & !imem_err & !nop_ack) begin
	      if (tlb_reload_req) begin
		 ibus_adr <= tlb_reload_addr;
		 ibus_req <= 1;
		 state <= TLB_RELOAD;
	      end else if (immu_enable_i) begin
		 ibus_adr <= immu_phys_addr;
		 if (!tlb_miss & !pagefault & !immu_busy) begin
		    ibus_req <= 1;
		    state <= READ;
		 end
	      end else if (!ctrl_branch_exception_i | doing_rfe_i) begin
		 ibus_adr <= pc_fetch;
		 ibus_req <= 1;
		 state <= READ;
	      end
	   end else if (ic_refill_req) begin
	      ibus_adr <= ic_addr_match;
	      ibus_req <= 1;
	      state <= IC_REFILL;
	   end
	end

	IC_REFILL: begin
	   ibus_req <= 1;
	   if (ibus_ack_i) begin
	      ibus_adr <= next_ibus_adr;
	      if (ic_refill_done) begin
		 ibus_req <= 0;
		 state <= IDLE;
	      end
	   end
	end

	READ: begin
	   ibus_ack <= ibus_ack_i;
	   ibus_dat <= ibus_dat_i;
	   if (ibus_ack_i | ibus_err_i) begin
	      ibus_req <= 0;
	      state <= IDLE;
	   end
	end

	TLB_RELOAD: begin
	   if (ctrl_branch_exception_i)
	     exception_while_tlb_reload <= 1;

	   ibus_adr <= tlb_reload_addr;
	   tlb_reload_data <= ibus_dat_i;
	   tlb_reload_ack <= ibus_ack_i & tlb_reload_req;

	   if (!tlb_reload_req)
	     state <= IDLE;

	   ibus_req <= tlb_reload_req;
	   if (ibus_ack_i | tlb_reload_ack)
	     ibus_req <= 0;
	end

	default:
	  state <= IDLE;
      endcase // case (state)

      if (rst) begin
	 ibus_req <= 0;
	 state <= IDLE;
      end
   end

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       ic_enable_r <= 0;
     else if (ic_enable & !ibus_req)
       ic_enable_r <= 1;
     else if (!ic_enable & !ic_refill)
       ic_enable_r <= 0;

   assign ic_enabled = ic_enable & ic_enable_r;
   assign ic_addr = (addr_valid | du_restart_i) ? pc_addr : pc_fetch;
   assign ic_addr_match = immu_enable_i ? immu_phys_addr : pc_fetch;
   assign ic_refill_allowed = (!((tlb_miss | pagefault) & immu_enable_i) &
			      !ctrl_branch_exception_i & !pipeline_flush_i &
			      !mispredict_stall | doing_rfe_i) &
			      !tlb_reload_busy & !immu_busy;

   assign ic_req = padv_i & !decode_except_ibus_err_o &
		   !decode_except_itlb_miss_o & !except_itlb_miss &
		   !decode_except_ipagefault_o & !except_ipagefault &
		   ic_access & ic_refill_allowed;

generate
if (FEATURE_INSTRUCTIONCACHE!="NONE") begin : icache_gen
   if (OPTION_ICACHE_LIMIT_WIDTH == OPTION_OPERAND_WIDTH) begin
      assign ic_access = ic_enabled &
			 !(immu_cache_inhibit & immu_enable_i);
   end else if (OPTION_ICACHE_LIMIT_WIDTH < OPTION_OPERAND_WIDTH) begin
      assign ic_access = ic_enabled &
			 ic_addr_match[OPTION_OPERAND_WIDTH-1:
				       OPTION_ICACHE_LIMIT_WIDTH] == 0 &
			 !(immu_cache_inhibit & immu_enable_i);
   end else begin
      initial begin
	 $display("ERROR: OPTION_ICACHE_LIMIT_WIDTH > OPTION_OPERAND_WIDTH");
	 $finish();
      end
   end

   wire ic_rst = rst | imem_err;

   /* mor1kx_icache AUTO_TEMPLATE (
    // Outputs
    .cpu_ack_o			(ic_ack),
    .cpu_dat_o			(ic_dat[OPTION_OPERAND_WIDTH-1:0]),
    .spr_bus_dat_o		(spr_bus_dat_ic_o),
    .spr_bus_ack_o		(spr_bus_ack_ic_o),
    .refill_o			(ic_refill),
    .refill_req_o		(ic_refill_req),
    .refill_done_o		(ic_refill_done),
    .invalidate_o		(ic_invalidate),
    // Inputs
    .rst			(ic_rst),
    .ic_access_i		(ic_access),
    .cpu_adr_i			(ic_addr),
    .cpu_adr_match_i		(ic_addr_match),
    .cpu_req_i			(ic_req),
    .wradr_i			(ibus_adr),
    .wrdat_i			(ibus_dat_i),
    .we_i			(ibus_ack_i),
    );*/

   mor1kx_icache
     #(
       .OPTION_ICACHE_BLOCK_WIDTH(OPTION_ICACHE_BLOCK_WIDTH),
       .OPTION_ICACHE_SET_WIDTH(OPTION_ICACHE_SET_WIDTH),
       .OPTION_ICACHE_WAYS(OPTION_ICACHE_WAYS),
       .OPTION_ICACHE_LIMIT_WIDTH(OPTION_ICACHE_LIMIT_WIDTH)
       )
   mor1kx_icache
     (/*AUTOINST*/
      // Outputs
      .refill_o				(ic_refill),		 // Templated
      .refill_req_o			(ic_refill_req),	 // Templated
      .refill_done_o			(ic_refill_done),	 // Templated
      .invalidate_o			(ic_invalidate),	 // Templated
      .cpu_ack_o			(ic_ack),		 // Templated
      .cpu_dat_o			(ic_dat[OPTION_OPERAND_WIDTH-1:0]), // Templated
      .spr_bus_dat_o			(spr_bus_dat_ic_o),	 // Templated
      .spr_bus_ack_o			(spr_bus_ack_ic_o),	 // Templated
      // Inputs
      .clk				(clk),
      .rst				(ic_rst),		 // Templated
      .ic_access_i			(ic_access),		 // Templated
      .cpu_adr_i			(ic_addr),		 // Templated
      .cpu_adr_match_i			(ic_addr_match),	 // Templated
      .cpu_req_i			(ic_req),		 // Templated
      .wradr_i				(ibus_adr),		 // Templated
      .wrdat_i				(ibus_dat_i),		 // Templated
      .we_i				(ibus_ack_i),		 // Templated
      .spr_bus_addr_i			(spr_bus_addr_i[15:0]),
      .spr_bus_we_i			(spr_bus_we_i),
      .spr_bus_stb_i			(spr_bus_stb_i),
      .spr_bus_dat_i			(spr_bus_dat_i[OPTION_OPERAND_WIDTH-1:0]));
end else begin // block: icache_gen
   assign ic_access = 0;
   assign ic_refill = 0;
   assign ic_refill_done = 0;
   assign ic_ack = 0;
end
endgenerate

generate
if (FEATURE_IMMU!="NONE") begin : immu_gen
   wire  [OPTION_OPERAND_WIDTH-1:0] virt_addr = ic_addr;
   wire 			    immu_spr_bus_stb;
   wire 			    immu_enable;
   // small hack to delay immu spr reads by one cycle
   // ideally the spr accesses should work so that the address is presented
   // in execute stage and the delayed data should be available in control
   // stage, but this is not how things currently work.
   assign immu_spr_bus_stb = spr_bus_stb_i & (!padv_ctrl_i | spr_bus_we_i);

   assign immu_enable = immu_enable_i & !pipeline_flush_i & !mispredict_stall;

   /* mor1kx_immu AUTO_TEMPLATE (
    .enable_i				(immu_enable),
    .busy_o				(immu_busy),
    .phys_addr_o			(immu_phys_addr),
    .cache_inhibit_o			(immu_cache_inhibit),
    .tlb_miss_o				(tlb_miss),
    .tlb_reload_req_o			(tlb_reload_req),
    .tlb_reload_addr_o			(tlb_reload_addr),
    .tlb_reload_pagefault_o		(tlb_reload_pagefault),
    .tlb_reload_ack_i			(tlb_reload_ack),
    .tlb_reload_data_i			(tlb_reload_data),
    .tlb_reload_busy_o			(tlb_reload_busy),
    .tlb_reload_pagefault_clear_i	(except_ipagefault_clear),
    .pagefault_o			(pagefault),
    .spr_bus_dat_o			(spr_bus_dat_immu_o),
    .spr_bus_ack_o			(spr_bus_ack_immu_o),
    .spr_bus_stb_i			(immu_spr_bus_stb),
    .virt_addr_i			(virt_addr),
    .virt_addr_match_i			(pc_fetch),
    ); */
   mor1kx_immu
     #(
       .FEATURE_IMMU_HW_TLB_RELOAD(FEATURE_IMMU_HW_TLB_RELOAD),
       .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH),
       .OPTION_IMMU_SET_WIDTH(OPTION_IMMU_SET_WIDTH),
       .OPTION_IMMU_WAYS(OPTION_IMMU_WAYS)
       )
   mor1kx_immu
     (/*AUTOINST*/
      // Outputs
      .busy_o				(immu_busy),		 // Templated
      .phys_addr_o			(immu_phys_addr),	 // Templated
      .cache_inhibit_o			(immu_cache_inhibit),	 // Templated
      .tlb_miss_o			(tlb_miss),		 // Templated
      .pagefault_o			(pagefault),		 // Templated
      .tlb_reload_req_o			(tlb_reload_req),	 // Templated
      .tlb_reload_addr_o		(tlb_reload_addr),	 // Templated
      .tlb_reload_pagefault_o		(tlb_reload_pagefault),	 // Templated
      .tlb_reload_busy_o		(tlb_reload_busy),	 // Templated
      .spr_bus_dat_o			(spr_bus_dat_immu_o),	 // Templated
      .spr_bus_ack_o			(spr_bus_ack_immu_o),	 // Templated
      // Inputs
      .clk				(clk),
      .rst				(rst),
      .enable_i				(immu_enable),		 // Templated
      .virt_addr_i			(virt_addr),		 // Templated
      .virt_addr_match_i		(pc_fetch),		 // Templated
      .supervisor_mode_i		(supervisor_mode_i),
      .tlb_reload_ack_i			(tlb_reload_ack),	 // Templated
      .tlb_reload_data_i		(tlb_reload_data),	 // Templated
      .tlb_reload_pagefault_clear_i	(except_ipagefault_clear), // Templated
      .spr_bus_addr_i			(spr_bus_addr_i[15:0]),
      .spr_bus_we_i			(spr_bus_we_i),
      .spr_bus_stb_i			(immu_spr_bus_stb),	 // Templated
      .spr_bus_dat_i			(spr_bus_dat_i[OPTION_OPERAND_WIDTH-1:0]));
end else begin
   assign immu_cache_inhibit = 0;
   assign immu_busy = 0;
   assign tlb_miss = 0;
   assign pagefault = 0;
   assign tlb_reload_busy = 0;
   assign tlb_reload_req = 0;
   assign tlb_reload_pagefault = 0;
end
endgenerate

endmodule // mor1kx_fetch_cappuccino

/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: mor1kx decode unit

  Completely combinatorial.

  Outputs:
   - ALU operation
   - indication of other type of op - LSU/SPR
   - immediates
   - register file addresses
   - exception decodes:  illegal, system call

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


module mor1kx_decode
  #(
    parameter OPTION_OPERAND_WIDTH = 32,
    parameter OPTION_RESET_PC = {{(OPTION_OPERAND_WIDTH-13){1'b0}},
				 `OR1K_RESET_VECTOR,8'd0},
    parameter OPTION_RF_ADDR_WIDTH = 5,

    parameter FEATURE_SYSCALL = "ENABLED",
    parameter FEATURE_TRAP = "ENABLED",
    parameter FEATURE_RANGE = "ENABLED",
    parameter FEATURE_MAC = "NONE",
    parameter FEATURE_MULTIPLIER = "PARALLEL",
    parameter FEATURE_DIVIDER = "NONE",

    parameter FEATURE_ADDC = "NONE",
    parameter FEATURE_SRA = "ENABLED",
    parameter FEATURE_ROR = "NONE",
    parameter FEATURE_EXT = "NONE",
    parameter FEATURE_CMOV = "NONE",
    parameter FEATURE_FFL1 = "NONE",
    parameter FEATURE_ATOMIC = "ENABLED",
    parameter FEATURE_MSYNC = "NONE",
    parameter FEATURE_PSYNC = "NONE",
    parameter FEATURE_CSYNC = "NONE",

    parameter FEATURE_CUST1 = "NONE",
    parameter FEATURE_CUST2 = "NONE",
    parameter FEATURE_CUST3 = "NONE",
    parameter FEATURE_CUST4 = "NONE",
    parameter FEATURE_CUST5 = "NONE",
    parameter FEATURE_CUST6 = "NONE",
    parameter FEATURE_CUST7 = "NONE",
    parameter FEATURE_CUST8 = "NONE"
    )
   (
    input 			      clk,
    input 			      rst,

    // input from fetch stage
    input [`OR1K_INSN_WIDTH-1:0]      decode_insn_i,

    // ALU opcodes
    output [`OR1K_ALU_OPC_WIDTH-1:0]  decode_opc_alu_o,
    output [`OR1K_ALU_OPC_WIDTH-1:0]  decode_opc_alu_secondary_o,

    output [`OR1K_IMM_WIDTH-1:0]      decode_imm16_o,
    output [OPTION_OPERAND_WIDTH-1:0] decode_immediate_o,
    output 			      decode_immediate_sel_o,

    // Upper 10 bits of immediate for jumps and branches
    output [9:0] 		      decode_immjbr_upper_o,

    // GPR numbers
    output [OPTION_RF_ADDR_WIDTH-1:0] decode_rfd_adr_o,
    output [OPTION_RF_ADDR_WIDTH-1:0] decode_rfa_adr_o,
    output [OPTION_RF_ADDR_WIDTH-1:0] decode_rfb_adr_o,

    output 			      decode_rf_wb_o,

    output 			      decode_op_jbr_o,
    output 			      decode_op_jr_o,
    output 			      decode_op_jal_o,
    output 			      decode_op_bf_o,
    output 			      decode_op_bnf_o,
    output 			      decode_op_brcond_o,
    output 			      decode_op_branch_o,

    output 			      decode_op_alu_o,

    output 			      decode_op_lsu_load_o,
    output 			      decode_op_lsu_store_o,
    output 			      decode_op_lsu_atomic_o,
    output reg [1:0] 		      decode_lsu_length_o,
    output 			      decode_lsu_zext_o,

    output 			      decode_op_mfspr_o,
    output 			      decode_op_mtspr_o,

    output 			      decode_op_rfe_o,
    output 			      decode_op_setflag_o,
    output 			      decode_op_add_o,
    output 			      decode_op_mul_o,
    output 			      decode_op_mul_signed_o,
    output 			      decode_op_mul_unsigned_o,
    output 			      decode_op_div_o,
    output 			      decode_op_div_signed_o,
    output 			      decode_op_div_unsigned_o,
    output 			      decode_op_shift_o,
    output 			      decode_op_ffl1_o,
    output 			      decode_op_movhi_o,

    // Adder control logic
    output 			      decode_adder_do_sub_o,
    output 			      decode_adder_do_carry_o,

    // exception output -
    output reg 			      decode_except_illegal_o,
    output 			      decode_except_syscall_o,
    output 			      decode_except_trap_o,

    output [`OR1K_OPCODE_WIDTH-1:0]   decode_opc_insn_o
    );

   wire [`OR1K_OPCODE_WIDTH-1:0]      opc_insn;
   wire [`OR1K_ALU_OPC_WIDTH-1:0]     opc_alu;

   wire [OPTION_OPERAND_WIDTH-1:0]    imm_sext;
   wire 			      imm_sext_sel;
   wire [OPTION_OPERAND_WIDTH-1:0]    imm_zext;
   wire 			      imm_zext_sel;
   wire [OPTION_OPERAND_WIDTH-1:0]    imm_high;
   wire 			      imm_high_sel;

   wire 			      decode_except_ibus_align;

   // Insn opcode
   assign opc_insn = decode_insn_i[`OR1K_OPCODE_SELECT];
   assign decode_opc_insn_o = opc_insn;

   // load opcodes are 6'b10_0000 to 6'b10_0110, 0 to 6, so check for 7 and up
   assign decode_op_lsu_load_o = (decode_insn_i[31:30] == 2'b10) &
				 !(&decode_insn_i[28:26]) &
				 !decode_insn_i[29] ||
				 ((opc_insn == `OR1K_OPCODE_LWA) &
				 (FEATURE_ATOMIC!="NONE"));

   // Detect when instruction is store
   assign decode_op_lsu_store_o = (opc_insn == `OR1K_OPCODE_SW) ||
				  (opc_insn == `OR1K_OPCODE_SB) ||
				  (opc_insn == `OR1K_OPCODE_SH) ||
				  ((opc_insn == `OR1K_OPCODE_SWA) &
				  (FEATURE_ATOMIC!="NONE"));

   assign decode_op_lsu_atomic_o = ((opc_insn == `OR1K_OPCODE_LWA) ||
				    (opc_insn == `OR1K_OPCODE_SWA)) &
				   (FEATURE_ATOMIC!="NONE");

   // Decode length of load/store operation
   always @(*)
     case (opc_insn)
       `OR1K_OPCODE_SB,
       `OR1K_OPCODE_LBZ,
       `OR1K_OPCODE_LBS:
	 decode_lsu_length_o = 2'b00;

       `OR1K_OPCODE_SH,
       `OR1K_OPCODE_LHZ,
       `OR1K_OPCODE_LHS:
	 decode_lsu_length_o = 2'b01;

       `OR1K_OPCODE_SW,
       `OR1K_OPCODE_SWA,
       `OR1K_OPCODE_LWZ,
       `OR1K_OPCODE_LWS,
       `OR1K_OPCODE_LWA:
	 decode_lsu_length_o = 2'b10;

       default:
	 decode_lsu_length_o = 2'b10;
     endcase

   assign decode_lsu_zext_o = opc_insn[0];

   assign decode_op_mtspr_o = opc_insn == `OR1K_OPCODE_MTSPR;

   // Detect when setflag instruction
   assign decode_op_setflag_o = opc_insn == `OR1K_OPCODE_SF ||
				opc_insn == `OR1K_OPCODE_SFIMM;

   assign decode_op_alu_o = opc_insn == `OR1K_OPCODE_ALU ||
			    opc_insn == `OR1K_OPCODE_ORI ||
			    opc_insn == `OR1K_OPCODE_ANDI ||
			    opc_insn == `OR1K_OPCODE_XORI;

   // Bottom 4 opcodes branch against an immediate
   assign decode_op_jbr_o = opc_insn < `OR1K_OPCODE_NOP;

   assign decode_op_jr_o = opc_insn == `OR1K_OPCODE_JR |
			   opc_insn == `OR1K_OPCODE_JALR;

   assign decode_op_jal_o = opc_insn == `OR1K_OPCODE_JALR |
			    opc_insn == `OR1K_OPCODE_JAL;

   assign decode_op_bf_o = opc_insn == `OR1K_OPCODE_BF;
   assign decode_op_bnf_o = opc_insn == `OR1K_OPCODE_BNF;
   assign decode_op_brcond_o = decode_op_bf_o | decode_op_bnf_o;

   // All branch instructions combined
   assign decode_op_branch_o = decode_op_jbr_o |
			       decode_op_jr_o |
			       decode_op_jal_o;

   assign decode_op_mfspr_o = opc_insn == `OR1K_OPCODE_MFSPR;

   assign decode_op_rfe_o = opc_insn == `OR1K_OPCODE_RFE;

   assign decode_op_add_o = (opc_insn == `OR1K_OPCODE_ALU &&
			     (opc_alu == `OR1K_ALU_OPC_ADDC ||
			      opc_alu == `OR1K_ALU_OPC_ADD ||
			      opc_alu == `OR1K_ALU_OPC_SUB)) ||
			    opc_insn == `OR1K_OPCODE_ADDIC ||
			    opc_insn == `OR1K_OPCODE_ADDI;

   assign decode_op_mul_signed_o = (opc_insn == `OR1K_OPCODE_ALU &&
				    opc_alu == `OR1K_ALU_OPC_MUL) ||
				   opc_insn == `OR1K_OPCODE_MULI;

   assign decode_op_mul_unsigned_o = opc_insn == `OR1K_OPCODE_ALU &&
				     opc_alu == `OR1K_ALU_OPC_MULU;

   assign decode_op_mul_o = decode_op_mul_signed_o | decode_op_mul_unsigned_o;

   assign decode_op_div_signed_o = opc_insn == `OR1K_OPCODE_ALU &&
				   opc_alu == `OR1K_ALU_OPC_DIV;

   assign decode_op_div_unsigned_o = opc_insn == `OR1K_OPCODE_ALU &&
				     opc_alu == `OR1K_ALU_OPC_DIVU;

   assign decode_op_div_o = decode_op_div_signed_o | decode_op_div_unsigned_o;

   assign decode_op_shift_o = opc_insn == `OR1K_OPCODE_ALU &&
			      opc_alu == `OR1K_ALU_OPC_SHRT ||
			      opc_insn == `OR1K_OPCODE_SHRTI;

   assign decode_op_ffl1_o = opc_insn == `OR1K_OPCODE_ALU &&
			     opc_alu == `OR1K_ALU_OPC_FFL1;

   assign decode_op_movhi_o = opc_insn == `OR1K_OPCODE_MOVHI;

   // Which instructions cause writeback?
   assign decode_rf_wb_o = (opc_insn == `OR1K_OPCODE_JAL |
			    opc_insn == `OR1K_OPCODE_MOVHI |
			    opc_insn == `OR1K_OPCODE_JALR |
			    opc_insn == `OR1K_OPCODE_LWA) |
			   // All '10????' opcodes except l.sfxxi
			   (decode_insn_i[31:30] == 2'b10 &
			    !(opc_insn == `OR1K_OPCODE_SFIMM)) |
			   // All '11????' opcodes except l.sfxx and l.mtspr
			   (decode_insn_i[31:30] == 2'b11 &
			    !(opc_insn == `OR1K_OPCODE_SF |
			      decode_op_mtspr_o | decode_op_lsu_store_o));

   // Register file addresses
   assign decode_rfa_adr_o = decode_insn_i[`OR1K_RA_SELECT];
   assign decode_rfb_adr_o = decode_insn_i[`OR1K_RB_SELECT];

   assign decode_rfd_adr_o = decode_op_jal_o ? 9 :
			     decode_insn_i[`OR1K_RD_SELECT];

   // Immediate in l.mtspr is broken up, reassemble
   assign decode_imm16_o = (decode_op_mtspr_o | decode_op_lsu_store_o) ?
			   {decode_insn_i[25:21],decode_insn_i[10:0]} :
			   decode_insn_i[`OR1K_IMM_SELECT];


   // Upper 10 bits for jump/branch instructions
   assign decode_immjbr_upper_o = decode_insn_i[25:16];

   assign imm_sext = {{16{decode_imm16_o[15]}}, decode_imm16_o[15:0]};
   assign imm_sext_sel = ((opc_insn[5:4] == 2'b10) &
                          ~(opc_insn == `OR1K_OPCODE_ORI) &
                          ~(opc_insn == `OR1K_OPCODE_ANDI)) |
                         (opc_insn == `OR1K_OPCODE_SWA) |
                         (opc_insn == `OR1K_OPCODE_LWA) |
                         (opc_insn == `OR1K_OPCODE_SW) |
                         (opc_insn == `OR1K_OPCODE_SH) |
                         (opc_insn == `OR1K_OPCODE_SB);

   assign imm_zext = {{16{1'b0}}, decode_imm16_o[15:0]};
   assign imm_zext_sel = ((opc_insn[5:4] == 2'b10) &
                          ((opc_insn == `OR1K_OPCODE_ORI) |
			   (opc_insn == `OR1K_OPCODE_ANDI))) |
                         (opc_insn == `OR1K_OPCODE_MTSPR);

   assign imm_high = {decode_imm16_o, 16'd0};
   assign imm_high_sel = decode_op_movhi_o;

   assign decode_immediate_o = imm_sext_sel ? imm_sext :
			       imm_zext_sel ? imm_zext : imm_high;

   assign decode_immediate_sel_o = imm_sext_sel | imm_zext_sel | imm_high_sel;

   // ALU opcode
   assign opc_alu = decode_insn_i[`OR1K_ALU_OPC_SELECT];
   assign decode_opc_alu_o = opc_insn == `OR1K_OPCODE_ORI ? `OR1K_ALU_OPC_OR :
			     opc_insn == `OR1K_OPCODE_ANDI ? `OR1K_ALU_OPC_AND :
			     opc_insn == `OR1K_OPCODE_XORI ? `OR1K_ALU_OPC_XOR :
			     opc_alu;

   assign decode_opc_alu_secondary_o = decode_op_setflag_o ?
				       decode_insn_i[`OR1K_COMP_OPC_SELECT]:
				       {1'b0,
					decode_insn_i[`OR1K_ALU_OPC_SECONDARY_SELECT]};

   assign decode_except_syscall_o = opc_insn == `OR1K_OPCODE_SYSTRAPSYNC &&
				    decode_insn_i[`OR1K_SYSTRAPSYNC_OPC_SELECT] ==
				    `OR1K_SYSTRAPSYNC_OPC_SYSCALL;

   assign decode_except_trap_o = opc_insn == `OR1K_OPCODE_SYSTRAPSYNC &&
				 decode_insn_i[`OR1K_SYSTRAPSYNC_OPC_SELECT] ==
				 `OR1K_SYSTRAPSYNC_OPC_TRAP;

   // Illegal instruction decode
   always @*
     case (opc_insn)
       `OR1K_OPCODE_J,
       `OR1K_OPCODE_JAL,
       `OR1K_OPCODE_BNF,
       `OR1K_OPCODE_BF,
       `OR1K_OPCODE_MOVHI,
       `OR1K_OPCODE_RFE,
       `OR1K_OPCODE_JR,
       `OR1K_OPCODE_JALR,
       `OR1K_OPCODE_LWZ,
       `OR1K_OPCODE_LWS,
       `OR1K_OPCODE_LBZ,
       `OR1K_OPCODE_LBS,
       `OR1K_OPCODE_LHZ,
       `OR1K_OPCODE_LHS,
       `OR1K_OPCODE_ADDI,
       `OR1K_OPCODE_ANDI,
       `OR1K_OPCODE_ORI,
       `OR1K_OPCODE_XORI,
       `OR1K_OPCODE_MFSPR,
       /*
	`OR1K_OPCODE_SLLI,
	`OR1K_OPCODE_SRLI,
	`OR1K_OPCODE_SRAI,
	`OR1K_OPCODE_RORI,
	*/
       `OR1K_OPCODE_SFIMM,
       `OR1K_OPCODE_MTSPR,
       `OR1K_OPCODE_SW,
       `OR1K_OPCODE_SB,
       `OR1K_OPCODE_SH,
       /*
	`OR1K_OPCODE_SFEQ,
	`OR1K_OPCODE_SFNE,
	`OR1K_OPCODE_SFGTU,
	`OR1K_OPCODE_SFGEU,
	`OR1K_OPCODE_SFLTU,
	`OR1K_OPCODE_SFLEU,
	`OR1K_OPCODE_SFGTS,
	`OR1K_OPCODE_SFGES,
	`OR1K_OPCODE_SFLTS,
	`OR1K_OPCODE_SFLES,
	*/
       `OR1K_OPCODE_SF,
       `OR1K_OPCODE_NOP:
	 decode_except_illegal_o = 1'b0;

       `OR1K_OPCODE_SWA,
       `OR1K_OPCODE_LWA:
	 decode_except_illegal_o = (FEATURE_ATOMIC=="NONE");

       `OR1K_OPCODE_CUST1:
	 decode_except_illegal_o = (FEATURE_CUST1=="NONE");
       `OR1K_OPCODE_CUST2:
	 decode_except_illegal_o = (FEATURE_CUST2=="NONE");
       `OR1K_OPCODE_CUST3:
	 decode_except_illegal_o = (FEATURE_CUST3=="NONE");
       `OR1K_OPCODE_CUST4:
	 decode_except_illegal_o = (FEATURE_CUST4=="NONE");
       `OR1K_OPCODE_CUST5:
	 decode_except_illegal_o = (FEATURE_CUST5=="NONE");
       `OR1K_OPCODE_CUST6:
	 decode_except_illegal_o = (FEATURE_CUST6=="NONE");
       `OR1K_OPCODE_CUST7:
	 decode_except_illegal_o = (FEATURE_CUST7=="NONE");
       `OR1K_OPCODE_CUST8:
	 decode_except_illegal_o = (FEATURE_CUST8=="NONE");

       `OR1K_OPCODE_LD,
	 `OR1K_OPCODE_SD:
	   decode_except_illegal_o = !(OPTION_OPERAND_WIDTH==64);

       `OR1K_OPCODE_ADDIC:
	 decode_except_illegal_o = (FEATURE_ADDC=="NONE");

       //`OR1K_OPCODE_MACRC, // Same as movhi - check!
       `OR1K_OPCODE_MACI,
	 `OR1K_OPCODE_MAC:
	   decode_except_illegal_o = (FEATURE_MAC=="NONE");

       `OR1K_OPCODE_MULI:
	 decode_except_illegal_o = (FEATURE_MULTIPLIER=="NONE");

       `OR1K_OPCODE_SHRTI:
	 case(decode_insn_i[`OR1K_ALU_OPC_SECONDARY_SELECT])
	   `OR1K_ALU_OPC_SECONDARY_SHRT_SLL,
	   `OR1K_ALU_OPC_SECONDARY_SHRT_SRL:
	     decode_except_illegal_o = 1'b0;
	   `OR1K_ALU_OPC_SECONDARY_SHRT_SRA:
	     decode_except_illegal_o = (FEATURE_SRA=="NONE");

	   `OR1K_ALU_OPC_SECONDARY_SHRT_ROR:
	     decode_except_illegal_o = (FEATURE_ROR=="NONE");
	   default:
	     decode_except_illegal_o = 1'b1;
	 endcase // case (decode_insn_i[`OR1K_ALU_OPC_SECONDARY_SELECT])

       `OR1K_OPCODE_ALU:
	 case(decode_insn_i[`OR1K_ALU_OPC_SELECT])
	   `OR1K_ALU_OPC_ADD,
	   `OR1K_ALU_OPC_SUB,
	   `OR1K_ALU_OPC_OR,
	   `OR1K_ALU_OPC_XOR,
	   `OR1K_ALU_OPC_AND:
	     decode_except_illegal_o = 1'b0;
	   `OR1K_ALU_OPC_CMOV:
	     decode_except_illegal_o = (FEATURE_CMOV=="NONE");
	   `OR1K_ALU_OPC_FFL1:
	     decode_except_illegal_o = (FEATURE_FFL1=="NONE");
	   `OR1K_ALU_OPC_DIV,
	     `OR1K_ALU_OPC_DIVU:
	       decode_except_illegal_o = (FEATURE_DIVIDER=="NONE");
	   `OR1K_ALU_OPC_ADDC:
	     decode_except_illegal_o = (FEATURE_ADDC=="NONE");
	   `OR1K_ALU_OPC_MUL,
	     `OR1K_ALU_OPC_MULU:
	       decode_except_illegal_o = (FEATURE_MULTIPLIER=="NONE");
	   `OR1K_ALU_OPC_EXTBH,
	     `OR1K_ALU_OPC_EXTW:
	       decode_except_illegal_o = (FEATURE_EXT=="NONE");
	   `OR1K_ALU_OPC_SHRT:
	     case(decode_insn_i[`OR1K_ALU_OPC_SECONDARY_SELECT])
	       `OR1K_ALU_OPC_SECONDARY_SHRT_SLL,
	       `OR1K_ALU_OPC_SECONDARY_SHRT_SRL:
		 decode_except_illegal_o = 1'b0;
	       `OR1K_ALU_OPC_SECONDARY_SHRT_SRA:
		 decode_except_illegal_o = (FEATURE_SRA=="NONE");
	       `OR1K_ALU_OPC_SECONDARY_SHRT_ROR:
		 decode_except_illegal_o = (FEATURE_ROR=="NONE");
	       default:
		 decode_except_illegal_o = 1'b1;
	     endcase // case (decode_insn_i[`OR1K_ALU_OPC_SECONDARY_SELECT])
	   default:
	     decode_except_illegal_o = 1'b1;
	 endcase // case (decode_insn_i[`OR1K_ALU_OPC_SELECT])

       `OR1K_OPCODE_SYSTRAPSYNC: begin
	  if ((decode_insn_i[`OR1K_SYSTRAPSYNC_OPC_SELECT] ==
	       `OR1K_SYSTRAPSYNC_OPC_SYSCALL &&
	       FEATURE_SYSCALL=="ENABLED") ||
	      (decode_insn_i[`OR1K_SYSTRAPSYNC_OPC_SELECT] ==
	       `OR1K_SYSTRAPSYNC_OPC_TRAP &&
	       FEATURE_TRAP=="ENABLED") ||
	      (decode_insn_i[`OR1K_SYSTRAPSYNC_OPC_SELECT] ==
	       `OR1K_SYSTRAPSYNC_OPC_MSYNC) ||
	      (decode_insn_i[`OR1K_SYSTRAPSYNC_OPC_SELECT] ==
	       `OR1K_SYSTRAPSYNC_OPC_PSYNC &&
	       FEATURE_PSYNC!="NONE") ||
	      (decode_insn_i[`OR1K_SYSTRAPSYNC_OPC_SELECT] ==
	       `OR1K_SYSTRAPSYNC_OPC_CSYNC &&
	       FEATURE_CSYNC!="NONE"))
	    decode_except_illegal_o = 1'b0;
	  else
	    decode_except_illegal_o = 1'b1;
       end // case: endcase...
       default:
	 decode_except_illegal_o = 1'b1;

     endcase // case (decode_insn_i[`OR1K_OPCODE_SELECT])

   // Adder control logic
   // Subtract when comparing to check if equal
   assign decode_adder_do_sub_o = (opc_insn == `OR1K_OPCODE_ALU &
				   opc_alu == `OR1K_ALU_OPC_SUB) |
				  decode_op_setflag_o;

   // Generate carry-in select
   assign decode_adder_do_carry_o = (FEATURE_ADDC!="NONE") &&
				    ((opc_insn == `OR1K_OPCODE_ALU &
				      opc_alu == `OR1K_ALU_OPC_ADDC) ||
				     (opc_insn == `OR1K_OPCODE_ADDIC));

endmodule // mor1kx_decode

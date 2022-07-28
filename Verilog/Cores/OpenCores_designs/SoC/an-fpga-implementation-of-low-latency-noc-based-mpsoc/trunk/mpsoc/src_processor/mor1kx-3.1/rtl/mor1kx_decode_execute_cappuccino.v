/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: Cappuccino decode to execute module.
  - Decode to execute stage signal passing.
  - Branches are resolved (in decode stage).
  - Hazards that can not be resolved by bypassing are detected and
    bubbles are inserted on such conditions.

  Generate valid signal when stage is done.

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


module mor1kx_decode_execute_cappuccino
  #(
    parameter OPTION_OPERAND_WIDTH = 32,
    parameter OPTION_RESET_PC = {{(OPTION_OPERAND_WIDTH-13){1'b0}},
				 `OR1K_RESET_VECTOR,8'd0},

    parameter OPTION_RF_ADDR_WIDTH = 5,

    parameter FEATURE_SYSCALL = "ENABLED",
    parameter FEATURE_TRAP = "ENABLED",
    parameter FEATURE_DELAY_SLOT = "ENABLED",

    parameter FEATURE_MULTIPLIER = "THREESTAGE",

    parameter FEATURE_INBUILT_CHECKERS = "ENABLED"
    )
   (
    input 				  clk,
    input 				  rst,

    // pipeline control signal in
    input 				  padv_i,
    input [OPTION_OPERAND_WIDTH-1:0] 	  pc_decode_i,

    // input from register file
    input [OPTION_OPERAND_WIDTH-1:0] 	  decode_rfb_i,
    input [OPTION_OPERAND_WIDTH-1:0] 	  execute_rfb_i,

    // Branch prediction signals
    input 				  predicted_flag_i,
    output reg 				  execute_predicted_flag_o,
    // The target pc that should be used in case of branch misprediction
    output reg [OPTION_OPERAND_WIDTH-1:0] execute_mispredict_target_o,

    input 				  pipeline_flush_i,

    // ALU related inputs from decode
    input [`OR1K_ALU_OPC_WIDTH-1:0] 	  decode_opc_alu_i,
    input [`OR1K_ALU_OPC_WIDTH-1:0] 	  decode_opc_alu_secondary_i,

    input [`OR1K_IMM_WIDTH-1:0] 	  decode_imm16_i,
    input [OPTION_OPERAND_WIDTH-1:0] 	  decode_immediate_i,
    input 				  decode_immediate_sel_i,

    //  ALU related outputs to execute
    output reg [`OR1K_ALU_OPC_WIDTH-1:0]  execute_opc_alu_o,
    output reg [`OR1K_ALU_OPC_WIDTH-1:0]  execute_opc_alu_secondary_o,

    output reg [`OR1K_IMM_WIDTH-1:0] 	  execute_imm16_o,
    output reg [OPTION_OPERAND_WIDTH-1:0] execute_immediate_o,
    output reg 				  execute_immediate_sel_o,

    // Adder control logic from decode
    input 				  decode_adder_do_sub_i,
    input 				  decode_adder_do_carry_i,

    // Adder control logic to execute
    output reg 				  execute_adder_do_sub_o,
    output reg 				  execute_adder_do_carry_o,

    // Upper 10 bits of immediate for jumps and branches
    input [9:0] 			  decode_immjbr_upper_i,
    output reg [9:0] 			  execute_immjbr_upper_o,

    // GPR numbers
    output reg [OPTION_RF_ADDR_WIDTH-1:0] execute_rfd_adr_o,
    input [OPTION_RF_ADDR_WIDTH-1:0] 	  decode_rfd_adr_i,
    input [OPTION_RF_ADDR_WIDTH-1:0] 	  decode_rfa_adr_i,
    input [OPTION_RF_ADDR_WIDTH-1:0] 	  decode_rfb_adr_i,
    input [OPTION_RF_ADDR_WIDTH-1:0] 	  ctrl_rfd_adr_i,
    input 				  ctrl_op_lsu_load_i,
    input 				  ctrl_op_mfspr_i,
    input 				  ctrl_op_mul_i,

    // Control signal inputs from decode stage
    input 				  decode_rf_wb_i,

    input 				  decode_op_alu_i,

    input 				  decode_op_setflag_i,

    input 				  decode_op_jbr_i,
    input 				  decode_op_jr_i,
    input 				  decode_op_jal_i,
    input 				  decode_op_bf_i,
    input 				  decode_op_bnf_i,
    input 				  decode_op_brcond_i,
    input 				  decode_op_branch_i,

    input 				  decode_op_lsu_load_i,
    input 				  decode_op_lsu_store_i,
    input 				  decode_op_lsu_atomic_i,
    input [1:0] 			  decode_lsu_length_i,
    input 				  decode_lsu_zext_i,

    input 				  decode_op_mfspr_i,
    input 				  decode_op_mtspr_i,

    input 				  decode_op_rfe_i,
    input 				  decode_op_add_i,
    input 				  decode_op_mul_i,
    input 				  decode_op_mul_signed_i,
    input 				  decode_op_mul_unsigned_i,
    input 				  decode_op_div_i,
    input 				  decode_op_div_signed_i,
    input 				  decode_op_div_unsigned_i,
    input 				  decode_op_shift_i,
    input 				  decode_op_ffl1_i,
    input 				  decode_op_movhi_i,

    input [`OR1K_OPCODE_WIDTH-1:0] 	  decode_opc_insn_i,

    // Control signal outputs to execute stage
    output reg 				  execute_rf_wb_o,

    output reg 				  execute_op_alu_o,

    output reg 				  execute_op_setflag_o,

    output reg 				  execute_op_jbr_o,
    output reg 				  execute_op_jr_o,
    output reg 				  execute_op_jal_o,
    output reg 				  execute_op_brcond_o,
    output reg 				  execute_op_branch_o,

    output reg 				  execute_op_lsu_load_o,
    output reg 				  execute_op_lsu_store_o,
    output reg 				  execute_op_lsu_atomic_o,
    output reg [1:0] 			  execute_lsu_length_o,
    output reg 				  execute_lsu_zext_o,

    output reg 				  execute_op_mfspr_o,
    output reg 				  execute_op_mtspr_o,

    output reg 				  execute_op_rfe_o,
    output reg 				  execute_op_add_o,
    output reg 				  execute_op_mul_o,
    output reg 				  execute_op_mul_signed_o,
    output reg 				  execute_op_mul_unsigned_o,
    output reg 				  execute_op_div_o,
    output reg 				  execute_op_div_signed_o,
    output reg 				  execute_op_div_unsigned_o,
    output reg 				  execute_op_shift_o,
    output reg 				  execute_op_ffl1_o,
    output reg 				  execute_op_movhi_o,

    output reg [OPTION_OPERAND_WIDTH-1:0] execute_jal_result_o,

    output reg [`OR1K_OPCODE_WIDTH-1:0]   execute_opc_insn_o,

    // branch detection
    output 				  decode_branch_o,
    output [OPTION_OPERAND_WIDTH-1:0] 	  decode_branch_target_o,

    // exceptions in
    input 				  decode_except_ibus_err_i,
    input 				  decode_except_itlb_miss_i,
    input 				  decode_except_ipagefault_i,
    input 				  decode_except_illegal_i,
    input 				  decode_except_syscall_i,
    input 				  decode_except_trap_i,

    // exception output -
    output reg 				  execute_except_ibus_err_o,
    output reg 				  execute_except_itlb_miss_o,
    output reg 				  execute_except_ipagefault_o,
    output reg 				  execute_except_illegal_o,
    output reg 				  execute_except_ibus_align_o,
    output reg 				  execute_except_syscall_o,
    output reg 				  execute_except_trap_o,

    output reg [OPTION_OPERAND_WIDTH-1:0] pc_execute_o,

    // output is valid, signal
    output reg 				  decode_valid_o,

    output 				  decode_bubble_o,
    output reg 				  execute_bubble_o
    );

   wire 			   ctrl_to_decode_interlock;
   wire 			   branch_to_imm;
   wire [OPTION_OPERAND_WIDTH-1:0] branch_to_imm_target;
   wire 			   branch_to_reg;

   wire 			   decode_except_ibus_align;

   wire [OPTION_OPERAND_WIDTH-1:0] next_pc_after_branch_insn;
   wire [OPTION_OPERAND_WIDTH-1:0] decode_mispredict_target;

   // Op control signals to execute stage
   always @(posedge clk `OR_ASYNC_RST)
     if (rst) begin
	execute_op_alu_o <= 1'b0;
	execute_op_add_o <= 1'b0;
	execute_op_mul_o <= 1'b0;
	execute_op_mul_signed_o <= 1'b0;
	execute_op_mul_unsigned_o <= 1'b0;
	execute_op_div_o <= 1'b0;
	execute_op_div_signed_o <= 1'b0;
	execute_op_div_unsigned_o <= 1'b0;
	execute_op_shift_o <= 1'b0;
	execute_op_ffl1_o <= 1'b0;
	execute_op_movhi_o <= 1'b0;
	execute_op_mfspr_o <= 1'b0;
	execute_op_mtspr_o <= 1'b0;
	execute_op_lsu_load_o <= 1'b0;
	execute_op_lsu_store_o <= 1'b0;
	execute_op_lsu_atomic_o <= 1'b0;
	execute_op_setflag_o <= 1'b0;
	execute_op_jbr_o <= 1'b0;
	execute_op_jr_o <= 1'b0;
	execute_op_jal_o <= 1'b0;
	execute_op_brcond_o <= 1'b0;
	execute_op_branch_o <= 0;
     end else if (pipeline_flush_i) begin
	execute_op_alu_o <= 1'b0;
	execute_op_add_o <= 1'b0;
	execute_op_mul_o <= 1'b0;
	execute_op_mul_signed_o <= 1'b0;
	execute_op_mul_unsigned_o <= 1'b0;
	execute_op_div_o <= 1'b0;
	execute_op_div_signed_o <= 1'b0;
	execute_op_div_unsigned_o <= 1'b0;
	execute_op_shift_o <= 1'b0;
	execute_op_ffl1_o <= 1'b0;
	execute_op_movhi_o <= 1'b0;
	execute_op_lsu_load_o <= 1'b0;
	execute_op_lsu_store_o <= 1'b0;
	execute_op_lsu_atomic_o <= 1'b0;
	execute_op_setflag_o <= 1'b0;
	execute_op_jbr_o <= 1'b0;
	execute_op_jr_o <= 1'b0;
	execute_op_jal_o <= 1'b0;
	execute_op_brcond_o <= 1'b0;
	execute_op_branch_o <= 1'b0;
     end else if (padv_i) begin
	execute_op_alu_o <= decode_op_alu_i;
	execute_op_add_o <= decode_op_add_i;
	execute_op_mul_o <= decode_op_mul_i;
	execute_op_mul_signed_o <= decode_op_mul_signed_i;
	execute_op_mul_unsigned_o <= decode_op_mul_unsigned_i;
	execute_op_div_o <= decode_op_div_i;
	execute_op_div_signed_o <= decode_op_div_signed_i;
	execute_op_div_unsigned_o <= decode_op_div_unsigned_i;
	execute_op_shift_o <= decode_op_shift_i;
	execute_op_ffl1_o <= decode_op_ffl1_i;
	execute_op_movhi_o <= decode_op_movhi_i;
	execute_op_mfspr_o <= decode_op_mfspr_i;
	execute_op_mtspr_o <= decode_op_mtspr_i;
	execute_op_lsu_load_o <= decode_op_lsu_load_i;
	execute_op_lsu_store_o <= decode_op_lsu_store_i;
	execute_op_lsu_atomic_o <= decode_op_lsu_atomic_i;
	execute_op_setflag_o <= decode_op_setflag_i;
	execute_op_jbr_o <= decode_op_jbr_i;
	execute_op_jr_o <= decode_op_jr_i;
	execute_op_jal_o <= decode_op_jal_i;
	execute_op_brcond_o <= decode_op_brcond_i;
	execute_op_branch_o <= decode_op_branch_i;
	if (decode_bubble_o) begin
	   execute_op_alu_o <= 1'b0;
	   execute_op_add_o <= 1'b0;
	   execute_op_mul_o <= 1'b0;
	   execute_op_mul_signed_o <= 1'b0;
	   execute_op_mul_unsigned_o <= 1'b0;
	   execute_op_div_o <= 1'b0;
	   execute_op_div_signed_o <= 1'b0;
	   execute_op_div_unsigned_o <= 1'b0;
	   execute_op_shift_o <= 1'b0;
	   execute_op_ffl1_o <= 1'b0;
	   execute_op_movhi_o <= 1'b0;
	   execute_op_mtspr_o <= 1'b0;
	   execute_op_mfspr_o <= 1'b0;
	   execute_op_lsu_load_o <= 1'b0;
	   execute_op_lsu_store_o <= 1'b0;
	   execute_op_lsu_atomic_o <= 1'b0;
	   execute_op_setflag_o <= 1'b0;
	   execute_op_jbr_o <= 1'b0;
	   execute_op_jr_o <= 1'b0;
	   execute_op_jal_o <= 1'b0;
	   execute_op_brcond_o <= 1'b0;
	   execute_op_branch_o <= 1'b0;
	end
     end

   // rfe is a special case, instead of pushing the pipeline full
   // of nops on a decode_bubble_o, we push it full of rfes.
   // The reason for this is that we need the rfe to reach control
   // stage so it will cause the branch.
   // It will clear itself by the pipeline_flush_i that the rfe
   // will generate.
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       execute_op_rfe_o <= 0;
     else if (pipeline_flush_i)
       execute_op_rfe_o <= 0;
     else if (padv_i)
       execute_op_rfe_o <= decode_op_rfe_i;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst) begin
	execute_rf_wb_o <= 0;
     end else if (pipeline_flush_i) begin
	execute_rf_wb_o <= 0;
     end else if (padv_i) begin
	execute_rf_wb_o <= decode_rf_wb_i;
	if (decode_bubble_o)
	  execute_rf_wb_o <= 0;
     end

   always @(posedge clk)
     if (padv_i)
       execute_rfd_adr_o <= decode_rfd_adr_i;

   always @(posedge clk)
     if (padv_i) begin
	execute_lsu_length_o <= decode_lsu_length_i;
	execute_lsu_zext_o <= decode_lsu_zext_i;
     end

   always @(posedge clk)
     if (padv_i) begin
	execute_imm16_o <= decode_imm16_i;
	execute_immediate_o <= decode_immediate_i;
	execute_immediate_sel_o <= decode_immediate_sel_i;
     end

   always @(posedge clk)
     if (padv_i )
       execute_immjbr_upper_o <= decode_immjbr_upper_i;

   always @(posedge clk)
     if (padv_i) begin
	execute_opc_alu_o <= decode_opc_alu_i;
	execute_opc_alu_secondary_o <= decode_opc_alu_secondary_i;
     end

   always @(posedge clk `OR_ASYNC_RST)
     if (rst) begin
	execute_opc_insn_o <= `OR1K_OPCODE_NOP;
     end else if (pipeline_flush_i) begin
	execute_opc_insn_o <= `OR1K_OPCODE_NOP;
     end else if (padv_i) begin
	execute_opc_insn_o <= decode_opc_insn_i;
	if (decode_bubble_o)
	  execute_opc_insn_o <= `OR1K_OPCODE_NOP;
     end

   always @(posedge clk `OR_ASYNC_RST)
     if (rst) begin
	execute_adder_do_sub_o <= 1'b0;
	execute_adder_do_carry_o <= 1'b0;
     end else if (pipeline_flush_i) begin
	execute_adder_do_sub_o <= 1'b0;
	execute_adder_do_carry_o <= 1'b0;
     end else if (padv_i) begin
	execute_adder_do_sub_o <= decode_adder_do_sub_i;
	execute_adder_do_carry_o <= decode_adder_do_carry_i;
	if (decode_bubble_o) begin
	   execute_adder_do_sub_o <= 1'b0;
	   execute_adder_do_carry_o <= 1'b0;
	end
     end

   // Decode for system call exception
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       execute_except_syscall_o <= 0;
     else if (padv_i && FEATURE_SYSCALL=="ENABLED")
       execute_except_syscall_o <= decode_except_syscall_i;

   // Decode for system call exception
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       execute_except_trap_o <= 0;
     else if (padv_i && FEATURE_TRAP=="ENABLED")
       execute_except_trap_o <= decode_except_trap_i;

   // Decode Illegal instruction
   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       execute_except_illegal_o <= 0;
     else if (padv_i)
       execute_except_illegal_o <= decode_except_illegal_i;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       execute_except_ibus_err_o <= 1'b0;
     else if (padv_i)
       execute_except_ibus_err_o <= decode_except_ibus_err_i;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       execute_except_itlb_miss_o <= 1'b0;
     else if (padv_i)
       execute_except_itlb_miss_o <= decode_except_itlb_miss_i;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       execute_except_ipagefault_o <= 1'b0;
     else if (padv_i)
       execute_except_ipagefault_o <= decode_except_ipagefault_i;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       execute_except_ibus_align_o <= 1'b0;
     else if (padv_i)
       execute_except_ibus_align_o <= decode_except_ibus_align;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       decode_valid_o <= 0;
     else
       decode_valid_o <= padv_i;

   always @(posedge clk `OR_ASYNC_RST)
     if (padv_i)
       pc_execute_o <= pc_decode_i;

   // Branch detection
   assign ctrl_to_decode_interlock = (ctrl_op_lsu_load_i | ctrl_op_mfspr_i |
				      ctrl_op_mul_i &
				      FEATURE_MULTIPLIER=="PIPELINED") &
				     ((decode_rfa_adr_i == ctrl_rfd_adr_i) ||
				      (decode_rfb_adr_i == ctrl_rfd_adr_i));

   assign branch_to_imm = (decode_op_jbr_i &
			   // l.j/l.jal
			   (!(|decode_opc_insn_i[2:1]) |
			    // l.bf/bnf and flag is right
			    (decode_opc_insn_i[2] == predicted_flag_i)));

   assign branch_to_imm_target = pc_decode_i + {{4{decode_immjbr_upper_i[9]}},
						decode_immjbr_upper_i,
						decode_imm16_i,2'b00};
   assign branch_to_reg = decode_op_jr_i &
			  !(ctrl_to_decode_interlock |
			    execute_rf_wb_o &
			    (decode_rfb_adr_i == execute_rfd_adr_o));

   assign decode_branch_o = (branch_to_imm | branch_to_reg) &
			    !pipeline_flush_i;

   assign decode_branch_target_o = branch_to_imm ?
				   branch_to_imm_target :
				   // If a bubble have been pushed out to get
				   // the instruction that will write the
				   // branch target to control stage, then we
				   // need to use the register result from
				   // execute stage instead of decode stage.
				   execute_bubble_o | execute_op_jr_o ?
				   execute_rfb_i : decode_rfb_i;

   assign decode_except_ibus_align = decode_branch_o &
				     (|decode_branch_target_o[1:0]);

   assign next_pc_after_branch_insn = FEATURE_DELAY_SLOT == "ENABLED" ?
				      pc_decode_i + 8 : pc_decode_i + 4;

   assign decode_mispredict_target = decode_op_bf_i & !predicted_flag_i |
				     decode_op_bnf_i & predicted_flag_i ?
				     branch_to_imm_target :
				     next_pc_after_branch_insn;

   // Forward branch prediction signals to execute stage
   always @(posedge clk)
     if (padv_i & decode_op_brcond_i)
       execute_mispredict_target_o <= decode_mispredict_target;

   always @(posedge clk)
     if (padv_i & decode_op_brcond_i)
       execute_predicted_flag_o <= predicted_flag_i;

   // Calculate the link register result
   // TODO: investigate if the ALU adder can be used for this without
   // introducing critical paths
   always @(posedge clk)
     if (padv_i)
       execute_jal_result_o <= next_pc_after_branch_insn;

   // Detect the situation where there is an instruction in execute stage
   // that will produce it's result in control stage (i.e. load and mfspr),
   // and an instruction currently in decode stage needing it's result as
   // input in execute stage.
   // Also detect the situation where there is a jump to register in decode
   // stage and an instruction in execute stage that will write to that
   // register.
   //
   // A bubble is also inserted when an rfe instruction is in decode stage,
   // the main purpose of this is to stall fetch while the rfe is propagating
   // up to ctrl stage.

   assign decode_bubble_o = (
			     // load/mfspr/mul
			     (execute_op_lsu_load_o | execute_op_mfspr_o |
			      execute_op_mul_o &
			      FEATURE_MULTIPLIER=="PIPELINED") &
			     (decode_rfa_adr_i == execute_rfd_adr_o ||
			      decode_rfb_adr_i == execute_rfd_adr_o) |
			     // mul
			     FEATURE_MULTIPLIER=="PIPELINED" &
			     (decode_op_mul_i &
			      (ctrl_to_decode_interlock |
			       execute_rf_wb_o &
			       (decode_rfa_adr_i == execute_rfd_adr_o ||
				decode_rfb_adr_i == execute_rfd_adr_o))) |
			     // jr
			     decode_op_jr_i &
			     (ctrl_to_decode_interlock |
			      execute_rf_wb_o &
			      (decode_rfb_adr_i == execute_rfd_adr_o)) |
			     // atomic store
			     execute_op_lsu_store_o & execute_op_lsu_atomic_o |
			     // rfe
			     decode_op_rfe_i
			     ) & padv_i;

   always @(posedge clk `OR_ASYNC_RST)
     if (rst)
       execute_bubble_o <= 0;
     else if (pipeline_flush_i)
       execute_bubble_o <= 0;
     else if (padv_i)
       execute_bubble_o <= decode_bubble_o;

endmodule // mor1kx_decode_execute_cappuccino

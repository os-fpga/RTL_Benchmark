/*
 *-----------------------------------------------------------------------------
 *     Copyright (C) 2015 by Dolphin Technology
 *     All right reserved.
 *
 *     Copyright Notification
 *     No part may be reproduced except as authorized by written permission.
 *
 *     Module/Class: dti_phy_defines.svh
 *     Project     : DTI_
 *     Author      : Toan Tran
 *     Created     : 2015-12-18 09:44:52
 *     Description :
 *
 *     @Last Modified by:   toan
 *     @Last Modified time: 2016-01-23 10:55:53
 *-----------------------------------------------------------------------------
 */

`define CFG_PHY_GEAR_RATIO          2                     //  DFI freq ratio mode support. 1: Matching, 2: Matching and 1:2 mode, 4: Matching + 1:2 mode + 1:4 mode
`define CFG_PHY_SLICE_NUM           8                     //  Number of PHY data slice
`define CFG_PHY_SLICE_WIDTH         8                     //  Number of bit in each data slice
`define CFG_PHY_RANK_NUM            2                     //  Number of support rank


`define CFG_PHY_CLK_WIDTH           2                     //  Clock bus width
`define CFG_PHY_ADDR_WIDTH          19                    //  Address bus width
`define CFG_PHY_BG_WIDTH            2                     //  BG bus width
`define CFG_PHY_BA_WIDTH            2                     //  BA bus width

`define CFG_DRAM_BG_NUM             4                     //  Number of bank group
`define CFG_DRAM_BG_WIDTH           2                     //  Bank Group bus width
`define CFG_DRAM_BANK_WIDTH         2                     //  Bank address bus width
`define CFG_DRAM_ROW_WIDTH          16                    //  Row address bus width
`define CFG_DRAM_COL_WIDTH          10                    //  Column address bus width
`define CFG_DRAM_ADDR_WIDTH         19                    //  Address bus width
`define CFG_DRAM_LEN_WIDTH          2                     //  DRAM burst length width: use 3 for BL16 support
`define CFG_DRAM_CTRL_WIDTH         2                     //  DRAM control bus width

`define CFG_MC_CMD_WIDTH            5                     //  MC command bus width
`define CFG_DRAM_CMD_WIDTH          6                     //  DRAM command bus width
`define CFG_DRAM_MROP_WIDTH         8                     //  LPDDR4 Mode Register Opcode Width

`define CFG_PHY_DLL_STEP            128
`define CFG_PHY_GATE_DLY_WIDTH      6                     //  Gate training delay width
`define CFG_GTPH_WIDTH              4                     //  Width of GTPH bus not include 2 LSB bits
`define CFG_HOLD_WIDTH              2                     //  Width of GTPH bus not include 2 LSB bits
`define CFG_PHY_RDLVL_DLY_WIDTH     8                     //  Data-eye training delay width
`define CFG_PHY_WRLVL_DLY_WIDTH     8                     //  Write leveling delay width
`define CFG_PHY_WRLVL_RESP_WIDTH    8                     //  Write leveling response width
`define CFG_PHY_VREF_WIDTH          6                     //  VREF bus width
`define CFG_PHY_CMD_DLY_WIDTH       6
`define CFG_PHY_DQ_TRANS            6
`define CFG_PHY_DQEYE_WIDTH         6
`define CFG_PHY_WDQ_DLY_WIDTH       8
`define CFG_PHY_WDM_DLY_WIDTH       8

`define CFG_DDR_TYPE_WIDTH          3
`define CFG_DDR_MR_WIDTH            18                    // DDR4/DDR3 Mode Register Width

`define CFG_DLL_LIM_WIDTH           5
`define CFG_DLL_BYPC_WIDTH          8
`define CFG_CLK_DLY_WIDTH           6
`define CFG_COUNTER_WIDTH           8
`define CFG_WIDE_COUNTER_WIDTH      22
`define CFG_DATAEN_REG_WIDTH        6
`define CFG_DATAEN_SHIFT_WIDTH      64

`define CFG_ODT_COUNT_WIDTH         8

`ifdef  SIM
  `define   CLKQ_DLY  #50ps
`else
  `define   CLKQ_DLY
`endif

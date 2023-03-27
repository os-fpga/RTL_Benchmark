/*
 *-----------------------------------------------------------------------------
 *     Copyright (C) 2022 by Dolphin Technology
 *     All right reserved.
 *
 *     Copyright Notification
 *     No part may be reproduced except as authorized by written permission.
 *
 *     Module/Class: dti_mode_ctrl_map
 *     Project     : dynamo_rps
 *     Author      : tung
 *     Created     : 2022-05-22
 *     Description :
 *-----------------------------------------------------------------------------
 */
`include "dti_global_defines.vh"

module dti_mode_ctrl_map
#(
  parameter FREQUENCY_RATIO       = `CFG_FREQUENCY_RATIO    ,
  parameter PHY_CA_WIDTH          = `CFG_PHY_CA_WIDTH       ,
  parameter DRAM_BA_WIDTH         = `CFG_DRAM_BA_WIDTH      ,
  parameter CHAN_RANK_NUM         = `CFG_CHAN_RANK_NUM      ,
  parameter DRAM_LP3_CA_WIDTH     = `CFG_DRAM_LP3_CA_WIDTH  ,
  parameter DRAM_LP4_CA_WIDTH     = `CFG_DRAM_LP4_CA_WIDTH  ,
  parameter PHY_SLICE_NUM         = `CFG_PHY_SLICE_NUM      ,
  parameter PHY_CALVL_SET_WIDTH   = `CFG_PHY_CALVL_SET_WIDTH,
  parameter CLK_DLY_WIDTH         = `CFG_CLK_DLY_WIDTH      ,
  parameter PHY_CTRL_WIDTH        = `CFG_PHY_CTRL_WIDTH     ,
  parameter DRAM_CHAN_NUM         = `CFG_DRAM_CHAN_NUM      ,
  parameter PHY_CALVL_DLY_WIDTH   = `CFG_PHY_CALVL_DLY_WIDTH,
  parameter PHY_CSLVL_DLY_WIDTH   = `CFG_PHY_CSLVL_DLY_WIDTH,
  parameter PHY_CMD_DLY_WIDTH     = `CFG_PHY_CMD_DLY_WIDTH  ,
  parameter PHY_CA_SET_WIDTH      = `CFG_PHY_CA_SET_WIDTH   ,
  parameter DLL_BYPC_WIDTH        = `CFG_DLL_BYPC_WIDTH     ,
  parameter DLL_LIM_WIDTH         = `CFG_DLL_LIM_WIDTH      ,
  parameter PHY_VREF_WIDTH        = `CFG_PHY_VREF_WIDTH
)
(
  // Configuration (After Sync)
  input                                                                     reg_lpddr4_en,
  input                                                                     reg_lpddr3_en,
  input                                                                     reg_ddr4_en,
  input                                                                     reg_ddr3_en,
  input                                                                     reg_dual_rank_en,
  input                                                                     reg_dual_chan_en,
  input             [PHY_SLICE_NUM-1 : 0]                                   DTI_DATA_BYTE_DISABLE,

  input             [DRAM_CHAN_NUM-1 : 0]                                   DTI_RESET_N_INT,
  input             [DRAM_CHAN_NUM*CHAN_RANK_NUM-1 : 0]                     DTI_CKE_INT,
  input             [DRAM_CHAN_NUM*CHAN_RANK_NUM-1 : 0]                     DTI_CS_INT,
  input             [DRAM_CHAN_NUM*PHY_CA_WIDTH-1 : 0]                      DTI_CA_INT,
  input             [DRAM_CHAN_NUM*DRAM_LP3_CA_WIDTH-1 : 0]                 DTI_CA_L_INT,
  input             [DRAM_CHAN_NUM*DRAM_BA_WIDTH-1 : 0]                     DTI_BA_INT,
  input             [DRAM_CHAN_NUM-1 : 0]                                   DTI_ACT_N_INT,
  input             [DRAM_CHAN_NUM-1 : 0]                                   DTI_ODT_INT,
  input             [DRAM_CHAN_NUM-1 : 0]                                   DTI_RANK_INT,

  output logic                                                              WDATA_ACT_N,
  output logic      [17 : 0]                                                WDATA_CA,
  output logic      [3  : 0]                                                WDATA_CKE,
  output logic      [3  : 0]                                                WDATA_CS,
  output logic      [9  : 0]                                                WDATA_L_CA,
  output logic      [1  : 0]                                                WDATA_ODT,
  output logic                                                              WDATA_RESET_N,
  output                                                                    DTI_RANK_A,
  output                                                                    DTI_RANK_B,

  input             [DRAM_CHAN_NUM*PHY_CA_WIDTH*PHY_CALVL_DLY_WIDTH-1 : 0]  DTI_CALVL_DLY_SYNC,
  input             [DRAM_CHAN_NUM*CHAN_RANK_NUM*PHY_CSLVL_DLY_WIDTH-1 : 0] DTI_CSLVL_DLY_SYNC,
  input             [DRAM_CHAN_NUM*CHAN_RANK_NUM*PHY_CMD_DLY_WIDTH-1 : 0]   CKE_DLY_SYNC,
  input             [DRAM_CHAN_NUM*PHY_CMD_DLY_WIDTH-1 : 0]                 ODT_DLY_SYNC,
  input             [DRAM_CHAN_NUM*PHY_CMD_DLY_WIDTH-1 : 0]                 RESET_N_DLY_SYNC,
  input             [DRAM_CHAN_NUM*PHY_CMD_DLY_WIDTH-1 : 0]                 ACTN_DLY_SYNC,
  input             [DRAM_CHAN_NUM*DRAM_BA_WIDTH*PHY_CMD_DLY_WIDTH-1 : 0]   BA_DLY_SYNC,
  input             [DRAM_CHAN_NUM*CLK_DLY_WIDTH-1 : 0]                     CLK_DLY_SYNC,

  output logic      [6  : 0]                                                ACT_N_DLY,
  output logic      [6  : 0]                                                CKE0_DLY,
  output logic      [6  : 0]                                                CKE1_DLY,
  output logic      [6  : 0]                                                CKE2_DLY,
  output logic      [6  : 0]                                                CKE3_DLY,
  output logic      [125: 0]                                                DTI_CALVL_DLY,
  output logic      [27 : 0]                                                DTI_CSLVL_DLY,
  output logic      [6  : 0]                                                ODT0_DLY,
  output logic      [6  : 0]                                                ODT1_DLY,
  output logic      [6  : 0]                                                RESET_N_DLY,
  output            [CLK_DLY_WIDTH-1 : 0]                                   CLK0_DLY,
  output            [CLK_DLY_WIDTH-1 : 0]                                   CLK1_DLY,

//  input             [3  : 0]                                                CSLVL_STATUS,
//  output            [DRAM_CHAN_NUM*CHAN_RANK_NUM-1 : 0]                     DTI_CSLVL_STATUS,

  input             [DRAM_CHAN_NUM-1 : 0]                                   DTI_CALVL_LOAD_INT,
  input             [DRAM_CHAN_NUM-1 : 0]                                   DTI_CALVL_CAPTURE_INT,
  input             [DRAM_CHAN_NUM-1 : 0]                                   DTI_CMDDLY_LOAD_INT,

  output                                                                    DTI_CALVL_CAPTURE,
  output                                                                    DTI_CALVL_LOAD,
  output                                                                    DTI_CMDDLY_LOAD,

  input             [DRAM_CHAN_NUM-1 : 0]                                   DTI_RN_CALVL_SYNC,
  output                                                                    RN_CALVL,

  input                                                                     DTI_CALVL_RESULT,
  input                                                                     DTI_CALVL_RESULT_B,
  output            [DRAM_CHAN_NUM-1 : 0]                                   DTI_CALVL_RESULT_SYNC,

  input             [DRAM_CHAN_NUM-1 : 0]                                   DTI_CALVL_CTRL_EN_SYNC,
  output                                                                    DTI_CALVL_CTRL_EN,

  input             [23 : 0]                                                    CALVL_STATUS,
  output            [DRAM_CHAN_NUM*PHY_CA_SET_WIDTH*CHAN_RANK_NUM-1 : 0]        DTI_CALVL_STATUS_SYNC,

  input             [83 : 0]                                                    R0_CALVL_SET,
  input             [83 : 0]                                                    R1_CALVL_SET,
  output            [DRAM_CHAN_NUM*PHY_CA_SET_WIDTH*PHY_CALVL_SET_WIDTH-1 : 0]  DTI_R0_CALVL_SET_SYNC,
  output            [DRAM_CHAN_NUM*PHY_CA_SET_WIDTH*PHY_CALVL_SET_WIDTH-1 : 0]  DTI_R1_CALVL_SET_SYNC,

  input             [DRAM_CHAN_NUM-1 : 0]                                   DTI_INIT_COMPLETE_CA_SYNC,
  output                                                                    DTI_INIT_COMPLETE_CA,

  input             [DRAM_CHAN_NUM-1 : 0]                                   LP_EN_REG_PBCR_CTL_SYNC,
  output                                                                    LP_EN_CTL,

  input             [DRAM_CHAN_NUM-1 : 0]                                   E_CMOS_CTL_SYNC,
  output                                                                    E_CMOS_CTL,

  input             [DRAM_CHAN_NUM*3-1 : 0]                                 DRVSEL_CTL_SYNC,
  output            [2 : 0]                                                 DRVSEL_CTL,

  input             [DRAM_CHAN_NUM*DLL_BYPC_WIDTH-1 : 0]                    BYPC_CTL_SYNC,
  input             [DRAM_CHAN_NUM-1 : 0]                                   BYP_CTL_SYNC,
  output            [DLL_BYPC_WIDTH-1 : 0]                                  BYPC_CTL,
  output                                                                    BYP_CTL,

  input             [DRAM_CHAN_NUM-1 : 0]                                   DLL_EN_CTL_SYNC,
  input             [DRAM_CHAN_NUM-1 : 0]                                   DLL_RESET_CTL_SYNC,
  input             [DRAM_CHAN_NUM-1 : 0]                                   DLL_UPDT_EN_CTL_SYNC,
  output                                                                    DLL_EN_CTL,
  output                                                                    DLL_RESET_CTL,
  output                                                                    DLL_UPDT_EN_CTL,

  input             [DRAM_CHAN_NUM*DLL_LIM_WIDTH-1 : 0]                     LIMIT_CTL_SYNC,
  output            [DRAM_CHAN_NUM-1 : 0]                                   LOCK_CTL_SYNC,
  output            [DRAM_CHAN_NUM-1 : 0]                                   OVFL_CTL_SYNC,
  output            [DRAM_CHAN_NUM-1 : 0]                                   UNFL_CTL_SYNC,
  output            [DLL_LIM_WIDTH-1 : 0]                                   LIMIT_CTL,
  input                                                                     LOCK_CTL,
  input                                                                     OVFL_CTL,
  input                                                                     UNFL_CTL,

  input             [DRAM_CHAN_NUM-1:0]                                     DTI_VREF_EN_CTL_SYNC,
  input             [DRAM_CHAN_NUM*PHY_VREF_WIDTH-1 : 0]                    DTI_VREF_SET_CTL_SYNC,
  output                                                                    DTI_VREF_EN_CTL, 
  output            [PHY_VREF_WIDTH-1 : 0]                                  DTI_VREF_SET_CTL

);

wire  [DRAM_CHAN_NUM-1 : 0]                                                 DTI_RESET_N_TMP;
wire  [DRAM_CHAN_NUM-1 : 0][CHAN_RANK_NUM-1 : 0]                            DTI_CKE_TMP;
wire  [DRAM_CHAN_NUM-1 : 0][CHAN_RANK_NUM-1 : 0]                            DTI_CS_TMP;
wire  [DRAM_CHAN_NUM-1 : 0][PHY_CA_WIDTH-1 : 0]                             DTI_CA_TMP;
wire  [DRAM_CHAN_NUM-1 : 0][DRAM_LP3_CA_WIDTH-1 : 0]                        DTI_CA_L_TMP;
wire  [DRAM_CHAN_NUM-1 : 0][DRAM_BA_WIDTH-1 : 0]                            DTI_BA_TMP;
wire  [DRAM_CHAN_NUM-1 : 0]                                                 DTI_ACT_N_TMP;
wire  [DRAM_CHAN_NUM-1 : 0]                                                 DTI_ODT_TMP;
wire  [DRAM_CHAN_NUM-1 : 0]                                                 DTI_RANK_TMP;

wire  [DRAM_CHAN_NUM-1 : 0][PHY_CA_WIDTH-1 : 0][PHY_CALVL_DLY_WIDTH-1 : 0]  DTI_CALVL_DLY_TMP;
wire  [DRAM_CHAN_NUM-1 : 0][CHAN_RANK_NUM-1 : 0][PHY_CSLVL_DLY_WIDTH-1 : 0] DTI_CSLVL_DLY_TMP;
wire  [DRAM_CHAN_NUM-1 : 0][CHAN_RANK_NUM-1 : 0][PHY_CMD_DLY_WIDTH-1 : 0]   CKE_DLY_TMP;
wire  [DRAM_CHAN_NUM-1 : 0][PHY_CMD_DLY_WIDTH-1 : 0]                        ODT_DLY_TMP;
wire  [DRAM_CHAN_NUM-1 : 0][PHY_CMD_DLY_WIDTH-1 : 0]                        RESET_N_DLY_TMP;
wire  [DRAM_CHAN_NUM-1 : 0][PHY_CMD_DLY_WIDTH-1 : 0]                        ACTN_DLY_TMP;
wire  [DRAM_CHAN_NUM-1 : 0][DRAM_BA_WIDTH-1 : 0][PHY_CMD_DLY_WIDTH-1 : 0]   BA_DLY_TMP;

// wire  [DRAM_CHAN_NUM-1 : 0][CHAN_RANK_NUM-1 : 0]                            DTI_CSLVL_STATUS_TMP;

logic [DRAM_CHAN_NUM-1 : 0][PHY_CA_SET_WIDTH*CHAN_RANK_NUM-1 : 0]           DTI_CALVL_STATUS_SYNC_TMP;

logic [DRAM_CHAN_NUM-1 : 0][PHY_CA_SET_WIDTH-1 : 0] [PHY_CALVL_SET_WIDTH-1 : 0] DTI_R0_CALVL_SET_SYNC_TMP;
logic [DRAM_CHAN_NUM-1 : 0][PHY_CA_SET_WIDTH-1 : 0] [PHY_CALVL_SET_WIDTH-1 : 0] DTI_R1_CALVL_SET_SYNC_TMP;

//===================================================================================================
// Command Address
//===================================================================================================
assign DTI_RESET_N_TMP    = DTI_RESET_N_INT;
assign DTI_CKE_TMP        = DTI_CKE_INT;
assign DTI_CS_TMP         = DTI_CS_INT;
assign DTI_CA_TMP         = DTI_CA_INT;
assign DTI_CA_L_TMP       = DTI_CA_L_INT;
assign DTI_BA_TMP         = DTI_BA_INT;
assign DTI_ACT_N_TMP      = DTI_ACT_N_INT;
assign DTI_ODT_TMP        = DTI_ODT_INT;
assign DTI_RANK_TMP       = DTI_RANK_INT;

assign {DTI_RANK_B, DTI_RANK_A}   = reg_lpddr4_en ? DTI_RANK_TMP : {DRAM_CHAN_NUM{DTI_RANK_TMP[0]}};

always_comb begin
  case (1'b1)
    // LPDDR4 - 2x16
    reg_lpddr4_en & reg_dual_chan_en: begin
      WDATA_ACT_N   = 1'b1;                                               // Unused
      WDATA_CA      = { 6'h00,                                            // Unused
                        DTI_CA_TMP[1][5:0],                               // Channel B
                        DTI_CA_TMP[0][5:0]                                // Channel A
                      };
      WDATA_CKE     = DTI_CKE_TMP;                                        // 2 channels, 2 ranks
      WDATA_CS      = DTI_CS_TMP;                                         // 2 channels, 2 ranks
      WDATA_L_CA    = 0;                                                  // Unused
      WDATA_ODT     = DTI_ODT_TMP;                                        // 2 channels
      WDATA_RESET_N = DTI_RESET_N_TMP[0];                                 // Use 1 reset_n for both channels
    end
    // LPDDR4 - x16
    reg_lpddr4_en & (~reg_dual_chan_en) & (|DTI_DATA_BYTE_DISABLE): begin
      WDATA_ACT_N   = 1'b1;                                               // Unused
      WDATA_CA      = { 6'h00,                                            // Unused
                        6'h00,                                            // Unused
                        DTI_CA_TMP[0][5:0]                                // Channel A
                      };
      WDATA_CKE     = {2'b00, DTI_CKE_TMP[0]};                            // Channe A ONLY, 2 ranks
      WDATA_CS      = {2'b00, DTI_CS_TMP[0]};                             // Channe A ONLY, 2 ranks
      WDATA_L_CA    = 0;                                                  // Unused
      WDATA_ODT     = {1'b0, DTI_ODT_TMP[0]};                             // Channe A ONLY
      WDATA_RESET_N = DTI_RESET_N_TMP[0];                                 // Use 1 reset_n
    end
    // LPDDR4 - x32 - Merge 2 channels into 1
    reg_lpddr4_en & (~reg_dual_chan_en) & (~|DTI_DATA_BYTE_DISABLE): begin
      WDATA_ACT_N   = 1'b1;                                               // Unused
      WDATA_CA      = { 6'h00,                                            // Unused
                        DTI_CA_TMP[0][5:0],                               // Channel A is coppied to Channel B
                        DTI_CA_TMP[0][5:0]                                // Channel A
                      };
      WDATA_CKE     = {2{DTI_CKE_TMP[0]}};                                // Channel A is coppied to Channel B
      WDATA_CS      = {2{DTI_CS_TMP[0]}};                                 // Channel A is coppied to Channel B
      WDATA_L_CA    = 0;                                                  // Unused
      WDATA_ODT     = {2{DTI_ODT_TMP[0]}};                                // Channel A is coppied to Channel B
      WDATA_RESET_N = DTI_RESET_N_TMP[0];                                 // Use 1 reset_n for both channels
    end
    // LPDDR3 - x16 x32
    reg_lpddr3_en: begin
      WDATA_ACT_N   = 1'b1;                                               // Unused
      WDATA_CA      = { 8'h00,                                            // Unused
                        DTI_CA_TMP[0][9:0]                                // Channel A - CA_H
                      };
      WDATA_CKE     = {2'b00, DTI_CKE_TMP[0]};                            // Channe A ONLY, 2 ranks
      WDATA_CS      = {2'b00, DTI_CS_TMP[0]};                             // Channe A ONLY, 2 ranks
      WDATA_L_CA    = DTI_CA_L_TMP[0];                                    // Channel A - CA_L
      WDATA_ODT     = {1'b0, DTI_ODT_TMP[0]};                             // Channe A ONLY
      WDATA_RESET_N = 1'b1;                                               // Unused
    end
    // DDR4 - x16 x32
    reg_ddr4_en: begin
      WDATA_ACT_N   = DTI_ACT_N_TMP[0];                                   // Channel A ONLY, ACT_N
      WDATA_CA      = DTI_CA_TMP[0][17:0];                                // Channel A ONLY, ADDRESS
      WDATA_CKE     = { DTI_BA_TMP[0][3:2],                               // Channel A, Bank Group Address
                        DTI_CKE_TMP[0]                                    // Channel A ONLY, CKE 2 ranks
                      };
      WDATA_CS      = { DTI_BA_TMP[0][1:0],                               // Channel A ONLY, Bank Address
                        DTI_CS_TMP[0]                                     // Channe A ONLY, CS 2 ranks
                      };
      WDATA_L_CA    = 0;                                                  // Unused
      WDATA_ODT     = {1'b0, DTI_ODT_TMP[0]};                             // Channe A ONLY
      WDATA_RESET_N = DTI_RESET_N_TMP[0];                                 // Channe A ONLY
    end
    // DDR3 - x16 x32
    reg_ddr3_en: begin
      WDATA_ACT_N   = DTI_CA_TMP[0][18];                                  // Channel A ONLY, RAS_N
      WDATA_CA      = DTI_CA_TMP[0][17:0];                                // Channel A ONLY, CAS_N, WE_N, ADDRESS[15:0]
      WDATA_CKE     = { 1'b0,                                             // Unused
                        DTI_BA_TMP[0][2],                                 // Channel A, Bank Address[2]
                        DTI_CKE_TMP[0]                                    // Channel A ONLY, CKE 2 ranks
                      };
      WDATA_CS      = { DTI_BA_TMP[0][1:0],                               // Channel A ONLY, Bank Address[1:0]
                        DTI_CS_TMP[0]                                     // Channe A ONLY, CS 2 ranks
                      };
      WDATA_L_CA    = 0;                                                  // Unused
      WDATA_ODT     = {1'b0, DTI_ODT_TMP[0]};                             // Channe A ONLY
      WDATA_RESET_N = DTI_RESET_N_TMP[0];                                 // Channe A ONLY
    end
    default: begin
      WDATA_ACT_N   = 1'b1;
      WDATA_CA      = 0;
      WDATA_CKE     = 0;
      WDATA_CS      = 0;
      WDATA_L_CA    = 0;
      WDATA_ODT     = 0;
      WDATA_RESET_N = 1'b1;
    end
  endcase
end

//===================================================================================================
// Command Delay
//===================================================================================================
assign DTI_CALVL_DLY_TMP  = DTI_CALVL_DLY_SYNC;
assign DTI_CSLVL_DLY_TMP  = DTI_CSLVL_DLY_SYNC;
assign CKE_DLY_TMP        = CKE_DLY_SYNC;
assign ODT_DLY_TMP        = ODT_DLY_SYNC;
assign RESET_N_DLY_TMP    = RESET_N_DLY_SYNC;
assign ACTN_DLY_TMP       = ACTN_DLY_SYNC;
assign BA_DLY_TMP         = BA_DLY_SYNC;
assign {CLK1_DLY,
        CLK0_DLY }        = CLK_DLY_SYNC;

always_comb begin
  case (1'b1)
    // LPDDR4 - 2x16
    reg_lpddr4_en & reg_dual_chan_en: begin
      ACT_N_DLY     = 0;                                                  // Unused
      CKE0_DLY      = CKE_DLY_TMP[0][0];                                  // Channel A, Rank 0
      CKE1_DLY      = CKE_DLY_TMP[0][1];                                  // Channel A, Rank 1
      CKE2_DLY      = CKE_DLY_TMP[1][0];                                  // Channel B, Rank 0
      CKE3_DLY      = CKE_DLY_TMP[1][1];                                  // Channel B, Rank 1
      DTI_CALVL_DLY = { 42'h0,                                            // Unused
                        DTI_CALVL_DLY_TMP[1][5:0],                        // Channel B
                        DTI_CALVL_DLY_TMP[0][5:0]                         // Channel A
                      };
      DTI_CSLVL_DLY = DTI_CSLVL_DLY_TMP;                                  // 2 channels, 2 ranks
      ODT0_DLY      = ODT_DLY_TMP[0];                                     // Channel A
      ODT1_DLY      = ODT_DLY_TMP[1];                                     // Channel B
      RESET_N_DLY   = RESET_N_DLY_TMP[0];                                 // Use 1 reset_n for both channels
    end
    // LPDDR4 - x16
    reg_lpddr4_en & (~reg_dual_chan_en) & (|DTI_DATA_BYTE_DISABLE): begin
      ACT_N_DLY     = 0;                                                  // Unused
      CKE0_DLY      = CKE_DLY_TMP[0][0];                                  // Channel A, Rank 0
      CKE1_DLY      = CKE_DLY_TMP[0][1];                                  // Channel A, Rank 1
      CKE2_DLY      = 0;                                                  // Unused
      CKE3_DLY      = 0;                                                  // Unused
      DTI_CALVL_DLY = { 42'h0,                                            // Unused
                        42'h0,                                            // Unused
                        DTI_CALVL_DLY_TMP[0][5:0]                         // Channel A
                      };
      DTI_CSLVL_DLY = { 14'h0,                                            // Unused
                        DTI_CSLVL_DLY_TMP[0]                              // Channel A, 2 ranks
                      };
      ODT0_DLY      = ODT_DLY_TMP[0];                                     // Channel A
      ODT1_DLY      = 0;                                                  // Unused
      RESET_N_DLY   = RESET_N_DLY_TMP[0];                                 // Use 1 reset_n
    end
    // LPDDR4 - x32 - Merge 2 channels into 1
    reg_lpddr4_en & (~reg_dual_chan_en) & (~|DTI_DATA_BYTE_DISABLE): begin
      ACT_N_DLY     = 0;                                                  // Unused
      CKE0_DLY      = CKE_DLY_TMP[0][0];                                  // Channel A, Rank 0
      CKE1_DLY      = CKE_DLY_TMP[0][1];                                  // Channel A, Rank 1
      CKE2_DLY      = CKE_DLY_TMP[1][0];                                  // Channel B, Rank 0
      CKE3_DLY      = CKE_DLY_TMP[1][1];                                  // Channel B, Rank 1
      DTI_CALVL_DLY = { 42'h0,                                            // Unused
                        DTI_CALVL_DLY_TMP[1][5:0],                        // Channel B
                        DTI_CALVL_DLY_TMP[0][5:0]                         // Channel A
                      };
      DTI_CSLVL_DLY = DTI_CSLVL_DLY_TMP;                                  // 2 channels, 2 ranks
      ODT0_DLY      = ODT_DLY_TMP[0];                                     // Channel A
      ODT1_DLY      = ODT_DLY_TMP[1];                                     // Channel B
      RESET_N_DLY   = RESET_N_DLY_TMP[0];                                 // Use 1 reset_n for both channels
    end
    // LPDDR3 - x16 x32
    reg_lpddr3_en: begin
      ACT_N_DLY     = 0;                                                  // Unused
      CKE0_DLY      = CKE_DLY_TMP[0][0];                                  // Channel A, Rank 0
      CKE1_DLY      = CKE_DLY_TMP[0][1];                                  // Channel A, Rank 1
      CKE2_DLY      = 0;                                                  // Unused
      CKE3_DLY      = 0;                                                  // Unused
      DTI_CALVL_DLY = { 56'h0,                                            // Unused
                        DTI_CALVL_DLY_TMP[0][9:0]                         // Channel A
                      };
      DTI_CSLVL_DLY = { 14'h0,                                            // Unused
                        DTI_CSLVL_DLY_TMP[0]                              // Channel A, 2 ranks
                      };
      ODT0_DLY      = ODT_DLY_TMP[0];                                     // Channel A
      ODT1_DLY      = 0;                                                  // Unused
      RESET_N_DLY   = 0;                                                  // Unused
    end
    // DDR4 - x16 x32
    reg_ddr4_en: begin
      ACT_N_DLY     = ACTN_DLY_TMP[0];                                    // Channel A
      CKE0_DLY      = CKE_DLY_TMP[0][0];                                  // Channel A, Rank 0
      CKE1_DLY      = CKE_DLY_TMP[0][1];                                  // Channel A, Rank 1
      CKE2_DLY      = BA_DLY_TMP[0][2];                                   // Channel A, Bank Address[2] (Bank Group [0])
      CKE3_DLY      = BA_DLY_TMP[0][3];                                   // Channel A, Bank Address[3] (Bank Group [1])
      DTI_CALVL_DLY = DTI_CALVL_DLY_TMP[0][17:0];                         // Channel A, Address
      DTI_CSLVL_DLY = { BA_DLY_TMP[0][1:0],                               // Channel A, Bank Address[1:0]
                        DTI_CSLVL_DLY_TMP[0]                              // Channel A, 2 ranks
                      };
      ODT0_DLY      = ODT_DLY_TMP[0];                                     // Channel A
      ODT1_DLY      = 0;                                                  // Unused
      RESET_N_DLY   = RESET_N_DLY_TMP[0];                                 // Channel A
    end
    // DDR3 - x16 x32
    reg_ddr3_en: begin
      ACT_N_DLY     = DTI_CALVL_DLY_TMP[0][18];                           // Channel A, RAS_N
      CKE0_DLY      = CKE_DLY_TMP[0][0];                                  // Channel A, Rank 0
      CKE1_DLY      = CKE_DLY_TMP[0][1];                                  // Channel A, Rank 1
      CKE2_DLY      = BA_DLY_TMP[0][2];                                   // Channel A, Bank Address[2]
      CKE3_DLY      = 0;                                                  // Unused
      DTI_CALVL_DLY = DTI_CALVL_DLY_TMP[0][17:0];                         // Channel A, CAS_N, WE_N, Address[15:0]
      DTI_CSLVL_DLY = { BA_DLY_TMP[0][1:0],                               // Channel A, Bank Address[1:0]
                        DTI_CSLVL_DLY_TMP[0]                              // Channel A, 2 ranks
                      };
      ODT0_DLY      = ODT_DLY_TMP[0];                                     // Channel A
      ODT1_DLY      = 0;                                                  // Unused
      RESET_N_DLY   = RESET_N_DLY_TMP[0];                                 // Channel A
    end
    default: begin
      ACT_N_DLY     = 0;
      CKE0_DLY      = 0;
      CKE1_DLY      = 0;
      CKE2_DLY      = 0;
      CKE3_DLY      = 0;
      DTI_CALVL_DLY = 0;
      DTI_CSLVL_DLY = 0;
      ODT0_DLY      = 0;
      ODT1_DLY      = 0;
      RESET_N_DLY   = 0;
    end
  endcase
end

//===================================================================================================
// CSLVL STATUS
//===================================================================================================
// assign DTI_CSLVL_STATUS = DTI_CSLVL_STATUS_TMP;
// assign DTI_CSLVL_STATUS_TMP[0][0] = CSLVL_STATUS[0];
// assign DTI_CSLVL_STATUS_TMP[0][1] = CSLVL_STATUS[2];
// assign DTI_CSLVL_STATUS_TMP[1][0] = CSLVL_STATUS[1];
// assign DTI_CSLVL_STATUS_TMP[1][1] = CSLVL_STATUS[3];

//===================================================================================================
// CALVL STATUS/SET
//===================================================================================================
assign DTI_CALVL_STATUS_SYNC  = DTI_CALVL_STATUS_SYNC_TMP;

assign DTI_R0_CALVL_SET_SYNC  = DTI_R0_CALVL_SET_SYNC_TMP;
assign DTI_R1_CALVL_SET_SYNC  = DTI_R1_CALVL_SET_SYNC_TMP;

always_comb begin
  case (reg_lpddr4_en)
    1'b1: begin // LPDDR4
      DTI_CALVL_STATUS_SYNC_TMP[0][11 :  0] = CALVL_STATUS[11 :  0];
      DTI_CALVL_STATUS_SYNC_TMP[0][23 : 12] = 0;
      DTI_CALVL_STATUS_SYNC_TMP[1][11 :  0] = CALVL_STATUS[23 : 12];
      DTI_CALVL_STATUS_SYNC_TMP[1][23 : 12] = 0;

      DTI_R0_CALVL_SET_SYNC_TMP[0][5  :  0] = R0_CALVL_SET[41 :  0];
      DTI_R0_CALVL_SET_SYNC_TMP[0][11 :  6] = 0;
      DTI_R0_CALVL_SET_SYNC_TMP[1][5  :  0] = R0_CALVL_SET[83 : 42];
      DTI_R0_CALVL_SET_SYNC_TMP[1][11 :  6] = 0;

      DTI_R1_CALVL_SET_SYNC_TMP[0][5  :  0] = R1_CALVL_SET[41 :  0];
      DTI_R1_CALVL_SET_SYNC_TMP[0][11 :  6] = 0;
      DTI_R1_CALVL_SET_SYNC_TMP[1][5  :  0] = R1_CALVL_SET[83 : 42];
      DTI_R1_CALVL_SET_SYNC_TMP[1][11 :  6] = 0;
    end
    1'b0: begin // LPDDR3
      DTI_CALVL_STATUS_SYNC_TMP[0][19 :  0] = CALVL_STATUS[19 :  0];
      DTI_CALVL_STATUS_SYNC_TMP[0][23 : 20] = 0;
      DTI_CALVL_STATUS_SYNC_TMP[1]          = 0;

      DTI_R0_CALVL_SET_SYNC_TMP[0][9  :  0] = R0_CALVL_SET[69 :  0];
      DTI_R0_CALVL_SET_SYNC_TMP[0][11 : 10] = 0;
      DTI_R0_CALVL_SET_SYNC_TMP[1]          = 0;

      DTI_R1_CALVL_SET_SYNC_TMP[0][9  :  0] = R1_CALVL_SET[69 :  0];
      DTI_R1_CALVL_SET_SYNC_TMP[0][11 : 10] = 0;
      DTI_R1_CALVL_SET_SYNC_TMP[1]          = 0;
    end
    default: begin
      DTI_CALVL_STATUS_SYNC_TMP = 0;
      DTI_R1_CALVL_SET_SYNC_TMP = 0;
    end
  endcase
end

//===================================================================================================
// CALVL, Command Delay
//===================================================================================================
assign DTI_CALVL_LOAD         = |DTI_CALVL_LOAD_INT;
assign DTI_CALVL_CAPTURE      = |DTI_CALVL_CAPTURE_INT;
assign DTI_CMDDLY_LOAD        = |DTI_CMDDLY_LOAD_INT;
assign RN_CALVL               = &DTI_RN_CALVL_SYNC;
assign DTI_CALVL_RESULT_SYNC  = {DTI_CALVL_RESULT_B, DTI_CALVL_RESULT};
assign DTI_CALVL_CTRL_EN      = |DTI_CALVL_CTRL_EN_SYNC;

//===================================================================================================
// Others
//===================================================================================================
assign DTI_INIT_COMPLETE_CA   = |DTI_INIT_COMPLETE_CA_SYNC;
assign LP_EN_CTL              = LP_EN_REG_PBCR_CTL_SYNC[0];
assign E_CMOS_CTL             = E_CMOS_CTL_SYNC[0];
assign DRVSEL_CTL             = DRVSEL_CTL_SYNC[2 : 0];
assign BYPC_CTL               = BYPC_CTL_SYNC[DLL_BYPC_WIDTH-1 : 0];
assign BYP_CTL                = BYP_CTL_SYNC[0];
assign DLL_EN_CTL             = DLL_EN_CTL_SYNC[0];
assign DLL_RESET_CTL          = DLL_RESET_CTL_SYNC[0];
assign DLL_UPDT_EN_CTL        = DLL_UPDT_EN_CTL_SYNC[0];
assign LIMIT_CTL              = LIMIT_CTL_SYNC[DLL_LIM_WIDTH-1 : 0];
assign LOCK_CTL_SYNC          = {DRAM_CHAN_NUM{LOCK_CTL}};
assign OVFL_CTL_SYNC          = {DRAM_CHAN_NUM{OVFL_CTL}};
assign UNFL_CTL_SYNC          = {DRAM_CHAN_NUM{UNFL_CTL}};
assign DTI_VREF_EN_CTL        = DTI_VREF_EN_CTL_SYNC[0];
assign DTI_VREF_SET_CTL       = DTI_VREF_SET_CTL_SYNC[PHY_VREF_WIDTH-1 : 0];

endmodule
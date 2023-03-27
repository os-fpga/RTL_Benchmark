/*
 *-----------------------------------------------------------------------------
 *     Copyright (C) 2022 by Dolphin Technology
 *     All right reserved.
 *
 *     Copyright Notification
 *     No part may be reproduced except as authorized by written permission.
 *
 *     Module/Class: dti_dfi_map
 *     Project     : dynamo_rps
 *     Author      : tung
 *     Created     : 2022-05-22
 *     Description :
 *-----------------------------------------------------------------------------
 */
`include "dti_global_defines.vh"

module dti_dfi_map
#(
  parameter FREQUENCY_RATIO       = `CFG_FREQUENCY_RATIO    ,
  parameter PHY_CA_WIDTH          = `CFG_PHY_CA_WIDTH       ,
  parameter DRAM_BA_WIDTH         = `CFG_DRAM_BA_WIDTH      ,
  parameter CHAN_RANK_NUM         = `CFG_CHAN_RANK_NUM      ,
  parameter DRAM_LP3_CA_WIDTH     = `CFG_DRAM_LP3_CA_WIDTH  ,
  parameter PHY_SLICE_NUM         = `CFG_PHY_SLICE_NUM      ,
  parameter DFI_SLICE_WIDTH       = `CFG_DFI_SLICE_WIDTH    ,
  parameter AXI4_DATA_WIDTH       = `CFG_AXI4_DATA_WIDTH    ,
  parameter DRAM_CHAN_NUM         = `CFG_DRAM_CHAN_NUM
)
(
  // Configuration
  input                                                                                   reg_dual_chan_en,
  input           [PHY_SLICE_NUM-1 : 0]                                                   DTI_DATA_BYTE_DISABLE,
  
  // Control Signals
  input           [DRAM_CHAN_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_RESET_N_MC,
  input           [DRAM_CHAN_NUM*FREQUENCY_RATIO*CHAN_RANK_NUM-1 : 0]                     DTI_CKE_MC,
  input           [DRAM_CHAN_NUM*FREQUENCY_RATIO*CHAN_RANK_NUM-1 : 0]                     DTI_CS_MC,
  input           [DRAM_CHAN_NUM*FREQUENCY_RATIO*PHY_CA_WIDTH-1 : 0]                      DTI_CA_MC,
  input           [DRAM_CHAN_NUM*FREQUENCY_RATIO*DRAM_LP3_CA_WIDTH-1 : 0]                 DTI_CA_L_MC,
  input           [DRAM_CHAN_NUM*FREQUENCY_RATIO*DRAM_BA_WIDTH-1 : 0]                     DTI_BA_MC,
  input           [DRAM_CHAN_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_ACT_N_MC,
  input           [DRAM_CHAN_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_ODT_MC,
  input           [DRAM_CHAN_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_RANK_MC,

  output          [DRAM_CHAN_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_RESET_N,
  output          [DRAM_CHAN_NUM*CHAN_RANK_NUM*FREQUENCY_RATIO-1 : 0]                     DTI_CKE,
  output          [DRAM_CHAN_NUM*CHAN_RANK_NUM*FREQUENCY_RATIO-1 : 0]                     DTI_CS,
  output          [DRAM_CHAN_NUM*PHY_CA_WIDTH*FREQUENCY_RATIO-1 : 0]                      DTI_CA,
  output          [DRAM_CHAN_NUM*DRAM_LP3_CA_WIDTH*FREQUENCY_RATIO-1 : 0]                 DTI_CA_L,
  output          [DRAM_CHAN_NUM*DRAM_BA_WIDTH*FREQUENCY_RATIO-1 : 0]                     DTI_BA,
  output          [DRAM_CHAN_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_ACT_N,
  output          [DRAM_CHAN_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_ODT,
  output          [DRAM_CHAN_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_RANK,

  // Write Signals
  input           [DRAM_CHAN_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_WRDATA_EN_MC,
  input           [DRAM_CHAN_NUM*AXI4_DATA_WIDTH-1 : 0]                                   DTI_WRDATA_MC,
  input           [DRAM_CHAN_NUM*AXI4_DATA_WIDTH/8-1 : 0]                                 DTI_WRDATA_MASK_MC,
  input           [DRAM_CHAN_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_RANK_WR_MC,

  output          [PHY_SLICE_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_WRDATA_EN,
  output          [PHY_SLICE_NUM*2*DFI_SLICE_WIDTH*FREQUENCY_RATIO-1 : 0]                 DTI_WRDATA,
  output          [PHY_SLICE_NUM*2*FREQUENCY_RATIO-1 : 0]                                 DTI_WRDATA_MASK,
  output          [PHY_SLICE_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_RANK_WR,

  // Read Signals
  input           [DRAM_CHAN_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_RDDATA_EN_MC,
  input           [DRAM_CHAN_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_RANK_RD_MC,
  output          [DRAM_CHAN_NUM*AXI4_DATA_WIDTH-1 : 0]                                   DTI_RDDATA_MC,
  output          [DRAM_CHAN_NUM*AXI4_DATA_WIDTH/8-1 : 0]                                 DTI_RDDATA_MASK_MC,
  output          [DRAM_CHAN_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_RDDATA_VALID_MC,

  output          [PHY_SLICE_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_RDDATA_EN,
  output          [PHY_SLICE_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_RANK_RD,
  input           [PHY_SLICE_NUM*2*DFI_SLICE_WIDTH*FREQUENCY_RATIO-1 : 0]                 DTI_RDDATA,
  input           [PHY_SLICE_NUM*2*FREQUENCY_RATIO-1 : 0]                                 DTI_RDDATA_MASK,
  input           [PHY_SLICE_NUM*FREQUENCY_RATIO-1 : 0]                                   DTI_RDDATA_VALID,

  // PTS
  input           [PHY_SLICE_NUM*CHAN_RANK_NUM-1 : 0]                                     gterr_reg_pts_slice,
  output          [CHAN_RANK_NUM*PHY_SLICE_NUM-1 : 0]                                     gterr_reg_pts,

  input           [PHY_SLICE_NUM*DFI_SLICE_WIDTH*CHAN_RANK_NUM-1 : 0]                     rdlvldqerr_reg_pts_slice,
  output          [CHAN_RANK_NUM*PHY_SLICE_NUM*DFI_SLICE_WIDTH-1 : 0]                     rdlvldqerr_reg_pts,

  input           [PHY_SLICE_NUM*CHAN_RANK_NUM-1 : 0]                                     rdlvldmerr_reg_pts_slice,
  output          [CHAN_RANK_NUM*PHY_SLICE_NUM-1 : 0]                                     rdlvldmerr_reg_pts,

  input           [PHY_SLICE_NUM*CHAN_RANK_NUM-1 : 0]                                     wrlvlerr_reg_pts_slice,
  output          [CHAN_RANK_NUM*PHY_SLICE_NUM-1 : 0]                                     wrlvlerr_reg_pts
);

wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0]                                    DTI_RESET_N_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0][CHAN_RANK_NUM-1 : 0]               DTI_CKE_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0][CHAN_RANK_NUM-1 : 0]               DTI_CS_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0][PHY_CA_WIDTH-1 : 0]                DTI_CA_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0][DRAM_LP3_CA_WIDTH-1 : 0]           DTI_CA_L_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0][DRAM_BA_WIDTH-1 : 0]               DTI_BA_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0]                                    DTI_ACT_N_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0]                                    DTI_ODT_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0]                                    DTI_RANK_MC_INT;

wire      [DRAM_CHAN_NUM-1 : 0]                         [FREQUENCY_RATIO-1 : 0]           DTI_RESET_N_INT;
wire      [DRAM_CHAN_NUM-1 : 0][CHAN_RANK_NUM-1 : 0]    [FREQUENCY_RATIO-1 : 0]           DTI_CKE_INT;
wire      [DRAM_CHAN_NUM-1 : 0][CHAN_RANK_NUM-1 : 0]    [FREQUENCY_RATIO-1 : 0]           DTI_CS_INT;
wire      [DRAM_CHAN_NUM-1 : 0][PHY_CA_WIDTH-1 : 0]     [FREQUENCY_RATIO-1 : 0]           DTI_CA_INT;
wire      [DRAM_CHAN_NUM-1 : 0][DRAM_LP3_CA_WIDTH-1 : 0][FREQUENCY_RATIO-1 : 0]           DTI_CA_L_INT;
wire      [DRAM_CHAN_NUM-1 : 0][DRAM_BA_WIDTH-1 : 0]    [FREQUENCY_RATIO-1 : 0]           DTI_BA_INT;
wire      [DRAM_CHAN_NUM-1 : 0]                         [FREQUENCY_RATIO-1 : 0]           DTI_ACT_N_INT;
wire      [DRAM_CHAN_NUM-1 : 0]                         [FREQUENCY_RATIO-1 : 0]           DTI_ODT_INT;
wire      [DRAM_CHAN_NUM-1 : 0]                         [FREQUENCY_RATIO-1 : 0]           DTI_RANK_INT;

wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0]                                                    DTI_WRDATA_EN_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0][1 : 0][PHY_SLICE_NUM-1 : 0][DFI_SLICE_WIDTH-1 : 0] DTI_WRDATA_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0][1 : 0][PHY_SLICE_NUM-1 : 0]                        DTI_WRDATA_MASK_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0]                                                    DTI_RANK_WR_MC_INT;

wire      [DRAM_CHAN_NUM-1 : 0]                                                   [FREQUENCY_RATIO-1 : 0] DTI_WRDATA_EN_MC_TMP;
wire      [DRAM_CHAN_NUM-1 : 0][PHY_SLICE_NUM-1 : 0][1 : 0][DFI_SLICE_WIDTH-1 : 0][FREQUENCY_RATIO-1 : 0] DTI_WRDATA_MC_TMP;
wire      [DRAM_CHAN_NUM-1 : 0][PHY_SLICE_NUM-1 : 0][1 : 0]                       [FREQUENCY_RATIO-1 : 0] DTI_WRDATA_MASK_MC_TMP;
wire      [DRAM_CHAN_NUM-1 : 0]                                                   [FREQUENCY_RATIO-1 : 0] DTI_RANK_WR_MC_TMP;

logic     [PHY_SLICE_NUM-1 : 0]                              [FREQUENCY_RATIO-1 : 0] DTI_WRDATA_EN_INT;
logic     [PHY_SLICE_NUM-1 : 0][1 : 0][DFI_SLICE_WIDTH-1 : 0][FREQUENCY_RATIO-1 : 0] DTI_WRDATA_INT;
logic     [PHY_SLICE_NUM-1 : 0][1 : 0]                       [FREQUENCY_RATIO-1 : 0] DTI_WRDATA_MASK_INT;
logic     [PHY_SLICE_NUM-1 : 0]                              [FREQUENCY_RATIO-1 : 0] DTI_RANK_WR_INT;

wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0]                                                    DTI_RDDATA_EN_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0]                                                    DTI_RANK_RD_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0][1 : 0][PHY_SLICE_NUM-1 : 0][DFI_SLICE_WIDTH-1 : 0] DTI_RDDATA_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0][1 : 0][PHY_SLICE_NUM-1 : 0]                        DTI_RDDATA_MASK_MC_INT;
wire      [DRAM_CHAN_NUM-1 : 0][FREQUENCY_RATIO-1 : 0]                                                    DTI_RDDATA_VALID_MC_INT;


logic     [DRAM_CHAN_NUM-1 : 0]                                                   [FREQUENCY_RATIO-1 : 0] DTI_RDDATA_EN_MC_TMP;
logic     [DRAM_CHAN_NUM-1 : 0]                                                   [FREQUENCY_RATIO-1 : 0] DTI_RANK_RD_MC_TMP;
logic     [DRAM_CHAN_NUM-1 : 0][PHY_SLICE_NUM-1 : 0][1 : 0][DFI_SLICE_WIDTH-1 : 0][FREQUENCY_RATIO-1 : 0] DTI_RDDATA_MC_TMP;
logic     [DRAM_CHAN_NUM-1 : 0][PHY_SLICE_NUM-1 : 0][1 : 0]                       [FREQUENCY_RATIO-1 : 0] DTI_RDDATA_MASK_MC_TMP;
logic     [DRAM_CHAN_NUM-1 : 0]                                                   [FREQUENCY_RATIO-1 : 0] DTI_RDDATA_VALID_MC_TMP;


logic     [PHY_SLICE_NUM-1 : 0]                              [FREQUENCY_RATIO-1 : 0] DTI_RDDATA_EN_INT;
logic     [PHY_SLICE_NUM-1 : 0]                              [FREQUENCY_RATIO-1 : 0] DTI_RANK_RD_INT;
wire      [PHY_SLICE_NUM-1 : 0][1 : 0][DFI_SLICE_WIDTH-1 : 0][FREQUENCY_RATIO-1 : 0] DTI_RDDATA_INT;
wire      [PHY_SLICE_NUM-1 : 0][1 : 0]                       [FREQUENCY_RATIO-1 : 0] DTI_RDDATA_MASK_INT;
wire      [PHY_SLICE_NUM-1 : 0]                              [FREQUENCY_RATIO-1 : 0] DTI_RDDATA_VALID_INT;

wire      [PHY_SLICE_NUM-1 : 0][CHAN_RANK_NUM-1 : 0]                                                      gterr_reg_pts_slice_int;
wire      [CHAN_RANK_NUM-1 : 0][PHY_SLICE_NUM-1 : 0]                                                      gterr_reg_pts_int;
wire      [PHY_SLICE_NUM*DFI_SLICE_WIDTH-1 : 0][CHAN_RANK_NUM-1 : 0]                                      rdlvldqerr_reg_pts_slice_int;
wire      [CHAN_RANK_NUM-1 : 0][PHY_SLICE_NUM*DFI_SLICE_WIDTH-1 : 0]                                      rdlvldqerr_reg_pts_int;
wire      [PHY_SLICE_NUM-1 : 0][CHAN_RANK_NUM-1 : 0]                                                      rdlvldmerr_reg_pts_slice_int;
wire      [CHAN_RANK_NUM-1 : 0][PHY_SLICE_NUM-1 : 0]                                                      rdlvldmerr_reg_pts_int;
wire      [PHY_SLICE_NUM-1 : 0][CHAN_RANK_NUM-1 : 0]                                                      wrlvlerr_reg_pts_slice_int;
wire      [CHAN_RANK_NUM-1 : 0][PHY_SLICE_NUM-1 : 0]                                                      wrlvlerr_reg_pts_int;

genvar cid, pid, bid, sid, did;
//===================================================================================================
// Control Interface
//===================================================================================================
assign DTI_RESET_N_MC_INT             = DTI_RESET_N_MC;
assign DTI_CKE_MC_INT                 = DTI_CKE_MC;
assign DTI_CS_MC_INT                  = DTI_CS_MC;
assign DTI_CA_MC_INT                  = DTI_CA_MC;
assign DTI_CA_L_MC_INT                = DTI_CA_L_MC;
assign DTI_BA_MC_INT                  = DTI_BA_MC;
assign DTI_ACT_N_MC_INT               = DTI_ACT_N_MC;
assign DTI_ODT_MC_INT                 = DTI_ODT_MC;
assign DTI_RANK_MC_INT                = DTI_RANK_MC;

assign DTI_RESET_N                    = DTI_RESET_N_INT;
assign DTI_CKE                        = DTI_CKE_INT;
assign DTI_CS                         = DTI_CS_INT;
assign DTI_CA                         = DTI_CA_INT;
assign DTI_CA_L                       = DTI_CA_L_INT;
assign DTI_BA                         = DTI_BA_INT;
assign DTI_ACT_N                      = DTI_ACT_N_INT;
assign DTI_ODT                        = DTI_ODT_INT;
assign DTI_RANK                       = DTI_RANK_INT;

generate
  for (cid = 0; cid < DRAM_CHAN_NUM; cid = cid + 1) begin : PROC_CA_CHAN
    for (pid = 0; pid < FREQUENCY_RATIO; pid = pid + 1) begin : PROC_CA_PHASE
      assign DTI_RESET_N_INT  [cid]     [pid] = DTI_RESET_N_MC_INT  [cid][pid];
      assign DTI_ACT_N_INT    [cid]     [pid] = DTI_ACT_N_MC_INT    [cid][pid];
      assign DTI_ODT_INT      [cid]     [pid] = DTI_ODT_MC_INT      [cid][pid];
      assign DTI_RANK_INT     [cid]     [pid] = DTI_RANK_MC_INT     [cid][pid];
      for (bid = 0; bid < CHAN_RANK_NUM; bid = bid + 1) begin : PROC_CKE_BIT
        assign DTI_CKE_INT    [cid][bid][pid] = DTI_CKE_MC_INT      [cid][pid][bid];
      end
      for (bid = 0; bid < CHAN_RANK_NUM; bid = bid + 1) begin : PROC_CS_BIT
        assign DTI_CS_INT     [cid][bid][pid] = DTI_CS_MC_INT       [cid][pid][bid];
      end
      for (bid = 0; bid < PHY_CA_WIDTH; bid = bid + 1) begin : PROC_CA_BIT
        assign DTI_CA_INT     [cid][bid][pid] = DTI_CA_MC_INT       [cid][pid][bid];
      end
      for (bid = 0; bid < DRAM_LP3_CA_WIDTH; bid = bid + 1) begin : PROC_CA_L_BIT
        assign DTI_CA_L_INT   [cid][bid][pid] = DTI_CA_L_MC_INT     [cid][pid][bid];
      end
      for (bid = 0; bid < DRAM_BA_WIDTH; bid = bid + 1) begin : PROC_BA_BIT
        assign DTI_BA_INT     [cid][bid][pid] = DTI_BA_MC_INT       [cid][pid][bid];
      end
    end
  end
endgenerate

//===================================================================================================
// Write Interface
//===================================================================================================
assign DTI_WRDATA_EN_MC_INT           = DTI_WRDATA_EN_MC;
assign DTI_WRDATA_MC_INT              = DTI_WRDATA_MC;
assign DTI_WRDATA_MASK_MC_INT         = DTI_WRDATA_MASK_MC;
assign DTI_RANK_WR_MC_INT             = DTI_RANK_WR_MC;

assign DTI_WRDATA_EN                  = DTI_WRDATA_EN_INT;
assign DTI_WRDATA                     = DTI_WRDATA_INT;
assign DTI_WRDATA_MASK                = DTI_WRDATA_MASK_INT;
assign DTI_RANK_WR                    = DTI_RANK_WR_INT;

generate
  for (cid = 0; cid < DRAM_CHAN_NUM; cid = cid + 1) begin : PROC_WR_CHAN
    for (pid = 0; pid < FREQUENCY_RATIO; pid = pid + 1) begin : PROC_WR_PHASE
      assign DTI_WRDATA_EN_MC_TMP [cid][pid] = DTI_WRDATA_EN_MC_INT [cid][pid];
      assign DTI_RANK_WR_MC_TMP   [cid][pid] = DTI_RANK_WR_MC_INT   [cid][pid];
      for (sid = 0; sid < PHY_SLICE_NUM; sid = sid + 1) begin : PROC_WR_SLICE
        for (did = 0; did < 2; did = did + 1) begin : PROC_WR_DDR
          assign DTI_WRDATA_MASK_MC_TMP [cid][sid][did][pid] = DTI_WRDATA_MASK_MC_INT [cid][pid][did][sid];
          for (bid = 0; bid < DFI_SLICE_WIDTH; bid = bid + 1) begin : PROC_WR_BIT
            assign DTI_WRDATA_MC_TMP  [cid][sid][did][bid][pid] = DTI_WRDATA_MC_INT [cid][pid][did][sid][bid];
          end
        end
      end
    end
  end
endgenerate

always_comb begin
  case (1'b1)
    // 2x16
    reg_dual_chan_en & (~|DTI_DATA_BYTE_DISABLE) : begin
      DTI_WRDATA_EN_INT   [0] = DTI_WRDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 0
      DTI_WRDATA_EN_INT   [1] = DTI_WRDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 1
      DTI_WRDATA_EN_INT   [2] = DTI_WRDATA_EN_MC_TMP  [1];    // Chan 1 is assigned to Slice 2
      DTI_WRDATA_EN_INT   [3] = DTI_WRDATA_EN_MC_TMP  [1];    // Chan 1 is assigned to Slice 3
      DTI_RANK_WR_INT     [0] = DTI_RANK_WR_MC_TMP    [0];    // Chan 0 is assigned to Slice 0
      DTI_RANK_WR_INT     [1] = DTI_RANK_WR_MC_TMP    [0];    // Chan 0 is assigned to Slice 1
      DTI_RANK_WR_INT     [2] = DTI_RANK_WR_MC_TMP    [1];    // Chan 1 is assigned to Slice 2
      DTI_RANK_WR_INT     [3] = DTI_RANK_WR_MC_TMP    [1];    // Chan 1 is assigned to Slice 3
      DTI_WRDATA_INT      [0] = DTI_WRDATA_MC_TMP     [0][0]; // Chan 0 Slice 0 is assigned to Slice 0
      DTI_WRDATA_INT      [1] = DTI_WRDATA_MC_TMP     [0][1]; // Chan 0 Slice 1 is assigned to Slice 1
      DTI_WRDATA_INT      [2] = DTI_WRDATA_MC_TMP     [1][0]; // Chan 1 Slice 0 is assigned to Slice 2
      DTI_WRDATA_INT      [3] = DTI_WRDATA_MC_TMP     [1][1]; // Chan 1 Slice 1 is assigned to Slice 3
      DTI_WRDATA_MASK_INT [0] = DTI_WRDATA_MASK_MC_TMP[0][0]; // Chan 0 Slice 0 is assigned to Slice 0
      DTI_WRDATA_MASK_INT [1] = DTI_WRDATA_MASK_MC_TMP[0][1]; // Chan 0 Slice 1 is assigned to Slice 1
      DTI_WRDATA_MASK_INT [2] = DTI_WRDATA_MASK_MC_TMP[1][0]; // Chan 1 Slice 0 is assigned to Slice 2
      DTI_WRDATA_MASK_INT [3] = DTI_WRDATA_MASK_MC_TMP[1][1]; // Chan 1 Slice 1 is assigned to Slice 3
    end
    // x32
    (~reg_dual_chan_en) & (~|DTI_DATA_BYTE_DISABLE) : begin
      DTI_WRDATA_EN_INT   [0] = DTI_WRDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 0
      DTI_WRDATA_EN_INT   [1] = DTI_WRDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 1
      DTI_WRDATA_EN_INT   [2] = DTI_WRDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 2
      DTI_WRDATA_EN_INT   [3] = DTI_WRDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 3
      DTI_RANK_WR_INT     [0] = DTI_RANK_WR_MC_TMP    [0];    // Chan 0 is assigned to Slice 0
      DTI_RANK_WR_INT     [1] = DTI_RANK_WR_MC_TMP    [0];    // Chan 0 is assigned to Slice 1
      DTI_RANK_WR_INT     [2] = DTI_RANK_WR_MC_TMP    [0];    // Chan 0 is assigned to Slice 2
      DTI_RANK_WR_INT     [3] = DTI_RANK_WR_MC_TMP    [0];    // Chan 0 is assigned to Slice 3
      DTI_WRDATA_INT      [0] = DTI_WRDATA_MC_TMP     [0][0]; // Chan 0 Slice 0 is assigned to Slice 0
      DTI_WRDATA_INT      [1] = DTI_WRDATA_MC_TMP     [0][1]; // Chan 0 Slice 1 is assigned to Slice 1
      DTI_WRDATA_INT      [2] = DTI_WRDATA_MC_TMP     [0][2]; // Chan 0 Slice 2 is assigned to Slice 2
      DTI_WRDATA_INT      [3] = DTI_WRDATA_MC_TMP     [0][3]; // Chan 0 Slice 3 is assigned to Slice 3
      DTI_WRDATA_MASK_INT [0] = DTI_WRDATA_MASK_MC_TMP[0][0]; // Chan 0 Slice 0 is assigned to Slice 0
      DTI_WRDATA_MASK_INT [1] = DTI_WRDATA_MASK_MC_TMP[0][1]; // Chan 0 Slice 1 is assigned to Slice 1
      DTI_WRDATA_MASK_INT [2] = DTI_WRDATA_MASK_MC_TMP[0][2]; // Chan 0 Slice 2 is assigned to Slice 2
      DTI_WRDATA_MASK_INT [3] = DTI_WRDATA_MASK_MC_TMP[0][3]; // Chan 0 Slice 3 is assigned to Slice 3
    end
    // x16
    (~reg_dual_chan_en) & (|DTI_DATA_BYTE_DISABLE) : begin
      DTI_WRDATA_EN_INT   [0] = DTI_WRDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 0
      DTI_WRDATA_EN_INT   [1] = DTI_WRDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 1
      DTI_WRDATA_EN_INT   [2] = 0;                            // Unused
      DTI_WRDATA_EN_INT   [3] = 0;                            // Unused
      DTI_RANK_WR_INT     [0] = DTI_RANK_WR_MC_TMP    [0];    // Chan 0 is assigned to Slice 0
      DTI_RANK_WR_INT     [1] = DTI_RANK_WR_MC_TMP    [0];    // Chan 0 is assigned to Slice 1
      DTI_RANK_WR_INT     [2] = 0;                            // Unused
      DTI_RANK_WR_INT     [3] = 0;                            // Unused
      DTI_WRDATA_INT      [0] = DTI_WRDATA_MC_TMP     [0][0]; // Chan 0 Slice 0 is assigned to Slice 0
      DTI_WRDATA_INT      [1] = DTI_WRDATA_MC_TMP     [0][1]; // Chan 0 Slice 1 is assigned to Slice 1
      DTI_WRDATA_INT      [2] = 0;                            // Unused
      DTI_WRDATA_INT      [3] = 0;                            // Unused
      DTI_WRDATA_MASK_INT [0] = DTI_WRDATA_MASK_MC_TMP[0][0]; // Chan 0 Slice 0 is assigned to Slice 0
      DTI_WRDATA_MASK_INT [1] = DTI_WRDATA_MASK_MC_TMP[0][1]; // Chan 0 Slice 1 is assigned to Slice 1
      DTI_WRDATA_MASK_INT [2] = 0;                            // Unused
      DTI_WRDATA_MASK_INT [3] = 0;                            // Unused
    end
    default : begin
      DTI_WRDATA_EN_INT       = 0;                            // Unused
      DTI_RANK_WR_INT         = 0;                            // Unused
      DTI_WRDATA_INT          = 0;                            // Unused
      DTI_WRDATA_MASK_INT     = 0;                            // Unused
    end
  endcase
end

//===================================================================================================
// Read Interface
//===================================================================================================
assign DTI_RDDATA_EN_MC_INT           = DTI_RDDATA_EN_MC;
assign DTI_RANK_RD_MC_INT             = DTI_RANK_RD_MC;
assign DTI_RDDATA_MC                  = DTI_RDDATA_MC_INT;
assign DTI_RDDATA_MASK_MC             = DTI_RDDATA_MASK_MC_INT;
assign DTI_RDDATA_VALID_MC            = DTI_RDDATA_VALID_MC_INT;

assign DTI_RDDATA_EN                  = DTI_RDDATA_EN_INT;
assign DTI_RANK_RD                    = DTI_RANK_RD_INT;
assign DTI_RDDATA_INT                 = DTI_RDDATA;
assign DTI_RDDATA_MASK_INT            = DTI_RDDATA_MASK;
assign DTI_RDDATA_VALID_INT           = DTI_RDDATA_VALID;

generate
  for (cid = 0; cid < DRAM_CHAN_NUM; cid = cid + 1) begin : PROC_RD_CHAN
    for (pid = 0; pid < FREQUENCY_RATIO; pid = pid + 1) begin : PROC_RD_PHASE
      assign DTI_RDDATA_EN_MC_TMP   [cid][pid]  = DTI_RDDATA_EN_MC_INT    [cid][pid];
      assign DTI_RANK_RD_MC_TMP     [cid][pid]  = DTI_RANK_RD_MC_INT      [cid][pid];
      assign DTI_RDDATA_VALID_MC_INT[cid][pid]  = DTI_RDDATA_VALID_MC_TMP [cid][pid];
      for (sid = 0; sid < PHY_SLICE_NUM; sid = sid + 1) begin : PROC_RD_SLICE
        for (did = 0; did < 2; did = did + 1) begin : PROC_RD_DDR
          assign DTI_RDDATA_MASK_MC_INT [cid][pid][did][sid] = DTI_RDDATA_MASK_MC_TMP [cid][sid][did][pid];
          for (bid = 0; bid < DFI_SLICE_WIDTH; bid = bid + 1) begin : PROC_RD_BIT
            assign DTI_RDDATA_MC_INT [cid][pid][did][sid][bid] = DTI_RDDATA_MC_TMP [cid][sid][did][bid][pid];
          end
        end
      end
    end
  end
endgenerate

always_comb begin
  case (1'b1)
    // 2x16
    reg_dual_chan_en & (~|DTI_DATA_BYTE_DISABLE) : begin
      DTI_RDDATA_EN_INT       [0]     = DTI_RDDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 0
      DTI_RDDATA_EN_INT       [1]     = DTI_RDDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 1
      DTI_RDDATA_EN_INT       [2]     = DTI_RDDATA_EN_MC_TMP  [1];    // Chan 1 is assigned to Slice 2
      DTI_RDDATA_EN_INT       [3]     = DTI_RDDATA_EN_MC_TMP  [1];    // Chan 1 is assigned to Slice 3
      DTI_RANK_RD_INT         [0]     = DTI_RANK_RD_MC_TMP    [0];    // Chan 0 is assigned to Slice 0
      DTI_RANK_RD_INT         [1]     = DTI_RANK_RD_MC_TMP    [0];    // Chan 0 is assigned to Slice 1
      DTI_RANK_RD_INT         [2]     = DTI_RANK_RD_MC_TMP    [1];    // Chan 1 is assigned to Slice 2
      DTI_RANK_RD_INT         [3]     = DTI_RANK_RD_MC_TMP    [1];    // Chan 1 is assigned to Slice 3
      DTI_RDDATA_MC_TMP       [0][0]  = DTI_RDDATA_INT        [0];    // Slice 0 is assigned to Chan 0 Slice 0
      DTI_RDDATA_MC_TMP       [0][1]  = DTI_RDDATA_INT        [1];    // Slice 1 is assigned to Chan 0 Slice 1
      DTI_RDDATA_MC_TMP       [0][2]  = 0;                            // Unused
      DTI_RDDATA_MC_TMP       [0][3]  = 0;                            // Unused
      DTI_RDDATA_MC_TMP       [1][0]  = DTI_RDDATA_INT        [2];    // Slice 2 is assigned to Chan 1 Slice 0
      DTI_RDDATA_MC_TMP       [1][1]  = DTI_RDDATA_INT        [3];    // Slice 3 is assigned to Chan 1 Slice 1
      DTI_RDDATA_MC_TMP       [1][2]  = 0;                            // Unused
      DTI_RDDATA_MC_TMP       [1][3]  = 0;                            // Unused
      DTI_RDDATA_MASK_MC_TMP  [0][0]  = DTI_RDDATA_MASK_INT   [0];    // Slice 0 is assigned to Chan 0 Slice 0
      DTI_RDDATA_MASK_MC_TMP  [0][1]  = DTI_RDDATA_MASK_INT   [1];    // Slice 1 is assigned to Chan 0 Slice 1
      DTI_RDDATA_MASK_MC_TMP  [0][2]  = 0;                            // Unused
      DTI_RDDATA_MASK_MC_TMP  [0][3]  = 0;                            // Unused
      DTI_RDDATA_MASK_MC_TMP  [1][0]  = DTI_RDDATA_MASK_INT   [2];    // Slice 2 is assigned to Chan 1 Slice 0
      DTI_RDDATA_MASK_MC_TMP  [1][1]  = DTI_RDDATA_MASK_INT   [3];    // Slice 3 is assigned to Chan 1 Slice 1
      DTI_RDDATA_MASK_MC_TMP  [1][2]  = 0;                            // Unused
      DTI_RDDATA_MASK_MC_TMP  [1][3]  = 0;                            // Unused
      DTI_RDDATA_VALID_MC_TMP [0]     = DTI_RDDATA_VALID_INT  [0];    // Slice 0 is assigned to Chan 0
      DTI_RDDATA_VALID_MC_TMP [1]     = DTI_RDDATA_VALID_INT  [2];    // Slice 2 is assigned to Chan 1
    end
    // x32
    (~reg_dual_chan_en) & (~|DTI_DATA_BYTE_DISABLE) : begin
      DTI_RDDATA_EN_INT       [0]     = DTI_RDDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 0
      DTI_RDDATA_EN_INT       [1]     = DTI_RDDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 1
      DTI_RDDATA_EN_INT       [2]     = DTI_RDDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 2
      DTI_RDDATA_EN_INT       [3]     = DTI_RDDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 3
      DTI_RANK_RD_INT         [0]     = DTI_RANK_RD_MC_TMP    [0];    // Chan 0 is assigned to Slice 0
      DTI_RANK_RD_INT         [1]     = DTI_RANK_RD_MC_TMP    [0];    // Chan 0 is assigned to Slice 1
      DTI_RANK_RD_INT         [2]     = DTI_RANK_RD_MC_TMP    [0];    // Chan 0 is assigned to Slice 2
      DTI_RANK_RD_INT         [3]     = DTI_RANK_RD_MC_TMP    [0];    // Chan 0 is assigned to Slice 3
      DTI_RDDATA_MC_TMP       [0][0]  = DTI_RDDATA_INT        [0];    // Slice 0 is assigned to Chan 0 Slice 0
      DTI_RDDATA_MC_TMP       [0][1]  = DTI_RDDATA_INT        [1];    // Slice 1 is assigned to Chan 0 Slice 1
      DTI_RDDATA_MC_TMP       [0][2]  = DTI_RDDATA_INT        [2];    // Slice 2 is assigned to Chan 0 Slice 2
      DTI_RDDATA_MC_TMP       [0][3]  = DTI_RDDATA_INT        [3];    // Slice 3 is assigned to Chan 0 Slice 3
      DTI_RDDATA_MC_TMP       [1]     = 0;                            // Unused
      DTI_RDDATA_MASK_MC_TMP  [0][0]  = DTI_RDDATA_MASK_INT   [0];    // Slice 0 is assigned to Chan 0 Slice 0
      DTI_RDDATA_MASK_MC_TMP  [0][1]  = DTI_RDDATA_MASK_INT   [1];    // Slice 1 is assigned to Chan 0 Slice 1
      DTI_RDDATA_MASK_MC_TMP  [0][2]  = DTI_RDDATA_MASK_INT   [2];    // Slice 2 is assigned to Chan 0 Slice 2
      DTI_RDDATA_MASK_MC_TMP  [0][3]  = DTI_RDDATA_MASK_INT   [3];    // Slice 3 is assigned to Chan 0 Slice 3
      DTI_RDDATA_MASK_MC_TMP  [1]     = 0;                            // Unused
      DTI_RDDATA_VALID_MC_TMP [0]     = DTI_RDDATA_VALID_INT  [0];    // Slice 0 is assigned to Chan 0
      DTI_RDDATA_VALID_MC_TMP [1]     = 0;                            // Unused
    end
    // x16
    (~reg_dual_chan_en) & (|DTI_DATA_BYTE_DISABLE) : begin
      DTI_RDDATA_EN_INT       [0]     = DTI_RDDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 0
      DTI_RDDATA_EN_INT       [1]     = DTI_RDDATA_EN_MC_TMP  [0];    // Chan 0 is assigned to Slice 1
      DTI_RDDATA_EN_INT       [2]     = 0;                            // Unused
      DTI_RDDATA_EN_INT       [3]     = 0;                            // Unused
      DTI_RANK_RD_INT         [0]     = DTI_RANK_RD_MC_TMP    [0];    // Chan 0 is assigned to Slice 0
      DTI_RANK_RD_INT         [1]     = DTI_RANK_RD_MC_TMP    [0];    // Chan 0 is assigned to Slice 1
      DTI_RANK_RD_INT         [2]     = 0;                            // Unused
      DTI_RANK_RD_INT         [3]     = 0;                            // Unused
      DTI_RDDATA_MC_TMP       [0][0]  = DTI_RDDATA_INT        [0];    // Slice 0 is assigned to Chan 0 Slice 0
      DTI_RDDATA_MC_TMP       [0][1]  = DTI_RDDATA_INT        [1];    // Slice 1 is assigned to Chan 0 Slice 1
      DTI_RDDATA_MC_TMP       [0][2]  = 0;                            // Unused
      DTI_RDDATA_MC_TMP       [0][3]  = 0;                            // Unused
      DTI_RDDATA_MC_TMP       [1]     = 0;                            // Unused
      DTI_RDDATA_MASK_MC_TMP  [0][0]  = DTI_RDDATA_MASK_INT   [0];    // Slice 0 is assigned to Chan 0 Slice 0
      DTI_RDDATA_MASK_MC_TMP  [0][1]  = DTI_RDDATA_MASK_INT   [1];    // Slice 1 is assigned to Chan 0 Slice 1
      DTI_RDDATA_MASK_MC_TMP  [0][2]  = 0;                            // Unused
      DTI_RDDATA_MASK_MC_TMP  [0][3]  = 0;                            // Unused
      DTI_RDDATA_MASK_MC_TMP  [1]     = 0;                            // Unused
      DTI_RDDATA_VALID_MC_TMP [0]     = DTI_RDDATA_VALID_INT  [0];    // Slice 0 is assigned to Chan 0
      DTI_RDDATA_VALID_MC_TMP [1]     = 0;                            // Unused
    end
    default : begin
      DTI_RDDATA_EN_INT               = 0;                            // Unused
      DTI_RANK_RD_INT                 = 0;                            // Unused
      DTI_RDDATA_MC_TMP               = 0;                            // Unused
      DTI_RDDATA_MASK_MC_TMP          = 0;                            // Unused
      DTI_RDDATA_VALID_MC_TMP         = 0;                            // Unused
    end
  endcase
end

//===================================================================================================
// PTS
//===================================================================================================
assign gterr_reg_pts_slice_int        = gterr_reg_pts_slice;
assign gterr_reg_pts                  = gterr_reg_pts_int;

assign rdlvldqerr_reg_pts_slice_int   = rdlvldqerr_reg_pts_slice;
assign rdlvldqerr_reg_pts             = rdlvldqerr_reg_pts_int;

assign rdlvldmerr_reg_pts_slice_int   = rdlvldmerr_reg_pts_slice;
assign rdlvldmerr_reg_pts             = rdlvldmerr_reg_pts_int;

assign wrlvlerr_reg_pts_slice_int     = wrlvlerr_reg_pts_slice;
assign wrlvlerr_reg_pts               = wrlvlerr_reg_pts_int;

generate
  for (bid = 0; bid < CHAN_RANK_NUM; bid = bid + 1) begin : PROC_PTS_RANK
    for (sid = 0; sid < PHY_SLICE_NUM; sid = sid + 1) begin : PROC_PTS_SLICE
      assign gterr_reg_pts_int      [bid][sid] = gterr_reg_pts_slice_int      [sid][bid];
      assign rdlvldmerr_reg_pts_int [bid][sid] = rdlvldmerr_reg_pts_slice_int [sid][bid];
      assign wrlvlerr_reg_pts_int   [bid][sid] = wrlvlerr_reg_pts_slice_int   [sid][bid];
    end
    for (sid = 0; sid < PHY_SLICE_NUM*DFI_SLICE_WIDTH; sid = sid + 1) begin : PROC_PTS_RDLVLDQ
      assign rdlvldqerr_reg_pts_int[bid][sid] = rdlvldqerr_reg_pts_slice_int[sid][bid];
    end
  end
endgenerate

endmodule
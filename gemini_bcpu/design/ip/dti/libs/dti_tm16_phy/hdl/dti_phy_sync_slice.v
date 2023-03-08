//-----------------------------------------------------------------------------------------------------------
//    Copyright (C) 2021 by Dolphin Technology
//    All right reserved.
//
//    Copyright Notification
//    No part may be reproduced except as authorized by written permission.
//
//    Module: phy_ctl_blk_lib.dti_phy_sync_slice
//    Company: Dolphin Technology
//    Author: tung
//    Date: 2021/02/19 13:47:01
//-----------------------------------------------------------------------------------------------------------
`include "dti_global_defines.vh"
module dti_phy_sync_slice
#(
  parameter PHY_SLICE_NUM         = `CFG_PHY_SLICE_NUM        ,
  parameter DFI_SLICE_WIDTH       = `CFG_DFI_SLICE_WIDTH      ,
  parameter PHY_VREF_WIDTH        = `CFG_PHY_VREF_WIDTH       ,
  parameter PHY_WDQ_DLY_WIDTH     = `CFG_PHY_WDQ_DLY_WIDTH    ,
  parameter PHY_GATE_DLY_WIDTH    = `CFG_PHY_GATE_DLY_WIDTH   ,
  parameter PHY_RDLVL_DLY_WIDTH   = `CFG_PHY_RDLVL_DLY_WIDTH  ,
  parameter PHY_WRLVL_DLY_WIDTH   = `CFG_PHY_WRLVL_DLY_WIDTH  ,
  parameter DLL_LIM_WIDTH         = `CFG_DLL_LIM_WIDTH        ,
  parameter DLL_BYPC_WIDTH        = `CFG_DLL_BYPC_WIDTH       ,
  parameter CHAN_RANK_NUM         = `CFG_CHAN_RANK_NUM
)
(
  input                                                     dti_mc_clock          ,
  input                                                     dti_phy_clock         ,
  input                                                     DTI_PHY_CLOCK_DQ      ,
  input                                                     dti_sys_reset_n       ,

  input                                                     FENA_RCV_INT          ,
  input                                                     DTI_CALVL_DQ_EN_INT   ,
  input   [6:0]                                             DTI_CALVL_DATA_INT    ,
  output                                                    FENA_RCV              ,
  output                                                    DTI_CALVL_DQ_EN       ,
  output  [6:0]                                             DTI_CALVL_DATA        ,

  input                                                     DTI_RDLVL_GATE_EN_INT     ,
  input   [ PHY_GATE_DLY_WIDTH - 1 : 0 ]                    DTI_RDLVL_GATE_DLY_INT    ,
  input   [ CHAN_RANK_NUM - 1 : 0 ]                         DTI_RDLVL_GATE_STATUS     ,
  input   [ PHY_GATE_DLY_WIDTH-1:0]                         DTI_GTPH_R0               ,
  input   [ PHY_GATE_DLY_WIDTH-1:0]                         DTI_GTPH_R1               ,
  output                                                    DTI_RDLVL_GATE_EN         ,
  output  [ PHY_GATE_DLY_WIDTH - 1 : 0 ]                    DTI_RDLVL_GATE_DLY        ,
  output  [ CHAN_RANK_NUM - 1 : 0 ]                         DTI_RDLVL_GATE_STATUS_INT ,
  output  [ PHY_GATE_DLY_WIDTH-1:0]                         DTI_GTPH_R0_INT           ,
  output  [ PHY_GATE_DLY_WIDTH-1:0]                         DTI_GTPH_R1_INT           ,

  input                                                     DTI_RDLVL_EDGE_INT    ,
  input                                                     DTI_RDLVL_EN_INT      ,
  input   [ DFI_SLICE_WIDTH * PHY_RDLVL_DLY_WIDTH - 1 : 0 ] DTI_RDLVL_DLY_INT     ,
  input   [ DFI_SLICE_WIDTH - 1 : 0 ]                       DTI_RDLVL_STATUS      ,
  input   [ DFI_SLICE_WIDTH * PHY_RDLVL_DLY_WIDTH - 1 : 0 ] DTI_RDLVL_SET         ,
  output                                                    DTI_RDLVL_EDGE        ,
  output                                                    DTI_RDLVL_EN          ,
  output  [ DFI_SLICE_WIDTH * PHY_RDLVL_DLY_WIDTH - 1 : 0 ] DTI_RDLVL_DLY         ,
  output  [ DFI_SLICE_WIDTH - 1 : 0 ]                       DTI_RDLVL_STATUS_INT  ,
  output  [ DFI_SLICE_WIDTH * PHY_RDLVL_DLY_WIDTH - 1 : 0 ] DTI_RDLVL_SET_INT     ,

  input                                                     DTI_RDLVL_EN_DM_INT   ,
  input   [ PHY_RDLVL_DLY_WIDTH - 1 : 0 ]                   DTI_RDLVL_DLY_DM_INT  ,
  input                                                     DTI_RDLVL_STATUS_DM   ,
  input   [ PHY_RDLVL_DLY_WIDTH - 1 : 0 ]                   DTI_RDLVL_SET_DM      ,
  output                                                    DTI_RDLVL_EN_DM       ,
  output  [ PHY_RDLVL_DLY_WIDTH - 1 : 0 ]                   DTI_RDLVL_DLY_DM      ,
  output                                                    DTI_RDLVL_STATUS_DM_INT ,
  output  [ PHY_RDLVL_DLY_WIDTH - 1 : 0 ]                   DTI_RDLVL_SET_DM_INT    ,
  
  input                                                     DTI_WRLVL_EN_INT      ,
  input   [ PHY_WRLVL_DLY_WIDTH : 0 ]                       DTI_WRLVL_DLY_INT     ,
  input                                                     DTI_WRLVL_STATUS      ,
  input   [ PHY_WRLVL_DLY_WIDTH - 1 : 0 ]                   DTI_WRLVL_SET         ,
  output                                                    DTI_WRLVL_EN          ,
  output  [ PHY_WRLVL_DLY_WIDTH : 0 ]                       DTI_WRLVL_DLY         ,
  output                                                    DTI_WRLVL_STATUS_INT  ,
  output  [ PHY_WRLVL_DLY_WIDTH - 1 : 0 ]                   DTI_WRLVL_SET_INT     ,

  input   [ PHY_WDQ_DLY_WIDTH - 1 : 0 ]                     DTI_WDM_DLY_INT       ,
  input   [ DFI_SLICE_WIDTH * PHY_WDQ_DLY_WIDTH - 1 : 0 ]   DTI_WDQ_DLY_INT       ,
  output  [ PHY_WDQ_DLY_WIDTH - 1 : 0 ]                     DTI_WDM_DLY           ,
  output  [ DFI_SLICE_WIDTH * PHY_WDQ_DLY_WIDTH - 1 : 0 ]   DTI_WDQ_DLY           ,

  input                                                     DTI_VREF_EN_INT       ,
  input                                                     DTI_VT_EN_INT         ,
  input   [ PHY_VREF_WIDTH - 1 : 0 ]                        BYP_VREF_SET_INT      ,
  input                                                     BYPEN_VREF_SET_INT    ,
  input                                                     DTI_VREF_RANGE_INT    ,
  input                                                     DTI_VT_DONE           ,
  input   [ PHY_VREF_WIDTH - 1 : 0 ]                        DTI_VREF_SET          ,
  output                                                    DTI_VREF_EN           ,
  output                                                    DTI_VT_EN             ,
  output  [ PHY_VREF_WIDTH - 1 : 0 ]                        BYP_VREF_SET          ,
  output                                                    BYPEN_VREF_SET        ,
  output                                                    DTI_VREF_RANGE        ,
  output                                                    DTI_VT_DONE_INT       ,
  output  [ PHY_VREF_WIDTH - 1 : 0 ]                        DTI_VREF_SET_INT      ,

//  input                                                     BIST_EN_INT           ,
//  input                                                     BIST_START_INT        ,
//  input                                                     BIST_DONE_DATA        ,
  input                                                     BIST_ERR_DM_INT       ,
  input   [ DFI_SLICE_WIDTH - 1 : 0 ]                       BIST_ERR_DQ_INT       ,
//  output                                                    BIST_EN               ,
//  output                                                    BIST_START            ,
//  output                                                    BIST_DONE_DATA_INT    ,
  output                                                    BIST_ERR_DM           ,
  output  [ DFI_SLICE_WIDTH - 1 : 0 ]                       BIST_ERR_DQ           ,

  input   [ CHAN_RANK_NUM - 1 : 0 ]                         dqsleadck             ,
  output  [ CHAN_RANK_NUM - 1 : 0 ]                         dqsleadck_int         ,

  input                                                     BYP_REG_DLLDQ         ,
  input   [ DLL_BYPC_WIDTH - 1 : 0 ]                        BYPC_REG_DLLDQ        ,
  output                                                    BYP_REG_DLLDQ_INT     ,
  output  [ DLL_BYPC_WIDTH - 1 : 0 ]                        BYPC_REG_DLLDQ_INT    ,

  input                                                     CMOS_EN_REG_DIOR      ,
  input   [ 2 : 0 ]                                         RTT_SEL_REG_DIOR      ,
  input                                                     RTT_EN_REG_DIOR       ,
  input   [ 2 : 0 ]                                         DRVSEL_REG_DIOR       ,
  input                                                     ODIS_DM_REG_DIOR      ,
  input                                                     ODIS_DQS_REG_DIOR     ,
  input   [ DFI_SLICE_WIDTH - 1 : 0 ]                       ODIS_DQ_REG_DIOR      ,
  output                                                    CMOS_EN_REG_DIOR_INT  ,
  output  [ 2 : 0 ]                                         RTT_SEL_REG_DIOR_INT  ,
  output                                                    RTT_EN_REG_DIOR_INT   ,
  output  [ 2 : 0 ]                                         DRVSEL_REG_DIOR_INT   ,
  output                                                    ODIS_DM_REG_DIOR_INT  ,
  output                                                    ODIS_DQS_REG_DIOR_INT ,
  output  [ DFI_SLICE_WIDTH - 1 : 0 ]                       ODIS_DQ_REG_DIOR_INT  ,

//  input   [ 7 : 0 ]                                         DLL_DLYC_DQ_INT       ,
  input                                                     DLL_EN_DQ             ,
  input                                                     DLL_RESET_DQ          ,
  input                                                     DLL_UPDT_EN_DQ        ,
//  output  [ 7 : 0 ]                                         DLL_DLYC_DQ           ,
  output                                                    DLL_EN_DQ_INT         ,
  output                                                    DLL_RESET_DQ_INT      ,
  output                                                    DLL_UPDT_EN_DQ_INT    ,

  input                                                     DTI_INIT_COMPLETE_DQ  ,
  output                                                    DTI_INIT_COMPLETE_DQ_INT,

//  input   [ DFI_SLICE_WIDTH - 1 : 0 ]                       DTI_WRLVL_RESP_INT    ,
//  output  [ DFI_SLICE_WIDTH - 1 : 0 ]                       DTI_WRLVL_RESP        ,

  input   [ DLL_LIM_WIDTH - 1 : 0 ]                         LIMIT_REG_DLLDQ       ,
  input                                                     LOCK_REG_DLLDQ_INT    ,
  input                                                     OVFL_REG_DLLDQ_INT    ,
  input                                                     UNFL_REG_DLLDQ_INT    ,
  output  [ DLL_LIM_WIDTH - 1 : 0 ]                         LIMIT_REG_DLLDQ_INT   ,
  output                                                    LOCK_REG_DLLDQ        ,
  output                                                    OVFL_REG_DLLDQ        ,
  output                                                    UNFL_REG_DLLDQ        ,

  input                                                     DTI_DATA_BYTE_DISABLE     ,
  output                                                    DTI_DATA_BYTE_DISABLE_INT ,

  input                                                     GT_DIS_REG_RTGC       ,
  output                                                    GT_DIS_REG_RTGC_INT   ,

  input                                                     GT_UPDT_REG_RTGC      ,
  output                                                    GT_UPDT_REG_RTGC_INT  ,

  input                                                     LP_EN_REG_PBCR        ,
  output                                                    LP_EN_REG_PBCR_INT    ,

  input                                                     OUTBYPEN_DM           ,
  input   [ DFI_SLICE_WIDTH - 1 : 0 ]                       OUTBYPEN_DQ           ,
  input                                                     OUTBYPEN_DQS          ,
  output                                                    OUTBYPEN_DM_INT       ,
  output  [ DFI_SLICE_WIDTH - 1 : 0 ]                       OUTBYPEN_DQ_INT       ,
  output                                                    OUTBYPEN_DQS_INT      ,

  input                                                     OUTD_DM               ,
  input   [ DFI_SLICE_WIDTH - 1 : 0 ]                       OUTD_DQ               ,
  input                                                     OUTD_DQS              ,
  output                                                    OUTD_DM_INT           ,
  output  [ DFI_SLICE_WIDTH - 1 : 0 ]                       OUTD_DQ_INT           ,
  output                                                    OUTD_DQS_INT      
);




//===============================================================================================
//          From MC to PHY
//===============================================================================================
dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_fena_rcv
(
  .clk_src        (dti_mc_clock   ),
  .clk_dest       (dti_phy_clock  ),
  .reset_n        (dti_sys_reset_n),
  .din_src        (FENA_RCV_INT   ),
  .dout_dest      (FENA_RCV       )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_calvl_dq_en
(
  .clk_src        (dti_mc_clock       ),
  .clk_dest       (dti_phy_clock      ),
  .reset_n        (dti_sys_reset_n    ),
  .din_src        (DTI_CALVL_DQ_EN_INT),
  .dout_dest      (DTI_CALVL_DQ_EN    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (7),
  .SRC_SYNC       (0)
)
sync_cslvl_data
(
  .clk_src        (dti_mc_clock      ),
  .clk_dest       (dti_phy_clock     ),
  .reset_n        (dti_sys_reset_n   ),
  .din_src        (DTI_CALVL_DATA_INT),
  .dout_dest      (DTI_CALVL_DATA    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_rdlvl_gate_en
(
  .clk_src        (dti_mc_clock         ),
  .clk_dest       (dti_phy_clock        ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (DTI_RDLVL_GATE_EN_INT),
  .dout_dest      (DTI_RDLVL_GATE_EN    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_GATE_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_rdlvl_gate_dly
(
  .clk_src        (dti_mc_clock          ),
  .clk_dest       (dti_phy_clock         ),
  .reset_n        (dti_sys_reset_n       ),
  .din_src        (DTI_RDLVL_GATE_DLY_INT),
  .dout_dest      (DTI_RDLVL_GATE_DLY    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_rdlvl_edge
(
  .clk_src        (dti_mc_clock      ),
  .clk_dest       (dti_phy_clock     ),
  .reset_n        (dti_sys_reset_n   ),
  .din_src        (DTI_RDLVL_EDGE_INT),
  .dout_dest      (DTI_RDLVL_EDGE    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_rdlvl_en
(
  .clk_src        (dti_mc_clock    ),
  .clk_dest       (dti_phy_clock   ),
  .reset_n        (dti_sys_reset_n ),
  .din_src        (DTI_RDLVL_EN_INT),
  .dout_dest      (DTI_RDLVL_EN    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DFI_SLICE_WIDTH * PHY_RDLVL_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_rdlvl_dly
(
  .clk_src        (dti_mc_clock     ),
  .clk_dest       (dti_phy_clock    ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (DTI_RDLVL_DLY_INT),
  .dout_dest      (DTI_RDLVL_DLY    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_rdlvl_en_dm
(
  .clk_src        (dti_mc_clock       ),
  .clk_dest       (dti_phy_clock      ),
  .reset_n        (dti_sys_reset_n    ),
  .din_src        (DTI_RDLVL_EN_DM_INT),
  .dout_dest      (DTI_RDLVL_EN_DM    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_RDLVL_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_rdlvl_dly_dm
(
  .clk_src        (dti_mc_clock        ),
  .clk_dest       (dti_phy_clock       ),
  .reset_n        (dti_sys_reset_n     ),
  .din_src        (DTI_RDLVL_DLY_DM_INT),
  .dout_dest      (DTI_RDLVL_DLY_DM    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_wrlvl_en
(
  .clk_src        (dti_mc_clock    ),
  .clk_dest       (dti_phy_clock   ),
  .reset_n        (dti_sys_reset_n ),
  .din_src        (DTI_WRLVL_EN_INT),
  .dout_dest      (DTI_WRLVL_EN    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_WRLVL_DLY_WIDTH + 1),
  .SRC_SYNC       (0)
)
sync_wrlvl_dly
(
  .clk_src        (dti_mc_clock     ),
  .clk_dest       (dti_phy_clock    ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (DTI_WRLVL_DLY_INT),
  .dout_dest      (DTI_WRLVL_DLY    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_WDQ_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_wdm_dly
(
  .clk_src        (dti_mc_clock   ),
  .clk_dest       (dti_phy_clock  ),
  .reset_n        (dti_sys_reset_n),
  .din_src        (DTI_WDM_DLY_INT),
  .dout_dest      (DTI_WDM_DLY    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DFI_SLICE_WIDTH * PHY_WDQ_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_wdq_dly
(
  .clk_src        (dti_mc_clock   ),
  .clk_dest       (dti_phy_clock  ),
  .reset_n        (dti_sys_reset_n),
  .din_src        (DTI_WDQ_DLY_INT),
  .dout_dest      (DTI_WDQ_DLY    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_vref_en
(
  .clk_src        (dti_mc_clock   ),
  .clk_dest       (dti_phy_clock  ),
  .reset_n        (dti_sys_reset_n),
  .din_src        (DTI_VREF_EN_INT),
  .dout_dest      (DTI_VREF_EN    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_vt_en
(
  .clk_src        (dti_mc_clock   ),
  .clk_dest       (dti_phy_clock  ),
  .reset_n        (dti_sys_reset_n),
  .din_src        (DTI_VT_EN_INT  ),
  .dout_dest      (DTI_VT_EN      )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_VREF_WIDTH),
  .SRC_SYNC       (0)
)
sync_byb_vref_set
(
  .clk_src        (dti_mc_clock    ),
  .clk_dest       (dti_phy_clock   ),
  .reset_n        (dti_sys_reset_n ),
  .din_src        (BYP_VREF_SET_INT),
  .dout_dest      (BYP_VREF_SET    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_bypen_vref_set
(
  .clk_src        (dti_mc_clock      ),
  .clk_dest       (dti_phy_clock     ),
  .reset_n        (dti_sys_reset_n   ),
  .din_src        (BYPEN_VREF_SET_INT),
  .dout_dest      (BYPEN_VREF_SET    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_vref_range
(
  .clk_src        (dti_mc_clock      ),
  .clk_dest       (dti_phy_clock     ),
  .reset_n        (dti_sys_reset_n   ),
  .din_src        (DTI_VREF_RANGE_INT),
  .dout_dest      (DTI_VREF_RANGE    )
);

// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_bist_en
// (
//   .clk_src        (dti_mc_clock   ),
//   .clk_dest       (dti_phy_clock  ),
//   .reset_n        (dti_sys_reset_n),
//   .din_src        (BIST_EN_INT    ),
//   .dout_dest      (BIST_EN        )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_bist_start
// (
//   .clk_src        (dti_mc_clock   ),
//   .clk_dest       (dti_phy_clock  ),
//   .reset_n        (dti_sys_reset_n),
//   .din_src        (BIST_START_INT ),
//   .dout_dest      (BIST_START     )
// );

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (CHAN_RANK_NUM),
  .SRC_SYNC       (0)
)
sync_dqsleadck
(
  .clk_src        (dti_mc_clock   ),
  .clk_dest       (dti_phy_clock  ),
  .reset_n        (dti_sys_reset_n),
  .din_src        (dqsleadck      ),
  .dout_dest      (dqsleadck_int  )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_byp_reg_dlldq
(
  .clk_src        (dti_mc_clock       ),
  .clk_dest       (dti_phy_clock      ),
  .reset_n        (dti_sys_reset_n    ),
  .din_src        (BYP_REG_DLLDQ      ),
  .dout_dest      (BYP_REG_DLLDQ_INT  )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DLL_BYPC_WIDTH),
  .SRC_SYNC       (0)
)
sync_bypc_reg_dlldq
(
  .clk_src        (dti_mc_clock       ),
  .clk_dest       (dti_phy_clock      ),
  .reset_n        (dti_sys_reset_n    ),
  .din_src        (BYPC_REG_DLLDQ     ),
  .dout_dest      (BYPC_REG_DLLDQ_INT )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_cmos_en
(
  .clk_src        (dti_mc_clock        ),
  .clk_dest       (dti_phy_clock       ),
  .reset_n        (dti_sys_reset_n     ),
  .din_src        (CMOS_EN_REG_DIOR    ),
  .dout_dest      (CMOS_EN_REG_DIOR_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_rtt_en
(
  .clk_src        (dti_mc_clock       ),
  .clk_dest       (dti_phy_clock      ),
  .reset_n        (dti_sys_reset_n    ),
  .din_src        (RTT_EN_REG_DIOR    ),
  .dout_dest      (RTT_EN_REG_DIOR_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (3),
  .SRC_SYNC       (0)
)
sync_rtt_sel
(
  .clk_src        (dti_mc_clock        ),
  .clk_dest       (dti_phy_clock       ),
  .reset_n        (dti_sys_reset_n     ),
  .din_src        (RTT_SEL_REG_DIOR    ),
  .dout_dest      (RTT_SEL_REG_DIOR_INT)
);

assign ODIS_DM_REG_DIOR_INT  = ODIS_DM_REG_DIOR;
assign ODIS_DQS_REG_DIOR_INT = ODIS_DQS_REG_DIOR;
assign ODIS_DQ_REG_DIOR_INT  = ODIS_DQ_REG_DIOR;

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_dll_en
(
  .clk_src        (dti_mc_clock   ),
  .clk_dest       (dti_phy_clock  ),
  .reset_n        (dti_sys_reset_n),
  .din_src        (DLL_EN_DQ      ),
  .dout_dest      (DLL_EN_DQ_INT  )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_dll_reset
(
  .clk_src        (dti_mc_clock      ),
  .clk_dest       (dti_phy_clock     ),
  .reset_n        (dti_sys_reset_n   ),
  .din_src        (DLL_RESET_DQ      ),
  .dout_dest      (DLL_RESET_DQ_INT  )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_dll_updt_en
(
  .clk_src        (dti_mc_clock      ),
  .clk_dest       (dti_phy_clock     ),
  .reset_n        (dti_sys_reset_n   ),
  .din_src        (DLL_UPDT_EN_DQ    ),
  .dout_dest      (DLL_UPDT_EN_DQ_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (3),
  .SRC_SYNC       (0)
)
sync_drvsel
(
  .clk_src        (dti_mc_clock       ),
  .clk_dest       (dti_phy_clock      ),
  .reset_n        (dti_sys_reset_n    ),
  .din_src        (DRVSEL_REG_DIOR    ),
  .dout_dest      (DRVSEL_REG_DIOR_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_init_complete
(
  .clk_src        (dti_mc_clock            ),
  .clk_dest       (DTI_PHY_CLOCK_DQ        ),
  .reset_n        (dti_sys_reset_n         ),
  .din_src        (DTI_INIT_COMPLETE_DQ    ),
  .dout_dest      (DTI_INIT_COMPLETE_DQ_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DLL_LIM_WIDTH),
  .SRC_SYNC       (0)
)
sync_limit
(
  .clk_src        (dti_mc_clock            ),
  .clk_dest       (dti_phy_clock           ),
  .reset_n        (dti_sys_reset_n         ),
  .din_src        (LIMIT_REG_DLLDQ         ),
  .dout_dest      (LIMIT_REG_DLLDQ_INT     )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_data_byte_dis
(
  .clk_src        (dti_mc_clock             ),
  .clk_dest       (dti_phy_clock            ),
  .reset_n        (dti_sys_reset_n          ),
  .din_src        (DTI_DATA_BYTE_DISABLE    ),
  .dout_dest      (DTI_DATA_BYTE_DISABLE_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_outpyen_dm
(
  .clk_src        (dti_mc_clock     ),
  .clk_dest       (dti_phy_clock    ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (OUTBYPEN_DM      ),
  .dout_dest      (OUTBYPEN_DM_INT  )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_outpyen_dqs
(
  .clk_src        (dti_mc_clock      ),
  .clk_dest       (dti_phy_clock     ),
  .reset_n        (dti_sys_reset_n   ),
  .din_src        (OUTBYPEN_DQS      ),
  .dout_dest      (OUTBYPEN_DQS_INT  )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DFI_SLICE_WIDTH),
  .SRC_SYNC       (0)
)
sync_outpyen_dq
(
  .clk_src        (dti_mc_clock      ),
  .clk_dest       (dti_phy_clock     ),
  .reset_n        (dti_sys_reset_n   ),
  .din_src        (OUTBYPEN_DQ       ),
  .dout_dest      (OUTBYPEN_DQ_INT   )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_outd_dm
(
  .clk_src        (dti_mc_clock     ),
  .clk_dest       (dti_phy_clock    ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (OUTD_DM          ),
  .dout_dest      (OUTD_DM_INT      )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_outd_dqs
(
  .clk_src        (dti_mc_clock      ),
  .clk_dest       (dti_phy_clock     ),
  .reset_n        (dti_sys_reset_n   ),
  .din_src        (OUTD_DQS          ),
  .dout_dest      (OUTD_DQS_INT      )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DFI_SLICE_WIDTH),
  .SRC_SYNC       (0)
)
sync_outd_dq
(
  .clk_src        (dti_mc_clock      ),
  .clk_dest       (dti_phy_clock     ),
  .reset_n        (dti_sys_reset_n   ),
  .din_src        (OUTD_DQ           ),
  .dout_dest      (OUTD_DQ_INT       )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_gt_dis
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_phy_clock                ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (GT_DIS_REG_RTGC              ),
  .dout_dest      (GT_DIS_REG_RTGC_INT          )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_gt_updt
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_phy_clock                ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (GT_UPDT_REG_RTGC             ),
  .dout_dest      (GT_UPDT_REG_RTGC_INT         )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_lp_en
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_phy_clock                ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (LP_EN_REG_PBCR               ),
  .dout_dest      (LP_EN_REG_PBCR_INT           )
);

//===============================================================================================
//          From PHY to MC
//===============================================================================================

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (CHAN_RANK_NUM),
  .SRC_SYNC       (0)
)
sync_rdlvl_gate_status
(
  .clk_src        (dti_phy_clock            ),
  .clk_dest       (dti_mc_clock             ),
  .reset_n        (dti_sys_reset_n          ),
  .din_src        (DTI_RDLVL_GATE_STATUS    ),
  .dout_dest      (DTI_RDLVL_GATE_STATUS_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_GATE_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_gtph_r0
(
  .clk_src        (dti_phy_clock  ),
  .clk_dest       (dti_mc_clock   ),
  .reset_n        (dti_sys_reset_n),
  .din_src        (DTI_GTPH_R0    ),
  .dout_dest      (DTI_GTPH_R0_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_GATE_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_gtph_r1
(
  .clk_src        (dti_phy_clock  ),
  .clk_dest       (dti_mc_clock   ),
  .reset_n        (dti_sys_reset_n),
  .din_src        (DTI_GTPH_R1    ),
  .dout_dest      (DTI_GTPH_R1_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DFI_SLICE_WIDTH),
  .SRC_SYNC       (0)
)
sync_rdlvl_status
(
  .clk_src        (dti_phy_clock       ),
  .clk_dest       (dti_mc_clock        ),
  .reset_n        (dti_sys_reset_n     ),
  .din_src        (DTI_RDLVL_STATUS    ),
  .dout_dest      (DTI_RDLVL_STATUS_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DFI_SLICE_WIDTH * PHY_RDLVL_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_rdlvl_set
(
  .clk_src        (dti_phy_clock    ),
  .clk_dest       (dti_mc_clock     ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (DTI_RDLVL_SET    ),
  .dout_dest      (DTI_RDLVL_SET_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_rdlvl_status_dm
(
  .clk_src        (dti_phy_clock          ),
  .clk_dest       (dti_mc_clock           ),
  .reset_n        (dti_sys_reset_n        ),
  .din_src        (DTI_RDLVL_STATUS_DM    ),
  .dout_dest      (DTI_RDLVL_STATUS_DM_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_RDLVL_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_rdlvl_set_dm
(
  .clk_src        (dti_phy_clock       ),
  .clk_dest       (dti_mc_clock        ),
  .reset_n        (dti_sys_reset_n     ),
  .din_src        (DTI_RDLVL_SET_DM    ),
  .dout_dest      (DTI_RDLVL_SET_DM_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_wrlvl_status
(
  .clk_src        (dti_phy_clock       ),
  .clk_dest       (dti_mc_clock        ),
  .reset_n        (dti_sys_reset_n     ),
  .din_src        (DTI_WRLVL_STATUS    ),
  .dout_dest      (DTI_WRLVL_STATUS_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_WRLVL_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_wrlvl_set
(
  .clk_src        (dti_phy_clock    ),
  .clk_dest       (dti_mc_clock     ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (DTI_WRLVL_SET    ),
  .dout_dest      (DTI_WRLVL_SET_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_vt_done
(
  .clk_src        (dti_phy_clock  ),
  .clk_dest       (dti_mc_clock   ),
  .reset_n        (dti_sys_reset_n),
  .din_src        (DTI_VT_DONE    ),
  .dout_dest      (DTI_VT_DONE_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_VREF_WIDTH),
  .SRC_SYNC       (0)
)
sync_dti_vref_set
(
  .clk_src        (dti_phy_clock   ),
  .clk_dest       (dti_mc_clock    ),
  .reset_n        (dti_sys_reset_n ),
  .din_src        (DTI_VREF_SET    ),
  .dout_dest      (DTI_VREF_SET_INT)
);

// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_bist_done_data
// (
//   .clk_src        (dti_phy_clock     ),
//   .clk_dest       (dti_mc_clock      ),
//   .reset_n        (dti_sys_reset_n   ),
//   .din_src        (BIST_DONE_DATA    ),
//   .dout_dest      (BIST_DONE_DATA_INT)
// );
// 
dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_bist_err_dm
(
  .clk_src        (dti_phy_clock  ),
  .clk_dest       (dti_mc_clock   ),
  .reset_n        (dti_sys_reset_n),
  .din_src        (BIST_ERR_DM_INT),
  .dout_dest      (BIST_ERR_DM    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DFI_SLICE_WIDTH),
  .SRC_SYNC       (0)
)
sync_bist_err_dq
(
  .clk_src        (dti_phy_clock  ),
  .clk_dest       (dti_mc_clock   ),
  .reset_n        (dti_sys_reset_n),
  .din_src        (BIST_ERR_DQ_INT),
  .dout_dest      (BIST_ERR_DQ    )
);

// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (8),
//   .SRC_SYNC       (0)
// )
// sync_dll_dlyc
// (
//   .clk_src        (dti_phy_clock  ),
//   .clk_dest       (dti_mc_clock   ),
//   .reset_n        (dti_sys_reset_n),
//   .din_src        (DLL_DLYC_DQ_INT),
//   .dout_dest      (DLL_DLYC_DQ    )
// );

// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (DFI_SLICE_WIDTH),
//   .SRC_SYNC       (0)
// )
// sync_wrlvl_resp
// (
//   .clk_src        (dti_phy_clock     ),
//   .clk_dest       (dti_mc_clock      ),
//   .reset_n        (dti_sys_reset_n   ),
//   .din_src        (DTI_WRLVL_RESP_INT),
//   .dout_dest      (DTI_WRLVL_RESP    )
// );

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_lock
(
  .clk_src        (dti_phy_clock     ),
  .clk_dest       (dti_mc_clock      ),
  .reset_n        (dti_sys_reset_n   ),
  .din_src        (LOCK_REG_DLLDQ_INT),
  .dout_dest      (LOCK_REG_DLLDQ    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_ovfl
(
  .clk_src        (dti_phy_clock     ),
  .clk_dest       (dti_mc_clock      ),
  .reset_n        (dti_sys_reset_n   ),
  .din_src        (OVFL_REG_DLLDQ_INT),
  .dout_dest      (OVFL_REG_DLLDQ    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_unfl
(
  .clk_src        (dti_phy_clock     ),
  .clk_dest       (dti_mc_clock      ),
  .reset_n        (dti_sys_reset_n   ),
  .din_src        (UNFL_REG_DLLDQ_INT),
  .dout_dest      (UNFL_REG_DLLDQ    )
);

endmodule
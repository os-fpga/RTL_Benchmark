//-----------------------------------------------------------------------------------------------------------
//    Copyright (C) 2022 by Dolphin Technology
//    All right reserved.
//
//    Copyright Notification
//    No part may be reproduced except as authorized by written permission.
//
//    Module: phy_ctl_blk_lib.dti_phy_sync_ctrl
//    Company: Dolphin Technology
//    Author: tung
//    Date: 2022-05-24
//-----------------------------------------------------------------------------------------------------------
`include "dti_global_defines.vh"
module dti_phy_sync_ctrl
#(
  parameter PHY_CA_SET_WIDTH      = `CFG_PHY_CA_SET_WIDTH   ,
  parameter PHY_SLICE_NUM         = `CFG_PHY_SLICE_NUM      ,
  parameter PHY_CSLVL_DLY_WIDTH   = `CFG_PHY_CSLVL_DLY_WIDTH,
  parameter PHY_CALVL_DLY_WIDTH   = `CFG_PHY_CALVL_DLY_WIDTH,
  parameter PHY_CSLVL_SET_WIDTH   = `CFG_PHY_CSLVL_SET_WIDTH,
  parameter PHY_CALVL_SET_WIDTH   = `CFG_PHY_CALVL_SET_WIDTH,
  parameter PHY_VREF_WIDTH        = `CFG_PHY_VREF_WIDTH     ,
  parameter PHY_CMD_DLY_WIDTH     = `CFG_PHY_CMD_DLY_WIDTH  ,
  parameter DLL_BYPC_WIDTH        = `CFG_DLL_BYPC_WIDTH     ,
  parameter CLK_DLY_WIDTH         = `CFG_CLK_DLY_WIDTH      ,
  parameter DLL_LIM_WIDTH         = `CFG_DLL_LIM_WIDTH      ,
  parameter CHAN_RANK_NUM         = `CFG_CHAN_RANK_NUM      ,
  parameter DRAM_BA_WIDTH         = `CFG_DRAM_BA_WIDTH      ,
  parameter PHY_CTRL_WIDTH        = `CFG_PHY_CTRL_WIDTH     ,
  parameter PHY_CA_WIDTH          = `CFG_PHY_CA_WIDTH
)
(
  // System Signal
  input                                                                     dti_mc_clock          ,
  input                                                                     dti_phy_clock         ,
  input                                                                     DTI_PHY_CLOCK_CA      ,
  input                                                                     dti_sys_reset_n       ,
  
  // Control Signal
  input                                                                     DTI_CALVL_RESULT      ,
  input   [ PHY_CA_SET_WIDTH * CHAN_RANK_NUM - 1:0]                         DTI_CALVL_STATUS      ,
  input   [ CHAN_RANK_NUM - 1 : 0 ]                                         DTI_CSLVL_STATUS      ,
  input   [ PHY_CA_SET_WIDTH * PHY_CALVL_SET_WIDTH - 1:0]                   DTI_R0_CALVL_SET      ,
  input   [ PHY_CA_SET_WIDTH * PHY_CALVL_SET_WIDTH - 1:0]                   DTI_R1_CALVL_SET      ,
  input   [ CHAN_RANK_NUM * PHY_CSLVL_SET_WIDTH-1:0]                        DTI_CSLVL_SET         ,
  output                                                                    DTI_CALVL_RESULT_INT  ,
  output  [ PHY_CA_SET_WIDTH * CHAN_RANK_NUM - 1:0]                         DTI_CALVL_STATUS_INT  ,
  output  [ CHAN_RANK_NUM - 1 : 0 ]                                         DTI_CSLVL_STATUS_INT  ,
  output  [ PHY_CA_SET_WIDTH * PHY_CALVL_SET_WIDTH - 1:0 ]                  DTI_R0_CALVL_SET_INT  ,
  output  [ PHY_CA_SET_WIDTH * PHY_CALVL_SET_WIDTH - 1:0 ]                  DTI_R1_CALVL_SET_INT  ,
  output  [ CHAN_RANK_NUM * PHY_CSLVL_SET_WIDTH-1:0]                        DTI_CSLVL_SET_INT     ,

  input                                                                     DTI_RN_CALVL_INT      ,
  input                                                                     DTI_CALVL_CTRL_EN_INT ,
  input   [ CHAN_RANK_NUM * PHY_CSLVL_DLY_WIDTH - 1 : 0 ]                   DTI_CSLVL_DLY_INT     ,
  input   [ PHY_CA_WIDTH * PHY_CALVL_DLY_WIDTH - 1 : 0 ]                    DTI_CALVL_DLY_INT     ,
  output                                                                    DTI_RN_CALVL          ,
  output                                                                    DTI_CALVL_CTRL_EN     ,
  output  [ CHAN_RANK_NUM * PHY_CSLVL_DLY_WIDTH - 1 : 0 ]                   DTI_CSLVL_DLY         ,
  output  [ PHY_CA_WIDTH * PHY_CALVL_DLY_WIDTH - 1 : 0 ]                    DTI_CALVL_DLY         ,

  input   [ CHAN_RANK_NUM * PHY_CMD_DLY_WIDTH - 1 : 0 ]                     CKE_DLY_INT           ,
  input   [ PHY_CMD_DLY_WIDTH - 1 : 0 ]                                     ODT_DLY_INT           ,
  input   [ PHY_CMD_DLY_WIDTH - 1 : 0 ]                                     RESET_N_DLY_INT       ,
  input   [ PHY_CMD_DLY_WIDTH - 1 : 0 ]                                     ACT_N_DLY_INT         ,
  input   [ DRAM_BA_WIDTH * PHY_CMD_DLY_WIDTH - 1 : 0 ]                     BA_DLY_INT            ,
  output  [ CHAN_RANK_NUM * PHY_CMD_DLY_WIDTH - 1 : 0 ]                     CKE_DLY               ,
  output  [ PHY_CMD_DLY_WIDTH - 1 : 0 ]                                     ODT_DLY               ,
  output  [ PHY_CMD_DLY_WIDTH - 1 : 0 ]                                     RESET_N_DLY           ,
  output  [ PHY_CMD_DLY_WIDTH - 1 : 0 ]                                     ACT_N_DLY             ,
  output  [ DRAM_BA_WIDTH * PHY_CMD_DLY_WIDTH - 1 : 0 ]                     BA_DLY                ,

//  input                                                                     BIST_EN_INT           ,
//  input                                                                     BIST_START_INT        ,
//  output                                                                    BIST_EN               ,
//  output                                                                    BIST_START            ,
//
//  input                                                                     BIST_DONE_CTL         ,
//  input   [ PHY_CA_SET_WIDTH - 1 : 0 ]                                      BIST_ERR_CA_INT       ,
//  input                                                                     BIST_ERR_CKE_INT      ,
//  input                                                                     BIST_ERR_CS_INT       ,
//  input                                                                     BIST_ERR_ODT_INT      ,
//  input                                                                     BIST_ERR_RESET_N_INT  ,
//  output                                                                    BIST_DONE_CTL_INT     ,
//  output  [ PHY_CA_SET_WIDTH - 1 : 0 ]                                      BIST_ERR_CA           ,
//  output                                                                    BIST_ERR_CKE          ,
//  output                                                                    BIST_ERR_CS           ,
//  output                                                                    BIST_ERR_ODT          ,
//  output                                                                    BIST_ERR_RESET_N      ,

  input                                                                     VREFENCA_REG_PBCR     ,
  input   [ PHY_VREF_WIDTH - 1 : 0 ]                                        VREFSETCA_REG_PBCR    ,
  input                                                                     DTI_INIT_COMPLETE_CA  ,
  input   [ DLL_LIM_WIDTH - 1 : 0 ]                                         LIMIT_REG_DLLCA       ,
  input                                                                     LOCK_REG_DLLCA_INT    ,
  input                                                                     OVFL_REG_DLLCA_INT    ,
  input                                                                     UNFL_REG_DLLCA_INT    ,
  input                                                                     CMOS_EN_REG_CIOR      ,
//  input   [ 7 : 0 ]                                                         DLL_DLYC_CTL_INT      ,
  input                                                                     DLL_EN_CA             ,
  input                                                                     DLL_RESET_CA          ,
  input                                                                     DLL_UPDT_EN_CA        ,
  input   [ 2 : 0 ]                                                         DRVSEL_REG_CIOR       ,
  input   [ CLK_DLY_WIDTH - 1 : 0 ]                                         CLKDLY_REG_DLLCA      ,
  input   [ DLL_BYPC_WIDTH - 1 : 0 ]                                        BYPC_REG_DLLCA        ,
  input                                                                     BYP_REG_DLLCA         ,
  output                                                                    VREFENCA_REG_PBCR_INT ,
  output  [ PHY_VREF_WIDTH - 1 : 0 ]                                        VREFSETCA_REG_PBCR_INT,
  output                                                                    DTI_INIT_COMPLETE_CA_INT,
  output  [ DLL_LIM_WIDTH - 1 : 0 ]                                         LIMIT_REG_DLLCA_INT   ,
  output                                                                    LOCK_REG_DLLCA        ,
  output                                                                    OVFL_REG_DLLCA        ,
  output                                                                    UNFL_REG_DLLCA        ,
  output                                                                    CMOS_EN_REG_CIOR_INT  ,
//  output  [ 7 : 0 ]                                                         DLL_DLYC_CTL          ,
  output                                                                    DLL_EN_CA_INT         ,
  output                                                                    DLL_RESET_CA_INT      ,
  output                                                                    DLL_UPDT_EN_CA_INT    ,
  output  [ 2 : 0 ]                                                         DRVSEL_REG_CIOR_INT   ,
  output  [ CLK_DLY_WIDTH - 1 : 0 ]                                         CLK_DLY               ,
  output  [ DLL_BYPC_WIDTH - 1 : 0 ]                                        BYPC_REG_DLLCA_INT    ,
  output                                                                    BYP_REG_DLLCA_INT     ,

//   input                                                                     ODIS_CLK_REG_CIOR     ,
//   input   [ PHY_CA_SET_WIDTH -  1 : 0 ]                                     ODIS_CA_REG_CIOR        ,
//   input                                                                     ODIS_CKE_REG_CIOR       ,
//   input                                                                     ODIS_CS_REG_CIOR        ,
//   input                                                                     ODIS_ODT_REG_CIOR       ,
//   input                                                                     ODIS_RESETN_REG_CIOR    ,
//   output                                                                    ODIS_CLK_REG_CIOR_INT ,
//   output  [ PHY_CA_SET_WIDTH -  1 : 0 ]                                     ODIS_CA_REG_CIOR_INT    ,
//   output                                                                    ODIS_CKE_REG_CIOR_INT   ,
//   output                                                                    ODIS_CS_REG_CIOR_INT    ,
//   output                                                                    ODIS_ODT_REG_CIOR_INT   ,
//   output                                                                    ODIS_RESETN_REG_CIOR_INT,

//  input   [ PHY_CA_SET_WIDTH -  1 : 0 ]                                     OUTD_CA                 ,
//  input                                                                     OUTD_CKE                ,
//  input                                                                     OUTD_CS                 ,
//  input                                                                     OUTD_ODT                ,
//  input                                                                     OUTD_RESET_N            ,
//  output  [ PHY_CA_SET_WIDTH -  1 : 0 ]                                     OUTD_CA_INT             ,
//  output                                                                    OUTD_CKE_INT            ,
//  output                                                                    OUTD_CS_INT             ,
//  output                                                                    OUTD_ODT_INT            ,
//  output                                                                    OUTD_RESET_N_INT        ,

//  input   [ PHY_CA_SET_WIDTH -  1 : 0 ]                                     OUTBYPEN_CA             ,
//  input                                                                     OUTBYPEN_CKE            ,
//  input                                                                     OUTBYPEN_CS             ,
//  input                                                                     OUTBYPEN_ODT            ,
//  input                                                                     OUTBYPEN_RESET_N        ,
//  output  [ PHY_CA_SET_WIDTH -  1 : 0 ]                                     OUTBYPEN_CA_INT         ,
//  output                                                                    OUTBYPEN_CKE_INT        ,
//  output                                                                    OUTBYPEN_CS_INT         ,
//  output                                                                    OUTBYPEN_ODT_INT        ,
//  output                                                                    OUTBYPEN_RESET_N_INT    ,

  input                                                                     LP_EN_REG_PBCR          ,
  output                                                                    LP_EN_REG_PBCR_INT      

);

//===============================================================================================
//          From MC to PHY
//===============================================================================================
dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_rn_calvl
(
  .clk_src        (dti_mc_clock     ),
  .clk_dest       (dti_phy_clock    ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (DTI_RN_CALVL_INT ),
  .dout_dest      (DTI_RN_CALVL     )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_calvl_ctrl_en
(
  .clk_src        (dti_mc_clock         ),
  .clk_dest       (dti_phy_clock        ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (DTI_CALVL_CTRL_EN_INT),
  .dout_dest      (DTI_CALVL_CTRL_EN    )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (CHAN_RANK_NUM*PHY_CSLVL_DLY_WIDTH),
  .SRC_SYNC       (0                    )
)
sync_cslvl_dly
(
  .clk_src        (dti_mc_clock         ),
  .clk_dest       (dti_phy_clock        ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (DTI_CSLVL_DLY_INT    ),
  .dout_dest      (DTI_CSLVL_DLY        )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_CA_WIDTH*PHY_CALVL_DLY_WIDTH),
  .SRC_SYNC       (0                          )
)
sync_calvl_dly
(
  .clk_src        (dti_mc_clock         ),
  .clk_dest       (dti_phy_clock        ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (DTI_CALVL_DLY_INT    ),
  .dout_dest      (DTI_CALVL_DLY        )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (CHAN_RANK_NUM*PHY_CMD_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_cke_dly
(
  .clk_src        (dti_mc_clock     ),
  .clk_dest       (dti_phy_clock    ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (CKE_DLY_INT      ),
  .dout_dest      (CKE_DLY          )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_CMD_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_odt_dly
(
  .clk_src        (dti_mc_clock     ),
  .clk_dest       (dti_phy_clock    ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (ODT_DLY_INT      ),
  .dout_dest      (ODT_DLY          )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_CMD_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_rstn_dly
(
  .clk_src        (dti_mc_clock     ),
  .clk_dest       (dti_phy_clock    ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (RESET_N_DLY_INT  ),
  .dout_dest      (RESET_N_DLY      )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_CMD_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_actn_dly
(
  .clk_src        (dti_mc_clock     ),
  .clk_dest       (dti_phy_clock    ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (ACT_N_DLY_INT  ),
  .dout_dest      (ACT_N_DLY      )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DRAM_BA_WIDTH*PHY_CMD_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_ba_dly
(
  .clk_src        (dti_mc_clock     ),
  .clk_dest       (dti_phy_clock    ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (BA_DLY_INT       ),
  .dout_dest      (BA_DLY           )
);

// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_bist_en
// (
//   .clk_src        (dti_mc_clock     ),
//   .clk_dest       (dti_phy_clock    ),
//   .reset_n        (dti_sys_reset_n  ),
//   .din_src        (BIST_EN_INT      ),
//   .dout_dest      (BIST_EN          )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_bist_start
// (
//   .clk_src        (dti_mc_clock     ),
//   .clk_dest       (dti_phy_clock    ),
//   .reset_n        (dti_sys_reset_n  ),
//   .din_src        (BIST_START_INT   ),
//   .dout_dest      (BIST_START       )
// );


dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DLL_BYPC_WIDTH),
  .SRC_SYNC       (0)
)
sync_bypc
(
  .clk_src        (dti_mc_clock       ),
  .clk_dest       (dti_phy_clock      ),
  .reset_n        (dti_sys_reset_n    ),
  .din_src        (BYPC_REG_DLLCA     ),
  .dout_dest      (BYPC_REG_DLLCA_INT )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_byp
(
  .clk_src        (dti_mc_clock       ),
  .clk_dest       (dti_phy_clock      ),
  .reset_n        (dti_sys_reset_n    ),
  .din_src        (BYP_REG_DLLCA      ),
  .dout_dest      (BYP_REG_DLLCA_INT  )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (CLK_DLY_WIDTH),
  .SRC_SYNC       (0)
)
sync_clk_dly
(
  .clk_src        (dti_mc_clock       ),
  .clk_dest       (dti_phy_clock      ),
  .reset_n        (dti_sys_reset_n    ),
  .din_src        (CLKDLY_REG_DLLCA   ),
  .dout_dest      (CLK_DLY            )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_dll_en
(
  .clk_src        (dti_mc_clock       ),
  .clk_dest       (dti_phy_clock      ),
  .reset_n        (dti_sys_reset_n    ),
  .din_src        (DLL_EN_CA          ),
  .dout_dest      (DLL_EN_CA_INT      )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_dll_reset
(
  .clk_src        (dti_mc_clock       ),
  .clk_dest       (dti_phy_clock      ),
  .reset_n        (dti_sys_reset_n    ),
  .din_src        (DLL_RESET_CA       ),
  .dout_dest      (DLL_RESET_CA_INT   )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_dll_updt_en
(
  .clk_src        (dti_mc_clock       ),
  .clk_dest       (dti_phy_clock      ),
  .reset_n        (dti_sys_reset_n    ),
  .din_src        (DLL_UPDT_EN_CA     ),
  .dout_dest      (DLL_UPDT_EN_CA_INT )
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
  .din_src        (DRVSEL_REG_CIOR    ),
  .dout_dest      (DRVSEL_REG_CIOR_INT)
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_e_cmos
(
  .clk_src        (dti_mc_clock         ),
  .clk_dest       (dti_phy_clock        ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (CMOS_EN_REG_CIOR     ),
  .dout_dest      (CMOS_EN_REG_CIOR_INT )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DLL_LIM_WIDTH),
  .SRC_SYNC       (0)
)
sync_dll_limit
(
  .clk_src        (dti_mc_clock         ),
  .clk_dest       (dti_phy_clock        ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (LIMIT_REG_DLLCA      ),
  .dout_dest      (LIMIT_REG_DLLCA_INT  )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_init_complete
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (DTI_PHY_CLOCK_CA             ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (DTI_INIT_COMPLETE_CA         ),
  .dout_dest      (DTI_INIT_COMPLETE_CA_INT     )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_vrefen_ca
(
  .clk_src        (dti_mc_clock              ),
  .clk_dest       (dti_phy_clock             ),
  .reset_n        (dti_sys_reset_n           ),
  .din_src        (VREFENCA_REG_PBCR         ),
  .dout_dest      (VREFENCA_REG_PBCR_INT     )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_VREF_WIDTH),
  .SRC_SYNC       (0)
)
sync_vrefset_ca
(
  .clk_src        (dti_mc_clock           ),
  .clk_dest       (dti_phy_clock          ),
  .reset_n        (dti_sys_reset_n        ),
  .din_src        (VREFSETCA_REG_PBCR     ),
  .dout_dest      (VREFSETCA_REG_PBCR_INT )
);

// assign ODIS_CA_REG_CIOR_INT = ODIS_CA_REG_CIOR;
// assign ODIS_CS_REG_CIOR_INT = ODIS_CS_REG_CIOR;
// assign ODIS_CKE_REG_CIOR_INT = ODIS_CKE_REG_CIOR;
// assign ODIS_CLK_REG_CIOR_INT = ODIS_CLK_REG_CIOR;
// assign ODIS_ODT_REG_CIOR_INT = ODIS_ODT_REG_CIOR;
// assign ODIS_RESETN_REG_CIOR_INT = ODIS_RESETN_REG_CIOR;


// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (PHY_CA_SET_WIDTH),
//   .SRC_SYNC       (0)
// )
// sync_outd_ca
// (
//   .clk_src        (dti_mc_clock           ),
//   .clk_dest       (dti_phy_clock          ),
//   .reset_n        (dti_sys_reset_n        ),
//   .din_src        (OUTD_CA                ),
//   .dout_dest      (OUTD_CA_INT            )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_outd_cs
// (
//   .clk_src        (dti_mc_clock           ),
//   .clk_dest       (dti_phy_clock          ),
//   .reset_n        (dti_sys_reset_n        ),
//   .din_src        (OUTD_CS                ),
//   .dout_dest      (OUTD_CS_INT            )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_outd_cke
// (
//   .clk_src        (dti_mc_clock           ),
//   .clk_dest       (dti_phy_clock          ),
//   .reset_n        (dti_sys_reset_n        ),
//   .din_src        (OUTD_CKE               ),
//   .dout_dest      (OUTD_CKE_INT           )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_outd_odt
// (
//   .clk_src        (dti_mc_clock           ),
//   .clk_dest       (dti_phy_clock          ),
//   .reset_n        (dti_sys_reset_n        ),
//   .din_src        (OUTD_ODT      ),
//   .dout_dest      (OUTD_ODT_INT  )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_outd_resetn
// (
//   .clk_src        (dti_mc_clock     ),
//   .clk_dest       (dti_phy_clock    ),
//   .reset_n        (dti_sys_reset_n  ),
//   .din_src        (OUTD_RESET_N     ),
//   .dout_dest      (OUTD_RESET_N_INT )
// );


// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (PHY_CA_SET_WIDTH),
//   .SRC_SYNC       (0)
// )
// sync_outbypen_ca
// (
//   .clk_src        (dti_mc_clock           ),
//   .clk_dest       (dti_phy_clock          ),
//   .reset_n        (dti_sys_reset_n        ),
//   .din_src        (OUTBYPEN_CA            ),
//   .dout_dest      (OUTBYPEN_CA_INT        )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_outbypen_cs
// (
//   .clk_src        (dti_mc_clock           ),
//   .clk_dest       (dti_phy_clock          ),
//   .reset_n        (dti_sys_reset_n        ),
//   .din_src        (OUTBYPEN_CS            ),
//   .dout_dest      (OUTBYPEN_CS_INT        )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_outbypen_cke
// (
//   .clk_src        (dti_mc_clock           ),
//   .clk_dest       (dti_phy_clock          ),
//   .reset_n        (dti_sys_reset_n        ),
//   .din_src        (OUTBYPEN_CKE           ),
//   .dout_dest      (OUTBYPEN_CKE_INT       )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_outbypen_odt
// (
//   .clk_src        (dti_mc_clock           ),
//   .clk_dest       (dti_phy_clock          ),
//   .reset_n        (dti_sys_reset_n        ),
//   .din_src        (OUTBYPEN_ODT           ),
//   .dout_dest      (OUTBYPEN_ODT_INT       )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_outbypen_resetn
// (
//   .clk_src        (dti_mc_clock        ),
//   .clk_dest       (dti_phy_clock       ),
//   .reset_n        (dti_sys_reset_n     ),
//   .din_src        (OUTBYPEN_RESET_N    ),
//   .dout_dest      (OUTBYPEN_RESET_N_INT)
// );

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
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_calvl_result
(
  .clk_src        (dti_phy_clock        ),
  .clk_dest       (dti_mc_clock         ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (DTI_CALVL_RESULT     ),
  .dout_dest      (DTI_CALVL_RESULT_INT )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_CA_SET_WIDTH*CHAN_RANK_NUM),
  .SRC_SYNC       (0           )
)
sync_calvl_status
(
  .clk_src        (dti_phy_clock        ),
  .clk_dest       (dti_mc_clock         ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (DTI_CALVL_STATUS     ),
  .dout_dest      (DTI_CALVL_STATUS_INT )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (CHAN_RANK_NUM),
  .SRC_SYNC       (0)
)
sync_cslvl_status
(
  .clk_src        (dti_phy_clock        ),
  .clk_dest       (dti_mc_clock         ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (DTI_CSLVL_STATUS     ),
  .dout_dest      (DTI_CSLVL_STATUS_INT )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_CA_SET_WIDTH*PHY_CALVL_SET_WIDTH),
  .SRC_SYNC       (0)
)
sync_calvl_set_r0
(
  .clk_src        (dti_phy_clock        ),
  .clk_dest       (dti_mc_clock         ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (DTI_R0_CALVL_SET     ),
  .dout_dest      (DTI_R0_CALVL_SET_INT )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_CA_SET_WIDTH*PHY_CALVL_SET_WIDTH),
  .SRC_SYNC       (0)
)
sync_calvl_set_r1
(
  .clk_src        (dti_phy_clock        ),
  .clk_dest       (dti_mc_clock         ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (DTI_R1_CALVL_SET     ),
  .dout_dest      (DTI_R1_CALVL_SET_INT )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (CHAN_RANK_NUM*PHY_CSLVL_SET_WIDTH),
  .SRC_SYNC       (0)
)
sync_cslvl_set
(
  .clk_src        (dti_phy_clock        ),
  .clk_dest       (dti_mc_clock         ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (DTI_CSLVL_SET        ),
  .dout_dest      (DTI_CSLVL_SET_INT    )
);


// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_bist_done_ctl
// (
//   .clk_src        (dti_phy_clock        ),
//   .clk_dest       (dti_mc_clock         ),
//   .reset_n        (dti_sys_reset_n      ),
//   .din_src        (BIST_DONE_CTL        ),
//   .dout_dest      (BIST_DONE_CTL_INT    )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (PHY_CA_SET_WIDTH),
//   .SRC_SYNC       (0)
// )
// sync_bist_err_ca
// (
//   .clk_src        (dti_phy_clock        ),
//   .clk_dest       (dti_mc_clock         ),
//   .reset_n        (dti_sys_reset_n      ),
//   .din_src        (BIST_ERR_CA_INT      ),
//   .dout_dest      (BIST_ERR_CA          )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_bist_err_cke
// (
//   .clk_src        (dti_phy_clock        ),
//   .clk_dest       (dti_mc_clock         ),
//   .reset_n        (dti_sys_reset_n      ),
//   .din_src        (BIST_ERR_CKE_INT     ),
//   .dout_dest      (BIST_ERR_CKE         )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_bist_err_cs
// (
//   .clk_src        (dti_phy_clock        ),
//   .clk_dest       (dti_mc_clock         ),
//   .reset_n        (dti_sys_reset_n      ),
//   .din_src        (BIST_ERR_CS_INT     ),
//   .dout_dest      (BIST_ERR_CS         )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_bist_err_odt
// (
//   .clk_src        (dti_phy_clock        ),
//   .clk_dest       (dti_mc_clock         ),
//   .reset_n        (dti_sys_reset_n      ),
//   .din_src        (BIST_ERR_ODT_INT     ),
//   .dout_dest      (BIST_ERR_ODT         )
// );
// 
// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (1),
//   .SRC_SYNC       (0)
// )
// sync_bist_err_reset_n
// (
//   .clk_src        (dti_phy_clock        ),
//   .clk_dest       (dti_mc_clock         ),
//   .reset_n        (dti_sys_reset_n      ),
//   .din_src        (BIST_ERR_RESET_N_INT ),
//   .dout_dest      (BIST_ERR_RESET_N     )
// );

// dti_cdc_data_sync_gf
// #(
//   .DATA_WIDTH     (8),
//   .SRC_SYNC       (0)
// )
// sync_dll_dlyc
// (
//   .clk_src        (dti_phy_clock        ),
//   .clk_dest       (dti_mc_clock         ),
//   .reset_n        (dti_sys_reset_n      ),
//   .din_src        (DLL_DLYC_CTL_INT     ),
//   .dout_dest      (DLL_DLYC_CTL         )
// );

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_lock
(
  .clk_src        (dti_phy_clock        ),
  .clk_dest       (dti_mc_clock         ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (LOCK_REG_DLLCA_INT   ),
  .dout_dest      (LOCK_REG_DLLCA       )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_ovlf
(
  .clk_src        (dti_phy_clock        ),
  .clk_dest       (dti_mc_clock         ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (OVFL_REG_DLLCA_INT   ),
  .dout_dest      (OVFL_REG_DLLCA       )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_unlf
(
  .clk_src        (dti_phy_clock        ),
  .clk_dest       (dti_mc_clock         ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (UNFL_REG_DLLCA_INT   ),
  .dout_dest      (UNFL_REG_DLLCA       )
);

endmodule
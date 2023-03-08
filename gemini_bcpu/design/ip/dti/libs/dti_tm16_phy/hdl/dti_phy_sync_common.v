//-----------------------------------------------------------------------------------------------------------
//    Copyright (C) 2021 by Dolphin Technology
//    All right reserved.
//
//    Copyright Notification
//    No part may be reproduced except as authorized by written permission.
//
//    Module: phy_ctl_blk_lib.dti_phy_sync_common
//    Company: Dolphin Technology
//    Author: tung
//    Date: 2021/02/19 13:47:01
//-----------------------------------------------------------------------------------------------------------
`include "dti_global_defines.vh"
module dti_phy_sync_common
#(
  parameter PHY_CTRL_WIDTH  = `CFG_PHY_CTRL_WIDTH,
  parameter DRAM_CHAN_NUM   = `CFG_DRAM_CHAN_NUM ,
  parameter CHAN_RANK_NUM   = `CFG_CHAN_RANK_NUM
)
(
  // System Signal
  input                                                                     dti_mc_clock            ,
  input                                                                     dti_phy_clock           ,
  input                                                                     dti_comp_clock          ,
  input                                                                     dti_sys_reset_n         ,

  
  input                                                                     DTI_DRAM_CLK_DISABLE_CTL,
  input                                                                     clklocken_reg_pom       ,
  output                                                                    DTI_DRAM_CLK_DISABLE_INT,
  output                                                                    clklocken_reg_pom_int   ,

  input                                                                     clklockc_reg_pos_int    ,
  output                                                                    clklockc_reg_pos        ,

  input       [DRAM_CHAN_NUM-1 : 0]                                         chanen_reg_pom          ,
  output      [DRAM_CHAN_NUM-1 : 0]                                         chanen_reg_pom_int      ,

  input       [CHAN_RANK_NUM-1 : 0]                                         ranken_reg_pom          ,
  output      [CHAN_RANK_NUM-1 : 0]                                         ranken_reg_pom_int      ,

  input                                                                     reg_lpddr4_en           ,
  input                                                                     reg_lpddr3_en           ,
  input                                                                     reg_ddr4_en             ,
  input                                                                     reg_ddr3_en             ,
  input                                                                     reg_dual_rank_en        ,
  input                                                                     reg_dual_chan_en        ,
  input                                                                     reg_dqs2ck_en           ,
  output                                                                    reg_lpddr4_en_int       ,
  output                                                                    reg_lpddr3_en_int       ,
  output                                                                    reg_ddr4_en_int         ,
  output                                                                    reg_ddr3_en_int         ,
  output                                                                    reg_dual_rank_en_int    ,
  output                                                                    reg_dual_chan_en_int    ,
  output                                                                    reg_dqs2ck_en_int       ,

  input       [1 : 0]                                                       DTI_FREQ_RATIO          ,
  output      [1 : 0]                                                       DTI_FREQ_RATIO_INT      ,

  input                                                                     BIST_START_INT          ,
  input                                                                     BIST_EN_INT             ,
  output                                                                    BIST_START              ,
  output                                                                    BIST_EN                 ,

  input                                                                     BIST_DONE               ,
  output                                                                    BIST_DONE_INT           ,

  input       [PHY_CTRL_WIDTH-1 : 0]                                        BIST_ERR_CTL            ,
  output      [PHY_CTRL_WIDTH-1 : 0]                                        BIST_ERR_CTL_INT        ,

  input       [2 : 0]                                                       IO_MODE_INT             ,
  output      [2 : 0]                                                       IO_MODE                 ,

  input   [ PHY_CTRL_WIDTH - 1 : 0 ]                                        OUTBYPEN_CTL            ,
  input   [ DRAM_CHAN_NUM - 1 : 0 ]                                         OUTBYPEN_CLK            ,
  output  [ PHY_CTRL_WIDTH - 1 : 0 ]                                        OUTBYPEN_CTL_INT        ,
  output  [ DRAM_CHAN_NUM - 1 : 0 ]                                         OUTBYPEN_CLK_INT        ,

  input   [ PHY_CTRL_WIDTH - 1 : 0 ]                                        OUTD_CTL                ,
  input   [ DRAM_CHAN_NUM - 1 : 0 ]                                         OUTD_CLK                ,
  output  [ PHY_CTRL_WIDTH - 1 : 0 ]                                        OUTD_CTL_INT            ,
  output  [ DRAM_CHAN_NUM - 1 : 0 ]                                         OUTD_CLK_INT            ,

  input                                                                     srst_reg_pccr           ,
  output                                                                    srst_reg_pccr_int
);

//===============================================================================================
//          From MC to PHY
//===============================================================================================

dti_cdc_data_sync_one
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_clk_dis
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_phy_clock                ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (DTI_DRAM_CLK_DISABLE_CTL     ),
  .dout_dest      (DTI_DRAM_CLK_DISABLE_INT     )
);


dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_clklocken
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_phy_clock                ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (clklocken_reg_pom            ),
  .dout_dest      (clklocken_reg_pom_int        )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_lpddr4_en
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_phy_clock                ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (reg_lpddr4_en                ),
  .dout_dest      (reg_lpddr4_en_int            )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_lpddr3_en
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_phy_clock                ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (reg_lpddr3_en                ),
  .dout_dest      (reg_lpddr3_en_int            )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_ddr4_en
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_phy_clock                ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (reg_ddr4_en                  ),
  .dout_dest      (reg_ddr4_en_int              )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_ddr3_en
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_phy_clock                ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (reg_ddr3_en                  ),
  .dout_dest      (reg_ddr3_en_int              )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_dual_rank
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_phy_clock                ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (reg_dual_rank_en             ),
  .dout_dest      (reg_dual_rank_en_int         )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_dual_chan
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_phy_clock                ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (reg_dual_chan_en             ),
  .dout_dest      (reg_dual_chan_en_int         )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DRAM_CHAN_NUM),
  .SRC_SYNC       (0)
)
sync_chanen
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_phy_clock                ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (chanen_reg_pom               ),
  .dout_dest      (chanen_reg_pom_int           )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (CHAN_RANK_NUM),
  .SRC_SYNC       (0)
)
sync_ranken
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_phy_clock                ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (ranken_reg_pom               ),
  .dout_dest      (ranken_reg_pom_int           )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_dqs2ck_en
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_phy_clock                ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (reg_dqs2ck_en                ),
  .dout_dest      (reg_dqs2ck_en_int            )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_bist_en
(
  .clk_src        (dti_mc_clock     ),
  .clk_dest       (dti_phy_clock    ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (BIST_EN_INT      ),
  .dout_dest      (BIST_EN          )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_bist_start
(
  .clk_src        (dti_mc_clock     ),
  .clk_dest       (dti_phy_clock    ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (BIST_START_INT   ),
  .dout_dest      (BIST_START       )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (3),
  .SRC_SYNC       (0)
)
sync_io_mode
(
  .clk_src        (dti_mc_clock     ),
  .clk_dest       (dti_phy_clock    ),
  .reset_n        (dti_sys_reset_n  ),
  .din_src        (IO_MODE_INT      ),
  .dout_dest      (IO_MODE          )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_CTRL_WIDTH),
  .SRC_SYNC       (0)
)
sync_outbypen_ctl
(
  .clk_src        (dti_mc_clock           ),
  .clk_dest       (dti_phy_clock          ),
  .reset_n        (dti_sys_reset_n        ),
  .din_src        (OUTBYPEN_CTL           ),
  .dout_dest      (OUTBYPEN_CTL_INT       )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DRAM_CHAN_NUM),
  .SRC_SYNC       (0)
)
sync_outbypen_clk
(
  .clk_src        (dti_mc_clock           ),
  .clk_dest       (dti_phy_clock          ),
  .reset_n        (dti_sys_reset_n        ),
  .din_src        (OUTBYPEN_CLK           ),
  .dout_dest      (OUTBYPEN_CLK_INT       )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_CTRL_WIDTH),
  .SRC_SYNC       (0)
)
sync_outd_ctl
(
  .clk_src        (dti_mc_clock           ),
  .clk_dest       (dti_phy_clock          ),
  .reset_n        (dti_sys_reset_n        ),
  .din_src        (OUTD_CTL                ),
  .dout_dest      (OUTD_CTL_INT            )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (DRAM_CHAN_NUM),
  .SRC_SYNC       (0)
)
sync_outd_clk
(
  .clk_src        (dti_mc_clock           ),
  .clk_dest       (dti_phy_clock          ),
  .reset_n        (dti_sys_reset_n        ),
  .din_src        (OUTD_CLK               ),
  .dout_dest      (OUTD_CLK_INT           )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (2),
  .SRC_SYNC       (0)
)
sync_freq_ratio
(
  .clk_src        (dti_mc_clock           ),
  .clk_dest       (dti_phy_clock          ),
  .reset_n        (dti_sys_reset_n        ),
  .din_src        (DTI_FREQ_RATIO         ),
  .dout_dest      (DTI_FREQ_RATIO_INT     )
);

//===============================================================================================
//          From PHY to MC
//===============================================================================================

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_clklock
(
  .clk_src        (dti_phy_clock        ),
  .clk_dest       (dti_mc_clock         ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (clklockc_reg_pos_int ),
  .dout_dest      (clklockc_reg_pos     )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_bist_done
(
  .clk_src        (dti_phy_clock        ),
  .clk_dest       (dti_mc_clock         ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (BIST_DONE            ),
  .dout_dest      (BIST_DONE_INT        )
);

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (PHY_CTRL_WIDTH),
  .SRC_SYNC       (0)
)
sync_bist_err_ctrl
(
  .clk_src        (dti_phy_clock        ),
  .clk_dest       (dti_mc_clock         ),
  .reset_n        (dti_sys_reset_n      ),
  .din_src        (BIST_ERR_CTL         ),
  .dout_dest      (BIST_ERR_CTL_INT     )
);

//===============================================================================================
//          From MC to COMP
//===============================================================================================

dti_cdc_data_sync_gf
#(
  .DATA_WIDTH     (1),
  .SRC_SYNC       (0)
)
sync_srst
(
  .clk_src        (dti_mc_clock                 ),
  .clk_dest       (dti_comp_clock               ),
  .reset_n        (dti_sys_reset_n              ),
  .din_src        (srst_reg_pccr                ),
  .dout_dest      (srst_reg_pccr_int            )
);

endmodule

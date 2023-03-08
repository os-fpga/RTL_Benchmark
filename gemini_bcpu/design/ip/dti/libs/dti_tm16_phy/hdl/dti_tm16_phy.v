//-----------------------------------------------------------------------------------------------------------
//    Copyright (C) 2022 by Dolphin Technology
//    All right reserved.
//
//    Copyright Notification
//    No part may be reproduced except as authorized by written permission.
//
//    Module: dti_tm16_phy_lib.dti_tm16_phy
//    Company: Dolphin Technology
//    Author: tung
//    Date: 11:35:15 08/18/22
//-----------------------------------------------------------------------------------------------------------

`include "dti_global_defines.vh"
module dti_tm16_phy #(
  parameter DRAM_CHAN_NUM           = `CFG_DRAM_CHAN_NUM,
  parameter DLL_BYPC_WIDTH          = `CFG_DLL_BYPC_WIDTH,
  parameter PHY_SLICE_NUM           = `CFG_PHY_SLICE_NUM,
  parameter CLK_DLY_WIDTH           = `CFG_CLK_DLY_WIDTH,
  parameter PHY_CTRL_WIDTH          = `CFG_PHY_CTRL_WIDTH,
  parameter DFI_SLICE_WIDTH         = `CFG_DFI_SLICE_WIDTH,
  parameter FREQUENCY_RATIO         = `CFG_FREQUENCY_RATIO,
  parameter DRAM_BA_WIDTH           = `CFG_DRAM_BA_WIDTH,
  parameter DRAM_LP3_CA_WIDTH       = `CFG_DRAM_LP3_CA_WIDTH,
  parameter PHY_CA_WIDTH            = `CFG_PHY_CA_WIDTH,
  parameter CHAN_RANK_NUM           = `CFG_CHAN_RANK_NUM,
  parameter AXI4_DATA_WIDTH         = `CFG_AXI4_DATA_WIDTH,
  parameter DLL_LIM_WIDTH           = `CFG_DLL_LIM_WIDTH,
  parameter PHY_VREF_WIDTH          = `CFG_PHY_VREF_WIDTH,
  parameter PHY_CMD_DLY_WIDTH       = `CFG_PHY_CMD_DLY_WIDTH,
  parameter DRAM_COL_WIDTH          = `CFG_DRAM_COL_WIDTH,
  parameter PHY_WDQ_DLY_WIDTH       = `CFG_PHY_WDQ_DLY_WIDTH,
  parameter PHY_DQ_TRANS            = `CFG_PHY_DQ_TRANS,
  parameter PHY_WDM_DLY_WIDTH       = `CFG_PHY_WDM_DLY_WIDTH,
  parameter DATAEN_REG_WIDTH        = `CFG_DATAEN_REG_WIDTH,
  parameter PHY_GATE_DLY_WIDTH      = `CFG_PHY_GATE_DLY_WIDTH,
  parameter PHY_RDLVL_DLY_WIDTH     = `CFG_PHY_RDLVL_DLY_WIDTH,
  parameter PHY_LP3_CALVL_PAT_WIDTH = `CFG_PHY_LP3_CALVL_PAT_WIDTH,
  parameter DMR_DATA_WIDTH          = `CFG_DMR_DATA_WIDTH,
  parameter MRR_DATA_WIDTH          = `CFG_MRR_DATA_WIDTH,
  parameter PHY_WIDE_COUNTER_WIDTH  = `CFG_PHY_WIDE_COUNTER_WIDTH,
  parameter PHY_COUNTER_WIDTH       = `CFG_PHY_COUNTER_WIDTH,
  parameter ODT_COUNT_WIDTH         = `CFG_ODT_COUNT_WIDTH,
  parameter DRAM_ROW_WIDTH          = `CFG_DRAM_ROW_WIDTH,
  parameter PHY_WRLVL_DLY_WIDTH     = `CFG_PHY_WRLVL_DLY_WIDTH,
  parameter PHY_CALVL_DLY_WIDTH     = `CFG_PHY_CALVL_DLY_WIDTH,
  parameter PHY_CALVL_SET_WIDTH     = `CFG_PHY_CALVL_SET_WIDTH,
  parameter PHY_CSLVL_SET_WIDTH     = `CFG_PHY_CSLVL_SET_WIDTH,
  parameter PHY_CALVL_DATA_WIDTH    = `CFG_PHY_CALVL_DATA_WIDTH,
  parameter PHY_CA_SET_WIDTH        = `CFG_PHY_CA_SET_WIDTH,
  parameter PHY_CSLVL_DLY_WIDTH     = `CFG_PHY_CSLVL_DLY_WIDTH,
  parameter HOLD_WIDTH              = `CFG_HOLD_WIDTH,
  parameter DRAM_LP4_CA_WIDTH       = `CFG_DRAM_LP4_CA_WIDTH
)
( 
  // Port Declarations
  input   wire    [DRAM_CHAN_NUM*DLL_BYPC_WIDTH - 1:0]                                           BYPC_REG_DLLCA, 
  input   wire    [PHY_SLICE_NUM*DLL_BYPC_WIDTH - 1:0]                                           BYPC_REG_DLLDQ, 
  input   wire                                                                                   BYP_EN_REG_PCCR, 
  input   wire    [3:0]                                                                          BYP_N_REG_PCCR, 
  input   wire    [3:0]                                                                          BYP_P_REG_PCCR, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            BYP_REG_DLLCA, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            BYP_REG_DLLDQ, 
  input   wire    [DRAM_CHAN_NUM*CLK_DLY_WIDTH - 1:0]                                            CLKDLY_REG_DLLCA, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            CLOCKDR_CLK, 
  input   wire    [PHY_CTRL_WIDTH-1:0]                                                           CLOCKDR_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            CLOCKDR_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                          CLOCKDR_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            CLOCKDR_DQS, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            CMOS_EN_REG_CIOR, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            CMOS_EN_REG_DIOR, 
  input   wire                                                                                   COMP_CLOCK, 
  input   wire                                                                                   COMP_RST_N, 
  input   wire    [DRAM_CHAN_NUM*3-1:0]                                                          DRVSEL_REG_CIOR, 
  input   wire    [PHY_SLICE_NUM*3-1:0]                                                          DRVSEL_REG_DIOR, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                                        DTI_ACT_N_MC, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO * DRAM_BA_WIDTH - 1:0]                        DTI_BA_MC, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO * DRAM_LP3_CA_WIDTH - 1:0]                    DTI_CA_L_MC, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO * PHY_CA_WIDTH - 1:0]                         DTI_CA_MC, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO * CHAN_RANK_NUM - 1:0]                        DTI_CKE_MC, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO * CHAN_RANK_NUM - 1:0]                        DTI_CS_MC, 
  input   wire    [PHY_SLICE_NUM - 1:0]                                                          DTI_DATA_BYTE_DISABLE, 
  input   wire                                                                                   DTI_DRAM_CLK_DISABLE, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            DTI_EXT_VREF, 
  input   wire    [1:0]                                                                          DTI_FREQ_RATIO, 
  input   wire                                                                                   DTI_MC_CLOCK, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                                        DTI_ODT_MC, 
  input   wire                                                                                   DTI_PHY_CLOCK, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                                        DTI_RANK_MC, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                                        DTI_RANK_RD_MC, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                                        DTI_RANK_WR_MC, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                                        DTI_RDDATA_EN_MC, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                                        DTI_RESET_N_MC, 
  input   wire                                                                                   DTI_SYS_RESET_N, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                                        DTI_WRDATA_EN_MC, 
  input   wire    [DRAM_CHAN_NUM * AXI4_DATA_WIDTH / 8 - 1:0]                                    DTI_WRDATA_MASK_MC, 
  input   wire    [DRAM_CHAN_NUM * AXI4_DATA_WIDTH - 1:0]                                        DTI_WRDATA_MC, 
  input   wire                                                                                   EN_REG_PCCR, 
  input   wire                                                                                   GT_DIS_REG_RTGC, 
  input   wire                                                                                   GT_UPDT_REG_RTGC, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            JTAG_SI_CLK, 
  input   wire    [PHY_CTRL_WIDTH - 1:0]                                                         JTAG_SI_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            JTAG_SI_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                          JTAG_SI_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            JTAG_SI_DQS, 
  input   wire    [DRAM_CHAN_NUM*DLL_LIM_WIDTH - 1:0]                                            LIMIT_REG_DLLCA, 
  input   wire    [PHY_SLICE_NUM*DLL_LIM_WIDTH - 1:0]                                            LIMIT_REG_DLLDQ, 
  input   wire                                                                                   LP_EN_REG_PBCR, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            MODE_CLK, 
  input   wire    [PHY_CTRL_WIDTH-1:0]                                                           MODE_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            MODE_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                          MODE_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            MODE_DQS, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            MODE_I_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                          MODE_I_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            MODE_I_DQS, 
  input   wire                                                                                   MVG_EN_REG_PCCR, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            ODIS_CLK_REG_CIOR, 
  input   wire    [PHY_CTRL_WIDTH-1:0]                                                           ODIS_CTL_REG_CIOR, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            ODIS_DM_REG_DIOR, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            ODIS_DQS_REG_DIOR, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                          ODIS_DQ_REG_DIOR, 
  input   wire                                                                                   PAD_REF, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            REG_OUTBYPEN_CLK, 
  input   wire    [PHY_CTRL_WIDTH - 1:0]                                                         REG_OUTBYPEN_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            REG_OUTBYPEN_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                          REG_OUTBYPEN_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            REG_OUTBYPEN_DQS, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            REG_OUTD_CLK, 
  input   wire    [PHY_CTRL_WIDTH - 1:0]                                                         REG_OUTD_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            REG_OUTD_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                          REG_OUTD_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            REG_OUTD_DQS, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            RTT_EN_REG_DIOR, 
  input   wire    [PHY_SLICE_NUM*3-1:0]                                                          RTT_SEL_REG_DIOR, 
  input   wire                                                                                   SE, 
  input   wire                                                                                   SE_CK, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            SHIFTDR_CLK, 
  input   wire    [PHY_CTRL_WIDTH-1:0]                                                           SHIFTDR_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            SHIFTDR_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                          SHIFTDR_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            SHIFTDR_DQS, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            SI_CLK, 
  input   wire    [PHY_CTRL_WIDTH - 1:0]                                                         SI_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            SI_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                          SI_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            SI_RD, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            SI_WR, 
  input   wire                                                                                   TPADEN_REG_PCCR, 
  input   wire                                                                                   T_CGCTL_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            T_CGCTL_DQ, 
  input   wire                                                                                   T_RCTL_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            T_RCTL_DQ, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            UPDATEDR_CLK, 
  input   wire    [PHY_CTRL_WIDTH-1:0]                                                           UPDATEDR_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            UPDATEDR_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                          UPDATEDR_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            UPDATEDR_DQS, 
  input   wire                                                                                   UPD_EN_REG_PCCR, 
  input   wire                                                                                   VDD, 
  input   wire                                                                                   VDDO, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            VREFENCA_REG_PBCR, 
  input   wire    [DRAM_CHAN_NUM*PHY_VREF_WIDTH - 1:0]                                           VREFSETCA_REG_PBCR, 
  input   wire                                                                                   VSS, 
  input   wire    [CHAN_RANK_NUM*DRAM_CHAN_NUM*PHY_CMD_DLY_WIDTH-1:0]                            actn_reg_ptsr, 
  input   wire    [DRAM_BA_WIDTH - 1:0]                                                          ba_reg_ptar, 
  input   wire    [CHAN_RANK_NUM*DRAM_CHAN_NUM*DRAM_BA_WIDTH*PHY_CMD_DLY_WIDTH-1:0]              ba_reg_ptsr, 
  input   wire                                                                                   bist_en_reg_pbcr, 
  input   wire                                                                                   bist_start_reg_pbcr, 
  input   wire    [CHAN_RANK_NUM*DRAM_CHAN_NUM*PHY_CA_WIDTH*PHY_CMD_DLY_WIDTH-1:0]               ca_reg_ptsr, 
  input   wire    [DRAM_CHAN_NUM - 1:0]                                                          chanen_reg_pom, 
  input   wire    [CHAN_RANK_NUM*DRAM_CHAN_NUM*PHY_CMD_DLY_WIDTH-1:0]                            cke_reg_ptsr, 
  input   wire                                                                                   clklocken_reg_pom, 
  input   wire                                                                                   cmddlyen_reg_pom, 
  input   wire    [DRAM_COL_WIDTH - 1:0]                                                         col_reg_ptar, 
  input   wire    [CHAN_RANK_NUM*DRAM_CHAN_NUM*PHY_CMD_DLY_WIDTH - 1:0]                          cs_reg_ptsr, 
  input   wire                                                                                   dfien_reg_pom, 
  input   wire                                                                                   dir_reg_dqsdqcr, 
  input   wire                                                                                   dllrsten_reg_pom, 
  input   wire                                                                                   dlyevalen_reg_pom, 
  input   wire    [7:0]                                                                          dlymax_reg_dqsdqcr, 
  input   wire    [PHY_WDQ_DLY_WIDTH-1:0]                                                        dlyoffs_reg_dqsdqcr, 
  input   wire    [PHY_DQ_TRANS - 1:0]                                                           dqrpt_reg_pttr, 
  input   wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * PHY_WDM_DLY_WIDTH - 1:0]                      dqsdm_reg_ptsr, 
  input   wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * DFI_SLICE_WIDTH * PHY_WDQ_DLY_WIDTH - 1:0]    dqsdq_reg_ptsr, 
  input   wire                                                                                   dqsdqen_reg_pom, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            dqsel_reg_dqsdqcr, 
  input   wire    [CHAN_RANK_NUM * PHY_SLICE_NUM - 1:0]                                          dqsleadck_reg_ptsr, 
  input   wire                                                                                   draminiten_reg_pom, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            en_reg_dllca, 
  input   wire    [PHY_SLICE_NUM - 1:0]                                                          en_reg_dlldq, 
  input   wire    [PHY_SLICE_NUM-1:0]                                                            fena_rcv_reg_dior, 
  input   wire    [DATAEN_REG_WIDTH - 1:0]                                                       fs0_trden_reg_rtgc, 
  input   wire    [DATAEN_REG_WIDTH:0]                                                           fs0_trdendbi_reg_rtgc, 
  input   wire    [DATAEN_REG_WIDTH - 1:0]                                                       fs0_twren_reg_rtgc, 
  input   wire    [DATAEN_REG_WIDTH - 1:0]                                                       fs1_trden_reg_rtgc, 
  input   wire    [DATAEN_REG_WIDTH:0]                                                           fs1_trdendbi_reg_rtgc, 
  input   wire    [DATAEN_REG_WIDTH - 1:0]                                                       fs1_twren_reg_rtgc, 
  input   wire                                                                                   fs_reg_pom, 
  input   wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * PHY_GATE_DLY_WIDTH - 1:0]                     gt_reg_ptsr, 
  input   wire                                                                                   gten_reg_pom, 
  input   wire    [10:0]                                                                         initcnt_reg_pccr, 
  input   wire                                                                                   ivrefen_reg_vtgc, 
  input   wire                                                                                   ivrefr_reg_vtgc, 
  input   wire    [7:0]                                                                          ivrefts_reg_vtgc, 
  input   wire    [2:0]                                                                          mpcrpt_reg_dqsdqcr, 
  input   wire                                                                                   mupd_reg_dqsdqcr, 
  input   wire                                                                                   odt_reg_pom, 
  input   wire    [DRAM_CHAN_NUM*PHY_CMD_DLY_WIDTH-1:0]                                          odt_reg_ptsr, 
  input   wire                                                                                   phyfsen_reg_pom, 
  input   wire                                                                                   phyinit_reg_pom, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            phyop_en, 
  input   wire                                                                                   physeten_reg_pom, 
  input   wire                                                                                   proc_reg_pom, 
  input   wire    [CHAN_RANK_NUM * PHY_SLICE_NUM - 1:0]                                          psck_reg_ptsr, 
  input   wire    [CHAN_RANK_NUM - 1:0]                                                          rank_reg_dqsdqcr, 
  input   wire    [CHAN_RANK_NUM - 1:0]                                                          ranken_reg_pom, 
  input   wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * DFI_SLICE_WIDTH * PHY_RDLVL_DLY_WIDTH - 1:0]  rdlvl_reg_ptsr, 
  input   wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * PHY_RDLVL_DLY_WIDTH - 1:0]                    rdlvldm_reg_ptsr, 
  input   wire                                                                                   rdlvlen_reg_pom, 
  input   wire    [PHY_LP3_CALVL_PAT_WIDTH - 1:0]                                                reg_calvl_pattern_a, 
  input   wire    [PHY_LP3_CALVL_PAT_WIDTH - 1:0]                                                reg_calvl_pattern_b, 
  input   wire                                                                                   reg_ddr3_en, 
  input   wire    [DMR_DATA_WIDTH - 1:0]                                                         reg_ddr3_mr0, 
  input   wire    [DMR_DATA_WIDTH - 1:0]                                                         reg_ddr3_mr1, 
  input   wire    [DMR_DATA_WIDTH - 1:0]                                                         reg_ddr3_mr2, 
  input   wire    [DMR_DATA_WIDTH - 1:0]                                                         reg_ddr3_mr3, 
  input   wire                                                                                   reg_ddr4_en, 
  input   wire    [DMR_DATA_WIDTH - 1:0]                                                         reg_ddr4_mr0, 
  input   wire    [DMR_DATA_WIDTH - 1:0]                                                         reg_ddr4_mr1, 
  input   wire    [DMR_DATA_WIDTH - 1:0]                                                         reg_ddr4_mr2, 
  input   wire    [DMR_DATA_WIDTH - 1:0]                                                         reg_ddr4_mr3, 
  input   wire    [DMR_DATA_WIDTH - 1:0]                                                         reg_ddr4_mr4, 
  input   wire    [DMR_DATA_WIDTH - 1:0]                                                         reg_ddr4_mr5, 
  input   wire    [DMR_DATA_WIDTH - 1:0]                                                         reg_ddr4_mr6, 
  input   wire    [PHY_VREF_WIDTH - 1:0]                                                         reg_ddr4_mr6_vrefdq, 
  input   wire                                                                                   reg_ddr4_mr6_vrefdqr, 
  input   wire                                                                                   reg_dqs2ck_en, 
  input   wire                                                                                   reg_dual_chan_en, 
  input   wire                                                                                   reg_dual_rank_en, 
  input   wire    [2:0]                                                                          reg_io_mode, 
  input   wire                                                                                   reg_lpddr3_en, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr3_mr1, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr3_mr11, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr3_mr16, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr3_mr17, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr3_mr2, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr3_mr3, 
  input   wire                                                                                   reg_lpddr4_en, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr11_fs0, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr11_fs1, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr11_nt_fs0, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr11_nt_fs1, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr13, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr1_fs0, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr1_fs1, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr22_fs0, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr22_fs1, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr22_nt_fs0, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr22_nt_fs1, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr2_fs0, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr2_fs1, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr3_fs0, 
  input   wire    [MRR_DATA_WIDTH - 1:0]                                                         reg_lpddr4_mr3_fs1, 
  input   wire    [PHY_WIDE_COUNTER_WIDTH-1:0]                                                   reg_t_caent, 
  input   wire    [PHY_COUNTER_WIDTH - 1:0]                                                      reg_t_calvl_max, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_calvladrckeh, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_calvlcap, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_calvlcc, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_calvlen, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_calvlext, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_ckckeh, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_ckehdqs, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_ckelck, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_ckfspe, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_ckfspx, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_dllen, 
  input   wire    [PHY_WIDE_COUNTER_WIDTH-1:0]                                                   reg_t_dlllock, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_dllrst, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_dqscke, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_dtrain, 
  input   wire    [PHY_WIDE_COUNTER_WIDTH-1:0]                                                   reg_t_fc, 
  input   wire    [PHY_WIDE_COUNTER_WIDTH-1:0]                                                   reg_t_init1, 
  input   wire    [PHY_WIDE_COUNTER_WIDTH-1:0]                                                   reg_t_init3, 
  input   wire    [PHY_WIDE_COUNTER_WIDTH-1:0]                                                   reg_t_init5, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_lvlaa, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_lvldis, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_lvldll, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_lvlexit, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_lvlload, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_lvlresp, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_lvlresp_nr, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_mod, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_mpcwr, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_mpcwr2rd, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_mrd, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_mrr, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_mrs2act, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_mrs2lvlen, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_mrw, 
  input   wire    [ODT_COUNT_WIDTH - 1:0]                                                        reg_t_odth8, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_odtup, 
  input   wire    [PHY_WIDE_COUNTER_WIDTH-1:0]                                                   reg_t_pori, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_rcd, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_rp, 
  input   wire    [PHY_WIDE_COUNTER_WIDTH-1:0]                                                   reg_t_rst, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_vrcgdis, 
  input   wire    [PHY_WIDE_COUNTER_WIDTH-1:0]                                                   reg_t_vrcgen, 
  input   wire    [PHY_WIDE_COUNTER_WIDTH-1:0]                                                   reg_t_vreftimelong, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_vreftimeshort, 
  input   wire    [PHY_WIDE_COUNTER_WIDTH-1:0]                                                   reg_t_xpr, 
  input   wire    [PHY_WIDE_COUNTER_WIDTH-1:0]                                                   reg_t_zqcal, 
  input   wire    [PHY_WIDE_COUNTER_WIDTH-1:0]                                                   reg_t_zqinit, 
  input   wire    [PHY_COUNTER_WIDTH-1:0]                                                        reg_t_zqlat, 
  input   wire    [DRAM_ROW_WIDTH - 1:0]                                                         row_reg_ptar, 
  input   wire    [DRAM_CHAN_NUM*PHY_CMD_DLY_WIDTH-1:0]                                          rstn_reg_ptsr, 
  input   wire                                                                                   sanchken_reg_pom, 
  input   wire    [DFI_SLICE_WIDTH * 2 - 1:0]                                                    sanpat_reg_ptsr, 
  input   wire                                                                                   srst_reg_pccr, 
  input   wire    [DRAM_CHAN_NUM-1:0]                                                            upd_reg_dllca, 
  input   wire    [PHY_SLICE_NUM - 1:0]                                                          upd_reg_dlldq, 
  input   wire                                                                                   vrefcaen_reg_pom, 
  input   wire                                                                                   vrefcar_reg_lpmr12_fs0, 
  input   wire                                                                                   vrefcar_reg_lpmr12_fs1, 
  input   wire    [CHAN_RANK_NUM - 1:0]                                                          vrefcar_reg_ptsr, 
  input   wire    [PHY_VREF_WIDTH - 1:0]                                                         vrefcas_reg_lpmr12_fs0, 
  input   wire    [PHY_VREF_WIDTH - 1:0]                                                         vrefcas_reg_lpmr12_fs1, 
  input   wire    [CHAN_RANK_NUM * PHY_VREF_WIDTH - 1:0]                                         vrefcas_reg_ptsr, 
  input   wire    [PHY_VREF_WIDTH - 1:0]                                                         vrefcasw_reg_vtgc, 
  input   wire                                                                                   vrefdqr_reg_lpmr14_fs0, 
  input   wire                                                                                   vrefdqr_reg_lpmr14_fs1, 
  input   wire                                                                                   vrefdqrden_reg_pom, 
  input   wire                                                                                   vrefdqrdr_reg_ptsr, 
  input   wire    [PHY_SLICE_NUM*PHY_VREF_WIDTH-1:0]                                             vrefdqrds_reg_ptsr, 
  input   wire    [PHY_VREF_WIDTH - 1:0]                                                         vrefdqs_reg_lpmr14_fs0, 
  input   wire    [PHY_VREF_WIDTH - 1:0]                                                         vrefdqs_reg_lpmr14_fs1, 
  input   wire    [PHY_VREF_WIDTH - 1:0]                                                         vrefdqsw_reg_vtgc, 
  input   wire                                                                                   vrefdqwren_reg_pom, 
  input   wire    [CHAN_RANK_NUM - 1:0]                                                          vrefdqwrr_reg_ptsr, 
  input   wire    [CHAN_RANK_NUM * PHY_VREF_WIDTH - 1:0]                                         vrefdqwrs_reg_ptsr, 
  input   wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * PHY_WRLVL_DLY_WIDTH - 1:0]                    wrlvl_reg_ptsr, 
  input   wire                                                                                   wrlvlen_reg_pom, 
  output  wire    [DRAM_CHAN_NUM * AXI4_DATA_WIDTH / 8 - 1:0]                                    DTI_RDDATA_MASK_MC, 
  output  wire    [DRAM_CHAN_NUM * AXI4_DATA_WIDTH - 1:0]                                        DTI_RDDATA_MC, 
  output  wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                                        DTI_RDDATA_VALID_MC, 
  output  wire    [DRAM_CHAN_NUM-1:0]                                                            JTAG_SO_CLK, 
  output  wire    [PHY_CTRL_WIDTH - 1:0]                                                         JTAG_SO_CTL, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                            JTAG_SO_DM, 
  output  wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                          JTAG_SO_DQ, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                            JTAG_SO_DQS, 
  output  wire    [DRAM_CHAN_NUM-1:0]                                                            LOCK_REG_DLLCA, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                            LOCK_REG_DLLDQ, 
  output  wire    [3:0]                                                                          NBC_REG_PCSR, 
  output  wire    [DRAM_CHAN_NUM-1:0]                                                            OVFL_REG_DLLCA, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                            OVFL_REG_DLLDQ, 
  output  wire    [1:0]                                                                          PAD_MEM_CLK, 
  output  wire    [1:0]                                                                          PAD_MEM_CLK_N, 
  output  wire    [PHY_CTRL_WIDTH - 1:0]                                                         PAD_MEM_CTL, 
  output  wire    [3:0]                                                                          PBC_REG_PCSR, 
  output  wire    [DRAM_CHAN_NUM-1:0]                                                            SO_CLK, 
  output  wire    [PHY_CTRL_WIDTH - 1:0]                                                         SO_CTL, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                            SO_DM, 
  output  wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                          SO_DQ, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                            SO_RD, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                            SO_WR, 
  output  wire    [DRAM_CHAN_NUM-1:0]                                                            UNFL_REG_DLLCA, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                            UNFL_REG_DLLDQ, 
  output  wire                                                                                   UPDT_C_REG_PCSR, 
  output  wire    [DRAM_CHAN_NUM-1:0]                                                            YC_CLK, 
  output  wire    [PHY_CTRL_WIDTH - 1:0]                                                         YC_CTL, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                            Y_DM, 
  output  wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                          Y_DQ, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                            Y_DQS, 
  output  wire                                                                                   bist_done_reg_pbsr, 
  output  wire    [PHY_CTRL_WIDTH-1:0]                                                           bist_err_ctl_reg_pbsr, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                            bist_err_dm_reg_pbsr, 
  output  wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                          bist_err_dq_reg_pbsr, 
  output  wire    [CHAN_RANK_NUM * DRAM_CHAN_NUM * PHY_CA_WIDTH * PHY_CALVL_DLY_WIDTH - 1:0]     ca_reg_ptsr_ip, 
  output  wire                                                                                   clklockc_reg_pos, 
  output  wire                                                                                   cmddlyc_reg_pos, 
  output  wire    [CHAN_RANK_NUM * DRAM_CHAN_NUM * PHY_CALVL_SET_WIDTH - 1:0]                    cs_reg_ptsr_ip, 
  output  wire    [PHY_SLICE_NUM+DRAM_CHAN_NUM-1:0]                                              dllerr_reg_pts, 
  output  wire                                                                                   dllrstc_reg_pos, 
  output  wire    [CHAN_RANK_NUM - 1:0]                                                          dlyevalc_reg_pos, 
  output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * PHY_WDM_DLY_WIDTH - 1:0]                      dqsdm_reg_ptsr_ip, 
  output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM - 1:0]                                          dqsdmerr_reg_pts, 
  output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * DFI_SLICE_WIDTH * PHY_WDQ_DLY_WIDTH - 1:0]    dqsdq_reg_ptsr_ip, 
  output  wire    [CHAN_RANK_NUM - 1:0]                                                          dqsdqc_reg_pos, 
  output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * DFI_SLICE_WIDTH - 1:0]                        dqsdqerr_reg_pts, 
  output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM - 1:0]                                          dqsleadck_reg_ptsr_ip, 
  output  wire                                                                                   draminitc_reg_pos, 
  output  wire                                                                                   fs0req_reg_pos, 
  output  wire                                                                                   fs1req_reg_pos, 
  output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * PHY_GATE_DLY_WIDTH - 1:0]                     gt_reg_ptsr_ip, 
  output  wire    [CHAN_RANK_NUM - 1:0]                                                          gtc_reg_pos, 
  output  wire    [CHAN_RANK_NUM*PHY_SLICE_NUM-1:0]                                              gterr_reg_pts, 
  output  wire    [CHAN_RANK_NUM*DRAM_CHAN_NUM-1:0]                                              lp3calvlerr_reg_pts, 
  output  wire                                                                                   mupd_reg_dqsdqcr_clr, 
  output  wire                                                                                   nt_rank_reg_ptsr_ip, 
  output  wire                                                                                   ofs_reg_pos, 
  output  wire                                                                                   phyfsc_reg_pos, 
  output  wire                                                                                   phyinitc_reg_pos, 
  output  wire                                                                                   physetc_reg_pos, 
  output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM - 1:0]                                          psck_reg_ptsr_ip, 
  output  wire                                                                                   ptsr_upd, 
  output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * DFI_SLICE_WIDTH * PHY_RDLVL_DLY_WIDTH - 1:0]  rdlvl_reg_ptsr_ip, 
  output  wire    [CHAN_RANK_NUM - 1:0]                                                          rdlvlc_reg_pos, 
  output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * PHY_RDLVL_DLY_WIDTH - 1:0]                    rdlvldm_reg_ptsr_ip, 
  output  wire    [CHAN_RANK_NUM*PHY_SLICE_NUM-1:0]                                              rdlvldmerr_reg_pts, 
  output  wire    [CHAN_RANK_NUM*PHY_SLICE_NUM*DFI_SLICE_WIDTH-1:0]                              rdlvldqerr_reg_pts, 
  output  wire    [CHAN_RANK_NUM - 1:0]                                                          sanchkc_reg_pos, 
  output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM - 1:0]                                          sanchkerr_reg_pts, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr11_fs0, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr11_fs1, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr11_nt_fs0, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr11_nt_fs1, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr12_fs0, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr12_fs1, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr13, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr13_nt, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr14_fs0, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr14_fs1, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr1_fs0, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr1_fs1, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr22_fs0, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr22_fs1, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr22_nt_fs0, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr22_nt_fs1, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr2_fs0, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr2_fs1, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr3_fs0, 
  output  wire    [MRR_DATA_WIDTH - 1:0]                                                         shad_reg_lpddr4_mr3_fs1, 
  output  wire                                                                                   srstc_reg_pcsr, 
  output  wire                                                                                   vrefcac_reg_pos, 
  output  wire    [CHAN_RANK_NUM * DRAM_CHAN_NUM-1:0]                                            vrefcaerr_reg_pts, 
  output  wire    [CHAN_RANK_NUM - 1:0]                                                          vrefcar_reg_ptsr_ip, 
  output  wire    [CHAN_RANK_NUM * PHY_VREF_WIDTH - 1:0]                                         vrefcas_reg_ptsr_ip, 
  output  wire    [CHAN_RANK_NUM - 1:0]                                                          vrefdqr_reg_ptsr_ip, 
  output  wire                                                                                   vrefdqrdc_reg_pos, 
  output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM - 1:0]                                          vrefdqrderr_reg_pts, 
  output  wire                                                                                   vrefdqrdr_reg_ptsr_ip, 
  output  wire    [PHY_SLICE_NUM * PHY_VREF_WIDTH - 1:0]                                         vrefdqrds_reg_ptsr_ip, 
  output  wire    [CHAN_RANK_NUM * PHY_VREF_WIDTH - 1:0]                                         vrefdqs_reg_ptsr_ip, 
  output  wire    [CHAN_RANK_NUM - 1:0]                                                          vrefdqwrc_reg_pos, 
  output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM - 1:0]                                          vrefdqwrerr_reg_pts, 
  output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * PHY_WRLVL_DLY_WIDTH - 1:0]                    wrlvl_reg_ptsr_ip, 
  output  wire    [CHAN_RANK_NUM - 1:0]                                                          wrlvlc_reg_pos, 
  output  wire    [CHAN_RANK_NUM*PHY_SLICE_NUM-1:0]                                              wrlvlerr_reg_pts, 
  inout   wire                                                                                   PAD_COMP, 
  inout   wire    [PHY_SLICE_NUM-1:0]                                                            PAD_MEM_DM, 
  inout   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH-1:0]                                            PAD_MEM_DQ, 
  inout   wire    [PHY_SLICE_NUM-1:0]                                                            PAD_MEM_DQS, 
  inout   wire    [PHY_SLICE_NUM-1:0]                                                            PAD_MEM_DQS_N, 
  inout   wire                                                                                   PAD_VREF
);


// Internal Declarations


// Local declarations

// Internal signal declarations
wire  [DRAM_CHAN_NUM * PHY_CMD_DLY_WIDTH - 1:0]                      ACTN_DLY_INT;
wire  [DRAM_CHAN_NUM*PHY_CMD_DLY_WIDTH-1:0]                          ACTN_DLY_SYNC;
wire  [6:0]                                                          ACT_N_DLY;
wire  [DRAM_CHAN_NUM * DRAM_BA_WIDTH * PHY_CMD_DLY_WIDTH - 1:0]      BA_DLY_INT;
wire  [DRAM_CHAN_NUM*DRAM_BA_WIDTH*PHY_CMD_DLY_WIDTH-1:0]            BA_DLY_SYNC;
wire  [PHY_SLICE_NUM-1:0]                                            BISTERR_DM;
wire  [PHY_SLICE_NUM*DFI_SLICE_WIDTH-1:0]                            BISTERR_DQ;
wire                                                                 BIST_DONE;
wire                                                                 BIST_DONE_CTL;
wire  [PHY_SLICE_NUM-1:0]                                            BIST_DONE_DQ;
wire                                                                 BIST_EN;
wire                                                                 BIST_ERR_ACT_N;
wire  [17:0]                                                         BIST_ERR_CA;
wire  [3:0]                                                          BIST_ERR_CKE;
wire  [3:0]                                                          BIST_ERR_CS;
wire  [PHY_CTRL_WIDTH-1:0]                                           BIST_ERR_CTL;
wire  [1:0]                                                          BIST_ERR_ODT;
wire                                                                 BIST_ERR_RESET_N;
wire                                                                 BIST_START;
wire  [DLL_BYPC_WIDTH-1:0]                                           BYPC_CTL;
wire  [DRAM_CHAN_NUM*DLL_BYPC_WIDTH-1:0]                             BYPC_CTL_SYNC;
wire  [PHY_SLICE_NUM*DLL_BYPC_WIDTH - 1:0]                           BYPC_DQ;
wire  [PHY_SLICE_NUM - 1:0]                                          BYPEN_VREF_SET;
wire  [PHY_SLICE_NUM - 1:0]                                          BYPEN_VREF_SET_INT;
wire                                                                 BYP_CTL;
wire  [DRAM_CHAN_NUM-1:0]                                            BYP_CTL_SYNC;
wire  [PHY_SLICE_NUM-1:0]                                            BYP_DQ;
wire  [PHY_SLICE_NUM * PHY_VREF_WIDTH - 1:0]                         BYP_VREF_SET;
wire  [PHY_SLICE_NUM * PHY_VREF_WIDTH - 1:0]                         BYP_VREF_SET_INT;
wire  [PHY_SLICE_NUM-1:0]                                            BYTE_RANK_RD;
wire  [PHY_SLICE_NUM-1:0]                                            BYTE_RANK_WR;
wire  [PHY_SLICE_NUM*2 * DFI_SLICE_WIDTH - 1:0]                      BYTE_RDDATA;
wire  [PHY_SLICE_NUM-1:0]                                            BYTE_RDDATA_EN;
wire  [PHY_SLICE_NUM*2-1:0]                                          BYTE_RDDATA_MASK;
wire  [PHY_SLICE_NUM-1:0]                                            BYTE_RDDATA_VALID;
wire  [PHY_SLICE_NUM*2 * DFI_SLICE_WIDTH - 1:0]                      BYTE_WRDATA;
wire  [PHY_SLICE_NUM-1:0]                                            BYTE_WRDATA_EN;
wire  [PHY_SLICE_NUM*2-1:0]                                          BYTE_WRDATA_MASK;
wire  [23:0]                                                         CALVL_STATUS;
wire  [6:0]                                                          CKE0_DLY;
wire  [6:0]                                                          CKE1_DLY;
wire  [6:0]                                                          CKE2_DLY;
wire  [6:0]                                                          CKE3_DLY;
wire  [DRAM_CHAN_NUM * CHAN_RANK_NUM * PHY_CMD_DLY_WIDTH - 1:0]      CKE_DLY_INT;
wire  [DRAM_CHAN_NUM*CHAN_RANK_NUM*PHY_CMD_DLY_WIDTH-1:0]            CKE_DLY_SYNC;
wire  [CLK_DLY_WIDTH-1:0]                                            CLK0_DLY;
wire  [CLK_DLY_WIDTH-1:0]                                            CLK1_DLY;
wire  [DRAM_CHAN_NUM*CLK_DLY_WIDTH-1:0]                              CLK_DLY_SYNC;
wire                                                                 CLOCKDR_ACT_N;
wire  [17:0]                                                         CLOCKDR_CA;
wire  [3:0]                                                          CLOCKDR_CKE;
wire  [3:0]                                                          CLOCKDR_CS;
wire  [1:0]                                                          CLOCKDR_ODT;
wire                                                                 CLOCKDR_RESET_N;
wire  [PHY_SLICE_NUM-1:0]                                            CMOS_EN_REG_DIOR_INT;
wire                                                                 COMP_IN;
wire                                                                 COMP_RST_N_INT;
wire  [DRAM_CHAN_NUM * CHAN_RANK_NUM * PHY_CSLVL_SET_WIDTH-1:0]      CSLVL_SET;
wire  [3:0]                                                          CSLVL_STATUS;
wire  [DRAM_CHAN_NUM-1:0]                                            DLL_EN_CA_INT;
wire                                                                 DLL_EN_CTL;
wire  [DRAM_CHAN_NUM-1:0]                                            DLL_EN_CTL_SYNC;
wire  [PHY_SLICE_NUM-1:0]                                            DLL_EN_DQ;
wire  [PHY_SLICE_NUM-1:0]                                            DLL_EN_DQ_INT;
wire  [DRAM_CHAN_NUM-1:0]                                            DLL_RESET_CA_INT;
wire                                                                 DLL_RESET_CTL;
wire  [DRAM_CHAN_NUM-1:0]                                            DLL_RESET_CTL_SYNC;
wire  [PHY_SLICE_NUM-1:0]                                            DLL_RESET_DQ;
wire  [PHY_SLICE_NUM-1:0]                                            DLL_RESET_DQ_INT;
wire  [DRAM_CHAN_NUM-1:0]                                            DLL_UPDT_EN_CA_INT;
wire                                                                 DLL_UPDT_EN_CTL;
wire  [DRAM_CHAN_NUM-1:0]                                            DLL_UPDT_EN_CTL_SYNC;
wire  [PHY_SLICE_NUM-1:0]                                            DLL_UPDT_EN_DQ;
wire  [PHY_SLICE_NUM-1:0]                                            DLL_UPDT_EN_DQ_INT;
wire  [2:0]                                                          DRVSEL_CTL;
wire  [DRAM_CHAN_NUM*3-1:0]                                          DRVSEL_CTL_SYNC;
wire  [PHY_SLICE_NUM*3-1:0]                                          DRVSEL_REG_DIOR_INT;
wire  [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                        DTI_ACT_N;
wire  [DRAM_CHAN_NUM*FREQUENCY_RATIO-1:0]                            DTI_ACT_N_CTL;
wire  [DRAM_CHAN_NUM - 1:0]                                          DTI_ACT_N_INT;
wire  [DRAM_CHAN_NUM * DRAM_BA_WIDTH * FREQUENCY_RATIO - 1:0]        DTI_BA;
wire  [DRAM_CHAN_NUM*DRAM_BA_WIDTH*FREQUENCY_RATIO-1:0]              DTI_BA_CTL;
wire  [DRAM_CHAN_NUM * DRAM_BA_WIDTH - 1:0]                          DTI_BA_INT;
wire  [DRAM_CHAN_NUM * PHY_CA_WIDTH * FREQUENCY_RATIO - 1:0]         DTI_CA;
wire                                                                 DTI_CALVL_CAPTURE;
wire  [DRAM_CHAN_NUM - 1:0]                                          DTI_CALVL_CAPTURE_CTL;
wire  [DRAM_CHAN_NUM - 1:0]                                          DTI_CALVL_CAPTURE_INT;
wire                                                                 DTI_CALVL_CTRL_EN;
wire  [DRAM_CHAN_NUM - 1:0]                                          DTI_CALVL_CTRL_EN_INT;
wire  [DRAM_CHAN_NUM-1:0]                                            DTI_CALVL_CTRL_EN_SYNC;
wire  [PHY_SLICE_NUM * PHY_CALVL_DATA_WIDTH - 1:0]                   DTI_CALVL_DATA;
wire  [PHY_SLICE_NUM * PHY_CALVL_DATA_WIDTH - 1:0]                   DTI_CALVL_DATA_INT;
wire  [125:0]                                                        DTI_CALVL_DLY;
wire  [DRAM_CHAN_NUM * PHY_CA_WIDTH * PHY_CALVL_DLY_WIDTH - 1:0]     DTI_CALVL_DLY_INT;
wire  [DRAM_CHAN_NUM*PHY_CA_WIDTH*PHY_CALVL_DLY_WIDTH-1:0]           DTI_CALVL_DLY_SYNC;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_CALVL_DQ_EN;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_CALVL_DQ_EN_INT;
wire                                                                 DTI_CALVL_LOAD;
wire  [DRAM_CHAN_NUM - 1:0]                                          DTI_CALVL_LOAD_CTL;
wire  [DRAM_CHAN_NUM - 1:0]                                          DTI_CALVL_LOAD_INT;
wire                                                                 DTI_CALVL_RESULT;
wire                                                                 DTI_CALVL_RESULT_B;
wire  [DRAM_CHAN_NUM - 1:0]                                          DTI_CALVL_RESULT_INT;
wire  [DRAM_CHAN_NUM-1:0]                                            DTI_CALVL_RESULT_SYNC;
wire  [DRAM_CHAN_NUM * PHY_CA_SET_WIDTH * CHAN_RANK_NUM - 1:0]       DTI_CALVL_STATUS_INT;
wire  [DRAM_CHAN_NUM*PHY_CA_SET_WIDTH*CHAN_RANK_NUM-1:0]             DTI_CALVL_STATUS_SYNC;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_CALVL_STB;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_CALVL_STB_INT;
wire  [DRAM_CHAN_NUM*PHY_CA_WIDTH*FREQUENCY_RATIO-1:0]               DTI_CA_CTL;
wire  [DRAM_CHAN_NUM * PHY_CA_WIDTH - 1:0]                           DTI_CA_INT;
wire  [DRAM_CHAN_NUM * DRAM_LP3_CA_WIDTH * FREQUENCY_RATIO - 1:0]    DTI_CA_L;
wire  [DRAM_CHAN_NUM*DRAM_LP3_CA_WIDTH*FREQUENCY_RATIO-1:0]          DTI_CA_L_CTL;
wire  [DRAM_CHAN_NUM * DRAM_LP3_CA_WIDTH - 1:0]                      DTI_CA_L_INT;
wire  [DRAM_CHAN_NUM * CHAN_RANK_NUM * FREQUENCY_RATIO - 1:0]        DTI_CKE;
wire  [DRAM_CHAN_NUM*CHAN_RANK_NUM*FREQUENCY_RATIO-1:0]              DTI_CKE_CTL;
wire  [DRAM_CHAN_NUM * CHAN_RANK_NUM - 1:0]                          DTI_CKE_INT;
wire                                                                 DTI_CMDDLY_LOAD;
wire  [DRAM_CHAN_NUM - 1:0]                                          DTI_CMDDLY_LOAD_CTL;
wire  [DRAM_CHAN_NUM - 1:0]                                          DTI_CMDDLY_LOAD_INT;
wire  [DRAM_CHAN_NUM * CHAN_RANK_NUM * FREQUENCY_RATIO - 1:0]        DTI_CS;
wire  [27:0]                                                         DTI_CSLVL_DLY;
wire  [DRAM_CHAN_NUM * CHAN_RANK_NUM * PHY_CSLVL_DLY_WIDTH - 1:0]    DTI_CSLVL_DLY_INT;
wire  [DRAM_CHAN_NUM*CHAN_RANK_NUM*PHY_CSLVL_DLY_WIDTH-1:0]          DTI_CSLVL_DLY_SYNC;
wire  [DRAM_CHAN_NUM * CHAN_RANK_NUM * PHY_CSLVL_SET_WIDTH - 1:0]    DTI_CSLVL_SET_INT;
wire  [DRAM_CHAN_NUM * CHAN_RANK_NUM - 1:0]                          DTI_CSLVL_STATUS_INT;
wire  [DRAM_CHAN_NUM*CHAN_RANK_NUM*FREQUENCY_RATIO-1:0]              DTI_CS_CTL;
wire  [DRAM_CHAN_NUM * CHAN_RANK_NUM - 1:0]                          DTI_CS_INT;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_DATA_BYTE_DISABLE_INT;
wire                                                                 DTI_DRAM_CLK_DISABLE_INT;
wire                                                                 DTI_DRAM_CLK_DISABLE_PHY;
wire  [1:0]                                                          DTI_FREQ_RATIO_INT;
wire                                                                 DTI_GEARDOWN_EN            = 0;
wire  [PHY_SLICE_NUM * PHY_GATE_DLY_WIDTH - 1:0]                     DTI_GTPH_R0;
wire  [PHY_SLICE_NUM * PHY_GATE_DLY_WIDTH - 1:0]                     DTI_GTPH_R0_INT;
wire  [PHY_SLICE_NUM * PHY_GATE_DLY_WIDTH - 1:0]                     DTI_GTPH_R1;
wire  [PHY_SLICE_NUM * PHY_GATE_DLY_WIDTH - 1:0]                     DTI_GTPH_R1_INT;
wire  [PHY_SLICE_NUM * HOLD_WIDTH - 1:0]                             DTI_HOLD_R0;
wire  [PHY_SLICE_NUM * HOLD_WIDTH - 1:0]                             DTI_HOLD_R1;
wire                                                                 DTI_INIT_COMPLETE_CA;
wire  [DRAM_CHAN_NUM-1:0]                                            DTI_INIT_COMPLETE_CA_INT;
wire  [DRAM_CHAN_NUM-1:0]                                            DTI_INIT_COMPLETE_CA_SYNC;
wire  [PHY_SLICE_NUM-1:0]                                            DTI_INIT_COMPLETE_DQ;
wire  [PHY_SLICE_NUM-1:0]                                            DTI_INIT_COMPLETE_DQ_INT;
wire                                                                 DTI_MC_CLOCK_180;
wire  [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                        DTI_ODT;
wire  [DRAM_CHAN_NUM*FREQUENCY_RATIO-1:0]                            DTI_ODT_CTL;
wire  [DRAM_CHAN_NUM - 1:0]                                          DTI_ODT_INT;
wire                                                                 DTI_PHY_CLOCK_180;
wire  [DRAM_CHAN_NUM * PHY_CA_SET_WIDTH * PHY_CALVL_SET_WIDTH - 1:0] DTI_R0_CALVL_SET_INT;
wire  [DRAM_CHAN_NUM*PHY_CA_SET_WIDTH*PHY_CALVL_SET_WIDTH-1:0]       DTI_R0_CALVL_SET_SYNC;
wire  [DRAM_CHAN_NUM * PHY_CA_SET_WIDTH * PHY_CALVL_SET_WIDTH - 1:0] DTI_R1_CALVL_SET_INT;
wire  [DRAM_CHAN_NUM*PHY_CA_SET_WIDTH*PHY_CALVL_SET_WIDTH-1:0]       DTI_R1_CALVL_SET_SYNC;
wire  [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                        DTI_RANK;
wire                                                                 DTI_RANK_A;
wire                                                                 DTI_RANK_B;
wire  [DRAM_CHAN_NUM*FREQUENCY_RATIO-1:0]                            DTI_RANK_CTL;
wire  [DRAM_CHAN_NUM - 1:0]                                          DTI_RANK_INT;
wire  [PHY_SLICE_NUM * FREQUENCY_RATIO - 1:0]                        DTI_RANK_RD;
wire  [PHY_SLICE_NUM*FREQUENCY_RATIO-1:0]                            DTI_RANK_RD_CTL;
wire  [PHY_SLICE_NUM * FREQUENCY_RATIO - 1:0]                        DTI_RANK_WR;
wire  [PHY_SLICE_NUM*FREQUENCY_RATIO-1:0]                            DTI_RANK_WR_CTL;
wire  [PHY_SLICE_NUM * 2 * DFI_SLICE_WIDTH * FREQUENCY_RATIO - 1:0]  DTI_RDDATA;
wire  [PHY_SLICE_NUM * FREQUENCY_RATIO - 1:0]                        DTI_RDDATA_EN;
wire  [PHY_SLICE_NUM*FREQUENCY_RATIO-1:0]                            DTI_RDDATA_EN_CTL;
wire  [PHY_SLICE_NUM * 2 * FREQUENCY_RATIO - 1:0]                    DTI_RDDATA_MASK;
wire  [PHY_SLICE_NUM * FREQUENCY_RATIO - 1:0]                        DTI_RDDATA_VALID;
wire  [PHY_SLICE_NUM * DFI_SLICE_WIDTH * PHY_RDLVL_DLY_WIDTH - 1:0]  DTI_RDLVL_DLY;
wire  [PHY_SLICE_NUM * PHY_RDLVL_DLY_WIDTH - 1:0]                    DTI_RDLVL_DLY_DM;
wire  [PHY_SLICE_NUM * PHY_RDLVL_DLY_WIDTH - 1:0]                    DTI_RDLVL_DLY_DM_INT;
wire  [PHY_SLICE_NUM * DFI_SLICE_WIDTH * PHY_RDLVL_DLY_WIDTH - 1:0]  DTI_RDLVL_DLY_INT;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_RDLVL_EDGE;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_RDLVL_EDGE_INT;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_RDLVL_EN;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_RDLVL_EN_DM;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_RDLVL_EN_DM_INT;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_RDLVL_EN_INT;
wire  [PHY_SLICE_NUM * PHY_GATE_DLY_WIDTH - 1:0]                     DTI_RDLVL_GATE_DLY;
wire  [PHY_SLICE_NUM * PHY_GATE_DLY_WIDTH - 1:0]                     DTI_RDLVL_GATE_DLY_INT;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_RDLVL_GATE_EN;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_RDLVL_GATE_EN_INT;
wire  [PHY_SLICE_NUM * CHAN_RANK_NUM - 1:0]                          DTI_RDLVL_GATE_STATUS;
wire  [PHY_SLICE_NUM * CHAN_RANK_NUM - 1:0]                          DTI_RDLVL_GATE_STATUS_INT;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_RDLVL_LOAD;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_RDLVL_LOAD_INT;
wire  [PHY_SLICE_NUM * DFI_SLICE_WIDTH * PHY_RDLVL_DLY_WIDTH - 1:0]  DTI_RDLVL_SET;
wire  [PHY_SLICE_NUM * PHY_RDLVL_DLY_WIDTH - 1:0]                    DTI_RDLVL_SET_DM;
wire  [PHY_SLICE_NUM * PHY_RDLVL_DLY_WIDTH - 1:0]                    DTI_RDLVL_SET_DM_INT;
wire  [PHY_SLICE_NUM * DFI_SLICE_WIDTH * PHY_RDLVL_DLY_WIDTH - 1:0]  DTI_RDLVL_SET_INT;
wire  [PHY_SLICE_NUM * DFI_SLICE_WIDTH - 1:0]                        DTI_RDLVL_STATUS;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_RDLVL_STATUS_DM;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_RDLVL_STATUS_DM_INT;
wire  [PHY_SLICE_NUM * DFI_SLICE_WIDTH - 1:0]                        DTI_RDLVL_STATUS_INT;
wire  [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                        DTI_RESET_N;
wire  [DRAM_CHAN_NUM*FREQUENCY_RATIO-1:0]                            DTI_RESET_N_CTL;
wire  [DRAM_CHAN_NUM - 1:0]                                          DTI_RESET_N_INT;
wire                                                                 DTI_RN_CALVL_INT;
wire  [DRAM_CHAN_NUM-1:0]                                            DTI_RN_CALVL_SYNC;
wire                                                                 DTI_VREF_EN_CTL;
wire  [DRAM_CHAN_NUM-1:0]                                            DTI_VREF_EN_CTL_SYNC;
wire  [PHY_SLICE_NUM-1:0]                                            DTI_VREF_EN_DQ;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_VREF_LOAD;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_VREF_LOAD_INT;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_VREF_RANGE;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_VREF_RANGE_INT;
wire  [PHY_SLICE_NUM * PHY_VREF_WIDTH - 1:0]                         DTI_VREF_SET;
wire  [PHY_VREF_WIDTH - 1:0]                                         DTI_VREF_SET_CTL;
wire  [DRAM_CHAN_NUM*PHY_VREF_WIDTH - 1:0]                           DTI_VREF_SET_CTL_SYNC;
wire  [PHY_SLICE_NUM * PHY_VREF_WIDTH - 1:0]                         DTI_VREF_SET_INT;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_VT_DONE;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_VT_DONE_INT;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_VT_EN;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_VT_EN_INT;
wire  [PHY_SLICE_NUM * PHY_WDM_DLY_WIDTH - 1:0]                      DTI_WDM_DLY;
wire  [PHY_SLICE_NUM * PHY_WDM_DLY_WIDTH - 1:0]                      DTI_WDM_DLY_INT;
wire  [PHY_SLICE_NUM * DFI_SLICE_WIDTH * PHY_WDQ_DLY_WIDTH - 1:0]    DTI_WDQ_DLY;
wire  [PHY_SLICE_NUM * DFI_SLICE_WIDTH * PHY_WDQ_DLY_WIDTH - 1:0]    DTI_WDQ_DLY_INT;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_WDQ_LOAD;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_WDQ_LOAD_INT;
wire  [PHY_SLICE_NUM * 2 * DFI_SLICE_WIDTH * FREQUENCY_RATIO - 1:0]  DTI_WRDATA;
wire  [PHY_SLICE_NUM*2*DFI_SLICE_WIDTH*FREQUENCY_RATIO-1:0]          DTI_WRDATA_CTL;
wire  [PHY_SLICE_NUM * FREQUENCY_RATIO - 1:0]                        DTI_WRDATA_EN;
wire  [PHY_SLICE_NUM*FREQUENCY_RATIO-1:0]                            DTI_WRDATA_EN_CTL;
wire  [PHY_SLICE_NUM * 2 * FREQUENCY_RATIO - 1:0]                    DTI_WRDATA_MASK;
wire  [PHY_SLICE_NUM*2*FREQUENCY_RATIO-1:0]                          DTI_WRDATA_MASK_CTL;
wire  [PHY_SLICE_NUM * (PHY_WRLVL_DLY_WIDTH + 1) - 1:0]              DTI_WRLVL_DLY;
wire  [PHY_SLICE_NUM * (PHY_WRLVL_DLY_WIDTH + 1) - 1:0]              DTI_WRLVL_DLY_INT;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_WRLVL_EN;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_WRLVL_EN_INT;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_WRLVL_LOAD;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_WRLVL_LOAD_INT;
wire  [PHY_SLICE_NUM*DFI_SLICE_WIDTH-1:0]                            DTI_WRLVL_RESP;
wire  [PHY_SLICE_NUM * PHY_WRLVL_DLY_WIDTH - 1:0]                    DTI_WRLVL_SET;
wire  [PHY_SLICE_NUM * PHY_WRLVL_DLY_WIDTH - 1:0]                    DTI_WRLVL_SET_INT;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_WRLVL_STATUS;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_WRLVL_STATUS_INT;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_WRLVL_STB;
wire  [PHY_SLICE_NUM - 1:0]                                          DTI_WRLVL_STB_INT;
wire                                                                 E_CMOS_CTL;
wire  [DRAM_CHAN_NUM-1:0]                                            E_CMOS_CTL_SYNC;
wire  [PHY_SLICE_NUM-1:0]                                            FENA_RCV;
wire  [PHY_SLICE_NUM-1:0]                                            FENA_RCV_INT;
wire  [PHY_SLICE_NUM-1:0]                                            GT_DIS;
wire  [PHY_SLICE_NUM-1:0]                                            GT_UPDT;
wire  [2:0]                                                          IO_MODE;
wire                                                                 JTAG_SI_ACT_N;
wire  [17:0]                                                         JTAG_SI_CA;
wire  [3:0]                                                          JTAG_SI_CKE;
wire  [3:0]                                                          JTAG_SI_CS;
wire  [1:0]                                                          JTAG_SI_ODT;
wire                                                                 JTAG_SI_RESET_N;
wire                                                                 JTAG_SO_ACT_N;
wire  [17:0]                                                         JTAG_SO_CA;
wire  [3:0]                                                          JTAG_SO_CKE;
wire  [3:0]                                                          JTAG_SO_CS;
wire  [1:0]                                                          JTAG_SO_ODT;
wire                                                                 JTAG_SO_RESET_N;
wire  [15:0]                                                         L3_DQ_RESP;
wire  [5:0]                                                          L4_DQ_RESP_A;
wire  [5:0]                                                          L4_DQ_RESP_B;
wire  [4:0]                                                          LIMIT_CTL;
wire  [DRAM_CHAN_NUM*DLL_LIM_WIDTH-1:0]                              LIMIT_CTL_SYNC;
wire  [PHY_SLICE_NUM*DLL_LIM_WIDTH - 1:0]                            LIMIT_DQ;
wire                                                                 LOCK_CTL;
wire  [DRAM_CHAN_NUM-1:0]                                            LOCK_CTL_SYNC;
wire  [PHY_SLICE_NUM-1:0]                                            LOCK_DQ;
wire                                                                 LP_EN_CTL;
wire  [PHY_SLICE_NUM-1:0]                                            LP_EN_DQ;
wire  [DRAM_CHAN_NUM-1:0]                                            LP_EN_REG_PBCR_CTL_SYNC;
wire                                                                 MEM_ACT_N;
wire  [17:0]                                                         MEM_CA;
wire  [3:0]                                                          MEM_CKE;
wire  [3:0]                                                          MEM_CS;
wire  [1:0]                                                          MEM_ODT;
wire                                                                 MEM_RESET_N;
wire                                                                 MODE_ACT_N;
wire  [17:0]                                                         MODE_CA;
wire  [3:0]                                                          MODE_CKE;
wire  [3:0]                                                          MODE_CS;
wire  [1:0]                                                          MODE_ODT;
wire                                                                 MODE_RESET_N;
wire  [11:0]                                                         NCTLH;
wire                                                                 NCTLH0;
wire  [PHY_SLICE_NUM-1:0]                                            NCTLH0_DQ;
wire                                                                 NCTLH1;
wire                                                                 NCTLH10;
wire  [PHY_SLICE_NUM-1:0]                                            NCTLH10_DQ;
wire                                                                 NCTLH11;
wire  [PHY_SLICE_NUM-1:0]                                            NCTLH11_DQ;
wire  [PHY_SLICE_NUM-1:0]                                            NCTLH1_DQ;
wire                                                                 NCTLH2;
wire  [PHY_SLICE_NUM-1:0]                                            NCTLH2_DQ;
wire                                                                 NCTLH3;
wire  [PHY_SLICE_NUM-1:0]                                            NCTLH3_DQ;
wire                                                                 NCTLH4;
wire  [PHY_SLICE_NUM-1:0]                                            NCTLH4_DQ;
wire                                                                 NCTLH5;
wire  [PHY_SLICE_NUM-1:0]                                            NCTLH5_DQ;
wire                                                                 NCTLH6;
wire  [PHY_SLICE_NUM-1:0]                                            NCTLH6_DQ;
wire                                                                 NCTLH7;
wire  [PHY_SLICE_NUM-1:0]                                            NCTLH7_DQ;
wire                                                                 NCTLH8;
wire  [PHY_SLICE_NUM-1:0]                                            NCTLH8_DQ;
wire                                                                 NCTLH9;
wire  [PHY_SLICE_NUM-1:0]                                            NCTLH9_DQ;
wire                                                                 NCTLHO0;
wire                                                                 NCTLHO1;
wire                                                                 NCTLHO10;
wire                                                                 NCTLHO11;
wire                                                                 NCTLHO2;
wire                                                                 NCTLHO3;
wire                                                                 NCTLHO4;
wire                                                                 NCTLHO5;
wire                                                                 NCTLHO6;
wire                                                                 NCTLHO7;
wire                                                                 NCTLHO8;
wire                                                                 NCTLHO9;
wire                                                                 ODIS_ACT_N;
wire  [17:0]                                                         ODIS_CA;
wire  [3:0]                                                          ODIS_CKE;
wire  [3:0]                                                          ODIS_CS;
wire  [PHY_SLICE_NUM-1:0]                                            ODIS_DM_REG_DIOR_INT;
wire  [PHY_SLICE_NUM-1:0]                                            ODIS_DQS_REG_DIOR_INT;
wire  [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                          ODIS_DQ_REG_DIOR_INT;
wire  [1:0]                                                          ODIS_ODT;
wire                                                                 ODIS_RESET_N;
wire  [6:0]                                                          ODT0_DLY;
wire  [6:0]                                                          ODT1_DLY;
wire  [DRAM_CHAN_NUM * PHY_CMD_DLY_WIDTH - 1:0]                      ODT_DLY_INT;
wire  [DRAM_CHAN_NUM*PHY_CMD_DLY_WIDTH-1:0]                          ODT_DLY_SYNC;
wire                                                                 OUTBYPEN_ACT_N;
wire  [17:0]                                                         OUTBYPEN_CA;
wire  [3:0]                                                          OUTBYPEN_CKE;
wire  [DRAM_CHAN_NUM-1:0]                                            OUTBYPEN_CLK;
wire  [3:0]                                                          OUTBYPEN_CS;
wire  [PHY_CTRL_WIDTH-1:0]                                           OUTBYPEN_CTL;
wire  [PHY_SLICE_NUM-1:0]                                            OUTBYPEN_DM;
wire  [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                          OUTBYPEN_DQ;
wire  [PHY_SLICE_NUM-1:0]                                            OUTBYPEN_DQS;
wire  [1:0]                                                          OUTBYPEN_ODT;
wire                                                                 OUTBYPEN_RESET_N;
wire                                                                 OUTD_ACT_N;
wire  [17:0]                                                         OUTD_CA;
wire  [3:0]                                                          OUTD_CKE;
wire  [DRAM_CHAN_NUM-1:0]                                            OUTD_CLK;
wire  [3:0]                                                          OUTD_CS;
wire  [PHY_CTRL_WIDTH-1:0]                                           OUTD_CTL;
wire  [PHY_SLICE_NUM-1:0]                                            OUTD_DM;
wire  [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                          OUTD_DQ;
wire  [PHY_SLICE_NUM-1:0]                                            OUTD_DQS;
wire  [1:0]                                                          OUTD_ODT;
wire                                                                 OUTD_RESET_N;
wire                                                                 OVFL_CTL;
wire  [DRAM_CHAN_NUM-1:0]                                            OVFL_CTL_SYNC;
wire  [PHY_SLICE_NUM-1:0]                                            OVFL_DQ;
wire  [11:0]                                                         PCTLH;
wire                                                                 PCTLH0;
wire  [PHY_SLICE_NUM-1:0]                                            PCTLH0_DQ;
wire                                                                 PCTLH1;
wire                                                                 PCTLH10;
wire  [PHY_SLICE_NUM-1:0]                                            PCTLH10_DQ;
wire                                                                 PCTLH11;
wire  [PHY_SLICE_NUM-1:0]                                            PCTLH11_DQ;
wire  [PHY_SLICE_NUM-1:0]                                            PCTLH1_DQ;
wire                                                                 PCTLH2;
wire  [PHY_SLICE_NUM-1:0]                                            PCTLH2_DQ;
wire                                                                 PCTLH3;
wire  [PHY_SLICE_NUM-1:0]                                            PCTLH3_DQ;
wire                                                                 PCTLH4;
wire  [PHY_SLICE_NUM-1:0]                                            PCTLH4_DQ;
wire                                                                 PCTLH5;
wire  [PHY_SLICE_NUM-1:0]                                            PCTLH5_DQ;
wire                                                                 PCTLH6;
wire  [PHY_SLICE_NUM-1:0]                                            PCTLH6_DQ;
wire                                                                 PCTLH7;
wire  [PHY_SLICE_NUM-1:0]                                            PCTLH7_DQ;
wire                                                                 PCTLH8;
wire  [PHY_SLICE_NUM-1:0]                                            PCTLH8_DQ;
wire                                                                 PCTLH9;
wire  [PHY_SLICE_NUM-1:0]                                            PCTLH9_DQ;
wire                                                                 PCTLHO0;
wire                                                                 PCTLHO1;
wire                                                                 PCTLHO10;
wire                                                                 PCTLHO11;
wire                                                                 PCTLHO2;
wire                                                                 PCTLHO3;
wire                                                                 PCTLHO4;
wire                                                                 PCTLHO5;
wire                                                                 PCTLHO6;
wire                                                                 PCTLHO7;
wire                                                                 PCTLHO8;
wire                                                                 PCTLHO9;
wire                                                                 PD;
wire                                                                 POR;
wire                                                                 PWRDNH_L;
wire                                                                 PWRDNH_R;
wire  [83:0]                                                         R0_CALVL_SET;
wire  [83:0]                                                         R1_CALVL_SET;
wire                                                                 REF                        = 0;
wire  [6:0]                                                          RESET_N_DLY;
wire  [DRAM_CHAN_NUM * PHY_CMD_DLY_WIDTH - 1:0]                      RESET_N_DLY_INT;
wire  [DRAM_CHAN_NUM*PHY_CMD_DLY_WIDTH-1:0]                          RESET_N_DLY_SYNC;
wire  [PHY_SLICE_NUM-1:0]                                            RET_ENI_H;
wire                                                                 RN_CALVL;
wire  [PHY_SLICE_NUM-1:0]                                            RTT_EN_REG_DIOR_INT;
wire  [PHY_SLICE_NUM*3-1:0]                                          RTT_SEL_REG_DIOR_INT;
wire                                                                 SEL;
wire                                                                 SHIFTDR_ACT_N;
wire  [17:0]                                                         SHIFTDR_CA;
wire  [3:0]                                                          SHIFTDR_CKE;
wire  [3:0]                                                          SHIFTDR_CS;
wire  [1:0]                                                          SHIFTDR_ODT;
wire                                                                 SHIFTDR_RESET_N;
wire                                                                 SI_ACT_N;
wire  [17:0]                                                         SI_CA;
wire  [3:0]                                                          SI_CKE;
wire  [3:0]                                                          SI_CS;
wire  [1:0]                                                          SI_ODT;
wire                                                                 SI_RESET_N;
wire                                                                 SO_ACT_N;
wire  [17:0]                                                         SO_CA;
wire  [3:0]                                                          SO_CKE;
wire  [3:0]                                                          SO_CS;
wire  [1:0]                                                          SO_ODT;
wire                                                                 SO_RESET_N;
wire                                                                 TPCK32;
wire  [11:0]                                                         TSTIO_NCTLH;
wire                                                                 TSTIO_NCTLH0;
wire                                                                 TSTIO_NCTLH1;
wire                                                                 TSTIO_NCTLH10;
wire                                                                 TSTIO_NCTLH11;
wire                                                                 TSTIO_NCTLH2;
wire                                                                 TSTIO_NCTLH3;
wire                                                                 TSTIO_NCTLH4;
wire                                                                 TSTIO_NCTLH5;
wire                                                                 TSTIO_NCTLH6;
wire                                                                 TSTIO_NCTLH7;
wire                                                                 TSTIO_NCTLH8;
wire                                                                 TSTIO_NCTLH9;
wire  [11:0]                                                         TSTIO_PCTLH;
wire                                                                 TSTIO_PCTLH0;
wire                                                                 TSTIO_PCTLH1;
wire                                                                 TSTIO_PCTLH10;
wire                                                                 TSTIO_PCTLH11;
wire                                                                 TSTIO_PCTLH2;
wire                                                                 TSTIO_PCTLH3;
wire                                                                 TSTIO_PCTLH4;
wire                                                                 TSTIO_PCTLH5;
wire                                                                 TSTIO_PCTLH6;
wire                                                                 TSTIO_PCTLH7;
wire                                                                 TSTIO_PCTLH8;
wire                                                                 TSTIO_PCTLH9;
wire                                                                 UNFL_CTL;
wire  [DRAM_CHAN_NUM-1:0]                                            UNFL_CTL_SYNC;
wire  [PHY_SLICE_NUM-1:0]                                            UNFL_DQ;
wire                                                                 UPDATEDR_ACT_N;
wire  [17:0]                                                         UPDATEDR_CA;
wire  [3:0]                                                          UPDATEDR_CKE;
wire  [3:0]                                                          UPDATEDR_CS;
wire  [1:0]                                                          UPDATEDR_ODT;
wire                                                                 UPDATEDR_RESET_N;
wire                                                                 WDATA_ACT_N;
wire  [17:0]                                                         WDATA_CA;
wire  [3:0]                                                          WDATA_CKE;
wire  [3:0]                                                          WDATA_CS;
wire  [9:0]                                                          WDATA_L_CA;
wire  [1:0]                                                          WDATA_ODT;
wire                                                                 WDATA_RESET_N;
wire                                                                 YC_ACT_N;
wire  [17:0]                                                         YC_CA;
wire  [3:0]                                                          YC_CKE;
wire  [3:0]                                                          YC_CS;
wire  [1:0]                                                          YC_ODT;
wire                                                                 YC_RESET_N;
wire  [DRAM_CHAN_NUM-1:0]                                            chanen_reg_pom_int;
wire                                                                 clklockc_reg_pos_int;
wire                                                                 clklocken_reg_pom_int;
wire  [DRAM_CHAN_NUM-1:0]                                            dfien_ctrl;
wire  [PHY_SLICE_NUM-1:0]                                            dfien_dq;
wire  [PHY_SLICE_NUM * CHAN_RANK_NUM - 1:0]                          dqsleadck;
wire  [PHY_SLICE_NUM*CHAN_RANK_NUM - 1:0]                            dqsleadck_int;
wire  [PHY_SLICE_NUM*CHAN_RANK_NUM-1:0]                              gterr_reg_pts_slice;
wire  [DRAM_CHAN_NUM-1:0]                                            mc_phase_lock_ctl;
wire  [PHY_SLICE_NUM-1:0]                                            mc_phase_lock_dq;
wire  [CHAN_RANK_NUM-1:0]                                            ranken_reg_pom_int;
wire  [PHY_SLICE_NUM*CHAN_RANK_NUM-1:0]                              rdlvldmerr_reg_pts_slice;
wire  [PHY_SLICE_NUM*DFI_SLICE_WIDTH*CHAN_RANK_NUM-1:0]              rdlvldqerr_reg_pts_slice;
wire                                                                 reg_ddr3_en_int;
wire                                                                 reg_ddr4_en_int;
wire                                                                 reg_dqs2ck_en_int;
wire                                                                 reg_dual_chan_en_int;
wire                                                                 reg_dual_rank_en_int;
wire                                                                 reg_dual_rank_int;
wire                                                                 reg_lpddr3_en_int;
wire                                                                 reg_lpddr4_en_int;
wire                                                                 srst_reg_pccr_int;
wire  [PHY_SLICE_NUM*CHAN_RANK_NUM-1:0]                              wrlvlerr_reg_pts_slice;


// Instances 
dti_clkinv dti_clkinv_mc( 
  .CKIN  (DTI_MC_CLOCK), 
  .CKOUT (DTI_MC_CLOCK_180)
); 

dti_clkinv dti_clkinv_phy( 
  .CKIN  (DTI_PHY_CLOCK), 
  .CKOUT (DTI_PHY_CLOCK_180)
); 

dti_tm16ffc_18ud15_lpd4_comp_jme dti_tm16ffc_18ud15_lpd4_comp_jme( 
  .TSTIO_PCTLH (TSTIO_PCTLH), 
  .TSTIO_NCTLH (TSTIO_NCTLH), 
  .BYP_P       (BYP_P_REG_PCCR), 
  .BYP_N       (BYP_N_REG_PCCR), 
  .IO_MODE     (IO_MODE), 
  .CLK         (COMP_CLOCK), 
  .CLKG        (TPCK32), 
  .UPDT_C      (UPDT_C_REG_PCSR), 
  .BYP_EN      (BYP_EN_REG_PCCR), 
  .NBC         (NBC_REG_PCSR), 
  .COMP_IN     (COMP_IN), 
  .MVG_EN      (MVG_EN_REG_PCCR), 
  .EN          (EN_REG_PCCR), 
  .PBC         (PBC_REG_PCSR), 
  .POR         (POR), 
  .UPDATE_EN   (UPD_EN_REG_PCCR), 
  .PD          (PD), 
  .SEL         (SEL), 
  .NCTLH       (NCTLH), 
  .PCTLH       (PCTLH), 
  .PWDNH       (PWRDNH_L), 
  .REF         (REF), 
  .VDD         (VDD), 
  .VSS         (VSS), 
  .VDDO        (VDDO)
); 

dti_tm16ffc_18ud15_lpd4_testpad_jme dti_tm16ffc_18ud15_lpd4_testpad_jme( 
  .TPCK32        (TPCK32), 
  .IO_MODE2      (IO_MODE[2]), 
  .IO_MODE1      (IO_MODE[1]), 
  .IO_MODE0      (IO_MODE[0]), 
  .TSTIO_PCTLH11 (TSTIO_PCTLH11), 
  .TSTIO_PCTLH10 (TSTIO_PCTLH10), 
  .TSTIO_PCTLH9  (TSTIO_PCTLH9), 
  .TSTIO_PCTLH8  (TSTIO_PCTLH8), 
  .TSTIO_PCTLH7  (TSTIO_PCTLH7), 
  .TSTIO_PCTLH6  (TSTIO_PCTLH6), 
  .TSTIO_PCTLH5  (TSTIO_PCTLH5), 
  .TSTIO_PCTLH4  (TSTIO_PCTLH4), 
  .TSTIO_PCTLH3  (TSTIO_PCTLH3), 
  .TSTIO_PCTLH2  (TSTIO_PCTLH2), 
  .TSTIO_PCTLH1  (TSTIO_PCTLH1), 
  .TSTIO_PCTLH0  (TSTIO_PCTLH0), 
  .TSTIO_NCTLH11 (TSTIO_NCTLH11), 
  .TSTIO_NCTLH10 (TSTIO_NCTLH10), 
  .TSTIO_NCTLH9  (TSTIO_NCTLH9), 
  .TSTIO_NCTLH8  (TSTIO_NCTLH8), 
  .TSTIO_NCTLH7  (TSTIO_NCTLH7), 
  .TSTIO_NCTLH6  (TSTIO_NCTLH6), 
  .TSTIO_NCTLH5  (TSTIO_NCTLH5), 
  .TSTIO_NCTLH4  (TSTIO_NCTLH4), 
  .TSTIO_NCTLH3  (TSTIO_NCTLH3), 
  .TSTIO_NCTLH2  (TSTIO_NCTLH2), 
  .TSTIO_NCTLH1  (TSTIO_NCTLH1), 
  .TSTIO_NCTLH0  (TSTIO_NCTLH0), 
  .PD            (PD), 
  .SEL           (SEL), 
  .Y             (COMP_IN), 
  .E             (TPADEN_REG_PCCR), 
  .NCTLH0        (NCTLH0), 
  .NCTLH1        (NCTLH1), 
  .NCTLH2        (NCTLH2), 
  .NCTLH3        (NCTLH3), 
  .NCTLH4        (NCTLH4), 
  .NCTLH5        (NCTLH5), 
  .NCTLH6        (NCTLH6), 
  .NCTLH7        (NCTLH7), 
  .NCTLH8        (NCTLH8), 
  .NCTLH9        (NCTLH9), 
  .NCTLH10       (NCTLH10), 
  .NCTLH11       (NCTLH11), 
  .PCTLH0        (PCTLH0), 
  .PCTLH1        (PCTLH1), 
  .PCTLH2        (PCTLH2), 
  .PCTLH3        (PCTLH3), 
  .PCTLH4        (PCTLH4), 
  .PCTLH5        (PCTLH5), 
  .PCTLH6        (PCTLH6), 
  .PCTLH7        (PCTLH7), 
  .PCTLH8        (PCTLH8), 
  .PCTLH9        (PCTLH9), 
  .PCTLH10       (PCTLH10), 
  .PCTLH11       (PCTLH11), 
  .PWDNH         (PWRDNH_L), 
  .REF           (REF), 
  .PAD           (PAD_COMP), 
  .VDD           (VDD), 
  .VSS           (VSS), 
  .VDDO          (VDDO)
); 

dti_tm16ffcd4lp4_18d_ctl30s2ckr2_jm dti_tm16ffcd4lp4_18d_ctl30s2ckr2_jm( 
  .ACT_N_DLY            (ACT_N_DLY), 
  .BIST_DONE            (BIST_DONE_CTL), 
  .BIST_EN              (BIST_EN), 
  .BIST_ERR_ACT_N       (BIST_ERR_ACT_N), 
  .BIST_ERR_CA          (BIST_ERR_CA), 
  .BIST_ERR_CKE         (BIST_ERR_CKE), 
  .BIST_ERR_CS          (BIST_ERR_CS), 
  .BIST_ERR_ODT         (BIST_ERR_ODT), 
  .BIST_ERR_RESET_N     (BIST_ERR_RESET_N), 
  .BIST_START           (BIST_START), 
  .BYP                  (BYP_CTL), 
  .BYPC                 (BYPC_CTL), 
  .CALVL_STATUS         (CALVL_STATUS), 
  .CKE0_DLY             (CKE0_DLY), 
  .CKE1_DLY             (CKE1_DLY), 
  .CKE2_DLY             (CKE2_DLY), 
  .CKE3_DLY             (CKE3_DLY), 
  .CLK0_DLY             (CLK0_DLY), 
  .CLK1_DLY             (CLK1_DLY), 
  .CLOCKDR_ACT_N        (CLOCKDR_ACT_N), 
  .CLOCKDR_CA           (CLOCKDR_CA), 
  .CLOCKDR_CKE          (CLOCKDR_CKE), 
  .CLOCKDR_CLK          (CLOCKDR_CLK), 
  .CLOCKDR_CS           (CLOCKDR_CS), 
  .CLOCKDR_ODT          (CLOCKDR_ODT), 
  .CLOCKDR_RESET_N      (CLOCKDR_RESET_N), 
  .CSLVL_SET            (CSLVL_SET), 
  .CSLVL_STATUS         (CSLVL_STATUS), 
  .DLL_EN               (DLL_EN_CTL), 
  .DLL_RESET            (DLL_RESET_CTL), 
  .DLL_UPDT_EN          (DLL_UPDT_EN_CTL), 
  .DRVSEL               (DRVSEL_CTL), 
  .DTI_CALVL_CAPTURE    (DTI_CALVL_CAPTURE), 
  .DTI_CALVL_DLY        (DTI_CALVL_DLY), 
  .DTI_CALVL_EN         (DTI_CALVL_CTRL_EN), 
  .DTI_CALVL_LOAD       (DTI_CALVL_LOAD), 
  .DTI_CALVL_RESULT     (DTI_CALVL_RESULT), 
  .DTI_CALVL_RESULT_B   (DTI_CALVL_RESULT_B), 
  .DTI_CLOCK            (DTI_PHY_CLOCK), 
  .DTI_CMDDLY_LOAD      (DTI_CMDDLY_LOAD), 
  .DTI_CSLVL_DLY        (DTI_CSLVL_DLY), 
  .DTI_DRAM_CLK_DISABLE (DTI_DRAM_CLK_DISABLE_INT), 
  .DTI_GEARDOWN_EN      (DTI_GEARDOWN_EN), 
  .DTI_INIT_COMPLETE    (DTI_INIT_COMPLETE_CA), 
  .DTI_RANK_A           (DTI_RANK_A), 
  .DTI_RANK_B           (DTI_RANK_B), 
  .DTI_VREF_EN          (DTI_VREF_EN_CTL), 
  .DTI_VREF_SET         (DTI_VREF_SET_CTL), 
  .E_CMOS               (E_CMOS_CTL), 
  .IO_MODE              (IO_MODE), 
  .JTAG_SI_ACT_N        (JTAG_SI_ACT_N), 
  .JTAG_SI_CA           (JTAG_SI_CA), 
  .JTAG_SI_CKE          (JTAG_SI_CKE), 
  .JTAG_SI_CLK          (JTAG_SI_CLK), 
  .JTAG_SI_CS           (JTAG_SI_CS), 
  .JTAG_SI_ODT          (JTAG_SI_ODT), 
  .JTAG_SI_RESET_N      (JTAG_SI_RESET_N), 
  .JTAG_SO_ACT_N        (JTAG_SO_ACT_N), 
  .JTAG_SO_CA           (JTAG_SO_CA), 
  .JTAG_SO_CKE          (JTAG_SO_CKE), 
  .JTAG_SO_CLK          (JTAG_SO_CLK), 
  .JTAG_SO_CS           (JTAG_SO_CS), 
  .JTAG_SO_ODT          (JTAG_SO_ODT), 
  .JTAG_SO_RESET_N      (JTAG_SO_RESET_N), 
  .L3_DQ_RESP           (L3_DQ_RESP), 
  .L4_DQ_RESP_A         (L4_DQ_RESP_A), 
  .L4_DQ_RESP_B         (L4_DQ_RESP_B), 
  .LIMIT                (LIMIT_CTL), 
  .LOCK                 (LOCK_CTL), 
  .LP_EN                (LP_EN_CTL), 
  .MEM_ACT_N            (MEM_ACT_N), 
  .MEM_CA               (MEM_CA), 
  .MEM_CKE              (MEM_CKE), 
  .MEM_CLK              (PAD_MEM_CLK), 
  .MEM_CLK_N            (PAD_MEM_CLK_N), 
  .MEM_CS               (MEM_CS), 
  .MEM_ODT              (MEM_ODT), 
  .MEM_RESET_N          (MEM_RESET_N), 
  .MODE_ACT_N           (MODE_ACT_N), 
  .MODE_CA              (MODE_CA), 
  .MODE_CKE             (MODE_CKE), 
  .MODE_CLK             (MODE_CLK), 
  .MODE_CS              (MODE_CS), 
  .MODE_ODT             (MODE_ODT), 
  .MODE_RESET_N         (MODE_RESET_N), 
  .NCTLH0               (NCTLH0), 
  .NCTLH1               (NCTLH1), 
  .NCTLH10              (NCTLH10), 
  .NCTLH11              (NCTLH11), 
  .NCTLH2               (NCTLH2), 
  .NCTLH3               (NCTLH3), 
  .NCTLH4               (NCTLH4), 
  .NCTLH5               (NCTLH5), 
  .NCTLH6               (NCTLH6), 
  .NCTLH7               (NCTLH7), 
  .NCTLH8               (NCTLH8), 
  .NCTLH9               (NCTLH9), 
  .NCTLHO0              (NCTLHO0), 
  .NCTLHO1              (NCTLHO1), 
  .NCTLHO10             (NCTLHO10), 
  .NCTLHO11             (NCTLHO11), 
  .NCTLHO2              (NCTLHO2), 
  .NCTLHO3              (NCTLHO3), 
  .NCTLHO4              (NCTLHO4), 
  .NCTLHO5              (NCTLHO5), 
  .NCTLHO6              (NCTLHO6), 
  .NCTLHO7              (NCTLHO7), 
  .NCTLHO8              (NCTLHO8), 
  .NCTLHO9              (NCTLHO9), 
  .ODIS_ACT_N           (ODIS_ACT_N), 
  .ODIS_CA              (ODIS_CA), 
  .ODIS_CKE             (ODIS_CKE), 
  .ODIS_CLK             (ODIS_CLK_REG_CIOR), 
  .ODIS_CS              (ODIS_CS), 
  .ODIS_ODT             (ODIS_ODT), 
  .ODIS_RESET_N         (ODIS_RESET_N), 
  .ODT0_DLY             (ODT0_DLY), 
  .ODT1_DLY             (ODT1_DLY), 
  .OUTBYPEN_ACT_N       (OUTBYPEN_ACT_N), 
  .OUTBYPEN_CA          (OUTBYPEN_CA), 
  .OUTBYPEN_CKE         (OUTBYPEN_CKE), 
  .OUTBYPEN_CLK         (OUTBYPEN_CLK), 
  .OUTBYPEN_CS          (OUTBYPEN_CS), 
  .OUTBYPEN_ODT         (OUTBYPEN_ODT), 
  .OUTBYPEN_RESET_N     (OUTBYPEN_RESET_N), 
  .OUTD_ACT_N           (OUTD_ACT_N), 
  .OUTD_CA              (OUTD_CA), 
  .OUTD_CKE             (OUTD_CKE), 
  .OUTD_CLK             (OUTD_CLK), 
  .OUTD_CS              (OUTD_CS), 
  .OUTD_ODT             (OUTD_ODT), 
  .OUTD_RESET_N         (OUTD_RESET_N), 
  .OVFL                 (OVFL_CTL), 
  .PAD_REF              (PAD_REF), 
  .PCTLH0               (PCTLH0), 
  .PCTLH1               (PCTLH1), 
  .PCTLH10              (PCTLH10), 
  .PCTLH11              (PCTLH11), 
  .PCTLH2               (PCTLH2), 
  .PCTLH3               (PCTLH3), 
  .PCTLH4               (PCTLH4), 
  .PCTLH5               (PCTLH5), 
  .PCTLH6               (PCTLH6), 
  .PCTLH7               (PCTLH7), 
  .PCTLH8               (PCTLH8), 
  .PCTLH9               (PCTLH9), 
  .PCTLHO0              (PCTLHO0), 
  .PCTLHO1              (PCTLHO1), 
  .PCTLHO10             (PCTLHO10), 
  .PCTLHO11             (PCTLHO11), 
  .PCTLHO2              (PCTLHO2), 
  .PCTLHO3              (PCTLHO3), 
  .PCTLHO4              (PCTLHO4), 
  .PCTLHO5              (PCTLHO5), 
  .PCTLHO6              (PCTLHO6), 
  .PCTLHO7              (PCTLHO7), 
  .PCTLHO8              (PCTLHO8), 
  .PCTLHO9              (PCTLHO9), 
  .PWRDNH_L             (PWRDNH_L), 
  .PWRDNH_R             (PWRDNH_R), 
  .R0_CALVL_SET         (R0_CALVL_SET), 
  .R1_CALVL_SET         (R1_CALVL_SET), 
  .RESET_N_DLY          (RESET_N_DLY), 
  .RN_CALVL             (RN_CALVL), 
  .SE                   (SE), 
  .SE_CK                (SE_CK), 
  .SHIFTDR_ACT_N        (SHIFTDR_ACT_N), 
  .SHIFTDR_CA           (SHIFTDR_CA), 
  .SHIFTDR_CKE          (SHIFTDR_CKE), 
  .SHIFTDR_CLK          (SHIFTDR_CLK), 
  .SHIFTDR_CS           (SHIFTDR_CS), 
  .SHIFTDR_ODT          (SHIFTDR_ODT), 
  .SHIFTDR_RESET_N      (SHIFTDR_RESET_N), 
  .SI_ACT_N             (SI_ACT_N), 
  .SI_CA                (SI_CA), 
  .SI_CKE               (SI_CKE), 
  .SI_CLK               (SI_CLK), 
  .SI_CS                (SI_CS), 
  .SI_ODT               (SI_ODT), 
  .SI_RESET_N           (SI_RESET_N), 
  .SO_ACT_N             (SO_ACT_N), 
  .SO_CA                (SO_CA), 
  .SO_CKE               (SO_CKE), 
  .SO_CLK               (SO_CLK), 
  .SO_CS                (SO_CS), 
  .SO_ODT               (SO_ODT), 
  .SO_RESET_N           (SO_RESET_N), 
  .T_CGCTL              (T_CGCTL_CTL), 
  .T_RCTL               (T_RCTL_CTL), 
  .UNFL                 (UNFL_CTL), 
  .UPDATEDR_ACT_N       (UPDATEDR_ACT_N), 
  .UPDATEDR_CA          (UPDATEDR_CA), 
  .UPDATEDR_CKE         (UPDATEDR_CKE), 
  .UPDATEDR_CLK         (UPDATEDR_CLK), 
  .UPDATEDR_CS          (UPDATEDR_CS), 
  .UPDATEDR_ODT         (UPDATEDR_ODT), 
  .UPDATEDR_RESET_N     (UPDATEDR_RESET_N), 
  .VDD                  (VDD), 
  .VDDO                 (VDDO), 
  .VSS                  (VSS), 
  .WDATA_ACT_N          (WDATA_ACT_N), 
  .WDATA_CA             (WDATA_CA), 
  .WDATA_CKE            (WDATA_CKE), 
  .WDATA_CS             (WDATA_CS), 
  .WDATA_L_CA           (WDATA_L_CA), 
  .WDATA_ODT            (WDATA_ODT), 
  .WDATA_RESET_N        (WDATA_RESET_N), 
  .YC_ACT_N             (YC_ACT_N), 
  .YC_CA                (YC_CA), 
  .YC_CKE               (YC_CKE), 
  .YC_CLK               (YC_CLK), 
  .YC_CS                (YC_CS), 
  .YC_ODT               (YC_ODT), 
  .YC_RESET_N           (YC_RESET_N)
); 

dti_ddr_phy_leveling dti_ddr_phy_leveling( 
  .DTI_DATA_BYTE_DISABLE (DTI_DATA_BYTE_DISABLE_INT), 
  .ranken_reg_pom        (ranken_reg_pom_int), 
  .DTI_GTPH_R0           (DTI_GTPH_R0), 
  .DTI_GTPH_R1           (DTI_GTPH_R1), 
  .DTI_HOLD_R0           (DTI_HOLD_R0), 
  .DTI_HOLD_R1           (DTI_HOLD_R1)
); 

dti_dfi_map dti_dfi_map( 
  .reg_dual_chan_en         (reg_dual_chan_en), 
  .DTI_DATA_BYTE_DISABLE    (DTI_DATA_BYTE_DISABLE), 
  .DTI_RESET_N_MC           (DTI_RESET_N_MC), 
  .DTI_CKE_MC               (DTI_CKE_MC), 
  .DTI_CS_MC                (DTI_CS_MC), 
  .DTI_CA_MC                (DTI_CA_MC), 
  .DTI_CA_L_MC              (DTI_CA_L_MC), 
  .DTI_BA_MC                (DTI_BA_MC), 
  .DTI_ACT_N_MC             (DTI_ACT_N_MC), 
  .DTI_ODT_MC               (DTI_ODT_MC), 
  .DTI_RANK_MC              (DTI_RANK_MC), 
  .DTI_RESET_N              (DTI_RESET_N), 
  .DTI_CKE                  (DTI_CKE), 
  .DTI_CS                   (DTI_CS), 
  .DTI_CA                   (DTI_CA), 
  .DTI_CA_L                 (DTI_CA_L), 
  .DTI_BA                   (DTI_BA), 
  .DTI_ACT_N                (DTI_ACT_N), 
  .DTI_ODT                  (DTI_ODT), 
  .DTI_RANK                 (DTI_RANK), 
  .DTI_WRDATA_EN_MC         (DTI_WRDATA_EN_MC), 
  .DTI_WRDATA_MC            (DTI_WRDATA_MC), 
  .DTI_WRDATA_MASK_MC       (DTI_WRDATA_MASK_MC), 
  .DTI_RANK_WR_MC           (DTI_RANK_WR_MC), 
  .DTI_WRDATA_EN            (DTI_WRDATA_EN), 
  .DTI_WRDATA               (DTI_WRDATA), 
  .DTI_WRDATA_MASK          (DTI_WRDATA_MASK), 
  .DTI_RANK_WR              (DTI_RANK_WR), 
  .DTI_RDDATA_EN_MC         (DTI_RDDATA_EN_MC), 
  .DTI_RANK_RD_MC           (DTI_RANK_RD_MC), 
  .DTI_RDDATA_MC            (DTI_RDDATA_MC), 
  .DTI_RDDATA_MASK_MC       (DTI_RDDATA_MASK_MC), 
  .DTI_RDDATA_VALID_MC      (DTI_RDDATA_VALID_MC), 
  .DTI_RDDATA_EN            (DTI_RDDATA_EN), 
  .DTI_RANK_RD              (DTI_RANK_RD), 
  .DTI_RDDATA               (DTI_RDDATA), 
  .DTI_RDDATA_MASK          (DTI_RDDATA_MASK), 
  .DTI_RDDATA_VALID         (DTI_RDDATA_VALID), 
  .gterr_reg_pts_slice      (gterr_reg_pts_slice), 
  .gterr_reg_pts            (gterr_reg_pts), 
  .rdlvldqerr_reg_pts_slice (rdlvldqerr_reg_pts_slice), 
  .rdlvldqerr_reg_pts       (rdlvldqerr_reg_pts), 
  .rdlvldmerr_reg_pts_slice (rdlvldmerr_reg_pts_slice), 
  .rdlvldmerr_reg_pts       (rdlvldmerr_reg_pts), 
  .wrlvlerr_reg_pts_slice   (wrlvlerr_reg_pts_slice), 
  .wrlvlerr_reg_pts         (wrlvlerr_reg_pts)
); 

dti_mode_ctrl_map dti_mode_ctrl_map( 
  .reg_lpddr4_en             (reg_lpddr4_en_int), 
  .reg_lpddr3_en             (reg_lpddr3_en_int), 
  .reg_ddr4_en               (reg_ddr4_en_int), 
  .reg_ddr3_en               (reg_ddr3_en_int), 
  .reg_dual_rank_en          (reg_dual_rank_int), 
  .reg_dual_chan_en          (reg_dual_chan_en_int), 
  .DTI_DATA_BYTE_DISABLE     (DTI_DATA_BYTE_DISABLE_INT), 
  .DTI_RESET_N_INT           (DTI_RESET_N_INT), 
  .DTI_CKE_INT               (DTI_CKE_INT), 
  .DTI_CS_INT                (DTI_CS_INT), 
  .DTI_CA_INT                (DTI_CA_INT), 
  .DTI_CA_L_INT              (DTI_CA_L_INT), 
  .DTI_BA_INT                (DTI_BA_INT), 
  .DTI_ACT_N_INT             (DTI_ACT_N_INT), 
  .DTI_ODT_INT               (DTI_ODT_INT), 
  .DTI_RANK_INT              (DTI_RANK_INT), 
  .WDATA_ACT_N               (WDATA_ACT_N), 
  .WDATA_CA                  (WDATA_CA), 
  .WDATA_CKE                 (WDATA_CKE), 
  .WDATA_CS                  (WDATA_CS), 
  .WDATA_L_CA                (WDATA_L_CA), 
  .WDATA_ODT                 (WDATA_ODT), 
  .WDATA_RESET_N             (WDATA_RESET_N), 
  .DTI_RANK_A                (DTI_RANK_A), 
  .DTI_RANK_B                (DTI_RANK_B), 
  .DTI_CALVL_DLY_SYNC        (DTI_CALVL_DLY_SYNC), 
  .DTI_CSLVL_DLY_SYNC        (DTI_CSLVL_DLY_SYNC), 
  .CKE_DLY_SYNC              (CKE_DLY_SYNC), 
  .ODT_DLY_SYNC              (ODT_DLY_SYNC), 
  .RESET_N_DLY_SYNC          (RESET_N_DLY_SYNC), 
  .ACTN_DLY_SYNC             (ACTN_DLY_SYNC), 
  .BA_DLY_SYNC               (BA_DLY_SYNC), 
  .CLK_DLY_SYNC              (CLK_DLY_SYNC), 
  .ACT_N_DLY                 (ACT_N_DLY), 
  .CKE0_DLY                  (CKE0_DLY), 
  .CKE1_DLY                  (CKE1_DLY), 
  .CKE2_DLY                  (CKE2_DLY), 
  .CKE3_DLY                  (CKE3_DLY), 
  .DTI_CALVL_DLY             (DTI_CALVL_DLY), 
  .DTI_CSLVL_DLY             (DTI_CSLVL_DLY), 
  .ODT0_DLY                  (ODT0_DLY), 
  .ODT1_DLY                  (ODT1_DLY), 
  .RESET_N_DLY               (RESET_N_DLY), 
  .CLK0_DLY                  (CLK0_DLY), 
  .CLK1_DLY                  (CLK1_DLY), 
  .DTI_CALVL_LOAD_INT        (DTI_CALVL_LOAD_INT), 
  .DTI_CALVL_CAPTURE_INT     (DTI_CALVL_CAPTURE_INT), 
  .DTI_CMDDLY_LOAD_INT       (DTI_CMDDLY_LOAD_INT), 
  .DTI_CALVL_CAPTURE         (DTI_CALVL_CAPTURE), 
  .DTI_CALVL_LOAD            (DTI_CALVL_LOAD), 
  .DTI_CMDDLY_LOAD           (DTI_CMDDLY_LOAD), 
  .DTI_RN_CALVL_SYNC         (DTI_RN_CALVL_SYNC), 
  .RN_CALVL                  (RN_CALVL), 
  .DTI_CALVL_RESULT          (DTI_CALVL_RESULT), 
  .DTI_CALVL_RESULT_B        (DTI_CALVL_RESULT_B), 
  .DTI_CALVL_RESULT_SYNC     (DTI_CALVL_RESULT_SYNC), 
  .DTI_CALVL_CTRL_EN_SYNC    (DTI_CALVL_CTRL_EN_SYNC), 
  .DTI_CALVL_CTRL_EN         (DTI_CALVL_CTRL_EN), 
  .CALVL_STATUS              (CALVL_STATUS), 
  .DTI_CALVL_STATUS_SYNC     (DTI_CALVL_STATUS_SYNC), 
  .R0_CALVL_SET              (R0_CALVL_SET), 
  .R1_CALVL_SET              (R1_CALVL_SET), 
  .DTI_R0_CALVL_SET_SYNC     (DTI_R0_CALVL_SET_SYNC), 
  .DTI_R1_CALVL_SET_SYNC     (DTI_R1_CALVL_SET_SYNC), 
  .DTI_INIT_COMPLETE_CA_SYNC (DTI_INIT_COMPLETE_CA_SYNC), 
  .DTI_INIT_COMPLETE_CA      (DTI_INIT_COMPLETE_CA), 
  .LP_EN_REG_PBCR_CTL_SYNC   (LP_EN_REG_PBCR_CTL_SYNC), 
  .LP_EN_CTL                 (LP_EN_CTL), 
  .E_CMOS_CTL_SYNC           (E_CMOS_CTL_SYNC), 
  .E_CMOS_CTL                (E_CMOS_CTL), 
  .DRVSEL_CTL_SYNC           (DRVSEL_CTL_SYNC), 
  .DRVSEL_CTL                (DRVSEL_CTL), 
  .BYPC_CTL_SYNC             (BYPC_CTL_SYNC), 
  .BYP_CTL_SYNC              (BYP_CTL_SYNC), 
  .BYPC_CTL                  (BYPC_CTL), 
  .BYP_CTL                   (BYP_CTL), 
  .DLL_EN_CTL_SYNC           (DLL_EN_CTL_SYNC), 
  .DLL_RESET_CTL_SYNC        (DLL_RESET_CTL_SYNC), 
  .DLL_UPDT_EN_CTL_SYNC      (DLL_UPDT_EN_CTL_SYNC), 
  .DLL_EN_CTL                (DLL_EN_CTL), 
  .DLL_RESET_CTL             (DLL_RESET_CTL), 
  .DLL_UPDT_EN_CTL           (DLL_UPDT_EN_CTL), 
  .LIMIT_CTL_SYNC            (LIMIT_CTL_SYNC), 
  .LOCK_CTL_SYNC             (LOCK_CTL_SYNC), 
  .OVFL_CTL_SYNC             (OVFL_CTL_SYNC), 
  .UNFL_CTL_SYNC             (UNFL_CTL_SYNC), 
  .LIMIT_CTL                 (LIMIT_CTL), 
  .LOCK_CTL                  (LOCK_CTL), 
  .OVFL_CTL                  (OVFL_CTL), 
  .UNFL_CTL                  (UNFL_CTL), 
  .DTI_VREF_EN_CTL_SYNC      (DTI_VREF_EN_CTL_SYNC), 
  .DTI_VREF_SET_CTL_SYNC     (DTI_VREF_SET_CTL_SYNC), 
  .DTI_VREF_EN_CTL           (DTI_VREF_EN_CTL), 
  .DTI_VREF_SET_CTL          (DTI_VREF_SET_CTL)
); 

dti_phy_ctl_blk dti_phy_ctl_blk( 
  .COMP_CLOCK                  (COMP_CLOCK), 
  .COMP_RST_N                  (COMP_RST_N), 
  .DTI_CALVL_RESULT            (DTI_CALVL_RESULT_INT), 
  .DTI_CALVL_STATUS            (DTI_CALVL_STATUS_INT), 
  .DTI_CSLVL_SET               (DTI_CSLVL_SET_INT), 
  .DTI_CSLVL_STATUS            (DTI_CSLVL_STATUS_INT), 
  .DTI_DATA_BYTE_DISABLE       (DTI_DATA_BYTE_DISABLE), 
  .DTI_DRAM_CLK_DISABLE        (DTI_DRAM_CLK_DISABLE), 
  .DTI_FREQ_RATIO              (DTI_FREQ_RATIO), 
  .DTI_GTPH_R0                 (DTI_GTPH_R0_INT), 
  .DTI_GTPH_R1                 (DTI_GTPH_R1_INT), 
  .DTI_MC_CLOCK                (DTI_MC_CLOCK), 
  .DTI_R0_CALVL_SET            (DTI_R0_CALVL_SET_INT), 
  .DTI_R1_CALVL_SET            (DTI_R1_CALVL_SET_INT), 
  .DTI_RDDATA                  (DTI_RDDATA), 
  .DTI_RDDATA_MASK             (DTI_RDDATA_MASK), 
  .DTI_RDDATA_VALID            (DTI_RDDATA_VALID), 
  .DTI_RDLVL_GATE_STATUS       (DTI_RDLVL_GATE_STATUS_INT), 
  .DTI_RDLVL_SET               (DTI_RDLVL_SET_INT), 
  .DTI_RDLVL_SET_DM            (DTI_RDLVL_SET_DM_INT), 
  .DTI_RDLVL_STATUS            (DTI_RDLVL_STATUS_INT), 
  .DTI_RDLVL_STATUS_DM         (DTI_RDLVL_STATUS_DM_INT), 
  .DTI_SYS_RESET_N             (DTI_SYS_RESET_N), 
  .DTI_VREF_SET                (DTI_VREF_SET_INT), 
  .DTI_VT_DONE                 (DTI_VT_DONE_INT), 
  .DTI_WRLVL_SET               (DTI_WRLVL_SET_INT), 
  .DTI_WRLVL_STATUS            (DTI_WRLVL_STATUS_INT), 
  .LOCK_REG_DLLCA              (LOCK_REG_DLLCA), 
  .LOCK_REG_DLLDQ              (LOCK_REG_DLLDQ), 
  .LP_EN_REG_PBCR              (LP_EN_REG_PBCR), 
  .actn_reg_ptsr               (actn_reg_ptsr), 
  .ba_reg_ptar                 (ba_reg_ptar), 
  .ba_reg_ptsr                 (ba_reg_ptsr), 
  .ca_reg_ptsr                 (ca_reg_ptsr), 
  .chanen_reg_pom              (chanen_reg_pom), 
  .cke_reg_ptsr                (cke_reg_ptsr), 
  .cmddlyen_reg_pom            (cmddlyen_reg_pom), 
  .col_reg_ptar                (col_reg_ptar), 
  .cs_reg_ptsr                 (cs_reg_ptsr), 
  .dfien_reg_pom               (dfien_reg_pom), 
  .dir_reg_dqsdqcr             (dir_reg_dqsdqcr), 
  .dllrsten_reg_pom            (dllrsten_reg_pom), 
  .dlyevalen_reg_pom           (dlyevalen_reg_pom), 
  .dlymax_reg_dqsdqcr          (dlymax_reg_dqsdqcr), 
  .dlyoffs_reg_dqsdqcr         (dlyoffs_reg_dqsdqcr), 
  .dqrpt_reg_pttr              (dqrpt_reg_pttr), 
  .dqsdm_reg_ptsr              (dqsdm_reg_ptsr), 
  .dqsdq_reg_ptsr              (dqsdq_reg_ptsr), 
  .dqsdqen_reg_pom             (dqsdqen_reg_pom), 
  .dqsel_reg_dqsdqcr           (dqsel_reg_dqsdqcr), 
  .dqsleadck_reg_ptsr          (dqsleadck_reg_ptsr), 
  .draminiten_reg_pom          (draminiten_reg_pom), 
  .en_reg_dllca                (en_reg_dllca), 
  .en_reg_dlldq                (en_reg_dlldq), 
  .fena_rcv_reg_dior           (fena_rcv_reg_dior), 
  .fs0_trden_reg_rtgc          (fs0_trden_reg_rtgc), 
  .fs0_trdendbi_reg_rtgc       (fs0_trdendbi_reg_rtgc), 
  .fs0_twren_reg_rtgc          (fs0_twren_reg_rtgc), 
  .fs1_trden_reg_rtgc          (fs1_trden_reg_rtgc), 
  .fs1_trdendbi_reg_rtgc       (fs1_trdendbi_reg_rtgc), 
  .fs1_twren_reg_rtgc          (fs1_twren_reg_rtgc), 
  .fs_reg_pom                  (fs_reg_pom), 
  .gt_reg_ptsr                 (gt_reg_ptsr), 
  .gten_reg_pom                (gten_reg_pom), 
  .initcnt_reg_pccr            (initcnt_reg_pccr), 
  .ivrefr_reg_vtgc             (ivrefr_reg_vtgc), 
  .ivrefts_reg_vtgc            (ivrefts_reg_vtgc), 
  .mpcrpt_reg_dqsdqcr          (mpcrpt_reg_dqsdqcr), 
  .mupd_reg_dqsdqcr            (mupd_reg_dqsdqcr), 
  .odt_reg_pom                 (odt_reg_pom), 
  .odt_reg_ptsr                (odt_reg_ptsr), 
  .phyfsen_reg_pom             (phyfsen_reg_pom), 
  .phyinit_reg_pom             (phyinit_reg_pom), 
  .physeten_reg_pom            (physeten_reg_pom), 
  .proc_reg_pom                (proc_reg_pom), 
  .psck_reg_ptsr               (psck_reg_ptsr), 
  .rank_reg_dqsdqcr            (rank_reg_dqsdqcr), 
  .ranken_reg_pom              (ranken_reg_pom), 
  .rdlvl_reg_ptsr              (rdlvl_reg_ptsr), 
  .rdlvldm_reg_ptsr            (rdlvldm_reg_ptsr), 
  .rdlvlen_reg_pom             (rdlvlen_reg_pom), 
  .reg_calvl_pattern_a         (reg_calvl_pattern_a), 
  .reg_calvl_pattern_b         (reg_calvl_pattern_b), 
  .reg_ddr3_en                 (reg_ddr3_en), 
  .reg_ddr3_mr0                (reg_ddr3_mr0), 
  .reg_ddr3_mr1                (reg_ddr3_mr1), 
  .reg_ddr3_mr2                (reg_ddr3_mr2), 
  .reg_ddr3_mr3                (reg_ddr3_mr3), 
  .reg_ddr4_en                 (reg_ddr4_en), 
  .reg_ddr4_mr0                (reg_ddr4_mr0), 
  .reg_ddr4_mr1                (reg_ddr4_mr1), 
  .reg_ddr4_mr2                (reg_ddr4_mr2), 
  .reg_ddr4_mr3                (reg_ddr4_mr3), 
  .reg_ddr4_mr4                (reg_ddr4_mr4), 
  .reg_ddr4_mr5                (reg_ddr4_mr5), 
  .reg_ddr4_mr6                (reg_ddr4_mr6), 
  .reg_ddr4_mr6_vrefdq         (reg_ddr4_mr6_vrefdq), 
  .reg_ddr4_mr6_vrefdqr        (reg_ddr4_mr6_vrefdqr), 
  .reg_lpddr3_en               (reg_lpddr3_en), 
  .reg_lpddr3_mr1              (reg_lpddr3_mr1), 
  .reg_lpddr3_mr11             (reg_lpddr3_mr11), 
  .reg_lpddr3_mr16             (reg_lpddr3_mr16), 
  .reg_lpddr3_mr17             (reg_lpddr3_mr17), 
  .reg_lpddr3_mr2              (reg_lpddr3_mr2), 
  .reg_lpddr3_mr3              (reg_lpddr3_mr3), 
  .reg_lpddr4_en               (reg_lpddr4_en), 
  .reg_lpddr4_mr11_fs0         (reg_lpddr4_mr11_fs0), 
  .reg_lpddr4_mr11_fs1         (reg_lpddr4_mr11_fs1), 
  .reg_lpddr4_mr11_nt_fs0      (reg_lpddr4_mr11_nt_fs0), 
  .reg_lpddr4_mr11_nt_fs1      (reg_lpddr4_mr11_nt_fs1), 
  .reg_lpddr4_mr13             (reg_lpddr4_mr13), 
  .reg_lpddr4_mr1_fs0          (reg_lpddr4_mr1_fs0), 
  .reg_lpddr4_mr1_fs1          (reg_lpddr4_mr1_fs1), 
  .reg_lpddr4_mr22_fs0         (reg_lpddr4_mr22_fs0), 
  .reg_lpddr4_mr22_fs1         (reg_lpddr4_mr22_fs1), 
  .reg_lpddr4_mr22_nt_fs0      (reg_lpddr4_mr22_nt_fs0), 
  .reg_lpddr4_mr22_nt_fs1      (reg_lpddr4_mr22_nt_fs1), 
  .reg_lpddr4_mr2_fs0          (reg_lpddr4_mr2_fs0), 
  .reg_lpddr4_mr2_fs1          (reg_lpddr4_mr2_fs1), 
  .reg_lpddr4_mr3_fs0          (reg_lpddr4_mr3_fs0), 
  .reg_lpddr4_mr3_fs1          (reg_lpddr4_mr3_fs1), 
  .reg_t_caent                 (reg_t_caent), 
  .reg_t_calvl_max             (reg_t_calvl_max), 
  .reg_t_calvladrckeh          (reg_t_calvladrckeh), 
  .reg_t_calvlcap              (reg_t_calvlcap), 
  .reg_t_calvlcc               (reg_t_calvlcc), 
  .reg_t_calvlen               (reg_t_calvlen), 
  .reg_t_calvlext              (reg_t_calvlext), 
  .reg_t_ckckeh                (reg_t_ckckeh), 
  .reg_t_ckehdqs               (reg_t_ckehdqs), 
  .reg_t_ckelck                (reg_t_ckelck), 
  .reg_t_ckfspe                (reg_t_ckfspe), 
  .reg_t_ckfspx                (reg_t_ckfspx), 
  .reg_t_dllen                 (reg_t_dllen), 
  .reg_t_dlllock               (reg_t_dlllock), 
  .reg_t_dllrst                (reg_t_dllrst), 
  .reg_t_dqscke                (reg_t_dqscke), 
  .reg_t_dtrain                (reg_t_dtrain), 
  .reg_t_fc                    (reg_t_fc), 
  .reg_t_init1                 (reg_t_init1), 
  .reg_t_init3                 (reg_t_init3), 
  .reg_t_init5                 (reg_t_init5), 
  .reg_t_lvlaa                 (reg_t_lvlaa), 
  .reg_t_lvldis                (reg_t_lvldis), 
  .reg_t_lvldll                (reg_t_lvldll), 
  .reg_t_lvlexit               (reg_t_lvlexit), 
  .reg_t_lvlload               (reg_t_lvlload), 
  .reg_t_lvlresp               (reg_t_lvlresp), 
  .reg_t_lvlresp_nr            (reg_t_lvlresp_nr), 
  .reg_t_mod                   (reg_t_mod), 
  .reg_t_mpcwr                 (reg_t_mpcwr), 
  .reg_t_mpcwr2rd              (reg_t_mpcwr2rd), 
  .reg_t_mrd                   (reg_t_mrd), 
  .reg_t_mrr                   (reg_t_mrr), 
  .reg_t_mrs2act               (reg_t_mrs2act), 
  .reg_t_mrs2lvlen             (reg_t_mrs2lvlen), 
  .reg_t_mrw                   (reg_t_mrw), 
  .reg_t_odth8                 (reg_t_odth8), 
  .reg_t_odtup                 (reg_t_odtup), 
  .reg_t_pori                  (reg_t_pori), 
  .reg_t_rcd                   (reg_t_rcd), 
  .reg_t_rp                    (reg_t_rp), 
  .reg_t_rst                   (reg_t_rst), 
  .reg_t_vrcgdis               (reg_t_vrcgdis), 
  .reg_t_vrcgen                (reg_t_vrcgen), 
  .reg_t_vreftimelong          (reg_t_vreftimelong), 
  .reg_t_vreftimeshort         (reg_t_vreftimeshort), 
  .reg_t_xpr                   (reg_t_xpr), 
  .reg_t_zqcal                 (reg_t_zqcal), 
  .reg_t_zqinit                (reg_t_zqinit), 
  .reg_t_zqlat                 (reg_t_zqlat), 
  .row_reg_ptar                (row_reg_ptar), 
  .rstn_reg_ptsr               (rstn_reg_ptsr), 
  .sanchken_reg_pom            (sanchken_reg_pom), 
  .sanpat_reg_ptsr             (sanpat_reg_ptsr), 
  .srst_reg_pccr               (srst_reg_pccr_int), 
  .upd_reg_dllca               (upd_reg_dllca), 
  .upd_reg_dlldq               (upd_reg_dlldq), 
  .vrefcaen_reg_pom            (vrefcaen_reg_pom), 
  .vrefcar_reg_lpmr12_fs0      (vrefcar_reg_lpmr12_fs0), 
  .vrefcar_reg_lpmr12_fs1      (vrefcar_reg_lpmr12_fs1), 
  .vrefcar_reg_ptsr            (vrefcar_reg_ptsr), 
  .vrefcas_reg_lpmr12_fs0      (vrefcas_reg_lpmr12_fs0), 
  .vrefcas_reg_lpmr12_fs1      (vrefcas_reg_lpmr12_fs1), 
  .vrefcas_reg_ptsr            (vrefcas_reg_ptsr), 
  .vrefcasw_reg_vtgc           (vrefcasw_reg_vtgc), 
  .vrefdqr_reg_lpmr14_fs0      (vrefdqr_reg_lpmr14_fs0), 
  .vrefdqr_reg_lpmr14_fs1      (vrefdqr_reg_lpmr14_fs1), 
  .vrefdqrden_reg_pom          (vrefdqrden_reg_pom), 
  .vrefdqrdr_reg_ptsr          (vrefdqrdr_reg_ptsr), 
  .vrefdqrds_reg_ptsr          (vrefdqrds_reg_ptsr), 
  .vrefdqs_reg_lpmr14_fs0      (vrefdqs_reg_lpmr14_fs0), 
  .vrefdqs_reg_lpmr14_fs1      (vrefdqs_reg_lpmr14_fs1), 
  .vrefdqsw_reg_vtgc           (vrefdqsw_reg_vtgc), 
  .vrefdqwren_reg_pom          (vrefdqwren_reg_pom), 
  .vrefdqwrr_reg_ptsr          (vrefdqwrr_reg_ptsr), 
  .vrefdqwrs_reg_ptsr          (vrefdqwrs_reg_ptsr), 
  .wrlvl_reg_ptsr              (wrlvl_reg_ptsr), 
  .wrlvlen_reg_pom             (wrlvlen_reg_pom), 
  .ACTN_DLY                    (ACTN_DLY_INT), 
  .BA_DLY                      (BA_DLY_INT), 
  .BYPEN_VREF_SET              (BYPEN_VREF_SET_INT), 
  .BYP_VREF_SET                (BYP_VREF_SET_INT), 
  .CKE_DLY                     (CKE_DLY_INT), 
  .COMP_RST_N_INT              (COMP_RST_N_INT), 
  .DLL_EN_CA                   (DLL_EN_CA_INT), 
  .DLL_EN_DQ                   (DLL_EN_DQ_INT), 
  .DLL_RESET_CA                (DLL_RESET_CA_INT), 
  .DLL_RESET_DQ                (DLL_RESET_DQ_INT), 
  .DLL_UPDT_EN_CA              (DLL_UPDT_EN_CA_INT), 
  .DLL_UPDT_EN_DQ              (DLL_UPDT_EN_DQ_INT), 
  .DTI_ACT_N_CTL               (DTI_ACT_N_CTL), 
  .DTI_BA_CTL                  (DTI_BA_CTL), 
  .DTI_CALVL_CAPTURE           (DTI_CALVL_CAPTURE_CTL), 
  .DTI_CALVL_CTRL_EN           (DTI_CALVL_CTRL_EN_INT), 
  .DTI_CALVL_DATA              (DTI_CALVL_DATA_INT), 
  .DTI_CALVL_DLY               (DTI_CALVL_DLY_INT), 
  .DTI_CALVL_DQ_EN             (DTI_CALVL_DQ_EN_INT), 
  .DTI_CALVL_LOAD              (DTI_CALVL_LOAD_CTL), 
  .DTI_CALVL_STB               (DTI_CALVL_STB_INT), 
  .DTI_CA_CTL                  (DTI_CA_CTL), 
  .DTI_CA_L_CTL                (DTI_CA_L_CTL), 
  .DTI_CKE_CTL                 (DTI_CKE_CTL), 
  .DTI_CMDDLY_LOAD             (DTI_CMDDLY_LOAD_CTL), 
  .DTI_CSLVL_DLY               (DTI_CSLVL_DLY_INT), 
  .DTI_CS_CTL                  (DTI_CS_CTL), 
  .DTI_DRAM_CLK_DISABLE_INT    (DTI_DRAM_CLK_DISABLE_PHY), 
  .DTI_INIT_COMPLETE_CA        (DTI_INIT_COMPLETE_CA_INT), 
  .DTI_INIT_COMPLETE_DQ        (DTI_INIT_COMPLETE_DQ_INT), 
  .DTI_ODT_CTL                 (DTI_ODT_CTL), 
  .DTI_RANK_CTL                (DTI_RANK_CTL), 
  .DTI_RANK_RD_CTL             (DTI_RANK_RD_CTL), 
  .DTI_RANK_WR_CTL             (DTI_RANK_WR_CTL), 
  .DTI_RDDATA_EN_CTL           (DTI_RDDATA_EN_CTL), 
  .DTI_RDLVL_DLY               (DTI_RDLVL_DLY_INT), 
  .DTI_RDLVL_DLY_DM            (DTI_RDLVL_DLY_DM_INT), 
  .DTI_RDLVL_EDGE              (DTI_RDLVL_EDGE_INT), 
  .DTI_RDLVL_EN                (DTI_RDLVL_EN_INT), 
  .DTI_RDLVL_EN_DM             (DTI_RDLVL_EN_DM_INT), 
  .DTI_RDLVL_GATE_DLY          (DTI_RDLVL_GATE_DLY_INT), 
  .DTI_RDLVL_GATE_EN           (DTI_RDLVL_GATE_EN_INT), 
  .DTI_RDLVL_LOAD              (DTI_RDLVL_LOAD_INT), 
  .DTI_RESET_N_CTL             (DTI_RESET_N_CTL), 
  .DTI_RN_CALVL                (DTI_RN_CALVL_INT), 
  .DTI_VREF_LOAD               (DTI_VREF_LOAD_INT), 
  .DTI_VREF_RANGE              (DTI_VREF_RANGE_INT), 
  .DTI_VT_EN                   (DTI_VT_EN_INT), 
  .DTI_WDM_DLY                 (DTI_WDM_DLY_INT), 
  .DTI_WDQ_DLY                 (DTI_WDQ_DLY_INT), 
  .DTI_WDQ_LOAD                (DTI_WDQ_LOAD_INT), 
  .DTI_WRDATA_CTL              (DTI_WRDATA_CTL), 
  .DTI_WRDATA_EN_CTL           (DTI_WRDATA_EN_CTL), 
  .DTI_WRDATA_MASK_CTL         (DTI_WRDATA_MASK_CTL), 
  .DTI_WRLVL_DLY               (DTI_WRLVL_DLY_INT), 
  .DTI_WRLVL_EN                (DTI_WRLVL_EN_INT), 
  .DTI_WRLVL_LOAD              (DTI_WRLVL_LOAD_INT), 
  .DTI_WRLVL_STB               (DTI_WRLVL_STB_INT), 
  .FENA_RCV                    (FENA_RCV_INT), 
  .ODT_DLY                     (ODT_DLY_INT), 
  .RESET_N_DLY                 (RESET_N_DLY_INT), 
  .ca_reg_ptsr_ip              (ca_reg_ptsr_ip), 
  .cmddlyc_reg_pos             (cmddlyc_reg_pos), 
  .cs_reg_ptsr_ip              (cs_reg_ptsr_ip), 
  .dllerr_reg_pts              (dllerr_reg_pts), 
  .dllrstc_reg_pos             (dllrstc_reg_pos), 
  .dlyevalc_reg_pos            (dlyevalc_reg_pos), 
  .dqsdm_reg_ptsr_ip           (dqsdm_reg_ptsr_ip), 
  .dqsdmerr_reg_pts            (dqsdmerr_reg_pts), 
  .dqsdq_reg_ptsr_ip           (dqsdq_reg_ptsr_ip), 
  .dqsdqc_reg_pos              (dqsdqc_reg_pos), 
  .dqsdqerr_reg_pts            (dqsdqerr_reg_pts), 
  .dqsleadck                   (dqsleadck), 
  .dqsleadck_reg_ptsr_ip       (dqsleadck_reg_ptsr_ip), 
  .draminitc_reg_pos           (draminitc_reg_pos), 
  .dti_init_complete_int       (srstc_reg_pcsr), 
  .fs0req_reg_pos              (fs0req_reg_pos), 
  .fs1req_reg_pos              (fs1req_reg_pos), 
  .gt_reg_ptsr_ip              (gt_reg_ptsr_ip), 
  .gtc_reg_pos                 (gtc_reg_pos), 
  .gterr_reg_pts               (gterr_reg_pts_slice), 
  .lp3calvlerr_reg_pts         (lp3calvlerr_reg_pts), 
  .mupd_reg_dqsdqcr_clr        (mupd_reg_dqsdqcr_clr), 
  .nt_rank                     (nt_rank_reg_ptsr_ip), 
  .ofs_reg_pos                 (ofs_reg_pos), 
  .phyfsc_reg_pos              (phyfsc_reg_pos), 
  .phyinitc_reg_pos            (phyinitc_reg_pos), 
  .physetc_reg_pos             (physetc_reg_pos), 
  .psck_reg_ptsr_ip            (psck_reg_ptsr_ip), 
  .ptsr_upd                    (ptsr_upd), 
  .rdlvl_reg_ptsr_ip           (rdlvl_reg_ptsr_ip), 
  .rdlvlc_reg_pos              (rdlvlc_reg_pos), 
  .rdlvldm_reg_ptsr_ip         (rdlvldm_reg_ptsr_ip), 
  .rdlvldmerr_reg_pts          (rdlvldmerr_reg_pts_slice), 
  .rdlvldqerr_reg_pts          (rdlvldqerr_reg_pts_slice), 
  .sanchkc_reg_pos             (sanchkc_reg_pos), 
  .sanchkerr_reg_pts           (sanchkerr_reg_pts), 
  .shad_reg_lpddr4_mr11_fs0    (shad_reg_lpddr4_mr11_fs0), 
  .shad_reg_lpddr4_mr11_fs1    (shad_reg_lpddr4_mr11_fs1), 
  .shad_reg_lpddr4_mr11_nt_fs0 (shad_reg_lpddr4_mr11_nt_fs0), 
  .shad_reg_lpddr4_mr11_nt_fs1 (shad_reg_lpddr4_mr11_nt_fs1), 
  .shad_reg_lpddr4_mr12_fs0    (shad_reg_lpddr4_mr12_fs0), 
  .shad_reg_lpddr4_mr12_fs1    (shad_reg_lpddr4_mr12_fs1), 
  .shad_reg_lpddr4_mr13        (shad_reg_lpddr4_mr13), 
  .shad_reg_lpddr4_mr13_nt     (shad_reg_lpddr4_mr13_nt), 
  .shad_reg_lpddr4_mr14_fs0    (shad_reg_lpddr4_mr14_fs0), 
  .shad_reg_lpddr4_mr14_fs1    (shad_reg_lpddr4_mr14_fs1), 
  .shad_reg_lpddr4_mr1_fs0     (shad_reg_lpddr4_mr1_fs0), 
  .shad_reg_lpddr4_mr1_fs1     (shad_reg_lpddr4_mr1_fs1), 
  .shad_reg_lpddr4_mr22_fs0    (shad_reg_lpddr4_mr22_fs0), 
  .shad_reg_lpddr4_mr22_fs1    (shad_reg_lpddr4_mr22_fs1), 
  .shad_reg_lpddr4_mr22_nt_fs0 (shad_reg_lpddr4_mr22_nt_fs0), 
  .shad_reg_lpddr4_mr22_nt_fs1 (shad_reg_lpddr4_mr22_nt_fs1), 
  .shad_reg_lpddr4_mr2_fs0     (shad_reg_lpddr4_mr2_fs0), 
  .shad_reg_lpddr4_mr2_fs1     (shad_reg_lpddr4_mr2_fs1), 
  .shad_reg_lpddr4_mr3_fs0     (shad_reg_lpddr4_mr3_fs0), 
  .shad_reg_lpddr4_mr3_fs1     (shad_reg_lpddr4_mr3_fs1), 
  .vrefcac_reg_pos             (vrefcac_reg_pos), 
  .vrefcaerr_reg_pts           (vrefcaerr_reg_pts), 
  .vrefcar_reg_ptsr_ip         (vrefcar_reg_ptsr_ip), 
  .vrefcas_reg_ptsr_ip         (vrefcas_reg_ptsr_ip), 
  .vrefdqr_reg_ptsr_ip         (vrefdqr_reg_ptsr_ip), 
  .vrefdqrdc_reg_pos           (vrefdqrdc_reg_pos), 
  .vrefdqrderr_reg_pts         (vrefdqrderr_reg_pts), 
  .vrefdqrdr_reg_ptsr_ip       (vrefdqrdr_reg_ptsr_ip), 
  .vrefdqrds_reg_ptsr_ip       (vrefdqrds_reg_ptsr_ip), 
  .vrefdqs_reg_ptsr_ip         (vrefdqs_reg_ptsr_ip), 
  .vrefdqwrc_reg_pos           (vrefdqwrc_reg_pos), 
  .vrefdqwrerr_reg_pts         (vrefdqwrerr_reg_pts), 
  .wrlvl_reg_ptsr_ip           (wrlvl_reg_ptsr_ip), 
  .wrlvlc_reg_pos              (wrlvlc_reg_pos), 
  .wrlvlerr_reg_pts            (wrlvlerr_reg_pts_slice)
); 

dti_phy_sync_common dti_phy_sync_common( 
  .dti_mc_clock             (DTI_MC_CLOCK), 
  .dti_phy_clock            (DTI_PHY_CLOCK), 
  .dti_comp_clock           (COMP_CLOCK), 
  .dti_sys_reset_n          (DTI_SYS_RESET_N), 
  .DTI_DRAM_CLK_DISABLE_CTL (DTI_DRAM_CLK_DISABLE_PHY), 
  .clklocken_reg_pom        (clklocken_reg_pom), 
  .DTI_DRAM_CLK_DISABLE_INT (DTI_DRAM_CLK_DISABLE_INT), 
  .clklocken_reg_pom_int    (clklocken_reg_pom_int), 
  .clklockc_reg_pos_int     (clklockc_reg_pos_int), 
  .clklockc_reg_pos         (clklockc_reg_pos), 
  .chanen_reg_pom           (chanen_reg_pom), 
  .chanen_reg_pom_int       (chanen_reg_pom_int), 
  .ranken_reg_pom           (ranken_reg_pom), 
  .ranken_reg_pom_int       (ranken_reg_pom_int), 
  .reg_lpddr4_en            (reg_lpddr4_en), 
  .reg_lpddr3_en            (reg_lpddr3_en), 
  .reg_ddr4_en              (reg_ddr4_en), 
  .reg_ddr3_en              (reg_ddr3_en), 
  .reg_dual_rank_en         (reg_dual_rank_en), 
  .reg_dual_chan_en         (reg_dual_chan_en), 
  .reg_dqs2ck_en            (reg_dqs2ck_en), 
  .reg_lpddr4_en_int        (reg_lpddr4_en_int), 
  .reg_lpddr3_en_int        (reg_lpddr3_en_int), 
  .reg_ddr4_en_int          (reg_ddr4_en_int), 
  .reg_ddr3_en_int          (reg_ddr3_en_int), 
  .reg_dual_rank_en_int     (reg_dual_rank_en_int), 
  .reg_dual_chan_en_int     (reg_dual_chan_en_int), 
  .reg_dqs2ck_en_int        (reg_dqs2ck_en_int), 
  .DTI_FREQ_RATIO           (DTI_FREQ_RATIO), 
  .DTI_FREQ_RATIO_INT       (DTI_FREQ_RATIO_INT), 
  .BIST_START_INT           (bist_start_reg_pbcr), 
  .BIST_EN_INT              (bist_en_reg_pbcr), 
  .BIST_START               (BIST_START), 
  .BIST_EN                  (BIST_EN), 
  .BIST_DONE                (BIST_DONE), 
  .BIST_DONE_INT            (bist_done_reg_pbsr), 
  .BIST_ERR_CTL             (BIST_ERR_CTL), 
  .BIST_ERR_CTL_INT         (bist_err_ctl_reg_pbsr), 
  .IO_MODE_INT              (reg_io_mode), 
  .IO_MODE                  (IO_MODE), 
  .OUTBYPEN_CTL             (REG_OUTBYPEN_CTL), 
  .OUTBYPEN_CLK             (REG_OUTBYPEN_CLK), 
  .OUTBYPEN_CTL_INT         (OUTBYPEN_CTL), 
  .OUTBYPEN_CLK_INT         (OUTBYPEN_CLK), 
  .OUTD_CTL                 (REG_OUTD_CTL), 
  .OUTD_CLK                 (REG_OUTD_CLK), 
  .OUTD_CTL_INT             (OUTD_CTL), 
  .OUTD_CLK_INT             (OUTD_CLK), 
  .srst_reg_pccr            (srst_reg_pccr), 
  .srst_reg_pccr_int        (srst_reg_pccr_int)
); 

dti_gear_ctrl dti_gear_ctrl[DRAM_CHAN_NUM-1:0]( 
  .dti_mc_clock           (DTI_MC_CLOCK), 
  .dti_phy_clock          (DTI_PHY_CLOCK), 
  .dti_sys_reset_n        (DTI_SYS_RESET_N), 
  .clklocken_reg_pom      (clklocken_reg_pom_int), 
  .dti_dram_clock_disable (DTI_DRAM_CLK_DISABLE_INT), 
  .mc_phase_lock          (mc_phase_lock_ctl), 
  .dfien_reg_pom          (dfien_ctrl), 
  .DTI_RESET_N            (DTI_RESET_N), 
  .DTI_CKE                (DTI_CKE), 
  .DTI_CS                 (DTI_CS), 
  .DTI_CA                 (DTI_CA), 
  .DTI_CA_L               (DTI_CA_L), 
  .DTI_BA                 (DTI_BA), 
  .DTI_ACT_N              (DTI_ACT_N), 
  .DTI_ODT                (DTI_ODT), 
  .DTI_RANK               (DTI_RANK), 
  .DTI_RESET_N_CTL        (DTI_RESET_N_CTL), 
  .DTI_CKE_CTL            (DTI_CKE_CTL), 
  .DTI_CS_CTL             (DTI_CS_CTL), 
  .DTI_CA_CTL             (DTI_CA_CTL), 
  .DTI_CA_L_CTL           (DTI_CA_L_CTL), 
  .DTI_BA_CTL             (DTI_BA_CTL), 
  .DTI_ACT_N_CTL          (DTI_ACT_N_CTL), 
  .DTI_ODT_CTL            (DTI_ODT_CTL), 
  .DTI_RANK_CTL           (DTI_RANK_CTL), 
  .DTI_RESET_N_INT        (DTI_RESET_N_INT), 
  .DTI_CKE_INT            (DTI_CKE_INT), 
  .DTI_CS_INT             (DTI_CS_INT), 
  .DTI_CA_INT             (DTI_CA_INT), 
  .DTI_CA_L_INT           (DTI_CA_L_INT), 
  .DTI_BA_INT             (DTI_BA_INT), 
  .DTI_ACT_N_INT          (DTI_ACT_N_INT), 
  .DTI_ODT_INT            (DTI_ODT_INT), 
  .DTI_RANK_INT           (DTI_RANK_INT), 
  .DTI_CALVL_LOAD_INT     (DTI_CALVL_LOAD_CTL), 
  .DTI_CALVL_CAPTURE_INT  (DTI_CALVL_CAPTURE_CTL), 
  .DTI_CMDDLY_LOAD_INT    (DTI_CMDDLY_LOAD_CTL), 
  .DTI_CALVL_LOAD         (DTI_CALVL_LOAD_INT), 
  .DTI_CALVL_CAPTURE      (DTI_CALVL_CAPTURE_INT), 
  .DTI_CMDDLY_LOAD        (DTI_CMDDLY_LOAD_INT)
); 

dti_phy_sync_ctrl dti_phy_sync_ctrl[DRAM_CHAN_NUM-1:0]( 
  .dti_mc_clock             (DTI_MC_CLOCK), 
  .dti_phy_clock            (DTI_PHY_CLOCK), 
  .DTI_PHY_CLOCK_CA         (DTI_PHY_CLOCK), 
  .dti_sys_reset_n          (DTI_SYS_RESET_N), 
  .DTI_CALVL_RESULT         (DTI_CALVL_RESULT_SYNC), 
  .DTI_CALVL_STATUS         (DTI_CALVL_STATUS_SYNC), 
  .DTI_CSLVL_STATUS         (CSLVL_STATUS), 
  .DTI_R0_CALVL_SET         (DTI_R0_CALVL_SET_SYNC), 
  .DTI_R1_CALVL_SET         (DTI_R1_CALVL_SET_SYNC), 
  .DTI_CSLVL_SET            (CSLVL_SET), 
  .DTI_CALVL_RESULT_INT     (DTI_CALVL_RESULT_INT), 
  .DTI_CALVL_STATUS_INT     (DTI_CALVL_STATUS_INT), 
  .DTI_CSLVL_STATUS_INT     (DTI_CSLVL_STATUS_INT), 
  .DTI_R0_CALVL_SET_INT     (DTI_R0_CALVL_SET_INT), 
  .DTI_R1_CALVL_SET_INT     (DTI_R1_CALVL_SET_INT), 
  .DTI_CSLVL_SET_INT        (DTI_CSLVL_SET_INT), 
  .DTI_RN_CALVL_INT         (DTI_RN_CALVL_INT), 
  .DTI_CALVL_CTRL_EN_INT    (DTI_CALVL_CTRL_EN_INT), 
  .DTI_CSLVL_DLY_INT        (DTI_CSLVL_DLY_INT), 
  .DTI_CALVL_DLY_INT        (DTI_CALVL_DLY_INT), 
  .DTI_RN_CALVL             (DTI_RN_CALVL_SYNC), 
  .DTI_CALVL_CTRL_EN        (DTI_CALVL_CTRL_EN_SYNC), 
  .DTI_CSLVL_DLY            (DTI_CSLVL_DLY_SYNC), 
  .DTI_CALVL_DLY            (DTI_CALVL_DLY_SYNC), 
  .CKE_DLY_INT              (CKE_DLY_INT), 
  .ODT_DLY_INT              (ODT_DLY_INT), 
  .RESET_N_DLY_INT          (RESET_N_DLY_INT), 
  .ACT_N_DLY_INT            (ACTN_DLY_INT), 
  .BA_DLY_INT               (BA_DLY_INT), 
  .CKE_DLY                  (CKE_DLY_SYNC), 
  .ODT_DLY                  (ODT_DLY_SYNC), 
  .RESET_N_DLY              (RESET_N_DLY_SYNC), 
  .ACT_N_DLY                (ACTN_DLY_SYNC), 
  .BA_DLY                   (BA_DLY_SYNC), 
  .VREFENCA_REG_PBCR        (VREFENCA_REG_PBCR), 
  .VREFSETCA_REG_PBCR       (VREFSETCA_REG_PBCR), 
  .DTI_INIT_COMPLETE_CA     (DTI_INIT_COMPLETE_CA_INT), 
  .LIMIT_REG_DLLCA          (LIMIT_REG_DLLCA), 
  .LOCK_REG_DLLCA_INT       (LOCK_CTL_SYNC), 
  .OVFL_REG_DLLCA_INT       (OVFL_CTL_SYNC), 
  .UNFL_REG_DLLCA_INT       (UNFL_CTL_SYNC), 
  .CMOS_EN_REG_CIOR         (CMOS_EN_REG_CIOR), 
  .DLL_EN_CA                (DLL_EN_CA_INT), 
  .DLL_RESET_CA             (DLL_RESET_CA_INT), 
  .DLL_UPDT_EN_CA           (DLL_UPDT_EN_CA_INT), 
  .DRVSEL_REG_CIOR          (DRVSEL_REG_CIOR), 
  .CLKDLY_REG_DLLCA         (CLKDLY_REG_DLLCA), 
  .BYPC_REG_DLLCA           (BYPC_REG_DLLCA), 
  .BYP_REG_DLLCA            (BYP_REG_DLLCA), 
  .VREFENCA_REG_PBCR_INT    (DTI_VREF_EN_CTL_SYNC), 
  .VREFSETCA_REG_PBCR_INT   (DTI_VREF_SET_CTL_SYNC), 
  .DTI_INIT_COMPLETE_CA_INT (DTI_INIT_COMPLETE_CA_SYNC), 
  .LIMIT_REG_DLLCA_INT      (LIMIT_CTL_SYNC), 
  .LOCK_REG_DLLCA           (LOCK_REG_DLLCA), 
  .OVFL_REG_DLLCA           (OVFL_REG_DLLCA), 
  .UNFL_REG_DLLCA           (UNFL_REG_DLLCA), 
  .CMOS_EN_REG_CIOR_INT     (E_CMOS_CTL_SYNC), 
  .DLL_EN_CA_INT            (DLL_EN_CTL_SYNC), 
  .DLL_RESET_CA_INT         (DLL_RESET_CTL_SYNC), 
  .DLL_UPDT_EN_CA_INT       (DLL_UPDT_EN_CTL_SYNC), 
  .DRVSEL_REG_CIOR_INT      (DRVSEL_CTL_SYNC), 
  .CLK_DLY                  (CLK_DLY_SYNC), 
  .BYPC_REG_DLLCA_INT       (BYPC_CTL_SYNC), 
  .BYP_REG_DLLCA_INT        (BYP_CTL_SYNC), 
  .LP_EN_REG_PBCR           (LP_EN_REG_PBCR), 
  .LP_EN_REG_PBCR_INT       (LP_EN_REG_PBCR_CTL_SYNC)
); 

dti_tm16ffcd4lp4r2_18d_dq8_jm dti_tm16ffcd4lp4r2_18d_dq8_jm[PHY_SLICE_NUM-1:0]( 
  .BISTERR_DM         (BISTERR_DM), 
  .BISTERR_DQ         (BISTERR_DQ), 
  .BIST_DONE          (BIST_DONE_DQ), 
  .BIST_EN            (BIST_EN), 
  .BIST_START         (BIST_START), 
  .BYP                (BYP_DQ), 
  .BYPCTL             (BYPC_DQ), 
  .BYPEN_VREF_SET     (BYPEN_VREF_SET), 
  .BYP_VREF_SET       (BYP_VREF_SET), 
  .CLOCKDR_DM         (CLOCKDR_DM), 
  .CLOCKDR_DQ         (CLOCKDR_DQ), 
  .CLOCKDR_DQS        (CLOCKDR_DQS), 
  .CMOS_EN            (CMOS_EN_REG_DIOR_INT), 
  .DIS_AUTOGT         (GT_DIS), 
  .DLL_EN             (DLL_EN_DQ), 
  .DLL_RESET          (DLL_RESET_DQ), 
  .DLL_UPDT_EN        (DLL_UPDT_EN_DQ), 
  .DM                 (PAD_MEM_DM), 
  .DQ                 (PAD_MEM_DQ), 
  .DQS                (PAD_MEM_DQS), 
  .DQS_GATE           (), 
  .DQS_N              (PAD_MEM_DQS_N), 
  .DRVSEL             (DRVSEL_REG_DIOR_INT), 
  .DTI_CALVL_DATA     (DTI_CALVL_DATA), 
  .DTI_CALVL_EN       (DTI_CALVL_DQ_EN), 
  .DTI_CALVL_STB      (DTI_CALVL_STB), 
  .DTI_CLOCK          (DTI_PHY_CLOCK), 
  .DTI_EXT_VREF       (DTI_EXT_VREF), 
  .DTI_INIT_COMPLETE  (DTI_INIT_COMPLETE_DQ), 
  .DTI_RANK_RD        (BYTE_RANK_RD), 
  .DTI_RANK_WR        (BYTE_RANK_WR), 
  .DTI_RDDATA         (BYTE_RDDATA), 
  .DTI_RDDATA_EN      (BYTE_RDDATA_EN), 
  .DTI_RDDATA_MASK    (BYTE_RDDATA_MASK), 
  .DTI_RDDATA_VALID   (BYTE_RDDATA_VALID), 
  .DTI_RDLVL_DLY      (DTI_RDLVL_DLY), 
  .DTI_RDLVL_DLY_DM   (DTI_RDLVL_DLY_DM), 
  .DTI_RDLVL_EDGE     (DTI_RDLVL_EDGE), 
  .DTI_RDLVL_EN       (DTI_RDLVL_EN), 
  .DTI_RDLVL_EN_DM    (DTI_RDLVL_EN_DM), 
  .DTI_RDLVL_GATE_DLY (DTI_RDLVL_GATE_DLY), 
  .DTI_RDLVL_GATE_EN  (DTI_RDLVL_GATE_EN), 
  .DTI_RDLVL_LOAD     (DTI_RDLVL_LOAD), 
  .DTI_VREF_EN        (DTI_VREF_EN_DQ), 
  .DTI_VREF_LOAD      (DTI_VREF_LOAD), 
  .DTI_VREF_RANGE     (DTI_VREF_RANGE), 
  .DTI_VREF_SET       (DTI_VREF_SET), 
  .DTI_VT_EN          (DTI_VT_EN), 
  .DTI_WDM_DLY        (DTI_WDM_DLY), 
  .DTI_WDQDLY_LOAD    (DTI_WDQ_LOAD), 
  .DTI_WDQ_DLY        (DTI_WDQ_DLY), 
  .DTI_WRDATA         (BYTE_WRDATA), 
  .DTI_WRDATA_EN      (BYTE_WRDATA_EN), 
  .DTI_WRDATA_MASK    (BYTE_WRDATA_MASK), 
  .DTI_WRLVL_DLY      (DTI_WRLVL_DLY), 
  .DTI_WRLVL_EN       (DTI_WRLVL_EN), 
  .DTI_WRLVL_LOAD     (DTI_WRLVL_LOAD), 
  .DTI_WRLVL_RESP     (DTI_WRLVL_RESP), 
  .DTI_WRLVL_STB      (DTI_WRLVL_STB), 
  .FENA_RCV           (FENA_RCV), 
  .GT_STATUS          (DTI_RDLVL_GATE_STATUS), 
  .GT_UPDT            (GT_UPDT), 
  .IO_MODE            (IO_MODE), 
  .JTAG_SI_DM         (JTAG_SI_DM), 
  .JTAG_SI_DQ         (JTAG_SI_DQ), 
  .JTAG_SI_DQS        (JTAG_SI_DQS), 
  .JTAG_SO_DM         (JTAG_SO_DM), 
  .JTAG_SO_DQ         (JTAG_SO_DQ), 
  .JTAG_SO_DQS        (JTAG_SO_DQS), 
  .LIMIT              (LIMIT_DQ), 
  .LOCK               (LOCK_DQ), 
  .LP_EN              (LP_EN_DQ), 
  .MODE_DM            (MODE_DM), 
  .MODE_DQ            (MODE_DQ), 
  .MODE_DQS           (MODE_DQS), 
  .MODE_I_DM          (MODE_I_DM), 
  .MODE_I_DQ          (MODE_I_DQ), 
  .MODE_I_DQS         (MODE_I_DQS), 
  .NCTLH0             (NCTLH0_DQ), 
  .NCTLH1             (NCTLH1_DQ), 
  .NCTLH10            (NCTLH10_DQ), 
  .NCTLH11            (NCTLH11_DQ), 
  .NCTLH2             (NCTLH2_DQ), 
  .NCTLH3             (NCTLH3_DQ), 
  .NCTLH4             (NCTLH4_DQ), 
  .NCTLH5             (NCTLH5_DQ), 
  .NCTLH6             (NCTLH6_DQ), 
  .NCTLH7             (NCTLH7_DQ), 
  .NCTLH8             (NCTLH8_DQ), 
  .NCTLH9             (NCTLH9_DQ), 
  .ODIS_DM            (ODIS_DM_REG_DIOR_INT), 
  .ODIS_DQ            (ODIS_DQ_REG_DIOR_INT), 
  .ODIS_DQS           (ODIS_DQS_REG_DIOR_INT), 
  .OUTBYPEN           (OUTBYPEN_DQ), 
  .OUTBYPEN_DM        (OUTBYPEN_DM), 
  .OUTBYPEN_DQS       (OUTBYPEN_DQS), 
  .OUT_DM             (OUTD_DM), 
  .OUT_DQ             (OUTD_DQ), 
  .OUT_DQS            (OUTD_DQS), 
  .OVFL               (OVFL_DQ), 
  .PAD_VREF           (PAD_VREF), 
  .PCTLH0             (PCTLH0_DQ), 
  .PCTLH1             (PCTLH1_DQ), 
  .PCTLH10            (PCTLH10_DQ), 
  .PCTLH11            (PCTLH11_DQ), 
  .PCTLH2             (PCTLH2_DQ), 
  .PCTLH3             (PCTLH3_DQ), 
  .PCTLH4             (PCTLH4_DQ), 
  .PCTLH5             (PCTLH5_DQ), 
  .PCTLH6             (PCTLH6_DQ), 
  .PCTLH7             (PCTLH7_DQ), 
  .PCTLH8             (PCTLH8_DQ), 
  .PCTLH9             (PCTLH9_DQ), 
  .R0_GTPH            (DTI_GTPH_R0), 
  .R0_HOLD            (DTI_HOLD_R0), 
  .R1_GTPH            (DTI_GTPH_R1), 
  .R1_HOLD            (DTI_HOLD_R1), 
  .RDLVL_DM           (DTI_RDLVL_SET_DM), 
  .RDLVL_SET          (DTI_RDLVL_SET), 
  .RDLVL_STATUS       (DTI_RDLVL_STATUS), 
  .RDLVL_STATUS_DM    (DTI_RDLVL_STATUS_DM), 
  .RET_ENI_H          (RET_ENI_H), 
  .RTTSEL             (RTT_SEL_REG_DIOR_INT), 
  .RTT_EN             (RTT_EN_REG_DIOR_INT), 
  .SE                 (SE), 
  .SE_CK              (SE_CK), 
  .SHIFTDR_DM         (SHIFTDR_DM), 
  .SHIFTDR_DQ         (SHIFTDR_DQ), 
  .SHIFTDR_DQS        (SHIFTDR_DQS), 
  .SI_DM              (SI_DM), 
  .SI_DQ              (SI_DQ), 
  .SI_RD              (SI_RD), 
  .SI_WR              (SI_WR), 
  .SO_DM              (SO_DM), 
  .SO_DQ              (SO_DQ), 
  .SO_RD              (SO_RD), 
  .SO_WR              (SO_WR), 
  .T_CGCTL            (T_CGCTL_DQ), 
  .T_RCTL             (T_RCTL_DQ), 
  .UNFL               (UNFL_DQ), 
  .UPDATEDR_DM        (UPDATEDR_DM), 
  .UPDATEDR_DQ        (UPDATEDR_DQ), 
  .UPDATEDR_DQS       (UPDATEDR_DQS), 
  .VDD                (VDD), 
  .VDDO               (VDDO), 
  .VSS                (VSS), 
  .VT_DONE            (DTI_VT_DONE), 
  .WRLVL_SET          (DTI_WRLVL_SET), 
  .WR_LEVELED         (DTI_WRLVL_STATUS), 
  .YC_DM              (Y_DM), 
  .YC_DQ              (Y_DQ), 
  .YC_DQS             (Y_DQS)
); 

dti_phy_sync_slice dti_phy_sync_slice[PHY_SLICE_NUM-1:0]( 
  .dti_mc_clock              (DTI_MC_CLOCK), 
  .dti_phy_clock             (DTI_PHY_CLOCK), 
  .DTI_PHY_CLOCK_DQ          (DTI_PHY_CLOCK), 
  .dti_sys_reset_n           (DTI_SYS_RESET_N), 
  .FENA_RCV_INT              (FENA_RCV_INT), 
  .DTI_CALVL_DQ_EN_INT       (DTI_CALVL_DQ_EN_INT), 
  .DTI_CALVL_DATA_INT        (DTI_CALVL_DATA_INT), 
  .FENA_RCV                  (FENA_RCV), 
  .DTI_CALVL_DQ_EN           (DTI_CALVL_DQ_EN), 
  .DTI_CALVL_DATA            (DTI_CALVL_DATA), 
  .DTI_RDLVL_GATE_EN_INT     (DTI_RDLVL_GATE_EN_INT), 
  .DTI_RDLVL_GATE_DLY_INT    (DTI_RDLVL_GATE_DLY_INT), 
  .DTI_RDLVL_GATE_STATUS     (DTI_RDLVL_GATE_STATUS), 
  .DTI_GTPH_R0               (DTI_GTPH_R0), 
  .DTI_GTPH_R1               (DTI_GTPH_R1), 
  .DTI_RDLVL_GATE_EN         (DTI_RDLVL_GATE_EN), 
  .DTI_RDLVL_GATE_DLY        (DTI_RDLVL_GATE_DLY), 
  .DTI_RDLVL_GATE_STATUS_INT (DTI_RDLVL_GATE_STATUS_INT), 
  .DTI_GTPH_R0_INT           (DTI_GTPH_R0_INT), 
  .DTI_GTPH_R1_INT           (DTI_GTPH_R1_INT), 
  .DTI_RDLVL_EDGE_INT        (DTI_RDLVL_EDGE_INT), 
  .DTI_RDLVL_EN_INT          (DTI_RDLVL_EN_INT), 
  .DTI_RDLVL_DLY_INT         (DTI_RDLVL_DLY_INT), 
  .DTI_RDLVL_STATUS          (DTI_RDLVL_STATUS), 
  .DTI_RDLVL_SET             (DTI_RDLVL_SET), 
  .DTI_RDLVL_EDGE            (DTI_RDLVL_EDGE), 
  .DTI_RDLVL_EN              (DTI_RDLVL_EN), 
  .DTI_RDLVL_DLY             (DTI_RDLVL_DLY), 
  .DTI_RDLVL_STATUS_INT      (DTI_RDLVL_STATUS_INT), 
  .DTI_RDLVL_SET_INT         (DTI_RDLVL_SET_INT), 
  .DTI_RDLVL_EN_DM_INT       (DTI_RDLVL_EN_DM_INT), 
  .DTI_RDLVL_DLY_DM_INT      (DTI_RDLVL_DLY_DM_INT), 
  .DTI_RDLVL_STATUS_DM       (DTI_RDLVL_STATUS_DM), 
  .DTI_RDLVL_SET_DM          (DTI_RDLVL_SET_DM), 
  .DTI_RDLVL_EN_DM           (DTI_RDLVL_EN_DM), 
  .DTI_RDLVL_DLY_DM          (DTI_RDLVL_DLY_DM), 
  .DTI_RDLVL_STATUS_DM_INT   (DTI_RDLVL_STATUS_DM_INT), 
  .DTI_RDLVL_SET_DM_INT      (DTI_RDLVL_SET_DM_INT), 
  .DTI_WRLVL_EN_INT          (DTI_WRLVL_EN_INT), 
  .DTI_WRLVL_DLY_INT         (DTI_WRLVL_DLY_INT), 
  .DTI_WRLVL_STATUS          (DTI_WRLVL_STATUS), 
  .DTI_WRLVL_SET             (DTI_WRLVL_SET), 
  .DTI_WRLVL_EN              (DTI_WRLVL_EN), 
  .DTI_WRLVL_DLY             (DTI_WRLVL_DLY), 
  .DTI_WRLVL_STATUS_INT      (DTI_WRLVL_STATUS_INT), 
  .DTI_WRLVL_SET_INT         (DTI_WRLVL_SET_INT), 
  .DTI_WDM_DLY_INT           (DTI_WDM_DLY_INT), 
  .DTI_WDQ_DLY_INT           (DTI_WDQ_DLY_INT), 
  .DTI_WDM_DLY               (DTI_WDM_DLY), 
  .DTI_WDQ_DLY               (DTI_WDQ_DLY), 
  .DTI_VREF_EN_INT           (ivrefen_reg_vtgc), 
  .DTI_VT_EN_INT             (DTI_VT_EN_INT), 
  .BYP_VREF_SET_INT          (BYP_VREF_SET_INT), 
  .BYPEN_VREF_SET_INT        (BYPEN_VREF_SET_INT), 
  .DTI_VREF_RANGE_INT        (DTI_VREF_RANGE_INT), 
  .DTI_VT_DONE               (DTI_VT_DONE), 
  .DTI_VREF_SET              (DTI_VREF_SET), 
  .DTI_VREF_EN               (DTI_VREF_EN_DQ), 
  .DTI_VT_EN                 (DTI_VT_EN), 
  .BYP_VREF_SET              (BYP_VREF_SET), 
  .BYPEN_VREF_SET            (BYPEN_VREF_SET), 
  .DTI_VREF_RANGE            (DTI_VREF_RANGE), 
  .DTI_VT_DONE_INT           (DTI_VT_DONE_INT), 
  .DTI_VREF_SET_INT          (DTI_VREF_SET_INT), 
  .BIST_ERR_DM_INT           (BISTERR_DM), 
  .BIST_ERR_DQ_INT           (BISTERR_DQ), 
  .BIST_ERR_DM               (bist_err_dm_reg_pbsr), 
  .BIST_ERR_DQ               (bist_err_dq_reg_pbsr), 
  .dqsleadck                 (dqsleadck), 
  .dqsleadck_int             (dqsleadck_int), 
  .BYP_REG_DLLDQ             (BYP_REG_DLLDQ), 
  .BYPC_REG_DLLDQ            (BYPC_REG_DLLDQ), 
  .BYP_REG_DLLDQ_INT         (BYP_DQ), 
  .BYPC_REG_DLLDQ_INT        (BYPC_DQ), 
  .CMOS_EN_REG_DIOR          (CMOS_EN_REG_DIOR), 
  .RTT_SEL_REG_DIOR          (RTT_SEL_REG_DIOR), 
  .RTT_EN_REG_DIOR           (RTT_EN_REG_DIOR), 
  .DRVSEL_REG_DIOR           (DRVSEL_REG_DIOR), 
  .ODIS_DM_REG_DIOR          (ODIS_DM_REG_DIOR), 
  .ODIS_DQS_REG_DIOR         (ODIS_DQS_REG_DIOR), 
  .ODIS_DQ_REG_DIOR          (ODIS_DQ_REG_DIOR), 
  .CMOS_EN_REG_DIOR_INT      (CMOS_EN_REG_DIOR_INT), 
  .RTT_SEL_REG_DIOR_INT      (RTT_SEL_REG_DIOR_INT), 
  .RTT_EN_REG_DIOR_INT       (RTT_EN_REG_DIOR_INT), 
  .DRVSEL_REG_DIOR_INT       (DRVSEL_REG_DIOR_INT), 
  .ODIS_DM_REG_DIOR_INT      (ODIS_DM_REG_DIOR_INT), 
  .ODIS_DQS_REG_DIOR_INT     (ODIS_DQS_REG_DIOR_INT), 
  .ODIS_DQ_REG_DIOR_INT      (ODIS_DQ_REG_DIOR_INT), 
  .DLL_EN_DQ                 (DLL_EN_DQ_INT), 
  .DLL_RESET_DQ              (DLL_RESET_DQ_INT), 
  .DLL_UPDT_EN_DQ            (DLL_UPDT_EN_DQ_INT), 
  .DLL_EN_DQ_INT             (DLL_EN_DQ), 
  .DLL_RESET_DQ_INT          (DLL_RESET_DQ), 
  .DLL_UPDT_EN_DQ_INT        (DLL_UPDT_EN_DQ), 
  .DTI_INIT_COMPLETE_DQ      (DTI_INIT_COMPLETE_DQ_INT), 
  .DTI_INIT_COMPLETE_DQ_INT  (DTI_INIT_COMPLETE_DQ), 
  .LIMIT_REG_DLLDQ           (LIMIT_REG_DLLDQ), 
  .LOCK_REG_DLLDQ_INT        (LOCK_DQ), 
  .OVFL_REG_DLLDQ_INT        (OVFL_DQ), 
  .UNFL_REG_DLLDQ_INT        (UNFL_DQ), 
  .LIMIT_REG_DLLDQ_INT       (LIMIT_DQ), 
  .LOCK_REG_DLLDQ            (LOCK_REG_DLLDQ), 
  .OVFL_REG_DLLDQ            (OVFL_REG_DLLDQ), 
  .UNFL_REG_DLLDQ            (UNFL_REG_DLLDQ), 
  .DTI_DATA_BYTE_DISABLE     (DTI_DATA_BYTE_DISABLE), 
  .DTI_DATA_BYTE_DISABLE_INT (DTI_DATA_BYTE_DISABLE_INT), 
  .GT_DIS_REG_RTGC           (GT_DIS_REG_RTGC), 
  .GT_DIS_REG_RTGC_INT       (GT_DIS), 
  .GT_UPDT_REG_RTGC          (GT_UPDT_REG_RTGC), 
  .GT_UPDT_REG_RTGC_INT      (GT_UPDT), 
  .LP_EN_REG_PBCR            (LP_EN_REG_PBCR), 
  .LP_EN_REG_PBCR_INT        (LP_EN_DQ), 
  .OUTBYPEN_DM               (REG_OUTBYPEN_DM), 
  .OUTBYPEN_DQ               (REG_OUTBYPEN_DQ), 
  .OUTBYPEN_DQS              (REG_OUTBYPEN_DQS), 
  .OUTBYPEN_DM_INT           (OUTBYPEN_DM), 
  .OUTBYPEN_DQ_INT           (OUTBYPEN_DQ), 
  .OUTBYPEN_DQS_INT          (OUTBYPEN_DQS), 
  .OUTD_DM                   (REG_OUTD_DM), 
  .OUTD_DQ                   (REG_OUTD_DQ), 
  .OUTD_DQS                  (REG_OUTD_DQS), 
  .OUTD_DM_INT               (OUTD_DM), 
  .OUTD_DQ_INT               (OUTD_DQ), 
  .OUTD_DQS_INT              (OUTD_DQS)
); 

dti_gear_slice dti_gear_slice[PHY_SLICE_NUM-1:0]( 
  .dti_mc_clock           (DTI_MC_CLOCK), 
  .dti_phy_clock          (DTI_PHY_CLOCK), 
  .dti_mc_clock_180       (DTI_MC_CLOCK_180), 
  .dti_phy_clock_180      (DTI_PHY_CLOCK_180), 
  .dti_sys_reset_n        (DTI_SYS_RESET_N), 
  .clklocken_reg_pom      (clklocken_reg_pom_int), 
  .dti_dram_clock_disable (DTI_DRAM_CLK_DISABLE_INT), 
  .dfien_reg_pom          (dfien_dq), 
  .mc_phase_lock          (mc_phase_lock_dq), 
  .dqsleadck              (dqsleadck_int), 
  .dti_freq_ratio         (DTI_FREQ_RATIO_INT), 
  .dqs2ck_en              (reg_dqs2ck_en_int), 
  .DTI_WRDATA_EN          (DTI_WRDATA_EN), 
  .DTI_WRDATA             (DTI_WRDATA), 
  .DTI_WRDATA_MASK        (DTI_WRDATA_MASK), 
  .DTI_RANK_WR            (DTI_RANK_WR), 
  .dti_wrdata_en_ctl      (DTI_WRDATA_EN_CTL), 
  .dti_wrdata_ctl         (DTI_WRDATA_CTL), 
  .dti_wrdata_mask_ctl    (DTI_WRDATA_MASK_CTL), 
  .dti_rank_wr_ctl        (DTI_RANK_WR_CTL), 
  .BYTE_WRDATA_EN         (BYTE_WRDATA_EN), 
  .BYTE_WRDATA            (BYTE_WRDATA), 
  .BYTE_WRDATA_MASK       (BYTE_WRDATA_MASK), 
  .BYTE_RANK_WR           (BYTE_RANK_WR), 
  .DTI_RDDATA_EN          (DTI_RDDATA_EN), 
  .DTI_RDDATA             (DTI_RDDATA), 
  .DTI_RDDATA_MASK        (DTI_RDDATA_MASK), 
  .DTI_RDDATA_VALID       (DTI_RDDATA_VALID), 
  .DTI_RANK_RD            (DTI_RANK_RD), 
  .dti_rddata_en_ctl      (DTI_RDDATA_EN_CTL), 
  .dti_rank_rd_ctl        (DTI_RANK_RD_CTL), 
  .BYTE_RDDATA_EN         (BYTE_RDDATA_EN), 
  .BYTE_RDDATA            (BYTE_RDDATA), 
  .BYTE_RDDATA_MASK       (BYTE_RDDATA_MASK), 
  .BYTE_RDDATA_VALID      (BYTE_RDDATA_VALID), 
  .BYTE_RANK_RD           (BYTE_RANK_RD), 
  .DTI_CALVL_STB_INT      (DTI_CALVL_STB_INT), 
  .DTI_CALVL_STB          (DTI_CALVL_STB), 
  .DTI_RDLVL_LOAD_INT     (DTI_RDLVL_LOAD_INT), 
  .DTI_RDLVL_LOAD         (DTI_RDLVL_LOAD), 
  .DTI_WRLVL_LOAD_INT     (DTI_WRLVL_LOAD_INT), 
  .DTI_WRLVL_STB_INT      (DTI_WRLVL_STB_INT), 
  .DTI_WRLVL_LOAD         (DTI_WRLVL_LOAD), 
  .DTI_WRLVL_STB          (DTI_WRLVL_STB), 
  .DTI_WDQ_LOAD_INT       (DTI_WDQ_LOAD_INT), 
  .DTI_WDQ_LOAD           (DTI_WDQ_LOAD), 
  .DTI_VREF_LOAD_INT      (DTI_VREF_LOAD_INT), 
  .DTI_VREF_LOAD          (DTI_VREF_LOAD)
); 

// HDL Embedded Text Block 1 eb1
// Assignment
assign clklockc_reg_pos_int = (&(mc_phase_lock_ctl | (~chanen_reg_pom_int))) & (&(mc_phase_lock_dq | DTI_DATA_BYTE_DISABLE_INT));

assign dfien_ctrl[0] = dfien_reg_pom | (|phyop_en & (~chanen_reg_pom[0]));
assign dfien_ctrl[1] = dfien_reg_pom | (|phyop_en & (~chanen_reg_pom[1]));

assign BIST_DONE     = &{BIST_DONE_CTL, {BIST_DONE_DQ | DTI_DATA_BYTE_DISABLE_INT}};

assign dfien_dq[0]   = dfien_reg_pom | (|phyop_en & (~chanen_reg_pom[0]));
assign dfien_dq[1]   = dfien_reg_pom | (|phyop_en & (~chanen_reg_pom[0]));
assign dfien_dq[2]   = dfien_reg_pom | (|phyop_en & (~chanen_reg_pom[1]));
assign dfien_dq[3]   = dfien_reg_pom | (|phyop_en & (~chanen_reg_pom[1]));

assign L4_DQ_RESP_B = DTI_WRLVL_RESP[3*DFI_SLICE_WIDTH +: DRAM_LP4_CA_WIDTH];
assign L4_DQ_RESP_A = DTI_WRLVL_RESP[1*DFI_SLICE_WIDTH +: DRAM_LP4_CA_WIDTH];
assign L3_DQ_RESP   = DTI_WRLVL_RESP[15:0];

assign  RET_ENI_H[3]  = PWRDNH_R;
assign  RET_ENI_H[2]  = PWRDNH_R;
assign  RET_ENI_H[1]  = PWRDNH_L;
assign  RET_ENI_H[0]  = PWRDNH_L;

assign  POR           = ~(COMP_RST_N_INT & srst_reg_pccr_int); // Reset Active HIGH

assign BIST_ERR_CTL = {BIST_ERR_ACT_N,
                       BIST_ERR_CA,
                       BIST_ERR_CKE,
                       BIST_ERR_CS,
                       BIST_ERR_ODT,
                       BIST_ERR_RESET_N};
assign PAD_MEM_CTL  = {MEM_ACT_N,
                       MEM_CA,
                       MEM_CKE,
                       MEM_CS,
                       MEM_ODT,
                       MEM_RESET_N};
assign {ODIS_ACT_N,
        ODIS_CA,
        ODIS_CKE,
        ODIS_CS,
        ODIS_ODT,
        ODIS_RESET_N } = ODIS_CTL_REG_CIOR; // Without Sync
assign {OUTBYPEN_ACT_N,
        OUTBYPEN_CA,
        OUTBYPEN_CKE,
        OUTBYPEN_CS,
        OUTBYPEN_ODT,
        OUTBYPEN_RESET_N } = OUTBYPEN_CTL;
assign {OUTD_ACT_N,
        OUTD_CA,
        OUTD_CKE,
        OUTD_CS,
        OUTD_ODT,
        OUTD_RESET_N } = OUTD_CTL;
assign {JTAG_SI_ACT_N,
        JTAG_SI_CA,
        JTAG_SI_CKE,
        JTAG_SI_CS,
        JTAG_SI_ODT,
        JTAG_SI_RESET_N } = JTAG_SI_CTL;
assign {SI_ACT_N,
        SI_CA,
        SI_CKE,
        SI_CS,
        SI_ODT,
        SI_RESET_N } = SI_CTL;
assign {CLOCKDR_ACT_N,
        CLOCKDR_CA,
        CLOCKDR_CKE,
        CLOCKDR_CS,
        CLOCKDR_ODT,
        CLOCKDR_RESET_N } = CLOCKDR_CTL;
assign {SHIFTDR_ACT_N,
        SHIFTDR_CA,
        SHIFTDR_CKE,
        SHIFTDR_CS,
        SHIFTDR_ODT,
        SHIFTDR_RESET_N } = SHIFTDR_CTL;
assign {MODE_ACT_N,
        MODE_CA,
        MODE_CKE,
        MODE_CS,
        MODE_ODT,
        MODE_RESET_N } = MODE_CTL;
assign {UPDATEDR_ACT_N,
        UPDATEDR_CA,
        UPDATEDR_CKE,
        UPDATEDR_CS,
        UPDATEDR_ODT,
        UPDATEDR_RESET_N } = UPDATEDR_CTL;
assign JTAG_SO_CTL = {JTAG_SO_ACT_N,
                      JTAG_SO_CA,
                      JTAG_SO_CKE,
                      JTAG_SO_CS,
                      JTAG_SO_ODT,
                      JTAG_SO_RESET_N};
assign SO_CTL      = {SO_ACT_N,
                      SO_CA,
                      SO_CKE,
                      SO_CS,
                      SO_ODT,
                      SO_RESET_N};
assign YC_CTL      = {YC_ACT_N,
                      YC_CA,
                      YC_CKE,
                      YC_CS,
                      YC_ODT,
                      YC_RESET_N};

assign NCTLH0_DQ  = {NCTLH0 , NCTLH0 , NCTLH0 , NCTLHO0 };
assign NCTLH1_DQ  = {NCTLH1 , NCTLH1 , NCTLH1 , NCTLHO1 };
assign NCTLH2_DQ  = {NCTLH2 , NCTLH2 , NCTLH2 , NCTLHO2 };
assign NCTLH3_DQ  = {NCTLH3 , NCTLH3 , NCTLH3 , NCTLHO3 };
assign NCTLH4_DQ  = {NCTLH4 , NCTLH4 , NCTLH4 , NCTLHO4 };
assign NCTLH5_DQ  = {NCTLH5 , NCTLH5 , NCTLH5 , NCTLHO5 };
assign NCTLH6_DQ  = {NCTLH6 , NCTLH6 , NCTLH6 , NCTLHO6 };
assign NCTLH7_DQ  = {NCTLH7 , NCTLH7 , NCTLH7 , NCTLHO7 };
assign NCTLH8_DQ  = {NCTLH8 , NCTLH8 , NCTLH8 , NCTLHO8 };
assign NCTLH9_DQ  = {NCTLH9 , NCTLH9 , NCTLH9 , NCTLHO9 };
assign NCTLH10_DQ = {NCTLH10, NCTLH10, NCTLH10, NCTLHO10};
assign NCTLH11_DQ = {NCTLH11, NCTLH11, NCTLH11, NCTLHO11};

assign PCTLH0_DQ  = {PCTLH0 , PCTLH0 , PCTLH0 , PCTLHO0 };
assign PCTLH1_DQ  = {PCTLH1 , PCTLH1 , PCTLH1 , PCTLHO1 };
assign PCTLH2_DQ  = {PCTLH2 , PCTLH2 , PCTLH2 , PCTLHO2 };
assign PCTLH3_DQ  = {PCTLH3 , PCTLH3 , PCTLH3 , PCTLHO3 };
assign PCTLH4_DQ  = {PCTLH4 , PCTLH4 , PCTLH4 , PCTLHO4 };
assign PCTLH5_DQ  = {PCTLH5 , PCTLH5 , PCTLH5 , PCTLHO5 };
assign PCTLH6_DQ  = {PCTLH6 , PCTLH6 , PCTLH6 , PCTLHO6 };
assign PCTLH7_DQ  = {PCTLH7 , PCTLH7 , PCTLH7 , PCTLHO7 };
assign PCTLH8_DQ  = {PCTLH8 , PCTLH8 , PCTLH8 , PCTLHO8 };
assign PCTLH9_DQ  = {PCTLH9 , PCTLH9 , PCTLH9 , PCTLHO9 };
assign PCTLH10_DQ = {PCTLH10, PCTLH10, PCTLH10, PCTLHO10};
assign PCTLH11_DQ = {PCTLH11, PCTLH11, PCTLH11, PCTLHO11};

assign  {TSTIO_NCTLH11 , TSTIO_NCTLH10 , TSTIO_NCTLH9  , TSTIO_NCTLH8  ,
         TSTIO_NCTLH7  , TSTIO_NCTLH6  , TSTIO_NCTLH5  , TSTIO_NCTLH4  ,
         TSTIO_NCTLH3  , TSTIO_NCTLH2  , TSTIO_NCTLH1  , TSTIO_NCTLH0  } = TSTIO_NCTLH;
assign  {TSTIO_PCTLH11 , TSTIO_PCTLH10 , TSTIO_PCTLH9  , TSTIO_PCTLH8  ,
         TSTIO_PCTLH7  , TSTIO_PCTLH6  , TSTIO_PCTLH5  , TSTIO_PCTLH4  ,
         TSTIO_PCTLH3  , TSTIO_PCTLH2  , TSTIO_PCTLH1  , TSTIO_PCTLH0  } = TSTIO_PCTLH;

assign  {NCTLH11 , NCTLH10 , NCTLH9  , NCTLH8  ,
         NCTLH7  , NCTLH6  , NCTLH5  , NCTLH4  ,
         NCTLH3  , NCTLH2  , NCTLH1  , NCTLH0  } = NCTLH;
assign  {PCTLH11 , PCTLH10 , PCTLH9  , PCTLH8  ,
         PCTLH7  , PCTLH6  , PCTLH5  , PCTLH4  ,
         PCTLH3  , PCTLH2  , PCTLH1  , PCTLH0  } = PCTLH;



endmodule // dti_tm16_phy


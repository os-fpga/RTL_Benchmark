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

  assign /*output  wire    [DRAM_CHAN_NUM * AXI4_DATA_WIDTH / 8 - 1:0]                                   */ DTI_RDDATA_MASK_MC='d0; 
  assign /*output  wire    [DRAM_CHAN_NUM * AXI4_DATA_WIDTH - 1:0]                                       */ DTI_RDDATA_MC='d0; 
  assign /*output  wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                                       */ DTI_RDDATA_VALID_MC='d0; 
  assign /*output  wire    [DRAM_CHAN_NUM-1:0]                                                           */ JTAG_SO_CLK='d0; 
  assign /*output  wire    [PHY_CTRL_WIDTH - 1:0]                                                        */ JTAG_SO_CTL='d0; 
  assign /*output  wire    [PHY_SLICE_NUM-1:0]                                                           */ JTAG_SO_DM='d0; 
  assign /*output  wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                         */ JTAG_SO_DQ='d0; 
  assign /*output  wire    [PHY_SLICE_NUM-1:0]                                                           */ JTAG_SO_DQS='d0; 
  assign /*output  wire    [DRAM_CHAN_NUM-1:0]                                                           */ LOCK_REG_DLLCA='d0; 
  assign /*output  wire    [PHY_SLICE_NUM-1:0]                                                           */ LOCK_REG_DLLDQ='d0; 
  assign /*output  wire    [3:0]                                                                         */ NBC_REG_PCSR='d0; 
  assign /*output  wire    [DRAM_CHAN_NUM-1:0]                                                           */ OVFL_REG_DLLCA='d0; 
  assign /*output  wire    [PHY_SLICE_NUM-1:0]                                                           */ OVFL_REG_DLLDQ='d0; 
  assign /*output  wire    [1:0]                                                                         */ PAD_MEM_CLK='d0; 
  assign /*output  wire    [1:0]                                                                         */ PAD_MEM_CLK_N='d0; 
  assign /*output  wire    [PHY_CTRL_WIDTH - 1:0]                                                        */ PAD_MEM_CTL='d0; 
  assign /*output  wire    [3:0]                                                                         */ PBC_REG_PCSR='d0; 
  assign /*output  wire    [DRAM_CHAN_NUM-1:0]                                                           */ SO_CLK='d0; 
  assign /*output  wire    [PHY_CTRL_WIDTH - 1:0]                                                        */ SO_CTL='d0; 
  assign /*output  wire    [PHY_SLICE_NUM-1:0]                                                           */ SO_DM='d0; 
  assign /*output  wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                         */ SO_DQ='d0; 
  assign /*output  wire    [PHY_SLICE_NUM-1:0]                                                           */ SO_RD='d0; 
  assign /*output  wire    [PHY_SLICE_NUM-1:0]                                                           */ SO_WR='d0; 
  assign /*output  wire    [DRAM_CHAN_NUM-1:0]                                                           */ UNFL_REG_DLLCA='d0; 
  assign /*output  wire    [PHY_SLICE_NUM-1:0]                                                           */ UNFL_REG_DLLDQ='d0; 
  assign /*output  wire                                                                                  */ UPDT_C_REG_PCSR='d0; 
  assign /*output  wire    [DRAM_CHAN_NUM-1:0]                                                           */ YC_CLK='d0; 
  assign /*output  wire    [PHY_CTRL_WIDTH - 1:0]                                                        */ YC_CTL='d0; 
  assign /*output  wire    [PHY_SLICE_NUM-1:0]                                                           */ Y_DM='d0; 
  assign /*output  wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                         */ Y_DQ='d0; 
  assign /*output  wire    [PHY_SLICE_NUM-1:0]                                                           */ Y_DQS='d0; 
  assign /*output  wire                                                                                  */ bist_done_reg_pbsr='d0; 
  assign /*output  wire    [PHY_CTRL_WIDTH-1:0]                                                          */ bist_err_ctl_reg_pbsr='d0; 
  assign /*output  wire    [PHY_SLICE_NUM-1:0]                                                           */ bist_err_dm_reg_pbsr='d0; 
  assign /*output  wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]                                         */ bist_err_dq_reg_pbsr='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * DRAM_CHAN_NUM * PHY_CA_WIDTH * PHY_CALVL_DLY_WIDTH - 1:0]    */ ca_reg_ptsr_ip='d0; 
  assign /*output  wire                                                                                  */ clklockc_reg_pos='d0; 
  assign /*output  wire                                                                                  */ cmddlyc_reg_pos='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * DRAM_CHAN_NUM * PHY_CALVL_SET_WIDTH - 1:0]                   */ cs_reg_ptsr_ip='d0; 
  assign /*output  wire    [PHY_SLICE_NUM+DRAM_CHAN_NUM-1:0]                                             */ dllerr_reg_pts='d0; 
  assign /*output  wire                                                                                  */ dllrstc_reg_pos='d0; 
  assign /*output  wire    [CHAN_RANK_NUM - 1:0]                                                         */ dlyevalc_reg_pos='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * PHY_WDM_DLY_WIDTH - 1:0]                     */ dqsdm_reg_ptsr_ip='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM - 1:0]                                         */ dqsdmerr_reg_pts='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * DFI_SLICE_WIDTH * PHY_WDQ_DLY_WIDTH - 1:0]   */ dqsdq_reg_ptsr_ip='d0; 
  assign /*output  wire    [CHAN_RANK_NUM - 1:0]                                                         */ dqsdqc_reg_pos='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * DFI_SLICE_WIDTH - 1:0]                       */ dqsdqerr_reg_pts='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM - 1:0]                                         */ dqsleadck_reg_ptsr_ip='d0; 
  assign /*output  wire                                                                                  */ draminitc_reg_pos='d0; 
  assign /*output  wire                                                                                  */ fs0req_reg_pos='d0; 
  assign /*output  wire                                                                                  */ fs1req_reg_pos='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * PHY_GATE_DLY_WIDTH - 1:0]                    */ gt_reg_ptsr_ip='d0; 
  assign /*output  wire    [CHAN_RANK_NUM - 1:0]                                                         */ gtc_reg_pos='d0; 
  assign /*output  wire    [CHAN_RANK_NUM*PHY_SLICE_NUM-1:0]                                             */ gterr_reg_pts='d0; 
  assign /*output  wire    [CHAN_RANK_NUM*DRAM_CHAN_NUM-1:0]                                             */ lp3calvlerr_reg_pts='d0; 
  assign /*output  wire                                                                                  */ mupd_reg_dqsdqcr_clr='d0; 
  assign /*output  wire                                                                                  */ nt_rank_reg_ptsr_ip='d0; 
  assign /*output  wire                                                                                  */ ofs_reg_pos='d0; 
  assign /*output  wire                                                                                  */ phyfsc_reg_pos='d0; 
  assign /*output  wire                                                                                  */ phyinitc_reg_pos='d0; 
  assign /*output  wire                                                                                  */ physetc_reg_pos='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM - 1:0]                                         */ psck_reg_ptsr_ip='d0; 
  assign /*output  wire                                                                                  */ ptsr_upd='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * DFI_SLICE_WIDTH * PHY_RDLVL_DLY_WIDTH - 1:0] */ rdlvl_reg_ptsr_ip='d0; 
  assign /*output  wire    [CHAN_RANK_NUM - 1:0]                                                         */ rdlvlc_reg_pos='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * PHY_RDLVL_DLY_WIDTH - 1:0]                   */ rdlvldm_reg_ptsr_ip='d0; 
  assign /*output  wire    [CHAN_RANK_NUM*PHY_SLICE_NUM-1:0]                                             */ rdlvldmerr_reg_pts='d0; 
  assign /*output  wire    [CHAN_RANK_NUM*PHY_SLICE_NUM*DFI_SLICE_WIDTH-1:0]                             */ rdlvldqerr_reg_pts='d0; 
  assign /*output  wire    [CHAN_RANK_NUM - 1:0]                                                         */ sanchkc_reg_pos='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM - 1:0]                                         */ sanchkerr_reg_pts='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr11_fs0='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr11_fs1='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr11_nt_fs0='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr11_nt_fs1='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr12_fs0='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr12_fs1='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr13='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr13_nt='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr14_fs0='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr14_fs1='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr1_fs0='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr1_fs1='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr22_fs0='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr22_fs1='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr22_nt_fs0='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr22_nt_fs1='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr2_fs0='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr2_fs1='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr3_fs0='d0; 
  assign /*output  wire    [MRR_DATA_WIDTH - 1:0]                                                        */ shad_reg_lpddr4_mr3_fs1='d0; 
  assign /*output  wire                                                                                  */ srstc_reg_pcsr='d0; 
  assign /*output  wire                                                                                  */ vrefcac_reg_pos='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * DRAM_CHAN_NUM-1:0]                                           */ vrefcaerr_reg_pts='d0; 
  assign /*output  wire    [CHAN_RANK_NUM - 1:0]                                                         */ vrefcar_reg_ptsr_ip='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_VREF_WIDTH - 1:0]                                        */ vrefcas_reg_ptsr_ip='d0; 
  assign /*output  wire    [CHAN_RANK_NUM - 1:0]                                                         */ vrefdqr_reg_ptsr_ip='d0; 
  assign /*output  wire                                                                                  */ vrefdqrdc_reg_pos='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM - 1:0]                                         */ vrefdqrderr_reg_pts='d0; 
  assign /*output  wire                                                                                  */ vrefdqrdr_reg_ptsr_ip='d0; 
  assign /*output  wire    [PHY_SLICE_NUM * PHY_VREF_WIDTH - 1:0]                                        */ vrefdqrds_reg_ptsr_ip='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_VREF_WIDTH - 1:0]                                        */ vrefdqs_reg_ptsr_ip='d0; 
  assign /*output  wire    [CHAN_RANK_NUM - 1:0]                                                         */ vrefdqwrc_reg_pos='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM - 1:0]                                         */ vrefdqwrerr_reg_pts='d0; 
  assign /*output  wire    [CHAN_RANK_NUM * PHY_SLICE_NUM * PHY_WRLVL_DLY_WIDTH - 1:0]                   */ wrlvl_reg_ptsr_ip='d0; 
  assign /*output  wire    [CHAN_RANK_NUM - 1:0]                                                         */ wrlvlc_reg_pos='d0; 
  assign /*output  wire    [CHAN_RANK_NUM*PHY_SLICE_NUM-1:0]                                             */ wrlvlerr_reg_pts='d0; 



endmodule // dti_tm16_phy


//-----------------------------------------------------------------------------------------------------------
//    Copyright (C) 2020 by Dolphin Technology
//    All right reserved.
//
//    Copyright Notification
//    No part may be reproduced except as authorized by written permission.
//
//    Module dynamo_rps.dynamo_core.struct
//    Company: Dolphin Technology
//    Author: phuongnn0
//    Date: 11:58:45 - 08/18/22
//-----------------------------------------------------------------------------------------------------------
`include "dti_global_defines.vh"
module dynamo_core #(
  parameter ACQ_BUF_DEPTH          = `CFG_ACQ_BUF_DEPTH,
  parameter ACQ_PTR_WIDTH          = `CFG_ACQ_PTR_WIDTH,
  parameter ACQ_STARV_WIDTH        = `CFG_ACQ_STARV_WIDTH,
  parameter ACR_CAS_INFO_WIDTH     = `CFG_ACR_CAS_INFO_WIDTH,
  parameter ACR_RAS_INFO_WIDTH     = `CFG_ACR_RAS_INFO_WIDTH,
  parameter ACR_REQ_THRESHOLD      = `CFG_ACR_REQ_THRESHOLD,
  parameter ADDR_CONFIG_WIDTH      = `CFG_ADDR_CONFIG_WIDTH,
  parameter AXI4_ADDR_WIDTH        = `CFG_AXI4_ADDR_WIDTH,
  parameter AXI4_BURST_WIDTH       = `CFG_AXI4_BURST_WIDTH,
  parameter AXI4_CACHE_WIDTH       = `CFG_AXI4_CACHE_WIDTH,
  parameter AXI4_DATA_WIDTH        = `CFG_AXI4_DATA_WIDTH,
  parameter AXI4_ID_WIDTH          = `CFG_AXI4_ID_WIDTH,
  parameter AXI4_LEN_WIDTH         = `CFG_AXI4_LEN_WIDTH,
  parameter AXI4_PROT_WIDTH        = `CFG_AXI4_PROT_WIDTH,
  parameter AXI4_QOS_WIDTH         = `CFG_AXI4_QOS_WIDTH,
  parameter AXI4_RESP_WIDTH        = `CFG_AXI4_RESP_WIDTH,
  parameter AXI4_SIZE_WIDTH        = `CFG_AXI4_SIZE_WIDTH,
  parameter AXI4_STRB_WIDTH        = `CFG_AXI4_STRB_WIDTH,
  parameter AXI_PORT_NUM           = `CFG_AXI_PORT_NUM,
  parameter AXI_PORT_WIDTH         = `CFG_AXI_PORT_WIDTH,
  parameter BRIF_PRI_ONEHOT        = `CFG_BRIF_PRI_ONEHOT,
  parameter BRIF_PRI_WIDTH         = `CFG_BRIF_PRI_WIDTH,
  parameter BRIF_TAGID_WIDTH       = `CFG_BRIF_TAGID_WIDTH,
  parameter CHAN_LAT_BARRIER_WIDTH = `CFG_CHAN_LAT_BARRIER_WIDTH,
  parameter CHAN_LAT_WIDTH         = `CFG_CHAN_LAT_WIDTH,
  parameter CMDADDR_BUS            = `CFG_CMDADDR_BUS,
  parameter DC_ROUTE_NUM           = `CFG_DC_ROUTE_NUM,
  parameter DFI_DATA_WIDTH         = `CFG_DFI_DATA_WIDTH,
  parameter DFI_SLICE_WIDTH        = `CFG_DFI_SLICE_WIDTH,
  parameter DIMM_PER_CHAN          = `CFG_DIMM_PER_CHAN,
  parameter DRAM_ADDR_WIDTH        = `CFG_DRAM_ADDR_WIDTH,
  parameter DRAM_BANK_NUM          = `CFG_DRAM_BA_NUM,
  parameter DRAM_BANK_STATUS_WIDTH = `CFG_DRAM_BANK_STATUS_WIDTH,
  parameter DRAM_BA_WIDTH          = `CFG_DRAM_BA_WIDTH,
  parameter DRAM_BG_NUM            = `CFG_DRAM_BG_NUM,
  parameter DRAM_BL_ENC_WIDTH      = `CFG_DRAM_BL_ENC_WIDTH,
  parameter DRAM_BL_WIDTH          = `CFG_DRAM_BL_WIDTH,
  parameter DRAM_CHAN_NUM          = `CFG_DRAM_CHAN_NUM,
  parameter DRAM_CMD_WIDTH         = `CFG_DRAM_CMD_WIDTH,
  parameter DRAM_COL_WIDTH         = `CFG_DRAM_COL_WIDTH,
  parameter DRAM_CTRL_WIDTH        = `CFG_DRAM_CTRL_WIDTH,
  parameter DRAM_LP4_CA_WIDTH      = `CFG_DRAM_LP4_CA_WIDTH,
  parameter DRAM_ROW_WIDTH         = `CFG_DRAM_ROW_WIDTH,
  parameter FREQUENCY_RATIO        = `CFG_FREQUENCY_RATIO,
  parameter FREQ_RATIO_WIDTH       = `CFG_FREQ_RATIO_WIDTH,
  parameter LPDDR_MR_OPCODE_WIDTH  = `CFG_LPDDR_MR_OPCODE_WIDTH,
  parameter MC_CMD_WIDTH           = `CFG_MC_CMD_WIDTH,
  parameter MC_COUNTER_WIDTH       = `CFG_MC_COUNTER_WIDTH,
  parameter MC_SW_COUNTER_WIDTH    = `CFG_MC_SW_COUNTER_WIDTH,
  parameter MC_W_COUNTER_WIDTH     = `CFG_MC_W_COUNTER_WIDTH,
  parameter MC_ZQ_COUNTER_WIDTH    = `CFG_MC_ZQ_COUNTER_WIDTH,
  parameter MRR_DATA_WIDTH         = `CFG_MRR_DATA_WIDTH,
  parameter NROW_PTR_WIDTH         = `CFG_NROW_PTR_WIDTH,
  parameter ODT_COUNT_WIDTH        = `CFG_ODT_COUNT_WIDTH,
  parameter PHY_CALVL_DLY_WIDTH    = `CFG_PHY_CALVL_DLY_WIDTH,
  parameter PHY_CMD_DLY_WIDTH      = `CFG_PHY_CMD_DLY_WIDTH,
  parameter PHY_COUNTER_WIDTH      = `CFG_PHY_COUNTER_WIDTH,
  parameter PHY_CSLVL_DLY_WIDTH    = `CFG_PHY_CSLVL_DLY_WIDTH,
  parameter PHY_DELAY_WIDTH        = `CFG_PHY_DELAY_WIDTH,
  parameter PHY_DQ_TRANS           = `CFG_PHY_DQ_TRANS,
  parameter PHY_GATE_DLY_WIDTH     = `CFG_PHY_GATE_DLY_WIDTH,
  parameter PHY_RDLVL_DLY_WIDTH    = `CFG_PHY_RDLVL_DLY_WIDTH,
  parameter PHY_SLICE_NUM          = `CFG_PHY_SLICE_NUM,
  parameter PHY_VREF_WIDTH         = `CFG_PHY_VREF_WIDTH,
  parameter PHY_WDM_DLY_WIDTH      = `CFG_PHY_WDM_DLY_WIDTH,
  parameter PHY_WDQ_DLY_WIDTH      = `CFG_PHY_WDQ_DLY_WIDTH,
  parameter PHY_WIDE_COUNTER_WIDTH = `CFG_PHY_WIDE_COUNTER_WIDTH,
  parameter PHY_WRLVL_DLY_WIDTH    = `CFG_PHY_WRLVL_DLY_WIDTH,
  parameter POLICY_BICTR_WIDTH     = `CFG_POLICY_BICTR_WIDTH,
  parameter RCB_ADDR_WIDTH         = `CFG_RCB_ADDR_WIDTH,
  parameter RCB_BUF_DEPTH          = `CFG_RCB_BUF_DEPTH,
  parameter RCB_BUF_WIDTH          = `CFG_RCB_BUF_WIDTH,
  parameter RCB_DATA_WIDTH         = `CFG_RCB_DATA_WIDTH,
  parameter RCB_PTR_WIDTH          = `CFG_RCB_PTR_WIDTH,
  parameter RCB_RESP_WIDTH         = `CFG_RCB_RESP_WIDTH,
  parameter RCB_TAG_WIDTH          = `CFG_RCB_TAG_WIDTH,
  parameter ROUTE_WIDTH_MAX        = `CFG_DC_ROUTE_WIDTH,
  parameter SHIFT_MASK_WIDTH       = `CFG_XQ_SHIFT_MASK_WIDTH,
  parameter USER_CMD_CHAN_WIDTH    = `CFG_USER_CMD_CHAN_WIDTH,
  parameter USER_CMD_WIDTH         = `CFG_USER_CMD_WIDTH,
  parameter USER_MRS_SEL_WIDTH     = `CFG_USER_MRS_SEL_WIDTH,
  parameter WCB_ADDR_WIDTH         = `CFG_WCB_ADDR_WIDTH,
  parameter WCB_BUF_DEPTH          = `CFG_WCB_BUF_DEPTH,
  parameter WCB_BUF_WIDTH          = `CFG_WCB_BUF_WIDTH,
  parameter WCB_DATA_WIDTH         = `CFG_WCB_DATA_WIDTH,
  parameter WCB_PTR_WIDTH          = `CFG_WCB_PTR_WIDTH,
  parameter WCB_RESP_WIDTH         = `CFG_WCB_RESP_WIDTH,
  parameter WCB_STRB_WIDTH         = `CFG_WCB_STRB_WIDTH,
  parameter WCB_TAG_WIDTH          = `CFG_WCB_TAG_WIDTH,
  parameter XQR_SHIFT_DELAY_WIDTH  = `CFG_XQR_SHIFT_DELAY_WIDTH,
  parameter XQW_SHIFT_DELAY_WIDTH  = `CFG_XQW_SHIFT_DELAY_WIDTH,
  parameter AXI4_MASTER_DATA_WIDTH = `CFG_AXI4_MASTER_DATA_WIDTH,
  parameter AXI4_MASTER_STRB_WIDTH = `CFG_AXI4_MASTER_STRB_WIDTH,
  parameter USER_CMDOP_WIDTH       = `CFG_USER_CMDOP_WIDTH,
  parameter LPDDR_MA_WIDTH         = `CFG_LPDDR_MA_WIDTH,
  parameter DLL_BYPC_WIDTH         = `CFG_DLL_BYPC_WIDTH,
  parameter CLK_DLY_WIDTH          = `CFG_CLK_DLY_WIDTH,
  parameter DLL_LIM_WIDTH          = `CFG_DLL_LIM_WIDTH,
  parameter ECC_NUM                = `CFG_AXI4_DATA_WIDTH/64,
  parameter ERR_CNT_WIDTH          = `CFG_ERR_CNT_WIDTH,
  parameter ECC_DATA_WIDTH         = `CFG_ECC_DATA_WIDTH,
  parameter ECC_MC_CYCLE           = `CFG_ECC_MC_CYCLE,
  parameter DRAM_RANK_WIDTH        = `CFG_DRAM_RANK_WIDTH,
  parameter DRAM_MR_WIDTH          = `CFG_DRAM_MR_WIDTH,
  parameter USER_CMD_RANK_WIDTH    = `CFG_USER_CMD_RANK_WIDTH,
  parameter CHAN_RANK_NUM          = `CFG_CHAN_RANK_NUM,
  parameter AXI4LITE_ADDR_WIDTH    = `CFG_AXI4LITE_ADDR_WIDTH,
  parameter AXI4LITE_RESP_WIDTH    = `CFG_AXI4LITE_RESP_WIDTH,
  parameter AXI4LITE_DATA_WIDTH    = `CFG_AXI4LITE_DATA_WIDTH,
  parameter DRAM_CA_WIDTH          = `CFG_DFI_CA_WIDTH,
  parameter DRAM_LP3_CA_WIDTH      = `CFG_DRAM_LP3_CA_WIDTH,
  parameter DRAM_BG_WIDTH          = `CFG_DRAM_BG_WIDTH,
  parameter PHY_CA_WIDTH           = `CFG_PHY_CA_WIDTH,
  parameter XQ_T_CAL_WIDTH         = `CFG_XQ_T_CAL_WIDTH
)
( 
  // Port Declarations
  input   wire    [AXI_PORT_NUM - 1:0]                                                  aclk_p, 
  input   wire    [AXI_PORT_NUM * AXI4_ADDR_WIDTH - 1:0]                                araddr_p, 
  input   wire    [AXI_PORT_NUM * AXI4_BURST_WIDTH - 1:0]                               arburst_p, 
  input   wire    [AXI_PORT_NUM * AXI4_CACHE_WIDTH - 1:0]                               arcache_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                                                  aresetn_p, 
  input   wire    [AXI_PORT_NUM * AXI4_ID_WIDTH - 1:0]                                  arid_p, 
  input   wire    [AXI_PORT_NUM * AXI4_LEN_WIDTH - 1:0]                                 arlen_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                                                  arlock_p, 
  input   wire    [AXI_PORT_NUM * AXI4_PROT_WIDTH - 1:0]                                arprot_p, 
  input   wire    [AXI_PORT_NUM * AXI4_QOS_WIDTH - 1:0]                                 arqos_p, 
  input   wire    [AXI_PORT_NUM * AXI4_SIZE_WIDTH - 1:0]                                arsize_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                                                  arvalid_p, 
  input   wire    [AXI_PORT_NUM * AXI4_ADDR_WIDTH - 1:0]                                awaddr_p, 
  input   wire    [AXI_PORT_NUM * AXI4_BURST_WIDTH - 1:0]                               awburst_p, 
  input   wire    [AXI_PORT_NUM * AXI4_CACHE_WIDTH - 1:0]                               awcache_p, 
  input   wire    [AXI_PORT_NUM * AXI4_ID_WIDTH - 1:0]                                  awid_p, 
  input   wire    [AXI_PORT_NUM * AXI4_LEN_WIDTH - 1:0]                                 awlen_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                                                  awlock_p, 
  input   wire    [AXI_PORT_NUM * AXI4_PROT_WIDTH - 1:0]                                awprot_p, 
  input   wire    [AXI_PORT_NUM * AXI4_QOS_WIDTH - 1:0]                                 awqos_p, 
  input   wire    [AXI_PORT_NUM * AXI4_SIZE_WIDTH - 1:0]                                awsize_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                                                  awvalid_p, 
  input   wire    [AXI4LITE_ADDR_WIDTH - 1:0]                                           axi4lite_araddr, 
  input   wire                                                                          axi4lite_arvalid, 
  input   wire    [AXI4LITE_ADDR_WIDTH - 1:0]                                           axi4lite_awaddr, 
  input   wire                                                                          axi4lite_awvalid, 
  input   wire                                                                          axi4lite_bready, 
  input   wire                                                                          axi4lite_clk, 
  input   wire                                                                          axi4lite_reset_n, 
  input   wire                                                                          axi4lite_rready, 
  input   wire    [AXI4LITE_DATA_WIDTH - 1:0]                                           axi4lite_wdata, 
  input   wire                                                                          axi4lite_wvalid, 
  input   wire    [AXI_PORT_NUM - 1:0]                                                  bready_p, 
  input   wire                                                                          clk, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO * 2 * DFI_DATA_WIDTH - 1:0]          dfi_rddata, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO * 2 * DFI_DATA_WIDTH / 8 - 1:0]      dfi_rddata_dbi_n, 
  input   wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO * 2 - 1:0]                           dfi_rddata_ecc_dbi_n, 
  input   wire    [DRAM_CHAN_NUM*FREQUENCY_RATIO - 1:0]                                 dfi_rddata_valid, 
  input   wire                                                                          mupd_dqsdqcr_clr, 
  input   wire    [29:0]                                                                pbsr_bist_err_ctl, 
  input   wire    [3:0]                                                                 pbsr_bist_err_dm, 
  input   wire    [31:0]                                                                pbsr_bist_err_dq, 
  input   wire    [3:0]                                                                 pts_lp3calvlerr, 
  input   wire    [531:0]                                                               ptsr_ca_ip, 
  input   wire    [27:0]                                                                ptsr_cs_ip, 
  input   wire    [63:0]                                                                ptsr_dqsdm_ip, 
  input   wire    [511:0]                                                               ptsr_dqsdq_ip, 
  input   wire    [7:0]                                                                 ptsr_dqsleadck_ip, 
  input   wire    [47:0]                                                                ptsr_gt_ip, 
  input   wire                                                                          ptsr_nt_rank_ip, 
  input   wire    [7:0]                                                                 ptsr_psck_ip, 
  input   wire    [63:0]                                                                ptsr_rdlvldm_ip, 
  input   wire    [511:0]                                                               ptsr_rdlvldq_ip, 
  input   wire                                                                          ptsr_upd, 
  input   wire    [1:0]                                                                 ptsr_vrefcar_ip, 
  input   wire    [11:0]                                                                ptsr_vrefcas_ip, 
  input   wire    [23:0]                                                                ptsr_vrefdqrd_ip, 
  input   wire                                                                          ptsr_vrefdqrdr_ip, 
  input   wire    [1:0]                                                                 ptsr_vrefdqwrr_ip, 
  input   wire    [11:0]                                                                ptsr_vrefdqwrs_ip, 
  input   wire    [63:0]                                                                ptsr_wrlvl_ip, 
  input   wire    [DC_ROUTE_NUM * RCB_BUF_WIDTH - 1:0]                                  rcb_do_bf, 
  input   wire    [1:0]                                                                 reg_dllca_lock, 
  input   wire    [1:0]                                                                 reg_dllca_ovfl, 
  input   wire    [1:0]                                                                 reg_dllca_unfl, 
  input   wire    [3:0]                                                                 reg_dlldq_lock, 
  input   wire    [3:0]                                                                 reg_dlldq_ovfl, 
  input   wire    [3:0]                                                                 reg_dlldq_unfl, 
  input   wire                                                                          reg_pbsr_bist_done, 
  input   wire    [3:0]                                                                 reg_pcsr_nbc, 
  input   wire    [3:0]                                                                 reg_pcsr_pbc, 
  input   wire                                                                          reg_pcsr_srstc, 
  input   wire                                                                          reg_pcsr_updc, 
  input   wire                                                                          reg_pos_clklockc, 
  input   wire                                                                          reg_pos_cmddlyc, 
  input   wire                                                                          reg_pos_dllrstc, 
  input   wire    [1:0]                                                                 reg_pos_dlyevalc, 
  input   wire    [1:0]                                                                 reg_pos_dqsdqc, 
  input   wire                                                                          reg_pos_draminitc, 
  input   wire                                                                          reg_pos_fs0req, 
  input   wire                                                                          reg_pos_fs1req, 
  input   wire    [1:0]                                                                 reg_pos_gtc, 
  input   wire                                                                          reg_pos_ofs, 
  input   wire                                                                          reg_pos_phyfsc, 
  input   wire                                                                          reg_pos_phyinitc, 
  input   wire                                                                          reg_pos_physetc, 
  input   wire    [1:0]                                                                 reg_pos_rdlvlc, 
  input   wire    [1:0]                                                                 reg_pos_sanchkc, 
  input   wire                                                                          reg_pos_vrefcac, 
  input   wire                                                                          reg_pos_vrefdqrdc, 
  input   wire    [1:0]                                                                 reg_pos_vrefdqwrc, 
  input   wire    [1:0]                                                                 reg_pos_wrlvlc, 
  input   wire    [5:0]                                                                 reg_pts_dllerr, 
  input   wire    [7:0]                                                                 reg_pts_dqsdmerr, 
  input   wire    [63:0]                                                                reg_pts_dqsdqerr, 
  input   wire    [7:0]                                                                 reg_pts_gterr, 
  input   wire    [7:0]                                                                 reg_pts_rdlvldmerr, 
  input   wire    [63:0]                                                                reg_pts_rdlvldqerr, 
  input   wire    [7:0]                                                                 reg_pts_sanchkerr, 
  input   wire    [3:0]                                                                 reg_pts_vrefcaerr, 
  input   wire    [7:0]                                                                 reg_pts_vrefdqrderr, 
  input   wire    [7:0]                                                                 reg_pts_vrefdqwrerr, 
  input   wire    [7:0]                                                                 reg_pts_wrlvlerr, 
  input   wire                                                                          reset_n, 
  input   wire    [AXI_PORT_NUM - 1:0]                                                  rready_p, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr11_fs0, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr11_fs1, 
  input   wire    [7:0]                                                                 shad_reg_lpmr11_nt_fs0, 
  input   wire    [7:0]                                                                 shad_reg_lpmr11_nt_fs1, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr12_fs0, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr12_fs1, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr13, 
  input   wire    [7:0]                                                                 shad_reg_lpmr13_nt, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr14_fs0, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr14_fs1, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr1_fs0, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr1_fs1, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr22_fs0, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr22_fs1, 
  input   wire    [7:0]                                                                 shad_reg_lpmr22_nt_fs0, 
  input   wire    [7:0]                                                                 shad_reg_lpmr22_nt_fs1, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr2_fs0, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr2_fs1, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr3_fs0, 
  input   wire    [LPDDR_MR_OPCODE_WIDTH-1:0]                                           shad_reg_lpmr3_fs1, 
  input   wire    [DC_ROUTE_NUM * WCB_BUF_WIDTH - 1:0]                                  wcb_do_bf, 
  input   wire    [AXI_PORT_NUM * AXI4_MASTER_DATA_WIDTH - 1:0]                         wdata_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                                                  wlast_p, 
  input   wire    [AXI_PORT_NUM * AXI4_MASTER_STRB_WIDTH - 1:0]                         wstrb_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                                                  wvalid_p, 
  output  wire    [AXI_PORT_NUM - 1:0]                                                  arready_p, 
  output  wire    [AXI_PORT_NUM - 1:0]                                                  awready_p, 
  output  wire                                                                          axi4lite_arready, 
  output  wire                                                                          axi4lite_awready, 
  output  wire    [AXI4LITE_RESP_WIDTH - 1:0]                                           axi4lite_bresp, 
  output  wire                                                                          axi4lite_bvalid, 
  output  wire    [AXI4LITE_DATA_WIDTH  - 1:0]                                          axi4lite_rdata, 
  output  wire    [AXI4LITE_RESP_WIDTH - 1:0]                                           axi4lite_rresp, 
  output  wire                                                                          axi4lite_rvalid, 
  output  wire                                                                          axi4lite_wready, 
  output  wire    [AXI_PORT_NUM * AXI4_ID_WIDTH - 1:0]                                  bid_p, 
  output  wire    [AXI_PORT_NUM * AXI4_RESP_WIDTH - 1:0]                                bresp_p, 
  output  wire    [AXI_PORT_NUM - 1:0]                                                  bvalid_p, 
  output  wire    [19:0]                                                                calvlpa_pattern_a, 
  output  wire    [19:0]                                                                calvlpa_pattern_b, 
  output  wire    [5:0]                                                                 ddr4_mr6_vrefdq, 
  output  wire                                                                          ddr4_mr6_vrefdqr, 
  output  wire    [DRAM_CHAN_NUM * CMDADDR_BUS*FREQUENCY_RATIO-1:0]                     dfi_act_n, 
  output  wire    [DRAM_CHAN_NUM * CMDADDR_BUS*FREQUENCY_RATIO*DRAM_BA_WIDTH-1:0]       dfi_ba, 
  output  wire    [DRAM_CHAN_NUM * CMDADDR_BUS*FREQUENCY_RATIO*PHY_CA_WIDTH-1:0]        dfi_ca, 
  output  wire    [DRAM_CHAN_NUM * CMDADDR_BUS*FREQUENCY_RATIO*DRAM_LP3_CA_WIDTH -1:0]  dfi_ca_l, 
  output  wire    [DRAM_CHAN_NUM * DIMM_PER_CHAN*FREQUENCY_RATIO*CHAN_RANK_NUM-1:0]     dfi_cke, 
  output  wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO * CHAN_RANK_NUM - 1:0]               dfi_cs_n, 
  output  wire    [1:0]                                                                 dfi_freq_ratio, 
  output  wire    [DRAM_CHAN_NUM * DIMM_PER_CHAN*FREQUENCY_RATIO*DRAM_CTRL_WIDTH-1:0]   dfi_odt, 
  output  wire    [DRAM_CHAN_NUM*FREQUENCY_RATIO - 1:0]                                 dfi_rank, 
  output  wire    [DRAM_CHAN_NUM*FREQUENCY_RATIO*DRAM_RANK_WIDTH-1:0]                   dfi_rank_rd, 
  output  wire    [DRAM_CHAN_NUM*FREQUENCY_RATIO*DRAM_RANK_WIDTH-1:0]                   dfi_rank_wr, 
  output  wire    [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                               dfi_rddata_en, 
  output  wire    [DRAM_CHAN_NUM * AXI4_DATA_WIDTH - 1:0]                               dfi_wrdata, 
  output  wire    [DRAM_CHAN_NUM*FREQUENCY_RATIO - 1:0]                                 dfi_wrdata_en, 
  output  wire    [DRAM_CHAN_NUM * AXI4_DATA_WIDTH/8 - 1:0]                             dfi_wrdata_mask, 
  output  wire                                                                          dmcfg_dqs2cken, 
  output  wire                                                                          dmctl_dual_chan_en, 
  output  wire                                                                          dmctl_dual_rank_en, 
  output  wire                                                                          dqsdqcr_dir, 
  output  wire    [7:0]                                                                 dqsdqcr_dlymax, 
  output  wire    [7:0]                                                                 dqsdqcr_dlyoffs, 
  output  wire    [3:0]                                                                 dqsdqcr_dqsel, 
  output  wire    [2:0]                                                                 dqsdqcr_mpcrpt, 
  output  wire                                                                          dqsdqcr_mupd, 
  output  wire    [1:0]                                                                 dqsdqcr_rank, 
  output  wire    [3:0]                                                                 dti_data_byte_dis, 
  output  wire                                                                          dti_dram_clk_dis, 
  output  wire    [DRAM_CHAN_NUM - 1:0]                                                 int_gc_fsm, 
  output  wire                                                                          lpddr4_lpmr12_fs0_vrefcar, 
  output  wire    [5:0]                                                                 lpddr4_lpmr12_fs0_vrefcas, 
  output  wire                                                                          lpddr4_lpmr12_fs1_vrefcar, 
  output  wire    [5:0]                                                                 lpddr4_lpmr12_fs1_vrefcas, 
  output  wire                                                                          lpddr4_lpmr14_fs0_vrefdqr, 
  output  wire    [5:0]                                                                 lpddr4_lpmr14_fs0_vrefdqs, 
  output  wire                                                                          lpddr4_lpmr14_fs1_vrefdqr, 
  output  wire    [5:0]                                                                 lpddr4_lpmr14_fs1_vrefdqs, 
  output  wire    [1:0]                                                                 outbypen_clk, 
  output  wire    [29:0]                                                                outbypen_ctl, 
  output  wire    [1:0]                                                                 outd_clk, 
  output  wire    [29:0]                                                                outd_ctl, 
  output  wire    [DRAM_CHAN_NUM-1:0]                                                   phyop_en, 
  output  wire                                                                          ptsr_nt_rank, 
  output  wire    [DC_ROUTE_NUM * RCB_BUF_WIDTH - 1:0]                                  rcb_di_bf, 
  output  wire    [DC_ROUTE_NUM * RCB_ADDR_WIDTH - 1:0]                                 rcb_ra_bf, 
  output  wire    [DC_ROUTE_NUM - 1:0]                                                  rcb_re_n_bf, 
  output  wire    [DC_ROUTE_NUM * RCB_ADDR_WIDTH - 1:0]                                 rcb_wa_bf, 
  output  wire    [DC_ROUTE_NUM - 1:0]                                                  rcb_we_n_bf, 
  output  wire    [AXI_PORT_NUM * AXI4_MASTER_DATA_WIDTH - 1:0]                         rdata_p, 
  output  wire    [1:0]                                                                 reg_adft_tst_en_ca, 
  output  wire    [3:0]                                                                 reg_adft_tst_en_dq, 
  output  wire    [1:0]                                                                 reg_cior_cmos_en, 
  output  wire    [5:0]                                                                 reg_cior_drvsel, 
  output  wire    [1:0]                                                                 reg_cior_odis_clk, 
  output  wire    [29:0]                                                                reg_cior_odis_ctl, 
  output  wire                                                                          reg_ddr3_enable, 
  output  wire    [17:0]                                                                reg_ddr3_mr0, 
  output  wire    [17:0]                                                                reg_ddr3_mr1, 
  output  wire    [17:0]                                                                reg_ddr3_mr2, 
  output  wire    [17:0]                                                                reg_ddr3_mr3, 
  output  wire                                                                          reg_ddr4_enable, 
  output  wire    [17:0]                                                                reg_ddr4_mr0, 
  output  wire    [17:0]                                                                reg_ddr4_mr1, 
  output  wire    [17:0]                                                                reg_ddr4_mr2, 
  output  wire    [17:0]                                                                reg_ddr4_mr3, 
  output  wire    [17:0]                                                                reg_ddr4_mr4, 
  output  wire    [17:0]                                                                reg_ddr4_mr5, 
  output  wire    [17:0]                                                                reg_ddr4_mr6, 
  output  wire    [FREQ_RATIO_WIDTH - 1:0]                                              reg_dfi_freq_ratio, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                   reg_dior_cmos_en, 
  output  wire    [PHY_SLICE_NUM*3-1:0]                                                 reg_dior_drvsel, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                   reg_dior_fena_rcv, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                   reg_dior_odis_dm, 
  output  wire    [PHY_SLICE_NUM*8-1:0]                                                 reg_dior_odis_dq, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                   reg_dior_odis_dqs, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                   reg_dior_rtt_en, 
  output  wire    [PHY_SLICE_NUM*3-1:0]                                                 reg_dior_rtt_sel, 
  output  wire    [DRAM_CHAN_NUM-1:0]                                                   reg_dllca_byp, 
  output  wire    [DRAM_CHAN_NUM*DLL_BYPC_WIDTH-1:0]                                    reg_dllca_bypc, 
  output  wire    [DRAM_CHAN_NUM*CLK_DLY_WIDTH - 1:0]                                   reg_dllca_clkdly, 
  output  wire    [DRAM_CHAN_NUM-1:0]                                                   reg_dllca_en, 
  output  wire    [DRAM_CHAN_NUM*DLL_LIM_WIDTH-1:0]                                     reg_dllca_limit, 
  output  wire    [DRAM_CHAN_NUM-1:0]                                                   reg_dllca_upd, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                   reg_dlldq_byp, 
  output  wire    [PHY_SLICE_NUM*DLL_BYPC_WIDTH-1:0]                                    reg_dlldq_bypc, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                   reg_dlldq_en, 
  output  wire    [PHY_SLICE_NUM*DLL_LIM_WIDTH-1:0]                                     reg_dlldq_limit, 
  output  wire    [PHY_SLICE_NUM-1:0]                                                   reg_dlldq_upd, 
  output  wire                                                                          reg_lpddr3_enable, 
  output  wire    [7:0]                                                                 reg_lpddr3_lpmr1, 
  output  wire    [7:0]                                                                 reg_lpddr3_lpmr10, 
  output  wire    [7:0]                                                                 reg_lpddr3_lpmr11, 
  output  wire    [7:0]                                                                 reg_lpddr3_lpmr16, 
  output  wire    [7:0]                                                                 reg_lpddr3_lpmr17, 
  output  wire    [7:0]                                                                 reg_lpddr3_lpmr2, 
  output  wire    [7:0]                                                                 reg_lpddr3_lpmr3, 
  output  wire                                                                          reg_lpddr4_enable, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr11_fs0, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr11_fs1, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr11_nt_fs0, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr11_nt_fs1, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr12_fs0, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr12_fs1, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr13, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr14_fs0, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr14_fs1, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr16, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr1_fs0, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr1_fs1, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr22_fs0, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr22_fs1, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr22_nt_fs0, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr22_nt_fs1, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr2_fs0, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr2_fs1, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr3_fs0, 
  output  wire    [7:0]                                                                 reg_lpddr4_lpmr3_fs1, 
  output  wire    [3:0]                                                                 reg_outbypen_dm, 
  output  wire    [31:0]                                                                reg_outbypen_dq, 
  output  wire    [3:0]                                                                 reg_outbypen_dqs, 
  output  wire    [3:0]                                                                 reg_outd_dm, 
  output  wire    [31:0]                                                                reg_outd_dq, 
  output  wire    [3:0]                                                                 reg_outd_dqs, 
  output  wire                                                                          reg_pbcr_bist_en, 
  output  wire                                                                          reg_pbcr_bist_start, 
  output  wire                                                                          reg_pbcr_lp_en, 
  output  wire    [1:0]                                                                 reg_pbcr_vrefenca, 
  output  wire    [11:0]                                                                reg_pbcr_vrefsetca, 
  output  wire    [3:0]                                                                 reg_pccr_byp_n, 
  output  wire    [3:0]                                                                 reg_pccr_byp_p, 
  output  wire                                                                          reg_pccr_bypen, 
  output  wire                                                                          reg_pccr_en, 
  output  wire    [10:0]                                                                reg_pccr_initcnt, 
  output  wire                                                                          reg_pccr_mvg, 
  output  wire                                                                          reg_pccr_srst, 
  output  wire                                                                          reg_pccr_tpaden, 
  output  wire                                                                          reg_pccr_upd, 
  output  wire    [DRAM_CHAN_NUM  - 1:0]                                                reg_pom_chanen, 
  output  wire                                                                          reg_pom_clklocken, 
  output  wire                                                                          reg_pom_cmddlyen, 
  output  wire    [2:0]                                                                 reg_pom_ddrt, 
  output  wire                                                                          reg_pom_dfien, 
  output  wire                                                                          reg_pom_dllrsten, 
  output  wire                                                                          reg_pom_dlyevalen, 
  output  wire                                                                          reg_pom_dqsdqen, 
  output  wire                                                                          reg_pom_draminiten, 
  output  wire                                                                          reg_pom_fs, 
  output  wire                                                                          reg_pom_gten, 
  output  wire                                                                          reg_pom_odt, 
  output  wire                                                                          reg_pom_phyfsen, 
  output  wire                                                                          reg_pom_phyinit, 
  output  wire                                                                          reg_pom_physeten, 
  output  wire                                                                          reg_pom_proc, 
  output  wire    [CHAN_RANK_NUM - 1:0]                                                 reg_pom_ranken, 
  output  wire                                                                          reg_pom_rdlvlen, 
  output  wire                                                                          reg_pom_sanchken, 
  output  wire                                                                          reg_pom_vrefcaen, 
  output  wire                                                                          reg_pom_vrefdqrden, 
  output  wire                                                                          reg_pom_vrefdqwren, 
  output  wire                                                                          reg_pom_wrlvlen, 
  output  wire    [3:0]                                                                 reg_ptar_ba, 
  output  wire    [10:0]                                                                reg_ptar_col, 
  output  wire    [16:0]                                                                reg_ptar_row, 
  output  wire    [27:0]                                                                reg_ptsr_actn, 
  output  wire    [111:0]                                                               reg_ptsr_ba, 
  output  wire    [531:0]                                                               reg_ptsr_ca, 
  output  wire    [27:0]                                                                reg_ptsr_cke, 
  output  wire    [27:0]                                                                reg_ptsr_cs, 
  output  wire    [63:0]                                                                reg_ptsr_dqsdm, 
  output  wire    [511:0]                                                               reg_ptsr_dqsdq, 
  output  wire    [7:0]                                                                 reg_ptsr_dqsleadck, 
  output  wire    [47:0]                                                                reg_ptsr_gt, 
  output  wire    [13:0]                                                                reg_ptsr_odt, 
  output  wire    [7:0]                                                                 reg_ptsr_psck, 
  output  wire    [63:0]                                                                reg_ptsr_rdlvldm, 
  output  wire    [511:0]                                                               reg_ptsr_rdlvldq, 
  output  wire    [13:0]                                                                reg_ptsr_rstn, 
  output  wire    [15:0]                                                                reg_ptsr_sanpat, 
  output  wire    [1:0]                                                                 reg_ptsr_vrefcar, 
  output  wire    [11:0]                                                                reg_ptsr_vrefcas, 
  output  wire    [23:0]                                                                reg_ptsr_vrefdqrd, 
  output  wire                                                                          reg_ptsr_vrefdqrdr, 
  output  wire    [1:0]                                                                 reg_ptsr_vrefdqwrr, 
  output  wire    [11:0]                                                                reg_ptsr_vrefdqwrs, 
  output  wire    [63:0]                                                                reg_ptsr_wrlvl, 
  output  wire                                                                          reg_rd_dbi, 
  output  wire    [5:0]                                                                 reg_rtgc_fs0_trden, 
  output  wire    [6:0]                                                                 reg_rtgc_fs0_trdendbi, 
  output  wire    [5:0]                                                                 reg_rtgc_fs0_twren, 
  output  wire    [5:0]                                                                 reg_rtgc_fs1_trden, 
  output  wire    [6:0]                                                                 reg_rtgc_fs1_trdendbi, 
  output  wire    [5:0]                                                                 reg_rtgc_fs1_twren, 
  output  wire                                                                          reg_rtgc_gt_dis, 
  output  wire                                                                          reg_rtgc_gt_updt, 
  output  wire    [21:0]                                                                reg_t_caent, 
  output  wire    [21:0]                                                                reg_t_caent_rb, 
  output  wire    [7:0]                                                                 reg_t_calvl_adr_ckeh_rb, 
  output  wire    [7:0]                                                                 reg_t_calvl_capture_rb, 
  output  wire    [7:0]                                                                 reg_t_calvl_cc_rb, 
  output  wire    [7:0]                                                                 reg_t_calvl_en_rb, 
  output  wire    [7:0]                                                                 reg_t_calvl_ext_rb, 
  output  wire    [7:0]                                                                 reg_t_calvl_max_rb, 
  output  wire    [7:0]                                                                 reg_t_ccd_s_rb, 
  output  wire    [7:0]                                                                 reg_t_ckckeh, 
  output  wire    [7:0]                                                                 reg_t_ckehdqs, 
  output  wire    [7:0]                                                                 reg_t_ckelck, 
  output  wire    [7:0]                                                                 reg_t_ckfspe, 
  output  wire    [7:0]                                                                 reg_t_ckfspx, 
  output  wire    [7:0]                                                                 reg_t_dllen, 
  output  wire    [21:0]                                                                reg_t_dlllock, 
  output  wire    [7:0]                                                                 reg_t_dllrst, 
  output  wire    [4:0]                                                                 reg_t_dqrpt, 
  output  wire    [7:0]                                                                 reg_t_dqscke, 
  output  wire    [7:0]                                                                 reg_t_dtrain, 
  output  wire    [21:0]                                                                reg_t_fc, 
  output  wire    [21:0]                                                                reg_t_init1, 
  output  wire    [21:0]                                                                reg_t_init3, 
  output  wire    [21:0]                                                                reg_t_init5, 
  output  wire    [7:0]                                                                 reg_t_lvlaa, 
  output  wire    [7:0]                                                                 reg_t_lvldis, 
  output  wire    [7:0]                                                                 reg_t_lvldll, 
  output  wire    [7:0]                                                                 reg_t_lvlexit, 
  output  wire    [7:0]                                                                 reg_t_lvlload, 
  output  wire    [7:0]                                                                 reg_t_lvlresp, 
  output  wire    [7:0]                                                                 reg_t_lvlresp_nr, 
  output  wire    [7:0]                                                                 reg_t_mod, 
  output  wire    [7:0]                                                                 reg_t_mpcwr, 
  output  wire    [7:0]                                                                 reg_t_mpcwr2rd, 
  output  wire    [7:0]                                                                 reg_t_mrd, 
  output  wire    [7:0]                                                                 reg_t_mrr, 
  output  wire    [7:0]                                                                 reg_t_mrs2act, 
  output  wire    [7:0]                                                                 reg_t_mrs2lvlen, 
  output  wire    [7:0]                                                                 reg_t_mrw, 
  output  wire    [7:0]                                                                 reg_t_odth4, 
  output  wire    [7:0]                                                                 reg_t_odth8, 
  output  wire    [7:0]                                                                 reg_t_odtup, 
  output  wire    [6:0]                                                                 reg_t_osco, 
  output  wire    [21:0]                                                                reg_t_pori, 
  output  wire    [7:0]                                                                 reg_t_rcd, 
  output  wire    [7:0]                                                                 reg_t_rp, 
  output  wire    [21:0]                                                                reg_t_rst, 
  output  wire    [7:0]                                                                 reg_t_vrcgdis, 
  output  wire    [21:0]                                                                reg_t_vrcgen, 
  output  wire    [21:0]                                                                reg_t_vreftimelong, 
  output  wire    [7:0]                                                                 reg_t_vreftimeshort, 
  output  wire    [21:0]                                                                reg_t_xpr, 
  output  wire    [21:0]                                                                reg_t_zqcal, 
  output  wire    [21:0]                                                                reg_t_zqinit, 
  output  wire    [7:0]                                                                 reg_t_zqlat, 
  output  wire                                                                          reg_vtgc_ivrefen, 
  output  wire                                                                          reg_vtgc_ivrefr, 
  output  wire    [7:0]                                                                 reg_vtgc_ivrefts, 
  output  wire    [5:0]                                                                 reg_vtgc_vrefcasw, 
  output  wire    [5:0]                                                                 reg_vtgc_vrefdqsw, 
  output  wire    [AXI_PORT_NUM * AXI4_ID_WIDTH - 1:0]                                  rid_p, 
  output  wire    [AXI_PORT_NUM - 1:0]                                                  rlast_p, 
  output  wire    [AXI_PORT_NUM * AXI4_RESP_WIDTH - 1:0]                                rresp_p, 
  output  wire    [AXI_PORT_NUM - 1:0]                                                  rvalid_p, 
  output  wire    [DC_ROUTE_NUM * WCB_BUF_WIDTH - 1:0]                                  wcb_di_bf, 
  output  wire    [DC_ROUTE_NUM * WCB_ADDR_WIDTH - 1:0]                                 wcb_ra_bf, 
  output  wire    [DC_ROUTE_NUM - 1:0]                                                  wcb_re_n_bf, 
  output  wire    [DC_ROUTE_NUM * WCB_ADDR_WIDTH - 1:0]                                 wcb_wa_bf, 
  output  wire    [DC_ROUTE_NUM - 1:0]                                                  wcb_we_n_bf, 
  output  wire    [AXI_PORT_NUM - 1:0]                                                  wready_p
);

`include "dti_global_params.vh"
// Internal Declarations


// Local declarations

// Internal signal declarations
wire  [DC_ROUTE_NUM * AXI4_ADDR_WIDTH - 1:0]                         araddr_rt;
wire  [DC_ROUTE_NUM * AXI4_BURST_WIDTH - 1:0]                        arburst_rt;
wire  [DC_ROUTE_NUM * AXI4_CACHE_WIDTH - 1:0]                        arcache_rt;
wire  [DC_ROUTE_NUM * AXI4_ID_WIDTH - 1:0]                           arid_rt;
wire  [DC_ROUTE_NUM * AXI4_LEN_WIDTH - 1:0]                          arlen_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           arlock_rt;
wire  [DC_ROUTE_NUM * AXI4_PROT_WIDTH - 1:0]                         arprot_rt;
wire  [DC_ROUTE_NUM * AXI4_QOS_WIDTH - 1:0]                          arqos_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           arready_rt;
wire  [DC_ROUTE_NUM * AXI4_SIZE_WIDTH - 1:0]                         arsize_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           arvalid_rt;
wire  [DC_ROUTE_NUM * AXI4_ADDR_WIDTH - 1:0]                         awaddr_rt;
wire  [DC_ROUTE_NUM * AXI4_BURST_WIDTH - 1:0]                        awburst_rt;
wire  [DC_ROUTE_NUM * AXI4_CACHE_WIDTH - 1:0]                        awcache_rt;
wire  [DC_ROUTE_NUM * AXI4_ID_WIDTH - 1:0]                           awid_rt;
wire  [DC_ROUTE_NUM * AXI4_LEN_WIDTH - 1:0]                          awlen_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           awlock_rt;
wire  [DC_ROUTE_NUM * AXI4_PROT_WIDTH - 1:0]                         awprot_rt;
wire  [DC_ROUTE_NUM * AXI4_QOS_WIDTH - 1:0]                          awqos_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           awready_rt;
wire  [DC_ROUTE_NUM * AXI4_SIZE_WIDTH - 1:0]                         awsize_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           awvalid_rt;
wire  [AXI4LITE_ADDR_WIDTH - 1:0]                                    axi4lite_araddr_rb;
wire                                                                 axi4lite_arready_rb;
wire                                                                 axi4lite_arvalid_rb;
wire  [AXI4LITE_ADDR_WIDTH - 1:0]                                    axi4lite_awaddr_rb;
wire                                                                 axi4lite_awready_rb;
wire                                                                 axi4lite_awvalid_rb;
wire                                                                 axi4lite_bready_rb;
wire  [AXI4LITE_RESP_WIDTH - 1:0]                                    axi4lite_bresp_rb;
wire                                                                 axi4lite_bvalid_rb;
wire  [AXI4LITE_DATA_WIDTH  - 1:0]                                   axi4lite_rdata_rb;
wire                                                                 axi4lite_rready_rb;
wire  [AXI4LITE_RESP_WIDTH - 1:0]                                    axi4lite_rresp_rb;
wire                                                                 axi4lite_rvalid_rb;
wire  [AXI4LITE_DATA_WIDTH - 1:0]                                    axi4lite_wdata_rb;
wire                                                                 axi4lite_wready_rb;
wire                                                                 axi4lite_wvalid_rb;
wire  [DRAM_CHAN_NUM*CHAN_RANK_NUM - 1:0]                            bank_ready_atomic_mrr;
wire  [DRAM_CHAN_NUM*CHAN_RANK_NUM-1:0]                              bank_ready_atomic_xq;
wire  [DRAM_CHAN_NUM - 1:0]                                          bank_ready_enable_ch;
wire  [DC_ROUTE_NUM * AXI4_ID_WIDTH - 1:0]                           bid_rt;
wire  [DRAM_CHAN_NUM-1:0]                                            bist_complete;
wire  [DRAM_CHAN_NUM-1:0]                                            bist_enable;
wire  [DC_ROUTE_NUM - 1:0]                                           bready_rt;
wire  [DC_ROUTE_NUM * AXI4_RESP_WIDTH - 1:0]                         bresp_rt;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM - 1:0]                          brif_bank_occp_b;
wire  [DRAM_CHAN_NUM*DRAM_BANK_NUM - 1:0]                            brif_bank_occp_bist;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM - 1:0]                          brif_bank_occp_pc;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM * DRAM_BANK_STATUS_WIDTH - 1:0] brif_bank_status_b;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM * ACR_CAS_INFO_WIDTH - 1:0]     brif_cas_info_b;
wire  [DRAM_CHAN_NUM*DRAM_BANK_NUM*ACR_CAS_INFO_WIDTH-1:0]           brif_cas_info_bist;
wire  [DRAM_CHAN_NUM*DRAM_BANK_NUM*ACR_CAS_INFO_WIDTH-1:0]           brif_cas_info_pc;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM - 1:0]                          brif_cas_rd_b;
wire  [DRAM_CHAN_NUM*DRAM_BANK_NUM-1:0]                              brif_cas_rd_bist;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM-1:0]                            brif_cas_rd_pc;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM - 1:0]                          brif_cas_ready_b;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM - 1:0]                          brif_cas_valid_b;
wire  [DRAM_CHAN_NUM*DRAM_BANK_NUM-1:0]                              brif_cas_valid_bist;
wire  [DRAM_CHAN_NUM*DRAM_BANK_NUM-1:0]                              brif_cas_valid_pc;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM - 1:0]                          brif_page_close_b;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM - 1:0]                          brif_page_keep_b;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM - 1:0]                          brif_pre_ready_b;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM - 1:0]                          brif_pre_valid_b;
wire  [DRAM_CHAN_NUM*DRAM_BANK_NUM-1:0]                              brif_pre_valid_bist;
wire  [DRAM_CHAN_NUM*DRAM_BANK_NUM-1:0]                              brif_pre_valid_pc;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM * BRIF_PRI_WIDTH - 1:0]         brif_pri_b;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM * DRAM_RANK_WIDTH - 1:0]        brif_rank_addr_b;
wire  [DRAM_CHAN_NUM*DRAM_BG_NUM*DRAM_BANK_NUM*DRAM_RANK_WIDTH-1:0]  brif_rank_addr_bist;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM * DRAM_RANK_WIDTH - 1:0]        brif_rank_addr_pc;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM - 1:0]                          brif_ras_last_b;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM - 1:0]                          brif_ras_ready_b;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM - 1:0]                          brif_ras_valid_b;
wire  [DRAM_CHAN_NUM*DRAM_BANK_NUM-1:0]                              brif_ras_valid_bist;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM - 1:0]                          brif_ras_valid_pc;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM * DRAM_ROW_WIDTH - 1:0]         brif_row_addr_b;
wire  [DRAM_CHAN_NUM*DRAM_BANK_NUM*DRAM_ROW_WIDTH-1:0]               brif_row_addr_bist;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM * DRAM_ROW_WIDTH - 1:0]         brif_row_addr_pc;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM * BRIF_TAGID_WIDTH - 1:0]       brif_tagid_b;
wire  [DC_ROUTE_NUM - 1:0]                                           bvalid_rt;
wire  [DRAM_CHAN_NUM-1:0]                                            cmden_reg_ucr;
wire  [DRAM_CHAN_NUM*USER_CMDOP_WIDTH-1:0]                           cmdop_reg_ucr;
wire  [2*RCB_DATA_WIDTH-1:0]                                         data_rddata;
wire                                                                 ddr4_mr2_wrcrc;
wire  [DRAM_CHAN_NUM * CHAN_LAT_WIDTH - 1:0]                         dfi_rdlat_ch                   = 0;
wire  [DRAM_CHAN_NUM - 1:0]                                          dfi_rdlat_update               = 0;
wire  [DRAM_CHAN_NUM * DRAM_ADDR_WIDTH - 1:0]                        dram_addr;
wire  [DRAM_CHAN_NUM * DRAM_BA_WIDTH - 1:0]                          dram_bank;
wire  [DRAM_CHAN_NUM * DRAM_BG_WIDTH - 1:0]                          dram_bg;
wire  [1:0]                                                          dram_chan_en;
wire  [DRAM_CHAN_NUM*CHAN_RANK_NUM-1:0]                              dram_cke;
wire  [DRAM_CHAN_NUM * MC_CMD_WIDTH - 1:0]                           dram_cmd;
wire  [DRAM_CHAN_NUM-1:0]                                            dram_cmd_mrr;
wire  [DRAM_CHAN_NUM-1:0]                                            dram_cmd_rd;
wire  [DRAM_CHAN_NUM - 1:0]                                          dram_cmd_rdy;
wire  [DRAM_CHAN_NUM-1:0]                                            dram_cmd_wr;
wire  [DRAM_CHAN_NUM*CHAN_RANK_NUM-1:0]                              dram_cs_n;
wire  [DRAM_CHAN_NUM*RCB_DATA_WIDTH/8-1:0]                           dram_dmi;
wire  [DRAM_CHAN_NUM - 1:0]                                          dram_odt;
wire  [DRAM_CHAN_NUM*DRAM_RANK_WIDTH-1:0]                            dram_rank_addr_rd;
wire  [DRAM_CHAN_NUM*DRAM_RANK_WIDTH-1:0]                            dram_rank_addr_wr;
wire  [1:0]                                                          dram_rank_en;
wire  [DRAM_CHAN_NUM * RCB_DATA_WIDTH - 1:0]                         dram_rdata;
wire  [RCB_DATA_WIDTH-1:0]                                           dram_rdata_ch0;
wire  [RCB_DATA_WIDTH-1:0]                                           dram_rdata_ch1;
wire  [DRAM_CHAN_NUM - 1:0]                                          dram_rdata_err_ded_ch;
wire  [DRAM_CHAN_NUM - 1:0]                                          dram_rdata_err_sec_ch;
wire  [DRAM_CHAN_NUM - 1:0]                                          dram_rvalid;
wire  [DRAM_CHAN_NUM - 1:0]                                          dram_rvalid_int;
wire  [DRAM_CHAN_NUM * WCB_DATA_WIDTH - 1:0]                         dram_wdata;
wire  [DRAM_CHAN_NUM*WCB_DATA_WIDTH-1:0]                             dram_wdata_bist;
wire  [DRAM_CHAN_NUM * WCB_DATA_WIDTH - 1:0]                         dram_wdata_pc;
wire  [DRAM_CHAN_NUM * WCB_STRB_WIDTH - 1:0]                         dram_wstrb;
wire  [DRAM_CHAN_NUM*WCB_STRB_WIDTH-1:0]                             dram_wstrb_bist;
wire  [DRAM_CHAN_NUM*WCB_STRB_WIDTH-1:0]                             dram_wstrb_pc;
wire  [DRAM_CHAN_NUM - 1:0]                                          int_gc_fsm_rb;
wire  [DRAM_CHAN_NUM-1:0]                                            keep_dfien;
wire                                                                 mpr_access_done_ch0;
wire  [DRAM_CHAN_NUM-1:0]                                            mpr_access_done_pc;
wire                                                                 mpr_access_enable_ch0;
wire  [DRAM_CHAN_NUM-1:0]                                            mpr_access_enable_pc;
wire                                                                 mpr_rd_n_wr_ch0;
wire  [DRAM_CHAN_NUM-1:0]                                            mpr_rd_n_wr_pc;
wire  [7:0]                                                          mpr_readout_ch0;
wire  [8*DRAM_CHAN_NUM-1:0]                                          mpr_readout_pc;
wire  [DRAM_CHAN_NUM-1:0]                                            mprw_mode_on;
wire  [DRAM_CHAN_NUM-1:0]                                            mrr_done_ch;
wire  [DRAM_CHAN_NUM-1:0]                                            mrr_enable_ch;
wire  [DRAM_CHAN_NUM*MRR_DATA_WIDTH-1:0]                             mrr_readout_ch;
wire  [DC_ROUTE_NUM*NROW_PTR_WIDTH-1:0]                              nrow_alloc_ptr_rt;
wire  [DC_ROUTE_NUM*NROW_PTR_WIDTH-1:0]                              nrow_alloc_tag_rt;
wire  [DRAM_CHAN_NUM-1:0]                                            rank_hold_ext;
wire  [DC_ROUTE_NUM * RCB_PTR_WIDTH   - 1:0]                         rc_alloc_ptr_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           rc_read_enable_rt;
wire  [DC_ROUTE_NUM * RCB_ADDR_WIDTH - 1:0]                          rc_read_ptr_rt;
wire  [DC_ROUTE_NUM * DRAM_CHAN_NUM - 1:0]                           rc_write_channel_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           rc_write_enable_rt;
wire  [DC_ROUTE_NUM * RCB_ADDR_WIDTH - 1:0]                          rc_write_ptr_rt;
wire  [DC_ROUTE_NUM*RCB_BUF_WIDTH/8-1:0]                             rdata_dmi_rt;
wire  [DC_ROUTE_NUM * RCB_DATA_WIDTH - 1:0]                          rdata_rt;
reg   [2*RCB_DATA_WIDTH-1:0]                                         rddata_store;
wire                                                                 rddata_upd;
wire  [DC_ROUTE_NUM - 1:0]                                           reg_acq_realtime_enable_rt;
wire  [ADDR_CONFIG_WIDTH - 1:0]                                      reg_addr_cfg;
wire  [DC_ROUTE_NUM-1:0]                                             reg_arq_lahead_en_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           reg_arq_lat_barrier_enable_rt;
wire  [DC_ROUTE_NUM * CHAN_LAT_BARRIER_WIDTH - 1:0]                  reg_arq_lat_barrier_rt;
wire  [DC_ROUTE_NUM * ACQ_PTR_WIDTH - 1:0]                           reg_arq_lvl_hi_rt;
wire  [DC_ROUTE_NUM * ACQ_PTR_WIDTH - 1:0]                           reg_arq_lvl_lo_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           reg_arq_ooo_enable_rt;
wire  [DC_ROUTE_NUM * ACQ_STARV_WIDTH - 1:0]                         reg_arq_starvation_th_rt;
wire                                                                 reg_auto_srx_zqcl_mc;
wire                                                                 reg_auto_srx_zqcl_rb;
wire  [DC_ROUTE_NUM-1:0]                                             reg_awq_lahead_en_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           reg_awq_lat_barrier_enable_rt;
wire  [DC_ROUTE_NUM * CHAN_LAT_BARRIER_WIDTH - 1:0]                  reg_awq_lat_barrier_rt;
wire  [DC_ROUTE_NUM * ACQ_PTR_WIDTH - 1:0]                           reg_awq_lvl_hi_rt;
wire  [DC_ROUTE_NUM * ACQ_PTR_WIDTH - 1:0]                           reg_awq_lvl_lo_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           reg_awq_ooo_enable_rt;
wire  [DC_ROUTE_NUM * ACQ_STARV_WIDTH - 1:0]                         reg_awq_starvation_th_rt;
wire                                                                 reg_bank_policy;
wire  [DRAM_CHAN_NUM-1:0]                                            reg_bist_diagnosis_en_ch;
wire  [DRAM_CHAN_NUM*4-1:0]                                          reg_bist_element_ch;
wire  [DRAM_CHAN_NUM*3-1:0]                                          reg_bist_end_background_ch;
wire  [DRAM_CHAN_NUM*DRAM_BA_WIDTH-1:0]                              reg_bist_end_bank_ch;
wire  [DRAM_CHAN_NUM*DRAM_COL_WIDTH-1:0]                             reg_bist_end_col_ch;
wire  [DRAM_CHAN_NUM*DRAM_RANK_WIDTH-1:0]                            reg_bist_end_rank_ch;
wire  [DRAM_CHAN_NUM*DRAM_ROW_WIDTH-1:0]                             reg_bist_end_row_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_0_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_10_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_11_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_12_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_13_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_14_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_15_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_1_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_2_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_3_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_4_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_5_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_6_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_7_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_8_ch;
wire  [DRAM_CHAN_NUM*32-1:0]                                         reg_bist_march_element_9_ch;
wire  [DRAM_CHAN_NUM*4-1:0]                                          reg_bist_operation_ch;
wire  [DRAM_CHAN_NUM*4-1:0]                                          reg_bist_retention_ch;
wire  [DRAM_CHAN_NUM*3-1:0]                                          reg_bist_start_background_ch;
wire  [DRAM_CHAN_NUM*DRAM_BA_WIDTH-1:0]                              reg_bist_start_bank_ch;
wire  [DRAM_CHAN_NUM*DRAM_COL_WIDTH-1:0]                             reg_bist_start_col_ch;
wire  [DRAM_CHAN_NUM*DRAM_RANK_WIDTH-1:0]                            reg_bist_start_rank_ch;
wire  [DRAM_CHAN_NUM*DRAM_ROW_WIDTH-1:0]                             reg_bist_start_row_ch;
wire                                                                 reg_chan_unlock;
wire  [2:0]                                                          reg_ddr4_mr4_cal;
wire                                                                 reg_ddr4_mr4_rdpre;
wire                                                                 reg_ddr4_mr4_wrpre;
wire  [XQ_T_CAL_WIDTH-1:0]                                           reg_ddr_mr4_t_cal;
wire                                                                 reg_ddr_ref_otf;
wire  [2:0]                                                          reg_dram_bank_enable;
wire  [DRAM_BL_ENC_WIDTH - 1:0]                                      reg_dram_bl_enc;
wire  [AXI4_ADDR_WIDTH-1:0]                                          reg_ecc_base;
wire  [DC_ROUTE_NUM - 1:0]                                           reg_ext_priority_rt;
wire                                                                 reg_hi_pri_imm;
wire                                                                 reg_inline_ecc_en;
wire  [DC_ROUTE_NUM - 1:0]                                           reg_max_priority_rt;
wire  [7:0]                                                          reg_mpr_wrdata;
wire  [AXI_PORT_NUM - 1:0]                                           reg_narrow_mode_rt;
wire  [AXI_PORT_NUM * AXI4_SIZE_WIDTH - 1:0]                         reg_narrow_size_rt;
wire                                                                 reg_phy_init_done;
reg                                                                  reg_pom_dfien_cld;
wire                                                                 reg_pom_dfien_pc;
wire                                                                 reg_pom_dfien_rb;
wire                                                                 reg_post_pull_en;
wire  [AXI4_ADDR_WIDTH-1:0]                                          reg_prot_mem_base;
wire  [AXI4_ADDR_WIDTH-1:0]                                          reg_prot_mem_size;
wire                                                                 reg_rd_dbi_dfi;
wire  [6:0]                                                          reg_rd_req_min;
wire  [7:0]                                                          reg_rd_req_min_rb;
wire                                                                 reg_ref_int_en;
wire  [ACR_REQ_THRESHOLD - 1:0]                                      reg_req_threshold;
wire  [AXI_PORT_NUM * AXI4_SIZE_WIDTH - 1:0]                         reg_size_max_rt;
wire                                                                 reg_switch_close;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_alrtp_mc;
wire  [7:0]                                                          reg_t_alrtp_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_ccd_l_mc;
wire  [7:0]                                                          reg_t_ccd_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_ccd_s_mc;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_ccdwm_mc;
wire  [7:0]                                                          reg_t_ccdwm_rb;
wire  [7:0]                                                          reg_t_ckckeh_rb;
wire  [7:0]                                                          reg_t_ckehdqs_rb;
wire  [7:0]                                                          reg_t_ckelck_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_ckesr_mc;
wire  [7:0]                                                          reg_t_ckesr_rb;
wire  [7:0]                                                          reg_t_ckfspe_rb;
wire  [7:0]                                                          reg_t_ckfspx_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_cmdcke_mc;
wire  [7:0]                                                          reg_t_cmdcke_rb;
wire  [7:0]                                                          reg_t_dllen_rb;
wire  [MC_W_COUNTER_WIDTH-1:0]                                       reg_t_dllk_mc;
wire  [19:0]                                                         reg_t_dllk_rb;
wire  [21:0]                                                         reg_t_dlllock_rb;
wire  [7:0]                                                          reg_t_dllrst_rb;
wire  [MC_SW_COUNTER_WIDTH - 1:0]                                    reg_t_dpd_mc;
wire  [19:0]                                                         reg_t_dpd_rb;
wire  [7:0]                                                          reg_t_dqrpt_rb;
wire  [7:0]                                                          reg_t_dqscke_rb;
wire  [7:0]                                                          reg_t_dtrain_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_faw_mc;
wire  [7:0]                                                          reg_t_faw_rb;
wire  [13:0]                                                         reg_t_fc_rb;
wire  [13:0]                                                         reg_t_init1_rb;
wire  [19:0]                                                         reg_t_init3_rb;
wire  [21:0]                                                         reg_t_init5_rb;
wire  [7:0]                                                          reg_t_lvlaa_rb;
wire  [7:0]                                                          reg_t_lvldis_rb;
wire  [7:0]                                                          reg_t_lvldll_rb;
wire  [7:0]                                                          reg_t_lvlexit_rb;
wire  [7:0]                                                          reg_t_lvlload_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_lvlresp_mc;
wire  [7:0]                                                          reg_t_lvlresp_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_mod_mc;
wire  [7:0]                                                          reg_t_mod_rb;
wire  [7:0]                                                          reg_t_mpcwr2rd_rb;
wire  [7:0]                                                          reg_t_mpcwr_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_mped_mc;
wire  [7:0]                                                          reg_t_mped_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_mprr_mc;
wire  [7:0]                                                          reg_t_mprr_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_mpx_mc;
wire  [7:0]                                                          reg_t_mpx_rb;
wire  [7:0]                                                          reg_t_mrd_rb;
wire  [7:0]                                                          reg_t_mrr_rb;
wire  [7:0]                                                          reg_t_mrs2act_rb;
wire  [19:0]                                                         reg_t_mrs2lvlen_rb;
wire  [7:0]                                                          reg_t_mrw_rb;
wire  [ODT_COUNT_WIDTH - 1:0]                                        reg_t_odth4_mc;
wire  [7:0]                                                          reg_t_odth4_rb;
wire  [ODT_COUNT_WIDTH - 1:0]                                        reg_t_odth8_mc;
wire  [7:0]                                                          reg_t_odth8_rb;
wire  [7:0]                                                          reg_t_odtup_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_osco_mc;
wire  [7:0]                                                          reg_t_osco_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_pd_mc;
wire  [7:0]                                                          reg_t_pd_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_phy_rdlat_mc;
wire  [19:0]                                                         reg_t_pori_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_ppd_mc;
wire  [7:0]                                                          reg_t_ppd_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_ras_mc;
wire  [7:0]                                                          reg_t_ras_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_rc_mc;
wire  [7:0]                                                          reg_t_rc_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_rcd_mc;
wire  [7:0]                                                          reg_t_rcd_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_rddata_en_mc;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_rdpden_mc;
wire  [7:0]                                                          reg_t_rdpden_rb;
wire  [9:0]                                                          reg_t_read_high_rb;
wire  [9:0]                                                          reg_t_read_low_rb;
wire  [MC_W_COUNTER_WIDTH - 1:0]                                     reg_t_refi_mc;
wire  [19:0]                                                         reg_t_refi_off_rb;
wire  [13:0]                                                         reg_t_refi_rb;
wire  [MC_W_COUNTER_WIDTH - 1:0]                                     reg_t_rfc_mc;
wire  [13:0]                                                         reg_t_rfc_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_rp_mc;
wire  [7:0]                                                          reg_t_rp_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_rrd_l_mc;
wire  [7:0]                                                          reg_t_rrd_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_rrd_s_mc;
wire  [7:0]                                                          reg_t_rrd_s_rb;
wire  [19:0]                                                         reg_t_rst_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_rtw_mc;
wire  [7:0]                                                          reg_t_rtw_rb;
wire  [7:0]                                                          reg_t_vrcgdis_rb;
wire  [13:0]                                                         reg_t_vrcgen_rb;
wire  [13:0]                                                         reg_t_vreftimelong_rb;
wire  [7:0]                                                          reg_t_vreftimeshort_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_wlbr_mc;
wire  [7:0]                                                          reg_t_wlbr_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_wlbtr_mc;
wire  [7:0]                                                          reg_t_wlbtr_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_wr_mpr_mc;
wire  [7:0]                                                          reg_t_wr_mpr_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_wrapden_mc;
wire  [7:0]                                                          reg_t_wrapden_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_wrdata_en_mc;
wire  [9:0]                                                          reg_t_write_high_rb;
wire  [9:0]                                                          reg_t_write_low_rb;
wire  [MC_W_COUNTER_WIDTH-1:0]                                       reg_t_xmpdll_mc;
wire  [13:0]                                                         reg_t_xmpdll_rb;
wire  [MC_COUNTER_WIDTH - 1:0]                                       reg_t_xp_mc;
wire  [7:0]                                                          reg_t_xp_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_xpdll_mc;
wire  [7:0]                                                          reg_t_xpdll_rb;
wire  [19:0]                                                         reg_t_xpr_rb;
wire  [MC_W_COUNTER_WIDTH-1:0]                                       reg_t_xs_mc;
wire  [13:0]                                                         reg_t_xs_rb;
wire  [MC_W_COUNTER_WIDTH-1:0]                                       reg_t_xsr_mc;
wire  [13:0]                                                         reg_t_xsr_rb;
wire  [27:0]                                                         reg_t_zq_itv_rb;
wire  [MC_W_COUNTER_WIDTH - 1:0]                                     reg_t_zqcal_mc;
wire  [19:0]                                                         reg_t_zqcal_rb;
wire  [MC_W_COUNTER_WIDTH-1:0]                                       reg_t_zqcl_mc;
wire  [13:0]                                                         reg_t_zqcl_rb;
wire  [MC_ZQ_COUNTER_WIDTH-1:0]                                      reg_t_zqcs_itv_mc;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_zqcs_mc;
wire  [7:0]                                                          reg_t_zqcs_rb;
wire  [19:0]                                                         reg_t_zqinit_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_zqlat_mc;
wire  [7:0]                                                          reg_t_zqlat_rb;
wire  [MC_COUNTER_WIDTH-1:0]                                         reg_t_zqrs_mc;
wire  [7:0]                                                          reg_t_zqrs_rb;
wire  [DC_ROUTE_NUM-1:0]                                             reg_wm_enable_rt;
wire                                                                 reg_wr_crc;
wire                                                                 reg_wr_crc_dfi;
wire                                                                 reg_wr_dbi;
wire                                                                 reg_wr_dbi_dfi;
wire  [7:0]                                                          reg_wr_req_min;
wire                                                                 reg_zq_auto_en;
wire  [DC_ROUTE_NUM * AXI4_ID_WIDTH - 1:0]                           rid_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           rlast_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           rready_rt;
wire  [DC_ROUTE_NUM * AXI4_RESP_WIDTH - 1:0]                         rresp_rt;
reg   [1:0]                                                          rvalid_index;
wire  [DC_ROUTE_NUM - 1:0]                                           rvalid_rt;
wire  [DRAM_CHAN_NUM * DRAM_BANK_NUM - 1:0]                          status_bank_idle_ch;
wire  [DRAM_CHAN_NUM*DRAM_BANK_NUM*CHAN_RANK_NUM-1:0]                status_bank_idle_mrr;
wire  [DRAM_CHAN_NUM*DRAM_BA_WIDTH-1:0]                              status_bist_bank_fail_ch;
wire  [DRAM_CHAN_NUM-1:0]                                            status_bist_endtest_ch;
wire  [DRAM_CHAN_NUM-1:0]                                            status_bist_error_ch;
wire  [DRAM_CHAN_NUM-1:0]                                            status_bist_error_new_ch;
wire  [DRAM_CHAN_NUM*DRAM_RANK_WIDTH-1:0]                            status_bist_rank_fail_ch;
wire  [DRAM_CHAN_NUM*DRAM_ROW_WIDTH-1:0]                             status_bist_row_fail_ch;
wire  [DRAM_CHAN_NUM - 1:0]                                          status_dram_pause_ch;
wire  [DRAM_CHAN_NUM - 1:0]                                          status_int_gc_fsm_ch;
wire  [DRAM_CHAN_NUM - 1:0]                                          status_xqr_empty_ch;
wire  [DRAM_CHAN_NUM - 1:0]                                          status_xqr_full_ch;
wire  [DRAM_CHAN_NUM - 1:0]                                          status_xqw_empty_ch;
wire  [DRAM_CHAN_NUM - 1:0]                                          status_xqw_full_ch;
wire                                                                 uci_mrs_last;
wire  [USER_CMD_CHAN_WIDTH-1:0]                                      user_cmd_chan;
wire  [DRAM_CHAN_NUM-1:0]                                            user_cmd_chan_sel;
wire  [7:0]                                                          user_cmd_mpr_data;
wire  [USER_CMD_WIDTH - 1:0]                                         user_cmd_opcode;
wire  [USER_CMD_RANK_WIDTH-1:0]                                      user_cmd_rank;
wire  [CHAN_RANK_NUM-1:0]                                            user_cmd_rank_sel;
wire  [DRAM_CHAN_NUM - 1:0]                                          user_cmd_ready_ch;
wire  [DRAM_CHAN_NUM-1:0]                                            user_cmd_valid;
wire  [DRAM_CHAN_NUM-1:0]                                            user_cmd_wait_done_ch;
wire  [LPDDR_MR_OPCODE_WIDTH - 1:0]                                  user_mr_op;
wire  [USER_MRS_SEL_WIDTH - 1:0]                                     user_mr_select;
wire  [DC_ROUTE_NUM * DRAM_CHAN_NUM - 1:0]                           wc_read_channel_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           wc_read_enable_rt;
wire  [DC_ROUTE_NUM * WCB_ADDR_WIDTH - 1:0]                          wc_read_ptr_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           wc_write_enable_rt;
wire  [DC_ROUTE_NUM * WCB_ADDR_WIDTH - 1:0]                          wc_write_ptr_rt;
wire  [DC_ROUTE_NUM * WCB_DATA_WIDTH - 1:0]                          wdata_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           wlast_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           wready_rt;
wire  [DC_ROUTE_NUM * WCB_STRB_WIDTH - 1:0]                          wstrb_rt;
wire  [DC_ROUTE_NUM - 1:0]                                           wvalid_rt;
wire  [DRAM_CHAN_NUM - 1:0]                                          xqif_rburst_last;
wire  [DRAM_CHAN_NUM - 1:0]                                          xqif_rdata_enable;
wire  [DRAM_CHAN_NUM - 1:0]                                          xqif_rdata_last;
wire  [DRAM_CHAN_NUM * RCB_TAG_WIDTH - 1:0]                          xqif_rdata_tag;
wire  [DRAM_CHAN_NUM - 1:0]                                          xqif_rdata_valid;
wire  [DRAM_CHAN_NUM - 1:0]                                          xqif_wburst_last;
wire  [DRAM_CHAN_NUM - 1:0]                                          xqif_wdata_enable;
wire  [DRAM_CHAN_NUM - 1:0]                                          xqif_wdata_last;
wire  [DRAM_CHAN_NUM * WCB_TAG_WIDTH - 1:0]                          xqif_wdata_tag;
wire  [DRAM_CHAN_NUM - 1:0]                                          xqif_wdata_valid;
wire  [DRAM_CHAN_NUM - 1:0]                                          xqif_wdata_valid_next;
reg   [XQR_SHIFT_DELAY_WIDTH - 1:0]                                  xqr_enable_delay;
wire  [MC_COUNTER_WIDTH - 1:0]                                       xqr_enable_delay_nxt;
wire  [DRAM_CHAN_NUM-1:0]                                            xqr_load;
wire  [DRAM_CHAN_NUM-1:0]                                            xqr_load_pc_mrr;
wire  [DRAM_CHAN_NUM*DC_ROUTE_NUM-1:0]                               xqr_route_busy_ch;
wire  [DC_ROUTE_NUM-1:0]                                             xqr_route_busy_int            [DRAM_CHAN_NUM-1:0];
wire  [DRAM_CHAN_NUM-1:0]                                            xqr_route_busy_rt             [DC_ROUTE_NUM-1:0];
wire  [DC_ROUTE_NUM - 1:0]                                           xqr_route_hold;
reg   [XQW_SHIFT_DELAY_WIDTH - 1:0]                                  xqw_enable_delay;
wire  [MC_COUNTER_WIDTH - 1:0]                                       xqw_enable_delay_nxt;
wire  [DRAM_CHAN_NUM-1:0]                                            xqw_load;
wire  [DRAM_CHAN_NUM*DC_ROUTE_NUM-1:0]                               xqw_route_busy_ch;
wire  [DC_ROUTE_NUM-1:0]                                             xqw_route_busy_int            [DRAM_CHAN_NUM-1:0];
wire  [DRAM_CHAN_NUM-1:0]                                            xqw_route_busy_rt             [DC_ROUTE_NUM-1:0];
wire  [DC_ROUTE_NUM - 1:0]                                           xqw_route_hold;


// Instances 
dataflow_controller dataflow_controller( 
  .araddr_rt                     (araddr_rt), 
  .arburst_rt                    (arburst_rt), 
  .arid_rt                       (arid_rt), 
  .arlen_rt                      (arlen_rt), 
  .arqos_rt                      (arqos_rt), 
  .arsize_rt                     (arsize_rt), 
  .arvalid_rt                    (arvalid_rt), 
  .awaddr_rt                     (awaddr_rt), 
  .awburst_rt                    (awburst_rt), 
  .awid_rt                       (awid_rt), 
  .awlen_rt                      (awlen_rt), 
  .awqos_rt                      (awqos_rt), 
  .awsize_rt                     (awsize_rt), 
  .awvalid_rt                    (awvalid_rt), 
  .bank_ready_enable_ch          (bank_ready_enable_ch), 
  .bready_rt                     (bready_rt), 
  .brif_bank_status              (brif_bank_status_b), 
  .brif_cas_ready_b              (brif_cas_ready_b), 
  .brif_pre_ready_b              (brif_pre_ready_b), 
  .brif_ras_ready_b              (brif_ras_ready_b), 
  .chan_en                       (dram_chan_en), 
  .clk                           (clk), 
  .dfi_rdlat_ch                  (dfi_rdlat_ch), 
  .dfi_rdlat_update              (dfi_rdlat_update), 
  .dram_rvalid                   (dram_rvalid), 
  .dti_data_byte_dis             (dti_data_byte_dis), 
  .nrow_alloc_ptr_rt             (nrow_alloc_ptr_rt), 
  .rank_en                       (dram_rank_en), 
  .reg_acq_realtime_enable_rt    (reg_acq_realtime_enable_rt), 
  .reg_addr_cfg                  (reg_addr_cfg), 
  .reg_arq_lahead_en             (reg_arq_lahead_en_rt), 
  .reg_arq_lat_barrier_enable_rt (reg_arq_lat_barrier_enable_rt), 
  .reg_arq_lat_barrier_rt        (reg_arq_lat_barrier_rt), 
  .reg_arq_lvl_hi_rt             (reg_arq_lvl_hi_rt), 
  .reg_arq_lvl_lo_rt             (reg_arq_lvl_lo_rt), 
  .reg_arq_ooo_enable_rt         (reg_arq_ooo_enable_rt), 
  .reg_arq_starv_rt              (reg_arq_starvation_th_rt), 
  .reg_awq_lahead_en             (reg_awq_lahead_en_rt), 
  .reg_awq_lat_barrier_enable_rt (reg_awq_lat_barrier_enable_rt), 
  .reg_awq_lat_barrier_rt        (reg_awq_lat_barrier_rt), 
  .reg_awq_lvl_hi_rt             (reg_awq_lvl_hi_rt), 
  .reg_awq_lvl_lo_rt             (reg_awq_lvl_lo_rt), 
  .reg_awq_ooo_enable_rt         (reg_awq_ooo_enable_rt), 
  .reg_awq_starv_rt              (reg_awq_starvation_th_rt), 
  .reg_bank_policy               (reg_bank_policy), 
  .reg_chan_unlock               (reg_chan_unlock), 
  .reg_channel_enable            (dram_chan_en), 
  .reg_dfi_freq_ratio            (reg_dfi_freq_ratio), 
  .reg_dram_bl_enc               (reg_dram_bl_enc), 
  .reg_ext_priority_rt           (reg_ext_priority_rt), 
  .reg_hi_pri_imm                (reg_hi_pri_imm), 
  .reg_lpddr4_enable             (reg_lpddr4_enable), 
  .reg_max_priority_rt           (reg_max_priority_rt), 
  .reg_rd_req_min                (reg_rd_req_min_rb), 
  .reg_req_threshold             (reg_req_threshold), 
  .reg_switch_close              (reg_switch_close), 
  .reg_t_read_high               (reg_t_read_high_rb), 
  .reg_t_read_low                (reg_t_read_low_rb), 
  .reg_t_write_high              (reg_t_write_high_rb), 
  .reg_t_write_low               (reg_t_write_low_rb), 
  .reg_wm_enable_rt              (reg_wm_enable_rt), 
  .reg_wr_req_min                (reg_wr_req_min), 
  .reset_n                       (reset_n), 
  .rready_rt                     (rready_rt), 
  .wlast_rt                      (wlast_rt), 
  .wstrb_rt                      (wstrb_rt), 
  .wvalid_rt                     (wvalid_rt), 
  .xqif_rburst_last              (xqif_rburst_last), 
  .xqif_rdata_last               (xqif_rdata_last), 
  .xqif_rdata_tag                (xqif_rdata_tag), 
  .xqif_rdata_valid              (xqif_rdata_valid), 
  .xqif_wburst_last              (xqif_wburst_last), 
  .xqif_wdata_last               (xqif_wdata_last), 
  .xqif_wdata_tag                (xqif_wdata_tag), 
  .xqif_wdata_valid_next         (xqif_wdata_valid_next), 
  .arready_rt                    (arready_rt), 
  .awready_rt                    (awready_rt), 
  .bc_occupy_empty               (), 
  .bc_occupy_full                (), 
  .bid_rt                        (bid_rt), 
  .bresp_rt                      (bresp_rt), 
  .brif_bank_occp_b              (brif_bank_occp_b), 
  .brif_cas_info_b               (brif_cas_info_b), 
  .brif_cas_rd_b                 (brif_cas_rd_b), 
  .brif_cas_valid_b              (brif_cas_valid_b), 
  .brif_page_close_b             (brif_page_close_b), 
  .brif_page_keep_b              (brif_page_keep_b), 
  .brif_pre_valid_b              (brif_pre_valid_b), 
  .brif_pri_b                    (brif_pri_b), 
  .brif_rank_addr_b              (brif_rank_addr_b), 
  .brif_ras_last_b               (brif_ras_last_b), 
  .brif_ras_valid_b              (brif_ras_valid_b), 
  .brif_row_addr_b               (brif_row_addr_b), 
  .brif_tagid_b                  (brif_tagid_b), 
  .bvalid_rt                     (bvalid_rt), 
  .rc_alloc_ptr_rt               (rc_alloc_ptr_rt), 
  .rc_nrow_ptr_rt                (nrow_alloc_tag_rt), 
  .rc_read_enable_rt             (rc_read_enable_rt), 
  .rc_read_ptr_rt                (rc_read_ptr_rt), 
  .rc_write_channel_rt           (rc_write_channel_rt), 
  .rc_write_enable_rt            (rc_write_enable_rt), 
  .rc_write_ptr_rt               (rc_write_ptr_rt), 
  .rid_rt                        (rid_rt), 
  .rlast_rt                      (rlast_rt), 
  .rresp_rt                      (rresp_rt), 
  .rvalid_rt                     (rvalid_rt), 
  .wc_read_channel_rt            (wc_read_channel_rt), 
  .wc_read_enable_rt             (wc_read_enable_rt), 
  .wc_read_ptr_rt                (wc_read_ptr_rt), 
  .wc_write_enable_rt            (wc_write_enable_rt), 
  .wc_write_ptr_rt               (wc_write_ptr_rt), 
  .wready_rt                     (wready_rt)
); 

datapath datapath( 
  .clk                 (clk), 
  .dram_dmi_chn        (dram_dmi), 
  .dram_rdata_chn      (dram_rdata), 
  .rc_read_enable_rt   (rc_read_enable_rt), 
  .rc_read_ptr_rt      (rc_read_ptr_rt), 
  .rc_write_channel_rt (rc_write_channel_rt), 
  .rc_write_enable_rt  (rc_write_enable_rt), 
  .rc_write_ptr_rt     (rc_write_ptr_rt), 
  .rcb_do_bf           (rcb_do_bf), 
  .reset_n             (reset_n), 
  .wc_read_channel_rt  (wc_read_channel_rt), 
  .wc_read_enable_rt   (wc_read_enable_rt), 
  .wc_read_ptr_rt      (wc_read_ptr_rt), 
  .wc_write_enable_rt  (wc_write_enable_rt), 
  .wc_write_ptr_rt     (wc_write_ptr_rt), 
  .wcb_do_bf           (wcb_do_bf), 
  .wdata_rt            (wdata_rt), 
  .wstrb_rt            (wstrb_rt), 
  .dram_wdata_chn      (dram_wdata), 
  .dram_wstrb_chn      (dram_wstrb), 
  .rcb_di_bf           (rcb_di_bf), 
  .rcb_dmi_bf          (rdata_dmi_rt), 
  .rcb_ra_bf           (rcb_ra_bf), 
  .rcb_re_n_bf         (rcb_re_n_bf), 
  .rcb_wa_bf           (rcb_wa_bf), 
  .rcb_we_n_bf         (rcb_we_n_bf), 
  .rdata_rt            (rdata_rt), 
  .wcb_di_bf           (wcb_di_bf), 
  .wcb_ra_bf           (wcb_ra_bf), 
  .wcb_re_n_bf         (wcb_re_n_bf), 
  .wcb_wa_bf           (wcb_wa_bf), 
  .wcb_we_n_bf         (wcb_we_n_bf)
); 

port_bridge port_bridge( 
  .aclk_p              (aclk_p), 
  .araddr_p            (araddr_p), 
  .arburst_p           (arburst_p), 
  .arcache_p           (arcache_p), 
  .aresetn_p           (aresetn_p), 
  .arid_p              (arid_p), 
  .arlen_p             (arlen_p), 
  .arlock_p            (arlock_p), 
  .arprot_p            (arprot_p), 
  .arqos_p             (arqos_p), 
  .arready_rt          (arready_rt), 
  .arsize_p            (arsize_p), 
  .arvalid_p           (arvalid_p), 
  .awaddr_p            (awaddr_p), 
  .awburst_p           (awburst_p), 
  .awcache_p           (awcache_p), 
  .awid_p              (awid_p), 
  .awlen_p             (awlen_p), 
  .awlock_p            (awlock_p), 
  .awprot_p            (awprot_p), 
  .awqos_p             (awqos_p), 
  .awready_rt          (awready_rt), 
  .awsize_p            (awsize_p), 
  .awvalid_p           (awvalid_p), 
  .axi4lite_araddr     (axi4lite_araddr), 
  .axi4lite_arready_rb (axi4lite_arready_rb), 
  .axi4lite_arvalid    (axi4lite_arvalid), 
  .axi4lite_awaddr     (axi4lite_awaddr), 
  .axi4lite_awready_rb (axi4lite_awready_rb), 
  .axi4lite_awvalid    (axi4lite_awvalid), 
  .axi4lite_bready     (axi4lite_bready), 
  .axi4lite_bresp_rb   (axi4lite_bresp_rb), 
  .axi4lite_bvalid_rb  (axi4lite_bvalid_rb), 
  .axi4lite_clk        (axi4lite_clk), 
  .axi4lite_rdata_rb   (axi4lite_rdata_rb), 
  .axi4lite_reset_n    (axi4lite_reset_n), 
  .axi4lite_rready     (axi4lite_rready), 
  .axi4lite_rresp_rb   (axi4lite_rresp_rb), 
  .axi4lite_rvalid_rb  (axi4lite_rvalid_rb), 
  .axi4lite_wdata      (axi4lite_wdata), 
  .axi4lite_wready_rb  (axi4lite_wready_rb), 
  .axi4lite_wvalid     (axi4lite_wvalid), 
  .bid_rt              (bid_rt), 
  .bready_p            (bready_p), 
  .bresp_rt            (bresp_rt), 
  .bvalid_rt           (bvalid_rt), 
  .ce_n_r_rt           (rcb_re_n_bf), 
  .clk                 (clk), 
  .int_gc_fsm_rb       (int_gc_fsm_rb), 
  .nrow_alloc_tag_rt   (nrow_alloc_tag_rt), 
  .rdata_rt            (rdata_rt), 
  .reg_narrow_mode_rt  (reg_narrow_mode_rt), 
  .reg_narrow_size_rt  (reg_narrow_size_rt), 
  .reg_size_max_rt     (reg_size_max_rt), 
  .reset_n             (reset_n), 
  .rid_rt              (rid_rt), 
  .rlast_rt            (rlast_rt), 
  .rready_p            (rready_p), 
  .rresp_rt            (rresp_rt), 
  .rvalid_rt           (rvalid_rt), 
  .wdata_p             (wdata_p), 
  .wlast_p             (wlast_p), 
  .wready_rt           (wready_rt), 
  .wstrb_p             (wstrb_p), 
  .wvalid_p            (wvalid_p), 
  .araddr_rt           (araddr_rt), 
  .arburst_rt          (arburst_rt), 
  .arcache_rt          (arcache_rt), 
  .arid_rt             (arid_rt), 
  .arlen_rt            (arlen_rt), 
  .arlock_rt           (arlock_rt), 
  .arprot_rt           (arprot_rt), 
  .arqos_rt            (arqos_rt), 
  .arready_p           (arready_p), 
  .arsize_rt           (arsize_rt), 
  .arvalid_rt          (arvalid_rt), 
  .awaddr_rt           (awaddr_rt), 
  .awburst_rt          (awburst_rt), 
  .awcache_rt          (awcache_rt), 
  .awid_rt             (awid_rt), 
  .awlen_rt            (awlen_rt), 
  .awlock_rt           (awlock_rt), 
  .awprot_rt           (awprot_rt), 
  .awqos_rt            (awqos_rt), 
  .awready_p           (awready_p), 
  .awsize_rt           (awsize_rt), 
  .awvalid_rt          (awvalid_rt), 
  .axi4lite_araddr_rb  (axi4lite_araddr_rb), 
  .axi4lite_arready    (axi4lite_arready), 
  .axi4lite_arvalid_rb (axi4lite_arvalid_rb), 
  .axi4lite_awaddr_rb  (axi4lite_awaddr_rb), 
  .axi4lite_awready    (axi4lite_awready), 
  .axi4lite_awvalid_rb (axi4lite_awvalid_rb), 
  .axi4lite_bready_rb  (axi4lite_bready_rb), 
  .axi4lite_bresp      (axi4lite_bresp), 
  .axi4lite_bvalid     (axi4lite_bvalid), 
  .axi4lite_rdata      (axi4lite_rdata), 
  .axi4lite_rready_rb  (axi4lite_rready_rb), 
  .axi4lite_rresp      (axi4lite_rresp), 
  .axi4lite_rvalid     (axi4lite_rvalid), 
  .axi4lite_wdata_rb   (axi4lite_wdata_rb), 
  .axi4lite_wready     (axi4lite_wready), 
  .axi4lite_wvalid_rb  (axi4lite_wvalid_rb), 
  .bid_p               (bid_p), 
  .bready_rt           (bready_rt), 
  .bresp_p             (bresp_p), 
  .bvalid_p            (bvalid_p), 
  .int_gc_fsm          (int_gc_fsm), 
  .nrow_alloc_ptr_rt   (nrow_alloc_ptr_rt), 
  .rdata_p             (rdata_p), 
  .rid_p               (rid_p), 
  .rlast_p             (rlast_p), 
  .rready_rt           (rready_rt), 
  .rresp_p             (rresp_p), 
  .rvalid_p            (rvalid_p), 
  .wdata_rt            (wdata_rt), 
  .wlast_rt            (wlast_rt), 
  .wready_p            (wready_p), 
  .wstrb_rt            (wstrb_rt), 
  .wvalid_rt           (wvalid_rt)
); 

register_block register_block( 
  .uci_cmd_op                  (user_cmd_opcode), 
  .uci_cmd_chan                (user_cmd_chan), 
  .uci_cmd_rank                (user_cmd_rank), 
  .uci_mr_sel                  (user_mr_select), 
  .uci_mrs_last                (uci_mrs_last), 
  .uci_mpr_data                (user_cmd_mpr_data), 
  .dmctl_ddrt                  (reg_pom_ddrt), 
  .dmctl_dfi_freq_ratio        (reg_dfi_freq_ratio), 
  .dmctl_dram_bank_en          (reg_dram_bank_enable), 
  .dmctl_switch_close          (reg_switch_close), 
  .dmctl_bank_policy           (reg_bank_policy), 
  .dmctl_wr_dbi                (reg_wr_dbi), 
  .dmctl_rd_dbi                (reg_rd_dbi), 
  .dmctl_dual_chan_en          (dmctl_dual_chan_en), 
  .dmctl_dual_rank_en          (dmctl_dual_rank_en), 
  .dmctl_rd_req_min            (reg_rd_req_min), 
  .dmctl_wr_req_min            (reg_wr_req_min), 
  .dmctl_wr_crc                (reg_wr_crc), 
  .dmctl_chan_unlock           (reg_chan_unlock), 
  .dmctl_hi_pri_imm            (reg_hi_pri_imm), 
  .dmcfg_ref_post_pull_en      (reg_post_pull_en), 
  .dmcfg_auto_srx_zqcl         (reg_auto_srx_zqcl_rb), 
  .dmcfg_ref_int_en            (reg_ref_int_en), 
  .dmcfg_req_th                (reg_req_threshold), 
  .dmcfg_zq_auto_en            (reg_zq_auto_en), 
  .dmcfg_ref_otf               (reg_ddr_ref_otf), 
  .dmcfg_dqs2cken              (dmcfg_dqs2cken), 
  .lpddr4_lpmr1_fs0_wpre       (), 
  .lpddr4_lpmr1_fs0_rpre       (), 
  .lpddr4_lpmr1_fs1_wpre       (), 
  .lpddr4_lpmr1_fs1_rpre       (), 
  .lpddr4_lpmr12_fs0_vrefcas   (lpddr4_lpmr12_fs0_vrefcas), 
  .lpddr4_lpmr12_fs0_vrefcar   (lpddr4_lpmr12_fs0_vrefcar), 
  .lpddr4_lpmr12_fs1_vrefcas   (lpddr4_lpmr12_fs1_vrefcas), 
  .lpddr4_lpmr12_fs1_vrefcar   (lpddr4_lpmr12_fs1_vrefcar), 
  .lpddr4_lpmr14_fs0_vrefdqs   (lpddr4_lpmr14_fs0_vrefdqs), 
  .lpddr4_lpmr14_fs0_vrefdqr   (lpddr4_lpmr14_fs0_vrefdqr), 
  .lpddr4_lpmr14_fs1_vrefdqs   (lpddr4_lpmr14_fs1_vrefdqs), 
  .lpddr4_lpmr14_fs1_vrefdqr   (lpddr4_lpmr14_fs1_vrefdqr), 
  .ddr4_mr2_wrcrc              (ddr4_mr2_wrcrc), 
  .ddr4_mr4_cal                (reg_ddr4_mr4_cal), 
  .ddr4_mr4_rpre               (reg_ddr4_mr4_rdpre), 
  .ddr4_mr4_wpre               (reg_ddr4_mr4_wrpre), 
  .ddr4_mr6_vrefdq             (ddr4_mr6_vrefdq), 
  .ddr4_mr6_vrefdqr            (ddr4_mr6_vrefdqr), 
  .ddr4_mr6_ccdl               (), 
  .phy_dti_dram_clk_dis        (dti_dram_clk_dis), 
  .phy_dti_data_byte_dis       (dti_data_byte_dis), 
  .pom_chanen                  (reg_pom_chanen), 
  .pom_dfien                   (reg_pom_dfien_rb), 
  .pom_proc                    (reg_pom_proc), 
  .pom_physeten                (reg_pom_physeten), 
  .pom_phyfsen                 (reg_pom_phyfsen), 
  .pom_phyinit                 (reg_pom_phyinit), 
  .pom_dllrsten                (reg_pom_dllrsten), 
  .pom_draminiten              (reg_pom_draminiten), 
  .pom_vrefdqrden              (reg_pom_vrefdqrden), 
  .pom_vrefcaen                (reg_pom_vrefcaen), 
  .pom_gten                    (reg_pom_gten), 
  .pom_wrlvlen                 (reg_pom_wrlvlen), 
  .pom_rdlvlen                 (reg_pom_rdlvlen), 
  .pom_vrefdqwren              (reg_pom_vrefdqwren), 
  .pom_dlyevalen               (reg_pom_dlyevalen), 
  .pom_sanchken                (reg_pom_sanchken), 
  .pom_fs                      (reg_pom_fs), 
  .pom_clklocken               (reg_pom_clklocken), 
  .pom_cmddlyen                (reg_pom_cmddlyen), 
  .pom_odt                     (reg_pom_odt), 
  .pom_dqsdqen                 (reg_pom_dqsdqen), 
  .pom_ranken                  (reg_pom_ranken), 
  .rtgc0_gt_updt               (reg_rtgc_gt_updt), 
  .rtgc0_gt_dis                (reg_rtgc_gt_dis), 
  .rtgc0_fs0_twren             (reg_rtgc_fs0_twren), 
  .rtgc0_fs0_trden             (reg_rtgc_fs0_trden), 
  .rtgc0_fs0_trdendbi          (reg_rtgc_fs0_trdendbi), 
  .rtgc1_fs1_twren             (reg_rtgc_fs1_twren), 
  .rtgc1_fs1_trden             (reg_rtgc_fs1_trden), 
  .rtgc1_fs1_trdendbi          (reg_rtgc_fs1_trdendbi), 
  .ptar_ba                     (reg_ptar_ba), 
  .ptar_row                    (reg_ptar_row), 
  .ptar_col                    (reg_ptar_col), 
  .vtgc_ivrefr                 (reg_vtgc_ivrefr), 
  .vtgc_ivrefts                (reg_vtgc_ivrefts), 
  .vtgc_vrefdqsw               (reg_vtgc_vrefdqsw), 
  .vtgc_vrefcasw               (reg_vtgc_vrefcasw), 
  .vtgc_ivrefen                (reg_vtgc_ivrefen), 
  .pbcr_bist_en                (reg_pbcr_bist_en), 
  .pbcr_bist_start             (reg_pbcr_bist_start), 
  .pbcr_lp_en                  (reg_pbcr_lp_en), 
  .pccr_srst                   (reg_pccr_srst), 
  .pccr_tpaden                 (reg_pccr_tpaden), 
  .pccr_mvg                    (reg_pccr_mvg), 
  .pccr_en                     (reg_pccr_en), 
  .pccr_upd                    (reg_pccr_upd), 
  .pccr_bypen                  (reg_pccr_bypen), 
  .pccr_byp_n                  (reg_pccr_byp_n), 
  .pccr_byp_p                  (reg_pccr_byp_p), 
  .pccr_initcnt                (reg_pccr_initcnt), 
  .dqsdqcr_dlyoffs             (dqsdqcr_dlyoffs), 
  .dqsdqcr_dqsel               (dqsdqcr_dqsel), 
  .dqsdqcr_mupd                (dqsdqcr_mupd), 
  .dqsdqcr_mpcrpt              (dqsdqcr_mpcrpt), 
  .dqsdqcr_dlymax              (dqsdqcr_dlymax), 
  .dqsdqcr_dir                 (dqsdqcr_dir), 
  .dqsdqcr_rank                (dqsdqcr_rank), 
  .calvlpa0_pattern_a          (calvlpa_pattern_a), 
  .calvlpa1_pattern_b          (calvlpa_pattern_b), 
  .adft_tst_en_ca              (reg_adft_tst_en_ca), 
  .adft_tst_en_dq              (reg_adft_tst_en_dq), 
  .outbypen0_clk               (outbypen_clk), 
  .outbypen0_dm                (reg_outbypen_dm), 
  .outbypen0_dqs               (reg_outbypen_dqs), 
  .outbypen1_dq                (reg_outbypen_dq), 
  .outbypen2_ctl               (outbypen_ctl), 
  .outd0_clk                   (outd_clk), 
  .outd0_dm                    (reg_outd_dm), 
  .outd0_dqs                   (reg_outd_dqs), 
  .outd1_dq                    (reg_outd_dq), 
  .outd2_ctl                   (outd_ctl), 
  .dvstt1_dfi_freq_ratio       (dfi_freq_ratio), 
  .pos_physetc                 (reg_pos_physetc), 
  .pos_phyfsc                  (reg_pos_phyfsc), 
  .pos_phyinitc                (reg_pos_phyinitc), 
  .pos_dllrstc                 (reg_pos_dllrstc), 
  .pos_draminitc               (reg_pos_draminitc), 
  .pos_vrefdqrdc               (reg_pos_vrefdqrdc), 
  .pos_vrefcac                 (reg_pos_vrefcac), 
  .pos_gtc                     (reg_pos_gtc), 
  .pos_wrlvlc                  (reg_pos_wrlvlc), 
  .pos_rdlvlc                  (reg_pos_rdlvlc), 
  .pos_vrefdqwrc               (reg_pos_vrefdqwrc), 
  .pos_dlyevalc                (reg_pos_dlyevalc), 
  .pos_sanchkc                 (reg_pos_sanchkc), 
  .pos_ofs                     (reg_pos_ofs), 
  .pos_fs0req                  (reg_pos_fs0req), 
  .pos_fs1req                  (reg_pos_fs1req), 
  .pos_clklockc                (reg_pos_clklockc), 
  .pos_cmddlyc                 (reg_pos_cmddlyc), 
  .pos_dqsdqc                  (reg_pos_dqsdqc), 
  .dllsttca_lock               (reg_dllca_lock), 
  .dllsttca_ovfl               (reg_dllca_ovfl), 
  .dllsttca_unfl               (reg_dllca_unfl), 
  .dllsttdq_lock               (reg_dlldq_lock), 
  .dllsttdq_ovfl               (reg_dlldq_ovfl), 
  .dllsttdq_unfl               (reg_dlldq_unfl), 
  .pbsr_bist_done              (reg_pbsr_bist_done), 
  .pbsr_bist_err_ctl           (pbsr_bist_err_ctl), 
  .pbsr1_bist_err_dq           (pbsr_bist_err_dq), 
  .pbsr2_bist_err_dm           (pbsr_bist_err_dm), 
  .pcsr_srstc                  (reg_pcsr_srstc), 
  .pcsr_updc                   (reg_pcsr_updc), 
  .pcsr_nbc                    (reg_pcsr_nbc), 
  .pcsr_pbc                    (reg_pcsr_pbc), 
  .rtcfg_ext_pri_rt            (reg_ext_priority_rt), 
  .rtcfg_max_pri_rt            (reg_max_priority_rt), 
  .rtcfg_arq_lvl_hi_rt         (reg_arq_lvl_hi_rt), 
  .rtcfg_arq_lvl_lo_rt         (reg_arq_lvl_lo_rt), 
  .rtcfg_awq_lvl_hi_rt         (reg_awq_lvl_hi_rt), 
  .rtcfg_awq_lvl_lo_rt         (reg_awq_lvl_lo_rt), 
  .rtcfg_arq_lat_barrier_en_rt (reg_arq_lat_barrier_enable_rt), 
  .rtcfg_awq_lat_barrier_en_rt (reg_awq_lat_barrier_enable_rt), 
  .rtcfg_arq_ooo_en_rt         (reg_arq_ooo_enable_rt), 
  .rtcfg_awq_ooo_en_rt         (reg_awq_ooo_enable_rt), 
  .rtcfg_acq_realtime_en_rt    (reg_acq_realtime_enable_rt), 
  .rtcfg_wm_enable_rt          (reg_wm_enable_rt), 
  .rtcfg_arq_lahead_en_rt      (reg_arq_lahead_en_rt), 
  .rtcfg_awq_lahead_en_rt      (reg_awq_lahead_en_rt), 
  .rtcfg_narrow_mode_rt        (reg_narrow_mode_rt), 
  .rtcfg_narrow_size_rt        (reg_narrow_size_rt), 
  .rtcfg_arq_lat_barrier_rt    (reg_arq_lat_barrier_rt), 
  .rtcfg_awq_lat_barrier_rt    (reg_awq_lat_barrier_rt), 
  .rtcfg_arq_starv_th_rt       (reg_arq_starvation_th_rt), 
  .rtcfg_awq_starv_th_rt       (reg_awq_starvation_th_rt), 
  .rtcfg_size_max_rt           (reg_size_max_rt), 
  .addr_cfg                    (reg_addr_cfg), 
  .dllctlca_limit              (reg_dllca_limit), 
  .dllctlca_en                 (reg_dllca_en), 
  .dllctlca_upd                (reg_dllca_upd), 
  .dllctlca_byp                (reg_dllca_byp), 
  .dllctlca_bypc               (reg_dllca_bypc), 
  .dllctlca_clkdly             (reg_dllca_clkdly), 
  .dllctldq_limit              (reg_dlldq_limit), 
  .dllctldq_en                 (reg_dlldq_en), 
  .dllctldq_upd                (reg_dlldq_upd), 
  .dllctldq_byp                (reg_dlldq_byp), 
  .dllctldq_bypc               (reg_dlldq_bypc), 
  .pbcr_vrefenca               (reg_pbcr_vrefenca), 
  .pbcr_vrefsetca              (reg_pbcr_vrefsetca), 
  .cior_drvsel                 (reg_cior_drvsel), 
  .cior_cmos_en                (reg_cior_cmos_en), 
  .cior_odis_clk               (reg_cior_odis_clk), 
  .cior_odis_ctl               (reg_cior_odis_ctl), 
  .dior_drvsel                 (reg_dior_drvsel), 
  .dior_cmos_en                (reg_dior_cmos_en), 
  .dior_fena_rcv               (reg_dior_fena_rcv), 
  .dior_rtt_en                 (reg_dior_rtt_en), 
  .dior_rtt_sel                (reg_dior_rtt_sel), 
  .dior_odis_dq                (reg_dior_odis_dq), 
  .dior_odis_dm                (reg_dior_odis_dm), 
  .dior_odis_dqs               (reg_dior_odis_dqs), 
  .ptsr_vrefcar                (reg_ptsr_vrefcar), 
  .ptsr_vrefcar_ip             (ptsr_vrefcar_ip), 
  .ptsr_vrefcas                (reg_ptsr_vrefcas), 
  .ptsr_vrefcas_ip             (ptsr_vrefcas_ip), 
  .ptsr_vrefdqwrr              (reg_ptsr_vrefdqwrr), 
  .ptsr_vrefdqwrr_ip           (ptsr_vrefdqwrr_ip), 
  .ptsr_vrefdqwrs              (reg_ptsr_vrefdqwrs), 
  .ptsr_vrefdqwrs_ip           (ptsr_vrefdqwrs_ip), 
  .ptsr_cs                     (reg_ptsr_cs), 
  .ptsr_cs_ip                  (ptsr_cs_ip), 
  .ptsr_ca                     (reg_ptsr_ca), 
  .ptsr_ca_ip                  (ptsr_ca_ip), 
  .ptsr_ba                     (reg_ptsr_ba), 
  .ptsr_actn                   (reg_ptsr_actn), 
  .ptsr_cke                    (reg_ptsr_cke), 
  .ptsr_gt                     (reg_ptsr_gt), 
  .ptsr_gt_ip                  (ptsr_gt_ip), 
  .ptsr_wrlvl                  (reg_ptsr_wrlvl), 
  .ptsr_wrlvl_ip               (ptsr_wrlvl_ip), 
  .ptsr_dqsdq                  (reg_ptsr_dqsdq), 
  .ptsr_dqsdq_ip               (ptsr_dqsdq_ip), 
  .ptsr_dqsdm                  (reg_ptsr_dqsdm), 
  .ptsr_dqsdm_ip               (ptsr_dqsdm_ip), 
  .ptsr_rdlvldq                (reg_ptsr_rdlvldq), 
  .ptsr_rdlvldq_ip             (ptsr_rdlvldq_ip), 
  .ptsr_rdlvldm                (reg_ptsr_rdlvldm), 
  .ptsr_rdlvldm_ip             (ptsr_rdlvldm_ip), 
  .ptsr_vrefdqrd               (reg_ptsr_vrefdqrd), 
  .ptsr_vrefdqrd_ip            (ptsr_vrefdqrd_ip), 
  .ptsr_vrefdqrdr              (reg_ptsr_vrefdqrdr), 
  .ptsr_vrefdqrdr_ip           (ptsr_vrefdqrdr_ip), 
  .ptsr_psck                   (reg_ptsr_psck), 
  .ptsr_psck_ip                (ptsr_psck_ip), 
  .ptsr_dqsleadck              (reg_ptsr_dqsleadck), 
  .ptsr_dqsleadck_ip           (ptsr_dqsleadck_ip), 
  .ptsr_sanpat                 (reg_ptsr_sanpat), 
  .ptsr_odt                    (reg_ptsr_odt), 
  .ptsr_rstn                   (reg_ptsr_rstn), 
  .ptsr_nt_rank                (ptsr_nt_rank), 
  .ptsr_nt_rank_ip             (ptsr_nt_rank_ip), 
  .reg_t_alrtp_rb              (reg_t_alrtp_rb), 
  .reg_t_ckesr_rb              (reg_t_ckesr_rb), 
  .reg_t_ccd_s_rb              (reg_t_ccd_s_rb), 
  .reg_t_faw_rb                (reg_t_faw_rb), 
  .reg_t_rtw_rb                (reg_t_rtw_rb), 
  .reg_t_rcd_rb                (reg_t_rcd_rb), 
  .reg_t_rdpden_rb             (reg_t_rdpden_rb), 
  .reg_t_rc_rb                 (reg_t_rc_rb), 
  .reg_t_ras_rb                (reg_t_ras_rb), 
  .reg_t_pd_rb                 (reg_t_pd_rb), 
  .reg_t_rp_rb                 (reg_t_rp_rb), 
  .reg_t_wlbr_rb               (reg_t_wlbr_rb), 
  .reg_t_wrapden_rb            (reg_t_wrapden_rb), 
  .reg_t_cke_rb                (), 
  .reg_t_xp_rb                 (reg_t_xp_rb), 
  .reg_t_vreftimelong_rb       (reg_t_vreftimelong_rb), 
  .reg_t_vreftimeshort_rb      (reg_t_vreftimeshort_rb), 
  .reg_t_mrd_rb                (reg_t_mrd_rb), 
  .reg_t_zqcs_itv_rb           (), 
  .reg_t_pori_rb               (reg_t_pori_rb), 
  .reg_t_zqinit_rb             (reg_t_zqinit_rb), 
  .reg_t_mrs2lvlen_rb          (reg_t_mrs2lvlen_rb), 
  .reg_t_zqcs_rb               (reg_t_zqcs_rb), 
  .reg_t_xpdll_rb              (reg_t_xpdll_rb), 
  .reg_t_wlbtr_rb              (reg_t_wlbtr_rb), 
  .reg_t_rrd_s_rb              (reg_t_rrd_s_rb), 
  .reg_t_rfc1_rb               (), 
  .reg_t_mrs2act_rb            (reg_t_mrs2act_rb), 
  .reg_t_lvlaa_rb              (reg_t_lvlaa_rb), 
  .reg_t_dllk_rb               (reg_t_dllk_rb), 
  .reg_t_refi_off_rb           (reg_t_refi_off_rb), 
  .reg_t_mprr_rb               (reg_t_mprr_rb), 
  .reg_t_xpr_rb                (reg_t_xpr_rb), 
  .reg_t_dllrst_rb             (reg_t_dllrst_rb), 
  .reg_t_rst_rb                (reg_t_rst_rb), 
  .reg_t_odth4_rb              (reg_t_odth4_rb), 
  .reg_t_odth8_rb              (reg_t_odth8_rb), 
  .reg_t_lvlload_rb            (reg_t_lvlload_rb), 
  .reg_t_lvldll_rb             (reg_t_lvldll_rb), 
  .reg_t_lvlresp_rb            (reg_t_lvlresp_rb), 
  .reg_t_xs_rb                 (reg_t_xs_rb), 
  .reg_t_mod_rb                (reg_t_mod_rb), 
  .reg_t_dpd_rb                (reg_t_dpd_rb), 
  .reg_t_mrw_rb                (reg_t_mrw_rb), 
  .reg_t_wr2rd_rb              (), 
  .reg_t_mrr_rb                (reg_t_mrr_rb), 
  .reg_t_zqrs_rb               (reg_t_zqrs_rb), 
  .reg_t_dqscke_rb             (reg_t_dqscke_rb), 
  .reg_t_xsr_rb                (reg_t_xsr_rb), 
  .reg_t_mped_rb               (reg_t_mped_rb), 
  .reg_t_mpx_rb                (reg_t_mpx_rb), 
  .reg_t_wr_mpr_rb             (reg_t_wr_mpr_rb), 
  .reg_t_init5_rb              (reg_t_init5_rb), 
  .reg_t_setgear_rb            (), 
  .reg_t_syncgear_rb           (), 
  .reg_t_dlllock_rb            (reg_t_dlllock_rb), 
  .reg_t_wlbtr_s_rb            (), 
  .reg_t_read_low_rb           (reg_t_read_low_rb), 
  .reg_t_read_high_rb          (reg_t_read_high_rb), 
  .reg_t_write_low_rb          (reg_t_write_low_rb), 
  .reg_t_write_high_rb         (reg_t_write_high_rb), 
  .reg_t_rfc2_rb               (), 
  .reg_t_rfc4_rb               (), 
  .reg_t_wlbr_crcdm_rb         (), 
  .reg_t_wlbtr_crcdm_l_rb      (), 
  .reg_t_wlbtr_crcdm_s_rb      (), 
  .reg_t_xmpdll_rb             (reg_t_xmpdll_rb), 
  .reg_t_wrmpr_rb              (), 
  .reg_t_lvlexit_rb            (reg_t_lvlexit_rb), 
  .reg_t_lvldis_rb             (reg_t_lvldis_rb), 
  .reg_t_zqoper_rb             (), 
  .reg_t_rfc_rb                (reg_t_rfc_rb), 
  .reg_t_xsdll_rb              (), 
  .reg_odtlon_rb               (), 
  .reg_odtloff_rb              (), 
  .reg_t_wlmrd_rb              (), 
  .reg_t_wldqsen_rb            (), 
  .reg_t_wtr_rb                (), 
  .reg_t_rda2pd_rb             (), 
  .reg_t_wra2pd_rb             (), 
  .reg_t_zqcl_rb               (reg_t_zqcl_rb), 
  .reg_t_calvl_adr_ckeh_rb     (reg_t_calvl_adr_ckeh_rb), 
  .reg_t_calvl_capture_rb      (reg_t_calvl_capture_rb), 
  .reg_t_calvl_cc_rb           (reg_t_calvl_cc_rb), 
  .reg_t_calvl_en_rb           (reg_t_calvl_en_rb), 
  .reg_t_calvl_ext_rb          (reg_t_calvl_ext_rb), 
  .reg_t_calvl_max_rb          (reg_t_calvl_max_rb), 
  .reg_t_ckehdqs_rb            (reg_t_ckehdqs_rb), 
  .reg_t_ccd_rb                (reg_t_ccd_rb), 
  .reg_t_zqlat_rb              (reg_t_zqlat_rb), 
  .reg_t_ckckeh_rb             (reg_t_ckckeh_rb), 
  .reg_t_rrd_rb                (reg_t_rrd_rb), 
  .reg_t_caent_rb              (reg_t_caent_rb), 
  .reg_t_cmdcke_rb             (reg_t_cmdcke_rb), 
  .reg_t_mpcwr_rb              (reg_t_mpcwr_rb), 
  .reg_t_dqrpt_rb              (reg_t_dqrpt_rb), 
  .reg_t_zq_itv_rb             (reg_t_zq_itv_rb), 
  .reg_t_ckelck_rb             (reg_t_ckelck_rb), 
  .reg_t_dllen_rb              (reg_t_dllen_rb), 
  .reg_t_init3_rb              (reg_t_init3_rb), 
  .reg_t_dtrain_rb             (reg_t_dtrain_rb), 
  .reg_t_mpcwr2rd_rb           (reg_t_mpcwr2rd_rb), 
  .reg_t_fc_rb                 (reg_t_fc_rb), 
  .reg_t_refi_rb               (reg_t_refi_rb), 
  .reg_t_vrcgen_rb             (reg_t_vrcgen_rb), 
  .reg_t_vrcgdis_rb            (reg_t_vrcgdis_rb), 
  .reg_t_odtup_rb              (reg_t_odtup_rb), 
  .reg_t_ccdwm_rb              (reg_t_ccdwm_rb), 
  .reg_t_osco_rb               (reg_t_osco_rb), 
  .reg_t_ckfspe_rb             (reg_t_ckfspe_rb), 
  .reg_t_ckfspx_rb             (reg_t_ckfspx_rb), 
  .reg_t_init1_rb              (reg_t_init1_rb), 
  .reg_t_zqcal_rb              (reg_t_zqcal_rb), 
  .reg_t_lvlresp_nr_rb         (reg_t_lvlresp_nr), 
  .reg_t_ppd_rb                (reg_t_ppd_rb), 
  .bistcfg_start_rank_ch       (reg_bist_start_rank_ch), 
  .bistcfg_end_rank_ch         (reg_bist_end_rank_ch), 
  .bistcfg_start_bank_ch       (reg_bist_start_bank_ch), 
  .bistcfg_end_bank_ch         (reg_bist_end_bank_ch), 
  .bistcfg_start_background_ch (reg_bist_start_background_ch), 
  .bistcfg_end_background_ch   (reg_bist_end_background_ch), 
  .bistcfg_element_ch          (reg_bist_element_ch), 
  .bistcfg_operation_ch        (reg_bist_operation_ch), 
  .bistcfg_retention_ch        (reg_bist_retention_ch), 
  .bistcfg_diagnosis_en_ch     (reg_bist_diagnosis_en_ch), 
  .biststaddr_start_row_ch     (reg_bist_start_row_ch), 
  .biststaddr_start_col_ch     (reg_bist_start_col_ch), 
  .bistedaddr_end_row_ch       (reg_bist_end_row_ch), 
  .bistedaddr_end_col_ch       (reg_bist_end_col_ch), 
  .bistm0_march_element_0_ch   (reg_bist_march_element_0_ch), 
  .bistm1_march_element_1_ch   (reg_bist_march_element_1_ch), 
  .bistm2_march_element_2_ch   (reg_bist_march_element_2_ch), 
  .bistm3_march_element_3_ch   (reg_bist_march_element_3_ch), 
  .bistm4_march_element_4_ch   (reg_bist_march_element_4_ch), 
  .bistm5_march_element_5_ch   (reg_bist_march_element_5_ch), 
  .bistm6_march_element_6_ch   (reg_bist_march_element_6_ch), 
  .bistm7_march_element_7_ch   (reg_bist_march_element_7_ch), 
  .bistm8_march_element_8_ch   (reg_bist_march_element_8_ch), 
  .bistm9_march_element_9_ch   (reg_bist_march_element_9_ch), 
  .bistm10_march_element_10_ch (reg_bist_march_element_10_ch), 
  .bistm11_march_element_11_ch (reg_bist_march_element_11_ch), 
  .bistm12_march_element_12_ch (reg_bist_march_element_12_ch), 
  .bistm13_march_element_13_ch (reg_bist_march_element_13_ch), 
  .bistm14_march_element_14_ch (reg_bist_march_element_14_ch), 
  .bistm15_march_element_15_ch (reg_bist_march_element_15_ch), 
  .status_dram_pause_ch        (status_dram_pause_ch), 
  .status_user_cmd_ready_ch    (user_cmd_ready_ch), 
  .status_bank_idle_ch         (status_bank_idle_ch), 
  .status_xqr_empty_ch         (status_xqr_empty_ch), 
  .status_xqr_full_ch          (status_xqr_full_ch), 
  .status_xqw_empty_ch         (status_xqw_empty_ch), 
  .status_xqw_full_ch          (status_xqw_full_ch), 
  .status_int_gc_fsm_ch        (status_int_gc_fsm_ch), 
  .status_bist_error_ch        (status_bist_error_ch), 
  .status_bist_endtest_ch      (status_bist_endtest_ch), 
  .status_bist_error_new_ch    (status_bist_error_new_ch), 
  .status_bist_rank_fail_ch    (status_bist_rank_fail_ch), 
  .status_bist_bank_fail_ch    (status_bist_bank_fail_ch), 
  .status_bist_row_fail_ch     (status_bist_row_fail_ch), 
  .pts_vrefdqrderr             (reg_pts_vrefdqrderr), 
  .pts_vrefcaerr               (reg_pts_vrefcaerr), 
  .pts_gterr                   (reg_pts_gterr), 
  .pts_wrlvlerr                (reg_pts_wrlvlerr), 
  .pts_vrefdqwrerr             (reg_pts_vrefdqwrerr), 
  .pts_rdlvldmerr              (reg_pts_rdlvldmerr), 
  .pts_dllerr                  (reg_pts_dllerr), 
  .pts_lp3calvlerr             (pts_lp3calvlerr), 
  .pts_sanchkerr               (reg_pts_sanchkerr), 
  .pts_dqsdmerr                (reg_pts_dqsdmerr), 
  .pts_rdlvldqerr              (reg_pts_rdlvldqerr), 
  .pts_dqsdqerr                (reg_pts_dqsdqerr), 
  .mpr_done_ch                 (mpr_access_done_ch0), 
  .mpr_readout_ch              (mpr_readout_ch0), 
  .mrr_done_ch                 (mrr_done_ch), 
  .mrr_readout_ch              (mrr_readout_ch), 
  .shad_reg_lpmr1_fs0          (shad_reg_lpmr1_fs0), 
  .shad_reg_lpmr1_fs1          (shad_reg_lpmr1_fs1), 
  .shad_reg_lpmr2_fs0          (shad_reg_lpmr2_fs0), 
  .shad_reg_lpmr2_fs1          (shad_reg_lpmr2_fs1), 
  .shad_reg_lpmr3_fs0          (shad_reg_lpmr3_fs0), 
  .shad_reg_lpmr3_fs1          (shad_reg_lpmr3_fs1), 
  .shad_reg_lpmr11_fs0         (shad_reg_lpmr11_fs0), 
  .shad_reg_lpmr11_fs1         (shad_reg_lpmr11_fs1), 
  .shad_reg_lpmr11_nt_fs0      (shad_reg_lpmr11_nt_fs0), 
  .shad_reg_lpmr11_nt_fs1      (shad_reg_lpmr11_nt_fs1), 
  .shad_reg_lpmr12_fs0         (shad_reg_lpmr12_fs0), 
  .shad_reg_lpmr12_fs1         (shad_reg_lpmr12_fs1), 
  .shad_reg_lpmr13             (shad_reg_lpmr13), 
  .shad_reg_lpmr14_fs0         (shad_reg_lpmr14_fs0), 
  .shad_reg_lpmr14_fs1         (shad_reg_lpmr14_fs1), 
  .shad_reg_lpmr22_fs0         (shad_reg_lpmr22_fs0), 
  .shad_reg_lpmr22_fs1         (shad_reg_lpmr22_fs1), 
  .shad_reg_lpmr22_nt_fs0      (shad_reg_lpmr22_nt_fs0), 
  .shad_reg_lpmr22_nt_fs1      (shad_reg_lpmr22_nt_fs1), 
  .data_rddata                 (data_rddata), 
  .int_gc_fsm_ch               (int_gc_fsm_rb), 
  .reg_ddr4_mr0                (reg_ddr4_mr0), 
  .reg_ddr4_mr1                (reg_ddr4_mr1), 
  .reg_ddr4_mr2                (reg_ddr4_mr2), 
  .reg_ddr4_mr3                (reg_ddr4_mr3), 
  .reg_ddr4_mr4                (reg_ddr4_mr4), 
  .reg_ddr4_mr5                (reg_ddr4_mr5), 
  .reg_ddr4_mr6                (reg_ddr4_mr6), 
  .reg_ddr3_mr0                (reg_ddr3_mr0), 
  .reg_ddr3_mr1                (reg_ddr3_mr1), 
  .reg_ddr3_mr2                (reg_ddr3_mr2), 
  .reg_ddr3_mr3                (reg_ddr3_mr3), 
  .reg_lpddr4_lpmr13           (reg_lpddr4_lpmr13), 
  .reg_lpddr4_lpmr16           (reg_lpddr4_lpmr16), 
  .reg_lpddr4_lpmr1_fs0        (reg_lpddr4_lpmr1_fs0), 
  .reg_lpddr4_lpmr1_fs1        (reg_lpddr4_lpmr1_fs1), 
  .reg_lpddr4_lpmr2_fs0        (reg_lpddr4_lpmr2_fs0), 
  .reg_lpddr4_lpmr2_fs1        (reg_lpddr4_lpmr2_fs1), 
  .reg_lpddr4_lpmr3_fs0        (reg_lpddr4_lpmr3_fs0), 
  .reg_lpddr4_lpmr3_fs1        (reg_lpddr4_lpmr3_fs1), 
  .reg_lpddr4_lpmr11_fs0       (reg_lpddr4_lpmr11_fs0), 
  .reg_lpddr4_lpmr11_fs1       (reg_lpddr4_lpmr11_fs1), 
  .reg_lpddr4_lpmr11_nt_fs0    (reg_lpddr4_lpmr11_nt_fs0), 
  .reg_lpddr4_lpmr11_nt_fs1    (reg_lpddr4_lpmr11_nt_fs1), 
  .reg_lpddr4_lpmr12_fs0       (reg_lpddr4_lpmr12_fs0), 
  .reg_lpddr4_lpmr12_fs1       (reg_lpddr4_lpmr12_fs1), 
  .reg_lpddr4_lpmr14_fs0       (reg_lpddr4_lpmr14_fs0), 
  .reg_lpddr4_lpmr14_fs1       (reg_lpddr4_lpmr14_fs1), 
  .reg_lpddr4_lpmr22_fs0       (reg_lpddr4_lpmr22_fs0), 
  .reg_lpddr4_lpmr22_fs1       (reg_lpddr4_lpmr22_fs1), 
  .reg_lpddr4_lpmr22_nt_fs0    (reg_lpddr4_lpmr22_nt_fs0), 
  .reg_lpddr4_lpmr22_nt_fs1    (reg_lpddr4_lpmr22_nt_fs1), 
  .reg_lpddr3_lpmr1            (reg_lpddr3_lpmr1), 
  .reg_lpddr3_lpmr2            (reg_lpddr3_lpmr2), 
  .reg_lpddr3_lpmr3            (reg_lpddr3_lpmr3), 
  .reg_lpddr3_lpmr10           (reg_lpddr3_lpmr10), 
  .reg_lpddr3_lpmr11           (reg_lpddr3_lpmr11), 
  .reg_lpddr3_lpmr16           (reg_lpddr3_lpmr16), 
  .reg_lpddr3_lpmr17           (reg_lpddr3_lpmr17), 
  .ddr4_mr4_t_cal              (reg_ddr_mr4_t_cal), 
  .dram_crc_dm                 (), 
  .dram_bl_enc                 (reg_dram_bl_enc), 
  .reg_ddr4_enable             (reg_ddr4_enable), 
  .reg_ddr3_enable             (reg_ddr3_enable), 
  .reg_lpddr4_enable           (reg_lpddr4_enable), 
  .reg_lpddr3_enable           (reg_lpddr3_enable), 
  .axi4lite_arvalid            (axi4lite_arvalid_rb), 
  .axi4lite_araddr             (axi4lite_araddr_rb), 
  .axi4lite_arready            (axi4lite_arready_rb), 
  .axi4lite_rready             (axi4lite_rready_rb), 
  .axi4lite_rvalid             (axi4lite_rvalid_rb), 
  .axi4lite_rdata              (axi4lite_rdata_rb), 
  .axi4lite_rresp              (axi4lite_rresp_rb), 
  .axi4lite_awvalid            (axi4lite_awvalid_rb), 
  .axi4lite_awaddr             (axi4lite_awaddr_rb), 
  .axi4lite_awready            (axi4lite_awready_rb), 
  .axi4lite_wvalid             (axi4lite_wvalid_rb), 
  .axi4lite_wdata              (axi4lite_wdata_rb), 
  .axi4lite_wready             (axi4lite_wready_rb), 
  .axi4lite_bready             (axi4lite_bready_rb), 
  .axi4lite_bvalid             (axi4lite_bvalid_rb), 
  .axi4lite_bresp              (axi4lite_bresp_rb), 
  .clk                         (clk), 
  .reset_n                     (reset_n), 
  .ptsr_upd                    (ptsr_upd), 
  .mupd_dqsdqcr_clr            (mupd_dqsdqcr_clr), 
  .user_cmd_wait_done_ch       (user_cmd_wait_done_ch), 
  .mpr_access_enable           (mpr_access_enable_ch0), 
  .mpr_rd_n_wr                 (mpr_rd_n_wr_ch0), 
  .mrr_enable                  (mrr_enable_ch), 
  .rddata_upd                  (rddata_upd), 
  .user_cmd_valid              (user_cmd_valid), 
  .reg_phy_init_done           (reg_phy_init_done)
); 

protocol_controller protocol_controller[DRAM_CHAN_NUM-1:0]( 
  .bank_ready_atomic_xq     (bank_ready_atomic_xq), 
  .bank_req_empty_mrr       (status_xqr_empty_ch), 
  .bist_complete            (bist_complete), 
  .brif_bank_occp           (brif_bank_occp_pc), 
  .brif_cas_info            (brif_cas_info_pc), 
  .brif_cas_rd              (brif_cas_rd_pc), 
  .brif_cas_valid           (brif_cas_valid_pc), 
  .brif_page_close          (brif_page_close_b), 
  .brif_page_keep           (brif_page_keep_b), 
  .brif_pre_valid           (brif_pre_valid_pc), 
  .brif_pri                 (brif_pri_b), 
  .brif_rank_addr_b         (brif_rank_addr_pc), 
  .brif_ras_valid           (brif_ras_valid_pc), 
  .brif_row_addr            (brif_row_addr_pc), 
  .brif_tagid               (brif_tagid_b), 
  .clk                      (clk), 
  .dfi_rddata               (dfi_rddata), 
  .dfi_rddata_valid         (dfi_rddata_valid), 
  .dram_cmd_mrr             (dram_cmd_mrr), 
  .dram_cmd_rd              (dram_cmd_rd), 
  .dram_cmd_rd_mrr          (dram_cmd_rd), 
  .dram_cmd_rdy             (dram_cmd_rdy), 
  .dram_cmd_wr              (dram_cmd_wr), 
  .dram_rvalid              (dram_rvalid), 
  .phy_dfien                (reg_pom_dfien), 
  .ptsr_nt_rank             (ptsr_nt_rank), 
  .rank_hold_ext            (rank_hold_ext), 
  .reg_auto_srx_zqcl        (reg_auto_srx_zqcl_mc), 
  .reg_channel_enable       (dram_chan_en), 
  .reg_ddr3_enable          (reg_ddr3_enable), 
  .reg_ddr3_mr0             (reg_ddr3_mr0), 
  .reg_ddr3_mr1             (reg_ddr3_mr1), 
  .reg_ddr3_mr2             (reg_ddr3_mr2), 
  .reg_ddr3_mr3             (reg_ddr3_mr3), 
  .reg_ddr4_enable          (reg_ddr4_enable), 
  .reg_ddr4_mr0             (reg_ddr4_mr0), 
  .reg_ddr4_mr1             (reg_ddr4_mr1), 
  .reg_ddr4_mr2             (reg_ddr4_mr2), 
  .reg_ddr4_mr3             (reg_ddr4_mr3), 
  .reg_ddr4_mr4             (reg_ddr4_mr4), 
  .reg_ddr4_mr4_rdpre       (reg_ddr4_mr4_rdpre), 
  .reg_ddr4_mr4_wrpre       (reg_ddr4_mr4_wrpre), 
  .reg_ddr4_mr5             (reg_ddr4_mr5), 
  .reg_ddr4_mr6             (reg_ddr4_mr6), 
  .reg_ddr_ref_otf          (reg_ddr_ref_otf), 
  .reg_dfi_freq_ratio       (reg_dfi_freq_ratio), 
  .reg_dram_bank_enable     (reg_dram_bank_enable), 
  .reg_dram_bl_enc          (reg_dram_bl_enc), 
  .reg_dram_rank_enable     (dram_rank_en), 
  .reg_lpddr3_enable        (reg_lpddr3_enable), 
  .reg_lpddr3_lpmr1         (reg_lpddr3_lpmr1), 
  .reg_lpddr3_lpmr10        (reg_lpddr3_lpmr10), 
  .reg_lpddr3_lpmr11        (reg_lpddr3_lpmr11), 
  .reg_lpddr3_lpmr16        (reg_lpddr3_lpmr16), 
  .reg_lpddr3_lpmr17        (reg_lpddr3_lpmr17), 
  .reg_lpddr3_lpmr2         (reg_lpddr3_lpmr2), 
  .reg_lpddr3_lpmr3         (reg_lpddr3_lpmr3), 
  .reg_lpddr4_enable        (reg_lpddr4_enable), 
  .reg_lpddr4_lpmr11_fs0    (reg_lpddr4_lpmr11_fs0), 
  .reg_lpddr4_lpmr11_fs1    (reg_lpddr4_lpmr11_fs1), 
  .reg_lpddr4_lpmr11_nt_fs0 (reg_lpddr4_lpmr11_nt_fs0), 
  .reg_lpddr4_lpmr11_nt_fs1 (reg_lpddr4_lpmr11_nt_fs1), 
  .reg_lpddr4_lpmr12_fs0    (reg_lpddr4_lpmr12_fs0), 
  .reg_lpddr4_lpmr12_fs1    (reg_lpddr4_lpmr12_fs1), 
  .reg_lpddr4_lpmr13        (reg_lpddr4_lpmr13), 
  .reg_lpddr4_lpmr14_fs0    (reg_lpddr4_lpmr14_fs0), 
  .reg_lpddr4_lpmr14_fs1    (reg_lpddr4_lpmr14_fs1), 
  .reg_lpddr4_lpmr16        (reg_lpddr4_lpmr16), 
  .reg_lpddr4_lpmr1_fs0     (reg_lpddr4_lpmr1_fs0), 
  .reg_lpddr4_lpmr1_fs1     (reg_lpddr4_lpmr1_fs1), 
  .reg_lpddr4_lpmr22_fs0    (reg_lpddr4_lpmr22_fs0), 
  .reg_lpddr4_lpmr22_fs1    (reg_lpddr4_lpmr22_fs1), 
  .reg_lpddr4_lpmr22_nt_fs0 (reg_lpddr4_lpmr22_nt_fs0), 
  .reg_lpddr4_lpmr22_nt_fs1 (reg_lpddr4_lpmr22_nt_fs1), 
  .reg_lpddr4_lpmr2_fs0     (reg_lpddr4_lpmr2_fs0), 
  .reg_lpddr4_lpmr2_fs1     (reg_lpddr4_lpmr2_fs1), 
  .reg_lpddr4_lpmr3_fs0     (reg_lpddr4_lpmr3_fs0), 
  .reg_lpddr4_lpmr3_fs1     (reg_lpddr4_lpmr3_fs1), 
  .reg_mpr_wrdata           (reg_mpr_wrdata), 
  .reg_pom_dfien            (reg_pom_dfien_pc), 
  .reg_pom_dqsdqen          (reg_pom_dqsdqen), 
  .reg_post_pull_en         (reg_post_pull_en), 
  .reg_ref_int_en           (reg_ref_int_en), 
  .reg_t_alrtp              (reg_t_alrtp_mc), 
  .reg_t_ccd_l              (reg_t_ccd_l_mc), 
  .reg_t_ccd_s              (reg_t_ccd_s_mc), 
  .reg_t_ccdwm              (reg_t_ccdwm_mc), 
  .reg_t_ckesr              (reg_t_ckesr_mc), 
  .reg_t_cmdcke             (reg_t_cmdcke_mc), 
  .reg_t_dllk               (reg_t_dllk_mc), 
  .reg_t_dpd                (reg_t_dpd_mc), 
  .reg_t_faw                (reg_t_faw_mc), 
  .reg_t_lvlresp            (reg_t_lvlresp_mc), 
  .reg_t_mod                (reg_t_mod_mc), 
  .reg_t_mped               (reg_t_mped_mc), 
  .reg_t_mprr               (reg_t_mprr_mc), 
  .reg_t_mpx                (reg_t_mpx_mc), 
  .reg_t_mrd                (reg_t_mrd), 
  .reg_t_mrr                (reg_t_mrr), 
  .reg_t_mrw                (reg_t_mrw), 
  .reg_t_osco               (reg_t_osco_mc), 
  .reg_t_pd                 (reg_t_pd_mc), 
  .reg_t_ppd                (reg_t_ppd_mc), 
  .reg_t_ras                (reg_t_ras_mc), 
  .reg_t_rc                 (reg_t_rc_mc), 
  .reg_t_rcd                (reg_t_rcd_mc), 
  .reg_t_rdpden             (reg_t_rdpden_mc), 
  .reg_t_refi               (reg_t_refi_mc), 
  .reg_t_rfc                (reg_t_rfc_mc), 
  .reg_t_rp                 (reg_t_rp_mc), 
  .reg_t_rrd_l              (reg_t_rrd_l_mc), 
  .reg_t_rrd_s              (reg_t_rrd_s_mc), 
  .reg_t_rtw                (reg_t_rtw_mc), 
  .reg_t_wlbr               (reg_t_wlbr_mc), 
  .reg_t_wlbtr              (reg_t_wlbtr_mc), 
  .reg_t_wr_mpr             (reg_t_wr_mpr_mc), 
  .reg_t_wrapden            (reg_t_wrapden_mc), 
  .reg_t_xmpdll             (reg_t_xmpdll_mc), 
  .reg_t_xp                 (reg_t_xp_mc), 
  .reg_t_xpdll              (reg_t_xpdll_mc), 
  .reg_t_xs                 (reg_t_xs_mc), 
  .reg_t_xsr                (reg_t_xsr_mc), 
  .reg_t_zqcal              (reg_t_zqcal_mc), 
  .reg_t_zqcl               (reg_t_zqcl_mc), 
  .reg_t_zqcs               (reg_t_zqcs_mc), 
  .reg_t_zqcs_itv           (reg_t_zqcs_itv_mc), 
  .reg_t_zqlat              (reg_t_zqlat_mc), 
  .reg_t_zqrs               (reg_t_zqrs_mc), 
  .reg_zq_auto_en           (reg_zq_auto_en), 
  .reset_n                  (reset_n), 
  .status_bank_idle_mrr     (status_bank_idle_mrr), 
  .user_cmd_chan_sel        (user_cmd_chan_sel), 
  .user_cmd_opcode          (user_cmd_opcode), 
  .user_cmd_rank            (user_cmd_rank), 
  .user_cmd_rank_sel        (user_cmd_rank_sel), 
  .user_cmd_valid           (user_cmd_valid), 
  .user_mr_select           (user_mr_select), 
  .user_mrs_last            (uci_mrs_last), 
  .xqr_enable_delay         (xqr_enable_delay), 
  .xqr_load                 (xqr_load), 
  .xqr_load_pc_mrr          (xqr_load_pc_mrr), 
  .xqr_route_hold           (xqr_route_hold), 
  .xqw_enable_delay         (xqw_enable_delay), 
  .xqw_load                 (xqw_load), 
  .xqw_route_hold           (xqw_route_hold), 
  .bank_ready_atomic_mrr    (bank_ready_atomic_mrr), 
  .bank_ready_enable        (bank_ready_enable_ch), 
  .bist_enable              (bist_enable), 
  .brif_bank_grant_ba       (), 
  .brif_bank_status_bg      (brif_bank_status_b), 
  .brif_cas_ready           (brif_cas_ready_b), 
  .brif_pre_ready           (brif_pre_ready_b), 
  .brif_ras_ready           (brif_ras_ready_b), 
  .cmden_reg_ucr            (cmden_reg_ucr), 
  .cmdop_reg_ucr            (cmdop_reg_ucr), 
  .dram_addr                (dram_addr), 
  .dram_bank                (dram_bank), 
  .dram_bg                  (dram_bg), 
  .dram_cke                 (dram_cke), 
  .dram_cmd                 (dram_cmd), 
  .dram_cs_n                (dram_cs_n), 
  .dram_odt                 (dram_odt), 
  .dram_rank_addr_rd        (dram_rank_addr_rd), 
  .dram_rank_addr_wr        (dram_rank_addr_wr), 
  .keep_dfien               (keep_dfien), 
  .mpr_access_done          (mpr_access_done_pc), 
  .mpr_access_enable        (mpr_access_enable_pc), 
  .mpr_rd_n_wr              (mpr_rd_n_wr_pc), 
  .mpr_readout              (mpr_readout_pc), 
  .mprw_mode_on             (mprw_mode_on), 
  .mrr_data                 (mrr_readout_ch), 
  .mrr_done                 (mrr_done_ch), 
  .mrr_enable               (mrr_enable_ch), 
  .phyop_en                 (phyop_en), 
  .ref_state_bist           (), 
  .status_bank_idle_array   (status_bank_idle_mrr), 
  .status_dram_idle_b       (status_bank_idle_ch), 
  .status_dram_pause        (status_dram_pause_ch), 
  .status_err_global_fsm    (status_int_gc_fsm_ch), 
  .status_xqr_empty         (status_xqr_empty_ch), 
  .status_xqr_full          (status_xqr_full_ch), 
  .status_xqw_empty         (status_xqw_empty_ch), 
  .status_xqw_full          (status_xqw_full_ch), 
  .user_cmd_ready           (user_cmd_ready_ch), 
  .user_cmd_wait_done       (user_cmd_wait_done_ch), 
  .xqif_rburst_last         (xqif_rburst_last), 
  .xqif_rdata_enable        (xqif_rdata_enable), 
  .xqif_rdata_last          (xqif_rdata_last), 
  .xqif_rdata_tag           (xqif_rdata_tag), 
  .xqif_rdata_valid         (xqif_rdata_valid), 
  .xqif_wburst_last         (xqif_wburst_last), 
  .xqif_wdata_enable        (xqif_wdata_enable), 
  .xqif_wdata_last          (xqif_wdata_last), 
  .xqif_wdata_tag           (xqif_wdata_tag), 
  .xqif_wdata_valid         (xqif_wdata_valid), 
  .xqif_wdata_valid_next    (xqif_wdata_valid_next), 
  .xqr_load_pc              (xqr_load_pc_mrr), 
  .xqr_route_busy           (xqr_route_busy_ch), 
  .xqw_route_busy           (xqw_route_busy_ch), 
  .zqcs_state_bist          ()
); 

dfi_bridge dfi_bridge[DRAM_CHAN_NUM-1:0]( 
  .clk                  (clk), 
  .dfi_rddata           (dfi_rddata), 
  .dfi_rddata_dbi_n     (dfi_rddata_dbi_n), 
  .dfi_rddata_valid     (dfi_rddata_valid), 
  .dmctl_dual_chan_en   (dmctl_dual_chan_en), 
  .dram_addr_pc         (dram_addr), 
  .dram_bank_pc         (dram_bank), 
  .dram_bg_pc           (dram_bg), 
  .dram_cke_pc          (dram_cke), 
  .dram_cmd_pc          (dram_cmd), 
  .dram_cs_n_pc         (dram_cs_n), 
  .dram_rank_addr_rd_pc (dram_rank_addr_rd), 
  .dram_rank_addr_wr_pc (dram_rank_addr_wr), 
  .dram_rdata_enable_pc (xqif_rdata_enable), 
  .dram_wdata_enable_pc (xqif_wdata_enable), 
  .dram_wdata_pc        (dram_wdata_pc), 
  .dram_wdata_valid_pc  (xqif_wdata_valid), 
  .dram_wstrb_pc        (dram_wstrb_pc), 
  .dti_data_byte_dis    (dti_data_byte_dis), 
  .mprw_mode_on         (mprw_mode_on), 
  .reg_ddr3_enable      (reg_ddr3_enable), 
  .reg_ddr4_enable      (reg_ddr4_enable), 
  .reg_ddr4_mr4_cal     (reg_ddr4_mr4_cal), 
  .reg_dfi_freq_ratio   (reg_dfi_freq_ratio), 
  .reg_dram_bl_enc      (reg_dram_bl_enc), 
  .reg_dual_rank        (dmctl_dual_rank_en), 
  .reg_lpddr3_enable    (reg_lpddr3_enable), 
  .reg_lpddr4_enable    (reg_lpddr4_enable), 
  .reg_mc_rd_dbi        (reg_rd_dbi_dfi), 
  .reg_mc_wr_crc        (reg_wr_crc_dfi), 
  .reg_mc_wr_dbi        (reg_wr_dbi_dfi), 
  .reg_odth4            (reg_t_odth4_mc), 
  .reg_odth8            (reg_t_odth8_mc), 
  .reg_t_phy_rdlat      (reg_t_phy_rdlat_mc), 
  .reg_t_rddata_en      (reg_t_rddata_en_mc), 
  .reg_t_wrdata_en      (reg_t_wrdata_en_mc), 
  .reset_n              (reset_n), 
  .dfi_act_n            (dfi_act_n), 
  .dfi_bank             (dfi_ba), 
  .dfi_bg               (), 
  .dfi_ca               (dfi_ca), 
  .dfi_ca_l             (dfi_ca_l), 
  .dfi_cke              (dfi_cke), 
  .dfi_cs_n             (dfi_cs_n), 
  .dfi_odt              (dfi_odt), 
  .dfi_parity           (), 
  .dfi_rank             (dfi_rank), 
  .dfi_rank_rd          (dfi_rank_rd), 
  .dfi_rank_wr          (dfi_rank_wr), 
  .dfi_rddata_en        (dfi_rddata_en), 
  .dfi_wrdata           (dfi_wrdata), 
  .dfi_wrdata_en        (dfi_wrdata_en), 
  .dfi_wrdata_mask      (dfi_wrdata_mask), 
  .dram_cmd_mrr         (dram_cmd_mrr), 
  .dram_cmd_rd          (dram_cmd_rd), 
  .dram_cmd_rdy         (dram_cmd_rdy), 
  .dram_cmd_wr          (dram_cmd_wr), 
  .dram_dmi             (dram_dmi), 
  .dram_rdata           (dram_rdata), 
  .dram_rvalid          (dram_rvalid), 
  .rank_hold_ext        (rank_hold_ext), 
  .xqr_load             (xqr_load), 
  .xqw_load             (xqw_load)
); 

`ifdef CFG_BIST_ENABLE
  // HDL Embedded Text Block 2 eb1
  // BIST
  assign brif_bank_occp_pc =                                        brif_bank_occp_b;
  assign brif_ras_valid_pc = (|bist_enable) ? brif_ras_valid_bist : brif_ras_valid_b;
  assign brif_rank_addr_pc = (|bist_enable) ? brif_rank_addr_bist  : brif_rank_addr_b;
  //assign brif_rank_addr_pc = brif_rank_addr_b;
  assign brif_row_addr_pc  = (|bist_enable) ? brif_row_addr_bist  : brif_row_addr_b;
  assign brif_cas_valid_pc = (|bist_enable) ? brif_cas_valid_bist : brif_cas_valid_b;
  assign brif_cas_info_pc  = (|bist_enable) ? brif_cas_info_bist  : brif_cas_info_b;
  assign brif_cas_rd_pc    = (|bist_enable) ? brif_cas_rd_bist    : brif_cas_rd_b;
  assign brif_pre_valid_pc = (|bist_enable) ? brif_pre_valid_bist : brif_pre_valid_b;
  assign dram_wdata_pc     = (|bist_enable) ? dram_wdata_bist     : dram_wdata;
  assign dram_wstrb_pc     = (|bist_enable) ? dram_wstrb_bist     : dram_wstrb;
  ddr_bist ddr_bist[DRAM_CHAN_NUM-1:0]( 
    .clk                   (clk), 
    .rst_n                 (reset_n), 
    .bist_run              (bist_enable), 
    .bist_error            (status_bist_error_ch), 
    .bist_endtest          (bist_complete), 
    .bist_start_rank       (reg_bist_start_rank_ch), 
    .bist_end_rank         (reg_bist_end_rank_ch), 
    .bist_start_bank       (reg_bist_start_bank_ch), 
    .bist_end_bank         (reg_bist_end_bank_ch), 
    .bist_start_background (reg_bist_start_background_ch), 
    .bist_end_background   (reg_bist_end_background_ch), 
    .bist_start_row        (reg_bist_start_row_ch), 
    .bist_end_row          (reg_bist_end_row_ch), 
    .bist_start_column     (reg_bist_start_col_ch), 
    .bist_end_column       (reg_bist_end_col_ch), 
    .bist_element          (reg_bist_element_ch), 
    .bist_operation        (reg_bist_operation_ch), 
    .bist_end_retention    (reg_bist_retention_ch), 
    .bist_march_element_0  (reg_bist_march_element_0_ch), 
    .bist_march_element_1  (reg_bist_march_element_1_ch), 
    .bist_march_element_2  (reg_bist_march_element_2_ch), 
    .bist_march_element_3  (reg_bist_march_element_3_ch), 
    .bist_march_element_4  (reg_bist_march_element_4_ch), 
    .bist_march_element_5  (reg_bist_march_element_5_ch), 
    .bist_march_element_6  (reg_bist_march_element_6_ch), 
    .bist_march_element_7  (reg_bist_march_element_7_ch), 
    .bist_march_element_8  (reg_bist_march_element_8_ch), 
    .bist_march_element_9  (reg_bist_march_element_9_ch), 
    .bist_march_element_10 (reg_bist_march_element_10_ch), 
    .bist_march_element_11 (reg_bist_march_element_11_ch), 
    .bist_march_element_12 (reg_bist_march_element_12_ch), 
    .bist_march_element_13 (reg_bist_march_element_13_ch), 
    .bist_march_element_14 (reg_bist_march_element_14_ch), 
    .bist_march_element_15 (reg_bist_march_element_15_ch), 
    .reg_size_max_rt       (reg_size_max_rt), 
    .reg_lpddr4_enable     (reg_lpddr4_enable), 
    .reg_dfi_freq_ratio    (reg_dfi_freq_ratio), 
    .dram_ras_ready        (brif_ras_ready_b), 
    .dram_cas_ready        (brif_cas_ready_b), 
    .dram_pre_ready        (brif_pre_ready_b), 
    .dram_write_en         (xqif_wdata_enable), 
    .dram_write_burst_last (xqif_wburst_last), 
    .dram_read_en          (xqif_rdata_valid), 
    .dram_read_burst_last  (xqif_rburst_last), 
    .dram_read_data        (dram_rdata), 
    .dram_write_data       (dram_wdata_bist), 
    .dram_write_strobe     (dram_wstrb_bist), 
    .dram_rank_addr        (brif_rank_addr_bist), 
    .dram_bank_occp        (brif_bank_occp_bist), 
    .dram_row_addr         (brif_row_addr_bist), 
    .dram_cas_info         (brif_cas_info_bist), 
    .dram_ras_valid        (brif_ras_valid_bist), 
    .dram_cas_valid        (brif_cas_valid_bist), 
    .dram_pre_valid        (brif_pre_valid_bist), 
    .dram_cas_rd           (brif_cas_rd_bist), 
    .diagnosis_en          (reg_bist_diagnosis_en_ch), 
    .bist_error_new        (status_bist_error_new_ch), 
    .dram_bank_fail        (status_bist_bank_fail_ch), 
    .dram_rank_fail        (status_bist_rank_fail_ch), 
    .dram_row_fail         (status_bist_row_fail_ch)
  ); 

`else
  // HDL Embedded Text Block 3 eb3
  // BIST
  assign brif_bank_occp_pc    = brif_bank_occp_b;
  assign brif_ras_valid_pc    = brif_ras_valid_b;
  assign brif_rank_addr_pc     = brif_rank_addr_b;
  assign brif_row_addr_pc     = brif_row_addr_b;
  assign brif_cas_valid_pc    = brif_cas_valid_b;
  assign brif_cas_info_pc     = brif_cas_info_b;
  assign brif_cas_rd_pc       = brif_cas_rd_b;
  assign brif_pre_valid_pc    = brif_pre_valid_b;
  assign dram_wdata_pc        = dram_wdata;
  assign dram_wstrb_pc        = dram_wstrb;
  assign status_bist_error_ch = 0;
  assign bist_complete        = {DRAM_CHAN_NUM{1'b1}};
  assign status_bist_error_new_ch = 0;
  assign status_bist_bank_fail_ch = 0;
  assign status_bist_row_fail_ch  = 0;
`endif

// HDL Embedded Text Block 1 eb2
//  Combinational Assignments
genvar ch_id, rt_id;
generate
  for (ch_id=0; ch_id < DRAM_CHAN_NUM; ch_id=ch_id+1) begin : PROC_CHAN
    assign xqr_route_busy_int[ch_id] = xqr_route_busy_ch[ch_id*DC_ROUTE_NUM +: DC_ROUTE_NUM];
    assign xqw_route_busy_int[ch_id] = xqw_route_busy_ch[ch_id*DC_ROUTE_NUM +: DC_ROUTE_NUM];
  end
endgenerate

generate
  for (rt_id=0; rt_id < DC_ROUTE_NUM; rt_id=rt_id+1) begin : PROC_ROUTE
    for (ch_id=0; ch_id < DRAM_CHAN_NUM; ch_id=ch_id+1) begin : PROC_ROUTE_CHAN
      assign xqr_route_busy_rt[rt_id][ch_id] = xqr_route_busy_int[ch_id][rt_id];
      assign xqw_route_busy_rt[rt_id][ch_id] = xqw_route_busy_int[ch_id][rt_id];
    end
    assign xqr_route_hold[rt_id] = |xqr_route_busy_rt[rt_id];
    assign xqw_route_hold[rt_id] = |xqw_route_busy_rt[rt_id];
  end
endgenerate

assign bank_ready_atomic_xq[1:0] = bank_ready_atomic_mrr[3:2];
assign bank_ready_atomic_xq[3:2] = bank_ready_atomic_mrr[1:0];

assign reg_mpr_wrdata         = user_cmd_mpr_data;
assign status_bist_endtest_ch = bist_complete;
// assign reg_lpmr1_rdpre        = reg_pos_ofs ? reg_lpmr1_fs1_rpre : reg_lpmr1_fs0_rpre;
// assign reg_lpmr1_wrpre        = reg_pos_ofs ? reg_lpmr1_fs1_wpre : reg_lpmr1_fs0_wpre;
assign reg_wr_crc_dfi     = reg_wr_crc & ddr4_mr2_wrcrc;
assign reg_wr_dbi_dfi         = reg_wr_dbi;
assign reg_rd_dbi_dfi         = reg_rd_dbi;

assign user_cmd_chan_sel  = user_cmd_chan;
assign user_cmd_rank_sel  = user_cmd_rank;
assign reg_rd_req_min_rb = {1'b0, reg_rd_req_min[6:0]};
assign reg_t_dqrpt = reg_t_dqrpt_rb[4:0];
assign reg_auto_srx_zqcl_mc = reg_auto_srx_zqcl_rb;
assign reg_t_ppd_mc         = reg_t_ppd_rb;
assign reg_t_odth4_mc       = reg_t_odth4_rb;
assign reg_t_odth8_mc       = reg_t_odth8_rb;
assign reg_t_caent          = reg_t_caent_rb        ;
assign reg_t_ckckeh         = reg_t_ckckeh_rb       ;
assign reg_t_ckehdqs        = reg_t_ckehdqs_rb      ;
assign reg_t_ckelck         = reg_t_ckelck_rb       ;
assign reg_t_ckfspe         = reg_t_ckfspe_rb       ;
assign reg_t_ckfspx         = reg_t_ckfspx_rb       ;
assign reg_t_dllen          = reg_t_dllen_rb        [ 7:0];
assign reg_t_dlllock        = reg_t_dlllock_rb      ;
assign reg_t_dllrst         = reg_t_dllrst_rb       [ 7:0];
assign reg_t_dqscke         = reg_t_dqscke_rb       ;
assign reg_t_dtrain         = reg_t_dtrain_rb       ;
assign reg_t_fc             = reg_t_fc_rb           ;
assign reg_t_init1          = reg_t_init1_rb        ;
assign reg_t_init3          = reg_t_init3_rb        ;
assign reg_t_init5          = reg_t_init5_rb        [ 21:0];
assign reg_t_lvlaa          = reg_t_lvlaa_rb        ;
assign reg_t_lvldis         = reg_t_lvldis_rb       ;
assign reg_t_lvldll         = reg_t_lvldll_rb       ;
assign reg_t_lvlexit        = reg_t_lvlexit_rb      ;
assign reg_t_lvlload        = reg_t_lvlload_rb      ;
assign reg_t_lvlresp        = reg_t_lvlresp_rb      [ 7:0];
assign reg_t_mpcwr          = reg_t_mpcwr_rb        [ 7:0];
assign reg_t_mpcwr2rd       = reg_t_mpcwr2rd_rb     ;
assign reg_t_mrd            = reg_t_mrd_rb          ;
assign reg_t_mrr            = reg_t_mrr_rb          ;
assign reg_t_mrs2act        = reg_t_mrs2act_rb      [ 7:0];
assign reg_t_mrs2lvlen      = reg_t_mrs2lvlen_rb    ;
assign reg_t_mrw            = reg_t_mrw_rb          ;
assign reg_t_odtup          = reg_t_odtup_rb        [ 7:0];
assign reg_t_osco           = reg_t_osco_rb         [ 6:0];
assign reg_t_rcd            = reg_t_rcd_rb          [ 7:0] + 4;
assign reg_t_rp             = reg_t_rp_rb           [ 7:0];
assign reg_t_vrcgdis        = reg_t_vrcgdis_rb      [ 7:0];
assign reg_t_vrcgen         = reg_t_vrcgen_rb       ;
assign reg_t_vreftimelong   = reg_t_vreftimelong_rb ;
assign reg_t_vreftimeshort  = reg_t_vreftimeshort_rb[ 7:0];
assign reg_t_zqcal          = reg_t_zqcal_rb        ;
assign reg_t_zqlat          = reg_t_zqlat_rb        [ 7:0];
assign reg_t_odth4          = reg_t_odth4_rb        ;
assign reg_t_odth8          = reg_t_odth8_rb        ;
assign reg_t_pori           = reg_t_pori_rb         ;
assign reg_t_rst            = reg_t_rst_rb          ;
assign reg_t_xpr            = reg_t_xpr_rb          ;
assign reg_t_zqinit         = reg_t_zqinit_rb       ;
assign reg_t_mod            = reg_t_mod_rb          ;
assign reg_t_zqcs_mc        = reg_t_zqcs_rb         ;
assign reg_t_dpd_mc         = reg_t_dpd_rb          [19:0];
assign reg_t_rrd_l_mc       = reg_t_rrd_rb          ;
assign reg_t_ccd_s_mc       = reg_t_ccd_s_rb        ;
assign reg_t_ccd_l_mc       = reg_t_ccd_rb          ;
assign reg_t_rrd_s_mc       = reg_t_rrd_s_rb        ;
assign reg_t_phy_rdlat_mc   = 0                     ;
assign reg_t_mod_mc         = reg_t_mod_rb          ;
assign reg_t_mprr_mc        = reg_t_mprr_rb         ;
assign reg_t_mped_mc        = reg_t_mped_rb         ;
assign reg_t_mpx_mc         = reg_t_mpx_rb          ;
assign reg_t_wr_mpr_mc      = reg_t_wr_mpr_rb       ;
assign reg_t_xpdll_mc       = reg_t_xpdll_rb        ;
assign reg_t_dllk_mc        = reg_t_dllk_rb         [MC_W_COUNTER_WIDTH-1  : 0];
assign reg_t_xmpdll_mc      = reg_t_xmpdll_rb       [MC_W_COUNTER_WIDTH-1  : 0];
assign reg_t_xs_mc          = reg_t_xs_rb           ;
assign reg_t_zqcl_mc        = reg_t_zqcl_rb         [MC_W_COUNTER_WIDTH-1  : 0];    

assign reg_t_alrtp_mc       = reg_t_alrtp_rb        [MC_COUNTER_WIDTH-1    : 0];

assign reg_t_ccdwm_mc       = reg_t_ccdwm_rb        [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_ckesr_mc       = reg_t_ckesr_rb        [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_cmdcke_mc      = reg_t_cmdcke_rb       [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_faw_mc         = reg_t_faw_rb          [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_osco_mc        = reg_t_osco_rb         [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_pd_mc          = reg_t_pd_rb           [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_ras_mc         = reg_t_ras_rb          [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_rc_mc          = reg_t_rc_rb           [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_rcd_mc         = reg_t_rcd_rb          [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_rdpden_mc      = reg_t_rdpden_rb       [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_refi_mc        = reg_t_refi_off_rb     [MC_W_COUNTER_WIDTH-1  : 0];
assign reg_t_rfc_mc         = reg_t_rfc_rb          [MC_W_COUNTER_WIDTH-1  : 0];
assign reg_t_rp_mc          = reg_t_rp_rb           [MC_COUNTER_WIDTH-1    : 0];

assign reg_t_rtw_mc         = reg_t_rtw_rb          [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_wlbr_mc        = reg_t_wlbr_rb         [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_wlbtr_mc       = reg_t_wlbtr_rb        [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_wrapden_mc     = reg_t_wrapden_rb      [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_xp_mc          = reg_t_xp_rb           [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_xsr_mc         = reg_t_xsr_rb          [MC_W_COUNTER_WIDTH-1  : 0];
assign reg_t_zqcs_itv_mc    = reg_t_zq_itv_rb       [MC_ZQ_COUNTER_WIDTH-1 : 0];
assign reg_t_zqcal_mc       = reg_t_zqcal_rb        [MC_W_COUNTER_WIDTH-1  : 0];
assign reg_t_zqlat_mc       = reg_t_zqlat_rb        [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_zqrs_mc        = reg_t_zqrs_rb         [MC_COUNTER_WIDTH-1    : 0];
assign reg_t_lvlresp_mc     = reg_t_lvlresp_rb      [MC_COUNTER_WIDTH-1    : 0];

assign mpr_readout_ch0       = mpr_readout_pc[7:0];
assign mpr_access_done_ch0   = mpr_access_done_pc[0];
assign mpr_access_enable_ch0 = mpr_access_enable_pc[0];
assign mpr_rd_n_wr_ch0       = mpr_rd_n_wr_pc[0];

always @(posedge clk, negedge reset_n) begin
  if (!reset_n) begin
    reg_pom_dfien_cld <= 0;
  end
  else begin
    reg_pom_dfien_cld <= reg_pom_dfien_rb;
  end
end
assign reg_pom_dfien        = reg_pom_dfien_cld | (|keep_dfien);

assign reg_pom_dfien_pc     = reg_pom_dfien_rb  | (|phyop_en);

assign reg_t_rddata_en_mc   = reg_pos_ofs ? (reg_rd_dbi_dfi ? {{(MC_COUNTER_WIDTH-7){1'b0}}, reg_rtgc_fs1_trdendbi + reg_ddr_mr4_t_cal} : {{(MC_COUNTER_WIDTH-6){1'b0}}, reg_rtgc_fs1_trden + reg_ddr_mr4_t_cal}) :
                                            (reg_rd_dbi_dfi ? {{(MC_COUNTER_WIDTH-7){1'b0}}, reg_rtgc_fs0_trdendbi + reg_ddr_mr4_t_cal} : {{(MC_COUNTER_WIDTH-6){1'b0}}, reg_rtgc_fs0_trden + reg_ddr_mr4_t_cal}) ;

assign reg_t_wrdata_en_mc   = reg_pos_ofs ? {{(MC_COUNTER_WIDTH-6){1'b0}}, reg_rtgc_fs1_twren + reg_ddr_mr4_t_cal} : {{(MC_COUNTER_WIDTH-6){1'b0}}, reg_rtgc_fs0_twren + reg_ddr_mr4_t_cal};

assign xqr_enable_delay_nxt = (reg_dfi_freq_ratio == 2'b10) ? reg_lpddr4_enable ? ((reg_t_rddata_en_mc + 3) >> 2) :  ((reg_t_rddata_en_mc) >> 2) : // 1:4
(reg_dfi_freq_ratio == 2'b01) ? (reg_lpddr4_enable ? (((reg_t_rddata_en_mc)     >> 1)+2):((reg_t_rddata_en_mc)     >> 1)) : // 1:2
                                                                reg_t_rddata_en_mc            ; // 1:1

assign xqw_enable_delay_nxt = (reg_dfi_freq_ratio == 2'b10) ? (reg_lpddr4_enable? ((reg_t_wrdata_en_mc - 1) >> 2) : ((reg_t_wrdata_en_mc - 4) >> 2)) : // 1:4
(reg_dfi_freq_ratio == 2'b01) ? (reg_lpddr4_enable ? (((reg_t_wrdata_en_mc -1) >> 1) + 1) : ((reg_t_wrdata_en_mc >> 1) -1)) : // 1:2
                                                                reg_t_wrdata_en_mc            ; // 1:1
always @(posedge clk, negedge reset_n) begin
  if (!reset_n) begin
    xqw_enable_delay <= 0;
    xqr_enable_delay <= 0;
  end
  else begin
    xqr_enable_delay <= xqr_enable_delay_nxt;
    xqw_enable_delay <= xqw_enable_delay_nxt;
  end
end
assign dram_rvalid_int = dram_rvalid & (~cmden_reg_ucr);
assign dram_rdata_ch0 = dram_rdata[0              +: RCB_DATA_WIDTH];
assign dram_rdata_ch1 = dram_rdata[RCB_DATA_WIDTH +: RCB_DATA_WIDTH];


assign dram_chan_en = dmctl_dual_chan_en ? 2'b11 : 2'b01;
assign dram_rank_en = dmctl_dual_rank_en ? 2'b11 : 2'b01;
always @(posedge clk, negedge reset_n) begin
  if (!reset_n) begin
    rvalid_index <= 0;
  end
  else if (~|dram_rvalid_int) begin
    rvalid_index <= 0;
  end
  else begin
    if (~|rvalid_index & reg_pbcr_lp_en) begin
      rvalid_index <= 2'b01;
    end
    else begin
      rvalid_index <= {rvalid_index[0], rvalid_index[1]};
    end
  end
end

always @(posedge clk, negedge reset_n) begin
  if (!reset_n) begin
    rddata_store <= 0;
  end
  else if (dram_rvalid_int[0]) begin // Read from channel A
    rddata_store <= {dram_rdata_ch0, rddata_store[RCB_DATA_WIDTH +: RCB_DATA_WIDTH]}; 
  end
  else if (dram_rvalid[1]) begin // Read from channel B
    rddata_store <= {dram_rdata_ch1, rddata_store[RCB_DATA_WIDTH +: RCB_DATA_WIDTH]}; 
  end
end
assign data_rddata = rddata_store;
assign rddata_upd  = rvalid_index[1];

endmodule // dynamo_core


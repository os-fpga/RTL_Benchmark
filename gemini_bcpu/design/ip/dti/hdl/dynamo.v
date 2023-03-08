//-----------------------------------------------------------------------------------------------------------
//    Copyright (C) 2020 by Dolphin Technology
//    All right reserved.
//
//    Copyright Notification
//    No part may be reproduced except as authorized by written permission.
//
//    Module dynamo_rps.dynamo.struct
//    Company: Dolphin Technology
//    Author: phuongnn0
//    Date: 12:02:14 - 08/18/22
//-----------------------------------------------------------------------------------------------------------
`include "dti_global_defines.vh"
module dynamo #(
  parameter DRAM_CHAN_NUM          = `CFG_DRAM_CHAN_NUM,
  parameter PHY_CTRL_WIDTH         = `CFG_PHY_CTRL_WIDTH,
  parameter PHY_SLICE_NUM          = `CFG_PHY_SLICE_NUM,
  parameter DFI_SLICE_WIDTH        = `CFG_DFI_SLICE_WIDTH,
  parameter AXI_PORT_NUM           = `CFG_AXI_PORT_NUM,
  parameter AXI4_ADDR_WIDTH        = `CFG_AXI4_ADDR_WIDTH,
  parameter AXI4_BURST_WIDTH       = `CFG_AXI4_BURST_WIDTH,
  parameter AXI4_CACHE_WIDTH       = `CFG_AXI4_CACHE_WIDTH,
  parameter AXI4_ID_WIDTH          = `CFG_AXI4_ID_WIDTH,
  parameter AXI4_LEN_WIDTH         = `CFG_AXI4_LEN_WIDTH,
  parameter AXI4_PROT_WIDTH        = `CFG_AXI4_PROT_WIDTH,
  parameter AXI4_QOS_WIDTH         = `CFG_AXI4_QOS_WIDTH,
  parameter AXI4_SIZE_WIDTH        = `CFG_AXI4_SIZE_WIDTH,
  parameter AXI4LITE_ADDR_WIDTH    = `CFG_AXI4LITE_ADDR_WIDTH,
  parameter AXI4LITE_DATA_WIDTH    = `CFG_AXI4LITE_DATA_WIDTH,
  parameter AXI4_MASTER_DATA_WIDTH = `CFG_AXI4_MASTER_DATA_WIDTH,
  parameter AXI4_MASTER_STRB_WIDTH = `CFG_AXI4_MASTER_STRB_WIDTH,
  parameter AXI4LITE_RESP_WIDTH    = `CFG_AXI4LITE_RESP_WIDTH,
  parameter AXI4_RESP_WIDTH        = `CFG_AXI4_RESP_WIDTH,
  parameter USER_CMDOP_WIDTH       = `CFG_USER_CMDOP_WIDTH,
  parameter CMDADDR_BUS            = `CFG_CMDADDR_BUS,
  parameter FREQUENCY_RATIO        = `CFG_FREQUENCY_RATIO,
  parameter DRAM_BA_WIDTH          = `CFG_DRAM_BA_WIDTH,
  parameter DRAM_LP3_CA_WIDTH      = `CFG_DRAM_LP3_CA_WIDTH,
  parameter DIMM_PER_CHAN          = `CFG_DIMM_PER_CHAN,
  parameter CHAN_RANK_NUM          = `CFG_CHAN_RANK_NUM,
  parameter DRAM_CTRL_WIDTH        = `CFG_DRAM_CTRL_WIDTH,
  parameter DRAM_RANK_WIDTH        = `CFG_DRAM_RANK_WIDTH,
  parameter DFI_DATA_WIDTH         = `CFG_DFI_DATA_WIDTH,
  parameter AXI4_DATA_WIDTH        = `CFG_AXI4_DATA_WIDTH,
  parameter LPDDR_MA_WIDTH         = `CFG_LPDDR_MA_WIDTH,
  parameter LPDDR_MR_OPCODE_WIDTH  = `CFG_LPDDR_MR_OPCODE_WIDTH,
  parameter MRR_DATA_WIDTH         = `CFG_MRR_DATA_WIDTH,
  parameter PHY_CA_WIDTH           = `CFG_PHY_CA_WIDTH,
  parameter PHY_CALVL_DLY_WIDTH    = `CFG_PHY_CALVL_DLY_WIDTH,
  parameter PHY_CSLVL_DLY_WIDTH    = `CFG_PHY_CSLVL_DLY_WIDTH,
  parameter PHY_WDM_DLY_WIDTH      = `CFG_PHY_WDM_DLY_WIDTH,
  parameter PHY_WDQ_DLY_WIDTH      = `CFG_PHY_WDQ_DLY_WIDTH,
  parameter PHY_GATE_DLY_WIDTH     = `CFG_PHY_GATE_DLY_WIDTH,
  parameter PHY_RDLVL_DLY_WIDTH    = `CFG_PHY_RDLVL_DLY_WIDTH,
  parameter PHY_VREF_WIDTH         = `CFG_PHY_VREF_WIDTH,
  parameter PHY_WRLVL_DLY_WIDTH    = `CFG_PHY_WRLVL_DLY_WIDTH,
  parameter DC_ROUTE_NUM           = `CFG_DC_ROUTE_NUM,
  parameter RCB_BUF_WIDTH          = `CFG_RCB_BUF_WIDTH,
  parameter RCB_ADDR_WIDTH         = `CFG_RCB_ADDR_WIDTH,
  parameter FREQ_RATIO_WIDTH       = `CFG_FREQ_RATIO_WIDTH,
  parameter DLL_BYPC_WIDTH         = `CFG_DLL_BYPC_WIDTH,
  parameter CLK_DLY_WIDTH          = `CFG_CLK_DLY_WIDTH,
  parameter DLL_LIM_WIDTH          = `CFG_DLL_LIM_WIDTH,
  parameter PHY_CMD_DLY_WIDTH      = `CFG_PHY_CMD_DLY_WIDTH,
  parameter SRAM_RWM_WIDTH         = `CFG_SRAM_RWM_WIDTH,
  parameter PHY_COUNTER_WIDTH      = `CFG_PHY_COUNTER_WIDTH,
  parameter ODT_COUNT_WIDTH        = `CFG_ODT_COUNT_WIDTH,
  parameter PHY_WIDE_COUNTER_WIDTH = `CFG_PHY_WIDE_COUNTER_WIDTH,
  parameter WCB_BUF_WIDTH          = `CFG_WCB_BUF_WIDTH,
  parameter WCB_ADDR_WIDTH         = `CFG_WCB_ADDR_WIDTH
)
( 
  // Port Declarations
  input   wire    [DRAM_CHAN_NUM-1:0]                            CLOCKDR_CLK, 
  input   wire    [PHY_CTRL_WIDTH-1:0]                           CLOCKDR_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                            CLOCKDR_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]          CLOCKDR_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                            CLOCKDR_DQS, 
  input   wire                                                   COMP_CLOCK, 
  input   wire                                                   COMP_RST_N, 
  input   wire    [PHY_SLICE_NUM-1:0]                            DTI_EXT_VREF, 
  input   wire                                                   DTI_MC_CLOCK, 
  input   wire                                                   DTI_PHY_CLOCK, 
  input   wire                                                   DTI_SYS_RESET_N, 
  input   wire    [DRAM_CHAN_NUM-1:0]                            JTAG_SI_CLK, 
  input   wire    [PHY_CTRL_WIDTH - 1:0]                         JTAG_SI_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                            JTAG_SI_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]          JTAG_SI_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                            JTAG_SI_DQS, 
  input   wire    [DRAM_CHAN_NUM-1:0]                            MODE_CLK, 
  input   wire    [PHY_CTRL_WIDTH-1:0]                           MODE_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                            MODE_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]          MODE_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                            MODE_DQS, 
  input   wire    [PHY_SLICE_NUM-1:0]                            MODE_I_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]          MODE_I_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                            MODE_I_DQS, 
  input   wire                                                   PAD_REF, 
  input   wire                                                   SE, 
  input   wire                                                   SE_CK, 
  input   wire    [DRAM_CHAN_NUM-1:0]                            SHIFTDR_CLK, 
  input   wire    [PHY_CTRL_WIDTH-1:0]                           SHIFTDR_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                            SHIFTDR_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]          SHIFTDR_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                            SHIFTDR_DQS, 
  input   wire    [DRAM_CHAN_NUM-1:0]                            SI_CLK, 
  input   wire    [PHY_CTRL_WIDTH - 1:0]                         SI_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                            SI_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]          SI_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                            SI_RD, 
  input   wire    [PHY_SLICE_NUM-1:0]                            SI_WR, 
  input   wire                                                   T_CGCTL_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                            T_CGCTL_DQ, 
  input   wire                                                   T_RCTL_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                            T_RCTL_DQ, 
  input   wire    [DRAM_CHAN_NUM-1:0]                            UPDATEDR_CLK, 
  input   wire    [PHY_CTRL_WIDTH-1:0]                           UPDATEDR_CTL, 
  input   wire    [PHY_SLICE_NUM-1:0]                            UPDATEDR_DM, 
  input   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]          UPDATEDR_DQ, 
  input   wire    [PHY_SLICE_NUM-1:0]                            UPDATEDR_DQS, 
  input   wire                                                   VDD, 
  input   wire                                                   VDDO, 
  input   wire                                                   VSS, 
  input   wire    [AXI_PORT_NUM - 1:0]                           aclk_p, 
  input   wire    [AXI_PORT_NUM * AXI4_ADDR_WIDTH - 1:0]         araddr_p, 
  input   wire    [AXI_PORT_NUM * AXI4_BURST_WIDTH - 1:0]        arburst_p, 
  input   wire    [AXI_PORT_NUM * AXI4_CACHE_WIDTH - 1:0]        arcache_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                           aresetn_p, 
  input   wire    [AXI_PORT_NUM * AXI4_ID_WIDTH - 1:0]           arid_p, 
  input   wire    [AXI_PORT_NUM * AXI4_LEN_WIDTH - 1:0]          arlen_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                           arlock_p, 
  input   wire    [AXI_PORT_NUM * AXI4_PROT_WIDTH - 1:0]         arprot_p, 
  input   wire    [AXI_PORT_NUM * AXI4_QOS_WIDTH - 1:0]          arqos_p, 
  input   wire    [AXI_PORT_NUM * AXI4_SIZE_WIDTH - 1:0]         arsize_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                           arvalid_p, 
  input   wire    [AXI_PORT_NUM * AXI4_ADDR_WIDTH - 1:0]         awaddr_p, 
  input   wire    [AXI_PORT_NUM * AXI4_BURST_WIDTH - 1:0]        awburst_p, 
  input   wire    [AXI_PORT_NUM * AXI4_CACHE_WIDTH - 1:0]        awcache_p, 
  input   wire    [AXI_PORT_NUM * AXI4_ID_WIDTH - 1:0]           awid_p, 
  input   wire    [AXI_PORT_NUM * AXI4_LEN_WIDTH - 1:0]          awlen_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                           awlock_p, 
  input   wire    [AXI_PORT_NUM * AXI4_PROT_WIDTH - 1:0]         awprot_p, 
  input   wire    [AXI_PORT_NUM * AXI4_QOS_WIDTH - 1:0]          awqos_p, 
  input   wire    [AXI_PORT_NUM * AXI4_SIZE_WIDTH - 1:0]         awsize_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                           awvalid_p, 
  input   wire    [AXI4LITE_ADDR_WIDTH - 1:0]                    axi4lite_araddr, 
  input   wire                                                   axi4lite_arvalid, 
  input   wire    [AXI4LITE_ADDR_WIDTH - 1:0]                    axi4lite_awaddr, 
  input   wire                                                   axi4lite_awvalid, 
  input   wire                                                   axi4lite_bready, 
  input   wire                                                   axi4lite_clk, 
  input   wire                                                   axi4lite_reset_n, 
  input   wire                                                   axi4lite_rready, 
  input   wire    [AXI4LITE_DATA_WIDTH - 1:0]                    axi4lite_wdata, 
  input   wire                                                   axi4lite_wvalid, 
  input   wire    [AXI_PORT_NUM - 1:0]                           bready_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                           rready_p, 
  input   wire    [AXI_PORT_NUM * AXI4_MASTER_DATA_WIDTH - 1:0]  wdata_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                           wlast_p, 
  input   wire    [AXI_PORT_NUM * AXI4_MASTER_STRB_WIDTH - 1:0]  wstrb_p, 
  input   wire    [AXI_PORT_NUM - 1:0]                           wvalid_p, 
  output  wire    [DRAM_CHAN_NUM-1:0]                            JTAG_SO_CLK, 
  output  wire    [PHY_CTRL_WIDTH - 1:0]                         JTAG_SO_CTL, 
  output  wire    [PHY_SLICE_NUM-1:0]                            JTAG_SO_DM, 
  output  wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]          JTAG_SO_DQ, 
  output  wire    [PHY_SLICE_NUM-1:0]                            JTAG_SO_DQS, 
  output  wire    [1:0]                                          PAD_MEM_CLK, 
  output  wire    [1:0]                                          PAD_MEM_CLK_N, 
  output  wire    [PHY_CTRL_WIDTH - 1:0]                         PAD_MEM_CTL, 
  output  wire    [DRAM_CHAN_NUM-1:0]                            SO_CLK, 
  output  wire    [PHY_CTRL_WIDTH - 1:0]                         SO_CTL, 
  output  wire    [PHY_SLICE_NUM-1:0]                            SO_DM, 
  output  wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]          SO_DQ, 
  output  wire    [PHY_SLICE_NUM-1:0]                            SO_RD, 
  output  wire    [PHY_SLICE_NUM-1:0]                            SO_WR, 
  output  wire    [DRAM_CHAN_NUM-1:0]                            YC_CLK, 
  output  wire    [PHY_CTRL_WIDTH - 1:0]                         YC_CTL, 
  output  wire    [PHY_SLICE_NUM-1:0]                            Y_DM, 
  output  wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH - 1:0]          Y_DQ, 
  output  wire    [PHY_SLICE_NUM-1:0]                            Y_DQS, 
  output  wire    [AXI_PORT_NUM - 1:0]                           arready_p, 
  output  wire    [AXI_PORT_NUM - 1:0]                           awready_p, 
  output  wire                                                   axi4lite_arready, 
  output  wire                                                   axi4lite_awready, 
  output  wire    [AXI4LITE_RESP_WIDTH - 1:0]                    axi4lite_bresp, 
  output  wire                                                   axi4lite_bvalid, 
  output  wire    [AXI4LITE_DATA_WIDTH  - 1:0]                   axi4lite_rdata, 
  output  wire    [AXI4LITE_RESP_WIDTH - 1:0]                    axi4lite_rresp, 
  output  wire                                                   axi4lite_rvalid, 
  output  wire                                                   axi4lite_wready, 
  output  wire    [AXI_PORT_NUM * AXI4_ID_WIDTH - 1:0]           bid_p, 
  output  wire    [AXI_PORT_NUM * AXI4_RESP_WIDTH - 1:0]         bresp_p, 
  output  wire    [AXI_PORT_NUM - 1:0]                           bvalid_p, 
  output  wire    [DRAM_CHAN_NUM - 1:0]                          int_gc_fsm, 
  output  wire    [AXI_PORT_NUM * AXI4_MASTER_DATA_WIDTH - 1:0]  rdata_p, 
  output  wire    [AXI_PORT_NUM * AXI4_ID_WIDTH - 1:0]           rid_p, 
  output  wire    [AXI_PORT_NUM - 1:0]                           rlast_p, 
  output  wire    [AXI_PORT_NUM * AXI4_RESP_WIDTH - 1:0]         rresp_p, 
  output  wire    [AXI_PORT_NUM - 1:0]                           rvalid_p, 
  output  wire    [AXI_PORT_NUM - 1:0]                           wready_p, 
  inout   wire                                                   PAD_COMP, 
  inout   wire    [PHY_SLICE_NUM-1:0]                            PAD_MEM_DM, 
  inout   wire    [PHY_SLICE_NUM*DFI_SLICE_WIDTH-1:0]            PAD_MEM_DQ, 
  inout   wire    [PHY_SLICE_NUM-1:0]                            PAD_MEM_DQS, 
  inout   wire    [PHY_SLICE_NUM-1:0]                            PAD_MEM_DQS_N, 
  inout   wire                                                   PAD_VREF
);

`include "dti_global_params.vh"
// Internal Declarations


// Local declarations

// Internal signal declarations
wire  [DRAM_CHAN_NUM * FREQUENCY_RATIO - 1:0]                                 DTI_RESET_N_MC;
wire  [19:0]                                                                  calvlpa_pattern_a;
wire  [19:0]                                                                  calvlpa_pattern_b;
wire  [DRAM_CHAN_NUM * CMDADDR_BUS*FREQUENCY_RATIO-1:0]                       dfi_act_n;
wire  [DRAM_CHAN_NUM * CMDADDR_BUS*FREQUENCY_RATIO*DRAM_BA_WIDTH-1:0]         dfi_ba;
wire  [DRAM_CHAN_NUM * CMDADDR_BUS*FREQUENCY_RATIO*PHY_CA_WIDTH-1:0]          dfi_ca;
wire  [DRAM_CHAN_NUM * CMDADDR_BUS*FREQUENCY_RATIO*DRAM_LP3_CA_WIDTH -1:0]    dfi_ca_l;
wire  [DRAM_CHAN_NUM * DIMM_PER_CHAN*FREQUENCY_RATIO*CHAN_RANK_NUM-1:0]       dfi_cke;
wire  [DRAM_CHAN_NUM * FREQUENCY_RATIO * CHAN_RANK_NUM - 1:0]                 dfi_cs_n;
wire  [1:0]                                                                   dfi_freq_ratio;
wire  [DRAM_CHAN_NUM * DIMM_PER_CHAN*FREQUENCY_RATIO*DRAM_CTRL_WIDTH-1:0]     dfi_odt;
wire  [DRAM_CHAN_NUM*FREQUENCY_RATIO - 1:0]                                   dfi_rank;
wire  [DRAM_CHAN_NUM*FREQUENCY_RATIO*DRAM_RANK_WIDTH-1:0]                     dfi_rank_rd;
wire  [DRAM_CHAN_NUM*FREQUENCY_RATIO*DRAM_RANK_WIDTH-1:0]                     dfi_rank_wr;
wire  [DRAM_CHAN_NUM * FREQUENCY_RATIO * 2 * DFI_DATA_WIDTH - 1:0]            dfi_rddata;
wire  [DRAM_CHAN_NUM * FREQUENCY_RATIO * 2 * DFI_DATA_WIDTH / 8 - 1:0]        dfi_rddata_dbi_n;
wire  [DRAM_CHAN_NUM*FREQUENCY_RATIO - 1:0]                                   dfi_rddata_en;
wire  [DRAM_CHAN_NUM*FREQUENCY_RATIO - 1:0]                                   dfi_rddata_valid;
wire  [DRAM_CHAN_NUM * AXI4_DATA_WIDTH - 1:0]                                 dfi_wrdata;
wire  [DRAM_CHAN_NUM*FREQUENCY_RATIO - 1:0]                                   dfi_wrdata_en;
wire  [DRAM_CHAN_NUM * AXI4_DATA_WIDTH/8 - 1:0]                               dfi_wrdata_mask;
wire                                                                          dmcfg_dqs2cken;
wire                                                                          dqsdqcr_dir;
wire  [7:0]                                                                   dqsdqcr_dlymax;
wire  [7:0]                                                                   dqsdqcr_dlyoffs;
wire  [3:0]                                                                   dqsdqcr_dqsel;
wire  [2:0]                                                                   dqsdqcr_mpcrpt;
wire                                                                          dqsdqcr_mupd;
wire  [1:0]                                                                   dqsdqcr_rank;
wire  [3:0]                                                                   dti_data_byte_dis;
wire                                                                          dti_dram_clk_dis;
wire                                                                          lpddr4_lpmr12_fs0_vrefcar;
wire  [5:0]                                                                   lpddr4_lpmr12_fs0_vrefcas;
wire                                                                          lpddr4_lpmr12_fs1_vrefcar;
wire  [5:0]                                                                   lpddr4_lpmr12_fs1_vrefcas;
wire                                                                          lpddr4_lpmr14_fs0_vrefdqr;
wire  [5:0]                                                                   lpddr4_lpmr14_fs0_vrefdqs;
wire                                                                          lpddr4_lpmr14_fs1_vrefdqr;
wire  [5:0]                                                                   lpddr4_lpmr14_fs1_vrefdqs;
wire                                                                          mupd_dqsdqcr_clr;
wire  [DRAM_CHAN_NUM-1:0]                                                     phyop_en;
wire  [CHAN_RANK_NUM*DRAM_CHAN_NUM*PHY_CA_WIDTH*PHY_CALVL_DLY_WIDTH - 1:0]    ptsr_ca_ip;
wire  [CHAN_RANK_NUM*DRAM_CHAN_NUM*PHY_CSLVL_DLY_WIDTH - 1:0]                 ptsr_cs_ip;
wire  [CHAN_RANK_NUM*PHY_SLICE_NUM*PHY_WDM_DLY_WIDTH-1:0]                     ptsr_dqsdm_ip;
wire  [CHAN_RANK_NUM*PHY_SLICE_NUM*DFI_SLICE_WIDTH*PHY_WDQ_DLY_WIDTH-1:0]     ptsr_dqsdq_ip;
wire  [CHAN_RANK_NUM*PHY_SLICE_NUM-1:0]                                       ptsr_dqsleadck_ip;
wire  [CHAN_RANK_NUM*PHY_SLICE_NUM*PHY_GATE_DLY_WIDTH-1:0]                    ptsr_gt_ip;
wire                                                                          ptsr_nt_rank;
wire                                                                          ptsr_nt_rank_ip;
wire  [CHAN_RANK_NUM*PHY_SLICE_NUM-1:0]                                       ptsr_psck_ip;
wire  [CHAN_RANK_NUM*PHY_SLICE_NUM*PHY_RDLVL_DLY_WIDTH - 1:0]                 ptsr_rdlvldm_ip;
wire  [CHAN_RANK_NUM*PHY_SLICE_NUM*DFI_SLICE_WIDTH*PHY_RDLVL_DLY_WIDTH - 1:0] ptsr_rdlvldq_ip;
wire                                                                          ptsr_upd;
wire  [CHAN_RANK_NUM-1:0]                                                     ptsr_vrefcar_ip;
wire  [CHAN_RANK_NUM*PHY_VREF_WIDTH-1:0]                                      ptsr_vrefcas_ip;
wire  [PHY_SLICE_NUM * PHY_VREF_WIDTH - 1:0]                                  ptsr_vrefdqrd_ip;
wire                                                                          ptsr_vrefdqrdr_ip;
wire  [1:0]                                                                   ptsr_vrefdqwrr_ip;
wire  [11:0]                                                                  ptsr_vrefdqwrs_ip;
wire  [CHAN_RANK_NUM*PHY_SLICE_NUM*PHY_WRLVL_DLY_WIDTH - 1:0]                 ptsr_wrlvl_ip;
wire  [DC_ROUTE_NUM * RCB_BUF_WIDTH - 1:0]                                    rcb_di_bf;
wire  [DC_ROUTE_NUM * RCB_BUF_WIDTH - 1:0]                                    rcb_do_bf;
wire  [DC_ROUTE_NUM * RCB_ADDR_WIDTH - 1:0]                                   rcb_ra_bf;
wire  [DC_ROUTE_NUM - 1:0]                                                    rcb_re_n_bf;
wire  [DC_ROUTE_NUM * RCB_ADDR_WIDTH - 1:0]                                   rcb_wa_bf;
wire  [DC_ROUTE_NUM - 1:0]                                                    rcb_we_n_bf;
wire  [1:0]                                                                   reg_adft_tst_en_ca;
wire  [3:0]                                                                   reg_adft_tst_en_dq;
wire  [1:0]                                                                   reg_cior_cmos_en;
wire  [5:0]                                                                   reg_cior_drvsel;
wire  [1:0]                                                                   reg_cior_odis_clk;
wire  [29:0]                                                                  reg_cior_odis_ctl;
wire                                                                          reg_ddr3_enable;
wire  [17:0]                                                                  reg_ddr3_mr0;
wire  [17:0]                                                                  reg_ddr3_mr1;
wire  [17:0]                                                                  reg_ddr3_mr2;
wire  [17:0]                                                                  reg_ddr3_mr3;
wire                                                                          reg_ddr4_enable;
wire  [17:0]                                                                  reg_ddr4_mr0;
wire  [17:0]                                                                  reg_ddr4_mr1;
wire  [17:0]                                                                  reg_ddr4_mr2;
wire  [17:0]                                                                  reg_ddr4_mr3;
wire  [17:0]                                                                  reg_ddr4_mr4;
wire  [17:0]                                                                  reg_ddr4_mr5;
wire  [17:0]                                                                  reg_ddr4_mr6;
wire  [PHY_VREF_WIDTH - 1:0]                                                  reg_ddr4_mr6_vrefdq;
wire                                                                          reg_ddr4_mr6_vrefdqr;
wire  [FREQ_RATIO_WIDTH - 1:0]                                                reg_dfi_freq_ratio;
wire  [PHY_SLICE_NUM-1:0]                                                     reg_dior_cmos_en;
wire  [PHY_SLICE_NUM*3-1:0]                                                   reg_dior_drvsel;
wire  [PHY_SLICE_NUM-1:0]                                                     reg_dior_fena_rcv;
wire  [PHY_SLICE_NUM-1:0]                                                     reg_dior_odis_dm;
wire  [PHY_SLICE_NUM*8-1:0]                                                   reg_dior_odis_dq;
wire  [PHY_SLICE_NUM-1:0]                                                     reg_dior_odis_dqs;
wire  [PHY_SLICE_NUM-1:0]                                                     reg_dior_rtt_en;
wire  [PHY_SLICE_NUM*3-1:0]                                                   reg_dior_rtt_sel;
wire  [DRAM_CHAN_NUM-1:0]                                                     reg_dllca_byp;
wire  [DRAM_CHAN_NUM*DLL_BYPC_WIDTH-1:0]                                      reg_dllca_bypc;
wire  [DRAM_CHAN_NUM*CLK_DLY_WIDTH - 1:0]                                     reg_dllca_clkdly;
wire  [DRAM_CHAN_NUM-1:0]                                                     reg_dllca_en;
wire  [DRAM_CHAN_NUM*DLL_LIM_WIDTH-1:0]                                       reg_dllca_limit;
wire  [1:0]                                                                   reg_dllca_lock;
wire  [1:0]                                                                   reg_dllca_ovfl;
wire  [1:0]                                                                   reg_dllca_unfl;
wire  [DRAM_CHAN_NUM-1:0]                                                     reg_dllca_upd;
wire  [PHY_SLICE_NUM-1:0]                                                     reg_dlldq_byp;
wire  [PHY_SLICE_NUM*8-1:0]                                                   reg_dlldq_bypc;
wire  [PHY_SLICE_NUM-1:0]                                                     reg_dlldq_en;
wire  [PHY_SLICE_NUM*5-1:0]                                                   reg_dlldq_limit;
wire  [3:0]                                                                   reg_dlldq_lock;
wire  [3:0]                                                                   reg_dlldq_ovfl;
wire  [3:0]                                                                   reg_dlldq_unfl;
wire  [PHY_SLICE_NUM-1:0]                                                     reg_dlldq_upd;
wire                                                                          reg_dual_chan_en;
wire                                                                          reg_dual_rank_en;
wire                                                                          reg_lpddr3_enable;
wire  [7:0]                                                                   reg_lpddr3_lpmr1;
wire  [7:0]                                                                   reg_lpddr3_lpmr10;
wire  [7:0]                                                                   reg_lpddr3_lpmr11;
wire  [7:0]                                                                   reg_lpddr3_lpmr16;
wire  [7:0]                                                                   reg_lpddr3_lpmr17;
wire  [7:0]                                                                   reg_lpddr3_lpmr2;
wire  [7:0]                                                                   reg_lpddr3_lpmr3;
wire                                                                          reg_lpddr4_enable;
wire  [7:0]                                                                   reg_lpddr4_lpmr11_fs0;
wire  [7:0]                                                                   reg_lpddr4_lpmr11_fs1;
wire  [MRR_DATA_WIDTH - 1:0]                                                  reg_lpddr4_lpmr11_nt_fs0;
wire  [MRR_DATA_WIDTH - 1:0]                                                  reg_lpddr4_lpmr11_nt_fs1;
wire  [7:0]                                                                   reg_lpddr4_lpmr12_fs0;
wire  [7:0]                                                                   reg_lpddr4_lpmr12_fs1;
wire  [7:0]                                                                   reg_lpddr4_lpmr13;
wire  [7:0]                                                                   reg_lpddr4_lpmr14_fs0;
wire  [7:0]                                                                   reg_lpddr4_lpmr14_fs1;
wire  [7:0]                                                                   reg_lpddr4_lpmr16;
wire  [7:0]                                                                   reg_lpddr4_lpmr1_fs0;
wire  [7:0]                                                                   reg_lpddr4_lpmr1_fs1;
wire  [7:0]                                                                   reg_lpddr4_lpmr22_fs0;
wire  [7:0]                                                                   reg_lpddr4_lpmr22_fs1;
wire  [MRR_DATA_WIDTH - 1:0]                                                  reg_lpddr4_lpmr22_nt_fs0;
wire  [MRR_DATA_WIDTH - 1:0]                                                  reg_lpddr4_lpmr22_nt_fs1;
wire  [7:0]                                                                   reg_lpddr4_lpmr2_fs0;
wire  [7:0]                                                                   reg_lpddr4_lpmr2_fs1;
wire  [7:0]                                                                   reg_lpddr4_lpmr3_fs0;
wire  [7:0]                                                                   reg_lpddr4_lpmr3_fs1;
wire                                                                          reg_mc_rd_dbi;
wire  [1:0]                                                                   reg_outbypen_clk;
wire  [29:0]                                                                  reg_outbypen_ctl;
wire  [3:0]                                                                   reg_outbypen_dm;
wire  [31:0]                                                                  reg_outbypen_dq;
wire  [3:0]                                                                   reg_outbypen_dqs;
wire  [1:0]                                                                   reg_outd_clk;
wire  [29:0]                                                                  reg_outd_ctl;
wire  [3:0]                                                                   reg_outd_dm;
wire  [31:0]                                                                  reg_outd_dq;
wire  [3:0]                                                                   reg_outd_dqs;
wire                                                                          reg_pbcr_bist_en;
wire                                                                          reg_pbcr_bist_start;
wire                                                                          reg_pbcr_lp_en;
wire  [1:0]                                                                   reg_pbcr_vrefenca;
wire  [11:0]                                                                  reg_pbcr_vrefsetca;
wire                                                                          reg_pbsr_bist_done;
wire  [29:0]                                                                  reg_pbsr_bist_err_ctl;
wire  [3:0]                                                                   reg_pbsr_bist_err_dm;
wire  [31:0]                                                                  reg_pbsr_bist_err_dq;
wire  [3:0]                                                                   reg_pccr_byp_n;
wire  [3:0]                                                                   reg_pccr_byp_p;
wire                                                                          reg_pccr_bypen;
wire                                                                          reg_pccr_en;
wire  [10:0]                                                                  reg_pccr_initcnt;
wire                                                                          reg_pccr_mvg;
wire                                                                          reg_pccr_srst;
wire                                                                          reg_pccr_tpaden;
wire                                                                          reg_pccr_upd;
wire  [3:0]                                                                   reg_pcsr_nbc;
wire  [3:0]                                                                   reg_pcsr_pbc;
wire                                                                          reg_pcsr_srstc;
wire                                                                          reg_pcsr_updc;
wire  [DRAM_CHAN_NUM  - 1:0]                                                  reg_pom_chanen;
wire                                                                          reg_pom_clklocken;
wire                                                                          reg_pom_cmddlyen;
wire  [2:0]                                                                   reg_pom_ddrt;
wire                                                                          reg_pom_dfien;
wire                                                                          reg_pom_dllrsten;
wire                                                                          reg_pom_dlyevalen;
wire                                                                          reg_pom_dqsdqen;
wire                                                                          reg_pom_draminiten;
wire                                                                          reg_pom_fs;
wire                                                                          reg_pom_gten;
wire                                                                          reg_pom_odt;
wire                                                                          reg_pom_phyfsen;
wire                                                                          reg_pom_phyinit;
wire                                                                          reg_pom_physeten;
wire                                                                          reg_pom_proc;
wire  [CHAN_RANK_NUM - 1:0]                                                   reg_pom_ranken;
wire                                                                          reg_pom_rdlvlen;
wire                                                                          reg_pom_sanchken;
wire                                                                          reg_pom_vrefcaen;
wire                                                                          reg_pom_vrefdqrden;
wire                                                                          reg_pom_vrefdqwren;
wire                                                                          reg_pom_wrlvlen;
wire                                                                          reg_pos_clklockc;
wire                                                                          reg_pos_cmddlyc;
wire                                                                          reg_pos_dllrstc;
wire  [1:0]                                                                   reg_pos_dlyevalc;
wire  [CHAN_RANK_NUM - 1:0]                                                   reg_pos_dqsdqc;
wire                                                                          reg_pos_draminitc;
wire                                                                          reg_pos_fs0req;
wire                                                                          reg_pos_fs1req;
wire  [CHAN_RANK_NUM -1:0]                                                    reg_pos_gtc;
wire                                                                          reg_pos_ofs;
wire                                                                          reg_pos_phyfsc;
wire                                                                          reg_pos_phyinitc;
wire                                                                          reg_pos_physetc;
wire  [CHAN_RANK_NUM-1:0]                                                     reg_pos_rdlvlc;
wire  [CHAN_RANK_NUM-1:0]                                                     reg_pos_sanchkc;
wire                                                                          reg_pos_vrefcac;
wire                                                                          reg_pos_vrefdqrdc;
wire  [CHAN_RANK_NUM -1:0]                                                    reg_pos_vrefdqwrc;
wire  [CHAN_RANK_NUM-1:0]                                                     reg_pos_wrlvlc;
wire  [3:0]                                                                   reg_ptar_ba;
wire  [10:0]                                                                  reg_ptar_col;
wire  [16:0]                                                                  reg_ptar_row;
wire  [5:0]                                                                   reg_pts_dllerr;
wire  [7:0]                                                                   reg_pts_dqsdmerr;
wire  [63:0]                                                                  reg_pts_dqsdqerr;
wire  [7:0]                                                                   reg_pts_gterr;
wire  [3:0]                                                                   reg_pts_lp3calvlerr;
wire  [7:0]                                                                   reg_pts_rdlvldmerr;
wire  [63:0]                                                                  reg_pts_rdlvldqerr;
wire  [7:0]                                                                   reg_pts_sanchkerr;
wire  [3:0]                                                                   reg_pts_vrefcaerr;
wire  [7:0]                                                                   reg_pts_vrefdqrderr;
wire  [7:0]                                                                   reg_pts_vrefdqwrerr;
wire  [7:0]                                                                   reg_pts_wrlvlerr;
wire  [27:0]                                                                  reg_ptsr_actn;
wire  [111:0]                                                                 reg_ptsr_ba;
wire  [531:0]                                                                 reg_ptsr_ca;
wire  [27:0]                                                                  reg_ptsr_cke;
wire  [27:0]                                                                  reg_ptsr_cs;
wire  [63:0]                                                                  reg_ptsr_dqsdm;
wire  [511:0]                                                                 reg_ptsr_dqsdq;
wire  [7:0]                                                                   reg_ptsr_dqsleadck;
wire  [47:0]                                                                  reg_ptsr_gt;
wire  [DRAM_CHAN_NUM*PHY_CMD_DLY_WIDTH-1:0]                                   reg_ptsr_odt;
wire  [7:0]                                                                   reg_ptsr_psck;
wire  [63:0]                                                                  reg_ptsr_rdlvldm;
wire  [511:0]                                                                 reg_ptsr_rdlvldq;
wire  [13:0]                                                                  reg_ptsr_rstn;
wire  [15:0]                                                                  reg_ptsr_sanpat;
wire  [1:0]                                                                   reg_ptsr_vrefcar;
wire  [11:0]                                                                  reg_ptsr_vrefcas;
wire  [23:0]                                                                  reg_ptsr_vrefdqrd;
wire                                                                          reg_ptsr_vrefdqrdr;
wire  [1:0]                                                                   reg_ptsr_vrefdqwrr;
wire  [11:0]                                                                  reg_ptsr_vrefdqwrs;
wire  [63:0]                                                                  reg_ptsr_wrlvl;
wire  [SRAM_RWM_WIDTH - 1:0]                                                  reg_rcb_t_rwm              = 3'b111;
wire  [5:0]                                                                   reg_rtgc_fs0_trden;
wire  [6:0]                                                                   reg_rtgc_fs0_trdendbi;
wire  [5:0]                                                                   reg_rtgc_fs0_twren;
wire  [5:0]                                                                   reg_rtgc_fs1_trden;
wire  [6:0]                                                                   reg_rtgc_fs1_trdendbi;
wire  [5:0]                                                                   reg_rtgc_fs1_twren;
wire                                                                          reg_rtgc_gt_dis;
wire                                                                          reg_rtgc_gt_updt;
wire  [21:0]                                                                  reg_t_caent;
wire  [PHY_COUNTER_WIDTH - 1:0]                                               reg_t_calvl_max;
wire  [PHY_COUNTER_WIDTH-1:0]                                                 reg_t_calvladrckeh;
wire  [PHY_COUNTER_WIDTH-1:0]                                                 reg_t_calvlcap;
wire  [PHY_COUNTER_WIDTH-1:0]                                                 reg_t_calvlcc;
wire  [PHY_COUNTER_WIDTH-1:0]                                                 reg_t_calvlen;
wire  [PHY_COUNTER_WIDTH-1:0]                                                 reg_t_calvlext;
wire  [7:0]                                                                   reg_t_ckckeh;
wire  [7:0]                                                                   reg_t_ckehdqs;
wire  [7:0]                                                                   reg_t_ckelck;
wire  [7:0]                                                                   reg_t_ckfspe;
wire  [7:0]                                                                   reg_t_ckfspx;
wire  [7:0]                                                                   reg_t_dllen;
wire  [21:0]                                                                  reg_t_dlllock;
wire  [7:0]                                                                   reg_t_dllrst;
wire  [4:0]                                                                   reg_t_dqrpt;
wire  [7:0]                                                                   reg_t_dqscke;
wire  [7:0]                                                                   reg_t_dtrain;
wire  [21:0]                                                                  reg_t_fc;
wire  [21:0]                                                                  reg_t_init1;
wire  [21:0]                                                                  reg_t_init3;
wire  [21:0]                                                                  reg_t_init5;
wire  [7:0]                                                                   reg_t_lvlaa;
wire  [7:0]                                                                   reg_t_lvldis;
wire  [7:0]                                                                   reg_t_lvldll;
wire  [7:0]                                                                   reg_t_lvlexit;
wire  [7:0]                                                                   reg_t_lvlload;
wire  [7:0]                                                                   reg_t_lvlresp;
wire  [PHY_COUNTER_WIDTH-1:0]                                                 reg_t_lvlresp_nr;
wire  [PHY_COUNTER_WIDTH-1:0]                                                 reg_t_mod;
wire  [7:0]                                                                   reg_t_mpcwr;
wire  [7:0]                                                                   reg_t_mpcwr2rd;
wire  [7:0]                                                                   reg_t_mrd;
wire  [7:0]                                                                   reg_t_mrr;
wire  [7:0]                                                                   reg_t_mrs2act;
wire  [7:0]                                                                   reg_t_mrs2lvlen;
wire  [7:0]                                                                   reg_t_mrw;
wire  [7:0]                                                                   reg_t_odth4;
wire  [ODT_COUNT_WIDTH - 1:0]                                                 reg_t_odth8;
wire  [7:0]                                                                   reg_t_odtup;
wire  [6:0]                                                                   reg_t_osco;
wire  [PHY_WIDE_COUNTER_WIDTH-1:0]                                            reg_t_pori;
wire  [7:0]                                                                   reg_t_rcd;
wire  [7:0]                                                                   reg_t_rp;
wire  [PHY_WIDE_COUNTER_WIDTH-1:0]                                            reg_t_rst;
wire  [7:0]                                                                   reg_t_vrcgdis;
wire  [21:0]                                                                  reg_t_vrcgen;
wire  [21:0]                                                                  reg_t_vreftimelong;
wire  [7:0]                                                                   reg_t_vreftimeshort;
wire  [PHY_WIDE_COUNTER_WIDTH-1:0]                                            reg_t_xpr;
wire  [21:0]                                                                  reg_t_zqcal;
wire  [PHY_WIDE_COUNTER_WIDTH-1:0]                                            reg_t_zqinit;
wire  [7:0]                                                                   reg_t_zqlat;
wire                                                                          reg_vtgc_ivrefen;
wire                                                                          reg_vtgc_ivrefr;
wire  [7:0]                                                                   reg_vtgc_ivrefts;
wire  [5:0]                                                                   reg_vtgc_vrefcasw;
wire  [5:0]                                                                   reg_vtgc_vrefdqsw;
wire  [SRAM_RWM_WIDTH - 1:0]                                                  reg_wcb_t_rwm              = 3'b111;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr11_fs0;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr11_fs1;
wire  [7:0]                                                                   shad_reg_lpmr11_nt_fs0;
wire  [7:0]                                                                   shad_reg_lpmr11_nt_fs1;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr12_fs0;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr12_fs1;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr13;
wire  [7:0]                                                                   shad_reg_lpmr13_nt;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr14_fs0;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr14_fs1;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr1_fs0;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr1_fs1;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr22_fs0;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr22_fs1;
wire  [7:0]                                                                   shad_reg_lpmr22_nt_fs0;
wire  [7:0]                                                                   shad_reg_lpmr22_nt_fs1;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr2_fs0;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr2_fs1;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr3_fs0;
wire  [LPDDR_MR_OPCODE_WIDTH-1:0]                                             shad_reg_lpmr3_fs1;
wire  [DC_ROUTE_NUM * WCB_BUF_WIDTH - 1:0]                                    wcb_di_bf;
wire  [DC_ROUTE_NUM * WCB_BUF_WIDTH - 1:0]                                    wcb_do_bf;
wire  [DC_ROUTE_NUM * WCB_ADDR_WIDTH - 1:0]                                   wcb_ra_bf;
wire  [DC_ROUTE_NUM - 1:0]                                                    wcb_re_n_bf;
wire  [DC_ROUTE_NUM * WCB_ADDR_WIDTH - 1:0]                                   wcb_wa_bf;
wire  [DC_ROUTE_NUM - 1:0]                                                    wcb_we_n_bf;


// Instances 
dti_tm16_phy dti_tm16_phy( 
  .BYPC_REG_DLLCA              (reg_dllca_bypc), 
  .BYPC_REG_DLLDQ              (reg_dlldq_bypc), 
  .BYP_EN_REG_PCCR             (reg_pccr_bypen), 
  .BYP_N_REG_PCCR              (reg_pccr_byp_n), 
  .BYP_P_REG_PCCR              (reg_pccr_byp_p), 
  .BYP_REG_DLLCA               (reg_dllca_byp), 
  .BYP_REG_DLLDQ               (reg_dlldq_byp), 
  .CLKDLY_REG_DLLCA            (reg_dllca_clkdly), 
  .CLOCKDR_CLK                 (CLOCKDR_CLK), 
  .CLOCKDR_CTL                 (CLOCKDR_CTL), 
  .CLOCKDR_DM                  (CLOCKDR_DM), 
  .CLOCKDR_DQ                  (CLOCKDR_DQ), 
  .CLOCKDR_DQS                 (CLOCKDR_DQS), 
  .CMOS_EN_REG_CIOR            (reg_cior_cmos_en), 
  .CMOS_EN_REG_DIOR            (reg_dior_cmos_en), 
  .COMP_CLOCK                  (COMP_CLOCK), 
  .COMP_RST_N                  (COMP_RST_N), 
  .DRVSEL_REG_CIOR             (reg_cior_drvsel), 
  .DRVSEL_REG_DIOR             (reg_dior_drvsel), 
  .DTI_ACT_N_MC                (dfi_act_n), 
  .DTI_BA_MC                   (dfi_ba), 
  .DTI_CA_L_MC                 (dfi_ca_l), 
  .DTI_CA_MC                   (dfi_ca), 
  .DTI_CKE_MC                  (dfi_cke), 
  .DTI_CS_MC                   (dfi_cs_n), 
  .DTI_DATA_BYTE_DISABLE       (dti_data_byte_dis), 
  .DTI_DRAM_CLK_DISABLE        (dti_dram_clk_dis), 
  .DTI_EXT_VREF                (DTI_EXT_VREF), 
  .DTI_FREQ_RATIO              (dfi_freq_ratio), 
  .DTI_MC_CLOCK                (DTI_MC_CLOCK), 
  .DTI_ODT_MC                  (dfi_odt), 
  .DTI_PHY_CLOCK               (DTI_PHY_CLOCK), 
  .DTI_RANK_MC                 (dfi_rank), 
  .DTI_RANK_RD_MC              (dfi_rank_rd), 
  .DTI_RANK_WR_MC              (dfi_rank_wr), 
  .DTI_RDDATA_EN_MC            (dfi_rddata_en), 
  .DTI_RESET_N_MC              (DTI_RESET_N_MC), 
  .DTI_SYS_RESET_N             (DTI_SYS_RESET_N), 
  .DTI_WRDATA_EN_MC            (dfi_wrdata_en), 
  .DTI_WRDATA_MASK_MC          (dfi_wrdata_mask), 
  .DTI_WRDATA_MC               (dfi_wrdata), 
  .EN_REG_PCCR                 (reg_pccr_en), 
  .GT_DIS_REG_RTGC             (reg_rtgc_gt_dis), 
  .GT_UPDT_REG_RTGC            (reg_rtgc_gt_updt), 
  .JTAG_SI_CLK                 (JTAG_SI_CLK), 
  .JTAG_SI_CTL                 (JTAG_SI_CTL), 
  .JTAG_SI_DM                  (JTAG_SI_DM), 
  .JTAG_SI_DQ                  (JTAG_SI_DQ), 
  .JTAG_SI_DQS                 (JTAG_SI_DQS), 
  .LIMIT_REG_DLLCA             (reg_dllca_limit), 
  .LIMIT_REG_DLLDQ             (reg_dlldq_limit), 
  .LP_EN_REG_PBCR              (reg_pbcr_lp_en), 
  .MODE_CLK                    (MODE_CLK), 
  .MODE_CTL                    (MODE_CTL), 
  .MODE_DM                     (MODE_DM), 
  .MODE_DQ                     (MODE_DQ), 
  .MODE_DQS                    (MODE_DQS), 
  .MODE_I_DM                   (MODE_I_DM), 
  .MODE_I_DQ                   (MODE_I_DQ), 
  .MODE_I_DQS                  (MODE_I_DQS), 
  .MVG_EN_REG_PCCR             (reg_pccr_mvg), 
  .ODIS_CLK_REG_CIOR           (reg_cior_odis_clk), 
  .ODIS_CTL_REG_CIOR           (reg_cior_odis_ctl), 
  .ODIS_DM_REG_DIOR            (reg_dior_odis_dm), 
  .ODIS_DQS_REG_DIOR           (reg_dior_odis_dqs), 
  .ODIS_DQ_REG_DIOR            (reg_dior_odis_dq), 
  .PAD_REF                     (PAD_REF), 
  .REG_OUTBYPEN_CLK            (reg_outbypen_clk), 
  .REG_OUTBYPEN_CTL            (reg_outbypen_ctl), 
  .REG_OUTBYPEN_DM             (reg_outbypen_dm), 
  .REG_OUTBYPEN_DQ             (reg_outbypen_dq), 
  .REG_OUTBYPEN_DQS            (reg_outbypen_dqs), 
  .REG_OUTD_CLK                (reg_outd_clk), 
  .REG_OUTD_CTL                (reg_outd_ctl), 
  .REG_OUTD_DM                 (reg_outd_dm), 
  .REG_OUTD_DQ                 (reg_outd_dq), 
  .REG_OUTD_DQS                (reg_outd_dqs), 
  .RTT_EN_REG_DIOR             (reg_dior_rtt_en), 
  .RTT_SEL_REG_DIOR            (reg_dior_rtt_sel), 
  .SE                          (SE), 
  .SE_CK                       (SE_CK), 
  .SHIFTDR_CLK                 (SHIFTDR_CLK), 
  .SHIFTDR_CTL                 (SHIFTDR_CTL), 
  .SHIFTDR_DM                  (SHIFTDR_DM), 
  .SHIFTDR_DQ                  (SHIFTDR_DQ), 
  .SHIFTDR_DQS                 (SHIFTDR_DQS), 
  .SI_CLK                      (SI_CLK), 
  .SI_CTL                      (SI_CTL), 
  .SI_DM                       (SI_DM), 
  .SI_DQ                       (SI_DQ), 
  .SI_RD                       (SI_RD), 
  .SI_WR                       (SI_WR), 
  .TPADEN_REG_PCCR             (reg_pccr_tpaden), 
  .T_CGCTL_CTL                 (T_CGCTL_CTL), 
  .T_CGCTL_DQ                  (T_CGCTL_DQ), 
  .T_RCTL_CTL                  (T_RCTL_CTL), 
  .T_RCTL_DQ                   (T_RCTL_DQ), 
  .UPDATEDR_CLK                (UPDATEDR_CLK), 
  .UPDATEDR_CTL                (UPDATEDR_CTL), 
  .UPDATEDR_DM                 (UPDATEDR_DM), 
  .UPDATEDR_DQ                 (UPDATEDR_DQ), 
  .UPDATEDR_DQS                (UPDATEDR_DQS), 
  .UPD_EN_REG_PCCR             (reg_pccr_upd), 
  .VDD                         (VDD), 
  .VDDO                        (VDDO), 
  .VREFENCA_REG_PBCR           (reg_pbcr_vrefenca), 
  .VREFSETCA_REG_PBCR          (reg_pbcr_vrefsetca), 
  .VSS                         (VSS), 
  .actn_reg_ptsr               (reg_ptsr_actn), 
  .ba_reg_ptar                 (reg_ptar_ba), 
  .ba_reg_ptsr                 (reg_ptsr_ba), 
  .bist_en_reg_pbcr            (reg_pbcr_bist_en), 
  .bist_start_reg_pbcr         (reg_pbcr_bist_start), 
  .ca_reg_ptsr                 (reg_ptsr_ca), 
  .chanen_reg_pom              (reg_pom_chanen), 
  .cke_reg_ptsr                (reg_ptsr_cke), 
  .clklocken_reg_pom           (reg_pom_clklocken), 
  .cmddlyen_reg_pom            (reg_pom_cmddlyen), 
  .col_reg_ptar                (reg_ptar_col), 
  .cs_reg_ptsr                 (reg_ptsr_cs), 
  .dfien_reg_pom               (reg_pom_dfien), 
  .dir_reg_dqsdqcr             (dqsdqcr_dir), 
  .dllrsten_reg_pom            (reg_pom_dllrsten), 
  .dlyevalen_reg_pom           (reg_pom_dlyevalen), 
  .dlymax_reg_dqsdqcr          (dqsdqcr_dlymax), 
  .dlyoffs_reg_dqsdqcr         (dqsdqcr_dlyoffs), 
  .dqrpt_reg_pttr              (reg_t_dqrpt), 
  .dqsdm_reg_ptsr              (reg_ptsr_dqsdm), 
  .dqsdq_reg_ptsr              (reg_ptsr_dqsdq), 
  .dqsdqen_reg_pom             (reg_pom_dqsdqen), 
  .dqsel_reg_dqsdqcr           (dqsdqcr_dqsel), 
  .dqsleadck_reg_ptsr          (reg_ptsr_dqsleadck), 
  .draminiten_reg_pom          (reg_pom_draminiten), 
  .en_reg_dllca                (reg_dllca_en), 
  .en_reg_dlldq                (reg_dlldq_en), 
  .fena_rcv_reg_dior           (reg_dior_fena_rcv), 
  .fs0_trden_reg_rtgc          (reg_rtgc_fs0_trden), 
  .fs0_trdendbi_reg_rtgc       (reg_rtgc_fs0_trdendbi), 
  .fs0_twren_reg_rtgc          (reg_rtgc_fs0_twren), 
  .fs1_trden_reg_rtgc          (reg_rtgc_fs1_trden), 
  .fs1_trdendbi_reg_rtgc       (reg_rtgc_fs1_trdendbi), 
  .fs1_twren_reg_rtgc          (reg_rtgc_fs1_twren), 
  .fs_reg_pom                  (reg_pom_fs), 
  .gt_reg_ptsr                 (reg_ptsr_gt), 
  .gten_reg_pom                (reg_pom_gten), 
  .initcnt_reg_pccr            (reg_pccr_initcnt), 
  .ivrefen_reg_vtgc            (reg_vtgc_ivrefen), 
  .ivrefr_reg_vtgc             (reg_vtgc_ivrefr), 
  .ivrefts_reg_vtgc            (reg_vtgc_ivrefts), 
  .mpcrpt_reg_dqsdqcr          (dqsdqcr_mpcrpt), 
  .mupd_reg_dqsdqcr            (dqsdqcr_mupd), 
  .odt_reg_pom                 (reg_pom_odt), 
  .odt_reg_ptsr                (reg_ptsr_odt), 
  .phyfsen_reg_pom             (reg_pom_phyfsen), 
  .phyinit_reg_pom             (reg_pom_phyinit), 
  .phyop_en                    (phyop_en), 
  .physeten_reg_pom            (reg_pom_physeten), 
  .proc_reg_pom                (reg_pom_proc), 
  .psck_reg_ptsr               (reg_ptsr_psck), 
  .rank_reg_dqsdqcr            (dqsdqcr_rank), 
  .ranken_reg_pom              (reg_pom_ranken), 
  .rdlvl_reg_ptsr              (reg_ptsr_rdlvldq), 
  .rdlvldm_reg_ptsr            (reg_ptsr_rdlvldm), 
  .rdlvlen_reg_pom             (reg_pom_rdlvlen), 
  .reg_calvl_pattern_a         (calvlpa_pattern_a), 
  .reg_calvl_pattern_b         (calvlpa_pattern_b), 
  .reg_ddr3_en                 (reg_ddr3_enable), 
  .reg_ddr3_mr0                (reg_ddr3_mr0), 
  .reg_ddr3_mr1                (reg_ddr3_mr1), 
  .reg_ddr3_mr2                (reg_ddr3_mr2), 
  .reg_ddr3_mr3                (reg_ddr3_mr3), 
  .reg_ddr4_en                 (reg_ddr4_enable), 
  .reg_ddr4_mr0                (reg_ddr4_mr0), 
  .reg_ddr4_mr1                (reg_ddr4_mr1), 
  .reg_ddr4_mr2                (reg_ddr4_mr2), 
  .reg_ddr4_mr3                (reg_ddr4_mr3), 
  .reg_ddr4_mr4                (reg_ddr4_mr4), 
  .reg_ddr4_mr5                (reg_ddr4_mr5), 
  .reg_ddr4_mr6                (reg_ddr4_mr6), 
  .reg_ddr4_mr6_vrefdq         (reg_ddr4_mr6_vrefdq), 
  .reg_ddr4_mr6_vrefdqr        (reg_ddr4_mr6_vrefdqr), 
  .reg_dqs2ck_en               (dmcfg_dqs2cken), 
  .reg_dual_chan_en            (reg_dual_chan_en), 
  .reg_dual_rank_en            (reg_dual_rank_en), 
  .reg_io_mode                 (reg_pom_ddrt), 
  .reg_lpddr3_en               (reg_lpddr3_enable), 
  .reg_lpddr3_mr1              (reg_lpddr3_lpmr1), 
  .reg_lpddr3_mr11             (reg_lpddr3_lpmr11), 
  .reg_lpddr3_mr16             (reg_lpddr3_lpmr16), 
  .reg_lpddr3_mr17             (reg_lpddr3_lpmr17), 
  .reg_lpddr3_mr2              (reg_lpddr3_lpmr2), 
  .reg_lpddr3_mr3              (reg_lpddr3_lpmr3), 
  .reg_lpddr4_en               (reg_lpddr4_enable), 
  .reg_lpddr4_mr11_fs0         (reg_lpddr4_lpmr11_fs0), 
  .reg_lpddr4_mr11_fs1         (reg_lpddr4_lpmr11_fs1), 
  .reg_lpddr4_mr11_nt_fs0      (reg_lpddr4_lpmr11_nt_fs0), 
  .reg_lpddr4_mr11_nt_fs1      (reg_lpddr4_lpmr11_nt_fs1), 
  .reg_lpddr4_mr13             (reg_lpddr4_lpmr13), 
  .reg_lpddr4_mr1_fs0          (reg_lpddr4_lpmr1_fs0), 
  .reg_lpddr4_mr1_fs1          (reg_lpddr4_lpmr1_fs1), 
  .reg_lpddr4_mr22_fs0         (reg_lpddr4_lpmr22_fs0), 
  .reg_lpddr4_mr22_fs1         (reg_lpddr4_lpmr22_fs1), 
  .reg_lpddr4_mr22_nt_fs0      (reg_lpddr4_lpmr22_nt_fs0), 
  .reg_lpddr4_mr22_nt_fs1      (reg_lpddr4_lpmr22_nt_fs1), 
  .reg_lpddr4_mr2_fs0          (reg_lpddr4_lpmr2_fs0), 
  .reg_lpddr4_mr2_fs1          (reg_lpddr4_lpmr2_fs1), 
  .reg_lpddr4_mr3_fs0          (reg_lpddr4_lpmr3_fs0), 
  .reg_lpddr4_mr3_fs1          (reg_lpddr4_lpmr3_fs1), 
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
  .row_reg_ptar                (reg_ptar_row), 
  .rstn_reg_ptsr               (reg_ptsr_rstn), 
  .sanchken_reg_pom            (reg_pom_sanchken), 
  .sanpat_reg_ptsr             (reg_ptsr_sanpat), 
  .srst_reg_pccr               (reg_pccr_srst), 
  .upd_reg_dllca               (reg_dllca_upd), 
  .upd_reg_dlldq               (reg_dlldq_upd), 
  .vrefcaen_reg_pom            (reg_pom_vrefcaen), 
  .vrefcar_reg_lpmr12_fs0      (lpddr4_lpmr12_fs0_vrefcar), 
  .vrefcar_reg_lpmr12_fs1      (lpddr4_lpmr12_fs1_vrefcar), 
  .vrefcar_reg_ptsr            (reg_ptsr_vrefcar), 
  .vrefcas_reg_lpmr12_fs0      (lpddr4_lpmr12_fs0_vrefcas), 
  .vrefcas_reg_lpmr12_fs1      (lpddr4_lpmr12_fs1_vrefcas), 
  .vrefcas_reg_ptsr            (reg_ptsr_vrefcas), 
  .vrefcasw_reg_vtgc           (reg_vtgc_vrefcasw), 
  .vrefdqr_reg_lpmr14_fs0      (lpddr4_lpmr14_fs0_vrefdqr), 
  .vrefdqr_reg_lpmr14_fs1      (lpddr4_lpmr14_fs1_vrefdqr), 
  .vrefdqrden_reg_pom          (reg_pom_vrefdqrden), 
  .vrefdqrdr_reg_ptsr          (reg_ptsr_vrefdqrdr), 
  .vrefdqrds_reg_ptsr          (reg_ptsr_vrefdqrd), 
  .vrefdqs_reg_lpmr14_fs0      (lpddr4_lpmr14_fs0_vrefdqs), 
  .vrefdqs_reg_lpmr14_fs1      (lpddr4_lpmr14_fs1_vrefdqs), 
  .vrefdqsw_reg_vtgc           (reg_vtgc_vrefdqsw), 
  .vrefdqwren_reg_pom          (reg_pom_vrefdqwren), 
  .vrefdqwrr_reg_ptsr          (reg_ptsr_vrefdqwrr), 
  .vrefdqwrs_reg_ptsr          (reg_ptsr_vrefdqwrs), 
  .wrlvl_reg_ptsr              (reg_ptsr_wrlvl), 
  .wrlvlen_reg_pom             (reg_pom_wrlvlen), 
  .DTI_RDDATA_MASK_MC          (dfi_rddata_dbi_n), 
  .DTI_RDDATA_MC               (dfi_rddata), 
  .DTI_RDDATA_VALID_MC         (dfi_rddata_valid), 
  .JTAG_SO_CLK                 (JTAG_SO_CLK), 
  .JTAG_SO_CTL                 (JTAG_SO_CTL), 
  .JTAG_SO_DM                  (JTAG_SO_DM), 
  .JTAG_SO_DQ                  (JTAG_SO_DQ), 
  .JTAG_SO_DQS                 (JTAG_SO_DQS), 
  .LOCK_REG_DLLCA              (reg_dllca_lock), 
  .LOCK_REG_DLLDQ              (reg_dlldq_lock), 
  .NBC_REG_PCSR                (reg_pcsr_nbc), 
  .OVFL_REG_DLLCA              (reg_dllca_ovfl), 
  .OVFL_REG_DLLDQ              (reg_dlldq_ovfl), 
  .PAD_MEM_CLK                 (PAD_MEM_CLK), 
  .PAD_MEM_CLK_N               (PAD_MEM_CLK_N), 
  .PAD_MEM_CTL                 (PAD_MEM_CTL), 
  .PBC_REG_PCSR                (reg_pcsr_pbc), 
  .SO_CLK                      (SO_CLK), 
  .SO_CTL                      (SO_CTL), 
  .SO_DM                       (SO_DM), 
  .SO_DQ                       (SO_DQ), 
  .SO_RD                       (SO_RD), 
  .SO_WR                       (SO_WR), 
  .UNFL_REG_DLLCA              (reg_dllca_unfl), 
  .UNFL_REG_DLLDQ              (reg_dlldq_unfl), 
  .UPDT_C_REG_PCSR             (reg_pcsr_updc), 
  .YC_CLK                      (YC_CLK), 
  .YC_CTL                      (YC_CTL), 
  .Y_DM                        (Y_DM), 
  .Y_DQ                        (Y_DQ), 
  .Y_DQS                       (Y_DQS), 
  .bist_done_reg_pbsr          (reg_pbsr_bist_done), 
  .bist_err_ctl_reg_pbsr       (reg_pbsr_bist_err_ctl), 
  .bist_err_dm_reg_pbsr        (reg_pbsr_bist_err_dm), 
  .bist_err_dq_reg_pbsr        (reg_pbsr_bist_err_dq), 
  .ca_reg_ptsr_ip              (ptsr_ca_ip), 
  .clklockc_reg_pos            (reg_pos_clklockc), 
  .cmddlyc_reg_pos             (reg_pos_cmddlyc), 
  .cs_reg_ptsr_ip              (ptsr_cs_ip), 
  .dllerr_reg_pts              (reg_pts_dllerr), 
  .dllrstc_reg_pos             (reg_pos_dllrstc), 
  .dlyevalc_reg_pos            (reg_pos_dlyevalc), 
  .dqsdm_reg_ptsr_ip           (ptsr_dqsdm_ip), 
  .dqsdmerr_reg_pts            (reg_pts_dqsdmerr), 
  .dqsdq_reg_ptsr_ip           (ptsr_dqsdq_ip), 
  .dqsdqc_reg_pos              (reg_pos_dqsdqc), 
  .dqsdqerr_reg_pts            (reg_pts_dqsdqerr), 
  .dqsleadck_reg_ptsr_ip       (ptsr_dqsleadck_ip), 
  .draminitc_reg_pos           (reg_pos_draminitc), 
  .fs0req_reg_pos              (reg_pos_fs0req), 
  .fs1req_reg_pos              (reg_pos_fs1req), 
  .gt_reg_ptsr_ip              (ptsr_gt_ip), 
  .gtc_reg_pos                 (reg_pos_gtc), 
  .gterr_reg_pts               (reg_pts_gterr), 
  .lp3calvlerr_reg_pts         (reg_pts_lp3calvlerr), 
  .mupd_reg_dqsdqcr_clr        (mupd_dqsdqcr_clr), 
  .nt_rank_reg_ptsr_ip         (ptsr_nt_rank_ip), 
  .ofs_reg_pos                 (reg_pos_ofs), 
  .phyfsc_reg_pos              (reg_pos_phyfsc), 
  .phyinitc_reg_pos            (reg_pos_phyinitc), 
  .physetc_reg_pos             (reg_pos_physetc), 
  .psck_reg_ptsr_ip            (ptsr_psck_ip), 
  .ptsr_upd                    (ptsr_upd), 
  .rdlvl_reg_ptsr_ip           (ptsr_rdlvldq_ip), 
  .rdlvlc_reg_pos              (reg_pos_rdlvlc), 
  .rdlvldm_reg_ptsr_ip         (ptsr_rdlvldm_ip), 
  .rdlvldmerr_reg_pts          (reg_pts_rdlvldmerr), 
  .rdlvldqerr_reg_pts          (reg_pts_rdlvldqerr), 
  .sanchkc_reg_pos             (reg_pos_sanchkc), 
  .sanchkerr_reg_pts           (reg_pts_sanchkerr), 
  .shad_reg_lpddr4_mr11_fs0    (shad_reg_lpmr11_fs0), 
  .shad_reg_lpddr4_mr11_fs1    (shad_reg_lpmr11_fs1), 
  .shad_reg_lpddr4_mr11_nt_fs0 (shad_reg_lpmr11_nt_fs0), 
  .shad_reg_lpddr4_mr11_nt_fs1 (shad_reg_lpmr11_nt_fs1), 
  .shad_reg_lpddr4_mr12_fs0    (shad_reg_lpmr12_fs0), 
  .shad_reg_lpddr4_mr12_fs1    (shad_reg_lpmr12_fs1), 
  .shad_reg_lpddr4_mr13        (shad_reg_lpmr13), 
  .shad_reg_lpddr4_mr13_nt     (shad_reg_lpmr13_nt), 
  .shad_reg_lpddr4_mr14_fs0    (shad_reg_lpmr14_fs0), 
  .shad_reg_lpddr4_mr14_fs1    (shad_reg_lpmr14_fs1), 
  .shad_reg_lpddr4_mr1_fs0     (shad_reg_lpmr1_fs0), 
  .shad_reg_lpddr4_mr1_fs1     (shad_reg_lpmr1_fs1), 
  .shad_reg_lpddr4_mr22_fs0    (shad_reg_lpmr22_fs0), 
  .shad_reg_lpddr4_mr22_fs1    (shad_reg_lpmr22_fs1), 
  .shad_reg_lpddr4_mr22_nt_fs0 (shad_reg_lpmr22_nt_fs0), 
  .shad_reg_lpddr4_mr22_nt_fs1 (shad_reg_lpmr22_nt_fs1), 
  .shad_reg_lpddr4_mr2_fs0     (shad_reg_lpmr2_fs0), 
  .shad_reg_lpddr4_mr2_fs1     (shad_reg_lpmr2_fs1), 
  .shad_reg_lpddr4_mr3_fs0     (shad_reg_lpmr3_fs0), 
  .shad_reg_lpddr4_mr3_fs1     (shad_reg_lpmr3_fs1), 
  .srstc_reg_pcsr              (reg_pcsr_srstc), 
  .vrefcac_reg_pos             (reg_pos_vrefcac), 
  .vrefcaerr_reg_pts           (reg_pts_vrefcaerr), 
  .vrefcar_reg_ptsr_ip         (ptsr_vrefcar_ip), 
  .vrefcas_reg_ptsr_ip         (ptsr_vrefcas_ip), 
  .vrefdqr_reg_ptsr_ip         (ptsr_vrefdqwrr_ip), 
  .vrefdqrdc_reg_pos           (reg_pos_vrefdqrdc), 
  .vrefdqrderr_reg_pts         (reg_pts_vrefdqrderr), 
  .vrefdqrdr_reg_ptsr_ip       (ptsr_vrefdqrdr_ip), 
  .vrefdqrds_reg_ptsr_ip       (ptsr_vrefdqrd_ip), 
  .vrefdqs_reg_ptsr_ip         (ptsr_vrefdqwrs_ip), 
  .vrefdqwrc_reg_pos           (reg_pos_vrefdqwrc), 
  .vrefdqwrerr_reg_pts         (reg_pts_vrefdqwrerr), 
  .wrlvl_reg_ptsr_ip           (ptsr_wrlvl_ip), 
  .wrlvlc_reg_pos              (reg_pos_wrlvlc), 
  .wrlvlerr_reg_pts            (reg_pts_wrlvlerr), 
  .PAD_COMP                    (PAD_COMP), 
  .PAD_MEM_DM                  (PAD_MEM_DM), 
  .PAD_MEM_DQ                  (PAD_MEM_DQ), 
  .PAD_MEM_DQS                 (PAD_MEM_DQS), 
  .PAD_MEM_DQS_N               (PAD_MEM_DQS_N), 
  .PAD_VREF                    (PAD_VREF)
); 

dynamo_core dynamo_core( 
  .aclk_p                    (aclk_p), 
  .araddr_p                  (araddr_p), 
  .arburst_p                 (arburst_p), 
  .arcache_p                 (arcache_p), 
  .aresetn_p                 (aresetn_p), 
  .arid_p                    (arid_p), 
  .arlen_p                   (arlen_p), 
  .arlock_p                  (arlock_p), 
  .arprot_p                  (arprot_p), 
  .arqos_p                   (arqos_p), 
  .arsize_p                  (arsize_p), 
  .arvalid_p                 (arvalid_p), 
  .awaddr_p                  (awaddr_p), 
  .awburst_p                 (awburst_p), 
  .awcache_p                 (awcache_p), 
  .awid_p                    (awid_p), 
  .awlen_p                   (awlen_p), 
  .awlock_p                  (awlock_p), 
  .awprot_p                  (awprot_p), 
  .awqos_p                   (awqos_p), 
  .awsize_p                  (awsize_p), 
  .awvalid_p                 (awvalid_p), 
  .axi4lite_araddr           (axi4lite_araddr), 
  .axi4lite_arvalid          (axi4lite_arvalid), 
  .axi4lite_awaddr           (axi4lite_awaddr), 
  .axi4lite_awvalid          (axi4lite_awvalid), 
  .axi4lite_bready           (axi4lite_bready), 
  .axi4lite_clk              (axi4lite_clk), 
  .axi4lite_reset_n          (axi4lite_reset_n), 
  .axi4lite_rready           (axi4lite_rready), 
  .axi4lite_wdata            (axi4lite_wdata), 
  .axi4lite_wvalid           (axi4lite_wvalid), 
  .bready_p                  (bready_p), 
  .clk                       (DTI_MC_CLOCK), 
  .dfi_rddata                (dfi_rddata), 
  .dfi_rddata_dbi_n          (dfi_rddata_dbi_n), 
  .dfi_rddata_ecc_dbi_n      (), 
  .dfi_rddata_valid          (dfi_rddata_valid), 
  .mupd_dqsdqcr_clr          (mupd_dqsdqcr_clr), 
  .pbsr_bist_err_ctl         (reg_pbsr_bist_err_ctl), 
  .pbsr_bist_err_dm          (reg_pbsr_bist_err_dm), 
  .pbsr_bist_err_dq          (reg_pbsr_bist_err_dq), 
  .pts_lp3calvlerr           (reg_pts_lp3calvlerr), 
  .ptsr_ca_ip                (ptsr_ca_ip), 
  .ptsr_cs_ip                (ptsr_cs_ip), 
  .ptsr_dqsdm_ip             (ptsr_dqsdm_ip), 
  .ptsr_dqsdq_ip             (ptsr_dqsdq_ip), 
  .ptsr_dqsleadck_ip         (ptsr_dqsleadck_ip), 
  .ptsr_gt_ip                (ptsr_gt_ip), 
  .ptsr_nt_rank_ip           (ptsr_nt_rank_ip), 
  .ptsr_psck_ip              (ptsr_psck_ip), 
  .ptsr_rdlvldm_ip           (ptsr_rdlvldm_ip), 
  .ptsr_rdlvldq_ip           (ptsr_rdlvldq_ip), 
  .ptsr_upd                  (ptsr_upd), 
  .ptsr_vrefcar_ip           (ptsr_vrefcar_ip), 
  .ptsr_vrefcas_ip           (ptsr_vrefcas_ip), 
  .ptsr_vrefdqrd_ip          (ptsr_vrefdqrd_ip), 
  .ptsr_vrefdqrdr_ip         (ptsr_vrefdqrdr_ip), 
  .ptsr_vrefdqwrr_ip         (ptsr_vrefdqwrr_ip), 
  .ptsr_vrefdqwrs_ip         (ptsr_vrefdqwrs_ip), 
  .ptsr_wrlvl_ip             (ptsr_wrlvl_ip), 
  .rcb_do_bf                 (rcb_do_bf), 
  .reg_dllca_lock            (reg_dllca_lock), 
  .reg_dllca_ovfl            (reg_dllca_ovfl), 
  .reg_dllca_unfl            (reg_dllca_unfl), 
  .reg_dlldq_lock            (reg_dlldq_lock), 
  .reg_dlldq_ovfl            (reg_dlldq_ovfl), 
  .reg_dlldq_unfl            (reg_dlldq_unfl), 
  .reg_pbsr_bist_done        (reg_pbsr_bist_done), 
  .reg_pcsr_nbc              (reg_pcsr_nbc), 
  .reg_pcsr_pbc              (reg_pcsr_pbc), 
  .reg_pcsr_srstc            (reg_pcsr_srstc), 
  .reg_pcsr_updc             (reg_pcsr_updc), 
  .reg_pos_clklockc          (reg_pos_clklockc), 
  .reg_pos_cmddlyc           (reg_pos_cmddlyc), 
  .reg_pos_dllrstc           (reg_pos_dllrstc), 
  .reg_pos_dlyevalc          (reg_pos_dlyevalc), 
  .reg_pos_dqsdqc            (reg_pos_dqsdqc), 
  .reg_pos_draminitc         (reg_pos_draminitc), 
  .reg_pos_fs0req            (reg_pos_fs0req), 
  .reg_pos_fs1req            (reg_pos_fs1req), 
  .reg_pos_gtc               (reg_pos_gtc), 
  .reg_pos_ofs               (reg_pos_ofs), 
  .reg_pos_phyfsc            (reg_pos_phyfsc), 
  .reg_pos_phyinitc          (reg_pos_phyinitc), 
  .reg_pos_physetc           (reg_pos_physetc), 
  .reg_pos_rdlvlc            (reg_pos_rdlvlc), 
  .reg_pos_sanchkc           (reg_pos_sanchkc), 
  .reg_pos_vrefcac           (reg_pos_vrefcac), 
  .reg_pos_vrefdqrdc         (reg_pos_vrefdqrdc), 
  .reg_pos_vrefdqwrc         (reg_pos_vrefdqwrc), 
  .reg_pos_wrlvlc            (reg_pos_wrlvlc), 
  .reg_pts_dllerr            (reg_pts_dllerr), 
  .reg_pts_dqsdmerr          (reg_pts_dqsdmerr), 
  .reg_pts_dqsdqerr          (reg_pts_dqsdqerr), 
  .reg_pts_gterr             (reg_pts_gterr), 
  .reg_pts_rdlvldmerr        (reg_pts_rdlvldmerr), 
  .reg_pts_rdlvldqerr        (reg_pts_rdlvldqerr), 
  .reg_pts_sanchkerr         (reg_pts_sanchkerr), 
  .reg_pts_vrefcaerr         (reg_pts_vrefcaerr), 
  .reg_pts_vrefdqrderr       (reg_pts_vrefdqrderr), 
  .reg_pts_vrefdqwrerr       (reg_pts_vrefdqwrerr), 
  .reg_pts_wrlvlerr          (reg_pts_wrlvlerr), 
  .reset_n                   (DTI_SYS_RESET_N), 
  .rready_p                  (rready_p), 
  .shad_reg_lpmr11_fs0       (shad_reg_lpmr11_fs0), 
  .shad_reg_lpmr11_fs1       (shad_reg_lpmr11_fs1), 
  .shad_reg_lpmr11_nt_fs0    (shad_reg_lpmr11_nt_fs0), 
  .shad_reg_lpmr11_nt_fs1    (shad_reg_lpmr11_nt_fs1), 
  .shad_reg_lpmr12_fs0       (shad_reg_lpmr12_fs0), 
  .shad_reg_lpmr12_fs1       (shad_reg_lpmr12_fs1), 
  .shad_reg_lpmr13           (shad_reg_lpmr13), 
  .shad_reg_lpmr13_nt        (shad_reg_lpmr13_nt), 
  .shad_reg_lpmr14_fs0       (shad_reg_lpmr14_fs0), 
  .shad_reg_lpmr14_fs1       (shad_reg_lpmr14_fs1), 
  .shad_reg_lpmr1_fs0        (shad_reg_lpmr1_fs0), 
  .shad_reg_lpmr1_fs1        (shad_reg_lpmr1_fs1), 
  .shad_reg_lpmr22_fs0       (shad_reg_lpmr22_fs0), 
  .shad_reg_lpmr22_fs1       (shad_reg_lpmr22_fs1), 
  .shad_reg_lpmr22_nt_fs0    (shad_reg_lpmr22_nt_fs0), 
  .shad_reg_lpmr22_nt_fs1    (shad_reg_lpmr22_nt_fs1), 
  .shad_reg_lpmr2_fs0        (shad_reg_lpmr2_fs0), 
  .shad_reg_lpmr2_fs1        (shad_reg_lpmr2_fs1), 
  .shad_reg_lpmr3_fs0        (shad_reg_lpmr3_fs0), 
  .shad_reg_lpmr3_fs1        (shad_reg_lpmr3_fs1), 
  .wcb_do_bf                 (wcb_do_bf), 
  .wdata_p                   (wdata_p), 
  .wlast_p                   (wlast_p), 
  .wstrb_p                   (wstrb_p), 
  .wvalid_p                  (wvalid_p), 
  .arready_p                 (arready_p), 
  .awready_p                 (awready_p), 
  .axi4lite_arready          (axi4lite_arready), 
  .axi4lite_awready          (axi4lite_awready), 
  .axi4lite_bresp            (axi4lite_bresp), 
  .axi4lite_bvalid           (axi4lite_bvalid), 
  .axi4lite_rdata            (axi4lite_rdata), 
  .axi4lite_rresp            (axi4lite_rresp), 
  .axi4lite_rvalid           (axi4lite_rvalid), 
  .axi4lite_wready           (axi4lite_wready), 
  .bid_p                     (bid_p), 
  .bresp_p                   (bresp_p), 
  .bvalid_p                  (bvalid_p), 
  .calvlpa_pattern_a         (calvlpa_pattern_a), 
  .calvlpa_pattern_b         (calvlpa_pattern_b), 
  .ddr4_mr6_vrefdq           (reg_ddr4_mr6_vrefdq), 
  .ddr4_mr6_vrefdqr          (reg_ddr4_mr6_vrefdqr), 
  .dfi_act_n                 (dfi_act_n), 
  .dfi_ba                    (dfi_ba), 
  .dfi_ca                    (dfi_ca), 
  .dfi_ca_l                  (dfi_ca_l), 
  .dfi_cke                   (dfi_cke), 
  .dfi_cs_n                  (dfi_cs_n), 
  .dfi_freq_ratio            (dfi_freq_ratio), 
  .dfi_odt                   (dfi_odt), 
  .dfi_rank                  (dfi_rank), 
  .dfi_rank_rd               (dfi_rank_rd), 
  .dfi_rank_wr               (dfi_rank_wr), 
  .dfi_rddata_en             (dfi_rddata_en), 
  .dfi_wrdata                (dfi_wrdata), 
  .dfi_wrdata_en             (dfi_wrdata_en), 
  .dfi_wrdata_mask           (dfi_wrdata_mask), 
  .dmcfg_dqs2cken            (dmcfg_dqs2cken), 
  .dmctl_dual_chan_en        (reg_dual_chan_en), 
  .dmctl_dual_rank_en        (reg_dual_rank_en), 
  .dqsdqcr_dir               (dqsdqcr_dir), 
  .dqsdqcr_dlymax            (dqsdqcr_dlymax), 
  .dqsdqcr_dlyoffs           (dqsdqcr_dlyoffs), 
  .dqsdqcr_dqsel             (dqsdqcr_dqsel), 
  .dqsdqcr_mpcrpt            (dqsdqcr_mpcrpt), 
  .dqsdqcr_mupd              (dqsdqcr_mupd), 
  .dqsdqcr_rank              (dqsdqcr_rank), 
  .dti_data_byte_dis         (dti_data_byte_dis), 
  .dti_dram_clk_dis          (dti_dram_clk_dis), 
  .int_gc_fsm                (int_gc_fsm), 
  .lpddr4_lpmr12_fs0_vrefcar (lpddr4_lpmr12_fs0_vrefcar), 
  .lpddr4_lpmr12_fs0_vrefcas (lpddr4_lpmr12_fs0_vrefcas), 
  .lpddr4_lpmr12_fs1_vrefcar (lpddr4_lpmr12_fs1_vrefcar), 
  .lpddr4_lpmr12_fs1_vrefcas (lpddr4_lpmr12_fs1_vrefcas), 
  .lpddr4_lpmr14_fs0_vrefdqr (lpddr4_lpmr14_fs0_vrefdqr), 
  .lpddr4_lpmr14_fs0_vrefdqs (lpddr4_lpmr14_fs0_vrefdqs), 
  .lpddr4_lpmr14_fs1_vrefdqr (lpddr4_lpmr14_fs1_vrefdqr), 
  .lpddr4_lpmr14_fs1_vrefdqs (lpddr4_lpmr14_fs1_vrefdqs), 
  .outbypen_clk              (reg_outbypen_clk), 
  .outbypen_ctl              (reg_outbypen_ctl), 
  .outd_clk                  (reg_outd_clk), 
  .outd_ctl                  (reg_outd_ctl), 
  .phyop_en                  (phyop_en), 
  .ptsr_nt_rank              (ptsr_nt_rank), 
  .rcb_di_bf                 (rcb_di_bf), 
  .rcb_ra_bf                 (rcb_ra_bf), 
  .rcb_re_n_bf               (rcb_re_n_bf), 
  .rcb_wa_bf                 (rcb_wa_bf), 
  .rcb_we_n_bf               (rcb_we_n_bf), 
  .rdata_p                   (rdata_p), 
  .reg_adft_tst_en_ca        (reg_adft_tst_en_ca), 
  .reg_adft_tst_en_dq        (reg_adft_tst_en_dq), 
  .reg_cior_cmos_en          (reg_cior_cmos_en), 
  .reg_cior_drvsel           (reg_cior_drvsel), 
  .reg_cior_odis_clk         (reg_cior_odis_clk), 
  .reg_cior_odis_ctl         (reg_cior_odis_ctl), 
  .reg_ddr3_enable           (reg_ddr3_enable), 
  .reg_ddr3_mr0              (reg_ddr3_mr0), 
  .reg_ddr3_mr1              (reg_ddr3_mr1), 
  .reg_ddr3_mr2              (reg_ddr3_mr2), 
  .reg_ddr3_mr3              (reg_ddr3_mr3), 
  .reg_ddr4_enable           (reg_ddr4_enable), 
  .reg_ddr4_mr0              (reg_ddr4_mr0), 
  .reg_ddr4_mr1              (reg_ddr4_mr1), 
  .reg_ddr4_mr2              (reg_ddr4_mr2), 
  .reg_ddr4_mr3              (reg_ddr4_mr3), 
  .reg_ddr4_mr4              (reg_ddr4_mr4), 
  .reg_ddr4_mr5              (reg_ddr4_mr5), 
  .reg_ddr4_mr6              (reg_ddr4_mr6), 
  .reg_dfi_freq_ratio        (reg_dfi_freq_ratio), 
  .reg_dior_cmos_en          (reg_dior_cmos_en), 
  .reg_dior_drvsel           (reg_dior_drvsel), 
  .reg_dior_fena_rcv         (reg_dior_fena_rcv), 
  .reg_dior_odis_dm          (reg_dior_odis_dm), 
  .reg_dior_odis_dq          (reg_dior_odis_dq), 
  .reg_dior_odis_dqs         (reg_dior_odis_dqs), 
  .reg_dior_rtt_en           (reg_dior_rtt_en), 
  .reg_dior_rtt_sel          (reg_dior_rtt_sel), 
  .reg_dllca_byp             (reg_dllca_byp), 
  .reg_dllca_bypc            (reg_dllca_bypc), 
  .reg_dllca_clkdly          (reg_dllca_clkdly), 
  .reg_dllca_en              (reg_dllca_en), 
  .reg_dllca_limit           (reg_dllca_limit), 
  .reg_dllca_upd             (reg_dllca_upd), 
  .reg_dlldq_byp             (reg_dlldq_byp), 
  .reg_dlldq_bypc            (reg_dlldq_bypc), 
  .reg_dlldq_en              (reg_dlldq_en), 
  .reg_dlldq_limit           (reg_dlldq_limit), 
  .reg_dlldq_upd             (reg_dlldq_upd), 
  .reg_lpddr3_enable         (reg_lpddr3_enable), 
  .reg_lpddr3_lpmr1          (reg_lpddr3_lpmr1), 
  .reg_lpddr3_lpmr10         (reg_lpddr3_lpmr10), 
  .reg_lpddr3_lpmr11         (reg_lpddr3_lpmr11), 
  .reg_lpddr3_lpmr16         (reg_lpddr3_lpmr16), 
  .reg_lpddr3_lpmr17         (reg_lpddr3_lpmr17), 
  .reg_lpddr3_lpmr2          (reg_lpddr3_lpmr2), 
  .reg_lpddr3_lpmr3          (reg_lpddr3_lpmr3), 
  .reg_lpddr4_enable         (reg_lpddr4_enable), 
  .reg_lpddr4_lpmr11_fs0     (reg_lpddr4_lpmr11_fs0), 
  .reg_lpddr4_lpmr11_fs1     (reg_lpddr4_lpmr11_fs1), 
  .reg_lpddr4_lpmr11_nt_fs0  (reg_lpddr4_lpmr11_nt_fs0), 
  .reg_lpddr4_lpmr11_nt_fs1  (reg_lpddr4_lpmr11_nt_fs1), 
  .reg_lpddr4_lpmr12_fs0     (reg_lpddr4_lpmr12_fs0), 
  .reg_lpddr4_lpmr12_fs1     (reg_lpddr4_lpmr12_fs1), 
  .reg_lpddr4_lpmr13         (reg_lpddr4_lpmr13), 
  .reg_lpddr4_lpmr14_fs0     (reg_lpddr4_lpmr14_fs0), 
  .reg_lpddr4_lpmr14_fs1     (reg_lpddr4_lpmr14_fs1), 
  .reg_lpddr4_lpmr16         (reg_lpddr4_lpmr16), 
  .reg_lpddr4_lpmr1_fs0      (reg_lpddr4_lpmr1_fs0), 
  .reg_lpddr4_lpmr1_fs1      (reg_lpddr4_lpmr1_fs1), 
  .reg_lpddr4_lpmr22_fs0     (reg_lpddr4_lpmr22_fs0), 
  .reg_lpddr4_lpmr22_fs1     (reg_lpddr4_lpmr22_fs1), 
  .reg_lpddr4_lpmr22_nt_fs0  (reg_lpddr4_lpmr22_nt_fs0), 
  .reg_lpddr4_lpmr22_nt_fs1  (reg_lpddr4_lpmr22_nt_fs1), 
  .reg_lpddr4_lpmr2_fs0      (reg_lpddr4_lpmr2_fs0), 
  .reg_lpddr4_lpmr2_fs1      (reg_lpddr4_lpmr2_fs1), 
  .reg_lpddr4_lpmr3_fs0      (reg_lpddr4_lpmr3_fs0), 
  .reg_lpddr4_lpmr3_fs1      (reg_lpddr4_lpmr3_fs1), 
  .reg_outbypen_dm           (reg_outbypen_dm), 
  .reg_outbypen_dq           (reg_outbypen_dq), 
  .reg_outbypen_dqs          (reg_outbypen_dqs), 
  .reg_outd_dm               (reg_outd_dm), 
  .reg_outd_dq               (reg_outd_dq), 
  .reg_outd_dqs              (reg_outd_dqs), 
  .reg_pbcr_bist_en          (reg_pbcr_bist_en), 
  .reg_pbcr_bist_start       (reg_pbcr_bist_start), 
  .reg_pbcr_lp_en            (reg_pbcr_lp_en), 
  .reg_pbcr_vrefenca         (reg_pbcr_vrefenca), 
  .reg_pbcr_vrefsetca        (reg_pbcr_vrefsetca), 
  .reg_pccr_byp_n            (reg_pccr_byp_n), 
  .reg_pccr_byp_p            (reg_pccr_byp_p), 
  .reg_pccr_bypen            (reg_pccr_bypen), 
  .reg_pccr_en               (reg_pccr_en), 
  .reg_pccr_initcnt          (reg_pccr_initcnt), 
  .reg_pccr_mvg              (reg_pccr_mvg), 
  .reg_pccr_srst             (reg_pccr_srst), 
  .reg_pccr_tpaden           (reg_pccr_tpaden), 
  .reg_pccr_upd              (reg_pccr_upd), 
  .reg_pom_chanen            (reg_pom_chanen), 
  .reg_pom_clklocken         (reg_pom_clklocken), 
  .reg_pom_cmddlyen          (reg_pom_cmddlyen), 
  .reg_pom_ddrt              (reg_pom_ddrt), 
  .reg_pom_dfien             (reg_pom_dfien), 
  .reg_pom_dllrsten          (reg_pom_dllrsten), 
  .reg_pom_dlyevalen         (reg_pom_dlyevalen), 
  .reg_pom_dqsdqen           (reg_pom_dqsdqen), 
  .reg_pom_draminiten        (reg_pom_draminiten), 
  .reg_pom_fs                (reg_pom_fs), 
  .reg_pom_gten              (reg_pom_gten), 
  .reg_pom_odt               (reg_pom_odt), 
  .reg_pom_phyfsen           (reg_pom_phyfsen), 
  .reg_pom_phyinit           (reg_pom_phyinit), 
  .reg_pom_physeten          (reg_pom_physeten), 
  .reg_pom_proc              (reg_pom_proc), 
  .reg_pom_ranken            (reg_pom_ranken), 
  .reg_pom_rdlvlen           (reg_pom_rdlvlen), 
  .reg_pom_sanchken          (reg_pom_sanchken), 
  .reg_pom_vrefcaen          (reg_pom_vrefcaen), 
  .reg_pom_vrefdqrden        (reg_pom_vrefdqrden), 
  .reg_pom_vrefdqwren        (reg_pom_vrefdqwren), 
  .reg_pom_wrlvlen           (reg_pom_wrlvlen), 
  .reg_ptar_ba               (reg_ptar_ba), 
  .reg_ptar_col              (reg_ptar_col), 
  .reg_ptar_row              (reg_ptar_row), 
  .reg_ptsr_actn             (reg_ptsr_actn), 
  .reg_ptsr_ba               (reg_ptsr_ba), 
  .reg_ptsr_ca               (reg_ptsr_ca), 
  .reg_ptsr_cke              (reg_ptsr_cke), 
  .reg_ptsr_cs               (reg_ptsr_cs), 
  .reg_ptsr_dqsdm            (reg_ptsr_dqsdm), 
  .reg_ptsr_dqsdq            (reg_ptsr_dqsdq), 
  .reg_ptsr_dqsleadck        (reg_ptsr_dqsleadck), 
  .reg_ptsr_gt               (reg_ptsr_gt), 
  .reg_ptsr_odt              (reg_ptsr_odt), 
  .reg_ptsr_psck             (reg_ptsr_psck), 
  .reg_ptsr_rdlvldm          (reg_ptsr_rdlvldm), 
  .reg_ptsr_rdlvldq          (reg_ptsr_rdlvldq), 
  .reg_ptsr_rstn             (reg_ptsr_rstn), 
  .reg_ptsr_sanpat           (reg_ptsr_sanpat), 
  .reg_ptsr_vrefcar          (reg_ptsr_vrefcar), 
  .reg_ptsr_vrefcas          (reg_ptsr_vrefcas), 
  .reg_ptsr_vrefdqrd         (reg_ptsr_vrefdqrd), 
  .reg_ptsr_vrefdqrdr        (reg_ptsr_vrefdqrdr), 
  .reg_ptsr_vrefdqwrr        (reg_ptsr_vrefdqwrr), 
  .reg_ptsr_vrefdqwrs        (reg_ptsr_vrefdqwrs), 
  .reg_ptsr_wrlvl            (reg_ptsr_wrlvl), 
  .reg_rd_dbi                (reg_mc_rd_dbi), 
  .reg_rtgc_fs0_trden        (reg_rtgc_fs0_trden), 
  .reg_rtgc_fs0_trdendbi     (reg_rtgc_fs0_trdendbi), 
  .reg_rtgc_fs0_twren        (reg_rtgc_fs0_twren), 
  .reg_rtgc_fs1_trden        (reg_rtgc_fs1_trden), 
  .reg_rtgc_fs1_trdendbi     (reg_rtgc_fs1_trdendbi), 
  .reg_rtgc_fs1_twren        (reg_rtgc_fs1_twren), 
  .reg_rtgc_gt_dis           (reg_rtgc_gt_dis), 
  .reg_rtgc_gt_updt          (reg_rtgc_gt_updt), 
  .reg_t_caent               (reg_t_caent), 
  .reg_t_caent_rb            (), 
  .reg_t_calvl_adr_ckeh_rb   (reg_t_calvladrckeh), 
  .reg_t_calvl_capture_rb    (reg_t_calvlcap), 
  .reg_t_calvl_cc_rb         (reg_t_calvlcc), 
  .reg_t_calvl_en_rb         (reg_t_calvlen), 
  .reg_t_calvl_ext_rb        (reg_t_calvlext), 
  .reg_t_calvl_max_rb        (reg_t_calvl_max), 
  .reg_t_ccd_s_rb            (), 
  .reg_t_ckckeh              (reg_t_ckckeh), 
  .reg_t_ckehdqs             (reg_t_ckehdqs), 
  .reg_t_ckelck              (reg_t_ckelck), 
  .reg_t_ckfspe              (reg_t_ckfspe), 
  .reg_t_ckfspx              (reg_t_ckfspx), 
  .reg_t_dllen               (reg_t_dllen), 
  .reg_t_dlllock             (reg_t_dlllock), 
  .reg_t_dllrst              (reg_t_dllrst), 
  .reg_t_dqrpt               (reg_t_dqrpt), 
  .reg_t_dqscke              (reg_t_dqscke), 
  .reg_t_dtrain              (reg_t_dtrain), 
  .reg_t_fc                  (reg_t_fc), 
  .reg_t_init1               (reg_t_init1), 
  .reg_t_init3               (reg_t_init3), 
  .reg_t_init5               (reg_t_init5), 
  .reg_t_lvlaa               (reg_t_lvlaa), 
  .reg_t_lvldis              (reg_t_lvldis), 
  .reg_t_lvldll              (reg_t_lvldll), 
  .reg_t_lvlexit             (reg_t_lvlexit), 
  .reg_t_lvlload             (reg_t_lvlload), 
  .reg_t_lvlresp             (reg_t_lvlresp), 
  .reg_t_lvlresp_nr          (reg_t_lvlresp_nr), 
  .reg_t_mod                 (reg_t_mod), 
  .reg_t_mpcwr               (reg_t_mpcwr), 
  .reg_t_mpcwr2rd            (reg_t_mpcwr2rd), 
  .reg_t_mrd                 (reg_t_mrd), 
  .reg_t_mrr                 (reg_t_mrr), 
  .reg_t_mrs2act             (reg_t_mrs2act), 
  .reg_t_mrs2lvlen           (reg_t_mrs2lvlen), 
  .reg_t_mrw                 (reg_t_mrw), 
  .reg_t_odth4               (reg_t_odth4), 
  .reg_t_odth8               (reg_t_odth8), 
  .reg_t_odtup               (reg_t_odtup), 
  .reg_t_osco                (reg_t_osco), 
  .reg_t_pori                (reg_t_pori), 
  .reg_t_rcd                 (reg_t_rcd), 
  .reg_t_rp                  (reg_t_rp), 
  .reg_t_rst                 (reg_t_rst), 
  .reg_t_vrcgdis             (reg_t_vrcgdis), 
  .reg_t_vrcgen              (reg_t_vrcgen), 
  .reg_t_vreftimelong        (reg_t_vreftimelong), 
  .reg_t_vreftimeshort       (reg_t_vreftimeshort), 
  .reg_t_xpr                 (reg_t_xpr), 
  .reg_t_zqcal               (reg_t_zqcal), 
  .reg_t_zqinit              (reg_t_zqinit), 
  .reg_t_zqlat               (reg_t_zqlat), 
  .reg_vtgc_ivrefen          (reg_vtgc_ivrefen), 
  .reg_vtgc_ivrefr           (reg_vtgc_ivrefr), 
  .reg_vtgc_ivrefts          (reg_vtgc_ivrefts), 
  .reg_vtgc_vrefcasw         (reg_vtgc_vrefcasw), 
  .reg_vtgc_vrefdqsw         (reg_vtgc_vrefdqsw), 
  .rid_p                     (rid_p), 
  .rlast_p                   (rlast_p), 
  .rresp_p                   (rresp_p), 
  .rvalid_p                  (rvalid_p), 
  .wcb_di_bf                 (wcb_di_bf), 
  .wcb_ra_bf                 (wcb_ra_bf), 
  .wcb_re_n_bf               (wcb_re_n_bf), 
  .wcb_wa_bf                 (wcb_wa_bf), 
  .wcb_we_n_bf               (wcb_we_n_bf), 
  .wready_p                  (wready_p)
); 

dynamo_sram dynamo_sram( 
  .dram_clk      (DTI_MC_CLOCK), 
  .port_clk      (DTI_MC_CLOCK), 
  .rcb_di_bf     (rcb_di_bf), 
  .rcb_ra_bf     (rcb_ra_bf), 
  .rcb_re_n_bf   (rcb_re_n_bf), 
  .rcb_wa_bf     (rcb_wa_bf), 
  .rcb_we_n_bf   (rcb_we_n_bf), 
  .reg_rcb_t_rwm (reg_rcb_t_rwm), 
  .reg_wcb_t_rwm (reg_wcb_t_rwm), 
  .wcb_di_bf     (wcb_di_bf), 
  .wcb_ra_bf     (wcb_ra_bf), 
  .wcb_re_n_bf   (wcb_re_n_bf), 
  .wcb_wa_bf     (wcb_wa_bf), 
  .wcb_we_n_bf   (wcb_we_n_bf), 
  .rcb_do_bf     (rcb_do_bf), 
  .wcb_do_bf     (wcb_do_bf)
); 

// HDL Embedded Text Block 1 EB
  assign DTI_RESET_N_MC      = {(DRAM_CHAN_NUM * FREQUENCY_RATIO){1'b1}}                  ;

endmodule // dynamo


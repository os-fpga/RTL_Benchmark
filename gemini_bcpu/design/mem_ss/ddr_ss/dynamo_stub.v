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
	
	// Stubbed RTL Tie Outputs to 0
	assign JTAG_SO_CLK 		='h0;
	assign JTAG_SO_CTL 		='h0;
  	assign JTAG_SO_DM 		='h0;
  	assign JTAG_SO_DQ 		='h0;
  	assign JTAG_SO_DQS 		='h0;
  	assign PAD_MEM_CLK 		='h0;
  	assign PAD_MEM_CLK_N 		='h0;
  	assign PAD_MEM_CTL 		='h0;
  	assign SO_CLK 			='h0;
  	assign SO_CTL 			='h0;
  	assign SO_DM 			='h0;
  	assign SO_DQ 			='h0;
  	assign SO_RD 			='h0;
  	assign SO_WR 			='h0;
  	assign YC_CLK 			='h0;
  	assign YC_CTL 			='h0;
  	assign Y_DM 			='h0;
  	assign Y_DQ 			='h0;
  	assign Y_DQS 			='h0;
  	assign arready_p 		='h0;
  	assign awready_p 		='h0;
  	assign axi4lite_arready 	='h0;
  	assign axi4lite_awready 	='h0;
  	assign axi4lite_bresp 		='h0;
  	assign axi4lite_bvalid		='h0;
  	assign axi4lite_rdata 		='h0;
  	assign axi4lite_rresp 		='h0;
  	assign axi4lite_rvalid 		='h0;
  	assign axi4lite_wready 		='h0;
  	assign bid_p 			='h0;
  	assign bresp_p 			='h0;
  	assign bvalid_p 		='h0;
  	assign int_gc_fsm 		='h0;
  	assign rdata_p 			='h0;
  	assign rid_p 			='h0;
  	assign rlast_p 			='h0;
  	assign rresp_p 			='h0;
  	assign rvalid_p 		='h0;
  	assign wready_p 		='h0;
endmodule

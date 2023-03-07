// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

module atcdmac300_register(
                            	  aclk,
                            	  aresetn,
                            	  pclk,
                            	  presetn,
                            	  cmd_buff_wr,
                            	  cmd_buff_wdata,
                            	  cmd_buff_full,
                            	  rdata_buff_rd,
                            	  rdata_buff_rdata,
                            	  rdata_buff_empty,
                            	  dma_int,
                            	  dma_soft_reset,
                            	  ch_0_en,
                            	  ch_0_int_tc_mask,
                            	  ch_0_int_err_mask,
                            	  ch_0_int_abt_mask,
                            	  ch_0_src_req_sel,
                            	  ch_0_dst_req_sel,
                            	  ch_0_src_addr_ctl,
                            	  ch_0_dst_addr_ctl,
                            	  ch_0_src_mode,
                            	  ch_0_dst_mode,
                            	  ch_0_src_width,
                            	  ch_0_dst_width,
                            	  ch_0_src_burst_size,
                            	  ch_0_priority,
                            	  ch_0_src_addr,
                            	  ch_0_dst_addr,
                            `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_0_src_bus_inf_idx,
                            	  ch_0_dst_bus_inf_idx,
                            `endif
                            `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  ch_0_llp_reg,
                               `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_0_lld_bus_inf_idx,
                               `endif
                            `endif
                            	  ch_0_tts,
                            	  ch_0_abt,
                            	  ch_1_en,
                            	  ch_1_int_tc_mask,
                            	  ch_1_int_err_mask,
                            	  ch_1_int_abt_mask,
                            	  ch_1_src_req_sel,
                            	  ch_1_dst_req_sel,
                            	  ch_1_src_addr_ctl,
                            	  ch_1_dst_addr_ctl,
                            	  ch_1_src_mode,
                            	  ch_1_dst_mode,
                            	  ch_1_src_width,
                            	  ch_1_dst_width,
                            	  ch_1_src_burst_size,
                            	  ch_1_priority,
                            	  ch_1_src_addr,
                            	  ch_1_dst_addr,
                            `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_1_src_bus_inf_idx,
                            	  ch_1_dst_bus_inf_idx,
                            `endif
                            `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  ch_1_llp_reg,
                               `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_1_lld_bus_inf_idx,
                               `endif
                            `endif
                            	  ch_1_tts,
                            	  ch_1_abt,
                            	  ch_2_en,
                            	  ch_2_int_tc_mask,
                            	  ch_2_int_err_mask,
                            	  ch_2_int_abt_mask,
                            	  ch_2_src_req_sel,
                            	  ch_2_dst_req_sel,
                            	  ch_2_src_addr_ctl,
                            	  ch_2_dst_addr_ctl,
                            	  ch_2_src_mode,
                            	  ch_2_dst_mode,
                            	  ch_2_src_width,
                            	  ch_2_dst_width,
                            	  ch_2_src_burst_size,
                            	  ch_2_priority,
                            	  ch_2_src_addr,
                            	  ch_2_dst_addr,
                            `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_2_src_bus_inf_idx,
                            	  ch_2_dst_bus_inf_idx,
                            `endif
                            `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  ch_2_llp_reg,
                               `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_2_lld_bus_inf_idx,
                               `endif
                            `endif
                            	  ch_2_tts,
                            	  ch_2_abt,
                            	  ch_3_en,
                            	  ch_3_int_tc_mask,
                            	  ch_3_int_err_mask,
                            	  ch_3_int_abt_mask,
                            	  ch_3_src_req_sel,
                            	  ch_3_dst_req_sel,
                            	  ch_3_src_addr_ctl,
                            	  ch_3_dst_addr_ctl,
                            	  ch_3_src_mode,
                            	  ch_3_dst_mode,
                            	  ch_3_src_width,
                            	  ch_3_dst_width,
                            	  ch_3_src_burst_size,
                            	  ch_3_priority,
                            	  ch_3_src_addr,
                            	  ch_3_dst_addr,
                            `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_3_src_bus_inf_idx,
                            	  ch_3_dst_bus_inf_idx,
                            `endif
                            `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  ch_3_llp_reg,
                               `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_3_lld_bus_inf_idx,
                               `endif
                            `endif
                            	  ch_3_tts,
                            	  ch_3_abt,
                            	  ch_4_en,
                            	  ch_4_int_tc_mask,
                            	  ch_4_int_err_mask,
                            	  ch_4_int_abt_mask,
                            	  ch_4_src_req_sel,
                            	  ch_4_dst_req_sel,
                            	  ch_4_src_addr_ctl,
                            	  ch_4_dst_addr_ctl,
                            	  ch_4_src_mode,
                            	  ch_4_dst_mode,
                            	  ch_4_src_width,
                            	  ch_4_dst_width,
                            	  ch_4_src_burst_size,
                            	  ch_4_priority,
                            	  ch_4_src_addr,
                            	  ch_4_dst_addr,
                            `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_4_src_bus_inf_idx,
                            	  ch_4_dst_bus_inf_idx,
                            `endif
                            `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  ch_4_llp_reg,
                               `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_4_lld_bus_inf_idx,
                               `endif
                            `endif
                            	  ch_4_tts,
                            	  ch_4_abt,
                            	  ch_5_en,
                            	  ch_5_int_tc_mask,
                            	  ch_5_int_err_mask,
                            	  ch_5_int_abt_mask,
                            	  ch_5_src_req_sel,
                            	  ch_5_dst_req_sel,
                            	  ch_5_src_addr_ctl,
                            	  ch_5_dst_addr_ctl,
                            	  ch_5_src_mode,
                            	  ch_5_dst_mode,
                            	  ch_5_src_width,
                            	  ch_5_dst_width,
                            	  ch_5_src_burst_size,
                            	  ch_5_priority,
                            	  ch_5_src_addr,
                            	  ch_5_dst_addr,
                            `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_5_src_bus_inf_idx,
                            	  ch_5_dst_bus_inf_idx,
                            `endif
                            `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  ch_5_llp_reg,
                               `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_5_lld_bus_inf_idx,
                               `endif
                            `endif
                            	  ch_5_tts,
                            	  ch_5_abt,
                            	  ch_6_en,
                            	  ch_6_int_tc_mask,
                            	  ch_6_int_err_mask,
                            	  ch_6_int_abt_mask,
                            	  ch_6_src_req_sel,
                            	  ch_6_dst_req_sel,
                            	  ch_6_src_addr_ctl,
                            	  ch_6_dst_addr_ctl,
                            	  ch_6_src_mode,
                            	  ch_6_dst_mode,
                            	  ch_6_src_width,
                            	  ch_6_dst_width,
                            	  ch_6_src_burst_size,
                            	  ch_6_priority,
                            	  ch_6_src_addr,
                            	  ch_6_dst_addr,
                            `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_6_src_bus_inf_idx,
                            	  ch_6_dst_bus_inf_idx,
                            `endif
                            `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  ch_6_llp_reg,
                               `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_6_lld_bus_inf_idx,
                               `endif
                            `endif
                            	  ch_6_tts,
                            	  ch_6_abt,
                            	  ch_7_en,
                            	  ch_7_int_tc_mask,
                            	  ch_7_int_err_mask,
                            	  ch_7_int_abt_mask,
                            	  ch_7_src_req_sel,
                            	  ch_7_dst_req_sel,
                            	  ch_7_src_addr_ctl,
                            	  ch_7_dst_addr_ctl,
                            	  ch_7_src_mode,
                            	  ch_7_dst_mode,
                            	  ch_7_src_width,
                            	  ch_7_dst_width,
                            	  ch_7_src_burst_size,
                            	  ch_7_priority,
                            	  ch_7_src_addr,
                            	  ch_7_dst_addr,
                            `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_7_src_bus_inf_idx,
                            	  ch_7_dst_bus_inf_idx,
                            `endif
                            `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  ch_7_llp_reg,
                               `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  ch_7_lld_bus_inf_idx,
                               `endif
                            `endif
                            	  ch_7_tts,
                            	  ch_7_abt,
                            `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                               `ifdef DMAC_CONFIG_CH0
                            	  dma1_ch_0_ctl_wen,
                            	  dma1_ch_0_en_wen,
                            	  dma1_ch_0_src_addr_wen,
                            	  dma1_ch_0_dst_addr_wen,
                                  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma1_ch_0_llp_wen,
                                  `endif
                            	  dma1_ch_0_tts_wen,
                            	  dma1_ch_0_tc_wen,
                            	  dma1_ch_0_err_wen,
                            	  dma1_ch_0_int_wen,
                               `endif
                               `ifdef DMAC_CONFIG_CH1
                            	  dma1_ch_1_ctl_wen,
                            	  dma1_ch_1_en_wen,
                            	  dma1_ch_1_src_addr_wen,
                            	  dma1_ch_1_dst_addr_wen,
                                  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma1_ch_1_llp_wen,
                                  `endif
                            	  dma1_ch_1_tts_wen,
                            	  dma1_ch_1_tc_wen,
                            	  dma1_ch_1_err_wen,
                            	  dma1_ch_1_int_wen,
                               `endif
                               `ifdef DMAC_CONFIG_CH2
                            	  dma1_ch_2_ctl_wen,
                            	  dma1_ch_2_en_wen,
                            	  dma1_ch_2_src_addr_wen,
                            	  dma1_ch_2_dst_addr_wen,
                                  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma1_ch_2_llp_wen,
                                  `endif
                            	  dma1_ch_2_tts_wen,
                            	  dma1_ch_2_tc_wen,
                            	  dma1_ch_2_err_wen,
                            	  dma1_ch_2_int_wen,
                               `endif
                               `ifdef DMAC_CONFIG_CH3
                            	  dma1_ch_3_ctl_wen,
                            	  dma1_ch_3_en_wen,
                            	  dma1_ch_3_src_addr_wen,
                            	  dma1_ch_3_dst_addr_wen,
                                  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma1_ch_3_llp_wen,
                                  `endif
                            	  dma1_ch_3_tts_wen,
                            	  dma1_ch_3_tc_wen,
                            	  dma1_ch_3_err_wen,
                            	  dma1_ch_3_int_wen,
                               `endif
                               `ifdef DMAC_CONFIG_CH4
                            	  dma1_ch_4_ctl_wen,
                            	  dma1_ch_4_en_wen,
                            	  dma1_ch_4_src_addr_wen,
                            	  dma1_ch_4_dst_addr_wen,
                                  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma1_ch_4_llp_wen,
                                  `endif
                            	  dma1_ch_4_tts_wen,
                            	  dma1_ch_4_tc_wen,
                            	  dma1_ch_4_err_wen,
                            	  dma1_ch_4_int_wen,
                               `endif
                               `ifdef DMAC_CONFIG_CH5
                            	  dma1_ch_5_ctl_wen,
                            	  dma1_ch_5_en_wen,
                            	  dma1_ch_5_src_addr_wen,
                            	  dma1_ch_5_dst_addr_wen,
                                  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma1_ch_5_llp_wen,
                                  `endif
                            	  dma1_ch_5_tts_wen,
                            	  dma1_ch_5_tc_wen,
                            	  dma1_ch_5_err_wen,
                            	  dma1_ch_5_int_wen,
                               `endif
                               `ifdef DMAC_CONFIG_CH6
                            	  dma1_ch_6_ctl_wen,
                            	  dma1_ch_6_en_wen,
                            	  dma1_ch_6_src_addr_wen,
                            	  dma1_ch_6_dst_addr_wen,
                                  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma1_ch_6_llp_wen,
                                  `endif
                            	  dma1_ch_6_tts_wen,
                            	  dma1_ch_6_tc_wen,
                            	  dma1_ch_6_err_wen,
                            	  dma1_ch_6_int_wen,
                               `endif
                               `ifdef DMAC_CONFIG_CH7
                            	  dma1_ch_7_ctl_wen,
                            	  dma1_ch_7_en_wen,
                            	  dma1_ch_7_src_addr_wen,
                            	  dma1_ch_7_dst_addr_wen,
                                  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma1_ch_7_llp_wen,
                                  `endif
                            	  dma1_ch_7_tts_wen,
                            	  dma1_ch_7_tc_wen,
                            	  dma1_ch_7_err_wen,
                            	  dma1_ch_7_int_wen,
                               `endif
                               `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma1_ch_llp_wdata,
                                  `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  dma1_ch_llp_wdata_idx,
                                  `endif
                               `endif
                            	  dma1_ch_ctl_wdata,
                            	  dma1_ch_ctl_wdata_pri,
                               `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  dma1_ch_ctl_wdata_idx,
                               `endif
                            	  dma1_ch_tts_wdata,
                            	  dma1_ch_src_addr_wdata,
                            	  dma1_ch_dst_addr_wdata,
                            `endif
                            `ifdef DMAC_CONFIG_CH0
                            	  dma0_ch_0_ctl_wen,
                            	  dma0_ch_0_en_wen,
                            	  dma0_ch_0_src_addr_wen,
                            	  dma0_ch_0_dst_addr_wen,
                               `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma0_ch_0_llp_wen,
                               `endif
                            	  dma0_ch_0_tts_wen,
                            	  dma0_ch_0_tc_wen,
                            	  dma0_ch_0_err_wen,
                            	  dma0_ch_0_int_wen,
                            `endif
                            `ifdef DMAC_CONFIG_CH1
                            	  dma0_ch_1_ctl_wen,
                            	  dma0_ch_1_en_wen,
                            	  dma0_ch_1_src_addr_wen,
                            	  dma0_ch_1_dst_addr_wen,
                               `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma0_ch_1_llp_wen,
                               `endif
                            	  dma0_ch_1_tts_wen,
                            	  dma0_ch_1_tc_wen,
                            	  dma0_ch_1_err_wen,
                            	  dma0_ch_1_int_wen,
                            `endif
                            `ifdef DMAC_CONFIG_CH2
                            	  dma0_ch_2_ctl_wen,
                            	  dma0_ch_2_en_wen,
                            	  dma0_ch_2_src_addr_wen,
                            	  dma0_ch_2_dst_addr_wen,
                               `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma0_ch_2_llp_wen,
                               `endif
                            	  dma0_ch_2_tts_wen,
                            	  dma0_ch_2_tc_wen,
                            	  dma0_ch_2_err_wen,
                            	  dma0_ch_2_int_wen,
                            `endif
                            `ifdef DMAC_CONFIG_CH3
                            	  dma0_ch_3_ctl_wen,
                            	  dma0_ch_3_en_wen,
                            	  dma0_ch_3_src_addr_wen,
                            	  dma0_ch_3_dst_addr_wen,
                               `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma0_ch_3_llp_wen,
                               `endif
                            	  dma0_ch_3_tts_wen,
                            	  dma0_ch_3_tc_wen,
                            	  dma0_ch_3_err_wen,
                            	  dma0_ch_3_int_wen,
                            `endif
                            `ifdef DMAC_CONFIG_CH4
                            	  dma0_ch_4_ctl_wen,
                            	  dma0_ch_4_en_wen,
                            	  dma0_ch_4_src_addr_wen,
                            	  dma0_ch_4_dst_addr_wen,
                               `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma0_ch_4_llp_wen,
                               `endif
                            	  dma0_ch_4_tts_wen,
                            	  dma0_ch_4_tc_wen,
                            	  dma0_ch_4_err_wen,
                            	  dma0_ch_4_int_wen,
                            `endif
                            `ifdef DMAC_CONFIG_CH5
                            	  dma0_ch_5_ctl_wen,
                            	  dma0_ch_5_en_wen,
                            	  dma0_ch_5_src_addr_wen,
                            	  dma0_ch_5_dst_addr_wen,
                               `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma0_ch_5_llp_wen,
                               `endif
                            	  dma0_ch_5_tts_wen,
                            	  dma0_ch_5_tc_wen,
                            	  dma0_ch_5_err_wen,
                            	  dma0_ch_5_int_wen,
                            `endif
                            `ifdef DMAC_CONFIG_CH6
                            	  dma0_ch_6_ctl_wen,
                            	  dma0_ch_6_en_wen,
                            	  dma0_ch_6_src_addr_wen,
                            	  dma0_ch_6_dst_addr_wen,
                               `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma0_ch_6_llp_wen,
                               `endif
                            	  dma0_ch_6_tts_wen,
                            	  dma0_ch_6_tc_wen,
                            	  dma0_ch_6_err_wen,
                            	  dma0_ch_6_int_wen,
                            `endif
                            `ifdef DMAC_CONFIG_CH7
                            	  dma0_ch_7_ctl_wen,
                            	  dma0_ch_7_en_wen,
                            	  dma0_ch_7_src_addr_wen,
                            	  dma0_ch_7_dst_addr_wen,
                               `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma0_ch_7_llp_wen,
                               `endif
                            	  dma0_ch_7_tts_wen,
                            	  dma0_ch_7_tc_wen,
                            	  dma0_ch_7_err_wen,
                            	  dma0_ch_7_int_wen,
                            `endif
                            `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                            	  dma0_ch_llp_wdata,
                               `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  dma0_ch_llp_wdata_idx,
                               `endif
                            `endif
                            	  dma0_ch_ctl_wdata,
                            	  dma0_ch_ctl_wdata_pri,
                            `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                            	  dma0_ch_ctl_wdata_idx,
                            `endif
                            	  dma0_ch_tts_wdata,
                            	  dma0_ch_src_addr_wdata,
                            	  dma0_ch_dst_addr_wdata
);
localparam      ADDR_WIDTH = `ATCDMAC300_ADDR_WIDTH;
localparam	ADDR_MSB	= `ATCDMAC300_ADDR_WIDTH - 1;
localparam	ADDR_WEN_MSB	= ADDR_MSB > 31 ? 1 : 0;


input          				aclk;
input          				aresetn;
input          				pclk;
input          				presetn;

input					cmd_buff_wr;
input	[39:0]				cmd_buff_wdata;
output					cmd_buff_full;
input					rdata_buff_rd;
output	[31:0]				rdata_buff_rdata;
output					rdata_buff_empty;

output					dma_int;
output					dma_soft_reset;

wire                			id_sel;
wire                			config_sel;
wire					dmac_ctl_sel;
wire					ch_status_w_sel;
wire					ch_status_r_sel;
wire					ch_en_sel;
wire					ch_abort_sel;
wire	[7:0]				status_tc;
wire	[7:0]				status_abt;
wire	[7:0]				status_err;
wire	[7:0]				status_int;
wire	[31:0]				ch_status;
wire	[31:0]				ch_en;

wire	[3:0]				ch_num 		=    `ATCDMAC300_CH_NUM;
wire	[5:0]				fifo_depth	=    `ATCDMAC300_FIFO_DEPTH;
wire	[4:0]				req_ack_num	= 5'd`ATCDMAC300_REQ_ACK_NUM;
wire	[6:0]				addr_msb	= 7'd`ATCDMAC300_ADDR_WIDTH;

output					ch_0_en;
output					ch_0_int_tc_mask;
output					ch_0_int_err_mask;
output					ch_0_int_abt_mask;
output	[3:0]				ch_0_src_req_sel;
output	[3:0]				ch_0_dst_req_sel;
output	[1:0]				ch_0_src_addr_ctl;
output	[1:0]				ch_0_dst_addr_ctl;
output					ch_0_src_mode;
output					ch_0_dst_mode;
output 	[2:0]				ch_0_src_width;
output 	[2:0]				ch_0_dst_width;
output	[3:0]				ch_0_src_burst_size;
output					ch_0_priority;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_0_src_addr;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_0_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_0_src_bus_inf_idx;
output					ch_0_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_0_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_0_lld_bus_inf_idx;
	`endif
`endif
output	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_0_tts;
output					ch_0_abt;
output					ch_1_en;
output					ch_1_int_tc_mask;
output					ch_1_int_err_mask;
output					ch_1_int_abt_mask;
output	[3:0]				ch_1_src_req_sel;
output	[3:0]				ch_1_dst_req_sel;
output	[1:0]				ch_1_src_addr_ctl;
output	[1:0]				ch_1_dst_addr_ctl;
output					ch_1_src_mode;
output					ch_1_dst_mode;
output 	[2:0]				ch_1_src_width;
output 	[2:0]				ch_1_dst_width;
output	[3:0]				ch_1_src_burst_size;
output					ch_1_priority;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_1_src_addr;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_1_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_1_src_bus_inf_idx;
output					ch_1_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_1_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_1_lld_bus_inf_idx;
	`endif
`endif
output	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_1_tts;
output					ch_1_abt;
output					ch_2_en;
output					ch_2_int_tc_mask;
output					ch_2_int_err_mask;
output					ch_2_int_abt_mask;
output	[3:0]				ch_2_src_req_sel;
output	[3:0]				ch_2_dst_req_sel;
output	[1:0]				ch_2_src_addr_ctl;
output	[1:0]				ch_2_dst_addr_ctl;
output					ch_2_src_mode;
output					ch_2_dst_mode;
output 	[2:0]				ch_2_src_width;
output 	[2:0]				ch_2_dst_width;
output	[3:0]				ch_2_src_burst_size;
output					ch_2_priority;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_2_src_addr;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_2_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_2_src_bus_inf_idx;
output					ch_2_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_2_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_2_lld_bus_inf_idx;
	`endif
`endif
output	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_2_tts;
output					ch_2_abt;
output					ch_3_en;
output					ch_3_int_tc_mask;
output					ch_3_int_err_mask;
output					ch_3_int_abt_mask;
output	[3:0]				ch_3_src_req_sel;
output	[3:0]				ch_3_dst_req_sel;
output	[1:0]				ch_3_src_addr_ctl;
output	[1:0]				ch_3_dst_addr_ctl;
output					ch_3_src_mode;
output					ch_3_dst_mode;
output 	[2:0]				ch_3_src_width;
output 	[2:0]				ch_3_dst_width;
output	[3:0]				ch_3_src_burst_size;
output					ch_3_priority;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_3_src_addr;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_3_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_3_src_bus_inf_idx;
output					ch_3_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_3_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_3_lld_bus_inf_idx;
	`endif
`endif
output	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_3_tts;
output					ch_3_abt;
output					ch_4_en;
output					ch_4_int_tc_mask;
output					ch_4_int_err_mask;
output					ch_4_int_abt_mask;
output	[3:0]				ch_4_src_req_sel;
output	[3:0]				ch_4_dst_req_sel;
output	[1:0]				ch_4_src_addr_ctl;
output	[1:0]				ch_4_dst_addr_ctl;
output					ch_4_src_mode;
output					ch_4_dst_mode;
output 	[2:0]				ch_4_src_width;
output 	[2:0]				ch_4_dst_width;
output	[3:0]				ch_4_src_burst_size;
output					ch_4_priority;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_4_src_addr;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_4_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_4_src_bus_inf_idx;
output					ch_4_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_4_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_4_lld_bus_inf_idx;
	`endif
`endif
output	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_4_tts;
output					ch_4_abt;
output					ch_5_en;
output					ch_5_int_tc_mask;
output					ch_5_int_err_mask;
output					ch_5_int_abt_mask;
output	[3:0]				ch_5_src_req_sel;
output	[3:0]				ch_5_dst_req_sel;
output	[1:0]				ch_5_src_addr_ctl;
output	[1:0]				ch_5_dst_addr_ctl;
output					ch_5_src_mode;
output					ch_5_dst_mode;
output 	[2:0]				ch_5_src_width;
output 	[2:0]				ch_5_dst_width;
output	[3:0]				ch_5_src_burst_size;
output					ch_5_priority;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_5_src_addr;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_5_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_5_src_bus_inf_idx;
output					ch_5_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_5_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_5_lld_bus_inf_idx;
	`endif
`endif
output	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_5_tts;
output					ch_5_abt;
output					ch_6_en;
output					ch_6_int_tc_mask;
output					ch_6_int_err_mask;
output					ch_6_int_abt_mask;
output	[3:0]				ch_6_src_req_sel;
output	[3:0]				ch_6_dst_req_sel;
output	[1:0]				ch_6_src_addr_ctl;
output	[1:0]				ch_6_dst_addr_ctl;
output					ch_6_src_mode;
output					ch_6_dst_mode;
output 	[2:0]				ch_6_src_width;
output 	[2:0]				ch_6_dst_width;
output	[3:0]				ch_6_src_burst_size;
output					ch_6_priority;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_6_src_addr;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_6_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_6_src_bus_inf_idx;
output					ch_6_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_6_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_6_lld_bus_inf_idx;
	`endif
`endif
output	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_6_tts;
output					ch_6_abt;
output					ch_7_en;
output					ch_7_int_tc_mask;
output					ch_7_int_err_mask;
output					ch_7_int_abt_mask;
output	[3:0]				ch_7_src_req_sel;
output	[3:0]				ch_7_dst_req_sel;
output	[1:0]				ch_7_src_addr_ctl;
output	[1:0]				ch_7_dst_addr_ctl;
output					ch_7_src_mode;
output					ch_7_dst_mode;
output 	[2:0]				ch_7_src_width;
output 	[2:0]				ch_7_dst_width;
output	[3:0]				ch_7_src_burst_size;
output					ch_7_priority;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_7_src_addr;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_7_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_7_src_bus_inf_idx;
output					ch_7_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_7_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					ch_7_lld_bus_inf_idx;
	`endif
`endif
output	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_7_tts;
output					ch_7_abt;

`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH0
input					dma1_ch_0_ctl_wen;
input					dma1_ch_0_en_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_0_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_0_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma1_ch_0_llp_wen;
		`endif
input					dma1_ch_0_tts_wen;
input					dma1_ch_0_tc_wen;
input					dma1_ch_0_err_wen;
input					dma1_ch_0_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH1
input					dma1_ch_1_ctl_wen;
input					dma1_ch_1_en_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_1_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_1_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma1_ch_1_llp_wen;
		`endif
input					dma1_ch_1_tts_wen;
input					dma1_ch_1_tc_wen;
input					dma1_ch_1_err_wen;
input					dma1_ch_1_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH2
input					dma1_ch_2_ctl_wen;
input					dma1_ch_2_en_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_2_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_2_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma1_ch_2_llp_wen;
		`endif
input					dma1_ch_2_tts_wen;
input					dma1_ch_2_tc_wen;
input					dma1_ch_2_err_wen;
input					dma1_ch_2_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH3
input					dma1_ch_3_ctl_wen;
input					dma1_ch_3_en_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_3_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_3_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma1_ch_3_llp_wen;
		`endif
input					dma1_ch_3_tts_wen;
input					dma1_ch_3_tc_wen;
input					dma1_ch_3_err_wen;
input					dma1_ch_3_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH4
input					dma1_ch_4_ctl_wen;
input					dma1_ch_4_en_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_4_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_4_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma1_ch_4_llp_wen;
		`endif
input					dma1_ch_4_tts_wen;
input					dma1_ch_4_tc_wen;
input					dma1_ch_4_err_wen;
input					dma1_ch_4_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH5
input					dma1_ch_5_ctl_wen;
input					dma1_ch_5_en_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_5_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_5_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma1_ch_5_llp_wen;
		`endif
input					dma1_ch_5_tts_wen;
input					dma1_ch_5_tc_wen;
input					dma1_ch_5_err_wen;
input					dma1_ch_5_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH6
input					dma1_ch_6_ctl_wen;
input					dma1_ch_6_en_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_6_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_6_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma1_ch_6_llp_wen;
		`endif
input					dma1_ch_6_tts_wen;
input					dma1_ch_6_tc_wen;
input					dma1_ch_6_err_wen;
input					dma1_ch_6_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH7
input					dma1_ch_7_ctl_wen;
input					dma1_ch_7_en_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_7_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_7_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma1_ch_7_llp_wen;
		`endif
input					dma1_ch_7_tts_wen;
input					dma1_ch_7_tc_wen;
input					dma1_ch_7_err_wen;
input					dma1_ch_7_int_wen;
	`endif
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	dma1_ch_llp_wdata;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					dma1_ch_llp_wdata_idx;
	`endif
	`endif
input	[27:1]				dma1_ch_ctl_wdata;
input					dma1_ch_ctl_wdata_pri;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input	[1:0]				dma1_ch_ctl_wdata_idx;
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	dma1_ch_tts_wdata;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma1_ch_src_addr_wdata;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma1_ch_dst_addr_wdata;
`endif

`ifdef DMAC_CONFIG_CH0
input					dma0_ch_0_ctl_wen;
input					dma0_ch_0_en_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_0_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_0_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma0_ch_0_llp_wen;
	`endif
input					dma0_ch_0_tts_wen;
input					dma0_ch_0_tc_wen;
input					dma0_ch_0_err_wen;
input					dma0_ch_0_int_wen;
`endif
`ifdef DMAC_CONFIG_CH1
input					dma0_ch_1_ctl_wen;
input					dma0_ch_1_en_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_1_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_1_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma0_ch_1_llp_wen;
	`endif
input					dma0_ch_1_tts_wen;
input					dma0_ch_1_tc_wen;
input					dma0_ch_1_err_wen;
input					dma0_ch_1_int_wen;
`endif
`ifdef DMAC_CONFIG_CH2
input					dma0_ch_2_ctl_wen;
input					dma0_ch_2_en_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_2_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_2_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma0_ch_2_llp_wen;
	`endif
input					dma0_ch_2_tts_wen;
input					dma0_ch_2_tc_wen;
input					dma0_ch_2_err_wen;
input					dma0_ch_2_int_wen;
`endif
`ifdef DMAC_CONFIG_CH3
input					dma0_ch_3_ctl_wen;
input					dma0_ch_3_en_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_3_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_3_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma0_ch_3_llp_wen;
	`endif
input					dma0_ch_3_tts_wen;
input					dma0_ch_3_tc_wen;
input					dma0_ch_3_err_wen;
input					dma0_ch_3_int_wen;
`endif
`ifdef DMAC_CONFIG_CH4
input					dma0_ch_4_ctl_wen;
input					dma0_ch_4_en_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_4_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_4_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma0_ch_4_llp_wen;
	`endif
input					dma0_ch_4_tts_wen;
input					dma0_ch_4_tc_wen;
input					dma0_ch_4_err_wen;
input					dma0_ch_4_int_wen;
`endif
`ifdef DMAC_CONFIG_CH5
input					dma0_ch_5_ctl_wen;
input					dma0_ch_5_en_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_5_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_5_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma0_ch_5_llp_wen;
	`endif
input					dma0_ch_5_tts_wen;
input					dma0_ch_5_tc_wen;
input					dma0_ch_5_err_wen;
input					dma0_ch_5_int_wen;
`endif
`ifdef DMAC_CONFIG_CH6
input					dma0_ch_6_ctl_wen;
input					dma0_ch_6_en_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_6_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_6_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma0_ch_6_llp_wen;
	`endif
input					dma0_ch_6_tts_wen;
input					dma0_ch_6_tc_wen;
input					dma0_ch_6_err_wen;
input					dma0_ch_6_int_wen;
`endif
`ifdef DMAC_CONFIG_CH7
input					dma0_ch_7_ctl_wen;
input					dma0_ch_7_en_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_7_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_7_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma0_ch_7_llp_wen;
	`endif
input					dma0_ch_7_tts_wen;
input					dma0_ch_7_tc_wen;
input					dma0_ch_7_err_wen;
input					dma0_ch_7_int_wen;
`endif

`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	dma0_ch_llp_wdata;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					dma0_ch_llp_wdata_idx;
	`endif
`endif
input	[27:1]				dma0_ch_ctl_wdata;
input					dma0_ch_ctl_wdata_pri;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input	[1:0]				dma0_ch_ctl_wdata_idx;
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	dma0_ch_tts_wdata;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma0_ch_src_addr_wdata;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma0_ch_dst_addr_wdata;

`ifdef DMAC_CONFIG_CH0
wire					ch_0_ctl_r_sel;
wire					ch_0_src_addr_r_sel;
wire					ch_0_dst_addr_r_sel;
wire					ch_0_tts_r_sel;
wire					ch_0_ctl_w_sel;
wire					ch_0_src_addr_w_sel;
wire					ch_0_dst_addr_w_sel;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_0_llp_r_sel;
wire					ch_0_llp_w_sel;
wire	[(`ATCDMAC300_ADDR_WIDTH-1):0] 	ch_0_llp;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_0_lld_bus_inf_idx;
		`else
wire					ch_0_lld_bus_inf_idx = 1'b0;
		`endif
	`endif
wire					ch_0_tts_w_sel;
reg					ch_0_en;
reg					ch_0_int_tc_mask;
reg					ch_0_int_err_mask;
reg					ch_0_int_abt_mask;
reg	[3:0]				ch_0_src_req_sel;
reg	[3:0]				ch_0_dst_req_sel;
reg	[1:0]				ch_0_src_addr_ctl;
reg	[1:0]				ch_0_dst_addr_ctl;
reg					ch_0_src_mode;
reg					ch_0_dst_mode;
reg	[2:0]				ch_0_src_width;
reg	[2:0]				ch_0_dst_width;
reg	[3:0]				ch_0_src_burst_size;
reg					ch_0_priority;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_0_src_bus_inf_idx;
reg					ch_0_dst_bus_inf_idx;
	`else
wire					ch_0_src_bus_inf_idx = 1'b0;
wire					ch_0_dst_bus_inf_idx = 1'b0;
	`endif
wire	[31:0]				ch_0_ctl;
reg	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_0_tts;
reg					ch_0_tc;
reg					ch_0_abt;
reg					ch_0_err;
reg					ch_0_int;
wire					ch_0_tc_nxt;
wire					ch_0_abt_nxt;
wire					ch_0_err_nxt;
wire					ch_0_int_nxt;
`else
wire					ch_0_en  = 1'b0;
wire	[3:0]				ch_0_src_req_sel = 4'b0;
wire	[3:0]				ch_0_dst_req_sel = 4'b0;
wire	[1:0]				ch_0_src_addr_ctl = 2'b0;
wire	[1:0]				ch_0_dst_addr_ctl = 2'b0;
wire					ch_0_src_mode = 1'b0;
wire					ch_0_dst_mode = 1'b0;
wire 	[2:0]				ch_0_src_width = 3'b0;
wire 	[2:0]				ch_0_dst_width = 3'b0;
wire	[3:0]				ch_0_src_burst_size = 4'b0;
wire					ch_0_priority = 1'b0;
wire					ch_0_src_bus_inf_idx = 1'b0;
wire					ch_0_dst_bus_inf_idx = 1'b0;
wire	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_0_tts = {`ATCDMAC300_TTS_WIDTH{1'b0}};
wire					ch_0_tc  = 1'b0;
wire					ch_0_abt = 1'b0;
wire					ch_0_err = 1'b0;
wire					ch_0_int = 1'b0;
wire					ch_0_int_tc_mask = 1'b0;
wire					ch_0_int_err_mask = 1'b0;
wire					ch_0_int_abt_mask = 1'b0;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_0_lld_bus_inf_idx = 1'b0;
	`endif
`endif
`ifdef DMAC_CONFIG_CH1
wire					ch_1_ctl_r_sel;
wire					ch_1_src_addr_r_sel;
wire					ch_1_dst_addr_r_sel;
wire					ch_1_tts_r_sel;
wire					ch_1_ctl_w_sel;
wire					ch_1_src_addr_w_sel;
wire					ch_1_dst_addr_w_sel;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_1_llp_r_sel;
wire					ch_1_llp_w_sel;
wire	[(`ATCDMAC300_ADDR_WIDTH-1):0] 	ch_1_llp;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_1_lld_bus_inf_idx;
		`else
wire					ch_1_lld_bus_inf_idx = 1'b0;
		`endif
	`endif
wire					ch_1_tts_w_sel;
reg					ch_1_en;
reg					ch_1_int_tc_mask;
reg					ch_1_int_err_mask;
reg					ch_1_int_abt_mask;
reg	[3:0]				ch_1_src_req_sel;
reg	[3:0]				ch_1_dst_req_sel;
reg	[1:0]				ch_1_src_addr_ctl;
reg	[1:0]				ch_1_dst_addr_ctl;
reg					ch_1_src_mode;
reg					ch_1_dst_mode;
reg	[2:0]				ch_1_src_width;
reg	[2:0]				ch_1_dst_width;
reg	[3:0]				ch_1_src_burst_size;
reg					ch_1_priority;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_1_src_bus_inf_idx;
reg					ch_1_dst_bus_inf_idx;
	`else
wire					ch_1_src_bus_inf_idx = 1'b0;
wire					ch_1_dst_bus_inf_idx = 1'b0;
	`endif
wire	[31:0]				ch_1_ctl;
reg	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_1_tts;
reg					ch_1_tc;
reg					ch_1_abt;
reg					ch_1_err;
reg					ch_1_int;
wire					ch_1_tc_nxt;
wire					ch_1_abt_nxt;
wire					ch_1_err_nxt;
wire					ch_1_int_nxt;
`else
wire					ch_1_en  = 1'b0;
wire	[3:0]				ch_1_src_req_sel = 4'b0;
wire	[3:0]				ch_1_dst_req_sel = 4'b0;
wire	[1:0]				ch_1_src_addr_ctl = 2'b0;
wire	[1:0]				ch_1_dst_addr_ctl = 2'b0;
wire					ch_1_src_mode = 1'b0;
wire					ch_1_dst_mode = 1'b0;
wire 	[2:0]				ch_1_src_width = 3'b0;
wire 	[2:0]				ch_1_dst_width = 3'b0;
wire	[3:0]				ch_1_src_burst_size = 4'b0;
wire					ch_1_priority = 1'b0;
wire					ch_1_src_bus_inf_idx = 1'b0;
wire					ch_1_dst_bus_inf_idx = 1'b0;
wire	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_1_tts = {`ATCDMAC300_TTS_WIDTH{1'b0}};
wire					ch_1_tc  = 1'b0;
wire					ch_1_abt = 1'b0;
wire					ch_1_err = 1'b0;
wire					ch_1_int = 1'b0;
wire					ch_1_int_tc_mask = 1'b0;
wire					ch_1_int_err_mask = 1'b0;
wire					ch_1_int_abt_mask = 1'b0;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_1_lld_bus_inf_idx = 1'b0;
	`endif
`endif
`ifdef DMAC_CONFIG_CH2
wire					ch_2_ctl_r_sel;
wire					ch_2_src_addr_r_sel;
wire					ch_2_dst_addr_r_sel;
wire					ch_2_tts_r_sel;
wire					ch_2_ctl_w_sel;
wire					ch_2_src_addr_w_sel;
wire					ch_2_dst_addr_w_sel;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_2_llp_r_sel;
wire					ch_2_llp_w_sel;
wire	[(`ATCDMAC300_ADDR_WIDTH-1):0] 	ch_2_llp;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_2_lld_bus_inf_idx;
		`else
wire					ch_2_lld_bus_inf_idx = 1'b0;
		`endif
	`endif
wire					ch_2_tts_w_sel;
reg					ch_2_en;
reg					ch_2_int_tc_mask;
reg					ch_2_int_err_mask;
reg					ch_2_int_abt_mask;
reg	[3:0]				ch_2_src_req_sel;
reg	[3:0]				ch_2_dst_req_sel;
reg	[1:0]				ch_2_src_addr_ctl;
reg	[1:0]				ch_2_dst_addr_ctl;
reg					ch_2_src_mode;
reg					ch_2_dst_mode;
reg	[2:0]				ch_2_src_width;
reg	[2:0]				ch_2_dst_width;
reg	[3:0]				ch_2_src_burst_size;
reg					ch_2_priority;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_2_src_bus_inf_idx;
reg					ch_2_dst_bus_inf_idx;
	`else
wire					ch_2_src_bus_inf_idx = 1'b0;
wire					ch_2_dst_bus_inf_idx = 1'b0;
	`endif
wire	[31:0]				ch_2_ctl;
reg	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_2_tts;
reg					ch_2_tc;
reg					ch_2_abt;
reg					ch_2_err;
reg					ch_2_int;
wire					ch_2_tc_nxt;
wire					ch_2_abt_nxt;
wire					ch_2_err_nxt;
wire					ch_2_int_nxt;
`else
wire					ch_2_en  = 1'b0;
wire	[3:0]				ch_2_src_req_sel = 4'b0;
wire	[3:0]				ch_2_dst_req_sel = 4'b0;
wire	[1:0]				ch_2_src_addr_ctl = 2'b0;
wire	[1:0]				ch_2_dst_addr_ctl = 2'b0;
wire					ch_2_src_mode = 1'b0;
wire					ch_2_dst_mode = 1'b0;
wire 	[2:0]				ch_2_src_width = 3'b0;
wire 	[2:0]				ch_2_dst_width = 3'b0;
wire	[3:0]				ch_2_src_burst_size = 4'b0;
wire					ch_2_priority = 1'b0;
wire					ch_2_src_bus_inf_idx = 1'b0;
wire					ch_2_dst_bus_inf_idx = 1'b0;
wire	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_2_tts = {`ATCDMAC300_TTS_WIDTH{1'b0}};
wire					ch_2_tc  = 1'b0;
wire					ch_2_abt = 1'b0;
wire					ch_2_err = 1'b0;
wire					ch_2_int = 1'b0;
wire					ch_2_int_tc_mask = 1'b0;
wire					ch_2_int_err_mask = 1'b0;
wire					ch_2_int_abt_mask = 1'b0;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_2_lld_bus_inf_idx = 1'b0;
	`endif
`endif
`ifdef DMAC_CONFIG_CH3
wire					ch_3_ctl_r_sel;
wire					ch_3_src_addr_r_sel;
wire					ch_3_dst_addr_r_sel;
wire					ch_3_tts_r_sel;
wire					ch_3_ctl_w_sel;
wire					ch_3_src_addr_w_sel;
wire					ch_3_dst_addr_w_sel;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_3_llp_r_sel;
wire					ch_3_llp_w_sel;
wire	[(`ATCDMAC300_ADDR_WIDTH-1):0] 	ch_3_llp;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_3_lld_bus_inf_idx;
		`else
wire					ch_3_lld_bus_inf_idx = 1'b0;
		`endif
	`endif
wire					ch_3_tts_w_sel;
reg					ch_3_en;
reg					ch_3_int_tc_mask;
reg					ch_3_int_err_mask;
reg					ch_3_int_abt_mask;
reg	[3:0]				ch_3_src_req_sel;
reg	[3:0]				ch_3_dst_req_sel;
reg	[1:0]				ch_3_src_addr_ctl;
reg	[1:0]				ch_3_dst_addr_ctl;
reg					ch_3_src_mode;
reg					ch_3_dst_mode;
reg	[2:0]				ch_3_src_width;
reg	[2:0]				ch_3_dst_width;
reg	[3:0]				ch_3_src_burst_size;
reg					ch_3_priority;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_3_src_bus_inf_idx;
reg					ch_3_dst_bus_inf_idx;
	`else
wire					ch_3_src_bus_inf_idx = 1'b0;
wire					ch_3_dst_bus_inf_idx = 1'b0;
	`endif
wire	[31:0]				ch_3_ctl;
reg	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_3_tts;
reg					ch_3_tc;
reg					ch_3_abt;
reg					ch_3_err;
reg					ch_3_int;
wire					ch_3_tc_nxt;
wire					ch_3_abt_nxt;
wire					ch_3_err_nxt;
wire					ch_3_int_nxt;
`else
wire					ch_3_en  = 1'b0;
wire	[3:0]				ch_3_src_req_sel = 4'b0;
wire	[3:0]				ch_3_dst_req_sel = 4'b0;
wire	[1:0]				ch_3_src_addr_ctl = 2'b0;
wire	[1:0]				ch_3_dst_addr_ctl = 2'b0;
wire					ch_3_src_mode = 1'b0;
wire					ch_3_dst_mode = 1'b0;
wire 	[2:0]				ch_3_src_width = 3'b0;
wire 	[2:0]				ch_3_dst_width = 3'b0;
wire	[3:0]				ch_3_src_burst_size = 4'b0;
wire					ch_3_priority = 1'b0;
wire					ch_3_src_bus_inf_idx = 1'b0;
wire					ch_3_dst_bus_inf_idx = 1'b0;
wire	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_3_tts = {`ATCDMAC300_TTS_WIDTH{1'b0}};
wire					ch_3_tc  = 1'b0;
wire					ch_3_abt = 1'b0;
wire					ch_3_err = 1'b0;
wire					ch_3_int = 1'b0;
wire					ch_3_int_tc_mask = 1'b0;
wire					ch_3_int_err_mask = 1'b0;
wire					ch_3_int_abt_mask = 1'b0;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_3_lld_bus_inf_idx = 1'b0;
	`endif
`endif
`ifdef DMAC_CONFIG_CH4
wire					ch_4_ctl_r_sel;
wire					ch_4_src_addr_r_sel;
wire					ch_4_dst_addr_r_sel;
wire					ch_4_tts_r_sel;
wire					ch_4_ctl_w_sel;
wire					ch_4_src_addr_w_sel;
wire					ch_4_dst_addr_w_sel;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_4_llp_r_sel;
wire					ch_4_llp_w_sel;
wire	[(`ATCDMAC300_ADDR_WIDTH-1):0] 	ch_4_llp;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_4_lld_bus_inf_idx;
		`else
wire					ch_4_lld_bus_inf_idx = 1'b0;
		`endif
	`endif
wire					ch_4_tts_w_sel;
reg					ch_4_en;
reg					ch_4_int_tc_mask;
reg					ch_4_int_err_mask;
reg					ch_4_int_abt_mask;
reg	[3:0]				ch_4_src_req_sel;
reg	[3:0]				ch_4_dst_req_sel;
reg	[1:0]				ch_4_src_addr_ctl;
reg	[1:0]				ch_4_dst_addr_ctl;
reg					ch_4_src_mode;
reg					ch_4_dst_mode;
reg	[2:0]				ch_4_src_width;
reg	[2:0]				ch_4_dst_width;
reg	[3:0]				ch_4_src_burst_size;
reg					ch_4_priority;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_4_src_bus_inf_idx;
reg					ch_4_dst_bus_inf_idx;
	`else
wire					ch_4_src_bus_inf_idx = 1'b0;
wire					ch_4_dst_bus_inf_idx = 1'b0;
	`endif
wire	[31:0]				ch_4_ctl;
reg	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_4_tts;
reg					ch_4_tc;
reg					ch_4_abt;
reg					ch_4_err;
reg					ch_4_int;
wire					ch_4_tc_nxt;
wire					ch_4_abt_nxt;
wire					ch_4_err_nxt;
wire					ch_4_int_nxt;
`else
wire					ch_4_en  = 1'b0;
wire	[3:0]				ch_4_src_req_sel = 4'b0;
wire	[3:0]				ch_4_dst_req_sel = 4'b0;
wire	[1:0]				ch_4_src_addr_ctl = 2'b0;
wire	[1:0]				ch_4_dst_addr_ctl = 2'b0;
wire					ch_4_src_mode = 1'b0;
wire					ch_4_dst_mode = 1'b0;
wire 	[2:0]				ch_4_src_width = 3'b0;
wire 	[2:0]				ch_4_dst_width = 3'b0;
wire	[3:0]				ch_4_src_burst_size = 4'b0;
wire					ch_4_priority = 1'b0;
wire					ch_4_src_bus_inf_idx = 1'b0;
wire					ch_4_dst_bus_inf_idx = 1'b0;
wire	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_4_tts = {`ATCDMAC300_TTS_WIDTH{1'b0}};
wire					ch_4_tc  = 1'b0;
wire					ch_4_abt = 1'b0;
wire					ch_4_err = 1'b0;
wire					ch_4_int = 1'b0;
wire					ch_4_int_tc_mask = 1'b0;
wire					ch_4_int_err_mask = 1'b0;
wire					ch_4_int_abt_mask = 1'b0;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_4_lld_bus_inf_idx = 1'b0;
	`endif
`endif
`ifdef DMAC_CONFIG_CH5
wire					ch_5_ctl_r_sel;
wire					ch_5_src_addr_r_sel;
wire					ch_5_dst_addr_r_sel;
wire					ch_5_tts_r_sel;
wire					ch_5_ctl_w_sel;
wire					ch_5_src_addr_w_sel;
wire					ch_5_dst_addr_w_sel;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_5_llp_r_sel;
wire					ch_5_llp_w_sel;
wire	[(`ATCDMAC300_ADDR_WIDTH-1):0] 	ch_5_llp;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_5_lld_bus_inf_idx;
		`else
wire					ch_5_lld_bus_inf_idx = 1'b0;
		`endif
	`endif
wire					ch_5_tts_w_sel;
reg					ch_5_en;
reg					ch_5_int_tc_mask;
reg					ch_5_int_err_mask;
reg					ch_5_int_abt_mask;
reg	[3:0]				ch_5_src_req_sel;
reg	[3:0]				ch_5_dst_req_sel;
reg	[1:0]				ch_5_src_addr_ctl;
reg	[1:0]				ch_5_dst_addr_ctl;
reg					ch_5_src_mode;
reg					ch_5_dst_mode;
reg	[2:0]				ch_5_src_width;
reg	[2:0]				ch_5_dst_width;
reg	[3:0]				ch_5_src_burst_size;
reg					ch_5_priority;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_5_src_bus_inf_idx;
reg					ch_5_dst_bus_inf_idx;
	`else
wire					ch_5_src_bus_inf_idx = 1'b0;
wire					ch_5_dst_bus_inf_idx = 1'b0;
	`endif
wire	[31:0]				ch_5_ctl;
reg	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_5_tts;
reg					ch_5_tc;
reg					ch_5_abt;
reg					ch_5_err;
reg					ch_5_int;
wire					ch_5_tc_nxt;
wire					ch_5_abt_nxt;
wire					ch_5_err_nxt;
wire					ch_5_int_nxt;
`else
wire					ch_5_en  = 1'b0;
wire	[3:0]				ch_5_src_req_sel = 4'b0;
wire	[3:0]				ch_5_dst_req_sel = 4'b0;
wire	[1:0]				ch_5_src_addr_ctl = 2'b0;
wire	[1:0]				ch_5_dst_addr_ctl = 2'b0;
wire					ch_5_src_mode = 1'b0;
wire					ch_5_dst_mode = 1'b0;
wire 	[2:0]				ch_5_src_width = 3'b0;
wire 	[2:0]				ch_5_dst_width = 3'b0;
wire	[3:0]				ch_5_src_burst_size = 4'b0;
wire					ch_5_priority = 1'b0;
wire					ch_5_src_bus_inf_idx = 1'b0;
wire					ch_5_dst_bus_inf_idx = 1'b0;
wire	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_5_tts = {`ATCDMAC300_TTS_WIDTH{1'b0}};
wire					ch_5_tc  = 1'b0;
wire					ch_5_abt = 1'b0;
wire					ch_5_err = 1'b0;
wire					ch_5_int = 1'b0;
wire					ch_5_int_tc_mask = 1'b0;
wire					ch_5_int_err_mask = 1'b0;
wire					ch_5_int_abt_mask = 1'b0;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_5_lld_bus_inf_idx = 1'b0;
	`endif
`endif
`ifdef DMAC_CONFIG_CH6
wire					ch_6_ctl_r_sel;
wire					ch_6_src_addr_r_sel;
wire					ch_6_dst_addr_r_sel;
wire					ch_6_tts_r_sel;
wire					ch_6_ctl_w_sel;
wire					ch_6_src_addr_w_sel;
wire					ch_6_dst_addr_w_sel;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_6_llp_r_sel;
wire					ch_6_llp_w_sel;
wire	[(`ATCDMAC300_ADDR_WIDTH-1):0] 	ch_6_llp;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_6_lld_bus_inf_idx;
		`else
wire					ch_6_lld_bus_inf_idx = 1'b0;
		`endif
	`endif
wire					ch_6_tts_w_sel;
reg					ch_6_en;
reg					ch_6_int_tc_mask;
reg					ch_6_int_err_mask;
reg					ch_6_int_abt_mask;
reg	[3:0]				ch_6_src_req_sel;
reg	[3:0]				ch_6_dst_req_sel;
reg	[1:0]				ch_6_src_addr_ctl;
reg	[1:0]				ch_6_dst_addr_ctl;
reg					ch_6_src_mode;
reg					ch_6_dst_mode;
reg	[2:0]				ch_6_src_width;
reg	[2:0]				ch_6_dst_width;
reg	[3:0]				ch_6_src_burst_size;
reg					ch_6_priority;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_6_src_bus_inf_idx;
reg					ch_6_dst_bus_inf_idx;
	`else
wire					ch_6_src_bus_inf_idx = 1'b0;
wire					ch_6_dst_bus_inf_idx = 1'b0;
	`endif
wire	[31:0]				ch_6_ctl;
reg	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_6_tts;
reg					ch_6_tc;
reg					ch_6_abt;
reg					ch_6_err;
reg					ch_6_int;
wire					ch_6_tc_nxt;
wire					ch_6_abt_nxt;
wire					ch_6_err_nxt;
wire					ch_6_int_nxt;
`else
wire					ch_6_en  = 1'b0;
wire	[3:0]				ch_6_src_req_sel = 4'b0;
wire	[3:0]				ch_6_dst_req_sel = 4'b0;
wire	[1:0]				ch_6_src_addr_ctl = 2'b0;
wire	[1:0]				ch_6_dst_addr_ctl = 2'b0;
wire					ch_6_src_mode = 1'b0;
wire					ch_6_dst_mode = 1'b0;
wire 	[2:0]				ch_6_src_width = 3'b0;
wire 	[2:0]				ch_6_dst_width = 3'b0;
wire	[3:0]				ch_6_src_burst_size = 4'b0;
wire					ch_6_priority = 1'b0;
wire					ch_6_src_bus_inf_idx = 1'b0;
wire					ch_6_dst_bus_inf_idx = 1'b0;
wire	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_6_tts = {`ATCDMAC300_TTS_WIDTH{1'b0}};
wire					ch_6_tc  = 1'b0;
wire					ch_6_abt = 1'b0;
wire					ch_6_err = 1'b0;
wire					ch_6_int = 1'b0;
wire					ch_6_int_tc_mask = 1'b0;
wire					ch_6_int_err_mask = 1'b0;
wire					ch_6_int_abt_mask = 1'b0;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_6_lld_bus_inf_idx = 1'b0;
	`endif
`endif
`ifdef DMAC_CONFIG_CH7
wire					ch_7_ctl_r_sel;
wire					ch_7_src_addr_r_sel;
wire					ch_7_dst_addr_r_sel;
wire					ch_7_tts_r_sel;
wire					ch_7_ctl_w_sel;
wire					ch_7_src_addr_w_sel;
wire					ch_7_dst_addr_w_sel;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_7_llp_r_sel;
wire					ch_7_llp_w_sel;
wire	[(`ATCDMAC300_ADDR_WIDTH-1):0] 	ch_7_llp;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_7_lld_bus_inf_idx;
		`else
wire					ch_7_lld_bus_inf_idx = 1'b0;
		`endif
	`endif
wire					ch_7_tts_w_sel;
reg					ch_7_en;
reg					ch_7_int_tc_mask;
reg					ch_7_int_err_mask;
reg					ch_7_int_abt_mask;
reg	[3:0]				ch_7_src_req_sel;
reg	[3:0]				ch_7_dst_req_sel;
reg	[1:0]				ch_7_src_addr_ctl;
reg	[1:0]				ch_7_dst_addr_ctl;
reg					ch_7_src_mode;
reg					ch_7_dst_mode;
reg	[2:0]				ch_7_src_width;
reg	[2:0]				ch_7_dst_width;
reg	[3:0]				ch_7_src_burst_size;
reg					ch_7_priority;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					ch_7_src_bus_inf_idx;
reg					ch_7_dst_bus_inf_idx;
	`else
wire					ch_7_src_bus_inf_idx = 1'b0;
wire					ch_7_dst_bus_inf_idx = 1'b0;
	`endif
wire	[31:0]				ch_7_ctl;
reg	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_7_tts;
reg					ch_7_tc;
reg					ch_7_abt;
reg					ch_7_err;
reg					ch_7_int;
wire					ch_7_tc_nxt;
wire					ch_7_abt_nxt;
wire					ch_7_err_nxt;
wire					ch_7_int_nxt;
`else
wire					ch_7_en  = 1'b0;
wire	[3:0]				ch_7_src_req_sel = 4'b0;
wire	[3:0]				ch_7_dst_req_sel = 4'b0;
wire	[1:0]				ch_7_src_addr_ctl = 2'b0;
wire	[1:0]				ch_7_dst_addr_ctl = 2'b0;
wire					ch_7_src_mode = 1'b0;
wire					ch_7_dst_mode = 1'b0;
wire 	[2:0]				ch_7_src_width = 3'b0;
wire 	[2:0]				ch_7_dst_width = 3'b0;
wire	[3:0]				ch_7_src_burst_size = 4'b0;
wire					ch_7_priority = 1'b0;
wire					ch_7_src_bus_inf_idx = 1'b0;
wire					ch_7_dst_bus_inf_idx = 1'b0;
wire	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_7_tts = {`ATCDMAC300_TTS_WIDTH{1'b0}};
wire					ch_7_tc  = 1'b0;
wire					ch_7_abt = 1'b0;
wire					ch_7_err = 1'b0;
wire					ch_7_int = 1'b0;
wire					ch_7_int_tc_mask = 1'b0;
wire					ch_7_int_err_mask = 1'b0;
wire					ch_7_int_abt_mask = 1'b0;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire					ch_7_lld_bus_inf_idx = 1'b0;
	`endif
`endif

reg					rd_cmd_valid_d1;
wire					cmd_valid;
wire					rd_cmd_valid;
wire					wr_cmd_valid;
wire            		        wr_cmd;
wire					dma_soft_reset;
wire	[8:0]				addr;
wire	[31:0]				wdata;
wire					cmd_buff_wr;
wire	[39:0]				cmd_buff_wdata;
wire					cmd_buff_rd;
wire	[39:0]				cmd_buff_rdata;
wire					cmd_buff_empty;
wire					cmd_buff_full;
wire					rdata_buff_wr;
wire	[32:0]				rdata_buff_wdata;
wire					rdata_buff_rd;
wire	[31:0]				rdata_buff_rdata;
wire					rdata_buff_empty;
wire					rdata_buff_full;

assign	cmd_valid	= (!cmd_buff_empty) && (!rdata_buff_full);
assign	cmd_buff_rd	=   cmd_valid;
assign	rdata_buff_wr	=   rd_cmd_valid_d1;
assign	wr_cmd_valid	=   cmd_valid && wr_cmd;
assign	rd_cmd_valid	=   cmd_valid && (!wr_cmd);
assign	wr_cmd		=   cmd_buff_rdata[39];
assign	addr		=   {cmd_buff_rdata[38:32],2'b0};
assign	wdata		=   cmd_buff_rdata[31:0];

assign	id_sel		= ({addr[8:2],2'b0} == 9'h00);
assign	config_sel	= ({addr[8:2],2'b0} == 9'h10);
assign	ch_status_r_sel	= ({addr[8:2],2'b0} == 9'h30);
assign	ch_en_sel	= ({addr[8:2],2'b0} == 9'h34);

assign	ch_status_w_sel	=   wr_cmd_valid & ({addr[8:2],2'b0} == 9'h30);
assign	dmac_ctl_sel	=   wr_cmd_valid & ({addr[8:2],2'b0} == 9'h20);
assign	ch_abort_sel	=   wr_cmd_valid & ({addr[8:2],2'b0} == 9'h24);

always @(posedge aclk or negedge aresetn) begin
	if (~aresetn) begin
		rd_cmd_valid_d1 <= 1'b0;
	end
	else begin
		rd_cmd_valid_d1 <= rd_cmd_valid;
	end
end

nds_async_buff #(40) cmd_buff (
        .w_reset_n	(presetn),
        .r_reset_n	(aresetn),
        .w_clk		(pclk),
        .r_clk		(aclk),
        .wr		(cmd_buff_wr),
        .wr_data	(cmd_buff_wdata),
        .rd		(cmd_buff_rd),
        .rd_data	(cmd_buff_rdata),
        .empty		(cmd_buff_empty),
        .full		(cmd_buff_full)
);

nds_async_buff #(32) rdata_buff (
        .w_reset_n	(aresetn),
        .r_reset_n	(presetn),
        .w_clk		(aclk),
        .r_clk		(pclk),
        .wr		(rdata_buff_wr),
        .wr_data	(rdata_buff_wdata[31:0]),
        .rd		(rdata_buff_rd),
        .rd_data	(rdata_buff_rdata),
        .empty		(rdata_buff_empty),
        .full		(rdata_buff_full)
);


`ifdef DMAC_CONFIG_CH0
assign ch_0_ctl_r_sel 		= ({addr[8:2],2'b0} == 9'h40);
assign ch_0_tts_r_sel 		= ({addr[8:2],2'b0} == 9'h44);
assign ch_0_src_addr_r_sel	= ({addr[8:2],2'b0} == 9'h48);
assign ch_0_dst_addr_r_sel 	= ({addr[8:2],2'b0} == 9'h50);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_0_llp_r_sel 		= ({addr[8:2],2'b0} == 9'h58);
	`endif
assign ch_0_ctl_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h40);
assign ch_0_tts_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h44);
assign ch_0_src_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h48);
assign ch_0_dst_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h50);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_0_llp_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h58);
	`endif

`endif
`ifdef DMAC_CONFIG_CH1
assign ch_1_ctl_r_sel 		= ({addr[8:2],2'b0} == 9'h60);
assign ch_1_tts_r_sel 		= ({addr[8:2],2'b0} == 9'h64);
assign ch_1_src_addr_r_sel	= ({addr[8:2],2'b0} == 9'h68);
assign ch_1_dst_addr_r_sel 	= ({addr[8:2],2'b0} == 9'h70);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_1_llp_r_sel 		= ({addr[8:2],2'b0} == 9'h78);
	`endif
assign ch_1_ctl_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h60);
assign ch_1_tts_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h64);
assign ch_1_src_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h68);
assign ch_1_dst_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h70);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_1_llp_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h78);
	`endif

`endif
`ifdef DMAC_CONFIG_CH2
assign ch_2_ctl_r_sel 		= ({addr[8:2],2'b0} == 9'h80);
assign ch_2_tts_r_sel 		= ({addr[8:2],2'b0} == 9'h84);
assign ch_2_src_addr_r_sel	= ({addr[8:2],2'b0} == 9'h88);
assign ch_2_dst_addr_r_sel 	= ({addr[8:2],2'b0} == 9'h90);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_2_llp_r_sel 		= ({addr[8:2],2'b0} == 9'h98);
	`endif
assign ch_2_ctl_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h80);
assign ch_2_tts_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h84);
assign ch_2_src_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h88);
assign ch_2_dst_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h90);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_2_llp_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h98);
	`endif

`endif
`ifdef DMAC_CONFIG_CH3
assign ch_3_ctl_r_sel 		= ({addr[8:2],2'b0} == 9'ha0);
assign ch_3_tts_r_sel 		= ({addr[8:2],2'b0} == 9'ha4);
assign ch_3_src_addr_r_sel	= ({addr[8:2],2'b0} == 9'ha8);
assign ch_3_dst_addr_r_sel 	= ({addr[8:2],2'b0} == 9'hb0);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_3_llp_r_sel 		= ({addr[8:2],2'b0} == 9'hb8);
	`endif
assign ch_3_ctl_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'ha0);
assign ch_3_tts_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'ha4);
assign ch_3_src_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'ha8);
assign ch_3_dst_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hb0);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_3_llp_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hb8);
	`endif

`endif
`ifdef DMAC_CONFIG_CH4
assign ch_4_ctl_r_sel 		= ({addr[8:2],2'b0} == 9'hc0);
assign ch_4_tts_r_sel 		= ({addr[8:2],2'b0} == 9'hc4);
assign ch_4_src_addr_r_sel	= ({addr[8:2],2'b0} == 9'hc8);
assign ch_4_dst_addr_r_sel 	= ({addr[8:2],2'b0} == 9'hd0);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_4_llp_r_sel 		= ({addr[8:2],2'b0} == 9'hd8);
	`endif
assign ch_4_ctl_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hc0);
assign ch_4_tts_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hc4);
assign ch_4_src_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hc8);
assign ch_4_dst_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hd0);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_4_llp_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hd8);
	`endif

`endif
`ifdef DMAC_CONFIG_CH5
assign ch_5_ctl_r_sel 		= ({addr[8:2],2'b0} == 9'he0);
assign ch_5_tts_r_sel 		= ({addr[8:2],2'b0} == 9'he4);
assign ch_5_src_addr_r_sel	= ({addr[8:2],2'b0} == 9'he8);
assign ch_5_dst_addr_r_sel 	= ({addr[8:2],2'b0} == 9'hf0);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_5_llp_r_sel 		= ({addr[8:2],2'b0} == 9'hf8);
	`endif
assign ch_5_ctl_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'he0);
assign ch_5_tts_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'he4);
assign ch_5_src_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'he8);
assign ch_5_dst_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hf0);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_5_llp_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hf8);
	`endif

`endif
`ifdef DMAC_CONFIG_CH6
assign ch_6_ctl_r_sel 		= ({addr[8:2],2'b0} == 9'h100);
assign ch_6_tts_r_sel 		= ({addr[8:2],2'b0} == 9'h104);
assign ch_6_src_addr_r_sel	= ({addr[8:2],2'b0} == 9'h108);
assign ch_6_dst_addr_r_sel 	= ({addr[8:2],2'b0} == 9'h110);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_6_llp_r_sel 		= ({addr[8:2],2'b0} == 9'h118);
	`endif
assign ch_6_ctl_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h100);
assign ch_6_tts_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h104);
assign ch_6_src_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h108);
assign ch_6_dst_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h110);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_6_llp_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h118);
	`endif

`endif
`ifdef DMAC_CONFIG_CH7
assign ch_7_ctl_r_sel 		= ({addr[8:2],2'b0} == 9'h120);
assign ch_7_tts_r_sel 		= ({addr[8:2],2'b0} == 9'h124);
assign ch_7_src_addr_r_sel	= ({addr[8:2],2'b0} == 9'h128);
assign ch_7_dst_addr_r_sel 	= ({addr[8:2],2'b0} == 9'h130);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_7_llp_r_sel 		= ({addr[8:2],2'b0} == 9'h138);
	`endif
assign ch_7_ctl_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h120);
assign ch_7_tts_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h124);
assign ch_7_src_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h128);
assign ch_7_dst_addr_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h130);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign ch_7_llp_w_sel 		= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h138);
	`endif

`endif

assign dma_soft_reset 		= dmac_ctl_sel & wdata[0];
assign dma_int			= |status_int;

assign status_tc		= {       ch_7_tc,  ch_6_tc,  ch_5_tc,  ch_4_tc,  ch_3_tc,  ch_2_tc,  ch_1_tc,  ch_0_tc };
assign status_abt		= {       ch_7_abt, ch_6_abt, ch_5_abt, ch_4_abt, ch_3_abt, ch_2_abt, ch_1_abt, ch_0_abt};
assign status_err		= {       ch_7_err, ch_6_err, ch_5_err, ch_4_err, ch_3_err, ch_2_err, ch_1_err, ch_0_err};
assign status_int		= {       ch_7_int, ch_6_int, ch_5_int, ch_4_int, ch_3_int, ch_2_int, ch_1_int, ch_0_int};
assign ch_status		= {8'b0,  status_tc, status_abt, status_err};
assign ch_en			= {24'b0, ch_7_en,  ch_6_en,  ch_5_en,  ch_4_en,  ch_3_en,  ch_2_en,  ch_1_en,  ch_0_en };


`ifdef DMAC_CONFIG_CH0
assign ch_0_tc_nxt 	= (ch_status_w_sel && wdata[16]) ? 1'b0 : ((dma0_ch_0_tc_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_0_tc_wen
						`endif
                                                                                        ) ? 1'b1 : ch_0_tc);
assign ch_0_abt_nxt 	= (ch_status_w_sel && wdata[8]) ? 1'b0 : ((ch_abort_sel & wdata[0] & ch_0_en) ? 1'b1 : ch_0_abt);
assign ch_0_err_nxt 	= (ch_status_w_sel && wdata[0]) ? 1'b0 : ((dma0_ch_0_err_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_0_err_wen
						`endif
                                                                                         ) ? 1'b1 : ch_0_err);
assign ch_0_int_nxt 	= ((!ch_0_tc_nxt) && (!ch_0_abt_nxt) && (!ch_0_err_nxt)) ? 1'b0 : ((dma0_ch_0_int_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                                         || dma1_ch_0_int_wen
						`endif
                                                                                         ) ? 1'b1 : ch_0_int);
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_0_tc		<= 1'b0;
		ch_0_abt	<= 1'b0;
		ch_0_err	<= 1'b0;
		ch_0_int	<= 1'b0;
	end
	else begin
		ch_0_tc		<= ch_0_tc_nxt;
		ch_0_abt	<= ch_0_abt_nxt;
		ch_0_err	<= ch_0_err_nxt;
		ch_0_int	<= ch_0_int_nxt;
	end
end
`endif

`ifdef DMAC_CONFIG_CH1
assign ch_1_tc_nxt 	= (ch_status_w_sel && wdata[17]) ? 1'b0 : ((dma0_ch_1_tc_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_1_tc_wen
						`endif
                                                                                        ) ? 1'b1 : ch_1_tc);
assign ch_1_abt_nxt 	= (ch_status_w_sel && wdata[9]) ? 1'b0 : ((ch_abort_sel & wdata[1] & ch_1_en) ? 1'b1 : ch_1_abt);
assign ch_1_err_nxt 	= (ch_status_w_sel && wdata[1]) ? 1'b0 : ((dma0_ch_1_err_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_1_err_wen
						`endif
                                                                                         ) ? 1'b1 : ch_1_err);
assign ch_1_int_nxt 	= ((!ch_1_tc_nxt) && (!ch_1_abt_nxt) && (!ch_1_err_nxt)) ? 1'b0 : ((dma0_ch_1_int_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                                         || dma1_ch_1_int_wen
						`endif
                                                                                         ) ? 1'b1 : ch_1_int);
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_1_tc		<= 1'b0;
		ch_1_abt	<= 1'b0;
		ch_1_err	<= 1'b0;
		ch_1_int	<= 1'b0;
	end
	else begin
		ch_1_tc		<= ch_1_tc_nxt;
		ch_1_abt	<= ch_1_abt_nxt;
		ch_1_err	<= ch_1_err_nxt;
		ch_1_int	<= ch_1_int_nxt;
	end
end
`endif

`ifdef DMAC_CONFIG_CH2
assign ch_2_tc_nxt 	= (ch_status_w_sel && wdata[18]) ? 1'b0 : ((dma0_ch_2_tc_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_2_tc_wen
						`endif
                                                                                        ) ? 1'b1 : ch_2_tc);
assign ch_2_abt_nxt 	= (ch_status_w_sel && wdata[10]) ? 1'b0 : ((ch_abort_sel & wdata[2] & ch_2_en) ? 1'b1 : ch_2_abt);
assign ch_2_err_nxt 	= (ch_status_w_sel && wdata[2]) ? 1'b0 : ((dma0_ch_2_err_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_2_err_wen
						`endif
                                                                                         ) ? 1'b1 : ch_2_err);
assign ch_2_int_nxt 	= ((!ch_2_tc_nxt) && (!ch_2_abt_nxt) && (!ch_2_err_nxt)) ? 1'b0 : ((dma0_ch_2_int_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                                         || dma1_ch_2_int_wen
						`endif
                                                                                         ) ? 1'b1 : ch_2_int);
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_2_tc		<= 1'b0;
		ch_2_abt	<= 1'b0;
		ch_2_err	<= 1'b0;
		ch_2_int	<= 1'b0;
	end
	else begin
		ch_2_tc		<= ch_2_tc_nxt;
		ch_2_abt	<= ch_2_abt_nxt;
		ch_2_err	<= ch_2_err_nxt;
		ch_2_int	<= ch_2_int_nxt;
	end
end
`endif

`ifdef DMAC_CONFIG_CH3
assign ch_3_tc_nxt 	= (ch_status_w_sel && wdata[19]) ? 1'b0 : ((dma0_ch_3_tc_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_3_tc_wen
						`endif
                                                                                        ) ? 1'b1 : ch_3_tc);
assign ch_3_abt_nxt 	= (ch_status_w_sel && wdata[11]) ? 1'b0 : ((ch_abort_sel & wdata[3] & ch_3_en) ? 1'b1 : ch_3_abt);
assign ch_3_err_nxt 	= (ch_status_w_sel && wdata[3]) ? 1'b0 : ((dma0_ch_3_err_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_3_err_wen
						`endif
                                                                                         ) ? 1'b1 : ch_3_err);
assign ch_3_int_nxt 	= ((!ch_3_tc_nxt) && (!ch_3_abt_nxt) && (!ch_3_err_nxt)) ? 1'b0 : ((dma0_ch_3_int_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                                         || dma1_ch_3_int_wen
						`endif
                                                                                         ) ? 1'b1 : ch_3_int);
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_3_tc		<= 1'b0;
		ch_3_abt	<= 1'b0;
		ch_3_err	<= 1'b0;
		ch_3_int	<= 1'b0;
	end
	else begin
		ch_3_tc		<= ch_3_tc_nxt;
		ch_3_abt	<= ch_3_abt_nxt;
		ch_3_err	<= ch_3_err_nxt;
		ch_3_int	<= ch_3_int_nxt;
	end
end
`endif

`ifdef DMAC_CONFIG_CH4
assign ch_4_tc_nxt 	= (ch_status_w_sel && wdata[20]) ? 1'b0 : ((dma0_ch_4_tc_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_4_tc_wen
						`endif
                                                                                        ) ? 1'b1 : ch_4_tc);
assign ch_4_abt_nxt 	= (ch_status_w_sel && wdata[12]) ? 1'b0 : ((ch_abort_sel & wdata[4] & ch_4_en) ? 1'b1 : ch_4_abt);
assign ch_4_err_nxt 	= (ch_status_w_sel && wdata[4]) ? 1'b0 : ((dma0_ch_4_err_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_4_err_wen
						`endif
                                                                                         ) ? 1'b1 : ch_4_err);
assign ch_4_int_nxt 	= ((!ch_4_tc_nxt) && (!ch_4_abt_nxt) && (!ch_4_err_nxt)) ? 1'b0 : ((dma0_ch_4_int_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                                         || dma1_ch_4_int_wen
						`endif
                                                                                         ) ? 1'b1 : ch_4_int);
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_4_tc		<= 1'b0;
		ch_4_abt	<= 1'b0;
		ch_4_err	<= 1'b0;
		ch_4_int	<= 1'b0;
	end
	else begin
		ch_4_tc		<= ch_4_tc_nxt;
		ch_4_abt	<= ch_4_abt_nxt;
		ch_4_err	<= ch_4_err_nxt;
		ch_4_int	<= ch_4_int_nxt;
	end
end
`endif

`ifdef DMAC_CONFIG_CH5
assign ch_5_tc_nxt 	= (ch_status_w_sel && wdata[21]) ? 1'b0 : ((dma0_ch_5_tc_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_5_tc_wen
						`endif
                                                                                        ) ? 1'b1 : ch_5_tc);
assign ch_5_abt_nxt 	= (ch_status_w_sel && wdata[13]) ? 1'b0 : ((ch_abort_sel & wdata[5] & ch_5_en) ? 1'b1 : ch_5_abt);
assign ch_5_err_nxt 	= (ch_status_w_sel && wdata[5]) ? 1'b0 : ((dma0_ch_5_err_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_5_err_wen
						`endif
                                                                                         ) ? 1'b1 : ch_5_err);
assign ch_5_int_nxt 	= ((!ch_5_tc_nxt) && (!ch_5_abt_nxt) && (!ch_5_err_nxt)) ? 1'b0 : ((dma0_ch_5_int_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                                         || dma1_ch_5_int_wen
						`endif
                                                                                         ) ? 1'b1 : ch_5_int);
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_5_tc		<= 1'b0;
		ch_5_abt	<= 1'b0;
		ch_5_err	<= 1'b0;
		ch_5_int	<= 1'b0;
	end
	else begin
		ch_5_tc		<= ch_5_tc_nxt;
		ch_5_abt	<= ch_5_abt_nxt;
		ch_5_err	<= ch_5_err_nxt;
		ch_5_int	<= ch_5_int_nxt;
	end
end
`endif

`ifdef DMAC_CONFIG_CH6
assign ch_6_tc_nxt 	= (ch_status_w_sel && wdata[22]) ? 1'b0 : ((dma0_ch_6_tc_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_6_tc_wen
						`endif
                                                                                        ) ? 1'b1 : ch_6_tc);
assign ch_6_abt_nxt 	= (ch_status_w_sel && wdata[14]) ? 1'b0 : ((ch_abort_sel & wdata[6] & ch_6_en) ? 1'b1 : ch_6_abt);
assign ch_6_err_nxt 	= (ch_status_w_sel && wdata[6]) ? 1'b0 : ((dma0_ch_6_err_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_6_err_wen
						`endif
                                                                                         ) ? 1'b1 : ch_6_err);
assign ch_6_int_nxt 	= ((!ch_6_tc_nxt) && (!ch_6_abt_nxt) && (!ch_6_err_nxt)) ? 1'b0 : ((dma0_ch_6_int_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                                         || dma1_ch_6_int_wen
						`endif
                                                                                         ) ? 1'b1 : ch_6_int);
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_6_tc		<= 1'b0;
		ch_6_abt	<= 1'b0;
		ch_6_err	<= 1'b0;
		ch_6_int	<= 1'b0;
	end
	else begin
		ch_6_tc		<= ch_6_tc_nxt;
		ch_6_abt	<= ch_6_abt_nxt;
		ch_6_err	<= ch_6_err_nxt;
		ch_6_int	<= ch_6_int_nxt;
	end
end
`endif

`ifdef DMAC_CONFIG_CH7
assign ch_7_tc_nxt 	= (ch_status_w_sel && wdata[23]) ? 1'b0 : ((dma0_ch_7_tc_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_7_tc_wen
						`endif
                                                                                        ) ? 1'b1 : ch_7_tc);
assign ch_7_abt_nxt 	= (ch_status_w_sel && wdata[15]) ? 1'b0 : ((ch_abort_sel & wdata[7] & ch_7_en) ? 1'b1 : ch_7_abt);
assign ch_7_err_nxt 	= (ch_status_w_sel && wdata[7]) ? 1'b0 : ((dma0_ch_7_err_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                 || dma1_ch_7_err_wen
						`endif
                                                                                         ) ? 1'b1 : ch_7_err);
assign ch_7_int_nxt 	= ((!ch_7_tc_nxt) && (!ch_7_abt_nxt) && (!ch_7_err_nxt)) ? 1'b0 : ((dma0_ch_7_int_wen
						`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                                                                                         || dma1_ch_7_int_wen
						`endif
                                                                                         ) ? 1'b1 : ch_7_int);
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_7_tc		<= 1'b0;
		ch_7_abt	<= 1'b0;
		ch_7_err	<= 1'b0;
		ch_7_int	<= 1'b0;
	end
	else begin
		ch_7_tc		<= ch_7_tc_nxt;
		ch_7_abt	<= ch_7_abt_nxt;
		ch_7_err	<= ch_7_err_nxt;
		ch_7_int	<= ch_7_int_nxt;
	end
end
`endif



`ifdef DMAC_CONFIG_CH0

assign ch_0_ctl = {
		ch_0_src_bus_inf_idx, ch_0_dst_bus_inf_idx,
		ch_0_priority, 1'b0, ch_0_src_burst_size, ch_0_src_width, ch_0_dst_width,
		ch_0_src_mode, ch_0_dst_mode, ch_0_src_addr_ctl, ch_0_dst_addr_ctl,
		ch_0_src_req_sel, ch_0_dst_req_sel, ch_0_int_abt_mask,
		ch_0_int_err_mask, ch_0_int_tc_mask, ch_0_en};
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_0_int_tc_mask	<= 1'b0;
		ch_0_int_err_mask	<= 1'b0;
		ch_0_int_abt_mask	<= 1'b0;
		ch_0_dst_req_sel	<= 4'b0;
		ch_0_src_req_sel	<= 4'b0;
		ch_0_dst_addr_ctl	<= 2'b0;
		ch_0_src_addr_ctl	<= 2'b0;
		ch_0_dst_mode		<= 1'b0;
		ch_0_src_mode		<= 1'b0;
		ch_0_dst_width		<= 3'b0;
		ch_0_src_width		<= 3'b0;
		ch_0_src_burst_size	<= 4'b0;
		ch_0_priority		<= 1'b0;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_0_dst_bus_inf_idx	<= 1'b0;
		ch_0_src_bus_inf_idx	<= 1'b0;
`endif
	end
	else if (ch_0_ctl_w_sel) begin
		ch_0_int_tc_mask	<= wdata[1];
		ch_0_int_err_mask	<= wdata[2];
		ch_0_int_abt_mask	<= wdata[3];
		ch_0_dst_req_sel	<= wdata[7:4];
		ch_0_src_req_sel	<= wdata[11:8];
		ch_0_dst_addr_ctl	<= wdata[13:12];
		ch_0_src_addr_ctl	<= wdata[15:14];
		ch_0_dst_mode		<= wdata[16];
		ch_0_src_mode		<= wdata[17];
		ch_0_dst_width		<= wdata[20:18];
		ch_0_src_width		<= wdata[23:21];
		ch_0_src_burst_size	<= wdata[27:24];
		ch_0_priority		<= wdata[29];
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_0_dst_bus_inf_idx	<= wdata[30];
		ch_0_src_bus_inf_idx	<= wdata[31];
`endif
	end
	else if (dma0_ch_0_ctl_wen) begin
		ch_0_int_tc_mask	<= dma0_ch_ctl_wdata[1];
		ch_0_int_err_mask	<= dma0_ch_ctl_wdata[2];
		ch_0_int_abt_mask	<= dma0_ch_ctl_wdata[3];
		ch_0_dst_req_sel	<= dma0_ch_ctl_wdata[7:4];
		ch_0_src_req_sel	<= dma0_ch_ctl_wdata[11:8];
		ch_0_dst_addr_ctl	<= dma0_ch_ctl_wdata[13:12];
		ch_0_src_addr_ctl	<= dma0_ch_ctl_wdata[15:14];
		ch_0_dst_mode		<= dma0_ch_ctl_wdata[16];
		ch_0_src_mode		<= dma0_ch_ctl_wdata[17];
		ch_0_dst_width		<= dma0_ch_ctl_wdata[20:18];
		ch_0_src_width		<= dma0_ch_ctl_wdata[23:21];
		ch_0_src_burst_size	<= dma0_ch_ctl_wdata[27:24];
		ch_0_priority		<= dma0_ch_ctl_wdata_pri;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_0_dst_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[0];
		ch_0_src_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[1];
`endif
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_0_ctl_wen) begin
		ch_0_int_tc_mask	<= dma1_ch_ctl_wdata[1];
		ch_0_int_err_mask	<= dma1_ch_ctl_wdata[2];
		ch_0_int_abt_mask	<= dma1_ch_ctl_wdata[3];
		ch_0_dst_req_sel	<= dma1_ch_ctl_wdata[7:4];
		ch_0_src_req_sel	<= dma1_ch_ctl_wdata[11:8];
		ch_0_dst_addr_ctl	<= dma1_ch_ctl_wdata[13:12];
		ch_0_src_addr_ctl	<= dma1_ch_ctl_wdata[15:14];
		ch_0_dst_mode		<= dma1_ch_ctl_wdata[16];
		ch_0_src_mode		<= dma1_ch_ctl_wdata[17];
		ch_0_dst_width		<= dma1_ch_ctl_wdata[20:18];
		ch_0_src_width		<= dma1_ch_ctl_wdata[23:21];
		ch_0_src_burst_size	<= dma1_ch_ctl_wdata[27:24];
		ch_0_priority		<= dma1_ch_ctl_wdata_pri;
	 `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_0_dst_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[0];
		ch_0_src_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[1];
	 `endif
	end
`endif
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_0_en			<= 1'b0;
	end
	else if (ch_0_ctl_w_sel) begin
		ch_0_en			<= wdata[0];
	end
	else if (dma0_ch_0_en_wen | dma_soft_reset) begin
		ch_0_en			<= 1'b0;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_0_en_wen) begin
		ch_0_en			<= 1'b0;
	end
`endif
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_0_tts	<= {`ATCDMAC300_TTS_WIDTH{1'b0}};
	end
	else if (ch_0_tts_w_sel) begin
		ch_0_tts 	<= wdata[(`ATCDMAC300_TTS_WIDTH-1):0];
	end
	else if (dma0_ch_0_tts_wen) begin
		ch_0_tts 	<= dma0_ch_tts_wdata;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_0_tts_wen) begin
		ch_0_tts 	<= dma1_ch_tts_wdata;
	end
`endif
end
`endif
`ifdef DMAC_CONFIG_CH1

assign ch_1_ctl = {
		ch_1_src_bus_inf_idx, ch_1_dst_bus_inf_idx,
		ch_1_priority, 1'b0, ch_1_src_burst_size, ch_1_src_width, ch_1_dst_width,
		ch_1_src_mode, ch_1_dst_mode, ch_1_src_addr_ctl, ch_1_dst_addr_ctl,
		ch_1_src_req_sel, ch_1_dst_req_sel, ch_1_int_abt_mask,
		ch_1_int_err_mask, ch_1_int_tc_mask, ch_1_en};
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_1_int_tc_mask	<= 1'b0;
		ch_1_int_err_mask	<= 1'b0;
		ch_1_int_abt_mask	<= 1'b0;
		ch_1_dst_req_sel	<= 4'b0;
		ch_1_src_req_sel	<= 4'b0;
		ch_1_dst_addr_ctl	<= 2'b0;
		ch_1_src_addr_ctl	<= 2'b0;
		ch_1_dst_mode		<= 1'b0;
		ch_1_src_mode		<= 1'b0;
		ch_1_dst_width		<= 3'b0;
		ch_1_src_width		<= 3'b0;
		ch_1_src_burst_size	<= 4'b0;
		ch_1_priority		<= 1'b0;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_1_dst_bus_inf_idx	<= 1'b0;
		ch_1_src_bus_inf_idx	<= 1'b0;
`endif
	end
	else if (ch_1_ctl_w_sel) begin
		ch_1_int_tc_mask	<= wdata[1];
		ch_1_int_err_mask	<= wdata[2];
		ch_1_int_abt_mask	<= wdata[3];
		ch_1_dst_req_sel	<= wdata[7:4];
		ch_1_src_req_sel	<= wdata[11:8];
		ch_1_dst_addr_ctl	<= wdata[13:12];
		ch_1_src_addr_ctl	<= wdata[15:14];
		ch_1_dst_mode		<= wdata[16];
		ch_1_src_mode		<= wdata[17];
		ch_1_dst_width		<= wdata[20:18];
		ch_1_src_width		<= wdata[23:21];
		ch_1_src_burst_size	<= wdata[27:24];
		ch_1_priority		<= wdata[29];
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_1_dst_bus_inf_idx	<= wdata[30];
		ch_1_src_bus_inf_idx	<= wdata[31];
`endif
	end
	else if (dma0_ch_1_ctl_wen) begin
		ch_1_int_tc_mask	<= dma0_ch_ctl_wdata[1];
		ch_1_int_err_mask	<= dma0_ch_ctl_wdata[2];
		ch_1_int_abt_mask	<= dma0_ch_ctl_wdata[3];
		ch_1_dst_req_sel	<= dma0_ch_ctl_wdata[7:4];
		ch_1_src_req_sel	<= dma0_ch_ctl_wdata[11:8];
		ch_1_dst_addr_ctl	<= dma0_ch_ctl_wdata[13:12];
		ch_1_src_addr_ctl	<= dma0_ch_ctl_wdata[15:14];
		ch_1_dst_mode		<= dma0_ch_ctl_wdata[16];
		ch_1_src_mode		<= dma0_ch_ctl_wdata[17];
		ch_1_dst_width		<= dma0_ch_ctl_wdata[20:18];
		ch_1_src_width		<= dma0_ch_ctl_wdata[23:21];
		ch_1_src_burst_size	<= dma0_ch_ctl_wdata[27:24];
		ch_1_priority		<= dma0_ch_ctl_wdata_pri;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_1_dst_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[0];
		ch_1_src_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[1];
`endif
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_1_ctl_wen) begin
		ch_1_int_tc_mask	<= dma1_ch_ctl_wdata[1];
		ch_1_int_err_mask	<= dma1_ch_ctl_wdata[2];
		ch_1_int_abt_mask	<= dma1_ch_ctl_wdata[3];
		ch_1_dst_req_sel	<= dma1_ch_ctl_wdata[7:4];
		ch_1_src_req_sel	<= dma1_ch_ctl_wdata[11:8];
		ch_1_dst_addr_ctl	<= dma1_ch_ctl_wdata[13:12];
		ch_1_src_addr_ctl	<= dma1_ch_ctl_wdata[15:14];
		ch_1_dst_mode		<= dma1_ch_ctl_wdata[16];
		ch_1_src_mode		<= dma1_ch_ctl_wdata[17];
		ch_1_dst_width		<= dma1_ch_ctl_wdata[20:18];
		ch_1_src_width		<= dma1_ch_ctl_wdata[23:21];
		ch_1_src_burst_size	<= dma1_ch_ctl_wdata[27:24];
		ch_1_priority		<= dma1_ch_ctl_wdata_pri;
	 `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_1_dst_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[0];
		ch_1_src_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[1];
	 `endif
	end
`endif
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_1_en			<= 1'b0;
	end
	else if (ch_1_ctl_w_sel) begin
		ch_1_en			<= wdata[0];
	end
	else if (dma0_ch_1_en_wen | dma_soft_reset) begin
		ch_1_en			<= 1'b0;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_1_en_wen) begin
		ch_1_en			<= 1'b0;
	end
`endif
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_1_tts	<= {`ATCDMAC300_TTS_WIDTH{1'b0}};
	end
	else if (ch_1_tts_w_sel) begin
		ch_1_tts 	<= wdata[(`ATCDMAC300_TTS_WIDTH-1):0];
	end
	else if (dma0_ch_1_tts_wen) begin
		ch_1_tts 	<= dma0_ch_tts_wdata;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_1_tts_wen) begin
		ch_1_tts 	<= dma1_ch_tts_wdata;
	end
`endif
end
`endif
`ifdef DMAC_CONFIG_CH2

assign ch_2_ctl = {
		ch_2_src_bus_inf_idx, ch_2_dst_bus_inf_idx,
		ch_2_priority, 1'b0, ch_2_src_burst_size, ch_2_src_width, ch_2_dst_width,
		ch_2_src_mode, ch_2_dst_mode, ch_2_src_addr_ctl, ch_2_dst_addr_ctl,
		ch_2_src_req_sel, ch_2_dst_req_sel, ch_2_int_abt_mask,
		ch_2_int_err_mask, ch_2_int_tc_mask, ch_2_en};
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_2_int_tc_mask	<= 1'b0;
		ch_2_int_err_mask	<= 1'b0;
		ch_2_int_abt_mask	<= 1'b0;
		ch_2_dst_req_sel	<= 4'b0;
		ch_2_src_req_sel	<= 4'b0;
		ch_2_dst_addr_ctl	<= 2'b0;
		ch_2_src_addr_ctl	<= 2'b0;
		ch_2_dst_mode		<= 1'b0;
		ch_2_src_mode		<= 1'b0;
		ch_2_dst_width		<= 3'b0;
		ch_2_src_width		<= 3'b0;
		ch_2_src_burst_size	<= 4'b0;
		ch_2_priority		<= 1'b0;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_2_dst_bus_inf_idx	<= 1'b0;
		ch_2_src_bus_inf_idx	<= 1'b0;
`endif
	end
	else if (ch_2_ctl_w_sel) begin
		ch_2_int_tc_mask	<= wdata[1];
		ch_2_int_err_mask	<= wdata[2];
		ch_2_int_abt_mask	<= wdata[3];
		ch_2_dst_req_sel	<= wdata[7:4];
		ch_2_src_req_sel	<= wdata[11:8];
		ch_2_dst_addr_ctl	<= wdata[13:12];
		ch_2_src_addr_ctl	<= wdata[15:14];
		ch_2_dst_mode		<= wdata[16];
		ch_2_src_mode		<= wdata[17];
		ch_2_dst_width		<= wdata[20:18];
		ch_2_src_width		<= wdata[23:21];
		ch_2_src_burst_size	<= wdata[27:24];
		ch_2_priority		<= wdata[29];
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_2_dst_bus_inf_idx	<= wdata[30];
		ch_2_src_bus_inf_idx	<= wdata[31];
`endif
	end
	else if (dma0_ch_2_ctl_wen) begin
		ch_2_int_tc_mask	<= dma0_ch_ctl_wdata[1];
		ch_2_int_err_mask	<= dma0_ch_ctl_wdata[2];
		ch_2_int_abt_mask	<= dma0_ch_ctl_wdata[3];
		ch_2_dst_req_sel	<= dma0_ch_ctl_wdata[7:4];
		ch_2_src_req_sel	<= dma0_ch_ctl_wdata[11:8];
		ch_2_dst_addr_ctl	<= dma0_ch_ctl_wdata[13:12];
		ch_2_src_addr_ctl	<= dma0_ch_ctl_wdata[15:14];
		ch_2_dst_mode		<= dma0_ch_ctl_wdata[16];
		ch_2_src_mode		<= dma0_ch_ctl_wdata[17];
		ch_2_dst_width		<= dma0_ch_ctl_wdata[20:18];
		ch_2_src_width		<= dma0_ch_ctl_wdata[23:21];
		ch_2_src_burst_size	<= dma0_ch_ctl_wdata[27:24];
		ch_2_priority		<= dma0_ch_ctl_wdata_pri;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_2_dst_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[0];
		ch_2_src_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[1];
`endif
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_2_ctl_wen) begin
		ch_2_int_tc_mask	<= dma1_ch_ctl_wdata[1];
		ch_2_int_err_mask	<= dma1_ch_ctl_wdata[2];
		ch_2_int_abt_mask	<= dma1_ch_ctl_wdata[3];
		ch_2_dst_req_sel	<= dma1_ch_ctl_wdata[7:4];
		ch_2_src_req_sel	<= dma1_ch_ctl_wdata[11:8];
		ch_2_dst_addr_ctl	<= dma1_ch_ctl_wdata[13:12];
		ch_2_src_addr_ctl	<= dma1_ch_ctl_wdata[15:14];
		ch_2_dst_mode		<= dma1_ch_ctl_wdata[16];
		ch_2_src_mode		<= dma1_ch_ctl_wdata[17];
		ch_2_dst_width		<= dma1_ch_ctl_wdata[20:18];
		ch_2_src_width		<= dma1_ch_ctl_wdata[23:21];
		ch_2_src_burst_size	<= dma1_ch_ctl_wdata[27:24];
		ch_2_priority		<= dma1_ch_ctl_wdata_pri;
	 `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_2_dst_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[0];
		ch_2_src_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[1];
	 `endif
	end
`endif
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_2_en			<= 1'b0;
	end
	else if (ch_2_ctl_w_sel) begin
		ch_2_en			<= wdata[0];
	end
	else if (dma0_ch_2_en_wen | dma_soft_reset) begin
		ch_2_en			<= 1'b0;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_2_en_wen) begin
		ch_2_en			<= 1'b0;
	end
`endif
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_2_tts	<= {`ATCDMAC300_TTS_WIDTH{1'b0}};
	end
	else if (ch_2_tts_w_sel) begin
		ch_2_tts 	<= wdata[(`ATCDMAC300_TTS_WIDTH-1):0];
	end
	else if (dma0_ch_2_tts_wen) begin
		ch_2_tts 	<= dma0_ch_tts_wdata;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_2_tts_wen) begin
		ch_2_tts 	<= dma1_ch_tts_wdata;
	end
`endif
end
`endif
`ifdef DMAC_CONFIG_CH3

assign ch_3_ctl = {
		ch_3_src_bus_inf_idx, ch_3_dst_bus_inf_idx,
		ch_3_priority, 1'b0, ch_3_src_burst_size, ch_3_src_width, ch_3_dst_width,
		ch_3_src_mode, ch_3_dst_mode, ch_3_src_addr_ctl, ch_3_dst_addr_ctl,
		ch_3_src_req_sel, ch_3_dst_req_sel, ch_3_int_abt_mask,
		ch_3_int_err_mask, ch_3_int_tc_mask, ch_3_en};
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_3_int_tc_mask	<= 1'b0;
		ch_3_int_err_mask	<= 1'b0;
		ch_3_int_abt_mask	<= 1'b0;
		ch_3_dst_req_sel	<= 4'b0;
		ch_3_src_req_sel	<= 4'b0;
		ch_3_dst_addr_ctl	<= 2'b0;
		ch_3_src_addr_ctl	<= 2'b0;
		ch_3_dst_mode		<= 1'b0;
		ch_3_src_mode		<= 1'b0;
		ch_3_dst_width		<= 3'b0;
		ch_3_src_width		<= 3'b0;
		ch_3_src_burst_size	<= 4'b0;
		ch_3_priority		<= 1'b0;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_3_dst_bus_inf_idx	<= 1'b0;
		ch_3_src_bus_inf_idx	<= 1'b0;
`endif
	end
	else if (ch_3_ctl_w_sel) begin
		ch_3_int_tc_mask	<= wdata[1];
		ch_3_int_err_mask	<= wdata[2];
		ch_3_int_abt_mask	<= wdata[3];
		ch_3_dst_req_sel	<= wdata[7:4];
		ch_3_src_req_sel	<= wdata[11:8];
		ch_3_dst_addr_ctl	<= wdata[13:12];
		ch_3_src_addr_ctl	<= wdata[15:14];
		ch_3_dst_mode		<= wdata[16];
		ch_3_src_mode		<= wdata[17];
		ch_3_dst_width		<= wdata[20:18];
		ch_3_src_width		<= wdata[23:21];
		ch_3_src_burst_size	<= wdata[27:24];
		ch_3_priority		<= wdata[29];
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_3_dst_bus_inf_idx	<= wdata[30];
		ch_3_src_bus_inf_idx	<= wdata[31];
`endif
	end
	else if (dma0_ch_3_ctl_wen) begin
		ch_3_int_tc_mask	<= dma0_ch_ctl_wdata[1];
		ch_3_int_err_mask	<= dma0_ch_ctl_wdata[2];
		ch_3_int_abt_mask	<= dma0_ch_ctl_wdata[3];
		ch_3_dst_req_sel	<= dma0_ch_ctl_wdata[7:4];
		ch_3_src_req_sel	<= dma0_ch_ctl_wdata[11:8];
		ch_3_dst_addr_ctl	<= dma0_ch_ctl_wdata[13:12];
		ch_3_src_addr_ctl	<= dma0_ch_ctl_wdata[15:14];
		ch_3_dst_mode		<= dma0_ch_ctl_wdata[16];
		ch_3_src_mode		<= dma0_ch_ctl_wdata[17];
		ch_3_dst_width		<= dma0_ch_ctl_wdata[20:18];
		ch_3_src_width		<= dma0_ch_ctl_wdata[23:21];
		ch_3_src_burst_size	<= dma0_ch_ctl_wdata[27:24];
		ch_3_priority		<= dma0_ch_ctl_wdata_pri;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_3_dst_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[0];
		ch_3_src_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[1];
`endif
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_3_ctl_wen) begin
		ch_3_int_tc_mask	<= dma1_ch_ctl_wdata[1];
		ch_3_int_err_mask	<= dma1_ch_ctl_wdata[2];
		ch_3_int_abt_mask	<= dma1_ch_ctl_wdata[3];
		ch_3_dst_req_sel	<= dma1_ch_ctl_wdata[7:4];
		ch_3_src_req_sel	<= dma1_ch_ctl_wdata[11:8];
		ch_3_dst_addr_ctl	<= dma1_ch_ctl_wdata[13:12];
		ch_3_src_addr_ctl	<= dma1_ch_ctl_wdata[15:14];
		ch_3_dst_mode		<= dma1_ch_ctl_wdata[16];
		ch_3_src_mode		<= dma1_ch_ctl_wdata[17];
		ch_3_dst_width		<= dma1_ch_ctl_wdata[20:18];
		ch_3_src_width		<= dma1_ch_ctl_wdata[23:21];
		ch_3_src_burst_size	<= dma1_ch_ctl_wdata[27:24];
		ch_3_priority		<= dma1_ch_ctl_wdata_pri;
	 `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_3_dst_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[0];
		ch_3_src_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[1];
	 `endif
	end
`endif
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_3_en			<= 1'b0;
	end
	else if (ch_3_ctl_w_sel) begin
		ch_3_en			<= wdata[0];
	end
	else if (dma0_ch_3_en_wen | dma_soft_reset) begin
		ch_3_en			<= 1'b0;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_3_en_wen) begin
		ch_3_en			<= 1'b0;
	end
`endif
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_3_tts	<= {`ATCDMAC300_TTS_WIDTH{1'b0}};
	end
	else if (ch_3_tts_w_sel) begin
		ch_3_tts 	<= wdata[(`ATCDMAC300_TTS_WIDTH-1):0];
	end
	else if (dma0_ch_3_tts_wen) begin
		ch_3_tts 	<= dma0_ch_tts_wdata;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_3_tts_wen) begin
		ch_3_tts 	<= dma1_ch_tts_wdata;
	end
`endif
end
`endif
`ifdef DMAC_CONFIG_CH4

assign ch_4_ctl = {
		ch_4_src_bus_inf_idx, ch_4_dst_bus_inf_idx,
		ch_4_priority, 1'b0, ch_4_src_burst_size, ch_4_src_width, ch_4_dst_width,
		ch_4_src_mode, ch_4_dst_mode, ch_4_src_addr_ctl, ch_4_dst_addr_ctl,
		ch_4_src_req_sel, ch_4_dst_req_sel, ch_4_int_abt_mask,
		ch_4_int_err_mask, ch_4_int_tc_mask, ch_4_en};
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_4_int_tc_mask	<= 1'b0;
		ch_4_int_err_mask	<= 1'b0;
		ch_4_int_abt_mask	<= 1'b0;
		ch_4_dst_req_sel	<= 4'b0;
		ch_4_src_req_sel	<= 4'b0;
		ch_4_dst_addr_ctl	<= 2'b0;
		ch_4_src_addr_ctl	<= 2'b0;
		ch_4_dst_mode		<= 1'b0;
		ch_4_src_mode		<= 1'b0;
		ch_4_dst_width		<= 3'b0;
		ch_4_src_width		<= 3'b0;
		ch_4_src_burst_size	<= 4'b0;
		ch_4_priority		<= 1'b0;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_4_dst_bus_inf_idx	<= 1'b0;
		ch_4_src_bus_inf_idx	<= 1'b0;
`endif
	end
	else if (ch_4_ctl_w_sel) begin
		ch_4_int_tc_mask	<= wdata[1];
		ch_4_int_err_mask	<= wdata[2];
		ch_4_int_abt_mask	<= wdata[3];
		ch_4_dst_req_sel	<= wdata[7:4];
		ch_4_src_req_sel	<= wdata[11:8];
		ch_4_dst_addr_ctl	<= wdata[13:12];
		ch_4_src_addr_ctl	<= wdata[15:14];
		ch_4_dst_mode		<= wdata[16];
		ch_4_src_mode		<= wdata[17];
		ch_4_dst_width		<= wdata[20:18];
		ch_4_src_width		<= wdata[23:21];
		ch_4_src_burst_size	<= wdata[27:24];
		ch_4_priority		<= wdata[29];
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_4_dst_bus_inf_idx	<= wdata[30];
		ch_4_src_bus_inf_idx	<= wdata[31];
`endif
	end
	else if (dma0_ch_4_ctl_wen) begin
		ch_4_int_tc_mask	<= dma0_ch_ctl_wdata[1];
		ch_4_int_err_mask	<= dma0_ch_ctl_wdata[2];
		ch_4_int_abt_mask	<= dma0_ch_ctl_wdata[3];
		ch_4_dst_req_sel	<= dma0_ch_ctl_wdata[7:4];
		ch_4_src_req_sel	<= dma0_ch_ctl_wdata[11:8];
		ch_4_dst_addr_ctl	<= dma0_ch_ctl_wdata[13:12];
		ch_4_src_addr_ctl	<= dma0_ch_ctl_wdata[15:14];
		ch_4_dst_mode		<= dma0_ch_ctl_wdata[16];
		ch_4_src_mode		<= dma0_ch_ctl_wdata[17];
		ch_4_dst_width		<= dma0_ch_ctl_wdata[20:18];
		ch_4_src_width		<= dma0_ch_ctl_wdata[23:21];
		ch_4_src_burst_size	<= dma0_ch_ctl_wdata[27:24];
		ch_4_priority		<= dma0_ch_ctl_wdata_pri;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_4_dst_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[0];
		ch_4_src_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[1];
`endif
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_4_ctl_wen) begin
		ch_4_int_tc_mask	<= dma1_ch_ctl_wdata[1];
		ch_4_int_err_mask	<= dma1_ch_ctl_wdata[2];
		ch_4_int_abt_mask	<= dma1_ch_ctl_wdata[3];
		ch_4_dst_req_sel	<= dma1_ch_ctl_wdata[7:4];
		ch_4_src_req_sel	<= dma1_ch_ctl_wdata[11:8];
		ch_4_dst_addr_ctl	<= dma1_ch_ctl_wdata[13:12];
		ch_4_src_addr_ctl	<= dma1_ch_ctl_wdata[15:14];
		ch_4_dst_mode		<= dma1_ch_ctl_wdata[16];
		ch_4_src_mode		<= dma1_ch_ctl_wdata[17];
		ch_4_dst_width		<= dma1_ch_ctl_wdata[20:18];
		ch_4_src_width		<= dma1_ch_ctl_wdata[23:21];
		ch_4_src_burst_size	<= dma1_ch_ctl_wdata[27:24];
		ch_4_priority		<= dma1_ch_ctl_wdata_pri;
	 `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_4_dst_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[0];
		ch_4_src_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[1];
	 `endif
	end
`endif
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_4_en			<= 1'b0;
	end
	else if (ch_4_ctl_w_sel) begin
		ch_4_en			<= wdata[0];
	end
	else if (dma0_ch_4_en_wen | dma_soft_reset) begin
		ch_4_en			<= 1'b0;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_4_en_wen) begin
		ch_4_en			<= 1'b0;
	end
`endif
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_4_tts	<= {`ATCDMAC300_TTS_WIDTH{1'b0}};
	end
	else if (ch_4_tts_w_sel) begin
		ch_4_tts 	<= wdata[(`ATCDMAC300_TTS_WIDTH-1):0];
	end
	else if (dma0_ch_4_tts_wen) begin
		ch_4_tts 	<= dma0_ch_tts_wdata;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_4_tts_wen) begin
		ch_4_tts 	<= dma1_ch_tts_wdata;
	end
`endif
end
`endif
`ifdef DMAC_CONFIG_CH5

assign ch_5_ctl = {
		ch_5_src_bus_inf_idx, ch_5_dst_bus_inf_idx,
		ch_5_priority, 1'b0, ch_5_src_burst_size, ch_5_src_width, ch_5_dst_width,
		ch_5_src_mode, ch_5_dst_mode, ch_5_src_addr_ctl, ch_5_dst_addr_ctl,
		ch_5_src_req_sel, ch_5_dst_req_sel, ch_5_int_abt_mask,
		ch_5_int_err_mask, ch_5_int_tc_mask, ch_5_en};
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_5_int_tc_mask	<= 1'b0;
		ch_5_int_err_mask	<= 1'b0;
		ch_5_int_abt_mask	<= 1'b0;
		ch_5_dst_req_sel	<= 4'b0;
		ch_5_src_req_sel	<= 4'b0;
		ch_5_dst_addr_ctl	<= 2'b0;
		ch_5_src_addr_ctl	<= 2'b0;
		ch_5_dst_mode		<= 1'b0;
		ch_5_src_mode		<= 1'b0;
		ch_5_dst_width		<= 3'b0;
		ch_5_src_width		<= 3'b0;
		ch_5_src_burst_size	<= 4'b0;
		ch_5_priority		<= 1'b0;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_5_dst_bus_inf_idx	<= 1'b0;
		ch_5_src_bus_inf_idx	<= 1'b0;
`endif
	end
	else if (ch_5_ctl_w_sel) begin
		ch_5_int_tc_mask	<= wdata[1];
		ch_5_int_err_mask	<= wdata[2];
		ch_5_int_abt_mask	<= wdata[3];
		ch_5_dst_req_sel	<= wdata[7:4];
		ch_5_src_req_sel	<= wdata[11:8];
		ch_5_dst_addr_ctl	<= wdata[13:12];
		ch_5_src_addr_ctl	<= wdata[15:14];
		ch_5_dst_mode		<= wdata[16];
		ch_5_src_mode		<= wdata[17];
		ch_5_dst_width		<= wdata[20:18];
		ch_5_src_width		<= wdata[23:21];
		ch_5_src_burst_size	<= wdata[27:24];
		ch_5_priority		<= wdata[29];
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_5_dst_bus_inf_idx	<= wdata[30];
		ch_5_src_bus_inf_idx	<= wdata[31];
`endif
	end
	else if (dma0_ch_5_ctl_wen) begin
		ch_5_int_tc_mask	<= dma0_ch_ctl_wdata[1];
		ch_5_int_err_mask	<= dma0_ch_ctl_wdata[2];
		ch_5_int_abt_mask	<= dma0_ch_ctl_wdata[3];
		ch_5_dst_req_sel	<= dma0_ch_ctl_wdata[7:4];
		ch_5_src_req_sel	<= dma0_ch_ctl_wdata[11:8];
		ch_5_dst_addr_ctl	<= dma0_ch_ctl_wdata[13:12];
		ch_5_src_addr_ctl	<= dma0_ch_ctl_wdata[15:14];
		ch_5_dst_mode		<= dma0_ch_ctl_wdata[16];
		ch_5_src_mode		<= dma0_ch_ctl_wdata[17];
		ch_5_dst_width		<= dma0_ch_ctl_wdata[20:18];
		ch_5_src_width		<= dma0_ch_ctl_wdata[23:21];
		ch_5_src_burst_size	<= dma0_ch_ctl_wdata[27:24];
		ch_5_priority		<= dma0_ch_ctl_wdata_pri;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_5_dst_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[0];
		ch_5_src_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[1];
`endif
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_5_ctl_wen) begin
		ch_5_int_tc_mask	<= dma1_ch_ctl_wdata[1];
		ch_5_int_err_mask	<= dma1_ch_ctl_wdata[2];
		ch_5_int_abt_mask	<= dma1_ch_ctl_wdata[3];
		ch_5_dst_req_sel	<= dma1_ch_ctl_wdata[7:4];
		ch_5_src_req_sel	<= dma1_ch_ctl_wdata[11:8];
		ch_5_dst_addr_ctl	<= dma1_ch_ctl_wdata[13:12];
		ch_5_src_addr_ctl	<= dma1_ch_ctl_wdata[15:14];
		ch_5_dst_mode		<= dma1_ch_ctl_wdata[16];
		ch_5_src_mode		<= dma1_ch_ctl_wdata[17];
		ch_5_dst_width		<= dma1_ch_ctl_wdata[20:18];
		ch_5_src_width		<= dma1_ch_ctl_wdata[23:21];
		ch_5_src_burst_size	<= dma1_ch_ctl_wdata[27:24];
		ch_5_priority		<= dma1_ch_ctl_wdata_pri;
	 `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_5_dst_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[0];
		ch_5_src_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[1];
	 `endif
	end
`endif
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_5_en			<= 1'b0;
	end
	else if (ch_5_ctl_w_sel) begin
		ch_5_en			<= wdata[0];
	end
	else if (dma0_ch_5_en_wen | dma_soft_reset) begin
		ch_5_en			<= 1'b0;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_5_en_wen) begin
		ch_5_en			<= 1'b0;
	end
`endif
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_5_tts	<= {`ATCDMAC300_TTS_WIDTH{1'b0}};
	end
	else if (ch_5_tts_w_sel) begin
		ch_5_tts 	<= wdata[(`ATCDMAC300_TTS_WIDTH-1):0];
	end
	else if (dma0_ch_5_tts_wen) begin
		ch_5_tts 	<= dma0_ch_tts_wdata;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_5_tts_wen) begin
		ch_5_tts 	<= dma1_ch_tts_wdata;
	end
`endif
end
`endif
`ifdef DMAC_CONFIG_CH6

assign ch_6_ctl = {
		ch_6_src_bus_inf_idx, ch_6_dst_bus_inf_idx,
		ch_6_priority, 1'b0, ch_6_src_burst_size, ch_6_src_width, ch_6_dst_width,
		ch_6_src_mode, ch_6_dst_mode, ch_6_src_addr_ctl, ch_6_dst_addr_ctl,
		ch_6_src_req_sel, ch_6_dst_req_sel, ch_6_int_abt_mask,
		ch_6_int_err_mask, ch_6_int_tc_mask, ch_6_en};
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_6_int_tc_mask	<= 1'b0;
		ch_6_int_err_mask	<= 1'b0;
		ch_6_int_abt_mask	<= 1'b0;
		ch_6_dst_req_sel	<= 4'b0;
		ch_6_src_req_sel	<= 4'b0;
		ch_6_dst_addr_ctl	<= 2'b0;
		ch_6_src_addr_ctl	<= 2'b0;
		ch_6_dst_mode		<= 1'b0;
		ch_6_src_mode		<= 1'b0;
		ch_6_dst_width		<= 3'b0;
		ch_6_src_width		<= 3'b0;
		ch_6_src_burst_size	<= 4'b0;
		ch_6_priority		<= 1'b0;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_6_dst_bus_inf_idx	<= 1'b0;
		ch_6_src_bus_inf_idx	<= 1'b0;
`endif
	end
	else if (ch_6_ctl_w_sel) begin
		ch_6_int_tc_mask	<= wdata[1];
		ch_6_int_err_mask	<= wdata[2];
		ch_6_int_abt_mask	<= wdata[3];
		ch_6_dst_req_sel	<= wdata[7:4];
		ch_6_src_req_sel	<= wdata[11:8];
		ch_6_dst_addr_ctl	<= wdata[13:12];
		ch_6_src_addr_ctl	<= wdata[15:14];
		ch_6_dst_mode		<= wdata[16];
		ch_6_src_mode		<= wdata[17];
		ch_6_dst_width		<= wdata[20:18];
		ch_6_src_width		<= wdata[23:21];
		ch_6_src_burst_size	<= wdata[27:24];
		ch_6_priority		<= wdata[29];
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_6_dst_bus_inf_idx	<= wdata[30];
		ch_6_src_bus_inf_idx	<= wdata[31];
`endif
	end
	else if (dma0_ch_6_ctl_wen) begin
		ch_6_int_tc_mask	<= dma0_ch_ctl_wdata[1];
		ch_6_int_err_mask	<= dma0_ch_ctl_wdata[2];
		ch_6_int_abt_mask	<= dma0_ch_ctl_wdata[3];
		ch_6_dst_req_sel	<= dma0_ch_ctl_wdata[7:4];
		ch_6_src_req_sel	<= dma0_ch_ctl_wdata[11:8];
		ch_6_dst_addr_ctl	<= dma0_ch_ctl_wdata[13:12];
		ch_6_src_addr_ctl	<= dma0_ch_ctl_wdata[15:14];
		ch_6_dst_mode		<= dma0_ch_ctl_wdata[16];
		ch_6_src_mode		<= dma0_ch_ctl_wdata[17];
		ch_6_dst_width		<= dma0_ch_ctl_wdata[20:18];
		ch_6_src_width		<= dma0_ch_ctl_wdata[23:21];
		ch_6_src_burst_size	<= dma0_ch_ctl_wdata[27:24];
		ch_6_priority		<= dma0_ch_ctl_wdata_pri;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_6_dst_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[0];
		ch_6_src_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[1];
`endif
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_6_ctl_wen) begin
		ch_6_int_tc_mask	<= dma1_ch_ctl_wdata[1];
		ch_6_int_err_mask	<= dma1_ch_ctl_wdata[2];
		ch_6_int_abt_mask	<= dma1_ch_ctl_wdata[3];
		ch_6_dst_req_sel	<= dma1_ch_ctl_wdata[7:4];
		ch_6_src_req_sel	<= dma1_ch_ctl_wdata[11:8];
		ch_6_dst_addr_ctl	<= dma1_ch_ctl_wdata[13:12];
		ch_6_src_addr_ctl	<= dma1_ch_ctl_wdata[15:14];
		ch_6_dst_mode		<= dma1_ch_ctl_wdata[16];
		ch_6_src_mode		<= dma1_ch_ctl_wdata[17];
		ch_6_dst_width		<= dma1_ch_ctl_wdata[20:18];
		ch_6_src_width		<= dma1_ch_ctl_wdata[23:21];
		ch_6_src_burst_size	<= dma1_ch_ctl_wdata[27:24];
		ch_6_priority		<= dma1_ch_ctl_wdata_pri;
	 `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_6_dst_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[0];
		ch_6_src_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[1];
	 `endif
	end
`endif
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_6_en			<= 1'b0;
	end
	else if (ch_6_ctl_w_sel) begin
		ch_6_en			<= wdata[0];
	end
	else if (dma0_ch_6_en_wen | dma_soft_reset) begin
		ch_6_en			<= 1'b0;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_6_en_wen) begin
		ch_6_en			<= 1'b0;
	end
`endif
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_6_tts	<= {`ATCDMAC300_TTS_WIDTH{1'b0}};
	end
	else if (ch_6_tts_w_sel) begin
		ch_6_tts 	<= wdata[(`ATCDMAC300_TTS_WIDTH-1):0];
	end
	else if (dma0_ch_6_tts_wen) begin
		ch_6_tts 	<= dma0_ch_tts_wdata;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_6_tts_wen) begin
		ch_6_tts 	<= dma1_ch_tts_wdata;
	end
`endif
end
`endif
`ifdef DMAC_CONFIG_CH7

assign ch_7_ctl = {
		ch_7_src_bus_inf_idx, ch_7_dst_bus_inf_idx,
		ch_7_priority, 1'b0, ch_7_src_burst_size, ch_7_src_width, ch_7_dst_width,
		ch_7_src_mode, ch_7_dst_mode, ch_7_src_addr_ctl, ch_7_dst_addr_ctl,
		ch_7_src_req_sel, ch_7_dst_req_sel, ch_7_int_abt_mask,
		ch_7_int_err_mask, ch_7_int_tc_mask, ch_7_en};
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_7_int_tc_mask	<= 1'b0;
		ch_7_int_err_mask	<= 1'b0;
		ch_7_int_abt_mask	<= 1'b0;
		ch_7_dst_req_sel	<= 4'b0;
		ch_7_src_req_sel	<= 4'b0;
		ch_7_dst_addr_ctl	<= 2'b0;
		ch_7_src_addr_ctl	<= 2'b0;
		ch_7_dst_mode		<= 1'b0;
		ch_7_src_mode		<= 1'b0;
		ch_7_dst_width		<= 3'b0;
		ch_7_src_width		<= 3'b0;
		ch_7_src_burst_size	<= 4'b0;
		ch_7_priority		<= 1'b0;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_7_dst_bus_inf_idx	<= 1'b0;
		ch_7_src_bus_inf_idx	<= 1'b0;
`endif
	end
	else if (ch_7_ctl_w_sel) begin
		ch_7_int_tc_mask	<= wdata[1];
		ch_7_int_err_mask	<= wdata[2];
		ch_7_int_abt_mask	<= wdata[3];
		ch_7_dst_req_sel	<= wdata[7:4];
		ch_7_src_req_sel	<= wdata[11:8];
		ch_7_dst_addr_ctl	<= wdata[13:12];
		ch_7_src_addr_ctl	<= wdata[15:14];
		ch_7_dst_mode		<= wdata[16];
		ch_7_src_mode		<= wdata[17];
		ch_7_dst_width		<= wdata[20:18];
		ch_7_src_width		<= wdata[23:21];
		ch_7_src_burst_size	<= wdata[27:24];
		ch_7_priority		<= wdata[29];
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_7_dst_bus_inf_idx	<= wdata[30];
		ch_7_src_bus_inf_idx	<= wdata[31];
`endif
	end
	else if (dma0_ch_7_ctl_wen) begin
		ch_7_int_tc_mask	<= dma0_ch_ctl_wdata[1];
		ch_7_int_err_mask	<= dma0_ch_ctl_wdata[2];
		ch_7_int_abt_mask	<= dma0_ch_ctl_wdata[3];
		ch_7_dst_req_sel	<= dma0_ch_ctl_wdata[7:4];
		ch_7_src_req_sel	<= dma0_ch_ctl_wdata[11:8];
		ch_7_dst_addr_ctl	<= dma0_ch_ctl_wdata[13:12];
		ch_7_src_addr_ctl	<= dma0_ch_ctl_wdata[15:14];
		ch_7_dst_mode		<= dma0_ch_ctl_wdata[16];
		ch_7_src_mode		<= dma0_ch_ctl_wdata[17];
		ch_7_dst_width		<= dma0_ch_ctl_wdata[20:18];
		ch_7_src_width		<= dma0_ch_ctl_wdata[23:21];
		ch_7_src_burst_size	<= dma0_ch_ctl_wdata[27:24];
		ch_7_priority		<= dma0_ch_ctl_wdata_pri;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_7_dst_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[0];
		ch_7_src_bus_inf_idx	<= dma0_ch_ctl_wdata_idx[1];
`endif
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_7_ctl_wen) begin
		ch_7_int_tc_mask	<= dma1_ch_ctl_wdata[1];
		ch_7_int_err_mask	<= dma1_ch_ctl_wdata[2];
		ch_7_int_abt_mask	<= dma1_ch_ctl_wdata[3];
		ch_7_dst_req_sel	<= dma1_ch_ctl_wdata[7:4];
		ch_7_src_req_sel	<= dma1_ch_ctl_wdata[11:8];
		ch_7_dst_addr_ctl	<= dma1_ch_ctl_wdata[13:12];
		ch_7_src_addr_ctl	<= dma1_ch_ctl_wdata[15:14];
		ch_7_dst_mode		<= dma1_ch_ctl_wdata[16];
		ch_7_src_mode		<= dma1_ch_ctl_wdata[17];
		ch_7_dst_width		<= dma1_ch_ctl_wdata[20:18];
		ch_7_src_width		<= dma1_ch_ctl_wdata[23:21];
		ch_7_src_burst_size	<= dma1_ch_ctl_wdata[27:24];
		ch_7_priority		<= dma1_ch_ctl_wdata_pri;
	 `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		ch_7_dst_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[0];
		ch_7_src_bus_inf_idx	<= dma1_ch_ctl_wdata_idx[1];
	 `endif
	end
`endif
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_7_en			<= 1'b0;
	end
	else if (ch_7_ctl_w_sel) begin
		ch_7_en			<= wdata[0];
	end
	else if (dma0_ch_7_en_wen | dma_soft_reset) begin
		ch_7_en			<= 1'b0;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_7_en_wen) begin
		ch_7_en			<= 1'b0;
	end
`endif
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ch_7_tts	<= {`ATCDMAC300_TTS_WIDTH{1'b0}};
	end
	else if (ch_7_tts_w_sel) begin
		ch_7_tts 	<= wdata[(`ATCDMAC300_TTS_WIDTH-1):0];
	end
	else if (dma0_ch_7_tts_wen) begin
		ch_7_tts 	<= dma0_ch_tts_wdata;
	end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	else if (dma1_ch_7_tts_wen) begin
		ch_7_tts 	<= dma1_ch_tts_wdata;
	end
`endif
end
`endif


generate
 if (ADDR_WIDTH > 32) begin : address_gt_32_reg_assign
	`ifdef DMAC_CONFIG_CH0
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_0_src_addr_h;
reg	[31:0]                          	ch_0_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_0_dst_addr_h;
reg	[31:0]                          	ch_0_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_0_llp_reg_h;
reg	[31:3]                          	ch_0_llp_reg_l;
assign ch_0_src_addr = {ch_0_src_addr_h,ch_0_src_addr_l};
assign ch_0_dst_addr = {ch_0_dst_addr_h,ch_0_dst_addr_l};
assign ch_0_llp_reg = {ch_0_llp_reg_h,ch_0_llp_reg_l};
	wire ch_0_src_addr_h_r_sel	= ({addr[8:2],2'b0} == 9'h4c);
	wire ch_0_dst_addr_h_r_sel 	= ({addr[8:2],2'b0} == 9'h54);
	wire ch_0_src_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h4c);
	wire ch_0_dst_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h54);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	wire ch_0_llp_h_r_sel	= ({addr[8:2],2'b0} == 9'h5c);
	wire ch_0_llp_h_w_sel	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h5c);
	`endif
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_0_src_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_0_src_addr_w_sel) begin
	 		ch_0_src_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_0_src_addr_wen[0]) begin
	 		ch_0_src_addr_l[31:0] 	<= dma0_ch_src_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_0_src_addr_wen[0]) begin
	 		ch_0_src_addr_l[31:0] 	<= dma1_ch_src_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_0_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_0_src_addr_h_w_sel) begin
	 		ch_0_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_0_src_addr_wen[1]) begin
	 		ch_0_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_0_src_addr_wen[1]) begin
	 		ch_0_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_0_dst_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_0_dst_addr_w_sel) begin
	 		ch_0_dst_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_0_dst_addr_wen[0]) begin
	 		ch_0_dst_addr_l[31:0] 	<= dma0_ch_dst_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_0_dst_addr_wen[0]) begin
	 		ch_0_dst_addr_l[31:0] 	<= dma1_ch_dst_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_0_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_0_dst_addr_h_w_sel) begin
	 		ch_0_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_0_dst_addr_wen[1]) begin
	 		ch_0_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_0_dst_addr_wen[1]) begin
	 		ch_0_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	 `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_0_llp_reg_l[31:3]	<= 29'h0;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_0_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_0_llp_w_sel) begin
	 		ch_0_llp_reg_l[31:3] 	<= wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_0_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_0_llp_wen[0]) begin
	 		ch_0_llp_reg_l[31:3] 	<= dma0_ch_llp_wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_0_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_0_llp_wen[0]) begin
	 		ch_0_llp_reg_l[31:3] 	<= dma1_ch_llp_wdata[31:3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_0_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	  `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_0_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_0_llp_h_w_sel) begin
	 		ch_0_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_0_llp_wen[1]) begin
	 		ch_0_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_0_llp_wen[1]) begin
	 		ch_0_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `endif
	end
	assign ch_0_llp	= {ch_0_llp_reg, 2'b0, ch_0_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_0_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_0_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

	`ifdef DMAC_CONFIG_CH1
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_1_src_addr_h;
reg	[31:0]                          	ch_1_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_1_dst_addr_h;
reg	[31:0]                          	ch_1_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_1_llp_reg_h;
reg	[31:3]                          	ch_1_llp_reg_l;
assign ch_1_src_addr = {ch_1_src_addr_h,ch_1_src_addr_l};
assign ch_1_dst_addr = {ch_1_dst_addr_h,ch_1_dst_addr_l};
assign ch_1_llp_reg = {ch_1_llp_reg_h,ch_1_llp_reg_l};
	wire ch_1_src_addr_h_r_sel	= ({addr[8:2],2'b0} == 9'h6c);
	wire ch_1_dst_addr_h_r_sel 	= ({addr[8:2],2'b0} == 9'h74);
	wire ch_1_src_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h6c);
	wire ch_1_dst_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h74);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	wire ch_1_llp_h_r_sel	= ({addr[8:2],2'b0} == 9'h7c);
	wire ch_1_llp_h_w_sel	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h7c);
	`endif
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_1_src_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_1_src_addr_w_sel) begin
	 		ch_1_src_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_1_src_addr_wen[0]) begin
	 		ch_1_src_addr_l[31:0] 	<= dma0_ch_src_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_1_src_addr_wen[0]) begin
	 		ch_1_src_addr_l[31:0] 	<= dma1_ch_src_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_1_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_1_src_addr_h_w_sel) begin
	 		ch_1_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_1_src_addr_wen[1]) begin
	 		ch_1_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_1_src_addr_wen[1]) begin
	 		ch_1_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_1_dst_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_1_dst_addr_w_sel) begin
	 		ch_1_dst_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_1_dst_addr_wen[0]) begin
	 		ch_1_dst_addr_l[31:0] 	<= dma0_ch_dst_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_1_dst_addr_wen[0]) begin
	 		ch_1_dst_addr_l[31:0] 	<= dma1_ch_dst_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_1_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_1_dst_addr_h_w_sel) begin
	 		ch_1_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_1_dst_addr_wen[1]) begin
	 		ch_1_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_1_dst_addr_wen[1]) begin
	 		ch_1_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	 `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_1_llp_reg_l[31:3]	<= 29'h0;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_1_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_1_llp_w_sel) begin
	 		ch_1_llp_reg_l[31:3] 	<= wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_1_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_1_llp_wen[0]) begin
	 		ch_1_llp_reg_l[31:3] 	<= dma0_ch_llp_wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_1_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_1_llp_wen[0]) begin
	 		ch_1_llp_reg_l[31:3] 	<= dma1_ch_llp_wdata[31:3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_1_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	  `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_1_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_1_llp_h_w_sel) begin
	 		ch_1_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_1_llp_wen[1]) begin
	 		ch_1_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_1_llp_wen[1]) begin
	 		ch_1_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `endif
	end
	assign ch_1_llp	= {ch_1_llp_reg, 2'b0, ch_1_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_1_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_1_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

	`ifdef DMAC_CONFIG_CH2
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_2_src_addr_h;
reg	[31:0]                          	ch_2_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_2_dst_addr_h;
reg	[31:0]                          	ch_2_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_2_llp_reg_h;
reg	[31:3]                          	ch_2_llp_reg_l;
assign ch_2_src_addr = {ch_2_src_addr_h,ch_2_src_addr_l};
assign ch_2_dst_addr = {ch_2_dst_addr_h,ch_2_dst_addr_l};
assign ch_2_llp_reg = {ch_2_llp_reg_h,ch_2_llp_reg_l};
	wire ch_2_src_addr_h_r_sel	= ({addr[8:2],2'b0} == 9'h8c);
	wire ch_2_dst_addr_h_r_sel 	= ({addr[8:2],2'b0} == 9'h94);
	wire ch_2_src_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h8c);
	wire ch_2_dst_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h94);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	wire ch_2_llp_h_r_sel	= ({addr[8:2],2'b0} == 9'h9c);
	wire ch_2_llp_h_w_sel	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h9c);
	`endif
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_2_src_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_2_src_addr_w_sel) begin
	 		ch_2_src_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_2_src_addr_wen[0]) begin
	 		ch_2_src_addr_l[31:0] 	<= dma0_ch_src_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_2_src_addr_wen[0]) begin
	 		ch_2_src_addr_l[31:0] 	<= dma1_ch_src_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_2_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_2_src_addr_h_w_sel) begin
	 		ch_2_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_2_src_addr_wen[1]) begin
	 		ch_2_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_2_src_addr_wen[1]) begin
	 		ch_2_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_2_dst_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_2_dst_addr_w_sel) begin
	 		ch_2_dst_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_2_dst_addr_wen[0]) begin
	 		ch_2_dst_addr_l[31:0] 	<= dma0_ch_dst_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_2_dst_addr_wen[0]) begin
	 		ch_2_dst_addr_l[31:0] 	<= dma1_ch_dst_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_2_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_2_dst_addr_h_w_sel) begin
	 		ch_2_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_2_dst_addr_wen[1]) begin
	 		ch_2_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_2_dst_addr_wen[1]) begin
	 		ch_2_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	 `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_2_llp_reg_l[31:3]	<= 29'h0;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_2_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_2_llp_w_sel) begin
	 		ch_2_llp_reg_l[31:3] 	<= wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_2_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_2_llp_wen[0]) begin
	 		ch_2_llp_reg_l[31:3] 	<= dma0_ch_llp_wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_2_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_2_llp_wen[0]) begin
	 		ch_2_llp_reg_l[31:3] 	<= dma1_ch_llp_wdata[31:3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_2_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	  `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_2_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_2_llp_h_w_sel) begin
	 		ch_2_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_2_llp_wen[1]) begin
	 		ch_2_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_2_llp_wen[1]) begin
	 		ch_2_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `endif
	end
	assign ch_2_llp	= {ch_2_llp_reg, 2'b0, ch_2_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_2_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_2_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

	`ifdef DMAC_CONFIG_CH3
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_3_src_addr_h;
reg	[31:0]                          	ch_3_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_3_dst_addr_h;
reg	[31:0]                          	ch_3_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_3_llp_reg_h;
reg	[31:3]                          	ch_3_llp_reg_l;
assign ch_3_src_addr = {ch_3_src_addr_h,ch_3_src_addr_l};
assign ch_3_dst_addr = {ch_3_dst_addr_h,ch_3_dst_addr_l};
assign ch_3_llp_reg = {ch_3_llp_reg_h,ch_3_llp_reg_l};
	wire ch_3_src_addr_h_r_sel	= ({addr[8:2],2'b0} == 9'hac);
	wire ch_3_dst_addr_h_r_sel 	= ({addr[8:2],2'b0} == 9'hb4);
	wire ch_3_src_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hac);
	wire ch_3_dst_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hb4);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	wire ch_3_llp_h_r_sel	= ({addr[8:2],2'b0} == 9'hbc);
	wire ch_3_llp_h_w_sel	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hbc);
	`endif
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_3_src_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_3_src_addr_w_sel) begin
	 		ch_3_src_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_3_src_addr_wen[0]) begin
	 		ch_3_src_addr_l[31:0] 	<= dma0_ch_src_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_3_src_addr_wen[0]) begin
	 		ch_3_src_addr_l[31:0] 	<= dma1_ch_src_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_3_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_3_src_addr_h_w_sel) begin
	 		ch_3_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_3_src_addr_wen[1]) begin
	 		ch_3_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_3_src_addr_wen[1]) begin
	 		ch_3_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_3_dst_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_3_dst_addr_w_sel) begin
	 		ch_3_dst_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_3_dst_addr_wen[0]) begin
	 		ch_3_dst_addr_l[31:0] 	<= dma0_ch_dst_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_3_dst_addr_wen[0]) begin
	 		ch_3_dst_addr_l[31:0] 	<= dma1_ch_dst_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_3_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_3_dst_addr_h_w_sel) begin
	 		ch_3_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_3_dst_addr_wen[1]) begin
	 		ch_3_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_3_dst_addr_wen[1]) begin
	 		ch_3_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	 `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_3_llp_reg_l[31:3]	<= 29'h0;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_3_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_3_llp_w_sel) begin
	 		ch_3_llp_reg_l[31:3] 	<= wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_3_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_3_llp_wen[0]) begin
	 		ch_3_llp_reg_l[31:3] 	<= dma0_ch_llp_wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_3_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_3_llp_wen[0]) begin
	 		ch_3_llp_reg_l[31:3] 	<= dma1_ch_llp_wdata[31:3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_3_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	  `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_3_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_3_llp_h_w_sel) begin
	 		ch_3_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_3_llp_wen[1]) begin
	 		ch_3_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_3_llp_wen[1]) begin
	 		ch_3_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `endif
	end
	assign ch_3_llp	= {ch_3_llp_reg, 2'b0, ch_3_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_3_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_3_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

	`ifdef DMAC_CONFIG_CH4
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_4_src_addr_h;
reg	[31:0]                          	ch_4_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_4_dst_addr_h;
reg	[31:0]                          	ch_4_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_4_llp_reg_h;
reg	[31:3]                          	ch_4_llp_reg_l;
assign ch_4_src_addr = {ch_4_src_addr_h,ch_4_src_addr_l};
assign ch_4_dst_addr = {ch_4_dst_addr_h,ch_4_dst_addr_l};
assign ch_4_llp_reg = {ch_4_llp_reg_h,ch_4_llp_reg_l};
	wire ch_4_src_addr_h_r_sel	= ({addr[8:2],2'b0} == 9'hcc);
	wire ch_4_dst_addr_h_r_sel 	= ({addr[8:2],2'b0} == 9'hd4);
	wire ch_4_src_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hcc);
	wire ch_4_dst_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hd4);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	wire ch_4_llp_h_r_sel	= ({addr[8:2],2'b0} == 9'hdc);
	wire ch_4_llp_h_w_sel	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hdc);
	`endif
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_4_src_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_4_src_addr_w_sel) begin
	 		ch_4_src_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_4_src_addr_wen[0]) begin
	 		ch_4_src_addr_l[31:0] 	<= dma0_ch_src_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_4_src_addr_wen[0]) begin
	 		ch_4_src_addr_l[31:0] 	<= dma1_ch_src_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_4_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_4_src_addr_h_w_sel) begin
	 		ch_4_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_4_src_addr_wen[1]) begin
	 		ch_4_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_4_src_addr_wen[1]) begin
	 		ch_4_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_4_dst_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_4_dst_addr_w_sel) begin
	 		ch_4_dst_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_4_dst_addr_wen[0]) begin
	 		ch_4_dst_addr_l[31:0] 	<= dma0_ch_dst_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_4_dst_addr_wen[0]) begin
	 		ch_4_dst_addr_l[31:0] 	<= dma1_ch_dst_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_4_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_4_dst_addr_h_w_sel) begin
	 		ch_4_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_4_dst_addr_wen[1]) begin
	 		ch_4_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_4_dst_addr_wen[1]) begin
	 		ch_4_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	 `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_4_llp_reg_l[31:3]	<= 29'h0;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_4_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_4_llp_w_sel) begin
	 		ch_4_llp_reg_l[31:3] 	<= wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_4_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_4_llp_wen[0]) begin
	 		ch_4_llp_reg_l[31:3] 	<= dma0_ch_llp_wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_4_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_4_llp_wen[0]) begin
	 		ch_4_llp_reg_l[31:3] 	<= dma1_ch_llp_wdata[31:3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_4_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	  `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_4_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_4_llp_h_w_sel) begin
	 		ch_4_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_4_llp_wen[1]) begin
	 		ch_4_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_4_llp_wen[1]) begin
	 		ch_4_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `endif
	end
	assign ch_4_llp	= {ch_4_llp_reg, 2'b0, ch_4_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_4_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_4_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

	`ifdef DMAC_CONFIG_CH5
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_5_src_addr_h;
reg	[31:0]                          	ch_5_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_5_dst_addr_h;
reg	[31:0]                          	ch_5_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_5_llp_reg_h;
reg	[31:3]                          	ch_5_llp_reg_l;
assign ch_5_src_addr = {ch_5_src_addr_h,ch_5_src_addr_l};
assign ch_5_dst_addr = {ch_5_dst_addr_h,ch_5_dst_addr_l};
assign ch_5_llp_reg = {ch_5_llp_reg_h,ch_5_llp_reg_l};
	wire ch_5_src_addr_h_r_sel	= ({addr[8:2],2'b0} == 9'hec);
	wire ch_5_dst_addr_h_r_sel 	= ({addr[8:2],2'b0} == 9'hf4);
	wire ch_5_src_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hec);
	wire ch_5_dst_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hf4);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	wire ch_5_llp_h_r_sel	= ({addr[8:2],2'b0} == 9'hfc);
	wire ch_5_llp_h_w_sel	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'hfc);
	`endif
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_5_src_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_5_src_addr_w_sel) begin
	 		ch_5_src_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_5_src_addr_wen[0]) begin
	 		ch_5_src_addr_l[31:0] 	<= dma0_ch_src_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_5_src_addr_wen[0]) begin
	 		ch_5_src_addr_l[31:0] 	<= dma1_ch_src_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_5_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_5_src_addr_h_w_sel) begin
	 		ch_5_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_5_src_addr_wen[1]) begin
	 		ch_5_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_5_src_addr_wen[1]) begin
	 		ch_5_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_5_dst_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_5_dst_addr_w_sel) begin
	 		ch_5_dst_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_5_dst_addr_wen[0]) begin
	 		ch_5_dst_addr_l[31:0] 	<= dma0_ch_dst_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_5_dst_addr_wen[0]) begin
	 		ch_5_dst_addr_l[31:0] 	<= dma1_ch_dst_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_5_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_5_dst_addr_h_w_sel) begin
	 		ch_5_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_5_dst_addr_wen[1]) begin
	 		ch_5_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_5_dst_addr_wen[1]) begin
	 		ch_5_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	 `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_5_llp_reg_l[31:3]	<= 29'h0;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_5_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_5_llp_w_sel) begin
	 		ch_5_llp_reg_l[31:3] 	<= wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_5_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_5_llp_wen[0]) begin
	 		ch_5_llp_reg_l[31:3] 	<= dma0_ch_llp_wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_5_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_5_llp_wen[0]) begin
	 		ch_5_llp_reg_l[31:3] 	<= dma1_ch_llp_wdata[31:3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_5_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	  `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_5_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_5_llp_h_w_sel) begin
	 		ch_5_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_5_llp_wen[1]) begin
	 		ch_5_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_5_llp_wen[1]) begin
	 		ch_5_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `endif
	end
	assign ch_5_llp	= {ch_5_llp_reg, 2'b0, ch_5_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_5_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_5_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

	`ifdef DMAC_CONFIG_CH6
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_6_src_addr_h;
reg	[31:0]                          	ch_6_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_6_dst_addr_h;
reg	[31:0]                          	ch_6_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_6_llp_reg_h;
reg	[31:3]                          	ch_6_llp_reg_l;
assign ch_6_src_addr = {ch_6_src_addr_h,ch_6_src_addr_l};
assign ch_6_dst_addr = {ch_6_dst_addr_h,ch_6_dst_addr_l};
assign ch_6_llp_reg = {ch_6_llp_reg_h,ch_6_llp_reg_l};
	wire ch_6_src_addr_h_r_sel	= ({addr[8:2],2'b0} == 9'h10c);
	wire ch_6_dst_addr_h_r_sel 	= ({addr[8:2],2'b0} == 9'h114);
	wire ch_6_src_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h10c);
	wire ch_6_dst_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h114);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	wire ch_6_llp_h_r_sel	= ({addr[8:2],2'b0} == 9'h11c);
	wire ch_6_llp_h_w_sel	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h11c);
	`endif
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_6_src_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_6_src_addr_w_sel) begin
	 		ch_6_src_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_6_src_addr_wen[0]) begin
	 		ch_6_src_addr_l[31:0] 	<= dma0_ch_src_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_6_src_addr_wen[0]) begin
	 		ch_6_src_addr_l[31:0] 	<= dma1_ch_src_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_6_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_6_src_addr_h_w_sel) begin
	 		ch_6_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_6_src_addr_wen[1]) begin
	 		ch_6_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_6_src_addr_wen[1]) begin
	 		ch_6_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_6_dst_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_6_dst_addr_w_sel) begin
	 		ch_6_dst_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_6_dst_addr_wen[0]) begin
	 		ch_6_dst_addr_l[31:0] 	<= dma0_ch_dst_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_6_dst_addr_wen[0]) begin
	 		ch_6_dst_addr_l[31:0] 	<= dma1_ch_dst_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_6_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_6_dst_addr_h_w_sel) begin
	 		ch_6_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_6_dst_addr_wen[1]) begin
	 		ch_6_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_6_dst_addr_wen[1]) begin
	 		ch_6_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	 `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_6_llp_reg_l[31:3]	<= 29'h0;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_6_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_6_llp_w_sel) begin
	 		ch_6_llp_reg_l[31:3] 	<= wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_6_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_6_llp_wen[0]) begin
	 		ch_6_llp_reg_l[31:3] 	<= dma0_ch_llp_wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_6_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_6_llp_wen[0]) begin
	 		ch_6_llp_reg_l[31:3] 	<= dma1_ch_llp_wdata[31:3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_6_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	  `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_6_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_6_llp_h_w_sel) begin
	 		ch_6_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_6_llp_wen[1]) begin
	 		ch_6_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_6_llp_wen[1]) begin
	 		ch_6_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `endif
	end
	assign ch_6_llp	= {ch_6_llp_reg, 2'b0, ch_6_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_6_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_6_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

	`ifdef DMAC_CONFIG_CH7
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_7_src_addr_h;
reg	[31:0]                          	ch_7_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_7_dst_addr_h;
reg	[31:0]                          	ch_7_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	ch_7_llp_reg_h;
reg	[31:3]                          	ch_7_llp_reg_l;
assign ch_7_src_addr = {ch_7_src_addr_h,ch_7_src_addr_l};
assign ch_7_dst_addr = {ch_7_dst_addr_h,ch_7_dst_addr_l};
assign ch_7_llp_reg = {ch_7_llp_reg_h,ch_7_llp_reg_l};
	wire ch_7_src_addr_h_r_sel	= ({addr[8:2],2'b0} == 9'h12c);
	wire ch_7_dst_addr_h_r_sel 	= ({addr[8:2],2'b0} == 9'h134);
	wire ch_7_src_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h12c);
	wire ch_7_dst_addr_h_w_sel 	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h134);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	wire ch_7_llp_h_r_sel	= ({addr[8:2],2'b0} == 9'h13c);
	wire ch_7_llp_h_w_sel	= wr_cmd_valid & ({addr[8:2],2'b0} == 9'h13c);
	`endif
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_7_src_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_7_src_addr_w_sel) begin
	 		ch_7_src_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_7_src_addr_wen[0]) begin
	 		ch_7_src_addr_l[31:0] 	<= dma0_ch_src_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_7_src_addr_wen[0]) begin
	 		ch_7_src_addr_l[31:0] 	<= dma1_ch_src_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_7_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_7_src_addr_h_w_sel) begin
	 		ch_7_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_7_src_addr_wen[1]) begin
	 		ch_7_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_7_src_addr_wen[1]) begin
	 		ch_7_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_src_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_7_dst_addr_l[31:0]	<= 32'h0;
		end
		else if (ch_7_dst_addr_w_sel) begin
	 		ch_7_dst_addr_l[31:0] 	<= wdata[31:0];
		end
		else if (dma0_ch_7_dst_addr_wen[0]) begin
	 		ch_7_dst_addr_l[31:0] 	<= dma0_ch_dst_addr_wdata[31:0];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_7_dst_addr_wen[0]) begin
	 		ch_7_dst_addr_l[31:0] 	<= dma1_ch_dst_addr_wdata[31:0];
		end
	 `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_7_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_7_dst_addr_h_w_sel) begin
	 		ch_7_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_7_dst_addr_wen[1]) begin
	 		ch_7_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_7_dst_addr_wen[1]) begin
	 		ch_7_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_dst_addr_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	 `endif
	end

	 `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_7_llp_reg_l[31:3]	<= 29'h0;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_7_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_7_llp_w_sel) begin
	 		ch_7_llp_reg_l[31:3] 	<= wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_7_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_7_llp_wen[0]) begin
	 		ch_7_llp_reg_l[31:3] 	<= dma0_ch_llp_wdata[31:3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_7_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_7_llp_wen[0]) begin
	 		ch_7_llp_reg_l[31:3] 	<= dma1_ch_llp_wdata[31:3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_7_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	  `endif
	end
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_7_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]	<= {(`ATCDMAC300_ADDR_WIDTH-32){1'b0}};
		end
		else if (ch_7_llp_h_w_sel) begin
	 		ch_7_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= wdata[(`ATCDMAC300_ADDR_WIDTH-33):0];
		end
		else if (dma0_ch_7_llp_wen[1]) begin
	 		ch_7_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_7_llp_wen[1]) begin
	 		ch_7_llp_reg_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0] <= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):32];
		end
	  `endif
	end
	assign ch_7_llp	= {ch_7_llp_reg, 2'b0, ch_7_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_7_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_7_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

assign rdata_buff_wdata =
		(({33{id_sel}} & {1'b0, `ATCDMAC300_ID}) |
		({33{config_sel}} & {1'b0, `ATCDMAC300_CHAIN_TRANSFER_EXIST, `ATCDMAC300_REQ_SYNC_EXIST, 4'h0, `DMA_DATA_WIDTH_REG, addr_msb, `ATCDMAC300_DUAL_DMA_CORE_EXIST,  `ATCDMAC300_DUAL_MASTER_IF_EXIST, req_ack_num, fifo_depth, ch_num}) |
		`ifdef DMAC_CONFIG_CH0
		({33{ch_0_ctl_r_sel}}        & {1'b0                             , ch_0_ctl                                    }) |
		({33{ch_0_src_addr_r_sel}}   & {1'b0                             , ch_0_src_addr_l[31:0]                         }) |
		({33{ch_0_src_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_0_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
		({33{ch_0_dst_addr_r_sel}}   & {1'b0                             , ch_0_dst_addr_l[31:0]                         }) |
		({33{ch_0_dst_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_0_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_0_llp_r_sel}}        & {1'b0                             , ch_0_llp[31:0]                              }) |
		({33{ch_0_llp_h_r_sel}}      & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_0_llp[(`ATCDMAC300_ADDR_WIDTH-1):32]     }) |
			`endif
		({33{ch_0_tts_r_sel}}        & {{33-`ATCDMAC300_TTS_WIDTH{1'b0}} , ch_0_tts                                    }) |
		`endif
		`ifdef DMAC_CONFIG_CH1
		({33{ch_1_ctl_r_sel}}        & {1'b0                             , ch_1_ctl                                    }) |
		({33{ch_1_src_addr_r_sel}}   & {1'b0                             , ch_1_src_addr_l[31:0]                         }) |
		({33{ch_1_src_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_1_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
		({33{ch_1_dst_addr_r_sel}}   & {1'b0                             , ch_1_dst_addr_l[31:0]                         }) |
		({33{ch_1_dst_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_1_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_1_llp_r_sel}}        & {1'b0                             , ch_1_llp[31:0]                              }) |
		({33{ch_1_llp_h_r_sel}}      & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_1_llp[(`ATCDMAC300_ADDR_WIDTH-1):32]     }) |
			`endif
		({33{ch_1_tts_r_sel}}        & {{33-`ATCDMAC300_TTS_WIDTH{1'b0}} , ch_1_tts                                    }) |
		`endif
		`ifdef DMAC_CONFIG_CH2
		({33{ch_2_ctl_r_sel}}        & {1'b0                             , ch_2_ctl                                    }) |
		({33{ch_2_src_addr_r_sel}}   & {1'b0                             , ch_2_src_addr_l[31:0]                         }) |
		({33{ch_2_src_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_2_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
		({33{ch_2_dst_addr_r_sel}}   & {1'b0                             , ch_2_dst_addr_l[31:0]                         }) |
		({33{ch_2_dst_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_2_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_2_llp_r_sel}}        & {1'b0                             , ch_2_llp[31:0]                              }) |
		({33{ch_2_llp_h_r_sel}}      & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_2_llp[(`ATCDMAC300_ADDR_WIDTH-1):32]     }) |
			`endif
		({33{ch_2_tts_r_sel}}        & {{33-`ATCDMAC300_TTS_WIDTH{1'b0}} , ch_2_tts                                    }) |
		`endif
		`ifdef DMAC_CONFIG_CH3
		({33{ch_3_ctl_r_sel}}        & {1'b0                             , ch_3_ctl                                    }) |
		({33{ch_3_src_addr_r_sel}}   & {1'b0                             , ch_3_src_addr_l[31:0]                         }) |
		({33{ch_3_src_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_3_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
		({33{ch_3_dst_addr_r_sel}}   & {1'b0                             , ch_3_dst_addr_l[31:0]                         }) |
		({33{ch_3_dst_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_3_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_3_llp_r_sel}}        & {1'b0                             , ch_3_llp[31:0]                              }) |
		({33{ch_3_llp_h_r_sel}}      & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_3_llp[(`ATCDMAC300_ADDR_WIDTH-1):32]     }) |
			`endif
		({33{ch_3_tts_r_sel}}        & {{33-`ATCDMAC300_TTS_WIDTH{1'b0}} , ch_3_tts                                    }) |
		`endif
		`ifdef DMAC_CONFIG_CH4
		({33{ch_4_ctl_r_sel}}        & {1'b0                             , ch_4_ctl                                    }) |
		({33{ch_4_src_addr_r_sel}}   & {1'b0                             , ch_4_src_addr_l[31:0]                         }) |
		({33{ch_4_src_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_4_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
		({33{ch_4_dst_addr_r_sel}}   & {1'b0                             , ch_4_dst_addr_l[31:0]                         }) |
		({33{ch_4_dst_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_4_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_4_llp_r_sel}}        & {1'b0                             , ch_4_llp[31:0]                              }) |
		({33{ch_4_llp_h_r_sel}}      & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_4_llp[(`ATCDMAC300_ADDR_WIDTH-1):32]     }) |
			`endif
		({33{ch_4_tts_r_sel}}        & {{33-`ATCDMAC300_TTS_WIDTH{1'b0}} , ch_4_tts                                    }) |
		`endif
		`ifdef DMAC_CONFIG_CH5
		({33{ch_5_ctl_r_sel}}        & {1'b0                             , ch_5_ctl                                    }) |
		({33{ch_5_src_addr_r_sel}}   & {1'b0                             , ch_5_src_addr_l[31:0]                         }) |
		({33{ch_5_src_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_5_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
		({33{ch_5_dst_addr_r_sel}}   & {1'b0                             , ch_5_dst_addr_l[31:0]                         }) |
		({33{ch_5_dst_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_5_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_5_llp_r_sel}}        & {1'b0                             , ch_5_llp[31:0]                              }) |
		({33{ch_5_llp_h_r_sel}}      & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_5_llp[(`ATCDMAC300_ADDR_WIDTH-1):32]     }) |
			`endif
		({33{ch_5_tts_r_sel}}        & {{33-`ATCDMAC300_TTS_WIDTH{1'b0}} , ch_5_tts                                    }) |
		`endif
		`ifdef DMAC_CONFIG_CH6
		({33{ch_6_ctl_r_sel}}        & {1'b0                             , ch_6_ctl                                    }) |
		({33{ch_6_src_addr_r_sel}}   & {1'b0                             , ch_6_src_addr_l[31:0]                         }) |
		({33{ch_6_src_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_6_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
		({33{ch_6_dst_addr_r_sel}}   & {1'b0                             , ch_6_dst_addr_l[31:0]                         }) |
		({33{ch_6_dst_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_6_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_6_llp_r_sel}}        & {1'b0                             , ch_6_llp[31:0]                              }) |
		({33{ch_6_llp_h_r_sel}}      & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_6_llp[(`ATCDMAC300_ADDR_WIDTH-1):32]     }) |
			`endif
		({33{ch_6_tts_r_sel}}        & {{33-`ATCDMAC300_TTS_WIDTH{1'b0}} , ch_6_tts                                    }) |
		`endif
		`ifdef DMAC_CONFIG_CH7
		({33{ch_7_ctl_r_sel}}        & {1'b0                             , ch_7_ctl                                    }) |
		({33{ch_7_src_addr_r_sel}}   & {1'b0                             , ch_7_src_addr_l[31:0]                         }) |
		({33{ch_7_src_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_7_src_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
		({33{ch_7_dst_addr_r_sel}}   & {1'b0                             , ch_7_dst_addr_l[31:0]                         }) |
		({33{ch_7_dst_addr_h_r_sel}} & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_7_dst_addr_h[(`ATCDMAC300_ADDR_WIDTH-1-32):0]}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_7_llp_r_sel}}        & {1'b0                             , ch_7_llp[31:0]                              }) |
		({33{ch_7_llp_h_r_sel}}      & {{65-`ATCDMAC300_ADDR_WIDTH{1'b0}}, ch_7_llp[(`ATCDMAC300_ADDR_WIDTH-1):32]     }) |
			`endif
		({33{ch_7_tts_r_sel}}        & {{33-`ATCDMAC300_TTS_WIDTH{1'b0}} , ch_7_tts                                    }) |
		`endif
		({33{ch_status_r_sel}}          & {1'b0                             , ch_status                                      }) |
		({33{ch_en_sel}}                & {1'b0                             , ch_en                                          }));

  end
  else begin : address_not_gt_32_reg_assign
	`ifdef DMAC_CONFIG_CH0
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_0_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_0_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):3]         	ch_0_llp_reg_l;
assign ch_0_src_addr = ch_0_src_addr_l;
assign ch_0_dst_addr = ch_0_dst_addr_l;
assign ch_0_llp_reg  = ch_0_llp_reg_l;
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_0_src_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_0_src_addr_w_sel) begin
	 		ch_0_src_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_0_src_addr_wen) begin
	 		ch_0_src_addr_l 	<= dma0_ch_src_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_0_src_addr_wen) begin
	 		ch_0_src_addr_l 	<= dma1_ch_src_addr_wdata;
		end
	  `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_0_dst_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_0_dst_addr_w_sel) begin
	 		ch_0_dst_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_0_dst_addr_wen) begin
	 		ch_0_dst_addr_l 	<= dma0_ch_dst_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_0_dst_addr_wen) begin
	 		ch_0_dst_addr_l 	<= dma1_ch_dst_addr_wdata;
		end
	  `endif
	end

	  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_0_llp_reg_l		<= {(`ATCDMAC300_ADDR_WIDTH-3){1'b0}};
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_0_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_0_llp_w_sel) begin
	 		ch_0_llp_reg_l		<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_0_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_0_llp_wen) begin
	 		ch_0_llp_reg_l		<= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_0_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
		`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_0_llp_wen) begin
	 		ch_0_llp_reg_l		<= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_0_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	 	`endif
	end
	assign ch_0_llp	= {ch_0_llp_reg, 2'b0, ch_0_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_0_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_0_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

	`ifdef DMAC_CONFIG_CH1
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_1_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_1_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):3]         	ch_1_llp_reg_l;
assign ch_1_src_addr = ch_1_src_addr_l;
assign ch_1_dst_addr = ch_1_dst_addr_l;
assign ch_1_llp_reg  = ch_1_llp_reg_l;
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_1_src_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_1_src_addr_w_sel) begin
	 		ch_1_src_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_1_src_addr_wen) begin
	 		ch_1_src_addr_l 	<= dma0_ch_src_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_1_src_addr_wen) begin
	 		ch_1_src_addr_l 	<= dma1_ch_src_addr_wdata;
		end
	  `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_1_dst_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_1_dst_addr_w_sel) begin
	 		ch_1_dst_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_1_dst_addr_wen) begin
	 		ch_1_dst_addr_l 	<= dma0_ch_dst_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_1_dst_addr_wen) begin
	 		ch_1_dst_addr_l 	<= dma1_ch_dst_addr_wdata;
		end
	  `endif
	end

	  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_1_llp_reg_l		<= {(`ATCDMAC300_ADDR_WIDTH-3){1'b0}};
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_1_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_1_llp_w_sel) begin
	 		ch_1_llp_reg_l		<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_1_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_1_llp_wen) begin
	 		ch_1_llp_reg_l		<= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_1_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
		`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_1_llp_wen) begin
	 		ch_1_llp_reg_l		<= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_1_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	 	`endif
	end
	assign ch_1_llp	= {ch_1_llp_reg, 2'b0, ch_1_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_1_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_1_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

	`ifdef DMAC_CONFIG_CH2
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_2_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_2_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):3]         	ch_2_llp_reg_l;
assign ch_2_src_addr = ch_2_src_addr_l;
assign ch_2_dst_addr = ch_2_dst_addr_l;
assign ch_2_llp_reg  = ch_2_llp_reg_l;
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_2_src_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_2_src_addr_w_sel) begin
	 		ch_2_src_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_2_src_addr_wen) begin
	 		ch_2_src_addr_l 	<= dma0_ch_src_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_2_src_addr_wen) begin
	 		ch_2_src_addr_l 	<= dma1_ch_src_addr_wdata;
		end
	  `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_2_dst_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_2_dst_addr_w_sel) begin
	 		ch_2_dst_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_2_dst_addr_wen) begin
	 		ch_2_dst_addr_l 	<= dma0_ch_dst_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_2_dst_addr_wen) begin
	 		ch_2_dst_addr_l 	<= dma1_ch_dst_addr_wdata;
		end
	  `endif
	end

	  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_2_llp_reg_l		<= {(`ATCDMAC300_ADDR_WIDTH-3){1'b0}};
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_2_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_2_llp_w_sel) begin
	 		ch_2_llp_reg_l		<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_2_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_2_llp_wen) begin
	 		ch_2_llp_reg_l		<= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_2_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
		`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_2_llp_wen) begin
	 		ch_2_llp_reg_l		<= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_2_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	 	`endif
	end
	assign ch_2_llp	= {ch_2_llp_reg, 2'b0, ch_2_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_2_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_2_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

	`ifdef DMAC_CONFIG_CH3
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_3_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_3_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):3]         	ch_3_llp_reg_l;
assign ch_3_src_addr = ch_3_src_addr_l;
assign ch_3_dst_addr = ch_3_dst_addr_l;
assign ch_3_llp_reg  = ch_3_llp_reg_l;
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_3_src_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_3_src_addr_w_sel) begin
	 		ch_3_src_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_3_src_addr_wen) begin
	 		ch_3_src_addr_l 	<= dma0_ch_src_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_3_src_addr_wen) begin
	 		ch_3_src_addr_l 	<= dma1_ch_src_addr_wdata;
		end
	  `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_3_dst_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_3_dst_addr_w_sel) begin
	 		ch_3_dst_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_3_dst_addr_wen) begin
	 		ch_3_dst_addr_l 	<= dma0_ch_dst_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_3_dst_addr_wen) begin
	 		ch_3_dst_addr_l 	<= dma1_ch_dst_addr_wdata;
		end
	  `endif
	end

	  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_3_llp_reg_l		<= {(`ATCDMAC300_ADDR_WIDTH-3){1'b0}};
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_3_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_3_llp_w_sel) begin
	 		ch_3_llp_reg_l		<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_3_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_3_llp_wen) begin
	 		ch_3_llp_reg_l		<= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_3_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
		`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_3_llp_wen) begin
	 		ch_3_llp_reg_l		<= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_3_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	 	`endif
	end
	assign ch_3_llp	= {ch_3_llp_reg, 2'b0, ch_3_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_3_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_3_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

	`ifdef DMAC_CONFIG_CH4
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_4_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_4_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):3]         	ch_4_llp_reg_l;
assign ch_4_src_addr = ch_4_src_addr_l;
assign ch_4_dst_addr = ch_4_dst_addr_l;
assign ch_4_llp_reg  = ch_4_llp_reg_l;
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_4_src_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_4_src_addr_w_sel) begin
	 		ch_4_src_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_4_src_addr_wen) begin
	 		ch_4_src_addr_l 	<= dma0_ch_src_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_4_src_addr_wen) begin
	 		ch_4_src_addr_l 	<= dma1_ch_src_addr_wdata;
		end
	  `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_4_dst_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_4_dst_addr_w_sel) begin
	 		ch_4_dst_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_4_dst_addr_wen) begin
	 		ch_4_dst_addr_l 	<= dma0_ch_dst_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_4_dst_addr_wen) begin
	 		ch_4_dst_addr_l 	<= dma1_ch_dst_addr_wdata;
		end
	  `endif
	end

	  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_4_llp_reg_l		<= {(`ATCDMAC300_ADDR_WIDTH-3){1'b0}};
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_4_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_4_llp_w_sel) begin
	 		ch_4_llp_reg_l		<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_4_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_4_llp_wen) begin
	 		ch_4_llp_reg_l		<= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_4_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
		`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_4_llp_wen) begin
	 		ch_4_llp_reg_l		<= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_4_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	 	`endif
	end
	assign ch_4_llp	= {ch_4_llp_reg, 2'b0, ch_4_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_4_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_4_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

	`ifdef DMAC_CONFIG_CH5
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_5_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_5_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):3]         	ch_5_llp_reg_l;
assign ch_5_src_addr = ch_5_src_addr_l;
assign ch_5_dst_addr = ch_5_dst_addr_l;
assign ch_5_llp_reg  = ch_5_llp_reg_l;
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_5_src_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_5_src_addr_w_sel) begin
	 		ch_5_src_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_5_src_addr_wen) begin
	 		ch_5_src_addr_l 	<= dma0_ch_src_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_5_src_addr_wen) begin
	 		ch_5_src_addr_l 	<= dma1_ch_src_addr_wdata;
		end
	  `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_5_dst_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_5_dst_addr_w_sel) begin
	 		ch_5_dst_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_5_dst_addr_wen) begin
	 		ch_5_dst_addr_l 	<= dma0_ch_dst_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_5_dst_addr_wen) begin
	 		ch_5_dst_addr_l 	<= dma1_ch_dst_addr_wdata;
		end
	  `endif
	end

	  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_5_llp_reg_l		<= {(`ATCDMAC300_ADDR_WIDTH-3){1'b0}};
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_5_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_5_llp_w_sel) begin
	 		ch_5_llp_reg_l		<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_5_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_5_llp_wen) begin
	 		ch_5_llp_reg_l		<= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_5_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
		`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_5_llp_wen) begin
	 		ch_5_llp_reg_l		<= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_5_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	 	`endif
	end
	assign ch_5_llp	= {ch_5_llp_reg, 2'b0, ch_5_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_5_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_5_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

	`ifdef DMAC_CONFIG_CH6
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_6_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_6_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):3]         	ch_6_llp_reg_l;
assign ch_6_src_addr = ch_6_src_addr_l;
assign ch_6_dst_addr = ch_6_dst_addr_l;
assign ch_6_llp_reg  = ch_6_llp_reg_l;
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_6_src_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_6_src_addr_w_sel) begin
	 		ch_6_src_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_6_src_addr_wen) begin
	 		ch_6_src_addr_l 	<= dma0_ch_src_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_6_src_addr_wen) begin
	 		ch_6_src_addr_l 	<= dma1_ch_src_addr_wdata;
		end
	  `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_6_dst_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_6_dst_addr_w_sel) begin
	 		ch_6_dst_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_6_dst_addr_wen) begin
	 		ch_6_dst_addr_l 	<= dma0_ch_dst_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_6_dst_addr_wen) begin
	 		ch_6_dst_addr_l 	<= dma1_ch_dst_addr_wdata;
		end
	  `endif
	end

	  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_6_llp_reg_l		<= {(`ATCDMAC300_ADDR_WIDTH-3){1'b0}};
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_6_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_6_llp_w_sel) begin
	 		ch_6_llp_reg_l		<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_6_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_6_llp_wen) begin
	 		ch_6_llp_reg_l		<= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_6_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
		`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_6_llp_wen) begin
	 		ch_6_llp_reg_l		<= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_6_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	 	`endif
	end
	assign ch_6_llp	= {ch_6_llp_reg, 2'b0, ch_6_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_6_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_6_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif

	`ifdef DMAC_CONFIG_CH7
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_7_src_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]         	ch_7_dst_addr_l;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):3]         	ch_7_llp_reg_l;
assign ch_7_src_addr = ch_7_src_addr_l;
assign ch_7_dst_addr = ch_7_dst_addr_l;
assign ch_7_llp_reg  = ch_7_llp_reg_l;
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_7_src_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_7_src_addr_w_sel) begin
	 		ch_7_src_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_7_src_addr_wen) begin
	 		ch_7_src_addr_l 	<= dma0_ch_src_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_7_src_addr_wen) begin
	 		ch_7_src_addr_l 	<= dma1_ch_src_addr_wdata;
		end
	  `endif
	end

	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_7_dst_addr_l	<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		end
		else if (ch_7_dst_addr_w_sel) begin
	 		ch_7_dst_addr_l 	<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):0];
		end
		else if (dma0_ch_7_dst_addr_wen) begin
	 		ch_7_dst_addr_l 	<= dma0_ch_dst_addr_wdata;
		end
	  `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_7_dst_addr_wen) begin
	 		ch_7_dst_addr_l 	<= dma1_ch_dst_addr_wdata;
		end
	  `endif
	end

	  `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	always @(posedge aclk or negedge aresetn) begin
		if (!aresetn) begin
			ch_7_llp_reg_l		<= {(`ATCDMAC300_ADDR_WIDTH-3){1'b0}};
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_7_lld_bus_inf_idx <= 1'b0;
		`endif
		end
		else if (ch_7_llp_w_sel) begin
	 		ch_7_llp_reg_l		<= wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_7_lld_bus_inf_idx <= wdata[0];
		`endif
		end
		else if (dma0_ch_7_llp_wen) begin
	 		ch_7_llp_reg_l		<= dma0_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_7_lld_bus_inf_idx <= dma0_ch_llp_wdata_idx;
		`endif
		end
		`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
		else if (dma1_ch_7_llp_wen) begin
	 		ch_7_llp_reg_l		<= dma1_ch_llp_wdata[(`ATCDMAC300_ADDR_WIDTH-1):3];
			`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			ch_7_lld_bus_inf_idx <= dma1_ch_llp_wdata_idx;
			`endif
		end
	 	`endif
	end
	assign ch_7_llp	= {ch_7_llp_reg, 2'b0, ch_7_lld_bus_inf_idx};
	  `endif
	`else
	assign ch_7_src_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	assign ch_7_dst_addr = {`ATCDMAC300_ADDR_WIDTH{1'b0}};
	`endif


assign rdata_buff_wdata =
		(({33{id_sel}}    & {1'b0, `ATCDMAC300_ID}) |
		({33{config_sel}} & {1'b0, `ATCDMAC300_CHAIN_TRANSFER_EXIST, `ATCDMAC300_REQ_SYNC_EXIST, 4'h0, `DMA_DATA_WIDTH_REG, addr_msb, `ATCDMAC300_DUAL_DMA_CORE_EXIST , `ATCDMAC300_DUAL_MASTER_IF_EXIST, req_ack_num, fifo_depth, ch_num}) |
		`ifdef DMAC_CONFIG_CH0
		({33{ch_0_ctl_r_sel}}      & {1'b0                               , ch_0_ctl     }) |
		({33{ch_0_src_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_0_src_addr_l}) |
		({33{ch_0_dst_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_0_dst_addr_l}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_0_llp_r_sel}}      & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_0_llp     }) |
			`endif
		({33{ch_0_tts_r_sel}}      & {{(33-`ATCDMAC300_TTS_WIDTH){1'b0}}, ch_0_tts      }) |
		`endif
		`ifdef DMAC_CONFIG_CH1
		({33{ch_1_ctl_r_sel}}      & {1'b0                               , ch_1_ctl     }) |
		({33{ch_1_src_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_1_src_addr_l}) |
		({33{ch_1_dst_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_1_dst_addr_l}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_1_llp_r_sel}}      & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_1_llp     }) |
			`endif
		({33{ch_1_tts_r_sel}}      & {{(33-`ATCDMAC300_TTS_WIDTH){1'b0}}, ch_1_tts      }) |
		`endif
		`ifdef DMAC_CONFIG_CH2
		({33{ch_2_ctl_r_sel}}      & {1'b0                               , ch_2_ctl     }) |
		({33{ch_2_src_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_2_src_addr_l}) |
		({33{ch_2_dst_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_2_dst_addr_l}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_2_llp_r_sel}}      & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_2_llp     }) |
			`endif
		({33{ch_2_tts_r_sel}}      & {{(33-`ATCDMAC300_TTS_WIDTH){1'b0}}, ch_2_tts      }) |
		`endif
		`ifdef DMAC_CONFIG_CH3
		({33{ch_3_ctl_r_sel}}      & {1'b0                               , ch_3_ctl     }) |
		({33{ch_3_src_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_3_src_addr_l}) |
		({33{ch_3_dst_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_3_dst_addr_l}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_3_llp_r_sel}}      & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_3_llp     }) |
			`endif
		({33{ch_3_tts_r_sel}}      & {{(33-`ATCDMAC300_TTS_WIDTH){1'b0}}, ch_3_tts      }) |
		`endif
		`ifdef DMAC_CONFIG_CH4
		({33{ch_4_ctl_r_sel}}      & {1'b0                               , ch_4_ctl     }) |
		({33{ch_4_src_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_4_src_addr_l}) |
		({33{ch_4_dst_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_4_dst_addr_l}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_4_llp_r_sel}}      & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_4_llp     }) |
			`endif
		({33{ch_4_tts_r_sel}}      & {{(33-`ATCDMAC300_TTS_WIDTH){1'b0}}, ch_4_tts      }) |
		`endif
		`ifdef DMAC_CONFIG_CH5
		({33{ch_5_ctl_r_sel}}      & {1'b0                               , ch_5_ctl     }) |
		({33{ch_5_src_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_5_src_addr_l}) |
		({33{ch_5_dst_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_5_dst_addr_l}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_5_llp_r_sel}}      & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_5_llp     }) |
			`endif
		({33{ch_5_tts_r_sel}}      & {{(33-`ATCDMAC300_TTS_WIDTH){1'b0}}, ch_5_tts      }) |
		`endif
		`ifdef DMAC_CONFIG_CH6
		({33{ch_6_ctl_r_sel}}      & {1'b0                               , ch_6_ctl     }) |
		({33{ch_6_src_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_6_src_addr_l}) |
		({33{ch_6_dst_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_6_dst_addr_l}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_6_llp_r_sel}}      & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_6_llp     }) |
			`endif
		({33{ch_6_tts_r_sel}}      & {{(33-`ATCDMAC300_TTS_WIDTH){1'b0}}, ch_6_tts      }) |
		`endif
		`ifdef DMAC_CONFIG_CH7
		({33{ch_7_ctl_r_sel}}      & {1'b0                               , ch_7_ctl     }) |
		({33{ch_7_src_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_7_src_addr_l}) |
		({33{ch_7_dst_addr_r_sel}} & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_7_dst_addr_l}) |
			`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
		({33{ch_7_llp_r_sel}}      & {{(33-`ATCDMAC300_ADDR_WIDTH){1'b0}}, ch_7_llp     }) |
			`endif
		({33{ch_7_tts_r_sel}}      & {{(33-`ATCDMAC300_TTS_WIDTH){1'b0}}, ch_7_tts      }) |
		`endif
		({33{ch_status_r_sel}}        & {1'b0                              , ch_status        }) |
		({33{ch_en_sel}}              & {1'b0                              , ch_en            }));

  end
endgenerate

endmodule

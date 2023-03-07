// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

module atcdmac300_chmux (
                          	  aclk,
                          	  aresetn,
                          	  dma_req,
                          	  dma_ack,
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
                          	  granted_channel,
                          	  ch_request,
                          	  ch_level,
                          	  current_channel,
                          `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                          	  dma1_idle_state,
                          	  dma1_ch_ctl_wen,
                          	  dma1_ch_en_wen,
                          	  dma1_ch_src_addr_wen,
                          	  dma1_ch_dst_addr_wen,
                             `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_llp_wen,
                             `endif
                          	  dma1_ch_tts_wen,
                          	  dma1_ch_tc_wen,
                          	  dma1_ch_err_wen,
                          	  dma1_ch_int_wen,
                          	  dma1_ch_src_ack,
                          	  dma1_ch_dst_ack,
                          	  dma1_arb_end,
                          	  dma1_current_channel,
                          	  dma1_ch_src_addr_ctl,
                          	  dma1_ch_dst_addr_ctl,
                          	  dma1_ch_src_width,
                          	  dma1_ch_dst_width,
                          	  dma1_ch_src_burst_size,
                          	  dma1_ch_src_mode,
                          	  dma1_ch_src_request,
                          	  dma1_ch_dst_mode,
                          	  dma1_ch_dst_request,
                          	  dma1_ch_tts,
                          	  dma1_ch_src_addr,
                          	  dma1_ch_dst_addr,
                             `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  dma1_ch_src_bus_inf_idx,
                          	  dma1_ch_dst_bus_inf_idx,
                             `endif
                             `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma1_ch_llp,
                                `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  dma1_ch_lld_bus_inf_idx,
                                `endif
                             `endif
                          	  dma1_ch_abt,
                          	  dma1_ch_int_tc_mask,
                          	  dma1_ch_int_err_mask,
                          	  dma1_ch_int_abt_mask,
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
                          `endif
                          	  dma0_idle_state,
                          	  dma0_ch_ctl_wen,
                          	  dma0_ch_en_wen,
                          	  dma0_ch_src_addr_wen,
                          	  dma0_ch_dst_addr_wen,
                          `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_llp_wen,
                          `endif
                          	  dma0_ch_tts_wen,
                          	  dma0_ch_tc_wen,
                          	  dma0_ch_err_wen,
                          	  dma0_ch_int_wen,
                          	  dma0_ch_src_ack,
                          	  dma0_ch_dst_ack,
                          	  dma0_arb_end,
                          	  dma0_current_channel,
                          	  dma0_ch_src_addr_ctl,
                          	  dma0_ch_dst_addr_ctl,
                          	  dma0_ch_src_width,
                          	  dma0_ch_dst_width,
                          	  dma0_ch_src_burst_size,
                          	  dma0_ch_src_mode,
                          	  dma0_ch_src_request,
                          	  dma0_ch_dst_mode,
                          	  dma0_ch_dst_request,
                          	  dma0_ch_tts,
                          	  dma0_ch_src_addr,
                          	  dma0_ch_dst_addr,
                          `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  dma0_ch_src_bus_inf_idx,
                          	  dma0_ch_dst_bus_inf_idx,
                          `endif
                          `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                          	  dma0_ch_llp,
                             `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                          	  dma0_ch_lld_bus_inf_idx,
                             `endif
                          `endif
                          	  dma0_ch_abt,
                          	  dma0_ch_int_tc_mask,
                          	  dma0_ch_int_err_mask,
                          	  dma0_ch_int_abt_mask
);
localparam	ADDR_MSB	= `ATCDMAC300_ADDR_WIDTH - 1;
localparam	ADDR_WEN_MSB	= ADDR_MSB > 31 ? 1 : 0;

input					aclk;
input					aresetn;

input	[(`ATCDMAC300_REQ_ACK_NUM-1):0]	dma_req;
output	[(`ATCDMAC300_REQ_ACK_NUM-1):0]	dma_ack;
reg	[(`ATCDMAC300_REQ_ACK_NUM-1):0]	dma_ack;

`ifdef ATCDMAC300_REQ_SYNC_SUPPORT
reg	[(`ATCDMAC300_REQ_ACK_NUM-1):0]	s0;
reg	[(`ATCDMAC300_REQ_ACK_NUM-1):0]	s1;
`endif

wire	[16:0]				s2;
wire	[15:0]				s3;

input					dma_soft_reset;
input					ch_0_en;
input					ch_0_int_tc_mask;
input					ch_0_int_err_mask;
input					ch_0_int_abt_mask;
input	[3:0]				ch_0_src_req_sel;
input	[3:0]				ch_0_dst_req_sel;
input	[1:0]				ch_0_src_addr_ctl;
input	[1:0]				ch_0_dst_addr_ctl;
input					ch_0_src_mode;
input					ch_0_dst_mode;
input 	[2:0]				ch_0_src_width;
input 	[2:0]				ch_0_dst_width;
input	[3:0]				ch_0_src_burst_size;
input					ch_0_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_0_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_0_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_0_src_bus_inf_idx;
input					ch_0_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_0_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_0_lld_bus_inf_idx;
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_0_tts;
input					ch_0_abt;
input					ch_1_en;
input					ch_1_int_tc_mask;
input					ch_1_int_err_mask;
input					ch_1_int_abt_mask;
input	[3:0]				ch_1_src_req_sel;
input	[3:0]				ch_1_dst_req_sel;
input	[1:0]				ch_1_src_addr_ctl;
input	[1:0]				ch_1_dst_addr_ctl;
input					ch_1_src_mode;
input					ch_1_dst_mode;
input 	[2:0]				ch_1_src_width;
input 	[2:0]				ch_1_dst_width;
input	[3:0]				ch_1_src_burst_size;
input					ch_1_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_1_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_1_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_1_src_bus_inf_idx;
input					ch_1_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_1_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_1_lld_bus_inf_idx;
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_1_tts;
input					ch_1_abt;
input					ch_2_en;
input					ch_2_int_tc_mask;
input					ch_2_int_err_mask;
input					ch_2_int_abt_mask;
input	[3:0]				ch_2_src_req_sel;
input	[3:0]				ch_2_dst_req_sel;
input	[1:0]				ch_2_src_addr_ctl;
input	[1:0]				ch_2_dst_addr_ctl;
input					ch_2_src_mode;
input					ch_2_dst_mode;
input 	[2:0]				ch_2_src_width;
input 	[2:0]				ch_2_dst_width;
input	[3:0]				ch_2_src_burst_size;
input					ch_2_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_2_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_2_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_2_src_bus_inf_idx;
input					ch_2_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_2_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_2_lld_bus_inf_idx;
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_2_tts;
input					ch_2_abt;
input					ch_3_en;
input					ch_3_int_tc_mask;
input					ch_3_int_err_mask;
input					ch_3_int_abt_mask;
input	[3:0]				ch_3_src_req_sel;
input	[3:0]				ch_3_dst_req_sel;
input	[1:0]				ch_3_src_addr_ctl;
input	[1:0]				ch_3_dst_addr_ctl;
input					ch_3_src_mode;
input					ch_3_dst_mode;
input 	[2:0]				ch_3_src_width;
input 	[2:0]				ch_3_dst_width;
input	[3:0]				ch_3_src_burst_size;
input					ch_3_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_3_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_3_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_3_src_bus_inf_idx;
input					ch_3_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_3_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_3_lld_bus_inf_idx;
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_3_tts;
input					ch_3_abt;
input					ch_4_en;
input					ch_4_int_tc_mask;
input					ch_4_int_err_mask;
input					ch_4_int_abt_mask;
input	[3:0]				ch_4_src_req_sel;
input	[3:0]				ch_4_dst_req_sel;
input	[1:0]				ch_4_src_addr_ctl;
input	[1:0]				ch_4_dst_addr_ctl;
input					ch_4_src_mode;
input					ch_4_dst_mode;
input 	[2:0]				ch_4_src_width;
input 	[2:0]				ch_4_dst_width;
input	[3:0]				ch_4_src_burst_size;
input					ch_4_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_4_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_4_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_4_src_bus_inf_idx;
input					ch_4_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_4_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_4_lld_bus_inf_idx;
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_4_tts;
input					ch_4_abt;
input					ch_5_en;
input					ch_5_int_tc_mask;
input					ch_5_int_err_mask;
input					ch_5_int_abt_mask;
input	[3:0]				ch_5_src_req_sel;
input	[3:0]				ch_5_dst_req_sel;
input	[1:0]				ch_5_src_addr_ctl;
input	[1:0]				ch_5_dst_addr_ctl;
input					ch_5_src_mode;
input					ch_5_dst_mode;
input 	[2:0]				ch_5_src_width;
input 	[2:0]				ch_5_dst_width;
input	[3:0]				ch_5_src_burst_size;
input					ch_5_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_5_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_5_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_5_src_bus_inf_idx;
input					ch_5_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_5_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_5_lld_bus_inf_idx;
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_5_tts;
input					ch_5_abt;
input					ch_6_en;
input					ch_6_int_tc_mask;
input					ch_6_int_err_mask;
input					ch_6_int_abt_mask;
input	[3:0]				ch_6_src_req_sel;
input	[3:0]				ch_6_dst_req_sel;
input	[1:0]				ch_6_src_addr_ctl;
input	[1:0]				ch_6_dst_addr_ctl;
input					ch_6_src_mode;
input					ch_6_dst_mode;
input 	[2:0]				ch_6_src_width;
input 	[2:0]				ch_6_dst_width;
input	[3:0]				ch_6_src_burst_size;
input					ch_6_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_6_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_6_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_6_src_bus_inf_idx;
input					ch_6_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_6_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_6_lld_bus_inf_idx;
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_6_tts;
input					ch_6_abt;
input					ch_7_en;
input					ch_7_int_tc_mask;
input					ch_7_int_err_mask;
input					ch_7_int_abt_mask;
input	[3:0]				ch_7_src_req_sel;
input	[3:0]				ch_7_dst_req_sel;
input	[1:0]				ch_7_src_addr_ctl;
input	[1:0]				ch_7_dst_addr_ctl;
input					ch_7_src_mode;
input					ch_7_dst_mode;
input 	[2:0]				ch_7_src_width;
input 	[2:0]				ch_7_dst_width;
input	[3:0]				ch_7_src_burst_size;
input					ch_7_priority;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_7_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_7_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_7_src_bus_inf_idx;
input					ch_7_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_7_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_7_lld_bus_inf_idx;
	`endif
`endif
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_7_tts;
input					ch_7_abt;

wire					s4;
wire					s5;
wire					s6;
wire					s7;
wire					s8;
wire					s9;
wire					s10;
wire					s11;

`ifdef DMAC_CONFIG_CH0
output					dma0_ch_0_ctl_wen;
output					dma0_ch_0_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_0_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_0_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_0_llp_wen;
	`endif
output					dma0_ch_0_tts_wen;
output					dma0_ch_0_tc_wen;
output					dma0_ch_0_err_wen;
output					dma0_ch_0_int_wen;
`endif
`ifdef DMAC_CONFIG_CH1
output					dma0_ch_1_ctl_wen;
output					dma0_ch_1_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_1_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_1_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_1_llp_wen;
	`endif
output					dma0_ch_1_tts_wen;
output					dma0_ch_1_tc_wen;
output					dma0_ch_1_err_wen;
output					dma0_ch_1_int_wen;
`endif
`ifdef DMAC_CONFIG_CH2
output					dma0_ch_2_ctl_wen;
output					dma0_ch_2_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_2_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_2_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_2_llp_wen;
	`endif
output					dma0_ch_2_tts_wen;
output					dma0_ch_2_tc_wen;
output					dma0_ch_2_err_wen;
output					dma0_ch_2_int_wen;
`endif
`ifdef DMAC_CONFIG_CH3
output					dma0_ch_3_ctl_wen;
output					dma0_ch_3_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_3_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_3_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_3_llp_wen;
	`endif
output					dma0_ch_3_tts_wen;
output					dma0_ch_3_tc_wen;
output					dma0_ch_3_err_wen;
output					dma0_ch_3_int_wen;
`endif
`ifdef DMAC_CONFIG_CH4
output					dma0_ch_4_ctl_wen;
output					dma0_ch_4_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_4_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_4_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_4_llp_wen;
	`endif
output					dma0_ch_4_tts_wen;
output					dma0_ch_4_tc_wen;
output					dma0_ch_4_err_wen;
output					dma0_ch_4_int_wen;
`endif
`ifdef DMAC_CONFIG_CH5
output					dma0_ch_5_ctl_wen;
output					dma0_ch_5_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_5_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_5_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_5_llp_wen;
	`endif
output					dma0_ch_5_tts_wen;
output					dma0_ch_5_tc_wen;
output					dma0_ch_5_err_wen;
output					dma0_ch_5_int_wen;
`endif
`ifdef DMAC_CONFIG_CH6
output					dma0_ch_6_ctl_wen;
output					dma0_ch_6_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_6_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_6_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_6_llp_wen;
	`endif
output					dma0_ch_6_tts_wen;
output					dma0_ch_6_tc_wen;
output					dma0_ch_6_err_wen;
output					dma0_ch_6_int_wen;
`endif
`ifdef DMAC_CONFIG_CH7
output					dma0_ch_7_ctl_wen;
output					dma0_ch_7_en_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_7_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma0_ch_7_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma0_ch_7_llp_wen;
	`endif
output					dma0_ch_7_tts_wen;
output					dma0_ch_7_tc_wen;
output					dma0_ch_7_err_wen;
output					dma0_ch_7_int_wen;
`endif

input	[2:0]	granted_channel;
output	[7:0]	ch_request;
output	[7:0]	ch_level;
output	[2:0]	current_channel;


`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
input					dma1_idle_state;
input					dma1_ch_ctl_wen;
input					dma1_ch_en_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma1_ch_dst_addr_wen;
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma1_ch_llp_wen;
	`endif
input					dma1_ch_tts_wen;
input					dma1_ch_tc_wen;
input					dma1_ch_err_wen;
input					dma1_ch_int_wen;
input					dma1_ch_src_ack;
input					dma1_ch_dst_ack;

output					dma1_arb_end;
output	[2:0]				dma1_current_channel;
output	[1:0]				dma1_ch_src_addr_ctl;
output	[1:0]				dma1_ch_dst_addr_ctl;
output	[2:0]				dma1_ch_src_width;
output	[2:0]				dma1_ch_dst_width;
output	[3:0]				dma1_ch_src_burst_size;
output					dma1_ch_src_mode;
output					dma1_ch_src_request;
output					dma1_ch_dst_mode;
output					dma1_ch_dst_request;
output	[(`ATCDMAC300_TTS_WIDTH-1):0]	dma1_ch_tts;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma1_ch_src_addr;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma1_ch_dst_addr;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					dma1_ch_src_bus_inf_idx;
output					dma1_ch_dst_bus_inf_idx;
	`endif
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[(`ATCDMAC300_ADDR_WIDTH-1):3]	dma1_ch_llp;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					dma1_ch_lld_bus_inf_idx;
		`endif
	`endif
output					dma1_ch_abt;
output					dma1_ch_int_tc_mask;
output					dma1_ch_int_err_mask;
output					dma1_ch_int_abt_mask;
wire					s12;
reg					dma1_arb_end;
reg	[1:0]				dma1_ch_src_addr_ctl;
reg	[1:0]				dma1_ch_dst_addr_ctl;
reg	[2:0]				dma1_ch_src_width;
reg	[2:0]				dma1_ch_dst_width;
reg	[3:0]				dma1_ch_src_burst_size;
reg					dma1_ch_src_mode;
reg					dma1_ch_src_request;
reg					dma1_ch_dst_mode;
reg					dma1_ch_dst_request;
reg	[(`ATCDMAC300_TTS_WIDTH-1):0]	dma1_ch_tts;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma1_ch_src_addr;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma1_ch_dst_addr;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					dma1_ch_src_bus_inf_idx;
reg					dma1_ch_dst_bus_inf_idx;
	`endif
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
reg	[(`ATCDMAC300_ADDR_WIDTH-1):3]	dma1_ch_llp;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					dma1_ch_lld_bus_inf_idx;
		`endif
	`endif
reg					dma1_ch_int_tc_mask;
reg					dma1_ch_int_err_mask;
reg					dma1_ch_int_abt_mask;
reg					dma1_ch_abt;
reg	[2:0]				dma1_current_channel;
wire	[2:0]				s13;
wire					s14;
wire					s15;
wire					s16;
wire					s17;
wire					s18;
wire					s19;
wire					s20;
wire					s21;
	`ifdef DMAC_CONFIG_CH0
output					dma1_ch_0_ctl_wen;
output					dma1_ch_0_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_0_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_0_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_0_llp_wen;
		`endif
output					dma1_ch_0_tts_wen;
output					dma1_ch_0_tc_wen;
output					dma1_ch_0_err_wen;
output					dma1_ch_0_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH1
output					dma1_ch_1_ctl_wen;
output					dma1_ch_1_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_1_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_1_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_1_llp_wen;
		`endif
output					dma1_ch_1_tts_wen;
output					dma1_ch_1_tc_wen;
output					dma1_ch_1_err_wen;
output					dma1_ch_1_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH2
output					dma1_ch_2_ctl_wen;
output					dma1_ch_2_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_2_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_2_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_2_llp_wen;
		`endif
output					dma1_ch_2_tts_wen;
output					dma1_ch_2_tc_wen;
output					dma1_ch_2_err_wen;
output					dma1_ch_2_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH3
output					dma1_ch_3_ctl_wen;
output					dma1_ch_3_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_3_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_3_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_3_llp_wen;
		`endif
output					dma1_ch_3_tts_wen;
output					dma1_ch_3_tc_wen;
output					dma1_ch_3_err_wen;
output					dma1_ch_3_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH4
output					dma1_ch_4_ctl_wen;
output					dma1_ch_4_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_4_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_4_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_4_llp_wen;
		`endif
output					dma1_ch_4_tts_wen;
output					dma1_ch_4_tc_wen;
output					dma1_ch_4_err_wen;
output					dma1_ch_4_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH5
output					dma1_ch_5_ctl_wen;
output					dma1_ch_5_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_5_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_5_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_5_llp_wen;
		`endif
output					dma1_ch_5_tts_wen;
output					dma1_ch_5_tc_wen;
output					dma1_ch_5_err_wen;
output					dma1_ch_5_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH6
output					dma1_ch_6_ctl_wen;
output					dma1_ch_6_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_6_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_6_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_6_llp_wen;
		`endif
output					dma1_ch_6_tts_wen;
output					dma1_ch_6_tc_wen;
output					dma1_ch_6_err_wen;
output					dma1_ch_6_int_wen;
	`endif
	`ifdef DMAC_CONFIG_CH7
output					dma1_ch_7_ctl_wen;
output					dma1_ch_7_en_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_7_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma1_ch_7_dst_addr_wen;
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma1_ch_7_llp_wen;
		`endif
output					dma1_ch_7_tts_wen;
output					dma1_ch_7_tc_wen;
output					dma1_ch_7_err_wen;
output					dma1_ch_7_int_wen;
	`endif
`endif

input					dma0_idle_state;
input					dma0_ch_ctl_wen;
input					dma0_ch_en_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_src_addr_wen;
input	[ADDR_WEN_MSB:0]		dma0_ch_dst_addr_wen;
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[ADDR_WEN_MSB:0]		dma0_ch_llp_wen;
`endif
input					dma0_ch_tts_wen;
input					dma0_ch_tc_wen;
input					dma0_ch_err_wen;
input					dma0_ch_int_wen;
input					dma0_ch_src_ack;
input					dma0_ch_dst_ack;

output					dma0_arb_end;
output	[2:0]				dma0_current_channel;
output	[1:0]				dma0_ch_src_addr_ctl;
output	[1:0]				dma0_ch_dst_addr_ctl;
output	[2:0]				dma0_ch_src_width;
output	[2:0]				dma0_ch_dst_width;
output	[3:0]				dma0_ch_src_burst_size;
output					dma0_ch_src_mode;
output					dma0_ch_src_request;
output					dma0_ch_dst_mode;
output					dma0_ch_dst_request;
output	[(`ATCDMAC300_TTS_WIDTH-1):0]	dma0_ch_tts;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma0_ch_src_addr;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma0_ch_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					dma0_ch_src_bus_inf_idx;
output					dma0_ch_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[(`ATCDMAC300_ADDR_WIDTH-1):3]	dma0_ch_llp;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					dma0_ch_lld_bus_inf_idx;
	`endif
`endif
output					dma0_ch_abt;
output					dma0_ch_int_tc_mask;
output					dma0_ch_int_err_mask;
output					dma0_ch_int_abt_mask;
wire					s22;
reg					dma0_arb_end;
reg	[1:0]				dma0_ch_src_addr_ctl;
reg	[1:0]				dma0_ch_dst_addr_ctl;
reg	[2:0]				dma0_ch_src_width;
reg	[2:0]				dma0_ch_dst_width;
reg	[3:0]				dma0_ch_src_burst_size;
reg					dma0_ch_src_mode;
reg					dma0_ch_src_request;
reg					dma0_ch_dst_mode;
reg					dma0_ch_dst_request;
reg	[(`ATCDMAC300_TTS_WIDTH-1):0]	dma0_ch_tts;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma0_ch_src_addr;
reg	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma0_ch_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					dma0_ch_src_bus_inf_idx;
reg					dma0_ch_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
reg	[(`ATCDMAC300_ADDR_WIDTH-1):3]	dma0_ch_llp;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg					dma0_ch_lld_bus_inf_idx;
	`endif
`endif
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
wire	[7:0]				s23;
wire	[7:0]				s24;
wire	[7:0]				s25;
wire	[7:0]				s26;
wire					s27;
reg					s28;
`else
wire					s28 = 1'b0;
wire	[7:0]				s23 = ch_request;
`endif

reg					dma0_ch_int_tc_mask;
reg					dma0_ch_int_err_mask;
reg					dma0_ch_int_abt_mask;
reg					dma0_ch_abt;
reg	[2:0]				dma0_current_channel;
wire	[2:0]				s29;

`ifdef DMAC_CONFIG_CH0
assign s4	= (dma0_current_channel == 3'h0);
assign dma0_ch_0_ctl_wen	= dma0_ch_ctl_wen	&& s4;
assign dma0_ch_0_en_wen		= dma0_ch_en_wen	&& s4;
assign dma0_ch_0_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s4}};
assign dma0_ch_0_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s4}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_0_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{s4}};
`endif
assign dma0_ch_0_tts_wen	= dma0_ch_tts_wen	&& s4;
assign dma0_ch_0_tc_wen		= dma0_ch_tc_wen	&& s4;
assign dma0_ch_0_err_wen	= dma0_ch_err_wen	&& s4;
assign dma0_ch_0_int_wen	= dma0_ch_int_wen	&& s4;
`else
assign s4	= 1'b0;
`endif
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH0
assign s14	= (dma1_current_channel == 3'h0);
assign dma1_ch_0_ctl_wen	= dma1_ch_ctl_wen	&& s14;
assign dma1_ch_0_en_wen		= dma1_ch_en_wen	&& s14;
assign dma1_ch_0_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s14}};
assign dma1_ch_0_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s14}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_0_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{s14}};
		`endif
assign dma1_ch_0_tts_wen	= dma1_ch_tts_wen 	&& s14;
assign dma1_ch_0_tc_wen		= dma1_ch_tc_wen	&& s14;
assign dma1_ch_0_err_wen	= dma1_ch_err_wen	&& s14;
assign dma1_ch_0_int_wen	= dma1_ch_int_wen	&& s14;
	`else
assign s14	= 1'b0;
	`endif
`endif
`ifdef DMAC_CONFIG_CH1
assign s5	= (dma0_current_channel == 3'h1);
assign dma0_ch_1_ctl_wen	= dma0_ch_ctl_wen	&& s5;
assign dma0_ch_1_en_wen		= dma0_ch_en_wen	&& s5;
assign dma0_ch_1_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s5}};
assign dma0_ch_1_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s5}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_1_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{s5}};
`endif
assign dma0_ch_1_tts_wen	= dma0_ch_tts_wen	&& s5;
assign dma0_ch_1_tc_wen		= dma0_ch_tc_wen	&& s5;
assign dma0_ch_1_err_wen	= dma0_ch_err_wen	&& s5;
assign dma0_ch_1_int_wen	= dma0_ch_int_wen	&& s5;
`else
assign s5	= 1'b0;
`endif
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH1
assign s15	= (dma1_current_channel == 3'h1);
assign dma1_ch_1_ctl_wen	= dma1_ch_ctl_wen	&& s15;
assign dma1_ch_1_en_wen		= dma1_ch_en_wen	&& s15;
assign dma1_ch_1_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s15}};
assign dma1_ch_1_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s15}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_1_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{s15}};
		`endif
assign dma1_ch_1_tts_wen	= dma1_ch_tts_wen 	&& s15;
assign dma1_ch_1_tc_wen		= dma1_ch_tc_wen	&& s15;
assign dma1_ch_1_err_wen	= dma1_ch_err_wen	&& s15;
assign dma1_ch_1_int_wen	= dma1_ch_int_wen	&& s15;
	`else
assign s15	= 1'b0;
	`endif
`endif
`ifdef DMAC_CONFIG_CH2
assign s6	= (dma0_current_channel == 3'h2);
assign dma0_ch_2_ctl_wen	= dma0_ch_ctl_wen	&& s6;
assign dma0_ch_2_en_wen		= dma0_ch_en_wen	&& s6;
assign dma0_ch_2_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s6}};
assign dma0_ch_2_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s6}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_2_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{s6}};
`endif
assign dma0_ch_2_tts_wen	= dma0_ch_tts_wen	&& s6;
assign dma0_ch_2_tc_wen		= dma0_ch_tc_wen	&& s6;
assign dma0_ch_2_err_wen	= dma0_ch_err_wen	&& s6;
assign dma0_ch_2_int_wen	= dma0_ch_int_wen	&& s6;
`else
assign s6	= 1'b0;
`endif
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH2
assign s16	= (dma1_current_channel == 3'h2);
assign dma1_ch_2_ctl_wen	= dma1_ch_ctl_wen	&& s16;
assign dma1_ch_2_en_wen		= dma1_ch_en_wen	&& s16;
assign dma1_ch_2_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s16}};
assign dma1_ch_2_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s16}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_2_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{s16}};
		`endif
assign dma1_ch_2_tts_wen	= dma1_ch_tts_wen 	&& s16;
assign dma1_ch_2_tc_wen		= dma1_ch_tc_wen	&& s16;
assign dma1_ch_2_err_wen	= dma1_ch_err_wen	&& s16;
assign dma1_ch_2_int_wen	= dma1_ch_int_wen	&& s16;
	`else
assign s16	= 1'b0;
	`endif
`endif
`ifdef DMAC_CONFIG_CH3
assign s7	= (dma0_current_channel == 3'h3);
assign dma0_ch_3_ctl_wen	= dma0_ch_ctl_wen	&& s7;
assign dma0_ch_3_en_wen		= dma0_ch_en_wen	&& s7;
assign dma0_ch_3_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s7}};
assign dma0_ch_3_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s7}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_3_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{s7}};
`endif
assign dma0_ch_3_tts_wen	= dma0_ch_tts_wen	&& s7;
assign dma0_ch_3_tc_wen		= dma0_ch_tc_wen	&& s7;
assign dma0_ch_3_err_wen	= dma0_ch_err_wen	&& s7;
assign dma0_ch_3_int_wen	= dma0_ch_int_wen	&& s7;
`else
assign s7	= 1'b0;
`endif
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH3
assign s17	= (dma1_current_channel == 3'h3);
assign dma1_ch_3_ctl_wen	= dma1_ch_ctl_wen	&& s17;
assign dma1_ch_3_en_wen		= dma1_ch_en_wen	&& s17;
assign dma1_ch_3_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s17}};
assign dma1_ch_3_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s17}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_3_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{s17}};
		`endif
assign dma1_ch_3_tts_wen	= dma1_ch_tts_wen 	&& s17;
assign dma1_ch_3_tc_wen		= dma1_ch_tc_wen	&& s17;
assign dma1_ch_3_err_wen	= dma1_ch_err_wen	&& s17;
assign dma1_ch_3_int_wen	= dma1_ch_int_wen	&& s17;
	`else
assign s17	= 1'b0;
	`endif
`endif
`ifdef DMAC_CONFIG_CH4
assign s8	= (dma0_current_channel == 3'h4);
assign dma0_ch_4_ctl_wen	= dma0_ch_ctl_wen	&& s8;
assign dma0_ch_4_en_wen		= dma0_ch_en_wen	&& s8;
assign dma0_ch_4_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s8}};
assign dma0_ch_4_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s8}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_4_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{s8}};
`endif
assign dma0_ch_4_tts_wen	= dma0_ch_tts_wen	&& s8;
assign dma0_ch_4_tc_wen		= dma0_ch_tc_wen	&& s8;
assign dma0_ch_4_err_wen	= dma0_ch_err_wen	&& s8;
assign dma0_ch_4_int_wen	= dma0_ch_int_wen	&& s8;
`else
assign s8	= 1'b0;
`endif
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH4
assign s18	= (dma1_current_channel == 3'h4);
assign dma1_ch_4_ctl_wen	= dma1_ch_ctl_wen	&& s18;
assign dma1_ch_4_en_wen		= dma1_ch_en_wen	&& s18;
assign dma1_ch_4_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s18}};
assign dma1_ch_4_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s18}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_4_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{s18}};
		`endif
assign dma1_ch_4_tts_wen	= dma1_ch_tts_wen 	&& s18;
assign dma1_ch_4_tc_wen		= dma1_ch_tc_wen	&& s18;
assign dma1_ch_4_err_wen	= dma1_ch_err_wen	&& s18;
assign dma1_ch_4_int_wen	= dma1_ch_int_wen	&& s18;
	`else
assign s18	= 1'b0;
	`endif
`endif
`ifdef DMAC_CONFIG_CH5
assign s9	= (dma0_current_channel == 3'h5);
assign dma0_ch_5_ctl_wen	= dma0_ch_ctl_wen	&& s9;
assign dma0_ch_5_en_wen		= dma0_ch_en_wen	&& s9;
assign dma0_ch_5_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s9}};
assign dma0_ch_5_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s9}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_5_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{s9}};
`endif
assign dma0_ch_5_tts_wen	= dma0_ch_tts_wen	&& s9;
assign dma0_ch_5_tc_wen		= dma0_ch_tc_wen	&& s9;
assign dma0_ch_5_err_wen	= dma0_ch_err_wen	&& s9;
assign dma0_ch_5_int_wen	= dma0_ch_int_wen	&& s9;
`else
assign s9	= 1'b0;
`endif
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH5
assign s19	= (dma1_current_channel == 3'h5);
assign dma1_ch_5_ctl_wen	= dma1_ch_ctl_wen	&& s19;
assign dma1_ch_5_en_wen		= dma1_ch_en_wen	&& s19;
assign dma1_ch_5_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s19}};
assign dma1_ch_5_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s19}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_5_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{s19}};
		`endif
assign dma1_ch_5_tts_wen	= dma1_ch_tts_wen 	&& s19;
assign dma1_ch_5_tc_wen		= dma1_ch_tc_wen	&& s19;
assign dma1_ch_5_err_wen	= dma1_ch_err_wen	&& s19;
assign dma1_ch_5_int_wen	= dma1_ch_int_wen	&& s19;
	`else
assign s19	= 1'b0;
	`endif
`endif
`ifdef DMAC_CONFIG_CH6
assign s10	= (dma0_current_channel == 3'h6);
assign dma0_ch_6_ctl_wen	= dma0_ch_ctl_wen	&& s10;
assign dma0_ch_6_en_wen		= dma0_ch_en_wen	&& s10;
assign dma0_ch_6_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s10}};
assign dma0_ch_6_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s10}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_6_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{s10}};
`endif
assign dma0_ch_6_tts_wen	= dma0_ch_tts_wen	&& s10;
assign dma0_ch_6_tc_wen		= dma0_ch_tc_wen	&& s10;
assign dma0_ch_6_err_wen	= dma0_ch_err_wen	&& s10;
assign dma0_ch_6_int_wen	= dma0_ch_int_wen	&& s10;
`else
assign s10	= 1'b0;
`endif
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH6
assign s20	= (dma1_current_channel == 3'h6);
assign dma1_ch_6_ctl_wen	= dma1_ch_ctl_wen	&& s20;
assign dma1_ch_6_en_wen		= dma1_ch_en_wen	&& s20;
assign dma1_ch_6_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s20}};
assign dma1_ch_6_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s20}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_6_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{s20}};
		`endif
assign dma1_ch_6_tts_wen	= dma1_ch_tts_wen 	&& s20;
assign dma1_ch_6_tc_wen		= dma1_ch_tc_wen	&& s20;
assign dma1_ch_6_err_wen	= dma1_ch_err_wen	&& s20;
assign dma1_ch_6_int_wen	= dma1_ch_int_wen	&& s20;
	`else
assign s20	= 1'b0;
	`endif
`endif
`ifdef DMAC_CONFIG_CH7
assign s11	= (dma0_current_channel == 3'h7);
assign dma0_ch_7_ctl_wen	= dma0_ch_ctl_wen	&& s11;
assign dma0_ch_7_en_wen		= dma0_ch_en_wen	&& s11;
assign dma0_ch_7_src_addr_wen	= dma0_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s11}};
assign dma0_ch_7_dst_addr_wen	= dma0_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s11}};
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma0_ch_7_llp_wen	= dma0_ch_llp_wen	& {ADDR_WEN_MSB+1{s11}};
`endif
assign dma0_ch_7_tts_wen	= dma0_ch_tts_wen	&& s11;
assign dma0_ch_7_tc_wen		= dma0_ch_tc_wen	&& s11;
assign dma0_ch_7_err_wen	= dma0_ch_err_wen	&& s11;
assign dma0_ch_7_int_wen	= dma0_ch_int_wen	&& s11;
`else
assign s11	= 1'b0;
`endif
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	`ifdef DMAC_CONFIG_CH7
assign s21	= (dma1_current_channel == 3'h7);
assign dma1_ch_7_ctl_wen	= dma1_ch_ctl_wen	&& s21;
assign dma1_ch_7_en_wen		= dma1_ch_en_wen	&& s21;
assign dma1_ch_7_src_addr_wen	= dma1_ch_src_addr_wen	& {ADDR_WEN_MSB+1{s21}};
assign dma1_ch_7_dst_addr_wen	= dma1_ch_dst_addr_wen	& {ADDR_WEN_MSB+1{s21}};
		`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign dma1_ch_7_llp_wen	= dma1_ch_llp_wen	& {ADDR_WEN_MSB+1{s21}};
		`endif
assign dma1_ch_7_tts_wen	= dma1_ch_tts_wen 	&& s21;
assign dma1_ch_7_tc_wen		= dma1_ch_tc_wen	&& s21;
assign dma1_ch_7_err_wen	= dma1_ch_err_wen	&& s21;
assign dma1_ch_7_int_wen	= dma1_ch_int_wen	&& s21;
	`else
assign s21	= 1'b0;
	`endif
`endif


reg s30;
always @(*) begin
	case(ch_0_src_req_sel)
		4'h1:	s30 = s2[1];
		4'h2:	s30 = s2[2];
		4'h3:	s30 = s2[3];
		4'h4:	s30 = s2[4];
		4'h5:	s30 = s2[5];
		4'h6:	s30 = s2[6];
		4'h7:	s30 = s2[7];
		4'h8:	s30 = s2[8];
		4'h9:	s30 = s2[9];
		4'ha:	s30 = s2[10];
		4'hb:	s30 = s2[11];
		4'hc:	s30 = s2[12];
		4'hd:	s30 = s2[13];
		4'he:	s30 = s2[14];
		4'hf:	s30 = s2[15];
		default: s30 = s2[0];
	endcase
end

reg s31;
always @(*) begin
	case(ch_0_dst_req_sel)
		4'h1:	s31 = s2[1];
		4'h2:	s31 = s2[2];
		4'h3:	s31 = s2[3];
		4'h4:	s31 = s2[4];
		4'h5:	s31 = s2[5];
		4'h6:	s31 = s2[6];
		4'h7:	s31 = s2[7];
		4'h8:	s31 = s2[8];
		4'h9:	s31 = s2[9];
		4'ha:	s31 = s2[10];
		4'hb:	s31 = s2[11];
		4'hc:	s31 = s2[12];
		4'hd:	s31 = s2[13];
		4'he:	s31 = s2[14];
		4'hf:	s31 = s2[15];
		default: s31 = s2[0];
	endcase
end
wire	s32 = ch_0_en & (s30 | ~ch_0_src_mode) & (s31 | ~ch_0_dst_mode);
reg s33;
always @(*) begin
	case(ch_1_src_req_sel)
		4'h1:	s33 = s2[1];
		4'h2:	s33 = s2[2];
		4'h3:	s33 = s2[3];
		4'h4:	s33 = s2[4];
		4'h5:	s33 = s2[5];
		4'h6:	s33 = s2[6];
		4'h7:	s33 = s2[7];
		4'h8:	s33 = s2[8];
		4'h9:	s33 = s2[9];
		4'ha:	s33 = s2[10];
		4'hb:	s33 = s2[11];
		4'hc:	s33 = s2[12];
		4'hd:	s33 = s2[13];
		4'he:	s33 = s2[14];
		4'hf:	s33 = s2[15];
		default: s33 = s2[0];
	endcase
end

reg s34;
always @(*) begin
	case(ch_1_dst_req_sel)
		4'h1:	s34 = s2[1];
		4'h2:	s34 = s2[2];
		4'h3:	s34 = s2[3];
		4'h4:	s34 = s2[4];
		4'h5:	s34 = s2[5];
		4'h6:	s34 = s2[6];
		4'h7:	s34 = s2[7];
		4'h8:	s34 = s2[8];
		4'h9:	s34 = s2[9];
		4'ha:	s34 = s2[10];
		4'hb:	s34 = s2[11];
		4'hc:	s34 = s2[12];
		4'hd:	s34 = s2[13];
		4'he:	s34 = s2[14];
		4'hf:	s34 = s2[15];
		default: s34 = s2[0];
	endcase
end
wire	s35 = ch_1_en & (s33 | ~ch_1_src_mode) & (s34 | ~ch_1_dst_mode);
reg s36;
always @(*) begin
	case(ch_2_src_req_sel)
		4'h1:	s36 = s2[1];
		4'h2:	s36 = s2[2];
		4'h3:	s36 = s2[3];
		4'h4:	s36 = s2[4];
		4'h5:	s36 = s2[5];
		4'h6:	s36 = s2[6];
		4'h7:	s36 = s2[7];
		4'h8:	s36 = s2[8];
		4'h9:	s36 = s2[9];
		4'ha:	s36 = s2[10];
		4'hb:	s36 = s2[11];
		4'hc:	s36 = s2[12];
		4'hd:	s36 = s2[13];
		4'he:	s36 = s2[14];
		4'hf:	s36 = s2[15];
		default: s36 = s2[0];
	endcase
end

reg s37;
always @(*) begin
	case(ch_2_dst_req_sel)
		4'h1:	s37 = s2[1];
		4'h2:	s37 = s2[2];
		4'h3:	s37 = s2[3];
		4'h4:	s37 = s2[4];
		4'h5:	s37 = s2[5];
		4'h6:	s37 = s2[6];
		4'h7:	s37 = s2[7];
		4'h8:	s37 = s2[8];
		4'h9:	s37 = s2[9];
		4'ha:	s37 = s2[10];
		4'hb:	s37 = s2[11];
		4'hc:	s37 = s2[12];
		4'hd:	s37 = s2[13];
		4'he:	s37 = s2[14];
		4'hf:	s37 = s2[15];
		default: s37 = s2[0];
	endcase
end
wire	s38 = ch_2_en & (s36 | ~ch_2_src_mode) & (s37 | ~ch_2_dst_mode);
reg s39;
always @(*) begin
	case(ch_3_src_req_sel)
		4'h1:	s39 = s2[1];
		4'h2:	s39 = s2[2];
		4'h3:	s39 = s2[3];
		4'h4:	s39 = s2[4];
		4'h5:	s39 = s2[5];
		4'h6:	s39 = s2[6];
		4'h7:	s39 = s2[7];
		4'h8:	s39 = s2[8];
		4'h9:	s39 = s2[9];
		4'ha:	s39 = s2[10];
		4'hb:	s39 = s2[11];
		4'hc:	s39 = s2[12];
		4'hd:	s39 = s2[13];
		4'he:	s39 = s2[14];
		4'hf:	s39 = s2[15];
		default: s39 = s2[0];
	endcase
end

reg s40;
always @(*) begin
	case(ch_3_dst_req_sel)
		4'h1:	s40 = s2[1];
		4'h2:	s40 = s2[2];
		4'h3:	s40 = s2[3];
		4'h4:	s40 = s2[4];
		4'h5:	s40 = s2[5];
		4'h6:	s40 = s2[6];
		4'h7:	s40 = s2[7];
		4'h8:	s40 = s2[8];
		4'h9:	s40 = s2[9];
		4'ha:	s40 = s2[10];
		4'hb:	s40 = s2[11];
		4'hc:	s40 = s2[12];
		4'hd:	s40 = s2[13];
		4'he:	s40 = s2[14];
		4'hf:	s40 = s2[15];
		default: s40 = s2[0];
	endcase
end
wire	s41 = ch_3_en & (s39 | ~ch_3_src_mode) & (s40 | ~ch_3_dst_mode);
reg s42;
always @(*) begin
	case(ch_4_src_req_sel)
		4'h1:	s42 = s2[1];
		4'h2:	s42 = s2[2];
		4'h3:	s42 = s2[3];
		4'h4:	s42 = s2[4];
		4'h5:	s42 = s2[5];
		4'h6:	s42 = s2[6];
		4'h7:	s42 = s2[7];
		4'h8:	s42 = s2[8];
		4'h9:	s42 = s2[9];
		4'ha:	s42 = s2[10];
		4'hb:	s42 = s2[11];
		4'hc:	s42 = s2[12];
		4'hd:	s42 = s2[13];
		4'he:	s42 = s2[14];
		4'hf:	s42 = s2[15];
		default: s42 = s2[0];
	endcase
end

reg s43;
always @(*) begin
	case(ch_4_dst_req_sel)
		4'h1:	s43 = s2[1];
		4'h2:	s43 = s2[2];
		4'h3:	s43 = s2[3];
		4'h4:	s43 = s2[4];
		4'h5:	s43 = s2[5];
		4'h6:	s43 = s2[6];
		4'h7:	s43 = s2[7];
		4'h8:	s43 = s2[8];
		4'h9:	s43 = s2[9];
		4'ha:	s43 = s2[10];
		4'hb:	s43 = s2[11];
		4'hc:	s43 = s2[12];
		4'hd:	s43 = s2[13];
		4'he:	s43 = s2[14];
		4'hf:	s43 = s2[15];
		default: s43 = s2[0];
	endcase
end
wire	s44 = ch_4_en & (s42 | ~ch_4_src_mode) & (s43 | ~ch_4_dst_mode);
reg s45;
always @(*) begin
	case(ch_5_src_req_sel)
		4'h1:	s45 = s2[1];
		4'h2:	s45 = s2[2];
		4'h3:	s45 = s2[3];
		4'h4:	s45 = s2[4];
		4'h5:	s45 = s2[5];
		4'h6:	s45 = s2[6];
		4'h7:	s45 = s2[7];
		4'h8:	s45 = s2[8];
		4'h9:	s45 = s2[9];
		4'ha:	s45 = s2[10];
		4'hb:	s45 = s2[11];
		4'hc:	s45 = s2[12];
		4'hd:	s45 = s2[13];
		4'he:	s45 = s2[14];
		4'hf:	s45 = s2[15];
		default: s45 = s2[0];
	endcase
end

reg s46;
always @(*) begin
	case(ch_5_dst_req_sel)
		4'h1:	s46 = s2[1];
		4'h2:	s46 = s2[2];
		4'h3:	s46 = s2[3];
		4'h4:	s46 = s2[4];
		4'h5:	s46 = s2[5];
		4'h6:	s46 = s2[6];
		4'h7:	s46 = s2[7];
		4'h8:	s46 = s2[8];
		4'h9:	s46 = s2[9];
		4'ha:	s46 = s2[10];
		4'hb:	s46 = s2[11];
		4'hc:	s46 = s2[12];
		4'hd:	s46 = s2[13];
		4'he:	s46 = s2[14];
		4'hf:	s46 = s2[15];
		default: s46 = s2[0];
	endcase
end
wire	s47 = ch_5_en & (s45 | ~ch_5_src_mode) & (s46 | ~ch_5_dst_mode);
reg s48;
always @(*) begin
	case(ch_6_src_req_sel)
		4'h1:	s48 = s2[1];
		4'h2:	s48 = s2[2];
		4'h3:	s48 = s2[3];
		4'h4:	s48 = s2[4];
		4'h5:	s48 = s2[5];
		4'h6:	s48 = s2[6];
		4'h7:	s48 = s2[7];
		4'h8:	s48 = s2[8];
		4'h9:	s48 = s2[9];
		4'ha:	s48 = s2[10];
		4'hb:	s48 = s2[11];
		4'hc:	s48 = s2[12];
		4'hd:	s48 = s2[13];
		4'he:	s48 = s2[14];
		4'hf:	s48 = s2[15];
		default: s48 = s2[0];
	endcase
end

reg s49;
always @(*) begin
	case(ch_6_dst_req_sel)
		4'h1:	s49 = s2[1];
		4'h2:	s49 = s2[2];
		4'h3:	s49 = s2[3];
		4'h4:	s49 = s2[4];
		4'h5:	s49 = s2[5];
		4'h6:	s49 = s2[6];
		4'h7:	s49 = s2[7];
		4'h8:	s49 = s2[8];
		4'h9:	s49 = s2[9];
		4'ha:	s49 = s2[10];
		4'hb:	s49 = s2[11];
		4'hc:	s49 = s2[12];
		4'hd:	s49 = s2[13];
		4'he:	s49 = s2[14];
		4'hf:	s49 = s2[15];
		default: s49 = s2[0];
	endcase
end
wire	s50 = ch_6_en & (s48 | ~ch_6_src_mode) & (s49 | ~ch_6_dst_mode);
reg s51;
always @(*) begin
	case(ch_7_src_req_sel)
		4'h1:	s51 = s2[1];
		4'h2:	s51 = s2[2];
		4'h3:	s51 = s2[3];
		4'h4:	s51 = s2[4];
		4'h5:	s51 = s2[5];
		4'h6:	s51 = s2[6];
		4'h7:	s51 = s2[7];
		4'h8:	s51 = s2[8];
		4'h9:	s51 = s2[9];
		4'ha:	s51 = s2[10];
		4'hb:	s51 = s2[11];
		4'hc:	s51 = s2[12];
		4'hd:	s51 = s2[13];
		4'he:	s51 = s2[14];
		4'hf:	s51 = s2[15];
		default: s51 = s2[0];
	endcase
end

reg s52;
always @(*) begin
	case(ch_7_dst_req_sel)
		4'h1:	s52 = s2[1];
		4'h2:	s52 = s2[2];
		4'h3:	s52 = s2[3];
		4'h4:	s52 = s2[4];
		4'h5:	s52 = s2[5];
		4'h6:	s52 = s2[6];
		4'h7:	s52 = s2[7];
		4'h8:	s52 = s2[8];
		4'h9:	s52 = s2[9];
		4'ha:	s52 = s2[10];
		4'hb:	s52 = s2[11];
		4'hc:	s52 = s2[12];
		4'hd:	s52 = s2[13];
		4'he:	s52 = s2[14];
		4'hf:	s52 = s2[15];
		default: s52 = s2[0];
	endcase
end
wire	s53 = ch_7_en & (s51 | ~ch_7_src_mode) & (s52 | ~ch_7_dst_mode);

always @(*) begin
	case(dma0_current_channel)
		3'h1: begin
			dma0_ch_src_addr_ctl 	= ch_1_src_addr_ctl;
			dma0_ch_dst_addr_ctl	= ch_1_dst_addr_ctl;
			dma0_ch_src_width	= ch_1_src_width;
			dma0_ch_dst_width	= ch_1_dst_width;
			dma0_ch_src_burst_size	= ch_1_src_burst_size;
			dma0_ch_tts		= ch_1_tts;
			dma0_ch_src_addr	= ch_1_src_addr;
			dma0_ch_dst_addr	= ch_1_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_1_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_1_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_1_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_1_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_1_src_mode;
			dma0_ch_src_request	= s33;
			dma0_ch_dst_mode	= ch_1_dst_mode;
			dma0_ch_dst_request	= s34;
			dma0_ch_abt		= ch_1_abt;
			dma0_ch_int_tc_mask	= ch_1_int_tc_mask;
			dma0_ch_int_err_mask	= ch_1_int_err_mask;
			dma0_ch_int_abt_mask	= ch_1_int_abt_mask;
		end
		3'h2: begin
			dma0_ch_src_addr_ctl 	= ch_2_src_addr_ctl;
			dma0_ch_dst_addr_ctl	= ch_2_dst_addr_ctl;
			dma0_ch_src_width	= ch_2_src_width;
			dma0_ch_dst_width	= ch_2_dst_width;
			dma0_ch_src_burst_size	= ch_2_src_burst_size;
			dma0_ch_tts		= ch_2_tts;
			dma0_ch_src_addr	= ch_2_src_addr;
			dma0_ch_dst_addr	= ch_2_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_2_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_2_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_2_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_2_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_2_src_mode;
			dma0_ch_src_request	= s36;
			dma0_ch_dst_mode	= ch_2_dst_mode;
			dma0_ch_dst_request	= s37;
			dma0_ch_abt		= ch_2_abt;
			dma0_ch_int_tc_mask	= ch_2_int_tc_mask;
			dma0_ch_int_err_mask	= ch_2_int_err_mask;
			dma0_ch_int_abt_mask	= ch_2_int_abt_mask;
		end
		3'h3: begin
			dma0_ch_src_addr_ctl 	= ch_3_src_addr_ctl;
			dma0_ch_dst_addr_ctl	= ch_3_dst_addr_ctl;
			dma0_ch_src_width	= ch_3_src_width;
			dma0_ch_dst_width	= ch_3_dst_width;
			dma0_ch_src_burst_size	= ch_3_src_burst_size;
			dma0_ch_tts		= ch_3_tts;
			dma0_ch_src_addr	= ch_3_src_addr;
			dma0_ch_dst_addr	= ch_3_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_3_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_3_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_3_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_3_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_3_src_mode;
			dma0_ch_src_request	= s39;
			dma0_ch_dst_mode	= ch_3_dst_mode;
			dma0_ch_dst_request	= s40;
			dma0_ch_abt		= ch_3_abt;
			dma0_ch_int_tc_mask	= ch_3_int_tc_mask;
			dma0_ch_int_err_mask	= ch_3_int_err_mask;
			dma0_ch_int_abt_mask	= ch_3_int_abt_mask;
		end
		3'h4: begin
			dma0_ch_src_addr_ctl 	= ch_4_src_addr_ctl;
			dma0_ch_dst_addr_ctl	= ch_4_dst_addr_ctl;
			dma0_ch_src_width	= ch_4_src_width;
			dma0_ch_dst_width	= ch_4_dst_width;
			dma0_ch_src_burst_size	= ch_4_src_burst_size;
			dma0_ch_tts		= ch_4_tts;
			dma0_ch_src_addr	= ch_4_src_addr;
			dma0_ch_dst_addr	= ch_4_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_4_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_4_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_4_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_4_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_4_src_mode;
			dma0_ch_src_request	= s42;
			dma0_ch_dst_mode	= ch_4_dst_mode;
			dma0_ch_dst_request	= s43;
			dma0_ch_abt		= ch_4_abt;
			dma0_ch_int_tc_mask	= ch_4_int_tc_mask;
			dma0_ch_int_err_mask	= ch_4_int_err_mask;
			dma0_ch_int_abt_mask	= ch_4_int_abt_mask;
		end
		3'h5: begin
			dma0_ch_src_addr_ctl 	= ch_5_src_addr_ctl;
			dma0_ch_dst_addr_ctl	= ch_5_dst_addr_ctl;
			dma0_ch_src_width	= ch_5_src_width;
			dma0_ch_dst_width	= ch_5_dst_width;
			dma0_ch_src_burst_size	= ch_5_src_burst_size;
			dma0_ch_tts		= ch_5_tts;
			dma0_ch_src_addr	= ch_5_src_addr;
			dma0_ch_dst_addr	= ch_5_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_5_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_5_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_5_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_5_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_5_src_mode;
			dma0_ch_src_request	= s45;
			dma0_ch_dst_mode	= ch_5_dst_mode;
			dma0_ch_dst_request	= s46;
			dma0_ch_abt		= ch_5_abt;
			dma0_ch_int_tc_mask	= ch_5_int_tc_mask;
			dma0_ch_int_err_mask	= ch_5_int_err_mask;
			dma0_ch_int_abt_mask	= ch_5_int_abt_mask;
		end
		3'h6: begin
			dma0_ch_src_addr_ctl 	= ch_6_src_addr_ctl;
			dma0_ch_dst_addr_ctl	= ch_6_dst_addr_ctl;
			dma0_ch_src_width	= ch_6_src_width;
			dma0_ch_dst_width	= ch_6_dst_width;
			dma0_ch_src_burst_size	= ch_6_src_burst_size;
			dma0_ch_tts		= ch_6_tts;
			dma0_ch_src_addr	= ch_6_src_addr;
			dma0_ch_dst_addr	= ch_6_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_6_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_6_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_6_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_6_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_6_src_mode;
			dma0_ch_src_request	= s48;
			dma0_ch_dst_mode	= ch_6_dst_mode;
			dma0_ch_dst_request	= s49;
			dma0_ch_abt		= ch_6_abt;
			dma0_ch_int_tc_mask	= ch_6_int_tc_mask;
			dma0_ch_int_err_mask	= ch_6_int_err_mask;
			dma0_ch_int_abt_mask	= ch_6_int_abt_mask;
		end
		3'h7: begin
			dma0_ch_src_addr_ctl 	= ch_7_src_addr_ctl;
			dma0_ch_dst_addr_ctl	= ch_7_dst_addr_ctl;
			dma0_ch_src_width	= ch_7_src_width;
			dma0_ch_dst_width	= ch_7_dst_width;
			dma0_ch_src_burst_size	= ch_7_src_burst_size;
			dma0_ch_tts		= ch_7_tts;
			dma0_ch_src_addr	= ch_7_src_addr;
			dma0_ch_dst_addr	= ch_7_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_7_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_7_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_7_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_7_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_7_src_mode;
			dma0_ch_src_request	= s51;
			dma0_ch_dst_mode	= ch_7_dst_mode;
			dma0_ch_dst_request	= s52;
			dma0_ch_abt		= ch_7_abt;
			dma0_ch_int_tc_mask	= ch_7_int_tc_mask;
			dma0_ch_int_err_mask	= ch_7_int_err_mask;
			dma0_ch_int_abt_mask	= ch_7_int_abt_mask;
		end
		default: begin
			dma0_ch_src_addr_ctl 	= ch_0_src_addr_ctl;
			dma0_ch_dst_addr_ctl 	= ch_0_dst_addr_ctl;
			dma0_ch_src_width	= ch_0_src_width;
			dma0_ch_dst_width	= ch_0_dst_width;
			dma0_ch_src_burst_size	= ch_0_src_burst_size;
			dma0_ch_tts		= ch_0_tts;
			dma0_ch_src_addr	= ch_0_src_addr;
			dma0_ch_dst_addr	= ch_0_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_src_bus_inf_idx	= ch_0_src_bus_inf_idx;
			dma0_ch_dst_bus_inf_idx	= ch_0_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma0_ch_llp		= ch_0_llp_reg;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma0_ch_lld_bus_inf_idx	= ch_0_lld_bus_inf_idx;
	`endif
`endif
			dma0_ch_src_mode	= ch_0_src_mode;
			dma0_ch_src_request	= s30;
			dma0_ch_dst_mode	= ch_0_dst_mode;
			dma0_ch_dst_request	= s31;
			dma0_ch_abt		= ch_0_abt;
			dma0_ch_int_tc_mask	= ch_0_int_tc_mask;
			dma0_ch_int_err_mask	= ch_0_int_err_mask;
			dma0_ch_int_abt_mask	= ch_0_int_abt_mask;
		end
	endcase
end
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
always @(*) begin
	case(dma1_current_channel)
		3'h1: begin
			dma1_ch_src_addr_ctl 	= ch_1_src_addr_ctl;
			dma1_ch_dst_addr_ctl	= ch_1_dst_addr_ctl;
			dma1_ch_src_width	= ch_1_src_width;
			dma1_ch_dst_width	= ch_1_dst_width;
			dma1_ch_src_burst_size	= ch_1_src_burst_size;
			dma1_ch_tts		= ch_1_tts;
			dma1_ch_src_addr	= ch_1_src_addr;
			dma1_ch_dst_addr	= ch_1_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_1_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_1_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_1_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_1_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_1_src_mode;
			dma1_ch_src_request	= s33;
			dma1_ch_dst_mode	= ch_1_dst_mode;
			dma1_ch_dst_request	= s34;
			dma1_ch_abt		= ch_1_abt;
			dma1_ch_int_tc_mask	= ch_1_int_tc_mask;
			dma1_ch_int_err_mask	= ch_1_int_err_mask;
			dma1_ch_int_abt_mask	= ch_1_int_abt_mask;
		end
		3'h2: begin
			dma1_ch_src_addr_ctl 	= ch_2_src_addr_ctl;
			dma1_ch_dst_addr_ctl	= ch_2_dst_addr_ctl;
			dma1_ch_src_width	= ch_2_src_width;
			dma1_ch_dst_width	= ch_2_dst_width;
			dma1_ch_src_burst_size	= ch_2_src_burst_size;
			dma1_ch_tts		= ch_2_tts;
			dma1_ch_src_addr	= ch_2_src_addr;
			dma1_ch_dst_addr	= ch_2_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_2_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_2_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_2_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_2_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_2_src_mode;
			dma1_ch_src_request	= s36;
			dma1_ch_dst_mode	= ch_2_dst_mode;
			dma1_ch_dst_request	= s37;
			dma1_ch_abt		= ch_2_abt;
			dma1_ch_int_tc_mask	= ch_2_int_tc_mask;
			dma1_ch_int_err_mask	= ch_2_int_err_mask;
			dma1_ch_int_abt_mask	= ch_2_int_abt_mask;
		end
		3'h3: begin
			dma1_ch_src_addr_ctl 	= ch_3_src_addr_ctl;
			dma1_ch_dst_addr_ctl	= ch_3_dst_addr_ctl;
			dma1_ch_src_width	= ch_3_src_width;
			dma1_ch_dst_width	= ch_3_dst_width;
			dma1_ch_src_burst_size	= ch_3_src_burst_size;
			dma1_ch_tts		= ch_3_tts;
			dma1_ch_src_addr	= ch_3_src_addr;
			dma1_ch_dst_addr	= ch_3_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_3_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_3_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_3_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_3_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_3_src_mode;
			dma1_ch_src_request	= s39;
			dma1_ch_dst_mode	= ch_3_dst_mode;
			dma1_ch_dst_request	= s40;
			dma1_ch_abt		= ch_3_abt;
			dma1_ch_int_tc_mask	= ch_3_int_tc_mask;
			dma1_ch_int_err_mask	= ch_3_int_err_mask;
			dma1_ch_int_abt_mask	= ch_3_int_abt_mask;
		end
		3'h4: begin
			dma1_ch_src_addr_ctl 	= ch_4_src_addr_ctl;
			dma1_ch_dst_addr_ctl	= ch_4_dst_addr_ctl;
			dma1_ch_src_width	= ch_4_src_width;
			dma1_ch_dst_width	= ch_4_dst_width;
			dma1_ch_src_burst_size	= ch_4_src_burst_size;
			dma1_ch_tts		= ch_4_tts;
			dma1_ch_src_addr	= ch_4_src_addr;
			dma1_ch_dst_addr	= ch_4_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_4_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_4_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_4_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_4_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_4_src_mode;
			dma1_ch_src_request	= s42;
			dma1_ch_dst_mode	= ch_4_dst_mode;
			dma1_ch_dst_request	= s43;
			dma1_ch_abt		= ch_4_abt;
			dma1_ch_int_tc_mask	= ch_4_int_tc_mask;
			dma1_ch_int_err_mask	= ch_4_int_err_mask;
			dma1_ch_int_abt_mask	= ch_4_int_abt_mask;
		end
		3'h5: begin
			dma1_ch_src_addr_ctl 	= ch_5_src_addr_ctl;
			dma1_ch_dst_addr_ctl	= ch_5_dst_addr_ctl;
			dma1_ch_src_width	= ch_5_src_width;
			dma1_ch_dst_width	= ch_5_dst_width;
			dma1_ch_src_burst_size	= ch_5_src_burst_size;
			dma1_ch_tts		= ch_5_tts;
			dma1_ch_src_addr	= ch_5_src_addr;
			dma1_ch_dst_addr	= ch_5_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_5_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_5_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_5_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_5_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_5_src_mode;
			dma1_ch_src_request	= s45;
			dma1_ch_dst_mode	= ch_5_dst_mode;
			dma1_ch_dst_request	= s46;
			dma1_ch_abt		= ch_5_abt;
			dma1_ch_int_tc_mask	= ch_5_int_tc_mask;
			dma1_ch_int_err_mask	= ch_5_int_err_mask;
			dma1_ch_int_abt_mask	= ch_5_int_abt_mask;
		end
		3'h6: begin
			dma1_ch_src_addr_ctl 	= ch_6_src_addr_ctl;
			dma1_ch_dst_addr_ctl	= ch_6_dst_addr_ctl;
			dma1_ch_src_width	= ch_6_src_width;
			dma1_ch_dst_width	= ch_6_dst_width;
			dma1_ch_src_burst_size	= ch_6_src_burst_size;
			dma1_ch_tts		= ch_6_tts;
			dma1_ch_src_addr	= ch_6_src_addr;
			dma1_ch_dst_addr	= ch_6_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_6_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_6_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_6_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_6_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_6_src_mode;
			dma1_ch_src_request	= s48;
			dma1_ch_dst_mode	= ch_6_dst_mode;
			dma1_ch_dst_request	= s49;
			dma1_ch_abt		= ch_6_abt;
			dma1_ch_int_tc_mask	= ch_6_int_tc_mask;
			dma1_ch_int_err_mask	= ch_6_int_err_mask;
			dma1_ch_int_abt_mask	= ch_6_int_abt_mask;
		end
		3'h7: begin
			dma1_ch_src_addr_ctl 	= ch_7_src_addr_ctl;
			dma1_ch_dst_addr_ctl	= ch_7_dst_addr_ctl;
			dma1_ch_src_width	= ch_7_src_width;
			dma1_ch_dst_width	= ch_7_dst_width;
			dma1_ch_src_burst_size	= ch_7_src_burst_size;
			dma1_ch_tts		= ch_7_tts;
			dma1_ch_src_addr	= ch_7_src_addr;
			dma1_ch_dst_addr	= ch_7_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_7_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_7_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_7_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_7_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_7_src_mode;
			dma1_ch_src_request	= s51;
			dma1_ch_dst_mode	= ch_7_dst_mode;
			dma1_ch_dst_request	= s52;
			dma1_ch_abt		= ch_7_abt;
			dma1_ch_int_tc_mask	= ch_7_int_tc_mask;
			dma1_ch_int_err_mask	= ch_7_int_err_mask;
			dma1_ch_int_abt_mask	= ch_7_int_abt_mask;
		end
		default: begin
			dma1_ch_src_addr_ctl 	= ch_0_src_addr_ctl;
			dma1_ch_dst_addr_ctl 	= ch_0_dst_addr_ctl;
			dma1_ch_src_width	= ch_0_src_width;
			dma1_ch_dst_width	= ch_0_dst_width;
			dma1_ch_src_burst_size	= ch_0_src_burst_size;
			dma1_ch_tts		= ch_0_tts;
			dma1_ch_src_addr	= ch_0_src_addr;
			dma1_ch_dst_addr	= ch_0_dst_addr;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_src_bus_inf_idx	= ch_0_src_bus_inf_idx;
			dma1_ch_dst_bus_inf_idx	= ch_0_dst_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
			dma1_ch_llp		= ch_0_llp_reg;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			dma1_ch_lld_bus_inf_idx	= ch_0_lld_bus_inf_idx;
		`endif
`endif
			dma1_ch_src_mode	= ch_0_src_mode;
			dma1_ch_src_request	= s30;
			dma1_ch_dst_mode	= ch_0_dst_mode;
			dma1_ch_dst_request	= s31;
			dma1_ch_abt		= ch_0_abt;
			dma1_ch_int_tc_mask	= ch_0_int_tc_mask;
			dma1_ch_int_err_mask	= ch_0_int_err_mask;
			dma1_ch_int_abt_mask	= ch_0_int_abt_mask;
		end
	endcase
end
`endif


assign s3[0] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h0)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h0)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h0)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h0)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h0)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h0)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h0)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h0)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h0)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h0)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h0)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h0)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h0)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h0)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h0)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h0)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h0)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h0))));
assign s3[1] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h1)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h1)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h1)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h1)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h1)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h1)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h1)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h1)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h1)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h1)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h1)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h1)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h1)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h1)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h1)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h1)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h1)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h1))));
assign s3[2] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h2)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h2)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h2)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h2)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h2)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h2)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h2)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h2)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h2)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h2)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h2)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h2)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h2)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h2)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h2)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h2)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h2)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h2))));
assign s3[3] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h3)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h3)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h3)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h3)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h3)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h3)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h3)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h3)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h3)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h3)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h3)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h3)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h3)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h3)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h3)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h3)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h3)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h3))));
assign s3[4] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h4)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h4)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h4)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h4)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h4)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h4)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h4)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h4)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h4)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h4)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h4)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h4)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h4)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h4)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h4)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h4)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h4)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h4))));
assign s3[5] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h5)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h5)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h5)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h5)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h5)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h5)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h5)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h5)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h5)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h5)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h5)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h5)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h5)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h5)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h5)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h5)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h5)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h5))));
assign s3[6] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h6)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h6)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h6)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h6)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h6)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h6)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h6)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h6)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h6)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h6)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h6)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h6)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h6)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h6)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h6)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h6)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h6)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h6))));
assign s3[7] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h7)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h7)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h7)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h7)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h7)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h7)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h7)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h7)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h7)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h7)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h7)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h7)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h7)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h7)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h7)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h7)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h7)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h7))));
assign s3[8] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h8)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h8)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h8)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h8)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h8)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h8)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h8)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h8)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h8)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h8)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h8)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h8)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h8)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h8)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h8)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h8)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h8)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h8))));
assign s3[9] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h9)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h9)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h9)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h9)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h9)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h9)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h9)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h9)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h9)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'h9)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'h9)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'h9)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'h9)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'h9)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'h9)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'h9)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'h9)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'h9))));
assign s3[10] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'ha)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'ha)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'ha)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'ha)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'ha)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'ha)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'ha)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'ha)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'ha)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'ha)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'ha)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'ha)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'ha)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'ha)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'ha)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'ha)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'ha)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'ha))));
assign s3[11] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hb)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hb)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hb)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hb)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hb)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hb)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hb)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hb)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hb)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hb)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hb)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hb)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hb)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hb)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hb)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hb)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hb)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hb))));
assign s3[12] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hc)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hc)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hc)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hc)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hc)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hc)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hc)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hc)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hc)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hc)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hc)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hc)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hc)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hc)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hc)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hc)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hc)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hc))));
assign s3[13] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hd)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hd)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hd)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hd)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hd)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hd)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hd)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hd)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hd)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hd)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hd)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hd)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hd)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hd)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hd)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hd)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hd)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hd))));
assign s3[14] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'he)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'he)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'he)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'he)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'he)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'he)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'he)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'he)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'he)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'he)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'he)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'he)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'he)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'he)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'he)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'he)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'he)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'he))));
assign s3[15] =
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	(s14 & ((dma1_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hf)))) |
	(s15 & ((dma1_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hf)))) |
	(s16 & ((dma1_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hf)))) |
	(s17 & ((dma1_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hf)))) |
	(s18 & ((dma1_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hf)))) |
	(s19 & ((dma1_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hf)))) |
	(s20 & ((dma1_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hf)))) |
	(s21 & ((dma1_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hf)) | (dma1_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hf)))) |
`endif
	(s4 & ((dma0_ch_src_ack & ch_0_src_mode & (ch_0_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_0_dst_mode & (ch_0_dst_req_sel == 4'hf)))) |
	(s5 & ((dma0_ch_src_ack & ch_1_src_mode & (ch_1_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_1_dst_mode & (ch_1_dst_req_sel == 4'hf)))) |
	(s6 & ((dma0_ch_src_ack & ch_2_src_mode & (ch_2_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_2_dst_mode & (ch_2_dst_req_sel == 4'hf)))) |
	(s7 & ((dma0_ch_src_ack & ch_3_src_mode & (ch_3_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_3_dst_mode & (ch_3_dst_req_sel == 4'hf)))) |
	(s8 & ((dma0_ch_src_ack & ch_4_src_mode & (ch_4_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_4_dst_mode & (ch_4_dst_req_sel == 4'hf)))) |
	(s9 & ((dma0_ch_src_ack & ch_5_src_mode & (ch_5_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_5_dst_mode & (ch_5_dst_req_sel == 4'hf)))) |
	(s10 & ((dma0_ch_src_ack & ch_6_src_mode & (ch_6_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_6_dst_mode & (ch_6_dst_req_sel == 4'hf)))) |
	(s11 & ((dma0_ch_src_ack & ch_7_src_mode & (ch_7_src_req_sel == 4'hf)) | (dma0_ch_dst_ack & ch_7_dst_mode & (ch_7_dst_req_sel == 4'hf))));

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		dma_ack <= {`ATCDMAC300_REQ_ACK_NUM{1'b0}};
	end
	else begin
		dma_ack	<= s3[`ATCDMAC300_REQ_ACK_NUM-1:0];
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		dma0_current_channel <= 3'b0;
	end
	else if (dma_soft_reset) begin
		dma0_current_channel <= 3'b0;
	end
	else if (s22 && (!dma0_arb_end)) begin
		dma0_current_channel <= s29;
	end
end

`ifdef ATCDMAC300_REQ_SYNC_SUPPORT
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		s0 <= {`ATCDMAC300_REQ_ACK_NUM{1'b0}};
		s1 <= {`ATCDMAC300_REQ_ACK_NUM{1'b0}};
	end
	else begin
		s0 <= dma_req;
		s1 <= s0;
	end
end

assign	s2 = {{17-`ATCDMAC300_REQ_ACK_NUM{1'b0}}, s1};
`else
assign	s2 = {{17-`ATCDMAC300_REQ_ACK_NUM{1'b0}}, dma_req};
`endif


wire [7:0] s54;

assign	s29 = granted_channel;

assign	s54 	= {s53, s50, s47, s44,
			   s41, s38, s35, s32};
assign	ch_level 	= {ch_7_priority, ch_6_priority, ch_5_priority, ch_4_priority,
			   ch_3_priority, ch_2_priority, ch_1_priority, ch_0_priority};
assign	s22	= (dma0_idle_state && (|s23) && (!s28));

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		dma0_arb_end <= 1'b0;
	end
	else begin
		dma0_arb_end <= s22;
	end
end

`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
assign	s25[0] = (dma0_current_channel == 3'h0) && (!dma0_idle_state);
assign	s25[1] = (dma0_current_channel == 3'h1) && (!dma0_idle_state);
assign	s25[2] = (dma0_current_channel == 3'h2) && (!dma0_idle_state);
assign	s25[3] = (dma0_current_channel == 3'h3) && (!dma0_idle_state);
assign	s25[4] = (dma0_current_channel == 3'h4) && (!dma0_idle_state);
assign	s25[5] = (dma0_current_channel == 3'h5) && (!dma0_idle_state);
assign	s25[6] = (dma0_current_channel == 3'h6) && (!dma0_idle_state);
assign	s25[7] = (dma0_current_channel == 3'h7) && (!dma0_idle_state);

assign	s26[0] = (dma1_current_channel == 3'h0) && (!dma1_idle_state);
assign	s26[1] = (dma1_current_channel == 3'h1) && (!dma1_idle_state);
assign	s26[2] = (dma1_current_channel == 3'h2) && (!dma1_idle_state);
assign	s26[3] = (dma1_current_channel == 3'h3) && (!dma1_idle_state);
assign	s26[4] = (dma1_current_channel == 3'h4) && (!dma1_idle_state);
assign	s26[5] = (dma1_current_channel == 3'h5) && (!dma1_idle_state);
assign	s26[6] = (dma1_current_channel == 3'h6) && (!dma1_idle_state);
assign	s26[7] = (dma1_current_channel == 3'h7) && (!dma1_idle_state);

assign	s13 = granted_channel;
assign	s12		 = (dma1_idle_state && (!(s22  ||  dma0_arb_end)) && (|s24));
assign	s27	 = (s28  &&    s12) || (s12    && (!s22));
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		dma1_current_channel <= 3'b0;
	end
	else if (dma_soft_reset) begin
		dma1_current_channel <= 3'b0;
	end
	else if (s12 && (!dma1_arb_end)) begin
		dma1_current_channel <= s13;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		dma1_arb_end 	<= 1'b0;
		s28	<= 1'b0;
	end
	else begin
		dma1_arb_end 	<= s12;
		s28	<= s27;
	end
end
assign	s23 =  s54     & (~s26);
assign	s24 =  s54     & (~s25);
assign	current_channel =  s27 ?   dma1_current_channel : dma0_current_channel;
assign	ch_request      =  s27 ?   s24      : s23;
`else
assign	current_channel	=  dma0_current_channel;
assign	ch_request	=  s54;
`endif
endmodule

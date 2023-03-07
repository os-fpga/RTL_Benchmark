// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcdmac100_config.vh"
`include "atcdmac100_const.vh"

module atcdmac100_chmux (
                          	  hclk,
                          	  hresetn,
                          	  dma_soft_reset,
                          	  idle_state,
                          	  granted_channel,
                          	  ch_request,
                          	  ch_level,
                          	  current_channel,
                          	  arb_end,
                          	  dma_req,
                          	  dma_ack,
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
                          `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  ch_0_llp,
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
                          `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  ch_1_llp,
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
                          `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  ch_2_llp,
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
                          `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  ch_3_llp,
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
                          `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  ch_4_llp,
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
                          `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  ch_5_llp,
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
                          `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  ch_6_llp,
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
                          `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  ch_7_llp,
                          `endif
                          	  ch_7_tts,
                          	  ch_7_abt,
                          `ifdef DMAC_CONFIG_CH0
                          	  dma_ch_0_ctl_wen,
                          	  dma_ch_0_en_wen,
                          	  dma_ch_0_src_addr_wen,
                          	  dma_ch_0_dst_addr_wen,
                             `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  dma_ch_0_llp_wen,
                             `endif
                          	  dma_ch_0_tts_wen,
                          	  dma_ch_0_tc_wen,
                          	  dma_ch_0_err_wen,
                          	  dma_ch_0_int_wen,
                          `endif
                          `ifdef DMAC_CONFIG_CH1
                          	  dma_ch_1_ctl_wen,
                          	  dma_ch_1_en_wen,
                          	  dma_ch_1_src_addr_wen,
                          	  dma_ch_1_dst_addr_wen,
                             `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  dma_ch_1_llp_wen,
                             `endif
                          	  dma_ch_1_tts_wen,
                          	  dma_ch_1_tc_wen,
                          	  dma_ch_1_err_wen,
                          	  dma_ch_1_int_wen,
                          `endif
                          `ifdef DMAC_CONFIG_CH2
                          	  dma_ch_2_ctl_wen,
                          	  dma_ch_2_en_wen,
                          	  dma_ch_2_src_addr_wen,
                          	  dma_ch_2_dst_addr_wen,
                             `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  dma_ch_2_llp_wen,
                             `endif
                          	  dma_ch_2_tts_wen,
                          	  dma_ch_2_tc_wen,
                          	  dma_ch_2_err_wen,
                          	  dma_ch_2_int_wen,
                          `endif
                          `ifdef DMAC_CONFIG_CH3
                          	  dma_ch_3_ctl_wen,
                          	  dma_ch_3_en_wen,
                          	  dma_ch_3_src_addr_wen,
                          	  dma_ch_3_dst_addr_wen,
                             `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  dma_ch_3_llp_wen,
                             `endif
                          	  dma_ch_3_tts_wen,
                          	  dma_ch_3_tc_wen,
                          	  dma_ch_3_err_wen,
                          	  dma_ch_3_int_wen,
                          `endif
                          `ifdef DMAC_CONFIG_CH4
                          	  dma_ch_4_ctl_wen,
                          	  dma_ch_4_en_wen,
                          	  dma_ch_4_src_addr_wen,
                          	  dma_ch_4_dst_addr_wen,
                             `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  dma_ch_4_llp_wen,
                             `endif
                          	  dma_ch_4_tts_wen,
                          	  dma_ch_4_tc_wen,
                          	  dma_ch_4_err_wen,
                          	  dma_ch_4_int_wen,
                          `endif
                          `ifdef DMAC_CONFIG_CH5
                          	  dma_ch_5_ctl_wen,
                          	  dma_ch_5_en_wen,
                          	  dma_ch_5_src_addr_wen,
                          	  dma_ch_5_dst_addr_wen,
                             `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  dma_ch_5_llp_wen,
                             `endif
                          	  dma_ch_5_tts_wen,
                          	  dma_ch_5_tc_wen,
                          	  dma_ch_5_err_wen,
                          	  dma_ch_5_int_wen,
                          `endif
                          `ifdef DMAC_CONFIG_CH6
                          	  dma_ch_6_ctl_wen,
                          	  dma_ch_6_en_wen,
                          	  dma_ch_6_src_addr_wen,
                          	  dma_ch_6_dst_addr_wen,
                             `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  dma_ch_6_llp_wen,
                             `endif
                          	  dma_ch_6_tts_wen,
                          	  dma_ch_6_tc_wen,
                          	  dma_ch_6_err_wen,
                          	  dma_ch_6_int_wen,
                          `endif
                          `ifdef DMAC_CONFIG_CH7
                          	  dma_ch_7_ctl_wen,
                          	  dma_ch_7_en_wen,
                          	  dma_ch_7_src_addr_wen,
                          	  dma_ch_7_dst_addr_wen,
                             `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  dma_ch_7_llp_wen,
                             `endif
                          	  dma_ch_7_tts_wen,
                          	  dma_ch_7_tc_wen,
                          	  dma_ch_7_err_wen,
                          	  dma_ch_7_int_wen,
                          `endif
                          	  dma_ch_ctl_wen,
                          	  dma_ch_en_wen,
                          	  dma_ch_src_addr_wen,
                          	  dma_ch_dst_addr_wen,
                          `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  dma_ch_llp_wen,
                          `endif
                          	  dma_ch_tts_wen,
                          	  dma_ch_tc_wen,
                          	  dma_ch_err_wen,
                          	  dma_ch_int_wen,
                          	  dma_ch_src_ack,
                          	  dma_ch_dst_ack,
                          	  ch_src_addr_ctl,
                          	  ch_dst_addr_ctl,
                          	  ch_src_width,
                          	  ch_dst_width,
                          	  ch_src_burst_size,
                          	  ch_src_mode,
                          	  ch_src_request,
                          	  ch_dst_mode,
                          	  ch_dst_request,
                          	  ch_tts,
                          	  ch_src_addr,
                          	  ch_dst_addr,
                          `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  ch_llp,
                          `endif
                          	  ch_abt,
                          	  ch_int_tc_mask,
                          	  ch_int_err_mask,
                          	  ch_int_abt_mask
);

parameter ADDR_WIDTH 	= 32;
parameter ADDR_MSB 	= ADDR_WIDTH - 1;
parameter DATA_WIDTH 	= 32;
parameter DATA_MSB 	= DATA_WIDTH - 1;

localparam DMA_REQ_PENDZERO = 6'd33 - `ATCDMAC100_REQ_ACK_NUM;

input		hclk;
input		hresetn;
input		dma_soft_reset;

input		idle_state;
input	[2:0]	granted_channel;

output	[7:0]	ch_request;
output	[7:0]	ch_level;
output	[2:0]	current_channel;

output		arb_end;

input	[`ATCDMAC100_REQ_ACK_NUM-6'd1:0]	dma_req;
output	[`ATCDMAC100_REQ_ACK_NUM-6'd1:0]	dma_ack;
reg	[`ATCDMAC100_REQ_ACK_NUM-6'd1:0]	dma_ack;

reg	[`ATCDMAC100_REQ_ACK_NUM-6'd1:0]	s0;
`ifdef ATCDMAC100_REQ_SYNC_SUPPORT
reg	[`ATCDMAC100_REQ_ACK_NUM-6'd1:0]	s1;
`endif

wire	[32:0]				s2;
wire	[31:0]				s3;

reg					arb_end;
wire					s4;

input					ch_0_en;
input					ch_0_int_tc_mask;
input					ch_0_int_err_mask;
input					ch_0_int_abt_mask;
input	[4:0]				ch_0_src_req_sel;
input	[4:0]				ch_0_dst_req_sel;
input	[1:0]				ch_0_src_addr_ctl;
input	[1:0]				ch_0_dst_addr_ctl;
input					ch_0_src_mode;
input					ch_0_dst_mode;
input 	[1:0]				ch_0_src_width;
input 	[1:0]				ch_0_dst_width;
input	[2:0]				ch_0_src_burst_size;
input					ch_0_priority;
input	[ADDR_MSB:0]			ch_0_src_addr;
input	[ADDR_MSB:0]			ch_0_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input	[ADDR_MSB:0]			ch_0_llp;
`endif
input	[21:0]				ch_0_tts;
input					ch_0_abt;
input					ch_1_en;
input					ch_1_int_tc_mask;
input					ch_1_int_err_mask;
input					ch_1_int_abt_mask;
input	[4:0]				ch_1_src_req_sel;
input	[4:0]				ch_1_dst_req_sel;
input	[1:0]				ch_1_src_addr_ctl;
input	[1:0]				ch_1_dst_addr_ctl;
input					ch_1_src_mode;
input					ch_1_dst_mode;
input 	[1:0]				ch_1_src_width;
input 	[1:0]				ch_1_dst_width;
input	[2:0]				ch_1_src_burst_size;
input					ch_1_priority;
input	[ADDR_MSB:0]			ch_1_src_addr;
input	[ADDR_MSB:0]			ch_1_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input	[ADDR_MSB:0]			ch_1_llp;
`endif
input	[21:0]				ch_1_tts;
input					ch_1_abt;
input					ch_2_en;
input					ch_2_int_tc_mask;
input					ch_2_int_err_mask;
input					ch_2_int_abt_mask;
input	[4:0]				ch_2_src_req_sel;
input	[4:0]				ch_2_dst_req_sel;
input	[1:0]				ch_2_src_addr_ctl;
input	[1:0]				ch_2_dst_addr_ctl;
input					ch_2_src_mode;
input					ch_2_dst_mode;
input 	[1:0]				ch_2_src_width;
input 	[1:0]				ch_2_dst_width;
input	[2:0]				ch_2_src_burst_size;
input					ch_2_priority;
input	[ADDR_MSB:0]			ch_2_src_addr;
input	[ADDR_MSB:0]			ch_2_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input	[ADDR_MSB:0]			ch_2_llp;
`endif
input	[21:0]				ch_2_tts;
input					ch_2_abt;
input					ch_3_en;
input					ch_3_int_tc_mask;
input					ch_3_int_err_mask;
input					ch_3_int_abt_mask;
input	[4:0]				ch_3_src_req_sel;
input	[4:0]				ch_3_dst_req_sel;
input	[1:0]				ch_3_src_addr_ctl;
input	[1:0]				ch_3_dst_addr_ctl;
input					ch_3_src_mode;
input					ch_3_dst_mode;
input 	[1:0]				ch_3_src_width;
input 	[1:0]				ch_3_dst_width;
input	[2:0]				ch_3_src_burst_size;
input					ch_3_priority;
input	[ADDR_MSB:0]			ch_3_src_addr;
input	[ADDR_MSB:0]			ch_3_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input	[ADDR_MSB:0]			ch_3_llp;
`endif
input	[21:0]				ch_3_tts;
input					ch_3_abt;
input					ch_4_en;
input					ch_4_int_tc_mask;
input					ch_4_int_err_mask;
input					ch_4_int_abt_mask;
input	[4:0]				ch_4_src_req_sel;
input	[4:0]				ch_4_dst_req_sel;
input	[1:0]				ch_4_src_addr_ctl;
input	[1:0]				ch_4_dst_addr_ctl;
input					ch_4_src_mode;
input					ch_4_dst_mode;
input 	[1:0]				ch_4_src_width;
input 	[1:0]				ch_4_dst_width;
input	[2:0]				ch_4_src_burst_size;
input					ch_4_priority;
input	[ADDR_MSB:0]			ch_4_src_addr;
input	[ADDR_MSB:0]			ch_4_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input	[ADDR_MSB:0]			ch_4_llp;
`endif
input	[21:0]				ch_4_tts;
input					ch_4_abt;
input					ch_5_en;
input					ch_5_int_tc_mask;
input					ch_5_int_err_mask;
input					ch_5_int_abt_mask;
input	[4:0]				ch_5_src_req_sel;
input	[4:0]				ch_5_dst_req_sel;
input	[1:0]				ch_5_src_addr_ctl;
input	[1:0]				ch_5_dst_addr_ctl;
input					ch_5_src_mode;
input					ch_5_dst_mode;
input 	[1:0]				ch_5_src_width;
input 	[1:0]				ch_5_dst_width;
input	[2:0]				ch_5_src_burst_size;
input					ch_5_priority;
input	[ADDR_MSB:0]			ch_5_src_addr;
input	[ADDR_MSB:0]			ch_5_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input	[ADDR_MSB:0]			ch_5_llp;
`endif
input	[21:0]				ch_5_tts;
input					ch_5_abt;
input					ch_6_en;
input					ch_6_int_tc_mask;
input					ch_6_int_err_mask;
input					ch_6_int_abt_mask;
input	[4:0]				ch_6_src_req_sel;
input	[4:0]				ch_6_dst_req_sel;
input	[1:0]				ch_6_src_addr_ctl;
input	[1:0]				ch_6_dst_addr_ctl;
input					ch_6_src_mode;
input					ch_6_dst_mode;
input 	[1:0]				ch_6_src_width;
input 	[1:0]				ch_6_dst_width;
input	[2:0]				ch_6_src_burst_size;
input					ch_6_priority;
input	[ADDR_MSB:0]			ch_6_src_addr;
input	[ADDR_MSB:0]			ch_6_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input	[ADDR_MSB:0]			ch_6_llp;
`endif
input	[21:0]				ch_6_tts;
input					ch_6_abt;
input					ch_7_en;
input					ch_7_int_tc_mask;
input					ch_7_int_err_mask;
input					ch_7_int_abt_mask;
input	[4:0]				ch_7_src_req_sel;
input	[4:0]				ch_7_dst_req_sel;
input	[1:0]				ch_7_src_addr_ctl;
input	[1:0]				ch_7_dst_addr_ctl;
input					ch_7_src_mode;
input					ch_7_dst_mode;
input 	[1:0]				ch_7_src_width;
input 	[1:0]				ch_7_dst_width;
input	[2:0]				ch_7_src_burst_size;
input					ch_7_priority;
input	[ADDR_MSB:0]			ch_7_src_addr;
input	[ADDR_MSB:0]			ch_7_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input	[ADDR_MSB:0]			ch_7_llp;
`endif
input	[21:0]				ch_7_tts;
input					ch_7_abt;

wire					s5;
wire					s6;
wire					s7;
wire					s8;
wire					s9;
wire					s10;
wire					s11;
wire					s12;

`ifdef DMAC_CONFIG_CH0
output					dma_ch_0_ctl_wen;
output					dma_ch_0_en_wen;
output					dma_ch_0_src_addr_wen;
output					dma_ch_0_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output					dma_ch_0_llp_wen;
`endif
output					dma_ch_0_tts_wen;
output					dma_ch_0_tc_wen;
output					dma_ch_0_err_wen;
output					dma_ch_0_int_wen;
`endif
`ifdef DMAC_CONFIG_CH1
output					dma_ch_1_ctl_wen;
output					dma_ch_1_en_wen;
output					dma_ch_1_src_addr_wen;
output					dma_ch_1_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output					dma_ch_1_llp_wen;
`endif
output					dma_ch_1_tts_wen;
output					dma_ch_1_tc_wen;
output					dma_ch_1_err_wen;
output					dma_ch_1_int_wen;
`endif
`ifdef DMAC_CONFIG_CH2
output					dma_ch_2_ctl_wen;
output					dma_ch_2_en_wen;
output					dma_ch_2_src_addr_wen;
output					dma_ch_2_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output					dma_ch_2_llp_wen;
`endif
output					dma_ch_2_tts_wen;
output					dma_ch_2_tc_wen;
output					dma_ch_2_err_wen;
output					dma_ch_2_int_wen;
`endif
`ifdef DMAC_CONFIG_CH3
output					dma_ch_3_ctl_wen;
output					dma_ch_3_en_wen;
output					dma_ch_3_src_addr_wen;
output					dma_ch_3_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output					dma_ch_3_llp_wen;
`endif
output					dma_ch_3_tts_wen;
output					dma_ch_3_tc_wen;
output					dma_ch_3_err_wen;
output					dma_ch_3_int_wen;
`endif
`ifdef DMAC_CONFIG_CH4
output					dma_ch_4_ctl_wen;
output					dma_ch_4_en_wen;
output					dma_ch_4_src_addr_wen;
output					dma_ch_4_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output					dma_ch_4_llp_wen;
`endif
output					dma_ch_4_tts_wen;
output					dma_ch_4_tc_wen;
output					dma_ch_4_err_wen;
output					dma_ch_4_int_wen;
`endif
`ifdef DMAC_CONFIG_CH5
output					dma_ch_5_ctl_wen;
output					dma_ch_5_en_wen;
output					dma_ch_5_src_addr_wen;
output					dma_ch_5_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output					dma_ch_5_llp_wen;
`endif
output					dma_ch_5_tts_wen;
output					dma_ch_5_tc_wen;
output					dma_ch_5_err_wen;
output					dma_ch_5_int_wen;
`endif
`ifdef DMAC_CONFIG_CH6
output					dma_ch_6_ctl_wen;
output					dma_ch_6_en_wen;
output					dma_ch_6_src_addr_wen;
output					dma_ch_6_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output					dma_ch_6_llp_wen;
`endif
output					dma_ch_6_tts_wen;
output					dma_ch_6_tc_wen;
output					dma_ch_6_err_wen;
output					dma_ch_6_int_wen;
`endif
`ifdef DMAC_CONFIG_CH7
output					dma_ch_7_ctl_wen;
output					dma_ch_7_en_wen;
output					dma_ch_7_src_addr_wen;
output					dma_ch_7_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output					dma_ch_7_llp_wen;
`endif
output					dma_ch_7_tts_wen;
output					dma_ch_7_tc_wen;
output					dma_ch_7_err_wen;
output					dma_ch_7_int_wen;
`endif

input					dma_ch_ctl_wen;
input					dma_ch_en_wen;
input					dma_ch_src_addr_wen;
input					dma_ch_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input					dma_ch_llp_wen;
`endif
input					dma_ch_tts_wen;
input					dma_ch_tc_wen;
input					dma_ch_err_wen;
input					dma_ch_int_wen;
input					dma_ch_src_ack;
input					dma_ch_dst_ack;

output	[1:0]				ch_src_addr_ctl;
output	[1:0]				ch_dst_addr_ctl;
output	[1:0]				ch_src_width;
output	[1:0]				ch_dst_width;
output	[2:0]				ch_src_burst_size;
output					ch_src_mode;
output					ch_src_request;
output					ch_dst_mode;
output					ch_dst_request;
output	[21:0]				ch_tts;
output	[ADDR_MSB:0]			ch_src_addr;
output	[ADDR_MSB:0]			ch_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output	[ADDR_MSB:0]			ch_llp;
`endif
output					ch_abt;
output					ch_int_tc_mask;
output					ch_int_err_mask;
output					ch_int_abt_mask;
reg	[1:0]				ch_src_addr_ctl;
reg	[1:0]				ch_dst_addr_ctl;
reg	[1:0]				ch_src_width;
reg	[1:0]				ch_dst_width;
reg	[2:0]				ch_src_burst_size;
reg					ch_src_mode;
reg					ch_src_request;
reg					ch_dst_mode;
reg					ch_dst_request;
reg	[21:0]				ch_tts;
reg	[ADDR_MSB:0]			ch_src_addr;
reg	[ADDR_MSB:0]			ch_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
reg	[ADDR_MSB:0]			ch_llp;
`endif
reg					ch_int_tc_mask;
reg					ch_int_err_mask;
reg					ch_int_abt_mask;
reg					ch_abt;

reg	[2:0]	current_channel;
reg	[4:0]	s13;
reg	[4:0]	s14;

wire	[2:0]	s15;
wire	[4:0]	s16;
wire	[4:0]	s17;

assign		s15 = granted_channel;

`ifdef DMAC_CONFIG_CH0
assign s5 = (current_channel == 3'h0);
assign dma_ch_0_ctl_wen = dma_ch_ctl_wen & s5;
assign dma_ch_0_en_wen = dma_ch_en_wen & s5;
assign dma_ch_0_src_addr_wen = dma_ch_src_addr_wen & s5;
assign dma_ch_0_dst_addr_wen = dma_ch_dst_addr_wen & s5;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign dma_ch_0_llp_wen = dma_ch_llp_wen & s5;
`endif
assign dma_ch_0_tts_wen = dma_ch_tts_wen & s5;
assign dma_ch_0_tc_wen = dma_ch_tc_wen & s5;
assign dma_ch_0_err_wen = dma_ch_err_wen & s5;
assign dma_ch_0_int_wen = dma_ch_int_wen & s5;
`else
assign s5 = 1'b0;
`endif
`ifdef DMAC_CONFIG_CH1
assign s6 = (current_channel == 3'h1);
assign dma_ch_1_ctl_wen = dma_ch_ctl_wen & s6;
assign dma_ch_1_en_wen = dma_ch_en_wen & s6;
assign dma_ch_1_src_addr_wen = dma_ch_src_addr_wen & s6;
assign dma_ch_1_dst_addr_wen = dma_ch_dst_addr_wen & s6;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign dma_ch_1_llp_wen = dma_ch_llp_wen & s6;
`endif
assign dma_ch_1_tts_wen = dma_ch_tts_wen & s6;
assign dma_ch_1_tc_wen = dma_ch_tc_wen & s6;
assign dma_ch_1_err_wen = dma_ch_err_wen & s6;
assign dma_ch_1_int_wen = dma_ch_int_wen & s6;
`else
assign s6 = 1'b0;
`endif
`ifdef DMAC_CONFIG_CH2
assign s7 = (current_channel == 3'h2);
assign dma_ch_2_ctl_wen = dma_ch_ctl_wen & s7;
assign dma_ch_2_en_wen = dma_ch_en_wen & s7;
assign dma_ch_2_src_addr_wen = dma_ch_src_addr_wen & s7;
assign dma_ch_2_dst_addr_wen = dma_ch_dst_addr_wen & s7;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign dma_ch_2_llp_wen = dma_ch_llp_wen & s7;
`endif
assign dma_ch_2_tts_wen = dma_ch_tts_wen & s7;
assign dma_ch_2_tc_wen = dma_ch_tc_wen & s7;
assign dma_ch_2_err_wen = dma_ch_err_wen & s7;
assign dma_ch_2_int_wen = dma_ch_int_wen & s7;
`else
assign s7 = 1'b0;
`endif
`ifdef DMAC_CONFIG_CH3
assign s8 = (current_channel == 3'h3);
assign dma_ch_3_ctl_wen = dma_ch_ctl_wen & s8;
assign dma_ch_3_en_wen = dma_ch_en_wen & s8;
assign dma_ch_3_src_addr_wen = dma_ch_src_addr_wen & s8;
assign dma_ch_3_dst_addr_wen = dma_ch_dst_addr_wen & s8;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign dma_ch_3_llp_wen = dma_ch_llp_wen & s8;
`endif
assign dma_ch_3_tts_wen = dma_ch_tts_wen & s8;
assign dma_ch_3_tc_wen = dma_ch_tc_wen & s8;
assign dma_ch_3_err_wen = dma_ch_err_wen & s8;
assign dma_ch_3_int_wen = dma_ch_int_wen & s8;
`else
assign s8 = 1'b0;
`endif
`ifdef DMAC_CONFIG_CH4
assign s9 = (current_channel == 3'h4);
assign dma_ch_4_ctl_wen = dma_ch_ctl_wen & s9;
assign dma_ch_4_en_wen = dma_ch_en_wen & s9;
assign dma_ch_4_src_addr_wen = dma_ch_src_addr_wen & s9;
assign dma_ch_4_dst_addr_wen = dma_ch_dst_addr_wen & s9;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign dma_ch_4_llp_wen = dma_ch_llp_wen & s9;
`endif
assign dma_ch_4_tts_wen = dma_ch_tts_wen & s9;
assign dma_ch_4_tc_wen = dma_ch_tc_wen & s9;
assign dma_ch_4_err_wen = dma_ch_err_wen & s9;
assign dma_ch_4_int_wen = dma_ch_int_wen & s9;
`else
assign s9 = 1'b0;
`endif
`ifdef DMAC_CONFIG_CH5
assign s10 = (current_channel == 3'h5);
assign dma_ch_5_ctl_wen = dma_ch_ctl_wen & s10;
assign dma_ch_5_en_wen = dma_ch_en_wen & s10;
assign dma_ch_5_src_addr_wen = dma_ch_src_addr_wen & s10;
assign dma_ch_5_dst_addr_wen = dma_ch_dst_addr_wen & s10;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign dma_ch_5_llp_wen = dma_ch_llp_wen & s10;
`endif
assign dma_ch_5_tts_wen = dma_ch_tts_wen & s10;
assign dma_ch_5_tc_wen = dma_ch_tc_wen & s10;
assign dma_ch_5_err_wen = dma_ch_err_wen & s10;
assign dma_ch_5_int_wen = dma_ch_int_wen & s10;
`else
assign s10 = 1'b0;
`endif
`ifdef DMAC_CONFIG_CH6
assign s11 = (current_channel == 3'h6);
assign dma_ch_6_ctl_wen = dma_ch_ctl_wen & s11;
assign dma_ch_6_en_wen = dma_ch_en_wen & s11;
assign dma_ch_6_src_addr_wen = dma_ch_src_addr_wen & s11;
assign dma_ch_6_dst_addr_wen = dma_ch_dst_addr_wen & s11;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign dma_ch_6_llp_wen = dma_ch_llp_wen & s11;
`endif
assign dma_ch_6_tts_wen = dma_ch_tts_wen & s11;
assign dma_ch_6_tc_wen = dma_ch_tc_wen & s11;
assign dma_ch_6_err_wen = dma_ch_err_wen & s11;
assign dma_ch_6_int_wen = dma_ch_int_wen & s11;
`else
assign s11 = 1'b0;
`endif
`ifdef DMAC_CONFIG_CH7
assign s12 = (current_channel == 3'h7);
assign dma_ch_7_ctl_wen = dma_ch_ctl_wen & s12;
assign dma_ch_7_en_wen = dma_ch_en_wen & s12;
assign dma_ch_7_src_addr_wen = dma_ch_src_addr_wen & s12;
assign dma_ch_7_dst_addr_wen = dma_ch_dst_addr_wen & s12;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign dma_ch_7_llp_wen = dma_ch_llp_wen & s12;
`endif
assign dma_ch_7_tts_wen = dma_ch_tts_wen & s12;
assign dma_ch_7_tc_wen = dma_ch_tc_wen & s12;
assign dma_ch_7_err_wen = dma_ch_err_wen & s12;
assign dma_ch_7_int_wen = dma_ch_int_wen & s12;
`else
assign s12 = 1'b0;
`endif


reg s18;
always @(*) begin
	case(ch_0_src_req_sel)
		5'd1:	 s18 = s2[1];
		5'd2:	 s18 = s2[2];
		5'd3:	 s18 = s2[3];
		5'd4:	 s18 = s2[4];
		5'd5:	 s18 = s2[5];
		5'd6:	 s18 = s2[6];
		5'd7:	 s18 = s2[7];
		5'd8:	 s18 = s2[8];
		5'd9:	 s18 = s2[9];
		5'd10:	 s18 = s2[10];
		5'd11:	 s18 = s2[11];
		5'd12:	 s18 = s2[12];
		5'd13:	 s18 = s2[13];
		5'd14:	 s18 = s2[14];
		5'd15:	 s18 = s2[15];
		5'd16:	 s18 = s2[16];
		5'd17:	 s18 = s2[17];
		5'd18:	 s18 = s2[18];
		5'd19:	 s18 = s2[19];
		5'd20:	 s18 = s2[20];
		5'd21:	 s18 = s2[21];
		5'd22:	 s18 = s2[22];
		5'd23:	 s18 = s2[23];
		5'd24:	 s18 = s2[24];
		5'd25:	 s18 = s2[25];
		5'd26:	 s18 = s2[26];
		5'd27:	 s18 = s2[27];
		5'd28:	 s18 = s2[28];
		5'd29:	 s18 = s2[29];
		5'd30:	 s18 = s2[30];
		5'd31:	 s18 = s2[31];
		default: s18 = s2[0];
	endcase
end

reg s19;
always @(*) begin
	case(ch_0_dst_req_sel)
		5'd1:	 s19 = s2[1];
		5'd2:	 s19 = s2[2];
		5'd3:	 s19 = s2[3];
		5'd4:	 s19 = s2[4];
		5'd5:	 s19 = s2[5];
		5'd6:	 s19 = s2[6];
		5'd7:	 s19 = s2[7];
		5'd8:	 s19 = s2[8];
		5'd9:	 s19 = s2[9];
		5'd10:	 s19 = s2[10];
		5'd11:	 s19 = s2[11];
		5'd12:	 s19 = s2[12];
		5'd13:	 s19 = s2[13];
		5'd14:	 s19 = s2[14];
		5'd15:	 s19 = s2[15];
		5'd16:	 s19 = s2[16];
		5'd17:	 s19 = s2[17];
		5'd18:	 s19 = s2[18];
		5'd19:	 s19 = s2[19];
		5'd20:	 s19 = s2[20];
		5'd21:	 s19 = s2[21];
		5'd22:	 s19 = s2[22];
		5'd23:	 s19 = s2[23];
		5'd24:	 s19 = s2[24];
		5'd25:	 s19 = s2[25];
		5'd26:	 s19 = s2[26];
		5'd27:	 s19 = s2[27];
		5'd28:	 s19 = s2[28];
		5'd29:	 s19 = s2[29];
		5'd30:	 s19 = s2[30];
		5'd31:	 s19 = s2[31];
		default: s19 = s2[0];
	endcase
end
wire	s20 = ch_0_en & (s18 | ~ch_0_src_mode) & (s19 | ~ch_0_dst_mode);
reg s21;
always @(*) begin
	case(ch_1_src_req_sel)
		5'd1:	 s21 = s2[1];
		5'd2:	 s21 = s2[2];
		5'd3:	 s21 = s2[3];
		5'd4:	 s21 = s2[4];
		5'd5:	 s21 = s2[5];
		5'd6:	 s21 = s2[6];
		5'd7:	 s21 = s2[7];
		5'd8:	 s21 = s2[8];
		5'd9:	 s21 = s2[9];
		5'd10:	 s21 = s2[10];
		5'd11:	 s21 = s2[11];
		5'd12:	 s21 = s2[12];
		5'd13:	 s21 = s2[13];
		5'd14:	 s21 = s2[14];
		5'd15:	 s21 = s2[15];
		5'd16:	 s21 = s2[16];
		5'd17:	 s21 = s2[17];
		5'd18:	 s21 = s2[18];
		5'd19:	 s21 = s2[19];
		5'd20:	 s21 = s2[20];
		5'd21:	 s21 = s2[21];
		5'd22:	 s21 = s2[22];
		5'd23:	 s21 = s2[23];
		5'd24:	 s21 = s2[24];
		5'd25:	 s21 = s2[25];
		5'd26:	 s21 = s2[26];
		5'd27:	 s21 = s2[27];
		5'd28:	 s21 = s2[28];
		5'd29:	 s21 = s2[29];
		5'd30:	 s21 = s2[30];
		5'd31:	 s21 = s2[31];
		default: s21 = s2[0];
	endcase
end

reg s22;
always @(*) begin
	case(ch_1_dst_req_sel)
		5'd1:	 s22 = s2[1];
		5'd2:	 s22 = s2[2];
		5'd3:	 s22 = s2[3];
		5'd4:	 s22 = s2[4];
		5'd5:	 s22 = s2[5];
		5'd6:	 s22 = s2[6];
		5'd7:	 s22 = s2[7];
		5'd8:	 s22 = s2[8];
		5'd9:	 s22 = s2[9];
		5'd10:	 s22 = s2[10];
		5'd11:	 s22 = s2[11];
		5'd12:	 s22 = s2[12];
		5'd13:	 s22 = s2[13];
		5'd14:	 s22 = s2[14];
		5'd15:	 s22 = s2[15];
		5'd16:	 s22 = s2[16];
		5'd17:	 s22 = s2[17];
		5'd18:	 s22 = s2[18];
		5'd19:	 s22 = s2[19];
		5'd20:	 s22 = s2[20];
		5'd21:	 s22 = s2[21];
		5'd22:	 s22 = s2[22];
		5'd23:	 s22 = s2[23];
		5'd24:	 s22 = s2[24];
		5'd25:	 s22 = s2[25];
		5'd26:	 s22 = s2[26];
		5'd27:	 s22 = s2[27];
		5'd28:	 s22 = s2[28];
		5'd29:	 s22 = s2[29];
		5'd30:	 s22 = s2[30];
		5'd31:	 s22 = s2[31];
		default: s22 = s2[0];
	endcase
end
wire	s23 = ch_1_en & (s21 | ~ch_1_src_mode) & (s22 | ~ch_1_dst_mode);
reg s24;
always @(*) begin
	case(ch_2_src_req_sel)
		5'd1:	 s24 = s2[1];
		5'd2:	 s24 = s2[2];
		5'd3:	 s24 = s2[3];
		5'd4:	 s24 = s2[4];
		5'd5:	 s24 = s2[5];
		5'd6:	 s24 = s2[6];
		5'd7:	 s24 = s2[7];
		5'd8:	 s24 = s2[8];
		5'd9:	 s24 = s2[9];
		5'd10:	 s24 = s2[10];
		5'd11:	 s24 = s2[11];
		5'd12:	 s24 = s2[12];
		5'd13:	 s24 = s2[13];
		5'd14:	 s24 = s2[14];
		5'd15:	 s24 = s2[15];
		5'd16:	 s24 = s2[16];
		5'd17:	 s24 = s2[17];
		5'd18:	 s24 = s2[18];
		5'd19:	 s24 = s2[19];
		5'd20:	 s24 = s2[20];
		5'd21:	 s24 = s2[21];
		5'd22:	 s24 = s2[22];
		5'd23:	 s24 = s2[23];
		5'd24:	 s24 = s2[24];
		5'd25:	 s24 = s2[25];
		5'd26:	 s24 = s2[26];
		5'd27:	 s24 = s2[27];
		5'd28:	 s24 = s2[28];
		5'd29:	 s24 = s2[29];
		5'd30:	 s24 = s2[30];
		5'd31:	 s24 = s2[31];
		default: s24 = s2[0];
	endcase
end

reg s25;
always @(*) begin
	case(ch_2_dst_req_sel)
		5'd1:	 s25 = s2[1];
		5'd2:	 s25 = s2[2];
		5'd3:	 s25 = s2[3];
		5'd4:	 s25 = s2[4];
		5'd5:	 s25 = s2[5];
		5'd6:	 s25 = s2[6];
		5'd7:	 s25 = s2[7];
		5'd8:	 s25 = s2[8];
		5'd9:	 s25 = s2[9];
		5'd10:	 s25 = s2[10];
		5'd11:	 s25 = s2[11];
		5'd12:	 s25 = s2[12];
		5'd13:	 s25 = s2[13];
		5'd14:	 s25 = s2[14];
		5'd15:	 s25 = s2[15];
		5'd16:	 s25 = s2[16];
		5'd17:	 s25 = s2[17];
		5'd18:	 s25 = s2[18];
		5'd19:	 s25 = s2[19];
		5'd20:	 s25 = s2[20];
		5'd21:	 s25 = s2[21];
		5'd22:	 s25 = s2[22];
		5'd23:	 s25 = s2[23];
		5'd24:	 s25 = s2[24];
		5'd25:	 s25 = s2[25];
		5'd26:	 s25 = s2[26];
		5'd27:	 s25 = s2[27];
		5'd28:	 s25 = s2[28];
		5'd29:	 s25 = s2[29];
		5'd30:	 s25 = s2[30];
		5'd31:	 s25 = s2[31];
		default: s25 = s2[0];
	endcase
end
wire	s26 = ch_2_en & (s24 | ~ch_2_src_mode) & (s25 | ~ch_2_dst_mode);
reg s27;
always @(*) begin
	case(ch_3_src_req_sel)
		5'd1:	 s27 = s2[1];
		5'd2:	 s27 = s2[2];
		5'd3:	 s27 = s2[3];
		5'd4:	 s27 = s2[4];
		5'd5:	 s27 = s2[5];
		5'd6:	 s27 = s2[6];
		5'd7:	 s27 = s2[7];
		5'd8:	 s27 = s2[8];
		5'd9:	 s27 = s2[9];
		5'd10:	 s27 = s2[10];
		5'd11:	 s27 = s2[11];
		5'd12:	 s27 = s2[12];
		5'd13:	 s27 = s2[13];
		5'd14:	 s27 = s2[14];
		5'd15:	 s27 = s2[15];
		5'd16:	 s27 = s2[16];
		5'd17:	 s27 = s2[17];
		5'd18:	 s27 = s2[18];
		5'd19:	 s27 = s2[19];
		5'd20:	 s27 = s2[20];
		5'd21:	 s27 = s2[21];
		5'd22:	 s27 = s2[22];
		5'd23:	 s27 = s2[23];
		5'd24:	 s27 = s2[24];
		5'd25:	 s27 = s2[25];
		5'd26:	 s27 = s2[26];
		5'd27:	 s27 = s2[27];
		5'd28:	 s27 = s2[28];
		5'd29:	 s27 = s2[29];
		5'd30:	 s27 = s2[30];
		5'd31:	 s27 = s2[31];
		default: s27 = s2[0];
	endcase
end

reg s28;
always @(*) begin
	case(ch_3_dst_req_sel)
		5'd1:	 s28 = s2[1];
		5'd2:	 s28 = s2[2];
		5'd3:	 s28 = s2[3];
		5'd4:	 s28 = s2[4];
		5'd5:	 s28 = s2[5];
		5'd6:	 s28 = s2[6];
		5'd7:	 s28 = s2[7];
		5'd8:	 s28 = s2[8];
		5'd9:	 s28 = s2[9];
		5'd10:	 s28 = s2[10];
		5'd11:	 s28 = s2[11];
		5'd12:	 s28 = s2[12];
		5'd13:	 s28 = s2[13];
		5'd14:	 s28 = s2[14];
		5'd15:	 s28 = s2[15];
		5'd16:	 s28 = s2[16];
		5'd17:	 s28 = s2[17];
		5'd18:	 s28 = s2[18];
		5'd19:	 s28 = s2[19];
		5'd20:	 s28 = s2[20];
		5'd21:	 s28 = s2[21];
		5'd22:	 s28 = s2[22];
		5'd23:	 s28 = s2[23];
		5'd24:	 s28 = s2[24];
		5'd25:	 s28 = s2[25];
		5'd26:	 s28 = s2[26];
		5'd27:	 s28 = s2[27];
		5'd28:	 s28 = s2[28];
		5'd29:	 s28 = s2[29];
		5'd30:	 s28 = s2[30];
		5'd31:	 s28 = s2[31];
		default: s28 = s2[0];
	endcase
end
wire	s29 = ch_3_en & (s27 | ~ch_3_src_mode) & (s28 | ~ch_3_dst_mode);
reg s30;
always @(*) begin
	case(ch_4_src_req_sel)
		5'd1:	 s30 = s2[1];
		5'd2:	 s30 = s2[2];
		5'd3:	 s30 = s2[3];
		5'd4:	 s30 = s2[4];
		5'd5:	 s30 = s2[5];
		5'd6:	 s30 = s2[6];
		5'd7:	 s30 = s2[7];
		5'd8:	 s30 = s2[8];
		5'd9:	 s30 = s2[9];
		5'd10:	 s30 = s2[10];
		5'd11:	 s30 = s2[11];
		5'd12:	 s30 = s2[12];
		5'd13:	 s30 = s2[13];
		5'd14:	 s30 = s2[14];
		5'd15:	 s30 = s2[15];
		5'd16:	 s30 = s2[16];
		5'd17:	 s30 = s2[17];
		5'd18:	 s30 = s2[18];
		5'd19:	 s30 = s2[19];
		5'd20:	 s30 = s2[20];
		5'd21:	 s30 = s2[21];
		5'd22:	 s30 = s2[22];
		5'd23:	 s30 = s2[23];
		5'd24:	 s30 = s2[24];
		5'd25:	 s30 = s2[25];
		5'd26:	 s30 = s2[26];
		5'd27:	 s30 = s2[27];
		5'd28:	 s30 = s2[28];
		5'd29:	 s30 = s2[29];
		5'd30:	 s30 = s2[30];
		5'd31:	 s30 = s2[31];
		default: s30 = s2[0];
	endcase
end

reg s31;
always @(*) begin
	case(ch_4_dst_req_sel)
		5'd1:	 s31 = s2[1];
		5'd2:	 s31 = s2[2];
		5'd3:	 s31 = s2[3];
		5'd4:	 s31 = s2[4];
		5'd5:	 s31 = s2[5];
		5'd6:	 s31 = s2[6];
		5'd7:	 s31 = s2[7];
		5'd8:	 s31 = s2[8];
		5'd9:	 s31 = s2[9];
		5'd10:	 s31 = s2[10];
		5'd11:	 s31 = s2[11];
		5'd12:	 s31 = s2[12];
		5'd13:	 s31 = s2[13];
		5'd14:	 s31 = s2[14];
		5'd15:	 s31 = s2[15];
		5'd16:	 s31 = s2[16];
		5'd17:	 s31 = s2[17];
		5'd18:	 s31 = s2[18];
		5'd19:	 s31 = s2[19];
		5'd20:	 s31 = s2[20];
		5'd21:	 s31 = s2[21];
		5'd22:	 s31 = s2[22];
		5'd23:	 s31 = s2[23];
		5'd24:	 s31 = s2[24];
		5'd25:	 s31 = s2[25];
		5'd26:	 s31 = s2[26];
		5'd27:	 s31 = s2[27];
		5'd28:	 s31 = s2[28];
		5'd29:	 s31 = s2[29];
		5'd30:	 s31 = s2[30];
		5'd31:	 s31 = s2[31];
		default: s31 = s2[0];
	endcase
end
wire	s32 = ch_4_en & (s30 | ~ch_4_src_mode) & (s31 | ~ch_4_dst_mode);
reg s33;
always @(*) begin
	case(ch_5_src_req_sel)
		5'd1:	 s33 = s2[1];
		5'd2:	 s33 = s2[2];
		5'd3:	 s33 = s2[3];
		5'd4:	 s33 = s2[4];
		5'd5:	 s33 = s2[5];
		5'd6:	 s33 = s2[6];
		5'd7:	 s33 = s2[7];
		5'd8:	 s33 = s2[8];
		5'd9:	 s33 = s2[9];
		5'd10:	 s33 = s2[10];
		5'd11:	 s33 = s2[11];
		5'd12:	 s33 = s2[12];
		5'd13:	 s33 = s2[13];
		5'd14:	 s33 = s2[14];
		5'd15:	 s33 = s2[15];
		5'd16:	 s33 = s2[16];
		5'd17:	 s33 = s2[17];
		5'd18:	 s33 = s2[18];
		5'd19:	 s33 = s2[19];
		5'd20:	 s33 = s2[20];
		5'd21:	 s33 = s2[21];
		5'd22:	 s33 = s2[22];
		5'd23:	 s33 = s2[23];
		5'd24:	 s33 = s2[24];
		5'd25:	 s33 = s2[25];
		5'd26:	 s33 = s2[26];
		5'd27:	 s33 = s2[27];
		5'd28:	 s33 = s2[28];
		5'd29:	 s33 = s2[29];
		5'd30:	 s33 = s2[30];
		5'd31:	 s33 = s2[31];
		default: s33 = s2[0];
	endcase
end

reg s34;
always @(*) begin
	case(ch_5_dst_req_sel)
		5'd1:	 s34 = s2[1];
		5'd2:	 s34 = s2[2];
		5'd3:	 s34 = s2[3];
		5'd4:	 s34 = s2[4];
		5'd5:	 s34 = s2[5];
		5'd6:	 s34 = s2[6];
		5'd7:	 s34 = s2[7];
		5'd8:	 s34 = s2[8];
		5'd9:	 s34 = s2[9];
		5'd10:	 s34 = s2[10];
		5'd11:	 s34 = s2[11];
		5'd12:	 s34 = s2[12];
		5'd13:	 s34 = s2[13];
		5'd14:	 s34 = s2[14];
		5'd15:	 s34 = s2[15];
		5'd16:	 s34 = s2[16];
		5'd17:	 s34 = s2[17];
		5'd18:	 s34 = s2[18];
		5'd19:	 s34 = s2[19];
		5'd20:	 s34 = s2[20];
		5'd21:	 s34 = s2[21];
		5'd22:	 s34 = s2[22];
		5'd23:	 s34 = s2[23];
		5'd24:	 s34 = s2[24];
		5'd25:	 s34 = s2[25];
		5'd26:	 s34 = s2[26];
		5'd27:	 s34 = s2[27];
		5'd28:	 s34 = s2[28];
		5'd29:	 s34 = s2[29];
		5'd30:	 s34 = s2[30];
		5'd31:	 s34 = s2[31];
		default: s34 = s2[0];
	endcase
end
wire	s35 = ch_5_en & (s33 | ~ch_5_src_mode) & (s34 | ~ch_5_dst_mode);
reg s36;
always @(*) begin
	case(ch_6_src_req_sel)
		5'd1:	 s36 = s2[1];
		5'd2:	 s36 = s2[2];
		5'd3:	 s36 = s2[3];
		5'd4:	 s36 = s2[4];
		5'd5:	 s36 = s2[5];
		5'd6:	 s36 = s2[6];
		5'd7:	 s36 = s2[7];
		5'd8:	 s36 = s2[8];
		5'd9:	 s36 = s2[9];
		5'd10:	 s36 = s2[10];
		5'd11:	 s36 = s2[11];
		5'd12:	 s36 = s2[12];
		5'd13:	 s36 = s2[13];
		5'd14:	 s36 = s2[14];
		5'd15:	 s36 = s2[15];
		5'd16:	 s36 = s2[16];
		5'd17:	 s36 = s2[17];
		5'd18:	 s36 = s2[18];
		5'd19:	 s36 = s2[19];
		5'd20:	 s36 = s2[20];
		5'd21:	 s36 = s2[21];
		5'd22:	 s36 = s2[22];
		5'd23:	 s36 = s2[23];
		5'd24:	 s36 = s2[24];
		5'd25:	 s36 = s2[25];
		5'd26:	 s36 = s2[26];
		5'd27:	 s36 = s2[27];
		5'd28:	 s36 = s2[28];
		5'd29:	 s36 = s2[29];
		5'd30:	 s36 = s2[30];
		5'd31:	 s36 = s2[31];
		default: s36 = s2[0];
	endcase
end

reg s37;
always @(*) begin
	case(ch_6_dst_req_sel)
		5'd1:	 s37 = s2[1];
		5'd2:	 s37 = s2[2];
		5'd3:	 s37 = s2[3];
		5'd4:	 s37 = s2[4];
		5'd5:	 s37 = s2[5];
		5'd6:	 s37 = s2[6];
		5'd7:	 s37 = s2[7];
		5'd8:	 s37 = s2[8];
		5'd9:	 s37 = s2[9];
		5'd10:	 s37 = s2[10];
		5'd11:	 s37 = s2[11];
		5'd12:	 s37 = s2[12];
		5'd13:	 s37 = s2[13];
		5'd14:	 s37 = s2[14];
		5'd15:	 s37 = s2[15];
		5'd16:	 s37 = s2[16];
		5'd17:	 s37 = s2[17];
		5'd18:	 s37 = s2[18];
		5'd19:	 s37 = s2[19];
		5'd20:	 s37 = s2[20];
		5'd21:	 s37 = s2[21];
		5'd22:	 s37 = s2[22];
		5'd23:	 s37 = s2[23];
		5'd24:	 s37 = s2[24];
		5'd25:	 s37 = s2[25];
		5'd26:	 s37 = s2[26];
		5'd27:	 s37 = s2[27];
		5'd28:	 s37 = s2[28];
		5'd29:	 s37 = s2[29];
		5'd30:	 s37 = s2[30];
		5'd31:	 s37 = s2[31];
		default: s37 = s2[0];
	endcase
end
wire	s38 = ch_6_en & (s36 | ~ch_6_src_mode) & (s37 | ~ch_6_dst_mode);
reg s39;
always @(*) begin
	case(ch_7_src_req_sel)
		5'd1:	 s39 = s2[1];
		5'd2:	 s39 = s2[2];
		5'd3:	 s39 = s2[3];
		5'd4:	 s39 = s2[4];
		5'd5:	 s39 = s2[5];
		5'd6:	 s39 = s2[6];
		5'd7:	 s39 = s2[7];
		5'd8:	 s39 = s2[8];
		5'd9:	 s39 = s2[9];
		5'd10:	 s39 = s2[10];
		5'd11:	 s39 = s2[11];
		5'd12:	 s39 = s2[12];
		5'd13:	 s39 = s2[13];
		5'd14:	 s39 = s2[14];
		5'd15:	 s39 = s2[15];
		5'd16:	 s39 = s2[16];
		5'd17:	 s39 = s2[17];
		5'd18:	 s39 = s2[18];
		5'd19:	 s39 = s2[19];
		5'd20:	 s39 = s2[20];
		5'd21:	 s39 = s2[21];
		5'd22:	 s39 = s2[22];
		5'd23:	 s39 = s2[23];
		5'd24:	 s39 = s2[24];
		5'd25:	 s39 = s2[25];
		5'd26:	 s39 = s2[26];
		5'd27:	 s39 = s2[27];
		5'd28:	 s39 = s2[28];
		5'd29:	 s39 = s2[29];
		5'd30:	 s39 = s2[30];
		5'd31:	 s39 = s2[31];
		default: s39 = s2[0];
	endcase
end

reg s40;
always @(*) begin
	case(ch_7_dst_req_sel)
		5'd1:	 s40 = s2[1];
		5'd2:	 s40 = s2[2];
		5'd3:	 s40 = s2[3];
		5'd4:	 s40 = s2[4];
		5'd5:	 s40 = s2[5];
		5'd6:	 s40 = s2[6];
		5'd7:	 s40 = s2[7];
		5'd8:	 s40 = s2[8];
		5'd9:	 s40 = s2[9];
		5'd10:	 s40 = s2[10];
		5'd11:	 s40 = s2[11];
		5'd12:	 s40 = s2[12];
		5'd13:	 s40 = s2[13];
		5'd14:	 s40 = s2[14];
		5'd15:	 s40 = s2[15];
		5'd16:	 s40 = s2[16];
		5'd17:	 s40 = s2[17];
		5'd18:	 s40 = s2[18];
		5'd19:	 s40 = s2[19];
		5'd20:	 s40 = s2[20];
		5'd21:	 s40 = s2[21];
		5'd22:	 s40 = s2[22];
		5'd23:	 s40 = s2[23];
		5'd24:	 s40 = s2[24];
		5'd25:	 s40 = s2[25];
		5'd26:	 s40 = s2[26];
		5'd27:	 s40 = s2[27];
		5'd28:	 s40 = s2[28];
		5'd29:	 s40 = s2[29];
		5'd30:	 s40 = s2[30];
		5'd31:	 s40 = s2[31];
		default: s40 = s2[0];
	endcase
end
wire	s41 = ch_7_en & (s39 | ~ch_7_src_mode) & (s40 | ~ch_7_dst_mode);

reg s42;
always @(*) begin
	case(s13)
		5'd1:	 s42 = s2[1];
		5'd2:	 s42 = s2[2];
		5'd3:	 s42 = s2[3];
		5'd4:	 s42 = s2[4];
		5'd5:	 s42 = s2[5];
		5'd6:	 s42 = s2[6];
		5'd7:	 s42 = s2[7];
		5'd8:	 s42 = s2[8];
		5'd9:	 s42 = s2[9];
		5'd10:	 s42 = s2[10];
		5'd11:	 s42 = s2[11];
		5'd12:	 s42 = s2[12];
		5'd13:	 s42 = s2[13];
		5'd14:	 s42 = s2[14];
		5'd15:	 s42 = s2[15];
		5'd16:	 s42 = s2[16];
		5'd17:	 s42 = s2[17];
		5'd18:	 s42 = s2[18];
		5'd19:	 s42 = s2[19];
		5'd20:	 s42 = s2[20];
		5'd21:	 s42 = s2[21];
		5'd22:	 s42 = s2[22];
		5'd23:	 s42 = s2[23];
		5'd24:	 s42 = s2[24];
		5'd25:	 s42 = s2[25];
		5'd26:	 s42 = s2[26];
		5'd27:	 s42 = s2[27];
		5'd28:	 s42 = s2[28];
		5'd29:	 s42 = s2[29];
		5'd30:	 s42 = s2[30];
		5'd31:	 s42 = s2[31];
		default: s42 = s2[0];
	endcase
end

reg s43;
always @(*) begin
	case(s14)
		5'd1:	 s43 = s2[1];
		5'd2:	 s43 = s2[2];
		5'd3:	 s43 = s2[3];
		5'd4:	 s43 = s2[4];
		5'd5:	 s43 = s2[5];
		5'd6:	 s43 = s2[6];
		5'd7:	 s43 = s2[7];
		5'd8:	 s43 = s2[8];
		5'd9:	 s43 = s2[9];
		5'd10:	 s43 = s2[10];
		5'd11:	 s43 = s2[11];
		5'd12:	 s43 = s2[12];
		5'd13:	 s43 = s2[13];
		5'd14:	 s43 = s2[14];
		5'd15:	 s43 = s2[15];
		5'd16:	 s43 = s2[16];
		5'd17:	 s43 = s2[17];
		5'd18:	 s43 = s2[18];
		5'd19:	 s43 = s2[19];
		5'd20:	 s43 = s2[20];
		5'd21:	 s43 = s2[21];
		5'd22:	 s43 = s2[22];
		5'd23:	 s43 = s2[23];
		5'd24:	 s43 = s2[24];
		5'd25:	 s43 = s2[25];
		5'd26:	 s43 = s2[26];
		5'd27:	 s43 = s2[27];
		5'd28:	 s43 = s2[28];
		5'd29:	 s43 = s2[29];
		5'd30:	 s43 = s2[30];
		5'd31:	 s43 = s2[31];
		default: s43 = s2[0];
	endcase
end


always @(*) begin
	case(current_channel)
		3'h1: begin
			ch_src_addr_ctl 	= ch_1_src_addr_ctl;
			ch_dst_addr_ctl 	= ch_1_dst_addr_ctl;
			ch_src_width		= ch_1_src_width;
			ch_dst_width		= ch_1_dst_width;
			ch_src_burst_size	= ch_1_src_burst_size;
			ch_tts			= ch_1_tts;
			ch_src_addr		= ch_1_src_addr;
			ch_dst_addr		= ch_1_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			ch_llp			= ch_1_llp;
`endif
			ch_src_mode		= ch_1_src_mode;
			ch_dst_mode		= ch_1_dst_mode;
			ch_abt			= ch_1_abt;
			ch_int_tc_mask		= ch_1_int_tc_mask;
			ch_int_err_mask		= ch_1_int_err_mask;
			ch_int_abt_mask		= ch_1_int_abt_mask;
		end
		3'h2: begin
			ch_src_addr_ctl 	= ch_2_src_addr_ctl;
			ch_dst_addr_ctl 	= ch_2_dst_addr_ctl;
			ch_src_width		= ch_2_src_width;
			ch_dst_width		= ch_2_dst_width;
			ch_src_burst_size	= ch_2_src_burst_size;
			ch_tts			= ch_2_tts;
			ch_src_addr		= ch_2_src_addr;
			ch_dst_addr		= ch_2_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			ch_llp			= ch_2_llp;
`endif
			ch_src_mode		= ch_2_src_mode;
			ch_dst_mode		= ch_2_dst_mode;
			ch_abt			= ch_2_abt;
			ch_int_tc_mask		= ch_2_int_tc_mask;
			ch_int_err_mask		= ch_2_int_err_mask;
			ch_int_abt_mask		= ch_2_int_abt_mask;
		end
		3'h3: begin
			ch_src_addr_ctl 	= ch_3_src_addr_ctl;
			ch_dst_addr_ctl 	= ch_3_dst_addr_ctl;
			ch_src_width		= ch_3_src_width;
			ch_dst_width		= ch_3_dst_width;
			ch_src_burst_size	= ch_3_src_burst_size;
			ch_tts			= ch_3_tts;
			ch_src_addr		= ch_3_src_addr;
			ch_dst_addr		= ch_3_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			ch_llp			= ch_3_llp;
`endif
			ch_src_mode		= ch_3_src_mode;
			ch_dst_mode		= ch_3_dst_mode;
			ch_abt			= ch_3_abt;
			ch_int_tc_mask		= ch_3_int_tc_mask;
			ch_int_err_mask		= ch_3_int_err_mask;
			ch_int_abt_mask		= ch_3_int_abt_mask;
		end
		3'h4: begin
			ch_src_addr_ctl 	= ch_4_src_addr_ctl;
			ch_dst_addr_ctl 	= ch_4_dst_addr_ctl;
			ch_src_width		= ch_4_src_width;
			ch_dst_width		= ch_4_dst_width;
			ch_src_burst_size	= ch_4_src_burst_size;
			ch_tts			= ch_4_tts;
			ch_src_addr		= ch_4_src_addr;
			ch_dst_addr		= ch_4_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			ch_llp			= ch_4_llp;
`endif
			ch_src_mode		= ch_4_src_mode;
			ch_dst_mode		= ch_4_dst_mode;
			ch_abt			= ch_4_abt;
			ch_int_tc_mask		= ch_4_int_tc_mask;
			ch_int_err_mask		= ch_4_int_err_mask;
			ch_int_abt_mask		= ch_4_int_abt_mask;
		end
		3'h5: begin
			ch_src_addr_ctl 	= ch_5_src_addr_ctl;
			ch_dst_addr_ctl 	= ch_5_dst_addr_ctl;
			ch_src_width		= ch_5_src_width;
			ch_dst_width		= ch_5_dst_width;
			ch_src_burst_size	= ch_5_src_burst_size;
			ch_tts			= ch_5_tts;
			ch_src_addr		= ch_5_src_addr;
			ch_dst_addr		= ch_5_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			ch_llp			= ch_5_llp;
`endif
			ch_src_mode		= ch_5_src_mode;
			ch_dst_mode		= ch_5_dst_mode;
			ch_abt			= ch_5_abt;
			ch_int_tc_mask		= ch_5_int_tc_mask;
			ch_int_err_mask		= ch_5_int_err_mask;
			ch_int_abt_mask		= ch_5_int_abt_mask;
		end
		3'h6: begin
			ch_src_addr_ctl 	= ch_6_src_addr_ctl;
			ch_dst_addr_ctl 	= ch_6_dst_addr_ctl;
			ch_src_width		= ch_6_src_width;
			ch_dst_width		= ch_6_dst_width;
			ch_src_burst_size	= ch_6_src_burst_size;
			ch_tts			= ch_6_tts;
			ch_src_addr		= ch_6_src_addr;
			ch_dst_addr		= ch_6_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			ch_llp			= ch_6_llp;
`endif
			ch_src_mode		= ch_6_src_mode;
			ch_dst_mode		= ch_6_dst_mode;
			ch_abt			= ch_6_abt;
			ch_int_tc_mask		= ch_6_int_tc_mask;
			ch_int_err_mask		= ch_6_int_err_mask;
			ch_int_abt_mask		= ch_6_int_abt_mask;
		end
		3'h7: begin
			ch_src_addr_ctl 	= ch_7_src_addr_ctl;
			ch_dst_addr_ctl 	= ch_7_dst_addr_ctl;
			ch_src_width		= ch_7_src_width;
			ch_dst_width		= ch_7_dst_width;
			ch_src_burst_size	= ch_7_src_burst_size;
			ch_tts			= ch_7_tts;
			ch_src_addr		= ch_7_src_addr;
			ch_dst_addr		= ch_7_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			ch_llp			= ch_7_llp;
`endif
			ch_src_mode		= ch_7_src_mode;
			ch_dst_mode		= ch_7_dst_mode;
			ch_abt			= ch_7_abt;
			ch_int_tc_mask		= ch_7_int_tc_mask;
			ch_int_err_mask		= ch_7_int_err_mask;
			ch_int_abt_mask		= ch_7_int_abt_mask;
		end
		default: begin
			ch_src_addr_ctl 	= ch_0_src_addr_ctl;
			ch_dst_addr_ctl 	= ch_0_dst_addr_ctl;
			ch_src_width		= ch_0_src_width;
			ch_dst_width		= ch_0_dst_width;
			ch_src_burst_size	= ch_0_src_burst_size;
			ch_tts			= ch_0_tts;
			ch_src_addr		= ch_0_src_addr;
			ch_dst_addr		= ch_0_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			ch_llp			= ch_0_llp;
`endif
			ch_src_mode		= ch_0_src_mode;
			ch_dst_mode		= ch_0_dst_mode;
			ch_abt			= ch_0_abt;
			ch_int_tc_mask		= ch_0_int_tc_mask;
			ch_int_err_mask		= ch_0_int_err_mask;
			ch_int_abt_mask		= ch_0_int_abt_mask;
		end
	endcase
			ch_src_request		= s42;
			ch_dst_request		= s43;
end


assign s3[0] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd0)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd0)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd0)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd0)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd0)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd0)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd0)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd0)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd0)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd0)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd0)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd0)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd0)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd0)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd0)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd0))));
assign s3[1] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd1)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd1)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd1)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd1)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd1)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd1)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd1)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd1)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd1)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd1)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd1)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd1)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd1)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd1)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd1)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd1))));
assign s3[2] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd2)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd2)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd2)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd2)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd2)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd2)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd2)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd2)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd2)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd2)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd2)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd2)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd2)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd2)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd2)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd2))));
assign s3[3] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd3)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd3)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd3)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd3)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd3)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd3)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd3)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd3)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd3)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd3)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd3)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd3)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd3)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd3)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd3)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd3))));
assign s3[4] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd4)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd4)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd4)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd4)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd4)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd4)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd4)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd4)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd4)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd4)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd4)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd4)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd4)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd4)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd4)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd4))));
assign s3[5] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd5)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd5)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd5)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd5)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd5)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd5)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd5)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd5)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd5)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd5)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd5)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd5)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd5)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd5)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd5)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd5))));
assign s3[6] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd6)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd6)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd6)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd6)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd6)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd6)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd6)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd6)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd6)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd6)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd6)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd6)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd6)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd6)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd6)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd6))));
assign s3[7] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd7)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd7)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd7)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd7)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd7)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd7)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd7)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd7)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd7)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd7)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd7)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd7)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd7)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd7)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd7)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd7))));
assign s3[8] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd8)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd8)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd8)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd8)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd8)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd8)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd8)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd8)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd8)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd8)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd8)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd8)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd8)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd8)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd8)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd8))));
assign s3[9] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd9)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd9)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd9)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd9)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd9)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd9)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd9)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd9)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd9)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd9)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd9)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd9)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd9)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd9)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd9)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd9))));
assign s3[10] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd10)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd10)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd10)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd10)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd10)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd10)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd10)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd10)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd10)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd10)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd10)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd10)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd10)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd10)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd10)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd10))));
assign s3[11] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd11)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd11)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd11)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd11)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd11)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd11)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd11)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd11)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd11)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd11)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd11)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd11)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd11)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd11)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd11)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd11))));
assign s3[12] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd12)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd12)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd12)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd12)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd12)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd12)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd12)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd12)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd12)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd12)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd12)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd12)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd12)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd12)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd12)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd12))));
assign s3[13] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd13)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd13)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd13)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd13)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd13)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd13)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd13)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd13)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd13)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd13)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd13)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd13)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd13)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd13)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd13)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd13))));
assign s3[14] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd14)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd14)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd14)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd14)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd14)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd14)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd14)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd14)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd14)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd14)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd14)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd14)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd14)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd14)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd14)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd14))));
assign s3[15] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd15)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd15)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd15)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd15)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd15)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd15)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd15)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd15)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd15)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd15)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd15)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd15)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd15)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd15)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd15)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd15))));
assign s3[16] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd16)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd16)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd16)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd16)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd16)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd16)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd16)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd16)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd16)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd16)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd16)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd16)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd16)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd16)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd16)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd16))));
assign s3[17] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd17)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd17)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd17)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd17)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd17)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd17)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd17)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd17)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd17)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd17)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd17)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd17)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd17)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd17)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd17)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd17))));
assign s3[18] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd18)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd18)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd18)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd18)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd18)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd18)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd18)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd18)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd18)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd18)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd18)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd18)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd18)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd18)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd18)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd18))));
assign s3[19] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd19)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd19)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd19)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd19)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd19)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd19)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd19)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd19)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd19)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd19)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd19)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd19)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd19)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd19)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd19)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd19))));
assign s3[20] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd20)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd20)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd20)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd20)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd20)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd20)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd20)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd20)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd20)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd20)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd20)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd20)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd20)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd20)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd20)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd20))));
assign s3[21] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd21)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd21)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd21)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd21)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd21)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd21)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd21)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd21)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd21)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd21)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd21)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd21)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd21)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd21)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd21)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd21))));
assign s3[22] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd22)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd22)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd22)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd22)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd22)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd22)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd22)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd22)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd22)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd22)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd22)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd22)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd22)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd22)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd22)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd22))));
assign s3[23] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd23)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd23)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd23)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd23)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd23)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd23)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd23)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd23)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd23)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd23)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd23)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd23)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd23)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd23)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd23)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd23))));
assign s3[24] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd24)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd24)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd24)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd24)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd24)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd24)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd24)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd24)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd24)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd24)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd24)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd24)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd24)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd24)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd24)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd24))));
assign s3[25] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd25)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd25)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd25)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd25)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd25)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd25)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd25)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd25)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd25)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd25)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd25)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd25)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd25)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd25)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd25)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd25))));
assign s3[26] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd26)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd26)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd26)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd26)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd26)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd26)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd26)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd26)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd26)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd26)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd26)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd26)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd26)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd26)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd26)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd26))));
assign s3[27] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd27)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd27)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd27)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd27)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd27)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd27)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd27)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd27)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd27)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd27)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd27)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd27)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd27)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd27)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd27)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd27))));
assign s3[28] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd28)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd28)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd28)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd28)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd28)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd28)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd28)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd28)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd28)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd28)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd28)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd28)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd28)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd28)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd28)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd28))));
assign s3[29] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd29)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd29)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd29)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd29)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd29)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd29)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd29)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd29)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd29)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd29)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd29)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd29)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd29)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd29)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd29)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd29))));
assign s3[30] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd30)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd30)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd30)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd30)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd30)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd30)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd30)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd30)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd30)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd30)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd30)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd30)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd30)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd30)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd30)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd30))));
assign s3[31] =
	(s5 & ((dma_ch_src_ack & ch_0_src_mode & (s13 == 5'd31)) | (dma_ch_dst_ack & ch_0_dst_mode & (s14 == 5'd31)))) |
	(s6 & ((dma_ch_src_ack & ch_1_src_mode & (s13 == 5'd31)) | (dma_ch_dst_ack & ch_1_dst_mode & (s14 == 5'd31)))) |
	(s7 & ((dma_ch_src_ack & ch_2_src_mode & (s13 == 5'd31)) | (dma_ch_dst_ack & ch_2_dst_mode & (s14 == 5'd31)))) |
	(s8 & ((dma_ch_src_ack & ch_3_src_mode & (s13 == 5'd31)) | (dma_ch_dst_ack & ch_3_dst_mode & (s14 == 5'd31)))) |
	(s9 & ((dma_ch_src_ack & ch_4_src_mode & (s13 == 5'd31)) | (dma_ch_dst_ack & ch_4_dst_mode & (s14 == 5'd31)))) |
	(s10 & ((dma_ch_src_ack & ch_5_src_mode & (s13 == 5'd31)) | (dma_ch_dst_ack & ch_5_dst_mode & (s14 == 5'd31)))) |
	(s11 & ((dma_ch_src_ack & ch_6_src_mode & (s13 == 5'd31)) | (dma_ch_dst_ack & ch_6_dst_mode & (s14 == 5'd31)))) |
	(s12 & ((dma_ch_src_ack & ch_7_src_mode & (s13 == 5'd31)) | (dma_ch_dst_ack & ch_7_dst_mode & (s14 == 5'd31))));

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		dma_ack <= {`ATCDMAC100_REQ_ACK_NUM{1'b0}};
	end
	else begin
		dma_ack	<= s3[`ATCDMAC100_REQ_ACK_NUM-6'd1:0];
	end
end

assign s16 = 	(s15 == 3'd0) ? ch_0_src_req_sel :
				(s15 == 3'd1) ? ch_1_src_req_sel :
				(s15 == 3'd2) ? ch_2_src_req_sel :
				(s15 == 3'd3) ? ch_3_src_req_sel :
				(s15 == 3'd4) ? ch_4_src_req_sel :
				(s15 == 3'd5) ? ch_5_src_req_sel :
				(s15 == 3'd6) ? ch_6_src_req_sel : ch_7_src_req_sel;

assign s17 = 	(s15 == 3'd0) ? ch_0_dst_req_sel :
				(s15 == 3'd1) ? ch_1_dst_req_sel :
				(s15 == 3'd2) ? ch_2_dst_req_sel :
				(s15 == 3'd3) ? ch_3_dst_req_sel :
				(s15 == 3'd4) ? ch_4_dst_req_sel :
				(s15 == 3'd5) ? ch_5_dst_req_sel :
				(s15 == 3'd6) ? ch_6_dst_req_sel : ch_7_dst_req_sel;

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		current_channel 	<= 3'b0;
		s13 	<= 5'b0;
		s14 	<= 5'b0;
	end
	else if (dma_soft_reset) begin
		current_channel 	<= 3'b0;
		s13 	<= 5'b0;
		s14 	<= 5'b0;
	end
	else if (s4 & ~arb_end) begin
		current_channel 	<= s15;
		s13 	<= s16;
		s14 	<= s17;
	end
end

`ifdef ATCDMAC100_REQ_SYNC_SUPPORT
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s0 <= {`ATCDMAC100_REQ_ACK_NUM{1'b0}};
		s1 <= {`ATCDMAC100_REQ_ACK_NUM{1'b0}};
	end
	else begin
		s0 <= dma_req;
		s1 <= s0;
	end
end

assign	s2 = {{DMA_REQ_PENDZERO{1'b0}}, s1};
`else
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s0 <= {`ATCDMAC100_REQ_ACK_NUM{1'b0}};
	end
	else begin
		s0 <= dma_req;
	end
end

assign	s2 = {{DMA_REQ_PENDZERO{1'b0}}, s0};
`endif


assign	ch_request 	= {s41, s38, s35, s32,
			   s29, s26, s23, s20};
assign	ch_level 	= {ch_7_priority, ch_6_priority, ch_5_priority, ch_4_priority,
			   ch_3_priority, ch_2_priority, ch_1_priority, ch_0_priority};
assign	s4 		= (idle_state & |ch_request);

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		arb_end	<= 1'b0;
	end
	else begin
		arb_end	<= s4;
	end
end

endmodule

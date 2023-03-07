// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcdmac100_config.vh"
`include "atcdmac100_const.vh"

module atcdmac100_ahbslv(
                          	  hclk,
                          	  hresetn,
                          	  haddr,
                          	  htrans,
                          	  hwrite,
                          	  hsize,
                          	  hburst,
                          	  hwdata,
                          	  hsel,
                          	  hreadyin,
                          	  hrdata,
                          	  hresp,
                          	  hready,
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
                          `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                          	  dma_ch_llp_wdata,
                          `endif
                          	  dma_ch_ctl_wdata,
                          	  dma_ch_tts_wdata,
                          	  dma_ch_src_addr_wdata,
                          	  dma_ch_dst_addr_wdata
);

parameter ADDR_WIDTH 	= 32;
parameter ADDR_MSB 	= ADDR_WIDTH - 1;
parameter DATA_WIDTH 	= 32;
parameter DATA_MSB 	= DATA_WIDTH - 1;

parameter DMAC_MSB 	= {28'd0, {`ATCDMAC100_CH_NUM - 4'd1}};
parameter DMAC_C0	= {28'd0, {4'd9 - `ATCDMAC100_CH_NUM}};

parameter RESP_OK	= 2'b0;

parameter BURST_SINGLE	= 3'h0;
parameter BURST_INC	= 3'h1;
parameter BURST_WRAP4	= 3'h2;
parameter BURST_INC4	= 3'h3;
parameter BURST_WRAP8	= 3'h4;
parameter BURST_INC8	= 3'h5;
parameter BURST_WRAP16	= 3'h6;
parameter BURST_INC16	= 3'h7;

input          		hclk;
input          		hresetn;
input	[ADDR_MSB:0]	haddr;
input	[1:0]		htrans;
input			hwrite;
input	[2:0]		hsize;
input	[2:0]		hburst;
input	[DATA_MSB:0]	hwdata;
input			hsel;
input			hreadyin;
output	[DATA_MSB:0]	hrdata;
output	[1:0]		hresp;
output			hready;

output			dma_int;
output			dma_soft_reset;

reg	[DATA_MSB:0]	hrdata;
wire	[DATA_MSB:0]	s0;

wire                	s1;
wire                	s2;
wire			s3;
wire			s4;
wire			s5;
wire			s6;
wire			s7;
wire	[7:0]		s8;
wire	[7:0]		s9;
wire	[7:0]		s10;
wire	[7:0]		s11;
wire	[31:0]		s12;
wire	[31:0]		s13;

wire	[3:0]		s14 		= `ATCDMAC100_CH_NUM;
wire	[5:0]		s15	= `ATCDMAC100_FIFO_DEPTH;
wire	[5:0]		s16	= `ATCDMAC100_REQ_ACK_NUM;

output			ch_0_en;
output			ch_0_int_tc_mask;
output			ch_0_int_err_mask;
output			ch_0_int_abt_mask;
output	[4:0]		ch_0_src_req_sel;
output	[4:0]		ch_0_dst_req_sel;
output	[1:0]		ch_0_src_addr_ctl;
output	[1:0]		ch_0_dst_addr_ctl;
output			ch_0_src_mode;
output			ch_0_dst_mode;
output 	[1:0]		ch_0_src_width;
output 	[1:0]		ch_0_dst_width;
output	[2:0]		ch_0_src_burst_size;
output			ch_0_priority;
output	[ADDR_MSB:0]	ch_0_src_addr;
output	[ADDR_MSB:0]	ch_0_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output	[ADDR_MSB:0]	ch_0_llp;
`endif
output	[21:0]		ch_0_tts;
output			ch_0_abt;
output			ch_1_en;
output			ch_1_int_tc_mask;
output			ch_1_int_err_mask;
output			ch_1_int_abt_mask;
output	[4:0]		ch_1_src_req_sel;
output	[4:0]		ch_1_dst_req_sel;
output	[1:0]		ch_1_src_addr_ctl;
output	[1:0]		ch_1_dst_addr_ctl;
output			ch_1_src_mode;
output			ch_1_dst_mode;
output 	[1:0]		ch_1_src_width;
output 	[1:0]		ch_1_dst_width;
output	[2:0]		ch_1_src_burst_size;
output			ch_1_priority;
output	[ADDR_MSB:0]	ch_1_src_addr;
output	[ADDR_MSB:0]	ch_1_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output	[ADDR_MSB:0]	ch_1_llp;
`endif
output	[21:0]		ch_1_tts;
output			ch_1_abt;
output			ch_2_en;
output			ch_2_int_tc_mask;
output			ch_2_int_err_mask;
output			ch_2_int_abt_mask;
output	[4:0]		ch_2_src_req_sel;
output	[4:0]		ch_2_dst_req_sel;
output	[1:0]		ch_2_src_addr_ctl;
output	[1:0]		ch_2_dst_addr_ctl;
output			ch_2_src_mode;
output			ch_2_dst_mode;
output 	[1:0]		ch_2_src_width;
output 	[1:0]		ch_2_dst_width;
output	[2:0]		ch_2_src_burst_size;
output			ch_2_priority;
output	[ADDR_MSB:0]	ch_2_src_addr;
output	[ADDR_MSB:0]	ch_2_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output	[ADDR_MSB:0]	ch_2_llp;
`endif
output	[21:0]		ch_2_tts;
output			ch_2_abt;
output			ch_3_en;
output			ch_3_int_tc_mask;
output			ch_3_int_err_mask;
output			ch_3_int_abt_mask;
output	[4:0]		ch_3_src_req_sel;
output	[4:0]		ch_3_dst_req_sel;
output	[1:0]		ch_3_src_addr_ctl;
output	[1:0]		ch_3_dst_addr_ctl;
output			ch_3_src_mode;
output			ch_3_dst_mode;
output 	[1:0]		ch_3_src_width;
output 	[1:0]		ch_3_dst_width;
output	[2:0]		ch_3_src_burst_size;
output			ch_3_priority;
output	[ADDR_MSB:0]	ch_3_src_addr;
output	[ADDR_MSB:0]	ch_3_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output	[ADDR_MSB:0]	ch_3_llp;
`endif
output	[21:0]		ch_3_tts;
output			ch_3_abt;
output			ch_4_en;
output			ch_4_int_tc_mask;
output			ch_4_int_err_mask;
output			ch_4_int_abt_mask;
output	[4:0]		ch_4_src_req_sel;
output	[4:0]		ch_4_dst_req_sel;
output	[1:0]		ch_4_src_addr_ctl;
output	[1:0]		ch_4_dst_addr_ctl;
output			ch_4_src_mode;
output			ch_4_dst_mode;
output 	[1:0]		ch_4_src_width;
output 	[1:0]		ch_4_dst_width;
output	[2:0]		ch_4_src_burst_size;
output			ch_4_priority;
output	[ADDR_MSB:0]	ch_4_src_addr;
output	[ADDR_MSB:0]	ch_4_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output	[ADDR_MSB:0]	ch_4_llp;
`endif
output	[21:0]		ch_4_tts;
output			ch_4_abt;
output			ch_5_en;
output			ch_5_int_tc_mask;
output			ch_5_int_err_mask;
output			ch_5_int_abt_mask;
output	[4:0]		ch_5_src_req_sel;
output	[4:0]		ch_5_dst_req_sel;
output	[1:0]		ch_5_src_addr_ctl;
output	[1:0]		ch_5_dst_addr_ctl;
output			ch_5_src_mode;
output			ch_5_dst_mode;
output 	[1:0]		ch_5_src_width;
output 	[1:0]		ch_5_dst_width;
output	[2:0]		ch_5_src_burst_size;
output			ch_5_priority;
output	[ADDR_MSB:0]	ch_5_src_addr;
output	[ADDR_MSB:0]	ch_5_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output	[ADDR_MSB:0]	ch_5_llp;
`endif
output	[21:0]		ch_5_tts;
output			ch_5_abt;
output			ch_6_en;
output			ch_6_int_tc_mask;
output			ch_6_int_err_mask;
output			ch_6_int_abt_mask;
output	[4:0]		ch_6_src_req_sel;
output	[4:0]		ch_6_dst_req_sel;
output	[1:0]		ch_6_src_addr_ctl;
output	[1:0]		ch_6_dst_addr_ctl;
output			ch_6_src_mode;
output			ch_6_dst_mode;
output 	[1:0]		ch_6_src_width;
output 	[1:0]		ch_6_dst_width;
output	[2:0]		ch_6_src_burst_size;
output			ch_6_priority;
output	[ADDR_MSB:0]	ch_6_src_addr;
output	[ADDR_MSB:0]	ch_6_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output	[ADDR_MSB:0]	ch_6_llp;
`endif
output	[21:0]		ch_6_tts;
output			ch_6_abt;
output			ch_7_en;
output			ch_7_int_tc_mask;
output			ch_7_int_err_mask;
output			ch_7_int_abt_mask;
output	[4:0]		ch_7_src_req_sel;
output	[4:0]		ch_7_dst_req_sel;
output	[1:0]		ch_7_src_addr_ctl;
output	[1:0]		ch_7_dst_addr_ctl;
output			ch_7_src_mode;
output			ch_7_dst_mode;
output 	[1:0]		ch_7_src_width;
output 	[1:0]		ch_7_dst_width;
output	[2:0]		ch_7_src_burst_size;
output			ch_7_priority;
output	[ADDR_MSB:0]	ch_7_src_addr;
output	[ADDR_MSB:0]	ch_7_dst_addr;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output	[ADDR_MSB:0]	ch_7_llp;
`endif
output	[21:0]		ch_7_tts;
output			ch_7_abt;

`ifdef DMAC_CONFIG_CH0
input					dma_ch_0_ctl_wen;
input					dma_ch_0_en_wen;
input					dma_ch_0_src_addr_wen;
input					dma_ch_0_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input					dma_ch_0_llp_wen;
`endif
input					dma_ch_0_tts_wen;
input					dma_ch_0_tc_wen;
input					dma_ch_0_err_wen;
input					dma_ch_0_int_wen;
`endif
`ifdef DMAC_CONFIG_CH1
input					dma_ch_1_ctl_wen;
input					dma_ch_1_en_wen;
input					dma_ch_1_src_addr_wen;
input					dma_ch_1_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input					dma_ch_1_llp_wen;
`endif
input					dma_ch_1_tts_wen;
input					dma_ch_1_tc_wen;
input					dma_ch_1_err_wen;
input					dma_ch_1_int_wen;
`endif
`ifdef DMAC_CONFIG_CH2
input					dma_ch_2_ctl_wen;
input					dma_ch_2_en_wen;
input					dma_ch_2_src_addr_wen;
input					dma_ch_2_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input					dma_ch_2_llp_wen;
`endif
input					dma_ch_2_tts_wen;
input					dma_ch_2_tc_wen;
input					dma_ch_2_err_wen;
input					dma_ch_2_int_wen;
`endif
`ifdef DMAC_CONFIG_CH3
input					dma_ch_3_ctl_wen;
input					dma_ch_3_en_wen;
input					dma_ch_3_src_addr_wen;
input					dma_ch_3_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input					dma_ch_3_llp_wen;
`endif
input					dma_ch_3_tts_wen;
input					dma_ch_3_tc_wen;
input					dma_ch_3_err_wen;
input					dma_ch_3_int_wen;
`endif
`ifdef DMAC_CONFIG_CH4
input					dma_ch_4_ctl_wen;
input					dma_ch_4_en_wen;
input					dma_ch_4_src_addr_wen;
input					dma_ch_4_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input					dma_ch_4_llp_wen;
`endif
input					dma_ch_4_tts_wen;
input					dma_ch_4_tc_wen;
input					dma_ch_4_err_wen;
input					dma_ch_4_int_wen;
`endif
`ifdef DMAC_CONFIG_CH5
input					dma_ch_5_ctl_wen;
input					dma_ch_5_en_wen;
input					dma_ch_5_src_addr_wen;
input					dma_ch_5_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input					dma_ch_5_llp_wen;
`endif
input					dma_ch_5_tts_wen;
input					dma_ch_5_tc_wen;
input					dma_ch_5_err_wen;
input					dma_ch_5_int_wen;
`endif
`ifdef DMAC_CONFIG_CH6
input					dma_ch_6_ctl_wen;
input					dma_ch_6_en_wen;
input					dma_ch_6_src_addr_wen;
input					dma_ch_6_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input					dma_ch_6_llp_wen;
`endif
input					dma_ch_6_tts_wen;
input					dma_ch_6_tc_wen;
input					dma_ch_6_err_wen;
input					dma_ch_6_int_wen;
`endif
`ifdef DMAC_CONFIG_CH7
input					dma_ch_7_ctl_wen;
input					dma_ch_7_en_wen;
input					dma_ch_7_src_addr_wen;
input					dma_ch_7_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input					dma_ch_7_llp_wen;
`endif
input					dma_ch_7_tts_wen;
input					dma_ch_7_tc_wen;
input					dma_ch_7_err_wen;
input					dma_ch_7_int_wen;
`endif

`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input	[ADDR_MSB:0]			dma_ch_llp_wdata;
`endif
input	[31:1]				dma_ch_ctl_wdata;
input	[21:0]				dma_ch_tts_wdata;
input	[ADDR_MSB:0]			dma_ch_src_addr_wdata;
input	[ADDR_MSB:0]			dma_ch_dst_addr_wdata;

`ifdef DMAC_CONFIG_CH0
wire			s17;
wire			s18;
wire			s19;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s20;
`endif
wire			s21;
wire			s22;
wire			s23;
wire			s24;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s25;
`endif
wire			s26;
reg			ch_0_en;
reg			ch_0_int_tc_mask;
reg			ch_0_int_err_mask;
reg			ch_0_int_abt_mask;
reg	[4:0]		ch_0_src_req_sel;
reg	[4:0]		ch_0_dst_req_sel;
reg	[1:0]		ch_0_src_addr_ctl;
reg	[1:0]		ch_0_dst_addr_ctl;
reg			ch_0_src_mode;
reg			ch_0_dst_mode;
reg	[1:0]		ch_0_src_width;
reg	[1:0]		ch_0_dst_width;
reg	[2:0]		ch_0_src_burst_size;
reg			ch_0_priority;
wire [31:0]		s27;
reg	[ADDR_MSB:0]	ch_0_src_addr;
wire [32:0]		s28;
reg	[ADDR_MSB:0]	ch_0_dst_addr;
wire [32:0]		s29;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
reg	[ADDR_MSB:2]	s30;
wire [ADDR_MSB:0] 	ch_0_llp;
wire [32:0] 	s31;
`endif
reg	[21:0]		ch_0_tts;
reg			s32;
reg			ch_0_abt;
reg			s33;
reg			s34;
wire		s35;
wire		s36;
wire		s37;
wire		s38;
`else
wire		ch_0_en = 1'b0;
wire	[4:0]	ch_0_src_req_sel = 5'b0;
wire	[4:0]	ch_0_dst_req_sel = 5'b0;
wire	[1:0]	ch_0_src_addr_ctl = 2'b0;
wire	[1:0]	ch_0_dst_addr_ctl = 2'b0;
wire		ch_0_src_mode = 1'b0;
wire		ch_0_dst_mode = 1'b0;
wire 	[1:0]	ch_0_src_width = 2'b0;
wire 	[1:0]	ch_0_dst_width = 2'b0;
wire	[2:0]	ch_0_src_burst_size = 3'b0;
wire		ch_0_priority = 1'b0;
wire	[31:0]	s28 = 32'b0;
wire	[ADDR_MSB:0]	ch_0_src_addr = {ADDR_WIDTH{1'b0}};
wire	[31:0]	s29 = 32'b0;
wire	[ADDR_MSB:0]	ch_0_dst_addr = {ADDR_WIDTH{1'b0}};
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire	[31:0]	s31 = 32'b0;
wire	[ADDR_MSB:0]	ch_0_llp = {ADDR_WIDTH{1'b0}};
`endif
wire	[21:0]	ch_0_tts = 22'b0;
wire		s32  = 1'b0;
wire		ch_0_abt = 1'b0;
wire		s33 = 1'b0;
wire		s34 = 1'b0;
wire		ch_0_int_tc_mask = 1'b0;
wire		ch_0_int_err_mask = 1'b0;
wire		ch_0_int_abt_mask = 1'b0;
`endif
`ifdef DMAC_CONFIG_CH1
wire			s39;
wire			s40;
wire			s41;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s42;
`endif
wire			s43;
wire			s44;
wire			s45;
wire			s46;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s47;
`endif
wire			s48;
reg			ch_1_en;
reg			ch_1_int_tc_mask;
reg			ch_1_int_err_mask;
reg			ch_1_int_abt_mask;
reg	[4:0]		ch_1_src_req_sel;
reg	[4:0]		ch_1_dst_req_sel;
reg	[1:0]		ch_1_src_addr_ctl;
reg	[1:0]		ch_1_dst_addr_ctl;
reg			ch_1_src_mode;
reg			ch_1_dst_mode;
reg	[1:0]		ch_1_src_width;
reg	[1:0]		ch_1_dst_width;
reg	[2:0]		ch_1_src_burst_size;
reg			ch_1_priority;
wire [31:0]		s49;
reg	[ADDR_MSB:0]	ch_1_src_addr;
wire [32:0]		s50;
reg	[ADDR_MSB:0]	ch_1_dst_addr;
wire [32:0]		s51;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
reg	[ADDR_MSB:2]	s52;
wire [ADDR_MSB:0] 	ch_1_llp;
wire [32:0] 	s53;
`endif
reg	[21:0]		ch_1_tts;
reg			s54;
reg			ch_1_abt;
reg			s55;
reg			s56;
wire		s57;
wire		s58;
wire		s59;
wire		s60;
`else
wire		ch_1_en = 1'b0;
wire	[4:0]	ch_1_src_req_sel = 5'b0;
wire	[4:0]	ch_1_dst_req_sel = 5'b0;
wire	[1:0]	ch_1_src_addr_ctl = 2'b0;
wire	[1:0]	ch_1_dst_addr_ctl = 2'b0;
wire		ch_1_src_mode = 1'b0;
wire		ch_1_dst_mode = 1'b0;
wire 	[1:0]	ch_1_src_width = 2'b0;
wire 	[1:0]	ch_1_dst_width = 2'b0;
wire	[2:0]	ch_1_src_burst_size = 3'b0;
wire		ch_1_priority = 1'b0;
wire	[31:0]	s50 = 32'b0;
wire	[ADDR_MSB:0]	ch_1_src_addr = {ADDR_WIDTH{1'b0}};
wire	[31:0]	s51 = 32'b0;
wire	[ADDR_MSB:0]	ch_1_dst_addr = {ADDR_WIDTH{1'b0}};
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire	[31:0]	s53 = 32'b0;
wire	[ADDR_MSB:0]	ch_1_llp = {ADDR_WIDTH{1'b0}};
`endif
wire	[21:0]	ch_1_tts = 22'b0;
wire		s54  = 1'b0;
wire		ch_1_abt = 1'b0;
wire		s55 = 1'b0;
wire		s56 = 1'b0;
wire		ch_1_int_tc_mask = 1'b0;
wire		ch_1_int_err_mask = 1'b0;
wire		ch_1_int_abt_mask = 1'b0;
`endif
`ifdef DMAC_CONFIG_CH2
wire			s61;
wire			s62;
wire			s63;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s64;
`endif
wire			s65;
wire			s66;
wire			s67;
wire			s68;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s69;
`endif
wire			s70;
reg			ch_2_en;
reg			ch_2_int_tc_mask;
reg			ch_2_int_err_mask;
reg			ch_2_int_abt_mask;
reg	[4:0]		ch_2_src_req_sel;
reg	[4:0]		ch_2_dst_req_sel;
reg	[1:0]		ch_2_src_addr_ctl;
reg	[1:0]		ch_2_dst_addr_ctl;
reg			ch_2_src_mode;
reg			ch_2_dst_mode;
reg	[1:0]		ch_2_src_width;
reg	[1:0]		ch_2_dst_width;
reg	[2:0]		ch_2_src_burst_size;
reg			ch_2_priority;
wire [31:0]		s71;
reg	[ADDR_MSB:0]	ch_2_src_addr;
wire [32:0]		s72;
reg	[ADDR_MSB:0]	ch_2_dst_addr;
wire [32:0]		s73;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
reg	[ADDR_MSB:2]	s74;
wire [ADDR_MSB:0] 	ch_2_llp;
wire [32:0] 	s75;
`endif
reg	[21:0]		ch_2_tts;
reg			s76;
reg			ch_2_abt;
reg			s77;
reg			s78;
wire		s79;
wire		s80;
wire		s81;
wire		s82;
`else
wire		ch_2_en = 1'b0;
wire	[4:0]	ch_2_src_req_sel = 5'b0;
wire	[4:0]	ch_2_dst_req_sel = 5'b0;
wire	[1:0]	ch_2_src_addr_ctl = 2'b0;
wire	[1:0]	ch_2_dst_addr_ctl = 2'b0;
wire		ch_2_src_mode = 1'b0;
wire		ch_2_dst_mode = 1'b0;
wire 	[1:0]	ch_2_src_width = 2'b0;
wire 	[1:0]	ch_2_dst_width = 2'b0;
wire	[2:0]	ch_2_src_burst_size = 3'b0;
wire		ch_2_priority = 1'b0;
wire	[31:0]	s72 = 32'b0;
wire	[ADDR_MSB:0]	ch_2_src_addr = {ADDR_WIDTH{1'b0}};
wire	[31:0]	s73 = 32'b0;
wire	[ADDR_MSB:0]	ch_2_dst_addr = {ADDR_WIDTH{1'b0}};
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire	[31:0]	s75 = 32'b0;
wire	[ADDR_MSB:0]	ch_2_llp = {ADDR_WIDTH{1'b0}};
`endif
wire	[21:0]	ch_2_tts = 22'b0;
wire		s76  = 1'b0;
wire		ch_2_abt = 1'b0;
wire		s77 = 1'b0;
wire		s78 = 1'b0;
wire		ch_2_int_tc_mask = 1'b0;
wire		ch_2_int_err_mask = 1'b0;
wire		ch_2_int_abt_mask = 1'b0;
`endif
`ifdef DMAC_CONFIG_CH3
wire			s83;
wire			s84;
wire			s85;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s86;
`endif
wire			s87;
wire			s88;
wire			s89;
wire			s90;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s91;
`endif
wire			s92;
reg			ch_3_en;
reg			ch_3_int_tc_mask;
reg			ch_3_int_err_mask;
reg			ch_3_int_abt_mask;
reg	[4:0]		ch_3_src_req_sel;
reg	[4:0]		ch_3_dst_req_sel;
reg	[1:0]		ch_3_src_addr_ctl;
reg	[1:0]		ch_3_dst_addr_ctl;
reg			ch_3_src_mode;
reg			ch_3_dst_mode;
reg	[1:0]		ch_3_src_width;
reg	[1:0]		ch_3_dst_width;
reg	[2:0]		ch_3_src_burst_size;
reg			ch_3_priority;
wire [31:0]		s93;
reg	[ADDR_MSB:0]	ch_3_src_addr;
wire [32:0]		s94;
reg	[ADDR_MSB:0]	ch_3_dst_addr;
wire [32:0]		s95;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
reg	[ADDR_MSB:2]	s96;
wire [ADDR_MSB:0] 	ch_3_llp;
wire [32:0] 	s97;
`endif
reg	[21:0]		ch_3_tts;
reg			s98;
reg			ch_3_abt;
reg			s99;
reg			s100;
wire		s101;
wire		s102;
wire		s103;
wire		s104;
`else
wire		ch_3_en = 1'b0;
wire	[4:0]	ch_3_src_req_sel = 5'b0;
wire	[4:0]	ch_3_dst_req_sel = 5'b0;
wire	[1:0]	ch_3_src_addr_ctl = 2'b0;
wire	[1:0]	ch_3_dst_addr_ctl = 2'b0;
wire		ch_3_src_mode = 1'b0;
wire		ch_3_dst_mode = 1'b0;
wire 	[1:0]	ch_3_src_width = 2'b0;
wire 	[1:0]	ch_3_dst_width = 2'b0;
wire	[2:0]	ch_3_src_burst_size = 3'b0;
wire		ch_3_priority = 1'b0;
wire	[31:0]	s94 = 32'b0;
wire	[ADDR_MSB:0]	ch_3_src_addr = {ADDR_WIDTH{1'b0}};
wire	[31:0]	s95 = 32'b0;
wire	[ADDR_MSB:0]	ch_3_dst_addr = {ADDR_WIDTH{1'b0}};
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire	[31:0]	s97 = 32'b0;
wire	[ADDR_MSB:0]	ch_3_llp = {ADDR_WIDTH{1'b0}};
`endif
wire	[21:0]	ch_3_tts = 22'b0;
wire		s98  = 1'b0;
wire		ch_3_abt = 1'b0;
wire		s99 = 1'b0;
wire		s100 = 1'b0;
wire		ch_3_int_tc_mask = 1'b0;
wire		ch_3_int_err_mask = 1'b0;
wire		ch_3_int_abt_mask = 1'b0;
`endif
`ifdef DMAC_CONFIG_CH4
wire			s105;
wire			s106;
wire			s107;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s108;
`endif
wire			s109;
wire			s110;
wire			s111;
wire			s112;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s113;
`endif
wire			s114;
reg			ch_4_en;
reg			ch_4_int_tc_mask;
reg			ch_4_int_err_mask;
reg			ch_4_int_abt_mask;
reg	[4:0]		ch_4_src_req_sel;
reg	[4:0]		ch_4_dst_req_sel;
reg	[1:0]		ch_4_src_addr_ctl;
reg	[1:0]		ch_4_dst_addr_ctl;
reg			ch_4_src_mode;
reg			ch_4_dst_mode;
reg	[1:0]		ch_4_src_width;
reg	[1:0]		ch_4_dst_width;
reg	[2:0]		ch_4_src_burst_size;
reg			ch_4_priority;
wire [31:0]		s115;
reg	[ADDR_MSB:0]	ch_4_src_addr;
wire [32:0]		s116;
reg	[ADDR_MSB:0]	ch_4_dst_addr;
wire [32:0]		s117;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
reg	[ADDR_MSB:2]	s118;
wire [ADDR_MSB:0] 	ch_4_llp;
wire [32:0] 	s119;
`endif
reg	[21:0]		ch_4_tts;
reg			s120;
reg			ch_4_abt;
reg			s121;
reg			s122;
wire		s123;
wire		s124;
wire		s125;
wire		s126;
`else
wire		ch_4_en = 1'b0;
wire	[4:0]	ch_4_src_req_sel = 5'b0;
wire	[4:0]	ch_4_dst_req_sel = 5'b0;
wire	[1:0]	ch_4_src_addr_ctl = 2'b0;
wire	[1:0]	ch_4_dst_addr_ctl = 2'b0;
wire		ch_4_src_mode = 1'b0;
wire		ch_4_dst_mode = 1'b0;
wire 	[1:0]	ch_4_src_width = 2'b0;
wire 	[1:0]	ch_4_dst_width = 2'b0;
wire	[2:0]	ch_4_src_burst_size = 3'b0;
wire		ch_4_priority = 1'b0;
wire	[31:0]	s116 = 32'b0;
wire	[ADDR_MSB:0]	ch_4_src_addr = {ADDR_WIDTH{1'b0}};
wire	[31:0]	s117 = 32'b0;
wire	[ADDR_MSB:0]	ch_4_dst_addr = {ADDR_WIDTH{1'b0}};
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire	[31:0]	s119 = 32'b0;
wire	[ADDR_MSB:0]	ch_4_llp = {ADDR_WIDTH{1'b0}};
`endif
wire	[21:0]	ch_4_tts = 22'b0;
wire		s120  = 1'b0;
wire		ch_4_abt = 1'b0;
wire		s121 = 1'b0;
wire		s122 = 1'b0;
wire		ch_4_int_tc_mask = 1'b0;
wire		ch_4_int_err_mask = 1'b0;
wire		ch_4_int_abt_mask = 1'b0;
`endif
`ifdef DMAC_CONFIG_CH5
wire			s127;
wire			s128;
wire			s129;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s130;
`endif
wire			s131;
wire			s132;
wire			s133;
wire			s134;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s135;
`endif
wire			s136;
reg			ch_5_en;
reg			ch_5_int_tc_mask;
reg			ch_5_int_err_mask;
reg			ch_5_int_abt_mask;
reg	[4:0]		ch_5_src_req_sel;
reg	[4:0]		ch_5_dst_req_sel;
reg	[1:0]		ch_5_src_addr_ctl;
reg	[1:0]		ch_5_dst_addr_ctl;
reg			ch_5_src_mode;
reg			ch_5_dst_mode;
reg	[1:0]		ch_5_src_width;
reg	[1:0]		ch_5_dst_width;
reg	[2:0]		ch_5_src_burst_size;
reg			ch_5_priority;
wire [31:0]		s137;
reg	[ADDR_MSB:0]	ch_5_src_addr;
wire [32:0]		s138;
reg	[ADDR_MSB:0]	ch_5_dst_addr;
wire [32:0]		s139;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
reg	[ADDR_MSB:2]	s140;
wire [ADDR_MSB:0] 	ch_5_llp;
wire [32:0] 	s141;
`endif
reg	[21:0]		ch_5_tts;
reg			s142;
reg			ch_5_abt;
reg			s143;
reg			s144;
wire		s145;
wire		s146;
wire		s147;
wire		s148;
`else
wire		ch_5_en = 1'b0;
wire	[4:0]	ch_5_src_req_sel = 5'b0;
wire	[4:0]	ch_5_dst_req_sel = 5'b0;
wire	[1:0]	ch_5_src_addr_ctl = 2'b0;
wire	[1:0]	ch_5_dst_addr_ctl = 2'b0;
wire		ch_5_src_mode = 1'b0;
wire		ch_5_dst_mode = 1'b0;
wire 	[1:0]	ch_5_src_width = 2'b0;
wire 	[1:0]	ch_5_dst_width = 2'b0;
wire	[2:0]	ch_5_src_burst_size = 3'b0;
wire		ch_5_priority = 1'b0;
wire	[31:0]	s138 = 32'b0;
wire	[ADDR_MSB:0]	ch_5_src_addr = {ADDR_WIDTH{1'b0}};
wire	[31:0]	s139 = 32'b0;
wire	[ADDR_MSB:0]	ch_5_dst_addr = {ADDR_WIDTH{1'b0}};
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire	[31:0]	s141 = 32'b0;
wire	[ADDR_MSB:0]	ch_5_llp = {ADDR_WIDTH{1'b0}};
`endif
wire	[21:0]	ch_5_tts = 22'b0;
wire		s142  = 1'b0;
wire		ch_5_abt = 1'b0;
wire		s143 = 1'b0;
wire		s144 = 1'b0;
wire		ch_5_int_tc_mask = 1'b0;
wire		ch_5_int_err_mask = 1'b0;
wire		ch_5_int_abt_mask = 1'b0;
`endif
`ifdef DMAC_CONFIG_CH6
wire			s149;
wire			s150;
wire			s151;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s152;
`endif
wire			s153;
wire			s154;
wire			s155;
wire			s156;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s157;
`endif
wire			s158;
reg			ch_6_en;
reg			ch_6_int_tc_mask;
reg			ch_6_int_err_mask;
reg			ch_6_int_abt_mask;
reg	[4:0]		ch_6_src_req_sel;
reg	[4:0]		ch_6_dst_req_sel;
reg	[1:0]		ch_6_src_addr_ctl;
reg	[1:0]		ch_6_dst_addr_ctl;
reg			ch_6_src_mode;
reg			ch_6_dst_mode;
reg	[1:0]		ch_6_src_width;
reg	[1:0]		ch_6_dst_width;
reg	[2:0]		ch_6_src_burst_size;
reg			ch_6_priority;
wire [31:0]		s159;
reg	[ADDR_MSB:0]	ch_6_src_addr;
wire [32:0]		s160;
reg	[ADDR_MSB:0]	ch_6_dst_addr;
wire [32:0]		s161;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
reg	[ADDR_MSB:2]	s162;
wire [ADDR_MSB:0] 	ch_6_llp;
wire [32:0] 	s163;
`endif
reg	[21:0]		ch_6_tts;
reg			s164;
reg			ch_6_abt;
reg			s165;
reg			s166;
wire		s167;
wire		s168;
wire		s169;
wire		s170;
`else
wire		ch_6_en = 1'b0;
wire	[4:0]	ch_6_src_req_sel = 5'b0;
wire	[4:0]	ch_6_dst_req_sel = 5'b0;
wire	[1:0]	ch_6_src_addr_ctl = 2'b0;
wire	[1:0]	ch_6_dst_addr_ctl = 2'b0;
wire		ch_6_src_mode = 1'b0;
wire		ch_6_dst_mode = 1'b0;
wire 	[1:0]	ch_6_src_width = 2'b0;
wire 	[1:0]	ch_6_dst_width = 2'b0;
wire	[2:0]	ch_6_src_burst_size = 3'b0;
wire		ch_6_priority = 1'b0;
wire	[31:0]	s160 = 32'b0;
wire	[ADDR_MSB:0]	ch_6_src_addr = {ADDR_WIDTH{1'b0}};
wire	[31:0]	s161 = 32'b0;
wire	[ADDR_MSB:0]	ch_6_dst_addr = {ADDR_WIDTH{1'b0}};
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire	[31:0]	s163 = 32'b0;
wire	[ADDR_MSB:0]	ch_6_llp = {ADDR_WIDTH{1'b0}};
`endif
wire	[21:0]	ch_6_tts = 22'b0;
wire		s164  = 1'b0;
wire		ch_6_abt = 1'b0;
wire		s165 = 1'b0;
wire		s166 = 1'b0;
wire		ch_6_int_tc_mask = 1'b0;
wire		ch_6_int_err_mask = 1'b0;
wire		ch_6_int_abt_mask = 1'b0;
`endif
`ifdef DMAC_CONFIG_CH7
wire			s171;
wire			s172;
wire			s173;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s174;
`endif
wire			s175;
wire			s176;
wire			s177;
wire			s178;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire			s179;
`endif
wire			s180;
reg			ch_7_en;
reg			ch_7_int_tc_mask;
reg			ch_7_int_err_mask;
reg			ch_7_int_abt_mask;
reg	[4:0]		ch_7_src_req_sel;
reg	[4:0]		ch_7_dst_req_sel;
reg	[1:0]		ch_7_src_addr_ctl;
reg	[1:0]		ch_7_dst_addr_ctl;
reg			ch_7_src_mode;
reg			ch_7_dst_mode;
reg	[1:0]		ch_7_src_width;
reg	[1:0]		ch_7_dst_width;
reg	[2:0]		ch_7_src_burst_size;
reg			ch_7_priority;
wire [31:0]		s181;
reg	[ADDR_MSB:0]	ch_7_src_addr;
wire [32:0]		s182;
reg	[ADDR_MSB:0]	ch_7_dst_addr;
wire [32:0]		s183;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
reg	[ADDR_MSB:2]	s184;
wire [ADDR_MSB:0] 	ch_7_llp;
wire [32:0] 	s185;
`endif
reg	[21:0]		ch_7_tts;
reg			s186;
reg			ch_7_abt;
reg			s187;
reg			s188;
wire		s189;
wire		s190;
wire		s191;
wire		s192;
`else
wire		ch_7_en = 1'b0;
wire	[4:0]	ch_7_src_req_sel = 5'b0;
wire	[4:0]	ch_7_dst_req_sel = 5'b0;
wire	[1:0]	ch_7_src_addr_ctl = 2'b0;
wire	[1:0]	ch_7_dst_addr_ctl = 2'b0;
wire		ch_7_src_mode = 1'b0;
wire		ch_7_dst_mode = 1'b0;
wire 	[1:0]	ch_7_src_width = 2'b0;
wire 	[1:0]	ch_7_dst_width = 2'b0;
wire	[2:0]	ch_7_src_burst_size = 3'b0;
wire		ch_7_priority = 1'b0;
wire	[31:0]	s182 = 32'b0;
wire	[ADDR_MSB:0]	ch_7_src_addr = {ADDR_WIDTH{1'b0}};
wire	[31:0]	s183 = 32'b0;
wire	[ADDR_MSB:0]	ch_7_dst_addr = {ADDR_WIDTH{1'b0}};
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire	[31:0]	s185 = 32'b0;
wire	[ADDR_MSB:0]	ch_7_llp = {ADDR_WIDTH{1'b0}};
`endif
wire	[21:0]	ch_7_tts = 22'b0;
wire		s186  = 1'b0;
wire		ch_7_abt = 1'b0;
wire		s187 = 1'b0;
wire		s188 = 1'b0;
wire		ch_7_int_tc_mask = 1'b0;
wire		ch_7_int_err_mask = 1'b0;
wire		ch_7_int_abt_mask = 1'b0;
`endif

wire			s193;
reg			s194;
reg			s195;

reg	[ADDR_MSB:0]	s196;
reg	[2:0]		s197;
reg	[2:0]		s198;

wire			dma_soft_reset;

wire 			s199;
wire 	[3:0]		s200;
wire 	[ADDR_MSB:0]	s201;
wire 	[ADDR_MSB:0]	s202;
wire 	[ADDR_MSB:0]	s203;

assign	s193 = hsel & htrans[1] & hreadyin;

assign	s1		= ({s203[7:2],2'b0} == 8'h00);
assign	s2	= ({s203[7:2],2'b0} == 8'h10);
assign	s5	= ({s203[7:2],2'b0} == 8'h30);
assign	s6	= ({s203[7:2],2'b0} == 8'h34);

assign	s4	= s194 & ({s196[7:2],2'b0} == 8'h30);
assign	s3	= s194 & ({s196[7:2],2'b0} == 8'h20);
assign	s7	= s194 & ({s196[7:2],2'b0} == 8'h40);

assign	hready 		= ~s195;
assign	hresp 		= RESP_OK;

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		hrdata <= 32'b0;
	end
	else begin
		hrdata <= s0;
	end
end


`ifdef DMAC_CONFIG_CH0
assign s17 		= ({s203[7:2],2'b0} == 8'h44);
assign s18	= ({s203[7:2],2'b0} == 8'h48);
assign s19 	= ({s203[7:2],2'b0} == 8'h4c);
assign s21 		= ({s203[7:2],2'b0} == 8'h50);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s20 		= ({s203[7:2],2'b0} == 8'h54);
`endif
assign s22 		= s194 & ({s196[7:2],2'b0} == 8'h44);
assign s23 	= s194 & ({s196[7:2],2'b0} == 8'h48);
assign s24 	= s194 & ({s196[7:2],2'b0} == 8'h4c);
assign s26 		= s194 & ({s196[7:2],2'b0} == 8'h50);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s25 		= s194 & ({s196[7:2],2'b0} == 8'h54);
`endif
`endif
`ifdef DMAC_CONFIG_CH1
assign s39 		= ({s203[7:2],2'b0} == 8'h58);
assign s40	= ({s203[7:2],2'b0} == 8'h5c);
assign s41 	= ({s203[7:2],2'b0} == 8'h60);
assign s43 		= ({s203[7:2],2'b0} == 8'h64);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s42 		= ({s203[7:2],2'b0} == 8'h68);
`endif
assign s44 		= s194 & ({s196[7:2],2'b0} == 8'h58);
assign s45 	= s194 & ({s196[7:2],2'b0} == 8'h5c);
assign s46 	= s194 & ({s196[7:2],2'b0} == 8'h60);
assign s48 		= s194 & ({s196[7:2],2'b0} == 8'h64);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s47 		= s194 & ({s196[7:2],2'b0} == 8'h68);
`endif
`endif
`ifdef DMAC_CONFIG_CH2
assign s61 		= ({s203[7:2],2'b0} == 8'h6c);
assign s62	= ({s203[7:2],2'b0} == 8'h70);
assign s63 	= ({s203[7:2],2'b0} == 8'h74);
assign s65 		= ({s203[7:2],2'b0} == 8'h78);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s64 		= ({s203[7:2],2'b0} == 8'h7c);
`endif
assign s66 		= s194 & ({s196[7:2],2'b0} == 8'h6c);
assign s67 	= s194 & ({s196[7:2],2'b0} == 8'h70);
assign s68 	= s194 & ({s196[7:2],2'b0} == 8'h74);
assign s70 		= s194 & ({s196[7:2],2'b0} == 8'h78);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s69 		= s194 & ({s196[7:2],2'b0} == 8'h7c);
`endif
`endif
`ifdef DMAC_CONFIG_CH3
assign s83 		= ({s203[7:2],2'b0} == 8'h80);
assign s84	= ({s203[7:2],2'b0} == 8'h84);
assign s85 	= ({s203[7:2],2'b0} == 8'h88);
assign s87 		= ({s203[7:2],2'b0} == 8'h8c);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s86 		= ({s203[7:2],2'b0} == 8'h90);
`endif
assign s88 		= s194 & ({s196[7:2],2'b0} == 8'h80);
assign s89 	= s194 & ({s196[7:2],2'b0} == 8'h84);
assign s90 	= s194 & ({s196[7:2],2'b0} == 8'h88);
assign s92 		= s194 & ({s196[7:2],2'b0} == 8'h8c);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s91 		= s194 & ({s196[7:2],2'b0} == 8'h90);
`endif
`endif
`ifdef DMAC_CONFIG_CH4
assign s105 		= ({s203[7:2],2'b0} == 8'h94);
assign s106	= ({s203[7:2],2'b0} == 8'h98);
assign s107 	= ({s203[7:2],2'b0} == 8'h9c);
assign s109 		= ({s203[7:2],2'b0} == 8'ha0);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s108 		= ({s203[7:2],2'b0} == 8'ha4);
`endif
assign s110 		= s194 & ({s196[7:2],2'b0} == 8'h94);
assign s111 	= s194 & ({s196[7:2],2'b0} == 8'h98);
assign s112 	= s194 & ({s196[7:2],2'b0} == 8'h9c);
assign s114 		= s194 & ({s196[7:2],2'b0} == 8'ha0);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s113 		= s194 & ({s196[7:2],2'b0} == 8'ha4);
`endif
`endif
`ifdef DMAC_CONFIG_CH5
assign s127 		= ({s203[7:2],2'b0} == 8'ha8);
assign s128	= ({s203[7:2],2'b0} == 8'hac);
assign s129 	= ({s203[7:2],2'b0} == 8'hb0);
assign s131 		= ({s203[7:2],2'b0} == 8'hb4);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s130 		= ({s203[7:2],2'b0} == 8'hb8);
`endif
assign s132 		= s194 & ({s196[7:2],2'b0} == 8'ha8);
assign s133 	= s194 & ({s196[7:2],2'b0} == 8'hac);
assign s134 	= s194 & ({s196[7:2],2'b0} == 8'hb0);
assign s136 		= s194 & ({s196[7:2],2'b0} == 8'hb4);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s135 		= s194 & ({s196[7:2],2'b0} == 8'hb8);
`endif
`endif
`ifdef DMAC_CONFIG_CH6
assign s149 		= ({s203[7:2],2'b0} == 8'hbc);
assign s150	= ({s203[7:2],2'b0} == 8'hc0);
assign s151 	= ({s203[7:2],2'b0} == 8'hc4);
assign s153 		= ({s203[7:2],2'b0} == 8'hc8);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s152 		= ({s203[7:2],2'b0} == 8'hcc);
`endif
assign s154 		= s194 & ({s196[7:2],2'b0} == 8'hbc);
assign s155 	= s194 & ({s196[7:2],2'b0} == 8'hc0);
assign s156 	= s194 & ({s196[7:2],2'b0} == 8'hc4);
assign s158 		= s194 & ({s196[7:2],2'b0} == 8'hc8);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s157 		= s194 & ({s196[7:2],2'b0} == 8'hcc);
`endif
`endif
`ifdef DMAC_CONFIG_CH7
assign s171 		= ({s203[7:2],2'b0} == 8'hd0);
assign s172	= ({s203[7:2],2'b0} == 8'hd4);
assign s173 	= ({s203[7:2],2'b0} == 8'hd8);
assign s175 		= ({s203[7:2],2'b0} == 8'hdc);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s174 		= ({s203[7:2],2'b0} == 8'he0);
`endif
assign s176 		= s194 & ({s196[7:2],2'b0} == 8'hd0);
assign s177 	= s194 & ({s196[7:2],2'b0} == 8'hd4);
assign s178 	= s194 & ({s196[7:2],2'b0} == 8'hd8);
assign s180 		= s194 & ({s196[7:2],2'b0} == 8'hdc);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign s179 		= s194 & ({s196[7:2],2'b0} == 8'he0);
`endif
`endif

assign dma_soft_reset 		= s3 & hwdata[0] & hreadyin;
assign dma_int			= |s11;

assign s8		= {s186, s164, s142, s120, s98, s76, s54, s32};
assign s9		= {ch_7_abt, ch_6_abt, ch_5_abt, ch_4_abt, ch_3_abt, ch_2_abt, ch_1_abt, ch_0_abt};
assign s10		= {s187, s165, s143, s121, s99, s77, s55, s33};
assign s11		= {s188, s166, s144, s122, s100, s78, s56, s34};
assign s12		= {8'b0, s8, s9, s10};
assign s13			= {24'b0, ch_7_en, ch_6_en, ch_5_en, ch_4_en, ch_3_en, ch_2_en, ch_1_en, ch_0_en};


`ifdef DMAC_CONFIG_CH0
assign s35 	= (s4 & hwdata[16]) ? 1'b0 : (dma_ch_0_tc_wen ? 1'b1 : s32);
assign s36 	= (s4 & hwdata[8]) ? 1'b0 : ((s7 & hwdata[0] & ch_0_en) ? 1'b1 : ch_0_abt);
assign s37 	= (s4 & hwdata[0]) ? 1'b0 : (dma_ch_0_err_wen ? 1'b1 : s33);
assign s38 	= (~s35 & ~s36 & ~s37) ? 1'b0 : (dma_ch_0_int_wen ? 1'b1 : s34);
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s32		<= 1'b0;
		ch_0_abt	<= 1'b0;
		s33	<= 1'b0;
		s34	<= 1'b0;
	end
	else begin
		s32		<= s35;
		ch_0_abt	<= s36;
		s33	<= s37;
		s34	<= s38;
	end
end
`endif

`ifdef DMAC_CONFIG_CH1
assign s57 	= (s4 & hwdata[17]) ? 1'b0 : (dma_ch_1_tc_wen ? 1'b1 : s54);
assign s58 	= (s4 & hwdata[9]) ? 1'b0 : ((s7 & hwdata[1] & ch_1_en) ? 1'b1 : ch_1_abt);
assign s59 	= (s4 & hwdata[1]) ? 1'b0 : (dma_ch_1_err_wen ? 1'b1 : s55);
assign s60 	= (~s57 & ~s58 & ~s59) ? 1'b0 : (dma_ch_1_int_wen ? 1'b1 : s56);
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s54		<= 1'b0;
		ch_1_abt	<= 1'b0;
		s55	<= 1'b0;
		s56	<= 1'b0;
	end
	else begin
		s54		<= s57;
		ch_1_abt	<= s58;
		s55	<= s59;
		s56	<= s60;
	end
end
`endif

`ifdef DMAC_CONFIG_CH2
assign s79 	= (s4 & hwdata[18]) ? 1'b0 : (dma_ch_2_tc_wen ? 1'b1 : s76);
assign s80 	= (s4 & hwdata[10]) ? 1'b0 : ((s7 & hwdata[2] & ch_2_en) ? 1'b1 : ch_2_abt);
assign s81 	= (s4 & hwdata[2]) ? 1'b0 : (dma_ch_2_err_wen ? 1'b1 : s77);
assign s82 	= (~s79 & ~s80 & ~s81) ? 1'b0 : (dma_ch_2_int_wen ? 1'b1 : s78);
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s76		<= 1'b0;
		ch_2_abt	<= 1'b0;
		s77	<= 1'b0;
		s78	<= 1'b0;
	end
	else begin
		s76		<= s79;
		ch_2_abt	<= s80;
		s77	<= s81;
		s78	<= s82;
	end
end
`endif

`ifdef DMAC_CONFIG_CH3
assign s101 	= (s4 & hwdata[19]) ? 1'b0 : (dma_ch_3_tc_wen ? 1'b1 : s98);
assign s102 	= (s4 & hwdata[11]) ? 1'b0 : ((s7 & hwdata[3] & ch_3_en) ? 1'b1 : ch_3_abt);
assign s103 	= (s4 & hwdata[3]) ? 1'b0 : (dma_ch_3_err_wen ? 1'b1 : s99);
assign s104 	= (~s101 & ~s102 & ~s103) ? 1'b0 : (dma_ch_3_int_wen ? 1'b1 : s100);
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s98		<= 1'b0;
		ch_3_abt	<= 1'b0;
		s99	<= 1'b0;
		s100	<= 1'b0;
	end
	else begin
		s98		<= s101;
		ch_3_abt	<= s102;
		s99	<= s103;
		s100	<= s104;
	end
end
`endif

`ifdef DMAC_CONFIG_CH4
assign s123 	= (s4 & hwdata[20]) ? 1'b0 : (dma_ch_4_tc_wen ? 1'b1 : s120);
assign s124 	= (s4 & hwdata[12]) ? 1'b0 : ((s7 & hwdata[4] & ch_4_en) ? 1'b1 : ch_4_abt);
assign s125 	= (s4 & hwdata[4]) ? 1'b0 : (dma_ch_4_err_wen ? 1'b1 : s121);
assign s126 	= (~s123 & ~s124 & ~s125) ? 1'b0 : (dma_ch_4_int_wen ? 1'b1 : s122);
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s120		<= 1'b0;
		ch_4_abt	<= 1'b0;
		s121	<= 1'b0;
		s122	<= 1'b0;
	end
	else begin
		s120		<= s123;
		ch_4_abt	<= s124;
		s121	<= s125;
		s122	<= s126;
	end
end
`endif

`ifdef DMAC_CONFIG_CH5
assign s145 	= (s4 & hwdata[21]) ? 1'b0 : (dma_ch_5_tc_wen ? 1'b1 : s142);
assign s146 	= (s4 & hwdata[13]) ? 1'b0 : ((s7 & hwdata[5] & ch_5_en) ? 1'b1 : ch_5_abt);
assign s147 	= (s4 & hwdata[5]) ? 1'b0 : (dma_ch_5_err_wen ? 1'b1 : s143);
assign s148 	= (~s145 & ~s146 & ~s147) ? 1'b0 : (dma_ch_5_int_wen ? 1'b1 : s144);
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s142		<= 1'b0;
		ch_5_abt	<= 1'b0;
		s143	<= 1'b0;
		s144	<= 1'b0;
	end
	else begin
		s142		<= s145;
		ch_5_abt	<= s146;
		s143	<= s147;
		s144	<= s148;
	end
end
`endif

`ifdef DMAC_CONFIG_CH6
assign s167 	= (s4 & hwdata[22]) ? 1'b0 : (dma_ch_6_tc_wen ? 1'b1 : s164);
assign s168 	= (s4 & hwdata[14]) ? 1'b0 : ((s7 & hwdata[6] & ch_6_en) ? 1'b1 : ch_6_abt);
assign s169 	= (s4 & hwdata[6]) ? 1'b0 : (dma_ch_6_err_wen ? 1'b1 : s165);
assign s170 	= (~s167 & ~s168 & ~s169) ? 1'b0 : (dma_ch_6_int_wen ? 1'b1 : s166);
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s164		<= 1'b0;
		ch_6_abt	<= 1'b0;
		s165	<= 1'b0;
		s166	<= 1'b0;
	end
	else begin
		s164		<= s167;
		ch_6_abt	<= s168;
		s165	<= s169;
		s166	<= s170;
	end
end
`endif

`ifdef DMAC_CONFIG_CH7
assign s189 	= (s4 & hwdata[23]) ? 1'b0 : (dma_ch_7_tc_wen ? 1'b1 : s186);
assign s190 	= (s4 & hwdata[15]) ? 1'b0 : ((s7 & hwdata[7] & ch_7_en) ? 1'b1 : ch_7_abt);
assign s191 	= (s4 & hwdata[7]) ? 1'b0 : (dma_ch_7_err_wen ? 1'b1 : s187);
assign s192 	= (~s189 & ~s190 & ~s191) ? 1'b0 : (dma_ch_7_int_wen ? 1'b1 : s188);
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s186		<= 1'b0;
		ch_7_abt	<= 1'b0;
		s187	<= 1'b0;
		s188	<= 1'b0;
	end
	else begin
		s186		<= s189;
		ch_7_abt	<= s190;
		s187	<= s191;
		s188	<= s192;
	end
end
`endif



always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s194 <= 1'b0;
	end
	else begin
		s194	<= s193 & hwrite;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s195 	<= 1'b0;
	end
	else begin
		s195	<= s193 & ~hwrite & (htrans == 2'b10);
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s196	<= {ADDR_WIDTH{1'b0}};
		s198	<= 3'b0;
		s197	<= 3'b0;
	end
	else if (s193) begin
		s196	<= haddr;
		s198	<= hsize;
		s197	<= hburst;
	end
end

assign s200 = 4'b0001 << s198;

assign s199 = (s197 == BURST_WRAP4) | (s197 == BURST_WRAP8) | (s197 == BURST_WRAP16);

assign s201 = s199 ? (~{ADDR_WIDTH{1'b0}}) << (s198 + {1'b0,s197[2:1]} + 3'b01) : {ADDR_WIDTH{1'b0}};

assign s202 = (s196 & s201) | ((s196 + {{(ADDR_MSB-3){1'b0}}, s200}) & ~s201);

assign s203 = s195 ? s196 : s202;


`ifdef DMAC_CONFIG_CH0

assign s27 = {ch_0_src_req_sel[4], ch_0_dst_req_sel[4],
		ch_0_priority, 4'b0, ch_0_src_burst_size, ch_0_src_width, ch_0_dst_width,
		ch_0_src_mode, ch_0_dst_mode, ch_0_src_addr_ctl, ch_0_dst_addr_ctl,
		ch_0_src_req_sel[3:0], ch_0_dst_req_sel[3:0], ch_0_int_abt_mask,
		ch_0_int_err_mask, ch_0_int_tc_mask, ch_0_en};
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_0_int_tc_mask	<= 1'b0;
		ch_0_int_err_mask	<= 1'b0;
		ch_0_int_abt_mask	<= 1'b0;
		ch_0_dst_req_sel	<= 5'b0;
		ch_0_src_req_sel	<= 5'b0;
		ch_0_dst_addr_ctl	<= 2'b0;
		ch_0_src_addr_ctl	<= 2'b0;
		ch_0_dst_mode		<= 1'b0;
		ch_0_src_mode		<= 1'b0;
		ch_0_dst_width		<= 2'b0;
		ch_0_src_width		<= 2'b0;
		ch_0_src_burst_size	<= 3'b0;
		ch_0_priority		<= 1'b0;
	end
	else if (s22 & hreadyin) begin
		ch_0_int_tc_mask	<= hwdata[1];
		ch_0_int_err_mask	<= hwdata[2];
		ch_0_int_abt_mask	<= hwdata[3];
		ch_0_dst_req_sel	<= {hwdata[30], hwdata[7:4]};
		ch_0_src_req_sel	<= {hwdata[31], hwdata[11:8]};
		ch_0_dst_addr_ctl	<= hwdata[13:12];
		ch_0_src_addr_ctl	<= hwdata[15:14];
		ch_0_dst_mode		<= hwdata[16];
		ch_0_src_mode		<= hwdata[17];
		ch_0_dst_width		<= hwdata[19:18];
		ch_0_src_width		<= hwdata[21:20];
		ch_0_src_burst_size	<= hwdata[24:22];
		ch_0_priority		<= hwdata[29];
	end
	else if (dma_ch_0_ctl_wen) begin
		ch_0_int_tc_mask	<= dma_ch_ctl_wdata[1];
		ch_0_int_err_mask	<= dma_ch_ctl_wdata[2];
		ch_0_int_abt_mask	<= dma_ch_ctl_wdata[3];
		ch_0_dst_req_sel	<= {dma_ch_ctl_wdata[30], dma_ch_ctl_wdata[7:4]};
		ch_0_src_req_sel	<= {dma_ch_ctl_wdata[31], dma_ch_ctl_wdata[11:8]};
		ch_0_dst_addr_ctl	<= dma_ch_ctl_wdata[13:12];
		ch_0_src_addr_ctl	<= dma_ch_ctl_wdata[15:14];
		ch_0_dst_mode		<= dma_ch_ctl_wdata[16];
		ch_0_src_mode		<= dma_ch_ctl_wdata[17];
		ch_0_dst_width		<= dma_ch_ctl_wdata[19:18];
		ch_0_src_width		<= dma_ch_ctl_wdata[21:20];
		ch_0_src_burst_size	<= dma_ch_ctl_wdata[24:22];
		ch_0_priority		<= dma_ch_ctl_wdata[29];
	end
end
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_0_en			<= 1'b0;
	end
	else if (s22 & hreadyin) begin
		ch_0_en			<= hwdata[0];
	end
	else if (dma_ch_0_en_wen | dma_soft_reset) begin
		ch_0_en			<= 1'b0;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_0_src_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s23 & hreadyin) begin
		ch_0_src_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_0_src_addr_wen) begin
		ch_0_src_addr 	<= dma_ch_src_addr_wdata;
	end
end
assign s28 = {{(33-ADDR_WIDTH){1'b0}}, ch_0_src_addr};

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_0_dst_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s24 & hreadyin) begin
		ch_0_dst_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_0_dst_addr_wen) begin
		ch_0_dst_addr 	<= dma_ch_dst_addr_wdata;
	end
end
assign s29 = {{(33-ADDR_WIDTH){1'b0}}, ch_0_dst_addr};

`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s30	<= {ADDR_WIDTH-2{1'b0}};
	end
	else if (s25 & hreadyin) begin
		s30	<= hwdata[ADDR_MSB:2];
	end
	else if (dma_ch_0_llp_wen) begin
		s30	<= dma_ch_llp_wdata[ADDR_MSB:2];
	end
end

assign ch_0_llp	= {s30, 2'b0};
assign s31 = {{(33-ADDR_WIDTH){1'b0}}, ch_0_llp};
`endif

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_0_tts	<= 22'b0;
	end
	else if (s26 & hreadyin) begin
		ch_0_tts 	<= hwdata[21:0];
	end
	else if (dma_ch_0_tts_wen) begin
		ch_0_tts 	<= dma_ch_tts_wdata[21:0];
	end
end
`endif
`ifdef DMAC_CONFIG_CH1

assign s49 = {ch_1_src_req_sel[4], ch_1_dst_req_sel[4],
		ch_1_priority, 4'b0, ch_1_src_burst_size, ch_1_src_width, ch_1_dst_width,
		ch_1_src_mode, ch_1_dst_mode, ch_1_src_addr_ctl, ch_1_dst_addr_ctl,
		ch_1_src_req_sel[3:0], ch_1_dst_req_sel[3:0], ch_1_int_abt_mask,
		ch_1_int_err_mask, ch_1_int_tc_mask, ch_1_en};
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_1_int_tc_mask	<= 1'b0;
		ch_1_int_err_mask	<= 1'b0;
		ch_1_int_abt_mask	<= 1'b0;
		ch_1_dst_req_sel	<= 5'b0;
		ch_1_src_req_sel	<= 5'b0;
		ch_1_dst_addr_ctl	<= 2'b0;
		ch_1_src_addr_ctl	<= 2'b0;
		ch_1_dst_mode		<= 1'b0;
		ch_1_src_mode		<= 1'b0;
		ch_1_dst_width		<= 2'b0;
		ch_1_src_width		<= 2'b0;
		ch_1_src_burst_size	<= 3'b0;
		ch_1_priority		<= 1'b0;
	end
	else if (s44 & hreadyin) begin
		ch_1_int_tc_mask	<= hwdata[1];
		ch_1_int_err_mask	<= hwdata[2];
		ch_1_int_abt_mask	<= hwdata[3];
		ch_1_dst_req_sel	<= {hwdata[30], hwdata[7:4]};
		ch_1_src_req_sel	<= {hwdata[31], hwdata[11:8]};
		ch_1_dst_addr_ctl	<= hwdata[13:12];
		ch_1_src_addr_ctl	<= hwdata[15:14];
		ch_1_dst_mode		<= hwdata[16];
		ch_1_src_mode		<= hwdata[17];
		ch_1_dst_width		<= hwdata[19:18];
		ch_1_src_width		<= hwdata[21:20];
		ch_1_src_burst_size	<= hwdata[24:22];
		ch_1_priority		<= hwdata[29];
	end
	else if (dma_ch_1_ctl_wen) begin
		ch_1_int_tc_mask	<= dma_ch_ctl_wdata[1];
		ch_1_int_err_mask	<= dma_ch_ctl_wdata[2];
		ch_1_int_abt_mask	<= dma_ch_ctl_wdata[3];
		ch_1_dst_req_sel	<= {dma_ch_ctl_wdata[30], dma_ch_ctl_wdata[7:4]};
		ch_1_src_req_sel	<= {dma_ch_ctl_wdata[31], dma_ch_ctl_wdata[11:8]};
		ch_1_dst_addr_ctl	<= dma_ch_ctl_wdata[13:12];
		ch_1_src_addr_ctl	<= dma_ch_ctl_wdata[15:14];
		ch_1_dst_mode		<= dma_ch_ctl_wdata[16];
		ch_1_src_mode		<= dma_ch_ctl_wdata[17];
		ch_1_dst_width		<= dma_ch_ctl_wdata[19:18];
		ch_1_src_width		<= dma_ch_ctl_wdata[21:20];
		ch_1_src_burst_size	<= dma_ch_ctl_wdata[24:22];
		ch_1_priority		<= dma_ch_ctl_wdata[29];
	end
end
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_1_en			<= 1'b0;
	end
	else if (s44 & hreadyin) begin
		ch_1_en			<= hwdata[0];
	end
	else if (dma_ch_1_en_wen | dma_soft_reset) begin
		ch_1_en			<= 1'b0;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_1_src_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s45 & hreadyin) begin
		ch_1_src_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_1_src_addr_wen) begin
		ch_1_src_addr 	<= dma_ch_src_addr_wdata;
	end
end
assign s50 = {{(33-ADDR_WIDTH){1'b0}}, ch_1_src_addr};

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_1_dst_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s46 & hreadyin) begin
		ch_1_dst_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_1_dst_addr_wen) begin
		ch_1_dst_addr 	<= dma_ch_dst_addr_wdata;
	end
end
assign s51 = {{(33-ADDR_WIDTH){1'b0}}, ch_1_dst_addr};

`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s52	<= {ADDR_WIDTH-2{1'b0}};
	end
	else if (s47 & hreadyin) begin
		s52	<= hwdata[ADDR_MSB:2];
	end
	else if (dma_ch_1_llp_wen) begin
		s52	<= dma_ch_llp_wdata[ADDR_MSB:2];
	end
end

assign ch_1_llp	= {s52, 2'b0};
assign s53 = {{(33-ADDR_WIDTH){1'b0}}, ch_1_llp};
`endif

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_1_tts	<= 22'b0;
	end
	else if (s48 & hreadyin) begin
		ch_1_tts 	<= hwdata[21:0];
	end
	else if (dma_ch_1_tts_wen) begin
		ch_1_tts 	<= dma_ch_tts_wdata[21:0];
	end
end
`endif
`ifdef DMAC_CONFIG_CH2

assign s71 = {ch_2_src_req_sel[4], ch_2_dst_req_sel[4],
		ch_2_priority, 4'b0, ch_2_src_burst_size, ch_2_src_width, ch_2_dst_width,
		ch_2_src_mode, ch_2_dst_mode, ch_2_src_addr_ctl, ch_2_dst_addr_ctl,
		ch_2_src_req_sel[3:0], ch_2_dst_req_sel[3:0], ch_2_int_abt_mask,
		ch_2_int_err_mask, ch_2_int_tc_mask, ch_2_en};
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_2_int_tc_mask	<= 1'b0;
		ch_2_int_err_mask	<= 1'b0;
		ch_2_int_abt_mask	<= 1'b0;
		ch_2_dst_req_sel	<= 5'b0;
		ch_2_src_req_sel	<= 5'b0;
		ch_2_dst_addr_ctl	<= 2'b0;
		ch_2_src_addr_ctl	<= 2'b0;
		ch_2_dst_mode		<= 1'b0;
		ch_2_src_mode		<= 1'b0;
		ch_2_dst_width		<= 2'b0;
		ch_2_src_width		<= 2'b0;
		ch_2_src_burst_size	<= 3'b0;
		ch_2_priority		<= 1'b0;
	end
	else if (s66 & hreadyin) begin
		ch_2_int_tc_mask	<= hwdata[1];
		ch_2_int_err_mask	<= hwdata[2];
		ch_2_int_abt_mask	<= hwdata[3];
		ch_2_dst_req_sel	<= {hwdata[30], hwdata[7:4]};
		ch_2_src_req_sel	<= {hwdata[31], hwdata[11:8]};
		ch_2_dst_addr_ctl	<= hwdata[13:12];
		ch_2_src_addr_ctl	<= hwdata[15:14];
		ch_2_dst_mode		<= hwdata[16];
		ch_2_src_mode		<= hwdata[17];
		ch_2_dst_width		<= hwdata[19:18];
		ch_2_src_width		<= hwdata[21:20];
		ch_2_src_burst_size	<= hwdata[24:22];
		ch_2_priority		<= hwdata[29];
	end
	else if (dma_ch_2_ctl_wen) begin
		ch_2_int_tc_mask	<= dma_ch_ctl_wdata[1];
		ch_2_int_err_mask	<= dma_ch_ctl_wdata[2];
		ch_2_int_abt_mask	<= dma_ch_ctl_wdata[3];
		ch_2_dst_req_sel	<= {dma_ch_ctl_wdata[30], dma_ch_ctl_wdata[7:4]};
		ch_2_src_req_sel	<= {dma_ch_ctl_wdata[31], dma_ch_ctl_wdata[11:8]};
		ch_2_dst_addr_ctl	<= dma_ch_ctl_wdata[13:12];
		ch_2_src_addr_ctl	<= dma_ch_ctl_wdata[15:14];
		ch_2_dst_mode		<= dma_ch_ctl_wdata[16];
		ch_2_src_mode		<= dma_ch_ctl_wdata[17];
		ch_2_dst_width		<= dma_ch_ctl_wdata[19:18];
		ch_2_src_width		<= dma_ch_ctl_wdata[21:20];
		ch_2_src_burst_size	<= dma_ch_ctl_wdata[24:22];
		ch_2_priority		<= dma_ch_ctl_wdata[29];
	end
end
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_2_en			<= 1'b0;
	end
	else if (s66 & hreadyin) begin
		ch_2_en			<= hwdata[0];
	end
	else if (dma_ch_2_en_wen | dma_soft_reset) begin
		ch_2_en			<= 1'b0;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_2_src_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s67 & hreadyin) begin
		ch_2_src_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_2_src_addr_wen) begin
		ch_2_src_addr 	<= dma_ch_src_addr_wdata;
	end
end
assign s72 = {{(33-ADDR_WIDTH){1'b0}}, ch_2_src_addr};

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_2_dst_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s68 & hreadyin) begin
		ch_2_dst_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_2_dst_addr_wen) begin
		ch_2_dst_addr 	<= dma_ch_dst_addr_wdata;
	end
end
assign s73 = {{(33-ADDR_WIDTH){1'b0}}, ch_2_dst_addr};

`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s74	<= {ADDR_WIDTH-2{1'b0}};
	end
	else if (s69 & hreadyin) begin
		s74	<= hwdata[ADDR_MSB:2];
	end
	else if (dma_ch_2_llp_wen) begin
		s74	<= dma_ch_llp_wdata[ADDR_MSB:2];
	end
end

assign ch_2_llp	= {s74, 2'b0};
assign s75 = {{(33-ADDR_WIDTH){1'b0}}, ch_2_llp};
`endif

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_2_tts	<= 22'b0;
	end
	else if (s70 & hreadyin) begin
		ch_2_tts 	<= hwdata[21:0];
	end
	else if (dma_ch_2_tts_wen) begin
		ch_2_tts 	<= dma_ch_tts_wdata[21:0];
	end
end
`endif
`ifdef DMAC_CONFIG_CH3

assign s93 = {ch_3_src_req_sel[4], ch_3_dst_req_sel[4],
		ch_3_priority, 4'b0, ch_3_src_burst_size, ch_3_src_width, ch_3_dst_width,
		ch_3_src_mode, ch_3_dst_mode, ch_3_src_addr_ctl, ch_3_dst_addr_ctl,
		ch_3_src_req_sel[3:0], ch_3_dst_req_sel[3:0], ch_3_int_abt_mask,
		ch_3_int_err_mask, ch_3_int_tc_mask, ch_3_en};
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_3_int_tc_mask	<= 1'b0;
		ch_3_int_err_mask	<= 1'b0;
		ch_3_int_abt_mask	<= 1'b0;
		ch_3_dst_req_sel	<= 5'b0;
		ch_3_src_req_sel	<= 5'b0;
		ch_3_dst_addr_ctl	<= 2'b0;
		ch_3_src_addr_ctl	<= 2'b0;
		ch_3_dst_mode		<= 1'b0;
		ch_3_src_mode		<= 1'b0;
		ch_3_dst_width		<= 2'b0;
		ch_3_src_width		<= 2'b0;
		ch_3_src_burst_size	<= 3'b0;
		ch_3_priority		<= 1'b0;
	end
	else if (s88 & hreadyin) begin
		ch_3_int_tc_mask	<= hwdata[1];
		ch_3_int_err_mask	<= hwdata[2];
		ch_3_int_abt_mask	<= hwdata[3];
		ch_3_dst_req_sel	<= {hwdata[30], hwdata[7:4]};
		ch_3_src_req_sel	<= {hwdata[31], hwdata[11:8]};
		ch_3_dst_addr_ctl	<= hwdata[13:12];
		ch_3_src_addr_ctl	<= hwdata[15:14];
		ch_3_dst_mode		<= hwdata[16];
		ch_3_src_mode		<= hwdata[17];
		ch_3_dst_width		<= hwdata[19:18];
		ch_3_src_width		<= hwdata[21:20];
		ch_3_src_burst_size	<= hwdata[24:22];
		ch_3_priority		<= hwdata[29];
	end
	else if (dma_ch_3_ctl_wen) begin
		ch_3_int_tc_mask	<= dma_ch_ctl_wdata[1];
		ch_3_int_err_mask	<= dma_ch_ctl_wdata[2];
		ch_3_int_abt_mask	<= dma_ch_ctl_wdata[3];
		ch_3_dst_req_sel	<= {dma_ch_ctl_wdata[30], dma_ch_ctl_wdata[7:4]};
		ch_3_src_req_sel	<= {dma_ch_ctl_wdata[31], dma_ch_ctl_wdata[11:8]};
		ch_3_dst_addr_ctl	<= dma_ch_ctl_wdata[13:12];
		ch_3_src_addr_ctl	<= dma_ch_ctl_wdata[15:14];
		ch_3_dst_mode		<= dma_ch_ctl_wdata[16];
		ch_3_src_mode		<= dma_ch_ctl_wdata[17];
		ch_3_dst_width		<= dma_ch_ctl_wdata[19:18];
		ch_3_src_width		<= dma_ch_ctl_wdata[21:20];
		ch_3_src_burst_size	<= dma_ch_ctl_wdata[24:22];
		ch_3_priority		<= dma_ch_ctl_wdata[29];
	end
end
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_3_en			<= 1'b0;
	end
	else if (s88 & hreadyin) begin
		ch_3_en			<= hwdata[0];
	end
	else if (dma_ch_3_en_wen | dma_soft_reset) begin
		ch_3_en			<= 1'b0;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_3_src_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s89 & hreadyin) begin
		ch_3_src_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_3_src_addr_wen) begin
		ch_3_src_addr 	<= dma_ch_src_addr_wdata;
	end
end
assign s94 = {{(33-ADDR_WIDTH){1'b0}}, ch_3_src_addr};

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_3_dst_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s90 & hreadyin) begin
		ch_3_dst_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_3_dst_addr_wen) begin
		ch_3_dst_addr 	<= dma_ch_dst_addr_wdata;
	end
end
assign s95 = {{(33-ADDR_WIDTH){1'b0}}, ch_3_dst_addr};

`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s96	<= {ADDR_WIDTH-2{1'b0}};
	end
	else if (s91 & hreadyin) begin
		s96	<= hwdata[ADDR_MSB:2];
	end
	else if (dma_ch_3_llp_wen) begin
		s96	<= dma_ch_llp_wdata[ADDR_MSB:2];
	end
end

assign ch_3_llp	= {s96, 2'b0};
assign s97 = {{(33-ADDR_WIDTH){1'b0}}, ch_3_llp};
`endif

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_3_tts	<= 22'b0;
	end
	else if (s92 & hreadyin) begin
		ch_3_tts 	<= hwdata[21:0];
	end
	else if (dma_ch_3_tts_wen) begin
		ch_3_tts 	<= dma_ch_tts_wdata[21:0];
	end
end
`endif
`ifdef DMAC_CONFIG_CH4

assign s115 = {ch_4_src_req_sel[4], ch_4_dst_req_sel[4],
		ch_4_priority, 4'b0, ch_4_src_burst_size, ch_4_src_width, ch_4_dst_width,
		ch_4_src_mode, ch_4_dst_mode, ch_4_src_addr_ctl, ch_4_dst_addr_ctl,
		ch_4_src_req_sel[3:0], ch_4_dst_req_sel[3:0], ch_4_int_abt_mask,
		ch_4_int_err_mask, ch_4_int_tc_mask, ch_4_en};
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_4_int_tc_mask	<= 1'b0;
		ch_4_int_err_mask	<= 1'b0;
		ch_4_int_abt_mask	<= 1'b0;
		ch_4_dst_req_sel	<= 5'b0;
		ch_4_src_req_sel	<= 5'b0;
		ch_4_dst_addr_ctl	<= 2'b0;
		ch_4_src_addr_ctl	<= 2'b0;
		ch_4_dst_mode		<= 1'b0;
		ch_4_src_mode		<= 1'b0;
		ch_4_dst_width		<= 2'b0;
		ch_4_src_width		<= 2'b0;
		ch_4_src_burst_size	<= 3'b0;
		ch_4_priority		<= 1'b0;
	end
	else if (s110 & hreadyin) begin
		ch_4_int_tc_mask	<= hwdata[1];
		ch_4_int_err_mask	<= hwdata[2];
		ch_4_int_abt_mask	<= hwdata[3];
		ch_4_dst_req_sel	<= {hwdata[30], hwdata[7:4]};
		ch_4_src_req_sel	<= {hwdata[31], hwdata[11:8]};
		ch_4_dst_addr_ctl	<= hwdata[13:12];
		ch_4_src_addr_ctl	<= hwdata[15:14];
		ch_4_dst_mode		<= hwdata[16];
		ch_4_src_mode		<= hwdata[17];
		ch_4_dst_width		<= hwdata[19:18];
		ch_4_src_width		<= hwdata[21:20];
		ch_4_src_burst_size	<= hwdata[24:22];
		ch_4_priority		<= hwdata[29];
	end
	else if (dma_ch_4_ctl_wen) begin
		ch_4_int_tc_mask	<= dma_ch_ctl_wdata[1];
		ch_4_int_err_mask	<= dma_ch_ctl_wdata[2];
		ch_4_int_abt_mask	<= dma_ch_ctl_wdata[3];
		ch_4_dst_req_sel	<= {dma_ch_ctl_wdata[30], dma_ch_ctl_wdata[7:4]};
		ch_4_src_req_sel	<= {dma_ch_ctl_wdata[31], dma_ch_ctl_wdata[11:8]};
		ch_4_dst_addr_ctl	<= dma_ch_ctl_wdata[13:12];
		ch_4_src_addr_ctl	<= dma_ch_ctl_wdata[15:14];
		ch_4_dst_mode		<= dma_ch_ctl_wdata[16];
		ch_4_src_mode		<= dma_ch_ctl_wdata[17];
		ch_4_dst_width		<= dma_ch_ctl_wdata[19:18];
		ch_4_src_width		<= dma_ch_ctl_wdata[21:20];
		ch_4_src_burst_size	<= dma_ch_ctl_wdata[24:22];
		ch_4_priority		<= dma_ch_ctl_wdata[29];
	end
end
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_4_en			<= 1'b0;
	end
	else if (s110 & hreadyin) begin
		ch_4_en			<= hwdata[0];
	end
	else if (dma_ch_4_en_wen | dma_soft_reset) begin
		ch_4_en			<= 1'b0;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_4_src_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s111 & hreadyin) begin
		ch_4_src_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_4_src_addr_wen) begin
		ch_4_src_addr 	<= dma_ch_src_addr_wdata;
	end
end
assign s116 = {{(33-ADDR_WIDTH){1'b0}}, ch_4_src_addr};

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_4_dst_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s112 & hreadyin) begin
		ch_4_dst_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_4_dst_addr_wen) begin
		ch_4_dst_addr 	<= dma_ch_dst_addr_wdata;
	end
end
assign s117 = {{(33-ADDR_WIDTH){1'b0}}, ch_4_dst_addr};

`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s118	<= {ADDR_WIDTH-2{1'b0}};
	end
	else if (s113 & hreadyin) begin
		s118	<= hwdata[ADDR_MSB:2];
	end
	else if (dma_ch_4_llp_wen) begin
		s118	<= dma_ch_llp_wdata[ADDR_MSB:2];
	end
end

assign ch_4_llp	= {s118, 2'b0};
assign s119 = {{(33-ADDR_WIDTH){1'b0}}, ch_4_llp};
`endif

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_4_tts	<= 22'b0;
	end
	else if (s114 & hreadyin) begin
		ch_4_tts 	<= hwdata[21:0];
	end
	else if (dma_ch_4_tts_wen) begin
		ch_4_tts 	<= dma_ch_tts_wdata[21:0];
	end
end
`endif
`ifdef DMAC_CONFIG_CH5

assign s137 = {ch_5_src_req_sel[4], ch_5_dst_req_sel[4],
		ch_5_priority, 4'b0, ch_5_src_burst_size, ch_5_src_width, ch_5_dst_width,
		ch_5_src_mode, ch_5_dst_mode, ch_5_src_addr_ctl, ch_5_dst_addr_ctl,
		ch_5_src_req_sel[3:0], ch_5_dst_req_sel[3:0], ch_5_int_abt_mask,
		ch_5_int_err_mask, ch_5_int_tc_mask, ch_5_en};
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_5_int_tc_mask	<= 1'b0;
		ch_5_int_err_mask	<= 1'b0;
		ch_5_int_abt_mask	<= 1'b0;
		ch_5_dst_req_sel	<= 5'b0;
		ch_5_src_req_sel	<= 5'b0;
		ch_5_dst_addr_ctl	<= 2'b0;
		ch_5_src_addr_ctl	<= 2'b0;
		ch_5_dst_mode		<= 1'b0;
		ch_5_src_mode		<= 1'b0;
		ch_5_dst_width		<= 2'b0;
		ch_5_src_width		<= 2'b0;
		ch_5_src_burst_size	<= 3'b0;
		ch_5_priority		<= 1'b0;
	end
	else if (s132 & hreadyin) begin
		ch_5_int_tc_mask	<= hwdata[1];
		ch_5_int_err_mask	<= hwdata[2];
		ch_5_int_abt_mask	<= hwdata[3];
		ch_5_dst_req_sel	<= {hwdata[30], hwdata[7:4]};
		ch_5_src_req_sel	<= {hwdata[31], hwdata[11:8]};
		ch_5_dst_addr_ctl	<= hwdata[13:12];
		ch_5_src_addr_ctl	<= hwdata[15:14];
		ch_5_dst_mode		<= hwdata[16];
		ch_5_src_mode		<= hwdata[17];
		ch_5_dst_width		<= hwdata[19:18];
		ch_5_src_width		<= hwdata[21:20];
		ch_5_src_burst_size	<= hwdata[24:22];
		ch_5_priority		<= hwdata[29];
	end
	else if (dma_ch_5_ctl_wen) begin
		ch_5_int_tc_mask	<= dma_ch_ctl_wdata[1];
		ch_5_int_err_mask	<= dma_ch_ctl_wdata[2];
		ch_5_int_abt_mask	<= dma_ch_ctl_wdata[3];
		ch_5_dst_req_sel	<= {dma_ch_ctl_wdata[30], dma_ch_ctl_wdata[7:4]};
		ch_5_src_req_sel	<= {dma_ch_ctl_wdata[31], dma_ch_ctl_wdata[11:8]};
		ch_5_dst_addr_ctl	<= dma_ch_ctl_wdata[13:12];
		ch_5_src_addr_ctl	<= dma_ch_ctl_wdata[15:14];
		ch_5_dst_mode		<= dma_ch_ctl_wdata[16];
		ch_5_src_mode		<= dma_ch_ctl_wdata[17];
		ch_5_dst_width		<= dma_ch_ctl_wdata[19:18];
		ch_5_src_width		<= dma_ch_ctl_wdata[21:20];
		ch_5_src_burst_size	<= dma_ch_ctl_wdata[24:22];
		ch_5_priority		<= dma_ch_ctl_wdata[29];
	end
end
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_5_en			<= 1'b0;
	end
	else if (s132 & hreadyin) begin
		ch_5_en			<= hwdata[0];
	end
	else if (dma_ch_5_en_wen | dma_soft_reset) begin
		ch_5_en			<= 1'b0;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_5_src_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s133 & hreadyin) begin
		ch_5_src_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_5_src_addr_wen) begin
		ch_5_src_addr 	<= dma_ch_src_addr_wdata;
	end
end
assign s138 = {{(33-ADDR_WIDTH){1'b0}}, ch_5_src_addr};

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_5_dst_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s134 & hreadyin) begin
		ch_5_dst_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_5_dst_addr_wen) begin
		ch_5_dst_addr 	<= dma_ch_dst_addr_wdata;
	end
end
assign s139 = {{(33-ADDR_WIDTH){1'b0}}, ch_5_dst_addr};

`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s140	<= {ADDR_WIDTH-2{1'b0}};
	end
	else if (s135 & hreadyin) begin
		s140	<= hwdata[ADDR_MSB:2];
	end
	else if (dma_ch_5_llp_wen) begin
		s140	<= dma_ch_llp_wdata[ADDR_MSB:2];
	end
end

assign ch_5_llp	= {s140, 2'b0};
assign s141 = {{(33-ADDR_WIDTH){1'b0}}, ch_5_llp};
`endif

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_5_tts	<= 22'b0;
	end
	else if (s136 & hreadyin) begin
		ch_5_tts 	<= hwdata[21:0];
	end
	else if (dma_ch_5_tts_wen) begin
		ch_5_tts 	<= dma_ch_tts_wdata[21:0];
	end
end
`endif
`ifdef DMAC_CONFIG_CH6

assign s159 = {ch_6_src_req_sel[4], ch_6_dst_req_sel[4],
		ch_6_priority, 4'b0, ch_6_src_burst_size, ch_6_src_width, ch_6_dst_width,
		ch_6_src_mode, ch_6_dst_mode, ch_6_src_addr_ctl, ch_6_dst_addr_ctl,
		ch_6_src_req_sel[3:0], ch_6_dst_req_sel[3:0], ch_6_int_abt_mask,
		ch_6_int_err_mask, ch_6_int_tc_mask, ch_6_en};
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_6_int_tc_mask	<= 1'b0;
		ch_6_int_err_mask	<= 1'b0;
		ch_6_int_abt_mask	<= 1'b0;
		ch_6_dst_req_sel	<= 5'b0;
		ch_6_src_req_sel	<= 5'b0;
		ch_6_dst_addr_ctl	<= 2'b0;
		ch_6_src_addr_ctl	<= 2'b0;
		ch_6_dst_mode		<= 1'b0;
		ch_6_src_mode		<= 1'b0;
		ch_6_dst_width		<= 2'b0;
		ch_6_src_width		<= 2'b0;
		ch_6_src_burst_size	<= 3'b0;
		ch_6_priority		<= 1'b0;
	end
	else if (s154 & hreadyin) begin
		ch_6_int_tc_mask	<= hwdata[1];
		ch_6_int_err_mask	<= hwdata[2];
		ch_6_int_abt_mask	<= hwdata[3];
		ch_6_dst_req_sel	<= {hwdata[30], hwdata[7:4]};
		ch_6_src_req_sel	<= {hwdata[31], hwdata[11:8]};
		ch_6_dst_addr_ctl	<= hwdata[13:12];
		ch_6_src_addr_ctl	<= hwdata[15:14];
		ch_6_dst_mode		<= hwdata[16];
		ch_6_src_mode		<= hwdata[17];
		ch_6_dst_width		<= hwdata[19:18];
		ch_6_src_width		<= hwdata[21:20];
		ch_6_src_burst_size	<= hwdata[24:22];
		ch_6_priority		<= hwdata[29];
	end
	else if (dma_ch_6_ctl_wen) begin
		ch_6_int_tc_mask	<= dma_ch_ctl_wdata[1];
		ch_6_int_err_mask	<= dma_ch_ctl_wdata[2];
		ch_6_int_abt_mask	<= dma_ch_ctl_wdata[3];
		ch_6_dst_req_sel	<= {dma_ch_ctl_wdata[30], dma_ch_ctl_wdata[7:4]};
		ch_6_src_req_sel	<= {dma_ch_ctl_wdata[31], dma_ch_ctl_wdata[11:8]};
		ch_6_dst_addr_ctl	<= dma_ch_ctl_wdata[13:12];
		ch_6_src_addr_ctl	<= dma_ch_ctl_wdata[15:14];
		ch_6_dst_mode		<= dma_ch_ctl_wdata[16];
		ch_6_src_mode		<= dma_ch_ctl_wdata[17];
		ch_6_dst_width		<= dma_ch_ctl_wdata[19:18];
		ch_6_src_width		<= dma_ch_ctl_wdata[21:20];
		ch_6_src_burst_size	<= dma_ch_ctl_wdata[24:22];
		ch_6_priority		<= dma_ch_ctl_wdata[29];
	end
end
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_6_en			<= 1'b0;
	end
	else if (s154 & hreadyin) begin
		ch_6_en			<= hwdata[0];
	end
	else if (dma_ch_6_en_wen | dma_soft_reset) begin
		ch_6_en			<= 1'b0;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_6_src_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s155 & hreadyin) begin
		ch_6_src_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_6_src_addr_wen) begin
		ch_6_src_addr 	<= dma_ch_src_addr_wdata;
	end
end
assign s160 = {{(33-ADDR_WIDTH){1'b0}}, ch_6_src_addr};

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_6_dst_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s156 & hreadyin) begin
		ch_6_dst_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_6_dst_addr_wen) begin
		ch_6_dst_addr 	<= dma_ch_dst_addr_wdata;
	end
end
assign s161 = {{(33-ADDR_WIDTH){1'b0}}, ch_6_dst_addr};

`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s162	<= {ADDR_WIDTH-2{1'b0}};
	end
	else if (s157 & hreadyin) begin
		s162	<= hwdata[ADDR_MSB:2];
	end
	else if (dma_ch_6_llp_wen) begin
		s162	<= dma_ch_llp_wdata[ADDR_MSB:2];
	end
end

assign ch_6_llp	= {s162, 2'b0};
assign s163 = {{(33-ADDR_WIDTH){1'b0}}, ch_6_llp};
`endif

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_6_tts	<= 22'b0;
	end
	else if (s158 & hreadyin) begin
		ch_6_tts 	<= hwdata[21:0];
	end
	else if (dma_ch_6_tts_wen) begin
		ch_6_tts 	<= dma_ch_tts_wdata[21:0];
	end
end
`endif
`ifdef DMAC_CONFIG_CH7

assign s181 = {ch_7_src_req_sel[4], ch_7_dst_req_sel[4],
		ch_7_priority, 4'b0, ch_7_src_burst_size, ch_7_src_width, ch_7_dst_width,
		ch_7_src_mode, ch_7_dst_mode, ch_7_src_addr_ctl, ch_7_dst_addr_ctl,
		ch_7_src_req_sel[3:0], ch_7_dst_req_sel[3:0], ch_7_int_abt_mask,
		ch_7_int_err_mask, ch_7_int_tc_mask, ch_7_en};
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_7_int_tc_mask	<= 1'b0;
		ch_7_int_err_mask	<= 1'b0;
		ch_7_int_abt_mask	<= 1'b0;
		ch_7_dst_req_sel	<= 5'b0;
		ch_7_src_req_sel	<= 5'b0;
		ch_7_dst_addr_ctl	<= 2'b0;
		ch_7_src_addr_ctl	<= 2'b0;
		ch_7_dst_mode		<= 1'b0;
		ch_7_src_mode		<= 1'b0;
		ch_7_dst_width		<= 2'b0;
		ch_7_src_width		<= 2'b0;
		ch_7_src_burst_size	<= 3'b0;
		ch_7_priority		<= 1'b0;
	end
	else if (s176 & hreadyin) begin
		ch_7_int_tc_mask	<= hwdata[1];
		ch_7_int_err_mask	<= hwdata[2];
		ch_7_int_abt_mask	<= hwdata[3];
		ch_7_dst_req_sel	<= {hwdata[30], hwdata[7:4]};
		ch_7_src_req_sel	<= {hwdata[31], hwdata[11:8]};
		ch_7_dst_addr_ctl	<= hwdata[13:12];
		ch_7_src_addr_ctl	<= hwdata[15:14];
		ch_7_dst_mode		<= hwdata[16];
		ch_7_src_mode		<= hwdata[17];
		ch_7_dst_width		<= hwdata[19:18];
		ch_7_src_width		<= hwdata[21:20];
		ch_7_src_burst_size	<= hwdata[24:22];
		ch_7_priority		<= hwdata[29];
	end
	else if (dma_ch_7_ctl_wen) begin
		ch_7_int_tc_mask	<= dma_ch_ctl_wdata[1];
		ch_7_int_err_mask	<= dma_ch_ctl_wdata[2];
		ch_7_int_abt_mask	<= dma_ch_ctl_wdata[3];
		ch_7_dst_req_sel	<= {dma_ch_ctl_wdata[30], dma_ch_ctl_wdata[7:4]};
		ch_7_src_req_sel	<= {dma_ch_ctl_wdata[31], dma_ch_ctl_wdata[11:8]};
		ch_7_dst_addr_ctl	<= dma_ch_ctl_wdata[13:12];
		ch_7_src_addr_ctl	<= dma_ch_ctl_wdata[15:14];
		ch_7_dst_mode		<= dma_ch_ctl_wdata[16];
		ch_7_src_mode		<= dma_ch_ctl_wdata[17];
		ch_7_dst_width		<= dma_ch_ctl_wdata[19:18];
		ch_7_src_width		<= dma_ch_ctl_wdata[21:20];
		ch_7_src_burst_size	<= dma_ch_ctl_wdata[24:22];
		ch_7_priority		<= dma_ch_ctl_wdata[29];
	end
end
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_7_en			<= 1'b0;
	end
	else if (s176 & hreadyin) begin
		ch_7_en			<= hwdata[0];
	end
	else if (dma_ch_7_en_wen | dma_soft_reset) begin
		ch_7_en			<= 1'b0;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_7_src_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s177 & hreadyin) begin
		ch_7_src_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_7_src_addr_wen) begin
		ch_7_src_addr 	<= dma_ch_src_addr_wdata;
	end
end
assign s182 = {{(33-ADDR_WIDTH){1'b0}}, ch_7_src_addr};

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_7_dst_addr	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s178 & hreadyin) begin
		ch_7_dst_addr 	<= hwdata[ADDR_MSB:0];
	end
	else if (dma_ch_7_dst_addr_wen) begin
		ch_7_dst_addr 	<= dma_ch_dst_addr_wdata;
	end
end
assign s183 = {{(33-ADDR_WIDTH){1'b0}}, ch_7_dst_addr};

`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s184	<= {ADDR_WIDTH-2{1'b0}};
	end
	else if (s179 & hreadyin) begin
		s184	<= hwdata[ADDR_MSB:2];
	end
	else if (dma_ch_7_llp_wen) begin
		s184	<= dma_ch_llp_wdata[ADDR_MSB:2];
	end
end

assign ch_7_llp	= {s184, 2'b0};
assign s185 = {{(33-ADDR_WIDTH){1'b0}}, ch_7_llp};
`endif

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		ch_7_tts	<= 22'b0;
	end
	else if (s180 & hreadyin) begin
		ch_7_tts 	<= hwdata[21:0];
	end
	else if (dma_ch_7_tts_wen) begin
		ch_7_tts 	<= dma_ch_tts_wdata[21:0];
	end
end
`endif
assign s0 =	(({32{s1}} & `ATCDMAC100_PRODUCT_ID) |
			({32{s2}} & {`ATCDMAC100_CHAIN_TRANSFER_EXIST, `ATCDMAC100_REQ_SYNC_EXIST, 14'h0, s16, s15, s14}) |
			`ifdef DMAC_CONFIG_CH0
			({32{s17}} & s27) |
			({32{s18}} & s28[31:0]) |
			({32{s19}} & s29[31:0]) |
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			({32{s20}} & s31[31:0]) |
`endif
			({32{s21}} & {10'b0, ch_0_tts}) |
			`endif
			`ifdef DMAC_CONFIG_CH1
			({32{s39}} & s49) |
			({32{s40}} & s50[31:0]) |
			({32{s41}} & s51[31:0]) |
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			({32{s42}} & s53[31:0]) |
`endif
			({32{s43}} & {10'b0, ch_1_tts}) |
			`endif
			`ifdef DMAC_CONFIG_CH2
			({32{s61}} & s71) |
			({32{s62}} & s72[31:0]) |
			({32{s63}} & s73[31:0]) |
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			({32{s64}} & s75[31:0]) |
`endif
			({32{s65}} & {10'b0, ch_2_tts}) |
			`endif
			`ifdef DMAC_CONFIG_CH3
			({32{s83}} & s93) |
			({32{s84}} & s94[31:0]) |
			({32{s85}} & s95[31:0]) |
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			({32{s86}} & s97[31:0]) |
`endif
			({32{s87}} & {10'b0, ch_3_tts}) |
			`endif
			`ifdef DMAC_CONFIG_CH4
			({32{s105}} & s115) |
			({32{s106}} & s116[31:0]) |
			({32{s107}} & s117[31:0]) |
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			({32{s108}} & s119[31:0]) |
`endif
			({32{s109}} & {10'b0, ch_4_tts}) |
			`endif
			`ifdef DMAC_CONFIG_CH5
			({32{s127}} & s137) |
			({32{s128}} & s138[31:0]) |
			({32{s129}} & s139[31:0]) |
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			({32{s130}} & s141[31:0]) |
`endif
			({32{s131}} & {10'b0, ch_5_tts}) |
			`endif
			`ifdef DMAC_CONFIG_CH6
			({32{s149}} & s159) |
			({32{s150}} & s160[31:0]) |
			({32{s151}} & s161[31:0]) |
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			({32{s152}} & s163[31:0]) |
`endif
			({32{s153}} & {10'b0, ch_6_tts}) |
			`endif
			`ifdef DMAC_CONFIG_CH7
			({32{s171}} & s181) |
			({32{s172}} & s182[31:0]) |
			({32{s173}} & s183[31:0]) |
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
			({32{s174}} & s185[31:0]) |
`endif
			({32{s175}} & {10'b0, ch_7_tts}) |
			`endif
			({32{s5}} & s12) |
			({32{s6}} & s13));

endmodule

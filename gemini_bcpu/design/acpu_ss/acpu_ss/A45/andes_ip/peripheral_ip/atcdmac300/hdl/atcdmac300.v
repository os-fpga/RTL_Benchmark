// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"


module atcdmac300 (
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	  m1_araddr,
	  m1_arburst,
	  m1_arcache,
	  m1_arid,
	  m1_arlen,
	  m1_arlock,
	  m1_arprot,
	  m1_arready,
	  m1_arsize,
	  m1_arvalid,
	  m1_awaddr,
	  m1_awburst,
	  m1_awcache,
	  m1_awid,
	  m1_awlen,
	  m1_awlock,
	  m1_awprot,
	  m1_awready,
	  m1_awsize,
	  m1_awvalid,
	  m1_bid,
	  m1_bready,
	  m1_bresp,
	  m1_bvalid,
	  m1_rdata,
	  m1_rid,
	  m1_rlast,
	  m1_rready,
	  m1_rresp,
	  m1_rvalid,
	  m1_wdata,
	  m1_wlast,
	  m1_wready,
	  m1_wstrb,
	  m1_wvalid,
`endif
	  paddr,
	  penable,
	  prdata,
	  pready,
	  psel,
	  pslverr,
	  pwdata,
	  pwrite,
	  pclk,
	  presetn,
	  m0_araddr,
	  m0_arburst,
	  m0_arcache,
	  m0_arid,
	  m0_arlen,
	  m0_arlock,
	  m0_arprot,
	  m0_arready,
	  m0_arsize,
	  m0_arvalid,
	  m0_awaddr,
	  m0_awburst,
	  m0_awcache,
	  m0_awid,
	  m0_awlen,
	  m0_awlock,
	  m0_awprot,
	  m0_awready,
	  m0_awsize,
	  m0_awvalid,
	  m0_bid,
	  m0_bready,
	  m0_bresp,
	  m0_bvalid,
	  m0_rdata,
	  m0_rid,
	  m0_rlast,
	  m0_rready,
	  m0_rresp,
	  m0_rvalid,
	  m0_wdata,
	  m0_wlast,
	  m0_wready,
	  m0_wstrb,
	  m0_wvalid,
	  aclk,
	  aresetn,
	  dma_ack,
	  dma_req,
	  dma_int
);

localparam ADDR_MSB	= `ATCDMAC300_ADDR_WIDTH - 1;
localparam ADDR_WEN_MSB	= ADDR_MSB > 31 ? 1 : 0;

`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output       [(`ATCDMAC300_ADDR_WIDTH-1):0] m1_araddr;
output                                [1:0] m1_arburst;
output                                [3:0] m1_arcache;
output                                [2:0] m1_arid;
output                                [7:0] m1_arlen;
output                                      m1_arlock;
output                                [2:0] m1_arprot;
input                                       m1_arready;
output                                [2:0] m1_arsize;
output                                      m1_arvalid;
output       [(`ATCDMAC300_ADDR_WIDTH-1):0] m1_awaddr;
output                                [1:0] m1_awburst;
output                                [3:0] m1_awcache;
output                                [2:0] m1_awid;
output                                [7:0] m1_awlen;
output                                      m1_awlock;
output                                [2:0] m1_awprot;
input                                       m1_awready;
output                                [2:0] m1_awsize;
output                                      m1_awvalid;
input                                 [2:0] m1_bid;
output                                      m1_bready;
input                                 [1:0] m1_bresp;
input                                       m1_bvalid;
input               [(`DMA_DATA_WIDTH-1):0] m1_rdata;
input                                 [2:0] m1_rid;
input                                       m1_rlast;
output                                      m1_rready;
input                                 [1:0] m1_rresp;
input                                       m1_rvalid;
output              [(`DMA_DATA_WIDTH-1):0] m1_wdata;
output                                      m1_wlast;
input                                       m1_wready;
output             [(`DMA_WSTRB_WIDTH-1):0] m1_wstrb;
output                                      m1_wvalid;
`endif
input                                [31:0] paddr;
input                                       penable;
output                               [31:0] prdata;
output                                      pready;
input                                       psel;
output                                      pslverr;
input                                [31:0] pwdata;
input                                       pwrite;
input                                       pclk;
input                                       presetn;
output       [(`ATCDMAC300_ADDR_WIDTH-1):0] m0_araddr;
output                                [1:0] m0_arburst;
output                                [3:0] m0_arcache;
output                                [2:0] m0_arid;
output                                [7:0] m0_arlen;
output                                      m0_arlock;
output                                [2:0] m0_arprot;
input                                       m0_arready;
output                                [2:0] m0_arsize;
output                                      m0_arvalid;
output       [(`ATCDMAC300_ADDR_WIDTH-1):0] m0_awaddr;
output                                [1:0] m0_awburst;
output                                [3:0] m0_awcache;
output                                [2:0] m0_awid;
output                                [7:0] m0_awlen;
output                                      m0_awlock;
output                                [2:0] m0_awprot;
input                                       m0_awready;
output                                [2:0] m0_awsize;
output                                      m0_awvalid;
input                                 [2:0] m0_bid;
output                                      m0_bready;
input                                 [1:0] m0_bresp;
input                                       m0_bvalid;
input               [(`DMA_DATA_WIDTH-1):0] m0_rdata;
input                                 [2:0] m0_rid;
input                                       m0_rlast;
output                                      m0_rready;
input                                 [1:0] m0_rresp;
input                                       m0_rvalid;
output              [(`DMA_DATA_WIDTH-1):0] m0_wdata;
output                                      m0_wlast;
input                                       m0_wready;
output             [(`DMA_WSTRB_WIDTH-1):0] m0_wstrb;
output                                      m0_wvalid;
input                                       aclk;
input                                       aresetn;
output      [(`ATCDMAC300_REQ_ACK_NUM-1):0] dma_ack;
input       [(`ATCDMAC300_REQ_ACK_NUM-1):0] dma_req;
output                                      dma_int;

`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
wire                                        s0;
wire                                        s1;
wire                                        s2;
wire                                        s3;
wire                [(`DMA_DATA_WIDTH-1):0] s4;
wire                                        s5;
wire                                        s6;
wire                                        dma0_ch_dst_bus_inf_idx;
wire                                        dma0_ch_src_bus_inf_idx;
wire                                  [1:0] dma0_ch_ctl_wdata_idx;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] s7;
wire                                        s8;
wire                                  [7:0] s9;
wire                                        s10;
wire                                  [2:0] s11;
wire                [(`DMA_DATA_WIDTH-1):0] s12;
wire                                        s13;
wire                                        ch_0_dst_bus_inf_idx;
wire                                        ch_0_src_bus_inf_idx;
wire                                        ch_1_dst_bus_inf_idx;
wire                                        ch_1_src_bus_inf_idx;
wire                                        ch_2_dst_bus_inf_idx;
wire                                        ch_2_src_bus_inf_idx;
wire                                        ch_3_dst_bus_inf_idx;
wire                                        ch_3_src_bus_inf_idx;
wire                                        ch_4_dst_bus_inf_idx;
wire                                        ch_4_src_bus_inf_idx;
wire                                        ch_5_dst_bus_inf_idx;
wire                                        ch_5_src_bus_inf_idx;
wire                                        ch_6_dst_bus_inf_idx;
wire                                        ch_6_src_bus_inf_idx;
wire                                        ch_7_dst_bus_inf_idx;
wire                                        ch_7_src_bus_inf_idx;
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] dma0_ch_llp;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] dma0_ch_llp_wdata;
wire                       [ADDR_WEN_MSB:0] dma0_ch_llp_wen;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_0_llp_reg;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_1_llp_reg;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_2_llp_reg;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_3_llp_reg;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_4_llp_reg;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_5_llp_reg;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_6_llp_reg;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] ch_7_llp_reg;
`endif
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
wire                                        s14;
wire                                        s15;
wire                                        s16;
wire                                        s17;
wire                [(`DMA_DATA_WIDTH-1):0] s18;
wire                                        s19;
wire                                        s20;
wire                                        dma1_arb_end;
wire                                        dma1_ch_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma1_ch_dst_addr;
wire                                  [1:0] dma1_ch_dst_addr_ctl;
wire                                        dma1_ch_dst_mode;
wire                                        dma1_ch_dst_request;
wire                                  [2:0] dma1_ch_dst_width;
wire                                        dma1_ch_int_abt_mask;
wire                                        dma1_ch_int_err_mask;
wire                                        dma1_ch_int_tc_mask;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma1_ch_src_addr;
wire                                  [1:0] dma1_ch_src_addr_ctl;
wire                                  [3:0] dma1_ch_src_burst_size;
wire                                        dma1_ch_src_mode;
wire                                        dma1_ch_src_request;
wire                                  [2:0] dma1_ch_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] dma1_ch_tts;
wire                                  [2:0] dma1_current_channel;
wire                                 [27:1] dma1_ch_ctl_wdata;
wire                                        dma1_ch_ctl_wdata_pri;
wire                                        dma1_ch_ctl_wen;
wire                                        dma1_ch_dst_ack;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma1_ch_dst_addr_wdata;
wire                       [ADDR_WEN_MSB:0] dma1_ch_dst_addr_wen;
wire                                        dma1_ch_en_wen;
wire                                        dma1_ch_err_wen;
wire                                        dma1_ch_int_wen;
wire                                        dma1_ch_src_ack;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma1_ch_src_addr_wdata;
wire                       [ADDR_WEN_MSB:0] dma1_ch_src_addr_wen;
wire                                        dma1_ch_tc_wen;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] dma1_ch_tts_wdata;
wire                                        dma1_ch_tts_wen;
wire                                        dma1_idle_state;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] s21;
wire                                        s22;
wire                                  [7:0] s23;
wire                                        s24;
wire                                  [2:0] s25;
wire                [(`DMA_DATA_WIDTH-1):0] s26;
wire                                        s27;
wire                                        dma1_mst_wr_mask;
`endif
`ifdef DMAC_CONFIG_CH0
wire                                        dma0_ch_0_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_0_dst_addr_wen;
wire                                        dma0_ch_0_en_wen;
wire                                        dma0_ch_0_err_wen;
wire                                        dma0_ch_0_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_0_src_addr_wen;
wire                                        dma0_ch_0_tc_wen;
wire                                        dma0_ch_0_tts_wen;
`endif
`ifdef DMAC_CONFIG_CH1
wire                                        dma0_ch_1_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_1_dst_addr_wen;
wire                                        dma0_ch_1_en_wen;
wire                                        dma0_ch_1_err_wen;
wire                                        dma0_ch_1_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_1_src_addr_wen;
wire                                        dma0_ch_1_tc_wen;
wire                                        dma0_ch_1_tts_wen;
`endif
`ifdef DMAC_CONFIG_CH2
wire                                        dma0_ch_2_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_2_dst_addr_wen;
wire                                        dma0_ch_2_en_wen;
wire                                        dma0_ch_2_err_wen;
wire                                        dma0_ch_2_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_2_src_addr_wen;
wire                                        dma0_ch_2_tc_wen;
wire                                        dma0_ch_2_tts_wen;
`endif
`ifdef DMAC_CONFIG_CH3
wire                                        dma0_ch_3_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_3_dst_addr_wen;
wire                                        dma0_ch_3_en_wen;
wire                                        dma0_ch_3_err_wen;
wire                                        dma0_ch_3_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_3_src_addr_wen;
wire                                        dma0_ch_3_tc_wen;
wire                                        dma0_ch_3_tts_wen;
`endif
`ifdef DMAC_CONFIG_CH4
wire                                        dma0_ch_4_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_4_dst_addr_wen;
wire                                        dma0_ch_4_en_wen;
wire                                        dma0_ch_4_err_wen;
wire                                        dma0_ch_4_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_4_src_addr_wen;
wire                                        dma0_ch_4_tc_wen;
wire                                        dma0_ch_4_tts_wen;
`endif
`ifdef DMAC_CONFIG_CH5
wire                                        dma0_ch_5_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_5_dst_addr_wen;
wire                                        dma0_ch_5_en_wen;
wire                                        dma0_ch_5_err_wen;
wire                                        dma0_ch_5_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_5_src_addr_wen;
wire                                        dma0_ch_5_tc_wen;
wire                                        dma0_ch_5_tts_wen;
`endif
`ifdef DMAC_CONFIG_CH6
wire                                        dma0_ch_6_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_6_dst_addr_wen;
wire                                        dma0_ch_6_en_wen;
wire                                        dma0_ch_6_err_wen;
wire                                        dma0_ch_6_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_6_src_addr_wen;
wire                                        dma0_ch_6_tc_wen;
wire                                        dma0_ch_6_tts_wen;
`endif
`ifdef DMAC_CONFIG_CH7
wire                                        dma0_ch_7_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_7_dst_addr_wen;
wire                                        dma0_ch_7_en_wen;
wire                                        dma0_ch_7_err_wen;
wire                                        dma0_ch_7_int_wen;
wire                       [ADDR_WEN_MSB:0] dma0_ch_7_src_addr_wen;
wire                                        dma0_ch_7_tc_wen;
wire                                        dma0_ch_7_tts_wen;
`endif
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire                                        dma0_ch_lld_bus_inf_idx;
wire                                        dma0_ch_llp_wdata_idx;
wire                                        ch_0_lld_bus_inf_idx;
wire                                        ch_1_lld_bus_inf_idx;
wire                                        ch_2_lld_bus_inf_idx;
wire                                        ch_3_lld_bus_inf_idx;
wire                                        ch_4_lld_bus_inf_idx;
wire                                        ch_5_lld_bus_inf_idx;
wire                                        ch_6_lld_bus_inf_idx;
wire                                        ch_7_lld_bus_inf_idx;
   `endif
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
   `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] dma1_ch_llp;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):3] dma1_ch_llp_wdata;
wire                       [ADDR_WEN_MSB:0] dma1_ch_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH0
wire                       [ADDR_WEN_MSB:0] dma0_ch_0_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH1
wire                       [ADDR_WEN_MSB:0] dma0_ch_1_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH2
wire                       [ADDR_WEN_MSB:0] dma0_ch_2_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH3
wire                       [ADDR_WEN_MSB:0] dma0_ch_3_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH4
wire                       [ADDR_WEN_MSB:0] dma0_ch_4_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH5
wire                       [ADDR_WEN_MSB:0] dma0_ch_5_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH6
wire                       [ADDR_WEN_MSB:0] dma0_ch_6_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH7
wire                       [ADDR_WEN_MSB:0] dma0_ch_7_llp_wen;
   `endif
`endif
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
   `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
wire                                        s28;
wire                                        s29;
wire                                        s30;
wire                                        s31;
wire                [(`DMA_DATA_WIDTH-1):0] s32;
wire                                        s33;
wire                                        s34;
wire                                        dma1_ch_dst_bus_inf_idx;
wire                                        dma1_ch_src_bus_inf_idx;
wire                                  [1:0] dma1_ch_ctl_wdata_idx;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] s35;
wire                                        s36;
wire                                  [7:0] s37;
wire                                        s38;
wire                                  [2:0] s39;
wire                [(`DMA_DATA_WIDTH-1):0] s40;
wire                                        s41;
   `endif
`endif
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
   `ifdef DMAC_CONFIG_CH0
wire                                        dma1_ch_0_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_0_dst_addr_wen;
wire                                        dma1_ch_0_en_wen;
wire                                        dma1_ch_0_err_wen;
wire                                        dma1_ch_0_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_0_src_addr_wen;
wire                                        dma1_ch_0_tc_wen;
wire                                        dma1_ch_0_tts_wen;
   `endif
   `ifdef DMAC_CONFIG_CH1
wire                                        dma1_ch_1_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_1_dst_addr_wen;
wire                                        dma1_ch_1_en_wen;
wire                                        dma1_ch_1_err_wen;
wire                                        dma1_ch_1_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_1_src_addr_wen;
wire                                        dma1_ch_1_tc_wen;
wire                                        dma1_ch_1_tts_wen;
   `endif
   `ifdef DMAC_CONFIG_CH2
wire                                        dma1_ch_2_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_2_dst_addr_wen;
wire                                        dma1_ch_2_en_wen;
wire                                        dma1_ch_2_err_wen;
wire                                        dma1_ch_2_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_2_src_addr_wen;
wire                                        dma1_ch_2_tc_wen;
wire                                        dma1_ch_2_tts_wen;
   `endif
   `ifdef DMAC_CONFIG_CH3
wire                                        dma1_ch_3_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_3_dst_addr_wen;
wire                                        dma1_ch_3_en_wen;
wire                                        dma1_ch_3_err_wen;
wire                                        dma1_ch_3_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_3_src_addr_wen;
wire                                        dma1_ch_3_tc_wen;
wire                                        dma1_ch_3_tts_wen;
   `endif
   `ifdef DMAC_CONFIG_CH4
wire                                        dma1_ch_4_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_4_dst_addr_wen;
wire                                        dma1_ch_4_en_wen;
wire                                        dma1_ch_4_err_wen;
wire                                        dma1_ch_4_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_4_src_addr_wen;
wire                                        dma1_ch_4_tc_wen;
wire                                        dma1_ch_4_tts_wen;
   `endif
   `ifdef DMAC_CONFIG_CH5
wire                                        dma1_ch_5_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_5_dst_addr_wen;
wire                                        dma1_ch_5_en_wen;
wire                                        dma1_ch_5_err_wen;
wire                                        dma1_ch_5_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_5_src_addr_wen;
wire                                        dma1_ch_5_tc_wen;
wire                                        dma1_ch_5_tts_wen;
   `endif
   `ifdef DMAC_CONFIG_CH6
wire                                        dma1_ch_6_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_6_dst_addr_wen;
wire                                        dma1_ch_6_en_wen;
wire                                        dma1_ch_6_err_wen;
wire                                        dma1_ch_6_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_6_src_addr_wen;
wire                                        dma1_ch_6_tc_wen;
wire                                        dma1_ch_6_tts_wen;
   `endif
   `ifdef DMAC_CONFIG_CH7
wire                                        dma1_ch_7_ctl_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_7_dst_addr_wen;
wire                                        dma1_ch_7_en_wen;
wire                                        dma1_ch_7_err_wen;
wire                                        dma1_ch_7_int_wen;
wire                       [ADDR_WEN_MSB:0] dma1_ch_7_src_addr_wen;
wire                                        dma1_ch_7_tc_wen;
wire                                        dma1_ch_7_tts_wen;
   `endif
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
wire                                        dma1_ch_lld_bus_inf_idx;
wire                                        dma1_ch_llp_wdata_idx;
      `endif
   `endif
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
      `ifdef DMAC_CONFIG_CH0
wire                       [ADDR_WEN_MSB:0] dma1_ch_0_llp_wen;
      `endif
      `ifdef DMAC_CONFIG_CH1
wire                       [ADDR_WEN_MSB:0] dma1_ch_1_llp_wen;
      `endif
      `ifdef DMAC_CONFIG_CH2
wire                       [ADDR_WEN_MSB:0] dma1_ch_2_llp_wen;
      `endif
      `ifdef DMAC_CONFIG_CH3
wire                       [ADDR_WEN_MSB:0] dma1_ch_3_llp_wen;
      `endif
      `ifdef DMAC_CONFIG_CH4
wire                       [ADDR_WEN_MSB:0] dma1_ch_4_llp_wen;
      `endif
      `ifdef DMAC_CONFIG_CH5
wire                       [ADDR_WEN_MSB:0] dma1_ch_5_llp_wen;
      `endif
      `ifdef DMAC_CONFIG_CH6
wire                       [ADDR_WEN_MSB:0] dma1_ch_6_llp_wen;
      `endif
      `ifdef DMAC_CONFIG_CH7
wire                       [ADDR_WEN_MSB:0] dma1_ch_7_llp_wen;
      `endif
   `endif
`endif
wire                                 [39:0] cmd_buff_wdata;
wire                                        cmd_buff_wr;
wire                                        rdata_buff_rd;
wire                                  [2:0] granted_channel;
wire                                        s42;
wire                                        s43;
wire                                        s44;
wire                                        s45;
wire                [(`DMA_DATA_WIDTH-1):0] s46;
wire                                        s47;
wire                                        s48;
wire                                  [7:0] ch_level;
wire                                  [7:0] ch_request;
wire                                  [2:0] current_channel;
wire                                        dma0_arb_end;
wire                                        dma0_ch_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma0_ch_dst_addr;
wire                                  [1:0] dma0_ch_dst_addr_ctl;
wire                                        dma0_ch_dst_mode;
wire                                        dma0_ch_dst_request;
wire                                  [2:0] dma0_ch_dst_width;
wire                                        dma0_ch_int_abt_mask;
wire                                        dma0_ch_int_err_mask;
wire                                        dma0_ch_int_tc_mask;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma0_ch_src_addr;
wire                                  [1:0] dma0_ch_src_addr_ctl;
wire                                  [3:0] dma0_ch_src_burst_size;
wire                                        dma0_ch_src_mode;
wire                                        dma0_ch_src_request;
wire                                  [2:0] dma0_ch_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] dma0_ch_tts;
wire                                  [2:0] dma0_current_channel;
wire                                 [27:1] dma0_ch_ctl_wdata;
wire                                        dma0_ch_ctl_wdata_pri;
wire                                        dma0_ch_ctl_wen;
wire                                        dma0_ch_dst_ack;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma0_ch_dst_addr_wdata;
wire                       [ADDR_WEN_MSB:0] dma0_ch_dst_addr_wen;
wire                                        dma0_ch_en_wen;
wire                                        dma0_ch_err_wen;
wire                                        dma0_ch_int_wen;
wire                                        dma0_ch_src_ack;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] dma0_ch_src_addr_wdata;
wire                       [ADDR_WEN_MSB:0] dma0_ch_src_addr_wen;
wire                                        dma0_ch_tc_wen;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] dma0_ch_tts_wdata;
wire                                        dma0_ch_tts_wen;
wire                                        dma0_idle_state;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] s49;
wire                                        s50;
wire                                  [7:0] s51;
wire                                        s52;
wire                                  [2:0] s53;
wire                [(`DMA_DATA_WIDTH-1):0] s54;
wire                                        s55;
wire                                        dma0_mst_wr_mask;
wire                                        ch_0_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_0_dst_addr;
wire                                  [1:0] ch_0_dst_addr_ctl;
wire                                        ch_0_dst_mode;
wire                                  [3:0] ch_0_dst_req_sel;
wire                                  [2:0] ch_0_dst_width;
wire                                        ch_0_en;
wire                                        ch_0_int_abt_mask;
wire                                        ch_0_int_err_mask;
wire                                        ch_0_int_tc_mask;
wire                                        ch_0_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_0_src_addr;
wire                                  [1:0] ch_0_src_addr_ctl;
wire                                  [3:0] ch_0_src_burst_size;
wire                                        ch_0_src_mode;
wire                                  [3:0] ch_0_src_req_sel;
wire                                  [2:0] ch_0_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_0_tts;
wire                                        ch_1_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_1_dst_addr;
wire                                  [1:0] ch_1_dst_addr_ctl;
wire                                        ch_1_dst_mode;
wire                                  [3:0] ch_1_dst_req_sel;
wire                                  [2:0] ch_1_dst_width;
wire                                        ch_1_en;
wire                                        ch_1_int_abt_mask;
wire                                        ch_1_int_err_mask;
wire                                        ch_1_int_tc_mask;
wire                                        ch_1_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_1_src_addr;
wire                                  [1:0] ch_1_src_addr_ctl;
wire                                  [3:0] ch_1_src_burst_size;
wire                                        ch_1_src_mode;
wire                                  [3:0] ch_1_src_req_sel;
wire                                  [2:0] ch_1_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_1_tts;
wire                                        ch_2_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_2_dst_addr;
wire                                  [1:0] ch_2_dst_addr_ctl;
wire                                        ch_2_dst_mode;
wire                                  [3:0] ch_2_dst_req_sel;
wire                                  [2:0] ch_2_dst_width;
wire                                        ch_2_en;
wire                                        ch_2_int_abt_mask;
wire                                        ch_2_int_err_mask;
wire                                        ch_2_int_tc_mask;
wire                                        ch_2_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_2_src_addr;
wire                                  [1:0] ch_2_src_addr_ctl;
wire                                  [3:0] ch_2_src_burst_size;
wire                                        ch_2_src_mode;
wire                                  [3:0] ch_2_src_req_sel;
wire                                  [2:0] ch_2_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_2_tts;
wire                                        ch_3_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_3_dst_addr;
wire                                  [1:0] ch_3_dst_addr_ctl;
wire                                        ch_3_dst_mode;
wire                                  [3:0] ch_3_dst_req_sel;
wire                                  [2:0] ch_3_dst_width;
wire                                        ch_3_en;
wire                                        ch_3_int_abt_mask;
wire                                        ch_3_int_err_mask;
wire                                        ch_3_int_tc_mask;
wire                                        ch_3_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_3_src_addr;
wire                                  [1:0] ch_3_src_addr_ctl;
wire                                  [3:0] ch_3_src_burst_size;
wire                                        ch_3_src_mode;
wire                                  [3:0] ch_3_src_req_sel;
wire                                  [2:0] ch_3_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_3_tts;
wire                                        ch_4_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_4_dst_addr;
wire                                  [1:0] ch_4_dst_addr_ctl;
wire                                        ch_4_dst_mode;
wire                                  [3:0] ch_4_dst_req_sel;
wire                                  [2:0] ch_4_dst_width;
wire                                        ch_4_en;
wire                                        ch_4_int_abt_mask;
wire                                        ch_4_int_err_mask;
wire                                        ch_4_int_tc_mask;
wire                                        ch_4_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_4_src_addr;
wire                                  [1:0] ch_4_src_addr_ctl;
wire                                  [3:0] ch_4_src_burst_size;
wire                                        ch_4_src_mode;
wire                                  [3:0] ch_4_src_req_sel;
wire                                  [2:0] ch_4_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_4_tts;
wire                                        ch_5_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_5_dst_addr;
wire                                  [1:0] ch_5_dst_addr_ctl;
wire                                        ch_5_dst_mode;
wire                                  [3:0] ch_5_dst_req_sel;
wire                                  [2:0] ch_5_dst_width;
wire                                        ch_5_en;
wire                                        ch_5_int_abt_mask;
wire                                        ch_5_int_err_mask;
wire                                        ch_5_int_tc_mask;
wire                                        ch_5_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_5_src_addr;
wire                                  [1:0] ch_5_src_addr_ctl;
wire                                  [3:0] ch_5_src_burst_size;
wire                                        ch_5_src_mode;
wire                                  [3:0] ch_5_src_req_sel;
wire                                  [2:0] ch_5_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_5_tts;
wire                                        ch_6_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_6_dst_addr;
wire                                  [1:0] ch_6_dst_addr_ctl;
wire                                        ch_6_dst_mode;
wire                                  [3:0] ch_6_dst_req_sel;
wire                                  [2:0] ch_6_dst_width;
wire                                        ch_6_en;
wire                                        ch_6_int_abt_mask;
wire                                        ch_6_int_err_mask;
wire                                        ch_6_int_tc_mask;
wire                                        ch_6_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_6_src_addr;
wire                                  [1:0] ch_6_src_addr_ctl;
wire                                  [3:0] ch_6_src_burst_size;
wire                                        ch_6_src_mode;
wire                                  [3:0] ch_6_src_req_sel;
wire                                  [2:0] ch_6_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_6_tts;
wire                                        ch_7_abt;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_7_dst_addr;
wire                                  [1:0] ch_7_dst_addr_ctl;
wire                                        ch_7_dst_mode;
wire                                  [3:0] ch_7_dst_req_sel;
wire                                  [2:0] ch_7_dst_width;
wire                                        ch_7_en;
wire                                        ch_7_int_abt_mask;
wire                                        ch_7_int_err_mask;
wire                                        ch_7_int_tc_mask;
wire                                        ch_7_priority;
wire         [(`ATCDMAC300_ADDR_WIDTH-1):0] ch_7_src_addr;
wire                                  [1:0] ch_7_src_addr_ctl;
wire                                  [3:0] ch_7_src_burst_size;
wire                                        ch_7_src_mode;
wire                                  [3:0] ch_7_src_req_sel;
wire                                  [2:0] ch_7_src_width;
wire          [(`ATCDMAC300_TTS_WIDTH-1):0] ch_7_tts;
wire                                        cmd_buff_full;
wire                                        dma_soft_reset;
wire                                        rdata_buff_empty;
wire                                 [31:0] rdata_buff_rdata;


atcdmac300_apbslv atcdmac300_apbslv (
	.pclk            (pclk            ),
	.presetn         (presetn         ),
	.paddr           (paddr           ),
	.psel            (psel            ),
	.penable         (penable         ),
	.pwrite          (pwrite          ),
	.pwdata          (pwdata          ),
	.pready          (pready          ),
	.prdata          (prdata          ),
	.pslverr         (pslverr         ),
	.cmd_buff_wr     (cmd_buff_wr     ),
	.cmd_buff_wdata  (cmd_buff_wdata  ),
	.cmd_buff_full   (cmd_buff_full   ),
	.rdata_buff_rd   (rdata_buff_rd   ),
	.rdata_buff_rdata(rdata_buff_rdata),
	.rdata_buff_empty(rdata_buff_empty)
);

atcdmac300_arbiter atcdmac300_arbiter (
	.ch_request     (ch_request     ),
	.ch_level       (ch_level       ),
	.current_channel(current_channel),
	.granted_channel(granted_channel)
);

atcdmac300_register atcdmac300_register (
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               ),
	.pclk                  (pclk                  ),
	.presetn               (presetn               ),
	.cmd_buff_wr           (cmd_buff_wr           ),
	.cmd_buff_wdata        (cmd_buff_wdata        ),
	.cmd_buff_full         (cmd_buff_full         ),
	.rdata_buff_rd         (rdata_buff_rd         ),
	.rdata_buff_rdata      (rdata_buff_rdata      ),
	.rdata_buff_empty      (rdata_buff_empty      ),
	.dma_int               (dma_int               ),
	.dma_soft_reset        (dma_soft_reset        ),
	.ch_0_en               (ch_0_en               ),
	.ch_0_int_tc_mask      (ch_0_int_tc_mask      ),
	.ch_0_int_err_mask     (ch_0_int_err_mask     ),
	.ch_0_int_abt_mask     (ch_0_int_abt_mask     ),
	.ch_0_src_req_sel      (ch_0_src_req_sel      ),
	.ch_0_dst_req_sel      (ch_0_dst_req_sel      ),
	.ch_0_src_addr_ctl     (ch_0_src_addr_ctl     ),
	.ch_0_dst_addr_ctl     (ch_0_dst_addr_ctl     ),
	.ch_0_src_mode         (ch_0_src_mode         ),
	.ch_0_dst_mode         (ch_0_dst_mode         ),
	.ch_0_src_width        (ch_0_src_width        ),
	.ch_0_dst_width        (ch_0_dst_width        ),
	.ch_0_src_burst_size   (ch_0_src_burst_size   ),
	.ch_0_priority         (ch_0_priority         ),
	.ch_0_src_addr         (ch_0_src_addr         ),
	.ch_0_dst_addr         (ch_0_dst_addr         ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_0_src_bus_inf_idx  (ch_0_src_bus_inf_idx  ),
	.ch_0_dst_bus_inf_idx  (ch_0_dst_bus_inf_idx  ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_0_llp_reg          (ch_0_llp_reg          ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_0_lld_bus_inf_idx  (ch_0_lld_bus_inf_idx  ),
   `endif
`endif
	.ch_0_tts              (ch_0_tts              ),
	.ch_0_abt              (ch_0_abt              ),
	.ch_1_en               (ch_1_en               ),
	.ch_1_int_tc_mask      (ch_1_int_tc_mask      ),
	.ch_1_int_err_mask     (ch_1_int_err_mask     ),
	.ch_1_int_abt_mask     (ch_1_int_abt_mask     ),
	.ch_1_src_req_sel      (ch_1_src_req_sel      ),
	.ch_1_dst_req_sel      (ch_1_dst_req_sel      ),
	.ch_1_src_addr_ctl     (ch_1_src_addr_ctl     ),
	.ch_1_dst_addr_ctl     (ch_1_dst_addr_ctl     ),
	.ch_1_src_mode         (ch_1_src_mode         ),
	.ch_1_dst_mode         (ch_1_dst_mode         ),
	.ch_1_src_width        (ch_1_src_width        ),
	.ch_1_dst_width        (ch_1_dst_width        ),
	.ch_1_src_burst_size   (ch_1_src_burst_size   ),
	.ch_1_priority         (ch_1_priority         ),
	.ch_1_src_addr         (ch_1_src_addr         ),
	.ch_1_dst_addr         (ch_1_dst_addr         ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_1_src_bus_inf_idx  (ch_1_src_bus_inf_idx  ),
	.ch_1_dst_bus_inf_idx  (ch_1_dst_bus_inf_idx  ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_1_llp_reg          (ch_1_llp_reg          ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_1_lld_bus_inf_idx  (ch_1_lld_bus_inf_idx  ),
   `endif
`endif
	.ch_1_tts              (ch_1_tts              ),
	.ch_1_abt              (ch_1_abt              ),
	.ch_2_en               (ch_2_en               ),
	.ch_2_int_tc_mask      (ch_2_int_tc_mask      ),
	.ch_2_int_err_mask     (ch_2_int_err_mask     ),
	.ch_2_int_abt_mask     (ch_2_int_abt_mask     ),
	.ch_2_src_req_sel      (ch_2_src_req_sel      ),
	.ch_2_dst_req_sel      (ch_2_dst_req_sel      ),
	.ch_2_src_addr_ctl     (ch_2_src_addr_ctl     ),
	.ch_2_dst_addr_ctl     (ch_2_dst_addr_ctl     ),
	.ch_2_src_mode         (ch_2_src_mode         ),
	.ch_2_dst_mode         (ch_2_dst_mode         ),
	.ch_2_src_width        (ch_2_src_width        ),
	.ch_2_dst_width        (ch_2_dst_width        ),
	.ch_2_src_burst_size   (ch_2_src_burst_size   ),
	.ch_2_priority         (ch_2_priority         ),
	.ch_2_src_addr         (ch_2_src_addr         ),
	.ch_2_dst_addr         (ch_2_dst_addr         ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_2_src_bus_inf_idx  (ch_2_src_bus_inf_idx  ),
	.ch_2_dst_bus_inf_idx  (ch_2_dst_bus_inf_idx  ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_2_llp_reg          (ch_2_llp_reg          ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_2_lld_bus_inf_idx  (ch_2_lld_bus_inf_idx  ),
   `endif
`endif
	.ch_2_tts              (ch_2_tts              ),
	.ch_2_abt              (ch_2_abt              ),
	.ch_3_en               (ch_3_en               ),
	.ch_3_int_tc_mask      (ch_3_int_tc_mask      ),
	.ch_3_int_err_mask     (ch_3_int_err_mask     ),
	.ch_3_int_abt_mask     (ch_3_int_abt_mask     ),
	.ch_3_src_req_sel      (ch_3_src_req_sel      ),
	.ch_3_dst_req_sel      (ch_3_dst_req_sel      ),
	.ch_3_src_addr_ctl     (ch_3_src_addr_ctl     ),
	.ch_3_dst_addr_ctl     (ch_3_dst_addr_ctl     ),
	.ch_3_src_mode         (ch_3_src_mode         ),
	.ch_3_dst_mode         (ch_3_dst_mode         ),
	.ch_3_src_width        (ch_3_src_width        ),
	.ch_3_dst_width        (ch_3_dst_width        ),
	.ch_3_src_burst_size   (ch_3_src_burst_size   ),
	.ch_3_priority         (ch_3_priority         ),
	.ch_3_src_addr         (ch_3_src_addr         ),
	.ch_3_dst_addr         (ch_3_dst_addr         ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_3_src_bus_inf_idx  (ch_3_src_bus_inf_idx  ),
	.ch_3_dst_bus_inf_idx  (ch_3_dst_bus_inf_idx  ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_3_llp_reg          (ch_3_llp_reg          ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_3_lld_bus_inf_idx  (ch_3_lld_bus_inf_idx  ),
   `endif
`endif
	.ch_3_tts              (ch_3_tts              ),
	.ch_3_abt              (ch_3_abt              ),
	.ch_4_en               (ch_4_en               ),
	.ch_4_int_tc_mask      (ch_4_int_tc_mask      ),
	.ch_4_int_err_mask     (ch_4_int_err_mask     ),
	.ch_4_int_abt_mask     (ch_4_int_abt_mask     ),
	.ch_4_src_req_sel      (ch_4_src_req_sel      ),
	.ch_4_dst_req_sel      (ch_4_dst_req_sel      ),
	.ch_4_src_addr_ctl     (ch_4_src_addr_ctl     ),
	.ch_4_dst_addr_ctl     (ch_4_dst_addr_ctl     ),
	.ch_4_src_mode         (ch_4_src_mode         ),
	.ch_4_dst_mode         (ch_4_dst_mode         ),
	.ch_4_src_width        (ch_4_src_width        ),
	.ch_4_dst_width        (ch_4_dst_width        ),
	.ch_4_src_burst_size   (ch_4_src_burst_size   ),
	.ch_4_priority         (ch_4_priority         ),
	.ch_4_src_addr         (ch_4_src_addr         ),
	.ch_4_dst_addr         (ch_4_dst_addr         ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_4_src_bus_inf_idx  (ch_4_src_bus_inf_idx  ),
	.ch_4_dst_bus_inf_idx  (ch_4_dst_bus_inf_idx  ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_4_llp_reg          (ch_4_llp_reg          ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_4_lld_bus_inf_idx  (ch_4_lld_bus_inf_idx  ),
   `endif
`endif
	.ch_4_tts              (ch_4_tts              ),
	.ch_4_abt              (ch_4_abt              ),
	.ch_5_en               (ch_5_en               ),
	.ch_5_int_tc_mask      (ch_5_int_tc_mask      ),
	.ch_5_int_err_mask     (ch_5_int_err_mask     ),
	.ch_5_int_abt_mask     (ch_5_int_abt_mask     ),
	.ch_5_src_req_sel      (ch_5_src_req_sel      ),
	.ch_5_dst_req_sel      (ch_5_dst_req_sel      ),
	.ch_5_src_addr_ctl     (ch_5_src_addr_ctl     ),
	.ch_5_dst_addr_ctl     (ch_5_dst_addr_ctl     ),
	.ch_5_src_mode         (ch_5_src_mode         ),
	.ch_5_dst_mode         (ch_5_dst_mode         ),
	.ch_5_src_width        (ch_5_src_width        ),
	.ch_5_dst_width        (ch_5_dst_width        ),
	.ch_5_src_burst_size   (ch_5_src_burst_size   ),
	.ch_5_priority         (ch_5_priority         ),
	.ch_5_src_addr         (ch_5_src_addr         ),
	.ch_5_dst_addr         (ch_5_dst_addr         ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_5_src_bus_inf_idx  (ch_5_src_bus_inf_idx  ),
	.ch_5_dst_bus_inf_idx  (ch_5_dst_bus_inf_idx  ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_5_llp_reg          (ch_5_llp_reg          ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_5_lld_bus_inf_idx  (ch_5_lld_bus_inf_idx  ),
   `endif
`endif
	.ch_5_tts              (ch_5_tts              ),
	.ch_5_abt              (ch_5_abt              ),
	.ch_6_en               (ch_6_en               ),
	.ch_6_int_tc_mask      (ch_6_int_tc_mask      ),
	.ch_6_int_err_mask     (ch_6_int_err_mask     ),
	.ch_6_int_abt_mask     (ch_6_int_abt_mask     ),
	.ch_6_src_req_sel      (ch_6_src_req_sel      ),
	.ch_6_dst_req_sel      (ch_6_dst_req_sel      ),
	.ch_6_src_addr_ctl     (ch_6_src_addr_ctl     ),
	.ch_6_dst_addr_ctl     (ch_6_dst_addr_ctl     ),
	.ch_6_src_mode         (ch_6_src_mode         ),
	.ch_6_dst_mode         (ch_6_dst_mode         ),
	.ch_6_src_width        (ch_6_src_width        ),
	.ch_6_dst_width        (ch_6_dst_width        ),
	.ch_6_src_burst_size   (ch_6_src_burst_size   ),
	.ch_6_priority         (ch_6_priority         ),
	.ch_6_src_addr         (ch_6_src_addr         ),
	.ch_6_dst_addr         (ch_6_dst_addr         ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_6_src_bus_inf_idx  (ch_6_src_bus_inf_idx  ),
	.ch_6_dst_bus_inf_idx  (ch_6_dst_bus_inf_idx  ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_6_llp_reg          (ch_6_llp_reg          ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_6_lld_bus_inf_idx  (ch_6_lld_bus_inf_idx  ),
   `endif
`endif
	.ch_6_tts              (ch_6_tts              ),
	.ch_6_abt              (ch_6_abt              ),
	.ch_7_en               (ch_7_en               ),
	.ch_7_int_tc_mask      (ch_7_int_tc_mask      ),
	.ch_7_int_err_mask     (ch_7_int_err_mask     ),
	.ch_7_int_abt_mask     (ch_7_int_abt_mask     ),
	.ch_7_src_req_sel      (ch_7_src_req_sel      ),
	.ch_7_dst_req_sel      (ch_7_dst_req_sel      ),
	.ch_7_src_addr_ctl     (ch_7_src_addr_ctl     ),
	.ch_7_dst_addr_ctl     (ch_7_dst_addr_ctl     ),
	.ch_7_src_mode         (ch_7_src_mode         ),
	.ch_7_dst_mode         (ch_7_dst_mode         ),
	.ch_7_src_width        (ch_7_src_width        ),
	.ch_7_dst_width        (ch_7_dst_width        ),
	.ch_7_src_burst_size   (ch_7_src_burst_size   ),
	.ch_7_priority         (ch_7_priority         ),
	.ch_7_src_addr         (ch_7_src_addr         ),
	.ch_7_dst_addr         (ch_7_dst_addr         ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_7_src_bus_inf_idx  (ch_7_src_bus_inf_idx  ),
	.ch_7_dst_bus_inf_idx  (ch_7_dst_bus_inf_idx  ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_7_llp_reg          (ch_7_llp_reg          ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_7_lld_bus_inf_idx  (ch_7_lld_bus_inf_idx  ),
   `endif
`endif
	.ch_7_tts              (ch_7_tts              ),
	.ch_7_abt              (ch_7_abt              ),
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
   `ifdef DMAC_CONFIG_CH0
	.dma1_ch_0_ctl_wen     (dma1_ch_0_ctl_wen     ),
	.dma1_ch_0_en_wen      (dma1_ch_0_en_wen      ),
	.dma1_ch_0_src_addr_wen(dma1_ch_0_src_addr_wen),
	.dma1_ch_0_dst_addr_wen(dma1_ch_0_dst_addr_wen),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_0_llp_wen     (dma1_ch_0_llp_wen     ),
      `endif
	.dma1_ch_0_tts_wen     (dma1_ch_0_tts_wen     ),
	.dma1_ch_0_tc_wen      (dma1_ch_0_tc_wen      ),
	.dma1_ch_0_err_wen     (dma1_ch_0_err_wen     ),
	.dma1_ch_0_int_wen     (dma1_ch_0_int_wen     ),
   `endif
   `ifdef DMAC_CONFIG_CH1
	.dma1_ch_1_ctl_wen     (dma1_ch_1_ctl_wen     ),
	.dma1_ch_1_en_wen      (dma1_ch_1_en_wen      ),
	.dma1_ch_1_src_addr_wen(dma1_ch_1_src_addr_wen),
	.dma1_ch_1_dst_addr_wen(dma1_ch_1_dst_addr_wen),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_1_llp_wen     (dma1_ch_1_llp_wen     ),
      `endif
	.dma1_ch_1_tts_wen     (dma1_ch_1_tts_wen     ),
	.dma1_ch_1_tc_wen      (dma1_ch_1_tc_wen      ),
	.dma1_ch_1_err_wen     (dma1_ch_1_err_wen     ),
	.dma1_ch_1_int_wen     (dma1_ch_1_int_wen     ),
   `endif
   `ifdef DMAC_CONFIG_CH2
	.dma1_ch_2_ctl_wen     (dma1_ch_2_ctl_wen     ),
	.dma1_ch_2_en_wen      (dma1_ch_2_en_wen      ),
	.dma1_ch_2_src_addr_wen(dma1_ch_2_src_addr_wen),
	.dma1_ch_2_dst_addr_wen(dma1_ch_2_dst_addr_wen),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_2_llp_wen     (dma1_ch_2_llp_wen     ),
      `endif
	.dma1_ch_2_tts_wen     (dma1_ch_2_tts_wen     ),
	.dma1_ch_2_tc_wen      (dma1_ch_2_tc_wen      ),
	.dma1_ch_2_err_wen     (dma1_ch_2_err_wen     ),
	.dma1_ch_2_int_wen     (dma1_ch_2_int_wen     ),
   `endif
   `ifdef DMAC_CONFIG_CH3
	.dma1_ch_3_ctl_wen     (dma1_ch_3_ctl_wen     ),
	.dma1_ch_3_en_wen      (dma1_ch_3_en_wen      ),
	.dma1_ch_3_src_addr_wen(dma1_ch_3_src_addr_wen),
	.dma1_ch_3_dst_addr_wen(dma1_ch_3_dst_addr_wen),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_3_llp_wen     (dma1_ch_3_llp_wen     ),
      `endif
	.dma1_ch_3_tts_wen     (dma1_ch_3_tts_wen     ),
	.dma1_ch_3_tc_wen      (dma1_ch_3_tc_wen      ),
	.dma1_ch_3_err_wen     (dma1_ch_3_err_wen     ),
	.dma1_ch_3_int_wen     (dma1_ch_3_int_wen     ),
   `endif
   `ifdef DMAC_CONFIG_CH4
	.dma1_ch_4_ctl_wen     (dma1_ch_4_ctl_wen     ),
	.dma1_ch_4_en_wen      (dma1_ch_4_en_wen      ),
	.dma1_ch_4_src_addr_wen(dma1_ch_4_src_addr_wen),
	.dma1_ch_4_dst_addr_wen(dma1_ch_4_dst_addr_wen),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_4_llp_wen     (dma1_ch_4_llp_wen     ),
      `endif
	.dma1_ch_4_tts_wen     (dma1_ch_4_tts_wen     ),
	.dma1_ch_4_tc_wen      (dma1_ch_4_tc_wen      ),
	.dma1_ch_4_err_wen     (dma1_ch_4_err_wen     ),
	.dma1_ch_4_int_wen     (dma1_ch_4_int_wen     ),
   `endif
   `ifdef DMAC_CONFIG_CH5
	.dma1_ch_5_ctl_wen     (dma1_ch_5_ctl_wen     ),
	.dma1_ch_5_en_wen      (dma1_ch_5_en_wen      ),
	.dma1_ch_5_src_addr_wen(dma1_ch_5_src_addr_wen),
	.dma1_ch_5_dst_addr_wen(dma1_ch_5_dst_addr_wen),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_5_llp_wen     (dma1_ch_5_llp_wen     ),
      `endif
	.dma1_ch_5_tts_wen     (dma1_ch_5_tts_wen     ),
	.dma1_ch_5_tc_wen      (dma1_ch_5_tc_wen      ),
	.dma1_ch_5_err_wen     (dma1_ch_5_err_wen     ),
	.dma1_ch_5_int_wen     (dma1_ch_5_int_wen     ),
   `endif
   `ifdef DMAC_CONFIG_CH6
	.dma1_ch_6_ctl_wen     (dma1_ch_6_ctl_wen     ),
	.dma1_ch_6_en_wen      (dma1_ch_6_en_wen      ),
	.dma1_ch_6_src_addr_wen(dma1_ch_6_src_addr_wen),
	.dma1_ch_6_dst_addr_wen(dma1_ch_6_dst_addr_wen),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_6_llp_wen     (dma1_ch_6_llp_wen     ),
      `endif
	.dma1_ch_6_tts_wen     (dma1_ch_6_tts_wen     ),
	.dma1_ch_6_tc_wen      (dma1_ch_6_tc_wen      ),
	.dma1_ch_6_err_wen     (dma1_ch_6_err_wen     ),
	.dma1_ch_6_int_wen     (dma1_ch_6_int_wen     ),
   `endif
   `ifdef DMAC_CONFIG_CH7
	.dma1_ch_7_ctl_wen     (dma1_ch_7_ctl_wen     ),
	.dma1_ch_7_en_wen      (dma1_ch_7_en_wen      ),
	.dma1_ch_7_src_addr_wen(dma1_ch_7_src_addr_wen),
	.dma1_ch_7_dst_addr_wen(dma1_ch_7_dst_addr_wen),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_7_llp_wen     (dma1_ch_7_llp_wen     ),
      `endif
	.dma1_ch_7_tts_wen     (dma1_ch_7_tts_wen     ),
	.dma1_ch_7_tc_wen      (dma1_ch_7_tc_wen      ),
	.dma1_ch_7_err_wen     (dma1_ch_7_err_wen     ),
	.dma1_ch_7_int_wen     (dma1_ch_7_int_wen     ),
   `endif
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_llp_wdata     (dma1_ch_llp_wdata     ),
      `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma1_ch_llp_wdata_idx (dma1_ch_llp_wdata_idx ),
      `endif
   `endif
	.dma1_ch_ctl_wdata     (dma1_ch_ctl_wdata     ),
	.dma1_ch_ctl_wdata_pri (dma1_ch_ctl_wdata_pri ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma1_ch_ctl_wdata_idx (dma1_ch_ctl_wdata_idx ),
   `endif
	.dma1_ch_tts_wdata     (dma1_ch_tts_wdata     ),
	.dma1_ch_src_addr_wdata(dma1_ch_src_addr_wdata),
	.dma1_ch_dst_addr_wdata(dma1_ch_dst_addr_wdata),
`endif
`ifdef DMAC_CONFIG_CH0
	.dma0_ch_0_ctl_wen     (dma0_ch_0_ctl_wen     ),
	.dma0_ch_0_en_wen      (dma0_ch_0_en_wen      ),
	.dma0_ch_0_src_addr_wen(dma0_ch_0_src_addr_wen),
	.dma0_ch_0_dst_addr_wen(dma0_ch_0_dst_addr_wen),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_0_llp_wen     (dma0_ch_0_llp_wen     ),
   `endif
	.dma0_ch_0_tts_wen     (dma0_ch_0_tts_wen     ),
	.dma0_ch_0_tc_wen      (dma0_ch_0_tc_wen      ),
	.dma0_ch_0_err_wen     (dma0_ch_0_err_wen     ),
	.dma0_ch_0_int_wen     (dma0_ch_0_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH1
	.dma0_ch_1_ctl_wen     (dma0_ch_1_ctl_wen     ),
	.dma0_ch_1_en_wen      (dma0_ch_1_en_wen      ),
	.dma0_ch_1_src_addr_wen(dma0_ch_1_src_addr_wen),
	.dma0_ch_1_dst_addr_wen(dma0_ch_1_dst_addr_wen),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_1_llp_wen     (dma0_ch_1_llp_wen     ),
   `endif
	.dma0_ch_1_tts_wen     (dma0_ch_1_tts_wen     ),
	.dma0_ch_1_tc_wen      (dma0_ch_1_tc_wen      ),
	.dma0_ch_1_err_wen     (dma0_ch_1_err_wen     ),
	.dma0_ch_1_int_wen     (dma0_ch_1_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH2
	.dma0_ch_2_ctl_wen     (dma0_ch_2_ctl_wen     ),
	.dma0_ch_2_en_wen      (dma0_ch_2_en_wen      ),
	.dma0_ch_2_src_addr_wen(dma0_ch_2_src_addr_wen),
	.dma0_ch_2_dst_addr_wen(dma0_ch_2_dst_addr_wen),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_2_llp_wen     (dma0_ch_2_llp_wen     ),
   `endif
	.dma0_ch_2_tts_wen     (dma0_ch_2_tts_wen     ),
	.dma0_ch_2_tc_wen      (dma0_ch_2_tc_wen      ),
	.dma0_ch_2_err_wen     (dma0_ch_2_err_wen     ),
	.dma0_ch_2_int_wen     (dma0_ch_2_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH3
	.dma0_ch_3_ctl_wen     (dma0_ch_3_ctl_wen     ),
	.dma0_ch_3_en_wen      (dma0_ch_3_en_wen      ),
	.dma0_ch_3_src_addr_wen(dma0_ch_3_src_addr_wen),
	.dma0_ch_3_dst_addr_wen(dma0_ch_3_dst_addr_wen),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_3_llp_wen     (dma0_ch_3_llp_wen     ),
   `endif
	.dma0_ch_3_tts_wen     (dma0_ch_3_tts_wen     ),
	.dma0_ch_3_tc_wen      (dma0_ch_3_tc_wen      ),
	.dma0_ch_3_err_wen     (dma0_ch_3_err_wen     ),
	.dma0_ch_3_int_wen     (dma0_ch_3_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH4
	.dma0_ch_4_ctl_wen     (dma0_ch_4_ctl_wen     ),
	.dma0_ch_4_en_wen      (dma0_ch_4_en_wen      ),
	.dma0_ch_4_src_addr_wen(dma0_ch_4_src_addr_wen),
	.dma0_ch_4_dst_addr_wen(dma0_ch_4_dst_addr_wen),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_4_llp_wen     (dma0_ch_4_llp_wen     ),
   `endif
	.dma0_ch_4_tts_wen     (dma0_ch_4_tts_wen     ),
	.dma0_ch_4_tc_wen      (dma0_ch_4_tc_wen      ),
	.dma0_ch_4_err_wen     (dma0_ch_4_err_wen     ),
	.dma0_ch_4_int_wen     (dma0_ch_4_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH5
	.dma0_ch_5_ctl_wen     (dma0_ch_5_ctl_wen     ),
	.dma0_ch_5_en_wen      (dma0_ch_5_en_wen      ),
	.dma0_ch_5_src_addr_wen(dma0_ch_5_src_addr_wen),
	.dma0_ch_5_dst_addr_wen(dma0_ch_5_dst_addr_wen),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_5_llp_wen     (dma0_ch_5_llp_wen     ),
   `endif
	.dma0_ch_5_tts_wen     (dma0_ch_5_tts_wen     ),
	.dma0_ch_5_tc_wen      (dma0_ch_5_tc_wen      ),
	.dma0_ch_5_err_wen     (dma0_ch_5_err_wen     ),
	.dma0_ch_5_int_wen     (dma0_ch_5_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH6
	.dma0_ch_6_ctl_wen     (dma0_ch_6_ctl_wen     ),
	.dma0_ch_6_en_wen      (dma0_ch_6_en_wen      ),
	.dma0_ch_6_src_addr_wen(dma0_ch_6_src_addr_wen),
	.dma0_ch_6_dst_addr_wen(dma0_ch_6_dst_addr_wen),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_6_llp_wen     (dma0_ch_6_llp_wen     ),
   `endif
	.dma0_ch_6_tts_wen     (dma0_ch_6_tts_wen     ),
	.dma0_ch_6_tc_wen      (dma0_ch_6_tc_wen      ),
	.dma0_ch_6_err_wen     (dma0_ch_6_err_wen     ),
	.dma0_ch_6_int_wen     (dma0_ch_6_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH7
	.dma0_ch_7_ctl_wen     (dma0_ch_7_ctl_wen     ),
	.dma0_ch_7_en_wen      (dma0_ch_7_en_wen      ),
	.dma0_ch_7_src_addr_wen(dma0_ch_7_src_addr_wen),
	.dma0_ch_7_dst_addr_wen(dma0_ch_7_dst_addr_wen),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_7_llp_wen     (dma0_ch_7_llp_wen     ),
   `endif
	.dma0_ch_7_tts_wen     (dma0_ch_7_tts_wen     ),
	.dma0_ch_7_tc_wen      (dma0_ch_7_tc_wen      ),
	.dma0_ch_7_err_wen     (dma0_ch_7_err_wen     ),
	.dma0_ch_7_int_wen     (dma0_ch_7_int_wen     ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_llp_wdata     (dma0_ch_llp_wdata     ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma0_ch_llp_wdata_idx (dma0_ch_llp_wdata_idx ),
   `endif
`endif
	.dma0_ch_ctl_wdata     (dma0_ch_ctl_wdata     ),
	.dma0_ch_ctl_wdata_pri (dma0_ch_ctl_wdata_pri ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma0_ch_ctl_wdata_idx (dma0_ch_ctl_wdata_idx ),
`endif
	.dma0_ch_tts_wdata     (dma0_ch_tts_wdata     ),
	.dma0_ch_src_addr_wdata(dma0_ch_src_addr_wdata),
	.dma0_ch_dst_addr_wdata(dma0_ch_dst_addr_wdata)
);

atcdmac300_chmux atcdmac300_chmux (
	.aclk                   (aclk                   ),
	.aresetn                (aresetn                ),
	.dma_req                (dma_req                ),
	.dma_ack                (dma_ack                ),
	.dma_soft_reset         (dma_soft_reset         ),
	.ch_0_en                (ch_0_en                ),
	.ch_0_int_tc_mask       (ch_0_int_tc_mask       ),
	.ch_0_int_err_mask      (ch_0_int_err_mask      ),
	.ch_0_int_abt_mask      (ch_0_int_abt_mask      ),
	.ch_0_src_req_sel       (ch_0_src_req_sel       ),
	.ch_0_dst_req_sel       (ch_0_dst_req_sel       ),
	.ch_0_src_addr_ctl      (ch_0_src_addr_ctl      ),
	.ch_0_dst_addr_ctl      (ch_0_dst_addr_ctl      ),
	.ch_0_src_mode          (ch_0_src_mode          ),
	.ch_0_dst_mode          (ch_0_dst_mode          ),
	.ch_0_src_width         (ch_0_src_width         ),
	.ch_0_dst_width         (ch_0_dst_width         ),
	.ch_0_src_burst_size    (ch_0_src_burst_size    ),
	.ch_0_priority          (ch_0_priority          ),
	.ch_0_src_addr          (ch_0_src_addr          ),
	.ch_0_dst_addr          (ch_0_dst_addr          ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_0_src_bus_inf_idx   (ch_0_src_bus_inf_idx   ),
	.ch_0_dst_bus_inf_idx   (ch_0_dst_bus_inf_idx   ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_0_llp_reg           (ch_0_llp_reg           ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_0_lld_bus_inf_idx   (ch_0_lld_bus_inf_idx   ),
   `endif
`endif
	.ch_0_tts               (ch_0_tts               ),
	.ch_0_abt               (ch_0_abt               ),
	.ch_1_en                (ch_1_en                ),
	.ch_1_int_tc_mask       (ch_1_int_tc_mask       ),
	.ch_1_int_err_mask      (ch_1_int_err_mask      ),
	.ch_1_int_abt_mask      (ch_1_int_abt_mask      ),
	.ch_1_src_req_sel       (ch_1_src_req_sel       ),
	.ch_1_dst_req_sel       (ch_1_dst_req_sel       ),
	.ch_1_src_addr_ctl      (ch_1_src_addr_ctl      ),
	.ch_1_dst_addr_ctl      (ch_1_dst_addr_ctl      ),
	.ch_1_src_mode          (ch_1_src_mode          ),
	.ch_1_dst_mode          (ch_1_dst_mode          ),
	.ch_1_src_width         (ch_1_src_width         ),
	.ch_1_dst_width         (ch_1_dst_width         ),
	.ch_1_src_burst_size    (ch_1_src_burst_size    ),
	.ch_1_priority          (ch_1_priority          ),
	.ch_1_src_addr          (ch_1_src_addr          ),
	.ch_1_dst_addr          (ch_1_dst_addr          ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_1_src_bus_inf_idx   (ch_1_src_bus_inf_idx   ),
	.ch_1_dst_bus_inf_idx   (ch_1_dst_bus_inf_idx   ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_1_llp_reg           (ch_1_llp_reg           ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_1_lld_bus_inf_idx   (ch_1_lld_bus_inf_idx   ),
   `endif
`endif
	.ch_1_tts               (ch_1_tts               ),
	.ch_1_abt               (ch_1_abt               ),
	.ch_2_en                (ch_2_en                ),
	.ch_2_int_tc_mask       (ch_2_int_tc_mask       ),
	.ch_2_int_err_mask      (ch_2_int_err_mask      ),
	.ch_2_int_abt_mask      (ch_2_int_abt_mask      ),
	.ch_2_src_req_sel       (ch_2_src_req_sel       ),
	.ch_2_dst_req_sel       (ch_2_dst_req_sel       ),
	.ch_2_src_addr_ctl      (ch_2_src_addr_ctl      ),
	.ch_2_dst_addr_ctl      (ch_2_dst_addr_ctl      ),
	.ch_2_src_mode          (ch_2_src_mode          ),
	.ch_2_dst_mode          (ch_2_dst_mode          ),
	.ch_2_src_width         (ch_2_src_width         ),
	.ch_2_dst_width         (ch_2_dst_width         ),
	.ch_2_src_burst_size    (ch_2_src_burst_size    ),
	.ch_2_priority          (ch_2_priority          ),
	.ch_2_src_addr          (ch_2_src_addr          ),
	.ch_2_dst_addr          (ch_2_dst_addr          ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_2_src_bus_inf_idx   (ch_2_src_bus_inf_idx   ),
	.ch_2_dst_bus_inf_idx   (ch_2_dst_bus_inf_idx   ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_2_llp_reg           (ch_2_llp_reg           ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_2_lld_bus_inf_idx   (ch_2_lld_bus_inf_idx   ),
   `endif
`endif
	.ch_2_tts               (ch_2_tts               ),
	.ch_2_abt               (ch_2_abt               ),
	.ch_3_en                (ch_3_en                ),
	.ch_3_int_tc_mask       (ch_3_int_tc_mask       ),
	.ch_3_int_err_mask      (ch_3_int_err_mask      ),
	.ch_3_int_abt_mask      (ch_3_int_abt_mask      ),
	.ch_3_src_req_sel       (ch_3_src_req_sel       ),
	.ch_3_dst_req_sel       (ch_3_dst_req_sel       ),
	.ch_3_src_addr_ctl      (ch_3_src_addr_ctl      ),
	.ch_3_dst_addr_ctl      (ch_3_dst_addr_ctl      ),
	.ch_3_src_mode          (ch_3_src_mode          ),
	.ch_3_dst_mode          (ch_3_dst_mode          ),
	.ch_3_src_width         (ch_3_src_width         ),
	.ch_3_dst_width         (ch_3_dst_width         ),
	.ch_3_src_burst_size    (ch_3_src_burst_size    ),
	.ch_3_priority          (ch_3_priority          ),
	.ch_3_src_addr          (ch_3_src_addr          ),
	.ch_3_dst_addr          (ch_3_dst_addr          ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_3_src_bus_inf_idx   (ch_3_src_bus_inf_idx   ),
	.ch_3_dst_bus_inf_idx   (ch_3_dst_bus_inf_idx   ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_3_llp_reg           (ch_3_llp_reg           ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_3_lld_bus_inf_idx   (ch_3_lld_bus_inf_idx   ),
   `endif
`endif
	.ch_3_tts               (ch_3_tts               ),
	.ch_3_abt               (ch_3_abt               ),
	.ch_4_en                (ch_4_en                ),
	.ch_4_int_tc_mask       (ch_4_int_tc_mask       ),
	.ch_4_int_err_mask      (ch_4_int_err_mask      ),
	.ch_4_int_abt_mask      (ch_4_int_abt_mask      ),
	.ch_4_src_req_sel       (ch_4_src_req_sel       ),
	.ch_4_dst_req_sel       (ch_4_dst_req_sel       ),
	.ch_4_src_addr_ctl      (ch_4_src_addr_ctl      ),
	.ch_4_dst_addr_ctl      (ch_4_dst_addr_ctl      ),
	.ch_4_src_mode          (ch_4_src_mode          ),
	.ch_4_dst_mode          (ch_4_dst_mode          ),
	.ch_4_src_width         (ch_4_src_width         ),
	.ch_4_dst_width         (ch_4_dst_width         ),
	.ch_4_src_burst_size    (ch_4_src_burst_size    ),
	.ch_4_priority          (ch_4_priority          ),
	.ch_4_src_addr          (ch_4_src_addr          ),
	.ch_4_dst_addr          (ch_4_dst_addr          ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_4_src_bus_inf_idx   (ch_4_src_bus_inf_idx   ),
	.ch_4_dst_bus_inf_idx   (ch_4_dst_bus_inf_idx   ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_4_llp_reg           (ch_4_llp_reg           ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_4_lld_bus_inf_idx   (ch_4_lld_bus_inf_idx   ),
   `endif
`endif
	.ch_4_tts               (ch_4_tts               ),
	.ch_4_abt               (ch_4_abt               ),
	.ch_5_en                (ch_5_en                ),
	.ch_5_int_tc_mask       (ch_5_int_tc_mask       ),
	.ch_5_int_err_mask      (ch_5_int_err_mask      ),
	.ch_5_int_abt_mask      (ch_5_int_abt_mask      ),
	.ch_5_src_req_sel       (ch_5_src_req_sel       ),
	.ch_5_dst_req_sel       (ch_5_dst_req_sel       ),
	.ch_5_src_addr_ctl      (ch_5_src_addr_ctl      ),
	.ch_5_dst_addr_ctl      (ch_5_dst_addr_ctl      ),
	.ch_5_src_mode          (ch_5_src_mode          ),
	.ch_5_dst_mode          (ch_5_dst_mode          ),
	.ch_5_src_width         (ch_5_src_width         ),
	.ch_5_dst_width         (ch_5_dst_width         ),
	.ch_5_src_burst_size    (ch_5_src_burst_size    ),
	.ch_5_priority          (ch_5_priority          ),
	.ch_5_src_addr          (ch_5_src_addr          ),
	.ch_5_dst_addr          (ch_5_dst_addr          ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_5_src_bus_inf_idx   (ch_5_src_bus_inf_idx   ),
	.ch_5_dst_bus_inf_idx   (ch_5_dst_bus_inf_idx   ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_5_llp_reg           (ch_5_llp_reg           ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_5_lld_bus_inf_idx   (ch_5_lld_bus_inf_idx   ),
   `endif
`endif
	.ch_5_tts               (ch_5_tts               ),
	.ch_5_abt               (ch_5_abt               ),
	.ch_6_en                (ch_6_en                ),
	.ch_6_int_tc_mask       (ch_6_int_tc_mask       ),
	.ch_6_int_err_mask      (ch_6_int_err_mask      ),
	.ch_6_int_abt_mask      (ch_6_int_abt_mask      ),
	.ch_6_src_req_sel       (ch_6_src_req_sel       ),
	.ch_6_dst_req_sel       (ch_6_dst_req_sel       ),
	.ch_6_src_addr_ctl      (ch_6_src_addr_ctl      ),
	.ch_6_dst_addr_ctl      (ch_6_dst_addr_ctl      ),
	.ch_6_src_mode          (ch_6_src_mode          ),
	.ch_6_dst_mode          (ch_6_dst_mode          ),
	.ch_6_src_width         (ch_6_src_width         ),
	.ch_6_dst_width         (ch_6_dst_width         ),
	.ch_6_src_burst_size    (ch_6_src_burst_size    ),
	.ch_6_priority          (ch_6_priority          ),
	.ch_6_src_addr          (ch_6_src_addr          ),
	.ch_6_dst_addr          (ch_6_dst_addr          ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_6_src_bus_inf_idx   (ch_6_src_bus_inf_idx   ),
	.ch_6_dst_bus_inf_idx   (ch_6_dst_bus_inf_idx   ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_6_llp_reg           (ch_6_llp_reg           ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_6_lld_bus_inf_idx   (ch_6_lld_bus_inf_idx   ),
   `endif
`endif
	.ch_6_tts               (ch_6_tts               ),
	.ch_6_abt               (ch_6_abt               ),
	.ch_7_en                (ch_7_en                ),
	.ch_7_int_tc_mask       (ch_7_int_tc_mask       ),
	.ch_7_int_err_mask      (ch_7_int_err_mask      ),
	.ch_7_int_abt_mask      (ch_7_int_abt_mask      ),
	.ch_7_src_req_sel       (ch_7_src_req_sel       ),
	.ch_7_dst_req_sel       (ch_7_dst_req_sel       ),
	.ch_7_src_addr_ctl      (ch_7_src_addr_ctl      ),
	.ch_7_dst_addr_ctl      (ch_7_dst_addr_ctl      ),
	.ch_7_src_mode          (ch_7_src_mode          ),
	.ch_7_dst_mode          (ch_7_dst_mode          ),
	.ch_7_src_width         (ch_7_src_width         ),
	.ch_7_dst_width         (ch_7_dst_width         ),
	.ch_7_src_burst_size    (ch_7_src_burst_size    ),
	.ch_7_priority          (ch_7_priority          ),
	.ch_7_src_addr          (ch_7_src_addr          ),
	.ch_7_dst_addr          (ch_7_dst_addr          ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_7_src_bus_inf_idx   (ch_7_src_bus_inf_idx   ),
	.ch_7_dst_bus_inf_idx   (ch_7_dst_bus_inf_idx   ),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_7_llp_reg           (ch_7_llp_reg           ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_7_lld_bus_inf_idx   (ch_7_lld_bus_inf_idx   ),
   `endif
`endif
	.ch_7_tts               (ch_7_tts               ),
	.ch_7_abt               (ch_7_abt               ),
`ifdef DMAC_CONFIG_CH0
	.dma0_ch_0_ctl_wen      (dma0_ch_0_ctl_wen      ),
	.dma0_ch_0_en_wen       (dma0_ch_0_en_wen       ),
	.dma0_ch_0_src_addr_wen (dma0_ch_0_src_addr_wen ),
	.dma0_ch_0_dst_addr_wen (dma0_ch_0_dst_addr_wen ),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_0_llp_wen      (dma0_ch_0_llp_wen      ),
   `endif
	.dma0_ch_0_tts_wen      (dma0_ch_0_tts_wen      ),
	.dma0_ch_0_tc_wen       (dma0_ch_0_tc_wen       ),
	.dma0_ch_0_err_wen      (dma0_ch_0_err_wen      ),
	.dma0_ch_0_int_wen      (dma0_ch_0_int_wen      ),
`endif
`ifdef DMAC_CONFIG_CH1
	.dma0_ch_1_ctl_wen      (dma0_ch_1_ctl_wen      ),
	.dma0_ch_1_en_wen       (dma0_ch_1_en_wen       ),
	.dma0_ch_1_src_addr_wen (dma0_ch_1_src_addr_wen ),
	.dma0_ch_1_dst_addr_wen (dma0_ch_1_dst_addr_wen ),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_1_llp_wen      (dma0_ch_1_llp_wen      ),
   `endif
	.dma0_ch_1_tts_wen      (dma0_ch_1_tts_wen      ),
	.dma0_ch_1_tc_wen       (dma0_ch_1_tc_wen       ),
	.dma0_ch_1_err_wen      (dma0_ch_1_err_wen      ),
	.dma0_ch_1_int_wen      (dma0_ch_1_int_wen      ),
`endif
`ifdef DMAC_CONFIG_CH2
	.dma0_ch_2_ctl_wen      (dma0_ch_2_ctl_wen      ),
	.dma0_ch_2_en_wen       (dma0_ch_2_en_wen       ),
	.dma0_ch_2_src_addr_wen (dma0_ch_2_src_addr_wen ),
	.dma0_ch_2_dst_addr_wen (dma0_ch_2_dst_addr_wen ),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_2_llp_wen      (dma0_ch_2_llp_wen      ),
   `endif
	.dma0_ch_2_tts_wen      (dma0_ch_2_tts_wen      ),
	.dma0_ch_2_tc_wen       (dma0_ch_2_tc_wen       ),
	.dma0_ch_2_err_wen      (dma0_ch_2_err_wen      ),
	.dma0_ch_2_int_wen      (dma0_ch_2_int_wen      ),
`endif
`ifdef DMAC_CONFIG_CH3
	.dma0_ch_3_ctl_wen      (dma0_ch_3_ctl_wen      ),
	.dma0_ch_3_en_wen       (dma0_ch_3_en_wen       ),
	.dma0_ch_3_src_addr_wen (dma0_ch_3_src_addr_wen ),
	.dma0_ch_3_dst_addr_wen (dma0_ch_3_dst_addr_wen ),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_3_llp_wen      (dma0_ch_3_llp_wen      ),
   `endif
	.dma0_ch_3_tts_wen      (dma0_ch_3_tts_wen      ),
	.dma0_ch_3_tc_wen       (dma0_ch_3_tc_wen       ),
	.dma0_ch_3_err_wen      (dma0_ch_3_err_wen      ),
	.dma0_ch_3_int_wen      (dma0_ch_3_int_wen      ),
`endif
`ifdef DMAC_CONFIG_CH4
	.dma0_ch_4_ctl_wen      (dma0_ch_4_ctl_wen      ),
	.dma0_ch_4_en_wen       (dma0_ch_4_en_wen       ),
	.dma0_ch_4_src_addr_wen (dma0_ch_4_src_addr_wen ),
	.dma0_ch_4_dst_addr_wen (dma0_ch_4_dst_addr_wen ),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_4_llp_wen      (dma0_ch_4_llp_wen      ),
   `endif
	.dma0_ch_4_tts_wen      (dma0_ch_4_tts_wen      ),
	.dma0_ch_4_tc_wen       (dma0_ch_4_tc_wen       ),
	.dma0_ch_4_err_wen      (dma0_ch_4_err_wen      ),
	.dma0_ch_4_int_wen      (dma0_ch_4_int_wen      ),
`endif
`ifdef DMAC_CONFIG_CH5
	.dma0_ch_5_ctl_wen      (dma0_ch_5_ctl_wen      ),
	.dma0_ch_5_en_wen       (dma0_ch_5_en_wen       ),
	.dma0_ch_5_src_addr_wen (dma0_ch_5_src_addr_wen ),
	.dma0_ch_5_dst_addr_wen (dma0_ch_5_dst_addr_wen ),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_5_llp_wen      (dma0_ch_5_llp_wen      ),
   `endif
	.dma0_ch_5_tts_wen      (dma0_ch_5_tts_wen      ),
	.dma0_ch_5_tc_wen       (dma0_ch_5_tc_wen       ),
	.dma0_ch_5_err_wen      (dma0_ch_5_err_wen      ),
	.dma0_ch_5_int_wen      (dma0_ch_5_int_wen      ),
`endif
`ifdef DMAC_CONFIG_CH6
	.dma0_ch_6_ctl_wen      (dma0_ch_6_ctl_wen      ),
	.dma0_ch_6_en_wen       (dma0_ch_6_en_wen       ),
	.dma0_ch_6_src_addr_wen (dma0_ch_6_src_addr_wen ),
	.dma0_ch_6_dst_addr_wen (dma0_ch_6_dst_addr_wen ),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_6_llp_wen      (dma0_ch_6_llp_wen      ),
   `endif
	.dma0_ch_6_tts_wen      (dma0_ch_6_tts_wen      ),
	.dma0_ch_6_tc_wen       (dma0_ch_6_tc_wen       ),
	.dma0_ch_6_err_wen      (dma0_ch_6_err_wen      ),
	.dma0_ch_6_int_wen      (dma0_ch_6_int_wen      ),
`endif
`ifdef DMAC_CONFIG_CH7
	.dma0_ch_7_ctl_wen      (dma0_ch_7_ctl_wen      ),
	.dma0_ch_7_en_wen       (dma0_ch_7_en_wen       ),
	.dma0_ch_7_src_addr_wen (dma0_ch_7_src_addr_wen ),
	.dma0_ch_7_dst_addr_wen (dma0_ch_7_dst_addr_wen ),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_7_llp_wen      (dma0_ch_7_llp_wen      ),
   `endif
	.dma0_ch_7_tts_wen      (dma0_ch_7_tts_wen      ),
	.dma0_ch_7_tc_wen       (dma0_ch_7_tc_wen       ),
	.dma0_ch_7_err_wen      (dma0_ch_7_err_wen      ),
	.dma0_ch_7_int_wen      (dma0_ch_7_int_wen      ),
`endif
	.granted_channel        (granted_channel        ),
	.ch_request             (ch_request             ),
	.ch_level               (ch_level               ),
	.current_channel        (current_channel        ),
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	.dma1_idle_state        (dma1_idle_state        ),
	.dma1_ch_ctl_wen        (dma1_ch_ctl_wen        ),
	.dma1_ch_en_wen         (dma1_ch_en_wen         ),
	.dma1_ch_src_addr_wen   (dma1_ch_src_addr_wen   ),
	.dma1_ch_dst_addr_wen   (dma1_ch_dst_addr_wen   ),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_llp_wen        (dma1_ch_llp_wen        ),
   `endif
	.dma1_ch_tts_wen        (dma1_ch_tts_wen        ),
	.dma1_ch_tc_wen         (dma1_ch_tc_wen         ),
	.dma1_ch_err_wen        (dma1_ch_err_wen        ),
	.dma1_ch_int_wen        (dma1_ch_int_wen        ),
	.dma1_ch_src_ack        (dma1_ch_src_ack        ),
	.dma1_ch_dst_ack        (dma1_ch_dst_ack        ),
	.dma1_arb_end           (dma1_arb_end           ),
	.dma1_current_channel   (dma1_current_channel   ),
	.dma1_ch_src_addr_ctl   (dma1_ch_src_addr_ctl   ),
	.dma1_ch_dst_addr_ctl   (dma1_ch_dst_addr_ctl   ),
	.dma1_ch_src_width      (dma1_ch_src_width      ),
	.dma1_ch_dst_width      (dma1_ch_dst_width      ),
	.dma1_ch_src_burst_size (dma1_ch_src_burst_size ),
	.dma1_ch_src_mode       (dma1_ch_src_mode       ),
	.dma1_ch_src_request    (dma1_ch_src_request    ),
	.dma1_ch_dst_mode       (dma1_ch_dst_mode       ),
	.dma1_ch_dst_request    (dma1_ch_dst_request    ),
	.dma1_ch_tts            (dma1_ch_tts            ),
	.dma1_ch_src_addr       (dma1_ch_src_addr       ),
	.dma1_ch_dst_addr       (dma1_ch_dst_addr       ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma1_ch_src_bus_inf_idx(dma1_ch_src_bus_inf_idx),
	.dma1_ch_dst_bus_inf_idx(dma1_ch_dst_bus_inf_idx),
   `endif
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_llp            (dma1_ch_llp            ),
      `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma1_ch_lld_bus_inf_idx(dma1_ch_lld_bus_inf_idx),
      `endif
   `endif
	.dma1_ch_abt            (dma1_ch_abt            ),
	.dma1_ch_int_tc_mask    (dma1_ch_int_tc_mask    ),
	.dma1_ch_int_err_mask   (dma1_ch_int_err_mask   ),
	.dma1_ch_int_abt_mask   (dma1_ch_int_abt_mask   ),
   `ifdef DMAC_CONFIG_CH0
	.dma1_ch_0_ctl_wen      (dma1_ch_0_ctl_wen      ),
	.dma1_ch_0_en_wen       (dma1_ch_0_en_wen       ),
	.dma1_ch_0_src_addr_wen (dma1_ch_0_src_addr_wen ),
	.dma1_ch_0_dst_addr_wen (dma1_ch_0_dst_addr_wen ),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_0_llp_wen      (dma1_ch_0_llp_wen      ),
      `endif
	.dma1_ch_0_tts_wen      (dma1_ch_0_tts_wen      ),
	.dma1_ch_0_tc_wen       (dma1_ch_0_tc_wen       ),
	.dma1_ch_0_err_wen      (dma1_ch_0_err_wen      ),
	.dma1_ch_0_int_wen      (dma1_ch_0_int_wen      ),
   `endif
   `ifdef DMAC_CONFIG_CH1
	.dma1_ch_1_ctl_wen      (dma1_ch_1_ctl_wen      ),
	.dma1_ch_1_en_wen       (dma1_ch_1_en_wen       ),
	.dma1_ch_1_src_addr_wen (dma1_ch_1_src_addr_wen ),
	.dma1_ch_1_dst_addr_wen (dma1_ch_1_dst_addr_wen ),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_1_llp_wen      (dma1_ch_1_llp_wen      ),
      `endif
	.dma1_ch_1_tts_wen      (dma1_ch_1_tts_wen      ),
	.dma1_ch_1_tc_wen       (dma1_ch_1_tc_wen       ),
	.dma1_ch_1_err_wen      (dma1_ch_1_err_wen      ),
	.dma1_ch_1_int_wen      (dma1_ch_1_int_wen      ),
   `endif
   `ifdef DMAC_CONFIG_CH2
	.dma1_ch_2_ctl_wen      (dma1_ch_2_ctl_wen      ),
	.dma1_ch_2_en_wen       (dma1_ch_2_en_wen       ),
	.dma1_ch_2_src_addr_wen (dma1_ch_2_src_addr_wen ),
	.dma1_ch_2_dst_addr_wen (dma1_ch_2_dst_addr_wen ),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_2_llp_wen      (dma1_ch_2_llp_wen      ),
      `endif
	.dma1_ch_2_tts_wen      (dma1_ch_2_tts_wen      ),
	.dma1_ch_2_tc_wen       (dma1_ch_2_tc_wen       ),
	.dma1_ch_2_err_wen      (dma1_ch_2_err_wen      ),
	.dma1_ch_2_int_wen      (dma1_ch_2_int_wen      ),
   `endif
   `ifdef DMAC_CONFIG_CH3
	.dma1_ch_3_ctl_wen      (dma1_ch_3_ctl_wen      ),
	.dma1_ch_3_en_wen       (dma1_ch_3_en_wen       ),
	.dma1_ch_3_src_addr_wen (dma1_ch_3_src_addr_wen ),
	.dma1_ch_3_dst_addr_wen (dma1_ch_3_dst_addr_wen ),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_3_llp_wen      (dma1_ch_3_llp_wen      ),
      `endif
	.dma1_ch_3_tts_wen      (dma1_ch_3_tts_wen      ),
	.dma1_ch_3_tc_wen       (dma1_ch_3_tc_wen       ),
	.dma1_ch_3_err_wen      (dma1_ch_3_err_wen      ),
	.dma1_ch_3_int_wen      (dma1_ch_3_int_wen      ),
   `endif
   `ifdef DMAC_CONFIG_CH4
	.dma1_ch_4_ctl_wen      (dma1_ch_4_ctl_wen      ),
	.dma1_ch_4_en_wen       (dma1_ch_4_en_wen       ),
	.dma1_ch_4_src_addr_wen (dma1_ch_4_src_addr_wen ),
	.dma1_ch_4_dst_addr_wen (dma1_ch_4_dst_addr_wen ),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_4_llp_wen      (dma1_ch_4_llp_wen      ),
      `endif
	.dma1_ch_4_tts_wen      (dma1_ch_4_tts_wen      ),
	.dma1_ch_4_tc_wen       (dma1_ch_4_tc_wen       ),
	.dma1_ch_4_err_wen      (dma1_ch_4_err_wen      ),
	.dma1_ch_4_int_wen      (dma1_ch_4_int_wen      ),
   `endif
   `ifdef DMAC_CONFIG_CH5
	.dma1_ch_5_ctl_wen      (dma1_ch_5_ctl_wen      ),
	.dma1_ch_5_en_wen       (dma1_ch_5_en_wen       ),
	.dma1_ch_5_src_addr_wen (dma1_ch_5_src_addr_wen ),
	.dma1_ch_5_dst_addr_wen (dma1_ch_5_dst_addr_wen ),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_5_llp_wen      (dma1_ch_5_llp_wen      ),
      `endif
	.dma1_ch_5_tts_wen      (dma1_ch_5_tts_wen      ),
	.dma1_ch_5_tc_wen       (dma1_ch_5_tc_wen       ),
	.dma1_ch_5_err_wen      (dma1_ch_5_err_wen      ),
	.dma1_ch_5_int_wen      (dma1_ch_5_int_wen      ),
   `endif
   `ifdef DMAC_CONFIG_CH6
	.dma1_ch_6_ctl_wen      (dma1_ch_6_ctl_wen      ),
	.dma1_ch_6_en_wen       (dma1_ch_6_en_wen       ),
	.dma1_ch_6_src_addr_wen (dma1_ch_6_src_addr_wen ),
	.dma1_ch_6_dst_addr_wen (dma1_ch_6_dst_addr_wen ),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_6_llp_wen      (dma1_ch_6_llp_wen      ),
      `endif
	.dma1_ch_6_tts_wen      (dma1_ch_6_tts_wen      ),
	.dma1_ch_6_tc_wen       (dma1_ch_6_tc_wen       ),
	.dma1_ch_6_err_wen      (dma1_ch_6_err_wen      ),
	.dma1_ch_6_int_wen      (dma1_ch_6_int_wen      ),
   `endif
   `ifdef DMAC_CONFIG_CH7
	.dma1_ch_7_ctl_wen      (dma1_ch_7_ctl_wen      ),
	.dma1_ch_7_en_wen       (dma1_ch_7_en_wen       ),
	.dma1_ch_7_src_addr_wen (dma1_ch_7_src_addr_wen ),
	.dma1_ch_7_dst_addr_wen (dma1_ch_7_dst_addr_wen ),
      `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma1_ch_7_llp_wen      (dma1_ch_7_llp_wen      ),
      `endif
	.dma1_ch_7_tts_wen      (dma1_ch_7_tts_wen      ),
	.dma1_ch_7_tc_wen       (dma1_ch_7_tc_wen       ),
	.dma1_ch_7_err_wen      (dma1_ch_7_err_wen      ),
	.dma1_ch_7_int_wen      (dma1_ch_7_int_wen      ),
   `endif
`endif
	.dma0_idle_state        (dma0_idle_state        ),
	.dma0_ch_ctl_wen        (dma0_ch_ctl_wen        ),
	.dma0_ch_en_wen         (dma0_ch_en_wen         ),
	.dma0_ch_src_addr_wen   (dma0_ch_src_addr_wen   ),
	.dma0_ch_dst_addr_wen   (dma0_ch_dst_addr_wen   ),
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_llp_wen        (dma0_ch_llp_wen        ),
`endif
	.dma0_ch_tts_wen        (dma0_ch_tts_wen        ),
	.dma0_ch_tc_wen         (dma0_ch_tc_wen         ),
	.dma0_ch_err_wen        (dma0_ch_err_wen        ),
	.dma0_ch_int_wen        (dma0_ch_int_wen        ),
	.dma0_ch_src_ack        (dma0_ch_src_ack        ),
	.dma0_ch_dst_ack        (dma0_ch_dst_ack        ),
	.dma0_arb_end           (dma0_arb_end           ),
	.dma0_current_channel   (dma0_current_channel   ),
	.dma0_ch_src_addr_ctl   (dma0_ch_src_addr_ctl   ),
	.dma0_ch_dst_addr_ctl   (dma0_ch_dst_addr_ctl   ),
	.dma0_ch_src_width      (dma0_ch_src_width      ),
	.dma0_ch_dst_width      (dma0_ch_dst_width      ),
	.dma0_ch_src_burst_size (dma0_ch_src_burst_size ),
	.dma0_ch_src_mode       (dma0_ch_src_mode       ),
	.dma0_ch_src_request    (dma0_ch_src_request    ),
	.dma0_ch_dst_mode       (dma0_ch_dst_mode       ),
	.dma0_ch_dst_request    (dma0_ch_dst_request    ),
	.dma0_ch_tts            (dma0_ch_tts            ),
	.dma0_ch_src_addr       (dma0_ch_src_addr       ),
	.dma0_ch_dst_addr       (dma0_ch_dst_addr       ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma0_ch_src_bus_inf_idx(dma0_ch_src_bus_inf_idx),
	.dma0_ch_dst_bus_inf_idx(dma0_ch_dst_bus_inf_idx),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma0_ch_llp            (dma0_ch_llp            ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma0_ch_lld_bus_inf_idx(dma0_ch_lld_bus_inf_idx),
   `endif
`endif
	.dma0_ch_abt            (dma0_ch_abt            ),
	.dma0_ch_int_tc_mask    (dma0_ch_int_tc_mask    ),
	.dma0_ch_int_err_mask   (dma0_ch_int_err_mask   ),
	.dma0_ch_int_abt_mask   (dma0_ch_int_abt_mask   )
);

atcdmac300_aximst atcdmac300_aximst_0 (
	.aclk                (aclk                ),
	.aresetn             (aresetn             ),
	.awid                (m0_awid             ),
	.awaddr              (m0_awaddr           ),
	.awlen               (m0_awlen            ),
	.awsize              (m0_awsize           ),
	.awburst             (m0_awburst          ),
	.awlock              (m0_awlock           ),
	.awcache             (m0_awcache          ),
	.awprot              (m0_awprot           ),
	.awvalid             (m0_awvalid          ),
	.awready             (m0_awready          ),
	.wstrb               (m0_wstrb            ),
	.wlast               (m0_wlast            ),
	.wdata               (m0_wdata            ),
	.wvalid              (m0_wvalid           ),
	.wready              (m0_wready           ),
	.bid                 (m0_bid              ),
	.bresp               (m0_bresp            ),
	.bvalid              (m0_bvalid           ),
	.bready              (m0_bready           ),
	.arid                (m0_arid             ),
	.araddr              (m0_araddr           ),
	.arlen               (m0_arlen            ),
	.arsize              (m0_arsize           ),
	.arburst             (m0_arburst          ),
	.arlock              (m0_arlock           ),
	.arcache             (m0_arcache          ),
	.arprot              (m0_arprot           ),
	.arvalid             (m0_arvalid          ),
	.arready             (m0_arready          ),
	.rid                 (m0_rid              ),
	.rresp               (m0_rresp            ),
	.rlast               (m0_rlast            ),
	.rdata               (m0_rdata            ),
	.rvalid              (m0_rvalid           ),
	.rready              (m0_rready           ),
`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	.dma1_mst_wr_mask    (dma1_mst_wr_mask    ),
	.dma1_mst_req        (s24       ),
	.dma1_mst_addr       (s21      ),
	.dma1_mst_write      (s27     ),
	.dma1_mst_size       (s25      ),
	.dma1_mst_fix        (s22       ),
	.dma1_mst_len        (s23       ),
	.dma1_mst_wdata      (s26     ),
	.dma1_current_channel(dma1_current_channel),
	.mst_dma1_grant      (s16     ),
	.mst_dma1_rd_ack     (s17    ),
	.mst_dma1_wr_ack     (s20    ),
	.mst_dma1_rdata      (s18     ),
	.mst_dma1_rlast      (s19     ),
	.mst_dma1_error      (s15     ),
	.mst_dma1_bvalid     (s14    ),
`endif
	.dma0_mst_wr_mask    (dma0_mst_wr_mask    ),
	.dma0_mst_req        (s52       ),
	.dma0_mst_addr       (s49      ),
	.dma0_mst_write      (s55     ),
	.dma0_mst_size       (s53      ),
	.dma0_mst_fix        (s50       ),
	.dma0_mst_len        (s51       ),
	.dma0_mst_wdata      (s54     ),
	.dma0_current_channel(dma0_current_channel),
	.mst_dma0_grant      (s44     ),
	.mst_dma0_rd_ack     (s45    ),
	.mst_dma0_wr_ack     (s48    ),
	.mst_dma0_rdata      (s46     ),
	.mst_dma0_rlast      (s47     ),
	.mst_dma0_error      (s43     ),
	.mst_dma0_bvalid     (s42    )
);

`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
atcdmac300_aximst atcdmac300_aximst_1 (
	.aclk                (aclk                ),
	.aresetn             (aresetn             ),
	.awid                (m1_awid             ),
	.awaddr              (m1_awaddr           ),
	.awlen               (m1_awlen            ),
	.awsize              (m1_awsize           ),
	.awburst             (m1_awburst          ),
	.awlock              (m1_awlock           ),
	.awcache             (m1_awcache          ),
	.awprot              (m1_awprot           ),
	.awvalid             (m1_awvalid          ),
	.awready             (m1_awready          ),
	.wstrb               (m1_wstrb            ),
	.wlast               (m1_wlast            ),
	.wdata               (m1_wdata            ),
	.wvalid              (m1_wvalid           ),
	.wready              (m1_wready           ),
	.bid                 (m1_bid              ),
	.bresp               (m1_bresp            ),
	.bvalid              (m1_bvalid           ),
	.bready              (m1_bready           ),
	.arid                (m1_arid             ),
	.araddr              (m1_araddr           ),
	.arlen               (m1_arlen            ),
	.arsize              (m1_arsize           ),
	.arburst             (m1_arburst          ),
	.arlock              (m1_arlock           ),
	.arcache             (m1_arcache          ),
	.arprot              (m1_arprot           ),
	.arvalid             (m1_arvalid          ),
	.arready             (m1_arready          ),
	.rid                 (m1_rid              ),
	.rresp               (m1_rresp            ),
	.rlast               (m1_rlast            ),
	.rdata               (m1_rdata            ),
	.rvalid              (m1_rvalid           ),
	.rready              (m1_rready           ),
   `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
	.dma1_mst_wr_mask    (dma1_mst_wr_mask    ),
	.dma1_mst_req        (s38       ),
	.dma1_mst_addr       (s35      ),
	.dma1_mst_write      (s41     ),
	.dma1_mst_size       (s39      ),
	.dma1_mst_fix        (s36       ),
	.dma1_mst_len        (s37       ),
	.dma1_mst_wdata      (s40     ),
	.dma1_current_channel(dma1_current_channel),
	.mst_dma1_grant      (s30     ),
	.mst_dma1_rd_ack     (s31    ),
	.mst_dma1_wr_ack     (s34    ),
	.mst_dma1_rdata      (s32     ),
	.mst_dma1_rlast      (s33     ),
	.mst_dma1_error      (s29     ),
	.mst_dma1_bvalid     (s28    ),
   `endif
	.dma0_mst_wr_mask    (dma0_mst_wr_mask    ),
	.dma0_mst_req        (s10       ),
	.dma0_mst_addr       (s7      ),
	.dma0_mst_write      (s13     ),
	.dma0_mst_size       (s11      ),
	.dma0_mst_fix        (s8       ),
	.dma0_mst_len        (s9       ),
	.dma0_mst_wdata      (s12     ),
	.dma0_current_channel(dma0_current_channel),
	.mst_dma0_grant      (s2     ),
	.mst_dma0_rd_ack     (s3    ),
	.mst_dma0_wr_ack     (s6    ),
	.mst_dma0_rdata      (s4     ),
	.mst_dma0_rlast      (s5     ),
	.mst_dma0_error      (s1     ),
	.mst_dma0_bvalid     (s0    )
);

`endif
atcdmac300_engine atcdmac300_engine_0 (
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_mst1_req         (s10          ),
	.dma_mst1_addr        (s7         ),
	.dma_mst1_write       (s13        ),
	.dma_mst1_size        (s11         ),
	.dma_mst1_fix         (s8          ),
	.dma_mst1_wdata       (s12        ),
	.dma_mst1_len         (s9          ),
	.mst1_dma_grant       (s2        ),
	.mst1_dma_rd_ack      (s3       ),
	.mst1_dma_wr_ack      (s6       ),
	.mst1_dma_rdata       (s4        ),
	.mst1_dma_rlast       (s5        ),
	.mst1_dma_bvalid      (s0       ),
	.mst1_dma_error       (s1        ),
`endif
	.dma_mst0_req         (s52          ),
	.dma_mst_wr_mask      (dma0_mst_wr_mask       ),
	.dma_mst0_addr        (s49         ),
	.dma_mst0_write       (s55        ),
	.dma_mst0_size        (s53         ),
	.dma_mst0_fix         (s50          ),
	.dma_mst0_wdata       (s54        ),
	.dma_mst0_len         (s51          ),
	.mst0_dma_grant       (s44        ),
	.mst0_dma_rd_ack      (s45       ),
	.mst0_dma_wr_ack      (s48       ),
	.mst0_dma_rdata       (s46        ),
	.mst0_dma_rlast       (s47        ),
	.mst0_dma_bvalid      (s42       ),
	.mst0_dma_error       (s43        ),
	.idle_state           (dma0_idle_state        ),
	.arb_end              (dma0_arb_end           ),
	.ch_src_addr_ctl      (dma0_ch_src_addr_ctl   ),
	.ch_dst_addr_ctl      (dma0_ch_dst_addr_ctl   ),
	.ch_src_width         (dma0_ch_src_width      ),
	.ch_dst_width         (dma0_ch_dst_width      ),
	.ch_src_burst_size    (dma0_ch_src_burst_size ),
	.ch_src_mode          (dma0_ch_src_mode       ),
	.ch_src_request       (dma0_ch_src_request    ),
	.ch_dst_mode          (dma0_ch_dst_mode       ),
	.ch_dst_request       (dma0_ch_dst_request    ),
	.ch_tts               (dma0_ch_tts            ),
	.ch_src_addr          (dma0_ch_src_addr       ),
	.ch_dst_addr          (dma0_ch_dst_addr       ),
	.ch_int_tc_mask       (dma0_ch_int_tc_mask    ),
	.ch_int_err_mask      (dma0_ch_int_err_mask   ),
	.ch_int_abt_mask      (dma0_ch_int_abt_mask   ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_src_bus_inf_idx   (dma0_ch_src_bus_inf_idx),
	.ch_dst_bus_inf_idx   (dma0_ch_dst_bus_inf_idx),
`endif
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_llp               (dma0_ch_llp            ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_lld_bus_inf_idx   (dma0_ch_lld_bus_inf_idx),
   `endif
`endif
	.ch_abt               (dma0_ch_abt            ),
	.dma_ch_src_ack       (dma0_ch_src_ack        ),
	.dma_ch_dst_ack       (dma0_ch_dst_ack        ),
	.dma_ch_ctl_wen       (dma0_ch_ctl_wen        ),
	.dma_ch_en_wen        (dma0_ch_en_wen         ),
	.dma_ch_src_addr_wen  (dma0_ch_src_addr_wen   ),
	.dma_ch_dst_addr_wen  (dma0_ch_dst_addr_wen   ),
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma_ch_llp_wen       (dma0_ch_llp_wen        ),
`endif
	.dma_ch_tts_wen       (dma0_ch_tts_wen        ),
	.dma_ch_tc_wen        (dma0_ch_tc_wen         ),
	.dma_ch_err_wen       (dma0_ch_err_wen        ),
	.dma_ch_int_wen       (dma0_ch_int_wen        ),
	.dma_ch_ctl_wdata     (dma0_ch_ctl_wdata      ),
	.dma_ch_ctl_wdata_pri (dma0_ch_ctl_wdata_pri  ),
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_ch_ctl_wdata_idx (dma0_ch_ctl_wdata_idx  ),
`endif
	.dma_ch_tts_wdata     (dma0_ch_tts_wdata      ),
	.dma_ch_src_addr_wdata(dma0_ch_src_addr_wdata ),
	.dma_ch_dst_addr_wdata(dma0_ch_dst_addr_wdata ),
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma_ch_llp_wdata     (dma0_ch_llp_wdata      ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_ch_llp_wdata_idx (dma0_ch_llp_wdata_idx  ),
   `endif
`endif
	.aclk                 (aclk                   ),
	.aresetn              (aresetn                ),
	.dma_soft_reset       (dma_soft_reset         )
);

`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
atcdmac300_engine atcdmac300_engine_1 (
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_mst1_req         (s38          ),
	.dma_mst1_addr        (s35         ),
	.dma_mst1_write       (s41        ),
	.dma_mst1_size        (s39         ),
	.dma_mst1_fix         (s36          ),
	.dma_mst1_wdata       (s40        ),
	.dma_mst1_len         (s37          ),
	.mst1_dma_grant       (s30        ),
	.mst1_dma_rd_ack      (s31       ),
	.mst1_dma_wr_ack      (s34       ),
	.mst1_dma_rdata       (s32        ),
	.mst1_dma_rlast       (s33        ),
	.mst1_dma_bvalid      (s28       ),
	.mst1_dma_error       (s29        ),
   `endif
	.dma_mst0_req         (s24          ),
	.dma_mst_wr_mask      (dma1_mst_wr_mask       ),
	.dma_mst0_addr        (s21         ),
	.dma_mst0_write       (s27        ),
	.dma_mst0_size        (s25         ),
	.dma_mst0_fix         (s22          ),
	.dma_mst0_wdata       (s26        ),
	.dma_mst0_len         (s23          ),
	.mst0_dma_grant       (s16        ),
	.mst0_dma_rd_ack      (s17       ),
	.mst0_dma_wr_ack      (s20       ),
	.mst0_dma_rdata       (s18        ),
	.mst0_dma_rlast       (s19        ),
	.mst0_dma_bvalid      (s14       ),
	.mst0_dma_error       (s15        ),
	.idle_state           (dma1_idle_state        ),
	.arb_end              (dma1_arb_end           ),
	.ch_src_addr_ctl      (dma1_ch_src_addr_ctl   ),
	.ch_dst_addr_ctl      (dma1_ch_dst_addr_ctl   ),
	.ch_src_width         (dma1_ch_src_width      ),
	.ch_dst_width         (dma1_ch_dst_width      ),
	.ch_src_burst_size    (dma1_ch_src_burst_size ),
	.ch_src_mode          (dma1_ch_src_mode       ),
	.ch_src_request       (dma1_ch_src_request    ),
	.ch_dst_mode          (dma1_ch_dst_mode       ),
	.ch_dst_request       (dma1_ch_dst_request    ),
	.ch_tts               (dma1_ch_tts            ),
	.ch_src_addr          (dma1_ch_src_addr       ),
	.ch_dst_addr          (dma1_ch_dst_addr       ),
	.ch_int_tc_mask       (dma1_ch_int_tc_mask    ),
	.ch_int_err_mask      (dma1_ch_int_err_mask   ),
	.ch_int_abt_mask      (dma1_ch_int_abt_mask   ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_src_bus_inf_idx   (dma1_ch_src_bus_inf_idx),
	.ch_dst_bus_inf_idx   (dma1_ch_dst_bus_inf_idx),
   `endif
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.ch_llp               (dma1_ch_llp            ),
      `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.ch_lld_bus_inf_idx   (dma1_ch_lld_bus_inf_idx),
      `endif
   `endif
	.ch_abt               (dma1_ch_abt            ),
	.dma_ch_src_ack       (dma1_ch_src_ack        ),
	.dma_ch_dst_ack       (dma1_ch_dst_ack        ),
	.dma_ch_ctl_wen       (dma1_ch_ctl_wen        ),
	.dma_ch_en_wen        (dma1_ch_en_wen         ),
	.dma_ch_src_addr_wen  (dma1_ch_src_addr_wen   ),
	.dma_ch_dst_addr_wen  (dma1_ch_dst_addr_wen   ),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma_ch_llp_wen       (dma1_ch_llp_wen        ),
   `endif
	.dma_ch_tts_wen       (dma1_ch_tts_wen        ),
	.dma_ch_tc_wen        (dma1_ch_tc_wen         ),
	.dma_ch_err_wen       (dma1_ch_err_wen        ),
	.dma_ch_int_wen       (dma1_ch_int_wen        ),
	.dma_ch_ctl_wdata     (dma1_ch_ctl_wdata      ),
	.dma_ch_ctl_wdata_pri (dma1_ch_ctl_wdata_pri  ),
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_ch_ctl_wdata_idx (dma1_ch_ctl_wdata_idx  ),
   `endif
	.dma_ch_tts_wdata     (dma1_ch_tts_wdata      ),
	.dma_ch_src_addr_wdata(dma1_ch_src_addr_wdata ),
	.dma_ch_dst_addr_wdata(dma1_ch_dst_addr_wdata ),
   `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	.dma_ch_llp_wdata     (dma1_ch_llp_wdata      ),
      `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dma_ch_llp_wdata_idx (dma1_ch_llp_wdata_idx  ),
      `endif
   `endif
	.aclk                 (aclk                   ),
	.aresetn              (aresetn                ),
	.dma_soft_reset       (dma_soft_reset         )
);

`endif
endmodule

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




assign /*output       [(`ATCDMAC300_ADDR_WIDTH-1):0]*/ m1_araddr='d0;
assign /*output                                [1:0]*/ m1_arburst='d0;
assign /*output                                [3:0]*/ m1_arcache='d0;
assign /*output                                [2:0]*/ m1_arid='d0;
assign /*output                                [7:0]*/ m1_arlen='d0;
assign /*output                                     */ m1_arlock='d0;
assign /*output                                [2:0]*/ m1_arprot='d0;
assign /*output                                [2:0]*/ m1_arsize='d0;
assign /*output                                     */ m1_arvalid='d0;
assign /*output       [(`ATCDMAC300_ADDR_WIDTH-1):0]*/ m1_awaddr='d0;
assign /*output                                [1:0]*/ m1_awburst='d0;
assign /*output                                [3:0]*/ m1_awcache='d0;
assign /*output                                [2:0]*/ m1_awid='d0;
assign /*output                                [7:0]*/ m1_awlen='d0;
assign /*output                                     */ m1_awlock='d0;
assign /*output                                [2:0]*/ m1_awprot='d0;
assign /*output                                [2:0]*/ m1_awsize='d0;
assign /*output                                     */ m1_awvalid='d0;
assign /*output                                     */ m1_bready='d0;
assign /*output                                     */ m1_rready='d0;
assign /*output              [(`DMA_DATA_WIDTH-1):0]*/ m1_wdata='d0;
assign /*output                                     */ m1_wlast='d0;
assign /*output             [(`DMA_WSTRB_WIDTH-1):0]*/ m1_wstrb='d0;
assign /*output                                     */ m1_wvalid='d0;
assign /*output                               [31:0]*/ prdata='d0;
assign /*output                                     */ pready='d0;
assign /*output                                     */ pslverr='d0;
assign /*output       [(`ATCDMAC300_ADDR_WIDTH-1):0]*/ m0_araddr='d0;
assign /*output                                [1:0]*/ m0_arburst='d0;
assign /*output                                [3:0]*/ m0_arcache='d0;
assign /*output                                [2:0]*/ m0_arid='d0;
assign /*output                                [7:0]*/ m0_arlen='d0;
assign /*output                                     */ m0_arlock='d0;
assign /*output                                [2:0]*/ m0_arprot='d0;
assign /*output                                [2:0]*/ m0_arsize='d0;
assign /*output                                     */ m0_arvalid='d0;
assign /*output       [(`ATCDMAC300_ADDR_WIDTH-1):0]*/ m0_awaddr='d0;
assign /*output                                [1:0]*/ m0_awburst='d0;
assign /*output                                [3:0]*/ m0_awcache='d0;
assign /*output                                [2:0]*/ m0_awid='d0;
assign /*output                                [7:0]*/ m0_awlen='d0;
assign /*output                                     */ m0_awlock='d0;
assign /*output                                [2:0]*/ m0_awprot='d0;
assign /*output                                [2:0]*/ m0_awsize='d0;
assign /*output                                     */ m0_awvalid='d0;
assign /*output                                     */ m0_bready='d0;
assign /*output                                     */ m0_rready='d0;
assign /*output              [(`DMA_DATA_WIDTH-1):0]*/ m0_wdata='d0;
assign /*output                                     */ m0_wlast='d0;
assign /*output             [(`DMA_WSTRB_WIDTH-1):0]*/ m0_wstrb='d0;
assign /*output                                     */ m0_wvalid='d0;
assign /*output      [(`ATCDMAC300_REQ_ACK_NUM-1):0]*/ dma_ack='d0;
assign /*output                                     */ dma_int='d0;








endmodule

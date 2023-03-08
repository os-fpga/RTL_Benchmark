// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc301_config.vh"
`include "atcbmc301_const.vh"


module atcbmc301 (
`ifdef ATCBMC301_MST0_SUPPORT
	  us0_araddr,
	  us0_arburst,
	  us0_arcache,
	  us0_arid,
	  us0_arlen,
	  us0_arlock,
	  us0_arprot,
	  us0_arready,
	  us0_arsize,
	  us0_arvalid,
	  us0_awaddr,
	  us0_awburst,
	  us0_awcache,
	  us0_awid,
	  us0_awlen,
	  us0_awlock,
	  us0_awprot,
	  us0_awready,
	  us0_awsize,
	  us0_awvalid,
	  us0_bid,
	  us0_bready,
	  us0_bresp,
	  us0_bvalid,
	  us0_rdata,
	  us0_rid,
	  us0_rlast,
	  us0_rready,
	  us0_rresp,
	  us0_rvalid,
	  us0_wdata,
	  us0_wlast,
	  us0_wready,
	  us0_wstrb,
	  us0_wvalid,
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
	  ds1_araddr,
	  ds1_arburst,
	  ds1_arcache,
	  ds1_arid,
	  ds1_arlen,
	  ds1_arlock,
	  ds1_arprot,
	  ds1_arready,
	  ds1_arsize,
	  ds1_arvalid,
	  ds1_awaddr,
	  ds1_awburst,
	  ds1_awcache,
	  ds1_awid,
	  ds1_awlen,
	  ds1_awlock,
	  ds1_awprot,
	  ds1_awready,
	  ds1_awsize,
	  ds1_awvalid,
	  ds1_bid,
	  ds1_bready,
	  ds1_bresp,
	  ds1_bvalid,
	  ds1_rdata,
	  ds1_rid,
	  ds1_rlast,
	  ds1_rready,
	  ds1_rresp,
	  ds1_rvalid,
	  ds1_wdata,
	  ds1_wlast,
	  ds1_wready,
	  ds1_wstrb,
	  ds1_wvalid,
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
	  ds2_araddr,
	  ds2_arburst,
	  ds2_arcache,
	  ds2_arid,
	  ds2_arlen,
	  ds2_arlock,
	  ds2_arprot,
	  ds2_arready,
	  ds2_arsize,
	  ds2_arvalid,
	  ds2_awaddr,
	  ds2_awburst,
	  ds2_awcache,
	  ds2_awid,
	  ds2_awlen,
	  ds2_awlock,
	  ds2_awprot,
	  ds2_awready,
	  ds2_awsize,
	  ds2_awvalid,
	  ds2_bid,
	  ds2_bready,
	  ds2_bresp,
	  ds2_bvalid,
	  ds2_rdata,
	  ds2_rid,
	  ds2_rlast,
	  ds2_rready,
	  ds2_rresp,
	  ds2_rvalid,
	  ds2_wdata,
	  ds2_wlast,
	  ds2_wready,
	  ds2_wstrb,
	  ds2_wvalid,
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
	  ds3_araddr,
	  ds3_arburst,
	  ds3_arcache,
	  ds3_arid,
	  ds3_arlen,
	  ds3_arlock,
	  ds3_arprot,
	  ds3_arready,
	  ds3_arsize,
	  ds3_arvalid,
	  ds3_awaddr,
	  ds3_awburst,
	  ds3_awcache,
	  ds3_awid,
	  ds3_awlen,
	  ds3_awlock,
	  ds3_awprot,
	  ds3_awready,
	  ds3_awsize,
	  ds3_awvalid,
	  ds3_bid,
	  ds3_bready,
	  ds3_bresp,
	  ds3_bvalid,
	  ds3_rdata,
	  ds3_rid,
	  ds3_rlast,
	  ds3_rready,
	  ds3_rresp,
	  ds3_rvalid,
	  ds3_wdata,
	  ds3_wlast,
	  ds3_wready,
	  ds3_wstrb,
	  ds3_wvalid,
`endif
`ifdef ATCBMC301_MST1_SUPPORT
	  us1_araddr,
	  us1_arburst,
	  us1_arcache,
	  us1_arid,
	  us1_arlen,
	  us1_arlock,
	  us1_arprot,
	  us1_arready,
	  us1_arsize,
	  us1_arvalid,
	  us1_awaddr,
	  us1_awburst,
	  us1_awcache,
	  us1_awid,
	  us1_awlen,
	  us1_awlock,
	  us1_awprot,
	  us1_awready,
	  us1_awsize,
	  us1_awvalid,
	  us1_bid,
	  us1_bready,
	  us1_bresp,
	  us1_bvalid,
	  us1_rdata,
	  us1_rid,
	  us1_rlast,
	  us1_rready,
	  us1_rresp,
	  us1_rvalid,
	  us1_wdata,
	  us1_wlast,
	  us1_wready,
	  us1_wstrb,
	  us1_wvalid,
`endif
	  aclk,
	  aresetn
);

`ifdef ATCBMC301_ADDR_WIDTH
parameter ADDR_WIDTH = `ATCBMC301_ADDR_WIDTH;
`else
parameter ADDR_WIDTH = 32;
`endif
`ifdef ATCBMC301_DATA_WIDTH
parameter DATA_WIDTH = `ATCBMC301_DATA_WIDTH;
`else
parameter DATA_WIDTH = 64;
`endif
`ifdef ATCBMC301_ID_WIDTH
parameter ID_WIDTH = `ATCBMC301_ID_WIDTH;
`else
parameter ID_WIDTH = 4;
`endif

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam ID_MSB = ID_WIDTH - 1;

`ifdef ATCBMC301_MST0_SUPPORT
input               [ADDR_MSB:0] us0_araddr;
input                      [1:0] us0_arburst;
input                      [3:0] us0_arcache;
input                 [ID_MSB:0] us0_arid;
input                      [7:0] us0_arlen;
input                            us0_arlock;
input                      [2:0] us0_arprot;
output                           us0_arready;
input                      [2:0] us0_arsize;
input                            us0_arvalid;
input               [ADDR_MSB:0] us0_awaddr;
input                      [1:0] us0_awburst;
input                      [3:0] us0_awcache;
input                 [ID_MSB:0] us0_awid;
input                      [7:0] us0_awlen;
input                            us0_awlock;
input                      [2:0] us0_awprot;
output                           us0_awready;
input                      [2:0] us0_awsize;
input                            us0_awvalid;
output                [ID_MSB:0] us0_bid;
input                            us0_bready;
output                     [1:0] us0_bresp;
output                           us0_bvalid;
output              [DATA_MSB:0] us0_rdata;
output                [ID_MSB:0] us0_rid;
output                           us0_rlast;
input                            us0_rready;
output                     [1:0] us0_rresp;
output                           us0_rvalid;
input               [DATA_MSB:0] us0_wdata;
input                            us0_wlast;
output                           us0_wready;
input       [(DATA_WIDTH/8)-1:0] us0_wstrb;
input                            us0_wvalid;
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
output              [ADDR_MSB:0] ds1_araddr;
output                     [1:0] ds1_arburst;
output                     [3:0] ds1_arcache;
output            [(ID_MSB+4):0] ds1_arid;
output                     [7:0] ds1_arlen;
output                           ds1_arlock;
output                     [2:0] ds1_arprot;
input                            ds1_arready;
output                     [2:0] ds1_arsize;
output                           ds1_arvalid;
output              [ADDR_MSB:0] ds1_awaddr;
output                     [1:0] ds1_awburst;
output                     [3:0] ds1_awcache;
output            [(ID_MSB+4):0] ds1_awid;
output                     [7:0] ds1_awlen;
output                           ds1_awlock;
output                     [2:0] ds1_awprot;
input                            ds1_awready;
output                     [2:0] ds1_awsize;
output                           ds1_awvalid;
input               [ID_MSB+4:0] ds1_bid;
output                           ds1_bready;
input                      [1:0] ds1_bresp;
input                            ds1_bvalid;
input               [DATA_MSB:0] ds1_rdata;
input               [ID_MSB+4:0] ds1_rid;
input                            ds1_rlast;
output                           ds1_rready;
input                      [1:0] ds1_rresp;
input                            ds1_rvalid;
output              [DATA_MSB:0] ds1_wdata;
output                           ds1_wlast;
input                            ds1_wready;
output      [(DATA_WIDTH/8)-1:0] ds1_wstrb;
output                           ds1_wvalid;
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
output              [ADDR_MSB:0] ds2_araddr;
output                     [1:0] ds2_arburst;
output                     [3:0] ds2_arcache;
output            [(ID_MSB+4):0] ds2_arid;
output                     [7:0] ds2_arlen;
output                           ds2_arlock;
output                     [2:0] ds2_arprot;
input                            ds2_arready;
output                     [2:0] ds2_arsize;
output                           ds2_arvalid;
output              [ADDR_MSB:0] ds2_awaddr;
output                     [1:0] ds2_awburst;
output                     [3:0] ds2_awcache;
output            [(ID_MSB+4):0] ds2_awid;
output                     [7:0] ds2_awlen;
output                           ds2_awlock;
output                     [2:0] ds2_awprot;
input                            ds2_awready;
output                     [2:0] ds2_awsize;
output                           ds2_awvalid;
input               [ID_MSB+4:0] ds2_bid;
output                           ds2_bready;
input                      [1:0] ds2_bresp;
input                            ds2_bvalid;
input               [DATA_MSB:0] ds2_rdata;
input               [ID_MSB+4:0] ds2_rid;
input                            ds2_rlast;
output                           ds2_rready;
input                      [1:0] ds2_rresp;
input                            ds2_rvalid;
output              [DATA_MSB:0] ds2_wdata;
output                           ds2_wlast;
input                            ds2_wready;
output      [(DATA_WIDTH/8)-1:0] ds2_wstrb;
output                           ds2_wvalid;
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
output              [ADDR_MSB:0] ds3_araddr;
output                     [1:0] ds3_arburst;
output                     [3:0] ds3_arcache;
output            [(ID_MSB+4):0] ds3_arid;
output                     [7:0] ds3_arlen;
output                           ds3_arlock;
output                     [2:0] ds3_arprot;
input                            ds3_arready;
output                     [2:0] ds3_arsize;
output                           ds3_arvalid;
output              [ADDR_MSB:0] ds3_awaddr;
output                     [1:0] ds3_awburst;
output                     [3:0] ds3_awcache;
output            [(ID_MSB+4):0] ds3_awid;
output                     [7:0] ds3_awlen;
output                           ds3_awlock;
output                     [2:0] ds3_awprot;
input                            ds3_awready;
output                     [2:0] ds3_awsize;
output                           ds3_awvalid;
input               [ID_MSB+4:0] ds3_bid;
output                           ds3_bready;
input                      [1:0] ds3_bresp;
input                            ds3_bvalid;
input               [DATA_MSB:0] ds3_rdata;
input               [ID_MSB+4:0] ds3_rid;
input                            ds3_rlast;
output                           ds3_rready;
input                      [1:0] ds3_rresp;
input                            ds3_rvalid;
output              [DATA_MSB:0] ds3_wdata;
output                           ds3_wlast;
input                            ds3_wready;
output      [(DATA_WIDTH/8)-1:0] ds3_wstrb;
output                           ds3_wvalid;
`endif
`ifdef ATCBMC301_MST1_SUPPORT
input               [ADDR_MSB:0] us1_araddr;
input                      [1:0] us1_arburst;
input                      [3:0] us1_arcache;
input                 [ID_MSB:0] us1_arid;
input                      [7:0] us1_arlen;
input                            us1_arlock;
input                      [2:0] us1_arprot;
output                           us1_arready;
input                      [2:0] us1_arsize;
input                            us1_arvalid;
input               [ADDR_MSB:0] us1_awaddr;
input                      [1:0] us1_awburst;
input                      [3:0] us1_awcache;
input                 [ID_MSB:0] us1_awid;
input                      [7:0] us1_awlen;
input                            us1_awlock;
input                      [2:0] us1_awprot;
output                           us1_awready;
input                      [2:0] us1_awsize;
input                            us1_awvalid;
output                [ID_MSB:0] us1_bid;
input                            us1_bready;
output                     [1:0] us1_bresp;
output                           us1_bvalid;
output              [DATA_MSB:0] us1_rdata;
output                [ID_MSB:0] us1_rid;
output                           us1_rlast;
input                            us1_rready;
output                     [1:0] us1_rresp;
output                           us1_rvalid;
input               [DATA_MSB:0] us1_wdata;
input                            us1_wlast;
output                           us1_wready;
input       [(DATA_WIDTH/8)-1:0] us1_wstrb;
input                            us1_wvalid;
`endif
input                            aclk;
input                            aresetn;

`ifdef ATCBMC301_MST0_SUPPORT
wire                [ADDR_MSB:0] mst0_araddr;
wire                       [1:0] mst0_arburst;
wire                       [3:0] mst0_arcache;
wire                  [ID_MSB:0] mst0_arid;
wire                       [7:0] mst0_arlen;
wire                             mst0_arlock;
wire                       [2:0] mst0_arprot;
wire                       [2:0] mst0_arsize;
wire                [ADDR_MSB:0] mst0_awaddr;
wire                       [1:0] mst0_awburst;
wire                       [3:0] mst0_awcache;
wire                  [ID_MSB:0] mst0_awid;
wire                       [7:0] mst0_awlen;
wire                             mst0_awlock;
wire                       [2:0] mst0_awprot;
wire                       [2:0] mst0_awsize;
wire                             mst0_bready;
wire                       [4:0] mst0_bsid;
wire                             mst0_rready;
wire                       [4:0] mst0_rsid;
wire                [DATA_MSB:0] mst0_wdata;
wire                             mst0_wlast;
wire                       [4:0] mst0_wsid;
wire        [(DATA_WIDTH/8)-1:0] mst0_wstrb;
wire                             mst0_wvalid;
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
wire                      [64:0] slv1_addr_mask;
wire                      [64:0] slv1_masked_base_addr;
wire                       [3:0] slv1_ar_mid;
wire                             slv1_arready;
wire                       [3:0] slv1_aw_mid;
wire                             slv1_awready;
wire                [ID_MSB+4:0] slv1_bid;
wire                       [1:0] slv1_bresp;
wire                             slv1_bvalid;
wire            [(DATA_MSB+3):0] slv1_read_data;
wire                [ID_MSB+4:0] slv1_rid;
wire                             slv1_rvalid;
wire                       [3:0] slv1_wmid;
wire                             slv1_wready;
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
wire                      [64:0] slv2_addr_mask;
wire                      [64:0] slv2_masked_base_addr;
wire                       [3:0] slv2_ar_mid;
wire                             slv2_arready;
wire                       [3:0] slv2_aw_mid;
wire                             slv2_awready;
wire                [ID_MSB+4:0] slv2_bid;
wire                       [1:0] slv2_bresp;
wire                             slv2_bvalid;
wire            [(DATA_MSB+3):0] slv2_read_data;
wire                [ID_MSB+4:0] slv2_rid;
wire                             slv2_rvalid;
wire                       [3:0] slv2_wmid;
wire                             slv2_wready;
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
wire                      [64:0] slv3_addr_mask;
wire                      [64:0] slv3_masked_base_addr;
wire                       [3:0] slv3_ar_mid;
wire                             slv3_arready;
wire                       [3:0] slv3_aw_mid;
wire                             slv3_awready;
wire                [ID_MSB+4:0] slv3_bid;
wire                       [1:0] slv3_bresp;
wire                             slv3_bvalid;
wire            [(DATA_MSB+3):0] slv3_read_data;
wire                [ID_MSB+4:0] slv3_rid;
wire                             slv3_rvalid;
wire                       [3:0] slv3_wmid;
wire                             slv3_wready;
`endif
`ifdef ATCBMC301_MST1_SUPPORT
wire                [ADDR_MSB:0] mst1_araddr;
wire                       [1:0] mst1_arburst;
wire                       [3:0] mst1_arcache;
wire                  [ID_MSB:0] mst1_arid;
wire                       [7:0] mst1_arlen;
wire                             mst1_arlock;
wire                       [2:0] mst1_arprot;
wire                       [2:0] mst1_arsize;
wire                [ADDR_MSB:0] mst1_awaddr;
wire                       [1:0] mst1_awburst;
wire                       [3:0] mst1_awcache;
wire                  [ID_MSB:0] mst1_awid;
wire                       [7:0] mst1_awlen;
wire                             mst1_awlock;
wire                       [2:0] mst1_awprot;
wire                       [2:0] mst1_awsize;
wire                             mst1_bready;
wire                       [4:0] mst1_bsid;
wire                             mst1_rready;
wire                       [4:0] mst1_rsid;
wire                [DATA_MSB:0] mst1_wdata;
wire                             mst1_wlast;
wire                       [4:0] mst1_wsid;
wire        [(DATA_WIDTH/8)-1:0] mst1_wstrb;
wire                             mst1_wvalid;
`endif
`ifdef ATCBMC301_MST0_SUPPORT
   `ifdef ATCBMC301_SLV1_SUPPORT
wire                             s0;
wire                             s1;
   `endif
   `ifdef ATCBMC301_SLV2_SUPPORT
wire                             s2;
wire                             s3;
   `endif
   `ifdef ATCBMC301_SLV3_SUPPORT
wire                             s4;
wire                             s5;
   `endif
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
   `ifdef ATCBMC301_MST1_SUPPORT
wire                             s6;
wire                             s7;
   `endif
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
   `ifdef ATCBMC301_MST1_SUPPORT
wire                             s8;
wire                             s9;
   `endif
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
   `ifdef ATCBMC301_MST1_SUPPORT
wire                             s10;
wire                             s11;
   `endif
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
`endif
`ifdef ATCBMC301_SLV1_SUPPORT
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
`endif
wire                             reg_mst0_high_priority;
wire                      [15:0] reg_priority_reload;

`ifdef ATCBMC301_SLV1_SUPPORT
   localparam        SLV1_SIZE = `ATCBMC301_SLV1_SIZE;
   assign slv1_addr_mask = {{(65-(SLV1_SIZE+19)){1'b1}},{(SLV1_SIZE+19){1'b0}}} &
                              {{(65-ADDR_WIDTH){1'b0}},{ADDR_WIDTH{1'b1}}};
   assign slv1_masked_base_addr = {{(65-ADDR_WIDTH){1'b0}},`ATCBMC301_SLV1_BASE_ADDR} & slv1_addr_mask;
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
   localparam        SLV2_SIZE = `ATCBMC301_SLV2_SIZE;
   assign slv2_addr_mask = {{(65-(SLV2_SIZE+19)){1'b1}},{(SLV2_SIZE+19){1'b0}}} &
                              {{(65-ADDR_WIDTH){1'b0}},{ADDR_WIDTH{1'b1}}};
   assign slv2_masked_base_addr = {{(65-ADDR_WIDTH){1'b0}},`ATCBMC301_SLV2_BASE_ADDR} & slv2_addr_mask;
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
   localparam        SLV3_SIZE = `ATCBMC301_SLV3_SIZE;
   assign slv3_addr_mask = {{(65-(SLV3_SIZE+19)){1'b1}},{(SLV3_SIZE+19){1'b0}}} &
                              {{(65-ADDR_WIDTH){1'b0}},{ADDR_WIDTH{1'b1}}};
   assign slv3_masked_base_addr = {{(65-ADDR_WIDTH){1'b0}},`ATCBMC301_SLV3_BASE_ADDR} & slv3_addr_mask;
`endif
`ifdef ATCBMC301_MST0_SUPPORT
localparam RESET_M0_HIGH_PRIORITY = `ATCBMC301_MST0_DEFAULT_HIGH_PRIORITY;
assign reg_mst0_high_priority = RESET_M0_HIGH_PRIORITY[0];
`else
assign reg_mst0_high_priority = 1'b0;
`endif
`ifdef ATCBMC301_MST0_SUPPORT
localparam RESET_M0_PRI_RELOAD = `ATCBMC301_MST0_DEFAULT_PRIORITY_RELOAD;
assign reg_priority_reload[0] = RESET_M0_PRI_RELOAD[0];
`else
assign reg_priority_reload[0] = 1'b0;
`endif
`ifdef ATCBMC301_MST1_SUPPORT
localparam RESET_M1_PRI_RELOAD = `ATCBMC301_MST1_DEFAULT_PRIORITY_RELOAD;
assign reg_priority_reload[1] = RESET_M1_PRI_RELOAD[0];
`else
assign reg_priority_reload[1] = 1'b0;
`endif
assign reg_priority_reload[2] = 1'b0;

assign reg_priority_reload[3] = 1'b0;

assign reg_priority_reload[4] = 1'b0;

assign reg_priority_reload[5] = 1'b0;

assign reg_priority_reload[6] = 1'b0;

assign reg_priority_reload[7] = 1'b0;

assign reg_priority_reload[8] = 1'b0;

assign reg_priority_reload[9] = 1'b0;

assign reg_priority_reload[10] = 1'b0;

assign reg_priority_reload[11] = 1'b0;

assign reg_priority_reload[12] = 1'b0;

assign reg_priority_reload[13] = 1'b0;

assign reg_priority_reload[14] = 1'b0;

assign reg_priority_reload[15] = 1'b0;



`ifdef ATCBMC301_MST0_SUPPORT
atcbmc301_us_axi #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTANDING_DEPTH(`ATCBMC301_MST0_OUTSTANDING_DEPTH)
) us0_ctrl (
   `ifdef ATCBMC301_SLV1_SUPPORT
	.slv1_ar_mid           (slv1_ar_mid           ),
	.slv1_arready          (slv1_arready          ),
	.slv1_arvalid          (s0     ),
	.slv1_addr_mask        (slv1_addr_mask        ),
	.slv1_masked_base_addr (slv1_masked_base_addr ),
	.slv1_connect          (`ATCBMC301_M0S1       ),
	.slv1_aw_mid           (slv1_aw_mid           ),
	.slv1_awready          (slv1_awready          ),
	.slv1_awvalid          (s1     ),
	.slv1_read_data        (slv1_read_data        ),
	.slv1_rid              (slv1_rid              ),
	.slv1_rvalid           (slv1_rvalid           ),
	.slv1_wmid             (slv1_wmid             ),
	.slv1_wready           (slv1_wready           ),
	.slv1_bid              (slv1_bid              ),
	.slv1_bresp            (slv1_bresp            ),
	.slv1_bvalid           (slv1_bvalid           ),
   `endif
   `ifdef ATCBMC301_SLV2_SUPPORT
	.slv2_ar_mid           (slv2_ar_mid           ),
	.slv2_arready          (slv2_arready          ),
	.slv2_arvalid          (s2     ),
	.slv2_addr_mask        (slv2_addr_mask        ),
	.slv2_masked_base_addr (slv2_masked_base_addr ),
	.slv2_connect          (`ATCBMC301_M0S2       ),
	.slv2_aw_mid           (slv2_aw_mid           ),
	.slv2_awready          (slv2_awready          ),
	.slv2_awvalid          (s3     ),
	.slv2_read_data        (slv2_read_data        ),
	.slv2_rid              (slv2_rid              ),
	.slv2_rvalid           (slv2_rvalid           ),
	.slv2_wmid             (slv2_wmid             ),
	.slv2_wready           (slv2_wready           ),
	.slv2_bid              (slv2_bid              ),
	.slv2_bresp            (slv2_bresp            ),
	.slv2_bvalid           (slv2_bvalid           ),
   `endif
   `ifdef ATCBMC301_SLV3_SUPPORT
	.slv3_ar_mid           (slv3_ar_mid           ),
	.slv3_arready          (slv3_arready          ),
	.slv3_arvalid          (s4     ),
	.slv3_addr_mask        (slv3_addr_mask        ),
	.slv3_masked_base_addr (slv3_masked_base_addr ),
	.slv3_connect          (`ATCBMC301_M0S3       ),
	.slv3_aw_mid           (slv3_aw_mid           ),
	.slv3_awready          (slv3_awready          ),
	.slv3_awvalid          (s5     ),
	.slv3_read_data        (slv3_read_data        ),
	.slv3_rid              (slv3_rid              ),
	.slv3_rvalid           (slv3_rvalid           ),
	.slv3_wmid             (slv3_wmid             ),
	.slv3_wready           (slv3_wready           ),
	.slv3_bid              (slv3_bid              ),
	.slv3_bresp            (slv3_bresp            ),
	.slv3_bvalid           (slv3_bvalid           ),
   `endif
	.us_rdata              (us0_rdata             ),
	.us_rlast              (us0_rlast             ),
	.us_rresp              (us0_rresp             ),
	.mst_araddr            (mst0_araddr           ),
	.mst_arburst           (mst0_arburst          ),
	.mst_arcache           (mst0_arcache          ),
	.mst_arid              (mst0_arid             ),
	.mst_arlen             (mst0_arlen            ),
	.mst_arlock            (mst0_arlock           ),
	.mst_arprot            (mst0_arprot           ),
	.mst_arsize            (mst0_arsize           ),
	.us_araddr             (us0_araddr            ),
	.us_arburst            (us0_arburst           ),
	.us_arcache            (us0_arcache           ),
	.us_arid               (us0_arid              ),
	.us_arlen              (us0_arlen             ),
	.us_arlock             (us0_arlock            ),
	.us_arprot             (us0_arprot            ),
	.us_arready            (us0_arready           ),
	.us_arsize             (us0_arsize            ),
	.us_arvalid            (us0_arvalid           ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               ),
	.self_id               (4'd0                  ),
	.us_rready             (us0_rready            ),
	.mst_awaddr            (mst0_awaddr           ),
	.mst_awburst           (mst0_awburst          ),
	.mst_awcache           (mst0_awcache          ),
	.mst_awid              (mst0_awid             ),
	.mst_awlen             (mst0_awlen            ),
	.mst_awlock            (mst0_awlock           ),
	.mst_awprot            (mst0_awprot           ),
	.mst_awsize            (mst0_awsize           ),
	.us_awaddr             (us0_awaddr            ),
	.us_awburst            (us0_awburst           ),
	.us_awcache            (us0_awcache           ),
	.us_awid               (us0_awid              ),
	.us_awlen              (us0_awlen             ),
	.us_awlock             (us0_awlock            ),
	.us_awprot             (us0_awprot            ),
	.us_awready            (us0_awready           ),
	.us_awsize             (us0_awsize            ),
	.us_awvalid            (us0_awvalid           ),
	.us_bready             (us0_bready            ),
	.mst_rready            (mst0_rready           ),
	.mst_rsid              (mst0_rsid             ),
	.us_rid                (us0_rid               ),
	.us_rvalid             (us0_rvalid            ),
	.mst_wdata             (mst0_wdata            ),
	.mst_wlast             (mst0_wlast            ),
	.mst_wsid              (mst0_wsid             ),
	.mst_wstrb             (mst0_wstrb            ),
	.mst_wvalid            (mst0_wvalid           ),
	.us_wdata              (us0_wdata             ),
	.us_wlast              (us0_wlast             ),
	.us_wready             (us0_wready            ),
	.us_wstrb              (us0_wstrb             ),
	.us_wvalid             (us0_wvalid            ),
	.mst_bready            (mst0_bready           ),
	.mst_bsid              (mst0_bsid             ),
	.us_bid                (us0_bid               ),
	.us_bresp              (us0_bresp             ),
	.us_bvalid             (us0_bvalid            )
);

`endif
`ifdef ATCBMC301_MST1_SUPPORT
atcbmc301_us_axi #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTANDING_DEPTH(`ATCBMC301_MST1_OUTSTANDING_DEPTH)
) us1_ctrl (
   `ifdef ATCBMC301_SLV1_SUPPORT
	.slv1_ar_mid           (slv1_ar_mid           ),
	.slv1_arready          (slv1_arready          ),
	.slv1_arvalid          (s6     ),
	.slv1_addr_mask        (slv1_addr_mask        ),
	.slv1_masked_base_addr (slv1_masked_base_addr ),
	.slv1_connect          (`ATCBMC301_M1S1       ),
	.slv1_aw_mid           (slv1_aw_mid           ),
	.slv1_awready          (slv1_awready          ),
	.slv1_awvalid          (s7     ),
	.slv1_read_data        (slv1_read_data        ),
	.slv1_rid              (slv1_rid              ),
	.slv1_rvalid           (slv1_rvalid           ),
	.slv1_wmid             (slv1_wmid             ),
	.slv1_wready           (slv1_wready           ),
	.slv1_bid              (slv1_bid              ),
	.slv1_bresp            (slv1_bresp            ),
	.slv1_bvalid           (slv1_bvalid           ),
   `endif
   `ifdef ATCBMC301_SLV2_SUPPORT
	.slv2_ar_mid           (slv2_ar_mid           ),
	.slv2_arready          (slv2_arready          ),
	.slv2_arvalid          (s8     ),
	.slv2_addr_mask        (slv2_addr_mask        ),
	.slv2_masked_base_addr (slv2_masked_base_addr ),
	.slv2_connect          (`ATCBMC301_M1S2       ),
	.slv2_aw_mid           (slv2_aw_mid           ),
	.slv2_awready          (slv2_awready          ),
	.slv2_awvalid          (s9     ),
	.slv2_read_data        (slv2_read_data        ),
	.slv2_rid              (slv2_rid              ),
	.slv2_rvalid           (slv2_rvalid           ),
	.slv2_wmid             (slv2_wmid             ),
	.slv2_wready           (slv2_wready           ),
	.slv2_bid              (slv2_bid              ),
	.slv2_bresp            (slv2_bresp            ),
	.slv2_bvalid           (slv2_bvalid           ),
   `endif
   `ifdef ATCBMC301_SLV3_SUPPORT
	.slv3_ar_mid           (slv3_ar_mid           ),
	.slv3_arready          (slv3_arready          ),
	.slv3_arvalid          (s10     ),
	.slv3_addr_mask        (slv3_addr_mask        ),
	.slv3_masked_base_addr (slv3_masked_base_addr ),
	.slv3_connect          (`ATCBMC301_M1S3       ),
	.slv3_aw_mid           (slv3_aw_mid           ),
	.slv3_awready          (slv3_awready          ),
	.slv3_awvalid          (s11     ),
	.slv3_read_data        (slv3_read_data        ),
	.slv3_rid              (slv3_rid              ),
	.slv3_rvalid           (slv3_rvalid           ),
	.slv3_wmid             (slv3_wmid             ),
	.slv3_wready           (slv3_wready           ),
	.slv3_bid              (slv3_bid              ),
	.slv3_bresp            (slv3_bresp            ),
	.slv3_bvalid           (slv3_bvalid           ),
   `endif
	.us_rdata              (us1_rdata             ),
	.us_rlast              (us1_rlast             ),
	.us_rresp              (us1_rresp             ),
	.mst_araddr            (mst1_araddr           ),
	.mst_arburst           (mst1_arburst          ),
	.mst_arcache           (mst1_arcache          ),
	.mst_arid              (mst1_arid             ),
	.mst_arlen             (mst1_arlen            ),
	.mst_arlock            (mst1_arlock           ),
	.mst_arprot            (mst1_arprot           ),
	.mst_arsize            (mst1_arsize           ),
	.us_araddr             (us1_araddr            ),
	.us_arburst            (us1_arburst           ),
	.us_arcache            (us1_arcache           ),
	.us_arid               (us1_arid              ),
	.us_arlen              (us1_arlen             ),
	.us_arlock             (us1_arlock            ),
	.us_arprot             (us1_arprot            ),
	.us_arready            (us1_arready           ),
	.us_arsize             (us1_arsize            ),
	.us_arvalid            (us1_arvalid           ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               ),
	.self_id               (4'd1                  ),
	.us_rready             (us1_rready            ),
	.mst_awaddr            (mst1_awaddr           ),
	.mst_awburst           (mst1_awburst          ),
	.mst_awcache           (mst1_awcache          ),
	.mst_awid              (mst1_awid             ),
	.mst_awlen             (mst1_awlen            ),
	.mst_awlock            (mst1_awlock           ),
	.mst_awprot            (mst1_awprot           ),
	.mst_awsize            (mst1_awsize           ),
	.us_awaddr             (us1_awaddr            ),
	.us_awburst            (us1_awburst           ),
	.us_awcache            (us1_awcache           ),
	.us_awid               (us1_awid              ),
	.us_awlen              (us1_awlen             ),
	.us_awlock             (us1_awlock            ),
	.us_awprot             (us1_awprot            ),
	.us_awready            (us1_awready           ),
	.us_awsize             (us1_awsize            ),
	.us_awvalid            (us1_awvalid           ),
	.us_bready             (us1_bready            ),
	.mst_rready            (mst1_rready           ),
	.mst_rsid              (mst1_rsid             ),
	.us_rid                (us1_rid               ),
	.us_rvalid             (us1_rvalid            ),
	.mst_wdata             (mst1_wdata            ),
	.mst_wlast             (mst1_wlast            ),
	.mst_wsid              (mst1_wsid             ),
	.mst_wstrb             (mst1_wstrb            ),
	.mst_wvalid            (mst1_wvalid           ),
	.us_wdata              (us1_wdata             ),
	.us_wlast              (us1_wlast             ),
	.us_wready             (us1_wready            ),
	.us_wstrb              (us1_wstrb             ),
	.us_wvalid             (us1_wvalid            ),
	.mst_bready            (mst1_bready           ),
	.mst_bsid              (mst1_bsid             ),
	.us_bid                (us1_bid               ),
	.us_bresp              (us1_bresp             ),
	.us_bvalid             (us1_bvalid            )
);

`endif














`ifdef ATCBMC301_SLV1_SUPPORT
atcbmc301_ds_axi #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.SLAVE_FIFO_DEPTH(`ATCBMC301_SLV1_FIFO_DEPTH)
) ds1_ctrl (
   `ifdef ATCBMC301_MST0_SUPPORT
	.mst0_araddr           (mst0_araddr           ),
	.mst0_arburst          (mst0_arburst          ),
	.mst0_arcache          (mst0_arcache          ),
	.mst0_arid             (mst0_arid             ),
	.mst0_arlen            (mst0_arlen            ),
	.mst0_arlock           (mst0_arlock           ),
	.mst0_arprot           (mst0_arprot           ),
	.mst0_arsize           (mst0_arsize           ),
	.mst0_arvalid          (s0     ),
	.mst0_connect          (`ATCBMC301_M0S1       ),
	.mst0_awaddr           (mst0_awaddr           ),
	.mst0_awburst          (mst0_awburst          ),
	.mst0_awcache          (mst0_awcache          ),
	.mst0_awid             (mst0_awid             ),
	.mst0_awlen            (mst0_awlen            ),
	.mst0_awlock           (mst0_awlock           ),
	.mst0_awprot           (mst0_awprot           ),
	.mst0_awsize           (mst0_awsize           ),
	.mst0_awvalid          (s1     ),
	.mst0_rready           (mst0_rready           ),
	.mst0_rsid             (mst0_rsid             ),
	.mst0_bready           (mst0_bready           ),
	.mst0_bsid             (mst0_bsid             ),
	.mst0_wdata            (mst0_wdata            ),
	.mst0_wlast            (mst0_wlast            ),
	.mst0_wsid             (mst0_wsid             ),
	.mst0_wstrb            (mst0_wstrb            ),
	.mst0_wvalid           (mst0_wvalid           ),
   `endif
   `ifdef ATCBMC301_MST1_SUPPORT
	.mst1_araddr           (mst1_araddr           ),
	.mst1_arburst          (mst1_arburst          ),
	.mst1_arcache          (mst1_arcache          ),
	.mst1_arid             (mst1_arid             ),
	.mst1_arlen            (mst1_arlen            ),
	.mst1_arlock           (mst1_arlock           ),
	.mst1_arprot           (mst1_arprot           ),
	.mst1_arsize           (mst1_arsize           ),
	.mst1_arvalid          (s6     ),
	.mst1_connect          (`ATCBMC301_M1S1       ),
	.mst1_awaddr           (mst1_awaddr           ),
	.mst1_awburst          (mst1_awburst          ),
	.mst1_awcache          (mst1_awcache          ),
	.mst1_awid             (mst1_awid             ),
	.mst1_awlen            (mst1_awlen            ),
	.mst1_awlock           (mst1_awlock           ),
	.mst1_awprot           (mst1_awprot           ),
	.mst1_awsize           (mst1_awsize           ),
	.mst1_awvalid          (s7     ),
	.mst1_rready           (mst1_rready           ),
	.mst1_rsid             (mst1_rsid             ),
	.mst1_bready           (mst1_bready           ),
	.mst1_bsid             (mst1_bsid             ),
	.mst1_wdata            (mst1_wdata            ),
	.mst1_wlast            (mst1_wlast            ),
	.mst1_wsid             (mst1_wsid             ),
	.mst1_wstrb            (mst1_wstrb            ),
	.mst1_wvalid           (mst1_wvalid           ),
   `endif
	.ds_araddr             (ds1_araddr            ),
	.ds_arburst            (ds1_arburst           ),
	.ds_arcache            (ds1_arcache           ),
	.ds_arid               (ds1_arid              ),
	.ds_arlen              (ds1_arlen             ),
	.ds_arlock             (ds1_arlock            ),
	.ds_arprot             (ds1_arprot            ),
	.ds_arready            (ds1_arready           ),
	.ds_arsize             (ds1_arsize            ),
	.ds_arvalid            (ds1_arvalid           ),
	.slv_ar_mid            (slv1_ar_mid           ),
	.slv_arready           (slv1_arready          ),
	.reg_mst0_high_priority(reg_mst0_high_priority),
	.reg_priority_reload   (reg_priority_reload   ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               ),
	.ds_awaddr             (ds1_awaddr            ),
	.ds_awburst            (ds1_awburst           ),
	.ds_awcache            (ds1_awcache           ),
	.ds_awid               (ds1_awid              ),
	.ds_awlen              (ds1_awlen             ),
	.ds_awlock             (ds1_awlock            ),
	.ds_awprot             (ds1_awprot            ),
	.ds_awready            (ds1_awready           ),
	.ds_awsize             (ds1_awsize            ),
	.ds_awvalid            (ds1_awvalid           ),
	.slv_aw_mid            (slv1_aw_mid           ),
	.slv_awready           (slv1_awready          ),
	.ds_rdata              (ds1_rdata             ),
	.ds_rid                (ds1_rid               ),
	.ds_rlast              (ds1_rlast             ),
	.ds_rready             (ds1_rready            ),
	.ds_rresp              (ds1_rresp             ),
	.ds_rvalid             (ds1_rvalid            ),
	.slv_read_data         (slv1_read_data        ),
	.slv_rid               (slv1_rid              ),
	.slv_rvalid            (slv1_rvalid           ),
	.self_id               (5'd1                  ),
	.ds_bid                (ds1_bid               ),
	.ds_bready             (ds1_bready            ),
	.ds_bresp              (ds1_bresp             ),
	.ds_bvalid             (ds1_bvalid            ),
	.ds_wdata              (ds1_wdata             ),
	.ds_wlast              (ds1_wlast             ),
	.ds_wready             (ds1_wready            ),
	.ds_wstrb              (ds1_wstrb             ),
	.ds_wvalid             (ds1_wvalid            ),
	.slv_bid               (slv1_bid              ),
	.slv_bresp             (slv1_bresp            ),
	.slv_bvalid            (slv1_bvalid           ),
	.slv_wmid              (slv1_wmid             ),
	.slv_wready            (slv1_wready           )
);

`endif
`ifdef ATCBMC301_SLV2_SUPPORT
atcbmc301_ds_axi #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.SLAVE_FIFO_DEPTH(`ATCBMC301_SLV2_FIFO_DEPTH)
) ds2_ctrl (
   `ifdef ATCBMC301_MST0_SUPPORT
	.mst0_araddr           (mst0_araddr           ),
	.mst0_arburst          (mst0_arburst          ),
	.mst0_arcache          (mst0_arcache          ),
	.mst0_arid             (mst0_arid             ),
	.mst0_arlen            (mst0_arlen            ),
	.mst0_arlock           (mst0_arlock           ),
	.mst0_arprot           (mst0_arprot           ),
	.mst0_arsize           (mst0_arsize           ),
	.mst0_arvalid          (s2     ),
	.mst0_connect          (`ATCBMC301_M0S2       ),
	.mst0_awaddr           (mst0_awaddr           ),
	.mst0_awburst          (mst0_awburst          ),
	.mst0_awcache          (mst0_awcache          ),
	.mst0_awid             (mst0_awid             ),
	.mst0_awlen            (mst0_awlen            ),
	.mst0_awlock           (mst0_awlock           ),
	.mst0_awprot           (mst0_awprot           ),
	.mst0_awsize           (mst0_awsize           ),
	.mst0_awvalid          (s3     ),
	.mst0_rready           (mst0_rready           ),
	.mst0_rsid             (mst0_rsid             ),
	.mst0_bready           (mst0_bready           ),
	.mst0_bsid             (mst0_bsid             ),
	.mst0_wdata            (mst0_wdata            ),
	.mst0_wlast            (mst0_wlast            ),
	.mst0_wsid             (mst0_wsid             ),
	.mst0_wstrb            (mst0_wstrb            ),
	.mst0_wvalid           (mst0_wvalid           ),
   `endif
   `ifdef ATCBMC301_MST1_SUPPORT
	.mst1_araddr           (mst1_araddr           ),
	.mst1_arburst          (mst1_arburst          ),
	.mst1_arcache          (mst1_arcache          ),
	.mst1_arid             (mst1_arid             ),
	.mst1_arlen            (mst1_arlen            ),
	.mst1_arlock           (mst1_arlock           ),
	.mst1_arprot           (mst1_arprot           ),
	.mst1_arsize           (mst1_arsize           ),
	.mst1_arvalid          (s8     ),
	.mst1_connect          (`ATCBMC301_M1S2       ),
	.mst1_awaddr           (mst1_awaddr           ),
	.mst1_awburst          (mst1_awburst          ),
	.mst1_awcache          (mst1_awcache          ),
	.mst1_awid             (mst1_awid             ),
	.mst1_awlen            (mst1_awlen            ),
	.mst1_awlock           (mst1_awlock           ),
	.mst1_awprot           (mst1_awprot           ),
	.mst1_awsize           (mst1_awsize           ),
	.mst1_awvalid          (s9     ),
	.mst1_rready           (mst1_rready           ),
	.mst1_rsid             (mst1_rsid             ),
	.mst1_bready           (mst1_bready           ),
	.mst1_bsid             (mst1_bsid             ),
	.mst1_wdata            (mst1_wdata            ),
	.mst1_wlast            (mst1_wlast            ),
	.mst1_wsid             (mst1_wsid             ),
	.mst1_wstrb            (mst1_wstrb            ),
	.mst1_wvalid           (mst1_wvalid           ),
   `endif
	.ds_araddr             (ds2_araddr            ),
	.ds_arburst            (ds2_arburst           ),
	.ds_arcache            (ds2_arcache           ),
	.ds_arid               (ds2_arid              ),
	.ds_arlen              (ds2_arlen             ),
	.ds_arlock             (ds2_arlock            ),
	.ds_arprot             (ds2_arprot            ),
	.ds_arready            (ds2_arready           ),
	.ds_arsize             (ds2_arsize            ),
	.ds_arvalid            (ds2_arvalid           ),
	.slv_ar_mid            (slv2_ar_mid           ),
	.slv_arready           (slv2_arready          ),
	.reg_mst0_high_priority(reg_mst0_high_priority),
	.reg_priority_reload   (reg_priority_reload   ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               ),
	.ds_awaddr             (ds2_awaddr            ),
	.ds_awburst            (ds2_awburst           ),
	.ds_awcache            (ds2_awcache           ),
	.ds_awid               (ds2_awid              ),
	.ds_awlen              (ds2_awlen             ),
	.ds_awlock             (ds2_awlock            ),
	.ds_awprot             (ds2_awprot            ),
	.ds_awready            (ds2_awready           ),
	.ds_awsize             (ds2_awsize            ),
	.ds_awvalid            (ds2_awvalid           ),
	.slv_aw_mid            (slv2_aw_mid           ),
	.slv_awready           (slv2_awready          ),
	.ds_rdata              (ds2_rdata             ),
	.ds_rid                (ds2_rid               ),
	.ds_rlast              (ds2_rlast             ),
	.ds_rready             (ds2_rready            ),
	.ds_rresp              (ds2_rresp             ),
	.ds_rvalid             (ds2_rvalid            ),
	.slv_read_data         (slv2_read_data        ),
	.slv_rid               (slv2_rid              ),
	.slv_rvalid            (slv2_rvalid           ),
	.self_id               (5'd2                  ),
	.ds_bid                (ds2_bid               ),
	.ds_bready             (ds2_bready            ),
	.ds_bresp              (ds2_bresp             ),
	.ds_bvalid             (ds2_bvalid            ),
	.ds_wdata              (ds2_wdata             ),
	.ds_wlast              (ds2_wlast             ),
	.ds_wready             (ds2_wready            ),
	.ds_wstrb              (ds2_wstrb             ),
	.ds_wvalid             (ds2_wvalid            ),
	.slv_bid               (slv2_bid              ),
	.slv_bresp             (slv2_bresp            ),
	.slv_bvalid            (slv2_bvalid           ),
	.slv_wmid              (slv2_wmid             ),
	.slv_wready            (slv2_wready           )
);

`endif
`ifdef ATCBMC301_SLV3_SUPPORT
atcbmc301_ds_axi #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.SLAVE_FIFO_DEPTH(`ATCBMC301_SLV3_FIFO_DEPTH)
) ds3_ctrl (
   `ifdef ATCBMC301_MST0_SUPPORT
	.mst0_araddr           (mst0_araddr           ),
	.mst0_arburst          (mst0_arburst          ),
	.mst0_arcache          (mst0_arcache          ),
	.mst0_arid             (mst0_arid             ),
	.mst0_arlen            (mst0_arlen            ),
	.mst0_arlock           (mst0_arlock           ),
	.mst0_arprot           (mst0_arprot           ),
	.mst0_arsize           (mst0_arsize           ),
	.mst0_arvalid          (s4     ),
	.mst0_connect          (`ATCBMC301_M0S3       ),
	.mst0_awaddr           (mst0_awaddr           ),
	.mst0_awburst          (mst0_awburst          ),
	.mst0_awcache          (mst0_awcache          ),
	.mst0_awid             (mst0_awid             ),
	.mst0_awlen            (mst0_awlen            ),
	.mst0_awlock           (mst0_awlock           ),
	.mst0_awprot           (mst0_awprot           ),
	.mst0_awsize           (mst0_awsize           ),
	.mst0_awvalid          (s5     ),
	.mst0_rready           (mst0_rready           ),
	.mst0_rsid             (mst0_rsid             ),
	.mst0_bready           (mst0_bready           ),
	.mst0_bsid             (mst0_bsid             ),
	.mst0_wdata            (mst0_wdata            ),
	.mst0_wlast            (mst0_wlast            ),
	.mst0_wsid             (mst0_wsid             ),
	.mst0_wstrb            (mst0_wstrb            ),
	.mst0_wvalid           (mst0_wvalid           ),
   `endif
   `ifdef ATCBMC301_MST1_SUPPORT
	.mst1_araddr           (mst1_araddr           ),
	.mst1_arburst          (mst1_arburst          ),
	.mst1_arcache          (mst1_arcache          ),
	.mst1_arid             (mst1_arid             ),
	.mst1_arlen            (mst1_arlen            ),
	.mst1_arlock           (mst1_arlock           ),
	.mst1_arprot           (mst1_arprot           ),
	.mst1_arsize           (mst1_arsize           ),
	.mst1_arvalid          (s10     ),
	.mst1_connect          (`ATCBMC301_M1S3       ),
	.mst1_awaddr           (mst1_awaddr           ),
	.mst1_awburst          (mst1_awburst          ),
	.mst1_awcache          (mst1_awcache          ),
	.mst1_awid             (mst1_awid             ),
	.mst1_awlen            (mst1_awlen            ),
	.mst1_awlock           (mst1_awlock           ),
	.mst1_awprot           (mst1_awprot           ),
	.mst1_awsize           (mst1_awsize           ),
	.mst1_awvalid          (s11     ),
	.mst1_rready           (mst1_rready           ),
	.mst1_rsid             (mst1_rsid             ),
	.mst1_bready           (mst1_bready           ),
	.mst1_bsid             (mst1_bsid             ),
	.mst1_wdata            (mst1_wdata            ),
	.mst1_wlast            (mst1_wlast            ),
	.mst1_wsid             (mst1_wsid             ),
	.mst1_wstrb            (mst1_wstrb            ),
	.mst1_wvalid           (mst1_wvalid           ),
   `endif
	.ds_araddr             (ds3_araddr            ),
	.ds_arburst            (ds3_arburst           ),
	.ds_arcache            (ds3_arcache           ),
	.ds_arid               (ds3_arid              ),
	.ds_arlen              (ds3_arlen             ),
	.ds_arlock             (ds3_arlock            ),
	.ds_arprot             (ds3_arprot            ),
	.ds_arready            (ds3_arready           ),
	.ds_arsize             (ds3_arsize            ),
	.ds_arvalid            (ds3_arvalid           ),
	.slv_ar_mid            (slv3_ar_mid           ),
	.slv_arready           (slv3_arready          ),
	.reg_mst0_high_priority(reg_mst0_high_priority),
	.reg_priority_reload   (reg_priority_reload   ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               ),
	.ds_awaddr             (ds3_awaddr            ),
	.ds_awburst            (ds3_awburst           ),
	.ds_awcache            (ds3_awcache           ),
	.ds_awid               (ds3_awid              ),
	.ds_awlen              (ds3_awlen             ),
	.ds_awlock             (ds3_awlock            ),
	.ds_awprot             (ds3_awprot            ),
	.ds_awready            (ds3_awready           ),
	.ds_awsize             (ds3_awsize            ),
	.ds_awvalid            (ds3_awvalid           ),
	.slv_aw_mid            (slv3_aw_mid           ),
	.slv_awready           (slv3_awready          ),
	.ds_rdata              (ds3_rdata             ),
	.ds_rid                (ds3_rid               ),
	.ds_rlast              (ds3_rlast             ),
	.ds_rready             (ds3_rready            ),
	.ds_rresp              (ds3_rresp             ),
	.ds_rvalid             (ds3_rvalid            ),
	.slv_read_data         (slv3_read_data        ),
	.slv_rid               (slv3_rid              ),
	.slv_rvalid            (slv3_rvalid           ),
	.self_id               (5'd3                  ),
	.ds_bid                (ds3_bid               ),
	.ds_bready             (ds3_bready            ),
	.ds_bresp              (ds3_bresp             ),
	.ds_bvalid             (ds3_bvalid            ),
	.ds_wdata              (ds3_wdata             ),
	.ds_wlast              (ds3_wlast             ),
	.ds_wready             (ds3_wready            ),
	.ds_wstrb              (ds3_wstrb             ),
	.ds_wvalid             (ds3_wvalid            ),
	.slv_bid               (slv3_bid              ),
	.slv_bresp             (slv3_bresp            ),
	.slv_bvalid            (slv3_bvalid           ),
	.slv_wmid              (slv3_wmid             ),
	.slv_wready            (slv3_wready           )
);

`endif





























endmodule

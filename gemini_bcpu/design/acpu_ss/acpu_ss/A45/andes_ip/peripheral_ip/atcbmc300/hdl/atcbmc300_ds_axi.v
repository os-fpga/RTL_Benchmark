// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"


module atcbmc300_ds_axi (
`ifdef ATCBMC300_MST0_SUPPORT
	  mst0_araddr,
	  mst0_arburst,
	  mst0_arcache,
	  mst0_arid,
	  mst0_arlen,
	  mst0_arlock,
	  mst0_arprot,
	  mst0_arsize,
	  mst0_arvalid,
	  mst0_connect,
	  mst0_awaddr,
	  mst0_awburst,
	  mst0_awcache,
	  mst0_awid,
	  mst0_awlen,
	  mst0_awlock,
	  mst0_awprot,
	  mst0_awsize,
	  mst0_awvalid,
	  mst0_rready,
	  mst0_rsid,
	  mst0_bready,
	  mst0_bsid,
	  mst0_wdata,
	  mst0_wlast,
	  mst0_wsid,
	  mst0_wstrb,
	  mst0_wvalid,
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	  mst1_araddr,
	  mst1_arburst,
	  mst1_arcache,
	  mst1_arid,
	  mst1_arlen,
	  mst1_arlock,
	  mst1_arprot,
	  mst1_arsize,
	  mst1_arvalid,
	  mst1_connect,
	  mst1_awaddr,
	  mst1_awburst,
	  mst1_awcache,
	  mst1_awid,
	  mst1_awlen,
	  mst1_awlock,
	  mst1_awprot,
	  mst1_awsize,
	  mst1_awvalid,
	  mst1_rready,
	  mst1_rsid,
	  mst1_bready,
	  mst1_bsid,
	  mst1_wdata,
	  mst1_wlast,
	  mst1_wsid,
	  mst1_wstrb,
	  mst1_wvalid,
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	  mst2_araddr,
	  mst2_arburst,
	  mst2_arcache,
	  mst2_arid,
	  mst2_arlen,
	  mst2_arlock,
	  mst2_arprot,
	  mst2_arsize,
	  mst2_arvalid,
	  mst2_connect,
	  mst2_awaddr,
	  mst2_awburst,
	  mst2_awcache,
	  mst2_awid,
	  mst2_awlen,
	  mst2_awlock,
	  mst2_awprot,
	  mst2_awsize,
	  mst2_awvalid,
	  mst2_rready,
	  mst2_rsid,
	  mst2_bready,
	  mst2_bsid,
	  mst2_wdata,
	  mst2_wlast,
	  mst2_wsid,
	  mst2_wstrb,
	  mst2_wvalid,
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	  mst3_araddr,
	  mst3_arburst,
	  mst3_arcache,
	  mst3_arid,
	  mst3_arlen,
	  mst3_arlock,
	  mst3_arprot,
	  mst3_arsize,
	  mst3_arvalid,
	  mst3_connect,
	  mst3_awaddr,
	  mst3_awburst,
	  mst3_awcache,
	  mst3_awid,
	  mst3_awlen,
	  mst3_awlock,
	  mst3_awprot,
	  mst3_awsize,
	  mst3_awvalid,
	  mst3_rready,
	  mst3_rsid,
	  mst3_bready,
	  mst3_bsid,
	  mst3_wdata,
	  mst3_wlast,
	  mst3_wsid,
	  mst3_wstrb,
	  mst3_wvalid,
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	  mst4_araddr,
	  mst4_arburst,
	  mst4_arcache,
	  mst4_arid,
	  mst4_arlen,
	  mst4_arlock,
	  mst4_arprot,
	  mst4_arsize,
	  mst4_arvalid,
	  mst4_connect,
	  mst4_awaddr,
	  mst4_awburst,
	  mst4_awcache,
	  mst4_awid,
	  mst4_awlen,
	  mst4_awlock,
	  mst4_awprot,
	  mst4_awsize,
	  mst4_awvalid,
	  mst4_rready,
	  mst4_rsid,
	  mst4_bready,
	  mst4_bsid,
	  mst4_wdata,
	  mst4_wlast,
	  mst4_wsid,
	  mst4_wstrb,
	  mst4_wvalid,
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	  mst5_araddr,
	  mst5_arburst,
	  mst5_arcache,
	  mst5_arid,
	  mst5_arlen,
	  mst5_arlock,
	  mst5_arprot,
	  mst5_arsize,
	  mst5_arvalid,
	  mst5_connect,
	  mst5_awaddr,
	  mst5_awburst,
	  mst5_awcache,
	  mst5_awid,
	  mst5_awlen,
	  mst5_awlock,
	  mst5_awprot,
	  mst5_awsize,
	  mst5_awvalid,
	  mst5_rready,
	  mst5_rsid,
	  mst5_bready,
	  mst5_bsid,
	  mst5_wdata,
	  mst5_wlast,
	  mst5_wsid,
	  mst5_wstrb,
	  mst5_wvalid,
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	  mst6_araddr,
	  mst6_arburst,
	  mst6_arcache,
	  mst6_arid,
	  mst6_arlen,
	  mst6_arlock,
	  mst6_arprot,
	  mst6_arsize,
	  mst6_arvalid,
	  mst6_connect,
	  mst6_awaddr,
	  mst6_awburst,
	  mst6_awcache,
	  mst6_awid,
	  mst6_awlen,
	  mst6_awlock,
	  mst6_awprot,
	  mst6_awsize,
	  mst6_awvalid,
	  mst6_rready,
	  mst6_rsid,
	  mst6_bready,
	  mst6_bsid,
	  mst6_wdata,
	  mst6_wlast,
	  mst6_wsid,
	  mst6_wstrb,
	  mst6_wvalid,
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	  mst7_araddr,
	  mst7_arburst,
	  mst7_arcache,
	  mst7_arid,
	  mst7_arlen,
	  mst7_arlock,
	  mst7_arprot,
	  mst7_arsize,
	  mst7_arvalid,
	  mst7_connect,
	  mst7_awaddr,
	  mst7_awburst,
	  mst7_awcache,
	  mst7_awid,
	  mst7_awlen,
	  mst7_awlock,
	  mst7_awprot,
	  mst7_awsize,
	  mst7_awvalid,
	  mst7_rready,
	  mst7_rsid,
	  mst7_bready,
	  mst7_bsid,
	  mst7_wdata,
	  mst7_wlast,
	  mst7_wsid,
	  mst7_wstrb,
	  mst7_wvalid,
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	  mst8_araddr,
	  mst8_arburst,
	  mst8_arcache,
	  mst8_arid,
	  mst8_arlen,
	  mst8_arlock,
	  mst8_arprot,
	  mst8_arsize,
	  mst8_arvalid,
	  mst8_connect,
	  mst8_awaddr,
	  mst8_awburst,
	  mst8_awcache,
	  mst8_awid,
	  mst8_awlen,
	  mst8_awlock,
	  mst8_awprot,
	  mst8_awsize,
	  mst8_awvalid,
	  mst8_rready,
	  mst8_rsid,
	  mst8_bready,
	  mst8_bsid,
	  mst8_wdata,
	  mst8_wlast,
	  mst8_wsid,
	  mst8_wstrb,
	  mst8_wvalid,
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	  mst9_araddr,
	  mst9_arburst,
	  mst9_arcache,
	  mst9_arid,
	  mst9_arlen,
	  mst9_arlock,
	  mst9_arprot,
	  mst9_arsize,
	  mst9_arvalid,
	  mst9_connect,
	  mst9_awaddr,
	  mst9_awburst,
	  mst9_awcache,
	  mst9_awid,
	  mst9_awlen,
	  mst9_awlock,
	  mst9_awprot,
	  mst9_awsize,
	  mst9_awvalid,
	  mst9_rready,
	  mst9_rsid,
	  mst9_bready,
	  mst9_bsid,
	  mst9_wdata,
	  mst9_wlast,
	  mst9_wsid,
	  mst9_wstrb,
	  mst9_wvalid,
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	  mst10_araddr,
	  mst10_arburst,
	  mst10_arcache,
	  mst10_arid,
	  mst10_arlen,
	  mst10_arlock,
	  mst10_arprot,
	  mst10_arsize,
	  mst10_arvalid,
	  mst10_connect,
	  mst10_awaddr,
	  mst10_awburst,
	  mst10_awcache,
	  mst10_awid,
	  mst10_awlen,
	  mst10_awlock,
	  mst10_awprot,
	  mst10_awsize,
	  mst10_awvalid,
	  mst10_rready,
	  mst10_rsid,
	  mst10_bready,
	  mst10_bsid,
	  mst10_wdata,
	  mst10_wlast,
	  mst10_wsid,
	  mst10_wstrb,
	  mst10_wvalid,
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	  mst11_araddr,
	  mst11_arburst,
	  mst11_arcache,
	  mst11_arid,
	  mst11_arlen,
	  mst11_arlock,
	  mst11_arprot,
	  mst11_arsize,
	  mst11_arvalid,
	  mst11_connect,
	  mst11_awaddr,
	  mst11_awburst,
	  mst11_awcache,
	  mst11_awid,
	  mst11_awlen,
	  mst11_awlock,
	  mst11_awprot,
	  mst11_awsize,
	  mst11_awvalid,
	  mst11_rready,
	  mst11_rsid,
	  mst11_bready,
	  mst11_bsid,
	  mst11_wdata,
	  mst11_wlast,
	  mst11_wsid,
	  mst11_wstrb,
	  mst11_wvalid,
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	  mst12_araddr,
	  mst12_arburst,
	  mst12_arcache,
	  mst12_arid,
	  mst12_arlen,
	  mst12_arlock,
	  mst12_arprot,
	  mst12_arsize,
	  mst12_arvalid,
	  mst12_connect,
	  mst12_awaddr,
	  mst12_awburst,
	  mst12_awcache,
	  mst12_awid,
	  mst12_awlen,
	  mst12_awlock,
	  mst12_awprot,
	  mst12_awsize,
	  mst12_awvalid,
	  mst12_rready,
	  mst12_rsid,
	  mst12_bready,
	  mst12_bsid,
	  mst12_wdata,
	  mst12_wlast,
	  mst12_wsid,
	  mst12_wstrb,
	  mst12_wvalid,
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	  mst13_araddr,
	  mst13_arburst,
	  mst13_arcache,
	  mst13_arid,
	  mst13_arlen,
	  mst13_arlock,
	  mst13_arprot,
	  mst13_arsize,
	  mst13_arvalid,
	  mst13_connect,
	  mst13_awaddr,
	  mst13_awburst,
	  mst13_awcache,
	  mst13_awid,
	  mst13_awlen,
	  mst13_awlock,
	  mst13_awprot,
	  mst13_awsize,
	  mst13_awvalid,
	  mst13_rready,
	  mst13_rsid,
	  mst13_bready,
	  mst13_bsid,
	  mst13_wdata,
	  mst13_wlast,
	  mst13_wsid,
	  mst13_wstrb,
	  mst13_wvalid,
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	  mst14_araddr,
	  mst14_arburst,
	  mst14_arcache,
	  mst14_arid,
	  mst14_arlen,
	  mst14_arlock,
	  mst14_arprot,
	  mst14_arsize,
	  mst14_arvalid,
	  mst14_connect,
	  mst14_awaddr,
	  mst14_awburst,
	  mst14_awcache,
	  mst14_awid,
	  mst14_awlen,
	  mst14_awlock,
	  mst14_awprot,
	  mst14_awsize,
	  mst14_awvalid,
	  mst14_rready,
	  mst14_rsid,
	  mst14_bready,
	  mst14_bsid,
	  mst14_wdata,
	  mst14_wlast,
	  mst14_wsid,
	  mst14_wstrb,
	  mst14_wvalid,
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	  mst15_araddr,
	  mst15_arburst,
	  mst15_arcache,
	  mst15_arid,
	  mst15_arlen,
	  mst15_arlock,
	  mst15_arprot,
	  mst15_arsize,
	  mst15_arvalid,
	  mst15_connect,
	  mst15_awaddr,
	  mst15_awburst,
	  mst15_awcache,
	  mst15_awid,
	  mst15_awlen,
	  mst15_awlock,
	  mst15_awprot,
	  mst15_awsize,
	  mst15_awvalid,
	  mst15_rready,
	  mst15_rsid,
	  mst15_bready,
	  mst15_bsid,
	  mst15_wdata,
	  mst15_wlast,
	  mst15_wsid,
	  mst15_wstrb,
	  mst15_wvalid,
`endif
	  ds_araddr,
	  ds_arburst,
	  ds_arcache,
	  ds_arid,
	  ds_arlen,
	  ds_arlock,
	  ds_arprot,
	  ds_arready,
	  ds_arsize,
	  ds_arvalid,
	  slv_ar_mid,
	  slv_arready,
	  reg_mst0_high_priority,
	  reg_priority_reload,
	  aclk,
	  aresetn,
	  ds_awaddr,
	  ds_awburst,
	  ds_awcache,
	  ds_awid,
	  ds_awlen,
	  ds_awlock,
	  ds_awprot,
	  ds_awready,
	  ds_awsize,
	  ds_awvalid,
	  slv_aw_mid,
	  slv_awready,
	  ds_rdata,
	  ds_rid,
	  ds_rlast,
	  ds_rready,
	  ds_rresp,
	  ds_rvalid,
	  slv_read_data,
	  slv_rid,
	  slv_rvalid,
	  self_id,
	  ds_bid,
	  ds_bready,
	  ds_bresp,
	  ds_bvalid,
	  ds_wdata,
	  ds_wlast,
	  ds_wready,
	  ds_wstrb,
	  ds_wvalid,
	  slv_bid,
	  slv_bresp,
	  slv_bvalid,
	  slv_wmid,
	  slv_wready
);

parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 64;
parameter ID_WIDTH = 4;
parameter SLAVE_FIFO_DEPTH = 4;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam ID_MSB = ID_WIDTH - 1;

`ifdef ATCBMC300_MST0_SUPPORT
input               [ADDR_MSB:0] mst0_araddr;
input                      [1:0] mst0_arburst;
input                      [3:0] mst0_arcache;
input                 [ID_MSB:0] mst0_arid;
input                      [7:0] mst0_arlen;
input                            mst0_arlock;
input                      [2:0] mst0_arprot;
input                      [2:0] mst0_arsize;
input                            mst0_arvalid;
input                            mst0_connect;
input               [ADDR_MSB:0] mst0_awaddr;
input                      [1:0] mst0_awburst;
input                      [3:0] mst0_awcache;
input                 [ID_MSB:0] mst0_awid;
input                      [7:0] mst0_awlen;
input                            mst0_awlock;
input                      [2:0] mst0_awprot;
input                      [2:0] mst0_awsize;
input                            mst0_awvalid;
input                            mst0_rready;
input                      [4:0] mst0_rsid;
input                            mst0_bready;
input                      [4:0] mst0_bsid;
input               [DATA_MSB:0] mst0_wdata;
input                            mst0_wlast;
input                      [4:0] mst0_wsid;
input       [(DATA_WIDTH/8)-1:0] mst0_wstrb;
input                            mst0_wvalid;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
input               [ADDR_MSB:0] mst1_araddr;
input                      [1:0] mst1_arburst;
input                      [3:0] mst1_arcache;
input                 [ID_MSB:0] mst1_arid;
input                      [7:0] mst1_arlen;
input                            mst1_arlock;
input                      [2:0] mst1_arprot;
input                      [2:0] mst1_arsize;
input                            mst1_arvalid;
input                            mst1_connect;
input               [ADDR_MSB:0] mst1_awaddr;
input                      [1:0] mst1_awburst;
input                      [3:0] mst1_awcache;
input                 [ID_MSB:0] mst1_awid;
input                      [7:0] mst1_awlen;
input                            mst1_awlock;
input                      [2:0] mst1_awprot;
input                      [2:0] mst1_awsize;
input                            mst1_awvalid;
input                            mst1_rready;
input                      [4:0] mst1_rsid;
input                            mst1_bready;
input                      [4:0] mst1_bsid;
input               [DATA_MSB:0] mst1_wdata;
input                            mst1_wlast;
input                      [4:0] mst1_wsid;
input       [(DATA_WIDTH/8)-1:0] mst1_wstrb;
input                            mst1_wvalid;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
input               [ADDR_MSB:0] mst2_araddr;
input                      [1:0] mst2_arburst;
input                      [3:0] mst2_arcache;
input                 [ID_MSB:0] mst2_arid;
input                      [7:0] mst2_arlen;
input                            mst2_arlock;
input                      [2:0] mst2_arprot;
input                      [2:0] mst2_arsize;
input                            mst2_arvalid;
input                            mst2_connect;
input               [ADDR_MSB:0] mst2_awaddr;
input                      [1:0] mst2_awburst;
input                      [3:0] mst2_awcache;
input                 [ID_MSB:0] mst2_awid;
input                      [7:0] mst2_awlen;
input                            mst2_awlock;
input                      [2:0] mst2_awprot;
input                      [2:0] mst2_awsize;
input                            mst2_awvalid;
input                            mst2_rready;
input                      [4:0] mst2_rsid;
input                            mst2_bready;
input                      [4:0] mst2_bsid;
input               [DATA_MSB:0] mst2_wdata;
input                            mst2_wlast;
input                      [4:0] mst2_wsid;
input       [(DATA_WIDTH/8)-1:0] mst2_wstrb;
input                            mst2_wvalid;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
input               [ADDR_MSB:0] mst3_araddr;
input                      [1:0] mst3_arburst;
input                      [3:0] mst3_arcache;
input                 [ID_MSB:0] mst3_arid;
input                      [7:0] mst3_arlen;
input                            mst3_arlock;
input                      [2:0] mst3_arprot;
input                      [2:0] mst3_arsize;
input                            mst3_arvalid;
input                            mst3_connect;
input               [ADDR_MSB:0] mst3_awaddr;
input                      [1:0] mst3_awburst;
input                      [3:0] mst3_awcache;
input                 [ID_MSB:0] mst3_awid;
input                      [7:0] mst3_awlen;
input                            mst3_awlock;
input                      [2:0] mst3_awprot;
input                      [2:0] mst3_awsize;
input                            mst3_awvalid;
input                            mst3_rready;
input                      [4:0] mst3_rsid;
input                            mst3_bready;
input                      [4:0] mst3_bsid;
input               [DATA_MSB:0] mst3_wdata;
input                            mst3_wlast;
input                      [4:0] mst3_wsid;
input       [(DATA_WIDTH/8)-1:0] mst3_wstrb;
input                            mst3_wvalid;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
input               [ADDR_MSB:0] mst4_araddr;
input                      [1:0] mst4_arburst;
input                      [3:0] mst4_arcache;
input                 [ID_MSB:0] mst4_arid;
input                      [7:0] mst4_arlen;
input                            mst4_arlock;
input                      [2:0] mst4_arprot;
input                      [2:0] mst4_arsize;
input                            mst4_arvalid;
input                            mst4_connect;
input               [ADDR_MSB:0] mst4_awaddr;
input                      [1:0] mst4_awburst;
input                      [3:0] mst4_awcache;
input                 [ID_MSB:0] mst4_awid;
input                      [7:0] mst4_awlen;
input                            mst4_awlock;
input                      [2:0] mst4_awprot;
input                      [2:0] mst4_awsize;
input                            mst4_awvalid;
input                            mst4_rready;
input                      [4:0] mst4_rsid;
input                            mst4_bready;
input                      [4:0] mst4_bsid;
input               [DATA_MSB:0] mst4_wdata;
input                            mst4_wlast;
input                      [4:0] mst4_wsid;
input       [(DATA_WIDTH/8)-1:0] mst4_wstrb;
input                            mst4_wvalid;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
input               [ADDR_MSB:0] mst5_araddr;
input                      [1:0] mst5_arburst;
input                      [3:0] mst5_arcache;
input                 [ID_MSB:0] mst5_arid;
input                      [7:0] mst5_arlen;
input                            mst5_arlock;
input                      [2:0] mst5_arprot;
input                      [2:0] mst5_arsize;
input                            mst5_arvalid;
input                            mst5_connect;
input               [ADDR_MSB:0] mst5_awaddr;
input                      [1:0] mst5_awburst;
input                      [3:0] mst5_awcache;
input                 [ID_MSB:0] mst5_awid;
input                      [7:0] mst5_awlen;
input                            mst5_awlock;
input                      [2:0] mst5_awprot;
input                      [2:0] mst5_awsize;
input                            mst5_awvalid;
input                            mst5_rready;
input                      [4:0] mst5_rsid;
input                            mst5_bready;
input                      [4:0] mst5_bsid;
input               [DATA_MSB:0] mst5_wdata;
input                            mst5_wlast;
input                      [4:0] mst5_wsid;
input       [(DATA_WIDTH/8)-1:0] mst5_wstrb;
input                            mst5_wvalid;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
input               [ADDR_MSB:0] mst6_araddr;
input                      [1:0] mst6_arburst;
input                      [3:0] mst6_arcache;
input                 [ID_MSB:0] mst6_arid;
input                      [7:0] mst6_arlen;
input                            mst6_arlock;
input                      [2:0] mst6_arprot;
input                      [2:0] mst6_arsize;
input                            mst6_arvalid;
input                            mst6_connect;
input               [ADDR_MSB:0] mst6_awaddr;
input                      [1:0] mst6_awburst;
input                      [3:0] mst6_awcache;
input                 [ID_MSB:0] mst6_awid;
input                      [7:0] mst6_awlen;
input                            mst6_awlock;
input                      [2:0] mst6_awprot;
input                      [2:0] mst6_awsize;
input                            mst6_awvalid;
input                            mst6_rready;
input                      [4:0] mst6_rsid;
input                            mst6_bready;
input                      [4:0] mst6_bsid;
input               [DATA_MSB:0] mst6_wdata;
input                            mst6_wlast;
input                      [4:0] mst6_wsid;
input       [(DATA_WIDTH/8)-1:0] mst6_wstrb;
input                            mst6_wvalid;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
input               [ADDR_MSB:0] mst7_araddr;
input                      [1:0] mst7_arburst;
input                      [3:0] mst7_arcache;
input                 [ID_MSB:0] mst7_arid;
input                      [7:0] mst7_arlen;
input                            mst7_arlock;
input                      [2:0] mst7_arprot;
input                      [2:0] mst7_arsize;
input                            mst7_arvalid;
input                            mst7_connect;
input               [ADDR_MSB:0] mst7_awaddr;
input                      [1:0] mst7_awburst;
input                      [3:0] mst7_awcache;
input                 [ID_MSB:0] mst7_awid;
input                      [7:0] mst7_awlen;
input                            mst7_awlock;
input                      [2:0] mst7_awprot;
input                      [2:0] mst7_awsize;
input                            mst7_awvalid;
input                            mst7_rready;
input                      [4:0] mst7_rsid;
input                            mst7_bready;
input                      [4:0] mst7_bsid;
input               [DATA_MSB:0] mst7_wdata;
input                            mst7_wlast;
input                      [4:0] mst7_wsid;
input       [(DATA_WIDTH/8)-1:0] mst7_wstrb;
input                            mst7_wvalid;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
input               [ADDR_MSB:0] mst8_araddr;
input                      [1:0] mst8_arburst;
input                      [3:0] mst8_arcache;
input                 [ID_MSB:0] mst8_arid;
input                      [7:0] mst8_arlen;
input                            mst8_arlock;
input                      [2:0] mst8_arprot;
input                      [2:0] mst8_arsize;
input                            mst8_arvalid;
input                            mst8_connect;
input               [ADDR_MSB:0] mst8_awaddr;
input                      [1:0] mst8_awburst;
input                      [3:0] mst8_awcache;
input                 [ID_MSB:0] mst8_awid;
input                      [7:0] mst8_awlen;
input                            mst8_awlock;
input                      [2:0] mst8_awprot;
input                      [2:0] mst8_awsize;
input                            mst8_awvalid;
input                            mst8_rready;
input                      [4:0] mst8_rsid;
input                            mst8_bready;
input                      [4:0] mst8_bsid;
input               [DATA_MSB:0] mst8_wdata;
input                            mst8_wlast;
input                      [4:0] mst8_wsid;
input       [(DATA_WIDTH/8)-1:0] mst8_wstrb;
input                            mst8_wvalid;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
input               [ADDR_MSB:0] mst9_araddr;
input                      [1:0] mst9_arburst;
input                      [3:0] mst9_arcache;
input                 [ID_MSB:0] mst9_arid;
input                      [7:0] mst9_arlen;
input                            mst9_arlock;
input                      [2:0] mst9_arprot;
input                      [2:0] mst9_arsize;
input                            mst9_arvalid;
input                            mst9_connect;
input               [ADDR_MSB:0] mst9_awaddr;
input                      [1:0] mst9_awburst;
input                      [3:0] mst9_awcache;
input                 [ID_MSB:0] mst9_awid;
input                      [7:0] mst9_awlen;
input                            mst9_awlock;
input                      [2:0] mst9_awprot;
input                      [2:0] mst9_awsize;
input                            mst9_awvalid;
input                            mst9_rready;
input                      [4:0] mst9_rsid;
input                            mst9_bready;
input                      [4:0] mst9_bsid;
input               [DATA_MSB:0] mst9_wdata;
input                            mst9_wlast;
input                      [4:0] mst9_wsid;
input       [(DATA_WIDTH/8)-1:0] mst9_wstrb;
input                            mst9_wvalid;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
input               [ADDR_MSB:0] mst10_araddr;
input                      [1:0] mst10_arburst;
input                      [3:0] mst10_arcache;
input                 [ID_MSB:0] mst10_arid;
input                      [7:0] mst10_arlen;
input                            mst10_arlock;
input                      [2:0] mst10_arprot;
input                      [2:0] mst10_arsize;
input                            mst10_arvalid;
input                            mst10_connect;
input               [ADDR_MSB:0] mst10_awaddr;
input                      [1:0] mst10_awburst;
input                      [3:0] mst10_awcache;
input                 [ID_MSB:0] mst10_awid;
input                      [7:0] mst10_awlen;
input                            mst10_awlock;
input                      [2:0] mst10_awprot;
input                      [2:0] mst10_awsize;
input                            mst10_awvalid;
input                            mst10_rready;
input                      [4:0] mst10_rsid;
input                            mst10_bready;
input                      [4:0] mst10_bsid;
input               [DATA_MSB:0] mst10_wdata;
input                            mst10_wlast;
input                      [4:0] mst10_wsid;
input       [(DATA_WIDTH/8)-1:0] mst10_wstrb;
input                            mst10_wvalid;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
input               [ADDR_MSB:0] mst11_araddr;
input                      [1:0] mst11_arburst;
input                      [3:0] mst11_arcache;
input                 [ID_MSB:0] mst11_arid;
input                      [7:0] mst11_arlen;
input                            mst11_arlock;
input                      [2:0] mst11_arprot;
input                      [2:0] mst11_arsize;
input                            mst11_arvalid;
input                            mst11_connect;
input               [ADDR_MSB:0] mst11_awaddr;
input                      [1:0] mst11_awburst;
input                      [3:0] mst11_awcache;
input                 [ID_MSB:0] mst11_awid;
input                      [7:0] mst11_awlen;
input                            mst11_awlock;
input                      [2:0] mst11_awprot;
input                      [2:0] mst11_awsize;
input                            mst11_awvalid;
input                            mst11_rready;
input                      [4:0] mst11_rsid;
input                            mst11_bready;
input                      [4:0] mst11_bsid;
input               [DATA_MSB:0] mst11_wdata;
input                            mst11_wlast;
input                      [4:0] mst11_wsid;
input       [(DATA_WIDTH/8)-1:0] mst11_wstrb;
input                            mst11_wvalid;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
input               [ADDR_MSB:0] mst12_araddr;
input                      [1:0] mst12_arburst;
input                      [3:0] mst12_arcache;
input                 [ID_MSB:0] mst12_arid;
input                      [7:0] mst12_arlen;
input                            mst12_arlock;
input                      [2:0] mst12_arprot;
input                      [2:0] mst12_arsize;
input                            mst12_arvalid;
input                            mst12_connect;
input               [ADDR_MSB:0] mst12_awaddr;
input                      [1:0] mst12_awburst;
input                      [3:0] mst12_awcache;
input                 [ID_MSB:0] mst12_awid;
input                      [7:0] mst12_awlen;
input                            mst12_awlock;
input                      [2:0] mst12_awprot;
input                      [2:0] mst12_awsize;
input                            mst12_awvalid;
input                            mst12_rready;
input                      [4:0] mst12_rsid;
input                            mst12_bready;
input                      [4:0] mst12_bsid;
input               [DATA_MSB:0] mst12_wdata;
input                            mst12_wlast;
input                      [4:0] mst12_wsid;
input       [(DATA_WIDTH/8)-1:0] mst12_wstrb;
input                            mst12_wvalid;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
input               [ADDR_MSB:0] mst13_araddr;
input                      [1:0] mst13_arburst;
input                      [3:0] mst13_arcache;
input                 [ID_MSB:0] mst13_arid;
input                      [7:0] mst13_arlen;
input                            mst13_arlock;
input                      [2:0] mst13_arprot;
input                      [2:0] mst13_arsize;
input                            mst13_arvalid;
input                            mst13_connect;
input               [ADDR_MSB:0] mst13_awaddr;
input                      [1:0] mst13_awburst;
input                      [3:0] mst13_awcache;
input                 [ID_MSB:0] mst13_awid;
input                      [7:0] mst13_awlen;
input                            mst13_awlock;
input                      [2:0] mst13_awprot;
input                      [2:0] mst13_awsize;
input                            mst13_awvalid;
input                            mst13_rready;
input                      [4:0] mst13_rsid;
input                            mst13_bready;
input                      [4:0] mst13_bsid;
input               [DATA_MSB:0] mst13_wdata;
input                            mst13_wlast;
input                      [4:0] mst13_wsid;
input       [(DATA_WIDTH/8)-1:0] mst13_wstrb;
input                            mst13_wvalid;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
input               [ADDR_MSB:0] mst14_araddr;
input                      [1:0] mst14_arburst;
input                      [3:0] mst14_arcache;
input                 [ID_MSB:0] mst14_arid;
input                      [7:0] mst14_arlen;
input                            mst14_arlock;
input                      [2:0] mst14_arprot;
input                      [2:0] mst14_arsize;
input                            mst14_arvalid;
input                            mst14_connect;
input               [ADDR_MSB:0] mst14_awaddr;
input                      [1:0] mst14_awburst;
input                      [3:0] mst14_awcache;
input                 [ID_MSB:0] mst14_awid;
input                      [7:0] mst14_awlen;
input                            mst14_awlock;
input                      [2:0] mst14_awprot;
input                      [2:0] mst14_awsize;
input                            mst14_awvalid;
input                            mst14_rready;
input                      [4:0] mst14_rsid;
input                            mst14_bready;
input                      [4:0] mst14_bsid;
input               [DATA_MSB:0] mst14_wdata;
input                            mst14_wlast;
input                      [4:0] mst14_wsid;
input       [(DATA_WIDTH/8)-1:0] mst14_wstrb;
input                            mst14_wvalid;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
input               [ADDR_MSB:0] mst15_araddr;
input                      [1:0] mst15_arburst;
input                      [3:0] mst15_arcache;
input                 [ID_MSB:0] mst15_arid;
input                      [7:0] mst15_arlen;
input                            mst15_arlock;
input                      [2:0] mst15_arprot;
input                      [2:0] mst15_arsize;
input                            mst15_arvalid;
input                            mst15_connect;
input               [ADDR_MSB:0] mst15_awaddr;
input                      [1:0] mst15_awburst;
input                      [3:0] mst15_awcache;
input                 [ID_MSB:0] mst15_awid;
input                      [7:0] mst15_awlen;
input                            mst15_awlock;
input                      [2:0] mst15_awprot;
input                      [2:0] mst15_awsize;
input                            mst15_awvalid;
input                            mst15_rready;
input                      [4:0] mst15_rsid;
input                            mst15_bready;
input                      [4:0] mst15_bsid;
input               [DATA_MSB:0] mst15_wdata;
input                            mst15_wlast;
input                      [4:0] mst15_wsid;
input       [(DATA_WIDTH/8)-1:0] mst15_wstrb;
input                            mst15_wvalid;
`endif
output              [ADDR_MSB:0] ds_araddr;
output                     [1:0] ds_arburst;
output                     [3:0] ds_arcache;
output            [(ID_MSB+4):0] ds_arid;
output                     [7:0] ds_arlen;
output                           ds_arlock;
output                     [2:0] ds_arprot;
input                            ds_arready;
output                     [2:0] ds_arsize;
output                           ds_arvalid;
output                     [3:0] slv_ar_mid;
output                           slv_arready;
input                            reg_mst0_high_priority;
input                     [15:0] reg_priority_reload;
input                            aclk;
input                            aresetn;
output              [ADDR_MSB:0] ds_awaddr;
output                     [1:0] ds_awburst;
output                     [3:0] ds_awcache;
output            [(ID_MSB+4):0] ds_awid;
output                     [7:0] ds_awlen;
output                           ds_awlock;
output                     [2:0] ds_awprot;
input                            ds_awready;
output                     [2:0] ds_awsize;
output                           ds_awvalid;
output                     [3:0] slv_aw_mid;
output                           slv_awready;
input               [DATA_MSB:0] ds_rdata;
input               [ID_MSB+4:0] ds_rid;
input                            ds_rlast;
output                           ds_rready;
input                      [1:0] ds_rresp;
input                            ds_rvalid;
output            [DATA_MSB+3:0] slv_read_data;
output              [ID_MSB+4:0] slv_rid;
output                           slv_rvalid;
input                      [4:0] self_id;
input               [ID_MSB+4:0] ds_bid;
output                           ds_bready;
input                      [1:0] ds_bresp;
input                            ds_bvalid;
output              [DATA_MSB:0] ds_wdata;
output                           ds_wlast;
input                            ds_wready;
output      [(DATA_WIDTH/8)-1:0] ds_wstrb;
output                           ds_wvalid;
output              [ID_MSB+4:0] slv_bid;
output                     [1:0] slv_bresp;
output                           slv_bvalid;
output                     [3:0] slv_wmid;
output                           slv_wready;

wire                             s0;
wire                             s1;
wire                             s2;
wire                             s3;


atcbmc300_ds_addr_ctrl #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        )
) ds_aw_addr (
`ifdef ATCBMC300_MST0_SUPPORT
	.mst0_addr             (mst0_awaddr           ),
	.mst0_len              (mst0_awlen            ),
	.mst0_size             (mst0_awsize           ),
	.mst0_burst            (mst0_awburst          ),
	.mst0_lock             (mst0_awlock           ),
	.mst0_cache            (mst0_awcache          ),
	.mst0_prot             (mst0_awprot           ),
	.mst0_aid              (mst0_awid             ),
	.mst0_avalid           (mst0_awvalid          ),
	.mst0_connect          (mst0_connect          ),
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	.mst1_addr             (mst1_awaddr           ),
	.mst1_len              (mst1_awlen            ),
	.mst1_size             (mst1_awsize           ),
	.mst1_burst            (mst1_awburst          ),
	.mst1_lock             (mst1_awlock           ),
	.mst1_cache            (mst1_awcache          ),
	.mst1_prot             (mst1_awprot           ),
	.mst1_aid              (mst1_awid             ),
	.mst1_avalid           (mst1_awvalid          ),
	.mst1_connect          (mst1_connect          ),
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	.mst2_addr             (mst2_awaddr           ),
	.mst2_len              (mst2_awlen            ),
	.mst2_size             (mst2_awsize           ),
	.mst2_burst            (mst2_awburst          ),
	.mst2_lock             (mst2_awlock           ),
	.mst2_cache            (mst2_awcache          ),
	.mst2_prot             (mst2_awprot           ),
	.mst2_aid              (mst2_awid             ),
	.mst2_avalid           (mst2_awvalid          ),
	.mst2_connect          (mst2_connect          ),
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	.mst3_addr             (mst3_awaddr           ),
	.mst3_len              (mst3_awlen            ),
	.mst3_size             (mst3_awsize           ),
	.mst3_burst            (mst3_awburst          ),
	.mst3_lock             (mst3_awlock           ),
	.mst3_cache            (mst3_awcache          ),
	.mst3_prot             (mst3_awprot           ),
	.mst3_aid              (mst3_awid             ),
	.mst3_avalid           (mst3_awvalid          ),
	.mst3_connect          (mst3_connect          ),
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	.mst4_addr             (mst4_awaddr           ),
	.mst4_len              (mst4_awlen            ),
	.mst4_size             (mst4_awsize           ),
	.mst4_burst            (mst4_awburst          ),
	.mst4_lock             (mst4_awlock           ),
	.mst4_cache            (mst4_awcache          ),
	.mst4_prot             (mst4_awprot           ),
	.mst4_aid              (mst4_awid             ),
	.mst4_avalid           (mst4_awvalid          ),
	.mst4_connect          (mst4_connect          ),
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	.mst5_addr             (mst5_awaddr           ),
	.mst5_len              (mst5_awlen            ),
	.mst5_size             (mst5_awsize           ),
	.mst5_burst            (mst5_awburst          ),
	.mst5_lock             (mst5_awlock           ),
	.mst5_cache            (mst5_awcache          ),
	.mst5_prot             (mst5_awprot           ),
	.mst5_aid              (mst5_awid             ),
	.mst5_avalid           (mst5_awvalid          ),
	.mst5_connect          (mst5_connect          ),
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	.mst6_addr             (mst6_awaddr           ),
	.mst6_len              (mst6_awlen            ),
	.mst6_size             (mst6_awsize           ),
	.mst6_burst            (mst6_awburst          ),
	.mst6_lock             (mst6_awlock           ),
	.mst6_cache            (mst6_awcache          ),
	.mst6_prot             (mst6_awprot           ),
	.mst6_aid              (mst6_awid             ),
	.mst6_avalid           (mst6_awvalid          ),
	.mst6_connect          (mst6_connect          ),
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	.mst7_addr             (mst7_awaddr           ),
	.mst7_len              (mst7_awlen            ),
	.mst7_size             (mst7_awsize           ),
	.mst7_burst            (mst7_awburst          ),
	.mst7_lock             (mst7_awlock           ),
	.mst7_cache            (mst7_awcache          ),
	.mst7_prot             (mst7_awprot           ),
	.mst7_aid              (mst7_awid             ),
	.mst7_avalid           (mst7_awvalid          ),
	.mst7_connect          (mst7_connect          ),
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	.mst8_addr             (mst8_awaddr           ),
	.mst8_len              (mst8_awlen            ),
	.mst8_size             (mst8_awsize           ),
	.mst8_burst            (mst8_awburst          ),
	.mst8_lock             (mst8_awlock           ),
	.mst8_cache            (mst8_awcache          ),
	.mst8_prot             (mst8_awprot           ),
	.mst8_aid              (mst8_awid             ),
	.mst8_avalid           (mst8_awvalid          ),
	.mst8_connect          (mst8_connect          ),
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	.mst9_addr             (mst9_awaddr           ),
	.mst9_len              (mst9_awlen            ),
	.mst9_size             (mst9_awsize           ),
	.mst9_burst            (mst9_awburst          ),
	.mst9_lock             (mst9_awlock           ),
	.mst9_cache            (mst9_awcache          ),
	.mst9_prot             (mst9_awprot           ),
	.mst9_aid              (mst9_awid             ),
	.mst9_avalid           (mst9_awvalid          ),
	.mst9_connect          (mst9_connect          ),
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	.mst10_addr            (mst10_awaddr          ),
	.mst10_len             (mst10_awlen           ),
	.mst10_size            (mst10_awsize          ),
	.mst10_burst           (mst10_awburst         ),
	.mst10_lock            (mst10_awlock          ),
	.mst10_cache           (mst10_awcache         ),
	.mst10_prot            (mst10_awprot          ),
	.mst10_aid             (mst10_awid            ),
	.mst10_avalid          (mst10_awvalid         ),
	.mst10_connect         (mst10_connect         ),
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	.mst11_addr            (mst11_awaddr          ),
	.mst11_len             (mst11_awlen           ),
	.mst11_size            (mst11_awsize          ),
	.mst11_burst           (mst11_awburst         ),
	.mst11_lock            (mst11_awlock          ),
	.mst11_cache           (mst11_awcache         ),
	.mst11_prot            (mst11_awprot          ),
	.mst11_aid             (mst11_awid            ),
	.mst11_avalid          (mst11_awvalid         ),
	.mst11_connect         (mst11_connect         ),
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	.mst12_addr            (mst12_awaddr          ),
	.mst12_len             (mst12_awlen           ),
	.mst12_size            (mst12_awsize          ),
	.mst12_burst           (mst12_awburst         ),
	.mst12_lock            (mst12_awlock          ),
	.mst12_cache           (mst12_awcache         ),
	.mst12_prot            (mst12_awprot          ),
	.mst12_aid             (mst12_awid            ),
	.mst12_avalid          (mst12_awvalid         ),
	.mst12_connect         (mst12_connect         ),
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	.mst13_addr            (mst13_awaddr          ),
	.mst13_len             (mst13_awlen           ),
	.mst13_size            (mst13_awsize          ),
	.mst13_burst           (mst13_awburst         ),
	.mst13_lock            (mst13_awlock          ),
	.mst13_cache           (mst13_awcache         ),
	.mst13_prot            (mst13_awprot          ),
	.mst13_aid             (mst13_awid            ),
	.mst13_avalid          (mst13_awvalid         ),
	.mst13_connect         (mst13_connect         ),
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	.mst14_addr            (mst14_awaddr          ),
	.mst14_len             (mst14_awlen           ),
	.mst14_size            (mst14_awsize          ),
	.mst14_burst           (mst14_awburst         ),
	.mst14_lock            (mst14_awlock          ),
	.mst14_cache           (mst14_awcache         ),
	.mst14_prot            (mst14_awprot          ),
	.mst14_aid             (mst14_awid            ),
	.mst14_avalid          (mst14_awvalid         ),
	.mst14_connect         (mst14_connect         ),
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	.mst15_addr            (mst15_awaddr          ),
	.mst15_len             (mst15_awlen           ),
	.mst15_size            (mst15_awsize          ),
	.mst15_burst           (mst15_awburst         ),
	.mst15_lock            (mst15_awlock          ),
	.mst15_cache           (mst15_awcache         ),
	.mst15_prot            (mst15_awprot          ),
	.mst15_aid             (mst15_awid            ),
	.mst15_avalid          (mst15_awvalid         ),
	.mst15_connect         (mst15_connect         ),
`endif
	.addr_outstanding_en   (s1),
	.slv_aready            (slv_awready           ),
	.arb_mid               (slv_aw_mid            ),
	.outstanding_ready     (s3  ),
	.addr                  (ds_awaddr             ),
	.len                   (ds_awlen              ),
	.size                  (ds_awsize             ),
	.burst                 (ds_awburst            ),
	.lock                  (ds_awlock             ),
	.cache                 (ds_awcache            ),
	.prot                  (ds_awprot             ),
	.aid                   (ds_awid               ),
	.avalid                (ds_awvalid            ),
	.aready                (ds_awready            ),
	.reg_mst0_high_priority(reg_mst0_high_priority),
	.reg_priority_reload   (reg_priority_reload   ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               )
);

atcbmc300_ds_wdata_bresp_ctrl #(
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTANDING_DEPTH(SLAVE_FIFO_DEPTH)
) ds_wdata_bresp (
	.self_id            (self_id               ),
`ifdef ATCBMC300_MST0_SUPPORT
	.mst0_wvalid        (mst0_wvalid           ),
	.mst0_wlast         (mst0_wlast            ),
	.mst0_wdata         (mst0_wdata            ),
	.mst0_wstrb         (mst0_wstrb            ),
	.mst0_wsid          (mst0_wsid             ),
	.mst0_bready        (mst0_bready           ),
	.mst0_bsid          (mst0_bsid             ),
	.mst0_connect       (mst0_connect          ),
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	.mst1_wvalid        (mst1_wvalid           ),
	.mst1_wlast         (mst1_wlast            ),
	.mst1_wdata         (mst1_wdata            ),
	.mst1_wstrb         (mst1_wstrb            ),
	.mst1_wsid          (mst1_wsid             ),
	.mst1_bready        (mst1_bready           ),
	.mst1_bsid          (mst1_bsid             ),
	.mst1_connect       (mst1_connect          ),
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	.mst2_wvalid        (mst2_wvalid           ),
	.mst2_wlast         (mst2_wlast            ),
	.mst2_wdata         (mst2_wdata            ),
	.mst2_wstrb         (mst2_wstrb            ),
	.mst2_wsid          (mst2_wsid             ),
	.mst2_bready        (mst2_bready           ),
	.mst2_bsid          (mst2_bsid             ),
	.mst2_connect       (mst2_connect          ),
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	.mst3_wvalid        (mst3_wvalid           ),
	.mst3_wlast         (mst3_wlast            ),
	.mst3_wdata         (mst3_wdata            ),
	.mst3_wstrb         (mst3_wstrb            ),
	.mst3_wsid          (mst3_wsid             ),
	.mst3_bready        (mst3_bready           ),
	.mst3_bsid          (mst3_bsid             ),
	.mst3_connect       (mst3_connect          ),
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	.mst4_wvalid        (mst4_wvalid           ),
	.mst4_wlast         (mst4_wlast            ),
	.mst4_wdata         (mst4_wdata            ),
	.mst4_wstrb         (mst4_wstrb            ),
	.mst4_wsid          (mst4_wsid             ),
	.mst4_bready        (mst4_bready           ),
	.mst4_bsid          (mst4_bsid             ),
	.mst4_connect       (mst4_connect          ),
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	.mst5_wvalid        (mst5_wvalid           ),
	.mst5_wlast         (mst5_wlast            ),
	.mst5_wdata         (mst5_wdata            ),
	.mst5_wstrb         (mst5_wstrb            ),
	.mst5_wsid          (mst5_wsid             ),
	.mst5_bready        (mst5_bready           ),
	.mst5_bsid          (mst5_bsid             ),
	.mst5_connect       (mst5_connect          ),
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	.mst6_wvalid        (mst6_wvalid           ),
	.mst6_wlast         (mst6_wlast            ),
	.mst6_wdata         (mst6_wdata            ),
	.mst6_wstrb         (mst6_wstrb            ),
	.mst6_wsid          (mst6_wsid             ),
	.mst6_bready        (mst6_bready           ),
	.mst6_bsid          (mst6_bsid             ),
	.mst6_connect       (mst6_connect          ),
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	.mst7_wvalid        (mst7_wvalid           ),
	.mst7_wlast         (mst7_wlast            ),
	.mst7_wdata         (mst7_wdata            ),
	.mst7_wstrb         (mst7_wstrb            ),
	.mst7_wsid          (mst7_wsid             ),
	.mst7_bready        (mst7_bready           ),
	.mst7_bsid          (mst7_bsid             ),
	.mst7_connect       (mst7_connect          ),
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	.mst8_wvalid        (mst8_wvalid           ),
	.mst8_wlast         (mst8_wlast            ),
	.mst8_wdata         (mst8_wdata            ),
	.mst8_wstrb         (mst8_wstrb            ),
	.mst8_wsid          (mst8_wsid             ),
	.mst8_bready        (mst8_bready           ),
	.mst8_bsid          (mst8_bsid             ),
	.mst8_connect       (mst8_connect          ),
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	.mst9_wvalid        (mst9_wvalid           ),
	.mst9_wlast         (mst9_wlast            ),
	.mst9_wdata         (mst9_wdata            ),
	.mst9_wstrb         (mst9_wstrb            ),
	.mst9_wsid          (mst9_wsid             ),
	.mst9_bready        (mst9_bready           ),
	.mst9_bsid          (mst9_bsid             ),
	.mst9_connect       (mst9_connect          ),
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	.mst10_wvalid       (mst10_wvalid          ),
	.mst10_wlast        (mst10_wlast           ),
	.mst10_wdata        (mst10_wdata           ),
	.mst10_wstrb        (mst10_wstrb           ),
	.mst10_wsid         (mst10_wsid            ),
	.mst10_bready       (mst10_bready          ),
	.mst10_bsid         (mst10_bsid            ),
	.mst10_connect      (mst10_connect         ),
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	.mst11_wvalid       (mst11_wvalid          ),
	.mst11_wlast        (mst11_wlast           ),
	.mst11_wdata        (mst11_wdata           ),
	.mst11_wstrb        (mst11_wstrb           ),
	.mst11_wsid         (mst11_wsid            ),
	.mst11_bready       (mst11_bready          ),
	.mst11_bsid         (mst11_bsid            ),
	.mst11_connect      (mst11_connect         ),
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	.mst12_wvalid       (mst12_wvalid          ),
	.mst12_wlast        (mst12_wlast           ),
	.mst12_wdata        (mst12_wdata           ),
	.mst12_wstrb        (mst12_wstrb           ),
	.mst12_wsid         (mst12_wsid            ),
	.mst12_bready       (mst12_bready          ),
	.mst12_bsid         (mst12_bsid            ),
	.mst12_connect      (mst12_connect         ),
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	.mst13_wvalid       (mst13_wvalid          ),
	.mst13_wlast        (mst13_wlast           ),
	.mst13_wdata        (mst13_wdata           ),
	.mst13_wstrb        (mst13_wstrb           ),
	.mst13_wsid         (mst13_wsid            ),
	.mst13_bready       (mst13_bready          ),
	.mst13_bsid         (mst13_bsid            ),
	.mst13_connect      (mst13_connect         ),
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	.mst14_wvalid       (mst14_wvalid          ),
	.mst14_wlast        (mst14_wlast           ),
	.mst14_wdata        (mst14_wdata           ),
	.mst14_wstrb        (mst14_wstrb           ),
	.mst14_wsid         (mst14_wsid            ),
	.mst14_bready       (mst14_bready          ),
	.mst14_bsid         (mst14_bsid            ),
	.mst14_connect      (mst14_connect         ),
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	.mst15_wvalid       (mst15_wvalid          ),
	.mst15_wlast        (mst15_wlast           ),
	.mst15_wdata        (mst15_wdata           ),
	.mst15_wstrb        (mst15_wstrb           ),
	.mst15_wsid         (mst15_wsid            ),
	.mst15_bready       (mst15_bready          ),
	.mst15_bsid         (mst15_bsid            ),
	.mst15_connect      (mst15_connect         ),
`endif
	.ds_wdata           (ds_wdata              ),
	.ds_wlast           (ds_wlast              ),
	.ds_wstrb           (ds_wstrb              ),
	.ds_wvalid          (ds_wvalid             ),
	.ds_wready          (ds_wready             ),
	.slv_wmid           (slv_wmid              ),
	.slv_wready         (slv_wready            ),
	.outstanding_ready  (s3  ),
	.slv_aid            (slv_aw_mid            ),
	.addr_outstanding_en(s1),
	.ds_bresp           (ds_bresp              ),
	.ds_bid             (ds_bid                ),
	.ds_bvalid          (ds_bvalid             ),
	.ds_bready          (ds_bready             ),
	.slv_bvalid         (slv_bvalid            ),
	.slv_bresp          (slv_bresp             ),
	.slv_bid            (slv_bid               ),
	.aclk               (aclk                  ),
	.aresetn            (aresetn               )
);

atcbmc300_ds_addr_ctrl #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        )
) ds_ar_addr (
`ifdef ATCBMC300_MST0_SUPPORT
	.mst0_addr             (mst0_araddr           ),
	.mst0_len              (mst0_arlen            ),
	.mst0_size             (mst0_arsize           ),
	.mst0_burst            (mst0_arburst          ),
	.mst0_lock             (mst0_arlock           ),
	.mst0_cache            (mst0_arcache          ),
	.mst0_prot             (mst0_arprot           ),
	.mst0_aid              (mst0_arid             ),
	.mst0_avalid           (mst0_arvalid          ),
	.mst0_connect          (mst0_connect          ),
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	.mst1_addr             (mst1_araddr           ),
	.mst1_len              (mst1_arlen            ),
	.mst1_size             (mst1_arsize           ),
	.mst1_burst            (mst1_arburst          ),
	.mst1_lock             (mst1_arlock           ),
	.mst1_cache            (mst1_arcache          ),
	.mst1_prot             (mst1_arprot           ),
	.mst1_aid              (mst1_arid             ),
	.mst1_avalid           (mst1_arvalid          ),
	.mst1_connect          (mst1_connect          ),
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	.mst2_addr             (mst2_araddr           ),
	.mst2_len              (mst2_arlen            ),
	.mst2_size             (mst2_arsize           ),
	.mst2_burst            (mst2_arburst          ),
	.mst2_lock             (mst2_arlock           ),
	.mst2_cache            (mst2_arcache          ),
	.mst2_prot             (mst2_arprot           ),
	.mst2_aid              (mst2_arid             ),
	.mst2_avalid           (mst2_arvalid          ),
	.mst2_connect          (mst2_connect          ),
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	.mst3_addr             (mst3_araddr           ),
	.mst3_len              (mst3_arlen            ),
	.mst3_size             (mst3_arsize           ),
	.mst3_burst            (mst3_arburst          ),
	.mst3_lock             (mst3_arlock           ),
	.mst3_cache            (mst3_arcache          ),
	.mst3_prot             (mst3_arprot           ),
	.mst3_aid              (mst3_arid             ),
	.mst3_avalid           (mst3_arvalid          ),
	.mst3_connect          (mst3_connect          ),
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	.mst4_addr             (mst4_araddr           ),
	.mst4_len              (mst4_arlen            ),
	.mst4_size             (mst4_arsize           ),
	.mst4_burst            (mst4_arburst          ),
	.mst4_lock             (mst4_arlock           ),
	.mst4_cache            (mst4_arcache          ),
	.mst4_prot             (mst4_arprot           ),
	.mst4_aid              (mst4_arid             ),
	.mst4_avalid           (mst4_arvalid          ),
	.mst4_connect          (mst4_connect          ),
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	.mst5_addr             (mst5_araddr           ),
	.mst5_len              (mst5_arlen            ),
	.mst5_size             (mst5_arsize           ),
	.mst5_burst            (mst5_arburst          ),
	.mst5_lock             (mst5_arlock           ),
	.mst5_cache            (mst5_arcache          ),
	.mst5_prot             (mst5_arprot           ),
	.mst5_aid              (mst5_arid             ),
	.mst5_avalid           (mst5_arvalid          ),
	.mst5_connect          (mst5_connect          ),
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	.mst6_addr             (mst6_araddr           ),
	.mst6_len              (mst6_arlen            ),
	.mst6_size             (mst6_arsize           ),
	.mst6_burst            (mst6_arburst          ),
	.mst6_lock             (mst6_arlock           ),
	.mst6_cache            (mst6_arcache          ),
	.mst6_prot             (mst6_arprot           ),
	.mst6_aid              (mst6_arid             ),
	.mst6_avalid           (mst6_arvalid          ),
	.mst6_connect          (mst6_connect          ),
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	.mst7_addr             (mst7_araddr           ),
	.mst7_len              (mst7_arlen            ),
	.mst7_size             (mst7_arsize           ),
	.mst7_burst            (mst7_arburst          ),
	.mst7_lock             (mst7_arlock           ),
	.mst7_cache            (mst7_arcache          ),
	.mst7_prot             (mst7_arprot           ),
	.mst7_aid              (mst7_arid             ),
	.mst7_avalid           (mst7_arvalid          ),
	.mst7_connect          (mst7_connect          ),
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	.mst8_addr             (mst8_araddr           ),
	.mst8_len              (mst8_arlen            ),
	.mst8_size             (mst8_arsize           ),
	.mst8_burst            (mst8_arburst          ),
	.mst8_lock             (mst8_arlock           ),
	.mst8_cache            (mst8_arcache          ),
	.mst8_prot             (mst8_arprot           ),
	.mst8_aid              (mst8_arid             ),
	.mst8_avalid           (mst8_arvalid          ),
	.mst8_connect          (mst8_connect          ),
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	.mst9_addr             (mst9_araddr           ),
	.mst9_len              (mst9_arlen            ),
	.mst9_size             (mst9_arsize           ),
	.mst9_burst            (mst9_arburst          ),
	.mst9_lock             (mst9_arlock           ),
	.mst9_cache            (mst9_arcache          ),
	.mst9_prot             (mst9_arprot           ),
	.mst9_aid              (mst9_arid             ),
	.mst9_avalid           (mst9_arvalid          ),
	.mst9_connect          (mst9_connect          ),
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	.mst10_addr            (mst10_araddr          ),
	.mst10_len             (mst10_arlen           ),
	.mst10_size            (mst10_arsize          ),
	.mst10_burst           (mst10_arburst         ),
	.mst10_lock            (mst10_arlock          ),
	.mst10_cache           (mst10_arcache         ),
	.mst10_prot            (mst10_arprot          ),
	.mst10_aid             (mst10_arid            ),
	.mst10_avalid          (mst10_arvalid         ),
	.mst10_connect         (mst10_connect         ),
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	.mst11_addr            (mst11_araddr          ),
	.mst11_len             (mst11_arlen           ),
	.mst11_size            (mst11_arsize          ),
	.mst11_burst           (mst11_arburst         ),
	.mst11_lock            (mst11_arlock          ),
	.mst11_cache           (mst11_arcache         ),
	.mst11_prot            (mst11_arprot          ),
	.mst11_aid             (mst11_arid            ),
	.mst11_avalid          (mst11_arvalid         ),
	.mst11_connect         (mst11_connect         ),
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	.mst12_addr            (mst12_araddr          ),
	.mst12_len             (mst12_arlen           ),
	.mst12_size            (mst12_arsize          ),
	.mst12_burst           (mst12_arburst         ),
	.mst12_lock            (mst12_arlock          ),
	.mst12_cache           (mst12_arcache         ),
	.mst12_prot            (mst12_arprot          ),
	.mst12_aid             (mst12_arid            ),
	.mst12_avalid          (mst12_arvalid         ),
	.mst12_connect         (mst12_connect         ),
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	.mst13_addr            (mst13_araddr          ),
	.mst13_len             (mst13_arlen           ),
	.mst13_size            (mst13_arsize          ),
	.mst13_burst           (mst13_arburst         ),
	.mst13_lock            (mst13_arlock          ),
	.mst13_cache           (mst13_arcache         ),
	.mst13_prot            (mst13_arprot          ),
	.mst13_aid             (mst13_arid            ),
	.mst13_avalid          (mst13_arvalid         ),
	.mst13_connect         (mst13_connect         ),
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	.mst14_addr            (mst14_araddr          ),
	.mst14_len             (mst14_arlen           ),
	.mst14_size            (mst14_arsize          ),
	.mst14_burst           (mst14_arburst         ),
	.mst14_lock            (mst14_arlock          ),
	.mst14_cache           (mst14_arcache         ),
	.mst14_prot            (mst14_arprot          ),
	.mst14_aid             (mst14_arid            ),
	.mst14_avalid          (mst14_arvalid         ),
	.mst14_connect         (mst14_connect         ),
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	.mst15_addr            (mst15_araddr          ),
	.mst15_len             (mst15_arlen           ),
	.mst15_size            (mst15_arsize          ),
	.mst15_burst           (mst15_arburst         ),
	.mst15_lock            (mst15_arlock          ),
	.mst15_cache           (mst15_arcache         ),
	.mst15_prot            (mst15_arprot          ),
	.mst15_aid             (mst15_arid            ),
	.mst15_avalid          (mst15_arvalid         ),
	.mst15_connect         (mst15_connect         ),
`endif
	.addr_outstanding_en   (s0),
	.slv_aready            (slv_arready           ),
	.arb_mid               (slv_ar_mid            ),
	.outstanding_ready     (s2  ),
	.addr                  (ds_araddr             ),
	.len                   (ds_arlen              ),
	.size                  (ds_arsize             ),
	.burst                 (ds_arburst            ),
	.lock                  (ds_arlock             ),
	.cache                 (ds_arcache            ),
	.prot                  (ds_arprot             ),
	.aid                   (ds_arid               ),
	.avalid                (ds_arvalid            ),
	.aready                (ds_arready            ),
	.reg_mst0_high_priority(reg_mst0_high_priority),
	.reg_priority_reload   (reg_priority_reload   ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               )
);

atcbmc300_ds_rdata_ctrl #(
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTANDING_DEPTH(SLAVE_FIFO_DEPTH)
) ds_rd_data (
	.self_id            (self_id               ),
`ifdef ATCBMC300_MST0_SUPPORT
	.mst0_rready        (mst0_rready           ),
	.mst0_rsid          (mst0_rsid             ),
	.mst0_connect       (mst0_connect          ),
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	.mst1_rready        (mst1_rready           ),
	.mst1_rsid          (mst1_rsid             ),
	.mst1_connect       (mst1_connect          ),
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	.mst2_rready        (mst2_rready           ),
	.mst2_rsid          (mst2_rsid             ),
	.mst2_connect       (mst2_connect          ),
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	.mst3_rready        (mst3_rready           ),
	.mst3_rsid          (mst3_rsid             ),
	.mst3_connect       (mst3_connect          ),
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	.mst4_rready        (mst4_rready           ),
	.mst4_rsid          (mst4_rsid             ),
	.mst4_connect       (mst4_connect          ),
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	.mst5_rready        (mst5_rready           ),
	.mst5_rsid          (mst5_rsid             ),
	.mst5_connect       (mst5_connect          ),
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	.mst6_rready        (mst6_rready           ),
	.mst6_rsid          (mst6_rsid             ),
	.mst6_connect       (mst6_connect          ),
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	.mst7_rready        (mst7_rready           ),
	.mst7_rsid          (mst7_rsid             ),
	.mst7_connect       (mst7_connect          ),
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	.mst8_rready        (mst8_rready           ),
	.mst8_rsid          (mst8_rsid             ),
	.mst8_connect       (mst8_connect          ),
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	.mst9_rready        (mst9_rready           ),
	.mst9_rsid          (mst9_rsid             ),
	.mst9_connect       (mst9_connect          ),
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	.mst10_rready       (mst10_rready          ),
	.mst10_rsid         (mst10_rsid            ),
	.mst10_connect      (mst10_connect         ),
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	.mst11_rready       (mst11_rready          ),
	.mst11_rsid         (mst11_rsid            ),
	.mst11_connect      (mst11_connect         ),
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	.mst12_rready       (mst12_rready          ),
	.mst12_rsid         (mst12_rsid            ),
	.mst12_connect      (mst12_connect         ),
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	.mst13_rready       (mst13_rready          ),
	.mst13_rsid         (mst13_rsid            ),
	.mst13_connect      (mst13_connect         ),
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	.mst14_rready       (mst14_rready          ),
	.mst14_rsid         (mst14_rsid            ),
	.mst14_connect      (mst14_connect         ),
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	.mst15_rready       (mst15_rready          ),
	.mst15_rsid         (mst15_rsid            ),
	.mst15_connect      (mst15_connect         ),
`endif
	.ds_rdata           (ds_rdata              ),
	.ds_rresp           (ds_rresp              ),
	.ds_rid             (ds_rid                ),
	.ds_rlast           (ds_rlast              ),
	.ds_rvalid          (ds_rvalid             ),
	.ds_rready          (ds_rready             ),
	.slv_rvalid         (slv_rvalid            ),
	.slv_read_data      (slv_read_data         ),
	.slv_rid            (slv_rid               ),
	.outstanding_ready  (s2  ),
	.addr_outstanding_en(s0),
	.aclk               (aclk                  ),
	.aresetn            (aresetn               )
);

endmodule

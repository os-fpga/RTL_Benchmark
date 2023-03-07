// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"


module atcbmc300_us_axi (
`ifdef ATCBMC300_SLV0_SUPPORT
	  slv0_ar_mid,
	  slv0_arready,
	  slv0_arvalid,
	  slv0_addr_mask,
	  slv0_masked_base_addr,
	  slv0_connect,
	  slv0_aw_mid,
	  slv0_awready,
	  slv0_awvalid,
	  slv0_read_data,
	  slv0_rid,
	  slv0_rvalid,
	  slv0_wmid,
	  slv0_wready,
	  slv0_bid,
	  slv0_bresp,
	  slv0_bvalid,
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
	  slv1_ar_mid,
	  slv1_arready,
	  slv1_arvalid,
	  slv1_addr_mask,
	  slv1_masked_base_addr,
	  slv1_connect,
	  slv1_aw_mid,
	  slv1_awready,
	  slv1_awvalid,
	  slv1_read_data,
	  slv1_rid,
	  slv1_rvalid,
	  slv1_wmid,
	  slv1_wready,
	  slv1_bid,
	  slv1_bresp,
	  slv1_bvalid,
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
	  slv2_ar_mid,
	  slv2_arready,
	  slv2_arvalid,
	  slv2_addr_mask,
	  slv2_masked_base_addr,
	  slv2_connect,
	  slv2_aw_mid,
	  slv2_awready,
	  slv2_awvalid,
	  slv2_read_data,
	  slv2_rid,
	  slv2_rvalid,
	  slv2_wmid,
	  slv2_wready,
	  slv2_bid,
	  slv2_bresp,
	  slv2_bvalid,
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
	  slv3_ar_mid,
	  slv3_arready,
	  slv3_arvalid,
	  slv3_addr_mask,
	  slv3_masked_base_addr,
	  slv3_connect,
	  slv3_aw_mid,
	  slv3_awready,
	  slv3_awvalid,
	  slv3_read_data,
	  slv3_rid,
	  slv3_rvalid,
	  slv3_wmid,
	  slv3_wready,
	  slv3_bid,
	  slv3_bresp,
	  slv3_bvalid,
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
	  slv4_ar_mid,
	  slv4_arready,
	  slv4_arvalid,
	  slv4_addr_mask,
	  slv4_masked_base_addr,
	  slv4_connect,
	  slv4_aw_mid,
	  slv4_awready,
	  slv4_awvalid,
	  slv4_read_data,
	  slv4_rid,
	  slv4_rvalid,
	  slv4_wmid,
	  slv4_wready,
	  slv4_bid,
	  slv4_bresp,
	  slv4_bvalid,
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
	  slv5_ar_mid,
	  slv5_arready,
	  slv5_arvalid,
	  slv5_addr_mask,
	  slv5_masked_base_addr,
	  slv5_connect,
	  slv5_aw_mid,
	  slv5_awready,
	  slv5_awvalid,
	  slv5_read_data,
	  slv5_rid,
	  slv5_rvalid,
	  slv5_wmid,
	  slv5_wready,
	  slv5_bid,
	  slv5_bresp,
	  slv5_bvalid,
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
	  slv6_ar_mid,
	  slv6_arready,
	  slv6_arvalid,
	  slv6_addr_mask,
	  slv6_masked_base_addr,
	  slv6_connect,
	  slv6_aw_mid,
	  slv6_awready,
	  slv6_awvalid,
	  slv6_read_data,
	  slv6_rid,
	  slv6_rvalid,
	  slv6_wmid,
	  slv6_wready,
	  slv6_bid,
	  slv6_bresp,
	  slv6_bvalid,
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
	  slv7_ar_mid,
	  slv7_arready,
	  slv7_arvalid,
	  slv7_addr_mask,
	  slv7_masked_base_addr,
	  slv7_connect,
	  slv7_aw_mid,
	  slv7_awready,
	  slv7_awvalid,
	  slv7_read_data,
	  slv7_rid,
	  slv7_rvalid,
	  slv7_wmid,
	  slv7_wready,
	  slv7_bid,
	  slv7_bresp,
	  slv7_bvalid,
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
	  slv8_ar_mid,
	  slv8_arready,
	  slv8_arvalid,
	  slv8_addr_mask,
	  slv8_masked_base_addr,
	  slv8_connect,
	  slv8_aw_mid,
	  slv8_awready,
	  slv8_awvalid,
	  slv8_read_data,
	  slv8_rid,
	  slv8_rvalid,
	  slv8_wmid,
	  slv8_wready,
	  slv8_bid,
	  slv8_bresp,
	  slv8_bvalid,
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
	  slv9_ar_mid,
	  slv9_arready,
	  slv9_arvalid,
	  slv9_addr_mask,
	  slv9_masked_base_addr,
	  slv9_connect,
	  slv9_aw_mid,
	  slv9_awready,
	  slv9_awvalid,
	  slv9_read_data,
	  slv9_rid,
	  slv9_rvalid,
	  slv9_wmid,
	  slv9_wready,
	  slv9_bid,
	  slv9_bresp,
	  slv9_bvalid,
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
	  slv10_ar_mid,
	  slv10_arready,
	  slv10_arvalid,
	  slv10_addr_mask,
	  slv10_masked_base_addr,
	  slv10_connect,
	  slv10_aw_mid,
	  slv10_awready,
	  slv10_awvalid,
	  slv10_read_data,
	  slv10_rid,
	  slv10_rvalid,
	  slv10_wmid,
	  slv10_wready,
	  slv10_bid,
	  slv10_bresp,
	  slv10_bvalid,
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
	  slv11_ar_mid,
	  slv11_arready,
	  slv11_arvalid,
	  slv11_addr_mask,
	  slv11_masked_base_addr,
	  slv11_connect,
	  slv11_aw_mid,
	  slv11_awready,
	  slv11_awvalid,
	  slv11_read_data,
	  slv11_rid,
	  slv11_rvalid,
	  slv11_wmid,
	  slv11_wready,
	  slv11_bid,
	  slv11_bresp,
	  slv11_bvalid,
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
	  slv12_ar_mid,
	  slv12_arready,
	  slv12_arvalid,
	  slv12_addr_mask,
	  slv12_masked_base_addr,
	  slv12_connect,
	  slv12_aw_mid,
	  slv12_awready,
	  slv12_awvalid,
	  slv12_read_data,
	  slv12_rid,
	  slv12_rvalid,
	  slv12_wmid,
	  slv12_wready,
	  slv12_bid,
	  slv12_bresp,
	  slv12_bvalid,
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
	  slv13_ar_mid,
	  slv13_arready,
	  slv13_arvalid,
	  slv13_addr_mask,
	  slv13_masked_base_addr,
	  slv13_connect,
	  slv13_aw_mid,
	  slv13_awready,
	  slv13_awvalid,
	  slv13_read_data,
	  slv13_rid,
	  slv13_rvalid,
	  slv13_wmid,
	  slv13_wready,
	  slv13_bid,
	  slv13_bresp,
	  slv13_bvalid,
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
	  slv14_ar_mid,
	  slv14_arready,
	  slv14_arvalid,
	  slv14_addr_mask,
	  slv14_masked_base_addr,
	  slv14_connect,
	  slv14_aw_mid,
	  slv14_awready,
	  slv14_awvalid,
	  slv14_read_data,
	  slv14_rid,
	  slv14_rvalid,
	  slv14_wmid,
	  slv14_wready,
	  slv14_bid,
	  slv14_bresp,
	  slv14_bvalid,
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
	  slv15_ar_mid,
	  slv15_arready,
	  slv15_arvalid,
	  slv15_addr_mask,
	  slv15_masked_base_addr,
	  slv15_connect,
	  slv15_aw_mid,
	  slv15_awready,
	  slv15_awvalid,
	  slv15_read_data,
	  slv15_rid,
	  slv15_rvalid,
	  slv15_wmid,
	  slv15_wready,
	  slv15_bid,
	  slv15_bresp,
	  slv15_bvalid,
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
	  slv16_ar_mid,
	  slv16_arready,
	  slv16_arvalid,
	  slv16_addr_mask,
	  slv16_masked_base_addr,
	  slv16_connect,
	  slv16_aw_mid,
	  slv16_awready,
	  slv16_awvalid,
	  slv16_read_data,
	  slv16_rid,
	  slv16_rvalid,
	  slv16_wmid,
	  slv16_wready,
	  slv16_bid,
	  slv16_bresp,
	  slv16_bvalid,
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
	  slv17_ar_mid,
	  slv17_arready,
	  slv17_arvalid,
	  slv17_addr_mask,
	  slv17_masked_base_addr,
	  slv17_connect,
	  slv17_aw_mid,
	  slv17_awready,
	  slv17_awvalid,
	  slv17_read_data,
	  slv17_rid,
	  slv17_rvalid,
	  slv17_wmid,
	  slv17_wready,
	  slv17_bid,
	  slv17_bresp,
	  slv17_bvalid,
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
	  slv18_ar_mid,
	  slv18_arready,
	  slv18_arvalid,
	  slv18_addr_mask,
	  slv18_masked_base_addr,
	  slv18_connect,
	  slv18_aw_mid,
	  slv18_awready,
	  slv18_awvalid,
	  slv18_read_data,
	  slv18_rid,
	  slv18_rvalid,
	  slv18_wmid,
	  slv18_wready,
	  slv18_bid,
	  slv18_bresp,
	  slv18_bvalid,
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
	  slv19_ar_mid,
	  slv19_arready,
	  slv19_arvalid,
	  slv19_addr_mask,
	  slv19_masked_base_addr,
	  slv19_connect,
	  slv19_aw_mid,
	  slv19_awready,
	  slv19_awvalid,
	  slv19_read_data,
	  slv19_rid,
	  slv19_rvalid,
	  slv19_wmid,
	  slv19_wready,
	  slv19_bid,
	  slv19_bresp,
	  slv19_bvalid,
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
	  slv20_ar_mid,
	  slv20_arready,
	  slv20_arvalid,
	  slv20_addr_mask,
	  slv20_masked_base_addr,
	  slv20_connect,
	  slv20_aw_mid,
	  slv20_awready,
	  slv20_awvalid,
	  slv20_read_data,
	  slv20_rid,
	  slv20_rvalid,
	  slv20_wmid,
	  slv20_wready,
	  slv20_bid,
	  slv20_bresp,
	  slv20_bvalid,
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
	  slv21_ar_mid,
	  slv21_arready,
	  slv21_arvalid,
	  slv21_addr_mask,
	  slv21_masked_base_addr,
	  slv21_connect,
	  slv21_aw_mid,
	  slv21_awready,
	  slv21_awvalid,
	  slv21_read_data,
	  slv21_rid,
	  slv21_rvalid,
	  slv21_wmid,
	  slv21_wready,
	  slv21_bid,
	  slv21_bresp,
	  slv21_bvalid,
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
	  slv22_ar_mid,
	  slv22_arready,
	  slv22_arvalid,
	  slv22_addr_mask,
	  slv22_masked_base_addr,
	  slv22_connect,
	  slv22_aw_mid,
	  slv22_awready,
	  slv22_awvalid,
	  slv22_read_data,
	  slv22_rid,
	  slv22_rvalid,
	  slv22_wmid,
	  slv22_wready,
	  slv22_bid,
	  slv22_bresp,
	  slv22_bvalid,
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
	  slv23_ar_mid,
	  slv23_arready,
	  slv23_arvalid,
	  slv23_addr_mask,
	  slv23_masked_base_addr,
	  slv23_connect,
	  slv23_aw_mid,
	  slv23_awready,
	  slv23_awvalid,
	  slv23_read_data,
	  slv23_rid,
	  slv23_rvalid,
	  slv23_wmid,
	  slv23_wready,
	  slv23_bid,
	  slv23_bresp,
	  slv23_bvalid,
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
	  slv24_ar_mid,
	  slv24_arready,
	  slv24_arvalid,
	  slv24_addr_mask,
	  slv24_masked_base_addr,
	  slv24_connect,
	  slv24_aw_mid,
	  slv24_awready,
	  slv24_awvalid,
	  slv24_read_data,
	  slv24_rid,
	  slv24_rvalid,
	  slv24_wmid,
	  slv24_wready,
	  slv24_bid,
	  slv24_bresp,
	  slv24_bvalid,
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
	  slv25_ar_mid,
	  slv25_arready,
	  slv25_arvalid,
	  slv25_addr_mask,
	  slv25_masked_base_addr,
	  slv25_connect,
	  slv25_aw_mid,
	  slv25_awready,
	  slv25_awvalid,
	  slv25_read_data,
	  slv25_rid,
	  slv25_rvalid,
	  slv25_wmid,
	  slv25_wready,
	  slv25_bid,
	  slv25_bresp,
	  slv25_bvalid,
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
	  slv26_ar_mid,
	  slv26_arready,
	  slv26_arvalid,
	  slv26_addr_mask,
	  slv26_masked_base_addr,
	  slv26_connect,
	  slv26_aw_mid,
	  slv26_awready,
	  slv26_awvalid,
	  slv26_read_data,
	  slv26_rid,
	  slv26_rvalid,
	  slv26_wmid,
	  slv26_wready,
	  slv26_bid,
	  slv26_bresp,
	  slv26_bvalid,
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
	  slv27_ar_mid,
	  slv27_arready,
	  slv27_arvalid,
	  slv27_addr_mask,
	  slv27_masked_base_addr,
	  slv27_connect,
	  slv27_aw_mid,
	  slv27_awready,
	  slv27_awvalid,
	  slv27_read_data,
	  slv27_rid,
	  slv27_rvalid,
	  slv27_wmid,
	  slv27_wready,
	  slv27_bid,
	  slv27_bresp,
	  slv27_bvalid,
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
	  slv28_ar_mid,
	  slv28_arready,
	  slv28_arvalid,
	  slv28_addr_mask,
	  slv28_masked_base_addr,
	  slv28_connect,
	  slv28_aw_mid,
	  slv28_awready,
	  slv28_awvalid,
	  slv28_read_data,
	  slv28_rid,
	  slv28_rvalid,
	  slv28_wmid,
	  slv28_wready,
	  slv28_bid,
	  slv28_bresp,
	  slv28_bvalid,
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
	  slv29_ar_mid,
	  slv29_arready,
	  slv29_arvalid,
	  slv29_addr_mask,
	  slv29_masked_base_addr,
	  slv29_connect,
	  slv29_aw_mid,
	  slv29_awready,
	  slv29_awvalid,
	  slv29_read_data,
	  slv29_rid,
	  slv29_rvalid,
	  slv29_wmid,
	  slv29_wready,
	  slv29_bid,
	  slv29_bresp,
	  slv29_bvalid,
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
	  slv30_ar_mid,
	  slv30_arready,
	  slv30_arvalid,
	  slv30_addr_mask,
	  slv30_masked_base_addr,
	  slv30_connect,
	  slv30_aw_mid,
	  slv30_awready,
	  slv30_awvalid,
	  slv30_read_data,
	  slv30_rid,
	  slv30_rvalid,
	  slv30_wmid,
	  slv30_wready,
	  slv30_bid,
	  slv30_bresp,
	  slv30_bvalid,
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
	  slv31_ar_mid,
	  slv31_arready,
	  slv31_arvalid,
	  slv31_addr_mask,
	  slv31_masked_base_addr,
	  slv31_connect,
	  slv31_aw_mid,
	  slv31_awready,
	  slv31_awvalid,
	  slv31_read_data,
	  slv31_rid,
	  slv31_rvalid,
	  slv31_wmid,
	  slv31_wready,
	  slv31_bid,
	  slv31_bresp,
	  slv31_bvalid,
`endif
	  us_rdata,
	  us_rlast,
	  us_rresp,
	  mst_araddr,
	  mst_arburst,
	  mst_arcache,
	  mst_arid,
	  mst_arlen,
	  mst_arlock,
	  mst_arprot,
	  mst_arsize,
	  us_araddr,
	  us_arburst,
	  us_arcache,
	  us_arid,
	  us_arlen,
	  us_arlock,
	  us_arprot,
	  us_arready,
	  us_arsize,
	  us_arvalid,
	  aclk,
	  aresetn,
	  self_id,
	  us_rready,
	  mst_awaddr,
	  mst_awburst,
	  mst_awcache,
	  mst_awid,
	  mst_awlen,
	  mst_awlock,
	  mst_awprot,
	  mst_awsize,
	  us_awaddr,
	  us_awburst,
	  us_awcache,
	  us_awid,
	  us_awlen,
	  us_awlock,
	  us_awprot,
	  us_awready,
	  us_awsize,
	  us_awvalid,
	  us_bready,
	  mst_rready,
	  mst_rsid,
	  us_rid,
	  us_rvalid,
	  mst_wdata,
	  mst_wlast,
	  mst_wsid,
	  mst_wstrb,
	  mst_wvalid,
	  us_wdata,
	  us_wlast,
	  us_wready,
	  us_wstrb,
	  us_wvalid,
	  mst_bready,
	  mst_bsid,
	  us_bid,
	  us_bresp,
	  us_bvalid
);

parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 64;
parameter ID_WIDTH = 4;
parameter OUTSTANDING_DEPTH = 4;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam ID_MSB = ID_WIDTH - 1;

`ifdef ATCBMC300_SLV0_SUPPORT
input                      [3:0] slv0_ar_mid;
input                            slv0_arready;
output                           slv0_arvalid;
input                     [64:0] slv0_addr_mask;
input                     [64:0] slv0_masked_base_addr;
input                            slv0_connect;
input                      [3:0] slv0_aw_mid;
input                            slv0_awready;
output                           slv0_awvalid;
input           [(DATA_MSB+3):0] slv0_read_data;
input               [ID_MSB+4:0] slv0_rid;
input                            slv0_rvalid;
input                      [3:0] slv0_wmid;
input                            slv0_wready;
input               [ID_MSB+4:0] slv0_bid;
input                      [1:0] slv0_bresp;
input                            slv0_bvalid;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
input                      [3:0] slv1_ar_mid;
input                            slv1_arready;
output                           slv1_arvalid;
input                     [64:0] slv1_addr_mask;
input                     [64:0] slv1_masked_base_addr;
input                            slv1_connect;
input                      [3:0] slv1_aw_mid;
input                            slv1_awready;
output                           slv1_awvalid;
input           [(DATA_MSB+3):0] slv1_read_data;
input               [ID_MSB+4:0] slv1_rid;
input                            slv1_rvalid;
input                      [3:0] slv1_wmid;
input                            slv1_wready;
input               [ID_MSB+4:0] slv1_bid;
input                      [1:0] slv1_bresp;
input                            slv1_bvalid;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
input                      [3:0] slv2_ar_mid;
input                            slv2_arready;
output                           slv2_arvalid;
input                     [64:0] slv2_addr_mask;
input                     [64:0] slv2_masked_base_addr;
input                            slv2_connect;
input                      [3:0] slv2_aw_mid;
input                            slv2_awready;
output                           slv2_awvalid;
input           [(DATA_MSB+3):0] slv2_read_data;
input               [ID_MSB+4:0] slv2_rid;
input                            slv2_rvalid;
input                      [3:0] slv2_wmid;
input                            slv2_wready;
input               [ID_MSB+4:0] slv2_bid;
input                      [1:0] slv2_bresp;
input                            slv2_bvalid;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
input                      [3:0] slv3_ar_mid;
input                            slv3_arready;
output                           slv3_arvalid;
input                     [64:0] slv3_addr_mask;
input                     [64:0] slv3_masked_base_addr;
input                            slv3_connect;
input                      [3:0] slv3_aw_mid;
input                            slv3_awready;
output                           slv3_awvalid;
input           [(DATA_MSB+3):0] slv3_read_data;
input               [ID_MSB+4:0] slv3_rid;
input                            slv3_rvalid;
input                      [3:0] slv3_wmid;
input                            slv3_wready;
input               [ID_MSB+4:0] slv3_bid;
input                      [1:0] slv3_bresp;
input                            slv3_bvalid;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
input                      [3:0] slv4_ar_mid;
input                            slv4_arready;
output                           slv4_arvalid;
input                     [64:0] slv4_addr_mask;
input                     [64:0] slv4_masked_base_addr;
input                            slv4_connect;
input                      [3:0] slv4_aw_mid;
input                            slv4_awready;
output                           slv4_awvalid;
input           [(DATA_MSB+3):0] slv4_read_data;
input               [ID_MSB+4:0] slv4_rid;
input                            slv4_rvalid;
input                      [3:0] slv4_wmid;
input                            slv4_wready;
input               [ID_MSB+4:0] slv4_bid;
input                      [1:0] slv4_bresp;
input                            slv4_bvalid;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
input                      [3:0] slv5_ar_mid;
input                            slv5_arready;
output                           slv5_arvalid;
input                     [64:0] slv5_addr_mask;
input                     [64:0] slv5_masked_base_addr;
input                            slv5_connect;
input                      [3:0] slv5_aw_mid;
input                            slv5_awready;
output                           slv5_awvalid;
input           [(DATA_MSB+3):0] slv5_read_data;
input               [ID_MSB+4:0] slv5_rid;
input                            slv5_rvalid;
input                      [3:0] slv5_wmid;
input                            slv5_wready;
input               [ID_MSB+4:0] slv5_bid;
input                      [1:0] slv5_bresp;
input                            slv5_bvalid;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
input                      [3:0] slv6_ar_mid;
input                            slv6_arready;
output                           slv6_arvalid;
input                     [64:0] slv6_addr_mask;
input                     [64:0] slv6_masked_base_addr;
input                            slv6_connect;
input                      [3:0] slv6_aw_mid;
input                            slv6_awready;
output                           slv6_awvalid;
input           [(DATA_MSB+3):0] slv6_read_data;
input               [ID_MSB+4:0] slv6_rid;
input                            slv6_rvalid;
input                      [3:0] slv6_wmid;
input                            slv6_wready;
input               [ID_MSB+4:0] slv6_bid;
input                      [1:0] slv6_bresp;
input                            slv6_bvalid;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
input                      [3:0] slv7_ar_mid;
input                            slv7_arready;
output                           slv7_arvalid;
input                     [64:0] slv7_addr_mask;
input                     [64:0] slv7_masked_base_addr;
input                            slv7_connect;
input                      [3:0] slv7_aw_mid;
input                            slv7_awready;
output                           slv7_awvalid;
input           [(DATA_MSB+3):0] slv7_read_data;
input               [ID_MSB+4:0] slv7_rid;
input                            slv7_rvalid;
input                      [3:0] slv7_wmid;
input                            slv7_wready;
input               [ID_MSB+4:0] slv7_bid;
input                      [1:0] slv7_bresp;
input                            slv7_bvalid;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
input                      [3:0] slv8_ar_mid;
input                            slv8_arready;
output                           slv8_arvalid;
input                     [64:0] slv8_addr_mask;
input                     [64:0] slv8_masked_base_addr;
input                            slv8_connect;
input                      [3:0] slv8_aw_mid;
input                            slv8_awready;
output                           slv8_awvalid;
input           [(DATA_MSB+3):0] slv8_read_data;
input               [ID_MSB+4:0] slv8_rid;
input                            slv8_rvalid;
input                      [3:0] slv8_wmid;
input                            slv8_wready;
input               [ID_MSB+4:0] slv8_bid;
input                      [1:0] slv8_bresp;
input                            slv8_bvalid;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
input                      [3:0] slv9_ar_mid;
input                            slv9_arready;
output                           slv9_arvalid;
input                     [64:0] slv9_addr_mask;
input                     [64:0] slv9_masked_base_addr;
input                            slv9_connect;
input                      [3:0] slv9_aw_mid;
input                            slv9_awready;
output                           slv9_awvalid;
input           [(DATA_MSB+3):0] slv9_read_data;
input               [ID_MSB+4:0] slv9_rid;
input                            slv9_rvalid;
input                      [3:0] slv9_wmid;
input                            slv9_wready;
input               [ID_MSB+4:0] slv9_bid;
input                      [1:0] slv9_bresp;
input                            slv9_bvalid;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
input                      [3:0] slv10_ar_mid;
input                            slv10_arready;
output                           slv10_arvalid;
input                     [64:0] slv10_addr_mask;
input                     [64:0] slv10_masked_base_addr;
input                            slv10_connect;
input                      [3:0] slv10_aw_mid;
input                            slv10_awready;
output                           slv10_awvalid;
input           [(DATA_MSB+3):0] slv10_read_data;
input               [ID_MSB+4:0] slv10_rid;
input                            slv10_rvalid;
input                      [3:0] slv10_wmid;
input                            slv10_wready;
input               [ID_MSB+4:0] slv10_bid;
input                      [1:0] slv10_bresp;
input                            slv10_bvalid;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
input                      [3:0] slv11_ar_mid;
input                            slv11_arready;
output                           slv11_arvalid;
input                     [64:0] slv11_addr_mask;
input                     [64:0] slv11_masked_base_addr;
input                            slv11_connect;
input                      [3:0] slv11_aw_mid;
input                            slv11_awready;
output                           slv11_awvalid;
input           [(DATA_MSB+3):0] slv11_read_data;
input               [ID_MSB+4:0] slv11_rid;
input                            slv11_rvalid;
input                      [3:0] slv11_wmid;
input                            slv11_wready;
input               [ID_MSB+4:0] slv11_bid;
input                      [1:0] slv11_bresp;
input                            slv11_bvalid;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
input                      [3:0] slv12_ar_mid;
input                            slv12_arready;
output                           slv12_arvalid;
input                     [64:0] slv12_addr_mask;
input                     [64:0] slv12_masked_base_addr;
input                            slv12_connect;
input                      [3:0] slv12_aw_mid;
input                            slv12_awready;
output                           slv12_awvalid;
input           [(DATA_MSB+3):0] slv12_read_data;
input               [ID_MSB+4:0] slv12_rid;
input                            slv12_rvalid;
input                      [3:0] slv12_wmid;
input                            slv12_wready;
input               [ID_MSB+4:0] slv12_bid;
input                      [1:0] slv12_bresp;
input                            slv12_bvalid;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
input                      [3:0] slv13_ar_mid;
input                            slv13_arready;
output                           slv13_arvalid;
input                     [64:0] slv13_addr_mask;
input                     [64:0] slv13_masked_base_addr;
input                            slv13_connect;
input                      [3:0] slv13_aw_mid;
input                            slv13_awready;
output                           slv13_awvalid;
input           [(DATA_MSB+3):0] slv13_read_data;
input               [ID_MSB+4:0] slv13_rid;
input                            slv13_rvalid;
input                      [3:0] slv13_wmid;
input                            slv13_wready;
input               [ID_MSB+4:0] slv13_bid;
input                      [1:0] slv13_bresp;
input                            slv13_bvalid;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
input                      [3:0] slv14_ar_mid;
input                            slv14_arready;
output                           slv14_arvalid;
input                     [64:0] slv14_addr_mask;
input                     [64:0] slv14_masked_base_addr;
input                            slv14_connect;
input                      [3:0] slv14_aw_mid;
input                            slv14_awready;
output                           slv14_awvalid;
input           [(DATA_MSB+3):0] slv14_read_data;
input               [ID_MSB+4:0] slv14_rid;
input                            slv14_rvalid;
input                      [3:0] slv14_wmid;
input                            slv14_wready;
input               [ID_MSB+4:0] slv14_bid;
input                      [1:0] slv14_bresp;
input                            slv14_bvalid;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
input                      [3:0] slv15_ar_mid;
input                            slv15_arready;
output                           slv15_arvalid;
input                     [64:0] slv15_addr_mask;
input                     [64:0] slv15_masked_base_addr;
input                            slv15_connect;
input                      [3:0] slv15_aw_mid;
input                            slv15_awready;
output                           slv15_awvalid;
input           [(DATA_MSB+3):0] slv15_read_data;
input               [ID_MSB+4:0] slv15_rid;
input                            slv15_rvalid;
input                      [3:0] slv15_wmid;
input                            slv15_wready;
input               [ID_MSB+4:0] slv15_bid;
input                      [1:0] slv15_bresp;
input                            slv15_bvalid;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
input                      [3:0] slv16_ar_mid;
input                            slv16_arready;
output                           slv16_arvalid;
input                     [64:0] slv16_addr_mask;
input                     [64:0] slv16_masked_base_addr;
input                            slv16_connect;
input                      [3:0] slv16_aw_mid;
input                            slv16_awready;
output                           slv16_awvalid;
input           [(DATA_MSB+3):0] slv16_read_data;
input               [ID_MSB+4:0] slv16_rid;
input                            slv16_rvalid;
input                      [3:0] slv16_wmid;
input                            slv16_wready;
input               [ID_MSB+4:0] slv16_bid;
input                      [1:0] slv16_bresp;
input                            slv16_bvalid;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
input                      [3:0] slv17_ar_mid;
input                            slv17_arready;
output                           slv17_arvalid;
input                     [64:0] slv17_addr_mask;
input                     [64:0] slv17_masked_base_addr;
input                            slv17_connect;
input                      [3:0] slv17_aw_mid;
input                            slv17_awready;
output                           slv17_awvalid;
input           [(DATA_MSB+3):0] slv17_read_data;
input               [ID_MSB+4:0] slv17_rid;
input                            slv17_rvalid;
input                      [3:0] slv17_wmid;
input                            slv17_wready;
input               [ID_MSB+4:0] slv17_bid;
input                      [1:0] slv17_bresp;
input                            slv17_bvalid;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
input                      [3:0] slv18_ar_mid;
input                            slv18_arready;
output                           slv18_arvalid;
input                     [64:0] slv18_addr_mask;
input                     [64:0] slv18_masked_base_addr;
input                            slv18_connect;
input                      [3:0] slv18_aw_mid;
input                            slv18_awready;
output                           slv18_awvalid;
input           [(DATA_MSB+3):0] slv18_read_data;
input               [ID_MSB+4:0] slv18_rid;
input                            slv18_rvalid;
input                      [3:0] slv18_wmid;
input                            slv18_wready;
input               [ID_MSB+4:0] slv18_bid;
input                      [1:0] slv18_bresp;
input                            slv18_bvalid;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
input                      [3:0] slv19_ar_mid;
input                            slv19_arready;
output                           slv19_arvalid;
input                     [64:0] slv19_addr_mask;
input                     [64:0] slv19_masked_base_addr;
input                            slv19_connect;
input                      [3:0] slv19_aw_mid;
input                            slv19_awready;
output                           slv19_awvalid;
input           [(DATA_MSB+3):0] slv19_read_data;
input               [ID_MSB+4:0] slv19_rid;
input                            slv19_rvalid;
input                      [3:0] slv19_wmid;
input                            slv19_wready;
input               [ID_MSB+4:0] slv19_bid;
input                      [1:0] slv19_bresp;
input                            slv19_bvalid;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
input                      [3:0] slv20_ar_mid;
input                            slv20_arready;
output                           slv20_arvalid;
input                     [64:0] slv20_addr_mask;
input                     [64:0] slv20_masked_base_addr;
input                            slv20_connect;
input                      [3:0] slv20_aw_mid;
input                            slv20_awready;
output                           slv20_awvalid;
input           [(DATA_MSB+3):0] slv20_read_data;
input               [ID_MSB+4:0] slv20_rid;
input                            slv20_rvalid;
input                      [3:0] slv20_wmid;
input                            slv20_wready;
input               [ID_MSB+4:0] slv20_bid;
input                      [1:0] slv20_bresp;
input                            slv20_bvalid;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
input                      [3:0] slv21_ar_mid;
input                            slv21_arready;
output                           slv21_arvalid;
input                     [64:0] slv21_addr_mask;
input                     [64:0] slv21_masked_base_addr;
input                            slv21_connect;
input                      [3:0] slv21_aw_mid;
input                            slv21_awready;
output                           slv21_awvalid;
input           [(DATA_MSB+3):0] slv21_read_data;
input               [ID_MSB+4:0] slv21_rid;
input                            slv21_rvalid;
input                      [3:0] slv21_wmid;
input                            slv21_wready;
input               [ID_MSB+4:0] slv21_bid;
input                      [1:0] slv21_bresp;
input                            slv21_bvalid;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
input                      [3:0] slv22_ar_mid;
input                            slv22_arready;
output                           slv22_arvalid;
input                     [64:0] slv22_addr_mask;
input                     [64:0] slv22_masked_base_addr;
input                            slv22_connect;
input                      [3:0] slv22_aw_mid;
input                            slv22_awready;
output                           slv22_awvalid;
input           [(DATA_MSB+3):0] slv22_read_data;
input               [ID_MSB+4:0] slv22_rid;
input                            slv22_rvalid;
input                      [3:0] slv22_wmid;
input                            slv22_wready;
input               [ID_MSB+4:0] slv22_bid;
input                      [1:0] slv22_bresp;
input                            slv22_bvalid;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
input                      [3:0] slv23_ar_mid;
input                            slv23_arready;
output                           slv23_arvalid;
input                     [64:0] slv23_addr_mask;
input                     [64:0] slv23_masked_base_addr;
input                            slv23_connect;
input                      [3:0] slv23_aw_mid;
input                            slv23_awready;
output                           slv23_awvalid;
input           [(DATA_MSB+3):0] slv23_read_data;
input               [ID_MSB+4:0] slv23_rid;
input                            slv23_rvalid;
input                      [3:0] slv23_wmid;
input                            slv23_wready;
input               [ID_MSB+4:0] slv23_bid;
input                      [1:0] slv23_bresp;
input                            slv23_bvalid;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
input                      [3:0] slv24_ar_mid;
input                            slv24_arready;
output                           slv24_arvalid;
input                     [64:0] slv24_addr_mask;
input                     [64:0] slv24_masked_base_addr;
input                            slv24_connect;
input                      [3:0] slv24_aw_mid;
input                            slv24_awready;
output                           slv24_awvalid;
input           [(DATA_MSB+3):0] slv24_read_data;
input               [ID_MSB+4:0] slv24_rid;
input                            slv24_rvalid;
input                      [3:0] slv24_wmid;
input                            slv24_wready;
input               [ID_MSB+4:0] slv24_bid;
input                      [1:0] slv24_bresp;
input                            slv24_bvalid;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
input                      [3:0] slv25_ar_mid;
input                            slv25_arready;
output                           slv25_arvalid;
input                     [64:0] slv25_addr_mask;
input                     [64:0] slv25_masked_base_addr;
input                            slv25_connect;
input                      [3:0] slv25_aw_mid;
input                            slv25_awready;
output                           slv25_awvalid;
input           [(DATA_MSB+3):0] slv25_read_data;
input               [ID_MSB+4:0] slv25_rid;
input                            slv25_rvalid;
input                      [3:0] slv25_wmid;
input                            slv25_wready;
input               [ID_MSB+4:0] slv25_bid;
input                      [1:0] slv25_bresp;
input                            slv25_bvalid;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
input                      [3:0] slv26_ar_mid;
input                            slv26_arready;
output                           slv26_arvalid;
input                     [64:0] slv26_addr_mask;
input                     [64:0] slv26_masked_base_addr;
input                            slv26_connect;
input                      [3:0] slv26_aw_mid;
input                            slv26_awready;
output                           slv26_awvalid;
input           [(DATA_MSB+3):0] slv26_read_data;
input               [ID_MSB+4:0] slv26_rid;
input                            slv26_rvalid;
input                      [3:0] slv26_wmid;
input                            slv26_wready;
input               [ID_MSB+4:0] slv26_bid;
input                      [1:0] slv26_bresp;
input                            slv26_bvalid;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
input                      [3:0] slv27_ar_mid;
input                            slv27_arready;
output                           slv27_arvalid;
input                     [64:0] slv27_addr_mask;
input                     [64:0] slv27_masked_base_addr;
input                            slv27_connect;
input                      [3:0] slv27_aw_mid;
input                            slv27_awready;
output                           slv27_awvalid;
input           [(DATA_MSB+3):0] slv27_read_data;
input               [ID_MSB+4:0] slv27_rid;
input                            slv27_rvalid;
input                      [3:0] slv27_wmid;
input                            slv27_wready;
input               [ID_MSB+4:0] slv27_bid;
input                      [1:0] slv27_bresp;
input                            slv27_bvalid;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
input                      [3:0] slv28_ar_mid;
input                            slv28_arready;
output                           slv28_arvalid;
input                     [64:0] slv28_addr_mask;
input                     [64:0] slv28_masked_base_addr;
input                            slv28_connect;
input                      [3:0] slv28_aw_mid;
input                            slv28_awready;
output                           slv28_awvalid;
input           [(DATA_MSB+3):0] slv28_read_data;
input               [ID_MSB+4:0] slv28_rid;
input                            slv28_rvalid;
input                      [3:0] slv28_wmid;
input                            slv28_wready;
input               [ID_MSB+4:0] slv28_bid;
input                      [1:0] slv28_bresp;
input                            slv28_bvalid;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
input                      [3:0] slv29_ar_mid;
input                            slv29_arready;
output                           slv29_arvalid;
input                     [64:0] slv29_addr_mask;
input                     [64:0] slv29_masked_base_addr;
input                            slv29_connect;
input                      [3:0] slv29_aw_mid;
input                            slv29_awready;
output                           slv29_awvalid;
input           [(DATA_MSB+3):0] slv29_read_data;
input               [ID_MSB+4:0] slv29_rid;
input                            slv29_rvalid;
input                      [3:0] slv29_wmid;
input                            slv29_wready;
input               [ID_MSB+4:0] slv29_bid;
input                      [1:0] slv29_bresp;
input                            slv29_bvalid;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
input                      [3:0] slv30_ar_mid;
input                            slv30_arready;
output                           slv30_arvalid;
input                     [64:0] slv30_addr_mask;
input                     [64:0] slv30_masked_base_addr;
input                            slv30_connect;
input                      [3:0] slv30_aw_mid;
input                            slv30_awready;
output                           slv30_awvalid;
input           [(DATA_MSB+3):0] slv30_read_data;
input               [ID_MSB+4:0] slv30_rid;
input                            slv30_rvalid;
input                      [3:0] slv30_wmid;
input                            slv30_wready;
input               [ID_MSB+4:0] slv30_bid;
input                      [1:0] slv30_bresp;
input                            slv30_bvalid;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
input                      [3:0] slv31_ar_mid;
input                            slv31_arready;
output                           slv31_arvalid;
input                     [64:0] slv31_addr_mask;
input                     [64:0] slv31_masked_base_addr;
input                            slv31_connect;
input                      [3:0] slv31_aw_mid;
input                            slv31_awready;
output                           slv31_awvalid;
input           [(DATA_MSB+3):0] slv31_read_data;
input               [ID_MSB+4:0] slv31_rid;
input                            slv31_rvalid;
input                      [3:0] slv31_wmid;
input                            slv31_wready;
input               [ID_MSB+4:0] slv31_bid;
input                      [1:0] slv31_bresp;
input                            slv31_bvalid;
`endif
output              [DATA_MSB:0] us_rdata;
output                           us_rlast;
output                     [1:0] us_rresp;
output              [ADDR_MSB:0] mst_araddr;
output                     [1:0] mst_arburst;
output                     [3:0] mst_arcache;
output                [ID_MSB:0] mst_arid;
output                     [7:0] mst_arlen;
output                           mst_arlock;
output                     [2:0] mst_arprot;
output                     [2:0] mst_arsize;
input               [ADDR_MSB:0] us_araddr;
input                      [1:0] us_arburst;
input                      [3:0] us_arcache;
input                 [ID_MSB:0] us_arid;
input                      [7:0] us_arlen;
input                            us_arlock;
input                      [2:0] us_arprot;
output                           us_arready;
input                      [2:0] us_arsize;
input                            us_arvalid;
input                            aclk;
input                            aresetn;
input                      [3:0] self_id;
input                            us_rready;
output              [ADDR_MSB:0] mst_awaddr;
output                     [1:0] mst_awburst;
output                     [3:0] mst_awcache;
output                [ID_MSB:0] mst_awid;
output                     [7:0] mst_awlen;
output                           mst_awlock;
output                     [2:0] mst_awprot;
output                     [2:0] mst_awsize;
input               [ADDR_MSB:0] us_awaddr;
input                      [1:0] us_awburst;
input                      [3:0] us_awcache;
input                 [ID_MSB:0] us_awid;
input                      [7:0] us_awlen;
input                            us_awlock;
input                      [2:0] us_awprot;
output                           us_awready;
input                      [2:0] us_awsize;
input                            us_awvalid;
input                            us_bready;
output                           mst_rready;
output                     [4:0] mst_rsid;
output                [ID_MSB:0] us_rid;
output                           us_rvalid;
output              [DATA_MSB:0] mst_wdata;
output                           mst_wlast;
output                     [4:0] mst_wsid;
output      [(DATA_WIDTH/8)-1:0] mst_wstrb;
output                           mst_wvalid;
input               [DATA_MSB:0] us_wdata;
input                            us_wlast;
output                           us_wready;
input       [(DATA_WIDTH/8)-1:0] us_wstrb;
input                            us_wvalid;
output                           mst_bready;
output                     [4:0] mst_bsid;
output                [ID_MSB:0] us_bid;
output                     [1:0] us_bresp;
output                           us_bvalid;

wire                             ar_outstanding_en;
wire                       [4:0] ar_outstanding_id;
wire            [(DATA_MSB+3):0] dec_err_rd_resp_data;
wire                  [ID_MSB:0] dec_err_rid;
wire                             dec_err_rvalid;
wire                  [ID_MSB:0] locking_arid;
wire                  [ID_MSB:0] master_arid;
wire                             master_arlock;
wire                             master_arvalid;
wire                             mst_arlocking;
wire                             aw_addr_outstanding_en;
wire                       [4:0] aw_outstanding_id;
wire                  [ID_MSB:0] dec_err_bid;
wire                       [1:0] dec_err_bresp;
wire                             dec_err_bvalid;
wire                             dec_err_wready;
wire                  [ID_MSB:0] locking_awid;
wire                             mst_awlocking;
wire                             ar_outstanding_idle;
wire                             ar_outstanding_ready;
wire                             dec_err_rready;
wire            [(DATA_MSB+3):0] s0;
wire                             aw_outstanding_ready;
wire                             dec_err_wlast;
wire                             dec_err_wvalid;
wire                             resp_outstanding_en;
wire                             wd_outstanding_idle;
wire                             br_outstanding_idle;
wire                             dec_err_bready;
wire                             outstanding_resp_ready;

assign us_rdata = s0[DATA_MSB:0];
assign us_rlast = s0[(DATA_MSB+1)];
assign us_rresp = s0[(DATA_MSB+3):(DATA_MSB+2)];

atcbmc300_us_write_addr_ctrl #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTAND_ID_WIDTH(5               ),
	.RESP_INORDER_ONLY(1               )
) us_aw_addr (
	.self_id               (self_id               ),
`ifdef ATCBMC300_SLV0_SUPPORT
	.slv0_aw_mid           (slv0_aw_mid           ),
	.slv0_awready          (slv0_awready          ),
	.slv0_masked_base_addr (slv0_masked_base_addr ),
	.slv0_addr_mask        (slv0_addr_mask        ),
	.slv0_awvalid          (slv0_awvalid          ),
	.slv0_connect          (slv0_connect          ),
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
	.slv1_aw_mid           (slv1_aw_mid           ),
	.slv1_awready          (slv1_awready          ),
	.slv1_masked_base_addr (slv1_masked_base_addr ),
	.slv1_addr_mask        (slv1_addr_mask        ),
	.slv1_awvalid          (slv1_awvalid          ),
	.slv1_connect          (slv1_connect          ),
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
	.slv2_aw_mid           (slv2_aw_mid           ),
	.slv2_awready          (slv2_awready          ),
	.slv2_masked_base_addr (slv2_masked_base_addr ),
	.slv2_addr_mask        (slv2_addr_mask        ),
	.slv2_awvalid          (slv2_awvalid          ),
	.slv2_connect          (slv2_connect          ),
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
	.slv3_aw_mid           (slv3_aw_mid           ),
	.slv3_awready          (slv3_awready          ),
	.slv3_masked_base_addr (slv3_masked_base_addr ),
	.slv3_addr_mask        (slv3_addr_mask        ),
	.slv3_awvalid          (slv3_awvalid          ),
	.slv3_connect          (slv3_connect          ),
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
	.slv4_aw_mid           (slv4_aw_mid           ),
	.slv4_awready          (slv4_awready          ),
	.slv4_masked_base_addr (slv4_masked_base_addr ),
	.slv4_addr_mask        (slv4_addr_mask        ),
	.slv4_awvalid          (slv4_awvalid          ),
	.slv4_connect          (slv4_connect          ),
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
	.slv5_aw_mid           (slv5_aw_mid           ),
	.slv5_awready          (slv5_awready          ),
	.slv5_masked_base_addr (slv5_masked_base_addr ),
	.slv5_addr_mask        (slv5_addr_mask        ),
	.slv5_awvalid          (slv5_awvalid          ),
	.slv5_connect          (slv5_connect          ),
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
	.slv6_aw_mid           (slv6_aw_mid           ),
	.slv6_awready          (slv6_awready          ),
	.slv6_masked_base_addr (slv6_masked_base_addr ),
	.slv6_addr_mask        (slv6_addr_mask        ),
	.slv6_awvalid          (slv6_awvalid          ),
	.slv6_connect          (slv6_connect          ),
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
	.slv7_aw_mid           (slv7_aw_mid           ),
	.slv7_awready          (slv7_awready          ),
	.slv7_masked_base_addr (slv7_masked_base_addr ),
	.slv7_addr_mask        (slv7_addr_mask        ),
	.slv7_awvalid          (slv7_awvalid          ),
	.slv7_connect          (slv7_connect          ),
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
	.slv8_aw_mid           (slv8_aw_mid           ),
	.slv8_awready          (slv8_awready          ),
	.slv8_masked_base_addr (slv8_masked_base_addr ),
	.slv8_addr_mask        (slv8_addr_mask        ),
	.slv8_awvalid          (slv8_awvalid          ),
	.slv8_connect          (slv8_connect          ),
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
	.slv9_aw_mid           (slv9_aw_mid           ),
	.slv9_awready          (slv9_awready          ),
	.slv9_masked_base_addr (slv9_masked_base_addr ),
	.slv9_addr_mask        (slv9_addr_mask        ),
	.slv9_awvalid          (slv9_awvalid          ),
	.slv9_connect          (slv9_connect          ),
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
	.slv10_aw_mid          (slv10_aw_mid          ),
	.slv10_awready         (slv10_awready         ),
	.slv10_masked_base_addr(slv10_masked_base_addr),
	.slv10_addr_mask       (slv10_addr_mask       ),
	.slv10_awvalid         (slv10_awvalid         ),
	.slv10_connect         (slv10_connect         ),
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
	.slv11_aw_mid          (slv11_aw_mid          ),
	.slv11_awready         (slv11_awready         ),
	.slv11_masked_base_addr(slv11_masked_base_addr),
	.slv11_addr_mask       (slv11_addr_mask       ),
	.slv11_awvalid         (slv11_awvalid         ),
	.slv11_connect         (slv11_connect         ),
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
	.slv12_aw_mid          (slv12_aw_mid          ),
	.slv12_awready         (slv12_awready         ),
	.slv12_masked_base_addr(slv12_masked_base_addr),
	.slv12_addr_mask       (slv12_addr_mask       ),
	.slv12_awvalid         (slv12_awvalid         ),
	.slv12_connect         (slv12_connect         ),
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
	.slv13_aw_mid          (slv13_aw_mid          ),
	.slv13_awready         (slv13_awready         ),
	.slv13_masked_base_addr(slv13_masked_base_addr),
	.slv13_addr_mask       (slv13_addr_mask       ),
	.slv13_awvalid         (slv13_awvalid         ),
	.slv13_connect         (slv13_connect         ),
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
	.slv14_aw_mid          (slv14_aw_mid          ),
	.slv14_awready         (slv14_awready         ),
	.slv14_masked_base_addr(slv14_masked_base_addr),
	.slv14_addr_mask       (slv14_addr_mask       ),
	.slv14_awvalid         (slv14_awvalid         ),
	.slv14_connect         (slv14_connect         ),
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
	.slv15_aw_mid          (slv15_aw_mid          ),
	.slv15_awready         (slv15_awready         ),
	.slv15_masked_base_addr(slv15_masked_base_addr),
	.slv15_addr_mask       (slv15_addr_mask       ),
	.slv15_awvalid         (slv15_awvalid         ),
	.slv15_connect         (slv15_connect         ),
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
	.slv16_aw_mid          (slv16_aw_mid          ),
	.slv16_awready         (slv16_awready         ),
	.slv16_masked_base_addr(slv16_masked_base_addr),
	.slv16_addr_mask       (slv16_addr_mask       ),
	.slv16_awvalid         (slv16_awvalid         ),
	.slv16_connect         (slv16_connect         ),
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
	.slv17_aw_mid          (slv17_aw_mid          ),
	.slv17_awready         (slv17_awready         ),
	.slv17_masked_base_addr(slv17_masked_base_addr),
	.slv17_addr_mask       (slv17_addr_mask       ),
	.slv17_awvalid         (slv17_awvalid         ),
	.slv17_connect         (slv17_connect         ),
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
	.slv18_aw_mid          (slv18_aw_mid          ),
	.slv18_awready         (slv18_awready         ),
	.slv18_masked_base_addr(slv18_masked_base_addr),
	.slv18_addr_mask       (slv18_addr_mask       ),
	.slv18_awvalid         (slv18_awvalid         ),
	.slv18_connect         (slv18_connect         ),
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
	.slv19_aw_mid          (slv19_aw_mid          ),
	.slv19_awready         (slv19_awready         ),
	.slv19_masked_base_addr(slv19_masked_base_addr),
	.slv19_addr_mask       (slv19_addr_mask       ),
	.slv19_awvalid         (slv19_awvalid         ),
	.slv19_connect         (slv19_connect         ),
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
	.slv20_aw_mid          (slv20_aw_mid          ),
	.slv20_awready         (slv20_awready         ),
	.slv20_masked_base_addr(slv20_masked_base_addr),
	.slv20_addr_mask       (slv20_addr_mask       ),
	.slv20_awvalid         (slv20_awvalid         ),
	.slv20_connect         (slv20_connect         ),
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
	.slv21_aw_mid          (slv21_aw_mid          ),
	.slv21_awready         (slv21_awready         ),
	.slv21_masked_base_addr(slv21_masked_base_addr),
	.slv21_addr_mask       (slv21_addr_mask       ),
	.slv21_awvalid         (slv21_awvalid         ),
	.slv21_connect         (slv21_connect         ),
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
	.slv22_aw_mid          (slv22_aw_mid          ),
	.slv22_awready         (slv22_awready         ),
	.slv22_masked_base_addr(slv22_masked_base_addr),
	.slv22_addr_mask       (slv22_addr_mask       ),
	.slv22_awvalid         (slv22_awvalid         ),
	.slv22_connect         (slv22_connect         ),
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
	.slv23_aw_mid          (slv23_aw_mid          ),
	.slv23_awready         (slv23_awready         ),
	.slv23_masked_base_addr(slv23_masked_base_addr),
	.slv23_addr_mask       (slv23_addr_mask       ),
	.slv23_awvalid         (slv23_awvalid         ),
	.slv23_connect         (slv23_connect         ),
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
	.slv24_aw_mid          (slv24_aw_mid          ),
	.slv24_awready         (slv24_awready         ),
	.slv24_masked_base_addr(slv24_masked_base_addr),
	.slv24_addr_mask       (slv24_addr_mask       ),
	.slv24_awvalid         (slv24_awvalid         ),
	.slv24_connect         (slv24_connect         ),
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
	.slv25_aw_mid          (slv25_aw_mid          ),
	.slv25_awready         (slv25_awready         ),
	.slv25_masked_base_addr(slv25_masked_base_addr),
	.slv25_addr_mask       (slv25_addr_mask       ),
	.slv25_awvalid         (slv25_awvalid         ),
	.slv25_connect         (slv25_connect         ),
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
	.slv26_aw_mid          (slv26_aw_mid          ),
	.slv26_awready         (slv26_awready         ),
	.slv26_masked_base_addr(slv26_masked_base_addr),
	.slv26_addr_mask       (slv26_addr_mask       ),
	.slv26_awvalid         (slv26_awvalid         ),
	.slv26_connect         (slv26_connect         ),
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
	.slv27_aw_mid          (slv27_aw_mid          ),
	.slv27_awready         (slv27_awready         ),
	.slv27_masked_base_addr(slv27_masked_base_addr),
	.slv27_addr_mask       (slv27_addr_mask       ),
	.slv27_awvalid         (slv27_awvalid         ),
	.slv27_connect         (slv27_connect         ),
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
	.slv28_aw_mid          (slv28_aw_mid          ),
	.slv28_awready         (slv28_awready         ),
	.slv28_masked_base_addr(slv28_masked_base_addr),
	.slv28_addr_mask       (slv28_addr_mask       ),
	.slv28_awvalid         (slv28_awvalid         ),
	.slv28_connect         (slv28_connect         ),
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
	.slv29_aw_mid          (slv29_aw_mid          ),
	.slv29_awready         (slv29_awready         ),
	.slv29_masked_base_addr(slv29_masked_base_addr),
	.slv29_addr_mask       (slv29_addr_mask       ),
	.slv29_awvalid         (slv29_awvalid         ),
	.slv29_connect         (slv29_connect         ),
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
	.slv30_aw_mid          (slv30_aw_mid          ),
	.slv30_awready         (slv30_awready         ),
	.slv30_masked_base_addr(slv30_masked_base_addr),
	.slv30_addr_mask       (slv30_addr_mask       ),
	.slv30_awvalid         (slv30_awvalid         ),
	.slv30_connect         (slv30_connect         ),
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
	.slv31_aw_mid          (slv31_aw_mid          ),
	.slv31_awready         (slv31_awready         ),
	.slv31_masked_base_addr(slv31_masked_base_addr),
	.slv31_addr_mask       (slv31_addr_mask       ),
	.slv31_awvalid         (slv31_awvalid         ),
	.slv31_connect         (slv31_connect         ),
`endif
	.us_awaddr             (us_awaddr             ),
	.us_awlen              (us_awlen              ),
	.us_awsize             (us_awsize             ),
	.us_awburst            (us_awburst            ),
	.us_awlock             (us_awlock             ),
	.us_awcache            (us_awcache            ),
	.us_awprot             (us_awprot             ),
	.us_awid               (us_awid               ),
	.us_awvalid            (us_awvalid            ),
	.us_awready            (us_awready            ),
	.mst_awaddr            (mst_awaddr            ),
	.mst_awlen             (mst_awlen             ),
	.mst_awsize            (mst_awsize            ),
	.mst_awburst           (mst_awburst           ),
	.mst_awlock            (mst_awlock            ),
	.mst_awcache           (mst_awcache           ),
	.mst_awprot            (mst_awprot            ),
	.mst_awid              (mst_awid              ),
	.dec_err_wready        (dec_err_wready        ),
	.dec_err_bvalid        (dec_err_bvalid        ),
	.dec_err_wvalid        (dec_err_wvalid        ),
	.dec_err_wlast         (dec_err_wlast         ),
	.dec_err_bready        (dec_err_bready        ),
	.aw_outstanding_id     (aw_outstanding_id     ),
	.dec_err_bresp         (dec_err_bresp         ),
	.dec_err_bid           (dec_err_bid           ),
	.aw_addr_outstanding_en(aw_addr_outstanding_en),
	.aw_outstanding_ready  (aw_outstanding_ready  ),
	.wd_outstanding_idle   (wd_outstanding_idle   ),
	.br_outstanding_idle   (br_outstanding_idle   ),
	.master_arlock         (master_arlock         ),
	.master_arvalid        (master_arvalid        ),
	.master_arid           (master_arid           ),
	.mst_arlocking         (mst_arlocking         ),
	.locking_arid          (locking_arid          ),
	.us_bid                (us_bid                ),
	.us_bvalid             (us_bvalid             ),
	.us_bready             (us_bready             ),
	.mst_awlocking         (mst_awlocking         ),
	.locking_awid          (locking_awid          ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               )
);

atcbmc300_us_wdata_ctrl #(
	.DATA_WIDTH      (DATA_WIDTH      ),
	.OUTSTANDING_DEPTH(OUTSTANDING_DEPTH),
	.OUTSTAND_ID_WIDTH(5               )
) us_wr_data (
	.self_id               (self_id               ),
`ifdef ATCBMC300_SLV0_SUPPORT
	.slv0_wmid             (slv0_wmid             ),
	.slv0_wready           (slv0_wready           ),
	.slv0_connect          (slv0_connect          ),
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
	.slv1_wmid             (slv1_wmid             ),
	.slv1_wready           (slv1_wready           ),
	.slv1_connect          (slv1_connect          ),
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
	.slv2_wmid             (slv2_wmid             ),
	.slv2_wready           (slv2_wready           ),
	.slv2_connect          (slv2_connect          ),
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
	.slv3_wmid             (slv3_wmid             ),
	.slv3_wready           (slv3_wready           ),
	.slv3_connect          (slv3_connect          ),
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
	.slv4_wmid             (slv4_wmid             ),
	.slv4_wready           (slv4_wready           ),
	.slv4_connect          (slv4_connect          ),
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
	.slv5_wmid             (slv5_wmid             ),
	.slv5_wready           (slv5_wready           ),
	.slv5_connect          (slv5_connect          ),
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
	.slv6_wmid             (slv6_wmid             ),
	.slv6_wready           (slv6_wready           ),
	.slv6_connect          (slv6_connect          ),
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
	.slv7_wmid             (slv7_wmid             ),
	.slv7_wready           (slv7_wready           ),
	.slv7_connect          (slv7_connect          ),
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
	.slv8_wmid             (slv8_wmid             ),
	.slv8_wready           (slv8_wready           ),
	.slv8_connect          (slv8_connect          ),
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
	.slv9_wmid             (slv9_wmid             ),
	.slv9_wready           (slv9_wready           ),
	.slv9_connect          (slv9_connect          ),
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
	.slv10_wmid            (slv10_wmid            ),
	.slv10_wready          (slv10_wready          ),
	.slv10_connect         (slv10_connect         ),
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
	.slv11_wmid            (slv11_wmid            ),
	.slv11_wready          (slv11_wready          ),
	.slv11_connect         (slv11_connect         ),
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
	.slv12_wmid            (slv12_wmid            ),
	.slv12_wready          (slv12_wready          ),
	.slv12_connect         (slv12_connect         ),
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
	.slv13_wmid            (slv13_wmid            ),
	.slv13_wready          (slv13_wready          ),
	.slv13_connect         (slv13_connect         ),
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
	.slv14_wmid            (slv14_wmid            ),
	.slv14_wready          (slv14_wready          ),
	.slv14_connect         (slv14_connect         ),
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
	.slv15_wmid            (slv15_wmid            ),
	.slv15_wready          (slv15_wready          ),
	.slv15_connect         (slv15_connect         ),
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
	.slv16_wmid            (slv16_wmid            ),
	.slv16_wready          (slv16_wready          ),
	.slv16_connect         (slv16_connect         ),
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
	.slv17_wmid            (slv17_wmid            ),
	.slv17_wready          (slv17_wready          ),
	.slv17_connect         (slv17_connect         ),
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
	.slv18_wmid            (slv18_wmid            ),
	.slv18_wready          (slv18_wready          ),
	.slv18_connect         (slv18_connect         ),
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
	.slv19_wmid            (slv19_wmid            ),
	.slv19_wready          (slv19_wready          ),
	.slv19_connect         (slv19_connect         ),
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
	.slv20_wmid            (slv20_wmid            ),
	.slv20_wready          (slv20_wready          ),
	.slv20_connect         (slv20_connect         ),
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
	.slv21_wmid            (slv21_wmid            ),
	.slv21_wready          (slv21_wready          ),
	.slv21_connect         (slv21_connect         ),
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
	.slv22_wmid            (slv22_wmid            ),
	.slv22_wready          (slv22_wready          ),
	.slv22_connect         (slv22_connect         ),
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
	.slv23_wmid            (slv23_wmid            ),
	.slv23_wready          (slv23_wready          ),
	.slv23_connect         (slv23_connect         ),
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
	.slv24_wmid            (slv24_wmid            ),
	.slv24_wready          (slv24_wready          ),
	.slv24_connect         (slv24_connect         ),
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
	.slv25_wmid            (slv25_wmid            ),
	.slv25_wready          (slv25_wready          ),
	.slv25_connect         (slv25_connect         ),
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
	.slv26_wmid            (slv26_wmid            ),
	.slv26_wready          (slv26_wready          ),
	.slv26_connect         (slv26_connect         ),
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
	.slv27_wmid            (slv27_wmid            ),
	.slv27_wready          (slv27_wready          ),
	.slv27_connect         (slv27_connect         ),
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
	.slv28_wmid            (slv28_wmid            ),
	.slv28_wready          (slv28_wready          ),
	.slv28_connect         (slv28_connect         ),
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
	.slv29_wmid            (slv29_wmid            ),
	.slv29_wready          (slv29_wready          ),
	.slv29_connect         (slv29_connect         ),
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
	.slv30_wmid            (slv30_wmid            ),
	.slv30_wready          (slv30_wready          ),
	.slv30_connect         (slv30_connect         ),
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
	.slv31_wmid            (slv31_wmid            ),
	.slv31_wready          (slv31_wready          ),
	.slv31_connect         (slv31_connect         ),
`endif
	.us_wdata              (us_wdata              ),
	.us_wlast              (us_wlast              ),
	.us_wstrb              (us_wstrb              ),
	.us_wvalid             (us_wvalid             ),
	.us_wready             (us_wready             ),
	.aw_outstanding_id     (aw_outstanding_id     ),
	.aw_addr_outstanding_en(aw_addr_outstanding_en),
	.aw_outstanding_ready  (aw_outstanding_ready  ),
	.wd_outstanding_idle   (wd_outstanding_idle   ),
	.resp_outstanding_en   (resp_outstanding_en   ),
	.outstanding_resp_ready(outstanding_resp_ready),
	.dec_err_wready        (dec_err_wready        ),
	.dec_err_wvalid        (dec_err_wvalid        ),
	.dec_err_wlast         (dec_err_wlast         ),
	.mst_wsid              (mst_wsid              ),
	.mst_wvalid            (mst_wvalid            ),
	.mst_wdata             (mst_wdata             ),
	.mst_wlast             (mst_wlast             ),
	.mst_wstrb             (mst_wstrb             ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               )
);

atcbmc300_us_resp_ctrl #(
	.BRESP_CHANNEL   (1               ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTANDING_DEPTH(OUTSTANDING_DEPTH),
	.OUTSTAND_ID_WIDTH(5               ),
	.RESP_DATA_WIDTH (2               ),
	.RESP_INORDER_ONLY(0               )
) us_wr_resp (
	.self_id           (self_id               ),
`ifdef ATCBMC300_SLV0_SUPPORT
	.slv0_resp_data    (slv0_bresp            ),
	.slv0_resp_id      (slv0_bid              ),
	.slv0_resp_valid   (slv0_bvalid           ),
	.slv0_connect      (slv0_connect          ),
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
	.slv1_resp_data    (slv1_bresp            ),
	.slv1_resp_id      (slv1_bid              ),
	.slv1_resp_valid   (slv1_bvalid           ),
	.slv1_connect      (slv1_connect          ),
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
	.slv2_resp_data    (slv2_bresp            ),
	.slv2_resp_id      (slv2_bid              ),
	.slv2_resp_valid   (slv2_bvalid           ),
	.slv2_connect      (slv2_connect          ),
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
	.slv3_resp_data    (slv3_bresp            ),
	.slv3_resp_id      (slv3_bid              ),
	.slv3_resp_valid   (slv3_bvalid           ),
	.slv3_connect      (slv3_connect          ),
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
	.slv4_resp_data    (slv4_bresp            ),
	.slv4_resp_id      (slv4_bid              ),
	.slv4_resp_valid   (slv4_bvalid           ),
	.slv4_connect      (slv4_connect          ),
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
	.slv5_resp_data    (slv5_bresp            ),
	.slv5_resp_id      (slv5_bid              ),
	.slv5_resp_valid   (slv5_bvalid           ),
	.slv5_connect      (slv5_connect          ),
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
	.slv6_resp_data    (slv6_bresp            ),
	.slv6_resp_id      (slv6_bid              ),
	.slv6_resp_valid   (slv6_bvalid           ),
	.slv6_connect      (slv6_connect          ),
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
	.slv7_resp_data    (slv7_bresp            ),
	.slv7_resp_id      (slv7_bid              ),
	.slv7_resp_valid   (slv7_bvalid           ),
	.slv7_connect      (slv7_connect          ),
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
	.slv8_resp_data    (slv8_bresp            ),
	.slv8_resp_id      (slv8_bid              ),
	.slv8_resp_valid   (slv8_bvalid           ),
	.slv8_connect      (slv8_connect          ),
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
	.slv9_resp_data    (slv9_bresp            ),
	.slv9_resp_id      (slv9_bid              ),
	.slv9_resp_valid   (slv9_bvalid           ),
	.slv9_connect      (slv9_connect          ),
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
	.slv10_resp_data   (slv10_bresp           ),
	.slv10_resp_id     (slv10_bid             ),
	.slv10_resp_valid  (slv10_bvalid          ),
	.slv10_connect     (slv10_connect         ),
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
	.slv11_resp_data   (slv11_bresp           ),
	.slv11_resp_id     (slv11_bid             ),
	.slv11_resp_valid  (slv11_bvalid          ),
	.slv11_connect     (slv11_connect         ),
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
	.slv12_resp_data   (slv12_bresp           ),
	.slv12_resp_id     (slv12_bid             ),
	.slv12_resp_valid  (slv12_bvalid          ),
	.slv12_connect     (slv12_connect         ),
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
	.slv13_resp_data   (slv13_bresp           ),
	.slv13_resp_id     (slv13_bid             ),
	.slv13_resp_valid  (slv13_bvalid          ),
	.slv13_connect     (slv13_connect         ),
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
	.slv14_resp_data   (slv14_bresp           ),
	.slv14_resp_id     (slv14_bid             ),
	.slv14_resp_valid  (slv14_bvalid          ),
	.slv14_connect     (slv14_connect         ),
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
	.slv15_resp_data   (slv15_bresp           ),
	.slv15_resp_id     (slv15_bid             ),
	.slv15_resp_valid  (slv15_bvalid          ),
	.slv15_connect     (slv15_connect         ),
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
	.slv16_resp_data   (slv16_bresp           ),
	.slv16_resp_id     (slv16_bid             ),
	.slv16_resp_valid  (slv16_bvalid          ),
	.slv16_connect     (slv16_connect         ),
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
	.slv17_resp_data   (slv17_bresp           ),
	.slv17_resp_id     (slv17_bid             ),
	.slv17_resp_valid  (slv17_bvalid          ),
	.slv17_connect     (slv17_connect         ),
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
	.slv18_resp_data   (slv18_bresp           ),
	.slv18_resp_id     (slv18_bid             ),
	.slv18_resp_valid  (slv18_bvalid          ),
	.slv18_connect     (slv18_connect         ),
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
	.slv19_resp_data   (slv19_bresp           ),
	.slv19_resp_id     (slv19_bid             ),
	.slv19_resp_valid  (slv19_bvalid          ),
	.slv19_connect     (slv19_connect         ),
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
	.slv20_resp_data   (slv20_bresp           ),
	.slv20_resp_id     (slv20_bid             ),
	.slv20_resp_valid  (slv20_bvalid          ),
	.slv20_connect     (slv20_connect         ),
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
	.slv21_resp_data   (slv21_bresp           ),
	.slv21_resp_id     (slv21_bid             ),
	.slv21_resp_valid  (slv21_bvalid          ),
	.slv21_connect     (slv21_connect         ),
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
	.slv22_resp_data   (slv22_bresp           ),
	.slv22_resp_id     (slv22_bid             ),
	.slv22_resp_valid  (slv22_bvalid          ),
	.slv22_connect     (slv22_connect         ),
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
	.slv23_resp_data   (slv23_bresp           ),
	.slv23_resp_id     (slv23_bid             ),
	.slv23_resp_valid  (slv23_bvalid          ),
	.slv23_connect     (slv23_connect         ),
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
	.slv24_resp_data   (slv24_bresp           ),
	.slv24_resp_id     (slv24_bid             ),
	.slv24_resp_valid  (slv24_bvalid          ),
	.slv24_connect     (slv24_connect         ),
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
	.slv25_resp_data   (slv25_bresp           ),
	.slv25_resp_id     (slv25_bid             ),
	.slv25_resp_valid  (slv25_bvalid          ),
	.slv25_connect     (slv25_connect         ),
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
	.slv26_resp_data   (slv26_bresp           ),
	.slv26_resp_id     (slv26_bid             ),
	.slv26_resp_valid  (slv26_bvalid          ),
	.slv26_connect     (slv26_connect         ),
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
	.slv27_resp_data   (slv27_bresp           ),
	.slv27_resp_id     (slv27_bid             ),
	.slv27_resp_valid  (slv27_bvalid          ),
	.slv27_connect     (slv27_connect         ),
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
	.slv28_resp_data   (slv28_bresp           ),
	.slv28_resp_id     (slv28_bid             ),
	.slv28_resp_valid  (slv28_bvalid          ),
	.slv28_connect     (slv28_connect         ),
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
	.slv29_resp_data   (slv29_bresp           ),
	.slv29_resp_id     (slv29_bid             ),
	.slv29_resp_valid  (slv29_bvalid          ),
	.slv29_connect     (slv29_connect         ),
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
	.slv30_resp_data   (slv30_bresp           ),
	.slv30_resp_id     (slv30_bid             ),
	.slv30_resp_valid  (slv30_bvalid          ),
	.slv30_connect     (slv30_connect         ),
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
	.slv31_resp_data   (slv31_bresp           ),
	.slv31_resp_id     (slv31_bid             ),
	.slv31_resp_valid  (slv31_bvalid          ),
	.slv31_connect     (slv31_connect         ),
`endif
	.mst_resp_slave_id (mst_bsid              ),
	.mst_resp_ready    (mst_bready            ),
	.dec_err_resp_id   (dec_err_bid           ),
	.dec_err_resp_data (dec_err_bresp         ),
	.dec_err_resp_valid(dec_err_bvalid        ),
	.dec_err_resp_ready(dec_err_bready        ),
	.outstanding_id    (mst_wsid              ),
	.outstanding_en    (resp_outstanding_en   ),
	.outstanding_ready (outstanding_resp_ready),
	.outstanding_idle  (br_outstanding_idle   ),
	.resp_id           (us_bid                ),
	.resp_data         (us_bresp              ),
	.resp_valid        (us_bvalid             ),
	.resp_ready        (us_bready             ),
	.aclk              (aclk                  ),
	.aresetn           (aresetn               )
);

atcbmc300_us_read_addr_ctrl #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTAND_ID_WIDTH(5               ),
	.RESP_INORDER_ONLY(1               )
) us_ar_addr (
	.self_id               (self_id               ),
`ifdef ATCBMC300_SLV0_SUPPORT
	.slv0_ar_mid           (slv0_ar_mid           ),
	.slv0_arready          (slv0_arready          ),
	.slv0_masked_base_addr (slv0_masked_base_addr ),
	.slv0_addr_mask        (slv0_addr_mask        ),
	.slv0_arvalid          (slv0_arvalid          ),
	.slv0_connect          (slv0_connect          ),
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
	.slv1_ar_mid           (slv1_ar_mid           ),
	.slv1_arready          (slv1_arready          ),
	.slv1_masked_base_addr (slv1_masked_base_addr ),
	.slv1_addr_mask        (slv1_addr_mask        ),
	.slv1_arvalid          (slv1_arvalid          ),
	.slv1_connect          (slv1_connect          ),
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
	.slv2_ar_mid           (slv2_ar_mid           ),
	.slv2_arready          (slv2_arready          ),
	.slv2_masked_base_addr (slv2_masked_base_addr ),
	.slv2_addr_mask        (slv2_addr_mask        ),
	.slv2_arvalid          (slv2_arvalid          ),
	.slv2_connect          (slv2_connect          ),
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
	.slv3_ar_mid           (slv3_ar_mid           ),
	.slv3_arready          (slv3_arready          ),
	.slv3_masked_base_addr (slv3_masked_base_addr ),
	.slv3_addr_mask        (slv3_addr_mask        ),
	.slv3_arvalid          (slv3_arvalid          ),
	.slv3_connect          (slv3_connect          ),
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
	.slv4_ar_mid           (slv4_ar_mid           ),
	.slv4_arready          (slv4_arready          ),
	.slv4_masked_base_addr (slv4_masked_base_addr ),
	.slv4_addr_mask        (slv4_addr_mask        ),
	.slv4_arvalid          (slv4_arvalid          ),
	.slv4_connect          (slv4_connect          ),
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
	.slv5_ar_mid           (slv5_ar_mid           ),
	.slv5_arready          (slv5_arready          ),
	.slv5_masked_base_addr (slv5_masked_base_addr ),
	.slv5_addr_mask        (slv5_addr_mask        ),
	.slv5_arvalid          (slv5_arvalid          ),
	.slv5_connect          (slv5_connect          ),
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
	.slv6_ar_mid           (slv6_ar_mid           ),
	.slv6_arready          (slv6_arready          ),
	.slv6_masked_base_addr (slv6_masked_base_addr ),
	.slv6_addr_mask        (slv6_addr_mask        ),
	.slv6_arvalid          (slv6_arvalid          ),
	.slv6_connect          (slv6_connect          ),
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
	.slv7_ar_mid           (slv7_ar_mid           ),
	.slv7_arready          (slv7_arready          ),
	.slv7_masked_base_addr (slv7_masked_base_addr ),
	.slv7_addr_mask        (slv7_addr_mask        ),
	.slv7_arvalid          (slv7_arvalid          ),
	.slv7_connect          (slv7_connect          ),
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
	.slv8_ar_mid           (slv8_ar_mid           ),
	.slv8_arready          (slv8_arready          ),
	.slv8_masked_base_addr (slv8_masked_base_addr ),
	.slv8_addr_mask        (slv8_addr_mask        ),
	.slv8_arvalid          (slv8_arvalid          ),
	.slv8_connect          (slv8_connect          ),
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
	.slv9_ar_mid           (slv9_ar_mid           ),
	.slv9_arready          (slv9_arready          ),
	.slv9_masked_base_addr (slv9_masked_base_addr ),
	.slv9_addr_mask        (slv9_addr_mask        ),
	.slv9_arvalid          (slv9_arvalid          ),
	.slv9_connect          (slv9_connect          ),
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
	.slv10_ar_mid          (slv10_ar_mid          ),
	.slv10_arready         (slv10_arready         ),
	.slv10_masked_base_addr(slv10_masked_base_addr),
	.slv10_addr_mask       (slv10_addr_mask       ),
	.slv10_arvalid         (slv10_arvalid         ),
	.slv10_connect         (slv10_connect         ),
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
	.slv11_ar_mid          (slv11_ar_mid          ),
	.slv11_arready         (slv11_arready         ),
	.slv11_masked_base_addr(slv11_masked_base_addr),
	.slv11_addr_mask       (slv11_addr_mask       ),
	.slv11_arvalid         (slv11_arvalid         ),
	.slv11_connect         (slv11_connect         ),
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
	.slv12_ar_mid          (slv12_ar_mid          ),
	.slv12_arready         (slv12_arready         ),
	.slv12_masked_base_addr(slv12_masked_base_addr),
	.slv12_addr_mask       (slv12_addr_mask       ),
	.slv12_arvalid         (slv12_arvalid         ),
	.slv12_connect         (slv12_connect         ),
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
	.slv13_ar_mid          (slv13_ar_mid          ),
	.slv13_arready         (slv13_arready         ),
	.slv13_masked_base_addr(slv13_masked_base_addr),
	.slv13_addr_mask       (slv13_addr_mask       ),
	.slv13_arvalid         (slv13_arvalid         ),
	.slv13_connect         (slv13_connect         ),
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
	.slv14_ar_mid          (slv14_ar_mid          ),
	.slv14_arready         (slv14_arready         ),
	.slv14_masked_base_addr(slv14_masked_base_addr),
	.slv14_addr_mask       (slv14_addr_mask       ),
	.slv14_arvalid         (slv14_arvalid         ),
	.slv14_connect         (slv14_connect         ),
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
	.slv15_ar_mid          (slv15_ar_mid          ),
	.slv15_arready         (slv15_arready         ),
	.slv15_masked_base_addr(slv15_masked_base_addr),
	.slv15_addr_mask       (slv15_addr_mask       ),
	.slv15_arvalid         (slv15_arvalid         ),
	.slv15_connect         (slv15_connect         ),
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
	.slv16_ar_mid          (slv16_ar_mid          ),
	.slv16_arready         (slv16_arready         ),
	.slv16_masked_base_addr(slv16_masked_base_addr),
	.slv16_addr_mask       (slv16_addr_mask       ),
	.slv16_arvalid         (slv16_arvalid         ),
	.slv16_connect         (slv16_connect         ),
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
	.slv17_ar_mid          (slv17_ar_mid          ),
	.slv17_arready         (slv17_arready         ),
	.slv17_masked_base_addr(slv17_masked_base_addr),
	.slv17_addr_mask       (slv17_addr_mask       ),
	.slv17_arvalid         (slv17_arvalid         ),
	.slv17_connect         (slv17_connect         ),
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
	.slv18_ar_mid          (slv18_ar_mid          ),
	.slv18_arready         (slv18_arready         ),
	.slv18_masked_base_addr(slv18_masked_base_addr),
	.slv18_addr_mask       (slv18_addr_mask       ),
	.slv18_arvalid         (slv18_arvalid         ),
	.slv18_connect         (slv18_connect         ),
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
	.slv19_ar_mid          (slv19_ar_mid          ),
	.slv19_arready         (slv19_arready         ),
	.slv19_masked_base_addr(slv19_masked_base_addr),
	.slv19_addr_mask       (slv19_addr_mask       ),
	.slv19_arvalid         (slv19_arvalid         ),
	.slv19_connect         (slv19_connect         ),
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
	.slv20_ar_mid          (slv20_ar_mid          ),
	.slv20_arready         (slv20_arready         ),
	.slv20_masked_base_addr(slv20_masked_base_addr),
	.slv20_addr_mask       (slv20_addr_mask       ),
	.slv20_arvalid         (slv20_arvalid         ),
	.slv20_connect         (slv20_connect         ),
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
	.slv21_ar_mid          (slv21_ar_mid          ),
	.slv21_arready         (slv21_arready         ),
	.slv21_masked_base_addr(slv21_masked_base_addr),
	.slv21_addr_mask       (slv21_addr_mask       ),
	.slv21_arvalid         (slv21_arvalid         ),
	.slv21_connect         (slv21_connect         ),
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
	.slv22_ar_mid          (slv22_ar_mid          ),
	.slv22_arready         (slv22_arready         ),
	.slv22_masked_base_addr(slv22_masked_base_addr),
	.slv22_addr_mask       (slv22_addr_mask       ),
	.slv22_arvalid         (slv22_arvalid         ),
	.slv22_connect         (slv22_connect         ),
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
	.slv23_ar_mid          (slv23_ar_mid          ),
	.slv23_arready         (slv23_arready         ),
	.slv23_masked_base_addr(slv23_masked_base_addr),
	.slv23_addr_mask       (slv23_addr_mask       ),
	.slv23_arvalid         (slv23_arvalid         ),
	.slv23_connect         (slv23_connect         ),
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
	.slv24_ar_mid          (slv24_ar_mid          ),
	.slv24_arready         (slv24_arready         ),
	.slv24_masked_base_addr(slv24_masked_base_addr),
	.slv24_addr_mask       (slv24_addr_mask       ),
	.slv24_arvalid         (slv24_arvalid         ),
	.slv24_connect         (slv24_connect         ),
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
	.slv25_ar_mid          (slv25_ar_mid          ),
	.slv25_arready         (slv25_arready         ),
	.slv25_masked_base_addr(slv25_masked_base_addr),
	.slv25_addr_mask       (slv25_addr_mask       ),
	.slv25_arvalid         (slv25_arvalid         ),
	.slv25_connect         (slv25_connect         ),
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
	.slv26_ar_mid          (slv26_ar_mid          ),
	.slv26_arready         (slv26_arready         ),
	.slv26_masked_base_addr(slv26_masked_base_addr),
	.slv26_addr_mask       (slv26_addr_mask       ),
	.slv26_arvalid         (slv26_arvalid         ),
	.slv26_connect         (slv26_connect         ),
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
	.slv27_ar_mid          (slv27_ar_mid          ),
	.slv27_arready         (slv27_arready         ),
	.slv27_masked_base_addr(slv27_masked_base_addr),
	.slv27_addr_mask       (slv27_addr_mask       ),
	.slv27_arvalid         (slv27_arvalid         ),
	.slv27_connect         (slv27_connect         ),
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
	.slv28_ar_mid          (slv28_ar_mid          ),
	.slv28_arready         (slv28_arready         ),
	.slv28_masked_base_addr(slv28_masked_base_addr),
	.slv28_addr_mask       (slv28_addr_mask       ),
	.slv28_arvalid         (slv28_arvalid         ),
	.slv28_connect         (slv28_connect         ),
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
	.slv29_ar_mid          (slv29_ar_mid          ),
	.slv29_arready         (slv29_arready         ),
	.slv29_masked_base_addr(slv29_masked_base_addr),
	.slv29_addr_mask       (slv29_addr_mask       ),
	.slv29_arvalid         (slv29_arvalid         ),
	.slv29_connect         (slv29_connect         ),
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
	.slv30_ar_mid          (slv30_ar_mid          ),
	.slv30_arready         (slv30_arready         ),
	.slv30_masked_base_addr(slv30_masked_base_addr),
	.slv30_addr_mask       (slv30_addr_mask       ),
	.slv30_arvalid         (slv30_arvalid         ),
	.slv30_connect         (slv30_connect         ),
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
	.slv31_ar_mid          (slv31_ar_mid          ),
	.slv31_arready         (slv31_arready         ),
	.slv31_masked_base_addr(slv31_masked_base_addr),
	.slv31_addr_mask       (slv31_addr_mask       ),
	.slv31_arvalid         (slv31_arvalid         ),
	.slv31_connect         (slv31_connect         ),
`endif
	.us_araddr             (us_araddr             ),
	.us_arlen              (us_arlen              ),
	.us_arsize             (us_arsize             ),
	.us_arburst            (us_arburst            ),
	.us_arlock             (us_arlock             ),
	.us_arcache            (us_arcache            ),
	.us_arprot             (us_arprot             ),
	.us_arid               (us_arid               ),
	.us_arvalid            (us_arvalid            ),
	.us_arready            (us_arready            ),
	.mst_araddr            (mst_araddr            ),
	.mst_arlen             (mst_arlen             ),
	.mst_arsize            (mst_arsize            ),
	.mst_arburst           (mst_arburst           ),
	.mst_arlock            (mst_arlock            ),
	.mst_arcache           (mst_arcache           ),
	.mst_arprot            (mst_arprot            ),
	.mst_arid              (mst_arid              ),
	.dec_err_rvalid        (dec_err_rvalid        ),
	.us_rid                (us_rid                ),
	.us_rlast              (us_rlast              ),
	.us_rready             (us_rready             ),
	.us_rvalid             (us_rvalid             ),
	.master_arlock         (master_arlock         ),
	.master_arvalid        (master_arvalid        ),
	.master_arid           (master_arid           ),
	.mst_arlocking         (mst_arlocking         ),
	.locking_arid          (locking_arid          ),
	.mst_awlocking         (mst_awlocking         ),
	.locking_awid          (locking_awid          ),
	.dec_err_rready        (dec_err_rready        ),
	.dec_err_rd_resp_data  (dec_err_rd_resp_data  ),
	.dec_err_rid           (dec_err_rid           ),
	.ar_outstanding_en     (ar_outstanding_en     ),
	.ar_outstanding_id     (ar_outstanding_id     ),
	.ar_outstanding_ready  (ar_outstanding_ready  ),
	.ar_outstanding_idle   (ar_outstanding_idle   ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               )
);

atcbmc300_us_resp_ctrl #(
	.BRESP_CHANNEL   (0               ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTANDING_DEPTH(OUTSTANDING_DEPTH),
	.OUTSTAND_ID_WIDTH(5               ),
	.RESP_DATA_WIDTH (DATA_WIDTH+3    ),
	.RESP_INORDER_ONLY(0               )
) us_rd_data (
	.self_id           (self_id             ),
`ifdef ATCBMC300_SLV0_SUPPORT
	.slv0_resp_data    (slv0_read_data      ),
	.slv0_resp_id      (slv0_rid            ),
	.slv0_resp_valid   (slv0_rvalid         ),
	.slv0_connect      (slv0_connect        ),
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
	.slv1_resp_data    (slv1_read_data      ),
	.slv1_resp_id      (slv1_rid            ),
	.slv1_resp_valid   (slv1_rvalid         ),
	.slv1_connect      (slv1_connect        ),
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
	.slv2_resp_data    (slv2_read_data      ),
	.slv2_resp_id      (slv2_rid            ),
	.slv2_resp_valid   (slv2_rvalid         ),
	.slv2_connect      (slv2_connect        ),
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
	.slv3_resp_data    (slv3_read_data      ),
	.slv3_resp_id      (slv3_rid            ),
	.slv3_resp_valid   (slv3_rvalid         ),
	.slv3_connect      (slv3_connect        ),
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
	.slv4_resp_data    (slv4_read_data      ),
	.slv4_resp_id      (slv4_rid            ),
	.slv4_resp_valid   (slv4_rvalid         ),
	.slv4_connect      (slv4_connect        ),
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
	.slv5_resp_data    (slv5_read_data      ),
	.slv5_resp_id      (slv5_rid            ),
	.slv5_resp_valid   (slv5_rvalid         ),
	.slv5_connect      (slv5_connect        ),
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
	.slv6_resp_data    (slv6_read_data      ),
	.slv6_resp_id      (slv6_rid            ),
	.slv6_resp_valid   (slv6_rvalid         ),
	.slv6_connect      (slv6_connect        ),
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
	.slv7_resp_data    (slv7_read_data      ),
	.slv7_resp_id      (slv7_rid            ),
	.slv7_resp_valid   (slv7_rvalid         ),
	.slv7_connect      (slv7_connect        ),
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
	.slv8_resp_data    (slv8_read_data      ),
	.slv8_resp_id      (slv8_rid            ),
	.slv8_resp_valid   (slv8_rvalid         ),
	.slv8_connect      (slv8_connect        ),
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
	.slv9_resp_data    (slv9_read_data      ),
	.slv9_resp_id      (slv9_rid            ),
	.slv9_resp_valid   (slv9_rvalid         ),
	.slv9_connect      (slv9_connect        ),
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
	.slv10_resp_data   (slv10_read_data     ),
	.slv10_resp_id     (slv10_rid           ),
	.slv10_resp_valid  (slv10_rvalid        ),
	.slv10_connect     (slv10_connect       ),
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
	.slv11_resp_data   (slv11_read_data     ),
	.slv11_resp_id     (slv11_rid           ),
	.slv11_resp_valid  (slv11_rvalid        ),
	.slv11_connect     (slv11_connect       ),
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
	.slv12_resp_data   (slv12_read_data     ),
	.slv12_resp_id     (slv12_rid           ),
	.slv12_resp_valid  (slv12_rvalid        ),
	.slv12_connect     (slv12_connect       ),
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
	.slv13_resp_data   (slv13_read_data     ),
	.slv13_resp_id     (slv13_rid           ),
	.slv13_resp_valid  (slv13_rvalid        ),
	.slv13_connect     (slv13_connect       ),
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
	.slv14_resp_data   (slv14_read_data     ),
	.slv14_resp_id     (slv14_rid           ),
	.slv14_resp_valid  (slv14_rvalid        ),
	.slv14_connect     (slv14_connect       ),
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
	.slv15_resp_data   (slv15_read_data     ),
	.slv15_resp_id     (slv15_rid           ),
	.slv15_resp_valid  (slv15_rvalid        ),
	.slv15_connect     (slv15_connect       ),
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
	.slv16_resp_data   (slv16_read_data     ),
	.slv16_resp_id     (slv16_rid           ),
	.slv16_resp_valid  (slv16_rvalid        ),
	.slv16_connect     (slv16_connect       ),
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
	.slv17_resp_data   (slv17_read_data     ),
	.slv17_resp_id     (slv17_rid           ),
	.slv17_resp_valid  (slv17_rvalid        ),
	.slv17_connect     (slv17_connect       ),
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
	.slv18_resp_data   (slv18_read_data     ),
	.slv18_resp_id     (slv18_rid           ),
	.slv18_resp_valid  (slv18_rvalid        ),
	.slv18_connect     (slv18_connect       ),
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
	.slv19_resp_data   (slv19_read_data     ),
	.slv19_resp_id     (slv19_rid           ),
	.slv19_resp_valid  (slv19_rvalid        ),
	.slv19_connect     (slv19_connect       ),
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
	.slv20_resp_data   (slv20_read_data     ),
	.slv20_resp_id     (slv20_rid           ),
	.slv20_resp_valid  (slv20_rvalid        ),
	.slv20_connect     (slv20_connect       ),
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
	.slv21_resp_data   (slv21_read_data     ),
	.slv21_resp_id     (slv21_rid           ),
	.slv21_resp_valid  (slv21_rvalid        ),
	.slv21_connect     (slv21_connect       ),
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
	.slv22_resp_data   (slv22_read_data     ),
	.slv22_resp_id     (slv22_rid           ),
	.slv22_resp_valid  (slv22_rvalid        ),
	.slv22_connect     (slv22_connect       ),
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
	.slv23_resp_data   (slv23_read_data     ),
	.slv23_resp_id     (slv23_rid           ),
	.slv23_resp_valid  (slv23_rvalid        ),
	.slv23_connect     (slv23_connect       ),
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
	.slv24_resp_data   (slv24_read_data     ),
	.slv24_resp_id     (slv24_rid           ),
	.slv24_resp_valid  (slv24_rvalid        ),
	.slv24_connect     (slv24_connect       ),
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
	.slv25_resp_data   (slv25_read_data     ),
	.slv25_resp_id     (slv25_rid           ),
	.slv25_resp_valid  (slv25_rvalid        ),
	.slv25_connect     (slv25_connect       ),
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
	.slv26_resp_data   (slv26_read_data     ),
	.slv26_resp_id     (slv26_rid           ),
	.slv26_resp_valid  (slv26_rvalid        ),
	.slv26_connect     (slv26_connect       ),
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
	.slv27_resp_data   (slv27_read_data     ),
	.slv27_resp_id     (slv27_rid           ),
	.slv27_resp_valid  (slv27_rvalid        ),
	.slv27_connect     (slv27_connect       ),
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
	.slv28_resp_data   (slv28_read_data     ),
	.slv28_resp_id     (slv28_rid           ),
	.slv28_resp_valid  (slv28_rvalid        ),
	.slv28_connect     (slv28_connect       ),
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
	.slv29_resp_data   (slv29_read_data     ),
	.slv29_resp_id     (slv29_rid           ),
	.slv29_resp_valid  (slv29_rvalid        ),
	.slv29_connect     (slv29_connect       ),
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
	.slv30_resp_data   (slv30_read_data     ),
	.slv30_resp_id     (slv30_rid           ),
	.slv30_resp_valid  (slv30_rvalid        ),
	.slv30_connect     (slv30_connect       ),
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
	.slv31_resp_data   (slv31_read_data     ),
	.slv31_resp_id     (slv31_rid           ),
	.slv31_resp_valid  (slv31_rvalid        ),
	.slv31_connect     (slv31_connect       ),
`endif
	.mst_resp_slave_id (mst_rsid            ),
	.mst_resp_ready    (mst_rready          ),
	.dec_err_resp_id   (dec_err_rid         ),
	.dec_err_resp_data (dec_err_rd_resp_data),
	.dec_err_resp_valid(dec_err_rvalid      ),
	.dec_err_resp_ready(dec_err_rready      ),
	.outstanding_id    (ar_outstanding_id   ),
	.outstanding_en    (ar_outstanding_en   ),
	.outstanding_ready (ar_outstanding_ready),
	.outstanding_idle  (ar_outstanding_idle ),
	.resp_id           (us_rid              ),
	.resp_data         (s0        ),
	.resp_valid        (us_rvalid           ),
	.resp_ready        (us_rready           ),
	.aclk              (aclk                ),
	.aresetn           (aresetn             )
);

endmodule

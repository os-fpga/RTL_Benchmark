// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"

module atcbmc300_internal_slave (
`ifdef ATCBMC300_MST0_SUPPORT
	  mst0_awid,
	  mst0_awaddr,
	  mst0_awlen,
	  mst0_awsize,
	  mst0_awburst,
	  mst0_awvalid,
	  mst0_wvalid,
	  mst0_wsid,
	  mst0_wlast,
	  mst0_wdata,
	  mst0_wstrb,
	  mst0_bready,
	  mst0_bsid,
	  mst0_connect,
	  mst0_arid,
	  mst0_araddr,
	  mst0_arlen,
	  mst0_arsize,
	  mst0_arburst,
	  mst0_arvalid,
	  mst0_rready,
	  mst0_rsid,
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	  mst1_awid,
	  mst1_awaddr,
	  mst1_awlen,
	  mst1_awsize,
	  mst1_awburst,
	  mst1_awvalid,
	  mst1_wvalid,
	  mst1_wsid,
	  mst1_wlast,
	  mst1_wdata,
	  mst1_wstrb,
	  mst1_bready,
	  mst1_bsid,
	  mst1_connect,
	  mst1_arid,
	  mst1_araddr,
	  mst1_arlen,
	  mst1_arsize,
	  mst1_arburst,
	  mst1_arvalid,
	  mst1_rready,
	  mst1_rsid,
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	  mst2_awid,
	  mst2_awaddr,
	  mst2_awlen,
	  mst2_awsize,
	  mst2_awburst,
	  mst2_awvalid,
	  mst2_wvalid,
	  mst2_wsid,
	  mst2_wlast,
	  mst2_wdata,
	  mst2_wstrb,
	  mst2_bready,
	  mst2_bsid,
	  mst2_connect,
	  mst2_arid,
	  mst2_araddr,
	  mst2_arlen,
	  mst2_arsize,
	  mst2_arburst,
	  mst2_arvalid,
	  mst2_rready,
	  mst2_rsid,
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	  mst3_awid,
	  mst3_awaddr,
	  mst3_awlen,
	  mst3_awsize,
	  mst3_awburst,
	  mst3_awvalid,
	  mst3_wvalid,
	  mst3_wsid,
	  mst3_wlast,
	  mst3_wdata,
	  mst3_wstrb,
	  mst3_bready,
	  mst3_bsid,
	  mst3_connect,
	  mst3_arid,
	  mst3_araddr,
	  mst3_arlen,
	  mst3_arsize,
	  mst3_arburst,
	  mst3_arvalid,
	  mst3_rready,
	  mst3_rsid,
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	  mst4_awid,
	  mst4_awaddr,
	  mst4_awlen,
	  mst4_awsize,
	  mst4_awburst,
	  mst4_awvalid,
	  mst4_wvalid,
	  mst4_wsid,
	  mst4_wlast,
	  mst4_wdata,
	  mst4_wstrb,
	  mst4_bready,
	  mst4_bsid,
	  mst4_connect,
	  mst4_arid,
	  mst4_araddr,
	  mst4_arlen,
	  mst4_arsize,
	  mst4_arburst,
	  mst4_arvalid,
	  mst4_rready,
	  mst4_rsid,
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	  mst5_awid,
	  mst5_awaddr,
	  mst5_awlen,
	  mst5_awsize,
	  mst5_awburst,
	  mst5_awvalid,
	  mst5_wvalid,
	  mst5_wsid,
	  mst5_wlast,
	  mst5_wdata,
	  mst5_wstrb,
	  mst5_bready,
	  mst5_bsid,
	  mst5_connect,
	  mst5_arid,
	  mst5_araddr,
	  mst5_arlen,
	  mst5_arsize,
	  mst5_arburst,
	  mst5_arvalid,
	  mst5_rready,
	  mst5_rsid,
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	  mst6_awid,
	  mst6_awaddr,
	  mst6_awlen,
	  mst6_awsize,
	  mst6_awburst,
	  mst6_awvalid,
	  mst6_wvalid,
	  mst6_wsid,
	  mst6_wlast,
	  mst6_wdata,
	  mst6_wstrb,
	  mst6_bready,
	  mst6_bsid,
	  mst6_connect,
	  mst6_arid,
	  mst6_araddr,
	  mst6_arlen,
	  mst6_arsize,
	  mst6_arburst,
	  mst6_arvalid,
	  mst6_rready,
	  mst6_rsid,
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	  mst7_awid,
	  mst7_awaddr,
	  mst7_awlen,
	  mst7_awsize,
	  mst7_awburst,
	  mst7_awvalid,
	  mst7_wvalid,
	  mst7_wsid,
	  mst7_wlast,
	  mst7_wdata,
	  mst7_wstrb,
	  mst7_bready,
	  mst7_bsid,
	  mst7_connect,
	  mst7_arid,
	  mst7_araddr,
	  mst7_arlen,
	  mst7_arsize,
	  mst7_arburst,
	  mst7_arvalid,
	  mst7_rready,
	  mst7_rsid,
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	  mst8_awid,
	  mst8_awaddr,
	  mst8_awlen,
	  mst8_awsize,
	  mst8_awburst,
	  mst8_awvalid,
	  mst8_wvalid,
	  mst8_wsid,
	  mst8_wlast,
	  mst8_wdata,
	  mst8_wstrb,
	  mst8_bready,
	  mst8_bsid,
	  mst8_connect,
	  mst8_arid,
	  mst8_araddr,
	  mst8_arlen,
	  mst8_arsize,
	  mst8_arburst,
	  mst8_arvalid,
	  mst8_rready,
	  mst8_rsid,
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	  mst9_awid,
	  mst9_awaddr,
	  mst9_awlen,
	  mst9_awsize,
	  mst9_awburst,
	  mst9_awvalid,
	  mst9_wvalid,
	  mst9_wsid,
	  mst9_wlast,
	  mst9_wdata,
	  mst9_wstrb,
	  mst9_bready,
	  mst9_bsid,
	  mst9_connect,
	  mst9_arid,
	  mst9_araddr,
	  mst9_arlen,
	  mst9_arsize,
	  mst9_arburst,
	  mst9_arvalid,
	  mst9_rready,
	  mst9_rsid,
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	  mst10_awid,
	  mst10_awaddr,
	  mst10_awlen,
	  mst10_awsize,
	  mst10_awburst,
	  mst10_awvalid,
	  mst10_wvalid,
	  mst10_wsid,
	  mst10_wlast,
	  mst10_wdata,
	  mst10_wstrb,
	  mst10_bready,
	  mst10_bsid,
	  mst10_connect,
	  mst10_arid,
	  mst10_araddr,
	  mst10_arlen,
	  mst10_arsize,
	  mst10_arburst,
	  mst10_arvalid,
	  mst10_rready,
	  mst10_rsid,
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	  mst11_awid,
	  mst11_awaddr,
	  mst11_awlen,
	  mst11_awsize,
	  mst11_awburst,
	  mst11_awvalid,
	  mst11_wvalid,
	  mst11_wsid,
	  mst11_wlast,
	  mst11_wdata,
	  mst11_wstrb,
	  mst11_bready,
	  mst11_bsid,
	  mst11_connect,
	  mst11_arid,
	  mst11_araddr,
	  mst11_arlen,
	  mst11_arsize,
	  mst11_arburst,
	  mst11_arvalid,
	  mst11_rready,
	  mst11_rsid,
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	  mst12_awid,
	  mst12_awaddr,
	  mst12_awlen,
	  mst12_awsize,
	  mst12_awburst,
	  mst12_awvalid,
	  mst12_wvalid,
	  mst12_wsid,
	  mst12_wlast,
	  mst12_wdata,
	  mst12_wstrb,
	  mst12_bready,
	  mst12_bsid,
	  mst12_connect,
	  mst12_arid,
	  mst12_araddr,
	  mst12_arlen,
	  mst12_arsize,
	  mst12_arburst,
	  mst12_arvalid,
	  mst12_rready,
	  mst12_rsid,
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	  mst13_awid,
	  mst13_awaddr,
	  mst13_awlen,
	  mst13_awsize,
	  mst13_awburst,
	  mst13_awvalid,
	  mst13_wvalid,
	  mst13_wsid,
	  mst13_wlast,
	  mst13_wdata,
	  mst13_wstrb,
	  mst13_bready,
	  mst13_bsid,
	  mst13_connect,
	  mst13_arid,
	  mst13_araddr,
	  mst13_arlen,
	  mst13_arsize,
	  mst13_arburst,
	  mst13_arvalid,
	  mst13_rready,
	  mst13_rsid,
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	  mst14_awid,
	  mst14_awaddr,
	  mst14_awlen,
	  mst14_awsize,
	  mst14_awburst,
	  mst14_awvalid,
	  mst14_wvalid,
	  mst14_wsid,
	  mst14_wlast,
	  mst14_wdata,
	  mst14_wstrb,
	  mst14_bready,
	  mst14_bsid,
	  mst14_connect,
	  mst14_arid,
	  mst14_araddr,
	  mst14_arlen,
	  mst14_arsize,
	  mst14_arburst,
	  mst14_arvalid,
	  mst14_rready,
	  mst14_rsid,
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	  mst15_awid,
	  mst15_awaddr,
	  mst15_awlen,
	  mst15_awsize,
	  mst15_awburst,
	  mst15_awvalid,
	  mst15_wvalid,
	  mst15_wsid,
	  mst15_wlast,
	  mst15_wdata,
	  mst15_wstrb,
	  mst15_bready,
	  mst15_bsid,
	  mst15_connect,
	  mst15_arid,
	  mst15_araddr,
	  mst15_arlen,
	  mst15_arsize,
	  mst15_arburst,
	  mst15_arvalid,
	  mst15_rready,
	  mst15_rsid,
`endif
`ifdef ATCBMC300_SLV0_SUPPORT
	  slv0_base_addr,
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
	  slv1_base_addr,
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
	  slv2_base_addr,
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
	  slv3_base_addr,
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
	  slv4_base_addr,
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
	  slv5_base_addr,
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
	  slv6_base_addr,
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
	  slv7_base_addr,
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
	  slv8_base_addr,
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
	  slv9_base_addr,
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
	  slv10_base_addr,
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
	  slv11_base_addr,
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
	  slv12_base_addr,
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
	  slv13_base_addr,
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
	  slv14_base_addr,
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
	  slv15_base_addr,
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
	  slv16_base_addr,
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
	  slv17_base_addr,
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
	  slv18_base_addr,
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
	  slv19_base_addr,
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
	  slv20_base_addr,
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
	  slv21_base_addr,
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
	  slv22_base_addr,
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
	  slv23_base_addr,
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
	  slv24_base_addr,
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
	  slv25_base_addr,
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
	  slv26_base_addr,
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
	  slv27_base_addr,
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
	  slv28_base_addr,
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
	  slv29_base_addr,
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
	  slv30_base_addr,
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
	  slv31_base_addr,
`endif
	  slv0_rid,
	  slv0_read_data,
	  slv0_rvalid,
	  slv0_bid,
	  slv0_bresp,
	  slv0_bvalid,
	  slv0_wready,
	  slv0_wmid,
	  slv0_arready,
	  slv0_awready,
	  slv0_ar_mid,
	  slv0_aw_mid,
	  reg_mst0_high_priority,
	  reg_priority_reload,
	  aclk,
	  aresetn
);
parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 64;
parameter ID_WIDTH   = 4;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam ID_MSB   = ID_WIDTH - 1;

localparam SELF_ID = 5'h0;
localparam MULTIPLE_WR_DATA = 256/DATA_WIDTH;

`ifdef ATCBMC300_MST0_SUPPORT
input [ID_MSB:0]   		mst0_awid;
input [19:0] 			mst0_awaddr;
input [3:0]        		mst0_awlen;
input [2:0]        		mst0_awsize;
input [1:0]        		mst0_awburst;
input 	        		mst0_awvalid;
input              		mst0_wvalid;
input [4:0]                	mst0_wsid;
input              		mst0_wlast;
input [DATA_MSB:0]         	mst0_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst0_wstrb;
input				mst0_bready;
input [4:0]                	mst0_bsid;
input 			    	mst0_connect;

input [ID_MSB:0]   		mst0_arid;
input [ADDR_MSB:0] 		mst0_araddr;
input [7:0]        		mst0_arlen;
input [2:0]        		mst0_arsize;
input [1:0]        		mst0_arburst;
input 	        		mst0_arvalid;
input				mst0_rready;
input [4:0]                	mst0_rsid;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
input [ID_MSB:0]   		mst1_awid;
input [19:0] 			mst1_awaddr;
input [3:0]        		mst1_awlen;
input [2:0]        		mst1_awsize;
input [1:0]        		mst1_awburst;
input 	        		mst1_awvalid;
input              		mst1_wvalid;
input [4:0]                	mst1_wsid;
input              		mst1_wlast;
input [DATA_MSB:0]         	mst1_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst1_wstrb;
input				mst1_bready;
input [4:0]                	mst1_bsid;
input 			    	mst1_connect;

input [ID_MSB:0]   		mst1_arid;
input [ADDR_MSB:0] 		mst1_araddr;
input [7:0]        		mst1_arlen;
input [2:0]        		mst1_arsize;
input [1:0]        		mst1_arburst;
input 	        		mst1_arvalid;
input				mst1_rready;
input [4:0]                	mst1_rsid;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
input [ID_MSB:0]   		mst2_awid;
input [19:0] 			mst2_awaddr;
input [3:0]        		mst2_awlen;
input [2:0]        		mst2_awsize;
input [1:0]        		mst2_awburst;
input 	        		mst2_awvalid;
input              		mst2_wvalid;
input [4:0]                	mst2_wsid;
input              		mst2_wlast;
input [DATA_MSB:0]         	mst2_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst2_wstrb;
input				mst2_bready;
input [4:0]                	mst2_bsid;
input 			    	mst2_connect;

input [ID_MSB:0]   		mst2_arid;
input [ADDR_MSB:0] 		mst2_araddr;
input [7:0]        		mst2_arlen;
input [2:0]        		mst2_arsize;
input [1:0]        		mst2_arburst;
input 	        		mst2_arvalid;
input				mst2_rready;
input [4:0]                	mst2_rsid;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
input [ID_MSB:0]   		mst3_awid;
input [19:0] 			mst3_awaddr;
input [3:0]        		mst3_awlen;
input [2:0]        		mst3_awsize;
input [1:0]        		mst3_awburst;
input 	        		mst3_awvalid;
input              		mst3_wvalid;
input [4:0]                	mst3_wsid;
input              		mst3_wlast;
input [DATA_MSB:0]         	mst3_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst3_wstrb;
input				mst3_bready;
input [4:0]                	mst3_bsid;
input 			    	mst3_connect;

input [ID_MSB:0]   		mst3_arid;
input [ADDR_MSB:0] 		mst3_araddr;
input [7:0]        		mst3_arlen;
input [2:0]        		mst3_arsize;
input [1:0]        		mst3_arburst;
input 	        		mst3_arvalid;
input				mst3_rready;
input [4:0]                	mst3_rsid;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
input [ID_MSB:0]   		mst4_awid;
input [19:0] 			mst4_awaddr;
input [3:0]        		mst4_awlen;
input [2:0]        		mst4_awsize;
input [1:0]        		mst4_awburst;
input 	        		mst4_awvalid;
input              		mst4_wvalid;
input [4:0]                	mst4_wsid;
input              		mst4_wlast;
input [DATA_MSB:0]         	mst4_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst4_wstrb;
input				mst4_bready;
input [4:0]                	mst4_bsid;
input 			    	mst4_connect;

input [ID_MSB:0]   		mst4_arid;
input [ADDR_MSB:0] 		mst4_araddr;
input [7:0]        		mst4_arlen;
input [2:0]        		mst4_arsize;
input [1:0]        		mst4_arburst;
input 	        		mst4_arvalid;
input				mst4_rready;
input [4:0]                	mst4_rsid;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
input [ID_MSB:0]   		mst5_awid;
input [19:0] 			mst5_awaddr;
input [3:0]        		mst5_awlen;
input [2:0]        		mst5_awsize;
input [1:0]        		mst5_awburst;
input 	        		mst5_awvalid;
input              		mst5_wvalid;
input [4:0]                	mst5_wsid;
input              		mst5_wlast;
input [DATA_MSB:0]         	mst5_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst5_wstrb;
input				mst5_bready;
input [4:0]                	mst5_bsid;
input 			    	mst5_connect;

input [ID_MSB:0]   		mst5_arid;
input [ADDR_MSB:0] 		mst5_araddr;
input [7:0]        		mst5_arlen;
input [2:0]        		mst5_arsize;
input [1:0]        		mst5_arburst;
input 	        		mst5_arvalid;
input				mst5_rready;
input [4:0]                	mst5_rsid;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
input [ID_MSB:0]   		mst6_awid;
input [19:0] 			mst6_awaddr;
input [3:0]        		mst6_awlen;
input [2:0]        		mst6_awsize;
input [1:0]        		mst6_awburst;
input 	        		mst6_awvalid;
input              		mst6_wvalid;
input [4:0]                	mst6_wsid;
input              		mst6_wlast;
input [DATA_MSB:0]         	mst6_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst6_wstrb;
input				mst6_bready;
input [4:0]                	mst6_bsid;
input 			    	mst6_connect;

input [ID_MSB:0]   		mst6_arid;
input [ADDR_MSB:0] 		mst6_araddr;
input [7:0]        		mst6_arlen;
input [2:0]        		mst6_arsize;
input [1:0]        		mst6_arburst;
input 	        		mst6_arvalid;
input				mst6_rready;
input [4:0]                	mst6_rsid;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
input [ID_MSB:0]   		mst7_awid;
input [19:0] 			mst7_awaddr;
input [3:0]        		mst7_awlen;
input [2:0]        		mst7_awsize;
input [1:0]        		mst7_awburst;
input 	        		mst7_awvalid;
input              		mst7_wvalid;
input [4:0]                	mst7_wsid;
input              		mst7_wlast;
input [DATA_MSB:0]         	mst7_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst7_wstrb;
input				mst7_bready;
input [4:0]                	mst7_bsid;
input 			    	mst7_connect;

input [ID_MSB:0]   		mst7_arid;
input [ADDR_MSB:0] 		mst7_araddr;
input [7:0]        		mst7_arlen;
input [2:0]        		mst7_arsize;
input [1:0]        		mst7_arburst;
input 	        		mst7_arvalid;
input				mst7_rready;
input [4:0]                	mst7_rsid;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
input [ID_MSB:0]   		mst8_awid;
input [19:0] 			mst8_awaddr;
input [3:0]        		mst8_awlen;
input [2:0]        		mst8_awsize;
input [1:0]        		mst8_awburst;
input 	        		mst8_awvalid;
input              		mst8_wvalid;
input [4:0]                	mst8_wsid;
input              		mst8_wlast;
input [DATA_MSB:0]         	mst8_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst8_wstrb;
input				mst8_bready;
input [4:0]                	mst8_bsid;
input 			    	mst8_connect;

input [ID_MSB:0]   		mst8_arid;
input [ADDR_MSB:0] 		mst8_araddr;
input [7:0]        		mst8_arlen;
input [2:0]        		mst8_arsize;
input [1:0]        		mst8_arburst;
input 	        		mst8_arvalid;
input				mst8_rready;
input [4:0]                	mst8_rsid;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
input [ID_MSB:0]   		mst9_awid;
input [19:0] 			mst9_awaddr;
input [3:0]        		mst9_awlen;
input [2:0]        		mst9_awsize;
input [1:0]        		mst9_awburst;
input 	        		mst9_awvalid;
input              		mst9_wvalid;
input [4:0]                	mst9_wsid;
input              		mst9_wlast;
input [DATA_MSB:0]         	mst9_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst9_wstrb;
input				mst9_bready;
input [4:0]                	mst9_bsid;
input 			    	mst9_connect;

input [ID_MSB:0]   		mst9_arid;
input [ADDR_MSB:0] 		mst9_araddr;
input [7:0]        		mst9_arlen;
input [2:0]        		mst9_arsize;
input [1:0]        		mst9_arburst;
input 	        		mst9_arvalid;
input				mst9_rready;
input [4:0]                	mst9_rsid;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
input [ID_MSB:0]   		mst10_awid;
input [19:0] 			mst10_awaddr;
input [3:0]        		mst10_awlen;
input [2:0]        		mst10_awsize;
input [1:0]        		mst10_awburst;
input 	        		mst10_awvalid;
input              		mst10_wvalid;
input [4:0]                	mst10_wsid;
input              		mst10_wlast;
input [DATA_MSB:0]         	mst10_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst10_wstrb;
input				mst10_bready;
input [4:0]                	mst10_bsid;
input 			    	mst10_connect;

input [ID_MSB:0]   		mst10_arid;
input [ADDR_MSB:0] 		mst10_araddr;
input [7:0]        		mst10_arlen;
input [2:0]        		mst10_arsize;
input [1:0]        		mst10_arburst;
input 	        		mst10_arvalid;
input				mst10_rready;
input [4:0]                	mst10_rsid;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
input [ID_MSB:0]   		mst11_awid;
input [19:0] 			mst11_awaddr;
input [3:0]        		mst11_awlen;
input [2:0]        		mst11_awsize;
input [1:0]        		mst11_awburst;
input 	        		mst11_awvalid;
input              		mst11_wvalid;
input [4:0]                	mst11_wsid;
input              		mst11_wlast;
input [DATA_MSB:0]         	mst11_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst11_wstrb;
input				mst11_bready;
input [4:0]                	mst11_bsid;
input 			    	mst11_connect;

input [ID_MSB:0]   		mst11_arid;
input [ADDR_MSB:0] 		mst11_araddr;
input [7:0]        		mst11_arlen;
input [2:0]        		mst11_arsize;
input [1:0]        		mst11_arburst;
input 	        		mst11_arvalid;
input				mst11_rready;
input [4:0]                	mst11_rsid;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
input [ID_MSB:0]   		mst12_awid;
input [19:0] 			mst12_awaddr;
input [3:0]        		mst12_awlen;
input [2:0]        		mst12_awsize;
input [1:0]        		mst12_awburst;
input 	        		mst12_awvalid;
input              		mst12_wvalid;
input [4:0]                	mst12_wsid;
input              		mst12_wlast;
input [DATA_MSB:0]         	mst12_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst12_wstrb;
input				mst12_bready;
input [4:0]                	mst12_bsid;
input 			    	mst12_connect;

input [ID_MSB:0]   		mst12_arid;
input [ADDR_MSB:0] 		mst12_araddr;
input [7:0]        		mst12_arlen;
input [2:0]        		mst12_arsize;
input [1:0]        		mst12_arburst;
input 	        		mst12_arvalid;
input				mst12_rready;
input [4:0]                	mst12_rsid;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
input [ID_MSB:0]   		mst13_awid;
input [19:0] 			mst13_awaddr;
input [3:0]        		mst13_awlen;
input [2:0]        		mst13_awsize;
input [1:0]        		mst13_awburst;
input 	        		mst13_awvalid;
input              		mst13_wvalid;
input [4:0]                	mst13_wsid;
input              		mst13_wlast;
input [DATA_MSB:0]         	mst13_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst13_wstrb;
input				mst13_bready;
input [4:0]                	mst13_bsid;
input 			    	mst13_connect;

input [ID_MSB:0]   		mst13_arid;
input [ADDR_MSB:0] 		mst13_araddr;
input [7:0]        		mst13_arlen;
input [2:0]        		mst13_arsize;
input [1:0]        		mst13_arburst;
input 	        		mst13_arvalid;
input				mst13_rready;
input [4:0]                	mst13_rsid;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
input [ID_MSB:0]   		mst14_awid;
input [19:0] 			mst14_awaddr;
input [3:0]        		mst14_awlen;
input [2:0]        		mst14_awsize;
input [1:0]        		mst14_awburst;
input 	        		mst14_awvalid;
input              		mst14_wvalid;
input [4:0]                	mst14_wsid;
input              		mst14_wlast;
input [DATA_MSB:0]         	mst14_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst14_wstrb;
input				mst14_bready;
input [4:0]                	mst14_bsid;
input 			    	mst14_connect;

input [ID_MSB:0]   		mst14_arid;
input [ADDR_MSB:0] 		mst14_araddr;
input [7:0]        		mst14_arlen;
input [2:0]        		mst14_arsize;
input [1:0]        		mst14_arburst;
input 	        		mst14_arvalid;
input				mst14_rready;
input [4:0]                	mst14_rsid;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
input [ID_MSB:0]   		mst15_awid;
input [19:0] 			mst15_awaddr;
input [3:0]        		mst15_awlen;
input [2:0]        		mst15_awsize;
input [1:0]        		mst15_awburst;
input 	        		mst15_awvalid;
input              		mst15_wvalid;
input [4:0]                	mst15_wsid;
input              		mst15_wlast;
input [DATA_MSB:0]         	mst15_wdata;
input [(DATA_WIDTH/8)-1:0] 	mst15_wstrb;
input				mst15_bready;
input [4:0]                	mst15_bsid;
input 			    	mst15_connect;

input [ID_MSB:0]   		mst15_arid;
input [ADDR_MSB:0] 		mst15_araddr;
input [7:0]        		mst15_arlen;
input [2:0]        		mst15_arsize;
input [1:0]        		mst15_arburst;
input 	        		mst15_arvalid;
input				mst15_rready;
input [4:0]                	mst15_rsid;
`endif
`ifdef ATCBMC300_SLV0_SUPPORT
input [63:20]	slv0_base_addr;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
input [63:20]	slv1_base_addr;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
input [63:20]	slv2_base_addr;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
input [63:20]	slv3_base_addr;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
input [63:20]	slv4_base_addr;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
input [63:20]	slv5_base_addr;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
input [63:20]	slv6_base_addr;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
input [63:20]	slv7_base_addr;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
input [63:20]	slv8_base_addr;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
input [63:20]	slv9_base_addr;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
input [63:20]	slv10_base_addr;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
input [63:20]	slv11_base_addr;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
input [63:20]	slv12_base_addr;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
input [63:20]	slv13_base_addr;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
input [63:20]	slv14_base_addr;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
input [63:20]	slv15_base_addr;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
input [63:20]	slv16_base_addr;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
input [63:20]	slv17_base_addr;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
input [63:20]	slv18_base_addr;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
input [63:20]	slv19_base_addr;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
input [63:20]	slv20_base_addr;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
input [63:20]	slv21_base_addr;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
input [63:20]	slv22_base_addr;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
input [63:20]	slv23_base_addr;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
input [63:20]	slv24_base_addr;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
input [63:20]	slv25_base_addr;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
input [63:20]	slv26_base_addr;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
input [63:20]	slv27_base_addr;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
input [63:20]	slv28_base_addr;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
input [63:20]	slv29_base_addr;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
input [63:20]	slv30_base_addr;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
input [63:20]	slv31_base_addr;
`endif
output [(ID_MSB+4):0] slv0_rid;
output [(DATA_MSB+3):0] slv0_read_data;
output 	     	    slv0_rvalid;

output [ID_MSB+4:0] slv0_bid;
output [1:0] 	    slv0_bresp;
output 	     	    slv0_bvalid;

output	     	    slv0_wready;
output [3:0] 	    slv0_wmid;

output	     	    slv0_arready;
output	     	    slv0_awready;
output [3:0]	    slv0_ar_mid;
output [3:0]	    slv0_aw_mid;

output              reg_mst0_high_priority;
output [15:0]       reg_priority_reload;

input aclk;
input aresetn;

localparam ARRDY = 3'h0;
localparam  RVLD = 3'h1;
localparam AWRDY = 3'h2;
localparam  WRDY = 3'h3;
localparam  BVLD = 3'h4;
localparam AXI_INCR = 2'b01;
localparam AXI_WRAP = 2'b10;

reg [ADDR_MSB:0] s0;
reg [3:0]        s1;
reg [2:0]        s2;
reg [1:0]        s3;
reg [ID_MSB:0] 	 s4;
reg [7:0]        s5;
reg [3:0] 	 s6;
reg [19:0] 	 s7;
reg [3:0]        s8;
reg [2:0]        s9;
reg [1:0]        s10;
reg [ID_MSB:0] 	 s11;
reg [3:0] 	 s12;
reg [ADDR_MSB:0] s13  [0:15];
reg [7:0]        s14   [0:15];
reg [2:0]        s15  [0:15];
reg [1:0]        s16 [0:15];
reg [ID_MSB:0]   s17    [0:15];
reg [15:0]	 s18;
reg [19:0] 	 s19  [0:15];
reg [3:0]        s20   [0:15];
reg [2:0]        s21  [0:15];
reg [1:0]        s22 [0:15];
reg [ID_MSB:0]   s23    [0:15];
reg [15:0]	 s24;
reg [DATA_MSB:0] 	   s25 [0:15];
reg [(DATA_WIDTH/8)-1:0] s26 [0:15];
reg [15:0]	 s27;
reg [15:0]	 s28;
reg [15:0]	 s29;
reg [15:0]	 s30;
reg 		 s31;
reg [DATA_MSB:0] s32;
reg 		 slv0_rvalid;
reg 		 slv0_wready;
reg 		 slv0_bvalid;
reg [63:0]	 s33 [0:31];
wire              reg_mst0_high_priority;
wire [15:0]       reg_priority_reload;
wire [15:0]       s34;
wire [15:0]       s35;
reg [255:0] 	 s36;
reg [63:0] s37[0:3];
wire [7:0]      s38;
wire [15:0]     s39;
wire [15:0]     s40;
wire 		s41;
wire 		s42;
wire		s43;
wire		s44;
wire [3:0]      s45;
wire [3:0]      s46;
wire 		s47;
wire     	s48;
wire s49;
wire s50;
assign s49 = s34!=16'h0;
assign s50 = s35!=16'h0;

`ifdef ATCBMC300_MST0_SUPPORT
reg s51;
assign s34[0] = s51;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s51 <= 1'b0;
	else
		s51 <= mst0_connect & ~((s45==4'd0) & slv0_arready) &
					   ((~s49 & mst0_arvalid & reg_priority_reload[0]) | s51);
end
reg s52;
assign s35[0] = s52;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s52 <= 1'b0;
	else
		s52 <= mst0_connect & ~((s46==4'd0) & slv0_awready) &
					   ((~s50 & mst0_awvalid & reg_priority_reload[0]) | s52);
end
`else
assign s34[0] = 1'b0;
assign s35[0] = 1'b0;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
reg s53;
assign s34[1] = s53;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s53 <= 1'b0;
	else
		s53 <= mst1_connect & ~((s45==4'd1) & slv0_arready) &
					   ((~s49 & mst1_arvalid & reg_priority_reload[1]) | s53);
end
reg s54;
assign s35[1] = s54;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s54 <= 1'b0;
	else
		s54 <= mst1_connect & ~((s46==4'd1) & slv0_awready) &
					   ((~s50 & mst1_awvalid & reg_priority_reload[1]) | s54);
end
`else
assign s34[1] = 1'b0;
assign s35[1] = 1'b0;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
reg s55;
assign s34[2] = s55;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s55 <= 1'b0;
	else
		s55 <= mst2_connect & ~((s45==4'd2) & slv0_arready) &
					   ((~s49 & mst2_arvalid & reg_priority_reload[2]) | s55);
end
reg s56;
assign s35[2] = s56;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s56 <= 1'b0;
	else
		s56 <= mst2_connect & ~((s46==4'd2) & slv0_awready) &
					   ((~s50 & mst2_awvalid & reg_priority_reload[2]) | s56);
end
`else
assign s34[2] = 1'b0;
assign s35[2] = 1'b0;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
reg s57;
assign s34[3] = s57;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s57 <= 1'b0;
	else
		s57 <= mst3_connect & ~((s45==4'd3) & slv0_arready) &
					   ((~s49 & mst3_arvalid & reg_priority_reload[3]) | s57);
end
reg s58;
assign s35[3] = s58;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s58 <= 1'b0;
	else
		s58 <= mst3_connect & ~((s46==4'd3) & slv0_awready) &
					   ((~s50 & mst3_awvalid & reg_priority_reload[3]) | s58);
end
`else
assign s34[3] = 1'b0;
assign s35[3] = 1'b0;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
reg s59;
assign s34[4] = s59;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s59 <= 1'b0;
	else
		s59 <= mst4_connect & ~((s45==4'd4) & slv0_arready) &
					   ((~s49 & mst4_arvalid & reg_priority_reload[4]) | s59);
end
reg s60;
assign s35[4] = s60;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s60 <= 1'b0;
	else
		s60 <= mst4_connect & ~((s46==4'd4) & slv0_awready) &
					   ((~s50 & mst4_awvalid & reg_priority_reload[4]) | s60);
end
`else
assign s34[4] = 1'b0;
assign s35[4] = 1'b0;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
reg s61;
assign s34[5] = s61;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s61 <= 1'b0;
	else
		s61 <= mst5_connect & ~((s45==4'd5) & slv0_arready) &
					   ((~s49 & mst5_arvalid & reg_priority_reload[5]) | s61);
end
reg s62;
assign s35[5] = s62;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s62 <= 1'b0;
	else
		s62 <= mst5_connect & ~((s46==4'd5) & slv0_awready) &
					   ((~s50 & mst5_awvalid & reg_priority_reload[5]) | s62);
end
`else
assign s34[5] = 1'b0;
assign s35[5] = 1'b0;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
reg s63;
assign s34[6] = s63;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s63 <= 1'b0;
	else
		s63 <= mst6_connect & ~((s45==4'd6) & slv0_arready) &
					   ((~s49 & mst6_arvalid & reg_priority_reload[6]) | s63);
end
reg s64;
assign s35[6] = s64;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s64 <= 1'b0;
	else
		s64 <= mst6_connect & ~((s46==4'd6) & slv0_awready) &
					   ((~s50 & mst6_awvalid & reg_priority_reload[6]) | s64);
end
`else
assign s34[6] = 1'b0;
assign s35[6] = 1'b0;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
reg s65;
assign s34[7] = s65;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s65 <= 1'b0;
	else
		s65 <= mst7_connect & ~((s45==4'd7) & slv0_arready) &
					   ((~s49 & mst7_arvalid & reg_priority_reload[7]) | s65);
end
reg s66;
assign s35[7] = s66;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s66 <= 1'b0;
	else
		s66 <= mst7_connect & ~((s46==4'd7) & slv0_awready) &
					   ((~s50 & mst7_awvalid & reg_priority_reload[7]) | s66);
end
`else
assign s34[7] = 1'b0;
assign s35[7] = 1'b0;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
reg s67;
assign s34[8] = s67;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s67 <= 1'b0;
	else
		s67 <= mst8_connect & ~((s45==4'd8) & slv0_arready) &
					   ((~s49 & mst8_arvalid & reg_priority_reload[8]) | s67);
end
reg s68;
assign s35[8] = s68;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s68 <= 1'b0;
	else
		s68 <= mst8_connect & ~((s46==4'd8) & slv0_awready) &
					   ((~s50 & mst8_awvalid & reg_priority_reload[8]) | s68);
end
`else
assign s34[8] = 1'b0;
assign s35[8] = 1'b0;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
reg s69;
assign s34[9] = s69;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s69 <= 1'b0;
	else
		s69 <= mst9_connect & ~((s45==4'd9) & slv0_arready) &
					   ((~s49 & mst9_arvalid & reg_priority_reload[9]) | s69);
end
reg s70;
assign s35[9] = s70;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s70 <= 1'b0;
	else
		s70 <= mst9_connect & ~((s46==4'd9) & slv0_awready) &
					   ((~s50 & mst9_awvalid & reg_priority_reload[9]) | s70);
end
`else
assign s34[9] = 1'b0;
assign s35[9] = 1'b0;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
reg s71;
assign s34[10] = s71;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s71 <= 1'b0;
	else
		s71 <= mst10_connect & ~((s45==4'd10) & slv0_arready) &
					   ((~s49 & mst10_arvalid & reg_priority_reload[10]) | s71);
end
reg s72;
assign s35[10] = s72;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s72 <= 1'b0;
	else
		s72 <= mst10_connect & ~((s46==4'd10) & slv0_awready) &
					   ((~s50 & mst10_awvalid & reg_priority_reload[10]) | s72);
end
`else
assign s34[10] = 1'b0;
assign s35[10] = 1'b0;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
reg s73;
assign s34[11] = s73;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s73 <= 1'b0;
	else
		s73 <= mst11_connect & ~((s45==4'd11) & slv0_arready) &
					   ((~s49 & mst11_arvalid & reg_priority_reload[11]) | s73);
end
reg s74;
assign s35[11] = s74;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s74 <= 1'b0;
	else
		s74 <= mst11_connect & ~((s46==4'd11) & slv0_awready) &
					   ((~s50 & mst11_awvalid & reg_priority_reload[11]) | s74);
end
`else
assign s34[11] = 1'b0;
assign s35[11] = 1'b0;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
reg s75;
assign s34[12] = s75;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s75 <= 1'b0;
	else
		s75 <= mst12_connect & ~((s45==4'd12) & slv0_arready) &
					   ((~s49 & mst12_arvalid & reg_priority_reload[12]) | s75);
end
reg s76;
assign s35[12] = s76;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s76 <= 1'b0;
	else
		s76 <= mst12_connect & ~((s46==4'd12) & slv0_awready) &
					   ((~s50 & mst12_awvalid & reg_priority_reload[12]) | s76);
end
`else
assign s34[12] = 1'b0;
assign s35[12] = 1'b0;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
reg s77;
assign s34[13] = s77;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s77 <= 1'b0;
	else
		s77 <= mst13_connect & ~((s45==4'd13) & slv0_arready) &
					   ((~s49 & mst13_arvalid & reg_priority_reload[13]) | s77);
end
reg s78;
assign s35[13] = s78;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s78 <= 1'b0;
	else
		s78 <= mst13_connect & ~((s46==4'd13) & slv0_awready) &
					   ((~s50 & mst13_awvalid & reg_priority_reload[13]) | s78);
end
`else
assign s34[13] = 1'b0;
assign s35[13] = 1'b0;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
reg s79;
assign s34[14] = s79;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s79 <= 1'b0;
	else
		s79 <= mst14_connect & ~((s45==4'd14) & slv0_arready) &
					   ((~s49 & mst14_arvalid & reg_priority_reload[14]) | s79);
end
reg s80;
assign s35[14] = s80;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s80 <= 1'b0;
	else
		s80 <= mst14_connect & ~((s46==4'd14) & slv0_awready) &
					   ((~s50 & mst14_awvalid & reg_priority_reload[14]) | s80);
end
`else
assign s34[14] = 1'b0;
assign s35[14] = 1'b0;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
reg s81;
assign s34[15] = s81;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s81 <= 1'b0;
	else
		s81 <= mst15_connect & ~((s45==4'd15) & slv0_arready) &
					   ((~s49 & mst15_arvalid & reg_priority_reload[15]) | s81);
end
reg s82;
assign s35[15] = s82;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s82 <= 1'b0;
	else
		s82 <= mst15_connect & ~((s46==4'd15) & slv0_awready) &
					   ((~s50 & mst15_awvalid & reg_priority_reload[15]) | s82);
end
`else
assign s34[15] = 1'b0;
assign s35[15] = 1'b0;
`endif
always @* begin
`ifdef ATCBMC300_MST0_SUPPORT
	s13  [0] = mst0_araddr  & {ADDR_WIDTH{mst0_connect}};
	s14   [0] = mst0_arlen   & {8{mst0_connect}};
	s15  [0] = mst0_arsize  & {3{mst0_connect}};
	s16 [0] = mst0_arburst & {2{mst0_connect}};
	s17    [0] = mst0_arid    & {ID_WIDTH{mst0_connect}};
	s18 [0] = mst0_arvalid & mst0_connect;
	s19  [0] = mst0_awaddr  & {20{mst0_connect}};
	s20   [0] = mst0_awlen   & {4{mst0_connect}};
	s21  [0] = mst0_awsize  & {3{mst0_connect}};
	s22 [0] = mst0_awburst & {2{mst0_connect}};
	s23    [0] = mst0_awid    & {ID_WIDTH{mst0_connect}};
	s24 [0] = mst0_awvalid & mst0_connect;
	s27  [0] = mst0_wvalid & mst0_connect & (mst0_wsid==SELF_ID);
	s28 [0]  = mst0_wlast  & mst0_connect;
	s25 [0] = mst0_wdata  & {DATA_WIDTH{mst0_connect}};
	s26 [0] = mst0_wstrb  & {(DATA_WIDTH/8){s27[0] & slv0_wready}};
	s29[0] = mst0_bready & mst0_connect & (mst0_bsid==SELF_ID);
	s30[0] = mst0_rready & mst0_connect & (mst0_rsid==SELF_ID);
`else
	s13  [0] = {ADDR_WIDTH{1'b0}};
	s14   [0] = {8{1'b0}};
	s15  [0] = {3{1'b0}};
	s16 [0] = {2{1'b0}};
	s17    [0] = {ID_WIDTH{1'b0}};
	s18 [0] = 1'b0;
	s19  [0] = {20{1'b0}};
	s20   [0] = {4{1'b0}};
	s21  [0] = {3{1'b0}};
	s22 [0] = {2{1'b0}};
	s23    [0] = {ID_WIDTH{1'b0}};
	s24 [0] = 1'b0;
	s25 [0] = {DATA_WIDTH{1'b0}};
	s26 [0] = {(DATA_WIDTH/8){1'b0}};
	s28 [0] = 1'b0;
	s27[0] = 1'b0;
	s29[0] = 1'b0;
	s30[0] = 1'b0;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	s13  [1] = mst1_araddr  & {ADDR_WIDTH{mst1_connect}};
	s14   [1] = mst1_arlen   & {8{mst1_connect}};
	s15  [1] = mst1_arsize  & {3{mst1_connect}};
	s16 [1] = mst1_arburst & {2{mst1_connect}};
	s17    [1] = mst1_arid    & {ID_WIDTH{mst1_connect}};
	s18 [1] = mst1_arvalid & mst1_connect;
	s19  [1] = mst1_awaddr  & {20{mst1_connect}};
	s20   [1] = mst1_awlen   & {4{mst1_connect}};
	s21  [1] = mst1_awsize  & {3{mst1_connect}};
	s22 [1] = mst1_awburst & {2{mst1_connect}};
	s23    [1] = mst1_awid    & {ID_WIDTH{mst1_connect}};
	s24 [1] = mst1_awvalid & mst1_connect;
	s27  [1] = mst1_wvalid & mst1_connect & (mst1_wsid==SELF_ID);
	s28 [1]  = mst1_wlast  & mst1_connect;
	s25 [1] = mst1_wdata  & {DATA_WIDTH{mst1_connect}};
	s26 [1] = mst1_wstrb  & {(DATA_WIDTH/8){s27[1] & slv0_wready}};
	s29[1] = mst1_bready & mst1_connect & (mst1_bsid==SELF_ID);
	s30[1] = mst1_rready & mst1_connect & (mst1_rsid==SELF_ID);
`else
	s13  [1] = {ADDR_WIDTH{1'b0}};
	s14   [1] = {8{1'b0}};
	s15  [1] = {3{1'b0}};
	s16 [1] = {2{1'b0}};
	s17    [1] = {ID_WIDTH{1'b0}};
	s18 [1] = 1'b0;
	s19  [1] = {20{1'b0}};
	s20   [1] = {4{1'b0}};
	s21  [1] = {3{1'b0}};
	s22 [1] = {2{1'b0}};
	s23    [1] = {ID_WIDTH{1'b0}};
	s24 [1] = 1'b0;
	s25 [1] = {DATA_WIDTH{1'b0}};
	s26 [1] = {(DATA_WIDTH/8){1'b0}};
	s28 [1] = 1'b0;
	s27[1] = 1'b0;
	s29[1] = 1'b0;
	s30[1] = 1'b0;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	s13  [2] = mst2_araddr  & {ADDR_WIDTH{mst2_connect}};
	s14   [2] = mst2_arlen   & {8{mst2_connect}};
	s15  [2] = mst2_arsize  & {3{mst2_connect}};
	s16 [2] = mst2_arburst & {2{mst2_connect}};
	s17    [2] = mst2_arid    & {ID_WIDTH{mst2_connect}};
	s18 [2] = mst2_arvalid & mst2_connect;
	s19  [2] = mst2_awaddr  & {20{mst2_connect}};
	s20   [2] = mst2_awlen   & {4{mst2_connect}};
	s21  [2] = mst2_awsize  & {3{mst2_connect}};
	s22 [2] = mst2_awburst & {2{mst2_connect}};
	s23    [2] = mst2_awid    & {ID_WIDTH{mst2_connect}};
	s24 [2] = mst2_awvalid & mst2_connect;
	s27  [2] = mst2_wvalid & mst2_connect & (mst2_wsid==SELF_ID);
	s28 [2]  = mst2_wlast  & mst2_connect;
	s25 [2] = mst2_wdata  & {DATA_WIDTH{mst2_connect}};
	s26 [2] = mst2_wstrb  & {(DATA_WIDTH/8){s27[2] & slv0_wready}};
	s29[2] = mst2_bready & mst2_connect & (mst2_bsid==SELF_ID);
	s30[2] = mst2_rready & mst2_connect & (mst2_rsid==SELF_ID);
`else
	s13  [2] = {ADDR_WIDTH{1'b0}};
	s14   [2] = {8{1'b0}};
	s15  [2] = {3{1'b0}};
	s16 [2] = {2{1'b0}};
	s17    [2] = {ID_WIDTH{1'b0}};
	s18 [2] = 1'b0;
	s19  [2] = {20{1'b0}};
	s20   [2] = {4{1'b0}};
	s21  [2] = {3{1'b0}};
	s22 [2] = {2{1'b0}};
	s23    [2] = {ID_WIDTH{1'b0}};
	s24 [2] = 1'b0;
	s25 [2] = {DATA_WIDTH{1'b0}};
	s26 [2] = {(DATA_WIDTH/8){1'b0}};
	s28 [2] = 1'b0;
	s27[2] = 1'b0;
	s29[2] = 1'b0;
	s30[2] = 1'b0;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	s13  [3] = mst3_araddr  & {ADDR_WIDTH{mst3_connect}};
	s14   [3] = mst3_arlen   & {8{mst3_connect}};
	s15  [3] = mst3_arsize  & {3{mst3_connect}};
	s16 [3] = mst3_arburst & {2{mst3_connect}};
	s17    [3] = mst3_arid    & {ID_WIDTH{mst3_connect}};
	s18 [3] = mst3_arvalid & mst3_connect;
	s19  [3] = mst3_awaddr  & {20{mst3_connect}};
	s20   [3] = mst3_awlen   & {4{mst3_connect}};
	s21  [3] = mst3_awsize  & {3{mst3_connect}};
	s22 [3] = mst3_awburst & {2{mst3_connect}};
	s23    [3] = mst3_awid    & {ID_WIDTH{mst3_connect}};
	s24 [3] = mst3_awvalid & mst3_connect;
	s27  [3] = mst3_wvalid & mst3_connect & (mst3_wsid==SELF_ID);
	s28 [3]  = mst3_wlast  & mst3_connect;
	s25 [3] = mst3_wdata  & {DATA_WIDTH{mst3_connect}};
	s26 [3] = mst3_wstrb  & {(DATA_WIDTH/8){s27[3] & slv0_wready}};
	s29[3] = mst3_bready & mst3_connect & (mst3_bsid==SELF_ID);
	s30[3] = mst3_rready & mst3_connect & (mst3_rsid==SELF_ID);
`else
	s13  [3] = {ADDR_WIDTH{1'b0}};
	s14   [3] = {8{1'b0}};
	s15  [3] = {3{1'b0}};
	s16 [3] = {2{1'b0}};
	s17    [3] = {ID_WIDTH{1'b0}};
	s18 [3] = 1'b0;
	s19  [3] = {20{1'b0}};
	s20   [3] = {4{1'b0}};
	s21  [3] = {3{1'b0}};
	s22 [3] = {2{1'b0}};
	s23    [3] = {ID_WIDTH{1'b0}};
	s24 [3] = 1'b0;
	s25 [3] = {DATA_WIDTH{1'b0}};
	s26 [3] = {(DATA_WIDTH/8){1'b0}};
	s28 [3] = 1'b0;
	s27[3] = 1'b0;
	s29[3] = 1'b0;
	s30[3] = 1'b0;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	s13  [4] = mst4_araddr  & {ADDR_WIDTH{mst4_connect}};
	s14   [4] = mst4_arlen   & {8{mst4_connect}};
	s15  [4] = mst4_arsize  & {3{mst4_connect}};
	s16 [4] = mst4_arburst & {2{mst4_connect}};
	s17    [4] = mst4_arid    & {ID_WIDTH{mst4_connect}};
	s18 [4] = mst4_arvalid & mst4_connect;
	s19  [4] = mst4_awaddr  & {20{mst4_connect}};
	s20   [4] = mst4_awlen   & {4{mst4_connect}};
	s21  [4] = mst4_awsize  & {3{mst4_connect}};
	s22 [4] = mst4_awburst & {2{mst4_connect}};
	s23    [4] = mst4_awid    & {ID_WIDTH{mst4_connect}};
	s24 [4] = mst4_awvalid & mst4_connect;
	s27  [4] = mst4_wvalid & mst4_connect & (mst4_wsid==SELF_ID);
	s28 [4]  = mst4_wlast  & mst4_connect;
	s25 [4] = mst4_wdata  & {DATA_WIDTH{mst4_connect}};
	s26 [4] = mst4_wstrb  & {(DATA_WIDTH/8){s27[4] & slv0_wready}};
	s29[4] = mst4_bready & mst4_connect & (mst4_bsid==SELF_ID);
	s30[4] = mst4_rready & mst4_connect & (mst4_rsid==SELF_ID);
`else
	s13  [4] = {ADDR_WIDTH{1'b0}};
	s14   [4] = {8{1'b0}};
	s15  [4] = {3{1'b0}};
	s16 [4] = {2{1'b0}};
	s17    [4] = {ID_WIDTH{1'b0}};
	s18 [4] = 1'b0;
	s19  [4] = {20{1'b0}};
	s20   [4] = {4{1'b0}};
	s21  [4] = {3{1'b0}};
	s22 [4] = {2{1'b0}};
	s23    [4] = {ID_WIDTH{1'b0}};
	s24 [4] = 1'b0;
	s25 [4] = {DATA_WIDTH{1'b0}};
	s26 [4] = {(DATA_WIDTH/8){1'b0}};
	s28 [4] = 1'b0;
	s27[4] = 1'b0;
	s29[4] = 1'b0;
	s30[4] = 1'b0;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	s13  [5] = mst5_araddr  & {ADDR_WIDTH{mst5_connect}};
	s14   [5] = mst5_arlen   & {8{mst5_connect}};
	s15  [5] = mst5_arsize  & {3{mst5_connect}};
	s16 [5] = mst5_arburst & {2{mst5_connect}};
	s17    [5] = mst5_arid    & {ID_WIDTH{mst5_connect}};
	s18 [5] = mst5_arvalid & mst5_connect;
	s19  [5] = mst5_awaddr  & {20{mst5_connect}};
	s20   [5] = mst5_awlen   & {4{mst5_connect}};
	s21  [5] = mst5_awsize  & {3{mst5_connect}};
	s22 [5] = mst5_awburst & {2{mst5_connect}};
	s23    [5] = mst5_awid    & {ID_WIDTH{mst5_connect}};
	s24 [5] = mst5_awvalid & mst5_connect;
	s27  [5] = mst5_wvalid & mst5_connect & (mst5_wsid==SELF_ID);
	s28 [5]  = mst5_wlast  & mst5_connect;
	s25 [5] = mst5_wdata  & {DATA_WIDTH{mst5_connect}};
	s26 [5] = mst5_wstrb  & {(DATA_WIDTH/8){s27[5] & slv0_wready}};
	s29[5] = mst5_bready & mst5_connect & (mst5_bsid==SELF_ID);
	s30[5] = mst5_rready & mst5_connect & (mst5_rsid==SELF_ID);
`else
	s13  [5] = {ADDR_WIDTH{1'b0}};
	s14   [5] = {8{1'b0}};
	s15  [5] = {3{1'b0}};
	s16 [5] = {2{1'b0}};
	s17    [5] = {ID_WIDTH{1'b0}};
	s18 [5] = 1'b0;
	s19  [5] = {20{1'b0}};
	s20   [5] = {4{1'b0}};
	s21  [5] = {3{1'b0}};
	s22 [5] = {2{1'b0}};
	s23    [5] = {ID_WIDTH{1'b0}};
	s24 [5] = 1'b0;
	s25 [5] = {DATA_WIDTH{1'b0}};
	s26 [5] = {(DATA_WIDTH/8){1'b0}};
	s28 [5] = 1'b0;
	s27[5] = 1'b0;
	s29[5] = 1'b0;
	s30[5] = 1'b0;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	s13  [6] = mst6_araddr  & {ADDR_WIDTH{mst6_connect}};
	s14   [6] = mst6_arlen   & {8{mst6_connect}};
	s15  [6] = mst6_arsize  & {3{mst6_connect}};
	s16 [6] = mst6_arburst & {2{mst6_connect}};
	s17    [6] = mst6_arid    & {ID_WIDTH{mst6_connect}};
	s18 [6] = mst6_arvalid & mst6_connect;
	s19  [6] = mst6_awaddr  & {20{mst6_connect}};
	s20   [6] = mst6_awlen   & {4{mst6_connect}};
	s21  [6] = mst6_awsize  & {3{mst6_connect}};
	s22 [6] = mst6_awburst & {2{mst6_connect}};
	s23    [6] = mst6_awid    & {ID_WIDTH{mst6_connect}};
	s24 [6] = mst6_awvalid & mst6_connect;
	s27  [6] = mst6_wvalid & mst6_connect & (mst6_wsid==SELF_ID);
	s28 [6]  = mst6_wlast  & mst6_connect;
	s25 [6] = mst6_wdata  & {DATA_WIDTH{mst6_connect}};
	s26 [6] = mst6_wstrb  & {(DATA_WIDTH/8){s27[6] & slv0_wready}};
	s29[6] = mst6_bready & mst6_connect & (mst6_bsid==SELF_ID);
	s30[6] = mst6_rready & mst6_connect & (mst6_rsid==SELF_ID);
`else
	s13  [6] = {ADDR_WIDTH{1'b0}};
	s14   [6] = {8{1'b0}};
	s15  [6] = {3{1'b0}};
	s16 [6] = {2{1'b0}};
	s17    [6] = {ID_WIDTH{1'b0}};
	s18 [6] = 1'b0;
	s19  [6] = {20{1'b0}};
	s20   [6] = {4{1'b0}};
	s21  [6] = {3{1'b0}};
	s22 [6] = {2{1'b0}};
	s23    [6] = {ID_WIDTH{1'b0}};
	s24 [6] = 1'b0;
	s25 [6] = {DATA_WIDTH{1'b0}};
	s26 [6] = {(DATA_WIDTH/8){1'b0}};
	s28 [6] = 1'b0;
	s27[6] = 1'b0;
	s29[6] = 1'b0;
	s30[6] = 1'b0;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	s13  [7] = mst7_araddr  & {ADDR_WIDTH{mst7_connect}};
	s14   [7] = mst7_arlen   & {8{mst7_connect}};
	s15  [7] = mst7_arsize  & {3{mst7_connect}};
	s16 [7] = mst7_arburst & {2{mst7_connect}};
	s17    [7] = mst7_arid    & {ID_WIDTH{mst7_connect}};
	s18 [7] = mst7_arvalid & mst7_connect;
	s19  [7] = mst7_awaddr  & {20{mst7_connect}};
	s20   [7] = mst7_awlen   & {4{mst7_connect}};
	s21  [7] = mst7_awsize  & {3{mst7_connect}};
	s22 [7] = mst7_awburst & {2{mst7_connect}};
	s23    [7] = mst7_awid    & {ID_WIDTH{mst7_connect}};
	s24 [7] = mst7_awvalid & mst7_connect;
	s27  [7] = mst7_wvalid & mst7_connect & (mst7_wsid==SELF_ID);
	s28 [7]  = mst7_wlast  & mst7_connect;
	s25 [7] = mst7_wdata  & {DATA_WIDTH{mst7_connect}};
	s26 [7] = mst7_wstrb  & {(DATA_WIDTH/8){s27[7] & slv0_wready}};
	s29[7] = mst7_bready & mst7_connect & (mst7_bsid==SELF_ID);
	s30[7] = mst7_rready & mst7_connect & (mst7_rsid==SELF_ID);
`else
	s13  [7] = {ADDR_WIDTH{1'b0}};
	s14   [7] = {8{1'b0}};
	s15  [7] = {3{1'b0}};
	s16 [7] = {2{1'b0}};
	s17    [7] = {ID_WIDTH{1'b0}};
	s18 [7] = 1'b0;
	s19  [7] = {20{1'b0}};
	s20   [7] = {4{1'b0}};
	s21  [7] = {3{1'b0}};
	s22 [7] = {2{1'b0}};
	s23    [7] = {ID_WIDTH{1'b0}};
	s24 [7] = 1'b0;
	s25 [7] = {DATA_WIDTH{1'b0}};
	s26 [7] = {(DATA_WIDTH/8){1'b0}};
	s28 [7] = 1'b0;
	s27[7] = 1'b0;
	s29[7] = 1'b0;
	s30[7] = 1'b0;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	s13  [8] = mst8_araddr  & {ADDR_WIDTH{mst8_connect}};
	s14   [8] = mst8_arlen   & {8{mst8_connect}};
	s15  [8] = mst8_arsize  & {3{mst8_connect}};
	s16 [8] = mst8_arburst & {2{mst8_connect}};
	s17    [8] = mst8_arid    & {ID_WIDTH{mst8_connect}};
	s18 [8] = mst8_arvalid & mst8_connect;
	s19  [8] = mst8_awaddr  & {20{mst8_connect}};
	s20   [8] = mst8_awlen   & {4{mst8_connect}};
	s21  [8] = mst8_awsize  & {3{mst8_connect}};
	s22 [8] = mst8_awburst & {2{mst8_connect}};
	s23    [8] = mst8_awid    & {ID_WIDTH{mst8_connect}};
	s24 [8] = mst8_awvalid & mst8_connect;
	s27  [8] = mst8_wvalid & mst8_connect & (mst8_wsid==SELF_ID);
	s28 [8]  = mst8_wlast  & mst8_connect;
	s25 [8] = mst8_wdata  & {DATA_WIDTH{mst8_connect}};
	s26 [8] = mst8_wstrb  & {(DATA_WIDTH/8){s27[8] & slv0_wready}};
	s29[8] = mst8_bready & mst8_connect & (mst8_bsid==SELF_ID);
	s30[8] = mst8_rready & mst8_connect & (mst8_rsid==SELF_ID);
`else
	s13  [8] = {ADDR_WIDTH{1'b0}};
	s14   [8] = {8{1'b0}};
	s15  [8] = {3{1'b0}};
	s16 [8] = {2{1'b0}};
	s17    [8] = {ID_WIDTH{1'b0}};
	s18 [8] = 1'b0;
	s19  [8] = {20{1'b0}};
	s20   [8] = {4{1'b0}};
	s21  [8] = {3{1'b0}};
	s22 [8] = {2{1'b0}};
	s23    [8] = {ID_WIDTH{1'b0}};
	s24 [8] = 1'b0;
	s25 [8] = {DATA_WIDTH{1'b0}};
	s26 [8] = {(DATA_WIDTH/8){1'b0}};
	s28 [8] = 1'b0;
	s27[8] = 1'b0;
	s29[8] = 1'b0;
	s30[8] = 1'b0;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	s13  [9] = mst9_araddr  & {ADDR_WIDTH{mst9_connect}};
	s14   [9] = mst9_arlen   & {8{mst9_connect}};
	s15  [9] = mst9_arsize  & {3{mst9_connect}};
	s16 [9] = mst9_arburst & {2{mst9_connect}};
	s17    [9] = mst9_arid    & {ID_WIDTH{mst9_connect}};
	s18 [9] = mst9_arvalid & mst9_connect;
	s19  [9] = mst9_awaddr  & {20{mst9_connect}};
	s20   [9] = mst9_awlen   & {4{mst9_connect}};
	s21  [9] = mst9_awsize  & {3{mst9_connect}};
	s22 [9] = mst9_awburst & {2{mst9_connect}};
	s23    [9] = mst9_awid    & {ID_WIDTH{mst9_connect}};
	s24 [9] = mst9_awvalid & mst9_connect;
	s27  [9] = mst9_wvalid & mst9_connect & (mst9_wsid==SELF_ID);
	s28 [9]  = mst9_wlast  & mst9_connect;
	s25 [9] = mst9_wdata  & {DATA_WIDTH{mst9_connect}};
	s26 [9] = mst9_wstrb  & {(DATA_WIDTH/8){s27[9] & slv0_wready}};
	s29[9] = mst9_bready & mst9_connect & (mst9_bsid==SELF_ID);
	s30[9] = mst9_rready & mst9_connect & (mst9_rsid==SELF_ID);
`else
	s13  [9] = {ADDR_WIDTH{1'b0}};
	s14   [9] = {8{1'b0}};
	s15  [9] = {3{1'b0}};
	s16 [9] = {2{1'b0}};
	s17    [9] = {ID_WIDTH{1'b0}};
	s18 [9] = 1'b0;
	s19  [9] = {20{1'b0}};
	s20   [9] = {4{1'b0}};
	s21  [9] = {3{1'b0}};
	s22 [9] = {2{1'b0}};
	s23    [9] = {ID_WIDTH{1'b0}};
	s24 [9] = 1'b0;
	s25 [9] = {DATA_WIDTH{1'b0}};
	s26 [9] = {(DATA_WIDTH/8){1'b0}};
	s28 [9] = 1'b0;
	s27[9] = 1'b0;
	s29[9] = 1'b0;
	s30[9] = 1'b0;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	s13  [10] = mst10_araddr  & {ADDR_WIDTH{mst10_connect}};
	s14   [10] = mst10_arlen   & {8{mst10_connect}};
	s15  [10] = mst10_arsize  & {3{mst10_connect}};
	s16 [10] = mst10_arburst & {2{mst10_connect}};
	s17    [10] = mst10_arid    & {ID_WIDTH{mst10_connect}};
	s18 [10] = mst10_arvalid & mst10_connect;
	s19  [10] = mst10_awaddr  & {20{mst10_connect}};
	s20   [10] = mst10_awlen   & {4{mst10_connect}};
	s21  [10] = mst10_awsize  & {3{mst10_connect}};
	s22 [10] = mst10_awburst & {2{mst10_connect}};
	s23    [10] = mst10_awid    & {ID_WIDTH{mst10_connect}};
	s24 [10] = mst10_awvalid & mst10_connect;
	s27  [10] = mst10_wvalid & mst10_connect & (mst10_wsid==SELF_ID);
	s28 [10]  = mst10_wlast  & mst10_connect;
	s25 [10] = mst10_wdata  & {DATA_WIDTH{mst10_connect}};
	s26 [10] = mst10_wstrb  & {(DATA_WIDTH/8){s27[10] & slv0_wready}};
	s29[10] = mst10_bready & mst10_connect & (mst10_bsid==SELF_ID);
	s30[10] = mst10_rready & mst10_connect & (mst10_rsid==SELF_ID);
`else
	s13  [10] = {ADDR_WIDTH{1'b0}};
	s14   [10] = {8{1'b0}};
	s15  [10] = {3{1'b0}};
	s16 [10] = {2{1'b0}};
	s17    [10] = {ID_WIDTH{1'b0}};
	s18 [10] = 1'b0;
	s19  [10] = {20{1'b0}};
	s20   [10] = {4{1'b0}};
	s21  [10] = {3{1'b0}};
	s22 [10] = {2{1'b0}};
	s23    [10] = {ID_WIDTH{1'b0}};
	s24 [10] = 1'b0;
	s25 [10] = {DATA_WIDTH{1'b0}};
	s26 [10] = {(DATA_WIDTH/8){1'b0}};
	s28 [10] = 1'b0;
	s27[10] = 1'b0;
	s29[10] = 1'b0;
	s30[10] = 1'b0;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	s13  [11] = mst11_araddr  & {ADDR_WIDTH{mst11_connect}};
	s14   [11] = mst11_arlen   & {8{mst11_connect}};
	s15  [11] = mst11_arsize  & {3{mst11_connect}};
	s16 [11] = mst11_arburst & {2{mst11_connect}};
	s17    [11] = mst11_arid    & {ID_WIDTH{mst11_connect}};
	s18 [11] = mst11_arvalid & mst11_connect;
	s19  [11] = mst11_awaddr  & {20{mst11_connect}};
	s20   [11] = mst11_awlen   & {4{mst11_connect}};
	s21  [11] = mst11_awsize  & {3{mst11_connect}};
	s22 [11] = mst11_awburst & {2{mst11_connect}};
	s23    [11] = mst11_awid    & {ID_WIDTH{mst11_connect}};
	s24 [11] = mst11_awvalid & mst11_connect;
	s27  [11] = mst11_wvalid & mst11_connect & (mst11_wsid==SELF_ID);
	s28 [11]  = mst11_wlast  & mst11_connect;
	s25 [11] = mst11_wdata  & {DATA_WIDTH{mst11_connect}};
	s26 [11] = mst11_wstrb  & {(DATA_WIDTH/8){s27[11] & slv0_wready}};
	s29[11] = mst11_bready & mst11_connect & (mst11_bsid==SELF_ID);
	s30[11] = mst11_rready & mst11_connect & (mst11_rsid==SELF_ID);
`else
	s13  [11] = {ADDR_WIDTH{1'b0}};
	s14   [11] = {8{1'b0}};
	s15  [11] = {3{1'b0}};
	s16 [11] = {2{1'b0}};
	s17    [11] = {ID_WIDTH{1'b0}};
	s18 [11] = 1'b0;
	s19  [11] = {20{1'b0}};
	s20   [11] = {4{1'b0}};
	s21  [11] = {3{1'b0}};
	s22 [11] = {2{1'b0}};
	s23    [11] = {ID_WIDTH{1'b0}};
	s24 [11] = 1'b0;
	s25 [11] = {DATA_WIDTH{1'b0}};
	s26 [11] = {(DATA_WIDTH/8){1'b0}};
	s28 [11] = 1'b0;
	s27[11] = 1'b0;
	s29[11] = 1'b0;
	s30[11] = 1'b0;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	s13  [12] = mst12_araddr  & {ADDR_WIDTH{mst12_connect}};
	s14   [12] = mst12_arlen   & {8{mst12_connect}};
	s15  [12] = mst12_arsize  & {3{mst12_connect}};
	s16 [12] = mst12_arburst & {2{mst12_connect}};
	s17    [12] = mst12_arid    & {ID_WIDTH{mst12_connect}};
	s18 [12] = mst12_arvalid & mst12_connect;
	s19  [12] = mst12_awaddr  & {20{mst12_connect}};
	s20   [12] = mst12_awlen   & {4{mst12_connect}};
	s21  [12] = mst12_awsize  & {3{mst12_connect}};
	s22 [12] = mst12_awburst & {2{mst12_connect}};
	s23    [12] = mst12_awid    & {ID_WIDTH{mst12_connect}};
	s24 [12] = mst12_awvalid & mst12_connect;
	s27  [12] = mst12_wvalid & mst12_connect & (mst12_wsid==SELF_ID);
	s28 [12]  = mst12_wlast  & mst12_connect;
	s25 [12] = mst12_wdata  & {DATA_WIDTH{mst12_connect}};
	s26 [12] = mst12_wstrb  & {(DATA_WIDTH/8){s27[12] & slv0_wready}};
	s29[12] = mst12_bready & mst12_connect & (mst12_bsid==SELF_ID);
	s30[12] = mst12_rready & mst12_connect & (mst12_rsid==SELF_ID);
`else
	s13  [12] = {ADDR_WIDTH{1'b0}};
	s14   [12] = {8{1'b0}};
	s15  [12] = {3{1'b0}};
	s16 [12] = {2{1'b0}};
	s17    [12] = {ID_WIDTH{1'b0}};
	s18 [12] = 1'b0;
	s19  [12] = {20{1'b0}};
	s20   [12] = {4{1'b0}};
	s21  [12] = {3{1'b0}};
	s22 [12] = {2{1'b0}};
	s23    [12] = {ID_WIDTH{1'b0}};
	s24 [12] = 1'b0;
	s25 [12] = {DATA_WIDTH{1'b0}};
	s26 [12] = {(DATA_WIDTH/8){1'b0}};
	s28 [12] = 1'b0;
	s27[12] = 1'b0;
	s29[12] = 1'b0;
	s30[12] = 1'b0;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	s13  [13] = mst13_araddr  & {ADDR_WIDTH{mst13_connect}};
	s14   [13] = mst13_arlen   & {8{mst13_connect}};
	s15  [13] = mst13_arsize  & {3{mst13_connect}};
	s16 [13] = mst13_arburst & {2{mst13_connect}};
	s17    [13] = mst13_arid    & {ID_WIDTH{mst13_connect}};
	s18 [13] = mst13_arvalid & mst13_connect;
	s19  [13] = mst13_awaddr  & {20{mst13_connect}};
	s20   [13] = mst13_awlen   & {4{mst13_connect}};
	s21  [13] = mst13_awsize  & {3{mst13_connect}};
	s22 [13] = mst13_awburst & {2{mst13_connect}};
	s23    [13] = mst13_awid    & {ID_WIDTH{mst13_connect}};
	s24 [13] = mst13_awvalid & mst13_connect;
	s27  [13] = mst13_wvalid & mst13_connect & (mst13_wsid==SELF_ID);
	s28 [13]  = mst13_wlast  & mst13_connect;
	s25 [13] = mst13_wdata  & {DATA_WIDTH{mst13_connect}};
	s26 [13] = mst13_wstrb  & {(DATA_WIDTH/8){s27[13] & slv0_wready}};
	s29[13] = mst13_bready & mst13_connect & (mst13_bsid==SELF_ID);
	s30[13] = mst13_rready & mst13_connect & (mst13_rsid==SELF_ID);
`else
	s13  [13] = {ADDR_WIDTH{1'b0}};
	s14   [13] = {8{1'b0}};
	s15  [13] = {3{1'b0}};
	s16 [13] = {2{1'b0}};
	s17    [13] = {ID_WIDTH{1'b0}};
	s18 [13] = 1'b0;
	s19  [13] = {20{1'b0}};
	s20   [13] = {4{1'b0}};
	s21  [13] = {3{1'b0}};
	s22 [13] = {2{1'b0}};
	s23    [13] = {ID_WIDTH{1'b0}};
	s24 [13] = 1'b0;
	s25 [13] = {DATA_WIDTH{1'b0}};
	s26 [13] = {(DATA_WIDTH/8){1'b0}};
	s28 [13] = 1'b0;
	s27[13] = 1'b0;
	s29[13] = 1'b0;
	s30[13] = 1'b0;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	s13  [14] = mst14_araddr  & {ADDR_WIDTH{mst14_connect}};
	s14   [14] = mst14_arlen   & {8{mst14_connect}};
	s15  [14] = mst14_arsize  & {3{mst14_connect}};
	s16 [14] = mst14_arburst & {2{mst14_connect}};
	s17    [14] = mst14_arid    & {ID_WIDTH{mst14_connect}};
	s18 [14] = mst14_arvalid & mst14_connect;
	s19  [14] = mst14_awaddr  & {20{mst14_connect}};
	s20   [14] = mst14_awlen   & {4{mst14_connect}};
	s21  [14] = mst14_awsize  & {3{mst14_connect}};
	s22 [14] = mst14_awburst & {2{mst14_connect}};
	s23    [14] = mst14_awid    & {ID_WIDTH{mst14_connect}};
	s24 [14] = mst14_awvalid & mst14_connect;
	s27  [14] = mst14_wvalid & mst14_connect & (mst14_wsid==SELF_ID);
	s28 [14]  = mst14_wlast  & mst14_connect;
	s25 [14] = mst14_wdata  & {DATA_WIDTH{mst14_connect}};
	s26 [14] = mst14_wstrb  & {(DATA_WIDTH/8){s27[14] & slv0_wready}};
	s29[14] = mst14_bready & mst14_connect & (mst14_bsid==SELF_ID);
	s30[14] = mst14_rready & mst14_connect & (mst14_rsid==SELF_ID);
`else
	s13  [14] = {ADDR_WIDTH{1'b0}};
	s14   [14] = {8{1'b0}};
	s15  [14] = {3{1'b0}};
	s16 [14] = {2{1'b0}};
	s17    [14] = {ID_WIDTH{1'b0}};
	s18 [14] = 1'b0;
	s19  [14] = {20{1'b0}};
	s20   [14] = {4{1'b0}};
	s21  [14] = {3{1'b0}};
	s22 [14] = {2{1'b0}};
	s23    [14] = {ID_WIDTH{1'b0}};
	s24 [14] = 1'b0;
	s25 [14] = {DATA_WIDTH{1'b0}};
	s26 [14] = {(DATA_WIDTH/8){1'b0}};
	s28 [14] = 1'b0;
	s27[14] = 1'b0;
	s29[14] = 1'b0;
	s30[14] = 1'b0;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	s13  [15] = mst15_araddr  & {ADDR_WIDTH{mst15_connect}};
	s14   [15] = mst15_arlen   & {8{mst15_connect}};
	s15  [15] = mst15_arsize  & {3{mst15_connect}};
	s16 [15] = mst15_arburst & {2{mst15_connect}};
	s17    [15] = mst15_arid    & {ID_WIDTH{mst15_connect}};
	s18 [15] = mst15_arvalid & mst15_connect;
	s19  [15] = mst15_awaddr  & {20{mst15_connect}};
	s20   [15] = mst15_awlen   & {4{mst15_connect}};
	s21  [15] = mst15_awsize  & {3{mst15_connect}};
	s22 [15] = mst15_awburst & {2{mst15_connect}};
	s23    [15] = mst15_awid    & {ID_WIDTH{mst15_connect}};
	s24 [15] = mst15_awvalid & mst15_connect;
	s27  [15] = mst15_wvalid & mst15_connect & (mst15_wsid==SELF_ID);
	s28 [15]  = mst15_wlast  & mst15_connect;
	s25 [15] = mst15_wdata  & {DATA_WIDTH{mst15_connect}};
	s26 [15] = mst15_wstrb  & {(DATA_WIDTH/8){s27[15] & slv0_wready}};
	s29[15] = mst15_bready & mst15_connect & (mst15_bsid==SELF_ID);
	s30[15] = mst15_rready & mst15_connect & (mst15_rsid==SELF_ID);
`else
	s13  [15] = {ADDR_WIDTH{1'b0}};
	s14   [15] = {8{1'b0}};
	s15  [15] = {3{1'b0}};
	s16 [15] = {2{1'b0}};
	s17    [15] = {ID_WIDTH{1'b0}};
	s18 [15] = 1'b0;
	s19  [15] = {20{1'b0}};
	s20   [15] = {4{1'b0}};
	s21  [15] = {3{1'b0}};
	s22 [15] = {2{1'b0}};
	s23    [15] = {ID_WIDTH{1'b0}};
	s24 [15] = 1'b0;
	s25 [15] = {DATA_WIDTH{1'b0}};
	s26 [15] = {(DATA_WIDTH/8){1'b0}};
	s28 [15] = 1'b0;
	s27[15] = 1'b0;
	s29[15] = 1'b0;
	s30[15] = 1'b0;
`endif
end
assign slv0_ar_mid = s45;
assign slv0_aw_mid = s46;
assign slv0_rid = {s4,s6};
assign slv0_bid = {s11,s12};
assign slv0_bresp = 2'b00;
assign slv0_wmid = s12;
assign slv0_arready = ~slv0_rvalid;
assign slv0_awready = ~slv0_wready & ~slv0_bvalid;
assign slv0_read_data = {2'b00, s31, s32};
assign s41 = s18[s45];
assign s42 = s24[s46];
assign s43 = (s41 & slv0_arready);
assign s44 = (s42 & slv0_awready);
assign s47 = (slv0_rvalid & s30[s6]);
assign s48 = (s27[s12] & slv0_wready);

assign s39 =       (reg_mst0_high_priority & s18[0]) ? 16'b1 :
		                    (s34!=16'h0) ? s34 :
		    ((s18 & reg_priority_reload)!=16'h0) ? (s18 & reg_priority_reload) : s18;
assign s45[3] = (~|s39[7:0]);
assign s45[2] = s45[3] ? (~|s39[11:08]) : (~|s39[03:00]);
assign s45[1] =
            		(s45[3:2]==2'h3 & (~|s39[13:12]))|
            		(s45[3:2]==2'h2 & (~|s39[09:08]))|
            		(s45[3:2]==2'h1 & (~|s39[05:04]))|
            		(s45[3:2]==2'h0 & (~|s39[01:00]));
assign s45[0] =
			(s45[3:1]==3'h7 & ~s39[14]) |
			(s45[3:1]==3'h6 & ~s39[12]) |
			(s45[3:1]==3'h5 & ~s39[10]) |
			(s45[3:1]==3'h4 & ~s39[08]) |
			(s45[3:1]==3'h3 & ~s39[06]) |
			(s45[3:1]==3'h2 & ~s39[04]) |
			(s45[3:1]==3'h1 & ~s39[02]) |
			(s45[3:1]==3'h0 & ~s39[00]) ;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		s2     <= 3'h0;
		s1 <= 4'h0;
		s3    <= 2'h0;
		s4 	   <= {ID_WIDTH{1'b0}};
		s6 	   <= {4{1'b0}};
	end else if (s43) begin
		s2     <= s15[s45] ;
		s1 <= s14[s45][3:0];
		s3    <= s16[s45];
		s4 	   <= s17[s45];
		s6 	   <= s45;
	end
end

wire [ADDR_MSB:0] s83 = {{(ADDR_WIDTH-1){1'b0}},1'b1} << s2;
wire [ADDR_MSB:0] s84 = s0 + s83;
wire [ADDR_MSB:0] s85 = ({{(ADDR_WIDTH-12){1'b0}},{12{(s3==AXI_INCR)}}} |
			              {{(ADDR_WIDTH-4){1'b0}},({4{(s3==AXI_WRAP)}} & s1[3:0])}) << s2;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s0  	<= {ADDR_WIDTH{1'b0}};
	else if (s43)
		s0  	<= s13[s45] ;
	else if (s47)
		s0  	<= (s85 & s84) | (~s85 & s0);
end


assign s38 = s43 ? s14[s45] : s5 - {7'b0,s47 & (s5!=8'h0)};
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s5   	<= 8'h0;
	else
		s5   	<= s38;
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s31 <= 1'b0;
	else
		s31 <= s38==8'h0;
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv0_rvalid  	<= 1'b0;
	else
		slv0_rvalid  	<= s43 | (slv0_rvalid & ~(s30[s6] & s31));
end


always @* begin
	s37[3] = s33[{s0[7:5],2'b11}];
	s37[2] = s33[{s0[7:5],2'b10}];
	s37[1] = s33[{s0[7:5],2'b01}];
	s37[0] = s33[{s0[7:5],2'b00}];
end
always @* begin
	if (s0[19:9]==11'b0)
		if (s0[8])
			s36 = {	s37[3],
					s37[2],
					s37[1],
					s37[0]};
		else if (s0[7:5]==3'b000)
			s36 = {	32'h0,
					32'h0,
					32'h0,
					reg_mst0_high_priority, 15'h0, reg_priority_reload,
					32'h0,
					32'h0,
					32'h0,
					`ATCBMC300_PRODUCT_ID};
		else
			s36 = {256'h0};
	else
			s36 = {256'h0};
end

generate
	if (DATA_MSB==31) begin: INTERNAL_READ_DATA32
		always @* begin
			case(s0[4:2])
				3'h7: s32 = s36[255:224];
				3'h6: s32 = s36[223:192];
				3'h5: s32 = s36[191:160];
				3'h4: s32 = s36[159:128];
				3'h3: s32 = s36[127:96];
				3'h2: s32 = s36[95:64];
				3'h1: s32 = s36[63:32];
				3'h0: s32 = s36[31:00];
			endcase
		end
	end
	else if (DATA_MSB==63) begin: INTERNAL_READ_DATA64
		always @* begin
			case(s0[4:3])
				2'h3: s32 = s36[255:192];
				2'h2: s32 = s36[191:128];
				2'h1: s32 = s36[127:64];
				2'h0: s32 = s36[63:00];
			endcase
		end
	end
	else if (DATA_MSB==127) begin: INTERNAL_READ_DATA128
		always @* begin
			case(s0[4])
				1'h1: s32 = s36[255:128];
				1'h0: s32 = s36[127:00];
			endcase
		end
	end
	else if (DATA_MSB==255) begin: INTERNAL_READ_DATA256
		always @* begin
			s32 = s36[255:00];
		end
	end
endgenerate

assign s40 =   (reg_mst0_high_priority & s24[0]) ? 16'b1 :
		                        (s35!=16'h0) ? s35 :
		    ((s24 & reg_priority_reload)!=16'h0) ? (s24 & reg_priority_reload) : s24;
assign s46[3] = (~|s40[7:0]);
assign s46[2] = s46[3] ? (~|s40[11:08]) : (~|s40[03:00]);
assign s46[1] =
            		(s46[3:2]==2'h3 & (~|s40[13:12]))|
            		(s46[3:2]==2'h2 & (~|s40[09:08]))|
            		(s46[3:2]==2'h1 & (~|s40[05:04]))|
            		(s46[3:2]==2'h0 & (~|s40[01:00]));
assign s46[0] =
			(s46[3:1]==3'h7 & ~s40[14]) |
			(s46[3:1]==3'h6 & ~s40[12]) |
			(s46[3:1]==3'h5 & ~s40[10]) |
			(s46[3:1]==3'h4 & ~s40[08]) |
			(s46[3:1]==3'h3 & ~s40[06]) |
			(s46[3:1]==3'h2 & ~s40[04]) |
			(s46[3:1]==3'h1 & ~s40[02]) |
			(s46[3:1]==3'h0 & ~s40[00]) ;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		s9  	<= 3'h0;
		s8<= 4'h0;
		s10 	<= 2'h0;
		s11 	<= {ID_WIDTH{1'b0}};
		s12 	<= {4{1'b0}};
	end else if (s44) begin
		s9     <= s21 [s46] ;
		s8 <= s20  [s46];
		s10    <= s22[s46];
		s11 	   <= s23   [s46];
		s12 	   <= s46;
	end
end

wire [19:0] s86 = {{19{1'b0}},1'b1} << s9;
wire [19:0] s87 = s7 + s86;
wire [19:0] s88 = ({{8{1'b0}},{12{(s10==AXI_INCR)}}} |
			         {{16{1'b0}},({4{(s10==AXI_WRAP)}} & s8[3:0])}) << s9;


always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s7  	<= {20{1'b0}};
	else if (s44)
		s7  	<= s19[s46] ;
	else if (s48)
		s7  	<= (s88 & s87) | (~s88 & s7);
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv0_wready  	<= 1'b0;
	else
		slv0_wready  	<= s44 | (slv0_wready & ~(s27[s12] & s28[s12]));
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv0_bvalid  	<= 1'b0;
	else
		slv0_bvalid  	<= (slv0_wready & s27[s12] & s28[s12]) | (slv0_bvalid & ~s29[s12]);
end

wire [31:0] s89 = s9==3'h0 ? (32'b1    	            <<  s7[4:0]) :
                            s9==3'h1 ? (32'b11   	            << {s7[4:1],1'b0}) :
		            s9==3'h2 ? (32'b1111 	            << {s7[4:2],2'b0}) :
		            s9==3'h3 ? (32'b1111_1111           << {s7[4:3],3'b0}) :
		            s9==3'h4 ? (32'b1111_1111_1111_1111 << {s7[4],4'b0}) :
                                         ({32{1'b1}});
wire [31:0] s90 = {MULTIPLE_WR_DATA{s26[s12]}} & s89;
wire [255:0] s91 = {
			      {8{s90[31]}},
			      {8{s90[30]}},
			      {8{s90[29]}},
			      {8{s90[28]}},
			      {8{s90[27]}},
			      {8{s90[26]}},
			      {8{s90[25]}},
			      {8{s90[24]}},
			      {8{s90[23]}},
			      {8{s90[22]}},
			      {8{s90[21]}},
			      {8{s90[20]}},
			      {8{s90[19]}},
			      {8{s90[18]}},
			      {8{s90[17]}},
			      {8{s90[16]}},
			      {8{s90[15]}},
			      {8{s90[14]}},
			      {8{s90[13]}},
			      {8{s90[12]}},
			      {8{s90[11]}},
			      {8{s90[10]}},
			      {8{s90[09]}},
			      {8{s90[08]}},
			      {8{s90[07]}},
			      {8{s90[06]}},
			      {8{s90[05]}},
			      {8{s90[04]}},
			      {8{s90[03]}},
			      {8{s90[02]}},
			      {8{s90[01]}},
			      {8{s90[00]}}
			     };
wire [255:0] s92  = {MULTIPLE_WR_DATA{s25[s12]}};

`ifdef ATCBMC300_MST0_SUPPORT
localparam RESET_M0_HIGH_PRIORITY = `ATCBMC300_MST0_DEFAULT_HIGH_PRIORITY;
reg s93;
assign reg_mst0_high_priority = s93;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s93 <= RESET_M0_HIGH_PRIORITY[0];
	else if (s7[19:5]==15'h00 & s91[31+128])
		s93 <= s92[31+128];
end
`else
assign reg_mst0_high_priority = 1'b0;
`endif



`ifdef ATCBMC300_MST0_SUPPORT
localparam RESET_M0_PRI_RELOAD = `ATCBMC300_MST0_DEFAULT_PRIORITY_RELOAD;
reg s94;
assign reg_priority_reload[0] = s94;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s94 <= RESET_M0_PRI_RELOAD[0];
	else
 		s94 <= ((s7[19:5]==15'h00) & s91[0+128])? s92[0+128] : s94;
end
`else
assign reg_priority_reload[0] = 1'b0;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
localparam RESET_M1_PRI_RELOAD = `ATCBMC300_MST1_DEFAULT_PRIORITY_RELOAD;
reg s95;
assign reg_priority_reload[1] = s95;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s95 <= RESET_M1_PRI_RELOAD[0];
	else
 		s95 <= ((s7[19:5]==15'h00) & s91[1+128])? s92[1+128] : s95;
end
`else
assign reg_priority_reload[1] = 1'b0;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
localparam RESET_M2_PRI_RELOAD = `ATCBMC300_MST2_DEFAULT_PRIORITY_RELOAD;
reg s96;
assign reg_priority_reload[2] = s96;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s96 <= RESET_M2_PRI_RELOAD[0];
	else
 		s96 <= ((s7[19:5]==15'h00) & s91[2+128])? s92[2+128] : s96;
end
`else
assign reg_priority_reload[2] = 1'b0;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
localparam RESET_M3_PRI_RELOAD = `ATCBMC300_MST3_DEFAULT_PRIORITY_RELOAD;
reg s97;
assign reg_priority_reload[3] = s97;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s97 <= RESET_M3_PRI_RELOAD[0];
	else
 		s97 <= ((s7[19:5]==15'h00) & s91[3+128])? s92[3+128] : s97;
end
`else
assign reg_priority_reload[3] = 1'b0;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
localparam RESET_M4_PRI_RELOAD = `ATCBMC300_MST4_DEFAULT_PRIORITY_RELOAD;
reg s98;
assign reg_priority_reload[4] = s98;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s98 <= RESET_M4_PRI_RELOAD[0];
	else
 		s98 <= ((s7[19:5]==15'h00) & s91[4+128])? s92[4+128] : s98;
end
`else
assign reg_priority_reload[4] = 1'b0;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
localparam RESET_M5_PRI_RELOAD = `ATCBMC300_MST5_DEFAULT_PRIORITY_RELOAD;
reg s99;
assign reg_priority_reload[5] = s99;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s99 <= RESET_M5_PRI_RELOAD[0];
	else
 		s99 <= ((s7[19:5]==15'h00) & s91[5+128])? s92[5+128] : s99;
end
`else
assign reg_priority_reload[5] = 1'b0;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
localparam RESET_M6_PRI_RELOAD = `ATCBMC300_MST6_DEFAULT_PRIORITY_RELOAD;
reg s100;
assign reg_priority_reload[6] = s100;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s100 <= RESET_M6_PRI_RELOAD[0];
	else
 		s100 <= ((s7[19:5]==15'h00) & s91[6+128])? s92[6+128] : s100;
end
`else
assign reg_priority_reload[6] = 1'b0;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
localparam RESET_M7_PRI_RELOAD = `ATCBMC300_MST7_DEFAULT_PRIORITY_RELOAD;
reg s101;
assign reg_priority_reload[7] = s101;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s101 <= RESET_M7_PRI_RELOAD[0];
	else
 		s101 <= ((s7[19:5]==15'h00) & s91[7+128])? s92[7+128] : s101;
end
`else
assign reg_priority_reload[7] = 1'b0;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
localparam RESET_M8_PRI_RELOAD = `ATCBMC300_MST8_DEFAULT_PRIORITY_RELOAD;
reg s102;
assign reg_priority_reload[8] = s102;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s102 <= RESET_M8_PRI_RELOAD[0];
	else
 		s102 <= ((s7[19:5]==15'h00) & s91[8+128])? s92[8+128] : s102;
end
`else
assign reg_priority_reload[8] = 1'b0;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
localparam RESET_M9_PRI_RELOAD = `ATCBMC300_MST9_DEFAULT_PRIORITY_RELOAD;
reg s103;
assign reg_priority_reload[9] = s103;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s103 <= RESET_M9_PRI_RELOAD[0];
	else
 		s103 <= ((s7[19:5]==15'h00) & s91[9+128])? s92[9+128] : s103;
end
`else
assign reg_priority_reload[9] = 1'b0;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
localparam RESET_M10_PRI_RELOAD = `ATCBMC300_MST10_DEFAULT_PRIORITY_RELOAD;
reg s104;
assign reg_priority_reload[10] = s104;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s104 <= RESET_M10_PRI_RELOAD[0];
	else
 		s104 <= ((s7[19:5]==15'h00) & s91[10+128])? s92[10+128] : s104;
end
`else
assign reg_priority_reload[10] = 1'b0;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
localparam RESET_M11_PRI_RELOAD = `ATCBMC300_MST11_DEFAULT_PRIORITY_RELOAD;
reg s105;
assign reg_priority_reload[11] = s105;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s105 <= RESET_M11_PRI_RELOAD[0];
	else
 		s105 <= ((s7[19:5]==15'h00) & s91[11+128])? s92[11+128] : s105;
end
`else
assign reg_priority_reload[11] = 1'b0;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
localparam RESET_M12_PRI_RELOAD = `ATCBMC300_MST12_DEFAULT_PRIORITY_RELOAD;
reg s106;
assign reg_priority_reload[12] = s106;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s106 <= RESET_M12_PRI_RELOAD[0];
	else
 		s106 <= ((s7[19:5]==15'h00) & s91[12+128])? s92[12+128] : s106;
end
`else
assign reg_priority_reload[12] = 1'b0;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
localparam RESET_M13_PRI_RELOAD = `ATCBMC300_MST13_DEFAULT_PRIORITY_RELOAD;
reg s107;
assign reg_priority_reload[13] = s107;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s107 <= RESET_M13_PRI_RELOAD[0];
	else
 		s107 <= ((s7[19:5]==15'h00) & s91[13+128])? s92[13+128] : s107;
end
`else
assign reg_priority_reload[13] = 1'b0;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
localparam RESET_M14_PRI_RELOAD = `ATCBMC300_MST14_DEFAULT_PRIORITY_RELOAD;
reg s108;
assign reg_priority_reload[14] = s108;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s108 <= RESET_M14_PRI_RELOAD[0];
	else
 		s108 <= ((s7[19:5]==15'h00) & s91[14+128])? s92[14+128] : s108;
end
`else
assign reg_priority_reload[14] = 1'b0;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
localparam RESET_M15_PRI_RELOAD = `ATCBMC300_MST15_DEFAULT_PRIORITY_RELOAD;
reg s109;
assign reg_priority_reload[15] = s109;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
 		s109 <= RESET_M15_PRI_RELOAD[0];
	else
 		s109 <= ((s7[19:5]==15'h00) & s91[15+128])? s92[15+128] : s109;
end
`else
assign reg_priority_reload[15] = 1'b0;
`endif

`ifdef ATCBMC300_SLV0_SUPPORT
   localparam        SLV0_SIZE = `ATCBMC300_SLV0_SIZE;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
   localparam        SLV1_SIZE = `ATCBMC300_SLV1_SIZE;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
   localparam        SLV2_SIZE = `ATCBMC300_SLV2_SIZE;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
   localparam        SLV3_SIZE = `ATCBMC300_SLV3_SIZE;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
   localparam        SLV4_SIZE = `ATCBMC300_SLV4_SIZE;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
   localparam        SLV5_SIZE = `ATCBMC300_SLV5_SIZE;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
   localparam        SLV6_SIZE = `ATCBMC300_SLV6_SIZE;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
   localparam        SLV7_SIZE = `ATCBMC300_SLV7_SIZE;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
   localparam        SLV8_SIZE = `ATCBMC300_SLV8_SIZE;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
   localparam        SLV9_SIZE = `ATCBMC300_SLV9_SIZE;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
   localparam        SLV10_SIZE = `ATCBMC300_SLV10_SIZE;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
   localparam        SLV11_SIZE = `ATCBMC300_SLV11_SIZE;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
   localparam        SLV12_SIZE = `ATCBMC300_SLV12_SIZE;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
   localparam        SLV13_SIZE = `ATCBMC300_SLV13_SIZE;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
   localparam        SLV14_SIZE = `ATCBMC300_SLV14_SIZE;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
   localparam        SLV15_SIZE = `ATCBMC300_SLV15_SIZE;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
   localparam        SLV16_SIZE = `ATCBMC300_SLV16_SIZE;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
   localparam        SLV17_SIZE = `ATCBMC300_SLV17_SIZE;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
   localparam        SLV18_SIZE = `ATCBMC300_SLV18_SIZE;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
   localparam        SLV19_SIZE = `ATCBMC300_SLV19_SIZE;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
   localparam        SLV20_SIZE = `ATCBMC300_SLV20_SIZE;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
   localparam        SLV21_SIZE = `ATCBMC300_SLV21_SIZE;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
   localparam        SLV22_SIZE = `ATCBMC300_SLV22_SIZE;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
   localparam        SLV23_SIZE = `ATCBMC300_SLV23_SIZE;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
   localparam        SLV24_SIZE = `ATCBMC300_SLV24_SIZE;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
   localparam        SLV25_SIZE = `ATCBMC300_SLV25_SIZE;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
   localparam        SLV26_SIZE = `ATCBMC300_SLV26_SIZE;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
   localparam        SLV27_SIZE = `ATCBMC300_SLV27_SIZE;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
   localparam        SLV28_SIZE = `ATCBMC300_SLV28_SIZE;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
   localparam        SLV29_SIZE = `ATCBMC300_SLV29_SIZE;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
   localparam        SLV30_SIZE = `ATCBMC300_SLV30_SIZE;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
   localparam        SLV31_SIZE = `ATCBMC300_SLV31_SIZE;
`endif
always @* begin
`ifdef ATCBMC300_SLV0_SUPPORT
   s33[0] =  {slv0_base_addr[63:20],12'h0,SLV0_SIZE[7:0]};
`else
   s33[0] =  64'h0;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
   s33[1] =  {slv1_base_addr[63:20],12'h0,SLV1_SIZE[7:0]};
`else
   s33[1] =  64'h0;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
   s33[2] =  {slv2_base_addr[63:20],12'h0,SLV2_SIZE[7:0]};
`else
   s33[2] =  64'h0;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
   s33[3] =  {slv3_base_addr[63:20],12'h0,SLV3_SIZE[7:0]};
`else
   s33[3] =  64'h0;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
   s33[4] =  {slv4_base_addr[63:20],12'h0,SLV4_SIZE[7:0]};
`else
   s33[4] =  64'h0;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
   s33[5] =  {slv5_base_addr[63:20],12'h0,SLV5_SIZE[7:0]};
`else
   s33[5] =  64'h0;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
   s33[6] =  {slv6_base_addr[63:20],12'h0,SLV6_SIZE[7:0]};
`else
   s33[6] =  64'h0;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
   s33[7] =  {slv7_base_addr[63:20],12'h0,SLV7_SIZE[7:0]};
`else
   s33[7] =  64'h0;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
   s33[8] =  {slv8_base_addr[63:20],12'h0,SLV8_SIZE[7:0]};
`else
   s33[8] =  64'h0;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
   s33[9] =  {slv9_base_addr[63:20],12'h0,SLV9_SIZE[7:0]};
`else
   s33[9] =  64'h0;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
   s33[10] =  {slv10_base_addr[63:20],12'h0,SLV10_SIZE[7:0]};
`else
   s33[10] =  64'h0;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
   s33[11] =  {slv11_base_addr[63:20],12'h0,SLV11_SIZE[7:0]};
`else
   s33[11] =  64'h0;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
   s33[12] =  {slv12_base_addr[63:20],12'h0,SLV12_SIZE[7:0]};
`else
   s33[12] =  64'h0;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
   s33[13] =  {slv13_base_addr[63:20],12'h0,SLV13_SIZE[7:0]};
`else
   s33[13] =  64'h0;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
   s33[14] =  {slv14_base_addr[63:20],12'h0,SLV14_SIZE[7:0]};
`else
   s33[14] =  64'h0;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
   s33[15] =  {slv15_base_addr[63:20],12'h0,SLV15_SIZE[7:0]};
`else
   s33[15] =  64'h0;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
   s33[16] =  {slv16_base_addr[63:20],12'h0,SLV16_SIZE[7:0]};
`else
   s33[16] =  64'h0;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
   s33[17] =  {slv17_base_addr[63:20],12'h0,SLV17_SIZE[7:0]};
`else
   s33[17] =  64'h0;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
   s33[18] =  {slv18_base_addr[63:20],12'h0,SLV18_SIZE[7:0]};
`else
   s33[18] =  64'h0;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
   s33[19] =  {slv19_base_addr[63:20],12'h0,SLV19_SIZE[7:0]};
`else
   s33[19] =  64'h0;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
   s33[20] =  {slv20_base_addr[63:20],12'h0,SLV20_SIZE[7:0]};
`else
   s33[20] =  64'h0;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
   s33[21] =  {slv21_base_addr[63:20],12'h0,SLV21_SIZE[7:0]};
`else
   s33[21] =  64'h0;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
   s33[22] =  {slv22_base_addr[63:20],12'h0,SLV22_SIZE[7:0]};
`else
   s33[22] =  64'h0;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
   s33[23] =  {slv23_base_addr[63:20],12'h0,SLV23_SIZE[7:0]};
`else
   s33[23] =  64'h0;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
   s33[24] =  {slv24_base_addr[63:20],12'h0,SLV24_SIZE[7:0]};
`else
   s33[24] =  64'h0;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
   s33[25] =  {slv25_base_addr[63:20],12'h0,SLV25_SIZE[7:0]};
`else
   s33[25] =  64'h0;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
   s33[26] =  {slv26_base_addr[63:20],12'h0,SLV26_SIZE[7:0]};
`else
   s33[26] =  64'h0;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
   s33[27] =  {slv27_base_addr[63:20],12'h0,SLV27_SIZE[7:0]};
`else
   s33[27] =  64'h0;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
   s33[28] =  {slv28_base_addr[63:20],12'h0,SLV28_SIZE[7:0]};
`else
   s33[28] =  64'h0;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
   s33[29] =  {slv29_base_addr[63:20],12'h0,SLV29_SIZE[7:0]};
`else
   s33[29] =  64'h0;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
   s33[30] =  {slv30_base_addr[63:20],12'h0,SLV30_SIZE[7:0]};
`else
   s33[30] =  64'h0;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
   s33[31] =  {slv31_base_addr[63:20],12'h0,SLV31_SIZE[7:0]};
`else
   s33[31] =  64'h0;
`endif
end
endmodule

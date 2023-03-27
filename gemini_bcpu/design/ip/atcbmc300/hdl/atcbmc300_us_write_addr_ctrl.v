// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"

module atcbmc300_us_write_addr_ctrl (
	  self_id,
`ifdef ATCBMC300_SLV0_SUPPORT
	  slv0_aw_mid,
	  slv0_awready,
	  slv0_masked_base_addr,
	  slv0_addr_mask,
	  slv0_awvalid,
	  slv0_connect,
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
	  slv1_aw_mid,
	  slv1_awready,
	  slv1_masked_base_addr,
	  slv1_addr_mask,
	  slv1_awvalid,
	  slv1_connect,
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
	  slv2_aw_mid,
	  slv2_awready,
	  slv2_masked_base_addr,
	  slv2_addr_mask,
	  slv2_awvalid,
	  slv2_connect,
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
	  slv3_aw_mid,
	  slv3_awready,
	  slv3_masked_base_addr,
	  slv3_addr_mask,
	  slv3_awvalid,
	  slv3_connect,
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
	  slv4_aw_mid,
	  slv4_awready,
	  slv4_masked_base_addr,
	  slv4_addr_mask,
	  slv4_awvalid,
	  slv4_connect,
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
	  slv5_aw_mid,
	  slv5_awready,
	  slv5_masked_base_addr,
	  slv5_addr_mask,
	  slv5_awvalid,
	  slv5_connect,
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
	  slv6_aw_mid,
	  slv6_awready,
	  slv6_masked_base_addr,
	  slv6_addr_mask,
	  slv6_awvalid,
	  slv6_connect,
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
	  slv7_aw_mid,
	  slv7_awready,
	  slv7_masked_base_addr,
	  slv7_addr_mask,
	  slv7_awvalid,
	  slv7_connect,
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
	  slv8_aw_mid,
	  slv8_awready,
	  slv8_masked_base_addr,
	  slv8_addr_mask,
	  slv8_awvalid,
	  slv8_connect,
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
	  slv9_aw_mid,
	  slv9_awready,
	  slv9_masked_base_addr,
	  slv9_addr_mask,
	  slv9_awvalid,
	  slv9_connect,
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
	  slv10_aw_mid,
	  slv10_awready,
	  slv10_masked_base_addr,
	  slv10_addr_mask,
	  slv10_awvalid,
	  slv10_connect,
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
	  slv11_aw_mid,
	  slv11_awready,
	  slv11_masked_base_addr,
	  slv11_addr_mask,
	  slv11_awvalid,
	  slv11_connect,
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
	  slv12_aw_mid,
	  slv12_awready,
	  slv12_masked_base_addr,
	  slv12_addr_mask,
	  slv12_awvalid,
	  slv12_connect,
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
	  slv13_aw_mid,
	  slv13_awready,
	  slv13_masked_base_addr,
	  slv13_addr_mask,
	  slv13_awvalid,
	  slv13_connect,
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
	  slv14_aw_mid,
	  slv14_awready,
	  slv14_masked_base_addr,
	  slv14_addr_mask,
	  slv14_awvalid,
	  slv14_connect,
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
	  slv15_aw_mid,
	  slv15_awready,
	  slv15_masked_base_addr,
	  slv15_addr_mask,
	  slv15_awvalid,
	  slv15_connect,
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
	  slv16_aw_mid,
	  slv16_awready,
	  slv16_masked_base_addr,
	  slv16_addr_mask,
	  slv16_awvalid,
	  slv16_connect,
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
	  slv17_aw_mid,
	  slv17_awready,
	  slv17_masked_base_addr,
	  slv17_addr_mask,
	  slv17_awvalid,
	  slv17_connect,
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
	  slv18_aw_mid,
	  slv18_awready,
	  slv18_masked_base_addr,
	  slv18_addr_mask,
	  slv18_awvalid,
	  slv18_connect,
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
	  slv19_aw_mid,
	  slv19_awready,
	  slv19_masked_base_addr,
	  slv19_addr_mask,
	  slv19_awvalid,
	  slv19_connect,
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
	  slv20_aw_mid,
	  slv20_awready,
	  slv20_masked_base_addr,
	  slv20_addr_mask,
	  slv20_awvalid,
	  slv20_connect,
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
	  slv21_aw_mid,
	  slv21_awready,
	  slv21_masked_base_addr,
	  slv21_addr_mask,
	  slv21_awvalid,
	  slv21_connect,
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
	  slv22_aw_mid,
	  slv22_awready,
	  slv22_masked_base_addr,
	  slv22_addr_mask,
	  slv22_awvalid,
	  slv22_connect,
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
	  slv23_aw_mid,
	  slv23_awready,
	  slv23_masked_base_addr,
	  slv23_addr_mask,
	  slv23_awvalid,
	  slv23_connect,
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
	  slv24_aw_mid,
	  slv24_awready,
	  slv24_masked_base_addr,
	  slv24_addr_mask,
	  slv24_awvalid,
	  slv24_connect,
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
	  slv25_aw_mid,
	  slv25_awready,
	  slv25_masked_base_addr,
	  slv25_addr_mask,
	  slv25_awvalid,
	  slv25_connect,
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
	  slv26_aw_mid,
	  slv26_awready,
	  slv26_masked_base_addr,
	  slv26_addr_mask,
	  slv26_awvalid,
	  slv26_connect,
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
	  slv27_aw_mid,
	  slv27_awready,
	  slv27_masked_base_addr,
	  slv27_addr_mask,
	  slv27_awvalid,
	  slv27_connect,
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
	  slv28_aw_mid,
	  slv28_awready,
	  slv28_masked_base_addr,
	  slv28_addr_mask,
	  slv28_awvalid,
	  slv28_connect,
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
	  slv29_aw_mid,
	  slv29_awready,
	  slv29_masked_base_addr,
	  slv29_addr_mask,
	  slv29_awvalid,
	  slv29_connect,
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
	  slv30_aw_mid,
	  slv30_awready,
	  slv30_masked_base_addr,
	  slv30_addr_mask,
	  slv30_awvalid,
	  slv30_connect,
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
	  slv31_aw_mid,
	  slv31_awready,
	  slv31_masked_base_addr,
	  slv31_addr_mask,
	  slv31_awvalid,
	  slv31_connect,
`endif
	  us_awaddr,
	  us_awlen,
	  us_awsize,
	  us_awburst,
	  us_awlock,
	  us_awcache,
	  us_awprot,
	  us_awid,
	  us_awvalid,
	  us_awready,
	  mst_awaddr,
	  mst_awlen,
	  mst_awsize,
	  mst_awburst,
	  mst_awlock,
	  mst_awcache,
	  mst_awprot,
	  mst_awid,
	  dec_err_wready,
	  dec_err_bvalid,
	  dec_err_wvalid,
	  dec_err_wlast,
	  dec_err_bready,
	  aw_outstanding_id,
	  dec_err_bresp,
	  dec_err_bid,
	  aw_addr_outstanding_en,
	  aw_outstanding_ready,
	  wd_outstanding_idle,
	  br_outstanding_idle,
	  master_arlock,
	  master_arvalid,
	  master_arid,
	  mst_arlocking,
	  locking_arid,
	  us_bid,
	  us_bvalid,
	  us_bready,
	  mst_awlocking,
	  locking_awid,
	  aclk,
	  aresetn
);
parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 64;
parameter ID_WIDTH   = 4;

parameter RESP_INORDER_ONLY = 1;
parameter OUTSTAND_ID_WIDTH = 5;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam ID_MSB   = ID_WIDTH - 1;
localparam OUTSTAND_ID_MSB = OUTSTAND_ID_WIDTH - 1;

input [3:0]     self_id;

`ifdef ATCBMC300_SLV0_SUPPORT
input [3:0]        slv0_aw_mid;
input              slv0_awready;
input [64:0]	   slv0_masked_base_addr;
input [64:0]	   slv0_addr_mask;
output		   slv0_awvalid;
input              slv0_connect;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
input [3:0]        slv1_aw_mid;
input              slv1_awready;
input [64:0]	   slv1_masked_base_addr;
input [64:0]	   slv1_addr_mask;
output		   slv1_awvalid;
input              slv1_connect;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
input [3:0]        slv2_aw_mid;
input              slv2_awready;
input [64:0]	slv2_masked_base_addr;
input [64:0]	slv2_addr_mask;
output		slv2_awvalid;
input              slv2_connect;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
input [3:0]        slv3_aw_mid;
input              slv3_awready;
input [64:0]	slv3_masked_base_addr;
input [64:0]	slv3_addr_mask;
output		slv3_awvalid;
input              slv3_connect;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
input [3:0]        slv4_aw_mid;
input              slv4_awready;
input [64:0]	slv4_masked_base_addr;
input [64:0]	slv4_addr_mask;
output		slv4_awvalid;
input              slv4_connect;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
input [3:0]        slv5_aw_mid;
input              slv5_awready;
input [64:0]	slv5_masked_base_addr;
input [64:0]	slv5_addr_mask;
output		slv5_awvalid;
input              slv5_connect;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
input [3:0]        slv6_aw_mid;
input              slv6_awready;
input [64:0]	slv6_masked_base_addr;
input [64:0]	slv6_addr_mask;
output		slv6_awvalid;
input              slv6_connect;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
input [3:0]        slv7_aw_mid;
input              slv7_awready;
input [64:0]	slv7_masked_base_addr;
input [64:0]	slv7_addr_mask;
output		slv7_awvalid;
input              slv7_connect;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
input [3:0]        slv8_aw_mid;
input              slv8_awready;
input [64:0]	slv8_masked_base_addr;
input [64:0]	slv8_addr_mask;
output		slv8_awvalid;
input              slv8_connect;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
input [3:0]        slv9_aw_mid;
input              slv9_awready;
input [64:0]	slv9_masked_base_addr;
input [64:0]	slv9_addr_mask;
output		slv9_awvalid;
input              slv9_connect;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
input [3:0]        slv10_aw_mid;
input              slv10_awready;
input [64:0]	slv10_masked_base_addr;
input [64:0]	slv10_addr_mask;
output		slv10_awvalid;
input              slv10_connect;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
input [3:0]        slv11_aw_mid;
input              slv11_awready;
input [64:0]	slv11_masked_base_addr;
input [64:0]	slv11_addr_mask;
output		slv11_awvalid;
input              slv11_connect;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
input [3:0]        slv12_aw_mid;
input              slv12_awready;
input [64:0]	slv12_masked_base_addr;
input [64:0]	slv12_addr_mask;
output		slv12_awvalid;
input              slv12_connect;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
input [3:0]        slv13_aw_mid;
input              slv13_awready;
input [64:0]	slv13_masked_base_addr;
input [64:0]	slv13_addr_mask;
output		slv13_awvalid;
input              slv13_connect;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
input [3:0]        slv14_aw_mid;
input              slv14_awready;
input [64:0]	slv14_masked_base_addr;
input [64:0]	slv14_addr_mask;
output		slv14_awvalid;
input              slv14_connect;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
input [3:0]        slv15_aw_mid;
input              slv15_awready;
input [64:0]	slv15_masked_base_addr;
input [64:0]	slv15_addr_mask;
output		slv15_awvalid;
input              slv15_connect;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
input [3:0]        slv16_aw_mid;
input              slv16_awready;
input [64:0]	slv16_masked_base_addr;
input [64:0]	slv16_addr_mask;
output		slv16_awvalid;
input              slv16_connect;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
input [3:0]        slv17_aw_mid;
input              slv17_awready;
input [64:0]	slv17_masked_base_addr;
input [64:0]	slv17_addr_mask;
output		slv17_awvalid;
input              slv17_connect;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
input [3:0]        slv18_aw_mid;
input              slv18_awready;
input [64:0]	slv18_masked_base_addr;
input [64:0]	slv18_addr_mask;
output		slv18_awvalid;
input              slv18_connect;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
input [3:0]        slv19_aw_mid;
input              slv19_awready;
input [64:0]	slv19_masked_base_addr;
input [64:0]	slv19_addr_mask;
output		slv19_awvalid;
input              slv19_connect;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
input [3:0]        slv20_aw_mid;
input              slv20_awready;
input [64:0]	slv20_masked_base_addr;
input [64:0]	slv20_addr_mask;
output		slv20_awvalid;
input              slv20_connect;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
input [3:0]        slv21_aw_mid;
input              slv21_awready;
input [64:0]	slv21_masked_base_addr;
input [64:0]	slv21_addr_mask;
output		slv21_awvalid;
input              slv21_connect;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
input [3:0]        slv22_aw_mid;
input              slv22_awready;
input [64:0]	slv22_masked_base_addr;
input [64:0]	slv22_addr_mask;
output		slv22_awvalid;
input              slv22_connect;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
input [3:0]        slv23_aw_mid;
input              slv23_awready;
input [64:0]	slv23_masked_base_addr;
input [64:0]	slv23_addr_mask;
output		slv23_awvalid;
input              slv23_connect;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
input [3:0]        slv24_aw_mid;
input              slv24_awready;
input [64:0]	slv24_masked_base_addr;
input [64:0]	slv24_addr_mask;
output		slv24_awvalid;
input              slv24_connect;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
input [3:0]        slv25_aw_mid;
input              slv25_awready;
input [64:0]	slv25_masked_base_addr;
input [64:0]	slv25_addr_mask;
output		slv25_awvalid;
input              slv25_connect;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
input [3:0]        slv26_aw_mid;
input              slv26_awready;
input [64:0]	slv26_masked_base_addr;
input [64:0]	slv26_addr_mask;
output		slv26_awvalid;
input              slv26_connect;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
input [3:0]        slv27_aw_mid;
input              slv27_awready;
input [64:0]	slv27_masked_base_addr;
input [64:0]	slv27_addr_mask;
output		slv27_awvalid;
input              slv27_connect;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
input [3:0]        slv28_aw_mid;
input              slv28_awready;
input [64:0]	slv28_masked_base_addr;
input [64:0]	slv28_addr_mask;
output		slv28_awvalid;
input              slv28_connect;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
input [3:0]        slv29_aw_mid;
input              slv29_awready;
input [64:0]	slv29_masked_base_addr;
input [64:0]	slv29_addr_mask;
output		slv29_awvalid;
input              slv29_connect;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
input [3:0]        slv30_aw_mid;
input              slv30_awready;
input [64:0]	slv30_masked_base_addr;
input [64:0]	slv30_addr_mask;
output		slv30_awvalid;
input              slv30_connect;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
input [3:0]        slv31_aw_mid;
input              slv31_awready;
input [64:0]	slv31_masked_base_addr;
input [64:0]	slv31_addr_mask;
output		slv31_awvalid;
input              slv31_connect;
`endif
input [ADDR_MSB:0] us_awaddr;
input [7:0]        us_awlen;
input [2:0]        us_awsize;
input [1:0]        us_awburst;
input 	           us_awlock;
input [3:0]        us_awcache;
input [2:0]        us_awprot;
input [ID_MSB:0]   us_awid;
input              us_awvalid;
output             us_awready;

output [ADDR_MSB:0] mst_awaddr;
output [7:0]        mst_awlen;
output [2:0]        mst_awsize;
output [1:0]        mst_awburst;
output 	            mst_awlock;
output [3:0]        mst_awcache;
output [2:0]        mst_awprot;
output [ID_MSB:0]   mst_awid;
output 		    dec_err_wready;
output 		    dec_err_bvalid;
input		    dec_err_wvalid;
input		    dec_err_wlast;
input 		    dec_err_bready;
output [OUTSTAND_ID_MSB:0]  	    aw_outstanding_id;
output [1:0] dec_err_bresp;
output [ID_MSB:0] dec_err_bid;
output 		    aw_addr_outstanding_en;
input		    aw_outstanding_ready;
input     	    wd_outstanding_idle;
input     	    br_outstanding_idle;
input       	    master_arlock;
input        	    master_arvalid;
input  [ID_MSB:0]   master_arid;
input 		    mst_arlocking;
input  [ID_MSB:0]   locking_arid;
input  [ID_MSB:0]   us_bid;
input               us_bvalid;
input               us_bready;
output 		    mst_awlocking;
output [ID_MSB:0]   locking_awid;
input aclk;
input aresetn;

reg [ADDR_MSB:0] s0;
reg [7:0]        s1;
reg [2:0]        s2;
reg [1:0]        s3;
reg 	         s4;
reg [3:0]        s5;
reg [2:0]        s6;
reg [ID_MSB:0]   s7;
reg              s8;
reg [ADDR_MSB:0] mst_awaddr;
reg [7:0]        mst_awlen;
reg [2:0]        mst_awsize;
reg [1:0]        mst_awburst;
reg 	         mst_awlock;
reg [3:0]        mst_awcache;
reg [2:0]        mst_awprot;
reg [ID_MSB:0]   mst_awid;
wire [31:0]      s9;
reg 		 dec_err_wready;
reg 		 dec_err_bvalid;
reg 		 mst_awlocking;
reg [ID_MSB:0]   locking_awid;
wire [ADDR_MSB:0] s10;
wire [ID_MSB:0] s11;
wire        s12;
wire        s13;
wire [31:0] s14;
wire [31:0] s15;
wire [31:0] s16;
wire        s17;
wire        s18;
wire        s19;
wire [4:0]  s20;
wire	    s21;

generate
	if (RESP_INORDER_ONLY==1) begin:only_slave_id
		assign aw_outstanding_id = s20;
	end else begin:include_awid
		assign aw_outstanding_id = {s11,s20};
	end
endgenerate

assign s20[4] =  |s15[31:16];
assign s20[3] = |{s15[31:24],s15[15:08]};
assign s20[2] = |{s15[31:28],s15[23:20],
     	          	   s15[15:12],s15[07:04]};
assign s20[1] = |{s15[31:30],s15[27:26],
                           s15[23:22],s15[19:18],
                           s15[15:14],s15[11:10],
                           s15[07:06],s15[03:02]};
assign s20[0] = |{s15[31],s15[29],s15[27],s15[25],
                           s15[23],s15[21],s15[19],s15[17],
                           s15[15],s15[13],s15[11],s15[09],
                           s15[07],s15[05],s15[03],s15[01]};
assign s21 = s12 & (~|s15);
assign aw_addr_outstanding_en = (|s15) & s17;


`ifdef ATCBMC300_SLV0_SUPPORT
reg slv0_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv0_awvalid <= 1'b0;
	else
		slv0_awvalid <= s17 ? s15[0] : (slv0_awvalid & ~s14[0]);
end

	assign s9[0] = slv0_awvalid;
	assign s16[0] = s12 & slv0_connect & (slv0_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv0_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[0] = s16[0];
	`else
		assign s15[0] = s16[0];
	`endif
	assign s14[0] = (slv0_aw_mid==self_id) & slv0_awready & slv0_connect;
`else
	assign s15[0] = 1'b0;
	assign s16[0] = 1'b0;
	assign s14[0] = 1'b0;
	assign s9[0] = 1'b0;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
reg slv1_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv1_awvalid <= 1'b0;
	else
		slv1_awvalid <= s17 ? s15[1] : (slv1_awvalid & ~s14[1]);
end

	assign s9[1] = slv1_awvalid;
	assign s16[1] = s12 & slv1_connect & (slv1_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv1_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[1] = s16[1] & (~s16[0]);
	`else
		assign s15[1] = s16[1];
	`endif
	assign s14[1] = (slv1_aw_mid==self_id) & slv1_awready & slv1_connect;
`else
	assign s15[1] = 1'b0;
	assign s16[1] = 1'b0;
	assign s14[1] = 1'b0;
	assign s9[1] = 1'b0;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
reg slv2_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv2_awvalid <= 1'b0;
	else
		slv2_awvalid <= s17 ? s15[2] : (slv2_awvalid & ~s14[2]);
end

	assign s9[2] = slv2_awvalid;
	assign s16[2] = s12 & slv2_connect & (slv2_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv2_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[2] = s16[2] & (~(|s16[1:0]));
	`else
		assign s15[2] = s16[2];
	`endif
	assign s14[2] = (slv2_aw_mid==self_id) & slv2_awready & slv2_connect;
`else
	assign s15[2] = 1'b0;
	assign s16[2] = 1'b0;
	assign s14[2] = 1'b0;
	assign s9[2] = 1'b0;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
reg slv3_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv3_awvalid <= 1'b0;
	else
		slv3_awvalid <= s17 ? s15[3] : (slv3_awvalid & ~s14[3]);
end

	assign s9[3] = slv3_awvalid;
	assign s16[3] = s12 & slv3_connect & (slv3_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv3_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[3] = s16[3] & (~(|s16[2:0]));
	`else
		assign s15[3] = s16[3];
	`endif
	assign s14[3] = (slv3_aw_mid==self_id) & slv3_awready & slv3_connect;
`else
	assign s15[3] = 1'b0;
	assign s16[3] = 1'b0;
	assign s14[3] = 1'b0;
	assign s9[3] = 1'b0;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
reg slv4_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv4_awvalid <= 1'b0;
	else
		slv4_awvalid <= s17 ? s15[4] : (slv4_awvalid & ~s14[4]);
end

	assign s9[4] = slv4_awvalid;
	assign s16[4] = s12 & slv4_connect & (slv4_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv4_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[4] = s16[4] & (~(|s16[3:0]));
	`else
		assign s15[4] = s16[4];
	`endif
	assign s14[4] = (slv4_aw_mid==self_id) & slv4_awready & slv4_connect;
`else
	assign s15[4] = 1'b0;
	assign s16[4] = 1'b0;
	assign s14[4] = 1'b0;
	assign s9[4] = 1'b0;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
reg slv5_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv5_awvalid <= 1'b0;
	else
		slv5_awvalid <= s17 ? s15[5] : (slv5_awvalid & ~s14[5]);
end

	assign s9[5] = slv5_awvalid;
	assign s16[5] = s12 & slv5_connect & (slv5_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv5_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[5] = s16[5] & (~(|s16[4:0]));
	`else
		assign s15[5] = s16[5];
	`endif
	assign s14[5] = (slv5_aw_mid==self_id) & slv5_awready & slv5_connect;
`else
	assign s15[5] = 1'b0;
	assign s16[5] = 1'b0;
	assign s14[5] = 1'b0;
	assign s9[5] = 1'b0;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
reg slv6_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv6_awvalid <= 1'b0;
	else
		slv6_awvalid <= s17 ? s15[6] : (slv6_awvalid & ~s14[6]);
end

	assign s9[6] = slv6_awvalid;
	assign s16[6] = s12 & slv6_connect & (slv6_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv6_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[6] = s16[6] & (~(|s16[5:0]));
	`else
		assign s15[6] = s16[6];
	`endif
	assign s14[6] = (slv6_aw_mid==self_id) & slv6_awready & slv6_connect;
`else
	assign s15[6] = 1'b0;
	assign s16[6] = 1'b0;
	assign s14[6] = 1'b0;
	assign s9[6] = 1'b0;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
reg slv7_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv7_awvalid <= 1'b0;
	else
		slv7_awvalid <= s17 ? s15[7] : (slv7_awvalid & ~s14[7]);
end

	assign s9[7] = slv7_awvalid;
	assign s16[7] = s12 & slv7_connect & (slv7_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv7_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[7] = s16[7] & (~(|s16[6:0]));
	`else
		assign s15[7] = s16[7];
	`endif
	assign s14[7] = (slv7_aw_mid==self_id) & slv7_awready & slv7_connect;
`else
	assign s15[7] = 1'b0;
	assign s16[7] = 1'b0;
	assign s14[7] = 1'b0;
	assign s9[7] = 1'b0;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
reg slv8_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv8_awvalid <= 1'b0;
	else
		slv8_awvalid <= s17 ? s15[8] : (slv8_awvalid & ~s14[8]);
end

	assign s9[8] = slv8_awvalid;
	assign s16[8] = s12 & slv8_connect & (slv8_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv8_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[8] = s16[8] & (~(|s16[7:0]));
	`else
		assign s15[8] = s16[8];
	`endif
	assign s14[8] = (slv8_aw_mid==self_id) & slv8_awready & slv8_connect;
`else
	assign s15[8] = 1'b0;
	assign s16[8] = 1'b0;
	assign s14[8] = 1'b0;
	assign s9[8] = 1'b0;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
reg slv9_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv9_awvalid <= 1'b0;
	else
		slv9_awvalid <= s17 ? s15[9] : (slv9_awvalid & ~s14[9]);
end

	assign s9[9] = slv9_awvalid;
	assign s16[9] = s12 & slv9_connect & (slv9_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv9_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[9] = s16[9] & (~(|s16[8:0]));
	`else
		assign s15[9] = s16[9];
	`endif
	assign s14[9] = (slv9_aw_mid==self_id) & slv9_awready & slv9_connect;
`else
	assign s15[9] = 1'b0;
	assign s16[9] = 1'b0;
	assign s14[9] = 1'b0;
	assign s9[9] = 1'b0;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
reg slv10_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv10_awvalid <= 1'b0;
	else
		slv10_awvalid <= s17 ? s15[10] : (slv10_awvalid & ~s14[10]);
end

	assign s9[10] = slv10_awvalid;
	assign s16[10] = s12 & slv10_connect & (slv10_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv10_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[10] = s16[10] & (~(|s16[9:0]));
	`else
		assign s15[10] = s16[10];
	`endif
	assign s14[10] = (slv10_aw_mid==self_id) & slv10_awready & slv10_connect;
`else
	assign s15[10] = 1'b0;
	assign s16[10] = 1'b0;
	assign s14[10] = 1'b0;
	assign s9[10] = 1'b0;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
reg slv11_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv11_awvalid <= 1'b0;
	else
		slv11_awvalid <= s17 ? s15[11] : (slv11_awvalid & ~s14[11]);
end

	assign s9[11] = slv11_awvalid;
	assign s16[11] = s12 & slv11_connect & (slv11_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv11_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[11] = s16[11] & (~(|s16[10:0]));
	`else
		assign s15[11] = s16[11];
	`endif
	assign s14[11] = (slv11_aw_mid==self_id) & slv11_awready & slv11_connect;
`else
	assign s15[11] = 1'b0;
	assign s16[11] = 1'b0;
	assign s14[11] = 1'b0;
	assign s9[11] = 1'b0;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
reg slv12_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv12_awvalid <= 1'b0;
	else
		slv12_awvalid <= s17 ? s15[12] : (slv12_awvalid & ~s14[12]);
end

	assign s9[12] = slv12_awvalid;
	assign s16[12] = s12 & slv12_connect & (slv12_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv12_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[12] = s16[12] & (~(|s16[11:0]));
	`else
		assign s15[12] = s16[12];
	`endif
	assign s14[12] = (slv12_aw_mid==self_id) & slv12_awready & slv12_connect;
`else
	assign s15[12] = 1'b0;
	assign s16[12] = 1'b0;
	assign s14[12] = 1'b0;
	assign s9[12] = 1'b0;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
reg slv13_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv13_awvalid <= 1'b0;
	else
		slv13_awvalid <= s17 ? s15[13] : (slv13_awvalid & ~s14[13]);
end

	assign s9[13] = slv13_awvalid;
	assign s16[13] = s12 & slv13_connect & (slv13_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv13_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[13] = s16[13] & (~(|s16[12:0]));
	`else
		assign s15[13] = s16[13];
	`endif
	assign s14[13] = (slv13_aw_mid==self_id) & slv13_awready & slv13_connect;
`else
	assign s15[13] = 1'b0;
	assign s16[13] = 1'b0;
	assign s14[13] = 1'b0;
	assign s9[13] = 1'b0;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
reg slv14_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv14_awvalid <= 1'b0;
	else
		slv14_awvalid <= s17 ? s15[14] : (slv14_awvalid & ~s14[14]);
end

	assign s9[14] = slv14_awvalid;
	assign s16[14] = s12 & slv14_connect & (slv14_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv14_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[14] = s16[14] & (~(|s16[13:0]));
	`else
		assign s15[14] = s16[14];
	`endif
	assign s14[14] = (slv14_aw_mid==self_id) & slv14_awready & slv14_connect;
`else
	assign s15[14] = 1'b0;
	assign s16[14] = 1'b0;
	assign s14[14] = 1'b0;
	assign s9[14] = 1'b0;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
reg slv15_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv15_awvalid <= 1'b0;
	else
		slv15_awvalid <= s17 ? s15[15] : (slv15_awvalid & ~s14[15]);
end

	assign s9[15] = slv15_awvalid;
	assign s16[15] = s12 & slv15_connect & (slv15_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv15_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[15] = s16[15] & (~(|s16[14:0]));
	`else
		assign s15[15] = s16[15];
	`endif
	assign s14[15] = (slv15_aw_mid==self_id) & slv15_awready & slv15_connect;
`else
	assign s15[15] = 1'b0;
	assign s16[15] = 1'b0;
	assign s14[15] = 1'b0;
	assign s9[15] = 1'b0;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
reg slv16_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv16_awvalid <= 1'b0;
	else
		slv16_awvalid <= s17 ? s15[16] : (slv16_awvalid & ~s14[16]);
end

	assign s9[16] = slv16_awvalid;
	assign s16[16] = s12 & slv16_connect & (slv16_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv16_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[16] = s16[16] & (~(|s16[15:0]));
	`else
		assign s15[16] = s16[16];
	`endif
	assign s14[16] = (slv16_aw_mid==self_id) & slv16_awready & slv16_connect;
`else
	assign s15[16] = 1'b0;
	assign s16[16] = 1'b0;
	assign s14[16] = 1'b0;
	assign s9[16] = 1'b0;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
reg slv17_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv17_awvalid <= 1'b0;
	else
		slv17_awvalid <= s17 ? s15[17] : (slv17_awvalid & ~s14[17]);
end

	assign s9[17] = slv17_awvalid;
	assign s16[17] = s12 & slv17_connect & (slv17_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv17_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[17] = s16[17] & (~(|s16[16:0]));
	`else
		assign s15[17] = s16[17];
	`endif
	assign s14[17] = (slv17_aw_mid==self_id) & slv17_awready & slv17_connect;
`else
	assign s15[17] = 1'b0;
	assign s16[17] = 1'b0;
	assign s14[17] = 1'b0;
	assign s9[17] = 1'b0;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
reg slv18_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv18_awvalid <= 1'b0;
	else
		slv18_awvalid <= s17 ? s15[18] : (slv18_awvalid & ~s14[18]);
end

	assign s9[18] = slv18_awvalid;
	assign s16[18] = s12 & slv18_connect & (slv18_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv18_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[18] = s16[18] & (~(|s16[17:0]));
	`else
		assign s15[18] = s16[18];
	`endif
	assign s14[18] = (slv18_aw_mid==self_id) & slv18_awready & slv18_connect;
`else
	assign s15[18] = 1'b0;
	assign s16[18] = 1'b0;
	assign s14[18] = 1'b0;
	assign s9[18] = 1'b0;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
reg slv19_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv19_awvalid <= 1'b0;
	else
		slv19_awvalid <= s17 ? s15[19] : (slv19_awvalid & ~s14[19]);
end

	assign s9[19] = slv19_awvalid;
	assign s16[19] = s12 & slv19_connect & (slv19_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv19_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[19] = s16[19] & (~(|s16[18:0]));
	`else
		assign s15[19] = s16[19];
	`endif
	assign s14[19] = (slv19_aw_mid==self_id) & slv19_awready & slv19_connect;
`else
	assign s15[19] = 1'b0;
	assign s16[19] = 1'b0;
	assign s14[19] = 1'b0;
	assign s9[19] = 1'b0;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
reg slv20_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv20_awvalid <= 1'b0;
	else
		slv20_awvalid <= s17 ? s15[20] : (slv20_awvalid & ~s14[20]);
end

	assign s9[20] = slv20_awvalid;
	assign s16[20] = s12 & slv20_connect & (slv20_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv20_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[20] = s16[20] & (~(|s16[19:0]));
	`else
		assign s15[20] = s16[20];
	`endif
	assign s14[20] = (slv20_aw_mid==self_id) & slv20_awready & slv20_connect;
`else
	assign s15[20] = 1'b0;
	assign s16[20] = 1'b0;
	assign s14[20] = 1'b0;
	assign s9[20] = 1'b0;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
reg slv21_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv21_awvalid <= 1'b0;
	else
		slv21_awvalid <= s17 ? s15[21] : (slv21_awvalid & ~s14[21]);
end

	assign s9[21] = slv21_awvalid;
	assign s16[21] = s12 & slv21_connect & (slv21_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv21_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[21] = s16[21] & (~(|s16[20:0]));
	`else
		assign s15[21] = s16[21];
	`endif
	assign s14[21] = (slv21_aw_mid==self_id) & slv21_awready & slv21_connect;
`else
	assign s15[21] = 1'b0;
	assign s16[21] = 1'b0;
	assign s14[21] = 1'b0;
	assign s9[21] = 1'b0;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
reg slv22_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv22_awvalid <= 1'b0;
	else
		slv22_awvalid <= s17 ? s15[22] : (slv22_awvalid & ~s14[22]);
end

	assign s9[22] = slv22_awvalid;
	assign s16[22] = s12 & slv22_connect & (slv22_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv22_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[22] = s16[22] & (~(|s16[21:0]));
	`else
		assign s15[22] = s16[22];
	`endif
	assign s14[22] = (slv22_aw_mid==self_id) & slv22_awready & slv22_connect;
`else
	assign s15[22] = 1'b0;
	assign s16[22] = 1'b0;
	assign s14[22] = 1'b0;
	assign s9[22] = 1'b0;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
reg slv23_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv23_awvalid <= 1'b0;
	else
		slv23_awvalid <= s17 ? s15[23] : (slv23_awvalid & ~s14[23]);
end

	assign s9[23] = slv23_awvalid;
	assign s16[23] = s12 & slv23_connect & (slv23_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv23_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[23] = s16[23] & (~(|s16[22:0]));
	`else
		assign s15[23] = s16[23];
	`endif
	assign s14[23] = (slv23_aw_mid==self_id) & slv23_awready & slv23_connect;
`else
	assign s15[23] = 1'b0;
	assign s16[23] = 1'b0;
	assign s14[23] = 1'b0;
	assign s9[23] = 1'b0;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
reg slv24_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv24_awvalid <= 1'b0;
	else
		slv24_awvalid <= s17 ? s15[24] : (slv24_awvalid & ~s14[24]);
end

	assign s9[24] = slv24_awvalid;
	assign s16[24] = s12 & slv24_connect & (slv24_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv24_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[24] = s16[24] & (~(|s16[23:0]));
	`else
		assign s15[24] = s16[24];
	`endif
	assign s14[24] = (slv24_aw_mid==self_id) & slv24_awready & slv24_connect;
`else
	assign s15[24] = 1'b0;
	assign s16[24] = 1'b0;
	assign s14[24] = 1'b0;
	assign s9[24] = 1'b0;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
reg slv25_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv25_awvalid <= 1'b0;
	else
		slv25_awvalid <= s17 ? s15[25] : (slv25_awvalid & ~s14[25]);
end

	assign s9[25] = slv25_awvalid;
	assign s16[25] = s12 & slv25_connect & (slv25_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv25_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[25] = s16[25] & (~(|s16[24:0]));
	`else
		assign s15[25] = s16[25];
	`endif
	assign s14[25] = (slv25_aw_mid==self_id) & slv25_awready & slv25_connect;
`else
	assign s15[25] = 1'b0;
	assign s16[25] = 1'b0;
	assign s14[25] = 1'b0;
	assign s9[25] = 1'b0;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
reg slv26_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv26_awvalid <= 1'b0;
	else
		slv26_awvalid <= s17 ? s15[26] : (slv26_awvalid & ~s14[26]);
end

	assign s9[26] = slv26_awvalid;
	assign s16[26] = s12 & slv26_connect & (slv26_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv26_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[26] = s16[26] & (~(|s16[25:0]));
	`else
		assign s15[26] = s16[26];
	`endif
	assign s14[26] = (slv26_aw_mid==self_id) & slv26_awready & slv26_connect;
`else
	assign s15[26] = 1'b0;
	assign s16[26] = 1'b0;
	assign s14[26] = 1'b0;
	assign s9[26] = 1'b0;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
reg slv27_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv27_awvalid <= 1'b0;
	else
		slv27_awvalid <= s17 ? s15[27] : (slv27_awvalid & ~s14[27]);
end

	assign s9[27] = slv27_awvalid;
	assign s16[27] = s12 & slv27_connect & (slv27_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv27_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[27] = s16[27] & (~(|s16[26:0]));
	`else
		assign s15[27] = s16[27];
	`endif
	assign s14[27] = (slv27_aw_mid==self_id) & slv27_awready & slv27_connect;
`else
	assign s15[27] = 1'b0;
	assign s16[27] = 1'b0;
	assign s14[27] = 1'b0;
	assign s9[27] = 1'b0;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
reg slv28_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv28_awvalid <= 1'b0;
	else
		slv28_awvalid <= s17 ? s15[28] : (slv28_awvalid & ~s14[28]);
end

	assign s9[28] = slv28_awvalid;
	assign s16[28] = s12 & slv28_connect & (slv28_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv28_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[28] = s16[28] & (~(|s16[27:0]));
	`else
		assign s15[28] = s16[28];
	`endif
	assign s14[28] = (slv28_aw_mid==self_id) & slv28_awready & slv28_connect;
`else
	assign s15[28] = 1'b0;
	assign s16[28] = 1'b0;
	assign s14[28] = 1'b0;
	assign s9[28] = 1'b0;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
reg slv29_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv29_awvalid <= 1'b0;
	else
		slv29_awvalid <= s17 ? s15[29] : (slv29_awvalid & ~s14[29]);
end

	assign s9[29] = slv29_awvalid;
	assign s16[29] = s12 & slv29_connect & (slv29_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv29_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[29] = s16[29] & (~(|s16[28:0]));
	`else
		assign s15[29] = s16[29];
	`endif
	assign s14[29] = (slv29_aw_mid==self_id) & slv29_awready & slv29_connect;
`else
	assign s15[29] = 1'b0;
	assign s16[29] = 1'b0;
	assign s14[29] = 1'b0;
	assign s9[29] = 1'b0;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
reg slv30_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv30_awvalid <= 1'b0;
	else
		slv30_awvalid <= s17 ? s15[30] : (slv30_awvalid & ~s14[30]);
end

	assign s9[30] = slv30_awvalid;
	assign s16[30] = s12 & slv30_connect & (slv30_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv30_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[30] = s16[30] & (~(|s16[29:0]));
	`else
		assign s15[30] = s16[30];
	`endif
	assign s14[30] = (slv30_aw_mid==self_id) & slv30_awready & slv30_connect;
`else
	assign s15[30] = 1'b0;
	assign s16[30] = 1'b0;
	assign s14[30] = 1'b0;
	assign s9[30] = 1'b0;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
reg slv31_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv31_awvalid <= 1'b0;
	else
		slv31_awvalid <= s17 ? s15[31] : (slv31_awvalid & ~s14[31]);
end

	assign s9[31] = slv31_awvalid;
	assign s16[31] = s12 & slv31_connect & (slv31_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv31_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s15[31] = s16[31] & (~(|s16[30:0]));
	`else
		assign s15[31] = s16[31];
	`endif
	assign s14[31] = (slv31_aw_mid==self_id) & slv31_awready & slv31_connect;
`else
	assign s15[31] = 1'b0;
	assign s16[31] = 1'b0;
	assign s14[31] = 1'b0;
	assign s9[31] = 1'b0;
`endif
assign us_awready = ~s8;
assign s12 = s8 | us_awvalid;
assign s10  = s8 ? s0 : us_awaddr;
assign s11    = s8 ? s7   : us_awid;
assign s13  = s8 ? s4 : us_awlock ;
assign s17 = ~|(s9 & ~s14) & s18 & ~s19;
assign s18 = ~dec_err_wready & ~dec_err_bvalid & (s21 ? (wd_outstanding_idle & br_outstanding_idle) : aw_outstanding_ready);
assign s19 = (s13 &
                          	   (~(br_outstanding_idle & ~us_bvalid & wd_outstanding_idle) |
                                    (master_arvalid & master_arlock & (master_arid==s11)) |
                                     (mst_arlocking & (locking_arid==s11))));
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s8 <= 1'b0;
	else
		s8 <= s12 & ~s17;
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		s0  <= {ADDR_WIDTH{1'b0}};
		s1   <= 8'b0;
		s2  <= 3'b0;
		s3 <= 2'b0;
		s5 <= 4'b0;
		s4  <= 1'b0;
		s6  <= 3'b0;
		s7   <= {ID_WIDTH{1'b0}};
	end else if (us_awvalid && !s17 && !s8) begin
		s0  <=  us_awaddr ;
		s1   <=  us_awlen  ;
		s2  <=  us_awsize ;
		s3 <=  us_awburst;
		s5 <=  us_awcache;
		s4  <=  us_awlock ;
		s6  <=  us_awprot ;
		s7    <=  us_awid  ;
	end
end

always @(posedge aclk or negedge aresetn) begin
  if (!aresetn) begin
	mst_awaddr  <= {ADDR_WIDTH{1'b0}};
	mst_awlen   <= 8'b0;
	mst_awsize  <= 3'b0;
	mst_awburst <= 2'b0;
	mst_awcache <= 4'b0;
	mst_awlock  <= 1'b0;
	mst_awprot  <= 3'b0;
	mst_awid   <= {ID_WIDTH{1'b0}};
  end else if (s12 & s17) begin
	mst_awaddr  <=  s10 ;
	mst_awlen   <=  s8 ? s1   : us_awlen  ;
	mst_awsize  <=  s8 ? s2  : us_awsize ;
	mst_awburst <=  s8 ? s3 : us_awburst;
	mst_awcache <=  s8 ? s5 : us_awcache;
	mst_awlock  <=  s13;
	mst_awprot  <=  s8 ? s6  : us_awprot ;
	mst_awid   <=  s11;
  end
end

assign dec_err_bresp = 2'b11;
assign dec_err_bid = mst_awid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		dec_err_wready <= 1'b0;
	else
		dec_err_wready <= (s17 & s21) | (dec_err_wready & ~(dec_err_wvalid & dec_err_wlast));
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		dec_err_bvalid <= 1'b0;
	else
		dec_err_bvalid <= (dec_err_wready & dec_err_wvalid & dec_err_wlast) | (dec_err_bvalid & ~dec_err_bready);
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		mst_awlocking  <= 1'b0;
		locking_awid   <= {ID_WIDTH{1'b0}};
	end else if (s12 & s17 & s13) begin
		mst_awlocking  <= 1'b1;
		locking_awid   <= s11;
        end else if (us_bvalid & us_bready & (us_bid==locking_awid))
		mst_awlocking  <= 1'b0;
end

endmodule

// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"

module atcbmc300_us_read_addr_ctrl (
	  self_id,
`ifdef ATCBMC300_SLV0_SUPPORT
	  slv0_ar_mid,
	  slv0_arready,
	  slv0_masked_base_addr,
	  slv0_addr_mask,
	  slv0_arvalid,
	  slv0_connect,
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
	  slv1_ar_mid,
	  slv1_arready,
	  slv1_masked_base_addr,
	  slv1_addr_mask,
	  slv1_arvalid,
	  slv1_connect,
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
	  slv2_ar_mid,
	  slv2_arready,
	  slv2_masked_base_addr,
	  slv2_addr_mask,
	  slv2_arvalid,
	  slv2_connect,
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
	  slv3_ar_mid,
	  slv3_arready,
	  slv3_masked_base_addr,
	  slv3_addr_mask,
	  slv3_arvalid,
	  slv3_connect,
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
	  slv4_ar_mid,
	  slv4_arready,
	  slv4_masked_base_addr,
	  slv4_addr_mask,
	  slv4_arvalid,
	  slv4_connect,
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
	  slv5_ar_mid,
	  slv5_arready,
	  slv5_masked_base_addr,
	  slv5_addr_mask,
	  slv5_arvalid,
	  slv5_connect,
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
	  slv6_ar_mid,
	  slv6_arready,
	  slv6_masked_base_addr,
	  slv6_addr_mask,
	  slv6_arvalid,
	  slv6_connect,
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
	  slv7_ar_mid,
	  slv7_arready,
	  slv7_masked_base_addr,
	  slv7_addr_mask,
	  slv7_arvalid,
	  slv7_connect,
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
	  slv8_ar_mid,
	  slv8_arready,
	  slv8_masked_base_addr,
	  slv8_addr_mask,
	  slv8_arvalid,
	  slv8_connect,
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
	  slv9_ar_mid,
	  slv9_arready,
	  slv9_masked_base_addr,
	  slv9_addr_mask,
	  slv9_arvalid,
	  slv9_connect,
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
	  slv10_ar_mid,
	  slv10_arready,
	  slv10_masked_base_addr,
	  slv10_addr_mask,
	  slv10_arvalid,
	  slv10_connect,
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
	  slv11_ar_mid,
	  slv11_arready,
	  slv11_masked_base_addr,
	  slv11_addr_mask,
	  slv11_arvalid,
	  slv11_connect,
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
	  slv12_ar_mid,
	  slv12_arready,
	  slv12_masked_base_addr,
	  slv12_addr_mask,
	  slv12_arvalid,
	  slv12_connect,
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
	  slv13_ar_mid,
	  slv13_arready,
	  slv13_masked_base_addr,
	  slv13_addr_mask,
	  slv13_arvalid,
	  slv13_connect,
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
	  slv14_ar_mid,
	  slv14_arready,
	  slv14_masked_base_addr,
	  slv14_addr_mask,
	  slv14_arvalid,
	  slv14_connect,
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
	  slv15_ar_mid,
	  slv15_arready,
	  slv15_masked_base_addr,
	  slv15_addr_mask,
	  slv15_arvalid,
	  slv15_connect,
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
	  slv16_ar_mid,
	  slv16_arready,
	  slv16_masked_base_addr,
	  slv16_addr_mask,
	  slv16_arvalid,
	  slv16_connect,
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
	  slv17_ar_mid,
	  slv17_arready,
	  slv17_masked_base_addr,
	  slv17_addr_mask,
	  slv17_arvalid,
	  slv17_connect,
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
	  slv18_ar_mid,
	  slv18_arready,
	  slv18_masked_base_addr,
	  slv18_addr_mask,
	  slv18_arvalid,
	  slv18_connect,
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
	  slv19_ar_mid,
	  slv19_arready,
	  slv19_masked_base_addr,
	  slv19_addr_mask,
	  slv19_arvalid,
	  slv19_connect,
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
	  slv20_ar_mid,
	  slv20_arready,
	  slv20_masked_base_addr,
	  slv20_addr_mask,
	  slv20_arvalid,
	  slv20_connect,
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
	  slv21_ar_mid,
	  slv21_arready,
	  slv21_masked_base_addr,
	  slv21_addr_mask,
	  slv21_arvalid,
	  slv21_connect,
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
	  slv22_ar_mid,
	  slv22_arready,
	  slv22_masked_base_addr,
	  slv22_addr_mask,
	  slv22_arvalid,
	  slv22_connect,
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
	  slv23_ar_mid,
	  slv23_arready,
	  slv23_masked_base_addr,
	  slv23_addr_mask,
	  slv23_arvalid,
	  slv23_connect,
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
	  slv24_ar_mid,
	  slv24_arready,
	  slv24_masked_base_addr,
	  slv24_addr_mask,
	  slv24_arvalid,
	  slv24_connect,
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
	  slv25_ar_mid,
	  slv25_arready,
	  slv25_masked_base_addr,
	  slv25_addr_mask,
	  slv25_arvalid,
	  slv25_connect,
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
	  slv26_ar_mid,
	  slv26_arready,
	  slv26_masked_base_addr,
	  slv26_addr_mask,
	  slv26_arvalid,
	  slv26_connect,
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
	  slv27_ar_mid,
	  slv27_arready,
	  slv27_masked_base_addr,
	  slv27_addr_mask,
	  slv27_arvalid,
	  slv27_connect,
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
	  slv28_ar_mid,
	  slv28_arready,
	  slv28_masked_base_addr,
	  slv28_addr_mask,
	  slv28_arvalid,
	  slv28_connect,
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
	  slv29_ar_mid,
	  slv29_arready,
	  slv29_masked_base_addr,
	  slv29_addr_mask,
	  slv29_arvalid,
	  slv29_connect,
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
	  slv30_ar_mid,
	  slv30_arready,
	  slv30_masked_base_addr,
	  slv30_addr_mask,
	  slv30_arvalid,
	  slv30_connect,
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
	  slv31_ar_mid,
	  slv31_arready,
	  slv31_masked_base_addr,
	  slv31_addr_mask,
	  slv31_arvalid,
	  slv31_connect,
`endif
	  us_araddr,
	  us_arlen,
	  us_arsize,
	  us_arburst,
	  us_arlock,
	  us_arcache,
	  us_arprot,
	  us_arid,
	  us_arvalid,
	  us_arready,
	  mst_araddr,
	  mst_arlen,
	  mst_arsize,
	  mst_arburst,
	  mst_arlock,
	  mst_arcache,
	  mst_arprot,
	  mst_arid,
	  dec_err_rvalid,
	  us_rid,
	  us_rlast,
	  us_rready,
	  us_rvalid,
	  master_arlock,
	  master_arvalid,
	  master_arid,
	  mst_arlocking,
	  locking_arid,
	  mst_awlocking,
	  locking_awid,
	  dec_err_rready,
	  dec_err_rd_resp_data,
	  dec_err_rid,
	  ar_outstanding_en,
	  ar_outstanding_id,
	  ar_outstanding_ready,
	  ar_outstanding_idle,
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
input [3:0]        slv0_ar_mid;
input              slv0_arready;
input [64:0]	   slv0_masked_base_addr;
input [64:0]   	   slv0_addr_mask;
output		   slv0_arvalid;
input              slv0_connect;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
input [3:0]        slv1_ar_mid;
input              slv1_arready;
input [64:0]	slv1_masked_base_addr;
input [64:0]	slv1_addr_mask;
output		slv1_arvalid;
input              slv1_connect;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
input [3:0]        slv2_ar_mid;
input              slv2_arready;
input [64:0]	slv2_masked_base_addr;
input [64:0]	slv2_addr_mask;
output		slv2_arvalid;
input              slv2_connect;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
input [3:0]        slv3_ar_mid;
input              slv3_arready;
input [64:0]	slv3_masked_base_addr;
input [64:0]	slv3_addr_mask;
output		slv3_arvalid;
input              slv3_connect;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
input [3:0]        slv4_ar_mid;
input              slv4_arready;
input [64:0]	slv4_masked_base_addr;
input [64:0]	slv4_addr_mask;
output		slv4_arvalid;
input              slv4_connect;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
input [3:0]        slv5_ar_mid;
input              slv5_arready;
input [64:0]	slv5_masked_base_addr;
input [64:0]	slv5_addr_mask;
output		slv5_arvalid;
input              slv5_connect;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
input [3:0]        slv6_ar_mid;
input              slv6_arready;
input [64:0]	slv6_masked_base_addr;
input [64:0]	slv6_addr_mask;
output		slv6_arvalid;
input              slv6_connect;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
input [3:0]        slv7_ar_mid;
input              slv7_arready;
input [64:0]	slv7_masked_base_addr;
input [64:0]	slv7_addr_mask;
output		slv7_arvalid;
input              slv7_connect;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
input [3:0]        slv8_ar_mid;
input              slv8_arready;
input [64:0]	slv8_masked_base_addr;
input [64:0]	slv8_addr_mask;
output		slv8_arvalid;
input              slv8_connect;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
input [3:0]        slv9_ar_mid;
input              slv9_arready;
input [64:0]	slv9_masked_base_addr;
input [64:0]	slv9_addr_mask;
output		slv9_arvalid;
input              slv9_connect;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
input [3:0]        slv10_ar_mid;
input              slv10_arready;
input [64:0]	slv10_masked_base_addr;
input [64:0]	slv10_addr_mask;
output		slv10_arvalid;
input              slv10_connect;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
input [3:0]        slv11_ar_mid;
input              slv11_arready;
input [64:0]	slv11_masked_base_addr;
input [64:0]	slv11_addr_mask;
output		slv11_arvalid;
input              slv11_connect;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
input [3:0]        slv12_ar_mid;
input              slv12_arready;
input [64:0]	slv12_masked_base_addr;
input [64:0]	slv12_addr_mask;
output		slv12_arvalid;
input              slv12_connect;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
input [3:0]        slv13_ar_mid;
input              slv13_arready;
input [64:0]	slv13_masked_base_addr;
input [64:0]	slv13_addr_mask;
output		slv13_arvalid;
input              slv13_connect;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
input [3:0]        slv14_ar_mid;
input              slv14_arready;
input [64:0]	slv14_masked_base_addr;
input [64:0]	slv14_addr_mask;
output		slv14_arvalid;
input              slv14_connect;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
input [3:0]        slv15_ar_mid;
input              slv15_arready;
input [64:0]	slv15_masked_base_addr;
input [64:0]	slv15_addr_mask;
output		slv15_arvalid;
input              slv15_connect;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
input [3:0]        slv16_ar_mid;
input              slv16_arready;
input [64:0]	slv16_masked_base_addr;
input [64:0]	slv16_addr_mask;
output		slv16_arvalid;
input              slv16_connect;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
input [3:0]        slv17_ar_mid;
input              slv17_arready;
input [64:0]	slv17_masked_base_addr;
input [64:0]	slv17_addr_mask;
output		slv17_arvalid;
input              slv17_connect;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
input [3:0]        slv18_ar_mid;
input              slv18_arready;
input [64:0]	slv18_masked_base_addr;
input [64:0]	slv18_addr_mask;
output		slv18_arvalid;
input              slv18_connect;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
input [3:0]        slv19_ar_mid;
input              slv19_arready;
input [64:0]	slv19_masked_base_addr;
input [64:0]	slv19_addr_mask;
output		slv19_arvalid;
input              slv19_connect;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
input [3:0]        slv20_ar_mid;
input              slv20_arready;
input [64:0]	slv20_masked_base_addr;
input [64:0]	slv20_addr_mask;
output		slv20_arvalid;
input              slv20_connect;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
input [3:0]        slv21_ar_mid;
input              slv21_arready;
input [64:0]	slv21_masked_base_addr;
input [64:0]	slv21_addr_mask;
output		slv21_arvalid;
input              slv21_connect;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
input [3:0]        slv22_ar_mid;
input              slv22_arready;
input [64:0]	slv22_masked_base_addr;
input [64:0]	slv22_addr_mask;
output		slv22_arvalid;
input              slv22_connect;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
input [3:0]        slv23_ar_mid;
input              slv23_arready;
input [64:0]	slv23_masked_base_addr;
input [64:0]	slv23_addr_mask;
output		slv23_arvalid;
input              slv23_connect;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
input [3:0]        slv24_ar_mid;
input              slv24_arready;
input [64:0]	slv24_masked_base_addr;
input [64:0]	slv24_addr_mask;
output		slv24_arvalid;
input              slv24_connect;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
input [3:0]        slv25_ar_mid;
input              slv25_arready;
input [64:0]	slv25_masked_base_addr;
input [64:0]	slv25_addr_mask;
output		slv25_arvalid;
input              slv25_connect;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
input [3:0]        slv26_ar_mid;
input              slv26_arready;
input [64:0]	slv26_masked_base_addr;
input [64:0]	slv26_addr_mask;
output		slv26_arvalid;
input              slv26_connect;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
input [3:0]        slv27_ar_mid;
input              slv27_arready;
input [64:0]	slv27_masked_base_addr;
input [64:0]	slv27_addr_mask;
output		slv27_arvalid;
input              slv27_connect;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
input [3:0]        slv28_ar_mid;
input              slv28_arready;
input [64:0]	slv28_masked_base_addr;
input [64:0]	slv28_addr_mask;
output		slv28_arvalid;
input              slv28_connect;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
input [3:0]        slv29_ar_mid;
input              slv29_arready;
input [64:0]	slv29_masked_base_addr;
input [64:0]	slv29_addr_mask;
output		slv29_arvalid;
input              slv29_connect;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
input [3:0]        slv30_ar_mid;
input              slv30_arready;
input [64:0]	slv30_masked_base_addr;
input [64:0]	slv30_addr_mask;
output		slv30_arvalid;
input              slv30_connect;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
input [3:0]        slv31_ar_mid;
input              slv31_arready;
input [64:0]	slv31_masked_base_addr;
input [64:0]	slv31_addr_mask;
output		slv31_arvalid;
input              slv31_connect;
`endif
input [ADDR_MSB:0] us_araddr;
input [7:0]        us_arlen;
input [2:0]        us_arsize;
input [1:0]        us_arburst;
input 	           us_arlock;
input [3:0]        us_arcache;
input [2:0]        us_arprot;
input [ID_MSB:0]   us_arid;
input              us_arvalid;
output             us_arready;

output [ADDR_MSB:0] mst_araddr;
output [7:0]        mst_arlen;
output [2:0]        mst_arsize;
output [1:0]        mst_arburst;
output 	            mst_arlock;
output [3:0]        mst_arcache;
output [2:0]        mst_arprot;
output [ID_MSB:0]   mst_arid;
output 		    dec_err_rvalid;
input [ID_MSB:0]    us_rid;
input               us_rlast;
input               us_rready;
input               us_rvalid;
output       	    master_arlock;
output        	    master_arvalid;
output 	[ID_MSB:0]  master_arid;
output 		    mst_arlocking;
output [ID_MSB:0]   locking_arid;
input 		    mst_awlocking;
input [ID_MSB:0]    locking_awid;
input		    dec_err_rready;
output [(DATA_MSB+3):0] dec_err_rd_resp_data;
output [ID_MSB:0]   dec_err_rid;
output 		    ar_outstanding_en;
output [OUTSTAND_ID_MSB:0]  	    ar_outstanding_id;
input		    ar_outstanding_ready;
input     	    ar_outstanding_idle;
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
reg [ADDR_MSB:0] mst_araddr;
reg [7:0]        mst_arlen;
reg [2:0]        mst_arsize;
reg [1:0]        mst_arburst;
reg 	         mst_arlock;
reg [3:0]        mst_arcache;
reg [2:0]        mst_arprot;
reg [ID_MSB:0]   mst_arid;
reg 		 dec_err_rvalid;
reg 		 mst_arlocking;
reg [ID_MSB:0]   locking_arid;
wire [31:0]      s9;
wire [ADDR_MSB:0] s10;
wire [ID_MSB:0] master_arid;
wire        master_arvalid;
wire        master_arlock;
wire [31:0] s11;
wire [31:0] s12;
wire [31:0] s13;
wire        s14;
wire        s15;
wire        s16;
wire [4:0]  s17;
wire	    s18;

generate
	if (RESP_INORDER_ONLY==1) begin:only_slave_id
		assign ar_outstanding_id = s17;
	end else begin:include_arid
		assign ar_outstanding_id = {master_arid,s17};
	end
endgenerate

assign s17[4] =  |s12[31:16];
assign s17[3] = |{s12[31:24],s12[15:08]};
assign s17[2] = |{s12[31:28],s12[23:20],
     	          	   s12[15:12],s12[07:04]};
assign s17[1] = |{s12[31:30],s12[27:26],
                           s12[23:22],s12[19:18],
                           s12[15:14],s12[11:10],
                           s12[07:06],s12[03:02]};
assign s17[0] = |{s12[31],s12[29],s12[27],s12[25],
                           s12[23],s12[21],s12[19],s12[17],
                           s12[15],s12[13],s12[11],s12[09],
                           s12[07],s12[05],s12[03],s12[01]};
assign s18 = master_arvalid & (~|s12);
assign ar_outstanding_en = (|s12) & s14;

`ifdef ATCBMC300_SLV0_SUPPORT
reg slv0_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv0_arvalid <= 1'b0;
	else
		slv0_arvalid <= s14 ? s12[0] : (slv0_arvalid & ~s11[0]);
end

	assign s9[0] = slv0_arvalid;
	assign s13[0] = master_arvalid & slv0_connect & (slv0_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv0_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[0] = s13[0];
	`else
		assign s12[0] = s13[0];
	`endif
	assign s11[0] = (slv0_ar_mid==self_id) & slv0_arready & slv0_connect;
`else
	assign    s12[0] = 1'b0;
	assign    s13[0] = 1'b0;
	assign s11[0] = 1'b0;
	assign   s9[0] = 1'b0;
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
reg slv1_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv1_arvalid <= 1'b0;
	else
		slv1_arvalid <= s14 ? s12[1] : (slv1_arvalid & ~s11[1]);
end

	assign s9[1] = slv1_arvalid;
	assign s13[1] = master_arvalid & slv1_connect & (slv1_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv1_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[1] = s13[1] & (~s13[0]);
	`else
		assign s12[1] = s13[1];
	`endif
	assign s11[1] = (slv1_ar_mid==self_id) & slv1_arready & slv1_connect;
`else
	assign    s12[1] = 1'b0;
	assign    s13[1] = 1'b0;
	assign s11[1] = 1'b0;
	assign   s9[1] = 1'b0;
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
reg slv2_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv2_arvalid <= 1'b0;
	else
		slv2_arvalid <= s14 ? s12[2] : (slv2_arvalid & ~s11[2]);
end

	assign s9[2] = slv2_arvalid;
	assign s13[2] = master_arvalid & slv2_connect & (slv2_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv2_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[2] = s13[2] & (~(|s13[1:0]));
	`else
		assign s12[2] = s13[2];
	`endif
	assign s11[2] = (slv2_ar_mid==self_id) & slv2_arready & slv2_connect;
`else
	assign    s12[2] = 1'b0;
	assign    s13[2] = 1'b0;
	assign s11[2] = 1'b0;
	assign   s9[2] = 1'b0;
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
reg slv3_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv3_arvalid <= 1'b0;
	else
		slv3_arvalid <= s14 ? s12[3] : (slv3_arvalid & ~s11[3]);
end

	assign s9[3] = slv3_arvalid;
	assign s13[3] = master_arvalid & slv3_connect & (slv3_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv3_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[3] = s13[3] & (~(|s13[2:0]));
	`else
		assign s12[3] = s13[3];
	`endif
	assign s11[3] = (slv3_ar_mid==self_id) & slv3_arready & slv3_connect;
`else
	assign    s12[3] = 1'b0;
	assign    s13[3] = 1'b0;
	assign s11[3] = 1'b0;
	assign   s9[3] = 1'b0;
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
reg slv4_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv4_arvalid <= 1'b0;
	else
		slv4_arvalid <= s14 ? s12[4] : (slv4_arvalid & ~s11[4]);
end

	assign s9[4] = slv4_arvalid;
	assign s13[4] = master_arvalid & slv4_connect & (slv4_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv4_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[4] = s13[4] & (~(|s13[3:0]));
	`else
		assign s12[4] = s13[4];
	`endif
	assign s11[4] = (slv4_ar_mid==self_id) & slv4_arready & slv4_connect;
`else
	assign    s12[4] = 1'b0;
	assign    s13[4] = 1'b0;
	assign s11[4] = 1'b0;
	assign   s9[4] = 1'b0;
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
reg slv5_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv5_arvalid <= 1'b0;
	else
		slv5_arvalid <= s14 ? s12[5] : (slv5_arvalid & ~s11[5]);
end

	assign s9[5] = slv5_arvalid;
	assign s13[5] = master_arvalid & slv5_connect & (slv5_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv5_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[5] = s13[5] & (~(|s13[4:0]));
	`else
		assign s12[5] = s13[5];
	`endif
	assign s11[5] = (slv5_ar_mid==self_id) & slv5_arready & slv5_connect;
`else
	assign    s12[5] = 1'b0;
	assign    s13[5] = 1'b0;
	assign s11[5] = 1'b0;
	assign   s9[5] = 1'b0;
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
reg slv6_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv6_arvalid <= 1'b0;
	else
		slv6_arvalid <= s14 ? s12[6] : (slv6_arvalid & ~s11[6]);
end

	assign s9[6] = slv6_arvalid;
	assign s13[6] = master_arvalid & slv6_connect & (slv6_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv6_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[6] = s13[6] & (~(|s13[5:0]));
	`else
		assign s12[6] = s13[6];
	`endif
	assign s11[6] = (slv6_ar_mid==self_id) & slv6_arready & slv6_connect;
`else
	assign    s12[6] = 1'b0;
	assign    s13[6] = 1'b0;
	assign s11[6] = 1'b0;
	assign   s9[6] = 1'b0;
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
reg slv7_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv7_arvalid <= 1'b0;
	else
		slv7_arvalid <= s14 ? s12[7] : (slv7_arvalid & ~s11[7]);
end

	assign s9[7] = slv7_arvalid;
	assign s13[7] = master_arvalid & slv7_connect & (slv7_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv7_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[7] = s13[7] & (~(|s13[6:0]));
	`else
		assign s12[7] = s13[7];
	`endif
	assign s11[7] = (slv7_ar_mid==self_id) & slv7_arready & slv7_connect;
`else
	assign    s12[7] = 1'b0;
	assign    s13[7] = 1'b0;
	assign s11[7] = 1'b0;
	assign   s9[7] = 1'b0;
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
reg slv8_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv8_arvalid <= 1'b0;
	else
		slv8_arvalid <= s14 ? s12[8] : (slv8_arvalid & ~s11[8]);
end

	assign s9[8] = slv8_arvalid;
	assign s13[8] = master_arvalid & slv8_connect & (slv8_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv8_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[8] = s13[8] & (~(|s13[7:0]));
	`else
		assign s12[8] = s13[8];
	`endif
	assign s11[8] = (slv8_ar_mid==self_id) & slv8_arready & slv8_connect;
`else
	assign    s12[8] = 1'b0;
	assign    s13[8] = 1'b0;
	assign s11[8] = 1'b0;
	assign   s9[8] = 1'b0;
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
reg slv9_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv9_arvalid <= 1'b0;
	else
		slv9_arvalid <= s14 ? s12[9] : (slv9_arvalid & ~s11[9]);
end

	assign s9[9] = slv9_arvalid;
	assign s13[9] = master_arvalid & slv9_connect & (slv9_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv9_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[9] = s13[9] & (~(|s13[8:0]));
	`else
		assign s12[9] = s13[9];
	`endif
	assign s11[9] = (slv9_ar_mid==self_id) & slv9_arready & slv9_connect;
`else
	assign    s12[9] = 1'b0;
	assign    s13[9] = 1'b0;
	assign s11[9] = 1'b0;
	assign   s9[9] = 1'b0;
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
reg slv10_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv10_arvalid <= 1'b0;
	else
		slv10_arvalid <= s14 ? s12[10] : (slv10_arvalid & ~s11[10]);
end

	assign s9[10] = slv10_arvalid;
	assign s13[10] = master_arvalid & slv10_connect & (slv10_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv10_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[10] = s13[10] & (~(|s13[9:0]));
	`else
		assign s12[10] = s13[10];
	`endif
	assign s11[10] = (slv10_ar_mid==self_id) & slv10_arready & slv10_connect;
`else
	assign    s12[10] = 1'b0;
	assign    s13[10] = 1'b0;
	assign s11[10] = 1'b0;
	assign   s9[10] = 1'b0;
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
reg slv11_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv11_arvalid <= 1'b0;
	else
		slv11_arvalid <= s14 ? s12[11] : (slv11_arvalid & ~s11[11]);
end

	assign s9[11] = slv11_arvalid;
	assign s13[11] = master_arvalid & slv11_connect & (slv11_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv11_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[11] = s13[11] & (~(|s13[10:0]));
	`else
		assign s12[11] = s13[11];
	`endif
	assign s11[11] = (slv11_ar_mid==self_id) & slv11_arready & slv11_connect;
`else
	assign    s12[11] = 1'b0;
	assign    s13[11] = 1'b0;
	assign s11[11] = 1'b0;
	assign   s9[11] = 1'b0;
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
reg slv12_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv12_arvalid <= 1'b0;
	else
		slv12_arvalid <= s14 ? s12[12] : (slv12_arvalid & ~s11[12]);
end

	assign s9[12] = slv12_arvalid;
	assign s13[12] = master_arvalid & slv12_connect & (slv12_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv12_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[12] = s13[12] & (~(|s13[11:0]));
	`else
		assign s12[12] = s13[12];
	`endif
	assign s11[12] = (slv12_ar_mid==self_id) & slv12_arready & slv12_connect;
`else
	assign    s12[12] = 1'b0;
	assign    s13[12] = 1'b0;
	assign s11[12] = 1'b0;
	assign   s9[12] = 1'b0;
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
reg slv13_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv13_arvalid <= 1'b0;
	else
		slv13_arvalid <= s14 ? s12[13] : (slv13_arvalid & ~s11[13]);
end

	assign s9[13] = slv13_arvalid;
	assign s13[13] = master_arvalid & slv13_connect & (slv13_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv13_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[13] = s13[13] & (~(|s13[12:0]));
	`else
		assign s12[13] = s13[13];
	`endif
	assign s11[13] = (slv13_ar_mid==self_id) & slv13_arready & slv13_connect;
`else
	assign    s12[13] = 1'b0;
	assign    s13[13] = 1'b0;
	assign s11[13] = 1'b0;
	assign   s9[13] = 1'b0;
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
reg slv14_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv14_arvalid <= 1'b0;
	else
		slv14_arvalid <= s14 ? s12[14] : (slv14_arvalid & ~s11[14]);
end

	assign s9[14] = slv14_arvalid;
	assign s13[14] = master_arvalid & slv14_connect & (slv14_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv14_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[14] = s13[14] & (~(|s13[13:0]));
	`else
		assign s12[14] = s13[14];
	`endif
	assign s11[14] = (slv14_ar_mid==self_id) & slv14_arready & slv14_connect;
`else
	assign    s12[14] = 1'b0;
	assign    s13[14] = 1'b0;
	assign s11[14] = 1'b0;
	assign   s9[14] = 1'b0;
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
reg slv15_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv15_arvalid <= 1'b0;
	else
		slv15_arvalid <= s14 ? s12[15] : (slv15_arvalid & ~s11[15]);
end

	assign s9[15] = slv15_arvalid;
	assign s13[15] = master_arvalid & slv15_connect & (slv15_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv15_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[15] = s13[15] & (~(|s13[14:0]));
	`else
		assign s12[15] = s13[15];
	`endif
	assign s11[15] = (slv15_ar_mid==self_id) & slv15_arready & slv15_connect;
`else
	assign    s12[15] = 1'b0;
	assign    s13[15] = 1'b0;
	assign s11[15] = 1'b0;
	assign   s9[15] = 1'b0;
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
reg slv16_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv16_arvalid <= 1'b0;
	else
		slv16_arvalid <= s14 ? s12[16] : (slv16_arvalid & ~s11[16]);
end

	assign s9[16] = slv16_arvalid;
	assign s13[16] = master_arvalid & slv16_connect & (slv16_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv16_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[16] = s13[16] & (~(|s13[15:0]));
	`else
		assign s12[16] = s13[16];
	`endif
	assign s11[16] = (slv16_ar_mid==self_id) & slv16_arready & slv16_connect;
`else
	assign    s12[16] = 1'b0;
	assign    s13[16] = 1'b0;
	assign s11[16] = 1'b0;
	assign   s9[16] = 1'b0;
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
reg slv17_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv17_arvalid <= 1'b0;
	else
		slv17_arvalid <= s14 ? s12[17] : (slv17_arvalid & ~s11[17]);
end

	assign s9[17] = slv17_arvalid;
	assign s13[17] = master_arvalid & slv17_connect & (slv17_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv17_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[17] = s13[17] & (~(|s13[16:0]));
	`else
		assign s12[17] = s13[17];
	`endif
	assign s11[17] = (slv17_ar_mid==self_id) & slv17_arready & slv17_connect;
`else
	assign    s12[17] = 1'b0;
	assign    s13[17] = 1'b0;
	assign s11[17] = 1'b0;
	assign   s9[17] = 1'b0;
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
reg slv18_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv18_arvalid <= 1'b0;
	else
		slv18_arvalid <= s14 ? s12[18] : (slv18_arvalid & ~s11[18]);
end

	assign s9[18] = slv18_arvalid;
	assign s13[18] = master_arvalid & slv18_connect & (slv18_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv18_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[18] = s13[18] & (~(|s13[17:0]));
	`else
		assign s12[18] = s13[18];
	`endif
	assign s11[18] = (slv18_ar_mid==self_id) & slv18_arready & slv18_connect;
`else
	assign    s12[18] = 1'b0;
	assign    s13[18] = 1'b0;
	assign s11[18] = 1'b0;
	assign   s9[18] = 1'b0;
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
reg slv19_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv19_arvalid <= 1'b0;
	else
		slv19_arvalid <= s14 ? s12[19] : (slv19_arvalid & ~s11[19]);
end

	assign s9[19] = slv19_arvalid;
	assign s13[19] = master_arvalid & slv19_connect & (slv19_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv19_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[19] = s13[19] & (~(|s13[18:0]));
	`else
		assign s12[19] = s13[19];
	`endif
	assign s11[19] = (slv19_ar_mid==self_id) & slv19_arready & slv19_connect;
`else
	assign    s12[19] = 1'b0;
	assign    s13[19] = 1'b0;
	assign s11[19] = 1'b0;
	assign   s9[19] = 1'b0;
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
reg slv20_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv20_arvalid <= 1'b0;
	else
		slv20_arvalid <= s14 ? s12[20] : (slv20_arvalid & ~s11[20]);
end

	assign s9[20] = slv20_arvalid;
	assign s13[20] = master_arvalid & slv20_connect & (slv20_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv20_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[20] = s13[20] & (~(|s13[19:0]));
	`else
		assign s12[20] = s13[20];
	`endif
	assign s11[20] = (slv20_ar_mid==self_id) & slv20_arready & slv20_connect;
`else
	assign    s12[20] = 1'b0;
	assign    s13[20] = 1'b0;
	assign s11[20] = 1'b0;
	assign   s9[20] = 1'b0;
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
reg slv21_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv21_arvalid <= 1'b0;
	else
		slv21_arvalid <= s14 ? s12[21] : (slv21_arvalid & ~s11[21]);
end

	assign s9[21] = slv21_arvalid;
	assign s13[21] = master_arvalid & slv21_connect & (slv21_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv21_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[21] = s13[21] & (~(|s13[20:0]));
	`else
		assign s12[21] = s13[21];
	`endif
	assign s11[21] = (slv21_ar_mid==self_id) & slv21_arready & slv21_connect;
`else
	assign    s12[21] = 1'b0;
	assign    s13[21] = 1'b0;
	assign s11[21] = 1'b0;
	assign   s9[21] = 1'b0;
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
reg slv22_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv22_arvalid <= 1'b0;
	else
		slv22_arvalid <= s14 ? s12[22] : (slv22_arvalid & ~s11[22]);
end

	assign s9[22] = slv22_arvalid;
	assign s13[22] = master_arvalid & slv22_connect & (slv22_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv22_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[22] = s13[22] & (~(|s13[21:0]));
	`else
		assign s12[22] = s13[22];
	`endif
	assign s11[22] = (slv22_ar_mid==self_id) & slv22_arready & slv22_connect;
`else
	assign    s12[22] = 1'b0;
	assign    s13[22] = 1'b0;
	assign s11[22] = 1'b0;
	assign   s9[22] = 1'b0;
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
reg slv23_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv23_arvalid <= 1'b0;
	else
		slv23_arvalid <= s14 ? s12[23] : (slv23_arvalid & ~s11[23]);
end

	assign s9[23] = slv23_arvalid;
	assign s13[23] = master_arvalid & slv23_connect & (slv23_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv23_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[23] = s13[23] & (~(|s13[22:0]));
	`else
		assign s12[23] = s13[23];
	`endif
	assign s11[23] = (slv23_ar_mid==self_id) & slv23_arready & slv23_connect;
`else
	assign    s12[23] = 1'b0;
	assign    s13[23] = 1'b0;
	assign s11[23] = 1'b0;
	assign   s9[23] = 1'b0;
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
reg slv24_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv24_arvalid <= 1'b0;
	else
		slv24_arvalid <= s14 ? s12[24] : (slv24_arvalid & ~s11[24]);
end

	assign s9[24] = slv24_arvalid;
	assign s13[24] = master_arvalid & slv24_connect & (slv24_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv24_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[24] = s13[24] & (~(|s13[23:0]));
	`else
		assign s12[24] = s13[24];
	`endif
	assign s11[24] = (slv24_ar_mid==self_id) & slv24_arready & slv24_connect;
`else
	assign    s12[24] = 1'b0;
	assign    s13[24] = 1'b0;
	assign s11[24] = 1'b0;
	assign   s9[24] = 1'b0;
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
reg slv25_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv25_arvalid <= 1'b0;
	else
		slv25_arvalid <= s14 ? s12[25] : (slv25_arvalid & ~s11[25]);
end

	assign s9[25] = slv25_arvalid;
	assign s13[25] = master_arvalid & slv25_connect & (slv25_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv25_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[25] = s13[25] & (~(|s13[24:0]));
	`else
		assign s12[25] = s13[25];
	`endif
	assign s11[25] = (slv25_ar_mid==self_id) & slv25_arready & slv25_connect;
`else
	assign    s12[25] = 1'b0;
	assign    s13[25] = 1'b0;
	assign s11[25] = 1'b0;
	assign   s9[25] = 1'b0;
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
reg slv26_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv26_arvalid <= 1'b0;
	else
		slv26_arvalid <= s14 ? s12[26] : (slv26_arvalid & ~s11[26]);
end

	assign s9[26] = slv26_arvalid;
	assign s13[26] = master_arvalid & slv26_connect & (slv26_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv26_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[26] = s13[26] & (~(|s13[25:0]));
	`else
		assign s12[26] = s13[26];
	`endif
	assign s11[26] = (slv26_ar_mid==self_id) & slv26_arready & slv26_connect;
`else
	assign    s12[26] = 1'b0;
	assign    s13[26] = 1'b0;
	assign s11[26] = 1'b0;
	assign   s9[26] = 1'b0;
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
reg slv27_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv27_arvalid <= 1'b0;
	else
		slv27_arvalid <= s14 ? s12[27] : (slv27_arvalid & ~s11[27]);
end

	assign s9[27] = slv27_arvalid;
	assign s13[27] = master_arvalid & slv27_connect & (slv27_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv27_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[27] = s13[27] & (~(|s13[26:0]));
	`else
		assign s12[27] = s13[27];
	`endif
	assign s11[27] = (slv27_ar_mid==self_id) & slv27_arready & slv27_connect;
`else
	assign    s12[27] = 1'b0;
	assign    s13[27] = 1'b0;
	assign s11[27] = 1'b0;
	assign   s9[27] = 1'b0;
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
reg slv28_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv28_arvalid <= 1'b0;
	else
		slv28_arvalid <= s14 ? s12[28] : (slv28_arvalid & ~s11[28]);
end

	assign s9[28] = slv28_arvalid;
	assign s13[28] = master_arvalid & slv28_connect & (slv28_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv28_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[28] = s13[28] & (~(|s13[27:0]));
	`else
		assign s12[28] = s13[28];
	`endif
	assign s11[28] = (slv28_ar_mid==self_id) & slv28_arready & slv28_connect;
`else
	assign    s12[28] = 1'b0;
	assign    s13[28] = 1'b0;
	assign s11[28] = 1'b0;
	assign   s9[28] = 1'b0;
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
reg slv29_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv29_arvalid <= 1'b0;
	else
		slv29_arvalid <= s14 ? s12[29] : (slv29_arvalid & ~s11[29]);
end

	assign s9[29] = slv29_arvalid;
	assign s13[29] = master_arvalid & slv29_connect & (slv29_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv29_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[29] = s13[29] & (~(|s13[28:0]));
	`else
		assign s12[29] = s13[29];
	`endif
	assign s11[29] = (slv29_ar_mid==self_id) & slv29_arready & slv29_connect;
`else
	assign    s12[29] = 1'b0;
	assign    s13[29] = 1'b0;
	assign s11[29] = 1'b0;
	assign   s9[29] = 1'b0;
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
reg slv30_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv30_arvalid <= 1'b0;
	else
		slv30_arvalid <= s14 ? s12[30] : (slv30_arvalid & ~s11[30]);
end

	assign s9[30] = slv30_arvalid;
	assign s13[30] = master_arvalid & slv30_connect & (slv30_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv30_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[30] = s13[30] & (~(|s13[29:0]));
	`else
		assign s12[30] = s13[30];
	`endif
	assign s11[30] = (slv30_ar_mid==self_id) & slv30_arready & slv30_connect;
`else
	assign    s12[30] = 1'b0;
	assign    s13[30] = 1'b0;
	assign s11[30] = 1'b0;
	assign   s9[30] = 1'b0;
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
reg slv31_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv31_arvalid <= 1'b0;
	else
		slv31_arvalid <= s14 ? s12[31] : (slv31_arvalid & ~s11[31]);
end

	assign s9[31] = slv31_arvalid;
	assign s13[31] = master_arvalid & slv31_connect & (slv31_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv31_addr_mask));
	`ifdef ATCBMC300_PRIORITY_DECODE
		assign s12[31] = s13[31] & (~(|s13[30:0]));
	`else
		assign s12[31] = s13[31];
	`endif
	assign s11[31] = (slv31_ar_mid==self_id) & slv31_arready & slv31_connect;
`else
	assign    s12[31] = 1'b0;
	assign    s13[31] = 1'b0;
	assign s11[31] = 1'b0;
	assign   s9[31] = 1'b0;
`endif
assign us_arready = ~s8;
assign master_arvalid = s8 | us_arvalid;
assign s10  = s8 ? s0 : us_araddr;
assign master_arid    = s8 ? s7   : us_arid;
assign master_arlock  = s8 ? s4  : us_arlock ;
assign s14 = ~|(s9 & ~s11) & s15 & ~s16;
assign s15 = ~dec_err_rvalid & (s18 ? ar_outstanding_idle : ar_outstanding_ready);
assign s16 = (master_arlock & (~(ar_outstanding_idle & ~us_rvalid) |
                                                   (mst_awlocking & (locking_awid==master_arid))));

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s8 <= 1'b0;
	else
		s8 <= master_arvalid & ~s14;
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
	end else if (us_arvalid & ~s14 & ~s8) begin
		s0  <=  us_araddr ;
		s1   <=  us_arlen  ;
		s2  <=  us_arsize ;
		s3 <=  us_arburst;
		s5 <=  us_arcache;
		s4  <=  us_arlock ;
		s6  <=  us_arprot ;
		s7    <=  us_arid  ;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		mst_araddr  <= {ADDR_WIDTH{1'b0}};
		mst_arsize  <= 3'b0;
		mst_arburst <= 2'b0;
		mst_arcache <= 4'b0;
		mst_arlock  <= 1'b0;
		mst_arprot  <= 3'b0;
		mst_arid   <= {ID_WIDTH{1'b0}};
	end else if (master_arvalid && s14) begin
		mst_araddr  <=  s10 ;
		mst_arsize  <=  s8 ? s2  : us_arsize ;
		mst_arburst <=  s8 ? s3 : us_arburst;
		mst_arcache <=  s8 ? s5 : us_arcache;
		mst_arlock  <=  master_arlock;
		mst_arprot  <=  s8 ? s6  : us_arprot ;
		mst_arid   <=  master_arid;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		mst_arlen   <= 8'h0;
	else if (master_arvalid && s14)
		mst_arlen   <=  s8 ? s1   : us_arlen  ;
	else
		mst_arlen   <=  mst_arlen - {7'b0,dec_err_rvalid & dec_err_rready & (mst_arlen!=8'h0)};
end

assign dec_err_rd_resp_data = {2'b11, (mst_arlen==8'h0), {DATA_WIDTH{1'b0}}};
assign dec_err_rid = mst_arid;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		dec_err_rvalid <= 1'b0;
	else
		dec_err_rvalid <= s14 ? s18 : (dec_err_rvalid & ~(dec_err_rready & (mst_arlen==8'h0)));
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		mst_arlocking  <= 1'b0;
		locking_arid   <= {ID_WIDTH{1'b0}};
	end else if (master_arvalid & s14 & master_arlock) begin
		mst_arlocking  <= 1'b1;
		locking_arid   <= master_arid;
        end else if (us_rvalid & us_rready & us_rlast & (us_rid==locking_arid))
		mst_arlocking  <= 1'b0;
end

endmodule

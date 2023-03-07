// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc301_config.vh"
`include "atcbmc301_const.vh"

module atcbmc301_us_write_addr_ctrl (
	  self_id,
`ifdef ATCBMC301_SLV1_SUPPORT
	  slv1_aw_mid,
	  slv1_awready,
	  slv1_masked_base_addr,
	  slv1_addr_mask,
	  slv1_awvalid,
	  slv1_connect,
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
	  slv2_aw_mid,
	  slv2_awready,
	  slv2_masked_base_addr,
	  slv2_addr_mask,
	  slv2_awvalid,
	  slv2_connect,
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
	  slv3_aw_mid,
	  slv3_awready,
	  slv3_masked_base_addr,
	  slv3_addr_mask,
	  slv3_awvalid,
	  slv3_connect,
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

`ifdef ATCBMC301_SLV1_SUPPORT
input [3:0]        slv1_aw_mid;
input              slv1_awready;
input [64:0]	   slv1_masked_base_addr;
input [64:0]	   slv1_addr_mask;
output		   slv1_awvalid;
input              slv1_connect;
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
input [3:0]        slv2_aw_mid;
input              slv2_awready;
input [64:0]	slv2_masked_base_addr;
input [64:0]	slv2_addr_mask;
output		slv2_awvalid;
input              slv2_connect;
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
input [3:0]        slv3_aw_mid;
input              slv3_awready;
input [64:0]	slv3_masked_base_addr;
input [64:0]	slv3_addr_mask;
output		slv3_awvalid;
input              slv3_connect;
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



	assign s15[0] = 1'b0;
	assign s16[0] = 1'b0;
	assign s14[0] = 1'b0;
	assign s9[0] = 1'b0;

`ifdef ATCBMC301_SLV1_SUPPORT
reg slv1_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv1_awvalid <= 1'b0;
	else
		slv1_awvalid <= s17 ? s15[1] : (slv1_awvalid & ~s14[1]);
end

	assign s9[1] = slv1_awvalid;
	assign s16[1] = s12 & slv1_connect & (slv1_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv1_addr_mask));
	`ifdef ATCBMC301_PRIORITY_DECODE
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
`ifdef ATCBMC301_SLV2_SUPPORT
reg slv2_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv2_awvalid <= 1'b0;
	else
		slv2_awvalid <= s17 ? s15[2] : (slv2_awvalid & ~s14[2]);
end

	assign s9[2] = slv2_awvalid;
	assign s16[2] = s12 & slv2_connect & (slv2_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv2_addr_mask));
	`ifdef ATCBMC301_PRIORITY_DECODE
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
`ifdef ATCBMC301_SLV3_SUPPORT
reg slv3_awvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv3_awvalid <= 1'b0;
	else
		slv3_awvalid <= s17 ? s15[3] : (slv3_awvalid & ~s14[3]);
end

	assign s9[3] = slv3_awvalid;
	assign s16[3] = s12 & slv3_connect & (slv3_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv3_addr_mask));
	`ifdef ATCBMC301_PRIORITY_DECODE
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

	assign s15[4] = 1'b0;
	assign s16[4] = 1'b0;
	assign s14[4] = 1'b0;
	assign s9[4] = 1'b0;


	assign s15[5] = 1'b0;
	assign s16[5] = 1'b0;
	assign s14[5] = 1'b0;
	assign s9[5] = 1'b0;


	assign s15[6] = 1'b0;
	assign s16[6] = 1'b0;
	assign s14[6] = 1'b0;
	assign s9[6] = 1'b0;


	assign s15[7] = 1'b0;
	assign s16[7] = 1'b0;
	assign s14[7] = 1'b0;
	assign s9[7] = 1'b0;


	assign s15[8] = 1'b0;
	assign s16[8] = 1'b0;
	assign s14[8] = 1'b0;
	assign s9[8] = 1'b0;


	assign s15[9] = 1'b0;
	assign s16[9] = 1'b0;
	assign s14[9] = 1'b0;
	assign s9[9] = 1'b0;


	assign s15[10] = 1'b0;
	assign s16[10] = 1'b0;
	assign s14[10] = 1'b0;
	assign s9[10] = 1'b0;


	assign s15[11] = 1'b0;
	assign s16[11] = 1'b0;
	assign s14[11] = 1'b0;
	assign s9[11] = 1'b0;


	assign s15[12] = 1'b0;
	assign s16[12] = 1'b0;
	assign s14[12] = 1'b0;
	assign s9[12] = 1'b0;


	assign s15[13] = 1'b0;
	assign s16[13] = 1'b0;
	assign s14[13] = 1'b0;
	assign s9[13] = 1'b0;


	assign s15[14] = 1'b0;
	assign s16[14] = 1'b0;
	assign s14[14] = 1'b0;
	assign s9[14] = 1'b0;


	assign s15[15] = 1'b0;
	assign s16[15] = 1'b0;
	assign s14[15] = 1'b0;
	assign s9[15] = 1'b0;


	assign s15[16] = 1'b0;
	assign s16[16] = 1'b0;
	assign s14[16] = 1'b0;
	assign s9[16] = 1'b0;


	assign s15[17] = 1'b0;
	assign s16[17] = 1'b0;
	assign s14[17] = 1'b0;
	assign s9[17] = 1'b0;


	assign s15[18] = 1'b0;
	assign s16[18] = 1'b0;
	assign s14[18] = 1'b0;
	assign s9[18] = 1'b0;


	assign s15[19] = 1'b0;
	assign s16[19] = 1'b0;
	assign s14[19] = 1'b0;
	assign s9[19] = 1'b0;


	assign s15[20] = 1'b0;
	assign s16[20] = 1'b0;
	assign s14[20] = 1'b0;
	assign s9[20] = 1'b0;


	assign s15[21] = 1'b0;
	assign s16[21] = 1'b0;
	assign s14[21] = 1'b0;
	assign s9[21] = 1'b0;


	assign s15[22] = 1'b0;
	assign s16[22] = 1'b0;
	assign s14[22] = 1'b0;
	assign s9[22] = 1'b0;


	assign s15[23] = 1'b0;
	assign s16[23] = 1'b0;
	assign s14[23] = 1'b0;
	assign s9[23] = 1'b0;


	assign s15[24] = 1'b0;
	assign s16[24] = 1'b0;
	assign s14[24] = 1'b0;
	assign s9[24] = 1'b0;


	assign s15[25] = 1'b0;
	assign s16[25] = 1'b0;
	assign s14[25] = 1'b0;
	assign s9[25] = 1'b0;


	assign s15[26] = 1'b0;
	assign s16[26] = 1'b0;
	assign s14[26] = 1'b0;
	assign s9[26] = 1'b0;


	assign s15[27] = 1'b0;
	assign s16[27] = 1'b0;
	assign s14[27] = 1'b0;
	assign s9[27] = 1'b0;


	assign s15[28] = 1'b0;
	assign s16[28] = 1'b0;
	assign s14[28] = 1'b0;
	assign s9[28] = 1'b0;


	assign s15[29] = 1'b0;
	assign s16[29] = 1'b0;
	assign s14[29] = 1'b0;
	assign s9[29] = 1'b0;


	assign s15[30] = 1'b0;
	assign s16[30] = 1'b0;
	assign s14[30] = 1'b0;
	assign s9[30] = 1'b0;


	assign s15[31] = 1'b0;
	assign s16[31] = 1'b0;
	assign s14[31] = 1'b0;
	assign s9[31] = 1'b0;

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

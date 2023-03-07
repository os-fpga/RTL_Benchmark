// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc301_config.vh"
`include "atcbmc301_const.vh"

module atcbmc301_us_read_addr_ctrl (
	  self_id,
`ifdef ATCBMC301_SLV1_SUPPORT
	  slv1_ar_mid,
	  slv1_arready,
	  slv1_masked_base_addr,
	  slv1_addr_mask,
	  slv1_arvalid,
	  slv1_connect,
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
	  slv2_ar_mid,
	  slv2_arready,
	  slv2_masked_base_addr,
	  slv2_addr_mask,
	  slv2_arvalid,
	  slv2_connect,
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
	  slv3_ar_mid,
	  slv3_arready,
	  slv3_masked_base_addr,
	  slv3_addr_mask,
	  slv3_arvalid,
	  slv3_connect,
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

`ifdef ATCBMC301_SLV1_SUPPORT
input [3:0]        slv1_ar_mid;
input              slv1_arready;
input [64:0]	slv1_masked_base_addr;
input [64:0]	slv1_addr_mask;
output		slv1_arvalid;
input              slv1_connect;
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
input [3:0]        slv2_ar_mid;
input              slv2_arready;
input [64:0]	slv2_masked_base_addr;
input [64:0]	slv2_addr_mask;
output		slv2_arvalid;
input              slv2_connect;
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
input [3:0]        slv3_ar_mid;
input              slv3_arready;
input [64:0]	slv3_masked_base_addr;
input [64:0]	slv3_addr_mask;
output		slv3_arvalid;
input              slv3_connect;
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


	assign    s12[0] = 1'b0;
	assign    s13[0] = 1'b0;
	assign s11[0] = 1'b0;
	assign   s9[0] = 1'b0;

`ifdef ATCBMC301_SLV1_SUPPORT
reg slv1_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv1_arvalid <= 1'b0;
	else
		slv1_arvalid <= s14 ? s12[1] : (slv1_arvalid & ~s11[1]);
end

	assign s9[1] = slv1_arvalid;
	assign s13[1] = master_arvalid & slv1_connect & (slv1_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv1_addr_mask));
	`ifdef ATCBMC301_PRIORITY_DECODE
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
`ifdef ATCBMC301_SLV2_SUPPORT
reg slv2_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv2_arvalid <= 1'b0;
	else
		slv2_arvalid <= s14 ? s12[2] : (slv2_arvalid & ~s11[2]);
end

	assign s9[2] = slv2_arvalid;
	assign s13[2] = master_arvalid & slv2_connect & (slv2_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv2_addr_mask));
	`ifdef ATCBMC301_PRIORITY_DECODE
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
`ifdef ATCBMC301_SLV3_SUPPORT
reg slv3_arvalid;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		slv3_arvalid <= 1'b0;
	else
		slv3_arvalid <= s14 ? s12[3] : (slv3_arvalid & ~s11[3]);
end

	assign s9[3] = slv3_arvalid;
	assign s13[3] = master_arvalid & slv3_connect & (slv3_masked_base_addr==({{(65-ADDR_WIDTH){1'b0}},s10} & slv3_addr_mask));
	`ifdef ATCBMC301_PRIORITY_DECODE
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

	assign    s12[4] = 1'b0;
	assign    s13[4] = 1'b0;
	assign s11[4] = 1'b0;
	assign   s9[4] = 1'b0;


	assign    s12[5] = 1'b0;
	assign    s13[5] = 1'b0;
	assign s11[5] = 1'b0;
	assign   s9[5] = 1'b0;


	assign    s12[6] = 1'b0;
	assign    s13[6] = 1'b0;
	assign s11[6] = 1'b0;
	assign   s9[6] = 1'b0;


	assign    s12[7] = 1'b0;
	assign    s13[7] = 1'b0;
	assign s11[7] = 1'b0;
	assign   s9[7] = 1'b0;


	assign    s12[8] = 1'b0;
	assign    s13[8] = 1'b0;
	assign s11[8] = 1'b0;
	assign   s9[8] = 1'b0;


	assign    s12[9] = 1'b0;
	assign    s13[9] = 1'b0;
	assign s11[9] = 1'b0;
	assign   s9[9] = 1'b0;


	assign    s12[10] = 1'b0;
	assign    s13[10] = 1'b0;
	assign s11[10] = 1'b0;
	assign   s9[10] = 1'b0;


	assign    s12[11] = 1'b0;
	assign    s13[11] = 1'b0;
	assign s11[11] = 1'b0;
	assign   s9[11] = 1'b0;


	assign    s12[12] = 1'b0;
	assign    s13[12] = 1'b0;
	assign s11[12] = 1'b0;
	assign   s9[12] = 1'b0;


	assign    s12[13] = 1'b0;
	assign    s13[13] = 1'b0;
	assign s11[13] = 1'b0;
	assign   s9[13] = 1'b0;


	assign    s12[14] = 1'b0;
	assign    s13[14] = 1'b0;
	assign s11[14] = 1'b0;
	assign   s9[14] = 1'b0;


	assign    s12[15] = 1'b0;
	assign    s13[15] = 1'b0;
	assign s11[15] = 1'b0;
	assign   s9[15] = 1'b0;


	assign    s12[16] = 1'b0;
	assign    s13[16] = 1'b0;
	assign s11[16] = 1'b0;
	assign   s9[16] = 1'b0;


	assign    s12[17] = 1'b0;
	assign    s13[17] = 1'b0;
	assign s11[17] = 1'b0;
	assign   s9[17] = 1'b0;


	assign    s12[18] = 1'b0;
	assign    s13[18] = 1'b0;
	assign s11[18] = 1'b0;
	assign   s9[18] = 1'b0;


	assign    s12[19] = 1'b0;
	assign    s13[19] = 1'b0;
	assign s11[19] = 1'b0;
	assign   s9[19] = 1'b0;


	assign    s12[20] = 1'b0;
	assign    s13[20] = 1'b0;
	assign s11[20] = 1'b0;
	assign   s9[20] = 1'b0;


	assign    s12[21] = 1'b0;
	assign    s13[21] = 1'b0;
	assign s11[21] = 1'b0;
	assign   s9[21] = 1'b0;


	assign    s12[22] = 1'b0;
	assign    s13[22] = 1'b0;
	assign s11[22] = 1'b0;
	assign   s9[22] = 1'b0;


	assign    s12[23] = 1'b0;
	assign    s13[23] = 1'b0;
	assign s11[23] = 1'b0;
	assign   s9[23] = 1'b0;


	assign    s12[24] = 1'b0;
	assign    s13[24] = 1'b0;
	assign s11[24] = 1'b0;
	assign   s9[24] = 1'b0;


	assign    s12[25] = 1'b0;
	assign    s13[25] = 1'b0;
	assign s11[25] = 1'b0;
	assign   s9[25] = 1'b0;


	assign    s12[26] = 1'b0;
	assign    s13[26] = 1'b0;
	assign s11[26] = 1'b0;
	assign   s9[26] = 1'b0;


	assign    s12[27] = 1'b0;
	assign    s13[27] = 1'b0;
	assign s11[27] = 1'b0;
	assign   s9[27] = 1'b0;


	assign    s12[28] = 1'b0;
	assign    s13[28] = 1'b0;
	assign s11[28] = 1'b0;
	assign   s9[28] = 1'b0;


	assign    s12[29] = 1'b0;
	assign    s13[29] = 1'b0;
	assign s11[29] = 1'b0;
	assign   s9[29] = 1'b0;


	assign    s12[30] = 1'b0;
	assign    s13[30] = 1'b0;
	assign s11[30] = 1'b0;
	assign   s9[30] = 1'b0;


	assign    s12[31] = 1'b0;
	assign    s13[31] = 1'b0;
	assign s11[31] = 1'b0;
	assign   s9[31] = 1'b0;

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

// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"

module atcbmc300_ds_wdata_bresp_ctrl (
	  self_id,
`ifdef ATCBMC300_MST0_SUPPORT
	  mst0_wvalid,
	  mst0_wlast,
	  mst0_wdata,
	  mst0_wstrb,
	  mst0_wsid,
	  mst0_bready,
	  mst0_bsid,
	  mst0_connect,
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	  mst1_wvalid,
	  mst1_wlast,
	  mst1_wdata,
	  mst1_wstrb,
	  mst1_wsid,
	  mst1_bready,
	  mst1_bsid,
	  mst1_connect,
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	  mst2_wvalid,
	  mst2_wlast,
	  mst2_wdata,
	  mst2_wstrb,
	  mst2_wsid,
	  mst2_bready,
	  mst2_bsid,
	  mst2_connect,
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	  mst3_wvalid,
	  mst3_wlast,
	  mst3_wdata,
	  mst3_wstrb,
	  mst3_wsid,
	  mst3_bready,
	  mst3_bsid,
	  mst3_connect,
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	  mst4_wvalid,
	  mst4_wlast,
	  mst4_wdata,
	  mst4_wstrb,
	  mst4_wsid,
	  mst4_bready,
	  mst4_bsid,
	  mst4_connect,
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	  mst5_wvalid,
	  mst5_wlast,
	  mst5_wdata,
	  mst5_wstrb,
	  mst5_wsid,
	  mst5_bready,
	  mst5_bsid,
	  mst5_connect,
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	  mst6_wvalid,
	  mst6_wlast,
	  mst6_wdata,
	  mst6_wstrb,
	  mst6_wsid,
	  mst6_bready,
	  mst6_bsid,
	  mst6_connect,
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	  mst7_wvalid,
	  mst7_wlast,
	  mst7_wdata,
	  mst7_wstrb,
	  mst7_wsid,
	  mst7_bready,
	  mst7_bsid,
	  mst7_connect,
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	  mst8_wvalid,
	  mst8_wlast,
	  mst8_wdata,
	  mst8_wstrb,
	  mst8_wsid,
	  mst8_bready,
	  mst8_bsid,
	  mst8_connect,
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	  mst9_wvalid,
	  mst9_wlast,
	  mst9_wdata,
	  mst9_wstrb,
	  mst9_wsid,
	  mst9_bready,
	  mst9_bsid,
	  mst9_connect,
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	  mst10_wvalid,
	  mst10_wlast,
	  mst10_wdata,
	  mst10_wstrb,
	  mst10_wsid,
	  mst10_bready,
	  mst10_bsid,
	  mst10_connect,
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	  mst11_wvalid,
	  mst11_wlast,
	  mst11_wdata,
	  mst11_wstrb,
	  mst11_wsid,
	  mst11_bready,
	  mst11_bsid,
	  mst11_connect,
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	  mst12_wvalid,
	  mst12_wlast,
	  mst12_wdata,
	  mst12_wstrb,
	  mst12_wsid,
	  mst12_bready,
	  mst12_bsid,
	  mst12_connect,
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	  mst13_wvalid,
	  mst13_wlast,
	  mst13_wdata,
	  mst13_wstrb,
	  mst13_wsid,
	  mst13_bready,
	  mst13_bsid,
	  mst13_connect,
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	  mst14_wvalid,
	  mst14_wlast,
	  mst14_wdata,
	  mst14_wstrb,
	  mst14_wsid,
	  mst14_bready,
	  mst14_bsid,
	  mst14_connect,
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	  mst15_wvalid,
	  mst15_wlast,
	  mst15_wdata,
	  mst15_wstrb,
	  mst15_wsid,
	  mst15_bready,
	  mst15_bsid,
	  mst15_connect,
`endif
	  ds_wdata,
	  ds_wlast,
	  ds_wstrb,
	  ds_wvalid,
	  ds_wready,
	  slv_wmid,
	  slv_wready,
	  outstanding_ready,
	  slv_aid,
	  addr_outstanding_en,
	  ds_bresp,
	  ds_bid,
	  ds_bvalid,
	  ds_bready,
	  slv_bvalid,
	  slv_bresp,
	  slv_bid,
	  aclk,
	  aresetn
);
parameter DATA_WIDTH = 64;
parameter ID_WIDTH   = 4;
parameter OUTSTANDING_DEPTH = 2;

localparam DATA_MSB = DATA_WIDTH - 1;
localparam ID_MSB   = ID_WIDTH - 1;
localparam OUTSTANDING_COUNT_WIDTH = $clog2(OUTSTANDING_DEPTH) + 1;

input [4:0] self_id;

`ifdef ATCBMC300_MST0_SUPPORT
input		        mst0_wvalid;
input 	                mst0_wlast;
input [DATA_MSB:0]         mst0_wdata;
input [(DATA_WIDTH/8)-1:0] mst0_wstrb;
input [4:0]                mst0_wsid;
input                      mst0_bready;
input [4:0]                mst0_bsid;
input			mst0_connect;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
input		        mst1_wvalid;
input 	                mst1_wlast;
input [DATA_MSB:0]         mst1_wdata;
input [(DATA_WIDTH/8)-1:0] mst1_wstrb;
input [4:0]                mst1_wsid;
input                      mst1_bready;
input [4:0]                mst1_bsid;
input			mst1_connect;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
input		        mst2_wvalid;
input 	                mst2_wlast;
input [DATA_MSB:0]         mst2_wdata;
input [(DATA_WIDTH/8)-1:0] mst2_wstrb;
input [4:0]                mst2_wsid;
input                      mst2_bready;
input [4:0]                mst2_bsid;
input			mst2_connect;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
input		        mst3_wvalid;
input 	                mst3_wlast;
input [DATA_MSB:0]         mst3_wdata;
input [(DATA_WIDTH/8)-1:0] mst3_wstrb;
input [4:0]                mst3_wsid;
input                      mst3_bready;
input [4:0]                mst3_bsid;
input			mst3_connect;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
input		        mst4_wvalid;
input 	                mst4_wlast;
input [DATA_MSB:0]         mst4_wdata;
input [(DATA_WIDTH/8)-1:0] mst4_wstrb;
input [4:0]                mst4_wsid;
input                      mst4_bready;
input [4:0]                mst4_bsid;
input			mst4_connect;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
input		        mst5_wvalid;
input 	                mst5_wlast;
input [DATA_MSB:0]         mst5_wdata;
input [(DATA_WIDTH/8)-1:0] mst5_wstrb;
input [4:0]                mst5_wsid;
input                      mst5_bready;
input [4:0]                mst5_bsid;
input			mst5_connect;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
input		        mst6_wvalid;
input 	                mst6_wlast;
input [DATA_MSB:0]         mst6_wdata;
input [(DATA_WIDTH/8)-1:0] mst6_wstrb;
input [4:0]                mst6_wsid;
input                      mst6_bready;
input [4:0]                mst6_bsid;
input			mst6_connect;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
input		        mst7_wvalid;
input 	                mst7_wlast;
input [DATA_MSB:0]         mst7_wdata;
input [(DATA_WIDTH/8)-1:0] mst7_wstrb;
input [4:0]                mst7_wsid;
input                      mst7_bready;
input [4:0]                mst7_bsid;
input			mst7_connect;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
input		        mst8_wvalid;
input 	                mst8_wlast;
input [DATA_MSB:0]         mst8_wdata;
input [(DATA_WIDTH/8)-1:0] mst8_wstrb;
input [4:0]                mst8_wsid;
input                      mst8_bready;
input [4:0]                mst8_bsid;
input			mst8_connect;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
input		        mst9_wvalid;
input 	                mst9_wlast;
input [DATA_MSB:0]         mst9_wdata;
input [(DATA_WIDTH/8)-1:0] mst9_wstrb;
input [4:0]                mst9_wsid;
input                      mst9_bready;
input [4:0]                mst9_bsid;
input			mst9_connect;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
input		        mst10_wvalid;
input 	                mst10_wlast;
input [DATA_MSB:0]         mst10_wdata;
input [(DATA_WIDTH/8)-1:0] mst10_wstrb;
input [4:0]                mst10_wsid;
input                      mst10_bready;
input [4:0]                mst10_bsid;
input			mst10_connect;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
input		        mst11_wvalid;
input 	                mst11_wlast;
input [DATA_MSB:0]         mst11_wdata;
input [(DATA_WIDTH/8)-1:0] mst11_wstrb;
input [4:0]                mst11_wsid;
input                      mst11_bready;
input [4:0]                mst11_bsid;
input			mst11_connect;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
input		        mst12_wvalid;
input 	                mst12_wlast;
input [DATA_MSB:0]         mst12_wdata;
input [(DATA_WIDTH/8)-1:0] mst12_wstrb;
input [4:0]                mst12_wsid;
input                      mst12_bready;
input [4:0]                mst12_bsid;
input			mst12_connect;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
input		        mst13_wvalid;
input 	                mst13_wlast;
input [DATA_MSB:0]         mst13_wdata;
input [(DATA_WIDTH/8)-1:0] mst13_wstrb;
input [4:0]                mst13_wsid;
input                      mst13_bready;
input [4:0]                mst13_bsid;
input			mst13_connect;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
input		        mst14_wvalid;
input 	                mst14_wlast;
input [DATA_MSB:0]         mst14_wdata;
input [(DATA_WIDTH/8)-1:0] mst14_wstrb;
input [4:0]                mst14_wsid;
input                      mst14_bready;
input [4:0]                mst14_bsid;
input			mst14_connect;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
input		        mst15_wvalid;
input 	                mst15_wlast;
input [DATA_MSB:0]         mst15_wdata;
input [(DATA_WIDTH/8)-1:0] mst15_wstrb;
input [4:0]                mst15_wsid;
input                      mst15_bready;
input [4:0]                mst15_bsid;
input			mst15_connect;
`endif
output [DATA_MSB:0] 		ds_wdata;
output 	           		ds_wlast;
output [(DATA_WIDTH/8)-1:0] 	ds_wstrb;
output              		ds_wvalid;
input               		ds_wready;

output [3:0]	    	slv_wmid;
output              	slv_wready;
output              	outstanding_ready;

input [3:0]         	slv_aid;
input               	addr_outstanding_en;

input [1:0]		ds_bresp;
input [ID_MSB+4:0]  	ds_bid;
input 			ds_bvalid;
output			ds_bready;

output			slv_bvalid;
output [1:0]		slv_bresp;
output [ID_MSB+4:0]  	slv_bid;

input aclk;
input aresetn;

reg [DATA_MSB:0] 	 ds_wdata;
reg 	                 ds_wlast;
reg [(DATA_WIDTH/8)-1:0] ds_wstrb;
reg             	 ds_wvalid;
reg [DATA_MSB:0] 	 mst_wdata [15:0];
reg [(DATA_WIDTH/8)-1:0] mst_wstrb [15:0];
reg [15:0]            	 mst_wlast;
reg [15:0]            	 mst_wvalid;
wire wmid_fifo_wr          ;
wire [3:0] wmid_fifo_wdata ;
wire last_wr		   ;
wire [3:0] wmid_fifo_rdata ;
wire wmid_fifo_empty       ;
wire bresp_cnt_empty;
wire wlast_pre;
wire wvalid_pre;
wire bresp_cnt_full;
wire slave_bready;

reg [15:0]		mst_bready;
reg			pending_bvalid;
reg [1:0]		pending_bresp;
reg [ID_MSB+4:0]  	pending_bid;


assign ds_bready = ~pending_bvalid;
assign slv_bvalid = (pending_bvalid | ds_bvalid) & ~bresp_cnt_empty;
assign slv_bid    = pending_bvalid ? pending_bid : ds_bid;
assign slv_bresp  = pending_bvalid ? pending_bresp : ds_bresp;
assign slave_bready = mst_bready[slv_bid[3:0]] & ~bresp_cnt_empty;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		pending_bvalid <= 1'b0;
	else
		pending_bvalid <= (pending_bvalid | ds_bvalid) & ~slave_bready;
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		pending_bid    <= {(ID_WIDTH+4){1'b0}};
		pending_bresp  <= 2'b0;
	end else if (ds_bvalid & ~slave_bready & ~pending_bvalid) begin
		pending_bid    <= ds_bid;
		pending_bresp  <= ds_bresp;
	end
end



always @* begin
`ifdef ATCBMC300_MST0_SUPPORT
	mst_wdata [0] = mst0_wdata  & {DATA_WIDTH{mst0_connect}};
	mst_wstrb [0] = mst0_wstrb  & {(DATA_WIDTH/8){mst0_connect}};
	mst_wlast [0] = mst0_wlast  & mst0_connect;
	mst_wvalid[0] = mst0_wvalid & mst0_connect & (mst0_wsid==self_id);
	mst_bready[0] = mst0_bready & mst0_connect & (mst0_bsid==self_id);
`else
	mst_wdata [0] = {DATA_WIDTH{1'b0}};
	mst_wstrb [0] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [0] = 1'b0;
	mst_wvalid[0] = 1'b0;
	mst_bready[0] = 1'b0;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	mst_wdata [1] = mst1_wdata  & {DATA_WIDTH{mst1_connect}};
	mst_wstrb [1] = mst1_wstrb  & {(DATA_WIDTH/8){mst1_connect}};
	mst_wlast [1] = mst1_wlast  & mst1_connect;
	mst_wvalid[1] = mst1_wvalid & mst1_connect & (mst1_wsid==self_id);
	mst_bready[1] = mst1_bready & mst1_connect & (mst1_bsid==self_id);
`else
	mst_wdata [1] = {DATA_WIDTH{1'b0}};
	mst_wstrb [1] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [1] = 1'b0;
	mst_wvalid[1] = 1'b0;
	mst_bready[1] = 1'b0;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	mst_wdata [2] = mst2_wdata  & {DATA_WIDTH{mst2_connect}};
	mst_wstrb [2] = mst2_wstrb  & {(DATA_WIDTH/8){mst2_connect}};
	mst_wlast [2] = mst2_wlast  & mst2_connect;
	mst_wvalid[2] = mst2_wvalid & mst2_connect & (mst2_wsid==self_id);
	mst_bready[2] = mst2_bready & mst2_connect & (mst2_bsid==self_id);
`else
	mst_wdata [2] = {DATA_WIDTH{1'b0}};
	mst_wstrb [2] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [2] = 1'b0;
	mst_wvalid[2] = 1'b0;
	mst_bready[2] = 1'b0;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	mst_wdata [3] = mst3_wdata  & {DATA_WIDTH{mst3_connect}};
	mst_wstrb [3] = mst3_wstrb  & {(DATA_WIDTH/8){mst3_connect}};
	mst_wlast [3] = mst3_wlast  & mst3_connect;
	mst_wvalid[3] = mst3_wvalid & mst3_connect & (mst3_wsid==self_id);
	mst_bready[3] = mst3_bready & mst3_connect & (mst3_bsid==self_id);
`else
	mst_wdata [3] = {DATA_WIDTH{1'b0}};
	mst_wstrb [3] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [3] = 1'b0;
	mst_wvalid[3] = 1'b0;
	mst_bready[3] = 1'b0;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	mst_wdata [4] = mst4_wdata  & {DATA_WIDTH{mst4_connect}};
	mst_wstrb [4] = mst4_wstrb  & {(DATA_WIDTH/8){mst4_connect}};
	mst_wlast [4] = mst4_wlast  & mst4_connect;
	mst_wvalid[4] = mst4_wvalid & mst4_connect & (mst4_wsid==self_id);
	mst_bready[4] = mst4_bready & mst4_connect & (mst4_bsid==self_id);
`else
	mst_wdata [4] = {DATA_WIDTH{1'b0}};
	mst_wstrb [4] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [4] = 1'b0;
	mst_wvalid[4] = 1'b0;
	mst_bready[4] = 1'b0;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	mst_wdata [5] = mst5_wdata  & {DATA_WIDTH{mst5_connect}};
	mst_wstrb [5] = mst5_wstrb  & {(DATA_WIDTH/8){mst5_connect}};
	mst_wlast [5] = mst5_wlast  & mst5_connect;
	mst_wvalid[5] = mst5_wvalid & mst5_connect & (mst5_wsid==self_id);
	mst_bready[5] = mst5_bready & mst5_connect & (mst5_bsid==self_id);
`else
	mst_wdata [5] = {DATA_WIDTH{1'b0}};
	mst_wstrb [5] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [5] = 1'b0;
	mst_wvalid[5] = 1'b0;
	mst_bready[5] = 1'b0;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	mst_wdata [6] = mst6_wdata  & {DATA_WIDTH{mst6_connect}};
	mst_wstrb [6] = mst6_wstrb  & {(DATA_WIDTH/8){mst6_connect}};
	mst_wlast [6] = mst6_wlast  & mst6_connect;
	mst_wvalid[6] = mst6_wvalid & mst6_connect & (mst6_wsid==self_id);
	mst_bready[6] = mst6_bready & mst6_connect & (mst6_bsid==self_id);
`else
	mst_wdata [6] = {DATA_WIDTH{1'b0}};
	mst_wstrb [6] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [6] = 1'b0;
	mst_wvalid[6] = 1'b0;
	mst_bready[6] = 1'b0;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	mst_wdata [7] = mst7_wdata  & {DATA_WIDTH{mst7_connect}};
	mst_wstrb [7] = mst7_wstrb  & {(DATA_WIDTH/8){mst7_connect}};
	mst_wlast [7] = mst7_wlast  & mst7_connect;
	mst_wvalid[7] = mst7_wvalid & mst7_connect & (mst7_wsid==self_id);
	mst_bready[7] = mst7_bready & mst7_connect & (mst7_bsid==self_id);
`else
	mst_wdata [7] = {DATA_WIDTH{1'b0}};
	mst_wstrb [7] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [7] = 1'b0;
	mst_wvalid[7] = 1'b0;
	mst_bready[7] = 1'b0;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	mst_wdata [8] = mst8_wdata  & {DATA_WIDTH{mst8_connect}};
	mst_wstrb [8] = mst8_wstrb  & {(DATA_WIDTH/8){mst8_connect}};
	mst_wlast [8] = mst8_wlast  & mst8_connect;
	mst_wvalid[8] = mst8_wvalid & mst8_connect & (mst8_wsid==self_id);
	mst_bready[8] = mst8_bready & mst8_connect & (mst8_bsid==self_id);
`else
	mst_wdata [8] = {DATA_WIDTH{1'b0}};
	mst_wstrb [8] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [8] = 1'b0;
	mst_wvalid[8] = 1'b0;
	mst_bready[8] = 1'b0;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	mst_wdata [9] = mst9_wdata  & {DATA_WIDTH{mst9_connect}};
	mst_wstrb [9] = mst9_wstrb  & {(DATA_WIDTH/8){mst9_connect}};
	mst_wlast [9] = mst9_wlast  & mst9_connect;
	mst_wvalid[9] = mst9_wvalid & mst9_connect & (mst9_wsid==self_id);
	mst_bready[9] = mst9_bready & mst9_connect & (mst9_bsid==self_id);
`else
	mst_wdata [9] = {DATA_WIDTH{1'b0}};
	mst_wstrb [9] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [9] = 1'b0;
	mst_wvalid[9] = 1'b0;
	mst_bready[9] = 1'b0;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	mst_wdata [10] = mst10_wdata  & {DATA_WIDTH{mst10_connect}};
	mst_wstrb [10] = mst10_wstrb  & {(DATA_WIDTH/8){mst10_connect}};
	mst_wlast [10] = mst10_wlast  & mst10_connect;
	mst_wvalid[10] = mst10_wvalid & mst10_connect & (mst10_wsid==self_id);
	mst_bready[10] = mst10_bready & mst10_connect & (mst10_bsid==self_id);
`else
	mst_wdata [10] = {DATA_WIDTH{1'b0}};
	mst_wstrb [10] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [10] = 1'b0;
	mst_wvalid[10] = 1'b0;
	mst_bready[10] = 1'b0;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	mst_wdata [11] = mst11_wdata  & {DATA_WIDTH{mst11_connect}};
	mst_wstrb [11] = mst11_wstrb  & {(DATA_WIDTH/8){mst11_connect}};
	mst_wlast [11] = mst11_wlast  & mst11_connect;
	mst_wvalid[11] = mst11_wvalid & mst11_connect & (mst11_wsid==self_id);
	mst_bready[11] = mst11_bready & mst11_connect & (mst11_bsid==self_id);
`else
	mst_wdata [11] = {DATA_WIDTH{1'b0}};
	mst_wstrb [11] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [11] = 1'b0;
	mst_wvalid[11] = 1'b0;
	mst_bready[11] = 1'b0;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	mst_wdata [12] = mst12_wdata  & {DATA_WIDTH{mst12_connect}};
	mst_wstrb [12] = mst12_wstrb  & {(DATA_WIDTH/8){mst12_connect}};
	mst_wlast [12] = mst12_wlast  & mst12_connect;
	mst_wvalid[12] = mst12_wvalid & mst12_connect & (mst12_wsid==self_id);
	mst_bready[12] = mst12_bready & mst12_connect & (mst12_bsid==self_id);
`else
	mst_wdata [12] = {DATA_WIDTH{1'b0}};
	mst_wstrb [12] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [12] = 1'b0;
	mst_wvalid[12] = 1'b0;
	mst_bready[12] = 1'b0;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	mst_wdata [13] = mst13_wdata  & {DATA_WIDTH{mst13_connect}};
	mst_wstrb [13] = mst13_wstrb  & {(DATA_WIDTH/8){mst13_connect}};
	mst_wlast [13] = mst13_wlast  & mst13_connect;
	mst_wvalid[13] = mst13_wvalid & mst13_connect & (mst13_wsid==self_id);
	mst_bready[13] = mst13_bready & mst13_connect & (mst13_bsid==self_id);
`else
	mst_wdata [13] = {DATA_WIDTH{1'b0}};
	mst_wstrb [13] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [13] = 1'b0;
	mst_wvalid[13] = 1'b0;
	mst_bready[13] = 1'b0;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	mst_wdata [14] = mst14_wdata  & {DATA_WIDTH{mst14_connect}};
	mst_wstrb [14] = mst14_wstrb  & {(DATA_WIDTH/8){mst14_connect}};
	mst_wlast [14] = mst14_wlast  & mst14_connect;
	mst_wvalid[14] = mst14_wvalid & mst14_connect & (mst14_wsid==self_id);
	mst_bready[14] = mst14_bready & mst14_connect & (mst14_bsid==self_id);
`else
	mst_wdata [14] = {DATA_WIDTH{1'b0}};
	mst_wstrb [14] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [14] = 1'b0;
	mst_wvalid[14] = 1'b0;
	mst_bready[14] = 1'b0;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	mst_wdata [15] = mst15_wdata  & {DATA_WIDTH{mst15_connect}};
	mst_wstrb [15] = mst15_wstrb  & {(DATA_WIDTH/8){mst15_connect}};
	mst_wlast [15] = mst15_wlast  & mst15_connect;
	mst_wvalid[15] = mst15_wvalid & mst15_connect & (mst15_wsid==self_id);
	mst_bready[15] = mst15_bready & mst15_connect & (mst15_bsid==self_id);
`else
	mst_wdata [15] = {DATA_WIDTH{1'b0}};
	mst_wstrb [15] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [15] = 1'b0;
	mst_wvalid[15] = 1'b0;
	mst_bready[15] = 1'b0;
`endif
end
assign slv_wmid = wmid_fifo_rdata;
assign wmid_fifo_wr = addr_outstanding_en;
assign wlast_pre = mst_wlast[slv_wmid[3:0]];
assign wvalid_pre = mst_wvalid[slv_wmid[3:0]];
assign last_wr = slv_wready & wvalid_pre & wlast_pre;
assign wmid_fifo_wdata = slv_aid;
assign slv_wready = ~(ds_wvalid & ~ds_wready) & ~wmid_fifo_empty & ~(wlast_pre & bresp_cnt_full);

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		ds_wvalid <= 1'b0;
	else
		ds_wvalid <= (slv_wready & wvalid_pre) | (ds_wvalid & ~ds_wready);
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds_wdata  <= {DATA_WIDTH{1'b0}};
		ds_wstrb  <= {(DATA_WIDTH/8){1'b0}};
		ds_wlast  <= 1'h0;
	end else if (slv_wready & wvalid_pre) begin
		ds_wdata  <= mst_wdata[slv_wmid[3:0]];
		ds_wstrb  <= mst_wstrb[slv_wmid[3:0]];
		ds_wlast  <= wlast_pre;
	end
end

generate
	if (OUTSTANDING_DEPTH > 1) begin : outstanding_fifo
		wire wmid_fifo_full        ;
		assign outstanding_ready = ~wmid_fifo_full;
		wire wmid_fifo_rd = last_wr;
		nds_sync_fifo_afe #(.DATA_WIDTH(4), .FIFO_DEPTH(OUTSTANDING_DEPTH)) wmid_fifo (
			.reset_n     (aresetn               ),
			.clk         (aclk                  ),
			.wr          (wmid_fifo_wr          ),
			.wr_data     (wmid_fifo_wdata       ),
			.rd          (wmid_fifo_rd          ),
			.rd_data     (wmid_fifo_rdata       ),
			.almost_empty(			    ),
			.almost_full (			    ),
			.empty       (wmid_fifo_empty       ),
			.full        (wmid_fifo_full        )
		);
		reg [OUTSTANDING_COUNT_WIDTH-1:0] bresp_cnt;
		always @(posedge aclk or negedge aresetn) begin
			if (!aresetn)
				bresp_cnt <= {OUTSTANDING_COUNT_WIDTH{1'b0}};
			else
				bresp_cnt <= bresp_cnt + ({OUTSTANDING_COUNT_WIDTH{slv_bvalid & slave_bready & ~last_wr}} |
                                                          {{OUTSTANDING_COUNT_WIDTH-1{1'b0}},last_wr & ~(slv_bvalid & slave_bready)});
		end
		assign bresp_cnt_full = bresp_cnt[OUTSTANDING_COUNT_WIDTH-1];
		assign bresp_cnt_empty = ~|bresp_cnt;
	end
	else begin: one_entry_outstanding_buffer
		reg [3:0] outstanding_wmid;
		reg [1:0] outstanding_state;
		assign bresp_cnt_full = 1'b0;
		assign outstanding_ready = (outstanding_state==2'b00) | (slv_bvalid & slave_bready);
		assign wmid_fifo_empty = outstanding_state!=2'b01;
		assign wmid_fifo_rdata = outstanding_wmid;
		assign bresp_cnt_empty = outstanding_state!=2'b10;
		always @(posedge aclk or negedge aresetn) begin
			if (!aresetn)
				outstanding_wmid <= 4'h0;
			else if (wmid_fifo_wr)
				outstanding_wmid <= wmid_fifo_wdata;
		end
		always @(posedge aclk or negedge aresetn) begin
			if (!aresetn)
				outstanding_state <= 2'b0;
			else
				outstanding_state <= wmid_fifo_wr ? 2'b01 :
						     last_wr ? 2'b10 :
             					     (slv_bvalid & slave_bready) ? 2'b0 :
 						     outstanding_state;
		end
	end
endgenerate
endmodule

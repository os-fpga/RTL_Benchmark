// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc301_config.vh"
`include "atcbmc301_const.vh"

module atcbmc301_ds_wdata_bresp_ctrl (
	  self_id,
`ifdef ATCBMC301_MST0_SUPPORT
	  mst0_wvalid,
	  mst0_wlast,
	  mst0_wdata,
	  mst0_wstrb,
	  mst0_wsid,
	  mst0_bready,
	  mst0_bsid,
	  mst0_connect,
`endif
`ifdef ATCBMC301_MST1_SUPPORT
	  mst1_wvalid,
	  mst1_wlast,
	  mst1_wdata,
	  mst1_wstrb,
	  mst1_wsid,
	  mst1_bready,
	  mst1_bsid,
	  mst1_connect,
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

`ifdef ATCBMC301_MST0_SUPPORT
input		        mst0_wvalid;
input 	                mst0_wlast;
input [DATA_MSB:0]         mst0_wdata;
input [(DATA_WIDTH/8)-1:0] mst0_wstrb;
input [4:0]                mst0_wsid;
input                      mst0_bready;
input [4:0]                mst0_bsid;
input			mst0_connect;
`endif
`ifdef ATCBMC301_MST1_SUPPORT
input		        mst1_wvalid;
input 	                mst1_wlast;
input [DATA_MSB:0]         mst1_wdata;
input [(DATA_WIDTH/8)-1:0] mst1_wstrb;
input [4:0]                mst1_wsid;
input                      mst1_bready;
input [4:0]                mst1_bsid;
input			mst1_connect;
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
`ifdef ATCBMC301_MST0_SUPPORT
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
`ifdef ATCBMC301_MST1_SUPPORT
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
	mst_wdata [2] = {DATA_WIDTH{1'b0}};
	mst_wstrb [2] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [2] = 1'b0;
	mst_wvalid[2] = 1'b0;
	mst_bready[2] = 1'b0;

	mst_wdata [3] = {DATA_WIDTH{1'b0}};
	mst_wstrb [3] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [3] = 1'b0;
	mst_wvalid[3] = 1'b0;
	mst_bready[3] = 1'b0;

	mst_wdata [4] = {DATA_WIDTH{1'b0}};
	mst_wstrb [4] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [4] = 1'b0;
	mst_wvalid[4] = 1'b0;
	mst_bready[4] = 1'b0;

	mst_wdata [5] = {DATA_WIDTH{1'b0}};
	mst_wstrb [5] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [5] = 1'b0;
	mst_wvalid[5] = 1'b0;
	mst_bready[5] = 1'b0;

	mst_wdata [6] = {DATA_WIDTH{1'b0}};
	mst_wstrb [6] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [6] = 1'b0;
	mst_wvalid[6] = 1'b0;
	mst_bready[6] = 1'b0;

	mst_wdata [7] = {DATA_WIDTH{1'b0}};
	mst_wstrb [7] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [7] = 1'b0;
	mst_wvalid[7] = 1'b0;
	mst_bready[7] = 1'b0;

	mst_wdata [8] = {DATA_WIDTH{1'b0}};
	mst_wstrb [8] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [8] = 1'b0;
	mst_wvalid[8] = 1'b0;
	mst_bready[8] = 1'b0;

	mst_wdata [9] = {DATA_WIDTH{1'b0}};
	mst_wstrb [9] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [9] = 1'b0;
	mst_wvalid[9] = 1'b0;
	mst_bready[9] = 1'b0;

	mst_wdata [10] = {DATA_WIDTH{1'b0}};
	mst_wstrb [10] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [10] = 1'b0;
	mst_wvalid[10] = 1'b0;
	mst_bready[10] = 1'b0;

	mst_wdata [11] = {DATA_WIDTH{1'b0}};
	mst_wstrb [11] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [11] = 1'b0;
	mst_wvalid[11] = 1'b0;
	mst_bready[11] = 1'b0;

	mst_wdata [12] = {DATA_WIDTH{1'b0}};
	mst_wstrb [12] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [12] = 1'b0;
	mst_wvalid[12] = 1'b0;
	mst_bready[12] = 1'b0;

	mst_wdata [13] = {DATA_WIDTH{1'b0}};
	mst_wstrb [13] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [13] = 1'b0;
	mst_wvalid[13] = 1'b0;
	mst_bready[13] = 1'b0;

	mst_wdata [14] = {DATA_WIDTH{1'b0}};
	mst_wstrb [14] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [14] = 1'b0;
	mst_wvalid[14] = 1'b0;
	mst_bready[14] = 1'b0;

	mst_wdata [15] = {DATA_WIDTH{1'b0}};
	mst_wstrb [15] = {(DATA_WIDTH/8){1'b0}};
	mst_wlast [15] = 1'b0;
	mst_wvalid[15] = 1'b0;
	mst_bready[15] = 1'b0;

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

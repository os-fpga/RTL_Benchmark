// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc301_config.vh"
`include "atcbmc301_const.vh"

module atcbmc301_ds_rdata_ctrl (
	  self_id,
`ifdef ATCBMC301_MST0_SUPPORT
	  mst0_rready,
	  mst0_rsid,
	  mst0_connect,
`endif
`ifdef ATCBMC301_MST1_SUPPORT
	  mst1_rready,
	  mst1_rsid,
	  mst1_connect,
`endif
	  ds_rdata,
	  ds_rresp,
	  ds_rid,
	  ds_rlast,
	  ds_rvalid,
	  ds_rready,
	  slv_rvalid,
	  slv_read_data,
	  slv_rid,
	  outstanding_ready,
	  addr_outstanding_en,
	  aclk,
	  aresetn
);
parameter DATA_WIDTH = 64;
parameter ID_WIDTH   = 4;
parameter OUTSTANDING_DEPTH = 2;

localparam DATA_MSB = DATA_WIDTH - 1;
localparam ID_MSB   = ID_WIDTH - 1;

input [4:0] self_id;

`ifdef ATCBMC301_MST0_SUPPORT
input                      mst0_rready;
input [4:0]                mst0_rsid;
input			mst0_connect;
`endif
`ifdef ATCBMC301_MST1_SUPPORT
input                      mst1_rready;
input [4:0]                mst1_rsid;
input			mst1_connect;
`endif
input [DATA_MSB:0]	ds_rdata;
input [1:0]		ds_rresp;
input [ID_MSB+4:0]  	ds_rid;
input 			ds_rlast;
input 			ds_rvalid;
output			ds_rready;

output			slv_rvalid;
output [DATA_MSB+3:0]	slv_read_data;
output [ID_MSB+4:0]  	slv_rid;

output              	outstanding_ready;
input               	addr_outstanding_en;

input aclk;
input aresetn;

reg [15:0]		mst_rready;
reg			pending_rvalid;
reg			pending_rlast;
reg [1:0]		pending_rresp;
reg [ID_MSB+4:0]  	pending_rid;
reg [DATA_MSB:0]  	pending_rdata;
wire rresp_cnt_empty;
wire [1:0] slv_rresp;
wire slv_rlast;
wire [DATA_MSB:0] slv_rdata;
wire slave_rready;

always @* begin
`ifdef ATCBMC301_MST0_SUPPORT
	mst_rready[0] = mst0_rready & mst0_connect & (mst0_rsid==self_id);
`else
	mst_rready[0] = 1'b0;
`endif
`ifdef ATCBMC301_MST1_SUPPORT
	mst_rready[1] = mst1_rready & mst1_connect & (mst1_rsid==self_id);
`else
	mst_rready[1] = 1'b0;
`endif
	mst_rready[2] = 1'b0;

	mst_rready[3] = 1'b0;

	mst_rready[4] = 1'b0;

	mst_rready[5] = 1'b0;

	mst_rready[6] = 1'b0;

	mst_rready[7] = 1'b0;

	mst_rready[8] = 1'b0;

	mst_rready[9] = 1'b0;

	mst_rready[10] = 1'b0;

	mst_rready[11] = 1'b0;

	mst_rready[12] = 1'b0;

	mst_rready[13] = 1'b0;

	mst_rready[14] = 1'b0;

	mst_rready[15] = 1'b0;

end
assign ds_rready = ~pending_rvalid;
assign slv_rvalid = (pending_rvalid | ds_rvalid) & ~rresp_cnt_empty;
assign slv_rid    = pending_rvalid ? pending_rid   : ds_rid;
assign slv_rresp  = pending_rvalid ? pending_rresp : ds_rresp;
assign slv_rlast  = pending_rvalid ? pending_rlast : ds_rlast;
assign slv_rdata  = pending_rvalid ? pending_rdata : ds_rdata;
assign slv_read_data = {slv_rresp, slv_rlast, slv_rdata};
assign slave_rready = mst_rready[slv_rid[3:0]] & ~rresp_cnt_empty;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		pending_rvalid <= 1'b0;
	else
		pending_rvalid <= (pending_rvalid | ds_rvalid) & ~slave_rready;
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		pending_rid    <= {(ID_WIDTH+4){1'b0}};
		pending_rresp  <= 2'b0;
		pending_rlast  <= 1'b0;
		pending_rdata  <= {DATA_WIDTH{1'b0}};
	end else if (ds_rvalid & ~slave_rready & ~pending_rvalid) begin
		pending_rid    <= ds_rid  ;
		pending_rresp  <= ds_rresp;
		pending_rlast  <= ds_rlast;
		pending_rdata  <= ds_rdata;
	end
end

localparam OUTSTANDING_COUNT_WIDTH = (OUTSTANDING_DEPTH > 1) ? ($clog2(OUTSTANDING_DEPTH) + 1) : 0;
generate
	if (OUTSTANDING_DEPTH > 1) begin : outstanding_fifo
		reg [OUTSTANDING_COUNT_WIDTH-1:0] rresp_cnt;
		assign outstanding_ready = ~rresp_cnt[OUTSTANDING_COUNT_WIDTH-1];
		assign rresp_cnt_empty = ~|rresp_cnt;
		always @(posedge aclk or negedge aresetn) begin
			if (!aresetn)
				rresp_cnt <= {OUTSTANDING_COUNT_WIDTH{1'b0}};
			else
				rresp_cnt <= rresp_cnt + ({OUTSTANDING_COUNT_WIDTH{slv_rvalid & slave_rready & slv_rlast & ~addr_outstanding_en}} |
                                                          {{OUTSTANDING_COUNT_WIDTH-1{1'b0}},addr_outstanding_en & ~(slv_rvalid & slave_rready & slv_rlast)});
		end
	end
	else begin: one_entry_outstanding_buffer
		reg rresp_cnt;
		assign outstanding_ready = ~rresp_cnt | (slv_rvalid & slave_rready & slv_rlast);
		assign rresp_cnt_empty = ~rresp_cnt;
		always @(posedge aclk or negedge aresetn) begin
			if (!aresetn)
				rresp_cnt <= 1'b0;
			else if (addr_outstanding_en)
				rresp_cnt <= 1'b1;
			else if (slv_rvalid & slave_rready & slv_rlast)
				rresp_cnt <= 1'b0;
		end
	end
endgenerate
endmodule

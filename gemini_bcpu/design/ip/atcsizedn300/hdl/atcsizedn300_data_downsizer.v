// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atcsizedn300_data_downsizer (
	aclk,
	aresetn,

	us_rid,
	us_rresp,
	us_rlast,
	us_rvalid,
	us_rdata,
	us_rready,

	ds_rresp,
	ds_rlast,
	ds_rvalid,
	ds_rdata,

	ds_rready,
	ds_arvalid,
	ds_arready,
	ds_arburst,
	ds_arlen,
	ds_araddr,

	us_rdata_size,
	us_rdata_id,
	us_rlast_burst,
	rcmd_fifo_full,

	us_wstrb,
	us_wlast,
	us_wvalid,
	us_wdata,
	us_wready,

	ds_wstrb,
	ds_wlast,
	ds_wvalid,
	ds_wdata,
	ds_wready,

	us_bid,
	us_bresp,
	us_bvalid,
	us_bready,

	ds_bresp,
	ds_bvalid,
	ds_bready,

	ds_awaddr,
	ds_awlen,
	ds_awvalid,
	ds_awburst,
	ds_awready,

	us_wdata_size,
	us_wdata_id,
	us_wlast_burst,
	wcmd_fifo_full
);

parameter  ID_WIDTH      = 4;
parameter  US_DATA_WIDTH = 128;
parameter  DS_DATA_WIDTH = 32;
localparam DS_DATA_SIZE = $clog2(DS_DATA_WIDTH) - 3;

localparam WCMD_WIDTH 	= 2 + 5 + 3 + 8;
localparam WID_WIDTH 	= ID_WIDTH + 1;
localparam RCMD_WIDTH  	= 4 + 5 + 3 + 2 + 1 + ID_WIDTH;
localparam WDATA_BUFFER_WIDTH = US_DATA_WIDTH + (US_DATA_WIDTH/8) + 1;
localparam RDATA_BUFFER_WIDTH = DS_DATA_WIDTH + 2 + 1;

localparam FIXED = 2'b00;
localparam INCR  = 2'b01;
localparam WRAP  = 2'b10;

input                            aclk;
input                            aresetn;

output	[ID_WIDTH-1:0] 		us_rid;
output  [1:0] 			us_rresp;
output                    	us_rlast;
output                    	us_rvalid;
output  [US_DATA_WIDTH-1:0] 	us_rdata;
input                     	us_rready;

input	[1:0] 			ds_rresp;
input                    	ds_rlast;
input                    	ds_rvalid;
input	[DS_DATA_WIDTH-1:0] 	ds_rdata;
output                     	ds_rready;

input				ds_arvalid;
input				ds_arready;
input   [1:0]			ds_arburst;
input	[3:0]			ds_arlen;
input	[4:0]			ds_araddr;
input	[2:0]			us_rdata_size;
input	[ID_WIDTH-1:0]		us_rdata_id;
input				us_rlast_burst;
output				rcmd_fifo_full;

input  	[(US_DATA_WIDTH/8)-1:0] us_wstrb;
input                   	us_wlast;
input                   	us_wvalid;
input  	[US_DATA_WIDTH-1:0] 	us_wdata;
output                    	us_wready;

output [(DS_DATA_WIDTH/8)-1:0] 	ds_wstrb;
output                   	ds_wlast;
output                   	ds_wvalid;
output  [DS_DATA_WIDTH-1:0] 	ds_wdata;
input                    	ds_wready;

input	[4:0]			ds_awaddr;
input	[7:0]			ds_awlen;
input				ds_awvalid;
input   [1:0]			ds_awburst;
input				ds_awready;
input	[2:0]			us_wdata_size;

output	[ID_WIDTH-1:0] 		us_bid;
output	[1:0] 			us_bresp;
output            		us_bvalid;
input        			us_bready;

input	[1:0] 			ds_bresp;
input                  		ds_bvalid;
output                  	ds_bready;

input	[ID_WIDTH-1:0]		us_wdata_id;
input				us_wlast_burst;
output				wcmd_fifo_full;

reg	[ID_WIDTH-1:0] 		us_rid;
reg	[1:0] 			us_rresp;
reg      	              	us_rlast;
reg      	              	us_rvalid;
reg	[US_DATA_WIDTH-1:0] 	us_rdata;

wire	[ID_WIDTH-1:0] 		us_rid_a1;
reg	[1:0] 			us_rresp_a1;
reg      	              	us_rlast_a1;
reg      	              	us_rvalid_a1;
reg	[US_DATA_WIDTH-1:0] 	us_rdata_a1;

wire 	[RCMD_WIDTH-1:0]	rcmd_fifo_rdata;
wire 	[RCMD_WIDTH-1:0]	rcmd_fifo_wdata;
wire				rcmd_fifo_rd;
wire				rcmd_fifo_wr;
wire				rcmd_fifo_empty;
wire				rcmd_fifo_full;
reg				rcmd_fifo_rd_d1;
reg				rcmd_fifo_empty_d1;


reg				rdata_addr_sel_a1;
reg				rdata_addr_sel;
wire	[4:0]			rdata_addr_mux;
reg	[4:0]			next_rdata_addr_a1;
reg	[4:0]			next_rdata_addr;
wire    [4:0] 			rdata_incr_addr;
reg	[4:0]			rdata_update_size_a1;
reg	[4:0]			rdata_update_size;
wire    [4:0] 			rdata_wrap_mask;

wire 	[ID_WIDTH-1:0]		rdata_bus_id;
wire 	[3:0]			rdata_len;
wire 	[1:0]			rdata_burst;
wire 	[2:0]			rdata_bus_size;
wire 	[4:0]			rdata_addr;
wire 				rdata_rlast;
wire 	[2:0]			rdata_ratio;

wire 	[2:0]			rdata_ds_size;
wire 				rdata_size_overflow;
reg                    		rdata_trans_complete;
reg                    		rdata_trans_complete_d1;

wire				update_rdata_addr;
wire				update_us_rdata;
reg				update_us_rdata_d1;

reg 	[RDATA_BUFFER_WIDTH-1:0]rdata_buffer;
reg 	[RDATA_BUFFER_WIDTH-1:0]rdata_buffer_a1;
reg				rdata_buffer_valid;
reg				rdata_buffer_valid_a1;

wire	[1:0] 			ds_mux_rresp;
wire	                    	ds_mux_rlast;
wire	[DS_DATA_WIDTH-1:0] 	ds_mux_rdata;
wire 				ds_rdata_valid;

reg	[(DS_DATA_WIDTH/8)-1:0] ds_wstrb;
reg                   		ds_wlast;
reg                   		ds_wvalid;
reg  	[DS_DATA_WIDTH-1:0] 	ds_wdata;

reg	[(DS_DATA_WIDTH/8)-1:0] ds_wstrb_a1;
reg                   		ds_wvalid_a1;
reg  	[DS_DATA_WIDTH-1:0] 	ds_wdata_a1;
reg				ds_wlast_a1;

wire 	[WCMD_WIDTH-1:0]	wcmd_fifo_rdata;
wire 	[WCMD_WIDTH-1:0]	wcmd_fifo_wdata;
wire				wcmd_fifo_rd;
wire				wcmd_fifo_wr;
wire				wcmd_fifo_empty;
reg				wcmd_fifo_rd_d1;
reg				wcmd_fifo_empty_d1;

wire	[7:0]			wdata_len;
wire 	[2:0]			wdata_bus_size;
wire 	[1:0]			wdata_burst;
wire	[4:0]			wdata_addr;
wire	[2:0]			wdata_ratio;
wire 	[2:0]			wdata_ds_size;
wire				wdata_size_overflow;

reg 	[WDATA_BUFFER_WIDTH-1:0]wdata_buffer;
reg 	[WDATA_BUFFER_WIDTH-1:0]wdata_buffer_a1;
reg				wdata_buffer_valid;
reg				wdata_buffer_valid_a1;

wire	[(US_DATA_WIDTH/8)-1:0]	us_mux_wstrb;
wire                  		us_mux_wlast;
wire  	[US_DATA_WIDTH-1:0] 	us_mux_wdata;

reg				wdata_addr_sel_a1;
reg				wdata_addr_sel;
wire	[4:0]			wdata_addr_mux;
reg	[4:0]			next_wdata_addr_a1;
reg	[4:0]			next_wdata_addr;
reg	[4:0]			wdata_update_size_a1;
reg	[4:0]			wdata_update_size;
wire    [4:0] 			wdata_wrap_mask;
wire    [4:0] 			wdata_incr_addr;
reg				wdata_trans_complete;

wire				us_wdata_valid;
wire				update_wdata_addr;
wire				update_ds_wdata;
reg				update_ds_wdata_d1;

reg	[7:0]			wdata_burst_count_a1;
reg	[7:0]			wdata_burst_count;
wire	[7:0]			wdata_burst_count_mux;
wire				ds_wdata_last;

reg	[1:0] 			us_bresp;
reg          	  		us_bvalid;
reg	[ID_WIDTH-1:0] 		us_bid_a1;
reg	[ID_WIDTH-1:0] 		us_bid;

reg	[1:0] 			us_bresp_a1;
reg          	  		us_bvalid_a1;

wire 	[WID_WIDTH-1:0]		wid_fifo_rdata;
wire 	[WID_WIDTH-1:0]		wid_fifo_wdata;
wire				wid_fifo_rd;
wire				wid_fifo_wr;
wire				wid_fifo_empty;

wire 	[ID_WIDTH-1:0]		wresp_id;
wire 				wresp_trans_complete;
reg 				wresp_trans_complete_d1;

reg	[1:0]			wresp_buffer;
reg	[1:0]			wresp_buffer_a1;
reg				wresp_buffer_valid;
reg				wresp_buffer_valid_a1;

wire	[1:0]			ds_mux_bresp;
wire				ds_mux_bvalid;
wire				update_us_wresp;

assign rcmd_fifo_wdata 	= {us_rdata_id, ds_arlen, ds_arburst , us_rdata_size, ds_araddr, us_rlast_burst};
assign rcmd_fifo_wr 	= ds_arvalid & ds_arready;
assign rcmd_fifo_rd	= update_us_rdata && (rdata_buffer_valid || ds_rvalid) && ds_mux_rlast;

assign ds_rdata_valid	= ds_rvalid && ds_rready;
assign update_us_rdata 	= ((!us_rvalid) || us_rready) && (!rcmd_fifo_empty);
assign update_rdata_addr	= update_us_rdata && (ds_rvalid || rdata_buffer_valid);

assign rdata_bus_id	= rcmd_fifo_rdata[RCMD_WIDTH-1:15];
assign rdata_len	= rcmd_fifo_rdata[14:11];
assign rdata_burst	= rcmd_fifo_rdata[10:9];
assign rdata_bus_size	= rcmd_fifo_rdata[8:6];
assign rdata_addr	= rcmd_fifo_rdata[5:1];
assign rdata_rlast	= rcmd_fifo_rdata[0];
assign rdata_ratio	= rdata_size_overflow ? (rdata_bus_size - DS_DATA_SIZE[2:0]) : 3'h0;
assign rdata_ds_size	= rdata_size_overflow ? DS_DATA_SIZE[2:0] : rdata_bus_size;
assign rdata_wrap_mask 	= (rdata_burst == WRAP) ? (~rdata_len[3:0]) << rdata_ds_size : 5'h0;
assign rdata_incr_addr	= rdata_addr_mux + rdata_update_size_a1;
assign rdata_size_overflow	= (rdata_bus_size > DS_DATA_SIZE[2:0]) ? 1'b1 : 1'b0;
assign rdata_addr_mux	= rdata_addr_sel_a1 ? rdata_addr : next_rdata_addr;

assign ds_mux_rdata	= rdata_buffer_valid ? rdata_buffer[RDATA_BUFFER_WIDTH-1:3] 	: ds_rdata;
assign ds_mux_rresp	= rdata_buffer_valid ? rdata_buffer[2:1] 			: ds_rresp;
assign ds_mux_rlast	= rdata_buffer_valid ? rdata_buffer[0] 				: ds_rlast;
assign ds_rready 	= (!rdata_buffer_valid);

assign wcmd_fifo_wdata 	= {ds_awlen, ds_awburst ,ds_awaddr, us_wdata_size};
assign wcmd_fifo_wr 	= ds_awvalid && ds_awready;
assign wcmd_fifo_rd	= (!wcmd_fifo_empty) && (wdata_buffer_valid || us_wvalid) && update_ds_wdata && ds_wdata_last;
assign us_wdata_valid	= us_wvalid && us_wready;
assign update_ds_wdata 	= ((!ds_wvalid) || ds_wready) && (!wcmd_fifo_empty);
assign update_wdata_addr= update_ds_wdata && (us_wvalid || wdata_buffer_valid);

assign wdata_len	= wcmd_fifo_rdata[WCMD_WIDTH-1:10];
assign wdata_burst	= wcmd_fifo_rdata[9:8];
assign wdata_addr	= wcmd_fifo_rdata[7:3];
assign wdata_bus_size	= wcmd_fifo_rdata[2:0];
assign wdata_ratio	= wdata_size_overflow ? (wdata_bus_size - DS_DATA_SIZE[2:0]) : 3'h0;
assign wdata_ds_size	= wdata_size_overflow ? DS_DATA_SIZE[2:0] : wdata_bus_size;
assign wdata_wrap_mask 	= (wdata_burst == WRAP) ? (~wdata_len[3:0]) << wdata_ds_size : 5'h0;
assign wdata_incr_addr	= wdata_addr_mux + wdata_update_size_a1;
assign wdata_size_overflow	= (wdata_bus_size > DS_DATA_SIZE[2:0]) ? 1'b1 : 1'b0;
assign wdata_addr_mux	= wdata_addr_sel_a1 ? wdata_addr : next_wdata_addr;
assign wdata_burst_count_mux 	= wdata_addr_sel_a1 ? wdata_len : wdata_burst_count;

assign us_mux_wdata	= wdata_buffer_valid ? wdata_buffer[WDATA_BUFFER_WIDTH-1:(US_DATA_WIDTH/8)+1] : us_wdata;
assign us_mux_wstrb	= wdata_buffer_valid ? wdata_buffer[(US_DATA_WIDTH/8):1] : us_wstrb;
assign us_mux_wlast	= wdata_buffer_valid ? wdata_buffer[0] : us_wlast;
assign ds_wdata_last	= (!(|wdata_burst_count_mux));
assign us_wready 	= (!wdata_buffer_valid);

assign wid_fifo_wdata 	= {us_wdata_id, us_wlast_burst};
assign wid_fifo_wr 	= ds_awvalid && ds_awready;
assign wid_fifo_rd	= update_us_wresp && ds_mux_bvalid;

assign wresp_id		= wid_fifo_rdata[WID_WIDTH-1:1];
assign wresp_trans_complete	= wid_fifo_rdata[0];

assign update_us_wresp 	= ((!us_bvalid) || us_bready) && (!wid_fifo_empty);

assign ds_mux_bresp	= wresp_buffer_valid ? wresp_buffer : ds_bresp;
assign ds_mux_bvalid	= wresp_buffer_valid ? 1'b1 : ds_bvalid;
assign ds_bready	= (!wresp_buffer_valid);

always @(*) begin
	if (ds_rdata_valid && (!update_us_rdata)) begin
		rdata_buffer_valid_a1 = 1'b1;
	end
	else if (update_us_rdata) begin
		rdata_buffer_valid_a1 = 1'b0;
	end
	else begin
		rdata_buffer_valid_a1 = rdata_buffer_valid;
	end
end

always @(*) begin
	if (ds_rdata_valid) begin
		rdata_buffer_a1	= {ds_rdata, ds_rresp, ds_rlast};
	end
	else begin
		rdata_buffer_a1 = rdata_buffer;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		rdata_buffer_valid 	<= 1'b0;
		rdata_buffer		<= {(RDATA_BUFFER_WIDTH){1'b0}};
	end
	else begin
		rdata_buffer_valid 	<= rdata_buffer_valid_a1;
		rdata_buffer		<= rdata_buffer_a1;
	end
end

always @(*) begin
	if ((!rcmd_fifo_empty) && rcmd_fifo_empty_d1) begin
		rdata_addr_sel_a1 = 1'b1;
	end
	else if ((!rcmd_fifo_empty) && rcmd_fifo_rd_d1) begin
		rdata_addr_sel_a1 = 1'b1;
	end
	else if (update_us_rdata_d1) begin
		rdata_addr_sel_a1 = 1'b0;
	end
	else begin
		rdata_addr_sel_a1 = rdata_addr_sel;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		update_us_rdata_d1	<= 1'b0;
		rcmd_fifo_empty_d1 	<= 1'b0;
		rcmd_fifo_rd_d1		<= 1'b0;
		rdata_addr_sel 		<= 1'b0;
	end
	else begin
		update_us_rdata_d1	<= update_us_rdata && (ds_rvalid || rdata_buffer_valid);
		rcmd_fifo_empty_d1 	<= rcmd_fifo_empty;
		rcmd_fifo_rd_d1		<= rcmd_fifo_rd;
		rdata_addr_sel 		<= rdata_addr_sel_a1;
	end
end

always @(*) begin
	if (rdata_addr_sel_a1) begin
		if (rdata_burst == FIXED) begin
			rdata_update_size_a1	= 5'h0;
		end
		else begin
			rdata_update_size_a1	= (5'h1 << rdata_ds_size);
		end
	end
	else begin
		rdata_update_size_a1	= rdata_update_size;
	end
end

always @(*) begin
	if (update_rdata_addr || rdata_addr_sel_a1) begin
		next_rdata_addr_a1 = (rdata_addr_mux &  rdata_wrap_mask)
                                  | (rdata_incr_addr & ~rdata_wrap_mask);
	end
	else begin
		next_rdata_addr_a1 = next_rdata_addr;
	end
end

generate
	if (DS_DATA_WIDTH == 32) begin :gen_raddr_mux_32_bit
		always @(*) begin
			if (rdata_ratio[1:0] == 2'h0) begin
				rdata_trans_complete	= 1'b1;
			end
			else if (rdata_ratio[1:0] == 2'h1 && rdata_addr_mux[DS_DATA_SIZE[2:0]]) begin
				rdata_trans_complete	= 1'b1;
			end
			else if (rdata_ratio[1:0] == 2'h2 && ((&rdata_addr_mux[DS_DATA_SIZE+1:DS_DATA_SIZE]))) begin
				rdata_trans_complete	= 1'b1;
			end
			else if (rdata_ratio[1:0] == 2'h3 && ((&rdata_addr_mux[DS_DATA_SIZE+2:DS_DATA_SIZE]))) begin
				rdata_trans_complete	= 1'b1;
			end
			else begin
				rdata_trans_complete	= 1'b0;
			end
		end
	end
	else if (DS_DATA_WIDTH == 64) begin :gen_raddr_mux_64_bit
		always @(*) begin
			if (rdata_ratio[1:0] == 2'h0) begin
				rdata_trans_complete	= 1'b1;
			end
			else if (rdata_ratio[1:0] == 2'h1 && rdata_addr_mux[DS_DATA_SIZE[2:0]]) begin
				rdata_trans_complete	= 1'b1;
			end
			else if (rdata_ratio[1:0] == 2'h2 && ((&rdata_addr_mux[DS_DATA_SIZE+1:DS_DATA_SIZE]))) begin
				rdata_trans_complete	= 1'b1;
			end
			else begin
				rdata_trans_complete	= 1'b0;
			end
		end
	end
	else if (DS_DATA_WIDTH == 128) begin :gen_raddr_mux_128_bit
		always @(*) begin
			if (rdata_ratio[1:0] == 2'h0) begin
				rdata_trans_complete	= 1'b1;
			end
			else if (rdata_ratio[1:0] == 2'h1 && rdata_addr_mux[DS_DATA_SIZE[2:0]]) begin
				rdata_trans_complete	= 1'b1;
			end
			else begin
				rdata_trans_complete	= 1'b0;
			end
		end
	end
endgenerate

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		next_rdata_addr		<= 5'h0;
		rdata_update_size	<= 5'h0;
	end
	else begin
		next_rdata_addr		<= next_rdata_addr_a1;
		rdata_update_size	<= rdata_update_size_a1;
	end
end

always @(*) begin
	if (update_us_rdata && rdata_trans_complete) begin
		us_rvalid_a1	= rdata_buffer_valid ? 1'b1 : ds_rvalid;
	end
	else if ((rcmd_fifo_empty || (!rdata_trans_complete)) && us_rready) begin
		us_rvalid_a1	= 1'b0;
	end
	else begin
		us_rvalid_a1	= us_rvalid;
	end
end

always @(*) begin
	if (update_us_rdata) begin
		if (rdata_rlast) begin
			us_rlast_a1	= ds_mux_rlast;
		end
		else begin
			us_rlast_a1	= 1'b0;
		end
	end
	else begin
		us_rlast_a1	= us_rlast;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		rdata_trans_complete_d1	<= 1'b1;
	end
	else begin
		if (update_us_rdata && (ds_rvalid || rdata_buffer_valid)) begin
			rdata_trans_complete_d1	<= rdata_trans_complete;
		end
	end
end

always @(*) begin
	if (update_us_rdata && (rdata_buffer_valid || ds_rvalid) && (rdata_trans_complete_d1 || (us_rresp == 2'h0))) begin
		us_rresp_a1	= ds_mux_rresp;
	end
	else begin
		us_rresp_a1	= us_rresp;
	end
end

assign us_rid_a1	= update_us_rdata ? rdata_bus_id : us_rid;
generate
	if (US_DATA_WIDTH == 256 && DS_DATA_WIDTH == 32) begin :rdata_for_256_to_32_bit
		always @(*) begin
			if (update_us_rdata) begin
				if (rdata_addr_mux[4:2] == 3'h0) begin
					us_rdata_a1[DS_DATA_WIDTH-1:0] 			= ds_mux_rdata;
					us_rdata_a1[US_DATA_WIDTH-1:DS_DATA_WIDTH] 	= us_rdata[US_DATA_WIDTH-1:DS_DATA_WIDTH];
				end
				else if (rdata_addr_mux[4:2] == 3'h1)  begin
					us_rdata_a1[DS_DATA_WIDTH-1:0] 			= us_rdata[DS_DATA_WIDTH-1:0];
					us_rdata_a1[DS_DATA_WIDTH*2-1:DS_DATA_WIDTH] 	= ds_mux_rdata;
					us_rdata_a1[US_DATA_WIDTH-1:DS_DATA_WIDTH*2] 	= us_rdata[US_DATA_WIDTH-1:DS_DATA_WIDTH*2];
				end
				else if (rdata_addr_mux[4:2] == 3'h2)  begin
					us_rdata_a1[DS_DATA_WIDTH*2-1:0] 		= us_rdata[DS_DATA_WIDTH*2-1:0];
					us_rdata_a1[DS_DATA_WIDTH*3-1:DS_DATA_WIDTH*2] 	= ds_mux_rdata;
					us_rdata_a1[US_DATA_WIDTH-1:DS_DATA_WIDTH*3] 	= us_rdata[US_DATA_WIDTH-1:DS_DATA_WIDTH*3];
				end
				else if (rdata_addr_mux[4:2] == 3'h3)  begin
					us_rdata_a1[DS_DATA_WIDTH*3-1:0] 		= us_rdata[DS_DATA_WIDTH*3-1:0];
					us_rdata_a1[DS_DATA_WIDTH*4-1:DS_DATA_WIDTH*3] 	= ds_mux_rdata;
					us_rdata_a1[US_DATA_WIDTH-1:DS_DATA_WIDTH*4] 	= us_rdata[US_DATA_WIDTH-1:DS_DATA_WIDTH*4];
				end
				else if (rdata_addr_mux[4:2] == 3'h4)  begin
					us_rdata_a1[DS_DATA_WIDTH*4-1:0] 		= us_rdata[DS_DATA_WIDTH*4-1:0];
					us_rdata_a1[DS_DATA_WIDTH*5-1:DS_DATA_WIDTH*4] 	= ds_mux_rdata;
					us_rdata_a1[US_DATA_WIDTH-1:DS_DATA_WIDTH*5] 	= us_rdata[US_DATA_WIDTH-1:DS_DATA_WIDTH*5];
				end
				else if (rdata_addr_mux[4:2] == 3'h5)  begin
					us_rdata_a1[DS_DATA_WIDTH*5-1:0] 		= us_rdata[DS_DATA_WIDTH*5-1:0];
					us_rdata_a1[DS_DATA_WIDTH*6-1:DS_DATA_WIDTH*5] 	= ds_mux_rdata;
					us_rdata_a1[US_DATA_WIDTH-1:DS_DATA_WIDTH*6] 	= us_rdata[US_DATA_WIDTH-1:DS_DATA_WIDTH*6];
				end
				else if (rdata_addr_mux[4:2] == 3'h6)  begin
					us_rdata_a1[DS_DATA_WIDTH*6-1:0] 		= us_rdata[DS_DATA_WIDTH*6-1:0];
					us_rdata_a1[DS_DATA_WIDTH*7-1:DS_DATA_WIDTH*6] 	= ds_mux_rdata;
					us_rdata_a1[US_DATA_WIDTH-1:DS_DATA_WIDTH*7] 	= us_rdata[US_DATA_WIDTH-1:DS_DATA_WIDTH*7];
				end
				else begin
					us_rdata_a1[DS_DATA_WIDTH*7-1:0]	 	= us_rdata[DS_DATA_WIDTH*7-1:0];
					us_rdata_a1[DS_DATA_WIDTH*8-1:DS_DATA_WIDTH*7] 	= ds_mux_rdata;
				end
			end
			else begin
				us_rdata_a1 	= us_rdata;
			end
		end
	end
	else if (US_DATA_WIDTH == 256 && DS_DATA_WIDTH == 64) begin :rdata_for_256_to_64_bit
		always @(*) begin
			if (update_us_rdata) begin
				if (rdata_addr_mux[4:3] == 2'h0) begin
					us_rdata_a1[DS_DATA_WIDTH-1:0] 			= ds_mux_rdata;
					us_rdata_a1[US_DATA_WIDTH-1:DS_DATA_WIDTH] 	= us_rdata[US_DATA_WIDTH-1:DS_DATA_WIDTH];
				end
				else if (rdata_addr_mux[4:3] == 2'h1)  begin
					us_rdata_a1[DS_DATA_WIDTH-1:0] 			= us_rdata[DS_DATA_WIDTH-1:0];
					us_rdata_a1[DS_DATA_WIDTH*2-1:DS_DATA_WIDTH] 	= ds_mux_rdata;
					us_rdata_a1[US_DATA_WIDTH-1:DS_DATA_WIDTH*2] 	= us_rdata[US_DATA_WIDTH-1:DS_DATA_WIDTH*2];
				end
				else if (rdata_addr_mux[4:3] == 2'h2)  begin
					us_rdata_a1[DS_DATA_WIDTH*2-1:0] 		= us_rdata[DS_DATA_WIDTH*2-1:0];
					us_rdata_a1[DS_DATA_WIDTH*3-1:DS_DATA_WIDTH*2] 	= ds_mux_rdata;
					us_rdata_a1[US_DATA_WIDTH-1:DS_DATA_WIDTH*3] 	= us_rdata[US_DATA_WIDTH-1:DS_DATA_WIDTH*3];
				end
				else begin
					us_rdata_a1[DS_DATA_WIDTH*3-1:0]	 	= us_rdata[DS_DATA_WIDTH*3-1:0];
					us_rdata_a1[DS_DATA_WIDTH*4-1:DS_DATA_WIDTH*3] 	= ds_mux_rdata;
				end
			end
			else begin
				us_rdata_a1 	= us_rdata;
			end
		end
	end
	else if (US_DATA_WIDTH == 128 && DS_DATA_WIDTH == 32) begin :rdata_for_128_to_32_bit
		always @(*) begin
			if (update_us_rdata) begin
				if (rdata_addr_mux[3:2] == 2'h0) begin
					us_rdata_a1[DS_DATA_WIDTH-1:0] 			= ds_mux_rdata;
					us_rdata_a1[US_DATA_WIDTH-1:DS_DATA_WIDTH] 	= us_rdata[US_DATA_WIDTH-1:DS_DATA_WIDTH];
				end
				else if (rdata_addr_mux[3:2] == 2'h1)  begin
					us_rdata_a1[DS_DATA_WIDTH-1:0] 			= us_rdata[DS_DATA_WIDTH-1:0];
					us_rdata_a1[DS_DATA_WIDTH*2-1:DS_DATA_WIDTH] 	= ds_mux_rdata;
					us_rdata_a1[US_DATA_WIDTH-1:DS_DATA_WIDTH*2] 	= us_rdata[US_DATA_WIDTH-1:DS_DATA_WIDTH*2];
				end
				else if (rdata_addr_mux[3:2] == 2'h2)  begin
					us_rdata_a1[DS_DATA_WIDTH*2-1:0] 		= us_rdata[DS_DATA_WIDTH*2-1:0];
					us_rdata_a1[DS_DATA_WIDTH*3-1:DS_DATA_WIDTH*2] 	= ds_mux_rdata;
					us_rdata_a1[US_DATA_WIDTH-1:DS_DATA_WIDTH*3] 	= us_rdata[US_DATA_WIDTH-1:DS_DATA_WIDTH*3];
				end
				else begin
					us_rdata_a1[DS_DATA_WIDTH*3-1:0]	 	= us_rdata[DS_DATA_WIDTH*3-1:0];
					us_rdata_a1[DS_DATA_WIDTH*4-1:DS_DATA_WIDTH*3] 	= ds_mux_rdata;
				end
			end
			else begin
				us_rdata_a1 	= us_rdata;
			end
		end
	end
	else begin :rdata_for_other_bits
		always @(*) begin
			if (update_us_rdata) begin
				if (rdata_addr_mux[DS_DATA_SIZE[2:0]] == 1'h0) begin
					us_rdata_a1[DS_DATA_WIDTH-1:0] 			= ds_mux_rdata;
					us_rdata_a1[US_DATA_WIDTH-1:DS_DATA_WIDTH] 	= us_rdata[US_DATA_WIDTH-1:DS_DATA_WIDTH];
				end
				else begin
					us_rdata_a1[DS_DATA_WIDTH-1:0] 			= us_rdata[DS_DATA_WIDTH-1:0];
					us_rdata_a1[DS_DATA_WIDTH*2-1:DS_DATA_WIDTH] 	= ds_mux_rdata;
				end
			end
			else begin
				us_rdata_a1 	= us_rdata;
			end
		end
	end
endgenerate

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us_rvalid	<= 1'b0;
		us_rid		<= {(ID_WIDTH){1'b0}};
		us_rdata	<= {(US_DATA_WIDTH){1'b0}};
		us_rresp	<= 2'h0;
		us_rlast	<= 1'b0;
	end
	else begin
		us_rvalid	<= us_rvalid_a1;
		us_rid		<= us_rid_a1;
		us_rdata	<= us_rdata_a1;
		us_rresp	<= us_rresp_a1;
		us_rlast	<= us_rlast_a1;
	end
end

always @(*) begin
	if (us_wdata_valid && ((!update_ds_wdata) || (!wdata_trans_complete))) begin
		wdata_buffer_valid_a1 = 1'b1;
	end
	else if (update_ds_wdata && wdata_trans_complete) begin
		wdata_buffer_valid_a1 = 1'b0;
	end
	else begin
		wdata_buffer_valid_a1 = wdata_buffer_valid;
	end
end

always @(*) begin
	if (us_wdata_valid) begin
		wdata_buffer_a1 = {us_wdata, us_wstrb, us_wlast};
	end
	else begin
		wdata_buffer_a1 = wdata_buffer;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		wdata_buffer_valid 	<= 1'b0;
		wdata_buffer	<= {(WDATA_BUFFER_WIDTH){1'b0}};
	end
	else begin
		wdata_buffer_valid 	<= wdata_buffer_valid_a1;
		wdata_buffer	<= wdata_buffer_a1;
	end
end

generate
	if (DS_DATA_WIDTH == 32) begin : gen_waddr_mux_32_bit
		always @(*) begin
			if (wdata_ratio[1:0] == 2'h0) begin
				wdata_trans_complete	= 1'b1;
			end
			else if (wdata_ratio[1:0] == 2'h1 && wdata_addr_mux[DS_DATA_SIZE[2:0]]) begin
				wdata_trans_complete	= 1'b1;
			end
			else if (wdata_ratio[1:0] == 2'h2 && (&wdata_addr_mux[DS_DATA_SIZE+1:DS_DATA_SIZE])) begin
				wdata_trans_complete	= 1'b1;
			end
			else if (wdata_ratio[1:0] == 2'h3 && (&wdata_addr_mux[DS_DATA_SIZE+2:DS_DATA_SIZE])) begin
				wdata_trans_complete	= 1'b1;
			end
			else begin
				wdata_trans_complete	= 1'b0;
			end
		end
	end
	else if (DS_DATA_WIDTH == 64) begin : gen_waddr_mux_64_bit
		always @(*) begin
			if (wdata_ratio[1:0] == 2'h0) begin
				wdata_trans_complete	= 1'b1;
			end
			else if (wdata_ratio[1:0] == 2'h1 && wdata_addr_mux[DS_DATA_SIZE[2:0]]) begin
				wdata_trans_complete	= 1'b1;
			end
			else if (wdata_ratio[1:0] == 2'h2 && (&wdata_addr_mux[DS_DATA_SIZE+1:DS_DATA_SIZE])) begin
				wdata_trans_complete	= 1'b1;
			end
			else begin
				wdata_trans_complete	= 1'b0;
			end
		end
	end
	else if (DS_DATA_WIDTH == 128) begin : gen_waddr_mux_128_bit
		always @(*) begin
			if (wdata_ratio[1:0] == 2'h0) begin
				wdata_trans_complete	= 1'b1;
			end
			else if (wdata_ratio[1:0] == 2'h1 && wdata_addr_mux[DS_DATA_SIZE[2:0]]) begin
				wdata_trans_complete	= 1'b1;
			end
			else begin
				wdata_trans_complete	= 1'b0;
			end
		end
	end
endgenerate

always @(*) begin
	if ((!wcmd_fifo_empty) && wcmd_fifo_empty_d1) begin
		wdata_addr_sel_a1 = 1'b1;
	end
	else if ((!wcmd_fifo_empty) && wcmd_fifo_rd_d1) begin
		wdata_addr_sel_a1 = 1'b1;
	end
	else if (update_ds_wdata_d1) begin
		wdata_addr_sel_a1 = 1'b0;
	end
	else begin
		wdata_addr_sel_a1 = wdata_addr_sel;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		update_ds_wdata_d1	<= 1'b0;
		wcmd_fifo_empty_d1 	<= 1'b0;
		wcmd_fifo_rd_d1		<= 1'b0;
		wdata_addr_sel 		<= 1'b0;
	end
	else begin
		update_ds_wdata_d1	<= update_ds_wdata && (us_wvalid || wdata_buffer_valid);
		wcmd_fifo_empty_d1 	<= wcmd_fifo_empty;
		wcmd_fifo_rd_d1		<= wcmd_fifo_rd;
		wdata_addr_sel 		<= wdata_addr_sel_a1;
	end
end

always @(*) begin
	if (wdata_addr_sel_a1) begin
		if (wdata_burst == FIXED) begin
			wdata_update_size_a1	= 5'h0;
		end
		else begin
			wdata_update_size_a1	= (5'h1 << wdata_ds_size);
		end
	end
	else begin
		wdata_update_size_a1	= wdata_update_size;
	end
end

always @(*) begin
	if (update_wdata_addr || wdata_addr_sel_a1) begin
		wdata_burst_count_a1 = wdata_burst_count_mux - 8'h1;
		next_wdata_addr_a1 = (wdata_addr_mux &  wdata_wrap_mask)
                                  | (wdata_incr_addr & ~wdata_wrap_mask);
	end
	else begin
		wdata_burst_count_a1 = wdata_burst_count;
		next_wdata_addr_a1 = next_wdata_addr;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		next_wdata_addr	<= 5'h0;
		wdata_burst_count 	<= 8'h0;
		wdata_update_size	<= 5'h0;
	end
	else begin
		next_wdata_addr	<= next_wdata_addr_a1;
		wdata_burst_count 	<= wdata_burst_count_a1;
		wdata_update_size	<= wdata_update_size_a1;
	end
end

always @(*) begin
	if (update_ds_wdata) begin
		ds_wvalid_a1	= wdata_buffer_valid ? 1'b1 : us_wvalid;
	end
	else if (wcmd_fifo_empty && ds_wready) begin
		ds_wvalid_a1	= 1'b0;
	end
	else begin
		ds_wvalid_a1	= ds_wvalid;
	end
end

always @(*) begin
	if (update_ds_wdata) begin
		if (ds_wdata_last) begin
			ds_wlast_a1 	= 1'b1;
		end
		else begin
			ds_wlast_a1 	= 1'b0;
		end
	end
	else begin
		ds_wlast_a1 	= ds_wlast;
	end
end

generate
	if (US_DATA_WIDTH == 256 && DS_DATA_WIDTH == 32) begin :wstrb_for_256_to_32_bit
		always @(*) begin
			if (update_ds_wdata) begin
				if (wdata_addr_mux[4:2] == 3'h0) begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH-1:0];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)-1:0];
				end
				else if (wdata_addr_mux[4:2] == 3'h1)  begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH*2-1:DS_DATA_WIDTH];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)*2-1:(DS_DATA_WIDTH/8)];
				end
				else if (wdata_addr_mux[4:2] == 3'h2)  begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH*3-1:DS_DATA_WIDTH*2];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)*3-1:(DS_DATA_WIDTH/8)*2];
				end
				else if (wdata_addr_mux[4:2] == 3'h3)  begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH*4-1:DS_DATA_WIDTH*3];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)*4-1:(DS_DATA_WIDTH/8)*3];
				end
				else if (wdata_addr_mux[4:2] == 3'h4)  begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH*5-1:DS_DATA_WIDTH*4];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)*5-1:(DS_DATA_WIDTH/8)*4];
				end
				else if (wdata_addr_mux[4:2] == 3'h5)  begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH*6-1:DS_DATA_WIDTH*5];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)*6-1:(DS_DATA_WIDTH/8)*5];
				end
				else if (wdata_addr_mux[4:2] == 3'h6)  begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH*7-1:DS_DATA_WIDTH*6];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)*7-1:(DS_DATA_WIDTH/8)*6];
				end
				else begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH*8-1:DS_DATA_WIDTH*7];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)*8-1:(DS_DATA_WIDTH/8)*7];
				end
			end
			else begin
				ds_wdata_a1 	= ds_wdata;
				ds_wstrb_a1 	= ds_wstrb;
			end
		end
	end
	else if (US_DATA_WIDTH == 256 && DS_DATA_WIDTH == 64) begin :wstrb_for_256_to_64_bit
		always @(*) begin
			if (update_ds_wdata) begin
				if (wdata_addr_mux[4:3] == 2'h0) begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH-1:0];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)-1:0];
				end
				else if (wdata_addr_mux[4:3] == 2'h1)  begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH*2-1:DS_DATA_WIDTH];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)*2-1:(DS_DATA_WIDTH/8)];
				end
				else if (wdata_addr_mux[4:3] == 2'h2)  begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH*3-1:DS_DATA_WIDTH*2];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)*3-1:(DS_DATA_WIDTH/8)*2];
				end
				else begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH*4-1:DS_DATA_WIDTH*3];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)*4-1:(DS_DATA_WIDTH/8)*3];
				end
			end
			else begin
				ds_wdata_a1 	= ds_wdata;
				ds_wstrb_a1 	= ds_wstrb;
			end
		end
	end
	else if (US_DATA_WIDTH == 128 && DS_DATA_WIDTH == 32) begin :wstrb_for_128_to_32_bit
		always @(*) begin
			if (update_ds_wdata) begin
				if (wdata_addr_mux[3:2] == 2'h0) begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH-1:0];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)-1:0];
				end
				else if (wdata_addr_mux[3:2] == 2'h1)  begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH*2-1:DS_DATA_WIDTH];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)*2-1:(DS_DATA_WIDTH/8)];
				end
				else if (wdata_addr_mux[3:2] == 2'h2)  begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH*3-1:DS_DATA_WIDTH*2];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)*3-1:(DS_DATA_WIDTH/8)*2];
				end
				else begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH*4-1:DS_DATA_WIDTH*3];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)*4-1:(DS_DATA_WIDTH/8)*3];
				end
			end
			else begin
				ds_wdata_a1 	= ds_wdata;
				ds_wstrb_a1 	= ds_wstrb;
			end
		end
	end
	else begin :wstrb_for_other_bits
		always @(*) begin
			if (update_ds_wdata) begin
				if (wdata_addr_mux[DS_DATA_SIZE[2:0]] == 1'h0) begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH-1:0];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)-1:0];
				end
				else begin
					ds_wdata_a1 	= us_mux_wdata[DS_DATA_WIDTH*2-1:DS_DATA_WIDTH];
					ds_wstrb_a1 	= us_mux_wstrb[(DS_DATA_WIDTH/8)*2-1:(DS_DATA_WIDTH/8)];
				end
			end
			else begin
				ds_wdata_a1 	= ds_wdata;
				ds_wstrb_a1 	= ds_wstrb;
			end
		end
	end
endgenerate

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds_wvalid	<= 1'b0;
		ds_wlast	<= 1'b0;
		ds_wdata	<= {(DS_DATA_WIDTH){1'b0}};
		ds_wstrb	<= {((DS_DATA_WIDTH/8)){1'b0}};
	end
	else begin
		ds_wvalid	<= ds_wvalid_a1;
		ds_wlast	<= ds_wlast_a1;
		ds_wdata	<= ds_wdata_a1;
		ds_wstrb	<= ds_wstrb_a1;
	end
end

always @(*) begin
	if (ds_bvalid && (!update_us_wresp)) begin
		wresp_buffer_valid_a1 	= 1'b1;
	end
	else if (update_us_wresp) begin
		wresp_buffer_valid_a1 	= 1'b0;
	end
	else begin
		wresp_buffer_valid_a1 	= wresp_buffer_valid;
	end
end

always @(*) begin
	if (ds_bvalid && ds_bready) begin
		wresp_buffer_a1	= ds_bresp;
	end
	else begin
		wresp_buffer_a1	= wresp_buffer;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		wresp_buffer_valid	<= 1'b0;
		wresp_buffer		<= 2'h0;
	end
	else begin
		wresp_buffer_valid	<= wresp_buffer_valid_a1;
		wresp_buffer		<= wresp_buffer_a1;
	end
end


always @(*) begin
	if (update_us_wresp && wresp_trans_complete) begin
		us_bvalid_a1	= ds_mux_bvalid;
	end
	else if ((wid_fifo_empty || (!wresp_trans_complete)) && us_bready) begin
		us_bvalid_a1	= 1'b0;
	end
	else begin
		us_bvalid_a1	= us_bvalid;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		wresp_trans_complete_d1	<= 1'b1;
	end
	else begin
		if (update_us_wresp && (ds_bvalid || wresp_buffer_valid)) begin
			wresp_trans_complete_d1	<= wresp_trans_complete;
		end
	end
end

always @(*) begin
	if (update_us_wresp && (wresp_buffer_valid || ds_bvalid) && (wresp_trans_complete_d1 || (us_bresp == 2'h0))) begin
		us_bresp_a1	= ds_mux_bresp;
	end
	else begin
		us_bresp_a1	= us_bresp;
	end
end

always @(*) begin
	if (update_us_wresp) begin
		us_bid_a1	= wresp_id;
	end
	else begin
		us_bid_a1	= us_bid;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		us_bresp	<= 2'h0;
		us_bvalid	<= 1'b0;
		us_bid		<= {(ID_WIDTH){1'b0}};
	end
	else begin
		us_bresp	<= us_bresp_a1;
		us_bvalid	<= us_bvalid_a1;
		us_bid		<= us_bid_a1;
	end
end

nds_sync_fifo_afe #(.DATA_WIDTH(RCMD_WIDTH),.FIFO_DEPTH(4)) rdata_cmd_fifo
(
.reset_n(aresetn),
.clk(aclk),
.wr(rcmd_fifo_wr),
.wr_data(rcmd_fifo_wdata),
.rd(rcmd_fifo_rd),
.rd_data(rcmd_fifo_rdata),
.almost_empty(),
.almost_full(),
.empty(rcmd_fifo_empty),
.full(rcmd_fifo_full)
);

nds_sync_fifo_afe #(.DATA_WIDTH(WCMD_WIDTH),.FIFO_DEPTH(4)) wdata_cmd_fifo
(
.reset_n(aresetn),
.clk(aclk),
.wr(wcmd_fifo_wr),
.wr_data(wcmd_fifo_wdata),
.rd(wcmd_fifo_rd),
.rd_data(wcmd_fifo_rdata),
.almost_empty(),
.almost_full(),
.empty(wcmd_fifo_empty),
.full()
);

nds_sync_fifo_afe #(.DATA_WIDTH(WID_WIDTH),.FIFO_DEPTH(4)) u_cmd_fifo
(
.reset_n(aresetn),
.clk(aclk),
.wr(wid_fifo_wr),
.wr_data(wid_fifo_wdata),
.rd(wid_fifo_rd),
.rd_data(wid_fifo_rdata),
.almost_empty(),
.almost_full(),
.empty(wid_fifo_empty),
.full(wcmd_fifo_full)
);

endmodule

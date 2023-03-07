// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


`timescale 1ns/1ps

module axi_monitor (
	  aclk,
	  aresetn,
	  awid,
	  awaddr,
	  awlen,
	  awsize,
	  awburst,
	  awlock,
	  awcache,
	  awprot,
	  awvalid,
	  awready,
`ifdef NDS_AXI_AWREGION_SUPPORT
	  awregion,
`endif
`ifdef NDS_AXI_AWQOS_SUPPORT
	  awqos,
`endif
`ifdef NDS_AXI_AWUSER_SUPPORT
	  awuser,
`endif
	  wid,
	  wdata,
	  wstrb,
	  wlast,
	  wvalid,
	  wready,
`ifdef NDS_AXI_WUSER_SUPPORT
	  wuser,
`endif
	  bid,
	  bresp,
	  bvalid,
	  bready,
`ifdef NDS_AXI_BUSER_SUPPORT
	  buser,
`endif
	  arid,
	  araddr,
	  arlen,
	  arsize,
	  arburst,
	  arlock,
	  arcache,
	  arprot,
	  arvalid,
	  arready,
`ifdef NDS_AXI_ARREGION_SUPPORT
	  arregion,
`endif
`ifdef NDS_AXI_ARQOS_SUPPORT
	  arqos,
`endif
`ifdef NDS_AXI_ARUSER_SUPPORT
	  aruser,
`endif
	  rid,
	  rdata,
	  rresp,
	  rlast,
	  rvalid,
`ifdef NDS_AXI_RUSER_SUPPORT
	  ruser,
`endif
	  rready
);
parameter DATA_WIDTH = 2;
parameter ADDR_WIDTH = 32;
parameter ID_WIDTH = 4;
parameter MASTER_ID = 10;
parameter SLAVE_ID = 1;
parameter AXI4 = 0;
parameter FIX_BURST = 1;
parameter WRAP_BURST = 1;
parameter UNALIGNED_BURST = 1'b0;
parameter HOLE_IN_STROBE = 1'b0;
localparam AWREGION_WIDTH = 
                            `ifdef NDS_AXI_AWREGION_SUPPORT 4; `else 0; `endif
localparam ARREGION_WIDTH = 
                            `ifdef NDS_AXI_ARREGION_SUPPORT 4; `else 0; `endif
localparam AWQOS_WIDTH 	 = 
                           `ifdef NDS_AXI_AWQOS_SUPPORT 4; `else 0; `endif
localparam ARQOS_WIDTH 	 = 
                           `ifdef NDS_AXI_ARQOS_SUPPORT 4; `else 0; `endif
parameter AWUSER_WIDTH	 = 0;
parameter ARUSER_WIDTH	 = 0;
parameter WUSER_WIDTH	 = 0;
parameter RUSER_WIDTH	 = 0;
parameter BUSER_WIDTH	 = 0;

parameter FIFO_PTR_WIDTH = 20;

parameter WAIT_READ_DATA_LIMIT = 100;
parameter WAIT_ARREADY = 100;
parameter WAIT_RREADY = 100;
parameter WAIT_AWREADY = 100;
parameter WAIT_WREADY = 100;

parameter WLATENCY_MAX = WAIT_AWREADY * 4;
parameter RLATENCY_MAX = WAIT_READ_DATA_LIMIT;

localparam AXLEN_WIDTH = 4 + (AXI4 * 4);

localparam DATA_BYTES = (1 << DATA_WIDTH);
localparam DATA_BITS = DATA_BYTES * 8;

localparam ID_NUM = 1 << ID_WIDTH;
localparam FIFO_DEPTH = 1 << (FIFO_PTR_WIDTH - 1);

localparam WRCMD_ADDR_WIDTH = 14 + AXLEN_WIDTH + ADDR_WIDTH + AWREGION_WIDTH + AWQOS_WIDTH + AWUSER_WIDTH;
localparam RDCMD_ADDR_WIDTH = 14 + AXLEN_WIDTH + ADDR_WIDTH + ARREGION_WIDTH + ARQOS_WIDTH + ARUSER_WIDTH;

localparam FIXED = 2'b00;
localparam INCR = 2'b01;
localparam WRAP = 2'b10;

localparam WAQ_NUM = AXI4 ? 1 : ID_NUM;

input				aclk;
input				aresetn;
input [ID_WIDTH-1:0]		awid;
input [ADDR_WIDTH-1:0]		awaddr;
input [AXLEN_WIDTH-1:0]		awlen;
input [2:0]			awsize;
input [1:0]			awburst;
input [1:0]			awlock;
input [3:0]			awcache;
input [2:0]			awprot;
input				awvalid;
input				awready;
`ifdef NDS_AXI_AWREGION_SUPPORT
input [3:0]			awregion;
`endif
`ifdef NDS_AXI_AWQOS_SUPPORT
input [3:0]			awqos;
`endif
`ifdef NDS_AXI_AWUSER_SUPPORT
input [AWUSER_WIDTH-1:0]	awuser;
`endif
input [ID_WIDTH-1:0]		wid;
input [DATA_BITS-1:0]		wdata;
input [DATA_BYTES-1:0]		wstrb;
input				wlast;
input				wvalid;
input				wready;
`ifdef NDS_AXI_WUSER_SUPPORT
input [WUSER_WIDTH-1:0]		wuser;
`endif
input [ID_WIDTH-1:0]		bid;
input [1:0]			bresp;
input				bvalid;
input				bready;
`ifdef NDS_AXI_BUSER_SUPPORT
input [BUSER_WIDTH-1:0]	buser;
`endif
input [ID_WIDTH-1:0]		arid;
input [ADDR_WIDTH-1:0]		araddr;
input [AXLEN_WIDTH-1:0]		arlen;
input [2:0]			arsize;
input [1:0]			arburst;
input [1:0]			arlock;
input [3:0]			arcache;
input [2:0]			arprot;
input				arvalid;
input				arready;
`ifdef NDS_AXI_ARREGION_SUPPORT
input [3:0]			arregion;
`endif
`ifdef NDS_AXI_ARQOS_SUPPORT
input [3:0]			arqos;
`endif
`ifdef NDS_AXI_ARUSER_SUPPORT
input [ARUSER_WIDTH-1:0]	aruser;
`endif
input [ID_WIDTH-1:0]		rid;
input [DATA_BITS-1:0]		rdata;
input [1:0]			rresp;
input				rlast;
input				rvalid;
`ifdef NDS_AXI_RUSER_SUPPORT
input [RUSER_WIDTH-1:0]		ruser;
`endif
input				rready;

reg [31:0]			wait_count_ar;
reg [31:0]			wait_count_r;
reg [31:0]			wait_count_aw;
reg [31:0]			wait_count_w;

wire [ADDR_WIDTH-1:0]		awsize_bytes = 1 << awsize;
wire [ADDR_WIDTH-1:0]		arsize_bytes = 1 << arsize;
reg  [12:0]			awaddr_n;
reg  [12:0]			araddr_n;

`ifdef NDS_AXI_PERFORM
wire				w_start;
wire				w_valid;
wire				r_start;
wire				r_valid;
`endif


wire [WRCMD_ADDR_WIDTH-1:0]		current_awd_fifo_rdata;
`ifdef NDS_AXI_AWREGION_SUPPORT
wire [AWREGION_WIDTH-1:0]		current_wregion;
`endif
`ifdef NDS_AXI_AWQOS_SUPPORT
wire [AWQOS_WIDTH-1:0]			current_wqos;
`endif
`ifdef NDS_AXI_AWUSER_SUPPORT
wire [AWUSER_WIDTH-1:0]			current_awuser;
`endif
`ifdef NDS_AXI_WUSER_SUPPORT
wire [WUSER_WIDTH-1:0]			current_wuser;
`endif
wire [ADDR_WIDTH-1:0]			current_waddr;
wire [3:0]				current_wcache;
wire [2:0]				current_wprot;
wire [AXLEN_WIDTH-1:0]			current_wlen;
wire [2:0]				current_wsize;
wire [1:0]				current_wburst;
wire [1:0]				current_wlock;
wire [ID_WIDTH-1:0]			current_wid;
wire [DATA_BITS-1:0]			current_wdata;
wire [DATA_BYTES-1:0]			current_wstrb;
wire [ID_WIDTH-1:0]			in_wid;
wire [DATA_BYTES-1:0]			wbyte_lane;
wire [DATA_BYTES-1:0]			wbyte_lane_one_hot_vector;
wire [DATA_BYTES-1:0]			current_write_byte;
wire 					hole_in_wstrb;
wire					current_wlast;
wire [WAQ_NUM-1:0]			awd_fifo_empty_all;
reg  [WAQ_NUM-1:0]			is_first_wctl;
reg  [ADDR_WIDTH-1:0]			next_waddr_per_id	[0:WAQ_NUM-1];
wire [WRCMD_ADDR_WIDTH-1:0]		awd_fifo_rdata_per_id	[0:WAQ_NUM-1];
wire [ADDR_WIDTH-1:0]			wbytes;
wire [ADDR_WIDTH-1:0]			waddr_mask;
wire [ADDR_WIDTH-1:0]			waddr_incr;
wire [2+AXI4:0]				wlen_bits;
wire [ADDR_WIDTH-1:0]			wwrap_bytes;
wire [ADDR_WIDTH-1:0]			wwrap_mask;
event					write_trans;

wire [ID_WIDTH+DATA_BYTES+DATA_BITS+WUSER_WIDTH:0]	wdq_wdata;
wire [ID_WIDTH+DATA_BYTES+DATA_BITS+WUSER_WIDTH:0]	wdq_rdata;
wire 					wdq_empty;
wire					wdq_full;
wire					wdq_wr;
wire					wdq_rd;

wire [WRCMD_ADDR_WIDTH-1:0]		bid_aw_fifo_rdata;
wire [WRCMD_ADDR_WIDTH-1:0]		aw_fifo_rdata_per_id	[0:WAQ_NUM-1];
wire [32+DATA_BYTES+DATA_BITS+WUSER_WIDTH-1:0]	bid_w_fifo_rdata;
wire [32+DATA_BYTES+DATA_BITS+WUSER_WIDTH-1:0]	w_fifo_rdata_per_id	[0:WAQ_NUM-1];
wire [ID_WIDTH-1:0]			in_bid;
event					bresp_trans;

`ifdef NDS_AXI_ARREGION_SUPPORT
wire [ARREGION_WIDTH-1:0]		current_rregion;
`endif
`ifdef NDS_AXI_ARQOS_SUPPORT
wire [ARQOS_WIDTH-1:0]			current_rqos;
`endif
`ifdef NDS_AXI_ARUSER_SUPPORT
wire [ARUSER_WIDTH-1:0]			current_aruser;
`endif
wire [RDCMD_ADDR_WIDTH-1:0]		current_ar_fifo_rdata;
wire [ADDR_WIDTH-1:0]			current_raddr;
wire [3:0]				current_rcache;
wire [AXLEN_WIDTH-1:0]			current_rlen;
wire [2:0]				current_rsize;
wire [1:0]				current_rburst;
wire [1:0]				current_rlock;
reg  [ID_NUM-1:0]			is_first_rctl;
reg  [ADDR_WIDTH-1:0]			next_raddr_per_id	[0:ID_NUM-1];
wire [RDCMD_ADDR_WIDTH-1:0]		ar_fifo_rdata_per_id	[0:ID_NUM-1];
wire [ADDR_WIDTH-1:0]			rbytes;
wire [ADDR_WIDTH-1:0]			raddr_mask;
wire [ADDR_WIDTH-1:0]			raddr_incr;
wire [2+AXI4:0]				rlen_bits;
wire [ADDR_WIDTH-1:0]			rwrap_bytes;
wire [ADDR_WIDTH-1:0]			rwrap_mask;
event					read_trans;


`include "sync_tasks.vh"


reg dispmon_axi_addr_mon_9;
reg dispmon_axi_mon_0;
reg dispmon_axi_mon_9;
initial begin
	dispmon_axi_addr_mon_9 = 1'b1;
	dispmon_axi_mon_0 = 1'b1;
	dispmon_axi_mon_9 = 1'b1;

	if ($test$plusargs("mon+axi_addr_mon+9+off")) dispmon_axi_addr_mon_9 = 1'b0;
	if ($test$plusargs("mon+axi_mon+0+off")) dispmon_axi_mon_0 = 1'b0;
	if ($test$plusargs("mon+axi_mon+9+off")) dispmon_axi_mon_9 = 1'b0;
end



wire [AXLEN_WIDTH+ADDR_WIDTH-1:0]	awsize_bytes_x_awlen = awsize_bytes * awlen;

always @(posedge aclk) begin
	if (awvalid & awready) begin
		case (awburst)
		FIXED:
			if (FIX_BURST == 1) begin
				if ({{(32-AXLEN_WIDTH){1'b0}},awlen} >= 16) begin
					if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d Invalid awlen=%d for FIXED burst.", $realtime, MASTER_ID, awlen); #1 $finish; end
				end
			end
			else begin
				if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d awburst=FIXED is not supported.", $realtime, MASTER_ID); #1 $finish; end
			end
		INCR: begin
			awaddr_n = {1'd0, awaddr[11:0]} + awsize_bytes_x_awlen[12:0];
			if (awaddr_n[12]) begin
				if (dispmon_axi_addr_mon_9) begin $display("%0t:axi_addr_mon:ERROR:M%0d INCR BURST accross 4K boundary, awaddr=0x%h awlen=%d awsize=%d.", $realtime, MASTER_ID, awaddr, awlen, awsize); #1 $finish; end
			end
		end
		WRAP:
			if (WRAP_BURST == 1) begin
				if (((AXI4 == 1) && (|awlen[AXLEN_WIDTH-1:AXLEN_WIDTH-4])) ||
				   ((awlen[3:0] !== 4'd1) && (awlen[3:0] !== 4'd3) && (awlen[3:0] !== 4'd7) && (awlen[3:0] !== 4'd15))) begin
					if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d Invalid awlen=%d for WRAP burst.", $realtime, MASTER_ID, awlen); #1 $finish; end
				end
			end
			else begin
				if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d awburst=WRAP is not supported.", $realtime, MASTER_ID); #1 $finish; end
			end
		2'b11: begin
				if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d awburst=2'b11 is reserved.", $realtime, MASTER_ID); #1 $finish; end
			end
		default: begin
				if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d unknown awburst is reserved.", $realtime, MASTER_ID); #1 $finish; end
		        end
		endcase
		if (&{UNALIGNED_BURST,awaddr & (awsize_bytes - {{(ADDR_WIDTH-1){1'b0}}, 1'b1})}) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d awaddr=0x%h is not aligned to the burst size %0d.", $realtime, MASTER_ID, awaddr, awsize_bytes); #1 $finish; end
		end
	end
end

assign bid_aw_fifo_rdata = aw_fifo_rdata_per_id[in_bid];

function [6*8-1:0] resp_str;
input [1:0] resp;
begin
	case(resp)
	2'b00: resp_str = "ok";
	2'b01: resp_str = "exokay";
	2'b10: resp_str = "slverr";
	2'b11: resp_str = "decerr";
	default: resp_str = "x";
	endcase
end
endfunction

always @(posedge aclk) begin
	if (awvalid & awready) begin
		if (dispmon_axi_mon_0) $display("%0t:axi_mon:M%0dS%0d write %h id=%h len=%h size=%h burst=%h cache=%h prot=%h%0s%0s%0s%0s", $realtime, MASTER_ID, SLAVE_ID, awaddr, awid, awlen, awsize, awburst, awcache, awprot
			`ifdef NDS_AXI_AWREGION_SUPPORT ,$psprintf(" region=%h",awregion) `else ,"" `endif
			`ifdef NDS_AXI_AWQOS_SUPPORT 	,$psprintf(" qos=%h",awqos)    	 `else ,"" `endif
			`ifdef NDS_AXI_AWUSER_SUPPORT 	,$psprintf(" user=%h",awuser)   	 `else ,"" `endif
			, awlock ? " lock" : "");
		if (awcache[2] & !awcache[1]) begin $display("%0t:axi_mon:WARNING:M%0d awcache=0x%h, the RA bit must not be asserted if the C bit is deasserted.", $realtime, MASTER_ID, awcache); end
		if (awcache[3] & !awcache[1]) begin $display("%0t:axi_mon:WARNING:M%0d awcache=0x%h, the WA bit must not be asserted if the C bit is deasserted.", $realtime, MASTER_ID, awcache); end
	end
	if (wvalid & wready)
		if (dispmon_axi_mon_0) $display("%0t:axi_mon:M%0dS%0d wdata=%h strb=%h id=%h%0s%0s", $realtime, MASTER_ID, SLAVE_ID, wdata, wstrb, wid
		`ifdef NDS_AXI_WUSER_SUPPORT 	,$psprintf(" user=%h",wuser)   `else ,"" `endif
		, wlast ? " last" : "");
	if (bvalid & bready)
		if (dispmon_axi_mon_0) $display("%0t:axi_mon:M%0dS%0d bresp=%0s id=%h %0s for waddr=%h", $realtime, MASTER_ID, SLAVE_ID, resp_str(bresp), bid
		`ifdef NDS_AXI_BUSER_SUPPORT 	,$psprintf(" user=%h",buser)   `else ,"" `endif
		, bid_aw_fifo_rdata[ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH-1:AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH]);
end


if (AXI4)
	assign in_wid = {ID_WIDTH{1'b0}};
else
	assign in_wid = wid;

assign wdq_wr = wvalid && wready;
assign wdq_rd = ~awd_fifo_empty_all[current_wid] && ~wdq_empty;
assign wdq_wdata = {wlast, in_wid, wstrb, wdata
		    `ifdef NDS_AXI_WUSER_SUPPORT
		    ,wuser
		    `endif
		};
assign current_wlast = wdq_rdata[ID_WIDTH+DATA_BYTES+DATA_BITS];
generate
if (AXI4)
	assign current_wid = {ID_WIDTH{1'b0}};
else
	assign current_wid = wdq_rdata[ID_WIDTH+DATA_BYTES+DATA_BITS+WUSER_WIDTH-1:DATA_BYTES+DATA_BITS+WUSER_WIDTH];
endgenerate
assign current_wstrb = wdq_rdata[DATA_BYTES+DATA_BITS+WUSER_WIDTH-1:DATA_BITS+WUSER_WIDTH];
assign current_wdata = wdq_rdata[DATA_BITS+WUSER_WIDTH-1:WUSER_WIDTH];
`ifdef NDS_AXI_WUSER_SUPPORT
assign current_wuser = wdq_rdata[WUSER_WIDTH-1:0];
`endif


simple_fifo #(1 + ID_WIDTH + DATA_BYTES + DATA_BITS + WUSER_WIDTH, FIFO_PTR_WIDTH - 1) write_data_queue (
	.clk(aclk),
	.reset_n(aresetn),
	.wr_en(wdq_wr),
	.wdata(wdq_wdata),
	.rd_en(wdq_rd),
	.rdata(wdq_rdata),
	.fifo_empty(wdq_empty),
	.fifo_full(wdq_full)
);

always @(posedge aclk) begin
	if (aresetn && wdq_wr && wdq_full && ~wdq_rd) begin
		if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d Write DATA FIFO is full.", $realtime, MASTER_ID); #1 $finish; end
	end
end

assign current_awd_fifo_rdata = awd_fifo_rdata_per_id[current_wid];
assign current_wsize  =	current_awd_fifo_rdata[ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH+13+AXLEN_WIDTH:ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH+11+AXLEN_WIDTH];
assign current_wburst = current_awd_fifo_rdata[ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH+10+AXLEN_WIDTH:ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH+ 9+AXLEN_WIDTH];
assign current_wlock  =	current_awd_fifo_rdata[ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH+ 8+AXLEN_WIDTH:ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH+ 7+AXLEN_WIDTH];
assign current_wcache = current_awd_fifo_rdata[ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH+ 6+AXLEN_WIDTH:ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH+ 3+AXLEN_WIDTH];
assign current_wprot  = current_awd_fifo_rdata[ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH+ 2+AXLEN_WIDTH:ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH+   AXLEN_WIDTH];
assign current_wlen   =	current_awd_fifo_rdata[ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH- 1+AXLEN_WIDTH:ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH];
assign current_waddr  =	is_first_wctl[current_wid] ? current_awd_fifo_rdata[ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH-1:AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH] : next_waddr_per_id[current_wid];
`ifdef NDS_AXI_AWREGION_SUPPORT
assign current_wregion	= current_awd_fifo_rdata[AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH-1:AWQOS_WIDTH+AWUSER_WIDTH];
`endif
`ifdef NDS_AXI_AWQOS_SUPPORT
assign current_wqos	= current_awd_fifo_rdata[AWQOS_WIDTH+AWUSER_WIDTH-1:AWUSER_WIDTH];
`endif
`ifdef NDS_AXI_AWUSER_SUPPORT
assign current_awuser	= current_awd_fifo_rdata[AWUSER_WIDTH-1:0];
`endif

assign wbytes = 1 << current_wsize;
assign waddr_mask = (wbytes - {{(ADDR_WIDTH-1){1'b0}}, 1'b1});
assign waddr_incr[11:0] = (current_waddr & ~waddr_mask) + wbytes;
assign waddr_incr[ADDR_WIDTH-1:12] = current_waddr[ADDR_WIDTH-1:12];
assign wbyte_lane_one_hot_vector = (1 << (current_wsize + 3'd1));
assign wbyte_lane = wbyte_lane_one_hot_vector - {{(DATA_BYTES-1){1'b0}}, 1'b1};
assign current_write_byte = wbyte_lane <<  current_waddr[DATA_WIDTH-1:0];
assign hole_in_wstrb = ~&(current_wstrb | ~current_write_byte);


generate
	if (AXI4) begin : axi4_wlen_bits
		assign wlen_bits = current_wlen[7] ? 4'd8 :
				   current_wlen[6] ? 4'd7 :
				   current_wlen[5] ? 4'd6 :
				   current_wlen[4] ? 4'd5 :
				   current_wlen[3] ? 4'd4 :
				   current_wlen[2] ? 4'd3 :
				   current_wlen[1] ? 4'd2 :
			 	   current_wlen[0] ? 4'd1 : 4'd0;
	end
	else begin : axi3_wlen_bits
		assign wlen_bits = current_wlen[3] ? 3'd4 :
				   current_wlen[2] ? 3'd3 :
				   current_wlen[1] ? 3'd2 :
			 	   current_wlen[0] ? 3'd1 : 3'd0;
	end
endgenerate

generate
if (AXI4) begin : gen_wwrap_bytes_axi4
	assign wwrap_bytes = 1 << (wlen_bits + {{(AXI4){1'b0}},current_wsize});
end
else begin : gen_wwrap_bytes_non_axi4
	assign wwrap_bytes = 1 << (wlen_bits + current_wsize);
end
endgenerate

assign wwrap_mask = (wwrap_bytes - {{(ADDR_WIDTH-1){1'b0}}, 1'b1});

wire [AXLEN_WIDTH+ADDR_WIDTH-1:0]	arsize_bytes_x_arlen = arsize_bytes * arlen;

always @(negedge aresetn or posedge aclk) begin
	if (~aresetn)
		is_first_wctl <= {WAQ_NUM{1'b1}};
	else if (wdq_rd) begin
		is_first_wctl[current_wid] <= current_wlast;
	end
end

always @(posedge aclk) begin
	if (aresetn && wdq_rd) begin
		->write_trans;
		case (current_wburst)
		2'b00:
			next_waddr_per_id[current_wid] <= current_waddr;
		2'b01:
			next_waddr_per_id[current_wid] <= waddr_incr;
		2'b10:
			next_waddr_per_id[current_wid] <= (current_waddr & ~wwrap_mask) | (waddr_incr & wwrap_mask);
		default:
			;
		endcase
		if(HOLE_IN_STROBE & hole_in_wstrb) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d holes in WSTRB is not supported.", $realtime, MASTER_ID); #1 $finish; end
		end
	end
end

if (AXI4)
	assign in_bid = {ID_WIDTH{1'b0}};
else
	assign in_bid = bid;

assign bid_w_fifo_rdata  = w_fifo_rdata_per_id[in_bid];
always @(posedge aclk) begin
	if (aresetn && bvalid && bready) begin
		->bresp_trans;
	end
end

always @(posedge aclk) begin
	if (arvalid & arready) begin
		case (arburst)
		FIXED:
			if (FIX_BURST == 1) begin
				if ({{(32-AXLEN_WIDTH){1'b0}},arlen} >= 16) begin
					if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d Invalid arlen=%d for FIXED burst.", $realtime, MASTER_ID, arlen); #1 $finish; end
				end
			end
			else begin
				if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d arburst=FIXED is not supported.", $realtime, MASTER_ID); #1 $finish; end
			end
		INCR: begin
			araddr_n = {1'd0, araddr[11:0]} + arsize_bytes_x_arlen[12:0];
			if (araddr_n[12]) begin
				if (dispmon_axi_addr_mon_9) begin $display("%0t:axi_addr_mon:ERROR:M%0d INCR BURST accross 4K boundary, araddr=0x%h arlen=%d arsize=%d.", $realtime, MASTER_ID, araddr, arlen, arsize); #1 $finish; end
			end
		end
		WRAP:
			if (WRAP_BURST == 1) begin
				if (((AXI4 == 1) && (|arlen[AXLEN_WIDTH-1:AXLEN_WIDTH-4])) ||
				   ((arlen[3:0] !== 4'd1) && (arlen[3:0] !== 4'd3) && (arlen[3:0] !== 4'd7) && (arlen[3:0] !== 4'd15))) begin
					if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d Invalid arlen=%d for WRAP burst.", $realtime, MASTER_ID, arlen); #1 $finish; end
				end
			end
			else begin
				if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d arburst=WRAP is not supported.", $realtime, MASTER_ID); #1 $finish; end
			end
		2'b11: begin
				if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d arburst=2'b11 is reserved.", $realtime, MASTER_ID); #1 $finish; end
			end
		default:
			;
		endcase
		if (&{UNALIGNED_BURST,(araddr & (arsize_bytes - {{(ADDR_WIDTH-1){1'b0}}, 1'b1}))}) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d araddr=0x%h is not aligned to the burst size %0d.", $realtime, MASTER_ID, araddr, arsize_bytes); #1 $finish; end
		end
	end
end

always @(posedge aclk) begin
	if (arvalid & arready) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:M%0dS%0d read %h id=%h len=%h size=%h burst=%h cache=%h prot=%h %0s%0s%0s%0s", $realtime, MASTER_ID, SLAVE_ID, araddr, arid, arlen, arsize, arburst, arcache, arprot
			`ifdef NDS_AXI_ARREGION_SUPPORT ,$psprintf(" region=%h",arregion) `else ,"" `endif
			`ifdef NDS_AXI_ARQOS_SUPPORT 	,$psprintf(" qos=%h",arqos)    	  `else ,"" `endif
			`ifdef NDS_AXI_ARUSER_SUPPORT 	,$psprintf(" user=%h",aruser)     `else ,"" `endif
			, arlock ? " lock" : "");
			if (arcache[2] & !arcache[1]) begin $display("%0t:axi_mon:WARNING:M%0d arcache=0x%h, the RA bit must not be asserted if the C bit is deasserted.", $realtime, MASTER_ID, arcache); end
			if (arcache[3] & !arcache[1]) begin $display("%0t:axi_mon:WARNING:M%0d arcache=0x%h, the WA bit must not be asserted if the C bit is deasserted.", $realtime, MASTER_ID, arcache); end
	end
	if (rvalid & rready)
		if (dispmon_axi_mon_0) $display("%0t:axi_mon:M%0dS%0d rresp=%0s id=%h rdata=%h %0s for raddr=%h%0s", $realtime, MASTER_ID, SLAVE_ID, resp_str(rresp), rid, rdata
		`ifdef NDS_AXI_RUSER_SUPPORT 	,$psprintf(" user=%h",ruser)   `else ,"" `endif
		, current_raddr, rlast ? " last" : "");
end

assign current_ar_fifo_rdata = ar_fifo_rdata_per_id[rid];
assign current_rsize  =	current_ar_fifo_rdata[ADDR_WIDTH+ARREGION_WIDTH+ARQOS_WIDTH+ARUSER_WIDTH+13+AXLEN_WIDTH:ADDR_WIDTH+ARREGION_WIDTH+ARQOS_WIDTH+ARUSER_WIDTH+11+AXLEN_WIDTH];
assign current_rburst = current_ar_fifo_rdata[ADDR_WIDTH+ARREGION_WIDTH+ARQOS_WIDTH+ARUSER_WIDTH+10+AXLEN_WIDTH:ADDR_WIDTH+ARREGION_WIDTH+ARQOS_WIDTH+ARUSER_WIDTH+ 9+AXLEN_WIDTH];
assign current_rlock  =	current_ar_fifo_rdata[ADDR_WIDTH+ARREGION_WIDTH+ARQOS_WIDTH+ARUSER_WIDTH+ 8+AXLEN_WIDTH:ADDR_WIDTH+ARREGION_WIDTH+ARQOS_WIDTH+ARUSER_WIDTH+ 7+AXLEN_WIDTH];
assign current_rcache = current_ar_fifo_rdata[ADDR_WIDTH+ARREGION_WIDTH+ARQOS_WIDTH+ARUSER_WIDTH+ 6+AXLEN_WIDTH:ADDR_WIDTH+ARREGION_WIDTH+ARQOS_WIDTH+ARUSER_WIDTH+ 3+AXLEN_WIDTH];
assign current_rlen   =	current_ar_fifo_rdata[ADDR_WIDTH+ARREGION_WIDTH+ARQOS_WIDTH+ARUSER_WIDTH- 1+AXLEN_WIDTH:ADDR_WIDTH+ARREGION_WIDTH+ARQOS_WIDTH+ARUSER_WIDTH];
assign current_raddr  =	is_first_rctl[rid] ? current_ar_fifo_rdata[ADDR_WIDTH+ARREGION_WIDTH+ARQOS_WIDTH+ARUSER_WIDTH-1:ARREGION_WIDTH+ARQOS_WIDTH+ARUSER_WIDTH] : next_raddr_per_id[rid];
`ifdef NDS_AXI_ARREGION_SUPPORT
assign current_rregion	= current_ar_fifo_rdata[ARREGION_WIDTH+ARQOS_WIDTH+ARUSER_WIDTH-1:ARQOS_WIDTH+ARUSER_WIDTH];
`endif
`ifdef NDS_AXI_ARQOS_SUPPORT
assign current_rqos	= current_ar_fifo_rdata[ARQOS_WIDTH+ARUSER_WIDTH-1:ARUSER_WIDTH];
`endif
`ifdef NDS_AXI_ARUSER_SUPPORT
assign current_aruser	= current_ar_fifo_rdata[ARUSER_WIDTH-1:0];
`endif

assign rbytes = 1 << current_rsize;
assign raddr_mask = (rbytes - {{(ADDR_WIDTH-1){1'b0}}, 1'b1});
assign raddr_incr[11:0] = (current_raddr & ~raddr_mask) + rbytes;
assign raddr_incr[ADDR_WIDTH-1:12] = current_raddr[ADDR_WIDTH-1:12];

generate
	if (AXI4) begin : axi4_rlen_bits
		assign rlen_bits = current_rlen[7] ? 4'd8 :
				   current_rlen[6] ? 4'd7 :
				   current_rlen[5] ? 4'd6 :
				   current_rlen[4] ? 4'd5 :
				   current_rlen[3] ? 4'd4 :
				   current_rlen[2] ? 4'd3 :
				   current_rlen[1] ? 4'd2 :
			 	   current_rlen[0] ? 4'd1 : 4'd0;
	end
	else begin : axi3_rlen_bits
		assign rlen_bits = current_rlen[3] ? 3'd4 :
				   current_rlen[2] ? 3'd3 :
				   current_rlen[1] ? 3'd2 :
			 	   current_rlen[0] ? 3'd1 : 3'd0;
	end
endgenerate

generate
if (AXI4) begin : gen_rwrap_bytes_axi4
	assign rwrap_bytes = 1 << (rlen_bits + {{(AXI4){1'b0}},current_rsize});
end
else begin : gen_rwrap_bytes_non_axi4
	assign rwrap_bytes = 1 << (rlen_bits + current_rsize);
end
endgenerate

assign rwrap_mask = (rwrap_bytes - {{(ADDR_WIDTH-1){1'b0}}, 1'b1});

always @(negedge aresetn or posedge aclk) begin
	if (~aresetn)
		is_first_rctl <= {ID_NUM{1'b1}};
	else if (rvalid && rready) begin
		is_first_rctl[rid] <= rlast;
	end
end

always @(posedge aclk) begin
	if (aresetn && rvalid && rready) begin
		->read_trans;
		case (current_rburst)
		2'b00:
			next_raddr_per_id[rid] <= current_raddr;
		2'b01:
			next_raddr_per_id[rid] <= raddr_incr;
		2'b10:
			next_raddr_per_id[rid] <= (current_raddr & ~rwrap_mask) | (raddr_incr & rwrap_mask);
		default:
			;
		endcase
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		wait_count_ar <= 0;
		wait_count_r <= 0;
		wait_count_aw <= 0;
		wait_count_w <= 0;
	end
	else begin
		if (arvalid) begin
			if (arready)
				wait_count_ar <= 0;
			else
				wait_count_ar <= wait_count_ar + 1;
		end

		if (rvalid) begin
			if (rready)
				wait_count_r <= 0;
			else
				wait_count_r <= wait_count_r + 1;
		end

		if (awvalid) begin
			if (awready)
				wait_count_aw <= 0;
			else
				wait_count_aw <= wait_count_aw + 1;
		end

		if (wvalid) begin
			if (wready)
				wait_count_w <= 0;
			else
				wait_count_w <= wait_count_w + 1;
		end
	end
end


always @(posedge aclk) begin
	if (wait_count_ar == WAIT_ARREADY) begin
		if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d arready is not asserted within %0d cycles.", $realtime, MASTER_ID, WAIT_ARREADY);
	end

	if (wait_count_r == WAIT_RREADY) begin
		if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d rready is not asserted within %0d cycles.", $realtime, MASTER_ID, WAIT_RREADY);
	end

	if (wait_count_aw == WAIT_AWREADY) begin
		if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d awready is not asserted within %0d cycles.", $realtime, MASTER_ID, WAIT_AWREADY);
	end

	if (wait_count_w == WAIT_WREADY) begin
		if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d wready is not asserted within %0d cycles.", $realtime, MASTER_ID, WAIT_WREADY);
	end
end

always @(posedge aclk) begin
	if (awvalid && awready) begin
		if ((^awaddr)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d awaddr contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
		if ((^awid)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d awid contains unknown.", $realtime, MASTER_ID);
		end
		if ((^awlen)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d awlen contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
		if ((^awsize)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d awsize contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
		if ((^awburst)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d awburst contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
		if ((^awlock)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d awlock contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
		if ((^awcache)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d awcache contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
		if ((^awprot)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d awprot contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
`ifdef NDS_AXI_AWREGION_SUPPORT
		if ((^awregion)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d awregion contains unknown.", $realtime, MASTER_ID);
		end
`endif
`ifdef NDS_AXI_AWQOS_SUPPORT
		if ((^awqos)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d awqos contains unknown.", $realtime, MASTER_ID);
		end
`endif
`ifdef NDS_AXI_AWUSER_SUPPORT
		if ((^awuser)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d awuser contains unknown.", $realtime, MASTER_ID);
		end
`endif
	end

	if (wvalid & wready) begin
		if ((^in_wid)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d in_wid contains unknown.", $realtime, MASTER_ID);
		end
		if ((^wdata)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d wdata contains unknown.", $realtime, MASTER_ID);
		end
		if ((^wstrb)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d wstrb contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
`ifdef NDS_AXI_WUSER_SUPPORT
		if ((^wuser)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d wuser contains unknown.", $realtime, MASTER_ID);
		end
`endif
	end

	if (bvalid & bready) begin
		if ((^bid)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d bid contains unknown.", $realtime, MASTER_ID);
		end
`ifdef NDS_AXI_BUSER_SUPPORT
		if ((^buser)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d buser contains unknown.", $realtime, MASTER_ID);
		end
`endif
`ifdef NDS_AXI_RESP_MON
		if ((^bresp)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d bresp contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
`else
		if ((^bresp)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:ERROR: M%0d bresp contains unknown.", $realtime, MASTER_ID);
		end
`endif
	end
end

always @(posedge aclk) begin
	if (arvalid && arready) begin
		if ((^araddr)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d araddr contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
		if ((^arid)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING: M%0d arid contains unknown.", $realtime, MASTER_ID);
		end
		if ((^arlen)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d arlen contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
		if ((^arsize)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d arsize contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
		if ((^arburst)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d arburst contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
		if ((^arlock)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d arlock contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
		if ((^arcache)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d arcache contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
		if ((^arprot)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d arprot contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
`ifdef NDS_AXI_ARREGION_SUPPORT
		if ((^arregion)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d arregion contains unknown.", $realtime, MASTER_ID);
		end
`endif
`ifdef NDS_AXI_ARQOS_SUPPORT
		if ((^arqos)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d arqos contains unknown.", $realtime, MASTER_ID);
		end
`endif
`ifdef NDS_AXI_ARUSER_SUPPORT
		if ((^aruser)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d aruser contains unknown.", $realtime, MASTER_ID);
		end
`endif
	end

	if (rvalid & rready) begin
		if ((^rid)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING: M%0d rid contains unknown.", $realtime, MASTER_ID);
		end
`ifdef NDS_AXI_RUSER_SUPPORT
		if ((^ruser)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d ruser contains unknown.", $realtime, MASTER_ID);
		end
`endif
`ifdef NDS_AXI_READ_UNKNOWN_MON_OFF
`else
		if ((^rdata)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING: M%0d rdata contains unknown.", $realtime, MASTER_ID);
		end
`endif
`ifdef NDS_AXI_RESP_MON
		if ((^rresp)===1'bx) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d rresp contains unknown.", $realtime, MASTER_ID); #1 $finish; end
		end
`else
		if ((^rresp)===1'bx) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING: M%0d rresp contains unknown.", $realtime, MASTER_ID);
		end
`endif
	end
end


genvar gen_i;

generate
for (gen_i = 0; gen_i < WAQ_NUM; gen_i = gen_i + 1) begin :idw
	wire					awd_fifo_wr_en;
	wire					awd_fifo_rd_en;
	wire					awd_fifo_full;
	wire					awd_fifo_empty;
	wire [14+AXLEN_WIDTH+ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH-1:0]	awd_fifo_wdata;
	wire [14+AXLEN_WIDTH+ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH-1:0]	awd_fifo_rdata;

	if (AXI4)
		assign awd_fifo_wr_en = awvalid & awready;
	else
		assign awd_fifo_wr_en = awvalid & awready & (awid == gen_i[ID_WIDTH-1:0]);
	assign awd_fifo_rd_en = ~awd_fifo_empty && ~wdq_empty && current_wlast && (current_wid == gen_i[ID_WIDTH-1:0]);
	assign awd_fifo_wdata = {awsize, awburst, awlock, awcache, awprot, awlen, awaddr
				`ifdef NDS_AXI_AWREGION_SUPPORT
				,awregion
				`endif
				`ifdef NDS_AXI_AWQOS_SUPPORT
				,awqos
				`endif
				`ifdef NDS_AXI_AWUSER_SUPPORT
				,awuser
				`endif
	};
	assign awd_fifo_rdata_per_id[gen_i] = awd_fifo_rdata;
	assign awd_fifo_empty_all[gen_i] = awd_fifo_empty;



	simple_fifo #(WRCMD_ADDR_WIDTH, FIFO_PTR_WIDTH - 1) awd_fifo (
		.clk(aclk),
		.reset_n(aresetn),
		.wr_en(awd_fifo_wr_en),
		.wdata(awd_fifo_wdata),
		.rd_en(awd_fifo_rd_en),
		.rdata(awd_fifo_rdata),
		.fifo_empty(awd_fifo_empty),
		.fifo_full(awd_fifo_full)
	);

	always @(posedge aclk) begin
		if (aresetn && awd_fifo_wr_en && awd_fifo_full && ~awd_fifo_rd_en) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d Write Address DATA FIFO for awid=%0d is full.", $realtime, MASTER_ID, awid); #1 $finish; end
		end
	end

	wire					aw_fifo_wr_en;
	wire [WRCMD_ADDR_WIDTH-1:0]		aw_fifo_wdata;
	wire [WRCMD_ADDR_WIDTH-1:0]		aw_fifo_rdata;
	wire					aw_fifo_full;
	wire					aw_fifo_empty;
	reg  [31:0]				aw_wait_cnt;

	reg  [31:0]				wdata_cnt;
	wire					w_fifo_wr_en;
	wire [32+DATA_BYTES+DATA_BITS+WUSER_WIDTH-1:0]	w_fifo_wdata;
	wire [32+DATA_BYTES+DATA_BITS+WUSER_WIDTH-1:0]	w_fifo_rdata;
	wire					w_fifo_full;
	wire					w_fifo_empty;

	wire					wtxn_end;

	if (AXI4)
		assign aw_fifo_wr_en = awvalid & awready;
	else
		assign aw_fifo_wr_en = awvalid & awready & (awid == gen_i[ID_WIDTH-1:0]);
	assign aw_fifo_wdata = {awsize, awburst, awlock, awcache, awprot, awlen, awaddr
				`ifdef NDS_AXI_AWREGION_SUPPORT
				,awregion
				`endif
				`ifdef NDS_AXI_AWQOS_SUPPORT
				,awqos
				`endif
				`ifdef NDS_AXI_AWUSER_SUPPORT
				,awuser
				`endif
	};
	assign aw_fifo_rdata_per_id[gen_i] = aw_fifo_rdata;



	simple_fifo #(WRCMD_ADDR_WIDTH, FIFO_PTR_WIDTH - 1) aw_fifo (
		.clk(aclk),
		.reset_n(aresetn),
		.wr_en(aw_fifo_wr_en),
		.wdata(aw_fifo_wdata),
		.rd_en(wtxn_end),
		.rdata(aw_fifo_rdata),
		.fifo_empty(aw_fifo_empty),
		.fifo_full(aw_fifo_full)
	);

	always @(posedge aclk) begin
		if (aresetn && aw_fifo_wr_en && aw_fifo_full && ~wtxn_end) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d Write Address FIFO for awid=%0d is full.", $realtime, MASTER_ID, awid); #1 $finish; end
		end
	end

	always @(posedge aclk or negedge aresetn) begin
		if (~aresetn)
			wdata_cnt <= 32'h0;
		else if (wvalid && wready && (in_wid == gen_i[ID_WIDTH-1:0])) begin
			if (wlast)
				wdata_cnt <= 32'h0;
			else
				wdata_cnt <= wdata_cnt + 32'h1;
		end
	end

	assign w_fifo_wr_en = wvalid & wready & (in_wid == gen_i[ID_WIDTH-1:0]) & wlast;
	assign w_fifo_wdata = {wstrb, wdata, wdata_cnt
			      `ifdef NDS_AXI_WUSER_SUPPORT
			      ,wuser
			      `endif
		};
	assign w_fifo_rdata_per_id[gen_i] = w_fifo_rdata;

	simple_fifo #(32 + DATA_BYTES + DATA_BITS + WUSER_WIDTH, FIFO_PTR_WIDTH - 1) w_fifo (
		.clk(aclk),
		.reset_n(aresetn),
		.wr_en(w_fifo_wr_en),
		.wdata(w_fifo_wdata),
		.rd_en(wtxn_end),
		.rdata(w_fifo_rdata),
		.fifo_empty(w_fifo_empty),
		.fifo_full(w_fifo_full)
	);

	always @(posedge aclk) begin
		if (aresetn && w_fifo_wr_en && w_fifo_full && ~wtxn_end) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d Write Data FIFO for in_wid=%0d is full.", $realtime, MASTER_ID, in_wid); #1 $finish; end
		end
	end

	if (AXI4)
		assign wtxn_end = bvalid & bready;
	else
		assign wtxn_end = bvalid & bready & (bid == gen_i[ID_WIDTH-1:0]);

	always @(posedge aclk) begin
		if (aresetn && wtxn_end) begin
			if (aw_fifo_empty || w_fifo_empty) begin
				if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d Write Address/Data must be ready before Write Response with bid=%0d.", $realtime, MASTER_ID, bid); #1 $finish; end
			end
			else if ({{(32-AXLEN_WIDTH){1'h0}}, aw_fifo_rdata[ADDR_WIDTH-1+AXLEN_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH:ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH]} !== w_fifo_rdata[WUSER_WIDTH+31:WUSER_WIDTH]) begin
				if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d awaddr=0x%h awid=%0d: transfer number %0d expected but %0d observed.", $realtime, MASTER_ID, aw_fifo_rdata[ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH-1:AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH], gen_i, aw_fifo_rdata[ADDR_WIDTH-1+AXLEN_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH:ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH] + {{(AXLEN_WIDTH-1){1'h0}},1'b1}, w_fifo_rdata[WUSER_WIDTH+31:WUSER_WIDTH] + 1); #1 $finish; end
			end
		end
	end

	always @(posedge aclk or negedge aresetn) begin
		if (~aresetn)
			aw_wait_cnt <= 0;
		else if (wtxn_end)
			aw_wait_cnt <= 0;
		else if (~aw_fifo_empty)
			aw_wait_cnt <= aw_wait_cnt + 1;
	end

	always @(posedge aclk) begin
		if (aresetn && (aw_wait_cnt == WLATENCY_MAX)) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d write addr=0x%h awid=%0d does not end in %0d cycles.", $realtime, MASTER_ID, aw_fifo_rdata[ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH-1:AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH], gen_i, WLATENCY_MAX);
			if (w_fifo_empty) begin
				if (dispmon_axi_mon_0) $display("%0t:axi_mon:expected %0d beats got %0d beats.", $realtime, aw_fifo_rdata[ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH-1+AXLEN_WIDTH:ADDR_WIDTH+AWREGION_WIDTH+AWQOS_WIDTH+AWUSER_WIDTH] + {{(AXLEN_WIDTH-1){1'h0}},1'b1}, wdata_cnt);
			end
		end
	end
end
endgenerate


genvar gen_i2;

generate
for (gen_i2 = 0; gen_i2 < ID_NUM; gen_i2 = gen_i2 + 1) begin :idr
	wire				ar_fifo_wr_en;
	wire [RDCMD_ADDR_WIDTH-1:0]	ar_fifo_wdata;
	wire [RDCMD_ADDR_WIDTH-1:0]	ar_fifo_rdata;
	wire				ar_fifo_full;
	wire				ar_fifo_empty;
	reg [31:0]			ar_wait_cnt;

	reg [31:0]			rdata_cnt;
	wire				rtxn_end;

	assign ar_fifo_wr_en = arvalid & arready & (arid == gen_i2[ID_WIDTH-1:0]);
	assign ar_fifo_wdata = {arsize, arburst, arlock, arcache, arprot, arlen, araddr
		    		`ifdef NDS_AXI_ARREGION_SUPPORT
		    		,arregion
		    		`endif
		    		`ifdef NDS_AXI_ARQOS_SUPPORT
		    		,arqos
		    		`endif
		    		`ifdef NDS_AXI_ARUSER_SUPPORT
		    		,aruser
		    		`endif
	};
	assign ar_fifo_rdata_per_id[gen_i2] = ar_fifo_rdata;



	simple_fifo #(RDCMD_ADDR_WIDTH, FIFO_PTR_WIDTH - 1) ar_fifo (
		.clk(aclk),
		.reset_n(aresetn),
		.wr_en(ar_fifo_wr_en),
		.wdata(ar_fifo_wdata),
		.rd_en(rtxn_end),
		.rdata(ar_fifo_rdata),
		.fifo_empty(ar_fifo_empty),
		.fifo_full(ar_fifo_full)
	);

	always @(posedge aclk) begin
		if (aresetn && ar_fifo_wr_en && ar_fifo_full && ~rtxn_end) begin
			if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d Read Address FIFO for arid=%0d is full.", $realtime, MASTER_ID, arid); #1 $finish; end
		end
	end

	always @(posedge aclk or negedge aresetn) begin
		if (~aresetn)
			rdata_cnt <= 32'h0;
		else if (rvalid && rready && (rid == gen_i2[ID_WIDTH-1:0])) begin
			if (rlast) begin
				if ({{(32-AXLEN_WIDTH){1'h0}}, ar_fifo_rdata[ADDR_WIDTH-1+AXLEN_WIDTH+ARQOS_WIDTH+ARREGION_WIDTH+ARUSER_WIDTH:ADDR_WIDTH+ARQOS_WIDTH+ARREGION_WIDTH+ARUSER_WIDTH]} !== rdata_cnt) begin
					if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d araddr=0x%h and arid=%0d, transfer number %0d expected but %0d observed.", $realtime, MASTER_ID, ar_fifo_rdata[ADDR_WIDTH+ARQOS_WIDTH+ARREGION_WIDTH+ARUSER_WIDTH-1:+ARQOS_WIDTH+ARREGION_WIDTH+ARUSER_WIDTH], rid, ar_fifo_rdata[ADDR_WIDTH+ARQOS_WIDTH+ARREGION_WIDTH+ARUSER_WIDTH-1+AXLEN_WIDTH:ADDR_WIDTH+ARQOS_WIDTH+ARREGION_WIDTH+ARUSER_WIDTH] + {{(AXLEN_WIDTH-1){1'h0}},1'b1}, rdata_cnt + 32'h1); #1 $finish; end
				end

				rdata_cnt <= 32'h0;
			end
			else
				rdata_cnt <= rdata_cnt + 32'h1;
		end
	end

	assign rtxn_end = rvalid & rready & (rid == gen_i2[ID_WIDTH-1:0]) & rlast;

	always @(posedge aclk) begin
		if (aresetn && rvalid && (rid == gen_i2[ID_WIDTH-1:0])) begin
			if (ar_fifo_empty) begin
				if (dispmon_axi_mon_9) begin $display("%0t:axi_mon:ERROR:M%0d arvalid/arready must be asserted before rvalid being asserted with rid=%0d.", $realtime, MASTER_ID, rid); #1 $finish; end
			end
		end
	end

	always @(posedge aclk or negedge aresetn) begin
		if (~aresetn)
			ar_wait_cnt <= 0;
		else if (rtxn_end)
			ar_wait_cnt <= 0;
		else if (~ar_fifo_empty)
			ar_wait_cnt <= ar_wait_cnt + 1;
	end

	always @(posedge aclk) begin
		if (aresetn && (ar_wait_cnt == RLATENCY_MAX)) begin
			if (dispmon_axi_mon_0) $display("%0t:axi_mon:WARNING:M%0d read addr=0x%h arid=%0d does not end in %0d cycles; expected %0d beats got %0d beats.", $realtime, MASTER_ID, ar_fifo_rdata[ADDR_WIDTH+ARQOS_WIDTH+ARREGION_WIDTH+ARUSER_WIDTH-1:+ARQOS_WIDTH+ARREGION_WIDTH+ARUSER_WIDTH], gen_i2, RLATENCY_MAX, ar_fifo_rdata[ADDR_WIDTH+ARQOS_WIDTH+ARREGION_WIDTH+ARUSER_WIDTH+3:ADDR_WIDTH+ARQOS_WIDTH+ARREGION_WIDTH+ARUSER_WIDTH] + 4'h1, rdata_cnt);
		end
	end

end
endgenerate


`ifdef NDS_AXI_PERFORM
assign w_start = awvalid && awready;
assign w_valid = wvalid && wready;

assign r_start = arvalid && arready;
assign r_valid = rvalid && rready;

bus_mon axi_perf_mon(
	.wstart(w_start),
	.wvalid(w_valid),
	.wlast(wlast),
        .rstart(r_start),
        .rvalid(r_valid),
        .rlast(rlast),
        .mon_en(1'b1),
        .resetn(aresetn),
        .clk(aclk)
);
`endif


endmodule















// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


`timescale 1ns/1ns


module simple_fifo (
	  clk,
	  reset_n,
	  wr_en,
	  wdata,
	  rd_en,
	  rdata,
	  fifo_empty,
	  fifo_full
);

parameter DATA_WIDTH = 32;
parameter DEPTH_BITS = 3;

input			clk;
input			reset_n;
input			wr_en;
input [DATA_WIDTH-1:0]	wdata;
input			rd_en;
output [DATA_WIDTH-1:0]	rdata;
output			fifo_empty;
output			fifo_full;

reg [DATA_WIDTH-1:0]	mem[0:(1 << DEPTH_BITS) - 1];

reg	[DEPTH_BITS:0]		wr_ptr;
reg	[DEPTH_BITS:0]		rd_ptr;

wire	[DEPTH_BITS:0]		wr_ptr_next = wr_ptr + {{DEPTH_BITS{1'b0}}, 1'b1};
wire	[DEPTH_BITS:0]		rd_ptr_next = rd_ptr + {{DEPTH_BITS{1'b0}}, 1'b1};

always @(negedge reset_n or posedge clk)
    if (~reset_n) begin
	wr_ptr <= {(DEPTH_BITS+1){1'b0}};
    end
    else if (wr_en && (~fifo_full || rd_en)) begin
	mem[wr_ptr[DEPTH_BITS-1:0]] <= wdata;
	wr_ptr <= wr_ptr_next;
    end

always @(negedge reset_n or posedge clk)
	if (~reset_n) begin
	rd_ptr <= {(DEPTH_BITS+1){1'b0}};
    end
    else if (rd_en && ~fifo_empty) begin
	rd_ptr <= rd_ptr_next;
    end

assign rdata = mem[rd_ptr[DEPTH_BITS-1:0]];

assign fifo_empty = (rd_ptr == wr_ptr);
assign fifo_full = (wr_ptr[DEPTH_BITS-1:0] == rd_ptr[DEPTH_BITS-1:0]) &
		   (wr_ptr[DEPTH_BITS] != rd_ptr[DEPTH_BITS]);


endmodule

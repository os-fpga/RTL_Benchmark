// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atciic100_config.vh"
`include "atciic100_const.vh"

module atciic100_fifo(
		  clk,
		  reset_n,
		  wr_apb,
		  wr_cntlr,
		  rd_apb,
		  rd_cntlr,
		  clr_apb,
		  clr_cntlr,
		  wr_data_apb,
		  wr_data_cntlr,
		  full,
		  empty,
		  half_full,
		  half_empty,
		  entries,
		  rd_data
);
localparam SYNC_FIFO_DEPTH = 1 << (`ATCIIC100_INDEX_WIDTH - 1);
input	clk;
input	reset_n;
input	wr_apb;
input	wr_cntlr;
input	rd_apb;
input	rd_cntlr;
input	clr_apb;
input	clr_cntlr;
input	[`ATCIIC100_DATA_WIDTH-1:0]		wr_data_apb;
input	[`ATCIIC100_DATA_WIDTH-1:0]		wr_data_cntlr;

output	full;
output	empty;
output	half_full;
output	half_empty;
output	[`ATCIIC100_INDEX_WIDTH-1:0]	entries;
output	[`ATCIIC100_DATA_WIDTH-1:0]		rd_data;

wire	wr;
wire	rd;
wire	fifo_clr;
wire	half_full;
wire	half_empty;
wire	[`ATCIIC100_DATA_WIDTH-1:0] 	wr_data;
wire	[`ATCIIC100_INDEX_WIDTH-1:0]	entries;
wire	[`ATCIIC100_INDEX_WIDTH-1:0]	wr_ptr;
wire	[`ATCIIC100_INDEX_WIDTH-1:0]	rd_ptr;

localparam [`ATCIIC100_INDEX_WIDTH-1:0]	HALF_NUM = {2'b01, {(`ATCIIC100_INDEX_WIDTH - 2){1'b0}}};


assign	wr			= wr_apb | wr_cntlr;
assign	wr_data		= wr_cntlr ? wr_data_cntlr : wr_data_apb;
assign	rd			= rd_apb | rd_cntlr;
assign	fifo_clr	= clr_apb | clr_cntlr;

assign	entries		= wr_ptr - rd_ptr;
assign	half_full	= entries >= HALF_NUM;
assign	half_empty	= entries <= HALF_NUM;

nds_sync_fifo_clr #(
        .DATA_WIDTH (`ATCIIC100_DATA_WIDTH),
        .FIFO_DEPTH (SYNC_FIFO_DEPTH),
        .POINTER_INDEX_WIDTH (`ATCIIC100_INDEX_WIDTH)
) u_nds_sync_fifo (
	.reset_n	(reset_n),
	.clk		(clk),
	.wr			(wr),
	.wr_data	(wr_data),
	.rd			(rd),
	.rd_data	(rd_data),
	.empty		(empty),
	.full		(full),
	.wr_ptr		(wr_ptr),
	.rd_ptr		(rd_ptr),
	.fifo_clr	(fifo_clr)
);

endmodule

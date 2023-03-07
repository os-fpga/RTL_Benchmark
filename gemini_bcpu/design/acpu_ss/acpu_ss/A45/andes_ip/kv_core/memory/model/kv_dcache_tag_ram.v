// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcache_tag_ram(
		  clk,
		  dcache_tag_cs,
		  dcache_tag_we,
		  dcache_tag_addr,
		  dcache_tag_wdata,
		  dcache_tag_rdata,
		  dcache_tag_ctrl_in,
		  dcache_tag_ctrl_out
);

parameter DCACHE_TAG_RAM_DW  = 19;
parameter DCACHE_TAG_RAM_AW  = 9;
parameter DCACHE_TAG_RAM_CTRL_IN_WIDTH = 1;
parameter DCACHE_TAG_RAM_CTRL_OUT_WIDTH = 1;

localparam OUT_DELAY = 0.1;

input                                         clk;
input                                         dcache_tag_cs;
input                                         dcache_tag_we;
input               [(DCACHE_TAG_RAM_AW-1):0] dcache_tag_addr;
input               [(DCACHE_TAG_RAM_DW-1):0] dcache_tag_wdata;
output              [(DCACHE_TAG_RAM_DW-1):0] dcache_tag_rdata;
input    [(DCACHE_TAG_RAM_CTRL_IN_WIDTH-1):0] dcache_tag_ctrl_in;
output  [(DCACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] dcache_tag_ctrl_out;

nds_ram_model #(
	.ADDR_WIDTH (DCACHE_TAG_RAM_AW),
	.WRITE_WIDTH(DCACHE_TAG_RAM_DW),
	.OUT_DELAY  (OUT_DELAY)
) ram_inst (
	.clk  (clk),
	.cs   (dcache_tag_cs),
	.we   (dcache_tag_we),
	.addr (dcache_tag_addr),
	.din  (dcache_tag_wdata),
	.dout (dcache_tag_rdata)
);

wire	nds_unused_dcache_ctrl_in = |dcache_tag_ctrl_in;
assign dcache_tag_ctrl_out = {DCACHE_TAG_RAM_CTRL_OUT_WIDTH{1'b0}};




endmodule


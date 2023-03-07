// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_icache_tag_ram(
		  clk,
		  icache_tag_cs,
		  icache_tag_addr,
		  icache_tag_rdata,
		  icache_tag_wdata,
		  icache_tag_we,
		  icache_tag_ctrl_in,
		  icache_tag_ctrl_out
);

parameter ICACHE_TAG_RAM_DW  = 19;
parameter ICACHE_TAG_RAM_AW  = 9;
parameter ICACHE_TAG_RAM_CTRL_IN_WIDTH = 1;
parameter ICACHE_TAG_RAM_CTRL_OUT_WIDTH = 1;

input                                        clk;

input                                        icache_tag_cs;
input              [(ICACHE_TAG_RAM_AW-1):0] icache_tag_addr;
output             [(ICACHE_TAG_RAM_DW-1):0] icache_tag_rdata;
input              [(ICACHE_TAG_RAM_DW-1):0] icache_tag_wdata;
input                                        icache_tag_we;
input   [(ICACHE_TAG_RAM_CTRL_IN_WIDTH-1):0] icache_tag_ctrl_in;
output [(ICACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] icache_tag_ctrl_out;

nds_ram_model #(
	.ADDR_WIDTH (ICACHE_TAG_RAM_AW),
	.WRITE_WIDTH (ICACHE_TAG_RAM_DW)
) ram_inst (
	.clk  (clk),
	.cs   (icache_tag_cs),
	.we   (icache_tag_we),
	.addr (icache_tag_addr),
	.din  (icache_tag_wdata),
	.dout (icache_tag_rdata)
);

wire nds_unused_icache_data_ctrl_in = |icache_tag_ctrl_in;
assign icache_tag_ctrl_out = {ICACHE_TAG_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule


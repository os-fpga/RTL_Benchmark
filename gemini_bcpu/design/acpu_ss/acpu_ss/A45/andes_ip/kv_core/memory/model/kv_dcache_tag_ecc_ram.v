// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcache_tag_ecc_ram(
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

input                                       clk;
input                                       dcache_tag_cs;
input                                       dcache_tag_we;
input             [(DCACHE_TAG_RAM_AW-1):0] dcache_tag_addr;
input             [(DCACHE_TAG_RAM_DW-1):0] dcache_tag_wdata;
output            [(DCACHE_TAG_RAM_DW-1):0] dcache_tag_rdata;
input  [(DCACHE_TAG_RAM_CTRL_IN_WIDTH-1):0] dcache_tag_ctrl_in;
output[(DCACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] dcache_tag_ctrl_out;

wire                                    ram_cs     = dcache_tag_cs;
wire          [(DCACHE_TAG_RAM_AW-1):0] ram_addr   = dcache_tag_addr;
wire                                    ram_we     = dcache_tag_we;
wire          [(DCACHE_TAG_RAM_DW-1):0] ram_wdata  = dcache_tag_wdata;
wire          [(DCACHE_TAG_RAM_DW-1):0] ram_rdata;

nds_ram_model #(
	.ADDR_WIDTH (DCACHE_TAG_RAM_AW),
	.WRITE_WIDTH(DCACHE_TAG_RAM_DW),
	.OUT_DELAY  (OUT_DELAY)
) ram_inst (
	.clk  (clk),
	.cs   (ram_cs),
	.we   (ram_we),
	.addr (ram_addr),
	.din  (ram_wdata),
	.dout (ram_rdata)
);

`ifdef TEST_MEM_MACRO

assign dcache_tag_rdata = ram_rdata;


// synthesis translate_off







// synthesis translate_on

`else

assign dcache_tag_rdata = ram_rdata;

`endif

wire	nds_unused_dcache_ctrl_in = |dcache_tag_ctrl_in;
assign dcache_tag_ctrl_out = {DCACHE_TAG_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule


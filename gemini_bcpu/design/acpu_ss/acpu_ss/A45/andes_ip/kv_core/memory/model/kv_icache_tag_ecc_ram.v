// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_icache_tag_ecc_ram(
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

localparam OUT_DELAY = 0.1;
localparam ICACHE_TAG_ECC_DW	= (ICACHE_TAG_RAM_DW-7 > 32) ? 8 : 7;
localparam NO_ECC_TAG_DW	= ICACHE_TAG_RAM_DW - ICACHE_TAG_ECC_DW;
localparam ICACHE_LOCK_BIT	= NO_ECC_TAG_DW-2;
localparam ICACHE_LOCK_DUP_BIT	= NO_ECC_TAG_DW-3;
localparam ICACHE_LOCK_DUP_D1	= NO_ECC_TAG_DW-4;

input              			clk;

input                                        icache_tag_cs;
input              [(ICACHE_TAG_RAM_AW-1):0] icache_tag_addr;
output	           [(ICACHE_TAG_RAM_DW-1):0] icache_tag_rdata;
input              [(ICACHE_TAG_RAM_DW-1):0] icache_tag_wdata;
input                                        icache_tag_we;
input   [(ICACHE_TAG_RAM_CTRL_IN_WIDTH-1):0] icache_tag_ctrl_in;
output [(ICACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] icache_tag_ctrl_out;

wire                                    ram_cs     = icache_tag_cs;
wire    [(ICACHE_TAG_RAM_AW-1):0]       ram_addr   = icache_tag_addr;
wire                                    ram_we     = icache_tag_we;
wire	[(ICACHE_TAG_RAM_DW-1):0]       ram_wdata  = icache_tag_wdata;
wire	[(ICACHE_TAG_RAM_DW-1):0]       ram_rdata;


nds_ram_model #(
	.ADDR_WIDTH (ICACHE_TAG_RAM_AW),
	.WRITE_WIDTH (ICACHE_TAG_RAM_DW)
) ram_inst (
	.clk  (clk),
	.cs   (ram_cs),
	.we   (ram_we),
	.addr (ram_addr),
	.din  (ram_wdata),
	.dout (ram_rdata)
);

`ifdef TEST_MEM_MACRO

	assign icache_tag_rdata = ram_rdata;

`elsif DISABLE_RAND_ECC_INJECT

	assign icache_tag_rdata = ram_rdata;






// synthesis translate_off








// synthesis translate_on

`else

	assign icache_tag_rdata = ram_rdata;

`endif

wire nds_unused_icache_data_ctrl_in = |icache_tag_ctrl_in;
assign icache_tag_ctrl_out = {ICACHE_TAG_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule


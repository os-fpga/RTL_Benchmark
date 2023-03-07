// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_stlb_ram(
		  clk,
		  stlb_cs,
		  stlb_we,
		  stlb_addr,
		  stlb_wdata,
		  stlb_rdata,
		  stlb_ctrl_in,
		  stlb_ctrl_out
);

parameter STLB_RAM_AW  = 3;
parameter STLB_RAM_DW  = 71;
parameter STLB_RAM_CTRL_IN_WIDTH = 1;
parameter STLB_RAM_CTRL_OUT_WIDTH = 1;

input				clk;
input				stlb_cs;
input				stlb_we;
input	[(STLB_RAM_AW-1):0]	stlb_addr;
input	[(STLB_RAM_DW-1):0]	stlb_wdata;
output	[(STLB_RAM_DW-1):0]	stlb_rdata;
input   [(STLB_RAM_CTRL_IN_WIDTH-1):0] stlb_ctrl_in;
output [(STLB_RAM_CTRL_OUT_WIDTH-1):0] stlb_ctrl_out;

localparam OUT_DELAY = 0.1;

nds_ram_model #(
	.ADDR_WIDTH	(STLB_RAM_AW),
	.WRITE_WIDTH	(STLB_RAM_DW),
	.OUT_DELAY	(OUT_DELAY)
) ram_inst (
	.clk  (clk),
	.cs   (stlb_cs),
	.we   (stlb_we),
	.addr (stlb_addr),
	.din  (stlb_wdata),
	.dout (stlb_rdata)
);

wire   nds_unused_stlb_ctrl_in = |{stlb_ctrl_in};
assign stlb_ctrl_out = {STLB_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule


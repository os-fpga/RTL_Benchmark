// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_btb_ram(
		  clk,
		  btb_addr,
		  btb_cs,
		  btb_we,
		  btb_wdata,
		  btb_rdata,
		  btb_ctrl_in,
		  btb_ctrl_out
);
parameter          BTB_RAM_ADDR_WIDTH=7;
parameter          BTB_RAM_DATA_WIDTH=38;
parameter          BTB_RAM_CTRL_IN_WIDTH=1;
parameter          BTB_RAM_CTRL_OUT_WIDTH=1;

input                                   clk;

input          [(BTB_RAM_ADDR_WIDTH-1):0] btb_addr;
input                                     btb_cs;
input                                     btb_we;
input          [(BTB_RAM_DATA_WIDTH-1):0] btb_wdata;
output         [(BTB_RAM_DATA_WIDTH-1):0] btb_rdata;
input       [(BTB_RAM_CTRL_IN_WIDTH-1):0] btb_ctrl_in;
output     [(BTB_RAM_CTRL_OUT_WIDTH-1):0] btb_ctrl_out;



nds_ram_model #(
	.ADDR_WIDTH  (BTB_RAM_ADDR_WIDTH),
	.WRITE_WIDTH (BTB_RAM_DATA_WIDTH)
) ram_inst (
	.clk (clk      ),
	.we  (btb_we   ),
	.cs  (btb_cs   ),
	.addr(btb_addr ),
	.din (btb_wdata),
	.dout(btb_rdata));

wire nds_unused_btb_ctrl_in = |btb_ctrl_in;
assign btb_ctrl_out = {BTB_RAM_CTRL_OUT_WIDTH{1'b0}};


endmodule


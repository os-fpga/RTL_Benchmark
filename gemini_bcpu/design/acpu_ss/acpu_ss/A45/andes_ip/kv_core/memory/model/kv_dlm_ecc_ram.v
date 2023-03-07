// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dlm_ecc_ram(
		  clk,
		  dlm_cs,
		  dlm_we,
		  dlm_addr,
		  dlm_wdata,
		  dlm_rdata,
		  dlm_ctrl_in,
		  dlm_ctrl_out
);
parameter DLM_RAM_AW   = 11;
parameter DLM_RAM_DW   = 64;
parameter DLM_RAM_CTRL_IN_WIDTH = 1;
parameter DLM_RAM_CTRL_OUT_WIDTH = 1;

localparam OUT_DELAY        = 0.1;

input                                     clk;
input                                     dlm_cs;
input                                     dlm_we;
input                  [(DLM_RAM_AW-1):0] dlm_addr;
input                  [(DLM_RAM_DW-1):0] dlm_wdata;
output                 [(DLM_RAM_DW-1):0] dlm_rdata;
input       [(DLM_RAM_CTRL_IN_WIDTH-1):0] dlm_ctrl_in;
output     [(DLM_RAM_CTRL_OUT_WIDTH-1):0] dlm_ctrl_out;

wire                          ram_cs     = dlm_cs;
wire       [(DLM_RAM_AW-1):0] ram_addr   = dlm_addr;
wire	   [(DLM_RAM_DW-1):0] ram_wdata  = dlm_wdata;
wire                          ram_we     = dlm_we;
wire       [(DLM_RAM_DW-1):0] ram_rdata;

nds_ecc_ram_model #(
	.ADDR_WIDTH (DLM_RAM_AW),
	.WRITE_WIDTH(DLM_RAM_DW),
	.OUT_DELAY  (OUT_DELAY)
) ram_inst (
	.clk (clk		),
	.cs  (ram_cs    	),
	.we  (ram_we	),
	.addr(ram_addr		),
	.din (ram_wdata 	),
	.dout(ram_rdata 	)
);

assign dlm_rdata = ram_rdata;

wire nds_unused_dlm_ctrl_in = |dlm_ctrl_in;
assign dlm_ctrl_out = {DLM_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule


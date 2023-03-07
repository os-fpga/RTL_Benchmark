// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_ilm_ecc_ram(
		  clk,
		  ilm_cs,
		  ilm_we,
		  ilm_addr,
		  ilm_wdata,
		  ilm_rdata,
		  ilm_ctrl_in,
		  ilm_ctrl_out
);
parameter ILM_RAM_AW   = 11;
parameter ILM_RAM_DW   = 64;
parameter ILM_RAM_CTRL_IN_WIDTH = 1;
parameter ILM_RAM_CTRL_OUT_WIDTH = 1;

localparam OUT_DELAY = 0.1;
localparam IN_DELAY = 0.1;


input                                     clk;
input                                     ilm_cs;
input                                     ilm_we;
input                  [(ILM_RAM_AW-1):0] ilm_addr;
input                  [(ILM_RAM_DW-1):0] ilm_wdata;
output                 [(ILM_RAM_DW-1):0] ilm_rdata;
input       [(ILM_RAM_CTRL_IN_WIDTH-1):0] ilm_ctrl_in;
output     [(ILM_RAM_CTRL_OUT_WIDTH-1):0] ilm_ctrl_out;

reg                        ilm_cs_dly;
reg                        ilm_we_dly;
reg     [(ILM_RAM_AW-1):0] ilm_addr_dly;
reg     [(ILM_RAM_DW-1):0] ilm_wdata_dly;

always @* begin
	#0 ilm_cs_dly		= ilm_cs;
	   ilm_we_dly		= ilm_we;
	   ilm_addr_dly		= ilm_addr;
	   ilm_wdata_dly	= ilm_wdata;
end



nds_ecc_ram_model #(
	.ADDR_WIDTH (ILM_RAM_AW),
	.WRITE_WIDTH(ILM_RAM_DW)
) ram_inst (
	.clk (clk),
	.cs  (ilm_cs_dly),
	.we  (ilm_we_dly),
	.addr(ilm_addr_dly),
	.din (ilm_wdata_dly),
	.dout(ilm_rdata)
);

wire nds_unused_ilm_ctrl_in = |ilm_ctrl_in;
assign ilm_ctrl_out = {ILM_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule


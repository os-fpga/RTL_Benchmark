// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary



module ae350_rambrg_ram (
	  addr,
	  clk,
	  csb,
	  web,
	  din,
	  dout
);

parameter  ADDR_WIDTH  = 18;
parameter  DATA_WIDTH  = 64;
input            [ADDR_WIDTH-1:0] addr;
input                             clk;
input                             csb;
input            [((DATA_WIDTH/8)-1):0] web;
input            [DATA_WIDTH-1:0] din;
output           [DATA_WIDTH-1:0] dout;


nds_ram_model_bwe #(.ADDR_WIDTH ( ADDR_WIDTH ),
                    .DATA_BYTE  ((DATA_WIDTH/8))
) ram_inst(
	.clk (clk  ),
	.bwe (~web ),
	.cs  (~csb ),
	.addr(addr ),
	.din (din  ),
	.dout(dout));
endmodule

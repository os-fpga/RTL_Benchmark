// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module ae250_rambrg_ram(
		  clk,
		  rambrg_ram_addr,
		  rambrg_ram_csb,
		  rambrg_ram_web,
		  rambrg_ram_wdata,
		  rambrg_ram_rdata
);
parameter          RAMBRG_RAM_ADDR_WIDTH=20;
parameter          RAMBRG_RAM_DATA_WIDTH=32;

input                                   clk;
input       [RAMBRG_RAM_ADDR_WIDTH-1:0]	rambrg_ram_addr;
input					rambrg_ram_csb;
input   [(RAMBRG_RAM_DATA_WIDTH/8)-1:0] rambrg_ram_web;
input       [RAMBRG_RAM_DATA_WIDTH-1:0]	rambrg_ram_wdata;
output      [RAMBRG_RAM_DATA_WIDTH-1:0]	rambrg_ram_rdata;



defparam ram_inst.ADDR_WIDTH = RAMBRG_RAM_ADDR_WIDTH;
defparam ram_inst.DATA_BYTE  = (RAMBRG_RAM_DATA_WIDTH/8);
nds_ram_model_bwe ram_inst(
	.clk (clk             ),
	.bwe (~rambrg_ram_web ),
	.cs  (~rambrg_ram_csb ),
	.addr(rambrg_ram_addr ),
	.din (rambrg_ram_wdata),
	.dout(rambrg_ram_rdata));
endmodule


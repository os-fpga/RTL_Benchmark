// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module ae350_rambrg_ram(
		  clk,
		  addr,
		  csb,
		  web,
		  din,
		  dout
);
parameter	ADDR_WIDTH = 20;
parameter	DATA_WIDTH = 32;
parameter	MEM_SIZE_KB = 256;

input                           clk;
input       [ADDR_WIDTH-1:0]	addr;
input				csb;
input   [(DATA_WIDTH/8)-1:0] 	web;
input       [DATA_WIDTH-1:0]	din;
output      [DATA_WIDTH-1:0]	dout;



endmodule


// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atciic100_config.vh"
`include "atciic100_const.vh"


module atciic100 (
	  i2c_int,
	  paddr,
	  penable,
	  prdata,
	  psel,
	  pwdata,
	  pwrite,
	  pclk,
	  presetn,
	  dma_ack,
	  dma_req,
	  scl_o,
	  sda_o,
	  scl_i,
	  sda_i
);

output             i2c_int;
input        [5:2] paddr;
input              penable;
output      [31:0] prdata;
input              psel;
input       [31:0] pwdata;
input              pwrite;
input              pclk;
input              presetn;
input              dma_ack;
output             dma_req;
output             scl_o;
output             sda_o;
input              scl_i;
input              sda_i;

assign /*output            */ i2c_int='d0;
assign /*output      [31:0]*/ prdata='d0;
assign /*output            */ dma_req='d0;
assign /*output            */ scl_o='d0;
assign /*output            */ sda_o='d0;

endmodule

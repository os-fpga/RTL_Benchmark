// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcwdt200_config.vh"
`include "atcwdt200_const.vh"

module atcwdt200 (
	  extclk,
	  wdt_pause,
	  wdt_rst,
	  wdt_int,
	  pclk,
	  presetn,
	  psel,
	  penable,
	  paddr,
	  pwrite,
	  pwdata,
	  prdata
);
`ifdef ATCWDT200_32BIT_TIMER
	parameter COUNTER_WIDTH = 32;
	parameter INT_TIME_WIDTH = 4;
`else
	parameter COUNTER_WIDTH = 16;
	parameter INT_TIME_WIDTH = 3;
`endif

parameter ST_INTTIME = 1'h0;
parameter ST_RSTTIME = 1'h1;

input			extclk;
input			wdt_pause;
output			wdt_rst;
output			wdt_int;

input			pclk;
input			presetn;
input			psel;
input			penable;
input	[4:2]		paddr;
input			pwrite;
input	[31:0]		pwdata;
output	[31:0]		prdata;

wire			wdt_rst;
wire			wdt_int;

reg	[4:2]		s0;

wire	[31:0]		prdata;
wire			s1;



assign /*output			*/ wdt_rst ='d0;
assign /*output			*/ wdt_int='d0;
assign /*output	[31:0]		*/ prdata='d0;


endmodule

// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcgpio100_config.vh"
`include "atcgpio100_const.vh"


module atcgpio100 (
`ifdef ATCGPIO100_PULL_SUPPORT
	  gpio_pulldown,
	  gpio_pullup,
`endif
`ifdef ATCGPIO100_INTR_SUPPORT
	  gpio_intr,
`endif
	  gpio_oe,
	  gpio_out,
	  paddr,
	  penable,
	  prdata,
	  psel,
	  pwdata,
	  pwrite,
	  pclk,
	  presetn,
	  extclk,
	  gpio_in
);

`ifdef ATCGPIO100_PULL_SUPPORT
output      [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_pulldown;
output      [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_pullup;
`endif
`ifdef ATCGPIO100_INTR_SUPPORT
output                                     gpio_intr;
`endif
output      [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_oe;
output      [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_out;
input                                [7:0] paddr;
input                                      penable;
output                              [31:0] prdata;
input                                      psel;
input                               [31:0] pwdata;
input                                      pwrite;
input                                      pclk;
input                                      presetn;
input                                      extclk;
input       [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_in;


`ifdef ATCGPIO100_PULL_SUPPORT
assign /*output      [(`ATCGPIO100_GPIO_NUM - 1):0]*/ gpio_pulldown='d0;
assign /*output      [(`ATCGPIO100_GPIO_NUM - 1):0]*/ gpio_pullup='d0;
`endif
`ifdef ATCGPIO100_INTR_SUPPORT
assign /*output                                    */ gpio_intr='d0;
`endif
assign /*output      [(`ATCGPIO100_GPIO_NUM - 1):0]*/ gpio_oe='d0;
assign /*output      [(`ATCGPIO100_GPIO_NUM - 1):0]*/ gpio_out='d0;
assign /*output                              [31:0]*/ prdata='d0;


endmodule

// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcpit100_config.vh"
`include "atcpit100_const.vh"


module atcpit100 (
`ifdef ATCPIT100_CH1_SUPPORT
	  ch1_pwm,
	  ch1_pwmoe,
`endif
`ifdef ATCPIT100_CH2_SUPPORT
	  ch2_pwm,
	  ch2_pwmoe,
`endif
`ifdef ATCPIT100_CH3_SUPPORT
	  ch3_pwm,
	  ch3_pwmoe,
`endif
	  extclk,
	  paddr,
	  pclk,
	  penable,
	  pit_pause,
	  presetn,
	  psel,
	  pwdata,
	  pwrite,
	  ch0_pwm,
	  ch0_pwmoe,
	  pit_intr,
	  prdata
);

`ifdef ATCPIT100_CH1_SUPPORT
output             ch1_pwm;
output             ch1_pwmoe;
`endif
`ifdef ATCPIT100_CH2_SUPPORT
output             ch2_pwm;
output             ch2_pwmoe;
`endif
`ifdef ATCPIT100_CH3_SUPPORT
output             ch3_pwm;
output             ch3_pwmoe;
`endif
input              extclk;
input        [6:2] paddr;
input              pclk;
input              penable;
input              pit_pause;
input              presetn;
input              psel;
input       [31:0] pwdata;
input              pwrite;
output             ch0_pwm;
output             ch0_pwmoe;
output             pit_intr;
output      [31:0] prdata;

assign /*output             */ch1_pwm='d0;
assign /*output             */ch1_pwmoe='d0;
assign /*output             */ch2_pwm='d0;
assign /*output             */ch2_pwmoe='d0;
assign /*output             */ch3_pwm='d0;
assign /*output             */ch3_pwmoe='d0;
assign /*output             */ch0_pwm='d0;
assign /*output             */ch0_pwmoe='d0;
assign /*output             */pit_intr='d0;
assign /*output      [31:0] */prdata='d0;


endmodule

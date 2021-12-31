///////////////////////////////////////////////////////////////////////////////
//
//
// Copyright (C) 2007, Licensed customers of QuickLogic may copy or modify
// this file for use in designing QuickLogic devices only.
//
// Module Name:  e_clock_mng
// File Name:    e_clock_mng.v
// 
// Version 1.0   April  1, 2006  -Original
// Version 1.1   Feb.   7, 2007  -Added 16 bit support
// Version 1.2   May.   14,2007  -Fixed cmd to cmd delay
//                               -SDIO power on switch clock line level
//                               -Used latched signal for datline0
//                               -Optimized to use fifo controllers
//                               -Modified to use one RAMBLOCK instead of two
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns

module e_clock_mng(
 rst,
 sd_clk_2x,
 sd_clock_en,    // from sync
 sdclk_disable,  // from sync
 sdio_on,
 int_clock_en,   // from sync
 clock_div,
 load_clock_div_p, //T flop Pulse from sync

 sd_clkn,                                        
 sd_clk,
 sd_clk_int
 );

 input           rst;
 input           sd_clk_2x;
 input           sd_clock_en;
 input           sdclk_disable;
 input           sdio_on;
 input           int_clock_en;
 input   [7:0]   clock_div;
 input           load_clock_div_p;

 output          sd_clkn;                                        
 output          sd_clk;
 output          sd_clk_int;

 wire sd_clkn;
 wire sd_clk;
 wire sd_clk_int;

 wire sd_clk_pre;
 wire sd_clk_fb;
 wire sd_clk_in;

 wire  sd_clk_cnt_is_0;
 wire  load_sd_clk_cnt;

 wire    [7:0]   div_value;
 wire    [7:0]   clk_div_cnt;
 
 wire            sd_clk_masked;

 assign  div_value[7]    = clock_div[7];
 assign  div_value[6]    = div_value[7] | clock_div[6];
 assign  div_value[5]    = div_value[6] | clock_div[5];
 assign  div_value[4]    = div_value[5] | clock_div[4];
 assign  div_value[3]    = div_value[4] | clock_div[3];
 assign  div_value[2]    = div_value[3] | clock_div[2];
 assign  div_value[1]    = div_value[2] | clock_div[1];
 assign  div_value[0]    = div_value[1] | clock_div[0];

 assign  sd_clk_cnt_is_0 = ~|clk_div_cnt;
 assign  load_sd_clk_cnt = load_clock_div_p | sd_clk_cnt_is_0;
 pp_dcntx8 sd_clk_cnt ( 
    .CLK        (sd_clk_2x), 
    .CLR        (rst), 
    .D          (div_value), 
    .EN         (int_clock_en), 
    .LOAD       (load_sd_clk_cnt), 
    .Q          (clk_div_cnt)
    );

 assign sd_clk_pre = (int_clock_en && sd_clock_en && !sdclk_disable && sd_clk_cnt_is_0)? ~sd_clk_fb : sd_clk_fb; 
 assign sd_clkn = ~sd_clk_int;
 
 assign sd_clk_masked = sd_clk_pre & sdio_on & sd_clock_en & int_clock_en;

 bipadoff_pp sd_clk_pad_inst( 
      .A2        (sd_clk_masked), 
		.EN        (1'b1), 
		.FFCLK     (sd_clk_2x), 
		.FFCLR     (rst), 
		.O_EN      (1'b1), 
		.P_FB      (sd_clk_fb),
		.Q         (sd_clk_in), 
		.P         (sd_clk),
		.sd_clock_en (sd_clock_en)
		);

/*  gclkbuff sd_clk_int_gbuf (
    .A (sd_clk_in), 
    .Z (sd_clk_int)
  ); */

assign sd_clk_int = sd_clk_in;
endmodule

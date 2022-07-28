// --------------------------------------------------------------------
//
// --------------------------------------------------------------------

//////////////////////////////////////////////////////////////////////
////                                                              ////
////  WISHBONE GPIO Definitions                                   ////
////                                                              ////
////  This file is part of the GPIO project                       ////
////  http://www.opencores.org/cores/gpio/                        ////
////                                                              ////
////  Description                                                 ////
////  GPIO IP Definitions.                                        ////
////                                                              ////
////  To Do:                                                      ////
////   Nothing                                                    ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//

//
// Number of GPIO I/O signals
//
// This is the most important parameter of the GPIO IP core. It defines how many
// I/O signals core has. Range is from 1 to 32. If more than 32 I/O signals are
// required, use several instances of GPIO IP core.
//
// Default is 16.
//
`define GPIO_IOS 32

//depending on number of GPIO_IOS, define this...
// for example: if there is 26 GPIO_IOS, define GPIO_LINES26
//

`define GPIO_LINES32

//
// Undefine this one if you don't want to remove GPIO block from your design
// but you also don't need it. When it is undefined, all GPIO ports still
// remain valid and the core can be synthesized however internally there is
// no GPIO funationality.
//
// Defined by default (duhh !).
//
`define GPIO_IMPLEMENTED

//
// Define to register all WISHBONE outputs.
//
// Register outputs if you are using GPIO core as a block and synthesizing
// and place&routing it separately from the rest of the system.
//
// If you do not need registered outputs, you can save some area by not defining
// this macro. By default it is defined.
//
`define GPIO_REGISTERED_WB_OUTPUTS

//
// Define to register all GPIO pad outputs.
//
// Register outputs if you are using GPIO core as a block and synthesizing
// and place&routing it separately from the rest of the system.
//
// If you do not need registered outputs, you can save some area by not defining
// this macro. By default it is defined.
//
`define GPIO_REGISTERED_IO_OUTPUTS

//
// Implement aux feature. If this define is not defined also aux_i port and 
// RGPIO_AUX register will be removed
//
// Defined by default.
//
`define GPIO_AUX_IMPLEMENT

//
// If this is not defined clk_pad_i will be removed. Input lines will be lached on 
// positive edge of system clock
// if disabled defines GPIO_NO_NEGEDGE_FLOPS, GPIO_NO_CLKPAD_LOGIC will have no effect.
//
// Defined by default.
//
// `define GPIO_CLKPAD

//
// Define to avoid using negative edge clock flip-flops for external clock
// (caused by NEC register. Instead an inverted external clock with
// positive edge clock flip-flops will be used.
// This define don't have any effect if GPIO_CLKPAD is not defined and if GPIO_SYNC_IN_CLK is defined
//
// By default it is not defined.
//
//`define GPIO_NO_NEGEDGE_FLOPS

//
// If GPIO_NO_NEGEDGE_FLOPS is defined, a mux needs to be placed on external clock
// clk_pad_i to implement RGPIO_CTRL[NEC] functionality. If no mux is allowed on
// clock signal, enable the following define.
// This define don't have any effect if GPIO_CLKPAD is not defined and if GPIO_SYNC_IN_CLK is defined
//
// By default it is not defined.
//
//`define GPIO_NO_CLKPAD_LOGIC


//
// synchronization defines
//
// Two synchronization flops to input lineis added.
// system clock synchronization.
//
`define GPIO_SYNC_IN_WB

//
// Add synchronization flops to external clock input line. Gpio will have just one clock domain, 
// everithing will be synchronized to wishbone clock. External clock muas be at least 2-3x slower 
// as systam clock.
//
`define GPIO_SYNC_CLK_WB

//
// Add synchronization to input pads. synchronization to external clock.
// Don't hawe any effect if GPIO_SYNC_CLK_WB is defined.
//
//`define GPIO_SYNC_IN_CLK

//
// Add synchronization flops between system clock and external clock.
// Only possible if external clock is enabled and clock synchroization is disabled.
//
//`define GPIO_SYNC_IN_CLK_WB



// 
// Undefine if you don't need to read GPIO registers except for RGPIO_IN register.
// When it is undefined all reads of GPIO registers return RGPIO_IN register. This
// is usually useful if you want really small area (for example when implemented in
// FPGA).
//
// To follow GPIO IP core specification document this one must be defined. Also to
// successfully run the test bench it must be defined. By default it is defined.
//
`define GPIO_READREGS

//
// Full WISHBONE address decoding
//
// It is is undefined, partial WISHBONE address decoding is performed.
// Undefine it if you need to save some area.
//
// By default it is defined.
//
`define GPIO_FULL_DECODE

//
// Strict 32-bit WISHBONE access
//
// If this one is defined, all WISHBONE accesses must be 32-bit. If it is
// not defined, err_o is asserted whenever 8- or 16-bit access is made.
// Undefine it if you need to save some area.
//
// By default it is defined.
//
//`define GPIO_STRICT_32BIT_ACCESS
//
`ifdef GPIO_STRICT_32BIT_ACCESS
`else
// added by gorand :
// if GPIO_STRICT_32BIT_ACCESS is not defined,
// depending on number of gpio I/O lines, the following are defined :
// if the number of I/O lines is in range 1-8,   GPIO_WB_BYTES1 is defined,
// if the number of I/O lines is in range 9-16,  GPIO_WB_BYTES2 is defined,
// if the number of I/O lines is in range 17-24, GPIO_WB_BYTES3 is defined,
// if the number of I/O lines is in range 25-32, GPIO_WB_BYTES4 is defined,

`define GPIO_WB_BYTES4
//`define GPIO_WB_BYTES3
//`define GPIO_WB_BYTES2
//`define GPIO_WB_BYTES1

`endif

//
// WISHBONE address bits used for full decoding of GPIO registers.
//
`define GPIO_ADDRHH 7
`define GPIO_ADDRHL 6
`define GPIO_ADDRLH 1
`define GPIO_ADDRLL 0

//
// Bits of WISHBONE address used for partial decoding of GPIO registers.
//
// Default 5:2.
//
`define GPIO_OFS_BITS	`GPIO_ADDRHL-1:`GPIO_ADDRLH+1

//
// Addresses of GPIO registers
//
// To comply with GPIO IP core specification document they must go from
// address 0 to address 0x18 in the following order: RGPIO_IN, RGPIO_OUT,
// RGPIO_OE, RGPIO_INTE, RGPIO_PTRIG, RGPIO_AUX and RGPIO_CTRL
//
// If particular register is not needed, it's address definition can be omitted
// and the register will not be implemented. Instead a fixed default value will
// be used.
//
`define GPIO_RGPIO_IN		  4'h0	// Address 0x00
`define GPIO_RGPIO_OUT		4'h1	// Address 0x04
`define GPIO_RGPIO_OE		  4'h2	// Address 0x08
`define GPIO_RGPIO_INTE		4'h3	// Address 0x0c
`define GPIO_RGPIO_PTRIG	4'h4	// Address 0x10

`ifdef GPIO_AUX_IMPLEMENT
`define GPIO_RGPIO_AUX		4'h5	// Address 0x14
`endif // GPIO_AUX_IMPLEMENT

`define GPIO_RGPIO_CTRL		4'h6	// Address 0x18
`define GPIO_RGPIO_INTS		4'h7	// Address 0x1c

`ifdef GPIO_CLKPAD
`define GPIO_RGPIO_ECLK   4'h8  // Address 0x20
`define GPIO_RGPIO_NEC    4'h9  // Address 0x24
`endif //  GPIO_CLKPAD

//
// Default values for unimplemented GPIO registers
//
`define GPIO_DEF_RGPIO_IN	`GPIO_IOS'h0
`define GPIO_DEF_RGPIO_OUT	`GPIO_IOS'h0
`define GPIO_DEF_RGPIO_OE	`GPIO_IOS'h0
`define GPIO_DEF_RGPIO_INTE	`GPIO_IOS'h0
`define GPIO_DEF_RGPIO_PTRIG	`GPIO_IOS'h0
`define GPIO_DEF_RGPIO_AUX	`GPIO_IOS'h0
`define GPIO_DEF_RGPIO_CTRL	`GPIO_IOS'h0
`define GPIO_DEF_RGPIO_ECLK `GPIO_IOS'h0
`define GPIO_DEF_RGPIO_NEC `GPIO_IOS'h0


//
// RGPIO_CTRL bits
//
// To comply with the GPIO IP core specification document they must go from
// bit 0 to bit 1 in the following order: INTE, INT
//
`define GPIO_RGPIO_CTRL_INTE		0
`define GPIO_RGPIO_CTRL_INTS		1


`timescale 1ns/10ps


module top(
  ////////////////////////  Clock Input     ////////////////////////
  input [1:0]       clock_24,               //  24 MHz
  input [1:0]       clock_27,               //  27 MHz
  input             clock_50,               //  50 MHz
  input             ext_clock,              //  External Clock
  ////////////////////////  Push Button     ////////////////////////
  input [3:0]       key,                    //  Pushbutton[3:0]
  ////////////////////////  DPDT Switch     ////////////////////////
  input [9:0]       sw,                     //  Toggle Switch[9:0]
  ////////////////////////  7-SEG Dispaly   ////////////////////////
  output    [6:0]   hex0,                   //  Seven Segment Digit 0
  output    [6:0]   hex1,                   //  Seven Segment Digit 1
  output    [6:0]   hex2,                   //  Seven Segment Digit 2
  output    [6:0]   hex3,                   //  Seven Segment Digit 3
  ////////////////////////////  LED     ////////////////////////////
  output    [7:0]   ledg,                   //  LED Green[7:0]
  output    [9:0]   ledr,                   //  LED Red[9:0]
  ////////////////////////////  UART    ////////////////////////////
  output            uart_txd,               //  UART Transmitter
  input             uart_rxd,               //  UART Receiver
  ///////////////////////       SDRAM Interface ////////////////////////
  inout [15:0]      dram_dq,                //  SDRAM Data bus 16 Bits
  output    [11:0]  dram_addr,              //  SDRAM Address bus 12 Bits
  output            dram_ldqm,              //  SDRAM Low-byte Data Mask
  output            dram_udqm,              //  SDRAM High-byte Data Mask
  output            dram_we_n,              //  SDRAM Write Enable
  output            dram_cas_n,             //  SDRAM Column Address Strobe
  output            dram_ras_n,             //  SDRAM Row Address Strobe
  output            dram_cs_n,              //  SDRAM Chip Select
  output            dram_ba_0,              //  SDRAM Bank Address 0
  output            dram_ba_1,              //  SDRAM Bank Address 0
  output            dram_clk,               //  SDRAM Clock
  output            dram_cke,               //  SDRAM Clock Enable
  ////////////////////////  Flash Interface ////////////////////////
  inout [7:0]       fl_dq,                  //  FLASH Data bus 8 Bits
  output    [21:0]  fl_addr,                //  FLASH Address bus 22 Bits
  output            fl_we_n,                //  FLASH Write Enable
  output            fl_rst_n,               //  FLASH Reset
  output            fl_oe_n,                //  FLASH Output Enable
  output            fl_ce_n,                //  FLASH Chip Enable
  ////////////////////////  SRAM Interface  ////////////////////////
  inout   [15:0]    sram_dq,                //  SRAM Data bus 16 Bits
  output  [17:0]    sram_addr,              //  SRAM Address bus 18 Bits
  output            sram_ub_n,              //  SRAM High-byte Data Mask
  output            sram_lb_n,              //  SRAM Low-byte Data Mask
  output            sram_we_n,              //  SRAM Write Enable
  output            sram_ce_n,              //  SRAM Chip Enable
  output            sram_oe_n,              //  SRAM Output Enable
  ////////////////////  SD Card Interface   ////////////////////////
  inout             sd_dat,                 //  SD Card Data
  inout             sd_dat3,                //  SD Card Data 3
  inout             sd_cmd,                 //  SD Card Command Signal
  output            sd_clk,                 //  SD Card Clock
  ////////////////////////  I2C     ////////////////////////////////
  inout             i2c_sdat,               //  I2C Data
  inout             i2c_sclk,               //  I2C Clock
  ////////////////////////  PS2     ////////////////////////////////
  input             ps2_dat,                //  PS2 Data
  input             ps2_clk,                //  PS2 Clock
  ////////////////////  USB JTAG link   ////////////////////////////
  input             tdi,                    // CPLD -> FPGA (data in)
  input             tck,                    // CPLD -> FPGA (clk)
  input             tcs,                    // CPLD -> FPGA (CS)
  output            tdo,                    // FPGA -> CPLD (data out)
  ////////////////////////  VGA         ////////////////////////////
  output            vga_hs,                 //  VGA H_SYNC
  output            vga_vs,                 //  VGA V_SYNC
  output    [3:0]   vga_r,                  //  VGA Red[3:0]
  output    [3:0]   vga_g,                  //  VGA Green[3:0]
  output    [3:0]   vga_b,                  //  VGA Blue[3:0]
  ////////////////////  Audio CODEC     ////////////////////////////
  inout             aud_adclrck,            //  Audio CODEC ADC LR Clock
  input             aud_adcdat,             //  Audio CODEC ADC Data
  inout             aud_daclrck,            //  Audio CODEC DAC LR Clock
  output            aud_dacdat,             //  Audio CODEC DAC Data
  inout             aud_bclk,               //  Audio CODEC Bit-Stream Clock
  output            aud_xck,                //  Audio CODEC Chip Clock
  ////////////////////////  GPIO    ////////////////////////////////
  inout [35:0]      gpio_0,                 //  GPIO Connection 0
  inout [35:0]      gpio_1                  //  GPIO Connection 1
);

	parameter DW 	= 32;
	parameter AW 	= 32;


  //---------------------------------------------------
  // system wires
	wire sys_rst;
// 	wire sys_clk = clock_27[0];
	wire sys_clk;
	wire sys_audio_clk_en;


  //---------------------------------------------------
  // pll
 // qaz_pll
 //   i_qaz_pll
 //   (
 //     .clock_24(clock_24),               //  24 MHz
 //     .clock_27(clock_27),               //  27 MHz
 //     .clock_50(clock_50),               //  50 MHz
 //     .ext_clock(ext_clock),              //  External Clock
//
 //     .sys_audio_clk_en(sys_audio_clk_en),
//
 //     .aud_xck(aud_xck),
 //     .sys_clk(sys_clk)
 //   );


//   //---------------------------------------------------
//   // audio clock
//   wire	CLK_18_4, outclk_sig;

//   PLL
//     u0(
//         .inclk0(clock_27[0]),
//         .c0(CLK_18_4)
//       );
//
//   clk_buffer	clk_buffer_inst (
//   	.ena ( sys_audio_clk_en ),
//   	.inclk ( CLK_18_4 ),
//   	.outclk ( outclk_sig )
//   	);
//
//   assign  aud_xck =	outclk_sig;


  //---------------------------------------------------
  // FLED
	reg [24:0] counter;
	wire [7:0]  fled;

	always @(posedge sys_clk or posedge sys_rst)
	  if(sys_rst)
  		counter <= 25'b0;
  	else
  		counter <= counter + 1;

	assign fled[0]  = sw[0];
	assign fled[1]  = sw[1];
	assign fled[2]  = sw[2];
	assign fled[3]  = sw[3];
	assign fled[4]  = sw[4];
	assign fled[5]  = sw[5];
	assign fled[6]  = sw[6];
	assign fled[7]  = counter[24];


// --------------------------------------------------------------------
//  wb_async_mem_bridge
  wire [31:0] m0_data_i;
  wire [31:0] m0_data_o;
  wire [31:0] m0_addr_o;
  wire [3:0]  m0_sel_o;
  wire        m0_we_o;
  wire        m0_cyc_o;
  wire        m0_stb_o;
  wire        m0_ack_i;
  wire        m0_err_i;
  wire        m0_rty_i;

  wb_async_mem_bridge #( .AW(24) )
    i_wb_async_mem_bridge(
      .wb_data_i(m0_data_i),
      .wb_data_o(m0_data_o),
      .wb_addr_o(m0_addr_o[23:0]),
      .wb_sel_o(m0_sel_o),
      .wb_we_o(m0_we_o),
      .wb_cyc_o(m0_cyc_o),
      .wb_stb_o(m0_stb_o),
      .wb_ack_i(m0_ack_i),
      .wb_err_i(m0_err_i),
      .wb_rty_i(m0_rty_i),

      .mem_d( gpio_1[31:0] ),
      .mem_a( gpio_0[23:0] ),
      .mem_oe_n( gpio_0[30] ),
      .mem_bls_n( { gpio_0[26], gpio_0[27], gpio_0[28], gpio_0[29] } ),
      .mem_we_n( gpio_0[25] ),
      .mem_cs_n( gpio_0[24] ),

      .wb_clk_i(sys_clk),
      .wb_rst_i(sys_rst)
    );


  //---------------------------------------------------
  // wb_conmax_top

  // Slave 0 Interface

  wire  [DW-1:0]  s0_data_i;
  wire  [DW-1:0]  s0_data_o;
  wire  [AW-1:0]  s0_addr_o;
  wire  [3:0]     s0_sel_o;
  wire            s0_we_o;
  wire            s0_cyc_o;
  wire            s0_stb_o;
  wire            s0_ack_i;
  wire            s0_err_i;
  wire            s0_rty_i;

  wire  [DW-1:0]  s1_data_i;
  wire  [DW-1:0]  s1_data_o;
  wire  [AW-1:0]  s1_addr_o;
  wire  [3:0]     s1_sel_o;
  wire            s1_we_o;
  wire            s1_cyc_o;
  wire            s1_stb_o;
  wire            s1_ack_i;
  wire            s1_err_i;
  wire            s1_rty_i;

  wire  [DW-1:0]  s2_data_i;
  wire  [DW-1:0]  s2_data_o;
  wire  [AW-1:0]  s2_addr_o;
  wire  [3:0]     s2_sel_o;
  wire            s2_we_o;
  wire            s2_cyc_o;
  wire            s2_stb_o;
  wire            s2_ack_i;
  wire            s2_err_i;
  wire            s2_rty_i;

  wire  [DW-1:0]  s3_data_i;
  wire  [DW-1:0]  s3_data_o;
  wire  [AW-1:0]  s3_addr_o;
  wire  [3:0]     s3_sel_o;
  wire            s3_we_o;
  wire            s3_cyc_o;
  wire            s3_stb_o;
  wire            s3_ack_i;
  wire            s3_err_i;
  wire            s3_rty_i;

  wire  [DW-1:0]  s4_data_i;
  wire  [DW-1:0]  s4_data_o;
  wire  [AW-1:0]  s4_addr_o;
  wire  [3:0]     s4_sel_o;
  wire            s4_we_o;
  wire            s4_cyc_o;
  wire            s4_stb_o;
  wire            s4_ack_i;
  wire            s4_err_i;
  wire            s4_rty_i;

  wire  [DW-1:0]  s5_data_i;
  wire  [DW-1:0]  s5_data_o;
  wire  [AW-1:0]  s5_addr_o;
  wire  [3:0]     s5_sel_o;
  wire            s5_we_o;
  wire            s5_cyc_o;
  wire            s5_stb_o;
  wire            s5_ack_i;
  wire            s5_err_i;
  wire            s5_rty_i;

  wire  [DW-1:0]  s6_data_i;
  wire  [DW-1:0]  s6_data_o;
  wire  [AW-1:0]  s6_addr_o;
  wire  [3:0]     s6_sel_o;
  wire            s6_we_o;
  wire            s6_cyc_o;
  wire            s6_stb_o;
  wire            s6_ack_i;
  wire            s6_err_i;
  wire            s6_rty_i;

  wb_conmax_top
    i_wb_conmax_top(
      // Master 0 Interface
      .m0_data_i(m0_data_o),
      .m0_data_o(m0_data_i),
      .m0_addr_i( {m0_addr_o[23:20], 8'b0, m0_addr_o[19:0]} ),
      .m0_sel_i(m0_sel_o),
      .m0_we_i(m0_we_o),
      .m0_cyc_i(m0_cyc_o),
      .m0_stb_i(m0_stb_o),
      .m0_ack_o(m0_ack_i),
      .m0_err_o(m0_err_i),
      .m0_rty_o(m0_rty_i),
      // Master 1 Interface
      .m1_data_i(32'h0000_0000),
      .m1_addr_i(32'h0000_0000),
      .m1_sel_i(4'h0),
      .m1_we_i(1'b0),
      .m1_cyc_i(1'b0),
      .m1_stb_i(1'b0),
      // Master 2 Interface
      .m2_data_i(32'h0000_0000),
      .m2_addr_i(32'h0000_0000),
      .m2_sel_i(4'h0),
      .m2_we_i(1'b0),
      .m2_cyc_i(1'b0),
      .m2_stb_i(1'b0),
      // Master 3 Interface
      .m3_data_i(32'h0000_0000),
      .m3_addr_i(32'h0000_0000),
      .m3_sel_i(4'h0),
      .m3_we_i(1'b0),
      .m3_cyc_i(1'b0),
      .m3_stb_i(1'b0),
      // Master 4 Interface
      .m4_data_i(32'h0000_0000),
      .m4_addr_i(32'h0000_0000),
      .m4_sel_i(4'h0),
      .m4_we_i(1'b0),
      .m4_cyc_i(1'b0),
      .m4_stb_i(1'b0),
      // Master 5 Interface
      .m5_data_i(32'h0000_0000),
      .m5_addr_i(32'h0000_0000),
      .m5_sel_i(4'h0),
      .m5_we_i(1'b0),
      .m5_cyc_i(1'b0),
      .m5_stb_i(1'b0),
      // Master 6 Interface
      .m6_data_i(32'h0000_0000),
      .m6_addr_i(32'h0000_0000),
      .m6_sel_i(4'h0),
      .m6_we_i(1'b0),
      .m6_cyc_i(1'b0),
      .m6_stb_i(1'b0),
      // Master 7 Interface
      .m7_data_i(32'h0000_0000),
      .m7_addr_i(32'h0000_0000),
      .m7_sel_i(4'h0),
      .m7_we_i(1'b0),
      .m7_cyc_i(1'b0),
      .m7_stb_i(1'b0),

      // Slave 0 Interface
      .s0_data_i(s0_data_i),
      .s0_data_o(s0_data_o),
      .s0_addr_o(s0_addr_o),
      .s0_sel_o(s0_sel_o),
      .s0_we_o(s0_we_o),
      .s0_cyc_o(s0_cyc_o),
      .s0_stb_o(s0_stb_o),
      .s0_ack_i(s0_ack_i),
      .s0_err_i(s0_err_i),
      .s0_rty_i(s0_rty_i),
      // Slave 1 Interface
      .s1_data_i(s1_data_i),
      .s1_data_o(s1_data_o),
      .s1_addr_o(s1_addr_o),
      .s1_sel_o(s1_sel_o),
      .s1_we_o(s1_we_o),
      .s1_cyc_o(s1_cyc_o),
      .s1_stb_o(s1_stb_o),
      .s1_ack_i(s1_ack_i),
      .s1_err_i(s1_err_i),
      .s1_rty_i(s1_rty_i),
      // Slave 2 Interface
      .s2_data_i(s2_data_i),
      .s2_data_o(s2_data_o),
      .s2_addr_o(s2_addr_o),
      .s2_sel_o(s2_sel_o),
      .s2_we_o(s2_we_o),
      .s2_cyc_o(s2_cyc_o),
      .s2_stb_o(s2_stb_o),
      .s2_ack_i(s2_ack_i),
      .s2_err_i(s2_err_i),
      .s2_rty_i(s2_rty_i),
      // Slave 3 Interface
      .s3_data_i(s3_data_i),
      .s3_data_o(s3_data_o),
      .s3_addr_o(s3_addr_o),
      .s3_sel_o(s3_sel_o),
      .s3_we_o(s3_we_o),
      .s3_cyc_o(s3_cyc_o),
      .s3_stb_o(s3_stb_o),
      .s3_ack_i(s3_ack_i),
      .s3_err_i(s3_err_i),
      .s3_rty_i(s3_rty_i),
      // Slave 4 Interface
      .s4_data_i(s4_data_i),
      .s4_data_o(s4_data_o),
      .s4_addr_o(s4_addr_o),
      .s4_sel_o(s4_sel_o),
      .s4_we_o(s4_we_o),
      .s4_cyc_o(s4_cyc_o),
      .s4_stb_o(s4_stb_o),
      .s4_ack_i(s4_ack_i),
      .s4_err_i(s4_err_i),
      .s4_rty_i(s4_rty_i),
      // Slave 5 Interface
      .s5_data_i(s5_data_i),
      .s5_data_o(s5_data_o),
      .s5_addr_o(s5_addr_o),
      .s5_sel_o(s5_sel_o),
      .s5_we_o(s5_we_o),
      .s5_cyc_o(s5_cyc_o),
      .s5_stb_o(s5_stb_o),
      .s5_ack_i(s5_ack_i),
      .s5_err_i(s5_err_i),
      .s5_rty_i(s5_rty_i),
      // Slave 6 Interface
      .s6_data_i(32'h0000_0000),
      .s6_ack_i(1'b0),
      .s6_err_i(1'b0),
      .s6_rty_i(1'b0),
      // Slave 7 Interface
      .s7_data_i(32'h0000_0000),
      .s7_ack_i(1'b0),
      .s7_err_i(1'b0),
      .s7_rty_i(1'b0),
      // Slave 8 Interface
      .s8_data_i(32'h0000_0000),
      .s8_ack_i(1'b0),
      .s8_err_i(1'b0),
      .s8_rty_i(1'b0),
      // Slave 9 Interface
      .s9_data_i(32'h0000_0000),
      .s9_ack_i(1'b0),
      .s9_err_i(1'b0),
      .s9_rty_i(1'b0),
      // Slave 10 Interface
      .s10_data_i(32'h0000_0000),
      .s10_ack_i(1'b0),
      .s10_err_i(1'b0),
      .s10_rty_i(1'b0),
      // Slave 11 Interface
      .s11_data_i(32'h0000_0000),
      .s11_ack_i(1'b0),
      .s11_err_i(1'b0),
      .s11_rty_i(1'b0),
      // Slave 12 Interface
      .s12_data_i(32'h0000_0000),
      .s12_ack_i(1'b0),
      .s12_err_i(1'b0),
      .s12_rty_i(1'b0),
      // Slave 13 Interface
      .s13_data_i(32'h0000_0000),
      .s13_ack_i(1'b0),
      .s13_err_i(1'b0),
      .s13_rty_i(1'b0),
      // Slave 14 Interface
      .s14_data_i(32'h0000_0000),
      .s14_ack_i(1'b0),
      .s14_err_i(1'b0),
      .s14_rty_i(1'b0),
      // Slave 15 Interface
      .s15_data_i(32'h0000_0000),
      .s15_ack_i(1'b0),
      .s15_err_i(1'b0),
      .s15_rty_i(1'b0),

      .clk_i(sys_clk),
      .rst_i(sys_rst)
    );


  //---------------------------------------------------
  // async_mem_if
  assign s0_err_i = 1'b0;
  assign s0_rty_i = 1'b0;

  async_mem_if #( .AW(18), .DW(16) )
    i_sram (
      .async_dq(sram_dq),
      .async_addr(sram_addr),
      .async_ub_n(sram_ub_n),
      .async_lb_n(sram_lb_n),
      .async_we_n(sram_we_n),
      .async_ce_n(sram_ce_n),
      .async_oe_n(sram_oe_n),
      .wb_clk_i(sys_clk),
      .wb_rst_i(sys_rst),
      .wb_adr_i( {14'h0000, s0_addr_o[17:0]} ),
      .wb_dat_i(s0_data_o),
      .wb_we_i(s0_we_o),
      .wb_stb_i(s0_stb_o),
      .wb_cyc_i(s0_cyc_o),
      .wb_sel_i(s0_sel_o),
      .wb_dat_o(s0_data_i),
      .wb_ack_o(s0_ack_i),
      .ce_setup(4'h0),
      .op_hold(4'h1),
      .ce_hold(4'h0),
      .big_endian_if_i(1'b0),
      .lo_byte_if_i(1'b0)
    );


  //---------------------------------------------------
  // GPIO a
  assign s1_rty_i = 1'b0;

  wire        gpio_a_inta_o;
  wire        gpio_a_clk_i;
  wire [31:0] gpio_a_aux_i;
  wire [31:0] gpio_a_ext_pad_i;
  wire [31:0] gpio_a_ext_pad_o;
  wire [31:0] gpio_a_ext_padoe_o;

  gpio_top
    i_gpio_a(
  	          .wb_clk_i(sys_clk),
  	          .wb_rst_i(sys_rst),
  	          .wb_cyc_i(s1_cyc_o),
  	          .wb_adr_i( s1_addr_o[7:0] ),
  	          .wb_dat_i(s1_data_o),
  	          .wb_sel_i(s1_sel_o),
  	          .wb_we_i(s1_we_o),
  	          .wb_stb_i(s1_stb_o),
  	          .wb_dat_o(s1_data_i),
  	          .wb_ack_o(s1_ack_i),
  	          .wb_err_o(s1_err_i),
  	          .wb_inta_o(gpio_a_inta_o),

`ifdef GPIO_AUX_IMPLEMENT
  	          .aux_i(gpio_a_aux_i),
`endif // GPIO_AUX_IMPLEMENT

`ifdef GPIO_CLKPAD
              .clk_pad_i(gpio_a_clk_i),
`endif //  GPIO_CLKPAD

  	          .ext_pad_i(gpio_a_ext_pad_i),
  	          .ext_pad_o(gpio_a_ext_pad_o),
  	          .ext_padoe_o(gpio_a_ext_padoe_o)
            );


  //---------------------------------------------------
  // GPIO b
  assign s2_rty_i = 1'b0;

  wire        gpio_b_inta_o;
  wire        gpio_b_clk_i;
  wire [31:0] gpio_b_aux_i;
  wire [31:0] gpio_b_ext_pad_i;
  wire [31:0] gpio_b_ext_pad_o;
  wire [31:0] gpio_b_ext_padoe_o;

  gpio_top
    i_gpio_b(
  	          .wb_clk_i(sys_clk),
  	          .wb_rst_i(sys_rst),
  	          .wb_cyc_i(s2_cyc_o),
  	          .wb_adr_i( s2_addr_o[7:0] ),
  	          .wb_dat_i(s2_data_o),
  	          .wb_sel_i(s2_sel_o),
  	          .wb_we_i(s2_we_o),
  	          .wb_stb_i(s2_stb_o),
  	          .wb_dat_o(s2_data_i),
  	          .wb_ack_o(s2_ack_i),
  	          .wb_err_o(s2_err_i),
  	          .wb_inta_o(gpio_b_inta_o),

`ifdef GPIO_AUX_IMPLEMENT
  	          .aux_i(gpio_b_aux_i),
`endif // GPIO_AUX_IMPLEMENT

`ifdef GPIO_CLKPAD
              .clk_pad_i(gpio_b_clk_i),
`endif //  GPIO_CLKPAD

  	          .ext_pad_i(gpio_b_ext_pad_i),
  	          .ext_pad_o(gpio_b_ext_pad_o),
  	          .ext_padoe_o(gpio_b_ext_padoe_o)
            );


  //---------------------------------------------------
  // qaz_system
  qaz_system
    i_qaz_system(
                    .sys_data_i(s3_data_o),
                    .sys_data_o(s3_data_i),
                    .sys_addr_i(s3_addr_o),
                    .sys_sel_i(s3_sel_o),
                    .sys_we_i(s3_we_o),
                    .sys_cyc_i(s3_cyc_o),
                    .sys_stb_i(s3_stb_o),
                    .sys_ack_o(s3_ack_i),
                    .sys_err_o(s3_err_i),
                    .sys_rty_o(s3_rty_i),

                    .async_rst_i(~key[0]),

                    .sys_audio_clk_en(sys_audio_clk_en),

                    .hex0(gpio_a_aux_i[6:0]),
                    .hex1(gpio_a_aux_i[14:8]),
                    .hex2(gpio_a_aux_i[22:16]),
                    .hex3(gpio_a_aux_i[30:24]),

                    .sys_clk_i(sys_clk),
                    .sys_rst_o(sys_rst)
                  );


  //---------------------------------------------------
  // simple pic
  wire        int_o;
  wire [1:0]  irq;

 // qaz_pic
 //   i_qaz_pic
 //   (
 //     .sys_data_i(s4_data_o),
 //     .sys_data_o(s4_data_i),
 //     .sys_addr_i(s4_addr_o),
 //     .sys_sel_i(s4_sel_o),
 //     .sys_we_i(s4_we_o),
 //     .sys_cyc_i(s4_cyc_o),
 //     .sys_stb_i(s4_stb_o),
 //     .sys_ack_o(s4_ack_i),
 //     .sys_err_o(s4_err_i),
 //     .sys_rty_o(s4_rty_i),
//
 //     .int_o(int_o),
 //     .irq(irq),
//
 //     .sys_clk_i(sys_clk),
 //     .sys_rst_i(sys_rst)
 //   );

  //---------------------------------------------------
  // i2c_master_top
  wire i2c_inta_o;
  wire scl_pad_i;
  wire scl_pad_o;
  wire scl_padoen_o;
  wire sda_pad_i;
  wire sda_pad_o;
  wire sda_padoen_o;

  // i2c data out
  wire [7:0] i2c_data_o;

  assign s5_data_i[7:0] = i2c_data_o;
  assign s5_data_i[15:8] = i2c_data_o;
  assign s5_data_i[23:16] = i2c_data_o;
  assign s5_data_i[31:24] = i2c_data_o;

  // i2c data in mux
  reg [7:0] i2c_data_i_mux;

  always @(*)
    case( s5_sel_o )
      4'b0001:  i2c_data_i_mux = s5_data_o[7:0];
      4'b0010:  i2c_data_i_mux = s5_data_o[15:8];
      4'b0100:  i2c_data_i_mux = s5_data_o[23:16];
      4'b1000:  i2c_data_i_mux = s5_data_o[31:24];
      default:  i2c_data_i_mux = s5_data_o[7:0];
    endcase

  // i2c bus error
  reg i2c_bus_error;

  always @(*)
    case( s5_sel_o )
      4'b0001:  i2c_bus_error = 1'b0;
      4'b0010:  i2c_bus_error = 1'b0;
      4'b0100:  i2c_bus_error = 1'b0;
      4'b1000:  i2c_bus_error = 1'b0;
      default:  i2c_bus_error = 1'b1;
    endcase

  // i2c_master_top
  assign s5_err_i = 1'b0;
  assign s5_rty_i = 1'b0;

  i2c_master_top
    i_i2c_master_top
    (
      // wishbone signals
      .wb_clk_i(sys_clk),     // master clock input
      .wb_rst_i(sys_rst),     // synchronous active high reset
      .arst_i(1'b1),       // asynchronous reset
      .wb_adr_i(s5_addr_o[2:0]),     // lower address bits
      .wb_dat_i(i2c_data_i_mux),     // databus input
      .wb_dat_o(i2c_data_o),     // databus output
      .wb_we_i(s5_we_o),      // write enable input
      .wb_stb_i(s5_stb_o),     // stobe/core select signal
      .wb_cyc_i(s5_cyc_o),     // valid bus cycle input
      .wb_ack_o(s5_ack_i),     // bus cycle acknowledge output
      .wb_inta_o(i2c_inta_o),    // interrupt request signal output

      // i2c clock line
      .scl_pad_i(scl_pad_i),       // SCL-line input
      .scl_pad_o(scl_pad_o),       // SCL-line output (always 1'b0)
      .scl_padoen_o(scl_padoen_o),    // SCL-line output enable (active low)

      // i2c data line
      .sda_pad_i(sda_pad_i),       // SDA-line input
      .sda_pad_o(sda_pad_o),       // SDA-line output (always 1'b0)
      .sda_padoen_o(sda_padoen_o)    // SDA-line output enable (active low)
      );


  //---------------------------------------------------
  // i2s_to_wb_tx
  i2s_to_wb_tx i_i2s_to_wb_tx
  (
//     .i2s_data_i(i2s_data_i),
//     .i2s_data_o(i2s_data_o),
//     .i2s_addr_i(i2s_addr_i),
//     .i2s_sel_i(i2s_sel_i),
//     .i2s_we_i(i2s_we_i),
//     .i2s_cyc_i(i2s_cyc_i),
//     .i2s_stb_i(i2s_stb_i),
//     .i2s_ack_o(i2s_ack_o),
//     .i2s_err_o(i2s_err_o),
//     .i2s_rty_o(i2s_rty_o),

    .i2s_sck_i(aud_bclk),
    .i2s_ws_i(aud_daclrck),
    .i2s_sd_o(aud_dacdat)

 //   .i2s_clk_i(sys_clk),
  //  .i2s_rst_i(sys_rst)
  );


  //---------------------------------------------------
  // IO pads
  genvar i;

  // gpio a
  wire [31:0] gpio_a_io_buffer_o;

  generate for( i = 0; i < 32; i = i + 1 )
    begin: gpio_a_pads
      assign gpio_a_io_buffer_o[i] = gpio_a_ext_padoe_o[i] ? gpio_a_ext_pad_o[i] : 1'bz;
    end
  endgenerate

  // gpio b
  wire [31:0] gpio_b_io_buffer_o;

  generate for( i = 0; i < 32; i = i + 1 )
    begin: gpio_b_pads
      assign gpio_b_io_buffer_o[i] = gpio_b_ext_padoe_o[i] ? gpio_b_ext_pad_o[i] : 1'bz;
    end
  endgenerate

  // i2c
  assign i2c_sclk = scl_padoen_o ? 1'bz : scl_pad_o;
  assign i2c_sdat = sda_padoen_o ? 1'bz : sda_pad_o;

  //---------------------------------------------------
  // outputs

  //  All inout port turn to tri-state
  assign  dram_dq     =   16'hzzzz;
  assign  fl_dq       =   8'hzz;
  assign  sd_dat      =   1'bz;
//   assign  i2c_sdat    =   1'bz;
//   assign  aud_adclrck =   1'bz;
//   assign  aud_daclrck =   1'bz;
//   assign  aud_bclk    =   1'bz;

  assign hex0             = gpio_a_io_buffer_o[6:0];
  assign hex1             = gpio_a_io_buffer_o[14:8];
  assign hex2             = gpio_a_io_buffer_o[22:16];
  assign hex3             = gpio_a_io_buffer_o[30:24];
  assign gpio_a_aux_i[7]  = 1'b0;
  assign gpio_a_aux_i[15] = 1'b0;
  assign gpio_a_aux_i[23] = 1'b0;
  assign gpio_a_aux_i[31] = 1'b0;
  assign gpio_a_ext_pad_i = 32'b0;

  assign ledg             = gpio_b_io_buffer_o[7:0];
  assign ledr             = gpio_b_io_buffer_o[17:8];
  assign gpio_b_aux_i     = { 24'b0, fled } ;
  assign gpio_b_ext_pad_i = { key, sw, 18'b0 };

//   assign gpio_1[35]       = ~gpio_b_inta_o;
  assign gpio_1[35] = ~int_o;
  assign irq[0]     = ~gpio_b_inta_o;
//   assign irq[1]     = 1'b1;
  assign irq[1]     = ~i2c_inta_o;

  assign scl_pad_i = i2c_sclk;
  assign sda_pad_i = i2c_sdat;

endmodule


module i2c_master_top(
	wb_clk_i, wb_rst_i, arst_i, wb_adr_i, wb_dat_i, wb_dat_o,
	wb_we_i, wb_stb_i, wb_cyc_i, wb_ack_o, wb_inta_o,
	scl_pad_i, scl_pad_o, scl_padoen_o, sda_pad_i, sda_pad_o, sda_padoen_o, tip_o, DrivingI2cBusOut,
	TP1,
	TP2);

	// parameters

	//
	// inputs & outputs
	//

	// wishbone signals
	input        wb_clk_i;     // master clock input
	input        wb_rst_i;     // synchronous active high reset
	input        arst_i;       // asynchronous reset
	input  [2:0] wb_adr_i;     // lower address bits
	input  [7:0] wb_dat_i;     // databus input
	output [7:0] wb_dat_o;     // databus output
	input        wb_we_i;      // write enable input
	input        wb_stb_i;     // stobe/core select signal
	input        wb_cyc_i;     // valid bus cycle input
	inout        wb_ack_o;     // bus cycle acknowledge output
	output       wb_inta_o;   	// interrupt request signal output
	
	// control signals
	output		tip_o;				// transfer in progress
	output		DrivingI2cBusOut;	// master is driving i2c bus

	reg [7:0] wb_dat_o;
	reg wb_ack_i;
	wire wb_ack_o = wb_ack_i;
	reg wb_inta_o;

	// I2C signals
	// i2c clock line
	input  scl_pad_i;       // SCL-line input
	output scl_pad_o;       // SCL-line output (always 1'b0)
	output scl_padoen_o;    // SCL-line output enable (active low)

	// i2c data line
	input  sda_pad_i;       // SDA-line input
	output sda_pad_o;       // SDA-line output (always 1'b0)
	output sda_padoen_o;    // SDA-line output enable (active low)
	
	// test signal
	output	TP1;
	output	TP2;


	//
	// variable declarations
	//

	// registers
	reg  [15:0] prer; // clock prescale register
	reg  [ 7:0] ctr;  // control register
	reg  [ 7:0] txr;  // transmit register
	wire [ 7:0] rxr;  // receive register
	reg  [ 7:0] cr;   // command register
	wire [ 7:0] sr;   // status register

	// done signal: command completed, clear command register
	wire done;

	// core enable signal
	wire core_en;
	wire ien;

	// status register signals
	wire irxack;
	reg  rxack;       // received aknowledge from slave
	reg  tip;         // transfer in progress
	reg  irq_flag;    // interrupt pending flag
	wire i2c_busy;    // bus busy (start signal detected)
	wire i2c_al;      // i2c bus arbitration lost
	reg  al;          // status register arbitration lost bit

	//
	// module body
	//

	assign tip_o = tip;
	
	// generate internal reset
	wire rst_i = arst_i;

	// generate wishbone signals
	wire wb_wacc = wb_we_i & wb_ack_i;

	// generate acknowledge output signal
	always @(posedge wb_clk_i)
	  wb_ack_i <= #1 wb_cyc_i & wb_stb_i & ~wb_ack_i; // because timing is always honored

	// assign DAT_O
	always @(posedge wb_clk_i)
	begin
	  case (wb_adr_i) // synopsys parallel_case
	    3'b000: wb_dat_o <= #1 prer[ 7:0];
	    3'b001: wb_dat_o <= #1 prer[15:8];
	    3'b010: wb_dat_o <= #1 ctr;
	    3'b011: wb_dat_o <= #1 rxr; // write is transmit register (txr)
	    3'b100: wb_dat_o <= #1 sr;  // write is command register (cr)
	    3'b101: wb_dat_o <= #1 txr;
	    3'b110: wb_dat_o <= #1 cr;
	    3'b111: wb_dat_o <= #1 0;   // reserved
	  endcase
	end

	// generate registers
	always @(posedge wb_clk_i or posedge rst_i)
	  if (rst_i)
	    begin
	        // prer <= #1 16'hffff;
	        // ctr  <= #1  8'h0;
			prer <= #1 16'h0000;
	        ctr  <= #1  8'h80;
	        txr  <= #1  8'h0;
	    end
	  else if (wb_rst_i)
	    begin
	        // prer <= #1 16'hffff;
	        // ctr  <= #1  8'h0;
			prer <= #1 16'h0000;
	        ctr  <= #1  8'h80;
	        txr  <= #1  8'h0;
	    end
	  else
	   if (wb_wacc)
	      case (wb_adr_i) // synopsys parallel_case
	        // 3'b000 : prer [ 7:0] <= #1 wb_dat_i;
	        // 3'b001 : prer [15:8] <= #1 wb_dat_i;
	        // 3'b010 : ctr         <= #1 wb_dat_i;
	         3'b011 : txr         <= #1 wb_dat_i;
	         default: ;
	      endcase

	// generate command register (special case)
	always @(posedge wb_clk_i or posedge rst_i)
	  if (rst_i)
	    cr <= #1 8'h0;
	  else if (wb_rst_i)
	    cr <= #1 8'h0;
	  else if (wb_wacc)
	    begin
	        if (core_en & (wb_adr_i == 3'b100) )
	          cr <= #1 wb_dat_i;
	    end
	  else
	    begin
	        if (done | i2c_al)
	          cr[7:4] <= #1 4'h0;           // clear command bits when done
	                                        // or when aribitration lost
	        cr[2:1] <= #1 2'b0;             // reserved bits
	        cr[0]   <= #1 1'b0;             // clear IRQ_ACK bit
	    end


	// decode command register
	wire sta  = cr[7];
	wire sto  = cr[6];
	wire rd   = cr[5];
	wire wr   = cr[4];
	wire ack  = cr[3];
	wire iack = cr[0];

	// decode control register
	assign core_en = ctr[7];
	assign ien = ctr[6];

	// hookup byte controller block
	i2c_master_byte_ctrl byte_controller (
		.clk      ( wb_clk_i     ),
		.rst      ( wb_rst_i     ),
		.Reset    ( rst_i        ),
		.ena      ( core_en      ),
		.clk_cnt  ( prer         ),
		.start    ( sta          ),
		.stop     ( sto          ),
		.read     ( rd           ),
		.write    ( wr           ),
		.ack_in   ( ack          ),
		.din      ( txr          ),
		.cmd_ack  ( done         ),
		.ack_out  ( irxack       ),
		.dout     ( rxr          ),
		.i2c_busy ( i2c_busy     ),
		.i2c_al   ( i2c_al       ),
		.scl_i    ( scl_pad_i    ),
		.scl_o    ( scl_pad_o    ),
		.scl_oen  ( scl_padoen_o ),
		.sda_i    ( sda_pad_i    ),
		.sda_o    ( sda_pad_o    ),
		.sda_oen  ( sda_padoen_o ),
		.DrivingI2cBusOut (DrivingI2cBusOut),
		.TP1	  ( TP1 		 ),
		.TP2	  ( TP2			 )
	);

	// status register block + interrupt request signal
	always @(posedge wb_clk_i or posedge rst_i)
	  if (rst_i)
	    begin
	        al       <= #1 1'b0;
	        rxack    <= #1 1'b0;
	        tip      <= #1 1'b0;
	        irq_flag <= #1 1'b0;
	    end
	  else if (wb_rst_i)
	    begin
	        al       <= #1 1'b0;
	        rxack    <= #1 1'b0;
	        tip      <= #1 1'b0;
	        irq_flag <= #1 1'b0;
	    end
	  else
	    begin
	        al       <= #1 i2c_al | (al & ~sta);
	        rxack    <= #1 irxack;
	        tip      <= #1 (rd | wr);
	        irq_flag <= #1 (done | i2c_al | irq_flag) & ~iack; // interrupt request flag is always generated
	    end

	// generate interrupt request signals
	always @(posedge wb_clk_i or posedge rst_i)
	  if (rst_i)
	    wb_inta_o <= #1 1'b0;
	  else if (wb_rst_i)
	    wb_inta_o <= #1 1'b0;
	  else
	    wb_inta_o <= #1 irq_flag && ien; // interrupt signal is only generated when IEN (interrupt enable bit is set)

	// assign status register bits
	assign sr[7]   = rxack;
	assign sr[6]   = i2c_busy;
	assign sr[5]   = al;
	assign sr[4:2] = 3'h0; // reserved
	assign sr[1]   = tip;
	assign sr[0]   = irq_flag;

endmodule




// bitcontroller states
`define I2C_CMD_NOP   4'b0000
`define I2C_CMD_START 4'b0001
`define I2C_CMD_STOP  4'b0010
`define I2C_CMD_WRITE 4'b0100
`define I2C_CMD_READ  4'b1000

module i2c_master_byte_ctrl (
	clk, rst, Reset, ena, clk_cnt, start, stop, read, write, ack_in, din,
	cmd_ack, ack_out, dout, i2c_busy, i2c_al, scl_i, scl_o, scl_oen, sda_i, sda_o, sda_oen, DrivingI2cBusOut,
	TP1,
	TP2	);

	//
	// inputs & outputs
	//
	input clk;     // master clock
	input rst;     // synchronous active high reset
	input Reset;  // asynchronous active high reset
	input ena;     // core enable signal

	input [15:0] clk_cnt; // 4x SCL

	// control inputs
	input       start;
	input       stop;
	input       read;
	input       write;
	input       ack_in;
	input [7:0] din;

	// status outputs
	output       cmd_ack;
	reg cmd_ack;
	output       ack_out;
	reg ack_out;
	output       i2c_busy;
	output       i2c_al;
	output [7:0] dout;

	// I2C signals
	input  scl_i;
	output scl_o;
	output scl_oen;
	input  sda_i;
	output sda_o;
	output sda_oen;
	
	// control signals
	output		DrivingI2cBusOut;
	
	// test signals
	output	TP1;
	output	TP2;


	//
	// Variable declarations
	//

	// statemachine
	parameter [5:0] ST_IDLE  = 6'b00_0000;
	parameter [5:0] ST_START = 6'b00_0001;
	parameter [5:0] ST_READ  = 6'b00_0010;
	parameter [5:0] ST_WRITE = 6'b00_0100;
	parameter [5:0] ST_ACK   = 6'b00_1000;
	parameter [5:0] ST_STOP  = 6'b01_0000;
	parameter [5:0] ST_DLWR  = 6'b10_0000;

	// signals for bit_controller
	reg  [3:0] core_cmd;
	reg        core_txd;
	wire       core_ack, core_rxd;

	// signals for shift register
	reg [7:0] sr; //8bit shift register
	reg       shift, ld;

	// signals for state machine
	wire       go;
	reg  [2:0] dcnt;
	wire       cnt_done;

	//
	// Module body
	//
	assign	DrivingI2cBusOut = (core_cmd != `I2C_CMD_READ);

	// hookup bit_controller
	i2c_master_bit_ctrl bit_controller (
		.clk     ( clk      ),
		.rst     ( rst      ),
		.Reset   ( Reset   ),
		.ena     ( ena      ),
		.clk_cnt ( clk_cnt  ),
		.cmd     ( core_cmd ),
		.cmd_ack ( core_ack ),
		.busy    ( i2c_busy ),
		.al      ( i2c_al   ),
		.din     ( core_txd ),
		.dout    ( core_rxd ),
		.scl_i   ( scl_i    ),
		.scl_o   ( scl_o    ),
		.scl_oen ( scl_oen  ),
		.sda_i   ( sda_i    ),
		.sda_o   ( sda_o    ),
		.sda_oen ( sda_oen  ),
		.TP1	 ( TP1		),
		.TP2	 ( TP2		)
	);

	// generate go-signal
	assign go = (read | write | stop) & ~cmd_ack;

	// assign dout output to shift-register
	assign dout = sr;

  //
  // state machine
  //
  reg [5:0] c_state; // synopsys enum_state

	// generate shift register
	// always @(posedge clk or posedge Reset)
	  // if (Reset)
	    // sr <= #1 8'h0;
	  // else if (rst)
	    // sr <= #1 8'h0;
	  // else if (ld)
	    // sr <= #1 din;
	  // else if (shift && clk_cnt !=0)
		// sr <= #1 {sr[6:0], core_rxd}; 
	  // else if (shift && c_state != ST_WRITE)
	    // sr <= #1 {sr[6:0], core_rxd};  

	// generate counter
	always @(posedge clk or posedge Reset)
	  if (Reset)
	    dcnt <= #1 3'h0;
	  else if (rst)
	    dcnt <= #1 3'h0;
	  else if (ld)
	    dcnt <= #1 3'h7;
	  else if (shift)
	    dcnt <= #1 dcnt - 3'h1;

	assign cnt_done = ~(|dcnt);

	always @(posedge clk or posedge Reset)
	  if (Reset)
	    begin
			sr <= #1 8'h0;
	        core_cmd <= #1 `I2C_CMD_NOP;
	        core_txd <= #1 1'b0;
	        shift    <= #1 1'b0;
	        ld       <= #1 1'b0;
	        cmd_ack  <= #1 1'b0;
	        c_state  <= #1 ST_IDLE;
	        ack_out  <= #1 1'b0;
	    end
	  else if (rst | i2c_al)
	   begin
			sr <= #1 8'h0;
	       core_cmd <= #1 `I2C_CMD_NOP;
	       core_txd <= #1 1'b0;
	       shift    <= #1 1'b0;
	       ld       <= #1 1'b0;
	       cmd_ack  <= #1 1'b0;
	       c_state  <= #1 ST_IDLE;
	       ack_out  <= #1 1'b0;
	   end
	else
	  begin
	  if (ld)
	    sr <= #1 din;
	  else if (shift && clk_cnt !=0)
		sr <= #1 {sr[6:0], core_rxd}; 
	  else if (shift && c_state != ST_WRITE)
	    sr <= #1 {sr[6:0], core_rxd};  
	      // initially reset all signals
	      core_txd <= #1 sr[7];
	      shift    <= #1 1'b0;
	      ld       <= #1 1'b0;
	      cmd_ack  <= #1 1'b0;

	      case (c_state) // synopsys full_case parallel_case
	        ST_IDLE:
	          if (go)
	            begin
	                if (start)
	                  begin
	                      c_state  <= #1 ST_START;
	                      core_cmd <= #1 `I2C_CMD_START;
	                  end
	                else if (read)
	                  begin
	                      c_state  <= #1 ST_READ;
	                      core_cmd <= #1 `I2C_CMD_READ;
	                  end
	                else if (write)
	                  begin
	                      c_state  <= #1 ST_DLWR;
	                      core_cmd <= #1 `I2C_CMD_NOP;
	                  end
	                else // stop
	                  begin
	                      c_state  <= #1 ST_STOP;
	                      core_cmd <= #1 `I2C_CMD_STOP;
	                  end

	                ld <= #1 1'b1;
	            end

	        ST_START:
	          if (core_ack)
	            begin
	                if (read)
	                  begin
	                      c_state  <= #1 ST_READ;
	                      core_cmd <= #1 `I2C_CMD_READ;
	                  end
	                else
	                  begin
	                      c_state  <= #1 ST_WRITE;
	                      core_cmd <= #1 `I2C_CMD_WRITE;
	                  end

	                ld <= #1 1'b1;
	            end
				
			ST_DLWR:
			begin
	             c_state  <= #1 ST_WRITE;
	             core_cmd <= #1 `I2C_CMD_WRITE;
	        end

	        ST_WRITE:
	          if (core_ack)
	            if (cnt_done)
	              begin
	                  c_state  <= #1 ST_ACK;
	                  core_cmd <= #1 `I2C_CMD_READ;
	              end
	            else
	              begin
	                  c_state  <= #1 ST_WRITE;       // stay in same state
	                  core_cmd <= #1 `I2C_CMD_WRITE; // write next bit
	                  shift    <= #1 1'b1;
					  if (clk_cnt == 0) sr <= #1 {sr[6:0], core_rxd};
	              end

	        ST_READ:
	          if (core_ack)
	            begin
	                if (cnt_done)
	                  begin
	                      c_state  <= #1 ST_ACK;
	                      core_cmd <= #1 `I2C_CMD_WRITE;
	                  end
	                else
	                  begin
	                      c_state  <= #1 ST_READ;       // stay in same state
	                      core_cmd <= #1 `I2C_CMD_READ; // read next bit
	                  end

	                shift    <= #1 1'b1;
					//sr <= #1 {sr[6:0], core_rxd};
	                core_txd <= #1 ack_in;
	            end

	        ST_ACK:
	          if (core_ack)
	            begin
	               if (stop)
	                 begin
	                     c_state  <= #1 ST_STOP;
	                     core_cmd <= #1 `I2C_CMD_STOP;
	                 end
	               else
	                 begin
	                     c_state  <= #1 ST_IDLE;
	                     core_cmd <= #1 `I2C_CMD_NOP;

	                     // generate command acknowledge signal
	                     cmd_ack  <= #1 1'b1;
	                 end

	                 // assign ack_out output to bit_controller_rxd (contains last received bit)
	                 ack_out <= #1 core_rxd;

	                 core_txd <= #1 1'b1;
					 
					 if (clk_cnt == 0) shift <= #1 1;
	             end
	           else
	             core_txd <= #1 ack_in;

	        ST_STOP:
	          if (core_ack)
	            begin
	                c_state  <= #1 ST_IDLE;
	                core_cmd <= #1 `I2C_CMD_NOP;

	                // generate command acknowledge signal
	                cmd_ack  <= #1 1'b1;
	            end

	      endcase
	  end
endmodule



module i2c_master_bit_ctrl (
    input             clk,      // system clock
    input             rst,      // synchronous active high reset
    input             Reset,    // asynchronous active low reset
    input             ena,      // core enable signal

    input      [15:0] clk_cnt,  // clock prescale value

    input      [ 3:0] cmd,      // command (from byte controller)
    output reg        cmd_ack,  // command complete acknowledge
    output reg        busy,     // i2c bus busy
    output reg        al,       // i2c bus arbitration lost

    input             din,
    output reg        dout,

    input             scl_i,    // i2c clock line input
    output            scl_o,    // i2c clock line output
    output reg        scl_oen,  // i2c clock line output enable (active low)
    input             sda_i,    // i2c data line input
    output            sda_o,    // i2c data line output
    output reg        sda_oen,   // i2c data line output enable (active low)
	output				TP1,
	output				TP2
);


    //
    // variable declarations
    //

    reg [ 1:0] cSCL, cSDA;      // capture SCL and SDA
    reg [ 2:0] fSCL, fSDA;      // SCL and SDA filter inputs
    reg        sSCL, sSDA;      // filtered and synchronized SCL and SDA inputs
    reg        dSCL, dSDA;      // delayed versions of sSCL and sSDA
    reg        dscl_oen;        // delayed scl_oen
    reg        sda_chk;         // check SDA output (Multi-master arbitration)
    reg        clk_en;          // clock generation signals
    reg        slave_wait;      // slave inserts wait states
    reg [15:0] cnt;             // clock divider counter (synthesis)
    reg [13:0] filter_cnt;      // clock divider for filter

	assign TP1 = cnt[0];
	assign TP2 = cnt[1];

    // state machine variable
    reg [17:0] c_state; // synopsys enum_state

    //
    // module body
    //

    // whenever the slave is not ready it can delay the cycle by pulling SCL low
    // delay scl_oen
    always @(posedge clk)
      dscl_oen <= #1 scl_oen;

    // slave_wait is asserted when master wants to drive SCL high, but the slave pulls it low
    // slave_wait remains asserted until the slave releases SCL
    always @(posedge clk or posedge Reset)
      if (Reset) slave_wait <= 1'b0;
      else         slave_wait <= (scl_oen & ~dscl_oen & ~sSCL) | (slave_wait & ~sSCL);

    // master drives SCL high, but another master pulls it low
    // master start counting down its low cycle now (clock synchronization)
    wire scl_sync   = dSCL & ~sSCL & scl_oen;


    // generate clk enable signal
    always @(posedge clk or posedge Reset)
      if (Reset)
      begin
          cnt    <= #1 16'h0;
          clk_en <= #1 1'b1;
      end
      else if (rst || ~|cnt || !ena || scl_sync)
      begin
          cnt    <= #1 clk_cnt;
          clk_en <= #1 1'b1;
      end
      else if (slave_wait)
      begin
          cnt    <= #1 cnt;
          clk_en <= #1 1'b0;    
      end
      else
      begin
          cnt    <= #1 cnt - 16'h1;
          clk_en <= #1 1'b0;
      end


    // generate bus status controller

    // capture SDA and SCL
    // reduce metastability risk
    always @(posedge clk or posedge Reset)
      if (Reset)
      begin
          cSCL <= #1 2'b00;
          cSDA <= #1 2'b00;
      end
      else if (rst)
      begin
          cSCL <= #1 2'b00;
          cSDA <= #1 2'b00;
      end
      else
      begin
          cSCL <= {cSCL[0],scl_i};
          cSDA <= {cSDA[0],sda_i};
      end


    // filter SCL and SDA signals; (attempt to) remove glitches
    always @(posedge clk or posedge Reset)
      if      (Reset     ) filter_cnt <= 14'h0;
      else if (rst || !ena ) filter_cnt <= 14'h0;
      else if (~|filter_cnt) filter_cnt <= clk_cnt >> 2; //16x I2C bus frequency
      else                   filter_cnt <= filter_cnt -1;


    always @(posedge clk or posedge Reset)
      if (Reset)
      begin
          fSCL <= 3'b111;
          fSDA <= 3'b111;
      end
      else if (rst)
      begin
          fSCL <= 3'b111;
          fSDA <= 3'b111;
      end
      else if (~|filter_cnt)
      begin
          fSCL <= {fSCL[1:0],cSCL[1]};
          fSDA <= {fSDA[1:0],cSDA[1]};
      end


    // generate filtered SCL and SDA signals
    always @(posedge clk or posedge Reset)
      if (Reset)
      begin
          sSCL <= #1 1'b1;
          sSDA <= #1 1'b1;

          dSCL <= #1 1'b1;
          dSDA <= #1 1'b1;
      end
      else if (rst)
      begin
          sSCL <= #1 1'b1;
          sSDA <= #1 1'b1;

          dSCL <= #1 1'b1;
          dSDA <= #1 1'b1;
      end
      else
      begin
          sSCL <= #1 &fSCL[2:1] | &fSCL[1:0] | (fSCL[2] & fSCL[0]);
          sSDA <= #1 &fSDA[2:1] | &fSDA[1:0] | (fSDA[2] & fSDA[0]);

          dSCL <= #1 sSCL;
          dSDA <= #1 sSDA;
      end

    // detect start condition => detect falling edge on SDA while SCL is high
    // detect stop condition => detect rising edge on SDA while SCL is high
    reg sta_condition;
    reg sto_condition;
    always @(posedge clk or posedge Reset)
      if (Reset)
      begin
          sta_condition <= #1 1'b0;
          sto_condition <= #1 1'b0;
      end
      else if (rst)
      begin
          sta_condition <= #1 1'b0;
          sto_condition <= #1 1'b0;
      end
      else
      begin
          sta_condition <= #1 ~sSDA &  dSDA & sSCL;
          sto_condition <= #1  sSDA & ~dSDA & sSCL;
      end


    // generate i2c bus busy signal
    always @(posedge clk or posedge Reset)
      if      (Reset) busy <= #1 1'b0;
      else if (rst  ) busy <= #1 1'b0;
      else              busy <= #1 (sta_condition | busy) & ~sto_condition;


    // generate arbitration lost signal
    // aribitration lost when:
    // 1) master drives SDA high, but the i2c bus is low
    // 2) stop detected while not requested
    reg cmd_stop;
    always @(posedge clk or posedge Reset)
      if (Reset)
          cmd_stop <= #1 1'b0;
      else if (rst)
          cmd_stop <= #1 1'b0;
      else if (clk_en)
          cmd_stop <= #1 cmd == `I2C_CMD_STOP;

    always @(posedge clk or posedge Reset)
      if (Reset)
          al <= #1 1'b0;
      else if (rst)
          al <= #1 1'b0;
      else
          al <= 0;
          // al <= #1 (sda_chk & ~sSDA & sda_oen) | (|c_state & sto_condition & ~cmd_stop);


    // generate dout signal (store SDA on rising edge of SCL)
    always @(posedge clk)
      if (sSCL & ~dSCL) dout <= #1 sSDA;


    // generate statemachine

    // nxt_state decoder
    parameter [17:0] idle    = 18'b0_0000_0000_0000_0000;
    parameter [17:0] start_a = 18'b0_0000_0000_0000_0001;
    parameter [17:0] start_b = 18'b0_0000_0000_0000_0010;
    parameter [17:0] start_c = 18'b0_0000_0000_0000_0100;
    parameter [17:0] start_d = 18'b0_0000_0000_0000_1000;
    parameter [17:0] start_e = 18'b0_0000_0000_0001_0000;
    parameter [17:0] stop_a  = 18'b0_0000_0000_0010_0000;
    parameter [17:0] stop_b  = 18'b0_0000_0000_0100_0000;
    parameter [17:0] stop_c  = 18'b0_0000_0000_1000_0000;
    parameter [17:0] stop_d  = 18'b0_0000_0001_0000_0000;
    parameter [17:0] rd_a    = 18'b0_0000_0010_0000_0000;
    parameter [17:0] rd_b    = 18'b0_0000_0100_0000_0000;
    parameter [17:0] rd_c    = 18'b0_0000_1000_0000_0000;
    parameter [17:0] rd_d    = 18'b0_0001_0000_0000_0000;
    parameter [17:0] wr_a    = 18'b0_0010_0000_0000_0000;
    parameter [17:0] wr_b    = 18'b0_0100_0000_0000_0000;
    parameter [17:0] wr_c    = 18'b0_1000_0000_0000_0000;
    parameter [17:0] wr_d    = 18'b1_0000_0000_0000_0000;

    always @(posedge clk or posedge Reset)
      if (Reset)
      begin
          c_state <= #1 idle;
          cmd_ack <= #1 1'b0;
          scl_oen <= #1 1'b1;
          sda_oen <= #1 1'b1;
          sda_chk <= #1 1'b0;
      end
      else if (rst | al)
      begin
          c_state <= #1 idle;
          cmd_ack <= #1 1'b0;
          scl_oen <= #1 1'b1;
          sda_oen <= #1 1'b1;
          sda_chk <= #1 1'b0;
      end
      else
      begin
          cmd_ack   <= #1 1'b0; // default no command acknowledge + assert cmd_ack only 1clk cycle

          if (clk_en)
              case (c_state) // synopsys full_case parallel_case
                    // idle state
                    idle:
                    begin
                        case (cmd) // synopsys full_case parallel_case
                             `I2C_CMD_START: c_state <= #1 start_a;
                             `I2C_CMD_STOP:  c_state <= #1 stop_a;
                             `I2C_CMD_WRITE: c_state <= #1 wr_a;
                             `I2C_CMD_READ:  c_state <= #1 rd_a;
                             default:        c_state <= #1 idle;
                        endcase

                        scl_oen <= #1 scl_oen; // keep SCL in same state
                        sda_oen <= #1 sda_oen; // keep SDA in same state
                        sda_chk <= #1 1'b0;    // don't check SDA output
                    end

                    // start
                    start_a:
                    begin
                        c_state <= #1 start_b;
                        scl_oen <= #1 scl_oen; // keep SCL in same state
                        sda_oen <= #1 1'b1;    // set SDA high
                        sda_chk <= #1 1'b0;    // don't check SDA output
                    end

                    start_b:
                    begin
                        c_state <= #1 start_c;
                        scl_oen <= #1 1'b1; // set SCL high
                        sda_oen <= #1 1'b1; // keep SDA high
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    start_c:
                    begin
                        c_state <= #1 start_d;
                        scl_oen <= #1 1'b1; // keep SCL high
                        sda_oen <= #1 1'b0; // set SDA low
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    start_d:
                    begin
                        c_state <= #1 start_e;
                        scl_oen <= #1 1'b1; // keep SCL high
                        sda_oen <= #1 1'b0; // keep SDA low
                        sda_chk <= #1 1'b0; // don't check SDA output
						if(clk_cnt == 0) cmd_ack <= #1 1'b1;
                    end

                    start_e:
                    begin
                        c_state <= #1 idle;
                        if(clk_cnt == 0) cmd_ack <= #1 1'b0;
						else cmd_ack <= #1 1'b1;
                        scl_oen <= #1 1'b0; // set SCL low
                        sda_oen <= #1 1'b0; // keep SDA low
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    // stop
                    stop_a:
                    begin
                        c_state <= #1 stop_b;
                        scl_oen <= #1 1'b0; // keep SCL low
                        sda_oen <= #1 1'b0; // set SDA low
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    stop_b:
                    begin
                        c_state <= #1 stop_c;
                        scl_oen <= #1 1'b1; // set SCL high
                        sda_oen <= #1 1'b0; // keep SDA low
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    stop_c:
                    begin
                        c_state <= #1 stop_d;
						cmd_ack <= #1 1'b1;
                        scl_oen <= #1 1'b1; // keep SCL high
                        sda_oen <= #1 1'b0; // keep SDA low
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    stop_d:
                    begin
                        c_state <= #1 idle;
						cmd_ack <= #1 1'b0;
                        scl_oen <= #1 1'b1; // keep SCL high
                        sda_oen <= #1 1'b1; // set SDA high
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    // read
                    rd_a:
                    begin
                        c_state <= #1 rd_b;
                        scl_oen <= #1 1'b0; // keep SCL low
                        sda_oen <= #1 1'b1; // tri-state SDA
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    rd_b:
                    begin
                        c_state <= #1 rd_c;
                        scl_oen <= #1 1'b1; // set SCL high
                        sda_oen <= #1 1'b1; // keep SDA tri-stated
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    rd_c:
                    begin
                        c_state <= #1 rd_d;
                        scl_oen <= #1 1'b1; // keep SCL high
                        sda_oen <= #1 1'b1; // keep SDA tri-stated
                        sda_chk <= #1 1'b0; // don't check SDA output
						if (clk_cnt == 0) cmd_ack <= #1 1'b1;
                    end

                    rd_d:
                    begin
                        c_state <= #1 idle;
						if (clk_cnt == 0) cmd_ack <= #1 0;
						else cmd_ack <= #1 1;
                        scl_oen <= #1 1'b0; // set SCL low
                        sda_oen <= #1 1'b1; // keep SDA tri-stated
                        sda_chk <= #1 1'b0; // don't check SDA output
                    end

                    // write
                    wr_a:
                    begin
                        c_state <= #1 wr_b;
                        scl_oen <= #1 1'b0; // keep SCL low
                        sda_oen <= #1 din;  // set SDA
                        sda_chk <= #1 1'b0; // don't check SDA output (SCL low)
                    end

                    wr_b:
                    begin
                        c_state <= #1 wr_c;
                        scl_oen <= #1 1'b1; // set SCL high
                        sda_oen <= #1 din;  // keep SDA
                        sda_chk <= #1 1'b0; // don't check SDA output yet
                                            // allow some time for SDA and SCL to settle
                    end

                    wr_c:
                    begin
                        c_state <= #1 wr_d;
                        scl_oen <= #1 1'b1; // keep SCL high
                        sda_oen <= #1 din;
                        sda_chk <= #1 1'b1; // check SDA output
						if (clk_cnt == 0) cmd_ack <= #1 1'b1; 
                    end

                    wr_d:
                    begin
                        c_state <= #1 idle;
						if (clk_cnt == 0) cmd_ack <= #1 0;  
						else cmd_ack <= #1 1;
                        scl_oen <= #1 1'b0; // set SCL low
                        sda_oen <= #1 din;
                        sda_chk <= #1 1'b0; // don't check SDA output (SCL low)
                    end

              endcase
      end


    // assign scl and sda output (always gnd)
    assign scl_o = 1'b0;
    assign sda_o = 1'b0;

endmodule


module
  i2s_to_wb_tx
  (
    input   [31:0]  fifo_right_data,
    input   [31:0]  fifo_left_data,
    input           fifo_ready,
    
    output reg      fifo_ack,
    
    output          i2s_ws_edge,
  
    input           i2s_enable,
    input           i2s_sck_i,
    input           i2s_ws_i,
    output          i2s_sd_o
  );

  //---------------------------------------------------
  // fifo_ready edge detection
  reg [2:0] fifo_ready_r;
  wire      fifo_ready_s = fifo_ready_r[1];

  always @(posedge i2s_sck_i)
    fifo_ready_r <= {fifo_ready_r[1:0], fifo_ready};

  wire fifo_ready_rise_edge = (fifo_ready_r[1] ^ fifo_ready_r[2]) & fifo_ready_r[1];


  //---------------------------------------------------
  // i2s_ws_i edge detection
  reg [1:0] i2s_ws_i_r;

  always @(posedge i2s_sck_i)
    i2s_ws_i_r <= {i2s_ws_i_r[0], i2s_ws_i};

  wire i2s_ws_rise_edge;
  wire i2s_ws_fall_edge;

  assign i2s_ws_rise_edge = (i2s_ws_i_r[0] ^ i2s_ws_i_r[1]) & i2s_ws_i_r[0];  // right
  assign i2s_ws_fall_edge = (i2s_ws_i_r[0] ^ i2s_ws_i_r[1]) & ~i2s_ws_i_r[0]; // left


  //---------------------------------------------------
  //  data out shift reg
  reg  [31:0] sd_r;
  wire [31:0] sd_w = i2s_ws_i ? fifo_right_data : fifo_left_data;

  always @(negedge i2s_sck_i)
    if( i2s_ws_edge )
      sd_r <= sd_w;
    else
      sd_r <= {sd_r[30:0], 1'b0};

  //---------------------------------------------------
  // ack flop
  always @(posedge i2s_sck_i)
    if( fifo_ready_s & i2s_ws_edge )
      fifo_ack <= 1'b1;
    else if( ~fifo_ready_s )
      fifo_ack <= 1'b0;
  
  
  //---------------------------------------------------
  // assign outputs

  assign i2s_sd_o     = sd_r[31];
  assign i2s_ws_edge  = i2s_ws_rise_edge | i2s_ws_fall_edge;

endmodule

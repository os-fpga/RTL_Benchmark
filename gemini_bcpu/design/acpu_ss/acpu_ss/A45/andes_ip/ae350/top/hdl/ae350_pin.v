// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "ae350_config.vh"
`include "ae350_const.vh"

`ifdef AE350_SPI1_SUPPORT
	`define _AE350_SPI_SUPPORT
`elsif AE350_SPI2_SUPPORT
	`define _AE350_SPI_SUPPORT
`endif

`ifdef _AE350_SPI_SUPPORT
	`include "atcspi200_config.vh"
	`include "atcspi200_const.vh"
	`undef _AE350_SPI_SUPPORT
`endif

`ifdef AE350_GPIO_SUPPORT
	`include "atcgpio100_config.vh"
	`include "atcgpio100_const.vh"
`endif
`ifdef AE350_PIT_SUPPORT
	`include "atcpit100_config.vh"
	`include "atcpit100_const.vh"
`endif

module ae350_pin (
	  X_hw_rstn,
	  T_hw_rstn,
	  X_por_b,
	  T_por_b,
`ifdef PLATFORM_DEBUG_PORT
	  X_tms,
   `ifdef PLATFORM_JTAG_TWOWIRE
   `else
	  X_trst,
	  X_tdi,
	  X_tdo,
   `endif
	  pin_tms_in,
	  pin_tms_out,
	  pin_tms_out_en,
   `ifdef PLATFORM_JTAG_TWOWIRE
   `else
	  pin_trst_in,
	  pin_trst_out,
	  pin_trst_out_en,
	  pin_tdi_in,
	  pin_tdi_out,
	  pin_tdi_out_en,
	  pin_tdo_in,
	  pin_tdo_out,
	  pin_tdo_out_en,
   `endif
   `ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
	  X_secure_mode,
	  T_secure_mode,
   `endif
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  X_spi1_holdn,
	  X_spi1_wpn,
   `endif
	  X_spi1_clk,
	  X_spi1_csn,
	  X_spi1_miso,
	  X_spi1_mosi,
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE350_SPI2_SUPPORT
	  X_spi2_holdn,
	  X_spi2_wpn,
   `endif
`endif
`ifdef AE350_SPI2_SUPPORT
	  X_spi2_clk,
	  X_spi2_csn,
	  X_spi2_miso,
	  X_spi2_mosi,
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  spi1_holdn_in,
	  spi1_wpn_in,
   `endif
	  spi1_clk_in,
	  spi1_csn_in,
	  spi1_miso_in,
	  spi1_mosi_in,
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE350_SPI2_SUPPORT
	  spi2_holdn_in,
	  spi2_wpn_in,
   `endif
`endif
`ifdef AE350_SPI2_SUPPORT
	  spi2_clk_in,
	  spi2_csn_in,
	  spi2_miso_in,
	  spi2_mosi_in,
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  spi1_holdn_out,
	  spi1_holdn_oe,
	  spi1_wpn_out,
	  spi1_wpn_oe,
   `endif
	  spi1_clk_out,
	  spi1_clk_oe,
	  spi1_csn_out,
	  spi1_csn_oe,
	  spi1_miso_out,
	  spi1_miso_oe,
	  spi1_mosi_out,
	  spi1_mosi_oe,
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE350_SPI2_SUPPORT
	  spi2_holdn_out,
	  spi2_holdn_oe,
	  spi2_wpn_out,
	  spi2_wpn_oe,
   `endif
`endif
`ifdef AE350_SPI2_SUPPORT
	  spi2_clk_out,
	  spi2_clk_oe,
	  spi2_csn_out,
	  spi2_csn_oe,
	  spi2_miso_out,
	  spi2_miso_oe,
	  spi2_mosi_out,
	  spi2_mosi_oe,
`endif
`ifdef AE350_I2C_SUPPORT
	  X_i2c_scl,
	  X_i2c_sda,
	  i2c_scl_in,
	  i2c_sda_in,
	  i2c_scl,
	  i2c_sda,
`endif
`ifdef AE350_UART1_SUPPORT
	  X_uart1_txd,
	  X_uart1_rxd,
   `ifdef AE350_UART2_SUPPORT
      `ifdef NDS_FPGA
      `else
	  X_uart1_ctsn,
	  X_uart1_rtsn,
      `endif
   `else
	  X_uart1_ctsn,
	  X_uart1_rtsn,
   `endif
	  X_uart1_dsrn,
	  X_uart1_dcdn,
	  X_uart1_rin,
	  X_uart1_dtrn,
	  X_uart1_out1n,
	  X_uart1_out2n,
`endif
`ifdef AE350_UART2_SUPPORT
	  X_uart2_txd,
	  X_uart2_rxd,
   `ifdef NDS_FPGA
   `else
	  X_uart2_ctsn,
	  X_uart2_rtsn,
	  X_uart2_dcdn,
	  X_uart2_dsrn,
	  X_uart2_rin,
	  X_uart2_dtrn,
	  X_uart2_out1n,
	  X_uart2_out2n,
   `endif
`endif
`ifdef AE350_UART1_SUPPORT
	  uart1_txd,
	  uart1_rtsn,
	  uart1_rxd,
	  uart1_ctsn,
	  uart1_dsrn,
	  uart1_dcdn,
	  uart1_rin,
	  uart1_dtrn,
	  uart1_out1n,
	  uart1_out2n,
`endif
`ifdef AE350_UART2_SUPPORT
	  uart2_txd,
	  uart2_rtsn,
	  uart2_rxd,
	  uart2_ctsn,
	  uart2_dcdn,
	  uart2_dsrn,
	  uart2_rin,
	  uart2_dtrn,
	  uart2_out1n,
	  uart2_out2n,
`endif
`ifdef AE350_PIT_SUPPORT
	  X_pwm_ch0,
	  ch0_pwm,
	  ch0_pwmoe,
   `ifdef ATCPIT100_CH1_SUPPORT
	  X_pwm_ch1,
	  ch1_pwm,
	  ch1_pwmoe,
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
	  X_pwm_ch2,
	  ch2_pwm,
	  ch2_pwmoe,
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
	  X_pwm_ch3,
	  ch3_pwm,
	  ch3_pwmoe,
   `endif
`endif
`ifdef NDS_FPGA
	  X_flash_cs,
	  X_flash_dir,
`endif
`ifdef AE350_GPIO_SUPPORT
	  X_gpio,
	  gpio_in,
	  gpio_oe,
	  gpio_out,
   `ifdef ATCGPIO100_PULL_SUPPORT
	  gpio_pulldown,
	  gpio_pullup,
   `endif
`endif
`ifdef NDS_FPGA
`else
	  X_oschio,
`endif
	  X_oschin,
	  T_osch

);

inout		X_hw_rstn;
output		T_hw_rstn;

inout		X_por_b;
output		T_por_b;

`ifdef PLATFORM_DEBUG_PORT
inout		X_tms;
`ifdef	PLATFORM_JTAG_TWOWIRE
`else
inout		X_trst;
inout		X_tdi;
inout		X_tdo;
`endif

output          pin_tms_in;
input           pin_tms_out;
input           pin_tms_out_en;
`ifdef	PLATFORM_JTAG_TWOWIRE
`else
output          pin_trst_in;
input           pin_trst_out;
input           pin_trst_out_en;
output          pin_tdi_in;
input           pin_tdi_out;
input           pin_tdi_out_en;
output          pin_tdo_in;
input           pin_tdo_out;
input           pin_tdo_out_en;
`endif

`ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
inout	[1:0]	X_secure_mode;
output	[1:0]	T_secure_mode;
`endif

`endif


`ifdef AE350_SPI1_SUPPORT
`ifdef ATCSPI200_QUADSPI_SUPPORT
inout          	X_spi1_holdn;
inout		X_spi1_wpn;
`endif
inout		X_spi1_clk;
inout		X_spi1_csn;
inout		X_spi1_miso;
inout		X_spi1_mosi;
`endif
`ifdef AE350_SPI2_SUPPORT
`ifdef ATCSPI200_QUADSPI_SUPPORT
inout		X_spi2_holdn;
inout		X_spi2_wpn;
`endif
inout		X_spi2_clk;
inout		X_spi2_csn;
inout		X_spi2_miso;
inout		X_spi2_mosi;
`endif
`ifdef AE350_SPI1_SUPPORT
`ifdef ATCSPI200_QUADSPI_SUPPORT
output		spi1_holdn_in;
output		spi1_wpn_in;
`endif
output		spi1_clk_in;
output		spi1_csn_in;
output		spi1_miso_in;
output		spi1_mosi_in;
`endif
`ifdef AE350_SPI2_SUPPORT
`ifdef ATCSPI200_QUADSPI_SUPPORT
output		spi2_holdn_in;
output		spi2_wpn_in;
`endif
output		spi2_clk_in;
output		spi2_csn_in;
output		spi2_miso_in;
output		spi2_mosi_in;
`endif
`ifdef AE350_SPI1_SUPPORT
`ifdef ATCSPI200_QUADSPI_SUPPORT
input          	spi1_holdn_out;
input		spi1_holdn_oe;
input		spi1_wpn_out;
input		spi1_wpn_oe;
`endif
input		spi1_clk_out;
input		spi1_clk_oe;
input		spi1_csn_out;
input		spi1_csn_oe;
input		spi1_miso_out;
input		spi1_miso_oe;
input		spi1_mosi_out;
input		spi1_mosi_oe;
`endif
`ifdef AE350_SPI2_SUPPORT
`ifdef ATCSPI200_QUADSPI_SUPPORT
input		spi2_holdn_out;
input		spi2_holdn_oe;
input		spi2_wpn_out;
input		spi2_wpn_oe;
`endif
input		spi2_clk_out;
input		spi2_clk_oe;
input		spi2_csn_out;
input		spi2_csn_oe;
input		spi2_miso_out;
input		spi2_miso_oe;
input		spi2_mosi_out;
input		spi2_mosi_oe;
`endif

`ifdef AE350_I2C_SUPPORT
inout		X_i2c_scl;
inout		X_i2c_sda;
output		i2c_scl_in;
output		i2c_sda_in;
input		i2c_scl;
input		i2c_sda;
`endif



`ifdef AE350_UART1_SUPPORT
inout		X_uart1_txd;
inout		X_uart1_rxd;
`ifdef AE350_UART2_SUPPORT
	`ifndef NDS_FPGA
	inout		X_uart1_ctsn;
	inout		X_uart1_rtsn;
	`endif
`else
inout		X_uart1_ctsn;
inout		X_uart1_rtsn;
`endif
inout		X_uart1_dsrn;
inout		X_uart1_dcdn;
inout		X_uart1_rin;
inout		X_uart1_dtrn;
inout		X_uart1_out1n;
inout		X_uart1_out2n;
`endif
`ifdef AE350_UART2_SUPPORT
inout		X_uart2_txd;
inout		X_uart2_rxd;
`ifdef NDS_FPGA
`else
inout		X_uart2_ctsn;
inout		X_uart2_rtsn;
inout		X_uart2_dcdn;
inout		X_uart2_dsrn;
inout		X_uart2_rin;
inout		X_uart2_dtrn;
inout		X_uart2_out1n;
inout		X_uart2_out2n;
`endif
`endif
`ifdef AE350_UART1_SUPPORT
input		uart1_txd;
input		uart1_rtsn;
output		uart1_rxd;
output		uart1_ctsn;
output          uart1_dsrn;
output          uart1_dcdn;
output          uart1_rin;
input           uart1_dtrn;
input           uart1_out1n;
input           uart1_out2n;
`endif
`ifdef AE350_UART2_SUPPORT
input		uart2_txd;
input		uart2_rtsn;
output		uart2_rxd;
output		uart2_ctsn;
output          uart2_dcdn;
output          uart2_dsrn;
output          uart2_rin;
input           uart2_dtrn;
input           uart2_out1n;
input           uart2_out2n;
`endif

`ifdef AE350_PIT_SUPPORT
inout		   X_pwm_ch0;
input              ch0_pwm;
input              ch0_pwmoe;
	`ifdef ATCPIT100_CH1_SUPPORT
inout		   X_pwm_ch1;
input              ch1_pwm;
input              ch1_pwmoe;
	`endif
	`ifdef ATCPIT100_CH2_SUPPORT
inout		   X_pwm_ch2;
input              ch2_pwm;
input              ch2_pwmoe;
	`endif
	`ifdef ATCPIT100_CH3_SUPPORT
inout		   X_pwm_ch3;
input              ch3_pwm;
input              ch3_pwmoe;
	`endif
`endif

`ifdef NDS_FPGA
inout              X_flash_cs;
inout              X_flash_dir;
`endif









`ifdef AE350_GPIO_SUPPORT
inout	[31:0]	X_gpio;
output	[31:0]	gpio_in;
input	[31:0]	gpio_oe;
input	[31:0]	gpio_out;
	`ifdef ATCGPIO100_PULL_SUPPORT
input	[31:0]	gpio_pulldown;
input	[31:0]	gpio_pullup;
	`endif
`endif

`ifdef NDS_FPGA
wire		X_oschio;
`else
inout		X_oschio;
`endif
input		X_oschin;
output		T_osch;

nds_osc_pad   osch_pad		(.O(T_osch), .I(X_oschin), .IO(X_oschio));

wire 	hw_rstn;
nds_inout_pad hw_rstn_pad      (.O(hw_rstn), .I(1'b0), .IO(X_hw_rstn), .E(1'b0), .PU(1'b0), .PD(1'b0));

`ifdef NDS_BOARD_VCU118
    assign T_hw_rstn = ~hw_rstn;
`else
    assign T_hw_rstn =  hw_rstn;
`endif


nds_inout_pad porb_pad		(.O(T_por_b), .I(1'b0), .IO(X_por_b), .E(1'b0), .PU(1'b0), .PD(1'b0));

`ifdef PLATFORM_DEBUG_PORT
nds_inout_pad jtag_tms_pad	(.O(pin_tms_in),  .I(pin_tms_out),  .IO(X_tms),  .E(pin_tms_out_en),  .PU(1'b1), .PD(1'b0));
`ifndef PLATFORM_JTAG_TWOWIRE
nds_inout_pad jtag_trst_pad	(.O(pin_trst_in), .I(pin_trst_out), .IO(X_trst), .E(pin_trst_out_en), .PU(1'b0), .PD(1'b0));
nds_inout_pad jtag_tdi_pad	(.O(pin_tdi_in),  .I(pin_tdi_out),  .IO(X_tdi),  .E(pin_tdi_out_en),  .PU(1'b0), .PD(1'b0));
nds_inout_pad jtag_tdo_pad	(.O(pin_tdo_in),  .I(pin_tdo_out),  .IO(X_tdo),  .E(pin_tdo_out_en),  .PU(1'b0), .PD(1'b0));
`endif

`ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
nds_inout_pad secure_mode_pad_0	(.O(T_secure_mode[0]),  .I(1'b0),  .IO(X_secure_mode[0]),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad secure_mode_pad_1	(.O(T_secure_mode[1]),  .I(1'b0),  .IO(X_secure_mode[1]),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
`endif


`endif

`ifdef AE350_SPI1_SUPPORT
`ifdef ATCSPI200_QUADSPI_SUPPORT
nds_inout_pad spi1_holdn_pad	(.O(spi1_holdn_in), .I(spi1_holdn_out), .IO(X_spi1_holdn), .E(spi1_holdn_oe), .PU(1'b0), .PD(1'b0));
nds_inout_pad spi1_wpn_pad	(.O(spi1_wpn_in),   .I(spi1_wpn_out),   .IO(X_spi1_wpn),   .E(spi1_wpn_oe),   .PU(1'b0), .PD(1'b0));
`endif
nds_inout_pad spi1_clk_pad	(.O(spi1_clk_in),   .I(spi1_clk_out),   .IO(X_spi1_clk),   .E(spi1_clk_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi1_csn_pad	(.O(spi1_csn_in),   .I(spi1_csn_out),   .IO(X_spi1_csn),   .E(spi1_csn_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi1_miso_pad	(.O(spi1_miso_in),  .I(spi1_miso_out),  .IO(X_spi1_miso),  .E(spi1_miso_oe),  .PU(1'b0), .PD(1'b0));
nds_inout_pad spi1_mosi_pad	(.O(spi1_mosi_in),  .I(spi1_mosi_out),  .IO(X_spi1_mosi),  .E(spi1_mosi_oe),  .PU(1'b0), .PD(1'b0));
`endif

`ifdef AE350_SPI2_SUPPORT
`ifdef ATCSPI200_QUADSPI_SUPPORT
nds_inout_pad spi2_holdn_pad	(.O(spi2_holdn_in), .I(spi2_holdn_out), .IO(X_spi2_holdn), .E(spi2_holdn_oe), .PU(1'b0), .PD(1'b0));
nds_inout_pad spi2_wpn_pad	(.O(spi2_wpn_in),   .I(spi2_wpn_out),   .IO(X_spi2_wpn),   .E(spi2_wpn_oe),   .PU(1'b0), .PD(1'b0));
`endif
nds_inout_pad spi2_clk_pad	(.O(spi2_clk_in),   .I(spi2_clk_out),   .IO(X_spi2_clk),   .E(spi2_clk_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi2_csn_pad	(.O(spi2_csn_in),   .I(spi2_csn_out),   .IO(X_spi2_csn),   .E(spi2_csn_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi2_miso_pad	(.O(spi2_miso_in),  .I(spi2_miso_out),  .IO(X_spi2_miso),  .E(spi2_miso_oe),  .PU(1'b0), .PD(1'b0));
nds_inout_pad spi2_mosi_pad	(.O(spi2_mosi_in),  .I(spi2_mosi_out),  .IO(X_spi2_mosi),  .E(spi2_mosi_oe),  .PU(1'b0), .PD(1'b0));
`endif

`ifdef AE350_I2C_SUPPORT
nds_inout_pad i2c_scl_pad	(.O(i2c_scl_in),  .I(1'b0),  .IO(X_i2c_scl),  .E(~i2c_scl),  .PU(1'b0), .PD(1'b0));
nds_inout_pad i2c_sda_pad	(.O(i2c_sda_in),  .I(1'b0),  .IO(X_i2c_sda),  .E(~i2c_sda),  .PU(1'b0), .PD(1'b0));
`endif

`ifdef AE350_UART1_SUPPORT
nds_inout_pad uart1_txd_pad	(.O(),  	 .I(uart1_txd),  .IO(X_uart1_txd),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_dtrn_pad	(.O(),  	 .I(uart1_dtrn),  .IO(X_uart1_dtrn),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_out1n_pad	(.O(),  	 .I(uart1_out1n), .IO(X_uart1_out1n), .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_out2n_pad	(.O(),  	 .I(uart1_out2n), .IO(X_uart1_out2n), .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_rxd_pad	(.O(uart1_rxd),  .I(1'b0),       .IO(X_uart1_rxd),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_dcdn_pad	(.O(uart1_dcdn),  .I(1'b0),       .IO(X_uart1_dcdn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_dsrn_pad	(.O(uart1_dsrn),  .I(1'b0),       .IO(X_uart1_dsrn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_rin_pad	(.O(uart1_rin),   .I(1'b0),       .IO(X_uart1_rin),   .E(1'b0),  .PU(1'b0), .PD(1'b0));
`ifdef AE350_UART2_SUPPORT
	`ifdef NDS_FPGA
	assign	uart1_ctsn = uart2_rtsn;
	assign	uart2_ctsn = uart1_rtsn;
	`else
	nds_inout_pad uart1_ctsn_pad	(.O(uart1_ctsn),  .I(1'b0),       .IO(X_uart1_ctsn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
	nds_inout_pad uart1_rtsn_pad	(.O(),  	 .I(uart1_rtsn),  .IO(X_uart1_rtsn),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
	nds_inout_pad uart2_ctsn_pad	(.O(uart2_ctsn),  .I(1'b0),       .IO(X_uart2_ctsn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
	nds_inout_pad uart2_rtsn_pad	(.O(),  	 .I(uart2_rtsn),  .IO(X_uart2_rtsn),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
	`endif
`else
	nds_inout_pad uart1_ctsn_pad	(.O(uart1_ctsn),  .I(1'b0),       .IO(X_uart1_ctsn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
	nds_inout_pad uart1_rtsn_pad	(.O(),  	 .I(uart1_rtsn),  .IO(X_uart1_rtsn),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
`endif
`endif

`ifdef AE350_UART2_SUPPORT
nds_inout_pad uart2_txd_pad	(.O(),  	 .I(uart2_txd),  .IO(X_uart2_txd),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_rxd_pad	(.O(uart2_rxd),  .I(1'b0),       .IO(X_uart2_rxd),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
`ifdef NDS_FPGA
assign	uart2_dcdn = 1'b1;
assign	uart2_dsrn = 1'b1;
assign	uart2_rin  = 1'b1;
`else
nds_inout_pad uart2_dtrn_pad	(.O(),  	 .I(uart2_dtrn),  .IO(X_uart2_dtrn),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_out1n_pad	(.O(),  	 .I(uart2_out1n), .IO(X_uart2_out1n),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_out2n_pad	(.O(),  	 .I(uart2_out2n), .IO(X_uart2_out2n),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_dcdn_pad	(.O(uart2_dcdn),  .I(1'b0),       .IO(X_uart2_dcdn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_dsrn_pad	(.O(uart2_dsrn),  .I(1'b0),       .IO(X_uart2_dsrn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_rin_pad	(.O(uart2_rin),   .I(1'b0),       .IO(X_uart2_rin),   .E(1'b0),  .PU(1'b0), .PD(1'b0));
`endif
`endif

`ifdef AE350_PIT_SUPPORT
nds_inout_pad pwm_ch0_pad	(.O(),  	 .I(ch0_pwm),  .IO(X_pwm_ch0),  .E(ch0_pwmoe),  .PU(1'b0), .PD(1'b0));
	`ifdef ATCPIT100_CH1_SUPPORT
nds_inout_pad pwm_ch1_pad	(.O(),  	 .I(ch1_pwm),  .IO(X_pwm_ch1),  .E(ch1_pwmoe),  .PU(1'b0), .PD(1'b0));
	`endif
	`ifdef ATCPIT100_CH2_SUPPORT
nds_inout_pad pwm_ch2_pad	(.O(),  	 .I(ch2_pwm),  .IO(X_pwm_ch2),  .E(ch2_pwmoe),  .PU(1'b0), .PD(1'b0));
	`endif
	`ifdef ATCPIT100_CH3_SUPPORT
nds_inout_pad pwm_ch3_pad	(.O(),  	 .I(ch3_pwm),  .IO(X_pwm_ch3),  .E(ch3_pwmoe),  .PU(1'b0), .PD(1'b0));
	`endif
`endif

`ifdef NDS_FPGA
nds_inout_pad pad_flash_cs	(.O(), .I(1'b0),  .IO(X_flash_cs),   .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad pad_flash_dir	(.O(), .I(1'b1),  .IO(X_flash_dir),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
`endif


























`ifdef AE350_GPIO_SUPPORT
nds_inout_pad gpio0_pad	(.O(gpio_in[0]), .I(gpio_out[0]), .IO(X_gpio[0]), .E(gpio_oe[0]),  .PU(gpio_pullup[0]), .PD(gpio_pulldown[0]));
nds_inout_pad gpio1_pad	(.O(gpio_in[1]), .I(gpio_out[1]), .IO(X_gpio[1]), .E(gpio_oe[1]),  .PU(gpio_pullup[1]), .PD(gpio_pulldown[1]));
nds_inout_pad gpio2_pad	(.O(gpio_in[2]), .I(gpio_out[2]), .IO(X_gpio[2]), .E(gpio_oe[2]),  .PU(gpio_pullup[2]), .PD(gpio_pulldown[2]));
nds_inout_pad gpio3_pad	(.O(gpio_in[3]), .I(gpio_out[3]), .IO(X_gpio[3]), .E(gpio_oe[3]),  .PU(gpio_pullup[3]), .PD(gpio_pulldown[3]));
nds_inout_pad gpio4_pad	(.O(gpio_in[4]), .I(gpio_out[4]), .IO(X_gpio[4]), .E(gpio_oe[4]),  .PU(gpio_pullup[4]), .PD(gpio_pulldown[4]));
nds_inout_pad gpio5_pad	(.O(gpio_in[5]), .I(gpio_out[5]), .IO(X_gpio[5]), .E(gpio_oe[5]),  .PU(gpio_pullup[5]), .PD(gpio_pulldown[5]));
nds_inout_pad gpio6_pad	(.O(gpio_in[6]), .I(gpio_out[6]), .IO(X_gpio[6]), .E(gpio_oe[6]),  .PU(gpio_pullup[6]), .PD(gpio_pulldown[6]));
nds_inout_pad gpio7_pad	(.O(gpio_in[7]), .I(gpio_out[7]), .IO(X_gpio[7]), .E(gpio_oe[7]),  .PU(gpio_pullup[7]), .PD(gpio_pulldown[7]));
nds_inout_pad gpio8_pad	(.O(gpio_in[8]), .I(gpio_out[8]), .IO(X_gpio[8]), .E(gpio_oe[8]),  .PU(gpio_pullup[8]), .PD(gpio_pulldown[8]));
nds_inout_pad gpio9_pad	(.O(gpio_in[9]), .I(gpio_out[9]), .IO(X_gpio[9]), .E(gpio_oe[9]),  .PU(gpio_pullup[9]), .PD(gpio_pulldown[9]));
nds_inout_pad gpio10_pad	(.O(gpio_in[10]), .I(gpio_out[10]), .IO(X_gpio[10]), .E(gpio_oe[10]),  .PU(gpio_pullup[10]), .PD(gpio_pulldown[10]));
nds_inout_pad gpio11_pad	(.O(gpio_in[11]), .I(gpio_out[11]), .IO(X_gpio[11]), .E(gpio_oe[11]),  .PU(gpio_pullup[11]), .PD(gpio_pulldown[11]));
nds_inout_pad gpio12_pad	(.O(gpio_in[12]), .I(gpio_out[12]), .IO(X_gpio[12]), .E(gpio_oe[12]),  .PU(gpio_pullup[12]), .PD(gpio_pulldown[12]));
nds_inout_pad gpio13_pad	(.O(gpio_in[13]), .I(gpio_out[13]), .IO(X_gpio[13]), .E(gpio_oe[13]),  .PU(gpio_pullup[13]), .PD(gpio_pulldown[13]));
nds_inout_pad gpio14_pad	(.O(gpio_in[14]), .I(gpio_out[14]), .IO(X_gpio[14]), .E(gpio_oe[14]),  .PU(gpio_pullup[14]), .PD(gpio_pulldown[14]));
nds_inout_pad gpio15_pad	(.O(gpio_in[15]), .I(gpio_out[15]), .IO(X_gpio[15]), .E(gpio_oe[15]),  .PU(gpio_pullup[15]), .PD(gpio_pulldown[15]));
nds_inout_pad gpio16_pad	(.O(gpio_in[16]), .I(gpio_out[16]), .IO(X_gpio[16]), .E(gpio_oe[16]),  .PU(gpio_pullup[16]), .PD(gpio_pulldown[16]));
nds_inout_pad gpio17_pad	(.O(gpio_in[17]), .I(gpio_out[17]), .IO(X_gpio[17]), .E(gpio_oe[17]),  .PU(gpio_pullup[17]), .PD(gpio_pulldown[17]));
nds_inout_pad gpio18_pad	(.O(gpio_in[18]), .I(gpio_out[18]), .IO(X_gpio[18]), .E(gpio_oe[18]),  .PU(gpio_pullup[18]), .PD(gpio_pulldown[18]));
nds_inout_pad gpio19_pad	(.O(gpio_in[19]), .I(gpio_out[19]), .IO(X_gpio[19]), .E(gpio_oe[19]),  .PU(gpio_pullup[19]), .PD(gpio_pulldown[19]));
nds_inout_pad gpio20_pad	(.O(gpio_in[20]), .I(gpio_out[20]), .IO(X_gpio[20]), .E(gpio_oe[20]),  .PU(gpio_pullup[20]), .PD(gpio_pulldown[20]));
nds_inout_pad gpio21_pad	(.O(gpio_in[21]), .I(gpio_out[21]), .IO(X_gpio[21]), .E(gpio_oe[21]),  .PU(gpio_pullup[21]), .PD(gpio_pulldown[21]));
nds_inout_pad gpio22_pad	(.O(gpio_in[22]), .I(gpio_out[22]), .IO(X_gpio[22]), .E(gpio_oe[22]),  .PU(gpio_pullup[22]), .PD(gpio_pulldown[22]));
nds_inout_pad gpio23_pad	(.O(gpio_in[23]), .I(gpio_out[23]), .IO(X_gpio[23]), .E(gpio_oe[23]),  .PU(gpio_pullup[23]), .PD(gpio_pulldown[23]));
nds_inout_pad gpio24_pad	(.O(gpio_in[24]), .I(gpio_out[24]), .IO(X_gpio[24]), .E(gpio_oe[24]),  .PU(gpio_pullup[24]), .PD(gpio_pulldown[24]));
nds_inout_pad gpio25_pad	(.O(gpio_in[25]), .I(gpio_out[25]), .IO(X_gpio[25]), .E(gpio_oe[25]),  .PU(gpio_pullup[25]), .PD(gpio_pulldown[25]));
nds_inout_pad gpio26_pad	(.O(gpio_in[26]), .I(gpio_out[26]), .IO(X_gpio[26]), .E(gpio_oe[26]),  .PU(gpio_pullup[26]), .PD(gpio_pulldown[26]));
nds_inout_pad gpio27_pad	(.O(gpio_in[27]), .I(gpio_out[27]), .IO(X_gpio[27]), .E(gpio_oe[27]),  .PU(gpio_pullup[27]), .PD(gpio_pulldown[27]));
nds_inout_pad gpio28_pad	(.O(gpio_in[28]), .I(gpio_out[28]), .IO(X_gpio[28]), .E(gpio_oe[28]),  .PU(gpio_pullup[28]), .PD(gpio_pulldown[28]));
nds_inout_pad gpio29_pad	(.O(gpio_in[29]), .I(gpio_out[29]), .IO(X_gpio[29]), .E(gpio_oe[29]),  .PU(gpio_pullup[29]), .PD(gpio_pulldown[29]));
nds_inout_pad gpio30_pad	(.O(gpio_in[30]), .I(gpio_out[30]), .IO(X_gpio[30]), .E(gpio_oe[30]),  .PU(gpio_pullup[30]), .PD(gpio_pulldown[30]));
nds_inout_pad gpio31_pad	(.O(gpio_in[31]), .I(gpio_out[31]), .IO(X_gpio[31]), .E(gpio_oe[31]),  .PU(gpio_pullup[31]), .PD(gpio_pulldown[31]));
`endif

endmodule

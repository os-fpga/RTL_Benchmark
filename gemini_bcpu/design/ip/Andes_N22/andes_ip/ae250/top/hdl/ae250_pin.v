// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module ae250_pin (
		  X_oschio,
		  X_oschin,
		  T_osch,
		  X_hw_rstn,
		  T_hw_rstn,
		  X_por_b,
		  T_por_b,
	`ifdef PLATFORM_DEBUG_PORT
		  X_tms,
	   `ifdef AE250_JTAG_TWOWIRE
	   `else
		  X_trst,
		  X_tdi,
		  X_tdo,
	   `endif
		  pin_tms_in,
		  pin_tms_out,
		  pin_tms_out_en,
	   `ifdef AE250_JTAG_TWOWIRE
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
	`endif
	`ifdef AE250_SPI1_SUPPORT
		  X_spi1_clk,
		  X_spi1_csn,
		  X_spi1_miso,
		  X_spi1_mosi,
		  spi1_clk_in,
		  spi1_csn_in,
		  spi1_miso_in,
		  spi1_mosi_in,
		  spi1_clk_out,
		  spi1_clk_oe,
		  spi1_csn_out,
		  spi1_csn_oe,
		  spi1_miso_out,
		  spi1_miso_oe,
		  spi1_mosi_out,
		  spi1_mosi_oe,
	   `ifdef ATCSPI200_QUADSPI_SUPPORT
		  X_spi1_holdn,
		  X_spi1_wpn,
		  spi1_holdn_in,
		  spi1_wpn_in,
		  spi1_holdn_out,
		  spi1_holdn_oe,
		  spi1_wpn_out,
		  spi1_wpn_oe,
	   `endif
	`endif
	`ifdef AE250_SPI2_SUPPORT
	   `ifdef NDS_BOARD_CF1
	   `else
		  X_spi2_clk,
		  X_spi2_csn,
		  X_spi2_miso,
		  X_spi2_mosi,
	   `endif
		  spi2_clk_in,
		  spi2_csn_in,
		  spi2_miso_in,
		  spi2_mosi_in,
		  spi2_clk_out,
		  spi2_clk_oe,
		  spi2_csn_out,
		  spi2_csn_oe,
		  spi2_miso_out,
		  spi2_miso_oe,
		  spi2_mosi_out,
		  spi2_mosi_oe,
	   `ifdef ATCSPI200_QUADSPI_SUPPORT
		  X_spi2_holdn,
		  X_spi2_wpn,
		  spi2_holdn_in,
		  spi2_wpn_in,
		  spi2_holdn_out,
		  spi2_holdn_oe,
		  spi2_wpn_out,
		  spi2_wpn_oe,
	   `endif
	`endif
	`ifdef AE250_SPI3_SUPPORT
		  X_spi3_clk,
		  X_spi3_csn,
		  X_spi3_miso,
		  X_spi3_mosi,
		  spi3_clk_in,
		  spi3_csn_in,
		  spi3_miso_in,
		  spi3_mosi_in,
		  spi3_clk_out,
		  spi3_clk_oe,
		  spi3_csn_out,
		  spi3_csn_oe,
		  spi3_miso_out,
		  spi3_miso_oe,
		  spi3_mosi_out,
		  spi3_mosi_oe,
	   `ifdef ATCSPI200_QUADSPI_SUPPORT
		  X_spi3_holdn,
		  X_spi3_wpn,
		  spi3_holdn_in,
		  spi3_wpn_in,
		  spi3_holdn_out,
		  spi3_holdn_oe,
		  spi3_wpn_out,
		  spi3_wpn_oe,
	   `endif
	`endif
	`ifdef AE250_SPI4_SUPPORT
		  X_spi4_clk,
		  X_spi4_csn,
		  X_spi4_miso,
		  X_spi4_mosi,
		  spi4_clk_in,
		  spi4_csn_in,
		  spi4_miso_in,
		  spi4_mosi_in,
		  spi4_clk_out,
		  spi4_clk_oe,
		  spi4_csn_out,
		  spi4_csn_oe,
		  spi4_miso_out,
		  spi4_miso_oe,
		  spi4_mosi_out,
		  spi4_mosi_oe,
	   `ifdef ATCSPI200_QUADSPI_SUPPORT
		  X_spi4_holdn,
		  X_spi4_wpn,
		  spi4_holdn_in,
		  spi4_wpn_in,
		  spi4_holdn_out,
		  spi4_holdn_oe,
		  spi4_wpn_out,
		  spi4_wpn_oe,
	   `endif
	`endif
	`ifdef NDS_BOARD_CF1
	`else
	   `ifdef AE250_I2C_SUPPORT
		  X_i2c_scl,
		  X_i2c_sda,
	   `endif
	`endif
	`ifdef AE250_I2C_SUPPORT
		  i2c_scl_in,
		  i2c_sda_in,
		  i2c_scl,
		  i2c_sda,
	`endif
	`ifdef AE250_I2C2_SUPPORT
		  i2c2_scl_in,
		  i2c2_sda_in,
		  i2c2_scl,
		  i2c2_sda,
	`endif
	`ifdef NDS_BOARD_CF1
	`else
	   `ifdef AE250_UART1_SUPPORT
		  X_uart1_txd,
		  X_uart1_rxd,
		  X_uart1_dsrn,
		  X_uart1_dcdn,
		  X_uart1_rin,
		  X_uart1_dtrn,
		  X_uart1_out1n,
		  X_uart1_out2n,
	   `endif
	`endif
	`ifdef AE250_UART1_SUPPORT
	   `ifdef AE250_UART2_SUPPORT
	      `ifdef NDS_FPGA
	      `else
		  X_uart1_ctsn,
		  X_uart1_rtsn,
	      `endif
	   `else
		  X_uart1_ctsn,
		  X_uart1_rtsn,
	   `endif
	`endif
	`ifdef NDS_BOARD_CF1
	`else
	   `ifdef AE250_UART2_SUPPORT
		  X_uart2_txd,
		  X_uart2_rxd,
	   `endif
	`endif
	`ifdef AE250_UART2_SUPPORT
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
	`ifdef AE250_UART1_SUPPORT
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
	`ifdef AE250_UART2_SUPPORT
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
	`ifdef NDS_BOARD_CF1
	`else
		  X_pwm_ch0,
	`endif
		  ch0_pwm,
		  ch0_pwmoe,
	`ifdef NDS_BOARD_CF1
	`else
	   `ifdef ATCPIT100_CH1_SUPPORT
		  X_pwm_ch1,
	   `endif
	`endif
	`ifdef ATCPIT100_CH1_SUPPORT
		  ch1_pwm,
		  ch1_pwmoe,
	`endif
	`ifdef NDS_BOARD_CF1
	`else
	   `ifdef ATCPIT100_CH2_SUPPORT
		  X_pwm_ch2,
	   `endif
	`endif
	`ifdef ATCPIT100_CH2_SUPPORT
		  ch2_pwm,
		  ch2_pwmoe,
	`endif
	`ifdef NDS_BOARD_CF1
	`else
	   `ifdef ATCPIT100_CH3_SUPPORT
		  X_pwm_ch3,
	   `endif
	`endif
	`ifdef ATCPIT100_CH3_SUPPORT
		  ch3_pwm,
		  ch3_pwmoe,
	`endif
	`ifdef AE250_PIT2_SUPPORT
		  pit2_ch0_pwm,
		  pit2_ch0_pwmoe,
	   `ifdef ATCPIT100_CH1_SUPPORT
		  pit2_ch1_pwm,
		  pit2_ch1_pwmoe,
	   `endif
	   `ifdef ATCPIT100_CH2_SUPPORT
		  pit2_ch2_pwm,
		  pit2_ch2_pwmoe,
	   `endif
	   `ifdef ATCPIT100_CH3_SUPPORT
		  pit2_ch3_pwm,
		  pit2_ch3_pwmoe,
	   `endif
	`endif
	`ifdef AE250_PIT3_SUPPORT
		  pit3_ch0_pwm,
		  pit3_ch0_pwmoe,
	   `ifdef ATCPIT100_CH1_SUPPORT
		  pit3_ch1_pwm,
		  pit3_ch1_pwmoe,
	   `endif
	   `ifdef ATCPIT100_CH2_SUPPORT
		  pit3_ch2_pwm,
		  pit3_ch2_pwmoe,
	   `endif
	   `ifdef ATCPIT100_CH3_SUPPORT
		  pit3_ch3_pwm,
		  pit3_ch3_pwmoe,
	   `endif
	`endif
	`ifdef AE250_PIT4_SUPPORT
		  pit4_ch0_pwm,
		  pit4_ch0_pwmoe,
	   `ifdef ATCPIT100_CH1_SUPPORT
		  pit4_ch1_pwm,
		  pit4_ch1_pwmoe,
	   `endif
	   `ifdef ATCPIT100_CH2_SUPPORT
		  pit4_ch2_pwm,
		  pit4_ch2_pwmoe,
	   `endif
	   `ifdef ATCPIT100_CH3_SUPPORT
		  pit4_ch3_pwm,
		  pit4_ch3_pwmoe,
	   `endif
	`endif
	`ifdef AE250_PIT5_SUPPORT
		  pit5_ch0_pwm,
		  pit5_ch0_pwmoe,
	   `ifdef ATCPIT100_CH1_SUPPORT
		  pit5_ch1_pwm,
		  pit5_ch1_pwmoe,
	   `endif
	   `ifdef ATCPIT100_CH2_SUPPORT
		  pit5_ch2_pwm,
		  pit5_ch2_pwmoe,
	   `endif
	   `ifdef ATCPIT100_CH3_SUPPORT
		  pit5_ch3_pwm,
		  pit5_ch3_pwmoe,
	   `endif
	`endif
	`ifdef NDS_BOARD_CF1
		  cf1_pinmux_ctrl0,
		  cf1_pinmux_ctrl1,
	`endif
		  X_gpio,
		  gpio_in,
		  gpio_oe,
		  gpio_out,
		  gpio_pulldown,
		  gpio_pullup
);

inout		X_oschio;
input		X_oschin;
output		T_osch;

inout		X_hw_rstn;
output		T_hw_rstn;

inout		X_por_b;
output		T_por_b;

`ifdef PLATFORM_DEBUG_PORT
inout		X_tms;
`ifdef	AE250_JTAG_TWOWIRE
`else
inout		X_trst;
inout		X_tdi;
inout		X_tdo;
`endif

output          pin_tms_in;
input           pin_tms_out;
input           pin_tms_out_en;
`ifdef	AE250_JTAG_TWOWIRE
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
`endif

`ifdef AE250_SPI1_SUPPORT
inout		X_spi1_clk;
inout		X_spi1_csn;
inout		X_spi1_miso;
inout		X_spi1_mosi;
output		spi1_clk_in;
output		spi1_csn_in;
output		spi1_miso_in;
output		spi1_mosi_in;
input		spi1_clk_out;
input		spi1_clk_oe;
input		spi1_csn_out;
input		spi1_csn_oe;
input		spi1_miso_out;
input		spi1_miso_oe;
input		spi1_mosi_out;
input		spi1_mosi_oe;
	`ifdef ATCSPI200_QUADSPI_SUPPORT
inout          	X_spi1_holdn;
inout		X_spi1_wpn;
output		spi1_holdn_in;
output		spi1_wpn_in;
input          	spi1_holdn_out;
input		spi1_holdn_oe;
input		spi1_wpn_out;
input		spi1_wpn_oe;
	`endif
`endif

`ifdef AE250_SPI2_SUPPORT
	`ifndef NDS_BOARD_CF1
inout		X_spi2_clk;
inout		X_spi2_csn;
inout		X_spi2_miso;
inout		X_spi2_mosi;
	`endif
output		spi2_clk_in;
output		spi2_csn_in;
output		spi2_miso_in;
output		spi2_mosi_in;
input		spi2_clk_out;
input		spi2_clk_oe;
input		spi2_csn_out;
input		spi2_csn_oe;
input		spi2_miso_out;
input		spi2_miso_oe;
input		spi2_mosi_out;
input		spi2_mosi_oe;
	`ifdef ATCSPI200_QUADSPI_SUPPORT
inout          	X_spi2_holdn;
inout		X_spi2_wpn;
output		spi2_holdn_in;
output		spi2_wpn_in;
input          	spi2_holdn_out;
input		spi2_holdn_oe;
input		spi2_wpn_out;
input		spi2_wpn_oe;
	`endif
`endif

`ifdef AE250_SPI3_SUPPORT
inout		X_spi3_clk;
inout		X_spi3_csn;
inout		X_spi3_miso;
inout		X_spi3_mosi;
output		spi3_clk_in;
output		spi3_csn_in;
output		spi3_miso_in;
output		spi3_mosi_in;
input		spi3_clk_out;
input		spi3_clk_oe;
input		spi3_csn_out;
input		spi3_csn_oe;
input		spi3_miso_out;
input		spi3_miso_oe;
input		spi3_mosi_out;
input		spi3_mosi_oe;
	`ifdef ATCSPI200_QUADSPI_SUPPORT
inout          	X_spi3_holdn;
inout		X_spi3_wpn;
output		spi3_holdn_in;
output		spi3_wpn_in;
input          	spi3_holdn_out;
input		spi3_holdn_oe;
input		spi3_wpn_out;
input		spi3_wpn_oe;
	`endif
`endif

`ifdef AE250_SPI4_SUPPORT
inout		X_spi4_clk;
inout		X_spi4_csn;
inout		X_spi4_miso;
inout		X_spi4_mosi;
output		spi4_clk_in;
output		spi4_csn_in;
output		spi4_miso_in;
output		spi4_mosi_in;
input		spi4_clk_out;
input		spi4_clk_oe;
input		spi4_csn_out;
input		spi4_csn_oe;
input		spi4_miso_out;
input		spi4_miso_oe;
input		spi4_mosi_out;
input		spi4_mosi_oe;
	`ifdef ATCSPI200_QUADSPI_SUPPORT
inout          	X_spi4_holdn;
inout		X_spi4_wpn;
output		spi4_holdn_in;
output		spi4_wpn_in;
input          	spi4_holdn_out;
input		spi4_holdn_oe;
input		spi4_wpn_out;
input		spi4_wpn_oe;
	`endif
`endif

`ifdef AE250_I2C_SUPPORT
	`ifndef NDS_BOARD_CF1
inout		X_i2c_scl;
inout		X_i2c_sda;
	`endif
output		i2c_scl_in;
output		i2c_sda_in;
input		i2c_scl;
input		i2c_sda;
`else
wire		i2c_scl = 1'b0;
wire		i2c_sda = 1'b0;
`endif

`ifdef AE250_I2C2_SUPPORT
output		i2c2_scl_in;
output		i2c2_sda_in;
input		i2c2_scl;
input		i2c2_sda;
`else
wire		i2c2_scl = 1'b0;
wire		i2c2_sda = 1'b0;
`endif

`ifdef AE250_UART1_SUPPORT
	`ifndef NDS_BOARD_CF1
inout		X_uart1_txd;
inout		X_uart1_rxd;
inout		X_uart1_dsrn;
inout		X_uart1_dcdn;
inout		X_uart1_rin;
inout		X_uart1_dtrn;
inout		X_uart1_out1n;
inout		X_uart1_out2n;
	`endif
	`ifdef AE250_UART2_SUPPORT
		`ifndef NDS_FPGA
inout		X_uart1_ctsn;
inout		X_uart1_rtsn;
		`endif
	`else
inout		X_uart1_ctsn;
inout		X_uart1_rtsn;
	`endif
`endif
`ifdef AE250_UART2_SUPPORT
	`ifndef NDS_BOARD_CF1
inout		X_uart2_txd;
inout		X_uart2_rxd;
	`endif
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
`ifdef AE250_UART1_SUPPORT
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
`ifdef AE250_UART2_SUPPORT
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

`ifndef NDS_BOARD_CF1
inout		   X_pwm_ch0;
`endif
input              ch0_pwm;
input              ch0_pwmoe;
`ifdef ATCPIT100_CH1_SUPPORT
	`ifndef NDS_BOARD_CF1
inout		   X_pwm_ch1;
	`endif
input              ch1_pwm;
input              ch1_pwmoe;
`endif
`ifdef ATCPIT100_CH2_SUPPORT
	`ifndef NDS_BOARD_CF1
inout		   X_pwm_ch2;
	`endif
input              ch2_pwm;
input              ch2_pwmoe;
`endif
`ifdef ATCPIT100_CH3_SUPPORT
	`ifndef NDS_BOARD_CF1
inout		   X_pwm_ch3;
	`endif
input              ch3_pwm;
input              ch3_pwmoe;
`endif

`ifdef AE250_PIT2_SUPPORT
input		pit2_ch0_pwm;
input		pit2_ch0_pwmoe;
	`ifdef ATCPIT100_CH1_SUPPORT
input		pit2_ch1_pwm;
input		pit2_ch1_pwmoe;
	`endif
	`ifdef ATCPIT100_CH2_SUPPORT
input		pit2_ch2_pwm;
input		pit2_ch2_pwmoe;
	`endif
	`ifdef ATCPIT100_CH3_SUPPORT
input		pit2_ch3_pwm;
input		pit2_ch3_pwmoe;
	`endif
`else
supply0		pit2_ch0_pwm;
supply0		pit2_ch0_pwmoe;
supply0		pit2_ch1_pwm;
supply0		pit2_ch1_pwmoe;
supply0		pit2_ch2_pwm;
supply0		pit2_ch2_pwmoe;
supply0		pit2_ch3_pwm;
supply0		pit2_ch3_pwmoe;
`endif

`ifdef AE250_PIT3_SUPPORT
input		pit3_ch0_pwm;
input		pit3_ch0_pwmoe;
	`ifdef ATCPIT100_CH1_SUPPORT
input		pit3_ch1_pwm;
input		pit3_ch1_pwmoe;
	`endif
	`ifdef ATCPIT100_CH2_SUPPORT
input		pit3_ch2_pwm;
input		pit3_ch2_pwmoe;
	`endif
	`ifdef ATCPIT100_CH3_SUPPORT
input		pit3_ch3_pwm;
input		pit3_ch3_pwmoe;
	`endif
`else
supply0		pit3_ch0_pwm;
supply0		pit3_ch0_pwmoe;
supply0		pit3_ch1_pwm;
supply0		pit3_ch1_pwmoe;
supply0		pit3_ch2_pwm;
supply0		pit3_ch2_pwmoe;
supply0		pit3_ch3_pwm;
supply0		pit3_ch3_pwmoe;
`endif

`ifdef AE250_PIT4_SUPPORT
input		pit4_ch0_pwm;
input		pit4_ch0_pwmoe;
	`ifdef ATCPIT100_CH1_SUPPORT
input		pit4_ch1_pwm;
input		pit4_ch1_pwmoe;
	`endif
	`ifdef ATCPIT100_CH2_SUPPORT
input		pit4_ch2_pwm;
input		pit4_ch2_pwmoe;
	`endif
	`ifdef ATCPIT100_CH3_SUPPORT
input		pit4_ch3_pwm;
input		pit4_ch3_pwmoe;
	`endif
`else
supply0		pit4_ch0_pwm;
supply0		pit4_ch0_pwmoe;
supply0		pit4_ch1_pwm;
supply0		pit4_ch1_pwmoe;
supply0		pit4_ch2_pwm;
supply0		pit4_ch2_pwmoe;
supply0		pit4_ch3_pwm;
supply0		pit4_ch3_pwmoe;
`endif

`ifdef AE250_PIT5_SUPPORT
input		pit5_ch0_pwm;
input		pit5_ch0_pwmoe;
	`ifdef ATCPIT100_CH1_SUPPORT
input		pit5_ch1_pwm;
input		pit5_ch1_pwmoe;
	`endif
	`ifdef ATCPIT100_CH2_SUPPORT
input		pit5_ch2_pwm;
input		pit5_ch2_pwmoe;
	`endif
	`ifdef ATCPIT100_CH3_SUPPORT
input		pit5_ch3_pwm;
input		pit5_ch3_pwmoe;
	`endif
`else
supply0		pit5_ch0_pwm;
supply0		pit5_ch0_pwmoe;
supply0		pit5_ch1_pwm;
supply0		pit5_ch1_pwmoe;
supply0		pit5_ch2_pwm;
supply0		pit5_ch2_pwmoe;
supply0		pit5_ch3_pwm;
supply0		pit5_ch3_pwmoe;
`endif







`ifdef NDS_BOARD_CF1
input   [31:0]	cf1_pinmux_ctrl0;
input   [31:0]	cf1_pinmux_ctrl1;
`endif

inout	[31:0]	X_gpio;
output	[31:0]	gpio_in;
input	[31:0]	gpio_oe;
input	[31:0]	gpio_out;
input	[31:0]	gpio_pulldown;
input	[31:0]	gpio_pullup;


wire		gpio_in_12;
wire		gpio_out_12;
wire		gpio_oe_12;
wire		gpio_pullup_12;
wire		gpio_pulldown_12;
wire		gpio_in_13;
wire		gpio_out_13;
wire		gpio_oe_13;
wire		gpio_pullup_13;
wire		gpio_pulldown_13;
wire		gpio_in_14;
wire		gpio_out_14;
wire		gpio_oe_14;
wire		gpio_pullup_14;
wire		gpio_pulldown_14;
wire		gpio_in_15;
wire		gpio_out_15;
wire		gpio_oe_15;
wire		gpio_pullup_15;
wire		gpio_pulldown_15;
wire		gpio_in_16;
wire		gpio_out_16;
wire		gpio_oe_16;
wire		gpio_pullup_16;
wire		gpio_pulldown_16;
wire		gpio_in_17;
wire		gpio_out_17;
wire		gpio_oe_17;
wire		gpio_pullup_17;
wire		gpio_pulldown_17;
wire		gpio_in_18;
wire		gpio_out_18;
wire		gpio_oe_18;
wire		gpio_pullup_18;
wire		gpio_pulldown_18;
wire		gpio_in_19;
wire		gpio_out_19;
wire		gpio_oe_19;
wire		gpio_pullup_19;
wire		gpio_pulldown_19;
wire		gpio_in_20;
wire		gpio_out_20;
wire		gpio_oe_20;
wire		gpio_pullup_20;
wire		gpio_pulldown_20;
wire		gpio_in_21;
wire		gpio_out_21;
wire		gpio_oe_21;
wire		gpio_pullup_21;
wire		gpio_pulldown_21;
wire		gpio_in_22;
wire		gpio_out_22;
wire		gpio_oe_22;
wire		gpio_pullup_22;
wire		gpio_pulldown_22;
wire		gpio_in_23;
wire		gpio_out_23;
wire		gpio_oe_23;
wire		gpio_pullup_23;
wire		gpio_pulldown_23;
wire		gpio_in_24;
wire		gpio_out_24;
wire		gpio_oe_24;
wire		gpio_pullup_24;
wire		gpio_pulldown_24;
wire		gpio_in_25;
wire		gpio_out_25;
wire		gpio_oe_25;
wire		gpio_pullup_25;
wire		gpio_pulldown_25;
wire		gpio_in_26;
wire		gpio_out_26;
wire		gpio_oe_26;
wire		gpio_pullup_26;
wire		gpio_pulldown_26;
wire		gpio_in_27;
wire		gpio_out_27;
wire		gpio_oe_27;
wire		gpio_pullup_27;
wire		gpio_pulldown_27;
wire		gpio_in_28;
wire		gpio_out_28;
wire		gpio_oe_28;
wire		gpio_pullup_28;
wire		gpio_pulldown_28;
wire		gpio_in_29;
wire		gpio_out_29;
wire		gpio_oe_29;
wire		gpio_pullup_29;
wire		gpio_pulldown_29;
wire		gpio_in_30;
wire		gpio_out_30;
wire		gpio_oe_30;
wire		gpio_pullup_30;
wire		gpio_pulldown_30;
wire		gpio_in_31;
wire		gpio_out_31;
wire		gpio_oe_31;
wire		gpio_pullup_31;
wire		gpio_pulldown_31;

nds_osc_pad   osch_pad		(.O(T_osch), .I(X_oschin), .IO(X_oschio));

nds_inout_pad hw_rstn_pad	(.O(T_hw_rstn), .I(1'b0), .IO(X_hw_rstn), .E(1'b0), .PU(1'b0), .PD(1'b0));

nds_inout_pad porb_pad		(.O(T_por_b), .I(1'b0), .IO(X_por_b), .E(1'b0), .PU(1'b0), .PD(1'b0));

`ifdef PLATFORM_DEBUG_PORT
nds_inout_pad jtag_tms_pad	(.O(pin_tms_in),  .I(pin_tms_out),  .IO(X_tms),  .E(pin_tms_out_en),  .PU(1'b1), .PD(1'b0));
`ifndef AE250_JTAG_TWOWIRE
nds_inout_pad jtag_trst_pad	(.O(pin_trst_in), .I(pin_trst_out), .IO(X_trst), .E(pin_trst_out_en), .PU(1'b0), .PD(1'b0));
nds_inout_pad jtag_tdi_pad	(.O(pin_tdi_in),  .I(pin_tdi_out),  .IO(X_tdi),  .E(pin_tdi_out_en),  .PU(1'b0), .PD(1'b0));
nds_inout_pad jtag_tdo_pad	(.O(pin_tdo_in),  .I(pin_tdo_out),  .IO(X_tdo),  .E(pin_tdo_out_en),  .PU(1'b0), .PD(1'b0));
`endif
`endif

`ifdef AE250_SPI1_SUPPORT
nds_inout_pad spi1_clk_pad	(.O(spi1_clk_in),   .I(spi1_clk_out),   .IO(X_spi1_clk),   .E(spi1_clk_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi1_csn_pad	(.O(spi1_csn_in),   .I(spi1_csn_out),   .IO(X_spi1_csn),   .E(spi1_csn_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi1_miso_pad	(.O(spi1_miso_in),  .I(spi1_miso_out),  .IO(X_spi1_miso),  .E(spi1_miso_oe),  .PU(1'b0), .PD(1'b0));
nds_inout_pad spi1_mosi_pad	(.O(spi1_mosi_in),  .I(spi1_mosi_out),  .IO(X_spi1_mosi),  .E(spi1_mosi_oe),  .PU(1'b0), .PD(1'b0));
	`ifdef ATCSPI200_QUADSPI_SUPPORT
nds_inout_pad spi1_holdn_pad	(.O(spi1_holdn_in), .I(spi1_holdn_out), .IO(X_spi1_holdn), .E(spi1_holdn_oe), .PU(1'b0), .PD(1'b0));
nds_inout_pad spi1_wpn_pad	(.O(spi1_wpn_in),   .I(spi1_wpn_out),   .IO(X_spi1_wpn),   .E(spi1_wpn_oe),   .PU(1'b0), .PD(1'b0));
	`endif
`endif

`ifdef AE250_SPI2_SUPPORT
	`ifndef NDS_BOARD_CF1
nds_inout_pad spi2_clk_pad	(.O(spi2_clk_in),   .I(spi2_clk_out),   .IO(X_spi2_clk),   .E(spi2_clk_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi2_csn_pad	(.O(spi2_csn_in),   .I(spi2_csn_out),   .IO(X_spi2_csn),   .E(spi2_csn_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi2_miso_pad	(.O(spi2_miso_in),  .I(spi2_miso_out),  .IO(X_spi2_miso),  .E(spi2_miso_oe),  .PU(1'b0), .PD(1'b0));
nds_inout_pad spi2_mosi_pad	(.O(spi2_mosi_in),  .I(spi2_mosi_out),  .IO(X_spi2_mosi),  .E(spi2_mosi_oe),  .PU(1'b0), .PD(1'b0));
	`endif
	`ifdef ATCSPI200_QUADSPI_SUPPORT
nds_inout_pad spi2_holdn_pad	(.O(spi2_holdn_in), .I(spi2_holdn_out), .IO(X_spi2_holdn), .E(spi2_holdn_oe), .PU(1'b0), .PD(1'b0));
nds_inout_pad spi2_wpn_pad	(.O(spi2_wpn_in),   .I(spi2_wpn_out),   .IO(X_spi2_wpn),   .E(spi2_wpn_oe),   .PU(1'b0), .PD(1'b0));
	`endif
`endif

`ifdef AE250_SPI3_SUPPORT
nds_inout_pad spi3_clk_pad	(.O(spi3_clk_in),   .I(spi3_clk_out),   .IO(X_spi3_clk),   .E(spi3_clk_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi3_csn_pad	(.O(spi3_csn_in),   .I(spi3_csn_out),   .IO(X_spi3_csn),   .E(spi3_csn_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi3_miso_pad	(.O(spi3_miso_in),  .I(spi3_miso_out),  .IO(X_spi3_miso),  .E(spi3_miso_oe),  .PU(1'b0), .PD(1'b0));
nds_inout_pad spi3_mosi_pad	(.O(spi3_mosi_in),  .I(spi3_mosi_out),  .IO(X_spi3_mosi),  .E(spi3_mosi_oe),  .PU(1'b0), .PD(1'b0));
	`ifdef ATCSPI200_QUADSPI_SUPPORT
nds_inout_pad spi3_holdn_pad	(.O(spi3_holdn_in), .I(spi3_holdn_out), .IO(X_spi3_holdn), .E(spi3_holdn_oe), .PU(1'b0), .PD(1'b0));
nds_inout_pad spi3_wpn_pad	(.O(spi3_wpn_in),   .I(spi3_wpn_out),   .IO(X_spi3_wpn),   .E(spi3_wpn_oe),   .PU(1'b0), .PD(1'b0));
	`endif
`endif

`ifdef AE250_SPI4_SUPPORT
nds_inout_pad spi4_clk_pad	(.O(spi4_clk_in),   .I(spi4_clk_out),   .IO(X_spi4_clk),   .E(spi4_clk_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi4_csn_pad	(.O(spi4_csn_in),   .I(spi4_csn_out),   .IO(X_spi4_csn),   .E(spi4_csn_oe),   .PU(1'b0), .PD(1'b0));
nds_inout_pad spi4_miso_pad	(.O(spi4_miso_in),  .I(spi4_miso_out),  .IO(X_spi4_miso),  .E(spi4_miso_oe),  .PU(1'b0), .PD(1'b0));
nds_inout_pad spi4_mosi_pad	(.O(spi4_mosi_in),  .I(spi4_mosi_out),  .IO(X_spi4_mosi),  .E(spi4_mosi_oe),  .PU(1'b0), .PD(1'b0));
	`ifdef ATCSPI200_QUADSPI_SUPPORT
nds_inout_pad spi4_holdn_pad	(.O(spi4_holdn_in), .I(spi4_holdn_out), .IO(X_spi4_holdn), .E(spi4_holdn_oe), .PU(1'b0), .PD(1'b0));
nds_inout_pad spi4_wpn_pad	(.O(spi4_wpn_in),   .I(spi4_wpn_out),   .IO(X_spi4_wpn),   .E(spi4_wpn_oe),   .PU(1'b0), .PD(1'b0));
	`endif
`endif

`ifdef AE250_I2C_SUPPORT
	`ifndef NDS_BOARD_CF1
nds_inout_pad i2c_scl_pad	(.O(i2c_scl_in),  .I(1'b0),  .IO(X_i2c_scl),  .E(~i2c_scl),  .PU(1'b0), .PD(1'b0));
nds_inout_pad i2c_sda_pad	(.O(i2c_sda_in),  .I(1'b0),  .IO(X_i2c_sda),  .E(~i2c_sda),  .PU(1'b0), .PD(1'b0));
	`endif
`endif


`ifdef AE250_UART1_SUPPORT
	`ifdef NDS_BOARD_CF1
assign uart1_dcdn = 1'b0;
assign uart1_dsrn = 1'b0;
assign uart1_rin = 1'b0;
	`else
nds_inout_pad uart1_txd_pad	(.O(),  	 .I(uart1_txd),  .IO(X_uart1_txd),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_rxd_pad	(.O(uart1_rxd),  .I(1'b0),       .IO(X_uart1_rxd),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_dtrn_pad	(.O(),  	 .I(uart1_dtrn),  .IO(X_uart1_dtrn),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_out1n_pad	(.O(),  	 .I(uart1_out1n), .IO(X_uart1_out1n), .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_out2n_pad	(.O(),  	 .I(uart1_out2n), .IO(X_uart1_out2n), .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_dcdn_pad	(.O(uart1_dcdn),  .I(1'b0),       .IO(X_uart1_dcdn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_dsrn_pad	(.O(uart1_dsrn),  .I(1'b0),       .IO(X_uart1_dsrn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart1_rin_pad	(.O(uart1_rin),   .I(1'b0),       .IO(X_uart1_rin),   .E(1'b0),  .PU(1'b0), .PD(1'b0));
	`endif
	`ifdef AE250_UART2_SUPPORT
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

`ifdef AE250_UART2_SUPPORT
	`ifndef NDS_BOARD_CF1
nds_inout_pad uart2_txd_pad	(.O(),  	 .I(uart2_txd),  .IO(X_uart2_txd),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_rxd_pad	(.O(uart2_rxd),  .I(1'b0),       .IO(X_uart2_rxd),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
	`endif
	`ifdef NDS_FPGA
assign	uart2_dcdn = 1'b1;
assign	uart2_dsrn = 1'b1;
assign	uart2_rin  = 1'b1;
	`else
nds_inout_pad uart2_dtrn_pad	(.O(),  	 .I(uart2_dtrn),  .IO(X_uart2_dtrn),  .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_out1n_pad	(.O(),  	 .I(uart2_out1n), .IO(X_uart2_out1n), .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_out2n_pad	(.O(),  	 .I(uart2_out2n), .IO(X_uart2_out2n), .E(1'b1),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_dcdn_pad	(.O(uart2_dcdn),  .I(1'b0),       .IO(X_uart2_dcdn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_dsrn_pad	(.O(uart2_dsrn),  .I(1'b0),       .IO(X_uart2_dsrn),  .E(1'b0),  .PU(1'b0), .PD(1'b0));
nds_inout_pad uart2_rin_pad	(.O(uart2_rin),   .I(1'b0),       .IO(X_uart2_rin),   .E(1'b0),  .PU(1'b0), .PD(1'b0));
	`endif
`endif

`ifndef NDS_BOARD_CF1
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
nds_inout_pad gpio12_pad	(.O(gpio_in_12), .I(gpio_out_12), .IO(X_gpio[12]), .E(gpio_oe_12),  .PU(gpio_pullup_12), .PD(gpio_pulldown_12));
nds_inout_pad gpio13_pad	(.O(gpio_in_13), .I(gpio_out_13), .IO(X_gpio[13]), .E(gpio_oe_13),  .PU(gpio_pullup_13), .PD(gpio_pulldown_13));
nds_inout_pad gpio14_pad	(.O(gpio_in_14), .I(gpio_out_14), .IO(X_gpio[14]), .E(gpio_oe_14),  .PU(gpio_pullup_14), .PD(gpio_pulldown_14));
nds_inout_pad gpio15_pad	(.O(gpio_in_15), .I(gpio_out_15), .IO(X_gpio[15]), .E(gpio_oe_15),  .PU(gpio_pullup_15), .PD(gpio_pulldown_15));
nds_inout_pad gpio16_pad	(.O(gpio_in_16), .I(gpio_out_16), .IO(X_gpio[16]), .E(gpio_oe_16),  .PU(gpio_pullup_16), .PD(gpio_pulldown_16));
nds_inout_pad gpio17_pad	(.O(gpio_in_17), .I(gpio_out_17), .IO(X_gpio[17]), .E(gpio_oe_17),  .PU(gpio_pullup_17), .PD(gpio_pulldown_17));
nds_inout_pad gpio18_pad	(.O(gpio_in_18), .I(gpio_out_18), .IO(X_gpio[18]), .E(gpio_oe_18),  .PU(gpio_pullup_18), .PD(gpio_pulldown_18));
nds_inout_pad gpio19_pad	(.O(gpio_in_19), .I(gpio_out_19), .IO(X_gpio[19]), .E(gpio_oe_19),  .PU(gpio_pullup_19), .PD(gpio_pulldown_19));
nds_inout_pad gpio20_pad	(.O(gpio_in_20), .I(gpio_out_20), .IO(X_gpio[20]), .E(gpio_oe_20),  .PU(gpio_pullup_20), .PD(gpio_pulldown_20));
nds_inout_pad gpio21_pad	(.O(gpio_in_21), .I(gpio_out_21), .IO(X_gpio[21]), .E(gpio_oe_21),  .PU(gpio_pullup_21), .PD(gpio_pulldown_21));
nds_inout_pad gpio22_pad	(.O(gpio_in_22), .I(gpio_out_22), .IO(X_gpio[22]), .E(gpio_oe_22),  .PU(gpio_pullup_22), .PD(gpio_pulldown_22));
nds_inout_pad gpio23_pad	(.O(gpio_in_23), .I(gpio_out_23), .IO(X_gpio[23]), .E(gpio_oe_23),  .PU(gpio_pullup_23), .PD(gpio_pulldown_23));
nds_inout_pad gpio24_pad	(.O(gpio_in_24), .I(gpio_out_24), .IO(X_gpio[24]), .E(gpio_oe_24),  .PU(gpio_pullup_24), .PD(gpio_pulldown_24));
nds_inout_pad gpio25_pad	(.O(gpio_in_25), .I(gpio_out_25), .IO(X_gpio[25]), .E(gpio_oe_25),  .PU(gpio_pullup_25), .PD(gpio_pulldown_25));
nds_inout_pad gpio26_pad	(.O(gpio_in_26), .I(gpio_out_26), .IO(X_gpio[26]), .E(gpio_oe_26),  .PU(gpio_pullup_26), .PD(gpio_pulldown_26));
nds_inout_pad gpio27_pad	(.O(gpio_in_27), .I(gpio_out_27), .IO(X_gpio[27]), .E(gpio_oe_27),  .PU(gpio_pullup_27), .PD(gpio_pulldown_27));
nds_inout_pad gpio28_pad	(.O(gpio_in_28), .I(gpio_out_28), .IO(X_gpio[28]), .E(gpio_oe_28),  .PU(gpio_pullup_28), .PD(gpio_pulldown_28));
nds_inout_pad gpio29_pad	(.O(gpio_in_29), .I(gpio_out_29), .IO(X_gpio[29]), .E(gpio_oe_29),  .PU(gpio_pullup_29), .PD(gpio_pulldown_29));
nds_inout_pad gpio30_pad	(.O(gpio_in_30), .I(gpio_out_30), .IO(X_gpio[30]), .E(gpio_oe_30),  .PU(gpio_pullup_30), .PD(gpio_pulldown_30));
nds_inout_pad gpio31_pad	(.O(gpio_in_31), .I(gpio_out_31), .IO(X_gpio[31]), .E(gpio_oe_31),  .PU(gpio_pullup_31), .PD(gpio_pulldown_31));

`ifdef NDS_BOARD_CF1
wire	[63:0]	cf1_pinmux_ctrls = {cf1_pinmux_ctrl1, cf1_pinmux_ctrl0};
`else
wire	[63:0]	cf1_pinmux_ctrls = 64'b10_10_10_10_10_10_00_00_00_00_00_00_00_00_10_10_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00;
`endif

wire [1:0]	pm_sel_12 = cf1_pinmux_ctrls[25:24];
wire [1:0]	pm_sel_13 = cf1_pinmux_ctrls[27:26];
wire [1:0]	pm_sel_14 = cf1_pinmux_ctrls[29:28];
wire [1:0]	pm_sel_15 = cf1_pinmux_ctrls[31:30];
wire [1:0]	pm_sel_16 = cf1_pinmux_ctrls[33:32];
wire [1:0]	pm_sel_17 = cf1_pinmux_ctrls[35:34];
wire [1:0]	pm_sel_18 = cf1_pinmux_ctrls[37:36];
wire [1:0]	pm_sel_19 = cf1_pinmux_ctrls[39:38];
wire [1:0]	pm_sel_20 = cf1_pinmux_ctrls[41:40];
wire [1:0]	pm_sel_21 = cf1_pinmux_ctrls[43:42];
wire [1:0]	pm_sel_22 = cf1_pinmux_ctrls[45:44];
wire [1:0]	pm_sel_23 = cf1_pinmux_ctrls[47:46];
wire [1:0]	pm_sel_24 = cf1_pinmux_ctrls[49:48];
wire [1:0]	pm_sel_25 = cf1_pinmux_ctrls[51:50];
wire [1:0]	pm_sel_26 = cf1_pinmux_ctrls[53:52];
wire [1:0]	pm_sel_27 = cf1_pinmux_ctrls[55:54];
wire [1:0]	pm_sel_28 = cf1_pinmux_ctrls[57:56];
wire [1:0]	pm_sel_29 = cf1_pinmux_ctrls[59:58];
wire [1:0]	pm_sel_30 = cf1_pinmux_ctrls[61:60];
wire [1:0]	pm_sel_31 = cf1_pinmux_ctrls[63:62];

assign gpio_in[12]	= (pm_sel_12==2'd0) ? gpio_in_12 : 1'b0;
assign gpio_in[13]	= (pm_sel_13==2'd0) ? gpio_in_13 : 1'b0;
assign gpio_in[14]	= (pm_sel_14==2'd0) ? gpio_in_14 : 1'b0;
assign gpio_in[15]	= (pm_sel_15==2'd0) ? gpio_in_15 : 1'b0;
assign gpio_in[16]	= (pm_sel_16==2'd2) ? gpio_in_16 : 1'b0;
assign gpio_in[17]	= (pm_sel_17==2'd2) ? gpio_in_17 : 1'b0;
assign gpio_in[18]	= (pm_sel_18==2'd0) ? gpio_in_18 : 1'b0;
assign gpio_in[19]	= (pm_sel_19==2'd0) ? gpio_in_19 : 1'b0;
assign gpio_in[20]	= (pm_sel_20==2'd0) ? gpio_in_20 : 1'b0;
assign gpio_in[21]	= (pm_sel_21==2'd0) ? gpio_in_21 : 1'b0;
assign gpio_in[22]	= (pm_sel_22==2'd0) ? gpio_in_22 : 1'b0;
assign gpio_in[23]	= (pm_sel_23==2'd0) ? gpio_in_23 : 1'b0;
assign gpio_in[24]	= (pm_sel_24==2'd0) ? gpio_in_24 : 1'b0;
assign gpio_in[25]	= (pm_sel_25==2'd0) ? gpio_in_25 : 1'b0;
assign gpio_in[26]	= (pm_sel_26==2'd2) ? gpio_in_26 : 1'b0;
assign gpio_in[27]	= (pm_sel_27==2'd2) ? gpio_in_27 : 1'b0;
assign gpio_in[28]	= (pm_sel_28==2'd2) ? gpio_in_28 : 1'b0;
assign gpio_in[29]	= (pm_sel_29==2'd2) ? gpio_in_29 : 1'b0;
assign gpio_in[30]	= (pm_sel_30==2'd2) ? gpio_in_30 : 1'b0;
assign gpio_in[31]	= (pm_sel_31==2'd2) ? gpio_in_31 : 1'b0;

`ifdef AE250_I2C2_SUPPORT
assign i2c2_sda_in	= (pm_sel_24==2'd2) ? gpio_in_24 : 1'b0;
assign i2c2_scl_in	= (pm_sel_25==2'd2) ? gpio_in_25 : 1'b0;
`endif

`ifdef NDS_BOARD_CF1
assign uart2_rxd	= (pm_sel_16==2'd0) ? gpio_in_16 : 1'b0;
assign uart1_rxd	= (pm_sel_18==2'd2) ? gpio_in_18 : 1'b0;

assign spi2_csn_in	= (pm_sel_26==2'd0) ? gpio_in_26 : 1'b0;
assign spi2_mosi_in	= (pm_sel_27==2'd0) ? gpio_in_27 : 1'b0;
assign spi2_miso_in	= (pm_sel_28==2'd0) ? gpio_in_28 : 1'b0;
assign spi2_clk_in	= (pm_sel_29==2'd0) ? gpio_in_29 : 1'b0;

assign i2c_sda_in	= (pm_sel_30==2'd0) ? gpio_in_30 : 1'b0;
assign i2c_scl_in	= (pm_sel_31==2'd0) ? gpio_in_31 : 1'b0;
`endif


assign gpio_out_12	= (pm_sel_12==2'd0) ? gpio_out[12]	: (pm_sel_12==2'd1) ? pit2_ch0_pwm	: (pm_sel_12==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_13	= (pm_sel_13==2'd0) ? gpio_out[13]	: (pm_sel_13==2'd1) ? pit2_ch1_pwm	: (pm_sel_13==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_14	= (pm_sel_14==2'd0) ? gpio_out[14]	: (pm_sel_14==2'd1) ? pit2_ch2_pwm	: (pm_sel_14==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_15	= (pm_sel_15==2'd0) ? gpio_out[15]	: (pm_sel_15==2'd1) ? pit2_ch3_pwm	: (pm_sel_15==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_16	= (pm_sel_16==2'd0) ? 1'b0	: (pm_sel_16==2'd1) ? pit3_ch0_pwm	: (pm_sel_16==2'd2) ? gpio_out[16]	: 1'b0;
assign gpio_out_17	= (pm_sel_17==2'd0) ? uart2_txd		: (pm_sel_17==2'd1) ? pit3_ch1_pwm	: (pm_sel_17==2'd2) ? gpio_out[17]	: 1'b0;
assign gpio_out_18	= (pm_sel_18==2'd0) ? gpio_out[18]	: (pm_sel_18==2'd1) ? pit3_ch2_pwm	: (pm_sel_18==2'd2) ? 1'b0	: 1'b0;
assign gpio_out_19	= (pm_sel_19==2'd0) ? gpio_out[19]	: (pm_sel_19==2'd1) ? pit3_ch3_pwm	: (pm_sel_19==2'd2) ? uart1_txd		: 1'b0;
assign gpio_out_20	= (pm_sel_20==2'd0) ? gpio_out[20]	: (pm_sel_20==2'd1) ? pit4_ch0_pwm	: (pm_sel_20==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_21	= (pm_sel_21==2'd0) ? gpio_out[21]	: (pm_sel_21==2'd1) ? pit4_ch1_pwm	: (pm_sel_21==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_22	= (pm_sel_22==2'd0) ? gpio_out[22]	: (pm_sel_22==2'd1) ? pit4_ch2_pwm	: (pm_sel_22==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_23	= (pm_sel_23==2'd0) ? gpio_out[23]	: (pm_sel_23==2'd1) ? pit4_ch3_pwm	: (pm_sel_23==2'd2) ? 1'b0		: 1'b0;
assign gpio_out_24	= (pm_sel_24==2'd0) ? gpio_out[24]	: (pm_sel_24==2'd1) ? pit5_ch0_pwm	: (pm_sel_24==2'd2) ? 1'b0	: 1'b0;
assign gpio_out_25	= (pm_sel_25==2'd0) ? gpio_out[25]	: (pm_sel_25==2'd1) ? pit5_ch1_pwm	: (pm_sel_25==2'd2) ? 1'b0	: 1'b0;
assign gpio_out_26	= (pm_sel_26==2'd0) ? spi2_csn_out	: (pm_sel_26==2'd1) ? pit5_ch2_pwm	: (pm_sel_26==2'd2) ? gpio_out[26]	: 1'b0;
assign gpio_out_27	= (pm_sel_27==2'd0) ? spi2_mosi_out	: (pm_sel_27==2'd1) ? pit5_ch3_pwm	: (pm_sel_27==2'd2) ? gpio_out[27]	: 1'b0;
assign gpio_out_28	= (pm_sel_28==2'd0) ? spi2_miso_out	: (pm_sel_28==2'd1) ? 1'b0		: (pm_sel_28==2'd2) ? gpio_out[28]	: 1'b0;
assign gpio_out_29	= (pm_sel_29==2'd0) ? spi2_clk_out	: (pm_sel_29==2'd1) ? 1'b0		: (pm_sel_29==2'd2) ? gpio_out[29]	: 1'b0;
assign gpio_out_30	= (pm_sel_30==2'd0) ? 1'b0	: (pm_sel_30==2'd1) ? 1'b0		: (pm_sel_30==2'd2) ? gpio_out[30]	: 1'b0;
assign gpio_out_31	= (pm_sel_31==2'd0) ? 1'b0	: (pm_sel_31==2'd1) ? 1'b0		: (pm_sel_31==2'd2) ? gpio_out[31]	: 1'b0;

assign gpio_oe_12	= (pm_sel_12==2'd0) ? gpio_oe[12]	: (pm_sel_12==2'd1) ? pit2_ch0_pwmoe	: (pm_sel_12==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_13	= (pm_sel_13==2'd0) ? gpio_oe[13]	: (pm_sel_13==2'd1) ? pit2_ch1_pwmoe	: (pm_sel_13==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_14	= (pm_sel_14==2'd0) ? gpio_oe[14]	: (pm_sel_14==2'd1) ? pit2_ch2_pwmoe	: (pm_sel_14==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_15	= (pm_sel_15==2'd0) ? gpio_oe[15]	: (pm_sel_15==2'd1) ? pit2_ch3_pwmoe	: (pm_sel_15==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_16	= (pm_sel_16==2'd0) ? 1'b0	: (pm_sel_16==2'd1) ? pit3_ch0_pwmoe	: (pm_sel_16==2'd2) ? gpio_oe[16]	: 1'b0;
assign gpio_oe_17	= (pm_sel_17==2'd0) ? 1'b1	: (pm_sel_17==2'd1) ? pit3_ch1_pwmoe	: (pm_sel_17==2'd2) ? gpio_oe[17]	: 1'b0;
assign gpio_oe_18	= (pm_sel_18==2'd0) ? gpio_oe[18]	: (pm_sel_18==2'd1) ? pit3_ch2_pwmoe	: (pm_sel_18==2'd2) ? 1'b0	: 1'b0;
assign gpio_oe_19	= (pm_sel_19==2'd0) ? gpio_oe[19]	: (pm_sel_19==2'd1) ? pit3_ch3_pwmoe	: (pm_sel_19==2'd2) ? 1'b1	: 1'b0;
assign gpio_oe_20	= (pm_sel_20==2'd0) ? gpio_oe[20]	: (pm_sel_20==2'd1) ? pit4_ch0_pwmoe	: (pm_sel_20==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_21	= (pm_sel_21==2'd0) ? gpio_oe[21]	: (pm_sel_21==2'd1) ? pit4_ch1_pwmoe	: (pm_sel_21==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_22	= (pm_sel_22==2'd0) ? gpio_oe[22]	: (pm_sel_22==2'd1) ? pit4_ch2_pwmoe	: (pm_sel_22==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_23	= (pm_sel_23==2'd0) ? gpio_oe[23]	: (pm_sel_23==2'd1) ? pit4_ch3_pwmoe	: (pm_sel_23==2'd2) ? 1'b0		: 1'b0;
assign gpio_oe_24	= (pm_sel_24==2'd0) ? gpio_oe[24]	: (pm_sel_24==2'd1) ? pit5_ch0_pwmoe	: (pm_sel_24==2'd2) ? ~i2c2_sda		: 1'b0;
assign gpio_oe_25	= (pm_sel_25==2'd0) ? gpio_oe[25]	: (pm_sel_25==2'd1) ? pit5_ch1_pwmoe	: (pm_sel_25==2'd2) ? ~i2c2_scl		: 1'b0;
assign gpio_oe_26	= (pm_sel_26==2'd0) ? spi2_csn_oe	: (pm_sel_26==2'd1) ? pit5_ch2_pwmoe	: (pm_sel_26==2'd2) ? gpio_oe[26]	: 1'b0;
assign gpio_oe_27	= (pm_sel_27==2'd0) ? spi2_mosi_oe	: (pm_sel_27==2'd1) ? pit5_ch3_pwmoe	: (pm_sel_27==2'd2) ? gpio_oe[27]	: 1'b0;
assign gpio_oe_28	= (pm_sel_28==2'd0) ? spi2_miso_oe	: (pm_sel_28==2'd1) ? 1'b0		: (pm_sel_28==2'd2) ? gpio_oe[28]	: 1'b0;
assign gpio_oe_29	= (pm_sel_29==2'd0) ? spi2_clk_oe	: (pm_sel_29==2'd1) ? 1'b0		: (pm_sel_29==2'd2) ? gpio_oe[29]	: 1'b0;
assign gpio_oe_30	= (pm_sel_30==2'd0) ? ~i2c_sda		: (pm_sel_30==2'd1) ? 1'b0		: (pm_sel_30==2'd2) ? gpio_oe[30]	: 1'b0;
assign gpio_oe_31	= (pm_sel_31==2'd0) ? ~i2c_scl		: (pm_sel_31==2'd1) ? 1'b0		: (pm_sel_31==2'd2) ? gpio_oe[31]	: 1'b0;

assign gpio_pullup_12	= (pm_sel_12==2'd0) ? gpio_pullup[12]	: (pm_sel_12==2'd1) ? 1'b0		: (pm_sel_12==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_13	= (pm_sel_13==2'd0) ? gpio_pullup[13]	: (pm_sel_13==2'd1) ? 1'b0		: (pm_sel_13==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_14	= (pm_sel_14==2'd0) ? gpio_pullup[14]	: (pm_sel_14==2'd1) ? 1'b0		: (pm_sel_14==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_15	= (pm_sel_15==2'd0) ? gpio_pullup[15]	: (pm_sel_15==2'd1) ? 1'b0		: (pm_sel_15==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_16	= (pm_sel_16==2'd0) ? 1'b0		: (pm_sel_16==2'd1) ? 1'b0		: (pm_sel_16==2'd2) ? gpio_pullup[16]	: 1'b0;
assign gpio_pullup_17	= (pm_sel_17==2'd0) ? 1'b0		: (pm_sel_17==2'd1) ? 1'b0		: (pm_sel_17==2'd2) ? gpio_pullup[17]	: 1'b0;
assign gpio_pullup_18	= (pm_sel_18==2'd0) ? gpio_pullup[18]	: (pm_sel_18==2'd1) ? 1'b0		: (pm_sel_18==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_19	= (pm_sel_19==2'd0) ? gpio_pullup[19]	: (pm_sel_19==2'd1) ? 1'b0		: (pm_sel_19==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_20	= (pm_sel_20==2'd0) ? gpio_pullup[20]	: (pm_sel_20==2'd1) ? 1'b0		: (pm_sel_20==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_21	= (pm_sel_21==2'd0) ? gpio_pullup[21]	: (pm_sel_21==2'd1) ? 1'b0		: (pm_sel_21==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_22	= (pm_sel_22==2'd0) ? gpio_pullup[22]	: (pm_sel_22==2'd1) ? 1'b0		: (pm_sel_22==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_23	= (pm_sel_23==2'd0) ? gpio_pullup[23]	: (pm_sel_23==2'd1) ? 1'b0		: (pm_sel_23==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_24	= (pm_sel_24==2'd0) ? gpio_pullup[24]	: (pm_sel_24==2'd1) ? 1'b0		: (pm_sel_24==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_25	= (pm_sel_25==2'd0) ? gpio_pullup[25]	: (pm_sel_25==2'd1) ? 1'b0		: (pm_sel_25==2'd2) ? 1'b0		: 1'b0;
assign gpio_pullup_26	= (pm_sel_26==2'd0) ? 1'b0		: (pm_sel_26==2'd1) ? 1'b0		: (pm_sel_26==2'd2) ? gpio_pullup[26]	: 1'b0;
assign gpio_pullup_27	= (pm_sel_27==2'd0) ? 1'b0		: (pm_sel_27==2'd1) ? 1'b0		: (pm_sel_27==2'd2) ? gpio_pullup[27]	: 1'b0;
assign gpio_pullup_28	= (pm_sel_28==2'd0) ? 1'b0		: (pm_sel_28==2'd1) ? 1'b0		: (pm_sel_28==2'd2) ? gpio_pullup[28]	: 1'b0;
assign gpio_pullup_29	= (pm_sel_29==2'd0) ? 1'b0		: (pm_sel_29==2'd1) ? 1'b0		: (pm_sel_29==2'd2) ? gpio_pullup[29]	: 1'b0;
assign gpio_pullup_30	= (pm_sel_30==2'd0) ? 1'b0		: (pm_sel_30==2'd1) ? 1'b0		: (pm_sel_30==2'd2) ? gpio_pullup[30]	: 1'b0;
assign gpio_pullup_31	= (pm_sel_31==2'd0) ? 1'b0		: (pm_sel_31==2'd1) ? 1'b0		: (pm_sel_31==2'd2) ? gpio_pullup[31]	: 1'b0;

assign gpio_pulldown_12	= (pm_sel_12==2'd0) ? gpio_pulldown[12]	: (pm_sel_12==2'd1) ? 1'b0		: (pm_sel_12==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_13	= (pm_sel_13==2'd0) ? gpio_pulldown[13]	: (pm_sel_13==2'd1) ? 1'b0		: (pm_sel_13==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_14	= (pm_sel_14==2'd0) ? gpio_pulldown[14]	: (pm_sel_14==2'd1) ? 1'b0		: (pm_sel_14==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_15	= (pm_sel_15==2'd0) ? gpio_pulldown[15]	: (pm_sel_15==2'd1) ? 1'b0		: (pm_sel_15==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_16	= (pm_sel_16==2'd0) ? 1'b0		: (pm_sel_16==2'd1) ? 1'b0		: (pm_sel_16==2'd2) ? gpio_pulldown[16]	: 1'b0;
assign gpio_pulldown_17	= (pm_sel_17==2'd0) ? 1'b0		: (pm_sel_17==2'd1) ? 1'b0		: (pm_sel_17==2'd2) ? gpio_pulldown[17]	: 1'b0;
assign gpio_pulldown_18	= (pm_sel_18==2'd0) ? gpio_pulldown[18]	: (pm_sel_18==2'd1) ? 1'b0		: (pm_sel_18==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_19	= (pm_sel_19==2'd0) ? gpio_pulldown[19]	: (pm_sel_19==2'd1) ? 1'b0		: (pm_sel_19==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_20	= (pm_sel_20==2'd0) ? gpio_pulldown[20]	: (pm_sel_20==2'd1) ? 1'b0		: (pm_sel_20==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_21	= (pm_sel_21==2'd0) ? gpio_pulldown[21]	: (pm_sel_21==2'd1) ? 1'b0		: (pm_sel_21==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_22	= (pm_sel_22==2'd0) ? gpio_pulldown[22]	: (pm_sel_22==2'd1) ? 1'b0		: (pm_sel_22==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_23	= (pm_sel_23==2'd0) ? gpio_pulldown[23]	: (pm_sel_23==2'd1) ? 1'b0		: (pm_sel_23==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_24	= (pm_sel_24==2'd0) ? gpio_pulldown[24]	: (pm_sel_24==2'd1) ? 1'b0		: (pm_sel_24==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_25	= (pm_sel_25==2'd0) ? gpio_pulldown[25]	: (pm_sel_25==2'd1) ? 1'b0		: (pm_sel_25==2'd2) ? 1'b0		: 1'b0;
assign gpio_pulldown_26	= (pm_sel_26==2'd0) ? 1'b0		: (pm_sel_26==2'd1) ? 1'b0		: (pm_sel_26==2'd2) ? gpio_pulldown[26]	: 1'b0;
assign gpio_pulldown_27	= (pm_sel_27==2'd0) ? 1'b0		: (pm_sel_27==2'd1) ? 1'b0		: (pm_sel_27==2'd2) ? gpio_pulldown[27]	: 1'b0;
assign gpio_pulldown_28	= (pm_sel_28==2'd0) ? 1'b0		: (pm_sel_28==2'd1) ? 1'b0		: (pm_sel_28==2'd2) ? gpio_pulldown[28]	: 1'b0;
assign gpio_pulldown_29	= (pm_sel_29==2'd0) ? 1'b0		: (pm_sel_29==2'd1) ? 1'b0		: (pm_sel_29==2'd2) ? gpio_pulldown[29]	: 1'b0;
assign gpio_pulldown_30	= (pm_sel_30==2'd0) ? 1'b0		: (pm_sel_30==2'd1) ? 1'b0		: (pm_sel_30==2'd2) ? gpio_pulldown[30]	: 1'b0;
assign gpio_pulldown_31	= (pm_sel_31==2'd0) ? 1'b0		: (pm_sel_31==2'd1) ? 1'b0		: (pm_sel_31==2'd2) ? gpio_pulldown[31]	: 1'b0;

endmodule

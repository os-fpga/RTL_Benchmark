// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "ae250_config.vh"
`include "ae250_const.vh"
`include "config.inc"
`include "global.inc"

`include "atcgpio100_config.vh"
`include "atcgpio100_const.vh"
`include "atcpit100_config.vh"
`include "atcpit100_const.vh"
`include "atcwdt200_config.vh"
`include "atcwdt200_const.vh"
`include "atcrtc100_config.vh"
`include "atcrtc100_const.vh"

`ifdef AE250_SPI1_SUPPORT
	`define _AE250_SPI_SUPPORT
`elsif AE250_SPI2_SUPPORT
	`define _AE250_SPI_SUPPORT
`elsif AE250_SPI3_SUPPORT
	`define _AE250_SPI_SUPPORT
`elsif AE250_SPI4_SUPPORT
	`define _AE250_SPI_SUPPORT
`endif

`ifdef _AE250_SPI_SUPPORT
	`include "atcspi200_config.vh"
	`include "atcspi200_const.vh"
	`undef _AE250_SPI_SUPPORT
`endif

`ifdef AE250_I2C_SUPPORT
	`define _AE250_I2C_SUPPORT
`elsif AE250_I2C2_SUPPORT
	`define _AE250_I2C_SUPPORT
`endif

`ifdef _AE250_I2C_SUPPORT
	`include "atciic100_config.vh"
	`include "atciic100_const.vh"
	`undef _AE250_I2C_SUPPORT
`endif

`ifdef _AE250_UART_SUPPORT
	`include "atcuart100_config.vh"
	`include "atcuart100_const.vh"
	`undef _AE250_UART_SUPPORT
`endif

`include "atcbmc200_config.vh"
`include "atcbmc200_const.vh"
`include "atcapbbrg100_config.vh"
`include "atcapbbrg100_const.vh"

`ifdef AE250_DMA_SUPPORT
	`include "atcdmac100_config.vh"
	`include "atcdmac100_const.vh"
`endif



`ifndef AE250_DMA_EXTREQ_SUPPORT
	`define AE250_DMA_EXTREQ_NUM	6'd0
`endif


module ae250_chip (
`ifdef NDS_FPGA
`else
	  X_pd_pwr_off,
	  X_om,
`endif
`ifdef AE250_SPI1_SUPPORT
	  X_spi1_clk,
	  X_spi1_csn,
	  X_spi1_miso,
	  X_spi1_mosi,
`endif
`ifdef PLATFORM_DEBUG_PORT
	  X_tms,
	  X_tck,
`endif
`ifdef AE250_SPI3_SUPPORT
	  X_spi3_clk,
	  X_spi3_csn,
	  X_spi3_miso,
	  X_spi3_mosi,
`endif
`ifdef AE250_SPI4_SUPPORT
	  X_spi4_clk,
	  X_spi4_csn,
	  X_spi4_miso,
	  X_spi4_mosi,
`endif
`ifdef AE250_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  X_spi1_holdn,
	  X_spi1_wpn,
   `endif
`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef AE250_JTAG_TWOWIRE
   `else
	  X_tdi,
	  X_tdo,
	  X_trst,
   `endif
`endif
`ifdef NDS_BOARD_CF1
`else
   `ifdef AE250_SPI2_SUPPORT
	  X_spi2_clk,
	  X_spi2_csn,
	  X_spi2_miso,
	  X_spi2_mosi,
   `endif
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE250_SPI2_SUPPORT
	  X_spi2_holdn,
	  X_spi2_wpn,
   `endif
   `ifdef AE250_SPI3_SUPPORT
	  X_spi3_holdn,
	  X_spi3_wpn,
   `endif
   `ifdef AE250_SPI4_SUPPORT
	  X_spi4_holdn,
	  X_spi4_wpn,
   `endif
`endif
`ifdef NDS_BOARD_CF1
`else
   `ifdef AE250_I2C_SUPPORT
	  X_i2c_scl,
	  X_i2c_sda,
   `endif
   `ifdef AE250_UART1_SUPPORT
	  X_uart1_dcdn,
	  X_uart1_dsrn,
	  X_uart1_dtrn,
	  X_uart1_out1n,
	  X_uart1_out2n,
	  X_uart1_rin,
	  X_uart1_rxd,
	  X_uart1_txd,
   `endif
`endif
`ifdef AE250_UART1_SUPPORT
   `ifdef AE250_UART2_SUPPORT
   `else
	  X_uart1_ctsn,
	  X_uart1_rtsn,
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE250_UART2_SUPPORT
	  X_uart2_ctsn,
	  X_uart2_dcdn,
	  X_uart2_dsrn,
	  X_uart2_dtrn,
	  X_uart2_out1n,
	  X_uart2_out2n,
	  X_uart2_rin,
	  X_uart2_rtsn,
   `endif
`endif
`ifdef NDS_BOARD_CF1
`else
   `ifdef AE250_UART2_SUPPORT
	  X_uart2_rxd,
	  X_uart2_txd,
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE250_UART1_SUPPORT
      `ifdef AE250_UART2_SUPPORT
	  X_uart1_ctsn,
	  X_uart1_rtsn,
      `endif
   `endif
`endif
	  X_gpio,
	  X_hw_rstn,
	  X_oschin,
	  X_oschio,
	  X_por_b,
	  X_pwm_ch0,
	  X_pwm_ch1,
	  X_pwm_ch2,
	  X_pwm_ch3,
	  X_aopd_por_b,
	  X_mpd_pwr_off,
	  X_osclin,
	  X_osclio,
	  X_rtc_wakeup,
	  X_wakeup_in
);

parameter SIMULATION = "FALSE" ;
parameter SIM_BYPASS_INIT_CAL = "OFF" ;
`ifdef AE250_DMA_SUPPORT
parameter DMA_ACK_MSB = `ATCDMAC100_REQ_ACK_NUM-6'd1;
`else
parameter DMA_ACK_MSB = 8;
`endif

localparam AE250_PADDR_WIDTH	= `AE250_PADDR_MSB + 1;
localparam AE250_DATA_WIDTH	= `AE250_DATA_MSB + 1;
localparam NDS_BIU_ADDR_WIDTH	= `NDS_BIU_ADDR_WIDTH;
localparam NDS_BIU_DATA_WIDTH	= `NDS_BIU_DATA_WIDTH;
localparam ISA_BASE		= `NDS_ISA_BASE;
localparam PALEN			= `NDS_BIU_ADDR_WIDTH;
localparam MMU_SCHEME		= `NDS_MMU_SCHEME;
localparam VALEN			= (MMU_SCHEME == "bare") ? PALEN : (MMU_SCHEME == "sv32") ? 32 : (MMU_SCHEME == "sv39") ? 39: 48;
localparam XLEN			= ISA_BASE == "rv64i" ? 64 : 32;
localparam PLIC_ADDR_WIDTH = `AE250_HADDR_MSB+1;
localparam PLIC_TARGET_NUM = 5'd1;
`ifdef AE250_SPI1_SUPPORT
   `ifdef NCEEIC050_SUPPORT
localparam NCEEIC050_ADDR_WIDTH = 20;
localparam CACHE_WAY_NUM        = 2;
localparam CACHE_RAM_SIZE_KB    = 8;
localparam CACHE_LINE_SIZE      = `NDS_CACHE_LINE_SIZE;
localparam FILL_START_ADDR      = "critical";
localparam DATA_WIDTH           = 32;
localparam BANK_RAM_SIZE        = (CACHE_RAM_SIZE_KB<<10)/CACHE_WAY_NUM;
localparam TAG_ADDR_MSB         = NCEEIC050_ADDR_WIDTH - 1;
localparam TAG_ADDR_LSB         = $clog2(BANK_RAM_SIZE);
localparam WAY_ADDR 	     = TAG_ADDR_LSB - 1;
localparam TAG_RAM_INDEX_MSB    = $clog2(BANK_RAM_SIZE)-1;
localparam TAG_RAM_INDEX_LSB    = $clog2(CACHE_LINE_SIZE);
localparam LINE_ADDR_MSB        = $clog2(CACHE_LINE_SIZE)-1;
localparam LINE_ADDR_LSB        = $clog2(DATA_WIDTH/8);
localparam TAG_WIDTH            = TAG_ADDR_MSB - TAG_ADDR_LSB + 1 + 1;
localparam TAG_RAM_INDEX_WIDTH  = TAG_RAM_INDEX_MSB - TAG_RAM_INDEX_LSB + 1;
localparam TAG_RAM_ENTRY        = 1 << TAG_RAM_INDEX_WIDTH;
localparam DATA_RAM_INDEX_MSB   = TAG_RAM_INDEX_MSB;
localparam DATA_RAM_INDEX_LSB   = LINE_ADDR_LSB;
localparam DATA_RAM_INDEX_WIDTH = DATA_RAM_INDEX_MSB - DATA_RAM_INDEX_LSB + 1;
localparam CLOCK_RATIO_SUPPORT =  `NDS_CLOCK_RATIO_SUPPORT;
   `endif
`endif

`ifdef NDS_FPGA
`else
inout              X_pd_pwr_off;
inout              X_om;
`endif
`ifdef AE250_SPI1_SUPPORT
inout              X_spi1_clk;
inout              X_spi1_csn;
inout              X_spi1_miso;
inout              X_spi1_mosi;
`endif
`ifdef PLATFORM_DEBUG_PORT
inout              X_tms;
inout              X_tck;
`endif
`ifdef AE250_SPI3_SUPPORT
inout              X_spi3_clk;
inout              X_spi3_csn;
inout              X_spi3_miso;
inout              X_spi3_mosi;
`endif
`ifdef AE250_SPI4_SUPPORT
inout              X_spi4_clk;
inout              X_spi4_csn;
inout              X_spi4_miso;
inout              X_spi4_mosi;
`endif
`ifdef AE250_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
inout              X_spi1_holdn;
inout              X_spi1_wpn;
   `endif
`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef AE250_JTAG_TWOWIRE
   `else
inout              X_tdi;
inout              X_tdo;
inout              X_trst;
   `endif
`endif
`ifdef NDS_BOARD_CF1
`else
   `ifdef AE250_SPI2_SUPPORT
inout              X_spi2_clk;
inout              X_spi2_csn;
inout              X_spi2_miso;
inout              X_spi2_mosi;
   `endif
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE250_SPI2_SUPPORT
inout              X_spi2_holdn;
inout              X_spi2_wpn;
   `endif
   `ifdef AE250_SPI3_SUPPORT
inout              X_spi3_holdn;
inout              X_spi3_wpn;
   `endif
   `ifdef AE250_SPI4_SUPPORT
inout              X_spi4_holdn;
inout              X_spi4_wpn;
   `endif
`endif
`ifdef NDS_BOARD_CF1
`else
   `ifdef AE250_I2C_SUPPORT
inout              X_i2c_scl;
inout              X_i2c_sda;
   `endif
   `ifdef AE250_UART1_SUPPORT
inout              X_uart1_dcdn;
inout              X_uart1_dsrn;
inout              X_uart1_dtrn;
inout              X_uart1_out1n;
inout              X_uart1_out2n;
inout              X_uart1_rin;
inout              X_uart1_rxd;
inout              X_uart1_txd;
   `endif
`endif
`ifdef AE250_UART1_SUPPORT
   `ifdef AE250_UART2_SUPPORT
   `else
inout              X_uart1_ctsn;
inout              X_uart1_rtsn;
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE250_UART2_SUPPORT
inout              X_uart2_ctsn;
inout              X_uart2_dcdn;
inout              X_uart2_dsrn;
inout              X_uart2_dtrn;
inout              X_uart2_out1n;
inout              X_uart2_out2n;
inout              X_uart2_rin;
inout              X_uart2_rtsn;
   `endif
`endif
`ifdef NDS_BOARD_CF1
`else
   `ifdef AE250_UART2_SUPPORT
inout              X_uart2_rxd;
inout              X_uart2_txd;
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE250_UART1_SUPPORT
      `ifdef AE250_UART2_SUPPORT
inout              X_uart1_ctsn;
inout              X_uart1_rtsn;
      `endif
   `endif
`endif
inout       [31:0] X_gpio;
inout              X_hw_rstn;
input              X_oschin;
inout              X_oschio;
inout              X_por_b;
inout              X_pwm_ch0;
inout              X_pwm_ch1;
inout              X_pwm_ch2;
inout              X_pwm_ch3;
inout              X_aopd_por_b;
inout              X_mpd_pwr_off;
input              X_osclin;
inout              X_osclio;
inout              X_rtc_wakeup;
inout              X_wakeup_in;

`ifdef ATCBMC200_AHB_MST2
wire                 [`ATCBMC200_ADDR_MSB:0] hm2_haddr;
wire                                   [2:0] hm2_hburst;
wire                                   [3:0] hm2_hprot;
wire                                   [2:0] hm2_hsize;
wire                                   [1:0] hm2_htrans;
wire                                  [31:0] hm2_hwdata;
wire                                         hm2_hwrite;
wire                                  [31:0] hm2_hrdata;
wire                                         hm2_hready;
wire                                   [1:0] hm2_hresp;
`endif
`ifdef ATCBMC200_AHB_MST3
wire                                  [31:0] hm3_haddr;
wire                                   [2:0] hm3_hburst;
wire                                   [3:0] hm3_hprot;
wire                                   [2:0] hm3_hsize;
wire                                   [1:0] hm3_htrans;
wire                                  [31:0] hm3_hwdata;
wire                                         hm3_hwrite;
wire                                  [31:0] hm3_hrdata;
wire                                         hm3_hready;
wire                                   [1:0] hm3_hresp;
`endif
`ifdef ATCBMC200_AHB_MST4
wire                                  [31:0] hm4_haddr;
wire                                   [2:0] hm4_hburst;
wire                                   [3:0] hm4_hprot;
wire                                   [2:0] hm4_hsize;
wire                                   [1:0] hm4_htrans;
wire                                  [31:0] hm4_hwdata;
wire                                         hm4_hwrite;
wire                                  [31:0] hm4_hrdata;
wire                                         hm4_hready;
wire                                   [1:0] hm4_hresp;
`endif
`ifdef ATCBMC200_AHB_MST5
wire                                  [31:0] hm5_haddr;
wire                                   [2:0] hm5_hburst;
wire                                   [3:0] hm5_hprot;
wire                                   [2:0] hm5_hsize;
wire                                   [1:0] hm5_htrans;
wire                                  [31:0] hm5_hwdata;
wire                                         hm5_hwrite;
wire                                  [31:0] hm5_hrdata;
wire                                         hm5_hready;
wire                                   [1:0] hm5_hresp;
`endif
`ifdef ATCBMC200_AHB_MST6
wire                                  [31:0] hm6_haddr;
wire                                   [2:0] hm6_hburst;
wire                                   [3:0] hm6_hprot;
wire                                   [2:0] hm6_hsize;
wire                                   [1:0] hm6_htrans;
wire                                  [31:0] hm6_hwdata;
wire                                         hm6_hwrite;
wire                                  [31:0] hm6_hrdata;
wire                                         hm6_hready;
wire                                   [1:0] hm6_hresp;
`endif
`ifdef ATCBMC200_AHB_MST7
wire                                  [31:0] hm7_haddr;
wire                                   [2:0] hm7_hburst;
wire                                   [3:0] hm7_hprot;
wire                                   [2:0] hm7_hsize;
wire                                   [1:0] hm7_htrans;
wire                                  [31:0] hm7_hwdata;
wire                                         hm7_hwrite;
wire                                  [31:0] hm7_hrdata;
wire                                         hm7_hready;
wire                                   [1:0] hm7_hresp;
`endif
`ifdef ATCBMC200_AHB_MST8
wire                                  [31:0] hm8_haddr;
wire                                   [2:0] hm8_hburst;
wire                                   [3:0] hm8_hprot;
wire                                   [2:0] hm8_hsize;
wire                                   [1:0] hm8_htrans;
wire                                  [31:0] hm8_hwdata;
wire                                         hm8_hwrite;
wire                                  [31:0] hm8_hrdata;
wire                                         hm8_hready;
wire                                   [1:0] hm8_hresp;
`endif
`ifdef ATCBMC200_AHB_MST9
wire                                  [31:0] hm9_haddr;
wire                                   [2:0] hm9_hburst;
wire                                   [3:0] hm9_hprot;
wire                                   [2:0] hm9_hsize;
wire                                   [1:0] hm9_htrans;
wire                                  [31:0] hm9_hwdata;
wire                                         hm9_hwrite;
wire                                  [31:0] hm9_hrdata;
wire                                         hm9_hready;
wire                                   [1:0] hm9_hresp;
`endif
`ifdef ATCBMC200_AHB_MST10
wire                 [`ATCBMC200_ADDR_MSB:0] hm10_haddr;
wire                                   [2:0] hm10_hburst;
wire                                   [3:0] hm10_hprot;
wire                                   [2:0] hm10_hsize;
wire                                   [1:0] hm10_htrans;
wire                                  [31:0] hm10_hwdata;
wire                                         hm10_hwrite;
wire                                  [31:0] hm10_hrdata;
wire                                         hm10_hready;
wire                                   [1:0] hm10_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV1
wire                                   [2:0] hs1_hburst;
`endif
`ifdef ATCBMC200_AHB_SLV2
wire                                         bmc_hs2_hready;
wire                    [`AE250_HADDR_MSB:0] hs2_haddr;
wire                                   [2:0] hs2_hburst;
wire                                   [3:0] hs2_hprot;
wire                                         hs2_hsel;
wire                                   [2:0] hs2_hsize;
wire                                   [1:0] hs2_htrans;
wire                                  [31:0] hs2_hwdata;
wire                                         hs2_hwrite;
wire                                         hs2_bmc_hready;
wire                                  [31:0] hs2_hrdata;
wire                                   [1:0] hs2_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV3
wire                                         hs3_bmc_hready;
wire                                  [31:0] hs3_hrdata;
wire                                   [1:0] hs3_hresp;
wire                                         bmc_hs3_hready;
wire                    [`AE250_HADDR_MSB:0] hs3_haddr;
wire                                   [2:0] hs3_hburst;
wire                                   [3:0] hs3_hprot;
wire                                         hs3_hsel;
wire                                   [2:0] hs3_hsize;
wire                                   [1:0] hs3_htrans;
wire                                  [31:0] hs3_hwdata;
wire                                         hs3_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV4
wire                                         hs4_bmc_hready;
wire                                  [31:0] hs4_hrdata;
wire                                   [1:0] hs4_hresp;
wire                                         bmc_hs4_hready;
wire                    [`AE250_HADDR_MSB:0] hs4_haddr;
wire                                   [2:0] hs4_hburst;
wire                                   [3:0] hs4_hprot;
wire                                         hs4_hsel;
wire                                   [2:0] hs4_hsize;
wire                                   [1:0] hs4_htrans;
wire                                  [31:0] hs4_hwdata;
wire                                         hs4_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV5
wire                                         hs5_bmc_hready;
wire                                  [31:0] hs5_hrdata;
wire                                   [1:0] hs5_hresp;
wire                                         bmc_hs5_hready;
wire                    [`AE250_HADDR_MSB:0] hs5_haddr;
wire                                   [2:0] hs5_hburst;
wire                                   [3:0] hs5_hprot;
wire                                         hs5_hsel;
wire                                   [2:0] hs5_hsize;
wire                                   [1:0] hs5_htrans;
wire                                  [31:0] hs5_hwdata;
wire                                         hs5_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV6
wire                                         hs6_bmc_hready;
wire                                  [31:0] hs6_hrdata;
wire                                   [1:0] hs6_hresp;
wire                                         bmc_hs6_hready;
wire                                   [2:0] hs6_hburst;
wire                                   [3:0] hs6_hprot;
wire                                         hs6_hsel;
wire                                   [2:0] hs6_hsize;
wire                                   [1:0] hs6_htrans;
wire                                  [31:0] hs6_hwdata;
wire                                         hs6_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV7
wire                                         hs7_bmc_hready;
wire                                  [31:0] hs7_hrdata;
wire                                   [1:0] hs7_hresp;
wire                                         bmc_hs7_hready;
wire                                   [2:0] hs7_hburst;
wire                                   [3:0] hs7_hprot;
wire                                         hs7_hsel;
wire                                   [2:0] hs7_hsize;
wire                                   [1:0] hs7_htrans;
wire                                  [31:0] hs7_hwdata;
wire                                         hs7_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV8
wire                                         hs8_bmc_hready;
wire                                  [31:0] hs8_hrdata;
wire                                   [1:0] hs8_hresp;
wire                                         bmc_hs8_hready;
wire                                   [2:0] hs8_hburst;
wire                                   [3:0] hs8_hprot;
wire                                         hs8_hsel;
wire                                   [2:0] hs8_hsize;
wire                                   [1:0] hs8_htrans;
wire                                  [31:0] hs8_hwdata;
wire                                         hs8_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV9
wire                                         hs9_bmc_hready;
wire                                  [31:0] hs9_hrdata;
wire                                   [1:0] hs9_hresp;
wire                                         bmc_hs9_hready;
wire                                   [2:0] hs9_hburst;
wire                                   [3:0] hs9_hprot;
wire                                         hs9_hsel;
wire                                   [2:0] hs9_hsize;
wire                                   [1:0] hs9_htrans;
wire                                  [31:0] hs9_hwdata;
wire                                         hs9_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV15
wire                                   [1:0] hs15_hresp;
`endif
`ifdef AE250_DMA_SUPPORT
wire        [`ATCDMAC100_REQ_ACK_NUM-6'd1:0] dma_req;
wire                                         dma_int;
`else
wire                                         dma_int=1'b0;
`endif
`ifdef ATCAPBBRG100_SLV_9
wire                                  [31:0] ps9_prdata;
wire                                         ps9_pready;
wire                                         ps9_psel;
`endif
`ifdef ATCAPBBRG100_SLV_10
wire                                  [31:0] ps10_prdata;
wire                                         ps10_pready;
wire                                         ps10_psel;
`endif
`ifdef ATCAPBBRG100_SLV_11
wire                                  [31:0] ps11_prdata;
wire                                         ps11_psel;
`endif
`ifdef ATCAPBBRG100_SLV_12
wire                                  [31:0] ps12_prdata;
wire                                         ps12_pready;
wire                                         ps12_pslverr;
wire                                         ps12_psel;
`endif
`ifdef ATCAPBBRG100_SLV_13
wire                                  [31:0] ps13_prdata;
wire                                         ps13_pready;
wire                                         ps13_psel;
`endif
`ifdef ATCAPBBRG100_SLV_14
wire                                  [31:0] ps14_prdata;
wire                                         ps14_pready;
wire                                         ps14_psel;
`endif
`ifdef ATCAPBBRG100_SLV_15
wire                                  [31:0] ps15_prdata;
wire                                         ps15_pready;
wire                                         ps15_pslverr;
wire                                         ps15_psel;
`endif
`ifdef ATCAPBBRG100_SLV_16
wire                                  [31:0] ps16_prdata;
wire                                         ps16_psel;
`endif
`ifdef ATCAPBBRG100_SLV_21
wire                                  [31:0] ps21_prdata;
wire                                         ps21_pready;
wire                                         ps21_pslverr;
wire                                         ps21_psel;
`endif
`ifdef ATCAPBBRG100_SLV_22
wire                                  [31:0] ps22_prdata;
wire                                         ps22_pready;
wire                                         ps22_pslverr;
wire                                         ps22_psel;
`endif
`ifdef ATCAPBBRG100_SLV_23
wire                                  [31:0] ps23_prdata;
wire                                         ps23_pready;
wire                                         ps23_pslverr;
wire                                         ps23_psel;
`endif
`ifdef ATCAPBBRG100_SLV_24
wire                                  [31:0] ps24_prdata;
wire                                         ps24_pready;
wire                                         ps24_pslverr;
wire                                         ps24_psel;
`endif
`ifdef ATCAPBBRG100_SLV_25
wire                                  [31:0] ps25_prdata;
wire                                         ps25_pready;
wire                                         ps25_pslverr;
wire                                         ps25_psel;
`endif
`ifdef ATCAPBBRG100_SLV_26
wire                                  [31:0] ps26_prdata;
wire                                         ps26_pready;
wire                                         ps26_pslverr;
wire                                         ps26_psel;
`endif
`ifdef ATCAPBBRG100_SLV_27
wire                                  [31:0] ps27_prdata;
wire                                         ps27_pready;
wire                                         ps27_pslverr;
wire                                         ps27_psel;
`endif
`ifdef ATCAPBBRG100_SLV_28
wire                                  [31:0] ps28_prdata;
wire                                         ps28_pready;
wire                                         ps28_pslverr;
wire                                         ps28_psel;
`endif
`ifdef ATCAPBBRG100_SLV_29
wire                                  [31:0] ps29_prdata;
wire                                         ps29_pready;
wire                                         ps29_pslverr;
wire                                         ps29_psel;
`endif
`ifdef ATCAPBBRG100_SLV_30
wire                                  [31:0] ps30_prdata;
wire                                         ps30_pready;
wire                                         ps30_pslverr;
wire                                         ps30_psel;
`endif
`ifdef ATCAPBBRG100_SLV_31
wire                                  [31:0] ps31_prdata;
wire                                         ps31_pready;
wire                                         ps31_pslverr;
wire                                         ps31_psel;
`endif
wire                                         sdc_int;

`ifdef NDS_FPGA
wire                                   [1:0] smu_core_clk_2_hclk_ratio;
wire                                   [1:0] smu_hclk_2_pclk_ratio;
`else
wire                                   [1:0] smu_core_clk_2_hclk_ratio;
wire                                   [1:0] smu_hclk_2_pclk_ratio;
`endif
`ifdef AE250_SPI1_SUPPORT
wire                                         spi1_clk_in;
wire                                         spi1_csn_in;
wire                                         spi1_miso_in;
wire                                         spi1_mosi_in;
wire                                         spi1_clk_oe;
wire                                         spi1_clk_out;
wire                                         spi1_csn_oe;
wire                                         spi1_csn_out;
wire                                         spi1_miso_oe;
wire                                         spi1_miso_out;
wire                                         spi1_mosi_oe;
wire                                         spi1_mosi_out;
`endif
`ifdef AE250_PLDM_SYS_BUS_ACCESS
wire                                         dm_sys_hgrant;
wire           [((`NDS_BIU_DATA_WIDTH)-1):0] dm_sys_hrdata;
wire                                         dm_sys_hready;
wire                                   [1:0] dm_sys_hresp;
wire                                  [31:0] dm_sys_haddr;
wire                                   [2:0] dm_sys_hburst;
wire                                         dm_sys_hbusreq;
wire                                   [3:0] dm_sys_hprot;
wire                                   [2:0] dm_sys_hsize;
wire                                   [1:0] dm_sys_htrans;
wire           [((`NDS_BIU_DATA_WIDTH)-1):0] dm_sys_hwdata;
wire                                         dm_sys_hwrite;
`endif
`ifdef NDS_BOARD_CF1
wire                                  [32:1] int_src;
wire                                  [31:0] cf1_pinmux_ctrl0;
wire                                  [31:0] cf1_pinmux_ctrl1;
`else
wire                                  [31:1] int_src;
`endif
`ifdef AE250_SPI2_SUPPORT
wire                                         spi2_clk_in;
wire                                         spi2_csn_in;
wire                                         spi2_miso_in;
wire                                         spi2_mosi_in;
wire                                         spi2_clk_oe;
wire                                         spi2_clk_out;
wire                                         spi2_csn_oe;
wire                                         spi2_csn_out;
wire                                         spi2_miso_oe;
wire                                         spi2_miso_out;
wire                                         spi2_mosi_oe;
wire                                         spi2_mosi_out;
`endif
`ifdef AE250_SPI3_SUPPORT
wire                                         spi3_rx_dma_ack;
wire                                         spi3_tx_dma_ack;
wire                                         spi3_clk_in;
wire                                         spi3_csn_in;
wire                                         spi3_miso_in;
wire                                         spi3_mosi_in;
wire                                         dmareq_spi3_rx;
wire                                         dmareq_spi3_tx;
wire                                         spi3_clk_oe;
wire                                         spi3_clk_out;
wire                                         spi3_csn_oe;
wire                                         spi3_csn_out;
wire                                         spi3_int;
wire                                         spi3_miso_oe;
wire                                         spi3_miso_out;
wire                                         spi3_mosi_oe;
wire                                         spi3_mosi_out;
`else
wire                                         spi3_int=1'b0;
`endif
`ifdef AE250_SPI4_SUPPORT
wire                                         spi4_rx_dma_ack;
wire                                         spi4_tx_dma_ack;
wire                                         spi4_clk_in;
wire                                         spi4_csn_in;
wire                                         spi4_miso_in;
wire                                         spi4_mosi_in;
wire                                         dmareq_spi4_rx;
wire                                         dmareq_spi4_tx;
wire                                         spi4_clk_oe;
wire                                         spi4_clk_out;
wire                                         spi4_csn_oe;
wire                                         spi4_csn_out;
wire                                         spi4_int;
wire                                         spi4_miso_oe;
wire                                         spi4_miso_out;
wire                                         spi4_mosi_oe;
wire                                         spi4_mosi_out;
`else
wire                                         spi4_int=1'b0;
`endif
`ifdef AE250_I2C_SUPPORT
wire                                         i2c_scl_in;
wire                                         i2c_sda_in;
wire                                         i2c_scl;
wire                                         i2c_sda;
`endif
`ifdef AE250_I2C2_SUPPORT
wire                                         i2c2_dma_ack;
wire                                         i2c2_psel;
wire                                         i2c2_scl_in;
wire                                         i2c2_sda_in;
wire                                         dmareq_i2c2;
wire                                         i2c2_int;
wire                                  [31:0] i2c2_prdata;
wire                                         i2c2_scl;
wire                                         i2c2_sda;
`else
wire                                         i2c2_int=1'b0;
`endif
`ifdef AE250_UART1_SUPPORT
wire                                         uart1_ctsn;
wire                                         uart1_dcdn;
wire                                         uart1_dsrn;
wire                                         uart1_rin;
wire                                         uart1_rxd;
wire                                         uart1_dtrn;
wire                                         uart1_out1n;
wire                                         uart1_out2n;
wire                                  [31:0] uart1_prdata;
wire                                         uart1_rtsn;
wire                                         uart1_txd;
`endif
`ifdef AE250_UART2_SUPPORT
wire                                         uart2_ctsn;
wire                                         uart2_dcdn;
wire                                         uart2_dsrn;
wire                                         uart2_rin;
wire                                         uart2_rxd;
wire                                         uart2_dtrn;
wire                                         uart2_out1n;
wire                                         uart2_out2n;
wire                                  [31:0] uart2_prdata;
wire                                         uart2_rtsn;
wire                                         uart2_txd;
`endif
`ifdef ATCPIT100_CH1_SUPPORT
wire                                         ch1_pwm;
wire                                         ch1_pwmoe;
`endif
`ifdef ATCPIT100_CH2_SUPPORT
wire                                         ch2_pwm;
wire                                         ch2_pwmoe;
`endif
`ifdef ATCPIT100_CH3_SUPPORT
wire                                         ch3_pwm;
wire                                         ch3_pwmoe;
`endif
`ifdef AE250_PIT2_SUPPORT
wire                                         pit2_ch0_pwm;
wire                                         pit2_ch0_pwmoe;
wire                                         pit2_int;
`else
wire                                         pit2_int=1'b0;
`endif
`ifdef AE250_PIT3_SUPPORT
wire                                         pit3_ch0_pwm;
wire                                         pit3_ch0_pwmoe;
wire                                         pit3_int;
`else
wire                                         pit3_int=1'b0;
`endif
`ifdef AE250_PIT4_SUPPORT
wire                                         pit4_ch0_pwm;
wire                                         pit4_ch0_pwmoe;
wire                                         pit4_int;
`else
wire                                         pit4_int=1'b0;
`endif
`ifdef AE250_PIT5_SUPPORT
wire                                         pit5_ch0_pwm;
wire                                         pit5_ch0_pwmoe;
wire                                         pit5_int;
`else
wire                                         pit5_int=1'b0;
`endif
wire                                         mac_int;

`ifdef AE250_DMA_EXTREQ_SUPPORT
wire          [`AE250_DMA_EXTREQ_NUM-6'd1:0] dma_ack_ext;
wire          [`AE250_DMA_EXTREQ_NUM-6'd1:0] dma_req_ext;
`endif
`ifdef ATCAPBBRG100_SLV_11
`endif
`ifdef AE250_SPI1_SUPPORT
   `ifdef NCEEIC050_SUPPORT
wire                                         eic_ds_spi_hresp;
wire                [NDS_BIU_DATA_WIDTH-1:0] eic_spi_hrdata;
wire                                         eic_spi_hready;
wire                                  [31:0] nceeic050_data_ram_rdata_way0;
wire                                  [31:0] nceeic050_data_ram_rdata_way1;
wire                       [(TAG_WIDTH-1):0] nceeic050_tag_ram_rdata_way0;
wire                       [(TAG_WIDTH-1):0] nceeic050_tag_ram_rdata_way1;
wire                                         eic050_us_hresp;
wire                                  [19:0] eic_spi_haddr;
wire                                   [2:0] eic_spi_hburst;
wire                                   [3:0] eic_spi_hprot;
wire                                   [2:0] eic_spi_hsize;
wire                                   [1:0] eic_spi_htrans;
wire                [NDS_BIU_DATA_WIDTH-1:0] eic_spi_hwdata;
wire                                         eic_spi_hwrite;
wire            [(DATA_RAM_INDEX_WIDTH-1):0] nceeic050_data_ram_addr;
wire                                         nceeic050_data_ram_cs_way0;
wire                                         nceeic050_data_ram_cs_way1;
wire                                  [31:0] nceeic050_data_ram_wdata;
wire                                         nceeic050_data_ram_we_way0;
wire                                         nceeic050_data_ram_we_way1;
wire             [(TAG_RAM_INDEX_WIDTH-1):0] nceeic050_tag_ram_addr;
wire                                         nceeic050_tag_ram_cs_way0;
wire                                         nceeic050_tag_ram_cs_way1;
wire                       [(TAG_WIDTH-1):0] nceeic050_tag_ram_wdata;
wire                                         nceeic050_tag_ram_we_way0;
wire                                         nceeic050_tag_ram_we_way1;
   `endif
   `ifdef ATCSPI200_QUADSPI_SUPPORT
wire                                         spi1_holdn_in;
wire                                         spi1_wpn_in;
wire                                         spi1_holdn_oe;
wire                                         spi1_holdn_out;
wire                                         spi1_wpn_oe;
wire                                         spi1_wpn_out;
   `endif
   `ifdef ATCSPI200_REG_APB
wire                                         spi1_psel;
wire                                  [31:0] spi1_prdata;
wire                                         spi1_pready;
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
wire                                         hreadyin_mem;
wire                                         hsel_mem;
wire                                   [1:0] htrans_mem;
wire                                         hwrite_mem;
wire                                  [31:0] hrdata_mem;
wire                                         hreadyout_mem;
wire                                   [1:0] hresp_mem;
   `endif
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE250_SPI2_SUPPORT
wire                                         spi2_holdn_in;
wire                                         spi2_wpn_in;
wire                                         spi2_holdn_oe;
wire                                         spi2_holdn_out;
wire                                         spi2_wpn_oe;
wire                                         spi2_wpn_out;
   `endif
`endif
`ifdef AE250_SPI2_SUPPORT
   `ifdef ATCSPI200_REG_APB
wire                                         spi2_psel;
wire                                  [31:0] spi2_prdata;
wire                                         spi2_pready;
   `endif
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE250_SPI3_SUPPORT
wire                                         spi3_holdn_in;
wire                                         spi3_wpn_in;
wire                                         spi3_holdn_oe;
wire                                         spi3_holdn_out;
wire                                         spi3_wpn_oe;
wire                                         spi3_wpn_out;
   `endif
`endif
`ifdef AE250_SPI3_SUPPORT
   `ifdef ATCSPI200_REG_APB
wire                                         spi3_psel;
wire                                  [31:0] spi3_prdata;
wire                                         spi3_pready;
   `endif
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE250_SPI4_SUPPORT
wire                                         spi4_holdn_in;
wire                                         spi4_wpn_in;
wire                                         spi4_holdn_oe;
wire                                         spi4_holdn_out;
wire                                         spi4_wpn_oe;
wire                                         spi4_wpn_out;
   `endif
`endif
`ifdef AE250_SPI4_SUPPORT
   `ifdef ATCSPI200_REG_APB
wire                                         spi4_psel;
wire                                  [31:0] spi4_prdata;
wire                                         spi4_pready;
   `endif
`endif
`ifdef ATCPIT100_CH1_SUPPORT
   `ifdef AE250_PIT2_SUPPORT
wire                                         pit2_ch1_pwm;
wire                                         pit2_ch1_pwmoe;
   `endif
`endif
`ifdef ATCPIT100_CH2_SUPPORT
   `ifdef AE250_PIT2_SUPPORT
wire                                         pit2_ch2_pwm;
wire                                         pit2_ch2_pwmoe;
   `endif
`endif
`ifdef ATCPIT100_CH3_SUPPORT
   `ifdef AE250_PIT2_SUPPORT
wire                                         pit2_ch3_pwm;
wire                                         pit2_ch3_pwmoe;
   `endif
`endif
`ifdef ATCPIT100_CH1_SUPPORT
   `ifdef AE250_PIT3_SUPPORT
wire                                         pit3_ch1_pwm;
wire                                         pit3_ch1_pwmoe;
   `endif
`endif
`ifdef ATCPIT100_CH2_SUPPORT
   `ifdef AE250_PIT3_SUPPORT
wire                                         pit3_ch2_pwm;
wire                                         pit3_ch2_pwmoe;
   `endif
`endif
`ifdef ATCPIT100_CH3_SUPPORT
   `ifdef AE250_PIT3_SUPPORT
wire                                         pit3_ch3_pwm;
wire                                         pit3_ch3_pwmoe;
   `endif
`endif
`ifdef ATCPIT100_CH1_SUPPORT
   `ifdef AE250_PIT4_SUPPORT
wire                                         pit4_ch1_pwm;
wire                                         pit4_ch1_pwmoe;
   `endif
`endif
`ifdef ATCPIT100_CH2_SUPPORT
   `ifdef AE250_PIT4_SUPPORT
wire                                         pit4_ch2_pwm;
wire                                         pit4_ch2_pwmoe;
   `endif
`endif
`ifdef ATCPIT100_CH3_SUPPORT
   `ifdef AE250_PIT4_SUPPORT
wire                                         pit4_ch3_pwm;
wire                                         pit4_ch3_pwmoe;
   `endif
`endif
`ifdef ATCPIT100_CH1_SUPPORT
   `ifdef AE250_PIT5_SUPPORT
wire                                         pit5_ch1_pwm;
wire                                         pit5_ch1_pwmoe;
   `endif
`endif
`ifdef ATCPIT100_CH2_SUPPORT
   `ifdef AE250_PIT5_SUPPORT
wire                                         pit5_ch2_pwm;
wire                                         pit5_ch2_pwmoe;
   `endif
`endif
`ifdef ATCPIT100_CH3_SUPPORT
   `ifdef AE250_PIT5_SUPPORT
wire                                         pit5_ch3_pwm;
wire                                         pit5_ch3_pwmoe;
   `endif
`endif
`ifdef ATCAPBBRG100_SLV_11
`endif
`ifdef ATCBMC200_AHB_MST2
   `ifdef ATCBMC200_AHB_SLV4
   `endif
`endif
wire                                   [1:0] cpu_hresp;
wire          [(`ATCSPI200_HADDR_WIDTH-1):0] haddr_mem32;
wire                    [`AE250_HADDR_MSB:0] hm0_haddr;
wire                                   [2:0] hm0_hburst;
wire                                   [3:0] hm0_hprot;
wire                                   [2:0] hm0_hsize;
wire                                   [1:0] hm0_htrans;
wire                  [AE250_DATA_WIDTH-1:0] hm0_hwdata;
wire                                         hm0_hwrite;
wire                                  [31:0] paddr32;
wire                                  [31:0] pd_wakeup_event;
wire                                  [31:0] ps2_prdata;
wire                                  [31:0] ps3_prdata;
wire                                         rtc_int_period;
wire                  [AE250_DATA_WIDTH-1:0] sizedn_cpu_hrdata;
wire                                         sizedn_cpu_hready;
wire                                         sizedn_cpu_hresp_1bit;
wire                                         ahb2core_clken;
wire                                         apb2ahb_clken;
wire                                         apb2core_clken;
wire                                         core_clk;
wire                                         hclk;
wire                                         pclk;
wire                                         pclk_gpio;
wire                                         pclk_i2c;
wire                                         pclk_pit;
wire                                         pclk_spi1;
wire                                         pclk_spi2;
wire                                         pclk_uart1;
wire                                         pclk_uart2;
wire                                         pclk_wdt;
wire                                         root_clk;
wire                                         spi_clk;
wire                                         uart_clk;
wire                                         core_wfi_mode;
wire                [NDS_BIU_ADDR_WIDTH-1:0] cpu_haddr;
wire                                   [2:0] cpu_hburst;
wire                                   [3:0] cpu_hprot;
wire                                   [2:0] cpu_hsize;
wire                                   [1:0] cpu_htrans;
wire                [NDS_BIU_DATA_WIDTH-1:0] cpu_hwdata;
wire                                         cpu_hwrite;
wire                                         dbg_srst_req;
wire                                         dbg_wakeup_req;
wire                                         pin_tdi_out;
wire                                         pin_tdi_out_en;
wire                                         pin_tdo_out;
wire                                         pin_tdo_out_en;
wire                                         pin_tms_out;
wire                                         pin_tms_out_en;
wire                                         pin_trst_out;
wire                                         pin_trst_out_en;
wire                                         T_hw_rstn;
wire                                         T_osch;
wire                                         T_por_b;
wire          [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_in;
wire                                         pin_tdi_in;
wire                                         pin_tdo_in;
wire                                         pin_tms_in;
wire                                         pin_trst_in;
wire                                         init_calib_complete;
wire                                         core_resetn;
wire                                         hresetn;
wire                                         main_rstn;
wire                                         main_rstn_csync;
wire                                         por_b_psync;
wire                                         por_rstn;
wire                                         presetn;
wire                                         spi_rstn;
wire                                         uart_rstn;
wire                                         clk_32k;
wire                                         dbg_tck;
wire                                         dbg_wakeup_ack;
wire                                         dcache_disable_init;
wire                                         icache_disable_init;
wire                                         mpd_iso_en;
wire                                         pd_clk_off;
wire                                         pd_iso_en;
wire                                         pd_pwr_off;
wire                                         pd_ret_en;
wire                                  [31:0] ps1_prdata;
wire                                  [31:0] reset_vector;
wire                                         rtc_rstn;
wire                                         smu2core_standby_req;
wire                                         smu2core_wakeup_ok;
wire                                         smu_core_clk_en;
wire                                         smu_core_clk_sel;
wire                                         smu_hclk_en;
wire                                         smu_interrupt_pd;
wire                                   [8:0] smu_pclk_en;
wire                                         smu_rstgen_core0_resetn;
wire                                         sw_rstn;
wire                                         test_clk;
wire                                         test_mode;
wire                                         test_rstn;
wire                                         scan_enable;
wire                                         scan_test;
wire                [NDS_BIU_DATA_WIDTH-1:0] cpu_hrdata;
wire                                         cpu_hready;
wire                                         cpu_hresp_1bit;
wire                    [`AE250_HADDR_MSB:0] sizedn_cpu_haddr;
wire                                   [2:0] sizedn_cpu_hburst;
wire                                   [3:0] sizedn_cpu_hprot;
wire                                   [2:0] sizedn_cpu_hsize;
wire                                   [1:0] sizedn_cpu_htrans;
wire                  [AE250_DATA_WIDTH-1:0] sizedn_cpu_hwdata;
wire                                         sizedn_cpu_hwrite;
wire                                         hs1_bmc_hready;
wire                                  [31:0] hs1_hrdata;
wire                                   [1:0] hs1_hresp;
wire                    [`AE250_PADDR_MSB:0] paddr;
wire                                         penable;
wire                                   [2:0] pprot;
wire                                         ps17_psel;
wire                                         ps18_psel;
wire                                         ps19_psel;
wire                                         ps1_psel;
wire                                         ps20_psel;
wire                                         ps2_psel;
wire                                         ps3_psel;
wire                                         ps4_psel;
wire                                         ps5_psel;
wire                                         ps6_psel;
wire                                         ps7_psel;
wire                                         ps8_psel;
wire                                   [3:0] pstrb;
wire                                  [31:0] pwdata;
wire                                         pwrite;
wire                                         bmc_hs15_hready;
wire                                         bmc_hs1_hready;
wire                                         bmc_int;
wire                  [AE250_DATA_WIDTH-1:0] hm0_hrdata;
wire                                         hm0_hready;
wire                                   [1:0] hm0_hresp;
wire                                  [31:0] hm1_hrdata;
wire                                         hm1_hready;
wire                                   [1:0] hm1_hresp;
wire                    [`AE250_HADDR_MSB:0] hs15_haddr;
wire                                   [2:0] hs15_hburst;
wire                                   [3:0] hs15_hprot;
wire                                         hs15_hsel;
wire                                   [2:0] hs15_hsize;
wire                                   [1:0] hs15_htrans;
wire                                  [31:0] hs15_hwdata;
wire                                         hs15_hwrite;
wire                    [`AE250_HADDR_MSB:0] hs1_haddr;
wire                                   [3:0] hs1_hprot;
wire                                         hs1_hsel;
wire                                   [2:0] hs1_hsize;
wire                                   [1:0] hs1_htrans;
wire                                  [31:0] hs1_hwdata;
wire                                         hs1_hwrite;
wire                    [`AE250_HADDR_MSB:0] hs6_haddr;
wire                    [`AE250_HADDR_MSB:0] hs7_haddr;
wire                    [`AE250_HADDR_MSB:0] hs8_haddr;
wire                    [`AE250_HADDR_MSB:0] hs9_haddr;
wire                         [DMA_ACK_MSB:0] dma_ack;
wire                 [`ATCBMC200_ADDR_MSB:0] hm1_haddr;
wire                                   [2:0] hm1_hburst;
wire                                   [3:0] hm1_hprot;
wire                                   [2:0] hm1_hsize;
wire                                   [1:0] hm1_htrans;
wire                                  [31:0] hm1_hwdata;
wire                                         hm1_hwrite;
wire                                         gpio_intr;
wire          [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_oe;
wire          [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_out;
wire          [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_pulldown;
wire          [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_pullup;
wire                                  [31:0] ps7_prdata;
wire                                         dmareq_i2c;
wire                                         i2c_int;
wire                                  [31:0] ps8_prdata;
wire                                         hs15_bmc_hready;
wire                                  [31:0] hs15_hrdata;
wire                                         ch0_pwm;
wire                                         ch0_pwmoe;
wire                                         pit_intr;
wire                                  [31:0] ps4_prdata;
wire                                  [31:0] ps17_prdata;
wire                                  [31:0] ps18_prdata;
wire                                  [31:0] ps19_prdata;
wire                                  [31:0] ps20_prdata;
wire                                         alarm_wakeup;
wire                                         freq_test_en;
wire                                         freq_test_out;
wire                                  [31:0] ps6_prdata;
wire                                         rtc_int_alarm;
wire                                         rtc_int_day;
wire                                         rtc_int_hour;
wire                                         rtc_int_hsec;
wire                                         rtc_int_min;
wire                                         rtc_int_sec;
wire                                         dmareq_spi1_rx;
wire                                         dmareq_spi1_tx;
wire                                         spi1_int;
wire                                         dmareq_spi2_rx;
wire                                         dmareq_spi2_tx;
wire                                         spi2_int;
wire                                         dmareqn_uart1_rx;
wire                                         dmareqn_uart1_tx;
wire                                         uart1_int;
wire                                         dmareqn_uart2_rx;
wire                                         dmareqn_uart2_tx;
wire                                         uart2_int;
wire                                  [31:0] ps5_prdata;
wire                                         wdt_int;
wire                                         wdt_rst;

`ifdef AE250_SPI1_SUPPORT
`else
assign dmareq_spi1_tx = 1'b0;
assign dmareq_spi1_rx = 1'b0;
assign spi1_int = 1'b0;
`endif
`ifdef AE250_SPI2_SUPPORT
`else
assign dmareq_spi2_tx = 1'b0;
assign dmareq_spi2_rx = 1'b0;
assign spi2_int = 1'b0;
`endif
`ifdef ATCGPIO100_INTR_SUPPORT
`else
assign gpio_intr = 1'b0;
`endif
assign mac_int = 1'b0;

assign sdc_int = 1'b0;

`ifdef AE250_UART1_SUPPORT
`else
assign dmareqn_uart1_tx = 1'b0;
assign dmareqn_uart1_rx = 1'b0;
assign uart1_int = 1'b0;
`endif
`ifdef AE250_UART2_SUPPORT
`else
assign dmareqn_uart2_tx = 1'b0;
assign dmareqn_uart2_rx = 1'b0;
assign uart2_int = 1'b0;
`endif
`ifdef AE250_I2C_SUPPORT
`else
assign dmareq_i2c = 1'b0;
assign i2c_int = 1'b0;
`endif
`ifdef AE250_SPI1_SUPPORT
   `ifdef NCEEIC050_SUPPORT
           assign hs15_hresp = {1'b0, eic050_us_hresp};
           assign eic_ds_spi_hresp = hresp_mem[0];
           assign hsel_mem = 1'b1;
           assign htrans_mem = eic_spi_htrans;
           assign hwrite_mem = eic_spi_hwrite;
           assign eic_spi_hrdata = hrdata_mem;
           assign hreadyin_mem = hreadyout_mem;
           assign eic_spi_hready = hreadyout_mem;
   `else
           assign hs15_hresp = hresp_mem;
           assign hsel_mem = hs15_hsel;
           assign htrans_mem = hs15_htrans;
           assign hwrite_mem = hs15_hwrite;
           assign hs15_hrdata = hrdata_mem;
           assign hreadyin_mem = bmc_hs15_hready;
           assign hs15_bmc_hready = hreadyout_mem;
   `endif
`else
   assign hs15_hresp = 2'b00;
   assign hs15_bmc_hready = 1'b1;
   assign hs15_hrdata = {AE250_DATA_WIDTH{1'b0}};
`endif
`ifdef NDS_BIU_DATA_WIDTH_32
	`ifdef AE250_ADDR_WIDTH_24
		assign hm0_haddr = (cpu_haddr[23:20] == 4'h8) ? {12'h800, cpu_haddr[19:0]} :
            		      (cpu_haddr[23:20] == 4'he) ? {12'he00, cpu_haddr[19:0]} : {8'd0, cpu_haddr[23:0]};
	`else
		assign hm0_haddr = cpu_haddr[`ATCBMC200_ADDR_MSB:0];
	`endif
	assign hm0_hburst = cpu_hburst;
	assign hm0_hprot  = cpu_hprot;
	assign hm0_hsize  = cpu_hsize;
	assign hm0_htrans = cpu_htrans;
	assign hm0_hwdata = cpu_hwdata[NDS_BIU_DATA_WIDTH-1:0];
	assign hm0_hwrite = cpu_hwrite;
	assign cpu_hrdata = hm0_hrdata[NDS_BIU_DATA_WIDTH-1:0];
	assign cpu_hready = hm0_hready;
	assign cpu_hresp  = hm0_hresp;
	assign sizedn_cpu_hready = 1'b1;
	assign sizedn_cpu_haddr = {(`AE250_HADDR_MSB+1){1'b0}};
	assign sizedn_cpu_hrdata = {AE250_DATA_WIDTH{1'b0}};
	assign sizedn_cpu_hwrite = 1'b0;
	assign sizedn_cpu_htrans = 2'b00;
	assign sizedn_cpu_hresp_1bit = 1'b0;
	assign sizedn_cpu_hburst = 3'b000;
	assign sizedn_cpu_hsize = 3'b000;
	assign sizedn_cpu_hprot = 4'b0000;
	assign sizedn_cpu_hwdata = {AE250_DATA_WIDTH{1'b0}};
	assign cpu_hresp_1bit = 1'b0;
`else
generate
if (NDS_BIU_DATA_WIDTH > AE250_DATA_WIDTH) begin: gen_sizedn_connect_cpu_bmc
	assign hm0_haddr  = sizedn_cpu_haddr;
	assign hm0_hburst = sizedn_cpu_hburst;
	assign hm0_hprot  = sizedn_cpu_hprot;
	assign hm0_hsize  = sizedn_cpu_hsize;
	assign hm0_htrans = sizedn_cpu_htrans;
	assign hm0_hwdata = sizedn_cpu_hwdata;
	assign hm0_hwrite = sizedn_cpu_hwrite;
	assign sizedn_cpu_hrdata      = hm0_hrdata;
	assign sizedn_cpu_hready      = hm0_hready;
	assign sizedn_cpu_hresp_1bit  = hm0_hresp[0];
	assign cpu_hresp  = {1'b0, cpu_hresp_1bit};
end
else begin: gen_connect_cpu_bmc
	`ifdef AE250_ADDR_WIDTH_24
		assign hm0_haddr = (cpu_haddr[23:20] == 4'h8) ? {12'h800, cpu_haddr[19:0]} :
            		      (cpu_haddr[23:20] == 4'he) ? {12'he00, cpu_haddr[19:0]} : {8'd0, cpu_haddr[23:0]};
	`else
		assign hm0_haddr = cpu_haddr[`ATCBMC200_ADDR_MSB:0];
	`endif
	assign hm0_hburst = cpu_hburst;
	assign hm0_hprot  = cpu_hprot;
	assign hm0_hsize  = cpu_hsize;
	assign hm0_htrans = cpu_htrans;
	assign hm0_hwdata = cpu_hwdata[NDS_BIU_DATA_WIDTH-1:0];
	assign hm0_hwrite = cpu_hwrite;
	assign cpu_hrdata = hm0_hrdata[NDS_BIU_DATA_WIDTH-1:0];
	assign cpu_hready = hm0_hready;
	assign cpu_hresp  = hm0_hresp;
	assign sizedn_cpu_hready = 1'b1;
	assign sizedn_cpu_haddr = {(`AE250_HADDR_MSB+1){1'b0}};
	assign sizedn_cpu_hrdata = {AE250_DATA_WIDTH{1'b0}};
	assign sizedn_cpu_hwrite = 1'b0;
	assign sizedn_cpu_htrans = 2'b00;
	assign sizedn_cpu_hresp_1bit = 1'b0;
	assign sizedn_cpu_hburst = 3'b000;
	assign sizedn_cpu_hsize = 3'b000;
	assign sizedn_cpu_hprot = 4'b0000;
	assign sizedn_cpu_hwdata = {AE250_DATA_WIDTH{1'b0}};
	assign cpu_hresp_1bit = 1'b0;
end
endgenerate
`endif
`ifdef ATCBMC200_AHB_MST3
assign hm3_haddr  = cpu_hm1_haddr;
assign hm3_hburst = cpu_hm1_hburst;
assign hm3_hwrite = cpu_hm1_hwrite;
assign hm3_hprot  = cpu_hm1_hprot;
assign hm3_hsize  = cpu_hm1_hsize;
assign hm3_htrans = cpu_hm1_htrans;
assign hm3_hwdata = cpu_hm1_hwdata;
assign cpu_hm1_hrdata = hm3_hrdata;
assign cpu_hm1_hready = hm3_hready;
assign cpu_hm1_hresp  = hm3_hresp;
`endif
`ifdef ATCBMC200_AHB_MST4
assign hm4_haddr  = cpu_hm2_haddr;
assign hm4_hburst = cpu_hm2_hburst;
assign hm4_hwrite = cpu_hm2_hwrite;
assign hm4_hprot  = cpu_hm2_hprot;
assign hm4_hsize  = cpu_hm2_hsize;
assign hm4_htrans = cpu_hm2_htrans;
assign hm4_hwdata = cpu_hm2_hwdata;
assign cpu_hm2_hrdata = hm4_hrdata;
assign cpu_hm2_hready = hm4_hready;
assign cpu_hm2_hresp  = hm4_hresp;
`endif
`ifdef ATCBMC200_AHB_MST5
assign hm5_haddr  = cpu_hm3_haddr;
assign hm5_hburst = cpu_hm3_hburst;
assign hm5_hwrite = cpu_hm3_hwrite;
assign hm5_hprot  = cpu_hm3_hprot;
assign hm5_hsize  = cpu_hm3_hsize;
assign hm5_htrans = cpu_hm3_htrans;
assign hm5_hwdata = cpu_hm3_hwdata;
assign cpu_hm3_hrdata = hm5_hrdata;
assign cpu_hm3_hready = hm5_hready;
assign cpu_hm3_hresp  = hm5_hresp;
`endif
`ifdef ATCBMC200_AHB_MST6
assign hm6_haddr  = cpu_hm4_haddr;
assign hm6_hburst = cpu_hm4_hburst;
assign hm6_hwrite = cpu_hm4_hwrite;
assign hm6_hprot  = cpu_hm4_hprot;
assign hm6_hsize  = cpu_hm4_hsize;
assign hm6_htrans = cpu_hm4_htrans;
assign hm6_hwdata = cpu_hm4_hwdata;
assign cpu_hm4_hrdata = hm6_hrdata;
assign cpu_hm4_hready = hm6_hready;
assign cpu_hm4_hresp  = hm6_hresp;
`endif
`ifdef ATCBMC200_AHB_MST7
assign hm7_haddr  = cpu_hm5_haddr;
assign hm7_hburst = cpu_hm5_hburst;
assign hm7_hwrite = cpu_hm5_hwrite;
assign hm7_hprot  = cpu_hm5_hprot;
assign hm7_hsize  = cpu_hm5_hsize;
assign hm7_htrans = cpu_hm5_htrans;
assign hm7_hwdata = cpu_hm5_hwdata;
assign cpu_hm5_hrdata = hm7_hrdata;
assign cpu_hm5_hready = hm7_hready;
assign cpu_hm5_hresp  = hm7_hresp;
`endif
`ifdef ATCBMC200_AHB_MST8
assign hm8_haddr  = cpu_hm6_haddr;
assign hm8_hburst = cpu_hm6_hburst;
assign hm8_hwrite = cpu_hm6_hwrite;
assign hm8_hprot  = cpu_hm6_hprot;
assign hm8_hsize  = cpu_hm6_hsize;
assign hm8_htrans = cpu_hm6_htrans;
assign hm8_hwdata = cpu_hm6_hwdata;
assign cpu_hm6_hrdata = hm8_hrdata;
assign cpu_hm6_hready = hm8_hready;
assign cpu_hm6_hresp  = hm8_hresp;
`endif
`ifdef ATCBMC200_AHB_MST9
assign hm9_haddr  = cpu_hm7_haddr;
assign hm9_hburst = cpu_hm7_hburst;
assign hm9_hwrite = cpu_hm7_hwrite;
assign hm9_hprot  = cpu_hm7_hprot;
assign hm9_hsize  = cpu_hm7_hsize;
assign hm9_htrans = cpu_hm7_htrans;
assign hm9_hwdata = cpu_hm7_hwdata;
assign cpu_hm7_hrdata = hm9_hrdata;
assign cpu_hm7_hready = hm9_hready;
assign cpu_hm7_hresp  = hm9_hresp;
`endif
`ifdef PLATFORM_DEBUG_PORT
 `ifdef AE250_PLDM_SYS_BUS_ACCESS
   assign	hm10_haddr	= dm_sys_haddr;
   assign	hm10_hburst	= dm_sys_hburst;
   assign	hm10_hprot	= dm_sys_hprot;
   assign	hm10_hsize	= dm_sys_hsize;
   assign	hm10_htrans	= dm_sys_htrans;
   assign	hm10_hwdata	= dm_sys_hwdata;
   assign	hm10_hwrite	= dm_sys_hwrite;
   assign	dm_sys_hgrant	= 1'b1;
   assign	dm_sys_hready	= hm10_hready;
   assign	dm_sys_hresp	= hm10_hresp;
   assign	dm_sys_hrdata	= hm10_hrdata;
 `endif
 `ifdef AE250_JTAG_TWOWIRE
   assign pin_trst_in = 1'b0;
   assign pin_tdi_in = 1'b0;
   assign pin_tdo_in = 1'b0;
 `else
 `endif
`else
   assign pin_trst_in = 1'b0;
   assign pin_tdi_in = 1'b0;
   assign pin_tdo_in = 1'b0;
   assign dbg_srst_req     = 1'b0;
   assign dbg_wakeup_req   = 1'b0;
`endif
`ifdef AE250_UART1_SUPPORT
assign ps2_prdata = uart1_prdata;
`else
assign ps2_prdata = 32'h0;
`endif
`ifdef AE250_UART2_SUPPORT
assign ps3_prdata = uart2_prdata;
`else
assign ps3_prdata = 32'h0;
`endif
`ifdef AE250_I2C2_SUPPORT
assign i2c2_psel = ps16_psel;
assign ps16_prdata = i2c2_prdata;
`endif
`ifdef AE250_ADDR_WIDTH_24
assign paddr32 = {8'h0, paddr};
   `ifdef NCEEIC050_SUPPORT
           assign haddr_mem32 = {12'h0, eic_spi_haddr};
   `else
           assign haddr_mem32 = {8'h0, hs15_haddr};
   `endif
`else
assign paddr32 = paddr;
   `ifdef NCEEIC050_SUPPORT
           assign haddr_mem32 = {12'h0, eic_spi_haddr};
   `else
           assign haddr_mem32 = hs15_haddr;
   `endif
`endif
`ifdef AE250_SPI1_SUPPORT
assign spi1_psel = ps9_psel;
assign ps9_pready = spi1_pready;
assign ps9_prdata = spi1_prdata;
`endif
`ifdef AE250_SPI2_SUPPORT
assign spi2_psel = ps10_psel;
assign ps10_pready = spi2_pready;
assign ps10_prdata = spi2_prdata;
`endif
`ifdef AE250_SPI3_SUPPORT
assign spi3_psel = ps13_psel;
assign ps13_pready = spi3_pready;
assign ps13_prdata = spi3_prdata;
`endif
`ifdef AE250_SPI4_SUPPORT
assign spi4_psel = ps14_psel;
assign ps14_pready = spi4_pready;
assign ps14_prdata = spi4_prdata;
`endif
`ifdef AE250_DMA_SUPPORT
	`ifdef AE250_DMA_EXTREQ_SUPPORT
assign dma_req = {dma_req_ext, dmareq_i2c, dmareqn_uart2_rx, dmareqn_uart2_tx, dmareqn_uart1_rx, dmareqn_uart1_tx, dmareq_spi2_rx, dmareq_spi2_tx, dmareq_spi1_rx, dmareq_spi1_tx};
assign dma_ack_ext = dma_ack[`AE250_DMA_EXTREQ_NUM+6'd8:9];
	`else
assign dma_req = {dmareq_i2c, dmareqn_uart2_rx, dmareqn_uart2_tx, dmareqn_uart1_rx, dmareqn_uart1_tx, dmareq_spi2_rx, dmareq_spi2_tx, dmareq_spi1_rx, dmareq_spi1_tx};
	`endif
`else
assign dma_ack = 9'h0;
`endif
assign int_src[1]  =  rtc_int_period;
assign int_src[2]  =  rtc_int_alarm;
assign int_src[3]  =  pit_intr;
assign int_src[4]  =  spi1_int;
assign int_src[5]  =  spi2_int;
assign int_src[6]  =  i2c_int;
assign int_src[7]  =  gpio_intr;
assign int_src[8]  =  uart1_int;
assign int_src[9]  =  uart2_int;
assign int_src[10] =  dma_int;
assign int_src[11] =  bmc_int;
assign int_src[12] =  1'b0;
assign int_src[13] =  1'b0;
assign int_src[14] =  1'b0;
assign int_src[15] =  spi3_int;
assign int_src[16] =  spi4_int;
assign int_src[17] =  1'b0;
assign int_src[18] =  sdc_int;
assign int_src[19] =  mac_int;
assign int_src[20] =  1'b0;
assign int_src[21] =  1'b0;
assign int_src[22] =  1'b0;
assign int_src[23] =  1'b0;
assign int_src[24] =  1'b0;
assign int_src[25] =  smu_interrupt_pd;
assign int_src[26] =  smu2core_standby_req;
assign int_src[27] =  smu2core_wakeup_ok;
assign int_src[28] =  i2c2_int;
assign int_src[29] =  pit2_int;
assign int_src[30] =  pit3_int;
assign int_src[31] =  pit4_int;
`ifdef NDS_BOARD_CF1
assign int_src[32] =  pit5_int;
`endif
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
assign rtc_int_period = rtc_int_hsec | rtc_int_sec | rtc_int_min | rtc_int_hour | rtc_int_day;
`else
assign rtc_int_period = rtc_int_sec | rtc_int_min | rtc_int_hour | rtc_int_day;
`endif
assign pd_wakeup_event = {int_src , 1'b0};

`ifdef AE250_DMA_EXTREQ_SUPPORT
  `ifdef NDS_BOARD_CF1
`ifdef AE250_SPI3_SUPPORT
assign dma_req_ext[0]	= dmareq_spi3_rx;
assign dma_req_ext[1]	= dmareq_spi3_tx;
assign spi3_rx_dma_ack	= dma_ack_ext[0];
assign spi3_tx_dma_ack	= dma_ack_ext[1];
`else
assign dma_req_ext[0]	= 1'b0;
assign dma_req_ext[1]	= 1'b0;
`endif
`ifdef AE250_SPI4_SUPPORT
assign dma_req_ext[2]	= dmareq_spi4_rx;
assign dma_req_ext[3]	= dmareq_spi4_tx;
assign spi4_rx_dma_ack	= dma_ack_ext[2];
assign spi4_tx_dma_ack	= dma_ack_ext[3];
`else
assign dma_req_ext[2]	= 1'b0;
assign dma_req_ext[3]	= 1'b0;
`endif
`ifdef AE250_I2C2_SUPPORT
assign dma_req_ext[4]	= dmareq_i2c2;
assign i2c2_dma_ack		= dma_ack_ext[4];
`else
assign dma_req_ext[4]	= 1'b0;
`endif
	`else
assign dma_req_ext[`AE250_DMA_EXTREQ_NUM-6'd1:0] = {(`AE250_DMA_EXTREQ_NUM     ){1'b0}};
	`endif
`endif


`ifdef NDS_FPGA
`else
assign X_pd_pwr_off = pd_pwr_off;
`endif

atcbmc200 u_bmc (
`ifdef ATCBMC200_AHB_MST0
	.hm0_haddr      (hm0_haddr      ),
	.hm0_hburst     (hm0_hburst     ),
	.hm0_hprot      (hm0_hprot      ),
	.hm0_hrdata     (hm0_hrdata     ),
	.hm0_hready     (hm0_hready     ),
	.hm0_hresp      (hm0_hresp      ),
	.hm0_hsize      (hm0_hsize      ),
	.hm0_htrans     (hm0_htrans     ),
	.hm0_hwrite     (hm0_hwrite     ),
	.hm0_hwdata     (hm0_hwdata     ),
`endif
`ifdef ATCBMC200_AHB_MST1
	.hm1_haddr      (hm1_haddr      ),
	.hm1_hburst     (hm1_hburst     ),
	.hm1_hprot      (hm1_hprot      ),
	.hm1_hrdata     (hm1_hrdata     ),
	.hm1_hready     (hm1_hready     ),
	.hm1_hresp      (hm1_hresp      ),
	.hm1_hsize      (hm1_hsize      ),
	.hm1_htrans     (hm1_htrans     ),
	.hm1_hwrite     (hm1_hwrite     ),
	.hm1_hwdata     (hm1_hwdata     ),
`endif
`ifdef ATCBMC200_AHB_MST2
	.hm2_haddr      (hm2_haddr      ),
	.hm2_hburst     (hm2_hburst     ),
	.hm2_hprot      (hm2_hprot      ),
	.hm2_hrdata     (hm2_hrdata     ),
	.hm2_hready     (hm2_hready     ),
	.hm2_hresp      (hm2_hresp      ),
	.hm2_hsize      (hm2_hsize      ),
	.hm2_htrans     (hm2_htrans     ),
	.hm2_hwrite     (hm2_hwrite     ),
	.hm2_hwdata     (hm2_hwdata     ),
`endif
`ifdef ATCBMC200_AHB_MST3
	.hm3_haddr      (hm3_haddr      ),
	.hm3_hburst     (hm3_hburst     ),
	.hm3_hprot      (hm3_hprot      ),
	.hm3_hrdata     (hm3_hrdata     ),
	.hm3_hready     (hm3_hready     ),
	.hm3_hresp      (hm3_hresp      ),
	.hm3_hsize      (hm3_hsize      ),
	.hm3_htrans     (hm3_htrans     ),
	.hm3_hwrite     (hm3_hwrite     ),
	.hm3_hwdata     (hm3_hwdata     ),
`endif
`ifdef ATCBMC200_AHB_MST4
	.hm4_haddr      (hm4_haddr      ),
	.hm4_hburst     (hm4_hburst     ),
	.hm4_hprot      (hm4_hprot      ),
	.hm4_hrdata     (hm4_hrdata     ),
	.hm4_hready     (hm4_hready     ),
	.hm4_hresp      (hm4_hresp      ),
	.hm4_hsize      (hm4_hsize      ),
	.hm4_htrans     (hm4_htrans     ),
	.hm4_hwrite     (hm4_hwrite     ),
	.hm4_hwdata     (hm4_hwdata     ),
`endif
`ifdef ATCBMC200_AHB_MST5
	.hm5_haddr      (hm5_haddr      ),
	.hm5_hburst     (hm5_hburst     ),
	.hm5_hprot      (hm5_hprot      ),
	.hm5_hrdata     (hm5_hrdata     ),
	.hm5_hready     (hm5_hready     ),
	.hm5_hresp      (hm5_hresp      ),
	.hm5_hsize      (hm5_hsize      ),
	.hm5_htrans     (hm5_htrans     ),
	.hm5_hwrite     (hm5_hwrite     ),
	.hm5_hwdata     (hm5_hwdata     ),
`endif
`ifdef ATCBMC200_AHB_MST6
	.hm6_haddr      (hm6_haddr      ),
	.hm6_hburst     (hm6_hburst     ),
	.hm6_hprot      (hm6_hprot      ),
	.hm6_hrdata     (hm6_hrdata     ),
	.hm6_hready     (hm6_hready     ),
	.hm6_hresp      (hm6_hresp      ),
	.hm6_hsize      (hm6_hsize      ),
	.hm6_htrans     (hm6_htrans     ),
	.hm6_hwrite     (hm6_hwrite     ),
	.hm6_hwdata     (hm6_hwdata     ),
`endif
`ifdef ATCBMC200_AHB_MST7
	.hm7_haddr      (hm7_haddr      ),
	.hm7_hburst     (hm7_hburst     ),
	.hm7_hprot      (hm7_hprot      ),
	.hm7_hrdata     (hm7_hrdata     ),
	.hm7_hready     (hm7_hready     ),
	.hm7_hresp      (hm7_hresp      ),
	.hm7_hsize      (hm7_hsize      ),
	.hm7_htrans     (hm7_htrans     ),
	.hm7_hwrite     (hm7_hwrite     ),
	.hm7_hwdata     (hm7_hwdata     ),
`endif
`ifdef ATCBMC200_AHB_MST8
	.hm8_haddr      (hm8_haddr      ),
	.hm8_hburst     (hm8_hburst     ),
	.hm8_hprot      (hm8_hprot      ),
	.hm8_hrdata     (hm8_hrdata     ),
	.hm8_hready     (hm8_hready     ),
	.hm8_hresp      (hm8_hresp      ),
	.hm8_hsize      (hm8_hsize      ),
	.hm8_htrans     (hm8_htrans     ),
	.hm8_hwrite     (hm8_hwrite     ),
	.hm8_hwdata     (hm8_hwdata     ),
`endif
`ifdef ATCBMC200_AHB_MST9
	.hm9_haddr      (hm9_haddr      ),
	.hm9_hburst     (hm9_hburst     ),
	.hm9_hprot      (hm9_hprot      ),
	.hm9_hrdata     (hm9_hrdata     ),
	.hm9_hready     (hm9_hready     ),
	.hm9_hresp      (hm9_hresp      ),
	.hm9_hsize      (hm9_hsize      ),
	.hm9_htrans     (hm9_htrans     ),
	.hm9_hwrite     (hm9_hwrite     ),
	.hm9_hwdata     (hm9_hwdata     ),
`endif
`ifdef ATCBMC200_AHB_MST10
	.hm10_haddr     (hm10_haddr     ),
	.hm10_hburst    (hm10_hburst    ),
	.hm10_hprot     (hm10_hprot     ),
	.hm10_hrdata    (hm10_hrdata    ),
	.hm10_hready    (hm10_hready    ),
	.hm10_hresp     (hm10_hresp     ),
	.hm10_hsize     (hm10_hsize     ),
	.hm10_htrans    (hm10_htrans    ),
	.hm10_hwrite    (hm10_hwrite    ),
	.hm10_hwdata    (hm10_hwdata    ),
`endif
`ifdef ATCBMC200_AHB_MST11
	.hm11_haddr     (               ),
	.hm11_hburst    (               ),
	.hm11_hprot     (               ),
	.hm11_hrdata    (               ),
	.hm11_hready    (               ),
	.hm11_hresp     (               ),
	.hm11_hsize     (               ),
	.hm11_htrans    (               ),
	.hm11_hwrite    (               ),
	.hm11_hwdata    (               ),
`endif
`ifdef ATCBMC200_AHB_MST12
	.hm12_haddr     (               ),
	.hm12_hburst    (               ),
	.hm12_hprot     (               ),
	.hm12_hrdata    (               ),
	.hm12_hready    (               ),
	.hm12_hresp     (               ),
	.hm12_hsize     (               ),
	.hm12_htrans    (               ),
	.hm12_hwrite    (               ),
	.hm12_hwdata    (               ),
`endif
`ifdef ATCBMC200_AHB_MST13
	.hm13_haddr     (               ),
	.hm13_hburst    (               ),
	.hm13_hprot     (               ),
	.hm13_hrdata    (               ),
	.hm13_hready    (               ),
	.hm13_hresp     (               ),
	.hm13_hsize     (               ),
	.hm13_htrans    (               ),
	.hm13_hwrite    (               ),
	.hm13_hwdata    (               ),
`endif
`ifdef ATCBMC200_AHB_MST14
	.hm14_haddr     (               ),
	.hm14_hburst    (               ),
	.hm14_hprot     (               ),
	.hm14_hrdata    (               ),
	.hm14_hready    (               ),
	.hm14_hresp     (               ),
	.hm14_hsize     (               ),
	.hm14_htrans    (               ),
	.hm14_hwrite    (               ),
	.hm14_hwdata    (               ),
`endif
`ifdef ATCBMC200_AHB_MST15
	.hm15_haddr     (               ),
	.hm15_hburst    (               ),
	.hm15_hprot     (               ),
	.hm15_hrdata    (               ),
	.hm15_hready    (               ),
	.hm15_hresp     (               ),
	.hm15_hsize     (               ),
	.hm15_htrans    (               ),
	.hm15_hwrite    (               ),
	.hm15_hwdata    (               ),
`endif
`ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata     (hs1_hrdata     ),
	.hs1_bmc_hready (hs1_bmc_hready ),
	.hs1_hresp      (hs1_hresp      ),
	.bmc_hs1_hready (bmc_hs1_hready ),
	.hs1_haddr      (hs1_haddr      ),
	.hs1_hburst     (hs1_hburst     ),
	.hs1_hprot      (hs1_hprot      ),
	.hs1_hsel       (hs1_hsel       ),
	.hs1_hsize      (hs1_hsize      ),
	.hs1_htrans     (hs1_htrans     ),
	.hs1_hwdata     (hs1_hwdata     ),
	.hs1_hwrite     (hs1_hwrite     ),
`endif
`ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata     (hs2_hrdata     ),
	.hs2_bmc_hready (hs2_bmc_hready ),
	.hs2_hresp      (hs2_hresp      ),
	.bmc_hs2_hready (bmc_hs2_hready ),
	.hs2_haddr      (hs2_haddr      ),
	.hs2_hburst     (hs2_hburst     ),
	.hs2_hprot      (hs2_hprot      ),
	.hs2_hsel       (hs2_hsel       ),
	.hs2_hsize      (hs2_hsize      ),
	.hs2_htrans     (hs2_htrans     ),
	.hs2_hwdata     (hs2_hwdata     ),
	.hs2_hwrite     (hs2_hwrite     ),
`endif
`ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata     (hs3_hrdata     ),
	.hs3_bmc_hready (hs3_bmc_hready ),
	.hs3_hresp      (hs3_hresp      ),
	.bmc_hs3_hready (bmc_hs3_hready ),
	.hs3_haddr      (hs3_haddr      ),
	.hs3_hburst     (hs3_hburst     ),
	.hs3_hprot      (hs3_hprot      ),
	.hs3_hsel       (hs3_hsel       ),
	.hs3_hsize      (hs3_hsize      ),
	.hs3_htrans     (hs3_htrans     ),
	.hs3_hwdata     (hs3_hwdata     ),
	.hs3_hwrite     (hs3_hwrite     ),
`endif
`ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata     (hs4_hrdata     ),
	.hs4_bmc_hready (hs4_bmc_hready ),
	.hs4_hresp      (hs4_hresp      ),
	.bmc_hs4_hready (bmc_hs4_hready ),
	.hs4_haddr      (hs4_haddr      ),
	.hs4_hburst     (hs4_hburst     ),
	.hs4_hprot      (hs4_hprot      ),
	.hs4_hsel       (hs4_hsel       ),
	.hs4_hsize      (hs4_hsize      ),
	.hs4_htrans     (hs4_htrans     ),
	.hs4_hwdata     (hs4_hwdata     ),
	.hs4_hwrite     (hs4_hwrite     ),
`endif
`ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata     (hs5_hrdata     ),
	.hs5_bmc_hready (hs5_bmc_hready ),
	.hs5_hresp      (hs5_hresp      ),
	.bmc_hs5_hready (bmc_hs5_hready ),
	.hs5_haddr      (hs5_haddr      ),
	.hs5_hburst     (hs5_hburst     ),
	.hs5_hprot      (hs5_hprot      ),
	.hs5_hsel       (hs5_hsel       ),
	.hs5_hsize      (hs5_hsize      ),
	.hs5_htrans     (hs5_htrans     ),
	.hs5_hwdata     (hs5_hwdata     ),
	.hs5_hwrite     (hs5_hwrite     ),
`endif
`ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata     (hs6_hrdata     ),
	.hs6_bmc_hready (hs6_bmc_hready ),
	.hs6_hresp      (hs6_hresp      ),
	.bmc_hs6_hready (bmc_hs6_hready ),
	.hs6_haddr      (hs6_haddr      ),
	.hs6_hburst     (hs6_hburst     ),
	.hs6_hprot      (hs6_hprot      ),
	.hs6_hsel       (hs6_hsel       ),
	.hs6_hsize      (hs6_hsize      ),
	.hs6_htrans     (hs6_htrans     ),
	.hs6_hwdata     (hs6_hwdata     ),
	.hs6_hwrite     (hs6_hwrite     ),
`endif
`ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata     (hs7_hrdata     ),
	.hs7_bmc_hready (hs7_bmc_hready ),
	.hs7_hresp      (hs7_hresp      ),
	.bmc_hs7_hready (bmc_hs7_hready ),
	.hs7_haddr      (hs7_haddr      ),
	.hs7_hburst     (hs7_hburst     ),
	.hs7_hprot      (hs7_hprot      ),
	.hs7_hsel       (hs7_hsel       ),
	.hs7_hsize      (hs7_hsize      ),
	.hs7_htrans     (hs7_htrans     ),
	.hs7_hwdata     (hs7_hwdata     ),
	.hs7_hwrite     (hs7_hwrite     ),
`endif
`ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata     (hs8_hrdata     ),
	.hs8_bmc_hready (hs8_bmc_hready ),
	.hs8_hresp      (hs8_hresp      ),
	.bmc_hs8_hready (bmc_hs8_hready ),
	.hs8_haddr      (hs8_haddr      ),
	.hs8_hburst     (hs8_hburst     ),
	.hs8_hprot      (hs8_hprot      ),
	.hs8_hsel       (hs8_hsel       ),
	.hs8_hsize      (hs8_hsize      ),
	.hs8_htrans     (hs8_htrans     ),
	.hs8_hwdata     (hs8_hwdata     ),
	.hs8_hwrite     (hs8_hwrite     ),
`endif
`ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata     (hs9_hrdata     ),
	.hs9_bmc_hready (hs9_bmc_hready ),
	.hs9_hresp      (hs9_hresp      ),
	.bmc_hs9_hready (bmc_hs9_hready ),
	.hs9_haddr      (hs9_haddr      ),
	.hs9_hburst     (hs9_hburst     ),
	.hs9_hprot      (hs9_hprot      ),
	.hs9_hsel       (hs9_hsel       ),
	.hs9_hsize      (hs9_hsize      ),
	.hs9_htrans     (hs9_htrans     ),
	.hs9_hwdata     (hs9_hwdata     ),
	.hs9_hwrite     (hs9_hwrite     ),
`endif
`ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata    (               ),
	.hs10_bmc_hready(               ),
	.hs10_hresp     (               ),
	.bmc_hs10_hready(               ),
	.hs10_haddr     (               ),
	.hs10_hburst    (               ),
	.hs10_hprot     (               ),
	.hs10_hsel      (               ),
	.hs10_hsize     (               ),
	.hs10_htrans    (               ),
	.hs10_hwdata    (               ),
	.hs10_hwrite    (               ),
`endif
`ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata    (               ),
	.hs11_bmc_hready(               ),
	.hs11_hresp     (               ),
	.bmc_hs11_hready(               ),
	.hs11_haddr     (               ),
	.hs11_hburst    (               ),
	.hs11_hprot     (               ),
	.hs11_hsel      (               ),
	.hs11_hsize     (               ),
	.hs11_htrans    (               ),
	.hs11_hwdata    (               ),
	.hs11_hwrite    (               ),
`endif
`ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata    (               ),
	.hs12_bmc_hready(               ),
	.hs12_hresp     (               ),
	.bmc_hs12_hready(               ),
	.hs12_haddr     (               ),
	.hs12_hburst    (               ),
	.hs12_hprot     (               ),
	.hs12_hsel      (               ),
	.hs12_hsize     (               ),
	.hs12_htrans    (               ),
	.hs12_hwdata    (               ),
	.hs12_hwrite    (               ),
`endif
`ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata    (               ),
	.hs13_bmc_hready(               ),
	.hs13_hresp     (               ),
	.bmc_hs13_hready(               ),
	.hs13_haddr     (               ),
	.hs13_hburst    (               ),
	.hs13_hprot     (               ),
	.hs13_hsel      (               ),
	.hs13_hsize     (               ),
	.hs13_htrans    (               ),
	.hs13_hwdata    (               ),
	.hs13_hwrite    (               ),
`endif
`ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata    (               ),
	.hs14_bmc_hready(               ),
	.hs14_hresp     (               ),
	.bmc_hs14_hready(               ),
	.hs14_haddr     (               ),
	.hs14_hburst    (               ),
	.hs14_hprot     (               ),
	.hs14_hsel      (               ),
	.hs14_hsize     (               ),
	.hs14_htrans    (               ),
	.hs14_hwdata    (               ),
	.hs14_hwrite    (               ),
`endif
`ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata    (hs15_hrdata    ),
	.hs15_bmc_hready(hs15_bmc_hready),
	.hs15_hresp     (hs15_hresp     ),
	.bmc_hs15_hready(bmc_hs15_hready),
	.hs15_haddr     (hs15_haddr     ),
	.hs15_hburst    (hs15_hburst    ),
	.hs15_hprot     (hs15_hprot     ),
	.hs15_hsel      (hs15_hsel      ),
	.hs15_hsize     (hs15_hsize     ),
	.hs15_htrans    (hs15_htrans    ),
	.hs15_hwdata    (hs15_hwdata    ),
	.hs15_hwrite    (hs15_hwrite    ),
`endif
`ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en   (       ),
	.ahb_slv1_en    (       ),
	.ahb_slv2_en    (       ),
	.ahb_slv3_en    (       ),
	.ahb_slv4_en    (       ),
	.ahb_slv5_en    (       ),
	.ahb_slv6_en    (       ),
	.ahb_slv7_en    (       ),
	.ahb_slv8_en    (       ),
	.ahb_slv9_en    (       ),
`endif
	.hclk           (hclk           ),
	.hresetn        (hresetn        ),
	.bmc_intr       (bmc_int        )
);

`ifdef ATCBMC200_AHB_SLV2
   `ifdef AE250_DMA_SUPPORT
atcdmac100 u_dmac (
	.haddr_mst  (hm1_haddr     ),
	.hburst_mst (hm1_hburst    ),
	.hbusreq_mst(      ),
	.hgrant_mst (1'b1          ),
	.hlock_mst  (      ),
	.hprot_mst  (hm1_hprot     ),
	.hrdata_mst (hm1_hrdata    ),
	.hready_mst (hm1_hready    ),
	.hresp_mst  (hm1_hresp     ),
	.hsize_mst  (hm1_hsize     ),
	.htrans_mst (hm1_htrans    ),
	.hwdata_mst (hm1_hwdata    ),
	.hwrite_mst (hm1_hwrite    ),
	.hclk       (hclk          ),
	.hresetn    (hresetn       ),
	.dma_int    (dma_int       ),
	.haddr      (hs2_haddr     ),
	.hburst     (hs2_hburst    ),
	.hrdata     (hs2_hrdata    ),
	.hready     (hs2_bmc_hready),
	.hreadyin   (bmc_hs2_hready),
	.hresp      (hs2_hresp     ),
	.hsel       (hs2_hsel      ),
	.hsize      (hs2_hsize     ),
	.htrans     (hs2_htrans    ),
	.hwdata     (hs2_hwdata    ),
	.hwrite     (hs2_hwrite    ),
	.dma_ack    (dma_ack       ),
	.dma_req    (dma_req       )
);

   `endif
`endif
atcapbbrg100 u_apbbrg (
`ifdef ATCAPBBRG100_SLV_1
	.ps1_psel     (ps1_psel      ),
	.ps1_prdata   (ps1_prdata    ),
	.ps1_pready   (1'b1          ),
	.ps1_pslverr  (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_2
	.ps2_psel     (ps2_psel      ),
	.ps2_prdata   (ps2_prdata    ),
	.ps2_pready   (1'b1          ),
	.ps2_pslverr  (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_3
	.ps3_psel     (ps3_psel      ),
	.ps3_prdata   (ps3_prdata    ),
	.ps3_pready   (1'b1          ),
	.ps3_pslverr  (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_4
	.ps4_psel     (ps4_psel      ),
	.ps4_prdata   (ps4_prdata    ),
	.ps4_pready   (1'b1          ),
	.ps4_pslverr  (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_5
	.ps5_psel     (ps5_psel      ),
	.ps5_prdata   (ps5_prdata    ),
	.ps5_pready   (1'b1          ),
	.ps5_pslverr  (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_6
	.ps6_psel     (ps6_psel      ),
	.ps6_prdata   (ps6_prdata    ),
	.ps6_pready   (1'b1          ),
	.ps6_pslverr  (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_7
	.ps7_psel     (ps7_psel      ),
	.ps7_prdata   (ps7_prdata    ),
	.ps7_pready   (1'b1          ),
	.ps7_pslverr  (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_8
	.ps8_psel     (ps8_psel      ),
	.ps8_prdata   (ps8_prdata    ),
	.ps8_pready   (1'b1          ),
	.ps8_pslverr  (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_9
	.ps9_psel     (ps9_psel      ),
	.ps9_prdata   (ps9_prdata    ),
	.ps9_pready   (ps9_pready    ),
	.ps9_pslverr  (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_10
	.ps10_psel    (ps10_psel     ),
	.ps10_prdata  (ps10_prdata   ),
	.ps10_pready  (ps10_pready   ),
	.ps10_pslverr (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_11
	.ps11_psel    (ps11_psel     ),
	.ps11_prdata  (ps11_prdata   ),
	.ps11_pready  (1'b1          ),
	.ps11_pslverr (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_12
	.ps12_psel    (ps12_psel     ),
	.ps12_prdata  (ps12_prdata   ),
	.ps12_pready  (ps12_pready   ),
	.ps12_pslverr (ps12_pslverr  ),
`endif
`ifdef ATCAPBBRG100_SLV_13
	.ps13_psel    (ps13_psel     ),
	.ps13_prdata  (ps13_prdata   ),
	.ps13_pready  (ps13_pready   ),
	.ps13_pslverr (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_14
	.ps14_psel    (ps14_psel     ),
	.ps14_prdata  (ps14_prdata   ),
	.ps14_pready  (ps14_pready   ),
	.ps14_pslverr (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_15
	.ps15_psel    (ps15_psel     ),
	.ps15_prdata  (ps15_prdata   ),
	.ps15_pready  (ps15_pready   ),
	.ps15_pslverr (ps15_pslverr  ),
`endif
`ifdef ATCAPBBRG100_SLV_16
	.ps16_psel    (ps16_psel     ),
	.ps16_prdata  (ps16_prdata   ),
	.ps16_pready  (1'b1          ),
	.ps16_pslverr (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_17
	.ps17_psel    (ps17_psel     ),
	.ps17_prdata  (ps17_prdata   ),
	.ps17_pready  (1'b1          ),
	.ps17_pslverr (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_18
	.ps18_psel    (ps18_psel     ),
	.ps18_prdata  (ps18_prdata   ),
	.ps18_pready  (1'b1          ),
	.ps18_pslverr (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_19
	.ps19_psel    (ps19_psel     ),
	.ps19_prdata  (ps19_prdata   ),
	.ps19_pready  (1'b1          ),
	.ps19_pslverr (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_20
	.ps20_psel    (ps20_psel     ),
	.ps20_prdata  (ps20_prdata   ),
	.ps20_pready  (1'b1          ),
	.ps20_pslverr (1'b0          ),
`endif
`ifdef ATCAPBBRG100_SLV_21
	.ps21_psel    (ps21_psel     ),
	.ps21_prdata  (ps21_prdata   ),
	.ps21_pready  (ps21_pready   ),
	.ps21_pslverr (ps21_pslverr  ),
`endif
`ifdef ATCAPBBRG100_SLV_22
	.ps22_psel    (ps22_psel     ),
	.ps22_prdata  (ps22_prdata   ),
	.ps22_pready  (ps22_pready   ),
	.ps22_pslverr (ps22_pslverr  ),
`endif
`ifdef ATCAPBBRG100_SLV_23
	.ps23_psel    (ps23_psel     ),
	.ps23_prdata  (ps23_prdata   ),
	.ps23_pready  (ps23_pready   ),
	.ps23_pslverr (ps23_pslverr  ),
`endif
`ifdef ATCAPBBRG100_SLV_24
	.ps24_psel    (ps24_psel     ),
	.ps24_prdata  (ps24_prdata   ),
	.ps24_pready  (ps24_pready   ),
	.ps24_pslverr (ps24_pslverr  ),
`endif
`ifdef ATCAPBBRG100_SLV_25
	.ps25_psel    (ps25_psel     ),
	.ps25_prdata  (ps25_prdata   ),
	.ps25_pready  (ps25_pready   ),
	.ps25_pslverr (ps25_pslverr  ),
`endif
`ifdef ATCAPBBRG100_SLV_26
	.ps26_psel    (ps26_psel     ),
	.ps26_prdata  (ps26_prdata   ),
	.ps26_pready  (ps26_pready   ),
	.ps26_pslverr (ps26_pslverr  ),
`endif
`ifdef ATCAPBBRG100_SLV_27
	.ps27_psel    (ps27_psel     ),
	.ps27_prdata  (ps27_prdata   ),
	.ps27_pready  (ps27_pready   ),
	.ps27_pslverr (ps27_pslverr  ),
`endif
`ifdef ATCAPBBRG100_SLV_28
	.ps28_psel    (ps28_psel     ),
	.ps28_prdata  (ps28_prdata   ),
	.ps28_pready  (ps28_pready   ),
	.ps28_pslverr (ps28_pslverr  ),
`endif
`ifdef ATCAPBBRG100_SLV_29
	.ps29_psel    (ps29_psel     ),
	.ps29_prdata  (ps29_prdata   ),
	.ps29_pready  (ps29_pready   ),
	.ps29_pslverr (ps29_pslverr  ),
`endif
`ifdef ATCAPBBRG100_SLV_30
	.ps30_psel    (ps30_psel     ),
	.ps30_prdata  (ps30_prdata   ),
	.ps30_pready  (ps30_pready   ),
	.ps30_pslverr (ps30_pslverr  ),
`endif
`ifdef ATCAPBBRG100_SLV_31
	.ps31_psel    (ps31_psel     ),
	.ps31_prdata  (ps31_prdata   ),
	.ps31_pready  (ps31_pready   ),
	.ps31_pslverr (ps31_pslverr  ),
`endif
	.hclk         (hclk          ),
	.hresetn      (hresetn       ),
	.hsel         (hs1_hsel      ),
	.hready_in    (bmc_hs1_hready),
	.htrans       (hs1_htrans    ),
	.haddr        (hs1_haddr     ),
	.hsize        (hs1_hsize     ),
	.hprot        (hs1_hprot     ),
	.hwrite       (hs1_hwrite    ),
	.hwdata       (hs1_hwdata    ),
	.apb2ahb_clken(apb2ahb_clken ),
	.hrdata       (hs1_hrdata    ),
	.hready       (hs1_bmc_hready),
	.hresp        (hs1_hresp     ),
	.pclk         (pclk          ),
	.presetn      (presetn       ),
	.pprot        (pprot         ),
	.pstrb        (pstrb         ),
	.paddr        (paddr         ),
	.penable      (penable       ),
	.pwrite       (pwrite        ),
	.pwdata       (pwdata        )
);

`ifdef ATCAPBBRG100_SLV_11

`endif
`ifdef ATCBMC200_AHB_SLV5
ae250_ram_subsystem #(
	.SIMULATION      (SIMULATION      ),
	.SIM_BYPASS_INIT_CAL(SIM_BYPASS_INIT_CAL)
) ae250_ram_subsystem (
	.hprot              (hs5_hprot          ),
	.haddr              (hs5_haddr          ),
	.hburst             (hs5_hburst         ),
	.hready             (bmc_hs5_hready     ),
	.hreadyout          (hs5_bmc_hready     ),
	.hresp              (hs5_hresp          ),
	.hsel               (hs5_hsel           ),
	.hsize              (hs5_hsize          ),
	.htrans             (hs5_htrans         ),
	.hwrite             (hs5_hwrite         ),
	.hclk               (hclk               ),
	.hresetn            (hresetn            ),
	.init_calib_complete(init_calib_complete),
	.hrdata             (hs5_hrdata         ),
	.hwdata             (hs5_hwdata         )
);

`endif
`ifdef AE250_SPI1_SUPPORT
   `ifdef NCEEIC050_SUPPORT
nceeic050 #(
	.ADDR_WIDTH      (20              ),
	.CACHE_LINE_SIZE (CACHE_LINE_SIZE ),
	.CACHE_RAM_SIZE_KB(CACHE_RAM_SIZE_KB),
	.CACHE_WAY_NUM   (CACHE_WAY_NUM   ),
	.FILL_START_ADDR (FILL_START_ADDR )
) u_nceeic050 (
	.us_htrans                    (hs15_htrans                  ),
	.us_haddr                     (hs15_haddr[19:0]             ),
	.us_hsize                     (hs15_hsize                   ),
	.us_hburst                    (hs15_hburst                  ),
	.us_hprot                     (hs15_hprot                   ),
	.us_hwrite                    (hs15_hwrite                  ),
	.us_hsel                      (hs15_hsel                    ),
	.us_hready                    (bmc_hs15_hready              ),
	.us_hwdata                    (hs15_hwdata                  ),
	.us_hrdata                    (hs15_hrdata                  ),
	.us_hresp                     (eic050_us_hresp              ),
	.us_hreadyout                 (hs15_bmc_hready              ),
	.nceeic050_tag_ram_cs_way0    (nceeic050_tag_ram_cs_way0    ),
	.nceeic050_tag_ram_we_way0    (nceeic050_tag_ram_we_way0    ),
	.nceeic050_tag_ram_cs_way1    (nceeic050_tag_ram_cs_way1    ),
	.nceeic050_tag_ram_we_way1    (nceeic050_tag_ram_we_way1    ),
	.nceeic050_tag_ram_addr       (nceeic050_tag_ram_addr       ),
	.nceeic050_tag_ram_wdata      (nceeic050_tag_ram_wdata      ),
	.nceeic050_tag_ram_rdata_way0 (nceeic050_tag_ram_rdata_way0 ),
	.nceeic050_tag_ram_rdata_way1 (nceeic050_tag_ram_rdata_way1 ),
	.nceeic050_data_ram_cs_way0   (nceeic050_data_ram_cs_way0   ),
	.nceeic050_data_ram_we_way0   (nceeic050_data_ram_we_way0   ),
	.nceeic050_data_ram_cs_way1   (nceeic050_data_ram_cs_way1   ),
	.nceeic050_data_ram_we_way1   (nceeic050_data_ram_we_way1   ),
	.nceeic050_data_ram_addr      (nceeic050_data_ram_addr      ),
	.nceeic050_data_ram_wdata     (nceeic050_data_ram_wdata     ),
	.nceeic050_data_ram_rdata_way0(nceeic050_data_ram_rdata_way0),
	.nceeic050_data_ram_rdata_way1(nceeic050_data_ram_rdata_way1),
	.ds_htrans                    (eic_spi_htrans               ),
	.ds_haddr                     (eic_spi_haddr                ),
	.ds_hsize                     (eic_spi_hsize                ),
	.ds_hburst                    (eic_spi_hburst               ),
	.ds_hprot                     (eic_spi_hprot                ),
	.ds_hwrite                    (eic_spi_hwrite               ),
	.ds_hwdata                    (eic_spi_hwdata               ),
	.ds_hrdata                    (eic_spi_hrdata               ),
	.ds_hresp                     (eic_ds_spi_hresp             ),
	.ds_hready                    (eic_spi_hready               ),
	.no_cache_init                (1'b0                         ),
	.reg_access_enable            (1'b1                         ),
	.reg_cache_enable             (1'b0                         ),
	.hclk                         (hclk                         ),
	.hresetn                      (hresetn                      )
);

n22_eic_ram #(
	.ADDR_WIDTH      (20              ),
	.CACHE_LINE_SIZE (CACHE_LINE_SIZE ),
	.CACHE_RAM_SIZE_KB(CACHE_RAM_SIZE_KB),
	.CACHE_WAY_NUM   (CACHE_WAY_NUM   )
) u_eic050_ram (
	.clk                          (hclk                         ),
	.nceeic050_tag_ram_cs_way0    (nceeic050_tag_ram_cs_way0    ),
	.nceeic050_tag_ram_we_way0    (nceeic050_tag_ram_we_way0    ),
	.nceeic050_tag_ram_cs_way1    (nceeic050_tag_ram_cs_way1    ),
	.nceeic050_tag_ram_we_way1    (nceeic050_tag_ram_we_way1    ),
	.nceeic050_tag_ram_addr       (nceeic050_tag_ram_addr       ),
	.nceeic050_tag_ram_wdata      (nceeic050_tag_ram_wdata      ),
	.nceeic050_tag_ram_rdata_way0 (nceeic050_tag_ram_rdata_way0 ),
	.nceeic050_tag_ram_rdata_way1 (nceeic050_tag_ram_rdata_way1 ),
	.nceeic050_data_ram_cs_way0   (nceeic050_data_ram_cs_way0   ),
	.nceeic050_data_ram_we_way0   (nceeic050_data_ram_we_way0   ),
	.nceeic050_data_ram_cs_way1   (nceeic050_data_ram_cs_way1   ),
	.nceeic050_data_ram_we_way1   (nceeic050_data_ram_we_way1   ),
	.nceeic050_data_ram_addr      (nceeic050_data_ram_addr      ),
	.nceeic050_data_ram_wdata     (nceeic050_data_ram_wdata     ),
	.nceeic050_data_ram_rdata_way0(nceeic050_data_ram_rdata_way0),
	.nceeic050_data_ram_rdata_way1(nceeic050_data_ram_rdata_way1)
);

   `endif
`endif
ae250_cpu_subsystem ae250_cpu_subsystem (
`ifdef AE250_PLDM_SYS_BUS_ACCESS
	.dm_sys_haddr             (dm_sys_haddr       ),
	.dm_sys_hburst            (dm_sys_hburst      ),
	.dm_sys_hbusreq           (dm_sys_hbusreq     ),
	.dm_sys_hgrant            (dm_sys_hgrant      ),
	.dm_sys_hprot             (dm_sys_hprot       ),
	.dm_sys_hrdata            (dm_sys_hrdata      ),
	.dm_sys_hready            (dm_sys_hready      ),
	.dm_sys_hresp             (dm_sys_hresp       ),
	.dm_sys_hsize             (dm_sys_hsize       ),
	.dm_sys_htrans            (dm_sys_htrans      ),
	.dm_sys_hwdata            (dm_sys_hwdata      ),
	.dm_sys_hwrite            (dm_sys_hwrite      ),
`endif
`ifdef NDS_BOARD_CF1
	.int_src                  (int_src            ),
`else
	.int_src                  (int_src            ),
`endif
`ifdef N22_HAS_ILM
   `ifdef N22_LM_ITF_TYPE_AHBL
   `endif
`endif
	.dbg_wakeup_req           (dbg_wakeup_req     ),
	.test_mode                (test_mode          ),
	.hart0_nmi                (wdt_int            ),
	.dbg_srst_req             (dbg_srst_req       ),
	.dbg_tck                  (dbg_tck            ),
	.mtime_clk                (pclk               ),
	.pin_tdi_in               (pin_tdi_in         ),
	.pin_tdi_out              (pin_tdi_out        ),
	.pin_tdi_out_en           (pin_tdi_out_en     ),
	.pin_tdo_in               (pin_tdo_in         ),
	.pin_tdo_out              (pin_tdo_out        ),
	.pin_tdo_out_en           (pin_tdo_out_en     ),
	.pin_tms_in               (pin_tms_in         ),
	.pin_tms_out              (pin_tms_out        ),
	.pin_tms_out_en           (pin_tms_out_en     ),
	.pin_trst_in              (pin_trst_in        ),
	.pin_trst_out             (pin_trst_out       ),
	.pin_trst_out_en          (pin_trst_out_en    ),
	.por_rstn                 (por_rstn           ),
	.core_clk                 (core_clk           ),
	.hart0_core_reset_n       (core_resetn        ),
	.hart0_core_wfi_mode      (core_wfi_mode      ),
	.hart0_reset_vector       (reset_vector       ),
	.hart0_icache_disable_init(icache_disable_init),
	.hart0_dcache_disable_init(dcache_disable_init),
	.ahb_bus_clk_en           (ahb2core_clken     ),
	.hclk                     (hclk               ),
	.hresetn                  (hresetn            ),
	.hrdata                   (cpu_hrdata         ),
	.hready                   (cpu_hready         ),
	.hresp                    (cpu_hresp          ),
	.haddr                    (cpu_haddr          ),
	.hburst                   (cpu_hburst         ),
	.hprot                    (cpu_hprot          ),
	.hsize                    (cpu_hsize          ),
	.htrans                   (cpu_htrans         ),
	.hwdata                   (cpu_hwdata         ),
	.hwrite                   (cpu_hwrite         )
);

`ifdef NDS_BIU_DATA_WIDTH_32
`else
generate
if (NDS_BIU_DATA_WIDTH > AE250_DATA_WIDTH) begin : gen_cpu_bmc_sizedn

	atcsizedn100 #(
		.ADDR_WIDTH      (`ATCBMC200_ADDR_MSB+1),
		.DS_DATA_WIDTH   (AE250_DATA_WIDTH),
		.US_DATA_WIDTH   (NDS_BIU_DATA_WIDTH)
	) cpu_bmc_sizedn (
		.hclk        (hclk                 ),
		.hresetn     (hresetn              ),
		.us_haddr    (cpu_haddr[`ATCBMC200_ADDR_MSB:0]),
		.us_hburst   (cpu_hburst           ),
		.us_hprot    (cpu_hprot            ),
		.us_hsel     (1'b1                 ),
		.us_hrdata   (cpu_hrdata           ),
		.us_hready   (cpu_hready           ),
		.us_hreadyout(cpu_hready           ),
		.us_hresp    (cpu_hresp_1bit       ),
		.us_hsize    (cpu_hsize            ),
		.us_hwdata   (cpu_hwdata           ),
		.us_hwrite   (cpu_hwrite           ),
		.us_htrans   (cpu_htrans           ),
		.ds_haddr    (sizedn_cpu_haddr     ),
		.ds_hburst   (sizedn_cpu_hburst    ),
		.ds_hprot    (sizedn_cpu_hprot     ),
		.ds_hrdata   (sizedn_cpu_hrdata    ),
		.ds_hready   (sizedn_cpu_hready    ),
		.ds_hresp    (sizedn_cpu_hresp_1bit),
		.ds_hsize    (sizedn_cpu_hsize     ),
		.ds_hwdata   (sizedn_cpu_hwdata    ),
		.ds_hwrite   (sizedn_cpu_hwrite    ),
		.ds_htrans   (sizedn_cpu_htrans    ),
		.bufw_err    (             )
	);

end
endgenerate

`endif
ae250_pin ae250_pin (
	.X_oschio        (X_oschio        ),
	.X_oschin        (X_oschin        ),
	.T_osch          (T_osch          ),
	.X_hw_rstn       (X_hw_rstn       ),
	.T_hw_rstn       (T_hw_rstn       ),
	.X_por_b         (X_por_b         ),
	.T_por_b         (T_por_b         ),
`ifdef PLATFORM_DEBUG_PORT
	.X_tms           (X_tms           ),
   `ifdef AE250_JTAG_TWOWIRE
   `else
	.X_trst          (X_trst          ),
	.X_tdi           (X_tdi           ),
	.X_tdo           (X_tdo           ),
   `endif
	.pin_tms_in      (pin_tms_in      ),
	.pin_tms_out     (pin_tms_out     ),
	.pin_tms_out_en  (pin_tms_out_en  ),
   `ifdef AE250_JTAG_TWOWIRE
   `else
	.pin_trst_in     (pin_trst_in     ),
	.pin_trst_out    (pin_trst_out    ),
	.pin_trst_out_en (pin_trst_out_en ),
	.pin_tdi_in      (pin_tdi_in      ),
	.pin_tdi_out     (pin_tdi_out     ),
	.pin_tdi_out_en  (pin_tdi_out_en  ),
	.pin_tdo_in      (pin_tdo_in      ),
	.pin_tdo_out     (pin_tdo_out     ),
	.pin_tdo_out_en  (pin_tdo_out_en  ),
   `endif
`endif
`ifdef AE250_SPI1_SUPPORT
	.X_spi1_clk      (X_spi1_clk      ),
	.X_spi1_csn      (X_spi1_csn      ),
	.X_spi1_miso     (X_spi1_miso     ),
	.X_spi1_mosi     (X_spi1_mosi     ),
	.spi1_clk_in     (spi1_clk_in     ),
	.spi1_csn_in     (spi1_csn_in     ),
	.spi1_miso_in    (spi1_miso_in    ),
	.spi1_mosi_in    (spi1_mosi_in    ),
	.spi1_clk_out    (spi1_clk_out    ),
	.spi1_clk_oe     (spi1_clk_oe     ),
	.spi1_csn_out    (spi1_csn_out    ),
	.spi1_csn_oe     (spi1_csn_oe     ),
	.spi1_miso_out   (spi1_miso_out   ),
	.spi1_miso_oe    (spi1_miso_oe    ),
	.spi1_mosi_out   (spi1_mosi_out   ),
	.spi1_mosi_oe    (spi1_mosi_oe    ),
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.X_spi1_holdn    (X_spi1_holdn    ),
	.X_spi1_wpn      (X_spi1_wpn      ),
	.spi1_holdn_in   (spi1_holdn_in   ),
	.spi1_wpn_in     (spi1_wpn_in     ),
	.spi1_holdn_out  (spi1_holdn_out  ),
	.spi1_holdn_oe   (spi1_holdn_oe   ),
	.spi1_wpn_out    (spi1_wpn_out    ),
	.spi1_wpn_oe     (spi1_wpn_oe     ),
   `endif
`endif
`ifdef NDS_BOARD_CF1
`else
   `ifdef AE250_SPI2_SUPPORT
	.X_spi2_clk      (X_spi2_clk      ),
	.X_spi2_csn      (X_spi2_csn      ),
	.X_spi2_miso     (X_spi2_miso     ),
	.X_spi2_mosi     (X_spi2_mosi     ),
   `endif
`endif
`ifdef AE250_SPI2_SUPPORT
	.spi2_clk_in     (spi2_clk_in     ),
	.spi2_csn_in     (spi2_csn_in     ),
	.spi2_miso_in    (spi2_miso_in    ),
	.spi2_mosi_in    (spi2_mosi_in    ),
	.spi2_clk_out    (spi2_clk_out    ),
	.spi2_clk_oe     (spi2_clk_oe     ),
	.spi2_csn_out    (spi2_csn_out    ),
	.spi2_csn_oe     (spi2_csn_oe     ),
	.spi2_miso_out   (spi2_miso_out   ),
	.spi2_miso_oe    (spi2_miso_oe    ),
	.spi2_mosi_out   (spi2_mosi_out   ),
	.spi2_mosi_oe    (spi2_mosi_oe    ),
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.X_spi2_holdn    (X_spi2_holdn    ),
	.X_spi2_wpn      (X_spi2_wpn      ),
	.spi2_holdn_in   (spi2_holdn_in   ),
	.spi2_wpn_in     (spi2_wpn_in     ),
	.spi2_holdn_out  (spi2_holdn_out  ),
	.spi2_holdn_oe   (spi2_holdn_oe   ),
	.spi2_wpn_out    (spi2_wpn_out    ),
	.spi2_wpn_oe     (spi2_wpn_oe     ),
   `endif
`endif
`ifdef AE250_SPI3_SUPPORT
	.X_spi3_clk      (X_spi3_clk      ),
	.X_spi3_csn      (X_spi3_csn      ),
	.X_spi3_miso     (X_spi3_miso     ),
	.X_spi3_mosi     (X_spi3_mosi     ),
	.spi3_clk_in     (spi3_clk_in     ),
	.spi3_csn_in     (spi3_csn_in     ),
	.spi3_miso_in    (spi3_miso_in    ),
	.spi3_mosi_in    (spi3_mosi_in    ),
	.spi3_clk_out    (spi3_clk_out    ),
	.spi3_clk_oe     (spi3_clk_oe     ),
	.spi3_csn_out    (spi3_csn_out    ),
	.spi3_csn_oe     (spi3_csn_oe     ),
	.spi3_miso_out   (spi3_miso_out   ),
	.spi3_miso_oe    (spi3_miso_oe    ),
	.spi3_mosi_out   (spi3_mosi_out   ),
	.spi3_mosi_oe    (spi3_mosi_oe    ),
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.X_spi3_holdn    (X_spi3_holdn    ),
	.X_spi3_wpn      (X_spi3_wpn      ),
	.spi3_holdn_in   (spi3_holdn_in   ),
	.spi3_wpn_in     (spi3_wpn_in     ),
	.spi3_holdn_out  (spi3_holdn_out  ),
	.spi3_holdn_oe   (spi3_holdn_oe   ),
	.spi3_wpn_out    (spi3_wpn_out    ),
	.spi3_wpn_oe     (spi3_wpn_oe     ),
   `endif
`endif
`ifdef AE250_SPI4_SUPPORT
	.X_spi4_clk      (X_spi4_clk      ),
	.X_spi4_csn      (X_spi4_csn      ),
	.X_spi4_miso     (X_spi4_miso     ),
	.X_spi4_mosi     (X_spi4_mosi     ),
	.spi4_clk_in     (spi4_clk_in     ),
	.spi4_csn_in     (spi4_csn_in     ),
	.spi4_miso_in    (spi4_miso_in    ),
	.spi4_mosi_in    (spi4_mosi_in    ),
	.spi4_clk_out    (spi4_clk_out    ),
	.spi4_clk_oe     (spi4_clk_oe     ),
	.spi4_csn_out    (spi4_csn_out    ),
	.spi4_csn_oe     (spi4_csn_oe     ),
	.spi4_miso_out   (spi4_miso_out   ),
	.spi4_miso_oe    (spi4_miso_oe    ),
	.spi4_mosi_out   (spi4_mosi_out   ),
	.spi4_mosi_oe    (spi4_mosi_oe    ),
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.X_spi4_holdn    (X_spi4_holdn    ),
	.X_spi4_wpn      (X_spi4_wpn      ),
	.spi4_holdn_in   (spi4_holdn_in   ),
	.spi4_wpn_in     (spi4_wpn_in     ),
	.spi4_holdn_out  (spi4_holdn_out  ),
	.spi4_holdn_oe   (spi4_holdn_oe   ),
	.spi4_wpn_out    (spi4_wpn_out    ),
	.spi4_wpn_oe     (spi4_wpn_oe     ),
   `endif
`endif
`ifdef NDS_BOARD_CF1
`else
   `ifdef AE250_I2C_SUPPORT
	.X_i2c_scl       (X_i2c_scl       ),
	.X_i2c_sda       (X_i2c_sda       ),
   `endif
`endif
`ifdef AE250_I2C_SUPPORT
	.i2c_scl_in      (i2c_scl_in      ),
	.i2c_sda_in      (i2c_sda_in      ),
	.i2c_scl         (i2c_scl         ),
	.i2c_sda         (i2c_sda         ),
`endif
`ifdef AE250_I2C2_SUPPORT
	.i2c2_scl_in     (i2c2_scl_in     ),
	.i2c2_sda_in     (i2c2_sda_in     ),
	.i2c2_scl        (i2c2_scl        ),
	.i2c2_sda        (i2c2_sda        ),
`endif
`ifdef NDS_BOARD_CF1
`else
   `ifdef AE250_UART1_SUPPORT
	.X_uart1_txd     (X_uart1_txd     ),
	.X_uart1_rxd     (X_uart1_rxd     ),
	.X_uart1_dsrn    (X_uart1_dsrn    ),
	.X_uart1_dcdn    (X_uart1_dcdn    ),
	.X_uart1_rin     (X_uart1_rin     ),
	.X_uart1_dtrn    (X_uart1_dtrn    ),
	.X_uart1_out1n   (X_uart1_out1n   ),
	.X_uart1_out2n   (X_uart1_out2n   ),
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE250_UART1_SUPPORT
      `ifdef AE250_UART2_SUPPORT
	.X_uart1_ctsn    (X_uart1_ctsn    ),
	.X_uart1_rtsn    (X_uart1_rtsn    ),
      `endif
   `endif
`endif
`ifdef AE250_UART1_SUPPORT
   `ifdef AE250_UART2_SUPPORT
   `else
	.X_uart1_ctsn    (X_uart1_ctsn    ),
	.X_uart1_rtsn    (X_uart1_rtsn    ),
   `endif
`endif
`ifdef NDS_BOARD_CF1
`else
   `ifdef AE250_UART2_SUPPORT
	.X_uart2_txd     (X_uart2_txd     ),
	.X_uart2_rxd     (X_uart2_rxd     ),
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE250_UART2_SUPPORT
	.X_uart2_ctsn    (X_uart2_ctsn    ),
	.X_uart2_rtsn    (X_uart2_rtsn    ),
	.X_uart2_dcdn    (X_uart2_dcdn    ),
	.X_uart2_dsrn    (X_uart2_dsrn    ),
	.X_uart2_rin     (X_uart2_rin     ),
	.X_uart2_dtrn    (X_uart2_dtrn    ),
	.X_uart2_out1n   (X_uart2_out1n   ),
	.X_uart2_out2n   (X_uart2_out2n   ),
   `endif
`endif
`ifdef AE250_UART1_SUPPORT
	.uart1_txd       (uart1_txd       ),
	.uart1_rtsn      (uart1_rtsn      ),
	.uart1_rxd       (uart1_rxd       ),
	.uart1_ctsn      (uart1_ctsn      ),
	.uart1_dsrn      (uart1_dsrn      ),
	.uart1_dcdn      (uart1_dcdn      ),
	.uart1_rin       (uart1_rin       ),
	.uart1_dtrn      (uart1_dtrn      ),
	.uart1_out1n     (uart1_out1n     ),
	.uart1_out2n     (uart1_out2n     ),
`endif
`ifdef AE250_UART2_SUPPORT
	.uart2_txd       (uart2_txd       ),
	.uart2_rtsn      (uart2_rtsn      ),
	.uart2_rxd       (uart2_rxd       ),
	.uart2_ctsn      (uart2_ctsn      ),
	.uart2_dcdn      (uart2_dcdn      ),
	.uart2_dsrn      (uart2_dsrn      ),
	.uart2_rin       (uart2_rin       ),
	.uart2_dtrn      (uart2_dtrn      ),
	.uart2_out1n     (uart2_out1n     ),
	.uart2_out2n     (uart2_out2n     ),
`endif
`ifdef NDS_BOARD_CF1
`else
	.X_pwm_ch0       (X_pwm_ch0       ),
`endif
	.ch0_pwm         (ch0_pwm         ),
	.ch0_pwmoe       (ch0_pwmoe       ),
`ifdef NDS_BOARD_CF1
`else
   `ifdef ATCPIT100_CH1_SUPPORT
	.X_pwm_ch1       (X_pwm_ch1       ),
   `endif
`endif
`ifdef ATCPIT100_CH1_SUPPORT
	.ch1_pwm         (ch1_pwm         ),
	.ch1_pwmoe       (ch1_pwmoe       ),
`endif
`ifdef NDS_BOARD_CF1
`else
   `ifdef ATCPIT100_CH2_SUPPORT
	.X_pwm_ch2       (X_pwm_ch2       ),
   `endif
`endif
`ifdef ATCPIT100_CH2_SUPPORT
	.ch2_pwm         (ch2_pwm         ),
	.ch2_pwmoe       (ch2_pwmoe       ),
`endif
`ifdef NDS_BOARD_CF1
`else
   `ifdef ATCPIT100_CH3_SUPPORT
	.X_pwm_ch3       (X_pwm_ch3       ),
   `endif
`endif
`ifdef ATCPIT100_CH3_SUPPORT
	.ch3_pwm         (ch3_pwm         ),
	.ch3_pwmoe       (ch3_pwmoe       ),
`endif
`ifdef AE250_PIT2_SUPPORT
	.pit2_ch0_pwm    (pit2_ch0_pwm    ),
	.pit2_ch0_pwmoe  (pit2_ch0_pwmoe  ),
   `ifdef ATCPIT100_CH1_SUPPORT
	.pit2_ch1_pwm    (pit2_ch1_pwm    ),
	.pit2_ch1_pwmoe  (pit2_ch1_pwmoe  ),
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
	.pit2_ch2_pwm    (pit2_ch2_pwm    ),
	.pit2_ch2_pwmoe  (pit2_ch2_pwmoe  ),
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
	.pit2_ch3_pwm    (pit2_ch3_pwm    ),
	.pit2_ch3_pwmoe  (pit2_ch3_pwmoe  ),
   `endif
`endif
`ifdef AE250_PIT3_SUPPORT
	.pit3_ch0_pwm    (pit3_ch0_pwm    ),
	.pit3_ch0_pwmoe  (pit3_ch0_pwmoe  ),
   `ifdef ATCPIT100_CH1_SUPPORT
	.pit3_ch1_pwm    (pit3_ch1_pwm    ),
	.pit3_ch1_pwmoe  (pit3_ch1_pwmoe  ),
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
	.pit3_ch2_pwm    (pit3_ch2_pwm    ),
	.pit3_ch2_pwmoe  (pit3_ch2_pwmoe  ),
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
	.pit3_ch3_pwm    (pit3_ch3_pwm    ),
	.pit3_ch3_pwmoe  (pit3_ch3_pwmoe  ),
   `endif
`endif
`ifdef AE250_PIT4_SUPPORT
	.pit4_ch0_pwm    (pit4_ch0_pwm    ),
	.pit4_ch0_pwmoe  (pit4_ch0_pwmoe  ),
   `ifdef ATCPIT100_CH1_SUPPORT
	.pit4_ch1_pwm    (pit4_ch1_pwm    ),
	.pit4_ch1_pwmoe  (pit4_ch1_pwmoe  ),
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
	.pit4_ch2_pwm    (pit4_ch2_pwm    ),
	.pit4_ch2_pwmoe  (pit4_ch2_pwmoe  ),
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
	.pit4_ch3_pwm    (pit4_ch3_pwm    ),
	.pit4_ch3_pwmoe  (pit4_ch3_pwmoe  ),
   `endif
`endif
`ifdef AE250_PIT5_SUPPORT
	.pit5_ch0_pwm    (pit5_ch0_pwm    ),
	.pit5_ch0_pwmoe  (pit5_ch0_pwmoe  ),
   `ifdef ATCPIT100_CH1_SUPPORT
	.pit5_ch1_pwm    (pit5_ch1_pwm    ),
	.pit5_ch1_pwmoe  (pit5_ch1_pwmoe  ),
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
	.pit5_ch2_pwm    (pit5_ch2_pwm    ),
	.pit5_ch2_pwmoe  (pit5_ch2_pwmoe  ),
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
	.pit5_ch3_pwm    (pit5_ch3_pwm    ),
	.pit5_ch3_pwmoe  (pit5_ch3_pwmoe  ),
   `endif
`endif
`ifdef NDS_BOARD_CF1
	.cf1_pinmux_ctrl0(cf1_pinmux_ctrl0),
	.cf1_pinmux_ctrl1(cf1_pinmux_ctrl1),
`endif
	.X_gpio          (X_gpio          ),
	.gpio_in         (gpio_in         ),
	.gpio_oe         (gpio_oe         ),
	.gpio_out        (gpio_out        ),
	.gpio_pulldown   (gpio_pulldown   ),
	.gpio_pullup     (gpio_pullup     )
);

`ifdef ATCBMC200_AHB_MST2
   `ifdef ATCBMC200_AHB_SLV4

   `endif
`endif
`ifdef AE250_UART1_SUPPORT
atcuart100 u_uart1 (
   `ifdef ATCUART100_UCLK_PCLK_SAME
   `else
	.uclk      (uart_clk        ),
	.urstn     (uart_rstn       ),
   `endif
	.dma_rx_ack(dma_ack[5]      ),
	.dma_tx_ack(dma_ack[4]      ),
	.paddr     (paddr[5:2]      ),
	.pclk      (pclk_uart1      ),
	.penable   (penable         ),
	.presetn   (presetn         ),
	.psel      (ps2_psel        ),
	.pwdata    (pwdata          ),
	.pwrite    (pwrite          ),
	.uart_ctsn (uart1_ctsn      ),
	.uart_dcdn (uart1_dcdn      ),
	.uart_dsrn (uart1_dsrn      ),
	.uart_rin  (uart1_rin       ),
	.uart_sin  (uart1_rxd       ),
	.dma_rx_req(dmareqn_uart1_rx),
	.dma_tx_req(dmareqn_uart1_tx),
	.prdata    (uart1_prdata    ),
	.uart_dtrn (uart1_dtrn      ),
	.uart_intr (uart1_int       ),
	.uart_out1n(uart1_out1n     ),
	.uart_out2n(uart1_out2n     ),
	.uart_rtsn (uart1_rtsn      ),
	.uart_sout (uart1_txd       )
);

`endif
`ifdef AE250_UART2_SUPPORT
atcuart100 u_uart2 (
   `ifdef ATCUART100_UCLK_PCLK_SAME
   `else
	.uclk      (uart_clk        ),
	.urstn     (uart_rstn       ),
   `endif
	.dma_rx_ack(dma_ack[7]      ),
	.dma_tx_ack(dma_ack[6]      ),
	.paddr     (paddr[5:2]      ),
	.pclk      (pclk_uart2      ),
	.penable   (penable         ),
	.presetn   (presetn         ),
	.psel      (ps3_psel        ),
	.pwdata    (pwdata          ),
	.pwrite    (pwrite          ),
	.uart_ctsn (uart2_ctsn      ),
	.uart_dcdn (uart2_dcdn      ),
	.uart_dsrn (uart2_dsrn      ),
	.uart_rin  (uart2_rin       ),
	.uart_sin  (uart2_rxd       ),
	.dma_rx_req(dmareqn_uart2_rx),
	.dma_tx_req(dmareqn_uart2_tx),
	.prdata    (uart2_prdata    ),
	.uart_dtrn (uart2_dtrn      ),
	.uart_intr (uart2_int       ),
	.uart_out1n(uart2_out1n     ),
	.uart_out2n(uart2_out2n     ),
	.uart_rtsn (uart2_rtsn      ),
	.uart_sout (uart2_txd       )
);

`endif
atcgpio100 u_gpio (
`ifdef ATCGPIO100_PULL_SUPPORT
	.gpio_pulldown(gpio_pulldown),
	.gpio_pullup  (gpio_pullup  ),
`endif
`ifdef ATCGPIO100_INTR_SUPPORT
	.gpio_intr    (gpio_intr    ),
`endif
	.gpio_oe      (gpio_oe      ),
	.gpio_out     (gpio_out     ),
	.paddr        (paddr[7:0]   ),
	.penable      (penable      ),
	.prdata       (ps7_prdata   ),
	.psel         (ps7_psel     ),
	.pwdata       (pwdata       ),
	.pwrite       (pwrite       ),
	.pclk         (pclk_gpio    ),
	.presetn      (presetn      ),
	.extclk       (clk_32k      ),
	.gpio_in      (gpio_in      )
);

atcpit100 u_pit (
`ifdef ATCPIT100_CH1_SUPPORT
	.ch1_pwm  (ch1_pwm   ),
	.ch1_pwmoe(ch1_pwmoe ),
`endif
`ifdef ATCPIT100_CH2_SUPPORT
	.ch2_pwm  (ch2_pwm   ),
	.ch2_pwmoe(ch2_pwmoe ),
`endif
`ifdef ATCPIT100_CH3_SUPPORT
	.ch3_pwm  (ch3_pwm   ),
	.ch3_pwmoe(ch3_pwmoe ),
`endif
	.extclk   (clk_32k   ),
	.paddr    (paddr[6:2]),
	.pclk     (pclk_pit  ),
	.penable  (penable   ),
	.pit_pause(1'b0      ),
	.presetn  (presetn   ),
	.psel     (ps4_psel  ),
	.pwdata   (pwdata    ),
	.pwrite   (pwrite    ),
	.ch0_pwm  (ch0_pwm   ),
	.ch0_pwmoe(ch0_pwmoe ),
	.pit_intr (pit_intr  ),
	.prdata   (ps4_prdata)
);

`ifdef AE250_PIT2_SUPPORT
atcpit100 u_pit2 (
   `ifdef ATCPIT100_CH1_SUPPORT
	.ch1_pwm  (pit2_ch1_pwm  ),
	.ch1_pwmoe(pit2_ch1_pwmoe),
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
	.ch2_pwm  (pit2_ch2_pwm  ),
	.ch2_pwmoe(pit2_ch2_pwmoe),
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
	.ch3_pwm  (pit2_ch3_pwm  ),
	.ch3_pwmoe(pit2_ch3_pwmoe),
   `endif
	.extclk   (clk_32k       ),
	.paddr    (paddr[6:2]    ),
	.pclk     (pclk_pit      ),
	.penable  (penable       ),
	.pit_pause(1'b0          ),
	.presetn  (presetn       ),
	.psel     (ps17_psel     ),
	.pwdata   (pwdata        ),
	.pwrite   (pwrite        ),
	.ch0_pwm  (pit2_ch0_pwm  ),
	.ch0_pwmoe(pit2_ch0_pwmoe),
	.pit_intr (pit2_int      ),
	.prdata   (ps17_prdata   )
);

`endif
`ifdef AE250_PIT3_SUPPORT
atcpit100 u_pit3 (
   `ifdef ATCPIT100_CH1_SUPPORT
	.ch1_pwm  (pit3_ch1_pwm  ),
	.ch1_pwmoe(pit3_ch1_pwmoe),
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
	.ch2_pwm  (pit3_ch2_pwm  ),
	.ch2_pwmoe(pit3_ch2_pwmoe),
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
	.ch3_pwm  (pit3_ch3_pwm  ),
	.ch3_pwmoe(pit3_ch3_pwmoe),
   `endif
	.extclk   (clk_32k       ),
	.paddr    (paddr[6:2]    ),
	.pclk     (pclk_pit      ),
	.penable  (penable       ),
	.pit_pause(1'b0          ),
	.presetn  (presetn       ),
	.psel     (ps18_psel     ),
	.pwdata   (pwdata        ),
	.pwrite   (pwrite        ),
	.ch0_pwm  (pit3_ch0_pwm  ),
	.ch0_pwmoe(pit3_ch0_pwmoe),
	.pit_intr (pit3_int      ),
	.prdata   (ps18_prdata   )
);

`endif
`ifdef AE250_PIT4_SUPPORT
atcpit100 u_pit4 (
   `ifdef ATCPIT100_CH1_SUPPORT
	.ch1_pwm  (pit4_ch1_pwm  ),
	.ch1_pwmoe(pit4_ch1_pwmoe),
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
	.ch2_pwm  (pit4_ch2_pwm  ),
	.ch2_pwmoe(pit4_ch2_pwmoe),
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
	.ch3_pwm  (pit4_ch3_pwm  ),
	.ch3_pwmoe(pit4_ch3_pwmoe),
   `endif
	.extclk   (clk_32k       ),
	.paddr    (paddr[6:2]    ),
	.pclk     (pclk_pit      ),
	.penable  (penable       ),
	.pit_pause(1'b0          ),
	.presetn  (presetn       ),
	.psel     (ps19_psel     ),
	.pwdata   (pwdata        ),
	.pwrite   (pwrite        ),
	.ch0_pwm  (pit4_ch0_pwm  ),
	.ch0_pwmoe(pit4_ch0_pwmoe),
	.pit_intr (pit4_int      ),
	.prdata   (ps19_prdata   )
);

`endif
`ifdef AE250_PIT5_SUPPORT
atcpit100 u_pit5 (
   `ifdef ATCPIT100_CH1_SUPPORT
	.ch1_pwm  (pit5_ch1_pwm  ),
	.ch1_pwmoe(pit5_ch1_pwmoe),
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
	.ch2_pwm  (pit5_ch2_pwm  ),
	.ch2_pwmoe(pit5_ch2_pwmoe),
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
	.ch3_pwm  (pit5_ch3_pwm  ),
	.ch3_pwmoe(pit5_ch3_pwmoe),
   `endif
	.extclk   (clk_32k       ),
	.paddr    (paddr[6:2]    ),
	.pclk     (pclk_pit      ),
	.penable  (penable       ),
	.pit_pause(1'b0          ),
	.presetn  (presetn       ),
	.psel     (ps20_psel     ),
	.pwdata   (pwdata        ),
	.pwrite   (pwrite        ),
	.ch0_pwm  (pit5_ch0_pwm  ),
	.ch0_pwmoe(pit5_ch0_pwmoe),
	.pit_intr (pit5_int      ),
	.prdata   (ps20_prdata   )
);

`endif
atcwdt200 u_wdt (
	.extclk   (clk_32k   ),
	.wdt_pause(1'b0      ),
	.wdt_rst  (wdt_rst   ),
	.wdt_int  (wdt_int   ),
	.pclk     (pclk_wdt  ),
	.presetn  (presetn   ),
	.psel     (ps5_psel  ),
	.penable  (penable   ),
	.paddr    (paddr[4:2]),
	.pwrite   (pwrite    ),
	.pwdata   (pwdata    ),
	.prdata   (ps5_prdata)
);

atcrtc100 u_rtc (
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
	.rtc_int_hsec (rtc_int_hsec ),
`endif
	.freq_test_en (freq_test_en ),
	.paddr        (paddr[5:2]   ),
	.penable      (penable      ),
	.prdata       (ps6_prdata   ),
	.psel         (ps6_psel     ),
	.pwdata       (pwdata       ),
	.pwrite       (pwrite       ),
	.rtc_int_alarm(rtc_int_alarm),
	.rtc_int_day  (rtc_int_day  ),
	.rtc_int_hour (rtc_int_hour ),
	.rtc_int_min  (rtc_int_min  ),
	.rtc_int_sec  (rtc_int_sec  ),
	.rtc_clk      (clk_32k      ),
	.rtc_rstn     (rtc_rstn     ),
	.pclk         (pclk         ),
	.presetn      (presetn      ),
	.alarm_wakeup (alarm_wakeup ),
	.freq_test_out(freq_test_out)
);

`ifdef AE250_I2C_SUPPORT
atciic100 u_i2c (
	.i2c_int(i2c_int   ),
	.paddr  (paddr[5:2]),
	.penable(penable   ),
	.prdata (ps8_prdata),
	.psel   (ps8_psel  ),
	.pwdata (pwdata    ),
	.pwrite (pwrite    ),
	.pclk   (pclk_i2c  ),
	.presetn(presetn   ),
	.dma_ack(dma_ack[8]),
	.dma_req(dmareq_i2c),
	.scl_o  (i2c_scl   ),
	.sda_o  (i2c_sda   ),
	.scl_i  (i2c_scl_in),
	.sda_i  (i2c_sda_in)
);

`endif
`ifdef AE250_I2C2_SUPPORT
atciic100 u_i2c2 (
	.i2c_int(i2c2_int    ),
	.paddr  (paddr[5:2]  ),
	.penable(penable     ),
	.prdata (i2c2_prdata ),
	.psel   (i2c2_psel   ),
	.pwdata (pwdata      ),
	.pwrite (pwrite      ),
	.pclk   (pclk        ),
	.presetn(presetn     ),
	.dma_ack(i2c2_dma_ack),
	.dma_req(dmareq_i2c2 ),
	.scl_o  (i2c2_scl    ),
	.sda_o  (i2c2_sda    ),
	.scl_i  (i2c2_scl_in ),
	.sda_i  (i2c2_sda_in )
);

`endif
`ifdef AE250_SPI1_SUPPORT
atcspi200 u_spi1 (
   `ifdef ATCSPI200_AHBBUS_EXIST
	.hclk                (hclk          ),
	.hresetn             (hresetn       ),
   `endif
   `ifdef ATCSPI200_EILMBUS_EXIST
	.eilm_addr           (      ),
	.eilm_clk            (      ),
	.eilm_rdata          (      ),
	.eilm_req            (      ),
	.eilm_resetn         (      ),
	.eilm_wait           (      ),
	.eilm_wait_cnt       (      ),
	.eilm_wdata          (      ),
	.eilm_web            (      ),
   `endif
   `ifdef ATCSPI200_REG_APB
	.pclk                (pclk_spi1     ),
	.presetn             (presetn       ),
	.paddr               (paddr32       ),
	.penable             (penable       ),
	.prdata              (spi1_prdata   ),
	.pready              (spi1_pready   ),
	.psel                (spi1_psel     ),
	.pwdata              (pwdata        ),
	.pwrite              (pwrite        ),
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
	.haddr_mem           (haddr_mem32   ),
	.hrdata_mem          (hrdata_mem    ),
	.hreadyin_mem        (hreadyin_mem  ),
	.hreadyout_mem       (hreadyout_mem ),
	.hresp_mem           (hresp_mem     ),
	.hsel_mem            (hsel_mem      ),
	.htrans_mem          (htrans_mem    ),
	.hwrite_mem          (hwrite_mem    ),
   `endif
   `ifdef ATCSPI200_REG_AHB
	.haddr_reg           (      ),
	.hrdata_reg          (      ),
	.hreadyin_reg        (      ),
	.hreadyout_reg       (      ),
	.hresp_reg           (      ),
	.hsel_reg            (      ),
	.htrans_reg          (      ),
	.hwdata_reg          (      ),
	.hwrite_reg          (      ),
   `endif
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_default_as_slave(1'b0          ),
	.spi_cs_n_in         (spi1_csn_in   ),
   `endif
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi_hold_n_in       (spi1_holdn_in ),
	.spi_hold_n_oe       (spi1_holdn_oe ),
	.spi_hold_n_out      (spi1_holdn_out),
	.spi_wp_n_in         (spi1_wpn_in   ),
	.spi_wp_n_oe         (spi1_wpn_oe   ),
	.spi_wp_n_out        (spi1_wpn_out  ),
   `endif
   `ifdef ATCSPI200_AHBBUS_EXIST
      `ifdef ATCSPI200_EILMBUS_EXIST
	.ahb2eilm_clken      (      ),
      `endif
      `ifdef ATCSPI200_REG_APB
	.apb2ahb_clken       (apb2ahb_clken ),
      `endif
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
      `ifdef ATCSPI200_HSPLIT_SUPPORT
	.hmaster_mem         ({`ATCSPI200_HMASTER_BIT{1'b0}}),
	.hsplit_mem          (      ),
      `endif
   `endif
   `ifdef ATCSPI200_REG_EILM
      `ifdef ATCSPI200_EILM_MEM_SUPPORT
	.eilm_reg_sel        (      ),
      `endif
   `endif
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi_cs_n_in         (spi1_csn_in   ),
      `endif
   `endif
   `ifdef ATCSPI200_AHBBUS_EXIST
   `else
      `ifdef ATCSPI200_EILMBUS_EXIST
         `ifdef ATCSPI200_REG_APB
	.apb2eilm_clken      (apb2core_clken),
         `endif
      `endif
   `endif
	.spi_clock           (spi_clk       ),
	.spi_rstn            (spi_rstn      ),
	.spi_boot_intr       (spi1_int      ),
	.spi_default_mode3   (1'b0          ),
	.spi_rx_dma_ack      (dma_ack[1]    ),
	.spi_rx_dma_req      (dmareq_spi1_rx),
	.spi_tx_dma_ack      (dma_ack[0]    ),
	.spi_tx_dma_req      (dmareq_spi1_tx),
	.scan_enable         (scan_enable   ),
	.scan_test           (scan_test     ),
	.spi_clk_in          (spi1_clk_in   ),
	.spi_clk_oe          (spi1_clk_oe   ),
	.spi_clk_out         (spi1_clk_out  ),
	.spi_cs_n_oe         (spi1_csn_oe   ),
	.spi_cs_n_out        (spi1_csn_out  ),
	.spi_miso_in         (spi1_miso_in  ),
	.spi_miso_oe         (spi1_miso_oe  ),
	.spi_miso_out        (spi1_miso_out ),
	.spi_mosi_in         (spi1_mosi_in  ),
	.spi_mosi_oe         (spi1_mosi_oe  ),
	.spi_mosi_out        (spi1_mosi_out )
);

`endif
`ifdef AE250_SPI2_SUPPORT
atcspi200 u_spi2 (
   `ifdef ATCSPI200_AHBBUS_EXIST
	.hclk                (hclk                          ),
	.hresetn             (hresetn                       ),
   `endif
   `ifdef ATCSPI200_EILMBUS_EXIST
	.eilm_addr           (                      ),
	.eilm_clk            (                      ),
	.eilm_rdata          (                      ),
	.eilm_req            (                      ),
	.eilm_resetn         (                      ),
	.eilm_wait           (                      ),
	.eilm_wait_cnt       (                      ),
	.eilm_wdata          (                      ),
	.eilm_web            (                      ),
   `endif
   `ifdef ATCSPI200_REG_APB
	.pclk                (pclk_spi2                     ),
	.presetn             (presetn                       ),
	.paddr               (paddr32                       ),
	.penable             (penable                       ),
	.prdata              (spi2_prdata                   ),
	.pready              (spi2_pready                   ),
	.psel                (spi2_psel                     ),
	.pwdata              (pwdata                        ),
	.pwrite              (pwrite                        ),
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
	.haddr_mem           ({`ATCSPI200_HADDR_WIDTH{1'b0}}),
	.hrdata_mem          (                      ),
	.hreadyin_mem        (1'b0                          ),
	.hreadyout_mem       (                      ),
	.hresp_mem           (                      ),
	.hsel_mem            (1'b0                          ),
	.htrans_mem          (2'b0                          ),
	.hwrite_mem          (1'b0                          ),
   `endif
   `ifdef ATCSPI200_REG_AHB
	.haddr_reg           (                      ),
	.hrdata_reg          (                      ),
	.hreadyin_reg        (                      ),
	.hreadyout_reg       (                      ),
	.hresp_reg           (                      ),
	.hsel_reg            (                      ),
	.htrans_reg          (                      ),
	.hwdata_reg          (                      ),
	.hwrite_reg          (                      ),
   `endif
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_default_as_slave(1'b0                          ),
	.spi_cs_n_in         (spi2_csn_in                   ),
   `endif
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi_hold_n_in       (spi2_holdn_in                 ),
	.spi_hold_n_oe       (spi2_holdn_oe                 ),
	.spi_hold_n_out      (spi2_holdn_out                ),
	.spi_wp_n_in         (spi2_wpn_in                   ),
	.spi_wp_n_oe         (spi2_wpn_oe                   ),
	.spi_wp_n_out        (spi2_wpn_out                  ),
   `endif
   `ifdef ATCSPI200_AHBBUS_EXIST
      `ifdef ATCSPI200_EILMBUS_EXIST
	.ahb2eilm_clken      (                      ),
      `endif
      `ifdef ATCSPI200_REG_APB
	.apb2ahb_clken       (apb2ahb_clken                 ),
      `endif
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
      `ifdef ATCSPI200_HSPLIT_SUPPORT
	.hmaster_mem         ({`ATCSPI200_HMASTER_BIT{1'b0}}),
	.hsplit_mem          (                      ),
      `endif
   `endif
   `ifdef ATCSPI200_REG_EILM
      `ifdef ATCSPI200_EILM_MEM_SUPPORT
	.eilm_reg_sel        (                      ),
      `endif
   `endif
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi_cs_n_in         (spi2_csn_in                   ),
      `endif
   `endif
   `ifdef ATCSPI200_AHBBUS_EXIST
   `else
      `ifdef ATCSPI200_EILMBUS_EXIST
         `ifdef ATCSPI200_REG_APB
	.apb2eilm_clken      (apb2core_clken                ),
         `endif
      `endif
   `endif
	.spi_clock           (spi_clk                       ),
	.spi_rstn            (spi_rstn                      ),
	.spi_boot_intr       (spi2_int                      ),
	.spi_default_mode3   (1'b0                          ),
	.spi_rx_dma_ack      (dma_ack[3]                    ),
	.spi_rx_dma_req      (dmareq_spi2_rx                ),
	.spi_tx_dma_ack      (dma_ack[2]                    ),
	.spi_tx_dma_req      (dmareq_spi2_tx                ),
	.scan_enable         (scan_enable                   ),
	.scan_test           (scan_test                     ),
	.spi_clk_in          (spi2_clk_in                   ),
	.spi_clk_oe          (spi2_clk_oe                   ),
	.spi_clk_out         (spi2_clk_out                  ),
	.spi_cs_n_oe         (spi2_csn_oe                   ),
	.spi_cs_n_out        (spi2_csn_out                  ),
	.spi_miso_in         (spi2_miso_in                  ),
	.spi_miso_oe         (spi2_miso_oe                  ),
	.spi_miso_out        (spi2_miso_out                 ),
	.spi_mosi_in         (spi2_mosi_in                  ),
	.spi_mosi_oe         (spi2_mosi_oe                  ),
	.spi_mosi_out        (spi2_mosi_out                 )
);

`endif
`ifdef AE250_SPI3_SUPPORT
atcspi200 u_spi3 (
   `ifdef ATCSPI200_AHBBUS_EXIST
	.hclk                (hclk                          ),
	.hresetn             (hresetn                       ),
   `endif
   `ifdef ATCSPI200_EILMBUS_EXIST
	.eilm_addr           (                      ),
	.eilm_clk            (                      ),
	.eilm_rdata          (                      ),
	.eilm_req            (                      ),
	.eilm_resetn         (                      ),
	.eilm_wait           (                      ),
	.eilm_wait_cnt       (                      ),
	.eilm_wdata          (                      ),
	.eilm_web            (                      ),
   `endif
   `ifdef ATCSPI200_REG_APB
	.pclk                (pclk                          ),
	.presetn             (presetn                       ),
	.paddr               (paddr32                       ),
	.penable             (penable                       ),
	.prdata              (spi3_prdata                   ),
	.pready              (spi3_pready                   ),
	.psel                (spi3_psel                     ),
	.pwdata              (pwdata                        ),
	.pwrite              (pwrite                        ),
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
	.haddr_mem           ({`ATCSPI200_HADDR_WIDTH{1'b0}}),
	.hrdata_mem          (                      ),
	.hreadyin_mem        (1'b0                          ),
	.hreadyout_mem       (                      ),
	.hresp_mem           (                      ),
	.hsel_mem            (1'b0                          ),
	.htrans_mem          (2'b0                          ),
	.hwrite_mem          (1'b0                          ),
   `endif
   `ifdef ATCSPI200_REG_AHB
	.haddr_reg           (                      ),
	.hrdata_reg          (                      ),
	.hreadyin_reg        (                      ),
	.hreadyout_reg       (                      ),
	.hresp_reg           (                      ),
	.hsel_reg            (                      ),
	.htrans_reg          (                      ),
	.hwdata_reg          (                      ),
	.hwrite_reg          (                      ),
   `endif
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_default_as_slave(1'b0                          ),
	.spi_cs_n_in         (spi3_csn_in                   ),
   `endif
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi_hold_n_in       (spi3_holdn_in                 ),
	.spi_hold_n_oe       (spi3_holdn_oe                 ),
	.spi_hold_n_out      (spi3_holdn_out                ),
	.spi_wp_n_in         (spi3_wpn_in                   ),
	.spi_wp_n_oe         (spi3_wpn_oe                   ),
	.spi_wp_n_out        (spi3_wpn_out                  ),
   `endif
   `ifdef ATCSPI200_AHBBUS_EXIST
      `ifdef ATCSPI200_EILMBUS_EXIST
	.ahb2eilm_clken      (                      ),
      `endif
      `ifdef ATCSPI200_REG_APB
	.apb2ahb_clken       (apb2ahb_clken                 ),
      `endif
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
      `ifdef ATCSPI200_HSPLIT_SUPPORT
	.hmaster_mem         ({`ATCSPI200_HMASTER_BIT{1'b0}}),
	.hsplit_mem          (                      ),
      `endif
   `endif
   `ifdef ATCSPI200_REG_EILM
      `ifdef ATCSPI200_EILM_MEM_SUPPORT
	.eilm_reg_sel        (                      ),
      `endif
   `endif
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi_cs_n_in         (spi3_csn_in                   ),
      `endif
   `endif
   `ifdef ATCSPI200_AHBBUS_EXIST
   `else
      `ifdef ATCSPI200_EILMBUS_EXIST
         `ifdef ATCSPI200_REG_APB
	.apb2eilm_clken      (apb2core_clken                ),
         `endif
      `endif
   `endif
	.spi_clock           (spi_clk                       ),
	.spi_rstn            (spi_rstn                      ),
	.spi_boot_intr       (spi3_int                      ),
	.spi_default_mode3   (1'b0                          ),
	.spi_rx_dma_ack      (spi3_rx_dma_ack               ),
	.spi_rx_dma_req      (dmareq_spi3_rx                ),
	.spi_tx_dma_ack      (spi3_tx_dma_ack               ),
	.spi_tx_dma_req      (dmareq_spi3_tx                ),
	.scan_enable         (scan_enable                   ),
	.scan_test           (scan_test                     ),
	.spi_clk_in          (spi3_clk_in                   ),
	.spi_clk_oe          (spi3_clk_oe                   ),
	.spi_clk_out         (spi3_clk_out                  ),
	.spi_cs_n_oe         (spi3_csn_oe                   ),
	.spi_cs_n_out        (spi3_csn_out                  ),
	.spi_miso_in         (spi3_miso_in                  ),
	.spi_miso_oe         (spi3_miso_oe                  ),
	.spi_miso_out        (spi3_miso_out                 ),
	.spi_mosi_in         (spi3_mosi_in                  ),
	.spi_mosi_oe         (spi3_mosi_oe                  ),
	.spi_mosi_out        (spi3_mosi_out                 )
);

`endif
`ifdef AE250_SPI4_SUPPORT
atcspi200 u_spi4 (
   `ifdef ATCSPI200_AHBBUS_EXIST
	.hclk                (hclk                          ),
	.hresetn             (hresetn                       ),
   `endif
   `ifdef ATCSPI200_EILMBUS_EXIST
	.eilm_addr           (                      ),
	.eilm_clk            (                      ),
	.eilm_rdata          (                      ),
	.eilm_req            (                      ),
	.eilm_resetn         (                      ),
	.eilm_wait           (                      ),
	.eilm_wait_cnt       (                      ),
	.eilm_wdata          (                      ),
	.eilm_web            (                      ),
   `endif
   `ifdef ATCSPI200_REG_APB
	.pclk                (pclk                          ),
	.presetn             (presetn                       ),
	.paddr               (paddr32                       ),
	.penable             (penable                       ),
	.prdata              (spi4_prdata                   ),
	.pready              (spi4_pready                   ),
	.psel                (spi4_psel                     ),
	.pwdata              (pwdata                        ),
	.pwrite              (pwrite                        ),
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
	.haddr_mem           ({`ATCSPI200_HADDR_WIDTH{1'b0}}),
	.hrdata_mem          (                      ),
	.hreadyin_mem        (1'b0                          ),
	.hreadyout_mem       (                      ),
	.hresp_mem           (                      ),
	.hsel_mem            (1'b0                          ),
	.htrans_mem          (2'b0                          ),
	.hwrite_mem          (1'b0                          ),
   `endif
   `ifdef ATCSPI200_REG_AHB
	.haddr_reg           (                      ),
	.hrdata_reg          (                      ),
	.hreadyin_reg        (                      ),
	.hreadyout_reg       (                      ),
	.hresp_reg           (                      ),
	.hsel_reg            (                      ),
	.htrans_reg          (                      ),
	.hwdata_reg          (                      ),
	.hwrite_reg          (                      ),
   `endif
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_default_as_slave(1'b0                          ),
	.spi_cs_n_in         (spi4_csn_in                   ),
   `endif
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi_hold_n_in       (spi4_holdn_in                 ),
	.spi_hold_n_oe       (spi4_holdn_oe                 ),
	.spi_hold_n_out      (spi4_holdn_out                ),
	.spi_wp_n_in         (spi4_wpn_in                   ),
	.spi_wp_n_oe         (spi4_wpn_oe                   ),
	.spi_wp_n_out        (spi4_wpn_out                  ),
   `endif
   `ifdef ATCSPI200_AHBBUS_EXIST
      `ifdef ATCSPI200_EILMBUS_EXIST
	.ahb2eilm_clken      (                      ),
      `endif
      `ifdef ATCSPI200_REG_APB
	.apb2ahb_clken       (apb2ahb_clken                 ),
      `endif
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
      `ifdef ATCSPI200_HSPLIT_SUPPORT
	.hmaster_mem         ({`ATCSPI200_HMASTER_BIT{1'b0}}),
	.hsplit_mem          (                      ),
      `endif
   `endif
   `ifdef ATCSPI200_REG_EILM
      `ifdef ATCSPI200_EILM_MEM_SUPPORT
	.eilm_reg_sel        (                      ),
      `endif
   `endif
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi_cs_n_in         (spi4_csn_in                   ),
      `endif
   `endif
   `ifdef ATCSPI200_AHBBUS_EXIST
   `else
      `ifdef ATCSPI200_EILMBUS_EXIST
         `ifdef ATCSPI200_REG_APB
	.apb2eilm_clken      (apb2core_clken                ),
         `endif
      `endif
   `endif
	.spi_clock           (spi_clk                       ),
	.spi_rstn            (spi_rstn                      ),
	.spi_boot_intr       (spi4_int                      ),
	.spi_default_mode3   (1'b0                          ),
	.spi_rx_dma_ack      (spi4_rx_dma_ack               ),
	.spi_rx_dma_req      (dmareq_spi4_rx                ),
	.spi_tx_dma_ack      (spi4_tx_dma_ack               ),
	.spi_tx_dma_req      (dmareq_spi4_tx                ),
	.scan_enable         (scan_enable                   ),
	.scan_test           (scan_test                     ),
	.spi_clk_in          (spi4_clk_in                   ),
	.spi_clk_oe          (spi4_clk_oe                   ),
	.spi_clk_out         (spi4_clk_out                  ),
	.spi_cs_n_oe         (spi4_csn_oe                   ),
	.spi_cs_n_out        (spi4_csn_out                  ),
	.spi_miso_in         (spi4_miso_in                  ),
	.spi_miso_oe         (spi4_miso_oe                  ),
	.spi_miso_out        (spi4_miso_out                 ),
	.spi_mosi_in         (spi4_mosi_in                  ),
	.spi_mosi_oe         (spi4_mosi_oe                  ),
	.spi_mosi_out        (spi4_mosi_out                 )
);

`endif
ae250_smu ae250_smu (
`ifdef NDS_FPGA
	.mpd_por_b                (T_por_b                  ),
	.smu_core_clk_2_hclk_ratio(smu_core_clk_2_hclk_ratio),
	.smu_hclk_2_pclk_ratio    (smu_hclk_2_pclk_ratio    ),
`else
	.X_om                     (X_om                     ),
	.smu_core_clk_2_hclk_ratio(smu_core_clk_2_hclk_ratio),
	.smu_hclk_2_pclk_ratio    (smu_hclk_2_pclk_ratio    ),
`endif
`ifdef PLATFORM_DEBUG_PORT
	.X_tck                    (X_tck                    ),
`endif
`ifdef NDS_BOARD_CF1
	.cf1_pinmux_ctrl0         (cf1_pinmux_ctrl0         ),
	.cf1_pinmux_ctrl1         (cf1_pinmux_ctrl1         ),
`endif
	.dbg_wakeup_ack           (dbg_wakeup_ack           ),
	.smu_core_clk_en          (smu_core_clk_en          ),
	.smu_rstgen_core0_resetn  (smu_rstgen_core0_resetn  ),
	.X_aopd_por_b             (X_aopd_por_b             ),
	.X_mpd_pwr_off            (X_mpd_pwr_off            ),
	.X_osclin                 (X_osclin                 ),
	.X_osclio                 (X_osclio                 ),
	.X_rtc_wakeup             (X_rtc_wakeup             ),
	.X_wakeup_in              (X_wakeup_in              ),
	.clk_32k                  (clk_32k                  ),
	.dbg_tck                  (dbg_tck                  ),
	.mpd_iso_en               (mpd_iso_en               ),
	.rtc_alarm_wakeup         (alarm_wakeup             ),
	.rtc_rstn                 (rtc_rstn                 ),
	.test_clk                 (test_clk                 ),
	.test_mode                (test_mode                ),
	.test_rstn                (test_rstn                ),
	.wdt_rstn                 (~wdt_rst                 ),
	.mpd_por_b_psync          (por_b_psync              ),
	.core2smu_wfi_mode        (core_wfi_mode            ),
	.pwdata                   (pwdata                   ),
	.pclk                     (pclk                     ),
	.dbg_wakeup_req           (dbg_wakeup_req           ),
	.dcache_disable_init      (dcache_disable_init      ),
	.icache_disable_init      (icache_disable_init      ),
	.paddr                    (paddr[12:2]              ),
	.penable                  (penable                  ),
	.prdata                   (ps1_prdata               ),
	.psel                     (ps1_psel                 ),
	.pwrite                   (pwrite                   ),
	.reset_vector             (reset_vector             ),
	.smu_hclk_en              (smu_hclk_en              ),
	.smu_pclk_en              (smu_pclk_en              ),
	.sw_rstn                  (sw_rstn                  ),
	.presetn                  (presetn                  ),
	.T_hw_rstn                (T_hw_rstn                ),
	.T_osch                   (T_osch                   ),
	.main_rstn                (main_rstn                ),
	.smu2core_standby_req     (smu2core_standby_req     ),
	.smu2core_wakeup_ok       (smu2core_wakeup_ok       ),
	.smu_core_clk_sel         (smu_core_clk_sel         ),
	.pd_clk_off               (pd_clk_off               ),
	.pd_iso_en                (pd_iso_en                ),
	.pd_pwr_off               (pd_pwr_off               ),
	.pd_ret_en                (pd_ret_en                ),
	.pd_wakeup_event          (pd_wakeup_event          ),
	.smu_interrupt_pd         (smu_interrupt_pd         )
);

ae250_clkgen ae250_clkgen (
	.T_osch                   (T_osch                   ),
	.main_rstn                (main_rstn                ),
	.main_rstn_csync          (main_rstn_csync          ),
	.hresetn                  (hresetn                  ),
	.smu_core_clk_sel         (smu_core_clk_sel         ),
`ifdef NDS_FPGA
	.smu_core_clk_2_hclk_ratio(smu_core_clk_2_hclk_ratio),
	.smu_hclk_2_pclk_ratio    (smu_hclk_2_pclk_ratio    ),
`else
	.scan_test                (scan_test                ),
	.scan_enable              (scan_enable              ),
	.test_clk                 (test_clk                 ),
	.smu_core_clk_2_hclk_ratio(smu_core_clk_2_hclk_ratio),
	.smu_hclk_2_pclk_ratio    (smu_hclk_2_pclk_ratio    ),
`endif
	.smu_core_clk_en          (smu_core_clk_en          ),
	.smu_hclk_en              (smu_hclk_en              ),
	.smu_pclk_en              (smu_pclk_en              ),
`ifdef NDS_FPGA
	.core_clk                 (core_clk                 ),
	.hclk                     (hclk                     ),
	.pclk                     (pclk                     ),
	.uart_clk                 (uart_clk                 ),
	.spi_clk                  (spi_clk                  ),
`else
	.core_clk                 (core_clk                 ),
	.hclk                     (hclk                     ),
	.pclk                     (pclk                     ),
	.uart_clk                 (uart_clk                 ),
	.spi_clk                  (spi_clk                  ),
`endif
	.pclk_uart1               (pclk_uart1               ),
	.pclk_uart2               (pclk_uart2               ),
	.pclk_spi1                (pclk_spi1                ),
	.pclk_spi2                (pclk_spi2                ),
	.pclk_gpio                (pclk_gpio                ),
	.pclk_pit                 (pclk_pit                 ),
	.pclk_i2c                 (pclk_i2c                 ),
	.pclk_wdt                 (pclk_wdt                 ),
	.apb2ahb_clken            (apb2ahb_clken            ),
	.ahb2core_clken           (ahb2core_clken           ),
	.root_clk                 (root_clk                 ),
	.apb2core_clken           (apb2core_clken           )
);

ae250_rstgen ae250_rstgen (
	.dbg_srst_req           (dbg_srst_req           ),
	.T_osch                 (T_osch                 ),
	.uart_clk               (uart_clk               ),
	.spi_clk                (spi_clk                ),
	.pclk                   (pclk                   ),
	.hclk                   (hclk                   ),
	.core_clk               (core_clk               ),
	.root_clk               (root_clk               ),
	.T_hw_rstn              (T_hw_rstn              ),
	.sw_rstn                (sw_rstn                ),
	.wdt_rstn               (~wdt_rst               ),
	.rtc_rstn               (rtc_rstn               ),
	.test_mode              (test_mode              ),
	.test_rstn              (test_rstn              ),
	.T_por_b                (T_por_b                ),
	.init_calib_complete    (init_calib_complete    ),
	.main_rstn              (main_rstn              ),
	.main_rstn_csync        (main_rstn_csync        ),
	.uart_rstn              (uart_rstn              ),
	.spi_rstn               (spi_rstn               ),
	.presetn                (presetn                ),
	.hresetn                (hresetn                ),
	.core_resetn            (core_resetn            ),
	.smu_rstgen_core0_resetn(smu_rstgen_core0_resetn),
	.por_b_psync            (por_b_psync            ),
	.por_rstn               (por_rstn               )
);

ae250_testgen ae250_testgen (
	.scan_test  (scan_test  ),
	.scan_enable(scan_enable)
);

endmodule

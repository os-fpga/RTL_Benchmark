// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`timescale 1ns/1ps

`include "config.inc"
`include "global.inc"
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

        `define AE350_AXI_SUPPORT



	`include "atcbmc300_config.vh"
	`include "atcbmc300_const.vh"

`ifdef AE350_PIT_SUPPORT
	`include "atcpit100_config.vh"
	`include "atcpit100_const.vh"
`endif


module system (
`ifdef NDS_AXI_AWUSER_SUPPORT
	  awuser,
`endif
`ifdef NDS_AXI_ARUSER_SUPPORT
	  aruser,
`endif

   `ifdef NDS_AXI_AWREGION_SUPPORT
	  awregion,
   `endif
   `ifdef NDS_AXI_AWQOS_SUPPORT
	  awqos,
   `endif
   `ifdef NDS_AXI_WUSER_SUPPORT
	  wuser,
   `endif
   `ifdef NDS_AXI_BUSER_SUPPORT
	  buser,
   `endif
   `ifdef NDS_AXI_ARREGION_SUPPORT
	  arregion,
   `endif
   `ifdef NDS_AXI_ARQOS_SUPPORT
	  arqos,
   `endif
   `ifdef NDS_AXI_RUSER_SUPPORT
	  ruser
   `endif

);

`ifdef NDS_AE350_MULTI_HART
   `ifdef AE350_ONLY_HART0_RESETRUN
      `ifdef NDS_HART0_RUN
parameter RUN_HART_NUM = 1;
      `else
parameter RUN_HART_NUM = 2;
      `endif
   `else
parameter RUN_HART_NUM = `NDS_NHART;
   `endif
`else
parameter RUN_HART_NUM = 1;
`endif

parameter TEST_MEM_BASE = {{(65-`ATCBMC300_ADDR_WIDTH){1'h0}}, `ATCBMC300_SLV2_BASE_ADDR} + 65'h0010_0000;
`ifdef NDS_AXI_AWUSER_SUPPORT
   `ifdef NDS_AXI_AWUSER_WIDTH
parameter NDS_AXI_AWUSER_WIDTH = `NDS_AXI_AWUSER_WIDTH;
   `else
parameter NDS_AXI_AWUSER_WIDTH = 1;
   `endif
`else
parameter NDS_AXI_AWUSER_WIDTH = 0;
`endif
`ifdef NDS_AXI_ARUSER_SUPPORT
   `ifdef NDS_AXI_ARUSER_WIDTH
parameter NDS_AXI_ARUSER_WIDTH = `NDS_AXI_ARUSER_WIDTH;
   `else
parameter NDS_AXI_ARUSER_WIDTH = 1;
   `endif
`else
parameter NDS_AXI_ARUSER_WIDTH = 0;
`endif

`ifdef NDS_AXI_AWUSER_SUPPORT
input       [NDS_AXI_AWUSER_WIDTH-1:0] awuser;
`endif
`ifdef NDS_AXI_ARUSER_SUPPORT
input       [NDS_AXI_ARUSER_WIDTH-1:0] aruser;
`endif

   `ifdef NDS_AXI_AWREGION_SUPPORT
input                            [3:0] awregion;
   `endif
   `ifdef NDS_AXI_AWQOS_SUPPORT
input                            [3:0] awqos;
   `endif
   `ifdef NDS_AXI_WUSER_SUPPORT
input                           [-1:0] wuser;
   `endif
   `ifdef NDS_AXI_BUSER_SUPPORT
input                           [-1:0] buser;
   `endif
   `ifdef NDS_AXI_ARREGION_SUPPORT
input                            [3:0] arregion;
   `endif
   `ifdef NDS_AXI_ARQOS_SUPPORT
input                            [3:0] arqos;
   `endif
   `ifdef NDS_AXI_RUSER_SUPPORT
input                           [-1:0] ruser;
   `endif


`ifdef PLATFORM_DEBUG_PORT
wire                                      X_tck;
wire                                      X_tms;
`endif
`ifdef NDS_FPGA
wire                                      X_flash_dir;
`else
wire                                      X_oschio;
wire                                      X_osclio;
`endif
`ifdef AE350_UART1_SUPPORT
wire                                      X_uart1_dtrn;
wire                                      X_uart1_out1n;
wire                                      X_uart1_out2n;
wire                                      X_uart1_txd;
wire                                      X_uart1_dcdn;
wire                                      X_uart1_dsrn;
wire                                      X_uart1_rin;
wire                                      X_uart1_rxd;
`endif
`ifdef AE350_UART2_SUPPORT
wire                                      X_uart2_txd;
wire                                      X_uart2_rxd;
`endif
`ifdef AE350_PIT_SUPPORT
wire                                      X_pwm_ch0;
wire                                      X_pwm_ch1;
wire                                      X_pwm_ch2;
wire                                      X_pwm_ch3;
`endif
`ifdef AE350_I2C_SUPPORT
tri1                                      X_i2c_scl;
tri1                                      X_i2c_sda;
wire                                      smbsus;
wire                                      smbalert;
`endif

wire                                      X_aclk;
wire                                      X_aresetn;
wire          [(`NDS_BIU_ADDR_WIDTH-1):0] X_cpu_araddr;
wire                                [1:0] X_cpu_arburst;
wire                                [3:0] X_cpu_arcache;
wire          [(`ATCBMC300_ID_WIDTH-1):0] X_cpu_arid;
wire                                [7:0] X_cpu_arlen;
wire                                      X_cpu_arlock;
wire                                [2:0] X_cpu_arprot;
wire                                      X_cpu_arready;
wire                                [2:0] X_cpu_arsize;
wire                                      X_cpu_arvalid;
wire          [(`NDS_BIU_ADDR_WIDTH-1):0] X_cpu_awaddr;
wire                                [1:0] X_cpu_awburst;
wire                                [3:0] X_cpu_awcache;
wire          [(`ATCBMC300_ID_WIDTH-1):0] X_cpu_awid;
wire                                [7:0] X_cpu_awlen;
wire                                      X_cpu_awlock;
wire                                [2:0] X_cpu_awprot;
wire                                      X_cpu_awready;
wire                                [2:0] X_cpu_awsize;
wire                                      X_cpu_awvalid;
wire          [(`ATCBMC300_ID_WIDTH-1):0] X_cpu_bid;
wire                                      X_cpu_bready;
wire                                [1:0] X_cpu_bresp;
wire                                      X_cpu_bvalid;
wire          [(`NDS_BIU_DATA_WIDTH-1):0] X_cpu_rdata;
wire          [(`ATCBMC300_ID_WIDTH-1):0] X_cpu_rid;
wire                                      X_cpu_rlast;
wire                                      X_cpu_rready;
wire                                [1:0] X_cpu_rresp;
wire                                      X_cpu_rvalid;
wire          [(`NDS_BIU_DATA_WIDTH-1):0] X_cpu_wdata;
wire                                      X_cpu_wlast;
wire                                      X_cpu_wready;
wire        [(`NDS_BIU_DATA_WIDTH/8)-1:0] X_cpu_wstrb;
wire                                      X_cpu_wvalid;

`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_JTAG_TWOWIRE
   `else
wire                                      X_tdi;
wire                                      X_tdo;
wire                                      X_trst;
wire                                      X_srst;
   `endif
   `ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
wire                                [1:0] X_secure_mode;
   `endif
`endif
`ifdef AE350_UART1_SUPPORT
   `ifdef AE350_UART2_SUPPORT
   `else
wire                                      X_uart1_rtsn;
wire                                      X_uart1_ctsn;
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE350_UART2_SUPPORT
wire                                      X_uart2_dtrn;
wire                                      X_uart2_out1n;
wire                                      X_uart2_out2n;
wire                                      X_uart2_rtsn;
wire                                      X_uart2_ctsn;
wire                                      X_uart2_dcdn;
wire                                      X_uart2_dsrn;
wire                                      X_uart2_rin;
   `endif
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef NDS_SPI_SLAVE_TEST
   `else
wire                                      X_spi1_clk;
wire                                      X_spi1_csn;
wire                                      X_spi1_mosi;
   `endif
`endif
`ifdef AE350_SPI2_SUPPORT
   `ifdef NDS_SPI_SLAVE_TEST
   `else
wire                                      X_spi2_clk;
wire                                      X_spi2_csn;
wire                                      X_spi2_mosi;
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE350_RTC_SUPPORT
wire                                      X_rtc_wakeup;
   `endif
`endif
`ifdef NDS_SPI_SLAVE_TEST
`else
   `ifdef NDS_SPI_3LINE_EPD
wire                                      busy_n;
   `endif
`endif



`ifdef NDS_FPGA
`else
   `ifdef AE350_UART1_SUPPORT
      `ifdef AE350_UART2_SUPPORT
wire                                      X_uart1_rtsn;
wire                                      X_uart1_ctsn;
      `endif
   `endif
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef NDS_SPI_SLAVE_TEST
   `else
      `ifdef NDS_SPI_3LINE_EPD
      `else
wire                                      X_spi1_holdn;
wire                                      X_spi1_miso;
wire                                      X_spi1_wpn;
      `endif
   `endif
`endif
`ifdef AE350_SPI2_SUPPORT
   `ifdef NDS_SPI_SLAVE_TEST
   `else
      `ifdef NDS_SPI_3LINE_EPD
      `else
wire                                      X_spi2_holdn;
wire                                      X_spi2_miso;
wire                                      X_spi2_wpn;
      `endif
   `endif
`endif
`ifdef NDS_SPI_SLAVE_TEST
`else
   `ifdef NDS_SPI_3LINE_EPD
   `else
   `endif
`endif
wire                               [31:0] H_hs0_haddr_32b;
wire                                      X_mpd_pwr_off;
wire                                      X_aopd_por_b;
wire                                      X_hw_rstn;
wire                                      X_om;
wire                                      X_por_b;
wire                                      X_wakeup_in;
wire                               [31:0] X_gpio;
wire                                      H_hclk;
wire                 [`AE350_HADDR_MSB:0] H_hm0_haddr;
wire                                [2:0] H_hm0_hburst;
wire                                [3:0] H_hm0_hmaster;
wire                                      H_hm0_hmastlock;
wire                                [3:0] H_hm0_hprot;
wire                               [31:0] H_hm0_hrdata;
wire                                      H_hm0_hreadyi;
wire                                [1:0] H_hm0_hresp;
wire                               [31:0] H_hm0_hselx;
wire                                [2:0] H_hm0_hsize;
wire                                [1:0] H_hm0_htrans;
wire                               [31:0] H_hm0_hwdata;
wire                                      H_hm0_hwrite;
wire                                      H_hresetn;
wire                 [`AE350_HADDR_MSB:0] H_hs0_haddr;
wire                                [2:0] H_hs0_hburst;
wire                                [3:0] H_hs0_hmaster;
wire                                      H_hs0_hmastlock;
wire                                [3:0] H_hs0_hprot;
wire                               [31:0] H_hs0_hrdata;
wire                                      H_hs0_hreadyi;
wire                                [1:0] H_hs0_hresp;
wire                                      H_hs0_hsel;
wire                               [31:0] H_hs0_hselx;
wire                                [2:0] H_hs0_hsize;
wire                                [1:0] H_hs0_htrans;
wire                               [31:0] H_hs0_hwdata;
wire                                      H_hs0_hwrite;
wire                                      X_oschin;
wire                                      X_osclin;

	`ifdef AE350_ADDR_WIDTH_24
		assign H_hs0_haddr_32b = {8'b0, H_hs0_haddr};
	`else
    	assign H_hs0_haddr_32b = H_hs0_haddr;
	`endif
`ifdef HREADY_WARN_WAIT_CNT
`else
	`define HREADY_WARN_WAIT_CNT	1024
`endif
`ifdef NDS_SPI_SLAVE_TEST
	`ifdef NDS_SPI4_TEST
   wire            X_spi1_clk  ;
   wire            X_spi1_csn  ;
   wire            X_spi1_miso ;
   wire            X_spi1_mosi ;
   wire            X_spi1_wpn  ;
   wire            X_spi1_holdn;
   wire            X_spi4_clk  ;
   wire            X_spi4_csn  ;
   wire            X_spi4_miso ;
   wire            X_spi4_mosi ;
   wire            X_spi4_wpn  ;
   wire            X_spi4_holdn;
	tran		sw_spi_clk	(X_spi4_clk,   X_spi1_clk  );
	tran		sw_spi_csn	(X_spi4_csn,   X_spi1_csn  );
   tran		sw_spi_miso	(X_spi4_miso,  X_spi1_miso );
   tran		sw_spi_mosi	(X_spi4_mosi,  X_spi1_mosi );
   tran		sw_spi_wpn	(X_spi4_wpn,   X_spi1_wpn  );
   tran		sw_spi_holdn	(X_spi4_holdn, X_spi1_holdn);
	`elsif NDS_SPI3_TEST
   wire            X_spi1_clk  ;
   wire            X_spi1_csn  ;
   wire            X_spi1_miso ;
   wire            X_spi1_mosi ;
   wire            X_spi1_wpn  ;
   wire            X_spi1_holdn;
   wire            X_spi3_clk  ;
   wire            X_spi3_csn  ;
   wire            X_spi3_miso ;
   wire            X_spi3_mosi ;
   wire            X_spi3_wpn  ;
   wire            X_spi3_holdn;
	tran		sw_spi_clk	(X_spi3_clk,   X_spi1_clk  );
	tran		sw_spi_csn	(X_spi3_csn,   X_spi1_csn  );
   tran		sw_spi_miso	(X_spi3_miso,  X_spi1_miso );
   tran		sw_spi_mosi	(X_spi3_mosi,  X_spi1_mosi );
   tran		sw_spi_wpn	(X_spi3_wpn,   X_spi1_wpn  );
   tran		sw_spi_holdn	(X_spi3_holdn, X_spi1_holdn);
	`else
   wire            X_spi1_clk  ;
   wire            X_spi1_csn  ;
   wire            X_spi1_miso ;
   wire            X_spi1_mosi ;
   wire            X_spi1_wpn  ;
   wire            X_spi1_holdn;
   wire            X_spi2_clk  ;
   wire            X_spi2_csn  ;
   wire            X_spi2_miso ;
   wire            X_spi2_mosi ;
   wire            X_spi2_wpn  ;
   wire            X_spi2_holdn;
	tran		sw_spi_clk	(X_spi2_clk,   X_spi1_clk  );
	tran		sw_spi_csn	(X_spi2_csn,   X_spi1_csn  );
   tran		sw_spi_miso	(X_spi2_miso,  X_spi1_miso );
   tran		sw_spi_mosi	(X_spi2_mosi,  X_spi1_mosi );
   tran		sw_spi_wpn	(X_spi2_wpn,   X_spi1_wpn  );
   tran		sw_spi_holdn	(X_spi2_holdn, X_spi1_holdn);
   `endif
`endif
`ifdef AE350_PIT_SUPPORT
   `ifndef ATCPIT100_CH1_SUPPORT
           assign X_pwm_ch1 = 1'b0;
   `endif
   `ifndef ATCPIT100_CH2_SUPPORT
           assign X_pwm_ch2 = 1'b0;
   `endif
   `ifndef ATCPIT100_CH3_SUPPORT
           assign X_pwm_ch3 = 1'b0;
   `endif
`endif
`ifdef PLATFORM_DEBUG_PORT
	`ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
	        `ifdef PLATFORM_NCEDBGLOCK100_PASSWD_MODE
		        assign X_secure_mode = 2'b11;
	        `else
		        assign X_secure_mode = 2'b00;
	        `endif
	`endif
`endif
`ifdef PLATFORM_DEBUG_PORT
pulldown(X_tck);
`ifdef PLATFORM_JTAG_TWOWIRE
`else
pulldown(X_trst);
pullup(X_srst);
`endif
`endif

ae350_chip #(
	.SIMULATION      ("TRUE"          ),
	.SIM_BYPASS_INIT_CAL("FAST"          )
) ae350_chip (
`ifdef PLATFORM_DEBUG_PORT
	.X_tck            (X_tck            ),
	.X_tms            (X_tms            ),
`endif
`ifdef NDS_FPGA
	.X_flash_dir      (X_flash_dir      ),
`else
	.X_aopd_por_b     (X_aopd_por_b     ),
	.X_mpd_pwr_off    (X_mpd_pwr_off    ),
	.X_om             (X_om             ),
	.X_osclio         (X_osclio         ),
	.X_oschio         (X_oschio         ),
`endif
`ifdef AE350_UART1_SUPPORT
	.X_uart1_dcdn     (X_uart1_dcdn     ),
	.X_uart1_dsrn     (X_uart1_dsrn     ),
	.X_uart1_dtrn     (X_uart1_dtrn     ),
	.X_uart1_out1n    (X_uart1_out1n    ),
	.X_uart1_out2n    (X_uart1_out2n    ),
	.X_uart1_rin      (X_uart1_rin      ),
	.X_uart1_rxd      (X_uart1_rxd      ),
	.X_uart1_txd      (X_uart1_txd      ),
`endif
`ifdef AE350_UART2_SUPPORT
	.X_uart2_rxd      (X_uart2_rxd      ),
	.X_uart2_txd      (X_uart2_txd      ),
`endif
`ifdef AE350_PIT_SUPPORT
	.X_pwm_ch0        (X_pwm_ch0        ),
`endif
`ifdef AE350_GPIO_SUPPORT
	.X_gpio           (X_gpio           ),
`endif
`ifdef AE350_I2C_SUPPORT
	.X_i2c_scl        (X_i2c_scl        ),
	.X_i2c_sda        (X_i2c_sda        ),
`endif
`ifdef AE350_SPI1_SUPPORT
	.X_spi1_clk       (X_spi1_clk       ),
	.X_spi1_csn       (X_spi1_csn       ),
	.X_spi1_miso      (X_spi1_miso      ),
	.X_spi1_mosi      (X_spi1_mosi      ),
`endif
`ifdef AE350_SPI2_SUPPORT
	.X_spi2_clk       (X_spi2_clk       ),
	.X_spi2_csn       (X_spi2_csn       ),
	.X_spi2_miso      (X_spi2_miso      ),
	.X_spi2_mosi      (X_spi2_mosi      ),
`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_JTAG_TWOWIRE
   `else
	.X_tdi            (X_tdi            ),
	.X_tdo            (X_tdo            ),
	.X_trst           (X_trst           ),
   `endif
   `ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
	.X_secure_mode    (X_secure_mode    ),
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE350_RTC_SUPPORT
	.X_rtc_wakeup     (X_rtc_wakeup     ),
   `endif
`endif
`ifdef AE350_UART1_SUPPORT
   `ifdef AE350_UART2_SUPPORT
   `else
	.X_uart1_ctsn     (X_uart1_ctsn     ),
	.X_uart1_rtsn     (X_uart1_rtsn     ),
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE350_UART2_SUPPORT
	.X_uart2_ctsn     (X_uart2_ctsn     ),
	.X_uart2_dcdn     (X_uart2_dcdn     ),
	.X_uart2_dsrn     (X_uart2_dsrn     ),
	.X_uart2_dtrn     (X_uart2_dtrn     ),
	.X_uart2_out1n    (X_uart2_out1n    ),
	.X_uart2_out2n    (X_uart2_out2n    ),
	.X_uart2_rin      (X_uart2_rin      ),
	.X_uart2_rtsn     (X_uart2_rtsn     ),
   `endif
`endif
`ifdef AE350_PIT_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
	.X_pwm_ch1        (X_pwm_ch1        ),
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
	.X_pwm_ch2        (X_pwm_ch2        ),
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
	.X_pwm_ch3        (X_pwm_ch3        ),
   `endif
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.X_spi1_holdn     (X_spi1_holdn     ),
	.X_spi1_wpn       (X_spi1_wpn       ),
   `endif
`endif
`ifdef AE350_SPI2_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.X_spi2_holdn     (X_spi2_holdn     ),
	.X_spi2_wpn       (X_spi2_wpn       ),
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE350_UART1_SUPPORT
      `ifdef AE350_UART2_SUPPORT
	.X_uart1_ctsn     (X_uart1_ctsn     ),
	.X_uart1_rtsn     (X_uart1_rtsn     ),
      `endif
   `endif
`endif

   `ifdef NDS_FPGA

   `else

   `endif

	.X_osclin         (X_osclin         ),
	.X_wakeup_in      (X_wakeup_in      ),
	.X_hw_rstn        (X_hw_rstn        ),
	.X_oschin         (X_oschin         ),
	.X_por_b          (X_por_b          )
);

ae350_tb ae350_tb (

	.X_cpu_araddr    (X_cpu_araddr    ),
	.X_cpu_arburst   (X_cpu_arburst   ),
	.X_cpu_arcache   (X_cpu_arcache   ),
	.X_cpu_arid      (X_cpu_arid      ),
	.X_cpu_arlen     (X_cpu_arlen     ),
	.X_cpu_arlock    (X_cpu_arlock    ),
	.X_cpu_arprot    (X_cpu_arprot    ),
	.X_cpu_arready   (X_cpu_arready   ),
	.X_cpu_arsize    (X_cpu_arsize    ),
	.X_cpu_arvalid   (X_cpu_arvalid   ),
	.X_cpu_awaddr    (X_cpu_awaddr    ),
	.X_cpu_awburst   (X_cpu_awburst   ),
	.X_cpu_awcache   (X_cpu_awcache   ),
	.X_cpu_awid      (X_cpu_awid      ),
	.X_cpu_awlen     (X_cpu_awlen     ),
	.X_cpu_awlock    (X_cpu_awlock    ),
	.X_cpu_awprot    (X_cpu_awprot    ),
	.X_cpu_awready   (X_cpu_awready   ),
	.X_cpu_awsize    (X_cpu_awsize    ),
	.X_cpu_awvalid   (X_cpu_awvalid   ),
	.X_cpu_bid       (X_cpu_bid       ),
	.X_cpu_bready    (X_cpu_bready    ),
	.X_cpu_bresp     (X_cpu_bresp     ),
	.X_cpu_bvalid    (X_cpu_bvalid    ),
	.X_cpu_rdata     (X_cpu_rdata     ),
	.X_cpu_rid       (X_cpu_rid       ),
	.X_cpu_rlast     (X_cpu_rlast     ),
	.X_cpu_rready    (X_cpu_rready    ),
	.X_cpu_rresp     (X_cpu_rresp     ),
	.X_cpu_rvalid    (X_cpu_rvalid    ),
	.X_cpu_wdata     (X_cpu_wdata     ),
	.X_cpu_wlast     (X_cpu_wlast     ),
	.X_cpu_wready    (X_cpu_wready    ),
	.X_cpu_wstrb     (X_cpu_wstrb     ),
	.X_cpu_wvalid    (X_cpu_wvalid    ),
	.X_aclk          (X_aclk          ),
	.X_aresetn       (X_aresetn       ),

	.H_hclk          (H_hclk          ),
	.H_hresetn       (H_hresetn       ),
	.H_hm0_haddr     (H_hm0_haddr     ),
	.H_hm0_htrans    (H_hm0_htrans    ),
	.H_hm0_hwrite    (H_hm0_hwrite    ),
	.H_hm0_hsize     (H_hm0_hsize     ),
	.H_hm0_hburst    (H_hm0_hburst    ),
	.H_hm0_hprot     (H_hm0_hprot     ),
	.H_hm0_hwdata    (H_hm0_hwdata    ),
	.H_hm0_hreadyi   (H_hm0_hreadyi   ),
	.H_hm0_hmaster   (H_hm0_hmaster   ),
	.H_hm0_hmastlock (H_hm0_hmastlock ),
	.H_hm0_hrdata    (H_hm0_hrdata    ),
	.H_hm0_hresp     (H_hm0_hresp     ),
	.H_hm0_hselx     (H_hm0_hselx     ),
	.H_hs0_haddr     (H_hs0_haddr     ),
	.H_hs0_htrans    (H_hs0_htrans    ),
	.H_hs0_hwrite    (H_hs0_hwrite    ),
	.H_hs0_hsize     (H_hs0_hsize     ),
	.H_hs0_hburst    (H_hs0_hburst    ),
	.H_hs0_hprot     (H_hs0_hprot     ),
	.H_hs0_hwdata    (H_hs0_hwdata    ),
	.H_hs0_hreadyi   (H_hs0_hreadyi   ),
	.H_hs0_hmaster   (H_hs0_hmaster   ),
	.H_hs0_hmastlock (H_hs0_hmastlock ),
	.H_hs0_hrdata    (H_hs0_hrdata    ),
	.H_hs0_hresp     (H_hs0_hresp     ),
	.H_hs0_hsel      (H_hs0_hsel      ),
	.H_hs0_hselx     (H_hs0_hselx     ),
`ifdef AE350_UART1_SUPPORT
	.X_uart1_rxd     (X_uart1_rxd     ),
	.X_uart1_txd     (X_uart1_txd     ),
	.X_uart1_dcdn    (X_uart1_dcdn    ),
	.X_uart1_dsrn    (X_uart1_dsrn    ),
	.X_uart1_rin     (X_uart1_rin     ),
	.X_uart1_dtrn    (X_uart1_dtrn    ),
	.X_uart1_out1n   (X_uart1_out1n   ),
	.X_uart1_out2n   (X_uart1_out2n   ),
   `ifdef NDS_FPGA
   `else
      `ifdef AE350_UART2_SUPPORT
	.X_uart1_ctsn    (X_uart1_ctsn    ),
	.X_uart1_rtsn    (X_uart1_rtsn    ),
      `endif
   `endif
   `ifdef AE350_UART2_SUPPORT
   `else
	.X_uart1_ctsn    (X_uart1_ctsn    ),
	.X_uart1_rtsn    (X_uart1_rtsn    ),
   `endif
`endif
`ifdef AE350_UART2_SUPPORT
	.X_uart2_rxd     (X_uart2_rxd     ),
	.X_uart2_txd     (X_uart2_txd     ),
   `ifdef NDS_FPGA
   `else
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
	.X_om            (X_om            ),
	.X_hw_rstn       (X_hw_rstn       ),
	.X_aopd_por_b    (X_aopd_por_b    ),
	.X_por_b         (X_por_b         ),
	.X_oschin        (X_oschin        ),
	.X_osclin        (X_osclin        ),
	.X_wakeup_in     (X_wakeup_in     ),
	.X_mpd_pwr_off   (X_mpd_pwr_off   )
);

platform_dump platform_dump (
);







axi_monitor #(
	.ADDR_WIDTH      (`NDS_BIU_ADDR_WIDTH),
	.ARUSER_WIDTH    (NDS_AXI_ARUSER_WIDTH),
	.AWUSER_WIDTH    (NDS_AXI_AWUSER_WIDTH),
	.AXI4            (1               ),
	.DATA_WIDTH      ($clog2(`NDS_BIU_DATA_WIDTH/8)),
	.ID_WIDTH        (`ATCBMC300_ID_WIDTH),
	.MASTER_ID       (10              ),
	.WAIT_ARREADY    (150             ),
	.WAIT_AWREADY    (150             ),
	.WAIT_READ_DATA_LIMIT(300             ),
	.WAIT_RREADY     (150             ),
	.WAIT_WREADY     (150             )
) axi_monitor (
	.aclk    (X_aclk                     ),
	.aresetn (X_aresetn                  ),
	.awid    (X_cpu_awid                 ),
	.awaddr  (X_cpu_awaddr               ),
	.awlen   (X_cpu_awlen                ),
	.awsize  (X_cpu_awsize               ),
	.awburst (X_cpu_awburst              ),
	.awlock  ({1'b0,X_cpu_awlock}        ),
	.awcache (X_cpu_awcache              ),
	.awprot  (X_cpu_awprot               ),
	.awvalid (X_cpu_awvalid              ),
	.awready (X_cpu_awready              ),
   `ifdef NDS_AXI_AWREGION_SUPPORT
	.awregion(awregion                   ),
   `endif
   `ifdef NDS_AXI_AWQOS_SUPPORT
	.awqos   (awqos                      ),
   `endif
   `ifdef NDS_AXI_AWUSER_SUPPORT
	.awuser  (awuser                     ),
   `endif
	.wid     ({`ATCBMC300_ID_WIDTH{1'b0}}),
	.wdata   (X_cpu_wdata                ),
	.wstrb   (X_cpu_wstrb                ),
	.wlast   (X_cpu_wlast                ),
	.wvalid  (X_cpu_wvalid               ),
	.wready  (X_cpu_wready               ),
   `ifdef NDS_AXI_WUSER_SUPPORT
	.wuser   (wuser                      ),
   `endif
	.bid     (X_cpu_bid                  ),
	.bresp   (X_cpu_bresp                ),
	.bvalid  (X_cpu_bvalid               ),
	.bready  (X_cpu_bready               ),
   `ifdef NDS_AXI_BUSER_SUPPORT
	.buser   (buser                      ),
   `endif
	.arid    (X_cpu_arid                 ),
	.araddr  (X_cpu_araddr               ),
	.arlen   (X_cpu_arlen                ),
	.arsize  (X_cpu_arsize               ),
	.arburst (X_cpu_arburst              ),
	.arlock  ({1'b0,X_cpu_arlock}        ),
	.arcache (X_cpu_arcache              ),
	.arprot  (X_cpu_arprot               ),
	.arvalid (X_cpu_arvalid              ),
	.arready (X_cpu_arready              ),
   `ifdef NDS_AXI_ARREGION_SUPPORT
	.arregion(arregion                   ),
   `endif
   `ifdef NDS_AXI_ARQOS_SUPPORT
	.arqos   (arqos                      ),
   `endif
   `ifdef NDS_AXI_ARUSER_SUPPORT
	.aruser  (aruser                     ),
   `endif
	.rid     (X_cpu_rid                  ),
	.rdata   (X_cpu_rdata                ),
	.rresp   (X_cpu_rresp                ),
	.rlast   (X_cpu_rlast                ),
	.rvalid  (X_cpu_rvalid               ),
   `ifdef NDS_AXI_RUSER_SUPPORT
	.ruser   (ruser                      ),
   `endif
	.rready  (X_cpu_rready               )
);


ahb_sim_control #(
	.BASE            (20'h80000       ),
	.HMASTER_START   (4'd0            ),
	.RUN_HART_NUM    (RUN_HART_NUM    )
) sim_control (
	.hclk   (H_hclk         ),
	.hresetn(H_hresetn      ),
	.haddr  (H_hs0_haddr_32b),
	.htrans (H_hs0_htrans   ),
	.hwrite (H_hs0_hwrite   ),
	.hsize  (H_hs0_hsize    ),
	.hburst (H_hs0_hburst   ),
	.hprot  (H_hs0_hprot    ),
	.hwdata (H_hs0_hwdata   ),
	.hreadyi(H_hs0_hreadyi  ),
	.hsel   (H_hs0_hsel     ),
	.hmaster(H_hs0_hmaster  ),
	.hrdata (       ),
	.hresp  (       ),
	.hready (       ),
	.hsplit (       )
);

ahb_monitor #(
	.ADDR_WIDTH      (`AE350_HADDR_MSB+1),
	.HREADY_WARN_WAIT_CNT(`HREADY_WARN_WAIT_CNT),
	.ID              (0               )
) ahb_monitor_mst0 (
	.hclk       (H_hclk         ),
	.hresetn    (H_hresetn      ),
	.hmaster    (H_hm0_hmaster  ),
	.hmastlock  (H_hm0_hmastlock),
	.hselx      (H_hm0_hselx    ),
	.haddr      (H_hm0_haddr    ),
	.htrans     (H_hm0_htrans   ),
	.hwrite     (H_hm0_hwrite   ),
	.hsize      (H_hm0_hsize    ),
	.hburst     (H_hm0_hburst   ),
	.hprot      (H_hm0_hprot    ),
	.hwdata     (H_hm0_hwdata   ),
	.hrdata     (H_hm0_hrdata   ),
	.hready     (H_hm0_hreadyi  ),
	.hresp      (H_hm0_hresp    ),
	.hllsc_req  (1'b0           ),
	.hllsc_error(1'b0           ),
	.hm0_hbusreq(1'b0           ),
	.hm0_hlock  (1'b0           ),
	.hm1_hbusreq(1'b0           ),
	.hm1_hlock  (1'b0           ),
	.hm2_hbusreq(1'b0           ),
	.hm2_hlock  (1'b0           ),
	.hm3_hbusreq(1'b0           ),
	.hm3_hlock  (1'b0           )
);

ahb_monitor #(
	.ADDR_WIDTH      (`AE350_HADDR_MSB+1),
	.HREADY_WARN_WAIT_CNT(`HREADY_WARN_WAIT_CNT),
	.ID              (0               )
) ahb_monitor_slv0 (
	.hclk       (H_hclk         ),
	.hresetn    (H_hresetn      ),
	.hmaster    (H_hs0_hmaster  ),
	.hmastlock  (H_hs0_hmastlock),
	.hselx      (H_hs0_hselx    ),
	.haddr      (H_hs0_haddr    ),
	.htrans     (H_hs0_htrans   ),
	.hwrite     (H_hs0_hwrite   ),
	.hsize      (H_hs0_hsize    ),
	.hburst     (H_hs0_hburst   ),
	.hprot      (H_hs0_hprot    ),
	.hwdata     (H_hs0_hwdata   ),
	.hrdata     (H_hs0_hrdata   ),
	.hready     (H_hs0_hreadyi  ),
	.hresp      (H_hs0_hresp    ),
	.hllsc_req  (1'b0           ),
	.hllsc_error(1'b0           ),
	.hm0_hbusreq(1'b0           ),
	.hm0_hlock  (1'b0           ),
	.hm1_hbusreq(1'b0           ),
	.hm1_hlock  (1'b0           ),
	.hm2_hbusreq(1'b0           ),
	.hm2_hlock  (1'b0           ),
	.hm3_hbusreq(1'b0           ),
	.hm3_hlock  (1'b0           )
);

`ifdef AE350_SPI1_SUPPORT
   `ifdef NDS_SPI_SLAVE_TEST
   `else
      `ifdef NDS_SPI_3LINE_EPD
A020AE01 epd_model1 (
	.rst_n (X_por_b    ),
	.busy_n(busy_n     ),
	.csb   (X_spi1_csn ),
	.scl   (X_spi1_clk ),
	.sda   (X_spi1_mosi)
);

      `endif
   `endif
`endif
`ifdef AE350_SPI2_SUPPORT
   `ifdef NDS_SPI_SLAVE_TEST
   `else
      `ifdef NDS_SPI_3LINE_EPD
A020AE01 epd_model2 (
	.rst_n (X_por_b    ),
	.busy_n(busy_n     ),
	.csb   (X_spi2_csn ),
	.scl   (X_spi2_clk ),
	.sda   (X_spi2_mosi)
);

      `endif
   `endif
`endif
`ifdef NDS_SPI_SLAVE_TEST
`else
   `ifdef NDS_SPI_3LINE_EPD


   `else
      `ifdef AE350_SPI1_SUPPORT
         `ifdef NDS_SPI_FLASH_MODEL
spi_flash_model spi_flash1 (
	.X_resetn(X_por_b     ),
	.X_clk   (X_spi1_clk  ),
	.X_csn   (X_spi1_csn  ),
	.X_si    (X_spi1_mosi ),
	.X_so    (X_spi1_miso ),
	.X_wpn   (X_spi1_wpn  ),
	.X_holdn (X_spi1_holdn)
);

         `endif
      `endif
      `ifdef AE350_SPI2_SUPPORT
         `ifdef NDS_SPI_FLASH_MODEL
spi_flash_model spi_flash2 (
	.X_resetn(X_por_b     ),
	.X_clk   (X_spi2_clk  ),
	.X_csn   (X_spi2_csn  ),
	.X_si    (X_spi2_mosi ),
	.X_so    (X_spi2_miso ),
	.X_wpn   (X_spi2_wpn  ),
	.X_holdn (X_spi2_holdn)
);

         `endif
      `endif


      `ifdef AE350_SPI1_SUPPORT
         `ifdef NDS_SPI_FLASH_MODEL
         `else
spi_flash spi_flash1 (
	.SCLK (X_spi1_clk  ),
	.CS   (X_spi1_csn  ),
	.RESET(X_por_b     ),
	.SI   (X_spi1_mosi ),
	.SO   (X_spi1_miso ),
	.WP   (X_spi1_wpn  ),
	.SIO3 (X_spi1_holdn)
);

         `endif
      `endif
      `ifdef AE350_SPI2_SUPPORT
         `ifdef NDS_SPI_FLASH_MODEL
         `else
spi_flash spi_flash2 (
	.SCLK (X_spi2_clk  ),
	.CS   (X_spi2_csn  ),
	.RESET(X_por_b     ),
	.SI   (X_spi2_mosi ),
	.SO   (X_spi2_miso ),
	.WP   (X_spi2_wpn  ),
	.SIO3 (X_spi2_holdn)
);

         `endif
      `endif


   `endif
`endif

`ifdef AE350_I2C_SUPPORT
i2c_slave_model i2c_slave (
	.scl     (X_i2c_scl),
	.sda     (X_i2c_sda),
	.smbsus  (smbsus   ),
	.smbalert(smbalert ),
	.resetn  (X_por_b  )
);

i2c_master_model #(
	.DEFAULT_CLK_PERIOD(2000            )
) i2c_master (
	.scl     (X_i2c_scl),
	.sda     (X_i2c_sda),
	.smbsus  (smbsus   ),
	.smbalert(smbalert )
);

`endif
gpio gpio_slv (
	.gpio(X_gpio)
);




`ifdef AE350_PIT_SUPPORT
pwm_model pwm_model (
	.pwm({X_pwm_ch3,X_pwm_ch2,X_pwm_ch1,X_pwm_ch0})
);

`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_JTAG_TWOWIRE
ext_debugger #(
	.DEBUG_INTERFACE ("serial"        ),
	.TEST_MEM_BASE   (TEST_MEM_BASE[63:0])
) ext_debugger (
	.X_tckc(X_tck   ),
	.X_tmsc(X_tms   ),
	.X_trst(),
	.X_tck (),
	.X_tms (),
	.X_tdi (),
	.X_tdo (),
	.X_srst()
);

   `else
ext_debugger #(
	.DEBUG_INTERFACE ("jtag"          ),
	.TEST_MEM_BASE   (TEST_MEM_BASE[63:0])
) ext_debugger (
	.X_tckc(),
	.X_tmsc(),
	.X_trst(X_trst  ),
	.X_tck (X_tck   ),
	.X_tms (X_tms   ),
	.X_tdi (X_tdi   ),
	.X_tdo (X_tdo   ),
	.X_srst(X_srst  )
);

   `endif
`endif
endmodule

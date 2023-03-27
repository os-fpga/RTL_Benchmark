// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "config.inc"
`include "global.inc"

`include "ae350_config.vh"
`include "ae350_const.vh"
`include "atcgpio100_config.vh"
`include "atcgpio100_const.vh"
`include "atcpit100_config.vh"
`include "atcpit100_const.vh"
`include "atcwdt200_config.vh"
`include "atcwdt200_const.vh"
`include "atcapbbrg100_config.vh"
`include "atcapbbrg100_const.vh"


`ifdef AE350_UART1_SUPPORT
`define AE350_UART_SUPPORT
`endif
`ifdef AE350_UART2_SUPPORT
`define AE350_UART_SUPPORT
`endif
`ifdef AE350_UART_SUPPORT
`include "atcuart100_config.vh"
`include "atcuart100_const.vh"
`undef AE350_UART_SUPPORT
`endif

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

`ifdef AE350_DMA_SUPPORT

	`define AE350_DMA_AXI_SUPPORT
	`include "atcdmac300_config.vh"
	`include "atcdmac300_const.vh"

`endif



module ae350_apb_subsystem (
`ifdef AE350_RTC_SUPPORT
	  rtc_prdata,
	  rtc_pready,
	  rtc_psel,
	  rtc_pslverr,
`endif
`ifdef AE350_UART1_SUPPORT
	  pclk_uart1,
	  uart1_ctsn,
	  uart1_dcdn,
	  uart1_dsrn,
	  uart1_dtrn,
	  uart1_out1n,
	  uart1_out2n,
	  uart1_rin,
	  uart1_rtsn,
	  uart1_rxd,
	  uart1_txd,
`endif
`ifdef AE350_UART2_SUPPORT
	  pclk_uart2,
	  uart2_ctsn,
	  uart2_dcdn,
	  uart2_dsrn,
	  uart2_dtrn,
	  uart2_out1n,
	  uart2_out2n,
	  uart2_rin,
	  uart2_rtsn,
	  uart2_rxd,
	  uart2_txd,
`endif
`ifdef AE350_PIT_SUPPORT
	  ch0_pwm,
	  ch0_pwmoe,
	  pclk_pit,
`endif
`ifdef AE350_WDT_SUPPORT
	  pclk_wdt,
`endif
`ifdef AE350_GPIO_SUPPORT
	  gpio_in,
	  gpio_oe,
	  gpio_out,
	  pclk_gpio,
`endif
`ifdef AE350_I2C_SUPPORT
	  i2c_scl,
	  i2c_scl_in,
	  i2c_sda,
	  i2c_sda_in,
	  pclk_i2c,
`endif
`ifdef AE350_SPI1_SUPPORT
	  spi1_clk_in,
	  spi1_clk_oe,
	  spi1_clk_out,
	  spi1_csn_oe,
	  spi1_csn_out,
	  spi1_miso_in,
	  spi1_miso_oe,
	  spi1_miso_out,
	  spi1_mosi_in,
	  spi1_mosi_oe,
	  spi1_mosi_out,
`endif
`ifdef AE350_SPI2_SUPPORT
	  spi2_clk_in,
	  spi2_clk_oe,
	  spi2_clk_out,
	  spi2_csn_oe,
	  spi2_csn_out,
	  spi2_miso_in,
	  spi2_miso_oe,
	  spi2_miso_out,
	  spi2_mosi_in,
	  spi2_mosi_oe,
	  spi2_mosi_out,
`endif
`ifdef AE350_DMA_AXI_SUPPORT
	  dmac0_arid,
	  dmac0_awid,
	  dmac0_bid,
	  dmac0_rid,
	  aclk,
	  aresetn,
	  dmac0_araddr,
	  dmac0_arburst,
	  dmac0_arcache,
	  dmac0_arlen,
	  dmac0_arlock,
	  dmac0_arprot,
	  dmac0_arready,
	  dmac0_arsize,
	  dmac0_arvalid,
	  dmac0_awaddr,
	  dmac0_awburst,
	  dmac0_awcache,
	  dmac0_awlen,
	  dmac0_awlock,
	  dmac0_awprot,
	  dmac0_awready,
	  dmac0_awsize,
	  dmac0_awvalid,
	  dmac0_bready,
	  dmac0_bresp,
	  dmac0_bvalid,
	  dmac0_rdata,
	  dmac0_rlast,
	  dmac0_rready,
	  dmac0_rresp,
	  dmac0_rvalid,
	  dmac0_wdata,
	  dmac0_wlast,
	  dmac0_wready,
	  dmac0_wstrb,
	  dmac0_wvalid,
`endif
`ifdef AE350_PIT_SUPPORT
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
`endif
`ifdef AE350_GPIO_SUPPORT
   `ifdef ATCGPIO100_PULL_SUPPORT
	  gpio_pulldown,
	  gpio_pullup,
   `endif
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_REG_APB
	  pclk_spi1,
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
	  spi_mem_haddr,
	  spi_mem_hrdata,
	  spi_mem_hready,
	  spi_mem_hreadyout,
	  spi_mem_hresp,
	  spi_mem_hsel,
	  spi_mem_htrans,
	  spi_mem_hwrite,
   `endif
   `ifdef ATCSPI200_SLAVE_SUPPORT
	  spi1_csn_in,
   `endif
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  spi1_holdn_in,
	  spi1_holdn_oe,
	  spi1_holdn_out,
	  spi1_wpn_in,
	  spi1_wpn_oe,
	  spi1_wpn_out,
   `endif
`endif
`ifdef ATCSPI200_REG_APB
   `ifdef AE350_SPI2_SUPPORT
	  pclk_spi2,
   `endif
`endif
`ifdef ATCSPI200_SLAVE_SUPPORT
   `ifdef AE350_SPI2_SUPPORT
	  spi2_csn_in,
   `endif
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE350_SPI2_SUPPORT
	  spi2_holdn_in,
	  spi2_holdn_oe,
	  spi2_holdn_out,
	  spi2_wpn_in,
	  spi2_wpn_oe,
	  spi2_wpn_out,
   `endif
`endif
`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	  dmac1_arid,
	  dmac1_awid,
	  dmac1_bid,
	  dmac1_rid,
	  dmac1_araddr,
	  dmac1_arburst,
	  dmac1_arcache,
	  dmac1_arlen,
	  dmac1_arlock,
	  dmac1_arprot,
	  dmac1_arready,
	  dmac1_arsize,
	  dmac1_arvalid,
	  dmac1_awaddr,
	  dmac1_awburst,
	  dmac1_awcache,
	  dmac1_awlen,
	  dmac1_awlock,
	  dmac1_awprot,
	  dmac1_awready,
	  dmac1_awsize,
	  dmac1_awvalid,
	  dmac1_bready,
	  dmac1_bresp,
	  dmac1_bvalid,
	  dmac1_rdata,
	  dmac1_rlast,
	  dmac1_rready,
	  dmac1_rresp,
	  dmac1_rvalid,
	  dmac1_wdata,
	  dmac1_wlast,
	  dmac1_wready,
	  dmac1_wstrb,
	  dmac1_wvalid,
   `endif
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	  spi1_csn_in,
      `endif
   `endif
`endif
`ifdef ATCSPI200_AHBBUS_EXIST
`else
   `ifdef ATCSPI200_EILMBUS_EXIST
      `ifdef ATCSPI200_REG_APB
	  apb2core_clken,
      `endif
   `endif
`endif
`ifdef ATCSPI200_SLAVE_SUPPORT
`else
   `ifdef ATCSPI200_DIRECT_IO_SUPPORT
      `ifdef AE350_SPI2_SUPPORT
	  spi2_csn_in,
      `endif
   `endif
`endif
	  ahb2apb_haddr,
	  ahb2apb_hprot,
	  ahb2apb_hrdata,
	  ahb2apb_hready,
	  ahb2apb_hready_in,
	  ahb2apb_hresp,
	  ahb2apb_hsel,
	  ahb2apb_hsize,
	  ahb2apb_htrans,
	  ahb2apb_hwdata,
	  ahb2apb_hwrite,
	  paddr,
	  penable,
	  pwdata,
	  pwrite,
	  smu_prdata,
	  smu_pready,
	  smu_psel,
	  smu_pslverr,
	  pclk,
	  presetn,
	  apb2ahb_clken,
	  hclk,
	  hresetn,
	  dma_int,
	  gpio_intr,
	  extclk,
	  i2c_int,
	  pit_intr,
	  sdc_int,
	  spi1_int,
	  scan_enable,
	  scan_test,
	  spi_clk,
	  spi_rstn,
	  spi2_int,
	  ssp_intr,
	  uart1_int,
	  uart_clk,
	  uart_rstn,
	  uart2_int,
	  wdt_int,
	  wdt_rst
);

parameter BUS_MASTER_ADDR_WIDTH	= 32;
parameter BIU_DATA_WIDTH		= 32;
parameter DMAC_DATA_WIDTH		= 64;
parameter AXI_ID_WIDTH = 4;

localparam BUS_MASTER_ADDR_MSB	= BUS_MASTER_ADDR_WIDTH-1;
`ifdef ATCAPBBRG100_SLV_14
   `ifdef AE350_DTROM_SIZE_KB
localparam DTROM_SIZE_KB = `AE350_DTROM_SIZE_KB;
   `else
localparam DTROM_SIZE_KB = 8;
   `endif
`endif

`ifdef AE350_RTC_SUPPORT
input                               [31:0] rtc_prdata;
input                                      rtc_pready;
output                                     rtc_psel;
input                                      rtc_pslverr;
`endif
`ifdef AE350_UART1_SUPPORT
input                                      pclk_uart1;
input                                      uart1_ctsn;
input                                      uart1_dcdn;
input                                      uart1_dsrn;
output                                     uart1_dtrn;
output                                     uart1_out1n;
output                                     uart1_out2n;
input                                      uart1_rin;
output                                     uart1_rtsn;
input                                      uart1_rxd;
output                                     uart1_txd;
`endif
`ifdef AE350_UART2_SUPPORT
input                                      pclk_uart2;
input                                      uart2_ctsn;
input                                      uart2_dcdn;
input                                      uart2_dsrn;
output                                     uart2_dtrn;
output                                     uart2_out1n;
output                                     uart2_out2n;
input                                      uart2_rin;
output                                     uart2_rtsn;
input                                      uart2_rxd;
output                                     uart2_txd;
`endif
`ifdef AE350_PIT_SUPPORT
output                                     ch0_pwm;
output                                     ch0_pwmoe;
input                                      pclk_pit;
`endif
`ifdef AE350_WDT_SUPPORT
input                                      pclk_wdt;
`endif
`ifdef AE350_GPIO_SUPPORT
input       [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_in;
output      [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_oe;
output      [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_out;
input                                      pclk_gpio;
`endif
`ifdef AE350_I2C_SUPPORT
output                                     i2c_scl;
input                                      i2c_scl_in;
output                                     i2c_sda;
input                                      i2c_sda_in;
input                                      pclk_i2c;
`endif
`ifdef AE350_SPI1_SUPPORT
input                                      spi1_clk_in;
output                                     spi1_clk_oe;
output                                     spi1_clk_out;
output                                     spi1_csn_oe;
output                                     spi1_csn_out;
input                                      spi1_miso_in;
output                                     spi1_miso_oe;
output                                     spi1_miso_out;
input                                      spi1_mosi_in;
output                                     spi1_mosi_oe;
output                                     spi1_mosi_out;
`endif
`ifdef AE350_SPI2_SUPPORT
input                                      spi2_clk_in;
output                                     spi2_clk_oe;
output                                     spi2_clk_out;
output                                     spi2_csn_oe;
output                                     spi2_csn_out;
input                                      spi2_miso_in;
output                                     spi2_miso_oe;
output                                     spi2_miso_out;
input                                      spi2_mosi_in;
output                                     spi2_mosi_oe;
output                                     spi2_mosi_out;
`endif
`ifdef AE350_DMA_AXI_SUPPORT
output                [(AXI_ID_WIDTH-1):0] dmac0_arid;
output                [(AXI_ID_WIDTH-1):0] dmac0_awid;
input                 [(AXI_ID_WIDTH-1):0] dmac0_bid;
input                 [(AXI_ID_WIDTH-1):0] dmac0_rid;
input                                      aclk;
input                                      aresetn;
output             [BUS_MASTER_ADDR_MSB:0] dmac0_araddr;
output                               [1:0] dmac0_arburst;
output                               [3:0] dmac0_arcache;
output                               [7:0] dmac0_arlen;
output                                     dmac0_arlock;
output                               [2:0] dmac0_arprot;
input                                      dmac0_arready;
output                               [2:0] dmac0_arsize;
output                                     dmac0_arvalid;
output             [BUS_MASTER_ADDR_MSB:0] dmac0_awaddr;
output                               [1:0] dmac0_awburst;
output                               [3:0] dmac0_awcache;
output                               [7:0] dmac0_awlen;
output                                     dmac0_awlock;
output                               [2:0] dmac0_awprot;
input                                      dmac0_awready;
output                               [2:0] dmac0_awsize;
output                                     dmac0_awvalid;
output                                     dmac0_bready;
input                                [1:0] dmac0_bresp;
input                                      dmac0_bvalid;
input              [(DMAC_DATA_WIDTH-1):0] dmac0_rdata;
input                                      dmac0_rlast;
output                                     dmac0_rready;
input                                [1:0] dmac0_rresp;
input                                      dmac0_rvalid;
output             [(DMAC_DATA_WIDTH-1):0] dmac0_wdata;
output                                     dmac0_wlast;
input                                      dmac0_wready;
output         [((DMAC_DATA_WIDTH/8)-1):0] dmac0_wstrb;
output                                     dmac0_wvalid;
`endif
`ifdef AE350_PIT_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
output                                     ch1_pwm;
output                                     ch1_pwmoe;
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
output                                     ch2_pwm;
output                                     ch2_pwmoe;
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
output                                     ch3_pwm;
output                                     ch3_pwmoe;
   `endif
`endif
`ifdef AE350_GPIO_SUPPORT
   `ifdef ATCGPIO100_PULL_SUPPORT
output      [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_pulldown;
output      [(`ATCGPIO100_GPIO_NUM - 1):0] gpio_pullup;
   `endif
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_REG_APB
input                                      pclk_spi1;
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
input       [(`ATCSPI200_HADDR_WIDTH-1):0] spi_mem_haddr;
output                              [31:0] spi_mem_hrdata;
input                                      spi_mem_hready;
output                                     spi_mem_hreadyout;
output                               [1:0] spi_mem_hresp;
input                                      spi_mem_hsel;
input                                [1:0] spi_mem_htrans;
input                                      spi_mem_hwrite;
   `endif
   `ifdef ATCSPI200_SLAVE_SUPPORT
input                                      spi1_csn_in;
   `endif
   `ifdef ATCSPI200_QUADSPI_SUPPORT
input                                      spi1_holdn_in;
output                                     spi1_holdn_oe;
output                                     spi1_holdn_out;
input                                      spi1_wpn_in;
output                                     spi1_wpn_oe;
output                                     spi1_wpn_out;
   `endif
`endif
`ifdef ATCSPI200_REG_APB
   `ifdef AE350_SPI2_SUPPORT
input                                      pclk_spi2;
   `endif
`endif
`ifdef ATCSPI200_SLAVE_SUPPORT
   `ifdef AE350_SPI2_SUPPORT
input                                      spi2_csn_in;
   `endif
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
   `ifdef AE350_SPI2_SUPPORT
input                                      spi2_holdn_in;
output                                     spi2_holdn_oe;
output                                     spi2_holdn_out;
input                                      spi2_wpn_in;
output                                     spi2_wpn_oe;
output                                     spi2_wpn_out;
   `endif
`endif
`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output                [(AXI_ID_WIDTH-1):0] dmac1_arid;
output                [(AXI_ID_WIDTH-1):0] dmac1_awid;
input                 [(AXI_ID_WIDTH-1):0] dmac1_bid;
input                 [(AXI_ID_WIDTH-1):0] dmac1_rid;
output             [BUS_MASTER_ADDR_MSB:0] dmac1_araddr;
output                               [1:0] dmac1_arburst;
output                               [3:0] dmac1_arcache;
output                               [7:0] dmac1_arlen;
output                                     dmac1_arlock;
output                               [2:0] dmac1_arprot;
input                                      dmac1_arready;
output                               [2:0] dmac1_arsize;
output                                     dmac1_arvalid;
output             [BUS_MASTER_ADDR_MSB:0] dmac1_awaddr;
output                               [1:0] dmac1_awburst;
output                               [3:0] dmac1_awcache;
output                               [7:0] dmac1_awlen;
output                                     dmac1_awlock;
output                               [2:0] dmac1_awprot;
input                                      dmac1_awready;
output                               [2:0] dmac1_awsize;
output                                     dmac1_awvalid;
output                                     dmac1_bready;
input                                [1:0] dmac1_bresp;
input                                      dmac1_bvalid;
input              [(DMAC_DATA_WIDTH-1):0] dmac1_rdata;
input                                      dmac1_rlast;
output                                     dmac1_rready;
input                                [1:0] dmac1_rresp;
input                                      dmac1_rvalid;
output             [(DMAC_DATA_WIDTH-1):0] dmac1_wdata;
output                                     dmac1_wlast;
input                                      dmac1_wready;
output         [((DMAC_DATA_WIDTH/8)-1):0] dmac1_wstrb;
output                                     dmac1_wvalid;
   `endif
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
input                                      spi1_csn_in;
      `endif
   `endif
`endif
`ifdef ATCSPI200_AHBBUS_EXIST
`else
   `ifdef ATCSPI200_EILMBUS_EXIST
      `ifdef ATCSPI200_REG_APB
input                                      apb2core_clken;
      `endif
   `endif
`endif
`ifdef ATCSPI200_SLAVE_SUPPORT
`else
   `ifdef ATCSPI200_DIRECT_IO_SUPPORT
      `ifdef AE350_SPI2_SUPPORT
input                                      spi2_csn_in;
      `endif
   `endif
`endif
input           [`ATCAPBBRG100_ADDR_MSB:0] ahb2apb_haddr;
input                                [3:0] ahb2apb_hprot;
output                              [31:0] ahb2apb_hrdata;
output                                     ahb2apb_hready;
input                                      ahb2apb_hready_in;
output                               [1:0] ahb2apb_hresp;
input                                      ahb2apb_hsel;
input                                [2:0] ahb2apb_hsize;
input                                [1:0] ahb2apb_htrans;
input                               [31:0] ahb2apb_hwdata;
input                                      ahb2apb_hwrite;
output          [`ATCAPBBRG100_ADDR_MSB:0] paddr;
output                                     penable;
output                              [31:0] pwdata;
output                                     pwrite;
input                               [31:0] smu_prdata;
input                                      smu_pready;
output                                     smu_psel;
input                                      smu_pslverr;
input                                      pclk;
input                                      presetn;
input                                      apb2ahb_clken;
input                                      hclk;
input                                      hresetn;
output                                     dma_int;
output                                     gpio_intr;
input                                      extclk;
output                                     i2c_int;
output                                     pit_intr;
output                                     sdc_int;
output                                     spi1_int;
input                                      scan_enable;
input                                      scan_test;
input                                      spi_clk;
input                                      spi_rstn;
output                                     spi2_int;
output                                     ssp_intr;
output                                     uart1_int;
input                                      uart_clk;
input                                      uart_rstn;
output                                     uart2_int;
output                                     wdt_int;
output                                     wdt_rst;

`ifdef ATCAPBBRG100_SLV_14
wire                                       ps14_psel;
wire                                [31:0] ps14_prdata;
wire                                       ps14_pready;
wire                                       ps14_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_12
wire                                       ps12_psel;
wire                                [31:0] ps12_prdata;
wire                                       ps12_pready;
wire                                       ps12_pslverr;
`endif
`ifdef AE350_UART1_SUPPORT
wire                                       ps2_psel;
wire                                [31:0] ps2_prdata;
`endif
`ifdef AE350_UART2_SUPPORT
wire                                       ps3_psel;
wire                                [31:0] ps3_prdata;
`endif
`ifdef AE350_PIT_SUPPORT
wire                                       ps4_psel;
wire                                [31:0] ps4_prdata;
`endif
`ifdef AE350_WDT_SUPPORT
wire                                       ps5_psel;
wire                                [31:0] ps5_prdata;
`endif
`ifdef AE350_GPIO_SUPPORT
wire                                       ps7_psel;
wire                                [31:0] ps7_prdata;
`endif
`ifdef AE350_I2C_SUPPORT
wire                                       ps8_psel;
wire                                [31:0] ps8_prdata;
`endif
`ifdef AE350_SPI1_SUPPORT
wire                                       ps9_psel;
wire                                [31:0] ps9_prdata;
wire                                       ps9_pready;
`endif
`ifdef AE350_SPI2_SUPPORT
wire                                       ps10_psel;
wire                                [31:0] ps10_prdata;
wire                                       ps10_pready;
`endif
`ifdef AE350_DMA_AXI_SUPPORT
wire                                 [2:0] dmac0_bid_3bit;
wire                                 [2:0] dmac0_rid_3bit;
wire                                 [2:0] dmac0_arid_3bit;
wire                                 [2:0] dmac0_awid_3bit;
`endif
`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
wire                                 [2:0] dmac1_bid_3bit;
wire                                 [2:0] dmac1_rid_3bit;
wire                                 [2:0] dmac1_arid_3bit;
wire                                 [2:0] dmac1_awid_3bit;
   `endif
`endif
wire                                [15:0] dma_req;
wire                                 [2:0] pprot;
wire                                 [3:0] pstrb;
wire                                [15:0] dma_ack;
wire                                       dmareq_i2c;
wire                                       dmareq_sdc;
wire                                       dmareq_spi1_rx;
wire                                       dmareq_spi1_tx;
wire                                       dmareq_spi2_rx;
wire                                       dmareq_spi2_tx;
wire                                       dmareq_ssp_rx;
wire                                       dmareq_ssp_tx;
wire                                       dmareqn_uart1_rx;
wire                                       dmareqn_uart1_tx;
wire                                       dmareqn_uart2_rx;
wire                                       dmareqn_uart2_tx;

`ifdef AE350_SPI1_SUPPORT
`else
assign dmareq_spi1_tx = 1'b0;
assign dmareq_spi1_rx = 1'b0;
assign spi1_int = 1'b0;
`endif
`ifdef AE350_SPI2_SUPPORT
`else
assign dmareq_spi2_tx = 1'b0;
assign dmareq_spi2_rx = 1'b0;
assign spi2_int = 1'b0;
`endif
`ifdef AE350_GPIO_SUPPORT
  `ifndef ATCGPIO100_INTR_SUPPORT
assign gpio_intr     = 1'b0;
  `endif
`else
assign gpio_intr     = 1'b0;
`endif
`ifdef AE350_WDT_SUPPORT
`else
assign wdt_int       = 1'b0;
assign wdt_rst       = 1'b0;
`endif
`ifdef AE350_PIT_SUPPORT
`else
assign pit_intr      = 1'b0;
`endif
`ifdef AE350_DMA_SUPPORT
`else
assign dma_int = 1'b0;
`endif
assign ssp_intr = 1'b0;
assign dmareq_ssp_tx = 1'b0;
assign dmareq_ssp_rx = 1'b0;

assign sdc_int = 1'b0;
assign dmareq_sdc = 1'b0;

`ifdef AE350_UART1_SUPPORT
`else
assign dmareqn_uart1_tx = 1'b0;
assign dmareqn_uart1_rx = 1'b0;
assign uart1_int = 1'b0;
`endif
`ifdef AE350_UART2_SUPPORT
`else
assign dmareqn_uart2_tx = 1'b0;
assign dmareqn_uart2_rx = 1'b0;
assign uart2_int = 1'b0;
`endif
`ifdef AE350_I2C_SUPPORT
`else
assign dmareq_i2c = 1'b0;
assign i2c_int = 1'b0;
`endif
	`ifdef AE350_DMA_AXI_SUPPORT
		assign dmac0_arid = {{(AXI_ID_WIDTH-3){1'b0}}, dmac0_arid_3bit};
		assign dmac0_awid = {{(AXI_ID_WIDTH-3){1'b0}}, dmac0_awid_3bit};
		assign dmac0_bid_3bit = dmac0_bid[2:0];
		assign dmac0_rid_3bit = dmac0_rid[2:0];
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
		assign dmac1_arid = {{(AXI_ID_WIDTH-3){1'b0}}, dmac1_arid_3bit};
		assign dmac1_awid = {{(AXI_ID_WIDTH-3){1'b0}}, dmac1_awid_3bit};
		assign dmac1_bid_3bit = dmac1_bid[2:0];
		assign dmac1_rid_3bit = dmac1_rid[2:0];
		`endif
	`endif
	assign dma_req = {dmareq_ssp_rx, dmareq_ssp_tx, 4'h0, dmareq_sdc, dmareq_i2c, dmareqn_uart2_rx, dmareqn_uart2_tx, dmareqn_uart1_rx, dmareqn_uart1_tx, dmareq_spi2_rx, dmareq_spi2_tx, dmareq_spi1_rx, dmareq_spi1_tx};
`ifdef AE350_DMA_SUPPORT
`else
	assign dma_ack = 16'h0;
`endif

atcapbbrg100 u_ahb2apb (
`ifdef ATCAPBBRG100_SLV_1
	.ps1_psel     (smu_psel          ),
	.ps1_prdata   (smu_prdata        ),
	.ps1_pready   (smu_pready        ),
	.ps1_pslverr  (smu_pslverr       ),
`endif
`ifdef ATCAPBBRG100_SLV_2
	.ps2_psel     (ps2_psel          ),
	.ps2_prdata   (ps2_prdata        ),
	.ps2_pready   (1'b1              ),
	.ps2_pslverr  (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_3
	.ps3_psel     (ps3_psel          ),
	.ps3_prdata   (ps3_prdata        ),
	.ps3_pready   (1'b1              ),
	.ps3_pslverr  (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_4
	.ps4_psel     (ps4_psel          ),
	.ps4_prdata   (ps4_prdata        ),
	.ps4_pready   (1'b1              ),
	.ps4_pslverr  (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_5
	.ps5_psel     (ps5_psel          ),
	.ps5_prdata   (ps5_prdata        ),
	.ps5_pready   (1'b1              ),
	.ps5_pslverr  (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_6
	.ps6_psel     (rtc_psel          ),
	.ps6_prdata   (rtc_prdata        ),
	.ps6_pready   (rtc_pready        ),
	.ps6_pslverr  (rtc_pslverr       ),
`endif
`ifdef ATCAPBBRG100_SLV_7
	.ps7_psel     (ps7_psel          ),
	.ps7_prdata   (ps7_prdata        ),
	.ps7_pready   (1'b1              ),
	.ps7_pslverr  (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_8
	.ps8_psel     (ps8_psel          ),
	.ps8_prdata   (ps8_prdata        ),
	.ps8_pready   (1'b1              ),
	.ps8_pslverr  (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_9
	.ps9_psel     (ps9_psel          ),
	.ps9_prdata   (ps9_prdata        ),
	.ps9_pready   (ps9_pready        ),
	.ps9_pslverr  (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_10
	.ps10_psel    (ps10_psel         ),
	.ps10_prdata  (ps10_prdata       ),
	.ps10_pready  (ps10_pready       ),
	.ps10_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_11
	.ps11_psel    (ps11_psel         ),
	.ps11_prdata  (ps11_prdata       ),
	.ps11_pready  (1'b1              ),
	.ps11_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_12
	.ps12_psel    (ps12_psel         ),
	.ps12_prdata  (ps12_prdata       ),
	.ps12_pready  (ps12_pready       ),
	.ps12_pslverr (ps12_pslverr      ),
`endif
`ifdef ATCAPBBRG100_SLV_13
	.ps13_psel    (ps13_psel         ),
	.ps13_prdata  (ps13_prdata       ),
	.ps13_pready  (1'b1              ),
	.ps13_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_14
	.ps14_psel    (ps14_psel         ),
	.ps14_prdata  (ps14_prdata       ),
	.ps14_pready  (ps14_pready       ),
	.ps14_pslverr (ps14_pslverr      ),
`endif
`ifdef ATCAPBBRG100_SLV_15
	.ps15_psel    (sigdump_apb_psel  ),
	.ps15_prdata  (sigdump_apb_prdata),
	.ps15_pready  (1'b1              ),
	.ps15_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_16
	.ps16_psel    (          ),
	.ps16_prdata  (32'h0             ),
	.ps16_pready  (1'b1              ),
	.ps16_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_17
	.ps17_psel    (          ),
	.ps17_prdata  (32'h0             ),
	.ps17_pready  (1'b1              ),
	.ps17_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_18
	.ps18_psel    (          ),
	.ps18_prdata  (32'h0             ),
	.ps18_pready  (1'b1              ),
	.ps18_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_19
	.ps19_psel    (          ),
	.ps19_prdata  (32'h0             ),
	.ps19_pready  (1'b1              ),
	.ps19_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_20
	.ps20_psel    (          ),
	.ps20_prdata  (32'h0             ),
	.ps20_pready  (1'b1              ),
	.ps20_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_21
	.ps21_psel    (          ),
	.ps21_prdata  (32'h0             ),
	.ps21_pready  (1'b1              ),
	.ps21_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_22
	.ps22_psel    (          ),
	.ps22_prdata  (32'h0             ),
	.ps22_pready  (1'b1              ),
	.ps22_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_23
	.ps23_psel    (          ),
	.ps23_prdata  (32'h0             ),
	.ps23_pready  (1'b1              ),
	.ps23_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_24
	.ps24_psel    (          ),
	.ps24_prdata  (32'h0             ),
	.ps24_pready  (1'b1              ),
	.ps24_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_25
	.ps25_psel    (          ),
	.ps25_prdata  (32'h0             ),
	.ps25_pready  (1'b1              ),
	.ps25_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_26
	.ps26_psel    (          ),
	.ps26_prdata  (32'h0             ),
	.ps26_pready  (1'b1              ),
	.ps26_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_27
	.ps27_psel    (          ),
	.ps27_prdata  (32'h0             ),
	.ps27_pready  (1'b1              ),
	.ps27_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_28
	.ps28_psel    (          ),
	.ps28_prdata  (32'h0             ),
	.ps28_pready  (1'b1              ),
	.ps28_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_29
	.ps29_psel    (          ),
	.ps29_prdata  (32'h0             ),
	.ps29_pready  (1'b1              ),
	.ps29_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_30
	.ps30_psel    (          ),
	.ps30_prdata  (32'h0             ),
	.ps30_pready  (1'b1              ),
	.ps30_pslverr (1'b0              ),
`endif
`ifdef ATCAPBBRG100_SLV_31
	.ps31_psel    (          ),
	.ps31_prdata  (32'h0             ),
	.ps31_pready  (1'b1              ),
	.ps31_pslverr (1'b0              ),
`endif
	.hclk         (hclk              ),
	.hresetn      (hresetn           ),
	.hsel         (ahb2apb_hsel      ),
	.hready_in    (ahb2apb_hready_in ),
	.htrans       (ahb2apb_htrans    ),
	.haddr        (ahb2apb_haddr     ),
	.hsize        (ahb2apb_hsize     ),
	.hprot        (ahb2apb_hprot     ),
	.hwrite       (ahb2apb_hwrite    ),
	.hwdata       (ahb2apb_hwdata    ),
	.apb2ahb_clken(apb2ahb_clken     ),
	.hrdata       (ahb2apb_hrdata    ),
	.hready       (ahb2apb_hready    ),
	.hresp        (ahb2apb_hresp     ),
	.pclk         (pclk              ),
	.presetn      (presetn           ),
	.pprot        (pprot             ),
	.pstrb        (pstrb             ),
	.paddr        (paddr             ),
	.penable      (penable           ),
	.pwrite       (pwrite            ),
	.pwdata       (pwdata            )
);

`ifdef AE350_UART1_SUPPORT
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
	.prdata    (ps2_prdata      ),
	.uart_dtrn (uart1_dtrn      ),
	.uart_intr (uart1_int       ),
	.uart_out1n(uart1_out1n     ),
	.uart_out2n(uart1_out2n     ),
	.uart_rtsn (uart1_rtsn      ),
	.uart_sout (uart1_txd       )
);

`endif
`ifdef AE350_UART2_SUPPORT
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
	.prdata    (ps3_prdata      ),
	.uart_dtrn (uart2_dtrn      ),
	.uart_intr (uart2_int       ),
	.uart_out1n(uart2_out1n     ),
	.uart_out2n(uart2_out2n     ),
	.uart_rtsn (uart2_rtsn      ),
	.uart_sout (uart2_txd       )
);

`endif
`ifdef AE350_PIT_SUPPORT
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
	.extclk   (extclk    ),
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

`endif
`ifdef AE350_WDT_SUPPORT
atcwdt200 u_wdt (
	.extclk   (extclk    ),
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

`endif
`ifdef AE350_GPIO_SUPPORT
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
	.extclk       (extclk       ),
	.gpio_in      (gpio_in      )
);

`endif
`ifdef AE350_I2C_SUPPORT
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
`ifdef AE350_SPI1_SUPPORT
atcspi200 u_spi1 (
   `ifdef ATCSPI200_AHBBUS_EXIST
	.hclk                (hclk             ),
	.hresetn             (hresetn          ),
   `endif
   `ifdef ATCSPI200_EILMBUS_EXIST
	.eilm_addr           (         ),
	.eilm_clk            (         ),
	.eilm_rdata          (         ),
	.eilm_req            (         ),
	.eilm_resetn         (         ),
	.eilm_wait           (         ),
	.eilm_wait_cnt       (         ),
	.eilm_wdata          (         ),
	.eilm_web            (         ),
   `endif
   `ifdef ATCSPI200_REG_APB
	.pclk                (pclk_spi1        ),
	.presetn             (presetn          ),
	.paddr               (paddr            ),
	.penable             (penable          ),
	.prdata              (ps9_prdata       ),
	.pready              (ps9_pready       ),
	.psel                (ps9_psel         ),
	.pwdata              (pwdata           ),
	.pwrite              (pwrite           ),
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
	.haddr_mem           (spi_mem_haddr    ),
	.hrdata_mem          (spi_mem_hrdata   ),
	.hreadyin_mem        (spi_mem_hready   ),
	.hreadyout_mem       (spi_mem_hreadyout),
	.hresp_mem           (spi_mem_hresp    ),
	.hsel_mem            (spi_mem_hsel     ),
	.htrans_mem          (spi_mem_htrans   ),
	.hwrite_mem          (spi_mem_hwrite   ),
   `endif
   `ifdef ATCSPI200_REG_AHB
	.haddr_reg           (         ),
	.hrdata_reg          (         ),
	.hreadyin_reg        (         ),
	.hreadyout_reg       (         ),
	.hresp_reg           (         ),
	.hsel_reg            (         ),
	.htrans_reg          (         ),
	.hwdata_reg          (         ),
	.hwrite_reg          (         ),
   `endif
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_default_as_slave(1'b0             ),
	.spi_cs_n_in         (spi1_csn_in      ),
   `endif
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi_hold_n_in       (spi1_holdn_in    ),
	.spi_hold_n_oe       (spi1_holdn_oe    ),
	.spi_hold_n_out      (spi1_holdn_out   ),
	.spi_wp_n_in         (spi1_wpn_in      ),
	.spi_wp_n_oe         (spi1_wpn_oe      ),
	.spi_wp_n_out        (spi1_wpn_out     ),
   `endif
   `ifdef ATCSPI200_AHBBUS_EXIST
      `ifdef ATCSPI200_EILMBUS_EXIST
	.ahb2eilm_clken      (         ),
      `endif
      `ifdef ATCSPI200_REG_APB
	.apb2ahb_clken       (apb2ahb_clken    ),
      `endif
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
      `ifdef ATCSPI200_HSPLIT_SUPPORT
	.hmaster_mem         (         ),
	.hsplit_mem          (         ),
      `endif
   `endif
   `ifdef ATCSPI200_REG_EILM
      `ifdef ATCSPI200_EILM_MEM_SUPPORT
	.eilm_reg_sel        (         ),
      `endif
   `endif
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi_cs_n_in         (spi1_csn_in      ),
      `endif
   `endif
   `ifdef ATCSPI200_AHBBUS_EXIST
   `else
      `ifdef ATCSPI200_EILMBUS_EXIST
         `ifdef ATCSPI200_REG_APB
	.apb2eilm_clken      (apb2core_clken   ),
         `endif
      `endif
   `endif
	.spi_clock           (spi_clk          ),
	.spi_rstn            (spi_rstn         ),
	.spi_boot_intr       (spi1_int         ),
	.spi_default_mode3   (1'b0             ),
	.spi_rx_dma_ack      (dma_ack[1]       ),
	.spi_rx_dma_req      (dmareq_spi1_rx   ),
	.spi_tx_dma_ack      (dma_ack[0]       ),
	.spi_tx_dma_req      (dmareq_spi1_tx   ),
	.scan_enable         (scan_enable      ),
	.scan_test           (scan_test        ),
	.spi_clk_in          (spi1_clk_in      ),
	.spi_clk_oe          (spi1_clk_oe      ),
	.spi_clk_out         (spi1_clk_out     ),
	.spi_cs_n_oe         (spi1_csn_oe      ),
	.spi_cs_n_out        (spi1_csn_out     ),
	.spi_miso_in         (spi1_miso_in     ),
	.spi_miso_oe         (spi1_miso_oe     ),
	.spi_miso_out        (spi1_miso_out    ),
	.spi_mosi_in         (spi1_mosi_in     ),
	.spi_mosi_oe         (spi1_mosi_oe     ),
	.spi_mosi_out        (spi1_mosi_out    )
);

`endif
`ifdef AE350_SPI2_SUPPORT
atcspi200 u_spi2 (
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
	.pclk                (pclk_spi2     ),
	.presetn             (presetn       ),
	.paddr               (paddr         ),
	.penable             (penable       ),
	.prdata              (ps10_prdata   ),
	.pready              (ps10_pready   ),
	.psel                (ps10_psel     ),
	.pwdata              (pwdata        ),
	.pwrite              (pwrite        ),
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
	.haddr_mem           ({`ATCSPI200_HADDR_WIDTH{1'b0}}),
	.hrdata_mem          (      ),
	.hreadyin_mem        (1'b1          ),
	.hreadyout_mem       (      ),
	.hresp_mem           (      ),
	.hsel_mem            (1'b0          ),
	.htrans_mem          (2'b0          ),
	.hwrite_mem          (1'b0          ),
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
	.spi_cs_n_in         (spi2_csn_in   ),
   `endif
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi_hold_n_in       (spi2_holdn_in ),
	.spi_hold_n_oe       (spi2_holdn_oe ),
	.spi_hold_n_out      (spi2_holdn_out),
	.spi_wp_n_in         (spi2_wpn_in   ),
	.spi_wp_n_oe         (spi2_wpn_oe   ),
	.spi_wp_n_out        (spi2_wpn_out  ),
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
	.hmaster_mem         (      ),
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
	.spi_cs_n_in         (spi2_csn_in   ),
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
	.spi_boot_intr       (spi2_int      ),
	.spi_default_mode3   (1'b0          ),
	.spi_rx_dma_ack      (dma_ack[3]    ),
	.spi_rx_dma_req      (dmareq_spi2_rx),
	.spi_tx_dma_ack      (dma_ack[2]    ),
	.spi_tx_dma_req      (dmareq_spi2_tx),
	.scan_enable         (scan_enable   ),
	.scan_test           (scan_test     ),
	.spi_clk_in          (spi2_clk_in   ),
	.spi_clk_oe          (spi2_clk_oe   ),
	.spi_clk_out         (spi2_clk_out  ),
	.spi_cs_n_oe         (spi2_csn_oe   ),
	.spi_cs_n_out        (spi2_csn_out  ),
	.spi_miso_in         (spi2_miso_in  ),
	.spi_miso_oe         (spi2_miso_oe  ),
	.spi_miso_out        (spi2_miso_out ),
	.spi_mosi_in         (spi2_mosi_in  ),
	.spi_mosi_oe         (spi2_mosi_oe  ),
	.spi_mosi_out        (spi2_mosi_out )
);

`endif

`ifdef AE350_DMA_AXI_SUPPORT
atcdmac300 u_dmac_axi (
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.m1_araddr (dmac1_araddr   ),
	.m1_arburst(dmac1_arburst  ),
	.m1_arcache(dmac1_arcache  ),
	.m1_arid   (dmac1_arid_3bit),
	.m1_arlen  (dmac1_arlen    ),
	.m1_arlock (dmac1_arlock   ),
	.m1_arprot (dmac1_arprot   ),
	.m1_arready(dmac1_arready  ),
	.m1_arsize (dmac1_arsize   ),
	.m1_arvalid(dmac1_arvalid  ),
	.m1_awaddr (dmac1_awaddr   ),
	.m1_awburst(dmac1_awburst  ),
	.m1_awcache(dmac1_awcache  ),
	.m1_awid   (dmac1_awid_3bit),
	.m1_awlen  (dmac1_awlen    ),
	.m1_awlock (dmac1_awlock   ),
	.m1_awprot (dmac1_awprot   ),
	.m1_awready(dmac1_awready  ),
	.m1_awsize (dmac1_awsize   ),
	.m1_awvalid(dmac1_awvalid  ),
	.m1_bid    (dmac1_bid_3bit ),
	.m1_bready (dmac1_bready   ),
	.m1_bresp  (dmac1_bresp    ),
	.m1_bvalid (dmac1_bvalid   ),
	.m1_rdata  (dmac1_rdata    ),
	.m1_rid    (dmac1_rid_3bit ),
	.m1_rlast  (dmac1_rlast    ),
	.m1_rready (dmac1_rready   ),
	.m1_rresp  (dmac1_rresp    ),
	.m1_rvalid (dmac1_rvalid   ),
	.m1_wdata  (dmac1_wdata    ),
	.m1_wlast  (dmac1_wlast    ),
	.m1_wready (dmac1_wready   ),
	.m1_wstrb  (dmac1_wstrb    ),
	.m1_wvalid (dmac1_wvalid   ),
   `endif
	.paddr     (paddr          ),
	.penable   (penable        ),
	.prdata    (ps12_prdata    ),
	.pready    (ps12_pready    ),
	.psel      (ps12_psel      ),
	.pslverr   (ps12_pslverr   ),
	.pwdata    (pwdata         ),
	.pwrite    (pwrite         ),
	.pclk      (pclk           ),
	.presetn   (presetn        ),
	.m0_araddr (dmac0_araddr   ),
	.m0_arburst(dmac0_arburst  ),
	.m0_arcache(dmac0_arcache  ),
	.m0_arid   (dmac0_arid_3bit),
	.m0_arlen  (dmac0_arlen    ),
	.m0_arlock (dmac0_arlock   ),
	.m0_arprot (dmac0_arprot   ),
	.m0_arready(dmac0_arready  ),
	.m0_arsize (dmac0_arsize   ),
	.m0_arvalid(dmac0_arvalid  ),
	.m0_awaddr (dmac0_awaddr   ),
	.m0_awburst(dmac0_awburst  ),
	.m0_awcache(dmac0_awcache  ),
	.m0_awid   (dmac0_awid_3bit),
	.m0_awlen  (dmac0_awlen    ),
	.m0_awlock (dmac0_awlock   ),
	.m0_awprot (dmac0_awprot   ),
	.m0_awready(dmac0_awready  ),
	.m0_awsize (dmac0_awsize   ),
	.m0_awvalid(dmac0_awvalid  ),
	.m0_bid    (dmac0_bid_3bit ),
	.m0_bready (dmac0_bready   ),
	.m0_bresp  (dmac0_bresp    ),
	.m0_bvalid (dmac0_bvalid   ),
	.m0_rdata  (dmac0_rdata    ),
	.m0_rid    (dmac0_rid_3bit ),
	.m0_rlast  (dmac0_rlast    ),
	.m0_rready (dmac0_rready   ),
	.m0_rresp  (dmac0_rresp    ),
	.m0_rvalid (dmac0_rvalid   ),
	.m0_wdata  (dmac0_wdata    ),
	.m0_wlast  (dmac0_wlast    ),
	.m0_wready (dmac0_wready   ),
	.m0_wstrb  (dmac0_wstrb    ),
	.m0_wvalid (dmac0_wvalid   ),
	.aclk      (aclk           ),
	.aresetn   (aresetn        ),
	.dma_ack   (dma_ack        ),
	.dma_req   (dma_req        ),
	.dma_int   (dma_int        )
);

`endif

`ifdef ATCAPBBRG100_SLV_14
sample_dtrom #(
	.MEM_SIZE_KB     (DTROM_SIZE_KB   )
) u_dtrom (
	.pclk   (pclk        ),
	.paddr  (paddr[19:0] ),
	.psel   (ps14_psel   ),
	.penable(penable     ),
	.pwrite (pwrite      ),
	.pwdata (pwdata      ),
	.pready (ps14_pready ),
	.prdata (ps14_prdata ),
	.pslverr(ps14_pslverr)
);

`endif
endmodule

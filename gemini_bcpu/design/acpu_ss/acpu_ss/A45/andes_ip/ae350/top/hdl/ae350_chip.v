// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "config.inc"
`include "global.inc"

`include "ae350_config.vh"
`include "ae350_const.vh"

`define AE350_AXI_SUPPORT

`include "atcgpio100_config.vh"
`include "atcgpio100_const.vh"
`include "atcpit100_config.vh"
`include "atcpit100_const.vh"
`include "atcwdt200_config.vh"
`include "atcwdt200_const.vh"
`include "atcrtc100_config.vh"
`include "atcrtc100_const.vh"





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

`ifdef AE350_I2C_SUPPORT
`include "atciic100_config.vh"
`include "atciic100_const.vh"
`endif

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

`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"
`include "atcbusdec200_config.vh"
`include "atcbusdec200_const.vh"
`include "atcapbbrg100_config.vh"
`include "atcapbbrg100_const.vh"

`ifdef AE350_SPI1_SUPPORT
`endif

`ifdef AE350_DMA_SUPPORT
	`define AE350_DMA_AXI_SUPPORT
	`include "atcdmac300_config.vh"
	`include "atcdmac300_const.vh"
`endif





module ae350_chip (
`ifdef PLATFORM_DEBUG_PORT
	  X_tck,
	  X_tms,
`endif
`ifdef NDS_FPGA
	  X_flash_dir,
`else
	  X_aopd_por_b,
	  X_mpd_pwr_off,
	  X_om,
	  X_osclio,
	  X_oschio,
`endif
`ifdef AE350_UART1_SUPPORT
	  X_uart1_dcdn,
	  X_uart1_dsrn,
	  X_uart1_dtrn,
	  X_uart1_out1n,
	  X_uart1_out2n,
	  X_uart1_rin,
	  X_uart1_rxd,
	  X_uart1_txd,
`endif
`ifdef AE350_UART2_SUPPORT
	  X_uart2_rxd,
	  X_uart2_txd,
`endif
`ifdef AE350_PIT_SUPPORT
	  X_pwm_ch0,
`endif
`ifdef AE350_GPIO_SUPPORT
	  X_gpio,
`endif
`ifdef AE350_I2C_SUPPORT
	  X_i2c_scl,
	  X_i2c_sda,
`endif
`ifdef AE350_SPI1_SUPPORT
	  X_spi1_clk,
	  X_spi1_csn,
	  X_spi1_miso,
	  X_spi1_mosi,
`endif
`ifdef AE350_SPI2_SUPPORT
	  X_spi2_clk,
	  X_spi2_csn,
	  X_spi2_miso,
	  X_spi2_mosi,
`endif

`ifdef PLATFORM_JTAG_TWOWIRE
`else
   `ifdef PLATFORM_DEBUG_PORT
	  X_tdi,
	  X_tdo,
	  X_trst,
   `endif
`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
	  X_secure_mode,
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE350_RTC_SUPPORT
	  X_rtc_wakeup,
   `endif
`endif
`ifdef AE350_UART1_SUPPORT
   `ifdef AE350_UART2_SUPPORT
   `else
	  X_uart1_ctsn,
	  X_uart1_rtsn,
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE350_UART2_SUPPORT
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
`ifdef AE350_PIT_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
	  X_pwm_ch1,
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
	  X_pwm_ch2,
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
	  X_pwm_ch3,
   `endif
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  X_spi1_holdn,
	  X_spi1_wpn,
   `endif
`endif
`ifdef AE350_SPI2_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  X_spi2_holdn,
	  X_spi2_wpn,
   `endif
`endif






`ifdef NDS_FPGA
`else
   `ifdef AE350_UART1_SUPPORT
      `ifdef AE350_UART2_SUPPORT
	  X_uart1_ctsn,
	  X_uart1_rtsn,
      `endif
   `endif
`endif
`ifdef NDS_FPGA
   


`else
   


`endif
	  X_osclin,
	  X_wakeup_in,
	  X_hw_rstn,
	  X_oschin,
	  X_por_b
);

parameter SIMULATION = "FALSE" ;
parameter SIM_BYPASS_INIT_CAL = "OFF" ;

localparam PALEN			= `NDS_BIU_ADDR_WIDTH;
localparam ISA_BASE			= `NDS_ISA_BASE;
localparam XLEN			= ISA_BASE == "rv64i" ? 64 : 32;
localparam MMU_SCHEME		= `NDS_MMU_SCHEME;
localparam VALEN			= (MMU_SCHEME == "bare") ? PALEN : (MMU_SCHEME == "sv32") ? 32 : (MMU_SCHEME == "sv39") ? 39: 48;
`ifdef PLATFORM_FORCE_4GB_SPACE
localparam ADDR_WIDTH               = 32;
`else
localparam ADDR_WIDTH               = PALEN;
`endif
localparam ADDR_MSB		        = (ADDR_WIDTH-1);
`ifdef NDS_L2C_BIU_DATA_WIDTH
localparam BIU_DATA_WIDTH	= `NDS_L2C_BIU_DATA_WIDTH;
localparam DMAC_DATA_WIDTH	= 64;
`else
localparam BIU_DATA_WIDTH	= `NDS_BIU_DATA_WIDTH;
localparam DMAC_DATA_WIDTH	= BIU_DATA_WIDTH;
`endif
localparam BIU_DATA_MSB		= (BIU_DATA_WIDTH-1);
localparam BIU_WSTRB_WIDTH		= (BIU_DATA_WIDTH/8);
localparam BIU_WSTRB_MSB		= (BIU_WSTRB_WIDTH-1);
localparam DMAC_DATA_MSB		= (DMAC_DATA_WIDTH-1);
localparam DMAC_WSTRB_WIDTH		= (DMAC_DATA_WIDTH/8);
localparam DMAC_WSTRB_MSB		= (DMAC_WSTRB_WIDTH-1);
`ifdef NDS_SLAVE_PORT_DATA_WIDTH
localparam SLVPORT_DATA_WIDTH	= `NDS_SLAVE_PORT_DATA_WIDTH;
`else
localparam SLVPORT_DATA_WIDTH	= `NDS_BIU_DATA_WIDTH;
`endif
localparam SLVPORT_DATA_MSB		= (SLVPORT_DATA_WIDTH-1);
localparam SLVPORT_WSTRB_WIDTH	= (SLVPORT_DATA_WIDTH/8);
localparam SLVPORT_WSTRB_MSB	= (SLVPORT_WSTRB_WIDTH-1);
localparam BIU_ID_WIDTH		= `AE350_AXI_ID_WIDTH;
localparam BIU_ID_MSB		= (BIU_ID_WIDTH-1);
localparam SYSTEM_BUS_TYPE	        = "axi";
localparam NHART                    = 1;
localparam DDR_ASYNC_DEPTH          = 16;

`ifdef ATCAPBBRG100_SLV_14
   `ifdef AE350_DTROM_SIZE_KB
localparam DTROM_SIZE_KB = `AE350_DTROM_SIZE_KB;
   `else
localparam DTROM_SIZE_KB = 8;
   `endif
`endif
`ifdef NDS_L2C_BIU_DATA_WIDTH
localparam L2C_BIU_DATA_WIDTH	= `NDS_L2C_BIU_DATA_WIDTH;
`else
localparam L2C_BIU_DATA_WIDTH	= 64;
`endif
`ifdef PLATFORM_JTAG_TWOWIRE
localparam DEBUG_INTERFACE        = "serial";
`else
localparam DEBUG_INTERFACE        = "jtag";
`endif
`ifdef PLATFORM_JTAG_TAP_NUM
localparam JTAG_TAP_NUM           = `PLATFORM_JTAG_TAP_NUM;
`else
localparam JTAG_TAP_NUM           = 1;
`endif
`ifdef PLATFORM_DM_TAP_ID
localparam DM_TAP_ID              = `PLATFORM_DM_TAP_ID;
`else
localparam DM_TAP_ID              = 0;
`endif

`ifdef PLATFORM_DEBUG_PORT
inout                                       X_tck;
inout                                       X_tms;
`endif
`ifdef NDS_FPGA
inout                                       X_flash_dir;
`else
inout                                       X_aopd_por_b;
inout                                       X_mpd_pwr_off;
inout                                       X_om;
inout                                       X_osclio;
inout                                       X_oschio;
`endif
`ifdef AE350_UART1_SUPPORT
inout                                       X_uart1_dcdn;
inout                                       X_uart1_dsrn;
inout                                       X_uart1_dtrn;
inout                                       X_uart1_out1n;
inout                                       X_uart1_out2n;
inout                                       X_uart1_rin;
inout                                       X_uart1_rxd;
inout                                       X_uart1_txd;
`endif
`ifdef AE350_UART2_SUPPORT
inout                                       X_uart2_rxd;
inout                                       X_uart2_txd;
`endif
`ifdef AE350_PIT_SUPPORT
inout                                       X_pwm_ch0;
`endif
`ifdef AE350_GPIO_SUPPORT
inout                                [31:0] X_gpio;
`endif
`ifdef AE350_I2C_SUPPORT
inout                                       X_i2c_scl;
inout                                       X_i2c_sda;
`endif
`ifdef AE350_SPI1_SUPPORT
inout                                       X_spi1_clk;
inout                                       X_spi1_csn;
inout                                       X_spi1_miso;
inout                                       X_spi1_mosi;
`endif
`ifdef AE350_SPI2_SUPPORT
inout                                       X_spi2_clk;
inout                                       X_spi2_csn;
inout                                       X_spi2_miso;
inout                                       X_spi2_mosi;
`endif

`ifdef PLATFORM_JTAG_TWOWIRE
`else
   `ifdef PLATFORM_DEBUG_PORT
inout                                       X_tdi;
inout                                       X_tdo;
inout                                       X_trst;
   `endif
`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
inout                                 [1:0] X_secure_mode;
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE350_RTC_SUPPORT
inout                                       X_rtc_wakeup;
   `endif
`endif
`ifdef AE350_UART1_SUPPORT
   `ifdef AE350_UART2_SUPPORT
   `else
inout                                       X_uart1_ctsn;
inout                                       X_uart1_rtsn;
   `endif
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE350_UART2_SUPPORT
inout                                       X_uart2_ctsn;
inout                                       X_uart2_dcdn;
inout                                       X_uart2_dsrn;
inout                                       X_uart2_dtrn;
inout                                       X_uart2_out1n;
inout                                       X_uart2_out2n;
inout                                       X_uart2_rin;
inout                                       X_uart2_rtsn;
   `endif
`endif
`ifdef AE350_PIT_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
inout                                       X_pwm_ch1;
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
inout                                       X_pwm_ch2;
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
inout                                       X_pwm_ch3;
   `endif
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
inout                                       X_spi1_holdn;
inout                                       X_spi1_wpn;
   `endif
`endif
`ifdef AE350_SPI2_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
inout                                       X_spi2_holdn;
inout                                       X_spi2_wpn;
   `endif
`endif






`ifdef NDS_FPGA
`else
   `ifdef AE350_UART1_SUPPORT
      `ifdef AE350_UART2_SUPPORT
inout                                       X_uart1_ctsn;
inout                                       X_uart1_rtsn;
      `endif
   `endif
`endif
`ifdef NDS_FPGA
   


`else
   


`endif
input                                       X_osclin;
inout                                       X_wakeup_in;
inout                                       X_hw_rstn;
input                                       X_oschin;
inout                                       X_por_b;

`ifdef AE350_DMA_AXI_SUPPORT
wire                       [(ADDR_WIDTH-1):0] dmac0_araddr;
wire                                    [1:0] dmac0_arburst;
wire                                    [3:0] dmac0_arcache;
wire                     [(BIU_ID_WIDTH-1):0] dmac0_arid;
wire                                    [7:0] dmac0_arlen;
wire                                          dmac0_arlock;
wire                                    [2:0] dmac0_arprot;
wire                                    [2:0] dmac0_arsize;
wire                                          dmac0_arvalid;
wire                       [(ADDR_WIDTH-1):0] dmac0_awaddr;
wire                                    [1:0] dmac0_awburst;
wire                                    [3:0] dmac0_awcache;
wire                     [(BIU_ID_WIDTH-1):0] dmac0_awid;
wire                                    [7:0] dmac0_awlen;
wire                                          dmac0_awlock;
wire                                    [2:0] dmac0_awprot;
wire                                    [2:0] dmac0_awsize;
wire                                          dmac0_awvalid;
wire                                          dmac0_bready;
wire                                          dmac0_rready;
wire                  [(DMAC_DATA_WIDTH-1):0] dmac0_wdata;
wire                                          dmac0_wlast;
wire              [((DMAC_DATA_WIDTH/8)-1):0] dmac0_wstrb;
wire                                          dmac0_wvalid;
wire                                          dmac0_arready;
wire                                          dmac0_awready;
wire                     [(BIU_ID_WIDTH-1):0] dmac0_bid;
wire                                    [1:0] dmac0_bresp;
wire                                          dmac0_bvalid;
wire                  [(DMAC_DATA_WIDTH-1):0] dmac0_rdata;
wire                     [(BIU_ID_WIDTH-1):0] dmac0_rid;
wire                                          dmac0_rlast;
wire                                    [1:0] dmac0_rresp;
wire                                          dmac0_rvalid;
wire                                          dmac0_wready;
`endif
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
wire                       [(ADDR_WIDTH-1):0] cpuslv_araddr;
wire                                    [1:0] cpuslv_arburst;
wire                                    [3:0] cpuslv_arcache;
wire                   [(BIU_ID_WIDTH-1)+4:0] cpuslv_arid;
wire                                    [7:0] cpuslv_arlen;
wire                                          cpuslv_arlock;
wire                                    [2:0] cpuslv_arprot;
wire                                    [2:0] cpuslv_arsize;
wire                                          cpuslv_arvalid;
wire                       [(ADDR_WIDTH-1):0] cpuslv_awaddr;
wire                                    [1:0] cpuslv_awburst;
wire                                    [3:0] cpuslv_awcache;
wire                   [(BIU_ID_WIDTH-1)+4:0] cpuslv_awid;
wire                                    [7:0] cpuslv_awlen;
wire                                          cpuslv_awlock;
wire                                    [2:0] cpuslv_awprot;
wire                                    [2:0] cpuslv_awsize;
wire                                          cpuslv_awvalid;
wire                                          cpuslv_bready;
wire                                          cpuslv_rready;
wire                     [SLVPORT_DATA_MSB:0] cpuslv_wdata;
wire                                          cpuslv_wlast;
wire                    [SLVPORT_WSTRB_MSB:0] cpuslv_wstrb;
wire                                          cpuslv_wvalid;
wire                                          cpuslv_arready;
wire                                          cpuslv_awready;
wire                   [(BIU_ID_WIDTH-1)+4:0] cpuslv_bid;
wire                                    [1:0] cpuslv_bresp;
wire                                          cpuslv_bvalid;
wire                     [SLVPORT_DATA_MSB:0] cpuslv_rdata;
wire                   [(BIU_ID_WIDTH-1)+4:0] cpuslv_rid;
wire                                          cpuslv_rlast;
wire                                    [1:0] cpuslv_rresp;
wire                                          cpuslv_rvalid;
wire                                          cpuslv_wready;
`endif
`ifdef NDS_IO_COHERENCE
wire                       [(ADDR_WIDTH-1):0] iocp0_araddr;
wire                                    [1:0] iocp0_arburst;
wire                                    [3:0] iocp0_arcache;
wire                   [(BIU_ID_WIDTH-1)+4:0] iocp0_arid;
wire                                    [7:0] iocp0_arlen;
wire                                          iocp0_arlock;
wire                                    [2:0] iocp0_arprot;
wire                                    [2:0] iocp0_arsize;
wire                                          iocp0_arvalid;
wire                       [(ADDR_WIDTH-1):0] iocp0_awaddr;
wire                                    [1:0] iocp0_awburst;
wire                                    [3:0] iocp0_awcache;
wire                   [(BIU_ID_WIDTH-1)+4:0] iocp0_awid;
wire                                    [7:0] iocp0_awlen;
wire                                          iocp0_awlock;
wire                                    [2:0] iocp0_awprot;
wire                                    [2:0] iocp0_awsize;
wire                                          iocp0_awvalid;
wire                                          iocp0_bready;
wire                                          iocp0_rready;
wire            [((`NDS_BIU_DATA_WIDTH)-1):0] iocp0_wdata;
wire                                          iocp0_wlast;
wire        [(((`NDS_BIU_DATA_WIDTH)/8)-1):0] iocp0_wstrb;
wire                                          iocp0_wvalid;
wire                                          iocp0_arready;
wire                                          iocp0_awready;
wire                   [(BIU_ID_WIDTH-1)+4:0] iocp0_bid;
wire                                    [1:0] iocp0_bresp;
wire                                          iocp0_bvalid;
wire            [((`NDS_BIU_DATA_WIDTH)-1):0] iocp0_rdata;
wire                   [(BIU_ID_WIDTH-1)+4:0] iocp0_rid;
wire                                          iocp0_rlast;
wire                                    [1:0] iocp0_rresp;
wire                                          iocp0_rvalid;
wire                                          iocp0_wready;
`endif
`ifdef PLATFORM_DEBUG_PORT
wire                                          pin_tdo_out;
wire                                          pin_tdo_out_en;
wire                                          pin_tms_out;
wire                                          pin_tms_out_en;
wire                                          pin_tdi_in;
wire                                          pin_tms_in;
wire                                          pin_trst_in;
`endif
`ifdef NDS_FPGA
wire                                    [1:0] ddr3_bw_ctrl;
wire                                          X_flash_cs;
`endif
`ifdef AE350_RTC_SUPPORT
wire                                   [31:0] rtc_prdata;
wire                                          rtc_pready;
wire                                          rtc_pslverr;
wire                                          rtc_psel;
`endif
`ifdef AE350_UART1_SUPPORT
wire                                          uart1_dtrn;
wire                                          uart1_out1n;
wire                                          uart1_out2n;
wire                                          uart1_rtsn;
wire                                          uart1_txd;
wire                                          uart1_ctsn;
wire                                          uart1_dcdn;
wire                                          uart1_dsrn;
wire                                          uart1_rin;
wire                                          uart1_rxd;
`endif
`ifdef AE350_UART2_SUPPORT
wire                                          uart2_dtrn;
wire                                          uart2_out1n;
wire                                          uart2_out2n;
wire                                          uart2_rtsn;
wire                                          uart2_txd;
wire                                          uart2_ctsn;
wire                                          uart2_dcdn;
wire                                          uart2_dsrn;
wire                                          uart2_rin;
wire                                          uart2_rxd;
`endif
`ifdef AE350_PIT_SUPPORT
wire                                          ch0_pwm;
wire                                          ch0_pwmoe;
`endif
`ifdef AE350_GPIO_SUPPORT
wire                                   [31:0] gpio_oe;
wire                                   [31:0] gpio_out;
wire                                   [31:0] gpio_in;
`endif
`ifdef AE350_I2C_SUPPORT
wire                                          i2c_scl;
wire                                          i2c_sda;
wire                                          i2c_scl_in;
wire                                          i2c_sda_in;
`endif
`ifdef AE350_SPI1_SUPPORT
wire                                          spi1_clk_oe;
wire                                          spi1_clk_out;
wire                                          spi1_csn_oe;
wire                                          spi1_csn_out;
wire                                          spi1_miso_oe;
wire                                          spi1_miso_out;
wire                                          spi1_mosi_oe;
wire                                          spi1_mosi_out;
wire                                   [31:0] spi_mem_hrdata;
wire                                          spi_mem_hreadyout;
wire                                    [1:0] spi_mem_hresp;
wire                                          spi1_clk_in;
wire                                          spi1_csn_in;
wire                                          spi1_miso_in;
wire                                          spi1_mosi_in;
wire                                          spi_mem_hsel;
`endif
`ifdef AE350_SPI2_SUPPORT
wire                                          spi2_clk_oe;
wire                                          spi2_clk_out;
wire                                          spi2_csn_oe;
wire                                          spi2_csn_out;
wire                                          spi2_miso_oe;
wire                                          spi2_miso_out;
wire                                          spi2_mosi_oe;
wire                                          spi2_mosi_out;
wire                                          spi2_clk_in;
wire                                          spi2_csn_in;
wire                                          spi2_miso_in;
wire                                          spi2_mosi_in;
`endif
`ifdef PLATFORM_DEBUG_SUBSYSTEM
wire                                    [8:0] dmi_haddr;
wire                                    [2:0] dmi_hburst;
wire                                    [3:0] dmi_hprot;
wire                                          dmi_hsel;
wire                                    [2:0] dmi_hsize;
wire                                    [1:0] dmi_htrans;
wire                                   [31:0] dmi_hwdata;
wire                                          dmi_hwrite;
wire                                          dmi_resetn;
wire                                   [31:0] dmi_hrdata;
wire                                          dmi_hready;
wire                                    [1:0] dmi_hresp;
`endif
`ifdef NDS_IO_PROBING
wire                                   [12:0] hart0_probe_gpr_index;
wire                     [((`NDS_VALEN)-1):0] hart0_probe_current_pc;
wire                      [((`NDS_XLEN)-1):0] hart0_probe_selected_gpr_value;
`endif
   `ifdef PLATFORM_DEBUG_SUBSYSTEM
wire                                          nds_unused_dmactive;
   `endif
   `ifdef NDS_IO_TRACE_INSTR_GEN1
wire                                   [19:0] nds_unused_hart0_gen1_trace_cause;
wire                     [(`NDS_VALEN)*2-1:0] nds_unused_hart0_gen1_trace_iaddr;
wire                                    [1:0] nds_unused_hart0_gen1_trace_iexception;
wire                                   [63:0] nds_unused_hart0_gen1_trace_instr;
wire                                    [1:0] nds_unused_hart0_gen1_trace_interrupt;
wire                                    [1:0] nds_unused_hart0_gen1_trace_ivalid;
wire                                    [3:0] nds_unused_hart0_gen1_trace_priv;
wire                      [(`NDS_XLEN)*2-1:0] nds_unused_hart0_gen1_trace_tval;
   `endif
   `ifdef NDS_IO_TRACE_INSTR
wire                                    [9:0] nds_unused_hart0_trace_cause;
wire                                          nds_unused_hart0_trace_halted;
wire                     [2*(`NDS_VALEN)-1:0] nds_unused_hart0_trace_iaddr;
wire                                    [1:0] nds_unused_hart0_trace_ilastsize;
wire                                    [3:0] nds_unused_hart0_trace_iretire;
wire                                    [7:0] nds_unused_hart0_trace_itype;
wire                                    [1:0] nds_unused_hart0_trace_priv;
wire                                          nds_unused_hart0_trace_reset;
wire                                    [5:0] nds_unused_hart0_trace_trigger;
wire                      [((`NDS_XLEN)-1):0] nds_unused_hart0_trace_tval;
   `endif

`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
wire                       [(ADDR_WIDTH-1):0] dmac1_araddr;
wire                                    [1:0] dmac1_arburst;
wire                                    [3:0] dmac1_arcache;
wire                     [(BIU_ID_WIDTH-1):0] dmac1_arid;
wire                                    [7:0] dmac1_arlen;
wire                                          dmac1_arlock;
wire                                    [2:0] dmac1_arprot;
wire                                    [2:0] dmac1_arsize;
wire                                          dmac1_arvalid;
wire                       [(ADDR_WIDTH-1):0] dmac1_awaddr;
wire                                    [1:0] dmac1_awburst;
wire                                    [3:0] dmac1_awcache;
wire                     [(BIU_ID_WIDTH-1):0] dmac1_awid;
wire                                    [7:0] dmac1_awlen;
wire                                          dmac1_awlock;
wire                                    [2:0] dmac1_awprot;
wire                                    [2:0] dmac1_awsize;
wire                                          dmac1_awvalid;
wire                                          dmac1_bready;
wire                                          dmac1_rready;
wire                  [(DMAC_DATA_WIDTH-1):0] dmac1_wdata;
wire                                          dmac1_wlast;
wire              [((DMAC_DATA_WIDTH/8)-1):0] dmac1_wstrb;
wire                                          dmac1_wvalid;
wire                                          dmac1_arready;
wire                                          dmac1_awready;
wire                     [(BIU_ID_WIDTH-1):0] dmac1_bid;
wire                                    [1:0] dmac1_bresp;
wire                                          dmac1_bvalid;
wire                  [(DMAC_DATA_WIDTH-1):0] dmac1_rdata;
wire                     [(BIU_ID_WIDTH-1):0] dmac1_rid;
wire                                          dmac1_rlast;
wire                                    [1:0] dmac1_rresp;
wire                                          dmac1_rvalid;
wire                                          dmac1_wready;
   `endif
`endif
   `ifdef NDS_IO_BIU_AXI_COMMON_X2
wire                                          cpu_d_arready;
wire                                          cpu_d_awready;
wire                     [(BIU_ID_WIDTH-1):0] cpu_d_bid;
wire                                    [1:0] cpu_d_bresp;
wire                                          cpu_d_bvalid;
wire                   [(BIU_DATA_WIDTH-1):0] cpu_d_rdata;
wire                     [(BIU_ID_WIDTH-1):0] cpu_d_rid;
wire                                          cpu_d_rlast;
wire                                    [1:0] cpu_d_rresp;
wire                                          cpu_d_rvalid;
wire                                          cpu_d_wready;
wire                                          cpu_i_arready;
wire                                          cpu_i_awready;
wire                     [(BIU_ID_WIDTH-1):0] cpu_i_bid;
wire                                    [1:0] cpu_i_bresp;
wire                                          cpu_i_bvalid;
wire                   [(BIU_DATA_WIDTH-1):0] cpu_i_rdata;
wire                     [(BIU_ID_WIDTH-1):0] cpu_i_rid;
wire                                          cpu_i_rlast;
wire                                    [1:0] cpu_i_rresp;
wire                                          cpu_i_rvalid;
wire                                          cpu_i_wready;
wire                       [(ADDR_WIDTH-1):0] cpu_d_araddr;
wire                                    [1:0] cpu_d_arburst;
wire                                    [3:0] cpu_d_arcache;
wire                     [(BIU_ID_WIDTH-1):0] cpu_d_arid;
wire                                    [7:0] cpu_d_arlen;
wire                                          cpu_d_arlock;
wire                                    [2:0] cpu_d_arprot;
wire                                    [2:0] cpu_d_arsize;
wire                                          cpu_d_arvalid;
wire                       [(ADDR_WIDTH-1):0] cpu_d_awaddr;
wire                                    [1:0] cpu_d_awburst;
wire                                    [3:0] cpu_d_awcache;
wire                     [(BIU_ID_WIDTH-1):0] cpu_d_awid;
wire                                    [7:0] cpu_d_awlen;
wire                                          cpu_d_awlock;
wire                                    [2:0] cpu_d_awprot;
wire                                    [2:0] cpu_d_awsize;
wire                                          cpu_d_awvalid;
wire                                          cpu_d_bready;
wire                                          cpu_d_rready;
wire                   [(BIU_DATA_WIDTH-1):0] cpu_d_wdata;
wire                                          cpu_d_wlast;
wire                  [(BIU_WSTRB_WIDTH-1):0] cpu_d_wstrb;
wire                                          cpu_d_wvalid;
wire                       [(ADDR_WIDTH-1):0] cpu_i_araddr;
wire                                    [1:0] cpu_i_arburst;
wire                                    [3:0] cpu_i_arcache;
wire                     [(BIU_ID_WIDTH-1):0] cpu_i_arid;
wire                                    [7:0] cpu_i_arlen;
wire                                          cpu_i_arlock;
wire                                    [2:0] cpu_i_arprot;
wire                                    [2:0] cpu_i_arsize;
wire                                          cpu_i_arvalid;
wire                       [(ADDR_WIDTH-1):0] cpu_i_awaddr;
wire                                    [1:0] cpu_i_awburst;
wire                                    [3:0] cpu_i_awcache;
wire                     [(BIU_ID_WIDTH-1):0] cpu_i_awid;
wire                                    [7:0] cpu_i_awlen;
wire                                          cpu_i_awlock;
wire                                    [2:0] cpu_i_awprot;
wire                                    [2:0] cpu_i_awsize;
wire                                          cpu_i_awvalid;
wire                                          cpu_i_bready;
wire                                          cpu_i_rready;
wire                   [(BIU_DATA_WIDTH-1):0] cpu_i_wdata;
wire                                          cpu_i_wlast;
wire                  [(BIU_WSTRB_WIDTH-1):0] cpu_i_wstrb;
wire                                          cpu_i_wvalid;
   `else
wire                                          cpu_arready;
wire                                          cpu_awready;
wire                     [(BIU_ID_WIDTH-1):0] cpu_bid;
wire                                    [1:0] cpu_bresp;
wire                                          cpu_bvalid;
wire                   [(BIU_DATA_WIDTH-1):0] cpu_rdata;
wire                     [(BIU_ID_WIDTH-1):0] cpu_rid;
wire                                          cpu_rlast;
wire                                    [1:0] cpu_rresp;
wire                                          cpu_rvalid;
wire                                          cpu_wready;
wire                       [(ADDR_WIDTH-1):0] cpu_araddr;
wire                                    [1:0] cpu_arburst;
wire                                    [3:0] cpu_arcache;
wire                     [(BIU_ID_WIDTH-1):0] cpu_arid;
wire                                    [7:0] cpu_arlen;
wire                                          cpu_arlock;
wire                                    [2:0] cpu_arprot;
wire                                    [2:0] cpu_arsize;
wire                                          cpu_arvalid;
wire                       [(ADDR_WIDTH-1):0] cpu_awaddr;
wire                                    [1:0] cpu_awburst;
wire                                    [3:0] cpu_awcache;
wire                     [(BIU_ID_WIDTH-1):0] cpu_awid;
wire                                    [7:0] cpu_awlen;
wire                                          cpu_awlock;
wire                                    [2:0] cpu_awprot;
wire                                    [2:0] cpu_awsize;
wire                                          cpu_awvalid;
wire                                          cpu_bready;
wire                                          cpu_rready;
wire                   [(BIU_DATA_WIDTH-1):0] cpu_wdata;
wire                                          cpu_wlast;
wire                  [(BIU_WSTRB_WIDTH-1):0] cpu_wstrb;
wire                                          cpu_wvalid;
   `endif

`ifdef PLATFORM_JTAG_TWOWIRE
`else
   `ifdef PLATFORM_DEBUG_PORT
wire                                          nds_unused_pin_tdo_in;
   `endif
`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
wire                                  [127:0] secure_code;
wire                                    [1:0] secure_mode;
wire                                    [1:0] T_secure_mode;
   `endif
`endif
`ifdef AE350_PIT_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
wire                                          ch1_pwm;
wire                                          ch1_pwmoe;
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
wire                                          ch2_pwm;
wire                                          ch2_pwmoe;
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
wire                                          ch3_pwm;
wire                                          ch3_pwmoe;
   `endif
`endif
`ifdef AE350_GPIO_SUPPORT
   `ifdef ATCGPIO100_PULL_SUPPORT
wire                                   [31:0] gpio_pulldown;
wire                                   [31:0] gpio_pullup;
   `endif
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
wire           [(`ATCSPI200_HADDR_WIDTH-1):0] spi_mem_haddr;
wire                                          spi_mem_hready;
wire                                    [1:0] spi_mem_htrans;
wire                                          spi_mem_hwrite;
   `endif
   `ifdef ATCSPI200_QUADSPI_SUPPORT
wire                                          spi1_holdn_oe;
wire                                          spi1_holdn_out;
wire                                          spi1_wpn_oe;
wire                                          spi1_wpn_out;
wire                                          spi1_holdn_in;
wire                                          spi1_wpn_in;
   `endif
`endif
`ifdef AE350_SPI2_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
wire                                          spi2_holdn_oe;
wire                                          spi2_holdn_out;
wire                                          spi2_wpn_oe;
wire                                          spi2_wpn_out;
wire                                          spi2_holdn_in;
wire                                          spi2_wpn_in;
   `endif
`endif

`ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
   `ifdef PLATFORM_DEBUG_SUBSYSTEM
wire                                          dm_sys_arready;
wire                                          dm_sys_awready;
wire                     [(BIU_ID_WIDTH-1):0] dm_sys_bid;
wire                                    [1:0] dm_sys_bresp;
wire                                          dm_sys_bvalid;
wire                   [(BIU_DATA_WIDTH-1):0] dm_sys_rdata;
wire                     [(BIU_ID_WIDTH-1):0] dm_sys_rid;
wire                                          dm_sys_rlast;
wire                                    [1:0] dm_sys_rresp;
wire                                          dm_sys_rvalid;
wire                                          dm_sys_wready;
wire                       [(ADDR_WIDTH-1):0] dm_sys_araddr;
wire                                    [1:0] dm_sys_arburst;
wire                                    [3:0] dm_sys_arcache;
wire                     [(BIU_ID_WIDTH-1):0] dm_sys_arid;
wire                                    [7:0] dm_sys_arlen;
wire                                          dm_sys_arlock;
wire                                    [2:0] dm_sys_arprot;
wire                                    [2:0] dm_sys_arsize;
wire                                          dm_sys_arvalid;
wire                       [(ADDR_WIDTH-1):0] dm_sys_awaddr;
wire                                    [1:0] dm_sys_awburst;
wire                                    [3:0] dm_sys_awcache;
wire                     [(BIU_ID_WIDTH-1):0] dm_sys_awid;
wire                                    [7:0] dm_sys_awlen;
wire                                          dm_sys_awlock;
wire                                    [2:0] dm_sys_awprot;
wire                                    [2:0] dm_sys_awsize;
wire                                          dm_sys_awvalid;
wire                                          dm_sys_bready;
wire                                          dm_sys_rready;
wire                   [(BIU_DATA_WIDTH-1):0] dm_sys_wdata;
wire                                          dm_sys_wlast;
wire                  [(BIU_WSTRB_WIDTH-1):0] dm_sys_wstrb;
wire                                          dm_sys_wvalid;
   `endif
`endif
`ifdef NDS_IO_L2C
`endif
`ifdef NDS_FPGA
   
wire                                    [3:0] ddr3_latency;

`endif



wire               [`ATCAPBBRG100_ADDR_MSB:0] ahb2apb_haddr;
wire                                    [3:0] ahb2apb_hprot;
wire                                          ahb2apb_hready_in;
wire                                          ahb2apb_hsel;
wire                                    [2:0] ahb2apb_hsize;
wire                                    [1:0] ahb2apb_htrans;
wire                                   [31:0] ahb2apb_hwdata;
wire                                          ahb2apb_hwrite;
wire         [(`ATCBUSDEC200_DATA_WIDTH-1):0] hbmc_hrdata;
wire                                          hbmc_hreadyout;
wire                                    [1:0] hbmc_hresp;
wire                                          lcd_intr;
wire                                          mac_int;
wire                                          aclk;
wire                                          ahb2core_clken;
wire                                          apb2ahb_clken;
wire                                          apb2core_clken;
wire                                          aresetn;
wire                                          axi2core_clken;
wire                                          cluster_iso_on;
wire                                          cluster_pwr_on;
wire                            [(NHART-1):0] core_clk;
wire                            [(NHART-1):0] core_l2_resetn;
wire                               [64*8-1:0] core_reset_vectors;
wire                            [(NHART-1):0] core_resetn;
wire                            [(NHART-1):0] dc_clk;
wire                                          extclk;
wire                                          hart0_dcache_disable_init;
wire                                          hart0_icache_disable_init;
wire                                          hclk;
wire                                          hresetn;
wire                                   [31:1] int_src;
wire                                          l2_clk;
wire                                          l2_resetn;
wire                            [(NHART-1):0] lm_clk;
wire                                          pclk;
wire                                          pclk_gpio;
wire                                          pclk_i2c;
wire                                          pclk_pit;
wire                                          pclk_spi1;
wire                                          pclk_spi2;
wire                                          pclk_uart1;
wire                                          pclk_uart2;
wire                                          pclk_wdt;
wire                                          pcs0_iso;
wire                                          pcs10_iso;
wire                                          pcs1_iso;
wire                                          pcs2_iso;
wire                                          pcs3_iso;
wire                                          pcs4_iso;
wire                                          pcs5_iso;
wire                                          pcs6_iso;
wire                                          pcs7_iso;
wire                                          pcs8_iso;
wire                                          pcs9_iso;
wire                                          pd0_vol_on;
wire                                          pd10_vol_on;
wire                                          pd1_vol_on;
wire                                          pd2_vol_on;
wire                                          pd3_vol_on;
wire                                          pd4_vol_on;
wire                                          pd5_vol_on;
wire                                          pd6_vol_on;
wire                                          pd7_vol_on;
wire                                          pd8_vol_on;
wire                                          pd9_vol_on;
wire                                          por_rstn;
wire                                          presetn;
wire                                          scan_enable;
wire                                          scan_test;
wire                                          sdc_clk;
wire                            [(NHART-1):0] slvp_resetn;
wire                                   [31:0] smu_prdata;
wire                                          smu_pready;
wire                                          smu_pslverr;
wire                                          spi_clk;
wire                                          spi_rstn;
wire                                          test_mode;
wire                                          test_rstn;
wire                                          uart_clk;
wire                                          uart_rstn;
wire                                   [31:0] ahb2apb_hrdata;
wire                                          ahb2apb_hready;
wire                                    [1:0] ahb2apb_hresp;
wire                                          dma_int;
wire                                          gpio_intr;
wire                                          i2c_int;
wire               [`ATCAPBBRG100_ADDR_MSB:0] paddr;
wire                                          penable;
wire                                          pit_intr;
wire                                   [31:0] pwdata;
wire                                          pwrite;
wire                                          sdc_int;
wire                                          smu_psel;
wire                                          spi1_int;
wire                                          spi2_int;
wire                                          ssp_intr;
wire                                          uart1_int;
wire                                          uart2_int;
wire                                          wdt_int;
wire                                          wdt_rst;
wire                             [ADDR_MSB:0] hbmc_haddr;
wire                                    [2:0] hbmc_hburst;
wire                                    [3:0] hbmc_hprot;
wire                                          hbmc_hready;
wire                                          hbmc_hsel;
wire                                    [2:0] hbmc_hsize;
wire                                    [1:0] hbmc_htrans;
wire                                   [31:0] hbmc_hwdata;
wire                                          hbmc_hwrite;
wire                       [(ADDR_WIDTH-1):0] ram_araddr;
wire                                    [1:0] ram_arburst;
wire                                    [3:0] ram_arcache;
wire                   [(BIU_ID_WIDTH-1)+4:0] ram_arid;
wire                                    [7:0] ram_arlen;
wire                                          ram_arlock;
wire                                    [2:0] ram_arprot;
wire                                    [2:0] ram_arsize;
wire                                          ram_arvalid;
wire                       [(ADDR_WIDTH-1):0] ram_awaddr;
wire                                    [1:0] ram_awburst;
wire                                    [3:0] ram_awcache;
wire                   [(BIU_ID_WIDTH-1)+4:0] ram_awid;
wire                                    [7:0] ram_awlen;
wire                                          ram_awlock;
wire                                    [2:0] ram_awprot;
wire                                    [2:0] ram_awsize;
wire                                          ram_awvalid;
wire                                          ram_bready;
wire                                          ram_rready;
wire                   [(BIU_DATA_WIDTH-1):0] ram_wdata;
wire                                          ram_wlast;
wire                  [(BIU_WSTRB_WIDTH-1):0] ram_wstrb;
wire                                          ram_wvalid;
wire                             [ADDR_MSB:0] rom_haddr;
wire                                    [2:0] rom_hburst;
wire                                    [3:0] rom_hprot;
wire                                          rom_hready;
wire                                          rom_hsel;
wire                                    [2:0] rom_hsize;
wire                                    [1:0] rom_htrans;
wire                                   [31:0] rom_hwdata;
wire                                          rom_hwrite;
wire                                          dbg_srst_req;
wire                                          hart0_core_wfi_mode;
wire                                    [5:0] hart0_wakeup_event;
wire                                          T_hw_rstn;
wire                                          T_osch;
wire                                          T_por_b;
wire                                          init_calib_complete;
wire                                          ram_arready;
wire                                          ram_awready;
wire                   [(BIU_ID_WIDTH-1)+4:0] ram_bid;
wire                                    [1:0] ram_bresp;
wire                                          ram_bvalid;
wire                   [(BIU_DATA_WIDTH-1):0] ram_rdata;
wire                   [(BIU_ID_WIDTH-1)+4:0] ram_rid;
wire                                          ram_rlast;
wire                                    [1:0] ram_rresp;
wire                                          ram_rvalid;
wire                                          ram_wready;
wire                                          ui_clk;
wire                                   [31:0] rom_hrdata;
wire                                          rom_hreadyout;
wire                                          rom_hresp;

`ifdef NDS_FPGA
`else
	`ifdef NDS_IO_PROBING
		assign hart0_probe_gpr_index = 13'b0;
	`endif
`endif
`ifdef AE350_SPI1_SUPPORT
       assign spi_mem_haddr	= rom_haddr[31:0];
       assign spi_mem_hwrite	= rom_hwrite;
       assign spi_mem_htrans 	= rom_htrans;
       assign spi_mem_hsel 	= 1'b1;
       assign spi_mem_hready	= spi_mem_hreadyout;

       assign rom_hrdata		= spi_mem_hrdata;
       assign rom_hresp 		= spi_mem_hresp[0];
       assign rom_hreadyout	= spi_mem_hreadyout;

`else
       assign smc_mem_hsel 	= 1'b1;
       assign smc_mem_hready 	= 1'b1;
       assign rom_hreadyout	= 1'b0;
       assign rom_hresp  		= 1'b0;
       assign rom_hrdata 		= 32'd0;

`endif
`ifdef NDS_IO_L2C
`endif
wire	unused_wire;
assign unused_wire = pcs0_iso | pcs1_iso | pcs2_iso | pcs3_iso | pcs4_iso | pcs5_iso | pcs6_iso | pcs7_iso | pcs8_iso | pcs9_iso | pcs10_iso
			| pd0_vol_on | pd1_vol_on| pd2_vol_on | pd3_vol_on | pd4_vol_on | pd5_vol_on | pd6_vol_on | pd7_vol_on | pd8_vol_on | pd9_vol_on | pd10_vol_on;
`ifdef PLATFORM_DEBUG_PORT
	`ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
		assign secure_mode = T_secure_mode;
		assign secure_code = 128'h52495343_2d564041_6e646573_54656368;
	`endif
`endif
`ifdef PLATFORM_DEBUG_PORT
    `ifdef PLATFORM_JTAG_TWOWIRE
            assign pin_tdi_in  = 1'b0;
            assign pin_trst_in = 1'b0;
    `endif
`endif

ae350_bus_connector ae350_bus_connector (
`ifdef AE350_DMA_AXI_SUPPORT
	.dmac0_araddr       (dmac0_araddr       ),
	.dmac0_arburst      (dmac0_arburst      ),
	.dmac0_arcache      (dmac0_arcache      ),
	.dmac0_arid         (dmac0_arid         ),
	.dmac0_arlen        (dmac0_arlen        ),
	.dmac0_arlock       (dmac0_arlock       ),
	.dmac0_arprot       (dmac0_arprot       ),
	.dmac0_arready      (dmac0_arready      ),
	.dmac0_arsize       (dmac0_arsize       ),
	.dmac0_arvalid      (dmac0_arvalid      ),
	.dmac0_awaddr       (dmac0_awaddr       ),
	.dmac0_awburst      (dmac0_awburst      ),
	.dmac0_awcache      (dmac0_awcache      ),
	.dmac0_awid         (dmac0_awid         ),
	.dmac0_awlen        (dmac0_awlen        ),
	.dmac0_awlock       (dmac0_awlock       ),
	.dmac0_awprot       (dmac0_awprot       ),
	.dmac0_awready      (dmac0_awready      ),
	.dmac0_awsize       (dmac0_awsize       ),
	.dmac0_awvalid      (dmac0_awvalid      ),
	.dmac0_bid          (dmac0_bid          ),
	.dmac0_bready       (dmac0_bready       ),
	.dmac0_bresp        (dmac0_bresp        ),
	.dmac0_bvalid       (dmac0_bvalid       ),
	.dmac0_rdata        (dmac0_rdata        ),
	.dmac0_rid          (dmac0_rid          ),
	.dmac0_rlast        (dmac0_rlast        ),
	.dmac0_rready       (dmac0_rready       ),
	.dmac0_rresp        (dmac0_rresp        ),
	.dmac0_rvalid       (dmac0_rvalid       ),
	.dmac0_wdata        (dmac0_wdata        ),
	.dmac0_wlast        (dmac0_wlast        ),
	.dmac0_wready       (dmac0_wready       ),
	.dmac0_wstrb        (dmac0_wstrb        ),
	.dmac0_wvalid       (dmac0_wvalid       ),
`endif
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
	.cpuslv_arid        (cpuslv_arid        ),
	.cpuslv_awid        (cpuslv_awid        ),
	.cpuslv_bid         (cpuslv_bid         ),
	.cpuslv_rid         (cpuslv_rid         ),
	.cpuslv_araddr      (cpuslv_araddr      ),
	.cpuslv_arburst     (cpuslv_arburst     ),
	.cpuslv_arcache     (cpuslv_arcache     ),
	.cpuslv_arlen       (cpuslv_arlen       ),
	.cpuslv_arlock      (cpuslv_arlock      ),
	.cpuslv_arprot      (cpuslv_arprot      ),
	.cpuslv_arready     (cpuslv_arready     ),
	.cpuslv_arsize      (cpuslv_arsize      ),
	.cpuslv_arvalid     (cpuslv_arvalid     ),
	.cpuslv_awaddr      (cpuslv_awaddr      ),
	.cpuslv_awburst     (cpuslv_awburst     ),
	.cpuslv_awcache     (cpuslv_awcache     ),
	.cpuslv_awlen       (cpuslv_awlen       ),
	.cpuslv_awlock      (cpuslv_awlock      ),
	.cpuslv_awprot      (cpuslv_awprot      ),
	.cpuslv_awready     (cpuslv_awready     ),
	.cpuslv_awsize      (cpuslv_awsize      ),
	.cpuslv_awvalid     (cpuslv_awvalid     ),
	.cpuslv_bready      (cpuslv_bready      ),
	.cpuslv_bresp       (cpuslv_bresp       ),
	.cpuslv_bvalid      (cpuslv_bvalid      ),
	.cpuslv_rdata       (cpuslv_rdata       ),
	.cpuslv_rlast       (cpuslv_rlast       ),
	.cpuslv_rready      (cpuslv_rready      ),
	.cpuslv_rresp       (cpuslv_rresp       ),
	.cpuslv_rvalid      (cpuslv_rvalid      ),
	.cpuslv_wdata       (cpuslv_wdata       ),
	.cpuslv_wlast       (cpuslv_wlast       ),
	.cpuslv_wready      (cpuslv_wready      ),
	.cpuslv_wstrb       (cpuslv_wstrb       ),
	.cpuslv_wvalid      (cpuslv_wvalid      ),
`endif
`ifdef NDS_IO_COHERENCE
	.iocp0_arcache      (iocp0_arcache      ),
	.iocp0_awcache      (iocp0_awcache      ),
	.iocp0_araddr       (iocp0_araddr       ),
	.iocp0_arburst      (iocp0_arburst      ),
	.iocp0_arid         (iocp0_arid         ),
	.iocp0_arlen        (iocp0_arlen        ),
	.iocp0_arlock       (iocp0_arlock       ),
	.iocp0_arprot       (iocp0_arprot       ),
	.iocp0_arready      (iocp0_arready      ),
	.iocp0_arsize       (iocp0_arsize       ),
	.iocp0_arvalid      (iocp0_arvalid      ),
	.iocp0_awaddr       (iocp0_awaddr       ),
	.iocp0_awburst      (iocp0_awburst      ),
	.iocp0_awid         (iocp0_awid         ),
	.iocp0_awlen        (iocp0_awlen        ),
	.iocp0_awlock       (iocp0_awlock       ),
	.iocp0_awprot       (iocp0_awprot       ),
	.iocp0_awready      (iocp0_awready      ),
	.iocp0_awsize       (iocp0_awsize       ),
	.iocp0_awvalid      (iocp0_awvalid      ),
	.iocp0_bid          (iocp0_bid          ),
	.iocp0_bready       (iocp0_bready       ),
	.iocp0_bresp        (iocp0_bresp        ),
	.iocp0_bvalid       (iocp0_bvalid       ),
	.iocp0_rdata        (iocp0_rdata        ),
	.iocp0_rid          (iocp0_rid          ),
	.iocp0_rlast        (iocp0_rlast        ),
	.iocp0_rready       (iocp0_rready       ),
	.iocp0_rresp        (iocp0_rresp        ),
	.iocp0_rvalid       (iocp0_rvalid       ),
	.iocp0_wdata        (iocp0_wdata        ),
	.iocp0_wlast        (iocp0_wlast        ),
	.iocp0_wready       (iocp0_wready       ),
	.iocp0_wstrb        (iocp0_wstrb        ),
	.iocp0_wvalid       (iocp0_wvalid       ),
`endif
   `ifdef NDS_IO_BIU_AXI_COMMON_X2
	.cpu_d_araddr       (cpu_d_araddr       ),
	.cpu_d_arburst      (cpu_d_arburst      ),
	.cpu_d_arcache      (cpu_d_arcache      ),
	.cpu_d_arid         (cpu_d_arid         ),
	.cpu_d_arlen        (cpu_d_arlen        ),
	.cpu_d_arlock       (cpu_d_arlock       ),
	.cpu_d_arprot       (cpu_d_arprot       ),
	.cpu_d_arready      (cpu_d_arready      ),
	.cpu_d_arsize       (cpu_d_arsize       ),
	.cpu_d_arvalid      (cpu_d_arvalid      ),
	.cpu_d_awaddr       (cpu_d_awaddr       ),
	.cpu_d_awburst      (cpu_d_awburst      ),
	.cpu_d_awcache      (cpu_d_awcache      ),
	.cpu_d_awid         (cpu_d_awid         ),
	.cpu_d_awlen        (cpu_d_awlen        ),
	.cpu_d_awlock       (cpu_d_awlock       ),
	.cpu_d_awprot       (cpu_d_awprot       ),
	.cpu_d_awready      (cpu_d_awready      ),
	.cpu_d_awsize       (cpu_d_awsize       ),
	.cpu_d_awvalid      (cpu_d_awvalid      ),
	.cpu_d_bid          (cpu_d_bid          ),
	.cpu_d_bready       (cpu_d_bready       ),
	.cpu_d_bresp        (cpu_d_bresp        ),
	.cpu_d_bvalid       (cpu_d_bvalid       ),
	.cpu_d_rdata        (cpu_d_rdata        ),
	.cpu_d_rid          (cpu_d_rid          ),
	.cpu_d_rlast        (cpu_d_rlast        ),
	.cpu_d_rready       (cpu_d_rready       ),
	.cpu_d_rresp        (cpu_d_rresp        ),
	.cpu_d_rvalid       (cpu_d_rvalid       ),
	.cpu_d_wdata        (cpu_d_wdata        ),
	.cpu_d_wlast        (cpu_d_wlast        ),
	.cpu_d_wready       (cpu_d_wready       ),
	.cpu_d_wstrb        (cpu_d_wstrb        ),
	.cpu_d_wvalid       (cpu_d_wvalid       ),
	.cpu_i_araddr       (cpu_i_araddr       ),
	.cpu_i_arburst      (cpu_i_arburst      ),
	.cpu_i_arcache      (cpu_i_arcache      ),
	.cpu_i_arid         (cpu_i_arid         ),
	.cpu_i_arlen        (cpu_i_arlen        ),
	.cpu_i_arlock       (cpu_i_arlock       ),
	.cpu_i_arprot       (cpu_i_arprot       ),
	.cpu_i_arready      (cpu_i_arready      ),
	.cpu_i_arsize       (cpu_i_arsize       ),
	.cpu_i_arvalid      (cpu_i_arvalid      ),
	.cpu_i_awaddr       (cpu_i_awaddr       ),
	.cpu_i_awburst      (cpu_i_awburst      ),
	.cpu_i_awcache      (cpu_i_awcache      ),
	.cpu_i_awid         (cpu_i_awid         ),
	.cpu_i_awlen        (cpu_i_awlen        ),
	.cpu_i_awlock       (cpu_i_awlock       ),
	.cpu_i_awprot       (cpu_i_awprot       ),
	.cpu_i_awready      (cpu_i_awready      ),
	.cpu_i_awsize       (cpu_i_awsize       ),
	.cpu_i_awvalid      (cpu_i_awvalid      ),
	.cpu_i_bid          (cpu_i_bid          ),
	.cpu_i_bready       (cpu_i_bready       ),
	.cpu_i_bresp        (cpu_i_bresp        ),
	.cpu_i_bvalid       (cpu_i_bvalid       ),
	.cpu_i_rdata        (cpu_i_rdata        ),
	.cpu_i_rid          (cpu_i_rid          ),
	.cpu_i_rlast        (cpu_i_rlast        ),
	.cpu_i_rready       (cpu_i_rready       ),
	.cpu_i_rresp        (cpu_i_rresp        ),
	.cpu_i_rvalid       (cpu_i_rvalid       ),
	.cpu_i_wdata        (cpu_i_wdata        ),
	.cpu_i_wlast        (cpu_i_wlast        ),
	.cpu_i_wready       (cpu_i_wready       ),
	.cpu_i_wstrb        (cpu_i_wstrb        ),
	.cpu_i_wvalid       (cpu_i_wvalid       ),
   `else
	.cpu_araddr         (cpu_araddr         ),
	.cpu_arburst        (cpu_arburst        ),
	.cpu_arcache        (cpu_arcache        ),
	.cpu_arid           (cpu_arid           ),
	.cpu_arlen          (cpu_arlen          ),
	.cpu_arlock         (cpu_arlock         ),
	.cpu_arprot         (cpu_arprot         ),
	.cpu_arready        (cpu_arready        ),
	.cpu_arsize         (cpu_arsize         ),
	.cpu_arvalid        (cpu_arvalid        ),
	.cpu_awaddr         (cpu_awaddr         ),
	.cpu_awburst        (cpu_awburst        ),
	.cpu_awcache        (cpu_awcache        ),
	.cpu_awid           (cpu_awid           ),
	.cpu_awlen          (cpu_awlen          ),
	.cpu_awlock         (cpu_awlock         ),
	.cpu_awprot         (cpu_awprot         ),
	.cpu_awready        (cpu_awready        ),
	.cpu_awsize         (cpu_awsize         ),
	.cpu_awvalid        (cpu_awvalid        ),
	.cpu_bid            (cpu_bid            ),
	.cpu_bready         (cpu_bready         ),
	.cpu_bresp          (cpu_bresp          ),
	.cpu_bvalid         (cpu_bvalid         ),
	.cpu_rdata          (cpu_rdata          ),
	.cpu_rid            (cpu_rid            ),
	.cpu_rlast          (cpu_rlast          ),
	.cpu_rready         (cpu_rready         ),
	.cpu_rresp          (cpu_rresp          ),
	.cpu_rvalid         (cpu_rvalid         ),
	.cpu_wdata          (cpu_wdata          ),
	.cpu_wlast          (cpu_wlast          ),
	.cpu_wready         (cpu_wready         ),
	.cpu_wstrb          (cpu_wstrb          ),
	.cpu_wvalid         (cpu_wvalid         ),
   `endif

`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dmac1_araddr       (dmac1_araddr       ),
	.dmac1_arburst      (dmac1_arburst      ),
	.dmac1_arcache      (dmac1_arcache      ),
	.dmac1_arid         (dmac1_arid         ),
	.dmac1_arlen        (dmac1_arlen        ),
	.dmac1_arlock       (dmac1_arlock       ),
	.dmac1_arprot       (dmac1_arprot       ),
	.dmac1_arready      (dmac1_arready      ),
	.dmac1_arsize       (dmac1_arsize       ),
	.dmac1_arvalid      (dmac1_arvalid      ),
	.dmac1_awaddr       (dmac1_awaddr       ),
	.dmac1_awburst      (dmac1_awburst      ),
	.dmac1_awcache      (dmac1_awcache      ),
	.dmac1_awid         (dmac1_awid         ),
	.dmac1_awlen        (dmac1_awlen        ),
	.dmac1_awlock       (dmac1_awlock       ),
	.dmac1_awprot       (dmac1_awprot       ),
	.dmac1_awready      (dmac1_awready      ),
	.dmac1_awsize       (dmac1_awsize       ),
	.dmac1_awvalid      (dmac1_awvalid      ),
	.dmac1_bid          (dmac1_bid          ),
	.dmac1_bready       (dmac1_bready       ),
	.dmac1_bresp        (dmac1_bresp        ),
	.dmac1_bvalid       (dmac1_bvalid       ),
	.dmac1_rdata        (dmac1_rdata        ),
	.dmac1_rid          (dmac1_rid          ),
	.dmac1_rlast        (dmac1_rlast        ),
	.dmac1_rready       (dmac1_rready       ),
	.dmac1_rresp        (dmac1_rresp        ),
	.dmac1_rvalid       (dmac1_rvalid       ),
	.dmac1_wdata        (dmac1_wdata        ),
	.dmac1_wlast        (dmac1_wlast        ),
	.dmac1_wready       (dmac1_wready       ),
	.dmac1_wstrb        (dmac1_wstrb        ),
	.dmac1_wvalid       (dmac1_wvalid       ),
   `endif
`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
	.dm_sys_araddr      (dm_sys_araddr      ),
	.dm_sys_arburst     (dm_sys_arburst     ),
	.dm_sys_arcache     (dm_sys_arcache     ),
	.dm_sys_arid        (dm_sys_arid        ),
	.dm_sys_arlen       (dm_sys_arlen       ),
	.dm_sys_arlock      (dm_sys_arlock      ),
	.dm_sys_arprot      (dm_sys_arprot      ),
	.dm_sys_arready     (dm_sys_arready     ),
	.dm_sys_arsize      (dm_sys_arsize      ),
	.dm_sys_arvalid     (dm_sys_arvalid     ),
	.dm_sys_awaddr      (dm_sys_awaddr      ),
	.dm_sys_awburst     (dm_sys_awburst     ),
	.dm_sys_awcache     (dm_sys_awcache     ),
	.dm_sys_awid        (dm_sys_awid        ),
	.dm_sys_awlen       (dm_sys_awlen       ),
	.dm_sys_awlock      (dm_sys_awlock      ),
	.dm_sys_awprot      (dm_sys_awprot      ),
	.dm_sys_awready     (dm_sys_awready     ),
	.dm_sys_awsize      (dm_sys_awsize      ),
	.dm_sys_awvalid     (dm_sys_awvalid     ),
	.dm_sys_bid         (dm_sys_bid         ),
	.dm_sys_bready      (dm_sys_bready      ),
	.dm_sys_bresp       (dm_sys_bresp       ),
	.dm_sys_bvalid      (dm_sys_bvalid      ),
	.dm_sys_rdata       (dm_sys_rdata       ),
	.dm_sys_rid         (dm_sys_rid         ),
	.dm_sys_rlast       (dm_sys_rlast       ),
	.dm_sys_rready      (dm_sys_rready      ),
	.dm_sys_rresp       (dm_sys_rresp       ),
	.dm_sys_rvalid      (dm_sys_rvalid      ),
	.dm_sys_wdata       (dm_sys_wdata       ),
	.dm_sys_wlast       (dm_sys_wlast       ),
	.dm_sys_wready      (dm_sys_wready      ),
	.dm_sys_wstrb       (dm_sys_wstrb       ),
	.dm_sys_wvalid      (dm_sys_wvalid      ),
   `endif
`endif
	.hbmc_haddr         (hbmc_haddr         ),
	.hbmc_hburst        (hbmc_hburst        ),
	.hbmc_hprot         (hbmc_hprot         ),
	.hbmc_hrdata        (hbmc_hrdata        ),
	.hbmc_hready        (hbmc_hready        ),
	.hbmc_hreadyout     (hbmc_hreadyout     ),
	.hbmc_hresp         (hbmc_hresp         ),
	.hbmc_hsel          (hbmc_hsel          ),
	.hbmc_hsize         (hbmc_hsize         ),
	.hbmc_htrans        (hbmc_htrans        ),
	.hbmc_hwdata        (hbmc_hwdata        ),
	.hbmc_hwrite        (hbmc_hwrite        ),
	.rom_haddr          (rom_haddr          ),
	.rom_hburst         (rom_hburst         ),
	.rom_hprot          (rom_hprot          ),
	.rom_hrdata         (rom_hrdata         ),
	.rom_hready         (rom_hready         ),
	.rom_hreadyout      (rom_hreadyout      ),
	.rom_hresp          (rom_hresp          ),
	.rom_hsel           (rom_hsel           ),
	.rom_hsize          (rom_hsize          ),
	.rom_htrans         (rom_htrans         ),
	.rom_hwdata         (rom_hwdata         ),
	.rom_hwrite         (rom_hwrite         ),
	.hclk               (hclk               ),
	.hresetn            (hresetn            ),
	.aclk               (aclk               ),
	.aresetn            (aresetn            ),
	.ram_araddr         (ram_araddr         ),
	.ram_arburst        (ram_arburst        ),
	.ram_arcache        (ram_arcache        ),
	.ram_arid           (ram_arid           ),
	.ram_arlen          (ram_arlen          ),
	.ram_arlock         (ram_arlock         ),
	.ram_arprot         (ram_arprot         ),
	.ram_arready        (ram_arready        ),
	.ram_arsize         (ram_arsize         ),
	.ram_arvalid        (ram_arvalid        ),
	.ram_awaddr         (ram_awaddr         ),
	.ram_awburst        (ram_awburst        ),
	.ram_awcache        (ram_awcache        ),
	.ram_awid           (ram_awid           ),
	.ram_awlen          (ram_awlen          ),
	.ram_awlock         (ram_awlock         ),
	.ram_awprot         (ram_awprot         ),
	.ram_awready        (ram_awready        ),
	.ram_awsize         (ram_awsize         ),
	.ram_awvalid        (ram_awvalid        ),
	.ram_bid            (ram_bid            ),
	.ram_bready         (ram_bready         ),
	.ram_bresp          (ram_bresp          ),
	.ram_bvalid         (ram_bvalid         ),
	.ram_rdata          (ram_rdata          ),
	.ram_rid            (ram_rid            ),
	.ram_rlast          (ram_rlast          ),
	.ram_rready         (ram_rready         ),
	.ram_rresp          (ram_rresp          ),
	.ram_rvalid         (ram_rvalid         ),
	.ram_wdata          (ram_wdata          ),
	.ram_wlast          (ram_wlast          ),
	.ram_wready         (ram_wready         ),
	.ram_wstrb          (ram_wstrb          ),
	.ram_wvalid         (ram_wvalid         )
);

ae350_ahb_subsystem #(
	.ADDR_MSB        (ADDR_MSB        )
) ae350_ahb_subsystem (
`ifdef ATCBUSDEC200_SLV1_SUPPORT
	.ahb2apb_haddr    (ahb2apb_haddr     ),
	.ahb2apb_hprot    (ahb2apb_hprot     ),
	.ahb2apb_hready_in(ahb2apb_hready_in ),
	.ahb2apb_hsize    (ahb2apb_hsize     ),
	.ahb2apb_htrans   (ahb2apb_htrans    ),
	.ahb2apb_hwdata   (ahb2apb_hwdata    ),
	.ahb2apb_hwrite   (ahb2apb_hwrite    ),
	.ahb2apb_hrdata   (ahb2apb_hrdata    ),
	.ahb2apb_hready   (ahb2apb_hready    ),
	.ahb2apb_hresp    (ahb2apb_hresp     ),
	.ahb2apb_hsel     (ahb2apb_hsel      ),
`endif
	.hbmc_hprot       (hbmc_hprot        ),
	.hbmc_hresp       (hbmc_hresp        ),
	.hbmc_haddr       (hbmc_haddr        ),
	.hbmc_htrans      (hbmc_htrans       ),
	.hclk             (hclk              ),
	.hresetn          (hresetn           ),
	.hbmc_hwdata      (hbmc_hwdata       ),
	.hbmc_hwrite      (hbmc_hwrite       ),
	.hbmc_hburst      (hbmc_hburst       ),
	.hbmc_hsize       (hbmc_hsize        ),
	.hbmc_hrdata      (hbmc_hrdata       ),
	.hbmc_hready      (hbmc_hready       ),
	.hbmc_hreadyout   (hbmc_hreadyout    ),
	.hbmc_hsel        (hbmc_hsel         ),
	.lcd_intr         (lcd_intr          ),
	.mac_int          (mac_int           )
);

ae350_apb_subsystem #(
	.AXI_ID_WIDTH    (BIU_ID_WIDTH    ),
	.BIU_DATA_WIDTH  (BIU_DATA_WIDTH  ),
	.BUS_MASTER_ADDR_WIDTH(ADDR_WIDTH      ),
	.DMAC_DATA_WIDTH (DMAC_DATA_WIDTH )
) ae350_apb_subsystem (
`ifdef AE350_RTC_SUPPORT
	.rtc_prdata        (rtc_prdata        ),
	.rtc_pready        (rtc_pready        ),
	.rtc_psel          (rtc_psel          ),
	.rtc_pslverr       (rtc_pslverr       ),
`endif
`ifdef AE350_UART1_SUPPORT
	.pclk_uart1        (pclk_uart1        ),
	.uart1_ctsn        (uart1_ctsn        ),
	.uart1_dcdn        (uart1_dcdn        ),
	.uart1_dsrn        (uart1_dsrn        ),
	.uart1_dtrn        (uart1_dtrn        ),
	.uart1_out1n       (uart1_out1n       ),
	.uart1_out2n       (uart1_out2n       ),
	.uart1_rin         (uart1_rin         ),
	.uart1_rtsn        (uart1_rtsn        ),
	.uart1_rxd         (uart1_rxd         ),
	.uart1_txd         (uart1_txd         ),
`endif
`ifdef AE350_UART2_SUPPORT
	.pclk_uart2        (pclk_uart2        ),
	.uart2_ctsn        (uart2_ctsn        ),
	.uart2_dcdn        (uart2_dcdn        ),
	.uart2_dsrn        (uart2_dsrn        ),
	.uart2_dtrn        (uart2_dtrn        ),
	.uart2_out1n       (uart2_out1n       ),
	.uart2_out2n       (uart2_out2n       ),
	.uart2_rin         (uart2_rin         ),
	.uart2_rtsn        (uart2_rtsn        ),
	.uart2_rxd         (uart2_rxd         ),
	.uart2_txd         (uart2_txd         ),
`endif
`ifdef AE350_PIT_SUPPORT
	.ch0_pwm           (ch0_pwm           ),
	.ch0_pwmoe         (ch0_pwmoe         ),
	.pclk_pit          (pclk_pit          ),
`endif
`ifdef AE350_WDT_SUPPORT
	.pclk_wdt          (pclk_wdt          ),
`endif
`ifdef AE350_GPIO_SUPPORT
	.gpio_in           (gpio_in           ),
	.gpio_oe           (gpio_oe           ),
	.gpio_out          (gpio_out          ),
	.pclk_gpio         (pclk_gpio         ),
`endif
`ifdef AE350_I2C_SUPPORT
	.i2c_scl           (i2c_scl           ),
	.i2c_scl_in        (i2c_scl_in        ),
	.i2c_sda           (i2c_sda           ),
	.i2c_sda_in        (i2c_sda_in        ),
	.pclk_i2c          (pclk_i2c          ),
`endif
`ifdef AE350_SPI1_SUPPORT
	.spi1_clk_in       (spi1_clk_in       ),
	.spi1_clk_oe       (spi1_clk_oe       ),
	.spi1_clk_out      (spi1_clk_out      ),
	.spi1_csn_oe       (spi1_csn_oe       ),
	.spi1_csn_out      (spi1_csn_out      ),
	.spi1_miso_in      (spi1_miso_in      ),
	.spi1_miso_oe      (spi1_miso_oe      ),
	.spi1_miso_out     (spi1_miso_out     ),
	.spi1_mosi_in      (spi1_mosi_in      ),
	.spi1_mosi_oe      (spi1_mosi_oe      ),
	.spi1_mosi_out     (spi1_mosi_out     ),
`endif
`ifdef AE350_SPI2_SUPPORT
	.spi2_clk_in       (spi2_clk_in       ),
	.spi2_clk_oe       (spi2_clk_oe       ),
	.spi2_clk_out      (spi2_clk_out      ),
	.spi2_csn_oe       (spi2_csn_oe       ),
	.spi2_csn_out      (spi2_csn_out      ),
	.spi2_miso_in      (spi2_miso_in      ),
	.spi2_miso_oe      (spi2_miso_oe      ),
	.spi2_miso_out     (spi2_miso_out     ),
	.spi2_mosi_in      (spi2_mosi_in      ),
	.spi2_mosi_oe      (spi2_mosi_oe      ),
	.spi2_mosi_out     (spi2_mosi_out     ),
`endif
`ifdef AE350_DMA_AXI_SUPPORT
	.dmac0_arid        (dmac0_arid        ),
	.dmac0_awid        (dmac0_awid        ),
	.dmac0_bid         (dmac0_bid         ),
	.dmac0_rid         (dmac0_rid         ),
	.aclk              (aclk              ),
	.aresetn           (aresetn           ),
	.dmac0_araddr      (dmac0_araddr      ),
	.dmac0_arburst     (dmac0_arburst     ),
	.dmac0_arcache     (dmac0_arcache     ),
	.dmac0_arlen       (dmac0_arlen       ),
	.dmac0_arlock      (dmac0_arlock      ),
	.dmac0_arprot      (dmac0_arprot      ),
	.dmac0_arready     (dmac0_arready     ),
	.dmac0_arsize      (dmac0_arsize      ),
	.dmac0_arvalid     (dmac0_arvalid     ),
	.dmac0_awaddr      (dmac0_awaddr      ),
	.dmac0_awburst     (dmac0_awburst     ),
	.dmac0_awcache     (dmac0_awcache     ),
	.dmac0_awlen       (dmac0_awlen       ),
	.dmac0_awlock      (dmac0_awlock      ),
	.dmac0_awprot      (dmac0_awprot      ),
	.dmac0_awready     (dmac0_awready     ),
	.dmac0_awsize      (dmac0_awsize      ),
	.dmac0_awvalid     (dmac0_awvalid     ),
	.dmac0_bready      (dmac0_bready      ),
	.dmac0_bresp       (dmac0_bresp       ),
	.dmac0_bvalid      (dmac0_bvalid      ),
	.dmac0_rdata       (dmac0_rdata       ),
	.dmac0_rlast       (dmac0_rlast       ),
	.dmac0_rready      (dmac0_rready      ),
	.dmac0_rresp       (dmac0_rresp       ),
	.dmac0_rvalid      (dmac0_rvalid      ),
	.dmac0_wdata       (dmac0_wdata       ),
	.dmac0_wlast       (dmac0_wlast       ),
	.dmac0_wready      (dmac0_wready      ),
	.dmac0_wstrb       (dmac0_wstrb       ),
	.dmac0_wvalid      (dmac0_wvalid      ),
`endif
`ifdef AE350_PIT_SUPPORT
   `ifdef ATCPIT100_CH1_SUPPORT
	.ch1_pwm           (ch1_pwm           ),
	.ch1_pwmoe         (ch1_pwmoe         ),
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
	.ch2_pwm           (ch2_pwm           ),
	.ch2_pwmoe         (ch2_pwmoe         ),
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
	.ch3_pwm           (ch3_pwm           ),
	.ch3_pwmoe         (ch3_pwmoe         ),
   `endif
`endif
`ifdef AE350_GPIO_SUPPORT
   `ifdef ATCGPIO100_PULL_SUPPORT
	.gpio_pulldown     (gpio_pulldown     ),
	.gpio_pullup       (gpio_pullup       ),
   `endif
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_REG_APB
	.pclk_spi1         (pclk_spi1         ),
   `endif
   `ifdef ATCSPI200_AHB_MEM_SUPPORT
	.spi_mem_haddr     (spi_mem_haddr     ),
	.spi_mem_hrdata    (spi_mem_hrdata    ),
	.spi_mem_hready    (spi_mem_hready    ),
	.spi_mem_hreadyout (spi_mem_hreadyout ),
	.spi_mem_hresp     (spi_mem_hresp     ),
	.spi_mem_hsel      (spi_mem_hsel      ),
	.spi_mem_htrans    (spi_mem_htrans    ),
	.spi_mem_hwrite    (spi_mem_hwrite    ),
   `endif
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi1_csn_in       (spi1_csn_in       ),
   `endif
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi1_holdn_in     (spi1_holdn_in     ),
	.spi1_holdn_oe     (spi1_holdn_oe     ),
	.spi1_holdn_out    (spi1_holdn_out    ),
	.spi1_wpn_in       (spi1_wpn_in       ),
	.spi1_wpn_oe       (spi1_wpn_oe       ),
	.spi1_wpn_out      (spi1_wpn_out      ),
   `endif
`endif
`ifdef AE350_SPI2_SUPPORT
   `ifdef ATCSPI200_REG_APB
	.pclk_spi2         (pclk_spi2         ),
   `endif
   `ifdef ATCSPI200_SLAVE_SUPPORT
	.spi2_csn_in       (spi2_csn_in       ),
   `endif
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi2_holdn_in     (spi2_holdn_in     ),
	.spi2_holdn_oe     (spi2_holdn_oe     ),
	.spi2_holdn_out    (spi2_holdn_out    ),
	.spi2_wpn_in       (spi2_wpn_in       ),
	.spi2_wpn_oe       (spi2_wpn_oe       ),
	.spi2_wpn_out      (spi2_wpn_out      ),
   `endif
`endif
`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	.dmac1_arid        (dmac1_arid        ),
	.dmac1_awid        (dmac1_awid        ),
	.dmac1_bid         (dmac1_bid         ),
	.dmac1_rid         (dmac1_rid         ),
	.dmac1_araddr      (dmac1_araddr      ),
	.dmac1_arburst     (dmac1_arburst     ),
	.dmac1_arcache     (dmac1_arcache     ),
	.dmac1_arlen       (dmac1_arlen       ),
	.dmac1_arlock      (dmac1_arlock      ),
	.dmac1_arprot      (dmac1_arprot      ),
	.dmac1_arready     (dmac1_arready     ),
	.dmac1_arsize      (dmac1_arsize      ),
	.dmac1_arvalid     (dmac1_arvalid     ),
	.dmac1_awaddr      (dmac1_awaddr      ),
	.dmac1_awburst     (dmac1_awburst     ),
	.dmac1_awcache     (dmac1_awcache     ),
	.dmac1_awlen       (dmac1_awlen       ),
	.dmac1_awlock      (dmac1_awlock      ),
	.dmac1_awprot      (dmac1_awprot      ),
	.dmac1_awready     (dmac1_awready     ),
	.dmac1_awsize      (dmac1_awsize      ),
	.dmac1_awvalid     (dmac1_awvalid     ),
	.dmac1_bready      (dmac1_bready      ),
	.dmac1_bresp       (dmac1_bresp       ),
	.dmac1_bvalid      (dmac1_bvalid      ),
	.dmac1_rdata       (dmac1_rdata       ),
	.dmac1_rlast       (dmac1_rlast       ),
	.dmac1_rready      (dmac1_rready      ),
	.dmac1_rresp       (dmac1_rresp       ),
	.dmac1_rvalid      (dmac1_rvalid      ),
	.dmac1_wdata       (dmac1_wdata       ),
	.dmac1_wlast       (dmac1_wlast       ),
	.dmac1_wready      (dmac1_wready      ),
	.dmac1_wstrb       (dmac1_wstrb       ),
	.dmac1_wvalid      (dmac1_wvalid      ),
   `endif
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi1_csn_in       (spi1_csn_in       ),
      `endif
   `endif
`endif
`ifdef ATCSPI200_REG_APB
   `ifdef ATCSPI200_AHBBUS_EXIST
   `else
      `ifdef ATCSPI200_EILMBUS_EXIST
	.apb2core_clken    (apb2core_clken    ),
      `endif
   `endif
`endif
`ifdef AE350_SPI2_SUPPORT
   `ifdef ATCSPI200_SLAVE_SUPPORT
   `else
      `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi2_csn_in       (spi2_csn_in       ),
      `endif
   `endif
`endif
	.ahb2apb_haddr     (ahb2apb_haddr     ),
	.ahb2apb_hprot     (ahb2apb_hprot     ),
	.ahb2apb_hrdata    (ahb2apb_hrdata    ),
	.ahb2apb_hready    (ahb2apb_hready    ),
	.ahb2apb_hready_in (ahb2apb_hready_in ),
	.ahb2apb_hresp     (ahb2apb_hresp     ),
	.ahb2apb_hsel      (ahb2apb_hsel      ),
	.ahb2apb_hsize     (ahb2apb_hsize     ),
	.ahb2apb_htrans    (ahb2apb_htrans    ),
	.ahb2apb_hwdata    (ahb2apb_hwdata    ),
	.ahb2apb_hwrite    (ahb2apb_hwrite    ),
	.paddr             (paddr             ),
	.penable           (penable           ),
	.pwdata            (pwdata            ),
	.pwrite            (pwrite            ),
	.smu_prdata        (smu_prdata        ),
	.smu_pready        (smu_pready        ),
	.smu_psel          (smu_psel          ),
	.smu_pslverr       (smu_pslverr       ),
	.pclk              (pclk              ),
	.presetn           (presetn           ),
	.apb2ahb_clken     (apb2ahb_clken     ),
	.hclk              (hclk              ),
	.hresetn           (hresetn           ),
	.dma_int           (dma_int           ),
	.gpio_intr         (gpio_intr         ),
	.extclk            (extclk            ),
	.i2c_int           (i2c_int           ),
	.pit_intr          (pit_intr          ),
	.sdc_int           (sdc_int           ),
	.spi1_int          (spi1_int          ),
	.scan_enable       (scan_enable       ),
	.scan_test         (scan_test         ),
	.spi_clk           (spi_clk           ),
	.spi_rstn          (spi_rstn          ),
	.spi2_int          (spi2_int          ),
	.ssp_intr          (ssp_intr          ),
	.uart1_int         (uart1_int         ),
	.uart_clk          (uart_clk          ),
	.uart_rstn         (uart_rstn         ),
	.uart2_int         (uart2_int         ),
	.wdt_int           (wdt_int           ),
	.wdt_rst           (wdt_rst           )
);


ae350_cpu_subsystem ae350_cpu_subsystem (
   `ifdef NDS_IO_BIU_AXI_COMMON_X2
	.i_arid                        (cpu_i_arid                            ),
	.i_araddr                      (cpu_i_araddr                          ),
	.i_arlen                       (cpu_i_arlen                           ),
	.i_arsize                      (cpu_i_arsize                          ),
	.i_arburst                     (cpu_i_arburst                         ),
	.i_arlock                      (cpu_i_arlock                          ),
	.i_arcache                     (cpu_i_arcache                         ),
	.i_arprot                      (cpu_i_arprot                          ),
	.i_arvalid                     (cpu_i_arvalid                         ),
	.i_arready                     (cpu_i_arready                         ),
	.i_awid                        (cpu_i_awid                            ),
	.i_awaddr                      (cpu_i_awaddr                          ),
	.i_awlen                       (cpu_i_awlen                           ),
	.i_awsize                      (cpu_i_awsize                          ),
	.i_awburst                     (cpu_i_awburst                         ),
	.i_awlock                      (cpu_i_awlock                          ),
	.i_awcache                     (cpu_i_awcache                         ),
	.i_awprot                      (cpu_i_awprot                          ),
	.i_awvalid                     (cpu_i_awvalid                         ),
	.i_awready                     (cpu_i_awready                         ),
	.i_wdata                       (cpu_i_wdata                           ),
	.i_wstrb                       (cpu_i_wstrb                           ),
	.i_wlast                       (cpu_i_wlast                           ),
	.i_wvalid                      (cpu_i_wvalid                          ),
	.i_wready                      (cpu_i_wready                          ),
	.i_bid                         (cpu_i_bid                             ),
	.i_bresp                       (cpu_i_bresp                           ),
	.i_bvalid                      (cpu_i_bvalid                          ),
	.i_bready                      (cpu_i_bready                          ),
	.i_rid                         (cpu_i_rid                             ),
	.i_rdata                       (cpu_i_rdata                           ),
	.i_rresp                       (cpu_i_rresp                           ),
	.i_rlast                       (cpu_i_rlast                           ),
	.i_rvalid                      (cpu_i_rvalid                          ),
	.i_rready                      (cpu_i_rready                          ),
	.d_arid                        (cpu_d_arid                            ),
	.d_araddr                      (cpu_d_araddr                          ),
	.d_arlen                       (cpu_d_arlen                           ),
	.d_arsize                      (cpu_d_arsize                          ),
	.d_arburst                     (cpu_d_arburst                         ),
	.d_arlock                      (cpu_d_arlock                          ),
	.d_arcache                     (cpu_d_arcache                         ),
	.d_arprot                      (cpu_d_arprot                          ),
	.d_arvalid                     (cpu_d_arvalid                         ),
	.d_arready                     (cpu_d_arready                         ),
	.d_awid                        (cpu_d_awid                            ),
	.d_awaddr                      (cpu_d_awaddr                          ),
	.d_awlen                       (cpu_d_awlen                           ),
	.d_awsize                      (cpu_d_awsize                          ),
	.d_awburst                     (cpu_d_awburst                         ),
	.d_awlock                      (cpu_d_awlock                          ),
	.d_awcache                     (cpu_d_awcache                         ),
	.d_awprot                      (cpu_d_awprot                          ),
	.d_awvalid                     (cpu_d_awvalid                         ),
	.d_awready                     (cpu_d_awready                         ),
	.d_wdata                       (cpu_d_wdata                           ),
	.d_wstrb                       (cpu_d_wstrb                           ),
	.d_wlast                       (cpu_d_wlast                           ),
	.d_wvalid                      (cpu_d_wvalid                          ),
	.d_wready                      (cpu_d_wready                          ),
	.d_bid                         (cpu_d_bid                             ),
	.d_bresp                       (cpu_d_bresp                           ),
	.d_bvalid                      (cpu_d_bvalid                          ),
	.d_bready                      (cpu_d_bready                          ),
	.d_rid                         (cpu_d_rid                             ),
	.d_rdata                       (cpu_d_rdata                           ),
	.d_rresp                       (cpu_d_rresp                           ),
	.d_rlast                       (cpu_d_rlast                           ),
	.d_rvalid                      (cpu_d_rvalid                          ),
	.d_rready                      (cpu_d_rready                          ),
   `endif
   `ifdef NDS_IO_BIU_AXI_COMMON_X1
	.arid                          (cpu_arid                              ),
	.araddr                        (cpu_araddr                            ),
	.arlen                         (cpu_arlen                             ),
	.arsize                        (cpu_arsize                            ),
	.arburst                       (cpu_arburst                           ),
	.arlock                        (cpu_arlock                            ),
	.arcache                       (cpu_arcache                           ),
	.arprot                        (cpu_arprot                            ),
	.arvalid                       (cpu_arvalid                           ),
	.arready                       (cpu_arready                           ),
	.awid                          (cpu_awid                              ),
	.awaddr                        (cpu_awaddr                            ),
	.awlen                         (cpu_awlen                             ),
	.awsize                        (cpu_awsize                            ),
	.awburst                       (cpu_awburst                           ),
	.awlock                        (cpu_awlock                            ),
	.awcache                       (cpu_awcache                           ),
	.awprot                        (cpu_awprot                            ),
	.awvalid                       (cpu_awvalid                           ),
	.awready                       (cpu_awready                           ),
	.wdata                         (cpu_wdata                             ),
	.wstrb                         (cpu_wstrb                             ),
	.wlast                         (cpu_wlast                             ),
	.wvalid                        (cpu_wvalid                            ),
	.wready                        (cpu_wready                            ),
	.bid                           (cpu_bid                               ),
	.bresp                         (cpu_bresp                             ),
	.bvalid                        (cpu_bvalid                            ),
	.bready                        (cpu_bready                            ),
	.rid                           (cpu_rid                               ),
	.rdata                         (cpu_rdata                             ),
	.rresp                         (cpu_rresp                             ),
	.rlast                         (cpu_rlast                             ),
	.rvalid                        (cpu_rvalid                            ),
	.rready                        (cpu_rready                            ),
   `endif
   `ifdef NDS_IO_SLAVEPORT_COMMON_X1
	.slv_arid                      (cpuslv_arid                           ),
	.slv_awid                      (cpuslv_awid                           ),
	.slv_bid                       (cpuslv_bid                            ),
	.slv_rid                       (cpuslv_rid                            ),
	.slv_araddr                    (cpuslv_araddr                         ),
	.slv_arburst                   (cpuslv_arburst                        ),
	.slv_arcache                   (cpuslv_arcache                        ),
	.slv_arlen                     (cpuslv_arlen                          ),
	.slv_arlock                    (cpuslv_arlock                         ),
	.slv_arprot                    (cpuslv_arprot                         ),
	.slv_arready                   (cpuslv_arready                        ),
	.slv_arsize                    (cpuslv_arsize                         ),
	.slv_arvalid                   (cpuslv_arvalid                        ),
	.slv_awaddr                    (cpuslv_awaddr                         ),
	.slv_awburst                   (cpuslv_awburst                        ),
	.slv_awcache                   (cpuslv_awcache                        ),
	.slv_awlen                     (cpuslv_awlen                          ),
	.slv_awlock                    (cpuslv_awlock                         ),
	.slv_awprot                    (cpuslv_awprot                         ),
	.slv_awready                   (cpuslv_awready                        ),
	.slv_awsize                    (cpuslv_awsize                         ),
	.slv_awvalid                   (cpuslv_awvalid                        ),
	.slv_bready                    (cpuslv_bready                         ),
	.slv_bresp                     (cpuslv_bresp                          ),
	.slv_bvalid                    (cpuslv_bvalid                         ),
	.slv_rdata                     (cpuslv_rdata                          ),
	.slv_rlast                     (cpuslv_rlast                          ),
	.slv_rready                    (cpuslv_rready                         ),
	.slv_rresp                     (cpuslv_rresp                          ),
	.slv_rvalid                    (cpuslv_rvalid                         ),
	.slv_wdata                     (cpuslv_wdata                          ),
	.slv_wlast                     (cpuslv_wlast                          ),
	.slv_wready                    (cpuslv_wready                         ),
	.slv_wstrb                     (cpuslv_wstrb                          ),
	.slv_wvalid                    (cpuslv_wvalid                         ),
   `endif
   `ifdef PLATFORM_DEBUG_SUBSYSTEM
	.dmactive                      (nds_unused_dmactive                   ),
	.dmi_haddr                     (dmi_haddr                             ),
	.dmi_hburst                    (dmi_hburst                            ),
	.dmi_hprot                     (dmi_hprot                             ),
	.dmi_hrdata                    (dmi_hrdata                            ),
	.dmi_hready                    (dmi_hready                            ),
	.dmi_hreadyout                 (dmi_hready                            ),
	.dmi_hresp                     (dmi_hresp                             ),
	.dmi_hsel                      (dmi_hsel                              ),
	.dmi_hsize                     (dmi_hsize                             ),
	.dmi_htrans                    (dmi_htrans                            ),
	.dmi_hwdata                    (dmi_hwdata                            ),
	.dmi_hwrite                    (dmi_hwrite                            ),
	.dmi_resetn                    (dmi_resetn                            ),
   `endif
   `ifdef NDS_IO_PROBING
	.hart0_probe_current_pc        (hart0_probe_current_pc                ),
	.hart0_probe_gpr_index         (hart0_probe_gpr_index                 ),
	.hart0_probe_selected_gpr_value(hart0_probe_selected_gpr_value        ),
   `endif
   `ifdef NDS_IO_TRACE_INSTR_GEN1
	.hart0_gen1_trace_cause        (nds_unused_hart0_gen1_trace_cause     ),
	.hart0_gen1_trace_enabled      (1'b0                                  ),
	.hart0_gen1_trace_iaddr        (nds_unused_hart0_gen1_trace_iaddr     ),
	.hart0_gen1_trace_iexception   (nds_unused_hart0_gen1_trace_iexception),
	.hart0_gen1_trace_instr        (nds_unused_hart0_gen1_trace_instr     ),
	.hart0_gen1_trace_interrupt    (nds_unused_hart0_gen1_trace_interrupt ),
	.hart0_gen1_trace_ivalid       (nds_unused_hart0_gen1_trace_ivalid    ),
	.hart0_gen1_trace_priv         (nds_unused_hart0_gen1_trace_priv      ),
	.hart0_gen1_trace_tval         (nds_unused_hart0_gen1_trace_tval      ),
   `endif
   `ifdef NDS_IO_TRACE_INSTR
	.hart0_trace_cause             (nds_unused_hart0_trace_cause          ),
	.hart0_trace_enabled           (1'b0                                  ),
	.hart0_trace_halted            (nds_unused_hart0_trace_halted         ),
	.hart0_trace_iaddr             (nds_unused_hart0_trace_iaddr          ),
	.hart0_trace_ilastsize         (nds_unused_hart0_trace_ilastsize      ),
	.hart0_trace_iretire           (nds_unused_hart0_trace_iretire        ),
	.hart0_trace_itype             (nds_unused_hart0_trace_itype          ),
	.hart0_trace_priv              (nds_unused_hart0_trace_priv           ),
	.hart0_trace_reset             (nds_unused_hart0_trace_reset          ),
	.hart0_trace_trigger           (nds_unused_hart0_trace_trigger        ),
	.hart0_trace_tval              (nds_unused_hart0_trace_tval           ),
   `endif
   `ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
      `ifdef PLATFORM_DEBUG_SUBSYSTEM
	.dm_sys_araddr                 (dm_sys_araddr                         ),
	.dm_sys_arburst                (dm_sys_arburst                        ),
	.dm_sys_arcache                (dm_sys_arcache                        ),
	.dm_sys_arid                   (dm_sys_arid                           ),
	.dm_sys_arlen                  (dm_sys_arlen                          ),
	.dm_sys_arlock                 (dm_sys_arlock                         ),
	.dm_sys_arprot                 (dm_sys_arprot                         ),
	.dm_sys_arready                (dm_sys_arready                        ),
	.dm_sys_arsize                 (dm_sys_arsize                         ),
	.dm_sys_arvalid                (dm_sys_arvalid                        ),
	.dm_sys_awaddr                 (dm_sys_awaddr                         ),
	.dm_sys_awburst                (dm_sys_awburst                        ),
	.dm_sys_awcache                (dm_sys_awcache                        ),
	.dm_sys_awid                   (dm_sys_awid                           ),
	.dm_sys_awlen                  (dm_sys_awlen                          ),
	.dm_sys_awlock                 (dm_sys_awlock                         ),
	.dm_sys_awprot                 (dm_sys_awprot                         ),
	.dm_sys_awready                (dm_sys_awready                        ),
	.dm_sys_awsize                 (dm_sys_awsize                         ),
	.dm_sys_awvalid                (dm_sys_awvalid                        ),
	.dm_sys_bid                    (dm_sys_bid                            ),
	.dm_sys_bready                 (dm_sys_bready                         ),
	.dm_sys_bresp                  (dm_sys_bresp                          ),
	.dm_sys_bvalid                 (dm_sys_bvalid                         ),
	.dm_sys_rdata                  (dm_sys_rdata                          ),
	.dm_sys_rid                    (dm_sys_rid                            ),
	.dm_sys_rlast                  (dm_sys_rlast                          ),
	.dm_sys_rready                 (dm_sys_rready                         ),
	.dm_sys_rresp                  (dm_sys_rresp                          ),
	.dm_sys_rvalid                 (dm_sys_rvalid                         ),
	.dm_sys_wdata                  (dm_sys_wdata                          ),
	.dm_sys_wlast                  (dm_sys_wlast                          ),
	.dm_sys_wready                 (dm_sys_wready                         ),
	.dm_sys_wstrb                  (dm_sys_wstrb                          ),
	.dm_sys_wvalid                 (dm_sys_wvalid                         ),
      `endif
   `endif
	.axi_bus_clk_en                (axi2core_clken                        ),
	.core_clk                      (core_clk                              ),
	.core_resetn                   (core_resetn                           ),
	.dbg_srst_req                  (dbg_srst_req                          ),
	.dc_clk                        (dc_clk                                ),
	.hart0_wakeup_event            (hart0_wakeup_event                    ),
	.lm_clk                        (lm_clk                                ),
	.slvp_resetn                   (slvp_resetn                           ),
	.test_rstn                     (test_rstn                             ),
	.aclk                          (aclk                                  ),
	.aresetn                       (aresetn                               ),
	.scan_enable                   (scan_enable                           ),
	.test_mode                     (test_mode                             ),
	.int_src                       (int_src                               ),
	.mtime_clk                     (pclk                                  ),
	.por_rstn                      (por_rstn                              ),
	.hart0_reset_vector            (core_reset_vectors[(VALEN-1):0]       ),
	.hart0_icache_disable_init     (hart0_icache_disable_init             ),
	.hart0_dcache_disable_init     (hart0_dcache_disable_init             ),
	.hart0_core_wfi_mode           (hart0_core_wfi_mode                   ),
	.hart0_nmi                     (wdt_int                               )
);









ae350_ram_subsystem #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (BIU_DATA_WIDTH  ),
	.DDR_ASYNC_DEPTH (DDR_ASYNC_DEPTH ),
	.ID_WIDTH        (BIU_ID_WIDTH+4  ),
	.SIMULATION      (SIMULATION      ),
	.SIM_BYPASS_INIT_CAL(SIM_BYPASS_INIT_CAL)
) ae350_ram_subsystem (

	.arcache            (ram_arcache        ),
	.arprot             (ram_arprot         ),
	.awcache            (ram_awcache        ),
	.awprot             (ram_awprot         ),
	.wlast              (ram_wlast          ),
	.aclk               (aclk               ),
	.aresetn            (aresetn            ),
	.araddr             (ram_araddr         ),
	.arburst            (ram_arburst        ),
	.arid               (ram_arid           ),
	.arlen              (ram_arlen          ),
	.arlock             (ram_arlock         ),
	.arready            (ram_arready        ),
	.arsize             (ram_arsize         ),
	.arvalid            (ram_arvalid        ),
	.awaddr             (ram_awaddr         ),
	.awburst            (ram_awburst        ),
	.awid               (ram_awid           ),
	.awlen              (ram_awlen          ),
	.awlock             (ram_awlock         ),
	.awready            (ram_awready        ),
	.awsize             (ram_awsize         ),
	.awvalid            (ram_awvalid        ),
	.bid                (ram_bid            ),
	.bready             (ram_bready         ),
	.bresp              (ram_bresp          ),
	.bvalid             (ram_bvalid         ),
	.rdata              (ram_rdata          ),
	.rid                (ram_rid            ),
	.rlast              (ram_rlast          ),
	.rready             (ram_rready         ),
	.rresp              (ram_rresp          ),
	.rvalid             (ram_rvalid         ),
	.wdata              (ram_wdata          ),
	.wready             (ram_wready         ),
	.wstrb              (ram_wstrb          ),
	.wvalid             (ram_wvalid         ),

   


	.T_por_b            (T_por_b            ),
	.init_calib_complete(init_calib_complete),
	.ui_clk             (ui_clk             )
);


ae350_aopd ae350_aopd (
`ifdef AE350_RTC_SUPPORT
	.rtc_pready                    (rtc_pready                          ),
	.rtc_pslverr                   (rtc_pslverr                         ),
	.rtc_prdata                    (rtc_prdata                          ),
	.rtc_psel                      (rtc_psel                            ),
`endif
`ifdef NDS_FPGA
	.ddr3_bw_ctrl                  (ddr3_bw_ctrl                        ),
	.ddr3_latency                  (ddr3_latency                        ),
`else
	.X_aopd_por_b                  (X_aopd_por_b                        ),
	.X_mpd_pwr_off                 (X_mpd_pwr_off                       ),
	.X_om                          (X_om                                ),
	.X_osclio                      (X_osclio                            ),
`endif
`ifdef PLATFORM_DEBUG_PORT
	.pin_tdi_in                    (pin_tdi_in                          ),
	.pin_tdo_out                   (pin_tdo_out                         ),
	.pin_tdo_out_en                (pin_tdo_out_en                      ),
	.pin_tms_out                   (pin_tms_out                         ),
	.pin_tms_out_en                (pin_tms_out_en                      ),
	.pin_trst_in                   (pin_trst_in                         ),
	.X_tck                         (X_tck                               ),
	.pin_tms_in                    (pin_tms_in                          ),
`endif
`ifdef PLATFORM_DEBUG_SUBSYSTEM
	.dmi_haddr                     (dmi_haddr                           ),
	.dmi_hburst                    (dmi_hburst                          ),
	.dmi_hprot                     (dmi_hprot                           ),
	.dmi_hrdata                    (dmi_hrdata                          ),
	.dmi_hready                    (dmi_hready                          ),
	.dmi_hresp                     (dmi_hresp                           ),
	.dmi_hsel                      (dmi_hsel                            ),
	.dmi_hsize                     (dmi_hsize                           ),
	.dmi_htrans                    (dmi_htrans                          ),
	.dmi_hwdata                    (dmi_hwdata                          ),
	.dmi_hwrite                    (dmi_hwrite                          ),
	.dmi_resetn                    (dmi_resetn                          ),
`endif
`ifdef NDS_IO_L2C
`endif
`ifdef NDS_FPGA
`else
   `ifdef AE350_RTC_SUPPORT
	.X_rtc_wakeup                  (X_rtc_wakeup                        ),
   `endif
`endif
`ifdef NDS_FPGA
   `ifdef NDS_IO_PROBING
	.hart0_probe_current_pc        (hart0_probe_current_pc[31:0]        ),
	.hart0_probe_gpr_index         (hart0_probe_gpr_index               ),
	.hart0_probe_selected_gpr_value(hart0_probe_selected_gpr_value[31:0]),
   `endif
`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
	.secure_code                   (secure_code                         ),
	.secure_mode                   (secure_mode                         ),
   `endif
`endif
	.cluster_iso_on                (cluster_iso_on                      ),
	.cluster_pwr_on                (cluster_pwr_on                      ),
	.dma_int                       (dma_int                             ),
	.extclk                        (extclk                              ),
	.gpio_intr                     (gpio_intr                           ),
	.hart0_core_wfi_mode           (hart0_core_wfi_mode                 ),
	.hart0_dcache_disable_init     (hart0_dcache_disable_init           ),
	.hart0_icache_disable_init     (hart0_icache_disable_init           ),
	.hart0_wakeup_event            (hart0_wakeup_event                  ),
	.i2c_int                       (i2c_int                             ),
	.int_src                       (int_src                             ),
	.lcd_intr                      (lcd_intr                            ),
	.mac_int                       (mac_int                             ),
	.pit_intr                      (pit_intr                            ),
	.sdc_int                       (sdc_int                             ),
	.spi1_int                      (spi1_int                            ),
	.spi2_int                      (spi2_int                            ),
	.ssp_intr                      (ssp_intr                            ),
	.uart1_int                     (uart1_int                           ),
	.uart2_int                     (uart2_int                           ),
	.wdt_int                       (wdt_int                             ),
	.X_osclin                      (X_osclin                            ),
	.X_wakeup_in                   (X_wakeup_in                         ),
	.T_por_b                       (T_por_b                             ),
	.scan_enable                   (scan_enable                         ),
	.scan_test                     (scan_test                           ),
	.test_mode                     (test_mode                           ),
	.test_rstn                     (test_rstn                           ),
	.T_osch                        (T_osch                              ),
	.pd0_vol_on                    (pd0_vol_on                          ),
	.pd10_vol_on                   (pd10_vol_on                         ),
	.pd1_vol_on                    (pd1_vol_on                          ),
	.pd2_vol_on                    (pd2_vol_on                          ),
	.pd3_vol_on                    (pd3_vol_on                          ),
	.pd4_vol_on                    (pd4_vol_on                          ),
	.pd5_vol_on                    (pd5_vol_on                          ),
	.pd6_vol_on                    (pd6_vol_on                          ),
	.pd7_vol_on                    (pd7_vol_on                          ),
	.pd8_vol_on                    (pd8_vol_on                          ),
	.pd9_vol_on                    (pd9_vol_on                          ),
	.aclk                          (aclk                                ),
	.ahb2core_clken                (ahb2core_clken                      ),
	.apb2ahb_clken                 (apb2ahb_clken                       ),
	.apb2core_clken                (apb2core_clken                      ),
	.axi2core_clken                (axi2core_clken                      ),
	.core_clk                      (core_clk                            ),
	.dc_clk                        (dc_clk                              ),
	.hclk                          (hclk                                ),
	.l2_clk                        (l2_clk                              ),
	.lm_clk                        (lm_clk                              ),
	.pclk                          (pclk                                ),
	.pclk_gpio                     (pclk_gpio                           ),
	.pclk_i2c                      (pclk_i2c                            ),
	.pclk_pit                      (pclk_pit                            ),
	.pclk_spi1                     (pclk_spi1                           ),
	.pclk_spi2                     (pclk_spi2                           ),
	.pclk_uart1                    (pclk_uart1                          ),
	.pclk_uart2                    (pclk_uart2                          ),
	.pclk_wdt                      (pclk_wdt                            ),
	.sdc_clk                       (sdc_clk                             ),
	.spi_clk                       (spi_clk                             ),
	.uart_clk                      (uart_clk                            ),
	.T_hw_rstn                     (T_hw_rstn                           ),
	.aresetn                       (aresetn                             ),
	.core_l2_resetn                (core_l2_resetn                      ),
	.core_resetn                   (core_resetn                         ),
	.dbg_srst_req                  (dbg_srst_req                        ),
	.hresetn                       (hresetn                             ),
	.init_calib_complete           (init_calib_complete                 ),
	.l2_resetn                     (l2_resetn                           ),
	.por_rstn                      (por_rstn                            ),
	.presetn                       (presetn                             ),
	.slvp_resetn                   (slvp_resetn                         ),
	.spi_rstn                      (spi_rstn                            ),
	.uart_rstn                     (uart_rstn                           ),
	.ui_clk                        (ui_clk                              ),
	.wdt_rst                       (wdt_rst                             ),
	.core_reset_vectors            (core_reset_vectors                  ),
	.pcs0_iso                      (pcs0_iso                            ),
	.pcs10_iso                     (pcs10_iso                           ),
	.pcs1_iso                      (pcs1_iso                            ),
	.pcs2_iso                      (pcs2_iso                            ),
	.pcs3_iso                      (pcs3_iso                            ),
	.pcs4_iso                      (pcs4_iso                            ),
	.pcs5_iso                      (pcs5_iso                            ),
	.pcs6_iso                      (pcs6_iso                            ),
	.pcs7_iso                      (pcs7_iso                            ),
	.pcs8_iso                      (pcs8_iso                            ),
	.pcs9_iso                      (pcs9_iso                            ),
	.smu_prdata                    (smu_prdata                          ),
	.smu_pready                    (smu_pready                          ),
	.smu_psel                      (smu_psel                            ),
	.smu_pslverr                   (smu_pslverr                         ),
	.paddr                         (paddr                               ),
	.penable                       (penable                             ),
	.pwdata                        (pwdata                              ),
	.pwrite                        (pwrite                              )
);

ae350_pin ae350_pin (
	.X_hw_rstn        (X_hw_rstn            ),
	.T_hw_rstn        (T_hw_rstn            ),
	.X_por_b          (X_por_b              ),
	.T_por_b          (T_por_b              ),
`ifdef PLATFORM_DEBUG_PORT
	.X_tms            (X_tms                ),
   `ifdef PLATFORM_JTAG_TWOWIRE
   `else
	.X_trst           (X_trst               ),
	.X_tdi            (X_tdi                ),
	.X_tdo            (X_tdo                ),
   `endif
	.pin_tms_in       (pin_tms_in           ),
	.pin_tms_out      (pin_tms_out          ),
	.pin_tms_out_en   (pin_tms_out_en       ),
   `ifdef PLATFORM_JTAG_TWOWIRE
   `else
	.pin_trst_in      (pin_trst_in          ),
	.pin_trst_out     (1'b0                 ),
	.pin_trst_out_en  (1'b0                 ),
	.pin_tdi_in       (pin_tdi_in           ),
	.pin_tdi_out      (1'b0                 ),
	.pin_tdi_out_en   (1'b0                 ),
	.pin_tdo_in       (nds_unused_pin_tdo_in),
	.pin_tdo_out      (pin_tdo_out          ),
	.pin_tdo_out_en   (pin_tdo_out_en       ),
   `endif
   `ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
	.X_secure_mode    (X_secure_mode        ),
	.T_secure_mode    (T_secure_mode        ),
   `endif
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.X_spi1_holdn     (X_spi1_holdn         ),
	.X_spi1_wpn       (X_spi1_wpn           ),
   `endif
	.X_spi1_clk       (X_spi1_clk           ),
	.X_spi1_csn       (X_spi1_csn           ),
	.X_spi1_miso      (X_spi1_miso          ),
	.X_spi1_mosi      (X_spi1_mosi          ),
`endif
`ifdef AE350_SPI2_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.X_spi2_holdn     (X_spi2_holdn         ),
	.X_spi2_wpn       (X_spi2_wpn           ),
   `endif
	.X_spi2_clk       (X_spi2_clk           ),
	.X_spi2_csn       (X_spi2_csn           ),
	.X_spi2_miso      (X_spi2_miso          ),
	.X_spi2_mosi      (X_spi2_mosi          ),
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi1_holdn_in    (spi1_holdn_in        ),
	.spi1_wpn_in      (spi1_wpn_in          ),
   `endif
	.spi1_clk_in      (spi1_clk_in          ),
	.spi1_csn_in      (spi1_csn_in          ),
	.spi1_miso_in     (spi1_miso_in         ),
	.spi1_mosi_in     (spi1_mosi_in         ),
`endif
`ifdef AE350_SPI2_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi2_holdn_in    (spi2_holdn_in        ),
	.spi2_wpn_in      (spi2_wpn_in          ),
   `endif
	.spi2_clk_in      (spi2_clk_in          ),
	.spi2_csn_in      (spi2_csn_in          ),
	.spi2_miso_in     (spi2_miso_in         ),
	.spi2_mosi_in     (spi2_mosi_in         ),
`endif
`ifdef AE350_SPI1_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi1_holdn_out   (spi1_holdn_out       ),
	.spi1_holdn_oe    (spi1_holdn_oe        ),
	.spi1_wpn_out     (spi1_wpn_out         ),
	.spi1_wpn_oe      (spi1_wpn_oe          ),
   `endif
	.spi1_clk_out     (spi1_clk_out         ),
	.spi1_clk_oe      (spi1_clk_oe          ),
	.spi1_csn_out     (spi1_csn_out         ),
	.spi1_csn_oe      (spi1_csn_oe          ),
	.spi1_miso_out    (spi1_miso_out        ),
	.spi1_miso_oe     (spi1_miso_oe         ),
	.spi1_mosi_out    (spi1_mosi_out        ),
	.spi1_mosi_oe     (spi1_mosi_oe         ),
`endif
`ifdef AE350_SPI2_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi2_holdn_out   (spi2_holdn_out       ),
	.spi2_holdn_oe    (spi2_holdn_oe        ),
	.spi2_wpn_out     (spi2_wpn_out         ),
	.spi2_wpn_oe      (spi2_wpn_oe          ),
   `endif
	.spi2_clk_out     (spi2_clk_out         ),
	.spi2_clk_oe      (spi2_clk_oe          ),
	.spi2_csn_out     (spi2_csn_out         ),
	.spi2_csn_oe      (spi2_csn_oe          ),
	.spi2_miso_out    (spi2_miso_out        ),
	.spi2_miso_oe     (spi2_miso_oe         ),
	.spi2_mosi_out    (spi2_mosi_out        ),
	.spi2_mosi_oe     (spi2_mosi_oe         ),
`endif
`ifdef AE350_I2C_SUPPORT
	.X_i2c_scl        (X_i2c_scl            ),
	.X_i2c_sda        (X_i2c_sda            ),
	.i2c_scl_in       (i2c_scl_in           ),
	.i2c_sda_in       (i2c_sda_in           ),
	.i2c_scl          (i2c_scl              ),
	.i2c_sda          (i2c_sda              ),
`endif
`ifdef AE350_UART1_SUPPORT
	.X_uart1_txd      (X_uart1_txd          ),
	.X_uart1_rxd      (X_uart1_rxd          ),
   `ifdef NDS_FPGA
   `else
      `ifdef AE350_UART2_SUPPORT
	.X_uart1_ctsn     (X_uart1_ctsn         ),
	.X_uart1_rtsn     (X_uart1_rtsn         ),
      `endif
   `endif
   `ifdef AE350_UART2_SUPPORT
   `else
	.X_uart1_ctsn     (X_uart1_ctsn         ),
	.X_uart1_rtsn     (X_uart1_rtsn         ),
   `endif
	.X_uart1_dsrn     (X_uart1_dsrn         ),
	.X_uart1_dcdn     (X_uart1_dcdn         ),
	.X_uart1_rin      (X_uart1_rin          ),
	.X_uart1_dtrn     (X_uart1_dtrn         ),
	.X_uart1_out1n    (X_uart1_out1n        ),
	.X_uart1_out2n    (X_uart1_out2n        ),
`endif
`ifdef AE350_UART2_SUPPORT
	.X_uart2_txd      (X_uart2_txd          ),
	.X_uart2_rxd      (X_uart2_rxd          ),
   `ifdef NDS_FPGA
   `else
	.X_uart2_ctsn     (X_uart2_ctsn         ),
	.X_uart2_rtsn     (X_uart2_rtsn         ),
	.X_uart2_dcdn     (X_uart2_dcdn         ),
	.X_uart2_dsrn     (X_uart2_dsrn         ),
	.X_uart2_rin      (X_uart2_rin          ),
	.X_uart2_dtrn     (X_uart2_dtrn         ),
	.X_uart2_out1n    (X_uart2_out1n        ),
	.X_uart2_out2n    (X_uart2_out2n        ),
   `endif
`endif
`ifdef AE350_UART1_SUPPORT
	.uart1_txd        (uart1_txd            ),
	.uart1_rtsn       (uart1_rtsn           ),
	.uart1_rxd        (uart1_rxd            ),
	.uart1_ctsn       (uart1_ctsn           ),
	.uart1_dsrn       (uart1_dsrn           ),
	.uart1_dcdn       (uart1_dcdn           ),
	.uart1_rin        (uart1_rin            ),
	.uart1_dtrn       (uart1_dtrn           ),
	.uart1_out1n      (uart1_out1n          ),
	.uart1_out2n      (uart1_out2n          ),
`endif
`ifdef AE350_UART2_SUPPORT
	.uart2_txd        (uart2_txd            ),
	.uart2_rtsn       (uart2_rtsn           ),
	.uart2_rxd        (uart2_rxd            ),
	.uart2_ctsn       (uart2_ctsn           ),
	.uart2_dcdn       (uart2_dcdn           ),
	.uart2_dsrn       (uart2_dsrn           ),
	.uart2_rin        (uart2_rin            ),
	.uart2_dtrn       (uart2_dtrn           ),
	.uart2_out1n      (uart2_out1n          ),
	.uart2_out2n      (uart2_out2n          ),
`endif
`ifdef AE350_PIT_SUPPORT
	.X_pwm_ch0        (X_pwm_ch0            ),
	.ch0_pwm          (ch0_pwm              ),
	.ch0_pwmoe        (ch0_pwmoe            ),
   `ifdef ATCPIT100_CH1_SUPPORT
	.X_pwm_ch1        (X_pwm_ch1            ),
	.ch1_pwm          (ch1_pwm              ),
	.ch1_pwmoe        (ch1_pwmoe            ),
   `endif
   `ifdef ATCPIT100_CH2_SUPPORT
	.X_pwm_ch2        (X_pwm_ch2            ),
	.ch2_pwm          (ch2_pwm              ),
	.ch2_pwmoe        (ch2_pwmoe            ),
   `endif
   `ifdef ATCPIT100_CH3_SUPPORT
	.X_pwm_ch3        (X_pwm_ch3            ),
	.ch3_pwm          (ch3_pwm              ),
	.ch3_pwmoe        (ch3_pwmoe            ),
   `endif
`endif
`ifdef NDS_FPGA
	.X_flash_cs       (X_flash_cs           ),
	.X_flash_dir      (X_flash_dir          ),
`endif
`ifdef AE350_GPIO_SUPPORT
	.X_gpio           (X_gpio               ),
	.gpio_in          (gpio_in              ),
	.gpio_oe          (gpio_oe              ),
	.gpio_out         (gpio_out             ),
   `ifdef ATCGPIO100_PULL_SUPPORT
	.gpio_pulldown    (gpio_pulldown        ),
	.gpio_pullup      (gpio_pullup          ),
   `endif
`endif
`ifdef NDS_FPGA
`else
	.X_oschio         (X_oschio             ),
`endif
	.X_oschin         (X_oschin             ),
	.T_osch           (T_osch               )
);

endmodule

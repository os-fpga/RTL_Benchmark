// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "ae350_config.vh"
`include "ae350_const.vh"

`include "atcapbbrg100_config.vh"
`include "atcapbbrg100_const.vh"


module ae350_aopd (
`ifdef AE350_RTC_SUPPORT
	  rtc_pready,
	  rtc_pslverr,
	  rtc_prdata,
	  rtc_psel,
`endif
`ifdef NDS_FPGA
	  ddr3_bw_ctrl,
	  ddr3_latency,
`else
	  X_aopd_por_b,
	  X_mpd_pwr_off,
	  X_om,
	  X_osclio,
`endif
`ifdef PLATFORM_DEBUG_PORT
	  pin_tdi_in,
	  pin_tdo_out,
	  pin_tdo_out_en,
	  pin_tms_out,
	  pin_tms_out_en,
	  pin_trst_in,
	  X_tck,
	  pin_tms_in,
`endif
`ifdef PLATFORM_DEBUG_SUBSYSTEM
	  dmi_haddr,
	  dmi_hburst,
	  dmi_hprot,
	  dmi_hrdata,
	  dmi_hready,
	  dmi_hresp,
	  dmi_hsel,
	  dmi_hsize,
	  dmi_htrans,
	  dmi_hwdata,
	  dmi_hwrite,
	  dmi_resetn,
`endif
`ifdef AE350_RTC_SUPPORT
   `ifdef NDS_FPGA
   `else
	  X_rtc_wakeup,
   `endif
`endif
`ifdef NDS_FPGA
   `ifdef NDS_IO_PROBING
	  hart0_probe_current_pc,
	  hart0_probe_gpr_index,
	  hart0_probe_selected_gpr_value,
   `endif
`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
	  secure_code,
	  secure_mode,
   `endif
`endif
	  cluster_iso_on,
	  cluster_pwr_on,
	  dma_int,
	  extclk,
	  gpio_intr,
	  hart0_core_wfi_mode,
	  hart0_dcache_disable_init,
	  hart0_icache_disable_init,
	  hart0_wakeup_event,
	  i2c_int,
	  int_src,
	  lcd_intr,
	  mac_int,
	  pit_intr,
	  sdc_int,
	  spi1_int,
	  spi2_int,
	  ssp_intr,
	  uart1_int,
	  uart2_int,
	  wdt_int,
	  X_osclin,
	  X_wakeup_in,
	  T_por_b,
	  scan_enable,
	  scan_test,
	  test_mode,
	  test_rstn,
	  T_osch,
	  pd0_vol_on,
	  pd10_vol_on,
	  pd1_vol_on,
	  pd2_vol_on,
	  pd3_vol_on,
	  pd4_vol_on,
	  pd5_vol_on,
	  pd6_vol_on,
	  pd7_vol_on,
	  pd8_vol_on,
	  pd9_vol_on,
	  aclk,
	  ahb2core_clken,
	  apb2ahb_clken,
	  apb2core_clken,
	  axi2core_clken,
	  core_clk,
	  dc_clk,
	  hclk,
	  l2_clk,
	  lm_clk,
	  pclk,
	  pclk_gpio,
	  pclk_i2c,
	  pclk_pit,
	  pclk_spi1,
	  pclk_spi2,
	  pclk_uart1,
	  pclk_uart2,
	  pclk_wdt,
	  sdc_clk,
	  spi_clk,
	  uart_clk,
	  T_hw_rstn,
	  aresetn,
	  core_l2_resetn,
	  core_resetn,
	  dbg_srst_req,
	  hresetn,
	  init_calib_complete,
	  l2_resetn,
	  por_rstn,
	  presetn,
	  slvp_resetn,
	  spi_rstn,
	  uart_rstn,
	  ui_clk,
	  wdt_rst,
	  core_reset_vectors,
	  pcs0_iso,
	  pcs10_iso,
	  pcs1_iso,
	  pcs2_iso,
	  pcs3_iso,
	  pcs4_iso,
	  pcs5_iso,
	  pcs6_iso,
	  pcs7_iso,
	  pcs8_iso,
	  pcs9_iso,
	  smu_prdata,
	  smu_pready,
	  smu_psel,
	  smu_pslverr,
	  paddr,
	  penable,
	  pwdata,
	  pwrite
);

localparam NHART                    = 1;

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

`ifdef AE350_RTC_SUPPORT
output                                 rtc_pready;
output                                 rtc_pslverr;
output                          [31:0] rtc_prdata;
input                                  rtc_psel;
`endif
`ifdef NDS_FPGA
output                           [1:0] ddr3_bw_ctrl;
output                           [3:0] ddr3_latency;
`else
inout                                  X_aopd_por_b;
inout                                  X_mpd_pwr_off;
inout                                  X_om;
inout                                  X_osclio;
`endif
`ifdef PLATFORM_DEBUG_PORT
input                                  pin_tdi_in;
output                                 pin_tdo_out;
output                                 pin_tdo_out_en;
output                                 pin_tms_out;
output                                 pin_tms_out_en;
input                                  pin_trst_in;
inout                                  X_tck;
input                                  pin_tms_in;
`endif
`ifdef PLATFORM_DEBUG_SUBSYSTEM
output                           [8:0] dmi_haddr;
output                           [2:0] dmi_hburst;
output                           [3:0] dmi_hprot;
input                           [31:0] dmi_hrdata;
input                                  dmi_hready;
input                            [1:0] dmi_hresp;
output                                 dmi_hsel;
output                           [2:0] dmi_hsize;
output                           [1:0] dmi_htrans;
output                          [31:0] dmi_hwdata;
output                                 dmi_hwrite;
output                                 dmi_resetn;
`endif
`ifdef AE350_RTC_SUPPORT
   `ifdef NDS_FPGA
   `else
inout                                  X_rtc_wakeup;
   `endif
`endif
`ifdef NDS_FPGA
   `ifdef NDS_IO_PROBING
input                           [31:0] hart0_probe_current_pc;
output                          [12:0] hart0_probe_gpr_index;
input                           [31:0] hart0_probe_selected_gpr_value;
   `endif
`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
input                          [127:0] secure_code;
input                            [1:0] secure_mode;
   `endif
`endif
output                                 cluster_iso_on;
output                                 cluster_pwr_on;
input                                  dma_int;
output                                 extclk;
input                                  gpio_intr;
input                                  hart0_core_wfi_mode;
output                                 hart0_dcache_disable_init;
output                                 hart0_icache_disable_init;
input                            [5:0] hart0_wakeup_event;
input                                  i2c_int;
output                          [31:1] int_src;
input                                  lcd_intr;
input                                  mac_int;
input                                  pit_intr;
input                                  sdc_int;
input                                  spi1_int;
input                                  spi2_int;
input                                  ssp_intr;
input                                  uart1_int;
input                                  uart2_int;
input                                  wdt_int;
input                                  X_osclin;
inout                                  X_wakeup_in;
input                                  T_por_b;
output                                 scan_enable;                     // synthesis syn_keep=1 */
output                                 scan_test;                       // synthesis syn_keep=1 */,
output                                 test_mode;                       // synthesis syn_keep=1 */,
output                                 test_rstn;                       // synthesis syn_keep=1 */,
input                                  T_osch;                          // synthesis syn_keep=1 */,
output                                 pd0_vol_on;                      // synthesis syn_keep=1 */,
output                                 pd10_vol_on;                     // synthesis syn_keep=1 */,
output                                 pd1_vol_on;                      // synthesis syn_keep=1 */,
output                                 pd2_vol_on;                      // synthesis syn_keep=1 */,
output                                 pd3_vol_on;                      // synthesis syn_keep=1 */,
output                                 pd4_vol_on;                      // synthesis syn_keep=1 */,
output                                 pd5_vol_on;                      // synthesis syn_keep=1 */,
output                                 pd6_vol_on;                      // synthesis syn_keep=1 */,
output                                 pd7_vol_on;                      // synthesis syn_keep=1 */,
output                                 pd8_vol_on;                      // synthesis syn_keep=1 */,
output                                 pd9_vol_on;                      // synthesis syn_keep=1 */,
output                                 aclk;
output                                 ahb2core_clken;
output                                 apb2ahb_clken;
output                                 apb2core_clken;
output                                 axi2core_clken;
output                   [(NHART-1):0] core_clk;
output                   [(NHART-1):0] dc_clk;
output                                 hclk;
output                                 l2_clk;
output                   [(NHART-1):0] lm_clk;
output                                 pclk;
output                                 pclk_gpio;
output                                 pclk_i2c;
output                                 pclk_pit;
output                                 pclk_spi1;
output                                 pclk_spi2;
output                                 pclk_uart1;
output                                 pclk_uart2;
output                                 pclk_wdt;
output                                 sdc_clk;
output                                 spi_clk;
output                                 uart_clk;
input                                  T_hw_rstn;
output                                 aresetn;
output                   [(NHART-1):0] core_l2_resetn;
output                   [(NHART-1):0] core_resetn;
input                                  dbg_srst_req;
output                                 hresetn;
input                                  init_calib_complete;
output                                 l2_resetn;
output                                 por_rstn;
output                                 presetn;
output                   [(NHART-1):0] slvp_resetn;
output                                 spi_rstn;
output                                 uart_rstn;
input                                  ui_clk;
input                                  wdt_rst;
output                         [511:0] core_reset_vectors;
output                                 pcs0_iso;                        // synthesis syn_keep=1 */,
output                                 pcs10_iso;
output                                 pcs1_iso;                        // synthesis syn_keep=1 */,
output                                 pcs2_iso;                        // synthesis syn_keep=1 */,
output                                 pcs3_iso;
output                                 pcs4_iso;
output                                 pcs5_iso;
output                                 pcs6_iso;
output                                 pcs7_iso;
output                                 pcs8_iso;
output                                 pcs9_iso;
output                          [31:0] smu_prdata;
output                                 smu_pready;
input                                  smu_psel;
output                                 smu_pslverr;
input       [`ATCAPBBRG100_ADDR_MSB:0] paddr;
input                                  penable;
input                           [31:0] pwdata;
input                                  pwrite;

wire                                   l2c_idle = 1'b0;
wire                                   l2c_pcs_standby_ok = 1'b1;

`ifdef AE350_RTC_SUPPORT
wire                                   rtc_int_period;
wire                                   alarm_wakeup;
wire                                   nds_unused_freq_test_en;
wire                                   nds_unused_freq_test_out;
wire                                   rtc_int_alarm;
wire                                   rtc_int_day;
wire                                   rtc_int_hour;
wire                                   rtc_int_hsec;
wire                                   rtc_int_min;
wire                                   rtc_int_sec;
`endif
`ifdef PLATFORM_DEBUG_SUBSYSTEM
wire                                   bus_clk;
wire                                   jdtm_tdi_in;
wire                                   jdtm_tms_in;
wire                            [31:0] dmi_haddr_32bit;
wire                                   jdtm_tdo_out;
wire                                   jdtm_tdo_out_en;
wire                                   jdtm_tms_out_en;
`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
wire                                   pin_tms_in_secure;
   `endif
`endif
wire                                   T_wakeup_in_pclk;
wire                             [7:0] cluster_iso_group;
wire                             [7:0] cluster_pwr_group;
wire                                   hart0_debugint;
wire                                   hart0_meip;
wire                                   hart0_msip;
wire                                   hart0_mtip;
wire                                   hart0_seip;
wire                                   hart0_standby_ok;
wire                                   hart0_ueip;
wire                                   mpd_por_rstn;
wire                                   pcs0_standby_ok;
wire                            [31:1] pcs0_wakeup_event;
wire                                   pcs10_standby_ok;
wire                            [31:1] pcs10_wakeup_event;
wire                                   pcs1_standby_ok;
wire                            [31:1] pcs1_wakeup_event;
wire                                   pcs2_standby_ok;
wire                            [31:1] pcs2_wakeup_event;
wire                                   pcs3_standby_ok;
wire                            [31:1] pcs3_wakeup_event;
wire                                   pcs4_standby_ok;
wire                            [31:1] pcs4_wakeup_event;
wire                                   pcs5_standby_ok;
wire                            [31:1] pcs5_wakeup_event;
wire                                   pcs6_standby_ok;
wire                            [31:1] pcs6_wakeup_event;
wire                                   pcs7_standby_ok;
wire                            [31:1] pcs7_wakeup_event;
wire                                   pcs8_standby_ok;
wire                            [31:1] pcs8_wakeup_event;
wire                                   pcs9_standby_ok;
wire                            [31:1] pcs9_wakeup_event;
wire                            [31:1] pcs_wakeup_event_general;
wire                                   T_aopd_por_b;
wire                                   T_om;
wire                                   T_oscl;
wire                                   T_tck;
wire                                   T_wakeup_in;
wire                                   test_clk;
wire                                   pcs0_vol_scale_ack;
wire                                   pcs10_vol_scale_ack;
wire                                   pcs1_vol_scale_ack;
wire                                   pcs2_vol_scale_ack;
wire                                   pcs3_vol_scale_ack;
wire                                   pcs4_vol_scale_ack;
wire                                   pcs5_vol_scale_ack;
wire                                   pcs6_vol_scale_ack;
wire                                   pcs7_vol_scale_ack;
wire                                   pcs8_vol_scale_ack;
wire                                   pcs9_vol_scale_ack;
wire                                   dbg_wakeup_req;
wire                                   aopd_clk_32k;
wire                                   aopd_dbg_tck;
wire                                   aopd_pclk;
wire                                   clk_32k;
wire                                   dm_clk;
wire                                   pcs0_frq_scale_ack;
wire                                   pcs10_frq_scale_ack;
wire                                   pcs1_frq_scale_ack;
wire                                   pcs2_frq_scale_ack;
wire                                   pcs3_frq_scale_ack;
wire                                   pcs4_frq_scale_ack;
wire                                   pcs5_frq_scale_ack;
wire                                   pcs6_frq_scale_ack;
wire                                   pcs7_frq_scale_ack;
wire                                   pcs8_frq_scale_ack;
wire                                   pcs9_frq_scale_ack;
wire                                   root_clk;
wire                                   aopd_por_dbg_rstn;
wire                                   aopd_por_rstn;
wire                                   aopd_prstn;
wire                                   aopd_rtc_rstn;
wire                                   main_rstn;
wire                                   main_rstn_csync;
wire                             [4:0] pcs0_reset_source;
wire                             [4:0] pcs10_reset_source;
wire                             [4:0] pcs1_reset_source;
wire                             [4:0] pcs2_reset_source;
wire                             [4:0] pcs3_reset_source;
wire                             [4:0] pcs4_reset_source;
wire                             [4:0] pcs5_reset_source;
wire                             [4:0] pcs6_reset_source;
wire                             [4:0] pcs7_reset_source;
wire                             [4:0] pcs8_reset_source;
wire                             [4:0] pcs9_reset_source;
wire                                   pldm_bus_resetn;
wire                                   por_b_psync;
wire                            [31:0] pcs0_frq_clkon;
wire                             [2:0] pcs0_frq_scale;
wire                                   pcs0_frq_scale_req;
wire                                   pcs0_int;
wire                             [3:0] pcs0_mem_init;
wire                                   pcs0_resetn;
wire                                   pcs0_reten;
wire                                   pcs0_standby_req;
wire                             [2:0] pcs0_vol_scale;
wire                                   pcs0_vol_scale_req;
wire                                   pcs0_wakeup;
wire                            [31:0] pcs10_frq_clkon;
wire                             [2:0] pcs10_frq_scale;
wire                                   pcs10_frq_scale_req;
wire                                   pcs10_int;
wire                             [3:0] pcs10_mem_init;
wire                                   pcs10_resetn;
wire                                   pcs10_reten;
wire                                   pcs10_slvp_resetn;
wire                                   pcs10_standby_req;
wire                             [2:0] pcs10_vol_scale;
wire                                   pcs10_vol_scale_req;
wire                                   pcs10_wakeup;
wire                            [31:0] pcs1_frq_clkon;
wire                             [2:0] pcs1_frq_scale;
wire                                   pcs1_frq_scale_req;
wire                                   pcs1_int;
wire                             [3:0] pcs1_mem_init;
wire                                   pcs1_resetn;
wire                                   pcs1_reten;
wire                                   pcs1_standby_req;
wire                             [2:0] pcs1_vol_scale;
wire                                   pcs1_vol_scale_req;
wire                                   pcs1_wakeup;
wire                            [31:0] pcs2_frq_clkon;
wire                             [2:0] pcs2_frq_scale;
wire                                   pcs2_frq_scale_req;
wire                                   pcs2_int;
wire                             [3:0] pcs2_mem_init;
wire                                   pcs2_resetn;
wire                                   pcs2_reten;
wire                                   pcs2_standby_req;
wire                             [2:0] pcs2_vol_scale;
wire                                   pcs2_vol_scale_req;
wire                                   pcs2_wakeup;
wire                            [31:0] pcs3_frq_clkon;
wire                             [2:0] pcs3_frq_scale;
wire                                   pcs3_frq_scale_req;
wire                                   pcs3_int;
wire                             [3:0] pcs3_mem_init;
wire                                   pcs3_resetn;
wire                                   pcs3_reten;
wire                                   pcs3_slvp_resetn;
wire                                   pcs3_standby_req;
wire                             [2:0] pcs3_vol_scale;
wire                                   pcs3_vol_scale_req;
wire                                   pcs3_wakeup;
wire                            [31:0] pcs4_frq_clkon;
wire                             [2:0] pcs4_frq_scale;
wire                                   pcs4_frq_scale_req;
wire                                   pcs4_int;
wire                             [3:0] pcs4_mem_init;
wire                                   pcs4_resetn;
wire                                   pcs4_reten;
wire                                   pcs4_slvp_resetn;
wire                                   pcs4_standby_req;
wire                             [2:0] pcs4_vol_scale;
wire                                   pcs4_vol_scale_req;
wire                                   pcs4_wakeup;
wire                            [31:0] pcs5_frq_clkon;
wire                             [2:0] pcs5_frq_scale;
wire                                   pcs5_frq_scale_req;
wire                                   pcs5_int;
wire                             [3:0] pcs5_mem_init;
wire                                   pcs5_resetn;
wire                                   pcs5_reten;
wire                                   pcs5_slvp_resetn;
wire                                   pcs5_standby_req;
wire                             [2:0] pcs5_vol_scale;
wire                                   pcs5_vol_scale_req;
wire                                   pcs5_wakeup;
wire                            [31:0] pcs6_frq_clkon;
wire                             [2:0] pcs6_frq_scale;
wire                                   pcs6_frq_scale_req;
wire                                   pcs6_int;
wire                             [3:0] pcs6_mem_init;
wire                                   pcs6_resetn;
wire                                   pcs6_reten;
wire                                   pcs6_slvp_resetn;
wire                                   pcs6_standby_req;
wire                             [2:0] pcs6_vol_scale;
wire                                   pcs6_vol_scale_req;
wire                                   pcs6_wakeup;
wire                            [31:0] pcs7_frq_clkon;
wire                             [2:0] pcs7_frq_scale;
wire                                   pcs7_frq_scale_req;
wire                                   pcs7_int;
wire                             [3:0] pcs7_mem_init;
wire                                   pcs7_resetn;
wire                                   pcs7_reten;
wire                                   pcs7_slvp_resetn;
wire                                   pcs7_standby_req;
wire                             [2:0] pcs7_vol_scale;
wire                                   pcs7_vol_scale_req;
wire                                   pcs7_wakeup;
wire                            [31:0] pcs8_frq_clkon;
wire                             [2:0] pcs8_frq_scale;
wire                                   pcs8_frq_scale_req;
wire                                   pcs8_int;
wire                             [3:0] pcs8_mem_init;
wire                                   pcs8_resetn;
wire                                   pcs8_reten;
wire                                   pcs8_slvp_resetn;
wire                                   pcs8_standby_req;
wire                             [2:0] pcs8_vol_scale;
wire                                   pcs8_vol_scale_req;
wire                                   pcs8_wakeup;
wire                            [31:0] pcs9_frq_clkon;
wire                             [2:0] pcs9_frq_scale;
wire                                   pcs9_frq_scale_req;
wire                                   pcs9_int;
wire                             [3:0] pcs9_mem_init;
wire                                   pcs9_resetn;
wire                                   pcs9_reten;
wire                                   pcs9_slvp_resetn;
wire                                   pcs9_standby_req;
wire                             [2:0] pcs9_vol_scale;
wire                                   pcs9_vol_scale_req;
wire                                   pcs9_wakeup;
wire                             [3:0] system_clock_ratio;

assign cluster_pwr_group = {pd10_vol_on, pd9_vol_on, pd8_vol_on, pd7_vol_on, pd6_vol_on, pd5_vol_on, pd4_vol_on, pd3_vol_on};
assign cluster_iso_group = {pcs10_iso, pcs9_iso, pcs8_iso, pcs7_iso, pcs6_iso, pcs5_iso, pcs4_iso, pcs3_iso};
assign cluster_pwr_on = |cluster_pwr_group[NHART-1:0];
assign cluster_iso_on = &cluster_iso_group[NHART-1:0];
assign mpd_por_rstn = por_b_psync;
assign extclk   = clk_32k;
assign pcs0_standby_ok = 1'b1;
assign pcs1_standby_ok = 1'b1;
assign pcs2_standby_ok = 1'b1;
assign pcs0_wakeup_event = pcs_wakeup_event_general;
assign pcs1_wakeup_event = pcs_wakeup_event_general;
assign pcs2_wakeup_event = pcs_wakeup_event_general;
assign hart0_icache_disable_init = ~pcs3_mem_init[0];
assign hart0_dcache_disable_init = ~pcs3_mem_init[1];
	assign hart0_standby_ok = hart0_core_wfi_mode;


assign pcs3_standby_ok = hart0_standby_ok;
		assign pcs4_standby_ok		 = 1'b1;
		assign pcs5_standby_ok		 = 1'b1;
		assign pcs6_standby_ok		 = 1'b1;
		assign pcs7_standby_ok		 = 1'b1;
		assign pcs8_standby_ok		 = 1'b1;
		assign pcs9_standby_ok		 = 1'b1;
		assign pcs10_standby_ok		 = 1'b1;

`ifdef AE350_RTC_SUPPORT
   assign int_src[1]  =  rtc_int_period;
   assign int_src[2]  =  rtc_int_alarm;
`else
   assign int_src[1]  =  1'b0;
   assign int_src[2]  =  1'b0;
`endif
assign int_src[3]  =  pit_intr;
assign int_src[4]  =  spi1_int;
assign int_src[5]  =  spi2_int;
assign int_src[6]  =  i2c_int;
assign int_src[7]  =  gpio_intr;
assign int_src[8]  =  uart1_int;
assign int_src[9]  =  uart2_int;
assign int_src[10] =  dma_int;
assign int_src[11] =  1'b0;
assign int_src[12] =  1'b0;
assign int_src[13] =  1'b0;
assign int_src[14] =  1'b0;
assign int_src[15] =  1'b0;
assign int_src[16] =  1'b0;

assign int_src[17] =  ssp_intr;
assign int_src[18] =  sdc_int;
assign int_src[19] =  mac_int;
assign int_src[20] =  lcd_intr;
assign int_src[21] =  1'b0;
assign int_src[22] =  1'b0;
assign int_src[23] =  1'b0;
assign int_src[24] =  1'b0;
assign int_src[25] =  1'b0;
assign int_src[26] =  1'b0;
assign int_src[27] =  1'b0;
assign int_src[28] =  1'b0;
assign int_src[29] =  1'b0;
assign int_src[30] =  1'b0;
assign int_src[31] =  1'b0;
wire  nds_unused_wakeup_rpulse;
wire  nds_unused_wakeup_fpulse;
wire  nds_unused_wakeup_pulse;
nds_sync_l2l T_wakeup_in_sync (
	.b_reset_n			(aopd_prstn),
	.b_clk				(aopd_pclk),
	.a_signal			(T_wakeup_in),
	.b_signal			(T_wakeup_in_pclk),
	.b_signal_rising_edge_pulse	(nds_unused_wakeup_rpulse),
	.b_signal_falling_edge_pulse	(nds_unused_wakeup_fpulse),
	.b_signal_edge_pulse		(nds_unused_wakeup_pulse)
);
assign hart0_meip     = hart0_wakeup_event[5];
assign hart0_seip     = hart0_wakeup_event[4];
assign hart0_ueip     = hart0_wakeup_event[3];
assign hart0_mtip     = hart0_wakeup_event[2];
assign hart0_msip     = hart0_wakeup_event[1];
assign hart0_debugint = hart0_wakeup_event[0];
assign pcs_wakeup_event_general[31:1] =
		 {hart0_meip|hart0_seip|hart0_ueip
		 ,hart0_mtip
		 ,hart0_msip
		 ,hart0_debugint
		 ,1'b0
		 ,1'b0
		 ,1'b0
		 ,1'b0
		 ,1'b0
		 ,T_wakeup_in_pclk
		 ,dbg_wakeup_req
		 ,int_src[20:1]};
assign pcs3_wakeup_event[31:1] =
		 {hart0_meip|hart0_seip|hart0_ueip
		 ,hart0_mtip
		 ,hart0_msip
		 ,hart0_debugint
		 ,wdt_int
		 ,6'd0
		 ,pcs_wakeup_event_general[20:1]};
assign pcs4_wakeup_event[31:1] =
		 31'b0;

assign pcs5_wakeup_event[31:1] =
		 31'b0;

assign pcs6_wakeup_event[31:1] =
		 31'b0;

assign pcs7_wakeup_event[31:1] =
		 31'b0;

assign pcs8_wakeup_event[31:1] =
		 31'b0;

assign pcs9_wakeup_event[31:1] =
		 31'b0;

assign pcs10_wakeup_event[31:1] =
		 31'b0;

`ifdef AE350_RTC_SUPPORT
   assign rtc_pslverr = 1'b0;
   assign rtc_pready  = 1'b1;
      `ifdef ATCRTC100_HALF_SECOND_SUPPORT
           assign rtc_int_period = rtc_int_hsec | rtc_int_sec | rtc_int_min | rtc_int_hour | rtc_int_day;
      `else
           assign rtc_int_period = rtc_int_sec | rtc_int_min | rtc_int_hour | rtc_int_day;
      `endif
`endif
`ifdef PLATFORM_DEBUG_SUBSYSTEM
	assign dmi_haddr = dmi_haddr_32bit[8:0];
	assign bus_clk = aclk;
`else
	assign dbg_wakeup_req = 1'b0;
`endif
`ifdef PLATFORM_DEBUG_SUBSYSTEM
	wire    unused_wire;
	assign	jdtm_tdi_in	= pin_tdi_in;
	`ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
		assign jdtm_tms_in = pin_tms_in_secure;
	`else
		assign jdtm_tms_in = pin_tms_in;
	`endif
	assign	pin_tdo_out	= jdtm_tdo_out;
	assign  pin_tdo_out_en	= jdtm_tdo_out_en;
	assign	pin_tms_out	= jdtm_tdo_out;
	assign	pin_tms_out_en	= jdtm_tms_out_en;
	assign  unused_wire     = pin_trst_in;
`endif









sample_ae350_smu sample_ae350_smu (
`ifdef NDS_FPGA
	.ddr3_bw_ctrl                  (ddr3_bw_ctrl                  ),
	.ddr3_latency                  (ddr3_latency                  ),
`endif
	.pcs4_slvp_resetn              (pcs4_slvp_resetn              ),

	.pcs5_slvp_resetn              (pcs5_slvp_resetn              ),

	.pcs6_slvp_resetn              (pcs6_slvp_resetn              ),

	.pcs7_slvp_resetn              (pcs7_slvp_resetn              ),

	.pcs8_slvp_resetn              (pcs8_slvp_resetn              ),

	.pcs9_slvp_resetn              (pcs9_slvp_resetn              ),

	.pcs10_slvp_resetn             (pcs10_slvp_resetn             ),

`ifdef NDS_FPGA
   `ifdef NDS_IO_PROBING
	.hart0_probe_current_pc        (hart0_probe_current_pc        ),
	.hart0_probe_gpr_index         (hart0_probe_gpr_index         ),
	.hart0_probe_selected_gpr_value(hart0_probe_selected_gpr_value),
   `endif
`endif
	.pcs0_resetn                   (pcs0_resetn                   ),
	.core_reset_vectors            (core_reset_vectors            ),
	.mpd_por_rstn                  (mpd_por_rstn                  ),
	.paddr                         (paddr[9:2]                    ),
	.penable                       (penable                       ),
	.prdata                        (smu_prdata                    ),
	.pready                        (smu_pready                    ),
	.psel                          (smu_psel                      ),
	.pslverr                       (smu_pslverr                   ),
	.pwdata                        (pwdata                        ),
	.pwrite                        (pwrite                        ),
	.system_clock_ratio            (system_clock_ratio            ),
	.pcs0_reset_source             (pcs0_reset_source             ),
	.pclk                          (aopd_pclk                     ),
	.presetn                       (aopd_por_dbg_rstn             ),
	.pcs1_reset_source             (pcs1_reset_source             ),
	.pcs10_reset_source            (pcs10_reset_source            ),
	.pcs2_reset_source             (pcs2_reset_source             ),
	.pcs3_reset_source             (pcs3_reset_source             ),
	.pcs4_reset_source             (pcs4_reset_source             ),
	.pcs5_reset_source             (pcs5_reset_source             ),
	.pcs6_reset_source             (pcs6_reset_source             ),
	.pcs7_reset_source             (pcs7_reset_source             ),
	.pcs8_reset_source             (pcs8_reset_source             ),
	.pcs9_reset_source             (pcs9_reset_source             ),
	.pcs0_frq_clkon                (pcs0_frq_clkon                ),
	.pcs0_frq_scale                (pcs0_frq_scale                ),
	.pcs0_frq_scale_ack            (pcs0_frq_scale_ack            ),
	.pcs0_frq_scale_req            (pcs0_frq_scale_req            ),
	.pcs0_int                      (pcs0_int                      ),
	.pcs0_iso                      (pcs0_iso                      ),
	.pcs0_mem_init                 (pcs0_mem_init                 ),
	.pcs0_reten                    (pcs0_reten                    ),
	.pcs0_standby_ok               (pcs0_standby_ok               ),
	.pcs0_standby_req              (pcs0_standby_req              ),
	.pcs0_vol_scale                (pcs0_vol_scale                ),
	.pcs0_vol_scale_ack            (pcs0_vol_scale_ack            ),
	.pcs0_vol_scale_req            (pcs0_vol_scale_req            ),
	.pcs0_wakeup                   (pcs0_wakeup                   ),
	.pcs0_wakeup_event             (pcs0_wakeup_event             ),
	.pcs1_frq_clkon                (pcs1_frq_clkon                ),
	.pcs1_frq_scale                (pcs1_frq_scale                ),
	.pcs1_frq_scale_ack            (pcs1_frq_scale_ack            ),
	.pcs1_frq_scale_req            (pcs1_frq_scale_req            ),
	.pcs1_int                      (pcs1_int                      ),
	.pcs1_iso                      (pcs1_iso                      ),
	.pcs1_mem_init                 (pcs1_mem_init                 ),
	.pcs1_resetn                   (pcs1_resetn                   ),
	.pcs1_reten                    (pcs1_reten                    ),
	.pcs1_standby_ok               (pcs1_standby_ok               ),
	.pcs1_standby_req              (pcs1_standby_req              ),
	.pcs1_vol_scale                (pcs1_vol_scale                ),
	.pcs1_vol_scale_ack            (pcs1_vol_scale_ack            ),
	.pcs1_vol_scale_req            (pcs1_vol_scale_req            ),
	.pcs1_wakeup                   (pcs1_wakeup                   ),
	.pcs1_wakeup_event             (pcs1_wakeup_event             ),
	.pcs10_frq_clkon               (pcs10_frq_clkon               ),
	.pcs10_frq_scale               (pcs10_frq_scale               ),
	.pcs10_frq_scale_ack           (pcs10_frq_scale_ack           ),
	.pcs10_frq_scale_req           (pcs10_frq_scale_req           ),
	.pcs10_int                     (pcs10_int                     ),
	.pcs10_iso                     (pcs10_iso                     ),
	.pcs10_mem_init                (pcs10_mem_init                ),
	.pcs10_resetn                  (pcs10_resetn                  ),
	.pcs10_reten                   (pcs10_reten                   ),
	.pcs10_standby_ok              (pcs10_standby_ok              ),
	.pcs10_standby_req             (pcs10_standby_req             ),
	.pcs10_vol_scale               (pcs10_vol_scale               ),
	.pcs10_vol_scale_ack           (pcs10_vol_scale_ack           ),
	.pcs10_vol_scale_req           (pcs10_vol_scale_req           ),
	.pcs10_wakeup                  (pcs10_wakeup                  ),
	.pcs10_wakeup_event            (pcs10_wakeup_event            ),
	.pcs2_frq_clkon                (pcs2_frq_clkon                ),
	.pcs2_frq_scale                (pcs2_frq_scale                ),
	.pcs2_frq_scale_ack            (pcs2_frq_scale_ack            ),
	.pcs2_frq_scale_req            (pcs2_frq_scale_req            ),
	.pcs2_int                      (pcs2_int                      ),
	.pcs2_iso                      (pcs2_iso                      ),
	.pcs2_mem_init                 (pcs2_mem_init                 ),
	.pcs2_resetn                   (pcs2_resetn                   ),
	.pcs2_reten                    (pcs2_reten                    ),
	.pcs2_standby_ok               (pcs2_standby_ok               ),
	.pcs2_standby_req              (pcs2_standby_req              ),
	.pcs2_vol_scale                (pcs2_vol_scale                ),
	.pcs2_vol_scale_ack            (pcs2_vol_scale_ack            ),
	.pcs2_vol_scale_req            (pcs2_vol_scale_req            ),
	.pcs2_wakeup                   (pcs2_wakeup                   ),
	.pcs2_wakeup_event             (pcs2_wakeup_event             ),
	.pcs3_frq_clkon                (pcs3_frq_clkon                ),
	.pcs3_frq_scale                (pcs3_frq_scale                ),
	.pcs3_frq_scale_ack            (pcs3_frq_scale_ack            ),
	.pcs3_frq_scale_req            (pcs3_frq_scale_req            ),
	.pcs3_int                      (pcs3_int                      ),
	.pcs3_iso                      (pcs3_iso                      ),
	.pcs3_mem_init                 (pcs3_mem_init                 ),
	.pcs3_resetn                   (pcs3_resetn                   ),
	.pcs3_reten                    (pcs3_reten                    ),
	.pcs3_slvp_resetn              (pcs3_slvp_resetn              ),
	.pcs3_standby_ok               (pcs3_standby_ok               ),
	.pcs3_standby_req              (pcs3_standby_req              ),
	.pcs3_vol_scale                (pcs3_vol_scale                ),
	.pcs3_vol_scale_ack            (pcs3_vol_scale_ack            ),
	.pcs3_vol_scale_req            (pcs3_vol_scale_req            ),
	.pcs3_wakeup                   (pcs3_wakeup                   ),
	.pcs3_wakeup_event             (pcs3_wakeup_event             ),
	.pcs4_frq_clkon                (pcs4_frq_clkon                ),
	.pcs4_frq_scale                (pcs4_frq_scale                ),
	.pcs4_frq_scale_ack            (pcs4_frq_scale_ack            ),
	.pcs4_frq_scale_req            (pcs4_frq_scale_req            ),
	.pcs4_int                      (pcs4_int                      ),
	.pcs4_iso                      (pcs4_iso                      ),
	.pcs4_mem_init                 (pcs4_mem_init                 ),
	.pcs4_resetn                   (pcs4_resetn                   ),
	.pcs4_reten                    (pcs4_reten                    ),
	.pcs4_standby_ok               (pcs4_standby_ok               ),
	.pcs4_standby_req              (pcs4_standby_req              ),
	.pcs4_vol_scale                (pcs4_vol_scale                ),
	.pcs4_vol_scale_ack            (pcs4_vol_scale_ack            ),
	.pcs4_vol_scale_req            (pcs4_vol_scale_req            ),
	.pcs4_wakeup                   (pcs4_wakeup                   ),
	.pcs4_wakeup_event             (pcs4_wakeup_event             ),
	.pcs5_frq_clkon                (pcs5_frq_clkon                ),
	.pcs5_frq_scale                (pcs5_frq_scale                ),
	.pcs5_frq_scale_ack            (pcs5_frq_scale_ack            ),
	.pcs5_frq_scale_req            (pcs5_frq_scale_req            ),
	.pcs5_int                      (pcs5_int                      ),
	.pcs5_iso                      (pcs5_iso                      ),
	.pcs5_mem_init                 (pcs5_mem_init                 ),
	.pcs5_resetn                   (pcs5_resetn                   ),
	.pcs5_reten                    (pcs5_reten                    ),
	.pcs5_standby_ok               (pcs5_standby_ok               ),
	.pcs5_standby_req              (pcs5_standby_req              ),
	.pcs5_vol_scale                (pcs5_vol_scale                ),
	.pcs5_vol_scale_ack            (pcs5_vol_scale_ack            ),
	.pcs5_vol_scale_req            (pcs5_vol_scale_req            ),
	.pcs5_wakeup                   (pcs5_wakeup                   ),
	.pcs5_wakeup_event             (pcs5_wakeup_event             ),
	.pcs6_frq_clkon                (pcs6_frq_clkon                ),
	.pcs6_frq_scale                (pcs6_frq_scale                ),
	.pcs6_frq_scale_ack            (pcs6_frq_scale_ack            ),
	.pcs6_frq_scale_req            (pcs6_frq_scale_req            ),
	.pcs6_int                      (pcs6_int                      ),
	.pcs6_iso                      (pcs6_iso                      ),
	.pcs6_mem_init                 (pcs6_mem_init                 ),
	.pcs6_resetn                   (pcs6_resetn                   ),
	.pcs6_reten                    (pcs6_reten                    ),
	.pcs6_standby_ok               (pcs6_standby_ok               ),
	.pcs6_standby_req              (pcs6_standby_req              ),
	.pcs6_vol_scale                (pcs6_vol_scale                ),
	.pcs6_vol_scale_ack            (pcs6_vol_scale_ack            ),
	.pcs6_vol_scale_req            (pcs6_vol_scale_req            ),
	.pcs6_wakeup                   (pcs6_wakeup                   ),
	.pcs6_wakeup_event             (pcs6_wakeup_event             ),
	.pcs7_frq_clkon                (pcs7_frq_clkon                ),
	.pcs7_frq_scale                (pcs7_frq_scale                ),
	.pcs7_frq_scale_ack            (pcs7_frq_scale_ack            ),
	.pcs7_frq_scale_req            (pcs7_frq_scale_req            ),
	.pcs7_int                      (pcs7_int                      ),
	.pcs7_iso                      (pcs7_iso                      ),
	.pcs7_mem_init                 (pcs7_mem_init                 ),
	.pcs7_resetn                   (pcs7_resetn                   ),
	.pcs7_reten                    (pcs7_reten                    ),
	.pcs7_standby_ok               (pcs7_standby_ok               ),
	.pcs7_standby_req              (pcs7_standby_req              ),
	.pcs7_vol_scale                (pcs7_vol_scale                ),
	.pcs7_vol_scale_ack            (pcs7_vol_scale_ack            ),
	.pcs7_vol_scale_req            (pcs7_vol_scale_req            ),
	.pcs7_wakeup                   (pcs7_wakeup                   ),
	.pcs7_wakeup_event             (pcs7_wakeup_event             ),
	.pcs8_frq_clkon                (pcs8_frq_clkon                ),
	.pcs8_frq_scale                (pcs8_frq_scale                ),
	.pcs8_frq_scale_ack            (pcs8_frq_scale_ack            ),
	.pcs8_frq_scale_req            (pcs8_frq_scale_req            ),
	.pcs8_int                      (pcs8_int                      ),
	.pcs8_iso                      (pcs8_iso                      ),
	.pcs8_mem_init                 (pcs8_mem_init                 ),
	.pcs8_resetn                   (pcs8_resetn                   ),
	.pcs8_reten                    (pcs8_reten                    ),
	.pcs8_standby_ok               (pcs8_standby_ok               ),
	.pcs8_standby_req              (pcs8_standby_req              ),
	.pcs8_vol_scale                (pcs8_vol_scale                ),
	.pcs8_vol_scale_ack            (pcs8_vol_scale_ack            ),
	.pcs8_vol_scale_req            (pcs8_vol_scale_req            ),
	.pcs8_wakeup                   (pcs8_wakeup                   ),
	.pcs8_wakeup_event             (pcs8_wakeup_event             ),
	.pcs9_frq_clkon                (pcs9_frq_clkon                ),
	.pcs9_frq_scale                (pcs9_frq_scale                ),
	.pcs9_frq_scale_ack            (pcs9_frq_scale_ack            ),
	.pcs9_frq_scale_req            (pcs9_frq_scale_req            ),
	.pcs9_int                      (pcs9_int                      ),
	.pcs9_iso                      (pcs9_iso                      ),
	.pcs9_mem_init                 (pcs9_mem_init                 ),
	.pcs9_resetn                   (pcs9_resetn                   ),
	.pcs9_reten                    (pcs9_reten                    ),
	.pcs9_standby_ok               (pcs9_standby_ok               ),
	.pcs9_standby_req              (pcs9_standby_req              ),
	.pcs9_vol_scale                (pcs9_vol_scale                ),
	.pcs9_vol_scale_ack            (pcs9_vol_scale_ack            ),
	.pcs9_vol_scale_req            (pcs9_vol_scale_req            ),
	.pcs9_wakeup                   (pcs9_wakeup                   ),
	.pcs9_wakeup_event             (pcs9_wakeup_event             )
);

ae350_aopd_pin ae350_aopd_pin (
`ifdef NDS_FPGA
`else
	.X_osclio        (X_osclio     ),
`endif
	.X_osclin        (X_osclin     ),
	.T_oscl          (T_oscl       ),
`ifdef PLATFORM_DEBUG_PORT
	.X_tck           (X_tck        ),
`endif
	.T_tck           (T_tck        ),
`ifdef NDS_FPGA
	.mpd_por_b       (T_por_b      ),
`else
	.X_aopd_por_b    (X_aopd_por_b ),
	.X_om            (X_om         ),
`endif
	.T_aopd_por_b    (T_aopd_por_b ),
	.T_om            (T_om         ),
	.X_wakeup_in     (X_wakeup_in  ),
	.T_wakeup_in     (T_wakeup_in  ),
`ifdef AE350_RTC_SUPPORT
   `ifdef NDS_FPGA
   `else
	.X_rtc_wakeup    (X_rtc_wakeup ),
	.rtc_alarm_wakeup(alarm_wakeup ),
   `endif
`endif
`ifdef NDS_FPGA
`else
	.X_mpd_pwr_off   (X_mpd_pwr_off),
`endif
	.mpd_pwr_off     (~pd2_vol_on  )
);

`ifdef AE350_RTC_SUPPORT
atcrtc100 u_rtc (
   `ifdef ATCRTC100_HALF_SECOND_SUPPORT
	.rtc_int_hsec (rtc_int_hsec            ),
   `endif
	.freq_test_en (nds_unused_freq_test_en ),
	.paddr        (paddr[5:2]              ),
	.penable      (penable                 ),
	.prdata       (rtc_prdata              ),
	.psel         (rtc_psel                ),
	.pwdata       (pwdata                  ),
	.pwrite       (pwrite                  ),
	.rtc_int_alarm(rtc_int_alarm           ),
	.rtc_int_day  (rtc_int_day             ),
	.rtc_int_hour (rtc_int_hour            ),
	.rtc_int_min  (rtc_int_min             ),
	.rtc_int_sec  (rtc_int_sec             ),
	.rtc_clk      (aopd_clk_32k            ),
	.rtc_rstn     (aopd_rtc_rstn           ),
	.pclk         (aopd_pclk               ),
	.presetn      (aopd_prstn              ),
	.alarm_wakeup (alarm_wakeup            ),
	.freq_test_out(nds_unused_freq_test_out)
);

`endif
sample_ae350_clkgen sample_ae350_clkgen (
	.root_clk           (root_clk           ),
	.test_mode          (test_mode          ),
	.test_clk           (test_clk           ),
`ifdef NDS_FPGA
`else
	.scan_test          (scan_test          ),
	.scan_enable        (scan_enable        ),
`endif
	.system_clock_ratio (system_clock_ratio ),
	.pcs0_frq_scale_req (pcs0_frq_scale_req ),
	.pcs0_frq_scale     (pcs0_frq_scale     ),
	.pcs0_frq_clkon     (pcs0_frq_clkon     ),
	.pcs0_frq_scale_ack (pcs0_frq_scale_ack ),
	.pcs1_frq_scale_req (pcs1_frq_scale_req ),
	.pcs1_frq_scale     (pcs1_frq_scale     ),
	.pcs1_frq_clkon     (pcs1_frq_clkon     ),
	.pcs1_frq_scale_ack (pcs1_frq_scale_ack ),
	.pcs2_frq_scale_req (pcs2_frq_scale_req ),
	.pcs2_frq_scale     (pcs2_frq_scale     ),
	.pcs2_frq_clkon     (pcs2_frq_clkon     ),
	.pcs2_frq_scale_ack (pcs2_frq_scale_ack ),
	.pcs3_frq_scale_req (pcs3_frq_scale_req ),
	.pcs3_frq_scale     (pcs3_frq_scale     ),
	.pcs3_frq_clkon     (pcs3_frq_clkon     ),
	.pcs3_frq_scale_ack (pcs3_frq_scale_ack ),
	.pcs4_frq_scale_req (pcs4_frq_scale_req ),
	.pcs4_frq_scale     (pcs4_frq_scale     ),
	.pcs4_frq_clkon     (pcs4_frq_clkon     ),
	.pcs4_frq_scale_ack (pcs4_frq_scale_ack ),
	.pcs5_frq_scale_req (pcs5_frq_scale_req ),
	.pcs5_frq_scale     (pcs5_frq_scale     ),
	.pcs5_frq_clkon     (pcs5_frq_clkon     ),
	.pcs5_frq_scale_ack (pcs5_frq_scale_ack ),
	.pcs6_frq_scale_req (pcs6_frq_scale_req ),
	.pcs6_frq_scale     (pcs6_frq_scale     ),
	.pcs6_frq_clkon     (pcs6_frq_clkon     ),
	.pcs6_frq_scale_ack (pcs6_frq_scale_ack ),
	.pcs7_frq_scale_req (pcs7_frq_scale_req ),
	.pcs7_frq_scale     (pcs7_frq_scale     ),
	.pcs7_frq_clkon     (pcs7_frq_clkon     ),
	.pcs7_frq_scale_ack (pcs7_frq_scale_ack ),
	.pcs8_frq_scale_req (pcs8_frq_scale_req ),
	.pcs8_frq_scale     (pcs8_frq_scale     ),
	.pcs8_frq_clkon     (pcs8_frq_clkon     ),
	.pcs8_frq_scale_ack (pcs8_frq_scale_ack ),
	.pcs9_frq_scale_req (pcs9_frq_scale_req ),
	.pcs9_frq_scale     (pcs9_frq_scale     ),
	.pcs9_frq_clkon     (pcs9_frq_clkon     ),
	.pcs9_frq_scale_ack (pcs9_frq_scale_ack ),
	.pcs10_frq_scale_req(pcs10_frq_scale_req),
	.pcs10_frq_scale    (pcs10_frq_scale    ),
	.pcs10_frq_clkon    (pcs10_frq_clkon    ),
	.pcs10_frq_scale_ack(pcs10_frq_scale_ack),
	.T_tck              (T_tck              ),
	.T_oscl             (T_oscl             ),
	.aopd_dbg_tck       (aopd_dbg_tck       ),
	.aopd_clk_32k       (aopd_clk_32k       ),
	.aopd_pclk          (aopd_pclk          ),
	.dm_clk             (dm_clk             ),
	.core_clk           (core_clk           ),
	.l2_clk             (l2_clk             ),
	.dc_clk             (dc_clk             ),
	.lm_clk             (lm_clk             ),
	.clk_32k            (clk_32k            ),
	.T_osch             (T_osch             ),
	.main_rstn          (main_rstn          ),
	.main_rstn_csync    (main_rstn_csync    ),
	.aopd_por_dbg_rstn  (aopd_por_dbg_rstn  ),
	.hresetn            (hresetn            ),
	.aclk               (aclk               ),
	.hclk               (hclk               ),
	.pclk               (pclk               ),
	.uart_clk           (uart_clk           ),
	.spi_clk            (spi_clk            ),
	.sdc_clk            (sdc_clk            ),
	.pclk_uart1         (pclk_uart1         ),
	.pclk_uart2         (pclk_uart2         ),
	.pclk_spi1          (pclk_spi1          ),
	.pclk_spi2          (pclk_spi2          ),
	.pclk_gpio          (pclk_gpio          ),
	.pclk_pit           (pclk_pit           ),
	.pclk_i2c           (pclk_i2c           ),
	.pclk_wdt           (pclk_wdt           ),
	.apb2ahb_clken      (apb2ahb_clken      ),
	.ahb2core_clken     (ahb2core_clken     ),
	.axi2core_clken     (axi2core_clken     ),
	.apb2core_clken     (apb2core_clken     )
);

sample_ae350_rstgen sample_ae350_rstgen (
	.test_mode          (test_mode          ),
	.test_rstn          (test_rstn          ),
	.pcs0_resetn        (pcs0_resetn        ),
	.pcs0_reset_source  (pcs0_reset_source  ),
	.pcs1_resetn        (pcs1_resetn        ),
	.pcs1_reset_source  (pcs1_reset_source  ),
	.pcs2_resetn        (pcs2_resetn        ),
	.pcs2_reset_source  (pcs2_reset_source  ),
	.pcs3_resetn        (pcs3_resetn        ),
	.pcs3_slvp_resetn   (pcs3_slvp_resetn   ),
	.pcs3_reset_source  (pcs3_reset_source  ),
	.pcs4_resetn        (pcs4_resetn        ),
	.pcs4_slvp_resetn   (pcs4_slvp_resetn   ),
	.pcs4_reset_source  (pcs4_reset_source  ),
	.pcs5_resetn        (pcs5_resetn        ),
	.pcs5_slvp_resetn   (pcs5_slvp_resetn   ),
	.pcs5_reset_source  (pcs5_reset_source  ),
	.pcs6_resetn        (pcs6_resetn        ),
	.pcs6_slvp_resetn   (pcs6_slvp_resetn   ),
	.pcs6_reset_source  (pcs6_reset_source  ),
	.pcs7_resetn        (pcs7_resetn        ),
	.pcs7_slvp_resetn   (pcs7_slvp_resetn   ),
	.pcs7_reset_source  (pcs7_reset_source  ),
	.pcs8_resetn        (pcs8_resetn        ),
	.pcs8_slvp_resetn   (pcs8_slvp_resetn   ),
	.pcs8_reset_source  (pcs8_reset_source  ),
	.pcs9_resetn        (pcs9_resetn        ),
	.pcs9_slvp_resetn   (pcs9_slvp_resetn   ),
	.pcs9_reset_source  (pcs9_reset_source  ),
	.pcs10_resetn       (pcs10_resetn       ),
	.pcs10_slvp_resetn  (pcs10_slvp_resetn  ),
	.pcs10_reset_source (pcs10_reset_source ),
	.T_aopd_por_b       (T_aopd_por_b       ),
	.aopd_pclk          (aopd_pclk          ),
	.aopd_clk_32k       (aopd_clk_32k       ),
	.aopd_dbg_tck       (aopd_dbg_tck       ),
	.aopd_prstn         (aopd_prstn         ),
	.aopd_rtc_rstn      (aopd_rtc_rstn      ),
	.aopd_por_rstn      (aopd_por_rstn      ),
	.aopd_por_dbg_rstn  (aopd_por_dbg_rstn  ),
	.dm_clk             (dm_clk             ),
	.pldm_bus_resetn    (pldm_bus_resetn    ),
	.T_por_b            (T_por_b            ),
	.dbg_srst_req       (dbg_srst_req       ),
	.T_osch             (T_osch             ),
	.uart_clk           (uart_clk           ),
	.spi_clk            (spi_clk            ),
	.pclk               (pclk               ),
	.hclk               (hclk               ),
	.aclk               (aclk               ),
	.core_clk           (core_clk           ),
	.l2_clk             (l2_clk             ),
	.root_clk           (root_clk           ),
	.T_hw_rstn          (T_hw_rstn          ),
	.wdt_rstn           (~wdt_rst           ),
	.init_calib_complete(init_calib_complete),
	.main_rstn          (main_rstn          ),
	.main_rstn_csync    (main_rstn_csync    ),
	.uart_rstn          (uart_rstn          ),
	.spi_rstn           (spi_rstn           ),
	.presetn            (presetn            ),
	.hresetn            (hresetn            ),
	.aresetn            (aresetn            ),
	.por_b_psync        (por_b_psync        ),
	.por_rstn           (por_rstn           ),
	.l2_resetn          (l2_resetn          ),
	.core_resetn        (core_resetn        ),
	.slvp_resetn        (slvp_resetn        ),
	.core_l2_resetn     (core_l2_resetn     )
);

ae350_vol_ctrl ae350_vol_ctrl (
	.pcs0_iso           (pcs0_iso           ),
	.pcs0_reten         (pcs0_reten         ),
	.pcs0_vol_scale_req (pcs0_vol_scale_req ),
	.pcs0_vol_scale     (pcs0_vol_scale     ),
	.pcs0_vol_scale_ack (pcs0_vol_scale_ack ),
	.pd0_vol_on         (pd0_vol_on         ),
	.pcs1_iso           (pcs1_iso           ),
	.pcs1_reten         (pcs1_reten         ),
	.pcs1_vol_scale_req (pcs1_vol_scale_req ),
	.pcs1_vol_scale     (pcs1_vol_scale     ),
	.pcs1_vol_scale_ack (pcs1_vol_scale_ack ),
	.pd1_vol_on         (pd1_vol_on         ),
	.pcs2_iso           (pcs2_iso           ),
	.pcs2_reten         (pcs2_reten         ),
	.pcs2_vol_scale_req (pcs2_vol_scale_req ),
	.pcs2_vol_scale     (pcs2_vol_scale     ),
	.pcs2_vol_scale_ack (pcs2_vol_scale_ack ),
	.pd2_vol_on         (pd2_vol_on         ),
	.pcs3_iso           (pcs3_iso           ),
	.pcs3_reten         (pcs3_reten         ),
	.pcs3_vol_scale_req (pcs3_vol_scale_req ),
	.pcs3_vol_scale     (pcs3_vol_scale     ),
	.pcs3_vol_scale_ack (pcs3_vol_scale_ack ),
	.pd3_vol_on         (pd3_vol_on         ),
	.pcs4_iso           (pcs4_iso           ),
	.pcs4_reten         (pcs4_reten         ),
	.pcs4_vol_scale_req (pcs4_vol_scale_req ),
	.pcs4_vol_scale     (pcs4_vol_scale     ),
	.pcs4_vol_scale_ack (pcs4_vol_scale_ack ),
	.pd4_vol_on         (pd4_vol_on         ),
	.pcs5_iso           (pcs5_iso           ),
	.pcs5_reten         (pcs5_reten         ),
	.pcs5_vol_scale_req (pcs5_vol_scale_req ),
	.pcs5_vol_scale     (pcs5_vol_scale     ),
	.pcs5_vol_scale_ack (pcs5_vol_scale_ack ),
	.pd5_vol_on         (pd5_vol_on         ),
	.pcs6_iso           (pcs6_iso           ),
	.pcs6_reten         (pcs6_reten         ),
	.pcs6_vol_scale_req (pcs6_vol_scale_req ),
	.pcs6_vol_scale     (pcs6_vol_scale     ),
	.pcs6_vol_scale_ack (pcs6_vol_scale_ack ),
	.pd6_vol_on         (pd6_vol_on         ),
	.pcs7_iso           (pcs7_iso           ),
	.pcs7_reten         (pcs7_reten         ),
	.pcs7_vol_scale_req (pcs7_vol_scale_req ),
	.pcs7_vol_scale     (pcs7_vol_scale     ),
	.pcs7_vol_scale_ack (pcs7_vol_scale_ack ),
	.pd7_vol_on         (pd7_vol_on         ),
	.pcs8_iso           (pcs8_iso           ),
	.pcs8_reten         (pcs8_reten         ),
	.pcs8_vol_scale_req (pcs8_vol_scale_req ),
	.pcs8_vol_scale     (pcs8_vol_scale     ),
	.pcs8_vol_scale_ack (pcs8_vol_scale_ack ),
	.pd8_vol_on         (pd8_vol_on         ),
	.pcs9_iso           (pcs9_iso           ),
	.pcs9_reten         (pcs9_reten         ),
	.pcs9_vol_scale_req (pcs9_vol_scale_req ),
	.pcs9_vol_scale     (pcs9_vol_scale     ),
	.pcs9_vol_scale_ack (pcs9_vol_scale_ack ),
	.pd9_vol_on         (pd9_vol_on         ),
	.pcs10_iso          (pcs10_iso          ),
	.pcs10_reten        (pcs10_reten        ),
	.pcs10_vol_scale_req(pcs10_vol_scale_req),
	.pcs10_vol_scale    (pcs10_vol_scale    ),
	.pcs10_vol_scale_ack(pcs10_vol_scale_ack),
	.pd10_vol_on        (pd10_vol_on        ),
	.aopd_clk_32k       (aopd_clk_32k       ),
	.aopd_rtc_rstn      (aopd_rtc_rstn      )
);

ae350_aopd_testgen ae350_aopd_testgen (
	.T_om        (T_om        ),
	.T_osch      (T_osch      ),
	.T_aopd_por_b(T_aopd_por_b),
	.test_mode   (test_mode   ),
	.test_clk    (test_clk    ),
	.test_rstn   (test_rstn   ),
	.scan_test   (scan_test   ),
	.scan_enable (scan_enable )
);

`ifdef PLATFORM_DEBUG_SUBSYSTEM
ncejdtm200 #(
	.DEBUG_INTERFACE (DEBUG_INTERFACE ),
	.SYNC_STAGE      (3               )
) ncejdtm200 (
	.dbg_wakeup_req(dbg_wakeup_req ),
	.tms_out_en    (jdtm_tms_out_en),
	.test_mode     (test_mode      ),
	.pwr_rst_n     (por_rstn       ),
	.tck           (aopd_dbg_tck   ),
	.tms           (jdtm_tms_in    ),
	.tdi           (jdtm_tdi_in    ),
	.tdo           (jdtm_tdo_out   ),
	.tdo_out_en    (jdtm_tdo_out_en),
	.dmi_hresetn   (dmi_resetn     ),
	.dmi_hclk      (bus_clk        ),
	.dmi_hsel      (dmi_hsel       ),
	.dmi_htrans    (dmi_htrans     ),
	.dmi_haddr     (dmi_haddr_32bit),
	.dmi_hsize     (dmi_hsize      ),
	.dmi_hburst    (dmi_hburst     ),
	.dmi_hprot     (dmi_hprot      ),
	.dmi_hwdata    (dmi_hwdata     ),
	.dmi_hwrite    (dmi_hwrite     ),
	.dmi_hrdata    (dmi_hrdata     ),
	.dmi_hready    (dmi_hready     ),
	.dmi_hresp     (dmi_hresp[0]   )
);

`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_NCEDBGLOCK100_SUPPORT
ncedbglock100 ncedbglock100 (
	.tck        (aopd_dbg_tck     ),
	.pwr_rst_n  (por_rstn         ),
	.secure_mode(secure_mode      ),
	.secure_code(secure_code      ),
	.tms_i      (pin_tms_in       ),
	.tms_o      (pin_tms_in_secure)
);

   `endif
`endif
endmodule

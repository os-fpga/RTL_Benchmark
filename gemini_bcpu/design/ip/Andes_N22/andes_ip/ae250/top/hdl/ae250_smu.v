// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "ae250_smu_config.vh"
`include "ae250_smu_const.vh"


module ae250_smu (
`ifdef NDS_FPGA
	  mpd_por_b,
	  smu_core_clk_2_hclk_ratio,
	  smu_hclk_2_pclk_ratio,
`else
	  X_om,
	  smu_core_clk_2_hclk_ratio,
	  smu_hclk_2_pclk_ratio,
`endif
`ifdef PLATFORM_DEBUG_PORT
	  X_tck,
`endif
`ifdef NDS_BOARD_CF1
	  cf1_pinmux_ctrl0,
	  cf1_pinmux_ctrl1,
`endif
	  dbg_wakeup_ack,
	  smu_core_clk_en,
	  smu_rstgen_core0_resetn,
	  X_aopd_por_b,
	  X_mpd_pwr_off,
	  X_osclin,
	  X_osclio,
	  X_rtc_wakeup,
	  X_wakeup_in,
	  clk_32k,
	  dbg_tck,
	  mpd_iso_en,
	  rtc_alarm_wakeup,
	  rtc_rstn,
	  test_clk,
	  test_mode,
	  test_rstn,
	  wdt_rstn,
	  mpd_por_b_psync,
	  core2smu_wfi_mode,
	  pwdata,
	  pclk,
	  dbg_wakeup_req,
	  dcache_disable_init,
	  icache_disable_init,
	  paddr,
	  penable,
	  prdata,
	  psel,
	  pwrite,
	  reset_vector,
	  smu_hclk_en,
	  smu_pclk_en,
	  sw_rstn,
	  presetn,
	  T_hw_rstn,
	  T_osch,
	  main_rstn,
	  smu2core_standby_req,
	  smu2core_wakeup_ok,
	  smu_core_clk_sel,
	  pd_clk_off,
	  pd_iso_en,
	  pd_pwr_off,
	  pd_ret_en,
	  pd_wakeup_event,
	  smu_interrupt_pd
);

parameter WAKEUP_WIDTH = 32'd32;

`ifdef NDS_FPGA
input                            mpd_por_b;
output                     [1:0] smu_core_clk_2_hclk_ratio;  // synthesis syn_keep=1	// Reset value must be 2'b00 to match the clock mux default
output                     [1:0] smu_hclk_2_pclk_ratio;      // synthesis syn_keep=1	// Reset value must be 2'b00 to match the clock mux default
`else
inout                            X_om;
output                     [1:0] smu_core_clk_2_hclk_ratio;
output                     [1:0] smu_hclk_2_pclk_ratio;
`endif
`ifdef PLATFORM_DEBUG_PORT
inout                            X_tck;
`endif
`ifdef NDS_BOARD_CF1
output                    [31:0] cf1_pinmux_ctrl0;
output                    [31:0] cf1_pinmux_ctrl1;
`endif
output                           dbg_wakeup_ack;
output                           smu_core_clk_en;
output                           smu_rstgen_core0_resetn;
inout                            X_aopd_por_b;
inout                            X_mpd_pwr_off;
input                            X_osclin;
inout                            X_osclio;
inout                            X_rtc_wakeup;
inout                            X_wakeup_in;
output                           clk_32k;
output                           dbg_tck;
output                           mpd_iso_en;
input                            rtc_alarm_wakeup;
output                           rtc_rstn;
output                           test_clk;
output                           test_mode;
output                           test_rstn;
input                            wdt_rstn;
input                            mpd_por_b_psync;
input                            core2smu_wfi_mode;
input                     [31:0] pwdata;
input                            pclk;
input                            dbg_wakeup_req;
output                           dcache_disable_init;
output                           icache_disable_init;
input                     [12:2] paddr;
input                            penable;
output                    [31:0] prdata;
input                            psel;
input                            pwrite;
output                    [31:0] reset_vector;
output                           smu_hclk_en;
output                     [8:0] smu_pclk_en;
output                           sw_rstn;
input                            presetn;
input                            T_hw_rstn;
input                            T_osch;
input                            main_rstn;
output                           smu2core_standby_req;
output                           smu2core_wakeup_ok;
output                           smu_core_clk_sel;
output                           pd_clk_off;
output                           pd_iso_en;
output                           pd_pwr_off;
output                           pd_ret_en;
input       [(WAKEUP_WIDTH-1):0] pd_wakeup_event;
output                           smu_interrupt_pd;

`ifdef AE250_SMU_SCRATCH_SUPPORT
wire        [(`AE250_SMU_SCRATCH_BIT-1):0] scratch_reg;
wire                                       scratch_wen;
`endif
wire                                 [1:0] core_wfi_mode;
wire                                       core_wfi_mode_all;
wire                                [10:8] wr_mask_reg;
wire                                       wrsr_alm_32k;
wire                                       wrsr_apor;
wire                                       wrsr_dbg_32k;
wire                                       wrsr_extw_32k;
wire                                       wrsr_hw_32k;
wire                                       wrsr_mpor;
wire                                       wrsr_sw;
wire                                       wrsr_wdt;
wire                                 [3:0] clock_ratio_reg;
wire                                       mpd_pwr_dis_wr_reg;
wire                                       smu_apbif_core_clk_en;
wire                                 [3:0] smu_iso_cyc;
wire                                       smu_iso_cyc_we;
wire                                 [2:0] smu_pwr_ctrl_cmd;
wire                                       smu_pwr_ctrl_cmd_we;
wire                                       smu_pwr_ctrl_int_en;
wire                                       smu_pwr_ctrl_int_en_we;
wire                                       smu_pwr_ctrl_int_pending_clr;
wire                                       smu_pwr_ctrl_int_pending_we;
wire                                 [3:0] smu_ret_cyc;
wire                                       smu_ret_cyc_we;
wire                  [(WAKEUP_WIDTH-1):0] smu_wakeup_enable;
wire                                       smu_wakeup_enable_we;
wire                                       standby_cmd_reg;
wire                                       wr_mask_wen;
wire                                       wrsr_wen;
wire                                       hw_rst_d2;
wire                                       standby_cmd_clr;
wire                                       wrsr_alm;
wire                                       wrsr_dbg;
wire                                       wrsr_extw;
wire                                       wrsr_hw;
wire                                       pd_rstn;
wire                                 [2:0] smu_pwr_ctrl_cmd_pending;
wire                                       smu_pwr_ctrl_int_pending;
wire                                 [2:0] smu_pwr_status;
wire                  [(WAKEUP_WIDTH-1):0] smu_wakeup_record;

assign smu_core_clk_en = smu_apbif_core_clk_en & (~pd_clk_off);
assign core_wfi_mode_all = &core_wfi_mode;
assign core_wfi_mode[0] = core2smu_wfi_mode;
assign smu_rstgen_core0_resetn = pd_rstn;
assign core_wfi_mode[1] = 1'b1;
assign dbg_wakeup_ack = 1'b1;

defparam ae250_smu_apbif.WAKEUP_WIDTH = WAKEUP_WIDTH;
ae250_smu_apbif ae250_smu_apbif (
	.pclk                        (pclk                        ),
	.presetn                     (presetn                     ),
	.psel                        (psel                        ),
	.penable                     (penable                     ),
	.paddr                       (paddr                       ),
	.pwdata                      (pwdata                      ),
	.pwrite                      (pwrite                      ),
	.prdata                      (prdata                      ),
	.mpd_por_b_psync             (mpd_por_b_psync             ),
	.wrsr_wen                    (wrsr_wen                    ),
	.wr_mask_wen                 (wr_mask_wen                 ),
	.wr_mask_reg                 (wr_mask_reg                 ),
	.wrsr_apor                   (wrsr_apor                   ),
	.wrsr_mpor                   (wrsr_mpor                   ),
	.wrsr_hw                     (wrsr_hw                     ),
	.wrsr_wdt                    (wrsr_wdt                    ),
	.wrsr_sw                     (wrsr_sw                     ),
	.wrsr_extw                   (wrsr_extw                   ),
	.wrsr_alm                    (wrsr_alm                    ),
	.wrsr_dbg                    (wrsr_dbg                    ),
`ifdef AE250_SMU_SCRATCH_SUPPORT
	.scratch_wen                 (scratch_wen                 ),
	.scratch_reg                 (scratch_reg                 ),
`endif
`ifdef NDS_BOARD_CF1
	.cf1_pinmux_ctrl0            (cf1_pinmux_ctrl0            ),
	.cf1_pinmux_ctrl1            (cf1_pinmux_ctrl1            ),
`endif
	.core2smu_wfi_mode           (core2smu_wfi_mode           ),
	.smu2core_wakeup_ok          (smu2core_wakeup_ok          ),
	.standby_cmd_reg             (standby_cmd_reg             ),
	.standby_cmd_clr             (standby_cmd_clr             ),
	.sw_rstn                     (sw_rstn                     ),
	.mpd_pwr_dis_wr_reg          (mpd_pwr_dis_wr_reg          ),
	.clock_ratio_reg             (clock_ratio_reg             ),
	.smu_core_clk_en             (smu_apbif_core_clk_en       ),
	.smu_hclk_en                 (smu_hclk_en                 ),
	.smu_pclk_en                 (smu_pclk_en                 ),
	.reset_vector                (reset_vector                ),
	.icache_disable_init         (icache_disable_init         ),
	.dcache_disable_init         (dcache_disable_init         ),
	.smu_pwr_ctrl_cmd_we         (smu_pwr_ctrl_cmd_we         ),
	.smu_pwr_ctrl_cmd            (smu_pwr_ctrl_cmd            ),
	.smu_iso_cyc_we              (smu_iso_cyc_we              ),
	.smu_iso_cyc                 (smu_iso_cyc                 ),
	.smu_ret_cyc_we              (smu_ret_cyc_we              ),
	.smu_ret_cyc                 (smu_ret_cyc                 ),
	.smu_wakeup_enable_we        (smu_wakeup_enable_we        ),
	.smu_wakeup_enable           (smu_wakeup_enable           ),
	.smu_pwr_ctrl_cmd_pending    (smu_pwr_ctrl_cmd_pending    ),
	.smu_pwr_status              (smu_pwr_status              ),
	.smu_wakeup_record           (smu_wakeup_record           ),
	.smu_pwr_ctrl_int_en_we      (smu_pwr_ctrl_int_en_we      ),
	.smu_pwr_ctrl_int_en         (smu_pwr_ctrl_int_en         ),
	.smu_pwr_ctrl_int_pending_we (smu_pwr_ctrl_int_pending_we ),
	.smu_pwr_ctrl_int_pending_clr(smu_pwr_ctrl_int_pending_clr),
	.smu_pwr_ctrl_int_pending    (smu_pwr_ctrl_int_pending    ),
	.dbg_wakeup_req              (dbg_wakeup_req              )
);

ae250_smu_mpd ae250_smu_mpd (
	.T_osch                   (T_osch                   ),
	.main_rstn                (main_rstn                ),
	.pclk                     (pclk                     ),
	.presetn                  (presetn                  ),
	.clk_32k                  (clk_32k                  ),
	.rtc_rstn                 (rtc_rstn                 ),
	.wrsr_wen                 (wrsr_wen                 ),
	.pwdata                   (pwdata                   ),
	.wrsr_hw_32k              (wrsr_hw_32k              ),
	.wrsr_extw_32k            (wrsr_extw_32k            ),
	.wrsr_alm_32k             (wrsr_alm_32k             ),
	.wrsr_dbg_32k             (wrsr_dbg_32k             ),
	.wrsr_hw                  (wrsr_hw                  ),
	.wrsr_extw                (wrsr_extw                ),
	.wrsr_alm                 (wrsr_alm                 ),
	.wrsr_dbg                 (wrsr_dbg                 ),
	.standby_cmd_reg          (standby_cmd_reg          ),
	.standby_cmd_clr          (standby_cmd_clr          ),
	.smu2core_standby_req     (smu2core_standby_req     ),
	.smu2core_wakeup_ok       (smu2core_wakeup_ok       ),
	.core2smu_wfi_mode        (core2smu_wfi_mode        ),
	.clock_ratio_reg          (clock_ratio_reg          ),
	.smu_core_clk_sel         (smu_core_clk_sel         ),
`ifdef NDS_FPGA
	.smu_core_clk_2_hclk_ratio(smu_core_clk_2_hclk_ratio),
	.smu_hclk_2_pclk_ratio    (smu_hclk_2_pclk_ratio    ),
`else
	.smu_core_clk_2_hclk_ratio(smu_core_clk_2_hclk_ratio),
	.smu_hclk_2_pclk_ratio    (smu_hclk_2_pclk_ratio    ),
`endif
	.T_hw_rstn                (T_hw_rstn                ),
	.hw_rst_d2                (hw_rst_d2                )
);

ae250_smu_aopd_top ae250_smu_aopd_top (
`ifdef NDS_FPGA
	.mpd_por_b         (mpd_por_b         ),
`else
	.X_om              (X_om              ),
`endif
`ifdef PLATFORM_DEBUG_PORT
	.X_tck             (X_tck             ),
`endif
`ifdef AE250_SMU_SCRATCH_SUPPORT
	.scratch_reg       (scratch_reg       ),
	.scratch_wen       (scratch_wen       ),
`endif
	.clk_32k           (clk_32k           ),
	.dbg_tck           (dbg_tck           ),
	.X_aopd_por_b      (X_aopd_por_b      ),
	.X_mpd_pwr_off     (X_mpd_pwr_off     ),
	.X_osclin          (X_osclin          ),
	.X_osclio          (X_osclio          ),
	.X_rtc_wakeup      (X_rtc_wakeup      ),
	.X_wakeup_in       (X_wakeup_in       ),
	.rtc_alarm_wakeup  (rtc_alarm_wakeup  ),
	.rtc_rstn          (rtc_rstn          ),
	.pclk              (pclk              ),
	.test_clk          (test_clk          ),
	.test_mode         (test_mode         ),
	.test_rstn         (test_rstn         ),
	.core2smu_wfi_mode (core2smu_wfi_mode ),
	.hw_rst_d2         (hw_rst_d2         ),
	.mpd_iso_en        (mpd_iso_en        ),
	.mpd_por_b_psync   (mpd_por_b_psync   ),
	.mpd_pwr_dis_wr_reg(mpd_pwr_dis_wr_reg),
	.pwdata            (pwdata            ),
	.sw_rstn           (sw_rstn           ),
	.wdt_rstn          (wdt_rstn          ),
	.wr_mask_reg       (wr_mask_reg       ),
	.wr_mask_wen       (wr_mask_wen       ),
	.wrsr_alm_32k      (wrsr_alm_32k      ),
	.wrsr_apor         (wrsr_apor         ),
	.wrsr_dbg_32k      (wrsr_dbg_32k      ),
	.wrsr_extw_32k     (wrsr_extw_32k     ),
	.wrsr_hw_32k       (wrsr_hw_32k       ),
	.wrsr_mpor         (wrsr_mpor         ),
	.wrsr_sw           (wrsr_sw           ),
	.wrsr_wdt          (wrsr_wdt          ),
	.wrsr_wen          (wrsr_wen          )
);

defparam ae250_smu_pd.WAKEUP_WIDTH = WAKEUP_WIDTH;
ae250_smu_pd ae250_smu_pd (
	.clk                         (pclk                        ),
	.rstn                        (presetn                     ),
	.smu_pwr_ctrl_cmd_we         (smu_pwr_ctrl_cmd_we         ),
	.smu_pwr_ctrl_cmd            (smu_pwr_ctrl_cmd            ),
	.smu_iso_cyc_we              (smu_iso_cyc_we              ),
	.smu_iso_cyc                 (smu_iso_cyc                 ),
	.smu_ret_cyc_we              (smu_ret_cyc_we              ),
	.smu_ret_cyc                 (smu_ret_cyc                 ),
	.smu_wakeup_enable_we        (smu_wakeup_enable_we        ),
	.smu_wakeup_enable           (smu_wakeup_enable           ),
	.smu_pwr_ctrl_int_en_we      (smu_pwr_ctrl_int_en_we      ),
	.smu_pwr_ctrl_int_en         (smu_pwr_ctrl_int_en         ),
	.smu_pwr_ctrl_int_pending_we (smu_pwr_ctrl_int_pending_we ),
	.smu_pwr_ctrl_int_pending_clr(smu_pwr_ctrl_int_pending_clr),
	.smu_pwr_ctrl_int_pending    (smu_pwr_ctrl_int_pending    ),
	.smu_pwr_ctrl_cmd_pending    (smu_pwr_ctrl_cmd_pending    ),
	.smu_pwr_status              (smu_pwr_status              ),
	.smu_wakeup_record           (smu_wakeup_record           ),
	.smu_interrupt_pd            (smu_interrupt_pd            ),
	.pd_standby                  (core_wfi_mode_all           ),
	.pd_clk_stable               (1'b1                        ),
	.pd_pwr_stable               (1'b1                        ),
	.pd_wakeup_event             (pd_wakeup_event             ),
	.pd_ret_en                   (pd_ret_en                   ),
	.pd_iso_en                   (pd_iso_en                   ),
	.pd_clk_off                  (pd_clk_off                  ),
	.pd_pwr_off                  (pd_pwr_off                  ),
	.pd_rstn                     (pd_rstn                     )
);

endmodule


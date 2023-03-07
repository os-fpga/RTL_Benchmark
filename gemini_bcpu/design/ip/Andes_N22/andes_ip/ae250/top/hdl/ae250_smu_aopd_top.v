// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "ae250_smu_config.vh"
`include "ae250_smu_const.vh"


module ae250_smu_aopd_top (
`ifdef NDS_FPGA
	  mpd_por_b,
`else
	  X_om,
`endif
`ifdef PLATFORM_DEBUG_PORT
	  X_tck,
`endif
`ifdef AE250_SMU_SCRATCH_SUPPORT
	  scratch_reg,
	  scratch_wen,
`endif
	  clk_32k,
	  dbg_tck,
	  X_aopd_por_b,
	  X_mpd_pwr_off,
	  X_osclin,
	  X_osclio,
	  X_rtc_wakeup,
	  X_wakeup_in,
	  rtc_alarm_wakeup,
	  rtc_rstn,
	  pclk,
	  test_clk,
	  test_mode,
	  test_rstn,
	  core2smu_wfi_mode,
	  hw_rst_d2,
	  mpd_iso_en,
	  mpd_por_b_psync,
	  mpd_pwr_dis_wr_reg,
	  pwdata,
	  sw_rstn,
	  wdt_rstn,
	  wr_mask_reg,
	  wr_mask_wen,
	  wrsr_alm_32k,
	  wrsr_apor,
	  wrsr_dbg_32k,
	  wrsr_extw_32k,
	  wrsr_hw_32k,
	  wrsr_mpor,
	  wrsr_sw,
	  wrsr_wdt,
	  wrsr_wen
);

`ifdef NDS_FPGA
input                                      mpd_por_b;
`else
inout                                      X_om;
`endif
`ifdef PLATFORM_DEBUG_PORT
inout                                      X_tck;
`endif
`ifdef AE250_SMU_SCRATCH_SUPPORT
output      [(`AE250_SMU_SCRATCH_BIT-1):0] scratch_reg;
input                                      scratch_wen;
`endif
output                                     clk_32k;
output                                     dbg_tck;
inout                                      X_aopd_por_b;
inout                                      X_mpd_pwr_off;
input                                      X_osclin;
inout                                      X_osclio;
inout                                      X_rtc_wakeup;
inout                                      X_wakeup_in;
input                                      rtc_alarm_wakeup;
output                                     rtc_rstn;
input                                      pclk;
output                                     test_clk;
output                                     test_mode;
output                                     test_rstn;
input                                      core2smu_wfi_mode;
input                                      hw_rst_d2;
output                                     mpd_iso_en;
input                                      mpd_por_b_psync;
input                                      mpd_pwr_dis_wr_reg;
input                               [31:0] pwdata;
input                                      sw_rstn;
input                                      wdt_rstn;
output                              [10:8] wr_mask_reg;
input                                      wr_mask_wen;
output                                     wrsr_alm_32k;
output                                     wrsr_apor;
output                                     wrsr_dbg_32k;
output                                     wrsr_extw_32k;
output                                     wrsr_hw_32k;
output                                     wrsr_mpor;
output                                     wrsr_sw;
output                                     wrsr_wdt;
input                                      wrsr_wen;

wire                                       T_aopd_por_b;
wire                                       T_om;
wire                                       T_oscl;
wire                                       T_tck;
wire                                       T_wakeup_in;
wire                                       aopd_por_b_psync;
wire                                       aopd_por_b_tsync;
wire                                       mpd_pwr_off;


ae250_smu_aopd_core u_smu_aopd_core (
	.clk_32k           (clk_32k           ),
	.rtc_rstn          (rtc_rstn          ),
	.pclk              (pclk              ),
	.dbg_tck           (dbg_tck           ),
	.tckc_rstn         (aopd_por_b_tsync  ),
	.pwdata            (pwdata            ),
	.aopd_prstn        (aopd_por_b_psync  ),
	.mpd_prstn         (mpd_por_b_psync   ),
	.hw_rst_d2         (hw_rst_d2         ),
	.wdt_rstn          (wdt_rstn          ),
	.sw_rstn           (sw_rstn           ),
	.core2smu_wfi_mode (core2smu_wfi_mode ),
	.rtc_alarm_wakeup  (rtc_alarm_wakeup  ),
	.T_wakeup_in       (T_wakeup_in       ),
	.wrsr_wen          (wrsr_wen          ),
	.wr_mask_wen       (wr_mask_wen       ),
	.wr_mask_reg       (wr_mask_reg       ),
	.mpd_pwr_dis_wr_reg(mpd_pwr_dis_wr_reg),
`ifdef AE250_SMU_SCRATCH_SUPPORT
	.scratch_wen       (scratch_wen       ),
	.scratch_reg       (scratch_reg       ),
`endif
	.wrsr_apor         (wrsr_apor         ),
	.wrsr_mpor         (wrsr_mpor         ),
	.wrsr_hw_32k       (wrsr_hw_32k       ),
	.wrsr_wdt          (wrsr_wdt          ),
	.wrsr_sw           (wrsr_sw           ),
	.wrsr_extw_32k     (wrsr_extw_32k     ),
	.wrsr_alm_32k      (wrsr_alm_32k      ),
	.wrsr_dbg_32k      (wrsr_dbg_32k      ),
	.mpd_pwr_off       (mpd_pwr_off       ),
	.mpd_iso_en        (mpd_iso_en        )
);

ae250_aopd_pin ae250_aopd_pin (
	.X_osclio        (X_osclio        ),
	.X_osclin        (X_osclin        ),
	.T_oscl          (T_oscl          ),
`ifdef PLATFORM_DEBUG_PORT
	.X_tck           (X_tck           ),
`endif
	.T_tck           (T_tck           ),
`ifdef NDS_FPGA
	.mpd_por_b       (mpd_por_b       ),
`else
	.X_aopd_por_b    (X_aopd_por_b    ),
`endif
	.T_aopd_por_b    (T_aopd_por_b    ),
`ifdef NDS_FPGA
`else
	.X_om            (X_om            ),
`endif
	.T_om            (T_om            ),
	.X_wakeup_in     (X_wakeup_in     ),
	.T_wakeup_in     (T_wakeup_in     ),
	.X_rtc_wakeup    (X_rtc_wakeup    ),
	.rtc_alarm_wakeup(rtc_alarm_wakeup),
	.X_mpd_pwr_off   (X_mpd_pwr_off   ),
	.mpd_pwr_off     (mpd_pwr_off     )
);

ae250_aopd_clkgen ae250_aopd_clkgen (
	.test_mode(test_mode),
	.test_clk (test_clk ),
	.clk_32k  (clk_32k  ),
	.T_oscl   (T_oscl   ),
	.dbg_tck  (dbg_tck  ),
	.T_tck    (T_tck    )
);

ae250_aopd_rstgen ae250_aopd_rstgen (
	.clk_32k         (clk_32k         ),
	.pclk            (pclk            ),
	.dbg_tck         (dbg_tck         ),
	.T_aopd_por_b    (T_aopd_por_b    ),
	.test_mode       (test_mode       ),
	.test_rstn       (test_rstn       ),
	.rtc_rstn        (rtc_rstn        ),
	.aopd_por_b_psync(aopd_por_b_psync),
	.aopd_por_b_tsync(aopd_por_b_tsync)
);

ae250_aopd_testgen ae250_aopd_testgen (
	.T_om        (T_om        ),
	.T_oscl      (T_oscl      ),
	.T_aopd_por_b(T_aopd_por_b),
	.test_mode   (test_mode   ),
	.test_clk    (test_clk    ),
	.test_rstn   (test_rstn   )
);

endmodule

// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcrtc100_config.vh"
`include "atcrtc100_const.vh"


module atcrtc100 (
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
	  rtc_int_hsec,
`endif
	  freq_test_en,
	  paddr,
	  penable,
	  prdata,
	  psel,
	  pwdata,
	  pwrite,
	  rtc_int_alarm,
	  rtc_int_day,
	  rtc_int_hour,
	  rtc_int_min,
	  rtc_int_sec,
	  rtc_clk,
	  rtc_rstn,
	  pclk,
	  presetn,
	  alarm_wakeup,
	  freq_test_out
);

`ifdef ATCRTC100_HALF_SECOND_SUPPORT
output             rtc_int_hsec;
`endif
output             freq_test_en;
input        [5:2] paddr;
input              penable;
output      [31:0] prdata;
input              psel;
input       [31:0] pwdata;
input              pwrite;
output             rtc_int_alarm;
output             rtc_int_day;
output             rtc_int_hour;
output             rtc_int_min;
output             rtc_int_sec;
input              rtc_clk;
input              rtc_rstn;
input              pclk;
input              presetn;
output             alarm_wakeup;
output             freq_test_out;

`ifdef ATCRTC100_HALF_SECOND_SUPPORT
wire                                   hsec_int_detect;
`endif
wire                                   alarm_wakeup_en_rtclk;
wire        [`ATCRTC100_SDO_WIDTH-1:0] ctr_sdo;
wire                                   ctr_upd_sync;
wire                             [4:0] reg_day_trim_rtclk;
wire                             [4:0] reg_hour_trim_rtclk;
wire                             [4:0] reg_min_trim_rtclk;
wire                             [4:0] reg_sec_trim_rtclk;
wire                                   reg_sign_day_trim_rtclk;
wire                                   reg_sign_hour_trim_rtclk;
wire                                   reg_sign_min_trim_rtclk;
wire                                   reg_sign_sec_trim_rtclk;
wire        [`ATCRTC100_ALM_WIDTH-1:0] rtc_alm_rtclk;
wire                                   rtc_en_rtclk;
wire                                   alarm_int_detect;
wire                                   day_int_detect;
wire                                   day_trim_trig;
wire                                   hour_int_detect;
wire                                   hour_trim_trig;
wire                                   min_int_detect;
wire                                   min_trim_trig;
wire                                   resume_trim_day;
wire                                   resume_trim_hour;
wire                                   resume_trim_min;
wire        [`ATCRTC100_SDO_WIDTH-1:0] rtc_ctr;
wire                                   sec_int_detect;
wire                                   rtc_1hz_pls;
wire                                   rtc_clk_falling_edge;


atcrtc100_pulsegen u_pulsegen (
	.rtc_rstn                (rtc_rstn                ),
	.rtc_clk                 (rtc_clk                 ),
	.rtc_en_rtclk            (rtc_en_rtclk            ),
	.rtc_1hz_pls             (rtc_1hz_pls             ),
	.ft_test_en              (freq_test_en            ),
	.ft_test_out             (freq_test_out           ),
	.reg_sec_trim_rtclk      (reg_sec_trim_rtclk      ),
	.reg_sign_sec_trim_rtclk (reg_sign_sec_trim_rtclk ),
	.reg_min_trim_rtclk      (reg_min_trim_rtclk      ),
	.reg_sign_min_trim_rtclk (reg_sign_min_trim_rtclk ),
	.reg_hour_trim_rtclk     (reg_hour_trim_rtclk     ),
	.reg_sign_hour_trim_rtclk(reg_sign_hour_trim_rtclk),
	.reg_day_trim_rtclk      (reg_day_trim_rtclk      ),
	.reg_sign_day_trim_rtclk (reg_sign_day_trim_rtclk ),
	.min_trim_trig           (min_trim_trig           ),
	.hour_trim_trig          (hour_trim_trig          ),
	.day_trim_trig           (day_trim_trig           ),
	.resume_trim_min         (resume_trim_min         ),
	.resume_trim_hour        (resume_trim_hour        ),
	.resume_trim_day         (resume_trim_day         ),
	.presetn                 (presetn                 ),
	.pclk                    (pclk                    ),
	.rtc_clk_falling_edge    (rtc_clk_falling_edge    )
);

atcrtc100_apbif u_apbif (
	.pclk                    (pclk                    ),
	.presetn                 (presetn                 ),
	.psel                    (psel                    ),
	.penable                 (penable                 ),
	.paddr                   (paddr                   ),
	.pwdata                  (pwdata                  ),
	.pwrite                  (pwrite                  ),
	.prdata                  (prdata                  ),
	.rtc_clk                 (rtc_clk                 ),
	.rtc_rstn                (rtc_rstn                ),
	.rtc_clk_falling_edge    (rtc_clk_falling_edge    ),
	.rtc_ctr                 (rtc_ctr                 ),
	.sec_int_detect          (sec_int_detect          ),
	.min_int_detect          (min_int_detect          ),
	.hour_int_detect         (hour_int_detect         ),
	.day_int_detect          (day_int_detect          ),
	.alarm_int_detect        (alarm_int_detect        ),
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
	.hsec_int_detect         (hsec_int_detect         ),
	.rtc_int_hsec            (rtc_int_hsec            ),
`endif
	.ctr_sdo                 (ctr_sdo                 ),
	.rtc_alm_rtclk           (rtc_alm_rtclk           ),
	.ctr_upd_sync            (ctr_upd_sync            ),
	.rtc_en_rtclk            (rtc_en_rtclk            ),
	.alarm_wakeup_en_rtclk   (alarm_wakeup_en_rtclk   ),
	.ft_en_rtclk             (freq_test_en            ),
	.rtc_int_sec             (rtc_int_sec             ),
	.rtc_int_min             (rtc_int_min             ),
	.rtc_int_hour            (rtc_int_hour            ),
	.rtc_int_day             (rtc_int_day             ),
	.rtc_int_alarm           (rtc_int_alarm           ),
	.reg_sec_trim_rtclk      (reg_sec_trim_rtclk      ),
	.reg_sign_sec_trim_rtclk (reg_sign_sec_trim_rtclk ),
	.reg_min_trim_rtclk      (reg_min_trim_rtclk      ),
	.reg_sign_min_trim_rtclk (reg_sign_min_trim_rtclk ),
	.reg_hour_trim_rtclk     (reg_hour_trim_rtclk     ),
	.reg_sign_hour_trim_rtclk(reg_sign_hour_trim_rtclk),
	.reg_day_trim_rtclk      (reg_day_trim_rtclk      ),
	.reg_sign_day_trim_rtclk (reg_sign_day_trim_rtclk )
);

atcrtc100_counter u_counter (
	.rtc_rstn             (rtc_rstn             ),
	.rtc_clk              (rtc_clk              ),
	.rtc_1hz_pls          (rtc_1hz_pls          ),
	.ctr_sdo              (ctr_sdo              ),
	.ctr_upd_sync         (ctr_upd_sync         ),
	.rtc_alm_rtclk        (rtc_alm_rtclk        ),
	.rtc_en_rtclk         (rtc_en_rtclk         ),
	.alarm_wakeup_en_rtclk(alarm_wakeup_en_rtclk),
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
	.hsec_int_detect      (hsec_int_detect      ),
`endif
	.sec_int_detect       (sec_int_detect       ),
	.min_int_detect       (min_int_detect       ),
	.hour_int_detect      (hour_int_detect      ),
	.day_int_detect       (day_int_detect       ),
	.alarm_int_detect     (alarm_int_detect     ),
	.alarm_wakeup         (alarm_wakeup         ),
	.rtc_ctr              (rtc_ctr              ),
	.min_trim_trig        (min_trim_trig        ),
	.hour_trim_trig       (hour_trim_trig       ),
	.day_trim_trig        (day_trim_trig        ),
	.resume_trim_min      (resume_trim_min      ),
	.resume_trim_hour     (resume_trim_hour     ),
	.resume_trim_day      (resume_trim_day      )
);

endmodule

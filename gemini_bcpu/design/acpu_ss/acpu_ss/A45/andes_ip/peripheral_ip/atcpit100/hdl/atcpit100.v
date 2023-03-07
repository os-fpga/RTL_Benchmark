// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcpit100_config.vh"
`include "atcpit100_const.vh"


module atcpit100 (
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
	  extclk,
	  paddr,
	  pclk,
	  penable,
	  pit_pause,
	  presetn,
	  psel,
	  pwdata,
	  pwrite,
	  ch0_pwm,
	  ch0_pwmoe,
	  pit_intr,
	  prdata
);

`ifdef ATCPIT100_CH1_SUPPORT
output             ch1_pwm;
output             ch1_pwmoe;
`endif
`ifdef ATCPIT100_CH2_SUPPORT
output             ch2_pwm;
output             ch2_pwmoe;
`endif
`ifdef ATCPIT100_CH3_SUPPORT
output             ch3_pwm;
output             ch3_pwmoe;
`endif
input              extclk;
input        [6:2] paddr;
input              pclk;
input              penable;
input              pit_pause;
input              presetn;
input              psel;
input       [31:0] pwdata;
input              pwrite;
output             ch0_pwm;
output             ch0_pwmoe;
output             pit_intr;
output      [31:0] prdata;

`ifdef ATCPIT100_CH1_SUPPORT
wire               ch1_chclk;
wire         [3:0] ch1_chen;
wire        [31:0] ch1_cntr;
wire         [3:0] ch1_intr_trig;
wire               ch1_mode_pwm;
wire               ch1_mode_pwm16;
wire               ch1_mode_pwm8;
wire               ch1_mode_tmr16;
wire               ch1_mode_tmr32;
wire               ch1_mode_tmr8;
wire               ch1_pwmpark;
wire        [31:0] ch1_reload;
`endif
`ifdef ATCPIT100_CH2_SUPPORT
wire               ch2_chclk;
wire         [3:0] ch2_chen;
wire        [31:0] ch2_cntr;
wire         [3:0] ch2_intr_trig;
wire               ch2_mode_pwm;
wire               ch2_mode_pwm16;
wire               ch2_mode_pwm8;
wire               ch2_mode_tmr16;
wire               ch2_mode_tmr32;
wire               ch2_mode_tmr8;
wire               ch2_pwmpark;
wire        [31:0] ch2_reload;
`endif
`ifdef ATCPIT100_CH3_SUPPORT
wire               ch3_chclk;
wire         [3:0] ch3_chen;
wire        [31:0] ch3_cntr;
wire         [3:0] ch3_intr_trig;
wire               ch3_mode_pwm;
wire               ch3_mode_pwm16;
wire               ch3_mode_pwm8;
wire               ch3_mode_tmr16;
wire               ch3_mode_tmr32;
wire               ch3_mode_tmr8;
wire               ch3_pwmpark;
wire        [31:0] ch3_reload;
`endif
wire               s0;
wire               s1;
wire               s2;
wire               s3;
wire               s4;
wire               s5;
wire               ch0_chclk;
wire         [3:0] ch0_chen;
wire        [31:0] ch0_cntr;
wire         [3:0] ch0_intr_trig;
wire               ch0_mode_pwm;
wire               ch0_mode_pwm16;
wire               ch0_mode_pwm8;
wire               ch0_mode_tmr16;
wire               ch0_mode_tmr32;
wire               ch0_mode_tmr8;
wire               ch0_pwmpark;
wire        [31:0] ch0_reload;
wire               extclk_en;
wire               s6;


atcpit100_apbslv u_apbslv (
	.pclk          (pclk          ),
	.presetn       (presetn       ),
	.psel          (psel          ),
	.penable       (penable       ),
	.pwrite        (pwrite        ),
	.paddr         (paddr         ),
	.pwdata        (pwdata        ),
	.prdata        (prdata        ),
	.pit_intr      (pit_intr      ),
`ifdef ATCPIT100_CH1_SUPPORT
	.ch1_intr_trig (ch1_intr_trig ),
	.ch1_cntr      (ch1_cntr      ),
	.ch1_reload    (ch1_reload    ),
	.ch1_mode_tmr32(ch1_mode_tmr32),
	.ch1_mode_tmr16(ch1_mode_tmr16),
	.ch1_mode_tmr8 (ch1_mode_tmr8 ),
	.ch1_mode_pwm  (ch1_mode_pwm  ),
	.ch1_mode_pwm16(ch1_mode_pwm16),
	.ch1_mode_pwm8 (ch1_mode_pwm8 ),
	.ch1_chclk     (ch1_chclk     ),
	.ch1_chen      (ch1_chen      ),
	.ch1_pwmpark   (ch1_pwmpark   ),
	.ch1_pwmoe     (ch1_pwmoe     ),
`endif
`ifdef ATCPIT100_CH2_SUPPORT
	.ch2_intr_trig (ch2_intr_trig ),
	.ch2_cntr      (ch2_cntr      ),
	.ch2_reload    (ch2_reload    ),
	.ch2_mode_tmr32(ch2_mode_tmr32),
	.ch2_mode_tmr16(ch2_mode_tmr16),
	.ch2_mode_tmr8 (ch2_mode_tmr8 ),
	.ch2_mode_pwm  (ch2_mode_pwm  ),
	.ch2_mode_pwm16(ch2_mode_pwm16),
	.ch2_mode_pwm8 (ch2_mode_pwm8 ),
	.ch2_chclk     (ch2_chclk     ),
	.ch2_chen      (ch2_chen      ),
	.ch2_pwmpark   (ch2_pwmpark   ),
	.ch2_pwmoe     (ch2_pwmoe     ),
`endif
`ifdef ATCPIT100_CH3_SUPPORT
	.ch3_intr_trig (ch3_intr_trig ),
	.ch3_cntr      (ch3_cntr      ),
	.ch3_reload    (ch3_reload    ),
	.ch3_mode_tmr32(ch3_mode_tmr32),
	.ch3_mode_tmr16(ch3_mode_tmr16),
	.ch3_mode_tmr8 (ch3_mode_tmr8 ),
	.ch3_mode_pwm  (ch3_mode_pwm  ),
	.ch3_mode_pwm16(ch3_mode_pwm16),
	.ch3_mode_pwm8 (ch3_mode_pwm8 ),
	.ch3_chclk     (ch3_chclk     ),
	.ch3_chen      (ch3_chen      ),
	.ch3_pwmpark   (ch3_pwmpark   ),
	.ch3_pwmoe     (ch3_pwmoe     ),
`endif
	.ch0_intr_trig (ch0_intr_trig ),
	.ch0_cntr      (ch0_cntr      ),
	.ch0_reload    (ch0_reload    ),
	.ch0_mode_tmr32(ch0_mode_tmr32),
	.ch0_mode_tmr16(ch0_mode_tmr16),
	.ch0_mode_tmr8 (ch0_mode_tmr8 ),
	.ch0_mode_pwm  (ch0_mode_pwm  ),
	.ch0_mode_pwm16(ch0_mode_pwm16),
	.ch0_mode_pwm8 (ch0_mode_pwm8 ),
	.ch0_chclk     (ch0_chclk     ),
	.ch0_chen      (ch0_chen      ),
	.ch0_pwmpark   (ch0_pwmpark   ),
	.ch0_pwmoe     (ch0_pwmoe     )
);

nds_sync_l2l u_sync_extclk (
	.b_reset_n                  (presetn                   ),
	.b_clk                      (pclk                      ),
	.a_signal                   (extclk                    ),
	.b_signal                   (s0        ),
	.b_signal_rising_edge_pulse (extclk_en                 ),
	.b_signal_falling_edge_pulse(s2),
	.b_signal_edge_pulse        (s1   )
);

nds_sync_l2l u_sync_pit_pause (
	.b_reset_n                  (presetn                  ),
	.b_clk                      (pclk                     ),
	.a_signal                   (pit_pause                ),
	.b_signal                   (s6          ),
	.b_signal_rising_edge_pulse (s5 ),
	.b_signal_falling_edge_pulse(s4),
	.b_signal_edge_pulse        (s3   )
);

atcpit100_ch u_ch0 (
	.pclk      (pclk           ),
	.presetn   (presetn        ),
	.extclk_en (extclk_en      ),
	.pit_pause (s6),
	.reload    (ch0_reload     ),
	.mode_tmr32(ch0_mode_tmr32 ),
	.mode_tmr16(ch0_mode_tmr16 ),
	.mode_tmr8 (ch0_mode_tmr8  ),
	.mode_pwm  (ch0_mode_pwm   ),
	.mode_pwm16(ch0_mode_pwm16 ),
	.mode_pwm8 (ch0_mode_pwm8  ),
	.ch_clk    (ch0_chclk      ),
	.ch_en     (ch0_chen       ),
	.pwm_park  (ch0_pwmpark    ),
	.intr_trig (ch0_intr_trig  ),
	.pwm       (ch0_pwm        ),
	.cntr      (ch0_cntr       )
);

`ifdef ATCPIT100_CH1_SUPPORT
atcpit100_ch u_ch1 (
	.pclk      (pclk           ),
	.presetn   (presetn        ),
	.extclk_en (extclk_en      ),
	.pit_pause (s6),
	.reload    (ch1_reload     ),
	.mode_tmr32(ch1_mode_tmr32 ),
	.mode_tmr16(ch1_mode_tmr16 ),
	.mode_tmr8 (ch1_mode_tmr8  ),
	.mode_pwm  (ch1_mode_pwm   ),
	.mode_pwm16(ch1_mode_pwm16 ),
	.mode_pwm8 (ch1_mode_pwm8  ),
	.ch_clk    (ch1_chclk      ),
	.ch_en     (ch1_chen       ),
	.pwm_park  (ch1_pwmpark    ),
	.intr_trig (ch1_intr_trig  ),
	.pwm       (ch1_pwm        ),
	.cntr      (ch1_cntr       )
);

`endif
`ifdef ATCPIT100_CH2_SUPPORT
atcpit100_ch u_ch2 (
	.pclk      (pclk           ),
	.presetn   (presetn        ),
	.extclk_en (extclk_en      ),
	.pit_pause (s6),
	.reload    (ch2_reload     ),
	.mode_tmr32(ch2_mode_tmr32 ),
	.mode_tmr16(ch2_mode_tmr16 ),
	.mode_tmr8 (ch2_mode_tmr8  ),
	.mode_pwm  (ch2_mode_pwm   ),
	.mode_pwm16(ch2_mode_pwm16 ),
	.mode_pwm8 (ch2_mode_pwm8  ),
	.ch_clk    (ch2_chclk      ),
	.ch_en     (ch2_chen       ),
	.pwm_park  (ch2_pwmpark    ),
	.intr_trig (ch2_intr_trig  ),
	.pwm       (ch2_pwm        ),
	.cntr      (ch2_cntr       )
);

`endif
`ifdef ATCPIT100_CH3_SUPPORT
atcpit100_ch u_ch3 (
	.pclk      (pclk           ),
	.presetn   (presetn        ),
	.extclk_en (extclk_en      ),
	.pit_pause (s6),
	.reload    (ch3_reload     ),
	.mode_tmr32(ch3_mode_tmr32 ),
	.mode_tmr16(ch3_mode_tmr16 ),
	.mode_tmr8 (ch3_mode_tmr8  ),
	.mode_pwm  (ch3_mode_pwm   ),
	.mode_pwm16(ch3_mode_pwm16 ),
	.mode_pwm8 (ch3_mode_pwm8  ),
	.ch_clk    (ch3_chclk      ),
	.ch_en     (ch3_chen       ),
	.pwm_park  (ch3_pwmpark    ),
	.intr_trig (ch3_intr_trig  ),
	.pwm       (ch3_pwm        ),
	.cntr      (ch3_cntr       )
);

`endif
endmodule

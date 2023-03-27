`include "config.inc"
`include "sample_ae350_smu_config.vh"
`include "sample_ae350_smu_const.vh"

module sample_ae350_smu (
`ifdef NDS_FPGA
	  ddr3_bw_ctrl,
	  ddr3_latency,
`endif
	  pcs4_slvp_resetn,

	  pcs5_slvp_resetn,

	  pcs6_slvp_resetn,

	  pcs7_slvp_resetn,

	  pcs8_slvp_resetn,

	  pcs9_slvp_resetn,

	  pcs10_slvp_resetn,

`ifdef NDS_FPGA
   `ifdef NDS_IO_PROBING
	  hart0_probe_current_pc,
	  hart0_probe_gpr_index,
	  hart0_probe_selected_gpr_value,
   `endif
`endif
	  pcs0_resetn,
	  core_reset_vectors,
	  mpd_por_rstn,
	  paddr,
	  penable,
	  prdata,
	  pready,
	  psel,
	  pslverr,
	  pwdata,
	  pwrite,
	  system_clock_ratio,
	  pcs0_reset_source,
	  pclk,
	  presetn,
	  pcs1_reset_source,
	  pcs10_reset_source,
	  pcs2_reset_source,
	  pcs3_reset_source,
	  pcs4_reset_source,
	  pcs5_reset_source,
	  pcs6_reset_source,
	  pcs7_reset_source,
	  pcs8_reset_source,
	  pcs9_reset_source,
	  pcs0_frq_clkon,
	  pcs0_frq_scale,
	  pcs0_frq_scale_ack,
	  pcs0_frq_scale_req,
	  pcs0_int,
	  pcs0_iso,
	  pcs0_mem_init,
	  pcs0_reten,
	  pcs0_standby_ok,
	  pcs0_standby_req,
	  pcs0_vol_scale,
	  pcs0_vol_scale_ack,
	  pcs0_vol_scale_req,
	  pcs0_wakeup,
	  pcs0_wakeup_event,
	  pcs1_frq_clkon,
	  pcs1_frq_scale,
	  pcs1_frq_scale_ack,
	  pcs1_frq_scale_req,
	  pcs1_int,
	  pcs1_iso,
	  pcs1_mem_init,
	  pcs1_resetn,
	  pcs1_reten,
	  pcs1_standby_ok,
	  pcs1_standby_req,
	  pcs1_vol_scale,
	  pcs1_vol_scale_ack,
	  pcs1_vol_scale_req,
	  pcs1_wakeup,
	  pcs1_wakeup_event,
	  pcs10_frq_clkon,
	  pcs10_frq_scale,
	  pcs10_frq_scale_ack,
	  pcs10_frq_scale_req,
	  pcs10_int,
	  pcs10_iso,
	  pcs10_mem_init,
	  pcs10_resetn,
	  pcs10_reten,
	  pcs10_standby_ok,
	  pcs10_standby_req,
	  pcs10_vol_scale,
	  pcs10_vol_scale_ack,
	  pcs10_vol_scale_req,
	  pcs10_wakeup,
	  pcs10_wakeup_event,
	  pcs2_frq_clkon,
	  pcs2_frq_scale,
	  pcs2_frq_scale_ack,
	  pcs2_frq_scale_req,
	  pcs2_int,
	  pcs2_iso,
	  pcs2_mem_init,
	  pcs2_resetn,
	  pcs2_reten,
	  pcs2_standby_ok,
	  pcs2_standby_req,
	  pcs2_vol_scale,
	  pcs2_vol_scale_ack,
	  pcs2_vol_scale_req,
	  pcs2_wakeup,
	  pcs2_wakeup_event,
	  pcs3_frq_clkon,
	  pcs3_frq_scale,
	  pcs3_frq_scale_ack,
	  pcs3_frq_scale_req,
	  pcs3_int,
	  pcs3_iso,
	  pcs3_mem_init,
	  pcs3_resetn,
	  pcs3_reten,
	  pcs3_slvp_resetn,
	  pcs3_standby_ok,
	  pcs3_standby_req,
	  pcs3_vol_scale,
	  pcs3_vol_scale_ack,
	  pcs3_vol_scale_req,
	  pcs3_wakeup,
	  pcs3_wakeup_event,
	  pcs4_frq_clkon,
	  pcs4_frq_scale,
	  pcs4_frq_scale_ack,
	  pcs4_frq_scale_req,
	  pcs4_int,
	  pcs4_iso,
	  pcs4_mem_init,
	  pcs4_resetn,
	  pcs4_reten,
	  pcs4_standby_ok,
	  pcs4_standby_req,
	  pcs4_vol_scale,
	  pcs4_vol_scale_ack,
	  pcs4_vol_scale_req,
	  pcs4_wakeup,
	  pcs4_wakeup_event,
	  pcs5_frq_clkon,
	  pcs5_frq_scale,
	  pcs5_frq_scale_ack,
	  pcs5_frq_scale_req,
	  pcs5_int,
	  pcs5_iso,
	  pcs5_mem_init,
	  pcs5_resetn,
	  pcs5_reten,
	  pcs5_standby_ok,
	  pcs5_standby_req,
	  pcs5_vol_scale,
	  pcs5_vol_scale_ack,
	  pcs5_vol_scale_req,
	  pcs5_wakeup,
	  pcs5_wakeup_event,
	  pcs6_frq_clkon,
	  pcs6_frq_scale,
	  pcs6_frq_scale_ack,
	  pcs6_frq_scale_req,
	  pcs6_int,
	  pcs6_iso,
	  pcs6_mem_init,
	  pcs6_resetn,
	  pcs6_reten,
	  pcs6_standby_ok,
	  pcs6_standby_req,
	  pcs6_vol_scale,
	  pcs6_vol_scale_ack,
	  pcs6_vol_scale_req,
	  pcs6_wakeup,
	  pcs6_wakeup_event,
	  pcs7_frq_clkon,
	  pcs7_frq_scale,
	  pcs7_frq_scale_ack,
	  pcs7_frq_scale_req,
	  pcs7_int,
	  pcs7_iso,
	  pcs7_mem_init,
	  pcs7_resetn,
	  pcs7_reten,
	  pcs7_standby_ok,
	  pcs7_standby_req,
	  pcs7_vol_scale,
	  pcs7_vol_scale_ack,
	  pcs7_vol_scale_req,
	  pcs7_wakeup,
	  pcs7_wakeup_event,
	  pcs8_frq_clkon,
	  pcs8_frq_scale,
	  pcs8_frq_scale_ack,
	  pcs8_frq_scale_req,
	  pcs8_int,
	  pcs8_iso,
	  pcs8_mem_init,
	  pcs8_resetn,
	  pcs8_reten,
	  pcs8_standby_ok,
	  pcs8_standby_req,
	  pcs8_vol_scale,
	  pcs8_vol_scale_ack,
	  pcs8_vol_scale_req,
	  pcs8_wakeup,
	  pcs8_wakeup_event,
	  pcs9_frq_clkon,
	  pcs9_frq_scale,
	  pcs9_frq_scale_ack,
	  pcs9_frq_scale_req,
	  pcs9_int,
	  pcs9_iso,
	  pcs9_mem_init,
	  pcs9_resetn,
	  pcs9_reten,
	  pcs9_standby_ok,
	  pcs9_standby_req,
	  pcs9_vol_scale,
	  pcs9_vol_scale_ack,
	  pcs9_vol_scale_req,
	  pcs9_wakeup,
	  pcs9_wakeup_event
);

parameter PCS_NUM = 11;

`ifdef NDS_FPGA
output        [1:0] ddr3_bw_ctrl;
output        [3:0] ddr3_latency;
`endif
output              pcs4_slvp_resetn;

output              pcs5_slvp_resetn;

output              pcs6_slvp_resetn;

output              pcs7_slvp_resetn;

output              pcs8_slvp_resetn;

output              pcs9_slvp_resetn;

output              pcs10_slvp_resetn;

`ifdef NDS_FPGA
   `ifdef NDS_IO_PROBING
input        [31:0] hart0_probe_current_pc;
output       [12:0] hart0_probe_gpr_index;
input        [31:0] hart0_probe_selected_gpr_value;
   `endif
`endif
output              pcs0_resetn;
output   [64*8-1:0] core_reset_vectors;
input               mpd_por_rstn;
input         [9:2] paddr;
input               penable;
output       [31:0] prdata;
output              pready;
input               psel;
output              pslverr;
input        [31:0] pwdata;
input               pwrite;
output        [3:0] system_clock_ratio;
input         [4:0] pcs0_reset_source;
input               pclk;
input               presetn;
input         [4:0] pcs1_reset_source;
input         [4:0] pcs10_reset_source;
input         [4:0] pcs2_reset_source;
input         [4:0] pcs3_reset_source;
input         [4:0] pcs4_reset_source;
input         [4:0] pcs5_reset_source;
input         [4:0] pcs6_reset_source;
input         [4:0] pcs7_reset_source;
input         [4:0] pcs8_reset_source;
input         [4:0] pcs9_reset_source;
output       [31:0] pcs0_frq_clkon;
output        [2:0] pcs0_frq_scale;
input               pcs0_frq_scale_ack;
output              pcs0_frq_scale_req;
output              pcs0_int;
output              pcs0_iso;
output        [3:0] pcs0_mem_init;
output              pcs0_reten;
input               pcs0_standby_ok;
output              pcs0_standby_req;
output        [2:0] pcs0_vol_scale;
input               pcs0_vol_scale_ack;
output              pcs0_vol_scale_req;
output              pcs0_wakeup;
input        [31:1] pcs0_wakeup_event;
output       [31:0] pcs1_frq_clkon;
output        [2:0] pcs1_frq_scale;
input               pcs1_frq_scale_ack;
output              pcs1_frq_scale_req;
output              pcs1_int;
output              pcs1_iso;
output        [3:0] pcs1_mem_init;
output              pcs1_resetn;
output              pcs1_reten;
input               pcs1_standby_ok;
output              pcs1_standby_req;
output        [2:0] pcs1_vol_scale;
input               pcs1_vol_scale_ack;
output              pcs1_vol_scale_req;
output              pcs1_wakeup;
input        [31:1] pcs1_wakeup_event;
output       [31:0] pcs10_frq_clkon;
output        [2:0] pcs10_frq_scale;
input               pcs10_frq_scale_ack;
output              pcs10_frq_scale_req;
output              pcs10_int;
output              pcs10_iso;
output        [3:0] pcs10_mem_init;
output              pcs10_resetn;
output              pcs10_reten;
input               pcs10_standby_ok;
output              pcs10_standby_req;
output        [2:0] pcs10_vol_scale;
input               pcs10_vol_scale_ack;
output              pcs10_vol_scale_req;
output              pcs10_wakeup;
input        [31:1] pcs10_wakeup_event;
output       [31:0] pcs2_frq_clkon;
output        [2:0] pcs2_frq_scale;
input               pcs2_frq_scale_ack;
output              pcs2_frq_scale_req;
output              pcs2_int;
output              pcs2_iso;
output        [3:0] pcs2_mem_init;
output              pcs2_resetn;
output              pcs2_reten;
input               pcs2_standby_ok;
output              pcs2_standby_req;
output        [2:0] pcs2_vol_scale;
input               pcs2_vol_scale_ack;
output              pcs2_vol_scale_req;
output              pcs2_wakeup;
input        [31:1] pcs2_wakeup_event;
output       [31:0] pcs3_frq_clkon;
output        [2:0] pcs3_frq_scale;
input               pcs3_frq_scale_ack;
output              pcs3_frq_scale_req;
output              pcs3_int;
output              pcs3_iso;
output        [3:0] pcs3_mem_init;
output              pcs3_resetn;
output              pcs3_reten;
output              pcs3_slvp_resetn;
input               pcs3_standby_ok;
output              pcs3_standby_req;
output        [2:0] pcs3_vol_scale;
input               pcs3_vol_scale_ack;
output              pcs3_vol_scale_req;
output              pcs3_wakeup;
input        [31:1] pcs3_wakeup_event;
output       [31:0] pcs4_frq_clkon;
output        [2:0] pcs4_frq_scale;
input               pcs4_frq_scale_ack;
output              pcs4_frq_scale_req;
output              pcs4_int;
output              pcs4_iso;
output        [3:0] pcs4_mem_init;
output              pcs4_resetn;
output              pcs4_reten;
input               pcs4_standby_ok;
output              pcs4_standby_req;
output        [2:0] pcs4_vol_scale;
input               pcs4_vol_scale_ack;
output              pcs4_vol_scale_req;
output              pcs4_wakeup;
input        [31:1] pcs4_wakeup_event;
output       [31:0] pcs5_frq_clkon;
output        [2:0] pcs5_frq_scale;
input               pcs5_frq_scale_ack;
output              pcs5_frq_scale_req;
output              pcs5_int;
output              pcs5_iso;
output        [3:0] pcs5_mem_init;
output              pcs5_resetn;
output              pcs5_reten;
input               pcs5_standby_ok;
output              pcs5_standby_req;
output        [2:0] pcs5_vol_scale;
input               pcs5_vol_scale_ack;
output              pcs5_vol_scale_req;
output              pcs5_wakeup;
input        [31:1] pcs5_wakeup_event;
output       [31:0] pcs6_frq_clkon;
output        [2:0] pcs6_frq_scale;
input               pcs6_frq_scale_ack;
output              pcs6_frq_scale_req;
output              pcs6_int;
output              pcs6_iso;
output        [3:0] pcs6_mem_init;
output              pcs6_resetn;
output              pcs6_reten;
input               pcs6_standby_ok;
output              pcs6_standby_req;
output        [2:0] pcs6_vol_scale;
input               pcs6_vol_scale_ack;
output              pcs6_vol_scale_req;
output              pcs6_wakeup;
input        [31:1] pcs6_wakeup_event;
output       [31:0] pcs7_frq_clkon;
output        [2:0] pcs7_frq_scale;
input               pcs7_frq_scale_ack;
output              pcs7_frq_scale_req;
output              pcs7_int;
output              pcs7_iso;
output        [3:0] pcs7_mem_init;
output              pcs7_resetn;
output              pcs7_reten;
input               pcs7_standby_ok;
output              pcs7_standby_req;
output        [2:0] pcs7_vol_scale;
input               pcs7_vol_scale_ack;
output              pcs7_vol_scale_req;
output              pcs7_wakeup;
input        [31:1] pcs7_wakeup_event;
output       [31:0] pcs8_frq_clkon;
output        [2:0] pcs8_frq_scale;
input               pcs8_frq_scale_ack;
output              pcs8_frq_scale_req;
output              pcs8_int;
output              pcs8_iso;
output        [3:0] pcs8_mem_init;
output              pcs8_resetn;
output              pcs8_reten;
input               pcs8_standby_ok;
output              pcs8_standby_req;
output        [2:0] pcs8_vol_scale;
input               pcs8_vol_scale_ack;
output              pcs8_vol_scale_req;
output              pcs8_wakeup;
input        [31:1] pcs8_wakeup_event;
output       [31:0] pcs9_frq_clkon;
output        [2:0] pcs9_frq_scale;
input               pcs9_frq_scale_ack;
output              pcs9_frq_scale_req;
output              pcs9_int;
output              pcs9_iso;
output        [3:0] pcs9_mem_init;
output              pcs9_resetn;
output              pcs9_reten;
input               pcs9_standby_ok;
output              pcs9_standby_req;
output        [2:0] pcs9_vol_scale;
input               pcs9_vol_scale_ack;
output              pcs9_vol_scale_req;
output              pcs9_wakeup;
input        [31:1] pcs9_wakeup_event;

wire         [31:0] pcs_hart_resetn;
wire         [10:0] pcs_sel;
wire                pcs_sel_cer;
wire                pcs_sel_cfg;
wire                pcs_sel_ctl;
wire                pcs_sel_misc;
wire                pcs_sel_misc2;
wire                pcs_sel_scratch;
wire                pcs_sel_status;
wire                pcs_sel_we;
wire         [31:0] pcs_wdata;
wire                pcs_write;
wire                smu_sw_rst;
wire         [31:0] pcs0_rdata;
wire                pcs0_resetn_new;
wire         [31:0] pcs1_rdata;
wire         [31:0] pcs10_rdata;
wire         [31:0] pcs2_rdata;
wire         [31:0] pcs3_rdata;
wire         [31:0] pcs4_rdata;
wire         [31:0] pcs5_rdata;
wire         [31:0] pcs6_rdata;
wire         [31:0] pcs7_rdata;
wire         [31:0] pcs8_rdata;
wire         [31:0] pcs9_rdata;

assign pcs0_resetn = pcs0_resetn_new & ~smu_sw_rst;
assign pcs4_slvp_resetn = 1'b1;

assign pcs5_slvp_resetn = 1'b1;

assign pcs6_slvp_resetn = 1'b1;

assign pcs7_slvp_resetn = 1'b1;

assign pcs8_slvp_resetn = 1'b1;

assign pcs9_slvp_resetn = 1'b1;

assign pcs10_slvp_resetn = 1'b1;


sample_ae350_smu_apbif #(
	.PCS_NUM         (PCS_NUM         )
) smu_apbif (
	.mpd_por_rstn                  (mpd_por_rstn                  ),
	.pclk                          (pclk                          ),
	.presetn                       (presetn                       ),
	.psel                          (psel                          ),
	.penable                       (penable                       ),
	.paddr                         (paddr                         ),
	.pwdata                        (pwdata                        ),
	.pwrite                        (pwrite                        ),
	.prdata                        (prdata                        ),
	.pready                        (pready                        ),
	.pslverr                       (pslverr                       ),
	.pcs0_rdata                    (pcs0_rdata                    ),
	.pcs1_rdata                    (pcs1_rdata                    ),
	.pcs2_rdata                    (pcs2_rdata                    ),
	.pcs3_rdata                    (pcs3_rdata                    ),
	.pcs4_rdata                    (pcs4_rdata                    ),
	.pcs5_rdata                    (pcs5_rdata                    ),
	.pcs6_rdata                    (pcs6_rdata                    ),
	.pcs7_rdata                    (pcs7_rdata                    ),
	.pcs8_rdata                    (pcs8_rdata                    ),
	.pcs9_rdata                    (pcs9_rdata                    ),
	.pcs10_rdata                   (pcs10_rdata                   ),
	.pcs0_reset_source             (pcs0_reset_source             ),
	.pcs1_reset_source             (pcs1_reset_source             ),
	.pcs2_reset_source             (pcs2_reset_source             ),
	.pcs3_reset_source             (pcs3_reset_source             ),
	.pcs4_reset_source             (pcs4_reset_source             ),
	.pcs5_reset_source             (pcs5_reset_source             ),
	.pcs6_reset_source             (pcs6_reset_source             ),
	.pcs7_reset_source             (pcs7_reset_source             ),
	.pcs8_reset_source             (pcs8_reset_source             ),
	.pcs9_reset_source             (pcs9_reset_source             ),
	.pcs10_reset_source            (pcs10_reset_source            ),
	.pcs_sel                       (pcs_sel                       ),
	.pcs_wdata                     (pcs_wdata                     ),
	.pcs_write                     (pcs_write                     ),
	.pcs_sel_cfg                   (pcs_sel_cfg                   ),
	.pcs_sel_scratch               (pcs_sel_scratch               ),
	.pcs_sel_misc                  (pcs_sel_misc                  ),
	.pcs_sel_misc2                 (pcs_sel_misc2                 ),
	.pcs_sel_we                    (pcs_sel_we                    ),
	.pcs_sel_ctl                   (pcs_sel_ctl                   ),
	.pcs_sel_status                (pcs_sel_status                ),
	.pcs_sel_cer                   (pcs_sel_cer                   ),
	.pcs_hart_resetn               (pcs_hart_resetn               ),
`ifdef NDS_FPGA
	.ddr3_latency                  (ddr3_latency                  ),
	.ddr3_bw_ctrl                  (ddr3_bw_ctrl                  ),
   `ifdef NDS_IO_PROBING
	.hart0_probe_current_pc        (hart0_probe_current_pc        ),
	.hart0_probe_gpr_index         (hart0_probe_gpr_index         ),
	.hart0_probe_selected_gpr_value(hart0_probe_selected_gpr_value),
   `endif
`endif
	.smu_sw_rst                    (smu_sw_rst                    ),
	.core_reset_vectors            (core_reset_vectors            ),
	.system_clock_ratio            (system_clock_ratio            )
);

sample_ae350_smu_pcs smu_pcs0 (
	.pclk             (pclk              ),
	.presetn          (presetn           ),
	.pcs_rdata        (pcs0_rdata        ),
	.pcs_sel          (pcs_sel[0]        ),
	.pcs_wdata        (pcs_wdata         ),
	.pcs_write        (pcs_write         ),
	.pcs_sel_cfg      (pcs_sel_cfg       ),
	.pcs_sel_scratch  (pcs_sel_scratch   ),
	.pcs_sel_misc     (pcs_sel_misc      ),
	.pcs_sel_misc2    (pcs_sel_misc2     ),
	.pcs_sel_we       (pcs_sel_we        ),
	.pcs_sel_ctl      (pcs_sel_ctl       ),
	.pcs_sel_status   (pcs_sel_status    ),
	.pcs_sel_cer      (pcs_sel_cer       ),
	.pcs_hart_rst     (1'b1              ),
	.pcs_wakeup_event (pcs0_wakeup_event ),
	.pcs_int          (pcs0_int          ),
	.pcs_wakeup       (pcs0_wakeup       ),
	.pcs_standby_req  (pcs0_standby_req  ),
	.pcs_standby_ok   (pcs0_standby_ok   ),
	.pcs_frq_scale_req(pcs0_frq_scale_req),
	.pcs_frq_scale    (pcs0_frq_scale    ),
	.pcs_frq_clkon    (pcs0_frq_clkon    ),
	.pcs_frq_scale_ack(pcs0_frq_scale_ack),
	.pcs_vol_scale_req(pcs0_vol_scale_req),
	.pcs_vol_scale    (pcs0_vol_scale    ),
	.pcs_vol_scale_ack(pcs0_vol_scale_ack),
	.pcs_iso          (pcs0_iso          ),
	.pcs_reten        (pcs0_reten        ),
	.pcs_resetn       (pcs0_resetn_new   ),
	.pcs_mem_init     (pcs0_mem_init     ),
	.pcs_reset_source (pcs0_reset_source )
);

sample_ae350_smu_pcs smu_pcs1 (
	.pclk             (pclk              ),
	.presetn          (presetn           ),
	.pcs_rdata        (pcs1_rdata        ),
	.pcs_sel          (pcs_sel[1]        ),
	.pcs_wdata        (pcs_wdata         ),
	.pcs_write        (pcs_write         ),
	.pcs_sel_cfg      (pcs_sel_cfg       ),
	.pcs_sel_scratch  (pcs_sel_scratch   ),
	.pcs_sel_misc     (pcs_sel_misc      ),
	.pcs_sel_misc2    (pcs_sel_misc2     ),
	.pcs_sel_we       (pcs_sel_we        ),
	.pcs_sel_ctl      (pcs_sel_ctl       ),
	.pcs_sel_status   (pcs_sel_status    ),
	.pcs_sel_cer      (pcs_sel_cer       ),
	.pcs_hart_rst     (1'b1              ),
	.pcs_wakeup_event (pcs1_wakeup_event ),
	.pcs_int          (pcs1_int          ),
	.pcs_wakeup       (pcs1_wakeup       ),
	.pcs_standby_req  (pcs1_standby_req  ),
	.pcs_standby_ok   (pcs1_standby_ok   ),
	.pcs_frq_scale_req(pcs1_frq_scale_req),
	.pcs_frq_scale    (pcs1_frq_scale    ),
	.pcs_frq_clkon    (pcs1_frq_clkon    ),
	.pcs_frq_scale_ack(pcs1_frq_scale_ack),
	.pcs_vol_scale_req(pcs1_vol_scale_req),
	.pcs_vol_scale    (pcs1_vol_scale    ),
	.pcs_vol_scale_ack(pcs1_vol_scale_ack),
	.pcs_iso          (pcs1_iso          ),
	.pcs_reten        (pcs1_reten        ),
	.pcs_resetn       (pcs1_resetn       ),
	.pcs_mem_init     (pcs1_mem_init     ),
	.pcs_reset_source (pcs1_reset_source )
);

sample_ae350_smu_pcs smu_pcs2 (
	.pclk             (pclk              ),
	.presetn          (presetn           ),
	.pcs_rdata        (pcs2_rdata        ),
	.pcs_sel          (pcs_sel[2]        ),
	.pcs_wdata        (pcs_wdata         ),
	.pcs_write        (pcs_write         ),
	.pcs_sel_cfg      (pcs_sel_cfg       ),
	.pcs_sel_scratch  (pcs_sel_scratch   ),
	.pcs_sel_misc     (pcs_sel_misc      ),
	.pcs_sel_misc2    (pcs_sel_misc2     ),
	.pcs_sel_we       (pcs_sel_we        ),
	.pcs_sel_ctl      (pcs_sel_ctl       ),
	.pcs_sel_status   (pcs_sel_status    ),
	.pcs_sel_cer      (pcs_sel_cer       ),
	.pcs_hart_rst     (1'b1              ),
	.pcs_wakeup_event (pcs2_wakeup_event ),
	.pcs_int          (pcs2_int          ),
	.pcs_wakeup       (pcs2_wakeup       ),
	.pcs_standby_req  (pcs2_standby_req  ),
	.pcs_standby_ok   (pcs2_standby_ok   ),
	.pcs_frq_scale_req(pcs2_frq_scale_req),
	.pcs_frq_scale    (pcs2_frq_scale    ),
	.pcs_frq_clkon    (pcs2_frq_clkon    ),
	.pcs_frq_scale_ack(pcs2_frq_scale_ack),
	.pcs_vol_scale_req(pcs2_vol_scale_req),
	.pcs_vol_scale    (pcs2_vol_scale    ),
	.pcs_vol_scale_ack(pcs2_vol_scale_ack),
	.pcs_iso          (pcs2_iso          ),
	.pcs_reten        (pcs2_reten        ),
	.pcs_resetn       (pcs2_resetn       ),
	.pcs_mem_init     (pcs2_mem_init     ),
	.pcs_reset_source (pcs2_reset_source )
);

sample_ae350_smu_pcs_core smu_pcs3 (
	.pclk             (pclk              ),
	.presetn          (presetn           ),
	.pcs_rdata        (pcs3_rdata        ),
	.pcs_sel          (pcs_sel[3]        ),
	.pcs_wdata        (pcs_wdata         ),
	.pcs_write        (pcs_write         ),
	.pcs_sel_cfg      (pcs_sel_cfg       ),
	.pcs_sel_scratch  (pcs_sel_scratch   ),
	.pcs_sel_misc     (pcs_sel_misc      ),
	.pcs_sel_misc2    (pcs_sel_misc2     ),
	.pcs_sel_we       (pcs_sel_we        ),
	.pcs_sel_ctl      (pcs_sel_ctl       ),
	.pcs_sel_status   (pcs_sel_status    ),
	.pcs_sel_cer      (pcs_sel_cer       ),
	.pcs_hart_rst     (pcs_hart_resetn[0]),
	.pcs_wakeup_event (pcs3_wakeup_event ),
	.pcs_int          (pcs3_int          ),
	.pcs_wakeup       (pcs3_wakeup       ),
	.pcs_standby_req  (pcs3_standby_req  ),
	.pcs_standby_ok   (pcs3_standby_ok   ),
	.pcs_frq_scale_req(pcs3_frq_scale_req),
	.pcs_frq_scale    (pcs3_frq_scale    ),
	.pcs_frq_clkon    (pcs3_frq_clkon    ),
	.pcs_frq_scale_ack(pcs3_frq_scale_ack),
	.pcs_vol_scale_req(pcs3_vol_scale_req),
	.pcs_vol_scale    (pcs3_vol_scale    ),
	.pcs_vol_scale_ack(pcs3_vol_scale_ack),
	.pcs_iso          (pcs3_iso          ),
	.pcs_reten        (pcs3_reten        ),
	.pcs_resetn       (pcs3_resetn       ),
	.pcs_slvp_resetn  (pcs3_slvp_resetn  ),
	.pcs_mem_init     (pcs3_mem_init     ),
	.pcs_reset_source (pcs3_reset_source )
);


sample_ae350_smu_pcs smu_pcs4 (
	.pclk             (pclk              ),
	.presetn          (presetn           ),
	.pcs_rdata        (pcs4_rdata        ),
	.pcs_sel          (pcs_sel[4]        ),
	.pcs_wdata        (pcs_wdata         ),
	.pcs_write        (pcs_write         ),
	.pcs_sel_cfg      (pcs_sel_cfg       ),
	.pcs_sel_scratch  (pcs_sel_scratch   ),
	.pcs_sel_misc     (pcs_sel_misc      ),
	.pcs_sel_misc2    (pcs_sel_misc2     ),
	.pcs_sel_we       (pcs_sel_we        ),
	.pcs_sel_ctl      (pcs_sel_ctl       ),
	.pcs_sel_status   (pcs_sel_status    ),
	.pcs_sel_cer      (pcs_sel_cer       ),
	.pcs_hart_rst     (1'b1              ),
	.pcs_wakeup_event (pcs4_wakeup_event ),
	.pcs_int          (pcs4_int          ),
	.pcs_wakeup       (pcs4_wakeup       ),
	.pcs_standby_req  (pcs4_standby_req  ),
	.pcs_standby_ok   (pcs4_standby_ok   ),
	.pcs_frq_scale_req(pcs4_frq_scale_req),
	.pcs_frq_scale    (pcs4_frq_scale    ),
	.pcs_frq_clkon    (pcs4_frq_clkon    ),
	.pcs_frq_scale_ack(pcs4_frq_scale_ack),
	.pcs_vol_scale_req(pcs4_vol_scale_req),
	.pcs_vol_scale    (pcs4_vol_scale    ),
	.pcs_vol_scale_ack(pcs4_vol_scale_ack),
	.pcs_iso          (pcs4_iso          ),
	.pcs_reten        (pcs4_reten        ),
	.pcs_resetn       (pcs4_resetn       ),
	.pcs_mem_init     (pcs4_mem_init     ),
	.pcs_reset_source (pcs4_reset_source )
);



sample_ae350_smu_pcs smu_pcs5 (
	.pclk             (pclk              ),
	.presetn          (presetn           ),
	.pcs_rdata        (pcs5_rdata        ),
	.pcs_sel          (pcs_sel[5]        ),
	.pcs_wdata        (pcs_wdata         ),
	.pcs_write        (pcs_write         ),
	.pcs_sel_cfg      (pcs_sel_cfg       ),
	.pcs_sel_scratch  (pcs_sel_scratch   ),
	.pcs_sel_misc     (pcs_sel_misc      ),
	.pcs_sel_misc2    (pcs_sel_misc2     ),
	.pcs_sel_we       (pcs_sel_we        ),
	.pcs_sel_ctl      (pcs_sel_ctl       ),
	.pcs_sel_status   (pcs_sel_status    ),
	.pcs_sel_cer      (pcs_sel_cer       ),
	.pcs_hart_rst     (1'b1              ),
	.pcs_wakeup_event (pcs5_wakeup_event ),
	.pcs_int          (pcs5_int          ),
	.pcs_wakeup       (pcs5_wakeup       ),
	.pcs_standby_req  (pcs5_standby_req  ),
	.pcs_standby_ok   (pcs5_standby_ok   ),
	.pcs_frq_scale_req(pcs5_frq_scale_req),
	.pcs_frq_scale    (pcs5_frq_scale    ),
	.pcs_frq_clkon    (pcs5_frq_clkon    ),
	.pcs_frq_scale_ack(pcs5_frq_scale_ack),
	.pcs_vol_scale_req(pcs5_vol_scale_req),
	.pcs_vol_scale    (pcs5_vol_scale    ),
	.pcs_vol_scale_ack(pcs5_vol_scale_ack),
	.pcs_iso          (pcs5_iso          ),
	.pcs_reten        (pcs5_reten        ),
	.pcs_resetn       (pcs5_resetn       ),
	.pcs_mem_init     (pcs5_mem_init     ),
	.pcs_reset_source (pcs5_reset_source )
);



sample_ae350_smu_pcs smu_pcs6 (
	.pclk             (pclk              ),
	.presetn          (presetn           ),
	.pcs_rdata        (pcs6_rdata        ),
	.pcs_sel          (pcs_sel[6]        ),
	.pcs_wdata        (pcs_wdata         ),
	.pcs_write        (pcs_write         ),
	.pcs_sel_cfg      (pcs_sel_cfg       ),
	.pcs_sel_scratch  (pcs_sel_scratch   ),
	.pcs_sel_misc     (pcs_sel_misc      ),
	.pcs_sel_misc2    (pcs_sel_misc2     ),
	.pcs_sel_we       (pcs_sel_we        ),
	.pcs_sel_ctl      (pcs_sel_ctl       ),
	.pcs_sel_status   (pcs_sel_status    ),
	.pcs_sel_cer      (pcs_sel_cer       ),
	.pcs_hart_rst     (1'b1              ),
	.pcs_wakeup_event (pcs6_wakeup_event ),
	.pcs_int          (pcs6_int          ),
	.pcs_wakeup       (pcs6_wakeup       ),
	.pcs_standby_req  (pcs6_standby_req  ),
	.pcs_standby_ok   (pcs6_standby_ok   ),
	.pcs_frq_scale_req(pcs6_frq_scale_req),
	.pcs_frq_scale    (pcs6_frq_scale    ),
	.pcs_frq_clkon    (pcs6_frq_clkon    ),
	.pcs_frq_scale_ack(pcs6_frq_scale_ack),
	.pcs_vol_scale_req(pcs6_vol_scale_req),
	.pcs_vol_scale    (pcs6_vol_scale    ),
	.pcs_vol_scale_ack(pcs6_vol_scale_ack),
	.pcs_iso          (pcs6_iso          ),
	.pcs_reten        (pcs6_reten        ),
	.pcs_resetn       (pcs6_resetn       ),
	.pcs_mem_init     (pcs6_mem_init     ),
	.pcs_reset_source (pcs6_reset_source )
);



sample_ae350_smu_pcs smu_pcs7 (
	.pclk             (pclk              ),
	.presetn          (presetn           ),
	.pcs_rdata        (pcs7_rdata        ),
	.pcs_sel          (pcs_sel[7]        ),
	.pcs_wdata        (pcs_wdata         ),
	.pcs_write        (pcs_write         ),
	.pcs_sel_cfg      (pcs_sel_cfg       ),
	.pcs_sel_scratch  (pcs_sel_scratch   ),
	.pcs_sel_misc     (pcs_sel_misc      ),
	.pcs_sel_misc2    (pcs_sel_misc2     ),
	.pcs_sel_we       (pcs_sel_we        ),
	.pcs_sel_ctl      (pcs_sel_ctl       ),
	.pcs_sel_status   (pcs_sel_status    ),
	.pcs_sel_cer      (pcs_sel_cer       ),
	.pcs_hart_rst     (1'b1              ),
	.pcs_wakeup_event (pcs7_wakeup_event ),
	.pcs_int          (pcs7_int          ),
	.pcs_wakeup       (pcs7_wakeup       ),
	.pcs_standby_req  (pcs7_standby_req  ),
	.pcs_standby_ok   (pcs7_standby_ok   ),
	.pcs_frq_scale_req(pcs7_frq_scale_req),
	.pcs_frq_scale    (pcs7_frq_scale    ),
	.pcs_frq_clkon    (pcs7_frq_clkon    ),
	.pcs_frq_scale_ack(pcs7_frq_scale_ack),
	.pcs_vol_scale_req(pcs7_vol_scale_req),
	.pcs_vol_scale    (pcs7_vol_scale    ),
	.pcs_vol_scale_ack(pcs7_vol_scale_ack),
	.pcs_iso          (pcs7_iso          ),
	.pcs_reten        (pcs7_reten        ),
	.pcs_resetn       (pcs7_resetn       ),
	.pcs_mem_init     (pcs7_mem_init     ),
	.pcs_reset_source (pcs7_reset_source )
);



sample_ae350_smu_pcs smu_pcs8 (
	.pclk             (pclk              ),
	.presetn          (presetn           ),
	.pcs_rdata        (pcs8_rdata        ),
	.pcs_sel          (pcs_sel[8]        ),
	.pcs_wdata        (pcs_wdata         ),
	.pcs_write        (pcs_write         ),
	.pcs_sel_cfg      (pcs_sel_cfg       ),
	.pcs_sel_scratch  (pcs_sel_scratch   ),
	.pcs_sel_misc     (pcs_sel_misc      ),
	.pcs_sel_misc2    (pcs_sel_misc2     ),
	.pcs_sel_we       (pcs_sel_we        ),
	.pcs_sel_ctl      (pcs_sel_ctl       ),
	.pcs_sel_status   (pcs_sel_status    ),
	.pcs_sel_cer      (pcs_sel_cer       ),
	.pcs_hart_rst     (1'b1              ),
	.pcs_wakeup_event (pcs8_wakeup_event ),
	.pcs_int          (pcs8_int          ),
	.pcs_wakeup       (pcs8_wakeup       ),
	.pcs_standby_req  (pcs8_standby_req  ),
	.pcs_standby_ok   (pcs8_standby_ok   ),
	.pcs_frq_scale_req(pcs8_frq_scale_req),
	.pcs_frq_scale    (pcs8_frq_scale    ),
	.pcs_frq_clkon    (pcs8_frq_clkon    ),
	.pcs_frq_scale_ack(pcs8_frq_scale_ack),
	.pcs_vol_scale_req(pcs8_vol_scale_req),
	.pcs_vol_scale    (pcs8_vol_scale    ),
	.pcs_vol_scale_ack(pcs8_vol_scale_ack),
	.pcs_iso          (pcs8_iso          ),
	.pcs_reten        (pcs8_reten        ),
	.pcs_resetn       (pcs8_resetn       ),
	.pcs_mem_init     (pcs8_mem_init     ),
	.pcs_reset_source (pcs8_reset_source )
);



sample_ae350_smu_pcs smu_pcs9 (
	.pclk             (pclk              ),
	.presetn          (presetn           ),
	.pcs_rdata        (pcs9_rdata        ),
	.pcs_sel          (pcs_sel[9]        ),
	.pcs_wdata        (pcs_wdata         ),
	.pcs_write        (pcs_write         ),
	.pcs_sel_cfg      (pcs_sel_cfg       ),
	.pcs_sel_scratch  (pcs_sel_scratch   ),
	.pcs_sel_misc     (pcs_sel_misc      ),
	.pcs_sel_misc2    (pcs_sel_misc2     ),
	.pcs_sel_we       (pcs_sel_we        ),
	.pcs_sel_ctl      (pcs_sel_ctl       ),
	.pcs_sel_status   (pcs_sel_status    ),
	.pcs_sel_cer      (pcs_sel_cer       ),
	.pcs_hart_rst     (1'b1              ),
	.pcs_wakeup_event (pcs9_wakeup_event ),
	.pcs_int          (pcs9_int          ),
	.pcs_wakeup       (pcs9_wakeup       ),
	.pcs_standby_req  (pcs9_standby_req  ),
	.pcs_standby_ok   (pcs9_standby_ok   ),
	.pcs_frq_scale_req(pcs9_frq_scale_req),
	.pcs_frq_scale    (pcs9_frq_scale    ),
	.pcs_frq_clkon    (pcs9_frq_clkon    ),
	.pcs_frq_scale_ack(pcs9_frq_scale_ack),
	.pcs_vol_scale_req(pcs9_vol_scale_req),
	.pcs_vol_scale    (pcs9_vol_scale    ),
	.pcs_vol_scale_ack(pcs9_vol_scale_ack),
	.pcs_iso          (pcs9_iso          ),
	.pcs_reten        (pcs9_reten        ),
	.pcs_resetn       (pcs9_resetn       ),
	.pcs_mem_init     (pcs9_mem_init     ),
	.pcs_reset_source (pcs9_reset_source )
);



sample_ae350_smu_pcs smu_pcs10 (
	.pclk             (pclk               ),
	.presetn          (presetn            ),
	.pcs_rdata        (pcs10_rdata        ),
	.pcs_sel          (pcs_sel[10]        ),
	.pcs_wdata        (pcs_wdata          ),
	.pcs_write        (pcs_write          ),
	.pcs_sel_cfg      (pcs_sel_cfg        ),
	.pcs_sel_scratch  (pcs_sel_scratch    ),
	.pcs_sel_misc     (pcs_sel_misc       ),
	.pcs_sel_misc2    (pcs_sel_misc2      ),
	.pcs_sel_we       (pcs_sel_we         ),
	.pcs_sel_ctl      (pcs_sel_ctl        ),
	.pcs_sel_status   (pcs_sel_status     ),
	.pcs_sel_cer      (pcs_sel_cer        ),
	.pcs_hart_rst     (1'b1               ),
	.pcs_wakeup_event (pcs10_wakeup_event ),
	.pcs_int          (pcs10_int          ),
	.pcs_wakeup       (pcs10_wakeup       ),
	.pcs_standby_req  (pcs10_standby_req  ),
	.pcs_standby_ok   (pcs10_standby_ok   ),
	.pcs_frq_scale_req(pcs10_frq_scale_req),
	.pcs_frq_scale    (pcs10_frq_scale    ),
	.pcs_frq_clkon    (pcs10_frq_clkon    ),
	.pcs_frq_scale_ack(pcs10_frq_scale_ack),
	.pcs_vol_scale_req(pcs10_vol_scale_req),
	.pcs_vol_scale    (pcs10_vol_scale    ),
	.pcs_vol_scale_ack(pcs10_vol_scale_ack),
	.pcs_iso          (pcs10_iso          ),
	.pcs_reten        (pcs10_reten        ),
	.pcs_resetn       (pcs10_resetn       ),
	.pcs_mem_init     (pcs10_mem_init     ),
	.pcs_reset_source (pcs10_reset_source )
);


endmodule

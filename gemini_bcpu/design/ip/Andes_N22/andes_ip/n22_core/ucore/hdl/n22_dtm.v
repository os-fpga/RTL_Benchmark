
`include "global.inc"
    `ifdef N22_HAS_DEBUG_PRIVATE
module n22_dtm (
      dbg_sleep,
	  dm_reset_n_sync,
	  tms_out_en,
	  test_mode,
      por_rst_n_tck,
      por_rst_n_clk,
      reset_bypass ,
	  tck,
	  tms,
	  tdi,
	  tdo,
	  tdo_out_en,
      tap_dmi_active,
	  dmi_hresetn,
      dmi_clk,
	  dmi_hclk,
	  dmi_hsel,
	  dmi_htrans,
	  dmi_haddr,
	  dmi_hsize,
	  dmi_hburst,
	  dmi_hprot,
	  dmi_hwdata,
	  dmi_hwrite,
	  dmi_hrdata,
	  dmi_hready,
	  dmi_hreadyout,
	  dmi_hresp
);

parameter DEBUG_INTERFACE = "jtag";

localparam DMI_DATA_BITS = 32;
localparam DMI_ADDR_BITS = 7;
localparam DMI_OP_BITS   = 2;
localparam DMI_REG_BITS = DMI_DATA_BITS + DMI_ADDR_BITS + DMI_OP_BITS;

input              dbg_sleep;
input              dm_reset_n_sync;
output             tms_out_en;
input              test_mode;
input              por_rst_n_tck;
input              por_rst_n_clk;
input              reset_bypass ;
input              tck;
input              tms;
input              tdi;
output             tdo;
output             tdo_out_en;
output             tap_dmi_active;
output             dmi_hresetn;
input              dmi_clk;
input              dmi_hclk;
output             dmi_hsel;
output       [1:0] dmi_htrans;
output      [31:0] dmi_haddr;
output       [2:0] dmi_hsize;
output       [2:0] dmi_hburst;
output       [3:0] dmi_hprot;
output      [31:0] dmi_hwdata;
output             dmi_hwrite;
input       [31:0] dmi_hrdata;
input              dmi_hready;
output             dmi_hreadyout;
input              dmi_hresp;

reg                            s0;
wire                           s1;
wire                    [31:0] dmi_tap_hrdata;
wire                           dtm_dmi_resetn;
wire        [DMI_REG_BITS-1:0] tap_dmi_data;
wire                           s2;
wire                           s3;
wire                           s4;

wire                           s5;
wire                           s6;
wire                    [31:0] s7;
wire                           s8;

assign s8 = ( s2 | s3 | s5 | s6);


wire s9 = reset_bypass ? por_rst_n_clk : dtm_dmi_resetn;
always @(posedge dmi_clk or negedge s9) begin
	if (!s9)
		s0 <= 1'b0;
	else
		s0 <= 1'b1;
end

wire s10;

n22_dtm_iso n22_dtm_iso(
         .tck          (tck                    ),
         .pwr_rst_n    (por_rst_n_tck          ),
         .dbg_sleep    (s10              ),
         .a_req        (s5    ),
         .a_ack        (s6    ),
         .a_data       (s7     ),
         .b_req        (s2        ),
         .b_ack        (s3        ),
         .b_data       (dmi_tap_hrdata         )
);


defparam n22_dtm_tap.DEBUG_INTERFACE = DEBUG_INTERFACE;
n22_dtm_tap n22_dtm_tap (
    .reset_bypass(reset_bypass),
	.tms_out_en    (tms_out_en     ),
	.tdi           (tdi            ),
	.tms           (tms            ),
	.tdo           (tdo            ),
	.tdo_out_en    (tdo_out_en     ),
	.tck           (tck            ),
	.pwr_rst_n     (por_rst_n_tck  ),
    .dmi_tap_hrdata(s7 ),
    .dmi_tap_ack   (s6),
    .tap_dmi_req   (s5),
	.tap_dmi_data  (tap_dmi_data   ),
	.dtm_dmi_resetn(dtm_dmi_resetn )
);


wire s11 = s4 & (~dbg_sleep);

n22_dtm_dmi n22_dtm_dmi (
	.dmi_hresetn   (dm_reset_n_sync ),
	.dmi_tap_hrdata(dmi_tap_hrdata  ),
	.dmi_tap_ack   (s1),
	.tap_dmi_req   (s11),
	.tap_dmi_data  (tap_dmi_data    ),
	.dmi_hclk      (dmi_hclk        ),
	.dmi_hresp     (dmi_hresp       ),
	.dmi_hready    (dmi_hready      ),
	.dmi_hrdata    (dmi_hrdata      ),
	.dmi_hreadyout (dmi_hreadyout   ),
	.dmi_haddr     (dmi_haddr       ),
	.dmi_htrans    (dmi_htrans      ),
	.dmi_hwrite    (dmi_hwrite      ),
	.dmi_hsize     (dmi_hsize       ),
	.dmi_hburst    (dmi_hburst      ),
	.dmi_hprot     (dmi_hprot       ),
	.dmi_hwdata    (dmi_hwdata      ),
	.dmi_hsel      (dmi_hsel        )
);

n22_sync_l2l n22_sync_tap_dmi (
	.b_reset_n                  (por_rst_n_clk       ),
	.b_clk                      (dmi_hclk        ),
	.a_signal                   (s2 ),
	.b_signal                   (s4),
	.b_signal_rising_edge_pulse (                ),
	.b_signal_falling_edge_pulse(                ),
	.b_signal_edge_pulse        (                )
);

n22_sync_l2l n22_sync_hresetn (
	.b_reset_n                  (por_rst_n_clk    ),
	.b_clk                      (dmi_clk      ),
	.a_signal                   (s0),
	.b_signal                   (dmi_hresetn  ),
	.b_signal_rising_edge_pulse (             ),
	.b_signal_falling_edge_pulse(             ),
	.b_signal_edge_pulse        (             )
);

n22_sync_l2l n22_sync_dmi_tap (
	.b_reset_n                  (por_rst_n_tck  ),
	.b_clk                      (tck             ),
	.a_signal                   (s1),
	.b_signal                   (s3 ),
	.b_signal_rising_edge_pulse (                ),
	.b_signal_falling_edge_pulse(                ),
	.b_signal_edge_pulse        (                )
);




n22_sync_l2l n22_sync_dbg_sleep_tap (
	.b_reset_n                  (por_rst_n_tck  ),
	.b_clk                      (tck             ),
	.a_signal                   (dbg_sleep),
	.b_signal                   (s10   ),
	.b_signal_rising_edge_pulse (                ),
	.b_signal_falling_edge_pulse(                ),
	.b_signal_edge_pulse        (                )
);

n22_sync_l2l n22_sync_tap_dmi_active (
	.b_reset_n                  (por_rst_n_clk  ),
	.b_clk                      (dmi_clk             ),
	.a_signal                   (s8),
	.b_signal                   (tap_dmi_active     ),
	.b_signal_rising_edge_pulse (                ),
	.b_signal_falling_edge_pulse(                ),
	.b_signal_edge_pulse        (                )
);


endmodule
`endif

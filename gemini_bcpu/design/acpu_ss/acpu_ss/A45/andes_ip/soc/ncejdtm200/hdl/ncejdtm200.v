// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module ncejdtm200 (
	  dbg_wakeup_req,
	  tms_out_en,
	  test_mode,
	  pwr_rst_n,
	  tck,
	  tms,
	  tdi,
	  tdo,
	  tdo_out_en,
	  dmi_hresetn,
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
	  dmi_hresp
);

parameter DEBUG_INTERFACE = "jtag";
parameter SYNC_STAGE = 2;

localparam DMI_DATA_BITS = 32;
localparam DMI_ADDR_BITS = 7;
localparam DMI_OP_BITS   = 2;
localparam DMI_REG_BITS = DMI_DATA_BITS + DMI_ADDR_BITS + DMI_OP_BITS;

output             dbg_wakeup_req;
output             tms_out_en;
input              test_mode;
input              pwr_rst_n;
input              tck;
input              tms;
input              tdi;
output             tdo;
output             tdo_out_en;
output             dmi_hresetn;
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
input              dmi_hresp;

wire                             nds_unused_wire;
wire                             s0;
wire                      [31:0] dmi_tap_hrdata;
wire                             dtm_dmi_resetn;
wire        [(DMI_REG_BITS-1):0] tap_dmi_data;
wire                             s1;
wire                             s2;
wire                       [1:0] nds_unused_b_edge;
wire                       [1:0] nds_unused_b_fall;
wire                       [1:0] nds_unused_b_rise;
wire                             s3;
wire                             s4;
wire                             s5;

assign nds_unused_wire = (|nds_unused_b_rise) | (|nds_unused_b_fall) | (|nds_unused_b_edge);

ncejdtm200_tap #(
	.DEBUG_INTERFACE (DEBUG_INTERFACE )
) ncejdtm200_tap (
	.dbg_wakeup_req(dbg_wakeup_req ),
	.tms_out_en    (tms_out_en     ),
	.tdi           (tdi            ),
	.tms           (tms            ),
	.tdo           (tdo            ),
	.tdo_out_en    (tdo_out_en     ),
	.tck           (tck            ),
	.pwr_rst_n     (s4  ),
	.dmi_tap_hrdata(dmi_tap_hrdata ),
	.dmi_tap_ack   (s2),
	.tap_dmi_req   (s1),
	.tap_dmi_data  (tap_dmi_data   ),
	.dtm_dmi_resetn(dtm_dmi_resetn )
);

ncejdtm200_dmi ncejdtm200_dmi (
	.dmi_hresetn   (dmi_hresetn     ),
	.dmi_tap_hrdata(dmi_tap_hrdata  ),
	.dmi_tap_ack   (s0),
	.tap_dmi_req   (s5),
	.tap_dmi_data  (tap_dmi_data    ),
	.dmi_hclk      (dmi_hclk        ),
	.dmi_hresp     (dmi_hresp       ),
	.dmi_hready    (dmi_hready      ),
	.dmi_hrdata    (dmi_hrdata      ),
	.dmi_haddr     (dmi_haddr       ),
	.dmi_htrans    (dmi_htrans      ),
	.dmi_hwrite    (dmi_hwrite      ),
	.dmi_hsize     (dmi_hsize       ),
	.dmi_hburst    (dmi_hburst      ),
	.dmi_hprot     (dmi_hprot       ),
	.dmi_hwdata    (dmi_hwdata      ),
	.dmi_hsel      (dmi_hsel        )
);

nds_sync_l2l #(
	.RESET_VALUE     (1'b0            ),
	.SYNC_STAGE      (SYNC_STAGE      )
) nds_sync_tap_dmi (
	.b_reset_n                  (s3       ),
	.b_clk                      (dmi_hclk            ),
	.a_signal                   (s1     ),
	.b_signal                   (s5    ),
	.b_signal_rising_edge_pulse (nds_unused_b_rise[0]),
	.b_signal_falling_edge_pulse(nds_unused_b_fall[0]),
	.b_signal_edge_pulse        (nds_unused_b_edge[0])
);

nds_rst_sync nds_sync_dtm_dmi_rst (
	.test_mode     (test_mode     ),
	.test_resetn_in(pwr_rst_n     ),
	.resetn_in     (dtm_dmi_resetn),
	.clk           (dmi_hclk      ),
	.resetn_out    (dmi_hresetn   )
);

nds_sync_l2l #(
	.RESET_VALUE     (1'b0            ),
	.SYNC_STAGE      (SYNC_STAGE      )
) nds_sync_dmi_tap (
	.b_reset_n                  (s4       ),
	.b_clk                      (tck                 ),
	.a_signal                   (s0    ),
	.b_signal                   (s2     ),
	.b_signal_rising_edge_pulse (nds_unused_b_rise[1]),
	.b_signal_falling_edge_pulse(nds_unused_b_fall[1]),
	.b_signal_edge_pulse        (nds_unused_b_edge[1])
);

nds_rst_sync nds_sync_pwr_rst_tck (
	.test_mode     (test_mode    ),
	.test_resetn_in(pwr_rst_n    ),
	.resetn_in     (pwr_rst_n    ),
	.clk           (tck          ),
	.resetn_out    (s4)
);

nds_rst_sync nds_sync_pwr_rst_dmi (
	.test_mode     (test_mode    ),
	.test_resetn_in(pwr_rst_n    ),
	.resetn_in     (pwr_rst_n    ),
	.clk           (dmi_hclk     ),
	.resetn_out    (s3)
);

endmodule

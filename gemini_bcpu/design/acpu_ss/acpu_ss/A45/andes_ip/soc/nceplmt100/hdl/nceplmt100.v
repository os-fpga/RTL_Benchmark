// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module nceplmt100 (
	  araddr,
	  arburst,
	  arcache,
	  arid,
	  arlen,
	  arlock,
	  arprot,
	  arready,
	  arsize,
	  arvalid,
	  awaddr,
	  awburst,
	  awcache,
	  awid,
	  awlen,
	  awlock,
	  awprot,
	  awready,
	  awsize,
	  awvalid,
	  bid,
	  bready,
	  bresp,
	  bvalid,
	  haddr,
	  hburst,
	  hrdata,
	  hready,
	  hreadyout,
	  hresp,
	  hsel,
	  hsize,
	  htrans,
	  hwdata,
	  hwrite,
	  mtip,
	  rdata,
	  rid,
	  rlast,
	  rready,
	  rresp,
	  rvalid,
	  wdata,
	  wlast,
	  wready,
	  wstrb,
	  wvalid,
	  clk,
	  resetn,
	  mtime_clk,
	  por_rstn,
	  test_mode,
	  stoptime
);

parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 32;
parameter BUS_TYPE = "ahb";
parameter ID_WIDTH = 4;
parameter NHART = 4;
parameter GRAY_WIDTH = 2;
parameter SYNC_STAGE = 2;

input         [(ADDR_WIDTH-1):0] araddr;
input                      [1:0] arburst;
input                      [3:0] arcache;
input           [(ID_WIDTH-1):0] arid;
input                      [7:0] arlen;
input                            arlock;
input                      [2:0] arprot;
output                           arready;
input                      [2:0] arsize;
input                            arvalid;
input         [(ADDR_WIDTH-1):0] awaddr;
input                      [1:0] awburst;
input                      [3:0] awcache;
input           [(ID_WIDTH-1):0] awid;
input                      [7:0] awlen;
input                            awlock;
input                      [2:0] awprot;
output                           awready;
input                      [2:0] awsize;
input                            awvalid;
output          [(ID_WIDTH-1):0] bid;
input                            bready;
output                     [1:0] bresp;
output                           bvalid;
input         [(ADDR_WIDTH-1):0] haddr;
input                      [2:0] hburst;
output        [(DATA_WIDTH-1):0] hrdata;
input                            hready;
output                           hreadyout;
output                     [1:0] hresp;
input                            hsel;
input                      [2:0] hsize;
input                      [1:0] htrans;
input         [(DATA_WIDTH-1):0] hwdata;
input                            hwrite;
output             [(NHART-1):0] mtip;
output        [(DATA_WIDTH-1):0] rdata;
output          [(ID_WIDTH-1):0] rid;
output                           rlast;
input                            rready;
output                     [1:0] rresp;
output                           rvalid;
input         [(DATA_WIDTH-1):0] wdata;
input                            wlast;
output                           wready;
input       [(DATA_WIDTH/8)-1:0] wstrb;
input                            wvalid;
input                            clk;
input                            resetn;
input                            mtime_clk;
input                            por_rstn;
input                            test_mode;
input                            stoptime;

wire          [(GRAY_WIDTH-1):0] mtime_gray_sync;
wire                             nds_unused_wire;
wire             [63:GRAY_WIDTH] mtime_shadow;
wire          [(GRAY_WIDTH-1):0] mtime_shadow_gray;
wire                             update_req;
wire             [63:GRAY_WIDTH] mtime;
wire          [(GRAY_WIDTH-1):0] mtime_gray;
wire                             update_ack;
wire                             s0;
wire                             s1;
wire                       [2:0] nds_unused_b_edge;
wire                       [2:0] nds_unused_b_fall;
wire                       [2:0] nds_unused_b_rise;
wire                             update_ack_sync;
wire                             update_req_sync;

wire [GRAY_WIDTH-1:0] b_signal_rising_edge_pulse;
wire [GRAY_WIDTH-1:0] b_signal_falling_edge_pulse;
wire [GRAY_WIDTH-1:0] b_signal_edge_pulse;

generate
genvar i_gray;
for (i_gray = 0; i_gray < GRAY_WIDTH; i_gray = i_gray + 1) begin: gen_gray_code_synchronizer
   nds_sync_l2l #(
       .RESET_VALUE (1'b0),
       .SYNC_STAGE  (SYNC_STAGE)
   ) mtime_gray_sync_l2l (
   	resetn,
   	clk,
   	mtime_gray[i_gray],
   	mtime_gray_sync[i_gray],
   	b_signal_rising_edge_pulse[i_gray],
   	b_signal_falling_edge_pulse[i_gray],
   	b_signal_edge_pulse[i_gray]
   );
end
endgenerate

assign nds_unused_wire = (|nds_unused_b_rise)          | (|nds_unused_b_fall)           | (|nds_unused_b_edge)
                      | (|b_signal_rising_edge_pulse) | (|b_signal_falling_edge_pulse) | (|b_signal_edge_pulse);

nds_rst_sync nds_sync_por_rst_mtime (
	.test_mode     (test_mode    ),
	.test_resetn_in(por_rstn     ),
	.resetn_in     (por_rstn     ),
	.clk           (mtime_clk    ),
	.resetn_out    (s0)
);

nceplmt100_busif #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BUS_TYPE        (BUS_TYPE        ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.GRAY_WIDTH      (GRAY_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.NHART           (NHART           )
) nceplmt100_busif (
	.clk              (clk              ),
	.resetn           (resetn           ),
	.htrans           (htrans           ),
	.hsize            (hsize            ),
	.hburst           (hburst           ),
	.haddr            (haddr            ),
	.hsel             (hsel             ),
	.hwrite           (hwrite           ),
	.hwdata           (hwdata           ),
	.hreadyout        (hreadyout        ),
	.hready           (hready           ),
	.hrdata           (hrdata           ),
	.hresp            (hresp            ),
	.awid             (awid             ),
	.awaddr           (awaddr           ),
	.awlen            (awlen            ),
	.awsize           (awsize           ),
	.awburst          (awburst          ),
	.awlock           (awlock           ),
	.awcache          (awcache          ),
	.awprot           (awprot           ),
	.awvalid          (awvalid          ),
	.awready          (awready          ),
	.wdata            (wdata            ),
	.wstrb            (wstrb            ),
	.wlast            (wlast            ),
	.wvalid           (wvalid           ),
	.wready           (wready           ),
	.bid              (bid              ),
	.bresp            (bresp            ),
	.bvalid           (bvalid           ),
	.bready           (bready           ),
	.arid             (arid             ),
	.araddr           (araddr           ),
	.arlen            (arlen            ),
	.arsize           (arsize           ),
	.arburst          (arburst          ),
	.arlock           (arlock           ),
	.arcache          (arcache          ),
	.arprot           (arprot           ),
	.arvalid          (arvalid          ),
	.arready          (arready          ),
	.rid              (rid              ),
	.rdata            (rdata            ),
	.rresp            (rresp            ),
	.rlast            (rlast            ),
	.rvalid           (rvalid           ),
	.rready           (rready           ),
	.mtip             (mtip             ),
	.mtime            (mtime            ),
	.mtime_gray_sync  (mtime_gray_sync  ),
	.mtime_shadow     (mtime_shadow     ),
	.mtime_shadow_gray(mtime_shadow_gray),
	.update_req       (update_req       ),
	.update_ack_sync  (update_ack_sync  )
);

nceplmt100_rtc #(
	.GRAY_WIDTH      (GRAY_WIDTH      )
) nceplmt100_rtc (
	.mtime_clk        (mtime_clk              ),
	.por_rstn         (s0          ),
	.mtime_shadow     (mtime_shadow           ),
	.mtime_shadow_gray(mtime_shadow_gray      ),
	.mtime            (mtime                  ),
	.mtime_gray       (mtime_gray             ),
	.stoptime_sync    (s1),
	.update_req_sync  (update_req_sync        ),
	.update_ack       (update_ack             )
);

nds_sync_l2l #(
	.RESET_VALUE     (1'b0            ),
	.SYNC_STAGE      (SYNC_STAGE      )
) update_req_sync_l2l (
	.b_reset_n                  (s0       ),
	.b_clk                      (mtime_clk           ),
	.a_signal                   (update_req          ),
	.b_signal                   (update_req_sync     ),
	.b_signal_rising_edge_pulse (nds_unused_b_rise[0]),
	.b_signal_falling_edge_pulse(nds_unused_b_fall[0]),
	.b_signal_edge_pulse        (nds_unused_b_edge[0])
);

nds_sync_l2l #(
	.RESET_VALUE     (1'b0            ),
	.SYNC_STAGE      (SYNC_STAGE      )
) update_ack_sync_l2l (
	.b_reset_n                  (resetn              ),
	.b_clk                      (clk                 ),
	.a_signal                   (update_ack          ),
	.b_signal                   (update_ack_sync     ),
	.b_signal_rising_edge_pulse (nds_unused_b_rise[1]),
	.b_signal_falling_edge_pulse(nds_unused_b_fall[1]),
	.b_signal_edge_pulse        (nds_unused_b_edge[1])
);

nds_sync_l2l #(
	.RESET_VALUE     (1'b0            ),
	.SYNC_STAGE      (SYNC_STAGE      )
) stoptime_sync_mtime_clk_l2l (
	.b_reset_n                  (s0          ),
	.b_clk                      (mtime_clk              ),
	.a_signal                   (stoptime               ),
	.b_signal                   (s1),
	.b_signal_rising_edge_pulse (nds_unused_b_rise[2]   ),
	.b_signal_falling_edge_pulse(nds_unused_b_fall[2]   ),
	.b_signal_edge_pulse        (nds_unused_b_edge[2]   )
);

endmodule


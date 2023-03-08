// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "ae250_config.vh"


module ae250_cpu_uncore (
`ifdef AE250_PLDM_SYS_BUS_ACCESS
	  debug_haddr,
	  debug_hburst,
	  debug_hbusreq,
	  debug_hgrant,
	  debug_hprot,
	  debug_hrdata,
	  debug_hready,
	  debug_hresp,
	  debug_hsize,
	  debug_htrans,
	  debug_hwdata,
	  debug_hwrite,
`endif
`ifdef NDS_BOARD_CF1
	  int_src,
	  meiack,
	  meiid,
	  meip,
	  seiack,
	  seiid,
	  seip,
`else
	  int_src,
	  meiack,
	  meiid,
	  meip,
	  seiack,
	  seiid,
	  seip,
`endif
	  dbg_wakeup_req,
	  dmactive,
	  pin_tdi_in,
	  pin_tdi_out,
	  pin_tdi_out_en,
	  pin_tdo_in,
	  pin_tdo_out,
	  pin_tdo_out_en,
	  pin_trst_in,
	  pin_trst_out,
	  pin_trst_out_en,
	  resethaltreq,
	  test_mode,
	  hclk,
	  hresetn,
	  haddr,
	  hburst,
	  hprot,
	  hrdata,
	  hready,
	  hresp,
	  hsize,
	  htrans,
	  hwdata,
	  hwrite,
	  uncore_haddr,
	  uncore_hburst,
	  uncore_hprot,
	  uncore_hrdata,
	  uncore_hready,
	  uncore_hresp,
	  uncore_hsize,
	  uncore_htrans,
	  uncore_hwdata,
	  uncore_hwrite,
	  mtime_clk,
	  msip,
	  por_rstn,
	  dbg_tck,
	  pin_tms_in,
	  pin_tms_out,
	  pin_tms_out_en,
	  dbg_srst_req,
	  debugint,
	  hart_halted,
	  hart_unavail,
	  hart_under_reset,
	  mtip,
	  stoptime
);

parameter HADDR_WIDTH = 32;
parameter HASEL_SUPPORT = "yes";
parameter PLIC_TARGET_NUM = 5'd1;
parameter ASYNC_INT = 1024'hc000000;
parameter RV_DATA_WIDTH = 64;
parameter SYS_DATA_WIDTH = 64;
`ifdef AE250_ADDR_WIDTH_24
parameter PLIC_BASE    = 64'h00e4_0000;
parameter PLIC_MASK    = 64'hfffe_0000;
parameter PLMT_BASE    = 64'h00e6_0000;
parameter PLMT_MASK    = 64'hffff_f000;
parameter PLIC_SW_BASE = 64'h00e6_4000;
parameter PLIC_SW_MASK = 64'hffff_c000;
parameter PLDM_BASE    = 64'h00e6_8000;
parameter PLDM_MASK    = 64'hffff_f000;
`else
parameter PLIC_BASE    = 64'he400_0000;
parameter PLIC_MASK    = 64'hfe00_0000;
parameter PLMT_BASE    = 64'he600_0000;
parameter PLMT_MASK    = 64'hfff0_0000;
parameter PLIC_SW_BASE = 64'he640_0000;
parameter PLIC_SW_MASK = 64'hffc0_0000;
parameter PLDM_BASE    = 64'he680_0000;
parameter PLDM_MASK    = 64'hfff0_0000;
`endif

`ifdef AE250_PLDM_SYS_BUS_ACCESS
output                      [31:0] debug_haddr;
output                       [2:0] debug_hburst;
output                             debug_hbusreq;
input                              debug_hgrant;
output                       [3:0] debug_hprot;
input       [(SYS_DATA_WIDTH-1):0] debug_hrdata;
input                              debug_hready;
input                        [1:0] debug_hresp;
output                       [2:0] debug_hsize;
output                       [1:0] debug_htrans;
output      [(SYS_DATA_WIDTH-1):0] debug_hwdata;
output                             debug_hwrite;
`endif
`ifdef NDS_BOARD_CF1
input                       [32:1] int_src;
input                              meiack;
output                       [9:0] meiid;
output                             meip;
input                              seiack;
output                       [9:0] seiid;
output                             seip;
`else
input                       [31:1] int_src;
input                              meiack;
output                       [9:0] meiid;
output                             meip;
input                              seiack;
output                       [9:0] seiid;
output                             seip;
`endif
output                             dbg_wakeup_req;
output                             dmactive;
input                              pin_tdi_in;
output                             pin_tdi_out;
output                             pin_tdi_out_en;
input                              pin_tdo_in;
output                             pin_tdo_out;
output                             pin_tdo_out_en;
input                              pin_trst_in;
output                             pin_trst_out;
output                             pin_trst_out_en;
output                       [0:0] resethaltreq;
input                              test_mode;
input                              hclk;
input                              hresetn;
output         [(HADDR_WIDTH-1):0] haddr;
output                       [2:0] hburst;
output                       [3:0] hprot;
input                       [31:0] hrdata;
input                              hready;
input                        [1:0] hresp;
output                       [2:0] hsize;
output                       [1:0] htrans;
output                      [31:0] hwdata;
output                             hwrite;
input          [(HADDR_WIDTH-1):0] uncore_haddr;
input                        [2:0] uncore_hburst;
input                        [3:0] uncore_hprot;
output                      [31:0] uncore_hrdata;
output                             uncore_hready;
output                       [1:0] uncore_hresp;
input                        [2:0] uncore_hsize;
input                        [1:0] uncore_htrans;
input                       [31:0] uncore_hwdata;
input                              uncore_hwrite;
input                              mtime_clk;
output                             msip;
input                              por_rstn;
input                              dbg_tck;
input                              pin_tms_in;
output                             pin_tms_out;
output                             pin_tms_out_en;
output                             dbg_srst_req;
output                       [0:0] debugint;
input                        [0:0] hart_halted;
input                        [0:0] hart_unavail;
input                        [0:0] hart_under_reset;
output                       [0:0] mtip;
input                              stoptime;

`ifdef AE250_PLDM_SYS_BUS_ACCESS
`else
wire                               debug_hgrant;
wire        [(SYS_DATA_WIDTH-1):0] debug_hrdata;
wire                               debug_hready;
wire                         [1:0] debug_hresp;
wire                        [31:0] debug_haddr;
wire                         [2:0] debug_hburst;
wire                               debug_hbusreq;
wire                         [3:0] debug_hprot;
wire                         [2:0] debug_hsize;
wire                         [1:0] debug_htrans;
wire        [(SYS_DATA_WIDTH-1):0] debug_hwdata;
wire                               debug_hwrite;
`endif
wire           [(HADDR_WIDTH-1):0] NC_rv_araddr;
wire           [(HADDR_WIDTH-1):0] NC_rv_awaddr;
wire                        [31:0] ds5_hrdata;
wire                               ds5_hreadyout;
wire                         [1:0] ds5_hresp;
wire                        [31:0] ds6_hrdata;
wire                               ds6_hreadyout;
wire                         [1:0] ds6_hresp;
wire                        [31:0] ds7_hrdata;
wire                               ds7_hreadyout;
wire                         [1:0] ds7_hresp;
wire                        [31:0] ds4_hrdata;
wire                               ds4_hreadyout;
wire                         [1:0] ds4_hresp;
wire             [HADDR_WIDTH-1:0] NC_ds5_haddr;
wire                         [2:0] NC_ds5_hburst;
wire                         [3:0] NC_ds5_hprot;
wire                               NC_ds5_hready;
wire                               NC_ds5_hsel;
wire                         [2:0] NC_ds5_hsize;
wire                         [1:0] NC_ds5_htrans;
wire                        [31:0] NC_ds5_hwdata;
wire                               NC_ds5_hwrite;
wire             [HADDR_WIDTH-1:0] NC_ds6_haddr;
wire                         [2:0] NC_ds6_hburst;
wire                         [3:0] NC_ds6_hprot;
wire                               NC_ds6_hready;
wire                               NC_ds6_hsel;
wire                         [2:0] NC_ds6_hsize;
wire                         [1:0] NC_ds6_htrans;
wire                        [31:0] NC_ds6_hwdata;
wire                               NC_ds6_hwrite;
wire             [HADDR_WIDTH-1:0] NC_ds7_haddr;
wire                         [2:0] NC_ds7_hburst;
wire                         [3:0] NC_ds7_hprot;
wire                               NC_ds7_hready;
wire                               NC_ds7_hsel;
wire                         [2:0] NC_ds7_hsize;
wire                         [1:0] NC_ds7_htrans;
wire                        [31:0] NC_ds7_hwdata;
wire                               NC_ds7_hwrite;
wire           [(HADDR_WIDTH-1):0] ds1_haddr;
wire                         [2:0] ds1_hburst;
wire                         [3:0] ds1_hprot;
wire                               ds1_hready;
wire                               ds1_hsel;
wire                         [2:0] ds1_hsize;
wire                         [1:0] ds1_htrans;
wire                        [31:0] ds1_hwdata;
wire                               ds1_hwrite;
wire           [(HADDR_WIDTH-1):0] ds2_haddr;
wire                         [2:0] ds2_hburst;
wire                         [3:0] ds2_hprot;
wire                               ds2_hready;
wire                               ds2_hsel;
wire                         [2:0] ds2_hsize;
wire                         [1:0] ds2_htrans;
wire                        [31:0] ds2_hwdata;
wire                               ds2_hwrite;
wire           [(HADDR_WIDTH-1):0] ds3_haddr;
wire                         [2:0] ds3_hburst;
wire                         [3:0] ds3_hprot;
wire                               ds3_hready;
wire                               ds3_hsel;
wire                         [2:0] ds3_hsize;
wire                         [1:0] ds3_htrans;
wire                        [31:0] ds3_hwdata;
wire                               ds3_hwrite;
wire           [(HADDR_WIDTH-1):0] ds4_haddr;
wire                         [2:0] ds4_hburst;
wire                         [3:0] ds4_hprot;
wire                               ds4_hready;
wire                               ds4_hsel;
wire                         [2:0] ds4_hsize;
wire                         [1:0] ds4_htrans;
wire                        [31:0] ds4_hwdata;
wire                               ds4_hwrite;
wire                        [31:0] ds2_hrdata;
wire                               ds2_hreadyout;
wire                         [1:0] ds2_hresp;
wire                         [9:0] NC_t10_eiid;
wire                               NC_t10_eip;
wire                         [9:0] NC_t11_eiid;
wire                               NC_t11_eip;
wire                         [9:0] NC_t12_eiid;
wire                               NC_t12_eip;
wire                         [9:0] NC_t13_eiid;
wire                               NC_t13_eip;
wire                         [9:0] NC_t14_eiid;
wire                               NC_t14_eip;
wire                         [9:0] NC_t15_eiid;
wire                               NC_t15_eip;
wire                         [9:0] NC_t2_eiid;
wire                               NC_t2_eip;
wire                         [9:0] NC_t3_eiid;
wire                               NC_t3_eip;
wire                         [9:0] NC_t4_eiid;
wire                               NC_t4_eip;
wire                         [9:0] NC_t5_eiid;
wire                               NC_t5_eip;
wire                         [9:0] NC_t6_eiid;
wire                               NC_t6_eip;
wire                         [9:0] NC_t7_eiid;
wire                               NC_t7_eip;
wire                         [9:0] NC_t8_eiid;
wire                               NC_t8_eip;
wire                         [9:0] NC_t9_eiid;
wire                               NC_t9_eip;
wire                        [31:0] ds1_hrdata;
wire                               ds1_hreadyout;
wire                         [1:0] ds1_hresp;
wire                        [31:0] ds3_hrdata;
wire                               ds3_hreadyout;
wire                         [1:0] ds3_hresp;

`ifdef AE250_PLDM_SYS_BUS_ACCESS
`else
	assign debug_hgrant = 1'b0;
	assign debug_hrdata = {(SYS_DATA_WIDTH){1'b0}};
	assign debug_hready = 1'b1;
	assign debug_hresp = 2'b00;
`endif
assign ds5_hreadyout = 1'bx;
assign ds5_hresp     = 2'bx;
assign ds5_hrdata    = 32'bx;
assign ds6_hreadyout = 1'bx;
assign ds6_hresp     = 2'bx;
assign ds6_hrdata    = 32'bx;
assign ds7_hreadyout = 1'bx;
assign ds7_hresp     = 2'bx;
assign ds7_hrdata    = 32'bx;
assign NC_rv_araddr = {(HADDR_WIDTH){1'bx}};
assign NC_rv_awaddr = {(HADDR_WIDTH){1'bx}};

atcbusdec250 #(
	.DS0_IS_SLAVE    (0               ),
	.DS1_BASE        (PLIC_BASE       ),
	.DS1_MASK        (PLIC_MASK       ),
	.DS2_BASE        (PLMT_BASE       ),
	.DS2_MASK        (PLMT_MASK       ),
	.DS3_BASE        (PLIC_SW_BASE    ),
	.DS3_MASK        (PLIC_SW_MASK    ),
	.DS4_BASE        (PLDM_BASE       ),
	.DS4_MASK        (PLDM_MASK       ),
	.HADDR_WIDTH     (HADDR_WIDTH     )
) atcbusdec250 (
	.ds0_hreadyout(hready       ),
	.ds0_hresp    (hresp        ),
	.ds0_hrdata   (hrdata       ),
	.ds0_hready   (     ),
	.ds0_hsel     (     ),
	.ds0_haddr    (haddr        ),
	.ds0_hwdata   (hwdata       ),
	.ds0_hburst   (hburst       ),
	.ds0_hwrite   (hwrite       ),
	.ds0_hprot    (hprot        ),
	.ds0_hsize    (hsize        ),
	.ds0_htrans   (htrans       ),
	.ds1_hreadyout(ds1_hreadyout),
	.ds1_hresp    (ds1_hresp    ),
	.ds1_hrdata   (ds1_hrdata   ),
	.ds1_hready   (ds1_hready   ),
	.ds1_hsel     (ds1_hsel     ),
	.ds1_haddr    (ds1_haddr    ),
	.ds1_hwdata   (ds1_hwdata   ),
	.ds1_hburst   (ds1_hburst   ),
	.ds1_hwrite   (ds1_hwrite   ),
	.ds1_hprot    (ds1_hprot    ),
	.ds1_hsize    (ds1_hsize    ),
	.ds1_htrans   (ds1_htrans   ),
	.ds2_hreadyout(ds2_hreadyout),
	.ds2_hresp    (ds2_hresp    ),
	.ds2_hrdata   (ds2_hrdata   ),
	.ds2_hready   (ds2_hready   ),
	.ds2_hsel     (ds2_hsel     ),
	.ds2_haddr    (ds2_haddr    ),
	.ds2_hwdata   (ds2_hwdata   ),
	.ds2_hburst   (ds2_hburst   ),
	.ds2_hwrite   (ds2_hwrite   ),
	.ds2_hprot    (ds2_hprot    ),
	.ds2_hsize    (ds2_hsize    ),
	.ds2_htrans   (ds2_htrans   ),
	.ds3_hreadyout(ds3_hreadyout),
	.ds3_hresp    (ds3_hresp    ),
	.ds3_hrdata   (ds3_hrdata   ),
	.ds3_hready   (ds3_hready   ),
	.ds3_hsel     (ds3_hsel     ),
	.ds3_haddr    (ds3_haddr    ),
	.ds3_hwdata   (ds3_hwdata   ),
	.ds3_hburst   (ds3_hburst   ),
	.ds3_hwrite   (ds3_hwrite   ),
	.ds3_hprot    (ds3_hprot    ),
	.ds3_hsize    (ds3_hsize    ),
	.ds3_htrans   (ds3_htrans   ),
	.ds4_hreadyout(ds4_hreadyout),
	.ds4_hresp    (ds4_hresp    ),
	.ds4_hrdata   (ds4_hrdata   ),
	.ds4_hready   (ds4_hready   ),
	.ds4_hsel     (ds4_hsel     ),
	.ds4_haddr    (ds4_haddr    ),
	.ds4_hwdata   (ds4_hwdata   ),
	.ds4_hburst   (ds4_hburst   ),
	.ds4_hwrite   (ds4_hwrite   ),
	.ds4_hprot    (ds4_hprot    ),
	.ds4_hsize    (ds4_hsize    ),
	.ds4_htrans   (ds4_htrans   ),
	.ds5_hreadyout(ds5_hreadyout),
	.ds5_hresp    (ds5_hresp    ),
	.ds5_hrdata   (ds5_hrdata   ),
	.ds5_hready   (NC_ds5_hready),
	.ds5_hsel     (NC_ds5_hsel  ),
	.ds5_haddr    (NC_ds5_haddr ),
	.ds5_hwdata   (NC_ds5_hwdata),
	.ds5_hburst   (NC_ds5_hburst),
	.ds5_hwrite   (NC_ds5_hwrite),
	.ds5_hprot    (NC_ds5_hprot ),
	.ds5_hsize    (NC_ds5_hsize ),
	.ds5_htrans   (NC_ds5_htrans),
	.ds6_hreadyout(ds6_hreadyout),
	.ds6_hresp    (ds6_hresp    ),
	.ds6_hrdata   (ds6_hrdata   ),
	.ds6_hready   (NC_ds6_hready),
	.ds6_hsel     (NC_ds6_hsel  ),
	.ds6_haddr    (NC_ds6_haddr ),
	.ds6_hwdata   (NC_ds6_hwdata),
	.ds6_hburst   (NC_ds6_hburst),
	.ds6_hwrite   (NC_ds6_hwrite),
	.ds6_hprot    (NC_ds6_hprot ),
	.ds6_hsize    (NC_ds6_hsize ),
	.ds6_htrans   (NC_ds6_htrans),
	.ds7_hreadyout(ds7_hreadyout),
	.ds7_hresp    (ds7_hresp    ),
	.ds7_hrdata   (ds7_hrdata   ),
	.ds7_hready   (NC_ds7_hready),
	.ds7_hsel     (NC_ds7_hsel  ),
	.ds7_haddr    (NC_ds7_haddr ),
	.ds7_hwdata   (NC_ds7_hwdata),
	.ds7_hburst   (NC_ds7_hburst),
	.ds7_hwrite   (NC_ds7_hwrite),
	.ds7_hprot    (NC_ds7_hprot ),
	.ds7_hsize    (NC_ds7_hsize ),
	.ds7_htrans   (NC_ds7_htrans),
	.hclk         (hclk         ),
	.hresetn      (hresetn      ),
	.us_hreadyout (uncore_hready),
	.us_hresp     (uncore_hresp ),
	.us_hrdata    (uncore_hrdata),
	.us_hsel      (1'b1         ),
	.us_hready    (1'bx         ),
	.us_haddr     (uncore_haddr ),
	.us_hwdata    (uncore_hwdata),
	.us_hburst    (uncore_hburst),
	.us_hwrite    (uncore_hwrite),
	.us_hprot     (uncore_hprot ),
	.us_hsize     (uncore_hsize ),
	.us_htrans    (uncore_htrans)
);

`ifdef NDS_BOARD_CF1
nceplic100 #(
	.ADDR_WIDTH      (HADDR_WIDTH     ),
	.ASYNC_INT       (ASYNC_INT       ),
	.EDGE_TRIGGER    (1024'd0         ),
	.INT_NUM         (32              ),
	.MAX_PRIORITY    (3               ),
	.PLIC_BUS        ("ahb"           ),
	.TARGET_NUM      (PLIC_TARGET_NUM ),
	.VECTOR_PLIC_SUPPORT("yes"           )
) u_plic (
	.araddr   ({HADDR_WIDTH{1'bx}}),
	.arburst  (2'd0               ),
	.arcache  (4'd0               ),
	.arid     (4'd0               ),
	.arlen    (8'd0               ),
	.arlock   (1'd0               ),
	.arprot   (3'd0               ),
	.arready  (           ),
	.arsize   (3'd0               ),
	.arvalid  (1'd0               ),
	.awaddr   ({HADDR_WIDTH{1'bx}}),
	.awburst  (2'd0               ),
	.awcache  (4'd0               ),
	.awid     (4'd0               ),
	.awlen    (8'd0               ),
	.awlock   (1'd0               ),
	.awprot   (3'd0               ),
	.awready  (           ),
	.awsize   (3'd0               ),
	.awvalid  (1'd0               ),
	.bid      (           ),
	.bready   (1'd0               ),
	.bresp    (           ),
	.bvalid   (           ),
	.haddr    (ds1_haddr          ),
	.hburst   (ds1_hburst         ),
	.hrdata   (ds1_hrdata         ),
	.hready   (ds1_hready         ),
	.hreadyout(ds1_hreadyout      ),
	.hresp    (ds1_hresp          ),
	.hsel     (ds1_hsel           ),
	.hsize    (ds1_hsize          ),
	.htrans   (ds1_htrans         ),
	.hwdata   (ds1_hwdata         ),
	.hwrite   (ds1_hwrite         ),
	.rdata    (           ),
	.rid      (           ),
	.rlast    (           ),
	.rready   (1'd0               ),
	.rresp    (           ),
	.rvalid   (           ),
	.wdata    (32'd0              ),
	.wlast    (1'd0               ),
	.wready   (           ),
	.wstrb    (4'd0               ),
	.wvalid   (1'd0               ),
	.clk      (hclk               ),
	.reset_n  (hresetn            ),
	.int_src  (int_src            ),
	.t0_eip   (meip               ),
	.t0_eiid  (meiid              ),
	.t0_eiack (meiack             ),
	.t1_eip   (seip               ),
	.t1_eiid  (seiid              ),
	.t1_eiack (seiack             ),
	.t2_eip   (NC_t2_eip          ),
	.t2_eiid  (NC_t2_eiid         ),
	.t2_eiack (1'b0               ),
	.t3_eip   (NC_t3_eip          ),
	.t3_eiid  (NC_t3_eiid         ),
	.t3_eiack (1'b0               ),
	.t4_eip   (NC_t4_eip          ),
	.t4_eiid  (NC_t4_eiid         ),
	.t4_eiack (1'b0               ),
	.t5_eip   (NC_t5_eip          ),
	.t5_eiid  (NC_t5_eiid         ),
	.t5_eiack (1'b0               ),
	.t6_eip   (NC_t6_eip          ),
	.t6_eiid  (NC_t6_eiid         ),
	.t6_eiack (1'b0               ),
	.t7_eip   (NC_t7_eip          ),
	.t7_eiid  (NC_t7_eiid         ),
	.t7_eiack (1'b0               ),
	.t8_eip   (NC_t8_eip          ),
	.t8_eiid  (NC_t8_eiid         ),
	.t8_eiack (1'b0               ),
	.t9_eip   (NC_t9_eip          ),
	.t9_eiid  (NC_t9_eiid         ),
	.t9_eiack (1'b0               ),
	.t10_eip  (NC_t10_eip         ),
	.t10_eiid (NC_t10_eiid        ),
	.t10_eiack(1'b0               ),
	.t11_eip  (NC_t11_eip         ),
	.t11_eiid (NC_t11_eiid        ),
	.t11_eiack(1'b0               ),
	.t12_eip  (NC_t12_eip         ),
	.t12_eiid (NC_t12_eiid        ),
	.t12_eiack(1'b0               ),
	.t13_eip  (NC_t13_eip         ),
	.t13_eiid (NC_t13_eiid        ),
	.t13_eiack(1'b0               ),
	.t14_eip  (NC_t14_eip         ),
	.t14_eiid (NC_t14_eiid        ),
	.t14_eiack(1'b0               ),
	.t15_eip  (NC_t15_eip         ),
	.t15_eiid (NC_t15_eiid        ),
	.t15_eiack(1'b0               )
);

`else
nceplic100 #(
	.ADDR_WIDTH      (HADDR_WIDTH     ),
	.ASYNC_INT       (ASYNC_INT       ),
	.EDGE_TRIGGER    (1024'd0         ),
	.INT_NUM         (31              ),
	.MAX_PRIORITY    (3               ),
	.PLIC_BUS        ("ahb"           ),
	.TARGET_NUM      (PLIC_TARGET_NUM ),
	.VECTOR_PLIC_SUPPORT("yes"           )
) u_plic (
	.araddr   ({HADDR_WIDTH{1'bx}}),
	.arburst  (2'd0               ),
	.arcache  (4'd0               ),
	.arid     (4'd0               ),
	.arlen    (8'd0               ),
	.arlock   (1'd0               ),
	.arprot   (3'd0               ),
	.arready  (           ),
	.arsize   (3'd0               ),
	.arvalid  (1'd0               ),
	.awaddr   ({HADDR_WIDTH{1'bx}}),
	.awburst  (2'd0               ),
	.awcache  (4'd0               ),
	.awid     (4'd0               ),
	.awlen    (8'd0               ),
	.awlock   (1'd0               ),
	.awprot   (3'd0               ),
	.awready  (           ),
	.awsize   (3'd0               ),
	.awvalid  (1'd0               ),
	.bid      (           ),
	.bready   (1'd0               ),
	.bresp    (           ),
	.bvalid   (           ),
	.haddr    (ds1_haddr          ),
	.hburst   (ds1_hburst         ),
	.hrdata   (ds1_hrdata         ),
	.hready   (ds1_hready         ),
	.hreadyout(ds1_hreadyout      ),
	.hresp    (ds1_hresp          ),
	.hsel     (ds1_hsel           ),
	.hsize    (ds1_hsize          ),
	.htrans   (ds1_htrans         ),
	.hwdata   (ds1_hwdata         ),
	.hwrite   (ds1_hwrite         ),
	.rdata    (           ),
	.rid      (           ),
	.rlast    (           ),
	.rready   (1'd0               ),
	.rresp    (           ),
	.rvalid   (           ),
	.wdata    (32'd0              ),
	.wlast    (1'd0               ),
	.wready   (           ),
	.wstrb    (4'd0               ),
	.wvalid   (1'd0               ),
	.clk      (hclk               ),
	.reset_n  (hresetn            ),
	.int_src  (int_src            ),
	.t0_eip   (meip               ),
	.t0_eiid  (meiid              ),
	.t0_eiack (meiack             ),
	.t1_eip   (seip               ),
	.t1_eiid  (seiid              ),
	.t1_eiack (seiack             ),
	.t2_eip   (NC_t2_eip          ),
	.t2_eiid  (NC_t2_eiid         ),
	.t2_eiack (1'b0               ),
	.t3_eip   (NC_t3_eip          ),
	.t3_eiid  (NC_t3_eiid         ),
	.t3_eiack (1'b0               ),
	.t4_eip   (NC_t4_eip          ),
	.t4_eiid  (NC_t4_eiid         ),
	.t4_eiack (1'b0               ),
	.t5_eip   (NC_t5_eip          ),
	.t5_eiid  (NC_t5_eiid         ),
	.t5_eiack (1'b0               ),
	.t6_eip   (NC_t6_eip          ),
	.t6_eiid  (NC_t6_eiid         ),
	.t6_eiack (1'b0               ),
	.t7_eip   (NC_t7_eip          ),
	.t7_eiid  (NC_t7_eiid         ),
	.t7_eiack (1'b0               ),
	.t8_eip   (NC_t8_eip          ),
	.t8_eiid  (NC_t8_eiid         ),
	.t8_eiack (1'b0               ),
	.t9_eip   (NC_t9_eip          ),
	.t9_eiid  (NC_t9_eiid         ),
	.t9_eiack (1'b0               ),
	.t10_eip  (NC_t10_eip         ),
	.t10_eiid (NC_t10_eiid        ),
	.t10_eiack(1'b0               ),
	.t11_eip  (NC_t11_eip         ),
	.t11_eiid (NC_t11_eiid        ),
	.t11_eiack(1'b0               ),
	.t12_eip  (NC_t12_eip         ),
	.t12_eiid (NC_t12_eiid        ),
	.t12_eiack(1'b0               ),
	.t13_eip  (NC_t13_eip         ),
	.t13_eiid (NC_t13_eiid        ),
	.t13_eiack(1'b0               ),
	.t14_eip  (NC_t14_eip         ),
	.t14_eiid (NC_t14_eiid        ),
	.t14_eiack(1'b0               ),
	.t15_eip  (NC_t15_eip         ),
	.t15_eiid (NC_t15_eiid        ),
	.t15_eiack(1'b0               )
);

`endif
nceplic100 #(
	.ADDR_WIDTH      (HADDR_WIDTH     ),
	.ASYNC_INT       (1024'd0         ),
	.EDGE_TRIGGER    (1024'd0         ),
	.INT_NUM         (1               ),
	.MAX_PRIORITY    (3               ),
	.PLIC_BUS        ("ahb"           ),
	.TARGET_NUM      (5'd1            ),
	.VECTOR_PLIC_SUPPORT("no"            )
) u_plic_sw (
	.araddr   ({HADDR_WIDTH{1'bx}}),
	.arburst  (2'd0               ),
	.arcache  (4'd0               ),
	.arid     (4'd0               ),
	.arlen    (8'd0               ),
	.arlock   (1'd0               ),
	.arprot   (3'd0               ),
	.arready  (           ),
	.arsize   (3'd0               ),
	.arvalid  (1'd0               ),
	.awaddr   ({HADDR_WIDTH{1'bx}}),
	.awburst  (2'd0               ),
	.awcache  (4'd0               ),
	.awid     (4'd0               ),
	.awlen    (8'd0               ),
	.awlock   (1'd0               ),
	.awprot   (3'd0               ),
	.awready  (           ),
	.awsize   (3'd0               ),
	.awvalid  (1'd0               ),
	.bid      (           ),
	.bready   (1'd0               ),
	.bresp    (           ),
	.bvalid   (           ),
	.haddr    (ds3_haddr          ),
	.hburst   (ds3_hburst         ),
	.hrdata   (ds3_hrdata         ),
	.hready   (ds3_hready         ),
	.hreadyout(ds3_hreadyout      ),
	.hresp    (ds3_hresp          ),
	.hsel     (ds3_hsel           ),
	.hsize    (ds3_hsize          ),
	.htrans   (ds3_htrans         ),
	.hwdata   (ds3_hwdata         ),
	.hwrite   (ds3_hwrite         ),
	.rdata    (           ),
	.rid      (           ),
	.rlast    (           ),
	.rready   (1'd0               ),
	.rresp    (           ),
	.rvalid   (           ),
	.wdata    (32'd0              ),
	.wlast    (1'd0               ),
	.wready   (           ),
	.wstrb    (4'd0               ),
	.wvalid   (1'd0               ),
	.clk      (hclk               ),
	.reset_n  (hresetn            ),
	.int_src  (1'b0               ),
	.t0_eip   (msip               ),
	.t0_eiid  (                   ),
	.t0_eiack (1'b0               ),
	.t1_eip   (                   ),
	.t1_eiid  (                   ),
	.t1_eiack (1'b0               ),
	.t2_eip   (                   ),
	.t2_eiid  (                   ),
	.t2_eiack (1'b0               ),
	.t3_eip   (                   ),
	.t3_eiid  (                   ),
	.t3_eiack (1'b0               ),
	.t4_eip   (                   ),
	.t4_eiid  (                   ),
	.t4_eiack (1'b0               ),
	.t5_eip   (                   ),
	.t5_eiid  (                   ),
	.t5_eiack (1'b0               ),
	.t6_eip   (                   ),
	.t6_eiid  (                   ),
	.t6_eiack (1'b0               ),
	.t7_eip   (                   ),
	.t7_eiid  (                   ),
	.t7_eiack (1'b0               ),
	.t8_eip   (                   ),
	.t8_eiid  (                   ),
	.t8_eiack (1'b0               ),
	.t9_eip   (                   ),
	.t9_eiid  (                   ),
	.t9_eiack (1'b0               ),
	.t10_eip  (                   ),
	.t10_eiid (                   ),
	.t10_eiack(1'b0               ),
	.t11_eip  (                   ),
	.t11_eiid (                   ),
	.t11_eiack(1'b0               ),
	.t12_eip  (                   ),
	.t12_eiid (                   ),
	.t12_eiack(1'b0               ),
	.t13_eip  (                   ),
	.t13_eiid (                   ),
	.t13_eiack(1'b0               ),
	.t14_eip  (                   ),
	.t14_eiid (                   ),
	.t14_eiack(1'b0               ),
	.t15_eip  (                   ),
	.t15_eiid (                   ),
	.t15_eiack(1'b0               )
);

ae250_debug_subsystem #(
	.ADDR_WIDTH      (HADDR_WIDTH     ),
	.HASEL_SUPPORT   (HASEL_SUPPORT   ),
	.RV_DATA_WIDTH   (RV_DATA_WIDTH   ),
	.SYS_DATA_WIDTH  (SYS_DATA_WIDTH  )
) ae250_debug_subsystem (
	.debugint        (debugint        ),
	.hart_halted     (hart_halted     ),
	.hart_unavail    (hart_unavail    ),
	.hart_under_reset(hart_under_reset),
	.pin_tdi_in      (pin_tdi_in      ),
	.pin_tdi_out     (pin_tdi_out     ),
	.pin_tdi_out_en  (pin_tdi_out_en  ),
	.pin_tdo_in      (pin_tdo_in      ),
	.pin_tdo_out     (pin_tdo_out     ),
	.pin_tdo_out_en  (pin_tdo_out_en  ),
	.pin_tms_in      (pin_tms_in      ),
	.pin_tms_out     (pin_tms_out     ),
	.pin_tms_out_en  (pin_tms_out_en  ),
	.pin_trst_in     (pin_trst_in     ),
	.pin_trst_out    (pin_trst_out    ),
	.pin_trst_out_en (pin_trst_out_en ),
	.resethaltreq    (resethaltreq    ),
	.clk             (hclk            ),
	.dbg_tck         (dbg_tck         ),
	.dbg_wakeup_req  (dbg_wakeup_req  ),
	.por_rstn        (por_rstn        ),
	.test_mode       (test_mode       ),
	.dbg_srst_req    (dbg_srst_req    ),
	.dmactive        (dmactive        ),
	.haddr           (ds4_haddr       ),
	.hburst          (ds4_hburst      ),
	.hclk            (hclk            ),
	.hprot           (ds4_hprot       ),
	.hrdata          (ds4_hrdata      ),
	.hready          (ds4_hready      ),
	.hreadyout       (ds4_hreadyout   ),
	.hresp           (ds4_hresp       ),
	.hsel            (ds4_hsel        ),
	.hsize           (ds4_hsize       ),
	.htrans          (ds4_htrans      ),
	.hwdata          (ds4_hwdata      ),
	.hwrite          (ds4_hwrite      ),
	.reset_n         (hresetn         ),
	.rv_araddr       (NC_rv_araddr    ),
	.rv_arburst      (2'bx            ),
	.rv_arcache      (4'bx            ),
	.rv_arid         (4'bx            ),
	.rv_arlen        (8'bx            ),
	.rv_arlock       (1'bx            ),
	.rv_arprot       (3'bx            ),
	.rv_arready      (        ),
	.rv_arsize       (3'bx            ),
	.rv_arvalid      (1'bx            ),
	.rv_awaddr       (NC_rv_awaddr    ),
	.rv_awburst      (2'bx            ),
	.rv_awcache      (4'bx            ),
	.rv_awid         (4'bx            ),
	.rv_awlen        (8'bx            ),
	.rv_awlock       (1'bx            ),
	.rv_awprot       (3'bx            ),
	.rv_awready      (        ),
	.rv_awsize       (3'bx            ),
	.rv_awvalid      (1'bx            ),
	.rv_bid          (        ),
	.rv_bready       (1'bx            ),
	.rv_bresp        (        ),
	.rv_bvalid       (        ),
	.rv_rdata        (        ),
	.rv_rid          (        ),
	.rv_rlast        (        ),
	.rv_rready       (1'bx            ),
	.rv_rresp        (        ),
	.rv_rvalid       (        ),
	.rv_wdata        (32'hx           ),
	.rv_wlast        (1'bx            ),
	.rv_wready       (        ),
	.rv_wstrb        (4'bx            ),
	.rv_wvalid       (1'bx            ),
	.sys_araddr      (        ),
	.sys_arburst     (        ),
	.sys_arcache     (        ),
	.sys_arid        (        ),
	.sys_arlen       (        ),
	.sys_arlock      (        ),
	.sys_arprot      (        ),
	.sys_arready     (1'bx            ),
	.sys_arsize      (        ),
	.sys_arvalid     (        ),
	.sys_awaddr      (        ),
	.sys_awburst     (        ),
	.sys_awcache     (        ),
	.sys_awid        (        ),
	.sys_awlen       (        ),
	.sys_awlock      (        ),
	.sys_awprot      (        ),
	.sys_awready     (1'bx            ),
	.sys_awsize      (        ),
	.sys_awvalid     (        ),
	.sys_bid         (4'bx            ),
	.sys_bready      (        ),
	.sys_bresp       (2'bx            ),
	.sys_bvalid      (1'bx            ),
	.sys_haddr       (debug_haddr     ),
	.sys_hburst      (debug_hburst    ),
	.sys_hbusreq     (debug_hbusreq   ),
	.sys_hgrant      (debug_hgrant    ),
	.sys_hprot       (debug_hprot     ),
	.sys_hrdata      (debug_hrdata    ),
	.sys_hready      (debug_hready    ),
	.sys_hresp       (debug_hresp     ),
	.sys_hsize       (debug_hsize     ),
	.sys_htrans      (debug_htrans    ),
	.sys_hwdata      (debug_hwdata    ),
	.sys_hwrite      (debug_hwrite    ),
	.sys_rdata       (32'hx           ),
	.sys_rid         (4'bx            ),
	.sys_rlast       (1'bx            ),
	.sys_rready      (        ),
	.sys_rresp       (2'bx            ),
	.sys_rvalid      (1'bx            ),
	.sys_wdata       (        ),
	.sys_wlast       (        ),
	.sys_wready      (1'bx            ),
	.sys_wstrb       (        ),
	.sys_wvalid      (        )
);

nceplmt100 #(
	.ADDR_WIDTH      (HADDR_WIDTH     ),
	.NHART           (1               )
) u_nceplmt100 (
	.por_rstn (por_rstn           ),
	.araddr   ({HADDR_WIDTH{1'bx}}),
	.arburst  (2'd0               ),
	.arcache  (4'd0               ),
	.arid     (4'd0               ),
	.arlen    (8'd0               ),
	.arlock   (1'd0               ),
	.arprot   (3'd0               ),
	.arready  (           ),
	.arsize   (3'd0               ),
	.arvalid  (1'd0               ),
	.awaddr   ({HADDR_WIDTH{1'bx}}),
	.awburst  (2'd0               ),
	.awcache  (4'd0               ),
	.awid     (4'd0               ),
	.awlen    (8'd0               ),
	.awlock   (1'd0               ),
	.awprot   (3'd0               ),
	.awready  (           ),
	.awsize   (3'd0               ),
	.awvalid  (1'd0               ),
	.bid      (           ),
	.bready   (1'd0               ),
	.bresp    (           ),
	.bvalid   (           ),
	.haddr    (ds2_haddr          ),
	.hburst   (ds2_hburst         ),
	.hrdata   (ds2_hrdata         ),
	.hready   (ds2_hready         ),
	.hreadyout(ds2_hreadyout      ),
	.hresp    (ds2_hresp          ),
	.hsel     (ds2_hsel           ),
	.hsize    (ds2_hsize          ),
	.htrans   (ds2_htrans         ),
	.hwdata   (ds2_hwdata         ),
	.hwrite   (ds2_hwrite         ),
	.mtip     (mtip               ),
	.rdata    (           ),
	.rid      (           ),
	.rlast    (           ),
	.rready   (1'd0               ),
	.rresp    (           ),
	.rvalid   (           ),
	.wdata    (32'd0              ),
	.wlast    (1'd0               ),
	.wready   (           ),
	.wstrb    (4'd0               ),
	.wvalid   (1'd0               ),
	.clk      (hclk               ),
	.resetn   (hresetn            ),
	.mtime_clk(mtime_clk          ),
	.stoptime (stoptime           )
);

endmodule

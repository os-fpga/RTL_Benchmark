// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary



module nceplic100 (
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
	  reset_n,
	  int_src,
	  t0_eip,
	  t0_eiid,
	  t0_eiack,
	  t1_eip,
	  t1_eiid,
	  t1_eiack,
	  t2_eip,
	  t2_eiid,
	  t2_eiack,
	  t3_eip,
	  t3_eiid,
	  t3_eiack,
	  t4_eip,
	  t4_eiid,
	  t4_eiack,
	  t5_eip,
	  t5_eiid,
	  t5_eiack,
	  t6_eip,
	  t6_eiid,
	  t6_eiack,
	  t7_eip,
	  t7_eiid,
	  t7_eiack,
	  t8_eip,
	  t8_eiid,
	  t8_eiack,
	  t9_eip,
	  t9_eiid,
	  t9_eiack,
	  t10_eip,
	  t10_eiid,
	  t10_eiack,
	  t11_eip,
	  t11_eiid,
	  t11_eiack,
	  t12_eip,
	  t12_eiid,
	  t12_eiack,
	  t13_eip,
	  t13_eiid,
	  t13_eiack,
	  t14_eip,
	  t14_eiid,
	  t14_eiack,
	  t15_eip,
	  t15_eiid,
	  t15_eiack
);

parameter    		INT_NUM = 63;
parameter    		TARGET_NUM = 16;
parameter    		MAX_PRIORITY = 15;
parameter 		PROGRAMMABLE_TRIGGER = 0;
parameter [1023:0]	EDGE_TRIGGER = 1024'b0;
parameter [1023:0]	ASYNC_INT = 1024'b0;
parameter 		ADDR_WIDTH = 32;
parameter 		DATA_WIDTH = 32;
parameter 		VECTOR_PLIC_SUPPORT = "no";
parameter 		PLIC_BUS = "axi";
parameter 		ID_WIDTH = 4;
parameter 		SYNC_STAGE = 2;

localparam BIT_REGION_SOURCE_PRIORITY		= 7;
localparam BIT_REGION_INTERRUPT_PENDING		= 6;
localparam BIT_REGION_TARGET_ENABLE		= 5;
localparam BIT_REGION_TARGET_THRESHOLD		= 4;
localparam BIT_REGION_PREEMPTIVE_STACK		= 3;
localparam BIT_REGION_FEATURE			= 2;
localparam BIT_REGION_TRIGGER_TYPE		= 1;
localparam BIT_REGION_CONFIG			= 0;

input           [(ADDR_WIDTH-1):0] araddr;
input                        [1:0] arburst;
input                        [3:0] arcache;
input             [(ID_WIDTH-1):0] arid;
input                        [7:0] arlen;
input                              arlock;
input                        [2:0] arprot;
output                             arready;
input                        [2:0] arsize;
input                              arvalid;
input           [(ADDR_WIDTH-1):0] awaddr;
input                        [1:0] awburst;
input                        [3:0] awcache;
input             [(ID_WIDTH-1):0] awid;
input                        [7:0] awlen;
input                              awlock;
input                        [2:0] awprot;
output                             awready;
input                        [2:0] awsize;
input                              awvalid;
output            [(ID_WIDTH-1):0] bid;
input                              bready;
output                       [1:0] bresp;
output                             bvalid;
input           [(ADDR_WIDTH-1):0] haddr;
input                        [2:0] hburst;
output          [(DATA_WIDTH-1):0] hrdata;
input                              hready;
output                             hreadyout;
output                       [1:0] hresp;
input                              hsel;
input                        [2:0] hsize;
input                        [1:0] htrans;
input           [(DATA_WIDTH-1):0] hwdata;
input                              hwrite;
output          [(DATA_WIDTH-1):0] rdata;
output            [(ID_WIDTH-1):0] rid;
output                             rlast;
input                              rready;
output                       [1:0] rresp;
output                             rvalid;
input           [(DATA_WIDTH-1):0] wdata;
input                              wlast;
output                             wready;
input       [((DATA_WIDTH/8)-1):0] wstrb;
input                              wvalid;
input                              clk;
input                              reset_n;
input                  [INT_NUM:1] int_src;
output                             t0_eip;
output                       [9:0] t0_eiid;
input                              t0_eiack;
output                             t1_eip;
output                       [9:0] t1_eiid;
input                              t1_eiack;
output                             t2_eip;
output                       [9:0] t2_eiid;
input                              t2_eiack;
output                             t3_eip;
output                       [9:0] t3_eiid;
input                              t3_eiack;
output                             t4_eip;
output                       [9:0] t4_eiid;
input                              t4_eiack;
output                             t5_eip;
output                       [9:0] t5_eiid;
input                              t5_eiack;
output                             t6_eip;
output                       [9:0] t6_eiid;
input                              t6_eiack;
output                             t7_eip;
output                       [9:0] t7_eiid;
input                              t7_eiack;
output                             t8_eip;
output                       [9:0] t8_eiid;
input                              t8_eiack;
output                             t9_eip;
output                       [9:0] t9_eiid;
input                              t9_eiack;
output                             t10_eip;
output                       [9:0] t10_eiid;
input                              t10_eiack;
output                             t11_eip;
output                       [9:0] t11_eiid;
input                              t11_eiack;
output                             t12_eip;
output                       [9:0] t12_eiid;
input                              t12_eiack;
output                             t13_eip;
output                       [9:0] t13_eiid;
input                              t13_eiack;
output                             t14_eip;
output                       [9:0] t14_eiid;
input                              t14_eiack;
output                             t15_eip;
output                       [9:0] t15_eiid;
input                              t15_eiack;

wire                               dep_delay_wr;
wire                        [21:2] req_addr;
wire                               req_hit_dep;
wire                         [7:0] req_region_sel;
wire                               req_valid;
wire                               req_wr;
wire                        [31:0] wr_data;
wire                        [31:0] rd_data;


nceplic100_busif #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BIT_REGION_CONFIG(BIT_REGION_CONFIG),
	.BIT_REGION_FEATURE(BIT_REGION_FEATURE),
	.BIT_REGION_INTERRUPT_PENDING(BIT_REGION_INTERRUPT_PENDING),
	.BIT_REGION_PREEMPTIVE_STACK(BIT_REGION_PREEMPTIVE_STACK),
	.BIT_REGION_SOURCE_PRIORITY(BIT_REGION_SOURCE_PRIORITY),
	.BIT_REGION_TARGET_ENABLE(BIT_REGION_TARGET_ENABLE),
	.BIT_REGION_TARGET_THRESHOLD(BIT_REGION_TARGET_THRESHOLD),
	.BIT_REGION_TRIGGER_TYPE(BIT_REGION_TRIGGER_TYPE),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.INT_NUM         (INT_NUM         ),
	.MAX_PRIORITY    (MAX_PRIORITY    ),
	.PLIC_BUS        (PLIC_BUS        ),
	.TARGET_NUM      (TARGET_NUM      )
) nceplic100_busif (
	.awid          (awid          ),
	.awaddr        (awaddr        ),
	.awlen         (awlen         ),
	.awsize        (awsize        ),
	.awburst       (awburst       ),
	.awlock        (awlock        ),
	.awcache       (awcache       ),
	.awprot        (awprot        ),
	.awvalid       (awvalid       ),
	.awready       (awready       ),
	.arid          (arid          ),
	.araddr        (araddr        ),
	.arlen         (arlen         ),
	.arsize        (arsize        ),
	.arburst       (arburst       ),
	.arlock        (arlock        ),
	.arcache       (arcache       ),
	.arprot        (arprot        ),
	.arvalid       (arvalid       ),
	.arready       (arready       ),
	.wdata         (wdata         ),
	.wstrb         (wstrb         ),
	.wlast         (wlast         ),
	.wvalid        (wvalid        ),
	.wready        (wready        ),
	.bid           (bid           ),
	.bresp         (bresp         ),
	.bvalid        (bvalid        ),
	.bready        (bready        ),
	.rid           (rid           ),
	.rdata         (rdata         ),
	.rresp         (rresp         ),
	.rlast         (rlast         ),
	.rvalid        (rvalid        ),
	.rready        (rready        ),
	.htrans        (htrans        ),
	.hsize         (hsize         ),
	.hburst        (hburst        ),
	.haddr         (haddr         ),
	.hsel          (hsel          ),
	.hwrite        (hwrite        ),
	.hwdata        (hwdata        ),
	.hready        (hready        ),
	.hreadyout     (hreadyout     ),
	.hrdata        (hrdata        ),
	.hresp         (hresp         ),
	.clk           (clk           ),
	.reset_n       (reset_n       ),
	.req_valid     (req_valid     ),
	.req_hit_dep   (req_hit_dep   ),
	.dep_delay_wr  (dep_delay_wr  ),
	.req_wr        (req_wr        ),
	.req_addr      (req_addr      ),
	.req_region_sel(req_region_sel),
	.rd_data       (rd_data       ),
	.wr_data       (wr_data       )
);

nceplic100_core #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.ASYNC_INT       (ASYNC_INT       ),
	.BIT_REGION_CONFIG(BIT_REGION_CONFIG),
	.BIT_REGION_FEATURE(BIT_REGION_FEATURE),
	.BIT_REGION_INTERRUPT_PENDING(BIT_REGION_INTERRUPT_PENDING),
	.BIT_REGION_PREEMPTIVE_STACK(BIT_REGION_PREEMPTIVE_STACK),
	.BIT_REGION_SOURCE_PRIORITY(BIT_REGION_SOURCE_PRIORITY),
	.BIT_REGION_TARGET_ENABLE(BIT_REGION_TARGET_ENABLE),
	.BIT_REGION_TARGET_THRESHOLD(BIT_REGION_TARGET_THRESHOLD),
	.BIT_REGION_TRIGGER_TYPE(BIT_REGION_TRIGGER_TYPE),
	.EDGE_TRIGGER    (EDGE_TRIGGER    ),
	.INT_NUM         (INT_NUM         ),
	.MAX_PRIORITY    (MAX_PRIORITY    ),
	.PROGRAMMABLE_TRIGGER(PROGRAMMABLE_TRIGGER),
	.SYNC_STAGE      (SYNC_STAGE      ),
	.TARGET_NUM      (TARGET_NUM      ),
	.VECTOR_PLIC_SUPPORT(VECTOR_PLIC_SUPPORT)
) nceplic100_core (
	.clk           (clk           ),
	.reset_n       (reset_n       ),
	.req_valid     (req_valid     ),
	.req_hit_dep   (req_hit_dep   ),
	.req_wr        (req_wr        ),
	.dep_delay_wr  (dep_delay_wr  ),
	.req_addr      (req_addr      ),
	.req_region_sel(req_region_sel),
	.rd_data       (rd_data       ),
	.wr_data       (wr_data       ),
	.int_src       (int_src       ),
	.t0_eip        (t0_eip        ),
	.t0_eiid       (t0_eiid       ),
	.t0_eiack      (t0_eiack      ),
	.t1_eip        (t1_eip        ),
	.t1_eiid       (t1_eiid       ),
	.t1_eiack      (t1_eiack      ),
	.t2_eip        (t2_eip        ),
	.t2_eiid       (t2_eiid       ),
	.t2_eiack      (t2_eiack      ),
	.t3_eip        (t3_eip        ),
	.t3_eiid       (t3_eiid       ),
	.t3_eiack      (t3_eiack      ),
	.t4_eip        (t4_eip        ),
	.t4_eiid       (t4_eiid       ),
	.t4_eiack      (t4_eiack      ),
	.t5_eip        (t5_eip        ),
	.t5_eiid       (t5_eiid       ),
	.t5_eiack      (t5_eiack      ),
	.t6_eip        (t6_eip        ),
	.t6_eiid       (t6_eiid       ),
	.t6_eiack      (t6_eiack      ),
	.t7_eip        (t7_eip        ),
	.t7_eiid       (t7_eiid       ),
	.t7_eiack      (t7_eiack      ),
	.t8_eip        (t8_eip        ),
	.t8_eiid       (t8_eiid       ),
	.t8_eiack      (t8_eiack      ),
	.t9_eip        (t9_eip        ),
	.t9_eiid       (t9_eiid       ),
	.t9_eiack      (t9_eiack      ),
	.t10_eip       (t10_eip       ),
	.t10_eiid      (t10_eiid      ),
	.t10_eiack     (t10_eiack     ),
	.t11_eip       (t11_eip       ),
	.t11_eiid      (t11_eiid      ),
	.t11_eiack     (t11_eiack     ),
	.t12_eip       (t12_eip       ),
	.t12_eiid      (t12_eiid      ),
	.t12_eiack     (t12_eiack     ),
	.t13_eip       (t13_eip       ),
	.t13_eiid      (t13_eiid      ),
	.t13_eiack     (t13_eiack     ),
	.t14_eip       (t14_eip       ),
	.t14_eiid      (t14_eiid      ),
	.t14_eiack     (t14_eiack     ),
	.t15_eip       (t15_eip       ),
	.t15_eiid      (t15_eiid      ),
	.t15_eiack     (t15_eiack     )
);

endmodule

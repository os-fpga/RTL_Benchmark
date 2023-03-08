// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary


module ae250_cpu_to_ahb (
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
	  hclk,
	  hprot,
	  hrdata,
	  hready,
	  hresetn,
	  hresp,
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
	  wvalid
);

parameter BIU_ADDR_WIDTH  = 32;
parameter BIU_DATA_WIDTH  = 32;
parameter BIU_ID_WIDTH  = 4;

input           [BIU_ADDR_WIDTH-1:0] araddr;
input                          [1:0] arburst;
input                          [3:0] arcache;
input             [BIU_ID_WIDTH-1:0] arid;
input                          [7:0] arlen;
input                                arlock;
input                          [2:0] arprot;
output                               arready;
input                          [2:0] arsize;
input                                arvalid;
input           [BIU_ADDR_WIDTH-1:0] awaddr;
input                          [1:0] awburst;
input                          [3:0] awcache;
input             [BIU_ID_WIDTH-1:0] awid;
input                          [7:0] awlen;
input                                awlock;
input                          [2:0] awprot;
output                               awready;
input                          [2:0] awsize;
input                                awvalid;
output            [BIU_ID_WIDTH-1:0] bid;
input                                bready;
output                         [1:0] bresp;
output                               bvalid;
output          [BIU_ADDR_WIDTH-1:0] haddr;
output                         [2:0] hburst;
input                                hclk;
output                         [3:0] hprot;
input           [BIU_DATA_WIDTH-1:0] hrdata;
input                                hready;
input                                hresetn;
input                          [1:0] hresp;
output                         [2:0] hsize;
output                         [1:0] htrans;
output          [BIU_DATA_WIDTH-1:0] hwdata;
output                               hwrite;
output          [BIU_DATA_WIDTH-1:0] rdata;
output            [BIU_ID_WIDTH-1:0] rid;
output                               rlast;
input                                rready;
output                         [1:0] rresp;
output                               rvalid;
input           [BIU_DATA_WIDTH-1:0] wdata;
input                                wlast;
output                               wready;
input       [(BIU_DATA_WIDTH/8)-1:0] wstrb;
input                                wvalid;



defparam atcaxi2ahb100.ADDR_WIDTH = BIU_ADDR_WIDTH;
defparam atcaxi2ahb100.DATA_WIDTH = BIU_DATA_WIDTH;
defparam atcaxi2ahb100.ID_WIDTH = BIU_ID_WIDTH;
atcaxi2ahb100 atcaxi2ahb100 (
	.haddr  (haddr   ),
	.htrans (htrans  ),
	.hready (hready  ),
	.hresp  (hresp[0]),
	.hwrite (hwrite  ),
	.hsize  (hsize   ),
	.hburst (hburst  ),
	.hprot  (hprot   ),
	.hwdata (hwdata  ),
	.hrdata (hrdata  ),
	.awaddr (awaddr  ),
	.awlen  (awlen   ),
	.awsize (awsize  ),
	.awburst(awburst ),
	.awlock (awlock  ),
	.awcache(awcache ),
	.awprot (awprot  ),
	.awid   (awid    ),
	.awvalid(awvalid ),
	.awready(awready ),
	.araddr (araddr  ),
	.arlen  (arlen   ),
	.arsize (arsize  ),
	.arburst(arburst ),
	.arlock (arlock  ),
	.arcache(arcache ),
	.arprot (arprot  ),
	.arid   (arid    ),
	.arvalid(arvalid ),
	.arready(arready ),
	.rid    (rid     ),
	.rdata  (rdata   ),
	.rresp  (rresp   ),
	.rlast  (rlast   ),
	.rvalid (rvalid  ),
	.rready (rready  ),
	.wdata  (wdata   ),
	.wstrb  (wstrb   ),
	.wlast  (wlast   ),
	.wvalid (wvalid  ),
	.wready (wready  ),
	.bid    (bid     ),
	.bresp  (bresp   ),
	.bvalid (bvalid  ),
	.bready (bready  ),
	.clk    (hclk    ),
	.resetn (hresetn )
);

endmodule

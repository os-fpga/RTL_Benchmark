// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary



module atcsizedn300 (
	  ds_bready,
	  ds_bresp,
	  ds_bvalid,
	  ds_rdata,
	  ds_rlast,
	  ds_rready,
	  ds_rresp,
	  ds_rvalid,
	  ds_wdata,
	  ds_wlast,
	  ds_wready,
	  ds_wstrb,
	  ds_wvalid,
	  us_bid,
	  us_bready,
	  us_bresp,
	  us_bvalid,
	  us_rdata,
	  us_rid,
	  us_rlast,
	  us_rready,
	  us_rresp,
	  us_rvalid,
	  us_wdata,
	  us_wlast,
	  us_wready,
	  us_wstrb,
	  us_wvalid,
	  ds_arready,
	  aclk,
	  aresetn,
	  ds_awready,
	  ds_araddr,
	  ds_arburst,
	  ds_arcache,
	  ds_arlen,
	  ds_arlock,
	  ds_arprot,
	  ds_arsize,
	  ds_arvalid,
	  us_araddr,
	  us_arburst,
	  us_arcache,
	  us_arid,
	  us_arlen,
	  us_arlock,
	  us_arprot,
	  us_arready,
	  us_arsize,
	  us_arvalid,
	  ds_awaddr,
	  ds_awburst,
	  ds_awcache,
	  ds_awlen,
	  ds_awlock,
	  ds_awprot,
	  ds_awsize,
	  ds_awvalid,
	  us_awaddr,
	  us_awburst,
	  us_awcache,
	  us_awid,
	  us_awlen,
	  us_awlock,
	  us_awprot,
	  us_awready,
	  us_awsize,
	  us_awvalid
);

parameter ID_WIDTH = 4;
parameter ADDR_WIDTH = 32;
parameter US_DATA_WIDTH = 128;
parameter DS_DATA_WIDTH = 32;

localparam PRODUCT_ID = 32'h00093004;

output                              ds_bready;
input                         [1:0] ds_bresp;
input                               ds_bvalid;
input         [(DS_DATA_WIDTH-1):0] ds_rdata;
input                               ds_rlast;
output                              ds_rready;
input                         [1:0] ds_rresp;
input                               ds_rvalid;
output        [(DS_DATA_WIDTH-1):0] ds_wdata;
output                              ds_wlast;
input                               ds_wready;
output      [(DS_DATA_WIDTH/8)-1:0] ds_wstrb;
output                              ds_wvalid;
output             [(ID_WIDTH-1):0] us_bid;
input                               us_bready;
output                        [1:0] us_bresp;
output                              us_bvalid;
output        [(US_DATA_WIDTH-1):0] us_rdata;
output             [(ID_WIDTH-1):0] us_rid;
output                              us_rlast;
input                               us_rready;
output                        [1:0] us_rresp;
output                              us_rvalid;
input         [(US_DATA_WIDTH-1):0] us_wdata;
input                               us_wlast;
output                              us_wready;
input       [(US_DATA_WIDTH/8)-1:0] us_wstrb;
input                               us_wvalid;
input                               ds_arready;
input                               aclk;
input                               aresetn;
input                               ds_awready;
output             [ADDR_WIDTH-1:0] ds_araddr;
output                        [1:0] ds_arburst;
output                        [3:0] ds_arcache;
output                        [7:0] ds_arlen;
output                              ds_arlock;
output                        [2:0] ds_arprot;
output                        [2:0] ds_arsize;
output                              ds_arvalid;
input            [(ADDR_WIDTH-1):0] us_araddr;
input                         [1:0] us_arburst;
input                         [3:0] us_arcache;
input              [(ID_WIDTH-1):0] us_arid;
input                         [7:0] us_arlen;
input                               us_arlock;
input                         [2:0] us_arprot;
output                              us_arready;
input                         [2:0] us_arsize;
input                               us_arvalid;
output             [ADDR_WIDTH-1:0] ds_awaddr;
output                        [1:0] ds_awburst;
output                        [3:0] ds_awcache;
output                        [7:0] ds_awlen;
output                              ds_awlock;
output                        [2:0] ds_awprot;
output                        [2:0] ds_awsize;
output                              ds_awvalid;
input            [(ADDR_WIDTH-1):0] us_awaddr;
input                         [1:0] us_awburst;
input                         [3:0] us_awcache;
input              [(ID_WIDTH-1):0] us_awid;
input                         [7:0] us_awlen;
input                               us_awlock;
input                         [2:0] us_awprot;
output                              us_awready;
input                         [2:0] us_awsize;
input                               us_awvalid;

wire                                rcmd_fifo_full;
wire                                wcmd_fifo_full;
wire               [(ID_WIDTH-1):0] us_rdata_id;
wire                          [2:0] us_rdata_size;
wire                                us_rlast_burst;
wire               [(ID_WIDTH-1):0] us_wdata_id;
wire                          [2:0] us_wdata_size;
wire                                us_wlast_burst;


atcsizedn300_addr_downsizer #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DS_DATA_WIDTH   (DS_DATA_WIDTH   ),
	.ID_WIDTH        (ID_WIDTH        ),
	.READ_CHANNEL    (1               ),
	.US_DATA_WIDTH   (US_DATA_WIDTH   )
) read_addr_downsizer (
	.aclk         (aclk          ),
	.aresetn      (aresetn       ),
	.us_arwid     (us_arid       ),
	.us_arwaddr   (us_araddr     ),
	.us_arwlen    (us_arlen      ),
	.us_arwsize   (us_arsize     ),
	.us_arwburst  (us_arburst    ),
	.us_arwlock   (us_arlock     ),
	.us_arwcache  (us_arcache    ),
	.us_arwprot   (us_arprot     ),
	.us_arwvalid  (us_arvalid    ),
	.us_arwready  (us_arready    ),
	.ds_arwaddr   (ds_araddr     ),
	.ds_arwlen    (ds_arlen      ),
	.ds_arwsize   (ds_arsize     ),
	.ds_arwburst  (ds_arburst    ),
	.ds_arwlock   (ds_arlock     ),
	.ds_arwcache  (ds_arcache    ),
	.ds_arwprot   (ds_arprot     ),
	.ds_arwvalid  (ds_arvalid    ),
	.ds_arwready  (ds_arready    ),
	.us_data_size (us_rdata_size ),
	.us_data_id   (us_rdata_id   ),
	.us_last_burst(us_rlast_burst),
	.cmd_fifo_full(rcmd_fifo_full)
);

atcsizedn300_addr_downsizer #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DS_DATA_WIDTH   (DS_DATA_WIDTH   ),
	.ID_WIDTH        (ID_WIDTH        ),
	.READ_CHANNEL    (0               ),
	.US_DATA_WIDTH   (US_DATA_WIDTH   )
) write_addr_downsizer (
	.aclk         (aclk          ),
	.aresetn      (aresetn       ),
	.us_arwid     (us_awid       ),
	.us_arwaddr   (us_awaddr     ),
	.us_arwlen    (us_awlen      ),
	.us_arwsize   (us_awsize     ),
	.us_arwburst  (us_awburst    ),
	.us_arwlock   (us_awlock     ),
	.us_arwcache  (us_awcache    ),
	.us_arwprot   (us_awprot     ),
	.us_arwvalid  (us_awvalid    ),
	.us_arwready  (us_awready    ),
	.ds_arwaddr   (ds_awaddr     ),
	.ds_arwlen    (ds_awlen      ),
	.ds_arwsize   (ds_awsize     ),
	.ds_arwburst  (ds_awburst    ),
	.ds_arwlock   (ds_awlock     ),
	.ds_arwcache  (ds_awcache    ),
	.ds_arwprot   (ds_awprot     ),
	.ds_arwvalid  (ds_awvalid    ),
	.ds_arwready  (ds_awready    ),
	.us_data_size (us_wdata_size ),
	.us_data_id   (us_wdata_id   ),
	.us_last_burst(us_wlast_burst),
	.cmd_fifo_full(wcmd_fifo_full)
);

atcsizedn300_data_downsizer #(
	.DS_DATA_WIDTH   (DS_DATA_WIDTH   ),
	.ID_WIDTH        (ID_WIDTH        ),
	.US_DATA_WIDTH   (US_DATA_WIDTH   )
) data_downsizer (
	.aclk          (aclk          ),
	.aresetn       (aresetn       ),
	.us_rid        (us_rid        ),
	.us_rresp      (us_rresp      ),
	.us_rlast      (us_rlast      ),
	.us_rvalid     (us_rvalid     ),
	.us_rdata      (us_rdata      ),
	.us_rready     (us_rready     ),
	.ds_rresp      (ds_rresp      ),
	.ds_rlast      (ds_rlast      ),
	.ds_rvalid     (ds_rvalid     ),
	.ds_rdata      (ds_rdata      ),
	.ds_rready     (ds_rready     ),
	.ds_arvalid    (ds_arvalid    ),
	.ds_arready    (ds_arready    ),
	.ds_arburst    (ds_arburst    ),
	.ds_arlen      (ds_arlen[3:0] ),
	.ds_araddr     (ds_araddr[4:0]),
	.us_rdata_size (us_rdata_size ),
	.us_rdata_id   (us_rdata_id   ),
	.us_rlast_burst(us_rlast_burst),
	.rcmd_fifo_full(rcmd_fifo_full),
	.us_wstrb      (us_wstrb      ),
	.us_wlast      (us_wlast      ),
	.us_wvalid     (us_wvalid     ),
	.us_wdata      (us_wdata      ),
	.us_wready     (us_wready     ),
	.ds_wstrb      (ds_wstrb      ),
	.ds_wlast      (ds_wlast      ),
	.ds_wvalid     (ds_wvalid     ),
	.ds_wdata      (ds_wdata      ),
	.ds_wready     (ds_wready     ),
	.ds_awaddr     (ds_awaddr[4:0]),
	.ds_awlen      (ds_awlen      ),
	.ds_awvalid    (ds_awvalid    ),
	.ds_awburst    (ds_awburst    ),
	.ds_awready    (ds_awready    ),
	.us_wdata_size (us_wdata_size ),
	.us_bid        (us_bid        ),
	.us_bresp      (us_bresp      ),
	.us_bvalid     (us_bvalid     ),
	.us_bready     (us_bready     ),
	.ds_bresp      (ds_bresp      ),
	.ds_bvalid     (ds_bvalid     ),
	.ds_bready     (ds_bready     ),
	.us_wdata_id   (us_wdata_id   ),
	.us_wlast_burst(us_wlast_burst),
	.wcmd_fifo_full(wcmd_fifo_full)
);

endmodule

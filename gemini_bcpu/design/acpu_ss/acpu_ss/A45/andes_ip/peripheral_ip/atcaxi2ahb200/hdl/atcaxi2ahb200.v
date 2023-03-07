// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary



module atcaxi2ahb200 (
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
	  hclk,
	  hresetn,
	  aclk,
	  aresetn,
	  haddr,
	  hburst,
	  hprot,
	  hrdata,
	  hready,
	  hresp,
	  hsize,
	  htrans,
	  hwdata,
	  hwrite
);

parameter ID_WIDTH = 4;
parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 32;
parameter CMD_FIFO_DEPTH = 4;
parameter RDATA_FIFO_DEPTH = 4;
parameter BRESP_FIFO_DEPTH = 4;
parameter WDATA_FIFO_DEPTH = 4;

localparam WSTRB_WIDTH = DATA_WIDTH/8;
localparam CMD_WIDTH   = 2+2+8+2+3+ID_WIDTH+ADDR_WIDTH;
localparam RDATA_WIDTH = 1+1+ID_WIDTH+DATA_WIDTH;
localparam WDATA_WIDTH = WSTRB_WIDTH+DATA_WIDTH;
localparam BRESP_WIDTH = 1+ID_WIDTH;
localparam PRODUCT_ID = 32'h00042002;

input           [ADDR_WIDTH-1:0] araddr;
input                      [1:0] arburst;
input                      [3:0] arcache;
input             [ID_WIDTH-1:0] arid;
input                      [7:0] arlen;
input                            arlock;
input                      [2:0] arprot;
output                           arready;
input                      [2:0] arsize;
input                            arvalid;
input           [ADDR_WIDTH-1:0] awaddr;
input                      [1:0] awburst;
input                      [3:0] awcache;
input             [ID_WIDTH-1:0] awid;
input                      [7:0] awlen;
input                            awlock;
input                      [2:0] awprot;
output                           awready;
input                      [2:0] awsize;
input                            awvalid;
output            [ID_WIDTH-1:0] bid;
input                            bready;
output                     [1:0] bresp;
output                           bvalid;
output          [DATA_WIDTH-1:0] rdata;
output            [ID_WIDTH-1:0] rid;
output                           rlast;
input                            rready;
output                     [1:0] rresp;
output                           rvalid;
input           [DATA_WIDTH-1:0] wdata;
input                            wlast;
output                           wready;
input       [(DATA_WIDTH/8)-1:0] wstrb;
input                            wvalid;
input                            hclk;
input                            hresetn;
input                            aclk;
input                            aresetn;
output        [(ADDR_WIDTH-1):0] haddr;
output                     [2:0] hburst;
output                     [3:0] hprot;
input         [(DATA_WIDTH-1):0] hrdata;
input                            hready;
input                            hresp;
output                     [2:0] hsize;
output                     [1:0] htrans;
output        [(DATA_WIDTH-1):0] hwdata;
output                           hwrite;

wire                             s0;
wire             [CMD_WIDTH-1:0] s1;
wire                             s2;
wire                             s3;
wire             [CMD_WIDTH-1:0] s4;
wire                             s5;
wire           [WDATA_WIDTH-1:0] s6;
wire                             s7;
wire                             s8;
wire                             brespq_almost_full;
wire                             s9;
wire                             brespq_full;
wire           [BRESP_WIDTH-1:0] s10;
wire           [BRESP_WIDTH-1:0] brespq_wdata;
wire                             brespq_wr;
wire                             rcmdq_rd;
wire           [RDATA_WIDTH-1:0] rdq_wdata;
wire                             rdq_wr;
wire                             wcmdq_rd;
wire                             wdq_rd;
wire                             s11;
wire                             s12;
wire                             rcmdq_empty;
wire                             s13;
wire             [CMD_WIDTH-1:0] rcmdq_rdata;
wire                             s14;
wire                             rdq_almost_full;
wire                             s15;
wire                             rdq_full;
wire           [RDATA_WIDTH-1:0] s16;
wire                             s17;
wire                             s18;
wire                             wcmdq_empty;
wire                             s19;
wire             [CMD_WIDTH-1:0] wcmdq_rdata;
wire                             s20;
wire                             s21;
wire                             wdq_empty;
wire                             s22;
wire           [WDATA_WIDTH-1:0] wdq_rdata;


assign s1[ADDR_WIDTH-1:0]                                  = araddr[ADDR_WIDTH-1:0];
assign s1[ID_WIDTH+ADDR_WIDTH-1  : ADDR_WIDTH]             = arid[ID_WIDTH-1:0];
assign s1[ID_WIDTH+ADDR_WIDTH+2  : ID_WIDTH+ADDR_WIDTH]    = arsize[2:0];
assign s1[ID_WIDTH+ADDR_WIDTH+4  : ID_WIDTH+ADDR_WIDTH+3]  = arcache[1:0];
assign s1[ID_WIDTH+ADDR_WIDTH+12 : ID_WIDTH+ADDR_WIDTH+5]  = arlen[7:0];
assign s1[ID_WIDTH+ADDR_WIDTH+14 : ID_WIDTH+ADDR_WIDTH+13] = arburst[1:0];
assign s1[ID_WIDTH+ADDR_WIDTH+16 : ID_WIDTH+ADDR_WIDTH+15] = {arprot[2],arprot[0]};
assign arready = ~s13;
assign s2 = arvalid & ~s13;
assign s4[ADDR_WIDTH-1:0]                                  = awaddr[ADDR_WIDTH-1:0];
assign s4[ID_WIDTH+ADDR_WIDTH-1  : ADDR_WIDTH]             = awid[ID_WIDTH-1:0];
assign s4[ID_WIDTH+ADDR_WIDTH+2  : ID_WIDTH+ADDR_WIDTH]    = awsize[2:0];
assign s4[ID_WIDTH+ADDR_WIDTH+4  : ID_WIDTH+ADDR_WIDTH+3]  = awcache[1:0];
assign s4[ID_WIDTH+ADDR_WIDTH+12 : ID_WIDTH+ADDR_WIDTH+5]  = awlen[7:0];
assign s4[ID_WIDTH+ADDR_WIDTH+14 : ID_WIDTH+ADDR_WIDTH+13] = awburst[1:0];
assign s4[ID_WIDTH+ADDR_WIDTH+16 : ID_WIDTH+ADDR_WIDTH+15] = {awprot[2],awprot[0]};
assign awready = ~s19;
assign s5 = awvalid & ~s19;
assign s6[DATA_WIDTH-1:0] = wdata[DATA_WIDTH-1:0];
assign s6[WSTRB_WIDTH+DATA_WIDTH-1:DATA_WIDTH] = wstrb[WSTRB_WIDTH-1:0];
assign s7 = wvalid & ~s22;
assign wready = ~s22;
assign rvalid = ~s15;
assign s3 = rready & ~s15;
assign rdata[DATA_WIDTH-1:0] = s16[DATA_WIDTH-1:0];
assign rlast = s16[DATA_WIDTH];
assign rresp = {s16[DATA_WIDTH+1],1'b0};
assign rid = s16[ID_WIDTH+DATA_WIDTH+1:DATA_WIDTH+2];
assign bvalid = ~s9;
assign s0 = bready & ~s9;
assign bresp = {s10[ID_WIDTH],1'b0};
assign bid = s10[ID_WIDTH-1:0];

fifo2ahb #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        )
) fifo2ahb (
	.haddr             (haddr             ),
	.htrans            (htrans            ),
	.hready            (hready            ),
	.hresp             (hresp             ),
	.hwrite            (hwrite            ),
	.hsize             (hsize             ),
	.hburst            (hburst            ),
	.hprot             (hprot             ),
	.hwdata            (hwdata            ),
	.hrdata            (hrdata            ),
	.rcmdq_rdata       (rcmdq_rdata       ),
	.rcmdq_empty       (rcmdq_empty       ),
	.rcmdq_rd          (rcmdq_rd          ),
	.wcmdq_rdata       (wcmdq_rdata       ),
	.wcmdq_empty       (wcmdq_empty       ),
	.wcmdq_rd          (wcmdq_rd          ),
	.wdq_rdata         (wdq_rdata         ),
	.wdq_empty         (wdq_empty         ),
	.wdq_rd            (wdq_rd            ),
	.rdq_wdata         (rdq_wdata         ),
	.rdq_wr            (rdq_wr            ),
	.rdq_almost_full   (rdq_almost_full   ),
	.rdq_full          (rdq_full          ),
	.brespq_wdata      (brespq_wdata      ),
	.brespq_wr         (brespq_wr         ),
	.brespq_almost_full(brespq_almost_full),
	.brespq_full       (brespq_full       ),
	.clk               (hclk              ),
	.resetn            (hresetn           )
);

nds_async_fifo_afe #(
	.DATA_WIDTH      (CMD_WIDTH       ),
	.FIFO_DEPTH      (CMD_FIFO_DEPTH  )
) rcmdq_fifo (
	.w_reset_n   (aresetn           ),
	.r_reset_n   (hresetn           ),
	.w_clk       (aclk              ),
	.r_clk       (hclk              ),
	.wr          (s2          ),
	.wr_data     (s1       ),
	.rd          (rcmdq_rd          ),
	.rd_data     (rcmdq_rdata       ),
	.empty       (rcmdq_empty       ),
	.full        (s13        ),
	.almost_empty(s11),
	.almost_full (s12 )
);

nds_async_fifo_afe #(
	.DATA_WIDTH      (CMD_WIDTH       ),
	.FIFO_DEPTH      (CMD_FIFO_DEPTH  )
) wcmdq_fifo (
	.w_reset_n   (aresetn           ),
	.r_reset_n   (hresetn           ),
	.w_clk       (aclk              ),
	.r_clk       (hclk              ),
	.wr          (s5          ),
	.wr_data     (s4       ),
	.rd          (wcmdq_rd          ),
	.rd_data     (wcmdq_rdata       ),
	.empty       (wcmdq_empty       ),
	.full        (s19        ),
	.almost_empty(s17),
	.almost_full (s18 )
);

nds_async_fifo_afe #(
	.DATA_WIDTH      (WDATA_WIDTH     ),
	.FIFO_DEPTH      (WDATA_FIFO_DEPTH)
) wdq_fifo (
	.w_reset_n   (aresetn         ),
	.r_reset_n   (hresetn         ),
	.w_clk       (aclk            ),
	.r_clk       (hclk            ),
	.wr          (s7          ),
	.wr_data     (s6       ),
	.rd          (wdq_rd          ),
	.rd_data     (wdq_rdata       ),
	.empty       (wdq_empty       ),
	.full        (s22        ),
	.almost_empty(s20),
	.almost_full (s21 )
);

nds_async_fifo_afe #(
	.ALMOST_FULL_THRESHOLD(2               ),
	.DATA_WIDTH      (RDATA_WIDTH     ),
	.FIFO_DEPTH      (RDATA_FIFO_DEPTH)
) rdq_fifo (
	.w_reset_n   (hresetn         ),
	.r_reset_n   (aresetn         ),
	.w_clk       (hclk            ),
	.r_clk       (aclk            ),
	.wr          (rdq_wr          ),
	.wr_data     (rdq_wdata       ),
	.rd          (s3          ),
	.rd_data     (s16       ),
	.empty       (s15       ),
	.full        (rdq_full        ),
	.almost_empty(s14),
	.almost_full (rdq_almost_full )
);

nds_async_fifo_afe #(
	.ALMOST_FULL_THRESHOLD(2               ),
	.DATA_WIDTH      (BRESP_WIDTH     ),
	.FIFO_DEPTH      (BRESP_FIFO_DEPTH)
) brespq_fifo (
	.w_reset_n   (hresetn            ),
	.r_reset_n   (aresetn            ),
	.w_clk       (hclk               ),
	.r_clk       (aclk               ),
	.wr          (brespq_wr          ),
	.wr_data     (brespq_wdata       ),
	.rd          (s0          ),
	.rd_data     (s10       ),
	.empty       (s9       ),
	.full        (brespq_full        ),
	.almost_empty(s8),
	.almost_full (brespq_almost_full )
);

endmodule

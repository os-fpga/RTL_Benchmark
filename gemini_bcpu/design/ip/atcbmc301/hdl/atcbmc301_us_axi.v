// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc301_config.vh"
`include "atcbmc301_const.vh"


module atcbmc301_us_axi (
`ifdef ATCBMC301_SLV1_SUPPORT
	  slv1_ar_mid,
	  slv1_arready,
	  slv1_arvalid,
	  slv1_addr_mask,
	  slv1_masked_base_addr,
	  slv1_connect,
	  slv1_aw_mid,
	  slv1_awready,
	  slv1_awvalid,
	  slv1_read_data,
	  slv1_rid,
	  slv1_rvalid,
	  slv1_wmid,
	  slv1_wready,
	  slv1_bid,
	  slv1_bresp,
	  slv1_bvalid,
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
	  slv2_ar_mid,
	  slv2_arready,
	  slv2_arvalid,
	  slv2_addr_mask,
	  slv2_masked_base_addr,
	  slv2_connect,
	  slv2_aw_mid,
	  slv2_awready,
	  slv2_awvalid,
	  slv2_read_data,
	  slv2_rid,
	  slv2_rvalid,
	  slv2_wmid,
	  slv2_wready,
	  slv2_bid,
	  slv2_bresp,
	  slv2_bvalid,
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
	  slv3_ar_mid,
	  slv3_arready,
	  slv3_arvalid,
	  slv3_addr_mask,
	  slv3_masked_base_addr,
	  slv3_connect,
	  slv3_aw_mid,
	  slv3_awready,
	  slv3_awvalid,
	  slv3_read_data,
	  slv3_rid,
	  slv3_rvalid,
	  slv3_wmid,
	  slv3_wready,
	  slv3_bid,
	  slv3_bresp,
	  slv3_bvalid,
`endif
	  us_rdata,
	  us_rlast,
	  us_rresp,
	  mst_araddr,
	  mst_arburst,
	  mst_arcache,
	  mst_arid,
	  mst_arlen,
	  mst_arlock,
	  mst_arprot,
	  mst_arsize,
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
	  aclk,
	  aresetn,
	  self_id,
	  us_rready,
	  mst_awaddr,
	  mst_awburst,
	  mst_awcache,
	  mst_awid,
	  mst_awlen,
	  mst_awlock,
	  mst_awprot,
	  mst_awsize,
	  us_awaddr,
	  us_awburst,
	  us_awcache,
	  us_awid,
	  us_awlen,
	  us_awlock,
	  us_awprot,
	  us_awready,
	  us_awsize,
	  us_awvalid,
	  us_bready,
	  mst_rready,
	  mst_rsid,
	  us_rid,
	  us_rvalid,
	  mst_wdata,
	  mst_wlast,
	  mst_wsid,
	  mst_wstrb,
	  mst_wvalid,
	  us_wdata,
	  us_wlast,
	  us_wready,
	  us_wstrb,
	  us_wvalid,
	  mst_bready,
	  mst_bsid,
	  us_bid,
	  us_bresp,
	  us_bvalid
);

parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 64;
parameter ID_WIDTH = 4;
parameter OUTSTANDING_DEPTH = 4;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam ID_MSB = ID_WIDTH - 1;

`ifdef ATCBMC301_SLV1_SUPPORT
input                      [3:0] slv1_ar_mid;
input                            slv1_arready;
output                           slv1_arvalid;
input                     [64:0] slv1_addr_mask;
input                     [64:0] slv1_masked_base_addr;
input                            slv1_connect;
input                      [3:0] slv1_aw_mid;
input                            slv1_awready;
output                           slv1_awvalid;
input           [(DATA_MSB+3):0] slv1_read_data;
input               [ID_MSB+4:0] slv1_rid;
input                            slv1_rvalid;
input                      [3:0] slv1_wmid;
input                            slv1_wready;
input               [ID_MSB+4:0] slv1_bid;
input                      [1:0] slv1_bresp;
input                            slv1_bvalid;
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
input                      [3:0] slv2_ar_mid;
input                            slv2_arready;
output                           slv2_arvalid;
input                     [64:0] slv2_addr_mask;
input                     [64:0] slv2_masked_base_addr;
input                            slv2_connect;
input                      [3:0] slv2_aw_mid;
input                            slv2_awready;
output                           slv2_awvalid;
input           [(DATA_MSB+3):0] slv2_read_data;
input               [ID_MSB+4:0] slv2_rid;
input                            slv2_rvalid;
input                      [3:0] slv2_wmid;
input                            slv2_wready;
input               [ID_MSB+4:0] slv2_bid;
input                      [1:0] slv2_bresp;
input                            slv2_bvalid;
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
input                      [3:0] slv3_ar_mid;
input                            slv3_arready;
output                           slv3_arvalid;
input                     [64:0] slv3_addr_mask;
input                     [64:0] slv3_masked_base_addr;
input                            slv3_connect;
input                      [3:0] slv3_aw_mid;
input                            slv3_awready;
output                           slv3_awvalid;
input           [(DATA_MSB+3):0] slv3_read_data;
input               [ID_MSB+4:0] slv3_rid;
input                            slv3_rvalid;
input                      [3:0] slv3_wmid;
input                            slv3_wready;
input               [ID_MSB+4:0] slv3_bid;
input                      [1:0] slv3_bresp;
input                            slv3_bvalid;
`endif
output              [DATA_MSB:0] us_rdata;
output                           us_rlast;
output                     [1:0] us_rresp;
output              [ADDR_MSB:0] mst_araddr;
output                     [1:0] mst_arburst;
output                     [3:0] mst_arcache;
output                [ID_MSB:0] mst_arid;
output                     [7:0] mst_arlen;
output                           mst_arlock;
output                     [2:0] mst_arprot;
output                     [2:0] mst_arsize;
input               [ADDR_MSB:0] us_araddr;
input                      [1:0] us_arburst;
input                      [3:0] us_arcache;
input                 [ID_MSB:0] us_arid;
input                      [7:0] us_arlen;
input                            us_arlock;
input                      [2:0] us_arprot;
output                           us_arready;
input                      [2:0] us_arsize;
input                            us_arvalid;
input                            aclk;
input                            aresetn;
input                      [3:0] self_id;
input                            us_rready;
output              [ADDR_MSB:0] mst_awaddr;
output                     [1:0] mst_awburst;
output                     [3:0] mst_awcache;
output                [ID_MSB:0] mst_awid;
output                     [7:0] mst_awlen;
output                           mst_awlock;
output                     [2:0] mst_awprot;
output                     [2:0] mst_awsize;
input               [ADDR_MSB:0] us_awaddr;
input                      [1:0] us_awburst;
input                      [3:0] us_awcache;
input                 [ID_MSB:0] us_awid;
input                      [7:0] us_awlen;
input                            us_awlock;
input                      [2:0] us_awprot;
output                           us_awready;
input                      [2:0] us_awsize;
input                            us_awvalid;
input                            us_bready;
output                           mst_rready;
output                     [4:0] mst_rsid;
output                [ID_MSB:0] us_rid;
output                           us_rvalid;
output              [DATA_MSB:0] mst_wdata;
output                           mst_wlast;
output                     [4:0] mst_wsid;
output      [(DATA_WIDTH/8)-1:0] mst_wstrb;
output                           mst_wvalid;
input               [DATA_MSB:0] us_wdata;
input                            us_wlast;
output                           us_wready;
input       [(DATA_WIDTH/8)-1:0] us_wstrb;
input                            us_wvalid;
output                           mst_bready;
output                     [4:0] mst_bsid;
output                [ID_MSB:0] us_bid;
output                     [1:0] us_bresp;
output                           us_bvalid;

wire                             ar_outstanding_en;
wire                       [4:0] ar_outstanding_id;
wire            [(DATA_MSB+3):0] dec_err_rd_resp_data;
wire                  [ID_MSB:0] dec_err_rid;
wire                             dec_err_rvalid;
wire                  [ID_MSB:0] locking_arid;
wire                  [ID_MSB:0] master_arid;
wire                             master_arlock;
wire                             master_arvalid;
wire                             mst_arlocking;
wire                             aw_addr_outstanding_en;
wire                       [4:0] aw_outstanding_id;
wire                  [ID_MSB:0] dec_err_bid;
wire                       [1:0] dec_err_bresp;
wire                             dec_err_bvalid;
wire                             dec_err_wready;
wire                  [ID_MSB:0] locking_awid;
wire                             mst_awlocking;
wire                             ar_outstanding_idle;
wire                             ar_outstanding_ready;
wire                             dec_err_rready;
wire            [(DATA_MSB+3):0] s0;
wire                             aw_outstanding_ready;
wire                             dec_err_wlast;
wire                             dec_err_wvalid;
wire                             resp_outstanding_en;
wire                             wd_outstanding_idle;
wire                             br_outstanding_idle;
wire                             dec_err_bready;
wire                             outstanding_resp_ready;

assign us_rdata = s0[DATA_MSB:0];
assign us_rlast = s0[(DATA_MSB+1)];
assign us_rresp = s0[(DATA_MSB+3):(DATA_MSB+2)];

atcbmc301_us_write_addr_ctrl #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTAND_ID_WIDTH(5               ),
	.RESP_INORDER_ONLY(1               )
) us_aw_addr (
	.self_id               (self_id               ),
`ifdef ATCBMC301_SLV1_SUPPORT
	.slv1_aw_mid           (slv1_aw_mid           ),
	.slv1_awready          (slv1_awready          ),
	.slv1_masked_base_addr (slv1_masked_base_addr ),
	.slv1_addr_mask        (slv1_addr_mask        ),
	.slv1_awvalid          (slv1_awvalid          ),
	.slv1_connect          (slv1_connect          ),
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
	.slv2_aw_mid           (slv2_aw_mid           ),
	.slv2_awready          (slv2_awready          ),
	.slv2_masked_base_addr (slv2_masked_base_addr ),
	.slv2_addr_mask        (slv2_addr_mask        ),
	.slv2_awvalid          (slv2_awvalid          ),
	.slv2_connect          (slv2_connect          ),
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
	.slv3_aw_mid           (slv3_aw_mid           ),
	.slv3_awready          (slv3_awready          ),
	.slv3_masked_base_addr (slv3_masked_base_addr ),
	.slv3_addr_mask        (slv3_addr_mask        ),
	.slv3_awvalid          (slv3_awvalid          ),
	.slv3_connect          (slv3_connect          ),
`endif
	.us_awaddr             (us_awaddr             ),
	.us_awlen              (us_awlen              ),
	.us_awsize             (us_awsize             ),
	.us_awburst            (us_awburst            ),
	.us_awlock             (us_awlock             ),
	.us_awcache            (us_awcache            ),
	.us_awprot             (us_awprot             ),
	.us_awid               (us_awid               ),
	.us_awvalid            (us_awvalid            ),
	.us_awready            (us_awready            ),
	.mst_awaddr            (mst_awaddr            ),
	.mst_awlen             (mst_awlen             ),
	.mst_awsize            (mst_awsize            ),
	.mst_awburst           (mst_awburst           ),
	.mst_awlock            (mst_awlock            ),
	.mst_awcache           (mst_awcache           ),
	.mst_awprot            (mst_awprot            ),
	.mst_awid              (mst_awid              ),
	.dec_err_wready        (dec_err_wready        ),
	.dec_err_bvalid        (dec_err_bvalid        ),
	.dec_err_wvalid        (dec_err_wvalid        ),
	.dec_err_wlast         (dec_err_wlast         ),
	.dec_err_bready        (dec_err_bready        ),
	.aw_outstanding_id     (aw_outstanding_id     ),
	.dec_err_bresp         (dec_err_bresp         ),
	.dec_err_bid           (dec_err_bid           ),
	.aw_addr_outstanding_en(aw_addr_outstanding_en),
	.aw_outstanding_ready  (aw_outstanding_ready  ),
	.wd_outstanding_idle   (wd_outstanding_idle   ),
	.br_outstanding_idle   (br_outstanding_idle   ),
	.master_arlock         (master_arlock         ),
	.master_arvalid        (master_arvalid        ),
	.master_arid           (master_arid           ),
	.mst_arlocking         (mst_arlocking         ),
	.locking_arid          (locking_arid          ),
	.us_bid                (us_bid                ),
	.us_bvalid             (us_bvalid             ),
	.us_bready             (us_bready             ),
	.mst_awlocking         (mst_awlocking         ),
	.locking_awid          (locking_awid          ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               )
);

atcbmc301_us_wdata_ctrl #(
	.DATA_WIDTH      (DATA_WIDTH      ),
	.OUTSTANDING_DEPTH(OUTSTANDING_DEPTH),
	.OUTSTAND_ID_WIDTH(5               )
) us_wr_data (
	.self_id               (self_id               ),
`ifdef ATCBMC301_SLV1_SUPPORT
	.slv1_wmid             (slv1_wmid             ),
	.slv1_wready           (slv1_wready           ),
	.slv1_connect          (slv1_connect          ),
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
	.slv2_wmid             (slv2_wmid             ),
	.slv2_wready           (slv2_wready           ),
	.slv2_connect          (slv2_connect          ),
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
	.slv3_wmid             (slv3_wmid             ),
	.slv3_wready           (slv3_wready           ),
	.slv3_connect          (slv3_connect          ),
`endif
	.us_wdata              (us_wdata              ),
	.us_wlast              (us_wlast              ),
	.us_wstrb              (us_wstrb              ),
	.us_wvalid             (us_wvalid             ),
	.us_wready             (us_wready             ),
	.aw_outstanding_id     (aw_outstanding_id     ),
	.aw_addr_outstanding_en(aw_addr_outstanding_en),
	.aw_outstanding_ready  (aw_outstanding_ready  ),
	.wd_outstanding_idle   (wd_outstanding_idle   ),
	.resp_outstanding_en   (resp_outstanding_en   ),
	.outstanding_resp_ready(outstanding_resp_ready),
	.dec_err_wready        (dec_err_wready        ),
	.dec_err_wvalid        (dec_err_wvalid        ),
	.dec_err_wlast         (dec_err_wlast         ),
	.mst_wsid              (mst_wsid              ),
	.mst_wvalid            (mst_wvalid            ),
	.mst_wdata             (mst_wdata             ),
	.mst_wlast             (mst_wlast             ),
	.mst_wstrb             (mst_wstrb             ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               )
);

atcbmc301_us_resp_ctrl #(
	.BRESP_CHANNEL   (1               ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTANDING_DEPTH(OUTSTANDING_DEPTH),
	.OUTSTAND_ID_WIDTH(5               ),
	.RESP_DATA_WIDTH (2               ),
	.RESP_INORDER_ONLY(0               )
) us_wr_resp (
	.self_id           (self_id               ),
`ifdef ATCBMC301_SLV1_SUPPORT
	.slv1_resp_data    (slv1_bresp            ),
	.slv1_resp_id      (slv1_bid              ),
	.slv1_resp_valid   (slv1_bvalid           ),
	.slv1_connect      (slv1_connect          ),
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
	.slv2_resp_data    (slv2_bresp            ),
	.slv2_resp_id      (slv2_bid              ),
	.slv2_resp_valid   (slv2_bvalid           ),
	.slv2_connect      (slv2_connect          ),
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
	.slv3_resp_data    (slv3_bresp            ),
	.slv3_resp_id      (slv3_bid              ),
	.slv3_resp_valid   (slv3_bvalid           ),
	.slv3_connect      (slv3_connect          ),
`endif
	.mst_resp_slave_id (mst_bsid              ),
	.mst_resp_ready    (mst_bready            ),
	.dec_err_resp_id   (dec_err_bid           ),
	.dec_err_resp_data (dec_err_bresp         ),
	.dec_err_resp_valid(dec_err_bvalid        ),
	.dec_err_resp_ready(dec_err_bready        ),
	.outstanding_id    (mst_wsid              ),
	.outstanding_en    (resp_outstanding_en   ),
	.outstanding_ready (outstanding_resp_ready),
	.outstanding_idle  (br_outstanding_idle   ),
	.resp_id           (us_bid                ),
	.resp_data         (us_bresp              ),
	.resp_valid        (us_bvalid             ),
	.resp_ready        (us_bready             ),
	.aclk              (aclk                  ),
	.aresetn           (aresetn               )
);

atcbmc301_us_read_addr_ctrl #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTAND_ID_WIDTH(5               ),
	.RESP_INORDER_ONLY(1               )
) us_ar_addr (
	.self_id               (self_id               ),
`ifdef ATCBMC301_SLV1_SUPPORT
	.slv1_ar_mid           (slv1_ar_mid           ),
	.slv1_arready          (slv1_arready          ),
	.slv1_masked_base_addr (slv1_masked_base_addr ),
	.slv1_addr_mask        (slv1_addr_mask        ),
	.slv1_arvalid          (slv1_arvalid          ),
	.slv1_connect          (slv1_connect          ),
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
	.slv2_ar_mid           (slv2_ar_mid           ),
	.slv2_arready          (slv2_arready          ),
	.slv2_masked_base_addr (slv2_masked_base_addr ),
	.slv2_addr_mask        (slv2_addr_mask        ),
	.slv2_arvalid          (slv2_arvalid          ),
	.slv2_connect          (slv2_connect          ),
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
	.slv3_ar_mid           (slv3_ar_mid           ),
	.slv3_arready          (slv3_arready          ),
	.slv3_masked_base_addr (slv3_masked_base_addr ),
	.slv3_addr_mask        (slv3_addr_mask        ),
	.slv3_arvalid          (slv3_arvalid          ),
	.slv3_connect          (slv3_connect          ),
`endif
	.us_araddr             (us_araddr             ),
	.us_arlen              (us_arlen              ),
	.us_arsize             (us_arsize             ),
	.us_arburst            (us_arburst            ),
	.us_arlock             (us_arlock             ),
	.us_arcache            (us_arcache            ),
	.us_arprot             (us_arprot             ),
	.us_arid               (us_arid               ),
	.us_arvalid            (us_arvalid            ),
	.us_arready            (us_arready            ),
	.mst_araddr            (mst_araddr            ),
	.mst_arlen             (mst_arlen             ),
	.mst_arsize            (mst_arsize            ),
	.mst_arburst           (mst_arburst           ),
	.mst_arlock            (mst_arlock            ),
	.mst_arcache           (mst_arcache           ),
	.mst_arprot            (mst_arprot            ),
	.mst_arid              (mst_arid              ),
	.dec_err_rvalid        (dec_err_rvalid        ),
	.us_rid                (us_rid                ),
	.us_rlast              (us_rlast              ),
	.us_rready             (us_rready             ),
	.us_rvalid             (us_rvalid             ),
	.master_arlock         (master_arlock         ),
	.master_arvalid        (master_arvalid        ),
	.master_arid           (master_arid           ),
	.mst_arlocking         (mst_arlocking         ),
	.locking_arid          (locking_arid          ),
	.mst_awlocking         (mst_awlocking         ),
	.locking_awid          (locking_awid          ),
	.dec_err_rready        (dec_err_rready        ),
	.dec_err_rd_resp_data  (dec_err_rd_resp_data  ),
	.dec_err_rid           (dec_err_rid           ),
	.ar_outstanding_en     (ar_outstanding_en     ),
	.ar_outstanding_id     (ar_outstanding_id     ),
	.ar_outstanding_ready  (ar_outstanding_ready  ),
	.ar_outstanding_idle   (ar_outstanding_idle   ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               )
);

atcbmc301_us_resp_ctrl #(
	.BRESP_CHANNEL   (0               ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTANDING_DEPTH(OUTSTANDING_DEPTH),
	.OUTSTAND_ID_WIDTH(5               ),
	.RESP_DATA_WIDTH (DATA_WIDTH+3    ),
	.RESP_INORDER_ONLY(0               )
) us_rd_data (
	.self_id           (self_id             ),
`ifdef ATCBMC301_SLV1_SUPPORT
	.slv1_resp_data    (slv1_read_data      ),
	.slv1_resp_id      (slv1_rid            ),
	.slv1_resp_valid   (slv1_rvalid         ),
	.slv1_connect      (slv1_connect        ),
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
	.slv2_resp_data    (slv2_read_data      ),
	.slv2_resp_id      (slv2_rid            ),
	.slv2_resp_valid   (slv2_rvalid         ),
	.slv2_connect      (slv2_connect        ),
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
	.slv3_resp_data    (slv3_read_data      ),
	.slv3_resp_id      (slv3_rid            ),
	.slv3_resp_valid   (slv3_rvalid         ),
	.slv3_connect      (slv3_connect        ),
`endif
	.mst_resp_slave_id (mst_rsid            ),
	.mst_resp_ready    (mst_rready          ),
	.dec_err_resp_id   (dec_err_rid         ),
	.dec_err_resp_data (dec_err_rd_resp_data),
	.dec_err_resp_valid(dec_err_rvalid      ),
	.dec_err_resp_ready(dec_err_rready      ),
	.outstanding_id    (ar_outstanding_id   ),
	.outstanding_en    (ar_outstanding_en   ),
	.outstanding_ready (ar_outstanding_ready),
	.outstanding_idle  (ar_outstanding_idle ),
	.resp_id           (us_rid              ),
	.resp_data         (s0        ),
	.resp_valid        (us_rvalid           ),
	.resp_ready        (us_rready           ),
	.aclk              (aclk                ),
	.aresetn           (aresetn             )
);

endmodule

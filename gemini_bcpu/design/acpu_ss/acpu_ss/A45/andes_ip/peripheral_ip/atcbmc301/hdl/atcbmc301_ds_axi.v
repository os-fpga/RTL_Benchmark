// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc301_config.vh"
`include "atcbmc301_const.vh"


module atcbmc301_ds_axi (
`ifdef ATCBMC301_MST0_SUPPORT
	  mst0_araddr,
	  mst0_arburst,
	  mst0_arcache,
	  mst0_arid,
	  mst0_arlen,
	  mst0_arlock,
	  mst0_arprot,
	  mst0_arsize,
	  mst0_arvalid,
	  mst0_connect,
	  mst0_awaddr,
	  mst0_awburst,
	  mst0_awcache,
	  mst0_awid,
	  mst0_awlen,
	  mst0_awlock,
	  mst0_awprot,
	  mst0_awsize,
	  mst0_awvalid,
	  mst0_rready,
	  mst0_rsid,
	  mst0_bready,
	  mst0_bsid,
	  mst0_wdata,
	  mst0_wlast,
	  mst0_wsid,
	  mst0_wstrb,
	  mst0_wvalid,
`endif
`ifdef ATCBMC301_MST1_SUPPORT
	  mst1_araddr,
	  mst1_arburst,
	  mst1_arcache,
	  mst1_arid,
	  mst1_arlen,
	  mst1_arlock,
	  mst1_arprot,
	  mst1_arsize,
	  mst1_arvalid,
	  mst1_connect,
	  mst1_awaddr,
	  mst1_awburst,
	  mst1_awcache,
	  mst1_awid,
	  mst1_awlen,
	  mst1_awlock,
	  mst1_awprot,
	  mst1_awsize,
	  mst1_awvalid,
	  mst1_rready,
	  mst1_rsid,
	  mst1_bready,
	  mst1_bsid,
	  mst1_wdata,
	  mst1_wlast,
	  mst1_wsid,
	  mst1_wstrb,
	  mst1_wvalid,
`endif
	  ds_araddr,
	  ds_arburst,
	  ds_arcache,
	  ds_arid,
	  ds_arlen,
	  ds_arlock,
	  ds_arprot,
	  ds_arready,
	  ds_arsize,
	  ds_arvalid,
	  slv_ar_mid,
	  slv_arready,
	  reg_mst0_high_priority,
	  reg_priority_reload,
	  aclk,
	  aresetn,
	  ds_awaddr,
	  ds_awburst,
	  ds_awcache,
	  ds_awid,
	  ds_awlen,
	  ds_awlock,
	  ds_awprot,
	  ds_awready,
	  ds_awsize,
	  ds_awvalid,
	  slv_aw_mid,
	  slv_awready,
	  ds_rdata,
	  ds_rid,
	  ds_rlast,
	  ds_rready,
	  ds_rresp,
	  ds_rvalid,
	  slv_read_data,
	  slv_rid,
	  slv_rvalid,
	  self_id,
	  ds_bid,
	  ds_bready,
	  ds_bresp,
	  ds_bvalid,
	  ds_wdata,
	  ds_wlast,
	  ds_wready,
	  ds_wstrb,
	  ds_wvalid,
	  slv_bid,
	  slv_bresp,
	  slv_bvalid,
	  slv_wmid,
	  slv_wready
);

parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 64;
parameter ID_WIDTH = 4;
parameter SLAVE_FIFO_DEPTH = 4;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam ID_MSB = ID_WIDTH - 1;

`ifdef ATCBMC301_MST0_SUPPORT
input               [ADDR_MSB:0] mst0_araddr;
input                      [1:0] mst0_arburst;
input                      [3:0] mst0_arcache;
input                 [ID_MSB:0] mst0_arid;
input                      [7:0] mst0_arlen;
input                            mst0_arlock;
input                      [2:0] mst0_arprot;
input                      [2:0] mst0_arsize;
input                            mst0_arvalid;
input                            mst0_connect;
input               [ADDR_MSB:0] mst0_awaddr;
input                      [1:0] mst0_awburst;
input                      [3:0] mst0_awcache;
input                 [ID_MSB:0] mst0_awid;
input                      [7:0] mst0_awlen;
input                            mst0_awlock;
input                      [2:0] mst0_awprot;
input                      [2:0] mst0_awsize;
input                            mst0_awvalid;
input                            mst0_rready;
input                      [4:0] mst0_rsid;
input                            mst0_bready;
input                      [4:0] mst0_bsid;
input               [DATA_MSB:0] mst0_wdata;
input                            mst0_wlast;
input                      [4:0] mst0_wsid;
input       [(DATA_WIDTH/8)-1:0] mst0_wstrb;
input                            mst0_wvalid;
`endif
`ifdef ATCBMC301_MST1_SUPPORT
input               [ADDR_MSB:0] mst1_araddr;
input                      [1:0] mst1_arburst;
input                      [3:0] mst1_arcache;
input                 [ID_MSB:0] mst1_arid;
input                      [7:0] mst1_arlen;
input                            mst1_arlock;
input                      [2:0] mst1_arprot;
input                      [2:0] mst1_arsize;
input                            mst1_arvalid;
input                            mst1_connect;
input               [ADDR_MSB:0] mst1_awaddr;
input                      [1:0] mst1_awburst;
input                      [3:0] mst1_awcache;
input                 [ID_MSB:0] mst1_awid;
input                      [7:0] mst1_awlen;
input                            mst1_awlock;
input                      [2:0] mst1_awprot;
input                      [2:0] mst1_awsize;
input                            mst1_awvalid;
input                            mst1_rready;
input                      [4:0] mst1_rsid;
input                            mst1_bready;
input                      [4:0] mst1_bsid;
input               [DATA_MSB:0] mst1_wdata;
input                            mst1_wlast;
input                      [4:0] mst1_wsid;
input       [(DATA_WIDTH/8)-1:0] mst1_wstrb;
input                            mst1_wvalid;
`endif
output              [ADDR_MSB:0] ds_araddr;
output                     [1:0] ds_arburst;
output                     [3:0] ds_arcache;
output            [(ID_MSB+4):0] ds_arid;
output                     [7:0] ds_arlen;
output                           ds_arlock;
output                     [2:0] ds_arprot;
input                            ds_arready;
output                     [2:0] ds_arsize;
output                           ds_arvalid;
output                     [3:0] slv_ar_mid;
output                           slv_arready;
input                            reg_mst0_high_priority;
input                     [15:0] reg_priority_reload;
input                            aclk;
input                            aresetn;
output              [ADDR_MSB:0] ds_awaddr;
output                     [1:0] ds_awburst;
output                     [3:0] ds_awcache;
output            [(ID_MSB+4):0] ds_awid;
output                     [7:0] ds_awlen;
output                           ds_awlock;
output                     [2:0] ds_awprot;
input                            ds_awready;
output                     [2:0] ds_awsize;
output                           ds_awvalid;
output                     [3:0] slv_aw_mid;
output                           slv_awready;
input               [DATA_MSB:0] ds_rdata;
input               [ID_MSB+4:0] ds_rid;
input                            ds_rlast;
output                           ds_rready;
input                      [1:0] ds_rresp;
input                            ds_rvalid;
output            [DATA_MSB+3:0] slv_read_data;
output              [ID_MSB+4:0] slv_rid;
output                           slv_rvalid;
input                      [4:0] self_id;
input               [ID_MSB+4:0] ds_bid;
output                           ds_bready;
input                      [1:0] ds_bresp;
input                            ds_bvalid;
output              [DATA_MSB:0] ds_wdata;
output                           ds_wlast;
input                            ds_wready;
output      [(DATA_WIDTH/8)-1:0] ds_wstrb;
output                           ds_wvalid;
output              [ID_MSB+4:0] slv_bid;
output                     [1:0] slv_bresp;
output                           slv_bvalid;
output                     [3:0] slv_wmid;
output                           slv_wready;

wire                             s0;
wire                             s1;
wire                             s2;
wire                             s3;


atcbmc301_ds_addr_ctrl #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        )
) ds_aw_addr (
`ifdef ATCBMC301_MST0_SUPPORT
	.mst0_addr             (mst0_awaddr           ),
	.mst0_len              (mst0_awlen            ),
	.mst0_size             (mst0_awsize           ),
	.mst0_burst            (mst0_awburst          ),
	.mst0_lock             (mst0_awlock           ),
	.mst0_cache            (mst0_awcache          ),
	.mst0_prot             (mst0_awprot           ),
	.mst0_aid              (mst0_awid             ),
	.mst0_avalid           (mst0_awvalid          ),
	.mst0_connect          (mst0_connect          ),
`endif
`ifdef ATCBMC301_MST1_SUPPORT
	.mst1_addr             (mst1_awaddr           ),
	.mst1_len              (mst1_awlen            ),
	.mst1_size             (mst1_awsize           ),
	.mst1_burst            (mst1_awburst          ),
	.mst1_lock             (mst1_awlock           ),
	.mst1_cache            (mst1_awcache          ),
	.mst1_prot             (mst1_awprot           ),
	.mst1_aid              (mst1_awid             ),
	.mst1_avalid           (mst1_awvalid          ),
	.mst1_connect          (mst1_connect          ),
`endif
	.addr_outstanding_en   (s1),
	.slv_aready            (slv_awready           ),
	.arb_mid               (slv_aw_mid            ),
	.outstanding_ready     (s3  ),
	.addr                  (ds_awaddr             ),
	.len                   (ds_awlen              ),
	.size                  (ds_awsize             ),
	.burst                 (ds_awburst            ),
	.lock                  (ds_awlock             ),
	.cache                 (ds_awcache            ),
	.prot                  (ds_awprot             ),
	.aid                   (ds_awid               ),
	.avalid                (ds_awvalid            ),
	.aready                (ds_awready            ),
	.reg_mst0_high_priority(reg_mst0_high_priority),
	.reg_priority_reload   (reg_priority_reload   ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               )
);

atcbmc301_ds_wdata_bresp_ctrl #(
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTANDING_DEPTH(SLAVE_FIFO_DEPTH)
) ds_wdata_bresp (
	.self_id            (self_id               ),
`ifdef ATCBMC301_MST0_SUPPORT
	.mst0_wvalid        (mst0_wvalid           ),
	.mst0_wlast         (mst0_wlast            ),
	.mst0_wdata         (mst0_wdata            ),
	.mst0_wstrb         (mst0_wstrb            ),
	.mst0_wsid          (mst0_wsid             ),
	.mst0_bready        (mst0_bready           ),
	.mst0_bsid          (mst0_bsid             ),
	.mst0_connect       (mst0_connect          ),
`endif
`ifdef ATCBMC301_MST1_SUPPORT
	.mst1_wvalid        (mst1_wvalid           ),
	.mst1_wlast         (mst1_wlast            ),
	.mst1_wdata         (mst1_wdata            ),
	.mst1_wstrb         (mst1_wstrb            ),
	.mst1_wsid          (mst1_wsid             ),
	.mst1_bready        (mst1_bready           ),
	.mst1_bsid          (mst1_bsid             ),
	.mst1_connect       (mst1_connect          ),
`endif
	.ds_wdata           (ds_wdata              ),
	.ds_wlast           (ds_wlast              ),
	.ds_wstrb           (ds_wstrb              ),
	.ds_wvalid          (ds_wvalid             ),
	.ds_wready          (ds_wready             ),
	.slv_wmid           (slv_wmid              ),
	.slv_wready         (slv_wready            ),
	.outstanding_ready  (s3  ),
	.slv_aid            (slv_aw_mid            ),
	.addr_outstanding_en(s1),
	.ds_bresp           (ds_bresp              ),
	.ds_bid             (ds_bid                ),
	.ds_bvalid          (ds_bvalid             ),
	.ds_bready          (ds_bready             ),
	.slv_bvalid         (slv_bvalid            ),
	.slv_bresp          (slv_bresp             ),
	.slv_bid            (slv_bid               ),
	.aclk               (aclk                  ),
	.aresetn            (aresetn               )
);

atcbmc301_ds_addr_ctrl #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        )
) ds_ar_addr (
`ifdef ATCBMC301_MST0_SUPPORT
	.mst0_addr             (mst0_araddr           ),
	.mst0_len              (mst0_arlen            ),
	.mst0_size             (mst0_arsize           ),
	.mst0_burst            (mst0_arburst          ),
	.mst0_lock             (mst0_arlock           ),
	.mst0_cache            (mst0_arcache          ),
	.mst0_prot             (mst0_arprot           ),
	.mst0_aid              (mst0_arid             ),
	.mst0_avalid           (mst0_arvalid          ),
	.mst0_connect          (mst0_connect          ),
`endif
`ifdef ATCBMC301_MST1_SUPPORT
	.mst1_addr             (mst1_araddr           ),
	.mst1_len              (mst1_arlen            ),
	.mst1_size             (mst1_arsize           ),
	.mst1_burst            (mst1_arburst          ),
	.mst1_lock             (mst1_arlock           ),
	.mst1_cache            (mst1_arcache          ),
	.mst1_prot             (mst1_arprot           ),
	.mst1_aid              (mst1_arid             ),
	.mst1_avalid           (mst1_arvalid          ),
	.mst1_connect          (mst1_connect          ),
`endif
	.addr_outstanding_en   (s0),
	.slv_aready            (slv_arready           ),
	.arb_mid               (slv_ar_mid            ),
	.outstanding_ready     (s2  ),
	.addr                  (ds_araddr             ),
	.len                   (ds_arlen              ),
	.size                  (ds_arsize             ),
	.burst                 (ds_arburst            ),
	.lock                  (ds_arlock             ),
	.cache                 (ds_arcache            ),
	.prot                  (ds_arprot             ),
	.aid                   (ds_arid               ),
	.avalid                (ds_arvalid            ),
	.aready                (ds_arready            ),
	.reg_mst0_high_priority(reg_mst0_high_priority),
	.reg_priority_reload   (reg_priority_reload   ),
	.aclk                  (aclk                  ),
	.aresetn               (aresetn               )
);

atcbmc301_ds_rdata_ctrl #(
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OUTSTANDING_DEPTH(SLAVE_FIFO_DEPTH)
) ds_rd_data (
	.self_id            (self_id               ),
`ifdef ATCBMC301_MST0_SUPPORT
	.mst0_rready        (mst0_rready           ),
	.mst0_rsid          (mst0_rsid             ),
	.mst0_connect       (mst0_connect          ),
`endif
`ifdef ATCBMC301_MST1_SUPPORT
	.mst1_rready        (mst1_rready           ),
	.mst1_rsid          (mst1_rsid             ),
	.mst1_connect       (mst1_connect          ),
`endif
	.ds_rdata           (ds_rdata              ),
	.ds_rresp           (ds_rresp              ),
	.ds_rid             (ds_rid                ),
	.ds_rlast           (ds_rlast              ),
	.ds_rvalid          (ds_rvalid             ),
	.ds_rready          (ds_rready             ),
	.slv_rvalid         (slv_rvalid            ),
	.slv_read_data      (slv_read_data         ),
	.slv_rid            (slv_rid               ),
	.outstanding_ready  (s2  ),
	.addr_outstanding_en(s0),
	.aclk               (aclk                  ),
	.aresetn            (aresetn               )
);

endmodule

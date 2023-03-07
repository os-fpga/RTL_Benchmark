// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_slvp_single (
    lm_reset_done,
    slv_clk,
    slv_reset_n,
    slv_clk_en,
    lm_clk,
    lm_reset_n,
    csr_mdlmb_eccen,
    csr_milmb_eccen,
    slvp_ipipe_ecc_corr,
    slvp_ipipe_ecc_ramid,
    slvp_ipipe_local_int,
    slv_awid,
    slv_awaddr,
    slv_awlen,
    slv_awsize,
    slv_awburst,
    slv_awlock,
    slv_awcache,
    slv_awprot,
    slv_awuser,
    slv_awready,
    slv_awvalid,
    slv_wdata,
    slv_wstrb,
    slv_wlast,
    slv_wvalid,
    slv_wready,
    slv_bid,
    slv_bresp,
    slv_bvalid,
    slv_bready,
    slv_arid,
    slv_araddr,
    slv_arlen,
    slv_arsize,
    slv_arburst,
    slv_arlock,
    slv_arcache,
    slv_arprot,
    slv_aruser,
    slv_arvalid,
    slv_arready,
    slv_rid,
    slv_rdata,
    slv_rresp,
    slv_rlast,
    slv_rvalid,
    slv_rready,
    slv_dlm0_a_addr,
    slv_dlm0_a_func,
    slv_dlm0_a_stall,
    slv_dlm0_a_user,
    slv_dlm0_a_valid,
    slv_dlm0_a_ready,
    slv_dlm0_d_data,
    slv_dlm0_d_status,
    slv_dlm0_d_user,
    slv_dlm0_d_valid,
    slv_dlm0_w_data,
    slv_dlm0_w_mask,
    slv_dlm0_w_valid,
    slv_dlm0_w_ready,
    slv_dlm1_a_addr,
    slv_dlm1_a_func,
    slv_dlm1_a_stall,
    slv_dlm1_a_user,
    slv_dlm1_a_valid,
    slv_dlm1_a_ready,
    slv_dlm1_d_data,
    slv_dlm1_d_status,
    slv_dlm1_d_user,
    slv_dlm1_d_valid,
    slv_dlm1_w_data,
    slv_dlm1_w_mask,
    slv_dlm1_w_valid,
    slv_dlm1_w_ready,
    slv_dlm2_a_addr,
    slv_dlm2_a_func,
    slv_dlm2_a_stall,
    slv_dlm2_a_user,
    slv_dlm2_a_valid,
    slv_dlm2_a_ready,
    slv_dlm2_d_data,
    slv_dlm2_d_status,
    slv_dlm2_d_user,
    slv_dlm2_d_valid,
    slv_dlm2_w_data,
    slv_dlm2_w_mask,
    slv_dlm2_w_valid,
    slv_dlm2_w_ready,
    slv_dlm3_a_addr,
    slv_dlm3_a_func,
    slv_dlm3_a_stall,
    slv_dlm3_a_user,
    slv_dlm3_a_valid,
    slv_dlm3_a_ready,
    slv_dlm3_d_data,
    slv_dlm3_d_status,
    slv_dlm3_d_user,
    slv_dlm3_d_valid,
    slv_dlm3_w_data,
    slv_dlm3_w_mask,
    slv_dlm3_w_valid,
    slv_dlm3_w_ready,
    slv_ilm_a_addr,
    slv_ilm_a_mask,
    slv_ilm_a_func,
    slv_ilm_a_stall,
    slv_ilm_a_user,
    slv_ilm_a_valid,
    slv_ilm_a_ready,
    slv_ilm_d_data,
    slv_ilm_d_status,
    slv_ilm_d_user,
    slv_ilm_d_valid,
    slv_ilm_w_data,
    slv_ilm_w_mask,
    slv_ilm_w_valid,
    slv_ilm_w_ready
);
parameter SLAVE_PORT_ASYNC = 0;
parameter SLAVE_PORT_ADDR_WIDTH = 32;
parameter SLAVE_PORT_DATA_WIDTH = 32;
parameter SLAVE_PORT_ID_WIDTH = 4;
parameter SLAVE_PORT_SOURCE_ID = 1'b0;
parameter ILM_UW = 1;
parameter DLM_UW = 1;
parameter ILM_SIZE_KB = 0;
parameter DLM_SIZE_KB = 0;
parameter ILM_AMSB = 19;
parameter DLM_AMSB = 19;
parameter DLM_BANK = 1;
parameter ILM_ECC_TYPE_INT = 0;
parameter DLM_ECC_TYPE_INT = 0;
localparam MAX_AMSB = (DLM_AMSB > ILM_AMSB) ? DLM_AMSB : ILM_AMSB;
localparam WCQ_WIDTH = SLAVE_PORT_ID_WIDTH + MAX_AMSB + 1 + 8 + 3 + 2 + 1;
localparam WDQ_WIDTH = SLAVE_PORT_DATA_WIDTH + (SLAVE_PORT_DATA_WIDTH / 8) + 1;
localparam BRQ_WIDTH = SLAVE_PORT_ID_WIDTH + 1;
localparam RCQ_WIDTH = SLAVE_PORT_ID_WIDTH + MAX_AMSB + 1 + 8 + 3 + 2 + 1;
localparam RDQ_WIDTH = SLAVE_PORT_ID_WIDTH + SLAVE_PORT_DATA_WIDTH + 1 + 1;
localparam WCQ_DEPTH = 2;
localparam WDQ_DEPTH = 2;
localparam BRQ_DEPTH = 2;
localparam RCQ_DEPTH = 2;
localparam RDQ_DEPTH = 2;
input lm_reset_done;
input slv_clk;
input slv_reset_n;
input slv_clk_en;
input lm_clk;
input lm_reset_n;
input [1:0] csr_mdlmb_eccen;
input [1:0] csr_milmb_eccen;
output slvp_ipipe_ecc_corr;
output [3:0] slvp_ipipe_ecc_ramid;
output slvp_ipipe_local_int;
input [(SLAVE_PORT_ID_WIDTH - 1):0] slv_awid;
input [(SLAVE_PORT_ADDR_WIDTH - 1):0] slv_awaddr;
input [7:0] slv_awlen;
input [2:0] slv_awsize;
input [1:0] slv_awburst;
input slv_awlock;
input [3:0] slv_awcache;
input [2:0] slv_awprot;
input slv_awuser;
output slv_awready;
input slv_awvalid;
input [(SLAVE_PORT_DATA_WIDTH - 1):0] slv_wdata;
input [((SLAVE_PORT_DATA_WIDTH / 8) - 1):0] slv_wstrb;
input slv_wlast;
input slv_wvalid;
output slv_wready;
output [(SLAVE_PORT_ID_WIDTH - 1):0] slv_bid;
output [1:0] slv_bresp;
output slv_bvalid;
input slv_bready;
input [(SLAVE_PORT_ID_WIDTH - 1):0] slv_arid;
input [(SLAVE_PORT_ADDR_WIDTH - 1):0] slv_araddr;
input [7:0] slv_arlen;
input [2:0] slv_arsize;
input [1:0] slv_arburst;
input slv_arlock;
input [3:0] slv_arcache;
input [2:0] slv_arprot;
input slv_aruser;
input slv_arvalid;
output slv_arready;
output [(SLAVE_PORT_ID_WIDTH - 1):0] slv_rid;
output [(SLAVE_PORT_DATA_WIDTH - 1):0] slv_rdata;
output [1:0] slv_rresp;
output slv_rlast;
output slv_rvalid;
input slv_rready;
output [DLM_AMSB:0] slv_dlm0_a_addr;
output [2:0] slv_dlm0_a_func;
output slv_dlm0_a_stall;
output [(DLM_UW - 1):0] slv_dlm0_a_user;
output slv_dlm0_a_valid;
input slv_dlm0_a_ready;
input [31:0] slv_dlm0_d_data;
input [13:0] slv_dlm0_d_status;
input [(DLM_UW - 1):0] slv_dlm0_d_user;
input slv_dlm0_d_valid;
output [31:0] slv_dlm0_w_data;
output [3:0] slv_dlm0_w_mask;
output slv_dlm0_w_valid;
input slv_dlm0_w_ready;
output [DLM_AMSB:0] slv_dlm1_a_addr;
output [2:0] slv_dlm1_a_func;
output slv_dlm1_a_stall;
output [(DLM_UW - 1):0] slv_dlm1_a_user;
output slv_dlm1_a_valid;
input slv_dlm1_a_ready;
input [31:0] slv_dlm1_d_data;
input [13:0] slv_dlm1_d_status;
input [(DLM_UW - 1):0] slv_dlm1_d_user;
input slv_dlm1_d_valid;
output [31:0] slv_dlm1_w_data;
output [3:0] slv_dlm1_w_mask;
output slv_dlm1_w_valid;
input slv_dlm1_w_ready;
output [DLM_AMSB:0] slv_dlm2_a_addr;
output [2:0] slv_dlm2_a_func;
output slv_dlm2_a_stall;
output [(DLM_UW - 1):0] slv_dlm2_a_user;
output slv_dlm2_a_valid;
input slv_dlm2_a_ready;
input [31:0] slv_dlm2_d_data;
input [13:0] slv_dlm2_d_status;
input [(DLM_UW - 1):0] slv_dlm2_d_user;
input slv_dlm2_d_valid;
output [31:0] slv_dlm2_w_data;
output [3:0] slv_dlm2_w_mask;
output slv_dlm2_w_valid;
input slv_dlm2_w_ready;
output [DLM_AMSB:0] slv_dlm3_a_addr;
output [2:0] slv_dlm3_a_func;
output slv_dlm3_a_stall;
output [(DLM_UW - 1):0] slv_dlm3_a_user;
output slv_dlm3_a_valid;
input slv_dlm3_a_ready;
input [31:0] slv_dlm3_d_data;
input [13:0] slv_dlm3_d_status;
input [(DLM_UW - 1):0] slv_dlm3_d_user;
input slv_dlm3_d_valid;
output [31:0] slv_dlm3_w_data;
output [3:0] slv_dlm3_w_mask;
output slv_dlm3_w_valid;
input slv_dlm3_w_ready;
output [ILM_AMSB:0] slv_ilm_a_addr;
output [1:0] slv_ilm_a_mask;
output [2:0] slv_ilm_a_func;
output slv_ilm_a_stall;
output [(ILM_UW - 1):0] slv_ilm_a_user;
output slv_ilm_a_valid;
input slv_ilm_a_ready;
input [63:0] slv_ilm_d_data;
input [13:0] slv_ilm_d_status;
input [(ILM_UW - 1):0] slv_ilm_d_user;
input slv_ilm_d_valid;
output [63:0] slv_ilm_w_data;
output [7:0] slv_ilm_w_mask;
output slv_ilm_w_valid;
input slv_ilm_w_ready;


wire brq_rready;
wire [(RCQ_WIDTH - 1):0] rcq_wdata;
wire rcq_wvalid;
wire rdq_rready;
wire [(WCQ_WIDTH - 1):0] wcq_wdata;
wire wcq_wvalid;
wire [(WDQ_WIDTH - 1):0] wdq_wdata;
wire wdq_wvalid;
wire [(BRQ_WIDTH - 1):0] brq_rdata;
wire brq_rvalid;
wire brq_wready;
wire [(RCQ_WIDTH - 1):0] rcq_rdata;
wire rcq_rvalid;
wire rcq_wready;
wire [(RDQ_WIDTH - 1):0] rdq_rdata;
wire rdq_rvalid;
wire rdq_wready;
wire [(WCQ_WIDTH - 1):0] wcq_rdata;
wire wcq_rvalid;
wire wcq_wready;
wire [(WDQ_WIDTH - 1):0] wdq_rdata;
wire wdq_rvalid;
wire wdq_wready;
wire [(BRQ_WIDTH - 1):0] brq_wdata;
wire brq_wvalid;
wire rcq_rready;
wire [(RDQ_WIDTH - 1):0] rdq_wdata;
wire rdq_wvalid;
wire wcq_rready;
wire wdq_rready;
kv_slvp_a2f #(
    .ADDR_WIDTH(SLAVE_PORT_ADDR_WIDTH),
    .ASYNC(SLAVE_PORT_ASYNC),
    .BRQ_WIDTH(BRQ_WIDTH),
    .DATA_WIDTH(SLAVE_PORT_DATA_WIDTH),
    .ID_WIDTH(SLAVE_PORT_ID_WIDTH),
    .MAX_AMSB(MAX_AMSB),
    .RCQ_WIDTH(RCQ_WIDTH),
    .RDQ_WIDTH(RDQ_WIDTH),
    .WCQ_WIDTH(WCQ_WIDTH),
    .WDQ_WIDTH(WDQ_WIDTH)
) u_axi2fifo (
    .slv_clk_en(slv_clk_en),
    .slv_clk(slv_clk),
    .slv_reset_n(slv_reset_n),
    .slv_awready(slv_awready),
    .slv_awvalid(slv_awvalid),
    .slv_awid(slv_awid),
    .slv_awaddr(slv_awaddr),
    .slv_awlen(slv_awlen),
    .slv_awsize(slv_awsize),
    .slv_awburst(slv_awburst),
    .slv_awlock(slv_awlock),
    .slv_awcache(slv_awcache),
    .slv_awprot(slv_awprot),
    .slv_awuser(slv_awuser),
    .slv_wready(slv_wready),
    .slv_wvalid(slv_wvalid),
    .slv_wdata(slv_wdata),
    .slv_wstrb(slv_wstrb),
    .slv_wlast(slv_wlast),
    .slv_bready(slv_bready),
    .slv_bvalid(slv_bvalid),
    .slv_bid(slv_bid),
    .slv_bresp(slv_bresp),
    .slv_arready(slv_arready),
    .slv_arvalid(slv_arvalid),
    .slv_arid(slv_arid),
    .slv_araddr(slv_araddr),
    .slv_arlen(slv_arlen),
    .slv_arsize(slv_arsize),
    .slv_arburst(slv_arburst),
    .slv_arlock(slv_arlock),
    .slv_arcache(slv_arcache),
    .slv_arprot(slv_arprot),
    .slv_aruser(slv_aruser),
    .slv_rready(slv_rready),
    .slv_rvalid(slv_rvalid),
    .slv_rid(slv_rid),
    .slv_rdata(slv_rdata),
    .slv_rresp(slv_rresp),
    .slv_rlast(slv_rlast),
    .wcq_wdata(wcq_wdata),
    .wcq_wvalid(wcq_wvalid),
    .wcq_wready(wcq_wready),
    .wdq_wdata(wdq_wdata),
    .wdq_wvalid(wdq_wvalid),
    .wdq_wready(wdq_wready),
    .brq_rdata(brq_rdata),
    .brq_rready(brq_rready),
    .brq_rvalid(brq_rvalid),
    .rcq_wdata(rcq_wdata),
    .rcq_wvalid(rcq_wvalid),
    .rcq_wready(rcq_wready),
    .rdq_rdata(rdq_rdata),
    .rdq_rready(rdq_rready),
    .rdq_rvalid(rdq_rvalid)
);
kv_slvp_fifo #(
    .ASYNC(SLAVE_PORT_ASYNC),
    .BRQ_DEPTH(BRQ_DEPTH),
    .BRQ_WIDTH(BRQ_WIDTH),
    .RCQ_DEPTH(RCQ_DEPTH),
    .RCQ_WIDTH(RCQ_WIDTH),
    .RDQ_DEPTH(RDQ_DEPTH),
    .RDQ_WIDTH(RDQ_WIDTH),
    .WCQ_DEPTH(WCQ_DEPTH),
    .WCQ_WIDTH(WCQ_WIDTH),
    .WDQ_DEPTH(WDQ_DEPTH),
    .WDQ_WIDTH(WDQ_WIDTH)
) u_fifo (
    .brq_rdata(brq_rdata),
    .brq_rready(brq_rready),
    .brq_rvalid(brq_rvalid),
    .brq_wdata(brq_wdata),
    .brq_wready(brq_wready),
    .brq_wvalid(brq_wvalid),
    .lm_clk(lm_clk),
    .lm_reset_n(lm_reset_n),
    .slv_clk(slv_clk),
    .slv_reset_n(slv_reset_n),
    .rcq_rdata(rcq_rdata),
    .rcq_rready(rcq_rready),
    .rcq_rvalid(rcq_rvalid),
    .rcq_wdata(rcq_wdata),
    .rcq_wready(rcq_wready),
    .rcq_wvalid(rcq_wvalid),
    .rdq_rdata(rdq_rdata),
    .rdq_rready(rdq_rready),
    .rdq_rvalid(rdq_rvalid),
    .rdq_wdata(rdq_wdata),
    .rdq_wready(rdq_wready),
    .rdq_wvalid(rdq_wvalid),
    .wcq_rdata(wcq_rdata),
    .wcq_rready(wcq_rready),
    .wcq_rvalid(wcq_rvalid),
    .wcq_wdata(wcq_wdata),
    .wcq_wready(wcq_wready),
    .wcq_wvalid(wcq_wvalid),
    .wdq_rdata(wdq_rdata),
    .wdq_rready(wdq_rready),
    .wdq_rvalid(wdq_rvalid),
    .wdq_wdata(wdq_wdata),
    .wdq_wready(wdq_wready),
    .wdq_wvalid(wdq_wvalid)
);
kv_slvp_f2l #(
    .BRQ_WIDTH(BRQ_WIDTH),
    .DATA_WIDTH(SLAVE_PORT_DATA_WIDTH),
    .DLM_AMSB(DLM_AMSB),
    .DLM_BANK(DLM_BANK),
    .DLM_ECC_TYPE_INT(DLM_ECC_TYPE_INT),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .DLM_UW(DLM_UW),
    .ID_WIDTH(SLAVE_PORT_ID_WIDTH),
    .ILM_AMSB(ILM_AMSB),
    .ILM_ECC_TYPE_INT(ILM_ECC_TYPE_INT),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .ILM_UW(ILM_UW),
    .MAX_AMSB(MAX_AMSB),
    .RCQ_WIDTH(RCQ_WIDTH),
    .RDQ_WIDTH(RDQ_WIDTH),
    .SOURCE_ID(SLAVE_PORT_SOURCE_ID),
    .WCQ_WIDTH(WCQ_WIDTH),
    .WDQ_WIDTH(WDQ_WIDTH)
) u_fifo2lm (
    .slv_dlm0_a_addr(slv_dlm0_a_addr),
    .slv_dlm0_a_func(slv_dlm0_a_func),
    .slv_dlm0_a_ready(slv_dlm0_a_ready),
    .slv_dlm0_a_stall(slv_dlm0_a_stall),
    .slv_dlm0_a_user(slv_dlm0_a_user),
    .slv_dlm0_a_valid(slv_dlm0_a_valid),
    .slv_dlm0_d_data(slv_dlm0_d_data),
    .slv_dlm0_d_status(slv_dlm0_d_status),
    .slv_dlm0_d_user(slv_dlm0_d_user),
    .slv_dlm0_d_valid(slv_dlm0_d_valid),
    .slv_dlm0_w_data(slv_dlm0_w_data),
    .slv_dlm0_w_mask(slv_dlm0_w_mask),
    .slv_dlm0_w_ready(slv_dlm0_w_ready),
    .slv_dlm0_w_valid(slv_dlm0_w_valid),
    .slv_dlm1_a_addr(slv_dlm1_a_addr),
    .slv_dlm1_a_func(slv_dlm1_a_func),
    .slv_dlm1_a_ready(slv_dlm1_a_ready),
    .slv_dlm1_a_stall(slv_dlm1_a_stall),
    .slv_dlm1_a_user(slv_dlm1_a_user),
    .slv_dlm1_a_valid(slv_dlm1_a_valid),
    .slv_dlm1_d_data(slv_dlm1_d_data),
    .slv_dlm1_d_status(slv_dlm1_d_status),
    .slv_dlm1_d_user(slv_dlm1_d_user),
    .slv_dlm1_d_valid(slv_dlm1_d_valid),
    .slv_dlm1_w_data(slv_dlm1_w_data),
    .slv_dlm1_w_mask(slv_dlm1_w_mask),
    .slv_dlm1_w_ready(slv_dlm1_w_ready),
    .slv_dlm1_w_valid(slv_dlm1_w_valid),
    .slv_dlm2_a_addr(slv_dlm2_a_addr),
    .slv_dlm2_a_func(slv_dlm2_a_func),
    .slv_dlm2_a_ready(slv_dlm2_a_ready),
    .slv_dlm2_a_stall(slv_dlm2_a_stall),
    .slv_dlm2_a_user(slv_dlm2_a_user),
    .slv_dlm2_a_valid(slv_dlm2_a_valid),
    .slv_dlm2_d_data(slv_dlm2_d_data),
    .slv_dlm2_d_status(slv_dlm2_d_status),
    .slv_dlm2_d_user(slv_dlm2_d_user),
    .slv_dlm2_d_valid(slv_dlm2_d_valid),
    .slv_dlm2_w_data(slv_dlm2_w_data),
    .slv_dlm2_w_mask(slv_dlm2_w_mask),
    .slv_dlm2_w_ready(slv_dlm2_w_ready),
    .slv_dlm2_w_valid(slv_dlm2_w_valid),
    .slv_dlm3_a_addr(slv_dlm3_a_addr),
    .slv_dlm3_a_func(slv_dlm3_a_func),
    .slv_dlm3_a_ready(slv_dlm3_a_ready),
    .slv_dlm3_a_stall(slv_dlm3_a_stall),
    .slv_dlm3_a_user(slv_dlm3_a_user),
    .slv_dlm3_a_valid(slv_dlm3_a_valid),
    .slv_dlm3_d_data(slv_dlm3_d_data),
    .slv_dlm3_d_status(slv_dlm3_d_status),
    .slv_dlm3_d_user(slv_dlm3_d_user),
    .slv_dlm3_d_valid(slv_dlm3_d_valid),
    .slv_dlm3_w_data(slv_dlm3_w_data),
    .slv_dlm3_w_mask(slv_dlm3_w_mask),
    .slv_dlm3_w_ready(slv_dlm3_w_ready),
    .slv_dlm3_w_valid(slv_dlm3_w_valid),
    .slv_ilm_a_addr(slv_ilm_a_addr),
    .slv_ilm_a_func(slv_ilm_a_func),
    .slv_ilm_a_mask(slv_ilm_a_mask),
    .slv_ilm_a_ready(slv_ilm_a_ready),
    .slv_ilm_a_stall(slv_ilm_a_stall),
    .slv_ilm_a_user(slv_ilm_a_user),
    .slv_ilm_a_valid(slv_ilm_a_valid),
    .slv_ilm_d_data(slv_ilm_d_data),
    .slv_ilm_d_status(slv_ilm_d_status),
    .slv_ilm_d_user(slv_ilm_d_user),
    .slv_ilm_d_valid(slv_ilm_d_valid),
    .slv_ilm_w_data(slv_ilm_w_data),
    .slv_ilm_w_mask(slv_ilm_w_mask),
    .slv_ilm_w_ready(slv_ilm_w_ready),
    .slv_ilm_w_valid(slv_ilm_w_valid),
    .clk(lm_clk),
    .reset_n(lm_reset_n),
    .csr_mdlmb_eccen(csr_mdlmb_eccen),
    .csr_milmb_eccen(csr_milmb_eccen),
    .lm_reset_done(lm_reset_done),
    .slvp_ipipe_ecc_corr(slvp_ipipe_ecc_corr),
    .slvp_ipipe_ecc_ramid(slvp_ipipe_ecc_ramid),
    .slvp_ipipe_local_int(slvp_ipipe_local_int),
    .brq_wdata(brq_wdata),
    .brq_wready(brq_wready),
    .brq_wvalid(brq_wvalid),
    .rcq_rdata(rcq_rdata),
    .rcq_rready(rcq_rready),
    .rcq_rvalid(rcq_rvalid),
    .rdq_wdata(rdq_wdata),
    .rdq_wready(rdq_wready),
    .rdq_wvalid(rdq_wvalid),
    .wcq_rdata(wcq_rdata),
    .wcq_rready(wcq_rready),
    .wcq_rvalid(wcq_rvalid),
    .wdq_rdata(wdq_rdata),
    .wdq_rready(wdq_rready),
    .wdq_rvalid(wdq_rvalid)
);
endmodule


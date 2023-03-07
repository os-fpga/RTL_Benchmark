// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lsu_rpt_stub (
    core_clk,
    core_reset_n,
    csr_milmb_ien,
    csr_mdlmb_den,
    csr_mcache_ctl_dprefetch_en,
    lsu_prefetch_clr,
    lsuop_prefetch_clr,
    rpt_cmt_valid,
    rpt_cmt_kill,
    rpt_cmt_pc,
    rpt_cmt_va,
    rpt_cmt_status,
    prf_req_valid,
    prf_req_func,
    prf_req_pc,
    prf_req_va,
    prf_req_ready,
    prf_ack_valid,
    prf_ack_status,
    prf_resp_valid,
    prf_resp_id,
    prf_resp_status,
    nbload_resp_valid,
    nbload_resp_rd,
    nbload_resp_status,
    prf_standby_ready
);
parameter EXTVALEN = 32;
parameter VALEN = 32;
parameter ILM_AMSB = 15;
parameter ILM_BASE = 64'h1000_0000;
parameter DLM_AMSB = 15;
parameter DLM_BASE = 64'h2000_0000;
localparam RPT_DEPTH = 4;
localparam PRF_WIDTH = EXTVALEN + 12 + 37;
input core_clk;
input core_reset_n;
input csr_milmb_ien;
input csr_mdlmb_den;
input csr_mcache_ctl_dprefetch_en;
input lsu_prefetch_clr;
input lsuop_prefetch_clr;
input rpt_cmt_valid;
input rpt_cmt_kill;
input [11:0] rpt_cmt_pc;
input [EXTVALEN - 1:0] rpt_cmt_va;
input [16:0] rpt_cmt_status;
output prf_req_valid;
output [36:0] prf_req_func;
output [11:0] prf_req_pc;
output [EXTVALEN - 1:0] prf_req_va;
input prf_req_ready;
input prf_ack_valid;
input [44:0] prf_ack_status;
input prf_resp_valid;
input [4:0] prf_resp_id;
input prf_resp_status;
input nbload_resp_valid;
input [4:0] nbload_resp_rd;
input nbload_resp_status;
output prf_standby_ready;


wire nds_unused_core_clk = core_clk;
wire nds_unused_core_reset_n = core_reset_n;
wire nds_unused_csr_milmb_ien = csr_milmb_ien;
wire nds_unused_csr_mdlmb_den = csr_mdlmb_den;
wire nds_unused_csr_mcache_ctl_dprefetch_en = csr_mcache_ctl_dprefetch_en;
wire nds_unused_lsu_prefetch_clr = lsu_prefetch_clr;
wire nds_unused_lsuop_prefetch_clr = lsuop_prefetch_clr;
wire nds_unused_rpt_cmt_valid = rpt_cmt_valid;
wire nds_unused_rpt_cmt_kill = rpt_cmt_kill;
wire [11:0] nds_unused_rpt_cmt_pc = rpt_cmt_pc;
wire [EXTVALEN - 1:0] s0 = rpt_cmt_va;
wire [16:0] nds_unused_rpt_cmt_status = rpt_cmt_status;
assign prf_req_valid = 1'b0;
assign prf_req_func = {37{1'b0}};
assign prf_req_pc = {12{1'b0}};
assign prf_req_va = {EXTVALEN{1'b0}};
wire nds_unused_prf_req_ready = prf_req_ready;
wire nds_unused_prf_ack_valid = prf_ack_valid;
wire [44:0] nds_unused_prf_ack_status = prf_ack_status;
wire nds_unused_prf_resp_valid = prf_resp_valid;
wire [4:0] nds_unused_prf_resp_id = prf_resp_id;
wire nds_unused_prf_resp_status = prf_resp_status;
wire nds_unused_nbload_resp_valid = nbload_resp_valid;
wire [4:0] nds_unused_nbload_resp_rd = nbload_resp_rd;
wire nds_unused_nbload_resp_status = nbload_resp_status;
assign prf_standby_ready = 1'b1;
endmodule


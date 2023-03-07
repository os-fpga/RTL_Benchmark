// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_slvp_f2l (
    slv_dlm0_a_addr,
    slv_dlm0_a_func,
    slv_dlm0_a_ready,
    slv_dlm0_a_stall,
    slv_dlm0_a_user,
    slv_dlm0_a_valid,
    slv_dlm0_d_data,
    slv_dlm0_d_status,
    slv_dlm0_d_user,
    slv_dlm0_d_valid,
    slv_dlm0_w_data,
    slv_dlm0_w_mask,
    slv_dlm0_w_ready,
    slv_dlm0_w_valid,
    slv_dlm1_a_addr,
    slv_dlm1_a_func,
    slv_dlm1_a_ready,
    slv_dlm1_a_stall,
    slv_dlm1_a_user,
    slv_dlm1_a_valid,
    slv_dlm1_d_data,
    slv_dlm1_d_status,
    slv_dlm1_d_user,
    slv_dlm1_d_valid,
    slv_dlm1_w_data,
    slv_dlm1_w_mask,
    slv_dlm1_w_ready,
    slv_dlm1_w_valid,
    slv_dlm2_a_addr,
    slv_dlm2_a_func,
    slv_dlm2_a_ready,
    slv_dlm2_a_stall,
    slv_dlm2_a_user,
    slv_dlm2_a_valid,
    slv_dlm2_d_data,
    slv_dlm2_d_status,
    slv_dlm2_d_user,
    slv_dlm2_d_valid,
    slv_dlm2_w_data,
    slv_dlm2_w_mask,
    slv_dlm2_w_ready,
    slv_dlm2_w_valid,
    slv_dlm3_a_addr,
    slv_dlm3_a_func,
    slv_dlm3_a_ready,
    slv_dlm3_a_stall,
    slv_dlm3_a_user,
    slv_dlm3_a_valid,
    slv_dlm3_d_data,
    slv_dlm3_d_status,
    slv_dlm3_d_user,
    slv_dlm3_d_valid,
    slv_dlm3_w_data,
    slv_dlm3_w_mask,
    slv_dlm3_w_ready,
    slv_dlm3_w_valid,
    slv_ilm_a_addr,
    slv_ilm_a_func,
    slv_ilm_a_mask,
    slv_ilm_a_ready,
    slv_ilm_a_stall,
    slv_ilm_a_user,
    slv_ilm_a_valid,
    slv_ilm_d_data,
    slv_ilm_d_status,
    slv_ilm_d_user,
    slv_ilm_d_valid,
    slv_ilm_w_data,
    slv_ilm_w_mask,
    slv_ilm_w_ready,
    slv_ilm_w_valid,
    clk,
    reset_n,
    csr_mdlmb_eccen,
    csr_milmb_eccen,
    lm_reset_done,
    slvp_ipipe_ecc_corr,
    slvp_ipipe_ecc_ramid,
    slvp_ipipe_local_int,
    brq_wdata,
    brq_wready,
    brq_wvalid,
    rcq_rdata,
    rcq_rready,
    rcq_rvalid,
    rdq_wdata,
    rdq_wready,
    rdq_wvalid,
    wcq_rdata,
    wcq_rready,
    wcq_rvalid,
    wdq_rdata,
    wdq_rready,
    wdq_rvalid
);
parameter DATA_WIDTH = 32;
parameter ID_WIDTH = 4;
parameter ILM_UW = 1;
parameter DLM_UW = 1;
parameter ILM_SIZE_KB = 0;
parameter DLM_SIZE_KB = 0;
parameter ILM_AMSB = 19;
parameter DLM_AMSB = 19;
parameter DLM_BANK = 1;
parameter MAX_AMSB = (DLM_AMSB > ILM_AMSB) ? DLM_AMSB : ILM_AMSB;
parameter WCQ_WIDTH = ID_WIDTH + MAX_AMSB + 1 + 8 + 3 + 2 + 1 + 1;
parameter WDQ_WIDTH = DATA_WIDTH + (DATA_WIDTH / 8) + 1;
parameter BRQ_WIDTH = ID_WIDTH + 1;
parameter RCQ_WIDTH = ID_WIDTH + MAX_AMSB + 1 + 8 + 3 + 2 + 1 + 1;
parameter RDQ_WIDTH = ID_WIDTH + DATA_WIDTH + 1 + 1;
parameter AX_CMD_WIDTH = ID_WIDTH + MAX_AMSB + 1 + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4;
parameter SOURCE_ID = 1'b0;
parameter ILM_ECC_TYPE_INT = 0;
parameter DLM_ECC_TYPE_INT = 0;
localparam QUEUE_DEPTH = 8;
localparam PTR_WIDTH = $clog2(QUEUE_DEPTH);
output [DLM_AMSB:0] slv_dlm0_a_addr;
output [2:0] slv_dlm0_a_func;
input slv_dlm0_a_ready;
output slv_dlm0_a_stall;
output [(DLM_UW - 1):0] slv_dlm0_a_user;
output slv_dlm0_a_valid;
input [31:0] slv_dlm0_d_data;
input [13:0] slv_dlm0_d_status;
input [(DLM_UW - 1):0] slv_dlm0_d_user;
input slv_dlm0_d_valid;
output [31:0] slv_dlm0_w_data;
output [3:0] slv_dlm0_w_mask;
input slv_dlm0_w_ready;
output slv_dlm0_w_valid;
output [DLM_AMSB:0] slv_dlm1_a_addr;
output [2:0] slv_dlm1_a_func;
input slv_dlm1_a_ready;
output slv_dlm1_a_stall;
output [(DLM_UW - 1):0] slv_dlm1_a_user;
output slv_dlm1_a_valid;
input [31:0] slv_dlm1_d_data;
input [13:0] slv_dlm1_d_status;
input [(DLM_UW - 1):0] slv_dlm1_d_user;
input slv_dlm1_d_valid;
output [31:0] slv_dlm1_w_data;
output [3:0] slv_dlm1_w_mask;
input slv_dlm1_w_ready;
output slv_dlm1_w_valid;
output [DLM_AMSB:0] slv_dlm2_a_addr;
output [2:0] slv_dlm2_a_func;
input slv_dlm2_a_ready;
output slv_dlm2_a_stall;
output [(DLM_UW - 1):0] slv_dlm2_a_user;
output slv_dlm2_a_valid;
input [31:0] slv_dlm2_d_data;
input [13:0] slv_dlm2_d_status;
input [(DLM_UW - 1):0] slv_dlm2_d_user;
input slv_dlm2_d_valid;
output [31:0] slv_dlm2_w_data;
output [3:0] slv_dlm2_w_mask;
input slv_dlm2_w_ready;
output slv_dlm2_w_valid;
output [DLM_AMSB:0] slv_dlm3_a_addr;
output [2:0] slv_dlm3_a_func;
input slv_dlm3_a_ready;
output slv_dlm3_a_stall;
output [(DLM_UW - 1):0] slv_dlm3_a_user;
output slv_dlm3_a_valid;
input [31:0] slv_dlm3_d_data;
input [13:0] slv_dlm3_d_status;
input [(DLM_UW - 1):0] slv_dlm3_d_user;
input slv_dlm3_d_valid;
output [31:0] slv_dlm3_w_data;
output [3:0] slv_dlm3_w_mask;
input slv_dlm3_w_ready;
output slv_dlm3_w_valid;
output [ILM_AMSB:0] slv_ilm_a_addr;
output [2:0] slv_ilm_a_func;
output [1:0] slv_ilm_a_mask;
input slv_ilm_a_ready;
output slv_ilm_a_stall;
output [(ILM_UW - 1):0] slv_ilm_a_user;
output slv_ilm_a_valid;
input [63:0] slv_ilm_d_data;
input [13:0] slv_ilm_d_status;
input [(ILM_UW - 1):0] slv_ilm_d_user;
input slv_ilm_d_valid;
output [63:0] slv_ilm_w_data;
output [7:0] slv_ilm_w_mask;
input slv_ilm_w_ready;
output slv_ilm_w_valid;
input clk;
input reset_n;
input [1:0] csr_mdlmb_eccen;
input [1:0] csr_milmb_eccen;
input lm_reset_done;
output slvp_ipipe_ecc_corr;
output [3:0] slvp_ipipe_ecc_ramid;
output slvp_ipipe_local_int;
output [(BRQ_WIDTH - 1):0] brq_wdata;
input brq_wready;
output brq_wvalid;
input [(RCQ_WIDTH - 1):0] rcq_rdata;
output rcq_rready;
input rcq_rvalid;
output [(RDQ_WIDTH - 1):0] rdq_wdata;
input rdq_wready;
output rdq_wvalid;
input [(WCQ_WIDTH - 1):0] wcq_rdata;
output wcq_rready;
input wcq_rvalid;
input [(WDQ_WIDTH - 1):0] wdq_rdata;
output wdq_rready;
input wdq_rvalid;


wire [63:0] dlm0_resp_data;
wire [(PTR_WIDTH - 1):0] dlm0_resp_ptr;
wire [13:0] dlm0_resp_status;
wire dlm0_resp_valid;
wire [(PTR_WIDTH - 1):0] dlm0_w_req_ptr;
wire dlm0_w_resp_ready;
wire [63:0] dlm1_resp_data;
wire [(PTR_WIDTH - 1):0] dlm1_resp_ptr;
wire [13:0] dlm1_resp_status;
wire dlm1_resp_valid;
wire [(PTR_WIDTH - 1):0] dlm1_w_req_ptr;
wire dlm1_w_resp_ready;
wire [63:0] dlm2_resp_data;
wire [(PTR_WIDTH - 1):0] dlm2_resp_ptr;
wire [13:0] dlm2_resp_status;
wire dlm2_resp_valid;
wire [(PTR_WIDTH - 1):0] dlm2_w_req_ptr;
wire dlm2_w_resp_ready;
wire [63:0] dlm3_resp_data;
wire [(PTR_WIDTH - 1):0] dlm3_resp_ptr;
wire [13:0] dlm3_resp_status;
wire dlm3_resp_valid;
wire [(PTR_WIDTH - 1):0] dlm3_w_req_ptr;
wire dlm3_w_resp_ready;
wire [63:0] ilm_resp_data;
wire [(PTR_WIDTH - 1):0] ilm_resp_ptr;
wire [13:0] ilm_resp_status;
wire ilm_resp_valid;
wire [(PTR_WIDTH - 1):0] ilm_w_req_ptr;
wire ilm_w_resp_ready;
wire issue_ready;
wire ax_command_ready;
wire [(BRQ_WIDTH - 1):0] b_resp_data;
wire b_resp_valid;
wire [63:0] dlm0_w_req_data;
wire [7:0] dlm0_w_req_strb;
wire [63:0] dlm1_w_req_data;
wire [7:0] dlm1_w_req_strb;
wire [63:0] dlm2_w_req_data;
wire [7:0] dlm2_w_req_strb;
wire [63:0] dlm3_w_req_data;
wire [7:0] dlm3_w_req_strb;
wire [63:0] ilm_w_req_data;
wire [7:0] ilm_w_req_strb;
wire [1:0] issue_a_mask;
wire [((MAX_AMSB + 1) - 1):0] issue_addr;
wire [1:0] issue_func;
wire [(PTR_WIDTH - 1):0] issue_ptr;
wire issue_user;
wire issue_valid;
wire [(RDQ_WIDTH - 1):0] r_resp_data;
wire r_resp_valid;
wire [(AX_CMD_WIDTH - 1):0] ax_command_data;
wire ax_command_valid;
wire b_resp_ready;
wire r_resp_ready;
kv_slvp_split #(
    .BRQ_WIDTH(BRQ_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .DLM_AMSB(DLM_AMSB),
    .DLM_ECC_TYPE_INT(DLM_ECC_TYPE_INT),
    .ID_WIDTH(ID_WIDTH),
    .ILM_AMSB(ILM_AMSB),
    .ILM_ECC_TYPE_INT(ILM_ECC_TYPE_INT),
    .MAX_AMSB(MAX_AMSB),
    .RCQ_WIDTH(RCQ_WIDTH),
    .RDQ_WIDTH(RDQ_WIDTH),
    .WCQ_WIDTH(WCQ_WIDTH),
    .WDQ_WIDTH(WDQ_WIDTH)
) u_slvp_split (
    .clk(clk),
    .reset_n(reset_n),
    .wcq_rdata(wcq_rdata),
    .wcq_rvalid(wcq_rvalid),
    .wcq_rready(wcq_rready),
    .wdq_rdata(wdq_rdata),
    .wdq_rvalid(wdq_rvalid),
    .wdq_rready(wdq_rready),
    .brq_wdata(brq_wdata),
    .brq_wvalid(brq_wvalid),
    .brq_wready(brq_wready),
    .rcq_rdata(rcq_rdata),
    .rcq_rvalid(rcq_rvalid),
    .rcq_rready(rcq_rready),
    .rdq_wdata(rdq_wdata),
    .rdq_wvalid(rdq_wvalid),
    .rdq_wready(rdq_wready),
    .ax_command_valid(ax_command_valid),
    .ax_command_ready(ax_command_ready),
    .ax_command_data(ax_command_data),
    .b_resp_valid(b_resp_valid),
    .b_resp_ready(b_resp_ready),
    .b_resp_data(b_resp_data),
    .r_resp_valid(r_resp_valid),
    .r_resp_ready(r_resp_ready),
    .r_resp_data(r_resp_data)
);
kv_slvp_queue #(
    .ADDR_WIDTH(MAX_AMSB + 1),
    .AX_CMD_WIDTH(AX_CMD_WIDTH),
    .B_RESP_WIDTH(BRQ_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .DLM_ECC_TYPE_INT(DLM_ECC_TYPE_INT),
    .ID_WIDTH(ID_WIDTH),
    .ILM_ECC_TYPE_INT(ILM_ECC_TYPE_INT),
    .PTR_WIDTH(PTR_WIDTH),
    .QUEUE_DEPTH(QUEUE_DEPTH),
    .R_RESP_WIDTH(RDQ_WIDTH)
) u_slvp_queue (
    .clk(clk),
    .reset_n(reset_n),
    .lm_reset_done(lm_reset_done),
    .ax_command_valid(ax_command_valid),
    .ax_command_ready(ax_command_ready),
    .ax_command_data(ax_command_data),
    .b_resp_valid(b_resp_valid),
    .b_resp_ready(b_resp_ready),
    .b_resp_data(b_resp_data),
    .r_resp_valid(r_resp_valid),
    .r_resp_ready(r_resp_ready),
    .r_resp_data(r_resp_data),
    .csr_milmb_eccen(csr_milmb_eccen),
    .csr_mdlmb_eccen(csr_mdlmb_eccen),
    .slvp_ipipe_local_int(slvp_ipipe_local_int),
    .slvp_ipipe_ecc_corr(slvp_ipipe_ecc_corr),
    .slvp_ipipe_ecc_ramid(slvp_ipipe_ecc_ramid),
    .issue_valid(issue_valid),
    .issue_ready(issue_ready),
    .issue_ptr(issue_ptr),
    .issue_addr(issue_addr),
    .issue_a_mask(issue_a_mask),
    .issue_func(issue_func),
    .issue_user(issue_user),
    .ilm_w_req_ptr(ilm_w_req_ptr),
    .ilm_w_req_data(ilm_w_req_data),
    .ilm_w_req_strb(ilm_w_req_strb),
    .ilm_w_resp_ready(ilm_w_resp_ready),
    .dlm0_w_req_ptr(dlm0_w_req_ptr),
    .dlm0_w_req_data(dlm0_w_req_data),
    .dlm0_w_req_strb(dlm0_w_req_strb),
    .dlm0_w_resp_ready(dlm0_w_resp_ready),
    .dlm1_w_req_ptr(dlm1_w_req_ptr),
    .dlm1_w_req_data(dlm1_w_req_data),
    .dlm1_w_req_strb(dlm1_w_req_strb),
    .dlm1_w_resp_ready(dlm1_w_resp_ready),
    .dlm2_w_req_ptr(dlm2_w_req_ptr),
    .dlm2_w_req_data(dlm2_w_req_data),
    .dlm2_w_req_strb(dlm2_w_req_strb),
    .dlm2_w_resp_ready(dlm2_w_resp_ready),
    .dlm3_w_req_ptr(dlm3_w_req_ptr),
    .dlm3_w_req_data(dlm3_w_req_data),
    .dlm3_w_req_strb(dlm3_w_req_strb),
    .dlm3_w_resp_ready(dlm3_w_resp_ready),
    .ilm_resp_valid(ilm_resp_valid),
    .ilm_resp_ptr(ilm_resp_ptr),
    .ilm_resp_data(ilm_resp_data),
    .ilm_resp_status(ilm_resp_status),
    .dlm0_resp_valid(dlm0_resp_valid),
    .dlm0_resp_ptr(dlm0_resp_ptr),
    .dlm0_resp_data(dlm0_resp_data),
    .dlm0_resp_status(dlm0_resp_status),
    .dlm1_resp_valid(dlm1_resp_valid),
    .dlm1_resp_ptr(dlm1_resp_ptr),
    .dlm1_resp_data(dlm1_resp_data),
    .dlm1_resp_status(dlm1_resp_status),
    .dlm2_resp_valid(dlm2_resp_valid),
    .dlm2_resp_ptr(dlm2_resp_ptr),
    .dlm2_resp_data(dlm2_resp_data),
    .dlm2_resp_status(dlm2_resp_status),
    .dlm3_resp_valid(dlm3_resp_valid),
    .dlm3_resp_ptr(dlm3_resp_ptr),
    .dlm3_resp_data(dlm3_resp_data),
    .dlm3_resp_status(dlm3_resp_status)
);
kv_slvp_dispatch #(
    .ADDR_WIDTH(MAX_AMSB + 1),
    .DLM_AMSB(DLM_AMSB),
    .DLM_BANK(DLM_BANK),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .DLM_UW(DLM_UW),
    .ILM_AMSB(ILM_AMSB),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .ILM_UW(ILM_UW),
    .PTR_WIDTH(PTR_WIDTH),
    .QUEUE_DEPTH(QUEUE_DEPTH),
    .SOURCE_ID(SOURCE_ID)
) u_slvp_dispatch (
    .clk(clk),
    .reset_n(reset_n),
    .issue_valid(issue_valid),
    .issue_ready(issue_ready),
    .issue_ptr(issue_ptr),
    .issue_addr(issue_addr),
    .issue_a_mask(issue_a_mask),
    .issue_func(issue_func),
    .issue_user(issue_user),
    .ilm_w_req_ptr(ilm_w_req_ptr),
    .ilm_w_req_data(ilm_w_req_data),
    .ilm_w_req_strb(ilm_w_req_strb),
    .ilm_w_resp_ready(ilm_w_resp_ready),
    .dlm0_w_req_ptr(dlm0_w_req_ptr),
    .dlm0_w_req_data(dlm0_w_req_data),
    .dlm0_w_req_strb(dlm0_w_req_strb),
    .dlm0_w_resp_ready(dlm0_w_resp_ready),
    .dlm1_w_req_ptr(dlm1_w_req_ptr),
    .dlm1_w_req_data(dlm1_w_req_data),
    .dlm1_w_req_strb(dlm1_w_req_strb),
    .dlm1_w_resp_ready(dlm1_w_resp_ready),
    .dlm2_w_req_ptr(dlm2_w_req_ptr),
    .dlm2_w_req_data(dlm2_w_req_data),
    .dlm2_w_req_strb(dlm2_w_req_strb),
    .dlm2_w_resp_ready(dlm2_w_resp_ready),
    .dlm3_w_req_ptr(dlm3_w_req_ptr),
    .dlm3_w_req_data(dlm3_w_req_data),
    .dlm3_w_req_strb(dlm3_w_req_strb),
    .dlm3_w_resp_ready(dlm3_w_resp_ready),
    .ilm_resp_valid(ilm_resp_valid),
    .ilm_resp_ptr(ilm_resp_ptr),
    .ilm_resp_data(ilm_resp_data),
    .ilm_resp_status(ilm_resp_status),
    .dlm0_resp_valid(dlm0_resp_valid),
    .dlm0_resp_ptr(dlm0_resp_ptr),
    .dlm0_resp_data(dlm0_resp_data),
    .dlm0_resp_status(dlm0_resp_status),
    .dlm1_resp_valid(dlm1_resp_valid),
    .dlm1_resp_ptr(dlm1_resp_ptr),
    .dlm1_resp_data(dlm1_resp_data),
    .dlm1_resp_status(dlm1_resp_status),
    .dlm2_resp_valid(dlm2_resp_valid),
    .dlm2_resp_ptr(dlm2_resp_ptr),
    .dlm2_resp_data(dlm2_resp_data),
    .dlm2_resp_status(dlm2_resp_status),
    .dlm3_resp_valid(dlm3_resp_valid),
    .dlm3_resp_ptr(dlm3_resp_ptr),
    .dlm3_resp_data(dlm3_resp_data),
    .dlm3_resp_status(dlm3_resp_status),
    .slv_ilm_a_valid(slv_ilm_a_valid),
    .slv_ilm_a_stall(slv_ilm_a_stall),
    .slv_ilm_a_ready(slv_ilm_a_ready),
    .slv_ilm_a_addr(slv_ilm_a_addr),
    .slv_ilm_a_mask(slv_ilm_a_mask),
    .slv_ilm_a_func(slv_ilm_a_func),
    .slv_ilm_a_user(slv_ilm_a_user),
    .slv_ilm_d_valid(slv_ilm_d_valid),
    .slv_ilm_d_data(slv_ilm_d_data),
    .slv_ilm_d_status(slv_ilm_d_status),
    .slv_ilm_d_user(slv_ilm_d_user),
    .slv_ilm_w_valid(slv_ilm_w_valid),
    .slv_ilm_w_data(slv_ilm_w_data),
    .slv_ilm_w_mask(slv_ilm_w_mask),
    .slv_ilm_w_ready(slv_ilm_w_ready),
    .slv_dlm0_a_valid(slv_dlm0_a_valid),
    .slv_dlm0_a_stall(slv_dlm0_a_stall),
    .slv_dlm0_a_ready(slv_dlm0_a_ready),
    .slv_dlm0_a_addr(slv_dlm0_a_addr),
    .slv_dlm0_a_func(slv_dlm0_a_func),
    .slv_dlm0_a_user(slv_dlm0_a_user),
    .slv_dlm0_d_valid(slv_dlm0_d_valid),
    .slv_dlm0_d_data(slv_dlm0_d_data),
    .slv_dlm0_d_status(slv_dlm0_d_status),
    .slv_dlm0_d_user(slv_dlm0_d_user),
    .slv_dlm0_w_valid(slv_dlm0_w_valid),
    .slv_dlm0_w_data(slv_dlm0_w_data),
    .slv_dlm0_w_mask(slv_dlm0_w_mask),
    .slv_dlm0_w_ready(slv_dlm0_w_ready),
    .slv_dlm1_a_valid(slv_dlm1_a_valid),
    .slv_dlm1_a_stall(slv_dlm1_a_stall),
    .slv_dlm1_a_ready(slv_dlm1_a_ready),
    .slv_dlm1_a_addr(slv_dlm1_a_addr),
    .slv_dlm1_a_func(slv_dlm1_a_func),
    .slv_dlm1_a_user(slv_dlm1_a_user),
    .slv_dlm1_d_valid(slv_dlm1_d_valid),
    .slv_dlm1_d_data(slv_dlm1_d_data),
    .slv_dlm1_d_status(slv_dlm1_d_status),
    .slv_dlm1_d_user(slv_dlm1_d_user),
    .slv_dlm1_w_valid(slv_dlm1_w_valid),
    .slv_dlm1_w_data(slv_dlm1_w_data),
    .slv_dlm1_w_mask(slv_dlm1_w_mask),
    .slv_dlm1_w_ready(slv_dlm1_w_ready),
    .slv_dlm2_a_valid(slv_dlm2_a_valid),
    .slv_dlm2_a_stall(slv_dlm2_a_stall),
    .slv_dlm2_a_ready(slv_dlm2_a_ready),
    .slv_dlm2_a_addr(slv_dlm2_a_addr),
    .slv_dlm2_a_func(slv_dlm2_a_func),
    .slv_dlm2_a_user(slv_dlm2_a_user),
    .slv_dlm2_d_valid(slv_dlm2_d_valid),
    .slv_dlm2_d_data(slv_dlm2_d_data),
    .slv_dlm2_d_status(slv_dlm2_d_status),
    .slv_dlm2_d_user(slv_dlm2_d_user),
    .slv_dlm2_w_valid(slv_dlm2_w_valid),
    .slv_dlm2_w_data(slv_dlm2_w_data),
    .slv_dlm2_w_mask(slv_dlm2_w_mask),
    .slv_dlm2_w_ready(slv_dlm2_w_ready),
    .slv_dlm3_a_valid(slv_dlm3_a_valid),
    .slv_dlm3_a_stall(slv_dlm3_a_stall),
    .slv_dlm3_a_ready(slv_dlm3_a_ready),
    .slv_dlm3_a_addr(slv_dlm3_a_addr),
    .slv_dlm3_a_func(slv_dlm3_a_func),
    .slv_dlm3_a_user(slv_dlm3_a_user),
    .slv_dlm3_d_valid(slv_dlm3_d_valid),
    .slv_dlm3_d_data(slv_dlm3_d_data),
    .slv_dlm3_d_status(slv_dlm3_d_status),
    .slv_dlm3_d_user(slv_dlm3_d_user),
    .slv_dlm3_w_valid(slv_dlm3_w_valid),
    .slv_dlm3_w_data(slv_dlm3_w_data),
    .slv_dlm3_w_mask(slv_dlm3_w_mask),
    .slv_dlm3_w_ready(slv_dlm3_w_ready)
);
endmodule


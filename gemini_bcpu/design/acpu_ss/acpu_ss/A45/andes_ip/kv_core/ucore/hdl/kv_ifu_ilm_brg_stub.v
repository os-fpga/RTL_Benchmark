// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_ifu_ilm_brg_stub (
    core_clk,
    core_reset_n,
    ifu_ilm_kill,
    ifu_ilm_req_valid,
    ifu_ilm_req_stall,
    ifu_ilm_req_addr,
    ifu_ilm_req_tag,
    ilm_ifu_req_ready,
    ilm_ifu_resp_valid,
    ilm_ifu_resp_rdata,
    ilm_ifu_resp_tag,
    ilm_ifu_resp_status,
    ifu_ilm_a_addr,
    ifu_ilm_a_func,
    ifu_ilm_a_ready,
    ifu_ilm_a_stall,
    ifu_ilm_a_user,
    ifu_ilm_a_valid,
    ifu_ilm_d_data,
    ifu_ilm_d_status,
    ifu_ilm_d_user,
    ifu_ilm_d_valid
);
parameter VALEN = 32;
parameter ILM_AMSB = 10;
localparam QUEUE_DEPTH = 3;
input core_clk;
input core_reset_n;
input ifu_ilm_kill;
input ifu_ilm_req_valid;
input ifu_ilm_req_stall;
input [VALEN - 1:0] ifu_ilm_req_addr;
input ifu_ilm_req_tag;
output ilm_ifu_req_ready;
output [3:0] ilm_ifu_resp_valid;
output [63:0] ilm_ifu_resp_rdata;
output ilm_ifu_resp_tag;
output [35:0] ilm_ifu_resp_status;
output [ILM_AMSB:0] ifu_ilm_a_addr;
output [2:0] ifu_ilm_a_func;
input ifu_ilm_a_ready;
output ifu_ilm_a_stall;
output [2:0] ifu_ilm_a_user;
output ifu_ilm_a_valid;
input [63:0] ifu_ilm_d_data;
input [13:0] ifu_ilm_d_status;
input [2:0] ifu_ilm_d_user;
input ifu_ilm_d_valid;


wire nds_unused_core_clk = core_clk;
wire nds_unused_core_reset_n = core_reset_n;
wire nds_unused_ifu_ilm_kill = ifu_ilm_kill;
wire nds_unused_ifu_ilm_req_valid = ifu_ilm_req_valid;
wire nds_unused_ifu_ilm_req_stall = ifu_ilm_req_stall;
wire [VALEN - 1:0] s0 = ifu_ilm_req_addr;
wire nds_unused_ifu_ilm_req_tag = ifu_ilm_req_tag;
assign ilm_ifu_req_ready = 1'b0;
assign ilm_ifu_resp_valid = 4'b0;
assign ilm_ifu_resp_rdata = 64'b0;
assign ilm_ifu_resp_tag = 1'b0;
assign ilm_ifu_resp_status = {36{1'b0}};
assign ifu_ilm_a_addr = {(ILM_AMSB + 1){1'b0}};
assign ifu_ilm_a_func = {3{1'b0}};
wire nds_unused_ifu_ilm_a_ready = ifu_ilm_a_ready;
assign ifu_ilm_a_stall = 1'b0;
assign ifu_ilm_a_user = 3'b0;
assign ifu_ilm_a_valid = 1'b0;
wire [63:0] nds_unused_ifu_ilm_d_data = ifu_ilm_d_data;
wire [13:0] nds_unused_ifu_ilm_d_status = ifu_ilm_d_status;
wire [2:0] nds_unused_ifu_ilm_d_user = ifu_ilm_d_user;
wire nds_unused_ifu_ilm_d_valid = ifu_ilm_d_valid;
endmodule


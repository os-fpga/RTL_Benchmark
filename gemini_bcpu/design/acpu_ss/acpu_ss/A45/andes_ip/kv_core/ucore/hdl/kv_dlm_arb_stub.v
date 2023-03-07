// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dlm_arb_stub (
    lm_clk,
    lm_reset_n,
    lsu_dlm_a_valid,
    lsu_dlm_a_stall,
    lsu_dlm_a_addr,
    lsu_dlm_a_func,
    lsu_dlm_a_user,
    lsu_dlm_a_ready,
    lsu_dlm_w_valid,
    lsu_dlm_w_data,
    lsu_dlm_w_mask,
    lsu_dlm_w_status,
    lsu_dlm_w_ready,
    lsu_dlm_d_valid,
    lsu_dlm_d_data,
    lsu_dlm_d_status,
    lsu_dlm_d_user,
    slv_dlm_a_valid,
    slv_dlm_a_stall,
    slv_dlm_a_addr,
    slv_dlm_a_func,
    slv_dlm_a_user,
    slv_dlm_a_ready,
    slv_dlm_w_valid,
    slv_dlm_w_data,
    slv_dlm_w_mask,
    slv_dlm_w_ready,
    slv_dlm_d_valid,
    slv_dlm_d_data,
    slv_dlm_d_status,
    slv_dlm_d_user,
    dlm0_a_valid,
    dlm0_a_stall,
    dlm0_a_addr,
    dlm0_a_func,
    dlm0_a_user,
    dlm0_a_source,
    dlm0_a_ready,
    dlm0_w_valid,
    dlm0_w_data,
    dlm0_w_mask,
    dlm0_w_ready,
    dlm0_d_valid,
    dlm0_d_data,
    dlm0_d_status,
    dlm0_d_user
);
parameter RAM_DW = 32;
parameter ECC_TYPE_INT = 0;
parameter UW = 1;
parameter DLM_BANKS = 1;
parameter DLM_SIZE_KB = 0;
parameter DLM_RAM_AW = 11;
parameter DLM_RAM_BWEW = 8;
parameter DLM_RAM_DW = 72;
parameter DLM_AMSB = DLM_RAM_AW + 1;
parameter DLM_ALSB = (DLM_BANKS == 1) ? 2 : 4;
parameter SOURCE_BITS = 4;
localparam ARB_SLV = 0;
localparam ARB_LSU = 1;
localparam ARB_BITS = 2;
input lm_clk;
input lm_reset_n;
input lsu_dlm_a_valid;
input lsu_dlm_a_stall;
input [DLM_AMSB:0] lsu_dlm_a_addr;
input [2:0] lsu_dlm_a_func;
input [UW - 1:0] lsu_dlm_a_user;
output lsu_dlm_a_ready;
input lsu_dlm_w_valid;
input [31:0] lsu_dlm_w_data;
input [3:0] lsu_dlm_w_mask;
output lsu_dlm_w_status;
output lsu_dlm_w_ready;
output lsu_dlm_d_valid;
output [31:0] lsu_dlm_d_data;
output [13:0] lsu_dlm_d_status;
output [UW - 1:0] lsu_dlm_d_user;
input slv_dlm_a_valid;
input slv_dlm_a_stall;
input [DLM_AMSB:0] slv_dlm_a_addr;
input [2:0] slv_dlm_a_func;
input [UW - 1:0] slv_dlm_a_user;
output slv_dlm_a_ready;
input slv_dlm_w_valid;
input [31:0] slv_dlm_w_data;
input [3:0] slv_dlm_w_mask;
output slv_dlm_w_ready;
output slv_dlm_d_valid;
output [31:0] slv_dlm_d_data;
output [13:0] slv_dlm_d_status;
output [UW - 1:0] slv_dlm_d_user;
output dlm0_a_valid;
output dlm0_a_stall;
output [DLM_RAM_AW - 1:0] dlm0_a_addr;
output [2:0] dlm0_a_func;
output [UW + 1:0] dlm0_a_user;
output [SOURCE_BITS - 1:0] dlm0_a_source;
input dlm0_a_ready;
output dlm0_w_valid;
output [31:0] dlm0_w_data;
output [3:0] dlm0_w_mask;
input dlm0_w_ready;
input dlm0_d_valid;
input [31:0] dlm0_d_data;
input [13:0] dlm0_d_status;
input [UW + 1:0] dlm0_d_user;


wire nds_unused_lm_clk = lm_clk;
wire nds_unused_lm_reset_n = lm_reset_n;
wire nds_unused_lsu_dlm_a_valid = lsu_dlm_a_valid;
wire nds_unused_lsu_dlm_a_stall = lsu_dlm_a_stall;
wire [DLM_AMSB:0] nds_unused_lsu_dlm_a_addr = lsu_dlm_a_addr;
wire [2:0] nds_unused_lsu_dlm_a_func = lsu_dlm_a_func;
wire [UW - 1:0] s0 = lsu_dlm_a_user;
assign lsu_dlm_a_ready = 1'b0;
wire nds_unused_lsu_dlm_w_valid = lsu_dlm_w_valid;
wire [31:0] nds_unused_lsu_dlm_w_data = lsu_dlm_w_data;
wire [3:0] nds_unused_lsu_dlm_w_mask = lsu_dlm_w_mask;
assign lsu_dlm_w_status = 1'b0;
assign lsu_dlm_w_ready = 1'b0;
assign lsu_dlm_d_valid = 1'b0;
assign lsu_dlm_d_data = {32{1'b0}};
assign lsu_dlm_d_status = {14{1'b0}};
assign lsu_dlm_d_user = {UW{1'b0}};
wire nds_unused_slv_dlm_a_valid = slv_dlm_a_valid;
wire nds_unused_slv_dlm_a_stall = slv_dlm_a_stall;
wire [DLM_AMSB:0] nds_unused_slv_dlm_a_addr = slv_dlm_a_addr;
wire [2:0] nds_unused_slv_dlm_a_func = slv_dlm_a_func;
wire [UW - 1:0] s1 = slv_dlm_a_user;
assign slv_dlm_a_ready = 1'b0;
wire nds_unused_slv_dlm_w_valid = slv_dlm_w_valid;
wire [31:0] nds_unused_slv_dlm_w_data = slv_dlm_w_data;
wire [3:0] nds_unused_slv_dlm_w_mask = slv_dlm_w_mask;
assign slv_dlm_w_ready = 1'b0;
assign slv_dlm_d_valid = 1'b0;
assign slv_dlm_d_data = {32{1'b0}};
assign slv_dlm_d_status = {14{1'b0}};
assign slv_dlm_d_user = {UW{1'b0}};
assign dlm0_a_valid = 1'b0;
assign dlm0_a_stall = 1'b0;
assign dlm0_a_addr = {DLM_RAM_AW{1'b0}};
assign dlm0_a_func = {3{1'b0}};
assign dlm0_a_user = {(UW + 1 + 1){1'b0}};
assign dlm0_a_source = {SOURCE_BITS{1'b0}};
wire nds_unused_dlm0_a_ready = dlm0_a_ready;
assign dlm0_w_valid = 1'b0;
assign dlm0_w_data = {32{1'b0}};
assign dlm0_w_mask = {4{1'b0}};
wire nds_unused_dlm0_w_ready = dlm0_w_ready;
wire nds_unused_dlm0_d_valid = dlm0_d_valid;
wire [31:0] nds_unused_dlm0_d_data = dlm0_d_data;
wire [13:0] nds_unused_dlm0_d_status = dlm0_d_status;
wire [UW + 1:0] s2 = dlm0_d_user;
endmodule


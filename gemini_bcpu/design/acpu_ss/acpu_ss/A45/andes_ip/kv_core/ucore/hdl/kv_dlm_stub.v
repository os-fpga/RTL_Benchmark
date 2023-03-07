// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dlm_stub (
    dlm_standby_ready,
    dlm0_async_write_error,
    dlm_a_addr,
    dlm_a_data,
    dlm_a_mask,
    dlm_a_opcode,
    dlm_a_parity,
    dlm_a_ready,
    dlm_a_size,
    dlm_a_user,
    dlm_a_valid,
    dlm_addr,
    dlm_byte_we,
    dlm_cs,
    dlm_csr_access0,
    dlm_d_data,
    dlm_d_denied,
    dlm_d_parity,
    dlm_d_ready,
    dlm_d_valid,
    dlm_rdata,
    dlm_user,
    dlm_wdata,
    dlm_we,
    csr_mdlmb_eccen,
    csr_mdlmb_rwecc,
    csr_mecc_code,
    lm_clk_en,
    lm_clk,
    lm_reset_n,
    dlm1_addr,
    dlm1_async_write_error,
    dlm1_byte_we,
    dlm1_cs,
    dlm1_rdata,
    dlm1_user,
    dlm1_wdata,
    dlm1_we,
    dlm_csr_access1,
    dlm2_addr,
    dlm2_async_write_error,
    dlm2_byte_we,
    dlm2_cs,
    dlm2_rdata,
    dlm2_user,
    dlm2_wdata,
    dlm2_we,
    dlm_csr_access2,
    dlm3_addr,
    dlm3_async_write_error,
    dlm3_byte_we,
    dlm3_cs,
    dlm3_rdata,
    dlm3_user,
    dlm3_wdata,
    dlm3_we,
    dlm_csr_access3,
    lsu_dlm0_a_addr,
    lsu_dlm0_a_func,
    lsu_dlm0_a_ready,
    lsu_dlm0_a_stall,
    lsu_dlm0_a_user,
    lsu_dlm0_a_valid,
    lsu_dlm0_d_data,
    lsu_dlm0_d_status,
    lsu_dlm0_d_user,
    lsu_dlm0_d_valid,
    lsu_dlm0_w_data,
    lsu_dlm0_w_mask,
    lsu_dlm0_w_ready,
    lsu_dlm0_w_status,
    lsu_dlm0_w_valid,
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
    lsu_dlm1_a_addr,
    lsu_dlm1_a_func,
    lsu_dlm1_a_ready,
    lsu_dlm1_a_stall,
    lsu_dlm1_a_user,
    lsu_dlm1_a_valid,
    lsu_dlm1_d_data,
    lsu_dlm1_d_status,
    lsu_dlm1_d_user,
    lsu_dlm1_d_valid,
    lsu_dlm1_w_data,
    lsu_dlm1_w_mask,
    lsu_dlm1_w_ready,
    lsu_dlm1_w_status,
    lsu_dlm1_w_valid,
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
    lsu_dlm2_a_addr,
    lsu_dlm2_a_func,
    lsu_dlm2_a_ready,
    lsu_dlm2_a_stall,
    lsu_dlm2_a_user,
    lsu_dlm2_a_valid,
    lsu_dlm2_d_data,
    lsu_dlm2_d_status,
    lsu_dlm2_d_user,
    lsu_dlm2_d_valid,
    lsu_dlm2_w_data,
    lsu_dlm2_w_mask,
    lsu_dlm2_w_ready,
    lsu_dlm2_w_status,
    lsu_dlm2_w_valid,
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
    lsu_dlm3_a_addr,
    lsu_dlm3_a_func,
    lsu_dlm3_a_ready,
    lsu_dlm3_a_stall,
    lsu_dlm3_a_user,
    lsu_dlm3_a_valid,
    lsu_dlm3_d_data,
    lsu_dlm3_d_status,
    lsu_dlm3_d_user,
    lsu_dlm3_d_valid,
    lsu_dlm3_w_data,
    lsu_dlm3_w_mask,
    lsu_dlm3_w_ready,
    lsu_dlm3_w_status,
    lsu_dlm3_w_valid,
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
    slv_dlm3_w_valid
);
parameter DLM_ECC_TYPE_INT = 0;
parameter DLM_SIZE_KB = 0;
parameter DLM_RAM_AW = 11;
parameter DLM_RAM_BWEW = 8;
parameter DLM_RAM_DW = 72;
parameter DLM_WAIT_CYCLE = 1;
parameter DLM_AMSB = DLM_RAM_AW + 1;
parameter NUM_DLM_BANKS = 1;
parameter UW = 1;
localparam SB_DEPTH = 6;
localparam DLM_BANKS = NUM_DLM_BANKS;
localparam SOURCE_BITS = 2;
output dlm_standby_ready;
output dlm0_async_write_error;
output [DLM_RAM_AW + 2:3] dlm_a_addr;
output [31:0] dlm_a_data;
output [3:0] dlm_a_mask;
output [2:0] dlm_a_opcode;
output [7:0] dlm_a_parity;
input dlm_a_ready;
output [2:0] dlm_a_size;
output [1:0] dlm_a_user;
output dlm_a_valid;
output [(DLM_RAM_AW - 1):0] dlm_addr;
output [(DLM_RAM_BWEW - 1):0] dlm_byte_we;
output dlm_cs;
output dlm_csr_access0;
input [31:0] dlm_d_data;
input dlm_d_denied;
input [7:0] dlm_d_parity;
output dlm_d_ready;
input dlm_d_valid;
input [(DLM_RAM_DW - 1):0] dlm_rdata;
output [(SOURCE_BITS - 1):0] dlm_user;
output [(DLM_RAM_DW - 1):0] dlm_wdata;
output dlm_we;
input [1:0] csr_mdlmb_eccen;
input csr_mdlmb_rwecc;
input [31:0] csr_mecc_code;
input lm_clk_en;
input lm_clk;
input lm_reset_n;
output [(DLM_RAM_AW - 1):0] dlm1_addr;
output dlm1_async_write_error;
output [(DLM_RAM_BWEW - 1):0] dlm1_byte_we;
output dlm1_cs;
input [(DLM_RAM_DW - 1):0] dlm1_rdata;
output [(SOURCE_BITS - 1):0] dlm1_user;
output [(DLM_RAM_DW - 1):0] dlm1_wdata;
output dlm1_we;
output dlm_csr_access1;
output [(DLM_RAM_AW - 1):0] dlm2_addr;
output dlm2_async_write_error;
output [(DLM_RAM_BWEW - 1):0] dlm2_byte_we;
output dlm2_cs;
input [(DLM_RAM_DW - 1):0] dlm2_rdata;
output [(SOURCE_BITS - 1):0] dlm2_user;
output [(DLM_RAM_DW - 1):0] dlm2_wdata;
output dlm2_we;
output dlm_csr_access2;
output [(DLM_RAM_AW - 1):0] dlm3_addr;
output dlm3_async_write_error;
output [(DLM_RAM_BWEW - 1):0] dlm3_byte_we;
output dlm3_cs;
input [(DLM_RAM_DW - 1):0] dlm3_rdata;
output [(SOURCE_BITS - 1):0] dlm3_user;
output [(DLM_RAM_DW - 1):0] dlm3_wdata;
output dlm3_we;
output dlm_csr_access3;
input [DLM_AMSB:0] lsu_dlm0_a_addr;
input [2:0] lsu_dlm0_a_func;
output lsu_dlm0_a_ready;
input lsu_dlm0_a_stall;
input [(UW - 1):0] lsu_dlm0_a_user;
input lsu_dlm0_a_valid;
output [31:0] lsu_dlm0_d_data;
output [13:0] lsu_dlm0_d_status;
output [(UW - 1):0] lsu_dlm0_d_user;
output lsu_dlm0_d_valid;
input [31:0] lsu_dlm0_w_data;
input [3:0] lsu_dlm0_w_mask;
output lsu_dlm0_w_ready;
output lsu_dlm0_w_status;
input lsu_dlm0_w_valid;
input [DLM_AMSB:0] slv_dlm0_a_addr;
input [2:0] slv_dlm0_a_func;
output slv_dlm0_a_ready;
input slv_dlm0_a_stall;
input [(UW - 1):0] slv_dlm0_a_user;
input slv_dlm0_a_valid;
output [31:0] slv_dlm0_d_data;
output [13:0] slv_dlm0_d_status;
output [(UW - 1):0] slv_dlm0_d_user;
output slv_dlm0_d_valid;
input [31:0] slv_dlm0_w_data;
input [3:0] slv_dlm0_w_mask;
output slv_dlm0_w_ready;
input slv_dlm0_w_valid;
input [DLM_AMSB:0] lsu_dlm1_a_addr;
input [2:0] lsu_dlm1_a_func;
output lsu_dlm1_a_ready;
input lsu_dlm1_a_stall;
input [(UW - 1):0] lsu_dlm1_a_user;
input lsu_dlm1_a_valid;
output [31:0] lsu_dlm1_d_data;
output [13:0] lsu_dlm1_d_status;
output [(UW - 1):0] lsu_dlm1_d_user;
output lsu_dlm1_d_valid;
input [31:0] lsu_dlm1_w_data;
input [3:0] lsu_dlm1_w_mask;
output lsu_dlm1_w_ready;
output lsu_dlm1_w_status;
input lsu_dlm1_w_valid;
input [DLM_AMSB:0] slv_dlm1_a_addr;
input [2:0] slv_dlm1_a_func;
output slv_dlm1_a_ready;
input slv_dlm1_a_stall;
input [(UW - 1):0] slv_dlm1_a_user;
input slv_dlm1_a_valid;
output [31:0] slv_dlm1_d_data;
output [13:0] slv_dlm1_d_status;
output [(UW - 1):0] slv_dlm1_d_user;
output slv_dlm1_d_valid;
input [31:0] slv_dlm1_w_data;
input [3:0] slv_dlm1_w_mask;
output slv_dlm1_w_ready;
input slv_dlm1_w_valid;
input [DLM_AMSB:0] lsu_dlm2_a_addr;
input [2:0] lsu_dlm2_a_func;
output lsu_dlm2_a_ready;
input lsu_dlm2_a_stall;
input [(UW - 1):0] lsu_dlm2_a_user;
input lsu_dlm2_a_valid;
output [31:0] lsu_dlm2_d_data;
output [13:0] lsu_dlm2_d_status;
output [(UW - 1):0] lsu_dlm2_d_user;
output lsu_dlm2_d_valid;
input [31:0] lsu_dlm2_w_data;
input [3:0] lsu_dlm2_w_mask;
output lsu_dlm2_w_ready;
output lsu_dlm2_w_status;
input lsu_dlm2_w_valid;
input [DLM_AMSB:0] slv_dlm2_a_addr;
input [2:0] slv_dlm2_a_func;
output slv_dlm2_a_ready;
input slv_dlm2_a_stall;
input [(UW - 1):0] slv_dlm2_a_user;
input slv_dlm2_a_valid;
output [31:0] slv_dlm2_d_data;
output [13:0] slv_dlm2_d_status;
output [(UW - 1):0] slv_dlm2_d_user;
output slv_dlm2_d_valid;
input [31:0] slv_dlm2_w_data;
input [3:0] slv_dlm2_w_mask;
output slv_dlm2_w_ready;
input slv_dlm2_w_valid;
input [DLM_AMSB:0] lsu_dlm3_a_addr;
input [2:0] lsu_dlm3_a_func;
output lsu_dlm3_a_ready;
input lsu_dlm3_a_stall;
input [(UW - 1):0] lsu_dlm3_a_user;
input lsu_dlm3_a_valid;
output [31:0] lsu_dlm3_d_data;
output [13:0] lsu_dlm3_d_status;
output [(UW - 1):0] lsu_dlm3_d_user;
output lsu_dlm3_d_valid;
input [31:0] lsu_dlm3_w_data;
input [3:0] lsu_dlm3_w_mask;
output lsu_dlm3_w_ready;
output lsu_dlm3_w_status;
input lsu_dlm3_w_valid;
input [DLM_AMSB:0] slv_dlm3_a_addr;
input [2:0] slv_dlm3_a_func;
output slv_dlm3_a_ready;
input slv_dlm3_a_stall;
input [(UW - 1):0] slv_dlm3_a_user;
input slv_dlm3_a_valid;
output [31:0] slv_dlm3_d_data;
output [13:0] slv_dlm3_d_status;
output [(UW - 1):0] slv_dlm3_d_user;
output slv_dlm3_d_valid;
input [31:0] slv_dlm3_w_data;
input [3:0] slv_dlm3_w_mask;
output slv_dlm3_w_ready;
input slv_dlm3_w_valid;


assign dlm_standby_ready = 1'b0;
assign dlm0_async_write_error = 1'b0;
assign dlm_a_addr = {(DLM_RAM_AW + 2 - 3 + 1){1'b0}};
assign dlm_a_data = {32{1'b0}};
assign dlm_a_mask = {4{1'b0}};
assign dlm_a_opcode = 3'b0;
assign dlm_a_parity = 8'b0;
wire nds_unused_dlm_a_ready = dlm_a_ready;
assign dlm_a_size = 3'b0;
assign dlm_a_user = 2'b0;
assign dlm_a_valid = 1'b0;
assign dlm_addr = {((DLM_RAM_AW - 1) + 1){1'b0}};
assign dlm_byte_we = {((DLM_RAM_BWEW - 1) + 1){1'b0}};
assign dlm_cs = 1'b0;
assign dlm_csr_access0 = 1'b0;
wire [31:0] nds_unused_dlm_d_data = dlm_d_data;
wire nds_unused_dlm_d_denied = dlm_d_denied;
wire [7:0] nds_unused_dlm_d_parity0 = dlm_d_parity;
assign dlm_d_ready = 1'b0;
wire nds_unused_dlm_d_valid = dlm_d_valid;
wire [(DLM_RAM_DW - 1):0] s0 = dlm_rdata;
assign dlm_user = {((SOURCE_BITS - 1) + 1){1'b0}};
assign dlm_wdata = {((DLM_RAM_DW - 1) + 1){1'b0}};
assign dlm_we = 1'b0;
wire [1:0] nds_unused_csr_mdlmb_eccen = csr_mdlmb_eccen;
wire nds_unused_csr_mdlmb_rwecc = csr_mdlmb_rwecc;
wire [31:0] nds_unused_csr_mecc_code = csr_mecc_code;
wire nds_unused_lm_clk_en = lm_clk_en;
wire nds_unused_lm_clk = lm_clk;
wire nds_unused_lm_reset_n = lm_reset_n;
assign dlm1_addr = {((DLM_RAM_AW - 1) + 1){1'b0}};
assign dlm1_async_write_error = 1'b0;
assign dlm1_byte_we = {((DLM_RAM_BWEW - 1) + 1){1'b0}};
assign dlm1_cs = 1'b0;
wire [(DLM_RAM_DW - 1):0] s1 = dlm1_rdata;
assign dlm1_user = {((SOURCE_BITS - 1) + 1){1'b0}};
assign dlm1_wdata = {((DLM_RAM_DW - 1) + 1){1'b0}};
assign dlm1_we = 1'b0;
assign dlm_csr_access1 = 1'b0;
assign dlm2_addr = {((DLM_RAM_AW - 1) + 1){1'b0}};
assign dlm2_async_write_error = 1'b0;
assign dlm2_byte_we = {((DLM_RAM_BWEW - 1) + 1){1'b0}};
assign dlm2_cs = 1'b0;
wire [(DLM_RAM_DW - 1):0] s2 = dlm2_rdata;
assign dlm2_user = {((SOURCE_BITS - 1) + 1){1'b0}};
assign dlm2_wdata = {((DLM_RAM_DW - 1) + 1){1'b0}};
assign dlm2_we = 1'b0;
assign dlm_csr_access2 = 1'b0;
assign dlm3_addr = {((DLM_RAM_AW - 1) + 1){1'b0}};
assign dlm3_async_write_error = 1'b0;
assign dlm3_byte_we = {((DLM_RAM_BWEW - 1) + 1){1'b0}};
assign dlm3_cs = 1'b0;
wire [(DLM_RAM_DW - 1):0] s3 = dlm3_rdata;
assign dlm3_user = {((SOURCE_BITS - 1) + 1){1'b0}};
assign dlm3_wdata = {((DLM_RAM_DW - 1) + 1){1'b0}};
assign dlm3_we = 1'b0;
assign dlm_csr_access3 = 1'b0;
wire [DLM_AMSB:0] nds_unused_lsu_dlm0_a_addr = lsu_dlm0_a_addr;
wire [2:0] nds_unused_lsu_dlm0_a_func = lsu_dlm0_a_func;
assign lsu_dlm0_a_ready = 1'b0;
wire nds_unused_lsu_dlm0_a_stall = lsu_dlm0_a_stall;
wire [(UW - 1):0] s4 = lsu_dlm0_a_user;
wire nds_unused_lsu_dlm0_a_valid = lsu_dlm0_a_valid;
assign lsu_dlm0_d_data = {32{1'b0}};
assign lsu_dlm0_d_status = {14{1'b0}};
assign lsu_dlm0_d_user = {((UW - 1) + 1){1'b0}};
assign lsu_dlm0_d_valid = 1'b0;
wire [31:0] nds_unused_lsu_dlm0_w_data = lsu_dlm0_w_data;
wire [3:0] nds_unused_lsu_dlm0_w_mask = lsu_dlm0_w_mask;
assign lsu_dlm0_w_ready = 1'b0;
assign lsu_dlm0_w_status = 1'b0;
wire nds_unused_lsu_dlm0_w_valid = lsu_dlm0_w_valid;
wire [DLM_AMSB:0] nds_unused_slv_dlm0_a_addr = slv_dlm0_a_addr;
wire [2:0] nds_unused_slv_dlm0_a_func = slv_dlm0_a_func;
assign slv_dlm0_a_ready = 1'b0;
wire nds_unused_slv_dlm0_a_stall = slv_dlm0_a_stall;
wire [(UW - 1):0] s5 = slv_dlm0_a_user;
wire nds_unused_slv_dlm0_a_valid = slv_dlm0_a_valid;
assign slv_dlm0_d_data = {32{1'b0}};
assign slv_dlm0_d_status = {14{1'b0}};
assign slv_dlm0_d_user = {((UW - 1) + 1){1'b0}};
assign slv_dlm0_d_valid = 1'b0;
wire [31:0] nds_unused_slv_dlm0_w_data = slv_dlm0_w_data;
wire [3:0] nds_unused_slv_dlm0_w_mask = slv_dlm0_w_mask;
assign slv_dlm0_w_ready = 1'b0;
wire nds_unused_slv_dlm0_w_valid = slv_dlm0_w_valid;
wire [DLM_AMSB:0] nds_unused_lsu_dlm1_a_addr = lsu_dlm1_a_addr;
wire [2:0] nds_unused_lsu_dlm1_a_func = lsu_dlm1_a_func;
assign lsu_dlm1_a_ready = 1'b0;
wire nds_unused_lsu_dlm1_a_stall = lsu_dlm1_a_stall;
wire [(UW - 1):0] s6 = lsu_dlm1_a_user;
wire nds_unused_lsu_dlm1_a_valid = lsu_dlm1_a_valid;
assign lsu_dlm1_d_data = {32{1'b0}};
assign lsu_dlm1_d_status = {14{1'b0}};
assign lsu_dlm1_d_user = {((UW - 1) + 1){1'b0}};
assign lsu_dlm1_d_valid = 1'b0;
wire [31:0] nds_unused_lsu_dlm1_w_data = lsu_dlm1_w_data;
wire [3:0] nds_unused_lsu_dlm1_w_mask = lsu_dlm1_w_mask;
assign lsu_dlm1_w_ready = 1'b0;
assign lsu_dlm1_w_status = 1'b0;
wire nds_unused_lsu_dlm1_w_valid = lsu_dlm1_w_valid;
wire [DLM_AMSB:0] nds_unused_slv_dlm1_a_addr = slv_dlm1_a_addr;
wire [2:0] nds_unused_slv_dlm1_a_func = slv_dlm1_a_func;
assign slv_dlm1_a_ready = 1'b0;
wire nds_unused_slv_dlm1_a_stall = slv_dlm1_a_stall;
wire [(UW - 1):0] s7 = slv_dlm1_a_user;
wire nds_unused_slv_dlm1_a_valid = slv_dlm1_a_valid;
assign slv_dlm1_d_data = {32{1'b0}};
assign slv_dlm1_d_status = {14{1'b0}};
assign slv_dlm1_d_user = {((UW - 1) + 1){1'b0}};
assign slv_dlm1_d_valid = 1'b0;
wire [31:0] nds_unused_slv_dlm1_w_data = slv_dlm1_w_data;
wire [3:0] nds_unused_slv_dlm1_w_mask = slv_dlm1_w_mask;
assign slv_dlm1_w_ready = 1'b0;
wire nds_unused_slv_dlm1_w_valid = slv_dlm1_w_valid;
wire [DLM_AMSB:0] nds_unused_lsu_dlm2_a_addr = lsu_dlm2_a_addr;
wire [2:0] nds_unused_lsu_dlm2_a_func = lsu_dlm2_a_func;
assign lsu_dlm2_a_ready = 1'b0;
wire nds_unused_lsu_dlm2_a_stall = lsu_dlm2_a_stall;
wire [(UW - 1):0] s8 = lsu_dlm2_a_user;
wire nds_unused_lsu_dlm2_a_valid = lsu_dlm2_a_valid;
assign lsu_dlm2_d_data = {32{1'b0}};
assign lsu_dlm2_d_status = {14{1'b0}};
assign lsu_dlm2_d_user = {((UW - 1) + 1){1'b0}};
assign lsu_dlm2_d_valid = 1'b0;
wire [31:0] nds_unused_lsu_dlm2_w_data = lsu_dlm2_w_data;
wire [3:0] nds_unused_lsu_dlm2_w_mask = lsu_dlm2_w_mask;
assign lsu_dlm2_w_ready = 1'b0;
assign lsu_dlm2_w_status = 1'b0;
wire nds_unused_lsu_dlm2_w_valid = lsu_dlm2_w_valid;
wire [DLM_AMSB:0] nds_unused_slv_dlm2_a_addr = slv_dlm2_a_addr;
wire [2:0] nds_unused_slv_dlm2_a_func = slv_dlm2_a_func;
assign slv_dlm2_a_ready = 1'b0;
wire nds_unused_slv_dlm2_a_stall = slv_dlm2_a_stall;
wire [(UW - 1):0] s9 = slv_dlm2_a_user;
wire nds_unused_slv_dlm2_a_valid = slv_dlm2_a_valid;
assign slv_dlm2_d_data = {32{1'b0}};
assign slv_dlm2_d_status = {14{1'b0}};
assign slv_dlm2_d_user = {((UW - 1) + 1){1'b0}};
assign slv_dlm2_d_valid = 1'b0;
wire [31:0] nds_unused_slv_dlm2_w_data = slv_dlm2_w_data;
wire [3:0] nds_unused_slv_dlm2_w_mask = slv_dlm2_w_mask;
assign slv_dlm2_w_ready = 1'b0;
wire nds_unused_slv_dlm2_w_valid = slv_dlm2_w_valid;
wire [DLM_AMSB:0] nds_unused_lsu_dlm3_a_addr = lsu_dlm3_a_addr;
wire [2:0] nds_unused_lsu_dlm3_a_func = lsu_dlm3_a_func;
assign lsu_dlm3_a_ready = 1'b0;
wire nds_unused_lsu_dlm3_a_stall = lsu_dlm3_a_stall;
wire [(UW - 1):0] s10 = lsu_dlm3_a_user;
wire nds_unused_lsu_dlm3_a_valid = lsu_dlm3_a_valid;
assign lsu_dlm3_d_data = {32{1'b0}};
assign lsu_dlm3_d_status = {14{1'b0}};
assign lsu_dlm3_d_user = {((UW - 1) + 1){1'b0}};
assign lsu_dlm3_d_valid = 1'b0;
wire [31:0] nds_unused_lsu_dlm3_w_data = lsu_dlm3_w_data;
wire [3:0] nds_unused_lsu_dlm3_w_mask = lsu_dlm3_w_mask;
assign lsu_dlm3_w_ready = 1'b0;
assign lsu_dlm3_w_status = 1'b0;
wire nds_unused_lsu_dlm3_w_valid = lsu_dlm3_w_valid;
wire [DLM_AMSB:0] nds_unused_slv_dlm3_a_addr = slv_dlm3_a_addr;
wire [2:0] nds_unused_slv_dlm3_a_func = slv_dlm3_a_func;
assign slv_dlm3_a_ready = 1'b0;
wire nds_unused_slv_dlm3_a_stall = slv_dlm3_a_stall;
wire [(UW - 1):0] s11 = slv_dlm3_a_user;
wire nds_unused_slv_dlm3_a_valid = slv_dlm3_a_valid;
assign slv_dlm3_d_data = {32{1'b0}};
assign slv_dlm3_d_status = {14{1'b0}};
assign slv_dlm3_d_user = {((UW - 1) + 1){1'b0}};
assign slv_dlm3_d_valid = 1'b0;
wire [31:0] nds_unused_slv_dlm3_w_data = slv_dlm3_w_data;
wire [3:0] nds_unused_slv_dlm3_w_mask = slv_dlm3_w_mask;
assign slv_dlm3_w_ready = 1'b0;
wire nds_unused_slv_dlm3_w_valid = slv_dlm3_w_valid;
endmodule


// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_ilm_stub (
    csr_mecc_code,
    csr_milmb_eccen,
    csr_milmb_rwecc,
    ilm_async_write_error,
    ilm0_addr,
    ilm0_byte_we,
    ilm0_cs,
    ilm0_rdata,
    ilm0_user,
    ilm0_wdata,
    ilm0_we,
    ilm1_addr,
    ilm1_byte_we,
    ilm1_cs,
    ilm1_rdata,
    ilm1_user,
    ilm1_wdata,
    ilm1_we,
    ilm_a_addr,
    ilm_a_data,
    ilm_a_mask,
    ilm_a_opcode,
    ilm_a_parity0,
    ilm_a_parity1,
    ilm_a_ready,
    ilm_a_size,
    ilm_a_user,
    ilm_a_valid,
    ilm_d_denied,
    ilm_d_data,
    ilm_d_parity0,
    ilm_d_parity1,
    ilm_d_ready,
    ilm_d_valid,
    ilm_csr_access,
    ilm_standby_ready,
    lm_clk_en,
    lm_clk,
    lm_reset_n,
    ifu_ilm_a_addr,
    ifu_ilm_a_func,
    ifu_ilm_a_ready,
    ifu_ilm_a_stall,
    ifu_ilm_a_user,
    ifu_ilm_a_valid,
    ifu_ilm_d_data,
    ifu_ilm_d_status,
    ifu_ilm_d_user,
    ifu_ilm_d_valid,
    lsu_ilm_a_addr,
    lsu_ilm_a_func,
    lsu_ilm_a_ready,
    lsu_ilm_a_stall,
    lsu_ilm_a_user,
    lsu_ilm_a_valid,
    lsu_ilm_d_data,
    lsu_ilm_d_status,
    lsu_ilm_d_user,
    lsu_ilm_d_valid,
    lsu_ilm_w_data,
    lsu_ilm_w_mask,
    lsu_ilm_w_ready,
    lsu_ilm_w_status,
    lsu_ilm_w_valid,
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
    slv_ilm_w_valid
);
parameter ILM_ECC_TYPE_INT = 0;
parameter ILM_SIZE_KB = 0;
parameter ILM_RAM_AW = 11;
parameter ILM_RAM_BWEW = 8;
parameter ILM_RAM_DW = 72;
parameter ILM_AMSB = ILM_RAM_AW + 1;
parameter UW = 3;
parameter ILM_WAIT_CYCLE = 1;
localparam BLOCKS = 2;
localparam SB_DEPTH = 4;
input [31:0] csr_mecc_code;
input [1:0] csr_milmb_eccen;
input csr_milmb_rwecc;
output ilm_async_write_error;
output [(ILM_RAM_AW - 1):0] ilm0_addr;
output [(ILM_RAM_BWEW - 1):0] ilm0_byte_we;
output ilm0_cs;
input [(ILM_RAM_DW - 1):0] ilm0_rdata;
output [1:0] ilm0_user;
output [(ILM_RAM_DW - 1):0] ilm0_wdata;
output ilm0_we;
output [(ILM_RAM_AW - 1):0] ilm1_addr;
output [(ILM_RAM_BWEW - 1):0] ilm1_byte_we;
output ilm1_cs;
input [(ILM_RAM_DW - 1):0] ilm1_rdata;
output [1:0] ilm1_user;
output [(ILM_RAM_DW - 1):0] ilm1_wdata;
output ilm1_we;
output ilm_csr_access;
output ilm_standby_ready;
input lm_clk_en;
input lm_clk;
input lm_reset_n;
input [ILM_AMSB:0] ifu_ilm_a_addr;
input [2:0] ifu_ilm_a_func;
output ifu_ilm_a_ready;
input ifu_ilm_a_stall;
input [(UW - 1):0] ifu_ilm_a_user;
input ifu_ilm_a_valid;
output [63:0] ifu_ilm_d_data;
output [13:0] ifu_ilm_d_status;
output [(UW - 1):0] ifu_ilm_d_user;
output ifu_ilm_d_valid;
input [ILM_AMSB:0] lsu_ilm_a_addr;
input [2:0] lsu_ilm_a_func;
output lsu_ilm_a_ready;
input lsu_ilm_a_stall;
input [(UW - 1):0] lsu_ilm_a_user;
input lsu_ilm_a_valid;
output [63:0] lsu_ilm_d_data;
output [13:0] lsu_ilm_d_status;
output [(UW - 1):0] lsu_ilm_d_user;
output lsu_ilm_d_valid;
input [63:0] lsu_ilm_w_data;
input [7:0] lsu_ilm_w_mask;
output lsu_ilm_w_ready;
output lsu_ilm_w_status;
input lsu_ilm_w_valid;
input [ILM_AMSB:0] slv_ilm_a_addr;
input [2:0] slv_ilm_a_func;
input [(BLOCKS - 1):0] slv_ilm_a_mask;
output slv_ilm_a_ready;
input slv_ilm_a_stall;
input [(UW - 1):0] slv_ilm_a_user;
input slv_ilm_a_valid;
output [63:0] slv_ilm_d_data;
output [13:0] slv_ilm_d_status;
output [(UW - 1):0] slv_ilm_d_user;
output slv_ilm_d_valid;
input [63:0] slv_ilm_w_data;
input [7:0] slv_ilm_w_mask;
output slv_ilm_w_ready;
input slv_ilm_w_valid;
output [(ILM_RAM_AW + 2):3] ilm_a_addr;
output [63:0] ilm_a_data;
output [7:0] ilm_a_mask;
output [2:0] ilm_a_opcode;
output [7:0] ilm_a_parity0;
output [7:0] ilm_a_parity1;
input ilm_a_ready;
output [2:0] ilm_a_size;
output [1:0] ilm_a_user;
output ilm_a_valid;
input ilm_d_denied;
input [63:0] ilm_d_data;
input [7:0] ilm_d_parity0;
input [7:0] ilm_d_parity1;
output ilm_d_ready;
input ilm_d_valid;


wire nds_unused_lm_tl_ul = ilm_a_ready | ilm_d_ready | (|ilm_d_data) | (|ilm_d_parity0) | (|ilm_d_parity1) | ilm_d_denied;
assign ilm_a_valid = 1'b0;
assign ilm_a_addr = {ILM_RAM_AW{1'b0}};
assign ilm_a_data = 64'b0;
assign ilm_a_opcode = 3'b0;
assign ilm_a_mask = {8'b0};
assign ilm_a_size = 3'b0;
assign ilm_a_user = 2'b0;
assign ilm_a_parity0 = 8'b0;
assign ilm_a_parity1 = 8'b0;
assign ilm_d_ready = 1'b0;
wire [31:0] nds_unused_csr_mecc_code = csr_mecc_code;
wire [1:0] nds_unused_csr_milmb_eccen = csr_milmb_eccen;
wire nds_unused_csr_milmb_rwecc = csr_milmb_rwecc;
assign ilm_async_write_error = 1'b0;
assign ilm0_addr = {((ILM_RAM_AW - 1) + 1){1'b0}};
assign ilm0_byte_we = {((ILM_RAM_BWEW - 1) + 1){1'b0}};
assign ilm0_cs = 1'b0;
wire [(ILM_RAM_DW - 1):0] s0 = ilm0_rdata;
assign ilm0_user = {2{1'b0}};
assign ilm0_wdata = {((ILM_RAM_DW - 1) + 1){1'b0}};
assign ilm0_we = 1'b0;
assign ilm1_addr = {((ILM_RAM_AW - 1) + 1){1'b0}};
assign ilm1_byte_we = {((ILM_RAM_BWEW - 1) + 1){1'b0}};
assign ilm1_cs = 1'b0;
wire [(ILM_RAM_DW - 1):0] s1 = ilm1_rdata;
assign ilm1_user = {2{1'b0}};
assign ilm1_wdata = {((ILM_RAM_DW - 1) + 1){1'b0}};
assign ilm1_we = 1'b0;
assign ilm_csr_access = 1'b0;
assign ilm_standby_ready = 1'b1;
wire nds_unused_lm_clk_en = lm_clk_en;
wire nds_unused_lm_clk = lm_clk;
wire nds_unused_lm_reset_n = lm_reset_n;
wire [ILM_AMSB:0] nds_unused_ifu_ilm_a_addr = ifu_ilm_a_addr;
wire [2:0] nds_unused_ifu_ilm_a_func = ifu_ilm_a_func;
assign ifu_ilm_a_ready = 1'b0;
wire nds_unused_ifu_ilm_a_stall = ifu_ilm_a_stall;
wire [(UW - 1):0] s2 = ifu_ilm_a_user;
wire nds_unused_ifu_ilm_a_valid = ifu_ilm_a_valid;
assign ifu_ilm_d_data = 64'b0;
assign ifu_ilm_d_status = {14{1'b0}};
assign ifu_ilm_d_user = {((UW - 1) + 1){1'b0}};
assign ifu_ilm_d_valid = 1'b0;
wire [ILM_AMSB:0] nds_unused_lsu_ilm_a_addr = lsu_ilm_a_addr;
wire [2:0] nds_unused_lsu_ilm_a_func = lsu_ilm_a_func;
assign lsu_ilm_a_ready = 1'b0;
wire nds_unused_lsu_ilm_a_stall = lsu_ilm_a_stall;
wire [(UW - 1):0] s3 = lsu_ilm_a_user;
wire nds_unused_lsu_ilm_a_valid = lsu_ilm_a_valid;
assign lsu_ilm_d_data = 64'b0;
assign lsu_ilm_d_status = {14{1'b0}};
assign lsu_ilm_d_user = {((UW - 1) + 1){1'b0}};
assign lsu_ilm_d_valid = 1'b0;
wire [63:0] nds_unused_lsu_ilm_w_data = lsu_ilm_w_data;
wire [7:0] nds_unused_lsu_ilm_w_mask = lsu_ilm_w_mask;
assign lsu_ilm_w_ready = 1'b0;
assign lsu_ilm_w_status = 1'b0;
wire nds_unused_lsu_ilm_w_valid = lsu_ilm_w_valid;
wire [ILM_AMSB:0] nds_unused_slv_ilm_a_addr = slv_ilm_a_addr;
wire [2:0] nds_unused_slv_ilm_a_func = slv_ilm_a_func;
wire [(BLOCKS - 1):0] s4 = slv_ilm_a_mask;
assign slv_ilm_a_ready = 1'b0;
wire nds_unused_slv_ilm_a_stall = slv_ilm_a_stall;
wire [(UW - 1):0] s5 = slv_ilm_a_user;
wire nds_unused_slv_ilm_a_valid = slv_ilm_a_valid;
assign slv_ilm_d_data = 64'b0;
assign slv_ilm_d_status = {14{1'b0}};
assign slv_ilm_d_user = {((UW - 1) + 1){1'b0}};
assign slv_ilm_d_valid = 1'b0;
wire [63:0] nds_unused_slv_ilm_w_data = slv_ilm_w_data;
wire [7:0] nds_unused_slv_ilm_w_mask = slv_ilm_w_mask;
assign slv_ilm_w_ready = 1'b0;
wire nds_unused_slv_ilm_w_valid = slv_ilm_w_valid;
endmodule


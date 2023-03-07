// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lm_stub (
    a_addr,
    a_func,
    a_mask,
    a_ready,
    a_source,
    a_stall,
    a_user,
    a_valid,
    csr_eccen,
    csr_mecc_code_code,
    csr_rwecc,
    d_data,
    d_status,
    d_user,
    d_valid,
    lm_clk_en,
    lm_pfm_event,
    lm_async_write_error,
    lm_standby_ready,
    ram0_addr,
    ram0_byte_we,
    ram0_cs,
    ram0_rdata,
    ram0_user,
    ram0_wdata,
    ram0_we,
    ram1_addr,
    ram1_byte_we,
    ram1_cs,
    ram1_rdata,
    ram1_user,
    ram1_wdata,
    ram1_we,
    lm_a_addr,
    lm_a_data,
    lm_a_mask,
    lm_a_opcode,
    lm_a_parity0,
    lm_a_parity1,
    lm_a_ready,
    lm_a_size,
    lm_a_user,
    lm_a_valid,
    lm_d_denied,
    lm_d_data,
    lm_d_parity0,
    lm_d_parity1,
    lm_d_ready,
    lm_d_valid,
    w_data,
    w_mask,
    w_ready,
    w_valid,
    lm_clk,
    lm_reset_n
);
parameter DW = 32;
parameter BLOCKS = 1;
parameter RAM_AW = 8;
parameter RAM_DW = DW;
parameter RAM_BWEW = DW / 8;
parameter ECC_TYPE_INT = 0;
parameter UW = 1;
parameter SOURCE_BITS = 2;
parameter SB_DEPTH = 6;
input [(RAM_AW - 1):0] a_addr;
input [2:0] a_func;
input [(BLOCKS - 1):0] a_mask;
output a_ready;
input [(SOURCE_BITS - 1):0] a_source;
input a_stall;
input [(UW - 1):0] a_user;
input a_valid;
input [1:0] csr_eccen;
input [7:0] csr_mecc_code_code;
input csr_rwecc;
output [(DW - 1):0] d_data;
output [13:0] d_status;
output [(UW - 1):0] d_user;
output d_valid;
input lm_clk_en;
output lm_pfm_event;
output lm_async_write_error;
output lm_standby_ready;
output [(RAM_AW - 1):0] ram0_addr;
output [(RAM_BWEW - 1):0] ram0_byte_we;
output ram0_cs;
input [(RAM_DW - 1):0] ram0_rdata;
output [(SOURCE_BITS - 1):0] ram0_user;
output [(RAM_DW - 1):0] ram0_wdata;
output ram0_we;
output [(RAM_AW - 1):0] ram1_addr;
output [(RAM_BWEW - 1):0] ram1_byte_we;
output ram1_cs;
input [(RAM_DW - 1):0] ram1_rdata;
output [(SOURCE_BITS - 1):0] ram1_user;
output [(RAM_DW - 1):0] ram1_wdata;
output ram1_we;
input [(DW - 1):0] w_data;
input [DW / 8 - 1:0] w_mask;
output w_ready;
input w_valid;
input lm_clk;
input lm_reset_n;
output [RAM_AW + 2:3] lm_a_addr;
output [(DW - 1):0] lm_a_data;
output [(DW / 8 - 1):0] lm_a_mask;
output [2:0] lm_a_opcode;
output [7:0] lm_a_parity0;
output [7:0] lm_a_parity1;
input lm_a_ready;
output [2:0] lm_a_size;
output [1:0] lm_a_user;
output lm_a_valid;
input lm_d_denied;
input [(DW - 1):0] lm_d_data;
input [7:0] lm_d_parity0;
input [7:0] lm_d_parity1;
output lm_d_ready;
input lm_d_valid;


wire [(RAM_AW - 1):0] s0 = a_addr;
wire [2:0] nds_unused_a_func = a_func;
wire [(BLOCKS - 1):0] s1 = a_mask;
assign a_ready = 1'b0;
wire [(SOURCE_BITS - 1):0] s2 = a_source;
wire nds_unused_a_stall = a_stall;
wire [(UW - 1):0] s3 = a_user;
wire nds_unused_a_valid = a_valid;
wire [1:0] nds_unused_csr_eccen = csr_eccen;
wire [7:0] nds_unused_csr_mecc_code_code = csr_mecc_code_code;
wire nds_unused_csr_rwecc = csr_rwecc;
assign d_data = {((DW - 1) + 1){1'b0}};
assign d_status = {14{1'b0}};
assign d_user = {((UW - 1) + 1){1'b0}};
assign d_valid = 1'b0;
wire nds_unused_lm_clk_en = lm_clk_en;
assign lm_pfm_event = 1'b0;
assign lm_async_write_error = 1'b0;
assign lm_standby_ready = 1'b0;
assign ram0_addr = {((RAM_AW - 1) + 1){1'b0}};
assign ram0_byte_we = {((RAM_BWEW - 1) + 1){1'b0}};
assign ram0_cs = 1'b0;
wire [(RAM_DW - 1):0] s4 = ram0_rdata;
assign ram0_user = {((SOURCE_BITS - 1) + 1){1'b0}};
assign ram0_wdata = {((RAM_DW - 1) + 1){1'b0}};
assign ram0_we = 1'b0;
assign ram1_addr = {((RAM_AW - 1) + 1){1'b0}};
assign ram1_byte_we = {((RAM_BWEW - 1) + 1){1'b0}};
assign ram1_cs = 1'b0;
wire [(RAM_DW - 1):0] s5 = ram1_rdata;
assign ram1_user = {((SOURCE_BITS - 1) + 1){1'b0}};
assign ram1_wdata = {((RAM_DW - 1) + 1){1'b0}};
assign ram1_we = 1'b0;
wire [(DW - 1):0] s6 = w_data;
wire [DW / 8 - 1:0] s7 = w_mask;
assign w_ready = 1'b0;
wire nds_unused_w_valid = w_valid;
wire nds_unused_lm_clk = lm_clk;
wire nds_unused_lm_reset_n = lm_reset_n;
assign lm_a_valid = 1'b0;
assign lm_a_addr = {RAM_AW{1'b0}};
assign lm_a_data = {DW{1'b0}};
assign lm_a_opcode = 3'b0;
assign lm_a_mask = {DW / 8{1'b0}};
assign lm_a_size = 3'b0;
assign lm_a_user = 2'b0;
assign lm_a_parity0 = 8'b0;
assign lm_a_parity1 = 8'b0;
assign lm_d_ready = 1'b0;
wire nds_unused_lm_tl_ul = lm_a_ready | lm_d_ready | (|lm_d_data) | (|lm_d_parity0) | (|lm_d_parity1) | lm_d_denied;
endmodule


// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dlm (
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


wire dlm0_a_ready;
wire [31:0] dlm0_d_data;
wire [13:0] dlm0_d_status;
wire [((UW + 2) - 1):0] dlm0_d_user;
wire dlm0_d_valid;
wire s0;
wire dlm0_w_ready;
wire [7:0] nds_unused_dlm0_a_parity1;
wire [(DLM_RAM_AW - 1):0] s1;
wire [(DLM_RAM_BWEW - 1):0] s2;
wire nds_unused_dlm0_ram1_cs;
wire [(SOURCE_BITS - 1):0] s3;
wire [(DLM_RAM_DW - 1):0] s4;
wire nds_unused_dlm0_ram1_we;
wire s5;
wire [31:0] s6;
wire [13:0] s7;
wire [((UW + 2) - 1):0] s8;
wire s9;
wire s10;
wire s11;
wire [DLM_RAM_AW + 2:3] s12;
wire [31:0] nds_unused_dlm1_a_data;
wire [3:0] nds_unused_dlm1_a_mask;
wire [2:0] nds_unused_dlm1_a_opcode;
wire [7:0] nds_unused_dlm1_a_parity0;
wire [7:0] nds_unused_dlm1_a_parity1;
wire [2:0] nds_unused_dlm1_a_size;
wire [1:0] nds_unused_dlm1_a_user;
wire nds_unused_dlm1_a_valid;
wire nds_unused_dlm1_d_ready;
wire [(DLM_RAM_AW - 1):0] s13;
wire [(DLM_RAM_BWEW - 1):0] s14;
wire nds_unused_dlm1_ram1_cs;
wire [(SOURCE_BITS - 1):0] s15;
wire [(DLM_RAM_DW - 1):0] s16;
wire nds_unused_dlm1_ram1_we;
wire s17;
wire [31:0] s18;
wire [13:0] s19;
wire [((UW + 2) - 1):0] s20;
wire s21;
wire s22;
wire s23;
wire [DLM_RAM_AW + 2:3] s24;
wire [31:0] nds_unused_dlm2_a_data;
wire [3:0] nds_unused_dlm2_a_mask;
wire [2:0] nds_unused_dlm2_a_opcode;
wire [7:0] nds_unused_dlm2_a_parity0;
wire [7:0] nds_unused_dlm2_a_parity1;
wire [2:0] nds_unused_dlm2_a_size;
wire [1:0] nds_unused_dlm2_a_user;
wire nds_unused_dlm2_a_valid;
wire nds_unused_dlm2_d_ready;
wire [(DLM_RAM_AW - 1):0] s25;
wire [(DLM_RAM_BWEW - 1):0] s26;
wire nds_unused_dlm2_ram1_cs;
wire [(SOURCE_BITS - 1):0] s27;
wire [(DLM_RAM_DW - 1):0] s28;
wire nds_unused_dlm2_ram1_we;
wire s29;
wire [31:0] s30;
wire [13:0] s31;
wire [((UW + 2) - 1):0] s32;
wire s33;
wire s34;
wire s35;
wire [DLM_RAM_AW + 2:3] s36;
wire [31:0] nds_unused_dlm3_a_data;
wire [3:0] nds_unused_dlm3_a_mask;
wire [2:0] nds_unused_dlm3_a_opcode;
wire [7:0] nds_unused_dlm3_a_parity0;
wire [7:0] nds_unused_dlm3_a_parity1;
wire [2:0] nds_unused_dlm3_a_size;
wire [1:0] nds_unused_dlm3_a_user;
wire nds_unused_dlm3_a_valid;
wire nds_unused_dlm3_d_ready;
wire [(DLM_RAM_AW - 1):0] s37;
wire [(DLM_RAM_BWEW - 1):0] s38;
wire nds_unused_dlm3_ram1_cs;
wire [(SOURCE_BITS - 1):0] s39;
wire [(DLM_RAM_DW - 1):0] s40;
wire nds_unused_dlm3_ram1_we;
wire [(DLM_RAM_AW - 1):0] dlm0_a_addr;
wire [2:0] dlm0_a_func;
wire [(SOURCE_BITS - 1):0] dlm0_a_source;
wire dlm0_a_stall;
wire [((UW + 2) - 1):0] dlm0_a_user;
wire dlm0_a_valid;
wire [31:0] dlm0_w_data;
wire [3:0] dlm0_w_mask;
wire dlm0_w_valid;
wire [(DLM_RAM_AW - 1):0] s41;
wire [2:0] s42;
wire [(SOURCE_BITS - 1):0] s43;
wire s44;
wire [((UW + 2) - 1):0] s45;
wire s46;
wire [31:0] s47;
wire [3:0] s48;
wire s49;
wire [(DLM_RAM_AW - 1):0] s50;
wire [2:0] s51;
wire [(SOURCE_BITS - 1):0] s52;
wire s53;
wire [((UW + 2) - 1):0] s54;
wire s55;
wire [31:0] s56;
wire [3:0] s57;
wire s58;
wire [(DLM_RAM_AW - 1):0] s59;
wire [2:0] s60;
wire [(SOURCE_BITS - 1):0] s61;
wire s62;
wire [((UW + 2) - 1):0] s63;
wire s64;
wire [31:0] s65;
wire [3:0] s66;
wire s67;
assign dlm_standby_ready = s0 | s10 | s22 | s34;
kv_dlm_arb #(
    .DLM_AMSB(DLM_AMSB),
    .DLM_BANKS(DLM_BANKS),
    .DLM_RAM_AW(DLM_RAM_AW),
    .DLM_RAM_BWEW(DLM_RAM_BWEW),
    .DLM_RAM_DW(DLM_RAM_DW),
    .ECC_TYPE_INT(DLM_ECC_TYPE_INT),
    .SOURCE_BITS(SOURCE_BITS),
    .UW(UW)
) u_dlm_arb0 (
    .lm_clk(lm_clk),
    .lm_reset_n(lm_reset_n),
    .lsu_dlm_a_valid(lsu_dlm0_a_valid),
    .lsu_dlm_a_stall(lsu_dlm0_a_stall),
    .lsu_dlm_a_addr(lsu_dlm0_a_addr),
    .lsu_dlm_a_func(lsu_dlm0_a_func),
    .lsu_dlm_a_user(lsu_dlm0_a_user),
    .lsu_dlm_a_ready(lsu_dlm0_a_ready),
    .lsu_dlm_w_valid(lsu_dlm0_w_valid),
    .lsu_dlm_w_data(lsu_dlm0_w_data),
    .lsu_dlm_w_mask(lsu_dlm0_w_mask),
    .lsu_dlm_w_status(lsu_dlm0_w_status),
    .lsu_dlm_w_ready(lsu_dlm0_w_ready),
    .lsu_dlm_d_valid(lsu_dlm0_d_valid),
    .lsu_dlm_d_data(lsu_dlm0_d_data),
    .lsu_dlm_d_status(lsu_dlm0_d_status),
    .lsu_dlm_d_user(lsu_dlm0_d_user),
    .slv_dlm_a_valid(slv_dlm0_a_valid),
    .slv_dlm_a_stall(slv_dlm0_a_stall),
    .slv_dlm_a_addr(slv_dlm0_a_addr),
    .slv_dlm_a_func(slv_dlm0_a_func),
    .slv_dlm_a_user(slv_dlm0_a_user),
    .slv_dlm_a_ready(slv_dlm0_a_ready),
    .slv_dlm_w_valid(slv_dlm0_w_valid),
    .slv_dlm_w_data(slv_dlm0_w_data),
    .slv_dlm_w_mask(slv_dlm0_w_mask),
    .slv_dlm_w_ready(slv_dlm0_w_ready),
    .slv_dlm_d_valid(slv_dlm0_d_valid),
    .slv_dlm_d_data(slv_dlm0_d_data),
    .slv_dlm_d_status(slv_dlm0_d_status),
    .slv_dlm_d_user(slv_dlm0_d_user),
    .dlm0_a_valid(dlm0_a_valid),
    .dlm0_a_stall(dlm0_a_stall),
    .dlm0_a_addr(dlm0_a_addr),
    .dlm0_a_func(dlm0_a_func),
    .dlm0_a_user(dlm0_a_user),
    .dlm0_a_source(dlm0_a_source),
    .dlm0_a_ready(dlm0_a_ready),
    .dlm0_w_valid(dlm0_w_valid),
    .dlm0_w_data(dlm0_w_data),
    .dlm0_w_mask(dlm0_w_mask),
    .dlm0_w_ready(dlm0_w_ready),
    .dlm0_d_valid(dlm0_d_valid),
    .dlm0_d_data(dlm0_d_data),
    .dlm0_d_status(dlm0_d_status),
    .dlm0_d_user(dlm0_d_user)
);
generate
    if (DLM_BANKS != 1) begin:gen_dlm_arb1
        kv_dlm_arb #(
            .DLM_AMSB(DLM_AMSB),
            .DLM_BANKS(DLM_BANKS),
            .DLM_RAM_AW(DLM_RAM_AW),
            .DLM_RAM_BWEW(DLM_RAM_BWEW),
            .DLM_RAM_DW(DLM_RAM_DW),
            .ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .SOURCE_BITS(SOURCE_BITS),
            .UW(UW)
        ) u_dlm_arb1 (
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .lsu_dlm_a_valid(lsu_dlm1_a_valid),
            .lsu_dlm_a_stall(lsu_dlm1_a_stall),
            .lsu_dlm_a_addr(lsu_dlm1_a_addr),
            .lsu_dlm_a_func(lsu_dlm1_a_func),
            .lsu_dlm_a_user(lsu_dlm1_a_user),
            .lsu_dlm_a_ready(lsu_dlm1_a_ready),
            .lsu_dlm_w_valid(lsu_dlm1_w_valid),
            .lsu_dlm_w_data(lsu_dlm1_w_data),
            .lsu_dlm_w_mask(lsu_dlm1_w_mask),
            .lsu_dlm_w_status(lsu_dlm1_w_status),
            .lsu_dlm_w_ready(lsu_dlm1_w_ready),
            .lsu_dlm_d_valid(lsu_dlm1_d_valid),
            .lsu_dlm_d_data(lsu_dlm1_d_data),
            .lsu_dlm_d_status(lsu_dlm1_d_status),
            .lsu_dlm_d_user(lsu_dlm1_d_user),
            .slv_dlm_a_valid(slv_dlm1_a_valid),
            .slv_dlm_a_stall(slv_dlm1_a_stall),
            .slv_dlm_a_addr(slv_dlm1_a_addr),
            .slv_dlm_a_func(slv_dlm1_a_func),
            .slv_dlm_a_user(slv_dlm1_a_user),
            .slv_dlm_a_ready(slv_dlm1_a_ready),
            .slv_dlm_w_valid(slv_dlm1_w_valid),
            .slv_dlm_w_data(slv_dlm1_w_data),
            .slv_dlm_w_mask(slv_dlm1_w_mask),
            .slv_dlm_w_ready(slv_dlm1_w_ready),
            .slv_dlm_d_valid(slv_dlm1_d_valid),
            .slv_dlm_d_data(slv_dlm1_d_data),
            .slv_dlm_d_status(slv_dlm1_d_status),
            .slv_dlm_d_user(slv_dlm1_d_user),
            .dlm0_a_valid(s46),
            .dlm0_a_stall(s44),
            .dlm0_a_addr(s41),
            .dlm0_a_func(s42),
            .dlm0_a_user(s45),
            .dlm0_a_source(s43),
            .dlm0_a_ready(s5),
            .dlm0_w_valid(s49),
            .dlm0_w_data(s47),
            .dlm0_w_mask(s48),
            .dlm0_w_ready(s11),
            .dlm0_d_valid(s9),
            .dlm0_d_data(s6),
            .dlm0_d_status(s7),
            .dlm0_d_user(s8)
        );
    end
    else begin:gen_dlm_arb1_stub
        kv_dlm_arb_stub #(
            .DLM_AMSB(DLM_AMSB),
            .DLM_BANKS(DLM_BANKS),
            .DLM_RAM_AW(DLM_RAM_AW),
            .DLM_RAM_BWEW(DLM_RAM_BWEW),
            .DLM_RAM_DW(DLM_RAM_DW),
            .ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .SOURCE_BITS(SOURCE_BITS),
            .UW(UW)
        ) u_dlm_arb1_stub (
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .lsu_dlm_a_valid(lsu_dlm1_a_valid),
            .lsu_dlm_a_stall(lsu_dlm1_a_stall),
            .lsu_dlm_a_addr(lsu_dlm1_a_addr),
            .lsu_dlm_a_func(lsu_dlm1_a_func),
            .lsu_dlm_a_user(lsu_dlm1_a_user),
            .lsu_dlm_a_ready(lsu_dlm1_a_ready),
            .lsu_dlm_w_valid(lsu_dlm1_w_valid),
            .lsu_dlm_w_data(lsu_dlm1_w_data),
            .lsu_dlm_w_mask(lsu_dlm1_w_mask),
            .lsu_dlm_w_status(lsu_dlm1_w_status),
            .lsu_dlm_w_ready(lsu_dlm1_w_ready),
            .lsu_dlm_d_valid(lsu_dlm1_d_valid),
            .lsu_dlm_d_data(lsu_dlm1_d_data),
            .lsu_dlm_d_status(lsu_dlm1_d_status),
            .lsu_dlm_d_user(lsu_dlm1_d_user),
            .slv_dlm_a_valid(slv_dlm1_a_valid),
            .slv_dlm_a_stall(slv_dlm1_a_stall),
            .slv_dlm_a_addr(slv_dlm1_a_addr),
            .slv_dlm_a_func(slv_dlm1_a_func),
            .slv_dlm_a_user(slv_dlm1_a_user),
            .slv_dlm_a_ready(slv_dlm1_a_ready),
            .slv_dlm_w_valid(slv_dlm1_w_valid),
            .slv_dlm_w_data(slv_dlm1_w_data),
            .slv_dlm_w_mask(slv_dlm1_w_mask),
            .slv_dlm_w_ready(slv_dlm1_w_ready),
            .slv_dlm_d_valid(slv_dlm1_d_valid),
            .slv_dlm_d_data(slv_dlm1_d_data),
            .slv_dlm_d_status(slv_dlm1_d_status),
            .slv_dlm_d_user(slv_dlm1_d_user),
            .dlm0_a_valid(s46),
            .dlm0_a_stall(s44),
            .dlm0_a_addr(s41),
            .dlm0_a_func(s42),
            .dlm0_a_user(s45),
            .dlm0_a_source(s43),
            .dlm0_a_ready(s5),
            .dlm0_w_valid(s49),
            .dlm0_w_data(s47),
            .dlm0_w_mask(s48),
            .dlm0_w_ready(s11),
            .dlm0_d_valid(s9),
            .dlm0_d_data(s6),
            .dlm0_d_status(s7),
            .dlm0_d_user(s8)
        );
    end
endgenerate
generate
    if (DLM_BANKS == 4) begin:gen_dlm_arb2_arb3
        kv_dlm_arb #(
            .DLM_AMSB(DLM_AMSB),
            .DLM_BANKS(DLM_BANKS),
            .DLM_RAM_AW(DLM_RAM_AW),
            .DLM_RAM_BWEW(DLM_RAM_BWEW),
            .DLM_RAM_DW(DLM_RAM_DW),
            .ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .SOURCE_BITS(SOURCE_BITS),
            .UW(UW)
        ) u_dlm_arb2 (
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .lsu_dlm_a_valid(lsu_dlm2_a_valid),
            .lsu_dlm_a_stall(lsu_dlm2_a_stall),
            .lsu_dlm_a_addr(lsu_dlm2_a_addr),
            .lsu_dlm_a_func(lsu_dlm2_a_func),
            .lsu_dlm_a_user(lsu_dlm2_a_user),
            .lsu_dlm_a_ready(lsu_dlm2_a_ready),
            .lsu_dlm_w_valid(lsu_dlm2_w_valid),
            .lsu_dlm_w_data(lsu_dlm2_w_data),
            .lsu_dlm_w_mask(lsu_dlm2_w_mask),
            .lsu_dlm_w_status(lsu_dlm2_w_status),
            .lsu_dlm_w_ready(lsu_dlm2_w_ready),
            .lsu_dlm_d_valid(lsu_dlm2_d_valid),
            .lsu_dlm_d_data(lsu_dlm2_d_data),
            .lsu_dlm_d_status(lsu_dlm2_d_status),
            .lsu_dlm_d_user(lsu_dlm2_d_user),
            .slv_dlm_a_valid(slv_dlm2_a_valid),
            .slv_dlm_a_stall(slv_dlm2_a_stall),
            .slv_dlm_a_addr(slv_dlm2_a_addr),
            .slv_dlm_a_func(slv_dlm2_a_func),
            .slv_dlm_a_user(slv_dlm2_a_user),
            .slv_dlm_a_ready(slv_dlm2_a_ready),
            .slv_dlm_w_valid(slv_dlm2_w_valid),
            .slv_dlm_w_data(slv_dlm2_w_data),
            .slv_dlm_w_mask(slv_dlm2_w_mask),
            .slv_dlm_w_ready(slv_dlm2_w_ready),
            .slv_dlm_d_valid(slv_dlm2_d_valid),
            .slv_dlm_d_data(slv_dlm2_d_data),
            .slv_dlm_d_status(slv_dlm2_d_status),
            .slv_dlm_d_user(slv_dlm2_d_user),
            .dlm0_a_valid(s55),
            .dlm0_a_stall(s53),
            .dlm0_a_addr(s50),
            .dlm0_a_func(s51),
            .dlm0_a_user(s54),
            .dlm0_a_source(s52),
            .dlm0_a_ready(s17),
            .dlm0_w_valid(s58),
            .dlm0_w_data(s56),
            .dlm0_w_mask(s57),
            .dlm0_w_ready(s23),
            .dlm0_d_valid(s21),
            .dlm0_d_data(s18),
            .dlm0_d_status(s19),
            .dlm0_d_user(s20)
        );
        kv_dlm_arb #(
            .DLM_AMSB(DLM_AMSB),
            .DLM_BANKS(DLM_BANKS),
            .DLM_RAM_AW(DLM_RAM_AW),
            .DLM_RAM_BWEW(DLM_RAM_BWEW),
            .DLM_RAM_DW(DLM_RAM_DW),
            .ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .SOURCE_BITS(SOURCE_BITS),
            .UW(UW)
        ) u_dlm_arb3 (
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .lsu_dlm_a_valid(lsu_dlm3_a_valid),
            .lsu_dlm_a_stall(lsu_dlm3_a_stall),
            .lsu_dlm_a_addr(lsu_dlm3_a_addr),
            .lsu_dlm_a_func(lsu_dlm3_a_func),
            .lsu_dlm_a_user(lsu_dlm3_a_user),
            .lsu_dlm_a_ready(lsu_dlm3_a_ready),
            .lsu_dlm_w_valid(lsu_dlm3_w_valid),
            .lsu_dlm_w_data(lsu_dlm3_w_data),
            .lsu_dlm_w_mask(lsu_dlm3_w_mask),
            .lsu_dlm_w_status(lsu_dlm3_w_status),
            .lsu_dlm_w_ready(lsu_dlm3_w_ready),
            .lsu_dlm_d_valid(lsu_dlm3_d_valid),
            .lsu_dlm_d_data(lsu_dlm3_d_data),
            .lsu_dlm_d_status(lsu_dlm3_d_status),
            .lsu_dlm_d_user(lsu_dlm3_d_user),
            .slv_dlm_a_valid(slv_dlm3_a_valid),
            .slv_dlm_a_stall(slv_dlm3_a_stall),
            .slv_dlm_a_addr(slv_dlm3_a_addr),
            .slv_dlm_a_func(slv_dlm3_a_func),
            .slv_dlm_a_user(slv_dlm3_a_user),
            .slv_dlm_a_ready(slv_dlm3_a_ready),
            .slv_dlm_w_valid(slv_dlm3_w_valid),
            .slv_dlm_w_data(slv_dlm3_w_data),
            .slv_dlm_w_mask(slv_dlm3_w_mask),
            .slv_dlm_w_ready(slv_dlm3_w_ready),
            .slv_dlm_d_valid(slv_dlm3_d_valid),
            .slv_dlm_d_data(slv_dlm3_d_data),
            .slv_dlm_d_status(slv_dlm3_d_status),
            .slv_dlm_d_user(slv_dlm3_d_user),
            .dlm0_a_valid(s64),
            .dlm0_a_stall(s62),
            .dlm0_a_addr(s59),
            .dlm0_a_func(s60),
            .dlm0_a_user(s63),
            .dlm0_a_source(s61),
            .dlm0_a_ready(s29),
            .dlm0_w_valid(s67),
            .dlm0_w_data(s65),
            .dlm0_w_mask(s66),
            .dlm0_w_ready(s35),
            .dlm0_d_valid(s33),
            .dlm0_d_data(s30),
            .dlm0_d_status(s31),
            .dlm0_d_user(s32)
        );
    end
    else begin:gen_dlm_arb2_arb3_stub
        kv_dlm_arb_stub #(
            .DLM_AMSB(DLM_AMSB),
            .DLM_BANKS(DLM_BANKS),
            .DLM_RAM_AW(DLM_RAM_AW),
            .DLM_RAM_BWEW(DLM_RAM_BWEW),
            .DLM_RAM_DW(DLM_RAM_DW),
            .ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .SOURCE_BITS(SOURCE_BITS),
            .UW(UW)
        ) u_dlm_arb2_stub (
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .lsu_dlm_a_valid(lsu_dlm2_a_valid),
            .lsu_dlm_a_stall(lsu_dlm2_a_stall),
            .lsu_dlm_a_addr(lsu_dlm2_a_addr),
            .lsu_dlm_a_func(lsu_dlm2_a_func),
            .lsu_dlm_a_user(lsu_dlm2_a_user),
            .lsu_dlm_a_ready(lsu_dlm2_a_ready),
            .lsu_dlm_w_valid(lsu_dlm2_w_valid),
            .lsu_dlm_w_data(lsu_dlm2_w_data),
            .lsu_dlm_w_mask(lsu_dlm2_w_mask),
            .lsu_dlm_w_status(lsu_dlm2_w_status),
            .lsu_dlm_w_ready(lsu_dlm2_w_ready),
            .lsu_dlm_d_valid(lsu_dlm2_d_valid),
            .lsu_dlm_d_data(lsu_dlm2_d_data),
            .lsu_dlm_d_status(lsu_dlm2_d_status),
            .lsu_dlm_d_user(lsu_dlm2_d_user),
            .slv_dlm_a_valid(slv_dlm2_a_valid),
            .slv_dlm_a_stall(slv_dlm2_a_stall),
            .slv_dlm_a_addr(slv_dlm2_a_addr),
            .slv_dlm_a_func(slv_dlm2_a_func),
            .slv_dlm_a_user(slv_dlm2_a_user),
            .slv_dlm_a_ready(slv_dlm2_a_ready),
            .slv_dlm_w_valid(slv_dlm2_w_valid),
            .slv_dlm_w_data(slv_dlm2_w_data),
            .slv_dlm_w_mask(slv_dlm2_w_mask),
            .slv_dlm_w_ready(slv_dlm2_w_ready),
            .slv_dlm_d_valid(slv_dlm2_d_valid),
            .slv_dlm_d_data(slv_dlm2_d_data),
            .slv_dlm_d_status(slv_dlm2_d_status),
            .slv_dlm_d_user(slv_dlm2_d_user),
            .dlm0_a_valid(s55),
            .dlm0_a_stall(s53),
            .dlm0_a_addr(s50),
            .dlm0_a_func(s51),
            .dlm0_a_user(s54),
            .dlm0_a_source(s52),
            .dlm0_a_ready(s17),
            .dlm0_w_valid(s58),
            .dlm0_w_data(s56),
            .dlm0_w_mask(s57),
            .dlm0_w_ready(s23),
            .dlm0_d_valid(s21),
            .dlm0_d_data(s18),
            .dlm0_d_status(s19),
            .dlm0_d_user(s20)
        );
        kv_dlm_arb_stub #(
            .DLM_AMSB(DLM_AMSB),
            .DLM_BANKS(DLM_BANKS),
            .DLM_RAM_AW(DLM_RAM_AW),
            .DLM_RAM_BWEW(DLM_RAM_BWEW),
            .DLM_RAM_DW(DLM_RAM_DW),
            .ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .SOURCE_BITS(SOURCE_BITS),
            .UW(UW)
        ) u_dlm_arb3_stub (
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .lsu_dlm_a_valid(lsu_dlm3_a_valid),
            .lsu_dlm_a_stall(lsu_dlm3_a_stall),
            .lsu_dlm_a_addr(lsu_dlm3_a_addr),
            .lsu_dlm_a_func(lsu_dlm3_a_func),
            .lsu_dlm_a_user(lsu_dlm3_a_user),
            .lsu_dlm_a_ready(lsu_dlm3_a_ready),
            .lsu_dlm_w_valid(lsu_dlm3_w_valid),
            .lsu_dlm_w_data(lsu_dlm3_w_data),
            .lsu_dlm_w_mask(lsu_dlm3_w_mask),
            .lsu_dlm_w_status(lsu_dlm3_w_status),
            .lsu_dlm_w_ready(lsu_dlm3_w_ready),
            .lsu_dlm_d_valid(lsu_dlm3_d_valid),
            .lsu_dlm_d_data(lsu_dlm3_d_data),
            .lsu_dlm_d_status(lsu_dlm3_d_status),
            .lsu_dlm_d_user(lsu_dlm3_d_user),
            .slv_dlm_a_valid(slv_dlm3_a_valid),
            .slv_dlm_a_stall(slv_dlm3_a_stall),
            .slv_dlm_a_addr(slv_dlm3_a_addr),
            .slv_dlm_a_func(slv_dlm3_a_func),
            .slv_dlm_a_user(slv_dlm3_a_user),
            .slv_dlm_a_ready(slv_dlm3_a_ready),
            .slv_dlm_w_valid(slv_dlm3_w_valid),
            .slv_dlm_w_data(slv_dlm3_w_data),
            .slv_dlm_w_mask(slv_dlm3_w_mask),
            .slv_dlm_w_ready(slv_dlm3_w_ready),
            .slv_dlm_d_valid(slv_dlm3_d_valid),
            .slv_dlm_d_data(slv_dlm3_d_data),
            .slv_dlm_d_status(slv_dlm3_d_status),
            .slv_dlm_d_user(slv_dlm3_d_user),
            .dlm0_a_valid(s64),
            .dlm0_a_stall(s62),
            .dlm0_a_addr(s59),
            .dlm0_a_func(s60),
            .dlm0_a_user(s63),
            .dlm0_a_source(s61),
            .dlm0_a_ready(s29),
            .dlm0_w_valid(s67),
            .dlm0_w_data(s65),
            .dlm0_w_mask(s66),
            .dlm0_w_ready(s35),
            .dlm0_d_valid(s33),
            .dlm0_d_data(s30),
            .dlm0_d_status(s31),
            .dlm0_d_user(s32)
        );
    end
endgenerate
kv_lm #(
    .BLOCKS(1),
    .DW(32),
    .ECC_TYPE_INT(DLM_ECC_TYPE_INT),
    .LM_WAIT_CYCLE(DLM_WAIT_CYCLE),
    .RAM_AW(DLM_RAM_AW),
    .RAM_BWEW(DLM_RAM_BWEW),
    .RAM_DW(DLM_RAM_DW),
    .SB_DEPTH(SB_DEPTH),
    .SOURCE_BITS(SOURCE_BITS),
    .UW(UW + 2)
) u_dlm0 (
    .ram0_addr(dlm_addr),
    .ram0_byte_we(dlm_byte_we),
    .ram0_cs(dlm_cs),
    .ram0_rdata(dlm_rdata),
    .ram0_user(dlm_user),
    .ram0_wdata(dlm_wdata),
    .ram0_we(dlm_we),
    .ram1_addr(s1),
    .ram1_byte_we(s2),
    .ram1_cs(nds_unused_dlm0_ram1_cs),
    .ram1_rdata({DLM_RAM_DW{1'b0}}),
    .ram1_user(s3),
    .ram1_wdata(s4),
    .ram1_we(nds_unused_dlm0_ram1_we),
    .lm_clk(lm_clk),
    .lm_reset_n(lm_reset_n),
    .a_addr(dlm0_a_addr),
    .a_func(dlm0_a_func),
    .a_mask(1'b1),
    .a_ready(dlm0_a_ready),
    .a_source(dlm0_a_source),
    .a_stall(dlm0_a_stall),
    .a_user(dlm0_a_user),
    .a_valid(dlm0_a_valid),
    .csr_eccen(csr_mdlmb_eccen),
    .csr_mecc_code_code(csr_mecc_code[7:0]),
    .csr_rwecc(csr_mdlmb_rwecc),
    .d_data(dlm0_d_data),
    .d_status(dlm0_d_status),
    .d_user(dlm0_d_user),
    .d_valid(dlm0_d_valid),
    .lm_async_write_error(dlm0_async_write_error),
    .lm_clk_en(lm_clk_en),
    .lm_pfm_event(dlm_csr_access0),
    .lm_standby_ready(s0),
    .w_data(dlm0_w_data),
    .w_mask(dlm0_w_mask),
    .w_ready(dlm0_w_ready),
    .w_valid(dlm0_w_valid),
    .lm_a_addr(dlm_a_addr),
    .lm_a_data(dlm_a_data),
    .lm_a_mask(dlm_a_mask),
    .lm_a_opcode(dlm_a_opcode),
    .lm_a_parity0(dlm_a_parity),
    .lm_a_parity1(nds_unused_dlm0_a_parity1),
    .lm_a_ready(dlm_a_ready),
    .lm_a_size(dlm_a_size),
    .lm_a_user(dlm_a_user),
    .lm_a_valid(dlm_a_valid),
    .lm_d_data(dlm_d_data),
    .lm_d_denied(dlm_d_denied),
    .lm_d_parity0(dlm_d_parity),
    .lm_d_parity1(8'b0),
    .lm_d_ready(dlm_d_ready),
    .lm_d_valid(dlm_d_valid)
);
generate
    if (DLM_BANKS != 1) begin:gen_u_dlm1
        kv_lm #(
            .BLOCKS(1),
            .DW(32),
            .ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .LM_WAIT_CYCLE(0),
            .RAM_AW(DLM_RAM_AW),
            .RAM_BWEW(DLM_RAM_BWEW),
            .RAM_DW(DLM_RAM_DW),
            .SB_DEPTH(SB_DEPTH),
            .SOURCE_BITS(SOURCE_BITS),
            .UW(UW + 2)
        ) u_dlm1 (
            .ram0_addr(dlm1_addr),
            .ram0_byte_we(dlm1_byte_we),
            .ram0_cs(dlm1_cs),
            .ram0_rdata(dlm1_rdata),
            .ram0_user(dlm1_user),
            .ram0_wdata(dlm1_wdata),
            .ram0_we(dlm1_we),
            .ram1_addr(s13),
            .ram1_byte_we(s14),
            .ram1_cs(nds_unused_dlm1_ram1_cs),
            .ram1_rdata({DLM_RAM_DW{1'b0}}),
            .ram1_user(s15),
            .ram1_wdata(s16),
            .ram1_we(nds_unused_dlm1_ram1_we),
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .a_addr(s41),
            .a_func(s42),
            .a_mask(1'b1),
            .a_ready(s5),
            .a_source(s43),
            .a_stall(s44),
            .a_user(s45),
            .a_valid(s46),
            .csr_eccen(csr_mdlmb_eccen),
            .csr_mecc_code_code(csr_mecc_code[7:0]),
            .csr_rwecc(csr_mdlmb_rwecc),
            .d_data(s6),
            .d_status(s7),
            .d_user(s8),
            .d_valid(s9),
            .lm_async_write_error(dlm1_async_write_error),
            .lm_clk_en(lm_clk_en),
            .lm_pfm_event(dlm_csr_access1),
            .lm_standby_ready(s10),
            .w_data(s47),
            .w_mask(s48),
            .w_ready(s11),
            .w_valid(s49),
            .lm_a_addr(s12),
            .lm_a_data(nds_unused_dlm1_a_data),
            .lm_a_mask(nds_unused_dlm1_a_mask),
            .lm_a_opcode(nds_unused_dlm1_a_opcode),
            .lm_a_parity0(nds_unused_dlm1_a_parity0),
            .lm_a_parity1(nds_unused_dlm1_a_parity1),
            .lm_a_ready(1'b1),
            .lm_a_size(nds_unused_dlm1_a_size),
            .lm_a_user(nds_unused_dlm1_a_user),
            .lm_a_valid(nds_unused_dlm1_a_valid),
            .lm_d_data({32{1'b0}}),
            .lm_d_denied(1'b0),
            .lm_d_parity0(8'b0),
            .lm_d_parity1(8'b0),
            .lm_d_ready(nds_unused_dlm1_d_ready),
            .lm_d_valid(1'b0)
        );
    end
    else begin:gen_u_dlm1_stub
        kv_lm_stub #(
            .BLOCKS(1),
            .DW(32),
            .ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .RAM_AW(DLM_RAM_AW),
            .RAM_BWEW(DLM_RAM_BWEW),
            .RAM_DW(DLM_RAM_DW),
            .SB_DEPTH(SB_DEPTH),
            .SOURCE_BITS(SOURCE_BITS),
            .UW(UW + 2)
        ) u_dlm1_stub (
            .a_addr(s41),
            .a_func(s42),
            .a_mask(1'b1),
            .a_ready(s5),
            .a_source(s43),
            .a_stall(s44),
            .a_user(s45),
            .a_valid(s46),
            .csr_eccen(csr_mdlmb_eccen),
            .csr_mecc_code_code(csr_mecc_code[7:0]),
            .csr_rwecc(csr_mdlmb_rwecc),
            .d_data(s6),
            .d_status(s7),
            .d_user(s8),
            .d_valid(s9),
            .lm_clk_en(lm_clk_en),
            .lm_pfm_event(dlm_csr_access1),
            .lm_async_write_error(dlm1_async_write_error),
            .lm_standby_ready(s10),
            .ram0_addr(dlm1_addr),
            .ram0_byte_we(dlm1_byte_we),
            .ram0_cs(dlm1_cs),
            .ram0_rdata(dlm1_rdata),
            .ram0_user(dlm1_user),
            .ram0_wdata(dlm1_wdata),
            .ram0_we(dlm1_we),
            .ram1_addr(s13),
            .ram1_byte_we(s14),
            .ram1_cs(nds_unused_dlm1_ram1_cs),
            .ram1_rdata({DLM_RAM_DW{1'b0}}),
            .ram1_user(s15),
            .ram1_wdata(s16),
            .ram1_we(nds_unused_dlm1_ram1_we),
            .w_data(s47),
            .w_mask(s48),
            .w_ready(s11),
            .w_valid(s49),
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .lm_a_addr(s12),
            .lm_a_data(nds_unused_dlm1_a_data),
            .lm_a_mask(nds_unused_dlm1_a_mask),
            .lm_a_opcode(nds_unused_dlm1_a_opcode),
            .lm_a_parity0(nds_unused_dlm1_a_parity0),
            .lm_a_parity1(nds_unused_dlm1_a_parity1),
            .lm_a_ready(1'b1),
            .lm_a_size(nds_unused_dlm1_a_size),
            .lm_a_user(nds_unused_dlm1_a_user),
            .lm_a_valid(nds_unused_dlm1_a_valid),
            .lm_d_denied(1'b0),
            .lm_d_data({32{1'b0}}),
            .lm_d_parity0(8'b0),
            .lm_d_parity1(8'b0),
            .lm_d_ready(nds_unused_dlm1_d_ready),
            .lm_d_valid(1'b0)
        );
    end
endgenerate
generate
    if (DLM_BANKS == 4) begin:gen_u_dlm2_dlm3
        kv_lm #(
            .BLOCKS(1),
            .DW(32),
            .ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .LM_WAIT_CYCLE(0),
            .RAM_AW(DLM_RAM_AW),
            .RAM_BWEW(DLM_RAM_BWEW),
            .RAM_DW(DLM_RAM_DW),
            .SB_DEPTH(SB_DEPTH),
            .SOURCE_BITS(SOURCE_BITS),
            .UW(UW + 2)
        ) u_dlm2 (
            .ram0_addr(dlm2_addr),
            .ram0_byte_we(dlm2_byte_we),
            .ram0_cs(dlm2_cs),
            .ram0_rdata(dlm2_rdata),
            .ram0_user(dlm2_user),
            .ram0_wdata(dlm2_wdata),
            .ram0_we(dlm2_we),
            .ram1_addr(s25),
            .ram1_byte_we(s26),
            .ram1_cs(nds_unused_dlm2_ram1_cs),
            .ram1_rdata({DLM_RAM_DW{1'b0}}),
            .ram1_user(s27),
            .ram1_wdata(s28),
            .ram1_we(nds_unused_dlm2_ram1_we),
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .a_addr(s50),
            .a_func(s51),
            .a_mask(1'b1),
            .a_ready(s17),
            .a_source(s52),
            .a_stall(s53),
            .a_user(s54),
            .a_valid(s55),
            .csr_eccen(csr_mdlmb_eccen),
            .csr_mecc_code_code(csr_mecc_code[7:0]),
            .csr_rwecc(csr_mdlmb_rwecc),
            .d_data(s18),
            .d_status(s19),
            .d_user(s20),
            .d_valid(s21),
            .lm_async_write_error(dlm2_async_write_error),
            .lm_clk_en(lm_clk_en),
            .lm_pfm_event(dlm_csr_access2),
            .lm_standby_ready(s22),
            .w_data(s56),
            .w_mask(s57),
            .w_ready(s23),
            .w_valid(s58),
            .lm_a_addr(s24),
            .lm_a_data(nds_unused_dlm2_a_data),
            .lm_a_mask(nds_unused_dlm2_a_mask),
            .lm_a_opcode(nds_unused_dlm2_a_opcode),
            .lm_a_parity0(nds_unused_dlm2_a_parity0),
            .lm_a_parity1(nds_unused_dlm2_a_parity1),
            .lm_a_ready(1'b1),
            .lm_a_size(nds_unused_dlm2_a_size),
            .lm_a_user(nds_unused_dlm2_a_user),
            .lm_a_valid(nds_unused_dlm2_a_valid),
            .lm_d_data({32{1'b0}}),
            .lm_d_denied(1'b0),
            .lm_d_parity0(8'b0),
            .lm_d_parity1(8'b0),
            .lm_d_ready(nds_unused_dlm2_d_ready),
            .lm_d_valid(1'b0)
        );
        kv_lm #(
            .BLOCKS(1),
            .DW(32),
            .ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .LM_WAIT_CYCLE(0),
            .RAM_AW(DLM_RAM_AW),
            .RAM_BWEW(DLM_RAM_BWEW),
            .RAM_DW(DLM_RAM_DW),
            .SB_DEPTH(SB_DEPTH),
            .SOURCE_BITS(SOURCE_BITS),
            .UW(UW + 2)
        ) u_dlm3 (
            .ram0_addr(dlm3_addr),
            .ram0_byte_we(dlm3_byte_we),
            .ram0_cs(dlm3_cs),
            .ram0_rdata(dlm3_rdata),
            .ram0_user(dlm3_user),
            .ram0_wdata(dlm3_wdata),
            .ram0_we(dlm3_we),
            .ram1_addr(s37),
            .ram1_byte_we(s38),
            .ram1_cs(nds_unused_dlm3_ram1_cs),
            .ram1_rdata({DLM_RAM_DW{1'b0}}),
            .ram1_user(s39),
            .ram1_wdata(s40),
            .ram1_we(nds_unused_dlm3_ram1_we),
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .a_addr(s59),
            .a_func(s60),
            .a_mask(1'b1),
            .a_ready(s29),
            .a_source(s61),
            .a_stall(s62),
            .a_user(s63),
            .a_valid(s64),
            .csr_eccen(csr_mdlmb_eccen),
            .csr_mecc_code_code(csr_mecc_code[7:0]),
            .csr_rwecc(csr_mdlmb_rwecc),
            .d_data(s30),
            .d_status(s31),
            .d_user(s32),
            .d_valid(s33),
            .lm_async_write_error(dlm3_async_write_error),
            .lm_clk_en(lm_clk_en),
            .lm_pfm_event(dlm_csr_access3),
            .lm_standby_ready(s34),
            .w_data(s65),
            .w_mask(s66),
            .w_ready(s35),
            .w_valid(s67),
            .lm_a_addr(s36),
            .lm_a_data(nds_unused_dlm3_a_data),
            .lm_a_mask(nds_unused_dlm3_a_mask),
            .lm_a_opcode(nds_unused_dlm3_a_opcode),
            .lm_a_parity0(nds_unused_dlm3_a_parity0),
            .lm_a_parity1(nds_unused_dlm3_a_parity1),
            .lm_a_ready(1'b1),
            .lm_a_size(nds_unused_dlm3_a_size),
            .lm_a_user(nds_unused_dlm3_a_user),
            .lm_a_valid(nds_unused_dlm3_a_valid),
            .lm_d_data({32{1'b0}}),
            .lm_d_denied(1'b0),
            .lm_d_parity0(8'b0),
            .lm_d_parity1(8'b0),
            .lm_d_ready(nds_unused_dlm3_d_ready),
            .lm_d_valid(1'b0)
        );
    end
    else begin:gen_u_dlm2_dlm3_stub
        kv_lm_stub #(
            .BLOCKS(1),
            .DW(32),
            .ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .RAM_AW(DLM_RAM_AW),
            .RAM_BWEW(DLM_RAM_BWEW),
            .RAM_DW(DLM_RAM_DW),
            .SB_DEPTH(SB_DEPTH),
            .SOURCE_BITS(SOURCE_BITS),
            .UW(UW + 2)
        ) u_dlm2_stub (
            .a_addr(s50),
            .a_func(s51),
            .a_mask(1'b1),
            .a_ready(s17),
            .a_source(s52),
            .a_stall(s53),
            .a_user(s54),
            .a_valid(s55),
            .csr_eccen(csr_mdlmb_eccen),
            .csr_mecc_code_code(csr_mecc_code[7:0]),
            .csr_rwecc(csr_mdlmb_rwecc),
            .d_data(s18),
            .d_status(s19),
            .d_user(s20),
            .d_valid(s21),
            .lm_clk_en(lm_clk_en),
            .lm_pfm_event(dlm_csr_access2),
            .lm_async_write_error(dlm2_async_write_error),
            .lm_standby_ready(s22),
            .ram0_addr(dlm2_addr),
            .ram0_byte_we(dlm2_byte_we),
            .ram0_cs(dlm2_cs),
            .ram0_rdata(dlm2_rdata),
            .ram0_user(dlm2_user),
            .ram0_wdata(dlm2_wdata),
            .ram0_we(dlm2_we),
            .ram1_addr(s25),
            .ram1_byte_we(s26),
            .ram1_cs(nds_unused_dlm2_ram1_cs),
            .ram1_rdata({DLM_RAM_DW{1'b0}}),
            .ram1_user(s27),
            .ram1_wdata(s28),
            .ram1_we(nds_unused_dlm2_ram1_we),
            .w_data(s56),
            .w_mask(s57),
            .w_ready(s23),
            .w_valid(s58),
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .lm_a_addr(s24),
            .lm_a_data(nds_unused_dlm2_a_data),
            .lm_a_mask(nds_unused_dlm2_a_mask),
            .lm_a_opcode(nds_unused_dlm2_a_opcode),
            .lm_a_parity0(nds_unused_dlm2_a_parity0),
            .lm_a_parity1(nds_unused_dlm2_a_parity1),
            .lm_a_ready(1'b1),
            .lm_a_size(nds_unused_dlm2_a_size),
            .lm_a_user(nds_unused_dlm2_a_user),
            .lm_a_valid(nds_unused_dlm2_a_valid),
            .lm_d_denied(1'b0),
            .lm_d_data({32{1'b0}}),
            .lm_d_parity0(8'b0),
            .lm_d_parity1(8'b0),
            .lm_d_ready(nds_unused_dlm2_d_ready),
            .lm_d_valid(1'b0)
        );
        kv_lm_stub #(
            .BLOCKS(1),
            .DW(32),
            .ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .RAM_AW(DLM_RAM_AW),
            .RAM_BWEW(DLM_RAM_BWEW),
            .RAM_DW(DLM_RAM_DW),
            .SB_DEPTH(SB_DEPTH),
            .SOURCE_BITS(SOURCE_BITS),
            .UW(UW + 2)
        ) u_dlm3_stub (
            .a_addr(s59),
            .a_func(s60),
            .a_mask(1'b1),
            .a_ready(s29),
            .a_source(s61),
            .a_stall(s62),
            .a_user(s63),
            .a_valid(s64),
            .csr_eccen(csr_mdlmb_eccen),
            .csr_mecc_code_code(csr_mecc_code[7:0]),
            .csr_rwecc(csr_mdlmb_rwecc),
            .d_data(s30),
            .d_status(s31),
            .d_user(s32),
            .d_valid(s33),
            .lm_clk_en(lm_clk_en),
            .lm_pfm_event(dlm_csr_access3),
            .lm_async_write_error(dlm3_async_write_error),
            .lm_standby_ready(s34),
            .ram0_addr(dlm3_addr),
            .ram0_byte_we(dlm3_byte_we),
            .ram0_cs(dlm3_cs),
            .ram0_rdata(dlm3_rdata),
            .ram0_user(dlm3_user),
            .ram0_wdata(dlm3_wdata),
            .ram0_we(dlm3_we),
            .ram1_addr(s37),
            .ram1_byte_we(s38),
            .ram1_cs(nds_unused_dlm3_ram1_cs),
            .ram1_rdata({DLM_RAM_DW{1'b0}}),
            .ram1_user(s39),
            .ram1_wdata(s40),
            .ram1_we(nds_unused_dlm3_ram1_we),
            .w_data(s65),
            .w_mask(s66),
            .w_ready(s35),
            .w_valid(s67),
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .lm_a_addr(s36),
            .lm_a_data(nds_unused_dlm3_a_data),
            .lm_a_mask(nds_unused_dlm3_a_mask),
            .lm_a_opcode(nds_unused_dlm3_a_opcode),
            .lm_a_parity0(nds_unused_dlm3_a_parity0),
            .lm_a_parity1(nds_unused_dlm3_a_parity1),
            .lm_a_ready(1'b1),
            .lm_a_size(nds_unused_dlm3_a_size),
            .lm_a_user(nds_unused_dlm3_a_user),
            .lm_a_valid(nds_unused_dlm3_a_valid),
            .lm_d_denied(1'b0),
            .lm_d_data({32{1'b0}}),
            .lm_d_parity0(8'b0),
            .lm_d_parity1(8'b0),
            .lm_d_ready(nds_unused_dlm3_d_ready),
            .lm_d_valid(1'b0)
        );
    end
endgenerate
endmodule


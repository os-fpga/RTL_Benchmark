// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_ilm (
    csr_mecc_code,
    csr_milmb_eccen,
    csr_milmb_rwecc,
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
    ilm_async_write_error,
    ilm_csr_access,
    ilm_d_data,
    ilm_d_denied,
    ilm_d_parity0,
    ilm_d_parity1,
    ilm_d_ready,
    ilm_d_valid,
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
parameter ILM_WAIT_CYCLE = 1;
parameter ILM_AMSB = ILM_RAM_AW + 1;
parameter UW = 3;
localparam BLOCKS = 2;
localparam SB_DEPTH = 4;
localparam SOURCE_BITS = 2;
input [31:0] csr_mecc_code;
input [1:0] csr_milmb_eccen;
input csr_milmb_rwecc;
output [(ILM_RAM_AW - 1):0] ilm0_addr;
output [(ILM_RAM_BWEW - 1):0] ilm0_byte_we;
output ilm0_cs;
input [(ILM_RAM_DW - 1):0] ilm0_rdata;
output [(SOURCE_BITS - 1):0] ilm0_user;
output [(ILM_RAM_DW - 1):0] ilm0_wdata;
output ilm0_we;
output [(ILM_RAM_AW - 1):0] ilm1_addr;
output [(ILM_RAM_BWEW - 1):0] ilm1_byte_we;
output ilm1_cs;
input [(ILM_RAM_DW - 1):0] ilm1_rdata;
output [(SOURCE_BITS - 1):0] ilm1_user;
output [(ILM_RAM_DW - 1):0] ilm1_wdata;
output ilm1_we;
output [ILM_RAM_AW + 2:3] ilm_a_addr;
output [63:0] ilm_a_data;
output [7:0] ilm_a_mask;
output [2:0] ilm_a_opcode;
output [7:0] ilm_a_parity0;
output [7:0] ilm_a_parity1;
input ilm_a_ready;
output [2:0] ilm_a_size;
output [1:0] ilm_a_user;
output ilm_a_valid;
output ilm_async_write_error;
output ilm_csr_access;
input [63:0] ilm_d_data;
input ilm_d_denied;
input [7:0] ilm_d_parity0;
input [7:0] ilm_d_parity1;
output ilm_d_ready;
input ilm_d_valid;
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


wire ilm0_a_ready;
wire [63:0] ilm0_d_data;
wire [13:0] ilm0_d_status;
wire [UW + 2:0] ilm0_d_user;
wire ilm0_d_valid;
wire ilm0_w_ready;
wire [(ILM_RAM_AW - 1):0] ilm0_a_addr;
wire [2:0] ilm0_a_func;
wire [(BLOCKS - 1):0] ilm0_a_mask;
wire [(SOURCE_BITS - 1):0] ilm0_a_source;
wire ilm0_a_stall;
wire [UW + 2:0] ilm0_a_user;
wire ilm0_a_valid;
wire [63:0] ilm0_w_data;
wire [7:0] ilm0_w_mask;
wire ilm0_w_valid;
kv_ilm_arb #(
    .BLOCKS(BLOCKS),
    .ECC_TYPE_INT(ILM_ECC_TYPE_INT),
    .ILM_AMSB(ILM_AMSB),
    .ILM_RAM_AW(ILM_RAM_AW),
    .ILM_RAM_BWEW(ILM_RAM_BWEW),
    .ILM_RAM_DW(ILM_RAM_DW),
    .SOURCE_BITS(SOURCE_BITS),
    .UW(UW)
) u_ilm_arb (
    .lm_clk(lm_clk),
    .lm_reset_n(lm_reset_n),
    .lsu_ilm_a_valid(lsu_ilm_a_valid),
    .lsu_ilm_a_stall(lsu_ilm_a_stall),
    .lsu_ilm_a_addr(lsu_ilm_a_addr),
    .lsu_ilm_a_func(lsu_ilm_a_func),
    .lsu_ilm_a_user(lsu_ilm_a_user),
    .lsu_ilm_a_ready(lsu_ilm_a_ready),
    .lsu_ilm_w_valid(lsu_ilm_w_valid),
    .lsu_ilm_w_data(lsu_ilm_w_data),
    .lsu_ilm_w_mask(lsu_ilm_w_mask),
    .lsu_ilm_w_ready(lsu_ilm_w_ready),
    .lsu_ilm_w_status(lsu_ilm_w_status),
    .lsu_ilm_d_valid(lsu_ilm_d_valid),
    .lsu_ilm_d_data(lsu_ilm_d_data),
    .lsu_ilm_d_status(lsu_ilm_d_status),
    .lsu_ilm_d_user(lsu_ilm_d_user),
    .ifu_ilm_a_valid(ifu_ilm_a_valid),
    .ifu_ilm_a_stall(ifu_ilm_a_stall),
    .ifu_ilm_a_addr(ifu_ilm_a_addr),
    .ifu_ilm_a_func(ifu_ilm_a_func),
    .ifu_ilm_a_user(ifu_ilm_a_user),
    .ifu_ilm_a_ready(ifu_ilm_a_ready),
    .ifu_ilm_d_valid(ifu_ilm_d_valid),
    .ifu_ilm_d_data(ifu_ilm_d_data),
    .ifu_ilm_d_status(ifu_ilm_d_status),
    .ifu_ilm_d_user(ifu_ilm_d_user),
    .slv_ilm_a_valid(slv_ilm_a_valid),
    .slv_ilm_a_stall(slv_ilm_a_stall),
    .slv_ilm_a_addr(slv_ilm_a_addr),
    .slv_ilm_a_mask(slv_ilm_a_mask),
    .slv_ilm_a_func(slv_ilm_a_func),
    .slv_ilm_a_user(slv_ilm_a_user),
    .slv_ilm_a_ready(slv_ilm_a_ready),
    .slv_ilm_w_valid(slv_ilm_w_valid),
    .slv_ilm_w_data(slv_ilm_w_data),
    .slv_ilm_w_mask(slv_ilm_w_mask),
    .slv_ilm_w_ready(slv_ilm_w_ready),
    .slv_ilm_d_valid(slv_ilm_d_valid),
    .slv_ilm_d_data(slv_ilm_d_data),
    .slv_ilm_d_status(slv_ilm_d_status),
    .slv_ilm_d_user(slv_ilm_d_user),
    .ilm0_a_valid(ilm0_a_valid),
    .ilm0_a_stall(ilm0_a_stall),
    .ilm0_a_addr(ilm0_a_addr),
    .ilm0_a_mask(ilm0_a_mask),
    .ilm0_a_func(ilm0_a_func),
    .ilm0_a_user(ilm0_a_user),
    .ilm0_a_source(ilm0_a_source),
    .ilm0_a_ready(ilm0_a_ready),
    .ilm0_w_valid(ilm0_w_valid),
    .ilm0_w_data(ilm0_w_data),
    .ilm0_w_mask(ilm0_w_mask),
    .ilm0_w_ready(ilm0_w_ready),
    .ilm0_d_valid(ilm0_d_valid),
    .ilm0_d_data(ilm0_d_data),
    .ilm0_d_status(ilm0_d_status),
    .ilm0_d_user(ilm0_d_user)
);
kv_lm #(
    .BLOCKS(BLOCKS),
    .DW(64),
    .ECC_TYPE_INT(ILM_ECC_TYPE_INT),
    .LM_WAIT_CYCLE(ILM_WAIT_CYCLE),
    .RAM_AW(ILM_RAM_AW),
    .RAM_BWEW(ILM_RAM_BWEW),
    .RAM_DW(ILM_RAM_DW),
    .SB_DEPTH(SB_DEPTH),
    .SOURCE_BITS(SOURCE_BITS),
    .UW(UW + 3)
) u_ilm0 (
    .ram0_addr(ilm0_addr),
    .ram0_byte_we(ilm0_byte_we),
    .ram0_cs(ilm0_cs),
    .ram0_rdata(ilm0_rdata),
    .ram0_user(ilm0_user),
    .ram0_wdata(ilm0_wdata),
    .ram0_we(ilm0_we),
    .ram1_addr(ilm1_addr),
    .ram1_byte_we(ilm1_byte_we),
    .ram1_cs(ilm1_cs),
    .ram1_rdata(ilm1_rdata),
    .ram1_user(ilm1_user),
    .ram1_wdata(ilm1_wdata),
    .ram1_we(ilm1_we),
    .lm_clk(lm_clk),
    .lm_reset_n(lm_reset_n),
    .a_addr(ilm0_a_addr),
    .a_func(ilm0_a_func),
    .a_mask(ilm0_a_mask),
    .a_ready(ilm0_a_ready),
    .a_source(ilm0_a_source),
    .a_stall(ilm0_a_stall),
    .a_user(ilm0_a_user),
    .a_valid(ilm0_a_valid),
    .csr_eccen(csr_milmb_eccen),
    .csr_mecc_code_code(csr_mecc_code[7:0]),
    .csr_rwecc(csr_milmb_rwecc),
    .d_data(ilm0_d_data),
    .d_status(ilm0_d_status),
    .d_user(ilm0_d_user),
    .d_valid(ilm0_d_valid),
    .lm_async_write_error(ilm_async_write_error),
    .lm_clk_en(lm_clk_en),
    .lm_pfm_event(ilm_csr_access),
    .lm_standby_ready(ilm_standby_ready),
    .w_data(ilm0_w_data),
    .w_mask(ilm0_w_mask),
    .w_ready(ilm0_w_ready),
    .w_valid(ilm0_w_valid),
    .lm_a_addr(ilm_a_addr),
    .lm_a_data(ilm_a_data),
    .lm_a_mask(ilm_a_mask),
    .lm_a_opcode(ilm_a_opcode),
    .lm_a_parity0(ilm_a_parity0),
    .lm_a_parity1(ilm_a_parity1),
    .lm_a_ready(ilm_a_ready),
    .lm_a_size(ilm_a_size),
    .lm_a_user(ilm_a_user),
    .lm_a_valid(ilm_a_valid),
    .lm_d_data(ilm_d_data),
    .lm_d_denied(ilm_d_denied),
    .lm_d_parity0(ilm_d_parity0),
    .lm_d_parity1(ilm_d_parity1),
    .lm_d_ready(ilm_d_ready),
    .lm_d_valid(ilm_d_valid)
);
endmodule


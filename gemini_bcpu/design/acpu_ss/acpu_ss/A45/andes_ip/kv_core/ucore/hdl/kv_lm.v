// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lm (
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
    lm_clk,
    lm_reset_n,
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
    lm_async_write_error,
    lm_clk_en,
    lm_pfm_event,
    lm_standby_ready,
    w_data,
    w_mask,
    w_ready,
    w_valid,
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
    lm_d_data,
    lm_d_denied,
    lm_d_parity0,
    lm_d_parity1,
    lm_d_ready,
    lm_d_valid
);
parameter DW = 32;
parameter BLOCKS = 1;
parameter RAM_AW = 8;
parameter RAM_DW = DW;
parameter RAM_BWEW = DW / 8;
parameter ECC_TYPE_INT = 0;
parameter UW = 1;
parameter SOURCE_BITS = 2;
parameter LM_WAIT_CYCLE = 1;
parameter SB_DEPTH = 6;
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
input lm_clk;
input lm_reset_n;
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
output lm_async_write_error;
input lm_clk_en;
output lm_pfm_event;
output lm_standby_ready;
input [(DW - 1):0] w_data;
input [DW / 8 - 1:0] w_mask;
output w_ready;
input w_valid;
output [RAM_AW + 2:3] lm_a_addr;
output [(DW - 1):0] lm_a_data;
output [DW / 8 - 1:0] lm_a_mask;
output [2:0] lm_a_opcode;
output [7:0] lm_a_parity0;
output [7:0] lm_a_parity1;
input lm_a_ready;
output [2:0] lm_a_size;
output [1:0] lm_a_user;
output lm_a_valid;
input [(DW - 1):0] lm_d_data;
input lm_d_denied;
input [7:0] lm_d_parity0;
input [7:0] lm_d_parity1;
output lm_d_ready;
input lm_d_valid;


wire [(RAM_AW - 1):0] sb_cmp_addr;
wire sb_drn_ready;
wire [(RAM_AW - 1):0] sb_enq_addr;
wire [DW + 1:0] sb_enq_data;
wire [(SB_DEPTH - 1):0] sb_enq_ent;
wire [(DW / 8) - 1:0] sb_enq_mask;
wire sb_enq_valid;
wire [(RAM_AW - 1):0] sb_drn_addr;
wire [DW + 1:0] sb_drn_data;
wire [(DW / 8) - 1:0] sb_drn_mask;
wire sb_drn_valid;
wire sb_empty;
wire sb_enq_ready;
wire sb_full;
wire [(SB_DEPTH - 1):0] sb_hit;
wire [(DW - 1):0] sb_hit_data;
wire [(DW / 8) - 1:0] sb_hit_mask;
generate
    if (LM_WAIT_CYCLE == 0) begin:gen_lm_tl_ul_no
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
    end
endgenerate
generate
    if (LM_WAIT_CYCLE == 1) begin:gen_lm_ram_no
        assign ram0_cs = 1'b0;
        assign ram0_we = 1'b0;
        assign ram0_addr = {RAM_AW{1'b0}};
        assign ram0_byte_we = {RAM_BWEW{1'b0}};
        assign ram0_user = 2'b0;
        assign ram0_wdata = {RAM_DW{1'b0}};
        assign ram1_cs = 1'b0;
        assign ram1_we = 1'b0;
        assign ram1_addr = {RAM_AW{1'b0}};
        assign ram1_byte_we = {RAM_BWEW{1'b0}};
        assign ram1_user = 2'b0;
        assign ram1_wdata = {RAM_DW{1'b0}};
        wire nds_unused_ram_rdata = (|ram0_rdata) | (|ram1_rdata);
    end
endgenerate
generate
    if (LM_WAIT_CYCLE == 1) begin:gen_tl_ul_ctl
        kv_lm_tl_ul_ctl #(
            .BLOCKS(BLOCKS),
            .DW(DW),
            .ECC_TYPE_INT(ECC_TYPE_INT),
            .RAM_AW(RAM_AW),
            .SB_DEPTH(SB_DEPTH),
            .SOURCE_BITS(SOURCE_BITS),
            .UW(UW)
        ) u_lm_tl_ul_ctl (
            .lm_clk(lm_clk),
            .lm_clk_en(lm_clk_en),
            .lm_reset_n(lm_reset_n),
            .lm_standby_ready(lm_standby_ready),
            .lm_pfm_event(lm_pfm_event),
            .lm_async_write_error(lm_async_write_error),
            .csr_eccen(csr_eccen),
            .csr_rwecc(csr_rwecc),
            .csr_mecc_code_code(csr_mecc_code_code),
            .a_valid(a_valid),
            .a_stall(a_stall),
            .a_addr(a_addr),
            .a_mask(a_mask),
            .a_func(a_func),
            .a_user(a_user),
            .a_source(a_source),
            .a_ready(a_ready),
            .w_valid(w_valid),
            .w_data(w_data),
            .w_mask(w_mask),
            .w_ready(w_ready),
            .d_valid(d_valid),
            .d_data(d_data),
            .d_status(d_status),
            .d_user(d_user),
            .lm_a_valid(lm_a_valid),
            .lm_a_ready(lm_a_ready),
            .lm_a_addr(lm_a_addr),
            .lm_a_data(lm_a_data),
            .lm_a_opcode(lm_a_opcode),
            .lm_a_mask(lm_a_mask),
            .lm_a_size(lm_a_size),
            .lm_a_user(lm_a_user),
            .lm_a_parity0(lm_a_parity0),
            .lm_a_parity1(lm_a_parity1),
            .lm_d_valid(lm_d_valid),
            .lm_d_ready(lm_d_ready),
            .lm_d_data(lm_d_data),
            .lm_d_parity0(lm_d_parity0),
            .lm_d_parity1(lm_d_parity1),
            .lm_d_denied(lm_d_denied),
            .sb_empty(sb_empty),
            .sb_full(sb_full),
            .sb_cmp_addr(sb_cmp_addr),
            .sb_hit_data(sb_hit_data),
            .sb_hit_mask(sb_hit_mask),
            .sb_hit(sb_hit),
            .sb_enq_valid(sb_enq_valid),
            .sb_enq_ent(sb_enq_ent),
            .sb_enq_addr(sb_enq_addr),
            .sb_enq_data(sb_enq_data),
            .sb_enq_mask(sb_enq_mask),
            .sb_enq_ready(sb_enq_ready),
            .sb_drn_valid(sb_drn_valid),
            .sb_drn_ready(sb_drn_ready),
            .sb_drn_addr(sb_drn_addr),
            .sb_drn_mask(sb_drn_mask),
            .sb_drn_data(sb_drn_data)
        );
    end
endgenerate
generate
    if (LM_WAIT_CYCLE == 0) begin:gen_ram_ctl
        kv_lm_ctl #(
            .BLOCKS(BLOCKS),
            .DW(DW),
            .ECC_TYPE_INT(ECC_TYPE_INT),
            .RAM_AW(RAM_AW),
            .RAM_BWEW(RAM_BWEW),
            .RAM_DW(RAM_DW),
            .SB_DEPTH(SB_DEPTH),
            .SOURCE_BITS(SOURCE_BITS),
            .UW(UW)
        ) u_lm_ctl (
            .lm_clk(lm_clk),
            .lm_clk_en(lm_clk_en),
            .lm_reset_n(lm_reset_n),
            .lm_standby_ready(lm_standby_ready),
            .lm_pfm_event(lm_pfm_event),
            .lm_async_write_error(lm_async_write_error),
            .csr_eccen(csr_eccen),
            .csr_rwecc(csr_rwecc),
            .csr_mecc_code_code(csr_mecc_code_code),
            .a_valid(a_valid),
            .a_stall(a_stall),
            .a_addr(a_addr),
            .a_mask(a_mask),
            .a_func(a_func),
            .a_user(a_user),
            .a_source(a_source),
            .a_ready(a_ready),
            .w_valid(w_valid),
            .w_data(w_data),
            .w_mask(w_mask),
            .w_ready(w_ready),
            .d_valid(d_valid),
            .d_data(d_data),
            .d_status(d_status),
            .d_user(d_user),
            .ram0_cs(ram0_cs),
            .ram0_we(ram0_we),
            .ram0_addr(ram0_addr),
            .ram0_byte_we(ram0_byte_we),
            .ram0_user(ram0_user),
            .ram0_wdata(ram0_wdata),
            .ram0_rdata(ram0_rdata),
            .ram1_cs(ram1_cs),
            .ram1_we(ram1_we),
            .ram1_addr(ram1_addr),
            .ram1_byte_we(ram1_byte_we),
            .ram1_user(ram1_user),
            .ram1_wdata(ram1_wdata),
            .ram1_rdata(ram1_rdata),
            .sb_empty(sb_empty),
            .sb_full(sb_full),
            .sb_cmp_addr(sb_cmp_addr),
            .sb_hit_data(sb_hit_data),
            .sb_hit_mask(sb_hit_mask),
            .sb_hit(sb_hit),
            .sb_enq_valid(sb_enq_valid),
            .sb_enq_ent(sb_enq_ent),
            .sb_enq_addr(sb_enq_addr),
            .sb_enq_data(sb_enq_data),
            .sb_enq_mask(sb_enq_mask),
            .sb_enq_ready(sb_enq_ready),
            .sb_drn_valid(sb_drn_valid),
            .sb_drn_ready(sb_drn_ready),
            .sb_drn_addr(sb_drn_addr),
            .sb_drn_mask(sb_drn_mask),
            .sb_drn_data(sb_drn_data)
        );
    end
endgenerate
kv_lm_sb #(
    .ALEN(RAM_AW),
    .DW(DW),
    .SB_DEPTH(SB_DEPTH)
) u_lm_sb (
    .lm_clk(lm_clk),
    .lm_reset_n(lm_reset_n),
    .sb_empty(sb_empty),
    .sb_full(sb_full),
    .sb_cmp_addr(sb_cmp_addr),
    .sb_hit_data(sb_hit_data),
    .sb_hit_mask(sb_hit_mask),
    .sb_hit(sb_hit),
    .sb_enq_valid(sb_enq_valid),
    .sb_enq_ent(sb_enq_ent),
    .sb_enq_addr(sb_enq_addr),
    .sb_enq_data(sb_enq_data),
    .sb_enq_mask(sb_enq_mask),
    .sb_enq_ready(sb_enq_ready),
    .sb_drn_valid(sb_drn_valid),
    .sb_drn_ready(sb_drn_ready),
    .sb_drn_addr(sb_drn_addr),
    .sb_drn_mask(sb_drn_mask),
    .sb_drn_data(sb_drn_data)
);
endmodule


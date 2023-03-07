// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lsu_rpt (
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


wire prefetch_en = csr_mcache_ctl_dprefetch_en & ~lsu_prefetch_clr & ~lsuop_prefetch_clr;
wire s0 = rpt_cmt_status[4];
wire s1 = rpt_cmt_status[0];
wire s2 = rpt_cmt_status[5];
wire s3 = rpt_cmt_status[10];
wire s4 = rpt_cmt_status[2];
wire s5 = rpt_cmt_status[1];
wire s6 = prf_ack_status[13];
wire cmt_valid;
wire [RPT_DEPTH - 1:0] s7;
wire [RPT_DEPTH - 1:0] s8;
wire [RPT_DEPTH - 1:0] s9;
wire [RPT_DEPTH - 1:0] s10;
wire [RPT_DEPTH - 1:0] s11;
wire [RPT_DEPTH - 1:0] s12;
wire [(EXTVALEN * RPT_DEPTH) - 1:0] s13;
wire [(12 * RPT_DEPTH) - 1:0] s14;
wire [RPT_DEPTH - 1:0] s15;
wire [(4 * RPT_DEPTH) - 1:0] s16;
wire [RPT_DEPTH - 1:0] s17;
wire [RPT_DEPTH - 1:0] s18;
wire s19;
wire [RPT_DEPTH - 1:0] s20;
wire [RPT_DEPTH - 1:0] s21;
wire [RPT_DEPTH - 1:0] s22;
wire [RPT_DEPTH - 1:0] s23;
wire [RPT_DEPTH - 1:0] s24;
reg [RPT_DEPTH - 1:0] s25;
wire [RPT_DEPTH - 1:0] s26;
wire s27;
wire s28;
wire s29;
wire s30;
wire [RPT_DEPTH - 1:0] s31;
wire s32 = |s9;
wire prf_valid;
wire [EXTVALEN - 1:0] prf_va;
wire [36:0] s33;
wire [11:0] prf_pc;
wire prf_vm;
wire [3:0] prf_mtype;
wire prf_ready;
wire s34;
wire s35;
wire s36;
wire s37;
wire s38;
wire s39;
wire [PRF_WIDTH - 1:0] s40;
wire s41;
wire s42;
wire [PRF_WIDTH - 1:0] s43;
wire s44;
reg [2:0] s45;
wire [2:0] s46;
wire s47;
wire [RPT_DEPTH - 1:0] s48;
wire s49;
wire [EXTVALEN - 1:0] s50;
wire [3:0] s51;
assign s49 = 1'b0;
assign s50 = {EXTVALEN{1'b0}};
assign s51 = 4'b0;
assign prf_standby_ready = &s17;
generate
    genvar i;
    for (i = 0; i < RPT_DEPTH; i = i + 1) begin:gen_ent
        kv_lsu_rpt_ent #(
            .EXTVALEN(EXTVALEN)
        ) u_ent (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .prefetch_en(prefetch_en),
            .cmt_valid(cmt_valid),
            .cmt_init(s7[i]),
            .cmt_pc(rpt_cmt_pc),
            .cmt_va(rpt_cmt_va),
            .cmt_status(rpt_cmt_status),
            .cmp_hit(s9[i]),
            .prf_valid(s10[i]),
            .prf_pc(s14[12 * i +:12]),
            .prf_va(s13[EXTVALEN * i +:EXTVALEN]),
            .prf_vm(s15[i]),
            .prf_mtype(s16[4 * i +:4]),
            .prf_ready(s12[i]),
            .prf_inflight(s11[i]),
            .prf_ack_valid(s18[i]),
            .prf_ack_replay(s19),
            .prf_resp_valid(s20[i]),
            .prf_resp_status(prf_resp_status),
            .nbload_resp_valid(nbload_resp_valid),
            .nbload_resp_rd(nbload_resp_rd),
            .nbload_resp_status(nbload_resp_status),
            .standby_ready(s17[i])
        );
    end
endgenerate
assign cmt_valid = prefetch_en & rpt_cmt_valid & ~rpt_cmt_kill & s1 & ~s5;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s45 <= 3'd0;
    end
    else if (s47) begin
        s45 <= s46;
    end
end

assign s47 = cmt_valid & (s44 | s32);
assign s8[0] = ~s45[2] & ~s45[0];
assign s8[1] = ~s45[2] & s45[0];
assign s8[2] = s45[2] & ~s45[1];
assign s8[3] = s45[2] & s45[1];
assign s44 = ~s32 & s3 & s0 & ~s4 & ~s2;
assign s7 = {RPT_DEPTH{s44}} & s8;
assign s48 = s32 ? s9 : s8;
assign s46 = ({3{s48[0]}} & {1'b1,s45[1],1'b1}) | ({3{s48[1]}} & {1'b1,s45[1],1'b0}) | ({3{s48[2]}} & {1'b0,1'b1,s45[0]}) | ({3{s48[3]}} & {1'b0,1'b0,s45[0]});
kv_arb_rr #(
    .N(RPT_DEPTH)
) u_arb_prf (
    .clk(core_clk),
    .resetn(core_reset_n),
    .en(s34),
    .valid(s21),
    .ready(s22),
    .grant(s23)
);
wire nds_unused_prf_ack_grant_wready;
wire nds_unused_prf_ack_grant_rvalid;
kv_fifo #(
    .DEPTH(4),
    .WIDTH(RPT_DEPTH)
) u_prf_ack_grant (
    .clk(core_clk),
    .reset_n(core_reset_n),
    .flush(1'b0),
    .wdata(s23),
    .wvalid(s34),
    .wready(nds_unused_prf_ack_grant_wready),
    .rdata(s31),
    .rvalid(nds_unused_prf_ack_grant_rvalid),
    .rready(prf_ack_valid)
);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s25 <= {RPT_DEPTH{1'b0}};
    end
    else if (s27) begin
        s25 <= s26;
    end
end

assign s24 = {RPT_DEPTH{~|s25}} | s25;
assign s12 = {RPT_DEPTH{prf_ready}} & s22 & s24;
assign s21 = s10 & s24;
assign s34 = prf_valid & prf_ready;
assign s27 = s28 | s29;
assign s28 = prf_ack_valid & s6 & ~s30;
assign s30 = |(s25 & (s10 | s11));
assign s29 = ~s30 | (prf_ack_valid & ~s6 & |(s31 & s25));
assign s26 = {RPT_DEPTH{s28}} & s31;
kv_mux_onehot #(
    .N(RPT_DEPTH),
    .W(EXTVALEN)
) u_prf_va (
    .out(prf_va),
    .sel(s23),
    .in(s13)
);
kv_mux_onehot #(
    .N(RPT_DEPTH),
    .W(12)
) u_prf_pc (
    .out(prf_pc),
    .sel(s23),
    .in(s14)
);
kv_mux_onehot #(
    .N(RPT_DEPTH),
    .W(1)
) u_prf_vm (
    .out(prf_vm),
    .sel(s23),
    .in(s15)
);
kv_mux_onehot #(
    .N(RPT_DEPTH),
    .W(4)
) u_prf_mtype (
    .out(prf_mtype),
    .sel(s23),
    .in(s16)
);
assign s37 = (s35 & csr_milmb_ien) | (s36 & csr_mdlmb_den);
assign s35 = prf_va[VALEN - 1:ILM_AMSB + 1] == ILM_BASE[VALEN - 1:ILM_AMSB + 1];
assign s36 = prf_va[VALEN - 1:DLM_AMSB + 1] == DLM_BASE[VALEN - 1:DLM_AMSB + 1];
assign prf_valid = (|s21) | s49;
assign prf_ready = s39;
assign s33[0 +:2] = 2'd0;
assign s33[34 +:3] = 3'd0;
assign s33[2] = 1'd1;
assign s33[3] = 1'd0;
assign s33[4] = 1'd0;
assign s33[5] = 1'd0;
assign s33[6] = 1'd0;
assign s33[7] = 1'd0;
assign s33[8] = 1'd0;
assign s33[9] = 1'd0;
assign s33[10] = s37;
assign s33[11] = 1'd0;
assign s33[12 +:4] = prf_mtype | s51;
assign s33[16] = 1'd1;
assign s33[17 +:5] = {1'b0,s23};
assign s33[22] = 1'd0;
assign s33[23] = 1'd0;
assign s33[24] = 1'd0;
assign s33[26] = 1'd1;
assign s33[25] = prf_vm;
assign s33[29] = 1'b0;
assign s33[27] = 1'b1;
assign s33[28] = 1'b0;
assign s33[30] = 1'b0;
assign s33[31] = 1'd0;
assign s33[32] = 1'd0;
assign s33[33] = 1'd1;
assign s18 = {RPT_DEPTH{prf_ack_valid}} & s31;
assign s19 = prf_ack_status[13] | prf_ack_status[14] | prf_ack_status[15];
kv_eb_half #(
    .WIDTH(PRF_WIDTH)
) u_prf_fifo (
    .clk(core_clk),
    .reset_n(core_reset_n),
    .wvalid(s38),
    .wready(s39),
    .wdata(s40),
    .rvalid(s41),
    .rready(s42),
    .rdata(s43)
);
assign s38 = prf_valid;
assign s40 = {prf_va | s50,prf_pc,s33};
assign s42 = prf_req_ready;
assign {prf_req_va,prf_req_pc,prf_req_func} = s43;
assign prf_req_valid = s41;
assign s20 = {RPT_DEPTH{prf_resp_valid}} & prf_resp_id[0 +:RPT_DEPTH];
endmodule


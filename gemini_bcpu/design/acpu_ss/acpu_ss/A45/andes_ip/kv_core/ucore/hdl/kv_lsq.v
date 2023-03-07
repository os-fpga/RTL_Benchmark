// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lsq (
    core_clk,
    core_reset_n,
    csr_milmb_ien,
    csr_mdlmb_den,
    lsq_empty,
    uop_issue_ready,
    ls_una_wait,
    uop_req_valid,
    uop_req_stall,
    uop_req_func,
    uop_req_pc,
    uop_req_addr,
    uop_req_ilm,
    uop_req_dlm,
    uop_req_op0,
    uop_req_op1,
    uop_resp_valid,
    uop_resp_result,
    uop_resp_result64,
    uop_resp_bresult,
    uop_resp_fault_va,
    uop_resp_pa,
    uop_resp_status,
    uop_cmt_valid,
    uop_cmt_kill,
    uop_cmt_wdata_i,
    uop_cmt_wdata_f,
    uop_cmt_wdata_sel_f,
    lsq_req_valid,
    lsq_req_stall,
    lsq_req_src,
    lsq_req_func,
    lsq_req_pc,
    lsq_req_va,
    lsq_req_va_op0,
    lsq_req_va_op1,
    lsq_req_offset,
    lsq_req_ilm,
    lsq_req_dlm,
    lsq_req_ready,
    lsq_commit,
    lsq_kill,
    lsq_cmt_wdata,
    lsq_ack_valid,
    lsq_ack_src,
    lsq_ack_result,
    lsq_ack_result2,
    lsq_ack_bresult,
    lsq_ack_fault_va,
    lsq_ack_pa,
    lsq_ack_status
);
parameter FLEN = 32;
parameter VALEN = 32;
parameter PALEN = 32;
parameter EXTVALEN = 32;
parameter DEPTH = 4;
parameter ILM_SIZE_KB = 8;
parameter ILM_AMSB = 15;
parameter ILM_BASE = 64'h1000_0000;
parameter DLM_SIZE_KB = 0;
parameter DLM_AMSB = 15;
parameter DLM_BASE = 64'h2000_0000;
localparam WIDTH = EXTVALEN + 2 + 27;
input core_clk;
input core_reset_n;
input csr_milmb_ien;
input csr_mdlmb_den;
output lsq_empty;
output uop_issue_ready;
input ls_una_wait;
input uop_req_valid;
input [1:0] uop_req_stall;
input [26:0] uop_req_func;
input [11:0] uop_req_pc;
input [EXTVALEN - 1:0] uop_req_addr;
input uop_req_ilm;
input uop_req_dlm;
input [VALEN - 1:0] uop_req_op0;
input [20:0] uop_req_op1;
output uop_resp_valid;
output [31:0] uop_resp_result;
output [63:0] uop_resp_result64;
output [31:0] uop_resp_bresult;
output [EXTVALEN - 1:0] uop_resp_fault_va;
output [PALEN - 1:0] uop_resp_pa;
output [36:0] uop_resp_status;
input uop_cmt_valid;
input uop_cmt_kill;
input [31:0] uop_cmt_wdata_i;
input [63:0] uop_cmt_wdata_f;
input uop_cmt_wdata_sel_f;
output lsq_req_valid;
output lsq_req_stall;
output [DEPTH - 1:0] lsq_req_src;
output [36:0] lsq_req_func;
output [11:0] lsq_req_pc;
output [EXTVALEN - 1:0] lsq_req_va;
output [VALEN - 1:0] lsq_req_va_op0;
output [20:0] lsq_req_va_op1;
output [2:0] lsq_req_offset;
output lsq_req_ilm;
output lsq_req_dlm;
input lsq_req_ready;
output [DEPTH - 1:0] lsq_commit;
output [DEPTH - 1:0] lsq_kill;
output [63:0] lsq_cmt_wdata;
input lsq_ack_valid;
input [DEPTH - 1:0] lsq_ack_src;
input [31:0] lsq_ack_result;
input [63:0] lsq_ack_result2;
input [31:0] lsq_ack_bresult;
input [EXTVALEN - 1:0] lsq_ack_fault_va;
input [PALEN - 1:0] lsq_ack_pa;
input [44:0] lsq_ack_status;


wire [2:0] uop_req_func3 = uop_req_func[0 +:3];
wire [DEPTH - 1:0] enq_ptr;
wire [DEPTH - 1:0] deq_ptr;
wire [DEPTH - 1:0] uop_cmt_ptr;
wire [DEPTH - 1:0] req_ptr;
wire req_ptr_en;
wire [DEPTH - 1:0] cnt;
reg wait_for_replay;
wire wait_for_replay_nx;
wire wait_for_replay_set;
wire wait_for_replay_clr;
wire [DEPTH - 1:0] ent_valid;
wire [DEPTH - 1:0] ent_committed;
wire [DEPTH - 1:0] ent_killed;
wire [DEPTH - 1:0] ent_abort;
wire [DEPTH - 1:0] ent_req_grant;
wire [(EXTVALEN * DEPTH) - 1:0] ent_base;
wire [(3 * DEPTH) - 1:0] ent_offset;
wire [(27 * DEPTH) - 1:0] ent_func;
wire [(12 * DEPTH) - 1:0] ent_pc;
wire [DEPTH - 1:0] ent_ilm;
wire [DEPTH - 1:0] ent_dlm;
wire [(4 * DEPTH) - 1:0] ent_mtype;
wire ent_req_valid;
wire [26:0] ent_req_func;
wire [11:0] ent_req_pc;
wire [EXTVALEN - 1:0] ent_req_addr;
wire [EXTVALEN - 1:0] ent_req_base;
wire [2:0] ent_req_offset;
wire [20:0] ent_req_offset_ze;
wire ent_req_ilm;
wire ent_req_dlm;
wire ent_req_killed;
wire ent_req_abort;
wire ent_req_committed;
wire ent_req_boundary;
wire [3:0] ent_req_mtype;
wire ent_req_first = ent_req_offset == 3'd0;
wire lsq_enq_valid;
wire [26:0] lsq_enq_func;
wire [11:0] lsq_enq_pc;
wire [EXTVALEN - 1:0] lsq_enq_addr;
wire lsq_enq_ilm;
wire lsq_enq_dlm;
wire deq_valid;
wire deq_kill;
wire deq_ent_killed;
wire deq_ent_committed;
wire deq_ent_abort;
wire lsq_req_grant;
wire lsq_resp_valid;
wire lsq_replay;
wire lsq_ack_nak;
wire lsq_ack_multi;
wire lsq_ack_last;
wire [2:0] lsq_ack_offset;
wire lsq_ack_first = lsq_ack_offset == 3'd0;
wire ent_replay;
wire [DEPTH - 1:0] ent_enq_valid = {DEPTH{lsq_enq_valid}} & enq_ptr;
wire [DEPTH - 1:0] ent_cmt_valid = {DEPTH{uop_cmt_valid}} & uop_cmt_ptr;
wire [DEPTH - 1:0] ent_deq_valid = {DEPTH{deq_valid}} & deq_ptr;
wire [DEPTH - 1:0] ent_resp_valid = {DEPTH{lsq_resp_valid}} & deq_ptr;
wire [2:0] req_base20;
wire [2:0] req_offset;
wire [1:0] req_size;
wire [2:0] req_fmt;
wire [26:0] req_func;
wire req_load;
wire req_store;
wire req_last;
wire req_multi;
wire req_una;
wire [2:0] req_offset_nx;
wire [EXTVALEN - 1:0] ent_ag_result;
wire [EXTVALEN - 1:0] ent_ag_op0;
wire [20:0] ent_ag_op1;
wire ent_ag_hit_ilm;
wire ent_ag_hit_dlm;
wire [26:0] deq_func;
wire deq_func_load = deq_func[3];
wire [2:0] deq_func_func3 = deq_func[0 +:3];
wire [31:0] multi_result;
wire [63:0] multi_result64;
reg unabuf_valid;
wire unabuf_valid_nx;
wire unabuf_valid_en;
wire unabuf_valid_rst;
wire [36:0] multi_status;
wire [36:0] single_status;
wire unabuf_status_en;
reg [36:0] unabuf_status;
wire [36:0] unabuf_status_nx;
wire [EXTVALEN - 1:0] unabuf_fault_va;
wire lsq_ack_halt = lsq_ack_status[0];
wire lsq_ack_xcpt = lsq_ack_status[1];
wire lsq_ack_replay = lsq_ack_status[14];
wire [3:0] lsq_ack_mtype = lsq_ack_status[17 +:4];
wire lsq_ack_abort = lsq_ack_halt | lsq_ack_xcpt | lsq_ack_replay;
wire unabuf_abort = unabuf_status[0] | unabuf_status[1] | unabuf_status[14];
generate
    genvar i;
    for (i = 0; i < DEPTH; i = i + 1) begin:gen_ent
        wire [2:0] replay_offset;
        kv_lsq_ent #(
            .EXTVALEN(EXTVALEN)
        ) u_lsq_ent (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .enq_valid(ent_enq_valid[i]),
            .enq_func(lsq_enq_func),
            .enq_pc(lsq_enq_pc),
            .enq_addr(lsq_enq_addr),
            .enq_ilm(lsq_enq_ilm),
            .enq_dlm(lsq_enq_dlm),
            .cmt_valid(ent_cmt_valid[i]),
            .cmt_kill(uop_cmt_kill),
            .replay(ent_replay),
            .replay_offset(replay_offset),
            .resp_valid(ent_resp_valid[i]),
            .resp_multi(lsq_ack_multi),
            .resp_first(lsq_ack_first),
            .resp_abort(lsq_ack_abort),
            .resp_mtype(lsq_ack_mtype),
            .deq_valid(ent_deq_valid[i]),
            .req_grant(ent_req_grant[i]),
            .req_offset_nx(req_offset_nx),
            .valid(ent_valid[i]),
            .base(ent_base[i * EXTVALEN +:EXTVALEN]),
            .offset(ent_offset[i * 3 +:3]),
            .func(ent_func[i * 27 +:27]),
            .pc(ent_pc[i * 12 +:12]),
            .ilm(ent_ilm[i]),
            .dlm(ent_dlm[i]),
            .committed(ent_committed[i]),
            .killed(ent_killed[i]),
            .abort(ent_abort[i]),
            .mtype(ent_mtype[i * 4 +:4])
        );
        assign replay_offset = lsq_ack_offset & {3{lsq_replay & deq_ptr[i]}};
    end
endgenerate
assign uop_issue_ready = ~cnt[DEPTH - 2];
assign uop_resp_valid = (lsq_resp_valid & lsq_ack_last) | (deq_ent_abort & ~deq_ent_killed);
assign uop_resp_result = unabuf_valid ? multi_result : lsq_ack_result;
assign uop_resp_bresult = lsq_ack_bresult;
assign uop_resp_pa = lsq_ack_pa;
assign uop_resp_status = unabuf_valid ? multi_status : single_status;
assign single_status[0] = lsq_ack_status[0];
assign single_status[1] = lsq_ack_status[1];
assign single_status[2 +:6] = lsq_ack_status[2 +:6];
assign single_status[8 +:3] = lsq_ack_status[8 +:3];
assign single_status[11] = lsq_ack_status[11];
assign single_status[12] = lsq_ack_status[12];
assign single_status[13] = lsq_ack_status[13];
assign single_status[14] = lsq_ack_status[14];
assign single_status[15] = lsq_ack_status[15];
assign single_status[16] = lsq_ack_status[16];
assign single_status[17] = lsq_ack_status[21];
assign single_status[18 +:8] = lsq_ack_status[22 +:8];
assign single_status[26] = lsq_ack_status[30];
assign single_status[27 +:4] = lsq_ack_status[31 +:4];
assign single_status[32] = lsq_ack_status[35];
assign single_status[31] = 1'b0;
assign single_status[33] = lsq_ack_status[16] | (lsq_ack_status[41] & deq_func_func3[1]);
assign single_status[34] = lsq_ack_status[42] | (unabuf_valid & unabuf_status[34]);
assign single_status[35] = lsq_ack_status[43] | (unabuf_valid & unabuf_status[35]);
assign single_status[36] = lsq_ack_status[44] | (unabuf_valid & unabuf_status[36]);
assign uop_resp_result64 = lsq_ack_multi ? multi_result64 : {32'd0,lsq_ack_result};
kv_cnt_onehot #(
    .N(DEPTH)
) u_enq_ptr (
    .clk(core_clk),
    .rst_n(core_reset_n),
    .en(lsq_enq_valid),
    .up_dn(1'b1),
    .load(1'b0),
    .data({DEPTH{1'b0}}),
    .cnt(enq_ptr)
);
kv_cnt_johnson #(
    .N(DEPTH)
) u_cnt (
    .clk(core_clk),
    .rst_n(core_reset_n),
    .up(lsq_enq_valid),
    .dn(deq_valid),
    .cnt(cnt)
);
assign lsq_enq_valid = uop_req_valid & ~uop_req_stall[0] & ~(uop_req_stall[1] & ~uop_resp_valid);
assign lsq_enq_func = uop_req_func;
assign lsq_enq_pc = uop_req_pc;
assign lsq_enq_addr = uop_req_addr;
assign lsq_enq_ilm = uop_req_ilm;
assign lsq_enq_dlm = uop_req_dlm;
assign lsq_empty = ~cnt[0];
kv_cnt_onehot #(
    .N(DEPTH)
) u_req_ptr (
    .clk(core_clk),
    .rst_n(core_reset_n),
    .en(req_ptr_en),
    .up_dn(1'b1),
    .load(lsq_replay),
    .data(deq_ptr),
    .cnt(req_ptr)
);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        wait_for_replay <= 1'b0;
    end
    else begin
        wait_for_replay <= wait_for_replay_nx;
    end
end

kv_mux_onehot #(
    .N(DEPTH),
    .W(1)
) u_ent_req_valid (
    .out(ent_req_valid),
    .sel(req_ptr),
    .in(ent_valid)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(EXTVALEN)
) u_ent_req_base (
    .out(ent_req_base),
    .sel(req_ptr),
    .in(ent_base)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(3)
) u_ent_req_offset (
    .out(ent_req_offset),
    .sel(req_ptr),
    .in(ent_offset)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(27)
) u_ent_req_func (
    .out(ent_req_func),
    .sel(req_ptr),
    .in(ent_func)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(12)
) u_ent_req_pc (
    .out(ent_req_pc),
    .sel(req_ptr),
    .in(ent_pc)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(1)
) u_ent_req_ilm (
    .out(ent_req_ilm),
    .sel(req_ptr),
    .in(ent_ilm)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(1)
) u_ent_req_dlm (
    .out(ent_req_dlm),
    .sel(req_ptr),
    .in(ent_dlm)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(1)
) u_ent_req_killed (
    .out(ent_req_killed),
    .sel(req_ptr),
    .in(ent_killed)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(1)
) u_ent_req_abort (
    .out(ent_req_abort),
    .sel(req_ptr),
    .in(ent_abort)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(1)
) u_ent_req_committed (
    .out(ent_req_committed),
    .sel(req_ptr),
    .in(ent_committed)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(4)
) u_ent_req_mtype (
    .out(ent_req_mtype),
    .sel(req_ptr),
    .in(ent_mtype)
);
assign req_ptr_en = lsq_replay | (lsq_req_grant & req_last) | (ent_req_valid & ent_req_committed & ent_req_killed) | (ent_req_valid & ent_req_committed & ent_req_abort);
assign lsq_resp_valid = lsq_ack_valid & ~lsq_ack_nak & ~wait_for_replay;
assign lsq_ack_nak = lsq_ack_status[13] | lsq_ack_status[15];
assign lsq_ack_last = lsq_ack_status[37];
assign lsq_ack_multi = lsq_ack_status[36];
assign lsq_ack_offset = lsq_ack_status[38 +:3];
assign lsq_replay = lsq_ack_valid & lsq_ack_nak & ~deq_kill & ~deq_ent_abort;
assign ent_replay = lsq_replay & ~wait_for_replay;
assign wait_for_replay_nx = wait_for_replay_set | (wait_for_replay & ~wait_for_replay_clr);
assign wait_for_replay_set = lsq_replay;
assign wait_for_replay_clr = 1'b1;
assign lsq_req_valid = ent_req_valid | uop_req_valid;
assign lsq_req_stall = wait_for_replay | (ent_req_valid ? 1'b0 : uop_req_stall[0] | (uop_req_stall[1] & ~uop_resp_valid)) | ent_req_killed;
assign req_func = ent_req_valid ? ent_req_func : uop_req_func;
assign lsq_req_pc = ent_req_valid ? ent_req_pc : uop_req_pc;
assign lsq_req_va = ent_req_valid ? ent_req_addr : uop_req_addr;
assign lsq_req_va_op0 = ent_req_valid ? ent_req_base[VALEN - 1:0] : uop_req_op0[VALEN - 1:0];
assign lsq_req_va_op1 = ent_req_valid ? ent_req_offset_ze[20:0] : uop_req_op1;
assign lsq_req_ilm = ent_req_valid ? ent_req_ilm : uop_req_ilm;
assign lsq_req_dlm = ent_req_valid ? ent_req_dlm : uop_req_dlm;
assign lsq_req_offset = ent_req_valid ? ent_req_offset : 3'd0;
kv_lsdec #(
    .FLEN(FLEN)
) u_lsdec (
    .base(req_base20),
    .offset(req_offset),
    .load(req_load),
    .store(req_store),
    .fmt(req_fmt),
    .size(req_size),
    .last(req_last),
    .una(req_una),
    .multi(req_multi),
    .offset_nx(req_offset_nx)
);
assign req_base20 = ent_req_valid ? ent_req_base[2:0] : uop_req_addr[2:0];
assign req_offset = lsq_req_offset;
assign req_load = req_func[3];
assign req_store = req_func[4];
assign req_fmt = req_func[0 +:3];
kv_zero_ext #(
    .OW(21),
    .IW(3)
) u_ag_offset_ze (
    .out(ent_req_offset_ze),
    .in(ent_req_offset)
);
assign ent_ag_op0 = ent_req_base;
assign ent_req_addr = ent_ag_result;
assign ent_ag_op1 = ent_req_offset_ze;
kv_agu #(
    .OP0LEN(EXTVALEN),
    .VALEN(VALEN),
    .EXTVALEN(EXTVALEN),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .ILM_BASE(ILM_BASE),
    .ILM_AMSB(ILM_AMSB),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .DLM_BASE(DLM_BASE),
    .DLM_AMSB(DLM_AMSB)
) u_entt_agu (
    .ag_op0(ent_ag_op0),
    .ag_op1(ent_ag_op1),
    .ag_result(ent_ag_result),
    .hit_ilm(ent_ag_hit_ilm),
    .hit_dlm(ent_ag_hit_dlm)
);
assign ent_req_boundary = (csr_milmb_ien & (ent_req_ilm ^ ent_ag_hit_ilm) & ~ent_req_first) | (csr_mdlmb_den & (ent_req_dlm ^ ent_ag_hit_dlm) & ~ent_req_first);
assign lsq_req_src = req_ptr;
assign lsq_req_grant = lsq_req_valid & lsq_req_ready & ~lsq_req_stall;
assign ent_req_grant = {DEPTH{lsq_req_grant}} & req_ptr;
assign lsq_req_func[0 +:2] = req_size;
assign lsq_req_func[34 +:3] = req_fmt;
assign lsq_req_func[33] = req_last;
assign lsq_req_func[32] = req_multi;
assign lsq_req_func[16] = req_func[11] & ~req_una;
assign lsq_req_func[11] = req_una;
assign lsq_req_func[10] = ent_req_valid & ent_req_boundary;
assign lsq_req_func[12 +:4] = ent_req_valid ? ent_req_mtype : 4'd0;
assign lsq_req_func[2] = req_func[3];
assign lsq_req_func[3] = req_func[4];
assign lsq_req_func[17 +:5] = req_func[12 +:5];
assign lsq_req_func[4] = req_func[5];
assign lsq_req_func[5] = req_func[6];
assign lsq_req_func[6] = req_func[7];
assign lsq_req_func[7] = req_func[8];
assign lsq_req_func[8] = req_func[9];
assign lsq_req_func[9] = req_func[10];
assign lsq_req_func[22] = req_func[17];
assign lsq_req_func[24] = req_func[19];
assign lsq_req_func[23] = req_func[18];
assign lsq_req_func[25] = req_func[20];
assign lsq_req_func[29] = req_func[24];
assign lsq_req_func[26] = req_func[21];
assign lsq_req_func[27] = req_func[22];
assign lsq_req_func[28] = req_func[23];
assign lsq_req_func[30] = req_func[25];
assign lsq_req_func[31] = req_func[26];
kv_cnt_onehot #(
    .N(DEPTH)
) u_uop_cmt_ptr (
    .clk(core_clk),
    .rst_n(core_reset_n),
    .en(uop_cmt_valid),
    .up_dn(1'b1),
    .load(1'b0),
    .data({DEPTH{1'b0}}),
    .cnt(uop_cmt_ptr)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(27)
) u_ent_deq_func (
    .out(deq_func),
    .sel(deq_ptr),
    .in(ent_func)
);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        unabuf_valid <= 1'b0;
    end
    else if (unabuf_valid_en) begin
        unabuf_valid <= unabuf_valid_nx;
    end
end

always @(posedge core_clk) begin
    if (unabuf_status_en) begin
        unabuf_status <= unabuf_status_nx;
    end
end

kv_cnt_onehot #(
    .N(DEPTH)
) u_deq_ptr (
    .clk(core_clk),
    .rst_n(core_reset_n),
    .en(deq_valid),
    .up_dn(1'b1),
    .load(1'b0),
    .data({DEPTH{1'b0}}),
    .cnt(deq_ptr)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(1)
) u_deq_ent_killed (
    .out(deq_ent_killed),
    .sel(deq_ptr),
    .in(ent_killed)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(1)
) u_deq_ent_committed (
    .out(deq_ent_committed),
    .sel(deq_ptr),
    .in(ent_committed)
);
kv_mux_onehot #(
    .N(DEPTH),
    .W(1)
) u_deq_ent_abort (
    .out(deq_ent_abort),
    .sel(deq_ptr),
    .in(ent_abort)
);
assign deq_kill = deq_ent_committed ? deq_ent_killed : uop_cmt_kill;
assign lsq_commit = ({DEPTH{wait_for_replay}}) | (ent_committed) | ({DEPTH{uop_cmt_valid}} & uop_cmt_ptr);
assign lsq_kill = ({DEPTH{wait_for_replay}}) | (ent_killed) | (ent_abort) | ({DEPTH{uop_cmt_valid & uop_cmt_kill}} & uop_cmt_ptr);
assign deq_valid = uop_resp_valid | deq_ent_killed | deq_ent_abort;
assign unabuf_valid_rst = deq_ent_killed | deq_ent_abort;
assign unabuf_valid_en = (lsq_resp_valid & lsq_ack_multi) | unabuf_valid_rst;
assign unabuf_valid_nx = ~lsq_ack_last & ~unabuf_valid_rst;
generate
    if (FLEN <= 32) begin:gen_flen_le_xlen
        reg [31:0] unabuf_data;
        wire [31:0] unabuf_data_nx;
        wire unabuf_data_en;
        wire [31:0] lsq_ack_fault_va_ze;
        always @(posedge core_clk) begin
            if (unabuf_data_en) begin
                unabuf_data <= unabuf_data_nx;
            end
        end

        kv_zero_ext #(
            .OW(32),
            .IW(EXTVALEN)
        ) u_lsq_ack_fault_va_ze (
            .out(lsq_ack_fault_va_ze),
            .in(lsq_ack_fault_va)
        );
        assign unabuf_data_en = (lsq_resp_valid & ~lsq_ack_last & deq_func_load) | unabuf_status_en;
        assign unabuf_data_nx = lsq_ack_abort ? lsq_ack_fault_va_ze : lsq_ack_result;
        assign multi_result = unabuf_data | lsq_ack_result2[31:0];
        assign multi_result64 = {multi_result[31:0],multi_result[31:0]};
        assign lsq_cmt_wdata[31:0] = uop_cmt_wdata_sel_f ? uop_cmt_wdata_f[31:0] : uop_cmt_wdata_i[31:0];
        assign lsq_cmt_wdata[63:32] = uop_cmt_wdata_sel_f ? uop_cmt_wdata_f[31:0] : uop_cmt_wdata_i[31:0];
        assign unabuf_fault_va = unabuf_data[EXTVALEN - 1:0];
    end
    else begin:gen_flen_gt_xlen
        wire [55:0] unabuf_data;
        wire [55:0] unabuf_wdata;
        wire [6:0] unabuf_bwe;
        wire unabuf_we;
        wire [6:0] offset_bwe;
        wire [55:0] lsq_ack_fault_va_ze;
        kv_dff_bwe #(
            .BYTES(7)
        ) u_unabuf_data (
            .clk(core_clk),
            .bwe(unabuf_bwe),
            .d(unabuf_wdata),
            .q(unabuf_data)
        );
        kv_zero_ext #(
            .OW(56),
            .IW(EXTVALEN)
        ) u_lsq_ack_fault_va_ze (
            .out(lsq_ack_fault_va_ze),
            .in(lsq_ack_fault_va)
        );
        assign offset_bwe = ({7{(lsq_ack_offset == 3'd0)}} & 7'h7f) | ({7{(lsq_ack_offset == 3'd1)}} & 7'h7e) | ({7{(lsq_ack_offset == 3'd2)}} & 7'h7c) | ({7{(lsq_ack_offset == 3'd3)}} & 7'h78) | ({7{(lsq_ack_offset == 3'd4)}} & 7'h70) | ({7{(lsq_ack_offset == 3'd5)}} & 7'h60) | ({7{(lsq_ack_offset == 3'd6)}} & 7'h40);
        assign unabuf_we = (lsq_resp_valid & ~lsq_ack_last);
        assign unabuf_bwe = ({7{unabuf_we & lsq_ack_abort}} & 7'h0f) | ({7{unabuf_we & deq_func_load}} & offset_bwe);
        assign unabuf_wdata = lsq_ack_abort ? lsq_ack_fault_va_ze : lsq_ack_first ? {24'd0,lsq_ack_result} : lsq_ack_result2[55:0];
        assign multi_result = unabuf_data[31:0] | lsq_ack_result2[31:0];
        assign multi_result64 = {8'd0,unabuf_data[55:0]} | {lsq_ack_result2[63:8],8'd0};
        assign lsq_cmt_wdata[31:0] = uop_cmt_wdata_sel_f ? uop_cmt_wdata_f[31:0] : uop_cmt_wdata_i[31:0];
        assign lsq_cmt_wdata[63:32] = uop_cmt_wdata_sel_f ? uop_cmt_wdata_f[63:32] : 32'd0;
        assign unabuf_fault_va = unabuf_data[EXTVALEN - 1:0];
    end
endgenerate
assign uop_resp_fault_va = (unabuf_valid & unabuf_abort) ? unabuf_fault_va[EXTVALEN - 1:0] : lsq_ack_fault_va;
assign multi_status = (unabuf_valid & unabuf_abort) ? unabuf_status : single_status;
assign unabuf_status_en = lsq_resp_valid & lsq_ack_multi & ~lsq_ack_last & ~(unabuf_valid & unabuf_abort);
assign unabuf_status_nx = single_status;
wire [DEPTH - 1:0] nds_unused_lsq_ack_src = lsq_ack_src;
endmodule


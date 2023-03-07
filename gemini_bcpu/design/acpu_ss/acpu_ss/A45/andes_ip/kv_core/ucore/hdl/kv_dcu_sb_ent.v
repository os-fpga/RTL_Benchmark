// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_sb_ent (
    dcu_clk,
    dcu_reset_n,
    enq_valid,
    enq_spec,
    enq_addr,
    enq_state,
    enq_way,
    enq_rmw,
    enq_rmwdata,
    cmp_addr,
    cmp_hit,
    cmp_hit_line,
    cmp_hit_beat,
    req_hit_line,
    req_hit_beat,
    evt_valid,
    evt_exclusive,
    probe_valid,
    probe_2b,
    probe_2n,
    fil_valid,
    fil_mesi,
    fil_last,
    fil_fault,
    fil_payload,
    fil_beat_data,
    cmt_valid,
    cmt_kill0,
    cmt_kill1,
    cmt_kill1_en,
    cmt_miss,
    cmt_wdata,
    cmt_wmask,
    drain_valid,
    drain_ready,
    valid,
    addr,
    rdata,
    mask,
    way,
    edata,
    emask,
    pending
);
parameter PALEN = 32;
parameter DCACHE_ECC_TYPE_INT = 0;
localparam GRN_LSB = 2;
localparam INVALID = 0;
localparam SPECULATIVE = 1;
localparam COMMITTED = 2;
localparam FSM_BITS = 3;
localparam S_BIT = 0;
localparam E_BIT = 1;
localparam M_BIT = 2;
localparam F_BIT = 3;
input dcu_clk;
input dcu_reset_n;
input enq_valid;
input enq_spec;
input [PALEN - 1:0] enq_addr;
input [3:0] enq_state;
input [3:0] enq_way;
input enq_rmw;
input [31:0] enq_rmwdata;
input [PALEN - 1:0] cmp_addr;
output cmp_hit;
output cmp_hit_line;
output cmp_hit_beat;
input req_hit_line;
input req_hit_beat;
input evt_valid;
input evt_exclusive;
input probe_valid;
input probe_2b;
input probe_2n;
input fil_valid;
input [2:0] fil_mesi;
input fil_last;
input fil_fault;
input fil_payload;
input [127:0] fil_beat_data;
input cmt_valid;
input cmt_kill0;
input cmt_kill1;
input cmt_kill1_en;
input cmt_miss;
input [31:0] cmt_wdata;
input [3:0] cmt_wmask;
output drain_valid;
input drain_ready;
output valid;
output [PALEN - 1:0] addr;
output [31:0] rdata;
output [3:0] mask;
output [3:0] way;
output [127:0] edata;
output [15:0] emask;
output pending;


reg [FSM_BITS - 1:0] s0;
reg [FSM_BITS - 1:0] s1;
reg s2;
wire s3 = s0[INVALID];
wire s4 = s0[SPECULATIVE];
wire s5 = s0[COMMITTED];
wire s6;
wire s7;
reg [3:0] s8;
wire [3:0] s9;
wire s10;
wire [3:0] s11;
wire [3:0] s12;
reg [PALEN - 1:0] addr;
reg [3:0] way;
wire [31:0] s13;
wire [3:0] bwe;
wire [31:0] s14;
wire [3:0] s15;
wire s16;
wire s17;
wire s18;
wire s19;
wire s20;
wire s21;
wire s22;
reg [3:0] s23;
wire [3:0] s24;
wire [3:0] s25;
wire [3:0] s26;
wire s27;
reg pending;
wire s28;
wire s29 = ~s3 & fil_valid & req_hit_line;
wire s30 = cmt_kill0 | (cmt_kill1 & cmt_kill1_en);
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        s0 <= {{(FSM_BITS - 1){1'b0}},1'b1};
    end
    else if (s2) begin
        s0 <= s1;
    end
end

always @(posedge dcu_clk) begin
    if (s18) begin
        addr <= enq_addr;
        way <= enq_way;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        s8 <= 4'b0;
    end
    else if (s10) begin
        s8 <= s9;
    end
end

kv_dff_bwe #(
    .BYTES(4)
) u_data (
    .clk(dcu_clk),
    .bwe(bwe),
    .d(s14),
    .q(s13)
);
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        s23 <= {4{1'b0}};
        pending <= 1'b0;
    end
    else if (s27) begin
        s23 <= s24;
        pending <= s28;
    end
end

always @* begin
    s1 = {FSM_BITS{1'b0}};
    case (1'b1)
        s0[INVALID]: begin
            if (enq_spec) begin
                s1[SPECULATIVE] = 1'b1;
                s2 = enq_valid;
            end
            else begin
                s1[COMMITTED] = 1'b1;
                s2 = enq_valid;
            end
        end
        s0[SPECULATIVE]: begin
            s1[COMMITTED] = 1'b1;
            s2 = cmt_valid;
        end
        s0[COMMITTED]: begin
            if (enq_valid) begin
                s1[SPECULATIVE] = 1'b1;
                s2 = enq_spec;
            end
            else begin
                s1[INVALID] = 1'b1;
                s2 = s19;
            end
        end
        default: begin
            s1 = {FSM_BITS{1'b0}};
            s2 = 1'b0;
        end
    endcase
end

assign valid = ~s3;
assign s18 = s3 & enq_valid;
generate
    if (DCACHE_ECC_TYPE_INT == 2) begin:gen_write_ecc
        wire s31 = (DCACHE_ECC_TYPE_INT == 2);
        wire [3:0] s32;
        wire [3:0] s33;
        wire [3:0] s34;
        wire [31:0] s35;
        wire [31:0] s36;
        wire [31:0] s37;
        wire [31:0] s38;
        wire [31:0] s39;
        reg s40;
        wire s41;
        wire s42;
        wire s43;
        wire s44;
        wire s45 = s29 & req_hit_beat & fil_payload;
        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                s40 <= 1'b0;
            end
            else if (s41) begin
                s40 <= s42;
            end
        end

        kv_mux #(
            .N(4),
            .W(32)
        ) u_fil_wdata (
            .out(s38),
            .sel(addr[GRN_LSB +:2]),
            .in(fil_beat_data)
        );
        assign s34 = ({4{cmt_valid & ~cmt_kill0}} & cmt_wmask) | ({4{~s3}} & s23);
        assign bwe = s15 | s32 | s33;
        assign s32 = {4{s45}} & ~s34;
        assign s27 = enq_valid | cmt_valid | s17 | s16 | s19;
        assign s25 = {4{cmt_valid & ~s30}} & cmt_wmask;
        assign s26 = {4{s17}} | {4{s16 & ~evt_exclusive}} | {4{enq_valid & s3}} | {4{s19}};
        assign s24 = s25 | (s23 & ~s26);
        assign s28 = |s24;
        kv_bit_expand #(
            .N(4),
            .M(8)
        ) u_bit_we_cmt (
            .out(s36),
            .in(s15)
        );
        kv_bit_expand #(
            .N(4),
            .M(8)
        ) u_bit_we_fil (
            .out(s35),
            .in(s32)
        );
        kv_bit_expand #(
            .N(4),
            .M(8)
        ) u_bit_we_rmw (
            .out(s37),
            .in(s33)
        );
        assign s39 = (s36 & cmt_wdata) | (s35 & s38) | (s37 & enq_rmwdata);
        assign s14 = s39;
        assign s41 = s43 | s44;
        assign s43 = (s3 & enq_valid & enq_state[S_BIT] & enq_rmw) | s17 | s45;
        assign s44 = (s19 & ~enq_valid) | s16 | (probe_valid & req_hit_line & probe_2n);
        assign s42 = ~s44 & (s40 | s43);
        assign s33 = {4{enq_valid & enq_valid & enq_state[S_BIT] & ~s40 & enq_rmw}} & ~s15;
        assign mask = s23 | {4{s40}};
        assign rdata = s13;
        assign s15 = ({4{cmt_valid & ~s30}} & cmt_wmask);
    end
    else begin:gen_write_noecc
        assign s15 = {4{cmt_valid & ~s30}} & cmt_wmask;
        assign bwe = s15;
        assign s14 = cmt_wdata;
        assign s27 = enq_valid | cmt_valid | s17 | s16 | s19;
        assign s25 = {4{cmt_valid & ~s30}} & cmt_wmask;
        assign s26 = {4{s17}} | {4{s16 & ~evt_exclusive}} | {4{enq_valid & s3}} | {4{s19}};
        assign s24 = s25 | (s23 & ~s26);
        assign s28 = |s24;
        assign mask = s23;
        assign rdata = s13;
    end
endgenerate
kv_dcu_sb_cmp #(
    .PALEN(PALEN)
) u_cmp (
    .cmp_addr(cmp_addr),
    .ent_addr(addr),
    .match_line(s21),
    .match_beat(s20),
    .match_xlen(s22)
);
assign cmp_hit = valid & s22 & (enq_valid | ~s19);
assign cmp_hit_line = valid & s21;
assign cmp_hit_beat = valid & s20;
kv_bin2onehot #(
    .N(4)
) u_grn_onehot (
    .out(s12),
    .in(addr[GRN_LSB +:2])
);
assign edata[0 +:32] = {32{cmp_hit_beat & s12[0]}} & s13;
assign edata[32 +:32] = {32{cmp_hit_beat & s12[1]}} & s13;
assign edata[64 +:32] = {32{cmp_hit_beat & s12[2]}} & s13;
assign edata[96 +:32] = {32{cmp_hit_beat & s12[3]}} & s13;
assign emask[0 +:4] = {4{cmp_hit_beat & s12[0] & s6}} & mask;
assign emask[4 +:4] = {4{cmp_hit_beat & s12[1] & s6}} & mask;
assign emask[8 +:4] = {4{cmp_hit_beat & s12[2] & s6}} & mask;
assign emask[12 +:4] = {4{cmp_hit_beat & s12[3] & s6}} & mask;
assign drain_valid = (pending & s6);
assign s17 = drain_valid & drain_ready;
assign s16 = evt_valid & req_hit_beat & s6;
assign s19 = s5 & (~pending | s7);
assign s10 = (enq_valid & s3) | (s29 & (fil_last | fil_fault)) | (evt_valid & req_hit_beat) | (probe_valid & req_hit_line & s4);
assign s9 = s3 ? enq_state : s29 ? {fil_fault,fil_mesi} : s11;
assign s11[S_BIT] = s8[S_BIT] & ~(evt_valid & ~evt_exclusive) & ~(probe_valid & (probe_2n));
assign s11[E_BIT] = s8[E_BIT] & ~(evt_valid & ~evt_exclusive) & ~(probe_valid & (probe_2n | probe_2b));
assign s11[M_BIT] = s8[M_BIT] & ~(evt_valid & ~evt_exclusive) & ~probe_valid;
assign s11[F_BIT] = 1'b0;
assign s6 = s8[E_BIT];
assign s7 = s8[F_BIT];
endmodule


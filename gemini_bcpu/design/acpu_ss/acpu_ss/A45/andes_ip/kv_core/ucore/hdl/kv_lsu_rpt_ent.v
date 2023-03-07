// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lsu_rpt_ent (
    core_clk,
    core_reset_n,
    prefetch_en,
    cmt_valid,
    cmt_init,
    cmt_status,
    cmt_pc,
    cmt_va,
    cmp_hit,
    prf_valid,
    prf_pc,
    prf_va,
    prf_vm,
    prf_mtype,
    prf_ready,
    prf_inflight,
    prf_ack_valid,
    prf_ack_replay,
    prf_resp_valid,
    prf_resp_status,
    nbload_resp_valid,
    nbload_resp_rd,
    nbload_resp_status,
    standby_ready
);
parameter EXTVALEN = 32;
localparam INVALID = 0;
localparam INIT = 1;
localparam TRANSIENT = 2;
localparam STEADY = 3;
localparam FSM_BITS = 4;
localparam IDX_LSB = 6;
input core_clk;
input core_reset_n;
input prefetch_en;
input cmt_valid;
input cmt_init;
input [16:0] cmt_status;
input [11:0] cmt_pc;
input [EXTVALEN - 1:0] cmt_va;
output cmp_hit;
output prf_valid;
output [11:0] prf_pc;
output [EXTVALEN - 1:0] prf_va;
output prf_vm;
output [3:0] prf_mtype;
input prf_ready;
output prf_inflight;
input prf_ack_valid;
input prf_ack_replay;
input prf_resp_valid;
input prf_resp_status;
input nbload_resp_valid;
input [4:0] nbload_resp_rd;
input nbload_resp_status;
output standby_ready;


reg [FSM_BITS - 1:0] s0;
reg [FSM_BITS - 1:0] s1;
reg s2;
wire s3 = s0[INVALID];
wire s4 = s0[INIT];
wire s5 = s0[TRANSIENT];
wire s6 = s0[STEADY];
wire s7 = ~s3;
wire s8 = cmt_status[4];
wire s9 = cmt_status[3];
wire s10 = cmt_status[2];
wire s11 = cmt_status[5];
wire [3:0] s12 = cmt_status[6 +:4];
wire s13 = cmt_status[11];
wire [4:0] s14 = cmt_status[12 +:5];
wire s15;
reg [11:0] s16;
reg s17;
reg [3:0] s18;
wire s19;
wire s20;
reg [EXTVALEN - 1:0] s21;
wire s22;
reg [EXTVALEN - 1:0] s23;
wire [EXTVALEN - 1:0] s24;
wire s25;
wire s26;
wire [EXTVALEN - 1:0] s27;
wire s28;
wire s29;
reg [EXTVALEN - 1:0] s30;
wire [EXTVALEN - 1:0] s31;
reg [1:0] s32;
wire [1:0] s33;
wire [1:0] s34;
wire s35;
wire s36;
wire s37;
wire s38;
wire s39 = s21[EXTVALEN - 1:IDX_LSB] == cmt_va[EXTVALEN - 1:IDX_LSB];
wire prf_valid;
wire s40;
wire s41;
wire s42;
reg prf_inflight;
wire s43;
wire s44;
reg s45;
wire s46;
wire s47;
reg s48;
wire s49;
wire s50;
wire s51;
wire s52;
reg [4:0] s53;
wire s54 = s53 == nbload_resp_rd;
wire s55;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s0 <= {{(FSM_BITS - 1){1'b0}},1'b1};
    end
    else if (s2) begin
        s0 <= s1;
    end
end

always @(posedge core_clk) begin
    if (s15) begin
        s16 <= cmt_pc;
        s17 <= s9;
        s18 <= s12;
    end
end

always @(posedge core_clk) begin
    if (s22) begin
        s21 <= cmt_va;
    end
end

always @(posedge core_clk) begin
    if (s25) begin
        s23 <= s24;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s48 <= 1'b0;
    end
    else if (s49) begin
        s48 <= s50;
    end
end

always @(posedge core_clk) begin
    if (s51) begin
        s53 <= s14;
    end
end

always @* begin
    s1 = {FSM_BITS{1'b0}};
    case (1'b1)
        s0[INVALID]: begin
            s1[INIT] = 1'b1;
            s2 = cmt_valid & cmt_init & prefetch_en;
        end
        s0[INIT]: begin
            if (s55) begin
                s1[INVALID] = 1'b1;
                s2 = 1'b1;
            end
            else if (cmt_init) begin
                s1[INIT] = 1'b1;
                s2 = cmt_valid;
            end
            else begin
                s1[TRANSIENT] = 1'b1;
                s2 = s26;
            end
        end
        s0[TRANSIENT]: begin
            if (s55) begin
                s1[INVALID] = 1'b1;
                s2 = 1'b1;
            end
            else if (cmt_init) begin
                s1[INIT] = 1'b1;
                s2 = cmt_valid;
            end
            else if (s28) begin
                s1[STEADY] = 1'b1;
                s2 = s26;
            end
            else begin
                s1[INIT] = 1'b1;
                s2 = s26;
            end
        end
        s0[STEADY]: begin
            if (s55) begin
                s1[INVALID] = 1'b1;
                s2 = 1'b1;
            end
            else if (cmt_init) begin
                s1[INIT] = 1'b1;
                s2 = cmt_valid;
            end
            else if (s28) begin
                s1[STEADY] = 1'b1;
                s2 = s26;
            end
            else begin
                s1[INIT] = 1'b1;
                s2 = s26;
            end
        end
        default: begin
            s1 = {FSM_BITS{1'b0}};
            s2 = 1'b0;
        end
    endcase
end

assign s15 = (cmt_valid & cmt_init);
assign s19 = (s16 == cmt_pc);
assign cmp_hit = s7 & s19;
assign s26 = s7 & cmt_valid & s19 & ~s39 & ~s10;
assign s22 = (cmt_valid & cmt_init) | (s7 & cmt_valid & s19 & ~s39 & ~s10);
assign s25 = (s4 & cmt_valid & s19 & ~s39) | (s5 & cmt_valid & s19 & ~s39);
assign s24 = cmt_va - s21;
assign s20 = (s17 == s9) & (s18 == s12);
assign s27 = s21 + s23;
assign s28 = (s27 == cmt_va) & s20;
assign s55 = ~prefetch_en | (prf_resp_valid & prf_resp_status) | (cmt_valid & s19 & s11) | (cmt_valid & s19 & ~s20) | (s48 & nbload_resp_valid & nbload_resp_status & s54);
assign s49 = s51 | s52;
assign s51 = cmt_valid & s13 & s8 & ~s10;
assign s52 = nbload_resp_valid & s54;
assign s50 = s51 | (s48 & ~s52);
always @(posedge core_clk) begin
    if (s29) begin
        s30 <= s31;
    end
end

always @(posedge core_clk) begin
    if (s35) begin
        s32 <= s33;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        prf_inflight <= 1'b0;
    end
    else if (s44) begin
        prf_inflight <= s43;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s45 <= 1'b0;
    end
    else if (s47) begin
        s45 <= s46;
    end
end

assign s40 = s32[1:0] == 2'd3;
assign s35 = s36 | s37 | s38;
assign s36 = (s5 & s28 & s26) | (s6 & s28 & s26 & ~|s32);
assign s37 = s42;
assign s38 = (s6 & s28 & s26);
assign s34 = s32 + {1'b0,s37} - {1'b0,s38};
assign s33 = s36 ? 2'd0 : s34;
assign s29 = s36 | s42;
assign s31 = ({EXTVALEN{s5}} & cmt_va) | ({EXTVALEN{s6}} & prf_va);
assign s41 = prf_valid & prf_ready;
assign s42 = prf_ack_valid & ~prf_ack_replay & s45;
assign prf_pc = s16;
assign prf_va = s30 + s23;
assign prf_vm = s17;
assign prf_mtype = s18;
assign s44 = s41 | prf_ack_valid;
assign s43 = s41 | (prf_inflight & ~prf_ack_valid);
assign s47 = s41 | s36;
assign s46 = ~s36 & (s45 | s41);
assign prf_valid = s6 & ~s40 & ~prf_inflight & ~s55;
assign standby_ready = ~(s6 & ~s40) & ~prf_inflight;
endmodule


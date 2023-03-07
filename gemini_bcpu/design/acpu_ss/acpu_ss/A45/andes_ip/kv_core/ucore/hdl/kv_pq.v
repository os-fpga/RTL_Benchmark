// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_pq (
    core_clk,
    core_reset_n,
    bpu_rd_ack,
    bpu_info_hit,
    bpu_info_fall_thru_pc,
    bpu_info_target,
    bpu_info_start_pc,
    bpu_info_offset,
    bpu_info_way,
    bpu_info_ucond,
    bpu_info_ret,
    bpu_info_pred_taken,
    bpu_info_pred_cnt,
    bpu_rd_ready,
    bpu_rd_valid,
    resume,
    resume_pc,
    retry,
    retry_pc,
    redirect,
    redirect_for_cti,
    redirect_pc,
    f0_valid,
    f0_pc,
    f0_vectored,
    f0_bblk_start,
    fetch_req_ready,
    fetch_req_valid,
    seq_pc,
    fetch_resp_valid,
    fetch_resp_valid_raw,
    fetch_normal,
    fetch_recover,
    recover_entry_update,
    target_pc,
    target_bblk_start,
    target_pred_taken,
    target_rd_low_word_only,
    ifu_i0_pc,
    ifu_i0_pred_valid,
    ifu_i0_pred_way,
    ifu_i0_pred_taken,
    ifu_i0_pred_ret,
    ifu_i0_pred_cnt,
    ifu_i0_pred_npc,
    ifu_i0_pred_brk,
    ifu_i0_keep_bhr,
    ifu_i0_pred_hit,
    ifu_i0_bblk_start,
    ifu_i0_32b,
    ifu_i0_issue,
    ifu_i1_pc,
    ifu_i1_pred_valid,
    ifu_i1_pred_way,
    ifu_i1_pred_taken,
    ifu_i1_pred_ret,
    ifu_i1_pred_cnt,
    ifu_i1_pred_npc,
    ifu_i1_pred_brk,
    ifu_i1_keep_bhr,
    ifu_i1_pred_hit,
    ifu_i1_bblk_start,
    ifu_i1_32b,
    ifu_i1_issue,
    no_addr_valid_stall,
    fetch_nxt_seq_kill_needed_f2,
    fetch_end_offset,
    resp_raw_is_bblk_end_f2
);
parameter VALEN = 32;
parameter EXTVALEN = 32;
parameter BTB_SIZE = 0;
localparam UNUSED_PC_BIT_NUM = 1;
localparam BBLK_START_PC_WIDTH = VALEN - UNUSED_PC_BIT_NUM;
localparam BBLK_OFFSET_WIDTH = 10;
localparam BBLK_PCNT_WIDTH = 4;
localparam BBLK_HIT_WAY_WIDTH = 2;
localparam BBLK_PRED_TAKEN_WIDTH = 1;
localparam BBLK_DATA_WIDTH = BBLK_START_PC_WIDTH + BBLK_OFFSET_WIDTH + 4 + 1 + 2 + 1;
localparam BBLK_RET_BIT = 0;
localparam BBLK_PCNT_LSB = BBLK_RET_BIT + 1;
localparam BBLK_PCNT_MSB = BBLK_PCNT_LSB + BBLK_PCNT_WIDTH - 1;
localparam BBLK_HIT_WAY_LSB = BBLK_PCNT_MSB + 1;
localparam BBLK_HIT_WAY_MSB = BBLK_HIT_WAY_LSB + BBLK_HIT_WAY_WIDTH - 1;
localparam BBLK_PRED_TAKEN_BIT = BBLK_HIT_WAY_MSB + 1;
localparam BBLK_OFFSET_LSB = BBLK_PRED_TAKEN_BIT + 1;
localparam BBLK_OFFSET_MSB = BBLK_OFFSET_LSB + BBLK_OFFSET_WIDTH - 1;
localparam BBLK_START_PC_LSB = BBLK_OFFSET_MSB + 1;
localparam BBLK_START_PC_MSB = BBLK_START_PC_LSB + BBLK_START_PC_WIDTH - 1;
localparam BBLK_Q_DEPTH = 5;
localparam BBLK_Q_PTR_MSB = 3;
localparam BBLK_Q_WRAP_NUM = 3'd4;
localparam BBLK_Q_WRAP_NUM_DEC1 = 3'd3;
input core_clk;
input core_reset_n;
input resume;
input [EXTVALEN - 1:0] resume_pc;
input retry;
input [EXTVALEN - 1:0] retry_pc;
input redirect;
input [EXTVALEN - 1:0] redirect_pc;
input redirect_for_cti;
input f0_valid;
input [EXTVALEN - 1:0] f0_pc;
input f0_vectored;
input f0_bblk_start;
input fetch_req_valid;
input fetch_req_ready;
input [VALEN - 1:0] seq_pc;
input [3:0] fetch_resp_valid;
input [3:0] fetch_resp_valid_raw;
input fetch_normal;
input fetch_recover;
input recover_entry_update;
input bpu_rd_ack;
input bpu_info_hit;
input [VALEN - 1:0] bpu_info_fall_thru_pc;
input [VALEN - 1:0] bpu_info_target;
input [VALEN - 1:0] bpu_info_start_pc;
input [9:0] bpu_info_offset;
input [1:0] bpu_info_way;
input bpu_info_ucond;
input bpu_info_ret;
input bpu_info_pred_taken;
input [3:0] bpu_info_pred_cnt;
input bpu_rd_ready;
output bpu_rd_valid;
output [VALEN - 1:0] target_pc;
output target_bblk_start;
output target_pred_taken;
output target_rd_low_word_only;
output [EXTVALEN - 1:0] ifu_i0_pc;
output ifu_i0_pred_valid;
output [1:0] ifu_i0_pred_way;
output ifu_i0_pred_taken;
output ifu_i0_pred_ret;
output [3:0] ifu_i0_pred_cnt;
output ifu_i0_pred_brk;
output [VALEN - 1:0] ifu_i0_pred_npc;
output ifu_i0_keep_bhr;
input ifu_i0_pred_hit;
input ifu_i0_bblk_start;
input ifu_i0_32b;
input ifu_i0_issue;
output [EXTVALEN - 1:0] ifu_i1_pc;
output ifu_i1_pred_valid;
output [1:0] ifu_i1_pred_way;
output ifu_i1_pred_taken;
output ifu_i1_pred_ret;
output [3:0] ifu_i1_pred_cnt;
output ifu_i1_pred_brk;
output [VALEN - 1:0] ifu_i1_pred_npc;
output ifu_i1_keep_bhr;
input ifu_i1_pred_hit;
input ifu_i1_bblk_start;
input ifu_i1_32b;
input ifu_i1_issue;
output no_addr_valid_stall;
output fetch_nxt_seq_kill_needed_f2;
output [3:0] fetch_end_offset;
output resp_raw_is_bblk_end_f2;


wire s0 = ifu_i0_32b;
wire s1 = ifu_i0_bblk_start;
wire s2 = ifu_i0_issue;
wire s3 = ifu_i1_32b;
wire s4 = ifu_i1_bblk_start;
wire s5 = ifu_i1_issue;
generate
    if (BTB_SIZE != 0) begin:gen_btb_pred_yes
        wire s6 = 1'b1;
        wire [VALEN - 1:0] s7;
        reg s8;
        wire s9;
        reg [BBLK_DATA_WIDTH - 1:0] s10[0:BBLK_Q_DEPTH - 1];
        reg [BBLK_Q_PTR_MSB:0] s11;
        wire [BBLK_Q_PTR_MSB:0] s12;
        wire s13;
        reg [BBLK_Q_PTR_MSB:0] s14;
        wire [BBLK_Q_PTR_MSB:0] s15;
        wire s16;
        reg [BBLK_Q_PTR_MSB:0] s17;
        wire [BBLK_Q_PTR_MSB:0] s18;
        wire s19;
        reg [BBLK_Q_PTR_MSB:0] s20;
        wire [BBLK_Q_PTR_MSB:0] s21;
        wire s22;
        wire [BBLK_Q_PTR_MSB - 1:0] s23;
        wire [BBLK_DATA_WIDTH - 1:0] s24;
        wire s25;
        wire s26;
        wire s27;
        wire [BBLK_Q_PTR_MSB:0] s28;
        wire [BBLK_Q_PTR_MSB:0] s29;
        wire [BBLK_Q_PTR_MSB:0] s30;
        wire [BBLK_Q_PTR_MSB:0] s31;
        wire [BBLK_Q_PTR_MSB:0] s32;
        wire s33;
        reg [VALEN - 1:0] s34;
        wire [VALEN - 1:0] s35;
        wire s36;
        wire [9:0] s37;
        reg s38;
        wire s39;
        reg s40;
        reg s41;
        wire [VALEN - 1:0] s42;
        wire [VALEN - 1:0] s43;
        wire [VALEN - 1:0] s44;
        wire [EXTVALEN - 1:0] s45;
        reg [EXTVALEN - 1:0] s46;
        wire [EXTVALEN - 1:0] s47;
        wire s48;
        reg [EXTVALEN - 1:0] s49;
        wire [EXTVALEN - 1:0] s50;
        wire s51;
        reg s52;
        wire s53;
        wire s54;
        wire s55;
        wire [EXTVALEN - 1:0] s56;
        wire [EXTVALEN - 1:0] s57;
        wire [EXTVALEN - 1:0] s58;
        wire [EXTVALEN - 1:0] s59;
        wire s60;
        wire [BBLK_DATA_WIDTH - 1:0] s61;
        wire [BBLK_DATA_WIDTH - 1:0] s62;
        wire [BBLK_DATA_WIDTH - 1:0] s63;
        wire [BBLK_DATA_WIDTH - 1:0] s64;
        reg s65;
        wire s66;
        wire s67;
        wire s68;
        wire s69;
        reg s70;
        reg s71;
        wire s72;
        reg s73;
        wire s74;
        wire s75;
        wire s76;
        wire s77;
        reg s78;
        wire s79;
        wire s80;
        wire s81;
        wire s82;
        wire s83;
        wire s84;
        reg [9:0] s85;
        wire [9:0] s86;
        wire [9:0] s87;
        wire [9:0] s88;
        wire [9:0] s89;
        wire [9:0] s90;
        wire [9:0] s91;
        wire [9:0] s92;
        wire [9:0] s93;
        wire [9:0] s94;
        wire [9:0] s95;
        wire [9:0] s96;
        wire [9:0] s97;
        wire [9:0] s98;
        wire [BBLK_DATA_WIDTH - 1:0] s99;
        wire [BBLK_DATA_WIDTH - 1:0] s100;
        wire s101;
        reg [9:0] s102;
        reg [BBLK_Q_PTR_MSB:0] s103;
        wire [9:0] s104;
        reg [9:0] s105;
        wire [9:0] s106;
        wire s107;
        wire [9:0] s108;
        wire [9:0] s109;
        wire [9:0] s110;
        wire [9:0] s111;
        wire [9:0] s112;
        wire [9:0] s113;
        wire s114;
        wire s115;
        wire s116;
        reg s117;
        wire s118;
        wire s119;
        wire s120;
        wire s121;
        wire s122;
        wire s123;
        wire s124;
        wire s125;
        wire s126;
        wire s127;
        wire s128;
        wire s129;
        wire s130;
        wire s131;
        wire [9:0] s132 = s85 - bpu_info_offset;
        wire [9:0] s133 = bpu_info_offset - s85;
        wire [9:0] s134 = s37 - s85;
        wire s135 = fetch_req_ready & fetch_req_valid;
        wire s136 = bpu_rd_ack & bpu_info_hit & s71;
        wire s137 = redirect | resume | retry;
        wire [BBLK_Q_PTR_MSB - 1:0] s138 = {BBLK_Q_PTR_MSB{1'b0}};
        wire [BBLK_Q_PTR_MSB - 1:0] s139 = {{BBLK_Q_PTR_MSB - 1{1'b0}},1'b1};
        wire [BBLK_Q_PTR_MSB:0] s140 = {BBLK_Q_PTR_MSB + 1{1'b0}};
        wire [BBLK_Q_PTR_MSB:0] s141 = {{BBLK_Q_PTR_MSB{1'b0}},1'b1};
        assign s131 = redirect | resume | retry | (s135 & fetch_normal) | s9 | s39 | s33 | fetch_recover;
        assign s93 = ({10{s6}} & s87) | ({10{~s6}} & s90);
        assign s94 = ({10{s6}} & s88) | ({10{~s6}} & s91);
        assign s95 = ({10{s6}} & s89) | ({10{~s6}} & s92);
        assign s96 = f0_valid ? s94 : s95;
        wire [9:0] s142;
        wire [9:0] s143;
        assign s142 = s135 ? s93 : 10'b0;
        assign s143 = s135 ? s95 : 10'b0;
        assign s86 = resume ? 10'b0 : redirect ? s142 : retry ? 10'b0 : fetch_recover ? s102 : s9 ? 10'b0 : s39 ? 10'b0 : f0_valid & fetch_normal ? s94 + s85 : s33 ? s143 : s95 + s85;
        assign s87 = (redirect_pc[2:1] == 2'b00) ? 10'd4 : (redirect_pc[2:1] == 2'b01) ? 10'd3 : (redirect_pc[2:1] == 2'b10) ? 10'd2 : 10'd1;
        assign s90 = {8'b0,~redirect_pc[2],redirect_pc[2]};
        assign s88 = (f0_pc[2:1] == 2'b00) ? 10'd4 : (f0_pc[2:1] == 2'b01) ? 10'd3 : (f0_pc[2:1] == 2'b10) ? 10'd2 : 10'd1;
        assign s91 = {8'b0,~f0_pc[2],f0_pc[2]};
        assign s89 = (target_pc[2:1] == 2'b00) ? 10'd4 : (target_pc[2:1] == 2'b01) ? 10'd3 : (target_pc[2:1] == 2'b10) ? 10'd2 : 10'd1;
        assign s92 = {8'b0,~target_pc[2],target_pc[2]};
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s85 <= 10'b0;
            end
            else if (s131) begin
                s85 <= s86;
            end
        end

        assign s7 = bpu_info_target;
        assign s74 = (redirect & fetch_req_ready & ~resume) | (f0_valid & fetch_req_ready & ~s136 & s25 & f0_bblk_start & ~s137 & fetch_normal) | (s33 & fetch_req_ready & ~s137 & ~recover_entry_update & fetch_normal) | (s8 & fetch_req_ready & ~s137 & ~recover_entry_update & fetch_normal) | (s38 & fetch_req_ready & s25 & ~s136 & ~s137 & ~recover_entry_update & fetch_normal) | (s83 & fetch_req_ready & s25 & ~s136 & ~s137 & ~recover_entry_update & fetch_normal);
        assign s75 = s136 | s137 | recover_entry_update;
        assign s76 = (s73 & ~s75) | s74;
        assign s77 = s74 | s75;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s73 <= 1'b0;
            end
            else if (s77) begin
                s73 <= s76;
            end
        end

        assign s33 = s73 & s136 & (~(|s85[9:4])) & (~(|bpu_info_offset[9:4])) & (s85[3:0] >= bpu_info_offset[3:0]);
        assign fetch_nxt_seq_kill_needed_f2 = s73 & s136 & (((s132 >= 10'd4) & s6) | ((s132 >= 10'd2) & ~s6)) & (s85 >= bpu_info_offset);
        assign s9 = s136 & s135 & fetch_normal & ~redirect & ~s33 & s25 & (s133 <= s96);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s8 <= 1'b0;
            end
            else begin
                s8 <= s9;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s34 <= {VALEN{1'b0}};
                s41 <= 1'b0;
            end
            else if (s136) begin
                s34 <= s7;
                s41 <= bpu_info_pred_taken;
            end
        end

        assign s35 = {s64[BBLK_START_PC_MSB:BBLK_START_PC_LSB],{UNUSED_PC_BIT_NUM{1'b0}}};
        assign s36 = s64[BBLK_PRED_TAKEN_BIT];
        assign s37 = s64[BBLK_OFFSET_MSB:BBLK_OFFSET_LSB];
        assign s39 = (s134 <= s96) & ~s25 & s135 & fetch_normal & ~redirect;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s38 <= 1'b0;
            end
            else begin
                s38 <= s39;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s40 <= 1'b0;
            end
            else if (s39) begin
                s40 <= s36;
            end
        end

        reg [VALEN - 1:0] s144;
        reg s145;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s144 <= {VALEN{1'b0}};
                s145 <= 1'b0;
            end
            else if (s66 & ~s67) begin
                s144 <= target_pc;
                s145 <= target_pred_taken;
            end
        end

        assign s66 = s33 | s8 | s38;
        assign s67 = s135 | s137 | recover_entry_update | fetch_recover;
        assign s68 = (s66 | s83) & ~s67;
        assign s69 = s66 | s67;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s65 <= 1'b0;
            end
            else if (s69) begin
                s65 <= s68;
            end
        end

        assign s83 = s65;
        assign target_pc[VALEN - 1:0] = s33 ? s7 : s8 ? s34 : s38 & s25 ? s34 : s38 ? s35 : s83 ? s144 : seq_pc;
        assign target_bblk_start = s33 | s8 | s38 | s83;
        assign target_pred_taken = s33 ? (bpu_info_pred_taken | fetch_nxt_seq_kill_needed_f2) : s8 ? s41 : s38 & s25 ? s41 : s38 ? s40 : s145;
        reg s146;
        wire s147;
        wire s148;
        wire s149;
        wire s150;
        wire s151;
        wire [9:0] s152 = s95 + s85;
        wire [9:0] s153 = s37 - s152;
        wire s154 = ~s25 & ~s38;
        assign s147 = (s154 & s135 & ~f0_valid & (s153 == 10'd1) & ~s137 & fetch_normal) | (s154 & s135 & ~f0_valid & (s153 == 10'd2) & ~s137 & fetch_normal & s6);
        assign s148 = s135 | s137 | fetch_recover;
        assign s149 = (s146 & ~s148) | s147;
        assign s150 = s147 | s148;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s146 <= 1'b0;
            end
            else if (s150) begin
                s146 <= s149;
            end
        end

        assign s151 = ~s25 & s38;
        assign target_rd_low_word_only = (s151 & (s37 == 10'd1) & ~s35[2] & ~s137) | (s151 & (s37 == 10'd2) & ~(|s35[2:1]) & ~s137 & s6) | (s146 & ~s137);
        integer s155;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                for (s155 = 0; s155 < BBLK_Q_DEPTH; s155 = s155 + 1)
                s10[s155] <= {BBLK_DATA_WIDTH{1'b0}};
            end
            else if (s136) begin
                s10[s23] <= s24;
            end
        end

        assign s24 = {bpu_info_start_pc[VALEN - 1:VALEN - BBLK_START_PC_WIDTH],bpu_info_offset,bpu_info_pred_taken,bpu_info_way,bpu_info_pred_cnt,bpu_info_ret};
        assign s64 = s10[s11[BBLK_Q_PTR_MSB - 1:0]];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s11 <= s140;
            end
            else if (s13) begin
                s11 <= s12;
            end
        end

        assign s12 = (resume | redirect | retry) ? s140 : fetch_recover ? s103 : s29;
        assign s13 = resume | redirect | retry | s9 | s33 | s39 | fetch_recover;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s20 <= s140;
            end
            else if (s22) begin
                s20 <= s21;
            end
        end

        assign s23 = s20[BBLK_Q_PTR_MSB - 1:0];
        assign s21 = (resume | redirect | retry) ? s140 : s28;
        assign s22 = s136 | resume | redirect | retry;
        assign s122 = (bpu_info_offset[1:0] == 2'b01);
        assign s123 = (bpu_info_offset[1:0] == 2'b10);
        assign s124 = (bpu_info_offset[1:0] == 2'b11);
        assign s125 = (bpu_info_offset[1:0] == 2'b00);
        assign s126 = (s105[1:0] == 2'b01);
        assign s127 = (s105[1:0] == 2'b10);
        assign s128 = (s105[1:0] == 2'b11);
        assign s129 = (s105[1:0] == 2'b00);
        assign s110[9:3] = 7'b0;
        assign s110[2] = fetch_resp_valid[3];
        assign s110[1] = ~fetch_resp_valid[3] & (fetch_resp_valid[2] | fetch_resp_valid[1]);
        assign s110[0] = ~fetch_resp_valid[3] & (fetch_resp_valid[2] | fetch_resp_valid[0] & ~fetch_resp_valid[1]);
        assign s111[9:2] = 8'b0;
        assign s111[1] = fetch_resp_valid[3];
        assign s111[0] = fetch_resp_valid[1] & ~fetch_resp_valid[3];
        assign s112[9:3] = 7'b0;
        assign s112[2] = fetch_resp_valid_raw[3];
        assign s112[1] = ~fetch_resp_valid_raw[3] & (fetch_resp_valid_raw[2] | fetch_resp_valid_raw[1]);
        assign s112[0] = ~fetch_resp_valid_raw[3] & (fetch_resp_valid_raw[2] | fetch_resp_valid_raw[0] & ~fetch_resp_valid_raw[1]);
        assign s113[9:2] = 8'b0;
        assign s113[1] = fetch_resp_valid_raw[3];
        assign s113[0] = fetch_resp_valid_raw[1] & ~fetch_resp_valid_raw[3];
        assign s108 = s6 ? s110 : s111;
        assign s109 = s6 ? s112 : s113;
        assign s99 = s10[s14[BBLK_Q_PTR_MSB - 1:0]];
        assign s100 = s10[s30[BBLK_Q_PTR_MSB - 1:0]];
        assign s97 = s99[BBLK_OFFSET_MSB:BBLK_OFFSET_LSB];
        assign s98 = s100[BBLK_OFFSET_MSB:BBLK_OFFSET_LSB];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s14 <= s140;
            end
            else if (s16) begin
                s14 <= s15;
            end
        end

        assign s15 = (resume | redirect | retry) ? s140 : fetch_recover ? s103 : s30;
        assign s16 = resume | redirect | s130 | fetch_recover | retry;
        assign s101 = (s14 == s20);
        assign s130 = (|fetch_resp_valid) & (s114 | s115);
        assign s114 = (s101 & (s109 >= bpu_info_offset) & s136);
        assign s115 = (~s101 & (s109 >= s105));
        assign resp_raw_is_bblk_end_f2 = (s114 | s115);
        assign s116 = (s20 == s30);
        assign s107 = ((s14 == s20) & s136) | (|fetch_resp_valid & s115 & ~s116 & ~recover_entry_update) | (|fetch_resp_valid & s115 & s136 & ~recover_entry_update) | (|fetch_resp_valid & ~recover_entry_update);
        assign s106 = ((s14 == s20) & s136) ? (|fetch_resp_valid) ? bpu_info_offset - s109 : bpu_info_offset : (s115 & ~s116) ? s98 : (s115 & s136) ? bpu_info_offset : s105 - s109;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s105 <= 10'b0;
            end
            else if (s107) begin
                s105 <= s106;
            end
        end

        assign fetch_end_offset = ~resp_raw_is_bblk_end_f2 ? 4'b1000 : (s14 == s20) ? s6 ? {s125,s124,s123,s122} : {s123,1'b0,s122,1'b0} : s6 ? {s129,s128,s127,s126} : {s127,1'b0,s126,1'b0};
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s17 <= s140;
            end
            else if (s19) begin
                s17 <= s18;
            end
        end

        assign s18 = (resume | redirect | retry) ? s140 : (ifu_i0_pred_hit & s2 & ifu_i1_pred_hit & s5) ? s32 : s31;
        assign s19 = resume | redirect | retry | ifu_i0_pred_hit & s2 | ifu_i1_pred_hit & s5;
        assign s25 = (s11 == s20);
        assign s26 = (s17 == s20);
        assign s28 = (s20[BBLK_Q_PTR_MSB - 1:0] == BBLK_Q_WRAP_NUM) ? {~s20[BBLK_Q_PTR_MSB],s138} : s20 + s141;
        assign s29 = (s11[BBLK_Q_PTR_MSB - 1:0] == BBLK_Q_WRAP_NUM) ? {~s11[BBLK_Q_PTR_MSB],s138} : s11 + s141;
        assign s30 = (s14[BBLK_Q_PTR_MSB - 1:0] == BBLK_Q_WRAP_NUM) ? {~s14[BBLK_Q_PTR_MSB],s138} : s14 + s141;
        assign s31 = (s17[BBLK_Q_PTR_MSB - 1:0] == BBLK_Q_WRAP_NUM) ? {~s17[BBLK_Q_PTR_MSB],s138} : s17 + s141;
        assign s32 = (s17[BBLK_Q_PTR_MSB - 1:0] == BBLK_Q_WRAP_NUM) ? {~s17[BBLK_Q_PTR_MSB],s139} : (s17[BBLK_Q_PTR_MSB - 1:0] == BBLK_Q_WRAP_NUM_DEC1) ? {~s17[BBLK_Q_PTR_MSB],s138} : s17 + {{BBLK_Q_PTR_MSB - 1{1'b0}},2'b10};
        assign s72 = (s20[BBLK_Q_PTR_MSB - 1:0] == s17[BBLK_Q_PTR_MSB - 1:0]) & (s20[BBLK_Q_PTR_MSB] != s17[BBLK_Q_PTR_MSB]);
        assign s27 = (s28[BBLK_Q_PTR_MSB - 1:0] == s17[BBLK_Q_PTR_MSB - 1:0]) & (s28[BBLK_Q_PTR_MSB] != s17[BBLK_Q_PTR_MSB]);
        reg s156;
        wire s157;
        wire s158;
        wire s159;
        wire s160;
        assign s157 = bpu_rd_ack & ~s136 | redirect | resume | retry;
        assign s158 = redirect & redirect_for_cti & ~resume;
        assign s159 = (s156 | s157) & ~s158;
        assign s160 = s157 | s158;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s156 <= 1'b1;
            end
            else if (s160) begin
                s156 <= s159;
            end
        end

        assign s82 = bpu_rd_valid & bpu_rd_ready;
        assign bpu_rd_valid = (redirect & redirect_for_cti) | (s136 & ~s27 & ~redirect) | (~s70 & ~s71 & ~s72 & ~s156 & ~redirect);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s70 <= 1'b0;
                s71 <= 1'b0;
            end
            else begin
                s70 <= s82 & ~resume & ~(retry & ~(redirect & redirect_for_cti));
                s71 <= s70 & ~s137;
            end
        end

        assign s61 = s10[s17[BBLK_Q_PTR_MSB - 1:0]];
        assign s62 = s10[s31[BBLK_Q_PTR_MSB - 1:0]];
        assign s63 = s10[s32[BBLK_Q_PTR_MSB - 1:0]];
        assign s42 = {s61[BBLK_START_PC_MSB:BBLK_START_PC_LSB],{UNUSED_PC_BIT_NUM{1'b0}}};
        assign s43 = {s62[BBLK_START_PC_MSB:BBLK_START_PC_LSB],{UNUSED_PC_BIT_NUM{1'b0}}};
        assign s44 = {s63[BBLK_START_PC_MSB:BBLK_START_PC_LSB],{UNUSED_PC_BIT_NUM{1'b0}}};
        assign s45 = s52 ? s49 : s46;
        assign s48 = s2 | resume | redirect | retry;
        assign s56 = s1 ? ifu_i0_pc : s45;
        assign s47 = resume ? resume_pc : redirect ? redirect_pc : retry ? retry_pc : s56 + s58;
        assign s51 = s5;
        assign s57 = s4 ? ifu_i1_pc : s56 + s58;
        assign s50 = s57 + s59;
        assign s53 = s5 & ~s137;
        assign s54 = s137 | s2;
        assign s55 = (s52 & ~s54) | s53;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s46 <= {EXTVALEN{1'b0}};
            end
            else if (s48) begin
                s46 <= s47;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s49 <= {EXTVALEN{1'b0}};
            end
            else if (s51) begin
                s49 <= s50;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s52 <= 1'b0;
            end
            else begin
                s52 <= s55;
            end
        end

        assign s58 = {{(EXTVALEN - 3){1'b0}},s0,~s0,1'b0};
        assign s59 = {{(EXTVALEN - 3){1'b0}},s3,~s3,1'b0};
        assign s84 = ~s26 & (s31 != s20);
        assign s60 = s84 & (s32 != s20);
        reg s161;
        wire s162;
        assign s162 = resume ? resume_pc[EXTVALEN - 1] : redirect ? redirect_pc[EXTVALEN - 1] : retry_pc[EXTVALEN - 1];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s161 <= 1'b0;
            end
            else if (s137) begin
                s161 <= s162;
            end
        end

        assign s79 = s137;
        assign s80 = s2;
        assign s81 = (s78 & ~s80) | s79;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s78 <= 1'b1;
            end
            else begin
                s78 <= s81;
            end
        end

        wire [VALEN - 1:0] s163;
        wire [VALEN - 1:0] s164;
        wire [VALEN:0] s165;
        wire [VALEN:0] s166;
        assign s163 = (s1 & s26 & ~s78) ? s34 : (s1 & ~s26) ? s42 : s45[VALEN - 1:0];
        assign s164 = ~s4 ? s163 + {{(VALEN - 3){1'b0}},s0,~s0,1'b0} : s84 ? s43 : s34;
        kv_sign_ext #(
            .OW(VALEN + 1),
            .IW(VALEN)
        ) u_ifu_i0_pc_sext (
            .out(s165),
            .in(s163)
        );
        kv_sign_ext #(
            .OW(VALEN + 1),
            .IW(VALEN)
        ) u_ifu_i1_pc_sext (
            .out(s166),
            .in(s164)
        );
        assign ifu_i0_pc = s78 ? {s161,s163[EXTVALEN - 2:0]} : s165[EXTVALEN - 1:0];
        assign ifu_i1_pc = s166[EXTVALEN - 1:0];
        wire s167;
        wire s168;
        assign s167 = 1'b0;
        assign s168 = 1'b0;
        assign ifu_i0_keep_bhr = 1'b0;
        assign ifu_i0_pred_valid = ~s26 | s167;
        assign ifu_i0_pred_way = s61[BBLK_HIT_WAY_MSB:BBLK_HIT_WAY_LSB];
        assign ifu_i0_pred_ret = s61[BBLK_RET_BIT];
        assign ifu_i0_pred_cnt = s61[BBLK_PCNT_MSB:BBLK_PCNT_LSB];
        assign ifu_i0_pred_taken = (s61[BBLK_PRED_TAKEN_BIT] & ifu_i0_pred_hit) | s168;
        assign ifu_i0_pred_npc = s84 ? s43[VALEN - 1:0] : s34[VALEN - 1:0];
        assign ifu_i0_pred_brk = s117;
        assign s118 = redirect & ~redirect_for_cti | retry & ~redirect;
        assign s119 = resume | (redirect & redirect_for_cti);
        assign s120 = (s118 | s117) & ~s119;
        assign s121 = s118 | s119;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s117 <= 1'b0;
            end
            else if (s121) begin
                s117 <= s120;
            end
        end

        wire s169;
        wire s170;
        assign s169 = 1'b0;
        assign s170 = 1'b0;
        assign ifu_i1_keep_bhr = 1'b0;
        assign ifu_i1_pred_valid = (s4 ? s84 : ~s26) | s169;
        assign ifu_i1_pred_way = s4 ? s62[BBLK_HIT_WAY_MSB:BBLK_HIT_WAY_LSB] : s61[BBLK_HIT_WAY_MSB:BBLK_HIT_WAY_LSB];
        assign ifu_i1_pred_ret = s4 ? s62[BBLK_RET_BIT] : s61[BBLK_RET_BIT];
        assign ifu_i1_pred_cnt = s4 ? s62[BBLK_PCNT_MSB:BBLK_PCNT_LSB] : s61[BBLK_PCNT_MSB:BBLK_PCNT_LSB];
        assign ifu_i1_pred_taken = (s4 ? s62[BBLK_PRED_TAKEN_BIT] & ifu_i1_pred_hit : s61[BBLK_PRED_TAKEN_BIT] & ifu_i1_pred_hit) | s170;
        assign ifu_i1_pred_npc = ~ifu_i0_pred_hit ? s84 ? s43[VALEN - 1:0] : s34[VALEN - 1:0] : s60 ? s44[VALEN - 1:0] : s34[VALEN - 1:0];
        assign ifu_i1_pred_brk = 1'b0;
        assign no_addr_valid_stall = (~bpu_rd_ready & redirect & redirect_for_cti) | (~bpu_rd_ready & f0_valid & ~s70 & ~s71) | (~bpu_rd_ready & s33) | (~bpu_rd_ready & s8) | (~bpu_rd_ready & s38 & s25) | (~bpu_rd_ready & s83 & s25) | (s72 & s25 & ~redirect) | (s27 & s136 & s73);
        assign s104 = ((s14 == s20) & s73) ? 10'b0 : ((s14 == s20) & (s85 == 10'b0)) ? 10'b0 : s97 - s105;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s102 <= 10'b0;
                s103 <= {BBLK_Q_PTR_MSB + 1{1'b0}};
            end
            else if (recover_entry_update) begin
                s102 <= s104;
                s103 <= s14;
            end
        end

        wire nds_unused_f0_vectored = f0_vectored;
    end
    else begin:gen_btb_pred_no
        reg [EXTVALEN - 1:0] s45;
        wire [EXTVALEN - 1:0] s171;
        wire s172;
        wire [EXTVALEN - 1:0] s58;
        wire [EXTVALEN - 1:0] s59;
        wire [EXTVALEN - 1:0] s173;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s45 <= {EXTVALEN{1'b0}};
            end
            else if (s172) begin
                s45 <= s171;
            end
        end

        assign s58 = {{(EXTVALEN - 3){1'b0}},s0,~s0,1'b0} & {EXTVALEN{s2}};
        assign s59 = {{(EXTVALEN - 3){1'b0}},s3,~s3,1'b0} & {EXTVALEN{s5}};
        assign s173 = s45 + s58 + s59;
        assign s172 = resume | redirect | s2 | s5 | retry;
        assign s171 = resume ? resume_pc : redirect ? redirect_pc : retry ? retry_pc : s173;
        assign ifu_i0_pc = f0_vectored ? f0_pc[EXTVALEN - 1:0] : s45;
        assign ifu_i1_pc = ifu_i0_pc + s58;
        assign target_pc[VALEN - 1:0] = seq_pc[VALEN - 1:0];
        assign ifu_i0_pred_valid = 1'b0;
        assign ifu_i0_pred_way = 2'b0;
        assign ifu_i0_pred_taken = 1'b0;
        assign ifu_i0_pred_ret = 1'b0;
        assign ifu_i0_pred_cnt = 4'b0;
        assign ifu_i0_pred_npc = {VALEN{1'b0}};
        assign ifu_i1_pred_valid = 1'b0;
        assign ifu_i1_pred_way = 2'b0;
        assign ifu_i1_pred_taken = 1'b0;
        assign ifu_i1_pred_ret = 1'b0;
        assign ifu_i1_pred_cnt = 4'b0;
        assign ifu_i1_pred_npc = {VALEN{1'b0}};
        assign ifu_i0_pred_brk = 1'b0;
        assign target_bblk_start = 1'b0;
        assign ifu_i0_keep_bhr = 1'b0;
        assign ifu_i1_keep_bhr = 1'b0;
        assign no_addr_valid_stall = 1'b0;
        assign fetch_nxt_seq_kill_needed_f2 = 1'b0;
        assign fetch_end_offset = 4'b1000;
        assign resp_raw_is_bblk_end_f2 = 1'b0;
        assign bpu_rd_valid = 1'b0;
        assign ifu_i1_pred_brk = 1'b0;
        assign target_pred_taken = 1'b0;
        assign target_rd_low_word_only = 1'b0;
    end
endgenerate
wire [VALEN - 1:0] s174 = bpu_info_fall_thru_pc;
wire nds_unused_bpu_info_ucond = bpu_info_ucond;
endmodule


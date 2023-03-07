// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_trigger (
    core_clk,
    core_reset_n,
    csr_halt_mode,
    cur_privilege_m,
    cur_privilege_s,
    cur_privilege_u,
    csr_satp_asid,
    csr_mcontext,
    csr_scontext,
    csr_tcontrol_mte,
    selected,
    i0_pc,
    i1_pc,
    ls_load,
    ls_store,
    ls_addr,
    int_code,
    xcpt_onehot,
    prev_dmode,
    prev_chain,
    dmode,
    chain,
    next_dmode,
    csr_tdata1_we,
    csr_tdata2_we,
    csr_tdata3_we,
    csr_wdata,
    icount_enabled,
    icount_dec,
    icount_clr,
    trace_enabled,
    tinfo,
    tdata1,
    tdata2,
    tdata3,
    i0_matched,
    i1_matched,
    ls_matched,
    int_matched,
    xcpt_matched,
    icount_matched,
    action_xcpt,
    action_halt,
    action_trace_on,
    action_trace_off,
    action_trace_notify
);
parameter CONFIGURED = 1'b0;
parameter VALEN = 32;
parameter NUM_PRIVILEGE_LEVELS = 1;
parameter LOCALINT_SLPECC = 16;
parameter LOCALINT_SBE = 17;
parameter LOCALINT_HPMINT = 18;
parameter SUPPORT_ICOUNT = 1'b1;
parameter SUPPORT_ITRIGGER = 1'b1;
parameter SUPPORT_ETRIGGER = 1'b1;
parameter SUPPORT_MCONTROL = 1'b1;
parameter SUPPORT_MCONTROL_CHAIN = 1'b1;
parameter TRACE_INTERFACE_INT = 0;
localparam MATCH_EQ = 4'd0;
localparam MATCH_MASK = 4'd1;
localparam MATCH_GE = 4'd2;
localparam MATCH_LT = 4'd3;
localparam ACTION_ST_BREAK = 6'd0;
localparam ACTION_ST_HALT = 6'd1;
localparam ACTION_ST_TRACE_ON = 6'd2;
localparam ACTION_ST_TRACE_OFF = 6'd3;
localparam ACTION_ST_TRACE_NOTIFY = 6'd4;
localparam TRIGGER_MATCH_BITS = (CONFIGURED != 1'b0) ? 2 : 0;
localparam TYPE_NONE = 4'd0;
localparam TYPE_ADDR_DATA_MATCH = 4'd2;
localparam TYPE_ICOUNT = 4'd3;
localparam TYPE_ITRIGGER = 4'd4;
localparam TYPE_ETRIGGER = 4'd5;
localparam TEXTRA_MVALUE_WIDTH = 6;
localparam TEXTRA_MVALUE_MSB = 31;
localparam TEXTRA_MVALUE_LSB = TEXTRA_MVALUE_MSB - TEXTRA_MVALUE_WIDTH + 1;
localparam TEXTRA_MSELECT = TEXTRA_MVALUE_LSB - 1;
localparam TEXTRA_ZERO_WIDTH = 14;
localparam TEXTRA_ZERO_MSB = TEXTRA_MSELECT - 1;
localparam TEXTRA_ZERO_LSB = TEXTRA_ZERO_MSB - TEXTRA_ZERO_WIDTH + 1;
localparam TEXTRA_SVALUE_WIDTH = 9;
localparam TEXTRA_SVALUE_MSB = TEXTRA_ZERO_LSB - 1;
localparam TEXTRA_SVALUE_LSB = TEXTRA_SVALUE_MSB - TEXTRA_SVALUE_WIDTH + 1;
localparam TEXTRA_SSELECT_MSB = 1;
localparam TEXTRA_SSELECT_LSB = 0;
input core_clk;
input core_reset_n;
input csr_halt_mode;
input cur_privilege_m;
input cur_privilege_s;
input cur_privilege_u;
input [8:0] csr_satp_asid;
input [31:0] csr_mcontext;
input [31:0] csr_scontext;
input csr_tcontrol_mte;
input selected;
input [VALEN - 1:0] i0_pc;
input [VALEN - 1:0] i1_pc;
input ls_load;
input ls_store;
input [VALEN - 1:0] ls_addr;
input [4:0] int_code;
input [16:0] xcpt_onehot;
input prev_dmode;
input prev_chain;
output dmode;
output chain;
input next_dmode;
input csr_tdata1_we;
input csr_tdata2_we;
input csr_tdata3_we;
input [31:0] csr_wdata;
output icount_enabled;
input icount_dec;
input icount_clr;
output trace_enabled;
output [31:0] tinfo;
output [31:0] tdata1;
output [31:0] tdata2;
output [31:0] tdata3;
output i0_matched;
output i1_matched;
output ls_matched;
output int_matched;
output xcpt_matched;
output icount_matched;
output action_xcpt;
output action_halt;
output action_trace_on;
output action_trace_off;
output action_trace_notify;


wire s0 = TRACE_INTERFACE_INT == 1;
wire s1 = 1'b0;
assign tinfo[0] = ~CONFIGURED;
assign tinfo[1] = 1'b0;
assign tinfo[2] = CONFIGURED & SUPPORT_MCONTROL;
assign tinfo[3] = CONFIGURED & SUPPORT_ICOUNT;
assign tinfo[4] = CONFIGURED & SUPPORT_ITRIGGER;
assign tinfo[5] = CONFIGURED & SUPPORT_ETRIGGER;
assign tinfo[31:6] = {26{1'b0}};
wire s2 = (csr_wdata[31:28] == TYPE_ADDR_DATA_MATCH);
wire s3 = (csr_wdata[31:28] == TYPE_ICOUNT);
wire s4 = csr_wdata[27];
wire s5 = (next_dmode & ~s4) ? 1'b0 : csr_wdata[11];
wire s6 = prev_chain & ~prev_dmode & s4 & s2;
wire s7;
wire s8;
wire s9;
wire s10;
wire s11;
wire s12;
wire s13;
wire s14;
wire [3:0] s15;
wire [13:0] s16 = 14'b1;
wire s17;
wire [5:0] s18;
wire s19 = 1'b0;
wire s20 = 1'b0;
wire [5:0] s21 = (TRIGGER_MATCH_BITS > 0) ? 6'd12 : 6'd0;
wire s22;
wire [3:0] s23;
wire [VALEN - 1:0] s24;
wire [5:0] s25;
wire [TEXTRA_MVALUE_WIDTH - 1:0] s26;
wire s27;
wire [8:0] s28;
wire [1:0] s29;
wire [31:0] tdata1;
wire [31:0] s30;
wire [31:0] s31;
wire [31:0] s32;
wire [31:0] tdata2;
wire [31:0] tdata3;
wire [31:0] s33;
wire s34;
wire s35;
wire s36;
wire s37 = ~s1 & icount_clr & s36 & s13;
wire s38 = (s15 == MATCH_MASK);
wire s39 = SUPPORT_MCONTROL & (s23 == TYPE_ADDR_DATA_MATCH);
wire s40 = SUPPORT_ICOUNT & (s23 == TYPE_ICOUNT);
wire s41 = SUPPORT_ITRIGGER & (s23 == TYPE_ITRIGGER);
wire s42 = SUPPORT_ETRIGGER & (s23 == TYPE_ETRIGGER);
wire s43 = s40;
wire s44 = s41;
wire s45 = s42;
wire s46 = s44 | s45;
wire s47 = (SUPPORT_ICOUNT & (csr_wdata[31:28] == TYPE_ICOUNT)) | (SUPPORT_ITRIGGER & (csr_wdata[31:28] == TYPE_ITRIGGER)) | (SUPPORT_ETRIGGER & (csr_wdata[31:28] == TYPE_ETRIGGER));
wire [3:0] s48 = s47 ? csr_wdata[31:28] : TYPE_ADDR_DATA_MATCH;
assign s30[0] = s7;
assign s30[1] = s8;
assign s30[2] = s9;
assign s30[3] = s12;
assign s30[4] = s11;
assign s30[5] = 1'b0;
assign s30[6] = s10;
assign s30[10:7] = s15;
assign s30[11] = s17;
assign s30[17:12] = s18;
assign s30[18] = s19;
assign s30[19] = s20;
assign s30[20:20] = {1{1'b0}};
assign s30[26:21] = s21;
assign s30[27] = s22;
assign s30[31:28] = s23;
assign s31[5:0] = s18;
assign s31[6] = s12;
assign s31[7] = s11;
assign s31[8] = s13 & s1;
assign s31[9] = s10;
assign s31[23:10] = s16;
assign s31[26:24] = {3{1'b0}};
assign s31[27] = s22;
assign s31[31:28] = s23;
assign s32[5:0] = s18;
assign s32[6] = s12;
assign s32[7] = s11;
assign s32[8] = 1'b0;
assign s32[9] = s10;
assign s32[10] = s42 ? s14 : 1'b0;
assign s32[26:11] = {16{1'b0}};
assign s32[27] = s22;
assign s32[31:28] = s23;
assign tdata1 = s43 ? s31 : s46 ? s32 : s30;
kv_zero_ext #(
    .OW(32),
    .IW(VALEN)
) u_tdata2 (
    .out(tdata2),
    .in(s24)
);
kv_zero_ext #(
    .OW(TEXTRA_MVALUE_WIDTH),
    .IW(6)
) u_trig_mvalue_extend (
    .out(s26),
    .in(s25)
);
assign s33[TEXTRA_MVALUE_MSB:TEXTRA_MVALUE_LSB] = s26;
assign s33[TEXTRA_MSELECT] = s27;
assign s33[TEXTRA_ZERO_MSB:TEXTRA_ZERO_LSB] = {TEXTRA_ZERO_WIDTH{1'b0}};
assign s33[TEXTRA_SVALUE_MSB:TEXTRA_SVALUE_LSB] = s28;
assign s33[TEXTRA_SSELECT_MSB:TEXTRA_SSELECT_LSB] = s29;
assign tdata3 = s33;
wire s49 = selected & csr_tdata1_we & (~s22 | csr_halt_mode) & ~s6;
wire s50 = selected & csr_tdata2_we & (~s22 | csr_halt_mode);
wire s51 = selected & csr_tdata3_we & (~s22 | csr_halt_mode);
generate
    if (CONFIGURED != 1'b0) begin:gen_reg_trig
        reg [VALEN - 1:0] s52;
        reg s53;
        reg s54;
        reg s55;
        reg [2:0] s56;
        wire [2:0] s57;
        reg s58;
        reg s59;
        wire s60;
        reg [2:0] s61;
        reg [5:0] s62;
        reg s63;
        wire [5:0] s64;
        wire [5:0] s65;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s52 <= {VALEN{1'b0}};
            end
            else if (s50) begin
                s52 <= csr_wdata[VALEN - 1:0];
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s53 <= 1'b0;
                s54 <= 1'b0;
                s55 <= 1'b0;
                s58 <= 1'b0;
            end
            else if (s49) begin
                s53 <= s2 & csr_wdata[0] & ~csr_wdata[2];
                s54 <= s2 & csr_wdata[1] & ~csr_wdata[2];
                s55 <= s2 & csr_wdata[2];
                s58 <= SUPPORT_MCONTROL_CHAIN & s2 & s5;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s59 <= 1'b0;
            end
            else if (s60) begin
                s59 <= csr_wdata[27];
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s56 <= 3'b0;
                s61 <= 3'd2;
            end
            else if (s49) begin
                s56 <= s57;
                s61 <= s48[2:0];
            end
        end

        assign s64 = s2 ? {2'd0,csr_wdata[15:12]} : csr_wdata[5:0];
        assign s65 = ({6{(s64 == ACTION_ST_HALT) & csr_halt_mode & csr_wdata[27]}} & ACTION_ST_HALT) | ({6{(s64 == ACTION_ST_TRACE_ON) & s0}} & ACTION_ST_TRACE_ON) | ({6{(s64 == ACTION_ST_TRACE_OFF) & s0}} & ACTION_ST_TRACE_OFF) | ({6{(s64 == ACTION_ST_TRACE_NOTIFY) & s0}} & ACTION_ST_TRACE_NOTIFY);
        assign s57 = s65[2:0];
        assign s60 = s49 & csr_halt_mode;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s62 <= 6'b0;
                s63 <= 1'b0;
            end
            else if (s51) begin
                s62 <= csr_wdata[TEXTRA_MVALUE_LSB + 5:TEXTRA_MVALUE_LSB];
                s63 <= csr_wdata[TEXTRA_MSELECT];
            end
        end

        assign s24 = s52;
        assign s7 = s53;
        assign s8 = s54;
        assign s9 = s55;
        assign s18 = {3'd0,s56};
        assign s17 = SUPPORT_MCONTROL_CHAIN & s58;
        assign s22 = s59;
        assign s23 = {1'b0,s61};
        assign s25 = s62;
        assign s27 = s63;
    end
    else begin:gen_reg_trig_dummy
        assign s24 = {VALEN{1'b0}};
        assign s7 = 1'b0;
        assign s8 = 1'b0;
        assign s9 = 1'b0;
        assign s18 = 6'd0;
        assign s17 = 1'd0;
        assign s22 = 1'd0;
        assign s23 = 4'd0;
        assign s25 = 6'd0;
        assign s27 = 1'b0;
    end
endgenerate
generate
    if (CONFIGURED != 1'b0) begin:gen_trig_m_nmi_1
        reg s66;
        wire s67;
        wire s68;
        reg s69;
        wire s70;
        wire s71;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s66 <= 1'b0;
            end
            else if (s68) begin
                s66 <= s67;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s69 <= 1'b0;
            end
            else if (s71) begin
                s69 <= s70;
            end
        end

        assign s68 = s49 | s37;
        assign s67 = s37 ? 1'b0 : s2 ? csr_wdata[6] : csr_wdata[9];
        assign s10 = s66;
        assign s71 = s49 & (csr_wdata[31:28] == TYPE_ETRIGGER);
        assign s70 = csr_wdata[10];
        assign s14 = s69;
    end
    else begin:gen_trig_m_nmi_0
        assign s10 = 1'b0;
        assign s14 = 1'b0;
    end
endgenerate
generate
    if ((CONFIGURED != 1'b0) && (NUM_PRIVILEGE_LEVELS > 2)) begin:gen_trig_s_1
        reg s72;
        wire s73;
        wire s74;
        reg [8:0] s75;
        reg [1:0] s76;
        wire [1:0] s77;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s72 <= 1'b0;
            end
            else if (s74) begin
                s72 <= s73;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s75 <= 9'b0;
                s76 <= 2'b0;
            end
            else if (s51) begin
                s75 <= csr_wdata[TEXTRA_SVALUE_MSB:TEXTRA_SVALUE_LSB];
                s76 <= s77;
            end
        end

        assign s74 = s49 | s37;
        assign s73 = s37 ? 1'b0 : s2 ? csr_wdata[4] : csr_wdata[7];
        assign s77 = (csr_wdata[TEXTRA_SSELECT_MSB:TEXTRA_SSELECT_LSB] == 2'd3) ? 2'd00 : csr_wdata[TEXTRA_SSELECT_MSB:TEXTRA_SSELECT_LSB];
        assign s11 = s72;
        assign s28 = s75;
        assign s29 = s76;
    end
    else begin:gen_trig_s_0
        assign s11 = 1'b0;
        assign s28 = 9'd0;
        assign s29 = 2'd0;
    end
endgenerate
generate
    if ((CONFIGURED != 1'b0) && (NUM_PRIVILEGE_LEVELS > 1)) begin:gen_trig_u_1
        reg s78;
        wire s79;
        wire s80;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s78 <= 1'b0;
            end
            else if (s80) begin
                s78 <= s79;
            end
        end

        assign s80 = s49 | s37;
        assign s79 = s37 ? 1'b0 : s2 ? csr_wdata[3] : csr_wdata[6];
        assign s12 = s78;
    end
    else begin:gen_trig_u_0
        assign s12 = 1'b0;
    end
endgenerate
generate
    if ((CONFIGURED != 1'b0) && (SUPPORT_ICOUNT == 1'b1)) begin:gen_trig_pending
        reg s81;
        wire s82;
        wire s83;
        wire s84;
        wire s85;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s81 <= 1'b0;
            end
            else if (s83) begin
                s81 <= s82;
            end
        end

        assign s83 = (s49 & s3) | s84 | s85;
        assign s84 = icount_dec & s35;
        assign s85 = icount_dec & s36;
        assign s82 = s84 ? 1'b1 : s85 ? 1'b0 : csr_wdata[8];
        assign s13 = s81;
    end
    else begin:gen_trig_pending_stub
        assign s13 = 1'b0;
    end
endgenerate
generate
    if (TRIGGER_MATCH_BITS > 0) begin:gen_reg_trig_match
        reg [TRIGGER_MATCH_BITS - 1:0] s86;
        wire [TRIGGER_MATCH_BITS - 1:0] s87 = |csr_wdata[10:TRIGGER_MATCH_BITS + 7] ? {TRIGGER_MATCH_BITS{1'b0}} : csr_wdata[TRIGGER_MATCH_BITS + 6:7];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s86 <= {TRIGGER_MATCH_BITS{1'b0}};
            end
            else if (s49) begin
                s86 <= s87;
            end
        end

        assign s15[0 +:TRIGGER_MATCH_BITS] = s86[0 +:TRIGGER_MATCH_BITS];
    end
endgenerate
generate
    if (TRIGGER_MATCH_BITS < 4) begin:gen_zero_extend_trig_match
        assign s15[3:TRIGGER_MATCH_BITS] = {(4 - TRIGGER_MATCH_BITS){1'b0}};
    end
endgenerate
reg [VALEN - 1:0] s88;
always @* begin
    casez ({s38,tdata2[11:0]})
        13'b1_???????????0: s88 = {{(VALEN - 1){1'b1}},1'b0};
        13'b1_??????????01: s88 = {{(VALEN - 2){1'b1}},2'b0};
        13'b1_?????????011: s88 = {{(VALEN - 3){1'b1}},3'b0};
        13'b1_????????0111: s88 = {{(VALEN - 4){1'b1}},4'b0};
        13'b1_???????01111: s88 = {{(VALEN - 5){1'b1}},5'b0};
        13'b1_??????011111: s88 = {{(VALEN - 6){1'b1}},6'b0};
        13'b1_?????0111111: s88 = {{(VALEN - 7){1'b1}},7'b0};
        13'b1_????01111111: s88 = {{(VALEN - 8){1'b1}},8'b0};
        13'b1_???011111111: s88 = {{(VALEN - 9){1'b1}},9'b0};
        13'b1_??0111111111: s88 = {{(VALEN - 10){1'b1}},10'b0};
        13'b1_?01111111111: s88 = {{(VALEN - 11){1'b1}},11'b0};
        13'b1_011111111111: s88 = {{(VALEN - 12){1'b1}},12'b0};
        default: s88 = {(VALEN){1'b1}};
    endcase
end

wire s89 = ((tdata2[VALEN - 1:0] & s88) == (i0_pc & s88));
wire s90 = (TRIGGER_MATCH_BITS > 1) & (i0_pc >= tdata2[VALEN - 1:0]);
wire s91 = ((tdata2[VALEN - 1:0] & s88) == (i1_pc & s88));
wire s92 = (TRIGGER_MATCH_BITS > 1) & (i1_pc >= tdata2[VALEN - 1:0]);
wire s93 = ((tdata2[VALEN - 1:0] & s88) == (ls_addr & s88));
wire s94 = (TRIGGER_MATCH_BITS > 1) & (ls_addr >= tdata2[VALEN - 1:0]);
wire s95 = ((s15 == MATCH_EQ) & s89) | ((s15 == MATCH_MASK) & s89) | ((s15 == MATCH_GE) & s90) | ((s15 == MATCH_LT) & ~s90);
wire s96 = ((s15 == MATCH_EQ) & s91) | ((s15 == MATCH_MASK) & s91) | ((s15 == MATCH_GE) & s92) | ((s15 == MATCH_LT) & ~s92);
wire s97 = ((s15 == MATCH_EQ) & s93) | ((s15 == MATCH_MASK) & s93) | ((s15 == MATCH_GE) & s94) | ((s15 == MATCH_LT) & ~s94);
wire s98 = (s10 & cur_privilege_m & (csr_tcontrol_mte | (s18 != ACTION_ST_BREAK))) | (s11 & cur_privilege_s) | (s12 & cur_privilege_u);
wire s99 = ((s27 == 1'b0) | (s25 == csr_mcontext[5:0])) & ((s29 == 2'd0) | ((s29 == 2'd1) & (s28 == csr_scontext[8:0])) | ((s29 == 2'd2) & (s28 == csr_satp_asid)));
wire s100 = (s7 & ls_load) | (s8 & ls_store);
wire s101 = (tdata2[0] & (int_code[4:0] == 5'd0)) | (tdata2[1] & (int_code[4:0] == 5'd1)) | (tdata2[3] & (int_code[4:0] == 5'd3)) | (tdata2[4] & (int_code[4:0] == 5'd4)) | (tdata2[5] & (int_code[4:0] == 5'd5)) | (tdata2[7] & (int_code[4:0] == 5'd7)) | (tdata2[8] & (int_code[4:0] == 5'd8)) | (tdata2[9] & (int_code[4:0] == 5'd9)) | (tdata2[11] & (int_code[4:0] == 5'd11)) | (tdata2[LOCALINT_SLPECC] & (int_code[4:0] == LOCALINT_SLPECC[4:0])) | (tdata2[LOCALINT_SBE] & (int_code[4:0] == LOCALINT_SBE[4:0])) | (tdata2[LOCALINT_HPMINT] & (int_code[4:0] == LOCALINT_HPMINT[4:0]));
wire s102 = |(tdata2[15:0] & xcpt_onehot[15:0]);
wire s103 = s14 & xcpt_onehot[16];
assign i0_matched = s9 & s39 & s98 & s99 & s95;
assign i1_matched = s9 & s39 & s98 & s99 & s96;
assign ls_matched = s100 & s39 & s98 & s99 & s97;
assign int_matched = s101 & s44 & s98 & s99;
assign xcpt_matched = s45 & ((s102 & s98) | s103) & s99;
assign icount_enabled = s40;
assign s35 = (s40 & s98 & s99);
assign s34 = (s40 & s98 & s99);
assign s36 = (s1 & s40 & s98 & s99) | (~s1 & s40);
assign icount_matched = s13 & s34;
assign action_halt = (s18 == ACTION_ST_HALT);
assign action_xcpt = (s18 == ACTION_ST_BREAK);
assign action_trace_on = (s18 == ACTION_ST_TRACE_ON);
assign action_trace_off = (s18 == ACTION_ST_TRACE_OFF);
assign action_trace_notify = (s18 == ACTION_ST_TRACE_NOTIFY);
assign dmode = s22;
assign chain = s39 & s17;
assign trace_enabled = s39 & (action_trace_on | action_trace_off | action_trace_notify) & s0;
generate
    if (CONFIGURED == 1'b0) begin:gen_nds_unused
        wire nds_unused_core_clk = core_clk;
        wire nds_unused_core_reset_n = core_reset_n;
        wire nds_unused_icount_dec = icount_dec;
        wire nds_unused_wdata_chain = s5;
        wire nds_unused_tdata1_we = s49;
        wire nds_unused_tdata2_we = s50;
        wire nds_unused_tdata3_we = s51;
        wire [3:0] nds_unused_reg_trig_type_nx = s48;
    end
endgenerate
endmodule


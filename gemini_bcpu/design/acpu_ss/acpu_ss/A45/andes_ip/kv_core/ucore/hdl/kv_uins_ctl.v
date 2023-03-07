// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_uins_ctl (
    core_clk,
    core_reset_n,
    cur_privilege_m,
    cur_privilege_s,
    cur_privilege_u,
    csr_halt_mode,
    csr_mcache_ctl_cctl_suen,
    ifu_valid,
    ifu_i0_instr,
    ifu_i1_instr,
    ifu_i0_pc,
    ifu_i1_pc,
    id_i1_instr,
    id_i0_instr,
    id_i0_ready,
    id_i1_ready,
    id_i0_alive,
    id_i1_alive,
    id_i0_pc,
    id_i1_pc,
    id_uinstr_pred_info,
    id_uinstr_pred_npc,
    id_uinstr_ctrl,
    id_uinstr_sel,
    id_uinstr_ready,
    id_uinstr_pc,
    id_uinstr_imm12,
    ifd_kill,
    ifd_i1_dec_ctrl,
    ifd_i0_dec_ctrl,
    ifd_i1_pred_info,
    ifd_i0_pred_info,
    ifd_i1_pred_npc,
    ifd_i0_pred_npc,
    uinstr_redirect,
    uinstr_redirect_pc,
    uinstr_flush,
    uinstr_done
);
parameter EXTVALEN = 32;
parameter UINS_PCLEN = 32;
parameter ICACHE_SIZE_KB = 32;
parameter DCACHE_SIZE_KB = 32;
parameter STLB_ECC_TYPE = 0;
parameter STACKSAFE_SUPPORT_INT = 0;
localparam IDLE = 0;
localparam ISSUE_SYNC = 1;
localparam CS_UCODE = 2;
localparam CS_ORG_INS = 3;
localparam STATES = 4;
input core_clk;
input core_reset_n;
input csr_halt_mode;
input cur_privilege_m;
input cur_privilege_s;
input cur_privilege_u;
input csr_mcache_ctl_cctl_suen;
input [31:0] ifu_i0_instr;
input [31:0] ifu_i1_instr;
input [1:0] ifu_valid;
input [EXTVALEN - 1:0] ifu_i0_pc;
input [EXTVALEN - 1:0] ifu_i1_pc;
input [322:0] ifd_i0_dec_ctrl;
input [322:0] ifd_i1_dec_ctrl;
input [11:0] ifd_i0_pred_info;
input [11:0] ifd_i1_pred_info;
input [EXTVALEN - 1:0] ifd_i0_pred_npc;
input [EXTVALEN - 1:0] ifd_i1_pred_npc;
input [1:0] ifd_kill;
input id_i0_ready;
input id_i1_ready;
output id_i0_alive;
output id_i1_alive;
output [EXTVALEN - 1:0] id_i0_pc;
output [EXTVALEN - 1:0] id_i1_pc;
output [31:0] id_i1_instr;
output [31:0] id_i0_instr;
output [322:0] id_uinstr_ctrl;
output [11:0] id_uinstr_pred_info;
output [EXTVALEN - 1:0] id_uinstr_pred_npc;
output [31:0] id_uinstr_imm12;
output id_uinstr_sel;
output id_uinstr_ready;
output [UINS_PCLEN - 3:0] id_uinstr_pc;
input uinstr_redirect;
input [UINS_PCLEN - 1:0] uinstr_redirect_pc;
input uinstr_flush;
input uinstr_done;


wire s0;
wire s1;
wire prgbuf_en;
wire s2;
wire [UINS_PCLEN - 3:0] s3;
wire [UINS_PCLEN - 3:0] prgbuf_update_pc;
wire [UINS_PCLEN - 3:0] s4;
wire s5;
wire s6;
wire [40:0] s7;
wire id_uinstr_sel;
wire uinstr_end;
wire s8;
wire s9;
wire s10;
wire [15:0] s11;
wire [1:0] s12;
wire s13;
wire s14;
wire s15;
wire s16;
wire [7:0] s17;
wire [7:0] s18;
wire s19;
wire s20;
wire s21;
reg [EXTVALEN - 1:0] s22;
wire [EXTVALEN - 1:0] s23;
reg [31:0] s24;
wire [31:0] s25;
wire s26;
wire sync_ins;
wire s27;
wire s28;
wire s29;
wire s30;
wire [43:0] uinstr_ctrl;
wire [43:0] s31;
wire [43:0] s32;
wire [43:0] s33;
reg [43:0] s34;
wire [31:0] s35;
wire ucode_exe;
wire [3:0] ucode_idx;
wire [2:0] pp_ucode_ctrl;
wire pp_ucode_xcpt;
wire pp_ucode_last;
wire pp_init_pc_en;
wire [3:0] pp_init_pc;
wire [11:0] pp_offset;
wire [11:0] pp_stackadj;
wire [2:0] pp_ucode_ctrl_ext;
wire [1:0] pp_pred_ctrl_ext;
wire pp_step_ctrl_ext;
reg [STATES - 1:0] s36;
reg [STATES - 1:0] s37;
reg s38;
assign s0 = ifu_valid[0] & ~ifd_kill[0];
assign id_i0_alive = s28 ? s0 : ~s8;
assign id_i0_pc = s28 ? ifu_i0_pc : s22;
assign id_i0_instr = s28 ? ifu_i0_instr : s24;
assign s8 = uinstr_redirect;
assign s1 = ifu_valid[1] & ~ifd_kill[1];
assign id_i1_alive = s1 & ~s9;
assign id_i1_pc = ifu_i1_pc;
assign id_i1_instr = ifu_i1_instr;
assign s9 = s14 | s21;
assign s20 = s14 & ~ifd_i0_dec_ctrl[304];
assign s21 = s15 & ~ifd_i1_dec_ctrl[304];
assign id_uinstr_sel = ~s28 | (s20 & s28);
assign id_uinstr_ready = s28;
assign s28 = s36[IDLE];
assign s29 = s36[CS_UCODE];
assign s30 = s36[CS_ORG_INS];
assign s27 = s36[ISSUE_SYNC];
assign sync_ins = s27 | s28;
assign s5 = s0 & s20;
assign s6 = s1 & s21;
assign s11 = s7[12 +:16];
assign uinstr_end = s30;
assign s10 = s11[1];
assign s12 = {s18[5],s17[5]};
assign s13 = pp_ucode_last;
assign s2 = s27 | s28 | pp_init_pc_en | s13;
assign s3 = pp_init_pc_en ? {{(UINS_PCLEN - 6){1'b0}},pp_init_pc} : s16 ? {{(UINS_PCLEN - 4){1'b0}},{2'b10}} : {(UINS_PCLEN - 2){1'b0}};
assign prgbuf_en = (s29 & id_i0_ready) | s2 | uinstr_redirect;
assign s4 = id_uinstr_pc + {{(UINS_PCLEN - 3){1'b0}},1'b1};
assign prgbuf_update_pc = s2 ? s3 : uinstr_redirect ? uinstr_redirect_pc[UINS_PCLEN - 1:2] : s4;
assign s26 = uinstr_flush | uinstr_done;
always @* begin
    s37 = {STATES{1'b0}};
    case (1'b1)
        s36[IDLE]: begin
            if (s26) begin
                s37[IDLE] = 1'b1;
                s38 = 1'b1;
            end
            else if (s5) begin
                s37[CS_UCODE] = 1'b1;
                s38 = id_i0_ready;
            end
            else if (s6) begin
                s37[ISSUE_SYNC] = 1'b1;
                s38 = id_i0_ready & (~s12[1] | id_i1_ready);
            end
            else begin
                s38 = 1'b0;
            end
        end
        s36[ISSUE_SYNC]: begin
            if (s26) begin
                s37[IDLE] = 1'b1;
                s38 = 1'b1;
            end
            else begin
                s37[CS_UCODE] = 1'b1;
                s38 = id_i0_ready;
            end
        end
        s36[CS_UCODE]: begin
            if (s26) begin
                s37[IDLE] = 1'b1;
                s38 = 1'b1;
            end
            else if (uinstr_redirect) begin
                s37[CS_UCODE] = 1'b1;
                s38 = 1'b1;
            end
            else if (s13) begin
                s37[IDLE] = 1'b1;
                s38 = id_i0_ready;
            end
            else if (s10) begin
                s37[CS_ORG_INS] = 1'b1;
                s38 = id_i0_ready;
            end
            else begin
                s38 = 1'b0;
            end
        end
        s36[CS_ORG_INS]: begin
            if (s26) begin
                s37[IDLE] = 1'b1;
                s38 = 1'b1;
            end
            else if (s10) begin
                s37[CS_ORG_INS] = 1'b1;
                s38 = id_i0_ready;
            end
            else begin
                s37[CS_UCODE] = 1'b1;
                s38 = id_i0_ready;
            end
        end
        default: begin
            s37 = {STATES{1'b0}};
            s38 = 1'b0;
        end
    endcase
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s36 <= {{(STATES - 1){1'b0}},1'b1};
    end
    else if (s38) begin
        s36 <= s37;
    end
end

kv_uins_dec kv_uins_dec_i0(
    .id_instr(id_i0_instr),
    .id_dec_ctrl(uinstr_ctrl),
    .instr_csrwi(s16),
    .uins_instr(s14),
    .instr_index(s17)
);
kv_uins_dec kv_uins_dec_i1(
    .id_instr(id_i1_instr),
    .id_dec_ctrl(s32),
    .instr_csrwi(s19),
    .uins_instr(s15),
    .instr_index(s18)
);
assign s23 = s14 ? ifu_i0_pc : ifu_i1_pc;
assign s25 = s14 ? ifu_i0_instr : ifu_i1_instr;
assign s33 = s14 ? s31 : s32;
assign uinstr_ctrl = s28 ? s31 : s34;
assign s31[2] = ifd_i0_dec_ctrl[87];
assign s31[1] = ifd_i0_dec_ctrl[86];
assign s31[7] = ifd_i0_dec_ctrl[181];
assign s31[8] = ifd_i0_dec_ctrl[182];
assign s31[6] = ifd_i0_dec_ctrl[168];
assign s31[0] = ifd_i0_dec_ctrl[42];
assign s31[17 +:21] = ifd_i0_dec_ctrl[228 +:21];
assign s31[38 +:5] = ifd_i0_dec_ctrl[267 +:5];
assign s31[13 +:4] = ifd_i0_dec_ctrl[221 +:4];
assign s31[3 +:2] = ifd_i0_dec_ctrl[100 +:2];
assign s31[12] = ifd_i0_dec_ctrl[216];
assign s31[9 +:3] = ifd_i0_dec_ctrl[213 +:3];
assign s31[43] = ifd_i0_dec_ctrl[294];
assign s31[5] = ifd_i0_dec_ctrl[140];
assign s32[2] = ifd_i1_dec_ctrl[87];
assign s32[1] = ifd_i1_dec_ctrl[86];
assign s32[7] = ifd_i1_dec_ctrl[181];
assign s32[8] = ifd_i1_dec_ctrl[182];
assign s32[6] = ifd_i1_dec_ctrl[168];
assign s32[0] = ifd_i1_dec_ctrl[42];
assign s32[38 +:5] = ifd_i1_dec_ctrl[267 +:5];
assign s32[17 +:21] = ifd_i1_dec_ctrl[228 +:21];
assign s32[13 +:4] = ifd_i1_dec_ctrl[221 +:4];
assign s32[3 +:2] = ifd_i1_dec_ctrl[100 +:2];
assign s32[12] = ifd_i1_dec_ctrl[216];
assign s32[9 +:3] = ifd_i1_dec_ctrl[213 +:3];
assign s32[43] = ifd_i1_dec_ctrl[294];
assign s32[5] = ifd_i1_dec_ctrl[140];
wire s39 = ((s20 & s0) | (s21 & s1)) & s28;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s22 <= {EXTVALEN{1'b0}};
        s24 <= 32'b0;
        s34 <= {44{1'b0}};
    end
    else if (s39) begin
        s22 <= s23;
        s24 <= s25;
        s34 <= s33;
    end
end

kv_uins_ctrl_ext #(
    .STACKSAFE_SUPPORT_INT(STACKSAFE_SUPPORT_INT)
) kv_uins_ctrl_ext (
    .pp_step_ctrl_ext(pp_step_ctrl_ext),
    .pp_pred_ctrl_ext(pp_pred_ctrl_ext),
    .pp_ucode_ctrl_ext(pp_ucode_ctrl_ext),
    .uinstr_ctrl(s7),
    .uinstr_end(uinstr_end),
    .uinstr_imm12(id_uinstr_imm12),
    .csr_halt_mode(csr_halt_mode),
    .sync_ins(sync_ins),
    .id_dec_ctrl(s34),
    .id_uinstr_ctrl(id_uinstr_ctrl)
);
kv_uins_prgbuf #(
    .UINS_PCLEN(UINS_PCLEN),
    .STLB_ECC_TYPE(STLB_ECC_TYPE),
    .ICACHE_SIZE_KB(ICACHE_SIZE_KB),
    .DCACHE_SIZE_KB(DCACHE_SIZE_KB)
) kv_uins_prgbuf (
    .core_reset_n(core_reset_n),
    .core_clk(core_clk),
    .sync_uins_sel(sync_ins),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .id_uinstr(id_i0_instr),
    .id_dec_ctrl(s34),
    .uinstr_end(uinstr_end),
    .prgbuf_en(prgbuf_en),
    .prgbuf_pc(id_uinstr_pc),
    .prgbuf_update_pc(prgbuf_update_pc),
    .uinstr_ctrl(s7),
    .pp_ucode_ctrl(pp_ucode_ctrl),
    .pp_ucode_xcpt(pp_ucode_xcpt),
    .pp_offset(pp_offset),
    .pp_stackadj(pp_stackadj),
    .instr_index(s17)
);
assign s35 = 32'd0;
assign ucode_exe = 1'b0;
assign ucode_idx = 4'd0;
assign pp_step_ctrl_ext = 1'b0;
assign pp_pred_ctrl_ext = 2'd0;
assign id_uinstr_pred_info = (ifd_i0_pred_info & {~id_uinstr_sel,{10{1'b1}},~id_uinstr_sel});
assign id_uinstr_pred_npc = {EXTVALEN{1'b0}};
kv_uins_pp #(
    .ABI(0)
) kv_uins_pp (
    .core_reset_n(core_reset_n),
    .core_clk(core_clk),
    .instr(s35),
    .ucode_exe(ucode_exe),
    .ucode_idx(ucode_idx),
    .pp_ucode_ctrl(pp_ucode_ctrl),
    .pp_ucode_xcpt(pp_ucode_xcpt),
    .pp_ucode_last(pp_ucode_last),
    .pp_init_pc_en(pp_init_pc_en),
    .pp_init_pc(pp_init_pc),
    .pp_offset(pp_offset),
    .pp_stackadj(pp_stackadj),
    .pp_ucode_ctrl_ext(pp_ucode_ctrl_ext)
);
wire nds_unused_csr_mcache_ctl_cctl_suen = csr_mcache_ctl_cctl_suen;
endmodule


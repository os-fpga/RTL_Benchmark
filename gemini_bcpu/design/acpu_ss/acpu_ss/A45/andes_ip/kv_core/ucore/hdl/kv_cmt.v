// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_cmt (
    core_clk,
    core_reset_n,
    csr_cur_privilege,
    hart_under_reset,
    hart_halted,
    wb_i0_alive,
    wb_i1_alive,
    wb_i0_seg_end,
    wb_i1_seg_end,
    wb_i0_pc,
    wb_i1_pc,
    wb_i0_npc,
    wb_i1_npc,
    wb_i0_tval,
    wb_i1_tval,
    wb_i0_instr,
    wb_i1_instr,
    wb_i0_ctrl,
    wb_i1_ctrl,
    wb_i0_reso_info,
    wb_i1_reso_info,
    wb_i0_16b,
    wb_i1_16b,
    wb_i0_trace_trigger,
    wb_i1_trace_trigger,
    wb_ls_ecc_code,
    wb_ls_ecc_corr,
    wb_ls_ecc_ramid,
    async_ready,
    debugint_valid,
    nmi_valid,
    mint_valid,
    sint_valid,
    uint_valid,
    mei_entry_sel,
    sei_entry_sel,
    uei_entry_sel,
    mint_vec,
    sint_vec,
    uint_vec,
    int_code,
    int_cause_detail,
    int_ecc,
    int_ecc_corr,
    int_ecc_ramid,
    int_ecc_insn,
    int_cause_interrupt,
    int_dex2dbg,
    int_ddcause,
    int_detail_cause_valid,
    reset_vector,
    csr_halt_mode,
    cur_privilege_m,
    cur_privilege_s,
    cur_privilege_u,
    csr_medeleg,
    csr_sedeleg,
    csr_mtvec,
    csr_stvec,
    csr_utvec,
    csr_dpc,
    csr_mepc,
    csr_sepc,
    csr_uepc,
    csr_dexc2dbg_iam,
    csr_dexc2dbg_iaf,
    csr_dexc2dbg_ii,
    csr_dexc2dbg_nmi,
    csr_dexc2dbg_lam,
    csr_dexc2dbg_laf,
    csr_dexc2dbg_sam,
    csr_dexc2dbg_saf,
    csr_dexc2dbg_uec,
    csr_dexc2dbg_sec,
    csr_dexc2dbg_hec,
    csr_dexc2dbg_mec,
    csr_dexc2dbg_hsp,
    csr_dexc2dbg_ace,
    csr_dexc2dbg_sbe,
    csr_dexc2dbg_ipf,
    csr_dexc2dbg_lpf,
    csr_dexc2dbg_spf,
    csr_dexc2dbg_pmov,
    csr_mmisc_ctl_vec_plic,
    resume,
    wb_i0_resume,
    wb_i0_retire,
    wb_i1_resume,
    wb_i1_retire,
    wb_postsync_resume,
    resume_pc,
    resume_ras_ptr,
    resume_vectored,
    epc_init,
    trigm_xcpt_onehot,
    trigm_xcpt_result,
    etrigger_fire,
    trigm_icount_valid,
    trigm_icount_clr,
    trigm_trace_enabled,
    ipipe_csr_cause_we,
    ipipe_csr_cause_detail_we,
    ipipe_csr_cause_interrupt,
    ipipe_csr_cause_code,
    ipipe_csr_cause_detail,
    ipipe_csr_cause_detail_pm,
    ipipe_csr_ecc_trap,
    ipipe_csr_ecc_code,
    ipipe_csr_ecc_code_en,
    ipipe_csr_ecc_corr,
    ipipe_csr_ecc_precise,
    ipipe_csr_ecc_ramid,
    ipipe_csr_ecc_insn,
    ipipe_csr_ecc_fetch,
    ipipe_csr_epc_we,
    ipipe_csr_epc_wdata,
    ipipe_csr_tval_we,
    ipipe_csr_tval_wdata,
    ipipe_csr_halt_taken,
    ipipe_csr_halt_return,
    ipipe_csr_halt_cause,
    ipipe_csr_halt_ddcause,
    ipipe_csr_nmi_taken,
    ipipe_csr_trap_taken,
    trap_handled_by_s_mode,
    trap_handled_by_u_mode,
    ipipe_csr_m_trap_return,
    ipipe_csr_s_trap_return,
    ipipe_csr_u_trap_return,
    ipipe_csr_int_delegate_u,
    ipipe_csr_int_delegate_s,
    wb_i0_instr_event,
    wb_i1_instr_event,
    ipipe_csr_inst_retire,
    ipipe_csr_pfm_inst_retire,
    gen1_trace_enabled,
    gen1_trace_ivalid,
    gen1_trace_iexception,
    gen1_trace_interrupt,
    gen1_trace_iaddr,
    gen1_trace_instr,
    gen1_trace_priv,
    gen1_trace_cause,
    gen1_trace_tval,
    trace_enabled,
    trace_stall,
    trace_itype,
    trace_cause,
    trace_tval,
    trace_priv,
    trace_iaddr,
    trace_iretire,
    trace_ilastsize,
    trace_halted,
    trace_reset,
    trace_trigger,
    ii_i0_trace_stall
);
parameter VALEN = 32;
parameter EXTVALEN = 32;
parameter DEBUG_VEC = 64'h0000_0000;
parameter CAUSE_LEN = 6;
parameter NUM_PRIVILEGE_LEVELS = 1;
parameter TRACE_INTERFACE_INT = 0;
parameter RVN_SUPPORT_INT = 0;
localparam NRET = 2;
input core_clk;
input core_reset_n;
input [1:0] csr_cur_privilege;
input hart_under_reset;
input hart_halted;
input wb_i0_alive;
input wb_i1_alive;
input wb_i0_seg_end;
input wb_i1_seg_end;
input [EXTVALEN - 1:0] wb_i0_pc;
input [EXTVALEN - 1:0] wb_i1_pc;
input [EXTVALEN - 1:0] wb_i0_npc;
input [EXTVALEN - 1:0] wb_i1_npc;
input [31:0] wb_i0_tval;
input [31:0] wb_i1_tval;
input [31:0] wb_i0_instr;
input [31:0] wb_i1_instr;
input [149:0] wb_i0_ctrl;
input [149:0] wb_i1_ctrl;
input [12:0] wb_i0_reso_info;
input [12:0] wb_i1_reso_info;
input wb_i0_16b;
input wb_i1_16b;
input [2:0] wb_i0_trace_trigger;
input [2:0] wb_i1_trace_trigger;
input [7:0] wb_ls_ecc_code;
input wb_ls_ecc_corr;
input [3:0] wb_ls_ecc_ramid;
input async_ready;
input debugint_valid;
input nmi_valid;
input mint_valid;
input sint_valid;
input uint_valid;
input mei_entry_sel;
input sei_entry_sel;
input uei_entry_sel;
input [11:0] mint_vec;
input [10:0] sint_vec;
input [9:0] uint_vec;
input [9:0] int_code;
input [2:0] int_cause_detail;
input int_ecc;
input int_ecc_corr;
input [3:0] int_ecc_ramid;
input int_ecc_insn;
input int_cause_interrupt;
input int_dex2dbg;
input [15:0] int_ddcause;
input int_detail_cause_valid;
input [VALEN - 1:0] reset_vector;
input csr_halt_mode;
input cur_privilege_m;
input cur_privilege_s;
input cur_privilege_u;
input [31:0] csr_medeleg;
input [31:0] csr_sedeleg;
input [31:0] csr_mtvec;
input [31:0] csr_stvec;
input [31:0] csr_utvec;
input [31:0] csr_dpc;
input [31:0] csr_mepc;
input [31:0] csr_sepc;
input [31:0] csr_uepc;
input csr_dexc2dbg_iam;
input csr_dexc2dbg_iaf;
input csr_dexc2dbg_ii;
input csr_dexc2dbg_nmi;
input csr_dexc2dbg_lam;
input csr_dexc2dbg_laf;
input csr_dexc2dbg_sam;
input csr_dexc2dbg_saf;
input csr_dexc2dbg_uec;
input csr_dexc2dbg_sec;
input csr_dexc2dbg_hec;
input csr_dexc2dbg_mec;
input csr_dexc2dbg_hsp;
input csr_dexc2dbg_ace;
input csr_dexc2dbg_sbe;
input csr_dexc2dbg_ipf;
input csr_dexc2dbg_lpf;
input csr_dexc2dbg_spf;
input csr_dexc2dbg_pmov;
input csr_mmisc_ctl_vec_plic;
input resume;
input wb_i0_resume;
input wb_i0_retire;
input wb_i1_resume;
input wb_i1_retire;
input wb_postsync_resume;
output [EXTVALEN - 1:0] resume_pc;
output [2:0] resume_ras_ptr;
output resume_vectored;
input epc_init;
output [16:0] trigm_xcpt_onehot;
input [4:0] trigm_xcpt_result;
output [4:0] etrigger_fire;
output trigm_icount_valid;
output trigm_icount_clr;
input trigm_trace_enabled;
output ipipe_csr_cause_we;
output ipipe_csr_cause_detail_we;
output ipipe_csr_cause_interrupt;
output [9:0] ipipe_csr_cause_code;
output [2:0] ipipe_csr_cause_detail;
output [1:0] ipipe_csr_cause_detail_pm;
output ipipe_csr_ecc_trap;
output [7:0] ipipe_csr_ecc_code;
output ipipe_csr_ecc_code_en;
output ipipe_csr_ecc_corr;
output ipipe_csr_ecc_precise;
output [3:0] ipipe_csr_ecc_ramid;
output ipipe_csr_ecc_insn;
output ipipe_csr_ecc_fetch;
output ipipe_csr_epc_we;
output [31:0] ipipe_csr_epc_wdata;
output ipipe_csr_tval_we;
output [31:0] ipipe_csr_tval_wdata;
output ipipe_csr_halt_taken;
output ipipe_csr_halt_return;
output [2:0] ipipe_csr_halt_cause;
output [15:0] ipipe_csr_halt_ddcause;
output ipipe_csr_nmi_taken;
output ipipe_csr_trap_taken;
output trap_handled_by_s_mode;
output trap_handled_by_u_mode;
output ipipe_csr_m_trap_return;
output ipipe_csr_s_trap_return;
output ipipe_csr_u_trap_return;
input ipipe_csr_int_delegate_u;
input ipipe_csr_int_delegate_s;
output [40:0] wb_i0_instr_event;
output [40:0] wb_i1_instr_event;
output [1:0] ipipe_csr_inst_retire;
output [1:0] ipipe_csr_pfm_inst_retire;
input gen1_trace_enabled;
output [NRET - 1:0] gen1_trace_ivalid;
output [NRET - 1:0] gen1_trace_iexception;
output [NRET - 1:0] gen1_trace_interrupt;
output [(VALEN * NRET) - 1:0] gen1_trace_iaddr;
output [(32 * NRET) - 1:0] gen1_trace_instr;
output [(2 * NRET) - 1:0] gen1_trace_priv;
output [(10 * NRET) - 1:0] gen1_trace_cause;
output [(32 * NRET) - 1:0] gen1_trace_tval;
input trace_enabled;
input trace_stall;
output [(4 * NRET) - 1:0] trace_itype;
output [9:0] trace_cause;
output [31:0] trace_tval;
output [1:0] trace_priv;
output [(VALEN * NRET) - 1:0] trace_iaddr;
output [(2 * NRET) - 1:0] trace_iretire;
output [NRET - 1:0] trace_ilastsize;
output trace_halted;
output trace_reset;
output [(3 * NRET) - 1:0] trace_trigger;
output ii_i0_trace_stall;


wire pp16_support = 1'b0;
wire [VALEN - 1:0] s0;
wire [VALEN - 1:0] s1;
wire [EXTVALEN - 1:0] s2;
wire s3;
wire [VALEN - 1:0] s4;
wire [EXTVALEN - 1:0] s5;
wire [EXTVALEN - 1:0] s6;
wire [31:0] s7;
wire [9:0] s8;
wire [2:0] s9;
wire s10;
wire s11;
wire s12;
wire [VALEN - 1:0] s13;
wire [EXTVALEN - 1:0] s14;
wire [31:0] s15;
wire [5:0] s16;
wire [2:0] s17;
wire [7:0] s18;
wire s19;
wire s20;
wire s21;
wire s22;
wire s23;
wire s24;
wire s25;
wire s26;
wire s27;
wire s28;
wire s29;
wire s30;
wire s31;
wire s32;
wire [VALEN - 1:0] s33;
wire [VALEN - 1:0] s34;
wire [VALEN - 1:0] s35;
wire [VALEN - 1:0] s36;
wire [VALEN - 1:0] s37;
wire [VALEN - 1:0] s38;
wire [15:0] s39;
wire [15:0] s40;
wire s41;
wire s42;
wire s43;
wire s44;
wire s45;
wire s46;
wire s47;
wire s48;
wire s49;
wire s50;
wire s51;
wire s52;
wire s53;
wire s54;
wire [7:0] s55;
wire [15:0] s56;
wire s57;
wire s58;
wire s59;
wire s60;
wire s61;
wire s62;
wire s63;
wire s64;
wire s65;
wire s66;
wire [7:0] s67;
wire [15:0] s68;
wire s69;
wire s70;
wire s71;
wire s72;
wire s73;
wire s74;
wire s75;
wire [7:0] s76 = wb_i0_ctrl[84] ? wb_ls_ecc_code : wb_i0_ctrl[69 +:8];
wire s77 = wb_i0_ctrl[84] ? wb_ls_ecc_corr : wb_i0_ctrl[77];
wire [3:0] s78 = wb_i0_ctrl[84] ? wb_ls_ecc_ramid : wb_i0_ctrl[80 +:4];
wire s79 = wb_i0_ctrl[79];
wire s80 = ~wb_i0_ctrl[84];
wire [7:0] s81 = wb_i1_ctrl[84] ? wb_ls_ecc_code : wb_i1_ctrl[69 +:8];
wire s82 = wb_i1_ctrl[84] ? wb_ls_ecc_corr : wb_i1_ctrl[77];
wire [3:0] s83 = wb_i1_ctrl[84] ? wb_ls_ecc_ramid : wb_i1_ctrl[80 +:4];
wire s84 = wb_i1_ctrl[79];
wire s85 = ~wb_i1_ctrl[84];
assign s45 = wb_i0_ctrl[106];
assign s46 = ~wb_i0_ctrl[106] & wb_i0_ctrl[138];
assign s47 = ~wb_i0_ctrl[106] & ~wb_i0_ctrl[138] & (wb_i0_ctrl[149]);
assign s48 = ~wb_i0_ctrl[106] & ~wb_i0_ctrl[138] & ~(wb_i0_ctrl[149]) & wb_i0_ctrl[110];
assign s49 = ~wb_i0_ctrl[106] & ~wb_i0_ctrl[138] & ~(wb_i0_ctrl[149]) & wb_i0_ctrl[144];
assign s50 = ~wb_i0_ctrl[106] & ~wb_i0_ctrl[138] & ~(wb_i0_ctrl[149]) & wb_i0_ctrl[148];
assign s51 = ~wb_i0_ctrl[106] & ~wb_i0_ctrl[138] & ~(wb_i0_ctrl[149]) & wb_i0_ctrl[66];
assign s52 = wb_i0_ctrl[67];
assign s53 = wb_i0_ctrl[68];
assign s55 = {wb_i0_ctrl[117 +:4],wb_i0_ctrl[113 +:4]};
assign s57 = wb_i1_ctrl[106];
assign s58 = ~wb_i1_ctrl[106] & wb_i1_ctrl[138];
assign s59 = ~wb_i1_ctrl[106] & ~wb_i1_ctrl[138] & (wb_i1_ctrl[149]);
assign s60 = ~wb_i1_ctrl[106] & ~wb_i1_ctrl[138] & ~(wb_i1_ctrl[149]) & wb_i1_ctrl[110];
assign s61 = ~wb_i1_ctrl[106] & ~wb_i1_ctrl[138] & ~(wb_i1_ctrl[149]) & wb_i1_ctrl[144];
assign s62 = ~wb_i1_ctrl[106] & ~wb_i1_ctrl[138] & ~(wb_i1_ctrl[149]) & wb_i1_ctrl[148];
assign s63 = ~wb_i1_ctrl[106] & ~wb_i1_ctrl[138] & ~(wb_i1_ctrl[149]) & wb_i1_ctrl[66];
assign s64 = wb_i1_ctrl[67];
assign s65 = wb_i1_ctrl[68];
assign s67 = {wb_i1_ctrl[117 +:4],wb_i1_ctrl[113 +:4]};
assign s54 = wb_i0_ctrl[78];
assign s66 = wb_i1_ctrl[78];
assign s14 = (wb_i0_resume) ? wb_i0_pc : wb_i1_pc;
assign s16 = (wb_i0_resume) ? wb_i0_ctrl[39 +:6] : wb_i1_ctrl[39 +:6];
assign s17 = (wb_i0_resume) ? wb_i0_ctrl[45 +:3] : wb_i1_ctrl[45 +:3];
assign s18 = (wb_i0_resume) ? {5'd0,wb_i0_ctrl[63 +:3]} : {5'd0,wb_i1_ctrl[63 +:3]};
assign s26 = (wb_i0_resume) ? s45 : s57;
assign s24 = (wb_i0_resume) ? s47 : s59;
assign s20 = (wb_i0_resume) ? s46 : s58;
assign s21 = (wb_i0_resume) ? s48 : s60;
assign s22 = (wb_i0_resume) ? s49 : s61;
assign s23 = (wb_i0_resume) ? s50 : s62;
assign s25 = (wb_i0_resume) ? s51 : s63;
assign s32 = debugint_valid & async_ready;
assign s28 = nmi_valid & async_ready;
assign s29 = mint_valid & async_ready;
assign s30 = sint_valid & async_ready;
assign s31 = uint_valid & async_ready;
assign s12 = s28 | s29 | s30 | s31;
assign s11 = s12 | s32;
assign s13[VALEN - 1:0] = (csr_halt_mode) ? {DEBUG_VEC[VALEN - 1:3],3'd4} : (s69) ? {DEBUG_VEC[VALEN - 1:3],3'd0} : (trap_handled_by_s_mode) ? csr_stvec[VALEN - 1:0] : (trap_handled_by_u_mode) ? csr_utvec[VALEN - 1:0] : csr_mtvec[VALEN - 1:0];
assign s0[VALEN - 1:0] = {DEBUG_VEC[VALEN - 1:3],3'd0};
assign s1[VALEN - 1:0] = csr_dexc2dbg_nmi ? {DEBUG_VEC[VALEN - 1:3],3'd0} : reset_vector[VALEN - 1:0];
assign {resume_vectored,resume_pc} = (wb_i0_alive & wb_i0_resume) ? {s3,s2} : (wb_i1_alive & wb_i1_resume) ? {s3,s2} : (wb_postsync_resume) ? {1'b0,s14} : {s10,s5};
wire [EXTVALEN - 1:0] s86;
wire [EXTVALEN - 1:0] s87;
kv_sign_ext #(
    .OW(EXTVALEN),
    .IW(VALEN)
) u_debug_vec_se (
    .out(s86),
    .in(s0)
);
kv_sign_ext #(
    .OW(EXTVALEN),
    .IW(VALEN)
) u_wb_xcpt_entry_se (
    .out(s87),
    .in(s13)
);
assign s2 = ({EXTVALEN{s20}} & s14) | ({EXTVALEN{s26}} & s86) | ({EXTVALEN{s24}} & s87) | ({EXTVALEN{s21}} & csr_mepc[EXTVALEN - 1:0]) | ({EXTVALEN{s22}} & csr_sepc[EXTVALEN - 1:0]) | ({EXTVALEN{s23}} & csr_uepc[EXTVALEN - 1:0]) | ({EXTVALEN{s25}} & csr_dpc[EXTVALEN - 1:0]);
assign s3 = ((((((s24 & csr_mmisc_ctl_vec_plic & ~s69 & ~csr_halt_mode))))));
generate
    if (32 < VALEN) begin:gen_int_vector_entry_zext
        assign s33[VALEN - 1:0] = {{(VALEN - 32){1'b0}},csr_mtvec[31:2],2'b0} + {{18{1'b0}},{mint_vec[11:0],2'd0}};
        assign s34[VALEN - 1:0] = {{(VALEN - 32){1'b0}},csr_stvec[31:2],2'b0} + {{19{1'b0}},{sint_vec[10:0],2'd0}};
        assign s35[VALEN - 1:0] = {{(VALEN - 32){1'b0}},csr_utvec[31:2],2'b0} + {{20{1'b0}},{uint_vec[9:0],2'd0}};
    end
    else begin:gen_int_vector_entry
        assign s33[VALEN - 1:0] = {csr_mtvec[VALEN - 1:2],2'b0} + {{(VALEN - 14){1'b0}},{mint_vec[11:0],2'd0}};
        assign s34[VALEN - 1:0] = {csr_stvec[VALEN - 1:2],2'b0} + {{(VALEN - 13){1'b0}},{sint_vec[10:0],2'd0}};
        assign s35[VALEN - 1:0] = {csr_utvec[VALEN - 1:2],2'b0} + {{(VALEN - 12){1'b0}},{uint_vec[9:0],2'd0}};
    end
endgenerate
assign s36 = int_dex2dbg ? {DEBUG_VEC[VALEN - 1:3],3'd0} : (csr_mmisc_ctl_vec_plic & mei_entry_sel) ? s33 : csr_mtvec[VALEN - 1:0];
assign s37 = int_dex2dbg ? {DEBUG_VEC[VALEN - 1:3],3'd0} : (csr_mmisc_ctl_vec_plic & sei_entry_sel) ? s34 : csr_stvec[VALEN - 1:0];
assign s38 = (csr_mmisc_ctl_vec_plic & uei_entry_sel) ? s35 : csr_utvec[VALEN - 1:0];
kv_sign_ext #(
    .OW(EXTVALEN),
    .IW(VALEN)
) u_async_resume_pc_sext (
    .out(s5),
    .in(s4)
);
assign s4 = ({VALEN{hart_under_reset}} & reset_vector) | ({VALEN{debugint_valid}} & s0) | ({VALEN{nmi_valid}} & s1) | ({VALEN{mint_valid}} & s36) | ({VALEN{sint_valid}} & s37) | ({VALEN{uint_valid}} & s38);
assign s10 = (mint_valid & csr_mmisc_ctl_vec_plic & ~int_dex2dbg) | (sint_valid & csr_mmisc_ctl_vec_plic & ~int_dex2dbg) | (uint_valid & csr_mmisc_ctl_vec_plic & ~int_dex2dbg);
assign s8 = ({10{nmi_valid}} & 10'd1) | ({10{mint_valid}} & int_code) | ({10{sint_valid}} & int_code) | ({10{uint_valid}} & int_code) | ({10{debugint_valid}} & {7'd0,3'd3});
assign s9 = int_cause_detail;
assign s6 = wb_i1_retire ? wb_i1_npc : wb_i0_retire ? wb_i0_npc : wb_i0_pc;
kv_sign_ext #(
    .OW(32),
    .IW(EXTVALEN)
) u_async_epc_se (
    .out(s7),
    .in(s6)
);
assign resume_ras_ptr = (wb_i0_resume) ? wb_i0_ctrl[123 +:3] : wb_i1_ctrl[123 +:3];
wire s88 = (s16 == 6'h0);
wire s89 = (s16 == 6'h1);
wire s90 = (s16 == 6'h2) & (s17 != 3'd2);
wire s91 = (s16 == 6'h4);
wire s92 = (s16 == 6'h5);
wire s93 = (s16 == 6'h6);
wire s94 = (s16 == 6'h7);
wire s95 = (s16 == 6'h8);
wire s96 = (s16 == 6'h9);
wire s97 = (s16 == 6'hb);
wire s98 = (s16 == 6'hf);
wire s99 = (s16 == 6'hd);
wire s100 = (s16 == 6'hc);
wire s101 = (s16 == 6'h20);
wire s102 = (s16 == 6'h21);
wire s103 = (s16 == 6'h2) & (s17 == 3'd2);
wire s104 = (s16 == 6'd40) | (s16 == 6'd41) | (s16 == 6'd42) | (s16 == 6'd43) | (s16 == 6'd44) | (s16 == 6'd45) | (s16 == 6'd46) | (s16 == 6'd47);
wire s105 = s104;
assign s69 = (csr_dexc2dbg_iam & s88) | (csr_dexc2dbg_iaf & s89) | (csr_dexc2dbg_ii & s90) | (csr_dexc2dbg_ii & s103) | (csr_dexc2dbg_lam & s91) | (csr_dexc2dbg_laf & s92) | (csr_dexc2dbg_sam & s93) | (csr_dexc2dbg_saf & s94) | (csr_dexc2dbg_uec & s95) | (csr_dexc2dbg_sec & s96) | (csr_dexc2dbg_mec & s97) | (csr_dexc2dbg_spf & s98) | (csr_dexc2dbg_lpf & s99) | (csr_dexc2dbg_ipf & s100) | (csr_dexc2dbg_hsp & s101) | (csr_dexc2dbg_hsp & s102) | (csr_dexc2dbg_ace & s105);
assign s70 = (csr_medeleg[0] & (s16 == 6'h0)) | (csr_medeleg[1] & (s16 == 6'h1)) | (csr_medeleg[2] & (s16 == 6'h2)) | (csr_medeleg[3] & (s16 == 6'h3)) | (csr_medeleg[4] & (s16 == 6'h4)) | (csr_medeleg[5] & (s16 == 6'h5)) | (csr_medeleg[6] & (s16 == 6'h6)) | (csr_medeleg[7] & (s16 == 6'h7)) | (csr_medeleg[8] & (s16 == 6'h8)) | (csr_medeleg[9] & (s16 == 6'h9)) | (csr_medeleg[12] & (s16 == 6'hc)) | (csr_medeleg[13] & (s16 == 6'hd)) | (csr_medeleg[15] & (s16 == 6'hf));
generate
    if (RVN_SUPPORT_INT == 1) begin:gen_rvn_sdeleg
        assign s71 = (csr_sedeleg[0] & (s16 == 6'h0)) | (csr_sedeleg[1] & (s16 == 6'h1)) | (csr_sedeleg[2] & (s16 == 6'h2)) | (csr_sedeleg[3] & (s16 == 6'h3)) | (csr_sedeleg[4] & (s16 == 6'h4)) | (csr_sedeleg[5] & (s16 == 6'h5)) | (csr_sedeleg[6] & (s16 == 6'h6)) | (csr_sedeleg[7] & (s16 == 6'h7)) | (csr_sedeleg[8] & (s16 == 6'h8)) | (csr_sedeleg[12] & (s16 == 6'hc)) | (csr_sedeleg[13] & (s16 == 6'hd)) | (csr_sedeleg[15] & (s16 == 6'hf));
    end
    else begin:gen_no_rvn_sdeleg
        assign s71 = 1'b0;
    end
endgenerate
wire s106 = (NUM_PRIVILEGE_LEVELS > 2);
wire s107 = (wb_i0_alive & wb_i0_resume) | (wb_i1_alive & wb_i1_resume);
wire s108 = ((s24 & cur_privilege_s & s70) | (s24 & cur_privilege_u & s70 & ~s71)) & s106;
wire s109 = (s24 & cur_privilege_u & s70 & (s71 | ~s106));
assign trap_handled_by_s_mode = (s107) ? (s108) : (sint_valid);
assign trap_handled_by_u_mode = (s107) ? (s109) : (uint_valid);
kv_sign_ext #(
    .OW(32),
    .IW(EXTVALEN)
) u_wb_pc_sext (
    .out(s15),
    .in(s14)
);
assign ipipe_csr_epc_wdata = (wb_i0_alive & wb_i0_resume) ? s15 : (wb_i1_alive & wb_i1_resume) ? s15 : s7;
assign ipipe_csr_epc_we = ipipe_csr_cause_we | epc_init;
assign ipipe_csr_tval_wdata = (wb_i0_alive & wb_i0_resume) ? wb_i0_tval : (wb_i1_alive & wb_i1_resume) ? wb_i1_tval : {32{1'b0}};
assign ipipe_csr_tval_we = ipipe_csr_cause_we;
assign {ipipe_csr_halt_taken,ipipe_csr_halt_cause} = ({4{debugint_valid & async_ready}} & {1'b1,3'd3}) | ({4{s28 & csr_dexc2dbg_nmi}} & {1'b1,3'd1}) | ({4{s29 & int_dex2dbg}} & {1'b1,3'd1}) | ({4{s30 & int_dex2dbg}} & {1'b1,3'd1}) | ({4{s45 & wb_i0_alive}} & {1'b1,s16[2:0]}) | ({4{s57 & wb_i1_alive}} & {1'b1,s16[2:0]}) | ({4{s47 & wb_i0_alive & s69}} & {1'b1,3'd1}) | ({4{s59 & wb_i1_alive & s69}} & {1'b1,3'd1});
assign s39 = (s16[2:0] == 3'd1) ? 16'd0 : {8'd0,8'd0};
assign s40 = ({16{s88}} & {8'd0,8'd1}) | ({16{s89}} & {8'd0,8'd2}) | ({16{s90}} & {s18,8'd3}) | ({16{s91}} & {8'd0,8'd5}) | ({16{s92}} & {8'd0,8'd6}) | ({16{s93}} & {8'd0,8'd7}) | ({16{s94}} & {8'd0,8'd8}) | ({16{s95}} & {8'd0,8'd9}) | ({16{s96}} & {8'd0,8'd10}) | ({16{s97}} & {8'd0,8'd12}) | ({16{s98}} & {8'd0,8'd15}) | ({16{s99}} & {8'd0,8'd13}) | ({16{s100}} & {8'd0,8'd11}) | ({16{s101}} & {8'd0,8'd32}) | ({16{s102}} & {8'd0,8'd33}) | ({16{s103}} & {8'd0,8'd34}) | ({16{s105}} & {8'd0,2'b0,s16});
assign ipipe_csr_halt_return = (wb_i0_alive & s51) | (wb_i1_alive & s63);
assign ipipe_csr_halt_ddcause = ({16{s28}} & {8'd0,8'd4}) | ({16{s29}} & int_ddcause) | ({16{s30}} & int_ddcause) | ({16{s45 & wb_i0_alive}} & s39) | ({16{s57 & wb_i1_alive}} & s39) | ({16{s47 & wb_i0_alive & s69}} & s40) | ({16{s59 & wb_i1_alive & s69}} & s40);
assign ipipe_csr_cause_we = (s47 & wb_i0_alive & ~csr_halt_mode) | (s59 & wb_i1_alive & ~csr_halt_mode) | s29 | s30 | s31 | ipipe_csr_nmi_taken;
assign ipipe_csr_cause_code = (wb_i0_alive & wb_i0_resume) ? {4'd0,s16} : (wb_i1_alive & wb_i1_resume) ? {4'd0,s16} : s8;
assign ipipe_csr_cause_detail = (wb_i0_alive & wb_i0_resume) ? s17 : (wb_i1_alive & wb_i1_resume) ? s17 : s9;
assign ipipe_csr_cause_detail_pm = (wb_i0_alive & wb_i0_resume) ? 2'b00 : (wb_i1_alive & wb_i1_resume) ? 2'b00 : csr_cur_privilege;
assign s27 = (s16 == 6'h1) | (s16 == 6'h2) | (s16 == 6'h5) | (s16 == 6'h7);
assign ipipe_csr_cause_detail_we = (s47 & wb_i0_alive & s27) | (s59 & wb_i1_alive & s27) | (mint_valid & int_detail_cause_valid) | (sint_valid & int_detail_cause_valid);
assign ipipe_csr_cause_interrupt = (s29 & int_cause_interrupt) | (s30 & int_cause_interrupt) | (s31 & int_cause_interrupt);
assign s19 = ((s16 == 6'h1) & (s17 == 3'd1)) | ((s16 == 6'h5) & (s17 == 3'd1)) | ((s16 == 6'h7) & (s17 == 3'd1));
assign s73 = s47 & wb_i0_alive & s19;
assign s74 = s59 & wb_i1_alive & s19;
assign s75 = (mint_valid & int_ecc) | (sint_valid & int_ecc);
assign ipipe_csr_ecc_trap = (wb_i0_alive & wb_i0_resume) ? s73 : (wb_i1_alive & wb_i1_resume) ? s74 : s75;
assign ipipe_csr_ecc_code_en = ipipe_csr_ecc_trap | (wb_i0_alive & ~wb_i0_resume & s54) | (wb_i1_alive & ~wb_i1_resume & s66);
assign ipipe_csr_ecc_corr = (wb_i0_alive & wb_i0_resume) ? s77 : (wb_i1_alive & wb_i1_resume) ? s82 : int_ecc_corr;
assign ipipe_csr_ecc_code = (s11 & s75) ? 8'd0 : (wb_i0_alive & s54) ? s76 : (wb_i0_alive & wb_i0_resume) ? s76 : s81;
assign ipipe_csr_ecc_ramid = (wb_i0_alive & wb_i0_resume) ? s78 : |(wb_i1_alive & wb_i1_resume) ? s83 : int_ecc_ramid;
assign ipipe_csr_ecc_insn = (wb_i0_alive & wb_i0_resume) ? s79 : (wb_i1_alive & wb_i1_resume) ? s84 : int_ecc_insn;
assign ipipe_csr_ecc_fetch = (wb_i0_alive & wb_i0_resume) ? s80 : (wb_i1_alive & wb_i1_resume) ? s85 : 1'b0;
assign ipipe_csr_ecc_precise = (wb_i0_alive & wb_i0_resume) | (wb_i1_alive & wb_i1_resume);
assign ipipe_csr_nmi_taken = s28;
assign ipipe_csr_trap_taken = (s47 & wb_i0_alive & ~csr_halt_mode) | (s59 & wb_i1_alive & ~csr_halt_mode) | s29 | s30 | s31;
assign ipipe_csr_m_trap_return = (wb_i0_retire & wb_i0_ctrl[110]) | (wb_i1_retire & wb_i1_ctrl[110]);
assign ipipe_csr_s_trap_return = (wb_i0_retire & wb_i0_ctrl[144]) | (wb_i1_retire & wb_i1_ctrl[144]);
assign ipipe_csr_u_trap_return = (wb_i0_retire & wb_i0_ctrl[148]) | (wb_i1_retire & wb_i1_ctrl[148]);
assign trigm_xcpt_onehot[0] = s24 & (s16[5:0] == 6'h0);
assign trigm_xcpt_onehot[1] = s24 & (s16[5:0] == 6'h1);
assign trigm_xcpt_onehot[2] = s24 & (s16[5:0] == 6'h2);
assign trigm_xcpt_onehot[3] = s24 & (s16[5:0] == 6'h3);
assign trigm_xcpt_onehot[4] = s24 & (s16[5:0] == 6'h4);
assign trigm_xcpt_onehot[5] = s24 & (s16[5:0] == 6'h5);
assign trigm_xcpt_onehot[6] = s24 & (s16[5:0] == 6'h6);
assign trigm_xcpt_onehot[7] = s24 & (s16[5:0] == 6'h7);
assign trigm_xcpt_onehot[8] = s24 & (s16[5:0] == 6'h8);
assign trigm_xcpt_onehot[9] = s24 & (s16[5:0] == 6'h9);
assign trigm_xcpt_onehot[10] = 1'b0;
assign trigm_xcpt_onehot[11] = s24 & (s16[5:0] == 6'hb);
assign trigm_xcpt_onehot[12] = s24 & (s16[5:0] == 6'hc);
assign trigm_xcpt_onehot[13] = s24 & (s16[5:0] == 6'hd);
assign trigm_xcpt_onehot[14] = 1'b0;
assign trigm_xcpt_onehot[15] = s24 & (s16[5:0] == 6'hf);
assign trigm_xcpt_onehot[16] = s28;
assign s72 = (s47 & wb_i0_alive) | (s59 & wb_i1_alive) | s28;
assign trigm_icount_valid = (wb_i0_alive & wb_i0_retire) | (wb_i1_alive & wb_i1_retire) | (wb_i0_alive & s47) | (wb_i1_alive & s59) | s28 | s29 | s30 | s31;
assign trigm_icount_clr = (wb_i0_alive & wb_i0_retire) | (wb_i1_alive & wb_i1_retire) | (wb_i0_alive & s47) | (wb_i1_alive & s59) | (wb_i0_alive & s45) | (wb_i1_alive & s57) | s32;
assign etrigger_fire = trigm_xcpt_result & {5{s72}};
kv_mini_dec kv_mini_dec_0(
    .pp16_support(pp16_support),
    .instr_retire(ipipe_csr_pfm_inst_retire[0]),
    .instr(wb_i0_instr),
    .instr_exec_it(wb_i0_ctrl[92]),
    .instr_pp(wb_i0_ctrl[112]),
    .reso_info(wb_i0_reso_info),
    .pp_ecnt(s55),
    .instr_event(wb_i0_instr_event),
    .trace_itype(s56)
);
kv_mini_dec kv_mini_dec_1(
    .pp16_support(pp16_support),
    .instr_retire(ipipe_csr_pfm_inst_retire[1]),
    .instr(wb_i1_instr),
    .instr_exec_it(wb_i1_ctrl[92]),
    .instr_pp(wb_i1_ctrl[112]),
    .reso_info(wb_i1_reso_info),
    .pp_ecnt(s67),
    .instr_event(wb_i1_instr_event),
    .trace_itype(s68)
);
assign ipipe_csr_inst_retire[0] = wb_i0_retire;
assign ipipe_csr_inst_retire[1] = wb_i1_retire;
assign s41 = (wb_i0_ctrl[39 +:6] == 6'h8) | (wb_i0_ctrl[39 +:6] == 6'h9) | (wb_i0_ctrl[39 +:6] == 6'hb);
assign s42 = (wb_i1_ctrl[39 +:6] == 6'h8) | (wb_i1_ctrl[39 +:6] == 6'h9) | (wb_i1_ctrl[39 +:6] == 6'hb);
assign s43 = (wb_i0_ctrl[39 +:6] == 6'h3);
assign s44 = (wb_i1_ctrl[39 +:6] == 6'h3);
assign ipipe_csr_pfm_inst_retire[0] = wb_i0_retire;
assign ipipe_csr_pfm_inst_retire[1] = wb_i1_retire;
generate
    if (TRACE_INTERFACE_INT == 1) begin:gen_trace_instr
        reg [3:0] s110;
        reg [3:0] s111;
        wire [3:0] s112;
        wire [3:0] s113;
        reg [1:0] s114;
        wire [1:0] s115;
        reg [VALEN - 1:0] s116;
        reg [VALEN - 1:0] s117;
        wire [VALEN - 1:0] s118;
        wire [VALEN - 1:0] s119;
        reg s120;
        reg s121;
        wire s122;
        wire s123;
        reg [31:0] s124;
        wire [31:0] s125;
        reg [9:0] s126;
        wire [9:0] s127;
        reg [2:0] s128;
        wire [2:0] s129;
        reg [2:0] s130;
        wire [2:0] s131;
        reg [1:0] s132;
        reg [1:0] s133;
        wire [1:0] s134;
        wire [1:0] s135;
        reg s136;
        wire s137;
        reg s138;
        wire s139;
        reg s140;
        reg [1:0] s141;
        reg [31:0] s142;
        reg [9:0] s143;
        wire s144;
        wire [1:0] s145;
        wire [31:0] s146;
        wire [9:0] s147;
        wire s148 = wb_i0_ctrl[110] | wb_i0_ctrl[144] | wb_i0_ctrl[148];
        wire s149 = wb_i1_ctrl[110] | wb_i1_ctrl[144] | wb_i1_ctrl[148];
        reg s150;
        wire s151;
        reg s152;
        wire s153;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s150 <= 1'b0;
            end
            else begin
                s150 <= s151;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s138 <= 1'b1;
            end
            else if (s150) begin
                s138 <= s139;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s152 <= 1'b0;
            end
            else if (s150) begin
                s152 <= s153;
            end
        end

        always @(posedge core_clk) begin
            if (s150) begin
                s110 <= s112;
                s114 <= s115;
                s120 <= s122;
                s132 <= s134;
                s124 <= s125;
                s126 <= s127;
                s128 <= s129;
                s136 <= s137;
                s116 <= s118;
            end
        end

        always @(posedge core_clk) begin
            if (s150) begin
                s111 <= s113;
                s121 <= s123;
                s133 <= s135;
                s117 <= s119;
                s130 <= s131;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s140 <= 1'b0;
            end
            else if (s150) begin
                s140 <= s144;
            end
        end

        always @(posedge core_clk) begin
            if (s150) begin
                s141 <= s145;
                s142 <= s146;
                s143 <= s147;
            end
        end

        assign s151 = trace_enabled | trigm_trace_enabled;
        assign s153 = trace_stall;
        assign ii_i0_trace_stall = s150 & s152 & ~hart_under_reset;
        assign s134 = wb_i0_retire ? {~wb_i0_16b,wb_i0_16b} : 2'd0;
        assign s135 = wb_i1_retire ? {~wb_i1_16b,wb_i1_16b} : 2'd0;
        assign s112 = ({4{wb_i0_alive & s47}} & 4'd1) | ({4{s140}} & 4'd2) | ({4{wb_i0_retire & s148}} & 4'd3) | ({4{wb_i0_retire & s56[4]}} & 4'd4) | ({4{wb_i0_retire & s56[5]}} & 4'd5) | ({4{wb_i0_retire & s56[8]}} & 4'd8) | ({4{wb_i0_retire & s56[9]}} & 4'd9) | ({4{wb_i0_retire & s56[10]}} & 4'd10) | ({4{wb_i0_retire & s56[11]}} & 4'd11) | ({4{wb_i0_retire & s56[12]}} & 4'd12) | ({4{wb_i0_retire & s56[13]}} & 4'd13) | ({4{wb_i0_retire & s56[14]}} & 4'd14) | ({4{wb_i0_retire & s56[15]}} & 4'd15);
        assign s113 = ({4{wb_i1_alive & s59}} & 4'd1) | ({4{wb_i1_retire & s149}} & 4'd3) | ({4{wb_i1_retire & s68[4]}} & 4'd4) | ({4{wb_i1_retire & s68[5]}} & 4'd5) | ({4{wb_i1_retire & s68[8]}} & 4'd8) | ({4{wb_i1_retire & s68[9]}} & 4'd9) | ({4{wb_i1_retire & s68[10]}} & 4'd10) | ({4{wb_i1_retire & s68[11]}} & 4'd11) | ({4{wb_i1_retire & s68[12]}} & 4'd12) | ({4{wb_i1_retire & s68[13]}} & 4'd13) | ({4{wb_i1_retire & s68[14]}} & 4'd14) | ({4{wb_i1_retire & s68[15]}} & 4'd15);
        assign s118 = wb_i0_pc[VALEN - 1:0];
        assign s119 = wb_i1_pc[VALEN - 1:0];
        assign s115 = s140 ? s141 : csr_cur_privilege;
        assign s127 = s140 ? s143 : ipipe_csr_cause_code;
        assign s125 = s140 ? s142 : ipipe_csr_tval_wdata;
        assign s137 = hart_halted;
        assign s139 = hart_under_reset;
        assign s129 = ({3{wb_i0_alive & s47}} & wb_i0_trace_trigger) | ({3{wb_i0_retire}} & wb_i0_trace_trigger);
        assign s131 = ({3{wb_i1_alive & s59}} & wb_i1_trace_trigger) | ({3{wb_i1_retire}} & wb_i1_trace_trigger);
        assign s122 = ~wb_i0_16b;
        assign s123 = ~wb_i1_16b;
        assign s144 = s12;
        assign s145 = csr_cur_privilege;
        assign s146 = ipipe_csr_tval_wdata;
        assign s147 = ipipe_csr_cause_code;
        assign trace_itype = {s111,s110};
        assign trace_cause = s126;
        assign trace_tval = s124;
        assign trace_iaddr = {s117,s116};
        assign trace_iretire = {s133,s132};
        assign trace_ilastsize = {s121,s120};
        assign trace_priv = s114;
        assign trace_halted = s136;
        assign trace_reset = s138;
        assign trace_trigger = {s130,s128};
    end
    else begin:gen_no_trace
        assign trace_itype = {(4 * NRET){1'b0}};
        assign trace_cause = 10'b0;
        assign trace_tval = {32{1'b0}};
        assign trace_priv = 2'b0;
        assign trace_iaddr = {(VALEN * NRET){1'b0}};
        assign trace_iretire = {(2 * NRET){1'b0}};
        assign trace_ilastsize = {(NRET){1'b0}};
        assign trace_halted = 1'b0;
        assign trace_reset = 1'b0;
        assign trace_trigger = 6'b0;
        assign ii_i0_trace_stall = 1'b0;
    end
endgenerate
generate
    if (TRACE_INTERFACE_INT == 2) begin:gen_trace_gen1
        reg s154;
        reg [VALEN - 1:0] s116;
        reg [31:0] s155;
        reg s156;
        reg s157;
        reg [1:0] s158;
        reg [31:0] s124;
        reg [9:0] s126;
        wire s159;
        wire [VALEN - 1:0] s118;
        wire [31:0] s160;
        wire s161;
        wire s162;
        wire [1:0] s163;
        wire [31:0] s125;
        wire [9:0] s127;
        reg s164;
        reg [VALEN - 1:0] s117;
        reg [31:0] s165;
        reg s166;
        wire s167;
        wire [VALEN - 1:0] s119;
        wire [31:0] s168;
        wire s169;
        wire s170;
        wire [VALEN - 1:0] s171;
        wire [31:0] s172;
        wire s173;
        wire [1:0] s174;
        wire [31:0] s175;
        wire [9:0] s176;
        reg s140;
        reg [1:0] s141;
        reg [31:0] s142;
        reg [9:0] s143;
        wire s144;
        wire [1:0] s145;
        wire [31:0] s146;
        wire [9:0] s147;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s154 <= 1'd0;
                s116 <= {VALEN{1'b0}};
                s155 <= 32'd0;
                s156 <= 1'd0;
                s158 <= 2'b11;
                s124 <= {32{1'b0}};
                s126 <= 10'd0;
                s157 <= 1'b0;
            end
            else if (gen1_trace_enabled) begin
                s154 <= s159;
                s116 <= s118;
                s155 <= s160;
                s156 <= s161;
                s158 <= s163;
                s124 <= s125;
                s126 <= s127;
                s157 <= s162;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s164 <= 1'd0;
                s117 <= {VALEN{1'b0}};
                s165 <= 32'd0;
                s166 <= 1'd0;
            end
            else if (gen1_trace_enabled) begin
                s164 <= s167;
                s117 <= s119;
                s165 <= s168;
                s166 <= s169;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s140 <= 1'b0;
                s141 <= 2'b11;
                s142 <= {32{1'b0}};
                s143 <= 10'd0;
            end
            else if (gen1_trace_enabled) begin
                s140 <= s144;
                s141 <= s145;
                s142 <= s146;
                s143 <= s147;
            end
        end

        assign s159 = s140 ? 1'b1 : s170;
        assign s118 = s140 ? s116 : s171;
        assign s160 = s140 ? s155 : s172;
        assign s161 = s140 ? 1'b1 : s173;
        assign s163 = s140 ? s141 : s174;
        assign s125 = s140 ? s142 : s175;
        assign s127 = s140 ? s143 : s176;
        assign s162 = s140;
        assign s170 = (wb_i0_alive & ~s46 & wb_i0_seg_end) | (wb_i0_alive & s47) | (wb_i0_alive & s45);
        assign s171 = wb_i0_pc[VALEN - 1:0];
        assign s172 = wb_i0_instr;
        assign s173 = s47 | s45;
        assign s174 = csr_cur_privilege;
        assign s175 = ipipe_csr_tval_wdata;
        assign s176 = ipipe_csr_cause_code;
        assign s167 = (wb_i1_alive & ~s58 & wb_i1_seg_end) | (wb_i1_alive & s59) | (wb_i1_alive & s57);
        assign s119 = wb_i1_pc[VALEN - 1:0];
        assign s168 = wb_i1_instr;
        assign s169 = s59 | s57;
        assign s144 = s11;
        assign s145 = csr_cur_privilege;
        assign s146 = ipipe_csr_tval_wdata;
        assign s147 = ipipe_csr_cause_code;
        assign gen1_trace_ivalid = {s164,s154};
        assign gen1_trace_iaddr = {s117,s116};
        assign gen1_trace_instr = {s165,s155};
        assign gen1_trace_iexception = {s166,s156};
        assign gen1_trace_priv = {2{s158}};
        assign gen1_trace_tval = {2{s124}};
        assign gen1_trace_cause = {2{s126}};
        assign gen1_trace_interrupt = {1'b0,s157};
    end
    else begin:gen_no_gen1_trace
        assign gen1_trace_ivalid = 2'b0;
        assign gen1_trace_interrupt = 2'b0;
        assign gen1_trace_iaddr = {(VALEN * 2){1'b0}};
        assign gen1_trace_instr = 64'b0;
        assign gen1_trace_iexception = 2'b0;
        assign gen1_trace_priv = 4'b0;
        assign gen1_trace_tval = {64{1'b0}};
        assign gen1_trace_cause = 20'b0;
    end
endgenerate
generate
    if (TRACE_INTERFACE_INT == 0) begin:gen_trace_none
        wire nds_unused_core_clk = core_clk;
        wire nds_unused_core_reset_n = core_reset_n;
        wire nds_unused_wb_i0_seg_end = wb_i0_seg_end;
        wire nds_unused_wb_i1_seg_end = wb_i1_seg_end;
        wire nds_unused_gen1_trace_enabled = gen1_trace_enabled;
        wire nds_unused_trace_enabled = trace_enabled;
    end
endgenerate
wire nds_unused_csr_dexc2dbg_hec = csr_dexc2dbg_hec;
wire nds_unused_ipipe_csr_int_delegate_u = ipipe_csr_int_delegate_u;
wire nds_unused_ipipe_csr_int_delegate_s = ipipe_csr_int_delegate_s;
wire nds_unused_csr_dexc2dbg_pmov = csr_dexc2dbg_pmov;
wire nds_unused_csr_dexc2dbg_sbe = csr_dexc2dbg_sbe;
wire nds_unused_resume = resume;
wire nds_unused_cur_privilege_m = cur_privilege_m;
wire nds_unused_wb_i0_ebreak = s52;
wire nds_unused_wb_i0_ecall = s53;
wire nds_unused_wb_i1_ebreak = s64;
wire nds_unused_wb_i1_ecall = s65;
endmodule


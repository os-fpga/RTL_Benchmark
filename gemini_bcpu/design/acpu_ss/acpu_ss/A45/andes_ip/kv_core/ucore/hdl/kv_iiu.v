// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_iiu (
    core_clk,
    core_reset_n,
    core_wfi_mode,
    csr_halt_mode,
    csr_dcsr_step,
    csr_mmisc_ctl_nbcache_en,
    csr_ls_translate_en,
    lx_stall,
    btb_flush_valid,
    btb_flush_ready,
    csr_btb_flush,
    wb_kill,
    wb_ras_ptr,
    wb_i0_doable,
    wb_i0_abort,
    wb_post_stall_rel,
    wb_i1_doable,
    wb_i1_abort,
    wb_i0_nbload,
    wb_i1_nbload,
    lx_i0_nbload,
    lx_i1_nbload,
    mm_i0_kill,
    mm_i0_ras_ptr,
    mm_i1_kill,
    mm_i1_ras_ptr,
    ii_i0_doable,
    ii_i1_doable,
    ii_i0_abort,
    ii_i0_trace_stall,
    ii_i0_instr,
    ii_i1_instr,
    ii_i0_ctrl,
    ii_i1_ctrl,
    mdu_kill,
    mdu_req_ready,
    mdu_resp_return,
    mdu_resp_tag,
    vpu_srf_wgrant,
    vpu_srf_wfrf,
    vpu_srf_waddr,
    fdiv_kill,
    fdiv_req_ready,
    fdiv_resp_return,
    fdiv_resp_tag,
    ii_vpu_vtype_sel,
    ii_viq_size,
    ii_vpu_i0_op1_hazard,
    ii_vpu_i1_op1_hazard,
    presync_ready,
    ls_issue_ready,
    nbload_resp_valid,
    nbload_resp_rd,
    lsu_cctl_req,
    wfi_enabled,
    wfi_done,
    ii_is_calu_pair,
    rs1_ren,
    rs2_ren,
    rs3_ren,
    rs4_ren,
    ii_rs1,
    ii_rs2,
    ii_rs3,
    ii_rs4,
    ii_ls_base_bypass,
    ii_ls_func,
    ii_ls_offset,
    mm_ls_loadb,
    throttling_stall,
    ace_resp_rd1,
    ace_resp_rd1_valid,
    ace_resp_rd2,
    ace_resp_rd2_valid,
    ace_no_credit_stall,
    wb_i0_rd1_wen,
    wb_i0_rd2_wen,
    ii_i0_bypass,
    ii_i1_bypass,
    ii_i0_xrs_bypass,
    ii_i1_xrs_bypass,
    ii_i0_frs_bypass,
    ii_i1_frs_bypass,
    ii_i1_frs3_bypass,
    ii_mdu_bypass,
    ii_i0_late,
    ii_i1_late,
    ii_i1_ex_bypass,
    ii_i0_mm_bypass,
    ii_i1_mm_bypass,
    ii_i1_lx_bypass,
    ii_i0_frs1_src_sel,
    ii_i0_frs2_src_sel,
    ii_i0_frs3_src_sel,
    ii_i1_frs1_src_sel,
    ii_i1_frs2_src_sel,
    ii_i1_frs3_src_sel,
    ii_fstore_wdata_sel,
    ii_i0_ex_nbload_hazard,
    ii_i1_ex_nbload_hazard,
    ii_i0_mm_nbload_hazard,
    ii_i1_mm_nbload_hazard,
    ii_i0_stall,
    ii_i1_stall,
    ii_i0_ras_ptr,
    ii_i1_ras_ptr,
    ace_sync_req,
    ace_presync_ready,
    ace_sync_ack,
    event_xrf_busy
);
parameter NUM_PRIVILEGE_LEVELS = 1;
parameter FLEN = 1;
input core_clk;
input core_reset_n;
input core_wfi_mode;
input csr_halt_mode;
input csr_dcsr_step;
input csr_mmisc_ctl_nbcache_en;
input csr_ls_translate_en;
input lx_stall;
output btb_flush_valid;
input btb_flush_ready;
input csr_btb_flush;
input wb_kill;
input [2:0] wb_ras_ptr;
input wb_i0_doable;
input wb_i0_abort;
input wb_post_stall_rel;
input wb_i1_doable;
input wb_i1_abort;
input wb_i0_nbload;
input wb_i1_nbload;
input lx_i0_nbload;
input lx_i1_nbload;
input mm_i0_kill;
input [2:0] mm_i0_ras_ptr;
input mm_i1_kill;
input [2:0] mm_i1_ras_ptr;
input ii_i0_doable;
input ii_i1_doable;
input ii_i0_abort;
input ii_i0_trace_stall;
input [31:0] ii_i0_instr;
input [31:0] ii_i1_instr;
input [322:0] ii_i0_ctrl;
input [322:0] ii_i1_ctrl;
output mdu_kill;
input mdu_req_ready;
input mdu_resp_return;
input [4:0] mdu_resp_tag;
input vpu_srf_wgrant;
input vpu_srf_wfrf;
input [4:0] vpu_srf_waddr;
output fdiv_kill;
input fdiv_req_ready;
input fdiv_resp_return;
input [4:0] fdiv_resp_tag;
output [4:0] ii_vpu_vtype_sel;
input [3:0] ii_viq_size;
output ii_vpu_i0_op1_hazard;
output ii_vpu_i1_op1_hazard;
input [2:0] presync_ready;
input ls_issue_ready;
input nbload_resp_valid;
input [4:0] nbload_resp_rd;
input lsu_cctl_req;
output wfi_enabled;
input wfi_done;
input ii_is_calu_pair;
input rs1_ren;
input rs2_ren;
input rs3_ren;
input rs4_ren;
input [4:0] ii_rs1;
input [4:0] ii_rs2;
input [4:0] ii_rs3;
input [4:0] ii_rs4;
output [2:0] ii_ls_base_bypass;
output [34:0] ii_ls_func;
output [20:0] ii_ls_offset;
input mm_ls_loadb;
input throttling_stall;
input [4:0] ace_resp_rd1;
input ace_resp_rd1_valid;
input [4:0] ace_resp_rd2;
input ace_resp_rd2_valid;
input ace_no_credit_stall;
input wb_i0_rd1_wen;
input wb_i0_rd2_wen;
output [17:0] ii_i0_bypass;
output [17:0] ii_i1_bypass;
output [17:0] ii_i0_xrs_bypass;
output [17:0] ii_i1_xrs_bypass;
output [17:0] ii_i0_frs_bypass;
output [17:0] ii_i1_frs_bypass;
output [8:0] ii_i1_frs3_bypass;
output [15:0] ii_mdu_bypass;
output ii_i0_late;
output ii_i1_late;
output [3:0] ii_i1_ex_bypass;
output [11:0] ii_i0_mm_bypass;
output [11:0] ii_i1_mm_bypass;
output [3:0] ii_i1_lx_bypass;
output [6:0] ii_i0_frs1_src_sel;
output [6:0] ii_i0_frs2_src_sel;
output [6:0] ii_i0_frs3_src_sel;
output [6:0] ii_i1_frs1_src_sel;
output [6:0] ii_i1_frs2_src_sel;
output [6:0] ii_i1_frs3_src_sel;
output [8:0] ii_fstore_wdata_sel;
output ii_i0_ex_nbload_hazard;
output ii_i1_ex_nbload_hazard;
output ii_i0_mm_nbload_hazard;
output ii_i1_mm_nbload_hazard;
output ii_i0_stall;
output ii_i1_stall;
output [2:0] ii_i0_ras_ptr;
output [2:0] ii_i1_ras_ptr;
output ace_sync_req;
input ace_presync_ready;
input ace_sync_ack;
output event_xrf_busy;
localparam POST_IDLE = 2'h0;
localparam POST_STALL = 2'h1;
localparam POST_DONE = 2'h2;


wire s0 = (NUM_PRIVILEGE_LEVELS > 2);
wire s1;
wire [4:0] ii_ex_rd1;
wire [4:0] ii_ex_rd2;
wire ii_i0_raw_hazard;
wire ii_i1_raw_hazard;
wire ii_i0_struct_hazard;
wire ii_i1_struct_hazard;
wire ii_i0_waw_hazard;
wire ii_i1_waw_hazard;
wire s2;
wire s3;
wire [23:0] ii_i0_fu;
wire [23:0] ii_i1_fu;
wire s4;
wire s5;
wire s6;
wire s7;
wire ii_i0_rd1_wen;
wire ii_i0_rd2_wen;
wire ii_i1_rd1_wen;
wire [4:0] ii_i0_rd1;
wire [4:0] ii_i0_rd2;
wire [4:0] ii_i1_rd1;
wire [2:0] s8 = ii_i0_ctrl[252 +:3];
wire s9 = ii_i0_ctrl[85];
wire [5:0] s10 = ii_i0_ctrl[295 +:6];
wire [5:0] s11 = ii_i1_ctrl[295 +:6];
wire s12 = ii_i0_ctrl[179] | ii_i0_ctrl[183];
wire s13 = ii_i1_ctrl[179] | ii_i1_ctrl[183];
wire [34:0] s14;
wire [34:0] s15;
wire s16 = 1'b0;
wire ii_i0_frs1_vpu_hazard;
wire s17 = 1'b0;
wire ii_i1_frs1_vpu_hazard;
wire [18:0] ii_ex_rd1_fu;
wire [18:0] ii_ex_rd2_fu;
reg [2:0] s18;
wire [2:0] s19;
wire s20;
wire [1:0] s21;
wire s22;
wire s23;
wire s24;
wire ii_i0_ls_base_bypass;
wire ii_i1_ls_base_bypass;
wire [1:0] s25;
reg s26;
wire s27;
reg [4:0] s28;
wire [4:0] s29;
wire s30;
wire s31;
wire s32;
wire s33 = ii_i0_ctrl[249] & ii_i0_ctrl[1] & (ii_i0_rd1 == 5'd0);
wire s34 = ii_i1_ctrl[249] & ii_i1_ctrl[1] & (ii_i1_rd1 == 5'd0);
wire fdiv_kill;
wire [8:0] ii_i0_frs1_bypass;
wire [8:0] ii_i0_frs2_bypass;
wire [8:0] ii_i0_frs3_bypass;
wire [8:0] ii_i1_frs1_bypass;
wire [8:0] ii_i1_frs2_bypass;
wire [8:0] ii_i1_frs3_bypass;
wire ii_i0_f_raw_hazard;
wire ii_i0_f_struct_hazard;
wire ii_i0_f_waw_hazard;
wire ii_i1_f_raw_hazard;
wire ii_i1_f_struct_hazard;
wire ii_i1_f_waw_hazard;
wire [8:0] s35;
wire [8:0] s36;
wire [8:0] s37;
wire [8:0] s38;
wire [6:1] ii_frs_ren;
wire rs1_match_mm_rd1;
wire rs1_match_mm_rd2;
wire rs3_match_mm_rd1;
wire rs3_match_mm_rd2;
wire rs1_match_ex_rd1;
wire rs1_match_ex_rd2;
wire rs3_match_ex_rd1;
wire rs3_match_ex_rd2;
reg ace_sync_req;
wire s39;
wire s40;
wire s41;
wire s42;
wire s43;
wire s44;
assign ii_i0_fu[0] = ii_i0_ctrl[164];
assign ii_i0_fu[1] = ii_i0_ctrl[165];
assign ii_i0_fu[2] = ii_i0_ctrl[179];
assign ii_i0_fu[3] = ii_i0_ctrl[180];
assign ii_i0_fu[4] = ii_i0_ctrl[183];
assign ii_i0_fu[5] = ii_i0_ctrl[182];
assign ii_i0_fu[7] = ii_i0_ctrl[168];
assign ii_i0_fu[8] = ii_i0_ctrl[166];
assign ii_i0_fu[9] = ii_i0_ctrl[293];
assign ii_i0_fu[10] = ii_i0_ctrl[169];
assign ii_i0_fu[11] = ii_i0_ctrl[171];
assign ii_i0_fu[12] = ii_i0_ctrl[170];
assign ii_i0_fu[13] = ii_i0_ctrl[163];
assign ii_i0_fu[14] = ii_i0_ctrl[173];
assign ii_i0_fu[15] = ii_i0_ctrl[178];
assign ii_i0_fu[16] = ii_i0_ctrl[176];
assign ii_i0_fu[17] = ii_i0_ctrl[177];
assign ii_i0_fu[18] = ii_i0_ctrl[174];
assign ii_i0_fu[19] = ii_i0_ctrl[175];
assign ii_i0_fu[20] = ii_i0_ctrl[172];
assign ii_i0_fu[21] = ii_i0_ctrl[194];
assign ii_i0_fu[22] = ii_i0_ctrl[189];
assign ii_i0_fu[23] = ii_i0_ctrl[193];
assign ii_i1_fu[0] = ii_i1_ctrl[164];
assign ii_i1_fu[1] = ii_i1_ctrl[165];
assign ii_i1_fu[2] = ii_i1_ctrl[179];
assign ii_i1_fu[3] = ii_i1_ctrl[180];
assign ii_i1_fu[4] = ii_i1_ctrl[183];
assign ii_i1_fu[5] = ii_i1_ctrl[182];
assign ii_i1_fu[7] = ii_i1_ctrl[168];
assign ii_i1_fu[8] = ii_i1_ctrl[166];
assign ii_i1_fu[9] = ii_i1_ctrl[293];
assign ii_i1_fu[10] = ii_i1_ctrl[169];
assign ii_i1_fu[11] = ii_i1_ctrl[171];
assign ii_i1_fu[12] = ii_i1_ctrl[170];
assign ii_i1_fu[13] = ii_i1_ctrl[163];
assign ii_i1_fu[14] = ii_i1_ctrl[173] & ii_i1_doable;
assign ii_i1_fu[15] = ii_i1_ctrl[178] & ii_i1_doable;
assign ii_i1_fu[16] = ii_i1_ctrl[176] & ii_i1_doable;
assign ii_i1_fu[17] = ii_i1_ctrl[177] & ii_i1_doable;
assign ii_i1_fu[18] = ii_i1_ctrl[174] & ii_i1_doable;
assign ii_i1_fu[19] = ii_i1_ctrl[175] & ii_i1_doable;
assign ii_i1_fu[20] = ii_i1_ctrl[172] & ii_i1_doable;
assign ii_i1_fu[21] = ii_i1_ctrl[194];
assign ii_i1_fu[22] = ii_i1_ctrl[189];
assign ii_i1_fu[23] = ii_i1_ctrl[193];
assign ii_i0_fu[6] = ii_i0_ctrl[181] | s33;
assign ii_i1_fu[6] = ii_i1_ctrl[181] | s34;
assign ii_i0_rd1 = ii_i0_ctrl[255 +:5];
assign ii_i0_rd1_wen = (ii_i0_ctrl[260] & (ii_i0_rd1 != 5'd0));
assign ii_i0_rd2 = ii_i0_ctrl[261 +:5];
assign ii_i0_rd2_wen = (ii_i0_ctrl[266] & (ii_i0_rd2 != 5'd0));
assign ii_i1_rd1 = ii_i1_ctrl[255 +:5];
assign ii_i1_rd1_wen = (ii_i1_ctrl[260] & (ii_i1_rd1 != 5'd0));
assign ii_frs_ren[1] = ii_i0_ctrl[146];
assign ii_frs_ren[2] = ii_i0_ctrl[152];
assign ii_frs_ren[3] = ii_i0_ctrl[158];
assign ii_frs_ren[4] = ii_i1_ctrl[146] & ~ii_i0_ctrl[292];
assign ii_frs_ren[5] = ii_i1_ctrl[152] & ~ii_i0_ctrl[292];
assign ii_frs_ren[6] = ii_i1_ctrl[158] & ~ii_i0_ctrl[292];
generate
    if (FLEN != 1) begin:gen_fscb
        wire [5:0] ii_i0_frd1;
        wire ii_i0_frd1_wen;
        wire [5:0] ii_i1_frd1;
        wire ii_i1_frd1_wen;
        wire [4:0] ii_i0_frs1;
        wire [4:0] ii_i0_frs2;
        wire [4:0] ii_i0_frs3;
        wire [4:0] ii_i1_frs1;
        wire [4:0] ii_i1_frs2;
        wire [4:0] ii_i1_frs3;
        wire [5:0] ii_ex_frd1;
        wire [5:0] ii_ex_frd2;
        wire [18:0] ii_ex_frd1_fu;
        wire [18:0] ii_ex_frd2_fu;
        assign ii_i0_frs1 = ii_i0_ctrl[141 +:5];
        assign ii_i0_frs2 = ii_i0_ctrl[147 +:5];
        assign ii_i0_frs3 = ii_i0_ctrl[153 +:5];
        assign ii_i1_frs1 = ii_i1_ctrl[141 +:5];
        assign ii_i1_frs2 = ii_i1_ctrl[147 +:5];
        assign ii_i1_frs3 = ii_i1_ctrl[153 +:5];
        assign ii_i0_frd1 = {ii_i0_frd1_wen,ii_i0_ctrl[131 +:5]};
        assign ii_i0_frd1_wen = ii_i0_ctrl[136];
        assign ii_i1_frd1 = {ii_i1_frd1_wen,ii_i1_ctrl[131 +:5]};
        assign ii_i1_frd1_wen = ii_i1_ctrl[136];
        assign ii_ex_frd1 = (~ii_i0_doable | ii_i0_stall | ~ii_i0_frd1_wen) ? 6'd0 : ii_i0_frd1;
        assign ii_ex_frd2 = (~ii_i1_doable | ii_i1_stall | ~ii_i1_frd1_wen) ? 6'd0 : ii_i1_frd1;
        assign ii_ex_frd1_fu = ii_ex_rd1_fu;
        assign ii_ex_frd2_fu = ii_ex_rd2_fu;
        kv_iiu_fscb u_kv_iiu_fscb(
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .core_wfi_mode(core_wfi_mode),
            .lx_stall(lx_stall),
            .wb_kill(wb_kill),
            .mm_i0_kill(mm_i0_kill),
            .mm_i1_kill(mm_i1_kill),
            .wb_i0_doable(wb_i0_doable),
            .wb_i1_doable(wb_i1_doable),
            .ii_i0_fu(ii_i0_fu),
            .ii_i1_fu(ii_i1_fu),
            .ii_i0_frd1(ii_i0_frd1),
            .ii_i1_frd1(ii_i1_frd1),
            .ii_i0_frd1_wen(ii_i0_frd1_wen),
            .ii_i1_frd1_wen(ii_i1_frd1_wen),
            .fdiv_req_ready(fdiv_req_ready),
            .fdiv_resp_return(fdiv_resp_return),
            .fdiv_resp_tag(fdiv_resp_tag),
            .ii_frs_ren(ii_frs_ren),
            .ii_i0_frs1(ii_i0_frs1),
            .ii_i0_frs2(ii_i0_frs2),
            .ii_i0_frs3(ii_i0_frs3),
            .ii_i1_frs1(ii_i1_frs1),
            .ii_i1_frs2(ii_i1_frs2),
            .ii_i1_frs3(ii_i1_frs3),
            .ii_ex_frd1(ii_ex_frd1),
            .ii_ex_frd2(ii_ex_frd2),
            .ii_ex_frd1_fu(ii_ex_frd1_fu),
            .ii_ex_frd2_fu(ii_ex_frd2_fu),
            .fdiv_kill(fdiv_kill),
            .ii_i0_frs1_bypass(ii_i0_frs1_bypass),
            .ii_i0_frs2_bypass(ii_i0_frs2_bypass),
            .ii_i0_frs3_bypass(ii_i0_frs3_bypass),
            .ii_i1_frs1_bypass(ii_i1_frs1_bypass),
            .ii_i1_frs2_bypass(ii_i1_frs2_bypass),
            .ii_i1_frs3_bypass(ii_i1_frs3_bypass),
            .ii_i0_frs1_src_sel(ii_i0_frs1_src_sel),
            .ii_i0_frs2_src_sel(ii_i0_frs2_src_sel),
            .ii_i0_frs3_src_sel(ii_i0_frs3_src_sel),
            .ii_i1_frs1_src_sel(ii_i1_frs1_src_sel),
            .ii_i1_frs2_src_sel(ii_i1_frs2_src_sel),
            .ii_i1_frs3_src_sel(ii_i1_frs3_src_sel),
            .ii_fstore_wdata_sel(ii_fstore_wdata_sel),
            .ii_i0_f_raw_hazard(ii_i0_f_raw_hazard),
            .ii_i1_f_raw_hazard(ii_i1_f_raw_hazard),
            .ii_i0_f_struct_hazard(ii_i0_f_struct_hazard),
            .ii_i1_f_struct_hazard(ii_i1_f_struct_hazard),
            .ii_i0_f_waw_hazard(ii_i0_f_waw_hazard),
            .ii_i1_f_waw_hazard(ii_i1_f_waw_hazard),
            .ii_i0_frs1_vpu_hazard(ii_i0_frs1_vpu_hazard),
            .ii_i1_frs1_vpu_hazard(ii_i1_frs1_vpu_hazard),
            .rs1_mtch_mm_rd1(rs1_match_mm_rd1),
            .rs1_mtch_mm_rd2(rs1_match_mm_rd2),
            .rs3_mtch_mm_rd1(rs3_match_mm_rd1),
            .rs3_mtch_mm_rd2(rs3_match_mm_rd2),
            .rs1_mtch_ex_rd1(rs1_match_ex_rd1),
            .rs1_mtch_ex_rd2(rs1_match_ex_rd2),
            .rs3_mtch_ex_rd1(rs3_match_ex_rd1),
            .rs3_mtch_ex_rd2(rs3_match_ex_rd2)
        );
    end
    else begin:gen_no_fscb
        wire s45;
        assign s45 = fdiv_req_ready | fdiv_resp_return | (|fdiv_resp_tag) | rs1_match_mm_rd1 | rs1_match_mm_rd2 | rs3_match_mm_rd1 | rs3_match_mm_rd2 | rs1_match_ex_rd1 | rs1_match_ex_rd2 | rs3_match_ex_rd1 | rs3_match_ex_rd2;
        assign ii_fstore_wdata_sel = 9'b0;
        assign fdiv_kill = 1'b0;
        assign ii_i0_frs1_bypass = 9'b0;
        assign ii_i0_frs2_bypass = 9'b0;
        assign ii_i0_frs3_bypass = 9'b0;
        assign ii_i1_frs1_bypass = 9'b0;
        assign ii_i1_frs2_bypass = 9'b0;
        assign ii_i1_frs3_bypass = 9'b0;
        assign ii_i0_frs1_src_sel = 7'b0;
        assign ii_i0_frs2_src_sel = 7'b0;
        assign ii_i0_frs3_src_sel = 7'b0;
        assign ii_i1_frs1_src_sel = 7'b0;
        assign ii_i1_frs2_src_sel = 7'b0;
        assign ii_i1_frs3_src_sel = 7'b0;
        assign ii_i0_f_raw_hazard = 1'b0;
        assign ii_i0_f_struct_hazard = 1'b0;
        assign ii_i0_f_waw_hazard = 1'b0;
        assign ii_i1_f_raw_hazard = 1'b0;
        assign ii_i1_f_struct_hazard = 1'b0;
        assign ii_i1_f_waw_hazard = 1'b0;
        assign ii_i0_frs1_vpu_hazard = 1'b0;
        assign ii_i1_frs1_vpu_hazard = 1'b0;
    end
endgenerate
assign ii_i0_bypass[8:0] = ii_frs_ren[1] ? ii_i0_frs1_bypass : s35;
assign ii_i0_bypass[17:9] = ii_frs_ren[2] ? ii_i0_frs2_bypass : s36;
assign ii_i1_bypass[8:0] = ii_frs_ren[3] ? ii_i0_frs3_bypass : ii_frs_ren[4] ? ii_i1_frs1_bypass : s37;
assign ii_i1_bypass[17:9] = ii_frs_ren[5] ? ii_i1_frs2_bypass : s38;
assign ii_i0_xrs_bypass = {s36,s35};
assign ii_i1_xrs_bypass = {s38,s37};
assign ii_i0_frs_bypass = {ii_i0_frs2_bypass,ii_i0_frs1_bypass};
assign ii_i1_frs_bypass = {ii_i1_frs2_bypass,(ii_frs_ren[3] ? ii_i0_frs3_bypass : ii_i1_frs1_bypass)};
kv_iiu_scb u_kv_iiu_scb(
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .core_wfi_mode(core_wfi_mode),
    .ii_i0_bogus(ii_i0_ctrl[44]),
    .ii_i1_bogus(ii_i1_ctrl[44]),
    .lx_stall(lx_stall),
    .wb_kill(wb_kill),
    .mm_i0_kill(mm_i0_kill),
    .mm_i1_kill(mm_i1_kill),
    .wb_i0_doable(wb_i0_doable),
    .wb_i0_abort(wb_i0_abort),
    .wb_i1_doable(wb_i1_doable),
    .wb_i1_abort(wb_i1_abort),
    .wb_i0_nbload(wb_i0_nbload),
    .wb_i1_nbload(wb_i1_nbload),
    .lx_i0_nbload(lx_i0_nbload),
    .lx_i1_nbload(lx_i1_nbload),
    .ii_i0_fu(ii_i0_fu),
    .ii_i0_singleissue(ii_i0_ctrl[292]),
    .ii_i1_fu(ii_i1_fu),
    .ii_i0_rd1(ii_i0_rd1),
    .ii_i0_rd1_wen(ii_i0_rd1_wen),
    .ii_i0_rd2(ii_i0_rd2),
    .ii_i0_rd2_wen(ii_i0_rd2_wen),
    .ii_i1_rd1(ii_i1_rd1),
    .ii_i1_rd1_wen(ii_i1_rd1_wen),
    .ii_rs_ren({rs4_ren,rs3_ren,rs2_ren,rs1_ren}),
    .mdu_kill(mdu_kill),
    .mdu_req_ready(mdu_req_ready),
    .mdu_resp_return(mdu_resp_return),
    .mdu_resp_tag(mdu_resp_tag),
    .ls_issue_ready(ls_issue_ready),
    .nbload_resp_valid(nbload_resp_valid),
    .nbload_resp_rd(nbload_resp_rd),
    .vpu_srf_wgrant(vpu_srf_wgrant),
    .vpu_srf_wfrf(vpu_srf_wfrf),
    .vpu_srf_waddr(vpu_srf_waddr),
    .ii_vpu_vtype_sel(ii_vpu_vtype_sel),
    .ace_resp_rd1(ace_resp_rd1),
    .ace_resp_rd1_valid(ace_resp_rd1_valid),
    .ace_resp_rd2(ace_resp_rd2),
    .ace_resp_rd2_valid(ace_resp_rd2_valid),
    .ace_no_credit_stall(ace_no_credit_stall),
    .wb_i0_rd1_wen(wb_i0_rd1_wen),
    .wb_i0_rd2_wen(wb_i0_rd2_wen),
    .ii_rs1(ii_rs1),
    .ii_rs2(ii_rs2),
    .ii_rs3(ii_rs3),
    .ii_rs4(ii_rs4),
    .ii_ex_rd1(ii_ex_rd1),
    .ii_ex_rd2(ii_ex_rd2),
    .ii_ex_rd1_fu(ii_ex_rd1_fu),
    .ii_ex_rd2_fu(ii_ex_rd2_fu),
    .ii_mdu_bypass(ii_mdu_bypass),
    .ii_i0_bypass({s36,s35}),
    .ii_i1_bypass({s38,s37}),
    .ii_i1_ex_bypass(ii_i1_ex_bypass),
    .ii_i0_mm_bypass(ii_i0_mm_bypass),
    .ii_i1_mm_bypass(ii_i1_mm_bypass),
    .ii_i1_lx_bypass(ii_i1_lx_bypass),
    .ii_i0_ex_nbload_hazard(ii_i0_ex_nbload_hazard),
    .ii_i1_ex_nbload_hazard(ii_i1_ex_nbload_hazard),
    .ii_i0_mm_nbload_hazard(ii_i0_mm_nbload_hazard),
    .ii_i1_mm_nbload_hazard(ii_i1_mm_nbload_hazard),
    .ii_is_calu_pair(ii_is_calu_pair),
    .ii_i0_late(ii_i0_late),
    .ii_i1_late(ii_i1_late),
    .ii_i0_ls_base_bypass(ii_i0_ls_base_bypass),
    .ii_i1_ls_base_bypass(ii_i1_ls_base_bypass),
    .mm_ls_loadb(mm_ls_loadb),
    .ii_i0_raw_hazard(ii_i0_raw_hazard),
    .ii_i1_raw_hazard(ii_i1_raw_hazard),
    .ii_i0_struct_hazard(ii_i0_struct_hazard),
    .ii_i1_struct_hazard(ii_i1_struct_hazard),
    .ii_i0_waw_hazard(ii_i0_waw_hazard),
    .ii_i1_waw_hazard(ii_i1_waw_hazard),
    .rs1_match_mm_rd1(rs1_match_mm_rd1),
    .rs1_match_mm_rd2(rs1_match_mm_rd2),
    .rs3_match_mm_rd1(rs3_match_mm_rd1),
    .rs3_match_mm_rd2(rs3_match_mm_rd2),
    .rs1_match_ex_rd1(rs1_match_ex_rd1),
    .rs1_match_ex_rd2(rs1_match_ex_rd2),
    .rs3_match_ex_rd1(rs3_match_ex_rd1),
    .rs3_match_ex_rd2(rs3_match_ex_rd2),
    .event_xrf_busy(event_xrf_busy)
);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s26 <= 1'b0;
    end
    else begin
        s26 <= s27;
    end
end

assign ii_ex_rd1 = (~ii_i0_doable | ii_i0_stall | ~ii_i0_rd1_wen) ? 5'd0 : ii_i0_rd1;
assign ii_ex_rd2 = ii_i0_ctrl[292] ? (~ii_i0_doable | ii_i0_stall | ~ii_i0_rd2_wen) ? 5'b0 : ii_i0_rd2 : (~ii_i1_doable | ii_i1_stall | ~ii_i1_rd1_wen) ? 5'd0 : ii_i1_rd1;
assign ii_ex_rd1_fu[0] = ii_i0_fu[0] & ii_i0_doable & ~ii_i0_stall & ~ii_i0_late;
assign ii_ex_rd1_fu[5] = ii_i0_fu[0] & ii_i0_doable & ~ii_i0_stall & ii_i0_late;
assign ii_ex_rd1_fu[1] = (ii_i0_fu[2] | ii_i0_fu[4]) & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[4] = ii_i0_fu[7] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[3] = ii_i0_fu[6] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[2] = ii_i0_fu[5] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[6] = ii_i0_fu[10] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[7] = ii_i0_fu[11] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[8] = ii_i0_fu[12] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[9] = ii_i0_fu[13] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[10] = ii_i0_fu[14] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[11] = ii_i0_fu[15] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[12] = ii_i0_fu[16] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[13] = ii_i0_fu[17] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[14] = ii_i0_fu[18] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[15] = ii_i0_fu[19] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[16] = ii_i0_fu[20] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[17] = ii_i0_fu[21] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd1_fu[18] = ii_i0_fu[23] & ii_i0_doable & ~ii_i0_stall;
assign ii_ex_rd2_fu[0] = ii_i1_fu[0] & ii_i1_doable & ~ii_i1_stall & ~ii_i1_late;
assign ii_ex_rd2_fu[5] = ii_i1_fu[0] & ii_i1_doable & ~ii_i1_stall & ii_i1_late;
assign ii_ex_rd2_fu[1] = (ii_i1_fu[2] | ii_i1_fu[4]) & ii_i1_doable & ~ii_i1_stall;
assign ii_ex_rd2_fu[4] = ii_i1_fu[7] & ii_i1_doable & ~ii_i1_stall;
assign ii_ex_rd2_fu[3] = ii_i1_fu[6] & ii_i1_doable & ~ii_i1_stall;
assign ii_ex_rd2_fu[2] = ii_i1_fu[5] & ii_i1_doable & ~ii_i1_stall;
assign ii_ex_rd2_fu[6] = ii_i0_ctrl[292] ? (ii_i0_fu[10] & ii_i0_doable & ~ii_i0_stall) : (ii_i1_fu[10] & ii_i1_doable & ~ii_i1_stall);
assign ii_ex_rd2_fu[7] = ii_i0_ctrl[292] ? (ii_i0_fu[11] & ii_i0_doable & ~ii_i0_stall) : (ii_i1_fu[11] & ii_i1_doable & ~ii_i1_stall);
assign ii_ex_rd2_fu[8] = ii_i0_ctrl[292] ? (ii_i0_fu[12] & ii_i0_doable & ~ii_i0_stall) : (ii_i1_fu[12] & ii_i1_doable & ~ii_i1_stall);
assign ii_ex_rd2_fu[9] = ii_i0_ctrl[292] ? (ii_i0_fu[13] & ii_i0_doable & ~ii_i0_stall) : (ii_i1_fu[13] & ii_i1_doable & ~ii_i1_stall);
assign ii_ex_rd2_fu[10] = ii_i1_fu[14] & ii_i1_doable & ~ii_i1_stall;
assign ii_ex_rd2_fu[11] = ii_i1_fu[15] & ii_i1_doable & ~ii_i1_stall;
assign ii_ex_rd2_fu[12] = ii_i1_fu[16] & ii_i1_doable & ~ii_i1_stall;
assign ii_ex_rd2_fu[13] = ii_i1_fu[17] & ii_i1_doable & ~ii_i1_stall;
assign ii_ex_rd2_fu[14] = ii_i1_fu[18] & ii_i1_doable & ~ii_i1_stall;
assign ii_ex_rd2_fu[15] = ii_i1_fu[19] & ii_i1_doable & ~ii_i1_stall;
assign ii_ex_rd2_fu[16] = ii_i1_fu[20] & ii_i1_doable & ~ii_i1_stall;
assign ii_ex_rd2_fu[17] = ii_i1_fu[21] & ii_i1_doable & ~ii_i1_stall;
assign ii_ex_rd2_fu[18] = ii_i1_fu[23] & ii_i1_doable & ~ii_i1_stall;
assign s27 = lx_stall & (s26 | mm_i0_kill | mm_i1_kill);
assign ii_i0_stall = ii_i0_raw_hazard | ii_i0_struct_hazard | ii_i0_waw_hazard | ii_i0_f_raw_hazard | ii_i0_f_struct_hazard | ii_i0_f_waw_hazard | ii_i0_trace_stall | s26 | s31 | lsu_cctl_req | (s8[0] & ~presync_ready[0]) | (s8[1] & ~presync_ready[1]) | (s8[2] & ~presync_ready[2]) | (s9 & ~ls_issue_ready) | ii_i0_ctrl[0] & ~ace_presync_ready | throttling_stall | s22 | s44 | s2 | s1;
assign ii_i1_stall = ii_i0_stall | ii_i1_raw_hazard | ii_i1_struct_hazard | ii_i1_waw_hazard | ii_i1_f_raw_hazard | ii_i1_f_struct_hazard | ii_i1_f_waw_hazard | ii_i0_ctrl[292] | ii_i1_ctrl[292] | ii_i1_ctrl[74] | s3;
assign s2 = ii_viq_size[3] & ii_i0_ctrl[193];
assign s3 = (ii_viq_size[3] & ii_i1_ctrl[193]) | (ii_viq_size[2] & ii_i0_ctrl[193] & ii_i1_ctrl[193]);
assign ii_vpu_i0_op1_hazard = s16 | ii_i0_frs1_vpu_hazard;
assign ii_vpu_i1_op1_hazard = s17 | ii_i1_frs1_vpu_hazard;
assign s42 = s39 | s40;
assign s41 = (s39 | ace_sync_req) & ~s40;
assign s39 = ii_i0_doable & s43 & ii_i0_ctrl[0] & ~ace_sync_req;
assign s40 = ace_sync_ack & ~throttling_stall;
assign s43 = ~ii_i0_raw_hazard & ~s26 & ~s31 & ~lsu_cctl_req & ace_presync_ready & ~throttling_stall;
assign s44 = (ii_i0_ctrl[0] & ~ace_sync_req & ~ii_i0_abort) | (ace_sync_req & ~ace_sync_ack);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ace_sync_req <= 1'b0;
    end
    else if (s42) begin
        ace_sync_req <= s41;
    end
end

assign s25[1] = ii_i0_ctrl[291] & (ii_rs1 != 5'd0) & s0;
assign s25[0] = ii_i0_ctrl[291] & (ii_rs2 != 5'd0) & s0;
assign s24 = ii_i0_ctrl[179] | ii_i0_ctrl[183];
assign s14[0 +:3] = ii_i0_ctrl[213 +:3];
assign s14[3] = ii_i0_ctrl[216];
assign s14[4] = ii_i0_ctrl[220];
assign s14[5] = ii_i0_ctrl[217];
assign s14[6] = ii_i0_ctrl[219];
assign s14[7] = ii_i0_ctrl[198];
assign s14[8 +:5] = ii_i0_ctrl[199 +:5];
assign s14[13 +:5] = ii_i0_ctrl[255 +:5];
assign s14[19 +:8] = ii_i0_ctrl[205 +:8];
assign s14[27] = ii_i0_ctrl[204];
assign s14[18] = ii_i0_ctrl[218] & csr_mmisc_ctl_nbcache_en;
assign s14[28] = csr_ls_translate_en & ~s10[3];
assign s14[34] = s10[3];
assign s14[29] = ii_i0_ctrl[129];
assign s14[30] = ii_i0_ctrl[130];
assign s14[31] = ii_i0_ctrl[291];
assign s14[32 +:2] = s25;
assign s15[0 +:3] = ii_i1_ctrl[213 +:3];
assign s15[3] = ii_i1_ctrl[216];
assign s15[4] = ii_i1_ctrl[220];
assign s15[5] = ii_i1_ctrl[217];
assign s15[6] = ii_i1_ctrl[219];
assign s15[7] = ii_i1_ctrl[198];
assign s15[8 +:5] = ii_i1_ctrl[199 +:5];
assign s15[13 +:5] = ii_i1_ctrl[255 +:5];
assign s15[19 +:8] = ii_i1_ctrl[205 +:8];
assign s15[27] = ii_i1_ctrl[204];
assign s15[18] = ii_i1_ctrl[218] & csr_mmisc_ctl_nbcache_en;
assign s15[28] = csr_ls_translate_en & ~s11[3];
assign s15[34] = s11[3];
assign s15[29] = 1'b0;
assign s15[30] = 1'b0;
assign s15[31] = 1'b0;
assign s15[32 +:2] = 2'd0;
assign ii_ls_offset = s24 ? ii_i0_ctrl[228 +:21] : ii_i1_ctrl[228 +:21];
assign ii_ls_func = s24 ? s14 : s15;
assign ii_ls_base_bypass = s24 ? {ii_i0_ls_base_bypass,1'b0,~ii_i0_ls_base_bypass} : {ii_i1_ls_base_bypass,~ii_i1_ls_base_bypass,1'b0};
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s28 <= 5'd0;
    end
    else if (s30) begin
        s28 <= s29;
    end
end

assign s32 = (ii_i0_doable & ~ii_i0_stall & ii_i0_ctrl[316] & ~(csr_halt_mode | csr_dcsr_step)) | (ii_i1_doable & ~ii_i1_stall & ii_i1_ctrl[316] & ~(csr_halt_mode | csr_dcsr_step));
assign s30 = ~lx_stall;
assign s29[4:1] = (wb_kill | (mm_i0_kill & ~s28[1]) | mm_i1_kill | wfi_done) ? 4'd0 : s28[3:0];
assign s29[0] = (wb_kill | (mm_i0_kill & ~s28[1]) | mm_i1_kill | wfi_done) ? 1'b0 : s32 | s28[0];
assign s31 = s28[0];
assign wfi_enabled = s28[4];
wire s46;
reg [1:0] s47;
reg [1:0] s48;
assign s21 = ii_i0_ctrl[70 +:2];
assign s23 = s21[1] & ii_i0_doable & ~ii_i0_stall;
assign s22 = (s47 == POST_STALL);
assign s46 = ~lx_stall | wb_post_stall_rel;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s47 <= POST_IDLE;
    end
    else if (s46) begin
        s47 <= s48;
    end
end

always @* begin
    s48 = s47;
    case (s47)
        POST_IDLE: if (s23) begin
            s48 = POST_STALL;
        end
        POST_STALL: if (wb_post_stall_rel) begin
            s48 = POST_DONE;
        end
        POST_DONE: s48 = POST_IDLE;
        default: s48 = 2'b0;
    endcase
end

assign s4 = ii_i0_ctrl[72] & ii_i0_doable;
assign s5 = ii_i0_ctrl[45] & ii_i0_doable;
assign s6 = ii_i1_ctrl[72] & ii_i1_doable;
assign s7 = ii_i1_ctrl[45] & ii_i1_doable;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s18 <= 3'd0;
    end
    else if (s20) begin
        s18 <= s19;
    end
end

assign s20 = ~ii_i0_stall & ii_i0_doable & (s5 | s4) & ~lx_stall | ~ii_i1_stall & ii_i1_doable & (s7 | s6) & ~lx_stall | wb_kill | mm_i0_kill | mm_i1_kill;
assign ii_i0_ras_ptr = s18 + {2'd0,s5} - {2'd0,s4};
assign ii_i1_ras_ptr = ii_i0_ras_ptr + {2'd0,s7} - {2'd0,s6};
assign s19 = wb_kill ? wb_ras_ptr : mm_i0_kill ? mm_i0_ras_ptr : mm_i1_kill ? mm_i1_ras_ptr : ii_i1_stall ? ii_i0_ras_ptr : ii_i1_ras_ptr;
wire nds_unused_ii_i0_abort = ii_i0_abort;
wire [31:0] nds_unused_ii_i0_instr = ii_i0_instr;
wire [31:0] nds_unused_ii_i1_instr = ii_i1_instr;
reg btb_flush_valid;
wire s49;
wire s50;
wire s51;
wire s52;
reg s53;
wire s54;
wire s55;
wire s56;
wire s57;
wire s58 = ii_i0_raw_hazard | ii_i0_struct_hazard | ii_i0_waw_hazard | s26 | s31 | lsu_cctl_req | throttling_stall | s22;
assign s1 = (csr_btb_flush & ~btb_flush_valid & ~s53) | (btb_flush_valid & ~btb_flush_ready);
assign s54 = btb_flush_valid & btb_flush_ready & throttling_stall & ~wb_kill;
assign s55 = ~throttling_stall | wb_kill;
assign s56 = (s53 & ~s55) | s54;
assign s57 = s54 | s55;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s53 <= 1'b0;
    end
    else if (s57) begin
        s53 <= s56;
    end
end

assign s49 = ii_i0_doable & presync_ready[0] & csr_btb_flush & ~s58 & ~btb_flush_valid & ~s53 & ~wb_kill;
assign s50 = btb_flush_ready | wb_kill;
assign s51 = (btb_flush_valid & ~s50) | s49;
assign s52 = s49 | s50;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        btb_flush_valid <= 1'b0;
    end
    else if (s52) begin
        btb_flush_valid <= s51;
    end
end

endmodule


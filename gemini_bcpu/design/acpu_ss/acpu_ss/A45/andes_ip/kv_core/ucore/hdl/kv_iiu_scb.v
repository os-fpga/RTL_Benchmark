// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_iiu_scb (
    core_clk,
    core_reset_n,
    core_wfi_mode,
    rs1_match_mm_rd1,
    rs1_match_mm_rd2,
    rs3_match_mm_rd1,
    rs3_match_mm_rd2,
    rs1_match_ex_rd1,
    rs1_match_ex_rd2,
    rs3_match_ex_rd1,
    rs3_match_ex_rd2,
    lx_stall,
    wb_kill,
    mm_i0_kill,
    mm_i1_kill,
    wb_i0_doable,
    wb_i0_abort,
    wb_i1_doable,
    wb_i1_abort,
    wb_i0_nbload,
    wb_i1_nbload,
    lx_i0_nbload,
    lx_i1_nbload,
    ii_i0_bogus,
    ii_i1_bogus,
    ii_i0_fu,
    ii_i0_singleissue,
    ii_i1_fu,
    ii_i0_rd1,
    ii_i0_rd1_wen,
    ii_i0_rd2,
    ii_i0_rd2_wen,
    ii_i1_rd1,
    ii_i1_rd1_wen,
    mdu_kill,
    mdu_req_ready,
    mdu_resp_return,
    mdu_resp_tag,
    ls_issue_ready,
    nbload_resp_valid,
    nbload_resp_rd,
    vpu_srf_wgrant,
    vpu_srf_wfrf,
    vpu_srf_waddr,
    ii_vpu_vtype_sel,
    ace_resp_rd1,
    ace_resp_rd1_valid,
    ace_resp_rd2,
    ace_resp_rd2_valid,
    ace_no_credit_stall,
    wb_i0_rd1_wen,
    wb_i0_rd2_wen,
    ii_is_calu_pair,
    ii_rs_ren,
    ii_rs1,
    ii_rs2,
    ii_rs3,
    ii_rs4,
    ii_ex_rd1,
    ii_ex_rd2,
    ii_ex_rd1_fu,
    ii_ex_rd2_fu,
    ii_i0_bypass,
    ii_i1_bypass,
    ii_i1_ex_bypass,
    ii_i0_mm_bypass,
    ii_i1_mm_bypass,
    ii_i1_lx_bypass,
    ii_i0_ex_nbload_hazard,
    ii_i1_ex_nbload_hazard,
    ii_i0_mm_nbload_hazard,
    ii_i1_mm_nbload_hazard,
    ii_mdu_bypass,
    ii_i0_late,
    ii_i1_late,
    ii_i0_ls_base_bypass,
    ii_i1_ls_base_bypass,
    mm_ls_loadb,
    ii_i0_raw_hazard,
    ii_i1_raw_hazard,
    ii_i0_struct_hazard,
    ii_i1_struct_hazard,
    ii_i0_waw_hazard,
    ii_i1_waw_hazard,
    event_xrf_busy
);
input core_clk;
input core_reset_n;
input core_wfi_mode;
output rs1_match_mm_rd1;
output rs1_match_mm_rd2;
output rs3_match_mm_rd1;
output rs3_match_mm_rd2;
output rs1_match_ex_rd1;
output rs1_match_ex_rd2;
output rs3_match_ex_rd1;
output rs3_match_ex_rd2;
input lx_stall;
input wb_kill;
input mm_i0_kill;
input mm_i1_kill;
input wb_i0_doable;
input wb_i0_abort;
input wb_i1_doable;
input wb_i1_abort;
input wb_i0_nbload;
input wb_i1_nbload;
input lx_i0_nbload;
input lx_i1_nbload;
input ii_i0_bogus;
input ii_i1_bogus;
input [23:0] ii_i0_fu;
input ii_i0_singleissue;
input [23:0] ii_i1_fu;
input [4:0] ii_i0_rd1;
input ii_i0_rd1_wen;
input [4:0] ii_i0_rd2;
input ii_i0_rd2_wen;
input [4:0] ii_i1_rd1;
input ii_i1_rd1_wen;
output mdu_kill;
input mdu_req_ready;
input mdu_resp_return;
input [4:0] mdu_resp_tag;
input ls_issue_ready;
input nbload_resp_valid;
input [4:0] nbload_resp_rd;
input vpu_srf_wgrant;
input vpu_srf_wfrf;
input [4:0] vpu_srf_waddr;
output [4:0] ii_vpu_vtype_sel;
input [4:0] ace_resp_rd1;
input ace_resp_rd1_valid;
input [4:0] ace_resp_rd2;
input ace_resp_rd2_valid;
input ace_no_credit_stall;
input wb_i0_rd1_wen;
input wb_i0_rd2_wen;
input ii_is_calu_pair;
input [4:1] ii_rs_ren;
input [4:0] ii_rs1;
input [4:0] ii_rs2;
input [4:0] ii_rs3;
input [4:0] ii_rs4;
input [4:0] ii_ex_rd1;
input [4:0] ii_ex_rd2;
input [18:0] ii_ex_rd1_fu;
input [18:0] ii_ex_rd2_fu;
output [17:0] ii_i0_bypass;
output [17:0] ii_i1_bypass;
output [3:0] ii_i1_ex_bypass;
output [11:0] ii_i0_mm_bypass;
output [11:0] ii_i1_mm_bypass;
output [3:0] ii_i1_lx_bypass;
output ii_i0_ex_nbload_hazard;
output ii_i1_ex_nbload_hazard;
output ii_i0_mm_nbload_hazard;
output ii_i1_mm_nbload_hazard;
output [15:0] ii_mdu_bypass;
output ii_i0_late;
output ii_i1_late;
output ii_i0_ls_base_bypass;
output ii_i1_ls_base_bypass;
input mm_ls_loadb;
output ii_i0_raw_hazard;
output ii_i1_raw_hazard;
output ii_i0_struct_hazard;
output ii_i1_struct_hazard;
output ii_i0_waw_hazard;
output ii_i1_waw_hazard;
output event_xrf_busy;


reg [31:1] s0;
wire [31:1] s1;
wire [31:1] s2;
wire [31:1] s3;
wire s4;
wire s5 = vpu_srf_wgrant & ~vpu_srf_wfrf;
wire s6;
wire s7;
wire s8;
wire s9;
wire s10;
wire s11;
wire s12;
wire [31:0] s13;
wire [31:0] s14;
wire [31:0] s15;
wire [31:0] s16;
wire [31:0] s17;
wire [31:0] s18;
wire [31:0] s19;
reg [4:0] s20;
reg [4:0] s21;
reg [4:0] s22;
reg [4:0] s23;
reg [4:0] s24;
reg [4:0] s25;
reg [4:0] s26;
reg [4:0] s27;
reg s28;
reg s29;
wire [4:0] s30;
wire [4:0] s31;
wire [4:0] s32;
wire [4:0] s33;
wire [4:0] s34;
wire [4:0] s35;
reg [18:0] s36;
reg [18:0] s37;
reg [18:0] s38;
reg [18:0] s39;
reg [18:0] s40;
reg [18:0] s41;
reg [18:0] s42;
reg [18:0] s43;
wire [18:0] s44;
wire [18:0] s45;
wire [18:0] s46;
wire [18:0] s47;
wire [18:0] s48;
wire [18:0] s49;
wire s50 = s36[0];
wire s51 = s37[0];
wire s52 = s38[0];
wire s53 = s39[0];
wire s54 = s40[0];
wire s55 = s41[0];
wire s56 = s42[0];
wire s57 = s43[0];
wire s58 = s36[5];
wire s59 = s37[5];
wire s60 = s38[5];
wire s61 = s39[5];
wire s62 = s40[5];
wire s63 = s41[5];
wire s64 = s42[5];
wire s65 = s43[5];
wire s66 = s36[1];
wire s67 = s37[1];
wire s68 = s38[1];
wire s69 = s39[1];
wire s70 = s40[1];
wire s71 = s41[1];
wire s72 = s42[1];
wire s73 = s43[1];
wire s74 = s70 & lx_i0_nbload;
wire s75 = s71 & lx_i1_nbload;
wire s76 = s72 & wb_i0_nbload;
wire s77 = s73 & wb_i1_nbload;
wire s78 = s36[2];
wire s79 = s37[2];
wire s80 = s38[2];
wire s81 = s39[2];
wire s82 = s40[2];
wire s83 = s41[2];
wire s84 = s42[2];
wire s85 = s43[2];
wire s86 = s36[3];
wire s87 = s37[3];
wire s88 = s38[3];
wire s89 = s39[3];
wire s90 = s40[3];
wire s91 = s41[3];
wire s92 = s42[3];
wire s93 = s43[3];
wire s94 = s36[4];
wire s95 = s37[4];
wire s96 = s38[4];
wire s97 = s39[4];
wire s98 = s40[4];
wire s99 = s41[4];
wire s100 = s42[4];
wire s101 = s43[4];
wire s102 = s36[6];
wire s103 = s37[6];
wire s104 = s38[6];
wire s105 = s39[6];
wire s106 = s40[6];
wire s107 = s41[6];
wire s108 = s42[6];
wire s109 = s43[6];
wire s110 = s36[7];
wire s111 = s37[7];
wire s112 = s38[7];
wire s113 = s39[7];
wire s114 = s40[7];
wire s115 = s41[7];
wire s116 = s42[7];
wire s117 = s43[7];
wire s118 = s36[8];
wire s119 = s37[8];
wire s120 = s38[8];
wire s121 = s39[8];
wire s122 = s40[8];
wire s123 = s41[8];
wire s124 = s42[8];
wire s125 = s43[8];
wire s126 = s36[12];
wire s127 = s37[12];
wire s128 = s38[12];
wire s129 = s39[12];
wire s130 = s40[12];
wire s131 = s41[12];
wire s132 = s42[12];
wire s133 = s43[12];
wire s134 = s36[13];
wire s135 = s37[13];
wire s136 = s38[13];
wire s137 = s39[13];
wire s138 = s40[13];
wire s139 = s41[13];
wire s140 = s42[13];
wire s141 = s43[13];
wire s142 = s36[9];
wire s143 = s37[9];
wire s144 = s38[9];
wire s145 = s39[9];
wire s146 = s40[9];
wire s147 = s41[9];
wire s148 = s42[9];
wire s149 = s43[9];
wire s150 = ii_ex_rd1_fu[17];
wire s151 = s36[17];
wire s152 = s37[17];
wire s153 = s38[17];
wire s154 = s39[17];
wire s155 = s40[17];
wire s156 = s41[17];
wire s157 = s42[17];
wire s158 = s43[17];
wire s159 = s36[18];
wire s160 = s37[18];
wire s161 = s38[18];
wire s162 = s39[18];
wire s163 = s40[18];
wire s164 = s41[18];
wire s165 = s42[18];
wire s166 = s43[18];
wire s167 = ii_i0_fu[10] | ii_i0_fu[11] | ii_i0_fu[12];
wire s168 = ii_i1_fu[10] | ii_i1_fu[11] | ii_i1_fu[12];
wire [8:0] s169;
wire [5:0] s170;
wire [8:0] s171;
wire [5:0] s172;
wire [8:0] s173;
wire [5:0] s174;
wire [7:0] s175;
wire [8:0] s176;
wire [5:0] s177;
wire [7:0] s178;
wire [8:0] s179;
wire [8:0] s180;
wire [8:0] s181;
wire [8:0] s182;
wire [8:0] s183;
wire [5:0] s184;
wire [7:0] s185;
wire [8:0] s186;
wire [5:0] s187;
wire [7:0] s188;
wire [8:0] s189;
wire [5:0] s190;
wire [7:0] s191;
wire [8:0] s192;
wire [5:0] s193;
wire [7:0] s194;
wire [1:0] s195;
wire [1:0] s196;
wire rs1_match_ex_rd1 = ii_rs_ren[1] & (ii_rs1 == s20);
wire rs1_match_ex_rd2 = ii_rs_ren[1] & (ii_rs1 == s21);
wire rs1_match_mm_rd1 = ii_rs_ren[1] & (ii_rs1 == s22);
wire rs1_match_mm_rd2 = ii_rs_ren[1] & (ii_rs1 == s23);
wire s197 = ii_rs_ren[1] & (ii_rs1 == s24);
wire s198 = ii_rs_ren[1] & (ii_rs1 == s25);
wire s199 = ii_rs_ren[1] & (ii_rs1 == s26);
wire s200 = ii_rs_ren[1] & (ii_rs1 == s27);
wire s201 = ii_rs_ren[2] & (ii_rs2 == s20);
wire s202 = ii_rs_ren[2] & (ii_rs2 == s21);
wire s203 = ii_rs_ren[2] & (ii_rs2 == s22);
wire s204 = ii_rs_ren[2] & (ii_rs2 == s23);
wire s205 = ii_rs_ren[2] & (ii_rs2 == s24);
wire s206 = ii_rs_ren[2] & (ii_rs2 == s25);
wire s207 = ii_rs_ren[2] & (ii_rs2 == s26);
wire s208 = ii_rs_ren[2] & (ii_rs2 == s27);
wire s209 = ii_rs_ren[3] & (ii_rs3 == ii_i0_rd1) & ii_i0_rd1_wen;
wire rs3_match_ex_rd1 = ii_rs_ren[3] & (ii_rs3 == s20);
wire rs3_match_ex_rd2 = ii_rs_ren[3] & (ii_rs3 == s21);
wire rs3_match_mm_rd1 = ii_rs_ren[3] & (ii_rs3 == s22);
wire rs3_match_mm_rd2 = ii_rs_ren[3] & (ii_rs3 == s23);
wire s210 = ii_rs_ren[3] & (ii_rs3 == s24);
wire s211 = ii_rs_ren[3] & (ii_rs3 == s25);
wire s212 = ii_rs_ren[3] & (ii_rs3 == s26);
wire s213 = ii_rs_ren[3] & (ii_rs3 == s27);
wire s214 = ii_rs_ren[4] & (ii_rs4 == ii_i0_rd1) & ii_i0_rd1_wen;
wire s215 = ii_rs_ren[4] & (ii_rs4 == s20);
wire s216 = ii_rs_ren[4] & (ii_rs4 == s21);
wire s217 = ii_rs_ren[4] & (ii_rs4 == s22);
wire s218 = ii_rs_ren[4] & (ii_rs4 == s23);
wire s219 = ii_rs_ren[4] & (ii_rs4 == s24);
wire s220 = ii_rs_ren[4] & (ii_rs4 == s25);
wire s221 = ii_rs_ren[4] & (ii_rs4 == s26);
wire s222 = ii_rs_ren[4] & (ii_rs4 == s27);
wire s223 = ii_i0_rd1_wen & (ii_i0_rd1 == s20);
wire s224 = ii_i0_rd1_wen & (ii_i0_rd1 == s21);
wire s225 = ii_i0_rd1_wen & (ii_i0_rd1 == s22);
wire s226 = ii_i0_rd1_wen & (ii_i0_rd1 == s23);
wire s227 = ii_i0_rd1_wen & (ii_i0_rd1 == s24);
wire s228 = ii_i0_rd1_wen & (ii_i0_rd1 == s25);
wire s229 = ii_i0_rd1_wen & (ii_i0_rd1 == s26);
wire s230 = ii_i0_rd1_wen & (ii_i0_rd1 == s27);
wire s231 = ii_i0_rd2_wen & (ii_i0_rd2 == s20);
wire s232 = ii_i0_rd2_wen & (ii_i0_rd2 == s21);
wire s233 = ii_i0_rd2_wen & (ii_i0_rd2 == s22);
wire s234 = ii_i0_rd2_wen & (ii_i0_rd2 == s23);
wire s235 = ii_i0_rd2_wen & (ii_i0_rd2 == s24);
wire s236 = ii_i0_rd2_wen & (ii_i0_rd2 == s25);
wire s237 = ii_i0_rd2_wen & (ii_i0_rd2 == s26);
wire s238 = ii_i0_rd2_wen & (ii_i0_rd2 == s27);
wire s239 = ii_i1_rd1_wen & (ii_i1_rd1 == s20);
wire s240 = ii_i1_rd1_wen & (ii_i1_rd1 == s21);
wire s241 = ii_i1_rd1_wen & (ii_i1_rd1 == s22);
wire s242 = ii_i1_rd1_wen & (ii_i1_rd1 == s23);
wire s243 = ii_i1_rd1_wen & (ii_i1_rd1 == s24);
wire s244 = ii_i1_rd1_wen & (ii_i1_rd1 == s25);
wire s245 = ii_i1_rd1_wen & (ii_i1_rd1 == s26);
wire s246 = ii_i1_rd1_wen & (ii_i1_rd1 == s27);
wire s247;
wire s248;
wire s249;
wire s250;
wire s251;
wire s252;
wire s253;
wire s254;
wire s255;
wire s256;
wire s257;
wire s258;
wire s259;
wire s260;
wire s261;
wire s262;
wire s263;
wire s264;
wire s265;
wire s266;
wire s267;
wire s268;
wire s269;
wire s270;
wire s271;
wire s272;
wire s273;
wire s274;
wire s275;
wire s276;
wire s277;
wire s278;
wire s279;
assign s276 = ii_i0_fu[16] & s209 & (ii_i1_fu[0] | (ii_i1_fu[8] & ~ii_i1_bogus));
assign s277 = ii_i0_fu[16] & s214 & (ii_i1_fu[0] | (ii_i1_fu[8] & ~ii_i1_bogus));
assign s278 = ii_i0_fu[17] & s209 & (ii_i1_fu[0] | (ii_i1_fu[8] & ~ii_i0_bogus));
assign s279 = ii_i0_fu[17] & s214 & (ii_i1_fu[0] | (ii_i1_fu[8] & ~ii_i0_bogus));
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s0 <= 31'd0;
    end
    else if (s4) begin
        s0 <= s1;
    end
end

kv_bin2onehot #(
    .N(32)
) u_wb_rd1_onehot (
    .out(s13),
    .in(s26)
);
kv_bin2onehot #(
    .N(32)
) u_wb_rd2_onehot (
    .out(s14),
    .in(s27)
);
kv_bin2onehot #(
    .N(32)
) u_nbload_resp_rd_onehot (
    .out(s15),
    .in(nbload_resp_rd)
);
kv_bin2onehot #(
    .N(32)
) u_mdu_resp_rd_onehot (
    .out(s16),
    .in(mdu_resp_tag)
);
kv_bin2onehot #(
    .N(32)
) u_ace_resp_rd1_onehot (
    .out(s17),
    .in(ace_resp_rd1)
);
kv_bin2onehot #(
    .N(32)
) u_ace_resp_rd2_onehot (
    .out(s18),
    .in(ace_resp_rd2)
);
kv_bin2onehot #(
    .N(32)
) u_vpu_srf_waddr_onehot (
    .out(s19),
    .in(vpu_srf_waddr)
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_rs1_status (
    .out(s6),
    .sel(ii_rs1),
    .in({s0,1'b0})
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_rs2_status (
    .out(s7),
    .sel(ii_rs2),
    .in({s0,1'b0})
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_rs3_status (
    .out(s8),
    .sel(ii_rs3),
    .in({s0,1'b0})
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_rs4_status (
    .out(s9),
    .sel(ii_rs4),
    .in({s0,1'b0})
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_i0_rd1_status (
    .out(s10),
    .sel(ii_i0_rd1),
    .in({s0,1'b0})
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_i0_rd2_status (
    .out(s11),
    .sel(ii_i0_rd2),
    .in({s0,1'b0})
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_i1_rd1_status (
    .out(s12),
    .sel(ii_i1_rd1),
    .in({s0,1'b0})
);
assign s1 = s2 | (s0 & ~s3);
assign s2 = ({31{wb_i0_doable & (s76 | s92 | s165)}} & s13[31:1]) | ({31{wb_i1_doable & (s77 | s93 | s166 | s149)}} & s14[31:1]) | ({31{wb_i0_doable & s148 & wb_i0_rd1_wen}} & s13[31:1]) | ({31{wb_i0_doable & s149 & wb_i0_rd2_wen}} & s14[31:1]);
assign s3 = ({31{nbload_resp_valid}} & s15[31:1]) | ({31{mdu_resp_return}} & s16[31:1]) | ({31{ace_resp_rd1_valid}} & s17[31:1]) | ({31{ace_resp_rd2_valid}} & s18[31:1]) | ({31{s5}} & s19[31:1]);
assign s4 = (wb_i0_doable & (wb_i0_nbload | s92 | s148 | s165)) | (wb_i1_doable & (wb_i1_nbload | s93 | s149 | s165)) | nbload_resp_valid | mdu_resp_return | ace_resp_rd1_valid | ace_resp_rd2_valid | s5;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s20 <= 5'd0;
        s21 <= 5'd0;
        s22 <= 5'd0;
        s23 <= 5'd0;
        s24 <= 5'd0;
        s25 <= 5'd0;
        s36 <= {19{1'd0}};
        s37 <= {19{1'd0}};
        s38 <= {19{1'd0}};
        s39 <= {19{1'd0}};
        s40 <= {19{1'd0}};
        s41 <= {19{1'd0}};
        s28 <= 1'b0;
        s29 <= 1'b0;
    end
    else if (~lx_stall) begin
        s20 <= ii_ex_rd1;
        s21 <= ii_ex_rd2;
        s22 <= s30;
        s23 <= s31;
        s24 <= s32;
        s25 <= s33;
        s36 <= ii_ex_rd1_fu;
        s37 <= ii_ex_rd2_fu;
        s38 <= s44;
        s39 <= s45;
        s40 <= s46;
        s41 <= s47;
        s28 <= ii_i0_singleissue;
        s29 <= s28;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s26 <= 5'd0;
        s27 <= 5'd0;
        s42 <= {19{1'd0}};
        s43 <= {19{1'd0}};
    end
    else if (~core_wfi_mode) begin
        s26 <= s34;
        s27 <= s35;
        s42 <= s48;
        s43 <= s49;
    end
end

assign {s44,s30} = (wb_kill | mm_i0_kill | mm_i1_kill) ? {24{1'd0}} : {s36,s20};
assign {s45,s31} = (wb_kill | mm_i0_kill | mm_i1_kill) ? {24{1'd0}} : {s37,s21};
assign {s46,s32} = (wb_kill) ? {24{1'd0}} : {s38,s22};
assign {s47,s33} = (wb_kill | (mm_i0_kill & ~s29)) ? {24{1'd0}} : {s39,s23};
assign {s48,s34} = (wb_kill | lx_stall) ? {24{1'd0}} : {s40,s24};
assign {s49,s35} = (wb_kill | lx_stall) ? {24{1'd0}} : {s41,s25};
assign s247 = ~(ii_i0_fu[3] & ii_i1_fu[0] & ~ii_i1_fu[9]) & ~(ii_i0_fu[3] & ii_i1_fu[8] & ~ii_i1_bogus & ~ii_i1_fu[9]) & ~(ii_i0_fu[1] & ii_i1_fu[0] & ~ii_i0_late & ~ii_i1_late) & ~(ii_i0_fu[1] & ii_i1_fu[8] & ~ii_i1_bogus & ~ii_i0_late & ~ii_i1_late) & ~(ii_i0_fu[0] & ~(ii_i0_fu[8] & ~ii_i0_bogus) & ii_i1_fu[1] & ~ii_i0_late & ~ii_i1_late) & ~(ii_i0_fu[16] & (ii_i1_fu[0] | (ii_i1_fu[8] & ~ii_i1_bogus))) & ~(ii_i0_fu[17] & (ii_i1_fu[0] | (ii_i1_fu[8] & ~ii_i1_bogus)));
assign s248 = s86 | (s78 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s110 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s118 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s66 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s58 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s50 & (ii_i0_fu[16] | ii_i0_fu[17])) | (s102 & (ii_i0_fu[16] | ii_i0_fu[17])) | (s126 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s134 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167)) | (ii_i0_fu[21] & (s78 | s102 | s110 | s118 | s66 | s58 | s126 | s134)) | s94 | s142;
assign s249 = s88 | (s80 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s68 & (ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s68 & ~mm_ls_loadb & (ii_i0_fu[2] | ii_i0_fu[4])) | (s60 & (ii_i0_fu[2] | ii_i0_fu[4] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s120 & (ii_i0_fu[2] | ii_i0_fu[4])) | (s120 & ii_i0_fu[7]) | (s120 & s167) | (s120 & ii_i0_fu[5]) | (s120 & ii_i0_fu[6]) | (s120 & ii_i0_fu[16]) | (s120 & ii_i0_fu[17]) | (s128 & (ii_i0_fu[2] | ii_i0_fu[4])) | (s128 & ii_i0_fu[7]) | (s128 & s167) | (s128 & ii_i0_fu[5]) | (s128 & ii_i0_fu[6]) | (s136 & (ii_i0_fu[2] | ii_i0_fu[4])) | (s136 & ii_i0_fu[7]) | (s136 & s167) | (s136 & ii_i0_fu[5]) | (s136 & ii_i0_fu[6]) | (s60 & ii_i0_fu[5]) | (s60 & ii_i0_fu[6]) | (s80 & ii_i0_fu[5]) | (s80 & ii_i0_fu[6]) | s96 | (s60 & ii_i0_fu[5]) | s144 | (ii_i0_fu[21] & (s80 | s104 | s112 | s120 | s68 | s60 | s128 | s136));
assign s250 = s90 | (s62 & ii_i0_fu[7]) | (s122 & ii_i0_fu[7]) | s74 | s146;
assign s251 = s86 | (s78 & (ii_i0_fu[2] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s66 & (ii_i0_fu[2] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s58 & (ii_i0_fu[2] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s110 & (ii_i0_fu[2] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s118 & (ii_i0_fu[2] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s126 & (ii_i0_fu[2] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s134 & (ii_i0_fu[2] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167)) | (ii_i0_fu[21] & (s78 | s102 | s110 | s118 | s66 | s58 | s126 | s134)) | s94 | s142;
assign s252 = s88 | (s80 & (ii_i0_fu[2] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s68 & (ii_i0_fu[2] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s60 & (ii_i0_fu[2] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s120 & (ii_i0_fu[2] | ii_i0_fu[4])) | (s120 & ii_i0_fu[7]) | (s120 & s167) | (s120 & ii_i0_fu[5]) | (s120 & ii_i0_fu[6]) | (s120 & ii_i0_fu[16]) | (s120 & ii_i0_fu[17]) | (s128 & (ii_i0_fu[2] | ii_i0_fu[4])) | (s128 & ii_i0_fu[7]) | (s128 & s167) | (s128 & ii_i0_fu[5]) | (s128 & ii_i0_fu[6]) | (s136 & (ii_i0_fu[2] | ii_i0_fu[4])) | (s136 & ii_i0_fu[7]) | (s136 & s167) | (s136 & ii_i0_fu[5]) | (s136 & ii_i0_fu[6]) | (s60 & ii_i0_fu[5]) | (s60 & ii_i0_fu[6]) | (s80 & ii_i0_fu[5]) | (s80 & ii_i0_fu[6]) | s96 | (s60 & ii_i0_fu[5]) | s144 | (ii_i0_fu[21] & (s80 | s104 | s112 | s120 | s68 | s60 | s128 | s136));
assign s253 = s90 | (s62 & ii_i0_fu[7]) | (s122 & ii_i0_fu[7]) | s74 | s146;
assign s254 = s92 | s76 | s148;
assign s255 = s87 | (s79 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s111 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s119 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s67 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s59 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s51 & (ii_i0_fu[16] | ii_i0_fu[17])) | (s103 & (ii_i0_fu[16] | ii_i0_fu[17])) | (s127 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s135 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167)) | (ii_i0_fu[21] & (s79 | s103 | s111 | s119 | s67 | s59 | s127 | s135)) | s95 | s143;
assign s256 = s89 | (s81 & (ii_i0_fu[2] | ii_i0_fu[4] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s69 & (ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s69 & ~mm_ls_loadb & (ii_i0_fu[2] | ii_i0_fu[4])) | (s61 & (ii_i0_fu[2] | ii_i0_fu[4] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s121 & (ii_i0_fu[2] | ii_i0_fu[4])) | (s121 & ii_i0_fu[7]) | (s121 & s167) | (s121 & ii_i0_fu[5]) | (s121 & ii_i0_fu[6]) | (s121 & ii_i0_fu[16]) | (s121 & ii_i0_fu[17]) | (s129 & (ii_i0_fu[2] | ii_i0_fu[4])) | (s129 & ii_i0_fu[7]) | (s129 & s167) | (s129 & ii_i0_fu[5]) | (s129 & ii_i0_fu[6]) | (s137 & (ii_i0_fu[2] | ii_i0_fu[4])) | (s137 & ii_i0_fu[7]) | (s137 & s167) | (s137 & ii_i0_fu[5]) | (s137 & ii_i0_fu[6]) | (s61 & ii_i0_fu[5]) | (s61 & ii_i0_fu[6]) | (s81 & ii_i0_fu[5]) | (s81 & ii_i0_fu[6]) | s97 | (s61 & ii_i0_fu[5]) | s145 | (ii_i0_fu[21] & (s81 | s105 | s113 | s121 | s69 | s61 | s129 | s137));
assign s257 = s91 | (s63 & ii_i0_fu[7]) | (s123 & ii_i0_fu[7]) | s75 | s147 | ii_i0_fu[16] | ii_i0_fu[17];
assign s258 = s87 | (s79 & (ii_i0_fu[2] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s67 & (ii_i0_fu[2] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s59 & (ii_i0_fu[2] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s111 & (ii_i0_fu[2] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s119 & (ii_i0_fu[2] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s127 & (ii_i0_fu[2] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s135 & (ii_i0_fu[2] | ii_i0_fu[6] | ii_i0_fu[5] | ii_i0_fu[7] | s167)) | (ii_i0_fu[21] & (s79 | s103 | s111 | s119 | s67 | s59 | s127 | s135)) | s95 | s143;
assign s259 = s89 | (s81 & (ii_i0_fu[2] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s69 & (ii_i0_fu[2] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s61 & (ii_i0_fu[2] | ii_i0_fu[7] | s167 | ii_i0_fu[16] | ii_i0_fu[17])) | (s121 & (ii_i0_fu[2] | ii_i0_fu[4])) | (s121 & ii_i0_fu[7]) | (s121 & s167) | (s121 & ii_i0_fu[5]) | (s121 & ii_i0_fu[6]) | (s121 & ii_i0_fu[16]) | (s121 & ii_i0_fu[17]) | (s129 & (ii_i0_fu[2] | ii_i0_fu[4])) | (s129 & ii_i0_fu[7]) | (s129 & s167) | (s129 & ii_i0_fu[5]) | (s129 & ii_i0_fu[6]) | (s137 & (ii_i0_fu[2] | ii_i0_fu[4])) | (s137 & ii_i0_fu[7]) | (s137 & s167) | (s137 & ii_i0_fu[5]) | (s137 & ii_i0_fu[6]) | (s61 & ii_i0_fu[5]) | (s61 & ii_i0_fu[6]) | (s81 & ii_i0_fu[5]) | (s81 & ii_i0_fu[6]) | s97 | (s61 & ii_i0_fu[5]) | s145 | (ii_i0_fu[21] & (s81 | s105 | s113 | s121 | s69 | s61 | s129 | s137));
assign s260 = s91 | (s63 & ii_i0_fu[7]) | (s123 & ii_i0_fu[7]) | s75 | s147;
assign s261 = s93 | s77 | s149;
assign s262 = s86 | (s78 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s110 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s118 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s66 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s58 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s50 & (ii_i1_fu[16] | ii_i1_fu[17])) | (s102 & (ii_i1_fu[16] | ii_i1_fu[17])) | (s126 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s134 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168)) | (ii_i1_fu[21] & (s78 | s102 | s110 | s118 | s66 | s58 | s126 | s134)) | s94 | s142;
assign s263 = s88 | (s80 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s68 & (ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s68 & ~mm_ls_loadb & (ii_i1_fu[2] | ii_i1_fu[4])) | (s60 & (ii_i1_fu[2] | ii_i1_fu[4] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s120 & (ii_i1_fu[2] | ii_i1_fu[4])) | (s120 & ii_i1_fu[7]) | (s120 & s168) | (s120 & ii_i1_fu[5]) | (s120 & ii_i1_fu[6]) | (s120 & ii_i1_fu[16]) | (s120 & ii_i1_fu[17]) | (s128 & (ii_i1_fu[2] | ii_i1_fu[4])) | (s128 & ii_i1_fu[7]) | (s128 & s168) | (s128 & ii_i1_fu[5]) | (s128 & ii_i1_fu[6]) | (s136 & (ii_i1_fu[2] | ii_i1_fu[4])) | (s136 & ii_i1_fu[7]) | (s136 & s168) | (s136 & ii_i1_fu[5]) | (s136 & ii_i1_fu[6]) | (s60 & ii_i1_fu[5]) | (s60 & ii_i1_fu[6]) | (s80 & ii_i1_fu[5]) | (s80 & ii_i1_fu[6]) | s96 | (s60 & ii_i1_fu[5]) | s144 | (ii_i1_fu[21] & (s80 | s104 | s112 | s120 | s68 | s60 | s128 | s136));
assign s264 = s90 | (s62 & ii_i1_fu[7]) | (s122 & ii_i1_fu[7]) | s74 | s146;
assign s265 = s86 | (s78 & (ii_i1_fu[2] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s66 & (ii_i1_fu[2] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s58 & (ii_i1_fu[2] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s110 & (ii_i1_fu[2] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s118 & (ii_i1_fu[2] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s126 & (ii_i1_fu[2] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s134 & (ii_i1_fu[2] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168)) | (ii_i1_fu[21] & (s78 | s102 | s110 | s118 | s66 | s58 | s126 | s134)) | s94 | s142;
assign s266 = s88 | (s80 & (ii_i1_fu[2] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s68 & (ii_i1_fu[2] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s60 & (ii_i1_fu[2] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s120 & (ii_i1_fu[2] | ii_i1_fu[4])) | (s120 & ii_i1_fu[7]) | (s120 & s168) | (s120 & ii_i1_fu[5]) | (s120 & ii_i1_fu[6]) | (s120 & ii_i1_fu[16]) | (s120 & ii_i1_fu[17]) | (s128 & (ii_i1_fu[2] | ii_i1_fu[4])) | (s128 & ii_i1_fu[7]) | (s128 & s168) | (s128 & ii_i1_fu[5]) | (s128 & ii_i1_fu[6]) | (s136 & (ii_i1_fu[2] | ii_i1_fu[4])) | (s136 & ii_i1_fu[7]) | (s136 & s168) | (s136 & ii_i1_fu[5]) | (s136 & ii_i1_fu[6]) | (s60 & ii_i1_fu[5]) | (s60 & ii_i1_fu[6]) | (s80 & ii_i1_fu[5]) | (s80 & ii_i1_fu[6]) | s96 | (s60 & ii_i1_fu[5]) | s144 | (ii_i1_fu[21] & (s80 | s104 | s112 | s120 | s68 | s60 | s128 | s136));
assign s267 = s90 | (s62 & ii_i1_fu[7]) | (s122 & ii_i1_fu[7]) | s74 | s146;
assign s268 = s92 | s76 | s148;
assign s269 = s87 | (s79 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s111 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s119 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s67 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s59 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s51 & (ii_i1_fu[16] | ii_i1_fu[17])) | (s103 & (ii_i1_fu[16] | ii_i1_fu[17])) | (s127 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s135 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168)) | (ii_i1_fu[21] & (s79 | s103 | s111 | s119 | s67 | s59 | s127 | s135)) | s95 | s143;
assign s270 = s89 | (s81 & (ii_i1_fu[2] | ii_i1_fu[4] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s69 & (ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s69 & ~mm_ls_loadb & (ii_i1_fu[2] | ii_i1_fu[4])) | (s61 & (ii_i1_fu[2] | ii_i1_fu[4] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s121 & (ii_i1_fu[2] | ii_i1_fu[4])) | (s121 & ii_i1_fu[7]) | (s121 & s168) | (s121 & ii_i1_fu[5]) | (s121 & ii_i1_fu[6]) | (s121 & ii_i1_fu[16]) | (s121 & ii_i1_fu[17]) | (s129 & (ii_i1_fu[2] | ii_i1_fu[4])) | (s129 & ii_i1_fu[7]) | (s129 & s168) | (s129 & ii_i1_fu[5]) | (s129 & ii_i1_fu[6]) | (s137 & (ii_i1_fu[2] | ii_i1_fu[4])) | (s137 & ii_i1_fu[7]) | (s137 & s168) | (s137 & ii_i1_fu[5]) | (s137 & ii_i1_fu[6]) | (s61 & ii_i1_fu[5]) | (s61 & ii_i1_fu[6]) | (s81 & ii_i1_fu[5]) | (s81 & ii_i1_fu[6]) | s97 | (s61 & ii_i1_fu[5]) | s145 | (ii_i1_fu[21] & (s81 | s105 | s113 | s121 | s69 | s61 | s129 | s137));
assign s271 = s91 | (s63 & ii_i1_fu[7]) | (s123 & ii_i1_fu[7]) | s75 | s147 | ii_i1_fu[16] | ii_i1_fu[17];
assign s272 = s87 | (s79 & (ii_i1_fu[2] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s67 & (ii_i1_fu[2] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s59 & (ii_i1_fu[2] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s111 & (ii_i1_fu[2] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s119 & (ii_i1_fu[2] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s127 & (ii_i1_fu[2] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s135 & (ii_i1_fu[2] | ii_i1_fu[6] | ii_i1_fu[5] | ii_i1_fu[7] | s168)) | (ii_i1_fu[21] & (s79 | s103 | s111 | s119 | s67 | s59 | s127 | s135)) | s95 | s143;
assign s273 = s89 | (s81 & (ii_i1_fu[2] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s69 & (ii_i1_fu[2] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s61 & (ii_i1_fu[2] | ii_i1_fu[7] | s168 | ii_i1_fu[16] | ii_i1_fu[17])) | (s121 & (ii_i1_fu[2] | ii_i1_fu[4])) | (s121 & ii_i1_fu[7]) | (s121 & s168) | (s121 & ii_i1_fu[5]) | (s121 & ii_i1_fu[6]) | (s121 & ii_i1_fu[16]) | (s121 & ii_i1_fu[17]) | (s129 & (ii_i1_fu[2] | ii_i1_fu[4])) | (s129 & ii_i1_fu[7]) | (s129 & s168) | (s129 & ii_i1_fu[5]) | (s129 & ii_i1_fu[6]) | (s137 & (ii_i1_fu[2] | ii_i1_fu[4])) | (s137 & ii_i1_fu[7]) | (s137 & s168) | (s137 & ii_i1_fu[5]) | (s137 & ii_i1_fu[6]) | (s61 & ii_i1_fu[5]) | (s61 & ii_i1_fu[6]) | (s81 & ii_i1_fu[5]) | (s81 & ii_i1_fu[6]) | s97 | (s61 & ii_i1_fu[5]) | s145 | (ii_i1_fu[21] & (s81 | s105 | s113 | s121 | s69 | s61 | s129 | s137));
assign s274 = s91 | (s63 & ii_i1_fu[7]) | (s123 & ii_i1_fu[7]) | s75 | s147;
assign s275 = s93 | s77 | s149;
wire s280;
wire s281;
wire s282;
wire s283;
wire s284;
wire s285;
wire s286;
wire s287;
wire s288;
wire s289;
wire s290;
wire s291;
assign s280 = s86 | (s78 & s167) | (s110 & s167) | (s118 & s167) | (s126 & s167) | (s134 & s167) | (s66 & s167) | (s58 & s167) | (s66 & s167) | s94 | s142;
assign s281 = s280;
assign s282 = s88 | (s80 & s167) | (s68 & s167) | (s60 & s167) | (s120 & s167) | (s128 & s167) | (s136 & s167) | s96 | s144;
assign s283 = s282;
assign s284 = s90 | s74 | s146;
assign s285 = s284;
assign s286 = s87 | (s79 & s167) | (s111 & s167) | (s119 & s167) | (s127 & s167) | (s135 & s167) | (s67 & s167) | (s59 & s167) | (s67 & s167) | s95 | s143;
assign s287 = s286;
assign s288 = s89 | (s81 & s167) | (s69 & s167) | (s61 & s167) | (s121 & s167) | (s129 & s167) | (s137 & s167) | s97 | s145;
assign s289 = s288;
assign s290 = s91 | s75 | s147;
assign s291 = s290;
assign ii_i0_raw_hazard = (s248 & rs1_match_ex_rd1) | (s255 & rs1_match_ex_rd2) | (s249 & rs1_match_mm_rd1) | (s256 & rs1_match_mm_rd2) | (s250 & s197) | (s257 & s198) | (s251 & s201) | (s258 & s202) | (s252 & s203) | (s259 & s204) | (s253 & s205) | (s260 & s206) | (s280 & rs3_match_ex_rd1 & ii_i0_singleissue) | (s286 & rs3_match_ex_rd2 & ii_i0_singleissue) | (s282 & rs3_match_mm_rd1 & ii_i0_singleissue) | (s288 & rs3_match_mm_rd2 & ii_i0_singleissue) | (s284 & s210 & ii_i0_singleissue) | (s290 & s211 & ii_i0_singleissue) | (s281 & s215 & ii_i0_singleissue) | (s287 & s216 & ii_i0_singleissue) | (s283 & s217 & ii_i0_singleissue) | (s289 & s218 & ii_i0_singleissue) | (s285 & s219 & ii_i0_singleissue) | (s291 & s220 & ii_i0_singleissue) | (s254 & (s199 | s207)) | (s254 & (s212 | s221) & ii_i0_singleissue) | (s261 & (s200 | s208)) | (s261 & (s213 | s222) & ii_i0_singleissue) | (ii_rs_ren[1] & s6) | (ii_rs_ren[2] & s7) | (ii_rs_ren[3] & s8 & ii_i0_singleissue) | (ii_rs_ren[4] & s9 & ii_i0_singleissue);
assign ii_i1_raw_hazard = (s247 & (s209 | s214)) | (s262 & rs3_match_ex_rd1) | (s269 & rs3_match_ex_rd2) | (s263 & rs3_match_mm_rd1) | (s270 & rs3_match_mm_rd2) | (s265 & s215) | (s272 & s216) | (s266 & s217) | (s273 & s218) | (s264 & s210) | (s271 & s211) | (s267 & s219) | (s274 & s220) | (s268 & (s212 | s221)) | (s275 & (s213 | s222)) | (ii_rs_ren[3] & s8) | (ii_rs_ren[4] & s9);
assign {s169,s170} = ({15{s50}} & {9'h002,6'h01}) | ({15{s58}} & {9'h000,6'h02}) | ({15{s66}} & {9'h000,6'h02}) | ({15{s78}} & {9'h000,6'h02}) | ({15{s86}} & {9'h000,6'h00}) | ({15{s94}} & {9'h000,6'h00}) | ({15{s102}} & {9'h002,6'h01}) | ({15{s110}} & {9'h000,6'h02}) | ({15{s118}} & {9'h000,6'h02}) | ({15{s126}} & {9'h000,6'h02}) | ({15{s134}} & {9'h002,6'h02}) | ({15{s142}} & {9'h000,6'h00});
assign {s171,s172} = ({15{s51}} & {9'h004,6'h01}) | ({15{s59}} & {9'h000,6'h04}) | ({15{s67}} & {9'h000,6'h04}) | ({15{s79}} & {9'h000,6'h04}) | ({15{s87}} & {9'h000,6'h00}) | ({15{s95}} & {9'h000,6'h00}) | ({15{s103}} & {9'h004,6'h01}) | ({15{s111}} & {9'h000,6'h04}) | ({15{s119}} & {9'h000,6'h04}) | ({15{s127}} & {9'h000,6'h04}) | ({15{s135}} & {9'h004,6'h04}) | ({15{s143}} & {9'h000,6'h00});
assign {s173,s174} = ({15{s52}} & {9'h008,6'h01}) | ({15{s60}} & {9'h000,6'h08}) | ({15{s68}} & {9'h000,6'h08}) | ({15{s80}} & {9'h000,6'h08}) | ({15{s88}} & {9'h000,6'h00}) | ({15{s96}} & {9'h000,6'h00}) | ({15{s104}} & {9'h008,6'h01}) | ({15{s112}} & {9'h008,6'h01}) | ({15{s120}} & {9'h000,6'h08}) | ({15{s128}} & {9'h000,6'h08}) | ({15{s136}} & {9'h008,6'h08}) | ({15{s144}} & {9'h000,6'h00});
assign {s176,s177} = ({15{s53}} & {9'h010,6'h01}) | ({15{s61}} & {9'h000,6'h10}) | ({15{s69}} & {9'h000,6'h10}) | ({15{s81}} & {9'h000,6'h10}) | ({15{s89}} & {9'h000,6'h00}) | ({15{s97}} & {9'h000,6'h00}) | ({15{s105}} & {9'h010,6'h01}) | ({15{s113}} & {9'h010,6'h01}) | ({15{s121}} & {9'h000,6'h10}) | ({15{s129}} & {9'h000,6'h10}) | ({15{s137}} & {9'h010,6'h10}) | ({15{s145}} & {9'h000,6'h00});
assign s181 = ({9{s54}} & 9'h020) | ({9{s62}} & 9'h020) | ({9{s70}} & 9'h020) | ({9{s82}} & 9'h020) | ({9{s90}} & 9'h000) | ({9{s98}} & 9'h020) | ({9{s106}} & 9'h020) | ({9{s114}} & 9'h020) | ({9{s122}} & 9'h020) | ({9{s130}} & 9'h020) | ({9{s138}} & 9'h020) | ({9{s146}} & 9'h000);
assign s182 = ({9{s55}} & 9'h040) | ({9{s63}} & 9'h040) | ({9{s71}} & 9'h040) | ({9{s83}} & 9'h040) | ({9{s91}} & 9'h000) | ({9{s99}} & 9'h040) | ({9{s107}} & 9'h040) | ({9{s115}} & 9'h040) | ({9{s123}} & 9'h040) | ({9{s131}} & 9'h040) | ({9{s139}} & 9'h040) | ({9{s147}} & 9'h000);
assign s179 = ({9{s56}} & 9'h080) | ({9{s64}} & 9'h080) | ({9{s72}} & 9'h080) | ({9{s84}} & 9'h080) | ({9{s92}} & 9'h080) | ({9{s100}} & 9'h080) | ({9{s108}} & 9'h080) | ({9{s116}} & 9'h080) | ({9{s124}} & 9'h080) | ({9{s132}} & 9'h080) | ({9{s140}} & 9'h080) | ({9{s148}} & 9'h000);
assign s180 = ({9{s57}} & 9'h100) | ({9{s65}} & 9'h100) | ({9{s73}} & 9'h100) | ({9{s85}} & 9'h100) | ({9{s93}} & 9'h100) | ({9{s101}} & 9'h100) | ({9{s109}} & 9'h100) | ({9{s117}} & 9'h100) | ({9{s125}} & 9'h100) | ({9{s133}} & 9'h100) | ({9{s141}} & 9'h100) | ({9{s149}} & 9'h000);
assign s175 = ({8{s52}} & 8'h08) | ({8{s104}} & 8'h08) | ({8{s112}} & 8'h08) | ({8{s128}} & 8'h08) | ({8{s136}} & 8'h08) | ({8{s68}} & 8'h20);
assign s178 = ({8{s53}} & 8'h10) | ({8{s105}} & 8'h10) | ({8{s113}} & 8'h10) | ({8{s129}} & 8'h10) | ({8{s137}} & 8'h10) | ({8{s69}} & 8'h20);
assign ii_i0_ls_base_bypass = rs1_match_ex_rd2 ? 1'b0 : rs1_match_ex_rd1 ? 1'b0 : rs1_match_mm_rd2 ? s69 : rs1_match_mm_rd1 ? s68 : 1'b0;
assign ii_i1_ls_base_bypass = rs3_match_ex_rd2 ? 1'b0 : rs3_match_ex_rd1 ? 1'b0 : rs3_match_mm_rd2 ? s69 : rs3_match_mm_rd1 ? s68 : 1'b0;
assign s183 = (rs1_match_ex_rd2) ? s171 : (rs1_match_ex_rd1) ? s169 : (rs1_match_mm_rd2) ? s176 : (rs1_match_mm_rd1) ? s173 : (s198) ? s182 : (s197) ? s181 : (s200) ? s180 : (s199) ? s179 : 9'h001;
assign s184 = ~ii_rs_ren[1] ? 6'h01 : (rs1_match_ex_rd2) ? s172 : (rs1_match_ex_rd1) ? s170 : (rs1_match_mm_rd2) ? s177 : (rs1_match_mm_rd1) ? s174 : 6'h01;
assign s185 = (rs1_match_ex_rd2) ? 8'h04 : (rs1_match_ex_rd1) ? 8'h02 : (rs1_match_mm_rd2) ? s178 : (rs1_match_mm_rd1) ? s175 : (s198) ? 8'h80 : (s197) ? 8'h40 : 8'h01;
assign s186 = (s202) ? s171 : (s201) ? s169 : (s204) ? s176 : (s203) ? s173 : (s206) ? s182 : (s205) ? s181 : (s208) ? s180 : (s207) ? s179 : 9'h001;
assign s187 = ~ii_rs_ren[2] ? 6'h01 : (s202) ? s172 : (s201) ? s170 : (s204) ? s177 : (s203) ? s174 : 6'h01;
assign s188 = (s202) ? 8'h04 : (s201) ? 8'h02 : (s204) ? s178 : (s203) ? s175 : (s206) ? 8'h80 : (s205) ? 8'h40 : 8'h01;
assign s189 = (rs3_match_ex_rd2) ? s171 : (rs3_match_ex_rd1) ? s169 : (rs3_match_mm_rd2) ? s176 : (rs3_match_mm_rd1) ? s173 : (s211) ? s182 : (s210) ? s181 : (s213) ? s180 : (s212) ? s179 : 9'h001;
assign s190 = ~ii_rs_ren[3] ? 6'h01 : (s276 | s278) ? 6'h20 : (rs3_match_ex_rd2) ? s172 : (rs3_match_ex_rd1) ? s170 : (rs3_match_mm_rd2) ? s177 : (rs3_match_mm_rd1) ? s174 : 6'h01;
assign s191 = (rs3_match_ex_rd2) ? 8'h04 : (rs3_match_ex_rd1) ? 8'h02 : (rs3_match_mm_rd2) ? s178 : (rs3_match_mm_rd1) ? s175 : (s211) ? 8'h80 : (s210) ? 8'h40 : 8'h01;
assign s192 = (s216) ? s171 : (s215) ? s169 : (s218) ? s176 : (s217) ? s173 : (s220) ? s182 : (s219) ? s181 : (s222) ? s180 : (s221) ? s179 : 9'h001;
assign s193 = ~ii_rs_ren[4] ? 6'h01 : (s277 | s279) ? 6'h20 : (s216) ? s172 : (s215) ? s170 : (s218) ? s177 : (s217) ? s174 : 6'h01;
assign s194 = (s216) ? 8'h04 : (s215) ? 8'h02 : (s218) ? s178 : (s217) ? s175 : (s220) ? 8'h80 : (s219) ? 8'h40 : 8'h01;
assign s195 = (s209 & ii_i0_fu[2]) ? 2'h2 : 2'h1;
assign s196 = (s214 & ii_i0_fu[2]) ? 2'h2 : 2'h1;
assign ii_i0_bypass = {s186,s183};
assign ii_i1_bypass = {s192,s189};
assign ii_i1_ex_bypass[0] = ~s209;
assign ii_i1_ex_bypass[1] = s209;
assign ii_i1_ex_bypass[2] = ~s214;
assign ii_i1_ex_bypass[3] = s214;
assign ii_i0_mm_bypass = {s187,s184};
assign ii_i1_mm_bypass = {s193,s190};
assign ii_i1_lx_bypass = {s196,s195};
assign ii_i0_late = ((ii_rs_ren[1] & ~s184[0]) | (ii_rs_ren[2] & ~s187[0]));
assign ii_i1_late = (ii_rs_ren[3] & ~s190[0]) | (ii_rs_ren[3] & s195[1]) | (ii_rs_ren[4] & ~s193[0]) | (ii_rs_ren[4] & s196[1]) | (ii_is_calu_pair & ii_i0_late) | (s167 & ii_rs_ren[3] & s209) | (s167 & ii_rs_ren[4] & s214) | s276 | s277 | s278 | s279;
assign ii_i0_struct_hazard = (ii_i0_fu[6] & ~mdu_req_ready) | (ii_i0_fu[6] & s86) | (ii_i0_fu[6] & s87) | (ii_i0_fu[2] & ~ls_issue_ready) | (ii_i0_fu[4] & ~ls_issue_ready) | (ii_i0_fu[13] & ace_no_credit_stall) | (ii_i0_fu[9] & ii_i0_late);
assign ii_i1_struct_hazard = (ii_i1_fu[6] & ~mdu_req_ready) | (ii_i1_fu[6] & s86) | (ii_i1_fu[6] & s87) | (ii_i1_fu[2] & ~ls_issue_ready) | (ii_i1_fu[4] & ~ls_issue_ready) | (ii_i1_fu[13] & ace_no_credit_stall) | (ii_i1_fu[9] & ii_i1_late) | (ii_i1_fu[7]) | (ii_i1_fu[6] & ii_i0_fu[6]) | (ii_i1_fu[5] & ii_i0_fu[5]) | (s167 & s168) | (ii_i1_fu[13] & ii_i0_fu[13]) | (ii_i1_fu[5] & ii_i0_fu[6]) | (ii_i1_fu[6] & ii_i0_fu[5]) | ((ii_i1_fu[2] | ii_i1_fu[4]) & (ii_i0_fu[2] | ii_i0_fu[4])) | ((ii_i1_fu[2] | ii_i1_fu[4]) & (ii_i0_fu[8] & ii_i0_late)) | ((ii_i1_fu[13]) & (ii_i0_fu[8] & ii_i0_late)) | (ii_i0_fu[2] & ii_i1_fu[23]) | (ii_i0_fu[4] & ii_i1_fu[23]) | (ii_i0_fu[22] & ii_i1_fu[23]);
assign ii_i0_waw_hazard = ((s223 | s231) & (s86 | s142 | s159)) | ((s224 | s232) & (s87 | s143 | s160)) | ((s225 | s233) & (s88 | s144 | s161)) | ((s226 | s234) & (s89 | s145 | s162)) | ((s227 | s235) & (s90 | s74 | s146 | s163)) | ((s228 | s236) & (s91 | s75 | s147 | s164)) | ((s229 | s237) & (s92 | s76 | s148 | s165)) | ((s230 | s238) & (s93 | s77 | s149 | s166)) | (ii_i0_rd1_wen & s10) | (ii_i0_rd2_wen & s11);
assign ii_i1_waw_hazard = (ii_i0_rd1_wen & ii_i1_rd1_wen & (ii_i0_rd1 == ii_i1_rd1)) | (s239 & (s86 | s142)) | (s240 & (s87 | s143)) | (s241 & (s88 | s144)) | (s242 & (s89 | s145)) | (s243 & (s90 | s74 | s146 | s163)) | (s244 & (s91 | s75 | s147 | s164)) | (s245 & (s92 | s76 | s148 | s165)) | (s246 & (s93 | s77 | s149 | s166)) | (ii_i1_rd1_wen & s12);
assign ii_i0_ex_nbload_hazard = (s68 & (rs1_match_mm_rd1 | s203 | s225)) | (s68 & s233) | (s69 & (rs1_match_mm_rd2 | s204 | s226)) | (s69 & s234) | (ii_i0_singleissue & s68 & (rs3_match_mm_rd1 | s217)) | (ii_i0_singleissue & s69 & (rs3_match_mm_rd2 | s218));
assign ii_i1_ex_nbload_hazard = (s68 & (rs3_match_mm_rd1 | s217 | s241)) | (s69 & (rs3_match_mm_rd2 | s218 | s242));
assign ii_i0_mm_nbload_hazard = (s66 & (rs1_match_ex_rd1 | s201 | s223)) | (s66 & s231) | (s67 & (rs1_match_ex_rd2 | s202 | s224)) | (s67 & s232) | (ii_i0_singleissue & s66 & (s215 | rs3_match_ex_rd1)) | (ii_i0_singleissue & s67 & (s216 | rs3_match_ex_rd2));
assign ii_i1_mm_nbload_hazard = (s66 & (rs3_match_ex_rd1 | s215 | s239)) | (s67 & (rs3_match_ex_rd2 | s216 | s240));
assign ii_mdu_bypass = (ii_i0_fu[6] | ii_i0_fu[5]) ? {s188,s185} : {s194,s191};
assign mdu_kill = (s88 & wb_kill) | (s89 & mm_i0_kill) | (s89 & wb_kill) | (s90 & wb_kill) | (s91 & wb_kill) | (s92 & ~wb_i0_doable) | (s93 & ~wb_i1_doable);
wire nds_unused_wb_i0_abort = wb_i0_abort;
wire nds_unused_wb_i1_abort = wb_i1_abort;
assign event_xrf_busy = (ii_rs_ren[1] & s6) | (ii_rs_ren[2] & s7) | (ii_rs_ren[3] & s8 & ii_i0_singleissue) | (ii_rs_ren[4] & s9 & ii_i0_singleissue);
assign ii_vpu_vtype_sel = (s150) ? 5'b00001 : (s151 | s152) ? 5'b00010 : (s153 | s154) ? 5'b00100 : (s155 | s156) ? 5'b01000 : 5'b10000;
endmodule


// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_iiu_fscb (
    core_clk,
    core_reset_n,
    core_wfi_mode,
    rs1_mtch_mm_rd1,
    rs1_mtch_mm_rd2,
    rs3_mtch_mm_rd1,
    rs3_mtch_mm_rd2,
    rs1_mtch_ex_rd1,
    rs1_mtch_ex_rd2,
    rs3_mtch_ex_rd1,
    rs3_mtch_ex_rd2,
    lx_stall,
    wb_kill,
    mm_i0_kill,
    mm_i1_kill,
    wb_i0_doable,
    wb_i1_doable,
    ii_i0_fu,
    ii_i1_fu,
    ii_i0_frd1,
    ii_i0_frd1_wen,
    ii_i1_frd1,
    ii_i1_frd1_wen,
    fdiv_kill,
    fdiv_req_ready,
    fdiv_resp_return,
    fdiv_resp_tag,
    ii_frs_ren,
    ii_i0_frs1,
    ii_i0_frs2,
    ii_i0_frs3,
    ii_i1_frs1,
    ii_i1_frs2,
    ii_i1_frs3,
    ii_ex_frd1,
    ii_ex_frd2,
    ii_ex_frd1_fu,
    ii_ex_frd2_fu,
    ii_i0_frs1_bypass,
    ii_i0_frs2_bypass,
    ii_i0_frs3_bypass,
    ii_i1_frs1_bypass,
    ii_i1_frs2_bypass,
    ii_i1_frs3_bypass,
    ii_i0_frs1_src_sel,
    ii_i0_frs2_src_sel,
    ii_i0_frs3_src_sel,
    ii_i1_frs1_src_sel,
    ii_i1_frs2_src_sel,
    ii_i1_frs3_src_sel,
    ii_fstore_wdata_sel,
    ii_i0_frs1_vpu_hazard,
    ii_i1_frs1_vpu_hazard,
    ii_i0_f_raw_hazard,
    ii_i1_f_raw_hazard,
    ii_i0_f_struct_hazard,
    ii_i1_f_struct_hazard,
    ii_i0_f_waw_hazard,
    ii_i1_f_waw_hazard
);
input core_clk;
input core_reset_n;
input core_wfi_mode;
input rs1_mtch_mm_rd1;
input rs1_mtch_mm_rd2;
input rs3_mtch_mm_rd1;
input rs3_mtch_mm_rd2;
input rs1_mtch_ex_rd1;
input rs1_mtch_ex_rd2;
input rs3_mtch_ex_rd1;
input rs3_mtch_ex_rd2;
input lx_stall;
input wb_kill;
input mm_i0_kill;
input mm_i1_kill;
input wb_i0_doable;
input wb_i1_doable;
input [23:0] ii_i0_fu;
input [23:0] ii_i1_fu;
input [5:0] ii_i0_frd1;
input ii_i0_frd1_wen;
input [5:0] ii_i1_frd1;
input ii_i1_frd1_wen;
output fdiv_kill;
input fdiv_req_ready;
input fdiv_resp_return;
input [4:0] fdiv_resp_tag;
input [6:1] ii_frs_ren;
input [4:0] ii_i0_frs1;
input [4:0] ii_i0_frs2;
input [4:0] ii_i0_frs3;
input [4:0] ii_i1_frs1;
input [4:0] ii_i1_frs2;
input [4:0] ii_i1_frs3;
input [5:0] ii_ex_frd1;
input [5:0] ii_ex_frd2;
input [18:0] ii_ex_frd1_fu;
input [18:0] ii_ex_frd2_fu;
output [8:0] ii_i0_frs1_bypass;
output [8:0] ii_i0_frs2_bypass;
output [8:0] ii_i0_frs3_bypass;
output [8:0] ii_i1_frs1_bypass;
output [8:0] ii_i1_frs2_bypass;
output [8:0] ii_i1_frs3_bypass;
output [6:0] ii_i0_frs1_src_sel;
output [6:0] ii_i0_frs2_src_sel;
output [6:0] ii_i0_frs3_src_sel;
output [6:0] ii_i1_frs1_src_sel;
output [6:0] ii_i1_frs2_src_sel;
output [6:0] ii_i1_frs3_src_sel;
output [8:0] ii_fstore_wdata_sel;
output ii_i0_frs1_vpu_hazard;
output ii_i1_frs1_vpu_hazard;
output ii_i0_f_raw_hazard;
output ii_i1_f_raw_hazard;
output ii_i0_f_struct_hazard;
output ii_i1_f_struct_hazard;
output ii_i0_f_waw_hazard;
output ii_i1_f_waw_hazard;


reg [31:0] s0;
wire [31:0] s1;
wire [31:0] s2;
wire [31:0] s3;
wire s4;
wire s5;
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
reg [5:0] s16;
reg [5:0] s17;
reg [5:0] s18;
reg [5:0] s19;
reg [5:0] s20;
reg [5:0] s21;
reg [5:0] s22;
reg [5:0] s23;
wire [5:0] s24;
wire [5:0] s25;
wire [5:0] s26;
wire [5:0] s27;
wire [5:0] s28;
wire [5:0] s29;
reg [18:0] s30;
reg [18:0] s31;
reg [18:0] s32;
reg [18:0] s33;
reg [18:0] s34;
reg [18:0] s35;
reg [18:0] s36;
reg [18:0] s37;
wire [18:0] s38;
wire [18:0] s39;
wire [18:0] s40;
wire [18:0] s41;
wire [18:0] s42;
wire [18:0] s43;
wire s44 = ii_frs_ren[1] & (ii_i0_frs1 == s16[4:0]) & s16[5];
wire s45 = ii_frs_ren[1] & (ii_i0_frs1 == s17[4:0]) & s17[5];
wire s46 = ii_frs_ren[1] & (ii_i0_frs1 == s18[4:0]) & s18[5];
wire s47 = ii_frs_ren[1] & (ii_i0_frs1 == s19[4:0]) & s19[5];
wire s48 = ii_frs_ren[1] & (ii_i0_frs1 == s20[4:0]) & s20[5];
wire s49 = ii_frs_ren[1] & (ii_i0_frs1 == s21[4:0]) & s21[5];
wire s50 = ii_frs_ren[1] & (ii_i0_frs1 == s22[4:0]) & s22[5];
wire s51 = ii_frs_ren[1] & (ii_i0_frs1 == s23[4:0]) & s23[5];
wire s52 = ii_frs_ren[4] & (ii_i1_frs1 == ii_i0_frd1[4:0]) & ii_i0_frd1_wen;
wire s53 = ii_frs_ren[4] & (ii_i1_frs1 == s16[4:0]) & s16[5];
wire s54 = ii_frs_ren[4] & (ii_i1_frs1 == s17[4:0]) & s17[5];
wire s55 = ii_frs_ren[4] & (ii_i1_frs1 == s18[4:0]) & s18[5];
wire s56 = ii_frs_ren[4] & (ii_i1_frs1 == s19[4:0]) & s19[5];
wire s57 = ii_frs_ren[4] & (ii_i1_frs1 == s20[4:0]) & s20[5];
wire s58 = ii_frs_ren[4] & (ii_i1_frs1 == s21[4:0]) & s21[5];
wire s59 = ii_frs_ren[4] & (ii_i1_frs1 == s22[4:0]) & s22[5];
wire s60 = ii_frs_ren[4] & (ii_i1_frs1 == s23[4:0]) & s23[5];
wire s61 = ii_frs_ren[2] & (ii_i0_frs2 == s16[4:0]) & s16[5];
wire s62 = ii_frs_ren[2] & (ii_i0_frs2 == s17[4:0]) & s17[5];
wire s63 = ii_frs_ren[2] & (ii_i0_frs2 == s18[4:0]) & s18[5];
wire s64 = ii_frs_ren[2] & (ii_i0_frs2 == s19[4:0]) & s19[5];
wire s65 = ii_frs_ren[2] & (ii_i0_frs2 == s20[4:0]) & s20[5];
wire s66 = ii_frs_ren[2] & (ii_i0_frs2 == s21[4:0]) & s21[5];
wire s67 = ii_frs_ren[2] & (ii_i0_frs2 == s22[4:0]) & s22[5];
wire s68 = ii_frs_ren[2] & (ii_i0_frs2 == s23[4:0]) & s23[5];
wire s69 = ii_frs_ren[5] & (ii_i1_frs2 == ii_i0_frd1[4:0]) & ii_i0_frd1_wen;
wire s70 = ii_frs_ren[5] & (ii_i1_frs2 == s16[4:0]) & s16[5];
wire s71 = ii_frs_ren[5] & (ii_i1_frs2 == s17[4:0]) & s17[5];
wire s72 = ii_frs_ren[5] & (ii_i1_frs2 == s18[4:0]) & s18[5];
wire s73 = ii_frs_ren[5] & (ii_i1_frs2 == s19[4:0]) & s19[5];
wire s74 = ii_frs_ren[5] & (ii_i1_frs2 == s20[4:0]) & s20[5];
wire s75 = ii_frs_ren[5] & (ii_i1_frs2 == s21[4:0]) & s21[5];
wire s76 = ii_frs_ren[5] & (ii_i1_frs2 == s22[4:0]) & s22[5];
wire s77 = ii_frs_ren[5] & (ii_i1_frs2 == s23[4:0]) & s23[5];
wire s78 = ii_frs_ren[3] & (ii_i0_frs3 == s16[4:0]) & s16[5];
wire s79 = ii_frs_ren[3] & (ii_i0_frs3 == s17[4:0]) & s17[5];
wire s80 = ii_frs_ren[3] & (ii_i0_frs3 == s18[4:0]) & s18[5];
wire s81 = ii_frs_ren[3] & (ii_i0_frs3 == s19[4:0]) & s19[5];
wire s82 = ii_frs_ren[3] & (ii_i0_frs3 == s20[4:0]) & s20[5];
wire s83 = ii_frs_ren[3] & (ii_i0_frs3 == s21[4:0]) & s21[5];
wire s84 = ii_frs_ren[3] & (ii_i0_frs3 == s22[4:0]) & s22[5];
wire s85 = ii_frs_ren[3] & (ii_i0_frs3 == s23[4:0]) & s23[5];
wire s86 = ii_frs_ren[6] & (ii_i1_frs3 == ii_i0_frd1[4:0]) & ii_i0_frd1_wen;
wire s87 = ii_frs_ren[6] & (ii_i1_frs3 == s16[4:0]) & s16[5];
wire s88 = ii_frs_ren[6] & (ii_i1_frs3 == s17[4:0]) & s17[5];
wire s89 = ii_frs_ren[6] & (ii_i1_frs3 == s18[4:0]) & s18[5];
wire s90 = ii_frs_ren[6] & (ii_i1_frs3 == s19[4:0]) & s19[5];
wire s91 = ii_frs_ren[6] & (ii_i1_frs3 == s20[4:0]) & s20[5];
wire s92 = ii_frs_ren[6] & (ii_i1_frs3 == s21[4:0]) & s21[5];
wire s93 = ii_frs_ren[6] & (ii_i1_frs3 == s22[4:0]) & s22[5];
wire s94 = ii_frs_ren[6] & (ii_i1_frs3 == s23[4:0]) & s23[5];
wire s95 = ii_frs_ren[1] & (ii_i0_frs1 == fdiv_resp_tag) & fdiv_resp_return;
wire s96 = ii_frs_ren[2] & (ii_i0_frs2 == fdiv_resp_tag) & fdiv_resp_return;
wire s97 = ii_frs_ren[3] & (ii_i0_frs3 == fdiv_resp_tag) & fdiv_resp_return;
wire s98 = ii_frs_ren[4] & (ii_i1_frs1 == fdiv_resp_tag) & fdiv_resp_return;
wire s99 = ii_frs_ren[5] & (ii_i1_frs2 == fdiv_resp_tag) & fdiv_resp_return;
wire s100 = ii_frs_ren[6] & (ii_i1_frs3 == fdiv_resp_tag) & fdiv_resp_return;
wire s101 = ii_i0_frd1_wen & (ii_i0_frd1 == s16);
wire s102 = ii_i0_frd1_wen & (ii_i0_frd1 == s17);
wire s103 = ii_i0_frd1_wen & (ii_i0_frd1 == s18);
wire s104 = ii_i0_frd1_wen & (ii_i0_frd1 == s19);
wire s105 = ii_i0_frd1_wen & (ii_i0_frd1 == s20);
wire s106 = ii_i0_frd1_wen & (ii_i0_frd1 == s21);
wire s107 = ii_i0_frd1_wen & (ii_i0_frd1 == s22);
wire s108 = ii_i0_frd1_wen & (ii_i0_frd1 == s23);
wire s109 = ii_i1_frd1_wen & (ii_i1_frd1 == s16);
wire s110 = ii_i1_frd1_wen & (ii_i1_frd1 == s17);
wire s111 = ii_i1_frd1_wen & (ii_i1_frd1 == s18);
wire s112 = ii_i1_frd1_wen & (ii_i1_frd1 == s19);
wire s113 = ii_i1_frd1_wen & (ii_i1_frd1 == s20);
wire s114 = ii_i1_frd1_wen & (ii_i1_frd1 == s21);
wire s115 = ii_i1_frd1_wen & (ii_i1_frd1 == s22);
wire s116 = ii_i1_frd1_wen & (ii_i1_frd1 == s23);
wire s117;
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
wire s132;
wire s133;
wire s134;
wire s135;
wire s136;
wire s137;
wire s138;
wire s139;
wire s140;
wire s141;
wire s142;
wire s143;
wire s144;
wire s145;
wire s146;
wire s147;
wire s148;
wire s149;
wire s150;
wire s151;
wire s152;
wire s153;
wire s154;
wire s155;
wire s156;
wire s157;
wire s158;
wire s159;
wire s160;
wire s161;
wire s162;
wire s163;
wire s164;
wire s165;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s0 <= 32'd0;
    end
    else if (s4) begin
        s0 <= s1;
    end
end

kv_bin2onehot #(
    .N(32)
) u_wb_frd1_onehot (
    .out(s13),
    .in(s22[4:0])
);
kv_bin2onehot #(
    .N(32)
) u_wb_frd2_onehot (
    .out(s14),
    .in(s23[4:0])
);
kv_bin2onehot #(
    .N(32)
) u_fdiv_resp_rd_onehot (
    .out(s15),
    .in(fdiv_resp_tag)
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_i0_frs1_status (
    .out(s5),
    .sel(ii_i0_frs1[4:0]),
    .in({s0})
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_i0_frs2_status (
    .out(s6),
    .sel(ii_i0_frs2[4:0]),
    .in({s0})
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_i0_frs3_status (
    .out(s7),
    .sel(ii_i0_frs3[4:0]),
    .in({s0})
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_i1_frs1_status (
    .out(s8),
    .sel(ii_i1_frs1[4:0]),
    .in({s0})
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_i1_frs2_status (
    .out(s9),
    .sel(ii_i1_frs2[4:0]),
    .in({s0})
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_i1_frs3_status (
    .out(s10),
    .sel(ii_i1_frs3[4:0]),
    .in({s0})
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_i0_frd1_status (
    .out(s11),
    .sel(ii_i0_frd1[4:0]),
    .in({s0})
);
kv_mux #(
    .N(32),
    .W(1)
) u_ii_i1_frd1_status (
    .out(s12),
    .sel(ii_i1_frd1[4:0]),
    .in({s0})
);
wire s166 = s36[16];
wire s167 = s37[16];
assign s1 = (s0 | s2) & ~s3;
assign s2 = ({32{wb_i0_doable & s166}} & s13[31:0]) | ({32{wb_i1_doable & s167}} & s14[31:0]);
assign s3 = ({32{fdiv_resp_return}} & s15[31:0]);
assign s4 = (wb_i0_doable & s166) | (wb_i1_doable & s167) | fdiv_resp_return;
wire s168 = ii_i0_fu[17] | s30[13] | s32[13] | s34[13] | ii_i1_fu[17] | s31[13] | s33[13] | s35[13];
wire s169 = ii_i0_fu[16] | s30[12] | s32[12] | s34[12] | ii_i1_fu[16] | s31[12] | s33[12] | s35[12];
wire s170 = ii_i0_fu[18] | s30[14] | s32[14] | s34[14] | ii_i1_fu[18] | s31[14] | s33[14] | s35[14];
wire s171 = ii_i0_fu[19] | s30[15] | s32[15] | s34[15] | ii_i1_fu[19] | s31[15] | s33[15] | s35[15];
wire s172 = ii_i0_fu[20] | s30[16] | s32[16] | s34[16] | ii_i1_fu[20] | s31[16] | s33[16] | s35[16];
wire s173 = ii_i0_fu[15] | s30[11] | s32[11] | s34[11] | ii_i1_fu[15] | s31[11] | s33[11] | s35[11];
wire s174 = ii_i0_fu[14] | s30[10] | s32[10] | s34[10] | ii_i1_fu[14] | s31[10] | s33[10] | s35[10];
wire s175 = (~lx_stall & (s168 | s169 | s170 | s171 | s172 | s173 | s174));
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s16 <= 6'd0;
        s17 <= 6'd0;
        s18 <= 6'd0;
        s19 <= 6'd0;
        s20 <= 6'd0;
        s21 <= 6'd0;
        s30 <= {19{1'd0}};
        s31 <= {19{1'd0}};
        s32 <= {19{1'd0}};
        s33 <= {19{1'd0}};
        s34 <= {19{1'd0}};
        s35 <= {19{1'd0}};
    end
    else if (s175) begin
        s16 <= ii_ex_frd1;
        s17 <= ii_ex_frd2;
        s18 <= s24;
        s19 <= s25;
        s20 <= s26;
        s21 <= s27;
        s30 <= ii_ex_frd1_fu;
        s31 <= ii_ex_frd2_fu;
        s32 <= s38;
        s33 <= s39;
        s34 <= s40;
        s35 <= s41;
    end
end

wire s176 = s34[13] | s36[13] | s35[13] | s37[13];
wire s177 = s34[12] | s36[12] | s35[12] | s37[12];
wire s178 = s34[14] | s36[14] | s35[14] | s37[14];
wire s179 = s34[15] | s36[15] | s35[15] | s37[15];
wire s180 = s34[16] | s36[16] | s35[16] | s37[16];
wire s181 = s34[11] | s36[11] | s35[11] | s37[11];
wire s182 = s34[10] | s36[10] | s35[10] | s37[10];
wire s183 = ~core_wfi_mode & (s176 | s177 | s178 | s179 | s180 | s181 | s182);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s22 <= 6'd0;
        s23 <= 6'd0;
        s36 <= {19{1'd0}};
        s37 <= {19{1'd0}};
    end
    else if (s183) begin
        s22 <= s28;
        s23 <= s29;
        s36 <= s42;
        s37 <= s43;
    end
end

assign {s38,s24} = (wb_kill | mm_i0_kill | mm_i1_kill) ? {{19{1'd0}},6'b000000} : {s30,s16};
assign {s39,s25} = (wb_kill | mm_i0_kill | mm_i1_kill) ? {{19{1'd0}},6'b000000} : {s31,s17};
assign {s40,s26} = (wb_kill) ? {{19{1'd0}},6'b000000} : {s32,s18};
assign {s41,s27} = (wb_kill | mm_i0_kill) ? {{19{1'd0}},6'b000000} : {s33,s19};
assign {s42,s28} = (wb_kill | lx_stall) ? {{19{1'd0}},6'b000000} : {s34,s20};
assign {s43,s29} = (wb_kill | lx_stall) ? {{19{1'd0}},6'b000000} : {s35,s21};
assign s117 = ~(ii_i0_fu[17] & ii_i1_fu[15]) & ~(ii_i0_fu[16] & ii_i1_fu[15]) & ~ii_i1_fu[14];
assign s118 = (s30[10] & ~ii_i0_fu[14] & ~ii_i0_fu[15] & ~ii_i0_fu[23]) | (s30[14] & ~ii_i0_fu[14] & ~ii_i0_fu[15]) | (s30[15] & ~ii_i0_fu[14]) | (s30[16] & ~ii_i0_fu[14]) | (s30[12] & ~ii_i0_fu[14] & ~ii_i0_fu[15]);
assign s119 = (s32[10] & ~ii_i0_fu[14] & ~ii_i0_fu[15]) | (s32[14] & ~ii_i0_fu[14] & ~ii_i0_fu[15]) | (s32[15] & ~ii_i0_fu[14] & ~ii_i0_fu[15]) | (s32[16] & ~ii_i0_fu[14]);
assign s120 = (s34[15] & ~ii_i0_fu[14]) | (s34[10] & ii_i0_fu[15]) | (s34[14] & ii_i0_fu[15]) | (s34[16] & ~ii_i0_fu[14]);
assign s121 = (s36[15] & ii_i0_fu[15]) | (s36[16] & ~ii_i0_fu[14] & (~s95 | ii_i0_fu[15]));
assign s122 = s118;
assign s123 = s119;
assign s124 = s120;
assign s125 = (s36[15] & ii_i0_fu[15]) | (s36[16] & ~ii_i0_fu[14] & (~s96 | ii_i0_fu[15]));
assign s130 = (s31[10] & ~ii_i0_fu[14] & ~ii_i0_fu[15] & ~ii_i0_fu[23]) | (s31[14] & ~ii_i0_fu[14] & ~ii_i0_fu[15]) | (s31[15] & ~ii_i0_fu[14]) | (s31[16] & ~ii_i0_fu[14]) | (s31[12] & ~ii_i0_fu[14] & ~ii_i0_fu[15]);
assign s131 = (s33[10] & ~ii_i0_fu[14] & ~ii_i0_fu[15]) | (s33[14] & ~ii_i0_fu[14] & ~ii_i0_fu[15]) | (s33[15] & ~ii_i0_fu[14] & ~ii_i0_fu[15]) | (s33[16] & ~ii_i0_fu[14]);
assign s132 = (s35[15] & ~ii_i0_fu[14]) | (s35[10] & ii_i0_fu[15]) | (s35[14] & ii_i0_fu[15]) | (s35[16] & ~ii_i0_fu[14]);
assign s133 = (s37[15] & ii_i0_fu[15]) | (s37[16] & ~ii_i0_fu[14] & (~s95 | ii_i0_fu[15]));
assign s134 = s130;
assign s135 = s131;
assign s136 = s132;
assign s137 = (s37[15] & ii_i0_fu[15]) | (s37[16] & ~ii_i0_fu[14] & (~s96 | ii_i0_fu[15]));
assign s126 = (s30[10] & ii_frs_ren[3]) | (s30[14] & ii_frs_ren[3]) | (s30[15] & ii_frs_ren[3]) | (s30[12] & ii_frs_ren[3]) | (s30[16] & ii_frs_ren[3]);
assign s127 = (s32[10] & ii_frs_ren[3]) | (s32[14] & ii_frs_ren[3]) | (s32[15] & ii_frs_ren[3]) | (s32[16] & ii_frs_ren[3]);
assign s128 = (s34[15] & ii_frs_ren[3]) | (s34[16] & ii_frs_ren[3]);
assign s129 = (s36[16] & ii_frs_ren[3] & ~s97);
assign s138 = (s31[10] & ii_frs_ren[3]) | (s31[14] & ii_frs_ren[3]) | (s31[15] & ii_frs_ren[3]) | (s31[12] & ii_frs_ren[3]) | (s31[16] & ii_frs_ren[3]);
assign s139 = (s33[10] & ii_frs_ren[3]) | (s33[14] & ii_frs_ren[3]) | (s33[15] & ii_frs_ren[3]) | (s33[16] & ii_frs_ren[3]);
assign s140 = (s35[15] & ii_frs_ren[3]) | (s35[16] & ii_frs_ren[3]);
assign s141 = (s37[16] & ii_frs_ren[3] & ~s97);
assign s142 = (s30[10] & ~ii_i1_fu[14] & ~ii_i1_fu[15]) | (s30[14] & ~ii_i1_fu[14] & ~ii_i1_fu[15]) | (s30[15] & ~ii_i1_fu[14]) | (s30[16] & ~ii_i1_fu[14]) | (s30[12] & ~ii_i1_fu[14] & ~ii_i1_fu[15]);
assign s143 = (s32[10] & ~ii_i1_fu[14] & ~ii_i1_fu[15]) | (s32[14] & ~ii_i1_fu[14] & ~ii_i1_fu[15]) | (s32[15] & ~ii_i1_fu[14] & ~ii_i1_fu[15]) | (s32[16] & ~ii_i1_fu[14]);
assign s144 = (s34[15] & ~ii_i1_fu[14]) | (s34[10] & ii_i1_fu[15]) | (s34[14] & ii_i1_fu[15]) | (s34[16] & ~ii_i1_fu[14]);
assign s145 = (s36[15] & ii_i1_fu[15]) | (s36[16] & ~ii_i1_fu[14] & (~s98 | ii_i1_fu[15]));
assign s146 = s142;
assign s147 = s143;
assign s148 = s144;
assign s149 = (s36[15] & ii_i1_fu[15]) | (s36[16] & ~ii_i1_fu[14] & (~s99 | ii_i1_fu[15]));
assign s154 = (s31[10] & ~ii_i1_fu[14] & ~ii_i1_fu[15]) | (s31[14] & ~ii_i1_fu[14] & ~ii_i1_fu[15]) | (s31[15] & ~ii_i1_fu[14]) | (s31[16] & ~ii_i1_fu[14]) | (s31[12] & ~ii_i1_fu[14] & ~ii_i1_fu[15]);
assign s155 = (s33[10] & ~ii_i1_fu[14] & ~ii_i1_fu[15]) | (s33[14] & ~ii_i1_fu[14] & ~ii_i1_fu[15]) | (s33[15] & ~ii_i1_fu[14] & ~ii_i1_fu[15]) | (s33[16] & ~ii_i1_fu[14]);
assign s156 = (s35[15] & ~ii_i1_fu[14]) | (s35[10] & ii_i1_fu[15]) | (s35[14] & ii_i1_fu[15]) | (s35[16] & ~ii_i1_fu[14]);
assign s157 = (s37[15] & ii_i1_fu[15]) | (s37[16] & ~ii_i1_fu[14] & (~s98 | ii_i1_fu[15]));
assign s158 = s154;
assign s159 = s155;
assign s160 = s156;
assign s161 = (s37[15] & ii_i1_fu[15]) | (s37[16] & ~ii_i1_fu[14] & (~s99 | ii_i1_fu[15]));
assign s150 = (s30[10] & ii_frs_ren[6]) | (s30[14] & ii_frs_ren[6]) | (s30[15] & ii_frs_ren[6]) | (s30[12] & ii_frs_ren[6]) | (s30[16] & ii_frs_ren[6]);
assign s151 = (s32[10] & ii_frs_ren[6]) | (s32[14] & ii_frs_ren[6]) | (s32[15] & ii_frs_ren[6]) | (s32[16] & ii_frs_ren[6]);
assign s152 = (s34[15] & ii_frs_ren[6]) | (s34[16] & ii_frs_ren[6]);
assign s153 = (s36[16] & ii_frs_ren[6] & ~s100);
assign s162 = (s31[10] & ii_frs_ren[6]) | (s31[14] & ii_frs_ren[6]) | (s31[15] & ii_frs_ren[6]) | (s31[12] & ii_frs_ren[6]) | (s31[16] & ii_frs_ren[6]);
assign s163 = (s33[10] & ii_frs_ren[6]) | (s33[14] & ii_frs_ren[6]) | (s33[15] & ii_frs_ren[6]) | (s33[16] & ii_frs_ren[6]);
assign s164 = (s35[15] & ii_frs_ren[6]) | (s35[16] & ii_frs_ren[6]);
assign s165 = (s37[16] & ii_frs_ren[6] & ~s100);
assign ii_i0_frs1_vpu_hazard = (s30[10] & s44) | (s31[10] & s45);
assign ii_i1_frs1_vpu_hazard = (s30[10] & s53) | (s31[10] & s54);
assign ii_i0_f_raw_hazard = (s118 & s44) | (s130 & s45) | (s119 & s46) | (s131 & s47) | (s120 & s48) | (s132 & s49) | (s121 & s50) | (s133 & s51) | (s122 & s61) | (s134 & s62) | (s123 & s63) | (s135 & s64) | (s124 & s65) | (s136 & s66) | (s125 & s67) | (s137 & s68) | (s126 & s78) | (s138 & s79) | (s127 & s80) | (s139 & s81) | (s128 & s82) | (s140 & s83) | (s129 & s84) | (s141 & s85) | (ii_frs_ren[1] & s5 & ~s95) | (ii_frs_ren[2] & s6 & (~s96 | ii_i0_fu[15])) | (ii_frs_ren[3] & s7 & ~s97);
assign ii_i1_f_raw_hazard = (s117 & (s52 | s69 | s86)) | (s142 & s53) | (s154 & s54) | (s143 & s55) | (s155 & s56) | (s146 & s70) | (s158 & s71) | (s147 & s72) | (s159 & s73) | (s144 & s57) | (s156 & s58) | (s148 & s74) | (s160 & s75) | (s145 & s59) | (s157 & s60) | (s149 & s76) | (s161 & s77) | (s150 & s87) | (s162 & s88) | (s151 & s89) | (s163 & s90) | (s152 & s91) | (s164 & s92) | (s153 & s93) | (s165 & s94) | (ii_frs_ren[4] & s8 & ~s98) | (ii_frs_ren[5] & s9 & (~s99 | ii_i1_fu[15])) | (ii_frs_ren[6] & s10 & ~s100);
wire s184 = (rs1_mtch_mm_rd1 & s32[12]) | (rs1_mtch_mm_rd2 & s33[12]);
wire s185 = (rs3_mtch_mm_rd1 & s32[12]) | (rs3_mtch_mm_rd2 & s33[12]);
wire s186 = (rs1_mtch_ex_rd1 & s30[13]) | (rs1_mtch_ex_rd2 & s31[13]);
wire s187 = (rs3_mtch_ex_rd1 & s30[13]) | (rs3_mtch_ex_rd2 & s31[13]);
wire s188 = ~s44 & ~s45;
wire s189 = ~s44 & ~s45 & ~s46 & ~s47;
wire s190 = ~s44 & ~s45 & ~s46 & ~s47 & ~s48 & ~s49;
wire s191 = ~s61 & ~s62;
wire s192 = ~s61 & ~s62 & ~s63 & ~s64;
wire s193 = ~s61 & ~s62 & ~s63 & ~s64 & ~s65 & ~s66;
wire s194 = ~s78 & ~s79;
wire s195 = ~s78 & ~s79 & ~s80 & ~s81;
wire s196 = ~s78 & ~s79 & ~s80 & ~s81 & ~s82 & ~s83;
wire s197 = ~s53 & ~s54;
wire s198 = ~s53 & ~s54 & ~s55 & ~s56;
wire s199 = ~s53 & ~s54 & ~s55 & ~s56 & ~s57 & ~s58;
wire s200 = ~s70 & ~s71;
wire s201 = ~s70 & ~s71 & ~s72 & ~s73;
wire s202 = ~s70 & ~s71 & ~s72 & ~s73 & ~s74 & ~s75;
wire s203 = ~s87 & ~s88;
wire s204 = ~s87 & ~s88 & ~s89 & ~s90;
wire s205 = ~s87 & ~s88 & ~s89 & ~s90 & ~s91 & ~s92;
assign ii_i0_frs1_src_sel[0] = s190 & ~s50 & ~s51 & ~s95 & ii_frs_ren[1];
assign ii_i0_frs1_src_sel[1] = (s189 & s48 & s34[14]) | (s189 & s49 & s35[14]);
assign ii_i0_frs1_src_sel[2] = (s190 & s50 & s36[15]) | (s190 & s51 & s37[15]);
assign ii_i0_frs1_src_sel[3] = (~ii_frs_ren[1] & ~rs1_mtch_ex_rd1 & ~rs1_mtch_ex_rd2 & rs1_mtch_mm_rd1 & s32[12]) | (~ii_frs_ren[1] & ~rs1_mtch_ex_rd1 & ~rs1_mtch_ex_rd2 & rs1_mtch_mm_rd2 & s33[12]) | (s188 & s46 & s32[12]) | (s188 & s47 & s33[12]);
assign ii_i0_frs1_src_sel[4] = (s188 & s32[13]) | (s188 & s33[13]) | (~ii_frs_ren[1] & ~s184 & ~s186 & ii_i0_fu[17]) | (~ii_frs_ren[1] & ~s184 & ~s186 & ii_i0_fu[16]) | (s189 & s48 & s34[10]) | (s189 & s48 & s34[12]) | (s189 & s48 & s34[13]) | (s190 & s50 & s36[12]) | (s190 & s50 & s36[13]) | (s190 & s50 & s36[14]) | (s190 & s50 & s36[10]) | (s189 & s49 & s35[10]) | (s189 & s35[12]) | (s189 & s35[13]) | (s190 & s51 & s37[12]) | (s190 & s51 & s37[13]) | (s190 & s51 & s37[14]) | (s190 & s51 & s37[10]);
assign ii_i0_frs1_src_sel[5] = s95;
assign ii_i0_frs1_src_sel[6] = (~ii_frs_ren[1] & rs1_mtch_ex_rd1 & s30[13]) | (~ii_frs_ren[1] & rs1_mtch_ex_rd2 & s31[13]) | (s44 & s30[13]) | (s45 & s31[13]);
assign ii_i0_frs2_src_sel[0] = s193 & ~s67 & ~s68 & ~s96 & ii_frs_ren[2];
assign ii_i0_frs2_src_sel[1] = (s192 & s65 & s34[14]) | (s192 & s66 & s35[14]);
assign ii_i0_frs2_src_sel[2] = (s193 & s67 & s36[15]) | (s193 & s68 & s37[15]);
assign ii_i0_frs2_src_sel[3] = (s191 & s63 & s32[12]) | (s191 & s64 & s33[12]);
assign ii_i0_frs2_src_sel[4] = (s191 & s32[13]) | (s191 & s33[13]) | (s192 & s65 & s34[10]) | (s192 & s65 & s34[12]) | (s192 & s65 & s34[13]) | (s193 & s67 & s36[12]) | (s193 & s67 & s36[13]) | (s193 & s67 & s36[14]) | (s193 & s67 & s36[10]) | (s192 & s66 & s35[10]) | (s192 & s35[12]) | (s192 & s35[13]) | (s193 & s68 & s37[12]) | (s193 & s68 & s37[13]) | (s193 & s68 & s37[14]) | (s193 & s68 & s37[10]);
assign ii_i0_frs2_src_sel[5] = s96;
assign ii_i0_frs2_src_sel[6] = (s61 & s30[13]) | (s62 & s31[13]);
assign ii_i0_frs3_src_sel[0] = s196 & ~s84 & ~s85 & ~s97 & ii_frs_ren[3];
assign ii_i0_frs3_src_sel[1] = (s195 & s82 & s34[14]) | (s195 & s83 & s35[14]);
assign ii_i0_frs3_src_sel[2] = (s196 & s84 & s36[15]) | (s196 & s85 & s37[15]);
assign ii_i0_frs3_src_sel[3] = (s194 & s80 & s32[12]) | (s194 & s81 & s33[12]);
assign ii_i0_frs3_src_sel[4] = (s194 & s32[13]) | (s194 & s33[13]) | (s195 & s82 & s34[10]) | (s195 & s82 & s34[12]) | (s195 & s82 & s34[13]) | (s196 & s84 & s36[12]) | (s196 & s84 & s36[13]) | (s196 & s84 & s36[14]) | (s196 & s84 & s36[10]) | (s195 & s83 & s35[10]) | (s195 & s35[12]) | (s195 & s35[13]) | (s196 & s85 & s37[12]) | (s196 & s85 & s37[13]) | (s196 & s85 & s37[14]) | (s196 & s85 & s37[10]);
assign ii_i0_frs3_src_sel[5] = s97;
assign ii_i0_frs3_src_sel[6] = (s78 & s30[13]) | (s79 & s31[13]);
assign ii_i1_frs1_src_sel[0] = s199 & ~s59 & ~s60 & ~s98 & ii_frs_ren[4];
assign ii_i1_frs1_src_sel[1] = (s198 & s57 & s34[14]) | (s198 & s58 & s35[14]);
assign ii_i1_frs1_src_sel[2] = (s199 & s59 & s36[15]) | (s199 & s60 & s37[15]);
assign ii_i1_frs1_src_sel[3] = (~ii_frs_ren[4] & ~rs3_mtch_ex_rd1 & ~rs3_mtch_ex_rd2 & rs3_mtch_mm_rd1 & s32[12]) | (~ii_frs_ren[4] & ~rs3_mtch_ex_rd1 & ~rs3_mtch_ex_rd2 & rs3_mtch_mm_rd2 & s33[12]) | (s197 & s55 & s32[12]) | (s197 & s56 & s33[12]);
assign ii_i1_frs1_src_sel[4] = (s197 & s32[13]) | (s197 & s33[13]) | (~ii_frs_ren[4] & ~s185 & ~s187 & ii_i1_fu[17]) | (~ii_frs_ren[4] & ~s185 & ~s187 & ii_i1_fu[16]) | (s198 & s57 & s34[10]) | (s198 & s57 & s34[12]) | (s198 & s57 & s34[13]) | (s199 & s59 & s36[12]) | (s199 & s59 & s36[13]) | (s199 & s59 & s36[14]) | (s199 & s59 & s36[10]) | (s198 & s58 & s35[10]) | (s198 & s35[12]) | (s198 & s35[13]) | (s199 & s60 & s37[12]) | (s199 & s60 & s37[13]) | (s199 & s60 & s37[14]) | (s199 & s60 & s37[10]);
assign ii_i1_frs1_src_sel[5] = s98;
assign ii_i1_frs1_src_sel[6] = (~ii_frs_ren[4] & rs3_mtch_ex_rd1 & s30[13]) | (~ii_frs_ren[4] & rs3_mtch_ex_rd2 & s31[13]) | (s53 & s30[13]) | (s54 & s31[13]);
assign ii_i1_frs2_src_sel[0] = s202 & ~s76 & ~s77 & ~s99 & ii_frs_ren[5];
assign ii_i1_frs2_src_sel[1] = (s201 & s74 & s34[14]) | (s201 & s75 & s35[14]);
assign ii_i1_frs2_src_sel[2] = (s202 & s76 & s36[15]) | (s202 & s77 & s37[15]);
assign ii_i1_frs2_src_sel[3] = (s200 & s72 & s32[12]) | (s200 & s73 & s33[12]);
assign ii_i1_frs2_src_sel[4] = (s200 & s32[13]) | (s200 & s33[13]) | (s201 & s74 & s34[10]) | (s201 & s74 & s34[12]) | (s201 & s74 & s34[13]) | (s202 & s76 & s36[12]) | (s202 & s76 & s36[13]) | (s202 & s76 & s36[14]) | (s202 & s76 & s36[10]) | (s201 & s75 & s35[10]) | (s201 & s35[12]) | (s201 & s35[13]) | (s202 & s77 & s37[12]) | (s202 & s77 & s37[13]) | (s202 & s77 & s37[14]) | (s202 & s77 & s37[10]);
assign ii_i1_frs2_src_sel[5] = s99;
assign ii_i1_frs2_src_sel[6] = (s70 & s30[13]) | (s71 & s31[13]);
assign ii_i1_frs3_src_sel[0] = s205 & ~s93 & ~s94 & ~s100 & ii_frs_ren[6];
assign ii_i1_frs3_src_sel[1] = (s204 & s91 & s34[14]) | (s204 & s92 & s35[14]);
assign ii_i1_frs3_src_sel[2] = (s205 & s93 & s36[15]) | (s205 & s94 & s37[15]);
assign ii_i1_frs3_src_sel[3] = (s203 & s89 & s32[12]) | (s203 & s90 & s33[12]);
assign ii_i1_frs3_src_sel[4] = (s203 & s32[13]) | (s203 & s33[13]) | (s204 & s91 & s34[10]) | (s204 & s91 & s34[12]) | (s204 & s91 & s34[13]) | (s205 & s93 & s36[12]) | (s205 & s93 & s36[13]) | (s205 & s93 & s36[14]) | (s205 & s93 & s36[10]) | (s204 & s92 & s35[10]) | (s204 & s35[12]) | (s204 & s35[13]) | (s205 & s94 & s37[12]) | (s205 & s94 & s37[13]) | (s205 & s94 & s37[14]) | (s205 & s94 & s37[10]);
assign ii_i1_frs3_src_sel[5] = s100;
assign ii_i1_frs3_src_sel[6] = (s87 & s30[13]) | (s88 & s31[13]);
assign ii_i0_frs1_bypass[0] = 1'b0;
assign ii_i0_frs1_bypass[1] = 1'b0;
assign ii_i0_frs1_bypass[2] = 1'b0;
assign ii_i0_frs1_bypass[3] = s46 & s32[13];
assign ii_i0_frs1_bypass[4] = s47 & s33[13];
assign ii_i0_frs1_bypass[5] = (s189 & s48 & s34[10]) | (s189 & s48 & s34[12]) | (s189 & s48 & s34[13]);
assign ii_i0_frs1_bypass[6] = (s189 & s49 & s35[10]) | (s189 & s49 & s35[12]) | (s189 & s49 & s35[13]);
assign ii_i0_frs1_bypass[7] = (s190 & s50 & s36[12]) | (s190 & s50 & s36[13]) | (s190 & s50 & s36[10]) | (s190 & s50 & s36[14]);
assign ii_i0_frs1_bypass[8] = (s190 & s51 & s37[12]) | (s190 & s51 & s37[13]) | (s190 & s51 & s37[10]) | (s190 & s51 & s37[14]);
assign ii_i1_frs1_bypass[0] = 1'b0;
assign ii_i1_frs1_bypass[1] = 1'b0;
assign ii_i1_frs1_bypass[2] = 1'b0;
assign ii_i1_frs1_bypass[3] = s55 & s32[13];
assign ii_i1_frs1_bypass[4] = s56 & s33[13];
assign ii_i1_frs1_bypass[5] = (s198 & s57 & s34[10]) | (s198 & s57 & s34[12]) | (s198 & s57 & s34[13]);
assign ii_i1_frs1_bypass[6] = (s198 & s58 & s35[10]) | (s198 & s58 & s35[12]) | (s198 & s58 & s35[13]);
assign ii_i1_frs1_bypass[7] = (s199 & s59 & s36[12]) | (s199 & s59 & s36[13]) | (s199 & s59 & s36[10]) | (s199 & s59 & s36[14]);
assign ii_i1_frs1_bypass[8] = (s199 & s60 & s37[12]) | (s199 & s60 & s37[13]) | (s199 & s60 & s37[10]) | (s199 & s60 & s37[14]);
assign ii_i0_frs2_bypass[0] = ~(|ii_i0_frs2_bypass[8:1]) & ii_i0_fu[15];
assign ii_i0_frs2_bypass[1] = 1'b0;
assign ii_i0_frs2_bypass[2] = 1'b0;
assign ii_i0_frs2_bypass[3] = s63 & s32[13];
assign ii_i0_frs2_bypass[4] = s64 & s33[13];
assign ii_i0_frs2_bypass[5] = (s192 & s65 & s34[10]) | (s192 & s65 & s34[12]) | (s192 & s65 & s34[13]);
assign ii_i0_frs2_bypass[6] = (s192 & s66 & s35[10]) | (s192 & s66 & s35[12]) | (s192 & s66 & s35[13]);
assign ii_i0_frs2_bypass[7] = (s193 & s67 & s36[12]) | (s193 & s67 & s36[13]) | (s193 & s67 & s36[10]) | (s193 & s67 & s36[14]);
assign ii_i0_frs2_bypass[8] = (s193 & s68 & s37[12]) | (s193 & s68 & s37[13]) | (s193 & s68 & s37[10]) | (s193 & s68 & s37[14]);
assign ii_i1_frs2_bypass[0] = ~(|ii_i1_frs2_bypass[8:1]) & ii_i1_fu[15];
assign ii_i1_frs2_bypass[1] = 1'b0;
assign ii_i1_frs2_bypass[2] = 1'b0;
assign ii_i1_frs2_bypass[3] = s72 & s32[13];
assign ii_i1_frs2_bypass[4] = s73 & s33[13];
assign ii_i1_frs2_bypass[5] = (s201 & s74 & s34[10]) | (s201 & s74 & s34[12]) | (s201 & s74 & s34[13]);
assign ii_i1_frs2_bypass[6] = (s201 & s75 & s35[10]) | (s201 & s75 & s35[12]) | (s201 & s75 & s35[13]);
assign ii_i1_frs2_bypass[7] = (s202 & s76 & s36[12]) | (s202 & s76 & s36[13]) | (s202 & s76 & s36[10]) | (s202 & s76 & s36[14]);
assign ii_i1_frs2_bypass[8] = (s202 & s77 & s37[12]) | (s202 & s77 & s37[13]) | (s202 & s77 & s37[10]) | (s202 & s77 & s37[14]);
assign ii_i0_frs3_bypass[0] = 1'b0;
assign ii_i0_frs3_bypass[1] = 1'b0;
assign ii_i0_frs3_bypass[2] = 1'b0;
assign ii_i0_frs3_bypass[3] = s80 & s32[13];
assign ii_i0_frs3_bypass[4] = s81 & s33[13];
assign ii_i0_frs3_bypass[5] = (s195 & s82 & s34[10]) | (s195 & s82 & s34[12]) | (s195 & s82 & s34[13]);
assign ii_i0_frs3_bypass[6] = (s195 & s83 & s35[10]) | (s195 & s83 & s35[12]) | (s195 & s83 & s35[13]);
assign ii_i0_frs3_bypass[7] = (s196 & s84 & s36[12]) | (s196 & s84 & s36[13]) | (s196 & s84 & s36[10]) | (s196 & s84 & s36[14]);
assign ii_i0_frs3_bypass[8] = (s196 & s85 & s37[12]) | (s196 & s85 & s37[13]) | (s196 & s85 & s37[10]) | (s196 & s85 & s37[14]);
assign ii_i1_frs3_bypass[0] = 1'b0;
assign ii_i1_frs3_bypass[1] = 1'b0;
assign ii_i1_frs3_bypass[2] = 1'b0;
assign ii_i1_frs3_bypass[3] = s89 & s32[13];
assign ii_i1_frs3_bypass[4] = s90 & s33[13];
assign ii_i1_frs3_bypass[5] = (s204 & s91 & s34[10]) | (s204 & s91 & s34[12]) | (s204 & s91 & s34[13]);
assign ii_i1_frs3_bypass[6] = (s204 & s92 & s35[10]) | (s204 & s92 & s35[12]) | (s204 & s92 & s35[13]);
assign ii_i1_frs3_bypass[7] = (s205 & s93 & s36[12]) | (s205 & s93 & s36[13]) | (s205 & s93 & s36[10]) | (s205 & s93 & s36[14]);
assign ii_i1_frs3_bypass[8] = (s205 & s94 & s37[12]) | (s205 & s94 & s37[13]) | (s205 & s94 & s37[10]) | (s205 & s94 & s37[14]);
wire s206;
assign s206 = ii_i1_fu[15] & ~ii_i0_fu[15];
assign ii_fstore_wdata_sel[0] = ~(|ii_fstore_wdata_sel[8:1]) & (ii_i0_fu[15] | ii_i1_fu[15]);
assign ii_fstore_wdata_sel[1] = (s69 & ii_i0_fu[16] & ii_i1_fu[15]) | (s69 & ii_i0_fu[17] & ii_i1_fu[15]);
assign ii_fstore_wdata_sel[2] = (s61 & ii_i0_fu[15] & s30[12]) | (s61 & ii_i0_fu[15] & s30[13]) | (~s69 & s70 & s206 & s30[12]) | (~s69 & s70 & s206 & s30[13]);
assign ii_fstore_wdata_sel[3] = (s62 & ii_i0_fu[15] & s31[12]) | (s62 & ii_i0_fu[15] & s31[13]) | (~s69 & s71 & s206 & s31[12]) | (~s69 & s71 & s206 & s31[13]);
assign ii_fstore_wdata_sel[4] = (s61 & ii_i0_fu[15] & s30[10]) | (~s69 & s70 & s206 & s30[10]) | (s62 & ii_i0_fu[15] & s31[10]) | (~s69 & s71 & s206 & s31[10]);
assign ii_fstore_wdata_sel[5] = (s61 & ii_i0_fu[15] & s30[14]) | (~s69 & s70 & s206 & s30[14]) | (s62 & ii_i0_fu[15] & s31[14]) | (~s69 & s71 & s206 & s31[14]);
assign ii_fstore_wdata_sel[6] = (~s61 & ~s62 & s63 & ii_i0_fu[15] & ~s32[15]) | (~s69 & ~s71 & ~s70 & s72 & s206 & ~s32[15]);
assign ii_fstore_wdata_sel[7] = (~s62 & ~s61 & s64 & ii_i0_fu[15] & ~s33[15]) | (~s69 & ~s71 & ~s70 & s73 & s206 & ~s33[15]);
assign ii_fstore_wdata_sel[8] = (~s61 & ~s62 & s63 & ii_i0_fu[15] & s32[15]) | (~s62 & ~s61 & s64 & ii_i0_fu[15] & s33[15]) | (~s69 & ~s71 & ~s70 & s72 & s206 & s32[15]) | (~s69 & ~s71 & ~s70 & s73 & s206 & s33[15]);
assign ii_i0_f_struct_hazard = (ii_i0_fu[20] & ~fdiv_req_ready);
assign ii_i1_f_struct_hazard = (ii_i1_fu[20] & ~fdiv_req_ready) | (ii_i1_fu[20] & ii_i0_fu[20]) | (ii_i1_fu[18] & ii_i0_fu[18]) | (ii_i1_fu[19] & ii_i0_fu[19]) | (ii_i1_fu[16] & ii_i0_fu[16]) | (ii_i1_fu[17] & ii_i0_fu[17]) | (ii_frs_ren[3] & ii_i1_fu[20]) | (ii_frs_ren[3] & ii_i1_fu[18]) | (ii_frs_ren[3] & ii_i1_fu[19]) | (ii_frs_ren[3] & ii_i1_fu[16]) | (ii_frs_ren[3] & ii_i1_fu[17]) | (ii_frs_ren[6] & (|ii_frs_ren[3:2]));
assign ii_i0_f_waw_hazard = (s101 & s30[16]) | (s102 & s31[16]) | (s103 & s32[16]) | (s104 & s33[16]) | (s105 & s34[16]) | (s106 & s35[16]) | (s107 & s36[16]) | (s108 & s37[16]) | (ii_i0_frd1_wen & s11);
assign ii_i1_f_waw_hazard = (ii_i0_frd1_wen & ii_i1_frd1_wen & (ii_i0_frd1 == ii_i1_frd1)) | (s109 & s30[16]) | (s110 & s31[16]) | (s111 & s32[16]) | (s112 & s33[16]) | (s113 & s34[16]) | (s114 & s35[16]) | (s115 & s36[16]) | (s116 & s37[16]) | (ii_i1_frd1_wen & s12);
assign fdiv_kill = (s30[16] & (wb_kill | mm_i0_kill | mm_i1_kill)) | (s31[16] & (wb_kill | mm_i0_kill | mm_i1_kill)) | (s32[16] & wb_kill) | (s33[16] & (wb_kill | mm_i0_kill)) | (s34[16] & wb_kill) | (s35[16] & wb_kill) | (s36[16] & ~wb_i0_doable) | (s37[16] & ~wb_i1_doable);
endmodule


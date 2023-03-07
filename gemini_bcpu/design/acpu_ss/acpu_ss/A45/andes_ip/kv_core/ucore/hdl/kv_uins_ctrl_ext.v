// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_uins_ctrl_ext (
    pp_step_ctrl_ext,
    pp_pred_ctrl_ext,
    pp_ucode_ctrl_ext,
    uinstr_ctrl,
    uinstr_end,
    uinstr_imm12,
    csr_halt_mode,
    sync_ins,
    id_dec_ctrl,
    id_uinstr_ctrl
);
parameter STACKSAFE_SUPPORT_INT = 0;
input pp_step_ctrl_ext;
input [1:0] pp_pred_ctrl_ext;
input [2:0] pp_ucode_ctrl_ext;
input [40:0] uinstr_ctrl;
input uinstr_end;
input sync_ins;
input [43:0] id_dec_ctrl;
input csr_halt_mode;
output [322:0] id_uinstr_ctrl;
output [31:0] uinstr_imm12;


wire s0 = 1'b0;
wire [322:0] s1 = {323{1'b0}};
wire [1:0] s2;
wire s3 = uinstr_ctrl[39];
wire s4 = uinstr_ctrl[40];
wire s5 = uinstr_ctrl[38];
wire [15:0] s6 = uinstr_ctrl[12 +:16];
wire s7 = s6[15];
wire s8 = s6[14];
wire s9 = s6[13];
wire s10 = s6[12];
wire s11 = s6[11];
wire s12 = s6[10];
wire s13 = s6[9];
wire s14 = s6[8];
wire s15 = s6[7];
wire s16 = s6[6];
wire s17 = s6[5];
wire s18 = s6[4];
wire s19 = s6[3];
wire s20 = s6[2];
wire s21 = s6[1];
wire nds_unused_uprg_end = s21;
wire s22 = s6[0];
wire [4:0] s23 = uinstr_ctrl[28 +:5];
wire [11:0] s24 = uinstr_ctrl[0 +:12];
wire [4:0] s25 = uinstr_ctrl[33 +:5];
wire [4:0] s26 = s24[4:0];
wire [31:0] s27;
wire [31:0] s28;
wire s29;
wire s30 = s11 | s15 | s12 | s14 | s16;
wire s31;
wire s32;
wire s33 = s13 | s22;
wire s34 = s22 & ~id_dec_ctrl[2];
wire s35 = s22 & id_dec_ctrl[1];
wire s36 = s22 & id_dec_ctrl[2];
wire s37 = pp_step_ctrl_ext;
wire s38 = pp_pred_ctrl_ext[0];
wire s39 = pp_pred_ctrl_ext[1];
wire s40 = pp_ucode_ctrl_ext[0];
wire s41 = pp_ucode_ctrl_ext[1];
wire s42 = pp_ucode_ctrl_ext[2];
wire [2:0] s43 = 3'd2;
wire [1:0] s44 = {2{(~s40)}};
wire [2:0] s45 = {2'b1,(~(s40 & ~s37))};
wire s46 = uinstr_end | s42;
assign s2[0] = uinstr_end;
assign s2[1] = s3 | s5;
assign id_uinstr_ctrl[42] = (uinstr_end & (id_dec_ctrl[5] & ~s0)) | (uinstr_end & id_dec_ctrl[0]) | (s42);
assign id_uinstr_ctrl[292] = s17 | s18 | s33 | s3 | s5 | s46;
assign id_uinstr_ctrl[225 +:2] = {sync_ins,s46};
assign id_uinstr_ctrl[252 +:3] = {1'b0,s13 | s34,s3} & s45;
assign id_uinstr_ctrl[70 +:2] = s2 & s44;
assign id_uinstr_ctrl[307] = s5;
assign id_uinstr_ctrl[317] = s4;
assign id_uinstr_ctrl[49 +:21] = {{9{s24[11]}},s24};
assign id_uinstr_ctrl[164] = s14 | s11 | s15 | s16 | s12;
assign id_uinstr_ctrl[1] = s11;
assign id_uinstr_ctrl[86] = s13 | s35;
assign id_uinstr_ctrl[87] = s36;
assign id_uinstr_ctrl[2] = s14;
assign id_uinstr_ctrl[165] = s14;
assign id_uinstr_ctrl[48] = s12;
assign id_uinstr_ctrl[166] = s12;
assign id_uinstr_ctrl[73] = s12;
assign id_uinstr_ctrl[72] = (s12 & s42);
assign id_uinstr_ctrl[27] = s15 | s16;
assign id_uinstr_ctrl[28] = s15;
assign id_uinstr_ctrl[205 +:8] = s24[7:0];
assign id_uinstr_ctrl[204] = s17 | s18;
assign id_uinstr_ctrl[85] = s17 | s18;
assign id_uinstr_ctrl[216] = s18 | s19 | s7;
assign id_uinstr_ctrl[218] = (s18 & ~s19) | (s7 & ~s41);
assign id_uinstr_ctrl[179] = s18 | s19 | s7;
assign id_uinstr_ctrl[183] = s17 | s8;
assign id_uinstr_ctrl[220] = s17 | s8;
assign id_uinstr_ctrl[181] = id_dec_ctrl[7] & s20;
assign id_uinstr_ctrl[182] = id_dec_ctrl[8] & s20;
assign id_uinstr_ctrl[221 +:4] = id_dec_ctrl[13 +:4];
assign id_uinstr_ctrl[306] = s9;
assign id_uinstr_ctrl[255 +:5] = s23;
assign id_uinstr_ctrl[260] = s30 | s33 | s19 | s20 | s10 | s7;
assign id_uinstr_ctrl[267 +:5] = s25;
assign id_uinstr_ctrl[272] = (s25 != 5'd0);
assign id_uinstr_ctrl[273 +:5] = s20 ? s26 : s23;
assign id_uinstr_ctrl[278] = ((s17 | s20) & (s26 != 5'd0)) | (s8);
assign id_uinstr_ctrl[228 +:21] = id_dec_ctrl[17 +:21];
assign id_uinstr_ctrl[76 +:6] = 6'h02;
assign id_uinstr_ctrl[103 +:3] = 3'd0;
assign id_uinstr_ctrl[88 +:12] = uinstr_ctrl[0 +:12];
assign id_uinstr_ctrl[100 +:2] = id_dec_ctrl[3 +:2];
assign id_uinstr_ctrl[168] = s33 | s10;
assign id_uinstr_ctrl[318 +:5] = s25;
assign id_uinstr_ctrl[302 +:2] = 2'b10;
assign id_uinstr_ctrl[213 +:3] = s40 ? s43 : id_dec_ctrl[9 +:3];
assign id_uinstr_ctrl[199 +:5] = {4'd0,s40};
assign id_uinstr_ctrl[251] = s40 ? s38 : 1'b0;
assign id_uinstr_ctrl[250] = s40 ? s39 : 1'b0;
assign s29 = s20;
assign uinstr_imm12 = (s12 | s40) ? (s28) : (s29 ? ({32{1'b0}}) : (s27));
assign s31 = id_uinstr_ctrl[272];
assign s32 = csr_halt_mode & (s25 == 5'd0) & s19;
assign id_uinstr_ctrl[295 +:6] = {1'b0,1'b0,s32,1'b0,1'b0,s31};
kv_zero_ext #(
    .OW(32),
    .IW(12)
) u_zero_ext_imm12 (
    .out(s27),
    .in(s24)
);
kv_sign_ext #(
    .OW(32),
    .IW(12)
) u_sign_ext_imm12 (
    .out(s28),
    .in(s24)
);
assign id_uinstr_ctrl[293] = (id_dec_ctrl[43] & s11 & (s23 == 5'h07) & ~uinstr_end) | (id_dec_ctrl[43] & s11 & (s23 == 5'h02) & s40);
assign id_uinstr_ctrl[294] = 1'b0;
assign id_uinstr_ctrl[140] = id_dec_ctrl[5];
assign id_uinstr_ctrl[249] = s40;
assign id_uinstr_ctrl[106] = s1[106];
assign id_uinstr_ctrl[227] = s1[227];
assign id_uinstr_ctrl[301] = s1[301];
assign id_uinstr_ctrl[308] = s1[308];
assign id_uinstr_ctrl[107] = s1[107];
assign id_uinstr_ctrl[108] = s1[108];
assign id_uinstr_ctrl[121] = s1[121];
assign id_uinstr_ctrl[196] = s1[196];
assign id_uinstr_ctrl[180] = s1[180];
assign id_uinstr_ctrl[169] = s1[169];
assign id_uinstr_ctrl[171] = s1[171];
assign id_uinstr_ctrl[170] = s1[170];
assign id_uinstr_ctrl[197] = s1[197];
assign id_uinstr_ctrl[167] = s1[167];
assign id_uinstr_ctrl[46] = s1[46];
assign id_uinstr_ctrl[45] = s1[45];
assign id_uinstr_ctrl[44] = s1[44];
assign id_uinstr_ctrl[43] = s1[43];
assign id_uinstr_ctrl[304] = s1[304];
assign id_uinstr_ctrl[305] = s1[305];
assign id_uinstr_ctrl[47] = s1[47];
assign id_uinstr_ctrl[217] = s1[217];
assign id_uinstr_ctrl[219] = s1[219];
assign id_uinstr_ctrl[198] = s1[198];
assign id_uinstr_ctrl[82 +:3] = s1[82 +:3];
assign id_uinstr_ctrl[109 +:8] = s1[109 +:8];
assign id_uinstr_ctrl[118 +:3] = s1[118 +:3];
assign id_uinstr_ctrl[117] = s1[117];
assign id_uinstr_ctrl[19] = s1[19];
assign id_uinstr_ctrl[35] = s1[35];
assign id_uinstr_ctrl[29] = s1[29];
assign id_uinstr_ctrl[30] = s1[30];
assign id_uinstr_ctrl[3] = s1[3];
assign id_uinstr_ctrl[32] = s1[32];
assign id_uinstr_ctrl[33] = s1[33];
assign id_uinstr_ctrl[34] = s1[34];
assign id_uinstr_ctrl[31] = s1[31];
assign id_uinstr_ctrl[23 +:4] = s1[23 +:4];
assign id_uinstr_ctrl[13] = s1[13];
assign id_uinstr_ctrl[12] = s1[12];
assign id_uinstr_ctrl[37 +:5] = s1[37 +:5];
assign id_uinstr_ctrl[14] = s1[14];
assign id_uinstr_ctrl[22] = s1[22];
assign id_uinstr_ctrl[15] = s1[15];
assign id_uinstr_ctrl[17] = s1[17];
assign id_uinstr_ctrl[16] = s1[16];
assign id_uinstr_ctrl[18] = s1[18];
assign id_uinstr_ctrl[10] = s1[10];
assign id_uinstr_ctrl[11] = s1[11];
assign id_uinstr_ctrl[20] = s1[20];
assign id_uinstr_ctrl[21] = s1[21];
assign id_uinstr_ctrl[36] = s1[36];
assign id_uinstr_ctrl[9] = s1[9];
assign id_uinstr_ctrl[5] = s1[5];
assign id_uinstr_ctrl[7] = s1[7];
assign id_uinstr_ctrl[4] = s1[4];
assign id_uinstr_ctrl[6] = s1[6];
assign id_uinstr_ctrl[8] = s1[8];
assign id_uinstr_ctrl[261 +:5] = s1[261 +:5];
assign id_uinstr_ctrl[266] = s1[266];
assign id_uinstr_ctrl[279 +:5] = s1[279 +:5];
assign id_uinstr_ctrl[284] = s1[284];
assign id_uinstr_ctrl[285 +:5] = s1[285 +:5];
assign id_uinstr_ctrl[290] = s1[290];
assign id_uinstr_ctrl[174] = s1[174];
assign id_uinstr_ctrl[175] = s1[175];
assign id_uinstr_ctrl[172] = s1[172];
assign id_uinstr_ctrl[176] = s1[176];
assign id_uinstr_ctrl[177] = s1[177];
assign id_uinstr_ctrl[173] = s1[173];
assign id_uinstr_ctrl[178] = s1[178];
assign id_uinstr_ctrl[131 +:5] = s1[131 +:5];
assign id_uinstr_ctrl[136] = s1[136];
assign id_uinstr_ctrl[141 +:5] = s1[141 +:5];
assign id_uinstr_ctrl[146] = s1[146];
assign id_uinstr_ctrl[147 +:5] = s1[147 +:5];
assign id_uinstr_ctrl[152] = s1[152];
assign id_uinstr_ctrl[153 +:5] = s1[153 +:5];
assign id_uinstr_ctrl[158] = s1[158];
assign id_uinstr_ctrl[316] = s1[316];
assign id_uinstr_ctrl[74] = s1[74];
assign id_uinstr_ctrl[75] = s1[75];
assign id_uinstr_ctrl[130] = s1[130];
assign id_uinstr_ctrl[129] = s1[129];
assign id_uinstr_ctrl[291] = s1[291];
assign id_uinstr_ctrl[122] = s1[122];
assign id_uinstr_ctrl[163] = s1[163];
assign id_uinstr_ctrl[193] = s1[193];
assign id_uinstr_ctrl[194] = s1[194];
assign id_uinstr_ctrl[0] = s1[0];
assign id_uinstr_ctrl[102] = s1[102];
assign id_uinstr_ctrl[159 +:3] = s1[159 +:3];
assign id_uinstr_ctrl[137 +:3] = s1[137 +:3];
assign id_uinstr_ctrl[123 +:6] = s1[123 +:6];
assign id_uinstr_ctrl[162] = s1[162];
assign id_uinstr_ctrl[313] = s1[313];
assign id_uinstr_ctrl[314] = s1[314];
assign id_uinstr_ctrl[315] = s1[315];
assign id_uinstr_ctrl[311] = s1[311];
assign id_uinstr_ctrl[309] = s1[309];
assign id_uinstr_ctrl[310] = s1[310];
assign id_uinstr_ctrl[312] = s1[312];
assign id_uinstr_ctrl[185] = s1[185];
assign id_uinstr_ctrl[189] = s1[189];
assign id_uinstr_ctrl[190] = s1[190];
assign id_uinstr_ctrl[186] = s1[186];
assign id_uinstr_ctrl[188] = s1[188];
assign id_uinstr_ctrl[192] = s1[192];
assign id_uinstr_ctrl[187] = s1[187];
assign id_uinstr_ctrl[191] = s1[191];
assign id_uinstr_ctrl[184] = s1[184];
assign id_uinstr_ctrl[195] = s1[195];
endmodule


// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_sfp_predec (
    instr,
    vpu_decode,
    isa_c_dp_fls_en,
    csr_mmisc_ctl_rvcompm,
    csr_mstatus_fs,
    csr_frm,
    instr_csr,
    instr_sfp,
    instr_illegal_sfp,
    instr_sfp_off_xcpt,
    sfp_rs1_ren,
    sfp_rd1_wen,
    sfp_frd1,
    sfp_frd1_wen,
    sfp_frs1,
    sfp_frs1_ren,
    sfp_frs2,
    sfp_frs2_ren,
    sfp_frs3,
    sfp_frs3_ren,
    sfp_ex_rm,
    sfp_ex_sign,
    sfp_ex_sew,
    sfp_ex_fmac,
    sfp_ex_fdiv,
    sfp_ex_fmis,
    sfp_ex_fmv,
    sfp_ex_ctrl,
    instr_sfp_ls,
    instr_sfp_lhw,
    instr_sfp_shw,
    instr_sfp_lw,
    instr_sfp_sw,
    instr_sfp_ld,
    instr_sfp_sd,
    instr_sfp_c_lwsp,
    instr_sfp_c_swsp,
    instr_sfp_c_ldsp,
    instr_sfp_c_sdsp,
    instr_sfp_c_lw,
    instr_sfp_c_sw,
    instr_sfp_c_ld,
    instr_sfp_c_sd
);
parameter FLEN = 32;
localparam STATE_OFF = 2'd0;
localparam CSR12_FFLAGS = 12'h001;
localparam CSR12_FRM = 12'h002;
localparam CSR12_FCSR = 12'h003;
input [31:0] instr;
input [25:0] vpu_decode;
input isa_c_dp_fls_en;
input csr_mmisc_ctl_rvcompm;
input [1:0] csr_mstatus_fs;
input [31:0] csr_frm;
input instr_csr;
output instr_sfp;
output instr_illegal_sfp;
output instr_sfp_off_xcpt;
output sfp_rs1_ren;
output sfp_rd1_wen;
output [4:0] sfp_frd1;
output sfp_frd1_wen;
output [4:0] sfp_frs1;
output sfp_frs1_ren;
output [4:0] sfp_frs2;
output sfp_frs2_ren;
output [4:0] sfp_frs3;
output sfp_frs3_ren;
output [2:0] sfp_ex_rm;
output sfp_ex_sign;
output [2:0] sfp_ex_sew;
output sfp_ex_fmac;
output sfp_ex_fdiv;
output sfp_ex_fmis;
output sfp_ex_fmv;
output [5:0] sfp_ex_ctrl;
output instr_sfp_ls;
output instr_sfp_lhw;
output instr_sfp_shw;
output instr_sfp_lw;
output instr_sfp_sw;
output instr_sfp_ld;
output instr_sfp_sd;
output instr_sfp_c_lwsp;
output instr_sfp_c_swsp;
output instr_sfp_c_ldsp;
output instr_sfp_c_sdsp;
output instr_sfp_c_lw;
output instr_sfp_c_sw;
output instr_sfp_c_ld;
output instr_sfp_c_sd;


wire s0;
wire s1;
wire s2;
wire s3;
wire s4;
wire s5;
wire s6;
wire s7;
wire s8;
wire s9;
wire s10;
wire s11;
wire s12;
wire s13;
wire s14;
wire s15;
wire s16;
wire s17;
wire s18;
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
wire s33;
wire s34;
wire s35;
wire s36;
wire s37;
wire s38;
wire s39;
wire s40;
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
wire s55;
wire s56;
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
wire s67;
wire s68;
wire s69;
wire s70;
wire s71;
wire s72;
wire s73;
wire s74;
wire s75;
wire s76;
wire s77;
wire s78;
wire s79;
wire s80;
wire s81;
wire s82;
wire s83;
wire s84;
wire s85;
wire s86;
wire s87;
wire s88;
wire s89;
wire s90;
wire s91;
wire s92;
wire s93;
wire s94;
wire s95;
wire s96;
wire s97;
wire s98;
wire s99;
wire s100;
wire s101;
wire s102;
wire s103;
wire s104;
wire s105;
wire s106;
wire s107;
wire s108;
wire s109;
wire s110;
wire s111;
wire [2:0] s112;
wire s113;
wire s114;
wire s115;
wire s116;
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
wire [6:0] s149;
wire [2:0] s150;
wire s151;
wire s152;
wire s153;
assign s149 = instr[31:25];
assign s150 = instr[14:12];
assign s151 = s139 | s140 | s141;
assign s153 = s142 | s143 | s144;
assign s152 = s145 | s146;
assign s147 = s151 | s71 | s72 | s153 | s152;
assign s138 = (instr[6:0] == 7'b1010011) & (s149[6:2] == 5'b11100) & (s150 == 3'b0) & (sfp_frs2 == 5'b0);
assign s137 = (instr[6:0] == 7'b1010011) & (s149[6:2] == 5'b11110) & (s150 == 3'b0) & (sfp_frs2 == 5'b0);
assign s148 = s138 | s137;
assign s119 = (instr[6:0] == 7'b1000011);
assign s120 = (instr[6:0] == 7'b1001111);
assign s121 = (instr[6:0] == 7'b1000111);
assign s122 = (instr[6:0] == 7'b1001011);
assign s123 = (instr[6:0] == 7'b1010011) & (s149[6:2] == 5'b00000);
assign s124 = (instr[6:0] == 7'b1010011) & (s149[6:2] == 5'b00001);
assign s125 = (instr[6:0] == 7'b1010011) & (s149[6:2] == 5'b00010);
assign s126 = (instr[6:0] == 7'b1010011) & (s149[6:2] == 5'b00011);
assign s127 = (instr[6:0] == 7'b1010011) & (s149[6:2] == 5'b01011) & (sfp_frs2 == 5'b0);
assign s128 = (s149[6:2] == 5'b00100) & (s150 == 3'b000) & (instr[6:0] == 7'b1010011);
assign s129 = (s149[6:2] == 5'b00100) & (s150 == 3'b001) & (instr[6:0] == 7'b1010011);
assign s130 = (s149[6:2] == 5'b00100) & (s150 == 3'b010) & (instr[6:0] == 7'b1010011);
assign s131 = (s149[6:2] == 5'b00101) & (s150 == 3'b001) & (instr[6:0] == 7'b1010011);
assign s132 = (s149[6:2] == 5'b00101) & (s150 == 3'b000) & (instr[6:0] == 7'b1010011);
assign s134 = (s149[6:2] == 5'b10100) & (s150 == 3'b000) & (instr[6:0] == 7'b1010011);
assign s133 = (s149[6:2] == 5'b10100) & (s150 == 3'b001) & (instr[6:0] == 7'b1010011);
assign s135 = (s149[6:2] == 5'b10100) & (s150 == 3'b010) & (instr[6:0] == 7'b1010011);
assign s136 = (s149[6:2] == 5'b11100) & (s150 == 3'b001) & (sfp_frs2 == 5'b0) & (instr[6:0] == 7'b1010011);
assign s139 = s59 | s61;
assign s140 = s60 | s50;
assign s141 = s62 | s49;
assign s142 = s53 | s54 | s57 | s58;
assign s143 = s65 | s66 | s69 | s70;
assign s144 = s43 | s44 | s47 | s48;
assign s145 = s51 | s63 | s41 | s52 | s64 | s42;
assign s146 = s55 | s67 | s45 | s56 | s68 | s46;
assign s0 = (instr[14:12] == 3'b001) & (instr[6:0] == 7'b0000111);
assign s1 = (instr[14:12] == 3'b010) & (instr[6:0] == 7'b0000111);
assign s2 = (instr[14:12] == 3'b011) & (instr[6:0] == 7'b0000111) & (FLEN == 64);
assign s3 = (instr[14:12] == 3'b001) & (instr[6:0] == 7'b0100111);
assign s4 = (instr[14:12] == 3'b010) & (instr[6:0] == 7'b0100111);
assign s5 = (instr[14:12] == 3'b011) & (instr[6:0] == 7'b0100111) & (FLEN == 64);
assign s6 = (instr[15:13] == 3'b011) & (instr[1:0] == 2'b00);
assign s7 = (instr[15:13] == 3'b001) & (instr[1:0] == 2'b00) & (FLEN == 64) & isa_c_dp_fls_en;
assign s8 = (instr[15:13] == 3'b011) & (instr[1:0] == 2'b10);
assign s9 = (instr[15:13] == 3'b001) & (instr[1:0] == 2'b10) & (FLEN == 64) & isa_c_dp_fls_en;
assign s10 = (instr[15:13] == 3'b111) & (instr[1:0] == 2'b00);
assign s11 = (instr[15:13] == 3'b101) & (instr[1:0] == 2'b00) & (FLEN == 64) & isa_c_dp_fls_en;
assign s12 = (instr[15:13] == 3'b111) & (instr[1:0] == 2'b10);
assign s13 = (instr[15:13] == 3'b101) & (instr[1:0] == 2'b10) & (FLEN == 64) & isa_c_dp_fls_en;
assign s14 = (s149[1:0] == 2'b10) & s119;
assign s15 = (s149[1:0] == 2'b10) & s120;
assign s16 = (s149[1:0] == 2'b10) & s121;
assign s17 = (s149[1:0] == 2'b10) & s122;
assign s18 = (s149[1:0] == 2'b10) & s123;
assign s19 = (s149[1:0] == 2'b10) & s124;
assign s20 = (s149[1:0] == 2'b10) & s125;
assign s21 = (s149[1:0] == 2'b10) & s126;
assign s22 = (s149[1:0] == 2'b10) & s127;
assign s23 = (s149[1:0] == 2'b00) & s119;
assign s24 = (s149[1:0] == 2'b00) & s120;
assign s25 = (s149[1:0] == 2'b00) & s121;
assign s26 = (s149[1:0] == 2'b00) & s122;
assign s27 = (s149[1:0] == 2'b00) & s123;
assign s28 = (s149[1:0] == 2'b00) & s124;
assign s29 = (s149[1:0] == 2'b00) & s125;
assign s30 = (s149[1:0] == 2'b00) & s126;
assign s31 = (s149[1:0] == 2'b00) & s127;
assign s32 = (s149[1:0] == 2'b01) & s119 & (FLEN == 64);
assign s33 = (s149[1:0] == 2'b01) & s120 & (FLEN == 64);
assign s34 = (s149[1:0] == 2'b01) & s121 & (FLEN == 64);
assign s35 = (s149[1:0] == 2'b01) & s122 & (FLEN == 64);
assign s36 = (s149[1:0] == 2'b01) & s123 & (FLEN == 64);
assign s37 = (s149[1:0] == 2'b01) & s124 & (FLEN == 64);
assign s38 = (s149[1:0] == 2'b01) & s125 & (FLEN == 64);
assign s39 = (s149[1:0] == 2'b01) & s126 & (FLEN == 64);
assign s40 = (s149[1:0] == 2'b01) & s127 & (FLEN == 64);
assign s41 = (instr[31:20] == 12'b110001000000) & (instr[6:0] == 7'b1010011);
assign s42 = (instr[31:20] == 12'b110001000001) & (instr[6:0] == 7'b1010011);
assign s43 = (instr[31:20] == 12'b110101000000) & (instr[6:0] == 7'b1010011);
assign s44 = (instr[31:20] == 12'b110101000001) & (instr[6:0] == 7'b1010011);
assign s45 = 1'b0;
assign s46 = 1'b0;
assign s47 = 1'b0;
assign s48 = 1'b0;
assign s49 = (instr[31:20] == 12'b010001000001) & (instr[6:0] == 7'b1010011) & (FLEN == 64);
assign s50 = (instr[31:20] == 12'b010000100010) & (instr[6:0] == 7'b1010011) & (FLEN == 64);
assign s51 = (instr[31:20] == 12'b110000000000) & (instr[6:0] == 7'b1010011);
assign s52 = (instr[31:20] == 12'b110000000001) & (instr[6:0] == 7'b1010011);
assign s53 = (instr[31:20] == 12'b110100000000) & (instr[6:0] == 7'b1010011);
assign s54 = (instr[31:20] == 12'b110100000001) & (instr[6:0] == 7'b1010011);
assign s55 = 1'b0;
assign s56 = 1'b0;
assign s57 = 1'b0;
assign s58 = 1'b0;
assign s59 = (instr[31:20] == 12'b010000000001) & (instr[6:0] == 7'b1010011) & (FLEN == 64);
assign s60 = (instr[31:20] == 12'b010000100000) & (instr[6:0] == 7'b1010011) & (FLEN == 64);
assign s61 = (instr[31:20] == 12'b010000000010) & (instr[6:0] == 7'b1010011);
assign s62 = (instr[31:20] == 12'b010001000000) & (instr[6:0] == 7'b1010011);
assign s63 = (instr[31:20] == 12'b110000100000) & (instr[6:0] == 7'b1010011) & (FLEN == 64);
assign s64 = (instr[31:20] == 12'b110000100001) & (instr[6:0] == 7'b1010011) & (FLEN == 64);
assign s65 = (instr[31:20] == 12'b110100100000) & (instr[6:0] == 7'b1010011) & (FLEN == 64);
assign s66 = (instr[31:20] == 12'b110100100001) & (instr[6:0] == 7'b1010011) & (FLEN == 64);
assign s67 = 1'b0;
assign s68 = 1'b0;
assign s69 = 1'b0;
assign s70 = 1'b0;
assign s71 = (instr[31:25] == 7'b0000000) & (instr[19:12] == 8'b00010100) & (instr[6:0] == 7'b1011011);
assign s72 = (instr[31:25] == 7'b0000000) & (instr[19:12] == 8'b00011100) & (instr[6:0] == 7'b1011011);
assign s73 = (s149[1:0] == 2'b10) & s135;
assign s74 = (s149[1:0] == 2'b10) & s133;
assign s75 = (s149[1:0] == 2'b10) & s134;
assign s76 = (s149[1:0] == 2'b00) & s135;
assign s77 = (s149[1:0] == 2'b00) & s133;
assign s78 = (s149[1:0] == 2'b00) & s134;
assign s79 = (s149[1:0] == 2'b01) & s135 & (FLEN == 64);
assign s80 = (s149[1:0] == 2'b01) & s133 & (FLEN == 64);
assign s81 = (s149[1:0] == 2'b01) & s134 & (FLEN == 64);
assign s82 = (s149[1:0] == 2'b10) & s132;
assign s83 = (s149[1:0] == 2'b10) & s131;
assign s84 = (s149[1:0] == 2'b00) & s132;
assign s85 = (s149[1:0] == 2'b00) & s131;
assign s86 = (s149[1:0] == 2'b01) & s132 & (FLEN == 64);
assign s87 = (s149[1:0] == 2'b01) & s131 & (FLEN == 64);
assign s88 = (s149[1:0] == 2'b10) & s138;
assign s89 = (s149[1:0] == 2'b10) & s137;
assign s90 = (s149[1:0] == 2'b00) & s138;
assign s91 = (s149[1:0] == 2'b00) & s137;
assign s92 = 1'b0;
assign s93 = 1'b0;
assign s94 = (s149[1:0] == 2'b10) & s128;
assign s95 = (s149[1:0] == 2'b10) & s129;
assign s96 = (s149[1:0] == 2'b10) & s130;
assign s97 = (s149[1:0] == 2'b00) & s128;
assign s98 = (s149[1:0] == 2'b00) & s129;
assign s99 = (s149[1:0] == 2'b00) & s130;
assign s100 = (s149[1:0] == 2'b01) & s128 & (FLEN == 64);
assign s101 = (s149[1:0] == 2'b01) & s129 & (FLEN == 64);
assign s102 = (s149[1:0] == 2'b01) & s130 & (FLEN == 64);
assign s103 = (s149[1:0] == 2'b10) & (s150 == 3'b001) & s136;
assign s104 = (s149[1:0] == 2'b00) & (s150 == 3'b001) & s136;
assign s105 = (s149[1:0] == 2'b01) & (s150 == 3'b001) & s136 & (FLEN == 64);
assign s106 = s0 | s1 | s2 | s3 | s4 | s5 | s6 | s7 | s8 | s9 | s10 | s11 | s12 | s13 | s14 | s15 | s16 | s17 | s18 | s19 | s20 | s21 | s22 | s23 | s24 | s25 | s26 | s27 | s28 | s29 | s30 | s31 | s32 | s33 | s34 | s35 | s36 | s37 | s38 | s39 | s40 | s41 | s42 | s43 | s44 | s45 | s46 | s47 | s48 | s49 | s50 | s51 | s52 | s53 | s54 | s55 | s56 | s57 | s58 | s59 | s60 | s61 | s62 | s63 | s64 | s65 | s66 | s67 | s68 | s69 | s70 | s71 | s72 | s73 | s74 | s75 | s76 | s77 | s78 | s79 | s80 | s81 | s82 | s83 | s84 | s85 | s86 | s87 | s88 | s89 | s90 | s91 | s92 | s93 | s94 | s95 | s96 | s97 | s98 | s99 | s100 | s101 | s102 | s103 | s104 | s105;
assign s107 = s14 | s15 | s16 | s17 | s18 | s19 | s20 | s21 | s22 | s23 | s24 | s25 | s26 | s27 | s28 | s29 | s30 | s31 | s32 | s33 | s34 | s35 | s36 | s37 | s38 | s39 | s40 | s41 | s42 | s43 | s44 | s45 | s46 | s47 | s48 | s49 | s50 | s51 | s52 | s53 | s54 | s55 | s56 | s57 | s58 | s59 | s60 | s61 | s62 | s63 | s64 | s65 | s66 | s67 | s68 | s69 | s70 | s72;
assign s108 = s0 | s1 | s2 | s3 | s4 | s5 | s6 | s7 | s8 | s9 | s10 | s11 | s12 | s13 | s43 | s44 | s47 | s48 | s53 | s54 | s57 | s58 | s65 | s66 | s69 | s70 | s89 | s91 | s93;
assign s109 = s41 | s42 | s45 | s46 | s51 | s52 | s55 | s56 | s63 | s64 | s67 | s68 | s73 | s74 | s75 | s76 | s77 | s78 | s79 | s80 | s81 | s88 | s90 | s92 | s103 | s104 | s105;
assign s110 = |s71 | s72;
assign instr_sfp = s106;
assign sfp_rs1_ren = s108;
assign sfp_rd1_wen = s109;
assign instr_sfp_ls = s0 | s1 | s2 | s6 | s7 | s8 | s9 | s3 | s4 | s5 | s10 | s11 | s12 | s13;
assign instr_sfp_lhw = s0;
assign instr_sfp_shw = s3;
assign instr_sfp_lw = s1;
assign instr_sfp_sw = s4;
assign instr_sfp_ld = s2;
assign instr_sfp_sd = s5;
assign instr_sfp_c_lwsp = s8;
assign instr_sfp_c_swsp = s12;
assign instr_sfp_c_ldsp = s9;
assign instr_sfp_c_sdsp = s13;
assign instr_sfp_c_lw = s6;
assign instr_sfp_c_sw = s10;
assign instr_sfp_c_ld = s7;
assign instr_sfp_c_sd = s11;
wire s154 = instr_sfp_c_lw | instr_sfp_c_ld;
wire s155 = s10 | s11;
wire s156 = s8 | s9;
wire s157 = s12 | s13;
assign sfp_frs1 = s110 ? sfp_frs2 : (s154 | s155) ? {2'b01,instr[4:2]} : instr[19:15];
assign sfp_frs2 = s157 ? instr[6:2] : s155 ? {2'b01,instr[4:2]} : instr[24:20];
assign sfp_frs3 = instr[31:27];
assign sfp_frd1 = s154 ? {2'b01,instr[4:2]} : instr[11:7];
assign sfp_frs1_ren = (~sfp_rs1_ren & instr_sfp) | vpu_decode[0];
assign sfp_frs2_ren = instr_sfp & ~(s147 | s148 | instr_sfp_lhw | instr_sfp_lw | instr_sfp_ld | instr_sfp_c_lwsp | instr_sfp_c_ldsp | instr_sfp_c_lw | instr_sfp_c_ld);
assign sfp_frs3_ren = s119 | s120 | s121 | s122;
assign sfp_frd1_wen = instr_sfp & ~(sfp_rd1_wen | instr_sfp_shw | instr_sfp_sw | instr_sfp_sd | instr_sfp_c_swsp | instr_sfp_c_sdsp | instr_sfp_c_sw | instr_sfp_c_sd);
assign sfp_ex_rm = s112;
assign sfp_ex_sign = (s153 & ~sfp_frs2[0]) | (s152 & ~sfp_frs2[0]);
assign sfp_ex_sew[2] = (~s147 & (s149[1:0] == 2'b01)) | (s151 & (sfp_frs2[1:0] == 2'b01)) | (s153 & sfp_frs2[1]) | (s152 & (s149[1:0] == 2'b01));
assign sfp_ex_sew[1] = (~s147 & ~(|s149[1:0])) | (s151 & ~(|sfp_frs2[1:0])) | s72 | (s153 & ~sfp_frs2[1]) | (s152 & ~(|s149[1:0]));
assign sfp_ex_sew[0] = (~s147 & (s149[1:0] == 2'b10)) | (s151 & (sfp_frs2[1:0] == 2'b10)) | s71 | (s152 & (s149[1:0] == 2'b10));
assign sfp_ex_fmac = s119 | s120 | s121 | s122 | s123 | s124 | s125;
assign sfp_ex_fdiv = s126 | s127;
assign sfp_ex_fmv = s148 | s128 | s129 | s130;
assign sfp_ex_fmis = ((instr[6:0] == 7'b1010011) & ~instr_sfp_ls & ~sfp_ex_fmac & ~sfp_ex_fdiv & ~sfp_ex_fmv) | s71 | s72;
assign sfp_ex_ctrl = ({6{s123}} & 6'b001100) | ({6{s124}} & 6'b001101) | ({6{s119}} & 6'b001000) | ({6{s121}} & 6'b001010) | ({6{s120}} & 6'b001001) | ({6{s122}} & 6'b001011) | ({6{s125}} & 6'b001110) | ({6{s126}} & 6'b000000) | ({6{s127}} & 6'b000001) | ({6{s128}} & 6'b100000) | ({6{s129}} & 6'b100001) | ({6{s130}} & 6'b100010) | ({6{s131}} & 6'b100100) | ({6{s132}} & 6'b100101) | ({6{s134}} & 6'b101000) | ({6{s133}} & 6'b101001) | ({6{s135}} & 6'b101010) | ({6{s138}} & 6'b101100) | ({6{s136}} & 6'b101101) | ({6{s137}} & 6'b101110) | ({6{s139}} & 6'b110000) | ({6{s140}} & 6'b110001) | ({6{s141}} & 6'b110010) | ({6{s71}} & 6'b110100) | ({6{s72}} & 6'b110101) | ({6{s142}} & 6'b111000) | ({6{s143}} & 6'b111001) | ({6{s144}} & 6'b111010) | ({6{s145}} & 6'b111100) | ({6{s146}} & 6'b111101);
assign s111 = (s107 & (instr[14:12] == 3'b111)) | s72;
assign s112 = s111 ? csr_frm[2:0] : s107 ? instr[14:12] : 3'b000;
assign s113 = instr_csr & ((instr[31:20] == CSR12_FFLAGS) | (instr[31:20] == CSR12_FRM) | (instr[31:20] == CSR12_FCSR));
assign s114 = (s112 == 3'b101) | (s112 == 3'b110) | ({s111,s112} == 4'b1_111);
assign s115 = (csr_mstatus_fs == STATE_OFF);
assign s116 = (s113 & s115) | (instr_sfp & s115);
assign s117 = (instr_sfp & s114);
assign s118 = (s110 & ~s115 & csr_mmisc_ctl_rvcompm);
assign instr_illegal_sfp = s116 | s117 | s118;
assign instr_sfp_off_xcpt = s116;
endmodule


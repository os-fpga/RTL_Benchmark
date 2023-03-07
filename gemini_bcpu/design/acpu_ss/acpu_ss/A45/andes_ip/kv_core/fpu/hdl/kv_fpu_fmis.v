// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fpu_fmis (
    fmis_standby_ready,
    f2_cmp_result,
    f2_narr_wdata,
    f2_wdata,
    f2_wdata_en,
    f2_flag_set,
    f2_result_type,
    f1_op1_data,
    f1_op2_data,
    f1_valid,
    f1_round_mode,
    f1_sew,
    f1_ediv,
    f1_ex_ctrl,
    f1_vmask,
    f1_sign,
    f1_fmis_scalar_valid,
    f1_op1_invalid,
    f1_op2_invalid,
    f1_widen,
    f1_narrow,
    f1_fcvtwh_instr,
    f1_fcvtws_instr,
    f1_fcvtwd_instr,
    f1_fcvtlh_instr,
    f1_fcvtls_instr,
    f1_fcvtld_instr,
    f1_fcvthw_instr,
    f1_fcvthl_instr,
    f1_fcvtsw_instr,
    f1_fcvtsl_instr,
    f1_fcvtdw_instr,
    f1_fcvtdl_instr,
    f1_fcvths_instr,
    f1_fcvthd_instr,
    f1_fcvtsh_instr,
    f1_fcvtsd_instr,
    f1_fcvtdh_instr,
    f1_fcvtds_instr,
    f1_fcvtbs_instr,
    f1_fcvtsb_instr,
    f1_fmin_instr,
    f1_fmax_instr,
    f1_feq_instr,
    f1_fle_instr,
    f1_flt_instr,
    f1_fclass_instr,
    f2_stall,
    core_clk,
    lane_pipe_id_0,
    core_reset_n
);
parameter FLEN = 32;
parameter XLEN = 32;
localparam ROUND_ZERO = 2'b00;
localparam ROUND_NEG = 2'b01;
localparam ROUND_POS = 2'b10;
localparam ROUND_NEAREST = 2'b11;
localparam ROUND_RNE = 3'b000;
localparam ROUND_RTZ = 3'b001;
localparam ROUND_RDN = 3'b010;
localparam ROUND_RUP = 3'b011;
localparam ROUND_RMM = 3'b100;
localparam ROUND_ROD = 3'b101;
localparam HP = 3'b001;
localparam SP = 3'b010;
localparam DP = 3'b011;
localparam SEW_8_BIT = 2'b00;
localparam SEW_16_BIT = 2'b01;
localparam SEW_32_BIT = 2'b10;
localparam SEW_64_BIT = 2'b11;
localparam TYPE_8_BIT = 2'b00;
localparam TYPE_16_BIT = 2'b01;
localparam TYPE_32_BIT = 2'b10;
localparam TYPE_64_BIT = 2'b11;
localparam CVT_BS_MSB = (FLEN == 16) ? 26 : 63;
localparam CVT_BS_RND = 10;
localparam CVT_BS_LSB = (FLEN == 16) ? 10 : 0;
localparam CVT_ABS_MSB = 63;
localparam CVT_ABS_LSB = 0;
localparam CVT_ABS_RND = 10;
localparam CVT_NBS_MSB = (FLEN == 16) ? 63 : (FLEN == 32) ? 76 : 105;
localparam CVT_NBS_LSB = (FLEN == 16) ? 48 : 0;
localparam CVT_NBS_RND = 52;
localparam LZD_MSB = (FLEN == 16) ? 15 : 63;
localparam FRD_TYPE_DP = 3'b111;
localparam FRD_TYPE_SP = 3'b110;
localparam FRD_TYPE_HP = 3'b101;
localparam FRD_TYPE_BP = 3'b100;
localparam FRD_TYPE_LONG = 3'b011;
localparam FRD_TYPE_WORD = 3'b010;
localparam FRD_TYPE_HALF = 3'b001;
localparam FRD_TYPE_BYTE = 3'b000;
localparam ITYPE_F2F = 2'b00;
localparam ITYPE_I2F = 2'b01;
localparam ITYPE_F2I = 2'b10;
localparam ITYPE_NCVT = 2'b11;
output fmis_standby_ready;
output f2_cmp_result;
output [63:0] f2_narr_wdata;
output [63:0] f2_wdata;
output f2_wdata_en;
output [4:0] f2_flag_set;
output [1:0] f2_result_type;
input [63:0] f1_op1_data;
input [63:0] f1_op2_data;
input f1_valid;
input [2:0] f1_round_mode;
input [2:0] f1_sew;
input [1:0] f1_ediv;
input [5:0] f1_ex_ctrl;
input f1_vmask;
input f1_sign;
input f1_fmis_scalar_valid;
input f1_op1_invalid;
input f1_op2_invalid;
input f1_widen;
input f1_narrow;
input core_clk;
input lane_pipe_id_0;
input core_reset_n;
input f2_stall;
input f1_fcvtwh_instr;
input f1_fcvtws_instr;
input f1_fcvtwd_instr;
input f1_fcvtlh_instr;
input f1_fcvtls_instr;
input f1_fcvtld_instr;
input f1_fcvthw_instr;
input f1_fcvthl_instr;
input f1_fcvtsw_instr;
input f1_fcvtsl_instr;
input f1_fcvtdw_instr;
input f1_fcvtdl_instr;
input f1_fcvths_instr;
input f1_fcvthd_instr;
input f1_fcvtsh_instr;
input f1_fcvtsd_instr;
input f1_fcvtdh_instr;
input f1_fcvtds_instr;
input f1_fcvtbs_instr;
input f1_fcvtsb_instr;
input f1_fmin_instr;
input f1_fmax_instr;
input f1_feq_instr;
input f1_fle_instr;
input f1_flt_instr;
input f1_fclass_instr;


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
wire [2:0] f1_round_mode;
wire [5:0] s48;
wire [63:0] s49;
wire [LZD_MSB:0] s50;
wire [12:0] s51;
wire s52;
wire s53;
wire s54;
wire s55;
wire [10:0] s56;
wire [7:0] s57;
wire [4:0] s58;
wire [51:0] s59;
wire [22:0] s60;
wire [9:0] s61;
wire [12:0] s62;
wire [12:0] s63;
wire [12:0] s64;
wire [12:0] s65;
wire [12:0] s66;
wire [12:0] s67;
wire [12:0] s68;
wire s69;
wire s70;
wire s71;
wire s72;
wire s73;
wire [63:0] f1_op1_data;
wire [63:0] f1_op2_data;
wire [63:0] s74;
wire [63:0] s75;
wire [63:0] s76;
wire [63:0] s77;
wire [63:0] s78;
wire [CVT_NBS_MSB:CVT_NBS_LSB] s79;
wire [CVT_NBS_MSB:CVT_NBS_LSB] s80;
wire [CVT_NBS_MSB:CVT_NBS_LSB] s81;
wire [CVT_NBS_MSB:CVT_NBS_LSB] s82;
wire [CVT_NBS_MSB:CVT_NBS_LSB] s83;
wire [CVT_NBS_MSB:CVT_NBS_LSB] s84;
wire [CVT_NBS_MSB:CVT_NBS_LSB] s85;
wire [CVT_ABS_MSB:CVT_ABS_LSB] s86;
wire [CVT_ABS_MSB:CVT_ABS_LSB] s87;
wire [CVT_ABS_MSB:CVT_ABS_LSB] s88;
wire [CVT_ABS_MSB:CVT_ABS_LSB] s89;
wire [CVT_ABS_MSB:CVT_ABS_LSB] s90;
wire [CVT_ABS_MSB:CVT_ABS_LSB] s91;
wire [CVT_ABS_MSB:CVT_ABS_LSB] s92;
wire [CVT_ABS_MSB:CVT_ABS_LSB] s93;
wire [CVT_NBS_MSB:CVT_NBS_RND] s94;
wire [CVT_ABS_MSB:CVT_ABS_LSB] s95;
wire [CVT_BS_MSB:CVT_BS_LSB] s96;
wire [CVT_BS_MSB:CVT_BS_RND] s97;
wire [2:0] s98;
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
wire s112;
wire s113;
wire s114;
wire s115;
wire s116;
wire s117;
wire f2_cmp_result;
wire [1:0] s118;
wire [54:1] s119;
wire [54:0] s120;
wire [12:0] s121;
wire [5:0] s122;
wire [12:0] s123;
wire [12:0] s124;
wire [12:0] s125;
wire [63:0] s126;
wire [63:0] s127;
wire [63:0] s128;
wire [63:0] s129;
wire [63:0] s130;
wire [63:0] s131;
wire [63:0] s132;
wire [63:0] s133;
wire [63:0] s134;
wire [63:0] s135;
wire [63:0] s136;
wire [63:0] s137;
wire [31:0] s138;
wire [15:0] s139;
wire [4:0] s140;
wire [4:0] s141;
wire [4:0] s142;
wire [4:0] s143;
wire [1:0] s144;
wire [2:0] s145;
wire s146;
wire s147;
wire s148;
wire s149;
reg s150;
reg s151;
reg s152;
reg [1:0] s153;
reg [1:0] s154;
reg s155;
reg s156;
reg s157;
reg s158;
reg s159;
reg s160;
reg s161;
reg s162;
reg s163;
wire [12:0] s164;
reg [12:0] s165;
reg [5:0] s166;
reg [CVT_BS_MSB:CVT_BS_LSB] s167;
reg [2:0] s168;
reg [1:0] s169;
reg s170;
reg s171;
reg [2:0] s172;
reg s173;
reg s174;
reg s175;
assign fmis_standby_ready = ~f1_valid & ~s162;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s162 <= 1'b0;
    end
    else if (~f2_stall) begin
        s162 <= f1_valid;
    end
end

always @(posedge core_clk) begin
    if (s108) begin
        s165 <= s121;
        s166 <= s122;
        s154 <= s118;
        s163 <= s100;
        s167 <= s96;
        s168 <= s98;
        s151 <= s104;
        s152 <= s105;
        s171 <= f1_sign;
        s170 <= s146;
        s173 <= s70;
        s150 <= s148;
        s175 <= s149;
    end
end

assign s108 = f1_valid & ~f2_stall;
assign f2_wdata_en = s162;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s159 <= 1'b0;
        s160 <= 1'b0;
        s161 <= 1'b0;
        s174 <= 1'b0;
        s172 <= 3'b0;
        s169 <= 2'b0;
        s158 <= 1'b0;
        s156 <= 1'b0;
        s157 <= 1'b0;
        s155 <= 1'b0;
    end
    else if (s108) begin
        s159 <= s44;
        s160 <= s43;
        s161 <= s45;
        s174 <= s46;
        s172 <= s145;
        s169 <= s144;
        s158 <= s147;
        s156 <= s72;
        s157 <= s73;
        s155 <= s71;
    end
end

wire s176 = (FLEN == 64);
wire s177 = (FLEN == 32) | s176;
wire s178 = f1_sew[2];
wire s179 = f1_sew[1];
wire s180 = f1_sew[0];
wire s181 = 1'b0;
wire s182 = f1_fmis_scalar_valid;
wire s183 = 1'b0;
wire s184 = 1'b0;
wire s185 = 1'b0;
wire s186 = 1'b0;
wire s187 = 1'b0;
assign s5 = 1'b0;
assign s6 = 1'b0;
assign s7 = 1'b0;
assign s8 = 1'b0;
assign s9 = 1'b0;
assign s10 = 1'b0;
assign s11 = 1'b0;
assign s12 = 1'b0;
assign s13 = 1'b0;
assign s14 = 1'b0;
assign s15 = 1'b0;
assign s16 = 1'b0;
assign s17 = 1'b0;
assign s18 = 1'b0;
assign s19 = 1'b0;
assign s20 = 1'b0;
assign s21 = 1'b0;
assign s22 = 1'b0;
assign s23 = 1'b0;
assign s24 = 1'b0;
assign s25 = 1'b0;
assign s26 = 1'b0;
assign s27 = 1'b0;
assign s28 = 1'b0;
assign s29 = 1'b0;
assign s30 = 1'b0;
assign s31 = 1'b0;
assign s32 = 1'b0;
assign s33 = 1'b0;
assign s34 = 1'b0;
wire s188 = ~(f1_widen | f1_narrow);
wire s189 = (f1_fcvtwh_instr | f1_fcvtws_instr | f1_fcvtwd_instr | f1_fcvtlh_instr | f1_fcvtls_instr | f1_fcvtld_instr) & s177;
wire s190 = (f1_fcvthw_instr | f1_fcvthl_instr | f1_fcvtsw_instr | f1_fcvtsl_instr | f1_fcvtdw_instr | f1_fcvtdl_instr) & s177;
wire s191 = (f1_fcvths_instr | f1_fcvthd_instr | f1_fcvtsh_instr | f1_fcvtsd_instr | f1_fcvtdh_instr | f1_fcvtds_instr | f1_fcvtbs_instr | f1_fcvtsb_instr) & s177;
wire s192 = (f1_fcvtsh_instr | f1_fcvtdh_instr | f1_fcvtds_instr) & s177;
wire s193 = (s18 | f1_fcvtsb_instr) & s177;
wire s194 = (s17 | f1_fcvtbs_instr) & s177;
wire s195 = s5 | s7 | s10 | s189 | s14 | s15 | s16;
wire s196 = s6 | s8 | s11 | s190;
wire s197 = (s9 | s12 | s191 | s13 | s193 | s194) & s177;
wire s198 = s19 | s186 | s187;
wire s199 = (s20 | s33 | f1_fmin_instr) & s180;
wire s200 = (s21 | s34 | f1_fmax_instr) & s180;
wire s201 = (s23 | s183) & s180;
wire s202 = (s24 | s184) & s180;
wire s203 = (s25 | s185) & s180;
wire s204 = (s26 | f1_feq_instr) & s180;
wire s205 = (s29 | f1_flt_instr) & s180;
wire s206 = (s28 | f1_fle_instr) & s180;
wire s207 = (s32 | f1_fclass_instr) & s180;
wire s208 = (s27) & s180;
wire s209 = (s30) & s180;
wire s210 = (s31) & s180;
wire s211 = (s22) & s180;
wire s212 = (s20 | s33 | f1_fmin_instr) & s179 & s177;
wire s213 = (s21 | s34 | f1_fmax_instr) & s179 & s177;
wire s214 = (s23 | s183) & s179 & s177;
wire s215 = (s24 | s184) & s179 & s177;
wire s216 = (s25 | s185) & s179 & s177;
wire s217 = (s26 | f1_feq_instr) & s179 & s177;
wire s218 = (s29 | f1_flt_instr) & s179 & s177;
wire s219 = (s28 | f1_fle_instr) & s179 & s177;
wire s220 = (s32 | f1_fclass_instr) & s179 & s177;
wire s221 = (s27) & s179 & s177;
wire s222 = (s30) & s179 & s177;
wire s223 = (s31) & s179 & s177;
wire s224 = (s22) & s179 & s177;
wire s225 = (s20 | s33 | f1_fmin_instr) & s178 & s176;
wire s226 = (s21 | s34 | f1_fmax_instr) & s178 & s176;
wire s227 = (s23 | s183) & s178 & s176;
wire s228 = (s24 | s184) & s178 & s176;
wire s229 = (s25 | s185) & s178 & s176;
wire s230 = (s26 | f1_feq_instr) & s178 & s176;
wire s231 = (s29 | f1_flt_instr) & s178 & s176;
wire s232 = (s28 | f1_fle_instr) & s178 & s176;
wire s233 = (s32 | f1_fclass_instr) & s178 & s176;
wire s234 = (s27) & s178 & s176;
wire s235 = (s30) & s178 & s176;
wire s236 = (s31) & s178 & s176;
wire s237 = (s22) & s178 & s176;
wire s238 = s192 | (s197 & f1_widen);
wire s239 = s221 | s217 | s218 | s219 | s222 | s223 | s213 | s212 | s224 | s208 | s204 | s205 | s206 | s209 | s210 | s200 | s199 | s211 | s234 | s230 | s231 | s232 | s235 | s236 | s226 | s225 | s237;
wire s240 = s214 | s215 | s216 | s201 | s202 | s203 | s227 | s228 | s229;
wire s241 = s220 | s233 | s207;
wire s242 = s239 | s193 | s198 | s241 | s240;
wire s243 = s212 | s213 | s199 | s200 | s225 | s226;
wire s244 = s14 | s15 | s16;
wire s245 = s195 & ((~f1_fmis_scalar_valid & ((s178 & (s188 | f1_narrow)) | (s179 & f1_widen))) | (f1_fcvtlh_instr | f1_fcvtls_instr | f1_fcvtld_instr)) & s177;
wire s246 = s195 & ((~f1_fmis_scalar_valid & ((s179 & (s188 | f1_narrow)) | (s180 & f1_widen))) | (f1_fcvtwh_instr | f1_fcvtws_instr | f1_fcvtwd_instr)) & s177;
wire s247 = s195 & ((~f1_fmis_scalar_valid & ((s180 & (s188 | f1_narrow)) | (s181 & f1_widen))) | (1'b0));
wire s248 = s195 & ((~f1_fmis_scalar_valid & ((s181 & (s188 | f1_narrow)))) | (1'b0));
wire s249 = s194;
wire s250 = ~s195 & ((~s191 & ~s190 & ((s178 & (s188 | f1_narrow)) | (s179 & f1_widen))) | (f1_fcvtdw_instr | f1_fcvtdl_instr | f1_fcvtdh_instr | f1_fcvtds_instr)) & s176;
wire s251 = ~s195 & ((~s191 & ~s190 & ((s179 & (s188 | f1_narrow)) | (s180 & f1_widen))) | (f1_fcvtsw_instr | f1_fcvtsl_instr | f1_fcvtsh_instr | f1_fcvtsd_instr)) & ~s249 & s177;
wire s252 = ~s195 & ((~s191 & ~s190 & ((s180 & (s188 | f1_narrow)) | (s181 & f1_widen))) | (f1_fcvthw_instr | f1_fcvthl_instr | f1_fcvths_instr | f1_fcvthd_instr)) & ~s249;
wire s253 = (((s178 & (s188)) | (s179 & f1_narrow)) & ~f1_fmis_scalar_valid | (f1_fcvtsl_instr | f1_fcvthl_instr | f1_fcvtdl_instr)) & s177;
wire s254 = (((s179 & (s188 | f1_widen)) | (s180 & f1_narrow)) & ~f1_fmis_scalar_valid | (f1_fcvthw_instr | f1_fcvtsw_instr | f1_fcvtdw_instr)) & s177;
wire s255 = ((s180 & (s188 | f1_widen)) | (s181 & f1_narrow));
wire s256 = ((s181 & (s188 | f1_widen)));
wire s257 = s193;
wire s258 = s178 & (s242 | f1_fcvtwd_instr | f1_fcvtld_instr | f1_fcvthd_instr | f1_fcvtsd_instr) & s176 & ~s257;
wire s259 = s179 & (s242 | f1_fcvtws_instr | f1_fcvtls_instr | f1_fcvths_instr | f1_fcvtds_instr | f1_fcvtbs_instr) & s177 & ~s257;
wire s260 = s180 & (s242 | f1_fcvtwh_instr | f1_fcvtlh_instr | f1_fcvtsh_instr | f1_fcvtdh_instr) & ~s257;
assign s0 = lane_pipe_id_0;
wire s261 = (s0 & s182 & (f1_ex_ctrl != 6'b101100) & (f1_ex_ctrl != 6'b110100));
assign s1 = s261 ? ((s260 & (FLEN == 64)) ? &f1_op1_data[63:16] : (s260 & (FLEN == 32)) ? &f1_op1_data[31:16] : 1'b0) : 1'b1;
assign s2 = s261 ? ((s260 & (FLEN == 64)) ? &f1_op2_data[63:16] : (s260 & (FLEN == 32)) ? &f1_op2_data[31:16] : 1'b0) : 1'b1;
assign s3 = s261 ? ((s259 & (FLEN == 64)) ? &f1_op1_data[63:32] : (s259 & (FLEN == 32)) ? 1'b1 : 1'b0) : 1'b1;
assign s4 = s261 ? ((s259 & (FLEN == 64)) ? &f1_op2_data[63:32] : (s259 & (FLEN == 32)) ? 1'b1 : 1'b0) : 1'b1;
wire s262 = (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[9:0] == 10'b0) & (s1);
wire s263 = (f1_op1_data[14:10] == 5'b0) & (f1_op1_data[9:0] != 10'b0) & (s1);
wire s264 = (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[9]) | ~(s1) | f1_op1_invalid;
wire s265 = (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[8:0] != 9'b0) & (s1) & ~f1_op1_data[9] & ~f1_op1_invalid;
wire s266 = (f1_op2_data[14:10] == 5'h1f) & (f1_op2_data[9]) | ~(s2) | f1_op2_invalid;
wire s267 = (f1_op2_data[14:10] == 5'h1f) & (f1_op2_data[8:0] != 9'b0) & (s2) & ~f1_op2_data[9] & ~f1_op2_invalid;
wire s268 = s177 & (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[22:0] == 23'b0) & (s3);
wire s269 = s177 & (f1_op1_data[30:23] == 8'b0) & (f1_op1_data[22:0] != 23'b0) & (s3);
wire s270 = s177 & (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[22]) | ~(s3) | f1_op1_invalid;
wire s271 = s177 & (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[21:0] != 22'b0) & (s3) & ~f1_op1_data[22] & ~f1_op1_invalid;
wire s272 = s177 & (f1_op2_data[30:23] == 8'hff) & (f1_op2_data[22]) | ~(s4) | f1_op2_invalid;
wire s273 = s177 & (f1_op2_data[30:23] == 8'hff) & (f1_op2_data[21:0] != 22'b0) & (s4) & ~f1_op2_data[22] & ~f1_op2_invalid;
wire s274 = s177 & (f1_op1_data[14:7] == 8'hff) & (f1_op1_data[6:0] != 7'b0);
wire s275 = s177 & (f1_op1_data[14:7] == 8'hff) & (f1_op1_data[6] == 1'b0) & (f1_op1_data[5:0] != 6'b0);
wire s276 = s177 & (f1_op1_data[14:7] == 8'hff) & (f1_op1_data[6] == 1'b1);
wire s277 = (f1_op1_data[62:0] == 63'b0) & s176;
wire s278 = (f1_op1_data[30:0] == 31'b0) & s177;
wire s279 = (f1_op1_data[14:0] == 15'b0);
wire s280 = s176 & (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[51:0] == 52'b0);
wire s281 = s176 & (f1_op1_data[62:52] == 11'b0) & (f1_op1_data[51:0] != 52'b0);
wire s282 = s176 & (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[51]) | f1_op1_invalid;
wire s283 = s176 & (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[50:0] != 51'b0) & ~f1_op1_data[51] & ~f1_op1_invalid;
wire s284 = s176 & (f1_op2_data[62:52] == 11'h7ff) & (f1_op2_data[51]) | f1_op2_invalid;
wire s285 = s176 & (f1_op2_data[62:52] == 11'h7ff) & (f1_op2_data[50:0] != 51'b0) & ~f1_op2_data[51] & ~f1_op2_invalid;
wire s286 = (s258 & s281) | (s259 & s269) | ((s260 | s257) & s263);
wire s287 = (s258 & s280) | (s259 & s268) | ((s260 | s257) & s262);
wire s288 = (s258 & s283) | (s259 & s271) | (s260 & s265) | (s257 & s275);
wire s289 = (s258 & s282) | (s259 & s270) | (s260 & s264) | (s257 & s276);
wire s290 = (s258 & s285) | (s259 & s273) | ((s260 | s257) & s267);
wire s291 = (s258 & s284) | (s259 & s272) | ((s260 | s257) & s266);
wire s292 = s289 | s288;
wire s293 = s291 | s290;
wire s294 = s271 | s270;
wire s295 = s273 | s272;
wire s296 = s283 | s282;
wire s297 = s285 | s284;
wire s298 = s265 | s264;
wire s299 = s267 | s266;
wire s300 = ((f1_op1_data == 64'b0) & s178) | ((f1_op1_data[31:0] == 32'b0) & s179);
assign s43 = s195 & s69 | s197 & s69 | s196 & s300;
assign s44 = s197 & s287 | s195 & s287;
assign s45 = s197 & s292 | s195 & s292;
assign s46 = s197 & s288 | s195 & s288 | s99;
wire [31:0] s301;
wire [31:0] s302;
wire [15:0] s303;
wire [15:0] s304;
assign s301 = s3 ? f1_op1_data[31:0] : 32'h7fc00000;
assign s302 = s4 ? f1_op2_data[31:0] : 32'h7fc00000;
assign s303 = s1 ? f1_op1_data[15:0] : 16'h7e00;
assign s304 = s2 ? f1_op2_data[15:0] : 16'h7e00;
assign s76 = s227 ? {f1_op2_data[63],f1_op1_data[62:0]} : s228 ? {~f1_op2_data[63],f1_op1_data[62:0]} : s229 ? {f1_op1_data[63] ^ f1_op2_data[63],f1_op1_data[62:0]} : s214 ? {32'hffffffff,s302[31],s301[30:0]} : s215 ? {32'hffffffff,~s302[31],s301[30:0]} : s216 ? {32'hffffffff,s301[31] ^ s302[31],s301[30:0]} : s201 ? {32'hffffffff,16'hffff,s304[15],s303[14:0]} : s202 ? {32'hffffffff,16'hffff,~s304[15],s303[14:0]} : {32'hffffffff,16'hffff,s303[15] ^ s304[15],s303[14:0]};
wire s305 = (f1_op1_data[15] == f1_op2_data[15]) & (f1_op1_data[14:10] == f1_op2_data[14:10]) & (f1_op1_data[9:0] == f1_op2_data[9:0]) | (f1_op1_data[15] != f1_op2_data[15]) & (f1_op1_data[14:0] == 15'h0) & (f1_op2_data[14:0] == 15'h0);
wire s306 = (f1_op1_data[15] == 1'b1) & (f1_op2_data[15] == 1'b0) & (~((f1_op1_data[14:0] == 15'h0) & (f1_op2_data[14:0] == 15'h0)) | s243) | (f1_op1_data[15] == 1'b1) & (f1_op2_data[15] == 1'b1) & (f1_op1_data[14:10] > f1_op2_data[14:10]) | (f1_op1_data[15] == 1'b0) & (f1_op2_data[15] == 1'b0) & (f1_op1_data[14:10] < f1_op2_data[14:10]) | (f1_op1_data[15] == 1'b1) & (f1_op2_data[15] == 1'b1) & (f1_op1_data[14:10] == f1_op2_data[14:10]) & (f1_op1_data[9:0] > f1_op2_data[9:0]) | (f1_op1_data[15] == 1'b0) & (f1_op2_data[15] == 1'b0) & (f1_op1_data[14:10] == f1_op2_data[14:10]) & (f1_op1_data[9:0] < f1_op2_data[9:0]);
wire s307 = s305 | s306;
wire s308 = ~s305 | s292 | s293;
wire s309 = ~s306;
wire s310 = ~s307;
wire s311 = ((f1_op1_data[31] == f1_op2_data[31]) & (f1_op1_data[30:23] == f1_op2_data[30:23]) & (f1_op1_data[22:0] == f1_op2_data[22:0]) | (f1_op1_data[31] != f1_op2_data[31]) & (f1_op1_data[30:0] == 31'h0) & (f1_op2_data[30:0] == 31'h0)) & s177;
wire s312 = ((f1_op1_data[31] == 1'b1) & (f1_op2_data[31] == 1'b0) & (~((f1_op1_data[30:0] == 31'h0) & (f1_op2_data[30:0] == 31'h0)) | s243) | (f1_op1_data[31] == 1'b1) & (f1_op2_data[31] == 1'b1) & (f1_op1_data[30:23] > f1_op2_data[30:23]) | (f1_op1_data[31] == 1'b0) & (f1_op2_data[31] == 1'b0) & (f1_op1_data[30:23] < f1_op2_data[30:23]) | (f1_op1_data[31] == 1'b1) & (f1_op2_data[31] == 1'b1) & (f1_op1_data[30:23] == f1_op2_data[30:23]) & (f1_op1_data[22:0] > f1_op2_data[22:0]) | (f1_op1_data[31] == 1'b0) & (f1_op2_data[31] == 1'b0) & (f1_op1_data[30:23] == f1_op2_data[30:23]) & (f1_op1_data[22:0] < f1_op2_data[22:0])) & s177;
wire s313 = s311 | s312;
wire s314 = ~s311 | s292 | s293;
wire s315 = ~s312;
wire s316 = ~s313;
wire s317 = ((f1_op1_data[63] == f1_op2_data[63]) & (f1_op1_data[62:52] == f1_op2_data[62:52]) & (f1_op1_data[51:0] == f1_op2_data[51:0]) | (f1_op1_data[63] != f1_op2_data[63]) & (f1_op1_data[62:0] == 63'h0) & (f1_op2_data[62:0] == 63'h0)) & s176;
wire s318 = ((f1_op1_data[63] == 1'b1) & (f1_op2_data[63] == 1'b0) & (~((f1_op1_data[62:0] == 63'h0) & (f1_op2_data[62:0] == 63'h0)) | s243) | (f1_op1_data[63] == 1'b1) & (f1_op2_data[63] == 1'b1) & (f1_op1_data[62:52] > f1_op2_data[62:52]) | (f1_op1_data[63] == 1'b0) & (f1_op2_data[63] == 1'b0) & (f1_op1_data[62:52] < f1_op2_data[62:52]) | (f1_op1_data[63] == 1'b1) & (f1_op2_data[63] == 1'b1) & (f1_op1_data[62:52] == f1_op2_data[62:52]) & (f1_op1_data[51:0] > f1_op2_data[51:0]) | (f1_op1_data[63] == 1'b0) & (f1_op2_data[63] == 1'b0) & (f1_op1_data[62:52] == f1_op2_data[62:52]) & (f1_op1_data[51:0] < f1_op2_data[51:0])) & s176;
wire s319 = s317 | s318;
wire s320 = ~s317 | s292 | s293;
wire s321 = ~s318;
wire s322 = ~s319;
wire s323 = (s292 | s293) & ~s27 | (s251 & (~s3 | ~s4));
wire s324 = s243 & s292 & s293;
assign s77 = s324 ? s250 ? {64'h7ff8000000000000} : s251 ? {32'hffffffff,32'h7fc00000} : {32'hffffffff,32'hffff7e00} : s225 ? s292 ? f1_op2_data : s293 ? f1_op1_data : s318 ? f1_op1_data : f1_op2_data : s226 ? s292 ? f1_op2_data : s293 ? f1_op1_data : s318 ? f1_op2_data : f1_op1_data : s237 ? f1_vmask ? f1_op2_data[63:0] : f1_op1_data[63:0] : s211 ? f1_vmask ? {32'hffffffff,16'hffff,f1_op2_data[15:0]} : {32'hffffffff,16'hffff,f1_op1_data[15:0]} : s224 ? f1_vmask ? {32'hffffffff,f1_op2_data[31:0]} : {32'hffffffff,f1_op1_data[31:0]} : s199 ? s292 ? {32'hffffffff,16'hffff,f1_op2_data[15:0]} : s293 ? {32'hffffffff,16'hffff,f1_op1_data[15:0]} : s306 ? {32'hffffffff,16'hffff,f1_op1_data[15:0]} : {32'hffffffff,16'hffff,f1_op2_data[15:0]} : s200 ? s292 ? {32'hffffffff,16'hffff,f1_op2_data[15:0]} : s293 ? {32'hffffffff,16'hffff,f1_op1_data[15:0]} : s306 ? {32'hffffffff,16'hffff,f1_op2_data[15:0]} : {32'hffffffff,16'hffff,f1_op1_data[15:0]} : s212 ? s292 ? {32'hffffffff,f1_op2_data[31:0]} : s293 ? {32'hffffffff,f1_op1_data[31:0]} : s312 ? {32'hffffffff,f1_op1_data[31:0]} : {32'hffffffff,f1_op2_data[31:0]} : s213 ? s292 ? {32'hffffffff,f1_op2_data[31:0]} : s293 ? {32'hffffffff,f1_op1_data[31:0]} : s312 ? {32'hffffffff,f1_op2_data[31:0]} : {32'hffffffff,f1_op1_data[31:0]} : s323 ? {64'b0} : s235 ? {63'b0,s321} : s236 ? {63'b0,s322} : s230 ? {63'b0,s317} : s234 ? {63'b0,s320} : s231 ? {63'b0,s318} : s232 ? {63'b0,s319} : s222 ? {63'b0,s315} : s223 ? {63'b0,s316} : s217 ? {63'b0,s311} : s221 ? {63'b0,s314} : s218 ? {63'b0,s312} : s219 ? {63'b0,s313} : s209 ? {63'b0,s309} : s210 ? {63'b0,s310} : s204 ? {63'b0,s305} : s208 ? {63'b0,s308} : s205 ? {63'b0,s306} : {63'b0,s307};
wire s325 = (f1_op1_data[15] == 1'b1) & (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[9:0] == 10'b0);
wire s326 = (f1_op1_data[15] == 1'b0) & (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[9:0] == 10'b0);
wire s327 = (f1_op1_data[15] == 1'b1) & (f1_op1_data[14:10] == 5'b0) & (f1_op1_data[9:0] != 10'b0);
wire s328 = (f1_op1_data[15] == 1'b0) & (f1_op1_data[14:10] == 5'b0) & (f1_op1_data[9:0] != 10'b0);
wire s329 = (f1_op1_data[15] == 1'b1) & (f1_op1_data[14:10] == 5'b0) & (f1_op1_data[9:0] == 10'b0);
wire s330 = (f1_op1_data[15] == 1'b0) & (f1_op1_data[14:10] == 5'b0) & (f1_op1_data[9:0] == 10'b0);
wire s331 = (f1_op1_data[15] == 1'b1) & (f1_op1_data[14:10] != 5'h1f) & (f1_op1_data[14:10] != 5'b0);
wire s332 = (f1_op1_data[15] == 1'b0) & (f1_op1_data[14:10] != 5'h1f) & (f1_op1_data[14:10] != 5'b0);
wire s333 = (f1_op1_data[31] == 1'b1) & (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[22:0] == 23'b0) & s177;
wire s334 = (f1_op1_data[31] == 1'b0) & (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[22:0] == 23'b0) & s177;
wire s335 = (f1_op1_data[31] == 1'b1) & (f1_op1_data[30:23] == 8'b0) & (f1_op1_data[22:0] != 23'b0) & s177;
wire s336 = (f1_op1_data[31] == 1'b0) & (f1_op1_data[30:23] == 8'b0) & (f1_op1_data[22:0] != 23'b0) & s177;
wire s337 = (f1_op1_data[31] == 1'b1) & (f1_op1_data[30:23] == 8'b0) & (f1_op1_data[22:0] == 23'b0) & s177;
wire s338 = (f1_op1_data[31] == 1'b0) & (f1_op1_data[30:23] == 8'b0) & (f1_op1_data[22:0] == 23'b0) & s177;
wire s339 = (f1_op1_data[31] == 1'b1) & (f1_op1_data[30:23] != 8'hff) & (f1_op1_data[30:23] != 8'b0) & s177;
wire s340 = (f1_op1_data[31] == 1'b0) & (f1_op1_data[30:23] != 8'hff) & (f1_op1_data[30:23] != 8'b0) & s177;
wire s341 = (f1_op1_data[63] == 1'b1) & (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[51:0] == 52'b0) & s176;
wire s342 = (f1_op1_data[63] == 1'b0) & (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[51:0] == 52'b0) & s176;
wire s343 = (f1_op1_data[63] == 1'b1) & (f1_op1_data[62:52] == 11'b0) & (f1_op1_data[51:0] != 52'b0) & s176;
wire s344 = (f1_op1_data[63] == 1'b0) & (f1_op1_data[62:52] == 11'b0) & (f1_op1_data[51:0] != 52'b0) & s176;
wire s345 = (f1_op1_data[63] == 1'b1) & (f1_op1_data[62:52] == 11'b0) & (f1_op1_data[51:0] == 52'b0) & s176;
wire s346 = (f1_op1_data[63] == 1'b0) & (f1_op1_data[62:52] == 11'b0) & (f1_op1_data[51:0] == 52'b0) & s176;
wire s347 = (f1_op1_data[63] == 1'b1) & (f1_op1_data[62:52] != 11'h7ff) & (f1_op1_data[62:52] != 11'h0) & s176;
wire s348 = (f1_op1_data[63] == 1'b0) & (f1_op1_data[62:52] != 11'h7ff) & (f1_op1_data[62:52] != 11'b0) & s176;
assign s78 = s250 ? (s282 ? 64'h200 : s283 ? 64'h100 : s342 ? 64'h80 : s348 ? 64'h40 : s344 ? 64'h20 : s346 ? 64'h10 : s345 ? 64'h8 : s343 ? 64'h4 : s347 ? 64'h2 : 64'h1) : s251 ? (s270 ? 64'h200 : s271 ? 64'h100 : s334 ? 64'h80 : s340 ? 64'h40 : s336 ? 64'h20 : s338 ? 64'h10 : s337 ? 64'h8 : s335 ? 64'h4 : s339 ? 64'h2 : 64'h1) : (s264 ? 64'h200 : s265 ? 64'h100 : s326 ? 64'h80 : s332 ? 64'h40 : s328 ? 64'h20 : s330 ? 64'h10 : s329 ? 64'h8 : s327 ? 64'h4 : s331 ? 64'h2 : 64'h1);
assign s99 = s239 & (s218 | s219 | s222 | s223) & (s294 | s295 | ~s3 | ~s4) | s239 & (s205 | s206 | s209 | s210) & (s298 | s299 | ~s1 | ~s2) | s239 & (s231 | s232 | s235 | s236) & (s296 | s297) | s239 & (s217 | s221 | s212 | s213) & ((s271 & s3) | (s273 & s4)) | s239 & (s204 | s208 | s199 | s200) & ((s265 & s1) | (s267 & s2)) | s239 & (s230 | s234 | s225 | s226) & (s283 | s285) | s193 & s275;
assign s75 = {32'hffffffff,(s274 ? 16'h7fc0 : f1_op1_data[15:0]),16'b0} & {64{s177}};
assign s74 = {64{s240}} & s76 | {64{s239}} & s77 | {64{s241}} & s78 | {64{s193}} & s75;
wire s349 = ~(f1_op1_data[62:52] == 11'b0) & s176;
wire s350 = ~(f1_op1_data[30:23] == 8'b0) & s177;
wire s351 = ~(f1_op1_data[14:10] == 5'b0);
assign s53 = {1{s176}} & f1_op1_data[63];
assign s56 = {11{s176}} & f1_op1_data[62:52];
assign s59 = {52{s176}} & f1_op1_data[51:0];
assign s54 = {1{s177}} & f1_op1_data[31];
assign s57 = {8{s177}} & f1_op1_data[30:23];
assign s60 = {23{s177}} & f1_op1_data[22:0];
assign s55 = f1_op1_data[15];
assign s58 = f1_op1_data[14:10];
assign s61 = f1_op1_data[9:0];
wire s352 = (s178 & f1_op1_data[63]) | (s179 & f1_op1_data[31]) | (s180 & f1_op1_data[15]) | (s181 & f1_op1_data[7]);
wire s353 = f1_sign & s352;
assign s82 = s48[3] ? {s81[CVT_NBS_MSB - 8:CVT_NBS_LSB],8'b0} : s81;
assign s83 = s48[2] ? {s82[CVT_NBS_MSB - 4:CVT_NBS_LSB],4'b0} : s82;
assign s84 = s48[1] ? {s83[CVT_NBS_MSB - 2:CVT_NBS_LSB],2'b0} : s83;
assign s85 = s48[0] ? {s84[CVT_NBS_MSB - 1:CVT_NBS_LSB],1'b0} : s84;
assign s35 = (s258 & s53) | (s259 & s54) | ((s260 | s257) & s55);
assign s69 = (s258 & s277) | (s259 & s278) | ((s260 | s257) & s279);
wire s354 = s197 & s259 & s252;
wire s355 = s197 & s258 & s252;
wire s356 = s197 & s258 & s251;
assign s63 = ({13{s258}} & {2'd0,s56}) | ({13{s259}} & {5'd0,s57}) | ({13{s260 | s257}} & {8'd0,s58});
assign s64 = ({13{s258}} & 13'b1110000000001) | ({13{s259}} & 13'b1111110000001) | ({13{s260 | s257}} & 13'b1111111110001);
assign s62 = (s63 + s64 + {12'b0,(s286 & ~s194)}) & {13{~s43}};
assign s73 = (s57 < 8'd113) & s354 & s177;
assign s72 = (s56 < 11'd1009) & s355 & s176;
assign s71 = (s56 < 11'd897) & s356 & s176;
assign s67 = (s73 | s72) ? ~s62 + 13'd29 : 13'd42;
assign s68 = s71 ? ~s62 - 13'd96 : 13'd29;
assign s66 = {13{s356}} & s68 | {13{(s354 | s355)}} & s67;
assign s51 = {13{s194}} & 13'd45 | {13{s197}} & s66 | {13{s195}} & s65;
assign s149 = s35 & s195 & f1_sign;
assign s86 = ({64{s258}} & {s349,s59,11'b0}) | ({64{s259}} & {s350,s60,40'b0}) | ({64{s260 | s257}} & {s351,s61,53'b0});
assign s87 = s51[5] ? {32'b0,s86[CVT_ABS_MSB:CVT_ABS_LSB + 32]} : s86;
assign s88 = s51[4] ? {16'b0,s87[CVT_ABS_MSB:CVT_ABS_LSB + 16]} : s87;
assign s89 = s51[3] ? {8'b0,s88[CVT_ABS_MSB:CVT_ABS_LSB + 8]} : s88;
assign s90 = s51[2] ? {4'b0,s89[CVT_ABS_MSB:CVT_ABS_LSB + 4]} : s89;
assign s91 = s51[1] ? {2'b0,s90[CVT_ABS_MSB:CVT_ABS_LSB + 2]} : s90;
assign s92 = s51[0] ? {1'b0,s91[CVT_ABS_MSB:CVT_ABS_LSB + 1]} : s91;
assign s37 = (s51[5] & (|s86[CVT_ABS_LSB + 31:CVT_ABS_LSB]));
assign s38 = (s51[4] & (|s87[CVT_ABS_LSB + 15:CVT_ABS_LSB])) | s37;
assign s39 = (s51[3] & (|s88[CVT_ABS_LSB + 7:CVT_ABS_LSB])) | s38;
assign s40 = (s51[2] & (|s89[CVT_ABS_LSB + 3:CVT_ABS_LSB])) | s39;
assign s41 = (s51[1] & (|s90[CVT_ABS_LSB + 1:CVT_ABS_LSB])) | s40;
assign s42 = (s51[0] & (s91[CVT_ABS_LSB])) | s41;
assign s36 = s52 | (|s92[CVT_ABS_RND - 1:CVT_ABS_LSB]) | s42;
assign s52 = |s51[12:6];
assign s93 = s52 ? {(CVT_ABS_MSB - CVT_ABS_LSB + 1){1'b0}} : s92;
assign s121 = ((s197 | s195) ? s62 : s253 ? 13'd63 : s254 ? 13'd31 : s255 ? 13'd15 : 13'd7);
assign s122 = ((s194 | s195) ? 6'b0 : s48);
assign s94 = s85[CVT_NBS_MSB:CVT_NBS_RND];
assign s95 = s93[CVT_ABS_MSB:CVT_ABS_LSB];
assign s101 = s36 & ~s238;
assign s102 = s47;
assign s146 = s196 ? s353 : s35;
assign s147 = s269 & s194;
assign s103 = f1_vmask | s22;
assign s98 = s13 ? ROUND_ROD : s244 ? ROUND_RTZ : f1_round_mode;
assign s144 = s242 ? ITYPE_NCVT : s196 ? ITYPE_I2F : s195 ? ITYPE_F2I : ITYPE_F2F;
assign s145 = s245 ? FRD_TYPE_LONG : s246 ? FRD_TYPE_WORD : s247 ? FRD_TYPE_HALF : s248 ? FRD_TYPE_BYTE : s250 ? FRD_TYPE_DP : s251 ? FRD_TYPE_SP : s249 ? FRD_TYPE_BP : FRD_TYPE_HP;
always @* begin
    case (s98)
        ROUND_RUP: s153 = ROUND_POS;
        ROUND_RDN: s153 = ROUND_NEG;
        ROUND_RTZ: s153 = ROUND_ZERO;
        ROUND_ROD: s153 = ROUND_ZERO;
        default: s153 = ROUND_NEAREST;
    endcase
end

assign s104 = s153[0] & s153[1];
assign s105 = (~s146 & ~s153[0] & s153[1]) | (s146 & s153[0] & ~s153[1]);
assign s100 = s196 ? s102 : s101;
assign s118 = {(s100 & s105),(s104 | s105)};
wire s357 = (s172 == FRD_TYPE_LONG) & s177;
wire s358 = (s172 == FRD_TYPE_WORD) & s177;
wire s359 = (s172 == FRD_TYPE_HALF);
wire s360 = (s172 == FRD_TYPE_BYTE);
wire s361 = (s172 == FRD_TYPE_DP) & s176;
wire s362 = (s172 == FRD_TYPE_SP) & s177;
wire s363 = (s172 == FRD_TYPE_BP);
wire s364 = (s172 == FRD_TYPE_HP);
wire s365 = s169 == ITYPE_NCVT;
wire s366 = s169 == ITYPE_I2F;
wire s367 = s169 == ITYPE_F2I;
wire s368 = s169 == ITYPE_F2F;
assign s164 = s165 - {7'b0,s166};
assign s97 = s167[CVT_BS_MSB:CVT_BS_RND];
assign s113 = s167[CVT_BS_RND];
assign s109 = s113 & ~s163;
assign s112 = s113 | s163;
assign s110 = s109 & (s168 == ROUND_RNE);
assign s111 = s112 & (s168 == ROUND_ROD);
assign s114 = s110 ? 1'b0 : s111 ? 1'b1 : s120[1];
assign s119 = {s120[54:2],s114};
assign s117 = s361 & s120[54] | s362 & (s120[25] | (s155 & s120[24])) | s364 & (s120[12] | ((s157 | s156) & s120[11])) | s363 & (s120[9] | (s158 & s120[8]));
assign s123 = (s361 ? 13'd1023 : (s362 | s363) ? 13'd127 : 13'd15) + s164;
assign s124 = (s361 ? 13'd1024 : (s362 | s363) ? 13'd128 : 13'd16) + s164;
assign s125 = s117 ? s124 : s123;
assign s131 = {64{s361}} & {s170,s125[10:0],s119[52:1]} | {64{s362}} & {32'hffffffff,s170,s125[7:0] & {8{~s115}},s119[23:1]} | {64{s363}} & {48'hffffffffffff,s170,s125[7:0] & {8{~s115}},s119[7:1]} | {64{s364}} & {48'hffffffffffff,s170,s125[4:0] & {5{~s115}},s119[10:1]};
assign s126 = s357 ? s136 : {{32{s138[31]}},s138};
wire s369 = ~(|s119[54:1]);
wire s370 = ~s164[12] & (s164[11:0] > 12'd127) & s177;
wire s371 = ~s164[12] | (~s164[11:0] < 12'd126) & s177;
wire s372 = ~s164[12] | (~s164[11:0] < 12'd150) & s177;
wire s373 = ~s164[12] & (s164[11:0] > 12'd15);
wire s374 = ~s164[12] | (~s164[11:0] < 12'd14);
wire s375 = ~s164[12] | (~s164[11:0] < 12'd25);
wire s376 = ~s164[12] & (s164[11:0] > 12'd126) & s177;
wire s377 = ~s164[12] | (~s164[11:0] < 12'd127) & s177;
wire s378 = ~s164[12] | (~s164[11:0] < 12'd151) & s177;
wire s379 = ~s164[12] & (s164[11:0] > 12'd14);
wire s380 = ~s164[12] | (~s164[11:0] < 12'd15);
wire s381 = ~s164[12] | (~s164[11:0] < 12'd26);
wire s382 = s117 ? s376 : s370;
wire s383 = s117 ? s377 : s371;
wire s384 = s117 ? s378 : s372;
wire s385 = s117 ? s379 : s373;
wire s386 = s117 ? s380 : s374;
wire s387 = s117 ? s381 : s375;
wire s388 = (s157 & s120[11] & s116) & s177 | (s156 & s120[11] & s116) & s176;
wire s389 = (s155 & s120[24] & s116) & s176;
wire s390 = s385;
wire s391 = ~s386 & (s387 | (s168 == ROUND_RUP));
wire s392 = s388 | ~s387 | (s391 & (s113 | s163));
wire s393 = s177 & s382;
wire s394 = s393;
wire s395 = s177 & ~s383 & (s384 | (s168 == ROUND_RUP));
wire s396 = s395;
wire s397 = s177 & (~s384 | (s395 & (s113 | s163)) | s389);
wire s398 = s397;
assign s115 = s364 & s391 | s362 & s395 | s363 & s396;
wire s399 = s159 | s161 | s160;
wire s400 = (s362 & s393 | s363 & s394 | s364 & s390) & ~s399;
wire s401 = ((s362 & s397 | s363 & s398 | s364 & s392) & ~(s399 | (s369 & ~s113 & ~s163)));
wire s402 = ~s161 & ~s159 & (s160 | s369 | (s401 & ~s115 & ~s388 & ~s389 & ((s168 == ROUND_RNE) | (s168 == ROUND_RMM) | (s168 == ROUND_RTZ) | ((s168 == ROUND_RUP) & s170) | ((s168 == ROUND_RDN) & ~s170))));
wire s403 = s401 & ~s388 & ~s389 & (((s168 == ROUND_ROD)) | ((s168 == ROUND_RUP) & ~s170) | ((s168 == ROUND_RDN) & s170));
wire s404 = ~s161 & (s159 | (s400 & (((s168 == ROUND_RNE)) | ((s168 == ROUND_RMM)) | ((s168 == ROUND_RDN) & s170) | ((s168 == ROUND_RUP) & ~s170))));
wire s405 = s400 & (((s168 == ROUND_RTZ)) | ((s168 == ROUND_ROD)) | ((s168 == ROUND_RUP) & s170) | ((s168 == ROUND_RDN) & ~s170));
wire s406 = s404 | s402 | s161 | s405 | (s403 & ~s115);
wire s407 = s363 & s161;
wire s408 = s364 & s161;
wire s409 = s362 & s161;
wire s410 = s361 & s161;
wire s411 = s363 & s404;
wire s412 = s364 & s404;
wire s413 = s362 & s404;
wire s414 = s361 & s404;
wire s415 = s363 & s402;
wire s416 = s364 & s402;
wire s417 = s362 & s402;
wire s418 = s361 & s402;
wire s419 = s364 & s405;
wire s420 = s362 & s405;
wire s421 = s361 & s405;
wire s422 = s364 & s403;
wire s423 = s362 & s403;
wire s424 = s361 & s403;
wire s425 = (s369 & ~s113 & ~s163 & ~s160) ? (s168 == ROUND_RDN) : s170;
assign s135 = ({64{s408}} & {48'hffffffffffff,1'b0,5'h1f,10'h200}) | ({64{s407}} & {48'hffffffffffff,1'b0,8'hff,7'h40}) | ({64{s409}} & {32'hffffffff,1'b0,8'hff,23'h400000}) | ({64{s410}} & {1'b0,11'h7ff,52'h8000000000000}) | ({64{s412}} & {48'hffffffffffff,s170,5'h1f,10'h0}) | ({64{s411}} & {48'hffffffffffff,s170,8'hff,7'h0}) | ({64{s413}} & {32'hffffffff,s170,8'hff,23'h0}) | ({64{s414}} & {s170,11'h7ff,52'h0}) | ({64{s416}} & {48'hffffffffffff,s425,5'h00,10'h0}) | ({64{s415}} & {48'hffffffffffff,s425,8'h00,7'h0}) | ({64{s417}} & {32'hffffffff,s425,8'h00,23'h0}) | ({64{s418}} & {s425,11'h000,52'h0}) | ({64{s419}} & {48'hffffffffffff,s170,5'h1e,10'h3ff}) | ({64{s420}} & {32'hffffffff,s170,8'hfe,23'h7fffff}) | ({64{s421}} & {s170,11'h7fe,52'hfffffffffffff}) | ({64{s422}} & {48'hffffffffffff,s170,5'h00,10'h1}) | ({64{s423}} & {32'hffffffff,s170,8'h00,23'h1}) | ({64{s424}} & {s170,11'h000,52'h1});
wire s426 = ~s171 & s170 & ~s161 & (~s369 | (~s165[11] & (|s165[10:6])));
wire s427 = s171 & s170 & ~s161 & ~s165[11] & (|s165[10:6]) | s171 & s170 & ~s161 & ~s165[11] & ~s136[63] & ~s369 | (s171 & s170 & s159);
wire s428 = ~s171 & ((~s170 & ((~s165[11] & (|s165[10:6])) | s159)) | s161);
wire s429 = s171 & ~s170 & ~s165[11] & (|s165[10:6]) | s171 & ~s170 & ~s165[11] & s136[63] | s171 & ((~s170 & s159) | s161);
wire s430 = ~s171 & s170 & ~s161 & (~s369 | (~s165[11] & (|s165[10:5])));
wire s431 = s171 & ~s170 & ~s165[11] & (|s165[10:5]) | s171 & ~s170 & ~s165[11] & (s138[31] | s120[33]) | s171 & ((~s170 & s159) | s161);
wire s432 = ~s171 & ((~s170 & ((~s165[11] & (|s165[10:5])) | s159)) | s161) | ~s171 & ~s170 & ~s165[11] & s120[33];
wire s433 = s171 & s170 & ~s161 & ~s165[11] & (|s165[10:5]) | s171 & s170 & ~s161 & ~s165[11] & ~s138[31] & ~s369 | s171 & s170 & s159;
wire s434 = ~s171 & s170 & ~s161 & (~s369 | (~s165[11] & (|s165[10:4])));
wire s435 = s171 & ~s170 & ~s165[11] & (|s165[10:4]) | s171 & ~s170 & ~s165[11] & (s138[15] | s120[17]) | s171 & ((~s170 & s159) | s161);
wire s436 = ~s171 & ((~s170 & ((~s165[11] & (|s165[10:4])) | s159)) | s161) | ~s171 & ~s170 & ~s165[11] & s120[17];
wire s437 = s171 & s170 & ~s161 & ~s165[11] & (|s165[10:4]) | s171 & s170 & ~s161 & ~s165[11] & ~s138[15] & ~s369 | s171 & s170 & s159;
wire s438 = ~s171 & s170 & ~s161 & (~s369 | (~s165[11] & (s165 > 13'd7)));
wire s439 = s171 & ~s170 & ~s165[11] & (|s165[10:3]) | s171 & ~s170 & ~s165[11] & (s138[7] | s120[9]) | s171 & ((~s170 & s159) | s161);
wire s440 = ~s171 & ((~s170 & ((~s165[11] & (|s165[10:3])) | s159)) | s161) | ~s171 & ~s170 & ~s165[11] & s120[9];
wire s441 = s171 & s170 & ~s161 & ~s165[11] & (|s165[10:3]) | s171 & s170 & ~s161 & ~s165[11] & ~s138[7] & ~s369 | s171 & s170 & s159;
wire s442 = (s360 & s438) | (s359 & s434) | (s358 & s430) | (s357 & s426);
wire s443 = s358 & s432 | s359 & s436 | s360 & s440 | s357 & s428;
wire s444 = (s360 & s438) | (s359 & s434) | (s358 & s430);
wire s445 = s359 & s436 | s360 & s440 | s358 & s432;
wire s446 = s358 & s431;
wire s447 = s358 & s433;
wire s448 = s359 & s435;
wire s449 = s359 & s437;
wire s450 = s360 & s439;
wire s451 = s360 & s441;
wire s452 = s357 & s429;
wire s453 = s357 & s427;
assign s133 = ({64{s442}} & 64'h0000_0000_0000_0000) | ({64{s443}} & 64'hffff_ffff_ffff_ffff) | ({64{s448}} & 64'h0000_0000_0000_7fff) | ({64{s449}} & 64'hffff_ffff_ffff_8000) | ({64{s450}} & 64'h0000_0000_0000_007f) | ({64{s451}} & 64'hffff_ffff_ffff_ff80) | ({64{s446}} & 64'h0000_0000_7fff_ffff) | ({64{s447}} & 64'hffff_ffff_8000_0000) | ({64{s452}} & 64'h7fff_ffff_ffff_ffff) | ({64{s453}} & 64'h8000_0000_0000_0000);
assign s134 = ({64{s444}} & 64'h0000_0000_0000_0000) | ({64{s445}} & 64'hffff_ffff_ffff_ffff) | ({64{s448}} & 64'h0000_0000_0000_7fff) | ({64{s449}} & 64'hffff_ffff_ffff_8000) | ({64{s450}} & 64'h0000_0000_0000_007f) | ({64{s451}} & 64'hffff_ffff_ffff_ff80) | ({64{s446}} & 64'h0000_0000_7fff_ffff) | ({64{s447}} & 64'hffff_ffff_8000_0000);
assign s106 = (s357 & (s426 | s428 | s429 | s427)) | (s358 & (s430 | s432 | s431 | s433)) | (s359 & (s434 | s436 | s435 | s437)) | (s360 & (s438 | s440 | s439 | s441));
assign s129 = s106 ? s133 : s126;
assign s132 = s406 ? s135 : s131;
assign f2_cmp_result = s128[0];
assign f2_wdata = {64{s365}} & s128 | {64{s367}} & s129 | {64{s366}} & s132 | {64{s368}} & s132;
assign s130 = s107 ? s134 : s127;
assign f2_narr_wdata = {64{s367}} & s130 | {64{s366 | s368}} & s132;
assign f2_result_type = s363 ? TYPE_16_BIT : s172[1:0];
wire s454 = ~(s368 & (s161 | s160)) & (((s113 | s163) & ~s159) | s400 | s401);
wire s455 = s454 & ~s106 & s173 & ~s150;
wire s456 = s106 | s174;
assign s141 = {1'b0,1'b0,s400,s401,s454};
assign s140 = {s174,1'b0,s400,s401,s454};
assign s142 = {s456,1'b0,1'b0,1'b0,s455};
assign s143 = {s174,4'b0};
assign f2_flag_set = {5{f2_wdata_en}} & ({5{s365}} & s143 | {5{s366}} & s141 | {5{s368}} & s140 | {5{s367}} & s142);
generate
    if ((FLEN == 32) | (FLEN == 64)) begin:gen_sp_dp_result
        wire s457;
        wire s458;
        wire [62:0] s459;
        wire [63:0] s460;
        wire [1:0] s461;
        wire [54:0] s462;
        wire [63:0] s463;
        assign s459 = ~f1_op1_data[62:0] + 63'b1;
        assign s460 = {&(~f1_op1_data[62:0]),s459[62:1],f1_op1_data[0]};
        assign s49 = {64{s353}} & s460 | {64{~s353}} & f1_op1_data;
        assign s457 = ((s179 & f1_narrow & ~f1_fmis_scalar_valid) | (f1_fcvtsd_instr | f1_fcvthd_instr)) & s176;
        assign s458 = ((((s179 & f1_widen) | (s180 & f1_narrow)) & ~f1_fmis_scalar_valid) | (f1_fcvths_instr | f1_fcvtds_instr | f1_fcvtbs_instr));
        assign s463 = {64{~s197 & s253}} & {f1_op1_data[63:0]} | {64{~s197 & s254}} & {f1_op1_data[31:0],32'b0} | {64{~s197 & s255}} & {f1_op1_data[15:0],48'b0} | {64{s197 & s457}} & {s349,s59,11'b0} | {64{s197 & s458}} & {s350,s60,29'b0,11'b0} | {64{s197 & s260}} & {s351,s61,42'b0,11'b0};
        assign s50 = {64{s197 | ~s353}} & s463 | {64{~s197 & s253 & s353}} & {s460[63:0]} | {64{~s197 & s254 & s353}} & {s460[31:0],32'b0} | {64{~s197 & s255 & s353}} & {s460[15:0],48'b0};
        assign s80 = s48[5] ? {s79[CVT_NBS_MSB - 32:CVT_NBS_LSB],32'b0} : s79;
        assign s81 = s48[4] ? {s80[CVT_NBS_MSB - 16:CVT_NBS_LSB],16'b0} : s80;
        assign s128 = {s167[CVT_BS_MSB:CVT_BS_LSB]};
        wire s464 = s167[CVT_BS_RND + 1];
        wire s465 = (~s113 & (s154 != 2'b11)) | (s113 & (s154 == 2'b00)) | (s113 & (s110 & ~s464));
        assign s461 = {1'b0,s154[1]} + {1'b0,s154[0]};
        assign s462 = s175 ? {53'b0,s465,1'b0} : {53'b0,s461};
        assign s120 = ({55{s175}} ^ {1'b0,s97}) + s462;
        assign s138 = s119[32:1];
        assign s139 = s119[16:1];
        wire s466 = s167[9];
        wire s467 = s364 & (s97[CVT_BS_RND + 10:CVT_BS_RND] == 11'h7ff) | s362 & (s97[CVT_BS_RND + 23:CVT_BS_RND] == 24'hffffff);
        wire s468 = s364 & (s97[CVT_BS_RND + 10:CVT_BS_RND] == 11'h7fe) | s362 & (s97[CVT_BS_RND + 23:CVT_BS_RND] == 24'hfffffe);
        wire s469 = s467 & ~(s461[1] | (s461[0] & s466));
        wire s470 = s468 & (s163 | s466) & (s152 & ~s151);
        assign s116 = s469 | s470;
    end
    else begin:gen_hp_result
        assign s49 = s353 ? {48'b0,((s255 ? ~f1_op1_data[15:0] : {8'b0,~f1_op1_data[7:0]}) + 16'b1)} : f1_op1_data[63:0];
        assign s50 = s255 ? {s49[15:0]} : {s49[7:0],8'b0};
        assign s80 = s79;
        assign s81 = s80;
        assign s47 = |s85[(CVT_NBS_RND - 1):CVT_NBS_LSB];
        assign s128 = {{48{s167[CVT_BS_LSB + 16]}},s167[(CVT_BS_LSB + 15):CVT_BS_LSB]};
        assign s120 = {37'b0,({1'b0,s97} + {17'b0,s154[1]} + {17'b0,s154[0]})};
        assign s138 = s170 ? (~s119[32:1] + 32'b1) : s119[32:1];
        assign s139 = s170 ? (~s119[16:1] + 16'b1) : s119[16:1];
        assign s137 = 64'b0;
        assign s116 = 1'b0;
    end
endgenerate
generate
    if (FLEN == 64) begin:gen_dp_nbs
        wire [52:0] s471;
        wire [63:0] s472;
        assign s79 = ({(CVT_NBS_MSB - CVT_NBS_LSB + 1){s250}} & {s50,42'b0}) | ({(CVT_NBS_MSB - CVT_NBS_LSB + 1){s251}} & {29'b0,s50,13'b0}) | ({(CVT_NBS_MSB - CVT_NBS_LSB + 1){s252}} & {42'b0,s50});
        wire s473 = f1_widen | s192;
        assign s96 = s242 ? s74[63:0] : (s196 | (s197 & s473)) ? {s94[CVT_NBS_MSB:CVT_NBS_RND],10'b0} : {s95[CVT_ABS_MSB:CVT_ABS_LSB]};
        assign s127 = {{32{s138[31]}},s138};
        assign s107 = (s358 & (s430 | s432 | s431 | s433)) | (s359 & (s434 | s436 | s435 | s437)) | (s360 & (s438 | s440 | s439 | s441));
        assign s148 = 1'b0;
        assign s70 = (s258 & (s56 < 11'd1075)) | (s259 & (s57 < 8'd179)) | s260;
        assign s65 = (s70 ? 13'd52 : 13'd63) - s62;
        assign s137 = {s167[CVT_BS_MSB:CVT_BS_LSB]};
        assign s471 = s119[53:1];
        assign s472 = s170 ? (~s137 + 64'b1) : s137;
        assign s136 = s173 ? {{11{s170 & ~s369}},s471} : s472;
    end
    else if (FLEN == 32) begin:gen_sp_nbs
        wire [63:0] s472;
        assign s79 = ({(CVT_NBS_MSB - CVT_NBS_LSB + 1){s251}} & {s50,13'b0}) | ({(CVT_NBS_MSB - CVT_NBS_LSB + 1){s252}} & {13'b0,s50});
        wire s473 = f1_widen | s192;
        assign s96 = s242 ? s74[63:0] : (s196 | (s197 & s473)) ? {29'b0,s94[CVT_NBS_MSB:CVT_NBS_RND],10'b0} : {s95[CVT_ABS_MSB:CVT_ABS_LSB]};
        assign s127 = {{48{s139[15]}},s139};
        assign s107 = (s359 & (s434 | s436 | s435 | s437)) | (s360 & (s438 | s440 | s439 | s441));
        assign s148 = (s259 & (s57 > 8'd151) & s245);
        assign s70 = (s259 & (s57 < 8'd179)) | s260;
        assign s65 = (s148 ? 13'd63 : s70 ? 13'd52 : 13'd63) - s62;
        assign s137 = {s167[CVT_BS_MSB:CVT_BS_LSB]};
        assign s472 = s170 ? (~s137 + 64'b1) : s137;
        assign s136 = s150 ? s472 : {{32{s170 & ~s369}},s138};
    end
    else begin:gen_hp_nbs
        assign s79 = s50;
        assign s96 = s242 ? {s74[16:0]} : s196 ? {5'b0,s94[63:52]} : {s95[26:10]};
        assign s127 = {{48{s139[15]}},s139};
        assign s107 = (s360 & (s438 | s440 | s439 | s441));
        assign s148 = 1'b0;
        assign s70 = 1'b1;
        assign s65 = 13'd52 - s62;
        assign s136 = 64'b0;
    end
endgenerate
generate
    if ((FLEN == 32) | (FLEN == 64)) begin:gen_lz_num_sp
        reg s474;
        wire [63:0] s475;
        wire [31:0] s476;
        wire [15:0] s477;
        wire [7:0] s478;
        wire [3:0] s479;
        wire [1:0] s480;
        wire s481;
        wire [1:0] s482;
        wire [1:0] s483;
        wire [1:0] s484;
        wire [1:0] s485;
        wire [5:0] s486;
        assign s48 = s486;
        assign s47 = s474;
        assign s475 = s50[63:0];
        assign s481 = ~|s475[63:32];
        assign s482[1] = ~|s475[31:16];
        assign s482[0] = ~|s475[63:48];
        assign s483[1] = s486[5] ? ~|s475[15:8] : ~|s475[47:40];
        assign s483[0] = s486[5] ? ~|s475[31:24] : ~|s475[63:56];
        assign s484[1] = ((s486[5:4] == 2'b11) & (~|s475[7:4])) | ((s486[5:4] == 2'b10) & (~|s475[23:20])) | ((s486[5:4] == 2'b01) & (~|s475[39:36])) | ((s486[5:4] == 2'b00) & (~|s475[55:52]));
        assign s484[0] = ((s486[5:4] == 2'b11) & (~|s475[15:12])) | ((s486[5:4] == 2'b10) & (~|s475[31:28])) | ((s486[5:4] == 2'b01) & (~|s475[47:44])) | ((s486[5:4] == 2'b00) & (~|s475[63:60]));
        assign s485[1] = ((s486[5:3] == 3'b111) & (~|s475[3:2])) | ((s486[5:3] == 3'b110) & (~|s475[11:10])) | ((s486[5:3] == 3'b101) & (~|s475[19:18])) | ((s486[5:3] == 3'b100) & (~|s475[27:26])) | ((s486[5:3] == 3'b011) & (~|s475[35:34])) | ((s486[5:3] == 3'b010) & (~|s475[43:42])) | ((s486[5:3] == 3'b001) & (~|s475[51:50])) | ((s486[5:3] == 3'b000) & (~|s475[59:58]));
        assign s485[0] = ((s486[5:3] == 3'b111) & (~|s475[7:6])) | ((s486[5:3] == 3'b110) & (~|s475[15:14])) | ((s486[5:3] == 3'b101) & (~|s475[23:22])) | ((s486[5:3] == 3'b100) & (~|s475[31:30])) | ((s486[5:3] == 3'b011) & (~|s475[39:38])) | ((s486[5:3] == 3'b010) & (~|s475[47:46])) | ((s486[5:3] == 3'b001) & (~|s475[55:54])) | ((s486[5:3] == 3'b000) & (~|s475[63:62]));
        assign s486[5] = s481;
        assign s486[4] = s486[5] ? s482[1] : s482[0];
        assign s486[3] = s486[4] ? s483[1] : s483[0];
        assign s486[2] = s486[3] ? s484[1] : s484[0];
        assign s486[1] = s486[2] ? s485[1] : s485[0];
        assign s486[0] = ~s480[1];
        assign s476 = s486[5] ? s475[31:0] : s475[63:32];
        assign s477 = s486[4] ? s476[15:0] : s476[31:16];
        assign s478 = s486[3] ? s477[7:0] : s477[15:8];
        assign s479 = s486[2] ? s478[3:0] : s478[7:4];
        assign s480 = s486[1] ? s479[1:0] : s479[3:2];
        always @* begin
            case (s486[5:0])
                6'd51: s474 = |s79[0];
                6'd50: s474 = |s79[(51 - 50):0];
                6'd49: s474 = |s79[(51 - 49):0];
                6'd48: s474 = |s79[(51 - 48):0];
                6'd47: s474 = |s79[(51 - 47):0];
                6'd46: s474 = |s79[(51 - 46):0];
                6'd45: s474 = |s79[(51 - 45):0];
                6'd44: s474 = |s79[(51 - 44):0];
                6'd43: s474 = |s79[(51 - 43):0];
                6'd42: s474 = |s79[(51 - 42):0];
                6'd41: s474 = |s79[(51 - 41):0];
                6'd40: s474 = |s79[(51 - 40):0];
                6'd39: s474 = |s79[(51 - 39):0];
                6'd38: s474 = |s79[(51 - 38):0];
                6'd37: s474 = |s79[(51 - 37):0];
                6'd36: s474 = |s79[(51 - 36):0];
                6'd35: s474 = |s79[(51 - 35):0];
                6'd34: s474 = |s79[(51 - 34):0];
                6'd33: s474 = |s79[(51 - 33):0];
                6'd32: s474 = |s79[(51 - 32):0];
                6'd31: s474 = |s79[(51 - 31):0];
                6'd30: s474 = |s79[(51 - 30):0];
                6'd29: s474 = |s79[(51 - 29):0];
                6'd28: s474 = |s79[(51 - 28):0];
                6'd27: s474 = |s79[(51 - 27):0];
                6'd26: s474 = |s79[(51 - 26):0];
                6'd25: s474 = |s79[(51 - 25):0];
                6'd24: s474 = |s79[(51 - 24):0];
                6'd23: s474 = |s79[(51 - 23):0];
                6'd22: s474 = |s79[(51 - 22):0];
                6'd21: s474 = |s79[(51 - 21):0];
                6'd20: s474 = |s79[(51 - 20):0];
                6'd19: s474 = |s79[(51 - 19):0];
                6'd18: s474 = |s79[(51 - 18):0];
                6'd17: s474 = |s79[(51 - 17):0];
                6'd16: s474 = |s79[(51 - 16):0];
                6'd15: s474 = |s79[(51 - 15):0];
                6'd14: s474 = |s79[(51 - 14):0];
                6'd13: s474 = |s79[(51 - 13):0];
                6'd12: s474 = |s79[(51 - 12):0];
                6'd11: s474 = |s79[(51 - 11):0];
                6'd10: s474 = |s79[(51 - 10):0];
                6'd9: s474 = |s79[(51 - 9):0];
                6'd8: s474 = |s79[(51 - 8):0];
                6'd7: s474 = |s79[(51 - 7):0];
                6'd6: s474 = |s79[(51 - 6):0];
                6'd5: s474 = |s79[(51 - 5):0];
                6'd4: s474 = |s79[(51 - 4):0];
                6'd3: s474 = |s79[(51 - 3):0];
                6'd2: s474 = |s79[(51 - 2):0];
                6'd1: s474 = |s79[(51 - 1):0];
                6'd0: s474 = |s79[(51 - 0):0];
                default: s474 = 1'b0;
            endcase
        end

    end
    else begin:gen_lz_num_hp
        wire [15:0] s477;
        wire [7:0] s478;
        wire [3:0] s479;
        wire [1:0] s480;
        wire s487;
        wire [1:0] s488;
        wire [1:0] s489;
        wire [3:0] s490;
        assign s48 = {2'b0,s490};
        assign s477 = s50[15:0];
        assign s487 = ~|s477[15:8];
        assign s488[1] = ~|s477[7:4];
        assign s488[0] = ~|s477[15:12];
        assign s489[1] = s490[3] ? ~|s477[3:2] : ~|s477[11:10];
        assign s489[0] = s490[3] ? ~|s477[7:6] : ~|s477[15:14];
        assign s490[3] = s487;
        assign s490[2] = s490[3] ? s488[1] : s488[0];
        assign s490[1] = s490[2] ? s489[1] : s489[0];
        assign s490[0] = ~s480[1];
        assign s478 = s490[3] ? s477[7:0] : s477[15:8];
        assign s479 = s490[2] ? s478[3:0] : s478[7:4];
        assign s480 = s490[1] ? s479[1:0] : s479[3:2];
    end
endgenerate
endmodule


// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fpu (
    core_clk,
    core_reset_n,
    fpu_ipipe_standby_ready,
    fpu_ipipe_fdiv_standby_ready,
    fpu_i0_ctrl,
    fpu_i0_valid,
    fpu_i0_frs1,
    fpu_i0_frs2,
    fpu_i0_frs3,
    fpu_i1_ctrl,
    fpu_i1_valid,
    fpu_i1_frs1,
    fpu_i1_frs2,
    fpu_i1_frs3,
    fpu_lx_stall,
    fpu_fmis_result,
    fmis_flag_set,
    fpu_fmv_result,
    fpu_fmac32_result,
    fpu_fmac64_result,
    fmac_flag_set,
    fdiv_req_ready,
    fdiv_resp_tag,
    fdiv_resp_result,
    fdiv_resp_valid,
    fdiv_resp_ready,
    fdiv_resp_flag_set,
    fdiv_kill
);
parameter FLEN = 32;
parameter XLEN = 32;
input core_clk;
input core_reset_n;
input [22 - 1:0] fpu_i0_ctrl;
input fpu_i0_valid;
input [63:0] fpu_i0_frs1;
input [FLEN - 1:0] fpu_i0_frs2;
input [FLEN - 1:0] fpu_i0_frs3;
input [22 - 1:0] fpu_i1_ctrl;
input fpu_i1_valid;
input [63:0] fpu_i1_frs1;
input [FLEN - 1:0] fpu_i1_frs2;
input [FLEN - 1:0] fpu_i1_frs3;
input fpu_lx_stall;
output fpu_ipipe_standby_ready;
output fpu_ipipe_fdiv_standby_ready;
output [63:0] fpu_fmis_result;
output [4:0] fmis_flag_set;
output [63:0] fpu_fmv_result;
output [FLEN - 1:0] fpu_fmac32_result;
output [FLEN - 1:0] fpu_fmac64_result;
output [4:0] fmac_flag_set;
output fdiv_req_ready;
output [FLEN - 1:0] fdiv_resp_result;
output [4:0] fdiv_resp_tag;
output fdiv_resp_valid;
input fdiv_resp_ready;
output [4:0] fdiv_resp_flag_set;
input fdiv_kill;


wire [FLEN - 1:0] s0;
wire [FLEN - 1:0] s1;
wire [FLEN - 1:0] s2;
wire s3;
wire [22 - 1:0] s4;
wire [10:0] s5;
wire [63:0] s6;
wire [FLEN - 1:0] s7;
wire s8;
wire [22 - 1:0] s9;
wire [63:0] s10;
wire [FLEN - 1:0] s11;
wire s12;
wire [22 - 1:0] s13;
wire [63:0] s14;
wire [FLEN - 1:0] s15;
wire s16;
wire [22 - 1:0] s17;
reg [FLEN - 1:0] s18;
reg [FLEN - 1:0] s19;
reg [FLEN - 1:0] s20;
reg s21;
reg [22 - 1:0] s22;
reg [10:0] s23;
reg [63:0] s24;
reg [FLEN - 1:0] s25;
reg s26;
reg [22 - 1:0] s27;
reg [63:0] s28;
reg [FLEN - 1:0] s29;
reg s30;
reg [22 - 1:0] s31;
reg [63:0] s32;
reg [FLEN - 1:0] s33;
reg s34;
reg [22 - 1:0] s35;
wire [1:0] nds_unused_result_type_fdiv;
wire [1:0] nds_unused_result_type_fmac;
wire nds_unused_wdata_en_fmac;
wire nds_unused_cmp_result;
wire [63:0] nds_unused_fmis_narr_wdata64;
wire [1:0] nds_unused_result_type_fmis;
wire nds_unused_wdata_en_fmis;
wire [4:0] s36;
wire [4:0] fmac_flag_set;
wire [4:0] fmis_flag_set;
wire nds_unused_all = (|nds_unused_result_type_fdiv) | (|nds_unused_result_type_fmac) | nds_unused_wdata_en_fmac | nds_unused_cmp_result | (|nds_unused_fmis_narr_wdata64) | (|nds_unused_result_type_fmis) | nds_unused_wdata_en_fmis;
wire fmac_standby_ready;
wire fdiv_standby_ready;
wire fmis_standby_ready;
wire fmv_standby_ready;
assign fpu_ipipe_standby_ready = fmac_standby_ready & fdiv_standby_ready & fmis_standby_ready & fmv_standby_ready;
assign fpu_ipipe_fdiv_standby_ready = fdiv_standby_ready;
wire [2:0] s37;
assign s37 = s4[18 +:3];
assign s3 = fpu_i0_valid & fpu_i0_ctrl[12] | fpu_i1_valid & fpu_i1_ctrl[12];
assign s8 = fpu_i0_valid & fpu_i0_ctrl[6] | fpu_i1_valid & fpu_i1_ctrl[6];
assign s12 = fpu_i0_valid & fpu_i0_ctrl[13] | fpu_i1_valid & fpu_i1_ctrl[13];
assign s16 = fpu_i0_valid & fpu_i0_ctrl[14] | fpu_i1_valid & fpu_i1_ctrl[14];
assign s0 = (fpu_i0_valid & fpu_i0_ctrl[12]) ? fpu_i0_frs1[FLEN - 1:0] : fpu_i1_frs1[FLEN - 1:0];
assign s1 = (fpu_i0_valid & fpu_i0_ctrl[12]) ? fpu_i0_frs2[FLEN - 1:0] : fpu_i1_frs2[FLEN - 1:0];
assign s2 = (fpu_i0_valid & fpu_i0_ctrl[12]) ? fpu_i0_frs3[FLEN - 1:0] : fpu_i1_frs3[FLEN - 1:0];
assign s4 = (fpu_i0_valid & fpu_i0_ctrl[12]) ? fpu_i0_ctrl : fpu_i1_ctrl;
assign s5 = ({11{s37[2]}} & 11'h43a) | ({11{s37[1]}} & 11'h79d) | ({11{s37[0]}} & 11'h000);
assign s6 = (fpu_i0_valid & fpu_i0_ctrl[6]) ? fpu_i0_frs1[63:0] : fpu_i1_frs1[63:0];
assign s7 = (fpu_i0_valid & fpu_i0_ctrl[6]) ? fpu_i0_frs2[FLEN - 1:0] : fpu_i1_frs2[FLEN - 1:0];
assign s9 = (fpu_i0_valid & fpu_i0_ctrl[6]) ? fpu_i0_ctrl : fpu_i1_ctrl;
assign s10 = (fpu_i0_valid & fpu_i0_ctrl[13]) ? fpu_i0_frs1 : fpu_i1_frs1;
assign s11 = (fpu_i0_valid & fpu_i0_ctrl[13]) ? fpu_i0_frs2[FLEN - 1:0] : fpu_i1_frs2[FLEN - 1:0];
assign s13 = (fpu_i0_valid & fpu_i0_ctrl[13]) ? fpu_i0_ctrl : fpu_i1_ctrl;
assign s14 = (fpu_i0_valid & fpu_i0_ctrl[14]) ? fpu_i0_frs1 : fpu_i1_frs1;
assign s15 = (fpu_i0_valid & fpu_i0_ctrl[14]) ? fpu_i0_frs2 : fpu_i1_frs2;
assign s17 = (fpu_i0_valid & fpu_i0_ctrl[14]) ? fpu_i0_ctrl : fpu_i1_ctrl;
wire [2:0] s38 = s13[18 +:3];
wire s39 = s38[0];
wire s40 = s38[1];
wire s41 = s38[2];
wire s42 = (FLEN == 32) | (FLEN == 64);
wire s43 = (FLEN == 64);
wire s44 = (s13[4:0] == 5'b11100) & s39;
wire s45 = (s13[4:0] == 5'b11100) & s40 & s42;
wire s46 = (s13[4:0] == 5'b11100) & s41 & s43;
wire s47 = (s13[4:0] == 5'b11101) & s39;
wire s48 = (s13[4:0] == 5'b11101) & s40 & s42;
wire s49 = (s13[4:0] == 5'b11101) & s41 & s43;
wire s50 = (s13[4:0] == 5'b11010) & s40;
wire s51 = (s13[4:0] == 5'b11010) & s41;
wire s52 = (s13[4:0] == 5'b11000) & s40 & s42;
wire s53 = (s13[4:0] == 5'b11000) & s41 & s42;
wire s54 = (s13[4:0] == 5'b11001) & s40 & s43;
wire s55 = (s13[4:0] == 5'b11001) & s41 & s43;
wire s56 = (s13[4:0] == 5'b10010) & s40 & s42;
wire s57 = (s13[4:0] == 5'b10010) & s41 & s43;
wire s58 = (s13[4:0] == 5'b10000) & s39 & s42;
wire s59 = (s13[4:0] == 5'b10000) & s41 & s43;
wire s60 = (s13[4:0] == 5'b10001) & s39 & s43;
wire s61 = (s13[4:0] == 5'b10001) & s40 & s43;
wire s62 = (s13[4:0] == 5'b10101) & s42;
wire s63 = (s13[4:0] == 5'b10100) & s42;
wire s64 = (s13[4:0] == 5'b00101);
wire s65 = (s13[4:0] == 5'b00100);
wire s66 = (s13[4:0] == 5'b01010);
wire s67 = (s13[4:0] == 5'b01000);
wire s68 = (s13[4:0] == 5'b01001);
wire s69 = (s13[4:0] == 5'b01101);
reg s70;
reg s71;
reg s72;
reg s73;
reg s74;
reg s75;
reg s76;
reg s77;
reg s78;
reg s79;
reg s80;
reg s81;
reg s82;
reg s83;
reg s84;
reg s85;
reg s86;
reg s87;
reg s88;
reg s89;
reg s90;
reg s91;
reg s92;
reg s93;
reg s94;
reg s95;
wire s96;
assign s96 = (s21 | s26 | s30 | s34 | fpu_i0_valid | fpu_i1_valid) & ~fpu_lx_stall;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s21 <= 1'b0;
        s26 <= 1'b0;
        s30 <= 1'b0;
        s34 <= 1'b0;
    end
    else if (s96) begin
        s21 <= s3;
        s26 <= s8;
        s30 <= s12;
        s34 <= s16;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s18 <= {FLEN{1'b0}};
        s19 <= {FLEN{1'b0}};
        s20 <= {FLEN{1'b0}};
        s23 <= 11'b0;
        s22 <= {22{1'b0}};
    end
    else if (s3 & ~fpu_lx_stall) begin
        s18 <= s0;
        s19 <= s1;
        s20 <= s2;
        s23 <= s5;
        s22 <= s4;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s24 <= 64'b0;
        s25 <= {FLEN{1'b0}};
        s27 <= {22{1'b0}};
    end
    else if (s8 & ~fpu_lx_stall) begin
        s24 <= s6;
        s25 <= s7;
        s27 <= s9;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s28 <= 64'b0;
        s29 <= {FLEN{1'b0}};
        s31 <= {22{1'b0}};
        s70 <= 1'b0;
        s71 <= 1'b0;
        s72 <= 1'b0;
        s73 <= 1'b0;
        s74 <= 1'b0;
        s75 <= 1'b0;
        s76 <= 1'b0;
        s77 <= 1'b0;
        s78 <= 1'b0;
        s79 <= 1'b0;
        s80 <= 1'b0;
        s81 <= 1'b0;
        s82 <= 1'b0;
        s83 <= 1'b0;
        s84 <= 1'b0;
        s85 <= 1'b0;
        s86 <= 1'b0;
        s87 <= 1'b0;
        s88 <= 1'b0;
        s89 <= 1'b0;
        s90 <= 1'b0;
        s91 <= 1'b0;
        s92 <= 1'b0;
        s93 <= 1'b0;
        s94 <= 1'b0;
        s95 <= 1'b0;
    end
    else if (s12 & ~fpu_lx_stall) begin
        s28 <= s10;
        s29 <= s11;
        s31 <= s13;
        s70 <= s44;
        s71 <= s45;
        s72 <= s46;
        s73 <= s47;
        s74 <= s48;
        s75 <= s49;
        s76 <= s50;
        s77 <= s51;
        s78 <= s52;
        s79 <= s53;
        s80 <= s54;
        s81 <= s55;
        s82 <= s56;
        s83 <= s57;
        s84 <= s58;
        s85 <= s59;
        s86 <= s60;
        s87 <= s61;
        s88 <= s62;
        s89 <= s63;
        s90 <= s64;
        s91 <= s65;
        s92 <= s66;
        s93 <= s67;
        s94 <= s68;
        s95 <= s69;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s32 <= 64'b0;
        s33 <= {FLEN{1'b0}};
        s35 <= {22{1'b0}};
    end
    else if (s16 & ~fpu_lx_stall) begin
        s32 <= s14;
        s33 <= s15;
        s35 <= s17;
    end
end

wire [2:0] s97 = s35[18 +:3];
wire [63:0] s98 = s32;
wire [63:0] s99;
kv_one_ext #(
    .OW(64),
    .IW(FLEN)
) u_f1_fmv_op2_1ext (
    .out(s99),
    .in(s33)
);
kv_fpu_fmv #(
    .FLEN(FLEN)
) u_fpu_fmv (
    .fmv_standby_ready(fmv_standby_ready),
    .f1_wdata(fpu_fmv_result),
    .f1_op1_data(s98),
    .f1_op2_data(s99),
    .f1_valid(s34),
    .f1_sew(s97),
    .f1_ex_ctrl(s35[0 +:6])
);
wire [2:0] s100 = s31[18 +:3];
wire [63:0] s101 = s28;
wire [63:0] s102;
kv_one_ext #(
    .OW(64),
    .IW(FLEN)
) u_f1_fmis_op2_1ext (
    .out(s102),
    .in(s29)
);
kv_fpu_fmis #(
    .FLEN(FLEN),
    .XLEN(XLEN)
) u_fpu_fmis (
    .fmis_standby_ready(fmis_standby_ready),
    .f2_cmp_result(nds_unused_cmp_result),
    .f2_narr_wdata(nds_unused_fmis_narr_wdata64),
    .f2_wdata(fpu_fmis_result),
    .f2_wdata_en(nds_unused_wdata_en_fmis),
    .f2_flag_set(fmis_flag_set),
    .f2_result_type(nds_unused_result_type_fmis),
    .f2_stall(fpu_lx_stall),
    .f1_op1_data(s101),
    .f1_op2_data(s102),
    .f1_valid(s30),
    .f1_round_mode(s31[15 +:3]),
    .f1_sew(s100),
    .f1_ediv(2'b0),
    .f1_ex_ctrl(s31[0 +:6]),
    .f1_vmask(1'b1),
    .f1_sign(s31[21]),
    .f1_fmis_scalar_valid(1'b1),
    .f1_op1_invalid(1'b0),
    .f1_op2_invalid(1'b0),
    .f1_widen(1'b0),
    .f1_narrow(1'b0),
    .f1_fcvtwh_instr(s70),
    .f1_fcvtws_instr(s71),
    .f1_fcvtwd_instr(s72),
    .f1_fcvtlh_instr(s73),
    .f1_fcvtls_instr(s74),
    .f1_fcvtld_instr(s75),
    .f1_fcvthw_instr(s76),
    .f1_fcvthl_instr(s77),
    .f1_fcvtsw_instr(s78),
    .f1_fcvtsl_instr(s79),
    .f1_fcvtdw_instr(s80),
    .f1_fcvtdl_instr(s81),
    .f1_fcvths_instr(s82),
    .f1_fcvthd_instr(s83),
    .f1_fcvtsh_instr(s84),
    .f1_fcvtsd_instr(s85),
    .f1_fcvtdh_instr(s86),
    .f1_fcvtds_instr(s87),
    .f1_fcvtbs_instr(s88),
    .f1_fcvtsb_instr(s89),
    .f1_fmin_instr(s90),
    .f1_fmax_instr(s91),
    .f1_feq_instr(s92),
    .f1_fle_instr(s93),
    .f1_flt_instr(s94),
    .f1_fclass_instr(s95),
    .core_clk(core_clk),
    .lane_pipe_id_0(1'b1),
    .core_reset_n(core_reset_n)
);
wire [2:0] s103;
wire [63:0] s104;
wire [63:0] s105;
wire s106;
wire [63:0] s107;
assign fdiv_resp_result = s107[FLEN - 1:0];
assign fdiv_resp_flag_set = s36;
assign s103 = s27[18 +:3];
assign s104 = s24;
kv_one_ext #(
    .OW(64),
    .IW(FLEN)
) u_f1_fdiv_op2_1ext (
    .out(s105),
    .in(s25)
);
assign s106 = ~fdiv_resp_ready;
kv_fpu_fdiv #(
    .FLEN(FLEN)
) u_fpu_div (
    .fdiv_standby_ready(fdiv_standby_ready),
    .f4_wdata(s107),
    .f4_wdata_en(fdiv_resp_valid),
    .f4_tag(fdiv_resp_tag),
    .f4_flag_set(s36),
    .f4_result_type(nds_unused_result_type_fdiv),
    .f4_frf_stall(s106),
    .req_ready(fdiv_req_ready),
    .f1_op1_data(s104),
    .f1_op2_data(s105),
    .f1_valid(s26),
    .f1_round_mode(s27[15 +:3]),
    .f1_sew(s103),
    .f1_ediv(2'b0),
    .f1_ex_ctrl(s27[0 +:6]),
    .f1_tag(s27[7 +:5]),
    .kill(fdiv_kill),
    .f3_main_pipe_stall(fpu_lx_stall),
    .core_clk(core_clk),
    .core_reset_n(core_reset_n)
);
wire [2:0] s108 = s22[18 +:3];
generate
    if (FLEN == 32) begin:gen_sp_fmac
        wire [63:0] s109;
        wire s110;
        assign s110 = s108[0];
        wire s111 = |s23;
        kv_fpu_fmac32 #(
            .FLEN(FLEN)
        ) u_fpu_fmac32 (
            .fmac_standby_ready(fmac_standby_ready),
            .f3_wdata(s109),
            .f3_wdata_en(nds_unused_wdata_en_fmac),
            .f3_flag_set(fmac_flag_set),
            .f3_result_type(nds_unused_result_type_fmac),
            .lane_pipe_id0(1'b1),
            .f1_op1_data(s18[31:0]),
            .f1_op2_data(s19[31:0]),
            .f1_op3_data(s20[31:0]),
            .f1_valid(s21),
            .f1_round_mode(s22[15 +:3]),
            .f1_sew(s108),
            .f1_ediv(2'b0),
            .f1_ex_ctrl(s22[0 +:6]),
            .f1_op_wide(1'b0),
            .f1_op_mask(1'b1),
            .f1_op1_hp(s110),
            .f1_op3_hp(s110),
            .f3_stall(fpu_lx_stall),
            .core_clk(core_clk),
            .core_reset_n(core_reset_n)
        );
        assign fpu_fmac32_result = s109[FLEN - 1:0];
        assign fpu_fmac64_result = {FLEN{1'b0}};
    end
    else begin:gen_dp_fmac
        wire s110;
        wire s112;
        wire s113;
        assign s110 = s108[0];
        assign s112 = s108[1];
        assign s113 = s108[2];
        kv_fpu_fmac64 #(
            .FLEN(FLEN)
        ) u_fpu_fmac64 (
            .fmac_standby_ready(fmac_standby_ready),
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .lane_pipe_id0(1'b1),
            .f3_stall(fpu_lx_stall),
            .f1_op1_data(s18),
            .f1_op2_data(s19),
            .f1_op3_data(s20),
            .f1_valid(s21),
            .f1_round_mode(s22[15 +:3]),
            .f1_sew(s108),
            .f1_ediv(2'b0),
            .f1_ex_ctrl(s22[0 +:6]),
            .f1_op_wide(1'b0),
            .f1_op_mask(1'b1),
            .f1_op1_dp(s113),
            .f1_op3_dp(s113),
            .f1_op1_sp(s112),
            .f1_op3_sp(s112),
            .f1_op1_hp(s110),
            .f1_op3_hp(s110),
            .f1_align_amount_adjustment(s23),
            .f4_wdata(fpu_fmac64_result),
            .f4_wdata_en(nds_unused_wdata_en_fmac),
            .f4_flag_set(fmac_flag_set),
            .f4_result_type(nds_unused_result_type_fmac)
        );
        assign fpu_fmac32_result = {FLEN{1'b0}};
    end
endgenerate
endmodule


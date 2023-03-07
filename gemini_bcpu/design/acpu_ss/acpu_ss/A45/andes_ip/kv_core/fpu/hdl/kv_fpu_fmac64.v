// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fpu_fmac64 (
    core_clk,
    core_reset_n,
    lane_pipe_id0,
    fmac_standby_ready,
    f1_op1_data,
    f1_op2_data,
    f1_op3_data,
    f1_valid,
    f1_round_mode,
    f1_sew,
    f1_ediv,
    f1_ex_ctrl,
    f1_op_wide,
    f1_op_mask,
    f1_op1_dp,
    f1_op3_dp,
    f1_op1_sp,
    f1_op3_sp,
    f1_op1_hp,
    f1_op3_hp,
    f1_align_amount_adjustment,
    f3_stall,
    f4_wdata,
    f4_wdata_en,
    f4_flag_set,
    f4_result_type
);
parameter FLEN = 64;
localparam MAC_MSB = 161;
localparam MAC_LSB = -2;
localparam MAC_WIDTH = MAC_MSB - MAC_LSB + 1;
localparam EXP_MSB = 12;
localparam EXP_WIDTH = EXP_MSB + 1;
localparam LZA_MSB = 107;
localparam LZA_LSB = MAC_LSB;
localparam LZA_WIDTH = LZA_MSB - LZA_LSB + 1;
localparam ROUND_RNE = 3'b000;
localparam ROUND_RTZ = 3'b001;
localparam ROUND_RDN = 3'b010;
localparam ROUND_RUP = 3'b011;
localparam ROUND_RMM = 3'b100;
localparam DP_BIAS = 13'h3ff;
localparam SP_BIAS = 13'h7f;
localparam HP_BIAS = 13'hf;
localparam DP_2X_BIAS = 13'h7fe;
localparam SP_2X_BIAS = 13'hfe;
localparam HP_2X_BIAS = 13'h1e;
localparam CSA_WIDTH = 106;
input core_clk;
input core_reset_n;
input lane_pipe_id0;
input [63:0] f1_op1_data;
input [63:0] f1_op2_data;
input [63:0] f1_op3_data;
input f1_valid;
input [2:0] f1_round_mode;
input [2:0] f1_sew;
input [1:0] f1_ediv;
input [5:0] f1_ex_ctrl;
input f1_op_wide;
input f1_op_mask;
input f1_op1_dp;
input f1_op3_dp;
input f1_op1_sp;
input f1_op3_sp;
input f1_op1_hp;
input f1_op3_hp;
input [10:0] f1_align_amount_adjustment;
input f3_stall;
output [63:0] f4_wdata;
output f4_wdata_en;
output [4:0] f4_flag_set;
output [1:0] f4_result_type;
output fmac_standby_ready;


wire f1_op2_dp = f1_op1_dp;
wire f1_op2_sp = f1_op1_sp;
wire f1_op2_hp = f1_op1_hp;
wire f1_align_amount_gt255;
wire f1_op1_sign;
wire f1_op2_sign;
wire f1_op3_sign;
wire [EXP_MSB:0] f1_op1_exp;
wire [EXP_MSB:0] f1_op2_exp;
wire [EXP_MSB:0] f1_op3_exp;
wire [52:0] f1_op1_frac;
wire [52:0] f1_op2_frac;
wire [52:0] f1_op3_frac;
wire [2:0] f1_round_mode;
wire f1_eff_sub;
wire f1_frd_dp;
wire f1_frd_sp;
wire f1_frd_hp;
wire f1_mul_sign;
wire [MAC_MSB:MAC_LSB] f1_pre_lsh_frac;
wire [MAC_MSB:MAC_LSB] f1_align_l0;
wire [MAC_MSB:MAC_LSB] f1_align_l1;
wire [MAC_MSB:MAC_LSB] f1_align_l2;
wire [MAC_MSB:MAC_LSB] f1_align_l3;
wire [MAC_MSB:MAC_LSB] f1_align_l4;
wire [MAC_MSB:MAC_LSB] f1_align_l5;
wire [EXP_MSB:0] f1_align_amount_carry;
wire [EXP_MSB + 1:0] f1_align_amount_sum;
wire [EXP_MSB:0] f1_align_amount;
wire f1_align_amount_zero;
wire f1_frd_zero_sign;
wire f1_frd_inf_sign;
wire [EXP_MSB:0] f1_op3_exp_wo_bias;
wire [EXP_MSB:0] f1_mul_exp_wo_bias;
wire f1_align_diff_gt2;
wire f1_frd_inf;
wire f1_frd_zero;
wire f1_frd_qnan;
wire f1_nv_exception;
wire f1_mul_is_zero;
wire [4:0] f1_op3_lzc;
wire [4:0] f1_op3_lzc_subnorm;
wire [23:0] f1_op3_lzc_data;
wire [15:0] f1_op3_lzc_data_l1;
wire [7:0] f1_op3_lzc_data_l2;
wire [3:0] f1_op3_lzc_data_l3;
wire [1:0] f1_op3_lzc_data_l4;
wire [EXP_MSB:0] f2_mac_exp_nx;
wire f2_eff_sub_nx;
wire f1_arith_sign;
wire f2_align_sticky_partial_nx;
wire [6:0] f1_lzc_align_diff_gt2;
wire f2_frd_subnorm_nx;
wire [7:6] f2_align_amount_nx;
wire [MAC_MSB:MAC_LSB] f2_align_l5_nx;
wire [53:0] f1_pp_x0;
wire [53:0] f1_pp_x2;
wire [53:0] f1_pp_x4;
wire [53:0] f1_pp_x6;
wire [53:0] f1_pp_x8;
wire [53:0] f1_pp_x10;
wire [53:0] f1_pp_x12;
wire [53:0] f1_pp_x14;
wire [53:0] f1_pp_x16;
wire [53:0] f1_pp_x18;
wire [53:0] f1_pp_x20;
wire [53:0] f1_pp_x22;
wire [53:0] f1_pp_x24;
wire [53:0] f1_pp_x26;
wire [53:0] f1_pp_x28;
wire [53:0] f1_pp_x30;
wire [53:0] f1_pp_x32;
wire [53:0] f1_pp_x34;
wire [53:0] f1_pp_x36;
wire [53:0] f1_pp_x38;
wire [53:0] f1_pp_x40;
wire [53:0] f1_pp_x42;
wire [53:0] f1_pp_x44;
wire [53:0] f1_pp_x46;
wire [53:0] f1_pp_x48;
wire [53:0] f1_pp_x50;
wire [53:0] f1_pp_x52;
wire [105:0] f1_pp_cin;
wire [105:0] f1_pp_ay;
wire [105:0] f1_pp_ab_bx;
wire f1_ci_x0;
wire f1_ci_x2;
wire f1_ci_x4;
wire f1_ci_x6;
wire f1_ci_x8;
wire f1_ci_x10;
wire f1_ci_x12;
wire f1_ci_x14;
wire f1_ci_x16;
wire f1_ci_x18;
wire f1_ci_x20;
wire f1_ci_x22;
wire f1_ci_x24;
wire f1_ci_x26;
wire f1_ci_x28;
wire f1_ci_x30;
wire f1_ci_x32;
wire f1_ci_x34;
wire f1_ci_x36;
wire f1_ci_x38;
wire f1_ci_x40;
wire f1_ci_x42;
wire f1_ci_x44;
wire f1_ci_x46;
wire f1_ci_x48;
wire f1_ci_x50;
wire f1_ci_x52;
wire [105:0] f1_c0_l1;
wire [105:0] f1_c1_l1;
wire [105:0] f1_c2_l1;
wire [105:0] f1_c3_l1;
wire [105:0] f1_c4_l1;
wire [105:0] f1_c5_l1;
wire [105:0] f1_c6_l1;
wire [105:0] f1_c0_l2;
wire [105:0] f1_c1_l2;
wire [105:0] f1_c2_l2;
wire [105:0] f1_c3_l2;
wire [105:0] f1_c0_l3;
wire [105:0] f1_c1_l3;
wire [106:0] f1_s0_l1;
wire [106:0] f1_s1_l1;
wire [106:0] f1_s2_l1;
wire [106:0] f1_s3_l1;
wire [106:0] f1_s4_l1;
wire [106:0] f1_s5_l1;
wire [106:0] f1_s6_l1;
wire [106:0] f1_s0_l2;
wire [106:0] f1_s1_l2;
wire [106:0] f1_s2_l2;
wire [106:0] f1_s3_l2;
wire [106:0] f1_s0_l3;
wire [106:0] f1_s1_l3;
reg [7:6] f2_align_amount;
reg [MAC_MSB:MAC_LSB] f2_align_l5;
reg f2_align_diff_gt2;
reg f2_valid;
reg f2_nv_exception;
reg f2_frd_inf;
reg f2_frd_zero;
reg f2_frd_qnan;
reg f2_arith_sign;
reg f2_frd_dp;
reg f2_frd_sp;
reg f2_frd_hp;
reg f2_eff_sub;
reg [2:0] f2_round_mode;
reg f2_align_sticky_partial;
reg [6:0] f2_lzc_align_diff_gt2;
reg [105:0] f2_c0_l3;
reg [105:0] f2_c1_l3;
reg [106:0] f2_s0_l3;
reg [106:0] f2_s1_l3;
reg f2_frd_scalar_fp;
reg f2_frd_subnorm;
reg [EXP_MSB:0] f2_mac_exp;
wire [MAC_MSB:MAC_LSB] f2_align_l6;
wire [MAC_MSB:MAC_LSB] f2_align_final;
wire f2_align_sticky_l6;
wire f2_align_sticky_l7;
wire f2_align_sticky;
wire [106:0] f2_mul_sum;
wire [105:0] f2_mul_carry;
wire [MAC_MSB:MAC_LSB] f2_sum;
wire [MAC_MSB:MAC_LSB] f2_carry;
wire f2_pipe_en;
wire [MAC_MSB:MAC_LSB] f2_ha_sum;
wire [MAC_MSB:MAC_LSB] f2_ha_carry;
wire [MAC_MSB:MAC_LSB] f2_ha_carry_inv;
wire [MAC_MSB:MAC_LSB] f2_pos_p0;
wire [MAC_MSB:MAC_LSB] f2_pos_g0;
wire [MAC_MSB:MAC_LSB] f2_pos_p1;
wire [MAC_MSB:MAC_LSB] f2_pos_g1;
wire [MAC_MSB:MAC_LSB] f2_pos_g2;
wire [MAC_MSB:MAC_LSB] f2_neg_p0;
wire [MAC_MSB:MAC_LSB] f2_neg_g0;
wire [MAC_MSB:MAC_LSB] f2_neg_p1;
wire [MAC_MSB:MAC_LSB] f2_neg_g1;
wire [MAC_MSB:MAC_LSB] f2_neg_g2;
wire [MAC_MSB:MAC_LSB] f2_p0;
wire [MAC_MSB:MAC_LSB] f2_g2;
wire [MAC_MSB:MAC_LSB] f3_p_nx;
wire [MAC_MSB:MAC_LSB] f3_g_nx;
wire [LZA_MSB:LZA_LSB] f2_eff_add_a_str;
wire [LZA_MSB + 1:LZA_LSB] f2_eff_add_p_str;
wire [LZA_MSB:LZA_LSB] f2_eff_add_lza_str;
wire [LZA_MSB:LZA_LSB] f2_eff_sub_e_str;
wire [LZA_MSB:LZA_LSB] f2_eff_sub_g_str;
wire [LZA_MSB:LZA_LSB] f2_eff_sub_s_str;
wire [LZA_MSB:LZA_LSB] f2_eff_sub_pos_str;
wire [LZA_MSB:LZA_LSB] f2_eff_sub_neg_str;
wire [LZA_MSB:LZA_LSB] f2_eff_sub_lza_str;
wire [LZA_MSB:LZA_LSB] f2_lza_str;
wire f2_complement;
wire [6:3] f2_lzc;
wire [1:0] f2_lzc_or_l1;
wire [1:0] f2_lzc_or_l2;
wire [1:0] f2_lzc_or_l3;
wire [EXP_MSB:0] f2_lzc_subnorm;
wire [6:0] f2_lzc_subnorm_final;
wire f2_lzc_eq_subnorm_b6to4;
wire f2_lzc_gt_subnorm_b6to4;
wire [6:3] f2_lzc_msb;
wire [6:4] f2_lzc_final_msb;
wire [63:0] f2_lza_str_l1;
wire [31:0] f2_lza_str_l2;
wire [15:0] f2_lza_str_l3;
reg f3_valid;
reg f3_nv_exception;
reg f3_frd_inf;
reg f3_frd_zero;
reg f3_frd_qnan;
reg f3_frd_dp;
reg f3_frd_sp;
reg f3_frd_hp;
reg f3_arith_sign;
reg f3_align_sticky;
reg [EXP_MSB:0] f3_mac_exp;
reg f3_align_diff_gt2;
reg [2:0] f3_round_mode;
reg [6:3] f3_lzc_msb;
reg [6:4] f3_lzc_final_msb;
reg [6:0] f3_lzc_align_diff_gt2;
reg [6:0] f3_lzc_subnorm;
reg f3_lzc_eq_subnorm_b6to4;
reg f3_lzc_gt_subnorm_b6to4;
reg f3_complement;
reg [MAC_MSB:MAC_LSB] f3_p;
reg [MAC_MSB:MAC_LSB] f3_g;
reg f3_frd_scalar_fp;
reg f3_frd_subnorm;
reg [15:0] f3_lza_str;
wire [7:0] f3_lza_str_l1;
wire [3:0] f3_lza_str_l2;
wire [1:0] f3_lza_str_l3;
wire [6:0] f3_lzc;
wire [6:0] f3_lzc_final;
wire f3_lzc_sel_subnorm;
wire [MAC_MSB:MAC_LSB] f3_nbs_p_l0;
wire [MAC_MSB:MAC_LSB] f3_nbs_p_l1;
wire [MAC_MSB:MAC_LSB] f3_nbs_p_l2;
wire [MAC_MSB:MAC_LSB] f3_nbs_p_l3;
wire [MAC_MSB:MAC_LSB] f3_nbs_p_l4;
wire [MAC_MSB:MAC_LSB] f3_nbs_p_l5;
wire [MAC_MSB:MAC_LSB] f3_nbs_p_l6;
wire [MAC_MSB:MAC_LSB] f3_nbs_p_l7;
wire [MAC_MSB:MAC_LSB] f3_nbs_g_l0;
wire [MAC_MSB:MAC_LSB] f3_nbs_g_l1;
wire [MAC_MSB:MAC_LSB] f3_nbs_g_l2;
wire [MAC_MSB:MAC_LSB] f3_nbs_g_l3;
wire [MAC_MSB:MAC_LSB] f3_nbs_g_l4;
wire [MAC_MSB:MAC_LSB] f3_nbs_g_l5;
wire [MAC_MSB:MAC_LSB] f3_nbs_g_l6;
wire [MAC_MSB:MAC_LSB] f3_nbs_g_l7;
wire [MAC_MSB:MAC_LSB] f3_nbs_p;
wire [MAC_MSB:MAC_LSB] f3_nbs_g;
wire f3_pipe_en;
wire f3_arith_sign_nx;
wire [53:2] f3_y0_p0;
wire [53:2] f3_y0_p1;
wire [53:2] f3_y0_p2;
wire [53:2] f3_y0_p3;
wire [53:2] f3_y0_p4;
wire [53:2] f3_y0_p5;
wire [53:2] f3_y0_g2_orig;
wire [53:2] f3_y0_g2;
wire [53:2] f3_y0_g3;
wire [53:2] f3_y0_g4;
wire [53:2] f3_y0_g5;
wire [53:2] f3_y0_g6;
wire [53:2] f3_y0;
wire [53:2] f3_y1_p0;
wire [53:2] f3_y1_p1;
wire [53:2] f3_y1_p2;
wire [53:2] f3_y1_p3;
wire [53:2] f3_y1_p4;
wire [53:2] f3_y1_p5;
wire [53:2] f3_y1_g2;
wire [53:2] f3_y1_g3;
wire [53:2] f3_y1_g4;
wire [53:2] f3_y1_g5;
wire [53:2] f3_y1_g6;
wire [53:2] f3_y1;
wire [2:0] f3_cslice_p0;
wire [2:0] f3_cslice_p1;
wire [2:0] f3_cslice_p2;
wire [2:0] f3_cslice_g2_orig;
wire [2:0] f3_cslice_g2;
wire [3:0] f3_z;
wire [106:MAC_LSB] f3_lslice_p0;
wire [106:MAC_LSB] f3_lslice_p1;
wire [106:MAC_LSB] f3_lslice_p2;
wire [106:MAC_LSB] f3_lslice_p3;
wire [106:MAC_LSB] f3_lslice_p4;
wire [106:MAC_LSB] f3_lslice_p5;
wire [106:MAC_LSB] f3_lslice_p6;
wire [106:MAC_LSB] f3_lslice_g2;
wire [106:MAC_LSB] f3_lslice_g3;
wire [106:MAC_LSB] f3_lslice_g4;
wire [106:MAC_LSB] f3_lslice_g5;
wire [106:MAC_LSB] f3_lslice_g6;
wire [106:MAC_LSB] f3_lslice_g7;
wire [106:MAC_LSB] f3_lslice_v;
wire f3_lslice_msb;
wire f3_carry;
wire f3_sticky;
wire [EXP_MSB:0] f4_mac_exp_nx;
wire f3_lza_err_check_disable;
wire f3_round_rne;
wire f3_round_rtz;
wire f3_round_rdn;
wire f3_round_rup;
wire f3_round_rmm;
wire f3_ri;
wire f3_rn;
wire f3_rz;
reg f4_valid;
reg f4_nv_exception;
reg f4_frd_inf;
reg f4_frd_zero;
reg f4_frd_qnan;
reg f4_frd_dp;
reg f4_frd_sp;
reg f4_frd_hp;
reg f4_arith_sign;
reg f4_align_sticky;
reg [EXP_MSB:0] f4_mac_exp;
reg f4_lslice_msb;
reg f4_carry;
reg f4_sticky;
reg [53:2] f4_y0;
reg [53:2] f4_y1;
reg [3:0] f4_z;
reg f4_frd_scalar_fp;
reg f4_lza_err_check_disable;
reg f4_round_rne;
reg f4_round_rdn;
reg f4_ri;
reg f4_rn;
reg f4_rz;
wire f4_redosum_masked;
wire [63:0] f4_redosum_scalar;
wire [3:0] f4_z_lza_err;
wire [3:0] f4_z_lza_noerr;
wire f4_frd_inf_final;
wire f4_frd_zero_final;
wire f4_pipe_en;
wire f4_dp_subnorm_pred;
wire f4_sp_subnorm_pred;
wire f4_hp_subnorm_pred;
wire f4_subnorm_pred;
wire f4_nx_exception;
wire [53:2] f4_y;
wire f4_lza_err;
wire [52:0] f4_frac;
wire [52:0] f4_frac_corrected;
wire f4_sticky_lza_err;
wire f4_inc;
wire f4_zero_sign;
wire f4_frd_special;
wire [63:0] f4_arith_wdata;
wire [63:0] f4_non_arith_wdata;
wire f4_non_arith_wdata_en;
wire [3:0] f4_round_digit_lza_err;
wire [3:0] f4_round_digit_lza_noerr;
wire [EXP_MSB:0] f4_adjust_exp_bias;
wire f4_tie;
wire f4_tie_round_bit;
wire f4_tie_sticky_bit;
wire f4_exp_d_gt_ovf_bound;
wire f4_exp_d_gt_sub_bound;
wire f4_exp_d_gt_udf_bound;
wire f4_exp_s_gt_ovf_bound;
wire f4_exp_s_gt_sub_bound;
wire f4_exp_s_gt_udf_bound;
wire f4_exp_h_gt_ovf_bound;
wire f4_exp_h_gt_sub_bound;
wire f4_exp_h_gt_udf_bound;
wire f4_exp_p0_d_gt_ovf_bound;
wire f4_exp_p0_d_gt_sub_bound;
wire f4_exp_p0_d_gt_udf_bound;
wire f4_exp_p0_s_gt_ovf_bound;
wire f4_exp_p0_s_gt_sub_bound;
wire f4_exp_p0_s_gt_udf_bound;
wire f4_exp_p0_h_gt_ovf_bound;
wire f4_exp_p0_h_gt_sub_bound;
wire f4_exp_p0_h_gt_udf_bound;
wire f4_exp_p1_d_gt_ovf_bound;
wire f4_exp_p1_d_gt_sub_bound;
wire f4_exp_p1_d_gt_udf_bound;
wire f4_exp_p1_s_gt_ovf_bound;
wire f4_exp_p1_s_gt_sub_bound;
wire f4_exp_p1_s_gt_udf_bound;
wire f4_exp_p1_h_gt_ovf_bound;
wire f4_exp_p1_h_gt_sub_bound;
wire f4_exp_p1_h_gt_udf_bound;
wire f4_dp_of_exception;
wire f4_sp_of_exception;
wire f4_hp_of_exception;
wire f4_of_exception;
wire f4_dp_uf_exception;
wire f4_sp_uf_exception;
wire f4_hp_uf_exception;
wire f4_uf_exception;
wire f4_dp_subnorm;
wire f4_sp_subnorm;
wire f4_hp_subnorm;
wire f4_subnorm;
wire f4_subnorm_to_normal;
wire f4_frac_all_zero;
wire f4_frd_largest;
wire f4_frd_smallest;
wire f4_frd_qnan_hp;
wire f4_frd_qnan_sp;
wire f4_frd_qnan_dp;
wire f4_frd_inf_hp;
wire f4_frd_inf_sp;
wire f4_frd_inf_dp;
wire f4_frd_zero_hp;
wire f4_frd_zero_sp;
wire f4_frd_zero_dp;
wire f4_frd_largest_hp;
wire f4_frd_largest_sp;
wire f4_frd_largest_dp;
wire f4_frd_smallest_hp;
wire f4_frd_smallest_sp;
wire f4_frd_smallest_dp;
wire f4_uf_to_subnorm;
wire f4_subnorm_to_norm_cond;
wire [2:0] f4_round_bits_as_normal;
wire f4_subnorm_to_norm_uf;
wire f4_exp_is_subnorm;
wire [EXP_MSB:0] f4_adjust_exp;
wire f4_wdata_en;
wire [1:0] f4_result_type;
wire [4:0] f4_flag_set;
wire [63:0] f4_wdata;
wire unused2;
wire unused3;
wire unused4;
wire unused6;
wire unused7;
wire unused8;
wire unused9;
wire unused10;
wire unused11;
assign fmac_standby_ready = ~f1_valid & ~f2_valid & ~f3_valid & ~f4_valid;
wire f1_sew16 = f1_sew[0];
wire f1_sew32 = f1_sew[1];
wire f1_sew64 = f1_sew[2] && (FLEN >= 64);
assign f1_frd_hp = (f1_sew16 & ~f1_op_wide);
assign f1_frd_sp = (f1_sew32 & ((FLEN == 32) | ~f1_op_wide)) | (f1_sew16 & f1_op_wide);
assign f1_frd_dp = (f1_sew64 & ((FLEN == 64) | ~f1_op_wide)) | (f1_sew32 & f1_op_wide & (FLEN >= 64));
wire f1_vadd_instr = 1'b0;
wire f1_vsub_instr = 1'b0;
wire f1_vmadd_instr = 1'b0;
wire f1_vmsub_instr = 1'b0;
wire f1_vnmadd_instr = 1'b0;
wire f1_vnmsub_instr = 1'b0;
wire f1_vmul_instr = 1'b0;
wire f1_vfsubvf_instr = 1'b0;
wire f1_vfwsubw_instr = 1'b0;
wire f1_fadd_instr = (f1_ex_ctrl[4:0] == 5'b01100);
wire f1_fsub_instr = (f1_ex_ctrl[4:0] == 5'b01101);
wire f1_fmadd_instr = (f1_ex_ctrl[4:0] == 5'b01000);
wire f1_fmsub_instr = (f1_ex_ctrl[4:0] == 5'b01010);
wire f1_fnmadd_instr = (f1_ex_ctrl[4:0] == 5'b01001);
wire f1_fnmsub_instr = (f1_ex_ctrl[4:0] == 5'b01011);
wire f1_fmul_instr = (f1_ex_ctrl[4:0] == 5'b01110);
wire f1_add_instr = f1_fadd_instr | f1_vadd_instr;
wire f1_sub_instr = f1_fsub_instr | f1_vsub_instr;
wire f1_mul_instr = f1_fmul_instr | f1_vmul_instr;
wire f1_madd_instr = f1_fmadd_instr | f1_vmadd_instr | f1_add_instr | f1_mul_instr;
wire f1_msub_instr = f1_fmsub_instr | f1_vmsub_instr | f1_sub_instr;
wire f1_nmadd_instr = f1_fnmadd_instr | f1_vnmadd_instr;
wire f1_nmsub_instr = f1_fnmsub_instr | f1_vnmsub_instr;
wire f1_frd_scalar_fp = f1_fadd_instr | f1_fsub_instr | f1_fmadd_instr | f1_fmsub_instr | f1_fnmadd_instr | f1_fnmsub_instr | f1_fmul_instr;
wire f1_op1_h_sign = f1_op1_data[15];
wire [4:0] f1_op1_h_exp = f1_op1_data[14:10];
wire [9:0] f1_op1_h_frac = f1_op1_data[9:0];
wire f1_op2_h_sign = f1_op2_data[15];
wire [4:0] f1_op2_h_exp = f1_op2_data[14:10];
wire [9:0] f1_op2_h_frac = f1_op2_data[9:0];
wire f1_op3_h_sign = f1_op3_data[15];
wire [4:0] f1_op3_h_exp = f1_op3_data[14:10];
wire [9:0] f1_op3_h_frac = f1_op3_data[9:0];
wire f1_op1_s_sign = f1_op1_data[31];
wire [7:0] f1_op1_s_exp = f1_op1_data[30:23];
wire [22:0] f1_op1_s_frac = f1_op1_data[22:0];
wire f1_op2_s_sign = f1_op2_data[31];
wire [7:0] f1_op2_s_exp = f1_op2_data[30:23];
wire [22:0] f1_op2_s_frac = f1_op2_data[22:0];
wire f1_op3_s_sign = f1_op3_data[31];
wire [7:0] f1_op3_s_exp = f1_op3_data[30:23];
wire [22:0] f1_op3_s_frac = f1_op3_data[22:0];
wire f1_op1_d_sign = f1_op1_data[63];
wire [10:0] f1_op1_d_exp = f1_op1_data[62:52];
wire [51:0] f1_op1_d_frac = f1_op1_data[51:0];
wire f1_op2_d_sign = f1_op2_data[63];
wire [10:0] f1_op2_d_exp = f1_op2_data[62:52];
wire [51:0] f1_op2_d_frac = f1_op2_data[51:0];
wire f1_op3_d_sign = f1_op3_data[63];
wire [10:0] f1_op3_d_exp = f1_op3_data[62:52];
wire [51:0] f1_op3_d_frac = f1_op3_data[51:0];
wire f1_op1_nanbox_check = lane_pipe_id0 & f1_frd_scalar_fp;
wire f1_op2_nanbox_check = lane_pipe_id0 & f1_frd_scalar_fp & ~(f1_fadd_instr | f1_fsub_instr);
wire f1_op3_nanbox_check = lane_pipe_id0 & f1_frd_scalar_fp & ~(f1_fmul_instr);
wire f1_op1_nanbox_fail = f1_op1_nanbox_check & ((f1_op1_sp & ~(&f1_op1_data[63:32]) & (FLEN == 64)) | (f1_op1_hp & ~(&f1_op1_data[63:16])));
wire f1_op2_nanbox_fail = f1_op2_nanbox_check & ((f1_op2_sp & ~(&f1_op2_data[63:32]) & (FLEN == 64)) | (f1_op2_hp & ~(&f1_op2_data[63:16])));
wire f1_op3_nanbox_fail = f1_op3_nanbox_check & ((f1_op3_sp & ~(&f1_op3_data[63:32]) & (FLEN == 64)) | (f1_op3_hp & ~(&f1_op3_data[63:16])));
wire f1_op1_exp_all1 = (f1_op1_dp & (&f1_op1_d_exp)) | (f1_op1_sp & (&f1_op1_s_exp)) | (f1_op1_hp & (&f1_op1_h_exp));
wire f1_op2_exp_all1 = (f1_op2_dp & (&f1_op2_d_exp)) | (f1_op2_sp & (&f1_op2_s_exp)) | (f1_op2_hp & (&f1_op2_h_exp));
wire f1_op3_exp_all1 = (f1_op3_dp & (&f1_op3_d_exp)) | (f1_op3_sp & (&f1_op3_s_exp)) | (f1_op3_hp & (&f1_op3_h_exp));
wire f1_op1_exp_all0 = (f1_op1_dp & ~(|f1_op1_d_exp)) | (f1_op1_sp & ~(|f1_op1_s_exp)) | (f1_op1_hp & ~(|f1_op1_h_exp));
wire f1_op2_exp_all0 = (f1_op2_dp & ~(|f1_op2_d_exp)) | (f1_op2_sp & ~(|f1_op2_s_exp)) | (f1_op2_hp & ~(|f1_op2_h_exp));
wire f1_op3_exp_all0 = (f1_op3_dp & ~(|f1_op3_d_exp)) | (f1_op3_sp & ~(|f1_op3_s_exp)) | (f1_op3_hp & ~(|f1_op3_h_exp));
wire f1_op1_frac_all0 = (f1_op1_dp & ~(|f1_op1_d_frac)) | (f1_op1_sp & ~(|f1_op1_s_frac)) | (f1_op1_hp & ~(|f1_op1_h_frac));
wire f1_op2_frac_all0 = (f1_op2_dp & ~(|f1_op2_d_frac)) | (f1_op2_sp & ~(|f1_op2_s_frac)) | (f1_op2_hp & ~(|f1_op2_h_frac));
wire f1_op3_frac_all0 = (f1_op3_dp & ~(|f1_op3_d_frac)) | (f1_op3_sp & ~(|f1_op3_s_frac)) | (f1_op3_hp & ~(|f1_op3_h_frac));
wire f1_op1_signaling_bit = (f1_op1_dp & f1_op1_data[51]) | (f1_op1_sp & f1_op1_data[22]) | (f1_op1_hp & f1_op1_data[9]);
wire f1_op2_signaling_bit = (f1_op2_dp & f1_op2_data[51]) | (f1_op2_sp & f1_op2_data[22]) | (f1_op2_hp & f1_op2_data[9]);
wire f1_op3_signaling_bit = (f1_op3_dp & f1_op3_data[51]) | (f1_op3_sp & f1_op3_data[22]) | (f1_op3_hp & f1_op3_data[9]);
wire f1_op1_is_inf = f1_op1_exp_all1 & f1_op1_frac_all0 & ~f1_op1_nanbox_fail;
wire f1_op2_is_inf = f1_op2_exp_all1 & f1_op2_frac_all0 & ~f1_op2_nanbox_fail;
wire f1_op3_is_inf = f1_op3_exp_all1 & f1_op3_frac_all0 & ~f1_op3_nanbox_fail;
wire f1_op1_is_nan = (f1_op1_exp_all1 & ~f1_op1_frac_all0) | f1_op1_nanbox_fail;
wire f1_op2_is_nan = (f1_op2_exp_all1 & ~f1_op2_frac_all0) | f1_op2_nanbox_fail;
wire f1_op3_is_nan = (f1_op3_exp_all1 & ~f1_op3_frac_all0) | f1_op3_nanbox_fail;
wire f1_op1_is_snan = f1_op1_is_nan & ~f1_op1_signaling_bit & ~f1_op1_nanbox_fail;
wire f1_op2_is_snan = f1_op2_is_nan & ~f1_op2_signaling_bit & ~f1_op2_nanbox_fail;
wire f1_op3_is_snan = f1_op3_is_nan & ~f1_op3_signaling_bit & ~f1_op3_nanbox_fail;
wire f1_op1_is_zero = f1_op1_exp_all0 & f1_op1_frac_all0 & ~f1_op1_nanbox_fail;
wire f1_op2_is_zero = f1_op2_exp_all0 & f1_op2_frac_all0 & ~f1_op2_nanbox_fail;
wire f1_op3_is_zero = f1_op3_exp_all0 & f1_op3_frac_all0 & ~f1_op3_nanbox_fail;
assign f1_op1_sign = ((f1_op1_dp & f1_op1_d_sign) | (f1_op1_sp & f1_op1_s_sign) | (f1_op1_hp & f1_op1_h_sign)) ^ (f1_vfwsubw_instr | f1_vfsubvf_instr);
assign f1_op2_sign = ((f1_op2_dp & f1_op2_d_sign) | (f1_op2_sp & f1_op2_s_sign) | (f1_op2_hp & f1_op2_h_sign));
assign f1_op3_sign = ((f1_op3_dp & f1_op3_d_sign) | (f1_op3_sp & f1_op3_s_sign) | (f1_op3_hp & f1_op3_h_sign)) ^ (f1_vfwsubw_instr | f1_vfsubvf_instr);
assign f1_mul_sign = f1_op1_sign ^ f1_op2_sign ^ (f1_nmadd_instr | f1_nmsub_instr);
assign f1_eff_sub = (f1_mul_sign ^ f1_op3_sign ^ (f1_msub_instr | f1_nmadd_instr));
wire f1_mul_to_inf = f1_op1_is_inf & ~(f1_op2_is_zero | f1_op2_is_nan) | f1_op2_is_inf & ~(f1_op1_is_zero | f1_op1_is_nan);
wire f1_mul_to_zero = f1_op1_is_zero & ~(f1_op2_is_inf | f1_op2_is_nan) | f1_op2_is_zero & ~(f1_op1_is_inf | f1_op1_is_nan);
wire f1_mul_to_nan = (f1_op1_is_nan | f1_op2_is_nan) | (f1_op1_is_inf & f1_op2_is_zero) | (f1_op2_is_inf & f1_op1_is_zero);
wire f1_mul_to_nv_exc = (f1_op1_is_snan | f1_op2_is_snan) | (f1_op1_is_inf & f1_op2_is_zero) | (f1_op2_is_inf & f1_op1_is_zero);
assign f1_frd_zero = f1_mul_to_zero & f1_op3_is_zero;
assign f1_frd_inf = (f1_mul_to_inf & ~f1_op3_is_nan & ~(f1_op3_is_inf & f1_eff_sub)) | (f1_op3_is_inf & ~f1_mul_to_nan & ~(f1_mul_to_inf & f1_eff_sub));
assign f1_frd_qnan = (f1_mul_to_nan | f1_op3_is_nan) | (f1_mul_to_inf & f1_op3_is_inf & f1_eff_sub);
assign f1_nv_exception = (f1_mul_to_nv_exc | f1_op3_is_snan) | (f1_mul_to_inf & f1_op3_is_inf & f1_eff_sub);
assign f1_frd_zero_sign = (f1_mul_instr & f1_mul_sign) | (f1_madd_instr & f1_mul_sign & f1_op3_sign) | (f1_nmadd_instr & f1_mul_sign & ~f1_op3_sign) | (f1_msub_instr & f1_mul_sign & ~f1_op3_sign) | (f1_nmsub_instr & f1_mul_sign & f1_op3_sign) | (f1_eff_sub & (f1_round_mode == ROUND_RDN));
assign f1_frd_inf_sign = (f1_madd_instr & (f1_op3_is_inf ? f1_op3_sign : f1_mul_sign)) | (f1_nmadd_instr & (f1_op3_is_inf ? ~f1_op3_sign : f1_mul_sign)) | (f1_msub_instr & (f1_op3_is_inf ? ~f1_op3_sign : f1_mul_sign)) | (f1_nmsub_instr & (f1_op3_is_inf ? f1_op3_sign : f1_mul_sign));
assign f1_op1_exp = ({EXP_WIDTH{f1_op1_dp}} & ({2'b0,f1_op1_d_exp} | {12'b0,~|f1_op1_d_exp})) | ({EXP_WIDTH{f1_op1_sp}} & ({5'b0,f1_op1_s_exp} | {12'b0,~|f1_op1_s_exp})) | ({EXP_WIDTH{f1_op1_hp}} & ({8'b0,f1_op1_h_exp} | {12'b0,~|f1_op1_h_exp}));
assign f1_op2_exp = ({EXP_WIDTH{f1_op2_dp}} & ({2'b0,f1_op2_d_exp} | {12'b0,~|f1_op2_d_exp})) | ({EXP_WIDTH{f1_op2_sp}} & ({5'b0,f1_op2_s_exp} | {12'b0,~|f1_op2_s_exp})) | ({EXP_WIDTH{f1_op2_hp}} & ({8'b0,f1_op2_h_exp} | {12'b0,~|f1_op2_h_exp}));
assign f1_op3_exp = ({EXP_WIDTH{f1_op3_dp}} & ({2'b0,f1_op3_d_exp} | {12'b0,~|f1_op3_d_exp})) | ({EXP_WIDTH{f1_op3_sp}} & ({5'b0,f1_op3_s_exp} | {12'b0,~|f1_op3_s_exp})) | ({EXP_WIDTH{f1_op3_hp}} & ({8'b0,f1_op3_h_exp} | {12'b0,~|f1_op3_h_exp}));
assign f1_op1_frac = ({53{f1_op1_dp}} & ({|f1_op1_d_exp,f1_op1_d_frac})) | ({53{f1_op1_sp}} & ({|f1_op1_s_exp,f1_op1_s_frac,29'b0})) | ({53{f1_op1_hp}} & ({|f1_op1_h_exp,f1_op1_h_frac,42'b0}));
assign f1_op2_frac = ({53{f1_op2_dp}} & ({|f1_op2_d_exp,f1_op2_d_frac})) | ({53{f1_op2_sp}} & ({|f1_op2_s_exp,f1_op2_s_frac,29'b0})) | ({53{f1_op2_hp}} & ({|f1_op2_h_exp,f1_op2_h_frac,42'b0}));
assign f1_op3_frac = ({53{f1_frd_dp & f1_op3_dp}} & ({|f1_op3_d_exp,f1_op3_d_frac})) | ({53{f1_frd_dp & f1_op3_sp}} & ({|f1_op3_s_exp,f1_op3_s_frac,29'b0})) | ({53{f1_frd_sp & f1_op3_sp}} & ({29'b0,|f1_op3_s_exp,f1_op3_s_frac})) | ({53{f1_frd_sp & f1_op3_hp}} & ({29'b0,|f1_op3_h_exp,f1_op3_h_frac,13'b0})) | ({53{f1_frd_hp & f1_op3_hp}} & ({42'b0,|f1_op3_h_exp,f1_op3_h_frac}));
assign f2_eff_sub_nx = f1_eff_sub & ~f1_frd_inf;
assign f1_arith_sign = f1_frd_zero ? f1_frd_zero_sign : f1_frd_inf ? f1_frd_inf_sign : f1_mul_sign;
kv_csa4_2 #(
    .CSA_WIDTH(EXP_MSB + 1)
) align_amount_csa (
    .in1(~f1_op3_exp),
    .in2(f1_op1_exp),
    .in3(f1_op2_exp),
    .in4({{(EXP_MSB - 11 + 1){f1_align_amount_adjustment[10]}},f1_align_amount_adjustment}),
    .sum(f1_align_amount_sum),
    .carry(f1_align_amount_carry)
);
assign {f1_align_amount} = {f1_align_amount_carry[EXP_MSB - 1:0],1'b0} + {f1_align_amount_sum[EXP_MSB:0]};
assign f1_mul_is_zero = f1_op1_is_zero | f1_op2_is_zero;
assign f1_pre_lsh_frac = {MAC_WIDTH{f1_eff_sub}} ^ ({1'b0,f1_op3_frac,110'b0});
wire f1_op3_is_subnorm_fixed_width = (f1_op3_dp & ((f1_op3_d_exp == 11'b0) | ((f1_op3_d_exp == 11'b1) & f1_eff_sub))) | (f1_op3_sp & ((f1_op3_s_exp == 8'b0) | ((f1_op3_s_exp == 8'b1) & f1_eff_sub)) & f1_frd_sp) | (f1_op3_hp & ((f1_op3_h_exp == 5'b0) | ((f1_op3_h_exp == 5'b1) & f1_eff_sub)) & f1_frd_hp);
wire f1_op3_is_subnorm_widening = (f1_op3_sp & (f1_op3_s_exp == 8'b0) & f1_frd_dp) | (f1_op3_hp & (f1_op3_h_exp == 5'b0) & f1_frd_sp);
assign f1_align_amount_zero = (f1_align_amount[EXP_MSB] | f1_mul_is_zero) & ~f1_op3_is_subnorm_widening;
assign f1_align_amount_gt255 = ~f1_mul_is_zero & ~f1_align_amount[EXP_MSB] & (|f1_align_amount[(EXP_MSB - 1):8]);
assign f1_op3_lzc_data = {1'b0,({{23{f1_op3_sp}} & f1_op3_data[22:0]}) | ({{10{f1_op3_hp}} & f1_op3_data[9:0],13'b0})};
assign f1_op3_lzc[4] = ~|f1_op3_data[23 -:16];
assign f1_op3_lzc[3] = (f1_op3_lzc[4:4] == 1'b0) ? ~|f1_op3_lzc_data[23 -:8] : 1'b0;
assign f1_op3_lzc[2] = (f1_op3_lzc[4:3] == 2'h0) ? ~|f1_op3_lzc_data[23 -:4] : (f1_op3_lzc[4:3] == 2'h1) ? ~|f1_op3_lzc_data[15 -:4] : (f1_op3_lzc[4:3] == 2'h2) ? ~|f1_op3_lzc_data[7 -:4] : 1'b0;
assign f1_op3_lzc[1] = (f1_op3_lzc[4:2] == 3'h0) ? ~|f1_op3_lzc_data[23 -:2] : (f1_op3_lzc[4:2] == 3'h1) ? ~|f1_op3_lzc_data[19 -:2] : (f1_op3_lzc[4:2] == 3'h2) ? ~|f1_op3_lzc_data[15 -:2] : (f1_op3_lzc[4:2] == 3'h3) ? ~|f1_op3_lzc_data[11 -:2] : (f1_op3_lzc[4:2] == 3'h4) ? ~|f1_op3_lzc_data[7 -:2] : (f1_op3_lzc[4:2] == 3'h5) ? ~|f1_op3_lzc_data[3 -:2] : 1'b0;
assign f1_op3_lzc_data_l1 = ~f1_op3_lzc[4] ? f1_op3_lzc_data[23 -:16] : {f1_op3_lzc_data[23 - 16:0],8'b0};
assign f1_op3_lzc_data_l2 = ~f1_op3_lzc[3] ? f1_op3_lzc_data_l1[15 -:8] : f1_op3_lzc_data_l1[7 -:8];
assign f1_op3_lzc_data_l3 = ~f1_op3_lzc[2] ? f1_op3_lzc_data_l2[7 -:4] : f1_op3_lzc_data_l2[3 -:4];
assign f1_op3_lzc_data_l4 = ~f1_op3_lzc[1] ? f1_op3_lzc_data_l3[3 -:2] : f1_op3_lzc_data_l3[1 -:2];
assign f1_op3_lzc[0] = ~f1_op3_lzc_data_l4[1];
assign f1_op3_lzc_subnorm = {5{f1_op3_is_subnorm_widening}} & f1_op3_lzc;
assign f1_lzc_align_diff_gt2 = (f1_align_amount_zero ? 7'b0 : f1_align_amount[6:0]) + {6'b0,f1_eff_sub & ~f1_op3_is_subnorm_fixed_width} + {2'b0,f1_op3_lzc_subnorm};
assign f1_align_l0 = (f1_align_amount[0]) ? {{1{f1_eff_sub}},f1_pre_lsh_frac[MAC_MSB:(MAC_LSB + 1)]} : f1_pre_lsh_frac;
assign f1_align_l1 = (f1_align_amount[1]) ? {{2{f1_eff_sub}},f1_align_l0[MAC_MSB:(MAC_LSB + 2)]} : f1_align_l0;
assign f1_align_l2 = (f1_align_amount[2]) ? {{4{f1_eff_sub}},f1_align_l1[MAC_MSB:(MAC_LSB + 4)]} : f1_align_l1;
assign f1_align_l3 = (f1_align_amount[3]) ? {{8{f1_eff_sub}},f1_align_l2[MAC_MSB:(MAC_LSB + 8)]} : f1_align_l2;
assign f1_align_l4 = (f1_align_amount[4]) ? {{16{f1_eff_sub}},f1_align_l3[MAC_MSB:(MAC_LSB + 16)]} : f1_align_l3;
assign f1_align_l5 = (f1_align_amount[5]) ? {{32{f1_eff_sub}},f1_align_l4[MAC_MSB:(MAC_LSB + 32)]} : f1_align_l4;
assign f2_align_l5_nx = {MAC_WIDTH{f1_align_amount_gt255}} & {MAC_WIDTH{f1_eff_sub}} | {MAC_WIDTH{f1_align_amount_zero}} & f1_pre_lsh_frac | {MAC_WIDTH{~f1_align_amount_gt255 & ~f1_align_amount_zero}} & f1_align_l5;
assign f2_align_sticky_partial_nx = f1_align_amount_gt255 & ~f1_op3_is_zero;
assign f2_align_amount_nx = {2{~f1_align_amount_zero}} & f1_align_amount[7:6];
assign f2_align_l6 = f2_align_amount[7] ? {{128{f2_eff_sub}},f2_align_l5[MAC_MSB:(MAC_LSB + 128)]} : f2_align_l5;
assign f2_align_final = f2_align_amount[6] ? {{64{f2_eff_sub}},f2_align_l6[MAC_MSB:(MAC_LSB + 64)]} : f2_align_l6;
assign f2_align_sticky_l6 = (f2_align_amount[7]) & (|({128{f2_eff_sub}} ^ f2_align_l5[(MAC_LSB + 127):MAC_LSB]));
assign f2_align_sticky_l7 = (f2_align_amount[6]) & (|({64{f2_eff_sub}} ^ f2_align_l6[(MAC_LSB + 63):MAC_LSB]));
assign f2_align_sticky = |{f2_align_sticky_partial,f2_align_sticky_l6,f2_align_sticky_l7};
assign f1_op3_exp_wo_bias = f1_op3_exp - (({EXP_WIDTH{f1_op3_dp}} & DP_BIAS) | ({EXP_WIDTH{f1_op3_sp}} & SP_BIAS) | ({EXP_WIDTH{f1_op3_hp}} & HP_BIAS));
assign f1_mul_exp_wo_bias = f1_op1_exp + f1_op2_exp - (({EXP_WIDTH{f1_op1_dp}} & DP_2X_BIAS) | ({EXP_WIDTH{f1_op1_sp}} & SP_2X_BIAS) | ({EXP_WIDTH{f1_op1_hp}} & HP_2X_BIAS));
assign f1_align_diff_gt2 = ((f1_frd_dp & ((f1_align_amount + {8'b0,f1_op3_lzc_subnorm}) < 14'd54)) | (f1_frd_sp & ((f1_align_amount + {8'b0,f1_op3_lzc_subnorm}) < 14'd25)) | (f1_frd_hp & ((f1_align_amount) < 13'd12))) | f1_align_amount_zero;
assign f2_mac_exp_nx = ({EXP_WIDTH{f1_align_diff_gt2}} & (f1_op3_exp_wo_bias + {13{f1_eff_sub | f1_op3_is_subnorm_fixed_width}})) | ({EXP_WIDTH{~f1_align_diff_gt2}} & (f1_mul_exp_wo_bias + 13'h2));
assign f2_frd_subnorm_nx = f1_align_diff_gt2 & f1_op3_is_subnorm_fixed_width;
assign {f1_ci_x0,f1_pp_x0} = pp_encode(f1_op1_frac[51:0], {f1_op2_frac[1:0],1'b0});
assign {f1_ci_x2,f1_pp_x2} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[3:1]);
assign {f1_ci_x4,f1_pp_x4} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[5:3]);
assign {f1_ci_x6,f1_pp_x6} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[7:5]);
assign {f1_ci_x8,f1_pp_x8} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[9:7]);
assign {f1_ci_x10,f1_pp_x10} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[11:9]);
assign {f1_ci_x12,f1_pp_x12} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[13:11]);
assign {f1_ci_x14,f1_pp_x14} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[15:13]);
assign {f1_ci_x16,f1_pp_x16} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[17:15]);
assign {f1_ci_x18,f1_pp_x18} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[19:17]);
assign {f1_ci_x20,f1_pp_x20} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[21:19]);
assign {f1_ci_x22,f1_pp_x22} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[23:21]);
assign {f1_ci_x24,f1_pp_x24} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[25:23]);
assign {f1_ci_x26,f1_pp_x26} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[27:25]);
assign {f1_ci_x28,f1_pp_x28} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[29:27]);
assign {f1_ci_x30,f1_pp_x30} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[31:29]);
assign {f1_ci_x32,f1_pp_x32} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[33:31]);
assign {f1_ci_x34,f1_pp_x34} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[35:33]);
assign {f1_ci_x36,f1_pp_x36} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[37:35]);
assign {f1_ci_x38,f1_pp_x38} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[39:37]);
assign {f1_ci_x40,f1_pp_x40} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[41:39]);
assign {f1_ci_x42,f1_pp_x42} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[43:41]);
assign {f1_ci_x44,f1_pp_x44} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[45:43]);
assign {f1_ci_x46,f1_pp_x46} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[47:45]);
assign {f1_ci_x48,f1_pp_x48} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[49:47]);
assign {f1_ci_x50,f1_pp_x50} = pp_encode(f1_op1_frac[51:0], f1_op2_frac[51:49]);
assign {f1_ci_x52,f1_pp_x52} = pp_encode(f1_op1_frac[51:0], {2'b0,f1_op2_frac[51]});
assign f1_pp_cin = {{26{2'b01}},1'b1,1'b0,1'b0,f1_ci_x50,1'b0,f1_ci_x48,1'b0,f1_ci_x46,1'b0,f1_ci_x44,1'b0,f1_ci_x42,1'b0,f1_ci_x40,1'b0,f1_ci_x38,1'b0,f1_ci_x36,1'b0,f1_ci_x34,1'b0,f1_ci_x32,1'b0,f1_ci_x30,1'b0,f1_ci_x28,1'b0,f1_ci_x26,1'b0,f1_ci_x24,1'b0,f1_ci_x22,1'b0,f1_ci_x20,1'b0,f1_ci_x18,1'b0,f1_ci_x16,1'b0,f1_ci_x14,1'b0,f1_ci_x12,1'b0,f1_ci_x10,1'b0,f1_ci_x8,1'b0,f1_ci_x6,1'b0,f1_ci_x4,1'b0,f1_ci_x2,1'b0,f1_ci_x0};
assign f1_pp_ay = {1'b0,1'b0,{52{f1_op1_frac[52]}} & f1_op2_frac[51:0],52'b0};
assign f1_pp_ab_bx = {1'b0,f1_op1_frac[52] & f1_op2_frac[52],{52{f1_op2_frac[52]}} & f1_op1_frac[51:0],52'b0};
kv_csa4_2 #(
    .CSA_WIDTH(106)
) csa4_2_l1_0 (
    .in1({52'b0,f1_pp_x0}),
    .in2({50'b0,f1_pp_x2,2'b0}),
    .in3({48'b0,f1_pp_x4,4'b0}),
    .in4({46'b0,f1_pp_x6,6'b0}),
    .sum(f1_s0_l1),
    .carry(f1_c0_l1)
);
kv_csa4_2 #(
    .CSA_WIDTH(106)
) csa4_2_l1_1 (
    .in1({44'b0,f1_pp_x8,8'b0}),
    .in2({42'b0,f1_pp_x10,10'b0}),
    .in3({40'b0,f1_pp_x12,12'b0}),
    .in4({38'b0,f1_pp_x14,14'b0}),
    .sum(f1_s1_l1),
    .carry(f1_c1_l1)
);
kv_csa4_2 #(
    .CSA_WIDTH(106)
) csa4_2_l1_2 (
    .in1({36'b0,f1_pp_x16,16'b0}),
    .in2({34'b0,f1_pp_x18,18'b0}),
    .in3({32'b0,f1_pp_x20,20'b0}),
    .in4({30'b0,f1_pp_x22,22'b0}),
    .sum(f1_s2_l1),
    .carry(f1_c2_l1)
);
kv_csa4_2 #(
    .CSA_WIDTH(106)
) csa4_2_l1_3 (
    .in1({28'b0,f1_pp_x24,24'b0}),
    .in2({26'b0,f1_pp_x26,26'b0}),
    .in3({24'b0,f1_pp_x28,28'b0}),
    .in4({22'b0,f1_pp_x30,30'b0}),
    .sum(f1_s3_l1),
    .carry(f1_c3_l1)
);
kv_csa4_2 #(
    .CSA_WIDTH(106)
) csa4_2_l1_4 (
    .in1({20'b0,f1_pp_x32,32'b0}),
    .in2({18'b0,f1_pp_x34,34'b0}),
    .in3({16'b0,f1_pp_x36,36'b0}),
    .in4({14'b0,f1_pp_x38,38'b0}),
    .sum(f1_s4_l1),
    .carry(f1_c4_l1)
);
kv_csa4_2 #(
    .CSA_WIDTH(106)
) csa4_2_l1_5 (
    .in1({12'b0,f1_pp_x40,40'b0}),
    .in2({10'b0,f1_pp_x42,42'b0}),
    .in3({8'b0,f1_pp_x44,44'b0}),
    .in4({6'b0,f1_pp_x46,46'b0}),
    .sum(f1_s5_l1),
    .carry(f1_c5_l1)
);
kv_csa4_2 #(
    .CSA_WIDTH(106)
) csa4_2_l1_6 (
    .in1({4'b0,f1_pp_x48,48'b0}),
    .in2({2'b0,f1_pp_x50,50'b0}),
    .in3({f1_pp_x52,52'b0}),
    .in4({f1_pp_cin}),
    .sum(f1_s6_l1),
    .carry(f1_c6_l1)
);
kv_csa4_2 #(
    .CSA_WIDTH(106)
) csa4_2_l2_0 (
    .in1({f1_c0_l1[104:0],1'b0}),
    .in2(f1_s0_l1[105:0]),
    .in3({f1_c1_l1[104:0],1'b0}),
    .in4(f1_s1_l1[105:0]),
    .sum(f1_s0_l2),
    .carry(f1_c0_l2)
);
kv_csa4_2 #(
    .CSA_WIDTH(106)
) csa4_2_l2_1 (
    .in1({f1_c2_l1[104:0],1'b0}),
    .in2(f1_s2_l1[105:0]),
    .in3({f1_c3_l1[104:0],1'b0}),
    .in4(f1_s3_l1[105:0]),
    .sum(f1_s1_l2),
    .carry(f1_c1_l2)
);
kv_csa4_2 #(
    .CSA_WIDTH(106)
) csa4_2_l2_2 (
    .in1({f1_c4_l1[104:0],1'b0}),
    .in2(f1_s4_l1[105:0]),
    .in3({f1_c5_l1[104:0],1'b0}),
    .in4(f1_s5_l1[105:0]),
    .sum(f1_s2_l2),
    .carry(f1_c2_l2)
);
kv_csa4_2 #(
    .CSA_WIDTH(106)
) csa4_2_l2_3 (
    .in1({f1_c6_l1[104:0],1'b0}),
    .in2(f1_s6_l1[105:0]),
    .in3({f1_pp_ay}),
    .in4(f1_pp_ab_bx[105:0]),
    .sum(f1_s3_l2),
    .carry(f1_c3_l2)
);
kv_csa4_2 #(
    .CSA_WIDTH(107)
) csa4_2_l3_0 (
    .in1({f1_c0_l2,1'b0}),
    .in2(f1_s0_l2),
    .in3({f1_c1_l2,1'b0}),
    .in4(f1_s1_l2),
    .sum({unused6,f1_s0_l3}),
    .carry({unused7,f1_c0_l3})
);
kv_csa4_2 #(
    .CSA_WIDTH(107)
) csa4_2_l3_1 (
    .in1({f1_c2_l2,1'b0}),
    .in2(f1_s2_l2),
    .in3({f1_c3_l2,1'b0}),
    .in4(f1_s3_l2),
    .sum({unused8,f1_s1_l3}),
    .carry({unused9,f1_c1_l3})
);
kv_csa4_2 #(
    .CSA_WIDTH(107)
) csa4_2_l4_0 (
    .in1({f2_c0_l3,1'b0}),
    .in2(f2_s0_l3),
    .in3({f2_c1_l3,1'b0}),
    .in4(f2_s1_l3),
    .sum({unused10,f2_mul_sum}),
    .carry({unused11,f2_mul_carry})
);
kv_csa3_2 #(
    .CSA_WIDTH(MAC_WIDTH)
) mac_csa (
    .in0({{55{1'b0}},f2_mul_sum[106] | f2_mul_carry[105],f2_mul_carry[104:0],3'b0}),
    .in1({{55{1'b1}},1'b1,f2_mul_sum[105:0],2'b0}),
    .cin({f2_align_final[MAC_MSB:MAC_LSB]}),
    .sum(f2_sum),
    .cout({unused2,f2_carry[MAC_MSB:MAC_LSB + 1]})
);
assign f2_carry[MAC_LSB] = f2_eff_sub & ~f2_align_sticky;
assign f2_complement = f2_eff_sub & ((~f2_carry[MAC_MSB:MAC_LSB + 1] > f2_sum[MAC_MSB:MAC_LSB + 1]));
assign f2_eff_add_a_str = f2_sum[LZA_MSB:LZA_LSB] | f2_carry[LZA_MSB:LZA_LSB];
assign f2_eff_add_p_str = f2_sum[LZA_MSB + 1:LZA_LSB] ~^ f2_carry[LZA_MSB + 1:LZA_LSB];
assign f2_eff_add_lza_str = {f2_eff_add_p_str[LZA_MSB:LZA_LSB + 1] & f2_eff_add_a_str[LZA_MSB - 1:LZA_LSB],~f2_eff_add_p_str[LZA_LSB]} | {f2_eff_add_p_str[LZA_MSB + 1] & f2_eff_add_a_str[LZA_MSB],{(LZA_MSB - LZA_LSB){1'b0}}};
assign f2_eff_sub_e_str = f2_sum[LZA_MSB:LZA_LSB] ^ f2_carry[LZA_MSB:LZA_LSB];
assign f2_eff_sub_g_str = ~f2_sum[LZA_MSB:LZA_LSB] & ~f2_carry[LZA_MSB:LZA_LSB];
assign f2_eff_sub_s_str = f2_sum[LZA_MSB:LZA_LSB] & f2_carry[LZA_MSB:LZA_LSB];
assign f2_eff_sub_pos_str = ({1'b1,f2_eff_sub_e_str[LZA_MSB:LZA_LSB + 1]} & f2_eff_sub_g_str[LZA_MSB:LZA_LSB] & {~f2_eff_sub_s_str[LZA_MSB - 1:LZA_LSB],1'b1}) | ({1'b0,~f2_eff_sub_e_str[LZA_MSB:LZA_LSB + 1]} & f2_eff_sub_s_str[LZA_MSB:LZA_LSB] & {~f2_eff_sub_s_str[LZA_MSB - 1:LZA_LSB],1'b1});
assign f2_eff_sub_neg_str = ({1'b1,f2_eff_sub_e_str[LZA_MSB:LZA_LSB + 1]} & f2_eff_sub_s_str[LZA_MSB:LZA_LSB] & {~f2_eff_sub_g_str[LZA_MSB - 1:LZA_LSB],1'b1}) | ({1'b0,~f2_eff_sub_e_str[LZA_MSB:LZA_LSB + 1]} & f2_eff_sub_g_str[LZA_MSB:LZA_LSB] & {~f2_eff_sub_g_str[LZA_MSB - 1:LZA_LSB],1'b1});
assign f2_eff_sub_lza_str = f2_eff_sub_pos_str | f2_eff_sub_neg_str;
assign f2_lza_str = f2_eff_sub ? f2_eff_sub_lza_str : f2_eff_add_lza_str;
assign f2_lzc_or_l1[0] = ~|f2_lza_str[LZA_MSB -:32];
assign f2_lzc_or_l1[1] = ~|f2_lza_str[LZA_MSB - 64 -:32];
assign f2_lzc_or_l2[0] = ~f2_lzc[6] ? ~|f2_lza_str[LZA_MSB -:16] : ~|f2_lza_str[LZA_MSB - 64 -:16];
assign f2_lzc_or_l2[1] = ~f2_lzc[6] ? ~|f2_lza_str[LZA_MSB - 32 -:16] : 1'b0;
assign f2_lzc_or_l3[0] = ~f2_lzc[6] ? (~f2_lzc[5] ? ~|f2_lza_str[LZA_MSB -:8] : ~|f2_lza_str[LZA_MSB - 32 -:8]) : (~f2_lzc[5] ? ~|f2_lza_str[LZA_MSB - 64 -:8] : ~|f2_lza_str[LZA_MSB - 96 -:8]);
assign f2_lzc_or_l3[1] = ~f2_lzc[6] ? (~f2_lzc[5] ? ~|f2_lza_str[LZA_MSB - 16 -:8] : ~|f2_lza_str[LZA_MSB - 48 -:8]) : (~f2_lzc[5] ? ~|f2_lza_str[LZA_MSB - 80 -:8] : 1'b0);
assign f2_lzc[6] = ~|f2_lza_str[LZA_MSB -:64];
assign f2_lzc[5] = ~f2_lzc[6] ? f2_lzc_or_l1[0] : f2_lzc_or_l1[1];
assign f2_lzc[4] = ~f2_lzc[5] ? f2_lzc_or_l2[0] : f2_lzc_or_l2[1];
assign f2_lzc[3] = ~f2_lzc[4] ? f2_lzc_or_l3[0] : f2_lzc_or_l3[1];
assign f2_lza_str_l1 = ~f2_lzc[6] ? f2_lza_str[LZA_MSB -:64] : {f2_lza_str[LZA_MSB - 64:LZA_LSB],{(128 - LZA_WIDTH){1'b0}}};
assign f2_lza_str_l2 = ~f2_lzc[5] ? f2_lza_str_l1[63 -:32] : f2_lza_str_l1[31 -:32];
assign f2_lza_str_l3 = ~f2_lzc[4] ? f2_lza_str_l2[31 -:16] : f2_lza_str_l2[15 -:16];
assign f3_lzc[6:3] = f3_lzc_msb;
assign f3_lzc[2] = ~f3_lzc[3] ? ~|f3_lza_str[15 -:4] : ~|f3_lza_str[15 - 8 -:4];
assign f3_lzc[1] = ~f3_lzc[2] ? (~f3_lzc[3] ? ~|f3_lza_str[15 -:2] : ~|f3_lza_str[15 - 8 -:2]) : (~f3_lzc[3] ? ~|f3_lza_str[15 - 4 -:2] : ~|f3_lza_str[15 - 12 -:2]);
assign f3_lza_str_l1 = ~f3_lzc[3] ? f3_lza_str[15 -:8] : f3_lza_str[7 -:8];
assign f3_lza_str_l2 = ~f3_lzc[2] ? f3_lza_str_l1[7 -:4] : f3_lza_str_l1[3 -:4];
assign f3_lza_str_l3 = ~f3_lzc[1] ? f3_lza_str_l2[3 -:2] : f3_lza_str_l2[1 -:2];
assign f3_lzc[0] = ~f3_lza_str_l3[1];
assign f2_lzc_eq_subnorm_b6to4 = f2_lzc[6:4] == f2_lzc_subnorm_final[6:4];
assign f2_lzc_gt_subnorm_b6to4 = f2_lzc[6:4] > f2_lzc_subnorm_final[6:4];
assign f2_lzc_final_msb[6:4] = f2_align_diff_gt2 ? f2_lzc_align_diff_gt2[6:4] : f2_lzc_gt_subnorm_b6to4 ? f2_lzc_subnorm_final[6:4] : f2_lzc[6:4];
assign f2_lzc_msb[6:3] = f2_lzc[6:3];
assign f2_lzc_subnorm = f2_mac_exp + (f2_frd_dp ? 13'd1022 : f2_frd_sp ? 13'd126 : 13'd14);
assign f2_lzc_subnorm_final = (f2_align_diff_gt2 | (|f2_lzc_subnorm[12:7])) ? 7'h7f : f2_lzc_subnorm[6:0];
assign {unused3,f2_ha_carry} = {f2_carry[MAC_MSB:MAC_LSB] & f2_sum[MAC_MSB:MAC_LSB],1'b0};
assign {unused4,f2_ha_carry_inv} = {~f2_carry[MAC_MSB:MAC_LSB] & ~f2_sum[MAC_MSB:MAC_LSB],1'b1};
assign f2_ha_sum = {f2_carry[MAC_MSB:MAC_LSB] ^ f2_sum[MAC_MSB:MAC_LSB]};
assign f2_pos_p0 = f2_ha_carry ^ f2_ha_sum;
assign f2_pos_g0 = f2_ha_carry & f2_ha_sum;
assign f2_pos_p1 = f2_pos_p0 & {f2_pos_p0[MAC_MSB - 1:MAC_LSB],1'h1};
assign f2_pos_g1 = f2_pos_g0 | (f2_pos_p0 & {f2_pos_g0[MAC_MSB - 1:MAC_LSB],1'h0});
assign f2_pos_g2 = f2_pos_g1 | (f2_pos_p1 & {f2_pos_g1[MAC_MSB - 2:MAC_LSB],2'h0});
assign f2_neg_p0 = f2_ha_carry_inv ^ f2_ha_sum;
assign f2_neg_g0 = f2_ha_carry_inv & f2_ha_sum;
assign f2_neg_p1 = f2_neg_p0 & {f2_neg_p0[MAC_MSB - 1:MAC_LSB],1'h1};
assign f2_neg_g1 = f2_neg_g0 | (f2_neg_p0 & {f2_neg_g0[MAC_MSB - 1:MAC_LSB],1'h0});
assign f2_neg_g2 = f2_neg_g1 | (f2_neg_p1 & {f2_neg_g1[MAC_MSB - 2:MAC_LSB],2'h0});
assign f2_p0 = f2_complement ? f2_neg_p0 : f2_pos_p0;
assign f2_g2 = f2_complement ? f2_neg_g2 : f2_pos_g2;
assign f3_p_nx = ({MAC_WIDTH{~f2_align_diff_gt2 & f2_frd_dp}} & {f2_p0[LZA_MSB:LZA_LSB],{(MAC_MSB - LZA_MSB){f2_complement}}}) | ({MAC_WIDTH{~f2_align_diff_gt2 & f2_frd_sp}} & {f2_p0[LZA_MSB + 29:LZA_LSB],{(MAC_MSB - LZA_MSB - 29){f2_complement}}}) | ({MAC_WIDTH{~f2_align_diff_gt2 & f2_frd_hp}} & {f2_p0[LZA_MSB + 42:LZA_LSB],{(MAC_MSB - LZA_MSB - 42){f2_complement}}}) | ({MAC_WIDTH{f2_align_diff_gt2}} & {f2_p0});
assign f3_g_nx = ({MAC_WIDTH{~f2_align_diff_gt2 & f2_frd_dp}} & {f2_g2[LZA_MSB:LZA_LSB],{(MAC_MSB - LZA_MSB){1'b0}}}) | ({MAC_WIDTH{~f2_align_diff_gt2 & f2_frd_sp}} & {f2_g2[LZA_MSB + 29:LZA_LSB],{(MAC_MSB - LZA_MSB - 29){1'b0}}}) | ({MAC_WIDTH{~f2_align_diff_gt2 & f2_frd_hp}} & {f2_g2[LZA_MSB + 42:LZA_LSB],{(MAC_MSB - LZA_MSB - 42){1'b0}}}) | ({MAC_WIDTH{f2_align_diff_gt2}} & {f2_g2});
assign f3_arith_sign_nx = f2_arith_sign ^ (f2_complement & ~f2_frd_zero);
assign f3_lzc_sel_subnorm = f3_lzc_gt_subnorm_b6to4 | (f3_lzc_eq_subnorm_b6to4 & (f3_lzc[3:0] > f3_lzc_subnorm[3:0]));
assign f3_lzc_final[6:4] = f3_lzc_final_msb[6:4];
assign f3_lzc_final[3:0] = f3_align_diff_gt2 ? f3_lzc_align_diff_gt2[3:0] : f3_lzc_sel_subnorm ? f3_lzc_subnorm[3:0] : f3_lzc[3:0];
assign f4_mac_exp_nx = f3_mac_exp - (f3_align_diff_gt2 ? 13'b0 : {6'b0,f3_lzc});
assign f3_lza_err_check_disable = (~f3_align_diff_gt2 & f3_lzc_sel_subnorm) | f3_frd_subnorm;
assign f3_nbs_p_l0 = f3_p;
assign f3_nbs_p_l1 = f3_lzc_final[6] ? {f3_nbs_p_l0[(MAC_MSB - 64):MAC_LSB],{64{f3_complement}}} : f3_nbs_p_l0;
assign f3_nbs_p_l2 = f3_lzc_final[5] ? {f3_nbs_p_l1[(MAC_MSB - 32):MAC_LSB],{32{f3_complement}}} : f3_nbs_p_l1;
assign f3_nbs_p_l3 = f3_lzc_final[4] ? {f3_nbs_p_l2[(MAC_MSB - 16):MAC_LSB],{16{f3_complement}}} : f3_nbs_p_l2;
assign f3_nbs_p_l4 = f3_lzc_final[3] ? {f3_nbs_p_l3[(MAC_MSB - 8):MAC_LSB],{8{f3_complement}}} : f3_nbs_p_l3;
assign f3_nbs_p_l5 = f3_lzc_final[2] ? {f3_nbs_p_l4[(MAC_MSB - 4):MAC_LSB],{4{f3_complement}}} : f3_nbs_p_l4;
assign f3_nbs_p_l6 = f3_lzc_final[1] ? {f3_nbs_p_l5[(MAC_MSB - 2):MAC_LSB],{2{f3_complement}}} : f3_nbs_p_l5;
assign f3_nbs_p_l7 = f3_lzc_final[0] ? {f3_nbs_p_l6[(MAC_MSB - 1):MAC_LSB],{1{f3_complement}}} : f3_nbs_p_l6;
assign f3_nbs_g_l0 = f3_g;
assign f3_nbs_g_l1 = f3_lzc_final[6] ? {f3_nbs_g_l0[(MAC_MSB - 64):MAC_LSB],64'b0} : f3_nbs_g_l0;
assign f3_nbs_g_l2 = f3_lzc_final[5] ? {f3_nbs_g_l1[(MAC_MSB - 32):MAC_LSB],32'b0} : f3_nbs_g_l1;
assign f3_nbs_g_l3 = f3_lzc_final[4] ? {f3_nbs_g_l2[(MAC_MSB - 16):MAC_LSB],16'b0} : f3_nbs_g_l2;
assign f3_nbs_g_l4 = f3_lzc_final[3] ? {f3_nbs_g_l3[(MAC_MSB - 8):MAC_LSB],8'b0} : f3_nbs_g_l3;
assign f3_nbs_g_l5 = f3_lzc_final[2] ? {f3_nbs_g_l4[(MAC_MSB - 4):MAC_LSB],4'b0} : f3_nbs_g_l4;
assign f3_nbs_g_l6 = f3_lzc_final[1] ? {f3_nbs_g_l5[(MAC_MSB - 2):MAC_LSB],2'b0} : f3_nbs_g_l5;
assign f3_nbs_g_l7 = f3_lzc_final[0] ? {f3_nbs_g_l6[(MAC_MSB - 1):MAC_LSB],1'b0} : f3_nbs_g_l6;
assign f3_nbs_p = f3_nbs_p_l7;
assign f3_nbs_g = f3_nbs_g_l7;
assign f3_y0_p0 = f3_nbs_p[MAC_MSB:110];
assign f3_y0_p1 = f3_y0_p0 & {f3_y0_p0[53 - 1:2],1'h1};
assign f3_y0_p2 = f3_y0_p1 & {f3_y0_p1[53 - 2:2],2'h3};
assign f3_y0_p3 = f3_y0_p2 & {f3_y0_p2[53 - 4:2],4'hf};
assign f3_y0_p4 = f3_y0_p3 & {f3_y0_p3[53 - 8:2],8'hff};
assign f3_y0_p5 = f3_y0_p4 & {f3_y0_p4[53 - 16:2],16'hffff};
assign f3_y0_g2_orig = f3_nbs_g[MAC_MSB:110];
assign f3_y0_g2 = {f3_y0_g2_orig[53:5],f3_y0_g2_orig[4:2] & ~f3_y0_p2[4:2]};
assign f3_y0_g3 = f3_y0_g2 | (f3_y0_p2 & {f3_y0_g2[53 - 4:2],4'h0});
assign f3_y0_g4 = f3_y0_g3 | (f3_y0_p3 & {f3_y0_g3[53 - 8:2],8'h0});
assign f3_y0_g5 = f3_y0_g4 | (f3_y0_p4 & {f3_y0_g4[53 - 16:2],16'h0});
assign f3_y0_g6 = f3_y0_g5 | (f3_y0_p5 & {f3_y0_g5[53 - 32:2],32'h0});
assign f3_y0 = f3_y0_p0 ^ {f3_y0_g6[52:2],1'b0};
assign f3_y1_p0 = {f3_y0_p0[53:3],~f3_y0_p0[2]};
assign f3_y1_p1 = f3_y1_p0 & {f3_y1_p0[53 - 1:2],1'h1};
assign f3_y1_p2 = f3_y1_p1 & {f3_y1_p1[53 - 2:2],2'h3};
assign f3_y1_p3 = f3_y1_p2 & {f3_y1_p2[53 - 4:2],4'hf};
assign f3_y1_p4 = f3_y1_p3 & {f3_y1_p3[53 - 8:2],8'hff};
assign f3_y1_p5 = f3_y1_p4 & {f3_y1_p4[53 - 16:2],16'hffff};
assign f3_y1_g2 = f3_y0_g2 | {48'b0,f3_y0_p2[5],f3_y0_p2[4],f3_y0_p2[3],f3_y0_p2[2]};
assign f3_y1_g3 = f3_y1_g2 | (f3_y1_p2 & {f3_y1_g2[53 - 4:2],4'h0});
assign f3_y1_g4 = f3_y1_g3 | (f3_y1_p3 & {f3_y1_g3[53 - 8:2],8'h0});
assign f3_y1_g5 = f3_y1_g4 | (f3_y1_p4 & {f3_y1_g4[53 - 16:2],16'h0});
assign f3_y1_g6 = f3_y1_g5 | (f3_y1_p5 & {f3_y1_g5[53 - 32:2],32'h0});
assign f3_y1 = f3_y1_p0 ^ {f3_y1_g6[52:2],1'b0};
assign f3_cslice_p0 = f3_nbs_p[109:107];
assign f3_cslice_p1 = f3_cslice_p0 & {f3_cslice_p0[1:0],1'h1};
assign f3_cslice_p2 = f3_cslice_p1 & {f3_cslice_p1[0],2'h3};
assign f3_cslice_g2_orig = f3_nbs_g[109:107];
assign f3_cslice_g2 = {f3_cslice_g2_orig[2:0] & ~f3_cslice_p2[2:0]};
assign f3_z = {1'b0,f3_cslice_p0} ^ {f3_cslice_g2,1'b0};
assign f3_lslice_p0 = f3_nbs_p[106:MAC_LSB];
assign f3_lslice_p1 = f3_lslice_p0 & {f3_lslice_p0[106 - 1:MAC_LSB],1'h1};
assign f3_lslice_p2 = f3_lslice_p1 & {f3_lslice_p1[106 - 2:MAC_LSB],2'h3};
assign f3_lslice_p3 = f3_lslice_p2 & {f3_lslice_p2[106 - 4:MAC_LSB],4'hf};
assign f3_lslice_p4 = f3_lslice_p3 & {f3_lslice_p3[106 - 8:MAC_LSB],8'hff};
assign f3_lslice_p5 = f3_lslice_p4 & {f3_lslice_p4[106 - 16:MAC_LSB],16'hffff};
assign f3_lslice_p6 = f3_lslice_p5 & {f3_lslice_p5[106 - 32:MAC_LSB],32'hffffffff};
assign f3_lslice_g2 = f3_nbs_g[106:MAC_LSB];
assign f3_lslice_g3 = f3_lslice_g2 | (f3_lslice_p2 & {f3_lslice_g2[106 - 4:MAC_LSB],4'h0});
assign f3_lslice_g4 = f3_lslice_g3 | (f3_lslice_p3 & {f3_lslice_g3[106 - 8:MAC_LSB],8'h0});
assign f3_lslice_g5 = f3_lslice_g4 | (f3_lslice_p4 & {f3_lslice_g4[106 - 16:MAC_LSB],16'h0});
assign f3_lslice_g6 = f3_lslice_g5 | (f3_lslice_p5 & {f3_lslice_g5[106 - 32:MAC_LSB],32'h0});
assign f3_lslice_g7 = f3_lslice_g6 | (f3_lslice_p6 & {f3_lslice_g6[106 - 64:MAC_LSB],64'h0});
assign f3_lslice_msb = ((f3_lslice_p0[106] ^ f3_lslice_g7[105]) & ~((&f3_lslice_p0) & f3_complement)) | (~f3_lslice_p0[106] & (&f3_lslice_p0[105:MAC_LSB]) & f3_complement);
assign f3_carry = f3_lslice_g7[106] | ((&f3_lslice_p0) & f3_complement);
assign f3_lslice_v = ({f3_lslice_p0[105:MAC_LSB],1'b0} | {f3_lslice_g2[105:MAC_LSB],1'b0} | {(106 - MAC_LSB + 1){f3_complement}}) ~^ {f3_lslice_p0};
assign f3_sticky = f3_align_sticky | ~(&f3_lslice_v);
assign f3_round_rne = (f3_round_mode == ROUND_RNE);
assign f3_round_rtz = (f3_round_mode == ROUND_RTZ);
assign f3_round_rdn = (f3_round_mode == ROUND_RDN);
assign f3_round_rup = (f3_round_mode == ROUND_RUP);
assign f3_round_rmm = (f3_round_mode == ROUND_RMM);
assign f3_rn = f3_round_rne | f3_round_rmm;
assign f3_ri = (~f3_arith_sign & f3_round_rup) | (f3_arith_sign & f3_round_rdn);
assign f3_rz = f3_round_rtz | (~f3_arith_sign & f3_round_rdn) | (f3_arith_sign & f3_round_rup);
assign f4_sticky_lza_err = f4_sticky | (f4_carry ^ f4_z[0]);
assign f4_round_digit_lza_noerr = {3'b0,f4_sticky & f4_ri} + {3'b0,f4_rn | f4_ri};
assign f4_round_digit_lza_err = {2'b0,f4_sticky_lza_err & f4_ri,1'b0} + {2'b0,f4_rn | f4_ri,1'b0};
assign f4_lza_err = (~f4_lza_err_check_disable & f4_frd_dp & (f4_y0[53] | (f4_y1[53] & f4_z_lza_noerr[3]))) | (~f4_lza_err_check_disable & f4_frd_sp & (f4_y0[24] | (f4_y1[24] & f4_z_lza_noerr[3]))) | (~f4_lza_err_check_disable & f4_frd_hp & (f4_y0[11] | (f4_y1[11] & f4_z_lza_noerr[3])));
assign f4_z_lza_noerr = f4_z + {3'b0,f4_carry} + f4_round_digit_lza_noerr;
assign f4_z_lza_err = f4_z + {3'b0,f4_carry} + f4_round_digit_lza_err;
assign f4_inc = f4_lza_err ? f4_z_lza_err[3] : f4_z_lza_noerr[3];
assign f4_y = f4_inc ? f4_y1 : f4_y0;
assign f4_frac = f4_lza_err ? {f4_y[53:2],f4_z_lza_err[2]} : {f4_y[52:2],f4_z_lza_noerr[2:1]};
assign f4_tie_round_bit = f4_lza_err ? f4_z[1] ^ (f4_z[0] & f4_carry) : f4_z[0] ^ f4_carry;
assign f4_tie_sticky_bit = f4_sticky | (f4_lza_err & f4_sticky_lza_err);
assign f4_tie = f4_tie_round_bit & ~f4_tie_sticky_bit;
assign f4_frac_corrected[0] = f4_frac[0] & ~(f4_tie & f4_round_rne);
assign f4_frac_corrected[52:1] = f4_frac[52:1];
assign f4_frac_all_zero = ~(|f4_frac_corrected);
assign f4_frd_zero_final = ~f4_frd_qnan & ~f4_frd_inf & (f4_frd_zero | f4_frac_all_zero | (f4_uf_exception & ~f4_subnorm & (f4_rn | f4_rz)));
assign f4_frd_smallest = f4_uf_exception & ~f4_subnorm & f4_ri;
assign f4_frd_inf_final = ~f4_frd_qnan & (f4_frd_inf | (f4_of_exception & (f4_rn | f4_ri)));
assign f4_frd_largest = f4_of_exception & f4_rz;
assign f4_exp_p0_d_gt_ovf_bound = ~f4_mac_exp[12] & (f4_mac_exp[11:0] > 12'd1023);
assign f4_exp_p0_d_gt_sub_bound = ~f4_mac_exp[12] | (~f4_mac_exp[11:0] < 12'd1022);
assign f4_exp_p0_d_gt_udf_bound = ~f4_mac_exp[12] | (~f4_mac_exp[11:0] < 12'd1075);
assign f4_exp_p0_s_gt_ovf_bound = ~f4_mac_exp[12] & (f4_mac_exp[11:0] > 12'd127);
assign f4_exp_p0_s_gt_sub_bound = ~f4_mac_exp[12] | (~f4_mac_exp[11:0] < 12'd126);
assign f4_exp_p0_s_gt_udf_bound = ~f4_mac_exp[12] | (~f4_mac_exp[11:0] < 12'd150);
assign f4_exp_p0_h_gt_ovf_bound = ~f4_mac_exp[12] & (f4_mac_exp[11:0] > 12'd15);
assign f4_exp_p0_h_gt_sub_bound = ~f4_mac_exp[12] | (~f4_mac_exp[11:0] < 12'd14);
assign f4_exp_p0_h_gt_udf_bound = ~f4_mac_exp[12] | (~f4_mac_exp[11:0] < 12'd25);
assign f4_exp_p1_d_gt_ovf_bound = ~f4_mac_exp[12] & (f4_mac_exp[11:0] > 12'd1022);
assign f4_exp_p1_d_gt_sub_bound = ~f4_mac_exp[12] | (~f4_mac_exp[11:0] < 12'd1023);
assign f4_exp_p1_d_gt_udf_bound = ~f4_mac_exp[12] | (~f4_mac_exp[11:0] < 12'd1076);
assign f4_exp_p1_s_gt_ovf_bound = ~f4_mac_exp[12] & (f4_mac_exp[11:0] > 12'd126);
assign f4_exp_p1_s_gt_sub_bound = ~f4_mac_exp[12] | (~f4_mac_exp[11:0] < 12'd127);
assign f4_exp_p1_s_gt_udf_bound = ~f4_mac_exp[12] | (~f4_mac_exp[11:0] < 12'd151);
assign f4_exp_p1_h_gt_ovf_bound = ~f4_mac_exp[12] & (f4_mac_exp[11:0] > 12'd14);
assign f4_exp_p1_h_gt_sub_bound = ~f4_mac_exp[12] | (~f4_mac_exp[11:0] < 12'd15);
assign f4_exp_p1_h_gt_udf_bound = ~f4_mac_exp[12] | (~f4_mac_exp[11:0] < 12'd26);
assign f4_exp_d_gt_ovf_bound = f4_lza_err ? f4_exp_p1_d_gt_ovf_bound : f4_exp_p0_d_gt_ovf_bound;
assign f4_exp_d_gt_sub_bound = f4_lza_err ? f4_exp_p1_d_gt_sub_bound : f4_exp_p0_d_gt_sub_bound;
assign f4_exp_d_gt_udf_bound = f4_lza_err ? f4_exp_p1_d_gt_udf_bound : f4_exp_p0_d_gt_udf_bound;
assign f4_exp_s_gt_ovf_bound = f4_lza_err ? f4_exp_p1_s_gt_ovf_bound : f4_exp_p0_s_gt_ovf_bound;
assign f4_exp_s_gt_sub_bound = f4_lza_err ? f4_exp_p1_s_gt_sub_bound : f4_exp_p0_s_gt_sub_bound;
assign f4_exp_s_gt_udf_bound = f4_lza_err ? f4_exp_p1_s_gt_udf_bound : f4_exp_p0_s_gt_udf_bound;
assign f4_exp_h_gt_ovf_bound = f4_lza_err ? f4_exp_p1_h_gt_ovf_bound : f4_exp_p0_h_gt_ovf_bound;
assign f4_exp_h_gt_sub_bound = f4_lza_err ? f4_exp_p1_h_gt_sub_bound : f4_exp_p0_h_gt_sub_bound;
assign f4_exp_h_gt_udf_bound = f4_lza_err ? f4_exp_p1_h_gt_udf_bound : f4_exp_p0_h_gt_udf_bound;
assign f4_frd_special = f4_frd_inf | f4_frd_zero | f4_frd_qnan;
assign f4_dp_subnorm_pred = ~f4_exp_p0_d_gt_sub_bound & f4_exp_p1_d_gt_udf_bound;
assign f4_sp_subnorm_pred = ~f4_exp_p0_s_gt_sub_bound & f4_exp_p1_s_gt_udf_bound;
assign f4_hp_subnorm_pred = ~f4_exp_p0_h_gt_sub_bound & f4_exp_p1_h_gt_udf_bound;
assign f4_subnorm_pred = (f4_frd_dp ? f4_dp_subnorm_pred : f4_frd_sp ? f4_sp_subnorm_pred : f4_hp_subnorm_pred) & ~f4_frd_special;
assign f4_uf_to_subnorm = f4_subnorm_pred & (f4_frac_corrected == 53'b1);
assign f4_dp_of_exception = f4_exp_d_gt_ovf_bound;
assign f4_dp_subnorm = ~f4_exp_d_gt_sub_bound & (f4_exp_d_gt_udf_bound | f4_uf_to_subnorm);
assign f4_dp_uf_exception = ~f4_exp_d_gt_udf_bound;
assign f4_sp_of_exception = f4_exp_s_gt_ovf_bound;
assign f4_sp_subnorm = ~f4_exp_s_gt_sub_bound & (f4_exp_s_gt_udf_bound | f4_uf_to_subnorm);
assign f4_sp_uf_exception = ~f4_exp_s_gt_udf_bound;
assign f4_hp_of_exception = f4_exp_h_gt_ovf_bound;
assign f4_hp_subnorm = ~f4_exp_h_gt_sub_bound & (f4_exp_h_gt_udf_bound | f4_uf_to_subnorm);
assign f4_hp_uf_exception = ~f4_exp_h_gt_udf_bound;
assign f4_of_exception = (f4_frd_dp ? f4_dp_of_exception : f4_frd_sp ? f4_sp_of_exception : f4_hp_of_exception) & ~f4_frd_special;
assign f4_subnorm = ((f4_frd_dp & f4_dp_subnorm) | (f4_frd_sp & f4_sp_subnorm) | (f4_frd_hp & f4_hp_subnorm)) & ~f4_frd_special;
assign f4_adjust_exp = f4_lza_err ? f4_mac_exp + 13'b1 : f4_mac_exp;
assign f4_exp_is_subnorm = (f4_adjust_exp == (f4_frd_dp ? 13'h1c01 : f4_frd_sp ? 13'h1f81 : 13'h1ff1));
assign f4_subnorm_to_norm_cond = (f4_frd_dp & ({f4_y0[52:2],f4_z[2:2]} == 52'h7ffffffffffff)) | (f4_frd_sp & ({f4_y0[23:2],f4_z[2:2]} == 23'h3fffff)) | (f4_frd_hp & ({f4_y0[10:2],f4_z[2:2]} == 10'h1ff));
assign f4_round_bits_as_normal = {1'b0,f4_z[1:0]} + {2'b0,f4_carry} + {2'b0,(f4_ri & f4_sticky) | (f4_rn & f4_lslice_msb)};
assign f4_subnorm_to_norm_uf = (f4_exp_is_subnorm) & f4_subnorm_to_norm_cond & ~f4_round_bits_as_normal[2];
assign f4_subnorm_to_normal = (f4_frd_dp & f4_frac[52]) | (f4_frd_sp & f4_frac[23]) | (f4_frd_hp & f4_frac[10]);
assign f4_uf_exception = (f4_subnorm & (f4_tie_round_bit | f4_tie_sticky_bit) & (~f4_subnorm_to_normal | f4_subnorm_to_norm_uf)) | ((f4_frd_dp ? f4_dp_uf_exception : f4_frd_sp ? f4_sp_uf_exception : f4_hp_uf_exception) & ~(f4_nv_exception | f4_frd_special | (f4_frac_all_zero & ~f4_tie_round_bit & ~f4_tie_sticky_bit)));
assign f4_nx_exception = ~(f4_frd_qnan | f4_frd_zero) & ((f4_tie_round_bit | f4_tie_sticky_bit) & ~(f4_nv_exception | f4_frd_inf) | f4_of_exception | f4_uf_exception);
assign f4_zero_sign = (f4_frac_all_zero & ~f4_tie_round_bit & ~f4_tie_sticky_bit & ~f4_frd_zero) ? f4_round_rdn : f4_arith_sign;
assign f4_frd_qnan_hp = ~f4_redosum_masked & f4_frd_hp & f4_frd_qnan;
assign f4_frd_qnan_sp = ~f4_redosum_masked & f4_frd_sp & f4_frd_qnan;
assign f4_frd_qnan_dp = ~f4_redosum_masked & f4_frd_dp & f4_frd_qnan;
assign f4_frd_inf_hp = ~f4_redosum_masked & f4_frd_hp & f4_frd_inf_final;
assign f4_frd_inf_sp = ~f4_redosum_masked & f4_frd_sp & f4_frd_inf_final;
assign f4_frd_inf_dp = ~f4_redosum_masked & f4_frd_dp & f4_frd_inf_final;
assign f4_frd_zero_hp = ~f4_redosum_masked & f4_frd_hp & f4_frd_zero_final;
assign f4_frd_zero_sp = ~f4_redosum_masked & f4_frd_sp & f4_frd_zero_final;
assign f4_frd_zero_dp = ~f4_redosum_masked & f4_frd_dp & f4_frd_zero_final;
assign f4_frd_largest_hp = ~f4_redosum_masked & f4_frd_hp & f4_frd_largest;
assign f4_frd_largest_sp = ~f4_redosum_masked & f4_frd_sp & f4_frd_largest;
assign f4_frd_largest_dp = ~f4_redosum_masked & f4_frd_dp & f4_frd_largest;
assign f4_frd_smallest_hp = ~f4_redosum_masked & f4_frd_hp & f4_frd_smallest;
assign f4_frd_smallest_sp = ~f4_redosum_masked & f4_frd_sp & f4_frd_smallest;
assign f4_frd_smallest_dp = ~f4_redosum_masked & f4_frd_dp & f4_frd_smallest;
assign f4_non_arith_wdata = ({64{f4_frd_qnan_hp}} & {48'hffffffffffff,1'b0,5'h1f,10'h200}) | ({64{f4_frd_qnan_sp}} & {32'hffffffff,1'b0,8'hff,23'h400000}) | ({64{f4_frd_qnan_dp}} & {1'b0,11'h7ff,52'h8000000000000}) | ({64{f4_frd_inf_hp}} & {48'hffffffffffff,f4_arith_sign,5'h1f,10'h0}) | ({64{f4_frd_inf_sp}} & {32'hffffffff,f4_arith_sign,8'hff,23'h0}) | ({64{f4_frd_inf_dp}} & {f4_arith_sign,11'h7ff,52'h0}) | ({64{f4_frd_zero_hp}} & {48'hffffffffffff,f4_zero_sign,5'h0,10'h0}) | ({64{f4_frd_zero_sp}} & {32'hffffffff,f4_zero_sign,8'h0,23'h0}) | ({64{f4_frd_zero_dp}} & {f4_zero_sign,11'h0,52'h0}) | ({64{f4_frd_largest_hp}} & {48'hffffffffffff,f4_arith_sign,5'h1e,10'h3ff}) | ({64{f4_frd_largest_sp}} & {32'hffffffff,f4_arith_sign,8'hfe,23'h7fffff}) | ({64{f4_frd_largest_dp}} & {f4_arith_sign,11'h7fe,52'hfffffffffffff}) | ({64{f4_frd_smallest_hp}} & {48'hffffffffffff,f4_arith_sign,5'h0,10'h1}) | ({64{f4_frd_smallest_sp}} & {32'hffffffff,f4_arith_sign,8'h0,23'h1}) | ({64{f4_frd_smallest_dp}} & {f4_arith_sign,11'h0,52'h1}) | ({64{f4_redosum_masked}} & {f4_redosum_scalar});
assign f4_non_arith_wdata_en = f4_frd_inf_final | f4_frd_zero_final | f4_frd_qnan | f4_frd_largest | f4_frd_smallest | f4_redosum_masked;
assign f4_flag_set = {(5){f4_valid & ~f4_redosum_masked}} & {f4_nv_exception,1'b0,f4_of_exception,f4_uf_exception,f4_nx_exception};
assign f4_wdata = f4_non_arith_wdata_en ? f4_non_arith_wdata : f4_arith_wdata;
assign f4_wdata_en = f4_valid;
assign f4_result_type = f4_frd_scalar_fp | f4_frd_dp ? 2'b11 : f4_frd_sp ? 2'b10 : 2'b01;
assign f4_adjust_exp_bias = f4_subnorm ? {12'b0,f4_subnorm_to_normal} : (f4_mac_exp + (f4_frd_dp ? DP_BIAS : f4_frd_sp ? SP_BIAS : HP_BIAS)) + {12'b0,f4_lza_err};
assign f4_arith_wdata = ({64{f4_frd_dp}} & {f4_arith_sign,f4_adjust_exp_bias[10:0],f4_frac_corrected[51:0]}) | ({64{f4_frd_sp}} & {32'hffffffff,f4_arith_sign,f4_adjust_exp_bias[7:0],f4_frac_corrected[22:0]}) | ({64{f4_frd_hp}} & {48'hffffffffffff,f4_arith_sign,f4_adjust_exp_bias[4:0],f4_frac_corrected[9:0]});
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f2_valid <= 1'b0;
        f3_valid <= 1'b0;
        f4_valid <= 1'b0;
    end
    else if (~f3_stall) begin
        f2_valid <= f1_valid;
        f3_valid <= f2_valid;
        f4_valid <= f3_valid;
    end
end

assign f2_pipe_en = f1_valid & ~f3_stall;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f2_frd_dp <= 1'b0;
        f2_frd_sp <= 1'b0;
        f2_frd_hp <= 1'b0;
        f2_frd_scalar_fp <= 1'b0;
    end
    else if (f2_pipe_en) begin
        f2_frd_dp <= f1_frd_dp;
        f2_frd_sp <= f1_frd_sp;
        f2_frd_hp <= f1_frd_hp;
        f2_frd_scalar_fp <= f1_frd_scalar_fp;
    end
end

always @(posedge core_clk) begin
    if (f2_pipe_en) begin
        f2_frd_inf <= f1_frd_inf;
        f2_frd_zero <= f1_frd_zero;
        f2_frd_qnan <= f1_frd_qnan;
        f2_eff_sub <= f2_eff_sub_nx;
        f2_arith_sign <= f1_arith_sign;
        f2_align_diff_gt2 <= f1_align_diff_gt2;
        f2_mac_exp <= f2_mac_exp_nx;
        f2_round_mode <= f1_round_mode;
        f2_nv_exception <= f1_nv_exception;
        f2_align_sticky_partial <= f2_align_sticky_partial_nx;
        f2_align_amount <= f2_align_amount_nx;
        f2_align_l5 <= f2_align_l5_nx;
        f2_lzc_align_diff_gt2 <= f1_lzc_align_diff_gt2;
        f2_c0_l3 <= f1_c0_l3;
        f2_c1_l3 <= f1_c1_l3;
        f2_s0_l3 <= f1_s0_l3;
        f2_s1_l3 <= f1_s1_l3;
        f2_frd_subnorm <= f2_frd_subnorm_nx;
    end
end

assign f3_pipe_en = f2_valid & ~f3_stall;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f3_frd_dp <= 1'b0;
        f3_frd_sp <= 1'b0;
        f3_frd_hp <= 1'b0;
        f3_frd_scalar_fp <= 1'b0;
    end
    else if (f3_pipe_en) begin
        f3_frd_dp <= f2_frd_dp;
        f3_frd_sp <= f2_frd_sp;
        f3_frd_hp <= f2_frd_hp;
        f3_frd_scalar_fp <= f2_frd_scalar_fp;
    end
end

always @(posedge core_clk) begin
    if (f3_pipe_en) begin
        f3_frd_inf <= f2_frd_inf;
        f3_frd_zero <= f2_frd_zero;
        f3_frd_qnan <= f2_frd_qnan;
        f3_nv_exception <= f2_nv_exception;
        f3_align_sticky <= f2_align_sticky;
        f3_arith_sign <= f3_arith_sign_nx;
        f3_mac_exp <= f2_mac_exp;
        f3_align_diff_gt2 <= f2_align_diff_gt2;
        f3_round_mode <= f2_round_mode;
        f3_complement <= f2_complement;
        f3_lzc_final_msb <= f2_lzc_final_msb;
        f3_lzc_msb <= f2_lzc_msb;
        f3_lzc_align_diff_gt2 <= f2_lzc_align_diff_gt2;
        f3_lzc_subnorm <= f2_lzc_subnorm_final;
        f3_lzc_eq_subnorm_b6to4 <= f2_lzc_eq_subnorm_b6to4;
        f3_lzc_gt_subnorm_b6to4 <= f2_lzc_gt_subnorm_b6to4;
        f3_p <= f3_p_nx;
        f3_g <= f3_g_nx;
        f3_frd_subnorm <= f2_frd_subnorm;
        f3_lza_str <= f2_lza_str_l3;
    end
end

assign f4_pipe_en = f3_valid & ~f3_stall;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f4_frd_dp <= 1'b0;
        f4_frd_sp <= 1'b0;
        f4_frd_hp <= 1'b0;
        f4_frd_scalar_fp <= 1'b0;
    end
    else if (f4_pipe_en) begin
        f4_frd_dp <= f3_frd_dp;
        f4_frd_sp <= f3_frd_sp;
        f4_frd_hp <= f3_frd_hp;
        f4_frd_scalar_fp <= f3_frd_scalar_fp;
    end
end

always @(posedge core_clk) begin
    if (f4_pipe_en) begin
        f4_frd_inf <= f3_frd_inf;
        f4_frd_zero <= f3_frd_zero;
        f4_frd_qnan <= f3_frd_qnan;
        f4_align_sticky <= f3_align_sticky;
        f4_arith_sign <= f3_arith_sign;
        f4_mac_exp <= f4_mac_exp_nx;
        f4_nv_exception <= f3_nv_exception;
        f4_y0 <= f3_y0;
        f4_y1 <= f3_y1;
        f4_z <= f3_z;
        f4_carry <= f3_carry;
        f4_sticky <= f3_sticky;
        f4_lslice_msb <= f3_lslice_msb;
        f4_lza_err_check_disable <= f3_lza_err_check_disable;
        f4_round_rne <= f3_round_rne;
        f4_round_rdn <= f3_round_rdn;
        f4_ri <= f3_ri;
        f4_rn <= f3_rn;
        f4_rz <= f3_rz;
    end
end

assign f4_redosum_masked = 1'b0;
assign f4_redosum_scalar = 64'b0;
function  [54:0] pp_encode;
input [51:0] x;
input [2:0] y;
reg [53:0] pp;
reg carry;
begin
    case (y)
        3'b000: {carry,pp} = {1'b0,1'b1,1'b0,52'b0};
        3'b111: {carry,pp} = {1'b0,1'b1,1'b0,52'b0};
        3'b001: {carry,pp} = {1'b0,1'b1,1'b0,x};
        3'b010: {carry,pp} = {1'b0,1'b1,1'b0,x};
        3'b011: {carry,pp} = {1'b0,1'b1,x,1'b0};
        3'b100: {carry,pp} = {1'b1,1'b0,~x,1'b1};
        3'b101: {carry,pp} = {1'b1,1'b0,1'b1,~x};
        3'b110: {carry,pp} = {1'b1,1'b0,1'b1,~x};
        default: {carry,pp} = {1'b0,1'b0,1'b0,52'b0};
    endcase
    pp_encode = {carry,pp};
end
endfunction
wire unused_wires = unused2 | unused3 | unused4 | unused6 | unused7 | unused8 | unused9 | unused10 | unused11;
endmodule


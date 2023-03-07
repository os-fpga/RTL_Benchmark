// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_iiq_wrap (
    core_clk,
    core_reset_n,
    iiq_flush,
    iiq_w_valid,
    iiq_w_ready,
    iiq_w_data0,
    iiq_w_data1,
    iiq_r_valid,
    iiq_r_ready,
    iiq_r_data0,
    iiq_r_data1
);
parameter IIQ_WIDTH = 32;
parameter FLEN = 0;
parameter VLEN = 512;
parameter EXTVALEN = 32;
parameter UINS_PCLEN = 9;
parameter CTRL_WIDTH = 32;
parameter PRED_WIDTH = 32;
parameter RVA_SUPPORT_INT = 0;
parameter RVN_SUPPORT_INT = 0;
parameter DSP_SUPPORT_INT = 0;
parameter ACE_SUPPORT_INT = 0;
parameter ISA_GP_INT = 0;
parameter ISA_LEA_INT = 0;
parameter ISA_BEQC_INT = 0;
parameter ISA_BBZ_INT = 0;
parameter ISA_BFO_INT = 0;
parameter ISA_STR_INT = 0;
parameter STACKSAFE_SUPPORT_INT = 0;
parameter NUM_PRIVILEGE_LEVELS = 1;
parameter MULTIPLIER_INT = 1;
localparam IIQ_DEPTH = 4;
input core_clk;
input core_reset_n;
input iiq_flush;
input [1:0] iiq_w_valid;
output [1:0] iiq_w_ready;
input [IIQ_WIDTH - 1:0] iiq_w_data0;
input [IIQ_WIDTH - 1:0] iiq_w_data1;
output [1:0] iiq_r_valid;
input [1:0] iiq_r_ready;
output [IIQ_WIDTH - 1:0] iiq_r_data0;
output [IIQ_WIDTH - 1:0] iiq_r_data1;


wire [IIQ_WIDTH - 1:0] s0;
wire [IIQ_WIDTH - 1:0] s1;
wire [IIQ_WIDTH - 1:0] s2;
wire [IIQ_WIDTH - 1:0] s3;
wire [IIQ_WIDTH - 1:0] s4;
wire [IIQ_WIDTH - 1:0] s5;
wire [IIQ_WIDTH - 1:0] s6;
wire [IIQ_WIDTH - 1:0] s7;
wire [EXTVALEN - 1:0] s8;
wire [UINS_PCLEN - 3:0] s9;
wire [EXTVALEN - 1:0] s10;
wire [CTRL_WIDTH - 1:0] s11;
wire [31:0] s12;
wire [31:0] s13;
wire [PRED_WIDTH - 1:0] s14;
wire [EXTVALEN - 1:0] s15;
wire [UINS_PCLEN - 3:0] s16;
wire [EXTVALEN - 1:0] s17;
wire [CTRL_WIDTH - 1:0] s18;
wire [31:0] s19;
wire [31:0] s20;
wire [PRED_WIDTH - 1:0] s21;
wire [EXTVALEN - 1:0] s22;
wire [UINS_PCLEN - 3:0] s23;
wire [EXTVALEN - 1:0] s24;
wire [CTRL_WIDTH - 1:0] s25;
wire [31:0] s26;
wire [31:0] s27;
wire [PRED_WIDTH - 1:0] s28;
wire [EXTVALEN - 1:0] s29;
wire [UINS_PCLEN - 3:0] s30;
wire [EXTVALEN - 1:0] s31;
wire [CTRL_WIDTH - 1:0] s32;
wire [31:0] s33;
wire [31:0] s34;
wire [PRED_WIDTH - 1:0] s35;
reg [31:0] s36;
reg [31:0] s37;
wire s38;
wire s39;
wire [CTRL_WIDTH - 1:0] s40;
wire [CTRL_WIDTH - 1:0] s41;
reg [CTRL_WIDTH - 1:0] s42;
reg [CTRL_WIDTH - 1:0] s43;
wire [31:0] s44;
wire [31:0] s45;
reg [31:0] s46;
reg [31:0] s47;
wire [31:0] s48;
wire [CTRL_WIDTH - 1:0] s49;
assign s48 = {{19{1'b0}},13'h1fff};
assign s49[0] = 1'b1;
assign s49[1] = 1'b1;
assign s49[2] = 1'b1;
assign s49[3] = 1'b0;
assign s49[4] = 1'b0;
assign s49[5] = 1'b0;
assign s49[6] = 1'b0;
assign s49[7] = 1'b0;
assign s49[8] = 1'b0;
assign s49[9] = 1'b0;
assign s49[10] = 1'b0;
assign s49[11] = 1'b0;
assign s49[12] = 1'b0;
assign s49[13] = 1'b0;
assign s49[14] = 1'b0;
assign s49[15] = 1'b0;
assign s49[16] = 1'b0;
assign s49[17] = 1'b0;
assign s49[18] = 1'b0;
assign s49[19] = 1'b0;
assign s49[20] = 1'b0;
assign s49[21] = 1'b0;
assign s49[22] = 1'b0;
assign s49[26:23] = 4'b0000;
assign s49[27] = 1'b1;
assign s49[28] = 1'b1;
assign s49[29] = 1'b0;
assign s49[30] = 1'b0;
assign s49[31] = 1'b0;
assign s49[32] = 1'b0;
assign s49[33] = 1'b0;
assign s49[34] = 1'b0;
assign s49[35] = 1'b0;
assign s49[36] = 1'b0;
assign s49[41:37] = 5'b00000;
assign s49[42] = 1'b1;
assign s49[43] = 1'b0;
assign s49[44] = 1'b1;
assign s49[45] = 1'b1;
assign s49[46] = 1'b1;
assign s49[47] = 1'b1;
assign s49[48] = 1'b1;
assign s49[69:49] = 21'b111111111111111111111;
assign s49[71:70] = 2'b11;
assign s49[72] = 1'b1;
assign s49[73] = 1'b1;
assign s49[74] = 1'b1;
assign s49[75] = 1'b1;
assign s49[81:76] = 6'b111111;
assign s49[84:82] = 3'b111;
assign s49[85] = 1'b1;
assign s49[86] = 1'b1;
assign s49[87] = 1'b1;
assign s49[99:88] = 12'b000000000000;
assign s49[101:100] = 2'b11;
assign s49[102] = 1'b1;
assign s49[105:103] = 3'b111;
assign s49[106] = 1'b0;
assign s49[107] = 1'b0;
assign s49[108] = 1'b0;
assign s49[116:109] = 8'b00000000;
assign s49[117] = 1'b0;
assign s49[120:118] = 3'b000;
assign s49[121] = 1'b1;
assign s49[122] = 1'b1;
assign s49[128:123] = 6'b111111;
assign s49[129] = 1'b0;
assign s49[130] = 1'b0;
assign s49[135:131] = 5'b11111;
assign s49[136] = 1'b1;
assign s49[139:137] = 3'b111;
assign s49[140] = 1'b1;
assign s49[145:141] = 5'b11111;
assign s49[146] = 1'b1;
assign s49[151:147] = 5'b11111;
assign s49[152] = 1'b1;
assign s49[157:153] = 5'b11111;
assign s49[158] = 1'b1;
assign s49[161:159] = 3'b111;
assign s49[162] = 1'b1;
assign s49[163] = 1'b1;
assign s49[164] = 1'b1;
assign s49[165] = 1'b1;
assign s49[166] = 1'b1;
assign s49[167] = 1'b1;
assign s49[168] = 1'b1;
assign s49[169] = 1'b1;
assign s49[170] = 1'b1;
assign s49[171] = 1'b1;
assign s49[172] = 1'b1;
assign s49[173] = 1'b1;
assign s49[174] = 1'b1;
assign s49[175] = 1'b1;
assign s49[176] = 1'b1;
assign s49[177] = 1'b1;
assign s49[178] = 1'b1;
assign s49[179] = 1'b1;
assign s49[180] = 1'b1;
assign s49[181] = 1'b1;
assign s49[182] = 1'b1;
assign s49[183] = 1'b1;
assign s49[184] = 1'b1;
assign s49[185] = 1'b1;
assign s49[186] = 1'b1;
assign s49[187] = 1'b1;
assign s49[188] = 1'b1;
assign s49[189] = 1'b1;
assign s49[190] = 1'b1;
assign s49[191] = 1'b1;
assign s49[192] = 1'b1;
assign s49[193] = 1'b1;
assign s49[194] = 1'b1;
assign s49[195] = 1'b1;
assign s49[196] = 1'b1;
assign s49[197] = 1'b0;
assign s49[198] = 1'b1;
assign s49[203:199] = 5'b11111;
assign s49[204] = 1'b1;
assign s49[212:205] = 8'b11111111;
assign s49[215:213] = 3'b111;
assign s49[216] = 1'b1;
assign s49[217] = 1'b1;
assign s49[218] = 1'b1;
assign s49[219] = 1'b1;
assign s49[220] = 1'b1;
assign s49[224:221] = 4'b0000;
assign s49[226:225] = 2'b11;
assign s49[227] = 1'b0;
assign s49[248:228] = 21'b000000000000000000000;
assign s49[249] = 1'b1;
assign s49[250] = 1'b1;
assign s49[251] = 1'b1;
assign s49[256:252] = 5'b11111;
assign s49[257] = 1'b1;
assign s49[262:258] = 5'b11111;
assign s49[263] = 1'b1;
assign s49[266:264] = 3'b111;
assign s49[271:267] = 5'b11111;
assign s49[272] = 1'b1;
assign s49[277:273] = 5'b11111;
assign s49[278] = 1'b1;
assign s49[283:279] = 5'b11111;
assign s49[284] = 1'b1;
assign s49[289:285] = 5'b11111;
assign s49[290] = 1'b1;
assign s49[291] = 1'b1;
assign s49[292] = 1'b1;
assign s49[293] = 1'b1;
assign s49[294] = 1'b1;
assign s49[300:295] = 6'b111111;
assign s49[301] = 1'b0;
assign s49[303:302] = 2'b11;
assign s49[304] = 1'b0;
assign s49[305] = 1'b1;
assign s49[306] = 1'b1;
assign s49[307] = 1'b1;
assign s49[308] = 1'b0;
assign s49[309] = 1'b0;
assign s49[310] = 1'b0;
assign s49[311] = 1'b0;
assign s49[312] = 1'b0;
assign s49[313] = 1'b0;
assign s49[314] = 1'b0;
assign s49[315] = 1'b0;
assign s49[316] = 1'b1;
assign s49[317] = 1'b1;
assign s49[322:318] = 5'b00000;
kv_iiq #(
    .DW(IIQ_WIDTH)
) u_iiq (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .flush(iiq_flush),
    .w_valid(iiq_w_valid),
    .w_ready(iiq_w_ready),
    .w_data0(s2),
    .w_data1(s3),
    .r_valid(iiq_r_valid),
    .r_ready(iiq_r_ready),
    .r_data0(s4),
    .r_data1(s5)
);
kv_dec #(
    .FLEN(FLEN),
    .VLEN(VLEN),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT),
    .RVN_SUPPORT_INT(RVN_SUPPORT_INT),
    .DSP_SUPPORT_INT(DSP_SUPPORT_INT),
    .ISA_GP_INT(ISA_GP_INT),
    .ISA_LEA_INT(ISA_LEA_INT),
    .ISA_BEQC_INT(ISA_BEQC_INT),
    .ISA_BBZ_INT(ISA_BBZ_INT),
    .ISA_BFO_INT(ISA_BFO_INT),
    .ISA_STR_INT(ISA_STR_INT),
    .STACKSAFE_SUPPORT_INT(STACKSAFE_SUPPORT_INT),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .MULTIPLIER_INT(MULTIPLIER_INT)
) u_kv_dec_i0 (
    .cur_privilege_m(1'b0),
    .cur_privilege_s(1'b0),
    .cur_privilege_u(1'b0),
    .csr_mstatus_tw(1'b0),
    .csr_mstatus_tvm(1'b0),
    .csr_mstatus_tsr(1'b0),
    .csr_mhsp_ctl_m(1'b0),
    .csr_mhsp_ctl_s(1'b0),
    .csr_mhsp_ctl_u(1'b0),
    .csr_mmisc_ctl_aces(2'b0),
    .src2_imm(s44),
    .id_ctrl(s40),
    .instr_from_exec_it(1'b0),
    .csr_frm({32{1'b0}}),
    .csr_mstatus_fs(2'd0),
    .csr_mmisc_ctl_rvcompm(1'b0),
    .csr_halt_mode(1'b0),
    .csr_dcsr_step(1'b0),
    .csr_dcsr_ebreakm(1'b0),
    .csr_dcsr_ebreaks(1'b0),
    .csr_dcsr_ebreaku(1'b0),
    .trigm_icount_enabled(1'b0),
    .ifu_vector_resume(1'b0),
    .ifu_pred_bogus(1'b0),
    .ifu_pred_hit(1'b0),
    .ifu_pred_taken(1'b0),
    .ifu_pred_start(1'b0),
    .ifu_pred_brk(1'b0),
    .ifu_fault(1'b0),
    .ifu_fault_dcause(3'd0),
    .ifu_ecc_code(s27[7:0]),
    .ifu_ecc_corr(s27[8]),
    .ifu_ecc_ramid(s27[11:9]),
    .ifu_page_fault(1'b0),
    .ifu_fault_upper(1'b0),
    .ifu_instr(s26),
    .ifu_instr_16b(s25[42])
);
kv_dec #(
    .FLEN(FLEN),
    .VLEN(VLEN),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT),
    .RVN_SUPPORT_INT(RVN_SUPPORT_INT),
    .DSP_SUPPORT_INT(DSP_SUPPORT_INT),
    .ISA_GP_INT(ISA_GP_INT),
    .ISA_LEA_INT(ISA_LEA_INT),
    .ISA_BEQC_INT(ISA_BEQC_INT),
    .ISA_BBZ_INT(ISA_BBZ_INT),
    .ISA_BFO_INT(ISA_BFO_INT),
    .ISA_STR_INT(ISA_STR_INT),
    .STACKSAFE_SUPPORT_INT(STACKSAFE_SUPPORT_INT),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .MULTIPLIER_INT(MULTIPLIER_INT)
) u_kv_dec_i1 (
    .cur_privilege_m(1'b0),
    .cur_privilege_s(1'b0),
    .cur_privilege_u(1'b0),
    .csr_mstatus_tw(1'b0),
    .csr_mstatus_tvm(1'b0),
    .csr_mstatus_tsr(1'b0),
    .csr_mhsp_ctl_m(1'b0),
    .csr_mhsp_ctl_s(1'b0),
    .csr_mhsp_ctl_u(1'b0),
    .csr_mmisc_ctl_aces(2'b0),
    .src2_imm(s45),
    .id_ctrl(s41),
    .instr_from_exec_it(1'b0),
    .csr_frm({32{1'b0}}),
    .csr_mstatus_fs(2'd0),
    .csr_mmisc_ctl_rvcompm(1'b0),
    .csr_halt_mode(1'b0),
    .csr_dcsr_step(1'b0),
    .csr_dcsr_ebreakm(1'b0),
    .csr_dcsr_ebreaks(1'b0),
    .csr_dcsr_ebreaku(1'b0),
    .trigm_icount_enabled(1'b0),
    .ifu_vector_resume(1'b0),
    .ifu_pred_bogus(1'b0),
    .ifu_pred_hit(1'b0),
    .ifu_pred_taken(1'b0),
    .ifu_pred_start(1'b0),
    .ifu_pred_brk(1'b0),
    .ifu_fault(1'b0),
    .ifu_fault_dcause(3'd0),
    .ifu_ecc_code(s34[7:0]),
    .ifu_ecc_corr(s34[8]),
    .ifu_ecc_ramid(s34[11:9]),
    .ifu_page_fault(1'b0),
    .ifu_fault_upper(1'b0),
    .ifu_instr(s33),
    .ifu_instr_16b(s32[42])
);
assign s0 = iiq_w_data0;
assign s1 = iiq_w_data1;
assign {s8,s9,s10,s11,s12,s13,s14} = s0;
assign {s15,s16,s17,s18,s19,s20,s21} = s1;
assign s2 = {s8,s9,s10,(s11 & s49),s12,(s36 & s48),s14};
assign s3 = {s15,s16,s17,(s18 & s49),s19,(s37 & s48),s21};
assign iiq_r_data0 = s6;
assign iiq_r_data1 = s7;
assign {s22,s23,s24,s25,s26,s27,s28} = s4;
assign {s29,s30,s31,s32,s33,s34,s35} = s5;
assign s6 = {s22,s23,s24,((s25 & s49) | (s42 & ~s49)),s26,((s27 & s48) | (s46 & ~s48)),s28};
assign s7 = {s29,s30,s31,((s32 & s49) | (s43 & ~s49)),s33,((s34 & s48) | (s47 & ~s48)),s35};
always @* begin
    s36 = s13;
    s37 = s20;
    if (s11[317]) begin
        s36 = {{20{1'b0}},s11[118 +:3],s11[117],s11[109 +:8]};
    end
    if (s18[317]) begin
        s37 = {{20{1'b0}},s18[118 +:3],s18[117],s18[109 +:8]};
    end
end

always @* begin
    s46 = s44;
    s47 = s45;
    if (s38) begin
        s46 = {{19{s27[12]}},s27[12:0]};
    end
    if (s39) begin
        s47 = {{19{s34[12]}},s34[12:0]};
    end
end

assign s38 = (s25[225 +:2] != 2'b11);
assign s39 = (s32[225 +:2] != 2'b11);
always @* begin
    s42 = s40;
    s43 = s41;
    if (s38) begin
        s42[88 +:12] = s27[11:0];
    end
    if (s39) begin
        s43[88 +:12] = s34[11:0];
    end
    if (s38 & s25[249]) begin
        s42[228 +:21] = s25[49 +:21];
    end
    if (s39 & s32[249]) begin
        s43[228 +:21] = s32[49 +:21];
    end
end

endmodule


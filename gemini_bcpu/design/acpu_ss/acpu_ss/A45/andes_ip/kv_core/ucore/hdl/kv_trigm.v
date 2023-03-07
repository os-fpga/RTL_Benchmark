// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_trigm (
    core_clk,
    core_reset_n,
    csr_halt_mode,
    csr_tcontrol_mte,
    csr_satp_asid,
    csr_cur_privilege,
    csr_tselect_we,
    csr_tdata1_we,
    csr_tdata2_we,
    csr_tdata3_we,
    csr_mcontext_we,
    csr_scontext_we,
    csr_wdata,
    csr_tselect,
    csr_tdata1,
    csr_tdata2,
    csr_tdata3,
    csr_mcontext,
    csr_scontext,
    csr_tinfo,
    ipipe_csr_halt_taken,
    trigm_i0_pc,
    trigm_i1_pc,
    trigm_i0_result,
    trigm_i1_result,
    trigm_ls_load,
    trigm_ls_store,
    trigm_ls_addr,
    trigm_ls_result,
    trigm_int_code,
    trigm_int_result,
    trigm_xcpt_onehot,
    trigm_xcpt_result,
    trigm_icount_result,
    trigm_icount_valid,
    trigm_icount_clr,
    trigm_icount_enabled,
    trigm_trace_enabled
);
parameter VALEN = 32;
parameter NUM_TRIGGER = 0;
parameter NUM_PRIVILEGE_LEVELS = 1;
parameter LOCALINT_SLPECC = 16;
parameter LOCALINT_SBE = 17;
parameter LOCALINT_HPMINT = 18;
parameter TRACE_INTERFACE_INT = 0;
localparam SUPPORT_ICOUNT = 8'b0000_0011;
localparam SUPPORT_ITRIGGER = 8'b0001_0001;
localparam SUPPORT_ETRIGGER = (NUM_TRIGGER == 2) ? 8'b0000_0010 : 8'b1000_1000;
localparam SUPPORT_MCONTROL = 8'b1111_1111;
localparam SUPPORT_MCONTROL_CHAIN = (NUM_TRIGGER == 2) ? 8'b0000_0001 : (NUM_TRIGGER == 4) ? 8'b0000_0111 : 8'b0111_0111;
localparam TSELECT_INDEX_BW = (NUM_TRIGGER <= 2) ? 1 : (NUM_TRIGGER <= 4) ? 2 : 3;
localparam TRIGGER_MATCH_BITS = 2;
localparam MATCH_EQ = 4'd0;
localparam MATCH_MASK = 4'd1;
localparam MATCH_GE = 4'd2;
localparam MATCH_LT = 4'd3;
localparam ACTION_BREAK = 6'd0;
localparam ACTION_HALT = 6'd1;
localparam TYPE_NONE = 4'd0;
localparam TYPE_ADDR_DATA_MATCH = 4'd2;
localparam TYPE_ICOUNT = 4'd3;
localparam TYPE_ITRIGGER = 4'd4;
localparam TYPE_ETRIGGER = 4'd5;
localparam PRIVILEGE_USER = 2'b00;
localparam PRIVILEGE_SUPERVISOR = 2'b01;
localparam PRIVILEGE_HYPERVISOR = 2'b10;
localparam PRIVILEGE_MACHINE = 2'b11;
localparam TEXTRA_MVALUE_WIDTH = 6;
localparam TEXTRA_MVALUE_MSB = 31;
localparam TEXTRA_MVALUE_LSB = TEXTRA_MVALUE_MSB - TEXTRA_MVALUE_WIDTH + 1;
localparam TEXTRA_MSELECT = TEXTRA_MVALUE_LSB - 1;
localparam TEXTRA_ZERO_WIDTH = 14;
localparam TEXTRA_ZERO_MSB = TEXTRA_MSELECT - 1;
localparam TEXTRA_ZERO_LSB = TEXTRA_ZERO_MSB - TEXTRA_ZERO_WIDTH + 1;
localparam TEXTRA_SVALUE_WIDTH = 9;
localparam TEXTRA_SVALUE_MSB = TEXTRA_ZERO_LSB - 1;
localparam TEXTRA_SVALUE_LSB = TEXTRA_SVALUE_MSB - TEXTRA_SVALUE_WIDTH + 1;
localparam TEXTRA_SSELECT_MSB = 1;
localparam TEXTRA_SSELECT_LSB = 0;
input core_clk;
input core_reset_n;
input csr_halt_mode;
input csr_tcontrol_mte;
input [8:0] csr_satp_asid;
input [1:0] csr_cur_privilege;
input csr_tselect_we;
input csr_tdata1_we;
input csr_tdata2_we;
input csr_tdata3_we;
input csr_mcontext_we;
input csr_scontext_we;
input [31:0] csr_wdata;
output [31:0] csr_tselect;
output [31:0] csr_tdata1;
output [31:0] csr_tdata2;
output [31:0] csr_tdata3;
output [31:0] csr_mcontext;
output [31:0] csr_scontext;
output [31:0] csr_tinfo;
input ipipe_csr_halt_taken;
input [VALEN - 1:0] trigm_i0_pc;
input [VALEN - 1:0] trigm_i1_pc;
output [4:0] trigm_i0_result;
output [4:0] trigm_i1_result;
input trigm_ls_load;
input trigm_ls_store;
input [VALEN - 1:0] trigm_ls_addr;
output [4:0] trigm_ls_result;
input [4:0] trigm_int_code;
output [4:0] trigm_int_result;
input [16:0] trigm_xcpt_onehot;
output [4:0] trigm_xcpt_result;
output [4:0] trigm_icount_result;
input trigm_icount_valid;
input trigm_icount_clr;
output trigm_icount_enabled;
output trigm_trace_enabled;


wire cur_privilege_m = (csr_cur_privilege == PRIVILEGE_MACHINE);
wire cur_privilege_s = (csr_cur_privilege == PRIVILEGE_SUPERVISOR);
wire cur_privilege_u = (csr_cur_privilege == PRIVILEGE_USER);
wire [31:0] csr_tselect;
wire icount_dec;
wire icount_clr;
wire [7:0] dmode;
wire [7:0] chain;
wire [7:0] s0;
wire [7:0] s1;
wire [7:0] s2;
wire [7:0] s3;
wire [7:0] s4;
wire [7:0] s5;
wire [7:0] s6;
wire [7:0] s7;
wire [7:0] s8;
wire [7:0] s9;
wire [7:0] s10;
wire [7:0] s11;
wire [7:0] s12;
wire [7:0] s13;
wire [7:0] s14;
wire [7:0] s15;
wire [7:0] s16;
wire [31:0] s17;
wire [31:0] s18;
wire [31:0] s19;
wire [31:0] s20;
wire [31:0] s21;
wire [31:0] s22;
wire [31:0] s23;
wire [31:0] s24;
wire [31:0] s25;
wire [31:0] s26;
wire [31:0] s27;
wire [31:0] s28;
wire [31:0] s29;
wire [31:0] s30;
wire [31:0] s31;
wire [31:0] s32;
wire [31:0] s33;
wire [31:0] s34;
wire [31:0] s35;
wire [31:0] s36;
wire [31:0] s37;
wire [31:0] s38;
wire [31:0] s39;
wire [31:0] s40;
wire [31:0] s41;
wire [31:0] s42;
wire [31:0] s43;
wire [31:0] s44;
wire [31:0] s45;
wire [31:0] s46;
wire [31:0] s47;
wire [31:0] s48;
assign s0[0] = (csr_tselect[2:0] == 3'd0);
assign s0[1] = (csr_tselect[2:0] == 3'd1);
assign s0[2] = (csr_tselect[2:0] == 3'd2);
assign s0[3] = (csr_tselect[2:0] == 3'd3);
assign s0[4] = (csr_tselect[2:0] == 3'd4);
assign s0[5] = (csr_tselect[2:0] == 3'd5);
assign s0[6] = (csr_tselect[2:0] == 3'd6);
assign s0[7] = (csr_tselect[2:0] == 3'd7);
assign csr_tinfo = ({32{s0[0]}} & s17) | ({32{s0[1]}} & s21) | ({32{s0[2]}} & s25) | ({32{s0[3]}} & s29) | ({32{s0[4]}} & s33) | ({32{s0[5]}} & s37) | ({32{s0[6]}} & s41) | ({32{s0[7]}} & s45);
assign csr_tdata1 = ({32{s0[0]}} & s18) | ({32{s0[1]}} & s22) | ({32{s0[2]}} & s26) | ({32{s0[3]}} & s30) | ({32{s0[4]}} & s34) | ({32{s0[5]}} & s38) | ({32{s0[6]}} & s42) | ({32{s0[7]}} & s46);
assign csr_tdata2 = ({32{s0[0]}} & s19) | ({32{s0[1]}} & s23) | ({32{s0[2]}} & s27) | ({32{s0[3]}} & s31) | ({32{s0[4]}} & s35) | ({32{s0[5]}} & s39) | ({32{s0[6]}} & s43) | ({32{s0[7]}} & s47);
assign csr_tdata3 = ({32{s0[0]}} & s20) | ({32{s0[1]}} & s24) | ({32{s0[2]}} & s28) | ({32{s0[3]}} & s32) | ({32{s0[4]}} & s36) | ({32{s0[5]}} & s40) | ({32{s0[6]}} & s44) | ({32{s0[7]}} & s48);
kv_trigger #(
    .CONFIGURED(NUM_TRIGGER > 0),
    .VALEN(VALEN),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .LOCALINT_SLPECC(LOCALINT_SLPECC),
    .LOCALINT_SBE(LOCALINT_SBE),
    .LOCALINT_HPMINT(LOCALINT_HPMINT),
    .TRACE_INTERFACE_INT(TRACE_INTERFACE_INT),
    .SUPPORT_ICOUNT(SUPPORT_ICOUNT[0]),
    .SUPPORT_ITRIGGER(SUPPORT_ITRIGGER[0]),
    .SUPPORT_ETRIGGER(SUPPORT_ETRIGGER[0]),
    .SUPPORT_MCONTROL(SUPPORT_MCONTROL[0]),
    .SUPPORT_MCONTROL_CHAIN(SUPPORT_MCONTROL_CHAIN[0])
) u_trigger0 (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_halt_mode(csr_halt_mode),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_satp_asid(csr_satp_asid),
    .csr_mcontext(csr_mcontext),
    .csr_scontext(csr_scontext),
    .csr_tcontrol_mte(csr_tcontrol_mte),
    .selected(s0[0]),
    .i0_pc(trigm_i0_pc),
    .i1_pc(trigm_i1_pc),
    .ls_load(trigm_ls_load),
    .ls_store(trigm_ls_store),
    .ls_addr(trigm_ls_addr),
    .int_code(trigm_int_code),
    .xcpt_onehot(trigm_xcpt_onehot),
    .prev_dmode(1'b0),
    .prev_chain(1'b0),
    .dmode(dmode[0]),
    .chain(chain[0]),
    .next_dmode(dmode[1]),
    .csr_tdata1_we(csr_tdata1_we),
    .csr_tdata2_we(csr_tdata2_we),
    .csr_tdata3_we(csr_tdata3_we),
    .csr_wdata(csr_wdata),
    .icount_dec(icount_dec),
    .icount_clr(icount_clr),
    .icount_enabled(s7[0]),
    .trace_enabled(s8[0]),
    .tinfo(s17),
    .tdata1(s18),
    .tdata2(s19),
    .tdata3(s20),
    .i0_matched(s1[0]),
    .i1_matched(s2[0]),
    .ls_matched(s3[0]),
    .int_matched(s4[0]),
    .xcpt_matched(s5[0]),
    .icount_matched(s6[0]),
    .action_xcpt(s12[0]),
    .action_halt(s13[0]),
    .action_trace_on(s14[0]),
    .action_trace_off(s15[0]),
    .action_trace_notify(s16[0])
);
kv_trigger #(
    .CONFIGURED(NUM_TRIGGER > 1),
    .VALEN(VALEN),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .LOCALINT_SLPECC(LOCALINT_SLPECC),
    .LOCALINT_SBE(LOCALINT_SBE),
    .LOCALINT_HPMINT(LOCALINT_HPMINT),
    .TRACE_INTERFACE_INT(TRACE_INTERFACE_INT),
    .SUPPORT_ICOUNT(SUPPORT_ICOUNT[1]),
    .SUPPORT_ITRIGGER(SUPPORT_ITRIGGER[1]),
    .SUPPORT_ETRIGGER(SUPPORT_ETRIGGER[1]),
    .SUPPORT_MCONTROL(SUPPORT_MCONTROL[1]),
    .SUPPORT_MCONTROL_CHAIN(SUPPORT_MCONTROL_CHAIN[1])
) u_trigger1 (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_halt_mode(csr_halt_mode),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_satp_asid(csr_satp_asid),
    .csr_mcontext(csr_mcontext),
    .csr_scontext(csr_scontext),
    .csr_tcontrol_mte(csr_tcontrol_mte),
    .selected(s0[1]),
    .i0_pc(trigm_i0_pc),
    .i1_pc(trigm_i1_pc),
    .ls_load(trigm_ls_load),
    .ls_store(trigm_ls_store),
    .ls_addr(trigm_ls_addr),
    .int_code(trigm_int_code),
    .xcpt_onehot(trigm_xcpt_onehot),
    .prev_dmode(dmode[0]),
    .prev_chain(chain[0]),
    .dmode(dmode[1]),
    .chain(chain[1]),
    .next_dmode(dmode[2]),
    .csr_tdata1_we(csr_tdata1_we),
    .csr_tdata2_we(csr_tdata2_we),
    .csr_tdata3_we(csr_tdata3_we),
    .csr_wdata(csr_wdata),
    .icount_dec(icount_dec),
    .icount_clr(icount_clr),
    .icount_enabled(s7[1]),
    .trace_enabled(s8[1]),
    .tinfo(s21),
    .tdata1(s22),
    .tdata2(s23),
    .tdata3(s24),
    .i0_matched(s1[1]),
    .i1_matched(s2[1]),
    .ls_matched(s3[1]),
    .int_matched(s4[1]),
    .xcpt_matched(s5[1]),
    .icount_matched(s6[1]),
    .action_xcpt(s12[1]),
    .action_halt(s13[1]),
    .action_trace_on(s14[1]),
    .action_trace_off(s15[1]),
    .action_trace_notify(s16[1])
);
kv_trigger #(
    .CONFIGURED(NUM_TRIGGER > 2),
    .VALEN(VALEN),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .LOCALINT_SLPECC(LOCALINT_SLPECC),
    .LOCALINT_SBE(LOCALINT_SBE),
    .LOCALINT_HPMINT(LOCALINT_HPMINT),
    .TRACE_INTERFACE_INT(TRACE_INTERFACE_INT),
    .SUPPORT_ICOUNT(SUPPORT_ICOUNT[2]),
    .SUPPORT_ITRIGGER(SUPPORT_ITRIGGER[2]),
    .SUPPORT_ETRIGGER(SUPPORT_ETRIGGER[2]),
    .SUPPORT_MCONTROL(SUPPORT_MCONTROL[2]),
    .SUPPORT_MCONTROL_CHAIN(SUPPORT_MCONTROL_CHAIN[2])
) u_trigger2 (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_halt_mode(csr_halt_mode),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_satp_asid(csr_satp_asid),
    .csr_mcontext(csr_mcontext),
    .csr_scontext(csr_scontext),
    .csr_tcontrol_mte(csr_tcontrol_mte),
    .selected(s0[2]),
    .i0_pc(trigm_i0_pc),
    .i1_pc(trigm_i1_pc),
    .ls_load(trigm_ls_load),
    .ls_store(trigm_ls_store),
    .ls_addr(trigm_ls_addr),
    .int_code(trigm_int_code),
    .xcpt_onehot(trigm_xcpt_onehot),
    .prev_dmode(dmode[1]),
    .prev_chain(chain[1]),
    .dmode(dmode[2]),
    .chain(chain[2]),
    .next_dmode(dmode[3]),
    .csr_tdata1_we(csr_tdata1_we),
    .csr_tdata2_we(csr_tdata2_we),
    .csr_tdata3_we(csr_tdata3_we),
    .csr_wdata(csr_wdata),
    .icount_dec(icount_dec),
    .icount_clr(icount_clr),
    .icount_enabled(s7[2]),
    .trace_enabled(s8[2]),
    .tinfo(s25),
    .tdata1(s26),
    .tdata2(s27),
    .tdata3(s28),
    .i0_matched(s1[2]),
    .i1_matched(s2[2]),
    .ls_matched(s3[2]),
    .int_matched(s4[2]),
    .xcpt_matched(s5[2]),
    .icount_matched(s6[2]),
    .action_xcpt(s12[2]),
    .action_halt(s13[2]),
    .action_trace_on(s14[2]),
    .action_trace_off(s15[2]),
    .action_trace_notify(s16[2])
);
kv_trigger #(
    .CONFIGURED(NUM_TRIGGER > 3),
    .VALEN(VALEN),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .LOCALINT_SLPECC(LOCALINT_SLPECC),
    .LOCALINT_SBE(LOCALINT_SBE),
    .LOCALINT_HPMINT(LOCALINT_HPMINT),
    .TRACE_INTERFACE_INT(TRACE_INTERFACE_INT),
    .SUPPORT_ICOUNT(SUPPORT_ICOUNT[3]),
    .SUPPORT_ITRIGGER(SUPPORT_ITRIGGER[3]),
    .SUPPORT_ETRIGGER(SUPPORT_ETRIGGER[3]),
    .SUPPORT_MCONTROL(SUPPORT_MCONTROL[3]),
    .SUPPORT_MCONTROL_CHAIN(SUPPORT_MCONTROL_CHAIN[3])
) u_trigger3 (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_halt_mode(csr_halt_mode),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_satp_asid(csr_satp_asid),
    .csr_mcontext(csr_mcontext),
    .csr_scontext(csr_scontext),
    .csr_tcontrol_mte(csr_tcontrol_mte),
    .selected(s0[3]),
    .i0_pc(trigm_i0_pc),
    .i1_pc(trigm_i1_pc),
    .ls_load(trigm_ls_load),
    .ls_store(trigm_ls_store),
    .ls_addr(trigm_ls_addr),
    .int_code(trigm_int_code),
    .xcpt_onehot(trigm_xcpt_onehot),
    .prev_dmode(dmode[2]),
    .prev_chain(chain[2]),
    .dmode(dmode[3]),
    .chain(chain[3]),
    .next_dmode(dmode[4]),
    .csr_tdata1_we(csr_tdata1_we),
    .csr_tdata2_we(csr_tdata2_we),
    .csr_tdata3_we(csr_tdata3_we),
    .csr_wdata(csr_wdata),
    .icount_dec(icount_dec),
    .icount_clr(icount_clr),
    .icount_enabled(s7[3]),
    .trace_enabled(s8[3]),
    .tinfo(s29),
    .tdata1(s30),
    .tdata2(s31),
    .tdata3(s32),
    .i0_matched(s1[3]),
    .i1_matched(s2[3]),
    .ls_matched(s3[3]),
    .int_matched(s4[3]),
    .xcpt_matched(s5[3]),
    .icount_matched(s6[3]),
    .action_xcpt(s12[3]),
    .action_halt(s13[3]),
    .action_trace_on(s14[3]),
    .action_trace_off(s15[3]),
    .action_trace_notify(s16[3])
);
kv_trigger #(
    .CONFIGURED(NUM_TRIGGER > 4),
    .VALEN(VALEN),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .LOCALINT_SLPECC(LOCALINT_SLPECC),
    .LOCALINT_SBE(LOCALINT_SBE),
    .LOCALINT_HPMINT(LOCALINT_HPMINT),
    .TRACE_INTERFACE_INT(TRACE_INTERFACE_INT),
    .SUPPORT_ICOUNT(SUPPORT_ICOUNT[4]),
    .SUPPORT_ITRIGGER(SUPPORT_ITRIGGER[4]),
    .SUPPORT_ETRIGGER(SUPPORT_ETRIGGER[4]),
    .SUPPORT_MCONTROL(SUPPORT_MCONTROL[4]),
    .SUPPORT_MCONTROL_CHAIN(SUPPORT_MCONTROL_CHAIN[4])
) u_trigger4 (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_halt_mode(csr_halt_mode),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_satp_asid(csr_satp_asid),
    .csr_mcontext(csr_mcontext),
    .csr_scontext(csr_scontext),
    .csr_tcontrol_mte(csr_tcontrol_mte),
    .selected(s0[4]),
    .i0_pc(trigm_i0_pc),
    .i1_pc(trigm_i1_pc),
    .ls_load(trigm_ls_load),
    .ls_store(trigm_ls_store),
    .ls_addr(trigm_ls_addr),
    .int_code(trigm_int_code),
    .xcpt_onehot(trigm_xcpt_onehot),
    .prev_dmode(dmode[3]),
    .prev_chain(chain[3]),
    .dmode(dmode[4]),
    .chain(chain[4]),
    .next_dmode(dmode[5]),
    .csr_tdata1_we(csr_tdata1_we),
    .csr_tdata2_we(csr_tdata2_we),
    .csr_tdata3_we(csr_tdata3_we),
    .csr_wdata(csr_wdata),
    .icount_dec(icount_dec),
    .icount_clr(icount_clr),
    .icount_enabled(s7[4]),
    .trace_enabled(s8[4]),
    .tinfo(s33),
    .tdata1(s34),
    .tdata2(s35),
    .tdata3(s36),
    .i0_matched(s1[4]),
    .i1_matched(s2[4]),
    .ls_matched(s3[4]),
    .int_matched(s4[4]),
    .xcpt_matched(s5[4]),
    .icount_matched(s6[4]),
    .action_xcpt(s12[4]),
    .action_halt(s13[4]),
    .action_trace_on(s14[4]),
    .action_trace_off(s15[4]),
    .action_trace_notify(s16[4])
);
kv_trigger #(
    .CONFIGURED(NUM_TRIGGER > 5),
    .VALEN(VALEN),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .LOCALINT_SLPECC(LOCALINT_SLPECC),
    .LOCALINT_SBE(LOCALINT_SBE),
    .LOCALINT_HPMINT(LOCALINT_HPMINT),
    .TRACE_INTERFACE_INT(TRACE_INTERFACE_INT),
    .SUPPORT_ICOUNT(SUPPORT_ICOUNT[5]),
    .SUPPORT_ITRIGGER(SUPPORT_ITRIGGER[5]),
    .SUPPORT_ETRIGGER(SUPPORT_ETRIGGER[5]),
    .SUPPORT_MCONTROL(SUPPORT_MCONTROL[5]),
    .SUPPORT_MCONTROL_CHAIN(SUPPORT_MCONTROL_CHAIN[5])
) u_trigger5 (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_halt_mode(csr_halt_mode),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_satp_asid(csr_satp_asid),
    .csr_mcontext(csr_mcontext),
    .csr_scontext(csr_scontext),
    .csr_tcontrol_mte(csr_tcontrol_mte),
    .selected(s0[5]),
    .i0_pc(trigm_i0_pc),
    .i1_pc(trigm_i1_pc),
    .ls_load(trigm_ls_load),
    .ls_store(trigm_ls_store),
    .ls_addr(trigm_ls_addr),
    .int_code(trigm_int_code),
    .xcpt_onehot(trigm_xcpt_onehot),
    .prev_dmode(dmode[4]),
    .prev_chain(chain[4]),
    .dmode(dmode[5]),
    .chain(chain[5]),
    .next_dmode(dmode[6]),
    .csr_tdata1_we(csr_tdata1_we),
    .csr_tdata2_we(csr_tdata2_we),
    .csr_tdata3_we(csr_tdata3_we),
    .csr_wdata(csr_wdata),
    .icount_dec(icount_dec),
    .icount_clr(icount_clr),
    .icount_enabled(s7[5]),
    .trace_enabled(s8[5]),
    .tinfo(s37),
    .tdata1(s38),
    .tdata2(s39),
    .tdata3(s40),
    .i0_matched(s1[5]),
    .i1_matched(s2[5]),
    .ls_matched(s3[5]),
    .int_matched(s4[5]),
    .xcpt_matched(s5[5]),
    .icount_matched(s6[5]),
    .action_xcpt(s12[5]),
    .action_halt(s13[5]),
    .action_trace_on(s14[5]),
    .action_trace_off(s15[5]),
    .action_trace_notify(s16[5])
);
kv_trigger #(
    .CONFIGURED(NUM_TRIGGER > 6),
    .VALEN(VALEN),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .LOCALINT_SLPECC(LOCALINT_SLPECC),
    .LOCALINT_SBE(LOCALINT_SBE),
    .LOCALINT_HPMINT(LOCALINT_HPMINT),
    .TRACE_INTERFACE_INT(TRACE_INTERFACE_INT),
    .SUPPORT_ICOUNT(SUPPORT_ICOUNT[6]),
    .SUPPORT_ITRIGGER(SUPPORT_ITRIGGER[6]),
    .SUPPORT_ETRIGGER(SUPPORT_ETRIGGER[6]),
    .SUPPORT_MCONTROL(SUPPORT_MCONTROL[6]),
    .SUPPORT_MCONTROL_CHAIN(SUPPORT_MCONTROL_CHAIN[6])
) u_trigger6 (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_halt_mode(csr_halt_mode),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_satp_asid(csr_satp_asid),
    .csr_mcontext(csr_mcontext),
    .csr_scontext(csr_scontext),
    .csr_tcontrol_mte(csr_tcontrol_mte),
    .selected(s0[6]),
    .i0_pc(trigm_i0_pc),
    .i1_pc(trigm_i1_pc),
    .ls_load(trigm_ls_load),
    .ls_store(trigm_ls_store),
    .ls_addr(trigm_ls_addr),
    .int_code(trigm_int_code),
    .xcpt_onehot(trigm_xcpt_onehot),
    .prev_dmode(dmode[5]),
    .prev_chain(chain[5]),
    .dmode(dmode[6]),
    .chain(chain[6]),
    .next_dmode(dmode[7]),
    .csr_tdata1_we(csr_tdata1_we),
    .csr_tdata2_we(csr_tdata2_we),
    .csr_tdata3_we(csr_tdata3_we),
    .csr_wdata(csr_wdata),
    .icount_dec(icount_dec),
    .icount_clr(icount_clr),
    .icount_enabled(s7[6]),
    .trace_enabled(s8[6]),
    .tinfo(s41),
    .tdata1(s42),
    .tdata2(s43),
    .tdata3(s44),
    .i0_matched(s1[6]),
    .i1_matched(s2[6]),
    .ls_matched(s3[6]),
    .int_matched(s4[6]),
    .xcpt_matched(s5[6]),
    .icount_matched(s6[6]),
    .action_xcpt(s12[6]),
    .action_halt(s13[6]),
    .action_trace_on(s14[6]),
    .action_trace_off(s15[6]),
    .action_trace_notify(s16[6])
);
kv_trigger #(
    .CONFIGURED(NUM_TRIGGER > 7),
    .VALEN(VALEN),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .LOCALINT_SLPECC(LOCALINT_SLPECC),
    .LOCALINT_SBE(LOCALINT_SBE),
    .LOCALINT_HPMINT(LOCALINT_HPMINT),
    .TRACE_INTERFACE_INT(TRACE_INTERFACE_INT),
    .SUPPORT_ICOUNT(SUPPORT_ICOUNT[7]),
    .SUPPORT_ITRIGGER(SUPPORT_ITRIGGER[7]),
    .SUPPORT_ETRIGGER(SUPPORT_ETRIGGER[7]),
    .SUPPORT_MCONTROL(SUPPORT_MCONTROL[7]),
    .SUPPORT_MCONTROL_CHAIN(SUPPORT_MCONTROL_CHAIN[7])
) u_trigger7 (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_halt_mode(csr_halt_mode),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_satp_asid(csr_satp_asid),
    .csr_mcontext(csr_mcontext),
    .csr_scontext(csr_scontext),
    .csr_tcontrol_mte(csr_tcontrol_mte),
    .selected(s0[7]),
    .i0_pc(trigm_i0_pc),
    .i1_pc(trigm_i1_pc),
    .ls_load(trigm_ls_load),
    .ls_store(trigm_ls_store),
    .ls_addr(trigm_ls_addr),
    .int_code(trigm_int_code),
    .xcpt_onehot(trigm_xcpt_onehot),
    .prev_dmode(dmode[6]),
    .prev_chain(chain[6]),
    .dmode(dmode[7]),
    .chain(chain[7]),
    .next_dmode(1'b0),
    .csr_tdata1_we(csr_tdata1_we),
    .csr_tdata2_we(csr_tdata2_we),
    .csr_tdata3_we(csr_tdata3_we),
    .csr_wdata(csr_wdata),
    .icount_dec(icount_dec),
    .icount_clr(icount_clr),
    .icount_enabled(s7[7]),
    .trace_enabled(s8[7]),
    .tinfo(s45),
    .tdata1(s46),
    .tdata2(s47),
    .tdata3(s48),
    .i0_matched(s1[7]),
    .i1_matched(s2[7]),
    .ls_matched(s3[7]),
    .int_matched(s4[7]),
    .xcpt_matched(s5[7]),
    .icount_matched(s6[7]),
    .action_xcpt(s12[7]),
    .action_halt(s13[7]),
    .action_trace_on(s14[7]),
    .action_trace_off(s15[7]),
    .action_trace_notify(s16[7])
);
generate
    if (NUM_TRIGGER > 0) begin:gen_reg_tselect_tinfo_mscontext
        reg [TSELECT_INDEX_BW - 1:0] s49;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s49 <= {TSELECT_INDEX_BW{1'b0}};
            end
            else if (csr_tselect_we) begin
                s49 <= csr_wdata[TSELECT_INDEX_BW - 1:0];
            end
        end

        assign csr_tselect = {{(32 - TSELECT_INDEX_BW){1'b0}},s49};
        reg [5:0] s50;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s50 <= 6'b0;
            end
            else if (csr_mcontext_we) begin
                s50 <= csr_wdata[5:0];
            end
        end

        assign csr_mcontext = {{26{1'b0}},s50};
        reg [8:0] s51;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s51 <= 9'b0;
            end
            else if (csr_scontext_we) begin
                s51 <= csr_wdata[8:0];
            end
        end

        assign csr_scontext = {{23{1'b0}},s51};
    end
    else begin:gen_no_reg_tselect_info_mcontext
        assign csr_tselect = {32{1'b0}};
        assign csr_mcontext = {32{1'b0}};
        assign csr_scontext = {32{1'b0}};
        wire nds_unused_csr_tselect_we = csr_tselect_we;
        wire nds_unused_csr_mcontext_we = csr_mcontext_we;
        wire nds_unused_csr_scontext_we = csr_scontext_we;
    end
endgenerate
assign s9[0] = s1[0];
assign s9[1] = s1[1] & (s9[0] | ~chain[0]);
assign s9[2] = s1[2] & (s9[1] | ~chain[1]);
assign s9[3] = s1[3] & (s9[2] | ~chain[2]);
assign s9[4] = s1[4] & (s9[3] | ~chain[3]);
assign s9[5] = s1[5] & (s9[4] | ~chain[4]);
assign s9[6] = s1[6] & (s9[5] | ~chain[5]);
assign s9[7] = s1[7] & (s9[6] | ~chain[6]);
assign s10[0] = s2[0];
assign s10[1] = s2[1] & (s10[0] | ~chain[0]);
assign s10[2] = s2[2] & (s10[1] | ~chain[1]);
assign s10[3] = s2[3] & (s10[2] | ~chain[2]);
assign s10[4] = s2[4] & (s10[3] | ~chain[3]);
assign s10[5] = s2[5] & (s10[4] | ~chain[4]);
assign s10[6] = s2[6] & (s10[5] | ~chain[5]);
assign s10[7] = s2[7] & (s10[6] | ~chain[6]);
assign s11[0] = s3[0];
assign s11[1] = s3[1] & (s11[0] | ~chain[0]);
assign s11[2] = s3[2] & (s11[1] | ~chain[1]);
assign s11[3] = s3[3] & (s11[2] | ~chain[2]);
assign s11[4] = s3[4] & (s11[3] | ~chain[3]);
assign s11[5] = s3[5] & (s11[4] | ~chain[4]);
assign s11[6] = s3[6] & (s11[5] | ~chain[5]);
assign s11[7] = s3[7] & (s11[6] | ~chain[6]);
assign trigm_i0_result[0] = ~csr_halt_mode & |(s9[7:0] & s12[7:0] & ~chain[7:0]);
assign trigm_i1_result[0] = ~csr_halt_mode & |(s10[7:0] & s12[7:0] & ~chain[7:0]);
assign trigm_ls_result[0] = ~csr_halt_mode & |(s11[7:0] & s12[7:0] & ~chain[7:0]);
assign trigm_int_result[0] = ~csr_halt_mode & |(s4[7:0] & s12[7:0] & ~chain[7:0]);
assign trigm_xcpt_result[0] = ~csr_halt_mode & |(s5[7:0] & s12[7:0] & ~chain[7:0]);
assign trigm_icount_result[0] = ~csr_halt_mode & |(s6[7:0] & s12[7:0] & ~chain[7:0]);
assign trigm_i0_result[1] = ~csr_halt_mode & |(s9[7:0] & s13[7:0] & ~chain[7:0]);
assign trigm_i1_result[1] = ~csr_halt_mode & |(s10[7:0] & s13[7:0] & ~chain[7:0]);
assign trigm_ls_result[1] = ~csr_halt_mode & |(s11[7:0] & s13[7:0] & ~chain[7:0]);
assign trigm_int_result[1] = ~csr_halt_mode & |(s4[7:0] & s13[7:0] & ~chain[7:0]);
assign trigm_xcpt_result[1] = ~csr_halt_mode & |(s5[7:0] & s13[7:0] & ~chain[7:0]);
assign trigm_icount_result[1] = ~csr_halt_mode & |(s6[7:0] & s13[7:0] & ~chain[7:0]);
assign trigm_i0_result[2] = ~csr_halt_mode & |(s9[7:0] & s14[7:0] & ~chain[7:0]);
assign trigm_i1_result[2] = ~csr_halt_mode & |(s10[7:0] & s14[7:0] & ~chain[7:0]);
assign trigm_ls_result[2] = ~csr_halt_mode & |(s11[7:0] & s14[7:0] & ~chain[7:0]);
assign trigm_int_result[2] = 1'b0;
assign trigm_xcpt_result[2] = 1'b0;
assign trigm_icount_result[2] = 1'b0;
assign trigm_i0_result[3] = ~csr_halt_mode & |(s9[7:0] & s15[7:0] & ~chain[7:0]);
assign trigm_i1_result[3] = ~csr_halt_mode & |(s10[7:0] & s15[7:0] & ~chain[7:0]);
assign trigm_ls_result[3] = ~csr_halt_mode & |(s11[7:0] & s15[7:0] & ~chain[7:0]);
assign trigm_int_result[3] = 1'b0;
assign trigm_xcpt_result[3] = 1'b0;
assign trigm_icount_result[3] = 1'b0;
assign trigm_i0_result[4] = ~csr_halt_mode & |(s9[7:0] & s16[7:0] & ~chain[7:0]);
assign trigm_i1_result[4] = ~csr_halt_mode & |(s10[7:0] & s16[7:0] & ~chain[7:0]);
assign trigm_ls_result[4] = ~csr_halt_mode & |(s11[7:0] & s16[7:0] & ~chain[7:0]);
assign trigm_int_result[4] = 1'b0;
assign trigm_xcpt_result[4] = 1'b0;
assign trigm_icount_result[4] = 1'b0;
assign trigm_icount_enabled = ~csr_halt_mode & |s7[7:0];
assign trigm_trace_enabled = |s8[7:0];
assign icount_dec = trigm_icount_valid & ~csr_halt_mode;
assign icount_clr = trigm_icount_clr & ~csr_halt_mode;
wire nds_unused_ipipe_csr_halt_taken = ipipe_csr_halt_taken;
endmodule


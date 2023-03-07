// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lsu_rob (
    core_clk,
    core_reset_n,
    m0_valid,
    m0_stall,
    m0_load,
    m0_id,
    m1_id,
    m2_id,
    m1_bank,
    m2_bank,
    m0_ilm,
    m0_dlm,
    m0_dcu,
    m1_valid,
    m1_killed,
    m1_ilm,
    m1_dlm,
    m1_dcu,
    m1_load,
    m1_nbload,
    m2_valid,
    m2_alive,
    m2_committed,
    m2_abort,
    m2_ilm,
    m2_dlm,
    m2_dcu,
    m2_biu,
    m2_c,
    m2_load,
    m2_nbload,
    m2_store,
    m2_lr,
    m2_sc,
    m2_va_onehot,
    m2_offset_onehot,
    m2_result_sel,
    m2_bresult_sel,
    dcu_ack_valid,
    dcu_ack_id,
    dcu_rdata,
    dcu_ack_status,
    dcu_cri_valid,
    dcu_cri_id,
    dcu_cri_rdata,
    dcu_cri_nbload_result,
    dcu_cri_status,
    dlm_resp_valid0,
    dlm_resp_valid1,
    dlm_resp_valid2,
    dlm_resp_valid3,
    dlm0_resp_id,
    dlm1_resp_id,
    dlm2_resp_id,
    dlm3_resp_id,
    dlm_rdata0,
    dlm_rdata1,
    dlm_rdata2,
    dlm_rdata3,
    dlm_resp_status0,
    dlm_resp_status1,
    dlm_resp_status2,
    dlm_resp_status3,
    dlm_w_ready,
    ilm_resp_valid,
    ilm_rdata,
    ilm_resp_status,
    ilm_w_ready,
    biu_bk_valid,
    biu_bk_error,
    biu_bk_exokay,
    biu_bk_rdata,
    biu_resp_valid,
    biu_stall,
    rob_valid,
    ls_rob_status,
    fmt_result,
    fmt_result2,
    fmt_bresult,
    m2_resp_valid,
    m2_stall,
    nbload_resp_valid,
    nbload_resp_rd,
    nbload_resp_result,
    nbload_resp_status,
    prf_resp_valid,
    prf_resp_id,
    prf_resp_status,
    lsu_async_read_error
);
parameter ILM_SIZE_KB = 0;
parameter DLM_SIZE_KB = 0;
parameter EXTVALEN = 32;
input core_clk;
input core_reset_n;
input m0_valid;
input m0_stall;
input m0_load;
input m0_id;
input m1_id;
input m2_id;
input [3:0] m1_bank;
input [3:0] m2_bank;
input m0_ilm;
input m0_dlm;
input m0_dcu;
input m1_valid;
input m1_killed;
input m1_ilm;
input m1_dlm;
input m1_dcu;
input m1_load;
input m1_nbload;
input m2_valid;
input m2_alive;
input m2_committed;
input m2_abort;
input m2_ilm;
input m2_dlm;
input m2_dcu;
input m2_biu;
input m2_c;
input m2_load;
input m2_nbload;
input m2_store;
input m2_lr;
input m2_sc;
input [7:0] m2_va_onehot;
input [7:1] m2_offset_onehot;
input [5:0] m2_result_sel;
input [4:0] m2_bresult_sel;
input dcu_ack_valid;
input dcu_ack_id;
input [31:0] dcu_rdata;
input [18:0] dcu_ack_status;
input dcu_cri_valid;
input [0:0] dcu_cri_id;
input [31:0] dcu_cri_rdata;
input [31:0] dcu_cri_nbload_result;
input [8:0] dcu_cri_status;
input dlm_resp_valid0;
input dlm_resp_valid1;
input dlm_resp_valid2;
input dlm_resp_valid3;
input dlm0_resp_id;
input dlm1_resp_id;
input dlm2_resp_id;
input dlm3_resp_id;
input [31:0] dlm_rdata0;
input [31:0] dlm_rdata1;
input [31:0] dlm_rdata2;
input [31:0] dlm_rdata3;
input [22:0] dlm_resp_status0;
input [22:0] dlm_resp_status1;
input [22:0] dlm_resp_status2;
input [22:0] dlm_resp_status3;
input dlm_w_ready;
input ilm_resp_valid;
input [31:0] ilm_rdata;
input [22:0] ilm_resp_status;
input ilm_w_ready;
input biu_bk_valid;
input biu_bk_error;
input biu_bk_exokay;
input [31:0] biu_bk_rdata;
input biu_resp_valid;
input biu_stall;
output rob_valid;
output [22:0] ls_rob_status;
output [31:0] fmt_result;
output [63:0] fmt_result2;
output [31:0] fmt_bresult;
output m2_resp_valid;
output m2_stall;
output nbload_resp_valid;
output [4:0] nbload_resp_rd;
output [31:0] nbload_resp_result;
output nbload_resp_status;
output prf_resp_valid;
output [4:0] prf_resp_id;
output prf_resp_status;
output lsu_async_read_error;


wire s0 = (ILM_SIZE_KB != 0) | (DLM_SIZE_KB != 0);
wire s1 = m0_valid & ~m0_stall & m0_ilm;
wire s2;
wire s3;
wire s4;
wire [22:0] s5;
wire [22:0] s6;
wire [22:0] s7;
wire [22:0] s8;
wire [22:0] s9;
wire [31:0] s10;
wire s11;
wire s12;
wire [31:0] s13;
wire [22:0] s14;
wire [31:0] s15;
wire [22:0] s16;
reg s17;
wire s18;
wire s19;
wire s20;
wire s21;
reg [31:0] s22;
wire [31:0] s23;
reg [22:0] s24;
wire [22:0] s25;
wire s26;
wire s27;
wire s28;
wire s29;
wire [31:0] s30;
wire [31:0] s31;
wire [22:0] s32;
reg s33;
wire s34;
wire s35;
wire s36;
wire s37;
wire s38;
wire s39;
reg [31:0] s40;
wire [31:0] s41;
wire s42;
reg [22:0] s43;
wire [22:0] s44;
wire s45;
wire s46;
wire [31:0] s47;
wire [63:0] s48;
wire [31:0] s49;
wire [31:0] s50;
wire [63:0] s51;
wire [31:0] s52;
wire s53 = dcu_cri_status[7];
wire s54 = dcu_cri_status[1];
wire s55 = dcu_cri_status[0];
wire s56 = dcu_cri_status[8];
wire [4:0] s57 = dcu_cri_status[2 +:5];
wire s58;
wire s59;
wire s60;
wire s61;
wire s62;
wire [31:0] s63;
wire [31:0] s64;
wire [22:0] s65;
wire [22:0] s66;
wire s67 = 1'b0;
wire s68;
assign s63 = ({32{m1_bank[0]}} & dlm_rdata0) | ({32{m1_bank[1]}} & dlm_rdata1) | ({32{m1_bank[2]}} & dlm_rdata2) | ({32{m1_bank[3]}} & dlm_rdata3);
assign s64 = ({32{m2_bank[0]}} & dlm_rdata0) | ({32{m2_bank[1]}} & dlm_rdata1) | ({32{m2_bank[2]}} & dlm_rdata2) | ({32{m2_bank[3]}} & dlm_rdata3);
assign s65 = ({23{m1_bank[0]}} & dlm_resp_status0) | ({23{m1_bank[1]}} & dlm_resp_status1) | ({23{m1_bank[2]}} & dlm_resp_status2) | ({23{m1_bank[3]}} & dlm_resp_status3);
assign s66 = ({23{m2_bank[0]}} & dlm_resp_status0) | ({23{m2_bank[1]}} & dlm_resp_status1) | ({23{m2_bank[2]}} & dlm_resp_status2) | ({23{m2_bank[3]}} & dlm_resp_status3);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s17 <= 1'b0;
    end
    else if (s21) begin
        s17 <= s20;
    end
end

always @(posedge core_clk) begin
    if (s19) begin
        s22 <= s23;
        s24 <= s25;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s33 <= 1'b0;
    end
    else if (s37) begin
        s33 <= s36;
    end
end

always @(posedge core_clk) begin
    if (s39) begin
        s40 <= s41;
    end
end

always @(posedge core_clk) begin
    if (s42) begin
        s43 <= s44;
    end
end

wire nds_unused_ilm_id_wready;
wire nds_unused_ilm_id_rvalid;
kv_fifo #(
    .WIDTH(1),
    .DEPTH(3)
) u_ilm_id (
    .clk(core_clk),
    .reset_n(core_reset_n),
    .flush(1'b0),
    .wvalid(s1),
    .wready(nds_unused_ilm_id_wready),
    .wdata(m0_id),
    .rvalid(nds_unused_ilm_id_rvalid),
    .rready(ilm_resp_valid),
    .rdata(s12)
);
assign {s14,s13} = ({55{m1_ilm & s0}} & {s6,ilm_rdata}) | ({55{m1_dlm & s0}} & {s65,s63}) | ({55{m1_dcu | ~s0}} & {s7,dcu_rdata});
assign s31 = ({32{m2_dlm & s0}} & s64) | ({32{m2_dcu | ~s0}} & dcu_rdata);
assign {s32,s30} = ({55{m2_ilm & s0}} & {s6,ilm_rdata}) | ({55{m2_dlm & s0}} & {s66,s64}) | ({55{m2_dcu | ~s0}} & {s7,dcu_rdata});
assign {s16,s15} = s17 ? {s24,s22} : {s14,s13};
assign s5 = s11 ? {23{1'b0}} : (m2_biu | s33) ? s43 : s32;
kv_fmt_load u_kv_fmt_load_adv(
    .addr_onehot(m2_va_onehot[7:0]),
    .offset_onehot(m2_offset_onehot[7:1]),
    .mem_rdata(s40),
    .result_sel(m2_result_sel),
    .bresult_sel(m2_bresult_sel),
    .result(s47),
    .result2(s48),
    .bresult(s49)
);
kv_fmt_load u_kv_fmt_load_fast(
    .addr_onehot(m2_va_onehot[7:0]),
    .offset_onehot(m2_offset_onehot[7:1]),
    .mem_rdata(s31),
    .result_sel(m2_result_sel),
    .bresult_sel(m2_bresult_sel),
    .result(s50),
    .result2(s51),
    .bresult(s52)
);
assign fmt_result = (m2_biu | s33) ? s47 : s50;
assign fmt_result2 = (m2_biu | s33) ? s48 : s51;
assign fmt_bresult = (m2_biu | s33) ? s49 : s52;
assign {s25,s23} = {s14,s13};
assign {s44,s41} = m2_stall ? m2_biu ? {s8,biu_bk_rdata} : s45 ? {s9,s10} : {s32,s30} : {s16,s15};
assign s42 = s35 | biu_bk_valid;
assign s39 = s42 & s38 & ~s44[1] & ~s44[7] & ~s44[0];
assign s26 = (ilm_resp_valid & (m1_id == s12)) | (dlm_resp_valid0 & (m1_id == dlm0_resp_id)) | (dlm_resp_valid1 & (m1_id == dlm1_resp_id)) | (dlm_resp_valid2 & (m1_id == dlm2_resp_id)) | (dlm_resp_valid3 & (m1_id == dlm3_resp_id)) | (dcu_ack_valid & (m1_id == dcu_ack_id) & (~m1_load | m1_nbload | s58 | s59 | s60 | s62));
assign s19 = m2_stall & s26;
assign s18 = ~m2_stall;
assign s21 = s19 | s18;
assign s20 = ~s18 & (s17 | s19);
assign s28 = (dlm_resp_valid0 & (m2_id == dlm0_resp_id)) | (dlm_resp_valid1 & (m2_id == dlm1_resp_id)) | (dlm_resp_valid2 & (m2_id == dlm2_resp_id)) | (dlm_resp_valid3 & (m2_id == dlm3_resp_id)) | (dcu_ack_valid & (m2_id == dcu_ack_id) & (~m2_load | m2_nbload | s58 | s59));
assign s29 = (ilm_resp_valid & (m2_id == s12)) | (dcu_ack_valid & (m2_id == dcu_ack_id) & (s60 | s62));
assign s27 = s28 | s29;
assign s45 = dcu_cri_valid & (m2_id == dcu_cri_id) & ~s54 & ~s53;
assign s35 = (s46 & s27) | (s46 & s45) | (~m2_stall & s26) | (~m2_stall & s17);
assign s38 = m2_stall ? m2_load : m1_load;
assign s34 = ~m2_stall & ~s17;
assign s37 = s35 | s34;
assign s36 = s35 | (~s34 & s33);
assign rob_valid = s28 | s33;
assign s3 = (m2_load & rob_valid) | (m2_store & dlm_w_ready);
assign s2 = (m2_load & rob_valid) | (m2_store & ilm_w_ready);
assign s4 = rob_valid;
assign m2_resp_valid = (m2_dlm & s3) | (m2_ilm & s2) | (m2_c & s4) | (m2_biu & biu_resp_valid);
assign s46 = (m2_alive & ~m2_committed) | (m2_valid & m2_ilm & ~s2) | (m2_valid & m2_dlm & ~s3) | (m2_alive & m2_c & ~m2_abort & ~s4) | biu_stall;
assign m2_stall = s46 | (s67 & s68);
assign s68 = ~m2_valid & ~(m1_valid & m1_killed);
assign ls_rob_status = s5;
assign nbload_resp_valid = dcu_cri_valid & s54 & ~s53;
assign nbload_resp_rd = s57;
assign nbload_resp_result = dcu_cri_nbload_result;
assign nbload_resp_status = s55;
assign lsu_async_read_error = nbload_resp_valid & s55;
assign prf_resp_valid = dcu_cri_valid & s53;
assign prf_resp_id = s57;
assign prf_resp_status = s55;
assign s6 = ilm_resp_status;
assign s58 = dcu_ack_status[3];
assign s59 = dcu_ack_status[0];
assign s60 = dcu_ack_status[2];
assign s62 = dcu_ack_status[1];
assign s61 = dcu_ack_status[18];
assign s7[0] = dcu_ack_status[0];
assign s7[1] = dcu_ack_status[1];
assign s7[2] = dcu_ack_status[2];
assign s7[3 +:3] = s61 ? 3'd1 : 3'd7;
assign s7[6] = dcu_ack_status[17];
assign s7[7] = dcu_ack_status[4];
assign s7[9 +:8] = dcu_ack_status[7 +:8];
assign s7[17] = dcu_ack_status[15];
assign s7[18 +:4] = {3'd2,dcu_ack_status[16]};
assign s7[22] = dcu_ack_status[6];
assign s7[8] = dcu_ack_status[5];
assign s9[0] = 1'b0;
assign s9[1] = 1'b0;
assign s9[2] = s55;
assign s9[3 +:3] = 3'd3;
assign s9[6] = s56;
assign s9[7] = 1'b0;
assign s9[9 +:8] = 8'b0;
assign s9[17] = 1'b0;
assign s9[18 +:4] = 4'd0;
assign s9[22] = 1'b0;
assign s9[8] = 1'b1;
assign s10 = dcu_cri_rdata;
assign s8[0] = 1'b0;
assign s8[1] = 1'b0;
assign s8[2] = biu_bk_error | (m2_lr & ~biu_bk_exokay);
assign s8[3 +:3] = 3'd3;
assign s8[6] = biu_bk_exokay;
assign s8[7] = 1'b0;
assign s8[9 +:8] = 8'b0;
assign s8[17] = 1'b0;
assign s8[18 +:4] = 4'd0;
assign s8[22] = 1'b0;
assign s8[8] = 1'b0;
assign s11 = m2_biu & m2_store & ~m2_sc;
wire nds_unused_m0_load = m0_load;
wire nds_unused_m0_dcu = m0_dcu;
wire nds_unused_m0_dlm = m0_dlm;
endmodule


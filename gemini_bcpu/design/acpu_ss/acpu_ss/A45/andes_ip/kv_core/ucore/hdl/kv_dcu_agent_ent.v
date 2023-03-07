// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_agent_ent (
    dcu_clk,
    dcu_reset_n,
    a_free,
    c_free,
    mshr_ptr,
    evb_ptr,
    a_grant_first,
    a_opcode,
    a_param,
    a_mshr_ptr,
    c_grant_first,
    c_opcode,
    c_evb_ptr,
    d_grant,
    d_opcode,
    d_param,
    d_offset,
    d_last
);
parameter DCU_DATA_WIDTH = 32;
parameter MSHR_DEPTH = 3;
parameter EVB_DEPTH = 3;
parameter CM_SUPPORT_INT = 0;
input dcu_clk;
input dcu_reset_n;
output a_free;
output c_free;
output [MSHR_DEPTH - 1:0] mshr_ptr;
output [EVB_DEPTH - 1:0] evb_ptr;
input a_grant_first;
input [2:0] a_opcode;
input [2:0] a_param;
input [MSHR_DEPTH - 1:0] a_mshr_ptr;
input c_grant_first;
input [2:0] c_opcode;
input [EVB_DEPTH - 1:0] c_evb_ptr;
input d_grant;
input [2:0] d_opcode;
input [1:0] d_param;
output [5:3] d_offset;
output d_last;


wire s0 = (CM_SUPPORT_INT == 1);
wire s1 = (DCU_DATA_WIDTH >= 128);
wire s2 = (DCU_DATA_WIDTH >= 256);
wire [5:3] s3 = DCU_DATA_WIDTH[8:6];
reg s4;
wire s5;
wire s6;
wire s7;
wire s8;
reg s9;
wire s10;
wire s11;
wire s12;
wire s13;
reg s14;
wire s15;
wire s16;
wire s17;
wire s18;
reg [MSHR_DEPTH - 1:0] mshr_ptr;
reg [EVB_DEPTH - 1:0] evb_ptr;
reg [5:3] d_offset;
wire [5:3] s19;
wire [5:3] s20 = d_offset + s3;
wire s21;
wire s22;
wire s23 = (a_opcode == 3'd1);
wire s24 = (d_opcode == 3'd6);
wire s25 = (d_opcode == 3'd0);
wire s26 = (d_opcode == 3'd1);
wire s27 = (d_opcode == 3'd5);
wire s28 = (d_opcode == 3'd4);
wire s29 = (c_opcode == 3'd6);
wire s30 = (c_opcode == 3'd7);
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        s4 <= 1'd0;
    end
    else if (s5) begin
        s4 <= s6;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        s14 <= 1'd0;
    end
    else if (s15) begin
        s14 <= s16;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        s9 <= 1'd0;
    end
    else if (s10) begin
        s9 <= s11;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        d_offset <= 3'd0;
    end
    else if (s21) begin
        d_offset <= s19;
    end
end

always @(posedge dcu_clk) begin
    if (s7) begin
        mshr_ptr <= a_mshr_ptr;
    end
end

always @(posedge dcu_clk) begin
    if (s12) begin
        evb_ptr <= c_evb_ptr;
    end
end

assign s5 = s7 | s8;
assign s6 = s7 | (s4 & ~s8);
assign s7 = a_grant_first;
assign s8 = d_grant & d_last & (s25 | s26 | s27 | s28);
assign s15 = s17 | s18;
assign s16 = s17 | (s14 & ~s18);
assign s17 = a_grant_first & s23;
assign s18 = d_grant & d_last & s25;
assign s10 = s12 | s13;
assign s11 = s12 | (s9 & ~s13);
assign s12 = c_grant_first & (s29 | s30);
assign s13 = d_grant & s24;
assign s22 = s24 | s25 | s28 | s26;
assign s21 = a_grant_first | (d_grant & ~s22);
assign s19 = a_grant_first ? 3'd0 : d_last ? 3'd0 : s20;
assign d_last = s22 | (d_offset[5] & (d_offset[4] | s2) & (d_offset[3] | s1));
assign a_free = ~s4;
assign c_free = ~s9 & (~s14 | s0);
wire nds_unused_signals = |{a_param,d_param};
endmodule


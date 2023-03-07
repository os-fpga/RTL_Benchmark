// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_alu (
    alu_op0,
    alu_op1,
    alu_bop0,
    alu_bop1,
    alu_func,
    alu_result,
    alu_aresult,
    alu_bresult
);
parameter RVA_SUPPORT_INT = 0;
parameter ISA_LEA_INT = 0;
parameter ISA_BFO_INT = 0;
parameter ISA_STR_INT = 0;
localparam SHAMT_WIDTH = 5;
input [31:0] alu_op0;
input [31:0] alu_op1;
input [31:0] alu_bop0;
input [31:0] alu_bop1;
input [35:0] alu_func;
output [31:0] alu_result;
output [31:0] alu_aresult;
output [31:0] alu_bresult;


wire s0 = alu_func[32];
wire s1 = alu_func[27];
wire s2 = alu_func[33];
wire s3 = alu_func[30];
wire s4 = alu_func[13];
wire s5 = alu_func[13];
wire [31:0] alu_op1;
wire [31:0] s6 = alu_op0;
wire [31:0] s7 = alu_op1 ^ {32{s0}};
wire [32:0] s8 = {1'b0,s6} + {1'b0,s7} + {{32{1'b0}},s0};
wire [31:0] s9;
wire [31:0] s10;
wire [31:0] s11;
wire [31:0] s12;
wire [31:0] s13;
wire [31:0] s14;
wire [31:0] s15;
wire [31:0] s16;
wire [31:0] s17;
wire s18 = ~s8[32];
wire s19 = (alu_op0[31] & ~alu_op1[31]) | ((alu_op0[31] == alu_op1[31]) & s8[31]);
wire [31:0] s20;
wire [31:0] s21;
wire [31:0] s22;
assign s10 = alu_bop0 & (alu_bop1 ^ {32{s4}});
assign s11 = alu_bop0 | (alu_bop1 ^ {32{s4}});
assign s12 = (alu_bop0 ^ alu_bop1) ^ {32{s4}};
wire [3:0] s23 = alu_func[22 +:4];
generate
    if ((ISA_LEA_INT == 1) || 1'b0) begin:gen_alu_op1_shout
        wire s24 = alu_func[12];
        wire [63:0] s25;
        wire [31:0] s26;
        assign s25[31:0] = alu_op1[31:0];
        assign s25[63:32] = alu_op1[31:0] & {32{~s24}};
        assign s26 = ({32{s23[0]}} & {s25[31:0]}) | ({32{s23[1]}} & {s25[30:0],1'b0}) | ({32{s23[2]}} & {s25[29:0],2'b0}) | ({32{s23[3]}} & {s25[28:0],3'b0});
        assign s9 = alu_op0 + s26;
    end
    else begin:gen_alu_op1_shout
        assign s9 = {32{1'b0}};
    end
endgenerate
generate
    if ((ISA_STR_INT == 1)) begin:gen_str_result_yes
        wire [7:0] s27;
        wire [7:0] s28;
        wire [7:0] s29;
        wire [3:0] s30 = s23;
        wire [31:0] s31;
        wire [31:0] s32;
        wire [31:0] s33;
        wire [31:0] s34;
        assign s27[0] = alu_op0[7:0] == alu_op1[7:0];
        assign s27[1] = alu_op0[15:8] == alu_op1[15:8];
        assign s27[2] = alu_op0[23:16] == alu_op1[23:16];
        assign s27[3] = alu_op0[31:24] == alu_op1[31:24];
        assign s27[4] = alu_op0[7:0] == alu_op1[7:0];
        assign s27[5] = alu_op0[15:8] == alu_op1[15:8];
        assign s27[6] = alu_op0[23:16] == alu_op1[23:16];
        assign s27[7] = alu_op0[31:24] == alu_op1[31:24];
        assign s28[0] = ~|alu_op0[7:0];
        assign s28[1] = ~|alu_op0[15:8];
        assign s28[2] = ~|alu_op0[23:16];
        assign s28[3] = ~|alu_op0[31:24];
        assign s28[4] = ~|alu_op0[7:0];
        assign s28[5] = ~|alu_op0[15:8];
        assign s28[6] = ~|alu_op0[23:16];
        assign s28[7] = ~|alu_op0[31:24];
        assign s29[0] = alu_op0[7:0] == alu_op1[7:0];
        assign s29[1] = alu_op0[15:8] == alu_op1[7:0];
        assign s29[2] = alu_op0[23:16] == alu_op1[7:0];
        assign s29[3] = alu_op0[31:24] == alu_op1[7:0];
        assign s29[4] = alu_op0[7:0] == alu_op1[7:0];
        assign s29[5] = alu_op0[15:8] == alu_op1[7:0];
        assign s29[6] = alu_op0[23:16] == alu_op1[7:0];
        assign s29[7] = alu_op0[31:24] == alu_op1[7:0];
        assign s31 = (s29[4]) ? {{28{1'b1}},4'hc} : (s29[5]) ? {{28{1'b1}},4'hd} : (s29[6]) ? {{28{1'b1}},4'he} : (s29[7]) ? {{28{1'b1}},4'hf} : {{28{1'b0}},4'd0};
        assign s32 = ((~s27[4] | s28[4])) ? {{28{1'b1}},4'hc} : ((~s27[5] | s28[5])) ? {{28{1'b1}},4'hd} : ((~s27[6] | s28[6])) ? {{28{1'b1}},4'he} : ((~s27[7] | s28[7])) ? {{28{1'b1}},4'hf} : {{28{1'b0}},4'h0};
        assign s33 = (~s27[4]) ? {{28{1'b1}},4'hc} : (~s27[5]) ? {{28{1'b1}},4'hd} : (~s27[6]) ? {{28{1'b1}},4'he} : (~s27[7]) ? {{28{1'b1}},4'hf} : {{28{1'b0}},4'h0};
        assign s34 = (~s27[7]) ? {{28{1'b1}},4'hf} : (~s27[6]) ? {{28{1'b1}},4'he} : (~s27[5]) ? {{28{1'b1}},4'hd} : (~s27[4]) ? {{28{1'b1}},4'hc} : {{28{1'b0}},4'h0};
        assign s13 = ({32{s30[0]}} & s31) | ({32{s30[1]}} & s32) | ({32{s30[2]}} & s33) | ({32{s30[3]}} & s34);
    end
    else begin:gen_str_result_no
        assign s13 = {32{1'b0}};
    end
endgenerate
assign s14[31:0] = s8[31:0];
wire s35 = alu_func[21];
assign s21 = alu_op0[31:0];
generate
    genvar i;
    for (i = 0; i < 32; i = i + 1) begin:gen_shift_left_in
        assign s22[i] = s21[32 - i - 1];
    end
endgenerate
wire [31:0] s36 = s1 ? s22[31:0] : s21;
wire [63:0] s37 = {s35 ? s36 : {32{s3 & ~s1 & s36[31]}},s36};
wire [SHAMT_WIDTH - 1:0] s38 = (s2 & ~s5) ? {1'b0,alu_op1[SHAMT_WIDTH - 2:0]} : alu_op1[SHAMT_WIDTH - 1:0];
wire [63:0] s39 = s37 >> s38;
wire [31:0] s40 = s39[31:0];
generate
    genvar j;
    for (j = 0; j < 32; j = j + 1) begin:gen_shift_left_out
        assign s20[j] = s40[32 - j - 1];
    end
endgenerate
assign s15 = s1 ? s20 : s40;
assign s16[31:0] = s15[31:0];
generate
    if ((ISA_BFO_INT == 1)) begin:gen_bfext_result
        wire [SHAMT_WIDTH - 1:0] s41 = alu_op1[SHAMT_WIDTH + 5:6];
        wire [SHAMT_WIDTH - 1:0] s42 = s41 - s38;
        wire [31:0] s43 = {32{1'b1}} >> ~s42;
        wire [31:0] s44 = {32{1'b1}} >> ~s41;
        wire s45 = alu_op0[s41] & s3 & ~s1;
        wire s46 = alu_op0[s42] & s3 & s1;
        assign s17 = (s43 & {32{~s1}} & s40) | (s44 & {32{s1}} & s20) | (~s43 & {32{s45}}) | (~s44 & {32{s46}});
    end
    else begin:gen_bfext_result_dontcare
        assign s17 = {32{1'b0}};
    end
endgenerate
wire [31:0] s47;
wire [31:0] s48;
wire [31:0] s49;
wire [31:0] s50;
wire [31:0] s51;
assign s48 = {32{1'b0}};
assign s49 = {32{1'b0}};
assign s50 = {32{1'b0}};
assign s51 = {32{1'b0}};
wire [31:0] s52;
assign s52 = {32{1'b0}};
assign s47 = {32{1'b0}};
wire [31:0] s53;
assign s53 = {32{1'b0}};
wire [31:0] s54;
assign s54 = {32{1'b0}};
wire [31:0] s55;
assign s55 = {32{1'b0}};
wire [31:0] s56;
assign s56 = {32{1'b0}};
wire [31:0] s57;
wire [31:0] s58;
wire [31:0] s59;
wire [31:0] s60;
assign s57 = {32{1'b0}};
assign s58 = {32{1'b0}};
assign s59 = {32{1'b0}};
assign s60 = {32{1'b0}};
assign alu_bresult = ({32{alu_func[1]}} & s10) | ({32{alu_func[18]}} & s11) | ({32{alu_func[34]}} & s12);
assign alu_aresult = ({32{alu_func[0]}} & s14) | ({32{alu_func[26]}} & s16) | ({32{alu_func[28]}} & {{31{1'b0}},s19}) | ({32{alu_func[29]}} & {{31{1'b0}},s18}) | ({32{alu_func[2]}} & s17) | ({32{alu_func[31]}} & s13) | ({32{alu_func[11]}} & s9) | ({32{alu_func[7]}} & s9) | ({32{alu_func[14]}} & s48) | ({32{alu_func[16]}} & s49) | ({32{alu_func[15]}} & s50) | ({32{alu_func[17]}} & s51) | ({32{alu_func[9]}} & s52) | ({32{alu_func[10]}} & s47) | ({32{alu_func[35]}} & s53) | ({32{alu_func[19]}} & s54) | ({32{alu_func[20]}} & s55) | ({32{alu_func[8]}} & s56) | ({32{alu_func[4]}} & s57) | ({32{alu_func[6]}} & s58) | ({32{alu_func[3]}} & s59) | ({32{alu_func[5]}} & s60) | alu_bresult;
assign alu_result = alu_aresult;
endmodule


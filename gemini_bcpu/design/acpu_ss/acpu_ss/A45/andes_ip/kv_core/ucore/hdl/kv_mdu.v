// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_mdu (
    core_clk,
    core_reset_n,
    mdu_req_valid,
    mdu_req_tag,
    mdu_req_func,
    mdu_req_op0,
    mdu_req_op1,
    mdu_req_ready,
    mdu_kill,
    mdu_resp_valid,
    mdu_resp_tag,
    mdu_resp_result,
    mdu_resp_ready
);
parameter MULTIPLIER_INT = 1;
localparam MUL_DIGIT = ((MULTIPLIER_INT == 0)) ? 1 : ((MULTIPLIER_INT == 1)) ? 1 : ((MULTIPLIER_INT == 2)) ? 2 : ((MULTIPLIER_INT == 3)) ? 4 : 8;
localparam CNT_BIT = 6;
localparam LEN = 32;
localparam MUL_PIPE = ((MUL_DIGIT > 4));
localparam MUL_END_CNT = (LEN / MUL_DIGIT) - 1;
localparam DIV_END_CNT = 32;
localparam ADDER_BIT = 32 + MUL_DIGIT;
localparam [2:0] IDLE = 3'b000;
localparam [2:0] PRE = 3'b001;
localparam [2:0] EXE = 3'b010;
localparam [2:0] POST = 3'b011;
localparam [2:0] DONE = 3'b100;
localparam [2:0] DIV_SHIFT = 3'b101;
localparam [2:0] MUL_OPERAND = 3'b110;
localparam MDUOP_MUL = 4'b0000;
localparam MDUOP_MULH = 4'b0001;
localparam MDUOP_MULHU = 4'b0010;
localparam MDUOP_MULHSU = 4'b0011;
localparam MDUOP_DIV = 4'b0100;
localparam MDUOP_DIVU = 4'b0101;
localparam MDUOP_REM = 4'b0110;
localparam MDUOP_REMU = 4'b0111;
localparam MDUOP_MULW = 4'b1000;
localparam MDUOP_DIVW = 4'b1100;
localparam MDUOP_DIVUW = 4'b1101;
localparam MDUOP_REMW = 4'b1110;
localparam MDUOP_REMUW = 4'b1111;
input core_clk;
input core_reset_n;
input mdu_req_valid;
input [4:0] mdu_req_tag;
input [3:0] mdu_req_func;
input [31:0] mdu_req_op0;
input [31:0] mdu_req_op1;
output mdu_req_ready;
input mdu_kill;
output mdu_resp_valid;
output [4:0] mdu_resp_tag;
output [31:0] mdu_resp_result;
input mdu_resp_ready;


reg [2:0] s0;
reg [2:0] s1;
reg [64:0] s2;
wire [64:0] s3;
wire s4;
reg [31:0] s5;
wire [31:0] s6;
wire s7;
reg [4:0] s8;
reg [3:0] s9;
wire s10;
reg s11;
reg s12;
reg [CNT_BIT - 1:0] s13;
wire [CNT_BIT - 1:0] s14;
wire [CNT_BIT - 1:0] s15 = s13 + {{(CNT_BIT - 1){1'b0}},1'b1};
wire s16 = s13 == {(CNT_BIT){1'b0}};
wire s17;
wire s18;
reg [CNT_BIT - 1:0] s19;
wire [CNT_BIT - 1:0] s20;
wire [ADDER_BIT - 1:0] s21;
wire [ADDER_BIT - 1:0] s22;
wire [ADDER_BIT - 1:0] s23;
reg s24;
reg s25;
reg s26;
reg s27;
reg s28;
reg [ADDER_BIT - 1:0] s29;
wire s30;
wire [64:0] s31;
wire [31:0] s32;
wire s33;
wire s34;
wire s35 = mdu_req_valid & mdu_req_ready & ~mdu_kill;
assign mdu_resp_valid = s0 == POST | s0 == DONE;
assign mdu_req_ready = s0 == IDLE;
assign mdu_resp_tag = s8;
wire s36 = ~s9[2];
wire s37 = s9[3];
wire s38 = (mdu_req_func[2] & ~mdu_req_func[0]) | (mdu_req_func == MDUOP_MUL) | (mdu_req_func == MDUOP_MULH) | (mdu_req_func == MDUOP_MULHSU);
wire s39 = (mdu_req_func[2] & ~mdu_req_func[0]) | (mdu_req_func == MDUOP_MUL) | (mdu_req_func == MDUOP_MULH);
wire s40 = (s9[2] & s9[1]) | (s9 == MDUOP_MULH) | (s9 == MDUOP_MULHSU) | (s9 == MDUOP_MULHU);
wire s41 = ~((s0 == IDLE) & ~s35);
assign s10 = ~s36 & s25 & (s2[31:0] == 32'h8000_0000) & (s5[31:0] == 32'hFFFF_FFFF);
assign s30 = ~s36 & s5[31:0] == 32'b0;
assign s31 = {33'b0,mdu_req_op0};
assign s32 = mdu_req_op1;
assign s33 = s38 & mdu_req_op0[31];
assign s34 = s39 & mdu_req_op1[31];
wire [63:0] s42;
wire [31:0] s43;
wire [64:0] s44;
wire [31:0] s45;
wire s46;
wire s47;
wire s48;
assign s42 = ~s2[63:0] + {{63{1'b0}},1'b1};
assign s43 = ~s5[31:0] + 32'b1;
assign s44 = s2[31] ? {33'b0,s42[31:0]} : s2[64:0];
assign s45 = s5[31] ? s43 : s5;
assign s46 = s40 & ~s36 & s2[31];
assign s47 = s36 & ((s9 == MDUOP_MULHSU) ? s2[31] : s2[31] ^ s5[31]);
assign s48 = ~s40 & ~s36 & (s2[31] ^ s5[31]);
wire nds_unused_w_op = s37;
wire s49 = s46 | s47 | s48;
wire [1:0] s50[0:15];
wire s51[0:15];
wire [1:0] s52[0:15];
wire s53[0:15];
wire [2:0] s54[0:7];
wire s55[0:7];
wire [2:0] s56[0:7];
wire s57[0:7];
wire [3:0] s58[0:3];
wire s59[0:3];
wire [3:0] s60[0:3];
wire s61[0:3];
wire [4:0] s62[0:1];
wire s63[0:1];
wire [4:0] s64[0:1];
wire s65[0:1];
wire [CNT_BIT - 1:0] s66;
wire [CNT_BIT - 1:0] s67;
generate
    genvar i_lzd4;
    for (i_lzd4 = 0; i_lzd4 < 16; i_lzd4 = i_lzd4 + 1) begin:gen_lzd4
        if (1'b1 & (i_lzd4 > 7)) begin:gen_gen_lzd4_block1
            assign s50[i_lzd4][1] = 1'b0;
            assign s50[i_lzd4][0] = 1'b0;
            assign s51[i_lzd4] = 1'b0;
            assign s52[i_lzd4][1] = 1'b0;
            assign s52[i_lzd4][0] = 1'b0;
            assign s53[i_lzd4] = 1'b0;
        end
        else begin:gen_gen_lzd4_block2
            assign s50[i_lzd4][1] = ~s2[i_lzd4 * 4 + 3] & ~s2[i_lzd4 * 4 + 2];
            assign s50[i_lzd4][0] = (~s2[i_lzd4 * 4 + 3] & ~s2[i_lzd4 * 4 + 1]) | (~s2[i_lzd4 * 4 + 3] & s2[i_lzd4 * 4 + 2]);
            assign s51[i_lzd4] = |(s2[i_lzd4 * 4 + 3:i_lzd4 * 4]);
            assign s52[i_lzd4][1] = ~s5[i_lzd4 * 4 + 3] & ~s5[i_lzd4 * 4 + 2];
            assign s52[i_lzd4][0] = (~s5[i_lzd4 * 4 + 3] & ~s5[i_lzd4 * 4 + 1]) | (~s5[i_lzd4 * 4 + 3] & s5[i_lzd4 * 4 + 2]);
            assign s53[i_lzd4] = |(s5[i_lzd4 * 4 + 3:i_lzd4 * 4]);
        end
    end
endgenerate
generate
    genvar i_lzd8;
    for (i_lzd8 = 0; i_lzd8 < 8; i_lzd8 = i_lzd8 + 1) begin:gen_lzd8
        assign s54[i_lzd8] = s51[i_lzd8 * 2 + 1] ? {1'b0,s50[i_lzd8 * 2 + 1]} : {1'b1,s50[i_lzd8 * 2]};
        assign s55[i_lzd8] = s51[i_lzd8 * 2 + 1] | s51[i_lzd8 * 2];
        assign s56[i_lzd8] = s53[i_lzd8 * 2 + 1] ? {1'b0,s52[i_lzd8 * 2 + 1]} : {1'b1,s52[i_lzd8 * 2]};
        assign s57[i_lzd8] = s53[i_lzd8 * 2 + 1] | s53[i_lzd8 * 2];
    end
endgenerate
generate
    genvar i_lzd16;
    for (i_lzd16 = 0; i_lzd16 < 4; i_lzd16 = i_lzd16 + 1) begin:gen_lzd16
        assign s58[i_lzd16] = s55[i_lzd16 * 2 + 1] ? {1'b0,s54[i_lzd16 * 2 + 1]} : {1'b1,s54[i_lzd16 * 2]};
        assign s59[i_lzd16] = s55[i_lzd16 * 2 + 1] | s55[i_lzd16 * 2];
        assign s60[i_lzd16] = s57[i_lzd16 * 2 + 1] ? {1'b0,s56[i_lzd16 * 2 + 1]} : {1'b1,s56[i_lzd16 * 2]};
        assign s61[i_lzd16] = s57[i_lzd16 * 2 + 1] | s57[i_lzd16 * 2];
    end
endgenerate
generate
    genvar i_lzd32;
    for (i_lzd32 = 0; i_lzd32 < 2; i_lzd32 = i_lzd32 + 1) begin:gen_lzd32
        assign s62[i_lzd32] = s59[i_lzd32 * 2 + 1] ? {1'b0,s58[i_lzd32 * 2 + 1]} : {1'b1,s58[i_lzd32 * 2]};
        assign s63[i_lzd32] = s59[i_lzd32 * 2 + 1] | s59[i_lzd32 * 2];
        assign s64[i_lzd32] = s61[i_lzd32 * 2 + 1] ? {1'b0,s60[i_lzd32 * 2 + 1]} : {1'b1,s60[i_lzd32 * 2]};
        assign s65[i_lzd32] = s61[i_lzd32 * 2 + 1] | s61[i_lzd32 * 2];
    end
endgenerate
assign s66 = s63[0] ? {1'b0,s62[0]} : 6'd32;
assign s67 = s65[0] ? {1'b0,s64[0]} : 6'd32;
assign s20 = (s66 > s67) ? 6'd32 : 6'd32 - s67 + s66;
wire [31:0] s68 = s43;
wire [ADDER_BIT - 1:0] s69;
generate
    if (MUL_DIGIT == 1) begin:gen_mul_operand_digit_1
        reg s70;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s70 <= 1'b0;
            end
            else if (s35) begin
                s70 <= mdu_req_op0[0];
            end
            else if (s0 == PRE) begin
                s70 <= s44[0];
            end
            else if (s0 == MUL_OPERAND) begin
                s70 <= s2[1];
            end
            else if (s0 == EXE) begin
                s70 <= s2[2];
            end
        end

        assign s69 = {{(ADDER_BIT - MUL_DIGIT){1'b0}},s70};
        assign s21 = s2[64:32];
    end
    else begin:gen_mul_operand_digit_2_4_8
        reg [MUL_DIGIT - 1:0] s70;
        always @(posedge core_clk) begin
            if (s35) begin
                s70 <= mdu_req_op0[MUL_DIGIT - 1:0];
            end
            else if (s0 == PRE) begin
                s70 <= s44[MUL_DIGIT - 1:0];
            end
            else if (s0 == MUL_OPERAND) begin
                s70 <= s2[MUL_DIGIT * 2 - 1:MUL_DIGIT];
            end
            else if (s0 == EXE) begin
                s70 <= s2[MUL_DIGIT * 3 - 1:MUL_DIGIT * 2];
            end
        end

        assign s69 = {{(ADDER_BIT - MUL_DIGIT){1'b0}},s70};
        assign s21 = {{(MUL_DIGIT - 1){1'b0}},s2[64:32]};
    end
endgenerate
wire [ADDER_BIT - 1:0] s71 = s69 * s5[31:0];
wire [ADDER_BIT - 1:0] s72 = {{(MUL_DIGIT){1'b1}},s5};
assign s22 = s36 ? s29 : s72;
assign s23 = s21 + s22;
assign s18 = s23[ADDER_BIT - 1];
wire [31:0] s73;
wire [31:0] s74;
wire [64:0] s75;
assign s73 = s40 ? (s25 & s26) ? s42[31:0] : s2[31:0] : {32{1'b1}};
assign s74 = s40 ? 32'b0 : {1'b1,31'b0};
assign s75 = s11 ? {33'b0,s73} : {33'b0,s74};
wire [64:0] s76 = s2 << s19;
wire [64:0] s77 = (s11 | s12) ? s75 : (~s36 && s16) ? s76 : (s36) ? {1'b0,s23[ADDER_BIT - 1:0],s2[31:MUL_DIGIT]} : s18 ? {s2[63:0],~s18} : {s23[31:0],s2[31:0],~s18};
wire [63:0] s78;
wire [31:0] s79;
wire [31:0] s80;
wire [31:0] s81;
wire [31:0] s82;
wire [31:0] s83;
wire [64:0] s84;
assign s78 = s42;
assign s79 = s42[31:0];
assign s80 = ~s2[64:33] + 32'b1;
assign s81 = s40 ? s24 ? s78[63:32] : s2[63:32] : s24 ? s42[31:0] : s2[31:0];
assign s82 = s40 ? s24 ? s80 : s2[64:33] : s24 ? s79 : s2[31:0];
assign s83 = s36 ? s81 : s82;
assign s84 = {s2[64:32],s83};
assign mdu_resp_result = (s0 == DONE) ? s2[31:0] : s84[31:0];
always @* begin
    if (mdu_kill) begin
        s1 = IDLE;
    end
    else begin
        case (s0)
            PRE: begin
                s1 = s36 ? MUL_OPERAND : DIV_SHIFT;
            end
            MUL_OPERAND: begin
                s1 = EXE;
            end
            DIV_SHIFT: begin
                s1 = EXE;
            end
            EXE: begin
                if (s11 || s12) begin
                    s1 = DONE;
                end
                else if (s36 && (s13 == MUL_END_CNT[CNT_BIT - 1:0])) begin
                    s1 = POST;
                end
                else if (s13 == DIV_END_CNT[CNT_BIT - 1:0]) begin
                    s1 = POST;
                end
                else begin
                    s1 = EXE;
                end
            end
            POST: begin
                if (mdu_resp_ready) begin
                    s1 = IDLE;
                end
                else begin
                    s1 = DONE;
                end
            end
            DONE: begin
                if (mdu_resp_ready) begin
                    s1 = IDLE;
                end
                else begin
                    s1 = DONE;
                end
            end
            IDLE: begin
                if (s35) begin
                    if (s33 | s34) begin
                        s1 = PRE;
                    end
                    else if (~mdu_req_func[2]) begin
                        s1 = MUL_OPERAND;
                    end
                    else begin
                        s1 = DIV_SHIFT;
                    end
                end
                else begin
                    s1 = IDLE;
                end
            end
            default: s1 = 3'b0;
        endcase
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s0 <= IDLE;
    end
    else if (s41) begin
        s0 <= s1;
    end
end

always @(posedge core_clk) begin
    if (mdu_req_valid & mdu_req_ready) begin
        s8 <= mdu_req_tag;
        s9 <= mdu_req_func;
    end
end

always @(posedge core_clk) begin
    if (s4) begin
        s2 <= s3;
    end
end

assign s4 = (s0 == PRE) | (s0 == EXE) | (s0 == POST) | (mdu_req_valid & mdu_req_ready);
assign s3 = ({65{(s0 == PRE)}} & s44) | ({65{(s0 == EXE)}} & s77) | ({65{(s0 == POST)}} & s84) | ({65{(s0 == IDLE)}} & s31);
always @(posedge core_clk) begin
    if (s7) begin
        s5 <= s6;
    end
end

assign s6 = ({32{(s0 == PRE)}} & s45) | ({32{(s0 == DIV_SHIFT)}} & s68) | ({32{(s0 == IDLE)}} & s32);
assign s7 = ((s0 == PRE) & s27) | (s0 == DIV_SHIFT) | (mdu_req_valid & mdu_req_ready);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s11 <= 1'b0;
    end
    else if (s28) begin
        s11 <= s30;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s12 <= 1'b0;
    end
    else if (s28) begin
        s12 <= s10;
    end
end

always @(posedge core_clk) begin
    if (s0 == DIV_SHIFT) begin
        s19 <= s20;
    end
end

always @(posedge core_clk) begin
    if (s17) begin
        s13 <= s14;
    end
end

assign s17 = s35 | (s0 == EXE);
assign s14 = s35 ? {(CNT_BIT){1'b0}} : (~s36 && s16) ? s19 : s15;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s24 <= 1'b0;
    end
    else if (s35) begin
        s24 <= 1'b0;
    end
    else if (s0 == PRE) begin
        s24 <= s49;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s25 <= 1'b0;
        s27 <= 1'b0;
    end
    else if (s35) begin
        s25 <= s38;
        s27 <= s39;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s28 <= 1'b0;
    end
    else if (s35) begin
        s28 <= 1'b1;
    end
    else begin
        s28 <= 1'b0;
    end
end

always @(posedge core_clk) begin
    if (s0 == MUL_OPERAND || s0 == EXE) begin
        s29 <= s71;
    end
end

generate
    always @(posedge core_clk or negedge core_reset_n) begin
        if (!core_reset_n) begin
            s26 <= 1'b0;
        end
        else if (s35) begin
            s26 <= mdu_req_op0[31];
        end
        else begin
            s26 <= s26;
        end
    end

endgenerate
endmodule


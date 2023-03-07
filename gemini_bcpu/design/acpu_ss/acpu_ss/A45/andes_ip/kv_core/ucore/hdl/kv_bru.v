// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_bru (
    bru_pc,
    bru_op0,
    bru_op1,
    bru_bop0,
    bru_bop1,
    bru_fn,
    bru_offset,
    bru_type,
    bru_pred_info,
    bru_pred_npc,
    bru_target,
    bru_seq_npc,
    bru_reso_info
);
parameter ISA_BBZ_INT = 0;
parameter VALEN = 32;
parameter EXTVALEN = 32;
parameter ILM_SIZE_KB = 8;
parameter ILM_BASE = 64'h1000_0000;
parameter ILM_AMSB = 15;
localparam TARGET_ADDRESS_BIT_NUMBER = 19;
localparam ALU_BLT = 3'b000;
localparam ALU_BGE = 3'b001;
localparam ALU_BLTU = 3'b010;
localparam ALU_BGEU = 3'b011;
localparam ALU_BEQ = 3'b100;
localparam ALU_BNE = 3'b101;
localparam ALU_BBZ = 3'b110;
localparam ALU_BBN = 3'b111;
localparam SHAMT_WIDTH = 5;
input [EXTVALEN - 1:0] bru_pc;
input [31:0] bru_op0;
input [31:0] bru_op1;
input [31:0] bru_bop0;
input [31:0] bru_bop1;
input [4:0] bru_fn;
input [20:0] bru_offset;
input [8:0] bru_type;
input [11:0] bru_pred_info;
input [EXTVALEN - 1:0] bru_pred_npc;
output [EXTVALEN - 1:0] bru_target;
output [EXTVALEN - 1:0] bru_seq_npc;
output [12:0] bru_reso_info;


wire s0 = bru_type[0];
wire s1 = bru_type[8];
wire s2 = bru_type[1];
wire s3 = bru_type[2];
wire s4 = bru_type[3];
wire s5 = bru_type[4];
wire s6 = bru_type[5] & ~s2;
wire s7 = bru_type[6];
wire s8 = bru_pred_info[11];
wire s9 = bru_pred_info[0];
wire s10 = bru_pred_info[1];
wire [3:0] s11 = bru_pred_info[2 +:4];
wire s12 = bru_pred_info[6];
wire s13 = bru_pred_info[7];
wire [1:0] s14 = bru_pred_info[8 +:2];
wire s15 = bru_pred_info[10];
wire s16;
wire s17;
wire [32:0] s18;
wire [32:0] s19;
wire s20;
wire s21;
wire s22;
wire [EXTVALEN - 1:0] s23;
wire [EXTVALEN - 1:0] s24;
wire [EXTVALEN - 1:0] s25;
wire [EXTVALEN - 1:0] s26;
wire [EXTVALEN - 1:0] s27;
wire [EXTVALEN - 1:0] s28;
wire [EXTVALEN - 1:0] s29;
wire [EXTVALEN - 1:0] s30;
wire s31;
wire s32;
wire s33;
wire nds_unused_top = s7 | s8 | s9 | s10 | (|s11) | s12 | s13 | s15;
assign s18 = (bru_fn[4]) ? {1'b0,bru_op0} : {bru_op0[31],bru_op0};
assign s19 = (bru_fn[4]) ? {1'b0,bru_op1} : {bru_op1[31],bru_op1};
assign s20 = $signed(s18) < $signed(s19);
assign s21 = bru_bop0 != bru_bop1;
generate
    if ((ISA_BBZ_INT == 1)) begin:gen_cmp_bset_bbz_32
        wire [31:0] s34 = {{31{1'b0}},1'b1} << bru_op1[SHAMT_WIDTH - 1:0];
        wire [31:0] s35 = bru_op0[31:0] & s34[31:0];
        assign s22 = |s35[31:0];
    end
    else begin:gen_cmp_bset_dontcare
        assign s22 = 1'b0;
    end
endgenerate
assign s16 = (bru_fn[0] & (bru_fn[3] ^ s21)) | (bru_fn[1] & (bru_fn[3] ^ s20)) | (bru_fn[2] & (bru_fn[3] ^ s22));
generate
    if (ILM_SIZE_KB != 0) begin:gen_hit_ilm
        wire [EXTVALEN - 1:ILM_AMSB + 1] s36 = ILM_BASE[EXTVALEN - 1:ILM_AMSB + 1];
        kv_fasthit #(
            .M(EXTVALEN),
            .N(ILM_AMSB + 1)
        ) u_br_target_hit_ilm (
            .a(s23),
            .b(s24),
            .k(s36[EXTVALEN - 1:ILM_AMSB + 1]),
            .hit(s32)
        );
        kv_fasthit #(
            .M(EXTVALEN),
            .N(ILM_AMSB + 1)
        ) u_seq_npc_hit_ilm (
            .a(bru_pc),
            .b(s27),
            .k(s36[EXTVALEN - 1:ILM_AMSB + 1]),
            .hit(s33)
        );
    end
    else begin:gen_hit_ilm_never
        assign s32 = 1'b0;
        assign s33 = 1'b0;
    end
endgenerate
kv_sign_ext #(
    .OW(EXTVALEN),
    .IW(21)
) u_bru_sign_ext_offset (
    .out(s29),
    .in(bru_offset)
);
kv_zero_ext #(
    .OW(EXTVALEN),
    .IW(21)
) u_bru_zero_ext_offset (
    .out(s30),
    .in(bru_offset)
);
generate
    if (EXTVALEN == VALEN) begin:gen_normal_va
        assign s28[VALEN - 1:0] = bru_op0[VALEN - 1:0];
    end
    else begin:gen_check_va
        wire s37;
        assign s37 = ~bru_type[7] | (&bru_op0[31:VALEN - 1]) | (~|bru_op0[31:VALEN - 1]);
        assign s28[EXTVALEN - 1:0] = bru_op0[EXTVALEN - 1:0];
        assign bru_target[EXTVALEN - 1] = s37 ? s25[VALEN - 1] : ~s25[VALEN - 1];
    end
endgenerate
assign s23 = bru_type[7] ? s28[EXTVALEN - 1:0] : bru_pc;
assign s24 = (s1) ? (s30) : (s29);
assign s25 = s23 + s24;
assign s27 = {{(EXTVALEN - 3){1'b0}},~s0,s0,1'b0};
assign s26 = bru_pc + s27;
assign bru_seq_npc = s26;
assign bru_target[VALEN - 1:0] = {s25[VALEN - 1:1],1'b0};
assign s31 = (s25[EXTVALEN - 1:1] != bru_pred_npc[EXTVALEN - 1:1]);
assign s17 = s2 | (s3 & s16);
assign bru_reso_info[0] = s17;
assign bru_reso_info[2] = s3;
assign bru_reso_info[1] = s2;
assign bru_reso_info[3] = s4;
assign bru_reso_info[4] = s5;
assign bru_reso_info[5 +:2] = s14;
assign bru_reso_info[7] = s32;
assign bru_reso_info[8] = s33;
assign bru_reso_info[9] = s6;
assign bru_reso_info[10] = s31;
assign bru_reso_info[11] = 1'b0;
assign bru_reso_info[12] = 1'b0;
endmodule


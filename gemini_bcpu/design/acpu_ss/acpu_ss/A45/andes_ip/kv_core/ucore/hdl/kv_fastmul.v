// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fastmul (
    core_clk,
    core_reset_n,
    fmul_req,
    fmul_func,
    fmul_op0,
    fmul_op1,
    fmul_stall,
    fmul_result
);
parameter MULTIPLIER_INT = 0;
localparam MDUOP_MUL = 4'b0000;
localparam MDUOP_MULH = 4'b0001;
localparam MDUOP_MULHU = 4'b0010;
localparam MDUOP_MULHSU = 4'b0011;
localparam MDUOP_MULW = 4'b1000;
input core_clk;
input core_reset_n;
input fmul_req;
input [3:0] fmul_func;
input [31:0] fmul_op0;
input [31:0] fmul_op1;
input fmul_stall;
output [31:0] fmul_result;


reg [31:0] mreq_op0;
reg [31:0] mreq_op1;
wire [31:0] mreq_op0_nx;
wire [31:0] mreq_op1_nx;
wire mreq_valid_nx;
reg mreq_valid;
reg mreq_high_product;
reg mreq_wop;
wire [31:0] mreq_op0_neg;
reg mreq_signed;
wire mreq_signed_nx;
reg mreq_mulhsu_condition;
wire mreq_mulhsu_condition_nx;
reg [31:0] mreq_op0_neg_reg;
wire [31:0] mreq_op0_neg_reg_nx;
reg m1_wop;
reg m1_high_product;
wire [63:0] m1_partial_sum_0;
wire [63:0] m1_partial_sum_1;
wire [63:0] m1_partial_sum_2;
wire [64:1] m1_partial_c_0;
wire [64:1] m1_partial_c_1;
wire [64:1] m1_partial_c_2;
wire [63:0] m1_extra_pp;
reg m1_mulhsu_condition;
wire [63:0] mwb_sum;
wire [63:0] mwb_inverse_sum;
wire nds_unused_wire0;
wire nds_unused_wire1;
wire fmul_high_product = (fmul_func == MDUOP_MULH) | (fmul_func == MDUOP_MULHSU) | (fmul_func == MDUOP_MULHU);
wire fmul_op0_msb;
assign mwb_inverse_sum = m1_mulhsu_condition ? ~mwb_sum : mwb_sum;
generate
    if ((MULTIPLIER_INT != 0)) begin:gen_fast_multiplier_disabled
        assign fmul_op0_msb = 1'b0;
        assign fmul_result = {32{1'b0}};
    end
    else begin:gen_xlen32_mul_resp
        assign fmul_op0_msb = fmul_op0[31];
        assign fmul_result = m1_high_product ? mwb_inverse_sum[63:32] : mwb_inverse_sum[31:0];
    end
endgenerate
always @(posedge core_clk) begin
    if (mreq_valid_nx && ~fmul_stall) begin
        mreq_op0 <= mreq_op0_nx;
        mreq_op1 <= mreq_op1_nx;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mreq_high_product <= 1'b0;
        mreq_wop <= 1'b0;
        mreq_signed <= 1'b0;
        mreq_mulhsu_condition <= 1'b0;
    end
    else if (mreq_valid_nx && ~fmul_stall) begin
        mreq_high_product <= fmul_high_product;
        mreq_wop <= fmul_func[3];
        mreq_signed <= mreq_signed_nx;
        mreq_mulhsu_condition <= mreq_mulhsu_condition_nx;
    end
end

always @(posedge core_clk) begin
    if (mreq_valid_nx && ~fmul_stall) begin
        mreq_op0_neg_reg <= mreq_op0_neg_reg_nx;
    end
end

assign mreq_op0_neg_reg_nx = ~mreq_op0_nx;
assign mreq_op0_neg = mreq_op0_neg_reg;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        mreq_valid <= 1'b0;
    end
    else if (!fmul_stall) begin
        mreq_valid <= mreq_valid_nx;
    end
end

assign mreq_valid_nx = fmul_req;
assign mreq_op0_nx = mreq_mulhsu_condition_nx ? ~fmul_op0 + {{31{1'b0}},1'b1} : fmul_op0;
assign mreq_op1_nx = fmul_op1;
assign mreq_signed_nx = (fmul_func == MDUOP_MULH);
assign mreq_mulhsu_condition_nx = (fmul_func == MDUOP_MULHSU) & fmul_op0_msb;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        m1_wop <= 1'b0;
        m1_high_product <= 1'b0;
        m1_mulhsu_condition <= 1'b0;
    end
    else if (mreq_valid && ~fmul_stall) begin
        m1_wop <= mreq_wop;
        m1_high_product <= mreq_high_product;
        m1_mulhsu_condition <= mreq_mulhsu_condition;
    end
end

generate
    reg [63:0] m1_partial_sum_0_reg;
    reg [63:0] m1_partial_sum_1_reg;
    reg [63:1] m1_partial_c_0_reg;
    reg [63:1] m1_partial_c_1_reg;
    wire [63:0] m1_partial_sum_0_reg_nx;
    wire [63:0] m1_partial_sum_1_reg_nx;
    wire [64:1] m1_partial_c_0_reg_nx;
    wire [64:1] m1_partial_c_1_reg_nx;
    assign nds_unused_wire0 = m1_partial_c_0_reg_nx[64] | m1_partial_c_1_reg_nx[64];
    always @(posedge core_clk) begin
        if (mreq_valid && ~fmul_stall) begin
            m1_partial_sum_0_reg <= m1_partial_sum_0_reg_nx;
            m1_partial_sum_1_reg <= m1_partial_sum_1_reg_nx;
            m1_partial_c_0_reg <= m1_partial_c_0_reg_nx[63:1];
            m1_partial_c_1_reg <= m1_partial_c_1_reg_nx[63:1];
        end
    end

    assign m1_partial_sum_0 = m1_partial_sum_0_reg;
    assign m1_partial_sum_1 = m1_partial_sum_1_reg;
    assign m1_partial_sum_2 = 64'b0;
    assign m1_partial_c_0 = {1'b0,m1_partial_c_0_reg};
    assign m1_partial_c_1 = {1'b0,m1_partial_c_1_reg};
    assign m1_partial_c_2 = 64'b0;
    assign m1_extra_pp = 64'b0;
    wire mul_en = mreq_valid;
    wire mdu_signed_ex = mreq_signed;
    wire [31:0] mul_in0 = mreq_op0;
    wire [31:0] mul_in1 = mreq_op1;
    wire [31:0] mul_in0_neg = mreq_op0_neg;
    wire ci0;
    wire ci2;
    wire ci4;
    wire ci6;
    wire ci8;
    wire ci10;
    wire ci12;
    wire ci14;
    wire ci16;
    wire ci18;
    wire ci20;
    wire ci22;
    wire ci24;
    wire ci26;
    wire ci28;
    wire ci30;
    wire [33:0] pp_x0;
    wire [33:0] pp_x2;
    wire [33:0] pp_x4;
    wire [33:0] pp_x6;
    wire [33:0] pp_x8;
    wire [33:0] pp_x10;
    wire [33:0] pp_x12;
    wire [33:0] pp_x14;
    wire [33:0] pp_x16;
    wire [33:0] pp_x18;
    wire [33:0] pp_x20;
    wire [33:0] pp_x22;
    wire [33:0] pp_x24;
    wire [33:0] pp_x26;
    wire [33:0] pp_x28;
    wire [33:0] pp_x30;
    kv_fastmul_recode a00(
        .mul_en(mul_en),
        .partial_y({mul_in1[1:0],1'b0}),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x0)
    );
    kv_fastmul_recode a01(
        .mul_en(mul_en),
        .partial_y(mul_in1[3:1]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x2)
    );
    kv_fastmul_recode a02(
        .mul_en(mul_en),
        .partial_y(mul_in1[5:3]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x4)
    );
    kv_fastmul_recode a03(
        .mul_en(mul_en),
        .partial_y(mul_in1[7:5]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x6)
    );
    kv_fastmul_recode a04(
        .mul_en(mul_en),
        .partial_y(mul_in1[9:7]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x8)
    );
    kv_fastmul_recode a05(
        .mul_en(mul_en),
        .partial_y(mul_in1[11:9]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x10)
    );
    kv_fastmul_recode a06(
        .mul_en(mul_en),
        .partial_y(mul_in1[13:11]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x12)
    );
    kv_fastmul_recode a07(
        .mul_en(mul_en),
        .partial_y(mul_in1[15:13]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x14)
    );
    kv_fastmul_recode a08(
        .mul_en(mul_en),
        .partial_y(mul_in1[17:15]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x16)
    );
    kv_fastmul_recode a09(
        .mul_en(mul_en),
        .partial_y(mul_in1[19:17]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x18)
    );
    kv_fastmul_recode a10(
        .mul_en(mul_en),
        .partial_y(mul_in1[21:19]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x20)
    );
    kv_fastmul_recode a11(
        .mul_en(mul_en),
        .partial_y(mul_in1[23:21]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x22)
    );
    kv_fastmul_recode a12(
        .mul_en(mul_en),
        .partial_y(mul_in1[25:23]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x24)
    );
    kv_fastmul_recode a13(
        .mul_en(mul_en),
        .partial_y(mul_in1[27:25]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x26)
    );
    kv_fastmul_recode a14(
        .mul_en(mul_en),
        .partial_y(mul_in1[29:27]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x28)
    );
    kv_fastmul_recode a15(
        .mul_en(mul_en),
        .partial_y(mul_in1[31:29]),
        .mdu_signed_ex(mdu_signed_ex),
        .mul_in0(mul_in0),
        .mul_in0_neg(mul_in0_neg),
        .recode_pp(pp_x30)
    );
    assign ci0 = recode_cin(mul_en, {mul_in1[1:0],1'b0});
    assign ci2 = recode_cin(mul_en, mul_in1[3:1]);
    assign ci4 = recode_cin(mul_en, mul_in1[5:3]);
    assign ci6 = recode_cin(mul_en, mul_in1[7:5]);
    assign ci8 = recode_cin(mul_en, mul_in1[9:7]);
    assign ci10 = recode_cin(mul_en, mul_in1[11:9]);
    assign ci12 = recode_cin(mul_en, mul_in1[13:11]);
    assign ci14 = recode_cin(mul_en, mul_in1[15:13]);
    assign ci16 = recode_cin(mul_en, mul_in1[17:15]);
    assign ci18 = recode_cin(mul_en, mul_in1[19:17]);
    assign ci20 = recode_cin(mul_en, mul_in1[21:19]);
    assign ci22 = recode_cin(mul_en, mul_in1[23:21]);
    assign ci24 = recode_cin(mul_en, mul_in1[25:23]);
    assign ci26 = recode_cin(mul_en, mul_in1[27:25]);
    assign ci28 = recode_cin(mul_en, mul_in1[29:27]);
    assign ci30 = recode_cin(mul_en, mul_in1[31:29]);
    wire [31:0] pp_x32 = {32{~mdu_signed_ex & mul_in1[31] & mul_en}} & mul_in0;
    wire [63:0] pp00 = {30'b0,2'b10,1'b0,ci30,1'b0,ci28,1'b0,ci26,1'b0,ci24,1'b0,ci22,1'b0,ci20,1'b0,ci18,1'b0,ci16,1'b0,ci14,1'b0,ci12,1'b0,ci10,1'b0,ci8,1'b0,ci6,1'b0,ci4,1'b0,ci2,1'b0,ci0};
    wire [63:0] pp01 = {28'b0,2'b01,pp_x0};
    wire [63:0] pp02 = {26'b0,2'b01,pp_x2,2'b00};
    wire [63:0] pp03 = {24'b0,2'b01,pp_x4,4'b00};
    wire [63:0] pp04 = {22'b0,2'b01,pp_x6,6'b00};
    wire [63:0] pp05 = {20'b0,2'b01,pp_x8,8'b00};
    wire [63:0] pp06 = {18'b0,2'b01,pp_x10,10'b00};
    wire [63:0] pp07 = {16'b0,2'b01,pp_x12,12'b00};
    wire [63:0] pp08 = {14'b0,2'b01,pp_x14,14'b00};
    wire [63:0] pp09 = {12'b0,2'b01,pp_x16,16'b00};
    wire [63:0] pp10 = {10'b0,2'b01,pp_x18,18'b00};
    wire [63:0] pp11 = {8'b0,2'b01,pp_x20,20'b00};
    wire [63:0] pp12 = {6'b0,2'b01,pp_x22,22'b00};
    wire [63:0] pp13 = {4'b0,2'b01,pp_x24,24'b00};
    wire [63:0] pp14 = {2'b0,2'b01,pp_x26,26'b00};
    wire [63:0] pp15 = {2'b01,pp_x28,28'b00};
    wire [63:0] pp16 = {pp_x30,30'b00};
    wire [63:0] pp17 = {pp_x32[31:0],32'b00};
    wire [63:0] pp18 = mreq_mulhsu_condition ? {64{1'b1}} : 64'b0;
    wire [63:0] ps00;
    wire [64:1] pc00;
    wire [63:0] ps01;
    wire [64:1] pc01;
    wire [63:0] ps02;
    wire [64:1] pc02;
    wire [63:0] ps10;
    wire [64:1] pc10;
    kv_fastmul_cmp112 #(
        .WIDTH(64)
    ) b0 (
        .in0(pp00),
        .in1(pp01),
        .in2(pp02),
        .in3(pp03),
        .in4(pp04),
        .in5(pp05),
        .in6(pp06),
        .in7(pp07),
        .in8(pp08),
        .in9(pp09),
        .ina(pp10),
        .s(ps00),
        .c(pc00)
    );
    kv_fastmul_cmp42 #(
        .WIDTH(64)
    ) b1 (
        .in0(pp11),
        .in1(pp12),
        .in2(pp13),
        .in3(pp14),
        .s(ps01),
        .c(pc01)
    );
    kv_fastmul_cmp42 #(
        .WIDTH(64)
    ) b2 (
        .in0(pp15),
        .in1(pp16),
        .in2(pp17),
        .in3(pp18),
        .s(ps02),
        .c(pc02)
    );
    kv_fastmul_cmp42 #(
        .WIDTH(64)
    ) b3 (
        .in0(ps01),
        .in1(ps02),
        .in2({pc01[63:1],1'b0}),
        .in3({pc02[63:1],1'b0}),
        .s(ps10),
        .c(pc10)
    );
    assign m1_partial_sum_0_reg_nx = ps00;
    assign m1_partial_sum_1_reg_nx = ps10;
    assign m1_partial_c_0_reg_nx = pc00;
    assign m1_partial_c_1_reg_nx = pc10;
endgenerate
assign mwb_sum = m1_partial_sum_0 + {m1_partial_c_0[63:1],1'b0} + m1_partial_sum_1 + {m1_partial_c_1[63:1],1'b0};
assign nds_unused_wire1 = m1_partial_c_0[64] | m1_partial_c_1[64] | (|m1_partial_c_2) | m1_wop | (|m1_extra_pp) | (|m1_partial_sum_2);
wire nds_unused_wire = nds_unused_wire0 | nds_unused_wire1 | m1_high_product | (|mwb_inverse_sum);
function  recode_cin;
input mul_en;
input [2:0] partial_y;
begin
    recode_cin = mul_en & (partial_y == 3'b100 || partial_y == 3'b101 || partial_y == 3'b110);
end
endfunction
endmodule


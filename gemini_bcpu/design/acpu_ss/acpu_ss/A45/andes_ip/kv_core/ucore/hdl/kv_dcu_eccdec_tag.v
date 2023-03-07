// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_eccdec_tag (
    tag0_check_en,
    tag1_check_en,
    tag2_check_en,
    tag3_check_en,
    tag0_codeword,
    tag1_codeword,
    tag2_codeword,
    tag3_codeword,
    tag0_corrdata,
    tag1_corrdata,
    tag2_corrdata,
    tag3_corrdata,
    tag0_error,
    tag1_error,
    tag2_error,
    tag3_error
);
parameter DCACHE_WAY = 2;
parameter TAG_RAM_CW = 39;
localparam PW = (TAG_RAM_CW > 39) ? 8 : 7;
localparam CW = (TAG_RAM_CW > 39) ? 72 : 39;
localparam DW = (TAG_RAM_CW > 39) ? 64 : 32;
localparam TAG_RAM_DW = TAG_RAM_CW - PW;
localparam S_BIT = 0;
localparam E_BIT = 1;
localparam M_BIT = 2;
localparam L_BIT = 3;
input tag0_check_en;
input tag1_check_en;
input tag2_check_en;
input tag3_check_en;
input [TAG_RAM_CW - 1:0] tag0_codeword;
input [TAG_RAM_CW - 1:0] tag1_codeword;
input [TAG_RAM_CW - 1:0] tag2_codeword;
input [TAG_RAM_CW - 1:0] tag3_codeword;
output [TAG_RAM_DW - 1:0] tag0_corrdata;
output [TAG_RAM_DW - 1:0] tag1_corrdata;
output [TAG_RAM_DW - 1:0] tag2_corrdata;
output [TAG_RAM_DW - 1:0] tag3_corrdata;
output [1:0] tag0_error;
output [1:0] tag1_error;
output [1:0] tag2_error;
output [1:0] tag3_error;


wire [DW - 1:0] s0;
wire [DW - 1:0] s1;
wire [DW - 1:0] s2;
wire [DW - 1:0] s3;
wire [DW - 1:0] s4;
wire [DW - 1:0] s5;
wire [DW - 1:0] s6;
wire [DW - 1:0] s7;
wire [PW - 1:0] s8;
wire [PW - 1:0] s9;
wire [PW - 1:0] s10;
wire [PW - 1:0] s11;
assign s8 = tag0_codeword[TAG_RAM_DW +:PW];
assign s9 = tag1_codeword[TAG_RAM_DW +:PW];
assign s10 = tag2_codeword[TAG_RAM_DW +:PW];
assign s11 = tag3_codeword[TAG_RAM_DW +:PW];
kv_zero_ext #(
    .OW(DW),
    .IW(TAG_RAM_DW)
) u_tag0_data_ze (
    .out(s0),
    .in(tag0_codeword[TAG_RAM_DW - 1:0])
);
kv_zero_ext #(
    .OW(DW),
    .IW(TAG_RAM_DW)
) u_tag1_data_ze (
    .out(s1),
    .in(tag1_codeword[TAG_RAM_DW - 1:0])
);
kv_zero_ext #(
    .OW(DW),
    .IW(TAG_RAM_DW)
) u_tag2_data_ze (
    .out(s2),
    .in(tag2_codeword[TAG_RAM_DW - 1:0])
);
kv_zero_ext #(
    .OW(DW),
    .IW(TAG_RAM_DW)
) u_tag3_data_ze (
    .out(s3),
    .in(tag3_codeword[TAG_RAM_DW - 1:0])
);
assign tag0_corrdata = s4[TAG_RAM_DW - 1:0];
assign tag1_corrdata = s5[TAG_RAM_DW - 1:0];
assign tag2_corrdata = s6[TAG_RAM_DW - 1:0];
assign tag3_corrdata = s7[TAG_RAM_DW - 1:0];
generate
    if ((DCACHE_WAY > 0) && (TAG_RAM_CW <= 39)) begin:gen_tag0_eccdec32
        wire [PW - 1:0] s12;
        wire nds_unused_tag0_error;
        wire nds_unused_tag0_invalidate;
        wire nds_unused_tag0_replay;
        wire nds_unused_tag0_xcpt;
        kv_eccdec32 u_eccdec(
            .data(s0),
            .parin(s8),
            .check_en(tag0_check_en),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s4),
            .parout(s12),
            .sec(tag0_error[0]),
            .ded(tag0_error[1]),
            .error(nds_unused_tag0_error),
            .invalidate(nds_unused_tag0_invalidate),
            .replay(nds_unused_tag0_replay),
            .xcpt(nds_unused_tag0_xcpt)
        );
    end
endgenerate
generate
    if ((DCACHE_WAY > 0) && (TAG_RAM_CW > 39)) begin:gen_tag0_eccdec64
        wire [PW - 1:0] s12;
        wire nds_unused_tag0_error;
        wire nds_unused_tag0_invalidate;
        wire nds_unused_tag0_replay;
        wire nds_unused_tag0_xcpt;
        kv_eccdec64 u_eccdec(
            .data(s0),
            .parin(s8),
            .check_en(tag0_check_en),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s4),
            .parout(s12),
            .sec(tag0_error[0]),
            .ded(tag0_error[1]),
            .error(nds_unused_tag0_error),
            .invalidate(nds_unused_tag0_invalidate),
            .replay(nds_unused_tag0_replay),
            .xcpt(nds_unused_tag0_xcpt)
        );
    end
endgenerate
generate
    if (DCACHE_WAY <= 0) begin:gen_tag0_eccdec_stub
        assign s4 = {DW{1'b0}};
        assign tag0_error = 2'd0;
    end
endgenerate
generate
    if ((DCACHE_WAY > 1) && (TAG_RAM_CW <= 39)) begin:gen_tag1_eccdec32
        wire [PW - 1:0] s13;
        wire nds_unused_tag1_error;
        wire nds_unused_tag1_invalidate;
        wire nds_unused_tag1_replay;
        wire nds_unused_tag1_xcpt;
        kv_eccdec32 u_eccdec(
            .data(s1),
            .parin(s9),
            .check_en(tag1_check_en),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s5),
            .parout(s13),
            .sec(tag1_error[0]),
            .ded(tag1_error[1]),
            .error(nds_unused_tag1_error),
            .invalidate(nds_unused_tag1_invalidate),
            .replay(nds_unused_tag1_replay),
            .xcpt(nds_unused_tag1_xcpt)
        );
    end
endgenerate
generate
    if ((DCACHE_WAY > 1) && (TAG_RAM_CW > 39)) begin:gen_tag1_eccdec64
        wire [PW - 1:0] s13;
        wire nds_unused_tag1_error;
        wire nds_unused_tag1_invalidate;
        wire nds_unused_tag1_replay;
        wire nds_unused_tag1_xcpt;
        kv_eccdec64 u_eccdec(
            .data(s1),
            .parin(s9),
            .check_en(tag1_check_en),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s5),
            .parout(s13),
            .sec(tag1_error[0]),
            .ded(tag1_error[1]),
            .error(nds_unused_tag1_error),
            .invalidate(nds_unused_tag1_invalidate),
            .replay(nds_unused_tag1_replay),
            .xcpt(nds_unused_tag1_xcpt)
        );
    end
endgenerate
generate
    if (DCACHE_WAY <= 1) begin:gen_tag1_eccdec_stub
        assign s5 = {DW{1'b0}};
        assign tag1_error = 2'd0;
    end
endgenerate
generate
    if ((DCACHE_WAY > 2) && (TAG_RAM_CW <= 39)) begin:gen_tag2_eccdec32
        wire [PW - 1:0] s14;
        wire nds_unused_tag2_error;
        wire nds_unused_tag2_invalidate;
        wire nds_unused_tag2_replay;
        wire nds_unused_tag2_xcpt;
        kv_eccdec32 u_eccdec(
            .data(s2),
            .parin(s10),
            .check_en(tag2_check_en),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s6),
            .parout(s14),
            .sec(tag2_error[0]),
            .ded(tag2_error[1]),
            .error(nds_unused_tag2_error),
            .invalidate(nds_unused_tag2_invalidate),
            .replay(nds_unused_tag2_replay),
            .xcpt(nds_unused_tag2_xcpt)
        );
    end
endgenerate
generate
    if ((DCACHE_WAY > 2) && (TAG_RAM_CW > 39)) begin:gen_tag2_eccdec64
        wire [PW - 1:0] s14;
        wire nds_unused_tag2_error;
        wire nds_unused_tag2_invalidate;
        wire nds_unused_tag2_replay;
        wire nds_unused_tag2_xcpt;
        kv_eccdec64 u_eccdec(
            .data(s2),
            .parin(s10),
            .check_en(tag2_check_en),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s6),
            .parout(s14),
            .sec(tag2_error[0]),
            .ded(tag2_error[1]),
            .error(nds_unused_tag2_error),
            .invalidate(nds_unused_tag2_invalidate),
            .replay(nds_unused_tag2_replay),
            .xcpt(nds_unused_tag2_xcpt)
        );
    end
endgenerate
generate
    if (DCACHE_WAY <= 2) begin:gen_tag2_eccdec_stub
        assign s6 = {DW{1'b0}};
        assign tag2_error = 2'd0;
    end
endgenerate
generate
    if ((DCACHE_WAY > 3) && (TAG_RAM_CW <= 39)) begin:gen_tag3_eccdec32
        wire [PW - 1:0] s15;
        wire nds_unused_tag3_error;
        wire nds_unused_tag3_invalidate;
        wire nds_unused_tag3_replay;
        wire nds_unused_tag3_xcpt;
        kv_eccdec32 u_eccdec(
            .data(s3),
            .parin(s11),
            .check_en(tag3_check_en),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s7),
            .parout(s15),
            .sec(tag3_error[0]),
            .ded(tag3_error[1]),
            .error(nds_unused_tag3_error),
            .invalidate(nds_unused_tag3_invalidate),
            .replay(nds_unused_tag3_replay),
            .xcpt(nds_unused_tag3_xcpt)
        );
    end
endgenerate
generate
    if ((DCACHE_WAY > 3) && (TAG_RAM_CW > 39)) begin:gen_tag3_eccdec64
        wire [PW - 1:0] s15;
        wire nds_unused_tag3_error;
        wire nds_unused_tag3_invalidate;
        wire nds_unused_tag3_replay;
        wire nds_unused_tag3_xcpt;
        kv_eccdec64 u_eccdec(
            .data(s3),
            .parin(s11),
            .check_en(tag3_check_en),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s7),
            .parout(s15),
            .sec(tag3_error[0]),
            .ded(tag3_error[1]),
            .error(nds_unused_tag3_error),
            .invalidate(nds_unused_tag3_invalidate),
            .replay(nds_unused_tag3_replay),
            .xcpt(nds_unused_tag3_xcpt)
        );
    end
endgenerate
generate
    if (DCACHE_WAY <= 3) begin:gen_tag3_eccdec_stub
        assign s7 = {DW{1'b0}};
        assign tag3_error = 2'd0;
    end
endgenerate
wire nds_unused_signals = |{tag1_check_en,tag2_check_en,tag3_check_en,s1,s2,s3,s9,s10,s11};
endmodule


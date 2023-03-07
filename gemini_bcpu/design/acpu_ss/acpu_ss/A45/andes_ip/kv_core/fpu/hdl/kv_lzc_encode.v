// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lzc_encode (
    lza_str,
    lzc
);
parameter WIDTH = 128;
localparam ENCODE_WIDTH = $clog2(WIDTH);
input [WIDTH - 1:0] lza_str;
output [ENCODE_WIDTH - 1:0] lzc;


generate
    if (WIDTH == 32) begin:gen_lzc_encode32
        wire [1:0] lzc_or_l1;
        wire [1:0] lzc_or_l2;
        wire [1:0] lzc_or_l3;
        wire [31:0] lza_str_l0;
        wire [15:0] lza_str_l1;
        wire [7:0] lza_str_l2;
        wire [3:0] lza_str_l3;
        wire [1:0] lza_str_l4;
        assign lzc_or_l1[0] = ~|lza_str[31 -:8];
        assign lzc_or_l1[1] = ~|lza_str[31 - 16 -:8];
        assign lzc_or_l2[0] = ~lzc[4] ? ~|lza_str[31 -:4] : ~|lza_str[31 - 16 -:4];
        assign lzc_or_l2[1] = ~lzc[4] ? ~|lza_str[31 - 8 -:4] : ~|lza_str[31 - 24 -:4];
        assign lzc_or_l3[0] = ~lzc[4] ? (~lzc[3] ? ~|lza_str[31 -:2] : ~|lza_str[31 - 8 -:2]) : (~lzc[3] ? ~|lza_str[31 - 16 -:2] : ~|lza_str[31 - 24 -:2]);
        assign lzc_or_l3[1] = ~lzc[4] ? (~lzc[3] ? ~|lza_str[31 - 4 -:2] : ~|lza_str[31 - 12 -:2]) : (~lzc[3] ? ~|lza_str[31 - 20 -:2] : ~|lza_str[31 - 28 -:2]);
        assign lzc[4] = ~|lza_str[31 -:16];
        assign lzc[3] = ~lzc[4] ? lzc_or_l1[0] : lzc_or_l1[1];
        assign lzc[2] = ~lzc[3] ? lzc_or_l2[0] : lzc_or_l2[1];
        assign lzc[1] = ~lzc[2] ? lzc_or_l3[0] : lzc_or_l3[1];
        assign lza_str_l0 = lza_str;
        assign lza_str_l1 = ~lzc[4] ? lza_str_l0[31 -:16] : lza_str_l0[15 -:16];
        assign lza_str_l2 = ~lzc[3] ? lza_str_l1[15 -:8] : lza_str_l1[7 -:8];
        assign lza_str_l3 = ~lzc[2] ? lza_str_l2[7 -:4] : lza_str_l2[3 -:4];
        assign lza_str_l4 = ~lzc[1] ? lza_str_l3[3 -:2] : lza_str_l3[1 -:2];
        assign lzc[0] = ~lza_str_l4[1];
    end
endgenerate
generate
    if (WIDTH == 8) begin:gen_lzc_encode8
        wire [1:0] lzc_or_l1;
        wire [7:0] lza_str_l0;
        wire [3:0] lza_str_l1;
        wire [1:0] lza_str_l2;
        assign lzc_or_l1[0] = ~|lza_str[(7) -:2];
        assign lzc_or_l1[1] = ~|lza_str[(7 - 4) -:2];
        assign lzc[2] = ~|lza_str[7 -:4];
        assign lzc[1] = ~lzc[2] ? lzc_or_l1[0] : lzc_or_l1[1];
        assign lzc[0] = ~lza_str_l2[1];
        assign lza_str_l0 = lza_str;
        assign lza_str_l1 = ~lzc[2] ? lza_str_l0[7 -:4] : lza_str_l0[3 -:4];
        assign lza_str_l2 = ~lzc[1] ? lza_str_l1[3 -:2] : lza_str_l1[1 -:2];
    end
endgenerate
generate
    if (WIDTH == 64) begin:gen_lzc_encode64
        wire [1:0] lzc_or_l1;
        wire [1:0] lzc_or_l2;
        wire [1:0] lzc_or_l3;
        wire [1:0] lzc_or_l4;
        wire [31:0] lza_str_l1;
        wire [15:0] lza_str_l2;
        wire [7:0] lza_str_l3;
        wire [3:0] lza_str_l4;
        wire [1:0] lza_str_l5;
        assign lzc_or_l1[0] = ~|lza_str[63 -:16];
        assign lzc_or_l1[1] = ~|lza_str[63 - 32 -:16];
        assign lzc_or_l2[0] = ~lzc[5] ? ~|lza_str[63 -:8] : ~|lza_str[63 - 32 -:8];
        assign lzc_or_l2[1] = ~lzc[5] ? ~|lza_str[63 - 16 -:8] : ~|lza_str[63 - 48 -:8];
        assign lzc_or_l3[0] = ~lzc[5] ? (~lzc[4] ? ~|lza_str[63 -:4] : ~|lza_str[63 - 16 -:4]) : (~lzc[4] ? ~|lza_str[63 - 32 -:4] : ~|lza_str[63 - 48 -:4]);
        assign lzc_or_l3[1] = ~lzc[5] ? (~lzc[4] ? ~|lza_str[63 - 8 -:4] : ~|lza_str[63 - 24 -:4]) : (~lzc[4] ? ~|lza_str[63 - 40 -:4] : ~|lza_str[63 - 56 -:4]);
        assign lzc_or_l4[0] = ~lzc[5] ? (~lzc[4] ? (~lzc[3] ? ~|lza_str[63 -:2] : ~|lza_str[63 - 8 -:2]) : (~lzc[3] ? ~|lza_str[63 - 16 -:2] : ~|lza_str[63 - 24 -:2])) : (~lzc[4] ? (~lzc[3] ? ~|lza_str[63 - 32 -:2] : ~|lza_str[63 - 40 -:2]) : (~lzc[3] ? ~|lza_str[63 - 48 -:2] : ~|lza_str[63 - 56 -:2]));
        assign lzc_or_l4[1] = ~lzc[5] ? (~lzc[4] ? (~lzc[3] ? ~|lza_str[63 - 4 -:2] : ~|lza_str[63 - 12 -:2]) : (~lzc[3] ? ~|lza_str[63 - 20 -:2] : ~|lza_str[63 - 28 -:2])) : (~lzc[4] ? (~lzc[3] ? ~|lza_str[63 - 36 -:2] : ~|lza_str[63 - 44 -:2]) : (~lzc[3] ? ~|lza_str[63 - 52 -:2] : ~|lza_str[63 - 60 -:2]));
        assign lzc[5] = ~|lza_str[63 -:32];
        assign lzc[4] = ~lzc[5] ? lzc_or_l1[0] : lzc_or_l1[1];
        assign lzc[3] = ~lzc[4] ? lzc_or_l2[0] : lzc_or_l2[1];
        assign lzc[2] = ~lzc[3] ? lzc_or_l3[0] : lzc_or_l3[1];
        assign lzc[1] = ~lzc[2] ? lzc_or_l4[0] : lzc_or_l4[1];
        assign lza_str_l1 = ~lzc[5] ? lza_str[63 -:32] : lza_str[31 -:32];
        assign lza_str_l2 = ~lzc[4] ? lza_str_l1[31 -:16] : lza_str_l1[15 -:16];
        assign lza_str_l3 = ~lzc[3] ? lza_str_l2[15 -:8] : lza_str_l2[7 -:8];
        assign lza_str_l4 = ~lzc[2] ? lza_str_l3[7 -:4] : lza_str_l3[3 -:4];
        assign lza_str_l5 = ~lzc[1] ? lza_str_l4[3 -:2] : lza_str_l4[1 -:2];
        assign lzc[0] = ~lza_str_l5[1];
    end
endgenerate
generate
    if (WIDTH == 128) begin:gen_lzc_encode128
        wire [1:0] lzc_or_l1;
        wire [1:0] lzc_or_l2;
        wire [1:0] lzc_or_l3;
        wire [1:0] lzc_or_l4;
        wire [1:0] lzc_or_l5;
        wire [63:0] lza_str_l1;
        wire [31:0] lza_str_l2;
        wire [15:0] lza_str_l3;
        wire [7:0] lza_str_l4;
        wire [3:0] lza_str_l5;
        wire [1:0] lza_str_l6;
        assign lzc_or_l1[0] = ~|lza_str[127 -:32];
        assign lzc_or_l1[1] = 1'b0;
        assign lzc_or_l2[0] = ~lzc[6] ? ~|lza_str[127 -:16] : ~|lza_str[127 - 64 -:16];
        assign lzc_or_l2[1] = ~lzc[6] ? ~|lza_str[127 - 32 -:16] : 1'b0;
        assign lzc_or_l3[0] = ~lzc[6] ? (~lzc[5] ? ~|lza_str[127 -:8] : ~|lza_str[127 - 32 -:8]) : (~lzc[5] ? ~|lza_str[127 - 64 -:8] : ~|lza_str[127 - 96 -:8]);
        assign lzc_or_l3[1] = ~lzc[6] ? (~lzc[5] ? ~|lza_str[127 - 16 -:8] : ~|lza_str[127 - 48 -:8]) : (~lzc[5] ? ~|lza_str[127 - 80 -:8] : 1'b0);
        assign lzc_or_l4[0] = ~lzc[6] ? (~lzc[5] ? (~lzc[4] ? ~|lza_str[127 -:4] : ~|lza_str[127 - 16 -:4]) : (~lzc[4] ? ~|lza_str[127 - 32 -:4] : ~|lza_str[127 - 48 -:4])) : (~lzc[5] ? (~lzc[4] ? ~|lza_str[127 - 64 -:4] : ~|lza_str[127 - 80 -:4]) : (~lzc[4] ? ~|lza_str[127 - 96 -:4] : ~|lza_str[127 - 112 -:4]));
        assign lzc_or_l4[1] = ~lzc[6] ? (~lzc[5] ? (~lzc[4] ? ~|lza_str[127 - 8 -:4] : ~|lza_str[127 - 24 -:4]) : (~lzc[4] ? ~|lza_str[127 - 40 -:4] : ~|lza_str[127 - 56 -:4])) : (~lzc[5] ? (~lzc[4] ? ~|lza_str[127 - 72 -:4] : ~|lza_str[127 - 88 -:4]) : (~lzc[4] ? ~|lza_str[127 - 104 -:4] : ~|lza_str[127 - 120 -:4]));
        assign lzc_or_l5[0] = ~lzc[6] ? (~lzc[5] ? (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 -:2] : ~|lza_str[127 - 8 -:2]) : (~lzc[3] ? ~|lza_str[127 - 16 -:2] : ~|lza_str[127 - 24 -:2])) : (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 - 32 -:2] : ~|lza_str[127 - 40 -:2]) : (~lzc[3] ? ~|lza_str[127 - 48 -:2] : ~|lza_str[127 - 56 -:2]))) : (~lzc[5] ? (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 - 64 -:2] : ~|lza_str[127 - 72 -:2]) : (~lzc[3] ? ~|lza_str[127 - 80 -:2] : ~|lza_str[127 - 88 -:2])) : (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 - 96 -:2] : ~|lza_str[127 - 104 -:2]) : (~lzc[3] ? ~|lza_str[127 - 112 -:2] : ~|lza_str[127 - 120 -:2])));
        assign lzc_or_l5[1] = ~lzc[6] ? (~lzc[5] ? (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 - 4 -:2] : ~|lza_str[127 - 12 -:2]) : (~lzc[3] ? ~|lza_str[127 - 20 -:2] : ~|lza_str[127 - 28 -:2])) : (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 - 36 -:2] : ~|lza_str[127 - 44 -:2]) : (~lzc[3] ? ~|lza_str[127 - 52 -:2] : ~|lza_str[127 - 60 -:2]))) : (~lzc[5] ? (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 - 68 -:2] : ~|lza_str[127 - 76 -:2]) : (~lzc[3] ? ~|lza_str[127 - 84 -:2] : ~|lza_str[127 - 92 -:2])) : (~lzc[4] ? (~lzc[3] ? ~|lza_str[127 - 100 -:2] : ~|lza_str[127 - 108 -:2]) : (~lzc[3] ? ~|lza_str[127 - 116 -:2] : ~|lza_str[127 - 124 -:2])));
        assign lzc[6] = ~|lza_str[127 -:64];
        assign lzc[5] = ~lzc[6] ? lzc_or_l1[0] : lzc_or_l1[1];
        assign lzc[4] = ~lzc[5] ? lzc_or_l2[0] : lzc_or_l2[1];
        assign lzc[3] = ~lzc[4] ? lzc_or_l3[0] : lzc_or_l3[1];
        assign lzc[2] = ~lzc[3] ? lzc_or_l4[0] : lzc_or_l4[1];
        assign lzc[1] = ~lzc[2] ? lzc_or_l5[0] : lzc_or_l5[1];
        assign lza_str_l1 = ~lzc[6] ? lza_str[127 -:64] : lza_str[63 -:64];
        assign lza_str_l2 = ~lzc[5] ? lza_str_l1[63 -:32] : lza_str_l1[31 -:32];
        assign lza_str_l3 = ~lzc[4] ? lza_str_l2[31 -:16] : lza_str_l2[15 -:16];
        assign lza_str_l4 = ~lzc[3] ? lza_str_l3[15 -:8] : lza_str_l3[7 -:8];
        assign lza_str_l5 = ~lzc[2] ? lza_str_l4[7 -:4] : lza_str_l4[3 -:4];
        assign lza_str_l6 = ~lzc[1] ? lza_str_l5[3 -:2] : lza_str_l5[1 -:2];
        assign lzc[0] = ~lza_str_l6[1];
    end
endgenerate
endmodule


// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fastmul_cmp112 (
    in0,
    in1,
    in2,
    in3,
    in4,
    in5,
    in6,
    in7,
    in8,
    in9,
    ina,
    s,
    c
);
parameter WIDTH = 8;
input [WIDTH - 1:0] in0;
input [WIDTH - 1:0] in1;
input [WIDTH - 1:0] in2;
input [WIDTH - 1:0] in3;
input [WIDTH - 1:0] in4;
input [WIDTH - 1:0] in5;
input [WIDTH - 1:0] in6;
input [WIDTH - 1:0] in7;
input [WIDTH - 1:0] in8;
input [WIDTH - 1:0] in9;
input [WIDTH - 1:0] ina;
output [WIDTH - 1:0] s;
output [WIDTH:1] c;


wire [WIDTH - 1:0] in0;
wire [WIDTH - 1:0] in1;
wire [WIDTH - 1:0] in2;
wire [WIDTH - 1:0] in3;
wire [WIDTH - 1:0] in4;
wire [WIDTH - 1:0] in5;
wire [WIDTH - 1:0] in6;
wire [WIDTH - 1:0] in7;
wire [WIDTH - 1:0] in8;
wire [WIDTH - 1:0] in9;
wire [WIDTH - 1:0] ina;
wire [WIDTH - 1:0] s0;
wire [WIDTH - 1:0] s1;
wire [WIDTH - 1:0] s2;
wire [WIDTH - 1:0] s3;
wire [WIDTH - 1:0] s4;
wire [WIDTH - 1:0] s5;
wire [WIDTH - 1:0] s6;
wire [WIDTH - 1:0] s7;
wire [WIDTH - 1:0] s8;
wire [WIDTH:0] s9;
wire [WIDTH:0] s10;
wire [WIDTH:0] s11;
wire [WIDTH:0] s12;
wire [WIDTH:0] s13;
wire [WIDTH:0] s14;
wire [WIDTH:0] s15;
wire [WIDTH:0] s16;
wire [WIDTH:1] s17;
assign s9[0] = 1'b0;
assign s10[0] = 1'b0;
assign s11[0] = 1'b0;
assign s12[0] = 1'b0;
assign s13[0] = 1'b0;
assign s14[0] = 1'b0;
assign s15[0] = 1'b0;
assign s16[0] = 1'b0;
wire nds_unused_wire = s9[WIDTH] | s10[WIDTH] | s11[WIDTH] | s12[WIDTH] | s13[WIDTH] | s14[WIDTH] | s15[WIDTH] | s16[WIDTH];
generate
    genvar i;
    for (i = 0; i < WIDTH; i = i + 1) begin:gen_cmp112_sc
        assign {s9[i + 1],s0[i]} = csa(in0[i], in1[i], in2[i]);
        assign {s10[i + 1],s1[i]} = csa(in3[i], in4[i], in5[i]);
        assign {s11[i + 1],s2[i]} = csa(in6[i], in7[i], in8[i]);
        assign {s12[i + 1],s3[i]} = csa(s0[i], s9[i], in9[i]);
        assign {s13[i + 1],s4[i]} = csa(s10[i], s11[i], s1[i]);
        assign {s14[i + 1],s5[i]} = csa(ina[i], s3[i], s12[i]);
        assign {s15[i + 1],s6[i]} = csa(s2[i], s13[i], s4[i]);
        assign {s16[i + 1],s7[i]} = csa(s5[i], s14[i], s15[i]);
        assign {s17[i + 1],s8[i]} = csa(s7[i], s6[i], s16[i]);
        assign s[i] = s8[i];
        assign c[i + 1] = s17[i + 1];
    end
endgenerate
function  [1:0] csa;
input in0;
input in1;
input in2;
begin
    csa[1] = ((in0 & in1) | (in2 & (in0 ^ in1)));
    csa[0] = (in0 ^ in1 ^ in2);
end
endfunction
endmodule


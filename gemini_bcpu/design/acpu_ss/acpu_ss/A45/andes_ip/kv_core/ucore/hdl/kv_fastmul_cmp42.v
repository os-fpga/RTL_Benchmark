// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fastmul_cmp42 (
    in0,
    in1,
    in2,
    in3,
    s,
    c
);
parameter WIDTH = 8;
input [WIDTH - 1:0] in0;
input [WIDTH - 1:0] in1;
input [WIDTH - 1:0] in2;
input [WIDTH - 1:0] in3;
output [WIDTH - 1:0] s;
output [WIDTH:1] c;


wire [WIDTH - 1:0] s0;
wire [WIDTH - 1:0] s1;
wire [WIDTH:0] s2;
wire [WIDTH:1] s3;
assign s2[0] = 1'b0;
generate
    genvar i;
    for (i = 0; i < WIDTH; i = i + 1) begin:gen_cmp42_sc
        assign {s2[i + 1],s0[i]} = csa(in0[i], in1[i], in2[i]);
        assign {s3[i + 1],s1[i]} = csa(in3[i], s0[i], s2[i]);
        assign s[i] = s1[i];
        assign c[i + 1] = s3[i + 1];
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


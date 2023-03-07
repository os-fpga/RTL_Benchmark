// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_minmax (
    a,
    b,
    tc,
    min_max,
    result
);
parameter WIDTH = 64;
input [WIDTH - 1:0] a;
input [WIDTH - 1:0] b;
input tc;
input min_max;
output [WIDTH - 1:0] result;


wire [WIDTH:0] s0 = {a[WIDTH - 1] & tc,a};
wire [WIDTH:0] s1 = {b[WIDTH - 1] & tc,b};
wire s2 = ($signed(s0) < $signed(s1));
assign result = (s2 ^ min_max) ? a : b;
endmodule


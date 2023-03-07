// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fasthit (
    a,
    b,
    k,
    hit
);
parameter M = 33;
parameter N = 12;
input [M - 1:0] a;
input [M - 1:0] b;
input [M - 1:N] k;
output hit;


wire [M - 1:N] s0;
wire [M - 1:N] s1;
wire [N - 1:0] s2;
wire s3;
generate
    genvar i;
    for (i = N; i < M; i = i + 1) begin:gen_hit_dlm_csa_c
        assign {s0[i],s1[i]} = {1'b0,a[i]} + {1'b0,b[i]} + {1'b0,~k[i]};
    end
endgenerate
assign {s3,s2} = {1'b0,a[N - 1:0]} + {1'b0,b[N - 1:0]};
assign hit = (~s1[M - 1:N] == {s0[M - 2:N],s3});
wire [N - 1:0] s4 = s2;
endmodule


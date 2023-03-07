// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_vor (
    out,
    in
);
parameter N = 2;
parameter W = 8;
output [W - 1:0] out;
input [(N * W) - 1:0] in;


wire [(N * W) - 1:0] s0;
assign s0[W - 1:0] = in[W - 1:0];
generate
    genvar i;
    for (i = 1; i < N; i = i + 1) begin:gen_tmp
        assign s0[i * W +:W] = s0[(i - 1) * W +:W] | in[i * W +:W];
    end
endgenerate
assign out = s0[(N - 1) * W +:W];
endmodule


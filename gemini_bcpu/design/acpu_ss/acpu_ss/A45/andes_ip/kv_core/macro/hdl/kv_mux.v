// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_mux (
    out,
    sel,
    in
);
parameter N = 2;
parameter W = 8;
localparam SW = $unsigned($clog2(N));
output [W - 1:0] out;
input [SW - 1:0] sel;
input [(N * W) - 1:0] in;


wire [(N * W) - 1:0] tmp;
wire [N - 1:0] sel_onehot;
assign sel_onehot = {{(N - 1){1'b0}},1'b1} << sel;
assign tmp[W - 1:0] = {W{sel_onehot[0]}} & in[W - 1:0];
generate
    genvar i;
    for (i = 1; i < N; i = i + 1) begin:gen_tmp
        assign tmp[i * W +:W] = tmp[(i - 1) * W +:W] | ({W{sel_onehot[i]}} & in[i * W +:W]);
    end
endgenerate
assign out = tmp[(N - 1) * W +:W];
endmodule


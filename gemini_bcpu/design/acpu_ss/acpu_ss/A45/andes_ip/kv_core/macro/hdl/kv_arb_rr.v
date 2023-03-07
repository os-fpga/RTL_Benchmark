// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_arb_rr (
    clk,
    resetn,
    en,
    valid,
    ready,
    grant
);
parameter N = 8;
input clk;
input resetn;
input en;
input [N - 1:0] valid;
output [N - 1:0] ready;
output [N - 1:0] grant;


wire [N * 2 - 1:0] s0 = {valid,valid};
wire [N * N - 1:0] s1;
wire [N * N - 1:0] s2;
reg [N - 1:0] sel;
wire s3 = en & (|valid);
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        sel <= {{(N - 1){1'b0}},1'b1};
    end
    else if (s3) begin
        sel <= {grant[N - 2:0],grant[N - 1]};
    end
end

kv_mux_onehot #(
    .N(N),
    .W(N)
) u_grant (
    .out(grant),
    .sel(sel),
    .in(s1)
);
kv_mux_onehot #(
    .N(N),
    .W(N)
) u_ready (
    .out(ready),
    .sel(sel),
    .in(s2)
);
generate
    genvar i;
    for (i = 0; i < N; i = i + 1) begin:gen_ent
        wire [N - 1:0] s4 = s0[i +:N];
        wire [N - 1:0] s5;
        wire [N - 1:0] s6;
        wire [N * 2 - 1:0] s7 = {s5,s5};
        wire [N * 2 - 1:0] s8 = {s6,s6};
        kv_arb_fp #(
            .N(N)
        ) u_arb_fp (
            .valid(s4),
            .ready(s5),
            .grant(s6)
        );
        assign s2[i * N +:N] = s7[N - i +:N];
        assign s1[i * N +:N] = s8[N - i +:N];
    end
endgenerate
endmodule


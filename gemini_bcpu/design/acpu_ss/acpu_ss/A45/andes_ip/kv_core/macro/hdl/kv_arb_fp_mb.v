// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_arb_fp_mb (
    clk,
    resetn,
    valids,
    readys,
    grants,
    ready,
    valid,
    lasts
);
parameter N = 8;
input clk;
input resetn;
input [N - 1:0] valids;
output [N - 1:0] readys;
output [N - 1:0] grants;
input ready;
output valid;
input [N - 1:0] lasts;


integer s0;
reg [N - 1:0] s1;
reg [N - 1:0] s2;
wire [N - 1:0] s3;
wire s4;
wire s5;
wire [N - 1:0] s6;
assign s6 = valids & s2;
assign s5 = |(grants & lasts);
assign s4 = ready & valid;
assign s3 = grants | {N{s5}};
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        s2 <= {N{1'b1}};
    end
    else if (s4) begin
        s2 <= s3;
    end
end

always @* begin
    s1[0] = 1'b1;
    for (s0 = 1; s0 < N; s0 = s0 + 1) begin
        s1[s0] = s1[s0 - 1] & ~s6[s0 - 1];
    end
end

assign readys = s1 & s2 & {N{ready}};
assign valid = |s6;
assign grants = s6 & s1;
endmodule


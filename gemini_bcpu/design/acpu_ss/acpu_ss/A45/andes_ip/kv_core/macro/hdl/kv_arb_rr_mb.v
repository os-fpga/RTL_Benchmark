// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_arb_rr_mb (
    clk,
    resetn,
    en,
    valid,
    last,
    ready,
    grant,
    valid_out
);
parameter N = 8;
input clk;
input resetn;
input en;
input [N - 1:0] valid;
input [N - 1:0] last;
output [N - 1:0] ready;
output [N - 1:0] grant;
output valid_out;


wire [N - 1:0] s0;
wire [N - 1:0] s1;
wire [N - 1:0] s2;
wire s3;
reg [N - 1:0] s4;
wire [N - 1:0] s5;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        s4 <= {N{1'b0}};
    end
    else if (en) begin
        s4 <= s5;
    end
end

kv_arb_rr #(
    .N(N)
) u_arb (
    .clk(clk),
    .resetn(resetn),
    .en(en),
    .valid(s0),
    .ready(s1),
    .grant(s2)
);
assign s0 = valid & ~s4;
assign ready = s1 & ~s4;
assign grant = s2;
assign s3 = |(grant & last);
assign s5 = ~grant & {N{~s3}};
assign valid_out = |s0;
endmodule


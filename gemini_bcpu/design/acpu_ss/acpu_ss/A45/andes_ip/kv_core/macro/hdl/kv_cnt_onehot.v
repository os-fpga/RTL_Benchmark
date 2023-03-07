// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_cnt_onehot (
    clk,
    rst_n,
    en,
    up_dn,
    load,
    data,
    cnt
);
parameter N = 4;
input clk;
input rst_n;
input en;
input up_dn;
input load;
input [N - 1:0] data;
output [N - 1:0] cnt;


reg [N - 1:0] cnt;
wire [N - 1:0] s0;
wire [N - 1:0] s1;
wire [N - 1:0] s2;
wire [N - 1:0] s3;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= {{(N - 1){1'b0}},1'b1};
    end
    else if (en) begin
        cnt <= s0;
    end
end

assign s0 = load ? data : s3;
assign s1 = {cnt[N - 2:0],cnt[N - 1]};
assign s2 = {cnt[0],cnt[N - 1:1]};
assign s3 = up_dn ? s1 : s2;
endmodule


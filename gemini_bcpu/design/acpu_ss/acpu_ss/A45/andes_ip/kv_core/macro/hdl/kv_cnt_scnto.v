// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_cnt_scnto (
    clk,
    rst_n,
    en,
    up_dn,
    load,
    data,
    cnt,
    tercnt
);
parameter W = 4;
parameter COUNT_TO = 4'hf;
input clk;
input rst_n;
input en;
input up_dn;
input load;
input [W - 1:0] data;
output [W - 1:0] cnt;
output tercnt;


reg [W - 1:0] cnt;
wire [W - 1:0] s0;
wire [W - 1:0] s1;
wire [W - 1:0] s2 = cnt + {{(W - 1){1'b0}},1'b1};
wire [W - 1:0] s3 = cnt - {{(W - 1){1'b0}},1'b1};
reg tercnt;
wire s4;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= {W{1'b0}};
    end
    else if (en) begin
        cnt <= s0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        tercnt <= 1'b0;
    end
    else if (en) begin
        tercnt <= s4;
    end
end

assign s0 = load ? data : s1;
assign s1 = up_dn ? s2 : s3;
assign s4 = s0 == COUNT_TO;
endmodule


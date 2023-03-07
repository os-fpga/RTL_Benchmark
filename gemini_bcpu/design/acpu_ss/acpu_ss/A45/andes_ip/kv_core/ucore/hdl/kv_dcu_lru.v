// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_lru (
    dcu_clk,
    dcu_reset_n,
    lru_req_valid,
    lru_req_idx,
    lru_ack_rdata,
    lru_cmt_valid,
    lru_cmt_idx,
    lru_cmt_way
);
parameter DCACHE_TAG_RAM_AW = 9;
parameter DCACHE_WAY = 2;
localparam IDX_WIDTH = DCACHE_TAG_RAM_AW;
localparam DEPTH = 1 << IDX_WIDTH;
localparam W = (DCACHE_WAY == 2) ? 1 : 3;
input dcu_clk;
input dcu_reset_n;
input lru_req_valid;
input [IDX_WIDTH - 1:0] lru_req_idx;
output [2:0] lru_ack_rdata;
input lru_cmt_valid;
input [IDX_WIDTH - 1:0] lru_cmt_idx;
input [3:0] lru_cmt_way;


reg [(DEPTH * W) - 1:0] s0;
wire [W - 1:0] s1;
reg [W - 1:0] s2;
wire [W - 1:0] s3;
generate
    genvar i;
    for (i = 0; i < DEPTH; i = i + 1) begin:gen_ent
        wire s4;
        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                s0[i * W +:W] <= {W{1'b0}};
            end
            else if (s4) begin
                s0[i * W +:W] <= s3;
            end
        end

        assign s4 = lru_cmt_valid & (lru_cmt_idx == i[IDX_WIDTH - 1:0]);
    end
endgenerate
kv_mux #(
    .N(DEPTH),
    .W(W)
) u_lru_rdata_a1 (
    .out(s1),
    .in(s0),
    .sel(lru_req_idx)
);
always @(posedge dcu_clk) begin
    if (lru_req_valid) begin
        s2 <= s1;
    end
end

generate
    if (DCACHE_WAY == 4) begin:gen_lru_4way
        assign s3 = ({3{lru_cmt_way[0]}} & {1'b1,s2[1],1'b1}) | ({3{lru_cmt_way[1]}} & {1'b1,s2[1],1'b0}) | ({3{lru_cmt_way[2]}} & {1'b0,1'b1,s2[0]}) | ({3{lru_cmt_way[3]}} & {1'b0,1'b0,s2[0]});
        assign lru_ack_rdata = s2;
    end
    else begin:gen_lru_2way
        assign s3 = lru_cmt_way[0];
        assign lru_ack_rdata = {2'd0,s2[0]};
    end
endgenerate
endmodule


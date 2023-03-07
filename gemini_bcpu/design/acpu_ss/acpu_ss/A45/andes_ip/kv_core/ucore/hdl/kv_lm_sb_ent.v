// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lm_sb_ent (
    lm_clk,
    lm_reset_n,
    valid,
    addr,
    mask,
    data,
    user,
    cmp_addr,
    cmp_hit,
    enq_valid,
    enq_addr,
    enq_data,
    enq_mask,
    enq_user,
    drn_valid,
    drn_ready
);
parameter DW = 32;
parameter ALEN = 8;
parameter UW = 2;
input lm_clk;
input lm_reset_n;
output valid;
output [ALEN - 1:0] addr;
output [(DW / 8) - 1:0] mask;
output [DW - 1:0] data;
output [UW - 1:0] user;
input [ALEN - 1:0] cmp_addr;
output cmp_hit;
input enq_valid;
input [ALEN - 1:0] enq_addr;
input [DW - 1:0] enq_data;
input [(DW / 8) - 1:0] enq_mask;
input [UW - 1:0] enq_user;
output drn_valid;
input drn_ready;


reg valid;
wire s0;
wire s1;
reg [ALEN - 1:0] addr;
wire [DW - 1:0] data;
wire [(DW / 8) - 1:0] s2;
reg [(DW / 8) - 1:0] mask;
wire s3;
wire [(DW / 8) - 1:0] s4;
wire [(DW / 8) - 1:0] s5;
wire [(DW / 8) - 1:0] s6;
reg [UW - 1:0] user;
wire s7;
wire [UW - 1:0] s8;
wire s9 = |mask;
wire s10;
wire s11;
wire cmp_hit;
always @(posedge lm_clk or negedge lm_reset_n) begin
    if (!lm_reset_n) begin
        valid <= 1'b0;
    end
    else if (s0) begin
        valid <= s1;
    end
end

always @(posedge lm_clk) begin
    if (enq_valid) begin
        addr <= enq_addr;
    end
end

kv_dff_bwe #(
    .BYTES(DW / 8)
) u_data (
    .clk(lm_clk),
    .bwe(s2),
    .d(enq_data),
    .q(data)
);
always @(posedge lm_clk or negedge lm_reset_n) begin
    if (!lm_reset_n) begin
        mask <= {DW / 8{1'b0}};
    end
    else if (s3) begin
        mask <= s4;
    end
end

always @(posedge lm_clk or negedge lm_reset_n) begin
    if (!lm_reset_n) begin
        user <= {UW{1'b0}};
    end
    else if (s7) begin
        user <= s8;
    end
end

assign s0 = enq_valid | s10;
assign s1 = enq_valid | (valid & ~s10);
assign s2 = {(DW / 8){enq_valid}} & enq_mask;
assign s3 = enq_valid;
assign s5 = {(DW / 8){enq_valid}} & enq_mask;
assign s4 = s5 | (mask & {(DW / 8){valid}} & ~s6);
assign s6 = {(DW / 8){s10}};
assign s7 = enq_valid;
assign s8 = enq_user;
assign cmp_hit = valid & (cmp_addr == addr);
assign drn_valid = valid & s9;
assign s11 = drn_valid & drn_ready;
assign s10 = s11 | (valid & ~s9);
endmodule


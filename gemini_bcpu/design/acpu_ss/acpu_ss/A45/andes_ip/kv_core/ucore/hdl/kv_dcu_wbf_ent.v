// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_wbf_ent (
    dcu_clk,
    dcu_reset_n,
    valid,
    data,
    mask,
    enq_valid,
    enq_kill,
    deq,
    we,
    waddr,
    wmask,
    wdata
);
parameter WRITE_AROUND_SUPPORT_INT = 0;
input dcu_clk;
input dcu_reset_n;
output valid;
output [511:0] data;
output [63:0] mask;
input enq_valid;
input enq_kill;
input deq;
input we;
input [5:4] waddr;
input [15:0] wmask;
input [127:0] wdata;


reg valid;
wire s0;
wire [511:0] d;
wire [511:0] q;
wire [63:0] bwe;
reg [63:0] mask;
wire [63:0] s1;
wire s2;
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        valid <= 1'b0;
    end
    else begin
        valid <= s0;
    end
end

kv_dff_bwe #(
    .BYTES(64)
) u_data (
    .clk(dcu_clk),
    .bwe(bwe),
    .d(d),
    .q(q)
);
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        mask <= 64'd0;
    end
    else if (s2) begin
        mask <= s1;
    end
end

assign d = {4{wdata}};
assign bwe[15:0] = {16{~waddr[5] & ~waddr[4] & we}} & wmask;
assign bwe[31:16] = {16{~waddr[5] & waddr[4] & we}} & wmask;
assign bwe[47:32] = {16{waddr[5] & ~waddr[4] & we}} & wmask;
assign bwe[63:48] = {16{waddr[5] & waddr[4] & we}} & wmask;
assign s0 = (enq_valid & ~enq_kill) | (valid & ~deq);
assign data = q;
assign s2 = enq_valid | we;
assign s1 = ~{64{enq_valid & ~enq_kill}} & (mask | bwe);
endmodule


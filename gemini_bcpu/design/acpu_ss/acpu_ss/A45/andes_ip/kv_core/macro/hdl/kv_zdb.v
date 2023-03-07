// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_zdb (
    clk,
    reset_n,
    wvalid,
    wdata,
    wready,
    rvalid,
    rdata,
    rready
);
parameter WIDTH = 8;
input clk;
input reset_n;
input wvalid;
input [WIDTH - 1:0] wdata;
output wready;
output rvalid;
output [WIDTH - 1:0] rdata;
input rready;


reg s0;
wire s1;
wire s2;
wire s3;
wire s4;
reg [WIDTH - 1:0] s5;
wire s6 = wvalid & wready;
wire s7 = rvalid & rready;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        s0 <= 1'b0;
    end
    else begin
        s0 <= s1;
    end
end

always @(posedge clk) begin
    if (s4) begin
        s5 <= wdata;
    end
end

assign rvalid = wvalid | s0;
assign rdata = s0 ? s5 : wdata;
assign wready = ~s0;
assign s4 = s2;
assign s1 = s2 | (s0 & ~s3);
assign s2 = s6 & ~rready;
assign s3 = s7;
endmodule


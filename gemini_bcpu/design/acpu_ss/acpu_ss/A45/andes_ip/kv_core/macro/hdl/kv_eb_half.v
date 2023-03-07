// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_eb_half (
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


reg rvalid;
wire s0;
reg [WIDTH - 1:0] rdata;
wire s1 = wvalid & wready;
wire s2 = rvalid & rready;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        rvalid <= 1'b0;
    end
    else begin
        rvalid <= s0;
    end
end

always @(posedge clk) begin
    if (s1) begin
        rdata <= wdata;
    end
end

assign s0 = s1 | (rvalid & ~s2);
assign wready = ~rvalid;
endmodule


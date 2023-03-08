// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atctlc2axi500_async_fifo (
        	  wclk,
        	  wreset_n,
        	  wdata,
        	  wvalid,
        	  wready,
        	  rclk,
        	  rreset_n,
        	  rdata,
        	  rvalid,
        	  rready
);

parameter DEPTH = 4;
parameter WIDTH = 8;
parameter SYNC_STAGE = 2;
input                       wclk;
input                       wreset_n;
input           [WIDTH-1:0] wdata;
input                       wvalid;
output                      wready;
input                       rclk;
input                       rreset_n;
output          [WIDTH-1:0] rdata;
output                      rvalid;
input                       rready;

localparam CW = $unsigned($clog2(DEPTH)) + 1;
localparam CL = 2**$unsigned($clog2(DEPTH));

wire                        wfire;
wire               [CL-1:0] wptr;
reg                [CW-1:0] wcnt;
wire               [CW-1:0] wcnt_inc;
reg                [CW-1:0] wcnt_gray;
wire               [CW-1:0] wcnt_gray_nx;
wire               [CW-1:0] wcnt_gray_sync;

wire                        rfire;
wire               [CL-1:0] rptr;
reg                [CW-1:0] rcnt;
wire               [CW-1:0] rcnt_inc;
reg                [CW-1:0] rcnt_gray;
wire               [CW-1:0] rcnt_gray_nx;
wire               [CW-1:0] rcnt_gray_sync;

reg             [WIDTH-1:0] mem[0:CL-1];
wire               [CL-1:0] mem_en;

reg             [WIDTH-1:0] rdata;

reg full;
wire empty;

assign wfire = wvalid & wready;
assign rfire = rvalid & rready;

assign wready = ~full;
assign rvalid = ~empty;

integer k;
assign empty = rcnt_gray == wcnt_gray_sync;
always @* begin
    full = 1'b1;
    for(k = 0; k < CW; k = k + 1)begin
        full = full & (wcnt_gray[CW-1-k] ^ rcnt_gray_sync[CW-1-k] ^ (k >= 2));
    end
end

assign wcnt_gray_nx = wcnt_inc ^ {1'b0, wcnt_inc[CW-1:1]};
always @(posedge wclk or negedge wreset_n)begin
    if(!wreset_n)begin
        wcnt_gray <= {CW{1'b0}};
    end
    else if(wfire)begin
        wcnt_gray <= wcnt_gray_nx;
    end
end

assign wcnt_inc = wcnt + {{CW-1{1'b0}}, 1'b1};
always @(posedge wclk or negedge wreset_n)begin
    if(!wreset_n)begin
        wcnt <= {CW{1'b0}};
    end
    else if(wfire)begin
        wcnt <= wcnt_inc;
    end
end

assign rcnt_gray_nx = rcnt_inc ^ {1'b0, rcnt_inc[CW-1:1]};
always @(posedge rclk or negedge rreset_n)begin
    if(!rreset_n)begin
        rcnt_gray <= {CW{1'b0}};
    end
    else if(rfire)begin
        rcnt_gray <= rcnt_gray_nx;
    end
end

assign rcnt_inc = rcnt + {{CW-1{1'b0}}, 1'b1};
always @(posedge rclk or negedge rreset_n)begin
    if(!rreset_n)begin
        rcnt <= {CW{1'b0}};
    end
    else if(rfire)begin
        rcnt <= rcnt_inc;
    end
end

generate
genvar l;
for(l=0; l<CW; l=l+1)begin : gen_ptr_sync
atctlc2axi500_sync_l2l #(
    .SYNC_STAGE(SYNC_STAGE),
    .RESET_VALUE(1'b0)
) u_wcnt_sync (
    .resetn(rreset_n),
    .clk(rclk),
    .d(wcnt_gray[l]),
    .q(wcnt_gray_sync[l])
);

atctlc2axi500_sync_l2l #(
    .SYNC_STAGE(SYNC_STAGE),
    .RESET_VALUE(1'b0)
) u_rcnt_sync (
    .resetn(wreset_n),
    .clk(wclk),
    .d(rcnt_gray[l]),
    .q(rcnt_gray_sync[l])
);
end
endgenerate

atctlc2axi500_bin2onehot #(.N(CL)) u_wptr (.out(wptr), .in(wcnt[CW-2:0]));
atctlc2axi500_bin2onehot #(.N(CL)) u_rptr (.out(rptr), .in(rcnt[CW-2:0]));

assign mem_en = wptr & {CL{wfire}};

generate
genvar i;
for (i=0; i<CL; i=i+1) begin : gen_mem
    always @(posedge wclk) begin
        if (mem_en[i])begin
            mem[i] <= wdata;
        end
    end
end
endgenerate

integer j;
always @* begin
    rdata = {WIDTH{1'b0}};
    for (j=0; j<CL; j=j+1) begin
        rdata = rdata | ({WIDTH{rptr[j]}} & mem[j]);
    end
end

endmodule


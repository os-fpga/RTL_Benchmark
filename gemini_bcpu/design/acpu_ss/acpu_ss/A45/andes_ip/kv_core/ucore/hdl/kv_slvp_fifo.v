// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_slvp_fifo (
    brq_rdata,
    brq_rready,
    brq_rvalid,
    brq_wdata,
    brq_wready,
    brq_wvalid,
    lm_clk,
    lm_reset_n,
    slv_clk,
    slv_reset_n,
    rcq_rdata,
    rcq_rready,
    rcq_rvalid,
    rcq_wdata,
    rcq_wready,
    rcq_wvalid,
    rdq_rdata,
    rdq_rready,
    rdq_rvalid,
    rdq_wdata,
    rdq_wready,
    rdq_wvalid,
    wcq_rdata,
    wcq_rready,
    wcq_rvalid,
    wcq_wdata,
    wcq_wready,
    wcq_wvalid,
    wdq_rdata,
    wdq_rready,
    wdq_rvalid,
    wdq_wdata,
    wdq_wready,
    wdq_wvalid
);
parameter ASYNC = 0;
parameter WCQ_DEPTH = 2;
parameter WCQ_WIDTH = 32;
parameter RCQ_DEPTH = 2;
parameter RCQ_WIDTH = 32;
parameter WDQ_DEPTH = 2;
parameter WDQ_WIDTH = 32;
parameter RDQ_DEPTH = 2;
parameter RDQ_WIDTH = 32;
parameter BRQ_DEPTH = 2;
parameter BRQ_WIDTH = 32;
output [(BRQ_WIDTH - 1):0] brq_rdata;
input brq_rready;
output brq_rvalid;
input [(BRQ_WIDTH - 1):0] brq_wdata;
output brq_wready;
input brq_wvalid;
input lm_clk;
input lm_reset_n;
input slv_clk;
input slv_reset_n;
output [(RCQ_WIDTH - 1):0] rcq_rdata;
input rcq_rready;
output rcq_rvalid;
input [(RCQ_WIDTH - 1):0] rcq_wdata;
output rcq_wready;
input rcq_wvalid;
output [(RDQ_WIDTH - 1):0] rdq_rdata;
input rdq_rready;
output rdq_rvalid;
input [(RDQ_WIDTH - 1):0] rdq_wdata;
output rdq_wready;
input rdq_wvalid;
output [(WCQ_WIDTH - 1):0] wcq_rdata;
input wcq_rready;
output wcq_rvalid;
input [(WCQ_WIDTH - 1):0] wcq_wdata;
output wcq_wready;
input wcq_wvalid;
output [(WDQ_WIDTH - 1):0] wdq_rdata;
input wdq_rready;
output wdq_rvalid;
input [(WDQ_WIDTH - 1):0] wdq_wdata;
output wdq_wready;
input wdq_wvalid;


generate
    if (ASYNC == 0) begin:gen_async_eq0_nds_unused
        wire nds_unused_slv_clk = slv_clk;
        wire nds_unused_slv_reset_n = slv_reset_n;
    end
endgenerate
generate
    if (ASYNC == 0) begin:gen_wcq_sync_fifo
        kv_slvp_sync_fifo #(
            .DEPTH(WCQ_DEPTH),
            .WIDTH(WCQ_WIDTH)
        ) u_wcq_sync_fifo (
            .clk(lm_clk),
            .reset_n(lm_reset_n),
            .wdata(wcq_wdata),
            .wvalid(wcq_wvalid),
            .wready(wcq_wready),
            .rdata(wcq_rdata),
            .rvalid(wcq_rvalid),
            .rready(wcq_rready)
        );
    end
endgenerate
generate
    if (ASYNC == 1) begin:gen_wcq_async_fifo
        kv_async_fifo #(
            .DEPTH(WCQ_DEPTH),
            .WIDTH(WCQ_WIDTH)
        ) u_wcq_async_fifo (
            .wclk(slv_clk),
            .wreset_n(slv_reset_n),
            .wdata(wcq_wdata),
            .wvalid(wcq_wvalid),
            .wready(wcq_wready),
            .rclk(lm_clk),
            .rreset_n(lm_reset_n),
            .rdata(wcq_rdata),
            .rvalid(wcq_rvalid),
            .rready(wcq_rready)
        );
    end
endgenerate
generate
    if (ASYNC == 0) begin:gen_rcq_sync_fifo
        kv_slvp_sync_fifo #(
            .DEPTH(RCQ_DEPTH),
            .WIDTH(RCQ_WIDTH)
        ) u_rcq_sync_fifo (
            .clk(lm_clk),
            .reset_n(lm_reset_n),
            .wdata(rcq_wdata),
            .wvalid(rcq_wvalid),
            .wready(rcq_wready),
            .rdata(rcq_rdata),
            .rvalid(rcq_rvalid),
            .rready(rcq_rready)
        );
    end
endgenerate
generate
    if (ASYNC == 1) begin:gen_rcq_async_fifo
        kv_async_fifo #(
            .DEPTH(RCQ_DEPTH),
            .WIDTH(RCQ_WIDTH)
        ) u_rcq_async_fifo (
            .wclk(slv_clk),
            .wreset_n(slv_reset_n),
            .wdata(rcq_wdata),
            .wvalid(rcq_wvalid),
            .wready(rcq_wready),
            .rclk(lm_clk),
            .rreset_n(lm_reset_n),
            .rdata(rcq_rdata),
            .rvalid(rcq_rvalid),
            .rready(rcq_rready)
        );
    end
endgenerate
generate
    if (ASYNC == 0) begin:gen_wdq_sync_fifo
        kv_slvp_sync_fifo #(
            .DEPTH(WDQ_DEPTH),
            .WIDTH(WDQ_WIDTH)
        ) u_wdq_sync_fifo (
            .clk(lm_clk),
            .reset_n(lm_reset_n),
            .wdata(wdq_wdata),
            .wvalid(wdq_wvalid),
            .wready(wdq_wready),
            .rdata(wdq_rdata),
            .rvalid(wdq_rvalid),
            .rready(wdq_rready)
        );
    end
endgenerate
generate
    if (ASYNC == 1) begin:gen_wdq_async_fifo
        kv_async_fifo #(
            .DEPTH(WDQ_DEPTH),
            .WIDTH(WDQ_WIDTH)
        ) u_wdq_async_fifo (
            .wclk(slv_clk),
            .wreset_n(slv_reset_n),
            .wdata(wdq_wdata),
            .wvalid(wdq_wvalid),
            .wready(wdq_wready),
            .rclk(lm_clk),
            .rreset_n(lm_reset_n),
            .rdata(wdq_rdata),
            .rvalid(wdq_rvalid),
            .rready(wdq_rready)
        );
    end
endgenerate
generate
    if (ASYNC == 0) begin:gen_rdq_sync_fifo
        kv_slvp_sync_fifo #(
            .DEPTH(RDQ_DEPTH),
            .WIDTH(RDQ_WIDTH)
        ) u_rdq_sync_fifo (
            .clk(lm_clk),
            .reset_n(lm_reset_n),
            .wdata(rdq_wdata),
            .wvalid(rdq_wvalid),
            .wready(rdq_wready),
            .rdata(rdq_rdata),
            .rvalid(rdq_rvalid),
            .rready(rdq_rready)
        );
    end
endgenerate
generate
    if (ASYNC == 1) begin:gen_rdq_async_fifo
        kv_async_fifo #(
            .DEPTH(RDQ_DEPTH),
            .WIDTH(RDQ_WIDTH)
        ) u_rdq_async_fifo (
            .wclk(lm_clk),
            .wreset_n(lm_reset_n),
            .wdata(rdq_wdata),
            .wvalid(rdq_wvalid),
            .wready(rdq_wready),
            .rclk(slv_clk),
            .rreset_n(slv_reset_n),
            .rdata(rdq_rdata),
            .rvalid(rdq_rvalid),
            .rready(rdq_rready)
        );
    end
endgenerate
generate
    if (ASYNC == 0) begin:gen_brq_sync_fifo
        kv_slvp_sync_fifo #(
            .DEPTH(BRQ_DEPTH),
            .WIDTH(BRQ_WIDTH)
        ) u_brq_sync_fifo (
            .clk(lm_clk),
            .reset_n(lm_reset_n),
            .wdata(brq_wdata),
            .wvalid(brq_wvalid),
            .wready(brq_wready),
            .rdata(brq_rdata),
            .rvalid(brq_rvalid),
            .rready(brq_rready)
        );
    end
endgenerate
generate
    if (ASYNC == 1) begin:gen_brq_async_fifo
        kv_async_fifo #(
            .DEPTH(BRQ_DEPTH),
            .WIDTH(BRQ_WIDTH)
        ) u_brq_async_fifo (
            .wclk(lm_clk),
            .wreset_n(lm_reset_n),
            .wdata(brq_wdata),
            .wvalid(brq_wvalid),
            .wready(brq_wready),
            .rclk(slv_clk),
            .rreset_n(slv_reset_n),
            .rdata(brq_rdata),
            .rvalid(brq_rvalid),
            .rready(brq_rready)
        );
    end
endgenerate
endmodule


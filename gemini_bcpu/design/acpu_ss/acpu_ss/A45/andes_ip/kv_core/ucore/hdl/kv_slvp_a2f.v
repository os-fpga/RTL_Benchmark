// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_slvp_a2f (
    slv_clk_en,
    slv_clk,
    slv_reset_n,
    slv_awready,
    slv_awvalid,
    slv_awid,
    slv_awaddr,
    slv_awlen,
    slv_awsize,
    slv_awburst,
    slv_awlock,
    slv_awcache,
    slv_awprot,
    slv_awuser,
    slv_wready,
    slv_wvalid,
    slv_wdata,
    slv_wstrb,
    slv_wlast,
    slv_bready,
    slv_bvalid,
    slv_bid,
    slv_bresp,
    slv_arready,
    slv_arvalid,
    slv_arid,
    slv_araddr,
    slv_arlen,
    slv_arsize,
    slv_arburst,
    slv_arlock,
    slv_arcache,
    slv_arprot,
    slv_aruser,
    slv_rready,
    slv_rvalid,
    slv_rid,
    slv_rdata,
    slv_rresp,
    slv_rlast,
    wcq_wdata,
    wcq_wvalid,
    wcq_wready,
    wdq_wdata,
    wdq_wvalid,
    wdq_wready,
    brq_rdata,
    brq_rready,
    brq_rvalid,
    rcq_wdata,
    rcq_wvalid,
    rcq_wready,
    rdq_rdata,
    rdq_rready,
    rdq_rvalid
);
parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 32;
parameter ID_WIDTH = 4;
parameter ASYNC = 0;
parameter MAX_AMSB = 19;
parameter WCQ_WIDTH = ID_WIDTH + MAX_AMSB + 1 + 8 + 3 + 2 + 1;
parameter WDQ_WIDTH = DATA_WIDTH + (DATA_WIDTH / 8) + 1;
parameter BRQ_WIDTH = ID_WIDTH + 1;
parameter RCQ_WIDTH = ID_WIDTH + MAX_AMSB + 1 + 8 + 3 + 2 + 1;
parameter RDQ_WIDTH = ID_WIDTH + DATA_WIDTH + 1 + 1;
input slv_clk_en;
input slv_clk;
input slv_reset_n;
output slv_awready;
input slv_awvalid;
input [(ID_WIDTH - 1):0] slv_awid;
input [(ADDR_WIDTH - 1):0] slv_awaddr;
input [7:0] slv_awlen;
input [2:0] slv_awsize;
input [1:0] slv_awburst;
input slv_awlock;
input [3:0] slv_awcache;
input [2:0] slv_awprot;
input slv_awuser;
output slv_wready;
input slv_wvalid;
input [(DATA_WIDTH - 1):0] slv_wdata;
input [((DATA_WIDTH / 8) - 1):0] slv_wstrb;
input slv_wlast;
input slv_bready;
output slv_bvalid;
output [(ID_WIDTH - 1):0] slv_bid;
output [1:0] slv_bresp;
output slv_arready;
input slv_arvalid;
input [(ID_WIDTH - 1):0] slv_arid;
input [(ADDR_WIDTH - 1):0] slv_araddr;
input [7:0] slv_arlen;
input [2:0] slv_arsize;
input [1:0] slv_arburst;
input slv_arlock;
input [3:0] slv_arcache;
input [2:0] slv_arprot;
input slv_aruser;
input slv_rready;
output slv_rvalid;
output [(ID_WIDTH - 1):0] slv_rid;
output [(DATA_WIDTH - 1):0] slv_rdata;
output [1:0] slv_rresp;
output slv_rlast;
output [(WCQ_WIDTH - 1):0] wcq_wdata;
output wcq_wvalid;
input wcq_wready;
output [(WDQ_WIDTH - 1):0] wdq_wdata;
output wdq_wvalid;
input wdq_wready;
input [(BRQ_WIDTH - 1):0] brq_rdata;
output brq_rready;
input brq_rvalid;
output [(RCQ_WIDTH - 1):0] rcq_wdata;
output rcq_wvalid;
input rcq_wready;
input [(RDQ_WIDTH - 1):0] rdq_rdata;
output rdq_rready;
input rdq_rvalid;


generate
    if (ASYNC == 1) begin:gen_aw_async
        assign wcq_wvalid = slv_awvalid;
        assign wcq_wdata = {slv_awuser,slv_awburst,slv_awsize,slv_awlen,slv_awaddr[MAX_AMSB:0],slv_awid};
        assign slv_awready = wcq_wready;
    end
    if (ASYNC == 0) begin:gen_aw_sync
        reg s0;
        reg [(WCQ_WIDTH - 1):0] s1;
        wire [(WCQ_WIDTH - 1):0] s2;
        reg s3;
        wire s4;
        wire s5;
        wire s6;
        wire s7 = s5 | s6;
        always @(posedge slv_clk or negedge slv_reset_n) begin
            if (!slv_reset_n) begin
                s3 <= 1'b0;
            end
            else if (s7) begin
                s3 <= s4;
            end
        end

        always @(posedge slv_clk or negedge slv_reset_n) begin
            if (!slv_reset_n) begin
                s1 <= {WCQ_WIDTH{1'b0}};
            end
            else if (s5) begin
                s1 <= s2;
            end
        end

        always @(posedge slv_clk or negedge slv_reset_n) begin
            if (!slv_reset_n) begin
                s0 <= 1'b0;
            end
            else if (slv_clk_en) begin
                s0 <= ~(s5 | s3);
            end
        end

        assign slv_awready = s0;
        assign s5 = (slv_clk_en & slv_awvalid & slv_awready & ~s3 & ~wcq_wready);
        assign s6 = (s3 & wcq_wready);
        assign s4 = s5;
        assign s2 = {slv_awuser,slv_awburst,slv_awsize,slv_awlen,slv_awaddr[MAX_AMSB:0],slv_awid};
        assign wcq_wdata = s3 ? s1 : s2;
        assign wcq_wvalid = s3 | (~s3 & slv_awvalid & slv_awready & slv_clk_en);
    end
    if (ASYNC == 1) begin:gen_w_async
        assign wdq_wvalid = slv_wvalid;
        assign wdq_wdata = {slv_wlast,slv_wstrb,slv_wdata};
        assign slv_wready = wdq_wready;
    end
    if (ASYNC == 0) begin:gen_w_sync
        reg s8;
        reg [(WDQ_WIDTH - 1):0] s9;
        wire [(WDQ_WIDTH - 1):0] s10;
        reg s11;
        wire s12;
        wire s13;
        wire s14;
        wire s15 = s13 | s14;
        always @(posedge slv_clk or negedge slv_reset_n) begin
            if (!slv_reset_n) begin
                s11 <= 1'b0;
            end
            else if (s15) begin
                s11 <= s12;
            end
        end

        always @(posedge slv_clk or negedge slv_reset_n) begin
            if (!slv_reset_n) begin
                s9 <= {WDQ_WIDTH{1'b0}};
            end
            else if (s13) begin
                s9 <= s10;
            end
        end

        always @(posedge slv_clk or negedge slv_reset_n) begin
            if (!slv_reset_n) begin
                s8 <= 1'b0;
            end
            else if (slv_clk_en) begin
                s8 <= ~(s13 | s11);
            end
        end

        assign slv_wready = s8;
        assign s13 = (slv_clk_en & slv_wvalid & slv_wready & ~s11 & ~wdq_wready);
        assign s14 = (s11 & wdq_wready);
        assign s12 = s13;
        assign s10 = {slv_wlast,slv_wstrb,slv_wdata};
        assign wdq_wdata = s11 ? s9 : s10;
        assign wdq_wvalid = s11 | (~s11 & slv_wvalid & slv_wready & slv_clk_en);
    end
    if (ASYNC == 1) begin:gen_b_async
        assign slv_bvalid = brq_rvalid;
        assign slv_bid = brq_rdata[0 +:ID_WIDTH];
        assign slv_bresp = {brq_rdata[(ID_WIDTH) +:1],1'b0};
        assign brq_rready = slv_bready;
    end
    if (ASYNC == 0) begin:gen_b_sync
        wire s16;
        wire [(ID_WIDTH - 1):0] s17;
        wire s18;
        reg s19;
        reg [(ID_WIDTH - 1):0] s20;
        reg s21;
        always @(posedge slv_clk or negedge slv_reset_n) begin
            if (!slv_reset_n) begin
                s19 <= 1'b0;
                s20 <= {ID_WIDTH{1'b0}};
                s21 <= 1'b0;
            end
            else if (slv_clk_en) begin
                s19 <= s16;
                s20 <= s17;
                s21 <= s18;
            end
        end

        assign s16 = (s19 & slv_bready & brq_rvalid) | (s19 & ~slv_bready) | (~s19 & brq_rvalid);
        assign s17 = ({ID_WIDTH{(s19 & slv_bready & brq_rvalid)}} & brq_rdata[0 +:ID_WIDTH]) | ({ID_WIDTH{(s19 & ~slv_bready)}} & s20) | ({ID_WIDTH{(~s19 & brq_rvalid)}} & brq_rdata[0 +:ID_WIDTH]);
        assign s18 = ((s19 & slv_bready & brq_rvalid) & brq_rdata[(ID_WIDTH) +:1]) | ((s19 & ~slv_bready) & s21) | ((~s19 & brq_rvalid) & brq_rdata[(ID_WIDTH) +:1]);
        assign brq_rready = (slv_clk_en & s19 & slv_bready) | (slv_clk_en & ~s19);
        assign slv_bvalid = s19;
        assign slv_bid = s20;
        assign slv_bresp = {s21,1'b0};
    end
    if (ASYNC == 1) begin:gen_ar_async
        assign rcq_wvalid = slv_arvalid;
        assign rcq_wdata = {slv_aruser,slv_arburst,slv_arsize,slv_arlen,slv_araddr[MAX_AMSB:0],slv_arid};
        assign slv_arready = rcq_wready;
    end
    if (ASYNC == 0) begin:gen_ar_sync
        reg s22;
        reg [(RCQ_WIDTH - 1):0] s23;
        wire [(RCQ_WIDTH - 1):0] s24;
        reg s25;
        wire s26;
        wire s27;
        wire s28;
        wire s29 = s27 | s28;
        always @(posedge slv_clk or negedge slv_reset_n) begin
            if (!slv_reset_n) begin
                s25 <= 1'b0;
            end
            else if (s29) begin
                s25 <= s26;
            end
        end

        always @(posedge slv_clk or negedge slv_reset_n) begin
            if (!slv_reset_n) begin
                s23 <= {RCQ_WIDTH{1'b0}};
            end
            else if (s27) begin
                s23 <= s24;
            end
        end

        always @(posedge slv_clk or negedge slv_reset_n) begin
            if (!slv_reset_n) begin
                s22 <= 1'b0;
            end
            else if (slv_clk_en) begin
                s22 <= ~(s27 | s25);
            end
        end

        assign slv_arready = s22;
        assign s27 = (slv_clk_en & slv_arvalid & slv_arready & ~s25 & ~rcq_wready);
        assign s28 = (s25 & rcq_wready);
        assign s26 = s27;
        assign s24 = {slv_aruser,slv_arburst,slv_arsize,slv_arlen,slv_araddr[MAX_AMSB:0],slv_arid};
        assign rcq_wdata = s25 ? s23 : s24;
        assign rcq_wvalid = s25 | (~s25 & slv_arvalid & slv_arready & slv_clk_en);
    end
    if (ASYNC == 1) begin:gen_r_async
        assign slv_rvalid = rdq_rvalid;
        assign slv_rid = rdq_rdata[0 +:ID_WIDTH];
        assign slv_rresp = {rdq_rdata[(ID_WIDTH) +:1],1'b0};
        assign slv_rdata = rdq_rdata[(ID_WIDTH + 1) +:DATA_WIDTH];
        assign slv_rlast = rdq_rdata[(ID_WIDTH + DATA_WIDTH + 1) +:1];
        assign rdq_rready = slv_rready;
    end
    if (ASYNC == 0) begin:gen_r_sync
        wire s30;
        wire [(ID_WIDTH - 1):0] s31;
        wire [(DATA_WIDTH - 1):0] s32;
        wire s33;
        wire s34;
        reg s35;
        reg [(ID_WIDTH - 1):0] s36;
        reg [(DATA_WIDTH - 1):0] s37;
        reg s38;
        reg s39;
        always @(posedge slv_clk or negedge slv_reset_n) begin
            if (!slv_reset_n) begin
                s35 <= 1'b0;
                s36 <= {ID_WIDTH{1'b0}};
                s38 <= 1'b0;
                s37 <= {DATA_WIDTH{1'b0}};
                s39 <= 1'b0;
            end
            else if (slv_clk_en) begin
                s35 <= s30;
                s36 <= s31;
                s38 <= s33;
                s37 <= s32;
                s39 <= s34;
            end
        end

        assign s30 = (s35 & slv_rready & rdq_rvalid) | (s35 & ~slv_rready) | (~s35 & rdq_rvalid);
        assign s31 = ({(ID_WIDTH){(s35 & slv_rready & rdq_rvalid)}} & rdq_rdata[0 +:ID_WIDTH]) | ({(ID_WIDTH){(s35 & ~slv_rready)}} & s36) | ({(ID_WIDTH){(~s35 & rdq_rvalid)}} & rdq_rdata[0 +:ID_WIDTH]);
        assign s33 = ((s35 & slv_rready & rdq_rvalid) & rdq_rdata[(ID_WIDTH) +:1]) | ((s35 & ~slv_rready) & s38) | ((~s35 & rdq_rvalid) & rdq_rdata[(ID_WIDTH) +:1]);
        assign s32 = ({(DATA_WIDTH){(s35 & slv_rready & rdq_rvalid)}} & rdq_rdata[(ID_WIDTH + 1) +:DATA_WIDTH]) | ({(DATA_WIDTH){(s35 & ~slv_rready)}} & s37) | ({(DATA_WIDTH){(~s35 & rdq_rvalid)}} & rdq_rdata[(ID_WIDTH + 1) +:DATA_WIDTH]);
        assign s34 = ((s35 & slv_rready & rdq_rvalid) & rdq_rdata[(ID_WIDTH + DATA_WIDTH + 1) +:1]) | ((s35 & ~slv_rready) & s39) | ((~s35 & rdq_rvalid) & rdq_rdata[(ID_WIDTH + DATA_WIDTH + 1) +:1]);
        assign rdq_rready = (slv_clk_en & s35 & slv_rready) | (slv_clk_en & ~s35);
        assign slv_rvalid = s35;
        assign slv_rid = s36;
        assign slv_rdata = s37;
        assign slv_rresp = {s38,1'b0};
        assign slv_rlast = s39;
    end
endgenerate
generate
    if (ASYNC == 1) begin:gen_async_unused_wire
        wire nds_unused_slv_clk_en = slv_clk_en;
        wire nds_unused_slv_clk = slv_clk;
        wire nds_unused_slv_reset_n = slv_reset_n;
    end
endgenerate
wire [3:0] nds_unused_slv_arcache = slv_arcache;
wire [2:0] nds_unused_slv_arprot = slv_arprot;
wire nds_unused_slv_arlock = slv_arlock;
wire [3:0] nds_unused_slv_awcache = slv_awcache;
wire [2:0] nds_unused_slv_awprot = slv_awprot;
wire nds_unused_slv_awlock = slv_awlock;
endmodule


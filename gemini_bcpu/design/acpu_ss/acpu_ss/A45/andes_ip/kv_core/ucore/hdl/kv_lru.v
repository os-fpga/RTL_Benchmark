// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lru (
    lru_write,
    lru_waddr,
    lru_way_hit,
    lru_ori_lru,
    lru_read,
    lru_raddr,
    lru_rdata,
    core_reset_n,
    core_clk
);
parameter TAG_AW = 0;
parameter WAY = 2;
parameter LRU_INT = 0;
localparam TAG_ENTRY = (1 << TAG_AW);
localparam LRU_WIDTH = (WAY == 4) ? 3 : 1;
input lru_write;
input [TAG_AW - 1:0] lru_waddr;
input [3:0] lru_way_hit;
input [2:0] lru_ori_lru;
input lru_read;
input [TAG_AW - 1:0] lru_raddr;
output [2:0] lru_rdata;
input core_reset_n;
input core_clk;


generate
    if ((LRU_INT == 0) && (WAY == 2)) begin:gen_lru_2way
        reg [LRU_WIDTH - 1:0] s0[0:TAG_ENTRY - 1];
        wire [TAG_AW - 1:0] s1;
        reg [TAG_AW - 1:0] s2;
        integer s3;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s2 <= {(TAG_AW){1'b0}};
            end
            else if (lru_read) begin
                s2 <= lru_raddr;
            end
        end

        assign s1 = s2;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                for (s3 = 0; s3 < (TAG_ENTRY / 4); s3 = s3 + 1) begin
                    s0[4 * s3] <= {LRU_WIDTH{1'b0}};
                    s0[4 * s3 + 1] <= {LRU_WIDTH{1'b0}};
                    s0[4 * s3 + 2] <= {LRU_WIDTH{1'b0}};
                    s0[4 * s3 + 3] <= {LRU_WIDTH{1'b0}};
                end
            end
            else if (lru_write) begin
                s0[lru_waddr] <= lru_way_hit[0];
            end
        end

        assign lru_rdata = {2'b00,s0[s1]};
        wire [2:0] nds_unused_lru_ori_lru = lru_ori_lru;
    end
    else if ((LRU_INT == 0) && (WAY == 4)) begin:gen_lru_4way
        reg [LRU_WIDTH - 1:0] s4;
        reg [LRU_WIDTH - 1:0] s0[0:TAG_ENTRY - 1];
        wire [TAG_AW - 1:0] s1;
        reg [TAG_AW - 1:0] s2;
        integer s3;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s2 <= {(TAG_AW){1'b0}};
            end
            else if (lru_read) begin
                s2 <= lru_raddr;
            end
        end

        assign s1 = s2;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                for (s3 = 0; s3 < (TAG_ENTRY / 4); s3 = s3 + 1) begin
                    s0[4 * s3] <= {LRU_WIDTH{1'b0}};
                    s0[4 * s3 + 1] <= {LRU_WIDTH{1'b0}};
                    s0[4 * s3 + 2] <= {LRU_WIDTH{1'b0}};
                    s0[4 * s3 + 3] <= {LRU_WIDTH{1'b0}};
                end
            end
            else if (lru_write) begin
                s0[lru_waddr] <= s4;
            end
        end

        always @* begin
            s4[2] = (|lru_way_hit[3:2]) ? 1'b0 : (|lru_way_hit[1:0]) ? 1'b1 : lru_ori_lru[2];
            s4[1] = (|lru_way_hit[3:2]) ? lru_way_hit[2] : lru_ori_lru[1];
            s4[0] = (|lru_way_hit[1:0]) ? lru_way_hit[0] : lru_ori_lru[0];
        end

        assign lru_rdata = s0[s1];
    end
    else if ((LRU_INT != 0) && WAY == 2) begin:gen_random_2way
        reg s5;
        wire s6;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s5 <= 1'b0;
            end
            else if (lru_read) begin
                s5 <= s6;
            end
        end

        assign s6 = ~s5;
        assign lru_rdata = {2'b0,s5};
        wire [TAG_AW - 1:0] s7 = lru_raddr;
        wire [3:0] nds_unused_lru_way_hit = lru_way_hit;
        wire [TAG_AW - 1:0] s8 = lru_waddr;
        wire [2:0] nds_unused_lru_ori_lru = lru_ori_lru;
        wire nds_unused_lru_write = lru_write;
    end
    else if ((LRU_INT != 0) && WAY == 4) begin:gen_random_4way
        reg [1:0] s5;
        wire [1:0] s6;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s5 <= 2'b0;
            end
            else if (lru_read) begin
                s5 <= s6;
            end
        end

        assign s6 = s5 + 2'b1;
        assign lru_rdata[2] = s5[1];
        assign lru_rdata[1] = s5[0] & s5[1];
        assign lru_rdata[0] = s5[0] & ~s5[1];
        wire [TAG_AW - 1:0] s7 = lru_raddr;
        wire [3:0] nds_unused_lru_way_hit = lru_way_hit;
        wire [TAG_AW - 1:0] s8 = lru_waddr;
        wire [2:0] nds_unused_lru_ori_lru = lru_ori_lru;
        wire nds_unused_lru_write = lru_write;
    end
    else begin:gen_lru_else_case
        assign lru_rdata = 3'b000;
        wire [TAG_AW - 1:0] s7 = lru_raddr;
        wire [3:0] nds_unused_lru_way_hit = lru_way_hit;
        wire nds_unused_lru_read = lru_read;
        wire [TAG_AW - 1:0] s8 = lru_waddr;
        wire [2:0] nds_unused_lru_ori_lru = lru_ori_lru;
        wire nds_unused_lru_write = lru_write;
        wire nds_unused_core_clk = core_clk;
        wire nds_unused_core_reset_n = core_reset_n;
    end
endgenerate
endmodule


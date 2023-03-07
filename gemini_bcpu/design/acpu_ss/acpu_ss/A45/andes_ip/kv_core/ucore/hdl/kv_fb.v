// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fb (
    core_clk,
    core_reset_n,
    ifu_icu_kill,
    icu_miss_flush,
    fb_valid,
    fb_force_fill,
    fb_available,
    fb_bus_req_valid,
    fb_bus_req_pa,
    fb_bus_req_cacheability,
    fb_bus_req_arcache,
    fb_bus_req_ready,
    fb_alloc,
    fb_alloc_pa,
    fb_alloc_tag,
    fb_alloc_index,
    fb_alloc_offset,
    fb_alloc_fillable,
    fb_alloc_arcache,
    fb_alloc_way,
    fb_invalidate,
    fb_fill_valid,
    fb_fill_way,
    fb_fill_tag,
    fb_fill_index,
    fb_fill_data0,
    fb_fill_data1,
    fb_fill_data2,
    fb_fill_data3,
    fb_fill_last,
    fb_fill_ready,
    fb_wr,
    fb_wr_data,
    fb_wr_error,
    fb_wr_wait,
    fb_wr_last,
    fb_aq_rd,
    fb_aq_rd_tag,
    fb_aq_rd_index,
    fb_aq_rd_offset,
    fb_aq_rd_pa,
    fb_aq_wait_crit_word,
    fb_aq_hit,
    fb_f1_rd,
    fb_f1_rd_prefetch,
    fb_f1_rd_tag,
    fb_f1_rd_index,
    fb_f1_rd_offset,
    fb_f1_rd_pa,
    fb_f1_rd_data,
    fb_f1_rd_error,
    fb_f1_wait_crit_word,
    fb_f1_hit
);
parameter PALEN = 32;
parameter ICACHE_SIZE_KB = 0;
parameter TAG_WIDTH = 10;
parameter INDEX_WIDTH = 5;
parameter OFFSET_WIDTH = 3;
input core_clk;
input core_reset_n;
input ifu_icu_kill;
input icu_miss_flush;
output fb_valid;
output fb_available;
input fb_force_fill;
output fb_bus_req_valid;
output [PALEN - 1:0] fb_bus_req_pa;
output fb_bus_req_cacheability;
output [3:0] fb_bus_req_arcache;
input fb_bus_req_ready;
input fb_alloc;
input [PALEN - 1:0] fb_alloc_pa;
input [TAG_WIDTH - 1:0] fb_alloc_tag;
input [INDEX_WIDTH - 1:0] fb_alloc_index;
input [OFFSET_WIDTH - 1:0] fb_alloc_offset;
input fb_alloc_fillable;
input [3:0] fb_alloc_arcache;
input [1:0] fb_alloc_way;
input fb_invalidate;
output fb_fill_valid;
output [1:0] fb_fill_way;
output [TAG_WIDTH - 1:0] fb_fill_tag;
output [INDEX_WIDTH - 1:0] fb_fill_index;
output [63:0] fb_fill_data0;
output [63:0] fb_fill_data1;
output [63:0] fb_fill_data2;
output [63:0] fb_fill_data3;
output fb_fill_last;
input fb_fill_ready;
input fb_wr;
input [255:0] fb_wr_data;
input fb_wr_error;
output fb_wr_wait;
output fb_wr_last;
input fb_f1_rd;
input fb_f1_rd_prefetch;
input [TAG_WIDTH - 1:0] fb_f1_rd_tag;
input [INDEX_WIDTH - 1:0] fb_f1_rd_index;
input [OFFSET_WIDTH - 1:0] fb_f1_rd_offset;
input [PALEN - 1:0] fb_f1_rd_pa;
output [63:0] fb_f1_rd_data;
output fb_f1_rd_error;
output fb_f1_wait_crit_word;
output fb_f1_hit;
input fb_aq_rd;
input [TAG_WIDTH - 1:0] fb_aq_rd_tag;
input [INDEX_WIDTH - 1:0] fb_aq_rd_index;
input [OFFSET_WIDTH - 1:0] fb_aq_rd_offset;
input [PALEN - 1:0] fb_aq_rd_pa;
output fb_aq_wait_crit_word;
output fb_aq_hit;


reg s0;
wire s1;
wire s2;
wire s3;
wire s4;
reg [PALEN - 1:0] s5;
reg [TAG_WIDTH - 1:0] s6;
reg [INDEX_WIDTH - 1:0] s7;
reg s8;
reg [3:0] s9;
reg [1:0] s10;
reg s11;
wire s12;
wire s13;
wire s14;
wire s15;
wire s16;
reg s17;
wire s18;
wire s19;
wire s20;
wire s21;
reg [PALEN - 1:0] s22;
reg [TAG_WIDTH - 1:0] s23;
reg [INDEX_WIDTH - 1:0] s24;
reg s25;
wire s26;
reg [1:0] s27;
reg fb_bus_req_valid;
wire s28;
wire s29;
wire s30;
wire s31;
wire s32 = fb_wr & ~fb_wr_wait;
wire s33 = fb_fill_valid & fb_fill_ready;
wire s34;
wire nds_unused_top = fb_f1_rd | (|fb_aq_rd_tag) | (|fb_aq_rd_index) | fb_aq_rd | (|fb_f1_rd_tag) | (|fb_f1_rd_index) | (|fb_alloc_offset);
assign fb_valid = s0 | s17 | fb_bus_req_valid;
assign fb_available = ~s0 & ~fb_bus_req_valid;
assign fb_wr_wait = fb_fill_valid;
assign fb_fill_way = s27;
assign fb_fill_tag = s23;
assign fb_fill_index = s24;
assign s18 = (s16 & fb_wr_last & s32 & s8 & ~fb_invalidate) | (s16 & fb_wr_last & s32 & ~s8 & ~ifu_icu_kill & ~icu_miss_flush & ~fb_invalidate);
assign s19 = fb_fill_last | (fb_invalidate & ~s33) | (s1 & ~s25) | (ifu_icu_kill & ~s25) | (icu_miss_flush & ~s25) | (fb_force_fill & ~s25);
assign s20 = (s17 & ~s19) | s18;
assign s21 = s18 | s19;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s17 <= 1'b0;
    end
    else if (s21) begin
        s17 <= s20;
    end
end

assign s28 = fb_alloc & ~ifu_icu_kill & ~fb_invalidate & ~fb_force_fill;
assign s29 = ifu_icu_kill | fb_bus_req_ready | fb_invalidate | icu_miss_flush | fb_force_fill;
assign s30 = (fb_bus_req_valid & ~s29) | s28;
assign s31 = s28 | s29;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        fb_bus_req_valid <= 1'b0;
    end
    else if (s31) begin
        fb_bus_req_valid <= s30;
    end
end

assign s1 = fb_bus_req_valid & fb_bus_req_ready & ~fb_force_fill;
assign s2 = (fb_wr_last & s32);
assign s3 = (s0 & ~s2) | s1;
assign s4 = s1 | s2;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s0 <= 1'b0;
    end
    else if (s4) begin
        s0 <= s3;
    end
end

assign s12 = (s3 & ifu_icu_kill & ~s8) | (s3 & fb_invalidate);
assign s13 = s2;
assign s14 = (s11 & ~s13) | s12;
assign s15 = s12 | s13;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s11 <= 1'b0;
    end
    else if (s15) begin
        s11 <= s14;
    end
end

assign s16 = s0 & ~s11;
assign s26 = s8 & ~(fb_wr_error & fb_wr) & ~s34;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s22 <= {PALEN{1'b0}};
        s23 <= {TAG_WIDTH{1'b0}};
        s24 <= {INDEX_WIDTH{1'b0}};
        s25 <= 1'b0;
        s27 <= 2'b0;
    end
    else if (s18) begin
        s22 <= s5;
        s23 <= s6;
        s24 <= s7;
        s25 <= s26;
        s27 <= s10;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s5 <= {PALEN{1'b0}};
        s6 <= {TAG_WIDTH{1'b0}};
        s7 <= {INDEX_WIDTH{1'b0}};
        s8 <= 1'b0;
        s9 <= 4'b0;
    end
    else if (fb_alloc) begin
        s5 <= fb_alloc_pa;
        s6 <= fb_alloc_tag;
        s7 <= fb_alloc_index;
        s8 <= fb_alloc_fillable;
        s9 <= fb_alloc_arcache;
    end
end

reg s35;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s35 <= 1'b0;
    end
    else begin
        s35 <= fb_alloc;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s10 <= 2'b0;
    end
    else if (s35) begin
        s10 <= fb_alloc_way;
    end
end

assign fb_bus_req_pa = s5;
assign fb_bus_req_cacheability = s8;
assign fb_bus_req_arcache = s9;
generate
    if (ICACHE_SIZE_KB != 0) begin:gen_fb_biu_width_256
        reg [255:0] s36[0:1];
        reg s37[0:1];
        reg s38[0:1];
        wire [7:0] s39;
        wire [7:0] s40;
        wire [63:0] s41[0:7];
        wire [255:0] s42 = s36[0];
        wire [255:0] s43 = s36[1];
        reg s44;
        wire s45;
        wire s46;
        reg s47;
        wire s48;
        wire s49;
        wire [255:0] s50[0:1];
        integer s51;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s44 <= 1'b0;
            end
            else if (s45) begin
                s44 <= s46;
            end
        end

        assign s45 = fb_alloc | s32;
        assign s46 = fb_alloc ? 1'b0 : ~s44;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                for (s51 = 0; s51 < 2; s51 = s51 + 1) begin
                    s36[s51] <= 256'b0;
                end
            end
            else if (s32) begin
                s36[0] <= s50[0];
                s36[1] <= s50[1];
            end
        end

        assign s50[0] = (~s8 | ~s44) ? (fb_wr_data & {256{~fb_wr_error}}) : s36[0];
        assign s50[1] = (~s8 | s44) ? (fb_wr_data & {256{~fb_wr_error}}) : s36[1];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                for (s51 = 0; s51 < 2; s51 = s51 + 1) begin
                    s37[s51] <= 1'b0;
                    s38[s51] <= 1'b0;
                end
            end
            else if (s1) begin
                for (s51 = 0; s51 < 2; s51 = s51 + 1) begin
                    s37[s51] <= 1'b0;
                    s38[s51] <= 1'b0;
                end
            end
            else if (s32) begin
                s37[s44] <= 1'b1;
                s38[s44] <= fb_wr_error;
            end
        end

        assign s34 = s38[0];
        assign fb_wr_last = (~s8 & s32) | (s44 & s8 & s32);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s47 <= 1'b0;
            end
            else if (s48) begin
                s47 <= s49;
            end
        end

        assign s48 = s33;
        assign s49 = ~s47;
        assign s41[0] = s42[63:0];
        assign s41[1] = s42[127:64];
        assign s41[2] = s42[191:128];
        assign s41[3] = s42[255:192];
        assign s41[4] = s43[63:0];
        assign s41[5] = s43[127:64];
        assign s41[6] = s43[191:128];
        assign s41[7] = s43[255:192];
        assign s39[0] = s37[0];
        assign s39[1] = s37[0];
        assign s39[2] = s37[0];
        assign s39[3] = s37[0];
        assign s39[4] = s37[1];
        assign s39[5] = s37[1];
        assign s39[6] = s37[1];
        assign s39[7] = s37[1];
        assign s40[0] = s38[0];
        assign s40[1] = s38[0];
        assign s40[2] = s38[0];
        assign s40[3] = s38[0];
        assign s40[4] = s38[1];
        assign s40[5] = s38[1];
        assign s40[6] = s38[1];
        assign s40[7] = s38[1];
        wire s52;
        wire s53;
        wire s54;
        assign s52 = s39[fb_f1_rd_offset];
        assign s53 = s40[fb_f1_rd_offset];
        assign s54 = s39[fb_aq_rd_offset];
        assign fb_aq_hit = ((fb_aq_rd_pa[PALEN - 1:6] == s5[PALEN - 1:6]) & s16 & s8 & s54) | ((fb_aq_rd_pa == s22) & s17 & ~s25 & ~icu_miss_flush) | ((fb_aq_rd_pa[PALEN - 1:6] == s22[PALEN - 1:6]) & s17 & s25);
        assign fb_aq_wait_crit_word = ((fb_aq_rd_pa[PALEN - 1:6] == s5[PALEN - 1:6]) & s16 & s8 & ~s54) | ((fb_aq_rd_pa == s5) & s16 & ~s8) | ((fb_aq_rd_pa[PALEN - 1:6] == s5[PALEN - 1:6]) & fb_bus_req_valid & s8 & ~icu_miss_flush) | ((fb_aq_rd_pa[PALEN - 1:6] == s5[PALEN - 1:6]) & fb_bus_req_valid & s8 & s3) | ((fb_aq_rd_pa == s5) & fb_bus_req_valid & ~s8 & ~icu_miss_flush) | ((fb_aq_rd_pa == s5) & fb_bus_req_valid & ~s8 & s3);
        assign fb_f1_hit = ((fb_f1_rd_pa[PALEN - 1:6] == s5[PALEN - 1:6]) & s16 & s8 & s52) | ((fb_f1_rd_pa == s22) & s17 & ~s25) | ((fb_f1_rd_pa[PALEN - 1:6] == s22[PALEN - 1:6]) & s17 & s25) | (fb_f1_wait_crit_word & fb_f1_rd_prefetch);
        assign fb_f1_wait_crit_word = ((fb_f1_rd_pa[PALEN - 1:6] == s5[PALEN - 1:6]) & s16 & s8 & ~s52) | ((fb_f1_rd_pa == s5) & s16 & ~s8) | ((fb_f1_rd_pa[PALEN - 1:6] == s5[PALEN - 1:6]) & fb_bus_req_valid & s8) | ((fb_f1_rd_pa == s5) & fb_bus_req_valid & ~s8);
        assign fb_f1_rd_data = s41[fb_f1_rd_offset];
        assign fb_f1_rd_error = s38[0] | s53;
        assign fb_fill_data0 = s47 ? s41[4] : s41[0];
        assign fb_fill_data1 = s47 ? s41[5] : s41[1];
        assign fb_fill_data2 = s47 ? s41[6] : s41[2];
        assign fb_fill_data3 = s47 ? s41[7] : s41[3];
        assign fb_fill_last = s47;
        assign fb_fill_valid = (s0 & s17 & s25) | (s17 & s25 & fb_force_fill);
    end
    else begin:gen_fb_no
        reg [63:0] s36;
        reg s39;
        wire [63:0] s55;
        reg s56;
        wire nds_unused_fb_no = (|fb_aq_rd_offset) | (|fb_f1_rd_offset) | s39;
        assign s55 = ({64{(s5[4:3] == 2'd0)}} & fb_wr_data[63:0] & {64{~fb_wr_error}}) | ({64{(s5[4:3] == 2'd1)}} & fb_wr_data[127:64] & {64{~fb_wr_error}}) | ({64{(s5[4:3] == 2'd2)}} & fb_wr_data[191:128] & {64{~fb_wr_error}}) | ({64{(s5[4:3] == 2'd3)}} & fb_wr_data[255:192] & {64{~fb_wr_error}});
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s36 <= 64'b0;
            end
            else if (s32) begin
                s36 <= s55;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s39 <= 1'b0;
            end
            else if (s1) begin
                s39 <= 1'b0;
            end
            else if (s32) begin
                s39 <= 1'b1;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s56 <= 1'b0;
            end
            else if (s32) begin
                s56 <= fb_wr_error;
            end
        end

        assign s34 = 1'b0;
        assign fb_f1_hit = ((s22 == fb_f1_rd_pa) & s17) | (fb_f1_wait_crit_word & fb_f1_rd_prefetch);
        assign fb_aq_hit = ((s22 == fb_aq_rd_pa) & s17);
        assign fb_f1_rd_data = s36;
        assign fb_f1_rd_error = s17 & s56;
        assign fb_fill_data0 = s36;
        assign fb_fill_data1 = s36;
        assign fb_fill_data2 = s36;
        assign fb_fill_data3 = s36;
        assign fb_fill_last = 1'b0;
        assign fb_wr_last = s32;
        assign fb_f1_wait_crit_word = ((s5 == fb_f1_rd_pa) & s16) | ((s5 == fb_f1_rd_pa) & fb_bus_req_valid) | ((s22 == fb_f1_rd_pa) & s17);
        assign fb_aq_wait_crit_word = ((s5 == fb_aq_rd_pa) & s16) | ((s5 == fb_aq_rd_pa) & fb_bus_req_valid) | ((s22 == fb_aq_rd_pa) & s17);
        assign fb_fill_valid = 1'b0;
    end
endgenerate
endmodule


// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_replace_way (
    tag0_rdata,
    tag1_rdata,
    tag2_rdata,
    tag3_rdata,
    lru_rdata,
    replace_way,
    replace_tag
);
parameter DCACHE_WAY = 2;
parameter TAG_RAM_DW = 28;
localparam TAG_S = 0;
localparam TAG_E = 1;
localparam TAG_M = 2;
localparam TAG_L = 3;
input [TAG_RAM_DW - 1:0] tag0_rdata;
input [TAG_RAM_DW - 1:0] tag1_rdata;
input [TAG_RAM_DW - 1:0] tag2_rdata;
input [TAG_RAM_DW - 1:0] tag3_rdata;
input [2:0] lru_rdata;
output [3:0] replace_way;
output [TAG_RAM_DW - 1:0] replace_tag;


wire s0 = DCACHE_WAY == 1;
wire s1 = DCACHE_WAY == 2;
wire s2 = DCACHE_WAY == 4;
wire [2:0] s3;
wire [3:0] s4;
wire [3:0] s5;
wire [TAG_RAM_DW - 1:0] s6;
wire [3:0] s7;
wire [3:0] s8;
wire s9 = |s7;
assign s7[0] = ~tag0_rdata[TAG_S] & (s2 | s1 | s0);
assign s7[1] = ~tag1_rdata[TAG_S] & (s2 | s1);
assign s7[2] = ~tag2_rdata[TAG_S] & (s2);
assign s7[3] = ~tag3_rdata[TAG_S] & (s2);
assign s8[0] = tag0_rdata[TAG_L] & (s2 | s1 | s0);
assign s8[1] = tag1_rdata[TAG_L] & (s2 | s1);
assign s8[2] = tag2_rdata[TAG_L] & (s2);
assign s8[3] = tag3_rdata[TAG_L] & (s2);
kv_ffs #(
    .WIDTH(4)
) u_invalid_way_ffs (
    .out(s5),
    .in(s7)
);
generate
    if (DCACHE_WAY == 1) begin:gen_lru_way1
        assign s3 = 3'b000;
    end
    else if (DCACHE_WAY == 2) begin:gen_lru_way2
        assign s3[0] = s8[1] ? 1'b0 : s8[0] ? 1'b1 : lru_rdata[0];
        assign s3[1] = 1'b0;
        assign s3[2] = 1'b0;
    end
    else begin:gen_lru_way4
        assign s3[0] = s8[1] ? 1'b0 : s8[0] ? 1'b1 : lru_rdata[0];
        assign s3[1] = s8[3] ? 1'b0 : s8[2] ? 1'b1 : lru_rdata[1];
        assign s3[2] = (&s8[3:2]) ? 1'b0 : (&s8[1:0]) ? 1'b1 : lru_rdata[2];
    end
endgenerate
assign s4[0] = ~s3[2] & ~s3[0];
assign s4[1] = ~s3[2] & s3[0];
assign s4[2] = s3[2] & ~s3[1];
assign s4[3] = s3[2] & s3[1];
kv_mux_onehot #(
    .N(4),
    .W(TAG_RAM_DW)
) u_m2_lru_tag (
    .out(s6),
    .sel(s4[3:0]),
    .in({tag3_rdata[TAG_RAM_DW - 1:0],tag2_rdata[TAG_RAM_DW - 1:0],tag1_rdata[TAG_RAM_DW - 1:0],tag0_rdata[TAG_RAM_DW - 1:0]})
);
assign replace_way = s9 ? s5 : s4;
assign replace_tag[TAG_S] = s9 ? 1'b0 : s6[TAG_S];
assign replace_tag[TAG_E] = s9 ? 1'b0 : s6[TAG_E];
assign replace_tag[TAG_M] = s9 ? 1'b0 : s6[TAG_M];
assign replace_tag[TAG_L] = s9 ? 1'b0 : s6[TAG_L];
assign replace_tag[TAG_RAM_DW - 1:TAG_L + 1] = s6[TAG_RAM_DW - 1:TAG_L + 1];
wire nds_unused_signals = |{s8,lru_rdata};
endmodule


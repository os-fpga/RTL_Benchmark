// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module n22_icache_ram (
    icache_data0_rdata,
    icache_data0_wdata,
    icache_data0_cs,
    icache_data0_we,
    icache_data0_addr,
    icache_tag0_cs,
    icache_tag0_addr,
    icache_tag0_rdata,
    icache_tag0_wdata,
    icache_tag0_we,
    icache_data2_rdata,
    icache_data2_wdata,
    icache_data2_cs,
    icache_data2_we,
    icache_data2_addr,
    icache_tag2_cs,
    icache_tag2_addr,
    icache_tag2_rdata,
    icache_tag2_wdata,
    icache_tag2_we,
    icache_data3_rdata,
    icache_data3_wdata,
    icache_data3_cs,
    icache_data3_we,
    icache_data3_addr,
    icache_tag3_cs,
    icache_tag3_addr,
    icache_tag3_rdata,
    icache_tag3_wdata,
    icache_tag3_we,
    core_clk
);
parameter ICACHE_TAG_RAM_DW = 19;
parameter ICACHE_TAG_RAM_AW = 9;
parameter ICACHE_DATA_RAM_DW = 64;
parameter ICACHE_DATA_RAM_AW = 11;
output [ICACHE_DATA_RAM_DW - 1:0] icache_data0_rdata;
input [ICACHE_DATA_RAM_DW - 1:0] icache_data0_wdata;
input icache_data0_cs;
input icache_data0_we;
input [ICACHE_DATA_RAM_AW - 1:0] icache_data0_addr;
input icache_tag0_cs;
input [ICACHE_TAG_RAM_AW - 1:0] icache_tag0_addr;
output [ICACHE_TAG_RAM_DW - 1:0] icache_tag0_rdata;
input [ICACHE_TAG_RAM_DW - 1:0] icache_tag0_wdata;
input icache_tag0_we;
output [ICACHE_DATA_RAM_DW - 1:0] icache_data2_rdata;
input [ICACHE_DATA_RAM_DW - 1:0] icache_data2_wdata;
input icache_data2_cs;
input icache_data2_we;
input [ICACHE_DATA_RAM_AW - 1:0] icache_data2_addr;
input icache_tag2_cs;
input [ICACHE_TAG_RAM_AW - 1:0] icache_tag2_addr;
output [ICACHE_TAG_RAM_DW - 1:0] icache_tag2_rdata;
input [ICACHE_TAG_RAM_DW - 1:0] icache_tag2_wdata;
input icache_tag2_we;
output [ICACHE_DATA_RAM_DW - 1:0] icache_data3_rdata;
input [ICACHE_DATA_RAM_DW - 1:0] icache_data3_wdata;
input icache_data3_cs;
input icache_data3_we;
input [ICACHE_DATA_RAM_AW - 1:0] icache_data3_addr;
input icache_tag3_cs;
input [ICACHE_TAG_RAM_AW - 1:0] icache_tag3_addr;
output [ICACHE_TAG_RAM_DW - 1:0] icache_tag3_rdata;
input [ICACHE_TAG_RAM_DW - 1:0] icache_tag3_wdata;
input icache_tag3_we;
input core_clk;


endmodule


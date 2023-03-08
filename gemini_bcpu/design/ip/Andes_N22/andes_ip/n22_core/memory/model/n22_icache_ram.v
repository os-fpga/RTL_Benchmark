// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module n22_icache_ram(
		  core_clk,
		  icache_data0_rdata,
		  icache_data0_wdata,
		  icache_data0_cs,
		  icache_data0_we,
		  icache_data0_addr,
		  icache_data1_rdata,
		  icache_data1_wdata,
		  icache_data1_cs,
		  icache_data1_we,
		  icache_data1_addr,
		  icache_data2_rdata,
		  icache_data2_wdata,
		  icache_data2_cs,
		  icache_data2_we,
		  icache_data2_addr,
		  icache_data3_rdata,
		  icache_data3_wdata,
		  icache_data3_cs,
		  icache_data3_we,
		  icache_data3_addr,
		  icache_tag0_cs,
		  icache_tag0_addr,
		  icache_tag0_rdata,
		  icache_tag0_wdata,
		  icache_tag0_we,
		  icache_tag1_cs,
		  icache_tag1_addr,
		  icache_tag1_rdata,
		  icache_tag1_wdata,
		  icache_tag1_we,
		  icache_tag2_cs,
		  icache_tag2_addr,
		  icache_tag2_rdata,
		  icache_tag2_wdata,
		  icache_tag2_we,
		  icache_tag3_cs,
		  icache_tag3_addr,
		  icache_tag3_rdata,
		  icache_tag3_wdata,
		  icache_tag3_we
);

input              core_clk;

parameter ICACHE_TAG_RAM_DW  = 19;
parameter ICACHE_TAG_RAM_AW  = 9;
parameter ICACHE_DATA_RAM_DW = 64;
parameter ICACHE_DATA_RAM_AW = 11;

output 	[ICACHE_DATA_RAM_DW-1:0]icache_data0_rdata;
input  	[ICACHE_DATA_RAM_DW-1:0]icache_data0_wdata;
input                  		icache_data0_cs;
input				icache_data0_we;
input	[ICACHE_DATA_RAM_AW-1:0]icache_data0_addr;

output 	[ICACHE_DATA_RAM_DW-1:0]icache_data1_rdata;
input  	[ICACHE_DATA_RAM_DW-1:0]icache_data1_wdata;
input                  		icache_data1_cs;
input				icache_data1_we;
input	[ICACHE_DATA_RAM_AW-1:0]icache_data1_addr;

output 	[ICACHE_DATA_RAM_DW-1:0]icache_data2_rdata;
input  	[ICACHE_DATA_RAM_DW-1:0]icache_data2_wdata;
input                  		icache_data2_cs;
input				icache_data2_we;
input	[ICACHE_DATA_RAM_AW-1:0]icache_data2_addr;

output 	[ICACHE_DATA_RAM_DW-1:0]icache_data3_rdata;
input  	[ICACHE_DATA_RAM_DW-1:0]icache_data3_wdata;
input                  		icache_data3_cs;
input				icache_data3_we;
input	[ICACHE_DATA_RAM_AW-1:0]icache_data3_addr;

input                           icache_tag0_cs;
input	[ICACHE_TAG_RAM_AW-1:0]	icache_tag0_addr;
output	[ICACHE_TAG_RAM_DW-1:0]	icache_tag0_rdata;
input	[ICACHE_TAG_RAM_DW-1:0] icache_tag0_wdata;
input                           icache_tag0_we;

input                           icache_tag1_cs;
input	[ICACHE_TAG_RAM_AW-1:0]	icache_tag1_addr;
output	[ICACHE_TAG_RAM_DW-1:0]	icache_tag1_rdata;
input	[ICACHE_TAG_RAM_DW-1:0]	icache_tag1_wdata;
input                           icache_tag1_we;

input                           icache_tag2_cs;
input	[ICACHE_TAG_RAM_AW-1:0]	icache_tag2_addr;
output	[ICACHE_TAG_RAM_DW-1:0]	icache_tag2_rdata;
input	[ICACHE_TAG_RAM_DW-1:0] icache_tag2_wdata;
input                           icache_tag2_we;

input                           icache_tag3_cs;
input	[ICACHE_TAG_RAM_AW-1:0]	icache_tag3_addr;
output	[ICACHE_TAG_RAM_DW-1:0]	icache_tag3_rdata;
input	[ICACHE_TAG_RAM_DW-1:0] icache_tag3_wdata;
input                           icache_tag3_we;


defparam icache_data_0.ADDR_WIDTH = ICACHE_DATA_RAM_AW;
defparam icache_data_0.WRITE_WIDTH = ICACHE_DATA_RAM_DW;
nds_ram_model icache_data_0 (
   .clk  (core_clk),
   .cs   (icache_data0_cs),
   .we   (icache_data0_we),
   .addr (icache_data0_addr),
   .din  (icache_data0_wdata),
   .dout (icache_data0_rdata)
);

defparam icache_tag_0.ADDR_WIDTH = ICACHE_TAG_RAM_AW;
defparam icache_tag_0.WRITE_WIDTH = ICACHE_TAG_RAM_DW;
nds_ram_model icache_tag_0 (
   .clk  (core_clk),
   .cs   (icache_tag0_cs),
   .we   (icache_tag0_we),
   .addr (icache_tag0_addr),
   .din  (icache_tag0_wdata),
   .dout (icache_tag0_rdata)
);

defparam icache_data_1.ADDR_WIDTH = ICACHE_DATA_RAM_AW;
defparam icache_data_1.WRITE_WIDTH = ICACHE_DATA_RAM_DW;
nds_ram_model icache_data_1 (
   .clk  (core_clk),
   .cs   (icache_data1_cs),
   .we   (icache_data1_we),
   .addr (icache_data1_addr),
   .din  (icache_data1_wdata),
   .dout (icache_data1_rdata)
);

defparam icache_tag_1.ADDR_WIDTH = ICACHE_TAG_RAM_AW;
defparam icache_tag_1.WRITE_WIDTH = ICACHE_TAG_RAM_DW;
nds_ram_model icache_tag_1 (
   .clk  (core_clk),
   .cs   (icache_tag1_cs),
   .we   (icache_tag1_we),
   .addr (icache_tag1_addr),
   .din  (icache_tag1_wdata),
   .dout (icache_tag1_rdata)
);

defparam icache_data_2.ADDR_WIDTH = ICACHE_DATA_RAM_AW;
defparam icache_data_2.WRITE_WIDTH = ICACHE_DATA_RAM_DW;
nds_ram_model icache_data_2 (
   .clk  (core_clk),
   .cs   (icache_data2_cs),
   .we   (icache_data2_we),
   .addr (icache_data2_addr),
   .din  (icache_data2_wdata),
   .dout (icache_data2_rdata)
);

defparam icache_tag_2.ADDR_WIDTH = ICACHE_TAG_RAM_AW;
defparam icache_tag_2.WRITE_WIDTH = ICACHE_TAG_RAM_DW;
nds_ram_model icache_tag_2 (
   .clk  (core_clk),
   .cs   (icache_tag2_cs),
   .we   (icache_tag2_we),
   .addr (icache_tag2_addr),
   .din  (icache_tag2_wdata),
   .dout (icache_tag2_rdata)
);

defparam icache_data_3.ADDR_WIDTH = ICACHE_DATA_RAM_AW;
defparam icache_data_3.WRITE_WIDTH = ICACHE_DATA_RAM_DW;
nds_ram_model icache_data_3 (
   .clk  (core_clk),
   .cs   (icache_data3_cs),
   .we   (icache_data3_we),
   .addr (icache_data3_addr),
   .din  (icache_data3_wdata),
   .dout (icache_data3_rdata)
);

defparam icache_tag_3.ADDR_WIDTH = ICACHE_TAG_RAM_AW;
defparam icache_tag_3.WRITE_WIDTH = ICACHE_TAG_RAM_DW;
nds_ram_model icache_tag_3 (
   .clk  (core_clk),
   .cs   (icache_tag3_cs),
   .we   (icache_tag3_we),
   .addr (icache_tag3_addr),
   .din  (icache_tag3_wdata),
   .dout (icache_tag3_rdata)
);

endmodule


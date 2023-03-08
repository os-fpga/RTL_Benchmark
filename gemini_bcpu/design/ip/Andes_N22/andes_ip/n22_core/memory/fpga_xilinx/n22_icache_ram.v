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
parameter ICACHE_TAG_RAM_DW  = 19;
parameter ICACHE_TAG_RAM_AW  = 9;
parameter ICACHE_DATA_RAM_DW = 64;
parameter ICACHE_DATA_RAM_AW = 11;

input				core_clk;
output 	[ICACHE_DATA_RAM_DW-1:0]	icache_data0_rdata;
input  	[ICACHE_DATA_RAM_DW-1:0]  	icache_data0_wdata;
input                  		icache_data0_cs;
input				icache_data0_we;
input	[ICACHE_DATA_RAM_AW-1:0] 	icache_data0_addr;

output 	[ICACHE_DATA_RAM_DW-1:0]	icache_data1_rdata;
input  	[ICACHE_DATA_RAM_DW-1:0]  	icache_data1_wdata;
input                  		icache_data1_cs;
input				icache_data1_we;
input	[ICACHE_DATA_RAM_AW-1:0] 	icache_data1_addr;

output 	[ICACHE_DATA_RAM_DW-1:0]	icache_data2_rdata;
input  	[ICACHE_DATA_RAM_DW-1:0]  	icache_data2_wdata;
input                  		icache_data2_cs;
input				icache_data2_we;
input	[ICACHE_DATA_RAM_AW-1:0] 	icache_data2_addr;

output 	[ICACHE_DATA_RAM_DW-1:0]	icache_data3_rdata;
input  	[ICACHE_DATA_RAM_DW-1:0]  	icache_data3_wdata;
input                  		icache_data3_cs;
input				icache_data3_we;
input	[ICACHE_DATA_RAM_AW-1:0] 	icache_data3_addr;

input                           icache_tag0_cs;
input	[ICACHE_TAG_RAM_AW-1:0]	icache_tag0_addr;
output	[ICACHE_TAG_RAM_DW-1:0]	icache_tag0_rdata;
input	[ICACHE_TAG_RAM_DW-1:0] 	icache_tag0_wdata;
input                           icache_tag0_we;

input                           icache_tag1_cs;
input	[ICACHE_TAG_RAM_AW-1:0]	icache_tag1_addr;
output	[ICACHE_TAG_RAM_DW-1:0]	icache_tag1_rdata;
input	[ICACHE_TAG_RAM_DW-1:0] 	icache_tag1_wdata;
input                           icache_tag1_we;

input                           icache_tag2_cs;
input	[ICACHE_TAG_RAM_AW-1:0]	icache_tag2_addr;
output	[ICACHE_TAG_RAM_DW-1:0]	icache_tag2_rdata;
input	[ICACHE_TAG_RAM_DW-1:0] 	icache_tag2_wdata;
input                           icache_tag2_we;

input                           icache_tag3_cs;
input	[ICACHE_TAG_RAM_AW-1:0]	icache_tag3_addr;
output	[ICACHE_TAG_RAM_DW-1:0]	icache_tag3_rdata;
input	[ICACHE_TAG_RAM_DW-1:0] 	icache_tag3_wdata;
input                           icache_tag3_we;


generate
if (ICACHE_TAG_RAM_AW==3 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_8x64
	ram8x64 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({8{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram8x64 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({8{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram8x64 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({8{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram8x64 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({8{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==3 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_8x32
	ram8x32 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({4{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram8x32 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({4{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram8x32 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({4{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram8x32 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({4{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==4 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_16x64
	ram16x64 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({8{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram16x64 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({8{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram16x64 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({8{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram16x64 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({8{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==4 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_16x32
	ram16x32 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({4{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram16x32 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({4{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram16x32 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({4{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram16x32 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({4{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==5 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_32x64
	ram32x64 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({8{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram32x64 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({8{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram32x64 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({8{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram32x64 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({8{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==5 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_32x32
	ram32x32 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({4{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram32x32 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({4{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram32x32 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({4{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram32x32 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({4{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==6 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_64x64
	ram64x64 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({8{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram64x64 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({8{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram64x64 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({8{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram64x64 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({8{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==6 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_64x32
	ram64x32 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({4{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram64x32 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({4{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram64x32 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({4{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram64x32 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({4{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==7 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_128x64
	ram128x64 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({8{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram128x64 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({8{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram128x64 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({8{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram128x64 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({8{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==7 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_128x32
	ram128x32 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({4{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram128x32 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({4{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram128x32 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({4{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram128x32 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({4{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==8 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_256x64
	ram256x64 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({8{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram256x64 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({8{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram256x64 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({8{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram256x64 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({8{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==8 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_256x32
	ram256x32 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({4{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram256x32 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({4{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram256x32 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({4{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram256x32 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({4{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==9 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_512x64
	ram512x64 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({8{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram512x64 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({8{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram512x64 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({8{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram512x64 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({8{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==9 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_512x32
	ram512x32 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({4{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram512x32 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({4{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram512x32 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({4{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram512x32 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({4{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==10 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_1024x64
	ram1024x64 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({8{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram1024x64 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({8{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram1024x64 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({8{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram1024x64 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({8{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==10 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_1024x32
	ram1024x32 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({4{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram1024x32 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({4{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram1024x32 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({4{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram1024x32 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({4{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==11 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_2048x64
	ram2048x64 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({8{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram2048x64 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({8{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram2048x64 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({8{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram2048x64 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({8{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==11 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_2048x32
	ram2048x32 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({4{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram2048x32 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({4{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram2048x32 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({4{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram2048x32 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({4{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==12 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_4096x64
	ram4096x64 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({8{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram4096x64 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({8{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram4096x64 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({8{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram4096x64 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({8{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==12 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_4096x32
	ram4096x32 icache_tag_0 (
		.clka    (core_clk                               ),
		.ena     (icache_tag0_cs                      ),
		.wea     ({4{icache_tag0_we}}                 ),
		.addra   (icache_tag0_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag0_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag0_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram4096x32 icache_tag_1 (
		.clka    (core_clk                               ),
		.ena     (icache_tag1_cs                      ),
		.wea     ({4{icache_tag1_we}}                 ),
		.addra   (icache_tag1_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag1_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag1_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram4096x32 icache_tag_2 (
		.clka    (core_clk                               ),
		.ena     (icache_tag2_cs                      ),
		.wea     ({4{icache_tag2_we}}                 ),
		.addra   (icache_tag2_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag2_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag2_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
	ram4096x32 icache_tag_3 (
		.clka    (core_clk                               ),
		.ena     (icache_tag3_cs                      ),
		.wea     ({4{icache_tag3_we}}                 ),
		.addra   (icache_tag3_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag3_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag3_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==6 && ICACHE_DATA_RAM_DW > 32) begin : gen_data_64x39
	ram64x39 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({8{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram64x39 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({8{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram64x39 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({8{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram64x39 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({8{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==6 && ICACHE_DATA_RAM_DW <=32) begin : gen_data_64x32
	ram64x32 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({4{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram64x32 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({4{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram64x32 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({4{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram64x32 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({4{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==7 && ICACHE_DATA_RAM_DW > 32) begin : gen_data_128x39
	ram128x39 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({8{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram128x39 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({8{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram128x39 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({8{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram128x39 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({8{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==7 && ICACHE_DATA_RAM_DW <=32) begin : gen_data_128x32
	ram128x32 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({4{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram128x32 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({4{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram128x32 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({4{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram128x32 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({4{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==8 && ICACHE_DATA_RAM_DW > 32) begin : gen_data_256x39
	ram256x39 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({8{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram256x39 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({8{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram256x39 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({8{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram256x39 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({8{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==8 && ICACHE_DATA_RAM_DW <=32) begin : gen_data_256x32
	ram256x32 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({4{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram256x32 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({4{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram256x32 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({4{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram256x32 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({4{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==9 && ICACHE_DATA_RAM_DW > 32) begin : gen_data_512x39
	ram512x39 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({8{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram512x39 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({8{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram512x39 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({8{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram512x39 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({8{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==9 && ICACHE_DATA_RAM_DW <=32) begin : gen_data_512x32
	ram512x32 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({4{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram512x32 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({4{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram512x32 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({4{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram512x32 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({4{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==10 && ICACHE_DATA_RAM_DW > 32) begin : gen_data_1024x39
	ram1024x39 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({8{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram1024x39 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({8{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram1024x39 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({8{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram1024x39 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({8{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==10 && ICACHE_DATA_RAM_DW <=32) begin : gen_data_1024x32
	ram1024x32 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({4{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram1024x32 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({4{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram1024x32 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({4{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram1024x32 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({4{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==11 && ICACHE_DATA_RAM_DW > 32) begin : gen_data_2048x39
	ram2048x39 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({8{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram2048x39 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({8{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram2048x39 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({8{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram2048x39 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({8{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==11 && ICACHE_DATA_RAM_DW <=32) begin : gen_data_2048x32
	ram2048x32 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({4{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram2048x32 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({4{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram2048x32 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({4{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram2048x32 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({4{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==12 && ICACHE_DATA_RAM_DW > 32) begin : gen_data_4096x39
	ram4096x39 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({8{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram4096x39 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({8{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram4096x39 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({8{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram4096x39 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({8{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==12 && ICACHE_DATA_RAM_DW <=32) begin : gen_data_4096x32
	ram4096x32 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({4{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram4096x32 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({4{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram4096x32 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({4{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram4096x32 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({4{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==13 && ICACHE_DATA_RAM_DW > 32) begin : gen_data_8192x39
	ram8192x39 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({8{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram8192x39 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({8{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram8192x39 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({8{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram8192x39 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({8{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==13 && ICACHE_DATA_RAM_DW <=32) begin : gen_data_8192x32
	ram8192x32 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({4{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram8192x32 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({4{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram8192x32 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({4{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram8192x32 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({4{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==14 && ICACHE_DATA_RAM_DW > 32) begin : gen_data_16384x39
	ram16384x39 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({8{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram16384x39 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({8{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram16384x39 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({8{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram16384x39 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({8{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==14 && ICACHE_DATA_RAM_DW <=32) begin : gen_data_16384x32
	ram16384x32 icache_data_0 (
		.clka    (core_clk                                 ),
		.ena     (icache_data0_cs                       ),
		.wea     ({4{icache_data0_we}}                  ),
		.addra   (icache_data0_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data0_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data0_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram16384x32 icache_data_1 (
		.clka    (core_clk                                 ),
		.ena     (icache_data1_cs                       ),
		.wea     ({4{icache_data1_we}}                  ),
		.addra   (icache_data1_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data1_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data1_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram16384x32 icache_data_2 (
		.clka    (core_clk                                 ),
		.ena     (icache_data2_cs                       ),
		.wea     ({4{icache_data2_we}}                  ),
		.addra   (icache_data2_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data2_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data2_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
	ram16384x32 icache_data_3 (
		.clka    (core_clk                                 ),
		.ena     (icache_data3_cs                       ),
		.wea     ({4{icache_data3_we}}                  ),
		.addra   (icache_data3_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data3_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data3_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate


endmodule


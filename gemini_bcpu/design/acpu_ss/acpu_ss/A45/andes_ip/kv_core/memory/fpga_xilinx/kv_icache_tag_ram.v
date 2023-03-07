// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_icache_tag_ram(
		  clk,
		  icache_tag_cs,
		  icache_tag_addr,
		  icache_tag_rdata,
		  icache_tag_wdata,
		  icache_tag_we,
		  icache_tag_ctrl_in,
		  icache_tag_ctrl_out
);
parameter ICACHE_TAG_RAM_DW  = 19;
parameter ICACHE_TAG_RAM_AW  = 9;
parameter ICACHE_TAG_RAM_CTRL_IN_WIDTH = 1;
parameter ICACHE_TAG_RAM_CTRL_OUT_WIDTH = 1;

input				clk;
input                           icache_tag_cs;
input	[ICACHE_TAG_RAM_AW-1:0]	icache_tag_addr;
output	[ICACHE_TAG_RAM_DW-1:0]	icache_tag_rdata;
input	[ICACHE_TAG_RAM_DW-1:0]	icache_tag_wdata;
input                           icache_tag_we;
input   [(ICACHE_TAG_RAM_CTRL_IN_WIDTH-1):0] icache_tag_ctrl_in;
output [(ICACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] icache_tag_ctrl_out;


generate
if (ICACHE_TAG_RAM_AW==5 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_32x64
	ram32x64 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({8{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==5 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_32x32
	ram32x32 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({4{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==6 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_64x64
	ram64x64 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({8{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==6 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_64x32
	ram64x32 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({4{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==7 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_128x64
	ram128x64 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({8{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==7 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_128x32
	ram128x32 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({4{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==8 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_256x64
	ram256x64 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({8{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==8 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_256x32
	ram256x32 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({4{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==9 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_512x64
	ram512x64 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({8{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==9 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_512x32
	ram512x32 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({4{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==10 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_1024x64
	ram1024x64 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({8{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==10 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_1024x32
	ram1024x32 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({4{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==11 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_2048x64
	ram2048x64 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({8{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==11 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_2048x32
	ram2048x32 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({4{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_TAG_RAM_AW==12 && ICACHE_TAG_RAM_DW > 32) begin : gen_tag_4096x64
	ram4096x64 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({8{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_TAG_RAM_AW==12 && ICACHE_TAG_RAM_DW <= 32) begin : gen_tag_4096x32
	ram4096x32 ram_inst (
		.clka    (clk                               ),
		.ena     (icache_tag_cs                      ),
		.wea     ({4{icache_tag_we}}                 ),
		.addra   (icache_tag_addr [ICACHE_TAG_RAM_AW-1:0]),
		.dina    (icache_tag_wdata[ICACHE_TAG_RAM_DW-1:0]),
		.douta   (icache_tag_rdata[ICACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

wire nds_unused_icache_data_ctrl_in = |icache_tag_ctrl_in;
assign icache_tag_ctrl_out = {ICACHE_TAG_RAM_CTRL_OUT_WIDTH{1'b0}};


endmodule


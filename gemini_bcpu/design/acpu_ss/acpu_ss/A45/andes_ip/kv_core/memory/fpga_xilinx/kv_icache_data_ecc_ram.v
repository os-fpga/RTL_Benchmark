// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_icache_data_ecc_ram(
		  clk,
		  icache_data_rdata,
		  icache_data_wdata,
		  icache_data_cs,
		  icache_data_we,
		  icache_data_addr,
		  icache_data_ctrl_in,
		  icache_data_ctrl_out
);
parameter ICACHE_DATA_RAM_DW = 64;
parameter ICACHE_DATA_RAM_AW = 11;
parameter ICACHE_DATA_RAM_CTRL_IN_WIDTH = 1;
parameter ICACHE_DATA_RAM_CTRL_OUT_WIDTH = 1;

input				clk;
output 	[ICACHE_DATA_RAM_DW-1:0]icache_data_rdata;
input  	[ICACHE_DATA_RAM_DW-1:0]icache_data_wdata;
input                  		icache_data_cs;
input				icache_data_we;
input	[ICACHE_DATA_RAM_AW-1:0]icache_data_addr;
input   [(ICACHE_DATA_RAM_CTRL_IN_WIDTH-1):0] icache_data_ctrl_in;
output [(ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] icache_data_ctrl_out;


generate
if (ICACHE_DATA_RAM_AW==5 && ICACHE_DATA_RAM_DW > 64) begin : gen_data_32x72
	ram32x72 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==5 && ICACHE_DATA_RAM_DW <=64) begin : gen_data_32x64
	ram32x64 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==6 && ICACHE_DATA_RAM_DW > 64) begin : gen_data_64x72
	ram64x72 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==6 && ICACHE_DATA_RAM_DW <=64) begin : gen_data_64x64
	ram64x64 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==7 && ICACHE_DATA_RAM_DW > 64) begin : gen_data_128x72
	ram128x72 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==7 && ICACHE_DATA_RAM_DW <=64) begin : gen_data_128x64
	ram128x64 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==8 && ICACHE_DATA_RAM_DW > 64) begin : gen_data_256x72
	ram256x72 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==8 && ICACHE_DATA_RAM_DW <=64) begin : gen_data_256x64
	ram256x64 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==9 && ICACHE_DATA_RAM_DW > 64) begin : gen_data_512x72
	ram512x72 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==9 && ICACHE_DATA_RAM_DW <=64) begin : gen_data_512x64
	ram512x64 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==10 && ICACHE_DATA_RAM_DW > 64) begin : gen_data_1024x72
	ram1024x72 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==10 && ICACHE_DATA_RAM_DW <=64) begin : gen_data_1024x64
	ram1024x64 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==11 && ICACHE_DATA_RAM_DW > 64) begin : gen_data_2048x72
	ram2048x72 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==11 && ICACHE_DATA_RAM_DW <=64) begin : gen_data_2048x64
	ram2048x64 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==12 && ICACHE_DATA_RAM_DW > 64) begin : gen_data_4096x72
	ram4096x72 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==12 && ICACHE_DATA_RAM_DW <=64) begin : gen_data_4096x64
	ram4096x64 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==13 && ICACHE_DATA_RAM_DW > 64) begin : gen_data_8192x72
	ram8192x72 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==13 && ICACHE_DATA_RAM_DW <=64) begin : gen_data_8192x64
	ram8192x64 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

generate
if (ICACHE_DATA_RAM_AW==14 && ICACHE_DATA_RAM_DW > 64) begin : gen_data_16384x72
	ram16384x72 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate
generate
if (ICACHE_DATA_RAM_AW==14 && ICACHE_DATA_RAM_DW <=64) begin : gen_data_16384x64
	ram16384x64 ram_inst (
		.clka    (clk                                 ),
		.ena     (icache_data_cs                       ),
		.wea     ({8{icache_data_we}}                  ),
		.addra   (icache_data_addr [ICACHE_DATA_RAM_AW-1:0]),
		.dina    (icache_data_wdata[ICACHE_DATA_RAM_DW-1:0]),
		.douta   (icache_data_rdata[ICACHE_DATA_RAM_DW-1:0])
	);
end
endgenerate

wire nds_unused_icache_data_ctrl_in = |icache_data_ctrl_in;
assign icache_data_ctrl_out = {ICACHE_DATA_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule


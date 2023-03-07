// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcache_tag_ram(
		  clk,
		  dcache_tag_cs,
		  dcache_tag_we,
		  dcache_tag_addr,
		  dcache_tag_rdata,
		  dcache_tag_wdata,
		  dcache_tag_ctrl_in,
		  dcache_tag_ctrl_out
);
parameter DCACHE_TAG_RAM_DW = 64;
parameter DCACHE_TAG_RAM_AW = 11;
parameter DCACHE_TAG_RAM_CTRL_IN_WIDTH = 1;
parameter DCACHE_TAG_RAM_CTRL_OUT_WIDTH = 1;

input					clk;
input                           	dcache_tag_cs;
input                                   dcache_tag_we;
input	[DCACHE_TAG_RAM_AW-1:0]		dcache_tag_addr;
output	[DCACHE_TAG_RAM_DW-1:0]		dcache_tag_rdata;
input	[DCACHE_TAG_RAM_DW-1:0] 	dcache_tag_wdata;
input    [(DCACHE_TAG_RAM_CTRL_IN_WIDTH-1):0] dcache_tag_ctrl_in;
output  [(DCACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] dcache_tag_ctrl_out;


generate
if ((DCACHE_TAG_RAM_AW==6) && (DCACHE_TAG_RAM_DW <= 32)) begin : gen_tag_64x32
	ram64x32 ram_inst (
		.clka    (clk                                   ),
		.ena     (dcache_tag_cs                          ),
		.wea     ({4{dcache_tag_we}}                     ),
		.addra   (dcache_tag_addr [DCACHE_TAG_RAM_AW-1:0]),
		.dina    (dcache_tag_wdata[DCACHE_TAG_RAM_DW-1:0]),
		.douta   (dcache_tag_rdata[DCACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if ((DCACHE_TAG_RAM_AW==6) && (DCACHE_TAG_RAM_DW > 32)) begin : gen_tag_64x64
	ram64x64 ram_inst (
		.clka    (clk                                   ),
		.ena     (dcache_tag_cs                          ),
		.wea     ({8{dcache_tag_we}}                     ),
		.addra   (dcache_tag_addr [DCACHE_TAG_RAM_AW-1:0]),
		.dina    (dcache_tag_wdata[DCACHE_TAG_RAM_DW-1:0]),
		.douta   (dcache_tag_rdata[DCACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if ((DCACHE_TAG_RAM_AW==7) && (DCACHE_TAG_RAM_DW <= 32)) begin : gen_tag_128x32
	ram128x32 ram_inst (
		.clka    (clk                                   ),
		.ena     (dcache_tag_cs                          ),
		.wea     ({4{dcache_tag_we}}                     ),
		.addra   (dcache_tag_addr [DCACHE_TAG_RAM_AW-1:0]),
		.dina    (dcache_tag_wdata[DCACHE_TAG_RAM_DW-1:0]),
		.douta   (dcache_tag_rdata[DCACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if ((DCACHE_TAG_RAM_AW==7) && (DCACHE_TAG_RAM_DW > 32)) begin : gen_tag_128x64
	ram128x64 ram_inst (
		.clka    (clk                                   ),
		.ena     (dcache_tag_cs                          ),
		.wea     ({8{dcache_tag_we}}                     ),
		.addra   (dcache_tag_addr [DCACHE_TAG_RAM_AW-1:0]),
		.dina    (dcache_tag_wdata[DCACHE_TAG_RAM_DW-1:0]),
		.douta   (dcache_tag_rdata[DCACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if ((DCACHE_TAG_RAM_AW==8) && (DCACHE_TAG_RAM_DW <= 32)) begin : gen_tag_256x32
	ram256x32 ram_inst (
		.clka    (clk                                   ),
		.ena     (dcache_tag_cs                          ),
		.wea     ({4{dcache_tag_we}}                     ),
		.addra   (dcache_tag_addr [DCACHE_TAG_RAM_AW-1:0]),
		.dina    (dcache_tag_wdata[DCACHE_TAG_RAM_DW-1:0]),
		.douta   (dcache_tag_rdata[DCACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if ((DCACHE_TAG_RAM_AW==8) && (DCACHE_TAG_RAM_DW > 32)) begin : gen_tag_256x64
	ram256x64 ram_inst (
		.clka    (clk                                   ),
		.ena     (dcache_tag_cs                          ),
		.wea     ({8{dcache_tag_we}}                     ),
		.addra   (dcache_tag_addr [DCACHE_TAG_RAM_AW-1:0]),
		.dina    (dcache_tag_wdata[DCACHE_TAG_RAM_DW-1:0]),
		.douta   (dcache_tag_rdata[DCACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if ((DCACHE_TAG_RAM_AW==9) && (DCACHE_TAG_RAM_DW <= 32)) begin : gen_tag_512x32
	ram512x32 ram_inst (
		.clka    (clk                                   ),
		.ena     (dcache_tag_cs                          ),
		.wea     ({4{dcache_tag_we}}                     ),
		.addra   (dcache_tag_addr [DCACHE_TAG_RAM_AW-1:0]),
		.dina    (dcache_tag_wdata[DCACHE_TAG_RAM_DW-1:0]),
		.douta   (dcache_tag_rdata[DCACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if ((DCACHE_TAG_RAM_AW==9) && (DCACHE_TAG_RAM_DW > 32)) begin : gen_tag_512x64
	ram512x64 ram_inst (
		.clka    (clk                                   ),
		.ena     (dcache_tag_cs                          ),
		.wea     ({8{dcache_tag_we}}                     ),
		.addra   (dcache_tag_addr [DCACHE_TAG_RAM_AW-1:0]),
		.dina    (dcache_tag_wdata[DCACHE_TAG_RAM_DW-1:0]),
		.douta   (dcache_tag_rdata[DCACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if ((DCACHE_TAG_RAM_AW==10) && (DCACHE_TAG_RAM_DW <= 32)) begin : gen_tag_1024x32
	ram1024x32 ram_inst (
		.clka    (clk                                   ),
		.ena     (dcache_tag_cs                          ),
		.wea     ({4{dcache_tag_we}}                     ),
		.addra   (dcache_tag_addr [DCACHE_TAG_RAM_AW-1:0]),
		.dina    (dcache_tag_wdata[DCACHE_TAG_RAM_DW-1:0]),
		.douta   (dcache_tag_rdata[DCACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if ((DCACHE_TAG_RAM_AW==10) && (DCACHE_TAG_RAM_DW > 32)) begin : gen_tag_1024x64
	ram1024x64 ram_inst (
		.clka    (clk                                   ),
		.ena     (dcache_tag_cs                          ),
		.wea     ({8{dcache_tag_we}}                     ),
		.addra   (dcache_tag_addr [DCACHE_TAG_RAM_AW-1:0]),
		.dina    (dcache_tag_wdata[DCACHE_TAG_RAM_DW-1:0]),
		.douta   (dcache_tag_rdata[DCACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if ((DCACHE_TAG_RAM_AW==11) && (DCACHE_TAG_RAM_DW <= 32)) begin : gen_tag_2048x32
	ram2048x32 ram_inst (
		.clka    (clk                                   ),
		.ena     (dcache_tag_cs                          ),
		.wea     ({4{dcache_tag_we}}                     ),
		.addra   (dcache_tag_addr [DCACHE_TAG_RAM_AW-1:0]),
		.dina    (dcache_tag_wdata[DCACHE_TAG_RAM_DW-1:0]),
		.douta   (dcache_tag_rdata[DCACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if ((DCACHE_TAG_RAM_AW==11) && (DCACHE_TAG_RAM_DW > 32)) begin : gen_tag_2048x64
	ram2048x64 ram_inst (
		.clka    (clk                                   ),
		.ena     (dcache_tag_cs                          ),
		.wea     ({8{dcache_tag_we}}                     ),
		.addra   (dcache_tag_addr [DCACHE_TAG_RAM_AW-1:0]),
		.dina    (dcache_tag_wdata[DCACHE_TAG_RAM_DW-1:0]),
		.douta   (dcache_tag_rdata[DCACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if ((DCACHE_TAG_RAM_AW==12) && (DCACHE_TAG_RAM_DW <= 32)) begin : gen_tag_4096x32
	ram4096x32 ram_inst (
		.clka    (clk                                   ),
		.ena     (dcache_tag_cs                          ),
		.wea     ({4{dcache_tag_we}}                     ),
		.addra   (dcache_tag_addr [DCACHE_TAG_RAM_AW-1:0]),
		.dina    (dcache_tag_wdata[DCACHE_TAG_RAM_DW-1:0]),
		.douta   (dcache_tag_rdata[DCACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

generate
if ((DCACHE_TAG_RAM_AW==12) && (DCACHE_TAG_RAM_DW > 32)) begin : gen_tag_4096x64
	ram4096x64 ram_inst (
		.clka    (clk                                   ),
		.ena     (dcache_tag_cs                          ),
		.wea     ({8{dcache_tag_we}}                     ),
		.addra   (dcache_tag_addr [DCACHE_TAG_RAM_AW-1:0]),
		.dina    (dcache_tag_wdata[DCACHE_TAG_RAM_DW-1:0]),
		.douta   (dcache_tag_rdata[DCACHE_TAG_RAM_DW-1:0])
	);
end
endgenerate

wire	nds_unused_dcache_ctrl_in = |dcache_tag_ctrl_in;
assign dcache_tag_ctrl_out = {DCACHE_TAG_RAM_CTRL_OUT_WIDTH{1'b0}};


endmodule


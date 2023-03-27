// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module n22_ilm_ram (
		  core_clk,
		  ilm_cs,
		  ilm_addr,
		  ilm_byte_we,
		  ilm_wdata,
		  ilm_rdata
);
parameter ILM_RAM_AW = 11;
parameter ILM_RAM_DW = 64;
parameter ILM_RAM_BWEW = 8;
parameter ILM_ECC_TYPE = "none";

localparam ILM_DW           = ILM_RAM_BWEW*8;
localparam ILM_DATA_MSB     = ILM_DW-1;
localparam ILM_DATA_LSB     = 0;
localparam ILM_ECCW    	    = (ILM_DW == 64) ? 8 : (ILM_ECC_TYPE == "ecc" ? 7 : 4);
localparam ILM_ECC_CODE_LSB = ILM_DATA_MSB+1;
localparam ILM_ECC_CODE_MSB = ILM_ECC_CODE_LSB+ILM_ECCW-1;

input                   core_clk;
input                   ilm_cs;
input      [ILM_RAM_AW-1:0] ilm_addr;
input    [ILM_RAM_BWEW-1:0] ilm_byte_we;
input      [ILM_RAM_DW-1:0] ilm_wdata;
output     [ILM_RAM_DW-1:0] ilm_rdata;

wire                        ilm_word_we = |ilm_byte_we;



generate
if ((ILM_RAM_AW==7) && (ILM_RAM_DW==32)) begin : gen_ram128x32
	ram128x32 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==7) && (ILM_RAM_DW==39)) begin : gen_ram128x39
	ram128x39 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_word_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==7) && (ILM_RAM_DW==64)) begin : gen_ram128x64
	ram128x64 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==7) && (ILM_RAM_DW==72)) begin : gen_ram128x72
	ram128x72 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	({9{ilm_word_we}}),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==8) && (ILM_RAM_DW==32)) begin : gen_ram256x32
	ram256x32 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==8) && (ILM_RAM_DW==39)) begin : gen_ram256x39
	ram256x39 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_word_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==8) && (ILM_RAM_DW==64)) begin : gen_ram256x64
	ram256x64 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==8) && (ILM_RAM_DW==72)) begin : gen_ram256x72
	ram256x72 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	({9{ilm_word_we}}),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==9) && (ILM_RAM_DW==32)) begin : gen_ram512x32
	ram512x32 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==9) && (ILM_RAM_DW==39)) begin : gen_ram512x39
	ram512x39 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_word_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==9) && (ILM_RAM_DW==64)) begin : gen_ram512x64
	ram512x64 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==9) && (ILM_RAM_DW==72)) begin : gen_ram512x72
	ram512x72 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	({9{ilm_word_we}}),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==10) && (ILM_RAM_DW==32)) begin : gen_ram1024x32
	ram1024x32 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==10) && (ILM_RAM_DW==39)) begin : gen_ram1024x39
	ram1024x39 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_word_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==10) && (ILM_RAM_DW==64)) begin : gen_ram1024x64
	ram1024x64 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==10) && (ILM_RAM_DW==72)) begin : gen_ram1024x72
	ram1024x72 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	({9{ilm_word_we}}),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==11) && (ILM_RAM_DW==32)) begin : gen_ram2048x32
	ram2048x32 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==11) && (ILM_RAM_DW==39)) begin : gen_ram2048x39
	ram2048x39 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_word_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==11) && (ILM_RAM_DW==64)) begin : gen_ram2048x64
	ram2048x64 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==11) && (ILM_RAM_DW==72)) begin : gen_ram2048x72
	ram2048x72 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	({9{ilm_word_we}}),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==12) && (ILM_RAM_DW==32)) begin : gen_ram4096x32
	ram4096x32 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==12) && (ILM_RAM_DW==39)) begin : gen_ram4096x39
	ram4096x39 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_word_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==12) && (ILM_RAM_DW==64)) begin : gen_ram4096x64
	ram4096x64 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==12) && (ILM_RAM_DW==72)) begin : gen_ram4096x72
	ram4096x72 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	({9{ilm_word_we}}),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==13) && (ILM_RAM_DW==32)) begin : gen_ram8192x32
	ram8192x32 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==13) && (ILM_RAM_DW==39)) begin : gen_ram8192x39
	ram8192x39 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_word_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==13) && (ILM_RAM_DW==64)) begin : gen_ram8192x64
	ram8192x64 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==13) && (ILM_RAM_DW==72)) begin : gen_ram8192x72
	ram8192x72 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	({9{ilm_word_we}}),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==14) && (ILM_RAM_DW==32)) begin : gen_ram16384x32
	ram16384x32 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==14) && (ILM_RAM_DW==39)) begin : gen_ram16384x39
	ram16384x39 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_word_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==14) && (ILM_RAM_DW==64)) begin : gen_ram16384x64
	ram16384x64 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==14) && (ILM_RAM_DW==72)) begin : gen_ram16384x72
	ram16384x72 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	({9{ilm_word_we}}),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==15) && (ILM_RAM_DW==32)) begin : gen_ram32768x32
	ram32768x32 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==15) && (ILM_RAM_DW==39)) begin : gen_ram32768x39
	ram32768x39 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_word_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==15) && (ILM_RAM_DW==64)) begin : gen_ram32768x64
	ram32768x64 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==15) && (ILM_RAM_DW==72)) begin : gen_ram32768x72
	ram32768x72 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	({9{ilm_word_we}}),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==16) && (ILM_RAM_DW==32)) begin : gen_ram65536x32
	ram65536x32 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==16) && (ILM_RAM_DW==39)) begin : gen_ram65536x39
	ram65536x39 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_word_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==16) && (ILM_RAM_DW==64)) begin : gen_ram65536x64
	ram65536x64 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==16) && (ILM_RAM_DW==72)) begin : gen_ram65536x72
	ram65536x72 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	({9{ilm_word_we}}),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==17) && (ILM_RAM_DW==32)) begin : gen_ram131072x32
	ram131072x32 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==17) && (ILM_RAM_DW==39)) begin : gen_ram131072x39
	ram131072x39 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_word_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==17) && (ILM_RAM_DW==64)) begin : gen_ram131072x64
	ram131072x64 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

generate
if ((ILM_RAM_AW==17) && (ILM_RAM_DW==72)) begin : gen_ram131072x72
	ram131072x72 ram_inst (
		.clka	(core_clk),
		.ena	(ilm_cs),
		.wea	({9{ilm_word_we}}),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate


endmodule


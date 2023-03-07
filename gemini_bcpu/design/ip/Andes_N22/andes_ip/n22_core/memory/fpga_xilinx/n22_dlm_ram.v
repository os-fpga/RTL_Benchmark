// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module n22_dlm_ram (
		  core_clk,
		  dlm_cs,
		  dlm_addr,
		  dlm_byte_we,
		  dlm_wdata,
		  dlm_rdata
);
parameter DLM_RAM_AW = 11;
parameter DLM_RAM_DW = 64;
parameter DLM_RAM_BWEW = 8;
parameter DLM_ECC_TYPE = "none";

localparam DLM_DW           = DLM_RAM_BWEW*8;
localparam DLM_DATA_MSB     = DLM_DW-1;
localparam DLM_DATA_LSB     = 0;
localparam DLM_ECCW    	    = (DLM_DW == 64) ? 8 : (DLM_ECC_TYPE == "ecc" ? 7 : 4);
localparam DLM_ECC_CODE_LSB = DLM_DATA_MSB+1;
localparam DLM_ECC_CODE_MSB = DLM_ECC_CODE_LSB+DLM_ECCW-1;

input                   core_clk;
input                   dlm_cs;
input      [DLM_RAM_AW-1:0] dlm_addr;
input    [DLM_RAM_BWEW-1:0] dlm_byte_we;
input      [DLM_RAM_DW-1:0] dlm_wdata;
output     [DLM_RAM_DW-1:0] dlm_rdata;

wire                        dlm_word_we = |dlm_byte_we;



generate
if ((DLM_RAM_AW==7) && (DLM_RAM_DW==32)) begin : gen_ram128x32
	ram128x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==7) && (DLM_RAM_DW==39)) begin : gen_ram128x39
	ram128x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==7) && (DLM_RAM_DW==64)) begin : gen_ram128x64
	ram128x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==7) && (DLM_RAM_DW==72)) begin : gen_ram128x72
	ram128x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==8) && (DLM_RAM_DW==32)) begin : gen_ram256x32
	ram256x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==8) && (DLM_RAM_DW==39)) begin : gen_ram256x39
	ram256x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==8) && (DLM_RAM_DW==64)) begin : gen_ram256x64
	ram256x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==8) && (DLM_RAM_DW==72)) begin : gen_ram256x72
	ram256x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==9) && (DLM_RAM_DW==32)) begin : gen_ram512x32
	ram512x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==9) && (DLM_RAM_DW==39)) begin : gen_ram512x39
	ram512x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==9) && (DLM_RAM_DW==64)) begin : gen_ram512x64
	ram512x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==9) && (DLM_RAM_DW==72)) begin : gen_ram512x72
	ram512x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==10) && (DLM_RAM_DW==32)) begin : gen_ram1024x32
	ram1024x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==10) && (DLM_RAM_DW==39)) begin : gen_ram1024x39
	ram1024x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==10) && (DLM_RAM_DW==64)) begin : gen_ram1024x64
	ram1024x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==10) && (DLM_RAM_DW==72)) begin : gen_ram1024x72
	ram1024x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==11) && (DLM_RAM_DW==32)) begin : gen_ram2048x32
	ram2048x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==11) && (DLM_RAM_DW==39)) begin : gen_ram2048x39
	ram2048x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==11) && (DLM_RAM_DW==64)) begin : gen_ram2048x64
	ram2048x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==11) && (DLM_RAM_DW==72)) begin : gen_ram2048x72
	ram2048x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==12) && (DLM_RAM_DW==32)) begin : gen_ram4096x32
	ram4096x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==12) && (DLM_RAM_DW==39)) begin : gen_ram4096x39
	ram4096x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==12) && (DLM_RAM_DW==64)) begin : gen_ram4096x64
	ram4096x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==12) && (DLM_RAM_DW==72)) begin : gen_ram4096x72
	ram4096x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==13) && (DLM_RAM_DW==32)) begin : gen_ram8192x32
	ram8192x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==13) && (DLM_RAM_DW==39)) begin : gen_ram8192x39
	ram8192x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==13) && (DLM_RAM_DW==64)) begin : gen_ram8192x64
	ram8192x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==13) && (DLM_RAM_DW==72)) begin : gen_ram8192x72
	ram8192x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==14) && (DLM_RAM_DW==32)) begin : gen_ram16384x32
	ram16384x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==14) && (DLM_RAM_DW==39)) begin : gen_ram16384x39
	ram16384x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==14) && (DLM_RAM_DW==64)) begin : gen_ram16384x64
	ram16384x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==14) && (DLM_RAM_DW==72)) begin : gen_ram16384x72
	ram16384x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==15) && (DLM_RAM_DW==32)) begin : gen_ram32768x32
	ram32768x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==15) && (DLM_RAM_DW==39)) begin : gen_ram32768x39
	ram32768x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==15) && (DLM_RAM_DW==64)) begin : gen_ram32768x64
	ram32768x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==15) && (DLM_RAM_DW==72)) begin : gen_ram32768x72
	ram32768x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==16) && (DLM_RAM_DW==32)) begin : gen_ram65536x32
	ram65536x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==16) && (DLM_RAM_DW==39)) begin : gen_ram65536x39
	ram65536x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==16) && (DLM_RAM_DW==64)) begin : gen_ram65536x64
	ram65536x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==16) && (DLM_RAM_DW==72)) begin : gen_ram65536x72
	ram65536x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==17) && (DLM_RAM_DW==32)) begin : gen_ram131072x32
	ram131072x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==17) && (DLM_RAM_DW==39)) begin : gen_ram131072x39
	ram131072x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==17) && (DLM_RAM_DW==64)) begin : gen_ram131072x64
	ram131072x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==17) && (DLM_RAM_DW==72)) begin : gen_ram131072x72
	ram131072x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==18) && (DLM_RAM_DW==32)) begin : gen_ram262144x32
	ram262144x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==18) && (DLM_RAM_DW==39)) begin : gen_ram262144x39
	ram262144x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==18) && (DLM_RAM_DW==64)) begin : gen_ram262144x64
	ram262144x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==18) && (DLM_RAM_DW==72)) begin : gen_ram262144x72
	ram262144x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==19) && (DLM_RAM_DW==32)) begin : gen_ram524288x32
	ram524288x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==19) && (DLM_RAM_DW==39)) begin : gen_ram524288x39
	ram524288x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==19) && (DLM_RAM_DW==64)) begin : gen_ram524288x64
	ram524288x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==19) && (DLM_RAM_DW==72)) begin : gen_ram524288x72
	ram524288x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==20) && (DLM_RAM_DW==32)) begin : gen_ram1048576x32
	ram1048576x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==20) && (DLM_RAM_DW==39)) begin : gen_ram1048576x39
	ram1048576x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==20) && (DLM_RAM_DW==64)) begin : gen_ram1048576x64
	ram1048576x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==20) && (DLM_RAM_DW==72)) begin : gen_ram1048576x72
	ram1048576x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==21) && (DLM_RAM_DW==32)) begin : gen_ram2097152x32
	ram2097152x32 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==21) && (DLM_RAM_DW==39)) begin : gen_ram2097152x39
	ram2097152x39 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==21) && (DLM_RAM_DW==64)) begin : gen_ram2097152x64
	ram2097152x64 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==21) && (DLM_RAM_DW==72)) begin : gen_ram2097152x72
	ram2097152x72 ram_inst (
		.clka	(core_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate


endmodule


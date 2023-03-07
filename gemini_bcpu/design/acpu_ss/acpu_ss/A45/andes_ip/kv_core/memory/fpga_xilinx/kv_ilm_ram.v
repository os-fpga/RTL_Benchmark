// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_ilm_ram (
		  clk,
		  ilm_cs,
		  ilm_we,
		  ilm_addr,
		  ilm_byte_we,
		  ilm_wdata,
		  ilm_rdata,
		  ilm_ctrl_in,
		  ilm_ctrl_out
);
parameter ILM_RAM_AW = 11;
parameter ILM_RAM_DW = 64;
parameter ILM_RAM_BWEW = 8;
parameter ILM_RAM_CTRL_IN_WIDTH = 1;
parameter ILM_RAM_CTRL_OUT_WIDTH = 1;

input                   clk;
input                   ilm_cs;
input                   ilm_we;
input      [ILM_RAM_AW-1:0] ilm_addr;
input    [ILM_RAM_BWEW-1:0] ilm_byte_we;
input      [ILM_RAM_DW-1:0] ilm_wdata;
output     [ILM_RAM_DW-1:0] ilm_rdata;
input       [(ILM_RAM_CTRL_IN_WIDTH-1):0] ilm_ctrl_in;
output     [(ILM_RAM_CTRL_OUT_WIDTH-1):0] ilm_ctrl_out;

wire                        ilm_word_we = ilm_we;


localparam INVALID_RAM = ~(((ILM_RAM_AW==9) && (ILM_RAM_DW==32)) ||
                           ((ILM_RAM_AW==9) && (ILM_RAM_DW==39)) ||
                           ((ILM_RAM_AW==9) && (ILM_RAM_DW==64)) ||
                           ((ILM_RAM_AW==9) && (ILM_RAM_DW==72)) ||
                           ((ILM_RAM_AW==10) && (ILM_RAM_DW==32)) ||
                           ((ILM_RAM_AW==10) && (ILM_RAM_DW==39)) ||
                           ((ILM_RAM_AW==10) && (ILM_RAM_DW==64)) ||
                           ((ILM_RAM_AW==10) && (ILM_RAM_DW==72)) ||
                           ((ILM_RAM_AW==11) && (ILM_RAM_DW==32)) ||
                           ((ILM_RAM_AW==11) && (ILM_RAM_DW==39)) ||
                           ((ILM_RAM_AW==11) && (ILM_RAM_DW==64)) ||
                           ((ILM_RAM_AW==11) && (ILM_RAM_DW==72)) ||
                           ((ILM_RAM_AW==12) && (ILM_RAM_DW==32)) ||
                           ((ILM_RAM_AW==12) && (ILM_RAM_DW==39)) ||
                           ((ILM_RAM_AW==12) && (ILM_RAM_DW==64)) ||
                           ((ILM_RAM_AW==12) && (ILM_RAM_DW==72)) ||
                           ((ILM_RAM_AW==13) && (ILM_RAM_DW==32)) ||
                           ((ILM_RAM_AW==13) && (ILM_RAM_DW==39)) ||
                           ((ILM_RAM_AW==13) && (ILM_RAM_DW==64)) ||
                           ((ILM_RAM_AW==13) && (ILM_RAM_DW==72)) ||
                           ((ILM_RAM_AW==14) && (ILM_RAM_DW==32)) ||
                           ((ILM_RAM_AW==14) && (ILM_RAM_DW==39)) ||
                           ((ILM_RAM_AW==14) && (ILM_RAM_DW==64)) ||
                           ((ILM_RAM_AW==14) && (ILM_RAM_DW==72)) ||
                           ((ILM_RAM_AW==15) && (ILM_RAM_DW==32)) ||
                           ((ILM_RAM_AW==15) && (ILM_RAM_DW==39)) ||
                           ((ILM_RAM_AW==15) && (ILM_RAM_DW==64)) ||
                           ((ILM_RAM_AW==15) && (ILM_RAM_DW==72)) ||
                           ((ILM_RAM_AW==16) && (ILM_RAM_DW==32)) ||
                           ((ILM_RAM_AW==16) && (ILM_RAM_DW==39)) ||
                           ((ILM_RAM_AW==16) && (ILM_RAM_DW==64)) ||
                           ((ILM_RAM_AW==16) && (ILM_RAM_DW==72)) ||
                           ((ILM_RAM_AW==17) && (ILM_RAM_DW==32)) ||
                           ((ILM_RAM_AW==17) && (ILM_RAM_DW==39)) ||
                           ((ILM_RAM_AW==17) && (ILM_RAM_DW==64)) ||
                           ((ILM_RAM_AW==17) && (ILM_RAM_DW==72))) ;


generate
if ((ILM_RAM_AW==9) && (ILM_RAM_DW==32)) begin : gen_ram512x32
	ram512x32 ram_inst (
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
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
		.clka	(clk),
		.ena	(ilm_cs),
		.wea	({9{ilm_word_we}}),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate


generate
if (INVALID_RAM) begin : gen_error
	blackbox_error_for_unsupported_ILM_size blackbox_error_for_unsupported_ILM_size (
		.clka	(clk),
		.ena	(ilm_cs),
		.wea	(ilm_byte_we),
		.addra	(ilm_addr),
		.dina	(ilm_wdata),
		.douta	(ilm_rdata)
	);
end
endgenerate

wire nds_unused_ilm_ctrl_in = |ilm_ctrl_in;
assign ilm_ctrl_out = {ILM_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule


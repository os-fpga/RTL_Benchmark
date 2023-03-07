// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcache_data_ram(
		  clk,
		  dcache_data_rdata,
		  dcache_data_wdata,
		  dcache_data_cs,
		  dcache_data_we,
		  dcache_data_byte_we,
		  dcache_data_addr,
		  dcache_data_ctrl_in,
		  dcache_data_ctrl_out
);
parameter DCACHE_DATA_RAM_DW  = 19;
parameter DCACHE_DATA_RAM_AW  = 9;
parameter DCACHE_DATA_RAM_BWEW = 8;
parameter DCACHE_DATA_RAM_CTRL_IN_WIDTH = 1;
parameter DCACHE_DATA_RAM_CTRL_OUT_WIDTH = 1;


input					clk;
output 	[DCACHE_DATA_RAM_DW-1:0]	dcache_data_rdata;
input  	[DCACHE_DATA_RAM_DW-1:0]  	dcache_data_wdata;
input                  			dcache_data_cs;
input                  			dcache_data_we;
input	[DCACHE_DATA_RAM_BWEW-1:0]	dcache_data_byte_we;
input	[DCACHE_DATA_RAM_AW-1:0] 	dcache_data_addr;
input   [(DCACHE_DATA_RAM_CTRL_IN_WIDTH-1):0] dcache_data_ctrl_in;
output [(DCACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] dcache_data_ctrl_out;

wire dcache_data_word_we = dcache_data_we;


generate
if ((DCACHE_DATA_RAM_AW==8) && (DCACHE_DATA_RAM_DW==32)) begin : gen_data_256x32
	ram256x32 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==8) && (DCACHE_DATA_RAM_DW==36)) begin : gen_data_256x36
	ram256x36 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_word_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==8) && (DCACHE_DATA_RAM_DW==39)) begin : gen_data_256x39
	ram256x39 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_word_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==8) && (DCACHE_DATA_RAM_DW==64)) begin : gen_data_256x64
	ram256x64 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==8) && (DCACHE_DATA_RAM_DW==72)) begin : gen_data_256x72
	ram256x72 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==9) && (DCACHE_DATA_RAM_DW==32)) begin : gen_data_512x32
	ram512x32 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==9) && (DCACHE_DATA_RAM_DW==36)) begin : gen_data_512x36
	ram512x36 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_word_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==9) && (DCACHE_DATA_RAM_DW==39)) begin : gen_data_512x39
	ram512x39 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_word_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==9) && (DCACHE_DATA_RAM_DW==64)) begin : gen_data_512x64
	ram512x64 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==9) && (DCACHE_DATA_RAM_DW==72)) begin : gen_data_512x72
	ram512x72 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==10) && (DCACHE_DATA_RAM_DW==32)) begin : gen_data_1024x32
	ram1024x32 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==10) && (DCACHE_DATA_RAM_DW==36)) begin : gen_data_1024x36
	ram1024x36 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_word_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==10) && (DCACHE_DATA_RAM_DW==39)) begin : gen_data_1024x39
	ram1024x39 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_word_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==10) && (DCACHE_DATA_RAM_DW==64)) begin : gen_data_1024x64
	ram1024x64 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==10) && (DCACHE_DATA_RAM_DW==72)) begin : gen_data_1024x72
	ram1024x72 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==11) && (DCACHE_DATA_RAM_DW==32)) begin : gen_data_2048x32
	ram2048x32 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==11) && (DCACHE_DATA_RAM_DW==36)) begin : gen_data_2048x36
	ram2048x36 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_word_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==11) && (DCACHE_DATA_RAM_DW==39)) begin : gen_data_2048x39
	ram2048x39 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_word_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==11) && (DCACHE_DATA_RAM_DW==64)) begin : gen_data_2048x64
	ram2048x64 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==11) && (DCACHE_DATA_RAM_DW==72)) begin : gen_data_2048x72
	ram2048x72 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==12) && (DCACHE_DATA_RAM_DW==32)) begin : gen_data_4096x32
	ram4096x32 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==12) && (DCACHE_DATA_RAM_DW==36)) begin : gen_data_4096x36
	ram4096x36 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_word_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==12) && (DCACHE_DATA_RAM_DW==39)) begin : gen_data_4096x39
	ram4096x39 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_word_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==12) && (DCACHE_DATA_RAM_DW==64)) begin : gen_data_4096x64
	ram4096x64 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==12) && (DCACHE_DATA_RAM_DW==72)) begin : gen_data_4096x72
	ram4096x72 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==13) && (DCACHE_DATA_RAM_DW==32)) begin : gen_data_8192x32
	ram8192x32 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==13) && (DCACHE_DATA_RAM_DW==36)) begin : gen_data_8192x36
	ram8192x36 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_word_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==13) && (DCACHE_DATA_RAM_DW==39)) begin : gen_data_8192x39
	ram8192x39 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_word_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==13) && (DCACHE_DATA_RAM_DW==64)) begin : gen_data_8192x64
	ram8192x64 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==13) && (DCACHE_DATA_RAM_DW==72)) begin : gen_data_8192x72
	ram8192x72 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==14) && (DCACHE_DATA_RAM_DW==32)) begin : gen_data_16384x32
	ram16384x32 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==14) && (DCACHE_DATA_RAM_DW==36)) begin : gen_data_16384x36
	ram16384x36 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_word_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==14) && (DCACHE_DATA_RAM_DW==39)) begin : gen_data_16384x39
	ram16384x39 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_word_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==14) && (DCACHE_DATA_RAM_DW==64)) begin : gen_data_16384x64
	ram16384x64 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

generate
if ((DCACHE_DATA_RAM_AW==14) && (DCACHE_DATA_RAM_DW==72)) begin : gen_data_16384x72
	ram16384x72 ram_inst (
		.clka    (clk            ),
		.ena     (dcache_data_cs   ),
		.wea     (dcache_data_byte_we),
		.addra   (dcache_data_addr ),
		.dina    (dcache_data_wdata),
		.douta   (dcache_data_rdata)
	);
end
endgenerate

wire	nds_unused_dcache_data_we = |{dcache_data_we, dcache_data_ctrl_in};
assign dcache_data_ctrl_out = {DCACHE_DATA_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule


// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dlm_ram (
		  clk,
		  dlm_cs,
		  dlm_we,
		  dlm_addr,
		  dlm_byte_we,
		  dlm_wdata,
		  dlm_rdata,
		  dlm_ctrl_in,
		  dlm_ctrl_out
);
parameter DLM_RAM_AW = 11;
parameter DLM_RAM_DW = 64;
parameter DLM_RAM_BWEW = 8;
parameter DLM_RAM_CTRL_IN_WIDTH = 1;
parameter DLM_RAM_CTRL_OUT_WIDTH = 1;

input                   clk;
input                   dlm_cs;
input                   dlm_we;
input      [DLM_RAM_AW-1:0] dlm_addr;
input    [DLM_RAM_BWEW-1:0] dlm_byte_we;
input      [DLM_RAM_DW-1:0] dlm_wdata;
output     [DLM_RAM_DW-1:0] dlm_rdata;
input       [(DLM_RAM_CTRL_IN_WIDTH-1):0] dlm_ctrl_in;
output     [(DLM_RAM_CTRL_OUT_WIDTH-1):0] dlm_ctrl_out;

wire                        dlm_word_we = dlm_we;


localparam INVALID_RAM = ~(((DLM_RAM_AW==9) && (DLM_RAM_DW==32)) ||
                           ((DLM_RAM_AW==9) && (DLM_RAM_DW==39)) ||
                           ((DLM_RAM_AW==9) && (DLM_RAM_DW==64)) ||
                           ((DLM_RAM_AW==9) && (DLM_RAM_DW==72)) ||
                           ((DLM_RAM_AW==10) && (DLM_RAM_DW==32)) ||
                           ((DLM_RAM_AW==10) && (DLM_RAM_DW==39)) ||
                           ((DLM_RAM_AW==10) && (DLM_RAM_DW==64)) ||
                           ((DLM_RAM_AW==10) && (DLM_RAM_DW==72)) ||
                           ((DLM_RAM_AW==11) && (DLM_RAM_DW==32)) ||
                           ((DLM_RAM_AW==11) && (DLM_RAM_DW==39)) ||
                           ((DLM_RAM_AW==11) && (DLM_RAM_DW==64)) ||
                           ((DLM_RAM_AW==11) && (DLM_RAM_DW==72)) ||
                           ((DLM_RAM_AW==12) && (DLM_RAM_DW==32)) ||
                           ((DLM_RAM_AW==12) && (DLM_RAM_DW==39)) ||
                           ((DLM_RAM_AW==12) && (DLM_RAM_DW==64)) ||
                           ((DLM_RAM_AW==12) && (DLM_RAM_DW==72)) ||
                           ((DLM_RAM_AW==13) && (DLM_RAM_DW==32)) ||
                           ((DLM_RAM_AW==13) && (DLM_RAM_DW==39)) ||
                           ((DLM_RAM_AW==13) && (DLM_RAM_DW==64)) ||
                           ((DLM_RAM_AW==13) && (DLM_RAM_DW==72)) ||
                           ((DLM_RAM_AW==14) && (DLM_RAM_DW==32)) ||
                           ((DLM_RAM_AW==14) && (DLM_RAM_DW==39)) ||
                           ((DLM_RAM_AW==14) && (DLM_RAM_DW==64)) ||
                           ((DLM_RAM_AW==14) && (DLM_RAM_DW==72)) ||
                           ((DLM_RAM_AW==15) && (DLM_RAM_DW==32)) ||
                           ((DLM_RAM_AW==15) && (DLM_RAM_DW==39)) ||
                           ((DLM_RAM_AW==15) && (DLM_RAM_DW==64)) ||
                           ((DLM_RAM_AW==15) && (DLM_RAM_DW==72)) ||
                           ((DLM_RAM_AW==16) && (DLM_RAM_DW==32)) ||
                           ((DLM_RAM_AW==16) && (DLM_RAM_DW==39)) ||
                           ((DLM_RAM_AW==16) && (DLM_RAM_DW==64)) ||
                           ((DLM_RAM_AW==16) && (DLM_RAM_DW==72)) ||
                           ((DLM_RAM_AW==17) && (DLM_RAM_DW==32)) ||
                           ((DLM_RAM_AW==17) && (DLM_RAM_DW==39)) ||
                           ((DLM_RAM_AW==17) && (DLM_RAM_DW==64)) ||
                           ((DLM_RAM_AW==17) && (DLM_RAM_DW==72)) ||
                           ((DLM_RAM_AW==18) && (DLM_RAM_DW==32)) ||
                           ((DLM_RAM_AW==18) && (DLM_RAM_DW==39)) ||
                           ((DLM_RAM_AW==18) && (DLM_RAM_DW==64)) ||
                           ((DLM_RAM_AW==18) && (DLM_RAM_DW==72)) ||
                           ((DLM_RAM_AW==19) && (DLM_RAM_DW==32)) ||
                           ((DLM_RAM_AW==19) && (DLM_RAM_DW==39)) ||
                           ((DLM_RAM_AW==19) && (DLM_RAM_DW==64)) ||
                           ((DLM_RAM_AW==19) && (DLM_RAM_DW==72)) ||
                           ((DLM_RAM_AW==20) && (DLM_RAM_DW==32)) ||
                           ((DLM_RAM_AW==20) && (DLM_RAM_DW==39)) ||
                           ((DLM_RAM_AW==20) && (DLM_RAM_DW==64)) ||
                           ((DLM_RAM_AW==20) && (DLM_RAM_DW==72)) ||
                           ((DLM_RAM_AW==21) && (DLM_RAM_DW==32)) ||
                           ((DLM_RAM_AW==21) && (DLM_RAM_DW==39)) ||
                           ((DLM_RAM_AW==21) && (DLM_RAM_DW==64)) ||
                           ((DLM_RAM_AW==21) && (DLM_RAM_DW==72))) ;


generate
if ((DLM_RAM_AW==9) && (DLM_RAM_DW==32)) begin : gen_ram512x32
	ram512x32 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate
generate
if ((DLM_RAM_AW==9) && (DLM_RAM_DW==64)) begin : gen_ram512x64
	ram512x64 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==10) && (DLM_RAM_DW==32)) begin : gen_ram1024x32
	ram1024x32 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate
generate
if ((DLM_RAM_AW==10) && (DLM_RAM_DW==64)) begin : gen_ram1024x64
	ram1024x64 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==11) && (DLM_RAM_DW==32)) begin : gen_ram2048x32
	ram2048x32 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate
generate
if ((DLM_RAM_AW==11) && (DLM_RAM_DW==64)) begin : gen_ram2048x64
	ram2048x64 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==12) && (DLM_RAM_DW==32)) begin : gen_ram4096x32
	ram4096x32 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate
generate
if ((DLM_RAM_AW==12) && (DLM_RAM_DW==64)) begin : gen_ram4096x64
	ram4096x64 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==13) && (DLM_RAM_DW==32)) begin : gen_ram8192x32
	ram8192x32 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate
generate
if ((DLM_RAM_AW==13) && (DLM_RAM_DW==64)) begin : gen_ram8192x64
	ram8192x64 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==14) && (DLM_RAM_DW==32)) begin : gen_ram16384x32
	ram16384x32 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate
generate
if ((DLM_RAM_AW==14) && (DLM_RAM_DW==64)) begin : gen_ram16384x64
	ram16384x64 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==15) && (DLM_RAM_DW==32)) begin : gen_ram32768x32
	ram32768x32 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate
generate
if ((DLM_RAM_AW==15) && (DLM_RAM_DW==64)) begin : gen_ram32768x64
	ram32768x64 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==16) && (DLM_RAM_DW==32)) begin : gen_ram65536x32
	ram65536x32 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate
generate
if ((DLM_RAM_AW==16) && (DLM_RAM_DW==64)) begin : gen_ram65536x64
	ram65536x64 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==17) && (DLM_RAM_DW==32)) begin : gen_ram131072x32
	ram131072x32 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate
generate
if ((DLM_RAM_AW==17) && (DLM_RAM_DW==64)) begin : gen_ram131072x64
	ram131072x64 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==18) && (DLM_RAM_DW==32)) begin : gen_ram262144x32
	ram262144x32 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate
generate
if ((DLM_RAM_AW==18) && (DLM_RAM_DW==64)) begin : gen_ram262144x64
	ram262144x64 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==19) && (DLM_RAM_DW==32)) begin : gen_ram524288x32
	ram524288x32 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate
generate
if ((DLM_RAM_AW==19) && (DLM_RAM_DW==64)) begin : gen_ram524288x64
	ram524288x64 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==20) && (DLM_RAM_DW==32)) begin : gen_ram1048576x32
	ram1048576x32 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate
generate
if ((DLM_RAM_AW==20) && (DLM_RAM_DW==64)) begin : gen_ram1048576x64
	ram1048576x64 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==21) && (DLM_RAM_DW==32)) begin : gen_ram2097152x32
	ram2097152x32 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate
generate
if ((DLM_RAM_AW==21) && (DLM_RAM_DW==64)) begin : gen_ram2097152x64
	ram2097152x64 ram_inst (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate



generate
if (INVALID_RAM) begin : gen_error
	blackbox_error_for_unsupported_DLM_size blackbox_error_for_unsupported_DLM_size (
		.clka	(clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

wire nds_unused_dlm_ctrl_in = |dlm_ctrl_in;
assign dlm_ctrl_out = {DLM_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule


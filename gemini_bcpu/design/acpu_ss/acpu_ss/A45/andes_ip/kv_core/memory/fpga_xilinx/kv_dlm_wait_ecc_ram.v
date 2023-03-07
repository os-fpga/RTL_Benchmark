// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dlm_wait_ecc_ram (
		  lm_clk,
		  lm_reset_n,
		  dlm_a_addr,
		  dlm_a_data,
		  dlm_a_mask,
		  dlm_a_opcode,
		  dlm_a_size,
		  dlm_a_user,
		  dlm_a_valid,
		  dlm_a_parity,
		  dlm_a_ready,
		  dlm_d_data,
		  dlm_d_denied,
		  dlm_d_ready,
		  dlm_d_parity,
		  dlm_d_valid
);
parameter DLM_RAM_AMSB = 11;
parameter DLM_RAM_DW   = 64;
parameter DLM_RAM_BWEW = 8;
parameter XLEN         = 64;

localparam DLM_RAM_ALSB = (XLEN == 64) ? 3 :
                          (XLEN == 32) ? 2 :
			                 1;
localparam DLM_RAM_AW = DLM_RAM_AMSB - DLM_RAM_ALSB + 1;

input                                      lm_clk;
input                                      lm_reset_n;

input          [DLM_RAM_AMSB:DLM_RAM_ALSB] dlm_a_addr;
input                           [XLEN-1:0] dlm_a_data;
input                   [DLM_RAM_BWEW-1:0] dlm_a_mask;
input                                [2:0] dlm_a_opcode;
input                                [2:0] dlm_a_size;
input                                [1:0] dlm_a_user;
input                                      dlm_a_valid;
input                                [7:0] dlm_a_parity;
output                                     dlm_a_ready;

output                          [XLEN-1:0] dlm_d_data;
output                                     dlm_d_denied;
input                                      dlm_d_ready;
output                               [7:0] dlm_d_parity;
output                                     dlm_d_valid;

wire                   dlm_cs		= dlm_a_valid;
wire                   dlm_word_we	= dlm_a_opcode == 3'd1;
wire      [DLM_RAM_AW-1:0] dlm_addr	= dlm_a_addr;
wire      [DLM_RAM_DW-1:0] dlm_wdata	= {dlm_a_parity, dlm_a_data};
wire     [DLM_RAM_DW-1:0] dlm_rdata;

reg                           dlm_cs_d1;

always @(posedge lm_clk or negedge lm_reset_n) begin
	if (!lm_reset_n)
		dlm_cs_d1 <= 1'b0;
	else
		dlm_cs_d1 <= dlm_cs;
end

assign dlm_d_valid = dlm_cs_d1;

assign dlm_a_ready = 1'b1;

assign dlm_d_denied = 1'b0;
assign {dlm_d_parity, dlm_d_data}  = dlm_rdata;


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
if ((DLM_RAM_AW==9) && (DLM_RAM_DW==39)) begin : gen_ram512x39
	ram512x39 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==9) && (DLM_RAM_DW==72)) begin : gen_ram512x72
	ram512x72 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==10) && (DLM_RAM_DW==39)) begin : gen_ram1024x39
	ram1024x39 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==10) && (DLM_RAM_DW==72)) begin : gen_ram1024x72
	ram1024x72 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==11) && (DLM_RAM_DW==39)) begin : gen_ram2048x39
	ram2048x39 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==11) && (DLM_RAM_DW==72)) begin : gen_ram2048x72
	ram2048x72 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==12) && (DLM_RAM_DW==39)) begin : gen_ram4096x39
	ram4096x39 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==12) && (DLM_RAM_DW==72)) begin : gen_ram4096x72
	ram4096x72 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==13) && (DLM_RAM_DW==39)) begin : gen_ram8192x39
	ram8192x39 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==13) && (DLM_RAM_DW==72)) begin : gen_ram8192x72
	ram8192x72 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==14) && (DLM_RAM_DW==39)) begin : gen_ram16384x39
	ram16384x39 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==14) && (DLM_RAM_DW==72)) begin : gen_ram16384x72
	ram16384x72 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==15) && (DLM_RAM_DW==39)) begin : gen_ram32768x39
	ram32768x39 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==15) && (DLM_RAM_DW==72)) begin : gen_ram32768x72
	ram32768x72 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==16) && (DLM_RAM_DW==39)) begin : gen_ram65536x39
	ram65536x39 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==16) && (DLM_RAM_DW==72)) begin : gen_ram65536x72
	ram65536x72 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==17) && (DLM_RAM_DW==39)) begin : gen_ram131072x39
	ram131072x39 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==17) && (DLM_RAM_DW==72)) begin : gen_ram131072x72
	ram131072x72 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==18) && (DLM_RAM_DW==39)) begin : gen_ram262144x39
	ram262144x39 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==18) && (DLM_RAM_DW==72)) begin : gen_ram262144x72
	ram262144x72 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==19) && (DLM_RAM_DW==39)) begin : gen_ram524288x39
	ram524288x39 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==19) && (DLM_RAM_DW==72)) begin : gen_ram524288x72
	ram524288x72 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==20) && (DLM_RAM_DW==39)) begin : gen_ram1048576x39
	ram1048576x39 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==20) && (DLM_RAM_DW==72)) begin : gen_ram1048576x72
	ram1048576x72 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==21) && (DLM_RAM_DW==39)) begin : gen_ram2097152x39
	ram2097152x39 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	(dlm_word_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if ((DLM_RAM_AW==21) && (DLM_RAM_DW==72)) begin : gen_ram2097152x72
	ram2097152x72 ram_inst (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	({9{dlm_word_we}}),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

generate
if (INVALID_RAM) begin : gen_error
	blackbox_error_for_unsupported_DLM_size blackbox_error_for_unsupported_DLM_size (
		.clka	(lm_clk),
		.ena	(dlm_cs),
		.wea	(dlm_byte_we),
		.addra	(dlm_addr),
		.dina	(dlm_wdata),
		.douta	(dlm_rdata)
	);
end
endgenerate

endmodule


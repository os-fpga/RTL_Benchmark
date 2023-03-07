// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_stlb_tag_ecc_ram (
		  clk,
		  stlb_cs,
		  stlb_we,
		  stlb_addr,
		  stlb_wdata,
		  stlb_rdata,
		  stlb_ctrl_in,
		  stlb_ctrl_out
);

parameter STLB_TAG_RAM_AW  = 3;
parameter STLB_TAG_RAM_DW  = 73;
parameter STLB_TAG_RAM_CTRL_IN_WIDTH = 1;
parameter STLB_TAG_RAM_CTRL_OUT_WIDTH = 1;


input                     clk;
input            	  stlb_cs;
input			  stlb_we;
input	[STLB_TAG_RAM_AW-1:0] stlb_addr;
input  	[STLB_TAG_RAM_DW-1:0] stlb_wdata;
output 	[STLB_TAG_RAM_DW-1:0] stlb_rdata;
input   [(STLB_TAG_RAM_CTRL_IN_WIDTH-1):0] stlb_ctrl_in;
output [(STLB_TAG_RAM_CTRL_OUT_WIDTH-1):0] stlb_ctrl_out;


wire  [6:0] ram_addr  = {{( 7-STLB_TAG_RAM_AW){1'b0}}, stlb_addr};
wire [71:0] ram_wdata = {{(72-STLB_TAG_RAM_DW){1'b0}}, stlb_wdata};
wire [71:0] ram_rdata;


generate
if ((STLB_TAG_RAM_AW == 3) && (STLB_TAG_RAM_DW <= 39) && (STLB_TAG_RAM_DW > 0)) begin : gen_ram_aw_8_dw_39
	ram8x39 ram_inst (
			.clka	(clk),
			.ena	(stlb_cs),
			.wea	({9{stlb_we}}),
			.addra	(ram_addr[2:0]),
			.dina	(ram_wdata[38:0]),
			.douta	(ram_rdata[38:0])
	);
	assign ram_rdata[71:39] = {33{1'b0}};
end
if ((STLB_TAG_RAM_AW == 3) && (STLB_TAG_RAM_DW <= 72) && (STLB_TAG_RAM_DW > 39)) begin : gen_ram_aw_8_dw_72
	ram8x72 ram_inst (
			.clka	(clk),
			.ena	(stlb_cs),
			.wea	({9{stlb_we}}),
			.addra	(ram_addr[2:0]),
			.dina	(ram_wdata[71:0]),
			.douta	(ram_rdata[71:0])
	);
end
if ((STLB_TAG_RAM_AW == 4) && (STLB_TAG_RAM_DW <= 39) && (STLB_TAG_RAM_DW > 0)) begin : gen_ram_aw_16_dw_39
	ram16x39 ram_inst (
			.clka	(clk),
			.ena	(stlb_cs),
			.wea	({9{stlb_we}}),
			.addra	(ram_addr[3:0]),
			.dina	(ram_wdata[38:0]),
			.douta	(ram_rdata[38:0])
	);
	assign ram_rdata[71:39] = {33{1'b0}};
end
if ((STLB_TAG_RAM_AW == 4) && (STLB_TAG_RAM_DW <= 72) && (STLB_TAG_RAM_DW > 39)) begin : gen_ram_aw_16_dw_72
	ram16x72 ram_inst (
			.clka	(clk),
			.ena	(stlb_cs),
			.wea	({9{stlb_we}}),
			.addra	(ram_addr[3:0]),
			.dina	(ram_wdata[71:0]),
			.douta	(ram_rdata[71:0])
	);
end
if ((STLB_TAG_RAM_AW == 5) && (STLB_TAG_RAM_DW <= 39) && (STLB_TAG_RAM_DW > 0)) begin : gen_ram_aw_32_dw_39
	ram32x39 ram_inst (
			.clka	(clk),
			.ena	(stlb_cs),
			.wea	({9{stlb_we}}),
			.addra	(ram_addr[4:0]),
			.dina	(ram_wdata[38:0]),
			.douta	(ram_rdata[38:0])
	);
	assign ram_rdata[71:39] = {33{1'b0}};
end
if ((STLB_TAG_RAM_AW == 5) && (STLB_TAG_RAM_DW <= 72) && (STLB_TAG_RAM_DW > 39)) begin : gen_ram_aw_32_dw_72
	ram32x72 ram_inst (
			.clka	(clk),
			.ena	(stlb_cs),
			.wea	({9{stlb_we}}),
			.addra	(ram_addr[4:0]),
			.dina	(ram_wdata[71:0]),
			.douta	(ram_rdata[71:0])
	);
end
if ((STLB_TAG_RAM_AW == 6) && (STLB_TAG_RAM_DW <= 39) && (STLB_TAG_RAM_DW > 0)) begin : gen_ram_aw_64_dw_39
	ram64x39 ram_inst (
			.clka	(clk),
			.ena	(stlb_cs),
			.wea	({9{stlb_we}}),
			.addra	(ram_addr[5:0]),
			.dina	(ram_wdata[38:0]),
			.douta	(ram_rdata[38:0])
	);
	assign ram_rdata[71:39] = {33{1'b0}};
end
if ((STLB_TAG_RAM_AW == 6) && (STLB_TAG_RAM_DW <= 72) && (STLB_TAG_RAM_DW > 39)) begin : gen_ram_aw_64_dw_72
	ram64x72 ram_inst (
			.clka	(clk),
			.ena	(stlb_cs),
			.wea	({9{stlb_we}}),
			.addra	(ram_addr[5:0]),
			.dina	(ram_wdata[71:0]),
			.douta	(ram_rdata[71:0])
	);
end
if ((STLB_TAG_RAM_AW == 7) && (STLB_TAG_RAM_DW <= 39) && (STLB_TAG_RAM_DW > 0)) begin : gen_ram_aw_128_dw_39
	ram128x39 ram_inst (
			.clka	(clk),
			.ena	(stlb_cs),
			.wea	({9{stlb_we}}),
			.addra	(ram_addr[6:0]),
			.dina	(ram_wdata[38:0]),
			.douta	(ram_rdata[38:0])
	);
	assign ram_rdata[71:39] = {33{1'b0}};
end
if ((STLB_TAG_RAM_AW == 7) && (STLB_TAG_RAM_DW <= 72) && (STLB_TAG_RAM_DW > 39)) begin : gen_ram_aw_128_dw_72
	ram128x72 ram_inst (
			.clka	(clk),
			.ena	(stlb_cs),
			.wea	({9{stlb_we}}),
			.addra	(ram_addr[6:0]),
			.dina	(ram_wdata[71:0]),
			.douta	(ram_rdata[71:0])
	);
end
endgenerate
assign stlb_rdata = ram_rdata[STLB_TAG_RAM_DW-1:0];

wire   nds_unused_stlb_ctrl_in = |{stlb_ctrl_in};
assign stlb_ctrl_out = {STLB_TAG_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule


// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_stlb_ram (
		  clk,
		  stlb_cs,
		  stlb_we,
		  stlb_addr,
		  stlb_wdata,
		  stlb_rdata,
		  stlb_ctrl_in,
		  stlb_ctrl_out
);

parameter STLB_RAM_AW  = 3;
parameter STLB_RAM_DW  = 73;
parameter STLB_RAM_CTRL_IN_WIDTH = 1;
parameter STLB_RAM_CTRL_OUT_WIDTH = 1;


input                     clk;
input            	  stlb_cs;
input			  stlb_we;
input	[STLB_RAM_AW-1:0] stlb_addr;
input  	[STLB_RAM_DW-1:0] stlb_wdata;
output 	[STLB_RAM_DW-1:0] stlb_rdata;
input   [(STLB_RAM_CTRL_IN_WIDTH-1):0] stlb_ctrl_in;
output [(STLB_RAM_CTRL_OUT_WIDTH-1):0] stlb_ctrl_out;


wire  [6:0] ram_addr  = {{( 7-STLB_RAM_AW){1'b0}}, stlb_addr};
wire [89:0] ram_wdata = {{(90-STLB_RAM_DW){1'b0}}, stlb_wdata};
wire [89:0] ram_rdata;

generate
if (STLB_RAM_AW == 3) begin : gen_ram_stlb_aw3
ram8x90 ram_inst (
		.clka	(clk),
		.ena	(stlb_cs),
		.wea	(stlb_we),
		.addra	(ram_addr[2:0]),
		.dina	(ram_wdata),
		.douta	(ram_rdata)
);
end
if (STLB_RAM_AW == 4) begin : gen_ram_stlb_aw4
ram16x90 ram_inst (
		.clka	(clk),
		.ena	(stlb_cs),
		.wea	(stlb_we),
		.addra	(ram_addr[3:0]),
		.dina	(ram_wdata),
		.douta	(ram_rdata)
);
end
if (STLB_RAM_AW == 5) begin : gen_ram_stlb_aw5
ram32x90 ram_inst (
		.clka	(clk),
		.ena	(stlb_cs),
		.wea	(stlb_we),
		.addra	(ram_addr[4:0]),
		.dina	(ram_wdata),
		.douta	(ram_rdata)
);
end
if (STLB_RAM_AW == 6) begin : gen_ram_stlb_aw6
ram64x90 ram_inst (
		.clka	(clk),
		.ena	(stlb_cs),
		.wea	(stlb_we),
		.addra	(ram_addr[5:0]),
		.dina	(ram_wdata),
		.douta	(ram_rdata)
);
end
if (STLB_RAM_AW == 7) begin : gen_ram_stlb_aw7
ram128x90 ram_inst (
		.clka	(clk),
		.ena	(stlb_cs),
		.wea	(stlb_we),
		.addra	(ram_addr[6:0]),
		.dina	(ram_wdata),
		.douta	(ram_rdata)
);
end
endgenerate

assign stlb_rdata = ram_rdata[STLB_RAM_DW-1:0];

wire   nds_unused_stlb_ctrl_in = |{stlb_ctrl_in};
assign stlb_ctrl_out = {STLB_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule


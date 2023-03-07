// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_btb_ram (
		  clk,
		  btb_addr,
		  btb_cs,
		  btb_we,
		  btb_wdata,
		  btb_rdata,
		  btb_ctrl_in,
		  btb_ctrl_out
);
parameter          BTB_RAM_ADDR_WIDTH=7;
parameter          BTB_RAM_DATA_WIDTH=38;
parameter          BTB_RAM_CTRL_IN_WIDTH=1;
parameter          BTB_RAM_CTRL_OUT_WIDTH=1;

input                                     clk;
input            [BTB_RAM_ADDR_WIDTH-1:0] btb_addr;
input                                     btb_cs;
input                                     btb_we;
input            [BTB_RAM_DATA_WIDTH-1:0] btb_wdata;
output           [BTB_RAM_DATA_WIDTH-1:0] btb_rdata;
input       [(BTB_RAM_CTRL_IN_WIDTH-1):0] btb_ctrl_in;
output     [(BTB_RAM_CTRL_OUT_WIDTH-1):0] btb_ctrl_out;

wire	[127:0]		btb_ram_wdata = {{128-BTB_RAM_DATA_WIDTH{1'b0}}, btb_wdata};




generate
if (BTB_RAM_ADDR_WIDTH == 7) begin : gen_btb_256
	wire			btb_cs0;
	wire			btb_cs1;
	wire	[127:0]		btb_ram_rdata0;
	wire	[127:0]		btb_ram_rdata1;
	reg			ram0_is_rd;
	reg			ram1_is_rd;

	assign btb_cs0 = btb_addr[BTB_RAM_ADDR_WIDTH-1];
	assign btb_cs1 = ~btb_addr[BTB_RAM_ADDR_WIDTH-1];

	ram64x128 ram_inst0 (
			.clka	(clk),
			.ena	(btb_cs0),
			.wea	({16{btb_we}}),
			.addra	(btb_addr[5:0]),
			.dina	(btb_ram_wdata),
			.douta	(btb_ram_rdata0)
	);

	ram64x128 ram_inst1 (
			.clka	(clk),
			.ena	(btb_cs1),
			.wea	({16{btb_we}}),
			.addra	(btb_addr[5:0]),
			.dina	(btb_ram_wdata),
			.douta	(btb_ram_rdata1)
	);

	always @(posedge clk) begin
		ram0_is_rd <= btb_cs0 & ~btb_we;
		ram1_is_rd <= btb_cs1 & ~btb_we;
	end

	assign btb_rdata = ({BTB_RAM_DATA_WIDTH{ram0_is_rd}} & btb_ram_rdata0[BTB_RAM_DATA_WIDTH-1:0]) |
			   ({BTB_RAM_DATA_WIDTH{ram1_is_rd}} & btb_ram_rdata1[BTB_RAM_DATA_WIDTH-1:0]) ;
end
else begin : gen_btb_512
	wire			btb_cs0;
	wire			btb_cs1;
	wire			btb_cs2;
	wire			btb_cs3;
	wire	[127:0]		btb_ram_rdata0;
	wire	[127:0]		btb_ram_rdata1;
	wire	[127:0]		btb_ram_rdata2;
	wire	[127:0]		btb_ram_rdata3;
	reg			ram0_is_rd;
	reg			ram1_is_rd;
	reg			ram2_is_rd;
	reg			ram3_is_rd;

	ram64x128 ram_inst0 (
			.clka	(clk),
			.ena	(btb_cs0),
			.wea	({16{btb_we}}),
			.addra	(btb_addr[5:0]),
			.dina	(btb_ram_wdata),
			.douta	(btb_ram_rdata0)
	);

	ram64x128 ram_inst1 (
			.clka	(clk),
			.ena	(btb_cs1),
			.wea	({16{btb_we}}),
			.addra	(btb_addr[5:0]),
			.dina	(btb_ram_wdata),
			.douta	(btb_ram_rdata1)
	);

	ram64x128 ram_inst2 (
			.clka	(clk),
			.ena	(btb_cs2),
			.wea	({16{btb_we}}),
			.addra	(btb_addr[5:0]),
			.dina	(btb_ram_wdata),
			.douta	(btb_ram_rdata2)
	);

	ram64x128 ram_inst3 (
			.clka	(clk),
			.ena	(btb_cs3),
			.wea	({16{btb_we}}),
			.addra	(btb_addr[5:0]),
			.dina	(btb_ram_wdata),
			.douta	(btb_ram_rdata3)
	);

	assign btb_cs0 = btb_addr[BTB_RAM_ADDR_WIDTH-1:BTB_RAM_ADDR_WIDTH-2] == 2'b00;
	assign btb_cs1 = btb_addr[BTB_RAM_ADDR_WIDTH-1:BTB_RAM_ADDR_WIDTH-2] == 2'b01;
	assign btb_cs2 = btb_addr[BTB_RAM_ADDR_WIDTH-1:BTB_RAM_ADDR_WIDTH-2] == 2'b10;
	assign btb_cs3 = btb_addr[BTB_RAM_ADDR_WIDTH-1:BTB_RAM_ADDR_WIDTH-2] == 2'b11;

	always @(posedge clk) begin
		ram0_is_rd <= btb_cs0 & ~btb_we;
		ram1_is_rd <= btb_cs1 & ~btb_we;
		ram2_is_rd <= btb_cs2 & ~btb_we;
		ram3_is_rd <= btb_cs3 & ~btb_we;
	end

	assign btb_rdata = ({BTB_RAM_DATA_WIDTH{ram0_is_rd}} & btb_ram_rdata0[BTB_RAM_DATA_WIDTH-1:0]) |
			   ({BTB_RAM_DATA_WIDTH{ram1_is_rd}} & btb_ram_rdata1[BTB_RAM_DATA_WIDTH-1:0]) |
			   ({BTB_RAM_DATA_WIDTH{ram2_is_rd}} & btb_ram_rdata2[BTB_RAM_DATA_WIDTH-1:0]) |
			   ({BTB_RAM_DATA_WIDTH{ram3_is_rd}} & btb_ram_rdata3[BTB_RAM_DATA_WIDTH-1:0]) ;

end
endgenerate

wire nds_unused_btb_ctrl_in = |btb_ctrl_in;
assign btb_ctrl_out = {BTB_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule


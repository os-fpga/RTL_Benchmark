// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_icache_data_ecc_ram(
		  clk,
		  icache_data_cs,
		  icache_data_addr,
		  icache_data_rdata,
		  icache_data_wdata,
		  icache_data_we,
		  icache_data_ctrl_in,
		  icache_data_ctrl_out
);

parameter ICACHE_DATA_RAM_DW  = 19;
parameter ICACHE_DATA_RAM_AW  = 9;
parameter ICACHE_DATA_RAM_CTRL_IN_WIDTH = 1;
parameter ICACHE_DATA_RAM_CTRL_OUT_WIDTH = 1;

localparam OUT_DELAY = 0.1;

input              			clk;

input                                        icache_data_cs;
input              [(ICACHE_DATA_RAM_AW-1):0] icache_data_addr;
output	           [(ICACHE_DATA_RAM_DW-1):0] icache_data_rdata;
input              [(ICACHE_DATA_RAM_DW-1):0] icache_data_wdata;
input                                        icache_data_we;
input   [(ICACHE_DATA_RAM_CTRL_IN_WIDTH-1):0] icache_data_ctrl_in;
output [(ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] icache_data_ctrl_out;

wire                                    ram_cs     = icache_data_cs;
wire    [(ICACHE_DATA_RAM_AW-1):0]       ram_addr   = icache_data_addr;
wire                                    ram_we     = icache_data_we;
wire	[(ICACHE_DATA_RAM_DW-1):0]       ram_wdata  = icache_data_wdata;
wire	[(ICACHE_DATA_RAM_DW-1):0]       ram_rdata;


nds_ram_model #(
	.ADDR_WIDTH (ICACHE_DATA_RAM_AW),
	.WRITE_WIDTH (ICACHE_DATA_RAM_DW)
) ram_inst (
	.clk  (clk),
	.cs   (ram_cs),
	.we   (ram_we),
	.addr (ram_addr),
	.din  (ram_wdata),
	.dout (ram_rdata)
);

`ifdef TEST_MEM_MACRO

	assign icache_data_rdata = ram_rdata;

`elsif DISABLE_RAND_ECC_INJECT

  assign icache_data_rdata = ram_rdata;





// synthesis translate_off








// synthesis translate_on

`else

	assign icache_data_rdata = ram_rdata;

`endif

wire nds_unused_icache_data_ctrl_in = |icache_data_ctrl_in;
assign icache_data_ctrl_out = {ICACHE_DATA_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule


// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_stlb_data_ecc_ram(
		  clk,
		  stlb_cs,
		  stlb_we,
		  stlb_addr,
		  stlb_wdata,
		  stlb_rdata,
		  stlb_ctrl_in,
		  stlb_ctrl_out
);
`ifndef NDS_ECC_RAND_INJECT_RATE
        `define NDS_ECC_RAND_INJECT_RATE 10

`endif

`ifndef NDS_ECC_RAND_INJECT_2BIT_ERR_RATE
        `define NDS_ECC_RAND_INJECT_2BIT_ERR_RATE 20
`endif

parameter STLB_DATA_RAM_AW             = 3;
parameter STLB_DATA_RAM_DW             = 71;
parameter STLB_DATA_RAM_CTRL_IN_WIDTH  = 1;
parameter STLB_DATA_RAM_CTRL_OUT_WIDTH = 1;

localparam OUT_DELAY = 0.1;

input                                  clk;
input                                  stlb_cs;
input                                  stlb_we;
input              [(STLB_DATA_RAM_AW-1):0] stlb_addr;
input              [(STLB_DATA_RAM_DW-1):0] stlb_wdata;
output             [(STLB_DATA_RAM_DW-1):0] stlb_rdata;
input   [(STLB_DATA_RAM_CTRL_IN_WIDTH-1):0] stlb_ctrl_in;
output [(STLB_DATA_RAM_CTRL_OUT_WIDTH-1):0] stlb_ctrl_out;

wire                              ram_cs     = stlb_cs;
wire          [(STLB_DATA_RAM_AW-1):0] ram_addr   = stlb_addr;
wire                              ram_we     = stlb_we;
wire          [(STLB_DATA_RAM_DW-1):0] ram_wdata  = stlb_wdata;
wire          [(STLB_DATA_RAM_DW-1):0] ram_rdata;

nds_ram_model #(
	.ADDR_WIDTH (STLB_DATA_RAM_AW),
	.WRITE_WIDTH(STLB_DATA_RAM_DW),
	.OUT_DELAY  (OUT_DELAY)
) ram_inst (
	.clk  (clk),
	.cs   (ram_cs),
	.we   (ram_we),
	.addr (ram_addr),
	.din  (ram_wdata),
	.dout (ram_rdata)
);

`ifdef TEST_MEM_MACRO

assign stlb_rdata = ram_rdata;

`else
        `ifdef DISABLE_RAND_ECC_INJECT

                assign stlb_rdata = ram_rdata;

        `else

                // synthesis translate_off







                // synthesis translate_on


                assign stlb_rdata = ram_rdata;


        `endif
`endif

wire	nds_unused_dcache_ctrl_in = |stlb_ctrl_in;
assign stlb_ctrl_out = {STLB_DATA_RAM_CTRL_OUT_WIDTH{1'b0}};

endmodule



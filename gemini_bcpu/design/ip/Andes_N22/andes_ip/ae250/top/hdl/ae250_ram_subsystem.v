// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "ae250_config.vh"
`include "ae250_const.vh"



module ae250_ram_subsystem (
	  hprot,
	  haddr,
	  hburst,
	  hready,
	  hreadyout,
	  hresp,
	  hsel,
	  hsize,
	  htrans,
	  hwrite,
	  hclk,
	  hresetn,
	  init_calib_complete,
	  hrdata,
	  hwdata
);

parameter ADDR_WIDTH = 32;
parameter SIMULATION = "FALSE" ;
parameter SIM_BYPASS_INIT_CAL = "OFF" ;

input                  [3:0] hprot;
input       [ADDR_WIDTH-1:0] haddr;
input                  [2:0] hburst;
input                        hready;
output                       hreadyout;
output                 [1:0] hresp;
input                        hsel;
input                  [2:0] hsize;
input                  [1:0] htrans;
input                        hwrite;
input                        hclk;
input                        hresetn;
output                       init_calib_complete;
output                [31:0] hrdata;
input                 [31:0] hwdata;

wire                                [19:0] rambrg_ram_addr;
wire                                       rambrg_ram_csb;
wire                                 [3:0] rambrg_ram_web;


assign init_calib_complete = 1'b1;
assign hresp[1] = 1'b0;




atcrambrg200 #(
	.ADDR_WIDTH      (22              ),
	.DATA_WIDTH      (32              ),
	.OOR_ERR_EN      (1               )
) atcrambrg200 (
	.hclk     (hclk           ),
	.hresetn  (hresetn        ),
	.hsel     (hsel           ),
	.hready   (hready         ),
	.haddr    (haddr[21:0]    ),
	.hwrite   (hwrite         ),
	.htrans   (htrans         ),
	.hsize    (hsize          ),
	.hburst   (hburst         ),
	.hprot    (hprot          ),
	.hreadyout(hreadyout      ),
	.hresp    (hresp[0]       ),
	.mem_csb  (rambrg_ram_csb ),
	.mem_web  (rambrg_ram_web ),
	.mem_addr (rambrg_ram_addr)
);

   `ifdef NDS_FPGA
ae250_fpga_rambrg_ram #(
	.RAMBRG_RAM_ADDR_WIDTH(20              ),
	.RAMBRG_RAM_DATA_WIDTH(32              )
) rambrg_ram (
	.clk             (hclk           ),
	.hresetn         (hresetn        ),
	.rambrg_ram_addr (rambrg_ram_addr),
	.rambrg_ram_csb  (rambrg_ram_csb ),
	.rambrg_ram_web  (rambrg_ram_web ),
	.rambrg_ram_wdata(hwdata         ),
	.rambrg_ram_rdata(hrdata         )
);

   `else
ae250_rambrg_ram #(
	.RAMBRG_RAM_ADDR_WIDTH(20              ),
	.RAMBRG_RAM_DATA_WIDTH(32              )
) rambrg_ram (
	.clk             (hclk           ),
	.rambrg_ram_addr (rambrg_ram_addr),
	.rambrg_ram_csb  (rambrg_ram_csb ),
	.rambrg_ram_web  (rambrg_ram_web ),
	.rambrg_ram_wdata(hwdata         ),
	.rambrg_ram_rdata(hrdata         )
);

   `endif

endmodule

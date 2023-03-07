// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "config.inc"
`include "global.inc"
`include "ae350_config.vh"
`include "ae350_const.vh"


module ae350_ram_subsystem (

	  arcache,
	  arprot,
	  awcache,
	  awprot,
	  wlast,
	  aclk,
	  aresetn,
	  araddr,
	  arburst,
	  arid,
	  arlen,
	  arlock,
	  arready,
	  arsize,
	  arvalid,
	  awaddr,
	  awburst,
	  awid,
	  awlen,
	  awlock,
	  awready,
	  awsize,
	  awvalid,
	  bid,
	  bready,
	  bresp,
	  bvalid,
	  rdata,
	  rid,
	  rlast,
	  rready,
	  rresp,
	  rvalid,
	  wdata,
	  wready,
	  wstrb,
	  wvalid,

   


	  T_por_b,
	  init_calib_complete,
	  ui_clk
);

parameter SIMULATION = "FALSE" ;
parameter SIM_BYPASS_INIT_CAL = "OFF" ;
parameter ID_WIDTH = 4 ;
parameter ADDR_WIDTH = 32 ;
parameter DATA_WIDTH = 64 ;
parameter DDR_ASYNC_DEPTH = 16;
parameter RAMBRG_ADDR_WIDTH       = 23;

localparam ADDR_MSB = ADDR_WIDTH-1 ;
localparam DDR3_WRAPPER_DATA_WIDTH = DATA_WIDTH ;
localparam DDR4_WRAPPER_DATA_WIDTH = DATA_WIDTH ;
localparam MEM_SIZE_KB     = (1 << (RAMBRG_ADDR_WIDTH - 10));
localparam MEM_ADDR_LSB    = $clog2(DATA_WIDTH/8);
localparam MEM_ADDR_MSB    = $clog2(MEM_SIZE_KB) - 1 + 10;
localparam MEM_ADDR_WIDTH  = MEM_ADDR_MSB - MEM_ADDR_LSB + 1;


input                      [3:0] arcache;
input                      [2:0] arprot;
input                      [3:0] awcache;
input                      [2:0] awprot;
input                            wlast;
input                            aclk;
input                            aresetn;
input           [ADDR_WIDTH-1:0] araddr;
input                      [1:0] arburst;
input           [(ID_WIDTH-1):0] arid;
input                      [7:0] arlen;
input                            arlock;
output                           arready;
input                      [2:0] arsize;
input                            arvalid;
input           [ADDR_WIDTH-1:0] awaddr;
input                      [1:0] awburst;
input           [(ID_WIDTH-1):0] awid;
input                      [7:0] awlen;
input                            awlock;
output                           awready;
input                      [2:0] awsize;
input                            awvalid;
output          [(ID_WIDTH-1):0] bid;
input                            bready;
output                     [1:0] bresp;
output                           bvalid;
output          [DATA_WIDTH-1:0] rdata;
output          [(ID_WIDTH-1):0] rid;
output                           rlast;
input                            rready;
output                     [1:0] rresp;
output                           rvalid;
input           [DATA_WIDTH-1:0] wdata;
output                           wready;
input       [(DATA_WIDTH/8)-1:0] wstrb;
input                            wvalid;

   


input                            T_por_b;
output                           init_calib_complete;
output                           ui_clk;


wire                         [(DATA_WIDTH-1):0] mem_dout;
wire                     [(MEM_ADDR_WIDTH-1):0] mem_addr;
wire                                            mem_csb;
wire                         [(DATA_WIDTH-1):0] mem_din;
wire                       [(DATA_WIDTH/8)-1:0] mem_web;

      `ifdef NDS_FPGA
      `else
      `endif

















 assign ui_clk = 1'b0;
 assign init_calib_complete = 1'b1;











atcrambrg300 #(
	.ADDR_WIDTH      (RAMBRG_ADDR_WIDTH),
	.DATA_WIDTH      (DATA_WIDTH      ),
	.ID_WIDTH        (ID_WIDTH        ),
	.OOR_ERR_EN      (1               )
) u_sram_brg (
	.awid    (awid                         ),
	.awaddr  (awaddr[RAMBRG_ADDR_WIDTH-1:0]),
	.awlen   (awlen                        ),
	.awsize  (awsize                       ),
	.awburst (awburst                      ),
	.awlock  (awlock                       ),
	.awvalid (awvalid                      ),
	.awready (awready                      ),
	.wdata   (wdata                        ),
	.wstrb   (wstrb                        ),
	.wvalid  (wvalid                       ),
	.wready  (wready                       ),
	.bid     (bid                          ),
	.bresp   (bresp                        ),
	.bvalid  (bvalid                       ),
	.bready  (bready                       ),
	.arid    (arid                         ),
	.araddr  (araddr[RAMBRG_ADDR_WIDTH-1:0]),
	.arlen   (arlen                        ),
	.arsize  (arsize                       ),
	.arburst (arburst                      ),
	.arlock  (arlock                       ),
	.arvalid (arvalid                      ),
	.arready (arready                      ),
	.rid     (rid                          ),
	.rdata   (rdata                        ),
	.rresp   (rresp                        ),
	.rlast   (rlast                        ),
	.rvalid  (rvalid                       ),
	.rready  (rready                       ),
	.mem_addr(mem_addr                     ),
	.mem_web (mem_web                      ),
	.mem_csb (mem_csb                      ),
	.mem_din (mem_din                      ),
	.mem_dout(mem_dout                     ),
	.aclk    (aclk                         ),
	.aresetn (aresetn                      )
);

ae350_rambrg_ram #(
	.ADDR_WIDTH      (MEM_ADDR_WIDTH  ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_sram (
	.addr(mem_addr),
	.clk (aclk    ),
	.csb (mem_csb ),
	.web (mem_web ),
	.din (mem_din ),
	.dout(mem_dout)
);




endmodule

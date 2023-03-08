// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary


`include "ae250_config.vh"


module ae250_debug_subsystem (
	  debugint,
	  hart_halted,
	  hart_unavail,
	  hart_under_reset,
	  pin_tdi_in,
	  pin_tdi_out,
	  pin_tdi_out_en,
	  pin_tdo_in,
	  pin_tdo_out,
	  pin_tdo_out_en,
	  pin_tms_in,
	  pin_tms_out,
	  pin_tms_out_en,
	  pin_trst_in,
	  pin_trst_out,
	  pin_trst_out_en,
	  resethaltreq,
	  clk,
	  dbg_tck,
	  dbg_wakeup_req,
	  por_rstn,
	  test_mode,
	  dbg_srst_req,
	  dmactive,
	  haddr,
	  hburst,
	  hclk,
	  hprot,
	  hrdata,
	  hready,
	  hreadyout,
	  hresp,
	  hsel,
	  hsize,
	  htrans,
	  hwdata,
	  hwrite,
	  reset_n,
	  rv_araddr,
	  rv_arburst,
	  rv_arcache,
	  rv_arid,
	  rv_arlen,
	  rv_arlock,
	  rv_arprot,
	  rv_arready,
	  rv_arsize,
	  rv_arvalid,
	  rv_awaddr,
	  rv_awburst,
	  rv_awcache,
	  rv_awid,
	  rv_awlen,
	  rv_awlock,
	  rv_awprot,
	  rv_awready,
	  rv_awsize,
	  rv_awvalid,
	  rv_bid,
	  rv_bready,
	  rv_bresp,
	  rv_bvalid,
	  rv_rdata,
	  rv_rid,
	  rv_rlast,
	  rv_rready,
	  rv_rresp,
	  rv_rvalid,
	  rv_wdata,
	  rv_wlast,
	  rv_wready,
	  rv_wstrb,
	  rv_wvalid,
	  sys_araddr,
	  sys_arburst,
	  sys_arcache,
	  sys_arid,
	  sys_arlen,
	  sys_arlock,
	  sys_arprot,
	  sys_arready,
	  sys_arsize,
	  sys_arvalid,
	  sys_awaddr,
	  sys_awburst,
	  sys_awcache,
	  sys_awid,
	  sys_awlen,
	  sys_awlock,
	  sys_awprot,
	  sys_awready,
	  sys_awsize,
	  sys_awvalid,
	  sys_bid,
	  sys_bready,
	  sys_bresp,
	  sys_bvalid,
	  sys_haddr,
	  sys_hburst,
	  sys_hbusreq,
	  sys_hgrant,
	  sys_hprot,
	  sys_hrdata,
	  sys_hready,
	  sys_hresp,
	  sys_hsize,
	  sys_htrans,
	  sys_hwdata,
	  sys_hwrite,
	  sys_rdata,
	  sys_rid,
	  sys_rlast,
	  sys_rready,
	  sys_rresp,
	  sys_rvalid,
	  sys_wdata,
	  sys_wlast,
	  sys_wready,
	  sys_wstrb,
	  sys_wvalid
);

parameter NHART = 1;
parameter SYS_ADDR_WIDTH = 32;
parameter SYS_DATA_WIDTH = 32;
parameter RV_ADDR_WIDTH = 32;
parameter RV_DATA_WIDTH = 32;
parameter HASEL_SUPPORT	= "yes";
parameter ADDR_WIDTH = 32;

`ifdef AE250_JTAG_TWOWIRE
localparam DEBUG_INTERFACE	= "serial";
`else
localparam DEBUG_INTERFACE	= "jtag";
`endif
`ifdef AE250_PLDM_SYS_BUS_ACCESS
localparam SYS_BUS_ACCESS	= "yes";
`else
localparam SYS_BUS_ACCESS	= "no";
`endif
`ifdef AE250_PLDM_PROGBUF_SUPPORT
localparam PROGBUF_SIZE	= 8;
`else
localparam PROGBUF_SIZE	= 2;
`endif

output                   [NHART-1:0] debugint;
input                    [NHART-1:0] hart_halted;
input                    [NHART-1:0] hart_unavail;
input                    [NHART-1:0] hart_under_reset;
input                                pin_tdi_in;
output                               pin_tdi_out;
output                               pin_tdi_out_en;
input                                pin_tdo_in;
output                               pin_tdo_out;
output                               pin_tdo_out_en;
input                                pin_tms_in;
output                               pin_tms_out;
output                               pin_tms_out_en;
input                                pin_trst_in;
output                               pin_trst_out;
output                               pin_trst_out_en;
output                   [NHART-1:0] resethaltreq;
input                                clk;
input                                dbg_tck;
output                               dbg_wakeup_req;
input                                por_rstn;
input                                test_mode;
output                               dbg_srst_req;
output                               dmactive;
input          [(RV_ADDR_WIDTH-1):0] haddr;
input                          [2:0] hburst;
input                                hclk;
input                          [3:0] hprot;
output         [(RV_DATA_WIDTH-1):0] hrdata;
input                                hready;
output                               hreadyout;
output                         [1:0] hresp;
input                                hsel;
input                          [2:0] hsize;
input                          [1:0] htrans;
input          [(RV_DATA_WIDTH-1):0] hwdata;
input                                hwrite;
input                                reset_n;
input          [(RV_ADDR_WIDTH-1):0] rv_araddr;
input                          [1:0] rv_arburst;
input                          [3:0] rv_arcache;
input                          [3:0] rv_arid;
input                          [7:0] rv_arlen;
input                                rv_arlock;
input                          [2:0] rv_arprot;
output                               rv_arready;
input                          [2:0] rv_arsize;
input                                rv_arvalid;
input          [(RV_ADDR_WIDTH-1):0] rv_awaddr;
input                          [1:0] rv_awburst;
input                          [3:0] rv_awcache;
input                          [3:0] rv_awid;
input                          [7:0] rv_awlen;
input                                rv_awlock;
input                          [2:0] rv_awprot;
output                               rv_awready;
input                          [2:0] rv_awsize;
input                                rv_awvalid;
output                         [3:0] rv_bid;
input                                rv_bready;
output                         [1:0] rv_bresp;
output                               rv_bvalid;
output         [(RV_DATA_WIDTH-1):0] rv_rdata;
output                         [3:0] rv_rid;
output                               rv_rlast;
input                                rv_rready;
output                         [1:0] rv_rresp;
output                               rv_rvalid;
input          [(RV_DATA_WIDTH-1):0] rv_wdata;
input                                rv_wlast;
output                               rv_wready;
input        [(RV_DATA_WIDTH/8)-1:0] rv_wstrb;
input                                rv_wvalid;
output        [(SYS_ADDR_WIDTH-1):0] sys_araddr;
output                         [1:0] sys_arburst;
output                         [3:0] sys_arcache;
output                         [3:0] sys_arid;
output                         [7:0] sys_arlen;
output                               sys_arlock;
output                         [2:0] sys_arprot;
input                                sys_arready;
output                         [2:0] sys_arsize;
output                               sys_arvalid;
output        [(SYS_ADDR_WIDTH-1):0] sys_awaddr;
output                         [1:0] sys_awburst;
output                         [3:0] sys_awcache;
output                         [3:0] sys_awid;
output                         [7:0] sys_awlen;
output                               sys_awlock;
output                         [2:0] sys_awprot;
input                                sys_awready;
output                         [2:0] sys_awsize;
output                               sys_awvalid;
input                          [3:0] sys_bid;
output                               sys_bready;
input                          [1:0] sys_bresp;
input                                sys_bvalid;
output        [(SYS_ADDR_WIDTH-1):0] sys_haddr;
output                         [2:0] sys_hburst;
output                               sys_hbusreq;
input                                sys_hgrant;
output                         [3:0] sys_hprot;
input         [(SYS_DATA_WIDTH-1):0] sys_hrdata;
input                                sys_hready;
input                          [1:0] sys_hresp;
output                         [2:0] sys_hsize;
output                         [1:0] sys_htrans;
output        [(SYS_DATA_WIDTH-1):0] sys_hwdata;
output                               sys_hwrite;
input         [(SYS_DATA_WIDTH-1):0] sys_rdata;
input                          [3:0] sys_rid;
input                                sys_rlast;
output                               sys_rready;
input                          [1:0] sys_rresp;
input                                sys_rvalid;
output        [(SYS_DATA_WIDTH-1):0] sys_wdata;
output                               sys_wlast;
input                                sys_wready;
output      [(SYS_DATA_WIDTH/8)-1:0] sys_wstrb;
output                               sys_wvalid;

wire                     [NHART-1:0] dm_hart_halted;
wire                     [NHART-1:0] dm_hart_unavail;
wire                     [NHART-1:0] dm_hart_under_reset;
wire                           [8:0] dmi_haddr;
wire                                 dmi_hresp;
wire                                 tdi;
wire                                 tms;
wire                          [31:0] dmi_haddr_32bit;
wire                           [2:0] dmi_hburst;
wire                           [3:0] dmi_hprot;
wire                                 dmi_hresetn;
wire                                 dmi_hsel;
wire                           [2:0] dmi_hsize;
wire                           [1:0] dmi_htrans;
wire                          [31:0] dmi_hwdata;
wire                                 dmi_hwrite;
wire                                 tdo;
wire                                 tdo_out_en;
wire                                 tms_out_en;
wire                     [NHART-1:0] dm_debugint;
wire                     [NHART-1:0] dm_resethaltreq;
wire                          [31:0] dmi_hrdata;
wire                                 dmi_hreadyout;
wire                           [1:0] dmi_hresp_2bit;

assign dmi_haddr = dmi_haddr_32bit[8:0];
assign dmi_hresp = dmi_hresp_2bit[0];
assign	pin_trst_out	= 1'b0;
assign	pin_trst_out_en	= 1'b0;
assign	tms		= pin_tms_in;
assign	pin_tdi_out	= 1'b0;
assign	pin_tdi_out_en	= 1'b0;
`ifdef AE250_JTAG_TWOWIRE
assign	pin_tms_out_en	= tms_out_en;
assign	pin_tms_out	= tdo;
assign	tdi     	= 1'bx;
assign	pin_tdo_out	= 1'bx;
assign	pin_tdo_out_en	= 1'bx;
`else
assign	pin_tms_out_en	= 1'b0;
assign	pin_tms_out	= 1'b0;
assign	tdi		= pin_tdi_in;
assign	pin_tdo_out	= tdo;
assign	pin_tdo_out_en	= tdo_out_en;
`endif
assign dm_hart_unavail     = hart_unavail;
assign dm_hart_under_reset = hart_under_reset;
assign dm_hart_halted      = hart_halted;
assign debugint = dm_debugint;
assign resethaltreq = dm_resethaltreq;

ncejdtm200 #(
	.DEBUG_INTERFACE (DEBUG_INTERFACE )
) ncejdtm200 (
	.dbg_wakeup_req(dbg_wakeup_req ),
	.tms_out_en    (tms_out_en     ),
	.test_mode     (test_mode      ),
	.pwr_rst_n     (por_rstn       ),
	.tck           (dbg_tck        ),
	.tms           (tms            ),
	.tdi           (tdi            ),
	.tdo           (tdo            ),
	.tdo_out_en    (tdo_out_en     ),
	.dmi_hresetn   (dmi_hresetn    ),
	.dmi_hclk      (clk            ),
	.dmi_hsel      (dmi_hsel       ),
	.dmi_htrans    (dmi_htrans     ),
	.dmi_haddr     (dmi_haddr_32bit),
	.dmi_hsize     (dmi_hsize      ),
	.dmi_hburst    (dmi_hburst     ),
	.dmi_hprot     (dmi_hprot      ),
	.dmi_hwdata    (dmi_hwdata     ),
	.dmi_hwrite    (dmi_hwrite     ),
	.dmi_hrdata    (dmi_hrdata     ),
	.dmi_hready    (dmi_hreadyout  ),
	.dmi_hresp     (dmi_hresp      )
);

ncepldm200 #(
	.ADDR_WIDTH      (RV_ADDR_WIDTH   ),
	.DATA_WIDTH      (RV_DATA_WIDTH   ),
	.HASEL_SUPPORT   (HASEL_SUPPORT   ),
	.NHART           (NHART           ),
	.PROGBUF_SIZE    (PROGBUF_SIZE    ),
	.RV_BUS_TYPE     ("ahb"           ),
	.SYSTEM_BUS_ACCESS_SUPPORT(SYS_BUS_ACCESS  ),
	.SYS_ADDR_WIDTH  (SYS_ADDR_WIDTH  ),
	.SYS_BUS_TYPE    ("ahb"           ),
	.SYS_DATA_WIDTH  (SYS_DATA_WIDTH  )
) ncepldm200 (
	.debugint        (dm_debugint        ),
	.resethaltreq    (dm_resethaltreq    ),
	.dmactive        (dmactive           ),
	.ndmreset        (dbg_srst_req       ),
	.clk             (hclk               ),
	.dmi_resetn      (dmi_hresetn        ),
	.hart_unavail    (dm_hart_unavail    ),
	.hart_halted     (dm_hart_halted     ),
	.hart_under_reset(dm_hart_under_reset),
	.bus_resetn      (reset_n            ),
	.rv_haddr        (haddr              ),
	.rv_htrans       (htrans             ),
	.rv_hwrite       (hwrite             ),
	.rv_hsize        (hsize              ),
	.rv_hburst       (hburst             ),
	.rv_hprot        (hprot              ),
	.rv_hwdata       (hwdata             ),
	.rv_hsel         (hsel               ),
	.rv_hready       (hready             ),
	.rv_hrdata       (hrdata             ),
	.rv_hreadyout    (hreadyout          ),
	.rv_hresp        (hresp              ),
	.rv_awid         (rv_awid            ),
	.rv_awaddr       (rv_awaddr          ),
	.rv_awlen        (rv_awlen           ),
	.rv_awsize       (rv_awsize          ),
	.rv_awburst      (rv_awburst         ),
	.rv_awlock       (rv_awlock          ),
	.rv_awcache      (rv_awcache         ),
	.rv_awprot       (rv_awprot          ),
	.rv_awvalid      (rv_awvalid         ),
	.rv_awready      (rv_awready         ),
	.rv_wdata        (rv_wdata           ),
	.rv_wstrb        (rv_wstrb           ),
	.rv_wlast        (rv_wlast           ),
	.rv_wvalid       (rv_wvalid          ),
	.rv_wready       (rv_wready          ),
	.rv_bid          (rv_bid             ),
	.rv_bresp        (rv_bresp           ),
	.rv_bvalid       (rv_bvalid          ),
	.rv_bready       (rv_bready          ),
	.rv_arid         (rv_arid            ),
	.rv_araddr       (rv_araddr          ),
	.rv_arlen        (rv_arlen           ),
	.rv_arsize       (rv_arsize          ),
	.rv_arburst      (rv_arburst         ),
	.rv_arlock       (rv_arlock          ),
	.rv_arcache      (rv_arcache         ),
	.rv_arprot       (rv_arprot          ),
	.rv_arvalid      (rv_arvalid         ),
	.rv_arready      (rv_arready         ),
	.rv_rid          (rv_rid             ),
	.rv_rdata        (rv_rdata           ),
	.rv_rresp        (rv_rresp           ),
	.rv_rlast        (rv_rlast           ),
	.rv_rvalid       (rv_rvalid          ),
	.rv_rready       (rv_rready          ),
	.sys_awid        (sys_awid           ),
	.sys_awaddr      (sys_awaddr         ),
	.sys_awlen       (sys_awlen          ),
	.sys_awsize      (sys_awsize         ),
	.sys_awburst     (sys_awburst        ),
	.sys_awlock      (sys_awlock         ),
	.sys_awcache     (sys_awcache        ),
	.sys_awprot      (sys_awprot         ),
	.sys_awvalid     (sys_awvalid        ),
	.sys_awready     (sys_awready        ),
	.sys_wdata       (sys_wdata          ),
	.sys_wstrb       (sys_wstrb          ),
	.sys_wlast       (sys_wlast          ),
	.sys_wvalid      (sys_wvalid         ),
	.sys_wready      (sys_wready         ),
	.sys_bid         (sys_bid            ),
	.sys_bresp       (sys_bresp          ),
	.sys_bvalid      (sys_bvalid         ),
	.sys_bready      (sys_bready         ),
	.sys_arid        (sys_arid           ),
	.sys_araddr      (sys_araddr         ),
	.sys_arlen       (sys_arlen          ),
	.sys_arsize      (sys_arsize         ),
	.sys_arburst     (sys_arburst        ),
	.sys_arlock      (sys_arlock         ),
	.sys_arcache     (sys_arcache        ),
	.sys_arprot      (sys_arprot         ),
	.sys_arvalid     (sys_arvalid        ),
	.sys_arready     (sys_arready        ),
	.sys_rid         (sys_rid            ),
	.sys_rdata       (sys_rdata          ),
	.sys_rresp       (sys_rresp          ),
	.sys_rlast       (sys_rlast          ),
	.sys_rvalid      (sys_rvalid         ),
	.sys_rready      (sys_rready         ),
	.sys_haddr       (sys_haddr          ),
	.sys_htrans      (sys_htrans         ),
	.sys_hwrite      (sys_hwrite         ),
	.sys_hsize       (sys_hsize          ),
	.sys_hburst      (sys_hburst         ),
	.sys_hprot       (sys_hprot          ),
	.sys_hwdata      (sys_hwdata         ),
	.sys_hbusreq     (sys_hbusreq        ),
	.sys_hrdata      (sys_hrdata         ),
	.sys_hready      (sys_hready         ),
	.sys_hresp       (sys_hresp          ),
	.sys_hgrant      (sys_hgrant         ),
	.dmi_haddr       (dmi_haddr          ),
	.dmi_htrans      (dmi_htrans         ),
	.dmi_hwrite      (dmi_hwrite         ),
	.dmi_hsize       (dmi_hsize          ),
	.dmi_hburst      (dmi_hburst         ),
	.dmi_hprot       (dmi_hprot          ),
	.dmi_hwdata      (dmi_hwdata         ),
	.dmi_hsel        (dmi_hsel           ),
	.dmi_hready      (1'b1               ),
	.dmi_hrdata      (dmi_hrdata         ),
	.dmi_hreadyout   (dmi_hreadyout      ),
	.dmi_hresp       (dmi_hresp_2bit     )
);

endmodule


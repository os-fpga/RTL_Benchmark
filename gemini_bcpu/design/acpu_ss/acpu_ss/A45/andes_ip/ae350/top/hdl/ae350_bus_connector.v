// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "config.inc"
`include "global.inc"

`include "ae350_config.vh"
`include "ae350_const.vh"

`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"


module ae350_bus_connector (
`ifdef AE350_DMA_AXI_SUPPORT
	  dmac0_araddr,
	  dmac0_arburst,
	  dmac0_arcache,
	  dmac0_arid,
	  dmac0_arlen,
	  dmac0_arlock,
	  dmac0_arprot,
	  dmac0_arready,
	  dmac0_arsize,
	  dmac0_arvalid,
	  dmac0_awaddr,
	  dmac0_awburst,
	  dmac0_awcache,
	  dmac0_awid,
	  dmac0_awlen,
	  dmac0_awlock,
	  dmac0_awprot,
	  dmac0_awready,
	  dmac0_awsize,
	  dmac0_awvalid,
	  dmac0_bid,
	  dmac0_bready,
	  dmac0_bresp,
	  dmac0_bvalid,
	  dmac0_rdata,
	  dmac0_rid,
	  dmac0_rlast,
	  dmac0_rready,
	  dmac0_rresp,
	  dmac0_rvalid,
	  dmac0_wdata,
	  dmac0_wlast,
	  dmac0_wready,
	  dmac0_wstrb,
	  dmac0_wvalid,
`endif
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
	  cpuslv_arid,
	  cpuslv_awid,
	  cpuslv_bid,
	  cpuslv_rid,
	  cpuslv_araddr,
	  cpuslv_arburst,
	  cpuslv_arcache,
	  cpuslv_arlen,
	  cpuslv_arlock,
	  cpuslv_arprot,
	  cpuslv_arready,
	  cpuslv_arsize,
	  cpuslv_arvalid,
	  cpuslv_awaddr,
	  cpuslv_awburst,
	  cpuslv_awcache,
	  cpuslv_awlen,
	  cpuslv_awlock,
	  cpuslv_awprot,
	  cpuslv_awready,
	  cpuslv_awsize,
	  cpuslv_awvalid,
	  cpuslv_bready,
	  cpuslv_bresp,
	  cpuslv_bvalid,
	  cpuslv_rdata,
	  cpuslv_rlast,
	  cpuslv_rready,
	  cpuslv_rresp,
	  cpuslv_rvalid,
	  cpuslv_wdata,
	  cpuslv_wlast,
	  cpuslv_wready,
	  cpuslv_wstrb,
	  cpuslv_wvalid,
`endif
`ifdef NDS_IO_COHERENCE
	  iocp0_arcache,
	  iocp0_awcache,
	  iocp0_araddr,
	  iocp0_arburst,
	  iocp0_arid,
	  iocp0_arlen,
	  iocp0_arlock,
	  iocp0_arprot,
	  iocp0_arready,
	  iocp0_arsize,
	  iocp0_arvalid,
	  iocp0_awaddr,
	  iocp0_awburst,
	  iocp0_awid,
	  iocp0_awlen,
	  iocp0_awlock,
	  iocp0_awprot,
	  iocp0_awready,
	  iocp0_awsize,
	  iocp0_awvalid,
	  iocp0_bid,
	  iocp0_bready,
	  iocp0_bresp,
	  iocp0_bvalid,
	  iocp0_rdata,
	  iocp0_rid,
	  iocp0_rlast,
	  iocp0_rready,
	  iocp0_rresp,
	  iocp0_rvalid,
	  iocp0_wdata,
	  iocp0_wlast,
	  iocp0_wready,
	  iocp0_wstrb,
	  iocp0_wvalid,
`endif
   `ifdef NDS_IO_BIU_AXI_COMMON_X2
	  cpu_d_araddr,
	  cpu_d_arburst,
	  cpu_d_arcache,
	  cpu_d_arid,
	  cpu_d_arlen,
	  cpu_d_arlock,
	  cpu_d_arprot,
	  cpu_d_arready,
	  cpu_d_arsize,
	  cpu_d_arvalid,
	  cpu_d_awaddr,
	  cpu_d_awburst,
	  cpu_d_awcache,
	  cpu_d_awid,
	  cpu_d_awlen,
	  cpu_d_awlock,
	  cpu_d_awprot,
	  cpu_d_awready,
	  cpu_d_awsize,
	  cpu_d_awvalid,
	  cpu_d_bid,
	  cpu_d_bready,
	  cpu_d_bresp,
	  cpu_d_bvalid,
	  cpu_d_rdata,
	  cpu_d_rid,
	  cpu_d_rlast,
	  cpu_d_rready,
	  cpu_d_rresp,
	  cpu_d_rvalid,
	  cpu_d_wdata,
	  cpu_d_wlast,
	  cpu_d_wready,
	  cpu_d_wstrb,
	  cpu_d_wvalid,
	  cpu_i_araddr,
	  cpu_i_arburst,
	  cpu_i_arcache,
	  cpu_i_arid,
	  cpu_i_arlen,
	  cpu_i_arlock,
	  cpu_i_arprot,
	  cpu_i_arready,
	  cpu_i_arsize,
	  cpu_i_arvalid,
	  cpu_i_awaddr,
	  cpu_i_awburst,
	  cpu_i_awcache,
	  cpu_i_awid,
	  cpu_i_awlen,
	  cpu_i_awlock,
	  cpu_i_awprot,
	  cpu_i_awready,
	  cpu_i_awsize,
	  cpu_i_awvalid,
	  cpu_i_bid,
	  cpu_i_bready,
	  cpu_i_bresp,
	  cpu_i_bvalid,
	  cpu_i_rdata,
	  cpu_i_rid,
	  cpu_i_rlast,
	  cpu_i_rready,
	  cpu_i_rresp,
	  cpu_i_rvalid,
	  cpu_i_wdata,
	  cpu_i_wlast,
	  cpu_i_wready,
	  cpu_i_wstrb,
	  cpu_i_wvalid,
   `else
	  cpu_araddr,
	  cpu_arburst,
	  cpu_arcache,
	  cpu_arid,
	  cpu_arlen,
	  cpu_arlock,
	  cpu_arprot,
	  cpu_arready,
	  cpu_arsize,
	  cpu_arvalid,
	  cpu_awaddr,
	  cpu_awburst,
	  cpu_awcache,
	  cpu_awid,
	  cpu_awlen,
	  cpu_awlock,
	  cpu_awprot,
	  cpu_awready,
	  cpu_awsize,
	  cpu_awvalid,
	  cpu_bid,
	  cpu_bready,
	  cpu_bresp,
	  cpu_bvalid,
	  cpu_rdata,
	  cpu_rid,
	  cpu_rlast,
	  cpu_rready,
	  cpu_rresp,
	  cpu_rvalid,
	  cpu_wdata,
	  cpu_wlast,
	  cpu_wready,
	  cpu_wstrb,
	  cpu_wvalid,
   `endif

`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
	  dmac1_araddr,
	  dmac1_arburst,
	  dmac1_arcache,
	  dmac1_arid,
	  dmac1_arlen,
	  dmac1_arlock,
	  dmac1_arprot,
	  dmac1_arready,
	  dmac1_arsize,
	  dmac1_arvalid,
	  dmac1_awaddr,
	  dmac1_awburst,
	  dmac1_awcache,
	  dmac1_awid,
	  dmac1_awlen,
	  dmac1_awlock,
	  dmac1_awprot,
	  dmac1_awready,
	  dmac1_awsize,
	  dmac1_awvalid,
	  dmac1_bid,
	  dmac1_bready,
	  dmac1_bresp,
	  dmac1_bvalid,
	  dmac1_rdata,
	  dmac1_rid,
	  dmac1_rlast,
	  dmac1_rready,
	  dmac1_rresp,
	  dmac1_rvalid,
	  dmac1_wdata,
	  dmac1_wlast,
	  dmac1_wready,
	  dmac1_wstrb,
	  dmac1_wvalid,
   `endif
`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
	  dm_sys_araddr,
	  dm_sys_arburst,
	  dm_sys_arcache,
	  dm_sys_arid,
	  dm_sys_arlen,
	  dm_sys_arlock,
	  dm_sys_arprot,
	  dm_sys_arready,
	  dm_sys_arsize,
	  dm_sys_arvalid,
	  dm_sys_awaddr,
	  dm_sys_awburst,
	  dm_sys_awcache,
	  dm_sys_awid,
	  dm_sys_awlen,
	  dm_sys_awlock,
	  dm_sys_awprot,
	  dm_sys_awready,
	  dm_sys_awsize,
	  dm_sys_awvalid,
	  dm_sys_bid,
	  dm_sys_bready,
	  dm_sys_bresp,
	  dm_sys_bvalid,
	  dm_sys_rdata,
	  dm_sys_rid,
	  dm_sys_rlast,
	  dm_sys_rready,
	  dm_sys_rresp,
	  dm_sys_rvalid,
	  dm_sys_wdata,
	  dm_sys_wlast,
	  dm_sys_wready,
	  dm_sys_wstrb,
	  dm_sys_wvalid,
   `endif
`endif
	  hbmc_haddr,
	  hbmc_hburst,
	  hbmc_hprot,
	  hbmc_hrdata,
	  hbmc_hready,
	  hbmc_hreadyout,
	  hbmc_hresp,
	  hbmc_hsel,
	  hbmc_hsize,
	  hbmc_htrans,
	  hbmc_hwdata,
	  hbmc_hwrite,
	  rom_haddr,
	  rom_hburst,
	  rom_hprot,
	  rom_hrdata,
	  rom_hready,
	  rom_hreadyout,
	  rom_hresp,
	  rom_hsel,
	  rom_hsize,
	  rom_htrans,
	  rom_hwdata,
	  rom_hwrite,
	  hclk,
	  hresetn,
	  aclk,
	  aresetn,
	  ram_araddr,
	  ram_arburst,
	  ram_arcache,
	  ram_arid,
	  ram_arlen,
	  ram_arlock,
	  ram_arprot,
	  ram_arready,
	  ram_arsize,
	  ram_arvalid,
	  ram_awaddr,
	  ram_awburst,
	  ram_awcache,
	  ram_awid,
	  ram_awlen,
	  ram_awlock,
	  ram_awprot,
	  ram_awready,
	  ram_awsize,
	  ram_awvalid,
	  ram_bid,
	  ram_bready,
	  ram_bresp,
	  ram_bvalid,
	  ram_rdata,
	  ram_rid,
	  ram_rlast,
	  ram_rready,
	  ram_rresp,
	  ram_rvalid,
	  ram_wdata,
	  ram_wlast,
	  ram_wready,
	  ram_wstrb,
	  ram_wvalid
);

localparam PALEN			= `NDS_BIU_ADDR_WIDTH;
localparam ISA_BASE			= `NDS_ISA_BASE;
localparam XLEN			= ISA_BASE == "rv64i" ? 64 : 32;
localparam MMU_SCHEME		= `NDS_MMU_SCHEME;
localparam VALEN			= (MMU_SCHEME == "bare") ? PALEN : (MMU_SCHEME == "sv32") ? 32 : (MMU_SCHEME == "sv39") ? 39: 48;
`ifdef PLATFORM_FORCE_4GB_SPACE
localparam ADDR_WIDTH               = 32;
`else
localparam ADDR_WIDTH               = PALEN;
`endif
localparam ADDR_MSB  		= (ADDR_WIDTH-1);
`ifdef NDS_L2C_BIU_DATA_WIDTH
localparam BIU_DATA_WIDTH		= `NDS_L2C_BIU_DATA_WIDTH;
`else
localparam BIU_DATA_WIDTH		= `NDS_BIU_DATA_WIDTH;
`endif
localparam BIU_DATA_MSB		= (BIU_DATA_WIDTH-1);
localparam BIU_WSTRB_WIDTH		= (BIU_DATA_WIDTH/8);
localparam BIU_WSTRB_MSB		= (BIU_WSTRB_WIDTH-1);
`ifdef NDS_SLAVE_PORT_DATA_WIDTH
localparam SLVPORT_DATA_WIDTH	= `NDS_SLAVE_PORT_DATA_WIDTH;
`else
localparam SLVPORT_DATA_WIDTH	= `NDS_BIU_DATA_WIDTH;
`endif
localparam SLVPORT_DATA_MSB		= (SLVPORT_DATA_WIDTH-1);
localparam SLVPORT_WSTRB_WIDTH	= (SLVPORT_DATA_WIDTH/8);
localparam SLVPORT_WSTRB_MSB	= (SLVPORT_WSTRB_WIDTH-1);
localparam BIU_ID_WIDTH		= `AE350_AXI_ID_WIDTH;
localparam BIU_ID_MSB		= (BIU_ID_WIDTH-1);
localparam SYSTEM_BUS_TYPE	        = "axi";
localparam ROMHBMC_DATA_WIDTH	= 32;
localparam ROMHBMC_DATA_MSB		= (ROMHBMC_DATA_WIDTH-1);
localparam AE350_SIZEUP300_MSB_PLAT	= $clog2(32) - 3;
`ifdef NDS_L2C_BIU_DATA_WIDTH
localparam AE350_SIZEUP300_MSB_CORE	= $clog2(BIU_DATA_WIDTH) - 4;
`else
localparam AE350_SIZEUP300_MSB_CORE	= $clog2(BIU_DATA_WIDTH) - 4;
`endif
localparam AXCACHE_WRITEBACK_RW_ALLOCATE = 4'b1111;

`ifdef AE350_DMA_AXI_SUPPORT
input                          [ADDR_MSB:0] dmac0_araddr;
input                                 [1:0] dmac0_arburst;
input                                 [3:0] dmac0_arcache;
input                        [BIU_ID_MSB:0] dmac0_arid;
input                                 [7:0] dmac0_arlen;
input                                       dmac0_arlock;
input                                 [2:0] dmac0_arprot;
output                                      dmac0_arready;
input                                 [2:0] dmac0_arsize;
input                                       dmac0_arvalid;
input                          [ADDR_MSB:0] dmac0_awaddr;
input                                 [1:0] dmac0_awburst;
input                                 [3:0] dmac0_awcache;
input                        [BIU_ID_MSB:0] dmac0_awid;
input                                 [7:0] dmac0_awlen;
input                                       dmac0_awlock;
input                                 [2:0] dmac0_awprot;
output                                      dmac0_awready;
input                                 [2:0] dmac0_awsize;
input                                       dmac0_awvalid;
output                       [BIU_ID_MSB:0] dmac0_bid;
input                                       dmac0_bready;
output                                [1:0] dmac0_bresp;
output                                      dmac0_bvalid;
output                     [BIU_DATA_MSB:0] dmac0_rdata;
output                       [BIU_ID_MSB:0] dmac0_rid;
output                                      dmac0_rlast;
input                                       dmac0_rready;
output                                [1:0] dmac0_rresp;
output                                      dmac0_rvalid;
input                      [BIU_DATA_MSB:0] dmac0_wdata;
input                                       dmac0_wlast;
output                                      dmac0_wready;
input                     [BIU_WSTRB_MSB:0] dmac0_wstrb;
input                                       dmac0_wvalid;
`endif
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
output                     [BIU_ID_MSB+4:0] cpuslv_arid;
output                     [BIU_ID_MSB+4:0] cpuslv_awid;
input                      [BIU_ID_MSB+4:0] cpuslv_bid;
input                      [BIU_ID_MSB+4:0] cpuslv_rid;
output                         [ADDR_MSB:0] cpuslv_araddr;
output                                [1:0] cpuslv_arburst;
output                                [3:0] cpuslv_arcache;
output                                [7:0] cpuslv_arlen;
output                                      cpuslv_arlock;
output                                [2:0] cpuslv_arprot;
input                                       cpuslv_arready;
output                                [2:0] cpuslv_arsize;
output                                      cpuslv_arvalid;
output                         [ADDR_MSB:0] cpuslv_awaddr;
output                                [1:0] cpuslv_awburst;
output                                [3:0] cpuslv_awcache;
output                                [7:0] cpuslv_awlen;
output                                      cpuslv_awlock;
output                                [2:0] cpuslv_awprot;
input                                       cpuslv_awready;
output                                [2:0] cpuslv_awsize;
output                                      cpuslv_awvalid;
output                                      cpuslv_bready;
input                                 [1:0] cpuslv_bresp;
input                                       cpuslv_bvalid;
input            [(SLVPORT_DATA_WIDTH-1):0] cpuslv_rdata;
input                                       cpuslv_rlast;
output                                      cpuslv_rready;
input                                 [1:0] cpuslv_rresp;
input                                       cpuslv_rvalid;
output           [(SLVPORT_DATA_WIDTH-1):0] cpuslv_wdata;
output                                      cpuslv_wlast;
input                                       cpuslv_wready;
output       [((SLVPORT_DATA_WIDTH/8)-1):0] cpuslv_wstrb;
output                                      cpuslv_wvalid;
`endif
`ifdef NDS_IO_COHERENCE
output                                [3:0] iocp0_arcache;
output                                [3:0] iocp0_awcache;
output                         [ADDR_MSB:0] iocp0_araddr;
output                                [1:0] iocp0_arburst;
output                     [BIU_ID_MSB+4:0] iocp0_arid;
output                                [7:0] iocp0_arlen;
output                                      iocp0_arlock;
output                                [2:0] iocp0_arprot;
input                                       iocp0_arready;
output                                [2:0] iocp0_arsize;
output                                      iocp0_arvalid;
output                         [ADDR_MSB:0] iocp0_awaddr;
output                                [1:0] iocp0_awburst;
output                     [BIU_ID_MSB+4:0] iocp0_awid;
output                                [7:0] iocp0_awlen;
output                                      iocp0_awlock;
output                                [2:0] iocp0_awprot;
input                                       iocp0_awready;
output                                [2:0] iocp0_awsize;
output                                      iocp0_awvalid;
input                      [BIU_ID_MSB+4:0] iocp0_bid;
output                                      iocp0_bready;
input                                 [1:0] iocp0_bresp;
input                                       iocp0_bvalid;
input           [(`NDS_BIU_DATA_WIDTH-1):0] iocp0_rdata;
input                      [BIU_ID_MSB+4:0] iocp0_rid;
input                                       iocp0_rlast;
output                                      iocp0_rready;
input                                 [1:0] iocp0_rresp;
input                                       iocp0_rvalid;
output          [(`NDS_BIU_DATA_WIDTH-1):0] iocp0_wdata;
output                                      iocp0_wlast;
input                                       iocp0_wready;
output      [((`NDS_BIU_DATA_WIDTH/8)-1):0] iocp0_wstrb;
output                                      iocp0_wvalid;
`endif
   `ifdef NDS_IO_BIU_AXI_COMMON_X2
input                          [ADDR_MSB:0] cpu_d_araddr;
input                                 [1:0] cpu_d_arburst;
input                                 [3:0] cpu_d_arcache;
input                        [BIU_ID_MSB:0] cpu_d_arid;
input                                 [7:0] cpu_d_arlen;
input                                       cpu_d_arlock;
input                                 [2:0] cpu_d_arprot;
output                                      cpu_d_arready;
input                                 [2:0] cpu_d_arsize;
input                                       cpu_d_arvalid;
input                          [ADDR_MSB:0] cpu_d_awaddr;
input                                 [1:0] cpu_d_awburst;
input                                 [3:0] cpu_d_awcache;
input                        [BIU_ID_MSB:0] cpu_d_awid;
input                                 [7:0] cpu_d_awlen;
input                                       cpu_d_awlock;
input                                 [2:0] cpu_d_awprot;
output                                      cpu_d_awready;
input                                 [2:0] cpu_d_awsize;
input                                       cpu_d_awvalid;
output                       [BIU_ID_MSB:0] cpu_d_bid;
input                                       cpu_d_bready;
output                                [1:0] cpu_d_bresp;
output                                      cpu_d_bvalid;
output                     [BIU_DATA_MSB:0] cpu_d_rdata;
output                       [BIU_ID_MSB:0] cpu_d_rid;
output                                      cpu_d_rlast;
input                                       cpu_d_rready;
output                                [1:0] cpu_d_rresp;
output                                      cpu_d_rvalid;
input                      [BIU_DATA_MSB:0] cpu_d_wdata;
input                                       cpu_d_wlast;
output                                      cpu_d_wready;
input                     [BIU_WSTRB_MSB:0] cpu_d_wstrb;
input                                       cpu_d_wvalid;
input                          [ADDR_MSB:0] cpu_i_araddr;
input                                 [1:0] cpu_i_arburst;
input                                 [3:0] cpu_i_arcache;
input                        [BIU_ID_MSB:0] cpu_i_arid;
input                                 [7:0] cpu_i_arlen;
input                                       cpu_i_arlock;
input                                 [2:0] cpu_i_arprot;
output                                      cpu_i_arready;
input                                 [2:0] cpu_i_arsize;
input                                       cpu_i_arvalid;
input                          [ADDR_MSB:0] cpu_i_awaddr;
input                                 [1:0] cpu_i_awburst;
input                                 [3:0] cpu_i_awcache;
input                        [BIU_ID_MSB:0] cpu_i_awid;
input                                 [7:0] cpu_i_awlen;
input                                       cpu_i_awlock;
input                                 [2:0] cpu_i_awprot;
output                                      cpu_i_awready;
input                                 [2:0] cpu_i_awsize;
input                                       cpu_i_awvalid;
output                       [BIU_ID_MSB:0] cpu_i_bid;
input                                       cpu_i_bready;
output                                [1:0] cpu_i_bresp;
output                                      cpu_i_bvalid;
output                     [BIU_DATA_MSB:0] cpu_i_rdata;
output                       [BIU_ID_MSB:0] cpu_i_rid;
output                                      cpu_i_rlast;
input                                       cpu_i_rready;
output                                [1:0] cpu_i_rresp;
output                                      cpu_i_rvalid;
input                      [BIU_DATA_MSB:0] cpu_i_wdata;
input                                       cpu_i_wlast;
output                                      cpu_i_wready;
input                     [BIU_WSTRB_MSB:0] cpu_i_wstrb;
input                                       cpu_i_wvalid;
   `else
input                          [ADDR_MSB:0] cpu_araddr;
input                                 [1:0] cpu_arburst;
input                                 [3:0] cpu_arcache;
input                        [BIU_ID_MSB:0] cpu_arid;
input                                 [7:0] cpu_arlen;
input                                       cpu_arlock;
input                                 [2:0] cpu_arprot;
output                                      cpu_arready;
input                                 [2:0] cpu_arsize;
input                                       cpu_arvalid;
input                          [ADDR_MSB:0] cpu_awaddr;
input                                 [1:0] cpu_awburst;
input                                 [3:0] cpu_awcache;
input                        [BIU_ID_MSB:0] cpu_awid;
input                                 [7:0] cpu_awlen;
input                                       cpu_awlock;
input                                 [2:0] cpu_awprot;
output                                      cpu_awready;
input                                 [2:0] cpu_awsize;
input                                       cpu_awvalid;
output                       [BIU_ID_MSB:0] cpu_bid;
input                                       cpu_bready;
output                                [1:0] cpu_bresp;
output                                      cpu_bvalid;
output                     [BIU_DATA_MSB:0] cpu_rdata;
output                       [BIU_ID_MSB:0] cpu_rid;
output                                      cpu_rlast;
input                                       cpu_rready;
output                                [1:0] cpu_rresp;
output                                      cpu_rvalid;
input                      [BIU_DATA_MSB:0] cpu_wdata;
input                                       cpu_wlast;
output                                      cpu_wready;
input                     [BIU_WSTRB_MSB:0] cpu_wstrb;
input                                       cpu_wvalid;
   `endif

`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input                          [ADDR_MSB:0] dmac1_araddr;
input                                 [1:0] dmac1_arburst;
input                                 [3:0] dmac1_arcache;
input                        [BIU_ID_MSB:0] dmac1_arid;
input                                 [7:0] dmac1_arlen;
input                                       dmac1_arlock;
input                                 [2:0] dmac1_arprot;
output                                      dmac1_arready;
input                                 [2:0] dmac1_arsize;
input                                       dmac1_arvalid;
input                          [ADDR_MSB:0] dmac1_awaddr;
input                                 [1:0] dmac1_awburst;
input                                 [3:0] dmac1_awcache;
input                        [BIU_ID_MSB:0] dmac1_awid;
input                                 [7:0] dmac1_awlen;
input                                       dmac1_awlock;
input                                 [2:0] dmac1_awprot;
output                                      dmac1_awready;
input                                 [2:0] dmac1_awsize;
input                                       dmac1_awvalid;
output                       [BIU_ID_MSB:0] dmac1_bid;
input                                       dmac1_bready;
output                                [1:0] dmac1_bresp;
output                                      dmac1_bvalid;
output                     [BIU_DATA_MSB:0] dmac1_rdata;
output                       [BIU_ID_MSB:0] dmac1_rid;
output                                      dmac1_rlast;
input                                       dmac1_rready;
output                                [1:0] dmac1_rresp;
output                                      dmac1_rvalid;
input                      [BIU_DATA_MSB:0] dmac1_wdata;
input                                       dmac1_wlast;
output                                      dmac1_wready;
input                     [BIU_WSTRB_MSB:0] dmac1_wstrb;
input                                       dmac1_wvalid;
   `endif
`endif
`ifdef PLATFORM_DEBUG_PORT
   `ifdef PLATFORM_PLDM_SYS_BUS_ACCESS
input                          [ADDR_MSB:0] dm_sys_araddr;
input                                 [1:0] dm_sys_arburst;
input                                 [3:0] dm_sys_arcache;
input                        [BIU_ID_MSB:0] dm_sys_arid;
input                                 [7:0] dm_sys_arlen;
input                                       dm_sys_arlock;
input                                 [2:0] dm_sys_arprot;
output                                      dm_sys_arready;
input                                 [2:0] dm_sys_arsize;
input                                       dm_sys_arvalid;
input                          [ADDR_MSB:0] dm_sys_awaddr;
input                                 [1:0] dm_sys_awburst;
input                                 [3:0] dm_sys_awcache;
input                        [BIU_ID_MSB:0] dm_sys_awid;
input                                 [7:0] dm_sys_awlen;
input                                       dm_sys_awlock;
input                                 [2:0] dm_sys_awprot;
output                                      dm_sys_awready;
input                                 [2:0] dm_sys_awsize;
input                                       dm_sys_awvalid;
output                       [BIU_ID_MSB:0] dm_sys_bid;
input                                       dm_sys_bready;
output                                [1:0] dm_sys_bresp;
output                                      dm_sys_bvalid;
output                     [BIU_DATA_MSB:0] dm_sys_rdata;
output                       [BIU_ID_MSB:0] dm_sys_rid;
output                                      dm_sys_rlast;
input                                       dm_sys_rready;
output                                [1:0] dm_sys_rresp;
output                                      dm_sys_rvalid;
input                      [BIU_DATA_MSB:0] dm_sys_wdata;
input                                       dm_sys_wlast;
output                                      dm_sys_wready;
input                     [BIU_WSTRB_MSB:0] dm_sys_wstrb;
input                                       dm_sys_wvalid;
   `endif
`endif
output                         [ADDR_MSB:0] hbmc_haddr;
output                                [2:0] hbmc_hburst;
output                                [3:0] hbmc_hprot;
input                                [31:0] hbmc_hrdata;
output                                      hbmc_hready;
input                                       hbmc_hreadyout;
input                                 [1:0] hbmc_hresp;
output                                      hbmc_hsel;
output                                [2:0] hbmc_hsize;
output                                [1:0] hbmc_htrans;
output                               [31:0] hbmc_hwdata;
output                                      hbmc_hwrite;
output                         [ADDR_MSB:0] rom_haddr;
output                                [2:0] rom_hburst;
output                                [3:0] rom_hprot;
input                                [31:0] rom_hrdata;
output                                      rom_hready;
input                                       rom_hreadyout;
input                                       rom_hresp;
output                                      rom_hsel;
output                                [2:0] rom_hsize;
output                                [1:0] rom_htrans;
output                               [31:0] rom_hwdata;
output                                      rom_hwrite;
input                                       hclk;
input                                       hresetn;
input                                       aclk;
input                                       aresetn;
output                         [ADDR_MSB:0] ram_araddr;
output                                [1:0] ram_arburst;
output                                [3:0] ram_arcache;
output                     [BIU_ID_MSB+4:0] ram_arid;
output                                [7:0] ram_arlen;
output                                      ram_arlock;
output                                [2:0] ram_arprot;
input                                       ram_arready;
output                                [2:0] ram_arsize;
output                                      ram_arvalid;
output                         [ADDR_MSB:0] ram_awaddr;
output                                [1:0] ram_awburst;
output                                [3:0] ram_awcache;
output                     [BIU_ID_MSB+4:0] ram_awid;
output                                [7:0] ram_awlen;
output                                      ram_awlock;
output                                [2:0] ram_awprot;
input                                       ram_awready;
output                                [2:0] ram_awsize;
output                                      ram_awvalid;
input                      [BIU_ID_MSB+4:0] ram_bid;
output                                      ram_bready;
input                                 [1:0] ram_bresp;
input                                       ram_bvalid;
input                      [BIU_DATA_MSB:0] ram_rdata;
input                      [BIU_ID_MSB+4:0] ram_rid;
input                                       ram_rlast;
output                                      ram_rready;
input                                 [1:0] ram_rresp;
input                                       ram_rvalid;
output                     [BIU_DATA_MSB:0] ram_wdata;
output                                      ram_wlast;
input                                       ram_wready;
output                    [BIU_WSTRB_MSB:0] ram_wstrb;
output                                      ram_wvalid;

`ifdef AE350_DMA_AXI_SUPPORT
wire                           [ADDR_MSB:0] dmac0_sys_araddr;
wire                                  [1:0] dmac0_sys_arburst;
wire                                  [3:0] dmac0_sys_arcache;
wire                         [BIU_ID_MSB:0] dmac0_sys_arid;
wire                                  [7:0] dmac0_sys_arlen;
wire                                        dmac0_sys_arlock;
wire                                  [2:0] dmac0_sys_arprot;
wire                                  [2:0] dmac0_sys_arsize;
wire                                        dmac0_sys_arvalid;
wire                           [ADDR_MSB:0] dmac0_sys_awaddr;
wire                                  [1:0] dmac0_sys_awburst;
wire                                  [3:0] dmac0_sys_awcache;
wire                         [BIU_ID_MSB:0] dmac0_sys_awid;
wire                                  [7:0] dmac0_sys_awlen;
wire                                        dmac0_sys_awlock;
wire                                  [2:0] dmac0_sys_awprot;
wire                                  [2:0] dmac0_sys_awsize;
wire                                        dmac0_sys_awvalid;
wire                                        dmac0_sys_bready;
wire                                        dmac0_sys_rready;
wire                       [BIU_DATA_MSB:0] dmac0_sys_wdata;
wire                                        dmac0_sys_wlast;
wire                      [BIU_WSTRB_MSB:0] dmac0_sys_wstrb;
wire                                        dmac0_sys_wvalid;
wire                                        dmac0_sys_arready;
wire                                        dmac0_sys_awready;
wire                         [BIU_ID_MSB:0] dmac0_sys_bid;
wire                                  [1:0] dmac0_sys_bresp;
wire                                        dmac0_sys_bvalid;
wire                       [BIU_DATA_MSB:0] dmac0_sys_rdata;
wire                         [BIU_ID_MSB:0] dmac0_sys_rid;
wire                                        dmac0_sys_rlast;
wire                                  [1:0] dmac0_sys_rresp;
wire                                        dmac0_sys_rvalid;
wire                                        dmac0_sys_wready;
`endif
`ifdef NDS_IO_SLAVEPORT_COMMON_X1
wire                     [(ADDR_WIDTH-1):0] sys2slv_araddr;
wire                                  [1:0] sys2slv_arburst;
wire                                  [3:0] sys2slv_arcache;
wire               [((BIU_ID_WIDTH+4)-1):0] sys2slv_arid;
wire                                  [7:0] sys2slv_arlen;
wire                                        sys2slv_arlock;
wire                                  [2:0] sys2slv_arprot;
wire                                  [2:0] sys2slv_arsize;
wire                                        sys2slv_arvalid;
wire                     [(ADDR_WIDTH-1):0] sys2slv_awaddr;
wire                                  [1:0] sys2slv_awburst;
wire                                  [3:0] sys2slv_awcache;
wire               [((BIU_ID_WIDTH+4)-1):0] sys2slv_awid;
wire                                  [7:0] sys2slv_awlen;
wire                                        sys2slv_awlock;
wire                                  [2:0] sys2slv_awprot;
wire                                  [2:0] sys2slv_awsize;
wire                                        sys2slv_awvalid;
wire                                        sys2slv_bready;
wire                                        sys2slv_rready;
wire                 [(BIU_DATA_WIDTH-1):0] sys2slv_wdata;
wire                                        sys2slv_wlast;
wire               [(BIU_DATA_WIDTH/8)-1:0] sys2slv_wstrb;
wire                                        sys2slv_wvalid;
wire                                        sys2slv_arready;
wire                                        sys2slv_awready;
wire               [((BIU_ID_WIDTH+4)-1):0] sys2slv_bid;
wire                                  [1:0] sys2slv_bresp;
wire                                        sys2slv_bvalid;
wire                 [(BIU_DATA_WIDTH-1):0] sys2slv_rdata;
wire               [((BIU_ID_WIDTH+4)-1):0] sys2slv_rid;
wire                                        sys2slv_rlast;
wire                                  [1:0] sys2slv_rresp;
wire                                        sys2slv_rvalid;
wire                                        sys2slv_wready;
`endif
`ifdef AE350_DMA_AXI_SUPPORT
   `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
wire                           [ADDR_MSB:0] dmac1_sys_araddr;
wire                                  [1:0] dmac1_sys_arburst;
wire                                  [3:0] dmac1_sys_arcache;
wire                         [BIU_ID_MSB:0] dmac1_sys_arid;
wire                                  [7:0] dmac1_sys_arlen;
wire                                        dmac1_sys_arlock;
wire                                  [2:0] dmac1_sys_arprot;
wire                                  [2:0] dmac1_sys_arsize;
wire                                        dmac1_sys_arvalid;
wire                           [ADDR_MSB:0] dmac1_sys_awaddr;
wire                                  [1:0] dmac1_sys_awburst;
wire                                  [3:0] dmac1_sys_awcache;
wire                         [BIU_ID_MSB:0] dmac1_sys_awid;
wire                                  [7:0] dmac1_sys_awlen;
wire                                        dmac1_sys_awlock;
wire                                  [2:0] dmac1_sys_awprot;
wire                                  [2:0] dmac1_sys_awsize;
wire                                        dmac1_sys_awvalid;
wire                                        dmac1_sys_bready;
wire                                        dmac1_sys_rready;
wire                       [BIU_DATA_MSB:0] dmac1_sys_wdata;
wire                                        dmac1_sys_wlast;
wire                      [BIU_WSTRB_MSB:0] dmac1_sys_wstrb;
wire                                        dmac1_sys_wvalid;
wire                                        dmac1_sys_arready;
wire                                        dmac1_sys_awready;
wire                         [BIU_ID_MSB:0] dmac1_sys_bid;
wire                                  [1:0] dmac1_sys_bresp;
wire                                        dmac1_sys_bvalid;
wire                       [BIU_DATA_MSB:0] dmac1_sys_rdata;
wire                         [BIU_ID_MSB:0] dmac1_sys_rid;
wire                                        dmac1_sys_rlast;
wire                                  [1:0] dmac1_sys_rresp;
wire                                        dmac1_sys_rvalid;
wire                                        dmac1_sys_wready;
   `endif
`endif
`ifdef NDS_IO_COHERENCE
   `ifdef ATCBMC300_SLV5_SUPPORT
wire                                  [3:0] nds_unused_iocp0_arcache;
wire                                  [3:0] nds_unused_iocp0_awcache;
   `endif
`endif
wire                   [ROMHBMC_DATA_MSB:0] hbmc2sys_hrdata;
wire                                        hbmc2sys_hready;
wire                                  [1:0] hbmc2sys_hresp;
wire                   [ROMHBMC_DATA_MSB:0] rom2sys_hrdata;
wire                                        rom2sys_hready;
wire                                  [1:0] rom2sys_hresp;
wire                                        sys2hbmc_hready;
wire                                        sys2hbmc_hsel;
wire                                        sys2rom_hready;
wire                                        sys2rom_hsel;
wire                       [BIU_ID_MSB+4:0] x2h_hbmc_arid;
wire                       [BIU_ID_MSB+4:0] x2h_hbmc_awid;
wire                       [BIU_ID_MSB+4:0] x2h_rom_arid;
wire                       [BIU_ID_MSB+4:0] x2h_rom_awid;
wire                           [ADDR_MSB:0] sys2hbmc_haddr;
wire                                  [2:0] sys2hbmc_hburst;
wire                                  [3:0] sys2hbmc_hprot;
wire                                  [2:0] sys2hbmc_hsize;
wire                                  [1:0] sys2hbmc_htrans;
wire                   [ROMHBMC_DATA_MSB:0] sys2hbmc_hwdata;
wire                                        sys2hbmc_hwrite;
wire                                        x2h_hbmc_arready;
wire                                        x2h_hbmc_awready;
wire                       [BIU_ID_MSB+4:0] x2h_hbmc_bid;
wire                                  [1:0] x2h_hbmc_bresp;
wire                                        x2h_hbmc_bvalid;
wire                                 [31:0] x2h_hbmc_rdata;
wire                       [BIU_ID_MSB+4:0] x2h_hbmc_rid;
wire                                        x2h_hbmc_rlast;
wire                                  [1:0] x2h_hbmc_rresp;
wire                                        x2h_hbmc_rvalid;
wire                                        x2h_hbmc_wready;
wire                           [ADDR_MSB:0] sys2rom_haddr;
wire                                  [2:0] sys2rom_hburst;
wire                                  [3:0] sys2rom_hprot;
wire                                  [2:0] sys2rom_hsize;
wire                                  [1:0] sys2rom_htrans;
wire                   [ROMHBMC_DATA_MSB:0] sys2rom_hwdata;
wire                                        sys2rom_hwrite;
wire                                        x2h_rom_arready;
wire                                        x2h_rom_awready;
wire                       [BIU_ID_MSB+4:0] x2h_rom_bid;
wire                                  [1:0] x2h_rom_bresp;
wire                                        x2h_rom_bvalid;
wire                                 [31:0] x2h_rom_rdata;
wire                       [BIU_ID_MSB+4:0] x2h_rom_rid;
wire                                        x2h_rom_rlast;
wire                                  [1:0] x2h_rom_rresp;
wire                                        x2h_rom_rvalid;
wire                                        x2h_rom_wready;
wire                                        sys2hbmc_arready;
wire                                        sys2hbmc_awready;
wire                       [BIU_ID_MSB+4:0] sys2hbmc_bid;
wire                                  [1:0] sys2hbmc_bresp;
wire                                        sys2hbmc_bvalid;
wire                       [BIU_DATA_MSB:0] sys2hbmc_rdata;
wire                       [BIU_ID_MSB+4:0] sys2hbmc_rid;
wire                                        sys2hbmc_rlast;
wire                                  [1:0] sys2hbmc_rresp;
wire                                        sys2hbmc_rvalid;
wire                                        sys2hbmc_wready;
wire                           [ADDR_MSB:0] x2h_hbmc_araddr;
wire                                  [1:0] x2h_hbmc_arburst;
wire                                  [3:0] x2h_hbmc_arcache;
wire                                  [7:0] x2h_hbmc_arlen;
wire                                        x2h_hbmc_arlock;
wire                                  [2:0] x2h_hbmc_arprot;
wire                                  [2:0] x2h_hbmc_arsize;
wire                                        x2h_hbmc_arvalid;
wire                           [ADDR_MSB:0] x2h_hbmc_awaddr;
wire                                  [1:0] x2h_hbmc_awburst;
wire                                  [3:0] x2h_hbmc_awcache;
wire                                  [7:0] x2h_hbmc_awlen;
wire                                        x2h_hbmc_awlock;
wire                                  [2:0] x2h_hbmc_awprot;
wire                                  [2:0] x2h_hbmc_awsize;
wire                                        x2h_hbmc_awvalid;
wire                                        x2h_hbmc_bready;
wire                                        x2h_hbmc_rready;
wire                                 [31:0] x2h_hbmc_wdata;
wire                                        x2h_hbmc_wlast;
wire                                  [3:0] x2h_hbmc_wstrb;
wire                                        x2h_hbmc_wvalid;
wire                                        sys2rom_arready;
wire                                        sys2rom_awready;
wire                       [BIU_ID_MSB+4:0] sys2rom_bid;
wire                                  [1:0] sys2rom_bresp;
wire                                        sys2rom_bvalid;
wire                       [BIU_DATA_MSB:0] sys2rom_rdata;
wire                       [BIU_ID_MSB+4:0] sys2rom_rid;
wire                                        sys2rom_rlast;
wire                                  [1:0] sys2rom_rresp;
wire                                        sys2rom_rvalid;
wire                                        sys2rom_wready;
wire                           [ADDR_MSB:0] x2h_rom_araddr;
wire                                  [1:0] x2h_rom_arburst;
wire                                  [3:0] x2h_rom_arcache;
wire                                  [7:0] x2h_rom_arlen;
wire                                        x2h_rom_arlock;
wire                                  [2:0] x2h_rom_arprot;
wire                                  [2:0] x2h_rom_arsize;
wire                                        x2h_rom_arvalid;
wire                           [ADDR_MSB:0] x2h_rom_awaddr;
wire                                  [1:0] x2h_rom_awburst;
wire                                  [3:0] x2h_rom_awcache;
wire                                  [7:0] x2h_rom_awlen;
wire                                        x2h_rom_awlock;
wire                                  [2:0] x2h_rom_awprot;
wire                                  [2:0] x2h_rom_awsize;
wire                                        x2h_rom_awvalid;
wire                                        x2h_rom_bready;
wire                                        x2h_rom_rready;
wire                                 [31:0] x2h_rom_wdata;
wire                                        x2h_rom_wlast;
wire                                  [3:0] x2h_rom_wstrb;
wire                                        x2h_rom_wvalid;
wire                           [ADDR_MSB:0] sys2hbmc_araddr;
wire                                  [1:0] sys2hbmc_arburst;
wire                                  [3:0] sys2hbmc_arcache;
wire                       [BIU_ID_MSB+4:0] sys2hbmc_arid;
wire                                  [7:0] sys2hbmc_arlen;
wire                                        sys2hbmc_arlock;
wire                                  [2:0] sys2hbmc_arprot;
wire                                  [2:0] sys2hbmc_arsize;
wire                                        sys2hbmc_arvalid;
wire                           [ADDR_MSB:0] sys2hbmc_awaddr;
wire                                  [1:0] sys2hbmc_awburst;
wire                                  [3:0] sys2hbmc_awcache;
wire                       [BIU_ID_MSB+4:0] sys2hbmc_awid;
wire                                  [7:0] sys2hbmc_awlen;
wire                                        sys2hbmc_awlock;
wire                                  [2:0] sys2hbmc_awprot;
wire                                  [2:0] sys2hbmc_awsize;
wire                                        sys2hbmc_awvalid;
wire                                        sys2hbmc_bready;
wire                                        sys2hbmc_rready;
wire                       [BIU_DATA_MSB:0] sys2hbmc_wdata;
wire                                        sys2hbmc_wlast;
wire                      [BIU_WSTRB_MSB:0] sys2hbmc_wstrb;
wire                                        sys2hbmc_wvalid;
wire                           [ADDR_MSB:0] sys2rom_araddr;
wire                                  [1:0] sys2rom_arburst;
wire                                  [3:0] sys2rom_arcache;
wire                       [BIU_ID_MSB+4:0] sys2rom_arid;
wire                                  [7:0] sys2rom_arlen;
wire                                        sys2rom_arlock;
wire                                  [2:0] sys2rom_arprot;
wire                                  [2:0] sys2rom_arsize;
wire                                        sys2rom_arvalid;
wire                           [ADDR_MSB:0] sys2rom_awaddr;
wire                                  [1:0] sys2rom_awburst;
wire                                  [3:0] sys2rom_awcache;
wire                       [BIU_ID_MSB+4:0] sys2rom_awid;
wire                                  [7:0] sys2rom_awlen;
wire                                        sys2rom_awlock;
wire                                  [2:0] sys2rom_awprot;
wire                                  [2:0] sys2rom_awsize;
wire                                        sys2rom_awvalid;
wire                                        sys2rom_bready;
wire                                        sys2rom_rready;
wire                       [BIU_DATA_MSB:0] sys2rom_wdata;
wire                                        sys2rom_wlast;
wire                      [BIU_WSTRB_MSB:0] sys2rom_wstrb;
wire                                        sys2rom_wvalid;















	generate
	if (BIU_DATA_WIDTH > 32) begin: gen_x2h_sizedn_connection
		assign x2h_hbmc_arid    = sys2hbmc_arid;
		assign x2h_hbmc_awid    = sys2hbmc_awid;

		assign x2h_rom_arid    = sys2rom_arid;
		assign x2h_rom_awid    = sys2rom_awid;
	end
	else begin: gen_x2h_sys_connection
		assign x2h_hbmc_araddr  = sys2hbmc_araddr;
		assign x2h_hbmc_arburst = sys2hbmc_arburst;
		assign x2h_hbmc_arcache = sys2hbmc_arcache;
		assign x2h_hbmc_arid    = sys2hbmc_arid;
		assign x2h_hbmc_arlen   = sys2hbmc_arlen;
		assign x2h_hbmc_arlock  = sys2hbmc_arlock;
		assign x2h_hbmc_arprot  = sys2hbmc_arprot;
		assign x2h_hbmc_arsize  = sys2hbmc_arsize;
		assign x2h_hbmc_arvalid = sys2hbmc_arvalid;
		assign sys2hbmc_arready = x2h_hbmc_arready;

		assign x2h_hbmc_awaddr  = sys2hbmc_awaddr;
		assign x2h_hbmc_awburst = sys2hbmc_awburst;
		assign x2h_hbmc_awcache = sys2hbmc_awcache;
		assign x2h_hbmc_awid    = sys2hbmc_awid;
		assign x2h_hbmc_awlen   = sys2hbmc_awlen;
		assign x2h_hbmc_awlock  = sys2hbmc_awlock;
		assign x2h_hbmc_awprot  = sys2hbmc_awprot;
		assign x2h_hbmc_awsize  = sys2hbmc_awsize;
		assign x2h_hbmc_awvalid = sys2hbmc_awvalid;
		assign sys2hbmc_awready = x2h_hbmc_awready;

		assign sys2hbmc_bid    = x2h_hbmc_bid;
		assign sys2hbmc_bresp  = x2h_hbmc_bresp;
		assign sys2hbmc_bvalid = x2h_hbmc_bvalid;
		assign x2h_hbmc_bready = sys2hbmc_bready;

		assign sys2hbmc_rdata  = x2h_hbmc_rdata;
		assign sys2hbmc_rid    = x2h_hbmc_rid;
		assign sys2hbmc_rlast  = x2h_hbmc_rlast;
		assign sys2hbmc_rresp  = x2h_hbmc_rresp;
		assign sys2hbmc_rvalid = x2h_hbmc_rvalid;
		assign x2h_hbmc_rready = sys2hbmc_rready;

		assign x2h_hbmc_wdata  = sys2hbmc_wdata;
		assign x2h_hbmc_wlast  = sys2hbmc_wlast;
		assign x2h_hbmc_wstrb  = sys2hbmc_wstrb;
		assign x2h_hbmc_wvalid = sys2hbmc_wvalid;
		assign sys2hbmc_wready = x2h_hbmc_wready;

		assign x2h_rom_araddr  = sys2rom_araddr;
		assign x2h_rom_arburst = sys2rom_arburst;
		assign x2h_rom_arcache = sys2rom_arcache;
		assign x2h_rom_arid    = sys2rom_arid;
		assign x2h_rom_arlen   = sys2rom_arlen;
		assign x2h_rom_arlock  = sys2rom_arlock;
		assign x2h_rom_arprot  = sys2rom_arprot;
		assign x2h_rom_arsize  = sys2rom_arsize;
		assign x2h_rom_arvalid = sys2rom_arvalid;
		assign sys2rom_arready = x2h_rom_arready;

		assign x2h_rom_awaddr  = sys2rom_awaddr;
		assign x2h_rom_awburst = sys2rom_awburst;
		assign x2h_rom_awcache = sys2rom_awcache;
		assign x2h_rom_awid    = sys2rom_awid;
		assign x2h_rom_awlen   = sys2rom_awlen;
		assign x2h_rom_awlock  = sys2rom_awlock;
		assign x2h_rom_awprot  = sys2rom_awprot;
		assign x2h_rom_awsize  = sys2rom_awsize;
		assign x2h_rom_awvalid = sys2rom_awvalid;
		assign sys2rom_awready = x2h_rom_awready;

		assign sys2rom_bid    = x2h_rom_bid;
		assign sys2rom_bresp  = x2h_rom_bresp;
		assign sys2rom_bvalid = x2h_rom_bvalid;
		assign x2h_rom_bready = sys2rom_bready;

		assign sys2rom_rdata  = x2h_rom_rdata;
		assign sys2rom_rid    = x2h_rom_rid;
		assign sys2rom_rlast  = x2h_rom_rlast;
		assign sys2rom_rresp  = x2h_rom_rresp;
		assign sys2rom_rvalid = x2h_rom_rvalid;
		assign x2h_rom_rready = sys2rom_rready;

		assign x2h_rom_wdata  = sys2rom_wdata;
		assign x2h_rom_wlast  = sys2rom_wlast;
		assign x2h_rom_wstrb  = sys2rom_wstrb;
		assign x2h_rom_wvalid = sys2rom_wvalid;
		assign sys2rom_wready = x2h_rom_wready;
	end
	endgenerate

	`ifdef AE350_DMA_AXI_SUPPORT
		assign dmac0_sys_araddr  = dmac0_araddr;
		assign dmac0_sys_arburst = dmac0_arburst;
		assign dmac0_sys_arcache = dmac0_arcache;
		assign dmac0_sys_arid    = dmac0_arid;
		assign dmac0_sys_arlen   = dmac0_arlen;
		assign dmac0_sys_arlock  = dmac0_arlock;
		assign dmac0_sys_arprot  = dmac0_arprot;
		assign dmac0_sys_arsize  = dmac0_arsize;
		assign dmac0_sys_arvalid = dmac0_arvalid;
		assign dmac0_arready = dmac0_sys_arready;

		assign dmac0_sys_awaddr  = dmac0_awaddr;
		assign dmac0_sys_awburst = dmac0_awburst;
		assign dmac0_sys_awcache = dmac0_awcache;
		assign dmac0_sys_awid    = dmac0_awid;
		assign dmac0_sys_awlen   = dmac0_awlen;
		assign dmac0_sys_awlock  = dmac0_awlock;
		assign dmac0_sys_awprot  = dmac0_awprot;
		assign dmac0_sys_awsize  = dmac0_awsize;
		assign dmac0_sys_awvalid = dmac0_awvalid;
		assign dmac0_awready = dmac0_sys_awready;

		assign dmac0_bid    = dmac0_sys_bid;
		assign dmac0_bresp  = dmac0_sys_bresp;
		assign dmac0_bvalid = dmac0_sys_bvalid;
		assign dmac0_sys_bready = dmac0_bready;

		assign dmac0_rdata  = dmac0_sys_rdata;
		assign dmac0_rid    = dmac0_sys_rid;
		assign dmac0_rlast  = dmac0_sys_rlast;
		assign dmac0_rresp  = dmac0_sys_rresp;
		assign dmac0_rvalid = dmac0_sys_rvalid;
		assign dmac0_sys_rready = dmac0_rready;

		assign dmac0_sys_wdata  = dmac0_wdata;
		assign dmac0_sys_wlast  = dmac0_wlast;
		assign dmac0_sys_wstrb  = dmac0_wstrb;
		assign dmac0_sys_wvalid = dmac0_wvalid;
		assign dmac0_wready = dmac0_sys_wready;
		`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
			assign dmac1_sys_araddr  = dmac1_araddr;
			assign dmac1_sys_arburst = dmac1_arburst;
			assign dmac1_sys_arcache = dmac1_arcache;
			assign dmac1_sys_arid    = dmac1_arid;
			assign dmac1_sys_arlen   = dmac1_arlen;
			assign dmac1_sys_arlock  = dmac1_arlock;
			assign dmac1_sys_arprot  = dmac1_arprot;
			assign dmac1_sys_arsize  = dmac1_arsize;
			assign dmac1_sys_arvalid = dmac1_arvalid;
			assign dmac1_arready = dmac1_sys_arready;

			assign dmac1_sys_awaddr  = dmac1_awaddr;
			assign dmac1_sys_awburst = dmac1_awburst;
			assign dmac1_sys_awcache = dmac1_awcache;
			assign dmac1_sys_awid    = dmac1_awid;
			assign dmac1_sys_awlen   = dmac1_awlen;
			assign dmac1_sys_awlock  = dmac1_awlock;
			assign dmac1_sys_awprot  = dmac1_awprot;
			assign dmac1_sys_awsize  = dmac1_awsize;
			assign dmac1_sys_awvalid = dmac1_awvalid;
			assign dmac1_awready = dmac1_sys_awready;

			assign dmac1_bid    = dmac1_sys_bid;
			assign dmac1_bresp  = dmac1_sys_bresp;
			assign dmac1_bvalid = dmac1_sys_bvalid;
			assign dmac1_sys_bready = dmac1_bready;

			assign dmac1_rdata  = dmac1_sys_rdata;
			assign dmac1_rid    = dmac1_sys_rid;
			assign dmac1_rlast  = dmac1_sys_rlast;
			assign dmac1_rresp  = dmac1_sys_rresp;
			assign dmac1_rvalid = dmac1_sys_rvalid;
			assign dmac1_sys_rready = dmac1_rready;

			assign dmac1_sys_wdata  = dmac1_wdata;
			assign dmac1_sys_wlast  = dmac1_wlast;
			assign dmac1_sys_wstrb  = dmac1_wstrb;
			assign dmac1_sys_wvalid = dmac1_wvalid;
			assign dmac1_wready = dmac1_sys_wready;
		`endif
	`endif


generate
if (BIU_DATA_WIDTH > 32 && SYSTEM_BUS_TYPE == "ahb") begin: gen_connect_hbmc_ahb_sdn
end
else begin: gen_connect_hbmc_ahb
	assign hbmc_haddr  = sys2hbmc_haddr;
	assign hbmc_hburst = sys2hbmc_hburst;
	assign hbmc_hprot  = sys2hbmc_hprot;
	assign hbmc_hsize  = sys2hbmc_hsize;
	assign hbmc_htrans = sys2hbmc_htrans;
	assign hbmc_hwrite = sys2hbmc_hwrite;
	assign hbmc_hwdata = sys2hbmc_hwdata;
	assign hbmc_hready = sys2hbmc_hready;
	assign hbmc_hsel   = sys2hbmc_hsel;
	assign hbmc2sys_hready	= hbmc_hreadyout;
	assign hbmc2sys_hresp	= hbmc_hresp;
	assign hbmc2sys_hrdata	= hbmc_hrdata;
end
endgenerate
assign sys2hbmc_hsel = 1'b1;
generate
if (BIU_DATA_WIDTH > 32 && SYSTEM_BUS_TYPE == "ahb") begin: gen_connect_rom_ahb_sdn
end
else begin: gen_connect_rom_ahb
	assign rom_haddr  = sys2rom_haddr;
	assign rom_hburst = sys2rom_hburst;
	assign rom_hprot  = sys2rom_hprot;
	assign rom_hsize  = sys2rom_hsize;
	assign rom_htrans = sys2rom_htrans;
	assign rom_hwrite = sys2rom_hwrite;
	assign rom_hwdata = sys2rom_hwdata;
	assign rom_hready = sys2rom_hready;
	assign rom_hsel = sys2rom_hsel;
	assign rom2sys_hready = rom_hreadyout;
	assign rom2sys_hresp  = {1'b0, rom_hresp};
	assign rom2sys_hrdata = rom_hrdata;
end
endgenerate
assign sys2rom_hready = rom2sys_hready;
assign sys2rom_hsel   = 1'b1;
assign sys2hbmc_hready = hbmc2sys_hready;

`ifdef NDS_IO_SLAVEPORT_COMMON_X1
	generate
	if (BIU_DATA_WIDTH > SLVPORT_DATA_WIDTH) begin: gen_connect_axi_slvport_sdn
		assign cpuslv_arid = sys2slv_arid;
		assign cpuslv_awid = sys2slv_awid;
	end
	else begin: gen_connect_axi_slvport
			assign cpuslv_araddr   = sys2slv_araddr;
			assign cpuslv_arburst  = sys2slv_arburst;
			assign cpuslv_arcache  = sys2slv_arcache;
			assign cpuslv_arid     = sys2slv_arid;
			assign cpuslv_arlen    = sys2slv_arlen;
			assign cpuslv_arlock   = sys2slv_arlock;
			assign cpuslv_arprot   = sys2slv_arprot;
			assign cpuslv_arsize   = sys2slv_arsize;
			assign cpuslv_arvalid  = sys2slv_arvalid;
			assign sys2slv_arready = cpuslv_arready;

			assign cpuslv_awaddr   = sys2slv_awaddr;
			assign cpuslv_awburst  = sys2slv_awburst;
			assign cpuslv_awcache  = sys2slv_awcache;
			assign cpuslv_awid     = sys2slv_awid;
			assign cpuslv_awlen    = sys2slv_awlen;
			assign cpuslv_awlock   = sys2slv_awlock;
			assign cpuslv_awprot   = sys2slv_awprot;
			assign cpuslv_awsize   = sys2slv_awsize;
			assign cpuslv_awvalid  = sys2slv_awvalid;
			assign sys2slv_awready = cpuslv_awready;

			assign sys2slv_bid     = cpuslv_bid;
			assign sys2slv_bresp   = cpuslv_bresp;
			assign sys2slv_bvalid  = cpuslv_bvalid;
			assign cpuslv_bready   = sys2slv_bready;

			assign sys2slv_rdata   = cpuslv_rdata;
			assign sys2slv_rid     = cpuslv_rid;
			assign sys2slv_rlast   = cpuslv_rlast;
			assign sys2slv_rresp   = cpuslv_rresp;
			assign sys2slv_rvalid  = cpuslv_rvalid;
			assign cpuslv_rready   = sys2slv_rready;

			assign cpuslv_wdata    = sys2slv_wdata;
			assign cpuslv_wlast    = sys2slv_wlast;
			assign cpuslv_wstrb    = sys2slv_wstrb;
			assign cpuslv_wvalid   = sys2slv_wvalid;
			assign sys2slv_wready  = cpuslv_wready;
	end
	endgenerate

`endif
`ifdef NDS_IO_COHERENCE
	assign iocp0_arcache = 4'b1111;
	assign iocp0_awcache = 4'b1111;
`endif







generate
if ((BIU_DATA_WIDTH > 32)) begin : gen_sizeup_for_gt32b_bus

	atcsizedn300 #(
		.ADDR_WIDTH      (ADDR_WIDTH      ),
		.DS_DATA_WIDTH   (32              ),
		.ID_WIDTH        (BIU_ID_WIDTH+4  ),
		.US_DATA_WIDTH   (BIU_DATA_WIDTH  )
	) sizedn_axibus_hbmc (
		.ds_bready (x2h_hbmc_bready                ),
		.ds_bresp  (x2h_hbmc_bresp[1:0]            ),
		.ds_bvalid (x2h_hbmc_bvalid                ),
		.ds_rdata  (x2h_hbmc_rdata[31:0]           ),
		.ds_rlast  (x2h_hbmc_rlast                 ),
		.ds_rready (x2h_hbmc_rready                ),
		.ds_rresp  (x2h_hbmc_rresp[1:0]            ),
		.ds_rvalid (x2h_hbmc_rvalid                ),
		.ds_wdata  (x2h_hbmc_wdata[31:0]           ),
		.ds_wlast  (x2h_hbmc_wlast                 ),
		.ds_wready (x2h_hbmc_wready                ),
		.ds_wstrb  (x2h_hbmc_wstrb[3:0]            ),
		.ds_wvalid (x2h_hbmc_wvalid                ),
		.us_bid    (sys2hbmc_bid[BIU_ID_MSB+4:0]   ),
		.us_bready (sys2hbmc_bready                ),
		.us_bresp  (sys2hbmc_bresp                 ),
		.us_bvalid (sys2hbmc_bvalid                ),
		.us_rdata  (sys2hbmc_rdata[BIU_DATA_MSB:0] ),
		.us_rid    (sys2hbmc_rid[BIU_ID_MSB+4:0]   ),
		.us_rlast  (sys2hbmc_rlast                 ),
		.us_rready (sys2hbmc_rready                ),
		.us_rresp  (sys2hbmc_rresp                 ),
		.us_rvalid (sys2hbmc_rvalid                ),
		.us_wdata  (sys2hbmc_wdata[BIU_DATA_MSB:0] ),
		.us_wlast  (sys2hbmc_wlast                 ),
		.us_wready (sys2hbmc_wready                ),
		.us_wstrb  (sys2hbmc_wstrb[BIU_WSTRB_MSB:0]),
		.us_wvalid (sys2hbmc_wvalid                ),
		.ds_arready(x2h_hbmc_arready               ),
		.aclk      (aclk                           ),
		.aresetn   (aresetn                        ),
		.ds_awready(x2h_hbmc_awready               ),
		.ds_araddr (x2h_hbmc_araddr[ADDR_MSB:0]    ),
		.ds_arburst(x2h_hbmc_arburst[1:0]          ),
		.ds_arcache(x2h_hbmc_arcache[3:0]          ),
		.ds_arlen  (x2h_hbmc_arlen[7:0]            ),
		.ds_arlock (x2h_hbmc_arlock                ),
		.ds_arprot (x2h_hbmc_arprot[2:0]           ),
		.ds_arsize (x2h_hbmc_arsize[2:0]           ),
		.ds_arvalid(x2h_hbmc_arvalid               ),
		.us_araddr (sys2hbmc_araddr[ADDR_MSB:0]    ),
		.us_arburst(sys2hbmc_arburst[1:0]          ),
		.us_arcache(sys2hbmc_arcache[3:0]          ),
		.us_arid   (sys2hbmc_arid[BIU_ID_MSB+4:0]  ),
		.us_arlen  (sys2hbmc_arlen[7:0]            ),
		.us_arlock (sys2hbmc_arlock                ),
		.us_arprot (sys2hbmc_arprot[2:0]           ),
		.us_arready(sys2hbmc_arready               ),
		.us_arsize (sys2hbmc_arsize[2:0]           ),
		.us_arvalid(sys2hbmc_arvalid               ),
		.ds_awaddr (x2h_hbmc_awaddr[ADDR_MSB:0]    ),
		.ds_awburst(x2h_hbmc_awburst[1:0]          ),
		.ds_awcache(x2h_hbmc_awcache[3:0]          ),
		.ds_awlen  (x2h_hbmc_awlen[7:0]            ),
		.ds_awlock (x2h_hbmc_awlock                ),
		.ds_awprot (x2h_hbmc_awprot[2:0]           ),
		.ds_awsize (x2h_hbmc_awsize[2:0]           ),
		.ds_awvalid(x2h_hbmc_awvalid               ),
		.us_awaddr (sys2hbmc_awaddr[ADDR_MSB:0]    ),
		.us_awburst(sys2hbmc_awburst[1:0]          ),
		.us_awcache(sys2hbmc_awcache[3:0]          ),
		.us_awid   (sys2hbmc_awid[BIU_ID_MSB+4:0]  ),
		.us_awlen  (sys2hbmc_awlen[7:0]            ),
		.us_awlock (sys2hbmc_awlock                ),
		.us_awprot (sys2hbmc_awprot[2:0]           ),
		.us_awready(sys2hbmc_awready               ),
		.us_awsize (sys2hbmc_awsize[2:0]           ),
		.us_awvalid(sys2hbmc_awvalid               )
	);

	atcsizedn300 #(
		.ADDR_WIDTH      (ADDR_WIDTH      ),
		.DS_DATA_WIDTH   (32              ),
		.ID_WIDTH        (BIU_ID_WIDTH+4  ),
		.US_DATA_WIDTH   (BIU_DATA_WIDTH  )
	) sizedn_axibus_rom (
		.ds_bready (x2h_rom_bready                ),
		.ds_bresp  (x2h_rom_bresp[1:0]            ),
		.ds_bvalid (x2h_rom_bvalid                ),
		.ds_rdata  (x2h_rom_rdata[31:0]           ),
		.ds_rlast  (x2h_rom_rlast                 ),
		.ds_rready (x2h_rom_rready                ),
		.ds_rresp  (x2h_rom_rresp[1:0]            ),
		.ds_rvalid (x2h_rom_rvalid                ),
		.ds_wdata  (x2h_rom_wdata[31:0]           ),
		.ds_wlast  (x2h_rom_wlast                 ),
		.ds_wready (x2h_rom_wready                ),
		.ds_wstrb  (x2h_rom_wstrb[3:0]            ),
		.ds_wvalid (x2h_rom_wvalid                ),
		.us_bid    (sys2rom_bid[BIU_ID_MSB+4:0]   ),
		.us_bready (sys2rom_bready                ),
		.us_bresp  (sys2rom_bresp                 ),
		.us_bvalid (sys2rom_bvalid                ),
		.us_rdata  (sys2rom_rdata[BIU_DATA_MSB:0] ),
		.us_rid    (sys2rom_rid[BIU_ID_MSB+4:0]   ),
		.us_rlast  (sys2rom_rlast                 ),
		.us_rready (sys2rom_rready                ),
		.us_rresp  (sys2rom_rresp                 ),
		.us_rvalid (sys2rom_rvalid                ),
		.us_wdata  (sys2rom_wdata[BIU_DATA_MSB:0] ),
		.us_wlast  (sys2rom_wlast                 ),
		.us_wready (sys2rom_wready                ),
		.us_wstrb  (sys2rom_wstrb[BIU_WSTRB_MSB:0]),
		.us_wvalid (sys2rom_wvalid                ),
		.ds_arready(x2h_rom_arready               ),
		.aclk      (aclk                          ),
		.aresetn   (aresetn                       ),
		.ds_awready(x2h_rom_awready               ),
		.ds_araddr (x2h_rom_araddr[ADDR_MSB:0]    ),
		.ds_arburst(x2h_rom_arburst[1:0]          ),
		.ds_arcache(x2h_rom_arcache[3:0]          ),
		.ds_arlen  (x2h_rom_arlen[7:0]            ),
		.ds_arlock (x2h_rom_arlock                ),
		.ds_arprot (x2h_rom_arprot[2:0]           ),
		.ds_arsize (x2h_rom_arsize[2:0]           ),
		.ds_arvalid(x2h_rom_arvalid               ),
		.us_araddr (sys2rom_araddr[ADDR_MSB:0]    ),
		.us_arburst(sys2rom_arburst[1:0]          ),
		.us_arcache(sys2rom_arcache[3:0]          ),
		.us_arid   (sys2rom_arid[BIU_ID_MSB+4:0]  ),
		.us_arlen  (sys2rom_arlen[7:0]            ),
		.us_arlock (sys2rom_arlock                ),
		.us_arprot (sys2rom_arprot[2:0]           ),
		.us_arready(sys2rom_arready               ),
		.us_arsize (sys2rom_arsize[2:0]           ),
		.us_arvalid(sys2rom_arvalid               ),
		.ds_awaddr (x2h_rom_awaddr[ADDR_MSB:0]    ),
		.ds_awburst(x2h_rom_awburst[1:0]          ),
		.ds_awcache(x2h_rom_awcache[3:0]          ),
		.ds_awlen  (x2h_rom_awlen[7:0]            ),
		.ds_awlock (x2h_rom_awlock                ),
		.ds_awprot (x2h_rom_awprot[2:0]           ),
		.ds_awsize (x2h_rom_awsize[2:0]           ),
		.ds_awvalid(x2h_rom_awvalid               ),
		.us_awaddr (sys2rom_awaddr[ADDR_MSB:0]    ),
		.us_awburst(sys2rom_awburst[1:0]          ),
		.us_awcache(sys2rom_awcache[3:0]          ),
		.us_awid   (sys2rom_awid[BIU_ID_MSB+4:0]  ),
		.us_awlen  (sys2rom_awlen[7:0]            ),
		.us_awlock (sys2rom_awlock                ),
		.us_awprot (sys2rom_awprot[2:0]           ),
		.us_awready(sys2rom_awready               ),
		.us_awsize (sys2rom_awsize[2:0]           ),
		.us_awvalid(sys2rom_awvalid               )
	);

end
endgenerate

atcbmc300 #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (BIU_DATA_WIDTH  )
) u_axi_bmc (
`ifdef ATCBMC300_MST0_SUPPORT
	.us0_araddr  (cpu_araddr                     ),
	.us0_arburst (cpu_arburst                    ),
	.us0_arcache (cpu_arcache                    ),
	.us0_arid    (cpu_arid                       ),
	.us0_arlen   (cpu_arlen                      ),
	.us0_arlock  (cpu_arlock                     ),
	.us0_arprot  (cpu_arprot                     ),
	.us0_arready (cpu_arready                    ),
	.us0_arsize  (cpu_arsize                     ),
	.us0_arvalid (cpu_arvalid                    ),
	.us0_awaddr  (cpu_awaddr                     ),
	.us0_awburst (cpu_awburst                    ),
	.us0_awcache (cpu_awcache                    ),
	.us0_awid    (cpu_awid                       ),
	.us0_awlen   (cpu_awlen                      ),
	.us0_awlock  (cpu_awlock                     ),
	.us0_awprot  (cpu_awprot                     ),
	.us0_awready (cpu_awready                    ),
	.us0_awsize  (cpu_awsize                     ),
	.us0_awvalid (cpu_awvalid                    ),
	.us0_bid     (cpu_bid                        ),
	.us0_bready  (cpu_bready                     ),
	.us0_bresp   (cpu_bresp                      ),
	.us0_bvalid  (cpu_bvalid                     ),
	.us0_rdata   (cpu_rdata                      ),
	.us0_rid     (cpu_rid                        ),
	.us0_rlast   (cpu_rlast                      ),
	.us0_rready  (cpu_rready                     ),
	.us0_rresp   (cpu_rresp                      ),
	.us0_rvalid  (cpu_rvalid                     ),
	.us0_wdata   (cpu_wdata                      ),
	.us0_wlast   (cpu_wlast                      ),
	.us0_wready  (cpu_wready                     ),
	.us0_wstrb   (cpu_wstrb                      ),
	.us0_wvalid  (cpu_wvalid                     ),
`endif
`ifdef ATCBMC300_SLV1_SUPPORT
	.ds1_araddr  (sys2hbmc_araddr[ADDR_MSB:0]    ),
	.ds1_arburst (sys2hbmc_arburst[1:0]          ),
	.ds1_arcache (sys2hbmc_arcache[3:0]          ),
	.ds1_arid    (sys2hbmc_arid[BIU_ID_MSB+4:0]  ),
	.ds1_arlen   (sys2hbmc_arlen[7:0]            ),
	.ds1_arlock  (sys2hbmc_arlock                ),
	.ds1_arprot  (sys2hbmc_arprot[2:0]           ),
	.ds1_arready (sys2hbmc_arready               ),
	.ds1_arsize  (sys2hbmc_arsize[2:0]           ),
	.ds1_arvalid (sys2hbmc_arvalid               ),
	.ds1_awaddr  (sys2hbmc_awaddr[ADDR_MSB:0]    ),
	.ds1_awburst (sys2hbmc_awburst[1:0]          ),
	.ds1_awcache (sys2hbmc_awcache[3:0]          ),
	.ds1_awid    (sys2hbmc_awid[BIU_ID_MSB+4:0]  ),
	.ds1_awlen   (sys2hbmc_awlen[7:0]            ),
	.ds1_awlock  (sys2hbmc_awlock                ),
	.ds1_awprot  (sys2hbmc_awprot[2:0]           ),
	.ds1_awready (sys2hbmc_awready               ),
	.ds1_awsize  (sys2hbmc_awsize[2:0]           ),
	.ds1_awvalid (sys2hbmc_awvalid               ),
	.ds1_bid     (sys2hbmc_bid[BIU_ID_MSB+4:0]   ),
	.ds1_bready  (sys2hbmc_bready                ),
	.ds1_bresp   (sys2hbmc_bresp[1:0]            ),
	.ds1_bvalid  (sys2hbmc_bvalid                ),
	.ds1_rdata   (sys2hbmc_rdata[BIU_DATA_MSB:0] ),
	.ds1_rid     (sys2hbmc_rid[BIU_ID_MSB+4:0]   ),
	.ds1_rlast   (sys2hbmc_rlast                 ),
	.ds1_rready  (sys2hbmc_rready                ),
	.ds1_rresp   (sys2hbmc_rresp[1:0]            ),
	.ds1_rvalid  (sys2hbmc_rvalid                ),
	.ds1_wdata   (sys2hbmc_wdata[BIU_DATA_MSB:0] ),
	.ds1_wlast   (sys2hbmc_wlast                 ),
	.ds1_wready  (sys2hbmc_wready                ),
	.ds1_wstrb   (sys2hbmc_wstrb[BIU_WSTRB_MSB:0]),
	.ds1_wvalid  (sys2hbmc_wvalid                ),
`endif
`ifdef ATCBMC300_SLV2_SUPPORT
	.ds2_araddr  (ram_araddr                     ),
	.ds2_arburst (ram_arburst                    ),
	.ds2_arcache (ram_arcache                    ),
	.ds2_arid    (ram_arid                       ),
	.ds2_arlen   (ram_arlen                      ),
	.ds2_arlock  (ram_arlock                     ),
	.ds2_arprot  (ram_arprot                     ),
	.ds2_arready (ram_arready                    ),
	.ds2_arsize  (ram_arsize                     ),
	.ds2_arvalid (ram_arvalid                    ),
	.ds2_awaddr  (ram_awaddr                     ),
	.ds2_awburst (ram_awburst                    ),
	.ds2_awcache (ram_awcache                    ),
	.ds2_awid    (ram_awid                       ),
	.ds2_awlen   (ram_awlen                      ),
	.ds2_awlock  (ram_awlock                     ),
	.ds2_awprot  (ram_awprot                     ),
	.ds2_awready (ram_awready                    ),
	.ds2_awsize  (ram_awsize                     ),
	.ds2_awvalid (ram_awvalid                    ),
	.ds2_bid     (ram_bid                        ),
	.ds2_bready  (ram_bready                     ),
	.ds2_bresp   (ram_bresp                      ),
	.ds2_bvalid  (ram_bvalid                     ),
	.ds2_rdata   (ram_rdata                      ),
	.ds2_rid     (ram_rid                        ),
	.ds2_rlast   (ram_rlast                      ),
	.ds2_rready  (ram_rready                     ),
	.ds2_rresp   (ram_rresp                      ),
	.ds2_rvalid  (ram_rvalid                     ),
	.ds2_wdata   (ram_wdata                      ),
	.ds2_wlast   (ram_wlast                      ),
	.ds2_wready  (ram_wready                     ),
	.ds2_wstrb   (ram_wstrb                      ),
	.ds2_wvalid  (ram_wvalid                     ),
`endif
`ifdef ATCBMC300_SLV3_SUPPORT
	.ds3_araddr  (sys2slv_araddr                 ),
	.ds3_arburst (sys2slv_arburst                ),
	.ds3_arcache (sys2slv_arcache                ),
	.ds3_arid    (sys2slv_arid                   ),
	.ds3_arlen   (sys2slv_arlen                  ),
	.ds3_arlock  (sys2slv_arlock                 ),
	.ds3_arprot  (sys2slv_arprot                 ),
	.ds3_arready (sys2slv_arready                ),
	.ds3_arsize  (sys2slv_arsize                 ),
	.ds3_arvalid (sys2slv_arvalid                ),
	.ds3_awaddr  (sys2slv_awaddr                 ),
	.ds3_awburst (sys2slv_awburst                ),
	.ds3_awcache (sys2slv_awcache                ),
	.ds3_awid    (sys2slv_awid                   ),
	.ds3_awlen   (sys2slv_awlen                  ),
	.ds3_awlock  (sys2slv_awlock                 ),
	.ds3_awprot  (sys2slv_awprot                 ),
	.ds3_awready (sys2slv_awready                ),
	.ds3_awsize  (sys2slv_awsize                 ),
	.ds3_awvalid (sys2slv_awvalid                ),
	.ds3_bid     (sys2slv_bid                    ),
	.ds3_bready  (sys2slv_bready                 ),
	.ds3_bresp   (sys2slv_bresp                  ),
	.ds3_bvalid  (sys2slv_bvalid                 ),
	.ds3_rdata   (sys2slv_rdata                  ),
	.ds3_rid     (sys2slv_rid                    ),
	.ds3_rlast   (sys2slv_rlast                  ),
	.ds3_rready  (sys2slv_rready                 ),
	.ds3_rresp   (sys2slv_rresp                  ),
	.ds3_rvalid  (sys2slv_rvalid                 ),
	.ds3_wdata   (sys2slv_wdata                  ),
	.ds3_wlast   (sys2slv_wlast                  ),
	.ds3_wready  (sys2slv_wready                 ),
	.ds3_wstrb   (sys2slv_wstrb                  ),
	.ds3_wvalid  (sys2slv_wvalid                 ),
`endif
`ifdef ATCBMC300_SLV4_SUPPORT
	.ds4_araddr  (sys2rom_araddr[ADDR_MSB:0]     ),
	.ds4_arburst (sys2rom_arburst[1:0]           ),
	.ds4_arcache (sys2rom_arcache[3:0]           ),
	.ds4_arid    (sys2rom_arid[BIU_ID_MSB+4:0]   ),
	.ds4_arlen   (sys2rom_arlen[7:0]             ),
	.ds4_arlock  (sys2rom_arlock                 ),
	.ds4_arprot  (sys2rom_arprot[2:0]            ),
	.ds4_arready (sys2rom_arready                ),
	.ds4_arsize  (sys2rom_arsize[2:0]            ),
	.ds4_arvalid (sys2rom_arvalid                ),
	.ds4_awaddr  (sys2rom_awaddr[ADDR_MSB:0]     ),
	.ds4_awburst (sys2rom_awburst[1:0]           ),
	.ds4_awcache (sys2rom_awcache[3:0]           ),
	.ds4_awid    (sys2rom_awid[BIU_ID_MSB+4:0]   ),
	.ds4_awlen   (sys2rom_awlen[7:0]             ),
	.ds4_awlock  (sys2rom_awlock                 ),
	.ds4_awprot  (sys2rom_awprot[2:0]            ),
	.ds4_awready (sys2rom_awready                ),
	.ds4_awsize  (sys2rom_awsize[2:0]            ),
	.ds4_awvalid (sys2rom_awvalid                ),
	.ds4_bid     (sys2rom_bid[BIU_ID_MSB+4:0]    ),
	.ds4_bready  (sys2rom_bready                 ),
	.ds4_bresp   (sys2rom_bresp[1:0]             ),
	.ds4_bvalid  (sys2rom_bvalid                 ),
	.ds4_rdata   (sys2rom_rdata[BIU_DATA_MSB:0]  ),
	.ds4_rid     (sys2rom_rid[BIU_ID_MSB+4:0]    ),
	.ds4_rlast   (sys2rom_rlast                  ),
	.ds4_rready  (sys2rom_rready                 ),
	.ds4_rresp   (sys2rom_rresp[1:0]             ),
	.ds4_rvalid  (sys2rom_rvalid                 ),
	.ds4_wdata   (sys2rom_wdata[BIU_DATA_MSB:0]  ),
	.ds4_wlast   (sys2rom_wlast                  ),
	.ds4_wready  (sys2rom_wready                 ),
	.ds4_wstrb   (sys2rom_wstrb[BIU_WSTRB_MSB:0] ),
	.ds4_wvalid  (sys2rom_wvalid                 ),
`endif
`ifdef ATCBMC300_SLV5_SUPPORT
	.ds5_araddr  (iocp0_araddr[ADDR_MSB:0]       ),
	.ds5_arburst (iocp0_arburst[1:0]             ),
	.ds5_arcache (nds_unused_iocp0_arcache[3:0]  ),
	.ds5_arid    (iocp0_arid[BIU_ID_MSB+4:0]     ),
	.ds5_arlen   (iocp0_arlen[7:0]               ),
	.ds5_arlock  (iocp0_arlock                   ),
	.ds5_arprot  (iocp0_arprot[2:0]              ),
	.ds5_arready (iocp0_arready                  ),
	.ds5_arsize  (iocp0_arsize[2:0]              ),
	.ds5_arvalid (iocp0_arvalid                  ),
	.ds5_awaddr  (iocp0_awaddr[ADDR_MSB:0]       ),
	.ds5_awburst (iocp0_awburst[1:0]             ),
	.ds5_awcache (nds_unused_iocp0_awcache[3:0]  ),
	.ds5_awid    (iocp0_awid[BIU_ID_MSB+4:0]     ),
	.ds5_awlen   (iocp0_awlen[7:0]               ),
	.ds5_awlock  (iocp0_awlock                   ),
	.ds5_awprot  (iocp0_awprot[2:0]              ),
	.ds5_awready (iocp0_awready                  ),
	.ds5_awsize  (iocp0_awsize[2:0]              ),
	.ds5_awvalid (iocp0_awvalid                  ),
	.ds5_bid     (iocp0_bid[BIU_ID_MSB+4:0]      ),
	.ds5_bready  (iocp0_bready                   ),
	.ds5_bresp   (iocp0_bresp[1:0]               ),
	.ds5_bvalid  (iocp0_bvalid                   ),
	.ds5_rdata   (iocp0_rdata[BIU_DATA_MSB:0]    ),
	.ds5_rid     (iocp0_rid[BIU_ID_MSB+4:0]      ),
	.ds5_rlast   (iocp0_rlast                    ),
	.ds5_rready  (iocp0_rready                   ),
	.ds5_rresp   (iocp0_rresp[1:0]               ),
	.ds5_rvalid  (iocp0_rvalid                   ),
	.ds5_wdata   (iocp0_wdata[BIU_DATA_MSB:0]    ),
	.ds5_wlast   (iocp0_wlast                    ),
	.ds5_wready  (iocp0_wready                   ),
	.ds5_wstrb   (iocp0_wstrb[BIU_WSTRB_MSB:0]   ),
	.ds5_wvalid  (iocp0_wvalid                   ),
`endif
`ifdef ATCBMC300_SLV6_SUPPORT
	.ds6_araddr  (sigdump_slv_araddr             ),
	.ds6_arburst (sigdump_slv_arburst            ),
	.ds6_arcache (                       ),
	.ds6_arid    (sigdump_slv_arid               ),
	.ds6_arlen   (sigdump_slv_arlen              ),
	.ds6_arlock  (sigdump_slv_arlock             ),
	.ds6_arprot  (                       ),
	.ds6_arready (sigdump_slv_arready            ),
	.ds6_arsize  (sigdump_slv_arsize             ),
	.ds6_arvalid (sigdump_slv_arvalid            ),
	.ds6_awaddr  (sigdump_slv_awaddr             ),
	.ds6_awburst (sigdump_slv_awburst            ),
	.ds6_awcache (                       ),
	.ds6_awid    (sigdump_slv_awid               ),
	.ds6_awlen   (sigdump_slv_awlen              ),
	.ds6_awlock  (sigdump_slv_awlock             ),
	.ds6_awprot  (                       ),
	.ds6_awready (sigdump_slv_awready            ),
	.ds6_awsize  (sigdump_slv_awsize             ),
	.ds6_awvalid (sigdump_slv_awvalid            ),
	.ds6_bid     (sigdump_slv_bid                ),
	.ds6_bready  (sigdump_slv_bready             ),
	.ds6_bresp   (sigdump_slv_bresp              ),
	.ds6_bvalid  (sigdump_slv_bvalid             ),
	.ds6_rdata   (sigdump_slv_rdata              ),
	.ds6_rid     (sigdump_slv_rid                ),
	.ds6_rlast   (sigdump_slv_rlast              ),
	.ds6_rready  (sigdump_slv_rready             ),
	.ds6_rresp   (sigdump_slv_rresp              ),
	.ds6_rvalid  (sigdump_slv_rvalid             ),
	.ds6_wdata   (sigdump_slv_wdata              ),
	.ds6_wlast   (                       ),
	.ds6_wready  (sigdump_slv_wready             ),
	.ds6_wstrb   (sigdump_slv_wstrb              ),
	.ds6_wvalid  (sigdump_slv_wvalid             ),
`endif
`ifdef ATCBMC300_SLV7_SUPPORT
	.ds7_araddr  (                       ),
	.ds7_arburst (                       ),
	.ds7_arcache (                       ),
	.ds7_arid    (                       ),
	.ds7_arlen   (                       ),
	.ds7_arlock  (                       ),
	.ds7_arprot  (                       ),
	.ds7_arready (1'b1                           ),
	.ds7_arsize  (                       ),
	.ds7_arvalid (                       ),
	.ds7_awaddr  (                       ),
	.ds7_awburst (                       ),
	.ds7_awcache (                       ),
	.ds7_awid    (                       ),
	.ds7_awlen   (                       ),
	.ds7_awlock  (                       ),
	.ds7_awprot  (                       ),
	.ds7_awready (1'b1                           ),
	.ds7_awsize  (                       ),
	.ds7_awvalid (                       ),
	.ds7_bid     ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds7_bready  (                       ),
	.ds7_bresp   (2'b0                           ),
	.ds7_bvalid  (1'b0                           ),
	.ds7_rdata   ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds7_rid     ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds7_rlast   (1'b0                           ),
	.ds7_rready  (                       ),
	.ds7_rresp   (2'b0                           ),
	.ds7_rvalid  (1'b0                           ),
	.ds7_wdata   (                       ),
	.ds7_wlast   (                       ),
	.ds7_wready  (1'b1                           ),
	.ds7_wstrb   (                       ),
	.ds7_wvalid  (                       ),
`endif
`ifdef ATCBMC300_SLV8_SUPPORT
	.ds8_araddr  (                       ),
	.ds8_arburst (                       ),
	.ds8_arcache (                       ),
	.ds8_arid    (                       ),
	.ds8_arlen   (                       ),
	.ds8_arlock  (                       ),
	.ds8_arprot  (                       ),
	.ds8_arready (1'b1                           ),
	.ds8_arsize  (                       ),
	.ds8_arvalid (                       ),
	.ds8_awaddr  (                       ),
	.ds8_awburst (                       ),
	.ds8_awcache (                       ),
	.ds8_awid    (                       ),
	.ds8_awlen   (                       ),
	.ds8_awlock  (                       ),
	.ds8_awprot  (                       ),
	.ds8_awready (1'b1                           ),
	.ds8_awsize  (                       ),
	.ds8_awvalid (                       ),
	.ds8_bid     ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds8_bready  (                       ),
	.ds8_bresp   (2'b0                           ),
	.ds8_bvalid  (1'b0                           ),
	.ds8_rdata   ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds8_rid     ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds8_rlast   (1'b0                           ),
	.ds8_rready  (                       ),
	.ds8_rresp   (2'b0                           ),
	.ds8_rvalid  (1'b0                           ),
	.ds8_wdata   (                       ),
	.ds8_wlast   (                       ),
	.ds8_wready  (1'b1                           ),
	.ds8_wstrb   (                       ),
	.ds8_wvalid  (                       ),
`endif
`ifdef ATCBMC300_SLV9_SUPPORT
	.ds9_araddr  (                       ),
	.ds9_arburst (                       ),
	.ds9_arcache (                       ),
	.ds9_arid    (                       ),
	.ds9_arlen   (                       ),
	.ds9_arlock  (                       ),
	.ds9_arprot  (                       ),
	.ds9_arready (1'b1                           ),
	.ds9_arsize  (                       ),
	.ds9_arvalid (                       ),
	.ds9_awaddr  (                       ),
	.ds9_awburst (                       ),
	.ds9_awcache (                       ),
	.ds9_awid    (                       ),
	.ds9_awlen   (                       ),
	.ds9_awlock  (                       ),
	.ds9_awprot  (                       ),
	.ds9_awready (1'b1                           ),
	.ds9_awsize  (                       ),
	.ds9_awvalid (                       ),
	.ds9_bid     ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds9_bready  (                       ),
	.ds9_bresp   (2'b0                           ),
	.ds9_bvalid  (1'b0                           ),
	.ds9_rdata   ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds9_rid     ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds9_rlast   (1'b0                           ),
	.ds9_rready  (                       ),
	.ds9_rresp   (2'b0                           ),
	.ds9_rvalid  (1'b0                           ),
	.ds9_wdata   (                       ),
	.ds9_wlast   (                       ),
	.ds9_wready  (1'b1                           ),
	.ds9_wstrb   (                       ),
	.ds9_wvalid  (                       ),
`endif
`ifdef ATCBMC300_SLV10_SUPPORT
	.ds10_araddr (                       ),
	.ds10_arburst(                       ),
	.ds10_arcache(                       ),
	.ds10_arid   (                       ),
	.ds10_arlen  (                       ),
	.ds10_arlock (                       ),
	.ds10_arprot (                       ),
	.ds10_arready(1'b1                           ),
	.ds10_arsize (                       ),
	.ds10_arvalid(                       ),
	.ds10_awaddr (                       ),
	.ds10_awburst(                       ),
	.ds10_awcache(                       ),
	.ds10_awid   (                       ),
	.ds10_awlen  (                       ),
	.ds10_awlock (                       ),
	.ds10_awprot (                       ),
	.ds10_awready(1'b1                           ),
	.ds10_awsize (                       ),
	.ds10_awvalid(                       ),
	.ds10_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds10_bready (                       ),
	.ds10_bresp  (2'b0                           ),
	.ds10_bvalid (1'b0                           ),
	.ds10_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds10_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds10_rlast  (1'b0                           ),
	.ds10_rready (                       ),
	.ds10_rresp  (2'b0                           ),
	.ds10_rvalid (1'b0                           ),
	.ds10_wdata  (                       ),
	.ds10_wlast  (                       ),
	.ds10_wready (1'b1                           ),
	.ds10_wstrb  (                       ),
	.ds10_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV11_SUPPORT
	.ds11_araddr (                       ),
	.ds11_arburst(                       ),
	.ds11_arcache(                       ),
	.ds11_arid   (                       ),
	.ds11_arlen  (                       ),
	.ds11_arlock (                       ),
	.ds11_arprot (                       ),
	.ds11_arready(1'b1                           ),
	.ds11_arsize (                       ),
	.ds11_arvalid(                       ),
	.ds11_awaddr (                       ),
	.ds11_awburst(                       ),
	.ds11_awcache(                       ),
	.ds11_awid   (                       ),
	.ds11_awlen  (                       ),
	.ds11_awlock (                       ),
	.ds11_awprot (                       ),
	.ds11_awready(1'b1                           ),
	.ds11_awsize (                       ),
	.ds11_awvalid(                       ),
	.ds11_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds11_bready (                       ),
	.ds11_bresp  (2'b0                           ),
	.ds11_bvalid (1'b0                           ),
	.ds11_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds11_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds11_rlast  (1'b0                           ),
	.ds11_rready (                       ),
	.ds11_rresp  (2'b0                           ),
	.ds11_rvalid (1'b0                           ),
	.ds11_wdata  (                       ),
	.ds11_wlast  (                       ),
	.ds11_wready (1'b1                           ),
	.ds11_wstrb  (                       ),
	.ds11_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV12_SUPPORT
	.ds12_araddr (                       ),
	.ds12_arburst(                       ),
	.ds12_arcache(                       ),
	.ds12_arid   (                       ),
	.ds12_arlen  (                       ),
	.ds12_arlock (                       ),
	.ds12_arprot (                       ),
	.ds12_arready(1'b1                           ),
	.ds12_arsize (                       ),
	.ds12_arvalid(                       ),
	.ds12_awaddr (                       ),
	.ds12_awburst(                       ),
	.ds12_awcache(                       ),
	.ds12_awid   (                       ),
	.ds12_awlen  (                       ),
	.ds12_awlock (                       ),
	.ds12_awprot (                       ),
	.ds12_awready(1'b1                           ),
	.ds12_awsize (                       ),
	.ds12_awvalid(                       ),
	.ds12_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds12_bready (                       ),
	.ds12_bresp  (2'b0                           ),
	.ds12_bvalid (1'b0                           ),
	.ds12_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds12_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds12_rlast  (1'b0                           ),
	.ds12_rready (                       ),
	.ds12_rresp  (2'b0                           ),
	.ds12_rvalid (1'b0                           ),
	.ds12_wdata  (                       ),
	.ds12_wlast  (                       ),
	.ds12_wready (1'b1                           ),
	.ds12_wstrb  (                       ),
	.ds12_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV13_SUPPORT
	.ds13_araddr (                       ),
	.ds13_arburst(                       ),
	.ds13_arcache(                       ),
	.ds13_arid   (                       ),
	.ds13_arlen  (                       ),
	.ds13_arlock (                       ),
	.ds13_arprot (                       ),
	.ds13_arready(1'b1                           ),
	.ds13_arsize (                       ),
	.ds13_arvalid(                       ),
	.ds13_awaddr (                       ),
	.ds13_awburst(                       ),
	.ds13_awcache(                       ),
	.ds13_awid   (                       ),
	.ds13_awlen  (                       ),
	.ds13_awlock (                       ),
	.ds13_awprot (                       ),
	.ds13_awready(1'b1                           ),
	.ds13_awsize (                       ),
	.ds13_awvalid(                       ),
	.ds13_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds13_bready (                       ),
	.ds13_bresp  (2'b0                           ),
	.ds13_bvalid (1'b0                           ),
	.ds13_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds13_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds13_rlast  (1'b0                           ),
	.ds13_rready (                       ),
	.ds13_rresp  (2'b0                           ),
	.ds13_rvalid (1'b0                           ),
	.ds13_wdata  (                       ),
	.ds13_wlast  (                       ),
	.ds13_wready (1'b1                           ),
	.ds13_wstrb  (                       ),
	.ds13_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV14_SUPPORT
	.ds14_araddr (                       ),
	.ds14_arburst(                       ),
	.ds14_arcache(                       ),
	.ds14_arid   (                       ),
	.ds14_arlen  (                       ),
	.ds14_arlock (                       ),
	.ds14_arprot (                       ),
	.ds14_arready(1'b1                           ),
	.ds14_arsize (                       ),
	.ds14_arvalid(                       ),
	.ds14_awaddr (                       ),
	.ds14_awburst(                       ),
	.ds14_awcache(                       ),
	.ds14_awid   (                       ),
	.ds14_awlen  (                       ),
	.ds14_awlock (                       ),
	.ds14_awprot (                       ),
	.ds14_awready(1'b1                           ),
	.ds14_awsize (                       ),
	.ds14_awvalid(                       ),
	.ds14_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds14_bready (                       ),
	.ds14_bresp  (2'b0                           ),
	.ds14_bvalid (1'b0                           ),
	.ds14_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds14_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds14_rlast  (1'b0                           ),
	.ds14_rready (                       ),
	.ds14_rresp  (2'b0                           ),
	.ds14_rvalid (1'b0                           ),
	.ds14_wdata  (                       ),
	.ds14_wlast  (                       ),
	.ds14_wready (1'b1                           ),
	.ds14_wstrb  (                       ),
	.ds14_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV15_SUPPORT
	.ds15_araddr (                       ),
	.ds15_arburst(                       ),
	.ds15_arcache(                       ),
	.ds15_arid   (                       ),
	.ds15_arlen  (                       ),
	.ds15_arlock (                       ),
	.ds15_arprot (                       ),
	.ds15_arready(1'b1                           ),
	.ds15_arsize (                       ),
	.ds15_arvalid(                       ),
	.ds15_awaddr (                       ),
	.ds15_awburst(                       ),
	.ds15_awcache(                       ),
	.ds15_awid   (                       ),
	.ds15_awlen  (                       ),
	.ds15_awlock (                       ),
	.ds15_awprot (                       ),
	.ds15_awready(1'b1                           ),
	.ds15_awsize (                       ),
	.ds15_awvalid(                       ),
	.ds15_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds15_bready (                       ),
	.ds15_bresp  (2'b0                           ),
	.ds15_bvalid (1'b0                           ),
	.ds15_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds15_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds15_rlast  (1'b0                           ),
	.ds15_rready (                       ),
	.ds15_rresp  (2'b0                           ),
	.ds15_rvalid (1'b0                           ),
	.ds15_wdata  (                       ),
	.ds15_wlast  (                       ),
	.ds15_wready (1'b1                           ),
	.ds15_wstrb  (                       ),
	.ds15_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV16_SUPPORT
	.ds16_araddr (                       ),
	.ds16_arburst(                       ),
	.ds16_arcache(                       ),
	.ds16_arid   (                       ),
	.ds16_arlen  (                       ),
	.ds16_arlock (                       ),
	.ds16_arprot (                       ),
	.ds16_arready(1'b1                           ),
	.ds16_arsize (                       ),
	.ds16_arvalid(                       ),
	.ds16_awaddr (                       ),
	.ds16_awburst(                       ),
	.ds16_awcache(                       ),
	.ds16_awid   (                       ),
	.ds16_awlen  (                       ),
	.ds16_awlock (                       ),
	.ds16_awprot (                       ),
	.ds16_awready(1'b1                           ),
	.ds16_awsize (                       ),
	.ds16_awvalid(                       ),
	.ds16_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds16_bready (                       ),
	.ds16_bresp  (2'b0                           ),
	.ds16_bvalid (1'b0                           ),
	.ds16_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds16_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds16_rlast  (1'b0                           ),
	.ds16_rready (                       ),
	.ds16_rresp  (2'b0                           ),
	.ds16_rvalid (1'b0                           ),
	.ds16_wdata  (                       ),
	.ds16_wlast  (                       ),
	.ds16_wready (1'b1                           ),
	.ds16_wstrb  (                       ),
	.ds16_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV17_SUPPORT
	.ds17_araddr (                       ),
	.ds17_arburst(                       ),
	.ds17_arcache(                       ),
	.ds17_arid   (                       ),
	.ds17_arlen  (                       ),
	.ds17_arlock (                       ),
	.ds17_arprot (                       ),
	.ds17_arready(1'b1                           ),
	.ds17_arsize (                       ),
	.ds17_arvalid(                       ),
	.ds17_awaddr (                       ),
	.ds17_awburst(                       ),
	.ds17_awcache(                       ),
	.ds17_awid   (                       ),
	.ds17_awlen  (                       ),
	.ds17_awlock (                       ),
	.ds17_awprot (                       ),
	.ds17_awready(1'b1                           ),
	.ds17_awsize (                       ),
	.ds17_awvalid(                       ),
	.ds17_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds17_bready (                       ),
	.ds17_bresp  (2'b0                           ),
	.ds17_bvalid (1'b0                           ),
	.ds17_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds17_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds17_rlast  (1'b0                           ),
	.ds17_rready (                       ),
	.ds17_rresp  (2'b0                           ),
	.ds17_rvalid (1'b0                           ),
	.ds17_wdata  (                       ),
	.ds17_wlast  (                       ),
	.ds17_wready (1'b1                           ),
	.ds17_wstrb  (                       ),
	.ds17_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV18_SUPPORT
	.ds18_araddr (                       ),
	.ds18_arburst(                       ),
	.ds18_arcache(                       ),
	.ds18_arid   (                       ),
	.ds18_arlen  (                       ),
	.ds18_arlock (                       ),
	.ds18_arprot (                       ),
	.ds18_arready(1'b1                           ),
	.ds18_arsize (                       ),
	.ds18_arvalid(                       ),
	.ds18_awaddr (                       ),
	.ds18_awburst(                       ),
	.ds18_awcache(                       ),
	.ds18_awid   (                       ),
	.ds18_awlen  (                       ),
	.ds18_awlock (                       ),
	.ds18_awprot (                       ),
	.ds18_awready(1'b1                           ),
	.ds18_awsize (                       ),
	.ds18_awvalid(                       ),
	.ds18_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds18_bready (                       ),
	.ds18_bresp  (2'b0                           ),
	.ds18_bvalid (1'b0                           ),
	.ds18_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds18_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds18_rlast  (1'b0                           ),
	.ds18_rready (                       ),
	.ds18_rresp  (2'b0                           ),
	.ds18_rvalid (1'b0                           ),
	.ds18_wdata  (                       ),
	.ds18_wlast  (                       ),
	.ds18_wready (1'b1                           ),
	.ds18_wstrb  (                       ),
	.ds18_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV19_SUPPORT
	.ds19_araddr (                       ),
	.ds19_arburst(                       ),
	.ds19_arcache(                       ),
	.ds19_arid   (                       ),
	.ds19_arlen  (                       ),
	.ds19_arlock (                       ),
	.ds19_arprot (                       ),
	.ds19_arready(1'b1                           ),
	.ds19_arsize (                       ),
	.ds19_arvalid(                       ),
	.ds19_awaddr (                       ),
	.ds19_awburst(                       ),
	.ds19_awcache(                       ),
	.ds19_awid   (                       ),
	.ds19_awlen  (                       ),
	.ds19_awlock (                       ),
	.ds19_awprot (                       ),
	.ds19_awready(1'b1                           ),
	.ds19_awsize (                       ),
	.ds19_awvalid(                       ),
	.ds19_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds19_bready (                       ),
	.ds19_bresp  (2'b0                           ),
	.ds19_bvalid (1'b0                           ),
	.ds19_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds19_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds19_rlast  (1'b0                           ),
	.ds19_rready (                       ),
	.ds19_rresp  (2'b0                           ),
	.ds19_rvalid (1'b0                           ),
	.ds19_wdata  (                       ),
	.ds19_wlast  (                       ),
	.ds19_wready (1'b1                           ),
	.ds19_wstrb  (                       ),
	.ds19_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV20_SUPPORT
	.ds20_araddr (                       ),
	.ds20_arburst(                       ),
	.ds20_arcache(                       ),
	.ds20_arid   (                       ),
	.ds20_arlen  (                       ),
	.ds20_arlock (                       ),
	.ds20_arprot (                       ),
	.ds20_arready(1'b1                           ),
	.ds20_arsize (                       ),
	.ds20_arvalid(                       ),
	.ds20_awaddr (                       ),
	.ds20_awburst(                       ),
	.ds20_awcache(                       ),
	.ds20_awid   (                       ),
	.ds20_awlen  (                       ),
	.ds20_awlock (                       ),
	.ds20_awprot (                       ),
	.ds20_awready(1'b1                           ),
	.ds20_awsize (                       ),
	.ds20_awvalid(                       ),
	.ds20_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds20_bready (                       ),
	.ds20_bresp  (2'b0                           ),
	.ds20_bvalid (1'b0                           ),
	.ds20_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds20_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds20_rlast  (1'b0                           ),
	.ds20_rready (                       ),
	.ds20_rresp  (2'b0                           ),
	.ds20_rvalid (1'b0                           ),
	.ds20_wdata  (                       ),
	.ds20_wlast  (                       ),
	.ds20_wready (1'b1                           ),
	.ds20_wstrb  (                       ),
	.ds20_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV21_SUPPORT
	.ds21_araddr (                       ),
	.ds21_arburst(                       ),
	.ds21_arcache(                       ),
	.ds21_arid   (                       ),
	.ds21_arlen  (                       ),
	.ds21_arlock (                       ),
	.ds21_arprot (                       ),
	.ds21_arready(1'b1                           ),
	.ds21_arsize (                       ),
	.ds21_arvalid(                       ),
	.ds21_awaddr (                       ),
	.ds21_awburst(                       ),
	.ds21_awcache(                       ),
	.ds21_awid   (                       ),
	.ds21_awlen  (                       ),
	.ds21_awlock (                       ),
	.ds21_awprot (                       ),
	.ds21_awready(1'b1                           ),
	.ds21_awsize (                       ),
	.ds21_awvalid(                       ),
	.ds21_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds21_bready (                       ),
	.ds21_bresp  (2'b0                           ),
	.ds21_bvalid (1'b0                           ),
	.ds21_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds21_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds21_rlast  (1'b0                           ),
	.ds21_rready (                       ),
	.ds21_rresp  (2'b0                           ),
	.ds21_rvalid (1'b0                           ),
	.ds21_wdata  (                       ),
	.ds21_wlast  (                       ),
	.ds21_wready (1'b1                           ),
	.ds21_wstrb  (                       ),
	.ds21_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV22_SUPPORT
	.ds22_araddr (                       ),
	.ds22_arburst(                       ),
	.ds22_arcache(                       ),
	.ds22_arid   (                       ),
	.ds22_arlen  (                       ),
	.ds22_arlock (                       ),
	.ds22_arprot (                       ),
	.ds22_arready(1'b1                           ),
	.ds22_arsize (                       ),
	.ds22_arvalid(                       ),
	.ds22_awaddr (                       ),
	.ds22_awburst(                       ),
	.ds22_awcache(                       ),
	.ds22_awid   (                       ),
	.ds22_awlen  (                       ),
	.ds22_awlock (                       ),
	.ds22_awprot (                       ),
	.ds22_awready(1'b1                           ),
	.ds22_awsize (                       ),
	.ds22_awvalid(                       ),
	.ds22_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds22_bready (                       ),
	.ds22_bresp  (2'b0                           ),
	.ds22_bvalid (1'b0                           ),
	.ds22_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds22_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds22_rlast  (1'b0                           ),
	.ds22_rready (                       ),
	.ds22_rresp  (2'b0                           ),
	.ds22_rvalid (1'b0                           ),
	.ds22_wdata  (                       ),
	.ds22_wlast  (                       ),
	.ds22_wready (1'b1                           ),
	.ds22_wstrb  (                       ),
	.ds22_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV23_SUPPORT
	.ds23_araddr (                       ),
	.ds23_arburst(                       ),
	.ds23_arcache(                       ),
	.ds23_arid   (                       ),
	.ds23_arlen  (                       ),
	.ds23_arlock (                       ),
	.ds23_arprot (                       ),
	.ds23_arready(1'b1                           ),
	.ds23_arsize (                       ),
	.ds23_arvalid(                       ),
	.ds23_awaddr (                       ),
	.ds23_awburst(                       ),
	.ds23_awcache(                       ),
	.ds23_awid   (                       ),
	.ds23_awlen  (                       ),
	.ds23_awlock (                       ),
	.ds23_awprot (                       ),
	.ds23_awready(1'b1                           ),
	.ds23_awsize (                       ),
	.ds23_awvalid(                       ),
	.ds23_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds23_bready (                       ),
	.ds23_bresp  (2'b0                           ),
	.ds23_bvalid (1'b0                           ),
	.ds23_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds23_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds23_rlast  (1'b0                           ),
	.ds23_rready (                       ),
	.ds23_rresp  (2'b0                           ),
	.ds23_rvalid (1'b0                           ),
	.ds23_wdata  (                       ),
	.ds23_wlast  (                       ),
	.ds23_wready (1'b1                           ),
	.ds23_wstrb  (                       ),
	.ds23_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV24_SUPPORT
	.ds24_araddr (                       ),
	.ds24_arburst(                       ),
	.ds24_arcache(                       ),
	.ds24_arid   (                       ),
	.ds24_arlen  (                       ),
	.ds24_arlock (                       ),
	.ds24_arprot (                       ),
	.ds24_arready(1'b1                           ),
	.ds24_arsize (                       ),
	.ds24_arvalid(                       ),
	.ds24_awaddr (                       ),
	.ds24_awburst(                       ),
	.ds24_awcache(                       ),
	.ds24_awid   (                       ),
	.ds24_awlen  (                       ),
	.ds24_awlock (                       ),
	.ds24_awprot (                       ),
	.ds24_awready(1'b1                           ),
	.ds24_awsize (                       ),
	.ds24_awvalid(                       ),
	.ds24_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds24_bready (                       ),
	.ds24_bresp  (2'b0                           ),
	.ds24_bvalid (1'b0                           ),
	.ds24_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds24_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds24_rlast  (1'b0                           ),
	.ds24_rready (                       ),
	.ds24_rresp  (2'b0                           ),
	.ds24_rvalid (1'b0                           ),
	.ds24_wdata  (                       ),
	.ds24_wlast  (                       ),
	.ds24_wready (1'b1                           ),
	.ds24_wstrb  (                       ),
	.ds24_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV25_SUPPORT
	.ds25_araddr (                       ),
	.ds25_arburst(                       ),
	.ds25_arcache(                       ),
	.ds25_arid   (                       ),
	.ds25_arlen  (                       ),
	.ds25_arlock (                       ),
	.ds25_arprot (                       ),
	.ds25_arready(1'b1                           ),
	.ds25_arsize (                       ),
	.ds25_arvalid(                       ),
	.ds25_awaddr (                       ),
	.ds25_awburst(                       ),
	.ds25_awcache(                       ),
	.ds25_awid   (                       ),
	.ds25_awlen  (                       ),
	.ds25_awlock (                       ),
	.ds25_awprot (                       ),
	.ds25_awready(1'b1                           ),
	.ds25_awsize (                       ),
	.ds25_awvalid(                       ),
	.ds25_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds25_bready (                       ),
	.ds25_bresp  (2'b0                           ),
	.ds25_bvalid (1'b0                           ),
	.ds25_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds25_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds25_rlast  (1'b0                           ),
	.ds25_rready (                       ),
	.ds25_rresp  (2'b0                           ),
	.ds25_rvalid (1'b0                           ),
	.ds25_wdata  (                       ),
	.ds25_wlast  (                       ),
	.ds25_wready (1'b1                           ),
	.ds25_wstrb  (                       ),
	.ds25_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV26_SUPPORT
	.ds26_araddr (                       ),
	.ds26_arburst(                       ),
	.ds26_arcache(                       ),
	.ds26_arid   (                       ),
	.ds26_arlen  (                       ),
	.ds26_arlock (                       ),
	.ds26_arprot (                       ),
	.ds26_arready(1'b1                           ),
	.ds26_arsize (                       ),
	.ds26_arvalid(                       ),
	.ds26_awaddr (                       ),
	.ds26_awburst(                       ),
	.ds26_awcache(                       ),
	.ds26_awid   (                       ),
	.ds26_awlen  (                       ),
	.ds26_awlock (                       ),
	.ds26_awprot (                       ),
	.ds26_awready(1'b1                           ),
	.ds26_awsize (                       ),
	.ds26_awvalid(                       ),
	.ds26_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds26_bready (                       ),
	.ds26_bresp  (2'b0                           ),
	.ds26_bvalid (1'b0                           ),
	.ds26_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds26_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds26_rlast  (1'b0                           ),
	.ds26_rready (                       ),
	.ds26_rresp  (2'b0                           ),
	.ds26_rvalid (1'b0                           ),
	.ds26_wdata  (                       ),
	.ds26_wlast  (                       ),
	.ds26_wready (1'b1                           ),
	.ds26_wstrb  (                       ),
	.ds26_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV27_SUPPORT
	.ds27_araddr (                       ),
	.ds27_arburst(                       ),
	.ds27_arcache(                       ),
	.ds27_arid   (                       ),
	.ds27_arlen  (                       ),
	.ds27_arlock (                       ),
	.ds27_arprot (                       ),
	.ds27_arready(1'b1                           ),
	.ds27_arsize (                       ),
	.ds27_arvalid(                       ),
	.ds27_awaddr (                       ),
	.ds27_awburst(                       ),
	.ds27_awcache(                       ),
	.ds27_awid   (                       ),
	.ds27_awlen  (                       ),
	.ds27_awlock (                       ),
	.ds27_awprot (                       ),
	.ds27_awready(1'b1                           ),
	.ds27_awsize (                       ),
	.ds27_awvalid(                       ),
	.ds27_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds27_bready (                       ),
	.ds27_bresp  (2'b0                           ),
	.ds27_bvalid (1'b0                           ),
	.ds27_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds27_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds27_rlast  (1'b0                           ),
	.ds27_rready (                       ),
	.ds27_rresp  (2'b0                           ),
	.ds27_rvalid (1'b0                           ),
	.ds27_wdata  (                       ),
	.ds27_wlast  (                       ),
	.ds27_wready (1'b1                           ),
	.ds27_wstrb  (                       ),
	.ds27_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV28_SUPPORT
	.ds28_araddr (                       ),
	.ds28_arburst(                       ),
	.ds28_arcache(                       ),
	.ds28_arid   (                       ),
	.ds28_arlen  (                       ),
	.ds28_arlock (                       ),
	.ds28_arprot (                       ),
	.ds28_arready(1'b1                           ),
	.ds28_arsize (                       ),
	.ds28_arvalid(                       ),
	.ds28_awaddr (                       ),
	.ds28_awburst(                       ),
	.ds28_awcache(                       ),
	.ds28_awid   (                       ),
	.ds28_awlen  (                       ),
	.ds28_awlock (                       ),
	.ds28_awprot (                       ),
	.ds28_awready(1'b1                           ),
	.ds28_awsize (                       ),
	.ds28_awvalid(                       ),
	.ds28_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds28_bready (                       ),
	.ds28_bresp  (2'b0                           ),
	.ds28_bvalid (1'b0                           ),
	.ds28_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds28_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds28_rlast  (1'b0                           ),
	.ds28_rready (                       ),
	.ds28_rresp  (2'b0                           ),
	.ds28_rvalid (1'b0                           ),
	.ds28_wdata  (                       ),
	.ds28_wlast  (                       ),
	.ds28_wready (1'b1                           ),
	.ds28_wstrb  (                       ),
	.ds28_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV29_SUPPORT
	.ds29_araddr (                       ),
	.ds29_arburst(                       ),
	.ds29_arcache(                       ),
	.ds29_arid   (                       ),
	.ds29_arlen  (                       ),
	.ds29_arlock (                       ),
	.ds29_arprot (                       ),
	.ds29_arready(1'b1                           ),
	.ds29_arsize (                       ),
	.ds29_arvalid(                       ),
	.ds29_awaddr (                       ),
	.ds29_awburst(                       ),
	.ds29_awcache(                       ),
	.ds29_awid   (                       ),
	.ds29_awlen  (                       ),
	.ds29_awlock (                       ),
	.ds29_awprot (                       ),
	.ds29_awready(1'b1                           ),
	.ds29_awsize (                       ),
	.ds29_awvalid(                       ),
	.ds29_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds29_bready (                       ),
	.ds29_bresp  (2'b0                           ),
	.ds29_bvalid (1'b0                           ),
	.ds29_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds29_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds29_rlast  (1'b0                           ),
	.ds29_rready (                       ),
	.ds29_rresp  (2'b0                           ),
	.ds29_rvalid (1'b0                           ),
	.ds29_wdata  (                       ),
	.ds29_wlast  (                       ),
	.ds29_wready (1'b1                           ),
	.ds29_wstrb  (                       ),
	.ds29_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV30_SUPPORT
	.ds30_araddr (                       ),
	.ds30_arburst(                       ),
	.ds30_arcache(                       ),
	.ds30_arid   (                       ),
	.ds30_arlen  (                       ),
	.ds30_arlock (                       ),
	.ds30_arprot (                       ),
	.ds30_arready(1'b1                           ),
	.ds30_arsize (                       ),
	.ds30_arvalid(                       ),
	.ds30_awaddr (                       ),
	.ds30_awburst(                       ),
	.ds30_awcache(                       ),
	.ds30_awid   (                       ),
	.ds30_awlen  (                       ),
	.ds30_awlock (                       ),
	.ds30_awprot (                       ),
	.ds30_awready(1'b1                           ),
	.ds30_awsize (                       ),
	.ds30_awvalid(                       ),
	.ds30_bid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds30_bready (                       ),
	.ds30_bresp  (2'b0                           ),
	.ds30_bvalid (1'b0                           ),
	.ds30_rdata  ({(BIU_DATA_WIDTH){1'b0}}       ),
	.ds30_rid    ({(BIU_ID_WIDTH+4){1'b0}}       ),
	.ds30_rlast  (1'b0                           ),
	.ds30_rready (                       ),
	.ds30_rresp  (2'b0                           ),
	.ds30_rvalid (1'b0                           ),
	.ds30_wdata  (                       ),
	.ds30_wlast  (                       ),
	.ds30_wready (1'b1                           ),
	.ds30_wstrb  (                       ),
	.ds30_wvalid (                       ),
`endif
`ifdef ATCBMC300_SLV31_SUPPORT
	.ds31_araddr (bmc2dfs_araddr                 ),
	.ds31_arburst(bmc2dfs_arburst                ),
	.ds31_arcache(bmc2dfs_arcache                ),
	.ds31_arid   (bmc2dfs_arid                   ),
	.ds31_arlen  (bmc2dfs_arlen                  ),
	.ds31_arlock (bmc2dfs_arlock                 ),
	.ds31_arprot (bmc2dfs_arprot                 ),
	.ds31_arready(bmc2dfs_arready                ),
	.ds31_arsize (bmc2dfs_arsize                 ),
	.ds31_arvalid(bmc2dfs_arvalid                ),
	.ds31_awaddr (bmc2dfs_awaddr                 ),
	.ds31_awburst(bmc2dfs_awburst                ),
	.ds31_awcache(bmc2dfs_awcache                ),
	.ds31_awid   (bmc2dfs_awid                   ),
	.ds31_awlen  (bmc2dfs_awlen                  ),
	.ds31_awlock (bmc2dfs_awlock                 ),
	.ds31_awprot (bmc2dfs_awprot                 ),
	.ds31_awready(bmc2dfs_awready                ),
	.ds31_awsize (bmc2dfs_awsize                 ),
	.ds31_awvalid(bmc2dfs_awvalid                ),
	.ds31_bid    (bmc2dfs_bid                    ),
	.ds31_bready (bmc2dfs_bready                 ),
	.ds31_bresp  (bmc2dfs_bresp                  ),
	.ds31_bvalid (bmc2dfs_bvalid                 ),
	.ds31_rdata  (bmc2dfs_rdata                  ),
	.ds31_rid    (bmc2dfs_rid                    ),
	.ds31_rlast  (bmc2dfs_rlast                  ),
	.ds31_rready (bmc2dfs_rready                 ),
	.ds31_rresp  (bmc2dfs_rresp                  ),
	.ds31_rvalid (bmc2dfs_rvalid                 ),
	.ds31_wdata  (bmc2dfs_wdata                  ),
	.ds31_wlast  (bmc2dfs_wlast                  ),
	.ds31_wready (bmc2dfs_wready                 ),
	.ds31_wstrb  (bmc2dfs_wstrb                  ),
	.ds31_wvalid (bmc2dfs_wvalid                 ),
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	.us1_araddr  (cpu_i_araddr                   ),
	.us1_arburst (cpu_i_arburst                  ),
	.us1_arcache (cpu_i_arcache                  ),
	.us1_arid    (cpu_i_arid                     ),
	.us1_arlen   (cpu_i_arlen                    ),
	.us1_arlock  (cpu_i_arlock                   ),
	.us1_arprot  (cpu_i_arprot                   ),
	.us1_arready (cpu_i_arready                  ),
	.us1_arsize  (cpu_i_arsize                   ),
	.us1_arvalid (cpu_i_arvalid                  ),
	.us1_awaddr  (cpu_i_awaddr                   ),
	.us1_awburst (cpu_i_awburst                  ),
	.us1_awcache (cpu_i_awcache                  ),
	.us1_awid    (cpu_i_awid                     ),
	.us1_awlen   (cpu_i_awlen                    ),
	.us1_awlock  (cpu_i_awlock                   ),
	.us1_awprot  (cpu_i_awprot                   ),
	.us1_awready (cpu_i_awready                  ),
	.us1_awsize  (cpu_i_awsize                   ),
	.us1_awvalid (cpu_i_awvalid                  ),
	.us1_bid     (cpu_i_bid                      ),
	.us1_bready  (cpu_i_bready                   ),
	.us1_bresp   (cpu_i_bresp                    ),
	.us1_bvalid  (cpu_i_bvalid                   ),
	.us1_rdata   (cpu_i_rdata                    ),
	.us1_rid     (cpu_i_rid                      ),
	.us1_rlast   (cpu_i_rlast                    ),
	.us1_rready  (cpu_i_rready                   ),
	.us1_rresp   (cpu_i_rresp                    ),
	.us1_rvalid  (cpu_i_rvalid                   ),
	.us1_wdata   (cpu_i_wdata                    ),
	.us1_wlast   (cpu_i_wlast                    ),
	.us1_wready  (cpu_i_wready                   ),
	.us1_wstrb   (cpu_i_wstrb                    ),
	.us1_wvalid  (cpu_i_wvalid                   ),
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	.us2_araddr  (cpu_d_araddr                   ),
	.us2_arburst (cpu_d_arburst                  ),
	.us2_arcache (cpu_d_arcache                  ),
	.us2_arid    (cpu_d_arid                     ),
	.us2_arlen   (cpu_d_arlen                    ),
	.us2_arlock  (cpu_d_arlock                   ),
	.us2_arprot  (cpu_d_arprot                   ),
	.us2_arready (cpu_d_arready                  ),
	.us2_arsize  (cpu_d_arsize                   ),
	.us2_arvalid (cpu_d_arvalid                  ),
	.us2_awaddr  (cpu_d_awaddr                   ),
	.us2_awburst (cpu_d_awburst                  ),
	.us2_awcache (cpu_d_awcache                  ),
	.us2_awid    (cpu_d_awid                     ),
	.us2_awlen   (cpu_d_awlen                    ),
	.us2_awlock  (cpu_d_awlock                   ),
	.us2_awprot  (cpu_d_awprot                   ),
	.us2_awready (cpu_d_awready                  ),
	.us2_awsize  (cpu_d_awsize                   ),
	.us2_awvalid (cpu_d_awvalid                  ),
	.us2_bid     (cpu_d_bid                      ),
	.us2_bready  (cpu_d_bready                   ),
	.us2_bresp   (cpu_d_bresp                    ),
	.us2_bvalid  (cpu_d_bvalid                   ),
	.us2_rdata   (cpu_d_rdata                    ),
	.us2_rid     (cpu_d_rid                      ),
	.us2_rlast   (cpu_d_rlast                    ),
	.us2_rready  (cpu_d_rready                   ),
	.us2_rresp   (cpu_d_rresp                    ),
	.us2_rvalid  (cpu_d_rvalid                   ),
	.us2_wdata   (cpu_d_wdata                    ),
	.us2_wlast   (cpu_d_wlast                    ),
	.us2_wready  (cpu_d_wready                   ),
	.us2_wstrb   (cpu_d_wstrb                    ),
	.us2_wvalid  (cpu_d_wvalid                   ),
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	.us3_araddr  ({ADDR_WIDTH{1'b0}}             ),
	.us3_arburst (2'b0                           ),
	.us3_arcache (4'b0                           ),
	.us3_arid    ({(BIU_ID_WIDTH){1'b0}}         ),
	.us3_arlen   (8'b0                           ),
	.us3_arlock  (                       ),
	.us3_arprot  (3'b0                           ),
	.us3_arready (                       ),
	.us3_arsize  (3'b0                           ),
	.us3_arvalid (1'b0                           ),
	.us3_awaddr  ({ADDR_WIDTH{1'b0}}             ),
	.us3_awburst (2'b0                           ),
	.us3_awcache (4'b0                           ),
	.us3_awid    ({BIU_ID_WIDTH{1'b0}}           ),
	.us3_awlen   (8'b0                           ),
	.us3_awlock  (1'b0                           ),
	.us3_awprot  (3'b0                           ),
	.us3_awready (                       ),
	.us3_awsize  (3'b0                           ),
	.us3_awvalid (1'b0                           ),
	.us3_bid     (                       ),
	.us3_bready  (1'b1                           ),
	.us3_bresp   (                       ),
	.us3_bvalid  (                       ),
	.us3_rdata   (                       ),
	.us3_rid     (                       ),
	.us3_rlast   (                       ),
	.us3_rready  (1'b1                           ),
	.us3_rresp   (                       ),
	.us3_rvalid  (                       ),
	.us3_wdata   ({BIU_DATA_WIDTH{1'b0}}         ),
	.us3_wlast   (1'b0                           ),
	.us3_wready  (                       ),
	.us3_wstrb   ({BIU_WSTRB_WIDTH{1'b0}}        ),
	.us3_wvalid  (1'b0                           ),
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	.us4_araddr  (mmio_araddr                    ),
	.us4_arburst (mmio_arburst                   ),
	.us4_arcache (mmio_arcache                   ),
	.us4_arid    (mmio_arid                      ),
	.us4_arlen   (mmio_arlen                     ),
	.us4_arlock  (mmio_arlock                    ),
	.us4_arprot  (mmio_arprot                    ),
	.us4_arready (mmio_arready                   ),
	.us4_arsize  (mmio_arsize                    ),
	.us4_arvalid (mmio_arvalid                   ),
	.us4_awaddr  (mmio_awaddr                    ),
	.us4_awburst (mmio_awburst                   ),
	.us4_awcache (mmio_awcache                   ),
	.us4_awid    (mmio_awid                      ),
	.us4_awlen   (mmio_awlen                     ),
	.us4_awlock  (mmio_awlock                    ),
	.us4_awprot  (mmio_awprot                    ),
	.us4_awready (mmio_awready                   ),
	.us4_awsize  (mmio_awsize                    ),
	.us4_awvalid (mmio_awvalid                   ),
	.us4_bid     (mmio_bid                       ),
	.us4_bready  (mmio_bready                    ),
	.us4_bresp   (mmio_bresp                     ),
	.us4_bvalid  (mmio_bvalid                    ),
	.us4_rdata   (mmio_rdata                     ),
	.us4_rid     (mmio_rid                       ),
	.us4_rlast   (mmio_rlast                     ),
	.us4_rready  (mmio_rready                    ),
	.us4_rresp   (mmio_rresp                     ),
	.us4_rvalid  (mmio_rvalid                    ),
	.us4_wdata   (mmio_wdata                     ),
	.us4_wlast   (mmio_wlast                     ),
	.us4_wready  (mmio_wready                    ),
	.us4_wstrb   (mmio_wstrb                     ),
	.us4_wvalid  (mmio_wvalid                    ),
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	.us5_araddr  (dmac0_sys_araddr               ),
	.us5_arburst (dmac0_sys_arburst              ),
	.us5_arcache (dmac0_sys_arcache              ),
	.us5_arid    (dmac0_sys_arid                 ),
	.us5_arlen   (dmac0_sys_arlen                ),
	.us5_arlock  (dmac0_sys_arlock               ),
	.us5_arprot  (dmac0_sys_arprot               ),
	.us5_arready (dmac0_sys_arready              ),
	.us5_arsize  (dmac0_sys_arsize               ),
	.us5_arvalid (dmac0_sys_arvalid              ),
	.us5_awaddr  (dmac0_sys_awaddr               ),
	.us5_awburst (dmac0_sys_awburst              ),
	.us5_awcache (dmac0_sys_awcache              ),
	.us5_awid    (dmac0_sys_awid                 ),
	.us5_awlen   (dmac0_sys_awlen                ),
	.us5_awlock  (dmac0_sys_awlock               ),
	.us5_awprot  (dmac0_sys_awprot               ),
	.us5_awready (dmac0_sys_awready              ),
	.us5_awsize  (dmac0_sys_awsize               ),
	.us5_awvalid (dmac0_sys_awvalid              ),
	.us5_bid     (dmac0_sys_bid                  ),
	.us5_bready  (dmac0_sys_bready               ),
	.us5_bresp   (dmac0_sys_bresp                ),
	.us5_bvalid  (dmac0_sys_bvalid               ),
	.us5_rdata   (dmac0_sys_rdata                ),
	.us5_rid     (dmac0_sys_rid                  ),
	.us5_rlast   (dmac0_sys_rlast                ),
	.us5_rready  (dmac0_sys_rready               ),
	.us5_rresp   (dmac0_sys_rresp                ),
	.us5_rvalid  (dmac0_sys_rvalid               ),
	.us5_wdata   (dmac0_sys_wdata                ),
	.us5_wlast   (dmac0_sys_wlast                ),
	.us5_wready  (dmac0_sys_wready               ),
	.us5_wstrb   (dmac0_sys_wstrb                ),
	.us5_wvalid  (dmac0_sys_wvalid               ),
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	.us6_araddr  (dmac1_sys_araddr               ),
	.us6_arburst (dmac1_sys_arburst              ),
	.us6_arcache (dmac1_sys_arcache              ),
	.us6_arid    (dmac1_sys_arid                 ),
	.us6_arlen   (dmac1_sys_arlen                ),
	.us6_arlock  (dmac1_sys_arlock               ),
	.us6_arprot  (dmac1_sys_arprot               ),
	.us6_arready (dmac1_sys_arready              ),
	.us6_arsize  (dmac1_sys_arsize               ),
	.us6_arvalid (dmac1_sys_arvalid              ),
	.us6_awaddr  (dmac1_sys_awaddr               ),
	.us6_awburst (dmac1_sys_awburst              ),
	.us6_awcache (dmac1_sys_awcache              ),
	.us6_awid    (dmac1_sys_awid                 ),
	.us6_awlen   (dmac1_sys_awlen                ),
	.us6_awlock  (dmac1_sys_awlock               ),
	.us6_awprot  (dmac1_sys_awprot               ),
	.us6_awready (dmac1_sys_awready              ),
	.us6_awsize  (dmac1_sys_awsize               ),
	.us6_awvalid (dmac1_sys_awvalid              ),
	.us6_bid     (dmac1_sys_bid                  ),
	.us6_bready  (dmac1_sys_bready               ),
	.us6_bresp   (dmac1_sys_bresp                ),
	.us6_bvalid  (dmac1_sys_bvalid               ),
	.us6_rdata   (dmac1_sys_rdata                ),
	.us6_rid     (dmac1_sys_rid                  ),
	.us6_rlast   (dmac1_sys_rlast                ),
	.us6_rready  (dmac1_sys_rready               ),
	.us6_rresp   (dmac1_sys_rresp                ),
	.us6_rvalid  (dmac1_sys_rvalid               ),
	.us6_wdata   (dmac1_sys_wdata                ),
	.us6_wlast   (dmac1_sys_wlast                ),
	.us6_wready  (dmac1_sys_wready               ),
	.us6_wstrb   (dmac1_sys_wstrb                ),
	.us6_wvalid  (dmac1_sys_wvalid               ),
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	.us7_araddr  (mac_sys_araddr                 ),
	.us7_arburst (mac_sys_arburst                ),
	.us7_arcache (mac_sys_arcache                ),
	.us7_arid    (mac_sys_arid                   ),
	.us7_arlen   (mac_sys_arlen                  ),
	.us7_arlock  (mac_sys_arlock                 ),
	.us7_arprot  (mac_sys_arprot                 ),
	.us7_arready (mac_sys_arready                ),
	.us7_arsize  (mac_sys_arsize                 ),
	.us7_arvalid (mac_sys_arvalid                ),
	.us7_awaddr  (mac_sys_awaddr                 ),
	.us7_awburst (mac_sys_awburst                ),
	.us7_awcache (mac_sys_awcache                ),
	.us7_awid    (mac_sys_awid                   ),
	.us7_awlen   (mac_sys_awlen                  ),
	.us7_awlock  (mac_sys_awlock                 ),
	.us7_awprot  (mac_sys_awprot                 ),
	.us7_awready (mac_sys_awready                ),
	.us7_awsize  (mac_sys_awsize                 ),
	.us7_awvalid (mac_sys_awvalid                ),
	.us7_bid     (mac_sys_bid                    ),
	.us7_bready  (mac_sys_bready                 ),
	.us7_bresp   (mac_sys_bresp                  ),
	.us7_bvalid  (mac_sys_bvalid                 ),
	.us7_rdata   (mac_sys_rdata                  ),
	.us7_rid     (mac_sys_rid                    ),
	.us7_rlast   (mac_sys_rlast                  ),
	.us7_rready  (mac_sys_rready                 ),
	.us7_rresp   (mac_sys_rresp                  ),
	.us7_rvalid  (mac_sys_rvalid                 ),
	.us7_wdata   (mac_sys_wdata                  ),
	.us7_wlast   (mac_sys_wlast                  ),
	.us7_wready  (mac_sys_wready                 ),
	.us7_wstrb   (mac_sys_wstrb                  ),
	.us7_wvalid  (mac_sys_wvalid                 ),
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	.us8_araddr  (lcdc_sys_araddr                ),
	.us8_arburst (lcdc_sys_arburst               ),
	.us8_arcache (lcdc_sys_arcache               ),
	.us8_arid    (lcdc_sys_arid                  ),
	.us8_arlen   (lcdc_sys_arlen                 ),
	.us8_arlock  (lcdc_sys_arlock                ),
	.us8_arprot  (lcdc_sys_arprot                ),
	.us8_arready (lcdc_sys_arready               ),
	.us8_arsize  (lcdc_sys_arsize                ),
	.us8_arvalid (lcdc_sys_arvalid               ),
	.us8_awaddr  (lcdc_sys_awaddr                ),
	.us8_awburst (lcdc_sys_awburst               ),
	.us8_awcache (lcdc_sys_awcache               ),
	.us8_awid    (lcdc_sys_awid                  ),
	.us8_awlen   (lcdc_sys_awlen                 ),
	.us8_awlock  (lcdc_sys_awlock                ),
	.us8_awprot  (lcdc_sys_awprot                ),
	.us8_awready (lcdc_sys_awready               ),
	.us8_awsize  (lcdc_sys_awsize                ),
	.us8_awvalid (lcdc_sys_awvalid               ),
	.us8_bid     (lcdc_sys_bid                   ),
	.us8_bready  (lcdc_sys_bready                ),
	.us8_bresp   (lcdc_sys_bresp                 ),
	.us8_bvalid  (lcdc_sys_bvalid                ),
	.us8_rdata   (lcdc_sys_rdata                 ),
	.us8_rid     (lcdc_sys_rid                   ),
	.us8_rlast   (lcdc_sys_rlast                 ),
	.us8_rready  (lcdc_sys_rready                ),
	.us8_rresp   (lcdc_sys_rresp                 ),
	.us8_rvalid  (lcdc_sys_rvalid                ),
	.us8_wdata   (lcdc_sys_wdata                 ),
	.us8_wlast   (lcdc_sys_wlast                 ),
	.us8_wready  (lcdc_sys_wready                ),
	.us8_wstrb   (lcdc_sys_wstrb                 ),
	.us8_wvalid  (lcdc_sys_wvalid                ),
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	.us9_araddr  ({(ADDR_MSB+1){1'b0}}           ),
	.us9_arburst ({(2){1'b0}}                    ),
	.us9_arcache ({(4){1'b0}}                    ),
	.us9_arid    ({(BIU_ID_MSB+1){1'b0}}         ),
	.us9_arlen   ({(8){1'b0}}                    ),
	.us9_arlock  (1'b0                           ),
	.us9_arprot  ({(3){1'b0}}                    ),
	.us9_arready (                       ),
	.us9_arsize  ({(3){1'b0}}                    ),
	.us9_arvalid (1'b0                           ),
	.us9_awaddr  (sigdump_awaddr                 ),
	.us9_awburst (sigdump_awburst                ),
	.us9_awcache (sigdump_awcache                ),
	.us9_awid    ({(BIU_ID_MSB+1){1'b0}}         ),
	.us9_awlen   (sigdump_awlen                  ),
	.us9_awlock  (1'b0                           ),
	.us9_awprot  (sigdump_awprot                 ),
	.us9_awready (sigdump_awready                ),
	.us9_awsize  (sigdump_awsize                 ),
	.us9_awvalid (sigdump_awvalid                ),
	.us9_bid     (                       ),
	.us9_bready  (sigdump_bready                 ),
	.us9_bresp   (sigdump_bresp                  ),
	.us9_bvalid  (sigdump_bvalid                 ),
	.us9_rdata   (                       ),
	.us9_rid     (                       ),
	.us9_rlast   (                       ),
	.us9_rready  (1'b1                           ),
	.us9_rresp   (                       ),
	.us9_rvalid  (                       ),
	.us9_wdata   (sigdump_wdata                  ),
	.us9_wlast   (sigdump_wlast                  ),
	.us9_wready  (sigdump_wready                 ),
	.us9_wstrb   (sigdump_wstrb                  ),
	.us9_wvalid  (sigdump_wvalid                 ),
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	.us10_araddr (dm_sys_araddr                  ),
	.us10_arburst(dm_sys_arburst                 ),
	.us10_arcache(dm_sys_arcache                 ),
	.us10_arid   (dm_sys_arid                    ),
	.us10_arlen  (dm_sys_arlen                   ),
	.us10_arlock (dm_sys_arlock                  ),
	.us10_arprot (dm_sys_arprot                  ),
	.us10_arready(dm_sys_arready                 ),
	.us10_arsize (dm_sys_arsize                  ),
	.us10_arvalid(dm_sys_arvalid                 ),
	.us10_awaddr (dm_sys_awaddr                  ),
	.us10_awburst(dm_sys_awburst                 ),
	.us10_awcache(dm_sys_awcache                 ),
	.us10_awid   (dm_sys_awid                    ),
	.us10_awlen  (dm_sys_awlen                   ),
	.us10_awlock (dm_sys_awlock                  ),
	.us10_awprot (dm_sys_awprot                  ),
	.us10_awready(dm_sys_awready                 ),
	.us10_awsize (dm_sys_awsize                  ),
	.us10_awvalid(dm_sys_awvalid                 ),
	.us10_bid    (dm_sys_bid                     ),
	.us10_bready (dm_sys_bready                  ),
	.us10_bresp  (dm_sys_bresp                   ),
	.us10_bvalid (dm_sys_bvalid                  ),
	.us10_rdata  (dm_sys_rdata                   ),
	.us10_rid    (dm_sys_rid                     ),
	.us10_rlast  (dm_sys_rlast                   ),
	.us10_rready (dm_sys_rready                  ),
	.us10_rresp  (dm_sys_rresp                   ),
	.us10_rvalid (dm_sys_rvalid                  ),
	.us10_wdata  (dm_sys_wdata                   ),
	.us10_wlast  (dm_sys_wlast                   ),
	.us10_wready (dm_sys_wready                  ),
	.us10_wstrb  (dm_sys_wstrb                   ),
	.us10_wvalid (dm_sys_wvalid                  ),
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	.us11_araddr ({ADDR_WIDTH{1'b0}}             ),
	.us11_arburst(2'b0                           ),
	.us11_arcache(4'b0                           ),
	.us11_arid   ({(BIU_ID_WIDTH){1'b0}}         ),
	.us11_arlen  (8'b0                           ),
	.us11_arlock (                       ),
	.us11_arprot (3'b0                           ),
	.us11_arready(                       ),
	.us11_arsize (3'b0                           ),
	.us11_arvalid(1'b0                           ),
	.us11_awaddr ({ADDR_WIDTH{1'b0}}             ),
	.us11_awburst(2'b0                           ),
	.us11_awcache(4'b0                           ),
	.us11_awid   ({BIU_ID_WIDTH{1'b0}}           ),
	.us11_awlen  (8'b0                           ),
	.us11_awlock (1'b0                           ),
	.us11_awprot (3'b0                           ),
	.us11_awready(                       ),
	.us11_awsize (3'b0                           ),
	.us11_awvalid(1'b0                           ),
	.us11_bid    (                       ),
	.us11_bready (1'b1                           ),
	.us11_bresp  (                       ),
	.us11_bvalid (                       ),
	.us11_rdata  (                       ),
	.us11_rid    (                       ),
	.us11_rlast  (                       ),
	.us11_rready (1'b1                           ),
	.us11_rresp  (                       ),
	.us11_rvalid (                       ),
	.us11_wdata  ({BIU_DATA_WIDTH{1'b0}}         ),
	.us11_wlast  (1'b0                           ),
	.us11_wready (                       ),
	.us11_wstrb  ({BIU_WSTRB_WIDTH{1'b0}}        ),
	.us11_wvalid (1'b0                           ),
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	.us12_araddr ({ADDR_WIDTH{1'b0}}             ),
	.us12_arburst(2'b0                           ),
	.us12_arcache(4'b0                           ),
	.us12_arid   ({(BIU_ID_WIDTH){1'b0}}         ),
	.us12_arlen  (8'b0                           ),
	.us12_arlock (                       ),
	.us12_arprot (3'b0                           ),
	.us12_arready(                       ),
	.us12_arsize (3'b0                           ),
	.us12_arvalid(1'b0                           ),
	.us12_awaddr ({ADDR_WIDTH{1'b0}}             ),
	.us12_awburst(2'b0                           ),
	.us12_awcache(4'b0                           ),
	.us12_awid   ({BIU_ID_WIDTH{1'b0}}           ),
	.us12_awlen  (8'b0                           ),
	.us12_awlock (1'b0                           ),
	.us12_awprot (3'b0                           ),
	.us12_awready(                       ),
	.us12_awsize (3'b0                           ),
	.us12_awvalid(1'b0                           ),
	.us12_bid    (                       ),
	.us12_bready (1'b1                           ),
	.us12_bresp  (                       ),
	.us12_bvalid (                       ),
	.us12_rdata  (                       ),
	.us12_rid    (                       ),
	.us12_rlast  (                       ),
	.us12_rready (1'b1                           ),
	.us12_rresp  (                       ),
	.us12_rvalid (                       ),
	.us12_wdata  ({BIU_DATA_WIDTH{1'b0}}         ),
	.us12_wlast  (1'b0                           ),
	.us12_wready (                       ),
	.us12_wstrb  ({BIU_WSTRB_WIDTH{1'b0}}        ),
	.us12_wvalid (1'b0                           ),
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	.us13_araddr ({ADDR_WIDTH{1'b0}}             ),
	.us13_arburst(2'b0                           ),
	.us13_arcache(4'b0                           ),
	.us13_arid   ({(BIU_ID_WIDTH){1'b0}}         ),
	.us13_arlen  (8'b0                           ),
	.us13_arlock (                       ),
	.us13_arprot (3'b0                           ),
	.us13_arready(                       ),
	.us13_arsize (3'b0                           ),
	.us13_arvalid(1'b0                           ),
	.us13_awaddr ({ADDR_WIDTH{1'b0}}             ),
	.us13_awburst(2'b0                           ),
	.us13_awcache(4'b0                           ),
	.us13_awid   ({BIU_ID_WIDTH{1'b0}}           ),
	.us13_awlen  (8'b0                           ),
	.us13_awlock (1'b0                           ),
	.us13_awprot (3'b0                           ),
	.us13_awready(                       ),
	.us13_awsize (3'b0                           ),
	.us13_awvalid(1'b0                           ),
	.us13_bid    (                       ),
	.us13_bready (1'b1                           ),
	.us13_bresp  (                       ),
	.us13_bvalid (                       ),
	.us13_rdata  (                       ),
	.us13_rid    (                       ),
	.us13_rlast  (                       ),
	.us13_rready (1'b1                           ),
	.us13_rresp  (                       ),
	.us13_rvalid (                       ),
	.us13_wdata  ({BIU_DATA_WIDTH{1'b0}}         ),
	.us13_wlast  (1'b0                           ),
	.us13_wready (                       ),
	.us13_wstrb  ({BIU_WSTRB_WIDTH{1'b0}}        ),
	.us13_wvalid (1'b0                           ),
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	.us14_araddr ({ADDR_WIDTH{1'b0}}             ),
	.us14_arburst(2'b0                           ),
	.us14_arcache(4'b0                           ),
	.us14_arid   ({(BIU_ID_WIDTH){1'b0}}         ),
	.us14_arlen  (8'b0                           ),
	.us14_arlock (                       ),
	.us14_arprot (3'b0                           ),
	.us14_arready(                       ),
	.us14_arsize (3'b0                           ),
	.us14_arvalid(1'b0                           ),
	.us14_awaddr ({ADDR_WIDTH{1'b0}}             ),
	.us14_awburst(2'b0                           ),
	.us14_awcache(4'b0                           ),
	.us14_awid   ({BIU_ID_WIDTH{1'b0}}           ),
	.us14_awlen  (8'b0                           ),
	.us14_awlock (1'b0                           ),
	.us14_awprot (3'b0                           ),
	.us14_awready(                       ),
	.us14_awsize (3'b0                           ),
	.us14_awvalid(1'b0                           ),
	.us14_bid    (                       ),
	.us14_bready (1'b1                           ),
	.us14_bresp  (                       ),
	.us14_bvalid (                       ),
	.us14_rdata  (                       ),
	.us14_rid    (                       ),
	.us14_rlast  (                       ),
	.us14_rready (1'b1                           ),
	.us14_rresp  (                       ),
	.us14_rvalid (                       ),
	.us14_wdata  ({BIU_DATA_WIDTH{1'b0}}         ),
	.us14_wlast  (1'b0                           ),
	.us14_wready (                       ),
	.us14_wstrb  ({BIU_WSTRB_WIDTH{1'b0}}        ),
	.us14_wvalid (1'b0                           ),
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	.us15_araddr ({ADDR_WIDTH{1'b0}}             ),
	.us15_arburst(2'b0                           ),
	.us15_arcache(4'b0                           ),
	.us15_arid   ({(BIU_ID_WIDTH){1'b0}}         ),
	.us15_arlen  (8'b0                           ),
	.us15_arlock (                       ),
	.us15_arprot (3'b0                           ),
	.us15_arready(                       ),
	.us15_arsize (3'b0                           ),
	.us15_arvalid(1'b0                           ),
	.us15_awaddr ({ADDR_WIDTH{1'b0}}             ),
	.us15_awburst(2'b0                           ),
	.us15_awcache(4'b0                           ),
	.us15_awid   ({BIU_ID_WIDTH{1'b0}}           ),
	.us15_awlen  (8'b0                           ),
	.us15_awlock (1'b0                           ),
	.us15_awprot (3'b0                           ),
	.us15_awready(                       ),
	.us15_awsize (3'b0                           ),
	.us15_awvalid(1'b0                           ),
	.us15_bid    (                       ),
	.us15_bready (1'b1                           ),
	.us15_bresp  (                       ),
	.us15_bvalid (                       ),
	.us15_rdata  (                       ),
	.us15_rid    (                       ),
	.us15_rlast  (                       ),
	.us15_rready (1'b1                           ),
	.us15_rresp  (                       ),
	.us15_rvalid (                       ),
	.us15_wdata  ({BIU_DATA_WIDTH{1'b0}}         ),
	.us15_wlast  (1'b0                           ),
	.us15_wready (                       ),
	.us15_wstrb  ({BIU_WSTRB_WIDTH{1'b0}}        ),
	.us15_wvalid (1'b0                           ),
`endif
	.aclk        (aclk                           ),
	.aresetn     (aresetn                        )
);

atcaxi2ahb200 #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (32              ),
	.ID_WIDTH        (BIU_ID_WIDTH+4  )
) axi2ahb_rom (
	.araddr (x2h_rom_araddr  ),
	.arburst(x2h_rom_arburst ),
	.arcache(x2h_rom_arcache ),
	.arid   (x2h_rom_arid    ),
	.arlen  (x2h_rom_arlen   ),
	.arlock (x2h_rom_arlock  ),
	.arprot (x2h_rom_arprot  ),
	.arready(x2h_rom_arready ),
	.arsize (x2h_rom_arsize  ),
	.arvalid(x2h_rom_arvalid ),
	.awaddr (x2h_rom_awaddr  ),
	.awburst(x2h_rom_awburst ),
	.awcache(x2h_rom_awcache ),
	.awid   (x2h_rom_awid    ),
	.awlen  (x2h_rom_awlen   ),
	.awlock (x2h_rom_awlock  ),
	.awprot (x2h_rom_awprot  ),
	.awready(x2h_rom_awready ),
	.awsize (x2h_rom_awsize  ),
	.awvalid(x2h_rom_awvalid ),
	.bid    (x2h_rom_bid     ),
	.bready (x2h_rom_bready  ),
	.bresp  (x2h_rom_bresp   ),
	.bvalid (x2h_rom_bvalid  ),
	.rdata  (x2h_rom_rdata   ),
	.rid    (x2h_rom_rid     ),
	.rlast  (x2h_rom_rlast   ),
	.rready (x2h_rom_rready  ),
	.rresp  (x2h_rom_rresp   ),
	.rvalid (x2h_rom_rvalid  ),
	.wdata  (x2h_rom_wdata   ),
	.wlast  (x2h_rom_wlast   ),
	.wready (x2h_rom_wready  ),
	.wstrb  (x2h_rom_wstrb   ),
	.wvalid (x2h_rom_wvalid  ),
	.hclk   (hclk            ),
	.hresetn(hresetn         ),
	.aclk   (aclk            ),
	.aresetn(aresetn         ),
	.haddr  (sys2rom_haddr   ),
	.hburst (sys2rom_hburst  ),
	.hprot  (sys2rom_hprot   ),
	.hrdata (rom2sys_hrdata  ),
	.hready (rom2sys_hready  ),
	.hresp  (rom2sys_hresp[0]),
	.hsize  (sys2rom_hsize   ),
	.htrans (sys2rom_htrans  ),
	.hwdata (sys2rom_hwdata  ),
	.hwrite (sys2rom_hwrite  )
);

atcaxi2ahb200 #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (32              ),
	.ID_WIDTH        (BIU_ID_WIDTH+4  )
) axi2ahb_hbmc (
	.araddr (x2h_hbmc_araddr  ),
	.arburst(x2h_hbmc_arburst ),
	.arcache(x2h_hbmc_arcache ),
	.arid   (x2h_hbmc_arid    ),
	.arlen  (x2h_hbmc_arlen   ),
	.arlock (x2h_hbmc_arlock  ),
	.arprot (x2h_hbmc_arprot  ),
	.arready(x2h_hbmc_arready ),
	.arsize (x2h_hbmc_arsize  ),
	.arvalid(x2h_hbmc_arvalid ),
	.awaddr (x2h_hbmc_awaddr  ),
	.awburst(x2h_hbmc_awburst ),
	.awcache(x2h_hbmc_awcache ),
	.awid   (x2h_hbmc_awid    ),
	.awlen  (x2h_hbmc_awlen   ),
	.awlock (x2h_hbmc_awlock  ),
	.awprot (x2h_hbmc_awprot  ),
	.awready(x2h_hbmc_awready ),
	.awsize (x2h_hbmc_awsize  ),
	.awvalid(x2h_hbmc_awvalid ),
	.bid    (x2h_hbmc_bid     ),
	.bready (x2h_hbmc_bready  ),
	.bresp  (x2h_hbmc_bresp   ),
	.bvalid (x2h_hbmc_bvalid  ),
	.rdata  (x2h_hbmc_rdata   ),
	.rid    (x2h_hbmc_rid     ),
	.rlast  (x2h_hbmc_rlast   ),
	.rready (x2h_hbmc_rready  ),
	.rresp  (x2h_hbmc_rresp   ),
	.rvalid (x2h_hbmc_rvalid  ),
	.wdata  (x2h_hbmc_wdata   ),
	.wlast  (x2h_hbmc_wlast   ),
	.wready (x2h_hbmc_wready  ),
	.wstrb  (x2h_hbmc_wstrb   ),
	.wvalid (x2h_hbmc_wvalid  ),
	.hclk   (hclk             ),
	.hresetn(hresetn          ),
	.aclk   (aclk             ),
	.aresetn(aresetn          ),
	.haddr  (sys2hbmc_haddr   ),
	.hburst (sys2hbmc_hburst  ),
	.hprot  (sys2hbmc_hprot   ),
	.hrdata (hbmc2sys_hrdata  ),
	.hready (hbmc2sys_hready  ),
	.hresp  (hbmc2sys_hresp[0]),
	.hsize  (sys2hbmc_hsize   ),
	.htrans (sys2hbmc_htrans  ),
	.hwdata (sys2hbmc_hwdata  ),
	.hwrite (sys2hbmc_hwrite  )
);



`ifdef NDS_IO_SLAVEPORT_COMMON_X1
generate
if ((BIU_DATA_WIDTH > SLVPORT_DATA_WIDTH)) begin : gen_axi_slvport_sdn

	atcsizedn300 #(
		.ADDR_WIDTH      (ADDR_WIDTH      ),
		.DS_DATA_WIDTH   (SLVPORT_DATA_WIDTH),
		.ID_WIDTH        (BIU_ID_WIDTH+4  ),
		.US_DATA_WIDTH   (BIU_DATA_WIDTH  )
	) u_axi_slvport_sdn (
		.ds_bready (cpuslv_bready  ),
		.ds_bresp  (cpuslv_bresp   ),
		.ds_bvalid (cpuslv_bvalid  ),
		.ds_rdata  (cpuslv_rdata   ),
		.ds_rlast  (cpuslv_rlast   ),
		.ds_rready (cpuslv_rready  ),
		.ds_rresp  (cpuslv_rresp   ),
		.ds_rvalid (cpuslv_rvalid  ),
		.ds_wdata  (cpuslv_wdata   ),
		.ds_wlast  (cpuslv_wlast   ),
		.ds_wready (cpuslv_wready  ),
		.ds_wstrb  (cpuslv_wstrb   ),
		.ds_wvalid (cpuslv_wvalid  ),
		.us_bid    (sys2slv_bid    ),
		.us_bready (sys2slv_bready ),
		.us_bresp  (sys2slv_bresp  ),
		.us_bvalid (sys2slv_bvalid ),
		.us_rdata  (sys2slv_rdata  ),
		.us_rid    (sys2slv_rid    ),
		.us_rlast  (sys2slv_rlast  ),
		.us_rready (sys2slv_rready ),
		.us_rresp  (sys2slv_rresp  ),
		.us_rvalid (sys2slv_rvalid ),
		.us_wdata  (sys2slv_wdata  ),
		.us_wlast  (sys2slv_wlast  ),
		.us_wready (sys2slv_wready ),
		.us_wstrb  (sys2slv_wstrb  ),
		.us_wvalid (sys2slv_wvalid ),
		.ds_arready(cpuslv_arready ),
		.aclk      (aclk           ),
		.aresetn   (aresetn        ),
		.ds_awready(cpuslv_awready ),
		.ds_araddr (cpuslv_araddr  ),
		.ds_arburst(cpuslv_arburst ),
		.ds_arcache(cpuslv_arcache ),
		.ds_arlen  (cpuslv_arlen   ),
		.ds_arlock (cpuslv_arlock  ),
		.ds_arprot (cpuslv_arprot  ),
		.ds_arsize (cpuslv_arsize  ),
		.ds_arvalid(cpuslv_arvalid ),
		.us_araddr (sys2slv_araddr ),
		.us_arburst(sys2slv_arburst),
		.us_arcache(sys2slv_arcache),
		.us_arid   (sys2slv_arid   ),
		.us_arlen  (sys2slv_arlen  ),
		.us_arlock (sys2slv_arlock ),
		.us_arprot (sys2slv_arprot ),
		.us_arready(sys2slv_arready),
		.us_arsize (sys2slv_arsize ),
		.us_arvalid(sys2slv_arvalid),
		.ds_awaddr (cpuslv_awaddr  ),
		.ds_awburst(cpuslv_awburst ),
		.ds_awcache(cpuslv_awcache ),
		.ds_awlen  (cpuslv_awlen   ),
		.ds_awlock (cpuslv_awlock  ),
		.ds_awprot (cpuslv_awprot  ),
		.ds_awsize (cpuslv_awsize  ),
		.ds_awvalid(cpuslv_awvalid ),
		.us_awaddr (sys2slv_awaddr ),
		.us_awburst(sys2slv_awburst),
		.us_awcache(sys2slv_awcache),
		.us_awid   (sys2slv_awid   ),
		.us_awlen  (sys2slv_awlen  ),
		.us_awlock (sys2slv_awlock ),
		.us_awprot (sys2slv_awprot ),
		.us_awready(sys2slv_awready),
		.us_awsize (sys2slv_awsize ),
		.us_awvalid(sys2slv_awvalid)
	);

end
endgenerate

`endif

endmodule

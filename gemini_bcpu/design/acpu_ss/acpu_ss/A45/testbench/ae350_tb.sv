
`timescale 1ns/1ps

`include "ae350_config.vh"
`include "ae350_const.vh"
`include "sample_ae350_smu_config.vh"
`include "sample_ae350_smu_const.vh"
`include "config.inc"
`include "global.inc"
`include "xmr.vh"
`include "ae350_xmr.vh"


`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"


`ifdef AE350_OSCH_PERIOD
`else
	`ifdef NDS_FPGA
		`define AE350_OSCH_PERIOD 50
	`else
		`define AE350_OSCH_PERIOD 25
	`endif
`endif

`ifdef AE350_OSCL_PERIOD
`else
        `define AE350_OSCL_PERIOD 30517.58
`endif

`ifdef AE350_POR_PERIOD
`else
	`define	AE350_POR_PERIOD	(10.0 * `AE350_OSCH_PERIOD)
`endif

`ifdef NDS_PLATFORM_TEST_DEEPSLEEP
	`define IMAGE_SIZE_POT		21
`else
	`define IMAGE_SIZE_POT		24
`endif

module ae350_tb (
	
		  X_cpu_araddr,
		  X_cpu_arburst,
		  X_cpu_arcache,
		  X_cpu_arid,
		  X_cpu_arlen,
		  X_cpu_arlock,
		  X_cpu_arprot,
		  X_cpu_arready,
		  X_cpu_arsize,
		  X_cpu_arvalid,
		  X_cpu_awaddr,
		  X_cpu_awburst,
		  X_cpu_awcache,
		  X_cpu_awid,
		  X_cpu_awlen,
		  X_cpu_awlock,
		  X_cpu_awprot,
		  X_cpu_awready,
		  X_cpu_awsize,
		  X_cpu_awvalid,
		  X_cpu_bid,
		  X_cpu_bready,
		  X_cpu_bresp,
		  X_cpu_bvalid,
		  X_cpu_rdata,
		  X_cpu_rid,
		  X_cpu_rlast,
		  X_cpu_rready,
		  X_cpu_rresp,
		  X_cpu_rvalid,
		  X_cpu_wdata,
		  X_cpu_wlast,
		  X_cpu_wready,
		  X_cpu_wstrb,
		  X_cpu_wvalid,
		  X_aclk,
		  X_aresetn,

		  H_hclk,
		  H_hresetn,
		  H_hm0_haddr,
		  H_hm0_htrans,
		  H_hm0_hwrite,
		  H_hm0_hsize,
		  H_hm0_hburst,
		  H_hm0_hprot,
		  H_hm0_hwdata,
		  H_hm0_hreadyi,
		  H_hm0_hmaster,
		  H_hm0_hmastlock,
		  H_hm0_hrdata,
		  H_hm0_hresp,
		  H_hm0_hselx,
		  H_hs0_haddr,
		  H_hs0_htrans,
		  H_hs0_hwrite,
		  H_hs0_hsize,
		  H_hs0_hburst,
		  H_hs0_hprot,
		  H_hs0_hwdata,
		  H_hs0_hreadyi,
		  H_hs0_hmaster,
		  H_hs0_hmastlock,
		  H_hs0_hrdata,
		  H_hs0_hresp,
		  H_hs0_hsel,
		  H_hs0_hselx,
	`ifdef AE350_UART1_SUPPORT
		  X_uart1_rxd,
		  X_uart1_txd,
		  X_uart1_dcdn,
		  X_uart1_dsrn,
		  X_uart1_rin,
		  X_uart1_dtrn,
		  X_uart1_out1n,
		  X_uart1_out2n,
	   `ifdef AE350_UART2_SUPPORT
	      `ifdef NDS_FPGA
	      `else
		  X_uart1_ctsn,
		  X_uart1_rtsn,
	      `endif
	   `else
		  X_uart1_ctsn,
		  X_uart1_rtsn,
	   `endif
	`endif
	`ifdef AE350_UART2_SUPPORT
		  X_uart2_rxd,
		  X_uart2_txd,
	   `ifdef NDS_FPGA
	   `else
		  X_uart2_ctsn,
		  X_uart2_rtsn,
		  X_uart2_dcdn,
		  X_uart2_dsrn,
		  X_uart2_rin,
		  X_uart2_dtrn,
		  X_uart2_out1n,
		  X_uart2_out2n,
	   `endif
	`endif
		  X_om,
		  X_hw_rstn,
		  X_aopd_por_b,
		  X_por_b,
		  X_oschin,
		  X_osclin,
		  X_wakeup_in,
		  X_mpd_pwr_off
);
parameter DDR3_CLK_PERIOD = 5;
parameter DDR4_CLK_PERIOD = 4;
parameter IMAGE_SIZE = 1 << `IMAGE_SIZE_POT;
parameter ILM_BASE = `NDS_ILM_BASE >> 2;
parameter DLM_BASE = `NDS_DLM_BASE >> 2;

`ifdef PLATFORM_RESET_VECTOR
parameter PLATFORM_RESET_VECTOR = `PLATFORM_RESET_VECTOR;
`else
parameter PLATFORM_RESET_VECTOR = 64'h80000000;
`endif

`ifdef PLATFORM_SPI_MEM_BASE
parameter PLATFORM_SPI_MEM_BASE = `PLATFORM_SPI_MEM_BASE;
`else
parameter PLATFORM_SPI_MEM_BASE = 64'h80000000;
`endif

`ifdef PLATFORM_DEBUG_VECTOR
parameter PLATFORM_DEBUG_VECTOR = `PLATFORM_DEBUG_VECTOR;
`else
parameter PLATFORM_DEBUG_VECTOR = 64'he6800000;
`endif

`ifdef PLATFORM_PLDM_REGS_BASE
parameter PLATFORM_PLDM_REGS_BASE = `PLATFORM_PLDM_REGS_BASE;
`else
parameter PLATFORM_PLDM_REGS_BASE = 64'he6800000;
`endif

localparam	XLEN  = `NDS_ISA_BASE == "rv64i" ? 64 : 32;
localparam	PALEN = `NDS_BIU_ADDR_WIDTH;
localparam	MMU_SCHEME = `NDS_MMU_SCHEME;
localparam	VALEN = (MMU_SCHEME == "sv32") ? 32 : (MMU_SCHEME == "sv39") ? 39 : (MMU_SCHEME == "sv48") ? 48 : PALEN;

localparam	ICACHE_WAY		= `NDS_ICACHE_WAY;
localparam	ICACHE_SIZE_KB		= `NDS_ICACHE_SIZE_KB;
localparam	ICACHE_LRU		= `NDS_ICACHE_LRU;
localparam	ICACHE_TAG_RAM_AW	= `NDS_ICACHE_TAG_RAM_AW;
localparam	ICACHE_TAG_RAM_DW	= `NDS_ICACHE_TAG_RAM_DW;

localparam	BIU_ID_WIDTH	= `NDS_BIU_ID_WIDTH;

localparam	SLAVE_PORT_SUPPORT = `NDS_SLAVE_PORT_SUPPORT;
localparam	SLAVE_PORT_ID_WIDTH = `NDS_SLAVE_PORT_ID_WIDTH;
localparam	DEBUG_SUPPORT      = `NDS_DEBUG_SUPPORT;
localparam	NDS_DEVICE_REGION0_BASE = `NDS_DEVICE_REGION0_BASE;
localparam	NDS_DEVICE_REGION0_MASK = `NDS_DEVICE_REGION0_MASK;
localparam	NDS_DEVICE_REGION1_BASE = `NDS_DEVICE_REGION1_BASE;
localparam	NDS_DEVICE_REGION1_MASK = `NDS_DEVICE_REGION1_MASK;
localparam	NDS_DEVICE_REGION2_BASE = `NDS_DEVICE_REGION2_BASE;
localparam	NDS_DEVICE_REGION2_MASK = `NDS_DEVICE_REGION2_MASK;
localparam	NDS_DEVICE_REGION3_BASE = `NDS_DEVICE_REGION3_BASE;
localparam	NDS_DEVICE_REGION3_MASK = `NDS_DEVICE_REGION3_MASK;
localparam	NDS_DEVICE_REGION4_BASE = `NDS_DEVICE_REGION4_BASE;
localparam	NDS_DEVICE_REGION4_MASK = `NDS_DEVICE_REGION4_MASK;
localparam	NDS_DEVICE_REGION5_BASE = `NDS_DEVICE_REGION5_BASE;
localparam	NDS_DEVICE_REGION5_MASK = `NDS_DEVICE_REGION5_MASK;
localparam	NDS_DEVICE_REGION6_BASE = `NDS_DEVICE_REGION6_BASE;
localparam	NDS_DEVICE_REGION6_MASK = `NDS_DEVICE_REGION6_MASK;
localparam	NDS_DEVICE_REGION7_BASE = `NDS_DEVICE_REGION7_BASE;
localparam	NDS_DEVICE_REGION7_MASK = `NDS_DEVICE_REGION7_MASK;

`ifdef NDS_IOCP_NUM
localparam	IOCP_NUM = `NDS_IOCP_NUM;
localparam	IOCP_ID_WIDTH = `NDS_IOCP_ID_WIDTH;
`else
localparam	IOCP_NUM = 0;
localparam	IOCP_ID_WIDTH = BIU_ID_WIDTH + 4;
`endif

localparam	DLM_SIZE_KB   = `NDS_DLM_SIZE_KB;
localparam	ILM_SIZE_KB   = `NDS_ILM_SIZE_KB;
localparam	DLM_ECC_TYPE  = `NDS_DLM_ECC_TYPE;
localparam	ILM_ECC_TYPE  = `NDS_ILM_ECC_TYPE;
localparam	DLM_WORD_SIZE = DLM_SIZE_KB*1024;
localparam	ILM_WORD_SIZE = (ILM_SIZE_KB == 0) ? 64*1024 : ILM_SIZE_KB*1024;
localparam	DLM_ECCW      = (`NDS_ISA_BASE == "rv64i") ? 8 : (DLM_ECC_TYPE == "ecc" ? 7 : 4);
localparam	ILM_ECCW      = (`NDS_ISA_BASE == "rv64i") ? 8 : (ILM_ECC_TYPE == "ecc" ? 7 : 4);
localparam	DLM_RAM_DW    = (DLM_ECC_TYPE != "none") ? (XLEN+DLM_ECCW) : XLEN;
localparam	ILM_RAM_DW    = (ILM_ECC_TYPE != "none") ? (XLEN+ILM_ECCW) : XLEN;
localparam      DLM_AMSB      = (XLEN == 64) ?
			(`NDS_NUM_DLM_BANKS == 1) ? `NDS_DLM_RAM_AW+2 : (`NDS_NUM_DLM_BANKS == 2) ? `NDS_DLM_RAM_AW+2 +1 : `NDS_DLM_RAM_AW+2+2 :
                        (`NDS_NUM_DLM_BANKS == 1) ? `NDS_DLM_RAM_AW+1 : (`NDS_NUM_DLM_BANKS == 2) ? `NDS_DLM_RAM_AW+1 +1 : `NDS_DLM_RAM_AW+1+2;

localparam NHART = 1;


`ifdef NDS_IO_L2C
localparam	L2C_SUPPORT    = 1;
`else
localparam	L2C_SUPPORT    = 0;
`endif

`ifndef NDS_SKIP_MISALIGNED_DEVICE_SLAVE_PORT_CHECK
localparam	SLVP_BASE = `ATCBMC300_SLV3_BASE_ADDR;
localparam	SLVP_DEVICE = ((SLVP_BASE & NDS_DEVICE_REGION0_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION0_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
			    | ((SLVP_BASE & NDS_DEVICE_REGION1_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION1_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
			    | ((SLVP_BASE & NDS_DEVICE_REGION2_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION2_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
			    | ((SLVP_BASE & NDS_DEVICE_REGION3_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION3_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
			    | ((SLVP_BASE & NDS_DEVICE_REGION4_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION4_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
			    | ((SLVP_BASE & NDS_DEVICE_REGION5_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION5_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
			    | ((SLVP_BASE & NDS_DEVICE_REGION6_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION6_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
			    | ((SLVP_BASE & NDS_DEVICE_REGION7_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION7_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
			    ;
`endif

`ifdef NDS_ATCSPI200_TEST
localparam	SPI1_MEM_BASE = `ATCBMC300_SLV4_BASE_ADDR;
localparam	SPI1_MEM_DEVICE = ((SPI1_MEM_BASE & NDS_DEVICE_REGION0_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION0_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
				| ((SPI1_MEM_BASE & NDS_DEVICE_REGION1_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION1_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
				| ((SPI1_MEM_BASE & NDS_DEVICE_REGION2_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION2_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
				| ((SPI1_MEM_BASE & NDS_DEVICE_REGION3_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION3_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
				| ((SPI1_MEM_BASE & NDS_DEVICE_REGION4_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION4_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
				| ((SPI1_MEM_BASE & NDS_DEVICE_REGION5_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION5_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
				| ((SPI1_MEM_BASE & NDS_DEVICE_REGION6_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION6_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
				| ((SPI1_MEM_BASE & NDS_DEVICE_REGION7_MASK[`ATCBMC300_ADDR_WIDTH-1:0]) == NDS_DEVICE_REGION7_BASE[`ATCBMC300_ADDR_WIDTH-1:0])
				;
`endif
`ifdef PLATFORM_JTAG_TAP_NUM
localparam      JTAG_TAP_NUM   = `PLATFORM_JTAG_TAP_NUM;
`else
localparam      JTAG_TAP_NUM   = 1;
`endif
`ifdef PLATFORM_DM_TAP_ID
localparam      DM_TAP_ID     = `PLATFORM_DM_TAP_ID;
`else
localparam      DM_TAP_ID     = 0;
`endif

`ifdef AE350_DDR3_RW_TEST
localparam AE350_DDR3_MEM_TEST_REDUCED_RANGE = 10;
localparam AE350_DDR3_MEM_BASE = 'h00000000;
localparam AE350_DDR3_MEM_SIZE = ('h80000000 >> AE350_DDR3_MEM_TEST_REDUCED_RANGE);
`endif


output        [`NDS_BIU_ADDR_WIDTH-1:0] X_cpu_araddr;
output                            [1:0] X_cpu_arburst;
output                            [3:0] X_cpu_arcache;
output      [(`ATCBMC300_ID_WIDTH-1):0] X_cpu_arid;
output                            [7:0] X_cpu_arlen;
output                                  X_cpu_arlock;
output                            [2:0] X_cpu_arprot;
output                                  X_cpu_arready;
output                            [2:0] X_cpu_arsize;
output                                  X_cpu_arvalid;
output        [`NDS_BIU_ADDR_WIDTH-1:0] X_cpu_awaddr;
output                            [1:0] X_cpu_awburst;
output                            [3:0] X_cpu_awcache;
output      [(`ATCBMC300_ID_WIDTH-1):0] X_cpu_awid;
output                            [7:0] X_cpu_awlen;
output                                  X_cpu_awlock;
output                            [2:0] X_cpu_awprot;
output                                  X_cpu_awready;
output                            [2:0] X_cpu_awsize;
output                                  X_cpu_awvalid;
output      [(`ATCBMC300_ID_WIDTH-1):0] X_cpu_bid;
output                                  X_cpu_bready;
output                            [1:0] X_cpu_bresp;
output                                  X_cpu_bvalid;
output        [`NDS_BIU_DATA_WIDTH-1:0] X_cpu_rdata;
output      [(`ATCBMC300_ID_WIDTH-1):0] X_cpu_rid;
output                                  X_cpu_rlast;
output                                  X_cpu_rready;
output                            [1:0] X_cpu_rresp;
output                                  X_cpu_rvalid;
output        [`NDS_BIU_DATA_WIDTH-1:0] X_cpu_wdata;
output                                  X_cpu_wlast;
output                                  X_cpu_wready;
output    [(`NDS_BIU_DATA_WIDTH/8)-1:0] X_cpu_wstrb;
output                                  X_cpu_wvalid;
output                                  X_aclk;
output                                  X_aresetn;

output		H_hclk;
output		H_hresetn;
output	[`AE350_HADDR_MSB:0]	H_hm0_haddr;
output	[1:0]	H_hm0_htrans;
output		H_hm0_hwrite;
output	[2:0]	H_hm0_hsize;
output	[2:0]	H_hm0_hburst;
output	[3:0]	H_hm0_hprot;
output	[31:0]	H_hm0_hwdata;
output		H_hm0_hreadyi;
output	[3:0]	H_hm0_hmaster;
output		H_hm0_hmastlock;
output	[31:0]	H_hm0_hrdata;
output	[1:0]	H_hm0_hresp;
output	[31:0]	H_hm0_hselx;
output	[`AE350_HADDR_MSB:0]	H_hs0_haddr;
output	[1:0]	H_hs0_htrans;
output		H_hs0_hwrite;
output	[2:0]	H_hs0_hsize;
output	[2:0]	H_hs0_hburst;
output	[3:0]	H_hs0_hprot;
output	[31:0]	H_hs0_hwdata;
output		H_hs0_hreadyi;
output	[3:0]	H_hs0_hmaster;
output		H_hs0_hmastlock;
output	[31:0]	H_hs0_hrdata;
output	[1:0]	H_hs0_hresp;
output		H_hs0_hsel;
output	[31:0]	H_hs0_hselx;



`ifdef AE350_UART1_SUPPORT
output		X_uart1_rxd;
input		X_uart1_txd;
output		X_uart1_dcdn;
output		X_uart1_dsrn;
output		X_uart1_rin;
input		X_uart1_dtrn;
input		X_uart1_out1n;
input		X_uart1_out2n;
`ifdef AE350_UART2_SUPPORT
	`ifndef NDS_FPGA
	output		X_uart1_ctsn;
	input		X_uart1_rtsn;
	`endif
`else
output		X_uart1_ctsn;
input		X_uart1_rtsn;
`endif
`endif

`ifdef AE350_UART2_SUPPORT
output		X_uart2_rxd;
input		X_uart2_txd;
`ifdef NDS_FPGA
`else
output		X_uart2_ctsn;
input		X_uart2_rtsn;
output		X_uart2_dcdn;
output		X_uart2_dsrn;
output		X_uart2_rin;
input		X_uart2_dtrn;
input		X_uart2_out1n;
input		X_uart2_out2n;
`endif
`endif
inout		X_om;
output		X_hw_rstn;
output		X_aopd_por_b;
output		X_por_b;
output		X_oschin;
output		X_osclin;
output		X_wakeup_in;
input		X_mpd_pwr_off;

integer 	seed;
reg	[31:0]	osch_phase;
reg	[31:0]	oscl_phase;
reg		tb_debug_mon;
reg		X_oschin;
reg		X_osclin;
reg		X_hw_rstn;
reg		X_aopd_por_b;
reg		X_por_b;
reg		X_wakeup_in;
wire [(NHART-1):0] core_resetn;
wire [(NHART-1):0] core_resetn_d1;
`ifdef AE350_UART1_SUPPORT
reg		X_uart1_rxd;
reg		X_uart1_ctsn;
reg		X_uart1_dcdn;
reg		X_uart1_dsrn;
reg		X_uart1_rin;
`endif
`ifdef AE350_UART2_SUPPORT
reg		X_uart2_rxd;
reg		X_uart2_ctsn;
reg		X_uart2_dcdn;
reg		X_uart2_dsrn;
reg		X_uart2_rin;
`endif
wire            X_pd_pwr_off;
wire            X_mpd_pwr_off_d1;
wire    [(NHART-1):0]		ilm_init_posedge_trigger;
// synthesis translate_off
reg	[31:0]	data /* sparse */ [0:IMAGE_SIZE-1];
reg	[31:0]	loader_data /* sparse */ [0:IMAGE_SIZE-1];
// synthesis translate_on

`ifndef NDS_NO_POWER_SCRIPT
`ifdef NDS_UPF_SIM
	`ifdef VCS
		import UPF::*;
		initial
		begin
			supply_on("VDD_0V81", 0.81);
			supply_on("VSS", 0.0);
		end
	`elsif XCELIUM
		initial
		begin
			void'($supply_on("VDD_0V81", 0.81));
			void'($supply_on("VSS", 0.0));
		end
	`elsif INCA
		initial
		begin
			void'($supply_on("VDD_0V81", 0.81));
			void'($supply_on("VSS", 0.0));
		end
	`endif
`endif
`endif

assign		X_om = 1'b0;
integer		default_seed = 32'h9bbd09e5;

initial begin
	if ($value$plusargs("seed=%d", seed))
		seed = seed ^ default_seed;
	else
		seed = default_seed;

	osch_phase = $urandom(seed) % $rtoi(`AE350_OSCH_PERIOD * 1000.0);
	oscl_phase = $urandom(seed) % $rtoi(`AE350_OSCL_PERIOD * 1000.0);

	// synthesis translate_off
       	$readmemh("NDSROM.dat", data);
       	$readmemh("loader.dat", loader_data);
	// synthesis translate_on

		tb_debug_mon = 1'b1;
end

initial begin
        X_oschin = 1'b0;
	#1;
	#(osch_phase / 1000.0);
        forever
                #(`AE350_OSCH_PERIOD/2.0) X_oschin = ~X_oschin;
end

initial begin
        X_osclin = 1'b0;
	#1;
	#(oscl_phase / 1000.0);
        forever
                #(`AE350_OSCL_PERIOD/2.0) X_osclin = ~X_osclin;
end







initial begin
	X_hw_rstn	= 1'b1;
	X_wakeup_in	= 1'b0;

	X_aopd_por_b	= 1'b0;
	X_por_b		= 1'b0;

	#(`AE350_POR_PERIOD) ;
	X_aopd_por_b	= 1'b1;

	#10;
	X_por_b		= 1'b1;

`ifdef AE350_UART1_SUPPORT
	X_uart1_dcdn	= 1'b1;
	X_uart1_dsrn 	= 1'b1;
	X_uart1_rin  	= 1'b1;
`endif

`ifdef AE350_UART2_SUPPORT
	X_uart2_dcdn 	= 1'b1;
	X_uart2_dsrn 	= 1'b1;
	X_uart2_rin  	= 1'b1;
`endif
end



`ifdef AE350_UART1_SUPPORT
`ifdef AE350_UART2_SUPPORT
always @* begin
	if ($test$plusargs("uart1_uart2"))
		X_uart1_rxd = X_uart2_txd;
	else
		X_uart1_rxd = 1'b1;
end

always @* begin
	if ($test$plusargs("uart1_uart2"))
		X_uart2_rxd = X_uart1_txd;
	else
		X_uart2_rxd = 1'b1;
end
`ifndef NDS_FPGA
always @* begin
	if ($test$plusargs("uart1_uart2"))
		X_uart1_ctsn = X_uart2_rtsn;
	else
		X_uart1_ctsn = 1'b1;
end

always @* begin
	if ($test$plusargs("uart1_uart2"))
		X_uart2_ctsn = X_uart1_rtsn;
	else
		X_uart2_ctsn = 1'b1;
end
`endif
`endif
`endif


`ifdef NDS_SPI4_TEST
	`define NDS_SPI 	`NDS_SPI4
	`define EPD		`NDS_BENCH_TOP.epd_model4
	`define EPD_DATA	`EPD.dtm
`elsif NDS_SPI3_TEST
	`define NDS_SPI 	`NDS_SPI3
	`define EPD		`NDS_BENCH_TOP.epd_model3
	`define EPD_DATA	`EPD.dtm
`elsif NDS_SPI2_TEST
	`define NDS_SPI 	`NDS_SPI2
	`define EPD		`NDS_BENCH_TOP.epd_model2
	`define EPD_DATA	`EPD.dtm
`else
	`define NDS_SPI 	`NDS_SPI1
	`define EPD		`NDS_BENCH_TOP.epd_model1
	`define EPD_DATA	`EPD.dtm
`endif

// synthesis translate_off
	`ifdef NDS_IO_BIU_X2
assign X_cpu_araddr  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_araddr;
assign X_cpu_arburst = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_arburst;
assign X_cpu_arcache = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_arcache;
assign X_cpu_arid    = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_arid;
assign X_cpu_arlen   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_arlen;
assign X_cpu_arlock  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_arlock;
assign X_cpu_arprot  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_arprot;
assign X_cpu_arready = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_arready;
assign X_cpu_arsize  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_arsize;
assign X_cpu_arvalid = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_arvalid;
assign X_cpu_awaddr  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_awaddr;
assign X_cpu_awburst = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_awburst;
assign X_cpu_awcache = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_awcache;
assign X_cpu_awid    = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_awid;
assign X_cpu_awlen   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_awlen;
assign X_cpu_awlock  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_awlock;
assign X_cpu_awprot  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_awprot;
assign X_cpu_awready = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_awready;
assign X_cpu_awsize  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_awsize;
assign X_cpu_awvalid = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_awvalid;
assign X_cpu_bid     = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_bid;
assign X_cpu_bready  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_bready;
assign X_cpu_bresp   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_bresp;
assign X_cpu_bvalid  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_bvalid;
assign X_cpu_rdata   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_rdata;
assign X_cpu_rid     = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_rid;
assign X_cpu_rlast   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_rlast;
assign X_cpu_rready  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_rready;
assign X_cpu_rresp   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_rresp;
assign X_cpu_rvalid  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_rvalid;
assign X_cpu_wdata   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_wdata;
assign X_cpu_wlast   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_wlast;
assign X_cpu_wready  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_wready;
assign X_cpu_wstrb   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_wstrb;
assign X_cpu_wvalid  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_d_wvalid;
assign X_aclk        = `NDS_PLATFORM_CORE.ae350_bus_connector.aclk;
assign X_aresetn     = `NDS_PLATFORM_CORE.ae350_bus_connector.aresetn;
	`else
assign X_cpu_araddr  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_araddr;
assign X_cpu_arburst = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_arburst;
assign X_cpu_arcache = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_arcache;
assign X_cpu_arid    = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_arid;
assign X_cpu_arlen   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_arlen;
assign X_cpu_arlock  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_arlock;
assign X_cpu_arprot  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_arprot;
assign X_cpu_arready = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_arready;
assign X_cpu_arsize  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_arsize;
assign X_cpu_arvalid = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_arvalid;
assign X_cpu_awaddr  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_awaddr;
assign X_cpu_awburst = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_awburst;
assign X_cpu_awcache = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_awcache;
assign X_cpu_awid    = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_awid;
assign X_cpu_awlen   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_awlen;
assign X_cpu_awlock  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_awlock;
assign X_cpu_awprot  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_awprot;
assign X_cpu_awready = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_awready;
assign X_cpu_awsize  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_awsize;
assign X_cpu_awvalid = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_awvalid;
assign X_cpu_bid     = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_bid;
assign X_cpu_bready  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_bready;
assign X_cpu_bresp   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_bresp;
assign X_cpu_bvalid  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_bvalid;
assign X_cpu_rdata   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_rdata;
assign X_cpu_rid     = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_rid;
assign X_cpu_rlast   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_rlast;
assign X_cpu_rready  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_rready;
assign X_cpu_rresp   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_rresp;
assign X_cpu_rvalid  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_rvalid;
assign X_cpu_wdata   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_wdata;
assign X_cpu_wlast   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_wlast;
assign X_cpu_wready  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_wready;
assign X_cpu_wstrb   = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_wstrb;
assign X_cpu_wvalid  = `NDS_PLATFORM_CORE.ae350_bus_connector.cpu_wvalid;
assign X_aclk        = `NDS_PLATFORM_CORE.ae350_bus_connector.aclk;
assign X_aresetn     = `NDS_PLATFORM_CORE.ae350_bus_connector.aresetn;
	`endif

always @(`NDS_SIM_CONTROL.rd_en_d1, `NDS_SIM_CONTROL.rd_en3_d1) begin
	if (`NDS_SIM_CONTROL.rd_en_d1 || `NDS_SIM_CONTROL.rd_en3_d1) begin
		force   `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hrdata = `NDS_SIM_CONTROL.hrdata;
		$display("%0t:%m: force `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hrdata = `NDS_SIM_CONTROL.hrdata", $time);
	end
	else begin
		release `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hrdata;
	end
end

assign H_hclk		= `NDS_PLATFORM_CORE.hclk;
assign H_hresetn	= `NDS_PLATFORM_CORE.hresetn;
assign H_hm0_haddr	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_haddr;
assign H_hm0_htrans	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_htrans;
assign H_hm0_hwrite	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hwrite;
assign H_hm0_hsize	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hsize;
assign H_hm0_hburst	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hburst;
assign H_hm0_hprot	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hprot;
assign H_hm0_hwdata	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hwdata;
assign H_hm0_hreadyi	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hready;
assign H_hm0_hmaster	= 4'h0;
assign H_hm0_hmastlock	= 1'b0;
assign H_hm0_hrdata	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hrdata;
assign H_hm0_hresp	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hresp;
assign H_hm0_hselx	= 32'h1;
assign H_hs0_haddr	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_haddr;
assign H_hs0_htrans	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_htrans;
assign H_hs0_hwrite	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hwrite;
assign H_hs0_hsize	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hsize;
assign H_hs0_hburst	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hburst;
assign H_hs0_hprot	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hprot;
assign H_hs0_hwdata	= `NDS_PLATFORM_CORE.ae350_bus_connector.hbmc_hwdata;
assign H_hs0_hreadyi	= `NDS_AHBDEC.hready;
assign H_hs0_hmaster	= 4'b0;
assign H_hs0_hmastlock	= 1'b0;
assign H_hs0_hrdata	= `NDS_AHBDEC.ds0_hrdata;
assign H_hs0_hresp	= {1'b0,`NDS_AHBDEC.ds0_hresp};
assign H_hs0_hsel	= `NDS_AHBDEC.ds0_hsel;
assign H_hs0_hselx	= {31'h0, `NDS_AHBDEC.ds0_hsel};

// synthesis translate_on

always @(`NDS_SIM_CONTROL.event_finish) begin
	#5;
	$display("%0t:ipipe:sim_ctrl finish=%0d", $time, `NDS_SIM_CONTROL.finish_status);
	$finish;
end

initial begin: error_termination
	reg [31:0]	error_status;

	fork: error_trap
`ifdef NDS_TB_PAT
		begin
			wait_model_error;
			get_program_status(error_status);
			disable error_trap;
		end
`endif
		begin
			`NDS_GPIO_MODEL.wait_model_error;
			`NDS_GPIO_MODEL.get_program_status(error_status);
			disable error_trap;
		end
`ifdef AE350_I2C_SUPPORT
		begin
			`NDS_I2C_MASTER.wait_model_error;
			`NDS_I2C_MASTER.get_program_status(error_status);
			disable error_trap;
		end
`endif
	join

	#10;
	$display("%0t:ERROR: ---- SIMULATION FAILED with status %0d ----", $time, error_status);
	$finish;
end

`ifndef AE350_SPI1_SUPPORT
	initial begin
		#5;
		$display("%0t:ipipe: ---- SIMULATION SKIPPED ---- ('SPI1' should be configured for using this testbench.)", $time);
		$finish;
	end
`endif
generate
if (PLATFORM_RESET_VECTOR != PLATFORM_SPI_MEM_BASE) begin : gen_reset_vector_checker
	initial begin
		#5;
		$display("%0t:ipipe: ---- SIMULATION SKIPPED ---- ('Reset Vector Address' should be assigned to SPI MEM Base Address for using this testbench.)", $time);
		$finish;
	end
end
endgenerate

`ifndef NDS_SKIP_LM_SIZE_CHECK
generate
if (ILM_SIZE_KB > 2048) begin : gen_ilm_size_checker
	initial begin
		#5;
		$display("%0t:ipipe: ---- SIMULATION SKIPPED ---- ('ILM Size' should be less than 2MiB for using this testbench.)", $time);
		$finish;
	end
end
if (ILM_SIZE_KB > 0 && ILM_BASE !='h0) begin : gen_ilm_base_checker
	initial begin
		#5;
		$display("%0t:ipipe: ---- SIMULATION SKIPPED ---- ('ILM Base' should be assigned to 0x0 for using this testbench when ILM Size is larger than 0 KiB.)", $time);
		$finish;
	end
end
endgenerate
generate
if (DLM_SIZE_KB > 2048) begin : gen_dlm_size_checker
	initial begin
		#5;
		$display("%0t:ipipe: ---- SIMULATION SKIPPED ---- ('DLM Size' should be less than 2MiB for using this testbench.)", $time);
		$finish;
	end
end
endgenerate
`endif
`ifndef NDS_SKIP_MISALIGNED_DEVICE_SLAVE_PORT_CHECK
generate
if ((DLM_SIZE_KB >= 32) && (SLAVE_PORT_SUPPORT == "yes") && (SLVP_DEVICE == 1'b1)) begin : gen_misaligned_access_device_space
	initial begin
		#5;
		$display("%0t:ipipe: ---- SIMULATION SKIPPED ---- (The testbench does not support misaligned access to device space through Slave Port)", $time);
		$finish;
	end
end
endgenerate
`endif

generate
if ((SLAVE_PORT_SUPPORT == "yes") && (SLAVE_PORT_ID_WIDTH < (BIU_ID_WIDTH + 4))) begin : gen_slave_port_id_width_checker
	initial begin
		#5;
		$display("%0t:ipipe: ---- SIMULATION SKIPPED ---- ('Slave Port ID Width' should be larger than or equal to BIU ID Width + 4 for using this testbench.)", $time);
		$finish;
	end
end
endgenerate

`ifdef NDS_ATCDMAC300_TEST
generate
if ((DLM_SIZE_KB != 0) && ((DLM_SIZE_KB < 32) || (SLAVE_PORT_SUPPORT == "no"))) begin : gen_atcdmac300_test_checker
	initial begin
		#5;
		$display("%0t:ipipe: ---- SIMULATION SKIPPED ---- (A suitable test memory region cannot be found to run this test when the Slave Port is configured out or DLM Size is too small.)", $time);
		$finish;
	end
end
endgenerate
`endif

`ifdef NDS_PLATFORM_TEST_IOCP_LATENCY
generate
if (IOCP_NUM==0) begin: gen_IOCP_latency_test_checker
	initial begin
		#5;
		$display("%0t:ipipe: ---- SIMULATION SKIPPED ---- ('I/O Coherence Port' should be configured to run this test.)", $time);
		$finish;
	end
end
endgenerate
`endif


`ifdef NDS_NCEPLDM200_TEST
generate
if (DEBUG_SUPPORT == "no") begin : gen_ncepldm200_test_checker
	initial begin
		#5;
		$display("%0t:ipipe: ---- SIMULATION SKIPPED ---- ('Debug Support' should be configured to run this test.)", $time);
		$finish;
	end
end
else if (PLATFORM_DEBUG_VECTOR != PLATFORM_PLDM_REGS_BASE) begin : gen_ncepldm200_debug_vector_checker
	initial begin
		#5;
		$display("%0t:ipipe: ---- SIMULATION SKIPPED ---- ('Debug Vector Address' should be assigned to the base address of the Debug Module (PLDM) to run this test.)", $time);
		$finish;
	end
end
endgenerate

`endif

`ifdef NDS_ATCSPI200_TEST
generate
if ((L2C_SUPPORT == 1) && (SPI1_MEM_DEVICE == 0)) begin : gen_atcspi200_test_checker
	initial begin
		#5;
		$display("%0t:ipipe: ---- SIMULATION SKIPPED ---- ('SPI MEM Base Address' should be assigned to the Device Region to run this test.)", $time);
		$finish;
	end
end
endgenerate
`endif

generate
if ((IOCP_NUM >= 1) && (IOCP_ID_WIDTH < (BIU_ID_WIDTH + 4))) begin : gen_iocp_id_width_checker
	initial begin
		#5;
		$display("%0t:ipipe: ---- SIMULATION SKIPPED ---- ('I/O Coherence Port ID Width' should be larger than or equal to BIU ID Width + 4 for using this testbench.)", $time);
		$finish;
	end
end
endgenerate



always @(`NDS_SIM_CONTROL.event_model_14) begin
	$display("%0t:power_analysis:tcf_dump_start", $time);
end

always @(`NDS_SIM_CONTROL.event_model_15) begin
	$display("%0t:power_analysis:tcf_dump_end", $time);
end
assign core_resetn = `NDS_CPU_SUBSYSTEM.core_resetn[(NHART-1):0];
assign #1 core_resetn_d1 = core_resetn;
assign X_pd_pwr_off = `NDS_PLATFORM_CORE.X_mpd_pwr_off;
assign #1 X_mpd_pwr_off_d1 = X_pd_pwr_off;

`ifdef NDS_PLATFORM_TEST_DEEPSLEEP
	assign ilm_init_posedge_trigger = core_resetn_d1;
`else
	assign ilm_init_posedge_trigger = {NHART{~X_mpd_pwr_off_d1}};
`endif

// synthesis translate_off


`ifndef NDS_SKIP_LM_SIZE_CHECK
generate
if ((ILM_SIZE_KB != 0) && (XLEN == 64)) begin : gen_rv64_init_ilm0
	reg [VALEN-1:0] vma_addr;
	reg [31:0] ilm_word;
	reg [71:0] mem_data72;
	integer	   ilm_idx;
	always @(posedge X_por_b or posedge ilm_init_posedge_trigger[0]) begin
		$display("%0t:%m:INFO:Initialize ILM with NDSROM.dat content.", $time);
		$display("%0t:ipipe:0:fast_reset milmb=%h", $realtime, 1'b1);
		vma_addr = {VALEN{1'h0}};
		for (ilm_idx = 0; ilm_idx < ILM_WORD_SIZE; ilm_idx = ilm_idx + 1) begin
			ilm_word = ((^data[ilm_idx]) === 1'bx) ? 32'h0 : data[ilm_idx];
			mem_data72[31:0] = {ilm_word[7:0], ilm_word[15:8], ilm_word[23:16], ilm_word[31:24]};
			if (tb_debug_mon && (mem_data72[31:0] != 32'h0)) begin
				$display("%0t:ipipe:0:ext update pa:%x mask:f data:%x", $time, vma_addr + (ILM_BASE << 2), mem_data72[31:0]);
			end
			vma_addr = vma_addr + {{(VALEN-3){1'h0}}, 3'h4};
			ilm_word = ((^data[ilm_idx+1]) === 1'bx) ? 32'd0 : data[ilm_idx+1];
			mem_data72[63:32] = {ilm_word[7:0], ilm_word[15:8], ilm_word[23:16], ilm_word[31:24]};
			if (ILM_ECC_TYPE == "ecc") begin
		                mem_data72[71:64] = ecc64_gen(mem_data72[63:0]);
	                end
	                else if (ILM_ECC_TYPE == "parity") begin
	                        mem_data72[71:64] = parity64_gen(mem_data72[63:0]);
	                end
                      `ifdef NDS_IO_ILM_RAM0
  	       		`NDS_ILM0.u_ilm_ram0.ram_inst.mem[ilm_idx[31:1]] = mem_data72[ILM_RAM_DW-1:0];
			    `endif
                      `ifdef NDS_IO_ILM_TL_UL
                          `NDS_CPU_SUBSYSTEM.gen_tl_ul_ram0.u_ilm_tl_ul_ram0.ram_inst.mem[ilm_idx[31:1]]  = mem_data72[ILM_RAM_DW-1:0];

                      `endif

			ilm_idx = ilm_idx+1;

			if (tb_debug_mon && (mem_data72[63:32] != 32'h0)) begin
					$display("%0t:ipipe:0:ext update pa:%x mask:f data:%x", $time, vma_addr + (ILM_BASE << 2), mem_data72[63:32]);
			end
			vma_addr = vma_addr + {{(VALEN-3){1'h0}}, 3'h4};
		end
		$display("%0t:ipipe:0:fast_reset milmb=%h", $realtime, 1'b0);
	end
end
endgenerate
generate
if ((ILM_SIZE_KB != 0) && (XLEN == 32)) begin : gen_rv32_init_ilm0
	reg [VALEN-1:0] vma_addr;
	reg [31:0] ilm_word;
	reg [71:0] mem_data72;
	integer	   ilm_idx;
	always @(posedge X_por_b or posedge ilm_init_posedge_trigger[0]) begin
		$display("%0t:%m:INFO:Initialize ILM with NDSROM.dat content.", $time);
		$display("%0t:ipipe:0:fast_reset milmb=%h", $realtime, 1'b1);
		vma_addr = {VALEN{1'h0}};
		for (ilm_idx = 0; ilm_idx < ILM_WORD_SIZE; ilm_idx = ilm_idx + 1) begin
			ilm_word = ((^data[ilm_idx]) === 1'bx) ? 32'h0 : data[ilm_idx];
			mem_data72[31:0] = {ilm_word[7:0], ilm_word[15:8], ilm_word[23:16], ilm_word[31:24]};
			if (tb_debug_mon && (mem_data72[31:0] != 32'h0)) begin
				$display("%0t:ipipe:0:ext update pa:%x mask:f data:%x", $time, vma_addr + (ILM_BASE << 2), mem_data72[31:0]);
			end
			vma_addr = vma_addr + {{(VALEN-3){1'h0}}, 3'h4};
			if (ILM_ECC_TYPE == "ecc") begin
	 	               mem_data72[38:32] = ecc32_gen(mem_data72[31:0]);
	                end
	                else if (ILM_ECC_TYPE == "parity") begin
	                       mem_data72[35:32] = parity32_gen(mem_data72[31:0]);
	                end
			    `ifdef NDS_IO_ILM_RAM1
			        if (ilm_idx[0]) begin
			            `NDS_ILM0.u_ilm_ram1.ram_inst.mem[ilm_idx[31:1]] = mem_data72[ILM_RAM_DW-1:0];
				end
				else begin
			            `NDS_ILM0.u_ilm_ram0.ram_inst.mem[ilm_idx[31:1]] = mem_data72[ILM_RAM_DW-1:0];
				end
				`endif
				`ifdef NDS_IO_ILM_TL_UL
                              if (ilm_idx[0])
                                `NDS_CPU_SUBSYSTEM.gen_tl_ul_ram1.u_ilm_tl_ul_ram1.ram_inst.mem[ilm_idx[31:1]] = mem_data72[ILM_RAM_DW-1:0];
                              else
                                `NDS_CPU_SUBSYSTEM.gen_tl_ul_ram0.u_ilm_tl_ul_ram0.ram_inst.mem[ilm_idx[31:1]] = mem_data72[ILM_RAM_DW-1:0];

				`endif

		end
		$display("%0t:ipipe:0:fast_reset milmb=%h", $realtime, 1'b0);
	end
end
endgenerate







`endif


`ifndef NDS_SKIP_LM_SIZE_CHECK
generate
if (DLM_SIZE_KB != 0) begin : gen_init_hart0_dlm
	reg [VALEN-1:0] vma_addr;
	reg [31:0] dlm_word;
	reg [71:0] mem_data72;
	integer	   dlm_idx;
	always @(posedge X_por_b) begin
		$display("%0t:%m:INFO:Initialize DLM with NDSROM.dat content.", $time);
		vma_addr = {VALEN{1'h0}};
		for (dlm_idx = 0; dlm_idx < DLM_WORD_SIZE; dlm_idx = dlm_idx + 1) begin
			dlm_word = ((^data[dlm_idx]) === 1'bx) ? 32'h0 : data[dlm_idx];
			mem_data72[31:0] = {dlm_word[7:0], dlm_word[15:8], dlm_word[23:16], dlm_word[31:24]};
			if (tb_debug_mon && (mem_data72[31:0] != 32'h0)) begin
				$display("%0t:ipipe:0:ext update pa:%x mask:f data:%x", $time, vma_addr + (DLM_BASE << 2), mem_data72[31:0]);
			end
			vma_addr = vma_addr + {{(VALEN-3){1'h0}}, 3'h4};
			if (XLEN == 64) begin
				dlm_word = ((^data[dlm_idx+1]) === 1'bx) ? 32'd0 : data[dlm_idx+1];
				mem_data72[63:32] = {dlm_word[7:0], dlm_word[15:8], dlm_word[23:16], dlm_word[31:24]};
				if (DLM_ECC_TYPE == "ecc") begin
		                        mem_data72[71:64] = ecc64_gen(mem_data72[63:0]);
	                        end
	                        else if (DLM_ECC_TYPE == "parity") begin
	                                mem_data72[71:64] = parity64_gen(mem_data72[63:0]);
	                        end
                          `ifndef NDS_IO_DLM_RAM1
				      `NDS_HART0_DLM0[dlm_idx[31:1]] = mem_data72[DLM_RAM_DW-1:0];
                          `endif
                          `ifdef NDS_IO_DLM_RAM1
                          `ifdef NDS_IO_DLM_RAM3
                          if (dlm_idx[2:1] == 2'b00) begin
				      `NDS_HART0_DLM0[dlm_idx[31:3]] = mem_data72[DLM_RAM_DW-1:0];
                          end
                          if (dlm_idx[2:1] == 2'b01) begin
				      `NDS_HART0_DLM1[dlm_idx[31:3]] = mem_data72[DLM_RAM_DW-1:0];
                          end
                          if (dlm_idx[2:1] == 2'b10) begin
				      `NDS_HART0_DLM2[dlm_idx[31:3]] = mem_data72[DLM_RAM_DW-1:0];
                          end
                          if (dlm_idx[2:1] == 2'b11) begin
				      `NDS_HART0_DLM3[dlm_idx[31:3]] = mem_data72[DLM_RAM_DW-1:0];
                          end
                          `else
                          if (dlm_idx[1] == 0) begin
				      `NDS_HART0_DLM0[dlm_idx[31:2]] = mem_data72[DLM_RAM_DW-1:0];
                          end
                          if (dlm_idx[1] == 1) begin
				      `NDS_HART0_DLM1[dlm_idx[31:2]] = mem_data72[DLM_RAM_DW-1:0];
                          end
                          `endif
                          `endif

				dlm_idx = dlm_idx+1;

				if (tb_debug_mon && (mem_data72[63:32] != 32'h0)) begin
					$display("%0t:ipipe:0:ext update pa:%x mask:f data:%x", $time, vma_addr + (DLM_BASE << 2), mem_data72[63:32]);
				end
				vma_addr = vma_addr + {{(VALEN-3){1'h0}}, 3'h4};
			end
			else begin
				if (DLM_ECC_TYPE == "ecc") begin
	 	                       mem_data72[38:32] = ecc32_gen(mem_data72[31:0]);
	                        end
	                        else if (DLM_ECC_TYPE == "parity") begin
	                               mem_data72[35:32] = parity32_gen(mem_data72[31:0]);
	                        end
                          `ifndef NDS_IO_DLM_RAM1
				      `NDS_HART0_DLM0[dlm_idx] = mem_data72[DLM_RAM_DW-1:0];
                          `endif
                          `ifdef NDS_IO_DLM_RAM1
                          `ifdef NDS_IO_DLM_RAM3
                          if (dlm_idx[1:0] == 2'b00) begin
				      `NDS_HART0_DLM0[dlm_idx[31:2]] = mem_data72[DLM_RAM_DW-1:0];
                          end
                          if (dlm_idx[1:0] == 2'b01) begin
				      `NDS_HART0_DLM1[dlm_idx[31:2]] = mem_data72[DLM_RAM_DW-1:0];
                          end
                          if (dlm_idx[1:0] == 2'b10) begin
				      `NDS_HART0_DLM2[dlm_idx[31:2]] = mem_data72[DLM_RAM_DW-1:0];
                          end
                          if (dlm_idx[1:0] == 2'b11) begin
				      `NDS_HART0_DLM3[dlm_idx[31:2]] = mem_data72[DLM_RAM_DW-1:0];
                          end
                          `else
                          if (dlm_idx[0] == 0) begin
				      `NDS_HART0_DLM0[dlm_idx[31:1]] = mem_data72[DLM_RAM_DW-1:0];
                          end
                          if (dlm_idx[0] == 1) begin
				      `NDS_HART0_DLM1[dlm_idx[31:1]] = mem_data72[DLM_RAM_DW-1:0];
                          end
                          `endif
                          `endif
			end
		end
	end
end
endgenerate














`endif










integer	   ram_idx;
integer	   ram_idx_inc;
`ifdef NDS_L2C_BIU_DATA_WIDTH
localparam BIU_DATA_WIDTH	= `NDS_L2C_BIU_DATA_WIDTH;
`else
localparam BIU_DATA_WIDTH	= `NDS_BIU_DATA_WIDTH;
`endif
localparam BIU_DATA_MSB		= BIU_DATA_WIDTH - 1;
localparam BIU_DATA_RATIO	= BIU_DATA_WIDTH/32;
generate
reg [31:0] ram_word[0:(BIU_DATA_RATIO-1)];
reg [BIU_DATA_MSB+32:0] mem_data;
always @(posedge X_por_b) begin
	$display("%0t:%m:INFO:Initialize RAM with NDSROM.dat content.", $time);
	for (ram_idx = 0; ram_idx < IMAGE_SIZE; ram_idx = ram_idx + BIU_DATA_RATIO) begin
		for (ram_idx_inc = 0; ram_idx_inc < BIU_DATA_RATIO; ram_idx_inc = ram_idx_inc + 1) begin
			ram_word[ram_idx_inc] = ((^data[ram_idx + ram_idx_inc]) === 1'bx) ? 32'h0 : data[ram_idx + ram_idx_inc];
			mem_data[BIU_DATA_MSB+32:0] = {
					ram_word[ram_idx_inc][7:0],
					ram_word[ram_idx_inc][15:8],
					ram_word[ram_idx_inc][23:16],
					ram_word[ram_idx_inc][31:24],
					mem_data[BIU_DATA_MSB+32:32]};
		end
			`NDS_RAM[ram_idx/BIU_DATA_RATIO] = mem_data[BIU_DATA_MSB+32:32];
	end
end
endgenerate



wire u_plic_support = `NDS_CPU_SUBSYSTEM.u_plic.VECTOR_PLIC_SUPPORT == "yes";
wire c_plic_support = `NDS_CORE0_TOP.VECTOR_PLIC_SUPPORT_INT == `NDS_CFG_YES;
initial begin
	#10
	if ( (u_plic_support && ~c_plic_support) || ( ~u_plic_support && c_plic_support) ) begin
		#5;
		$display("%0t:ipipe:%0d:ERROR: VECTOR_PLIC_SUPPORT not match, support parameter in plic:%0d, in core_top:%0d", $time, 0, u_plic_support, c_plic_support);
		$finish;
	end
end





// synthesis translate_on

`ifdef AE350_SPI1_SUPPORT
`ifndef NDS_SPI_SLAVE_TEST
`ifndef NDS_SPI_3LINE_EPD
always @(posedge X_por_b) begin
	copy_image_to_spi_rom;
end

task copy_image_to_spi_rom;
parameter LOADER_SIZE = 32'h1000;
parameter SPI_BASE    = {`SAMPLE_AE350_SMU_RESET_VECTOR_HI_DEFAULT, `SAMPLE_AE350_SMU_RESET_VECTOR_LO_DEFAULT};
// synthesis translate_off
reg	[31:0]	data_32b;
reg	[31:0]	i;
reg 	[VALEN-1:0] vma_addr;
// synthesis translate_on

begin

	$display("%0t:%m:INFO:Copy loader data to SPI flash", $time);

	// synthesis translate_off
	vma_addr = {VALEN{1'h0}};
	vma_addr[31:0] = SPI_BASE[31:0];
	for (i = 32'h0; i < LOADER_SIZE; i = i + 32'h1) begin
		data_32b = loader_data[i];
		if (data_32b !== 32'hx) begin
			`SPI_FLASH_DATA[4*i  ][7:0] = data_32b[31:24];
			`SPI_FLASH_DATA[4*i+1][7:0] = data_32b[23:16];
			`SPI_FLASH_DATA[4*i+2][7:0] = data_32b[15:8];
			`SPI_FLASH_DATA[4*i+3][7:0] = data_32b[7:0];
			if (tb_debug_mon) begin
				$display("%0t:ipipe:ext update pa:%x mask:f data:%x", $time, vma_addr,
				{data_32b[7:0], data_32b[15:8], data_32b[23:16], data_32b[31:24]});
			end
		end
		vma_addr = vma_addr + 32'h4;
	end
	// synthesis translate_on
end
endtask
`endif
`endif
`endif


// synthesis translate_off
// synthesis translate_on



	// synthesis translate_off


	// synthesis translate_on

`ifdef NDS_SPI_SLAVE_TEST
reg [63:0] remap_reset_vector;

initial begin
	
		if (`ATCBMC300_ADDR_WIDTH == 64) begin : gen_atcbmc300_addr_eq_64
			remap_reset_vector = `ATCBMC300_SLV2_BASE_ADDR;
		end
		else begin : gen_atcbmc300_addr_lt_64
			remap_reset_vector = {{(64-`ATCBMC300_ADDR_WIDTH){1'b0}}, `ATCBMC300_SLV2_BASE_ADDR};
		end

	remap_reset_vector = remap_reset_vector + 64'h80;
	if (!(({`NDS_SMU.smu_apbif.RESET_VECTOR_HI_DEFAULT, `NDS_SMU.smu_apbif.RESET_VECTOR_DEFAULT} == remap_reset_vector) || (ILM_SIZE_KB == 0))) begin
		remap_reset_vector = `NDS_ILM_BASE + 64'h80;
	end

	force  `NDS_PLATFORM_CHIP.core_reset_vectors[63:0] = remap_reset_vector;
	$display("%0t:%m:INFO:force core0_reset_vector to 64'h%x when NDS_SPI_SLAVE_TEST is defined", $time, remap_reset_vector);
end
`endif

`define NDS_OSCH_PERIOD `AE350_OSCH_PERIOD
`ifdef NDS_TB_PAT
	`include "sync_tasks.vh"
	`include "nds_tb.pat"
`endif

initial begin
        $timeformat(-9, 2, " ns");
end

function [6:0] ecc32_gen;
input   [31:0]  data;
reg     [6:0]   code;
begin
        code[0] =       data[30] ^ data[28] ^ data[26] ^ data[25] ^ data[23] ^ data[21] ^ data[19] ^ data[17] ^ data[15] ^ data[13]
                        ^ data[11] ^ data[10] ^ data[ 8] ^ data[ 6] ^ data[ 4] ^ data[ 3] ^ data[ 1] ^ data[ 0] ;
        code[1] =       data[31] ^ data[28] ^ data[27] ^ data[25] ^ data[24] ^ data[21] ^ data[20] ^ data[17] ^ data[16] ^ data[13]
                        ^ data[12] ^ data[10] ^ data[ 9] ^ data[ 6] ^ data[ 5] ^ data[ 3] ^ data[ 2] ^ data[ 0] ;
        code[2] =       data[31] ^ data[30] ^ data[29] ^ data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[17] ^ data[16] ^ data[15]
                        ^ data[14] ^ data[10] ^ data[ 9] ^ data[ 8] ^ data[ 7] ^ data[ 3] ^ data[ 2] ^ data[ 1] ;
        code[3] =       data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[21] ^ data[20] ^ data[19] ^ data[18] ^ data[10] ^ data[ 9]
                        ^ data[ 8] ^ data[ 7] ^ data[ 6] ^ data[ 5] ^ data[ 4] ;
        code[4] =       data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[21] ^ data[20] ^ data[19] ^ data[18] ^ data[17] ^ data[16]
                        ^ data[15] ^ data[14] ^ data[13] ^ data[12] ^ data[11] ;
        code[5] =       (data[31] ^ data[30] ^ data[29] ^ data[28] ^ data[27] ^ data[26] );
        code[6] =       (data[29] ^ data[27] ^ data[26] ^ data[24] ^ data[23] ^ data[21] ^ data[18] ^ data[17] ^ data[14] ^ data[12]
                        ^ data[11] ^ data[10] ^ data[ 7] ^ data[ 5] ^ data[ 4] ^ data[ 2] ^ data[ 1] ^ data[ 0] );
        ecc32_gen = code;
end
endfunction

function [7:0] ecc64_gen;
input   [63:0]  data;
reg     [7:0]   code;
begin
        code[ 0] =        data[63] ^ data[61] ^ data[59] ^ data[57] ^ data[56] ^ data[54] ^ data[52] ^ data[50] ^ data[48] ^ data[46]
                        ^ data[44] ^ data[42] ^ data[40] ^ data[38] ^ data[36] ^ data[34] ^ data[32] ^ data[30] ^ data[28] ^ data[26]
                        ^ data[25] ^ data[23] ^ data[21] ^ data[19] ^ data[17] ^ data[15] ^ data[13] ^ data[11] ^ data[10] ^ data[ 8]
                        ^ data[ 6] ^ data[ 4] ^ data[ 3] ^ data[ 1] ^ data[ 0] ;
        code[ 1] =        data[63] ^ data[62] ^ data[59] ^ data[58] ^ data[56] ^ data[55] ^ data[52] ^ data[51] ^ data[48] ^ data[47]
                        ^ data[44] ^ data[43] ^ data[40] ^ data[39] ^ data[36] ^ data[35] ^ data[32] ^ data[31] ^ data[28] ^ data[27]
                        ^ data[25] ^ data[24] ^ data[21] ^ data[20] ^ data[17] ^ data[16] ^ data[13] ^ data[12] ^ data[10] ^ data[ 9]
                        ^ data[ 6] ^ data[ 5] ^ data[ 3] ^ data[ 2] ^ data[ 0] ;
        code[ 2] =        data[63] ^ data[62] ^ data[61] ^ data[60] ^ data[56] ^ data[55] ^ data[54] ^ data[53] ^ data[48] ^ data[47]
                        ^ data[46] ^ data[45] ^ data[40] ^ data[39] ^ data[38] ^ data[37] ^ data[32] ^ data[31] ^ data[30] ^ data[29]
                        ^ data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[17] ^ data[16] ^ data[15] ^ data[14] ^ data[10] ^ data[ 9]
                        ^ data[ 8] ^ data[ 7] ^ data[ 3] ^ data[ 2] ^ data[ 1] ;
        code[ 3] =        data[56] ^ data[55] ^ data[54] ^ data[53] ^ data[52] ^ data[51] ^ data[50] ^ data[49] ^ data[40] ^ data[39]
                        ^ data[38] ^ data[37] ^ data[36] ^ data[35] ^ data[34] ^ data[33] ^ data[25] ^ data[24] ^ data[23] ^ data[22]
                        ^ data[21] ^ data[20] ^ data[19] ^ data[18] ^ data[10] ^ data[ 9] ^ data[ 8] ^ data[ 7] ^ data[ 6] ^ data[ 5]
                        ^ data[ 4] ;
        code[ 4] =        data[56] ^ data[55] ^ data[54] ^ data[53] ^ data[52] ^ data[51] ^ data[50] ^ data[49] ^ data[48] ^ data[47]
                        ^ data[46] ^ data[45] ^ data[44] ^ data[43] ^ data[42] ^ data[41] ^ data[25] ^ data[24] ^ data[23] ^ data[22]
                        ^ data[21] ^ data[20] ^ data[19] ^ data[18] ^ data[17] ^ data[16] ^ data[15] ^ data[14] ^ data[13] ^ data[12]
                        ^ data[11] ;
        code[ 5] =        data[56] ^ data[55] ^ data[54] ^ data[53] ^ data[52] ^ data[51] ^ data[50] ^ data[49] ^ data[48] ^ data[47]
                        ^ data[46] ^ data[45] ^ data[44] ^ data[43] ^ data[42] ^ data[41] ^ data[40] ^ data[39] ^ data[38] ^ data[37]
                        ^ data[36] ^ data[35] ^ data[34] ^ data[33] ^ data[32] ^ data[31] ^ data[30] ^ data[29] ^ data[28] ^ data[27]
                        ^ data[26] ;
        code[ 6] =      (data[63] ^ data[62] ^ data[61] ^ data[60] ^ data[59] ^ data[58] ^ data[57] );
        code[ 7] =      (data[63] ^ data[60] ^ data[58] ^ data[57] ^ data[56] ^ data[53] ^ data[51] ^ data[50] ^ data[47] ^ data[46]
                        ^ data[44] ^ data[41] ^ data[39] ^ data[38] ^ data[36] ^ data[33] ^ data[32] ^ data[29] ^ data[27] ^ data[26]
                        ^ data[24] ^ data[23] ^ data[21] ^ data[18] ^ data[17] ^ data[14] ^ data[12] ^ data[11] ^ data[10] ^ data[ 7]
                        ^ data[ 5] ^ data[ 4] ^ data[ 2] ^ data[ 1] ^ data[ 0] );
        ecc64_gen = code;
end
endfunction

function [3:0] parity32_gen;
input   [31:0]  data;
reg     [3:0]   code;
begin
        code[0] = ^data[7:0];
        code[1] = ^data[15:8];
        code[2] = ^data[23:16];
        code[3] = ^data[31:24];
        parity32_gen = code;
end
endfunction

function [7:0] parity64_gen;
input   [63:0]  data;
reg     [7:0]   code;
begin
        code[0] = ^data[7:0];
        code[1] = ^data[15:8];
        code[2] = ^data[23:16];
        code[3] = ^data[31:24];
        code[4] = ^data[39:32];
        code[5] = ^data[47:40];
        code[6] = ^data[55:48];
        code[7] = ^data[63:56];
        parity64_gen = code;
end
endfunction

`ifdef PLATFORM_DEBUG_PORT
genvar tapid;
generate
for (tapid = 0; tapid < JTAG_TAP_NUM; tapid += 1) begin : gen_jtag_taps
        if (tapid != DM_TAP_ID
        ) begin : gen_jtag_dummy_tap
                wire    tck     = `NDS_CHIP_AOPD.tap_tck [tapid];
                wire    trst    = `NDS_CHIP_AOPD.tap_trst[tapid];
                wire    tms     = `NDS_CHIP_AOPD.tap_tms [tapid];
                wire    tdi     = `NDS_CHIP_AOPD.tap_tdi [tapid];
                wire    tdo;
                `ifdef NDS_JTAG_DEVICE_MODEL
                        jtag_device dummy_tap (
                                .dbgi_n     (1'b1        ),
                                .edm_tck    (tck         ),
                                .edm_tdi    (tdi         ),
                                .edm_tms    (tms         ),
                                .edm_trst   (trst        ),
                                .jtagedm_ver(32'h0000063d),
                        .dbgack_n   (    ),
                        .edm_tdo    (tdo         )
                        );
                `else
                        assign tdo = tdi;
                `endif

                initial force `NDS_CHIP_AOPD.tap_tdo[tapid] = tdo;
        end
end
endgenerate
`endif

bind a45_core_top instn_simple_pipe_mon instn_simple_pipe_mon (.*);

endmodule


//-----------------------------------------------------------------------------
//	RapidSilicon
//	Author:	Michael Wood
//	Date:	3/9/2022
//-----------------------------------------------------------------------------
module memss
	#(
	parameter ADDR_WIDTH = 32,
	parameter SRAM_DWIDTH = 32,
	parameter DDR_DWIDTH = 128,
	parameter SRAM_SWIDTH = (SRAM_DWIDTH/8),
	parameter DDR_SWIDTH = (DDR_DWIDTH/8))
	(
	input				ddr_sys_clk,
	input				ddr_phy_clk,
	input				ddr_sys_resetn,
	input				sram_sys_clk,
	input				sram_sys_resetn,
	input 				ddr0_aclk,
	input 				ddr1_aclk,
	input 				ddr2_aclk,
	input 				ddr3_aclk,
	input 				sramb0_aclk,
	input 				sramb1_aclk,
	input 				sramb2_aclk,
	input 				sramb3_aclk,
	input 				cntl_aclk,
	input 				ddr0_aresetn,
	input 				ddr1_aresetn,
	input 				ddr2_aresetn,
	input 				ddr3_aresetn,
	input 				sramb0_aresetn,
	input 				sramb1_aresetn,
	input 				sramb2_aresetn,
	input 				sramb3_aresetn,
	input 				cntl_aresetn,
	input 				ddr0_awvalid,
	output 				ddr0_awready, 
	input 	[ADDR_WIDTH-1:0] 	ddr0_awaddr, 
	input 	[ 2:0] 			ddr0_awsize, 
	input 	[ 1:0]			ddr0_awburst,
	input 	[ 3:0]			ddr0_awcache, 
	input 	[ 2:0]			ddr0_awprot,
	input 				ddr0_awlock,
	input 	[ 3:0]			ddr0_awqos,
 	input 	[ 3:0]			ddr0_awid, 	
	input 	[ 3:0]			ddr0_awlen, 
	input 				ddr0_wvalid, 
	output 				ddr0_wready,
	input 				ddr0_wlast, 	
	input 	[DDR_DWIDTH-1:0]	ddr0_wdata, 
	input 	[DDR_SWIDTH-1:0]	ddr0_wstrb, 
	output 				ddr0_bvalid, 
	input 				ddr0_bready, 
	output 	[ 1:0]			ddr0_bresp, 
	output 	[ 3:0]			ddr0_bid, 	
	input 				ddr0_arvalid, 
	output 				ddr0_arready, 
	input 	[ADDR_WIDTH-1:0]	ddr0_araddr, 
	input 	[ 2:0]			ddr0_arsize, 
	input 	[ 1:0]			ddr0_arburst,
	input 	[ 3:0]			ddr0_arcache, 
	input 	[ 2:0]			ddr0_arprot, 
	input 				ddr0_arlock,
	input 	[ 3:0]			ddr0_arqos,
	input 	[ 3:0]			ddr0_arid, 
	input 	[ 3:0]			ddr0_arlen, 
	output 				ddr0_rvalid, 
	input 				ddr0_rready,
	output 				ddr0_rlast, 
	output 	[DDR_DWIDTH-1:0]	ddr0_rdata, 
	output 	[ 1:0]			ddr0_rresp, 
	output  [ 3:0]			ddr0_rid,
	input 				ddr1_awvalid,
	output 				ddr1_awready, 
	input 	[ADDR_WIDTH-1:0] 	ddr1_awaddr, 
	input 	[ 2:0] 			ddr1_awsize, 
	input 	[ 1:0]			ddr1_awburst,
	input 	[ 3:0]			ddr1_awcache, 
	input 	[ 2:0]			ddr1_awprot,
	input 				ddr1_awlock,
	input 	[ 3:0]			ddr1_awqos,
 	input 	[ 3:0]			ddr1_awid, 	
	input 	[ 3:0]			ddr1_awlen, 
	input 				ddr1_wvalid, 
	output 				ddr1_wready,
	input 				ddr1_wlast, 	
	input 	[DDR_DWIDTH-1:0]	ddr1_wdata, 
	input 	[DDR_SWIDTH-1:0]	ddr1_wstrb, 
	output 				ddr1_bvalid, 
	input 				ddr1_bready, 
	output 	[ 1:0]			ddr1_bresp, 
	output 	[ 3:0]			ddr1_bid, 	
	input 				ddr1_arvalid, 
	output 				ddr1_arready, 
	input 	[ADDR_WIDTH-1:0]	ddr1_araddr, 
	input 	[ 2:0]			ddr1_arsize, 
	input 	[ 1:0]			ddr1_arburst,
	input 	[ 3:0]			ddr1_arcache, 
	input 	[ 2:0]			ddr1_arprot, 
	input 				ddr1_arlock,
	input 	[ 3:0]			ddr1_arqos,
	input 	[ 3:0]			ddr1_arid, 
	input 	[ 3:0]			ddr1_arlen, 
	output 				ddr1_rvalid, 
	input 				ddr1_rready,
	output 				ddr1_rlast, 
	output 	[DDR_DWIDTH-1:0]	ddr1_rdata, 
	output  [ 1:0]			ddr1_rresp, 
	output 	[ 3:0]			ddr1_rid,
	input 				ddr2_awvalid,
	output 				ddr2_awready, 
	input 	[ADDR_WIDTH-1:0] 	ddr2_awaddr, 
	input 	[ 2:0] 			ddr2_awsize, 
	input 	[ 1:0]			ddr2_awburst,
	input 	[ 3:0]			ddr2_awcache, 
	input 	[ 2:0]			ddr2_awprot,
	input 				ddr2_awlock,
	input 	[ 3:0]			ddr2_awqos,
 	input 	[ 3:0]			ddr2_awid, 	
	input 	[ 3:0]			ddr2_awlen, 
	input 				ddr2_wvalid, 
	output 				ddr2_wready,
	input 				ddr2_wlast, 	
	input 	[DDR_DWIDTH-1:0]	ddr2_wdata, 
	input 	[DDR_SWIDTH-1:0]	ddr2_wstrb, 
	output 				ddr2_bvalid, 
	input 				ddr2_bready, 
	output 	[ 1:0]			ddr2_bresp, 
	output 	[ 3:0]			ddr2_bid, 	
	input 				ddr2_arvalid, 
	output 				ddr2_arready, 
	input 	[ADDR_WIDTH-1:0]	ddr2_araddr, 
	input 	[ 2:0]			ddr2_arsize, 
	input 	[ 1:0]			ddr2_arburst,
	input 	[ 3:0]			ddr2_arcache, 
	input 	[ 2:0]			ddr2_arprot, 
	input 				ddr2_arlock,
	input 	[ 3:0]			ddr2_arqos,
	input 	[ 3:0]			ddr2_arid, 
	input 	[ 3:0]			ddr2_arlen, 
	output 				ddr2_rvalid, 
	input 				ddr2_rready,
	output 				ddr2_rlast, 
	output 	[DDR_DWIDTH-1:0]	ddr2_rdata, 
	output 	[ 1:0]			ddr2_rresp, 
	output 	[ 3:0]			ddr2_rid,
	input 				ddr3_awvalid,
	output 				ddr3_awready, 
	input 	[ADDR_WIDTH-1:0] 	ddr3_awaddr, 
	input 	[ 2:0] 			ddr3_awsize, 
	input 	[ 1:0]			ddr3_awburst,
	input 	[ 3:0]			ddr3_awcache, 
	input 	[ 2:0]			ddr3_awprot,
	input 				ddr3_awlock,
	input 	[ 3:0]			ddr3_awqos,
 	input 	[ 3:0]			ddr3_awid, 	
	input 	[ 3:0]			ddr3_awlen, 
	input 				ddr3_wvalid, 
	output 				ddr3_wready,
	input 				ddr3_wlast, 	
	input 	[DDR_DWIDTH-1:0]	ddr3_wdata, 
	input 	[DDR_SWIDTH-1:0]	ddr3_wstrb, 
	output 				ddr3_bvalid, 
	input 				ddr3_bready, 
	output 	[ 1:0]			ddr3_bresp, 
	output 	[ 3:0]			ddr3_bid, 	
	input 				ddr3_arvalid, 
	output 				ddr3_arready, 
	input 	[ADDR_WIDTH-1:0]	ddr3_araddr, 
	input 	[ 2:0]			ddr3_arsize, 
	input 	[ 1:0]			ddr3_arburst,
	input 	[ 3:0]			ddr3_arcache, 
	input 	[ 2:0]			ddr3_arprot, 
	input 				ddr3_arlock,
	input 	[ 3:0]			ddr3_arqos,
	input 	[ 3:0]			ddr3_arid, 
	input 	[ 3:0]			ddr3_arlen, 
	output 				ddr3_rvalid, 
	input 				ddr3_rready,
	output 				ddr3_rlast, 
	output 	[DDR_DWIDTH-1:0]	ddr3_rdata, 
	output 	[ 1:0]			ddr3_rresp, 
	output 	[ 3:0]			ddr3_rid,
	input 				sramb0_awvalid,
	output 				sramb0_awready, 
	input 	[ADDR_WIDTH-1:0] 	sramb0_awaddr, 
	input 	[ 2:0] 			sramb0_awsize, 
	input 	[ 1:0]			sramb0_awburst,
 	input 	[ 3:0]			sramb0_awid, 	
	input 	[ 3:0]			sramb0_awlen, 
	input 				sramb0_wvalid, 
	output 				sramb0_wready,
	input 				sramb0_wlast, 	
	input 	[SRAM_DWIDTH-1:0]	sramb0_wdata, 
	input 	[SRAM_SWIDTH-1:0]	sramb0_wstrb, 
	input 	[ 3:0]			sramb0_wid, 	
	output 				sramb0_bvalid, 
	input 				sramb0_bready, 
	output 	[ 1:0]			sramb0_bresp, 
	output 	[ 3:0]			sramb0_bid, 	
	input 				sramb0_arvalid, 
	output 				sramb0_arready, 
	input 	[ADDR_WIDTH-1:0]	sramb0_araddr, 
	input 	[ 2:0]			sramb0_arsize, 
	input 	[ 1:0]			sramb0_arburst,
	input 	[ 3:0]			sramb0_arid, 
	input 	[ 3:0]			sramb0_arlen, 
	output 				sramb0_rvalid, 
	input 				sramb0_rready,
	output 				sramb0_rlast, 
	output 	[SRAM_DWIDTH-1:0]	sramb0_rdata, 
	output 	[ 1:0]			sramb0_rresp, 
	output 	[ 3:0]			sramb0_rid,
	input 				sramb1_awvalid,
	output 				sramb1_awready, 
	input 	[ADDR_WIDTH-1:0] 	sramb1_awaddr, 
	input 	[ 2:0] 			sramb1_awsize, 
	input 	[ 1:0]			sramb1_awburst,
 	input 	[ 3:0]			sramb1_awid, 	
	input 	[ 3:0]			sramb1_awlen, 
	input 				sramb1_wvalid, 
	output 				sramb1_wready,
	input 				sramb1_wlast, 	
	input 	[SRAM_DWIDTH-1:0]	sramb1_wdata, 
	input 	[SRAM_SWIDTH-1:0]	sramb1_wstrb, 
	input 	[ 3:0]			sramb1_wid, 	
	output 				sramb1_bvalid, 
	input 				sramb1_bready, 
	output 	[ 1:0]			sramb1_bresp, 
	output 	[ 3:0]			sramb1_bid, 	
	input 				sramb1_arvalid, 
	output 				sramb1_arready, 
	input 	[ADDR_WIDTH-1:0]	sramb1_araddr, 
	input 	[ 2:0]			sramb1_arsize, 
	input 	[ 1:0]			sramb1_arburst,
	input 	[ 3:0]			sramb1_arid, 
	input 	[ 3:0]			sramb1_arlen, 
	output 				sramb1_rvalid, 
	input 				sramb1_rready,
	output 				sramb1_rlast, 
	output 	[SRAM_DWIDTH-1:0]	sramb1_rdata, 
	output 	[ 1:0]			sramb1_rresp, 
	output 	[ 3:0]			sramb1_rid,
	input 				sramb2_awvalid,
	output 				sramb2_awready, 
	input 	[ADDR_WIDTH-1:0] 	sramb2_awaddr, 
	input 	[ 2:0] 			sramb2_awsize, 
	input 	[ 1:0]			sramb2_awburst,
 	input 	[ 3:0]			sramb2_awid, 	
	input 	[ 3:0]			sramb2_awlen, 
	input 				sramb2_wvalid, 
	output 				sramb2_wready,
	input 				sramb2_wlast, 	
	input 	[SRAM_DWIDTH-1:0]	sramb2_wdata, 
	input 	[SRAM_SWIDTH-1:0]	sramb2_wstrb, 
	input 	[ 3:0]			sramb2_wid, 	
	output 				sramb2_bvalid, 
	input 				sramb2_bready, 
	output 	[1:0]			sramb2_bresp, 
	output 	[3:0]			sramb2_bid, 	
	input 				sramb2_arvalid, 
	output 				sramb2_arready, 
	input 	[ADDR_WIDTH-1:0]	sramb2_araddr, 
	input 	[ 2:0]			sramb2_arsize, 
	input 	[ 1:0]			sramb2_arburst,
	input 	[ 3:0]			sramb2_arid, 
	input 	[ 3:0]			sramb2_arlen, 
	output 				sramb2_rvalid, 
	input 				sramb2_rready,
	output 				sramb2_rlast, 
	output 	[SRAM_DWIDTH-1:0]	sramb2_rdata, 
	output 	[ 1:0]			sramb2_rresp, 
	output 	[3:0]			sramb2_rid,
	input 				sramb3_awvalid,
	output 				sramb3_awready, 
	input 	[ADDR_WIDTH-1:0] 	sramb3_awaddr, 
	input 	[ 2:0] 			sramb3_awsize, 
	input 	[ 1:0]			sramb3_awburst,
 	input 	[ 3:0]			sramb3_awid, 	
	input 	[ 3:0]			sramb3_awlen, 
	input 				sramb3_wvalid, 
	output 				sramb3_wready,
	input 				sramb3_wlast, 	
	input 	[SRAM_DWIDTH-1:0]	sramb3_wdata, 
	input 	[SRAM_SWIDTH-1:0]	sramb3_wstrb, 
	input 	[ 3:0]			sramb3_wid, 	
	output 				sramb3_bvalid, 
	input 				sramb3_bready, 
	output 	[ 1:0]			sramb3_bresp, 
	output 	[ 3:0]			sramb3_bid, 	
	input 				sramb3_arvalid, 
	output 				sramb3_arready, 
	input 	[ADDR_WIDTH-1:0]	sramb3_araddr, 
	input 	[ 2:0]			sramb3_arsize, 
	input 	[ 1:0]			sramb3_arburst,
	input 	[ 3:0]			sramb3_arid, 
	input 	[ 3:0]			sramb3_arlen, 
	output 				sramb3_rvalid, 
	input 				sramb3_rready,
	output 				sramb3_rlast, 
	output 	[SRAM_DWIDTH-1:0]	sramb3_rdata, 
	output 	[ 1:0]			sramb3_rresp, 
	output 	[ 3:0]			sramb3_rid,
	output				cntl_arready, 
	output				cntl_awready, 
	output	[ 1:0]			cntl_bresp, 
	output				cntl_bvalid, 
	output	[31:0]			cntl_rdata, 
	output	[ 1:0]			cntl_rresp, 
	output				cntl_rvalid, 
	output				cntl_wready, 
	input	[31:0]			cntl_araddr, 
	input				cntl_arvalid, 
	input	[31:0]			cntl_awaddr, 
	input				cntl_awvalid, 
	input				cntl_bready, 
	input				cntl_rready, 
	input	[31:0]			cntl_wdata, 
	input				cntl_wvalid, 	
	output  [ 1:0]			int_gc_fsm,
	input	[ 3:0]   		DTI_EXT_VREF,
	output  [29:0]			PAD_MEM_CTL,
	output 	[ 1:0]			PAD_MEM_CLK,
	output  [ 1:0]			PAD_MEM_CLK_N,
	inout  	[ 3:0]			PAD_MEM_DM,
	inout  	[31:0]			PAD_MEM_DQ,
	inout  	[ 3:0]			PAD_MEM_DQS,
	inout	[ 3:0]			PAD_MEM_DQS_N,
	input	[29:0]			CLOCKDR_CTL,
	input 	[ 1:0]			CLOCKDR_CLK,
	input	[ 3:0]			CLOCKDR_DM,
	input   [31:0]			CLOCKDR_DQ,
	input 	[ 3:0]			CLOCKDR_DQS,
	input	[29:0]			JTAG_SI_CTL,
	input 	[ 1:0]			JTAG_SI_CLK,
	input	[ 3:0]			JTAG_SI_DM,
	input   [31:0]			JTAG_SI_DQ,
	input 	[ 3:0]			JTAG_SI_DQS,
	output	[29:0]			JTAG_SO_CTL,
	output 	[ 1:0]			JTAG_SO_CLK,
	output	[ 3:0]			JTAG_SO_DM,
	output  [31:0]			JTAG_SO_DQ,
	output 	[ 3:0]			JTAG_SO_DQS,
	input	[29:0]			MODE_CTL,
	input 	[ 1:0]			MODE_CLK,
	input	[ 3:0]			MODE_DM,
	input   [31:0]			MODE_DQ,
	input 	[ 3:0]			MODE_DQS,
	input	[ 3:0]			MODE_I_DM,
	input   [31:0]			MODE_I_DQ,
	input 	[ 3:0]			MODE_I_DQS,
	input				PAD_REF,
	input				SE,
	input				SE_CK,
	input	[29:0]			SHIFTDR_CTL,
	input 	[ 1:0]			SHIFTDR_CLK,
	input	[ 3:0]			SHIFTDR_DM,
	input   [31:0]			SHIFTDR_DQ,
	input 	[ 3:0]			SHIFTDR_DQS,
	input	[ 1:0]			SI_CLK,
	input	[29:0]			SI_CTL,
	input	[ 3:0]			SI_DM,
	input   [31:0]			SI_DQ,
	input	[ 3:0]			SI_RD,
	input	[ 3:0]			SI_WR,
	output	[ 1:0]			SO_CLK,
	output	[29:0]			SO_CTL,
	output	[ 3:0]			SO_DM,
	output   [31:0]			SO_DQ,
	output	[ 3:0]			SO_RD,
	output	[ 3:0]			SO_WR,
	input				T_CGCTL_CTL,
	input	[ 3:0]			T_CGCTL_DQ,
	input				T_RCTL_CTL,
	input	[ 3:0]			T_RCTL_DQ,
	input				VDD,
	input				VDDO,
	input				VSS,
	input	[29:0]			UPDATEDR_CTL,
	input 	[ 1:0]			UPDATEDR_CLK,
	input	[ 3:0]			UPDATEDR_DM,
	input   [31:0]			UPDATEDR_DQ,
	input 	[ 3:0]			UPDATEDR_DQS,
	inout				PAD_COMP,
	output 	[ 1:0]			YC_CLK,
	output 	[29:0]			YC_CTL,
	output  [ 3:0]			Y_DM, 
	output  [31:0]			Y_DQ, 
	output  [ 3:0]			Y_DQS, 
	inout				PAD_VREF
);


assign ddr0_awready   = 'h0;
assign ddr0_wready    = 'h0;
assign ddr0_bvalid    = 'h0;
assign ddr0_bresp     = 'h0;
assign ddr0_bid       = 'h0;
assign ddr0_arready   = 'h0;
assign ddr0_rvalid    = 'h0;
assign ddr0_rlast     = 'h0;
assign ddr0_rdata     = 'h0;
assign ddr0_rresp     = 'h0;
assign ddr0_rid       = 'h0;
assign ddr1_awready   = 'h0;
assign ddr1_wready    = 'h0;
assign ddr1_bvalid    = 'h0;
assign ddr1_bresp     = 'h0;
assign ddr1_bid       = 'h0;
assign ddr1_arready   = 'h0;
assign ddr1_rvalid    = 'h0;
assign ddr1_rlast     = 'h0;
assign ddr1_rdata     = 'h0;
assign ddr1_rresp     = 'h0;
assign ddr1_rid       = 'h0;
assign ddr2_awready   = 'h0;
assign ddr2_wready    = 'h0;
assign ddr2_bvalid    = 'h0;
assign ddr2_bresp     = 'h0;
assign ddr2_bid       = 'h0;
assign ddr2_arready   = 'h0;
assign ddr2_rvalid    = 'h0;
assign ddr2_rlast     = 'h0;
assign ddr2_rdata     = 'h0;
assign ddr2_rresp     = 'h0;
assign ddr2_rid       = 'h0;
assign ddr3_awready   = 'h0;
assign ddr3_wready    = 'h0;
assign ddr3_bvalid    = 'h0;
assign ddr3_bresp     = 'h0;
assign ddr3_bid       = 'h0;
assign ddr3_arready   = 'h0;
assign ddr3_rvalid    = 'h0;
assign ddr3_rlast     = 'h0;
assign ddr3_rdata     = 'h0;
assign ddr3_rresp     = 'h0;
assign ddr3_rid       = 'h0;
assign sramb0_awready = 'h0;
assign sramb0_wready  = 'h0;
assign sramb0_bvalid  = 'h0;
assign sramb0_bresp   = 'h0;
assign sramb0_bid     = 'h0;
assign sramb0_arready = 'h0;
assign sramb0_rvalid  = 'h0;
assign sramb0_rlast   = 'h0;
assign sramb0_rdata   = 'h0;
assign sramb0_rresp   = 'h0;
assign sramb0_rid     = 'h0;
assign sramb1_awready = 'h0;
assign sramb1_wready  = 'h0;
assign sramb1_bvalid  = 'h0;
assign sramb1_bresp   = 'h0;
assign sramb1_bid     = 'h0;
assign sramb1_arready = 'h0;
assign sramb1_rvalid  = 'h0;
assign sramb1_rlast   = 'h0;
assign sramb1_rdata   = 'h0;
assign sramb1_rresp   = 'h0;
assign sramb1_rid     = 'h0;
assign sramb2_awready = 'h0;
assign sramb2_wready  = 'h0;
assign sramb2_bvalid  = 'h0;
assign sramb2_bresp   = 'h0;
assign sramb2_bid     = 'h0;
assign sramb2_arready = 'h0;
assign sramb2_rvalid  = 'h0;
assign sramb2_rlast   = 'h0;
assign sramb2_rdata   = 'h0;
assign sramb2_rresp   = 'h0;
assign sramb2_rid     = 'h0;
assign sramb3_awready = 'h0;
assign sramb3_wready  = 'h0;
assign sramb3_bvalid  = 'h0;
assign sramb3_bresp   = 'h0;
assign sramb3_bid     = 'h0;
assign sramb3_arready = 'h0;
assign sramb3_rvalid  = 'h0;
assign sramb3_rlast   = 'h0;
assign sramb3_rdata   = 'h0;
assign sramb3_rresp   = 'h0;
assign sramb3_rid     = 'h0;
assign cntl_arready   = 'h0;
assign cntl_awready   = 'h0;
assign cntl_bresp     = 'h0;
assign cntl_bvalid    = 'h0;
assign cntl_rdata     = 'h0;
assign cntl_rresp     = 'h0;
assign cntl_rvalid    = 'h0;
assign cntl_wready    = 'h0;
assign int_gc_fsm     = 'h0;
assign PAD_MEM_CTL    = 'h0;
assign PAD_MEM_CLK    = 'h0;
assign PAD_MEM_CLK_N  = 'h0;
assign PAD_MEM_DM     = 'h0;
assign PAD_MEM_DQ     = 'h0;
assign PAD_MEM_DQS    = 'h0;
assign PAD_MEM_DQS_N  = 'h0;
assign JTAG_SO_CTL    = 'h0;
assign JTAG_SO_CLK    = 'h0;
assign JTAG_SO_DM     = 'h0;
assign JTAG_SO_DQ     = 'h0;
assign JTAG_SO_DQS    = 'h0;
assign SO_CLK         = 'h0;
assign SO_CTL         = 'h0;
assign SO_DM          = 'h0;
assign SO_DQ          = 'h0;
assign SO_RD          = 'h0;
assign SO_WR          = 'h0;
assign PAD_COMP       = 'h0;
assign YC_CLK         = 'h0;
assign YC_CTL         = 'h0;
assign Y_DM           = 'h0;
assign Y_DQ           = 'h0;
assign Y_DQS          = 'h0;
assign PAD_VREF       = 'h0;

endmodule : memss
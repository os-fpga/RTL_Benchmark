//-----------------------------------------------------------------------------
//	RapidSilicon
//	Author:	Michael Wood
//	Date:	3/9/2022
//-----------------------------------------------------------------------------
module sram_ss #(
	parameter ADDR_WIDTH = 32,
	parameter DATA_WIDTH = 32,
	parameter STRB_WIDTH = (DATA_WIDTH/8),
	parameter ID_WIDTH   = 4)
	(
	input 			sramb0_aclk,		// 533 MHz
	input 			sramb0_aresetn,
	input 			sramb1_aclk,		// 533 MHz
	input 			sramb1_aresetn,
	input 			sramb2_aclk,		// 533 MHz
	input 			sramb2_aresetn,
	input 			sramb3_aclk,		// 533 MHz
	input 			sramb3_aresetn,
	input 			sram_sys_clk,		// 533 MHz
	input			sram_sys_resetn,
	input 			sramb0_awvalid,
	output 			sramb0_awready, 
	input [ADDR_WIDTH-1:0] 	sramb0_awaddr, 
	input [2:0] 		sramb0_awsize, 
	input [1:0]		sramb0_awburst,
 	input [ID_WIDTH-1:0]	sramb0_awid, 	
	input [ 3:0]		sramb0_awlen, 
	input 			sramb0_wvalid, 
	output 			sramb0_wready,
	input 			sramb0_wlast, 	
	input [DATA_WIDTH-1:0]	sramb0_wdata, 
	input [STRB_WIDTH-1:0]	sramb0_wstrb, 
	input [3:0]		sramb0_wid, 	
	output 			sramb0_bvalid, 
	input 			sramb0_bready, 
	output [1:0]		sramb0_bresp, 
	output [3:0]		sramb0_bid, 	
	input 			sramb0_arvalid, 
	output 			sramb0_arready, 
	input [ADDR_WIDTH-1:0]	sramb0_araddr, 
	input [2:0]		sramb0_arsize, 
	input [1:0]		sramb0_arburst,
	input [ID_WIDTH-1:0]	sramb0_arid, 
	input [ 3:0]		sramb0_arlen, 
	output 			sramb0_rvalid, 
	input 			sramb0_rready,
	output 			sramb0_rlast, 
	output [DATA_WIDTH-1:0]	sramb0_rdata, 
	output [1:0]		sramb0_rresp, 
	output [ID_WIDTH-1:0]	sramb0_rid,
	input 			sramb1_awvalid,
	output 			sramb1_awready, 
	input [ADDR_WIDTH-1:0] 	sramb1_awaddr, 
	input [2:0] 		sramb1_awsize, 
	input [1:0]		sramb1_awburst,
 	input [ID_WIDTH-1:0]	sramb1_awid, 	
	input [ 3:0]		sramb1_awlen, 
	input 			sramb1_wvalid, 
	output 			sramb1_wready,
	input 			sramb1_wlast, 	
	input [DATA_WIDTH-1:0]	sramb1_wdata, 
	input [STRB_WIDTH-1:0]	sramb1_wstrb, 
	input [3:0]		sramb1_wid, 	
	output 			sramb1_bvalid, 
	input 			sramb1_bready, 
	output [1:0]		sramb1_bresp, 
	output [3:0]		sramb1_bid, 	
	input 			sramb1_arvalid, 
	output 			sramb1_arready, 
	input [ADDR_WIDTH-1:0]	sramb1_araddr, 
	input [2:0]		sramb1_arsize, 
	input [1:0]		sramb1_arburst,
	input [ID_WIDTH-1:0]	sramb1_arid, 
	input [3:0]		sramb1_arlen, 
	output 			sramb1_rvalid, 
	input 			sramb1_rready,
	output 			sramb1_rlast, 
	output [DATA_WIDTH-1:0]	sramb1_rdata, 
	output [1:0]		sramb1_rresp, 
	output [ID_WIDTH-1:0]	sramb1_rid,
	input 			sramb2_awvalid,
	output 			sramb2_awready, 
	input [ADDR_WIDTH-1:0] 	sramb2_awaddr, 
	input [2:0] 		sramb2_awsize, 
	input [1:0]		sramb2_awburst,
 	input [ID_WIDTH-1:0]	sramb2_awid, 	
	input [3:0]		sramb2_awlen, 
	input 			sramb2_wvalid, 
	output 			sramb2_wready,
	input 			sramb2_wlast, 	
	input [DATA_WIDTH-1:0]	sramb2_wdata, 
	input [STRB_WIDTH-1:0]	sramb2_wstrb, 
	input [3:0]		sramb2_wid, 	
	output 			sramb2_bvalid, 
	input 			sramb2_bready, 
	output [1:0]		sramb2_bresp, 
	output [3:0]		sramb2_bid, 	
	input 			sramb2_arvalid, 
	output 			sramb2_arready, 
	input [ADDR_WIDTH-1:0]	sramb2_araddr, 
	input [2:0]		sramb2_arsize, 
	input [1:0]		sramb2_arburst,
	input [ID_WIDTH-1:0]	sramb2_arid, 
	input [3:0]		sramb2_arlen, 
	output 			sramb2_rvalid, 
	input 			sramb2_rready,
	output 			sramb2_rlast, 
	output [DATA_WIDTH-1:0]	sramb2_rdata, 
	output [1:0]		sramb2_rresp, 
	output [ID_WIDTH-1:0]	sramb2_rid,
	input 			sramb3_awvalid,
	output 			sramb3_awready, 
	input [ADDR_WIDTH-1:0] 	sramb3_awaddr, 
	input [2:0] 		sramb3_awsize, 
	input [1:0]		sramb3_awburst,
 	input [ID_WIDTH-1:0]	sramb3_awid, 	
	input [3:0]		sramb3_awlen, 
	input 			sramb3_wvalid, 
	output 			sramb3_wready,
	input 			sramb3_wlast, 	
	input [DATA_WIDTH-1:0]	sramb3_wdata, 
	input [STRB_WIDTH-1:0]	sramb3_wstrb, 
	input [3:0]		sramb3_wid, 	
	output 			sramb3_bvalid, 
	input 			sramb3_bready, 
	output [1:0]		sramb3_bresp, 
	output [3:0]		sramb3_bid, 	
	input 			sramb3_arvalid, 
	output 			sramb3_arready, 
	input [ADDR_WIDTH-1:0]	sramb3_araddr, 
	input [2:0]		sramb3_arsize, 
	input [1:0]		sramb3_arburst,
	input [ID_WIDTH-1:0]	sramb3_arid, 
	input [3:0]		sramb3_arlen, 
	output 			sramb3_rvalid, 
	input 			sramb3_rready,
	output 			sramb3_rlast, 
	output [DATA_WIDTH-1:0]	sramb3_rdata, 
	output [1:0]		sramb3_rresp, 
	output [ID_WIDTH-1:0]	sramb3_rid);

	// Bank 0 Interface	
	wire [13:0] 		mem0_addr;
        wire 	    		mem0_ce;
	wire 	    		mem0_we;
        wire [DATA_WIDTH-1:0] 	mem0_wdata;
        wire [DATA_WIDTH-1:0] 	mem0_rdata;
        wire [STRB_WIDTH-1:0] 	mem0_bywe;

	// Bank 1 Interface	
	wire [13:0] 		mem1_addr;
        wire 	    		mem1_ce;
	wire 	    		mem1_we;
        wire [DATA_WIDTH-1:0] 	mem1_wdata;
        wire [DATA_WIDTH-1:0] 	mem1_rdata;
        wire [STRB_WIDTH-1:0] 	mem1_bywe;

	// Bank 2 Interface	
	wire [13:0] 		mem2_addr;
        wire 	    		mem2_ce;
	wire 	    		mem2_we;
        wire [DATA_WIDTH-1:0] 	mem2_wdata;
        wire [DATA_WIDTH-1:0] 	mem2_rdata;
        wire [STRB_WIDTH-1:0] 	mem2_bywe;

	// Bank 3 Interface	
	wire [13:0] 		mem3_addr;
        wire 	    		mem3_ce;
	wire 	    		mem3_we;
        wire [DATA_WIDTH-1:0] 	mem3_wdata;
        wire [DATA_WIDTH-1:0] 	mem3_rdata;
        wire [STRB_WIDTH-1:0] 	mem3_bywe;




	/*********** SRAM Memory Bank 0 ***********/	
  	dti_sp_tm16fcll_16384x32_32byw2x_m_shd sram_bank0(
		.VDD	(1'b1		),
		.VSS	(1'b0		),
		.DO	(mem0_rdata	), 
		.A	(mem0_addr	), 
		.DI	(mem0_wdata	), 
		.CE_N	(~mem0_ce	), 
		.GWE_N	(~mem0_we	), 
		.BYWE_N	(~mem0_bywe	), 
		.T_RWM	(3'b011		),
		.T_DLY	(3'h0		),
		.CLK	(sram_sys_clk	)
	);

	/*********** SRAM Memory Bank 1 ***********/	
  	dti_sp_tm16fcll_16384x32_32byw2x_m_shd sram_bank1(
		.VDD	(1'b1		),
		.VSS	(1'b0		),
		.DO	(mem1_rdata	), 
		.A	(mem1_addr	), 
		.DI	(mem1_wdata	), 
		.CE_N	(~mem1_ce	), 
		.GWE_N	(~mem1_we	), 
		.BYWE_N	(~mem1_bywe	), 
		.T_RWM	(3'b011		),
		.T_DLY	(3'h0		),
		.CLK	(sram_sys_clk	)
	);

	/*********** SRAM Memory Bank 2 ***********/	
  	dti_sp_tm16fcll_16384x32_32byw2x_m_shd sram_bank2(
		.VDD	(1'b1		),
		.VSS	(1'b0		),
	 	.DO	(mem2_rdata	), 
		.A	(mem2_addr	), 
		.DI	(mem2_wdata	), 
		.CE_N	(~mem2_ce	), 
		.GWE_N	(~mem2_we	), 
		.BYWE_N	(~mem2_bywe	), 
		.T_RWM	(3'b011		),
		.T_DLY	(3'h0		),
		.CLK	(sram_sys_clk	)
	);

	/*********** SRAM Memory Bank 3 ***********/	
  	dti_sp_tm16fcll_16384x32_32byw2x_m_shd sram_bank3(
		.VDD	(1'b1		),
		.VSS	(1'b0		),
		.DO	(mem3_rdata	), 
		.A	(mem3_addr	), 
		.DI	(mem3_wdata	), 
		.CE_N	(~mem3_ce	), 
		.GWE_N	(~mem3_we	), 
		.BYWE_N	(~mem3_bywe	), 
		.T_RWM	(3'b011		),
		.T_DLY	(3'h0		),
		.CLK	(sram_sys_clk	)
	);

	/*********** SRAM Memory Bank0 Controller  ***********/	
	bank_cntl bank0_cntl(
		.aclk		(sramb0_aclk	), 
		.aresetn	(sramb0_aresetn	),
		.sram_clk	(sram_sys_clk	),
		.sram_resetn	(sram_sys_resetn),
		.awvalid	(sramb0_awvalid	),
		.awready	(sramb0_awready	), 
		.awaddr		(sramb0_awaddr	), 
		.awsize		(sramb0_awsize	), 
		.awburst	(sramb0_awburst	),
		.awid		(sramb0_awid	), 	
		.awlen		(sramb0_awlen	), 
		.wvalid		(sramb0_wvalid	), 
		.wready		(sramb0_wready	),
		.wlast		(sramb0_wlast	), 	
		.wdata		(sramb0_wdata	), 
		.wstrb		(sramb0_wstrb	), 
		.wid		(sramb0_wid	), 	 
		.bvalid		(sramb0_bvalid	), 
		.bready		(sramb0_bready	), 
		.bresp		(sramb0_bresp	), 
		.bid		(sramb0_bid	), 	
		.arvalid	(sramb0_arvalid	), 
		.arready	(sramb0_arready	), 
		.araddr		(sramb0_araddr	), 
		.arsize		(sramb0_arsize	), 
		.arburst	(sramb0_arburst	),
		.arid		(sramb0_arid	), 
		.arlen		(sramb0_arlen	), 
		.rvalid		(sramb0_rvalid	), 
		.rready		(sramb0_rready	),
		.rlast		(sramb0_rlast	), 
		.rdata		(sramb0_rdata	), 
		.rresp		(sramb0_rresp	), 
		.rid		(sramb0_rid	),
		.mem_addr	(mem0_addr	),
		.mem_ce		(mem0_ce	),
		.mem_we		(mem0_we	),
		.mem_wdata	(mem0_wdata	),
		.mem_rdata	(mem0_rdata	),
		.mem_bywe	(mem0_bywe	)
	);

	/*********** SRAM Memory Bank1 Controller  ***********/	
	bank_cntl bank1_cntl(
		.aclk		(sramb1_aclk	), 
		.aresetn	(sramb1_aresetn	),
		.sram_clk	(sram_sys_clk	),
		.sram_resetn	(sram_sys_resetn),
		.awvalid	(sramb1_awvalid	),
		.awready	(sramb1_awready	), 
		.awaddr		(sramb1_awaddr	), 
		.awsize		(sramb1_awsize	), 
		.awburst	(sramb1_awburst	),
		.awid		(sramb1_awid	), 	
		.awlen		(sramb1_awlen	), 
		.wvalid		(sramb1_wvalid	), 
		.wready		(sramb1_wready	),
		.wlast		(sramb1_wlast	), 	
		.wdata		(sramb1_wdata	), 
		.wstrb		(sramb1_wstrb	), 
		.wid		(sramb1_wid	), 	 
		.bvalid		(sramb1_bvalid	), 
		.bready		(sramb1_bready	), 
		.bresp		(sramb1_bresp	), 
		.bid		(sramb1_bid	), 	
		.arvalid	(sramb1_arvalid	), 
		.arready	(sramb1_arready	), 
		.araddr		(sramb1_araddr	), 
		.arsize		(sramb1_arsize	), 
		.arburst	(sramb1_arburst	),
		.arid		(sramb1_arid	), 
		.arlen		(sramb1_arlen	), 
		.rvalid		(sramb1_rvalid	), 
		.rready		(sramb1_rready	),
		.rlast		(sramb1_rlast	), 
		.rdata		(sramb1_rdata	), 
		.rresp		(sramb1_rresp	), 
		.rid		(sramb1_rid	),
		.mem_addr	(mem1_addr	),
		.mem_ce		(mem1_ce	),
		.mem_we		(mem1_we	),
		.mem_wdata	(mem1_wdata	),
		.mem_rdata	(mem1_rdata	),
		.mem_bywe	(mem1_bywe	)
	);

	/*********** SRAM Memory Bank2 Controller  ***********/	
	bank_cntl bank2_cntl(
		.aclk		(sramb2_aclk	), 
		.aresetn	(sramb2_aresetn	),
		.sram_clk	(sram_sys_clk	),
		.sram_resetn	(sram_sys_resetn),
		.awvalid	(sramb2_awvalid	),
		.awready	(sramb2_awready	), 
		.awaddr		(sramb2_awaddr	), 
		.awsize		(sramb2_awsize	), 
		.awburst	(sramb2_awburst	),
 		.awid		(sramb2_awid	), 	
		.awlen		(sramb2_awlen	), 
		.wvalid		(sramb2_wvalid	), 
		.wready		(sramb2_wready	),
		.wlast		(sramb2_wlast	), 	
		.wdata		(sramb2_wdata	), 
		.wstrb		(sramb2_wstrb	), 
		.wid		(sramb2_wid	), 	 
		.bvalid		(sramb2_bvalid	), 
		.bready		(sramb2_bready	), 
		.bresp		(sramb2_bresp	), 
		.bid		(sramb2_bid	), 	
		.arvalid	(sramb2_arvalid	), 
		.arready	(sramb2_arready	), 
		.araddr		(sramb2_araddr	), 
		.arsize		(sramb2_arsize	), 
		.arburst	(sramb2_arburst	),
		.arid		(sramb2_arid	), 
		.arlen		(sramb2_arlen	), 
		.rvalid		(sramb2_rvalid	), 
		.rready		(sramb2_rready	),
		.rlast		(sramb2_rlast	), 
		.rdata		(sramb2_rdata	), 
		.rresp		(sramb2_rresp	), 
		.rid		(sramb2_rid	),
		.mem_addr	(mem2_addr	),
		.mem_ce		(mem2_ce	),
		.mem_we		(mem2_we	),
		.mem_wdata	(mem2_wdata	),
		.mem_rdata	(mem2_rdata	),
		.mem_bywe	(mem2_bywe	)
	);

	/*********** SRAM Memory Bank3 Controller  ***********/	
	bank_cntl bank3_cntl(
		.aclk		(sramb3_aclk	), 
		.aresetn	(sramb3_aresetn	),
		.sram_clk	(sram_sys_clk	),
		.sram_resetn	(sram_sys_resetn),
		.awvalid	(sramb3_awvalid	),
		.awready	(sramb3_awready	), 
		.awaddr		(sramb3_awaddr	), 
		.awsize		(sramb3_awsize	), 
		.awburst	(sramb3_awburst	),
 		.awid		(sramb3_awid	), 	
		.awlen		(sramb3_awlen	), 
		.wvalid		(sramb3_wvalid	), 
		.wready		(sramb3_wready	),
		.wlast		(sramb3_wlast	), 	
		.wdata		(sramb3_wdata	), 
		.wstrb		(sramb3_wstrb	), 
		.wid		(sramb3_wid	), 	 
		.bvalid		(sramb3_bvalid	), 
		.bready		(sramb3_bready	), 
		.bresp		(sramb3_bresp	), 
		.bid		(sramb3_bid	), 	
		.arvalid	(sramb3_arvalid	), 
		.arready	(sramb3_arready	), 
		.araddr		(sramb3_araddr	), 
		.arsize		(sramb3_arsize	), 
		.arburst	(sramb3_arburst	),
		.arid		(sramb3_arid	), 
		.arlen		(sramb3_arlen	), 
		.rvalid		(sramb3_rvalid	), 
		.rready		(sramb3_rready	),
		.rlast		(sramb3_rlast	), 
		.rdata		(sramb3_rdata	), 
		.rresp		(sramb3_rresp	), 
		.rid		(sramb3_rid	),
		.mem_addr	(mem3_addr	),
		.mem_ce		(mem3_ce	),
		.mem_we		(mem3_we	),
		.mem_wdata	(mem3_wdata	),
		.mem_rdata	(mem3_rdata	),
		.mem_bywe	(mem3_bywe	)
	);
endmodule

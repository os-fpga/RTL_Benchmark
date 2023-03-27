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
	input  wire 			sramb0_aclk,		// 533 MHz
	input  wire 			sramb0_aresetn,
	input  wire 			sramb1_aclk,		// 533 MHz
	input  wire 			sramb1_aresetn,
	input  wire 			sramb2_aclk,		// 533 MHz
	input  wire 			sramb2_aresetn,
	input  wire 			sramb3_aclk,		// 533 MHz
	input  wire 			sramb3_aresetn,
	input  wire 			sram_sys_clk,		// 533 MHz
	input  wire			sram_sys_resetn,
	input  wire 			sramb0_awvalid,
	output wire 			sramb0_awready, 
	input  wire [ADDR_WIDTH-1:0] 	sramb0_awaddr, 
	input  wire [2:0] 		sramb0_awsize, 
	input  wire [1:0]		sramb0_awburst,
 	input  wire [ID_WIDTH-1:0]	sramb0_awid, 	
	input  wire [ 3:0]		sramb0_awlen, 
	input  wire 			sramb0_wvalid, 
	output wire 			sramb0_wready,
	input  wire 			sramb0_wlast, 	
	input  wire [DATA_WIDTH-1:0]	sramb0_wdata, 
	input  wire [STRB_WIDTH-1:0]	sramb0_wstrb, 
	input  wire [3:0]		sramb0_wid, 	
	output wire 			sramb0_bvalid, 
	input  wire 			sramb0_bready, 
	output wire [1:0]		sramb0_bresp, 
	output wire [3:0]		sramb0_bid, 	
	input  wire 			sramb0_arvalid, 
	output wire 			sramb0_arready, 
	input  wire [ADDR_WIDTH-1:0]	sramb0_araddr, 
	input  wire [2:0]		sramb0_arsize, 
	input  wire [1:0]		sramb0_arburst,
	input  wire [ID_WIDTH-1:0]	sramb0_arid, 
	input  wire [ 3:0]		sramb0_arlen, 
	output wire 			sramb0_rvalid, 
	input  wire 			sramb0_rready,
	output wire 			sramb0_rlast, 
	output wire [DATA_WIDTH-1:0]	sramb0_rdata, 
	output wire [1:0]		sramb0_rresp, 
	output wire [ID_WIDTH-1:0]	sramb0_rid,
	input  wire 			sramb1_awvalid,
	output wire 			sramb1_awready, 
	input  wire [ADDR_WIDTH-1:0] 	sramb1_awaddr, 
	input  wire [2:0] 		sramb1_awsize, 
	input  wire [1:0]		sramb1_awburst,
 	input  wire [ID_WIDTH-1:0]	sramb1_awid, 	
	input  wire [ 3:0]		sramb1_awlen, 
	input  wire 			sramb1_wvalid, 
	output wire 			sramb1_wready,
	input  wire 			sramb1_wlast, 	
	input  wire [DATA_WIDTH-1:0]	sramb1_wdata, 
	input  wire [STRB_WIDTH-1:0]	sramb1_wstrb, 
	input  wire [3:0]		sramb1_wid, 	
	output wire 			sramb1_bvalid, 
	input  wire 			sramb1_bready, 
	output wire [1:0]		sramb1_bresp, 
	output wire [3:0]		sramb1_bid, 	
	input  wire 			sramb1_arvalid, 
	output wire 			sramb1_arready, 
	input  wire [ADDR_WIDTH-1:0]	sramb1_araddr, 
	input  wire [2:0]		sramb1_arsize, 
	input  wire [1:0]		sramb1_arburst,
	input  wire [ID_WIDTH-1:0]	sramb1_arid, 
	input  wire [3:0]		sramb1_arlen, 
	output wire 			sramb1_rvalid, 
	input  wire 			sramb1_rready,
	output wire 			sramb1_rlast, 
	output wire [DATA_WIDTH-1:0]	sramb1_rdata, 
	output wire [1:0]		sramb1_rresp, 
	output wire [ID_WIDTH-1:0]	sramb1_rid,
	input  wire 			sramb2_awvalid,
	output wire 			sramb2_awready, 
	input  wire [ADDR_WIDTH-1:0] 	sramb2_awaddr, 
	input  wire [2:0] 		sramb2_awsize, 
	input  wire [1:0]		sramb2_awburst,
 	input  wire [ID_WIDTH-1:0]	sramb2_awid, 	
	input  wire [3:0]		sramb2_awlen, 
	input  wire 			sramb2_wvalid, 
	output wire 			sramb2_wready,
	input  wire 			sramb2_wlast, 	
	input  wire [DATA_WIDTH-1:0]	sramb2_wdata, 
	input  wire [STRB_WIDTH-1:0]	sramb2_wstrb, 
	input  wire [3:0]		sramb2_wid, 	
	output wire 			sramb2_bvalid, 
	input  wire 			sramb2_bready, 
	output wire [1:0]		sramb2_bresp, 
	output wire [3:0]		sramb2_bid, 	
	input  wire 			sramb2_arvalid, 
	output wire 			sramb2_arready, 
	input  wire [ADDR_WIDTH-1:0]	sramb2_araddr, 
	input  wire [2:0]		sramb2_arsize, 
	input  wire [1:0]		sramb2_arburst,
	input  wire [ID_WIDTH-1:0]	sramb2_arid, 
	input  wire [3:0]		sramb2_arlen, 
	output wire 			sramb2_rvalid, 
	input  wire 			sramb2_rready,
	output wire 			sramb2_rlast, 
	output wire [DATA_WIDTH-1:0]	sramb2_rdata, 
	output wire [1:0]		sramb2_rresp, 
	output wire [ID_WIDTH-1:0]	sramb2_rid,
	input  wire 			sramb3_awvalid,
	output wire 			sramb3_awready, 
	input  wire [ADDR_WIDTH-1:0] 	sramb3_awaddr, 
	input  wire [2:0] 		sramb3_awsize, 
	input  wire [1:0]		sramb3_awburst,
 	input  wire [ID_WIDTH-1:0]	sramb3_awid, 	
	input  wire [3:0]		sramb3_awlen, 
	input  wire 			sramb3_wvalid, 
	output wire 			sramb3_wready,
	input  wire 			sramb3_wlast, 	
	input  wire [DATA_WIDTH-1:0]	sramb3_wdata, 
	input  wire [STRB_WIDTH-1:0]	sramb3_wstrb, 
	input  wire [3:0]		sramb3_wid, 	
	output wire 			sramb3_bvalid, 
	input  wire 			sramb3_bready, 
	output wire [1:0]		sramb3_bresp, 
	output wire [3:0]		sramb3_bid, 	
	input  wire 			sramb3_arvalid, 
	output wire 			sramb3_arready, 
	input  wire [ADDR_WIDTH-1:0]	sramb3_araddr, 
	input  wire [2:0]		sramb3_arsize, 
	input  wire [1:0]		sramb3_arburst,
	input  wire [ID_WIDTH-1:0]	sramb3_arid, 
	input  wire [3:0]		sramb3_arlen, 
	output wire 			sramb3_rvalid, 
	input  wire 			sramb3_rready,
	output wire 			sramb3_rlast, 
	output wire [DATA_WIDTH-1:0]	sramb3_rdata, 
	output wire [1:0]		sramb3_rresp, 
	output wire [ID_WIDTH-1:0]	sramb3_rid);


	// Stubbed RTL Outputs Tied to 0
	assign sramb0_awready 	= 'h0;
	assign sramb0_wready	= 'h0;
	assign sramb0_bvalid 	= 'h0;
	assign sramb0_bresp 	= 'h0;
	assign sramb0_bid 	= 'h0;
	assign sramb0_arready 	= 'h0;
	assign sramb0_rvalid 	= 'h0;
	assign sramb0_rlast 	= 'h0;
	assign sramb0_rdata 	= 'h0;
	assign sramb0_rresp 	= 'h0;
	assign sramb0_rid	= 'h0;
	assign sramb1_awready 	= 'h0;
	assign sramb1_wready	= 'h0;
	assign sramb1_bvalid 	= 'h0;
	assign sramb1_bresp 	= 'h0;
	assign sramb1_bid 	= 'h0;
	assign sramb1_arready 	= 'h0;
	assign sramb1_rvalid 	= 'h0;
	assign sramb1_rlast	= 'h0;
	assign sramb1_rdata 	= 'h0;
	assign sramb1_rresp 	= 'h0;
	assign sramb1_rid	= 'h0;
	assign sramb2_awready	= 'h0;
	assign sramb2_wready	= 'h0;
	assign sramb2_bvalid 	= 'h0;
	assign sramb2_bresp 	= 'h0;
	assign sramb2_bid 	= 'h0;
	assign sramb2_arready 	= 'h0;
	assign sramb2_rvalid 	= 'h0;
	assign sramb2_rlast 	= 'h0;
	assign sramb2_rdata 	= 'h0;
	assign sramb2_rresp 	= 'h0;
	assign sramb2_rid	= 'h0;
	assign sramb3_awready 	= 'h0;
	assign sramb3_wready	= 'h0;
	assign sramb3_bvalid 	= 'h0;
	assign sramb3_bresp 	= 'h0;
	assign sramb3_bid 	= 'h0;
	assign sramb3_arready 	= 'h0;
	assign sramb3_rvalid 	= 'h0;
	assign sramb3_rlast 	= 'h0;
	assign sramb3_rdata 	= 'h0;
	assign sramb3_rresp 	= 'h0;
	assign sramb3_rid	= 'h0;
endmodule

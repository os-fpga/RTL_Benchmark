//-----------------------------------------------------------------------------
//	RapidSilicon
//	Author:	Michael Wood
//	Date:	3/9/2022
//-----------------------------------------------------------------------------
module bank_cntl #(
	parameter ADDR_WIDTH = 32,
	parameter DATA_WIDTH = 32,
	parameter STRB_WIDTH = (DATA_WIDTH/8))

	(
	input 				aclk,
	input 				aresetn,
	input 				sram_clk,
	input				sram_resetn,
	input 				awvalid,
	output 				awready, 
	input [ADDR_WIDTH-1:0] 		awaddr, 
	input [2:0] 			awsize, 
	input [1:0]			awburst,
 	input [3:0]			awid, 	
	input [ 3:0]			awlen, 
	input 				wvalid, 
	output 				wready,
	input 				wlast, 	
	input [DATA_WIDTH-1:0]		wdata, 
	input [STRB_WIDTH-1:0]		wstrb, 
	input [3:0]			wid, 	
	output 				bvalid, 
	input 				bready, 
	output [1:0]			bresp, 
	output [3:0]			bid, 	
	input 				arvalid, 
	output 				arready, 
	input [ADDR_WIDTH-1:0]		araddr, 
	input [2:0]			arsize, 
	input [1:0]			arburst,
	input [3:0]			arid, 
	input [ 3:0]			arlen, 
	output 				rvalid, 
	input 				rready,
	output 				rlast, 
	output [DATA_WIDTH-1:0]		rdata, 
	output [1:0]			rresp, 
	output [ 3:0]			rid,
	output [13:0]			mem_addr,
        output 				mem_ce,
        output 				mem_we,
        output [DATA_WIDTH-1:0] 	mem_wdata,
        input  [DATA_WIDTH-1:0] 	mem_rdata,
        output [STRB_WIDTH-1:0]		mem_bywe);
	

	// AXI Decode side FIFO	
	wire        axi_aw_cntl_wr_req;
        wire [29:0] axi_aw_cntl_wr_din;
        wire        axi_aw_cntl_wr_full;
        wire        axi_w_data_wr_req;
        wire [40:0] axi_w_data_wr_din;
        wire        axi_w_data_wr_full;
        wire        axi_ar_cntl_wr_req;
        wire [29:0] axi_ar_cntl_wr_din;
        wire        axi_ar_cntl_wr_full;
        wire        axi_r_data_rd_req;
        wire [38:0] axi_r_data_rd_dout;
        wire        axi_r_data_rd_empty;

	// Memory Control Side FIFO
	wire        axi_aw_cntl_rd_req;
	wire        axi_aw_cntl_rd_empty;
	wire [29:0] axi_aw_cntl_rd_dout;
	wire        axi_ar_cntl_rd_req;
	wire        axi_ar_cntl_rd_empty;
	wire [29:0] axi_ar_cntl_rd_dout;
	wire        axi_w_data_rd_req;
	wire        axi_w_data_rd_empty;
	wire [40:0] axi_w_data_rd_dout;
	wire        axi_r_data_wr_req;
	wire        axi_r_data_wr_full;
	wire [38:0] axi_r_data_wr_din;    
	
	
	// AXI Decoder
	axi_decoder axi_decoder(
				.clk			(aclk), 
				.resetn			(aresetn),
				.awvalid		(awvalid),
				.awready		(awready), 
				.awaddr			(awaddr), 
				.awsize			(awsize), 
				.awburst		(awburst),
 				.awid			(awid), 	
				.awlen			(awlen), 
				.wvalid			(wvalid), 
				.wready			(wready),
				.wlast			(wlast), 	
				.wdata			(wdata), 
				.wstrb			(wstrb), 
				.wid			(wid), 	 
				.arvalid		(arvalid), 
				.arready		(arready), 
				.araddr			(araddr), 
				.arsize			(arsize), 
				.arburst		(arburst),
				.arid			(arid), 
				.arlen			(arlen), 
				.rvalid			(rvalid), 
				.rready			(rready),
				.rlast			(rlast), 
				.rdata			(rdata), 
				.rresp			(rresp), 
				.rid			(rid), 
				.axi_aw_cntl_wr_req	(axi_aw_cntl_wr_req),
				.axi_aw_cntl_wr_din	(axi_aw_cntl_wr_din),
				.axi_aw_cntl_wr_full	(axi_aw_cntl_wr_full),
				.axi_w_data_wr_req	(axi_w_data_wr_req),
				.axi_w_data_wr_din	(axi_w_data_wr_din),
				.axi_w_data_wr_full	(axi_w_data_wr_full),
				.axi_ar_cntl_wr_req	(axi_ar_cntl_wr_req),
				.axi_ar_cntl_wr_din	(axi_ar_cntl_wr_din),
				.axi_ar_cntl_wr_full	(axi_ar_cntl_wr_full),
				.axi_r_data_rd_req	(axi_r_data_rd_req),
				.axi_r_data_rd_dout	(axi_r_data_rd_dout),
				.axi_r_data_rd_empty	(axi_r_data_rd_empty));
	// FIFOS
		// Write Control FIFO
		nds_sync_fifo_data #(	.FIFO_DEPTH(8), 
					.DATA_WIDTH(30), 
					.POINTER_INDEX_WIDTH(4)) 	
				aw_cntl_fifo(  	.w_reset_n	(aresetn		),
						.r_reset_n	(sram_resetn		),
						.w_clk		(aclk			),
						.r_clk		(sram_clk		),
    						.wr_data	(axi_aw_cntl_wr_din	),
    						.wr		(axi_aw_cntl_wr_req	),
    						.rd		(axi_aw_cntl_rd_req	),
    						.rd_data	(axi_aw_cntl_rd_dout	),
						.w_clk_empty	(			),
    						.empty		(axi_aw_cntl_rd_empty	),
    						.full		(axi_aw_cntl_wr_full	)
		);

		// Read Control FIFO
		nds_sync_fifo_data #(	.FIFO_DEPTH(8), 
					.DATA_WIDTH(30), 
					.POINTER_INDEX_WIDTH(4)) 	
				ar_cntl_fifo(  	.w_reset_n	(aresetn		),
						.r_reset_n	(sram_resetn		),
						.w_clk		(aclk			),
						.r_clk		(sram_clk		),
    						.wr_data	(axi_ar_cntl_wr_din	),
    						.wr		(axi_ar_cntl_wr_req	),
    						.rd		(axi_ar_cntl_rd_req	),
    						.rd_data	(axi_ar_cntl_rd_dout	),
						.w_clk_empty	(			),
    						.empty		(axi_ar_cntl_rd_empty	),
    						.full		(axi_ar_cntl_wr_full	)
		);

		// Write Data FIFO
		nds_sync_fifo_data #(	.FIFO_DEPTH(16), 
					.DATA_WIDTH(41), 
					.POINTER_INDEX_WIDTH(5)) 	
				w_data_fifo(  	.w_reset_n	(aresetn		),
						.r_reset_n	(sram_resetn		),
						.w_clk		(aclk			),
						.r_clk		(sram_clk		),
    						.wr_data	(axi_w_data_wr_din	),
    						.wr		(axi_w_data_wr_req	),
    						.rd		(axi_w_data_rd_req	),
    						.rd_data	(axi_w_data_rd_dout	),
						.w_clk_empty	(			),
    						.empty		(axi_w_data_rd_empty	),
    						.full		(axi_w_data_wr_full	)
		);
		
		// Read Data FIFO
		nds_sync_fifo_data #(	.FIFO_DEPTH(16), 
					.DATA_WIDTH(39), 
					.POINTER_INDEX_WIDTH(5)) 	
				r_data_fifo(  	.w_reset_n	(aresetn		),
						.r_reset_n	(sram_resetn		),
						.w_clk		(aclk			),
						.r_clk		(sram_clk		),
    						.wr_data	(axi_r_data_wr_din	),
    						.wr		(axi_r_data_wr_req	),
    						.rd		(axi_r_data_rd_req	),
    						.rd_data	(axi_r_data_rd_dout	),
						.w_clk_empty	(			),
    						.empty		(axi_r_data_rd_empty	),
    						.full		(axi_r_data_wr_full	)
		);
		
	// Memory Control
	mem_cntl	mem_controller(
				.clk			(sram_clk),
				.resetn			(sram_resetn),
      				.axi_aw_cntl_rd_req	(axi_aw_cntl_rd_req),
				.axi_aw_cntl_rd_empty	(axi_aw_cntl_rd_empty),
      				.axi_aw_cntl_rd_dout	(axi_aw_cntl_rd_dout),
				.axi_ar_cntl_rd_req	(axi_ar_cntl_rd_req),
				.axi_ar_cntl_rd_empty	(axi_ar_cntl_rd_empty),
      				.axi_ar_cntl_rd_dout	(axi_ar_cntl_rd_dout),
				.axi_w_data_rd_req	(axi_w_data_rd_req),
				.axi_w_data_rd_empty	(axi_w_data_rd_empty),
				.axi_w_data_rd_dout	(axi_w_data_rd_dout),
				.axi_r_data_wr_req	(axi_r_data_wr_req),
				.axi_r_data_wr_full	(axi_r_data_wr_full),
				.axi_r_data_wr_din	(axi_r_data_wr_din),
				.mem_addr		(mem_addr),
				.mem_ce			(mem_ce),
				.mem_we			(mem_we),
				.mem_wdata		(mem_wdata),
				.mem_rdata		(mem_rdata),
				.mem_bywe		(mem_bywe),
				.bvalid			(bvalid), 
				.bready			(bready), 
				.bresp			(bresp), 
				.bid			(bid));					



endmodule

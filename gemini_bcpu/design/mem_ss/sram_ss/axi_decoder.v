//-----------------------------------------------------------------------------
//	RapidSilicon
//	Author:	Michael Wood
//	Date:	3/9/2022
//-----------------------------------------------------------------------------
module axi_decoder #(
	parameter ADDR_WIDTH = 32,
	parameter DATA_WIDTH = 32, 
	parameter STRB_WIDTH = (DATA_WIDTH/8))
	
	(
	input 				clk, 
	input 				resetn,
	input 				awvalid,
	output reg			awready, 
	input [ADDR_WIDTH-1:0] 		awaddr, 
	input [2:0] 			awsize, 
	input [1:0]			awburst,
 	input [3:0]			awid, 	
	input [3:0]			awlen, 
	input 				wvalid, 
	output reg			wready,
	input 				wlast, 	
	input [DATA_WIDTH-1:0]		wdata, 
	input [STRB_WIDTH-1:0]		wstrb, 
	input [3:0]			wid, 	 
	input 				arvalid, 
	output reg			arready, 
	input [ADDR_WIDTH-1:0]		araddr, 
	input [2:0]			arsize, 
	input [1:0]			arburst,
	input [3:0]			arid, 
	input [3:0]			arlen, 
	output reg			rvalid, 
	input 				rready,
	output reg 			rlast, 
	output reg [DATA_WIDTH-1:0]	rdata, 
	output reg [1:0]		rresp, 
	output reg [3:0]		rid, 
	output reg 			axi_aw_cntl_wr_req,
	output reg [29:0]		axi_aw_cntl_wr_din,
	input 				axi_aw_cntl_wr_full,
	output reg			axi_ar_cntl_wr_req,
	output reg [29:0]		axi_ar_cntl_wr_din,
	input 				axi_ar_cntl_wr_full,
	output reg			axi_w_data_wr_req,
	output reg [40:0]		axi_w_data_wr_din,
	input 				axi_w_data_wr_full,
	output reg			axi_r_data_rd_req,
	input 	   [38:0]		axi_r_data_rd_dout,
	input 				axi_r_data_rd_empty);
		

	wire [29:0]	axi_wr_cntl;
	wire [29:0]	axi_rd_cntl;
	wire [40:0] 	axi_wr_data;
	wire		axi_w_error;
	wire		axi_r_error;
	wire 			rlast_w;
	wire [DATA_WIDTH-1:0]	rdata_w;
	wire [1:0]		rresp_w;
	wire [3:0]		rid_w;
	reg			rvalid_pre;

	// Error triggered one unaligned address or FIFO overflow	
	assign axi_w_error = ((awaddr[1:0] != 2'h0 ) || (awsize > 2)) ? 1'b1 : 1'b0;
	assign axi_r_error = ((araddr[1:0] != 2'h0 ) || (arsize > 2)) ? 1'b1 : 1'b0;

	assign axi_wr_cntl = {axi_w_error, awid, awburst, awsize, awlen, awaddr[15:0]};
	assign axi_rd_cntl = {axi_r_error, arid, arburst, arsize, arlen, araddr[15:0]};
	assign axi_wr_data = {wlast, wid, wstrb, wdata};
		

	assign rlast_w  = axi_r_data_rd_dout[38];
	assign rid_w    = axi_r_data_rd_dout[37:34];
	assign rresp_w  = axi_r_data_rd_dout[33:32];
	assign rdata_w  = axi_r_data_rd_dout[31:0];
	
	always@(*) begin
		awready <= !axi_aw_cntl_wr_full;
		arready <= !axi_ar_cntl_wr_full;
		wready 	<= !axi_w_data_wr_full;	
	end

	// Latch Read Control Info
	always@(*) begin
		if(axi_r_data_rd_empty) begin
			rvalid 	<= 1'b0;
			rlast 	<= 1'b0;
			rresp	<= 2'h0;
			rid	<= 4'h0;
			rdata	<= 32'h0;
		end
		else begin
			rvalid 	<= 1'b1;
			rlast 	<= rlast_w;
			rresp	<= rresp_w;
			rid	<= rid_w;
			rdata	<= rdata_w;
		end

		if(~axi_r_data_rd_empty && rready)
			axi_r_data_rd_req <= 1'b1;
		else
			axi_r_data_rd_req <= 1'b0;
	end	

	always@(posedge clk, negedge resetn)
	begin
		if(~resetn)
		begin
			axi_aw_cntl_wr_req <= 1'h0;
			axi_aw_cntl_wr_din <= 30'h0;
			axi_w_data_wr_req <= 1'h0;
			axi_w_data_wr_din <= 77'h0;
			axi_ar_cntl_wr_req <= 1'h0;
			axi_ar_cntl_wr_din <= 30'h0;
		end
		else 
		begin
			if(awvalid && awready) begin	// Write Address Ready
				axi_aw_cntl_wr_req <= 1;
				axi_aw_cntl_wr_din <= axi_wr_cntl;
			end
			else begin
				axi_aw_cntl_wr_req <= 0;
				axi_aw_cntl_wr_din <= 30'h0;
			end

			if(arvalid && arready) begin	// Read Address Ready
				axi_ar_cntl_wr_req <= 1;
				axi_ar_cntl_wr_din <= axi_rd_cntl;
			end
			else begin
				axi_ar_cntl_wr_req <= 0;
				axi_ar_cntl_wr_din <= 30'h0;
			end
			if(wvalid && wready) begin		// Write Data Channel
				axi_w_data_wr_req <= 1;
				axi_w_data_wr_din <= axi_wr_data;
			end
			else begin
				axi_w_data_wr_req <= 0;
				axi_w_data_wr_din <= 41'h0;
			end
		end
	end

endmodule

//-----------------------------------------------------------------------------
//	RapidSilicon
//	Author:	Michael Wood
//	Date:	3/9/2022
//-----------------------------------------------------------------------------
module mem_cntl(
	input			clk,
	input 			resetn,
	output reg		axi_aw_cntl_rd_req,
	input			axi_aw_cntl_rd_empty,
	input 	   [29:0]	axi_aw_cntl_rd_dout,
	output reg		axi_ar_cntl_rd_req,
	input 			axi_ar_cntl_rd_empty,
	input 	   [29:0]	axi_ar_cntl_rd_dout,
	output reg		axi_w_data_rd_req,
	input 			axi_w_data_rd_empty,
	input 	   [40:0] 	axi_w_data_rd_dout,
	output   		axi_r_data_wr_req,
	input			axi_r_data_wr_full,
	output     [38:0] 	axi_r_data_wr_din,
	output reg [13:0]	mem_addr,
	output reg 		mem_ce,
	output   		mem_we,
	output 	   [31:0]	mem_wdata,
	input	   [31:0]	mem_rdata,
	output     [ 3:0] 	mem_bywe,
	output reg		bvalid, 
	input 			bready, 
	output reg [ 1:0]	bresp, 
	output reg [ 3:0]	bid);					



	parameter IDLE 		= 2'h0;
	parameter FIRST_ACCESS 	= 2'h1;
	parameter BURST_ACCESS 	= 2'h2;
	// Arbiter Control Signals
	wire 		wr_granted;
	wire		rd_granted;

	// Memory Control Information
	reg [30:0] 	axi_cntl_word;
	wire		error;
	reg 		rlast;
	reg 		rlast_pre;
	reg  [ 3:0]	rid;
	reg  [ 3:0]	rid_pre;
	reg  [ 1:0]	rresp;
	reg  [31:0]	rdata;

	// MEM_CS control singals	
	wire 		xaction_avail;
	wire		xaction_done;
	wire		xaction_done_pre;
	wire		data_avail;
	reg		xaction_avail_q;
	wire [ 2:0] 	burst_type;
	wire [15:0] 	axaddr;
	reg  [15:0]	axaddr_mod;
	wire [15:0] 	axaddr_thresh;
	wire [15:0] 	axaddr_base;
	wire [3:0]  	axlen;
	wire [3:0] 	axsize;
	wire [3:0]  axid;
	reg [3:0]  access_cnt;
	reg [3:0]  rd_avail_cnt;
	reg [3:0]  rd_serv_cnt;
	reg 	   gen_response;
	wire 	   read_done;

	reg [1:0]	mem_cs;
	reg [1:0] 	mem_ns;
	wire 		mem_cs_is_IDLE;

	// Submodule Instantiations
	// Arbiter
	arbiter arbiter(.clk(clk),
			.resetn(resetn),
			.wr_req(!axi_aw_cntl_rd_empty),
			.rd_req(!axi_ar_cntl_rd_empty),
			.done(xaction_done_pre),
			.wr_granted(wr_granted),
			.rd_granted(rd_granted));



	assign xaction_avail 	= !axi_aw_cntl_rd_empty || !axi_ar_cntl_rd_empty;
	assign data_avail	= ((!bvalid && !axi_w_data_rd_empty && mem_we) || (!axi_r_data_wr_full && !mem_we)) && !mem_cs_is_IDLE;
	assign xaction_done 	= ((access_cnt == axlen) && data_avail && !mem_cs_is_IDLE) ? 1'b1 : 1'b0;
	assign xaction_done_pre = (axlen != 0 ? (access_cnt == (axlen - 1)) : (access_cnt == axlen)) && data_avail && !mem_cs_is_IDLE;
	assign read_done	= rlast && axi_r_data_wr_req;

	always@(posedge clk, negedge resetn) begin
		if(!resetn)	xaction_avail_q <= 1'b0;
		else 		xaction_avail_q <= xaction_avail;
	end

	always@(posedge clk, negedge resetn) begin
		if(!resetn) axi_cntl_word <= {1'b0, 30'h0};
		else begin
			if((mem_cs == IDLE && mem_ns != IDLE) || (xaction_done && mem_cs == BURST_ACCESS)) begin
				if(wr_granted)
					axi_cntl_word <= {1'b1, axi_aw_cntl_rd_dout};
				else if(rd_granted)
					axi_cntl_word <= {1'b0, axi_ar_cntl_rd_dout};
				else
					axi_cntl_word <= {1'b0, 30'h0};
			end	
		end
	end

	assign mem_cs_is_IDLE = mem_cs == IDLE ?  1'b1 : 1'b0;

	assign mem_wdata 		= axi_w_data_rd_dout[31:0];
	assign mem_bywe			= axi_w_data_rd_dout[35:32];	


	assign axi_r_data_wr_req = ( (rd_avail_cnt != rd_serv_cnt) && !axi_r_data_wr_full )? 1'b1 : 1'b0;
	assign axi_r_data_wr_din = {rlast, rid, rresp, rdata};
		
	// Latch AXI Read Data Info
	always@(*) begin
		if(axi_r_data_wr_req) 	rresp <= (error ? 2'h2 : 2'h0);
		if(axi_r_data_wr_req)	rdata <= mem_rdata;
	end

	always@(posedge clk, negedge resetn) begin
		if(!resetn) begin
			rlast			<= 1'b0;
			rid			<= 1'b0;
		end
		else begin
			rlast			<= (mem_we) ? 1'b0 : data_avail ? xaction_done 	: !read_done ? rlast : 1'b0;
			rid			<= (mem_we) ? 4'h0 : data_avail ? axid 		: !read_done ? rid   : 4'h0;
		end
		
	end
	
	// Burst Access Counter
	always@(posedge clk, negedge resetn) begin
		if(!resetn) 		
			access_cnt <= 7'h0;
		else if(xaction_done) 	
			access_cnt 	<= 7'h0;
		else if(data_avail) 
			access_cnt <= access_cnt + 1;	
		else 	
			access_cnt <= access_cnt;
	end

	// Read Logic
	always@(posedge clk, negedge resetn) begin
		if(!resetn) begin
			rd_avail_cnt <= 4'h0;
			rd_serv_cnt <= 4'h0;
		end 
		else begin	
			if(mem_ce && ~mem_we) 	rd_avail_cnt <= rd_avail_cnt + 1;
			else 			rd_avail_cnt <= rd_avail_cnt;
			
			if(axi_r_data_wr_req)	rd_serv_cnt <= rd_serv_cnt + 1;
			else 			rd_serv_cnt <= rd_serv_cnt;
		end
	end
	// Address Calculation
	always@(posedge clk, negedge resetn) begin
		if(~resetn) axaddr_mod <= 16'h0;
		else begin
			if(data_avail) begin
				if(burst_type == 1) begin
					axaddr_mod <= ((axaddr_base) + ((access_cnt+1) * (axsize)));
				end
				else if(burst_type == 2) begin
					if( ((axaddr_base) + ((access_cnt+1) * (axsize))) >= axaddr_thresh)
						axaddr_mod <= (axaddr_base) + ((access_cnt+1) * (axsize)) - ((axsize)*(axlen+1));
					else	
						axaddr_mod <=  ((axaddr_base) + ((access_cnt+1) * (axsize)));
				end
				else begin	// Fixed Burst
					axaddr_mod <= axaddr_base;
				end
			end
			else 	axaddr_mod <= axaddr_mod;
		end
	end	

	assign axaddr_base	= axi_cntl_word[15:0];
	assign axaddr_thresh	= ((axi_cntl_word[15:0] / ((axlen+1)*(axsize))) *  ((axlen+1)*(axsize))) + ((axlen+1)*(axsize));
	assign axaddr		= (access_cnt == 0) ? axi_cntl_word[15:0] : axaddr_mod;
	assign burst_type 	= axi_cntl_word[24:23];
	assign axlen	   	= axi_cntl_word[19:16];
	assign axsize	   	= (1 << axi_cntl_word[22:20]);
	assign axid	   	= axi_cntl_word[28:25];
	assign error	   	= axi_cntl_word[29];
	assign mem_we	   	= axi_cntl_word[30];
	
	// Memory Access State Machine
	always@(posedge clk, negedge resetn) begin
		if(~resetn) begin
			mem_cs <= 2'd0;
		end
		else begin
			mem_cs <= mem_ns;
		end
	end		


	// Memory Access State Machine Combo Logic
	always@(*) begin
		case(mem_cs)
			IDLE : begin
				// Set Memory Interface Out
				mem_ce 		<= 1'b0;
				axi_w_data_rd_req <= 1'b0;
				axi_aw_cntl_rd_req	<= wr_granted ? 1'b1 : 1'b0;
				axi_ar_cntl_rd_req	<= rd_granted ? 1'b1 : 1'b0;
				gen_response 	<= 1'b0;
				if(xaction_avail_q) begin
					mem_ns 	 <= FIRST_ACCESS;
					mem_addr <= axaddr[15:2];
				end 
				else begin	
					mem_ns <= IDLE;
					mem_addr <= 16'h0;
				end

			end
			FIRST_ACCESS: begin
				axi_aw_cntl_rd_req	<= 1'b0;
				axi_ar_cntl_rd_req	<= 1'b0;
				mem_addr 	<= axaddr[15:2]; 
				if(data_avail) begin
					// Set Memory Interface Out
					mem_ce 		<= error ? 1'b0 : 1'b1;
					axi_w_data_rd_req 	<= mem_we ? 1'b1 : 1'b0;
					// State Transition
					if(!xaction_done) begin
						mem_ns 		<= BURST_ACCESS;
						gen_response 	<= 1'b0;
					end
					else if(xaction_done) begin	// Single burst creates throughput bubble
						mem_ns 		<= IDLE;
						gen_response 	<= mem_we ? 1'b1 : 1'b0;
					end 
					else begin
						mem_ns 		<= IDLE;
						gen_response 	<= 1'b0;
					end
				end 
				else begin
					mem_ce	<= 1'b0;
					mem_ns <= FIRST_ACCESS;
					axi_w_data_rd_req 	<= 1'b0;
					gen_response 	<= 1'b0;
				end
				
			end
			BURST_ACCESS: begin
				mem_addr 	<= axaddr[15:2];
				if(data_avail) begin
					// Set Memory Interface Out
					mem_ce 		<= error ? 1'b0 : 1'b1;
					axi_w_data_rd_req <= mem_we ? 1'b1 : 1'b0;
					// State Transition
					if(!xaction_done) begin
						mem_ns <= BURST_ACCESS;
						axi_aw_cntl_rd_req	<= 1'b0;
						axi_ar_cntl_rd_req	<= 1'b0;
						gen_response <= 1'b0;
					end
					else if(xaction_avail_q) begin
						mem_ns <= FIRST_ACCESS;
						gen_response 	<= mem_we ? 1'b1 : 1'b0;
						axi_aw_cntl_rd_req	<= wr_granted ? 1'b1 : 1'b0;
						axi_ar_cntl_rd_req	<= rd_granted ? 1'b1 : 1'b0;
					end
					else begin
						mem_ns 		<= IDLE;
						gen_response 	<= mem_we ? 1'b1 : 1'b0;
						axi_aw_cntl_rd_req	<= 1'b0;
						axi_ar_cntl_rd_req	<= 1'b0;
					end
				end
				else begin
					mem_ce <= 1'b0;
					mem_ns <= BURST_ACCESS;
					axi_w_data_rd_req 	<= 1'b0;
					axi_aw_cntl_rd_req	<= 1'b0;
					axi_ar_cntl_rd_req	<= 1'b0;
					gen_response <= 1'b0;
				end
			end
			default: begin
				mem_ce 			<=1'b0;	// Disable Memory Interface
				mem_addr 		<= 13'h0;
				axi_aw_cntl_rd_req	<= 1'b0;
				axi_ar_cntl_rd_req	<= 1'b0;
				axi_w_data_rd_req 	<= 1'b0;
				mem_ns 			<= IDLE;
				gen_response 		<= 1'b0;
			end
		endcase
	end

	// Response Generation Block
	always@(posedge clk, negedge resetn) begin
		if(!resetn) begin
			bvalid 	<= 1'b0;
			bid	<= 4'h0;
			bresp	<= 2'h0;
		end
		else begin	
			// Latch Response Info
			if(gen_response) begin
				bid	<= axid;
				bresp 	<= error ? 2'h2 : 2'h0;
				bvalid	<= 1'b1;
			end
			else if(!bready) begin
				bid	<= bid;
				bresp 	<= bresp;
				bvalid	<= bvalid;
			end
			else begin
				bid	<= 4'h0;
				bresp 	<= 2'h0;
				bvalid 	<= 1'b0;

			end
		end
	end
endmodule

// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atcrambrg500 (
        	  clk,
        	  clk_en,
        	  resetn,
        	  a_valid,
        	  a_ready,
        	  a_addr,
        	  a_data,
        	  a_opcode,
        	  a_mask,
        	  a_size,
        	  a_parity0,
        	  a_parity1,
        	  d_valid,
        	  d_ready,
        	  d_data,
        	  d_parity0,
        	  d_parity1,
        	  d_denied,
        	  ram0_cs,
        	  ram0_we,
        	  ram0_addr,
        	  ram0_wdata,
        	  ram0_bwe,
        	  ram0_rdata,
        	  ram1_cs,
        	  ram1_we,
        	  ram1_addr,
        	  ram1_wdata,
        	  ram1_bwe,
        	  ram1_rdata
);

parameter US_AW      		= 12;
parameter DS_DW                 = 32;

localparam US_DW      		= 64;
localparam PREFETCH_SUPPORT     = 1;
localparam RAM_NUM		= ((DS_DW == 32) | (DS_DW == 39)) ? 2 : 1;

localparam PRODUCT_ID		= 32'h000B5000;

localparam ECC_SUPPORT          = ((DS_DW == 39) | (DS_DW == 72)) ? 1 : 0;
localparam BLOCK_DW             = (DS_DW <= 39) ? 32 : 64;
localparam BUS_BLOCKS           = US_DW/BLOCK_DW;
localparam RAM_BLOCKS		= RAM_NUM;

localparam BLOCK_BW		= BLOCK_DW / 8;
localparam RAM_DW		= RAM_BLOCKS * BLOCK_DW;
localparam EW			= ECC_SUPPORT ? ((US_DW/BUS_BLOCKS) == 32) ? 7 : 8 : 1;
localparam RAM_BLOCK_DW		= ECC_SUPPORT ? BLOCK_DW + EW : BLOCK_DW;
localparam RAM_BLOCK_AW  	= US_AW - $clog2(RAM_BLOCKS/BUS_BLOCKS) - $clog2(US_DW/8);
localparam RAM_BLOCK_BWE 	= BLOCK_BW + ECC_SUPPORT;
localparam RAM_BLOCKS_DW	= RAM_BLOCK_DW * RAM_BLOCKS;
localparam BLOCK_ALSB    	= $clog2(RAM_DW) - 3;

input				clk;
input				clk_en;
input				resetn;

input				a_valid;
output				a_ready;
input	[US_AW-1:0]		a_addr;
input	[US_DW-1:0]		a_data;
input	[2:0]			a_opcode;
input	[(US_DW/8)-1:0]		a_mask;
input	[2:0]			a_size;
input	[EW-1:0]		a_parity0;
input	[EW-1:0]		a_parity1;

output				d_valid;
input				d_ready;
output	[US_DW-1:0]		d_data;
output	[EW-1:0]		d_parity0;
output	[EW-1:0]		d_parity1;
output				d_denied;

output				ram0_cs;
output				ram0_we;
output	[RAM_BLOCK_AW-1:0]	ram0_addr;
output	[RAM_BLOCK_DW-1:0]	ram0_wdata;
output	[RAM_BLOCK_BWE-1:0]	ram0_bwe;
input	[RAM_BLOCK_DW-1:0]	ram0_rdata;

output				ram1_cs;
output				ram1_we;
output	[RAM_BLOCK_AW-1:0]	ram1_addr;
output	[RAM_BLOCK_DW-1:0]	ram1_wdata;
output	[RAM_BLOCK_BWE-1:0]	ram1_bwe;
input	[RAM_BLOCK_DW-1:0]	ram1_rdata;

reg				req_buf_valid;
wire				req_buf_valid_set;
wire				req_buf_valid_clr;
wire				req_buf_valid_nx;
wire				req_buf_valid_en;

reg	[US_AW-1:0]		req_buf_addr;
reg				req_buf_wr;
reg	[(US_DW/8)-1:0]		req_buf_mask;
reg	[US_DW-1:0]		req_buf_data;
reg	[2:0]			req_buf_size;
reg	[EW-1:0]		req_buf_parity0;
reg	[EW-1:0]		req_buf_parity1;

wire				req_buf_hit;
wire				req_buf_denied;
wire				req_buf_wr_done;

wire				req_ram_buf_denied;

wire	[US_DW-1:0]		req_resp_data;
wire	[EW-1:0]		req_resp_parity0;
wire	[EW-1:0]		req_resp_parity1;

reg				wr_done_wait_d_ready;
wire				wr_done_wait_d_ready_set;
wire				wr_done_wait_d_ready_clr;
wire				wr_done_wait_d_ready_nx;
wire				wr_done_wait_d_ready_en;

wire				req_buf_hit_prefb0;
wire				req_buf_hit_prefb1;
wire				req_buf_hit_data_phase;


reg				req_ram_buf_valid;
wire				req_ram_buf_valid_set;
wire				req_ram_buf_valid_clr;
wire				req_ram_buf_valid_nx;
wire				req_ram_buf_valid_en;

wire				req_ram_buf_from_req_buf;

reg	[US_AW-1:0]		req_ram_buf_addr;
reg				req_ram_buf_wr;
reg	[(US_DW/8)-1:0]		req_ram_buf_mask;
reg	[US_DW-1:0]		req_ram_buf_data;
reg	[2:0]			req_ram_buf_size;
reg	[EW-1:0]		req_ram_buf_parity0;
reg	[EW-1:0]		req_ram_buf_parity1;

wire	[US_AW-1:0]		req_ram_buf_addr_nx;
wire				req_ram_buf_wr_nx;
wire	[(US_DW/8)-1:0]		req_ram_buf_mask_nx;
wire	[US_DW-1:0]		req_ram_buf_data_nx;
wire	[2:0]			req_ram_buf_size_nx;
wire	[EW-1:0]		req_ram_buf_parity0_nx;
wire	[EW-1:0]		req_ram_buf_parity1_nx;

reg				d_valid_buf_valid;
wire				d_valid_buf_valid_set;
wire				d_valid_buf_valid_clr;
wire				d_valid_buf_valid_nx;
wire				d_valid_buf_valid_en;
reg	[US_DW-1:0]		d_valid_buf_data;
reg	[EW-1:0]		d_valid_buf_parity0;
reg	[EW-1:0]		d_valid_buf_parity1;
reg				d_valid_buf_denied;

wire				prefb0_alloc_valid;
wire	[US_AW-1:0]		prefb0_addr;
wire				prefb0_data_valid;
wire	[RAM_BLOCKS_DW-1:0]	prefb0_data;
wire				prefb1_alloc_valid;
wire	[US_AW-1:0]		prefb1_addr;
wire				prefb1_data_valid;
wire	[RAM_BLOCKS_DW-1:0]	prefb1_data;
wire	[RAM_BLOCKS_DW-1:0]	prefb0_data_nx;
wire	[RAM_BLOCKS_DW-1:0]	prefb1_data_nx;

wire				prefb0_ret;
wire				prefb1_ret;
wire				prefb_fill_full;


wire				prefb_ram_buf_valid;

wire	[US_AW-1:0]		prefb_ram_buf_addr;


wire				ram_sel_prefb;
wire				req_ram_buf_is_prefb_ram_buf;
wire				req_ram_buf_hit_prefb0;
wire				req_ram_buf_hit_prefb1;
wire				req_ram_buf_hit_dphase;
wire				req_ram_buf_wr_acc;

reg				ram_data_phase_valid;
wire				ram_data_phase_valid_set;
wire				ram_data_phase_valid_clr;
wire				ram_data_phase_valid_nx;
wire				ram_data_phase_valid_en;
reg	[US_AW-1:0]		ram_data_phase_addr;
wire	[US_AW-1:0]		ram_data_phase_addr_nx;
reg				ram_data_phase_wr;

wire				ram_cs;
wire				ram_we;
wire	[RAM_DW-1:0]		ram_wdata;
wire	[RAM_DW/8-1:0]		ram_mask;
wire	[RAM_BLOCK_AW-1:0]	ram_addr;

reg				ram_data_phase_stable;
wire				ram_data_phase_stable_set;
wire				ram_data_phase_stable_clr;
wire				ram_data_phase_stable_nx;
wire				ram_data_phase_stable_en;

wire				ram_rd_access_from_bus;
wire				ram_wr_access_from_bus;



generate
if (RAM_BLOCKS == 1) begin : gen_1_ram_prefb_data_nx
	assign prefb0_data_nx = ram0_rdata;
	assign prefb1_data_nx = ram0_rdata;
end
else if (RAM_BLOCKS == 2) begin : gen_2_ram_prefb_data_nx
	assign prefb0_data_nx = {ram1_rdata, ram0_rdata};
	assign prefb1_data_nx = {ram1_rdata, ram0_rdata};
end
else begin : gen_ram_prefb_data_stub
	wire   nds_unused_prefb_data = (|prefb0_data_nx) | (|prefb0_data_nx);
	assign prefb0_data_nx = {RAM_BLOCKS_DW{1'b0}};
	assign prefb1_data_nx = {RAM_BLOCKS_DW{1'b0}};
end
endgenerate


generate
if (PREFETCH_SUPPORT == 1) begin : gen_prefetch_buffer
	reg				prefb0_alloc_valid_reg;
	wire				prefb0_alloc_valid_set;
	wire				prefb0_alloc_valid_clr;
	wire				prefb0_alloc_valid_nx;
	wire				prefb0_alloc_valid_en;
	reg	[US_AW-1:0]		prefb0_addr_reg;
	wire	[US_AW-1:0]		prefb0_addr_nx;
	reg				prefb0_data_valid_reg;
	wire				prefb0_data_valid_set;
	wire				prefb0_data_valid_clr;
	wire				prefb0_data_valid_en;
	wire				prefb0_data_valid_nx;
	reg	[RAM_BLOCKS_DW-1:0]	prefb0_data_reg;

	reg				prefb1_alloc_valid_reg;
	wire				prefb1_alloc_valid_set;
	wire				prefb1_alloc_valid_clr;
	wire				prefb1_alloc_valid_nx;
	wire				prefb1_alloc_valid_en;
	reg	[US_AW-1:0]		prefb1_addr_reg;
	wire	[US_AW-1:0]		prefb1_addr_nx;
	reg				prefb1_data_valid_reg;
	wire				prefb1_data_valid_set;
	wire				prefb1_data_valid_clr;
	wire				prefb1_data_valid_en;
	wire				prefb1_data_valid_nx;
	reg	[RAM_BLOCKS_DW-1:0]	prefb1_data_reg;

	reg				fill_ptr;
	wire				fill_ptr_nx;
	wire				fill_ptr_update;

	reg				alloc_ptr;
	wire				alloc_ptr_nx;
	wire				alloc_ptr_update;

	wire				prefb_miss_clr;

	wire				prefb_alloc_full;

	reg				prefb_ram_buf_valid_reg;
	wire				prefb_ram_buf_valid_set;
	wire				prefb_ram_buf_valid_clr;
	wire				prefb_ram_buf_valid_nx;
	wire				prefb_ram_buf_valid_en;

	reg	[US_AW-1:0]		prefb_ram_buf_addr_reg;
	wire	[US_AW-1:0]		prefb_ram_buf_addr_nx;


	assign prefb0_alloc_valid_set = (~prefb0_alloc_valid & ram_sel_prefb & ~alloc_ptr & clk_en)
				      | (clk_en & ram_rd_access_from_bus)
				      | (prefb0_ret & ~prefb_miss_clr)
				      ;
	assign prefb0_alloc_valid_clr = prefb_miss_clr;
	assign prefb0_alloc_valid_nx  = (prefb0_alloc_valid & ~prefb0_alloc_valid_clr) | prefb0_alloc_valid_set;
	assign prefb0_alloc_valid_en  = prefb0_alloc_valid_set | prefb0_alloc_valid_clr;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			prefb0_alloc_valid_reg <= 1'b0;
		else if (prefb0_alloc_valid_en)
			prefb0_alloc_valid_reg <= prefb0_alloc_valid_nx;
	end
	assign prefb0_alloc_valid = prefb0_alloc_valid_reg;

	assign prefb0_addr_nx = ram_rd_access_from_bus ? req_ram_buf_addr : prefb0_ret ? ram_data_phase_addr : prefb_ram_buf_addr;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			prefb0_addr_reg <= {US_AW{1'b0}};
		else if (prefb0_alloc_valid_set)
			prefb0_addr_reg <= prefb0_addr_nx;
	end
	assign prefb0_addr = prefb0_addr_reg;

	assign prefb1_alloc_valid_set = (~prefb1_alloc_valid & ram_sel_prefb & alloc_ptr & clk_en)
				      | prefb1_ret
				      ;
	assign prefb1_alloc_valid_clr = prefb_miss_clr;
	assign prefb1_alloc_valid_nx  = (prefb1_alloc_valid | prefb1_alloc_valid_set) & ~prefb1_alloc_valid_clr;
	assign prefb1_alloc_valid_en  = prefb1_alloc_valid_set | prefb1_alloc_valid_clr;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			prefb1_alloc_valid_reg <= 1'b0;
		else if (prefb1_alloc_valid_en)
			prefb1_alloc_valid_reg <= prefb1_alloc_valid_nx;
	end

	assign prefb1_alloc_valid = prefb1_alloc_valid_reg;

	assign prefb1_addr_nx = prefb1_ret ? ram_data_phase_addr : prefb_ram_buf_addr;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			prefb1_addr_reg <= {US_AW{1'b0}};
		else if (prefb1_alloc_valid_set)
			prefb1_addr_reg <= prefb1_addr_nx;
	end

	assign prefb1_addr = prefb1_addr_reg;


	assign prefb0_data_valid_set = (~prefb0_data_valid & ram_data_phase_valid & ~fill_ptr & clk_en)
				     | prefb0_ret
				     ;
	assign prefb0_data_valid_clr = prefb_miss_clr;
	assign prefb0_data_valid_nx  = (prefb0_data_valid | prefb0_data_valid_set) & ~prefb0_data_valid_clr;
	assign prefb0_data_valid_en  = prefb0_data_valid_set | prefb0_data_valid_clr;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			prefb0_data_valid_reg <= 1'b0;
		else if (prefb0_data_valid_en)
			prefb0_data_valid_reg <= prefb0_data_valid_nx;
	end
	assign prefb0_data_valid = prefb0_data_valid_reg;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			prefb0_data_reg <= {RAM_BLOCKS_DW{1'b0}};
		else if (prefb0_data_valid_set)
			prefb0_data_reg <= prefb0_data_nx;
	end

	assign prefb0_data = prefb0_data_reg;

	assign prefb1_data_valid_set = (~prefb1_data_valid & ram_data_phase_valid & fill_ptr & clk_en)
				     | prefb1_ret
				     ;
	assign prefb1_data_valid_clr = prefb_miss_clr;
	assign prefb1_data_valid_nx  = (prefb1_data_valid | prefb1_data_valid_set) & ~prefb1_data_valid_clr;
	assign prefb1_data_valid_en  = prefb1_data_valid_set | prefb1_data_valid_clr;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			prefb1_data_valid_reg <= 1'b0;
		else if (prefb1_data_valid_en)
			prefb1_data_valid_reg <= prefb1_data_valid_nx;
	end

	assign prefb1_data_valid = prefb1_data_valid_reg;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			prefb1_data_reg <= {RAM_BLOCKS_DW{1'b0}};
		else if (prefb1_data_valid_set)
			prefb1_data_reg <= prefb1_data_nx;
	end

	assign prefb1_data = prefb1_data_reg;

	assign prefb0_ret = (clk_en & prefb_fill_full & ~alloc_ptr & req_buf_hit_prefb1)
			  | (clk_en & prefb_fill_full & req_buf_hit_data_phase)
			  ;
	assign prefb1_ret = (clk_en & prefb_fill_full & alloc_ptr & req_buf_hit_prefb0)
			  | (clk_en & prefb_fill_full & req_buf_hit_data_phase)
			  ;

	assign prefb_alloc_full = prefb0_alloc_valid & prefb1_alloc_valid;
	assign prefb_fill_full  = prefb0_data_valid & prefb1_data_valid;

	assign prefb_miss_clr = (clk_en & ram_rd_access_from_bus)
			      | (clk_en & ram_wr_access_from_bus)
			      ;

	assign alloc_ptr_update = prefb_miss_clr
				| (clk_en & ram_sel_prefb & ~prefb0_alloc_valid)
				| (clk_en & ram_sel_prefb & ~prefb1_alloc_valid)
				| (clk_en & ram_data_phase_valid & prefb_alloc_full & prefb0_ret)
				| (clk_en & ram_data_phase_valid & prefb_alloc_full & prefb1_ret)
				;

	assign alloc_ptr_nx     = prefb_miss_clr ? req_ram_buf_wr ? 1'b0 : 1'b1 : ~alloc_ptr;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			alloc_ptr <= 1'b0;
		else if (alloc_ptr_update)
			alloc_ptr <= alloc_ptr_nx;
	end
	assign fill_ptr_update = prefb_miss_clr
			       | (ram_data_phase_valid & ~ram_data_phase_wr & clk_en & ~prefb0_data_valid)
			       | (ram_data_phase_valid & ~ram_data_phase_wr & clk_en & ~prefb1_data_valid)
			       | (ram_data_phase_valid & ~ram_data_phase_wr & clk_en & prefb_fill_full & prefb0_ret)
			       | (ram_data_phase_valid & ~ram_data_phase_wr & clk_en & prefb_fill_full & prefb1_ret)
			       ;
	assign fill_ptr_nx     = prefb_miss_clr ? 1'b0 : ~fill_ptr;


	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			fill_ptr <= 1'b0;
		else if (fill_ptr_update)
			fill_ptr <= fill_ptr_nx;
	end


	assign prefb_ram_buf_valid_set = (ram_rd_access_from_bus & clk_en)
				       | (ram_sel_prefb & ~prefb_alloc_full & clk_en)
				       | (prefb0_ret & ~prefb_miss_clr)
				       | (prefb1_ret & ~prefb_miss_clr)
				       ;
	assign prefb_ram_buf_valid_clr = clk_en | prefb_miss_clr;
	assign prefb_ram_buf_valid_nx  = (prefb_ram_buf_valid & ~prefb_ram_buf_valid_clr) | prefb_ram_buf_valid_set;
	assign prefb_ram_buf_valid_en  = prefb_ram_buf_valid_set | prefb_ram_buf_valid_clr;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			prefb_ram_buf_valid_reg <= 1'b0;
		else if (prefb_ram_buf_valid_en)
			prefb_ram_buf_valid_reg <= prefb_ram_buf_valid_nx;
	end
	assign prefb_ram_buf_valid = prefb_ram_buf_valid_reg;

	assign prefb_ram_buf_addr_nx = ((prefb0_ret|prefb1_ret) ? ram_data_phase_addr : ram_sel_prefb ? prefb_ram_buf_addr : req_ram_buf_addr)
				     + {{US_AW-BLOCK_ALSB-1{1'b0}}, 1'b1, {BLOCK_ALSB{1'b0}}};

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			prefb_ram_buf_addr_reg <= {US_AW{1'b0}};
		else if (prefb_ram_buf_valid_set)
			prefb_ram_buf_addr_reg <= prefb_ram_buf_addr_nx;
	end
	assign prefb_ram_buf_addr = prefb_ram_buf_addr_reg;
end
else begin : gen_prefetch_buffer_stub
	assign prefb0_alloc_valid	= 1'b0;
	assign prefb0_addr		= {US_AW{1'b0}};
	assign prefb0_data_valid	= 1'b0;
	assign prefb0_data		= {RAM_BLOCKS_DW{1'b0}};
	assign prefb1_alloc_valid	= 1'b0;
	assign prefb1_addr		= {US_AW{1'b0}};
	assign prefb1_data_valid	= 1'b0;
	assign prefb1_data		= {RAM_BLOCKS_DW{1'b0}};
	assign prefb0_ret		= 1'b0;
	assign prefb1_ret		= 1'b0;
	assign prefb_ram_buf_valid	= 1'b0;
	assign prefb_ram_buf_addr	= 1'b0;
	assign prefb_fill_full		= 1'b1;
end
endgenerate

assign d_valid_buf_valid_set = ((req_buf_hit | req_buf_wr_done | req_buf_denied) & ~d_ready & ~d_valid_buf_valid);
assign d_valid_buf_valid_clr = d_ready;
assign d_valid_buf_valid_nx  = (d_valid_buf_valid & ~d_valid_buf_valid_clr) | d_valid_buf_valid_set;
assign d_valid_buf_valid_en  = d_valid_buf_valid_set | d_valid_buf_valid_clr;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		d_valid_buf_valid <= 1'b0;
	else if (d_valid_buf_valid_en)
		d_valid_buf_valid <= d_valid_buf_valid_nx;
end

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		d_valid_buf_data	<= {US_DW{1'b0}};
		d_valid_buf_parity0	<= {EW{1'b0}};
		d_valid_buf_parity1	<= {EW{1'b0}};
		d_valid_buf_denied	<= 1'b0;
	end
	else if (d_valid_buf_valid_set) begin
		d_valid_buf_data	<= req_resp_data;
		d_valid_buf_parity0	<= req_resp_parity0;
		d_valid_buf_parity1	<= req_resp_parity1;
		d_valid_buf_denied	<= req_buf_denied;
	end
end
assign wr_done_wait_d_ready_set = d_valid_buf_valid & req_buf_wr & clk_en & req_ram_buf_valid & req_ram_buf_wr & ~req_ram_buf_denied;
assign wr_done_wait_d_ready_clr = ~d_valid_buf_valid;
assign wr_done_wait_d_ready_nx  = (wr_done_wait_d_ready | wr_done_wait_d_ready_set) & ~wr_done_wait_d_ready_clr;
assign wr_done_wait_d_ready_en  = wr_done_wait_d_ready_set | wr_done_wait_d_ready_clr;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		wr_done_wait_d_ready <= 1'b0;
	else if (wr_done_wait_d_ready_en)
		wr_done_wait_d_ready <= wr_done_wait_d_ready_nx;
end

assign req_buf_hit_prefb0 = prefb0_alloc_valid & prefb0_data_valid & (req_buf_addr[US_AW-1:BLOCK_ALSB] == prefb0_addr[US_AW-1:BLOCK_ALSB]) & req_buf_valid & ~req_buf_denied;
assign req_buf_hit_prefb1 = prefb1_alloc_valid & prefb1_data_valid & (req_buf_addr[US_AW-1:BLOCK_ALSB] == prefb1_addr[US_AW-1:BLOCK_ALSB]) & req_buf_valid & ~req_buf_denied;
assign req_buf_hit_data_phase = (ram_data_phase_valid  & (ram_data_phase_addr[US_AW-1:BLOCK_ALSB] == req_buf_addr[US_AW-1:BLOCK_ALSB]) & req_buf_valid & ~req_buf_denied & clk_en)
			      | (ram_data_phase_stable & (ram_data_phase_addr[US_AW-1:BLOCK_ALSB] == req_buf_addr[US_AW-1:BLOCK_ALSB]) & req_buf_valid & ~req_buf_denied)
      ;

assign req_buf_hit = (req_buf_hit_prefb0 & ~req_buf_wr)
		   | (req_buf_hit_prefb1 & ~req_buf_wr)
		   | (req_buf_hit_data_phase & ~req_buf_wr)
		   ;
assign req_buf_denied = (req_buf_valid & (req_buf_size != 3'd0) & (US_DW == 8))
		      | (req_buf_valid & (req_buf_size != 3'd1) & (US_DW == 16))
		      | (req_buf_valid & (req_buf_size != 3'd2) & (US_DW == 32))
		      | (req_buf_valid & (req_buf_size != 3'd3) & (US_DW == 64))
		      | (req_buf_valid & (req_buf_size != 3'd4) & (US_DW == 128))
		      | (req_buf_valid & (req_buf_size != 3'd5) & (US_DW == 256))
		      | (req_buf_valid & (req_buf_size != 3'd6) & (US_DW == 512))
		      | (req_buf_valid & (req_buf_size != 3'd7) & (US_DW == 1024))
		      ;

assign req_buf_wr_done = req_buf_wr & clk_en & req_ram_buf_valid & req_ram_buf_wr & ~req_ram_buf_denied | wr_done_wait_d_ready;

assign req_buf_valid_set = (a_valid & req_buf_hit & ~d_valid_buf_valid)
			 | (a_valid & req_buf_wr_done & ~d_valid_buf_valid)
			 | (a_valid & req_buf_denied & ~d_valid_buf_valid)
			 | (a_valid & ~req_buf_valid)
			 ;

assign req_buf_valid_clr = (req_buf_hit & ~d_valid_buf_valid)
			 | (req_buf_wr_done & ~d_valid_buf_valid)
			 | (req_buf_denied & ~d_valid_buf_valid)
			 ;
assign req_buf_valid_nx  = (~req_buf_valid_clr & req_buf_valid) | req_buf_valid_set;
assign req_buf_valid_en  = req_buf_valid_set | req_buf_valid_clr;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		req_buf_valid <= 1'b0;
	else if (req_buf_valid_en)
		req_buf_valid <= req_buf_valid_nx;
end

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		req_buf_addr	<= {US_AW{1'b0}};
		req_buf_wr	<= 1'b0;
		req_buf_mask	<= {(US_DW/8){1'b0}};
		req_buf_data	<= {US_DW{1'b0}};
		req_buf_size	<= 3'b0;
		req_buf_parity0	<= {EW{1'b0}};
		req_buf_parity1	<= {EW{1'b0}};
	end
	else if (req_buf_valid_set) begin
		req_buf_addr	<= a_addr;
		req_buf_wr	<= ~a_opcode[2];
		req_buf_mask	<= a_mask;
		req_buf_data	<= a_data;
		req_buf_size	<= a_size;
		req_buf_parity0	<= a_parity0;
		req_buf_parity1	<= a_parity1;
	end
end

assign req_ram_buf_from_req_buf = (req_buf_valid & clk_en & ~req_buf_hit & ~req_buf_wr_done & ~req_buf_denied);
assign req_ram_buf_valid_set = req_ram_buf_from_req_buf		|
			       (a_valid & a_ready & clk_en)	;
assign req_ram_buf_valid_clr = clk_en;
assign req_ram_buf_valid_nx  = (req_ram_buf_valid & ~req_ram_buf_valid_clr) | req_ram_buf_valid_set;
assign req_ram_buf_valid_en  = req_ram_buf_valid_set | req_ram_buf_valid_clr;


always @(posedge clk or negedge resetn) begin
	if (!resetn)
		req_ram_buf_valid <= 1'b0;
	else if (req_ram_buf_valid_en)
		req_ram_buf_valid <= req_ram_buf_valid_nx;
end
assign req_ram_buf_addr_nx	= req_ram_buf_from_req_buf ? req_buf_addr	: a_addr;
assign req_ram_buf_wr_nx	= req_ram_buf_from_req_buf ? req_buf_wr		: ~a_opcode[2];
assign req_ram_buf_mask_nx	= req_ram_buf_from_req_buf ? req_buf_mask	: a_mask;
assign req_ram_buf_data_nx	= req_ram_buf_from_req_buf ? req_buf_data	: a_data;
assign req_ram_buf_size_nx	= req_ram_buf_from_req_buf ? req_buf_size	: a_size;
assign req_ram_buf_parity0_nx	= req_ram_buf_from_req_buf ? req_buf_parity0	: a_parity0;
assign req_ram_buf_parity1_nx	= req_ram_buf_from_req_buf ? req_buf_parity1	: a_parity1;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		req_ram_buf_addr	<= {US_AW{1'b0}};
		req_ram_buf_wr		<= 1'b0;
		req_ram_buf_mask	<= {(US_DW/8){1'b0}};
		req_ram_buf_data	<= {US_DW{1'b0}};
		req_ram_buf_size	<= 3'b0;
		req_ram_buf_parity0	<= {EW{1'b0}};
		req_ram_buf_parity1	<= {EW{1'b0}};
	end
	else if (req_ram_buf_valid_set) begin
		req_ram_buf_addr	<= req_ram_buf_addr_nx;
		req_ram_buf_wr		<= req_ram_buf_wr_nx;
		req_ram_buf_mask	<= req_ram_buf_mask_nx;
		req_ram_buf_data	<= req_ram_buf_data_nx;
		req_ram_buf_size	<= req_ram_buf_size_nx;
		req_ram_buf_parity0	<= req_ram_buf_parity0_nx;
		req_ram_buf_parity1	<= req_ram_buf_parity1_nx;

	end
end

assign req_ram_buf_denied = (req_ram_buf_valid & (req_ram_buf_size != 3'd0) & (US_DW == 8))
		          | (req_ram_buf_valid & (req_ram_buf_size != 3'd1) & (US_DW == 16))
		          | (req_ram_buf_valid & (req_ram_buf_size != 3'd2) & (US_DW == 32))
		          | (req_ram_buf_valid & (req_ram_buf_size != 3'd3) & (US_DW == 64))
		          | (req_ram_buf_valid & (req_ram_buf_size != 3'd4) & (US_DW == 128))
		          | (req_ram_buf_valid & (req_ram_buf_size != 3'd5) & (US_DW == 256))
		          | (req_ram_buf_valid & (req_ram_buf_size != 3'd6) & (US_DW == 512))
		          | (req_ram_buf_valid & (req_ram_buf_size != 3'd7) & (US_DW == 1024))
		          ;

assign req_ram_buf_wr_acc = req_ram_buf_wr & req_ram_buf_valid;

assign req_ram_buf_is_prefb_ram_buf = prefb_ram_buf_valid & (req_ram_buf_addr[US_AW-1:BLOCK_ALSB] == prefb_ram_buf_addr[US_AW-1:BLOCK_ALSB]);
assign req_ram_buf_hit_prefb0       = prefb0_alloc_valid & (req_ram_buf_addr[US_AW-1:BLOCK_ALSB] == prefb0_addr[US_AW-1:BLOCK_ALSB]);
assign req_ram_buf_hit_prefb1       = prefb1_alloc_valid & (req_ram_buf_addr[US_AW-1:BLOCK_ALSB] == prefb1_addr[US_AW-1:BLOCK_ALSB]);
assign req_ram_buf_hit_dphase       = ram_data_phase_valid & (req_ram_buf_addr[US_AW-1:BLOCK_ALSB] == ram_data_phase_addr[US_AW-1:BLOCK_ALSB]);

assign ram_sel_prefb = (~req_ram_buf_wr_acc & prefb_ram_buf_valid & req_ram_buf_is_prefb_ram_buf)
		     | (~req_ram_buf_wr_acc & prefb_ram_buf_valid & req_ram_buf_hit_prefb0)
		     | (~req_ram_buf_wr_acc & prefb_ram_buf_valid & req_ram_buf_hit_prefb1)
		     | (~req_ram_buf_wr_acc & prefb_ram_buf_valid & req_ram_buf_hit_dphase)
		     | (prefb_ram_buf_valid & req_ram_buf_denied)
		     ;
assign ram_rd_access_from_bus = req_ram_buf_valid & ~req_ram_buf_wr_acc & ~req_ram_buf_is_prefb_ram_buf & ~req_ram_buf_hit_prefb0 & ~req_ram_buf_hit_prefb1 & ~req_ram_buf_hit_dphase & ~req_ram_buf_denied;
assign ram_wr_access_from_bus = req_ram_buf_valid & req_ram_buf_wr_acc & ~req_ram_buf_denied;

assign ram_cs = (prefb_ram_buf_valid & ram_sel_prefb)
	      | ram_rd_access_from_bus
	      | ram_wr_access_from_bus
	      ;
assign ram_we   = req_ram_buf_wr_acc & ~req_ram_buf_denied;
assign ram_addr = ram_sel_prefb ? prefb_ram_buf_addr[US_AW-1:BLOCK_ALSB] : req_ram_buf_addr[US_AW-1:BLOCK_ALSB];

generate
if ((RAM_BLOCKS/BUS_BLOCKS) == 1) begin : gen_oen_bus_width_ram_info
	assign ram_mask	 = req_ram_buf_wr_acc ? req_ram_buf_mask : {RAM_DW/8{1'b0}};
	assign ram_wdata = req_ram_buf_data;
end
else  begin : gen_two_bus_width_ram_info
	wire			block_select = req_ram_buf_addr[BLOCK_ALSB-1];
	wire	[RAM_DW/8-1:0]	ram_wr_mask;

	assign ram_wr_mask = block_select ? {req_ram_buf_mask, {(US_DW/8){1'b0}}} :
					    {{(US_DW/8){1'b0}}, req_ram_buf_mask} ;
	assign ram_mask  = req_ram_buf_wr_acc ? ram_wr_mask : {RAM_DW/8{1'b0}};
	assign ram_wdata = block_select ? {req_ram_buf_data, {US_DW{1'b0}}} :
					  {{US_DW{1'b0}}, req_ram_buf_data} ;
end
endgenerate

generate
if ((RAM_BLOCKS == 1) && (ECC_SUPPORT == 1)) begin : gen_1_ram_block_ecc_ram_if
	assign ram0_bwe   = {ram_mask[BLOCK_BW-1], ram_mask};
	assign ram0_we    = ram_we;
	assign ram0_cs    = ram_we ? ram_cs & (|ram0_bwe) : ram_cs;
	assign ram0_addr  = ram_addr;
	assign ram0_wdata = {req_ram_buf_parity0, ram_wdata};

	assign ram1_bwe   = {RAM_BLOCK_BWE{1'b0}};
	assign ram1_we    = 1'b0;
	assign ram1_cs    = 1'b0;
	assign ram1_addr  = {RAM_BLOCK_AW{1'b0}};
	assign ram1_wdata = {RAM_BLOCK_DW{1'b0}};
end
else if ((RAM_BLOCKS == 1) && (ECC_SUPPORT == 0)) begin : gen_1_ram_block_ram_if
	assign ram0_bwe   = ram_mask;
	assign ram0_we    = ram_we;
	assign ram0_cs    = ram_we ? ram_cs & (|ram0_bwe) : ram_cs;
	assign ram0_addr  = ram_addr;
	assign ram0_wdata = ram_wdata;

	assign ram1_bwe   = {RAM_BLOCK_BWE{1'b0}};
	assign ram1_we    = 1'b0;
	assign ram1_cs    = 1'b0;
	assign ram1_addr  = {RAM_BLOCK_AW{1'b0}};
	assign ram1_wdata = {RAM_BLOCK_DW{1'b0}};
end
else if ((RAM_BLOCKS == 2) && (ECC_SUPPORT == 1)) begin : gen_2_ram_block_ecc_ram_if
	assign ram0_bwe   = {ram_mask[BLOCK_BW-1], ram_mask[BLOCK_BW-1:0]};
	assign ram0_we    = ram_we;
	assign ram0_cs    = ram_we ? ram_cs & (|ram0_bwe) : ram_cs;
	assign ram0_addr  = ram_addr;
	assign ram0_wdata = {req_ram_buf_parity0, ram_wdata[BLOCK_DW-1:0]};

	assign ram1_bwe   = {ram_mask[BLOCK_BW*2-1], ram_mask[BLOCK_BW*2-1:BLOCK_BW]};
	assign ram1_we    = ram_we;
	assign ram1_cs    = ram_we ? ram_cs & (|ram1_bwe) : ram_cs;
	assign ram1_addr  = ram_addr;
	assign ram1_wdata = (BUS_BLOCKS == 1) ? {req_ram_buf_parity0, ram_wdata[BLOCK_DW*2-1:BLOCK_DW]} :
					        {req_ram_buf_parity1, ram_wdata[BLOCK_DW*2-1:BLOCK_DW]} ;
end
else  begin : gen_2_ram_block_ram_if
	assign ram0_bwe   = ram_mask[BLOCK_BW-1:0];
	assign ram0_we    = ram_we;
	assign ram0_cs    = ram_we ? ram_cs & (|ram0_bwe) : ram_cs;
	assign ram0_addr  = ram_addr;
	assign ram0_wdata = ram_wdata[BLOCK_DW-1:0];

	assign ram1_bwe   = ram_mask[BLOCK_BW*2-1:BLOCK_BW];
	assign ram1_we    = ram_we;
	assign ram1_cs    = ram_we ? ram_cs & (|ram1_bwe) : ram_cs;
	assign ram1_addr  = ram_addr;
	assign ram1_wdata = ram_wdata[BLOCK_DW*2-1:BLOCK_DW];
end
endgenerate



assign ram_data_phase_stable_set = ram_data_phase_valid & clk_en;
assign ram_data_phase_stable_clr = (~prefb_fill_full & clk_en)
				 | (clk_en & prefb0_ret)
				 | (clk_en & prefb1_ret)
				 | (clk_en & ram_cs)
				 ;
assign ram_data_phase_stable_nx  = (ram_data_phase_stable | ram_data_phase_stable_set) & ~ram_data_phase_stable_clr;
assign ram_data_phase_stable_en  = ram_data_phase_stable_set | ram_data_phase_stable_clr;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		ram_data_phase_stable <= 1'b0;
	else if (ram_data_phase_stable_en)
		ram_data_phase_stable <= ram_data_phase_stable_nx;
end




assign ram_data_phase_valid_set = ram_cs & ~ram_we & clk_en;
assign ram_data_phase_valid_clr = (clk_en & ~prefb_fill_full)
				| (clk_en & prefb0_ret)
				| (clk_en & prefb1_ret)
				| (clk_en & ram_cs)
				;
assign ram_data_phase_valid_nx  = (ram_data_phase_valid & ~ram_data_phase_valid_clr) | ram_data_phase_valid_set;
assign ram_data_phase_valid_en  = ram_data_phase_valid_set | ram_data_phase_valid_clr;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		ram_data_phase_valid <= 1'b0;
	else if (ram_data_phase_valid_en)
		ram_data_phase_valid <= ram_data_phase_valid_nx;
end
always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		ram_data_phase_addr	<= {US_AW{1'b0}};
		ram_data_phase_wr	<= 1'b0;
	end
	else if (ram_data_phase_valid_set) begin
		ram_data_phase_addr	<= ram_data_phase_addr_nx;
		ram_data_phase_wr	<= req_ram_buf_wr_acc;
	end
end
assign ram_data_phase_addr_nx = ram_sel_prefb ? prefb_ram_buf_addr : req_ram_buf_addr;

assign a_ready = req_buf_valid_clr | ~req_buf_valid;

generate
if ((RAM_BLOCKS == 1) && (ECC_SUPPORT == 1)) begin : gen_1_ecc_ram_block_resp
	assign req_resp_data = req_buf_hit_data_phase ? ram0_rdata[US_DW-1:0]  :
			       req_buf_hit_prefb0     ? prefb0_data[US_DW-1:0] :
							prefb1_data[US_DW-1:0] ;
	assign req_resp_parity0 = req_buf_hit_data_phase ? ram0_rdata[RAM_BLOCK_DW-1:RAM_BLOCK_DW-EW]	:
				  req_buf_hit_prefb0     ? prefb0_data[US_DW+EW-1:US_DW]		:
							   prefb1_data[US_DW+EW-1:US_DW]		;
	assign req_resp_parity1 = {EW{1'b0}};
end
else if ((RAM_BLOCKS == 1) && (ECC_SUPPORT == 0)) begin : gen_1_ram_block_resp
	assign req_resp_data = req_buf_hit_data_phase ? ram0_rdata[US_DW-1:0]  :
			       req_buf_hit_prefb0     ? prefb0_data[US_DW-1:0] :
							prefb1_data[US_DW-1:0] ;
	assign req_resp_parity0 = {EW{1'b0}};
	assign req_resp_parity1 = {EW{1'b0}};
end
else if ((RAM_BLOCKS == 2) && (ECC_SUPPORT == 1) && (BUS_BLOCKS == 1)) begin : gen_2_ecc_ram_block_1bus_block_resp
	wire	[US_DW-1:0]	ram_hit_data;
	wire	[US_DW-1:0]	prefb0_hit_data;
	wire	[US_DW-1:0]	prefb1_hit_data;

	wire	[EW-1:0]	ram_hit_parity0;
	wire	[EW-1:0]	prefb0_hit_parity0;
	wire	[EW-1:0]	prefb1_hit_parity0;

	assign ram_hit_data    = req_buf_addr[BLOCK_ALSB-1] ? ram1_rdata[US_DW-1:0] : ram0_rdata[US_DW-1:0];
	assign prefb0_hit_data = req_buf_addr[BLOCK_ALSB-1] ? prefb0_data[US_DW*2+EW-1:US_DW+EW] : prefb0_data[US_DW-1:0];
	assign prefb1_hit_data = req_buf_addr[BLOCK_ALSB-1] ? prefb1_data[US_DW*2+EW-1:US_DW+EW] : prefb1_data[US_DW-1:0];
	assign req_resp_data = req_buf_hit_data_phase ? ram_hit_data[US_DW-1:0]  :
			       req_buf_hit_prefb0     ? prefb0_hit_data[US_DW-1:0] :
							prefb1_hit_data[US_DW-1:0] ;

	assign ram_hit_parity0 = req_buf_addr[BLOCK_ALSB-1] ? ram1_rdata[RAM_BLOCK_DW-1:RAM_BLOCK_DW-EW] :
						              ram0_rdata[RAM_BLOCK_DW-1:RAM_BLOCK_DW-EW] ;

	assign prefb0_hit_parity0 = req_buf_addr[BLOCK_ALSB-1] ? prefb0_data[RAM_BLOCKS_DW-1:RAM_BLOCKS_DW-EW] :
								 prefb0_data[US_DW+EW-1:US_DW];

	assign prefb1_hit_parity0 = req_buf_addr[BLOCK_ALSB-1] ? prefb1_data[RAM_BLOCKS_DW-1:RAM_BLOCKS_DW-EW] :
								 prefb1_data[US_DW+EW-1:US_DW];

	assign req_resp_parity0 = req_buf_hit_data_phase ? ram_hit_parity0    :
				  req_buf_hit_prefb0	 ? prefb0_hit_parity0 :
							   prefb1_hit_parity0 ;
	assign req_resp_parity1 = {EW{1'b0}};
end
else if ((RAM_BLOCKS == 2) && (ECC_SUPPORT == 0) && (BUS_BLOCKS == 1)) begin : gen_2_ram_block_1bus_block_resp
	wire	[US_DW-1:0]	ram_hit_data;
	wire	[US_DW-1:0]	prefb0_hit_data;
	wire	[US_DW-1:0]	prefb1_hit_data;

	assign ram_hit_data    = req_buf_addr[BLOCK_ALSB-1] ? ram1_rdata[US_DW-1:0] : ram0_rdata[US_DW-1:0];
	assign prefb0_hit_data = req_buf_addr[BLOCK_ALSB-1] ? prefb0_data[US_DW*2-1:US_DW] : prefb0_data[US_DW-1:0];
	assign prefb1_hit_data = req_buf_addr[BLOCK_ALSB-1] ? prefb1_data[US_DW*2-1:US_DW] : prefb1_data[US_DW-1:0];
	assign req_resp_data = req_buf_hit_data_phase ? ram_hit_data[US_DW-1:0]  :
			       req_buf_hit_prefb0     ? prefb0_hit_data[US_DW-1:0] :
							prefb1_hit_data[US_DW-1:0] ;

	assign req_resp_parity0 = {EW{1'b0}};
	assign req_resp_parity1 = {EW{1'b0}};
end
else if ((RAM_BLOCKS == 2) && (ECC_SUPPORT == 1) && (BUS_BLOCKS == 2)) begin : gen_2_ecc_ram_block_2bus_block_resp
	wire	[US_DW-1:0]	ram_hit_data;
	wire	[US_DW-1:0]	prefb0_hit_data;
	wire	[US_DW-1:0]	prefb1_hit_data;

	wire	[EW-1:0]	ram_hit_parity0;
	wire	[EW-1:0]	prefb0_hit_parity0;
	wire	[EW-1:0]	prefb1_hit_parity0;

	wire	[EW-1:0]	ram_hit_parity1;
	wire	[EW-1:0]	prefb0_hit_parity1;
	wire	[EW-1:0]	prefb1_hit_parity1;

	assign ram_hit_data    = {ram1_rdata[RAM_BLOCK_DW-EW-1:0] , ram0_rdata[RAM_BLOCK_DW-EW-1:0]};
	assign prefb0_hit_data = {prefb0_data[US_DW+EW-1:US_DW/2+EW], prefb0_data[US_DW/2-1:0]};
	assign prefb1_hit_data = {prefb1_data[US_DW+EW-1:US_DW/2+EW], prefb1_data[US_DW/2-1:0]};
	assign req_resp_data = req_buf_hit_data_phase ? ram_hit_data[US_DW-1:0]  :
			       req_buf_hit_prefb0     ? prefb0_hit_data[US_DW-1:0] :
							prefb1_hit_data[US_DW-1:0] ;

	assign ram_hit_parity0 = ram0_rdata[RAM_BLOCK_DW-1:RAM_BLOCK_DW-EW] ;
	assign ram_hit_parity1 = ram1_rdata[RAM_BLOCK_DW-1:RAM_BLOCK_DW-EW] ;

	assign prefb0_hit_parity0 = prefb0_data[US_DW/2+EW-1:US_DW/2];
	assign prefb1_hit_parity0 = prefb1_data[US_DW/2+EW-1:US_DW/2];

	assign prefb0_hit_parity1 = prefb0_data[US_DW+EW*2-1:US_DW+EW];
	assign prefb1_hit_parity1 = prefb1_data[US_DW+EW*2-1:US_DW+EW];

	assign req_resp_parity0 = req_buf_hit_data_phase ? ram_hit_parity0    :
				  req_buf_hit_prefb0	 ? prefb0_hit_parity0 :
							   prefb1_hit_parity0 ;

	assign req_resp_parity1 = req_buf_hit_data_phase ? ram_hit_parity1    :
				  req_buf_hit_prefb0	 ? prefb0_hit_parity1 :
							   prefb1_hit_parity1 ;
end
else  begin : gen_2_ram_block_2bus_block_resp
	wire	[US_DW-1:0]	ram_hit_data;
	wire	[US_DW-1:0]	prefb0_hit_data;
	wire	[US_DW-1:0]	prefb1_hit_data;

	assign ram_hit_data    = {ram1_rdata[RAM_BLOCK_DW-1:0], ram0_rdata[RAM_BLOCK_DW-1:0]};
	assign prefb0_hit_data = {prefb0_data[US_DW-1:US_DW/2], prefb0_data[US_DW/2-1:0]};
	assign prefb1_hit_data = {prefb1_data[US_DW-1:US_DW/2], prefb1_data[US_DW/2-1:0]};
	assign req_resp_data = req_buf_hit_data_phase ? ram_hit_data[US_DW-1:0]  :
			       req_buf_hit_prefb0     ? prefb0_hit_data[US_DW-1:0] :
							prefb1_hit_data[US_DW-1:0] ;
	assign req_resp_parity0 = {EW{1'b0}};
	assign req_resp_parity1 = {EW{1'b0}};
end
endgenerate

assign d_valid   = d_valid_buf_valid | req_buf_hit | req_buf_wr_done | req_buf_denied;
assign d_data    = d_valid_buf_valid ? d_valid_buf_data : req_resp_data;
assign d_parity0 = d_valid_buf_valid ? d_valid_buf_parity0 : req_resp_parity0;
assign d_parity1 = d_valid_buf_valid ? d_valid_buf_parity1 : req_resp_parity1;
assign d_denied  = d_valid_buf_valid ? d_valid_buf_denied : req_buf_denied;

endmodule

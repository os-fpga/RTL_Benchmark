// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module atcexmon300_ent (
	aclk,
	reset_n,
	norm_clr,
	exok_clr,
	set,
	dec_err,
	exclusive_rdata,
	exclusive_wdata,
	match_exclusive,
	ent_id,
	ent_valid
);

parameter ADDR_WIDTH  = 32;
parameter FIFO_WIDTH  = 4;
parameter SIZE_WIDTH  = 3;
parameter LEN_WIDTH   = 8;
parameter CACHE_WIDTH = 4;
parameter QOS_WIDTH   = 4;
parameter REGION_WIDTH= 4;
parameter PROT_WIDTH  = 3;
parameter ID_WIDTH    = 8;
parameter BURST_WIDTH = 2;
parameter DATA_WIDTH  = 64;

input			aclk;
input			reset_n;
input			norm_clr;
input			exok_clr;
input			set;
input			dec_err;
input  [FIFO_WIDTH-1:0] exclusive_rdata;
input  [FIFO_WIDTH-1:0]	exclusive_wdata;
output			match_exclusive;
output   [ID_WIDTH-1:0] ent_id;
output			ent_valid;

wire			ent_arlock;
wire			ent_awlock;
wire    [LEN_WIDTH-1:0] ent_arlen;
wire    [LEN_WIDTH-1:0] ent_awlen;
wire  [CACHE_WIDTH-1:0] ent_arcache;
wire  [CACHE_WIDTH-1:0] ent_awcache;
wire   [PROT_WIDTH-1:0] ent_arprot;
wire   [PROT_WIDTH-1:0] ent_awprot;
wire     [ID_WIDTH-1:0] ent_arid;
wire     [ID_WIDTH-1:0] ent_awid;
wire   [ADDR_WIDTH-1:0] ent_araddr;
wire   [ADDR_WIDTH-1:0] ent_awaddr;
wire   [SIZE_WIDTH-1:0] ent_arsize;
wire   [SIZE_WIDTH-1:0] ent_awsize;
wire  [BURST_WIDTH-1:0] ent_arburst;
wire  [BURST_WIDTH-1:0] ent_awburst;
wire    [QOS_WIDTH-1:0] ent_arqos;
wire    [QOS_WIDTH-1:0] ent_awqos;
wire [REGION_WIDTH-1:0] ent_arregion;
wire [REGION_WIDTH-1:0] ent_awregion;

reg    [FIFO_WIDTH-1:0] ent_exclusive_data;
reg			ent_valid;

wire			ent_valid_nx;
wire			ent_valid_set;
wire		 	ent_valid_clr;
wire		 	ent_valid_en;
wire			ent_exclusive_data_en;

reg			norm_clr_en;
reg   [ADDR_WIDTH-13:0] ent_awaddr_reg;

wire             [12:0] burst_inc_start;
wire             [12:0] ent_araddr_start;
wire             [11:0] addr_wrap_mask;
wire		 [12:0] burst_wrap_star;
wire   		 [12:0] burst_wrap_end;
wire             [12:0] burst_star_nx;
reg              [12:0] burst_star;
wire             [12:0] burst_end_nx;
reg              [12:0] burst_end;
wire             [12:0] burst_inc_end;
wire             [12:0] ent_araddr_end;
wire             [12:0] burst_addr_end;
wire		 [12:0] burst_block;
wire 		 [11:0] burst_len;
wire 		 [12:0] burst_inc_len;
wire 		 [11:0] burst_wrap_len;
wire 		 [11:0] burst_wrap_block;
wire 		 [11:0] burst_mask;
wire 		  [7:0] cmp_arsize;
wire 		  [7:0] mask_awsize;
wire 	       	        burst_overlap;

atcexmon300_bin2size  #(.N(8))  u_ar_bin2size (.out(cmp_arsize),  .in(ent_arsize));
atcexmon300_bin2mask  #(.N(8))  u_aw_bin2mask (.out(mask_awsize), .in(ent_awsize));

assign ent_araddr_start = {1'b0, ent_araddr[11:0]};
assign ent_araddr_end	= {1'b0, ent_araddr[11:0]} + {5'b0,{(cmp_arsize - 8'b1)}};
assign burst_len	= ({{(12-LEN_WIDTH){1'b0}}, ent_awlen}) + 12'h001;

assign burst_inc_len	= ent_awburst[0] ? ({1'b0, burst_len}) : 13'b1;
assign burst_block	= burst_inc_len << ent_awsize;
assign burst_addr_end	= ({1'b0, ent_awaddr[11:0]}) + burst_block;

assign burst_inc_start  = {1'b0, ent_awaddr[11:0]};
assign burst_inc_end	= (burst_addr_end & ({5'h1f, mask_awsize})) - 13'b1;

assign burst_wrap_len	= burst_len;
assign burst_wrap_block	= burst_wrap_len << ent_awsize;
assign burst_mask	= (burst_wrap_block - 12'b1);
assign addr_wrap_mask	= ~burst_mask;

assign burst_wrap_star  = {1'b0, (ent_awaddr[11:0] &  addr_wrap_mask)};
assign burst_wrap_end   = {1'b0, (ent_awaddr[11:0] | ~addr_wrap_mask)};

assign burst_star_nx = ({13{~ent_awburst[1]}} & burst_inc_start)
		     | ({13{ ent_awburst[1]}} & burst_wrap_star)
		     ;
assign burst_end_nx  = ({13{~ent_awburst[1]}} & burst_inc_end)
		     | ({13{ ent_awburst[1]}} & burst_wrap_end)
		     ;
assign burst_overlap = (burst_star       <= ent_araddr_end)
		     & (ent_araddr_start <= burst_end)
		     & (ent_awaddr_reg   == ent_araddr[ADDR_WIDTH-1:12])
		     ;

always @(posedge aclk or negedge reset_n) begin
        if (!reset_n) begin
		norm_clr_en      <= 1'b0;
		burst_star	 <= 13'b0;
		burst_end	 <= 13'b0;
		ent_awaddr_reg	 <= {(ADDR_WIDTH-12){1'b0}};
	end
	else begin
		norm_clr_en      <= norm_clr;
		burst_star       <= burst_star_nx;
		burst_end	 <= burst_end_nx;
		ent_awaddr_reg	 <= ent_awaddr[ADDR_WIDTH-1:12];
	end
end

assign ent_id = ent_arid;
assign {ent_arlock, ent_arid, ent_araddr, ent_arsize, ent_arburst, ent_arlen, ent_arcache, ent_arprot, ent_arqos, ent_arregion}  = ent_exclusive_data;
assign {ent_awlock, ent_awid, ent_awaddr, ent_awsize, ent_awburst, ent_awlen, ent_awcache, ent_awprot, ent_awqos, ent_awregion}  = exclusive_wdata;
assign match_exclusive =  ent_valid
		       & (ent_araddr   == ent_awaddr)
		       & (ent_arid     == ent_awid)
		       & (ent_arsize   == ent_awsize)
		       & (ent_arlen    == ent_awlen)
		       & (ent_arcache  == ent_awcache)
		       & (ent_arprot   == ent_awprot)
		       & (ent_arburst  == ent_awburst)
		       & (ent_arregion == ent_awregion)
		       & ~(|ent_awlen)
		       ;

assign ent_valid_set = set;
assign ent_valid_clr = burst_overlap & exok_clr
		     | burst_overlap & norm_clr_en
		     | dec_err
		     ;
assign ent_valid_nx  = ent_valid_set | ~ent_valid_clr;
assign ent_valid_en  = ent_valid_set | ent_valid_clr;

always @(posedge aclk or negedge reset_n) begin
        if (!reset_n)
		ent_valid <= 1'b0;
	else if (ent_valid_en)
		ent_valid <= ent_valid_nx;
end

assign ent_exclusive_data_en = ent_valid_set;
always @(posedge aclk or negedge reset_n) begin
        if (!reset_n)
		ent_exclusive_data <= {(FIFO_WIDTH){1'b0}};
	else if (ent_exclusive_data_en)
		ent_exclusive_data <= exclusive_rdata;
end
endmodule


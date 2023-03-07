// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module atcrambrg300(
       	  awid,
       	  awaddr,
       	  awlen,
       	  awsize,
       	  awburst,
       	  awlock,
       	  awvalid,
       	  awready,
       	  wdata,
       	  wstrb,
       	  wvalid,
       	  wready,
       	  bid,
       	  bresp,
       	  bvalid,
       	  bready,
       	  arid,
       	  araddr,
       	  arlen,
       	  arsize,
       	  arburst,
       	  arlock,
       	  arvalid,
       	  arready,
       	  rid,
       	  rdata,
       	  rresp,
       	  rlast,
       	  rvalid,
       	  rready,
       	  mem_addr,
       	  mem_web,
       	  mem_csb,
       	  mem_din,
       	  mem_dout,
       	  aclk,
       	  aresetn
);
parameter  ID_WIDTH        = 4;
parameter  DATA_WIDTH      = 32;
parameter  ADDR_WIDTH      = 20;
parameter  MEM_SIZE_KB     = (1 << (ADDR_WIDTH-10));
parameter  OOR_ERR_EN      = 1;

localparam PRODUCT_ID      = 32'h000B3003;

localparam DATA_SIZE       = $clog2(DATA_WIDTH/8);
localparam WSTRB_WIDTH     = DATA_WIDTH/8;
localparam ID_MSB          = ID_WIDTH-1;
localparam DATA_MSB        = DATA_WIDTH-1;
localparam WSTRB_MSB       = WSTRB_WIDTH-1;
localparam MEM_ADDR_LSB    = $clog2(DATA_WIDTH/8);
localparam MEM_ADDR_MSB    = $clog2(MEM_SIZE_KB) - 1 + 10;
localparam MEM_ADDR_WIDTH  = MEM_ADDR_MSB - MEM_ADDR_LSB + 1;

localparam RDATA_WIDTH     = ID_WIDTH+1+2+DATA_WIDTH;
localparam RDATA_RDATA_LSB = 0;
localparam RDATA_RDATA_MSB = DATA_WIDTH-1;
localparam RDATA_RRESP_LSB = RDATA_RDATA_MSB+1;
localparam RDATA_RRESP_MSB = RDATA_RRESP_LSB+1;
localparam RDATA_RLAST     = RDATA_RRESP_MSB+1;
localparam RDATA_RID_LSB   = RDATA_RLAST+1;
localparam RDATA_RID_MSB   = RDATA_RID_LSB+ID_MSB;

localparam WRESP_WIDTH     = ID_WIDTH+2;
localparam WRESP_DATA_LSB  = 0;
localparam WRESP_DATA_MSB  = WRESP_DATA_LSB+1;
localparam WRESP_BID_LSB   = WRESP_DATA_MSB+1;
localparam WRESP_BID_MSB   = WRESP_BID_LSB+ID_MSB;

localparam BURST_FIXED     = 2'b00;
localparam BURST_WRAP      = 2'b10;
localparam SLVERR          = 2'b10;

localparam S_RW_ADDR_DATA_READY     = 2'h0;
localparam S_PREF_WDATA             = 2'h1;
localparam S_PEND_AWADDR            = 2'h2;
localparam S_PEND_AWADDR_PREF_WDATA = 2'h3;

input         [ID_WIDTH-1:0] awid;
input       [ADDR_WIDTH-1:0] awaddr;
input                  [7:0] awlen;
input                  [2:0] awsize;
input                  [1:0] awburst;
input                        awlock;
input                        awvalid;
output                       awready;

input       [DATA_WIDTH-1:0] wdata;
input   [(DATA_WIDTH/8)-1:0] wstrb;
input                        wvalid;
output                       wready;

output        [ID_WIDTH-1:0] bid;
output                 [1:0] bresp;
output                       bvalid;
input                        bready;

input         [ID_WIDTH-1:0] arid;
input       [ADDR_WIDTH-1:0] araddr;
input                  [7:0] arlen;
input                  [2:0] arsize;
input                  [1:0] arburst;
input                        arlock;
input                        arvalid;
output                       arready;

output        [ID_WIDTH-1:0] rid;
output      [DATA_WIDTH-1:0] rdata;
output                 [1:0] rresp;
output                       rlast;
output                       rvalid;
input                        rready;

output  [MEM_ADDR_WIDTH-1:0] mem_addr;
output  [(DATA_WIDTH/8)-1:0] mem_web;
output                       mem_csb;
output      [DATA_WIDTH-1:0] mem_din;
input       [DATA_WIDTH-1:0] mem_dout;

input                        aclk;
input                        aresetn;

reg                          rd_cmd_dp;
reg                          rd_dp_last;
wire                   [1:0] rresp_beat;
wire                         rdata_fifo_almost_empty;
wire                         rdata_fifo_almost_full;
wire                         rdata_fifo_full;
wire                         rdata_fifo_empty;
wire                         rdata_fifo_wr;
wire                         rdata_fifo_rd;
wire       [RDATA_WIDTH-1:0] rdata_fifo_wr_data;
wire       [RDATA_WIDTH-1:0] rdata_fifo_rd_data;
wire                         rd_cmd_ap;
wire                         rd_ap_last;

reg                          bready_d1;
reg                          bresp_stat_keep;
wire                         wr_cmd_ap;
wire                         bresp_fifo_almost_empty;
wire                         bresp_fifo_almost_full;
wire                         bresp_fifo_full;
wire                         bresp_fifo_empty;
wire                         bresp_fifo_wr;
wire      [(ID_WIDTH+2)-1:0] bresp_fifo_wr_data;
wire                         bresp_fifo_rd;
wire      [(ID_WIDTH+2)-1:0] bresp_fifo_rd_data;
wire                         bresp_fifo_ready;
wire                   [1:0] bresp_trans;
wire                         bresp_valid;
wire                         bresp_status;
wire                         bresp_stat_keep_nx;

reg                          wr_cmd;
reg                    [1:0] burst_type;
reg                    [2:0] burst_size;
reg                          burst_lock;
reg                          rd_exok_dp;
reg                    [3:0] burst_len;
reg                    [7:0] burst_cnt;
reg           [ID_WIDTH-1:0] burst_id_ap;
reg           [ID_WIDTH-1:0] burst_id_dp;
wire                   [7:0] new_cmd_len;
wire        [ADDR_WIDTH-1:0] next_burst_addr;
wire           [DATA_SIZE:0] burst_offset;
wire                   [7:0] burst_cnt_nx;
wire                   [1:0] burst_type_nx;
wire                   [2:0] burst_size_nx;
wire                         burst_lock_nx;
wire                   [3:0] burst_len_nx;
wire                         burst_end;
wire                         burst_addr_fixed;
wire          [ID_WIDTH-1:0] burst_id_nx;
wire                         wr_cmd_nx;

reg               [ID_MSB:0] pending_aid;
reg         [ADDR_WIDTH-1:0] pending_addr;
reg                    [7:0] pending_len;
reg                    [2:0] pending_size;
reg                          pending_lock;
reg                    [1:0] pending_burst;
wire                         pend_wr_cmd_sel;
wire              [ID_MSB:0] new_write_id;
wire        [ADDR_WIDTH-1:0] new_write_addr;
wire                   [7:0] new_write_len;
wire                   [2:0] new_write_size;
wire                         new_write_lock;
wire                   [1:0] new_write_burst;

reg            [WSTRB_MSB:0] wdata_buff_wstrb;
reg             [DATA_MSB:0] wdata_buff_wdata;

reg        [ADDR_WIDTH-1:0] issue_addr;
wire       [ADDR_WIDTH-1:0] issue_addr_nx;
wire                  [11:0] inc_addr;
wire                  [11:0] wrap_mask;
wire                  [11:0] incr_mask;
wire                  [11:0] burst_addr_mask;

reg                          mem_cs;
wire                         mem_cs_nx;
wire                         rd_cs_en;
wire                         wr_cs_en;
wire                         zero_wstrb;

reg                    [1:0] axi_cs;
reg                    [1:0] axi_ns;

reg                    [7:0] arlen_keep;
reg                          pend_rd_cmd;
wire                         pend_wr_cmd;
wire                         pend_rd_cmd_nx;
wire                   [7:0] arlen_keep_nx;
wire                         new_wcmd_rd;
wire                         new_rcmd_rd;
wire                         new_cmd_rd;

reg                          out_of_range_ap;
wire                         out_of_range_nx;

reg                          store_cond_ok;
reg           [ID_WIDTH-1:0] exclusive_id;
reg         [ADDR_WIDTH-1:0] exclusive_addr;
reg                    [2:0] exclusive_size;
reg                    [3:0] exclusive_len;
reg                    [1:0] exclusive_burst;
reg                          exclusive_lock_valid;
reg         [ADDR_WIDTH-1:0] exclusive_mask;
reg         [ADDR_WIDTH-1:0] write_addr_check_mask;
wire        [ADDR_WIDTH-1:0] exclusive_mask_nx;
wire        [ADDR_WIDTH-1:0] write_addr_check_mask_nx;
wire                  [11:0] exclusive_wrap_mask;
wire                  [11:0] write_addr_check_mask_lsb;
wire                  [11:0] write_addr_check_mask_a1;
wire                  [11:0] lock_mask_a1;
wire                         exclusive_lock_valid_nx;
wire                         write_hit_exclusive_addr;
wire                         store_cond_ok_nx;
wire                         store_cond_fail;

assign bresp_fifo_ready   =   bresp_fifo_empty | bready_d1;
assign wr_cmd_nx          =   new_cmd_rd  ? new_wcmd_rd : wr_cmd;
assign new_cmd_rd         =   new_wcmd_rd | new_rcmd_rd;
assign new_rcmd_rd        = ( arvalid & arready);
assign new_wcmd_rd        =   burst_end & bresp_fifo_ready & (
                                                               (axi_cs == S_PEND_AWADDR_PREF_WDATA)
                          | (~new_rcmd_rd &           wvalid & (axi_cs == S_PEND_AWADDR))
                          | (~new_rcmd_rd & awvalid & wvalid & (axi_cs == S_RW_ADDR_DATA_READY))
                          | (~new_rcmd_rd & awvalid &          (axi_cs == S_PREF_WDATA)));

assign pend_wr_cmd        =   (axi_cs == S_PEND_AWADDR_PREF_WDATA);
assign pend_rd_cmd_nx     =   (new_rcmd_rd | pend_rd_cmd) & ~mem_cs_nx;
assign arready            = ~(~rdata_fifo_empty | ~burst_end | pend_wr_cmd);
assign awready            =  ((burst_end & ((axi_cs == S_RW_ADDR_DATA_READY) | (axi_cs == S_PREF_WDATA))) & bresp_fifo_ready) ;
assign wready             =  ((burst_end & ((axi_cs == S_RW_ADDR_DATA_READY) | (axi_cs == S_PEND_AWADDR))) | (~burst_end & wr_cmd)) & bresp_fifo_ready;
assign arlen_keep_nx      =    new_rcmd_rd ? arlen : arlen_keep;

assign pend_wr_cmd_sel    =  (axi_cs == S_PEND_AWADDR_PREF_WDATA) | (axi_cs == S_PEND_AWADDR);
assign new_write_id       =   pend_wr_cmd_sel ? pending_aid   : awid;
assign new_write_addr     =   pend_wr_cmd_sel ? pending_addr  : awaddr[ADDR_WIDTH-1:0];
assign new_write_len      =   pend_wr_cmd_sel ? pending_len   : awlen;
assign new_write_size     =   pend_wr_cmd_sel ? pending_size  : awsize;
assign new_write_lock     =   pend_wr_cmd_sel ? pending_lock  : awlock;
assign new_write_burst    =   pend_wr_cmd_sel ? pending_burst : awburst;

assign wr_cmd_ap          =   mem_cs    &  wr_cmd;
assign rd_cmd_ap          =   mem_cs    & ~wr_cmd;
assign rd_ap_last         =   rd_cmd_ap &  burst_end;

assign new_cmd_len        =   new_rcmd_rd ? arlen        :  new_write_len;
assign burst_cnt_nx       =   new_cmd_rd  ? new_cmd_len  :  pend_rd_cmd ? arlen_keep         :~burst_end   ? burst_cnt - 8'b1   : burst_cnt;
assign burst_id_nx        =   new_rcmd_rd ? arid         :  new_wcmd_rd ? new_write_id       : burst_id_ap;
assign burst_len_nx       =   new_rcmd_rd ? arlen[3:0]   :  new_wcmd_rd ? new_write_len[3:0] : burst_len;
assign burst_type_nx      =   new_rcmd_rd ? arburst      :  new_wcmd_rd ? new_write_burst    : burst_type;
assign burst_size_nx      =   new_rcmd_rd ? arsize       :  new_wcmd_rd ? new_write_size     : burst_size;
assign burst_lock_nx      =   new_rcmd_rd ? arlock       :  new_wcmd_rd ? new_write_lock     : burst_lock;
assign burst_end          =  (burst_cnt == 8'h0) & ~pend_rd_cmd;
assign burst_addr_fixed   = (~burst_end ? burst_type : new_rcmd_rd ? arburst : new_write_burst) == BURST_FIXED;
assign burst_offset       =   {{(DATA_SIZE){1'b0}},1'b1} << burst_size;
assign inc_addr           =   burst_addr_fixed ? 12'h0 : {{(12-(DATA_SIZE+1)){1'b0}}, burst_offset};
assign incr_mask          =   12'h0;
assign wrap_mask          =  {8'hff,~burst_len} << burst_size;
assign burst_addr_mask    =  (burst_type == BURST_WRAP) ? wrap_mask : incr_mask;
assign issue_addr_nx      =   new_rcmd_rd        ? araddr[ADDR_WIDTH-1:0] :
                              new_wcmd_rd        ? new_write_addr[ADDR_WIDTH-1:0] :
                              mem_cs             ? next_burst_addr :
                                                   issue_addr;
generate
	if (ADDR_WIDTH >= 13) begin : next_burst_addr_gen_0
		wire [11:0]		burst_addr_inc;
		assign burst_addr_inc                =  issue_addr[11:0]            +  inc_addr;
		assign next_burst_addr[11:0]         = (issue_addr[11:0]            &  burst_addr_mask)
                                                     | (burst_addr_inc              & ~burst_addr_mask);
		assign next_burst_addr[ADDR_WIDTH-1:12] =  issue_addr[ADDR_WIDTH-1:12];
	end
	else begin : next_burst_addr_gen_1
		wire [ADDR_WIDTH-1:0]	burst_addr_inc;
		assign burst_addr_inc                  =  issue_addr[ADDR_WIDTH-1:0]     +  inc_addr[ADDR_WIDTH-1:0];
		assign next_burst_addr[ADDR_WIDTH-1:0] = (issue_addr[ADDR_WIDTH-1:0]     &  burst_addr_mask[ADDR_WIDTH-1:0])
                                                       | (burst_addr_inc[ADDR_WIDTH-1:0] & ~burst_addr_mask[ADDR_WIDTH-1:0]);
	end
endgenerate

generate
	if (ADDR_WIDTH >= 11) begin : out_of_range_check_0
		assign out_of_range_nx = mem_cs_nx & ({1'b0, issue_addr_nx[ADDR_WIDTH-1:10]} >= MEM_SIZE_KB[ADDR_WIDTH-10:0]);
	end
	else begin : out_of_range_check_1
		assign out_of_range_nx = 1'b0;
	end
endgenerate

assign rd_cs_en           =  (new_rcmd_rd |  ~burst_end | pend_rd_cmd) & (rready | (rdata_fifo_empty & ~rd_cmd_dp));
assign wr_cs_en           =  (new_wcmd_rd | (~burst_end & wready & wvalid));
assign mem_cs_nx          =   wr_cmd_nx ?  wr_cs_en : rd_cs_en;
assign zero_wstrb         =   wr_cmd & mem_cs & (wdata_buff_wstrb == {WSTRB_WIDTH{1'b1}}) ;
assign mem_web            =   wr_cmd ? wdata_buff_wstrb : {WSTRB_WIDTH{1'b1}};
assign mem_addr           =   issue_addr[MEM_ADDR_MSB:MEM_ADDR_LSB];
assign mem_csb            =  ~mem_cs | out_of_range_ap | zero_wstrb | store_cond_fail;
assign mem_din            =   wdata_buff_wdata;

assign rdata_fifo_wr      = ~(rready & rdata_fifo_empty) & rd_cmd_dp;
assign rdata_fifo_wr_data =  {burst_id_dp, rd_dp_last, rresp_beat, mem_dout};
assign rdata_fifo_rd      =  ~rdata_fifo_empty & rready;
assign rvalid             =  ~rdata_fifo_empty | rd_cmd_dp;
assign rdata              =   rdata_fifo_empty ? mem_dout    : rdata_fifo_rd_data[RDATA_RDATA_MSB:RDATA_RDATA_LSB];
assign rlast              =   rdata_fifo_empty ? rd_dp_last  : rdata_fifo_rd_data[RDATA_RLAST];
assign rresp              =   rdata_fifo_empty ? rresp_beat  : rdata_fifo_rd_data[RDATA_RRESP_MSB:RDATA_RRESP_LSB];
assign rid                =   rdata_fifo_empty ? burst_id_dp : rdata_fifo_rd_data[RDATA_RID_MSB  :RDATA_RID_LSB];

assign bresp_valid        =   wr_cmd_ap & burst_end;
assign bresp_stat_keep_nx =  (bresp_status | bresp_stat_keep) & ~bresp_valid;
assign bresp_trans        =  (bresp_status | bresp_stat_keep) ? SLVERR : {1'b0, store_cond_ok};
assign bresp_fifo_wr_data =  {burst_id_ap,bresp_trans};
assign bresp_fifo_wr      = ~(bresp_fifo_empty & bready) & bresp_valid;
assign bresp_fifo_rd      =  ~bresp_fifo_empty & bready  & bvalid;
assign bvalid             =  ~bresp_fifo_empty | bresp_valid;
assign bresp              =   bresp_fifo_empty ? bresp_trans : bresp_fifo_rd_data[WRESP_DATA_MSB:WRESP_DATA_LSB];
assign bid                =   bresp_fifo_empty ? burst_id_ap : bresp_fifo_rd_data[WRESP_BID_MSB :WRESP_BID_LSB] ;

generate
	if (ADDR_WIDTH >= 13) begin : exclusive_mask_0
		assign exclusive_mask_nx[ADDR_WIDTH-1:12]        = {(ADDR_WIDTH-12){1'b1}};
		assign exclusive_mask_nx[11:0]                   =  exclusive_wrap_mask[11:0];
		assign write_addr_check_mask_nx[ADDR_WIDTH-1:12] = {(ADDR_WIDTH-12){1'b1}};
		assign write_addr_check_mask_nx[11:0]            =  write_addr_check_mask_lsb[11:0];
	end
	else begin : exclusive_mask_1
		assign exclusive_mask_nx[ADDR_WIDTH-1:0]         =  exclusive_wrap_mask[ADDR_WIDTH-1:0];
		assign write_addr_check_mask_nx[ADDR_WIDTH-1:0]  =  write_addr_check_mask_lsb[ADDR_WIDTH-1:0];
	end
endgenerate

assign lock_mask_a1                    =  {12'hfff} << exclusive_size;
assign write_addr_check_mask_a1        =  {12'hfff} << awsize;
assign write_addr_check_mask_lsb       = (exclusive_size >= awsize) ? lock_mask_a1 : write_addr_check_mask_a1;
assign exclusive_wrap_mask             =  {8'hff,((arburst == BURST_FIXED) ? 4'hf : (~arlen[3:0]))} << arsize;
assign write_hit_exclusive_addr        = ~store_cond_fail &  wr_cmd & mem_cs
                                       & (  ((exclusive_addr & exclusive_mask       ) == (issue_addr & exclusive_mask))
                                          | ((exclusive_addr & write_addr_check_mask) == (issue_addr & write_addr_check_mask)));


assign exclusive_lock_valid_nx         = (new_rcmd_rd & arlock & (~out_of_range_nx)) | (exclusive_lock_valid & ~write_hit_exclusive_addr);
assign store_cond_fail                 = (wr_cmd & burst_lock & ~store_cond_ok);
assign store_cond_ok_nx                = (store_cond_ok & ~burst_end)
                                       | (new_wcmd_rd & exclusive_lock_valid
                                       & (new_write_id    ==       exclusive_id)
                                       & (new_write_len   == {4'h0,exclusive_len})
                                       & (new_write_size  ==       exclusive_size)
                                       & (new_write_addr  ==       exclusive_addr)
                                       & (new_write_burst ==       exclusive_burst));

generate
	if (OOR_ERR_EN == 1) begin : out_of_range_enable

		reg    out_of_range_dp;
		assign rresp_beat   =  {out_of_range_dp, (rd_exok_dp & ~out_of_range_dp)};
		assign bresp_status =   wr_cmd_ap & out_of_range_ap;
		always @(posedge aclk or negedge aresetn)
			if (~aresetn)
				out_of_range_dp <= 1'b0;
			else
				out_of_range_dp <= out_of_range_ap;
	end
	else begin : out_of_range_disable
		assign rresp_beat   = {1'b0, rd_exok_dp};
		assign bresp_status = 1'b0;
	end
endgenerate

always @(*)
	case(axi_cs)
	S_PREF_WDATA:
		     if ( new_rcmd_rd & awvalid & awready)
			axi_ns = S_PEND_AWADDR_PREF_WDATA;
		else if (                     awvalid & awready & bresp_fifo_ready)
			axi_ns = S_RW_ADDR_DATA_READY;
		else
			axi_ns = S_PREF_WDATA;
	S_PEND_AWADDR_PREF_WDATA:
		if (burst_end & bresp_fifo_ready)
			axi_ns = S_RW_ADDR_DATA_READY;
		else
			axi_ns = S_PEND_AWADDR_PREF_WDATA;
	S_PEND_AWADDR:
		     if (wvalid & ~new_rcmd_rd & burst_end & bresp_fifo_ready)
			axi_ns = S_RW_ADDR_DATA_READY;
		else if (wvalid & burst_end & bresp_fifo_ready)
			axi_ns = S_PEND_AWADDR_PREF_WDATA;
		else
			axi_ns = S_PEND_AWADDR;
	default:
		     if ( awvalid & awready & wvalid & wready & (new_rcmd_rd | ~bresp_fifo_ready) )
			axi_ns = S_PEND_AWADDR_PREF_WDATA;
		else if ( awvalid & awready & (new_rcmd_rd | (~wvalid & wready)))
			axi_ns = S_PEND_AWADDR;
		else if (~awvalid & awready &                          wvalid & wready)
			axi_ns = S_PREF_WDATA;
		else
			axi_ns = S_RW_ADDR_DATA_READY;
	endcase

always @(posedge aclk or negedge aresetn)
	if (~aresetn)
		burst_cnt <= 8'h0;
	else if (mem_cs_nx | new_cmd_rd)
		burst_cnt <= burst_cnt_nx;

always @(posedge aclk or negedge aresetn)
      if (~aresetn) begin
		wdata_buff_wdata <= {DATA_WIDTH{1'b0}};
		wdata_buff_wstrb <= {WSTRB_WIDTH{1'b0}};
	end else if (wvalid & wready) begin
		wdata_buff_wdata <=  wdata;
		wdata_buff_wstrb <= ~wstrb;
	end

always @(posedge aclk or negedge aresetn)
	if (~aresetn)begin
		pending_aid   <= {(ID_MSB+1){1'b0}};
		pending_len   <=  8'h0;
		pending_addr  <= {(ADDR_WIDTH){1'b0}};
		pending_size  <=  3'h0;
		pending_lock  <=  1'h0;
		pending_burst <=  2'h0;
	end else if (awvalid & awready & ((axi_ns == S_PEND_AWADDR) | (axi_ns == S_PEND_AWADDR_PREF_WDATA))) begin
		pending_aid   <=  awid;
		pending_len   <=  awlen;
		pending_addr  <=  awaddr[ADDR_WIDTH-1:0];
		pending_size  <=  awsize;
		pending_lock  <=  awlock;
		pending_burst <=  awburst;
	end

always @(posedge aclk or negedge aresetn)
	if (~aresetn) begin
		axi_cs          <= S_RW_ADDR_DATA_READY;
		mem_cs          <= 1'b0;
		wr_cmd          <= 1'b0;
		burst_len       <= 4'h0;
		rd_cmd_dp       <= 1'b0;
		rd_exok_dp      <= 1'h0;
		bready_d1       <= 1'b0;
		rd_dp_last      <= 1'b0;
		issue_addr      <= {(ADDR_WIDTH){1'b0}};
		arlen_keep      <= 8'h0;
		burst_type      <= 2'h0;
		burst_size      <= 3'h0;
		burst_lock      <= 1'h0;
		burst_id_ap     <= {ID_WIDTH{1'b0}};
		burst_id_dp     <= {ID_WIDTH{1'b0}};
		pend_rd_cmd     <= 1'b0;
		out_of_range_ap <= 1'b0;
		bresp_stat_keep <= 1'b0;
	end else begin
		axi_cs          <= axi_ns;
		mem_cs          <= mem_cs_nx;
		wr_cmd          <= wr_cmd_nx;
		burst_len       <= burst_len_nx;
		rd_cmd_dp       <= rd_cmd_ap;
		rd_exok_dp      <= rd_cmd_ap & burst_lock;
		bready_d1       <= bready;
		rd_dp_last      <= rd_ap_last;
		issue_addr      <= issue_addr_nx;
		arlen_keep      <= arlen_keep_nx;
		burst_type      <= burst_type_nx;
		burst_size      <= burst_size_nx;
		burst_lock      <= burst_lock_nx;
		burst_id_ap     <= burst_id_nx;
		burst_id_dp     <= burst_id_ap;
		pend_rd_cmd     <= pend_rd_cmd_nx;
		out_of_range_ap <= out_of_range_nx;
		bresp_stat_keep <= bresp_stat_keep_nx;
	end

nds_sync_fifo_afe #(RDATA_WIDTH,2) u_rdata_fifo (
	.reset_n      (aresetn                ),
	.clk          (aclk                   ),
	.wr           (rdata_fifo_wr          ),
	.wr_data      (rdata_fifo_wr_data     ),
	.rd           (rdata_fifo_rd          ),
	.rd_data      (rdata_fifo_rd_data     ),
	.almost_empty (rdata_fifo_almost_empty),
	.almost_full  (rdata_fifo_almost_full ),
	.empty        (rdata_fifo_empty       ),
	.full         (rdata_fifo_full        )
);

nds_sync_fifo_afe  #(WRESP_WIDTH,2) u_bresp_fifo (
	.reset_n      (aresetn                ),
	.clk          (aclk                   ),
	.wr           (bresp_fifo_wr          ),
	.wr_data      (bresp_fifo_wr_data     ),
	.rd           (bresp_fifo_rd          ),
	.rd_data      (bresp_fifo_rd_data     ),
	.almost_empty (bresp_fifo_almost_empty),
	.almost_full  (bresp_fifo_almost_full ),
	.empty        (bresp_fifo_empty       ),
	.full         (bresp_fifo_full        )
);

always @(posedge aclk or negedge aresetn)
	if (~aresetn) begin
		exclusive_id	<= {ID_WIDTH{1'b0}};
		exclusive_mask	<= {(ADDR_WIDTH){1'b0}};
		exclusive_addr	<= {(ADDR_WIDTH){1'b0}};
		exclusive_size	<= 3'b0;
		exclusive_len	<= 4'b0;
		exclusive_burst	<= 2'b0;
	end else if (new_rcmd_rd & arlock & (~out_of_range_nx)) begin
		exclusive_id	<= arid;
		exclusive_addr	<= araddr[ADDR_WIDTH-1:0];
		exclusive_mask	<= exclusive_mask_nx;
		exclusive_size	<= arsize;
		exclusive_len	<= arlen[3:0];
		exclusive_burst	<= arburst;
	end

always @(posedge aclk or negedge aresetn)
	if (~aresetn) begin
		exclusive_lock_valid <= 1'b0;
		store_cond_ok        <= 1'b0;
	end else begin
		exclusive_lock_valid <= exclusive_lock_valid_nx;
		store_cond_ok        <= store_cond_ok_nx;
	end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		write_addr_check_mask <= {(ADDR_WIDTH){1'b0}};
	end
	else if (awvalid & awready) begin
		write_addr_check_mask <= write_addr_check_mask_nx;
	end
end

endmodule

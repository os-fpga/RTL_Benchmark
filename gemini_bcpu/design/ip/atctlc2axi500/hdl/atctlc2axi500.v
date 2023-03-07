// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module atctlc2axi500 (
    	  clk,
    	  resetn,
    	  aclk_en,
    	  aclk,
    	  aresetn,
    	  awid,
    	  awaddr,
    	  awlen,
    	  awsize,
    	  awburst,
    	  awlock,
    	  awcache,
    	  awprot,
    	  awuser,
    	  awvalid,
    	  awready,
    	  wdata,
    	  wstrb,
    	  wlast,
    	  wuser,
    	  wvalid,
    	  wready,
    	  bid,
    	  bresp,
    	  buser,
    	  bvalid,
    	  bready,
    	  arid,
    	  araddr,
    	  arlen,
    	  arsize,
    	  arburst,
    	  arlock,
    	  arcache,
    	  arprot,
    	  aruser,
    	  arvalid,
    	  arready,
    	  rid,
    	  rdata,
    	  rresp,
    	  rlast,
    	  ruser,
    	  rvalid,
    	  rready,
    	  a_opcode,
    	  a_param,
    	  a_size,
    	  a_source,
    	  a_address,
    	  a_mask,
    	  a_corrupt,
    	  a_data,
    	  a_user,
    	  a_valid,
    	  a_ready,
    	  b_opcode,
    	  b_param,
    	  b_size,
    	  b_source,
    	  b_address,
    	  b_mask,
    	  b_corrupt,
    	  b_data,
    	  b_user,
    	  b_valid,
    	  b_ready,
    	  c_opcode,
    	  c_param,
    	  c_size,
    	  c_source,
    	  c_address,
    	  c_corrupt,
    	  c_data,
    	  c_user,
    	  c_valid,
    	  c_ready,
    	  d_opcode,
    	  d_param,
    	  d_size,
    	  d_source,
    	  d_sink,
    	  d_denied,
    	  d_corrupt,
    	  d_data,
    	  d_user,
    	  d_valid,
    	  d_ready,
    	  e_sink,
    	  e_valid,
    	  e_ready,
    	  e_user
);

parameter AXI_ASYNC         = 0;
parameter ADDR_WIDTH        = 32;
parameter DATA_WIDTH        = 64;
parameter TL_SOURCE_WIDTH   = 4;
parameter TL_SINK_WIDTH     = 2;
parameter AXI_ID_WIDTH      = 4;
parameter AXI_USER_WIDTH    = 1;

localparam PRODUCT_ID       = 32'h00125005;
localparam SYNC_STAGE       = 3;
localparam ASYNC_DEPTH      = 8;

input                              clk;
input                              resetn;
input                              aclk_en;

input                              aclk;
input                              aresetn;

output          [AXI_ID_WIDTH-1:0] awid;
output            [ADDR_WIDTH-1:0] awaddr;
output                       [7:0] awlen;
output                       [2:0] awsize;
output                       [1:0] awburst;
output                             awlock;
output                       [3:0] awcache;
output                       [2:0] awprot;
output        [AXI_USER_WIDTH-1:0] awuser;
output                             awvalid;
input                              awready;

output            [DATA_WIDTH-1:0] wdata;
output        [(DATA_WIDTH/8)-1:0] wstrb;
output                             wlast;
output        [AXI_USER_WIDTH-1:0] wuser;
output                             wvalid;
input                              wready;

input           [AXI_ID_WIDTH-1:0] bid;
input                        [1:0] bresp;
input         [AXI_USER_WIDTH-1:0] buser;
input                              bvalid;
output                             bready;

output          [AXI_ID_WIDTH-1:0] arid;
output            [ADDR_WIDTH-1:0] araddr;
output                       [7:0] arlen;
output                       [2:0] arsize;
output                       [1:0] arburst;
output                             arlock;
output                       [3:0] arcache;
output                       [2:0] arprot;
output        [AXI_USER_WIDTH-1:0] aruser;
output                             arvalid;
input                              arready;

input           [AXI_ID_WIDTH-1:0] rid;
input             [DATA_WIDTH-1:0] rdata;
input                        [1:0] rresp;
input                              rlast;
input         [AXI_USER_WIDTH-1:0] ruser;
input                              rvalid;
output                             rready;

input                        [2:0] a_opcode;
input                        [2:0] a_param;
input                        [2:0] a_size;
input        [TL_SOURCE_WIDTH-1:0] a_source;
input             [ADDR_WIDTH-1:0] a_address;
input           [DATA_WIDTH/8-1:0] a_mask;
input                              a_corrupt;
input             [DATA_WIDTH-1:0] a_data;
input     [(AXI_USER_WIDTH+8)-1:0] a_user;
input                              a_valid;
output                             a_ready;

output                       [2:0] b_opcode;
output                       [2:0] b_param;
output                       [2:0] b_size;
output       [TL_SOURCE_WIDTH-1:0] b_source;
output            [ADDR_WIDTH-1:0] b_address;
output          [DATA_WIDTH/8-1:0] b_mask;
output                             b_corrupt;
output            [DATA_WIDTH-1:0] b_data;
output                             b_user;
output                             b_valid;
input                              b_ready;

input                        [2:0] c_opcode;
input                        [2:0] c_param;
input                        [2:0] c_size;
input        [TL_SOURCE_WIDTH-1:0] c_source;
input             [ADDR_WIDTH-1:0] c_address;
input                              c_corrupt;
input             [DATA_WIDTH-1:0] c_data;
input     [(AXI_USER_WIDTH+8)-1:0] c_user;
input                              c_valid;
output                             c_ready;

output                       [2:0] d_opcode;
output                       [1:0] d_param;
output                       [2:0] d_size;
output       [TL_SOURCE_WIDTH-1:0] d_source;
output         [TL_SINK_WIDTH-1:0] d_sink;
output                             d_denied;
output                             d_corrupt;
output            [DATA_WIDTH-1:0] d_data;
output    [(AXI_USER_WIDTH+2)-1:0] d_user;
output                             d_valid;
input                              d_ready;

input          [TL_SINK_WIDTH-1:0] e_sink;
input                              e_valid;
output                             e_ready;
input                              e_user;

localparam TL_A_USER_WIDTH   = 8 + AXI_USER_WIDTH;
localparam TL_B_USER_WIDTH   = 1;
localparam TL_C_USER_WIDTH   = 8 + AXI_USER_WIDTH;
localparam TL_D_USER_WIDTH   = 2 + AXI_USER_WIDTH;
localparam TL_E_USER_WIDTH   = 1;

localparam AXSIZE_WIDTH  = 3;
localparam AXCACHE_WIDTH = 4;
localparam AXLOCK_WIDTH  = 1;
localparam AXPROT_WIDTH  = 3;
localparam AXLEN_WIDTH   = 8;
localparam AXBURST_WIDTH = 2;
localparam WSTRB_WIDTH   = DATA_WIDTH/8;
localparam XLAST_WIDTH   = 1;

localparam TL_SIZE_WIDTH            = 3;
localparam TL_OP_WIDTH              = 3;
localparam TL_W_USER_WIDTH          = 8 + AXI_USER_WIDTH;
localparam TL_R_USER_WIDTH          = 8 + AXI_USER_WIDTH;
localparam TL_REQ_USER_AXPROT_POS   = 0;
localparam TL_REQ_USER_AXCACHE_POS  = TL_REQ_USER_AXPROT_POS + AXPROT_WIDTH;
localparam TL_REQ_USER_AXLOCK_POS   = TL_REQ_USER_AXCACHE_POS + AXCACHE_WIDTH;
localparam TL_REQ_AWUSER_POS        = TL_REQ_USER_AXLOCK_POS + AXLOCK_WIDTH;
localparam TL_REQ_WUSER_POS         = TL_REQ_AWUSER_POS;
localparam TL_REQ_ARUSER_POS        = TL_REQ_AWUSER_POS;

localparam MAX_BYTE_LOG2            = {{32-TL_SIZE_WIDTH{1'b0}},{TL_SIZE_WIDTH{1'b1}}};
localparam DATA_BYTE_WIDTH_LOG2     = $unsigned($clog2(DATA_WIDTH/8));
localparam BEAT_CNT_WIDTH           = MAX_BYTE_LOG2 - DATA_BYTE_WIDTH_LOG2;

wire                         tl2aw_valid;
wire                         tl2aw_ready;
wire                         tl2dw_valid;
wire                         tl2dw_ready;
wire                         tl2ar_valid;
wire                         tl2ar_ready;

wire                         rvalid_ls;
wire                         rready_ls;
wire                         bvalid_ls;
wire                         bready_ls;
wire                         bp_a2d_valid;
wire                         bp_a2d_ready;
wire                         bp_c2d_valid;
wire                         bp_c2d_ready;

wire                   [2:0] iss_a_opcode;
wire                   [2:0] iss_a_param;
wire                   [2:0] iss_a_size;
wire   [TL_SOURCE_WIDTH-1:0] iss_a_source;
wire        [ADDR_WIDTH-1:0] iss_a_address;
wire      [DATA_WIDTH/8-1:0] iss_a_mask;
wire        [DATA_WIDTH-1:0] iss_a_data;
wire   [TL_A_USER_WIDTH-1:0] iss_a_user;
wire                         iss_a_valid;
wire                         iss_a_ready;

wire                   [2:0] iss_c_opcode;
wire                   [2:0] iss_c_size;
wire   [TL_SOURCE_WIDTH-1:0] iss_c_source;
wire        [ADDR_WIDTH-1:0] iss_c_address;
wire        [DATA_WIDTH-1:0] iss_c_data;
wire   [TL_C_USER_WIDTH-1:0] iss_c_user;
wire                         iss_c_valid;
wire                         iss_c_ready;

wire                   [1:0] w_sel;
wire                   [3:0] d_sel;
wire       [TL_OP_WIDTH-1:0] a2d_opcode;
wire                   [1:0] a2d_param;
wire  [AXI_USER_WIDTH+2-1:0] a2d_user;
wire                         a2d_corrupt;
wire       [TL_OP_WIDTH-1:0] c2d_opcode;
wire                   [1:0] c2d_param;
wire  [AXI_USER_WIDTH+2-1:0] c2d_user;
wire                         c2d_corrupt;
wire   [TL_SOURCE_WIDTH-1:0] r2d_source;
wire                   [1:0] r2d_param;
wire       [TL_OP_WIDTH-1:0] r2d_opcode;
wire     [TL_SIZE_WIDTH-1:0] r2d_size;
wire  [AXI_USER_WIDTH+2-1:0] r2d_user;
wire                         r2d_corrupt;
wire   [TL_SOURCE_WIDTH-1:0] b2d_source;
wire                   [1:0] b2d_param;
wire       [TL_OP_WIDTH-1:0] b2d_opcode;
wire     [TL_SIZE_WIDTH-1:0] b2d_size;
wire  [AXI_USER_WIDTH+2-1:0] b2d_user;
wire                         b2d_corrupt;

wire                         a2d_valid;
wire                         a2d_ready;
wire   [TL_SOURCE_WIDTH-1:0] a2d_source;
wire     [TL_SIZE_WIDTH-1:0] a2d_size;
wire     [TL_SINK_WIDTH-1:0] bp_a2d_sink;
wire     [TL_SINK_WIDTH-1:0] a2d_sink;
wire                         c2d_valid;
wire                         c2d_ready;
wire   [TL_SOURCE_WIDTH-1:0] c2d_source;
wire     [TL_SIZE_WIDTH-1:0] c2d_size;

wire                   [7:0] iss_c_bytesize;
wire      [DATA_WIDTH/8-1:0] iss_c_mask;
wire       [WSTRB_WIDTH-1:0] iss_c_mask_unaligned;
wire      [AXSIZE_WIDTH-1:0] a2x_size_nx;
wire      [AXSIZE_WIDTH-1:0] c2x_size_nx;
wire     [MAX_BYTE_LOG2-1:0] a2x_len_temp;
wire     [MAX_BYTE_LOG2-1:0] c2x_len_temp;
wire       [AXLEN_WIDTH-1:0] a2x_len_nx;
wire       [AXLEN_WIDTH-1:0] c2x_len_nx;
wire                         a2w_last;
wire                         c2w_last;

wire      [AXI_ID_WIDTH-1:0] awid_nx;
wire        [ADDR_WIDTH-1:0] awaddr_nx;
wire       [AXLEN_WIDTH-1:0] awlen_nx;
wire      [AXSIZE_WIDTH-1:0] awsize_nx;
wire      [AXLOCK_WIDTH-1:0] awlock_nx;
wire     [AXCACHE_WIDTH-1:0] awcache_nx;
wire      [AXPROT_WIDTH-1:0] awprot_nx;
wire    [AXI_USER_WIDTH-1:0] awuser_nx;
wire   [TL_W_USER_WIDTH-1:0] tl_req_user_aw;
wire   [TL_R_USER_WIDTH-1:0] tl_req_user_ar;
wire        [DATA_WIDTH-1:0] wdata_nx;
wire       [WSTRB_WIDTH-1:0] wstrb_nx;
wire       [XLAST_WIDTH-1:0] wlast_nx;
wire    [AXI_USER_WIDTH-1:0] wuser_nx;
wire      [AXI_ID_WIDTH-1:0] arid_nx;
wire        [ADDR_WIDTH-1:0] araddr_nx;
wire       [AXLEN_WIDTH-1:0] arlen_nx;
wire      [AXSIZE_WIDTH-1:0] arsize_nx;
wire      [AXLOCK_WIDTH-1:0] arlock_nx;
wire     [AXCACHE_WIDTH-1:0] arcache_nx;
wire      [AXPROT_WIDTH-1:0] arprot_nx;
wire    [AXI_USER_WIDTH-1:0] aruser_nx;
wire      [AXI_ID_WIDTH-1:0] bid_ls;
wire                   [1:0] bresp_ls;
wire    [AXI_USER_WIDTH-1:0] buser_ls;
wire      [AXI_ID_WIDTH-1:0] rid_ls;
wire        [DATA_WIDTH-1:0] rdata_ls;
wire                   [1:0] rresp_ls;
wire       [XLAST_WIDTH-1:0] rlast_ls;
wire    [AXI_USER_WIDTH-1:0] ruser_ls;

wire                         w_in_burst;
wire                         w_beat_clr;
wire                         w_beat_cnt_en;
wire    [BEAT_CNT_WIDTH-1:0] w_beat_cnt_inc;
wire    [BEAT_CNT_WIDTH-1:0] w_beat_cnt_nx;
reg     [BEAT_CNT_WIDTH-1:0] w_beat_cnt;

assign b_opcode  = 3'b0;
assign b_param   = 3'b0;
assign b_size    = {TL_SIZE_WIDTH{1'b0}};
assign b_source  = {TL_SOURCE_WIDTH{1'b0}};
assign b_address = {ADDR_WIDTH{1'b0}};
assign b_mask    = {DATA_WIDTH/8{1'b0}};
assign b_corrupt = 1'b0;
assign b_data    = {DATA_WIDTH{1'b0}};
assign b_user    = {TL_B_USER_WIDTH{1'b0}};
assign b_valid   = 1'b0;

wire nds_unused_a_corrupt = a_corrupt;
wire nds_unused_b_ready = b_ready;
wire [2:0] nds_unused_c_param = c_param;
wire nds_unused_c_corrupt = c_corrupt;
wire nds_unused_e_user = e_user;
generate
if(AXI_ASYNC) begin : gen_unused_async
    wire nds_unused_aclk_en = aclk_en;
end
else begin : gen_unused_sync
    wire nds_unused_aclk = aclk;
    wire nds_unused_aresetn = aresetn;
end
endgenerate

atctlc2axi500_scb #(
    .TL_SIZE_WIDTH(TL_SIZE_WIDTH),
    .TL_OP_WIDTH(TL_OP_WIDTH),
    .TL_SINK_WIDTH(TL_SINK_WIDTH),
    .TL_SOURCE_WIDTH(TL_SOURCE_WIDTH),
    .AXI_ID_WIDTH(AXI_ID_WIDTH)
)u_scb(
    .clk(clk),
    .resetn(resetn),
    .a_valid(iss_a_valid),
    .a_ready(iss_a_ready),
    .a_opcode(iss_a_opcode),
    .a_size(iss_a_size),
    .a_param(iss_a_param),
    .a_source(iss_a_source),
    .a_last(a2w_last),
    .c_valid(iss_c_valid),
    .c_ready(iss_c_ready),
    .c_opcode(iss_c_opcode),
    .c_size(iss_c_size),
    .c_source(iss_c_source),
    .c_last(c2w_last),
    .d_valid(d_valid),
    .d_ready(d_ready),
    .d_sink(d_sink),
    .e_valid(e_valid),
    .e_ready(e_ready),
    .e_sink(e_sink),
    .arvalid(tl2ar_valid),
    .arready(tl2ar_ready),
    .arid(arid_nx),
    .awvalid(tl2aw_valid),
    .awready(tl2aw_ready),
    .awid(awid_nx),
    .wvalid(tl2dw_valid),
    .wready(tl2dw_ready),
    .bp_a2d_valid(bp_a2d_valid),
    .bp_a2d_ready(bp_a2d_ready),
    .bp_a2d_sink(bp_a2d_sink),
    .bp_c2d_valid(bp_c2d_valid),
    .bp_c2d_ready(bp_c2d_ready),
    .d_sel(d_sel),
    .a2d_valid(a2d_valid),
    .a2d_ready(a2d_ready),
    .a2d_opcode(a2d_opcode),
    .a2d_param(a2d_param),
    .a2d_sink(a2d_sink),
    .c2d_valid(c2d_valid),
    .c2d_ready(c2d_ready),
    .c2d_opcode(c2d_opcode),
    .c2d_param(c2d_param),
    .rvalid(rvalid_ls),
    .rready(rready_ls),
    .rlast(rlast_ls),
    .rid(rid_ls),
    .bvalid(bvalid_ls),
    .bready(bready_ls),
    .bid(bid_ls),
    .r2d_source(r2d_source),
    .r2d_opcode(r2d_opcode),
    .r2d_size(r2d_size),
    .r2d_param(r2d_param),
    .b2d_source(b2d_source),
    .b2d_opcode(b2d_opcode),
    .b2d_size(b2d_size),
    .b2d_param(b2d_param),
    .w_sel(w_sel),
    .w_in_burst(w_in_burst)
);

assign w_in_burst     = |w_beat_cnt;
assign w_beat_cnt_en  = tl2dw_valid & tl2dw_ready;
assign w_beat_clr     = wlast_nx;
assign w_beat_cnt_nx  = {BEAT_CNT_WIDTH{~w_beat_clr}} & w_beat_cnt_inc;
assign w_beat_cnt_inc = w_beat_cnt + {{BEAT_CNT_WIDTH-1{1'b0}}, 1'b1};
always@(posedge clk or negedge resetn)begin
    if(!resetn)begin
        w_beat_cnt <= {BEAT_CNT_WIDTH{1'b0}};
    end
    else if(w_beat_cnt_en)begin
        w_beat_cnt <= w_beat_cnt_nx;
    end
end

assign a2x_size_nx          = (iss_a_size > DATA_BYTE_WIDTH_LOG2[0+:TL_SIZE_WIDTH]) ? DATA_BYTE_WIDTH_LOG2[0+:TL_SIZE_WIDTH] : iss_a_size;
assign a2x_len_temp         = {MAX_BYTE_LOG2{1'b1}} << iss_a_size;
assign a2x_len_nx           = {{AXLEN_WIDTH-BEAT_CNT_WIDTH{1'b0}}, ~a2x_len_temp[DATA_BYTE_WIDTH_LOG2+:BEAT_CNT_WIDTH]};

assign c2x_size_nx          = (iss_c_size > DATA_BYTE_WIDTH_LOG2[0+:TL_SIZE_WIDTH]) ? DATA_BYTE_WIDTH_LOG2[0+:TL_SIZE_WIDTH] : iss_c_size;
assign c2x_len_temp         = {MAX_BYTE_LOG2{1'b1}} << iss_c_size;
assign c2x_len_nx           = {{AXLEN_WIDTH-BEAT_CNT_WIDTH{1'b0}}, ~c2x_len_temp[DATA_BYTE_WIDTH_LOG2+:BEAT_CNT_WIDTH]};

atctlc2axi500_mux_onehot #(.N(2), .W(ADDR_WIDTH)     ) u_awaddr  (.out(awaddr_nx      ), .sel(w_sel), .in({iss_a_address, iss_c_address}));
atctlc2axi500_mux_onehot #(.N(2), .W(AXSIZE_WIDTH)   ) u_awsize  (.out(awsize_nx      ), .sel(w_sel), .in({a2x_size_nx  , c2x_size_nx  }));
atctlc2axi500_mux_onehot #(.N(2), .W(AXLEN_WIDTH)    ) u_awlen   (.out(awlen_nx       ), .sel(w_sel), .in({a2x_len_nx   , c2x_len_nx   }));
atctlc2axi500_mux_onehot #(.N(2), .W(TL_W_USER_WIDTH)) u_tlwuser (.out(tl_req_user_aw ), .sel(w_sel), .in({iss_a_user   , iss_c_user   }));
atctlc2axi500_mux_onehot #(.N(2), .W(DATA_WIDTH)     ) u_wdata   (.out(wdata_nx       ), .sel(w_sel), .in({iss_a_data   , iss_c_data   }));
atctlc2axi500_mux_onehot #(.N(2), .W(WSTRB_WIDTH)    ) u_wstrb   (.out(wstrb_nx       ), .sel(w_sel), .in({iss_a_mask   , iss_c_mask   }));
atctlc2axi500_mux_onehot #(.N(2), .W(1)              ) u_wlast   (.out(wlast_nx       ), .sel(w_sel), .in({a2w_last     , c2w_last     }));

assign iss_c_bytesize       = 8'd1 << iss_c_size;
assign iss_c_mask_unaligned = ~({WSTRB_WIDTH{1'b1}} << iss_c_bytesize);
assign iss_c_mask           = iss_c_mask_unaligned << iss_c_address[0+:DATA_BYTE_WIDTH_LOG2];

assign a2w_last             = (~|a2x_len_nx) | ({{AXLEN_WIDTH-BEAT_CNT_WIDTH{1'b0}}, w_beat_cnt} == a2x_len_nx);
assign c2w_last             = (~|c2x_len_nx) | ({{AXLEN_WIDTH-BEAT_CNT_WIDTH{1'b0}}, w_beat_cnt} == c2x_len_nx);

assign awburst              = 2'b01;
assign awlock_nx            = tl_req_user_aw[TL_REQ_USER_AXLOCK_POS +:AXLOCK_WIDTH  ];
assign awcache_nx           = tl_req_user_aw[TL_REQ_USER_AXCACHE_POS+:AXCACHE_WIDTH ];
assign awprot_nx            = tl_req_user_aw[TL_REQ_USER_AXPROT_POS +:AXPROT_WIDTH  ];
assign awuser_nx            = tl_req_user_aw[TL_REQ_AWUSER_POS      +:AXI_USER_WIDTH];
assign wuser_nx             = tl_req_user_aw[TL_REQ_WUSER_POS       +:AXI_USER_WIDTH];

assign araddr_nx            = iss_a_address;
assign arsize_nx            = a2x_size_nx;
assign arlen_nx             = a2x_len_nx;
assign arburst              = 2'b01;
assign tl_req_user_ar       = iss_a_user[TL_R_USER_WIDTH-1:0];
assign arlock_nx            = tl_req_user_ar[TL_REQ_USER_AXLOCK_POS +:AXLOCK_WIDTH  ];
assign arcache_nx           = tl_req_user_ar[TL_REQ_USER_AXCACHE_POS+:AXCACHE_WIDTH ];
assign arprot_nx            = tl_req_user_ar[TL_REQ_USER_AXPROT_POS +:AXPROT_WIDTH  ];
assign aruser_nx            = tl_req_user_ar[TL_REQ_ARUSER_POS      +:AXI_USER_WIDTH];

assign a2d_user[1:0] = 2'b0;
assign a2d_corrupt   = 1'b0;
assign c2d_user[1:0] = 2'b0;
assign c2d_corrupt   = 1'b0;
assign b2d_user      = {buser_ls, bresp_ls};
assign b2d_corrupt   = 1'b0;
assign r2d_user      = {ruser_ls, rresp_ls};
assign r2d_corrupt   = rresp_ls[1];
atctlc2axi500_mux_onehot #(.N(4), .W(TL_OP_WIDTH)    ) u_d_opcode (.out(d_opcode ), .sel(d_sel), .in({r2d_opcode , b2d_opcode , a2d_opcode , c2d_opcode }));
atctlc2axi500_mux_onehot #(.N(4), .W(2)              ) u_d_param  (.out(d_param  ), .sel(d_sel), .in({r2d_param  , b2d_param  , a2d_param  , c2d_param  }));
atctlc2axi500_mux_onehot #(.N(4), .W(TL_SIZE_WIDTH)  ) u_d_size   (.out(d_size   ), .sel(d_sel), .in({r2d_size   , b2d_size   , a2d_size   , c2d_size   }));
atctlc2axi500_mux_onehot #(.N(4), .W(TL_SOURCE_WIDTH)) u_d_source (.out(d_source ), .sel(d_sel), .in({r2d_source , b2d_source , a2d_source , c2d_source }));
atctlc2axi500_mux_onehot #(.N(4), .W(1)              ) u_d_corrupt(.out(d_corrupt), .sel(d_sel), .in({r2d_corrupt, b2d_corrupt, a2d_corrupt, c2d_corrupt}));
atctlc2axi500_mux_onehot #(.N(4), .W(TL_D_USER_WIDTH)) u_d_user   (.out(d_user   ), .sel(d_sel), .in({r2d_user   , b2d_user   , a2d_user   , c2d_user   }));
assign d_data      = rdata_ls;
assign d_denied    = 1'b0;

generate
if(AXI_ASYNC)begin : gen_async_aw_fifo
    wire                         awvalid_ff;
    wire                         awready_ff;
    wire      [AXI_ID_WIDTH-1:0] awid_ff;
    wire        [ADDR_WIDTH-1:0] awaddr_ff;
    wire       [AXLEN_WIDTH-1:0] awlen_ff;
    wire      [AXSIZE_WIDTH-1:0] awsize_ff;
    wire      [AXLOCK_WIDTH-1:0] awlock_ff;
    wire     [AXCACHE_WIDTH-1:0] awcache_ff;
    wire      [AXPROT_WIDTH-1:0] awprot_ff;
    wire    [AXI_USER_WIDTH-1:0] awuser_ff;
    atctlc2axi500_async_fifo #(
        .SYNC_STAGE(SYNC_STAGE),
        .WIDTH(AXI_ID_WIDTH + ADDR_WIDTH + AXLEN_WIDTH + AXSIZE_WIDTH + AXLOCK_WIDTH + AXCACHE_WIDTH + AXPROT_WIDTH + AXI_USER_WIDTH),
        .DEPTH(ASYNC_DEPTH)
    )u_aw_fifo(
	.wclk(clk),
	.wreset_n(resetn),
        .wvalid(tl2aw_valid),
        .wready(tl2aw_ready),
	.rclk(aclk),
	.rreset_n(aresetn),
        .rvalid(awvalid_ff),
        .rready(awready_ff),
        .wdata({awid_nx, awaddr_nx, awlen_nx, awsize_nx, awlock_nx, awcache_nx, awprot_nx, awuser_nx}),
        .rdata({awid_ff, awaddr_ff, awlen_ff, awsize_ff, awlock_ff, awcache_ff, awprot_ff, awuser_ff})
    );
    atctlc2axi500_elastic_buffer_o #(
        .DW(AXI_ID_WIDTH + ADDR_WIDTH + AXLEN_WIDTH + AXSIZE_WIDTH + AXLOCK_WIDTH + AXCACHE_WIDTH + AXPROT_WIDTH + AXI_USER_WIDTH)
    )u_aw_buffer(
        .clk(aclk),
        .resetn(aresetn),
        .clk_en(1'b1),
        .i_valid(awvalid_ff),
        .i_ready(awready_ff),
        .o_valid(awvalid),
        .o_ready(awready),
        .din( {awid_ff, awaddr_ff, awlen_ff, awsize_ff, awlock_ff, awcache_ff, awprot_ff, awuser_ff}),
        .dout({awid   , awaddr   , awlen   , awsize   , awlock   , awcache   , awprot   , awuser   })
    );
end
else begin : gen_sync_aw_buffer
    atctlc2axi500_elastic_buffer_o #(
        .DW(AXI_ID_WIDTH + ADDR_WIDTH + AXLEN_WIDTH + AXSIZE_WIDTH + AXLOCK_WIDTH + AXCACHE_WIDTH + AXPROT_WIDTH + AXI_USER_WIDTH)
    )u_aw_buffer(
        .clk(clk),
        .resetn(resetn),
        .clk_en(aclk_en),
        .i_valid(tl2aw_valid),
        .i_ready(tl2aw_ready),
        .o_valid(awvalid),
        .o_ready(awready),
        .din( {awid_nx, awaddr_nx, awlen_nx, awsize_nx, awlock_nx, awcache_nx, awprot_nx, awuser_nx}),
        .dout({awid   , awaddr   , awlen   , awsize   , awlock   , awcache   , awprot   , awuser   })
    );
end
endgenerate

generate
if(AXI_ASYNC)begin : gen_async_dw_fifo
    wire                         wvalid_ff;
    wire                         wready_ff;
    wire        [DATA_WIDTH-1:0] wdata_ff;
    wire       [WSTRB_WIDTH-1:0] wstrb_ff;
    wire       [XLAST_WIDTH-1:0] wlast_ff;
    wire    [AXI_USER_WIDTH-1:0] wuser_ff;
    atctlc2axi500_async_fifo #(
        .SYNC_STAGE(SYNC_STAGE),
        .WIDTH(DATA_WIDTH + WSTRB_WIDTH + XLAST_WIDTH + AXI_USER_WIDTH),
        .DEPTH(ASYNC_DEPTH)
    )u_dw_fifo(
	.wclk(clk),
	.wreset_n(resetn),
        .wvalid(tl2dw_valid),
        .wready(tl2dw_ready),
	.rclk(aclk),
	.rreset_n(aresetn),
        .rvalid(wvalid_ff),
        .rready(wready_ff),
        .wdata({wdata_nx, wstrb_nx, wlast_nx, wuser_nx}),
        .rdata({wdata_ff, wstrb_ff, wlast_ff, wuser_ff})
    );
    atctlc2axi500_elastic_buffer_o #(
        .DW(DATA_WIDTH + WSTRB_WIDTH + XLAST_WIDTH + AXI_USER_WIDTH)
    )u_dw_buffer(
        .clk(aclk),
        .resetn(aresetn),
        .clk_en(1'b1),
        .i_valid(wvalid_ff),
        .i_ready(wready_ff),
        .o_valid(wvalid),
        .o_ready(wready),
        .din( {wdata_ff, wstrb_ff, wlast_ff, wuser_ff}),
        .dout({wdata   , wstrb   , wlast   , wuser   })
    );
end
else begin : gen_sync_dw_buffer
    atctlc2axi500_elastic_buffer_o #(
        .DW(DATA_WIDTH + WSTRB_WIDTH + XLAST_WIDTH + AXI_USER_WIDTH)
    )u_dw_buffer(
        .clk(clk),
        .resetn(resetn),
        .clk_en(aclk_en),
        .i_valid(tl2dw_valid),
        .i_ready(tl2dw_ready),
        .o_valid(wvalid),
        .o_ready(wready),
        .din( {wdata_nx, wstrb_nx, wlast_nx, wuser_nx}),
        .dout({wdata   , wstrb   , wlast   , wuser   })
    );
end
endgenerate

generate
if(AXI_ASYNC)begin : gen_async_ar_fifo
    wire                         arvalid_ff;
    wire                         arready_ff;
    wire      [AXI_ID_WIDTH-1:0] arid_ff;
    wire        [ADDR_WIDTH-1:0] araddr_ff;
    wire       [AXLEN_WIDTH-1:0] arlen_ff;
    wire      [AXSIZE_WIDTH-1:0] arsize_ff;
    wire      [AXLOCK_WIDTH-1:0] arlock_ff;
    wire     [AXCACHE_WIDTH-1:0] arcache_ff;
    wire      [AXPROT_WIDTH-1:0] arprot_ff;
    wire    [AXI_USER_WIDTH-1:0] aruser_ff;
    atctlc2axi500_async_fifo #(
        .SYNC_STAGE(SYNC_STAGE),
        .WIDTH(AXI_ID_WIDTH + ADDR_WIDTH + AXLEN_WIDTH + AXSIZE_WIDTH + AXLOCK_WIDTH + AXCACHE_WIDTH + AXPROT_WIDTH + AXI_USER_WIDTH),
        .DEPTH(ASYNC_DEPTH)
    )u_ar_fifo(
	.wclk(clk),
	.wreset_n(resetn),
        .wvalid(tl2ar_valid),
        .wready(tl2ar_ready),
	.rclk(aclk),
	.rreset_n(aresetn),
        .rvalid(arvalid_ff),
        .rready(arready_ff),
        .wdata({arid_nx, araddr_nx, arlen_nx, arsize_nx, arlock_nx, arcache_nx, arprot_nx, aruser_nx}),
        .rdata({arid_ff, araddr_ff, arlen_ff, arsize_ff, arlock_ff, arcache_ff, arprot_ff, aruser_ff})
    );
    atctlc2axi500_elastic_buffer_o #(
        .DW(AXI_ID_WIDTH + ADDR_WIDTH + AXLEN_WIDTH + AXSIZE_WIDTH + AXLOCK_WIDTH + AXCACHE_WIDTH + AXPROT_WIDTH + AXI_USER_WIDTH)
    )u_ar_buffer(
        .clk(aclk),
        .resetn(aresetn),
        .clk_en(1'b1),
        .i_valid(arvalid_ff),
        .i_ready(arready_ff),
        .o_valid(arvalid),
        .o_ready(arready),
        .din ({arid_ff, araddr_ff, arlen_ff, arsize_ff, arlock_ff, arcache_ff, arprot_ff, aruser_ff}),
        .dout({arid   , araddr   , arlen   , arsize   , arlock   , arcache   , arprot   , aruser   })
    );
end
else begin : gen_sync_ar_buffer
    atctlc2axi500_elastic_buffer_o #(
        .DW(AXI_ID_WIDTH + ADDR_WIDTH + AXLEN_WIDTH + AXSIZE_WIDTH + AXLOCK_WIDTH + AXCACHE_WIDTH + AXPROT_WIDTH + AXI_USER_WIDTH)
    )u_ar_buffer(
        .clk(clk),
        .resetn(resetn),
        .clk_en(aclk_en),
        .i_valid(tl2ar_valid),
        .i_ready(tl2ar_ready),
        .o_valid(arvalid),
        .o_ready(arready),
        .din ({arid_nx, araddr_nx, arlen_nx, arsize_nx, arlock_nx, arcache_nx, arprot_nx, aruser_nx}),
        .dout({arid   , araddr   , arlen   , arsize   , arlock   , arcache   , arprot   , aruser   })
    );
end
endgenerate

generate
if(AXI_ASYNC)begin : gen_async_r_fifo
    wire                         rvalid_ff;
    wire                         rready_ff;
    wire      [AXI_ID_WIDTH-1:0] rid_ff;
    wire        [DATA_WIDTH-1:0] rdata_ff;
    wire                   [1:0] rresp_ff;
    wire       [XLAST_WIDTH-1:0] rlast_ff;
    wire    [AXI_USER_WIDTH-1:0] ruser_ff;
    atctlc2axi500_elastic_buffer_i #(
        .DW(AXI_ID_WIDTH + DATA_WIDTH + 2 + XLAST_WIDTH + AXI_USER_WIDTH)
    )u_r_buffer(
        .clk(aclk),
        .resetn(aresetn),
        .clk_en(1'b1),
        .i_valid(rvalid),
        .i_ready(rready),
        .o_valid(rvalid_ff),
        .o_ready(rready_ff),
        .din ({rid   , rdata   , rresp   , rlast   , ruser   }),
        .dout({rid_ff, rdata_ff, rresp_ff, rlast_ff, ruser_ff})

    );
    atctlc2axi500_async_fifo #(
        .SYNC_STAGE(SYNC_STAGE),
        .DEPTH(ASYNC_DEPTH),
        .WIDTH(AXI_ID_WIDTH + DATA_WIDTH + 2 + XLAST_WIDTH + AXI_USER_WIDTH)
    )u_r_fifo(
        .wclk(aclk),
        .wreset_n(aresetn),
        .wvalid(rvalid_ff),
        .wready(rready_ff),
        .rclk(clk),
        .rreset_n(resetn),
        .rvalid(rvalid_ls),
        .rready(rready_ls),
        .wdata({rid_ff, rdata_ff, rresp_ff, rlast_ff, ruser_ff}),
        .rdata({rid_ls, rdata_ls, rresp_ls, rlast_ls, ruser_ls})
    );
end
else begin : gen_sync_r_fifo
    atctlc2axi500_elastic_buffer_i #(
        .DW(AXI_ID_WIDTH + DATA_WIDTH + 2 + XLAST_WIDTH + AXI_USER_WIDTH)
    )u_r_buffer(
        .clk(clk),
        .resetn(resetn),
        .clk_en(aclk_en),
        .i_valid(rvalid),
        .i_ready(rready),
        .o_valid(rvalid_ls),
        .o_ready(rready_ls),
        .din ({rid   , rdata   , rresp   , rlast   , ruser   }),
        .dout({rid_ls, rdata_ls, rresp_ls, rlast_ls, ruser_ls})

    );
end
endgenerate

generate
if(AXI_ASYNC)begin : gen_async_b_fifo
    wire                         bvalid_ff;
    wire                         bready_ff;
    wire      [AXI_ID_WIDTH-1:0] bid_ff;
    wire                   [1:0] bresp_ff;
    wire    [AXI_USER_WIDTH-1:0] buser_ff;
    atctlc2axi500_elastic_buffer_i #(
        .DW(AXI_ID_WIDTH + 2 + AXI_USER_WIDTH)
    )u_b_buffer(
        .clk(aclk),
        .resetn(aresetn),
        .clk_en(1'b1),
        .i_valid(bvalid),
        .i_ready(bready),
        .o_valid(bvalid_ff),
        .o_ready(bready_ff),
        .din ({bid   , bresp   , buser   }),
        .dout({bid_ff, bresp_ff, buser_ff})
    );
    atctlc2axi500_async_fifo #(
        .SYNC_STAGE(SYNC_STAGE),
        .DEPTH(ASYNC_DEPTH),
        .WIDTH(AXI_ID_WIDTH + 2 + AXI_USER_WIDTH)
    )u_b_fifo(
        .wclk(aclk),
        .wreset_n(aresetn),
        .wvalid(bvalid_ff),
        .wready(bready_ff),
        .rclk(clk),
        .rreset_n(resetn),
        .rvalid(bvalid_ls),
        .rready(bready_ls),
        .wdata({bid_ff, bresp_ff, buser_ff}),
        .rdata({bid_ls, bresp_ls, buser_ls})
    );
end
else begin : gen_sync_b_fifo
    atctlc2axi500_elastic_buffer_i #(
        .DW(AXI_ID_WIDTH + 2 + AXI_USER_WIDTH)
    )u_b_buffer(
        .clk(clk),
        .resetn(resetn),
        .clk_en(aclk_en),
        .i_valid(bvalid),
        .i_ready(bready),
        .o_valid(bvalid_ls),
        .o_ready(bready_ls),
        .din ({bid   , bresp   , buser   }),
        .dout({bid_ls, bresp_ls, buser_ls})
    );
end
endgenerate

atctlc2axi500_sync_fifo #(
    .DEPTH(2),
    .WIDTH(TL_SOURCE_WIDTH + TL_SIZE_WIDTH + TL_SINK_WIDTH + AXI_USER_WIDTH)
)u_a2d_bypass_fifo(
    .clk(clk),
    .reset_n(resetn),
    .wvalid(bp_a2d_valid),
    .wready(bp_a2d_ready),
    .rvalid(a2d_valid),
    .rready(a2d_ready),
    .wdata({iss_a_source, iss_a_size, bp_a2d_sink, iss_a_user[TL_REQ_ARUSER_POS+:AXI_USER_WIDTH]}),
    .rdata({a2d_source  , a2d_size  , a2d_sink   , a2d_user[2+:AXI_USER_WIDTH]                  })
);


atctlc2axi500_sync_fifo #(
    .DEPTH(2),
    .WIDTH(TL_SOURCE_WIDTH + TL_SIZE_WIDTH + AXI_USER_WIDTH)
)u_c2d_bypass_fifo(
    .clk(clk),
    .reset_n(resetn),
    .wvalid(bp_c2d_valid),
    .wready(bp_c2d_ready),
    .rvalid(c2d_valid),
    .rready(c2d_ready),
    .wdata({iss_c_source, iss_c_size, iss_a_user[TL_REQ_AWUSER_POS+:AXI_USER_WIDTH]}),
    .rdata({c2d_source  , c2d_size  , c2d_user[2+:AXI_USER_WIDTH]                  })
);

atctlc2axi500_bypass_elastic_buffer #(
    .DW(3 + 3 + TL_SIZE_WIDTH + TL_SOURCE_WIDTH + ADDR_WIDTH + DATA_WIDTH/8 + DATA_WIDTH + TL_A_USER_WIDTH)
)u_a_input_buffer(
    .clk(clk),
    .resetn(resetn),
    .i_valid(a_valid),
    .i_ready(a_ready),
    .o_valid(iss_a_valid),
    .o_ready(iss_a_ready),
    .din( {    a_opcode,     a_param,     a_size,     a_source,     a_address,     a_mask,     a_data,     a_user}),
    .dout({iss_a_opcode, iss_a_param, iss_a_size, iss_a_source, iss_a_address, iss_a_mask, iss_a_data, iss_a_user})
);

atctlc2axi500_bypass_elastic_buffer #(
    .DW(3 + TL_SIZE_WIDTH + TL_SOURCE_WIDTH + ADDR_WIDTH + DATA_WIDTH + TL_C_USER_WIDTH)
)u_c_input_buffer(
    .clk(clk),
    .resetn(resetn),
    .i_valid(c_valid),
    .i_ready(c_ready),
    .o_valid(iss_c_valid),
    .o_ready(iss_c_ready),
    .din( {    c_opcode,     c_size,     c_source,     c_address,     c_data,     c_user}),
    .dout({iss_c_opcode, iss_c_size, iss_c_source, iss_c_address, iss_c_data, iss_c_user})
);





















endmodule

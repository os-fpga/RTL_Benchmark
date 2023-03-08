// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atctlc2axi500_scb (
    	  clk,
    	  resetn,
    	  a_valid,
    	  a_ready,
    	  a_opcode,
    	  a_size,
    	  a_source,
    	  a_param,
    	  a_last,
    	  c_valid,
    	  c_ready,
    	  c_opcode,
    	  c_size,
    	  c_source,
    	  c_last,
    	  d_valid,
    	  d_ready,
    	  d_sink,
    	  e_valid,
    	  e_ready,
    	  e_sink,
    	  w_sel,
    	  w_in_burst,
    	  awvalid,
    	  awready,
    	  awid,
    	  arvalid,
    	  arready,
    	  arid,
    	  wvalid,
    	  wready,
    	  bp_a2d_valid,
    	  bp_a2d_ready,
    	  bp_a2d_sink,
    	  bp_c2d_valid,
    	  bp_c2d_ready,
    	  d_sel,
    	  a2d_valid,
    	  a2d_ready,
    	  a2d_opcode,
    	  a2d_param,
    	  a2d_sink,
    	  c2d_valid,
    	  c2d_ready,
    	  c2d_opcode,
    	  c2d_param,
    	  rvalid,
    	  rready,
    	  rlast,
    	  rid,
    	  bvalid,
    	  bready,
    	  bid,
    	  r2d_source,
    	  r2d_opcode,
    	  r2d_size,
    	  r2d_param,
    	  b2d_source,
    	  b2d_opcode,
    	  b2d_size,
    	  b2d_param
);

parameter TL_SIZE_WIDTH   = 3;
parameter TL_OP_WIDTH     = 3;
parameter TL_SINK_WIDTH   = 1;
parameter TL_SOURCE_WIDTH = 4;
parameter AXI_ID_WIDTH    = 4;
localparam TL_IDLEN = 2**TL_SOURCE_WIDTH;

localparam FORCE_ID_REMAP = 0;


localparam ID_REMAP_EN = (TL_SOURCE_WIDTH > AXI_ID_WIDTH) || FORCE_ID_REMAP;

localparam TL_OP_PUTFULL        = 3'd0;
localparam TL_OP_PUTPART        = 3'd1;
localparam TL_OP_GET            = 3'd4;
localparam TL_OP_ACQUIREBLOCK   = 3'd6;
localparam TL_OP_ACQUIREPERM    = 3'd7;


localparam TL_OP_ACCESSACK      = 3'd0;
localparam TL_OP_ACCESSACKDATA  = 3'd1;
localparam TL_OP_PROBEACKDATA   = 3'd5;
localparam TL_OP_RELEASE        = 3'd6;
localparam TL_OP_RELEASEDATA    = 3'd7;

localparam TL_OP_GRANT          = 3'd4;
localparam TL_OP_GRANTDATA      = 3'd5;
localparam TL_OP_RELEASEACK     = 3'd6;

localparam TL_PERM_2T      = 2'd0;
localparam TL_PERM_2B      = 2'd1;
localparam TL_PERM_2N      = 2'd2;
localparam TL_PERM_N2B     = 3'd0;
localparam TL_PERM_N2T     = 3'd1;
localparam TL_PERM_B2T     = 3'd2;
localparam TL_PERM_T2B     = 3'd0;
localparam TL_PERM_T2N     = 3'd1;
localparam TL_PERM_B2N     = 3'd2;
localparam TL_PERM_T2T     = 3'd3;
localparam TL_PERM_B2B     = 3'd4;
localparam TL_PERM_N2N     = 3'd5;

input clk;
input resetn;

input                         a_valid;
output                        a_ready;
input       [TL_OP_WIDTH-1:0] a_opcode;
input     [TL_SIZE_WIDTH-1:0] a_size;
input   [TL_SOURCE_WIDTH-1:0] a_source;
input                   [2:0] a_param;
input                         a_last;

input                         c_valid;
output                        c_ready;
input       [TL_OP_WIDTH-1:0] c_opcode;
input     [TL_SIZE_WIDTH-1:0] c_size;
input   [TL_SOURCE_WIDTH-1:0] c_source;
input                         c_last;

output                        d_valid;
input                         d_ready;
output    [TL_SINK_WIDTH-1:0] d_sink;

input                         e_valid;
output                        e_ready;
input     [TL_SINK_WIDTH-1:0] e_sink;

output                  [1:0] w_sel;
input                         w_in_burst;

output                        awvalid;
input                         awready;
output     [AXI_ID_WIDTH-1:0] awid;
output                        arvalid;
input                         arready;
output     [AXI_ID_WIDTH-1:0] arid;
output                        wvalid;
input                         wready;

output                        bp_a2d_valid;
input                         bp_a2d_ready;
output    [TL_SINK_WIDTH-1:0] bp_a2d_sink;
output                        bp_c2d_valid;
input                         bp_c2d_ready;

output                  [3:0] d_sel;
input                         a2d_valid;
output                        a2d_ready;
output      [TL_OP_WIDTH-1:0] a2d_opcode;
output                  [1:0] a2d_param;
input     [TL_SINK_WIDTH-1:0] a2d_sink;
input                         c2d_valid;
output                        c2d_ready;
output      [TL_OP_WIDTH-1:0] c2d_opcode;
output                  [1:0] c2d_param;

input                         rvalid;
output                        rready;
input                         rlast;
input      [AXI_ID_WIDTH-1:0] rid;
input                         bvalid;
output                        bready;
input      [AXI_ID_WIDTH-1:0] bid;

output  [TL_SOURCE_WIDTH-1:0] r2d_source;
output      [TL_OP_WIDTH-1:0] r2d_opcode;
output    [TL_SIZE_WIDTH-1:0] r2d_size;
output                  [1:0] r2d_param;

output  [TL_SOURCE_WIDTH-1:0] b2d_source;
output      [TL_OP_WIDTH-1:0] b2d_opcode;
output    [TL_SIZE_WIDTH-1:0] b2d_size;
output                  [1:0] b2d_param;

wire [TL_SOURCE_WIDTH-1:0] x2w_source;

wire [3:0] d_valids;
wire [3:0] d_readys;

wire [TL_SINK_WIDTH-1:0] next_sink;
wire [TL_SINK_WIDTH-1:0] b2d_sink;
wire [TL_SINK_WIDTH-1:0] r2d_sink;
wire [TL_SINK_WIDTH-1:0] c2d_sink;

wire is_a2r;
wire is_a2w;
wire is_a2d;
wire is_c2w;
wire is_c2d;

wire a2r_valid;
wire a2r_ready;
wire a2w_valid;
wire a2w_ready;
wire c2w_valid;
wire c2w_ready;

wire [TL_IDLEN-1:0] a2r_id_busys;
wire [TL_IDLEN-1:0] a2w_id_busys;
wire [TL_IDLEN-1:0] c2w_id_busys;

wire a2r_id_cft;
wire a2w_id_cft;
wire c2w_id_cft;

wire a2r_stall;
wire a2d_stall;
wire a2w_stall;
wire c2w_stall;

reg                [TL_IDLEN-1:0] a2x_is_acquireblocks;
reg  [TL_IDLEN*TL_SIZE_WIDTH-1:0] a2x_sizes;
reg  [TL_IDLEN*TL_SINK_WIDTH-1:0] a2r_sinks;
reg                [TL_IDLEN-1:0] a2r_busys;
reg                [TL_IDLEN-1:0] a2w_busys;
reg                [TL_IDLEN-1:0] c2w_busys;
reg  [TL_IDLEN*TL_SIZE_WIDTH-1:0] c2x_sizes;

wire                              r_in_burst_en;
wire                              r_in_burst_nx;
reg                               r_in_burst;

wire arid_busy;
wire awid_busy;

wire b2d_sink_rsp_valid;
wire r2d_sink_rsp_valid;
wire c2d_sink_rsp_valid;
wire a2d_sink_rsp_valid;

wire sink_req_valid;
wire sink_rsp;
wire sink_rsp_valid;
wire sink_ack_valid;
wire sink_busy;

wire a_op_get         ;
wire a_op_acquireblock;
wire a_op_acquireperm ;
wire a_op_putfull     ;
wire a_op_putpart     ;
wire c_op_release     ;
wire c_op_releasedata ;
wire a_perm_n2b       ;
wire a_perm_n2t       ;
wire a_perm_b2t       ;

wire [TL_IDLEN-1:0] a_source_onehot;
wire [TL_IDLEN-1:0] c_source_onehot;
wire [TL_IDLEN-1:0] r2d_source_onehot;
wire [TL_IDLEN-1:0] b2d_source_onehot;


atctlc2axi500_bin2onehot #(.N(TL_IDLEN)) u_a_source_onehot  (.out(a_source_onehot  ), .in(a_source  ));
atctlc2axi500_bin2onehot #(.N(TL_IDLEN)) u_c_source_onehot  (.out(c_source_onehot  ), .in(c_source  ));
atctlc2axi500_bin2onehot #(.N(TL_IDLEN)) u_r2d_source_onehot(.out(r2d_source_onehot), .in(r2d_source));
atctlc2axi500_bin2onehot #(.N(TL_IDLEN)) u_b2d_source_onehot(.out(b2d_source_onehot), .in(b2d_source));

assign a_op_get          = a_opcode == TL_OP_GET;
assign a_op_acquireblock = a_opcode == TL_OP_ACQUIREBLOCK;
assign a_op_acquireperm  = a_opcode == TL_OP_ACQUIREPERM;
assign a_op_putfull      = a_opcode == TL_OP_PUTFULL;
assign a_op_putpart      = a_opcode == TL_OP_PUTPART;
assign c_op_release      = c_opcode == TL_OP_RELEASE;
assign c_op_releasedata  = c_opcode == TL_OP_RELEASEDATA;
assign a_perm_n2b        = a_param == TL_PERM_N2B;
assign a_perm_n2t        = a_param == TL_PERM_N2T;
assign a_perm_b2t        = a_param == TL_PERM_B2T;


assign is_a2r = a_op_get
              | (a_op_acquireblock & (a_perm_n2b | a_perm_n2t))
              ;
assign is_a2w = (a_op_putfull | a_op_putpart);
assign is_a2d = a_op_acquireperm
              | (a_op_acquireblock & a_perm_b2t)
              ;
assign is_c2w = c_op_releasedata
              ;
assign is_c2d = c_op_release;

assign a_ready = (a2w_ready & is_a2w)
               | (a2r_ready & is_a2r)
               | (bp_a2d_ready & is_a2d & ~a2d_stall)
               ;
assign a2w_valid = a_valid & is_a2w;
assign a2r_valid = a_valid & is_a2r;
assign bp_a2d_valid = a_valid & is_a2d & ~a2d_stall;

assign c_ready = (c2w_ready & is_c2w)
               | (bp_c2d_ready & is_c2d)
               ;
assign c2w_valid = c_valid & is_c2w;
assign bp_c2d_valid = c_valid & is_c2d;

assign d_valids = {rvalid, bvalid, a2d_valid, c2d_valid} & ~{1'b0, {3{r_in_burst}}}
                ;
assign {rready, bready, a2d_ready, c2d_ready} = d_readys & ~{1'b0, {3{r_in_burst}}}
                                              ;

assign e_ready = 1'b1;

generate
if(ID_REMAP_EN)begin : gen_id_remap
    wire argrant = arvalid & arready;
    wire rgrant = rvalid & rready & rlast;
    wire awgrant = awvalid & awready;
    wire bgrant = bvalid & bready;

    atctlc2axi500_id_remapper #(
        .US_IDW(TL_SOURCE_WIDTH),
        .DS_IDW(AXI_ID_WIDTH)
    ) u_arid_remapper (
        .clk(clk),
        .resetn(resetn),
        .us_grant(argrant),
        .us_id(a_source),
        .ds_grant(rgrant),
        .ds_id(rid),
        .ds2us_id(r2d_source),
        .next_id(arid),
        .busy(arid_busy)
    );

    atctlc2axi500_id_remapper #(
        .US_IDW(TL_SOURCE_WIDTH),
        .DS_IDW(AXI_ID_WIDTH)
    ) u_awid_remapper (
        .clk(clk),
        .resetn(resetn),
        .us_grant(awgrant),
        .us_id(x2w_source),
        .ds_grant(bgrant),
        .ds_id(bid),
        .ds2us_id(b2d_source),
        .next_id(awid),
        .busy(awid_busy)
    );
end
else if(TL_SOURCE_WIDTH < AXI_ID_WIDTH)begin : gen_id_extend
    assign b2d_source = bid[0+:TL_SOURCE_WIDTH];
    assign r2d_source = rid[0+:TL_SOURCE_WIDTH];
    assign arid = {{(AXI_ID_WIDTH-TL_SOURCE_WIDTH){1'b0}}, a_source};
    assign awid = {{(AXI_ID_WIDTH-TL_SOURCE_WIDTH){1'b0}}, x2w_source};
    assign arid_busy = 1'b0;
    assign awid_busy = 1'b0;
end
else if(TL_SOURCE_WIDTH == AXI_ID_WIDTH)begin : gen_id_bypass
    assign b2d_source = bid;
    assign r2d_source = rid;
    assign arid = a_source;
    assign awid = x2w_source;
    assign arid_busy = 1'b0;
    assign awid_busy = 1'b0;
end
endgenerate

assign a2r_id_busys = a2r_busys | a2w_busys;
assign a2w_id_busys = a2r_busys
                    | c2w_busys
                    | a2w_busys & {TL_IDLEN{~w_in_burst}}
                    ;
assign c2w_id_busys = a2w_busys
                    | c2w_busys & {TL_IDLEN{~w_in_burst}}
                    ;
assign a2r_id_cft = a2r_id_busys[a_source];
assign a2w_id_cft = a2w_id_busys[a_source];
assign c2w_id_cft = c2w_id_busys[c_source];

assign a2r_stall = a2r_id_cft | (sink_busy & a_op_acquireblock) | arid_busy;
assign a2d_stall = a2r_id_cft | sink_busy;
assign a2w_stall = a2w_id_cft | (awid_busy & ~w_in_burst);
assign c2w_stall = c2w_id_cft | (awid_busy & ~w_in_burst);

wire tl2w_ready;
wire tl2w_valid;
wire tl2w_stall;
assign tl2w_stall = |(w_sel & {a2w_stall, c2w_stall});
assign tl2w_ready = (awready|w_in_burst) & wready & ~tl2w_stall;
assign awvalid    = tl2w_valid & wready & ~w_in_burst & ~tl2w_stall;
assign wvalid     = tl2w_valid & (awready|w_in_burst) & ~tl2w_stall;
atctlc2axi500_burst_arb #(
    .N(2)
)u_cmd_w_burst_arb(
    .clk(clk),
    .resetn(resetn),
    .valids  ({a2w_valid  , c2w_valid  }),
    .readys  ({a2w_ready  , c2w_ready  }),
    .lasts   ({a_last     , c_last     }),
    .grants  (w_sel),
    .valid   (tl2w_valid),
    .ready   (tl2w_ready)
);

atctlc2axi500_mux_onehot #(.N(2), .W(TL_SOURCE_WIDTH)) u_x2w_source (.out(x2w_source), .sel(w_sel), .in({a_source, c_source}));

assign arvalid = a2r_valid & ~a2r_stall;
assign a2r_ready = arready & ~a2r_stall;

atctlc2axi500_arb_fp #(
    .N(4)
) u_d_arb (
    .valids  (d_valids),
    .readys  (d_readys),
    .grants  (d_sel),
    .valid   (d_valid),
    .ready   (d_ready)
);

assign b2d_opcode         = a2w_busys[b2d_source] ? TL_OP_ACCESSACK : TL_OP_RELEASEACK;
assign b2d_size           = c2w_busys[b2d_source] ? c2x_sizes[b2d_source*TL_SIZE_WIDTH+:TL_SIZE_WIDTH]
                                                 : a2x_sizes[b2d_source*TL_SIZE_WIDTH+:TL_SIZE_WIDTH]
                                                 ;
assign b2d_param          = 2'b0;
assign b2d_sink           = {TL_SINK_WIDTH{1'b0}};
assign b2d_sink_rsp_valid = 1'b0;

assign r2d_opcode         = a2x_is_acquireblocks[r2d_source] ? TL_OP_GRANTDATA : TL_OP_ACCESSACKDATA;
assign r2d_size           = a2x_sizes[r2d_source*TL_SIZE_WIDTH+:TL_SIZE_WIDTH];
assign r2d_param          = a2x_is_acquireblocks[r2d_source] ? TL_PERM_2T : 2'b0;
assign r2d_sink           = a2r_sinks[r2d_source*TL_SINK_WIDTH+:TL_SINK_WIDTH];
assign r2d_sink_rsp_valid = a2x_is_acquireblocks[r2d_source] & rlast;

assign c2d_opcode         = TL_OP_RELEASEACK;
assign c2d_param          = 2'b0;
assign c2d_sink           = {TL_SINK_WIDTH{1'b0}};
assign c2d_sink_rsp_valid = 1'b0;

assign a2d_opcode         = TL_OP_GRANT;
assign a2d_param          = TL_PERM_2T;
assign a2d_sink_rsp_valid = 1'b1;

assign bp_a2d_sink = next_sink;
assign sink_req_valid = a2r_valid & a2r_ready & a_op_acquireblock
                      | bp_a2d_valid & bp_a2d_ready;
assign sink_rsp_valid = d_valid & d_ready & sink_rsp;
assign sink_ack_valid = e_valid & e_ready;
atctlc2axi500_mux_onehot #(
    .N(4),
    .W(1)
) u_d_sink_req_valid (
    .out(sink_rsp),
    .sel(d_sel),
    .in({r2d_sink_rsp_valid, b2d_sink_rsp_valid, a2d_sink_rsp_valid, c2d_sink_rsp_valid })
);

atctlc2axi500_mux_onehot #(
    .N(4),
    .W(TL_SINK_WIDTH  )
) u_d_sink (
    .out(d_sink),
    .sel(d_sel),
    .in({r2d_sink , b2d_sink , a2d_sink , c2d_sink })
);

atctlc2axi500_sink_id_pool #(
    .SINK_WIDTH(TL_SINK_WIDTH)
)u_sink_id_pool(
    .clk(clk),
    .resetn(resetn),
    .busy(sink_busy),
    .req_valid(sink_req_valid),
    .next_sink(next_sink),
    .rsp_valid(sink_rsp_valid),
    .rsp_sink(d_sink),
    .ack_valid(sink_ack_valid),
    .ack_sink(e_sink)
);

assign r_in_burst_en = rvalid & rready;
assign r_in_burst_nx = ~rlast;
always @(posedge clk or negedge resetn)begin
    if(!resetn)begin
        r_in_burst <= 1'b0;
    end
    else if(r_in_burst_en)begin
        r_in_burst <= r_in_burst_nx;
    end
end

generate
genvar i;
for (i=0; i<TL_IDLEN; i=i+1) begin : gen_c2w_busys_ent
    wire we;
    wire set;
    wire clr;
    wire wdata;
    assign set = c2w_valid & c2w_ready & c_source_onehot[i];
    assign clr = bvalid & bready & b2d_source_onehot[i];
    assign we = set | clr;
    assign wdata = ~clr;
    always@(posedge clk or negedge resetn)begin
        if(!resetn)begin
            c2w_busys[i] <= 1'b0;
        end
        else if(we)begin
            c2w_busys[i] <= wdata;
        end
    end
end

for (i=0; i<TL_IDLEN; i=i+1) begin : gen_c2w_sizes_ent
    wire we;
    assign we = c2w_valid & c2w_ready & c_source_onehot[i];
    always@(posedge clk or negedge resetn)begin
        if(!resetn)begin
            c2x_sizes[TL_SIZE_WIDTH*i+:TL_SIZE_WIDTH] <= {TL_SIZE_WIDTH{1'b0}};
        end
        else if(we)begin
            c2x_sizes[TL_SIZE_WIDTH*i+:TL_SIZE_WIDTH] <= c_size;
        end
    end
end

for (i=0; i<TL_IDLEN; i=i+1) begin : gen_a2x_sizes_ent
    wire we;
    assign we = (a2r_valid & a2r_ready | a2w_valid & a2w_ready) & a_source_onehot[i];
    always@(posedge clk or negedge resetn)begin
        if(!resetn)begin
            a2x_sizes[TL_SIZE_WIDTH*i+:TL_SIZE_WIDTH] <= {TL_SIZE_WIDTH{1'b0}};
        end
        else if(we)begin
            a2x_sizes[TL_SIZE_WIDTH*i+:TL_SIZE_WIDTH] <= a_size;
        end
    end
end

for (i=0; i<TL_IDLEN; i=i+1) begin : gen_a2r_sinks_ent
    wire we;
    assign we = a2r_valid & a2r_ready & a_source_onehot[i];
    always@(posedge clk or negedge resetn)begin
        if(!resetn)begin
            a2r_sinks[TL_SINK_WIDTH*i+:TL_SINK_WIDTH] <= {TL_SINK_WIDTH{1'b0}};
        end
        else if(we)begin
            a2r_sinks[TL_SINK_WIDTH*i+:TL_SINK_WIDTH] <= next_sink;
        end
    end
end

for (i=0; i<TL_IDLEN; i=i+1) begin : gen_a2r_acq_ent
    wire we;
    assign we = a2r_valid & a2r_ready & a_source_onehot[i];
    always@(posedge clk or negedge resetn)begin
        if(!resetn)begin
            a2x_is_acquireblocks[i] <= 1'b0;
        end
        else if(we)begin
            a2x_is_acquireblocks[i] <= a_op_acquireblock;
        end
    end
end


for (i=0; i<TL_IDLEN; i=i+1) begin : gen_a2w_busys_ent
    wire we;
    wire set;
    wire clr;
    wire wdata;
    assign set = a2w_valid & a2w_ready & a_source_onehot[i];
    assign clr = bvalid & bready & b2d_source_onehot[i];
    assign we = set | clr;
    assign wdata = ~clr;
    always@(posedge clk or negedge resetn)begin
        if(!resetn)begin
            a2w_busys[i] <= 1'b0;
        end
        else if(we)begin
            a2w_busys[i] <= wdata;
        end
    end
end

for (i=0; i<TL_IDLEN; i=i+1) begin : gen_a2r_busys_ent
    wire we;
    wire set;
    wire clr;
    wire wdata;
    assign set = a2r_valid & a2r_ready & a_source_onehot[i];
    assign clr = rvalid & rready & rlast & r2d_source_onehot[i];
    assign we = set | clr;
    assign wdata = ~clr;
    always@(posedge clk or negedge resetn)begin
        if(!resetn)begin
            a2r_busys[i] <= 1'b0;
        end
        else if(we)begin
            a2r_busys[i] <= wdata;
        end
    end
end
endgenerate

endmodule



`include "global.inc"

module n22_gnrl_pipe_stage # (
  parameter CUT_READY = 0,
  parameter DP = 1,
  parameter DW = 32
) (
  input           i_vld,
  output          i_rdy,
  input  [DW-1:0] i_dat,
  output          o_vld,
  input           o_rdy,
  output [DW-1:0] o_dat,

  input           clk,
  input           rst_n
);

  genvar i;
  generate

  if(DP == 0) begin: gen_dp_eq_0

      assign o_vld = i_vld;
      assign i_rdy = o_rdy;
      assign o_dat = i_dat;

  end
  else begin: gen_dp_gt_0

      wire vld_set;
      wire vld_clr;
      wire vld_ena;
      wire vld_r;
      wire vld_nxt;

      assign vld_set = i_vld & i_rdy;
      assign vld_clr = o_vld & o_rdy;

      assign vld_ena = vld_set | vld_clr;
      assign vld_nxt = vld_set | (~vld_clr);

      n22_gnrl_dfflr #(1) vld_dfflr (vld_ena, vld_nxt, vld_r, clk, rst_n);

      assign o_vld = vld_r;

      n22_gnrl_dffl #(DW) dat_dfflr (vld_set, i_dat, o_dat, clk);

      if(CUT_READY == 1) begin:gen_cut_ready
          assign i_rdy = (~vld_r);
      end
      else begin:gen_no_cut_ready
          assign i_rdy = (~vld_r) | vld_clr;
      end
  end
  endgenerate


endmodule


module n22_gnrl_sync # (
  parameter DP = 2,
  parameter DW = 32
) (
  input  [DW-1:0] din_a,
  output [DW-1:0] dout,

  input           rst_n,
  input           clk
);

  wire [DW-1:0] sync_dat [DP-1:0];

  genvar i;

  generate
    for(i=0;i<DP;i=i+1) begin:gen_sync
      if(i==0) begin:gen_i_is_0
        n22_gnrl_dffr #(DW) sync_dffr(din_a,         sync_dat[0], clk, rst_n);
      end
      else begin:gen_i_is_not_0
        n22_gnrl_dffr #(DW) sync_dffr(sync_dat[i-1], sync_dat[i], clk, rst_n);
      end
    end
  endgenerate

  assign dout = sync_dat[DP-1];

endmodule


module n22_gnrl_cdc_rx
# (
  parameter DW = 32,
  parameter SYNC_DP = 2
) (
  input  i_vld_a,
  output i_rdy,
  input  [DW-1:0] i_dat,
  output o_vld,
  input  o_rdy,
  output [DW-1:0] o_dat,

  input  clk,
  input  rst_n
);

wire i_vld_sync;
n22_gnrl_sync #(.DP(SYNC_DP), .DW(1)) u_i_vld_sync (
     .clk   (clk),
     .rst_n (rst_n),
     .din_a (i_vld_a),
     .dout  (i_vld_sync)
    );

wire i_vld_sync_r;
n22_gnrl_dffr #(1) i_vld_sync_dffr(i_vld_sync, i_vld_sync_r, clk, rst_n);
wire i_vld_sync_nedge = (~i_vld_sync) & i_vld_sync_r;

wire buf_rdy;
wire i_rdy_r;
wire i_rdy_set = buf_rdy & i_vld_sync & (~i_rdy_r);
wire i_rdy_clr = i_vld_sync_nedge;
wire i_rdy_ena = i_rdy_set |   i_rdy_clr;
wire i_rdy_nxt = i_rdy_set | (~i_rdy_clr);
n22_gnrl_dfflr #(1) i_rdy_dfflr(i_rdy_ena, i_rdy_nxt, i_rdy_r, clk, rst_n);
assign i_rdy = i_rdy_r;


wire buf_vld_r;
wire [DW-1:0] buf_dat_r;

wire buf_dat_ena = i_rdy_set;
n22_gnrl_dfflr #(DW) buf_dat_dfflr(buf_dat_ena, i_dat, buf_dat_r, clk, rst_n);

wire buf_vld_set = buf_dat_ena;
wire buf_vld_clr = o_vld & o_rdy;
wire buf_vld_ena = buf_vld_set | buf_vld_clr;
wire buf_vld_nxt = buf_vld_set | (~buf_vld_clr);
n22_gnrl_dfflr #(1) buf_vld_dfflr(buf_vld_ena, buf_vld_nxt, buf_vld_r, clk, rst_n);
assign buf_rdy = (~buf_vld_r);

assign o_vld = buf_vld_r;
assign o_dat = buf_dat_r;

endmodule

module n22_gnrl_cdc_tx
# (
  parameter DW = 32,
  parameter SYNC_DP = 2
) (
  input  i_vld,
  output i_rdy,
  input  [DW-1:0] i_dat,

  output o_vld,
  input  o_rdy_a,
  output [DW-1:0] o_dat,

  input  clk,
  input  rst_n
);

wire o_rdy_sync;

n22_gnrl_sync #(
    .DP(SYNC_DP),
    .DW(1)
) u_o_rdy_sync (
         .clk   (clk),
         .rst_n (rst_n),
         .din_a (o_rdy_a),
         .dout  (o_rdy_sync)
        );

wire vld_r;
wire [DW-1:0] dat_r;

wire vld_set = i_vld & i_rdy;
wire vld_clr = o_vld & o_rdy_sync;
wire vld_ena = vld_set | vld_clr;
wire vld_nxt = vld_set | (~vld_clr);
n22_gnrl_dfflr #(1) vld_dfflr(vld_ena, vld_nxt, vld_r, clk, rst_n);
n22_gnrl_dfflr #(DW) dat_dfflr(vld_set, i_dat, dat_r, clk, rst_n);

wire o_rdy_sync_r;
n22_gnrl_dffr #(1) o_rdy_sync_dffr(o_rdy_sync, o_rdy_sync_r, clk, rst_n);
wire o_rdy_nedge = (~o_rdy_sync) & o_rdy_sync_r;

wire nrdy_r;
wire nrdy_set = vld_set;
wire nrdy_clr = o_rdy_nedge;
wire nrdy_ena = nrdy_set | nrdy_clr;
wire nrdy_nxt = nrdy_set | (~nrdy_clr);
n22_gnrl_dfflr #(1) buf_nrdy_dfflr(nrdy_ena, nrdy_nxt, nrdy_r, clk, rst_n);

assign o_vld = vld_r;
assign o_dat = dat_r;

assign i_rdy = (~nrdy_r) | nrdy_clr;

endmodule


module n22_gnrl_bypbuf # (
  parameter DP = 8,
  parameter DW = 32
) (
  input           i_vld,
  output          i_rdy,
  input  [DW-1:0] i_dat,

  output          o_vld,
  input           o_rdy,
  output [DW-1:0] o_dat,

  input           clk,
  input           rst_n
);


  wire          fifo_i_vld;
  wire          fifo_i_rdy;
  wire [DW-1:0] fifo_i_dat;

  wire          fifo_o_vld;
  wire          fifo_o_rdy;
  wire [DW-1:0] fifo_o_dat;

  n22_gnrl_fifo # (
       .DP(DP),
       .DW(DW),
       .CUT_READY(1)
  ) u_bypbuf_fifo(
    .i_vld   (fifo_i_vld),
    .i_rdy   (fifo_i_rdy),
    .i_dat   (fifo_i_dat),
    .o_vld   (fifo_o_vld),
    .o_rdy   (fifo_o_rdy),
    .o_dat   (fifo_o_dat),
    .clk     (clk  ),
    .rst_n   (rst_n)
  );


  assign i_rdy = fifo_i_rdy;

  wire byp = i_vld & o_rdy & (~fifo_o_vld);

  assign fifo_o_rdy = o_rdy;

  assign o_vld = fifo_o_vld | i_vld;

  assign o_dat = fifo_o_vld ? fifo_o_dat : i_dat;

  assign fifo_i_dat  = i_dat;

  assign fifo_i_vld = i_vld & (~byp);


endmodule


module n22_gnrl_fifo # (
  parameter CUT_READY = 0,
  parameter MSKO = 0,
  parameter DP   = 8,
  parameter DW   = 32
) (

  input           i_vld,
  output          i_rdy,
  input  [DW-1:0] i_dat,
  output          o_vld,
  input           o_rdy,
  output [DW-1:0] o_dat,

  input           clk,
  input           rst_n
);

genvar i;
generate

  if(DP == 0) begin: gen_dp_eq1

     assign o_vld = i_vld;
     assign i_rdy = o_rdy;
     assign o_dat = i_dat;

  end
  else begin: gen_dp_gt0

    wire [DW-1:0] fifo_rf_r [DP-1:0];
    wire [DP-1:0] fifo_rf_en;

    wire wen = i_vld & i_rdy;
    wire ren = o_vld & o_rdy;

    wire [DP-1:0] rptr_vec_nxt;
    wire [DP-1:0] rptr_vec_r;
    wire [DP-1:0] wptr_vec_nxt;
    wire [DP-1:0] wptr_vec_r;

    if(DP == 1) begin:gen_rptr_dp_1
      assign rptr_vec_nxt = 1'b1;
    end
    else begin:gen_rptr_dp_not_1
      assign rptr_vec_nxt =
          rptr_vec_r[DP-1] ? {{DP-1{1'b0}}, 1'b1} :
                          (rptr_vec_r << 1);
    end

    if(DP == 1) begin:gen_wptr_dp_1
      assign wptr_vec_nxt = 1'b1;
    end
    else begin:gen_wptr_dp_not_1
      assign wptr_vec_nxt =
          wptr_vec_r[DP-1] ? {{DP-1{1'b0}}, 1'b1} :
                          (wptr_vec_r << 1);
    end

    n22_gnrl_dfflrs #(1)    rptr_vec_0_dfflrs  (ren, rptr_vec_nxt[0]     , rptr_vec_r[0]     , clk, rst_n);
    n22_gnrl_dfflrs #(1)    wptr_vec_0_dfflrs  (wen, wptr_vec_nxt[0]     , wptr_vec_r[0]     , clk, rst_n);
    if(DP > 1) begin:gen_dp_gt1
    n22_gnrl_dfflr  #(DP-1) rptr_vec_31_dfflr  (ren, rptr_vec_nxt[DP-1:1], rptr_vec_r[DP-1:1], clk, rst_n);
    n22_gnrl_dfflr  #(DP-1) wptr_vec_31_dfflr  (wen, wptr_vec_nxt[DP-1:1], wptr_vec_r[DP-1:1], clk, rst_n);
    end

    wire [DP:0] i_vec;
    wire [DP:0] o_vec;
    wire [DP:0] vec_nxt;
    wire [DP:0] vec_r;

    wire vec_en = (ren ^ wen );
    assign vec_nxt = wen ? {vec_r[DP-1:0], 1'b1} : (vec_r >> 1);

    n22_gnrl_dfflrs #(1)  vec_0_dfflrs     (vec_en, vec_nxt[0]     , vec_r[0]     ,     clk, rst_n);
    n22_gnrl_dfflr  #(DP) vec_31_dfflr     (vec_en, vec_nxt[DP:1], vec_r[DP:1],     clk, rst_n);

    assign i_vec = {1'b0,vec_r[DP:1]};
    assign o_vec = {1'b0,vec_r[DP:1]};

    if(DP == 1) begin:gen_cut_dp_eq1
        if(CUT_READY == 1) begin:gen_cut_ready
          assign i_rdy = (~i_vec[DP-1]);
        end
        else begin:gen_no_cut_ready
          assign i_rdy = (~i_vec[DP-1]) | ren;
        end
    end
    else begin : no_cut_dp_gt1
      assign i_rdy = (~i_vec[DP-1]);
    end


    for (i=0; i<DP; i=i+1) begin:gen_fifo_rf
      assign fifo_rf_en[i] = wen & wptr_vec_r[i];
      n22_gnrl_dffl  #(DW) fifo_rf_dffl (fifo_rf_en[i], i_dat, fifo_rf_r[i], clk);
    end

    integer j;
    reg [DW-1:0] mux_rdat;
    always @*
    begin : rd_port_PROC
      mux_rdat = {DW{1'b0}};
      for(j=0; j<DP; j=j+1) begin
        mux_rdat = mux_rdat | ({DW{rptr_vec_r[j]}} & fifo_rf_r[j]);
      end
    end

    if(MSKO == 1) begin:gen_mask_output
        assign o_dat = {DW{o_vld}} & mux_rdat;
    end
    else begin:gen_no_mask_output
        assign o_dat = mux_rdat;
    end

    assign o_vld = (o_vec[0]);

  end
endgenerate

endmodule


module n22_gnrl_stck # (
  parameter DP   = 8,
  parameter DW   = 32
) (

  input           i_wen,
  input  [DW-1:0] i_dat,
  input           o_ren,
  output [DW-1:0] o_dat,

  input           clk,
  input           rst_n
);



  wire [DW-1:0] stck_rf_r [DP-1:0];
  wire [DP-1:0] stck_rf_en;

  wire [DP:0] i_vec;
  wire [DP:0] o_vec;
  wire [DP:0] vec_nxt;
  wire [DP:0] vec_r;

  wire vec_en = (o_ren ^ i_wen );
  assign vec_nxt = i_wen ? (vec_r << 1) : (vec_r >> 1);

  n22_gnrl_dfflrs #(1)  vec_0_dfflrs(vec_en, vec_nxt[0]   , vec_r[0]   , clk, rst_n);
  n22_gnrl_dfflr  #(DP) vec_dp_dfflr(vec_en, vec_nxt[DP:1], vec_r[DP:1], clk, rst_n);


  assign i_vec = vec_r;
  assign o_vec = (vec_r >> 1);

  genvar i;
  generate
    for (i=0; i<DP; i=i+1) begin:gen_stck_rf
      assign stck_rf_en[i] = i_wen & i_vec[i];
      n22_gnrl_dffl  #(DW) stck_rf_dffl (stck_rf_en[i], i_dat, stck_rf_r[i], clk);
    end
  endgenerate

  integer j;
  reg [DW-1:0] mux_rdat;
  always @*
  begin : rd_port_PROC
    mux_rdat = {DW{1'b0}};
    for(j=0; j<DP; j=j+1) begin
      mux_rdat = mux_rdat | ({DW{o_vec[j]}} & stck_rf_r[j]);
    end
  end

  assign o_dat = mux_rdat;


endmodule


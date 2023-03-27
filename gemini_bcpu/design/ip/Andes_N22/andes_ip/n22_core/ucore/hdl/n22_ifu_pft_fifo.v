
`include "global.inc"

`ifdef N22_HAS_PREFETCH
module n22_ifu_pft_fifo # (
  parameter DP   = 8,
  parameter DW   = 32
) (

  input           i_flush,

  input           i_vld,
  output          i_rdy,
  output          prdt_i_rdy,
  input  [DW-1:0] i_dat,
  output          o_vld,
  input           o_rdy,
  output [DW-1:0] o_dat,

  input           clk,
  input           rst_n
);


    wire [DW-1:0] s0 [DP-1:0];
    wire [DP-1:0] s1;

    wire s2 = (i_vld & i_rdy);
    wire s3 = (o_vld & o_rdy);

    wire [DP-1:0] s4;
    wire [DP-1:0] s5;
    wire [DP-1:0] s6;
    wire [DP-1:0] s7;

    assign s4 =
          i_flush ? { {DP-1{1'b0}}, 1'b1 } :
          s5[DP-1] ? {{DP-1{1'b0}}, 1'b1} :
                          (s5 << 1);

    assign s6 =
          i_flush ? { {DP-1{1'b0}}, 1'b1 } :
          s7[DP-1] ? {{DP-1{1'b0}}, 1'b1} :
                          (s7 << 1);

    n22_gnrl_dfflrs #(1)    rptr_vec_0_dfflrs  ((s3 | i_flush), s4[0]     , s5[0]     , clk, rst_n);
    n22_gnrl_dfflrs #(1)    wptr_vec_0_dfflrs  ((s2 | i_flush), s6[0]     , s7[0]     , clk, rst_n);
    n22_gnrl_dfflr  #(DP-1) rptr_vec_31_dfflr  ((s3 | i_flush), s4[DP-1:1], s5[DP-1:1], clk, rst_n);
    n22_gnrl_dfflr  #(DP-1) wptr_vec_31_dfflr  ((s2 | i_flush), s6[DP-1:1], s7[DP-1:1], clk, rst_n);

    wire [DP:0] s8;
    wire [DP:0] s9;
    wire [DP:0] s10;
    wire [DP:0] s11;

    wire s12 = (s3 ^ s2 ) | i_flush;
    assign s10 = i_flush ? { {DP{1'b0}}, 1'b1 } : s2 ? {s11[DP-1:0], 1'b1} : (s11 >> 1);

    n22_gnrl_dfflrs #(1)  vec_0_dfflrs     (s12, s10[0]     , s11[0]     ,     clk, rst_n);
    n22_gnrl_dfflr  #(DP) vec_31_dfflr     (s12, s10[DP:1], s11[DP:1],     clk, rst_n);

    assign s8 = {1'b0,s11[DP:1]};
    assign s9 = {1'b0,s11[DP:1]};

    assign i_rdy = (~s8[DP-1]) | s3;
    assign prdt_i_rdy = (~s8[DP-2]) | s3;


    genvar i;
    generate

      for (i=0; i<DP; i=i+1) begin:gen_fifo_rf
        assign s1[i] = s2 & s7[i];
        n22_gnrl_dfflr  #(DW) fifo_rf_dfflr (s1[i], i_dat, s0[i], clk, rst_n);
      end

    endgenerate

    integer s13;
    reg [DW-1:0] s14;
    always @*
    begin : rd_port_PROC
      s14 = {DW{1'b0}};
      for(s13=0; s13<DP; s13=s13+1) begin
        s14 = s14 | ({DW{s5[s13]}} & s0[s13]);
      end
    end

    assign o_dat = s14;

    assign o_vld = (s9[0]);


endmodule

`endif

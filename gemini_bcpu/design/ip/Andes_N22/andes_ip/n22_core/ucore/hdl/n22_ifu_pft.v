
`include "global.inc"

`ifdef N22_HAS_PREFETCH

module n22_ifu_pft #(
  parameter AW = 32,
  parameter DW = 32
)(
  output pft_no_outs,

  input  ifu_icb_cmd_valid,
  output ifu_icb_cmd_ready,
  input  [AW-1:0] ifu_icb_cmd_addr,
  input  ifu_icb_cmd_dmode,
  input  ifu_icb_cmd_vmode,
  input  ifu_icb_cmd_mmode,
  input  ifu_icb_cmd_seq,

  output ifu_icb_rsp_valid,
  output ifu_icb_rsp_err,
  output ifu_icb_rsp_pmperr,
  output [DW-1:0] ifu_icb_rsp_rdata,

  output pft_icb_cmd_valid,
  input  pft_icb_cmd_ready,
  output [AW-1:0] pft_icb_cmd_addr,
  output pft_icb_cmd_dmode,
  output pft_icb_cmd_vmode,
  output pft_icb_cmd_mmode,
  output pft_icb_cmd_seq,

  input  pft_icb_rsp_valid,
  input  pft_icb_rsp_err,
  input  pft_icb_rsp_pmperr,
  input  [DW-1:0] pft_icb_rsp_rdata,

  output pft_active,

  input  clk,
  input  rst_n
  );



  wire s0;
  wire s1;
  wire [AW-1:0] s2;
  wire s3;
  wire s4;
  wire s5;
  wire s6;

  localparam CMD_PACK_W = (AW + 4);

  wire [CMD_PACK_W-1:0]s7;
  wire [CMD_PACK_W-1:0]s8;

  assign s8 = {
                             ifu_icb_cmd_addr
                            ,ifu_icb_cmd_dmode
                            ,ifu_icb_cmd_vmode
                            ,ifu_icb_cmd_mmode
                            ,ifu_icb_cmd_seq
                          };

  assign {
                             s2
                            ,s3
                            ,s4
                            ,s5
                            ,s6
                          } = s7;


  n22_gnrl_bypbuf # (
    .DP(1),
    .DW(CMD_PACK_W)
  ) u_ifu_cmd_bypbuf(
      .i_vld   (ifu_icb_cmd_valid),
      .i_rdy   (ifu_icb_cmd_ready),

      .o_vld   (s0),
      .o_rdy   (s1),

      .i_dat   (s8),
      .o_dat   (s7),

      .clk     (clk  ),
      .rst_n   (rst_n)
  );




  wire s9;
  wire s10;

  wire s11;
  wire s12 = pft_icb_cmd_valid & pft_icb_cmd_ready;
  wire s13 = pft_icb_rsp_valid;
  wire s14 = s12;
  wire s15 = s13;
  wire s16 = s14 | s15;
  wire s17 = s14 | (~s15);

  n22_gnrl_dfflr #(1) out_flag_dfflr (s16, s17, s11, clk, rst_n);

  wire s18   = (~s11);
  assign pft_no_outs = (~pft_active);


  wire s19 = s18 | (s15);


  wire s20;
  wire s21 = s0 & s1;
  wire s22 = ifu_icb_rsp_valid;
  wire s23 = s21;
  wire s24 = s22;
  wire s25 = s23 | s24;
  wire s26 = s23 | (~s24);

  n22_gnrl_dfflr #(1) i_icb_out_flag_dfflr (s25, s26, s20, clk, rst_n);

  wire s27   = (~s20);


  wire s28 = s27 | (s24);



  wire s29;
  wire s30;

  wire s31;
  wire s32;
  wire s33;
  wire s34;

  wire s35 = (~s6) & s28;

  wire s36  = 1'b1;

  assign s1 =
       (s36 ? s32 : 1'b1)
     & (s35 ? s30 : 1'b1);

  assign s31        = s36  & s0 & (s35 ? s30 : 1'b1);
  assign s29 = s35 & s0 & (s36  ? s32        : 1'b1);


  n22_gnrl_pipe_stage # (
   .CUT_READY(0),
   .DP(1),
   .DW(1)
  ) u_e1_stage (
    .i_vld(s31),
    .i_rdy(s32),
    .i_dat(1'b0),
    .o_vld(s33),
    .o_rdy(s34),
    .o_dat(),

    .clk  (clk  ),
    .rst_n(rst_n)
   );

  wire s37 = s29 & s30;

  wire s38;
  wire s39;

  assign ifu_icb_rsp_valid = s33 & s38;

  assign s34 = s38;

  assign s39 = s33;

  wire s40 = s37;

  n22_ifu_pft_fifo # (
    .DP  (2),
    .DW  (DW+2)
  ) u_n22_ifu_pft_fifo (
    .i_flush(s40),

    .i_vld  (pft_icb_rsp_valid),
    .i_rdy  (s9),
    .prdt_i_rdy  (s10),
    .i_dat  ({pft_icb_rsp_pmperr, pft_icb_rsp_err, pft_icb_rsp_rdata}),
    .o_vld  (s38),
    .o_rdy  (s39),
    .o_dat  ({ifu_icb_rsp_pmperr, ifu_icb_rsp_err, ifu_icb_rsp_rdata}),
    .clk    (clk),
    .rst_n  (rst_n)
  );


  wire [AW-1:0] s41;
  wire s42  = s12 & ( s35);
  wire s43  = s12 & (~s35);
  wire s44  = s42 | s43;
  wire [AW-1:0] s45 = ({s41[AW-1:2],2'b0} + {{AW-3{1'b0}},3'd4});
  wire [AW-1:0] s46 = s42 ? {s2[AW-1:2],2'b0} : s45;
  n22_gnrl_dfflr #(AW) addr_dfflr (s44, s46, s41, clk, rst_n);

  wire s47;
  wire s48;

  wire s49 = s5;
  wire s50 = s3;

  wire s51 = s42;
  wire s52 = s42;

  n22_gnrl_dfflr #(1) dmode_dfflr (s52, s50, s48, clk, rst_n);
  n22_gnrl_dfflr #(1) mmode_dfflr (s51, s49, s47, clk, rst_n);

  assign pft_icb_cmd_addr  = s35 ? s2  : s45;
  assign pft_icb_cmd_dmode = s35 ? s3 : s48;
  assign pft_icb_cmd_mmode = s35 ? s5 : s47;
  assign pft_icb_cmd_vmode = s35 ? s4 : 1'b0;

  wire s53;
  wire s54 = s42;
  wire s55 = s54;
  wire s56 = s54;
  n22_gnrl_dfflr #(1) valid_dfflr (s55, s56, s53, clk, rst_n);

  wire s57;
  wire s58;

  assign s57 = s35 ? s29 : s53;
  assign s30   = s58;


  wire s59 = (s35 ? 1'b1 : s10) & s19;
  assign pft_icb_cmd_seq       = ~s35;
  assign pft_icb_cmd_valid     = s59 & s57;
  assign s58 = s59 & pft_icb_cmd_ready;

  assign pft_active = (~s18)
                    | s33
                    | pft_icb_cmd_valid
                    | pft_icb_rsp_valid
                    | ifu_icb_cmd_valid
                    | s0
                    | ifu_icb_rsp_valid
                    ;

`ifndef FPGA_SOURCE
`ifndef SYNTHESIS
//synopsys translate_off






//synopsys translate_on
`endif
`endif


endmodule
`endif


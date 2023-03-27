
`include "global.inc"

module n22_tmr_top(
  output  tmr_active,
  input   clk_aon,
  input   clk,

  input   rst_n,

  input           i_icb_cmd_valid,
  output          i_icb_cmd_ready,
  input  [`N22_ADDR_SIZE-1:0] i_icb_cmd_addr,
  input           i_icb_cmd_read,
  input  [32-1:0] i_icb_cmd_wdata,
  input  [4 -1:0] i_icb_cmd_wmask,
  input           i_icb_cmd_mmode,
  input           i_icb_cmd_dmode,

  output          i_icb_rsp_valid,
  input           i_icb_rsp_ready,
  output [32-1:0] i_icb_rsp_rdata,
  output          i_icb_rsp_err,


  output  tmr_irq,
  output  sft_irq,

  input   rtc_toggle_a,

  input   dbg_stoptime
);

  wire          tmr_stop;

  wire          icb_rsp_valid;
  wire          icb_rsp_ready;
  wire [32-1:0] icb_rsp_rdata;

  `ifndef N22_TMR_PRIVATE
  n22_gnrl_fifo # (
        .CUT_READY (1),
        .MSKO      (0),
        .DP  (1),
        .DW  (32)
  ) u_icb_rsp_fifo (
        .i_vld(icb_rsp_valid),
        .i_rdy(icb_rsp_ready),
        .i_dat(icb_rsp_rdata),
        .o_vld(i_icb_rsp_valid),
        .o_rdy(i_icb_rsp_ready),
        .o_dat(i_icb_rsp_rdata),

        .clk  (clk),
        .rst_n(rst_n)
  );
  `endif
  `ifdef N22_TMR_PRIVATE
  assign icb_rsp_ready   = i_icb_rsp_ready;
  assign i_icb_rsp_valid = icb_rsp_valid;
  assign i_icb_rsp_rdata = icb_rsp_rdata;
  `endif


  wire s0 = tmr_stop | dbg_stoptime;

  wire s1;

  n22_gnrl_sync # (
  .DP(`N22_ASYNC_FF_LEVELS),
  .DW(1)
  ) u_rtctoggle_sync(
      .din_a    (rtc_toggle_a),
      .dout     (s1),
      .clk      (clk_aon     ),
      .rst_n    (rst_n)
  );


  wire s2 = s1;


  wire s3 = s2 & (~s0);

  wire s4;
  n22_gnrl_dffr #(1) toggle_dffr (s3, s4, clk_aon, rst_n);
  wire s5 = s3 ^ s4;
  wire s6 = s5;


  n22_tmr_main  u_n22_tmr_main(

  .clk             (clk),
  .rst_n           (rst_n  ),

  .icb_cmd_valid   (i_icb_cmd_valid),
  .icb_cmd_ready   (i_icb_cmd_ready),
  .icb_cmd_addr    (i_icb_cmd_addr ),
  .icb_cmd_read    (i_icb_cmd_read ),
  .icb_cmd_wdata   (i_icb_cmd_wdata),

  .icb_rsp_valid   (icb_rsp_valid),
  .icb_rsp_ready   (icb_rsp_ready),
  .icb_rsp_rdata   (icb_rsp_rdata),

  .mtime_r         (),
  .mtimeh_r        (),
  .tmr_stop        (tmr_stop),

  .sft_irq         (sft_irq),
  .tmr_irq         (tmr_irq),
  .io_rtctick      (s6)

  );

  assign tmr_active = i_icb_cmd_valid | i_icb_rsp_valid |  icb_rsp_valid |
                     ((~s0) & s6);
  assign i_icb_rsp_err = 1'b0;

endmodule

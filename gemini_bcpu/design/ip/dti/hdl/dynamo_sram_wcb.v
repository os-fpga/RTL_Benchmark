//------------------------------------------------------------------------------------------------------------------
//    Copyright (C) 2014 by Dolphin Technology
//    All right reserved.
//
//    Copyright Notification
//    No part may be reproduced except as authorized by written permission.
//
//    Module: dynamo.dynamo_sram_wcb
//    Company: Dolphin Technology
//    Project: Memory Controller
//    Author: tung
//    Date: 01/16/22
//-------------------------------------------------------------------------------------------------------------------

`include "dti_global_defines.vh"
module dynamo_sram_wcb #(
  parameter BUFF_NUM   = `CFG_DC_ROUTE_NUM,
  parameter ADDR_WIDTH = `CFG_WCB_ADDR_WIDTH,
  parameter DATA_WIDTH = `CFG_WCB_BUF_WIDTH,
  parameter RWM_WIDTH  = `CFG_SRAM_RWM_WIDTH
) (
  // Port Declarations
  input           [BUFF_NUM*ADDR_WIDTH-1:0]  a_r_bf   ,
  input           [BUFF_NUM*ADDR_WIDTH-1:0]  a_w_bf   ,
  input           [BUFF_NUM-1:0]             ce_n_r_bf,
  input           [BUFF_NUM-1:0]             ce_n_w_bf,
  input                                      clk_r    ,
  input                                      clk_w    ,
  input           [BUFF_NUM*DATA_WIDTH-1:0]  di_bf    ,
  input           [RWM_WIDTH-1:0]            t_rwm    ,
  output wire     [BUFF_NUM*DATA_WIDTH-1:0]  do_bf
);
  `include "dti_global_params.vh"
  localparam  SRAM_NUM  = DATA_WIDTH / 72;

  wire        vdd_wire  ;
  wire        vss_wire  ;

  genvar i;
  generate
    for (i=0; i<BUFF_NUM; i=i+1) begin : WRITE_BUFFER
      // dti_2pr_tm40ulvt_328x72_2ww1x_hc
      dti_2pr_tm16ffcll_576x72_t4bw2x_m_hc
      wcb_buff[SRAM_NUM-1:0](
        .VDD                ( vdd_wire                               ),
        .VSS                ( vss_wire                               ),
        .DO                 ( do_bf     [i*DATA_WIDTH +: DATA_WIDTH] ),
        .A_R                ( a_r_bf    [i*ADDR_WIDTH +: ADDR_WIDTH] ),
        .A_W                ( a_w_bf    [i*ADDR_WIDTH +: ADDR_WIDTH] ),
        .DI                 ( di_bf     [i*DATA_WIDTH +: DATA_WIDTH] ),
        .CE_N_R             ( ce_n_r_bf [i]                          ),
        .CE_N_W             ( ce_n_w_bf [i]                          ),
        .T_RWM_R            ( t_rwm                                  ),
        .T_RWM_W            ( t_rwm                                  ),
        .CLK_R              ( clk_r                                  ),
        .CLK_W              ( clk_w                                  ),
        .T_A_R              ( 10'b0                                  ),
        .T_A_W              ( 10'b0                                  ),
        .T_DI               ( 72'b0                                  ),
        .T_BE_N             ( 1'b1                                   ),
        .T_CE_N_R           ( 1'b1                                   ),
        .T_CE_N_W           ( 1'b1                                   ),
        .BWE_N              ( 72'h0                                  ),
        .T_BWE_N            ( 72'hFFFF_FFFF_FFFF_FFFF_FF             )
      );
    end
  endgenerate

endmodule // dynamo_sram_wcb


//-----------------------------------------------------------------------------------------------------------
//    Copyright (C) 2020 by Dolphin Technology
//    All right reserved.
//
//    Copyright Notification
//    No part may be reproduced except as authorized by written permission.
//
//    Module: dynamo_cypress.dynamo_sram
//    Company: Dolphin Technology
//    Author: tung
//    Date: 08:57:35 - 04/04/22
//-----------------------------------------------------------------------------------------------------------
`include "dti_global_defines.vh"
module dynamo_sram #(
  parameter RCB_BUFF_NUM   = `CFG_DC_ROUTE_NUM,
  parameter RCB_ADDR_WIDTH = `CFG_RCB_ADDR_WIDTH,
  parameter RCB_DATA_WIDTH = `CFG_RCB_BUF_WIDTH,
  parameter WCB_BUFF_NUM   = `CFG_DC_ROUTE_NUM,
  parameter WCB_ADDR_WIDTH = `CFG_WCB_ADDR_WIDTH,
  parameter WCB_DATA_WIDTH = `CFG_WCB_BUF_WIDTH,
  parameter RWM_WIDTH      = `CFG_SRAM_RWM_WIDTH
)
( 
  // Port Declarations
  input   wire                                               dram_clk, 
  input   wire                                               port_clk, 
  input   wire    [ RCB_BUFF_NUM * RCB_DATA_WIDTH - 1 : 0 ]  rcb_di_bf, 
  input   wire    [ RCB_BUFF_NUM * RCB_ADDR_WIDTH - 1 : 0 ]  rcb_ra_bf, 
  input   wire    [ RCB_BUFF_NUM - 1 : 0 ]                   rcb_re_n_bf, 
  input   wire    [ RCB_BUFF_NUM * RCB_ADDR_WIDTH - 1 : 0 ]  rcb_wa_bf, 
  input   wire    [ RCB_BUFF_NUM - 1 : 0 ]                   rcb_we_n_bf, 
  input   wire    [ RWM_WIDTH - 1 : 0 ]                      reg_rcb_t_rwm, 
  input   wire    [ RWM_WIDTH - 1 : 0 ]                      reg_wcb_t_rwm, 
  input   wire    [ WCB_BUFF_NUM * WCB_DATA_WIDTH - 1 : 0 ]  wcb_di_bf, 
  input   wire    [ WCB_BUFF_NUM * WCB_ADDR_WIDTH - 1 : 0 ]  wcb_ra_bf, 
  input   wire    [ WCB_BUFF_NUM - 1 : 0 ]                   wcb_re_n_bf, 
  input   wire    [ WCB_BUFF_NUM * WCB_ADDR_WIDTH - 1 : 0 ]  wcb_wa_bf, 
  input   wire    [ WCB_BUFF_NUM - 1 : 0 ]                   wcb_we_n_bf, 
  output  wire    [ RCB_BUFF_NUM * RCB_DATA_WIDTH - 1 : 0 ]  rcb_do_bf, 
  output  wire    [ WCB_BUFF_NUM * WCB_DATA_WIDTH - 1 : 0 ]  wcb_do_bf
);

`include "dti_global_params.vh"
// Internal Declarations


// Local declarations

// Internal signal declarations


// Instances 
dynamo_sram_rcb dynamo_sram_rcb( 
  .a_r_bf    (rcb_ra_bf), 
  .a_w_bf    (rcb_wa_bf), 
  .ce_n_r_bf (rcb_re_n_bf), 
  .ce_n_w_bf (rcb_we_n_bf), 
  .clk_r     (port_clk), 
  .clk_w     (dram_clk), 
  .di_bf     (rcb_di_bf), 
  .t_rwm     (reg_rcb_t_rwm), 
  .do_bf     (rcb_do_bf)
); 

dynamo_sram_wcb dynamo_sram_wcb( 
  .a_r_bf    (wcb_ra_bf), 
  .a_w_bf    (wcb_wa_bf), 
  .ce_n_r_bf (wcb_re_n_bf), 
  .ce_n_w_bf (wcb_we_n_bf), 
  .clk_r     (dram_clk), 
  .clk_w     (port_clk), 
  .di_bf     (wcb_di_bf), 
  .t_rwm     (reg_wcb_t_rwm), 
  .do_bf     (wcb_do_bf)
); 


endmodule // dynamo_sram


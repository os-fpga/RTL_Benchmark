//------------------------------------------------------------------------------
// Copyright (c) 2019 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           cdnsusbhs_upmux.v
//   Module Name:        cdnsusbhs_upmux
//
//   Release Revision:   R128_F015
//   Release SVN Tag:    USBHS_DUS1301_R128_F015_H03X32T08A32
//
//   IP Name:            USBHS-OTG
//   IP Part Number:     IP4010E
//
//   Product Type:       Configurable
//   IP Type:            Soft IP
//   IP Family:          USB
//   Technology:         N/A
//   Protocol:           USB2
//   Architecture:       OTGCTL
//   Licensable IP:      N/A
//
//------------------------------------------------------------------------------
//   Description:
//   The multiplexer for microprocessor interfaces
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_upmux
  (
  upclk,
  uprst,

  upaddr,
  uprd,
  upwr,
  upbe_rd,
  upbe_wr,
  uprdata,
  upwdata,

  dma_upaddr,
  dma_uprd,
  dma_upwr,
  dma_upbe_rd,
  dma_upbe_wr,
  dma_uprdata,
  dma_upwdata,

  cusb2_upaddr,
  cusb2_uprd,
  cusb2_upwr,
  cusb2_upbe_rd,
  cusb2_upbe_wr,
  cusb2_upwdata,
  cusb2_upendian,
  cusb2_uprdata
  );

  input                            upclk;
  input                            uprst;

  input  [8:0]                     upaddr;
  input                            uprd;
  input                            upwr;
  input  [3:0]                     upbe_rd;
  input  [3:0]                     upbe_wr;
  output [31:0]                    uprdata;
  wire   [31:0]                    uprdata;
  input  [31:0]                    upwdata;

  output [4:0]                     dma_upaddr;
  wire   [4:0]                     dma_upaddr;
  output                           dma_uprd;
  wire                             dma_uprd;
  output                           dma_upwr;
  wire                             dma_upwr;
  output [3:0]                     dma_upbe_rd;
  wire   [3:0]                     dma_upbe_rd;
  output [3:0]                     dma_upbe_wr;
  wire   [3:0]                     dma_upbe_wr;
  input  [31:0]                    dma_uprdata;
  output [31:0]                    dma_upwdata;
  wire   [31:0]                    dma_upwdata;

  output [7:0]                     cusb2_upaddr;
  wire   [7:0]                     cusb2_upaddr;
  output                           cusb2_uprd;
  wire                             cusb2_uprd;
  output                           cusb2_upwr;
  wire                             cusb2_upwr;
  output [3:0]                     cusb2_upbe_rd;
  wire   [3:0]                     cusb2_upbe_rd;
  output [3:0]                     cusb2_upbe_wr;
  wire   [3:0]                     cusb2_upbe_wr;
  output [31:0]                    cusb2_upwdata;
  wire   [31:0]                    cusb2_upwdata;
  input                            cusb2_upendian;
  input  [31:0]                    cusb2_uprdata;

  wire                             cusb2_sel;
  reg                              cusb2_sel_r;
  wire                             dma_sel;
  reg                              dma_sel_r;

  wire   [31:0]                    upwdata_e;
  wire   [3:0]                     upbe_rd_e;
  wire   [3:0]                     upbe_wr_e;
  wire   [31:0]                    uprdata_e;



  assign upwdata_e = (cusb2_upendian == 1'b0) ? upwdata[31:0] :
                                               {upwdata[7:0],   upwdata[15:8],
                                                upwdata[23:16], upwdata[31:24]} ;



  assign upbe_rd_e = (cusb2_upendian == 1'b0) ? upbe_rd[3:0] :
                                               {upbe_rd[0], upbe_rd[1],
                                                upbe_rd[2], upbe_rd[3]} ;



  assign upbe_wr_e = (cusb2_upendian == 1'b0) ? upbe_wr[3:0] :
                                               {upbe_wr[0], upbe_wr[1],
                                                upbe_wr[2], upbe_wr[3]} ;



  assign uprdata   = (cusb2_upendian == 1'b0) ? uprdata_e[31:0] :
                                               {uprdata_e[7:0],   uprdata_e[15:8],
                                                uprdata_e[23:16], uprdata_e[31:24]} ;



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : CUSB2_SEL_R_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      cusb2_sel_r <= 1'b0;
      end
    else
      begin
      cusb2_sel_r <= cusb2_sel;
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : DMA_SEL_R_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      dma_sel_r <= 1'b0;
      end
    else
      begin
      dma_sel_r <= dma_sel;
      end
    end





  assign cusb2_sel = (upaddr[8] == 1'b0) ? 1'b1 :
                                           1'b0;





  assign dma_sel   = (upaddr[8] == 1'b1 &&
                      upaddr[7:5] == 3'b000) ? 1'b1 :
                                               1'b0;




  assign cusb2_upaddr  = (cusb2_sel   == 1'b1) ? upaddr[7:0]   : {8{1'b0}};
  assign cusb2_uprd    = (cusb2_sel   == 1'b1) ? uprd          : 1'b0;
  assign cusb2_upwr    = (cusb2_sel   == 1'b1) ? upwr          : 1'b0;
  assign cusb2_upbe_rd = (cusb2_sel_r == 1'b1) ? upbe_rd_e     : {4{1'b0}};
  assign cusb2_upbe_wr = (cusb2_sel   == 1'b1) ? upbe_wr_e     : {4{1'b0}};
  assign cusb2_upwdata = (cusb2_sel   == 1'b1) ? upwdata_e     : {32{1'b0}};




  assign dma_upaddr    = (dma_sel     == 1'b1) ? upaddr[4:0]   : {5{1'b0}};
  assign dma_uprd      = (dma_sel     == 1'b1) ? uprd          : 1'b0;
  assign dma_upwr      = (dma_sel     == 1'b1) ? upwr          : 1'b0;
  assign dma_upbe_rd   = (dma_sel_r   == 1'b1) ? upbe_rd_e     : {4{1'b0}};
  assign dma_upbe_wr   = (dma_sel     == 1'b1) ? upbe_wr_e     : {4{1'b0}};
  assign dma_upwdata   = (dma_sel     == 1'b1) ? upwdata_e     : {32{1'b0}};




  assign uprdata_e     = (cusb2_sel_r == 1'b1) ? cusb2_uprdata :
                                                 dma_uprdata;

endmodule

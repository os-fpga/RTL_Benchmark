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
//   Filename:           cdnsusbhs_clkgate.v
//   Module Name:        cdnsusbhs_clkgate
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
//   The microprocessor interface wrapper
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"
`include "cdnsusbhs_adma_defines.v"



module cdnsusbhs_clkgate
  (
  aclk,
  areset,


  awid,
  awaddr,
  awsize,





  awvalid,



  `ifdef CDNSUSBHS_UP_AXI_4
  `else
  wid,
  `endif

  wdata_0,
  wdata_3,
  wstrb_0,
  wstrb_3,
  wvalid,





  bready,

  bvalid,

  endian,

  wuintreq,

  software_reset,

  aclk_en
  );





  parameter SAXI_ID_WIDTH    = 32'd`CDNSUSBHS_SAXI_ID_WIDTH;


  input                            aclk;
  input                            areset;


  input  [SAXI_ID_WIDTH-1:0]       awid;
  input  [9:0]                     awaddr;
  input  [2:0]                     awsize;





  input                            awvalid;




  `ifdef CDNSUSBHS_UP_AXI_4
  `else
  input  [SAXI_ID_WIDTH-1:0]       wid;
  `endif

  input  [7:0]                     wdata_0;
  input  [7:0]                     wdata_3;
  input                            wstrb_0;
  input                            wstrb_3;
  input                            wvalid;






  input                            bready;

  input                            bvalid;

  input                            endian;

  input                            wuintreq;

  output                           software_reset;
  reg                              software_reset;

  output                           aclk_en;
  reg                              aclk_en;

  reg                              aclk_en_axi;
  reg                              software_reset_axi;
  reg                              awrite_clkgate;
  reg                              wuintreq_en;
  reg                              wuintreq_r;



  `CDNSUSBHS_ALWAYS(aclk,areset)
    begin : WUINTREQ_REG_PROC
    if `CDNSUSBHS_RESET(areset)
      begin
      wuintreq_r <= 1'b0 ;
      end
    else
      begin
      wuintreq_r <= wuintreq ;
      end
    end



  `ifdef CDNSUSBHS_UP_AXI_4
  always @(awvalid or wvalid or awaddr or wstrb_0 or wstrb_3 or awsize or
           awid or endian)
  `else
  always @(awvalid or wvalid or awaddr or wstrb_0 or wstrb_3 or awsize or
           awid or wid or endian)
  `endif
    begin : AWRITE_CLKGATE_REG_PROC


  `ifdef CDNSUSBHS_UP_AXI_4
    if (awvalid == 1'b1 && wvalid == 1'b1 &&
        awaddr[9:2] == 8'hF0)
  `else
    if (awvalid == 1'b1 && wvalid == 1'b1 &&
        awaddr[9:2] == 8'hF0 &&
        awid == wid)
  `endif
      begin
      if (endian == 1'b0 && wstrb_0 == 1'b1)
        begin
        if (awsize == 3'b000 && awaddr[1:0] == 2'b00)
          begin
          awrite_clkgate = 1'b1 ;
          end
        else if (awsize == 3'b001 && awaddr[1] == 1'b0)
          begin
          awrite_clkgate = 1'b1 ;
          end
        else if (awsize == 3'b010)
          begin
          awrite_clkgate = 1'b1 ;
          end
        else
          begin
          awrite_clkgate = 1'b0 ;
          end
        end
      else if (endian == 1'b1 && wstrb_3 == 1'b1)
        begin
        if (awsize == 3'b000 && awaddr[1:0] == 2'b11)
          begin
          awrite_clkgate = 1'b1 ;
          end
        else if (awsize == 3'b001 && awaddr[1] == 1'b1)
          begin
          awrite_clkgate = 1'b1 ;
          end
        else if (awsize == 3'b010)
          begin
          awrite_clkgate = 1'b1 ;
          end
        else
          begin
          awrite_clkgate = 1'b0 ;
          end
        end
      else
        begin
        awrite_clkgate = 1'b0 ;
        end
      end
    else
      begin
      awrite_clkgate = 1'b0 ;
      end
    end



  `CDNSUSBHS_ALWAYS(aclk,areset)
    begin : ACLK_EN_AXI_REG_PROC
    if `CDNSUSBHS_RESET(areset)
      begin
      aclk_en_axi <= 1'b1 ;
      end
    else
      begin
      if (wuintreq_en == 1'b1 &&
          wuintreq == 1'b1 && wuintreq_r == 1'b0)
        begin
        aclk_en_axi <= 1'b1 ;
        end
      else if (awrite_clkgate == 1'b1)
        begin
        if (endian == 1'b0)
          begin
          aclk_en_axi <= wdata_0[0] ;
          end
        else
          begin
          aclk_en_axi <= wdata_3[0] ;
          end
        end
      end
    end



  `CDNSUSBHS_ALWAYS(aclk,areset)
    begin : ACLK_EN_REG_PROC
    if `CDNSUSBHS_RESET(areset)
      begin
      aclk_en <= 1'b1 ;
      end
    else
      begin
      if (wuintreq_en == 1'b1 &&
          wuintreq == 1'b1 && wuintreq_r == 1'b0)
        begin
        aclk_en <= 1'b1 ;
        end
      else if ((bvalid == 1'b1 && bready == 1'b1) || aclk_en_axi == 1'b1)
        begin
        aclk_en <= aclk_en_axi ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(aclk,areset)
    begin : WUINTREQ_EN_REG_PROC
    if `CDNSUSBHS_RESET(areset)
      begin
      wuintreq_en <= 1'b1 ;
      end
    else
      begin
      if (awrite_clkgate == 1'b1)
        begin
        if (endian == 1'b0)
          begin
          wuintreq_en <= wdata_0[7] ;
          end
        else
          begin
          wuintreq_en <= wdata_3[7] ;
          end
        end
      end
    end



  `CDNSUSBHS_ALWAYS(aclk,areset)
    begin : SOFTWARE_RESET_AXI_REG_PROC
    if `CDNSUSBHS_RESET(areset)
      begin
      software_reset_axi <= 1'b0 ;
      end
    else
      begin
      if (awrite_clkgate == 1'b1)
        begin
        if (endian == 1'b0)
          begin
          software_reset_axi <= wdata_0[1] ;
          end
        else
          begin
          software_reset_axi <= wdata_3[1] ;
          end
        end
      end
    end



  `CDNSUSBHS_ALWAYS(aclk,areset)
    begin : SOFTWARE_RESET_REG_PROC
    if `CDNSUSBHS_RESET(areset)
      begin
      software_reset <= 1'b0 ;
      end
    else
      begin
      if ((bvalid == 1'b1 && bready == 1'b1) || aclk_en_axi == 1'b1)
        begin
        software_reset <= software_reset_axi ;
        end
      end
    end

endmodule

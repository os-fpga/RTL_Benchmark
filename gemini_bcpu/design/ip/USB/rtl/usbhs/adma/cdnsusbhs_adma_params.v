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
//   Filename:           cdnsusbhs_adma_params.v
//   Module Name:        N/A
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
//   ADMA Constant definitions package
//   M.K.
//------------------------------------------------------------------------------






  parameter IMPLEMENT_DMAEP       = 32'b1111111111111111_1111111111111111;
  parameter IMPLEMENT_EP          = {`CDNSUSBHS_EPINEXIST, `CDNSUSBHS_EPOUTEXIST} & IMPLEMENT_DMAEP;
  parameter DATA_WIDTH            = 32'd`CDNSUSBHS_DATA_WIDTH;
  parameter ADDR_WIDTH            = 32'd`CDNSUSBHS_ADDR_WIDTH;
  parameter PKTADDR_WIDTH         = 32'd`CDNSUSBHS_PKTADDR_WIDTH;
  parameter PKTLENGTH_WIDTH       = 32'd`CDNSUSBHS_PKTLENGTH_WIDTH;
  parameter EPNUM_WIDTH           = 32'd`CDNSUSBHS_EPNUM_WIDTH;
  parameter STID_WIDTH            = 32'd`CDNSUSBHS_STID_WIDTH;
  parameter XFERLENGTH_WIDTH      = 32'd`CDNSUSBHS_XFERLENGTH_WIDTH;


  parameter TRB_NORMAL            = 6'd1;
  parameter TRB_LINK              = 6'd6;




  parameter OCP_CMD_WIDTH         = 32'd`CDNSUSBHS_OCP_CMD_WIDTH;
  parameter OCP_RESP_WIDTH        = 32'd`CDNSUSBHS_OCP_RESP_WIDTH;
  parameter OCP_DATA_WIDTH        = 32'd`CDNSUSBHS_OCP_DATA_WIDTH;
  parameter OCP_BYTEEN_WIDTH      = 32'd`CDNSUSBHS_OCP_BYTEEN_WIDTH;
  parameter OCP_ADDR_WIDTH        = 32'd`CDNSUSBHS_OCP_ADDR_WIDTH;
  parameter OCP_BURSTLENGTH_WIDTH = 32'd`CDNSUSBHS_OCP_BURSTLENGTH_WIDTH;
  parameter OCP_BURSTSEQ_WIDTH    = 32'd`CDNSUSBHS_OCP_BURSTSEQ_WIDTH;


  parameter DMA_TRB_LENGTH        = 11'd12;





  parameter SFR_ADDR_WIDTH        = 32'd`CDNSUSBHS_SFR_ADDR_WIDTH;







  parameter IMPLEMENT_EP_ISO      = {`CDNSUSBHS_EPINEXIST, `CDNSUSBHS_EPOUTEXIST};





  `ifdef CDNSUSBHS_CONT_BURST_PROTECTION
  parameter F0AWIDTH              = `CDNSUSBHS_DATA_SYNC0_DEPTH;
  parameter F1AWIDTH              = `CDNSUSBHS_DATA_SYNC1_DEPTH;
  `endif





  `ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  parameter AXI_OT_W              = 32'd`CDNSUSBHS_AXI_OT_W;
  `endif

  parameter MAXI_ID_WIDTH         = 32'd`CDNSUSBHS_MAXI_ID_WIDTH;
  parameter M_CACHE_WIDTH         = 32'd`CDNSUSBHS_M_CACHE_WIDTH;
  parameter M_LEN_WIDTH           = 32'd`CDNSUSBHS_M_LEN_WIDTH;
  parameter AXI_MAX_RD_OT         = 32'd`CDNSUSBHS_AXI_WCD - 32'd1;
  parameter AXI_MAX_WR_OT         = 32'd`CDNSUSBHS_AXI_WCD - 32'd1;
  parameter AXI_BMAX_RST_VALUE    = 32'd`CDNSUSBHS_AXI_BMAX;



  parameter DMADATAWIDTH          = 32'd`CDNSUSBHS_DMADATAWIDTH;

  parameter MEMADDRWIDTH          = 32'd`CDNSUSBHS_ADMAMEMORY_WIDTH;

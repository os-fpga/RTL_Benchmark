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
//   Filename:           cdnsusbhs_adma_defines.v
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
//   Defines used in ADMA components
//   S.G.
//------------------------------------------------------------------------------













  `define CDNSUSBHS_DMADATAWIDTH         `CDNSUSBHS_FIFODATAWIDTH

  `define CDNSUSBHS_DMAADDRWIDTH         32





  `define CDNSUSBHS_IMPLEMENT_DMA_PRECISE_BURSTS






  //`define CDNSUSBHS_CONT_BURST_PROTECTION









  `define CDNSUSBHS_SUPPORT_ENDIANESS_CONV









  `define CDNSUSBHS_SFR_SUPPORT_ENDIANESS_CONV









  `define CDNSUSBHS_SUPPORT_MISALIGNED_ADDRESSES






  //`define CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK









  `define CDNSUSBHS_OCP_CMD_WIDTH          3
  `define CDNSUSBHS_OCP_RESP_WIDTH         2
  `define CDNSUSBHS_OCP_DATA_WIDTH         32
  `define CDNSUSBHS_OCP_BYTEEN_WIDTH       4
  `define CDNSUSBHS_OCP_ADDR_WIDTH         32
  `define CDNSUSBHS_OCP_BURSTLENGTH_WIDTH  8
  `define CDNSUSBHS_OCP_BURSTSEQ_WIDTH     3
  `define CDNSUSBHS_OCP_SFLAG_WDTH         2

  `define CDNSUSBHS_SFR_ADDR_WIDTH         7
  `define CDNSUSBHS_SFR_WIDTH              32
  `define CDNSUSBHS_DATA_WIDTH             32

  `define CDNSUSBHS_ADDR_WIDTH             32
  `define CDNSUSBHS_PKTADDR_WIDTH          9
  `define CDNSUSBHS_PKTLENGTH_WIDTH        11
  `define CDNSUSBHS_EPNUM_WIDTH            4
  `define CDNSUSBHS_STID_WIDTH             16
  `define CDNSUSBHS_XFERLENGTH_WIDTH       17





  `define CDNSUSBHS_DATA_SYNC0_DEPTH       2
  `define CDNSUSBHS_DATA_SYNC1_DEPTH       2





  `define CDNSUSBHS_IMPLEMENT_SFR_AMBA
//`define CDNSUSBHS_IMPLEMENT_DMA_AMBA
  `define CDNSUSBHS_IMPLEMENT_DMA_OCP

  `define CDNSUSBHS_IMPLEMENT_DMA_FIFO



//`define CDNSUSBHS_UP_AXI_4




`ifdef CDNSUSBHS_UP_AXI_4
`else
  `define CDNSUSBHS_MAXI_ID_WIDTH         4
  `define CDNSUSBHS_SAXI_ID_WIDTH        12
  `define CDNSUSBHS_M_LEN_WIDTH           4
  `define CDNSUSBHS_S_LEN_WIDTH           4
  `define CDNSUSBHS_M_CACHE_WIDTH         4
  `define CDNSUSBHS_S_CACHE_WIDTH         4
  `define CDNSUSBHS_AXI_BMAX             15
`endif




`ifdef CDNSUSBHS_UP_AXI_4
  `define CDNSUSBHS_MAXI_ID_WIDTH         4
  `define CDNSUSBHS_SAXI_ID_WIDTH        12
  `define CDNSUSBHS_M_LEN_WIDTH           8
  `define CDNSUSBHS_S_LEN_WIDTH           8
  `define CDNSUSBHS_M_CACHE_WIDTH         4
  `define CDNSUSBHS_S_CACHE_WIDTH         4
  `define CDNSUSBHS_AXI_BMAX            255
`endif






  `define CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  `define CDNSUSBHS_AXI_OT_W              5

  `define CDNSUSBHS_AXI_WCD              16
  `define CDNSUSBHS_AXI_WCD_PW            4

//`define CDNSUSBHS_AXI_RCD               8
//`define CDNSUSBHS_AXI_RCD_PW            3



  `define CDNSUSBHS_M_DATA_WIDTH         `CDNSUSBHS_DMADATAWIDTH
  `define CDNSUSBHS_M_ADDR_WIDTH         `CDNSUSBHS_DMAADDRWIDTH




  `define CDNSUSBHS_EPIN_POINTER_0        0
  `define CDNSUSBHS_EPIN_POINTER_1        1
  `define CDNSUSBHS_EPIN_POINTER_2        2
  `define CDNSUSBHS_EPIN_POINTER_3        3
  `define CDNSUSBHS_EPIN_POINTER_4        4
  `define CDNSUSBHS_EPIN_POINTER_5        5
  `define CDNSUSBHS_EPIN_POINTER_6        6
  `define CDNSUSBHS_EPIN_POINTER_7        7
  `define CDNSUSBHS_EPIN_POINTER_8        8
  `define CDNSUSBHS_EPIN_POINTER_9        8
  `define CDNSUSBHS_EPIN_POINTER_10       8
  `define CDNSUSBHS_EPIN_POINTER_11       8
  `define CDNSUSBHS_EPIN_POINTER_12       8
  `define CDNSUSBHS_EPIN_POINTER_13       8
  `define CDNSUSBHS_EPIN_POINTER_14       8
  `define CDNSUSBHS_EPIN_POINTER_15       8

  `define CDNSUSBHS_EPOUT_POINTER_0       9
  `define CDNSUSBHS_EPOUT_POINTER_1       10
  `define CDNSUSBHS_EPOUT_POINTER_2       11
  `define CDNSUSBHS_EPOUT_POINTER_3       12
  `define CDNSUSBHS_EPOUT_POINTER_4       13
  `define CDNSUSBHS_EPOUT_POINTER_5       14
  `define CDNSUSBHS_EPOUT_POINTER_6       15
  `define CDNSUSBHS_EPOUT_POINTER_7       16
  `define CDNSUSBHS_EPOUT_POINTER_8       17
  `define CDNSUSBHS_EPOUT_POINTER_9       17
  `define CDNSUSBHS_EPOUT_POINTER_10      17
  `define CDNSUSBHS_EPOUT_POINTER_11      17
  `define CDNSUSBHS_EPOUT_POINTER_12      17
  `define CDNSUSBHS_EPOUT_POINTER_13      17
  `define CDNSUSBHS_EPOUT_POINTER_14      17
  `define CDNSUSBHS_EPOUT_POINTER_15      17










  `define CDNSUSBHS_ADMAMEMORY_SIZE       72
  `define CDNSUSBHS_ADMAMEMORY_WIDTH      7


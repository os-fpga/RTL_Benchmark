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
//   Filename:           cdnsusbhs_cusb2_params.v
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
//   CUSB2 Constant definitions package
//   S.G. D.K.
//------------------------------------------------------------------------------




  parameter PID_OUT             = 5'b0_0001;
  parameter PID_IN              = 5'b0_1001;
  parameter PID_SOF             = 5'b0_0101;
  parameter PID_SETUP           = 5'b0_1101;
  parameter PID_MDATA           = 5'b0_1111;
  parameter PID_DATA0           = 5'b0_0011;
  parameter PID_DATA1           = 5'b0_1011;
  parameter PID_DATA2           = 5'b0_0111;
  parameter PID_ACK             = 5'b0_0010;
  parameter PID_NAK             = 5'b0_1010;
  parameter PID_STALL           = 5'b0_1110;
  parameter PID_NYET            = 5'b0_0110;
  parameter PID_PING            = 5'b0_0100;
  parameter PID_EXT             = 5'b0_0000;
  parameter PID_LPM             = 5'b0_0011;




  parameter SUBPID_LPM          = 5'b1_0011;




  parameter EP_BULK             = 2'b10;
  parameter EP_INT              = 2'b11;
  parameter EP_ISO              = 2'b01;
  parameter EP_CTRL             = 2'b00;




  parameter FIFOCTRL_ID         = 10'b01_1010_1000;
  parameter FIFOCTRL_RV         =  8'b1000_0000;
  parameter EP0CS_RV            =  8'b0000_1000;
  parameter OUTXCS_RV           =  5'b0_0010;
  parameter OUTXCON_RV          =  8'b0000_1011;
  parameter INXCS_RV            =  5'b0_0000;
  parameter INXCON_RV           =  8'b0000_1011;
`ifdef CDNSUSBHS_BENDIAN
  parameter ENDIAN_RV           =  8'b1000_0000;
`else
  parameter ENDIAN_RV           =  8'b0000_0000;
`endif

  parameter HCLPMCTRL_RV        =  8'b0000_0001;





  parameter DOTG2CTRL_RV        = 4'b0001;




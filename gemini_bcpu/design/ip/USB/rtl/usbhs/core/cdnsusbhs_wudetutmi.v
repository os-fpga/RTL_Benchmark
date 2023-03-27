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
//   Filename:           cdnsusbhs_wudetutmi.v
//   Module Name:        cdnsusbhs_wudetutmi
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
//   UTMI clock part of Wake-up detector
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_wudetutmi
  (



  wakeupid,
  wakeupid_ack,

  wakeupdp,
  wakeupdp_ack,

  wakeupvbus,
  wakeupvbus_ack
  );




  input                                wakeupid;
  output                               wakeupid_ack;
  wire                                 wakeupid_ack;

  input                                wakeupdp;
  output                               wakeupdp_ack;
  wire                                 wakeupdp_ack;

  input                                wakeupvbus;
  output                               wakeupvbus_ack;
  wire                                 wakeupvbus_ack;



  assign wakeupid_ack   = wakeupid;



  assign wakeupdp_ack   = wakeupdp;



  assign wakeupvbus_ack = wakeupvbus;

endmodule

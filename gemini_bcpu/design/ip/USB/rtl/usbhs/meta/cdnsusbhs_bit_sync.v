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
//   Filename:           cdnsusbhs_bit_sync.v
//   Module Name:        cdnsusbhs_bit_sync
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
//   BIT_SYNC
//   K.W.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_bit_sync
  (

  txdata,


  rxclk,
  rxrst,
  rxdata
  );

  parameter DATA_SYNC_WIDTH = 32'd1;


  input  [DATA_SYNC_WIDTH-1:0]     txdata;


  input                            rxclk;
  input                            rxrst;
  output [DATA_SYNC_WIDTH-1:0]     rxdata;
  wire   [DATA_SYNC_WIDTH-1:0]     rxdata;



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_DFF_SYNC[DATA_SYNC_WIDTH-1:0]
    (

    .txsignal                           (txdata),


    .rxclk                              (rxclk),
    .rxrst                              (rxrst),
    .rxsignal                           (rxdata)
    );

endmodule

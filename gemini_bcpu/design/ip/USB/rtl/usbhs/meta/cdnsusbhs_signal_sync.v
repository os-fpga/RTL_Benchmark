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
//   Filename:           cdnsusbhs_signal_sync.v
//   Module Name:        cdnsusbhs_signal_sync
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
//   Signal Synchronizer - Top Level
//   K.W.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_signal_sync
  (

  txclk,
  txrst,
  txsignal,


  rxclk,
  rxrst,
  rxsignal
  );


  input                            txclk;
  input                            txrst;
  input                            txsignal;

  input                            rxclk;
  input                            rxrst;
  output                           rxsignal;
  wire                             rxsignal;

  wire                             cdc_req;
  wire                             cdc_req_rx;
  wire                             cdc_ack;
  wire                             cdc_ack_tx;




  cdnsusbhs_signal_sync_tx
  U_CDNSUSBHS_SIGNAL_SYNC_TX
    (

    .txclk                              (txclk),
    .txrst                              (txrst),
    .txsignal                           (txsignal),

    .cdc_req                            (cdc_req),
    .cdc_ack                            (cdc_ack_tx)
    );




  cdnsusbhs_signal_sync_rx
  U_CDNSUSBHS_SIGNAL_SYNC_RX
    (

    .rxclk                              (rxclk),
    .rxrst                              (rxrst),
    .rxsignal                           (rxsignal),

    .cdc_req                            (cdc_req_rx),
    .cdc_ack                            (cdc_ack)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_DFF_SYNC_TX
    (

    .txsignal                           (cdc_ack),


    .rxclk                              (txclk),
    .rxrst                              (txrst),
    .rxsignal                           (cdc_ack_tx)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_DFF_SYNC_RX
     (

    .txsignal                           (cdc_req),


    .rxclk                              (rxclk),
    .rxrst                              (rxrst),
    .rxsignal                           (cdc_req_rx)
    );

endmodule

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
//   Filename:           cdnsusbhs_data_sync.v
//   Module Name:        cdnsusbhs_data_sync
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
//   Data Synchronizer - Top Level
//   K.W.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_data_sync
  (

  txclk,
  txrst,
  txdata,


  rxclk,
  rxrst,
  rxdata
  );

  parameter DATA_SYNC_WIDTH = 32'd1;


  input                            txclk;
  input                            txrst;
  input  [DATA_SYNC_WIDTH-1:0]     txdata;


  input                            rxclk;
  input                            rxrst;
  output [DATA_SYNC_WIDTH-1:0]     rxdata;
  wire   [DATA_SYNC_WIDTH-1:0]     rxdata;

  wire   [DATA_SYNC_WIDTH-1:0]     cdc_data;
  wire                             cdc_req;
  wire                             cdc_req_rx;
  wire                             cdc_ack;
  wire                             cdc_ack_tx;




  cdnsusbhs_data_sync_tx
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (DATA_SYNC_WIDTH)
  `else
    DATA_SYNC_WIDTH
  `endif
    )
  U_CDNSUSBHS_DATA_SYNC_TX
    (

    .txclk                              (txclk),
    .txrst                              (txrst),
    .txdata                             (txdata),

    .cdc_data                           (cdc_data),
    .cdc_req                            (cdc_req),
    .cdc_ack                            (cdc_ack_tx)
    );




  cdnsusbhs_data_sync_rx
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (DATA_SYNC_WIDTH)
  `else
    DATA_SYNC_WIDTH
  `endif
    )
  U_CDNSUSBHS_DATA_SYNC_RX
    (

    .rxclk                              (rxclk),
    .rxrst                              (rxrst),
    .rxdata                             (rxdata),

    .cdc_data                           (cdc_data),
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

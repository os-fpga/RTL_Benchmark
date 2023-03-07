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
//   Filename:           cdnsusbhs_signal_sync_rx.v
//   Module Name:        cdnsusbhs_signal_sync_rx
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
//   Signal Synchronizer - RX domain
//   K.W.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_signal_sync_rx
  (

  rxclk,
  rxrst,
  rxsignal,


  cdc_req,
  cdc_ack
  );


  input                            rxclk;
  input                            rxrst;
  output                           rxsignal;
  wire                             rxsignal;

  input                            cdc_req;
  output                           cdc_ack;
  wire                             cdc_ack;

  reg                              cdc_req_r;



  `CDNSUSBHS_ALWAYS(rxclk,rxrst)
    begin : REQ_SIGNAL_PROC
    if `CDNSUSBHS_RESET(rxrst)
      begin
      cdc_req_r <= 1'b0;
      end
    else
      begin
      cdc_req_r <= cdc_req;
      end
    end



  assign cdc_ack = cdc_req;



  assign rxsignal = (cdc_req != cdc_req_r) ? 1'b1 :
                                             1'b0 ;

endmodule

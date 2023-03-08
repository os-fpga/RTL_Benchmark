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
//   Filename:           cdnsusbhs_signal_sync_tx.v
//   Module Name:        cdnsusbhs_signal_sync_tx
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
//   Signal Synchronizer - TX domain
//   K.W.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_signal_sync_tx
  (

  txclk,
  txrst,
  txsignal,


  cdc_ack,
  cdc_req
  );


  input                            txclk;
  input                            txrst;
  input                            txsignal;

  input                            cdc_ack;
  output                           cdc_req;
  reg                              cdc_req;

  reg                              txsignal_r;
  wire                             txsignal_rise;



  `CDNSUSBHS_ALWAYS(txclk,txrst)
    begin : TXSIGNAL_R_PROC
    if `CDNSUSBHS_RESET(txrst)
      begin
      txsignal_r <= 1'b0;
      end
    else
      begin
      txsignal_r <= txsignal;
      end
    end



  assign txsignal_rise = (txsignal == 1'b1 && txsignal_r == 1'b0) ? 1'b1 :
                                                                    1'b0 ;



  `CDNSUSBHS_ALWAYS(txclk,txrst)
    begin : REQ_SIGNAL_PROC
    if `CDNSUSBHS_RESET(txrst)
      begin
      cdc_req <= 1'b0;
      end
    else
      begin
      if (txsignal_rise == 1'b1 && cdc_ack == cdc_req)
        begin
        cdc_req <= ~cdc_req ;
        end
      end
    end

endmodule

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
//   Filename:           cdnsusbhs_data_sync_rx.v
//   Module Name:        cdnsusbhs_data_sync_rx
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
//   Data Synchronizer - RX domain
//   K.W.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_data_sync_rx
  (

  rxclk,
  rxrst,
  rxdata,


  cdc_data,
  cdc_req,
  cdc_ack
  );

  parameter DATA_SYNC_WIDTH = 32'd1;


  input                            rxclk;
  input                            rxrst;
  output [DATA_SYNC_WIDTH-1:0]     rxdata;
  reg    [DATA_SYNC_WIDTH-1:0]     rxdata;


  input  [DATA_SYNC_WIDTH-1:0]     cdc_data;
  input                            cdc_req;
  output                           cdc_ack;
  wire                             cdc_ack;

  reg                              cdc_req_r;



  `CDNSUSBHS_ALWAYS(rxclk,rxrst)
    begin : REQ_DATA_PROC
    if `CDNSUSBHS_RESET(rxrst)
      begin
      cdc_req_r <= 1'b0;
      end
    else
      begin
      cdc_req_r <= cdc_req;
      end
    end



  assign cdc_ack = cdc_req_r;



  `CDNSUSBHS_ALWAYS(rxclk,rxrst)
    begin : DATA_HOLD_PROC
    if `CDNSUSBHS_RESET(rxrst)
      begin
      rxdata <= {DATA_SYNC_WIDTH{1'b0}};
      end
    else
      begin
      if (cdc_req != cdc_req_r)
        begin
        rxdata <= cdc_data;
        end
      end
    end

endmodule

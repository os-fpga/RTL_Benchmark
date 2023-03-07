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
//   Filename:           cdnsusbhs_data_sync_tx.v
//   Module Name:        cdnsusbhs_data_sync_tx
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
//   Data Synchronizer - TX domain
//   K.W.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_data_sync_tx
  (

  txclk,
  txrst,
  txdata,


  cdc_ack,
  cdc_data,
  cdc_req
  );

  parameter DATA_SYNC_WIDTH = 32'd1;


  input                            txclk;
  input                            txrst;
  input  [DATA_SYNC_WIDTH-1:0]     txdata;

  input                            cdc_ack;
  output [DATA_SYNC_WIDTH-1:0]     cdc_data;
  reg    [DATA_SYNC_WIDTH-1:0]     cdc_data;
  output                           cdc_req;
  reg                              cdc_req;

  wire                             cdc_change;



  assign cdc_change = (cdc_req == cdc_ack & txdata != cdc_data);



  `CDNSUSBHS_ALWAYS(txclk,txrst)
    begin : REQ_DATA_PROC
    if `CDNSUSBHS_RESET(txrst)
      begin
      cdc_req <= 1'b0;
      end
    else
      begin
      if (cdc_change == 1'b1)
        begin
        cdc_req <= ~cdc_req;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(txclk,txrst)
    begin : DATA_HOLD_PROC
    if `CDNSUSBHS_RESET(txrst)
      begin
      cdc_data <= {DATA_SYNC_WIDTH{1'b0}};
      end
    else
      begin
      if (cdc_change == 1'b1)
        begin
        cdc_data <= txdata;
        end
      end
    end

endmodule

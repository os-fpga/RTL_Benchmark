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
//   Filename:           cdnsusbhs_load_sync_tx.v
//   Module Name:        cdnsusbhs_load_sync_tx
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



module cdnsusbhs_load_sync_tx
  (

  txclk,
  txrst,
  txdata,
  txload,


  cdc_ack,
  cdc_data,
  cdc_req
  );

  parameter DATA_SYNC_WIDTH = 32'd1;


  input                            txclk;
  input                            txrst;
  input                            txload;
  input  [DATA_SYNC_WIDTH-1:0]     txdata;

  input                            cdc_ack;
  output [DATA_SYNC_WIDTH-1:0]     cdc_data;
  reg    [DATA_SYNC_WIDTH-1:0]     cdc_data;
  output                           cdc_req;
  reg                              cdc_req;

  reg                              txload_r;
  wire                             txload_rise;



  `CDNSUSBHS_ALWAYS(txclk,txrst)
    begin : LOAD_DATA_PROC
    if `CDNSUSBHS_RESET(txrst)
      begin
      txload_r <= 1'b0;
      end
    else
      begin
      txload_r <= txload;
      end
    end



  assign txload_rise = (txload == 1'b1 && txload_r == 1'b0) ? 1'b1 :
                                                              1'b0 ;



  `CDNSUSBHS_ALWAYS(txclk,txrst)
    begin : REQ_DATA_PROC
    if `CDNSUSBHS_RESET(txrst)
      begin
      cdc_req <= 1'b0;
      end
    else
      begin
      if (txload_rise == 1'b1 && cdc_req == cdc_ack)
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
      if (txload_rise == 1'b1 && cdc_req == cdc_ack)
        begin
        cdc_data <= txdata;
        end
      end
    end

endmodule

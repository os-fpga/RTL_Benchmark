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
//   Filename:           cdnsusbhs_dff_sync.v
//   Module Name:        cdnsusbhs_dff_sync
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
//   DFF_SYNC
//   K.W.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_dff_sync
  (

  txsignal,


  rxclk,
  rxrst,
  rxsignal
  );


  input                            txsignal;


  input                            rxclk;
  input                            rxrst;
  output                           rxsignal;
`ifdef ABV_ON
  wire                             rxsignal;
`else
`ifdef CDNSUSBHS_VERILOG_2001
  wire                             rxsignal;
`else
  reg                              rxsignal;
`endif
`endif

`ifdef ABV_ON
`else
`ifdef CDNSUSBHS_VERILOG_2001
`else
  reg                              txsignal_ff;
`endif
`endif

`ifdef ABV_ON


  cdnsdru_datasync_v1
    #(
    .CDNSDRU_DATASYNC_RESET_STATE          (1'b0),
    `ifdef CDNSUSBHS_ASYNCHRONOUS_RST
    .CDNSDRU_DATASYNC_SYNC_RESET           (1'b0),
    `else
    .CDNSDRU_DATASYNC_SYNC_RESET           (1'b1),
    `endif
    .CDNSDRU_DATASYNC_NUM_FLOPS            (32'd2),
    .CDNSDRU_DATASYNC_DIN_W                (32'd1),
    .CDNSDRU_DATASYNC_ENABLE_RANDOMIZATION (1'b1),
    .CDNSDRU_DATASYNC_META_WINDOW          (100)
    )
  U_CDNS_SYNCFLOP
    (
    .clk              (rxclk),
    `ifdef CDNSUSBHS_HIGH_RST
    .reset_n          (~rxrst),
    `else
    .reset_n          (rxrst),
    `endif
    .din              (txsignal),
    .dout             (rxsignal)
    );
`else

`ifdef CDNSUSBHS_VERILOG_2001


  cdnsdru_datasync_v1
    #(
    .CDNSDRU_DATASYNC_RESET_STATE          (1'b0),
    `ifdef CDNSUSBHS_ASYNCHRONOUS_RST
    .CDNSDRU_DATASYNC_SYNC_RESET           (1'b0),
    `else
    .CDNSDRU_DATASYNC_SYNC_RESET           (1'b1),
    `endif
    .CDNSDRU_DATASYNC_NUM_FLOPS            (32'd2),
    .CDNSDRU_DATASYNC_DIN_W                (32'd1),
    .CDNSDRU_DATASYNC_ENABLE_RANDOMIZATION (1'b1),
    .CDNSDRU_DATASYNC_META_WINDOW          (100)
    )
  U_CDNS_SYNCFLOP
    (
    .clk              (rxclk),
    `ifdef CDNSUSBHS_HIGH_RST
    .reset_n          (~rxrst),
    `else
    .reset_n          (rxrst),
    `endif
    .din              (txsignal),
    .dout             (rxsignal)
    );
`else



  `CDNSUSBHS_ALWAYS(rxclk,rxrst)
    begin : TX_SIGNAL_PROC
    if `CDNSUSBHS_RESET(rxrst)
      begin
      txsignal_ff <= 1'b0;
      rxsignal    <= 1'b0;
      end
    else
      begin
      txsignal_ff <= txsignal;
      rxsignal    <= txsignal_ff;
      end
    end
`endif
`endif

endmodule

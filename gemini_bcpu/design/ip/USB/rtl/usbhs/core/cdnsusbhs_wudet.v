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
//   Filename:           cdnsusbhs_wudet.v
//   Module Name:        cdnsusbhs_wudet
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
//   Architecture STRUCTURAL of WUDET
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_wudet
  (
  utmiclk,
  utmirst,

  wakeup5kclk,
  wakeup5krst,

  utmiiddig,
  utmilinestate,
  utmivbusvalid,
  utmiavalid,

  wakeupid,
  wakeupdp,
  wakeupvbus
  );

  input                                utmiclk;
  input                                utmirst;

  input                                wakeup5kclk;
  input                                wakeup5krst;

  input                                utmiiddig;
  input    [1:0]                       utmilinestate;
  input                                utmivbusvalid;
  input                                utmiavalid;

  output                               wakeupid;
  wire                                 wakeupid;
  output                               wakeupdp;
  wire                                 wakeupdp;
  output                               wakeupvbus;
  wire                                 wakeupvbus;

  wire                                 utmilinestate_or;

  wire                                 wakeupid_utmi;
  wire                                 wakeupdp_utmi;
  wire                                 wakeupvbus_utmi;

  wire                                 wakeupid_ack;
  wire                                 wakeupdp_ack;
  wire                                 wakeupvbus_ack;

  wire                                 utmiiddig_5k;
  wire                                 utmilinestate_5k;
  wire                                 utmivbusvalid_5k;
  wire                                 utmiavalid_5k;
  wire                                 wakeupid_ack_5k;
  wire                                 wakeupdp_ack_5k;
  wire                                 wakeupvbus_ack_5k;



  assign utmilinestate_or = (utmilinestate[1] | utmilinestate[0]);




  cdnsusbhs_wudet5k
  U_CDNSUSBHS_WUDET5K
    (
    .wakeup5kclk                        (wakeup5kclk),
    .wakeup5krst                        (wakeup5krst),

    .utmiiddig                          (utmiiddig_5k),
    .utmilinestate                      (utmilinestate_5k),
    .utmivbusvalid                      (utmivbusvalid_5k),
    .utmiavalid                         (utmiavalid_5k),

    .wakeupid_ack                       (wakeupid_ack_5k),
    .wakeupdp_ack                       (wakeupdp_ack_5k),
    .wakeupvbus_ack                     (wakeupvbus_ack_5k),

    .wakeupid                           (wakeupid),
    .wakeupdp                           (wakeupdp),
    .wakeupvbus                         (wakeupvbus)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_UTMIIDDIG_5K
    (

    .txsignal                           (utmiiddig),


    .rxclk                              (wakeup5kclk),
    .rxrst                              (wakeup5krst),
    .rxsignal                           (utmiiddig_5k)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_UTMILINESTATE_5K
    (

    .txsignal                           (utmilinestate_or),


    .rxclk                              (wakeup5kclk),
    .rxrst                              (wakeup5krst),
    .rxsignal                           (utmilinestate_5k)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_UTMIVBUSVALID_5K
    (

    .txsignal                           (utmivbusvalid),


    .rxclk                              (wakeup5kclk),
    .rxrst                              (wakeup5krst),
    .rxsignal                           (utmivbusvalid_5k)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_UTMIAVALID_5K
    (

    .txsignal                           (utmiavalid),


    .rxclk                              (wakeup5kclk),
    .rxrst                              (wakeup5krst),
    .rxsignal                           (utmiavalid_5k)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_WAKEUPID_ACK_5K
    (

    .txsignal                           (wakeupid_ack),


    .rxclk                              (wakeup5kclk),
    .rxrst                              (wakeup5krst),
    .rxsignal                           (wakeupid_ack_5k)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_WAKEUPDP_ACK_5K
    (

    .txsignal                           (wakeupdp_ack),


    .rxclk                              (wakeup5kclk),
    .rxrst                              (wakeup5krst),
    .rxsignal                           (wakeupdp_ack_5k)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_WAKEUPVBUS_ACK_5K
    (

    .txsignal                           (wakeupvbus_ack),


    .rxclk                              (wakeup5kclk),
    .rxrst                              (wakeup5krst),
    .rxsignal                           (wakeupvbus_ack_5k)
    );




  cdnsusbhs_wudetutmi
  U_CDNSUSBHS_WUDETUTMI
    (



    .wakeupid                           (wakeupid_utmi),
    .wakeupid_ack                       (wakeupid_ack),

    .wakeupdp                           (wakeupdp_utmi),
    .wakeupdp_ack                       (wakeupdp_ack),

    .wakeupvbus                         (wakeupvbus_utmi),
    .wakeupvbus_ack                     (wakeupvbus_ack)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_WAKEUPID_UTMI
    (

    .txsignal                           (wakeupid),


    .rxclk                              (utmiclk),
    .rxrst                              (utmirst),
    .rxsignal                           (wakeupid_utmi)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_WAKEUPDP_UTMI
    (

    .txsignal                           (wakeupdp),


    .rxclk                              (utmiclk),
    .rxrst                              (utmirst),
    .rxsignal                           (wakeupdp_utmi)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_WAKEUPVBUS_UTMI
    (

    .txsignal                           (wakeupvbus),


    .rxclk                              (utmiclk),
    .rxrst                              (utmirst),
    .rxsignal                           (wakeupvbus_utmi)
    );

endmodule

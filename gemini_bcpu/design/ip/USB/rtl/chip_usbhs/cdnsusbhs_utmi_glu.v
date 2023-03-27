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
//   Filename:           cdnsusbhs_utmi_glu.v
//   Module Name:        cdnsusbhs_utmi_glu
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
//   UTMI tri-state buffer
//   K.W.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_utmi_glu
  (

  utmitxvalid,
  utmidatain,


  utmirxvalid,
  utmidataout,


  utmirxvalidl,


  utmitxvalidl,


  utmivalidh,
  utmidata
  );

  parameter USBDATAWIDTH = 16;


  input  [USBDATAWIDTH/8-1:0]      utmitxvalid;
  input  [USBDATAWIDTH-1:0]        utmidatain;


  output [USBDATAWIDTH/8-1:0]      utmirxvalid;
  wire   [USBDATAWIDTH/8-1:0]      utmirxvalid;
  output [USBDATAWIDTH-1:0]        utmidataout;
  wire   [USBDATAWIDTH-1:0]        utmidataout;


  input                            utmirxvalidl;


  output                           utmitxvalidl;
  wire                             utmitxvalidl;


  inout                            utmivalidh;
  wire                             utmivalidh;
  inout  [USBDATAWIDTH-1:0]        utmidata;
  wire   [USBDATAWIDTH-1:0]        utmidata;

  reg    [1:0]                     utmitxvalid_v;



  assign utmivalidh =
            (utmitxvalid[0] == 1'b1) ? utmitxvalid[USBDATAWIDTH/8-1] :
                                       1'bz ;



  assign utmitxvalidl = utmitxvalid[0] ;





  always @(utmivalidh or utmirxvalidl or utmitxvalid)
    begin : UTMIRXVALID_PROC

    utmitxvalid_v = 2'b00;
    if (utmitxvalid[0] == 1'b1)
      begin
      utmitxvalid_v[1] = 1'b0 ;
      end
    else
      begin
      utmitxvalid_v[1] = utmivalidh ;
      end
    utmitxvalid_v[0] = utmirxvalidl ;
    end





  assign utmirxvalid = utmitxvalid_v[USBDATAWIDTH/8-1:0];



  assign utmidata =
            (utmitxvalid[0] == 1'b1) ? utmidatain :
                                      {USBDATAWIDTH{1'bz}} ;



  assign utmidataout = utmidata ;

endmodule

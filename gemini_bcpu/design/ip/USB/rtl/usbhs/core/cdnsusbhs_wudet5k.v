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
//   Filename:           cdnsusbhs_wudet5k.v
//   Module Name:        cdnsusbhs_wudet5k
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
//   Slow clock part of Wake-up detector
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_wudet5k
  (
  wakeup5kclk,
  wakeup5krst,

  utmiiddig,
  utmilinestate,
  utmivbusvalid,
  utmiavalid,

  wakeupid_ack,
  wakeupdp_ack,
  wakeupvbus_ack,

  wakeupid,
  wakeupdp,
  wakeupvbus
  );

  input                                wakeup5kclk;
  input                                wakeup5krst;

  input                                utmiiddig;
  input                                utmilinestate;
  input                                utmivbusvalid;
  input                                utmiavalid;

  input                                wakeupid_ack;
  input                                wakeupdp_ack;
  input                                wakeupvbus_ack;

  output                               wakeupid;
  reg                                  wakeupid;
  output                               wakeupdp;
  reg                                  wakeupdp;
  output                               wakeupvbus;
  reg                                  wakeupvbus;

  reg                                  utmiiddig_r;
  reg                                  utmilinestate_r;
  reg                                  utmivbusvalid_r;
  reg                                  utmiavalid_r;








  `CDNSUSBHS_ALWAYS(wakeup5kclk,wakeup5krst)
    begin : UTMIIDDIG_SYNC_PROC
    if `CDNSUSBHS_RESET(wakeup5krst)
      begin
      utmiiddig_r <= 1'b0 ;
      end
    else
      begin
      utmiiddig_r <= utmiiddig ;
      end
    end




  `CDNSUSBHS_ALWAYS(wakeup5kclk,wakeup5krst)
    begin : WAKEUPID_SYNC_PROC
    if `CDNSUSBHS_RESET(wakeup5krst)
      begin
      wakeupid <= 1'b0 ;
      end
    else
      begin
      if (wakeupid_ack == 1'b1)
        begin
        wakeupid <= 1'b0 ;
        end
      else if (utmiiddig != utmiiddig_r)
        begin
        wakeupid <= 1'b1 ;
        end
      end
    end








  `CDNSUSBHS_ALWAYS(wakeup5kclk,wakeup5krst)
    begin : UTMILINESTATE_SYNC_PROC
    if `CDNSUSBHS_RESET(wakeup5krst)
      begin
      utmilinestate_r <= 1'b0 ;
      end
    else
      begin
      utmilinestate_r <= utmilinestate ;
      end
    end




  `CDNSUSBHS_ALWAYS(wakeup5kclk,wakeup5krst)
    begin : WAKEUPDP_SYNC_PROC
    if `CDNSUSBHS_RESET(wakeup5krst)
      begin
      wakeupdp <= 1'b0 ;
      end
    else
      begin
      if (wakeupdp_ack == 1'b1)
        begin
        wakeupdp <= 1'b0 ;
        end
      else if (utmilinestate != utmilinestate_r)
        begin
        wakeupdp <= 1'b1 ;
        end
      end
    end








  `CDNSUSBHS_ALWAYS(wakeup5kclk,wakeup5krst)
    begin : UTMIVBUSVALID_SYNC_PROC
    if `CDNSUSBHS_RESET(wakeup5krst)
      begin
      utmivbusvalid_r <= 1'b0 ;
      end
    else
      begin
      utmivbusvalid_r <= utmivbusvalid ;
      end
    end




  `CDNSUSBHS_ALWAYS(wakeup5kclk,wakeup5krst)
    begin : UTMIAVALID_SYNC_PROC
    if `CDNSUSBHS_RESET(wakeup5krst)
      begin
      utmiavalid_r <= 1'b0 ;
      end
    else
      begin
      utmiavalid_r <= utmiavalid ;
      end
    end




  `CDNSUSBHS_ALWAYS(wakeup5kclk,wakeup5krst)
    begin : WAKEUPVBUS_SYNC_PROC
    if `CDNSUSBHS_RESET(wakeup5krst)
      begin
      wakeupvbus <= 1'b0 ;
      end
    else
      begin
      if (wakeupvbus_ack == 1'b1)
        begin
        wakeupvbus <= 1'b0 ;
        end
      else if ((utmivbusvalid != utmivbusvalid_r) ||
               (utmiavalid    != utmiavalid_r))
        begin
        wakeupvbus <= 1'b1 ;
        end
      end
    end

endmodule

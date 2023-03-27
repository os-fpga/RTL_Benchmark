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
//   Filename:           cdnsusbhs_epinusb.v
//   Module Name:        cdnsusbhs_epinusb
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
//   IN endpoint - USB clock domain
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_epinusb
  (
  usbclk,
  usbrst,
  upbusyset,

  inxmaxpck,

  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  buffering,
  `endif
  eptype,
  isotoggle,
  upinbc,
  hsmode,
  endp,
  clrinbsy,
  rd,
  txfall,
  usbreset,
  discon,
  togglerst,
  toggleset,
  fiforst,
  usbbusyclr,
  isoerr,
  dvi,
  busy,
  toggle,

  sofpulse,
  hcsendsof,
  dmasof,

  isosofpulse,
  isodump2k,
  isodump1k,
  inxisodctrl,
  inxisoautodump,

  hcresend,
  hcdopingset,
  hcerrtype,
  hcepnr,
  hcepdir,
  hcerrinc,
  hcerrclr,
  hcerrset,
  hcepwaitclr,
  hcepwaitset,
  hcdevdopingset,
  hcdevdopingclr,
  upstren,
  enterhm,
  hcerrtypeusb,
  hcerrcountusb,
  isotoggleusb,
  hcoutxmaxpckusb,
  hcepsuspend,
  hcdoiso,
  hcepwait,
  hcdoping,

  hcsof_timer,
  hcsof_timer_start,
  hcsof_timer_stop,
  hcsof_timer_reload,
  hcsof_timer_end,

  usbfifoptrrd
  );

  parameter EPNUMBER    = 32'd1;
  parameter EPSIZE      = 32'd1024;
  parameter EPBUFFER    = 32'd4;
  parameter BCWIDTH     = 32'd11;


  parameter EPBMASK     = (EPBUFFER == 32'd1) ? 2'b00 :
                          (EPBUFFER == 32'd2) ? 2'b01 :
                                                2'b11 ;


  `include "cdnsusbhs_cusb2_params.v"

  input                            usbclk;
  input                            usbrst;
  input  [EPBUFFER-1:0]            upbusyset;

  input  [BCWIDTH-1:0]             inxmaxpck;

  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  input  [1:0]                     buffering;
  `endif
  input  [1:0]                     eptype;
  input  [1:0]                     isotoggle;
  input  [4*BCWIDTH-1:0]           upinbc;
  input                            hsmode;
  input  [3:0]                     endp;
  input                            clrinbsy;
  input                            rd;
  input                            txfall;
  input                            usbreset;
  input                            discon;
  input                            togglerst;
  input                            toggleset;
  input                            fiforst;
  output [EPBUFFER-1:0]            usbbusyclr;
  reg    [EPBUFFER-1:0]            usbbusyclr;
  output                           isoerr;
  reg                              isoerr;
  output                           dvi;
  reg                              dvi;
  output                           busy;
  wire                             busy;
  output [1:0]                     toggle;
  wire   [1:0]                     toggle;

  input                            sofpulse;
  input                            hcsendsof;
  output                           dmasof;
  wire                             dmasof;

  input                            isosofpulse;
  input                            isodump2k;
  input                            isodump1k;
  input                            inxisodctrl;
  input                            inxisoautodump;

  input                            hcresend;
  input                            hcdopingset;
  input  [2:0]                     hcerrtype;
  input  [3:0]                     hcepnr;
  input                            hcepdir;
  input                            hcerrinc;
  input                            hcerrclr;
  input                            hcerrset;
  input                            hcepwaitclr;
  input                            hcepwaitset;
  input                            hcdevdopingset;
  input                            hcdevdopingclr;
  input                            upstren;
  input                            enterhm;
  output [2:0]                     hcerrtypeusb;
  reg    [2:0]                     hcerrtypeusb;
  output [1:0]                     hcerrcountusb;
  reg    [1:0]                     hcerrcountusb;
  output [1:0]                     isotoggleusb;
  wire   [1:0]                     isotoggleusb;
  output [10:0]                    hcoutxmaxpckusb;
  reg    [10:0]                    hcoutxmaxpckusb;
  output                           hcepsuspend;
  reg                              hcepsuspend;
  output                           hcdoiso;
  reg                              hcdoiso;
  output                           hcepwait;
  reg                              hcepwait;
  output                           hcdoping;
  reg                              hcdoping;

  input  [15:0]                    hcsof_timer;
  input                            hcsof_timer_start;
  input                            hcsof_timer_stop;
  input                            hcsof_timer_reload;
  output                           hcsof_timer_end;
  wire                             hcsof_timer_end;

  output [11:0]                    usbfifoptrrd;
  reg    [11:0]                    usbfifoptrrd;

  reg    [BCWIDTH-1:0]             usbinxbc;
  wire   [BCWIDTH-1:0]             usbinxbc_nxt;

  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  wire   [1:0]                     usbbuffnr;
  reg    [1:0]                     usbbuffnr_reg;
  `endif

  reg    [BCWIDTH-1:0]             upinbcreg[EPBUFFER-1:0];
  reg    [BCWIDTH-1:0]             upinbc_a[3:0];
  wire   [BCWIDTH-1:0]             upinxbc;

  reg    [1:0]                     toggle_bit;

  reg    [EPBUFFER-1:0]            usb_busy;

  reg                              dvi_nxt;

  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  reg    [11:0]                    epsize_s;
  `ifdef CDNSUSBHS_NO_NEW_POINTER
  reg    [1:0]                     sizemod_s;
  `endif
  `endif
  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  `ifdef CDNSUSBHS_NO_NEW_POINTER
  reg    [1:0]                     inxmaxpck_s;
  `endif
  `endif
  reg    [11:0]                    usbinxbc_s;

  reg    [1:0]                     hcisotoggleusb;
  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  wire   [1:0]                     hcisotoggleusb_h;
  `else
  reg    [1:0]                     hcisotoggleusb_h;
  `endif
  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  reg    [1:0]                     hcisotoggleusb_d;
  `endif

  wire                             isodump;

  reg                              doiso;

  reg    [1:0]                     hcisocount;
  reg                              hcdopingrst;

  reg    [15:0]                    hcsof_timer_usb;
  reg                              hcsof_timer_reload_usb;

  reg                              hcsof_timer_en;
  wire                             hcsof_timer_epval_1;
  reg                              hcsof_timer_epval_1_r;
  wire                             hcsof_timer_epval;
  reg    [15:0]                    hcsof_timer_;




  assign isodump =
                   (upstren == 1'b0)                                  ? 1'b0 :
                   (eptype == EP_ISO &&
                    inxisoautodump == 1'b1 &&
                    doiso == 1'b1 &&
                    ((isodump2k == 1'b1 &&    toggle_bit == 2'b10)  ||
                     (isodump1k == 1'b1 &&   (toggle_bit == 2'b01   ||
                                              toggle_bit == 2'b10)) ||
                     (isosofpulse == 1'b1 && (toggle_bit == 2'b00   ||
                                              toggle_bit == 2'b01   ||
                                              toggle_bit == 2'b10)))) ? 1'b1 :
                                                                        1'b0 ;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DOISO_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      doiso <= 1'b0 ;
      end
    else
      begin
      if (eptype != EP_ISO || fiforst == 1'b1)
        begin
        doiso <= 1'b0 ;
        end
      else if (sofpulse == 1'b1)
        begin
      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
        if (usb_busy[0] == 1'b1)
      `else
        if (usb_busy[usbbuffnr] == 1'b1)
      `endif
          begin
          doiso <= 1'b1 ;
          end
        else
          begin
          doiso <= 1'b0 ;
          end
        end
      else if (toggle_bit == 2'b11)
        begin
        doiso <= 1'b0 ;
        end
      end
    end







  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  reg [3:0] usb_busy_v;

  always @(usb_busy)
    begin : USB_BUSY_PROC
    usb_busy_v               = 4'h0;
    usb_busy_v[EPBUFFER-1:0] = usb_busy;
    end
  `endif



  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  assign hcisotoggleusb_h = 2'b00 ;
  `else
  always @(isotoggle or usb_busy_v)
    begin : HCISOTOGGLEUSB_H_COMB_PROC



    if (isotoggle == 2'b11)
      begin
      case (usb_busy_v)
        `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4
          4'hF,
          4'h7,
          4'hB,
          4'hD,
          4'hE:
              begin
              hcisotoggleusb_h = 2'b10 ;
              end

          4'h3,
          4'h5,
          4'h6,
          4'h9,
          4'hC:
              begin
              hcisotoggleusb_h = 2'b01 ;
              end
        `else

        `ifdef CDNSUSBHS_EPIN_BUFFER_CC_3
          4'h7:
              begin
              hcisotoggleusb_h = 2'b10 ;
              end

          4'h3,
          4'h5,
          4'h6:
              begin
              hcisotoggleusb_h = 2'b01 ;
              end
        `else

          4'h3:
              begin
              hcisotoggleusb_h = 2'b01 ;
              end
        `endif
        `endif






          default :
              begin
              hcisotoggleusb_h = 2'b00 ;
              end
      endcase
      end
    else
      begin
      hcisotoggleusb_h = isotoggle ;
      end
    end
  `endif



  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  always @(isotoggle or usb_busy_v)
    begin : HCISOTOGGLEUSB_D_COMB_PROC



    case (usb_busy_v)
      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4
        4'hF,
        4'hE,
        4'hD,
        4'hB,
        4'h7 :
            begin
            if (isotoggle[1] == 1'b1)
              begin
              hcisotoggleusb_d = 2'b10 ;
              end
            else
              begin
              hcisotoggleusb_d = isotoggle ;
              end
            end


        4'hC,
        4'h9,
        4'h6,
        4'h5,
        4'h3 :
            begin
            if (isotoggle == 2'b00)
              begin
              hcisotoggleusb_d = 2'b00 ;
              end
            else
              begin
              hcisotoggleusb_d = 2'b01 ;
              end
            end

      `else
      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_3
        4'h7 :
            begin
            if (isotoggle[1] == 1'b1)
              begin
              hcisotoggleusb_d = 2'b10 ;
              end
            else
              begin
              hcisotoggleusb_d = isotoggle ;
              end
            end

        4'h6,
        4'h5,
        4'h3:
            begin
            if (isotoggle == 2'b00)
              begin
              hcisotoggleusb_d = 2'b00 ;
              end
            else
              begin
              hcisotoggleusb_d = 2'b01 ;
              end
            end

      `else
        4'h3:
            begin
            if (isotoggle == 2'b00)
              begin
              hcisotoggleusb_d = 2'b00 ;
              end
            else
              begin
              hcisotoggleusb_d = 2'b01 ;
              end
            end
      `endif
      `endif

        default :
            begin
            hcisotoggleusb_d = 2'b00 ;
            end
    endcase
    end
  `endif



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCISOTOGGLEUSB_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcisotoggleusb <= 2'b00;
      end
    else
      begin
      if (upstren == 1'b0)
        begin
        if (isotoggle == 2'b11)
          begin
          if (hcsendsof == 1'b1)
            begin
            hcisotoggleusb <= hcisotoggleusb_h ;
            end
          end
        else
          begin
          hcisotoggleusb <= isotoggle ;
          end
        end
      else
        begin
        if (inxisodctrl == 1'b1)
          begin
          if (hcsendsof == 1'b1)
            begin

            `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
            hcisotoggleusb <= 2'b00 ;
            `else
            hcisotoggleusb <= hcisotoggleusb_d ;
            `endif
            end
          end
        else
          begin
          hcisotoggleusb <= isotoggle ;
          end
        end
      end
    end




  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  assign busy = usb_busy[0] ;
  `else
  assign busy = usb_busy[usbbuffnr] ;
  `endif




  always @(upinbc)
    begin : UPINBCREG_TMP_SYNC_COMB_PROC
    upinbc_a[3] = upinbc[4 * BCWIDTH-1 : 3 * BCWIDTH] ;
    upinbc_a[2] = upinbc[3 * BCWIDTH-1 : 2 * BCWIDTH] ;
    upinbc_a[1] = upinbc[2 * BCWIDTH-1 : 1 * BCWIDTH] ;
    upinbc_a[0] = upinbc[1 * BCWIDTH-1 : 0 * BCWIDTH] ;
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : UPINBCREG_COMB_PROC
      integer i;
    if `CDNSUSBHS_RESET(usbrst)
      begin

      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin
        upinbcreg[i] <= {BCWIDTH{1'b0}} ;
        end
      end
    else
      begin
      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin
        if (fiforst == 1'b1)
          begin
          upinbcreg[i] <= {BCWIDTH{1'b0}} ;
          end
        else if (usb_busy[i] == 1'b1 && usbbusyclr[i] == 1'b1)
          begin
          upinbcreg[i] <= {BCWIDTH{1'b0}} ;
          end
        else if (upbusyset[i] == 1'b1)
          begin
          upinbcreg[i] <= upinbc_a[i] ;
          end
        end
      end
    end




  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  assign upinxbc = upinbcreg[0] ;
  `else
  assign upinxbc = upinbcreg[usbbuffnr] ;
  `endif





  always @(upinxbc)
    begin : HCOUTXMAXPCKUSB_COMB_PROC
    hcoutxmaxpckusb              = {11{1'b0}};
    hcoutxmaxpckusb[BCWIDTH-1:0] = upinxbc ;
    end




  always @(upinxbc or usbinxbc_nxt)
    begin : DVI_NXT_COMB_PROC
      reg [BCWIDTH:0] diff_v;


    diff_v   = ({1'b1, upinxbc}) -
               ({1'b0, usbinxbc_nxt});




    if (diff_v[BCWIDTH] == 1'b1)
      begin

      if (|diff_v[BCWIDTH-1:1] == 1'b1)
        begin

        dvi_nxt = 1'b1;
        end
      else if (diff_v[0] == 1'b1)
        begin

        dvi_nxt = 1'b1;
        end
      else
        begin

        dvi_nxt = 1'b0;
        end

      end

    else
      begin
      dvi_nxt = 1'b0;
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DVI_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      dvi <= 1'b0 ;
      end
    else
      begin
      dvi <= dvi_nxt ;
      end
    end

  `ifdef CDNSUSBHS_NO_NEW_POINTER
  `else



  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  always @(usbbuffnr or inxmaxpck)
    begin : EPSIZE_S_PROC
      reg [11:0] inxmaxpck_v;

    inxmaxpck_v = 12'h000;
    case (inxmaxpck[1:0])
      2'b11   : inxmaxpck_v[BCWIDTH-1:0] = inxmaxpck + 1'b1;
      2'b10   : inxmaxpck_v[BCWIDTH-1:0] = inxmaxpck + 2'b10;
      2'b01   : inxmaxpck_v[BCWIDTH-1:0] = inxmaxpck + 2'b11;
      default : inxmaxpck_v[BCWIDTH-1:0] = inxmaxpck;
    endcase


    case (usbbuffnr)
        `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4
        2'b11   : epsize_s = {inxmaxpck_v[10:0], 1'b0} + inxmaxpck_v;
        2'b10   : epsize_s = {inxmaxpck_v[10:0], 1'b0};
        `else
        `ifdef CDNSUSBHS_EPIN_BUFFER_CC_3
        2'b10   : epsize_s = {inxmaxpck_v[10:0], 1'b0};
        `endif
        `endif
        2'b01   : epsize_s =  inxmaxpck_v;

        default : epsize_s =  12'h000;
    endcase
    end
  `endif



  always @(usbinxbc)
    begin : USBINXBC_S_COMB_PROC
    usbinxbc_s              = {12{1'b0}};
    usbinxbc_s[BCWIDTH-1:0] = usbinxbc;
    end




  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  always @(usbinxbc_s)
    begin : USBFIFOPTRRD_COMB_PROC

    usbfifoptrrd = usbinxbc_s;
    end
  `else
  always @(usbinxbc_s or epsize_s)
    begin : USBFIFOPTRRD_COMB_PROC

    usbfifoptrrd = epsize_s + usbinxbc_s;
    end
  `endif
  `endif

  `ifdef CDNSUSBHS_NO_NEW_POINTER



  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  always @(usbinxbc or inxmaxpck)
  `else
  always @(usbinxbc or usbbuffnr or inxmaxpck)
  `endif
    begin : EPSIZE_S_PROC
      reg [11:0] usbinxbc_v;
      reg [11:0] inxmaxpck_v;
    `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
    `else
    `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4
      reg [8:0]  inxmaxpcksum_v;
    `endif
    `endif


    usbinxbc_v               = {12{1'b0}};
    usbinxbc_v[BCWIDTH-1:0]  = usbinxbc;

    inxmaxpck_v              = {12{1'b0}};
    inxmaxpck_v[BCWIDTH-1:0] = inxmaxpck;

    `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
    `else

    `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4
    inxmaxpcksum_v = {9{1'b0}};
    inxmaxpcksum_v = inxmaxpck_v[11:3] +
                     inxmaxpck_v[10:2];
    `endif





    case (usbbuffnr)
        `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4
        2'b11 :
            begin
            epsize_s  = {inxmaxpcksum_v[8:0], inxmaxpck_v[2], 2'b00} ;
            sizemod_s =  2'b11;
            end
        2'b10 :
            begin
            epsize_s  = {inxmaxpck_v[10:2], 3'b000};
            sizemod_s =  2'b10;
            end
        `else

        `ifdef CDNSUSBHS_EPIN_BUFFER_CC_3
        2'b10 :
            begin
            epsize_s  = {inxmaxpck_v[10:2], 3'b000};
            sizemod_s =  2'b10;
            end
        `endif
        `endif

        2'b01 :
            begin
            epsize_s  = {inxmaxpck_v[11:2], 2'b00};
            sizemod_s =  2'b01;
            end

        default :
            begin
            epsize_s  = 12'h000;
            sizemod_s =  2'b00;
            end
    endcase
    `endif

    `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
    `else
    inxmaxpck_s = inxmaxpck_v[1:0];
    `endif
    usbinxbc_s  = usbinxbc_v;
    end




  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  always @(usbinxbc_s)
    begin : USBFIFOPTRRD_COMB_PROC

    usbfifoptrrd = usbinxbc_s;
    end

  `else
  always @(usbinxbc_s or inxmaxpck_s or epsize_s or sizemod_s)
    begin : USBFIFOPTRRD_COMB_PROC
      reg [11:0] usbfifoptrrd_v;


    usbfifoptrrd_v = epsize_s + usbinxbc_s;

    if (inxmaxpck_s[0] == 1'b1 ||
        inxmaxpck_s[1] == 1'b1)
      begin

      usbfifoptrrd = usbfifoptrrd_v + {8'h00, sizemod_s, 2'b00} ;
      end
    else
      begin

      usbfifoptrrd = usbfifoptrrd_v ;
      end
    end
  `endif
  `endif




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : BUSY_USB_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usb_busy <= {EPBUFFER{INXCS_RV[1]}} ;
      end
    else
      begin
      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin
        if (fiforst == 1'b1)
          begin
          usb_busy[i] <= 1'b0 ;
          end
        else
          begin

          if ((usb_busy[i] == 1'b1 && usbbusyclr[i] == 1'b1) ||
               enterhm == 1'b1 ||
               usbreset == 1'b1 ||
              (discon == 1'b1 && upstren == 1'b1))
            begin
            usb_busy[i] <= 1'b0 ;
            end
          else if (upbusyset[i] == 1'b1)
            begin

            usb_busy[i] <= 1'b1 ;
            end
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBBUSYCLR_PROC
      integer i;
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usbbusyclr <= {EPBUFFER{1'b0}} ;
      end
    else
      begin
      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin

      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
        if ((clrinbsy == 1'b1 && endp == EPNUMBER[3:0]) ||

            (isodump  == 1'b1))
      `else
        if ((clrinbsy == 1'b1 && endp == EPNUMBER[3:0] && usbbuffnr == i) ||

            (isodump  == 1'b1 && usbbuffnr == i))
      `endif
          begin
          usbbusyclr[i] <= 1'b1 ;
          end
        else
          begin
          usbbusyclr[i] <= 1'b0 ;
          end
        end
      end
    end





  reg    [BCWIDTH-1:0]             usbinxbc_nxt_v ;

  always @(rd or usbinxbc)
    begin : USBINXBC_NXT_V_COMB_PROC


    if (rd == 1'b1)
      begin

      usbinxbc_nxt_v = usbinxbc + 2'b01 ;
      end
    else
      begin
      usbinxbc_nxt_v = usbinxbc ;
      end
    end



  assign usbinxbc_nxt = usbinxbc_nxt_v[BCWIDTH-1:0];




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBINXBC_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usbinxbc <= {BCWIDTH{1'b0}} ;
      end
    else
      begin
      if (txfall == 1'b1 && rd == 1'b0 && endp == EPNUMBER[3:0])

        begin

        usbinxbc <= {BCWIDTH{1'b0}} ;
        end
      else
        begin

        if (endp == EPNUMBER[3:0])
          begin
          usbinxbc <= usbinxbc_nxt;
          end
        end
      end
    end

  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBBUFFNR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usbbuffnr_reg <= {2{1'b0}} ;
      end
    else
      begin
      if (fiforst == 1'b1)
        begin
        usbbuffnr_reg <= {2{1'b0}} ;
        end
      else
        begin
        if ((clrinbsy == 1'b1 && endp == EPNUMBER[3:0]) ||
             isodump  == 1'b1)
          begin
          if (buffering == usbbuffnr)
            begin
            usbbuffnr_reg <= {2{1'b0}} ;
            end
          else
            begin
            usbbuffnr_reg <= usbbuffnr + 1'b1 ;
            end
          end
        end
      end
    end




  assign usbbuffnr = (EPBMASK & usbbuffnr_reg);
  `endif




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TOGGLE_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      toggle_bit <= 2'b00 ;
      end
    else
      begin

      case (eptype)
          EP_ISO :
              begin
              if (togglerst == 1'b1)
                begin
                toggle_bit <= hcisotoggleusb ;
                end
              else if ((sofpulse   == 1'b1 && upstren == 1'b1) ||
                       (hcsendsof  == 1'b1 && upstren == 1'b0))
                begin

                if (hsmode == 1'b1)
                  begin
                  if (isotoggle == 2'b11 && upstren == 1'b0)
                    begin
                    toggle_bit <= hcisotoggleusb_h ;
                    end
                  else
                    begin
                    toggle_bit <= hcisotoggleusb ;
                    end
                  end
                else
                  begin
                  toggle_bit <= 2'b00 ;
                  end
                end
              else if (clrinbsy == 1'b1 && endp == EPNUMBER[3:0])
                begin
                if (toggle_bit != 2'b11)
                  begin
                  toggle_bit <= toggle_bit - 1'b1 ;
                  end
                end
              end
          default :
              begin

              if (togglerst == 1'b1)
                begin
                toggle_bit <= 2'b00 ;
                end
              else if (toggleset == 1'b1)
                begin
                toggle_bit <= 2'b01 ;
                end
              else if (clrinbsy == 1'b1 && endp == EPNUMBER[3:0])
                begin

                toggle_bit <= toggle_bit + 1'b1 ;
                end
              end
      endcase
      end
    end




  assign toggle = toggle_bit ;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : ISOERR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      isoerr <= INXCS_RV[0] ;
      end
    else
      begin
      case (eptype)
          EP_ISO :
              begin
              if (togglerst == 1'b1)
                begin
                isoerr <= 1'b0 ;
                end
              else
                begin
                if (upstren == 1'b1)
                  begin

                  if (sofpulse == 1'b1)
                    begin
                    if (toggle_bit == 2'b11)
                      begin
                      isoerr <= 1'b0 ;
                      end
                    else
                      begin
                      isoerr <= 1'b1 ;
                      end
                    end
                  end
                else
                  begin

                  if (hcsendsof == 1'b1)
                    begin
                    if (hcisocount == 2'b00)
                      begin
                      isoerr <= 1'b0 ;
                      end
                    else
                      begin
                      isoerr <= 1'b1 ;
                      end
                    end
                  end
                end
              end
          default :
              begin

              isoerr <= 1'b0 ;
              end
      endcase
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCERR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcerrtypeusb  <= 3'b000 ;
      hcerrcountusb <= 2'b00 ;
      end
    else
      begin
      if (fiforst == 1'b1 ||
          hcresend == 1'b1)
        begin


        hcerrtypeusb  <= 3'b000 ;
        hcerrcountusb <= 2'b00 ;
        end
      else if (hcepnr == EPNUMBER[3:0] && hcepdir == 1'b0)
        begin
        if (hcerrinc == 1'b1)
          begin
          hcerrtypeusb  <= hcerrtype ;
          hcerrcountusb <= hcerrcountusb + 1'b1 ;
          end
        else if (hcerrset == 1'b1)
          begin
          hcerrtypeusb  <= hcerrtype ;
          hcerrcountusb <= 2'b11 ;
          end
        else if (hcerrclr == 1'b1)
          begin
          hcerrtypeusb  <= 3'b000 ;
          hcerrcountusb <= 2'b00 ;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCEPSUSPEND_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcepsuspend <= 1'b0 ;
      end
    else
      begin
      if (fiforst == 1'b1 ||
          hcresend == 1'b1)
        begin

        hcepsuspend <= 1'b0 ;
        end
      else if (hcerrcountusb == 2'b11)
        begin
        hcepsuspend <= 1'b1 ;
        end
      end
    end



  assign isotoggleusb = hcisotoggleusb ;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDOISO_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcdoiso <= 1'b0 ;
      end
    else
      begin
      if (eptype != EP_ISO)
        begin
        hcdoiso <= hcsof_timer_epval;
        end
      else if (hcsendsof == 1'b1)
        begin
        `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
        if (usb_busy[0] == 1'b1)
        `else
        if (usb_busy[usbbuffnr] == 1'b1)
        `endif
          begin
          hcdoiso <= hcsof_timer_epval;
          end
        else
          begin
          hcdoiso <= 1'b0 ;
          end
        end
      else if (hcisocount == 2'b00)
        begin
        hcdoiso <= 1'b0 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCISOCOUNT_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcisocount <= 2'b00 ;
      end
    else
      begin
      if (hcsendsof == 1'b1 || fiforst == 1'b1)
        begin
        if (hsmode == 1'b0)
          begin
          hcisocount <= 2'b01 ;
          end
        else if (isotoggle == 2'b11 && upstren == 1'b0)
          begin
          case (hcisotoggleusb_h)
              2'b00   : hcisocount <= 2'b01 ;
              2'b01   : hcisocount <= 2'b10 ;
              default : hcisocount <= 2'b11 ;
          endcase
          end
        else
          begin
          case (hcisotoggleusb)
              2'b00   : hcisocount <= 2'b01 ;
              2'b01   : hcisocount <= 2'b10 ;
              default : hcisocount <= 2'b11 ;
          endcase
          end
        end
      else if (clrinbsy == 1'b1 && hcepnr == EPNUMBER[3:0] &&
               hcisocount != 2'b00 &&
               hcepdir == 1'b0)
        begin
        hcisocount <= hcisocount - 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCEPWAIT_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcepwait <= 1'b0 ;
      end
    else
      begin
      if (hcsendsof == 1'b1 ||
          hcepwaitclr == 1'b1)
        begin

        hcepwait <= 1'b0 ;
        end
      else if (hcepnr == EPNUMBER[3:0] && hcepdir == 1'b0 &&
               hcepwaitset == 1'b1)
        begin


        hcepwait <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDOPING_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcdoping <= 1'b0 ;
      end
    else if (hsmode == 1'b0 ||
             hcdopingrst == 1'b1 ||
             eptype != EP_BULK)
      begin
      hcdoping <= 1'b0 ;
      end
    else
      begin
      if ((hcepnr == EPNUMBER[3:0] && hcepdir == 1'b0) ||
           hcdopingset == 1'b1)
        begin


        if (hcdevdopingset == 1'b1 ||
            hcdopingset == 1'b1)
          begin
          hcdoping <= 1'b1 ;
          end
        else if (hcdevdopingclr == 1'b1)
          begin
          hcdoping <= 1'b0 ;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDOPINGRST_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcdopingrst <= 1'b0 ;
      end
    else
      begin
      if (fiforst == 1'b1)
        begin
        hcdopingrst <= 1'b1 ;
        end
      else
        begin
        if (hcdevdopingset == 1'b0 &&
            hcdopingset == 1'b0)
          begin
          hcdopingrst <= 1'b0;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCSOF_TIMER_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcsof_timer_usb        <= 16'h0000 ;
      hcsof_timer_           <= 16'h0000 ;
      hcsof_timer_reload_usb <= 1'b0 ;
      hcsof_timer_en         <= 1'b0 ;
      end
    else
      begin
      if (upstren == 1'b1 || fiforst == 1'b1)
        begin
        hcsof_timer_usb        <= 16'h0000 ;
        hcsof_timer_           <= 16'h0000 ;
        hcsof_timer_reload_usb <= 1'b0 ;
        hcsof_timer_en         <= 1'b0 ;
        end
      else if (hcsof_timer_start == 1'b1)
        begin
        hcsof_timer_usb        <= hcsof_timer ;
        hcsof_timer_           <= hcsof_timer ;
        hcsof_timer_reload_usb <= hcsof_timer_reload ;
        hcsof_timer_en         <= 1'b1 ;
        end
      else if (hcsof_timer_stop == 1'b1)
        begin
        hcsof_timer_usb        <= hcsof_timer ;
        hcsof_timer_           <= hcsof_timer ;
        hcsof_timer_reload_usb <= 1'b0 ;
        hcsof_timer_en         <= 1'b0 ;
        end
      else if (hcsendsof == 1'b1 && hcsof_timer_en == 1'b1)
        begin
        if (hcsof_timer_usb == 16'h0001)
          begin
          hcsof_timer_usb <= hcsof_timer_;
          if (hcsof_timer_reload_usb == 1'b0)
            begin
            hcsof_timer_en <= 1'b0 ;
            end
          end
        else if (hcsof_timer_usb != 16'h0000)
          begin
          hcsof_timer_usb <= hcsof_timer_usb - 1'b1;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCSOF_TIMER_EPVAL_1_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcsof_timer_epval_1_r <= 1'b0 ;
      end
    else
      begin
      if (upstren == 1'b1 || fiforst == 1'b1)
        begin
        hcsof_timer_epval_1_r <= 1'b0 ;
        end
      else if (hcsof_timer_start == 1'b1)
        begin
        hcsof_timer_epval_1_r <= 1'b0 ;
        end
      else if (hcsendsof == 1'b1)
        begin
        hcsof_timer_epval_1_r <= hcsof_timer_epval_1 ;
        end
      end
    end



  assign hcsof_timer_end = (hcsof_timer_stop       == 1'b1) ? 1'b1 :
                           (hcsof_timer_reload_usb == 1'b0) ? (hcsof_timer_epval_1 & hcsendsof) :
                                                              1'b0 ;



  assign hcsof_timer_epval_1 = (hcsof_timer_usb == 16'h0001) ? 1'b1 :
                               (hcsof_timer_usb == 16'h0000) ? 1'b1 :
                                                               1'b0 ;



  assign hcsof_timer_epval =
                            (hcsof_timer_ == 16'h0001) ? 1'b1 :
                            (hcsof_timer_ == 16'h0000) ? 1'b1 :
                                  (eptype == EP_ISO)   ? hcsof_timer_epval_1 :
                                                         hcsof_timer_epval_1_r ;



  assign dmasof = (upstren == 1'b1) ? sofpulse :
                                      hcsendsof & hcsof_timer_epval_1 ;

endmodule

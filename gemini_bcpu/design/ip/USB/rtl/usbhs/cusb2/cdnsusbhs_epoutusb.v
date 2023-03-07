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
//   Filename:           cdnsusbhs_epoutusb.v
//   Module Name:        cdnsusbhs_epoutusb
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
//   OUT endpoint - USB clock domain
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_epoutusb
  (
  usbclk,
  usbrst,
  upbusyset,
  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else
  buffering,
  `endif
  eptype,
  epval,
  hsmode,
  endp,
  clroutbsy,
  pid,
  wr,
  overflowwr,
  tokrcvfall,
  togglerst,
  toggleset,
  fiforst,
  usboutbc,
  usbbusyclr,
  isoerr,
  bufffull,
  busy,
  nxtbusy,
  toggle,
  usbfifoptrwr,

  hcsendsof,
  dmasof,

  hcisotoggle,
  hcresend,
  hcerrtype,
  hcepnr,
  hcepdir,
  hcerrinc,
  hcerrclr,
  hcerrset,
  hcepwaitclr,
  hcepwaitset,
  sendtok,
  hcisostop,
  upstren,
  enterhm,
  hcerrtypeusb,
  hcerrcountusb,
  hcepsuspend,
  hcinxmaxpckusb,
  hcdoiso,
  hcepwait,

  buf_enable_auto,
  buf_enable_start,
  buf_enable_data,

  outxmaxpck,

  hcsof_timer,
  hcsof_timer_start,
  hcsof_timer_stop,
  hcsof_timer_reload,
  hcsof_timer_end,

  sofpulse
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
  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else
  input  [1:0]                     buffering;
  `endif
  input  [1:0]                     eptype;
  input                            epval;
  input                            hsmode;
  input  [3:0]                     endp;
  input                            clroutbsy;
  input  [4:0]                     pid;
  input                            wr;
  input                            overflowwr;
  input                            tokrcvfall;
  input                            togglerst;
  input                            toggleset;
  input                            fiforst;
  output [4*BCWIDTH-1:0]           usboutbc;
  wire   [4*BCWIDTH-1:0]           usboutbc;
  output [EPBUFFER-1:0]            usbbusyclr;
  reg    [EPBUFFER-1:0]            usbbusyclr;
  output                           isoerr;
  reg                              isoerr;
  output                           bufffull;
  wire                             bufffull;
  output                           busy;
  wire                             busy;
  output                           nxtbusy;
  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  wire                             nxtbusy;
  `else
  reg                              nxtbusy;
  `endif
  output [1:0]                     toggle;
  wire   [1:0]                     toggle;
  output [11:0]                    usbfifoptrwr;
  reg    [11:0]                    usbfifoptrwr;

  input                            sofpulse;

  input                            hcsendsof;
  output                           dmasof;
  wire                             dmasof;

  input  [1:0]                     hcisotoggle;
  input                            hcresend;
  input  [2:0]                     hcerrtype;
  input  [3:0]                     hcepnr;
  input                            hcepdir;
  input                            hcerrinc;
  input                            hcerrclr;
  input                            hcerrset;
  input                            hcepwaitclr;
  input                            hcepwaitset;
  input                            sendtok;
  input                            hcisostop;
  input                            upstren;
  input                            enterhm;
  output [2:0]                     hcerrtypeusb;
  reg    [2:0]                     hcerrtypeusb;
  output [1:0]                     hcerrcountusb;
  reg    [1:0]                     hcerrcountusb;
  output                           hcepsuspend;
  reg                              hcepsuspend;
  output [10:0]                    hcinxmaxpckusb;
  reg    [10:0]                    hcinxmaxpckusb;
  output                           hcdoiso;
  reg                              hcdoiso;
  output                           hcepwait;
  reg                              hcepwait;

  input                            buf_enable_auto;
  input                            buf_enable_start;
  input  [3:0]                     buf_enable_data;

  input  [BCWIDTH-1:0]             outxmaxpck;

  input  [15:0]                    hcsof_timer;
  input                            hcsof_timer_start;
  input                            hcsof_timer_stop;
  input                            hcsof_timer_reload;
  output                           hcsof_timer_end;
  wire                             hcsof_timer_end;

  reg    [BCWIDTH-1:0]             usboutbc_a[3:0];
  `ifdef CDNSUSBHS_NO_UPOUTXBC_SYNCFF
  `else
  reg    [BCWIDTH-1:0]             usboutbc_c[3:0];
  `endif
  reg    [BCWIDTH-1:0]             usboutovbc_nxt;
  reg    [BCWIDTH-1:0]             usboutovbc;

  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else
  wire   [1:0]                     usbbuffnr;
  reg    [1:0]                     usbbuffnr_reg;
  `endif

  reg    [1:0]                     toggle_bit;

  reg    [EPBUFFER-1:0]            usb_busy;

  reg                              iso_err;

  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else
  reg    [11:0]                    epsize_s;
  `ifdef CDNSUSBHS_NO_NEW_POINTER
  reg    [1:0]                     sizemod_s;
  `endif
  `endif

  reg    [11:0]                    usboutxbc_s;
  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else
  `ifdef CDNSUSBHS_NO_NEW_POINTER
  reg    [1:0]                     outxmaxpck_s;
  `endif
  `endif

  wire   [BCWIDTH-1:0]             usboutxbc;

  reg    [1:0]                     hcisocount;

  reg    [15:0]                    hcsof_timer_usb;
  reg                              hcsof_timer_reload_usb;

  reg                              hcsof_timer_en;
  wire                             hcsof_timer_epval_1;
  reg                              hcsof_timer_epval_1_r;
  wire                             hcsof_timer_epval;
  reg    [15:0]                    hcsof_timer_;

  reg                              epvaldma;

  reg    [3:0]                     usb_busy_s;
  reg    [3:1]                     outxcs;
  reg    [3:0]                     buf_enable;




  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  assign busy = usb_busy[0];
  `else
  assign busy = usb_busy[usbbuffnr];
  `endif




  `ifdef CDNSUSBHS_NO_UPOUTXBC_SYNCFF
  assign usboutbc = {usboutbc_a[3],
                     usboutbc_a[2],
                     usboutbc_a[1],
                     usboutbc_a[0]};
  `else
  assign usboutbc = {usboutbc_c[3],
                     usboutbc_c[2],
                     usboutbc_c[1],
                     usboutbc_c[0]};
  `endif




  `ifdef CDNSUSBHS_NO_UPOUTXBC_SYNCFF
  `else
  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBOUTBC_C_PROC
      integer i;
    if `CDNSUSBHS_RESET(usbrst)
      begin
      for(i = 3; i >= 0; i = i - 1)
        begin
        usboutbc_c[i] <= {BCWIDTH{1'b0}};
        end
      end
    else
      begin


      for(i = 3; i >= EPBUFFER; i = i - 1)
        begin
        usboutbc_c[i] <= {BCWIDTH{1'b0}};
        end

      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin
        if (usb_busy[i] == 1'b1 && usbbusyclr[i] == 1'b1)
          begin
          usboutbc_c[i] <= usboutbc_a[i];
          end
        end
      end
    end
  `endif




  assign toggle = toggle_bit;



  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  assign usboutxbc = usboutbc_a[0];
  `else
  assign usboutxbc = usboutbc_a[usbbuffnr];
  `endif

  `ifdef CDNSUSBHS_NO_NEW_POINTER
  `else



  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else
  always @(usbbuffnr or outxmaxpck)
    begin : USBFIFOPTRWR_COMB_PROC
      reg [11:0] outxmaxpck_v;

    outxmaxpck_v = 12'h000;
    case (outxmaxpck[1:0])
      2'b11   : outxmaxpck_v[BCWIDTH-1:0] = outxmaxpck + 1'b1;
      2'b10   : outxmaxpck_v[BCWIDTH-1:0] = outxmaxpck + 2'b10;
      2'b01   : outxmaxpck_v[BCWIDTH-1:0] = outxmaxpck + 2'b11;
      default : outxmaxpck_v[BCWIDTH-1:0] = outxmaxpck;
    endcase


    case (usbbuffnr)
        `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_4
        2'b11   : epsize_s = {outxmaxpck_v[10:0], 1'b0} + outxmaxpck_v;
        2'b10   : epsize_s = {outxmaxpck_v[10:0], 1'b0};
        `else
        `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_3
        2'b10   : epsize_s = {outxmaxpck_v[10:0], 1'b0};
        `endif
        `endif
        2'b01   : epsize_s =  outxmaxpck_v;

        default : epsize_s =  12'h000;
    endcase
    end
  `endif



  always @(usboutxbc)
    begin : USBOUTXBC_S_COMB_PROC

    usboutxbc_s              = {12{1'b0}};
    usboutxbc_s[BCWIDTH-1:0] = usboutxbc;
    end




  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  always @(usboutxbc_s)
    begin : USBFIFOPTRWR_WRITE_PROC

    usbfifoptrwr = usboutxbc_s;
    end
  `else
  always @(usboutxbc_s or epsize_s)
    begin : USBFIFOPTRWR_WRITE_PROC

    usbfifoptrwr = epsize_s + usboutxbc_s;
    end
  `endif
  `endif

  `ifdef CDNSUSBHS_NO_NEW_POINTER




  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  always @(usboutxbc or outxmaxpck)
  `else
  always @(usboutxbc or usbbuffnr or outxmaxpck)
  `endif
    begin : USBFIFOPTRWR_COMB_PROC
      reg [11:0] usboutxbc_v;
      reg [11:0] outxmaxpck_v;
    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
    `else
    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_4
      reg [8:0]  outxmaxpcksum_v;
    `endif
    `endif


    usboutxbc_v               = {12{1'b0}};
    usboutxbc_v[BCWIDTH-1:0]  = usboutxbc;

    outxmaxpck_v              = 12'h000;
    outxmaxpck_v[BCWIDTH-1:0] = outxmaxpck;

    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
    `else

    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_4
    outxmaxpcksum_v = {9{1'b0}};
    outxmaxpcksum_v = outxmaxpck_v[11:3] +
                      outxmaxpck_v[10:2];
    `endif





    case (usbbuffnr)
        `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_4
        2'b11 :
            begin
            epsize_s  = {outxmaxpcksum_v[8:0], outxmaxpck_v[2], 2'b00};
            sizemod_s =  2'b11;
            end
        2'b10 :
            begin
            epsize_s  = {outxmaxpck_v[10:2], 3'b000};
            sizemod_s =  2'b10;
            end
        `else

        `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_3
        2'b10 :
            begin
            epsize_s  = {outxmaxpck_v[10:2], 3'b000};
            sizemod_s =  2'b10;
            end
        `endif
        `endif

        2'b01 :
            begin
            epsize_s  = {outxmaxpck_v[11:2], 2'b00};
            sizemod_s =  2'b01;
            end

        default :
            begin
            epsize_s  = 12'h000;
            sizemod_s =  2'b00;
            end
    endcase
    `endif

    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
    `else
    outxmaxpck_s = outxmaxpck_v[1:0];
    `endif
    usboutxbc_s  = usboutxbc_v;
    end




  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  always @(usboutxbc_s)
    begin : USBFIFOPTRWR_WRITE_PROC

    usbfifoptrwr = usboutxbc_s;
    end

  `else
  always @(usboutxbc_s or outxmaxpck_s or sizemod_s or epsize_s)
    begin : USBFIFOPTRWR_WRITE_PROC
      reg [11:0] usbfifoptrwr_v;

    usbfifoptrwr_v = epsize_s + usboutxbc_s;

    if (outxmaxpck_s[0] == 1'b1 ||
        outxmaxpck_s[1] == 1'b1)
      begin
      usbfifoptrwr = usbfifoptrwr_v + {8'h00, sizemod_s, 2'b00};
      end
    else
      begin
      usbfifoptrwr = usbfifoptrwr_v;
      end
    end
  `endif
  `endif











  assign bufffull = (usboutovbc >= outxmaxpck) ? 1'b1 :
                                                 1'b0 ;




  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  assign nxtbusy = 1'b0;
  `else
  always @(usb_busy or buffering or usbbuffnr)
    begin : NXTBUSY_COMB_PROC
      reg [3:0] usb_busy_v;




    usb_busy_v               = 4'h0;
    usb_busy_v[EPBUFFER-1:0] = usb_busy;


    if (buffering == 2'b00)
      begin

      nxtbusy = 1'b0;
      end
    else if (usbbuffnr == buffering)
      begin
      nxtbusy = usb_busy_v[0];
      end
    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_4
    else if (usbbuffnr == 2'b00)
      begin
      nxtbusy = usb_busy_v[1];
      end
    else if (usbbuffnr == 2'b01)
      begin
      nxtbusy = usb_busy_v[2];
      end
    else
      begin
      nxtbusy = usb_busy_v[3];
      end
    `else
    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_3
    else if (usbbuffnr == 2'b00)
      begin
      nxtbusy = usb_busy_v[1];
      end
    else
      begin
      nxtbusy = usb_busy_v[2];
      end
    `else
    else
      begin
      nxtbusy = usb_busy_v[1];
      end
    `endif
    `endif
    end
  `endif




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : BUSY_USB_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usb_busy <= {EPBUFFER{OUTXCS_RV[1]}};
      end
    else
      begin
      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin

        if (fiforst == 1'b1 && upstren == 1'b1)
          begin

          usb_busy[i] <= 1'b1;
          end
        else if ((usb_busy[i] == 1'b1 && usbbusyclr[i] == 1'b1) ||
                  enterhm == 1'b1 ||
                  fiforst == 1'b1)
          begin

          usb_busy[i] <= 1'b0;
          end
        else if (upbusyset[i] == 1'b1)
          begin

          usb_busy[i] <= 1'b1;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBBUSYCLR_PROC
      integer i;
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usbbusyclr <= {EPBUFFER{1'b0}};
      end
    else
      begin
      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin

      `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
        if (clroutbsy == 1'b1 && endp == EPNUMBER[3:0])
      `else
        if (clroutbsy == 1'b1 && endp == EPNUMBER[3:0] && usbbuffnr == i)
      `endif
          begin
          usbbusyclr[i] <= 1'b1;
          end
        else
          begin
          usbbusyclr[i] <= 1'b0;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBOUTBC_A_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(usbrst)
      begin
      for(i = 3; i >= 0; i = i - 1)
        begin
        usboutbc_a[i] <= {BCWIDTH{1'b0}};
        end
      end
    else
      begin


      for(i = 3; i >= EPBUFFER; i = i - 1)
        begin
        usboutbc_a[i] <= {BCWIDTH{1'b0}};
        end

      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin
        if (fiforst == 1'b1)
          begin

          usboutbc_a[i] <= {BCWIDTH{1'b0}};
          end
      `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
        else if (endp == EPNUMBER[3:0])
      `else
        else if (endp == EPNUMBER[3:0] && i == usbbuffnr)
      `endif
          begin
          if (((pid == PID_OUT && tokrcvfall == 1'b1) || sendtok == 1'b1) && busy == 1'b1)
            begin

            usboutbc_a[i] <= {BCWIDTH{1'b0}};
            end
          else if (wr == 1'b1)
            begin

              usboutbc_a[i] <= usboutxbc + 2'b01;
            end
          end
        end
      end
    end




  always @(pid or usboutovbc or tokrcvfall or endp or
           overflowwr or sendtok)
    begin : USBOUTOVBC_NXT_COMB_PROC



    usboutovbc_nxt = usboutovbc;


    if (((pid == PID_OUT && tokrcvfall == 1'b1) || sendtok == 1'b1) &&
          endp == EPNUMBER[3:0])
      begin
      usboutovbc_nxt = {BCWIDTH{1'b0}};
      end
    else if (endp == EPNUMBER[3:0] && overflowwr == 1'b1)
      begin

      usboutovbc_nxt = usboutovbc + 2'b01;
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBOUTOVBC_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usboutovbc <= {BCWIDTH{1'b0}};
      end
    else
      begin
      if (fiforst == 1'b1)
        begin

        usboutovbc <= {BCWIDTH{1'b0}};
        end
      else
        begin
        usboutovbc <= usboutovbc_nxt;
        end
      end
    end

  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else


  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBBUFFNR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usbbuffnr_reg <= {2{1'b0}};
      end
    else
      begin
      if (fiforst == 1'b1)
        begin

        usbbuffnr_reg <= {2{1'b0}};
        end
      else
        begin
        if (clroutbsy == 1'b1 && endp == EPNUMBER[3:0])
          begin
          if (buffering == usbbuffnr)
            begin
            usbbuffnr_reg <= {2{1'b0}};
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
      toggle_bit <= 2'b00;
      end
    else
      begin
      case (eptype)
          EP_ISO :
              begin


              if (togglerst == 1'b1)
                begin
                toggle_bit <= 2'b00;
                end
              else
                begin
                if (upstren == 1'b1)
                  begin

                  if (sofpulse == 1'b1)
                    begin
                    toggle_bit <= 2'b00;
                    end
                  else if (clroutbsy == 1'b1 && endp == EPNUMBER[3:0])
                    begin

                    if (toggle_bit != 2'b11)
                      begin
                      toggle_bit <= toggle_bit + 1'b1;
                      end
                    end
                  end
                end
              end
          default :
              begin


              if (togglerst == 1'b1)
                begin
                toggle_bit <= 2'b00;
                end
              else if (toggleset == 1'b1)
                begin
                toggle_bit <= 2'b01;
                end
              else
                begin
                if (clroutbsy == 1'b1 && endp == EPNUMBER[3:0])
                  begin

                  toggle_bit <= toggle_bit + 1'b1;
                  end
                end
              end
      endcase
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : ISO_ERR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      iso_err <= 1'b0;
      end
    else
      begin
      if (eptype == EP_ISO && hsmode == 1'b1)
        begin
        if (upstren == 1'b1)
          begin
          if (clroutbsy == 1'b1 && endp == EPNUMBER[3:0] &&
            ((pid == PID_DATA0 && toggle_bit == 2'b00) ||
             (pid == PID_DATA1 && toggle_bit == 2'b01) ||
             (pid == PID_DATA2 && toggle_bit == 2'b10)))
            begin

            iso_err <= 1'b0;
            end
          else if (sofpulse == 1'b1)
            begin
            iso_err <= 1'b1;
            end
          end
        else
          begin

          if (clroutbsy == 1'b1 && endp == EPNUMBER[3:0] &&
            ~((pid == PID_DATA0 && hcisocount == 2'b01) ||
              (pid == PID_DATA1 && hcisocount == 2'b10) ||
              (pid == PID_DATA2 && hcisocount == 2'b11)))
            begin

            iso_err <= 1'b1 ;
            end
          else if (hcsendsof == 1'b1)
            begin
            iso_err <= 1'b0;
            end
          end
        end
      else
        begin
        iso_err <= 1'b0;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : ISOERR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      isoerr <= 1'b0;
      end
    else
      begin
      case (eptype)
          EP_ISO :
              begin
              if (togglerst == 1'b1)
                begin
                isoerr <= 1'b0;
                end
              else
                begin
                if (upstren == 1'b1)
                  begin

                  if (sofpulse == 1'b1)
                    begin
                    if (toggle_bit == 2'b00 || iso_err == 1'b1)
                      begin


                      isoerr <= 1'b1;
                      end
                    else
                      begin
                      isoerr <= 1'b0;
                      end
                    end
                  end
                else
                  begin

                  if (hcsendsof == 1'b1)
                    begin
                    if (iso_err == 1'b1 ||
                        hcisocount != 2'b00)
                      begin
                      isoerr <= 1'b1 ;
                      end
                    else
                      begin
                      isoerr <= 1'b0 ;
                      end
                    end
                  end
                end
              end
          default :
              begin

              isoerr <= 1'b0;
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
      else if (hcepnr == EPNUMBER[3:0] &&
               hcepdir == 1'b1)
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




  always @(outxmaxpck)
    begin : HCINXMAXPCKUSB_COMB_PROC

    hcinxmaxpckusb              = {11{1'b0}} ;

    hcinxmaxpckusb[BCWIDTH-1:0] = outxmaxpck ;
    end




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
        hcdoiso <= epvaldma;
        end
      else if (hcsendsof == 1'b1)
        begin
        if (busy == 1'b1)
          begin
          hcdoiso <= epvaldma;
          end
        else
          begin
          hcdoiso <= 1'b0 ;
          end
        end
      else if (hcisocount == 2'b00 ||
               (hcisostop == 1'b1 &&
                hcepnr == EPNUMBER[3:0] && hcepdir == 1'b1))
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
        else
          begin
          case (hcisotoggle)
              2'b00   : hcisocount <= 2'b01 ;
              2'b01   : hcisocount <= 2'b10 ;
              default : hcisocount <= 2'b11 ;
          endcase
          end
        end
      else if (hcepnr == EPNUMBER[3:0] && hcepdir == 1'b1 &&
               clroutbsy == 1'b1 &&
               hcisocount != 2'b00)
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
      else if (hcepnr == EPNUMBER[3:0] && hcepdir == 1'b1 &&
               hcepwaitset == 1'b1)
        begin


        hcepwait <= 1'b1 ;
        end
      end
    end




  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  always @(usb_busy)
  `else
  always @(usb_busy or buffering)
  `endif
    begin : USB_BUSY_S_COMB_PROC
      reg [3:0] usb_busy_v;




    usb_busy_v               = 4'hF ;
    usb_busy_v[EPBUFFER-1:0] = usb_busy ;

    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
          usb_busy_s = {3'b111, usb_busy_v[0]} ;
    `else

    case (buffering)
      `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_4
      2'b11 :
          begin
          usb_busy_s = usb_busy_v ;
          end
      2'b10 :
          begin
          usb_busy_s = {1'b1,   usb_busy_v[2:0]} ;
          end
      `else

      `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_3
      2'b10 :
          begin
          usb_busy_s = {1'b1,   usb_busy_v[2:0]} ;
          end
      `endif
      `endif

      2'b01 :
          begin
          usb_busy_s = {2'b11,  usb_busy_v[1:0]} ;
          end

      default :
          begin
          usb_busy_s = {3'b111, usb_busy_v[0]} ;
          end
    endcase
    `endif
    end




  always @(usb_busy_s)
    begin : OUTXCS_COMB_PROC


    outxcs[1] = &usb_busy_s;


    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
            outxcs[3:2] = 2'b00;
    `else
    case (usb_busy_s)
      `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_4
        4'h0 :
            begin
            outxcs[3:2] = 2'b11;
            end

        4'h8,
        4'h4,
        4'h2,
        4'h1:
            begin
            outxcs[3:2] = 2'b10;
            end


        4'hC,
        4'hA,
        4'h9,
        4'h6,
        4'h3:
            begin
            outxcs[3:2] = 2'b01;
            end
      `else

      `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_3
        4'h8:
            begin
            outxcs[3:2] = 2'b10;
            end


        4'hC,
        4'hA,
        4'h9:
            begin
            outxcs[3:2] = 2'b01;
            end
      `else

        4'hC:
            begin
            outxcs[3:2] = 2'b01;
            end
      `endif
      `endif






        default :
            begin
            outxcs[3:2] = 2'b00;
            end
    endcase
    `endif
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : VAL_DMA_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      epvaldma <= 1'b0;
      end
    else
      begin
      if (upstren == 1'b1)
        begin
        epvaldma <= epval;
        end
      else if (hcsof_timer_epval == 1'b0)
        begin
        epvaldma <= 1'b0;
        end
      else if (buf_enable_auto == 1'b0)
        begin
        epvaldma <= epval;
        end
      else if ((outxcs[3:2] == 2'b11) ||
               (outxcs[3:2] == 2'b10 && buf_enable[3] == 1'b0) ||
               (outxcs[3:2] == 2'b01 && buf_enable[2] == 1'b0) ||
               (outxcs[1]   == 1'b0  && buf_enable[1] == 1'b0) ||
                                       (buf_enable[0] == 1'b0))
        begin
        epvaldma <= 1'b0;
        end
      else
        begin
        epvaldma <= 1'b1;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : BUF_ENABLE_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      buf_enable <= 4'h0;
      end
    else
      begin
      if (|upbusyset == 1'b1)
        begin
        buf_enable <= buf_enable_data;
        end
      else if (buf_enable_start == 1'b1)
        begin
        if (eptype == EP_ISO)
          begin
          buf_enable <= 4'hF;
          end
        else
          begin
          buf_enable <= 4'h1;
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



  assign hcsof_timer_epval =       (epval == 1'b0)     ? 1'b0 :
                            (hcsof_timer_ == 16'h0001) ? 1'b1 :
                            (hcsof_timer_ == 16'h0000) ? 1'b1 :
                                  (eptype == EP_ISO)   ? hcsof_timer_epval_1 :
                                                         hcsof_timer_epval_1_r ;



  assign dmasof = (upstren == 1'b1) ? sofpulse :
                                      hcsendsof & hcsof_timer_epval_1 ;

endmodule

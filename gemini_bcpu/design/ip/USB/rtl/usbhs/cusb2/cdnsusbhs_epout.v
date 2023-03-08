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
//   Filename:           cdnsusbhs_epout.v
//   Module Name:        cdnsusbhs_epout
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
//   OUT endpoint (structural)
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_epout
  (
  upclk,
  usbclk,
  uprst,
  usbrst,
  hsmode,
  endp,
  pid,
  clroutbsy,
  wr,
  overflowwr,
  tokrcvfall,
  togglerst,
  toggleset,
  fiforst,

  fifoendpnr,
  fiford,

  upstrenup,
  buf_enable,
  fifobc,

  upaddr,
  upwr,
  uprd,
  updatai_0,
  updatai_1,
  updatai_2,
  updatai_3,
  int_upbe_rd,
  int_upbe_wr,
  bufffull,
  eptype,
  episo,
  stall,
  busy,
  nxtbusy,
  epval,
  toggle,
  sfrtoggle,
  outbsyfall,
  usbfifoptrwr,
  upfifoptrrd,

  fifoempty,

  outxmaxpck,

  sofpulse,

  hcsendsof,
  dmasof,

  hcepnr,
  hcepdir,
  hcerrinc,
  hcerrclr,
  hcerrset,
  hcerrtype,
  hcepwaitclr,
  hcepwaitset,
  sendtok,
  hcisostop,
  upstren,
  enterhm,
  enterhmup,
  hcunderrien,
  hcnakidis,
  hcepsuspend,
  hcendpnrusb,
  hcinxmaxpckusb,
  hcdoiso,
  hcepwait,
  hcerrirq,

  updatao
  );

  parameter EPNUMBER     = 32'd1;
  parameter EPSIZE       = 32'd1024;
  parameter EPBUFFER     = 32'd4;
  parameter BCWIDTH      = 32'd11;

  `include "cdnsusbhs_cusb2_params.v"

  input                            upclk;
  input                            usbclk;
  input                            uprst;
  input                            usbrst;
  input                            hsmode;
  input  [3:0]                     endp;
  input  [4:0]                     pid;
  input                            clroutbsy;
  input                            wr;
  input                            overflowwr;
  input                            tokrcvfall;
  input                            togglerst;
  input                            toggleset;
  input                            fiforst;

  input  [3:0]                     fifoendpnr;
  input                            fiford;

  input                            upstrenup;
  input  [3:0]                     buf_enable;
  output [10:0]                    fifobc;
  wire   [10:0]                    fifobc;

  input  [7:0]                     upaddr;
  input                            upwr;
  input                            uprd;
  input  [7:0]                     updatai_0;
  input  [7:0]                     updatai_1;
  input  [7:0]                     updatai_2;
  input  [7:0]                     updatai_3;
  input  [3:0]                     int_upbe_rd;
  input  [3:0]                     int_upbe_wr;
  output                           bufffull;
  wire                             bufffull;
  output [1:0]                     eptype;
  wire   [1:0]                     eptype;
  output                           episo;
  wire                             episo;
  output                           stall;
  wire                             stall;
  output                           busy;
  wire                             busy;
  output                           nxtbusy;
  wire                             nxtbusy;
  output                           epval;
  wire                             epval;
  output [1:0]                     toggle;
  wire   [1:0]                     toggle;
  output                           sfrtoggle;
  wire                             sfrtoggle;
  output                           outbsyfall;
  wire                             outbsyfall;
  output [11:0]                    usbfifoptrwr;
  wire   [11:0]                    usbfifoptrwr;
  output [11:0]                    upfifoptrrd;
  wire   [11:0]                    upfifoptrrd;

  output                           fifoempty;
  wire                             fifoempty;

  input  [10:0]                    outxmaxpck;

  input                            sofpulse;

  input                            hcsendsof;
  output                           dmasof;
  wire                             dmasof;

  input                            upstren;
  input                            enterhm;
  input                            enterhmup;
  output                           hcunderrien;
  wire                             hcunderrien;
  output                           hcnakidis;
  wire                             hcnakidis;
  output                           hcepsuspend;
  wire                             hcepsuspend;
  output [3:0]                     hcendpnrusb;
  wire   [3:0]                     hcendpnrusb;
  output [10:0]                    hcinxmaxpckusb;
  wire   [10:0]                    hcinxmaxpckusb;
  output                           hcdoiso;
  wire                             hcdoiso;
  output                           hcepwait;
  wire                             hcepwait;
  output                           hcerrirq;
  wire                             hcerrirq;
  input  [3:0]                     hcepnr;
  input                            hcepdir;
  input                            hcerrinc;
  input                            hcerrclr;
  input                            hcerrset;
  input  [2:0]                     hcerrtype;
  input                            hcepwaitclr;
  input                            hcepwaitset;
  input                            sendtok;
  input                            hcisostop;

  output [31:0]                    updatao;
  wire   [31:0]                    updatao;




  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else
  wire   [1:0]                     buffering;
  `endif
  wire   [EPBUFFER-1:0]            upbusyset;
  wire   [EPBUFFER-1:0]            upbusyset_usb;
  wire   [3:0]                     hcendpnr;
  wire                             hcresend;
  wire                             hcresend_usb;
  wire   [1:0]                     hcisotoggle;
  wire                             buf_enable_auto;
  wire                             buf_enable_auto_usb;
  wire                             buf_enable_start;
  wire                             buf_enable_start_usb;
  wire   [3:0]                     buf_enable_data;




  wire   [4*BCWIDTH-1:0]           usboutbc;
  wire   [EPBUFFER-1:0]            usbbusyclr;
  wire   [EPBUFFER-1:0]            usbbusyclr_up;
  wire                             isoerr;
  wire                             isoerr_up;
  wire   [2:0]                     hcerrtypeusb;
  wire   [1:0]                     hcerrcountusb;
  wire   [2:0]                     hcerrtypeup;
  wire   [1:0]                     hcerrcountup;
  wire                             hcunderrien_up;
  wire                             hcnakidis_up;



  wire   [BCWIDTH-1:0]             outxmaxpck_usb;
  wire   [7:0]                     outxcon;
  wire   [7:0]                     outxcon_usb;
  wire                             togglerst_usb;
  wire                             toggleset_usb;
  wire                             fiforst_usb;
  wire                             dmasof_usb;



  wire   [15:0]                    hcsof_timer;
  wire                             hcsof_timer_start;
  wire                             hcsof_timer_start_usb;
  wire                             hcsof_timer_stop;
  wire                             hcsof_timer_stop_usb;
  wire                             hcsof_timer_reload;
  wire                             hcsof_timer_end;
  wire                             hcsof_timer_end_up;



  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  assign {epval, stall, hcisotoggle, eptype}            = outxcon_usb[7:2];
  `else
  assign {epval, stall, hcisotoggle, eptype, buffering} = outxcon_usb;
  `endif



  assign episo = (outxcon[3:2] == EP_ISO) ? 1'b1 :
                                            1'b0 ;




  cdnsusbhs_epoutup
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (EPNUMBER),
    .EPSIZE                             (EPSIZE),
    .EPBUFFER                           (EPBUFFER),
    .BCWIDTH                            (BCWIDTH)
  `else
    EPNUMBER,
    EPSIZE,
    EPBUFFER,
    BCWIDTH
  `endif
    )
  U_CDNSUSBHS_EPOUTUP
    (
    .upclk                              (upclk),
    .uprst                              (uprst),
    .usboutbc                           (usboutbc),
    .usbbusyclr                         (usbbusyclr_up),
    .isoerr                             (isoerr_up),
    .outxcon                            (outxcon),
    .upbusyset                          (upbusyset),
    .fiforst                            (fiforst),
    .outbsyfall                         (outbsyfall),
    .upfifoptrrd                        (upfifoptrrd),

    .fifoendpnr                         (fifoendpnr),
    .fiford                             (fiford),

    .fifoempty                          (fifoempty),
    .upstren                            (upstrenup),
    .buf_enable                         (buf_enable),
    .buf_enable_auto                    (buf_enable_auto),
    .buf_enable_start                   (buf_enable_start),
    .buf_enable_data                    (buf_enable_data),
    .fifobc                             (fifobc),

    .upaddr                             (upaddr),
    .upwr                               (upwr),
    .uprd                               (uprd),
    .updatai_0                          (updatai_0),
    .updatai_1                          (updatai_1),
    .updatai_2                          (updatai_2),
    .updatai_3                          (updatai_3),
    .int_upbe_rd                        (int_upbe_rd),
    .int_upbe_wr                        (int_upbe_wr),

    .outxmaxpck                         (outxmaxpck[BCWIDTH-1:0]),

    .hcerrcount                         (hcerrcountup),
    .hcendpnr                           (hcendpnr),
    .hcresend                           (hcresend),
    .hcerrtype                          (hcerrtypeup),
    .hcerrirq                           (hcerrirq),
    .hcunderrien                        (hcunderrien_up),
    .hcnakidis                          (hcnakidis_up),
    .enterhm                            (enterhmup),

    .hcsof_timer                        (hcsof_timer),
    .hcsof_timer_start                  (hcsof_timer_start),
    .hcsof_timer_stop                   (hcsof_timer_stop),
    .hcsof_timer_reload                 (hcsof_timer_reload),
    .hcsof_timer_end                    (hcsof_timer_end_up),

    .updatao                            (updatao)
    );




  cdnsusbhs_epoutusb
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (EPNUMBER),
    .EPSIZE                             (EPSIZE),
    .EPBUFFER                           (EPBUFFER),
    .BCWIDTH                            (BCWIDTH)
  `else
    EPNUMBER,
    EPSIZE,
    EPBUFFER,
    BCWIDTH
  `endif
    )
  U_CDNSUSBHS_EPOUTUSB
    (
    .usbclk                             (usbclk),
    .usbrst                             (usbrst),
    .upbusyset                          (upbusyset_usb),
    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
    `else
    .buffering                          (buffering),
    `endif
    .eptype                             (eptype),
    .epval                              (epval),
    .usboutbc                           (usboutbc),
    .usbbusyclr                         (usbbusyclr),
    .isoerr                             (isoerr),
    .hsmode                             (hsmode),
    .endp                               (endp),
    .clroutbsy                          (clroutbsy),
    .pid                                (pid),
    .wr                                 (wr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),
    .bufffull                           (bufffull),
    .busy                               (busy),
    .nxtbusy                            (nxtbusy),
    .toggle                             (toggle),
    .togglerst                          (togglerst_usb),
    .toggleset                          (toggleset_usb),
    .fiforst                            (fiforst_usb),
    .outxmaxpck                         (outxmaxpck_usb),

    .sofpulse                           (sofpulse),

    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_usb),

    .hcerrtype                          (hcerrtype),
    .hcepsuspend                        (hcepsuspend),
    .hcinxmaxpckusb                     (hcinxmaxpckusb),
    .hcerrtypeusb                       (hcerrtypeusb),
    .hcerrcountusb                      (hcerrcountusb),
    .hcresend                           (hcresend_usb),
    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcdoiso                            (hcdoiso),
    .hcisotoggle                        (hcisotoggle),
    .hcepwait                           (hcepwait),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),

    .buf_enable_auto                    (buf_enable_auto_usb),
    .buf_enable_start                   (buf_enable_start_usb),
    .buf_enable_data                    (buf_enable_data),

    .hcsof_timer                        (hcsof_timer),
    .hcsof_timer_start                  (hcsof_timer_start_usb),
    .hcsof_timer_stop                   (hcsof_timer_stop_usb),
    .hcsof_timer_reload                 (hcsof_timer_reload),
    .hcsof_timer_end                    (hcsof_timer_end),

    .usbfifoptrwr                       (usbfifoptrwr)
    );



  `ifdef CDNSUSBHS_NO_OUTXMAXPCK_SYNCFF
  assign outxmaxpck_usb = outxmaxpck[BCWIDTH-1:0];
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (BCWIDTH)
  `else
    BCWIDTH
  `endif
    )
  U_CDNSUSBHS_OUTXMAXPCK
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txdata                             (outxmaxpck[BCWIDTH-1:0]),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             (outxmaxpck_usb)
    );
  `endif



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd8)
  `else
    8
  `endif
    )
  U_CDNSUSBHS_OUTXCON
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txdata                             (outxcon),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             (outxcon_usb)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd4)
  `else
    4
  `endif
    )
  U_CDNSUSBHS_HCENDPNR
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txdata                             (hcendpnr),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             (hcendpnrusb)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd5)
  `else
    5
  `endif
    )
  U_CDNSUSBHS_HCERR
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txdata                             ({hcerrtypeusb, hcerrcountusb}),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxdata                             ({hcerrtypeup, hcerrcountup})
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_TOGGLERST_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (togglerst),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (togglerst_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_TOGGLESET_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (toggleset),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (toggleset_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_FIFORST_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (fiforst),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (fiforst_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_HCRESEND_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (hcresend),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (hcresend_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_UPBUSYSET_USB[EPBUFFER-1:0]
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (upbusyset),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (upbusyset_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_USBBUSYCLR_USB[EPBUFFER-1:0]
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txsignal                           (usbbusyclr),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxsignal                           (usbbusyclr_up)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_HCUNDERRIEN_USB
    (

    .txdata                             (hcunderrien_up),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             (hcunderrien)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_HCNAKIDIS_USB
    (

    .txdata                             (hcnakidis_up),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             (hcnakidis)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_ISOERR_UP
    (

    .txdata                             (isoerr),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxdata                             (isoerr_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_BUF_ENABLE_START_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (buf_enable_start),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (buf_enable_start_usb)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_BUF_ENABLE_AUTO_USB
    (

    .txdata                             (buf_enable_auto),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             (buf_enable_auto_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_HCSOF_TIMER_START_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (hcsof_timer_start),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (hcsof_timer_start_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_HCSOF_TIMER_STOP_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (hcsof_timer_stop),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (hcsof_timer_stop_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_HCSOF_TIMER_END_UP
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txsignal                           (hcsof_timer_end),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxsignal                           (hcsof_timer_end_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_DMASOF
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txsignal                           (dmasof_usb),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxsignal                           (dmasof)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_SFRTOGGLE
    (

    .txdata                             (toggle[0]),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxdata                             (sfrtoggle)
    );

endmodule

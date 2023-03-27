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
//   Filename:           cdnsusbhs_epin.v
//   Module Name:        cdnsusbhs_epin
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
//   IN endpoint (structural)
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_epin
  (
  upclk,
  usbclk,
  uprst,
  usbrst,
  hsmode,
  endp,
  clrinbsy,
  usbreset,
  disconusb,
  rd,
  txfall,
  togglerst,
  toggleset,
  fiforst,

  fifoendpnr,
  fifowr,
  fifoend,
  fifoacc,
  fifodval,

  upaddr,
  updatai_0,
  updatai_1,
  updatai_2,
  updatai_3,
  updataival_0,
  updataival_1,
  updataival_2,
  updataival_3,
  upwr,
  upincbc,
  dvi,
  eptype,
  episo,
  stall,
  busy,
  epval,
  toggle,
  sfrtoggle,
  inbsyfall,
  usbfifoptrrd,
  upfifoptrwr,

  fifofull,
  fifoafull,

  inxmaxpck,
  usbresetup,
  discon,

  sofpulse,
  hcsendsof,
  dmasof,

  isosofpulse,
  isodump2k,
  isodump1k,
  inxisodctrl,
  isosofpulseup,
  inxisoautoarm,
  inxisoautodump,

  hcepnr,
  hcepdir,
  hcerrinc,
  hcerrclr,
  hcerrset,
  hcerrtype,
  hcepwaitclr,
  hcepwaitset,
  hcdevdopingset,
  hcdevdopingclr,
  upstren,
  upstrenup,
  enterhm,
  enterhmup,

  isotoggleusb,
  hcoutxmaxpckusb,
  hcepsuspend,
  hcendpnrusb,
  hcdoiso,
  hcepwait,
  hcdoping,
  hcnakidis,
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
  input                            clrinbsy;
  input                            usbreset;
  input                            disconusb;
  input                            rd;
  input                            txfall;
  input                            togglerst;
  input                            toggleset;
  input                            fiforst;

  input  [3:0]                     fifoendpnr;
  input                            fifowr;
  input                            fifoend;
  input                            fifoacc;
  input  [3:0]                     fifodval;

  input  [7:0]                     upaddr;
  input                            upwr;
  input  [7:0]                     updatai_0;
  input  [7:0]                     updatai_1;
  input  [7:0]                     updatai_2;
  input  [7:0]                     updatai_3;
  input                            updataival_0;
  input                            updataival_1;
  input                            updataival_2;
  input                            updataival_3;
  input                            upincbc;
  output                           dvi;
  wire                             dvi;
  output [1:0]                     eptype;
  wire   [1:0]                     eptype;
  output                           episo;
  wire                             episo;
  output                           stall;
  wire                             stall;
  output                           busy;
  wire                             busy;
  output                           epval;
  wire                             epval;
  output [1:0]                     toggle;
  wire   [1:0]                     toggle;
  output                           sfrtoggle;
  wire                             sfrtoggle;
  output                           inbsyfall;
  wire                             inbsyfall;
  output [11:0]                    usbfifoptrrd;
  wire   [11:0]                    usbfifoptrrd;
  output [11:0]                    upfifoptrwr;
  wire   [11:0]                    upfifoptrwr;

  output                           fifofull;
  wire                             fifofull;
  output                           fifoafull;
  wire                             fifoafull;

  input  [10:0]                    inxmaxpck;
  input                            usbresetup;
  input                            discon;

  input                            sofpulse;
  input                            hcsendsof;
  output                           dmasof;
  wire                             dmasof;

  input                            isosofpulse;
  input                            isodump2k;
  input                            isodump1k;
  input                            inxisodctrl;
  input                            isosofpulseup;
  input                            inxisoautoarm;
  input                            inxisoautodump;

  input  [3:0]                     hcepnr;
  input                            hcepdir;
  input                            hcerrinc;
  input                            hcerrclr;
  input                            hcerrset;
  input  [2:0]                     hcerrtype;
  input                            hcepwaitclr;
  input                            hcepwaitset;
  input                            hcdevdopingset;
  input                            hcdevdopingclr;
  input                            upstren;
  input                            upstrenup;
  input                            enterhm;
  input                            enterhmup;

  output [1:0]                     isotoggleusb;
  wire   [1:0]                     isotoggleusb;
  output [10:0]                    hcoutxmaxpckusb;
  wire   [10:0]                    hcoutxmaxpckusb;
  output                           hcepsuspend;
  wire                             hcepsuspend;
  output [3:0]                     hcendpnrusb;
  wire   [3:0]                     hcendpnrusb;
  output                           hcdoiso;
  wire                             hcdoiso;
  output                           hcepwait;
  wire                             hcepwait;
  output                           hcdoping;
  wire                             hcdoping;
  output                           hcnakidis;
  wire                             hcnakidis;
  output                           hcerrirq;
  wire                             hcerrirq;

  output [31:0]                    updatao;
  wire   [31:0]                    updatao;




  wire                             isoerr;
  wire                             isoerr_up;
  wire   [EPBUFFER-1:0]            usbbusyclr;
  wire   [EPBUFFER-1:0]            usbbusyclr_up;
  wire   [2:0]                     hcerrtypeusb;
  wire   [1:0]                     hcerrcountusb;
  wire   [2:0]                     hcerrtypeup;
  wire   [1:0]                     hcerrcountup;
  wire                             hcdoping_usb;
  wire                             hcdoping_up;




  wire   [4*BCWIDTH-1:0]           upinbc;
  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  wire   [1:0]                     buffering;
  `endif
  wire   [EPBUFFER-1:0]            upbusyset;
  wire   [EPBUFFER-1:0]            upbusyset_usb;
  wire   [1:0]                     isotoggle;
  wire   [3:0]                     hcendpnr;
  wire                             hcresend;
  wire                             hcresend_usb;
  wire                             hcdopingset;
  wire                             hcdopingset_usb;
  wire                             hcnakidis_up;



  wire   [BCWIDTH-1:0]             inxmaxpck_usb;
  wire   [7:0]                     inxcon;
  wire   [7:0]                     inxcon_usb;
  wire                             togglerst_usb;
  wire                             toggleset_usb;
  wire                             fiforst_usb;
  wire                             inxisoautodump_usb;
  wire                             inxisodctrl_usb;
  wire                             dmasof_usb;



  wire   [15:0]                    hcsof_timer;
  wire                             hcsof_timer_start;
  wire                             hcsof_timer_start_usb;
  wire                             hcsof_timer_stop;
  wire                             hcsof_timer_stop_usb;
  wire                             hcsof_timer_reload;
  wire                             hcsof_timer_end;
  wire                             hcsof_timer_end_up;



  assign hcdoping = hcdoping_usb ;



  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  assign {epval, stall, isotoggle, eptype}            = inxcon_usb[7:2];
  `else
  assign {epval, stall, isotoggle, eptype, buffering} = inxcon_usb;
  `endif



  assign episo = (inxcon[3:2] == EP_ISO) ? 1'b1 :
                                           1'b0 ;




  cdnsusbhs_epinup
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
  U_CDNSUSBHS_EPINUP
    (
    .upclk                              (upclk),
    .uprst                              (uprst),
    .usbbusyclr                         (usbbusyclr_up),
    .isoerr                             (isoerr_up),
    .upinbc                             (upinbc),
    .upbusyset                          (upbusyset),
    .inxcon                             (inxcon),
    .fiforst                            (fiforst),
    .inbsyfall                          (inbsyfall),
    .upfifoptrwr                        (upfifoptrwr),

    .fifoendpnr                         (fifoendpnr),
    .fifowr                             (fifowr),
    .fifoend                            (fifoend),
    .fifoacc                            (fifoacc),
    .fifodval                           (fifodval),
    .fifofull                           (fifofull),
    .fifoafull                          (fifoafull),

    .upaddr                             (upaddr),
    .upwr                               (upwr),
    .upincbc                            (upincbc),
    .updatai_0                          (updatai_0),
    .updatai_1                          (updatai_1),
    .updatai_2                          (updatai_2),
    .updatai_3                          (updatai_3),
    .updataival_0                       (updataival_0),
    .updataival_1                       (updataival_1),
    .updataival_2                       (updataival_2),
    .updataival_3                       (updataival_3),

    .inxmaxpck                          (inxmaxpck[BCWIDTH-1:0]),
    .usbresetup                         (usbresetup),
    .discon                             (discon),

    .inxisoautoarm                      (inxisoautoarm),
    .isosofpulseup                      (isosofpulseup),

    .hcerrtype                          (hcerrtypeup),
    .hcerrcount                         (hcerrcountup),
    .hcdoping                           (hcdoping_up),
    .hcendpnr                           (hcendpnr),
    .hcresend                           (hcresend),
    .hcdopingset                        (hcdopingset),
    .hcnakidis                          (hcnakidis_up),
    .upstren                            (upstrenup),
    .enterhm                            (enterhmup),
    .hcerrirq                           (hcerrirq),

    .hcsof_timer                        (hcsof_timer),
    .hcsof_timer_start                  (hcsof_timer_start),
    .hcsof_timer_stop                   (hcsof_timer_stop),
    .hcsof_timer_reload                 (hcsof_timer_reload),
    .hcsof_timer_end                    (hcsof_timer_end_up),

    .updatao                            (updatao)
    );




  cdnsusbhs_epinusb
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
  U_CDNSUSBHS_EPINUSB
    (
    .usbclk                             (usbclk),
    .usbrst                             (usbrst),
    .upbusyset                          (upbusyset_usb),
    `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
    `else
    .buffering                          (buffering),
    `endif
    .eptype                             (eptype),
    .isotoggle                          (isotoggle),
    .upinbc                             (upinbc),
    .usbbusyclr                         (usbbusyclr),
    .isoerr                             (isoerr),
    .hsmode                             (hsmode),
    .endp                               (endp),
    .clrinbsy                           (clrinbsy),
    .rd                                 (rd),
    .txfall                             (txfall),
    .usbreset                           (usbreset),
    .discon                             (disconusb),
    .dvi                                (dvi),
    .busy                               (busy),
    .toggle                             (toggle),
    .togglerst                          (togglerst_usb),
    .toggleset                          (toggleset_usb),
    .fiforst                            (fiforst_usb),

    .inxmaxpck                          (inxmaxpck_usb),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_usb),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .inxisodctrl                        (inxisodctrl_usb),
    .inxisoautodump                     (inxisoautodump_usb),

    .hcresend                           (hcresend_usb),
    .hcdopingset                        (hcdopingset_usb),
    .hcerrtypeusb                       (hcerrtypeusb),
    .hcerrcountusb                      (hcerrcountusb),
    .hcerrtype                          (hcerrtype),
    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .isotoggleusb                       (isotoggleusb),
    .hcoutxmaxpckusb                    (hcoutxmaxpckusb),
    .hcepsuspend                        (hcepsuspend),
    .hcdoiso                            (hcdoiso),
    .hcepwait                           (hcepwait),
    .hcdoping                           (hcdoping_usb),

    .hcsof_timer                        (hcsof_timer),
    .hcsof_timer_start                  (hcsof_timer_start_usb),
    .hcsof_timer_stop                   (hcsof_timer_stop_usb),
    .hcsof_timer_reload                 (hcsof_timer_reload),
    .hcsof_timer_end                    (hcsof_timer_end),

    .usbfifoptrrd                       (usbfifoptrrd)
    );



  `ifdef CDNSUSBHS_NO_INXMAXPCK_SYNCFF
  assign inxmaxpck_usb = inxmaxpck[BCWIDTH-1:0];
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (BCWIDTH)
  `else
    BCWIDTH
  `endif
    )
  U_CDNSUSBHS_INXMAXPCK
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txdata                             (inxmaxpck[BCWIDTH-1:0]),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             (inxmaxpck_usb)
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
  U_CDNSUSBHS_INXCON
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txdata                             (inxcon),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             (inxcon_usb)
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
  U_CDNSUSBHS_HCDOPINGSET_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (hcdopingset),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (hcdopingset_usb)
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



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_HCDOPING_UP
    (

    .txdata                             (hcdoping_usb),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxdata                             (hcdoping_up)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_INXISOAUTODUMP_USB
    (

    .txdata                             (inxisoautodump),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             (inxisoautodump_usb)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_INXISODCTRL_USB
    (

    .txdata                             (inxisodctrl),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             (inxisodctrl_usb)
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

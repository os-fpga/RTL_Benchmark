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
//   Filename:           cdnsusbhs_ep0.v
//   Module Name:        cdnsusbhs_ep0
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
//   Endpoint 0 (structural)
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_ep0
  (
  upclk,
  usbclk,
  uprst,
  usbrst,
  usbreset,
  hsmode,
  endp,
  clroutbsy,
  clrinbsy,
  pid,
  tokrcvfall,
  settoken,
  sudav,
  lpm_token_84,
  lpm_auto_entry,
  usbresetup,
  disconusb,
  discon,
  wr,
  overflowwr,
  rd,
  outdatawr,
  txfall,
  sendstall,
  upaddr,
  upwr,
  updatai_0,
  updatai_1,
  updatai_2,
  updatai_3,
  updataival_0,
  updataival_1,
  updataival_2,
  updataival_3,
  fnaddrusb,
  ep0stall,
  ep0bufffull,
  ep0busyin,
  ep0busyout,
  ep0nxtbusyout,
  ep0togglein,
  ep0toggleout,
  sfrep0togglein,
  sfrep0toggleout,
  ep0datastage,
  fnaddrup,
  outbsyfall,
  inbsyfall,
  dvi,
  testmode,
  testmodesel,
  tmodecustom,
  tmodeselcustom,
  usbfifoptrwr,
  usbfifoptrrd,
  buf_enable,
  epval,
  sendpckt,
  hcepnr,
  hcepdir,
  hcerrinc,
  hcerrclr,
  hcerrset,
  hcerrtype,
  hcsendsof,
  hcepwaitclr,
  hcepwaitset,
  sendtok,
  hcdevdopingset,
  hcdevdopingclr,
  upstren,
  upstrenup,
  enterhm,
  enterhmup,
  portctrltm,
  hcinepsuspend,
  hcoutepsuspend,
  hcendpnrusb,
  hcin0maxpckusb,
  hcout0maxpckusb,
  hcinepwait,
  hcoutepwait,
  hcdoping,
  hcdosetup,
  hcunderrien,
  hclpmctrl,
  hclpmctrlb,
  hcdolpm,
  hcinerrirq,
  hcouterrirq,

  out0maxpck,

  fiforstin,
  fiforstout,

  fifoinendp,
  fifoend,
  fifowr,
  fifodval,
  fifofull,

  fifooutendp,

  fiford,
  fifoempty,

  fifoacc,
  fifobc,
  upfifoptrwr,
  upfifoptrrd,

  hcnak_hshk,

  updatao
  );

  `include "cdnsusbhs_cusb2_params.v"

  input                            upclk;
  input                            usbclk;
  input                            uprst;
  input                            usbrst;
  input                            usbreset;
  input                            hsmode;
  input  [3:0]                     endp;
  input                            clroutbsy;
  input                            clrinbsy;
  input  [4:0]                     pid;
  input                            tokrcvfall;
  input                            settoken;
  output                           sudav;
  wire                             sudav;
  input  [5:0]                     lpm_token_84;
  output                           lpm_auto_entry;
  wire                             lpm_auto_entry;
  input                            usbresetup;
  input                            disconusb;
  input                            discon;
  input                            wr;
  input                            overflowwr;
  input                            rd;
  input  [7:0]                     outdatawr;
  input                            txfall;
  input                            sendstall;
  input  [7:0]                     upaddr;
  input                            upwr;
  input  [7:0]                     updatai_0;
  input  [6:0]                     updatai_1;
  input  [7:0]                     updatai_2;
  input  [7:0]                     updatai_3;
  input                            updataival_0;
  input                            updataival_1;
  input                            updataival_2;
  input                            updataival_3;
  output [6:0]                     fnaddrusb;
  wire   [6:0]                     fnaddrusb;
  output                           ep0stall;
  wire                             ep0stall;
  output                           ep0bufffull;
  wire                             ep0bufffull;
  output                           ep0busyin;
  wire                             ep0busyin;
  output                           ep0busyout;
  wire                             ep0busyout;
  output                           ep0nxtbusyout;
  wire                             ep0nxtbusyout;
  output                           ep0togglein;
  wire                             ep0togglein;
  output                           ep0toggleout;
  wire                             ep0toggleout;
  output                           sfrep0togglein;
  wire                             sfrep0togglein;
  output                           sfrep0toggleout;
  wire                             sfrep0toggleout;
  output                           ep0datastage;
  wire                             ep0datastage;
  output [6:0]                     fnaddrup;
  wire   [6:0]                     fnaddrup;
  output                           outbsyfall;
  wire                             outbsyfall;
  output                           inbsyfall;
  wire                             inbsyfall;
  output                           dvi;
  wire                             dvi;
  output                           testmode;
  wire                             testmode;
  output [1:0]                     testmodesel;
  wire   [1:0]                     testmodesel;
  output                           tmodecustom;
  wire                             tmodecustom;
  output [7:0]                     tmodeselcustom;
  wire   [7:0]                     tmodeselcustom;
  output [11:0]                    usbfifoptrwr;
  wire   [11:0]                    usbfifoptrwr;
  output [11:0]                    usbfifoptrrd;
  wire   [11:0]                    usbfifoptrrd;
  input                            buf_enable;
  output                           epval;
  wire                             epval;
  input                            sendpckt;
  input  [3:0]                     hcepnr;
  input                            hcepdir;
  input                            hcerrinc;
  input                            hcerrclr;
  input                            hcerrset;
  input  [2:0]                     hcerrtype;
  input                            hcsendsof;
  input                            hcepwaitclr;
  input                            hcepwaitset;
  input                            sendtok;
  input                            hcdevdopingset;
  input                            hcdevdopingclr;
  input                            upstren;
  input                            upstrenup;
  input                            enterhm;
  input                            enterhmup;
  input  [3:0]                     portctrltm;
  output                           hcinepsuspend;
  wire                             hcinepsuspend;
  output                           hcoutepsuspend;
  wire                             hcoutepsuspend;
  output [3:0]                     hcendpnrusb;
  wire   [3:0]                     hcendpnrusb;
  output [10:0]                    hcin0maxpckusb;
  wire   [10:0]                    hcin0maxpckusb;
  output [10:0]                    hcout0maxpckusb;
  wire   [10:0]                    hcout0maxpckusb;
  output                           hcinepwait;
  wire                             hcinepwait;
  output                           hcoutepwait;
  wire                             hcoutepwait;
  output                           hcdoping;
  wire                             hcdoping;
  output                           hcdosetup;
  wire                             hcdosetup;
  output                           hcunderrien;
  wire                             hcunderrien;
  output [7:0]                     hclpmctrl;
  wire   [7:0]                     hclpmctrl;
  output                           hclpmctrlb;
  wire                             hclpmctrlb;
  output                           hcdolpm;
  wire                             hcdolpm;
  output                           hcinerrirq;
  wire                             hcinerrirq;
  output                           hcouterrirq;
  wire                             hcouterrirq;

  input  [6:0]                     out0maxpck;

  input                            fiforstin;
  input                            fiforstout;

  input  [3:0]                     fifoinendp;
  input                            fifoend;
  input                            fifowr;
  input  [3:0]                     fifodval;
  output                           fifofull;
  wire                             fifofull;


  input  [3:0]                     fifooutendp;

  input                            fiford;
  output                           fifoempty;
  wire                             fifoempty;

  input                            fifoacc;
  output [10:0]                    fifobc;
  wire   [10:0]                    fifobc;
  output [11:0]                    upfifoptrwr;
  wire   [11:0]                    upfifoptrwr;
  output [11:0]                    upfifoptrrd;
  wire   [11:0]                    upfifoptrrd;

  output [5:0]                     hcnak_hshk;
  wire   [5:0]                     hcnak_hshk;

  output [31:0]                    updatao;
  wire   [31:0]                    updatao;


  wire   [6:0]                     usbout0bc;
  wire   [6:0]                     usbout0bc_up;
  wire                             usboutbsyclr;
  wire                             usboutbsyclr_up;
  wire                             usbinbsyclr;
  wire                             usbinbsyclr_up;
  wire   [6:0]                     fnaddrusb_int;
  wire                             setupack;
  wire                             setupack_up;
  wire                             setaddr;
  wire                             setaddr_up;
  wire                             testmodereq;
  wire                             testmodereq_up;
  wire                             testmodeerr;
  wire                             testmodeerr_up;
  wire                             testmodenak;
  wire                             testmodenak_up;
  wire                             clroutbsy_setup;
  wire                             clroutbsy_setup_up;
  wire   [63:0]                    setupbuff_usb;
  wire   [63:0]                    setupbuff_up;
  wire   [2:0]                     hcinerrtypeusb;
  wire   [2:0]                     hcouterrtypeusb;
  wire   [1:0]                     hcinerrcountusb;
  wire   [1:0]                     hcouterrcountusb;
  wire   [2:0]                     hcinerrtypeup;
  wire   [2:0]                     hcouterrtypeup;
  wire   [1:0]                     hcinerrcountup;
  wire   [1:0]                     hcouterrcountup;
  wire                             hcdoping_usb;
  wire                             hcdoping_up;
  wire                             chgsetup;
  wire                             chgsetup_up;


  wire   [6:0]                     upin0bc;
  wire   [6:0]                     upin0bc_usb;
  wire                             setoutbsyreq;
  wire                             setoutbsyreq_usb;
  wire                             setinbsyreq;
  wire                             setinbsyreq_usb;
  wire                             hsnak;
  wire                             hsnak_usb;
  wire                             stall;
  wire                             stall_usb;
  wire                             dstall;
  wire                             dstall_usb;
  wire   [6:0]                     fnaddrup_int;
  wire   [3:0]                     hcendpnr;
  wire                             hcinresend;
  wire                             hcinresend_usb;
  wire                             hcoutresend;
  wire                             hcoutresend_usb;
  wire                             hcdopingset;
  wire                             hcdopingset_usb;
  wire                             hcsettoggle;
  wire                             hcsettoggle_usb;
  wire                             hcclrtoggle;
  wire                             hcclrtoggle_usb;
  wire                             hcset;
  wire                             hcset_usb;
  wire                             hcsetlpm;
  wire                             hcsetlpm_usb;
  wire   [7:0]                     hclpmctrl_up;
  wire                             hclpmctrlb_up;
  wire                             val;
  wire                             hcunderrien_up;



  wire   [6:0]                     out0maxpck_usb;
  wire   [6:0]                     fnaddrup_usb;
  wire   [6:0]                     fnaddrusb_up;
  wire   [5:0]                     lpm_token_up;
  wire                             fiforstin_usb;
  wire                             fiforstout_usb;




  assign fnaddrusb = fnaddrusb_int ;




  assign fnaddrup  = fnaddrup_int ;




  assign hcdoping = hcdoping_usb ;



  assign sudav = clroutbsy_setup_up;




  cdnsusbhs_ep0up
  U_CDNSUSBHS_EP0UP
    (
    .upclk                              (upclk),
    .uprst                              (uprst),
    .usbout0bc                          (usbout0bc_up),
    .usboutbsyclr                       (usboutbsyclr_up),
    .usbinbsyclr                        (usbinbsyclr_up),
    .fnaddrusb                          (fnaddrusb_up),
    .setupack                           (setupack_up),
    .setaddr                            (setaddr_up),
    .testmodereq                        (testmodereq_up),
    .testmodeerr                        (testmodeerr_up),
    .testmodenak                        (testmodenak_up),
    .usbresetup                         (usbresetup),
    .discon                             (discon),
    .lpm_token                          (lpm_token_up),
    .lpm_auto_entry                     (lpm_auto_entry),
    .upin0bc                            (upin0bc),
    .setoutbsyreq                       (setoutbsyreq),
    .setinbsyreq                        (setinbsyreq),
    .hsnak                              (hsnak),
    .stall                              (stall),
    .dstall                             (dstall),
    .fnaddrup                           (fnaddrup_int),
    .outbsyfall                         (outbsyfall),
    .inbsyfall                          (inbsyfall),
    .hcinerrtype                        (hcinerrtypeup),
    .hcouterrtype                       (hcouterrtypeup),
    .hcinerrcount                       (hcinerrcountup),
    .hcouterrcount                      (hcouterrcountup),
    .hcdoping                           (hcdoping_up),
    .enterhm                            (enterhmup),
    .chgsetup                           (chgsetup_up),
    .hcendpnr                           (hcendpnr),
    .hcinresend                         (hcinresend),
    .hcoutresend                        (hcoutresend),
    .hcdopingset                        (hcdopingset),
    .hcsettoggle                        (hcsettoggle),
    .hcclrtoggle                        (hcclrtoggle),
    .hcsetlpm                           (hcsetlpm),
    .hcset                              (hcset),
    .hcunderrien                        (hcunderrien_up),
    .hclpmctrl                          (hclpmctrl_up),
    .hclpmctrlb                         (hclpmctrlb_up),
    .hcinerrirq                         (hcinerrirq),
    .hcouterrirq                        (hcouterrirq),
    .upstren                            (upstrenup),
    .setupbuff                          (setupbuff_up),
    .clroutbsy_setup                    (clroutbsy_setup_up),

    .fiforstin                          (fiforstin),
    .fiforstout                         (fiforstout),

    .fifoinendp                         (fifoinendp),
    .fifoend                            (fifoend),
    .fifowr                             (fifowr),
    .fifodval                           (fifodval),
    .fifofull                           (fifofull),


    .fifooutendp                        (fifooutendp),

    .fiford                             (fiford),
    .fifoempty                          (fifoempty),

    .out0maxpck                         (out0maxpck),
    .fifoacc                            (fifoacc),
    .fifobc                             (fifobc),
    .upfifoptrwr                        (upfifoptrwr),
    .upfifoptrrd                        (upfifoptrrd),

    .buf_enable                         (buf_enable),
    .val                                (val),

    .hcnak_hshk                         (hcnak_hshk),

    .upaddr                             (upaddr),
    .updatao                            (updatao),
    .updatai_0                          (updatai_0),
    .updatai_1                          (updatai_1),
    .updatai_2                          (updatai_2),
    .updatai_3                          (updatai_3),
    .updataival_0                       (updataival_0),
    .updataival_1                       (updataival_1),
    .updataival_2                       (updataival_2),
    .updataival_3                       (updataival_3),
    .upwr                               (upwr)
    );




  cdnsusbhs_ep0usb
  U_CDNSUSBHS_EP0USB
    (
    .usbclk                             (usbclk),
    .usbrst                             (usbrst),
    .setoutbsyreq                       (setoutbsyreq_usb),
    .setinbsyreq                        (setinbsyreq_usb),
    .upin0bc                            (upin0bc_usb),
    .hsnak                              (hsnak_usb),
    .stall                              (stall_usb),
    .dstall                             (dstall_usb),

    .out0maxpck                         (out0maxpck_usb),

    .usboutbsyclr                       (usboutbsyclr),
    .usbinbsyclr                        (usbinbsyclr),
    .setupack                           (setupack),
    .setaddr                            (setaddr),
    .usbout0bc                          (usbout0bc),
    .fnaddrusb                          (fnaddrusb_int),
    .testmodereq                        (testmodereq),
    .testmodeerr                        (testmodeerr),
    .testmodenak                        (testmodenak),
    .usbreset                           (usbreset),
    .hsmode                             (hsmode),
    .endp                               (endp),
    .clroutbsy                          (clroutbsy),
    .clrinbsy                           (clrinbsy),
    .pid                                (pid),
    .tokrcvfall                         (tokrcvfall),
    .settoken                           (settoken),
    .ep0bufffull                        (ep0bufffull),
    .ep0busyin                          (ep0busyin),
    .ep0busyout                         (ep0busyout),
    .ep0nxtbusyout                      (ep0nxtbusyout),
    .ep0stall                           (ep0stall),
    .ep0togglein                        (ep0togglein),
    .ep0toggleout                       (ep0toggleout),
    .ep0datastage                       (ep0datastage),
    .discon                             (disconusb),
    .setupbuff                          (setupbuff_usb),
    .wr                                 (wr),
    .overflowwr                         (overflowwr),
    .rd                                 (rd),
    .outdatawr                          (outdatawr),
    .txfall                             (txfall),
    .dvi                                (dvi),
    .testmode                           (testmode),
    .testmodesel                        (testmodesel),
    .tmodecustom                        (tmodecustom),
    .tmodeselcustom                     (tmodeselcustom),
    .clroutbsy_setup                    (clroutbsy_setup),
    .sendstall                          (sendstall),
    .sendpckt                           (sendpckt),

    .fnaddrup                           (fnaddrup_usb),
    .hcoutresend                        (hcoutresend_usb),
    .hcinresend                         (hcinresend_usb),
    .hcdopingset                        (hcdopingset_usb),
    .hcsettoggle                        (hcsettoggle_usb),
    .hcclrtoggle                        (hcclrtoggle_usb),
    .hcsetlpm                           (hcsetlpm_usb),
    .hcset                              (hcset_usb),
    .hcerrtype                          (hcerrtype),
    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcsendsof                          (hcsendsof),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .hcouterrtypeusb                    (hcouterrtypeusb),
    .hcinerrtypeusb                     (hcinerrtypeusb),
    .hcouterrcountusb                   (hcouterrcountusb),
    .hcinerrcountusb                    (hcinerrcountusb),
    .chgsetup                           (chgsetup),
    .hcout0maxpckusb                    (hcout0maxpckusb),
    .hcin0maxpckusb                     (hcin0maxpckusb),
    .hcoutepsuspend                     (hcoutepsuspend),
    .hcinepsuspend                      (hcinepsuspend),
    .hcoutepwait                        (hcoutepwait),
    .hcinepwait                         (hcinepwait),
    .hcdoping                           (hcdoping_usb),
    .hcdosetup                          (hcdosetup),
    .hcdolpm                            (hcdolpm),
    .portctrltm                         (portctrltm),

    .fiforstin                          (fiforstin_usb),
    .fiforstout                         (fiforstout_usb),

    .usbfifoptrwr                       (usbfifoptrwr),
    .usbfifoptrrd                       (usbfifoptrrd)
    );



  `ifdef CDNSUSBHS_NO_OUT0MAXPCK_SYNCFF
  assign out0maxpck_usb = out0maxpck;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd7)
  `else
    7
  `endif
    )
  U_CDNSUSBHS_OUT0MAXPCK
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txdata                             (out0maxpck),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             (out0maxpck_usb)
    );
  `endif























  cdnsusbhs_load_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd64)
  `else
    64
  `endif
    )
  U_CDNSUSBHS_CLROUTBSY_SETUP_UP
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txload                             (clroutbsy_setup),
    .txdata                             (setupbuff_usb),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxstrobe                           (clroutbsy_setup_up),
    .rxdata                             (setupbuff_up)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd7)
  `else
    7
  `endif
    )
  U_CDNSUSBHS_FNADDRUP
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txdata                             (fnaddrup_int),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             (fnaddrup_usb)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd7)
  `else
    7
  `endif
    )
  U_CDNSUSBHS_FNADDRUSB
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txdata                             (fnaddrusb_int),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxdata                             (fnaddrusb_up)
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
  U_CDNSUSBHS_HCOUTERR
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txdata                             ({hcouterrtypeusb, hcouterrcountusb}),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxdata                             ({hcouterrtypeup, hcouterrcountup})
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd5)
  `else
    5
  `endif
    )
  U_CDNSUSBHS_HCINERR
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txdata                             ({hcinerrtypeusb, hcinerrcountusb}),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxdata                             ({hcinerrtypeup, hcinerrcountup})
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd6)
  `else
    6
  `endif
    )
  U_CDNSUSBHS_LPM_TOKEN_UP
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txdata                             (lpm_token_84),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxdata                             (lpm_token_up)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd9)
  `else
    9
  `endif
    )
  U_CDNSUSBHS_HCLPMCTRL_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txdata                             ({hclpmctrlb_up, hclpmctrl_up}),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             ({hclpmctrlb, hclpmctrl})
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_FIFORSTIN_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (fiforstin),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (fiforstin_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_FIFORSTOUT_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (fiforstout),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (fiforstout_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_SETOUTBSYREQ_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (setoutbsyreq),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (setoutbsyreq_usb)
    );
















  cdnsusbhs_load_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd7)
  `else
    7
  `endif
    )
  U_CDNSUSBHS_SETINBSYREQ_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txload                             (setinbsyreq),
    .txdata                             (upin0bc),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxstrobe                           (setinbsyreq_usb),
    .rxdata                             (upin0bc_usb)
    );
















  cdnsusbhs_load_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd7)
  `else
    7
  `endif
    )
  U_CDNSUSBHS_USBOUTBSYCLR_UP
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txload                             (usboutbsyclr),
    .txdata                             (usbout0bc),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxstrobe                           (usboutbsyclr_up),
    .rxdata                             (usbout0bc_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_USBINBSYCLR_UP
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txsignal                           (usbinbsyclr),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxsignal                           (usbinbsyclr_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_HCINRESEND_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (hcinresend),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (hcinresend_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_HCOUTRESEND_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (hcoutresend),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (hcoutresend_usb)
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



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_HCSET_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (hcset),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (hcset_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_HCETLPM_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (hcsetlpm),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (hcsetlpm_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_HCSETTOGGLE_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (hcsettoggle),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (hcsettoggle_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_HCCLRTOGGLE_USB
    (

    .txclk                              (upclk),
    .txrst                              (uprst),
    .txsignal                           (hcclrtoggle),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxsignal                           (hcclrtoggle_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_CHGSETUP_UP
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txsignal                           (chgsetup),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxsignal                           (chgsetup_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_SETADDR_UP
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txsignal                           (setaddr),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxsignal                           (setaddr_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_TESTMODEREQ_UP
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txsignal                           (testmodereq),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxsignal                           (testmodereq_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_TESTMODEERR_UP
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txsignal                           (testmodeerr),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxsignal                           (testmodeerr_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_TESTMODENAK_UP
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txsignal                           (testmodenak),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxsignal                           (testmodenak_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_SETUPACK_UP
    (

    .txclk                              (usbclk),
    .txrst                              (usbrst),
    .txsignal                           (setupack),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxsignal                           (setupack_up)
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
    .DATA_SYNC_WIDTH                    (32'd3)
  `else
    3
  `endif
    )
  U_CDNSUSBHS_EP0CS_USB
    (

    .txdata                             ({hsnak, stall, dstall}),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             ({hsnak_usb, stall_usb, dstall_usb})
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
  U_CDNSUSBHS_OUT0VAL
    (

    .txdata                             (val),


    .rxclk                              (usbclk),
    .rxrst                              (usbrst),
    .rxdata                             (epval)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_SFREP0TOGGLEIN
    (

    .txdata                             (ep0togglein),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxdata                             (sfrep0togglein)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_SFREP0TOGGLEOUT
    (

    .txdata                             (ep0toggleout),


    .rxclk                              (upclk),
    .rxrst                              (uprst),
    .rxdata                             (sfrep0toggleout)
    );

endmodule

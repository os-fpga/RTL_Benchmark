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
//   Filename:           cdnsusbhs_devfsm.v
//   Module Name:        cdnsusbhs_devfsm
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
//   Device Transaction FSM
//   K.W. D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_devfsm
  (
  usbclk,
  usbrst,
  fnaddr,
  ep0toggleout,
  ep0togglein,
  ep0datastage,
  epvalin,
  eptypein,
  eptypeout,
  stallin,
  busyin,
  togglein,
  toggleout,
  dviin,
  epvalout,
  stallout,
  busyout,
  nxtbusyout,
  bufffullout,
  testmode,
  tfnaddr,
  tendp,
  tendpnxt,
  pid,
  piderr,
  usberr,
  rcvfall,
  txfall,
  overflowwr,
  clroutbsy,
  clrinbsy,
  tokrcvfall,
  settoken,

  sendhshk,
  sendpckt,
  sendzeroiso,
  receive,
  dvi,
  sendpid,
  busyff,
  tokenok,
  sendstall,
  outpngirq,
  outpngirq_no,
  sofirq,

  sofpulse,

  hcdosetup,
  hclpmctrl,
  hclpmctrlb,
  hcdolpm,
  lpmstate,
  lpmstate_besl,
  isotogglein,
  hcinmaxpckusb,
  hcdoisoin,
  hcepsuspendin,
  hcepwaitin,
  hcendpnrusbin,
  hcendpnrusbout,
  hcunderrien,
  hcnakidisin,
  hcnakidisout,
  hcdopingout,
  hcdoisoout,
  hcepsuspendout,
  hcoutmaxpckusb,
  hcepwaitout,
  rxactiveff,
  rxtxidle,

  upstren,
  downstren,
  hclocsof,
  busidle,
  lsmode,
  hcerrtype,
  hcerrinc,
  hcerrclr,
  hcerrset,
  hcepdir,
  hcepwaitclr,
  hcepwaitset,
  hcdevdopingset,
  hcdevdopingclr,
  enterhm,
  hcisostop,
  sendtok,
  hctoken,
  hcsleep_ack,
  hcepnr,
  hcfrmcount,
  hcfrmnr,

  hcsendsof,

  innak,
  innak_no,

  suspendm,
  sleepm,

  clrmfrmnrack,
  clrmfrmnr,
  isosofpulse,
  isosofpulsereq,
  isodump2k,
  isodump1k,

  lpm_nyet,
  lpm_usbirq,
  lpm_token,
  lpm_token_84,
  lpm_sleep_req,
  lpmirq,
  lpmirq_retry,

  sof_rcv_disable,

  hcnak_hshk,

  enable,
  hsmode,
  timeout,
  usbreset
  );

  `include "cdnsusbhs_cusb2_params.v"

  input                        usbclk;
  input                        usbrst;
  input   [6:0]                fnaddr;
  input                        ep0toggleout;
  input                        ep0togglein;
  input                        ep0datastage;
  input   [15:1]               epvalin;
  input   [31:2]               eptypein;
  input   [31:2]               eptypeout;
  input   [15:0]               stallin;
  input   [15:0]               busyin;
  input   [31:2]               togglein;
  input   [31:2]               toggleout;
  input   [15:0]               dviin;
  input   [15:0]               epvalout;
  input   [15:0]               stallout;
  input   [15:0]               busyout;
  input   [15:0]               nxtbusyout;
  input   [15:0]               bufffullout;
  input                        testmode;
  input   [6:0]                tfnaddr;
  input   [3:0]                tendp;
  input   [3:0]                tendpnxt;
  input   [4:0]                pid;
  input                        piderr;
  input                        usberr;
  input                        rcvfall;
  input                        txfall;
  input                        overflowwr;
  output                       clroutbsy;
  wire                         clroutbsy;
  output                       clrinbsy;
  wire                         clrinbsy;
  output                       tokrcvfall;
  wire                         tokrcvfall;
  output                       settoken;
  wire                         settoken;


  output                       sendhshk;
  wire                         sendhshk;
  output                       sendpckt;
  wire                         sendpckt;
  output                       sendzeroiso;
  wire                         sendzeroiso;
  output                       receive;
  wire                         receive;
  output                       dvi;
  reg                          dvi;
  output  [3:0]                sendpid;
  wire    [3:0]                sendpid;
  output                       busyff;
  wire                         busyff;
  output                       tokenok;
  wire                         tokenok;
  output                       sendstall;
  wire                         sendstall;
  output                       outpngirq;
  wire                         outpngirq;
  output  [3:0]                outpngirq_no;
  wire    [3:0]                outpngirq_no;
  output                       sofirq;
  wire                         sofirq;

  output                       sofpulse;
  reg                          sofpulse;

  input                        lpm_nyet;
  input                        lpm_usbirq;
  input    [8:0]               lpm_token;
  output   [5:0]               lpm_token_84;
  reg      [5:0]               lpm_token_84;
  output                       lpm_sleep_req;
  wire                         lpm_sleep_req;
  output                       lpmirq;
  reg                          lpmirq;
  input                        lpmirq_retry;

  input                        hcdosetup;
  input   [7:0]                hclpmctrl;
  input                        hclpmctrlb;
  input                        hcdolpm;
  input                        lpmstate;
  input                        lpmstate_besl;
  input   [31:2]               isotogglein;
  input   [16*11-1:0]          hcinmaxpckusb;
  input   [15:1]               hcdoisoin;
  input   [15:0]               hcepsuspendin;
  input   [15:0]               hcepwaitin;
  input   [63:0]               hcendpnrusbin;
  input   [63:0]               hcendpnrusbout;
  input   [15:0]               hcunderrien;
  input   [15:0]               hcnakidisin;
  input   [15:0]               hcnakidisout;
  input   [15:0]               hcdopingout;
  input   [15:1]               hcdoisoout;
  input   [15:0]               hcepsuspendout;
  input   [16*11-1:0]          hcoutmaxpckusb;
  input   [15:0]               hcepwaitout;
  input                        rxactiveff;
  input                        rxtxidle;
  input                        upstren;
  input                        downstren;
  input                        hclocsof;
  input                        busidle;
  input                        lsmode;
  output  [2:0]                hcerrtype;
  reg     [2:0]                hcerrtype;
  output                       hcerrinc;
  reg                          hcerrinc;
  output                       hcerrclr;
  reg                          hcerrclr;
  output                       hcerrset;
  reg                          hcerrset;
  output                       hcepdir;
  wire                         hcepdir;
  output                       hcepwaitclr;
  reg                          hcepwaitclr;
  output                       hcepwaitset;
  reg                          hcepwaitset;
  output                       hcdevdopingset;
  reg                          hcdevdopingset;
  output                       hcdevdopingclr;
  reg                          hcdevdopingclr;
  output                       enterhm;
  wire                         enterhm;
  output                       hcisostop;
  wire                         hcisostop;
  output                       sendtok;
  wire                         sendtok;
  output  [10:0]               hctoken;
  reg     [10:0]               hctoken;
  output                       hcsleep_ack;
  reg                          hcsleep_ack;
  output  [3:0]                hcepnr;
  wire    [3:0]                hcepnr;
  output  [10:0]               hcfrmcount;
  reg     [10:0]               hcfrmcount;
  output  [15:0]               hcfrmnr;
  reg     [15:0]               hcfrmnr;

  output                       hcsendsof;
  wire                         hcsendsof;

  output                       innak;
  wire                         innak;
  output   [3:0]               innak_no;
  wire     [3:0]               innak_no;

  input                        suspendm;
  input                        sleepm;

  input                        clrmfrmnr;
  output                       clrmfrmnrack;
  reg                          clrmfrmnrack;
  output                       isosofpulse;
  wire                         isosofpulse;
  output                       isosofpulsereq;
  reg                          isosofpulsereq;
  output                       isodump2k;
  reg                          isodump2k;
  output                       isodump1k;
  reg                          isodump1k;

  input                        sof_rcv_disable;

  input  [5:0]                 hcnak_hshk;

  input                        enable;
  input                        hsmode;
  input                        timeout;
  input                        usbreset;

  reg                          setup_token;
  wire                         togglerr;
  reg                          epval;
  reg    [1:0]                 eptype;
  reg                          stall;
  reg                          busy;
  reg                          nxtbusy;
  reg    [1:0]                 toggle;
  reg                          epval_ff;
  reg                          busy_ff;
  reg                          stall_ff;
  reg                          nxtbusy_ff;
  wire                         bufffull;
  reg                          overflow;
  wire   [4:0]                 send_pid;
  reg    [4:0]                 send_pid_dev;
  reg    [4:0]                 send_pid_host;
  wire                         send_hshk;
  wire                         tok_rcv_fall;
  wire                         sof_rcv_fall;




  wire                         clr_outbsy;

  wire                         not_usb_overflow;
  wire                         usb_overflow;
  wire                         usb_bufffull;

  reg                          interpackdly_dev;
  reg                          interpackdly_host;

  wire                         phreceive;

  reg                          sendsof;

  reg                          isosofsend;

  reg    [15:0]                htscmpout;
  reg    [15:0]                htscmpin;
  reg                          hcdotrans;
  reg                          hcdir;
  reg                          hcdoping;
  reg    [6:0]                 interpackcounter;
  reg    [1:0]                 hceptype;
  reg    [1:0]                 hctoggle;
  wire                         hctogglerr;
  reg    [1:0]                 hcisotoggle;
  reg    [4:0]                 hcdatapid;
  reg    [15:0]                hcdooutvect;
  reg                          hcouteptype0;
  reg                          hc_outeptype0;
  reg                          hcdoout;
  reg                          hc_doout;
  reg    [3:0]                 hcoutepnr;
  wire   [3:0]                 hc_outepnr;
  reg    [15:0]                hcdoinvect;
  reg                          hcineptype0;
  reg                          hc_ineptype0;
  reg                          hcdoin;
  reg                          hc_doin;
  reg    [3:0]                 hcinepnr;
  wire   [3:0]                 hc_inepnr;
  wire                         hcreceive;
  reg    [2:0]                 hcmframecounter;
  reg    [4:0]                 hccountm20;
  wire                         frmcounten20;
  reg    [15:0]                hc_frmnumber;
  reg    [10:0]                hcfrmremaincmp;
  reg                          htsdisable;
  wire                         hcfrmremainhsth1;
  wire                         hcfrmremainhsth2;
  wire                         hcfrmremainhsth3;
  wire                         hcfrmremainfsth1;
  wire                         hcfrmremainfsth2;
  wire                         hcfrmremainfsth3;
  reg                          hcframecounter_r;
  wire                         hcframecounter_w;
  wire                         hcframecounter_i;
  reg    [11:0]                hcframecounter;
  reg    [11:0]                hcframecounter_v;
  reg                          usbreset_r;
  reg                          downstren_r;
  wire                         enter_hm;
  reg                          underrien;
  reg                          hcnakidis;

  reg    [7:0]                 eptypeout_s1;
  reg    [3:0]                 eptypeout_s2;
  reg    [1:0]                 eptypeout_s3;
  reg    [7:0]                 hcdoout_s1;
  reg    [3:0]                 hcdoout_s2;
  reg    [1:0]                 hcdoout_s3;
  reg    [7:0]                 selhcout_s1;
  reg    [3:0]                 selhcout_s2;
  reg    [1:0]                 selhcout_s3;
  reg                          hcoutepnr_s3;
  reg                          hcoutepnr_s2;
  reg                          hcoutepnr_s1;
  reg                          hcoutepnr_s0;

  reg    [7:0]                 eptypein_s1;
  reg    [3:0]                 eptypein_s2;
  reg    [1:0]                 eptypein_s3;
  reg    [7:0]                 hcdoin_s1;
  reg    [3:0]                 hcdoin_s2;
  reg    [1:0]                 hcdoin_s3;
  reg    [7:0]                 selhcin_s1;
  reg    [3:0]                 selhcin_s2;
  reg    [1:0]                 selhcin_s3;
  reg                          hcinepnr_s3;
  reg                          hcinepnr_s2;
  reg                          hcinepnr_s1;
  reg                          hcinepnr_s0;

  wire   [15:0]                hcdoisoout_x;
  wire   [15:0]                hcdoisoin_x;
  reg    [15:0]                transreq_v;
  reg    [15:0]                hceptypeout_s;
  reg    [15:0]                hceptypein_s;
  reg    [15:0]                htscmpout_v;
  reg    [15:0]                htscmpin_v;

  reg                          timeout_r;

  reg                          framecounter_en;
  reg    [14:0]                framecounter;

  reg    [14:0]                curframe;
  reg                          curframeov;
  reg                          curframestart;
  reg    [14:0]                nxtframe;

  reg                          sofok;
  reg                          lastsofok;

  reg                          sendsof_tmp;
  reg                          isosof_r;
  reg                          isosof_r1;

  reg    [2:0]                 sofirq_filtered;

  reg                          tokenpid;
  reg                          tokenpid_r;
  wire                         tokenpid_next;
  reg                          wait_on_idle;
  reg                          busidle_r;




  reg                          hcsleep_ack_r;
  reg                          lpm_hold;

  reg                          lpm_count;
  reg    [8:0]                 lpm_counter;

  wire                         ttokenretry;

  wire                         lpm_send_stall;
  wire                         lpm_send_nyet;

  wire                         lpm_ack_nyet_hshk;

  reg                          lpmstate_r;

  wire   [1:0]                 eptypein_v;
  wire   [1:0]                 eptypeout_v;
  wire   [1:0]                 togglein_v;
  wire   [1:0]                 toggleout_v;
  wire   [1:0]                 hctoggleout_v;
  wire   [1:0]                 hctogglein_v;
  wire                         dviin_v;
  wire                         hcdviin_v;

  wire                         epvalin_v;
  wire                         epvalout_v;
  wire                         busyin_v;
  wire                         busyout_v;
  wire                         nxtbusyout_v;
  wire                         stallin_v;
  wire                         stallout_v;

  reg    [15:0]                busyin_r;

  wire   [1:0]                 isotogglein_v;
  wire   [3:0]                 hcendpnrusbin_v;
  wire   [3:0]                 hcendpnrusbout_v;

  wire   [2:0]                 hcmfrmcount;
  wire   [15:0]                hcfrmnumber;

  wire   [2:0]                 hcnak_hshk_reg_hs;
  wire   [2:0]                 hcnak_hshk_reg_fs;

  wire                         hcnak_hshk_sel_hs;
  wire                         hcnak_hshk_sel_fs;
  wire                         hcnak_hshk_sel;
  reg                          hcnak_hshk_sel_r;
  wire                         hcnak_hshk_clr;

  reg    [15:0]                hcinnak;
  reg    [15:0]                hcoutnak;




  parameter R_TOK              = 5'b0_0000;
  parameter R_TOK_EXT          = 5'b0_0001;
  parameter R_PKT              = 5'b0_0010;
  parameter R_HSHK             = 5'b0_0011;
  parameter S_PKT              = 5'b0_0100;
  parameter S_ISOPKT           = 5'b0_0101;
  parameter S_ZEROISO          = 5'b0_0110;
  parameter S_ACK              = 5'b0_0111;
  parameter S_STA              = 5'b0_1000;
  parameter S_NAK              = 5'b0_1001;
  parameter S_NYT              = 5'b0_1010;
  parameter C_OUTNYT           = 5'b0_1011;
  parameter C_OUTACK           = 5'b0_1100;
  parameter C_OUT              = 5'b0_1101;
  parameter C_IN               = 5'b0_1110;
  parameter W_SHSHK            = 5'b0_1111;
  parameter W_SPKT             = 5'b1_0000;

  reg    [4:0]                 devfsm_st;

  reg    [4:0]                 devfsm_nxt;




  parameter HC_IDLE1           = 5'b0_0000;
  parameter HC_IDLE            = 5'b0_0001;
  parameter HCS_IN             = 5'b0_0010;
  parameter HCS_OUT            = 5'b0_0011;
  parameter HCS_PING           = 5'b0_0100;
  parameter HCS_SET            = 5'b0_0101;
  parameter HCS_SOF            = 5'b0_0110;
  parameter HCS_PKT            = 5'b0_0111;
  parameter HCS_ACK            = 5'b0_1000;
  parameter HCR_PKT            = 5'b0_1001;
  parameter HCR_HSHK           = 5'b0_1010;
  parameter HCR_PHSHK          = 5'b0_1011;
  parameter HCC_IN             = 5'b0_1100;
  parameter HCC_OUT            = 5'b0_1101;
  parameter HCC_INACK          = 5'b0_1110;
  parameter HC_DOPING          = 5'b0_1111;
  parameter HCC_DOPING         = 5'b1_0000;
  parameter HCW_SPKT           = 5'b1_0001;
  parameter HCW_SACK           = 5'b1_0010;
  parameter HC_RNAK            = 5'b1_0011;
  parameter HC_ERR             = 5'b1_0100;
  parameter HCS_EXT            = 5'b1_0101;
  parameter HCS_LPM            = 5'b1_0110;

  reg    [4:0]                 hcfsm_st;

  reg    [4:0]                 hcfsm_nxt;




  assign eptypein_v    = (tendp == 4'hF) ? eptypein[(15+1)*2-1 : 15*2] :
                         (tendp == 4'hE) ? eptypein[(14+1)*2-1 : 14*2] :
                         (tendp == 4'hD) ? eptypein[(13+1)*2-1 : 13*2] :
                         (tendp == 4'hC) ? eptypein[(12+1)*2-1 : 12*2] :
                         (tendp == 4'hB) ? eptypein[(11+1)*2-1 : 11*2] :
                         (tendp == 4'hA) ? eptypein[(10+1)*2-1 : 10*2] :
                         (tendp == 4'h9) ? eptypein[( 9+1)*2-1 :  9*2] :
                         (tendp == 4'h8) ? eptypein[( 8+1)*2-1 :  8*2] :
                         (tendp == 4'h7) ? eptypein[( 7+1)*2-1 :  7*2] :
                         (tendp == 4'h6) ? eptypein[( 6+1)*2-1 :  6*2] :
                         (tendp == 4'h5) ? eptypein[( 5+1)*2-1 :  5*2] :
                         (tendp == 4'h4) ? eptypein[( 4+1)*2-1 :  4*2] :
                         (tendp == 4'h3) ? eptypein[( 3+1)*2-1 :  3*2] :
                         (tendp == 4'h2) ? eptypein[( 2+1)*2-1 :  2*2] :
                         (tendp == 4'h1) ? eptypein[( 1+1)*2-1 :  1*2] :
                                           EP_CTRL ;




  assign eptypeout_v   = (tendp == 4'hF) ? eptypeout[(15+1)*2-1 : 15*2] :
                         (tendp == 4'hE) ? eptypeout[(14+1)*2-1 : 14*2] :
                         (tendp == 4'hD) ? eptypeout[(13+1)*2-1 : 13*2] :
                         (tendp == 4'hC) ? eptypeout[(12+1)*2-1 : 12*2] :
                         (tendp == 4'hB) ? eptypeout[(11+1)*2-1 : 11*2] :
                         (tendp == 4'hA) ? eptypeout[(10+1)*2-1 : 10*2] :
                         (tendp == 4'h9) ? eptypeout[( 9+1)*2-1 :  9*2] :
                         (tendp == 4'h8) ? eptypeout[( 8+1)*2-1 :  8*2] :
                         (tendp == 4'h7) ? eptypeout[( 7+1)*2-1 :  7*2] :
                         (tendp == 4'h6) ? eptypeout[( 6+1)*2-1 :  6*2] :
                         (tendp == 4'h5) ? eptypeout[( 5+1)*2-1 :  5*2] :
                         (tendp == 4'h4) ? eptypeout[( 4+1)*2-1 :  4*2] :
                         (tendp == 4'h3) ? eptypeout[( 3+1)*2-1 :  3*2] :
                         (tendp == 4'h2) ? eptypeout[( 2+1)*2-1 :  2*2] :
                         (tendp == 4'h1) ? eptypeout[( 1+1)*2-1 :  1*2] :
                                           EP_CTRL ;




  assign togglein_v    = (tendp == 4'hF) ? togglein[(15+1)*2-1 : 15*2] :
                         (tendp == 4'hE) ? togglein[(14+1)*2-1 : 14*2] :
                         (tendp == 4'hD) ? togglein[(13+1)*2-1 : 13*2] :
                         (tendp == 4'hC) ? togglein[(12+1)*2-1 : 12*2] :
                         (tendp == 4'hB) ? togglein[(11+1)*2-1 : 11*2] :
                         (tendp == 4'hA) ? togglein[(10+1)*2-1 : 10*2] :
                         (tendp == 4'h9) ? togglein[( 9+1)*2-1 :  9*2] :
                         (tendp == 4'h8) ? togglein[( 8+1)*2-1 :  8*2] :
                         (tendp == 4'h7) ? togglein[( 7+1)*2-1 :  7*2] :
                         (tendp == 4'h6) ? togglein[( 6+1)*2-1 :  6*2] :
                         (tendp == 4'h5) ? togglein[( 5+1)*2-1 :  5*2] :
                         (tendp == 4'h4) ? togglein[( 4+1)*2-1 :  4*2] :
                         (tendp == 4'h3) ? togglein[( 3+1)*2-1 :  3*2] :
                         (tendp == 4'h2) ? togglein[( 2+1)*2-1 :  2*2] :
                         (tendp == 4'h1) ? togglein[( 1+1)*2-1 :  1*2] :
                                           {1'b0, ep0togglein};




  assign toggleout_v   = (tendp == 4'hF) ? toggleout[(15+1)*2-1 : 15*2] :
                         (tendp == 4'hE) ? toggleout[(14+1)*2-1 : 14*2] :
                         (tendp == 4'hD) ? toggleout[(13+1)*2-1 : 13*2] :
                         (tendp == 4'hC) ? toggleout[(12+1)*2-1 : 12*2] :
                         (tendp == 4'hB) ? toggleout[(11+1)*2-1 : 11*2] :
                         (tendp == 4'hA) ? toggleout[(10+1)*2-1 : 10*2] :
                         (tendp == 4'h9) ? toggleout[( 9+1)*2-1 :  9*2] :
                         (tendp == 4'h8) ? toggleout[( 8+1)*2-1 :  8*2] :
                         (tendp == 4'h7) ? toggleout[( 7+1)*2-1 :  7*2] :
                         (tendp == 4'h6) ? toggleout[( 6+1)*2-1 :  6*2] :
                         (tendp == 4'h5) ? toggleout[( 5+1)*2-1 :  5*2] :
                         (tendp == 4'h4) ? toggleout[( 4+1)*2-1 :  4*2] :
                         (tendp == 4'h3) ? toggleout[( 3+1)*2-1 :  3*2] :
                         (tendp == 4'h2) ? toggleout[( 2+1)*2-1 :  2*2] :
                         (tendp == 4'h1) ? toggleout[( 1+1)*2-1 :  1*2] :
                                           {1'b0, ep0toggleout};




  assign hctoggleout_v = (hcoutepnr == 4'hF) ? togglein[(15+1)*2-1 : 15*2] :
                         (hcoutepnr == 4'hE) ? togglein[(14+1)*2-1 : 14*2] :
                         (hcoutepnr == 4'hD) ? togglein[(13+1)*2-1 : 13*2] :
                         (hcoutepnr == 4'hC) ? togglein[(12+1)*2-1 : 12*2] :
                         (hcoutepnr == 4'hB) ? togglein[(11+1)*2-1 : 11*2] :
                         (hcoutepnr == 4'hA) ? togglein[(10+1)*2-1 : 10*2] :
                         (hcoutepnr == 4'h9) ? togglein[( 9+1)*2-1 :  9*2] :
                         (hcoutepnr == 4'h8) ? togglein[( 8+1)*2-1 :  8*2] :
                         (hcoutepnr == 4'h7) ? togglein[( 7+1)*2-1 :  7*2] :
                         (hcoutepnr == 4'h6) ? togglein[( 6+1)*2-1 :  6*2] :
                         (hcoutepnr == 4'h5) ? togglein[( 5+1)*2-1 :  5*2] :
                         (hcoutepnr == 4'h4) ? togglein[( 4+1)*2-1 :  4*2] :
                         (hcoutepnr == 4'h3) ? togglein[( 3+1)*2-1 :  3*2] :
                         (hcoutepnr == 4'h2) ? togglein[( 2+1)*2-1 :  2*2] :
                         (hcoutepnr == 4'h1) ? togglein[( 1+1)*2-1 :  1*2] :
                                               {1'b0, ep0togglein};




  assign hctogglein_v  = (hcinepnr == 4'hF) ? toggleout[(15+1)*2-1 : 15*2] :
                         (hcinepnr == 4'hE) ? toggleout[(14+1)*2-1 : 14*2] :
                         (hcinepnr == 4'hD) ? toggleout[(13+1)*2-1 : 13*2] :
                         (hcinepnr == 4'hC) ? toggleout[(12+1)*2-1 : 12*2] :
                         (hcinepnr == 4'hB) ? toggleout[(11+1)*2-1 : 11*2] :
                         (hcinepnr == 4'hA) ? toggleout[(10+1)*2-1 : 10*2] :
                         (hcinepnr == 4'h9) ? toggleout[( 9+1)*2-1 :  9*2] :
                         (hcinepnr == 4'h8) ? toggleout[( 8+1)*2-1 :  8*2] :
                         (hcinepnr == 4'h7) ? toggleout[( 7+1)*2-1 :  7*2] :
                         (hcinepnr == 4'h6) ? toggleout[( 6+1)*2-1 :  6*2] :
                         (hcinepnr == 4'h5) ? toggleout[( 5+1)*2-1 :  5*2] :
                         (hcinepnr == 4'h4) ? toggleout[( 4+1)*2-1 :  4*2] :
                         (hcinepnr == 4'h3) ? toggleout[( 3+1)*2-1 :  3*2] :
                         (hcinepnr == 4'h2) ? toggleout[( 2+1)*2-1 :  2*2] :
                         (hcinepnr == 4'h1) ? toggleout[( 1+1)*2-1 :  1*2] :
                                              {1'b0, ep0toggleout};




  assign dviin_v       = (tendp == 4'hF) ? dviin[15] :
                         (tendp == 4'hE) ? dviin[14] :
                         (tendp == 4'hD) ? dviin[13] :
                         (tendp == 4'hC) ? dviin[12] :
                         (tendp == 4'hB) ? dviin[11] :
                         (tendp == 4'hA) ? dviin[10] :
                         (tendp == 4'h9) ? dviin[9] :
                         (tendp == 4'h8) ? dviin[8] :
                         (tendp == 4'h7) ? dviin[7] :
                         (tendp == 4'h6) ? dviin[6] :
                         (tendp == 4'h5) ? dviin[5] :
                         (tendp == 4'h4) ? dviin[4] :
                         (tendp == 4'h3) ? dviin[3] :
                         (tendp == 4'h2) ? dviin[2] :
                         (tendp == 4'h1) ? dviin[1] :
                  (ep0datastage == 1'b1) ? dviin[0] :
                                           1'b0 ;




  assign hcdviin_v     = (tendp == 4'hF) ? dviin[15] :
                         (tendp == 4'hE) ? dviin[14] :
                         (tendp == 4'hD) ? dviin[13] :
                         (tendp == 4'hC) ? dviin[12] :
                         (tendp == 4'hB) ? dviin[11] :
                         (tendp == 4'hA) ? dviin[10] :
                         (tendp == 4'h9) ? dviin[9] :
                         (tendp == 4'h8) ? dviin[8] :
                         (tendp == 4'h7) ? dviin[7] :
                         (tendp == 4'h6) ? dviin[6] :
                         (tendp == 4'h5) ? dviin[5] :
                         (tendp == 4'h4) ? dviin[4] :
                         (tendp == 4'h3) ? dviin[3] :
                         (tendp == 4'h2) ? dviin[2] :
                         (tendp == 4'h1) ? dviin[1] :
                  (ep0datastage == 1'b1) ? dviin[0] :
                     (downstren == 1'b1) ? dviin[0] :
                                           1'b0 ;




  assign epvalin_v     = (tendpnxt == 4'hF) ? epvalin[15] :
                         (tendpnxt == 4'hE) ? epvalin[14] :
                         (tendpnxt == 4'hD) ? epvalin[13] :
                         (tendpnxt == 4'hC) ? epvalin[12] :
                         (tendpnxt == 4'hB) ? epvalin[11] :
                         (tendpnxt == 4'hA) ? epvalin[10] :
                         (tendpnxt == 4'h9) ? epvalin[9] :
                         (tendpnxt == 4'h8) ? epvalin[8] :
                         (tendpnxt == 4'h7) ? epvalin[7] :
                         (tendpnxt == 4'h6) ? epvalin[6] :
                         (tendpnxt == 4'h5) ? epvalin[5] :
                         (tendpnxt == 4'h4) ? epvalin[4] :
                         (tendpnxt == 4'h3) ? epvalin[3] :
                         (tendpnxt == 4'h2) ? epvalin[2] :
                         (tendpnxt == 4'h1) ? epvalin[1] :
                                              1'b1 ;




  assign epvalout_v    = (tendpnxt == 4'hF) ? epvalout[15] :
                         (tendpnxt == 4'hE) ? epvalout[14] :
                         (tendpnxt == 4'hD) ? epvalout[13] :
                         (tendpnxt == 4'hC) ? epvalout[12] :
                         (tendpnxt == 4'hB) ? epvalout[11] :
                         (tendpnxt == 4'hA) ? epvalout[10] :
                         (tendpnxt == 4'h9) ? epvalout[9] :
                         (tendpnxt == 4'h8) ? epvalout[8] :
                         (tendpnxt == 4'h7) ? epvalout[7] :
                         (tendpnxt == 4'h6) ? epvalout[6] :
                         (tendpnxt == 4'h5) ? epvalout[5] :
                         (tendpnxt == 4'h4) ? epvalout[4] :
                         (tendpnxt == 4'h3) ? epvalout[3] :
                         (tendpnxt == 4'h2) ? epvalout[2] :
                         (tendpnxt == 4'h1) ? epvalout[1] :
                                              1'b1 ;




  assign busyin_v      = (tendpnxt == 4'hF) ? busyin[15] :
                         (tendpnxt == 4'hE) ? busyin[14] :
                         (tendpnxt == 4'hD) ? busyin[13] :
                         (tendpnxt == 4'hC) ? busyin[12] :
                         (tendpnxt == 4'hB) ? busyin[11] :
                         (tendpnxt == 4'hA) ? busyin[10] :
                         (tendpnxt == 4'h9) ? busyin[9] :
                         (tendpnxt == 4'h8) ? busyin[8] :
                         (tendpnxt == 4'h7) ? busyin[7] :
                         (tendpnxt == 4'h6) ? busyin[6] :
                         (tendpnxt == 4'h5) ? busyin[5] :
                         (tendpnxt == 4'h4) ? busyin[4] :
                         (tendpnxt == 4'h3) ? busyin[3] :
                         (tendpnxt == 4'h2) ? busyin[2] :
                         (tendpnxt == 4'h1) ? busyin[1] :
                                              busyin[0] ;




  assign busyout_v     = (tendpnxt == 4'hF) ? busyout[15] :
                         (tendpnxt == 4'hE) ? busyout[14] :
                         (tendpnxt == 4'hD) ? busyout[13] :
                         (tendpnxt == 4'hC) ? busyout[12] :
                         (tendpnxt == 4'hB) ? busyout[11] :
                         (tendpnxt == 4'hA) ? busyout[10] :
                         (tendpnxt == 4'h9) ? busyout[9] :
                         (tendpnxt == 4'h8) ? busyout[8] :
                         (tendpnxt == 4'h7) ? busyout[7] :
                         (tendpnxt == 4'h6) ? busyout[6] :
                         (tendpnxt == 4'h5) ? busyout[5] :
                         (tendpnxt == 4'h4) ? busyout[4] :
                         (tendpnxt == 4'h3) ? busyout[3] :
                         (tendpnxt == 4'h2) ? busyout[2] :
                         (tendpnxt == 4'h1) ? busyout[1] :
                                              busyout[0] ;




  assign nxtbusyout_v  = (tendp == 4'hF) ? nxtbusyout[15] :
                         (tendp == 4'hE) ? nxtbusyout[14] :
                         (tendp == 4'hD) ? nxtbusyout[13] :
                         (tendp == 4'hC) ? nxtbusyout[12] :
                         (tendp == 4'hB) ? nxtbusyout[11] :
                         (tendp == 4'hA) ? nxtbusyout[10] :
                         (tendp == 4'h9) ? nxtbusyout[9] :
                         (tendp == 4'h8) ? nxtbusyout[8] :
                         (tendp == 4'h7) ? nxtbusyout[7] :
                         (tendp == 4'h6) ? nxtbusyout[6] :
                         (tendp == 4'h5) ? nxtbusyout[5] :
                         (tendp == 4'h4) ? nxtbusyout[4] :
                         (tendp == 4'h3) ? nxtbusyout[3] :
                         (tendp == 4'h2) ? nxtbusyout[2] :
                         (tendp == 4'h1) ? nxtbusyout[1] :
                                           nxtbusyout[0] ;




  assign stallin_v     = (tendpnxt == 4'hF) ? stallin[15] :
                         (tendpnxt == 4'hE) ? stallin[14] :
                         (tendpnxt == 4'hD) ? stallin[13] :
                         (tendpnxt == 4'hC) ? stallin[12] :
                         (tendpnxt == 4'hB) ? stallin[11] :
                         (tendpnxt == 4'hA) ? stallin[10] :
                         (tendpnxt == 4'h9) ? stallin[9] :
                         (tendpnxt == 4'h8) ? stallin[8] :
                         (tendpnxt == 4'h7) ? stallin[7] :
                         (tendpnxt == 4'h6) ? stallin[6] :
                         (tendpnxt == 4'h5) ? stallin[5] :
                         (tendpnxt == 4'h4) ? stallin[4] :
                         (tendpnxt == 4'h3) ? stallin[3] :
                         (tendpnxt == 4'h2) ? stallin[2] :
                         (tendpnxt == 4'h1) ? stallin[1] :
                                              stallin[0] ;




  assign stallout_v    = (tendpnxt == 4'hF) ? stallout[15] :
                         (tendpnxt == 4'hE) ? stallout[14] :
                         (tendpnxt == 4'hD) ? stallout[13] :
                         (tendpnxt == 4'hC) ? stallout[12] :
                         (tendpnxt == 4'hB) ? stallout[11] :
                         (tendpnxt == 4'hA) ? stallout[10] :
                         (tendpnxt == 4'h9) ? stallout[9] :
                         (tendpnxt == 4'h8) ? stallout[8] :
                         (tendpnxt == 4'h7) ? stallout[7] :
                         (tendpnxt == 4'h6) ? stallout[6] :
                         (tendpnxt == 4'h5) ? stallout[5] :
                         (tendpnxt == 4'h4) ? stallout[4] :
                         (tendpnxt == 4'h3) ? stallout[3] :
                         (tendpnxt == 4'h2) ? stallout[2] :
                         (tendpnxt == 4'h1) ? stallout[1] :
                                              stallout[0] ;




  assign isotogglein_v    = (hcoutepnr == 4'hF) ? isotogglein[(15+1)*2-1 : 15*2] :
                            (hcoutepnr == 4'hE) ? isotogglein[(14+1)*2-1 : 14*2] :
                            (hcoutepnr == 4'hD) ? isotogglein[(13+1)*2-1 : 13*2] :
                            (hcoutepnr == 4'hC) ? isotogglein[(12+1)*2-1 : 12*2] :
                            (hcoutepnr == 4'hB) ? isotogglein[(11+1)*2-1 : 11*2] :
                            (hcoutepnr == 4'hA) ? isotogglein[(10+1)*2-1 : 10*2] :
                            (hcoutepnr == 4'h9) ? isotogglein[( 9+1)*2-1 :  9*2] :
                            (hcoutepnr == 4'h8) ? isotogglein[( 8+1)*2-1 :  8*2] :
                            (hcoutepnr == 4'h7) ? isotogglein[( 7+1)*2-1 :  7*2] :
                            (hcoutepnr == 4'h6) ? isotogglein[( 6+1)*2-1 :  6*2] :
                            (hcoutepnr == 4'h5) ? isotogglein[( 5+1)*2-1 :  5*2] :
                            (hcoutepnr == 4'h4) ? isotogglein[( 4+1)*2-1 :  4*2] :
                            (hcoutepnr == 4'h3) ? isotogglein[( 3+1)*2-1 :  3*2] :
                            (hcoutepnr == 4'h2) ? isotogglein[( 2+1)*2-1 :  2*2] :
                            (hcoutepnr == 4'h1) ? isotogglein[( 1+1)*2-1 :  1*2] :
                                                  2'b00 ;




  assign hcendpnrusbin_v  = (hcinepnr == 4'hF) ? hcendpnrusbin[(15+1)*4-1 : 15*4] :
                            (hcinepnr == 4'hE) ? hcendpnrusbin[(14+1)*4-1 : 14*4] :
                            (hcinepnr == 4'hD) ? hcendpnrusbin[(13+1)*4-1 : 13*4] :
                            (hcinepnr == 4'hC) ? hcendpnrusbin[(12+1)*4-1 : 12*4] :
                            (hcinepnr == 4'hB) ? hcendpnrusbin[(11+1)*4-1 : 11*4] :
                            (hcinepnr == 4'hA) ? hcendpnrusbin[(10+1)*4-1 : 10*4] :
                            (hcinepnr == 4'h9) ? hcendpnrusbin[( 9+1)*4-1 :  9*4] :
                            (hcinepnr == 4'h8) ? hcendpnrusbin[( 8+1)*4-1 :  8*4] :
                            (hcinepnr == 4'h7) ? hcendpnrusbin[( 7+1)*4-1 :  7*4] :
                            (hcinepnr == 4'h6) ? hcendpnrusbin[( 6+1)*4-1 :  6*4] :
                            (hcinepnr == 4'h5) ? hcendpnrusbin[( 5+1)*4-1 :  5*4] :
                            (hcinepnr == 4'h4) ? hcendpnrusbin[( 4+1)*4-1 :  4*4] :
                            (hcinepnr == 4'h3) ? hcendpnrusbin[( 3+1)*4-1 :  3*4] :
                            (hcinepnr == 4'h2) ? hcendpnrusbin[( 2+1)*4-1 :  2*4] :
                            (hcinepnr == 4'h1) ? hcendpnrusbin[( 1+1)*4-1 :  1*4] :
                                                 hcendpnrusbin[( 0+1)*4-1 :  0*4] ;




  assign hcendpnrusbout_v = (hcoutepnr == 4'hF) ? hcendpnrusbout[(15+1)*4-1 : 15*4] :
                            (hcoutepnr == 4'hE) ? hcendpnrusbout[(14+1)*4-1 : 14*4] :
                            (hcoutepnr == 4'hD) ? hcendpnrusbout[(13+1)*4-1 : 13*4] :
                            (hcoutepnr == 4'hC) ? hcendpnrusbout[(12+1)*4-1 : 12*4] :
                            (hcoutepnr == 4'hB) ? hcendpnrusbout[(11+1)*4-1 : 11*4] :
                            (hcoutepnr == 4'hA) ? hcendpnrusbout[(10+1)*4-1 : 10*4] :
                            (hcoutepnr == 4'h9) ? hcendpnrusbout[( 9+1)*4-1 :  9*4] :
                            (hcoutepnr == 4'h8) ? hcendpnrusbout[( 8+1)*4-1 :  8*4] :
                            (hcoutepnr == 4'h7) ? hcendpnrusbout[( 7+1)*4-1 :  7*4] :
                            (hcoutepnr == 4'h6) ? hcendpnrusbout[( 6+1)*4-1 :  6*4] :
                            (hcoutepnr == 4'h5) ? hcendpnrusbout[( 5+1)*4-1 :  5*4] :
                            (hcoutepnr == 4'h4) ? hcendpnrusbout[( 4+1)*4-1 :  4*4] :
                            (hcoutepnr == 4'h3) ? hcendpnrusbout[( 3+1)*4-1 :  3*4] :
                            (hcoutepnr == 4'h2) ? hcendpnrusbout[( 2+1)*4-1 :  2*4] :
                            (hcoutepnr == 4'h1) ? hcendpnrusbout[( 1+1)*4-1 :  1*4] :
                                                  hcendpnrusbout[( 0+1)*4-1 :  0*4] ;



  assign not_usb_overflow = ~overflow;
  assign usb_overflow     =  overflow & overflowwr;



  assign usb_bufffull = overflow;




  assign clr_outbsy = (hcfsm_st  == HCC_INACK ||
                       hcfsm_st  == HCC_IN    ||
                       devfsm_st == C_OUTACK  ||
                       devfsm_st == C_OUTNYT  ||
                      (devfsm_st == C_OUT && busy_ff == 1'b1)) ? 1'b1 :
                                                                 1'b0;




  assign clroutbsy = clr_outbsy;




  assign clrinbsy = (hcfsm_st  == HCC_OUT ||
                     devfsm_st == C_IN) ? 1'b1 :
                                          1'b0;




  always @(devfsm_st or toggle or hsmode)
    begin : SEND_PID_DEVICE_COMB_PROC




    case (devfsm_st)
        S_ACK,
        C_OUTACK :
            begin
            send_pid_dev = PID_ACK;
            end
        S_NAK :
            begin
            send_pid_dev = PID_NAK;
            end
        S_STA :
            begin
            send_pid_dev = PID_STALL;
            end
        C_OUTNYT :
            begin
            send_pid_dev = PID_NYET;
            end
        S_NYT :
            begin
            send_pid_dev = PID_NYET;
            end
        S_PKT :
            begin
            if (toggle[0] == 1'b1)
              begin
              send_pid_dev = PID_DATA1;
              end
            else
              begin
              send_pid_dev = PID_DATA0;
              end
            end
        S_ZEROISO :
            begin
            send_pid_dev = PID_DATA0;
            end
        S_ISOPKT :
            begin
            if (toggle == 2'b01)
              begin
              send_pid_dev = PID_DATA1;
              end
            else if (toggle == 2'b00 || hsmode == 1'b0)
              begin
              send_pid_dev = PID_DATA0;
              end
            else
              begin
              send_pid_dev = PID_DATA2;
              end
            end
        default :
            begin
            send_pid_dev = PID_DATA2;
            end
    endcase
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDATAPID_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcdatapid <= PID_DATA0;
      end
    else
      begin
      if (hceptype == EP_ISO)
        begin
        if (hsmode == 1'b0)
          begin
          hcdatapid <= PID_DATA0;
          end
        else
          begin
          case (hcisotoggle)
              2'b00 :
                  begin
                  hcdatapid <= PID_DATA0;
                  end
              2'b01 :
                  begin
                  if (hctoggle == 2'b01)
                    begin
                    hcdatapid <= PID_MDATA;
                    end
                  else
                    begin
                    hcdatapid <= PID_DATA1;
                    end
                  end
              default :
                  begin
                  if (hctoggle == 2'b10 ||
                      hctoggle == 2'b01)
                    begin
                    hcdatapid <= PID_MDATA;
                    end
                  else
                    begin
                    hcdatapid <= PID_DATA2;
                    end
                  end
            endcase
          end
        end
      else
        begin
        if (hctoggle[0] == 1'b0)
          begin
          hcdatapid <= PID_DATA0;
          end
        else
          begin
          hcdatapid <= PID_DATA1;
          end
        end
      end
    end




  always @(hcfsm_st or hcdatapid)
    begin : SEND_PID_HOST_COMB_PROC




    case (hcfsm_st)
        HCS_ACK,
        HCC_INACK :
            begin
            send_pid_host = PID_ACK;
            end
        HCS_IN :
            begin
            send_pid_host = PID_IN;
            end
        HCS_OUT :
            begin
            send_pid_host = PID_OUT;
            end
        HCS_PING :
            begin
            send_pid_host = PID_PING;
            end
        HCS_SET :
            begin
            send_pid_host = PID_SETUP;
            end
        HCS_EXT :
            begin
            send_pid_host = PID_EXT;
            end
        HCS_LPM :
            begin
            send_pid_host = PID_LPM;
            end
        HCS_SOF :
            begin
            send_pid_host = PID_SOF;
            end
        default :
            begin

            send_pid_host = hcdatapid;
            end
    endcase
    end




  assign send_pid = (upstren == 1'b0) ? send_pid_host :
                                        send_pid_dev;




  assign sendpid = send_pid[3:0];




























  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SETUP_TOKEN_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      setup_token <= 1'b0;
      end
    else
      begin
      if (tok_rcv_fall == 1'b1 &&
          pid == PID_SETUP &&
          tendp == 4'h0)
        begin
        setup_token <= 1'b1;
        end
      else if (clr_outbsy == 1'b1)
        begin
        setup_token <= 1'b0;
        end
      else if (devfsm_st  == R_PKT &&
               devfsm_nxt == R_TOK)
        begin
        setup_token <= 1'b0;
        end
      end
    end




  assign settoken = setup_token;




  assign sendstall = (devfsm_st == S_STA) ? 1'b1 :
                                            1'b0;




  assign send_hshk = (hcfsm_st  == HCS_ACK   ||
                      hcfsm_st  == HCC_INACK ||
                      devfsm_st == S_ACK     ||
                      devfsm_st == S_NAK     ||
                      devfsm_st == S_STA     ||
                      devfsm_st == C_OUTNYT  ||
                      devfsm_st == S_NYT     ||
                      devfsm_st == C_OUTACK) ? 1'b1 :
                                               1'b0;




  assign sendhshk = send_hshk;




  assign sendpckt = (hcfsm_st  == HCS_PKT ||
                     devfsm_st == S_PKT   ||
                     devfsm_st == S_ISOPKT) ? 1'b1 :
                                              1'b0;




  assign sendzeroiso = (devfsm_st == S_ZEROISO) ? 1'b1 :
                                                  1'b0;




  assign hcisostop = (
                      hcfsm_st == HC_ERR ||
                        (rcvfall == 1'b1      &&
                         pid     == PID_DATA0 &&
                         piderr  == 1'b0)
                     ) ? 1'b1 :
                         1'b0;




  assign sendtok = (hcfsm_st == HCS_IN   ||
                    hcfsm_st == HCS_OUT  ||
                    hcfsm_st == HCS_PING ||
                    hcfsm_st == HCS_SET  ||
                    hcfsm_st == HCS_EXT  ||
                    hcfsm_st == HCS_LPM  ||
                    hcfsm_st == HCS_SOF)   ? 1'b1 :
                                             1'b0;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCTOKEN_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hctoken <= {11{1'b0}};
      end
    else
      begin
      if (htsdisable == 1'b1 &&
          hcframecounter == 12'h000)
        begin
        hctoken[10:0] <= hc_frmnumber[10:0];
        end
      else if (~(hcfsm_st == HCS_SOF ||
                 sendsof == 1'b1))
        begin
        if (hcfsm_nxt == HCS_LPM)
          begin
          hctoken <= {2'b00, hclpmctrlb, hclpmctrl};
          end
        else
          begin
          if (hcdir == 1'b0)
            begin
            hctoken[10:7] <= hcendpnrusbout_v;
            hctoken[6:0]  <= fnaddr[6:0];
            end
          else
            begin
            hctoken[10:7] <= hcendpnrusbin_v;
            hctoken[6:0]  <= fnaddr[6:0];
            end
          end
        end
      end
    end




  assign phreceive = (
                      devfsm_st == R_PKT &&
                      not_usb_overflow == 1'b1 &&
                      (
                       ((togglerr == 1'b0 || eptype == EP_ISO) &&
                         busy_ff  == 1'b1 &&
                         stall_ff == 1'b0
                       ) ||
                         setup_token == 1'b1
                      )
                     ) ? 1'b1 :
                         1'b0;




  assign hcreceive = (
                      hcfsm_st == HCR_PKT &&
                      not_usb_overflow == 1'b1 &&
                      (hctogglerr == 1'b0 || hceptype == EP_ISO)
                     ) ? 1'b1 :
                         1'b0;




  assign receive = hcreceive | phreceive;




  assign bufffull = bufffullout[tendp];




  assign tok_rcv_fall = (
                         ((devfsm_st == R_TOK &&
                           rcvfall == 1'b1 &&
                           piderr == 1'b0 &&
                           usberr == 1'b0
                          ) || tokenpid_r == 1'b1
                         ) && fnaddr == tfnaddr
                        ) ? 1'b1 :
                            1'b0;




  assign tokrcvfall = tok_rcv_fall;




  always @(stallout_v or stallin_v or
           busyout_v or nxtbusyout_v or busyin_v or
           toggleout_v or togglein_v or
           eptypeout_v or eptypein_v or
           epvalout_v or epvalin_v or
           dviin_v or hcdviin_v or
           downstren or
           devfsm_st or pid)
    begin : EPFLAGS_COMB_PROC









    if (devfsm_st == R_TOK_EXT ||
       (pid == PID_EXT && downstren == 1'b0))
      begin
      epval   = 1'b1;
      eptype  = 2'b00;
      stall   = 1'b0;
      busy    = 1'b0;
      nxtbusy = 1'b0;
      toggle  = 2'b00;
      dvi     = 1'b0;
      end
    else if (devfsm_st == R_PKT ||
             devfsm_st == W_SHSHK ||
             pid == PID_OUT ||
             pid == PID_SETUP ||
             pid == PID_PING)
      begin

      busy    = busyout_v;
      nxtbusy = nxtbusyout_v;
      stall   = stallout_v;
      eptype  = eptypeout_v;
      toggle  = toggleout_v;
      dvi     = dviin_v;
      epval   = epvalout_v;
      end
    else
      begin

      busy    = busyin_v;
      nxtbusy = 1'b0;
      stall   = stallin_v;
      eptype  = eptypein_v;
      toggle  = togglein_v;
      dvi     = hcdviin_v;
      epval   = epvalin_v;
      end
    end




  assign togglerr = ((toggle[0] == 1'b1 && pid[3] == 1'b0) ||
                     (toggle[0] == 1'b0 && pid[3] == 1'b1)) ? 1'b1 :
                                                              1'b0 ;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : BUSY_FF_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      epval_ff   <= 1'b0;
      busy_ff    <= 1'b0;
      nxtbusy_ff <= 1'b0;
      stall_ff   <= 1'b0;
      end
    else
      begin
      if ((devfsm_st == R_TOK && devfsm_nxt == R_TOK) || tokenpid_next == 1'b1)
        begin
        epval_ff <= epval;

        if (stall == 1'b1)
          begin
          busy_ff    <= 1'b0;

          stall_ff   <= 1'b1;
          end
        else
          begin
          busy_ff    <= busy;

          stall_ff   <= 1'b0;
          end
        end
      if (stall_ff == 1'b1)
        begin
        nxtbusy_ff <= 1'b0;
        end
      else
        begin
        nxtbusy_ff <= nxtbusy;
        end
      end
    end






  assign busyff = busy_ff;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : OVERFLOW_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      overflow <= 1'b0;
      end
    else
      begin
      if (overflowwr == 1'b1 && bufffull == 1'b1)
        begin
        overflow <= 1'b1;
        end
      else if ((rcvfall == 1'b1 && upstren == 1'b1) ||
                hcfsm_st == HC_IDLE1)
        begin
        overflow <= 1'b0;
        end
      end
    end




  assign outpngirq    = (pid == PID_PING && send_pid == PID_NAK &&
                                            send_hshk == 1'b1) ? 1'b1 :
                                                                 1'b0 ;
  assign outpngirq_no = tendp;






  assign tokenok = (
                    ((devfsm_st == R_TOK &&
                      usberr == 1'b0 &&
                      piderr == 1'b0) || tokenpid == 1'b1
                    )
                    && tfnaddr == fnaddr && epval_ff == 1'b1
                   ) ? 1'b1 :
                       1'b0;





  always @(usberr or piderr or devfsm_st or pid or tendp)
    begin : TOKENPID_COMB_PROC



    if (usberr == 1'b0 &&
        piderr == 1'b0 &&
       (devfsm_st == R_PKT || devfsm_st == R_HSHK) &&
       (pid == PID_IN ||
        (pid == PID_SETUP && tendp == 4'h0) ||
         pid == PID_OUT ||
         pid == PID_EXT ||
         pid == PID_PING))
      begin
      tokenpid = 1'b1;
      end
    else
      begin
      tokenpid = 1'b0;
      end
    end



  assign tokenpid_next = tokenpid & rcvfall;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TOKENPID_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      tokenpid_r <= 1'b0;
      end
    else
      begin
      if (rcvfall)
        begin
        tokenpid_r <= tokenpid;
        end
      else
        begin
        tokenpid_r <= 1'b0;
        end
      end
    end




  always @(devfsm_st or rcvfall or piderr or tendp or testmode or
           stall_ff or setup_token or timeout or txfall or
           usberr or eptype or busy_ff or togglerr or tfnaddr or
           fnaddr or epval_ff or hsmode or pid or nxtbusy_ff or
           usb_overflow or
           interpackdly_dev or
           lpm_send_stall or lpm_send_nyet or
           tokenpid_r)
    begin : DEVFSM_NXT_COMB_PROC


    case (devfsm_st)

        R_TOK :
            begin
            if (((rcvfall == 1'b1 &&
                  usberr == 1'b0 &&
                  piderr == 1'b0) || tokenpid_r == 1'b1) &&
                  tfnaddr == fnaddr &&
                  epval_ff == 1'b1 &&
                  testmode == 1'b0)
              begin
              if (pid == PID_IN)
                begin

                devfsm_nxt = W_SPKT;
                end
              else if ((pid == PID_SETUP && tendp == 4'h0) ||
                        pid == PID_OUT)
                begin

                devfsm_nxt = R_PKT;
                end
              else if (pid == PID_EXT)
                begin
                devfsm_nxt = R_TOK_EXT;
                end
              else if (pid == PID_PING &&
                       hsmode == 1'b1 &&
                      (eptype == EP_BULK || eptype == EP_CTRL))
                begin

                if (stall_ff == 1'b1)
                  begin
                  devfsm_nxt = S_STA;
                  end
                else if (busy_ff == 1'b1)
                  begin
                  devfsm_nxt = S_ACK;
                  end
                else
                  begin
                  devfsm_nxt = S_NAK;
                  end
                end
              else
                begin

                devfsm_nxt = R_TOK;
                end
              end
            else
              begin
              devfsm_nxt = R_TOK;
              end
            end

        R_TOK_EXT :
            begin
            if (timeout == 1'b1)
              begin
              devfsm_nxt = R_TOK;
              end
            else if (rcvfall == 1'b1)
              begin
              if (usberr == 1'b0 &&
                  piderr == 1'b0 &&
                  testmode == 1'b0 &&
                  tfnaddr == fnaddr &&
                  epval_ff == 1'b1)
                begin
                if (pid == SUBPID_LPM)
                  begin
                  if (lpm_send_stall == 1'b1)
                    begin
                    devfsm_nxt = S_STA;
                    end
                  else if (lpm_send_nyet == 1'b1)
                    begin
                    devfsm_nxt = S_NYT;
                    end
                  else
                    begin
                    devfsm_nxt = S_ACK;
                    end
                  end
                else
                  begin
                  devfsm_nxt = R_TOK;
                  end
                end
              else
                begin
                devfsm_nxt = R_TOK;
                end
              end
            else
              begin
              devfsm_nxt = R_TOK_EXT;
              end
            end

        R_PKT :
            begin
            if (timeout == 1'b1 || usb_overflow == 1'b1)
              begin

              devfsm_nxt = R_TOK;
              end
            else if (rcvfall == 1'b1)
              begin
              if (usberr == 1'b1 ||
                  piderr == 1'b1 ||
                 (setup_token == 1'b1 && tendp != 4'h0) ||
                 !(pid == PID_DATA0 ||
                   pid == PID_DATA1 ||
                   pid == PID_DATA2 ||
                   pid == PID_MDATA))
                begin
                devfsm_nxt = R_TOK;
                end
              else if (eptype == EP_ISO)
                begin
                devfsm_nxt = C_OUT;
                end
              else if (pid == PID_DATA0 ||
                       pid == PID_DATA1)
                begin

                devfsm_nxt = W_SHSHK;
                end
              else
                begin
                devfsm_nxt = R_TOK;
                end
              end
            else
              begin
              devfsm_nxt = R_PKT;
              end
            end

        R_HSHK :
            begin
            if (timeout == 1'b1)
              begin
              devfsm_nxt = R_TOK;
              end
            else if (rcvfall == 1'b1)
              begin
              if (piderr == 1'b0)
                begin


                if (pid == PID_ACK)
                  begin
                  devfsm_nxt = C_IN;
                  end
                else
                  begin
                  devfsm_nxt = R_TOK;
                  end
                end
              else
                begin
                devfsm_nxt = R_TOK;
                end
              end
            else
              begin
              devfsm_nxt = R_HSHK;
              end
            end

        S_PKT :
            begin


            if (txfall == 1'b1)
              begin

              devfsm_nxt = R_HSHK;
              end
            else
              begin
              devfsm_nxt = S_PKT;
              end
            end

        S_ISOPKT :
            begin


            if (txfall == 1'b1)
              begin

              devfsm_nxt = C_IN;
              end
            else
              begin
              devfsm_nxt = S_ISOPKT;
              end
            end

        S_ZEROISO :
            begin


            if (txfall == 1'b1)
              begin
              devfsm_nxt = R_TOK;
              end
            else
              begin
              devfsm_nxt = S_ZEROISO;
              end
            end

        S_ACK :
            begin


            devfsm_nxt = R_TOK;
            end

        S_STA :
            begin


            devfsm_nxt = R_TOK;
            end

        S_NAK :
            begin


            devfsm_nxt = R_TOK;
            end

        C_OUTNYT :
            begin


            devfsm_nxt = R_TOK;
            end

        S_NYT :
            begin


            devfsm_nxt = R_TOK;
            end

        C_OUTACK :
            begin


            devfsm_nxt = R_TOK;
            end

        C_OUT :
            begin


            devfsm_nxt = R_TOK;
            end

        W_SHSHK :
            begin


            if (interpackdly_dev == 1'b1)
              begin
              if (setup_token == 1'b1)
                begin
                devfsm_nxt = C_OUTACK;
                end
              else if (stall_ff == 1'b1)
                begin
                devfsm_nxt = S_STA;
                end
              else if (togglerr == 1'b1)
                begin
                devfsm_nxt = S_ACK;
                end
              else if (busy_ff == 1'b0)
                begin
                devfsm_nxt = S_NAK;
                end
              else if (nxtbusy_ff == 1'b1 ||
                       eptype == EP_INT ||
                       hsmode == 1'b0)
                begin
                devfsm_nxt = C_OUTACK;
                end
              else
                begin
                devfsm_nxt = C_OUTNYT;
                end
              end
            else
              begin
              devfsm_nxt = W_SHSHK;
              end
            end

        W_SPKT :
            begin


            if (interpackdly_dev == 1'b1)
              begin
              if (eptype == EP_ISO)
                begin
                if (busy_ff == 1'b1)
                  begin
                  devfsm_nxt = S_ISOPKT;
                  end
                else
                  begin
                  devfsm_nxt = S_ZEROISO;
                  end
                end
              else if (stall_ff == 1'b1)
                begin
                devfsm_nxt = S_STA;
                end
              else if (busy_ff == 1'b1)
                begin
                devfsm_nxt = S_PKT;
                end
              else
                begin
                devfsm_nxt = S_NAK;
                end
              end
            else
              begin
              devfsm_nxt = W_SPKT;
              end
            end

        default :
            begin


            devfsm_nxt = R_TOK;
            end
    endcase
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DEVFSM_ST_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      devfsm_st <= R_TOK;
      end
    else
      begin
      if (usbreset == 1'b0 && upstren  == 1'b1)
        begin
        devfsm_st <= devfsm_nxt;
        end
      else
        begin

        devfsm_st <= R_TOK;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : INTERPACKDLY_DEV_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      interpackdly_dev <= 1'b0;
      end
    else
      begin
      if (devfsm_st == R_TOK)
        begin
        interpackdly_dev <= 1'b0;
        end
      else
        begin
        if (devfsm_st == W_SPKT  ||
            devfsm_st == W_SHSHK)
          begin
          interpackdly_dev <= 1'b1;
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBRESET_REG_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usbreset_r <= 1'b0;
      end
    else
      begin
      usbreset_r <= usbreset;
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LPMSTATE_REG_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      lpmstate_r <= 1'b0;
      end
    else
      begin
      lpmstate_r <= lpmstate;
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DOWNSTREN_REG_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      downstren_r <= 1'b0;
      end
    else
      begin
      downstren_r <= downstren;
      end
    end





  assign enter_hm = downstren & ~downstren_r;





  assign enterhm = enter_hm;











  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : INTERPACKCOUNTER_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      interpackcounter <= 7'b0000000;
      end
    else
      begin

      if (hcfsm_st == HC_IDLE1 ||
          hcfsm_st == HCS_SET ||
          hcfsm_st == HCS_EXT ||
          hcfsm_st == HCS_OUT ||
          hcfsm_st == HCR_PKT)
        begin
        interpackcounter <= 7'b0000000;
        end
      else if (interpackcounter != 7'b1111111 &&
               busidle == 1'b1)
        begin
        if (enable == 1'b1)
          begin
          interpackcounter <= interpackcounter + 1'b1;
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : INTERPACKDLY_HOST_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      interpackdly_host <= 1'b0;
      end
    else
      begin
      if (hcfsm_st == HC_IDLE1 ||
          hcfsm_st == HCS_SET  ||
          hcfsm_st == HCS_EXT  ||
          hcfsm_st == HCS_OUT  ||
          hcfsm_st == HCR_PKT)
        begin
        interpackdly_host <= 1'b0;
        end
      else
        begin
        if (lsmode == 1'b1)
          begin
          if (interpackcounter == 7'b1010000)
            begin
            interpackdly_host <= 1'b1;
            end
          end
        else
          begin
          if (hcfsm_st == HC_IDLE)
            begin
            if (interpackcounter == 7'b0001001)
              begin
              interpackdly_host <= 1'b1;
              end
            end
          else
            begin
              if (interpackcounter == 7'b0000100)
                begin
                interpackdly_host <= 1'b1;
                end
            end
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : UNDERRIEN_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      underrien <= 1'b0;
      end
    else
      begin
      underrien <= hcunderrien[hcinepnr];
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCNAKIDIS_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcnakidis <= 1'b0;
      end
    else
      begin
      if (hcdir == 1'b0)
        begin
        hcnakidis <= hcnakidisout[hcoutepnr];
        end
      else
        begin
        hcnakidis <= hcnakidisin[hcinepnr];
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TIMEOUT_R_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      timeout_r <= 1'b0;
      end
    else
      begin
      timeout_r <= timeout;
      end
    end





  always @(hcfsm_st or txfall or sendsof or hcdoping or hcdosetup or
           hcdotrans or timeout or timeout_r or rcvfall or usberr or
           piderr or pid or hctogglerr or hceptype or rxactiveff or
           rxtxidle or interpackdly_host or hcdir or hsmode or underrien or
           wait_on_idle or
           hcdolpm or
           usb_overflow or not_usb_overflow)
    begin : HCFSM_NXT_COMB_PROC


    case (hcfsm_st)

        HC_IDLE1 :
            begin


            if (rxtxidle == 1'b1 && wait_on_idle == 1'b0)


              begin
              hcfsm_nxt = HC_IDLE;
              end
            else
              begin
              hcfsm_nxt = HC_IDLE1;
              end
            end

        HC_IDLE :
            begin
            if (sendsof == 1'b1)
              begin
              hcfsm_nxt = HCS_SOF;
              end
            else
              begin
              if (hcdotrans == 1'b1 &&
                  interpackdly_host == 1'b1)
                begin


                if (hcdoping == 1'b1 &&
                    hcdir == 1'b0)
                  begin
                  hcfsm_nxt = HCS_PING;
                  end
                else if (hcdosetup == 1'b1 &&
                         hceptype == EP_CTRL)
                  begin
                  hcfsm_nxt = HCS_SET;
                  end
                else if (hcdolpm == 1'b1 &&
                         hceptype == EP_CTRL)
                  begin
                  hcfsm_nxt = HCS_EXT;
                  end
                else
                  begin

                  if (hcdir == 1'b1)
                    begin
                    hcfsm_nxt = HCS_IN;
                    end
                  else
                    begin
                    hcfsm_nxt = HCS_OUT;
                    end
                  end
                end
              else
                begin
                hcfsm_nxt = HC_IDLE;
                end
              end
            end

        HCS_IN :
            begin


            if (txfall == 1'b1)
              begin
              hcfsm_nxt = HCR_PKT;
              end
            else
              begin
              hcfsm_nxt = HCS_IN;
              end
            end

        HCS_OUT :
            begin


            if (txfall == 1'b1)
              begin
              hcfsm_nxt = HCW_SPKT;
              end
            else
              begin
              hcfsm_nxt = HCS_OUT;
              end
            end

        HCS_EXT :
            begin


            if (txfall == 1'b1)
              begin
              hcfsm_nxt = HCW_SPKT;
              end
            else
              begin
              hcfsm_nxt = HCS_EXT;
              end
            end

        HCS_PING :
            begin


            if (txfall == 1'b1)
              begin
              hcfsm_nxt = HCR_PHSHK;
              end
            else
              begin
              hcfsm_nxt = HCS_PING;
              end
            end

        HCS_SET :
            begin


            if (txfall == 1'b1)
              begin
              hcfsm_nxt = HCW_SPKT;
              end
            else
              begin
              hcfsm_nxt = HCS_SET;
              end
            end

        HCS_SOF :
            begin


            if (txfall == 1'b1)
              begin
              hcfsm_nxt = HC_IDLE1;
              end
            else
              begin
              hcfsm_nxt = HCS_SOF;
              end
            end

        HCW_SPKT :
            begin


            if (interpackdly_host == 1'b1)
              begin
              if (hcdolpm == 1'b1)
                begin
                hcfsm_nxt = HCS_LPM;
                end
              else
                begin
                hcfsm_nxt = HCS_PKT;
                end
              end
            else
              begin
              hcfsm_nxt = HCW_SPKT;
              end
            end

        HCS_PKT :
            begin


            if (txfall == 1'b1)
              begin

              if (hceptype == EP_ISO)
                begin
                hcfsm_nxt = HCC_OUT;
                end
              else
                begin
                hcfsm_nxt = HCR_HSHK;
                end
              end
            else
              begin
              hcfsm_nxt = HCS_PKT;
              end
            end

        HCS_LPM :
            begin


            if (txfall == 1'b1)
              begin

              hcfsm_nxt = HCR_HSHK;
              end
            else
              begin
              hcfsm_nxt = HCS_LPM;
              end
            end

        HCW_SACK :
            begin
            if (interpackdly_host == 1'b1)
              begin


              if (hctogglerr == 1'b1)
                begin
                hcfsm_nxt = HCS_ACK;
                end
              else
                begin
                hcfsm_nxt = HCC_INACK;
                end
              end
            else
              begin
              hcfsm_nxt = HCW_SACK;
              end
            end

        HCS_ACK :
          begin


            if (txfall == 1'b1)
              begin
              hcfsm_nxt = HC_ERR;
              end
            else
              begin
              hcfsm_nxt = HCS_ACK;
              end
            end

        HCR_PKT :
            begin
            if ((timeout == 1'b1 && timeout_r == 1'b0) ||
                 usb_overflow == 1'b1)
              begin

              hcfsm_nxt = HC_ERR;
              end
            else if (rcvfall == 1'b1)
              begin
              if ((usberr == 1'b1) ||
                  (piderr == 1'b1) ||
                 ~(pid == PID_DATA0 ||
                   pid == PID_DATA1 ||
                   pid == PID_DATA2 ||
                   pid == PID_MDATA))
                begin

                if (pid == PID_NAK && piderr == 1'b0)
                  begin
                  hcfsm_nxt = HC_RNAK;
                  end
                else
                  begin
                  hcfsm_nxt = HC_ERR;
                  end
                end
              else if (hceptype == EP_ISO &&
                      (hsmode == 1'b1 ||
                       pid == PID_DATA0 ||
                       pid == PID_DATA1))
                begin

                hcfsm_nxt = HCC_IN;
                end
              else if (pid == PID_DATA0 ||
                       pid == PID_DATA1)
                begin
                  hcfsm_nxt = HCW_SACK;
                end
              else
                begin
                hcfsm_nxt = HC_ERR;
                end
              end
            else
              begin
              hcfsm_nxt = HCR_PKT;
              end
            end

        HCR_HSHK :
            begin
            if (timeout == 1'b1 && timeout_r == 1'b0)
              begin
              hcfsm_nxt = HC_ERR;
              end
            else if (rcvfall == 1'b1)
              begin


              if (piderr == 1'b0 &&
                   (pid == PID_ACK ||
                     (pid == PID_NYET &&
                      hsmode == 1'b1 && hcdolpm == 1'b0)
                   )
                 )
                begin
                hcfsm_nxt = HCC_OUT;
                end
              else if (piderr == 1'b0 &&
                       pid == PID_NYET &&
                       hcdolpm == 1'b1)
                begin
                hcfsm_nxt = HC_ERR;
                end
              else if (piderr == 1'b0 &&
                       pid == PID_NAK &&
                       hcdolpm == 1'b0)
                begin
                hcfsm_nxt = HC_RNAK;
                end
              else
                begin
                hcfsm_nxt = HC_ERR;
                end
              end
            else
              begin
              hcfsm_nxt = HCR_HSHK;
              end
            end

        HCR_PHSHK :
            begin
            if (timeout == 1'b1 && timeout_r == 1'b0)
              begin
              hcfsm_nxt = HC_ERR;
              end
            else if (rcvfall == 1'b1)
              begin
              if (piderr == 1'b0)
                begin


                if (pid == PID_ACK)
                  begin
                  hcfsm_nxt = HCC_DOPING;
                  end
                else if (pid == PID_NAK)
                  begin
                  hcfsm_nxt = HC_DOPING;
                  end
                else
                  begin
                  hcfsm_nxt = HC_ERR;
                  end
                end
              else
                begin
                hcfsm_nxt = HC_ERR;
                end
              end
            else
              begin
              hcfsm_nxt = HCR_PHSHK;
              end
            end

        HCC_IN :
            begin


            if (underrien == 1'b1 &&
                not_usb_overflow == 1'b1)
              begin

              hcfsm_nxt = HC_ERR;
              end
            else
              begin
              hcfsm_nxt = HC_IDLE1;
              end
            end

        HCC_OUT :
            begin


            hcfsm_nxt = HC_IDLE1;
            end

        HCC_INACK :
            begin


            if (underrien == 1'b1 &&
                not_usb_overflow == 1'b1)
              begin
              hcfsm_nxt = HC_ERR;
              end
            else
              begin
              hcfsm_nxt = HC_IDLE1;
              end
            end

        HC_DOPING :
            begin


            hcfsm_nxt = HC_IDLE1;
            end

        HCC_DOPING :
            begin


            hcfsm_nxt = HC_IDLE1;
            end

        HC_RNAK :
            begin


            hcfsm_nxt = HC_IDLE1;
            end

        default :
            begin


            if (rxactiveff == 1'b0)
              begin
              hcfsm_nxt = HC_IDLE1;
              end
            else
              begin
              hcfsm_nxt = HC_ERR;
              end
            end
    endcase
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCFSM_ST_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcfsm_st <= HC_IDLE;
      end
    else
      begin
      if (rxtxidle == 1'b1 && (lpmstate == 1'b1 ||
                               lpmstate_besl == 1'b1))
        begin
        hcfsm_st <= HC_IDLE1;
        end
      else if (hclocsof == 1'b1 &&
               usbreset == 1'b0 &&
               testmode == 1'b0)
        begin

        hcfsm_st <= hcfsm_nxt;
        end
      else
        begin
        hcfsm_st <= HC_IDLE;
        end
      end
    end










  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCSLEEP_ACK_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcsleep_ack   <= 1'b0;
      hcsleep_ack_r <= 1'b0;
      end
    else
      begin
      hcsleep_ack <= hcsleep_ack_r ;

      if (hcdolpm == 1'b1 &&
          hcfsm_st == HCC_OUT &&
          tendp == 4'b0000)
        begin
        hcsleep_ack_r <= 1'b1 ;
        end
      else
        begin
        hcsleep_ack_r <= 1'b0 ;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCERRTYPE_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcerrtype <= 3'b000;
      hcerrinc  <= 1'b0;
      hcerrset  <= 1'b0;
      end
    else
      begin
      if (hcfsm_nxt == HC_ERR)
        begin
        case (hcfsm_st)
            HCS_ACK :
                begin
                hcerrtype <= 3'b010;
                hcerrinc  <= 1'b1;
                end
            HCR_PKT :
                begin
                if ((timeout == 1'b1 && timeout_r == 1'b0) ||
                    usb_overflow == 1'b1)
                  begin


                  if (timeout == 1'b1)
                    begin
                    hcerrtype <= 3'b100;
                    hcerrinc  <= 1'b1;
                    end
                  else
                    begin
                    hcerrtype <= 3'b110;
                    hcerrset  <= 1'b1;
                    end
                  end
                else
                  begin

                  if (pid == PID_STALL && piderr == 1'b0)
                    begin
                    hcerrtype <= 3'b011;
                    hcerrset  <= 1'b1;
                    end
                  else if (piderr == 1'b1)
                    begin
                    hcerrtype <= 3'b101;
                    hcerrinc  <= 1'b1;
                    end
                  else if (usberr == 1'b1)
                    begin
                    hcerrtype <= 3'b001;
                    hcerrinc  <= 1'b1;
                    end
                  else
                    begin
                    hcerrtype <= 3'b101;
                    hcerrinc  <= 1'b1;
                    end
                  end
                end
            HCR_HSHK :
                begin
                if (timeout == 1'b1 && timeout_r == 1'b0)
                  begin
                  hcerrtype <= 3'b100;
                  hcerrinc  <= 1'b1;
                  end
                else
                  begin

                  if (piderr == 1'b1)
                    begin
                    hcerrtype <= 3'b101;
                    hcerrinc  <= 1'b1;
                    end
                  else if (pid == PID_STALL)
                    begin
                    hcerrtype <= 3'b011;
                    hcerrset  <= 1'b1;
                    end
                  else if (pid == PID_NYET && hcdolpm == 1'b1)
                    begin
                    hcerrtype <= 3'b000;
                    hcerrset  <= 1'b1;
                    end
                  else
                    begin
                    hcerrtype <= 3'b101;
                    hcerrinc  <= 1'b1;
                    end
                  end
                end
            HCR_PHSHK :
                begin
                if (timeout == 1'b1 && timeout_r == 1'b0)
                  begin
                  hcerrtype <= 3'b100;
                  hcerrinc  <= 1'b1;
                  end
                else
                  begin

                  if (piderr == 1'b1)
                    begin
                    hcerrtype <= 3'b101;
                    hcerrinc  <= 1'b1;
                    end
                  else if (pid == PID_STALL)
                    begin
                    hcerrtype <= 3'b011;
                    hcerrset  <= 1'b1;
                    end
                  else
                    begin

                    hcerrtype <= 3'b101;
                    hcerrinc  <= 1'b1;
                    end
                  end
                end
            HCC_INACK,
            HCC_IN :
                begin

                hcerrtype <= 3'b111;
                hcerrset  <= 1'b1;
                end
            default :
                begin
                hcerrinc <= 1'b0;
                hcerrset <= 1'b0;
                end
        endcase
        end
      else
        begin
        if (hcfsm_st == HC_RNAK &&
            hceptype == EP_INT && hcnakidis == 1'b0)
          begin
          hcerrinc  <= 1'b0;
          hcerrset  <= 1'b1;
          hcerrtype <= 3'b000;
          end
        else
          begin
          hcerrinc <= 1'b0;
          hcerrset <= 1'b0;
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCERRCLR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcerrclr <= 1'b0;
      end
    else
      begin
      if (((hcfsm_st == HCC_IN || hcfsm_st == HCC_INACK) &&
           (underrien == 1'b0 || usb_bufffull == 1'b1)) ||
            hcfsm_st == HCC_OUT ||
            hcfsm_st == HCC_DOPING ||
            hcfsm_st == HC_DOPING ||
           (hcfsm_st == HC_RNAK && (hceptype != EP_INT || hcnakidis == 1'b1)))
        begin
        hcerrclr <= 1'b1;
        end
      else
        begin
        hcerrclr <= 1'b0;
        end
      end
    end







  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCEPTOGGLEBITS_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hctoggle    <= 2'b00;
      hcisotoggle <= 2'b00;
      end
    else
      begin
      if (hcdir == 1'b1)
        begin

        hctoggle    <= hctogglein_v;
        hcisotoggle <= 2'b00;
        end
      else
        begin

        hctoggle    <= hctoggleout_v;
        hcisotoggle <= isotogglein_v;
        end
      end
    end





  assign hctogglerr = ((hctoggle[0] == 1'b1 && pid[3] == 1'b0) ||
                       (hctoggle[0] == 1'b0 && pid[3] == 1'b1)) ? 1'b1 :
                                                                  1'b0 ;





  assign hcdoisoout_x = {hcdoisoout, 1'b1};



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : BUSYIN_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      busyin_r <= {16{1'b0}};
      end
    else
      begin
      busyin_r <= busyin;
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDOOUTVECT_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcdooutvect <= {16{1'b0}};
      end
    else
      begin
      for(i = 15; i >= 0; i = i - 1)
        begin
        if (hcfsm_st == HC_IDLE1 ||
            enter_hm == 1'b1)
          begin
          hcdooutvect[i] <= 1'b0;
          end
        else if (hcfsm_st == HC_IDLE &&
                 ~(busyin[i] == 1'b1 &&
                   busyin_r[i] == 1'b1 &&
                   hcoutnak[i] == 1'b0 &&
                   hcdoisoout_x[i] == 1'b1 &&
                   htscmpout[i] == 1'b1 &&
                   hcepwaitout[i] == 1'b0 &&
                   hcepsuspendout[i] == 1'b0))
          begin





          hcdooutvect[i] <= 1'b0;
          end
        else if (busyin[i] == 1'b1 &&
                 busyin_r[i] == 1'b1 &&
                 hcoutnak[i] == 1'b0 &&
                 hcdoisoout_x[i] == 1'b1 &&
                 htscmpout[i] == 1'b1 &&
                 hcepwaitout[i] == 1'b0 &&
                 hcepsuspendout[i] == 1'b0)
          begin





          hcdooutvect[i] <= 1'b1;
          end
        end
      end
    end











  always @(eptypein or hcdooutvect)
    begin : HTS_PRIORITY_OUT_S1_COMB_PROC
      reg [15:0] hceptypeout_v;
      integer    i;



    eptypeout_s1 = {8{1'b0}};
    hcdoout_s1   = {8{1'b0}};
    selhcout_s1  = {8{1'b0}};

    hceptypeout_v[0] = 1'b0;
    for(i = 15; i >= 1; i = i - 1)
      begin
      hceptypeout_v[i] = eptypein[i*2];
      end

    for(i = 7; i >= 0; i = i - 1)
      begin
      eptypeout_s1[i] = (hceptypeout_v[(2*i)+1] & hcdooutvect[(2*i)+1]) |
                        (hceptypeout_v[2*i] & hcdooutvect[2*i]);
      hcdoout_s1[i]   = hcdooutvect[(2*i)+1] | hcdooutvect[2*i];
      selhcout_s1[i]  = (~hcdooutvect[2*i]) |
                       ((~hceptypeout_v[2*i]) & (hceptypeout_v[(2*i)+1]) &
                         (hcdooutvect[(2*i)+1]));
      end
    end



  always @(eptypeout_s1 or hcdoout_s1)
    begin : HTS_PRIORITY_OUT_S2_COMB_PROC
      integer i;

    eptypeout_s2 = {4{1'b0}};
    hcdoout_s2   = {4{1'b0}};
    selhcout_s2  = {4{1'b0}};

    for(i = 3; i >= 0; i = i - 1)
      begin
      eptypeout_s2[i] = (eptypeout_s1[(2*i)+1] & hcdoout_s1[(2*i)+1]) |
                        (eptypeout_s1[2*i] & hcdoout_s1[2*i]);
      hcdoout_s2[i]   = hcdoout_s1[(2*i)+1] | hcdoout_s1[2*i];
      selhcout_s2[i]  = (~(hcdoout_s1[2*i])) |
                        ((~eptypeout_s1[2*i]) & (eptypeout_s1[(2*i)+1]) &
                          (hcdoout_s1[(2*i)+1]));
      end
    end



  always @(eptypeout_s2 or hcdoout_s2)
    begin : HTS_PRIORITY_OUT_S3_COMB_PROC
      integer i;

    eptypeout_s3 = 2'b00;
    hcdoout_s3 = 2'b00;
    selhcout_s3 = 2'b00;

    for(i = 1; i >= 0; i = i - 1)
      begin
      eptypeout_s3[i] = (eptypeout_s2[(2*i)+1] & hcdoout_s2[(2*i)+1]) |
                        (eptypeout_s2[2*i] & hcdoout_s2[2*i]);
      hcdoout_s3[i]   = hcdoout_s2[(2*i)+1] | hcdoout_s2[2*i];
      selhcout_s3[i]  = (~(hcdoout_s2[2*i])) |
                        ((~eptypeout_s2[2*i]) & (eptypeout_s2[(2*i)+1]) &
                        (hcdoout_s2[(2*i)+1]));
      end
    end



  always @(eptypeout_s3 or hcdoout_s3)
    begin : HTS_PRIORITY_OUT_COMB_PROC

    hc_outeptype0 = (eptypeout_s3[1] & hcdoout_s3[1]) |
                    (eptypeout_s3[0] & hcdoout_s3[0]);

    hc_doout = hcdoout_s3[1] | hcdoout_s3[0];

    hcoutepnr_s3 =   (~hcdoout_s3[0]) |
                     (~eptypeout_s3[0] &
                       eptypeout_s3[1] &
                       hcdoout_s3[1]);
    end



  always @(hcoutepnr_s3 or selhcout_s3)
    begin : HTS_PRTY_OUT_HCOUTEP2_PROC



    if (hcoutepnr_s3 == 1'b1)
      begin
      hcoutepnr_s2 = selhcout_s3[1];
      end
    else
      begin
      hcoutepnr_s2 = selhcout_s3[0];
      end
    end



  always @(hcoutepnr_s3 or hcoutepnr_s2 or selhcout_s2)
    begin : HTS_PRTY_OUT_HCOUTEP1_PROC
      reg [3:2] hcoutepnr_v;


    hcoutepnr_v = {hcoutepnr_s3, hcoutepnr_s2};

    case (hcoutepnr_v)
        2'b11 :
            begin
            hcoutepnr_s1 = selhcout_s2[3];
            end
        2'b10 :
            begin
            hcoutepnr_s1 = selhcout_s2[2];
            end
        2'b01 :
            begin
            hcoutepnr_s1 = selhcout_s2[1];
            end
        default :
            begin
            hcoutepnr_s1 = selhcout_s2[0];
            end
    endcase
    end



  always @(hcoutepnr_s3 or hcoutepnr_s2 or hcoutepnr_s1 or selhcout_s1)
    begin : HTS_PRTY_OUT_HCOUTEP0_PROC
      reg [3:1] hcoutepnr_v;


    hcoutepnr_v = {hcoutepnr_s3, hcoutepnr_s2, hcoutepnr_s1};

    case (hcoutepnr_v)
        3'b111 :
            begin
            hcoutepnr_s0 = selhcout_s1[7];
            end
        3'b110 :
            begin
            hcoutepnr_s0 = selhcout_s1[6];
            end
        3'b101 :
            begin
            hcoutepnr_s0 = selhcout_s1[5];
            end
        3'b100 :
            begin
            hcoutepnr_s0 = selhcout_s1[4];
            end
        3'b011 :
            begin
            hcoutepnr_s0 = selhcout_s1[3];
            end
        3'b010 :
            begin
            hcoutepnr_s0 = selhcout_s1[2];
            end
        3'b001 :
            begin
            hcoutepnr_s0 = selhcout_s1[1];
            end
        default :
            begin
            hcoutepnr_s0 = selhcout_s1[0];
            end
    endcase
    end





  assign hc_outepnr = {hcoutepnr_s3, hcoutepnr_s2,
                       hcoutepnr_s1, hcoutepnr_s0};





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCOUTEPNR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcoutepnr <= 4'h0;
      end
    else
      begin
      if (hcdoout == 1'b0 &&
          hcfsm_nxt == HC_IDLE)
        begin
        hcoutepnr <= hc_outepnr;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCOUTEPTYPE0_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcouteptype0 <= 1'b0;
      end
    else
      begin
      if (hcdoout == 1'b0 && hcfsm_nxt == HC_IDLE)
        begin
        hcouteptype0 <= hc_outeptype0;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDOOUT_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcdoout <= 1'b0;
      end
    else
      begin
      if (hcfsm_st == HC_IDLE1 ||
          enter_hm == 1'b1 ||
          downstren == 1'b0)
        begin
        hcdoout <= 1'b0;
        end
      else if (hcfsm_st == HC_IDLE)
        begin
        hcdoout <= hc_doout;
        end
      end
    end





  assign hcdoisoin_x = {hcdoisoin, epvalout[0]};



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDOINVECT_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcdoinvect <= {16{1'b0}};
      end
    else
      begin
      for(i = 15; i >= 0; i = i - 1)
        begin
        if (hcfsm_st == HC_IDLE1 ||
            enter_hm == 1'b1)
          begin
          hcdoinvect[i] <= 1'b0;
          end
        else if (hcfsm_st == HC_IDLE &&
                 ~(busyout[i] == 1'b1 &&
                   hcinnak[i] == 1'b0 &&
                   hcdoisoin_x[i] == 1'b1 &&
                   htscmpin[i] == 1'b1 &&
                   hcepwaitin[i] == 1'b0 &&
                   hcepsuspendin[i] == 1'b0))
          begin





          hcdoinvect[i] <= 1'b0;
          end
        else if (busyout[i] == 1'b1 &&
                 hcinnak[i] == 1'b0 &&
                 hcdoisoin_x[i] == 1'b1 &&
                 htscmpin[i] == 1'b1 &&
                 hcepwaitin[i] == 1'b0 &&
                 hcepsuspendin[i] == 1'b0)
          begin





          hcdoinvect[i] <= 1'b1;
          end
        end
      end
    end











  always @(eptypeout or hcdoinvect)
    begin : HTS_PRIORITY_IN_S1_COMB_PROC
      reg [15:0] hceptypein_v;
      integer    i;



    eptypein_s1 = {8{1'b0}};
    hcdoin_s1   = {8{1'b0}};
    selhcin_s1  = {8{1'b0}};

    hceptypein_v[0] = 1'b0;
    for(i = 15; i >= 1; i = i - 1)
      begin
      hceptypein_v[i] = eptypeout[i*2];
      end

    for(i = 7; i >= 0; i = i - 1)
      begin
      eptypein_s1[i] = (hceptypein_v[(2*i)+1] & hcdoinvect[(2*i)+1]) |
                       (hceptypein_v[2*i] & hcdoinvect[2*i]);
      hcdoin_s1[i]   = hcdoinvect[(2*i)+1] | hcdoinvect[2*i];
      selhcin_s1[i]  = (~hcdoinvect[2*i]) |
                       ((~hceptypein_v[2*i]) & (hceptypein_v[(2*i)+1]) &
                       (hcdoinvect[(2*i)+1]));
      end
    end



  always @(eptypein_s1 or hcdoin_s1)
    begin : HTS_PRIORITY_IN_S2_COMB_PROC
      integer i;


    eptypein_s2 = {4{1'b0}};
    hcdoin_s2   = {4{1'b0}};
    selhcin_s2  = {4{1'b0}};

    for(i = 3; i >= 0; i = i - 1)
      begin
      eptypein_s2[i] = (eptypein_s1[(2*i)+1] & hcdoin_s1[(2*i)+1]) |
                       (eptypein_s1[2*i] & hcdoin_s1[2*i]);
      hcdoin_s2[i]   = hcdoin_s1[(2*i)+1] | hcdoin_s1[2*i];
      selhcin_s2[i]  = (~(hcdoin_s1[2*i])) |
                       ((~eptypein_s1[2*i]) & (eptypein_s1[(2*i)+1]) &
                       (hcdoin_s1[(2*i)+1]));
      end
    end



  always @(eptypein_s2 or hcdoin_s2)
    begin : HTS_PRIORITY_IN_S3_COMB_PROC
      integer i;


    eptypein_s3 = 2'b00;
    hcdoin_s3   = 2'b00;
    selhcin_s3  = 2'b00;

    for(i = 1; i >= 0; i = i - 1)
      begin
      eptypein_s3[i] = (eptypein_s2[(2*i)+1] & hcdoin_s2[(2*i)+1]) |
                       (eptypein_s2[2*i] & hcdoin_s2[2*i]);
      hcdoin_s3[i]   = hcdoin_s2[(2*i)+1] | hcdoin_s2[2*i];
      selhcin_s3[i]  = (~(hcdoin_s2[2*i])) |
                       ((~eptypein_s2[2*i]) & (eptypein_s2[(2*i)+1]) &
                       (hcdoin_s2[(2*i)+1]));
      end
    end



  always @(eptypein_s3 or hcdoin_s3)
    begin : HTS_PRIORITY_IN_HCINEPNR3_COMB_PROC



    hc_ineptype0 = (eptypein_s3[1] & hcdoin_s3[1]) |
                   (eptypein_s3[0] & hcdoin_s3[0]);

    hc_doin = hcdoin_s3[1] | hcdoin_s3[0];

    hcinepnr_s3 =   (~hcdoin_s3[0]) |
                    (~eptypein_s3[0] &
                      eptypein_s3[1] &
                      hcdoin_s3[1]);
    end



  always @(hcinepnr_s3 or selhcin_s3)
    begin : HTS_PRIORITY_IN_HCINEPNR2_COMB_PROC




    if (hcinepnr_s3 == 1'b1)
      begin
      hcinepnr_s2 = selhcin_s3[1];
      end
    else
      begin
      hcinepnr_s2 = selhcin_s3[0];
      end
    end



  always @(hcinepnr_s3 or hcinepnr_s2 or selhcin_s2)
    begin : HTS_PRIORITY_IN_HCINEPNR1_COMB_PROC
      reg [3:2] hcinepnr_v;



    hcinepnr_v = {hcinepnr_s3, hcinepnr_s2};

    case (hcinepnr_v)
        2'b11 :
            begin
            hcinepnr_s1 = selhcin_s2[3];
            end
        2'b10 :
            begin
            hcinepnr_s1 = selhcin_s2[2];
            end
        2'b01 :
            begin
            hcinepnr_s1 = selhcin_s2[1];
            end
        default :
            begin
            hcinepnr_s1 = selhcin_s2[0];
            end
    endcase
    end



  always @(hcinepnr_s3 or hcinepnr_s2 or hcinepnr_s1 or selhcin_s1)
    begin : HTS_PRIORITY_IN_HCINEPNR0_COMB_PROC
      reg [3:1] hcinepnr_v;



    hcinepnr_v = {hcinepnr_s3, hcinepnr_s2, hcinepnr_s1};

    case (hcinepnr_v)
        3'b111 :
            begin
            hcinepnr_s0 = selhcin_s1[7];
            end
        3'b110 :
            begin
            hcinepnr_s0 = selhcin_s1[6];
            end
        3'b101 :
            begin
            hcinepnr_s0 = selhcin_s1[5];
            end
        3'b100 :
            begin
            hcinepnr_s0 = selhcin_s1[4];
            end
        3'b011 :
            begin
            hcinepnr_s0 = selhcin_s1[3];
            end
        3'b010 :
            begin
            hcinepnr_s0 = selhcin_s1[2];
            end
        3'b001 :
            begin
            hcinepnr_s0 = selhcin_s1[1];
            end
        default :
            begin
            hcinepnr_s0 = selhcin_s1[0];
            end
    endcase
    end





  assign hc_inepnr = {hcinepnr_s3, hcinepnr_s2,
                      hcinepnr_s1, hcinepnr_s0};





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCINEPNR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcinepnr <= 4'h0;
      end
    else
      begin
      if (hcdoin == 1'b0 &&
          hcfsm_nxt == HC_IDLE)
        begin
        hcinepnr <= hc_inepnr;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCINEPTYPE0_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcineptype0 <= 1'b0;
      end
    else
      begin
      if (hcdoin == 1'b0 && hcfsm_nxt == HC_IDLE)
        begin
        hcineptype0 <= hc_ineptype0;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDOIN_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcdoin <= 1'b0;
      end
    else
      begin
      if (hcfsm_st == HC_IDLE1 ||
          enter_hm == 1'b1 ||
          downstren == 1'b0)
        begin
        hcdoin <= 1'b0;
        end
      else if (hcfsm_st == HC_IDLE)
        begin
        hcdoin <= hc_doin;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDOPING_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcdoping <= 1'b0;
      end
    else
      begin
      hcdoping <= hcdopingout[hcoutepnr];
      end
    end





  always @(eptypein or eptypeout)
    begin : HCEPTYPE_COMB_PROC
      integer i;

    hceptypeout_s[0] = 1'b0;
    hceptypein_s[0]  = 1'b0;

    for(i = 15; i >= 1; i = i - 1)
      begin
      hceptypeout_s[i] = eptypein[i*2+1];
      hceptypein_s[i]  = eptypeout[i*2+1];
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCEPTYPE_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hceptype <= 2'b00;
      end
    else
      begin
      if (hcdoin == 1'b0 || (hcineptype0 == 1'b0 &&
                             hcouteptype0 == 1'b1 &&
                             hcdoout == 1'b1))
        begin





        hceptype[1] <= hceptypeout_s[hcoutepnr];
        hceptype[0] <= hcouteptype0;
        end
      else
        begin

        hceptype[1] <= hceptypein_s[hcinepnr];
        hceptype[0] <= hcineptype0;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDIR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcdir <= 1'b0;
      end
    else
      begin
      if (hcfsm_nxt == HC_IDLE)
        begin
        if (hcdoin == 1'b0 || (hcineptype0 == 1'b0 &&
                               hcouteptype0 == 1'b1 &&
                               hcdoout == 1'b1))
          begin

          hcdir <= 1'b0;
          end
        else
          begin

          hcdir <= 1'b1;
          end
        end
      end
    end





  assign hcepdir = hcdir;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDOTRANS_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcdotrans <= 1'b0;
      end
    else
      begin
       if (downstren == 1'b0)
         begin
         hcdotrans <= 1'b0;
         end
       else
         begin
         if (hcfsm_st == HC_IDLE1 ||
             enter_hm == 1'b1)
           begin
           hcdotrans <= 1'b0;
           end
         else if (hcfsm_nxt == HC_IDLE)
           begin
           hcdotrans <= hcdoout | hcdoin;
           end
         end
       end
    end





  assign hcepnr = (hcdir == 1'b0) ? hcoutepnr :
                                    hcinepnr;











  always @(hcframecounter or hsmode or lsmode)
    begin : HCFRAMECOUNTER_COMB_PROC

    case ({hsmode, lsmode})
        2'b10 :
            begin

            if (hcframecounter[11] == 1'b1 ||
                hcframecounter[10] == 1'b1)
              begin
              hcframecounter_v = 12'h7FF;
              end
            else
              begin
              hcframecounter_v = {hcframecounter[10:0], 1'b0};
              end
            end
        2'b01 :
            begin

            hcframecounter_v = ({3'b000, hcframecounter[11:3]});
            end
        default :
            begin

            hcframecounter_v = hcframecounter;
            end
    endcase
    end




  assign hcfrmremainhsth1 = (hsmode == 1'b1) ? (hcframecounter_v >= 12'h1B4) :
                                                1'b1 ;




  assign hcfrmremainhsth2 = (hsmode == 1'b1) ? (hcframecounter_v >= 12'h134) :
                                                1'b1 ;




  assign hcfrmremainhsth3 = (hsmode == 1'b1) ? (hcframecounter_v >= 12'h0B4) :
                                                1'b1 ;




  assign hcfrmremainfsth1 = (hsmode == 1'b1) ? 1'b1 :
                            (lsmode == 1'b1) ? 1'b1 :
                                               (hcframecounter_v >= 12'h140) ;




  assign hcfrmremainfsth2 = (hsmode == 1'b1) ? 1'b1 :
                            (lsmode == 1'b1) ? 1'b1 :
                                               (hcframecounter_v >= 12'h0C0) ;




  assign hcfrmremainfsth3 = (hsmode == 1'b1) ? 1'b1 :
                            (lsmode == 1'b1) ? (hcframecounter_v >= 12'h01B) :
                                               (hcframecounter_v >= 12'h040) ;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCFRMREMAINCMP_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcfrmremaincmp <= {11{1'b0}};
      end
    else
      begin
      case ({hsmode, lsmode})
          2'b10 :
              begin

              if (hcfrmremainhsth3 == 1'b0)
                begin
                hcfrmremaincmp <= {11{1'b0}};
                end
              else if (hcfrmremainhsth2 == 1'b0)
                begin
                hcfrmremaincmp <= hcframecounter_v[10:0] - 11'b00010110100;
                end
              else if (hcfrmremainhsth1 == 1'b0)
                begin
                hcfrmremaincmp <= 11'b00010000000;
                end
              else
                begin
                hcfrmremaincmp <= hcframecounter_v[10:0] - 11'b00100110100;
                end
              end
          2'b01 :
              begin

              if (hcfrmremainfsth3 == 1'b0)
                begin
                hcfrmremaincmp <= {11{1'b0}};
                end
              else
                begin
                hcfrmremaincmp <= hcframecounter_v[10:0] - 10'b0000011011;
                end
              end
          default :
              begin

              if (hcfrmremainfsth3 == 1'b0)
                begin
                hcfrmremaincmp <= {11{1'b0}};
                end
              else if (hcfrmremainfsth2 == 1'b0)
                begin
                hcfrmremaincmp <= hcframecounter_v[10:0] - 10'b0001000000;
                end
              else if (hcfrmremainfsth1 == 1'b0)
                begin
                hcfrmremaincmp <= 11'b00010000000;
                end
              else
                begin
                hcfrmremaincmp <= hcframecounter_v[10:0] - 10'b0011000000;
                end
              end
      endcase
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HTSDISABLE_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      htsdisable <= 1'b0;
      end
    else
      begin
      if (hsmode == 1'b1)
        begin
        htsdisable <= ~hcfrmremainhsth3;
        end
      else
        begin

        htsdisable <= ~hcfrmremainfsth3;
        end
      end
    end





  always @(hcfrmremaincmp or hcoutmaxpckusb)
    begin : HTSCMPOUT_COMB_PROC
      integer    i;
      integer    j;
      reg [10:0] hcoutmaxpckusb_v;





    for(i = 15; i >= 0; i = i - 1)
      begin
      for(j = 10; j >= 0; j = j - 1)
        begin
        hcoutmaxpckusb_v[j] = hcoutmaxpckusb[i*11 + j];
        end
      if (hcfrmremaincmp >= hcoutmaxpckusb_v)
        begin
        htscmpout_v[i] = 1'b1;
        end
      else
        begin
        htscmpout_v[i] = 1'b0;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HTSCMPOUT_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      htscmpout <= {16{1'b0}};
      end
    else
      begin
      if (htsdisable == 1'b1)
        begin
        htscmpout <= {16{1'b0}};
        end
      else
        begin
        if (hcfsm_st == HC_IDLE1 ||
            hcfsm_st == HC_IDLE)
          begin
          htscmpout <= htscmpout_v;
          end
        end
      end
    end





  always @(hcfrmremaincmp or hcinmaxpckusb)
    begin : HTSCMPIN_COMB_PROC
      integer    i;
      integer    j;
      reg [10:0] hcinmaxpckusb_v;





    for(i = 15; i >= 0; i = i - 1)
      begin
      for(j = 10; j >= 0; j = j - 1)
        begin
        hcinmaxpckusb_v[j] = hcinmaxpckusb[i*11 + j];
        end
      if (hcfrmremaincmp >= hcinmaxpckusb_v)
        begin
        htscmpin_v[i] = 1'b1;
        end
      else
        begin
        htscmpin_v[i] = 1'b0;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HTSCMPIN_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      htscmpin <= 16'h0000;
      end
    else
      begin
      if (htsdisable == 1'b1)
        begin
        htscmpin <= 16'h0000;
        end
      else
        begin
        if (hcfsm_st == HC_IDLE1 ||
            hcfsm_st == HC_IDLE)
          begin
          htscmpin <= htscmpin_v;
          end
        end
      end
    end



  always @(hcdoinvect or hcdooutvect)
    begin : HCEPWAITCLR_COMB_PROC
      integer i;



    for(i = 15; i >= 0; i = i - 1)
      begin
      transreq_v[i] = hcdoinvect[i] | hcdooutvect[i];
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCEPWAITCLR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcepwaitclr <= 1'b0;
      end
    else
      begin
      if (hcfsm_st == HC_IDLE &&
          interpackdly_host == 1'b1 &&
          transreq_v == 16'h0000)
        begin

        hcepwaitclr <= 1'b1;
        end
      else
        begin
        hcepwaitclr <= 1'b0;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCEPWAITSET_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcepwaitset <= 1'b0;
      end
    else
      begin
      if (rcvfall == 1'b1 &&
          pid == PID_NAK)
        begin
        hcepwaitset <= 1'b1;
        end
      else
        begin
        hcepwaitset <= 1'b0;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDEVDOPINGCLR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcdevdopingclr <= 1'b0;
      end
    else
      begin
      if (hcfsm_st == HCC_DOPING ||
         (hcfsm_st == HCC_OUT && pid == PID_ACK))
        begin
        hcdevdopingclr <= 1'b1;
        end
      else
        begin
        hcdevdopingclr <= 1'b0;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDEVDOPINGSET_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcdevdopingset <= 1'b0;
      end
    else
      begin
      if (hcfsm_st == HCS_PKT ||
          hcfsm_st == HCS_PING)
        begin
        hcdevdopingset <= 1'b1;
        end
      else
        begin
        hcdevdopingset <= 1'b0;
        end
      end
    end










  assign lpm_sleep_req = (lpm_hold == 1'b1 &&
                          lpm_send_nyet == 1'b0) ? 1'b1 :
                                                   1'b0;






  assign lpm_send_stall = (lpm_token[3:0] == 4'b0001) ? 1'b0 :
                                                        1'b1;




  assign lpm_send_nyet = lpm_nyet;






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LPM_TOKEN_84_FF_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      lpm_token_84 <= {6{1'b0}};
      end
    else
      begin
      if (lpm_hold == 1'b1 && lpm_usbirq == 1'b0)
        begin
        lpm_token_84 <= {lpm_send_nyet,
                         lpm_token[8:4]};
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LPM_COUNTER_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      lpm_counter <= {9{1'b0}};
      end
    else
      begin
      if (lpm_count == 1'b1 && lpm_ack_nyet_hshk == 1'b0)
        begin
        if (enable == 1'b1)
          begin
          lpm_counter <= lpm_counter + 1'b1;
          end
        end
      else
        begin
        lpm_counter <= {9{1'b0}};
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LPM_COUNT_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      lpm_count <= 1'b0;
      end
    else
      begin
      if (ttokenretry == 1'b1)
        begin
        lpm_count <= 1'b0;
        end
      else if (lpm_ack_nyet_hshk == 1'b1 && lpm_count == 1'b0)
        begin
        lpm_count <= 1'b1;
        end
      end
    end






  assign ttokenretry = lpm_counter[8] & lpm_counter[4];




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LPMIRQ_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      lpmirq <= 1'b0;
      end
    else
      begin
      if (ttokenretry == 1'b1 || lpmirq_retry == 1'b1)
        begin
        lpmirq <= 1'b1;
        end
      else
        begin
        lpmirq <= 1'b0;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LPMHOLD_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      lpm_hold <= 1'b0;
      end
    else
      begin
      if (ttokenretry == 1'b1)
        begin
        lpm_hold <= 1'b1;
        end
      else
        begin
        lpm_hold <= 1'b0;
        end
      end
    end






  assign lpm_ack_nyet_hshk = (pid == SUBPID_LPM &&
                             (send_pid == PID_ACK || send_pid == PID_NYET) &&
                              send_hshk == 1'b1
                             ) ? 1'b1 :
                                 1'b0;












  assign sof_rcv_fall = (devfsm_st == R_TOK &&
                         rcvfall == 1'b1 &&
                         piderr == 1'b0 &&
                         usberr == 1'b0 &&
                         pid == PID_SOF) ? 1'b1 :
                                           1'b0;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : CURFRAME_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      curframe      <= {15{1'b0}};
      curframestart <= 1'b0;
      end
    else
      begin
      if (upstren == 1'b0 || sof_rcv_disable == 1'b1)
        begin
        curframe      <= {15{1'b0}};
        curframestart <= 1'b0;
        end
      else
        begin
        if (usbreset == 1'b1 ||
            suspendm == 1'b1 ||
            sleepm   == 1'b1)
          begin
          curframe      <= {15{1'b0}};
          curframestart <= 1'b0;
          end
        else if (sof_rcv_fall == 1'b1)
          begin
          curframe      <= {15{1'b0}};
          curframestart <= 1'b1;
          end
        else if (curframestart == 1'b1)
          begin
          if (enable == 1'b1)
            begin
            if (hsmode == 1'b1)
              begin
              if (curframe[11:0] == 12'b111111111111)
                begin
                curframe <= {15{1'b0}};
                end
              else
                begin


                curframe <= curframe + 1'b1;
                end
              end
            else
              begin


              curframe <= curframe + 1'b1;
              end
            end
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : CUEFRAMEOV_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      curframeov <= 1'b1;
      end
    else
      begin
      if (upstren == 1'b0 || sof_rcv_disable == 1'b1)
        begin
        curframeov <= 1'b1;
        end
      else
        begin

        if (usbreset == 1'b1 ||
            suspendm == 1'b1 ||
            sleepm   == 1'b1)
          begin
          curframeov <= 1'b1;
          end
        else if (sof_rcv_fall == 1'b1)
          begin
          curframeov <= 1'b0;
          end
        else
          begin
          if (hsmode == 1'b1)
            begin
            if (curframe[11:0] == 12'b111111111111)
              begin
              curframeov <= 1'b1;
              end
            end
          else
            begin
            if (curframe == 15'b111111111111111)
              begin
              curframeov <= 1'b1;
              end
            end
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : NXTFRAME_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      nxtframe <= {15{1'b0}};
      end
    else
      begin
      if (upstren == 1'b0 || sof_rcv_disable == 1'b1)
        begin
        nxtframe <= {15{1'b0}};
        end
      else
        begin
        if (usbreset == 1'b1 ||
            suspendm == 1'b1 ||
            sleepm   == 1'b1)
          begin
          nxtframe <= {15{1'b0}};
          end
        else if (sof_rcv_fall == 1'b1 &&
                 curframeov   == 1'b0)
          begin
          nxtframe <= curframe;
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCFRAMECOUNTER_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcframecounter <= 12'h5DB;
      end
    else
      begin
      if (upstren    == 1'b1 ||
          usbreset_r == 1'b1 ||
          hclocsof   == 1'b0 ||
          lpmstate_r == 1'b1)
        begin



        if (hsmode == 1'b1)
          begin

          hcframecounter <= 12'hEA5;
          end
        else
          begin

          hcframecounter <= 12'h5DB;
          end
        end
      else
        begin
        if (hsmode == 1'b1)
          begin


          if (enable == 1'b1)
            begin
            if (hcframecounter == 12'h000)
              begin
              hcframecounter <= 12'hEA5;
              end
            else
              begin
              hcframecounter <= hcframecounter - 1'b1;
              end
            end
          end
        else
          begin

          if (frmcounten20 == 1'b1)
            begin
            if (enable == 1'b1)
              begin
              if (hcframecounter == 12'h000)
                begin
                hcframecounter <= 12'h5DB;
                end
              else
                begin
                hcframecounter <= hcframecounter - 1'b1;
                end
              end
            end
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : FRAMECOUNTER_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      framecounter    <= {15{1'b0}};
      framecounter_en <= 1'b0;
      end
    else
      begin
      if (upstren == 1'b0 || sof_rcv_disable == 1'b1)
        begin
        framecounter    <= {15{1'b0}};
        framecounter_en <= 1'b0;
        end
      else
        begin
        if (usbreset == 1'b1 ||
            suspendm == 1'b1 ||
            sleepm   == 1'b1)
          begin
          framecounter    <= {15{1'b0}};
          framecounter_en <= 1'b0;
          end
        else
          begin
          if (sof_rcv_fall == 1'b1 &&
              curframeov == 1'b0)
            begin
            framecounter    <= curframe;
            framecounter_en <= 1'b1;
            end
          else if (framecounter_en == 1'b1)
            begin
            if (enable == 1'b1)
              begin
              if (framecounter == 15'b000000000000000)
                begin
                framecounter <= nxtframe;
                end
              else
                begin
                framecounter <= framecounter - 1'b1;
                end
              end
            end
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SENDSOF_TMP_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      sendsof_tmp <= 1'b0;
      end
    else
      begin
      if (upstren == 1'b0 || sof_rcv_disable == 1'b1)
        begin
        sendsof_tmp <= 1'b0;
        end
      else
        begin
        if (usbreset == 1'b1 ||
            suspendm == 1'b1 ||
            sleepm   == 1'b1)
          begin
          sendsof_tmp <= 1'b0;
          end
        else if (sof_rcv_fall == 1'b1)
          begin
          sendsof_tmp <= 1'b1;
          end
        else if (framecounter == 15'b000000000000000 &&
                 framecounter_en == 1'b1)
          begin
          if (enable == 1'b1)
            begin
            sendsof_tmp <= 1'b1;
            end
          end

        else if (isosof_r == 1'b1 && isosof_r1 == 1'b0)
          begin
          sendsof_tmp <= 1'b0;
          end
        else if ((curframe == 15'b100_0000_0000_0000 && hsmode == 1'b0) ||
                 (curframe == 15'b000_1000_0000_0000 && hsmode == 1'b1))



          begin
          sendsof_tmp <= 1'b0;
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SENDSOF_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      sendsof <= 1'b0;
      end
    else
      begin
      if (upstren == 1'b1)
        begin
        sendsof <= 1'b0;
        end
      else
        begin
        if (hsmode == 1'b1)
          begin
          if (hcframecounter == 12'h000)
            begin
            if (enable == 1'b1)
              begin
              sendsof <= 1'b1;
              end
            end
          else
            begin
            sendsof <= 1'b0;
            end
          end
        else
          begin

          if (hcframecounter == 12'h000 &&
              frmcounten20 == 1'b1)
            begin
            if (enable == 1'b1)
              begin
              sendsof <= 1'b1;
              end
            end
          else
            begin
            sendsof <= 1'b0;
            end
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : ISOSOFSEND_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      isosofsend <= 1'b0;
      end
    else
      begin
      if (upstren == 1'b0 || sof_rcv_disable == 1'b1)
        begin
        isosofsend <= 1'b0;
        end
      else
        begin
        if (sendsof_tmp == 1'b0)
          begin
          if (sof_rcv_fall == 1'b1)
            begin
            isosofsend <= 1'b1;
            end
          else if (framecounter == 15'b000000000000000 &&
                   framecounter_en == 1'b1)
            begin
            if (enable == 1'b1)
              begin
              isosofsend <= 1'b1;
              end
            end
          end
        else
          begin
          isosofsend <= 1'b0;
          end
        end
      end
    end





  assign hcsendsof = sendsof | isosofsend;







  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SOFIRQ_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      sofirq_filtered <= 3'b000;
      end
    else
      begin
      if (sofirq_filtered != 3'b000)
        begin
        sofirq_filtered <= sofirq_filtered - 1'b1 ;
        end
      else if (sof_rcv_disable == 1'b1 && sof_rcv_fall == 1'b1)
        begin
        sofirq_filtered <= 3'b011;
        end

      else if (sof_rcv_disable == 1'b0 && isosofsend == 1'b1)
        begin
        sofirq_filtered <= 3'b100;
        end
      end
    end



  assign sofirq = (sofirq_filtered == 3'b010) ? 1'b1 :
                                                1'b0 ;






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SOFPULSE_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      sofpulse <= 1'b0;
      end
    else
      begin
      sofpulse <= sofirq;
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LASTSOFOK_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      sofok     <= 1'b0;
      lastsofok <= 1'b0;
      end
    else
      begin
      if (sof_rcv_disable == 1'b1)
        begin
        sofok     <= 1'b0;
        lastsofok <= 1'b0;
        end
      else if (sof_rcv_fall == 1'b1)
        begin

        sofok <= 1'b1;
        end
      else if (sofpulse == 1'b1)
        begin

        sofok <= 1'b0;
        if (sofok == 1'b1)
          begin
          lastsofok <= 1'b1;
          end
        else
          begin
          lastsofok <= 1'b0;
          end
        end
      end
    end







  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : CLRMFRMNRACK_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      clrmfrmnrack <= 1'b0;
      end
    else
      begin
      if (sof_rcv_disable == 1'b1)
        begin
        clrmfrmnrack <= clrmfrmnr;








        end
      else if (isosof_r  == 1'b1 &&
               isosof_r1 == 1'b0)
        begin

        clrmfrmnrack <= 1'b0;
        end
      else if (sof_rcv_fall == 1'b1 &&
               lastsofok == 1'b1 &&
               clrmfrmnr == 1'b1)
        begin



        clrmfrmnrack <= 1'b1;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : ISOSOF_REG_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      isosof_r <= 1'b0 ;
      end
    else
      begin
      if (upstren == 1'b0 || sof_rcv_disable == 1'b1)
        begin
        isosof_r <= 1'b0 ;
        end
      else
        begin
        if (framecounter == 15'b000000000010100)
          begin

          if (enable == 1'b1)
            begin
            isosof_r <= 1'b1 ;
            end
          end
        else
          begin
          isosof_r <= 1'b0 ;
          end
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : ISOSOF_REG1_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      isosof_r1 <= 1'b0 ;
      end
    else
      begin
      isosof_r1 <= isosof_r ;
      end
    end





  assign isosofpulse = isosof_r & ~isosof_r1 ;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCCOUNTM20_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hccountm20 <= 5'b00000;
      end
    else
      begin
      if (usbreset == 1'b1)
        begin

        hccountm20 <= 5'b00000;
        end
      else if (hclocsof == 1'b1)
        begin

        if (enable == 1'b1)
          begin
          if (hccountm20 == 5'b10011)
            begin
            hccountm20 <= 5'b00000;
            end
          else
            begin
            hccountm20 <= hccountm20 + 1'b1;
            end
          end
        end
      end
    end





  assign frmcounten20 = (hccountm20 == 5'b10011) ? 1'b1 :
                                                   1'b0;







  assign hcframecounter_w = (hsmode == 1'b1) ? hcframecounter[6] :
                                               hcframecounter[2] ;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCFRAMECOUNTER_FF_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcframecounter_r <= 1'b0;
      end
    else
      begin
      hcframecounter_r <= hcframecounter_w;
      end
    end



  assign hcframecounter_i = (lpmstate == 1'b1)                     ? 1'b0 :
                            (hcframecounter_r == hcframecounter_w) ? 1'b0 :
                                                                     1'b1 ;







  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCFRMCOUNT_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcfrmcount <= {11{1'b0}} ;
      end
    else
      begin
      if (usbreset == 1'b1)
        begin

        hcfrmcount <= {11{1'b0}} ;
        end
      else if (downstren == 1'b1)
        begin

        if (hsmode == 1'b1)
          begin

          if (hcframecounter_i == 1'b1)
            begin

            hcfrmcount <= {hcframecounter[11:6], 5'b00000};
            end
          end
        else
          begin

          if (hcframecounter_i == 1'b1)
            begin

            hcfrmcount <= {1'b0, hcframecounter[11:2]};
            end
          end
        end
      else
        begin
        hcfrmcount <= {11{1'b0}} ;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCMFRAMECOUNTER_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcmframecounter <= 3'b000;
      end
    else
      begin
      if (usbreset == 1'b1)
        begin
        hcmframecounter <= 3'b000;
        end
      else if (downstren == 1'b1)
        begin
        if (hcframecounter == 12'h000 &&
            hsmode == 1'b1)
          begin
          if (enable == 1'b1)
            begin
            hcmframecounter <= hcmframecounter + 1'b1;
            end
          end
        end
      end
    end





  assign hcmfrmcount = hcmframecounter;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HC_FRMNUMBER_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hc_frmnumber <= {16{1'b0}};
      end
    else
      begin
      if (hsmode == 1'b1)
        begin
        if (hcframecounter == 12'h000 &&
            hcmframecounter == 3'b111)
          begin
          if (enable == 1'b1)
            begin
            hc_frmnumber <= hc_frmnumber + 1'b1;
            end
          end
        end
      else
        begin

        if (hcframecounter == 12'h000 &&
            frmcounten20 == 1'b1)
          begin
          if (enable == 1'b1)
            begin
            hc_frmnumber <= hc_frmnumber + 1'b1;
            end
          end
        end
      end
    end





  assign hcfrmnumber = hc_frmnumber;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCFRMNR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcfrmnr <= {16{1'b0}};
      end
    else
      begin
      if (usbreset == 1'b1)
        begin

        hcfrmnr <= {16{1'b0}};
        end
      else if (downstren == 1'b1)
        begin

        if (hsmode == 1'b1)
          begin

          if (hcframecounter_i == 1'b1)
            begin

            hcfrmnr <= {hcfrmnumber[12:0], hcmfrmcount};
            end
          end
        else
          begin

          if (hcframecounter_i == 1'b1)
            begin

            hcfrmnr <= hcfrmnumber[15:0];
            end
          end
        end
      else
        begin
        hcfrmnr <= {16{1'b0}} ;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : ISOSOF_REGS_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      isosofpulsereq <= 1'b0;
      end
    else
      begin
      isosofpulsereq <= isosof_r & ~isosof_r1;
      end
    end







  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : ISODUMP1K_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      isodump1k <= 1'b0;
      end
    else
      begin
      if (upstren == 1'b0)
        begin
        isodump1k <= 1'b0;
        end
      else
        begin
        if (hsmode == 1'b1 &&
            framecounter == 15'b000001000000000)
          begin
          if (enable == 1'b1)
            begin

            isodump1k <= 1'b1;
            end
          end
        else
          begin
          isodump1k <= 1'b0;
          end
        end
      end
    end







  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : ISODUMP2K_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      isodump2k <= 1'b0;
      end
    else
      begin
      if (upstren == 1'b0)
        begin
        isodump2k <= 1'b0 ;
        end
      else
        begin
        if (hsmode == 1'b1 &&
            framecounter == 15'b000010000000000)
          begin
          if (enable == 1'b1)
            begin

            isodump2k <= 1'b1;
            end
          end
        else
          begin
          isodump2k <= 1'b0;
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : WAIT_ON_IDLE_ON_THE_BUS_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      wait_on_idle <= 1'b0;
      end
    else
      begin
      if (busidle == 1'b1 && busidle_r == 1'b0)
        begin
        wait_on_idle <= 1'b0;
        end
      else if ((hcfsm_nxt == HCS_ACK   && hcfsm_st != HCS_ACK) ||
               (hcfsm_nxt == HCC_INACK && hcfsm_st != HCC_INACK) ||
               (hcfsm_nxt == HCS_SOF   && hcfsm_st != HCS_SOF))
        begin
        wait_on_idle <= 1'b1;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : BUSIDLE_R_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      busidle_r <= 1'b0;
      end
    else
      begin
      busidle_r <= busidle;
      end
    end





  assign innak = (devfsm_nxt == S_NAK && devfsm_st == W_SPKT) ? 1'b1 :
                                                                1'b0 ;
  assign innak_no = tendp;



  assign hcnak_hshk_reg_hs = hcnak_hshk[5:3] ;
  assign hcnak_hshk_reg_fs = hcnak_hshk[2:0];









  assign hcnak_hshk_sel_hs =            (hsmode == 1'b0)   ? 1'b1 :
                             (hcnak_hshk_reg_hs == 3'b001) ? hcframecounter[11] :
                             (hcnak_hshk_reg_hs == 3'b010) ? hcframecounter[10] :
                             (hcnak_hshk_reg_hs == 3'b011) ? hcframecounter[9] :
                             (hcnak_hshk_reg_hs == 3'b100) ? hcframecounter[8] :
                             (hcnak_hshk_reg_hs == 3'b101) ? hcframecounter[7] :
                             (hcnak_hshk_reg_hs == 3'b110) ? hcframecounter[6] :
                             (hcnak_hshk_reg_hs == 3'b111) ? hcframecounter[6] :
                                                           1'b1 ;



  assign hcnak_hshk_sel_fs =            (hsmode == 1'b1)   ? 1'b1 :
                             (hcnak_hshk_reg_fs == 3'b001) ? hcframecounter[10] :
                             (hcnak_hshk_reg_fs == 3'b010) ? hcframecounter[9] :
                             (hcnak_hshk_reg_fs == 3'b011) ? hcframecounter[8] :
                             (hcnak_hshk_reg_fs == 3'b100) ? hcframecounter[7] :
                             (hcnak_hshk_reg_fs == 3'b101) ? hcframecounter[6] :
                             (hcnak_hshk_reg_fs == 3'b110) ? hcframecounter[5] :
                             (hcnak_hshk_reg_fs == 3'b111) ? hcframecounter[5] :
                                                             1'b1 ;



  assign hcnak_hshk_sel = hcnak_hshk_sel_hs & hcnak_hshk_sel_fs ;



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCNAK_HSHK_SEL_R_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcnak_hshk_sel_r <= 1'b0;
      end
    else
      begin
      hcnak_hshk_sel_r <= hcnak_hshk_sel;
      end
    end



  assign hcnak_hshk_clr =        (htsdisable == 1'b1)  ? 1'b1 :
                          (hcnak_hshk_reg_hs == 3'b000 &&
                           hcnak_hshk_reg_fs == 3'b000) ? 1'b1 :
                                                         (hcnak_hshk_sel ^ hcnak_hshk_sel_r);



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : EP_NAK_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcinnak  <= 16'h0000;
      hcoutnak <= 16'h0000;
      end
    else
      begin
      if (hcnak_hshk_clr == 1'b1)
        begin
        hcinnak  <= 16'h0000;
        hcoutnak <= 16'h0000;
        end
      else if (hcfsm_st == HC_RNAK ||
              (hcfsm_st == HCR_PHSHK && pid == PID_NAK && rcvfall == 1'b1 && piderr == 1'b0))
        begin
        if (hcdir == 1'b0)
          begin
          hcoutnak[hcoutepnr] <= 1'b1 ;
          end
        else
          begin
          hcinnak[hcinepnr]   <= 1'b1 ;
          end
        end
      end
    end

endmodule

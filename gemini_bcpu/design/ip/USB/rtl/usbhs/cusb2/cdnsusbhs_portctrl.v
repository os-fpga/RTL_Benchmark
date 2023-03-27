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
//   Filename:           cdnsusbhs_portctrl.v
//   Module Name:        cdnsusbhs_portctrl
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
//   OTG2FSM/ Downstream/ Upstream port controller
//   K.W. D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"

//`define CDNSUSBHS_SMSC_PHY



module cdnsusbhs_portctrl
  (
  usbclk,
  usbrst,
  wakeup,
  wakeup_a,
  testmode,
  testmodesel,
  suspendm_req,
  sleepm_req,
  sigrsum,
  sigrsum_a,
  discon,
  linestate,
  resumereq,
  wuintreq,
  hsmode,
  hsmodeirq,

  utmitxvalidl,

  suspreq,
  sleepreq,
  sigrsumclr,
  wakesrc,
  suspendm,
  opmode,
  termselect,
  xcvrselect,
  drivechirpk,
  sleepm,
  lpmirq_retry,
  tsmode,

  enable,

  lpm_sleep_req,
  lpm_auto_entry,
  hsdisable,

  suspendm_en,
  sleepm_en,
  hostdiscon,
  iddig,
  avalid,
  vbusvalid,
  sessend,
  bvalid,
  usbrstsig_a,
  usbrstsig,
  usbrstsig16ms,
  usbrstsig55ms,
  wakeupid,
  wakeupdp,
  wakeupvbus,
  hcsleep_ack,
  hclpmctrl_hird,
  hclpmctrlb,
  otgctrl,
  otgctrl_bus_req,
  otgforce,
  otg2ctrl,
  bc_dmpulldown,
  bc_dppulldown,
  bc_pulldownctrl,
  tbvbuspls,
  tawaitbcon,
  taaidlbdis,
  tbvbusdispls,
  wuiden,
  wudpen,
  wuvbusen,
  portctrltm,
  chrgvbus,
  dischrgvbus,
  drvvbus,
  locpulldndp,
  locpulldndm,
  idpullup,
  busidle,
  usbreset,
  usbresetirq,
  usbrstsigclr,
  lsmode,
  drivechirpj,
  lpmstate,
  lpmstate_besl,
  hclocsof,
  downstren,
  upstren,
  clrbhnpen,
  otgstatus,
  otgstate,
  downstrstate,
  idleirq,
  srpdetirq,
  locsofirq,
  vbuserrirq,
  periphirq,
  idchangeirq,
  hostdisconirq,
  bse0srpirq,
  adp_change_ack,
  upstrstate,

  otgspeed,

  workaround_otg,

  linestate_up,

  timeout
  );



  input                        usbclk;
  input                        usbrst;
  input                        wakeup;
  input                        wakeup_a;
  input                        testmode;
  input   [1:0]                testmodesel;
  input                        suspendm_req;
  input                        sleepm_req;
  input                        sigrsum;
  input                        sigrsum_a;
  input                        discon;
  input   [1:0]                linestate;
  output                       resumereq;
  reg                          resumereq;
  output                       wuintreq;
  reg                          wuintreq;
  output                       hsmode;
  reg                          hsmode;
  output                       hsmodeirq;
  wire                         hsmodeirq;

  input                        utmitxvalidl;

  output                       suspreq;
  reg                          suspreq;
  output                       sleepreq;
  reg                          sleepreq;
  output                       sigrsumclr;
  wire                         sigrsumclr;
  output                       wakesrc;
  reg                          wakesrc;
  output                       suspendm;
  wire                         suspendm;
  output  [1:0]                opmode;
  reg     [1:0]                opmode;
  output                       termselect;
  reg                          termselect;
  output  [1:0]                xcvrselect;
  reg     [1:0]                xcvrselect;
  output                       drivechirpk;
  reg                          drivechirpk;
  output                       sleepm;
  wire                         sleepm;
  output                       lpmirq_retry;
  reg                          lpmirq_retry;
  input   [1:0]                tsmode;

  output                       enable;
  wire                         enable;

  input                        lpm_sleep_req;
  input                        lpm_auto_entry;
  input                        hsdisable;

  output                       suspendm_en;
  reg                          suspendm_en;
  output                       sleepm_en;
  reg                          sleepm_en;
  input                        hostdiscon;
  input                        iddig;
  input                        avalid;
  input                        vbusvalid;
  input                        sessend;
  input                        bvalid;
  input                        usbrstsig_a;
  input                        usbrstsig;
  input                        usbrstsig16ms;
  input                        usbrstsig55ms;
  input                        wakeupid;
  input                        wakeupdp;
  input                        wakeupvbus;
  input                        hcsleep_ack;
  input   [3:0]                hclpmctrl_hird;
  input                        hclpmctrlb;
  input   [6:0]                otgctrl;
  input                        otgctrl_bus_req;
  input   [7:0]                otgforce;
  input   [1:0]                otg2ctrl;
  input                        bc_dmpulldown;
  input                        bc_dppulldown;
  input                        bc_pulldownctrl;
  input   [7:0]                tbvbuspls;
  input   [7:0]                tawaitbcon;
  input   [7:0]                taaidlbdis;
  input   [7:0]                tbvbusdispls;
  input                        wuiden;
  input                        wudpen;
  input                        wuvbusen;
  input                        portctrltm;

  output                       chrgvbus;
  reg                          chrgvbus;
  output                       dischrgvbus;
  reg                          dischrgvbus;
  output                       drvvbus;
  reg                          drvvbus;
  output                       locpulldndp;
  reg                          locpulldndp;
  output                       locpulldndm;
  reg                          locpulldndm;
  output                       idpullup;
  wire                         idpullup;
  output                       busidle;
  wire                         busidle;
  output                       usbreset;
  reg                          usbreset;
  output                       usbresetirq;
  wire                         usbresetirq;
  output                       usbrstsigclr;
  wire                         usbrstsigclr;
  output                       lsmode;
  reg                          lsmode;
  output                       drivechirpj;
  reg                          drivechirpj;
  output                       lpmstate;
  reg                          lpmstate;
  output                       lpmstate_besl;
  reg                          lpmstate_besl;
  output                       hclocsof;
  reg                          hclocsof;
  output                       downstren;
  wire                         downstren;
  output                       upstren;
  wire                         upstren;
  output                       clrbhnpen;
  reg                          clrbhnpen;
  output  [7:0]                otgstatus;
  wire    [7:0]                otgstatus;
  output  [4:0]                otgstate;
  wire    [4:0]                otgstate;
  output  [3:0]                downstrstate;
  wire    [3:0]                downstrstate;
  output                       idleirq;
  wire                         idleirq;
  output                       srpdetirq;
  wire                         srpdetirq;
  output                       locsofirq;
  wire                         locsofirq;
  output                       vbuserrirq;
  wire                         vbuserrirq;
  output                       periphirq;
  wire                         periphirq;
  output                       idchangeirq;
  wire                         idchangeirq;
  output                       hostdisconirq;
  wire                         hostdisconirq;
  output                       bse0srpirq;
  wire                         bse0srpirq;

  output                       adp_change_ack;
  wire                         adp_change_ack;

  output  [4:0]                upstrstate;
  wire    [4:0]                upstrstate;

  output  [2:0]                otgspeed;
  reg     [2:0]                otgspeed;

  input   [2:0]                workaround_otg;

  output  [1:0]                linestate_up;
  wire    [1:0]                linestate_up;

  output                       timeout;
  wire                         timeout;

  reg                          enable_r;



  parameter TDATAPULSE_SHORT  = 19'b000_0011_1010_1010_0000;
  parameter TDATAPULSE        = 19'b011_0100_0000_0000_0000;




  parameter DISABLED_U        = 5'b0_0000;
  parameter TIMERRESET        = 5'b0_0001;
  parameter SE0_STATE         = 5'b0_0010;
  parameter J_STATE           = 5'b0_0011;
  parameter HIGH_SPEED_U      = 5'b0_0100;
  parameter HIGH_SPEED_SE0    = 5'b0_0101;
  parameter REMOVE_HS         = 5'b0_0110;
  parameter SUSPENDED         = 5'b0_0111;
  parameter WAIT_FILT         = 5'b0_1000;
  parameter DETECT_SE0        = 5'b0_1001;
  parameter HANDSHAKE         = 5'b0_1010;
  parameter DETECT_HSJ        = 5'b0_1011;
  parameter DETECT_HSK        = 5'b0_1100;
  parameter INCREASE          = 5'b0_1101;
  parameter WAIT_END_RESET    = 5'b0_1110;
  parameter DRIVE_RESUME      = 5'b0_1111;
  parameter RESUME            = 5'b1_0000;
  parameter SLEEP_RESUME      = 5'b1_0001;
  parameter SLEEP             = 5'b1_0010;


  reg [4:0] state_u;

  reg [4:0] next_state_u;




  parameter A_IDLE       = 5'b0_0000;
  parameter A_WAIT_VRISE = 5'b0_0001;
  parameter A_WAIT_BCON  = 5'b0_0010;
  parameter A_HOST       = 5'b0_0011;
  parameter A_SUSPEND    = 5'b0_0100;
  parameter A_PERIPHERAL = 5'b0_0101;
  parameter A_VBUS_ERR   = 5'b0_0110;
  parameter A_WAIT_VFALL = 5'b0_0111;
  parameter B_IDLE       = 5'b1_0000;
  parameter B_PERIPHERAL = 5'b1_0001;
  parameter B_WAIT_ACON  = 5'b1_0010;
  parameter B_HOST_1     = 5'b1_0011;
  parameter B_HOST_2     = 5'b1_0100;
  parameter B_SRP_INIT1  = 5'b1_0101;
  parameter B_SRP_INIT2  = 5'b1_0110;
  parameter B_DISCHRG1   = 5'b1_0111;
  parameter B_DISCHRG2   = 5'b1_1000;


  reg [4:0] state;

  reg [4:0] next_state;
  reg [4:0] prev_state;








  parameter DISABLED         = 4'b0000;
  parameter DDRIVE_SE0       = 4'b0001;
  parameter CLR_TIMER1       = 4'b0010;
  parameter RUN_TIMER1       = 4'b0011;
  parameter WAITD            = 4'b0100;
  parameter DEV_DET          = 4'b0101;
  parameter FULL_SPEED       = 4'b0110;
  parameter LOW_SPEED        = 4'b0111;
  parameter DR_CHIRP_J       = 4'b1000;
  parameter DR_CHIRP_K       = 4'b1001;
  parameter DRIVE_SE0_HS     = 4'b1010;
  parameter HIGH_SPEED       = 4'b1011;
  parameter PRE_SUSPEND      = 4'b1100;
  parameter LPM_SUSPEND      = 4'b1101;
  parameter LPM_DRIVE_RESUME = 4'b1110;


  reg [3:0] state_d;

  reg [3:0] next_state_d;




  parameter NO_RES = 2'b00;
  parameter RES1   = 2'b01;
  parameter RES2   = 2'b10;
  parameter RES3   = 2'b11;


  reg [1:0] state_hr;

  reg [1:0] next_state_hr;




  parameter IDL_IDLE   = 2'b00;
  parameter IDL_ACTIVE = 2'b01;
  parameter IDL_EOP    = 2'b10;
  parameter IDL_EOP1   = 2'b11;


  reg [1:0] idlfsm_st;

  reg [1:0] idlfsm_nxt;


  wire                         hsdisable_s;

  reg                          prev_wait_vrise;


  wire     [1:0]               linestate_int;
  wire     [1:0]               linestate_filtered;
  reg      [1:0]               linestate_r;
  reg      [1:0]               linestate_r2;
  reg      [1:0]               linestate_r3;
  reg                          linestate_j;
  reg                          hostdiscon_r;
  wire                         avalid_s;
  wire                         vbusvalid_s;
  wire                         sessend_s;
  wire                         bvalid_s;
  wire                         forcebconn;

  parameter TIMER_T0_WIDTH   = 32'd27;
  parameter TIMER_T1_WIDTH   = 32'd27;
  parameter TIMER_T2_WIDTH   = 32'd28;
  parameter TIMER_T3_WIDTH   = 32'd8;
  parameter TIMER_T4_WIDTH   = 32'd8;
  parameter BHOSTTIMER_WIDTH = 32'd24;

  reg      [TIMER_T0_WIDTH-1:0]   timer_t0;
  reg      [TIMER_T1_WIDTH-1:0]   timer_t1;
  reg      [TIMER_T2_WIDTH-1:0]   timer_t2;
  reg      [TIMER_T3_WIDTH-1:0]   timer_t3;
  reg      [TIMER_T4_WIDTH-1:0]   timer_t4;
  reg      [BHOSTTIMER_WIDTH-1:0] bhosttimer;

  wire                         bhosttmout;

  reg                          downstr_en;
  reg                          upstr_en;
  wire                         a_bus_drop;
  wire                         bus_req;
  wire                         a_set_b_hnp_en;
  wire                         b_hnp_enable;
  wire                         srpdatadeten;
  wire                         srpvbusdeten;
  wire                         a_srp_det_filtered;
  reg                          a_srp_det_filtered_r;
  reg                          a_srp_det_filtered_r2;
  wire                         a_srp_det_10ms;
  reg                          a_srp_det_long;
  wire                         a_srp_det;
  reg                          a_srp_det_r;
  wire                         b_se0_srp;
  wire                         b_ssend_srp;
  reg                          b_ssend_srp_tmout;


  reg                          a_conn;
  reg                          b_conn;
  reg                          devconnected;
  reg                          devconnected_ff;
  reg                          bse0srp;
  reg                          bse0srp_r;
  wire                         a_bus_suspend;
  wire                         b_bus_suspend;
  wire                         a_bus_resume;
  wire                         a_wait_vrise_tmout;
  wire                         a_wait_vfall_tmout;
  wire                         a_wait_bcon_tmout;
  wire                         a_aidl_bdis_tmout;
  wire                         b_ase0_brst_tmout;

  wire                         tursm;
  wire                         tsuspreq;
  reg                          tursm_tmout;
  wire                         tbconn;
  reg                          tbconn_tmout;



  wire                         ta_wait_opmode;
  wire                         ta_wait_linestate;
  wire                         ta_bcon_sdb;
  wire                         ta_bcon_ldb;
  wire                         ta_bcon_sdb_win;
  reg                          ta_bcon_sdb_win_tmout;
  wire                         tb_acon_dbnc;
  wire                         tldis_dschg;
  reg                          tldis_dschg_tmout;
  wire                         tddis;



  wire                         tb_data_pls;
  wire                         tb_vbus_pls;
  wire                         tb_dischrgpls_tmout;



  reg                          suspendm_req_rr;
  reg                          suspendm_req_r;
  reg                          suspendm_req_r2;
  reg                          suspendm_req_r3;
  reg                          wakeup_r;
  reg                          wakeupreq_ff;
  reg                          wakeupreq_ff1;
  reg                          wuiden_r;
  reg                          wudpen_r;
  reg                          wuvbusen_r;
  wire                         wudetector;
  reg                          wudetector_ff;
  wire                         wudetector_hold;
  reg                          disperreset;
  reg                          usbrstsig_r;
  reg                          usbrstsig_r2;
  reg                          usbrstsig16ms_r;
  reg                          usbrstsig55ms_r;
  wire                         hrstsig;
  reg                          sigrsum_r;
  reg                          sigrsum_r2;
  reg                          sigrsum_latch;
  reg                          status;
  wire                         hsmode_s;
  reg                          hsmode_r;
  reg                          bustimeout;
  wire                         usbreset_s;

  parameter TIMERP_T0_WIDTH = 32'd23;
  reg      [TIMERP_T0_WIDTH-1:0]  timerp_t0;
  reg      [19:0]                 timerp_t1;
  reg      [10:0]                 timerp_t2;
  reg      [14:0]                 timer_vbusvld;

  wire                         tfilt;
  wire                         tstatej;
  wire                         tfiltjk;

  wire                         tfilt25;
  wire                         tfilt12;
  reg                          tfilt12_latch;
  reg                          suspend_r;
  reg                          failed_hnp;

  reg                          inc;
  reg                          count_rst;
  reg      [1:0]               count;
  reg                          wakeup_set;
  reg                          susp_set;
  wire                         clr_tmr_t0;
  reg                          count_tmr_t0;

  wire                         tfiltse0;
  wire                         twtrstfs_se0;
  wire                         twtrstfs_j;
  wire                         tuch;
  wire                         twaitchk;
  wire                         twtfs;
  wire                         twtrev;
  wire                         twtrsths;
  wire                         touths;
  wire                         toutfs;
  wire                         touthhs;
  wire                         touthfs;
  wire                         touthls;
  wire                         twtrsm;
  wire                         tdrsmup;
  wire                         tdrsmup_5u;
  wire                         tbfsbdis;
  reg                          tbfsbdis_tmout;
  wire                         tb_aidl_bdisx;
  reg                          tb_aidl_bdisx_tmout;
  wire                         ta_bidl_adis;
  reg                          ta_bidl_adis_tmout;

  wire                         tdrst;
  wire                         tdrst10;
  wire                         tdrst16;
  wire                         tdrst55;
  wire                         tuchend;
  reg                          tuchend_tmout;
  wire                         tdchbit;
  wire                         tdrstdchse0;
  reg                          tdrstdchse0_latch;
  wire                         tdrst16dchse0;
  wire                         tdrst10dchse0;
  wire                         tdrst55dchse0;
  wire                         tdrsmdn;

  wire                         tdevdrvresume;
  wire                         tdevdrvresume_5u;

  `ifdef CDNSUSBHS_LPM_ENABLE
  reg                          lpm_enable;
  wire                         lpm_enable_r;
  `endif
  `ifdef CDNSUSBHS_LPM_ENABLE
  `else
  wire                         sleep_r;
  `endif
  reg                          sleepm_mode;
  `ifdef CDNSUSBHS_LPM_ENABLE
  `else
  reg                          sleep_ff;
  `endif


  `ifdef CDNSUSBHS_LPM_ENABLE
  wire                         lpm_enableh_r;
  `endif
  `ifdef CDNSUSBHS_LPM_ENABLE
  `else
  wire                         sleeph_r;
  `endif
  reg      [1:0]               speed_ff;
  wire                         thirdresume;
  reg      [19:0]              thirdtime;
  wire                         tbeslresume;
  reg      [11:0]              tbesltime;
  reg                          rwdet_lpm;
  reg                          hcsleep_ack_ff;
  wire                         hcsleep_ack_fix;
  wire                         lpmstate_w;
  reg                          susp_req;
  reg                          host_do_suspend;

  wire                         otg2en;
  wire                         adp_change;
  reg                          adp_change_r;

  reg                          disdrivechirpk_r;

  reg                          iddig_r;
  reg                          iddig_r2;
  reg                          iddig_r3;

  reg      [1:0]               opmode_r;

  reg      [1:0]               linestate_up_r;





  assign adp_change_ack = adp_change ;



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : ADP_CHANGE_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      adp_change_r <= 1'b0 ;
      end
    else
      begin
      if (state != A_IDLE && state != B_IDLE)
        begin
        adp_change_r <= 1'b0 ;
        end
      else if (adp_change == 1'b1)
        begin
        adp_change_r <= 1'b1 ;
        end
      end
    end



  assign hsdisable_s = hsdisable ;






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : WU_EN_SFFS_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      wuiden_r   <= 1'b0 ;
      wudpen_r   <= 1'b0 ;
      wuvbusen_r <= 1'b0 ;
      end
    else
      begin
      if (suspendm_req == 1'b1 && suspendm_req_rr == 1'b0)
        begin
        wuiden_r   <= wuiden ;
        wudpen_r   <= wudpen ;
        wuvbusen_r <= wuvbusen ;
        end
      end
    end





  assign linestate_filtered = (ta_wait_linestate == 1'b0) ? 2'b00 :
                                                            linestate ;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LINESTATE_UP_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      linestate_up_r <= 2'b00 ;
      end
    else
      begin
      linestate_up_r <= linestate_filtered ;
      end
    end





  assign linestate_up = (suspendm == 1'b0) ? linestate_filtered :
                                             linestate_up_r;





  assign linestate_int = (state_d == LOW_SPEED || speed_ff == 2'b10) ? {linestate_filtered[0], linestate_filtered[1]} :
                                                                        linestate_filtered ;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LINE_STATE_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      linestate_r  <= 2'b00 ;
      linestate_r2 <= 2'b00 ;
      linestate_r3 <= 2'b00 ;
      linestate_j  <= 1'b0 ;
      end
    else
      begin
      if (utmitxvalidl == 1'b1 && hsmode_s == 1'b0 && (state_d == FULL_SPEED ||
                                                       state_d == LOW_SPEED))
        begin
        linestate_r <= 2'b10 ;
        end
      else if (utmitxvalidl == 1'b1 && hsmode_s == 1'b1 && state_d == HIGH_SPEED)
        begin
        linestate_r <= 2'b01 ;
        end
      else
        begin
        linestate_r <= linestate_int ;
        end

      linestate_r2 <= linestate_r;
      linestate_r3 <= linestate_r2;
      if (linestate_r  == 2'b01 &&
          linestate_r2 == 2'b01 &&
          linestate_r3 == 2'b01)
        begin
        linestate_j <= 1'b1 ;
        end
      else
        begin
        linestate_j <= 1'b0 ;
        end
      end
    end





  assign otgstate = state ;






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HOSTDISCON_R_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hostdiscon_r <= 1'b0 ;
      end
    else
      begin
      hostdiscon_r <= hostdiscon ;
      end
    end



  assign vbusvalid_s = (otgforce[7] == 1'b1) ? 1'b1 :
                       (otgforce[6] == 1'b1) ? 1'b0 :
                                               vbusvalid;



  assign avalid_s    = (otgforce[5] == 1'b1) ? 1'b1 :
                       (otgforce[4] == 1'b1) ? 1'b0 :
                                               avalid;



  assign bvalid_s    = (otgforce[3] == 1'b1) ? 1'b1 :
                       (otgforce[2] == 1'b1) ? 1'b0 :
                                               bvalid ;



  assign sessend_s   = (otgforce[1] == 1'b1) ? 1'b1 :
                       (otgforce[0] == 1'b1) ? 1'b0 :
                                               sessend;





  assign idpullup = 1'b1 ;






  assign a_srp_det =
                     (a_srp_det_filtered_r  == 1'b0 &&
                      a_srp_det_filtered_r2 == 1'b1 && srpdatadeten == 1'b1) ? 1'b1 :

                     (otg2en == 1'b1)                                        ? 1'b0 :

                     (avalid_s == 1'b1 && srpvbusdeten == 1'b1)              ? 1'b1 :
                                                                               1'b0 ;






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : A_SRP_DET_R_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      a_srp_det_r <= 1'b0 ;
      end
    else
      begin
      if (a_srp_det == 1'b1)
        begin
        a_srp_det_r <= 1'b1 ;
        end
      else if (enable_r == 1'b1)
        begin
        a_srp_det_r <= 1'b0 ;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : A_SRP_DET_FILTERED_R_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      a_srp_det_filtered_r  <= 1'b0 ;
      a_srp_det_filtered_r2 <= 1'b0 ;
      end
    else
      begin
      if (linestate_r == 2'b00 || (a_srp_det_filtered_r == 1'b1 && a_srp_det_10ms == 1'b1))
        begin
        a_srp_det_filtered_r <= 1'b0 ;
        end
      else if (a_srp_det_filtered == 1'b1)
        begin
        a_srp_det_filtered_r <= 1'b1 ;
        end
      a_srp_det_filtered_r2 <= a_srp_det_filtered_r;
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : A_SRP_DET_LONG_R_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      a_srp_det_long <= 1'b0 ;
      end
    else
      begin
      if (a_srp_det_10ms == 1'b1 && srpdatadeten == 1'b1)
        begin
        if (a_srp_det_filtered_r == 1'b1)
          begin
          a_srp_det_long <= 1'b1 ;
          end
        end
      else if (state == A_IDLE && linestate_r == 2'b00)
        begin
        a_srp_det_long <= 1'b0 ;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : CLRBHNPEN_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      clrbhnpen <= 1'b0 ;
      end
    else
      begin
      if (b_hnp_enable == 1'b0 && a_set_b_hnp_en == 1'b0)
        begin
        clrbhnpen <= 1'b0 ;
        end
      else if ((state != A_IDLE && next_state == A_IDLE)       ||
               (state != B_IDLE && next_state == B_IDLE)       ||
               (state_d == DDRIVE_SE0 &&
                                   next_state_d != DDRIVE_SE0) ||
               (state_u == HANDSHAKE &&
                                   next_state_u != HANDSHAKE))
        begin
        if (enable_r == 1'b1)
          begin
          clrbhnpen <= 1'b1 ;
          end
        end
      else
        begin
        clrbhnpen <= 1'b0 ;
        end
      end
    end






  assign a_bus_suspend =
     (state_u == SUSPENDED &&





      tb_aidl_bdisx_tmout == 1'b1 &&







     (status == 1'b0 || tbfsbdis_tmout == 1'b1)) ? 1'b1 :
                                                   1'b0 ;









  assign b_bus_suspend =
     (state_u != SUSPENDED)                         ? 1'b0 :



     (otg2en == 1'b1 &&
                        ta_bidl_adis_tmout == 1'b1) ? 1'b1 :
     (otg2en == 1'b0 &&
                       (status == 1'b0 ||
                        tbfsbdis_tmout == 1'b1))    ? 1'b1 :
                                                      1'b0 ;



  assign {forcebconn,
          srpdatadeten,
          srpvbusdeten,
          b_hnp_enable,
          a_set_b_hnp_en,
          a_bus_drop,
          bus_req} = otgctrl ;



  assign {adp_change,
          otg2en} = otg2ctrl ;






  always @(iddig or state or state_d or state_hr or bus_req or ta_wait_opmode or
           a_bus_drop or a_set_b_hnp_en or b_hnp_enable or discon or
           a_bus_resume or a_bus_suspend or b_bus_suspend or a_conn or
           b_conn or a_srp_det_r or b_se0_srp or hrstsig or avalid_s or
           vbusvalid_s or sessend_s or bvalid_s or a_aidl_bdis_tmout or
           a_wait_vrise_tmout or b_ase0_brst_tmout or a_wait_bcon_tmout or
           tb_data_pls or tb_vbus_pls or linestate_r or
           tbvbusdispls or testmode or portctrltm or tb_dischrgpls_tmout or
           failed_hnp or timer_vbusvld or forcebconn or bhosttmout or
           adp_change_r or b_ssend_srp_tmout or a_wait_vfall_tmout or otg2en or
           suspendm_req_r)
    begin : NEXT_STATE_PROC
    case (state)
        A_IDLE :
            begin
            if (suspendm_req_r == 1'b0)
              begin
              next_state = A_IDLE ;
              end
            else if (iddig == 1'b1)
              begin
              next_state = B_IDLE ;
              end
            else if (ta_wait_opmode == 1'b0)
              begin
              next_state = A_IDLE ;
              end

            else if (a_bus_drop == 1'b0 && adp_change_r == 1'b1)
              begin
              next_state = A_WAIT_VRISE ;
              end

            else if (a_bus_drop == 1'b0 && (bus_req == 1'b1 ||
                                            a_srp_det_r == 1'b1))
              begin
              next_state = A_WAIT_VRISE ;
              end
            else
              begin
              next_state = A_IDLE ;
              end
            end
        A_WAIT_VFALL :
            begin
            if (otg2en == 1'b1)
              begin
              if (a_wait_vfall_tmout == 1'b1)
                begin
                next_state = A_IDLE ;
                end
              else
                begin
                next_state = A_WAIT_VFALL ;
                end
              end
            else
              begin
              if (iddig == 1'b1 ||
                  (avalid_s == 1'b0 && (bus_req == 1'b1 ||
                                        linestate_r == 2'b00)))
                begin
                next_state = A_IDLE ;
                end
              else
                begin
                next_state = A_WAIT_VFALL ;
                end
              end
            end
        A_WAIT_VRISE :
            begin
              if (vbusvalid_s == 1'b1 && (forcebconn == 1'b1 ||
                                          timer_vbusvld[14:4] == 11'b11101010011))
                begin
                next_state = A_WAIT_BCON ;
                end
              else if (iddig == 1'b1 ||
                       a_bus_drop == 1'b1 ||
                       a_wait_vrise_tmout == 1'b1)
                begin
                if (otg2en == 1'b1)
                  begin
                  next_state = A_WAIT_VFALL ;
                  end
                else
                  begin
                  next_state = A_WAIT_BCON ;
                  end
                end
              else
                begin
                next_state = A_WAIT_VRISE ;
                end
            end
        A_PERIPHERAL :
            begin
            if (iddig == 1'b1 ||
                a_bus_drop == 1'b1)
              begin
              next_state = A_WAIT_VFALL ;
              end
            else if (b_bus_suspend == 1'b1)
              begin
              next_state = A_WAIT_BCON ;
              end
            else if (vbusvalid_s == 1'b0)
              begin
              next_state = A_VBUS_ERR ;
              end
            else
              begin
              next_state = A_PERIPHERAL ;
              end
            end
       A_VBUS_ERR :
            begin
            if (iddig == 1'b1 ||
                a_bus_drop == 1'b1)
              begin
              next_state = A_WAIT_VFALL ;
              end
            else
              begin
              next_state = A_VBUS_ERR ;
              end
            end
       A_WAIT_BCON :
            begin
            if (suspendm_req_r == 1'b0)
              begin
              next_state = A_WAIT_BCON ;
              end
            else if (iddig == 1'b1 ||
                     a_bus_drop == 1'b1 ||
                     a_wait_bcon_tmout == 1'b1)
              begin
              next_state = A_WAIT_VFALL ;
              end
            else if (vbusvalid_s == 1'b0)
              begin
              next_state = A_VBUS_ERR ;
              end
            else if (b_conn == 1'b1 ||
                     testmode == 1'b1 ||
                     portctrltm == 1'b1)
              begin
              next_state = A_HOST ;
              end
            else
              begin
              next_state = A_WAIT_BCON ;
              end
            end
        A_SUSPEND :
            begin
            if (suspendm_req_r == 1'b0)
              begin
              next_state = A_SUSPEND ;
              end
            else if (vbusvalid_s == 1'b0)
              begin
              next_state = A_VBUS_ERR ;
              end
            else if (iddig == 1'b1 ||
                     a_bus_drop == 1'b1 ||
                     a_aidl_bdis_tmout == 1'b1)
              begin
              next_state = A_WAIT_VFALL ;
              end
            else if ((bus_req == 1'b1 || hrstsig == 1'b1) &&




                     (a_set_b_hnp_en == 1'b0 ||
                     (a_set_b_hnp_en == 1'b1 && linestate_r != 2'b00)))
              begin
              next_state = A_HOST ;
              end
            else if (b_conn == 1'b0)
              begin
              if (a_set_b_hnp_en == 1'b1)
                begin
                next_state = A_PERIPHERAL ;
                end
              else
                begin
                next_state = A_WAIT_BCON ;
                end
              end
            else
              begin
              next_state = A_SUSPEND ;
              end
            end
       A_HOST :
            begin
            if (testmode == 1'b1 ||
                portctrltm == 1'b1)
              begin
              next_state = A_HOST ;
              end
            else if (b_conn == 1'b0)
              begin
              next_state = A_WAIT_BCON ;
              end
            else if (iddig == 1'b1 ||
                     a_bus_drop == 1'b1)
              begin
              if (otg2en == 1'b1)
                begin
                next_state = A_WAIT_VFALL;
                end
              else
                begin
                next_state = A_WAIT_BCON ;
                end
              end
            else if (vbusvalid_s == 1'b0)
              begin
              next_state = A_VBUS_ERR ;
              end
            else if (bus_req == 1'b0 &&
                     state_hr == NO_RES && (state_d == LOW_SPEED ||
                                            state_d == FULL_SPEED ||
                                            state_d == HIGH_SPEED))
              begin
              next_state = A_SUSPEND ;
              end
            else
              begin
              next_state = A_HOST ;
              end
            end
        B_IDLE :
            begin
            if (suspendm_req_r == 1'b0)
              begin
              next_state = B_IDLE ;
              end
            else if (iddig == 1'b0)
              begin
              next_state = A_IDLE ;
              end
            else if (ta_wait_opmode == 1'b0)
              begin
              next_state = B_IDLE ;
              end
            else if (bvalid_s == 1'b1 &&
                     discon == 1'b0)
              begin
              next_state = B_PERIPHERAL ;
              end
            else if ((bus_req == 1'b1 || adp_change_r == 1'b1) &&
                      b_se0_srp == 1'b1 &&
                     ((otg2en == 1'b1 && b_ssend_srp_tmout == 1'b1) ||
                      (otg2en == 1'b0 && sessend_s         == 1'b1)))
              begin
              next_state = B_SRP_INIT1 ;
              end
            else if (bus_req == 1'b1 &&
                     bvalid_s == 1'b0 &&
                     sessend_s == 1'b0 && otg2en == 1'b0)
              begin
              next_state = B_DISCHRG1 ;
              end
            else
              begin
              next_state = B_IDLE ;
              end
            end
        B_HOST_1 :
            begin
            if (iddig == 1'b0 ||
                bvalid_s == 1'b0)
              begin
              next_state = B_IDLE;
              end
            else if (a_conn == 1'b0 &&
                     (state_d == LOW_SPEED ||
                      state_d == FULL_SPEED ||
                      state_d == HIGH_SPEED))
              begin
              next_state = B_PERIPHERAL;
              end
            else if (bus_req == 1'b0 &&
                     state_hr  == NO_RES &&
                     (state_d == LOW_SPEED ||
                      state_d == FULL_SPEED ||
                      state_d == HIGH_SPEED))
              begin
              next_state = B_HOST_2;
              end
            else
              begin
              next_state = B_HOST_1;
              end
            end
        B_HOST_2 :
            begin
            if (iddig == 1'b0 ||
                bvalid_s == 1'b0)
              begin
              next_state = B_IDLE;
              end

            else if ((bus_req == 1'b1 || hrstsig == 1'b1) &&
                      otg2en == 1'b1)
              begin





              next_state = B_HOST_1;
              end


            else if (bhosttmout == 1'b1)
              begin
              next_state = B_PERIPHERAL;
              end
            else
              begin
              next_state = B_HOST_2;
              end
            end
        B_SRP_INIT1 :
            begin
            if (iddig == 1'b0)
              begin
              next_state = B_IDLE ;
              end
            else if (tb_data_pls == 1'b1)
              begin
              if (otg2en == 1'b1)
                begin
                next_state = B_IDLE ;
                end
              else
                begin
                next_state = B_SRP_INIT2 ;
                end
              end
            else
              begin
              next_state = B_SRP_INIT1 ;
              end
            end
       B_SRP_INIT2 :
            begin
            if (iddig == 1'b0)
              begin
              next_state = B_IDLE ;
              end
            else if (tb_vbus_pls == 1'b1)
              begin
              if (tbvbusdispls == 8'h00)
                begin
                next_state = B_IDLE ;
                end
              else
                begin
                next_state = B_DISCHRG2 ;
                end
              end
            else
              begin
              next_state = B_SRP_INIT2 ;
              end
            end
        B_PERIPHERAL :
            begin
            if (testmode == 1'b1)
              begin
              next_state = B_PERIPHERAL ;
              end
            else if (iddig == 1'b0 ||
                     bvalid_s == 1'b0 ||
                     discon == 1'b1)
              begin
              next_state = B_IDLE ;
              end
            else if (bus_req == 1'b1 &&
                     b_hnp_enable == 1'b1 &&
                     a_bus_suspend == 1'b1 &&
                     failed_hnp == 1'b0)
              begin
              next_state = B_WAIT_ACON ;
              end
            else
              begin
              next_state = B_PERIPHERAL ;
              end
            end
        B_WAIT_ACON :
            begin
            if (iddig == 1'b0 ||
                bvalid_s == 1'b0)
              begin
              next_state = B_IDLE ;
              end
            else if (a_conn == 1'b1)
              begin
              next_state = B_HOST_1;
              end
            else if (a_bus_resume == 1'b1 ||
                     b_ase0_brst_tmout == 1'b1)
              begin
              next_state = B_PERIPHERAL ;
              end
            else
              begin
              next_state = B_WAIT_ACON ;
              end
            end
       B_DISCHRG1 :
            begin

            if (iddig == 1'b0 ||
                bvalid_s == 1'b1 ||
                sessend_s == 1'b1)
              begin
              next_state = B_IDLE ;
              end
            else
              begin
              next_state = B_DISCHRG1 ;
              end
            end
       default :
            begin

            if (iddig == 1'b0 ||
                tb_dischrgpls_tmout == 1'b1)
              begin
              next_state = B_IDLE ;
              end
            else
              begin
              next_state = B_DISCHRG2 ;
              end
            end
    endcase
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : STATE_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      state <= A_IDLE ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        state <= next_state ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TIMER_VBUSVLD_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      timer_vbusvld <= 15'b000_0000_0000_0000;
      end
    else
      begin
      if (forcebconn == 1'b1 || vbusvalid_s == 1'b0)
        begin
        timer_vbusvld <= 15'b000_0000_0000_0000;
        end
      else if (timer_vbusvld[14:4] != 11'b11101010011)
        begin
        timer_vbusvld <= timer_vbusvld + 1'b1;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TURSM_TMOUT_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      tursm_tmout <= 1'b0 ;
      end
    else
      begin
      if (state != A_SUSPEND && state != B_HOST_2)
        begin
        tursm_tmout <= 1'b0 ;
        end
      else if (tursm == 1'b1)
        begin
        tursm_tmout <= 1'b1 ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TBCONN_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      tbconn_tmout <= 1'b0 ;
      end
    else
      begin
      if (state != A_SUSPEND)
        begin
        tbconn_tmout <= 1'b0 ;
        end
      else if (tbconn == 1'b1)
        begin
        tbconn_tmout <= 1'b1 ;
        end
      end
    end






  always @(state_hr or state or next_state or bus_req or state_d or
           host_do_suspend or thirdresume or tbeslresume or next_state_d or
           tdrsmdn or tursm_tmout or linestate_r or linestate_r3 or speed_ff)
    begin : NEXT_STATE_HR_PROC
    case (state_hr)
        NO_RES :
            begin
            if (tursm_tmout == 1'b1 &&
                bus_req == 1'b1 &&
                 ((state == B_HOST_2  && next_state == B_HOST_1) ||
                  (state == A_SUSPEND && next_state == A_HOST)))
              begin
              next_state_hr = RES1 ;
              end
            else if (next_state_d == LPM_DRIVE_RESUME)
              begin
              next_state_hr = RES1 ;
              end
            else
              begin
              next_state_hr = NO_RES ;
              end
            end
        RES1 :
            begin
            if (tdrsmdn == 1'b1 ||

               (thirdresume == 1'b1 && state_d == LPM_DRIVE_RESUME &&
                                       host_do_suspend == 1'b0))
              begin
              next_state_hr = RES2 ;
              end
            else
              begin
              next_state_hr = RES1 ;
              end
            end
        RES2 :
            begin
            if ((linestate_r  == 2'b01 &&
                 linestate_r3 == 2'b00 && speed_ff != 2'b00) ||
                (linestate_r3 == 2'b00 && speed_ff == 2'b00))
              begin
              next_state_hr = RES3 ;
              end
            else
              begin
              next_state_hr = RES2 ;
              end
            end
        default :
            begin

            if (tbeslresume == 1'b1)
              begin
              next_state_hr = NO_RES ;
              end
            else
              begin
              next_state_hr = RES3 ;
              end
            end
    endcase
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : STATE_HR_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      state_hr <= NO_RES ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        if (usbrstsig == 1'b1 || (next_state != A_HOST && next_state != B_HOST_1))
          begin
          state_hr <= NO_RES ;
          end
        else
          begin
          state_hr <= next_state_hr ;
          end
        end
      end
    end









  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : PREV_WAIT_VRISE_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      prev_wait_vrise <= 1'b0 ;
      end
    else
      begin
      if (next_state == A_WAIT_BCON)
        begin
        if (state == A_WAIT_VRISE)
          begin
          prev_wait_vrise <= 1'b1 ;
          end
        else if (state != A_WAIT_BCON)
          begin
          prev_wait_vrise <= 1'b0 ;
          end
        end
      end
    end




































  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DOWNSTR_EN_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      downstr_en <= 1'b0 ;
      end
    else
      begin
      if (next_state == A_HOST ||
          next_state == A_SUSPEND ||
          next_state == B_HOST_2 ||
          next_state == B_HOST_1)
        begin
        downstr_en <= 1'b1 ;
        end
      else
        begin
        downstr_en <= 1'b0 ;
        end
      end
    end



  assign downstren = downstr_en ;








  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCLOCSOF_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hclocsof <= 1'b0 ;
      end
    else
      begin
      if ((next_state == A_HOST ||
           next_state == B_HOST_1) && (next_state_hr == NO_RES ||
                                       next_state_hr == RES3))
        begin
        hclocsof <= 1'b1 ;
        end
      else
        begin
        hclocsof <= 1'b0 ;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : UPSTR_EN_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      upstr_en <= 1'b0 ;
      end
    else
      begin
      if (next_state == A_PERIPHERAL ||
          next_state == B_PERIPHERAL)
        begin
        upstr_en <= 1'b1 ;
        end
      else
        begin
        upstr_en <= 1'b0 ;
        end
      end
    end



  assign upstren = upstr_en ;






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DRVVBUS_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      drvvbus <= 1'b0 ;
      end
    else
      begin
      if (state == A_WAIT_VRISE ||
          state == A_PERIPHERAL ||
          state == A_WAIT_BCON ||
          state == A_SUSPEND ||
          state == A_HOST)
        begin
        drvvbus <= 1'b1 ;
        end
      else
        begin
        drvvbus <= 1'b0 ;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : CHRGVBUS_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      chrgvbus <= 1'b0 ;
      end
    else
      begin
      if (state == B_SRP_INIT2)
        begin
        chrgvbus <= 1'b1 ;
        end
      else
        begin
        chrgvbus <= 1'b0 ;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DISCHRG_VBUS_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      dischrgvbus <= 1'b0 ;
      end
    else
      begin
      if (state == B_DISCHRG1 ||
          state == B_DISCHRG2)
        begin
        dischrgvbus <= 1'b1 ;
        end
      else
        begin
        dischrgvbus <= 1'b0 ;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LOCPULLDNDP_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      locpulldndp <= 1'b0 ;
      end
    else
      begin
      if (bc_pulldownctrl == 1'b1)
        begin
        locpulldndp <= bc_dppulldown ;
        end
      else
        begin
          if (state == A_IDLE ||
              state == A_WAIT_VRISE ||
              state == A_WAIT_BCON ||
              state == A_HOST ||
              state == A_SUSPEND ||
              state == B_IDLE ||
              state == B_WAIT_ACON ||
              state == B_HOST_1 ||
              state == B_HOST_2)
            begin
            locpulldndp <= 1'b1 ;
            end
          else
            begin
            locpulldndp <= 1'b0 ;
            end
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LOCPULLDNDM_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      locpulldndm <= 1'b0 ;
      end
    else
      begin
      if (bc_pulldownctrl == 1'b1)
        begin
        locpulldndm <= bc_dmpulldown ;
        end
      else
        begin
          if (state == A_IDLE ||
              state == A_WAIT_VRISE ||
              state == A_WAIT_BCON ||
              state == A_HOST ||
              state == A_SUSPEND ||
              state == B_IDLE ||
              state == B_WAIT_ACON ||
              state == B_HOST_1 ||
              state == B_HOST_2 ||
              state == A_PERIPHERAL ||
              state == B_PERIPHERAL)
            begin
            locpulldndm <= 1'b1 ;
            end
          else
            begin
            locpulldndm <= 1'b0 ;
            end
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TIMER_T0_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      timer_t0 <= {TIMER_T0_WIDTH{1'b0}} ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        if ((state != A_WAIT_VRISE && next_state == A_WAIT_VRISE) ||
            (state != A_WAIT_VFALL && next_state == A_WAIT_VFALL) ||
            (state != A_WAIT_BCON  && next_state == A_WAIT_BCON))
          begin
          timer_t0 <= {TIMER_T0_WIDTH{1'b0}} ;
          end
        else if (state != A_SUSPEND && next_state == A_SUSPEND)
          begin
          timer_t0 <= {TIMER_T0_WIDTH{1'b0}} ;
          end
        else if ((state != B_WAIT_ACON  && next_state == B_WAIT_ACON) ||
                 (state == B_WAIT_ACON  && linestate_r != 2'b00) ||
                  state == B_IDLE)
          begin
          timer_t0 <= {TIMER_T0_WIDTH{1'b0}} ;
          end
        else if ((state == B_SRP_INIT1 && next_state == B_SRP_INIT2) ||
                 (state == B_SRP_INIT2 && next_state == B_DISCHRG2))
          begin
          timer_t0 <= {TIMER_T0_WIDTH{1'b0}} ;
          end
        else
          begin
          timer_t0 <= timer_t0 + 1'b1 ;
          end
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TIMER_T1_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      timer_t1 <= {TIMER_T1_WIDTH{1'b0}} ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        if (state == A_SUSPEND)
          begin
          if (linestate_r == 2'b00)
            begin
            timer_t1 <= timer_t1 + 1'b1 ;
            end
          else
            begin
            timer_t1 <= {TIMER_T1_WIDTH{1'b0}} ;
            end
          end
        else if (state == A_IDLE)
          begin
          if (linestate_r == 2'b00 || linestate_r != linestate_r2)
            begin
            timer_t1 <= {TIMER_T1_WIDTH{1'b0}} ;
            end
          else
            begin
            timer_t1 <= timer_t1 + 1'b1 ;
            end
          end
        else if ((state == A_WAIT_BCON && next_state == A_HOST &&
                                          next_state_hr == NO_RES) ||
                 (state == B_WAIT_ACON && next_state == B_HOST_1))
          begin
          timer_t1 <= {TIMER_T1_WIDTH{1'b0}} ;
          end
        else if ((state == B_IDLE || state == B_DISCHRG1) &&
                 linestate_r == 2'b00 &&
                 b_se0_srp == 1'b1)
          begin
          timer_t1 <= timer_t1 ;
          end
        else if ((state == A_WAIT_BCON && linestate_r != 2'b00) ||
                 (state == B_WAIT_ACON && linestate_r[0] == 1'b1) ||
                ((state_d == LOW_SPEED ||
                  state_d == FULL_SPEED ||

                  state == B_IDLE ||
                  state == B_DISCHRG1) && linestate_r == 2'b00))
          begin
          timer_t1 <= timer_t1 + 1'b1 ;
          end
        else
          begin
          timer_t1 <= {TIMER_T1_WIDTH{1'b0}} ;
          end
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TIMER_T2_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      timer_t2 <= {TIMER_T2_WIDTH{1'b0}} ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        if (state == A_WAIT_BCON ||
            state == B_WAIT_ACON ||
           (state == A_SUSPEND && next_state != A_WAIT_BCON) ||
            state_d == PRE_SUSPEND ||
           (state == B_HOST_2  && next_state != B_PERIPHERAL) ||
           (state == B_IDLE    && vbusvalid_s == 1'b0 && otg2en == 1'b1) ||
            state_hr == RES2)
          begin
          timer_t2 <= timer_t2 + 1'b1 ;
          end
        else
          begin
          timer_t2 <= {TIMER_T2_WIDTH{1'b0}} ;
          end
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TIMER_T3_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      timer_t3 <= {TIMER_T3_WIDTH{1'b0}} ;
      end
    else
      begin
      if (workaround_otg[0] == 1'b1)
        begin
        if (prev_state == A_IDLE && state == B_IDLE && ta_wait_opmode == 1'b1)
          begin
          timer_t3 <= timer_t3 ;
          end
        else if (opmode == 2'b01 && opmode != opmode_r)
          begin
          timer_t3 <= {TIMER_T3_WIDTH{1'b0}} ;
          end
        else if (locpulldndm == 1'b1)
          begin
          if (ta_wait_opmode == 1'b0)
            begin
            if (enable_r == 1'b1)
              begin
              timer_t3 <= timer_t3 + 1'b1 ;
              end
            end
          end
        end
      else
        begin
        timer_t3 <= {TIMER_T3_WIDTH{1'b0}} ;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TIMER_T4_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      timer_t4 <= {TIMER_T4_WIDTH{1'b0}} ;
      end
    else
      begin
      if (workaround_otg[1] == 1'b1)
        begin
        if (prev_state != A_IDLE && prev_state != B_IDLE)
          begin
          timer_t4 <= timer_t4 ;
          end
        else if (locpulldndm == 1'b0)
          begin
          timer_t4 <= {TIMER_T4_WIDTH{1'b0}} ;
          end
        else
          begin
          if (ta_wait_linestate == 1'b0)
            begin
            if (enable_r == 1'b1)
              begin
              timer_t4 <= timer_t4 + 1'b1 ;
              end
            end
          end
        end
      else
        begin
        timer_t4 <= {TIMER_T4_WIDTH{1'b0}} ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : PREV_STATE_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      prev_state <= A_IDLE ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        prev_state <= state ;
        end
      end
    end






  assign a_wait_vrise_tmout = timer_t0[21] & timer_t0[19] & timer_t0[18] &
                              timer_t0[16] & timer_t0[15] & timer_t0[14] &
                              timer_t0[10] & timer_t0[9]  & timer_t0[7] ;






  assign a_wait_vfall_tmout = (forcebconn == 1'b0) ?

                               timer_t0[24] & timer_t0[23] & timer_t0[22] &
                               timer_t0[19] & timer_t0[16] & timer_t0[15] &
                               timer_t0[9]  & timer_t0[8]  & timer_t0[7] :

                               timer_t0[12] & timer_t0[10] & timer_t0[9] &
                               timer_t0[8]  & timer_t0[6]  & timer_t0[5] &
                               timer_t0[4] ;






  assign a_wait_bcon_tmout = (tawaitbcon[7] == 1'b0 &&
                              timer_t0[26:20] == tawaitbcon[6:0]) ? 1'b1 :
                                                                    1'b0 ;








  assign a_aidl_bdis_tmout =
                             (otg2en == 1'b0 &&
                              taaidlbdis[7] == 1'b0 &&
                              timer_t0[24:18] == taaidlbdis[6:0]) ? 1'b1 :
                             (otg2en == 1'b1 &&
                              a_set_b_hnp_en == 1'b1 &&
                              taaidlbdis[7] == 1'b0 &&
                              timer_t0[24:18] == taaidlbdis[6:0]) ? 1'b1 :
                                                                    1'b0 ;






  assign b_ase0_brst_tmout =
                             (forcebconn == 1'b0 && otg2en == 1'b1) ?

                              timer_t0[22] & timer_t0[18] & timer_t0[17] &
                              timer_t0[15] & timer_t0[14] & timer_t0[13] &
                              timer_t0[12] & timer_t0[10] & timer_t0[4] :


                              timer_t0[16] & timer_t0[14] & timer_t0[13] &
                              timer_t0[11] & timer_t0[10] & timer_t0[9] &
                              timer_t0[5]  & timer_t0[4]  & timer_t0[2] &
                              timer_t0[1] ;







  assign a_srp_det_filtered = timer_t1[6] & timer_t1[3] & timer_t1[1] & timer_t1[0] ;



  assign a_srp_det_10ms = timer_t1[18] &
                          timer_t1[15] & timer_t1[12] &
                          timer_t1[ 9] & timer_t1[ 8] &
                          timer_t1[ 7] & timer_t1[ 6] & timer_t1[ 5] &
                          timer_t1[ 4];








  assign ta_wait_opmode = (workaround_otg[0] == 1'b0) ? 1'b1 :
                                                        timer_t3[7] & timer_t3[4] &
                                                        timer_t3[2] & timer_t3[1] & timer_t3[0] ;





  assign ta_wait_linestate = (workaround_otg[1] == 1'b0) ? 1'b1 :
                                                           timer_t4[7] & timer_t4[4] &
                                                           timer_t4[2] & timer_t4[1] & timer_t4[0] ;






  assign ta_bcon_sdb = timer_t1[6] & timer_t1[3] & timer_t1[1] &
                       timer_t1[0] ;






  assign ta_bcon_ldb = timer_t1[21] & timer_t1[19] & timer_t1[18] &
                       timer_t1[17] & timer_t1[13] & timer_t1[12] &
                       timer_t1[11] & timer_t1[10];






  assign ta_bcon_sdb_win = timer_t2[21] & timer_t2[19] & timer_t2[18] &
                           timer_t2[16] & timer_t2[15] & timer_t2[14] &
                           timer_t2[10] & timer_t2[9]  & timer_t2[7] ;






  assign tb_acon_dbnc = timer_t1[6] & timer_t1[3] & timer_t1[1] &
                        timer_t1[0] ;






  assign tldis_dschg = timer_t2[9] & timer_t2[7] & timer_t2[6] &
                       timer_t2[5] & timer_t2[3] & timer_t2[2] &
                       timer_t2[1] ;






  assign tddis = timer_t1[6] & timer_t1[3] & timer_t1[1] &
                 timer_t1[0] ;
















  assign tursm = timer_t2[16] &
                 timer_t2[14] & timer_t2[13] &
                 timer_t2[11] & timer_t2[10] & timer_t2[9] & timer_t2[8] ;





  assign tbconn = timer_t2[16] &
                  timer_t2[15] & timer_t2[14] & timer_t2[12] &
                  timer_t2[10] & timer_t2[8] ;









  assign tsuspreq = timer_t2[16] &
                    timer_t2[14] & timer_t2[13] &
                    timer_t2[11] & timer_t2[10]  & timer_t2[9] & timer_t2[8] ;









  assign b_se0_srp =
                     (forcebconn == 1'b0 && otg2en == 1'b1) ?

                      timer_t1[24] & timer_t1[23] & timer_t1[22] &
                      timer_t1[19] & timer_t1[16] & timer_t1[15] &
                      timer_t1[9]  & timer_t1[8]  & timer_t1[7] :


                      timer_t1[15] & timer_t1[14] & timer_t1[13] &
                      timer_t1[11] & timer_t1[9]  & timer_t1[7] ;






  assign tb_data_pls = (forcebconn == 1'b1) ? (timer_t0[18:0] == TDATAPULSE_SHORT) :
                                              (timer_t0[18:0] == TDATAPULSE) ;






  assign tb_vbus_pls = (forcebconn == 1'b1) ? (timer_t0[11:0]  == 12'hCD0) :
                                              (timer_t0[22:15] == tbvbuspls) ;






  assign tb_dischrgpls_tmout = (forcebconn == 1'b1) ? (timer_t0[11:0]  == 12'hCD0) :
                                                      (timer_t0[22:15] == tbvbusdispls) ;






  assign b_ssend_srp =
                       (forcebconn == 1'b0 && otg2en == 1'b1) ?

                        timer_t2[25] & timer_t2[23] & timer_t2[21] &
                        timer_t2[19] & timer_t2[18] & timer_t2[17] &
                        timer_t2[15] & timer_t2[13] & timer_t2[10] &
                        timer_t2[8]  & timer_t2[6] :

                        timer_t2[15] & timer_t2[14] & timer_t2[13] &
                        timer_t2[11] & timer_t2[9]  & timer_t2[7] ;



















  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : B_SSEND_SRP_TMOUT_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      b_ssend_srp_tmout <= 1'b0 ;
      end
    else
      begin
      if (state != B_IDLE)
        begin
        b_ssend_srp_tmout <= 1'b0 ;
        end
      else if (b_ssend_srp == 1'b1)
        begin
        b_ssend_srp_tmout <= 1'b1 ;
        end
      end
    end







































  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TLDIS_DSCHG_TMOUT_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      tldis_dschg_tmout <= 1'b0 ;
      end
    else
      begin
      if (state != A_WAIT_BCON &&
          state != B_WAIT_ACON)
        begin
        tldis_dschg_tmout <= 1'b0 ;
        end
      else if (tldis_dschg == 1'b1)
        begin
        tldis_dschg_tmout <= 1'b1 ;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TA_BCON_SDB_WIN_TMOUT_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      ta_bcon_sdb_win_tmout <= 1'b0 ;
      end
    else
      begin
      if (state != A_WAIT_BCON)
        begin
        ta_bcon_sdb_win_tmout <= 1'b0 ;
        end
      else if (ta_bcon_sdb_win == 1'b1)
        begin
        ta_bcon_sdb_win_tmout <= 1'b1 ;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : A_CONN_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      a_conn <= 1'b0 ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        if (state == B_WAIT_ACON &&
            tb_acon_dbnc == 1'b1 &&
            tldis_dschg_tmout == 1'b1 && hostdiscon == 1'b0)
          begin
          a_conn <= 1'b1 ;
          end
        else if (state == B_IDLE ||
                 state == B_PERIPHERAL ||
               ((state_d == LOW_SPEED ||
                     state_d == FULL_SPEED
                    ) && tddis == 1'b1
                  ) ||
                  (state_d == HIGH_SPEED &&
                   hostdiscon == 1'b1
                  )
                )
          begin
          a_conn <= 1'b0 ;
          end
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : B_CONN_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      b_conn <= 1'b0 ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        case (state)

            A_WAIT_BCON :
                begin
                if (tldis_dschg_tmout == 1'b1 && hostdiscon == 1'b0)
                  begin
                  if (ta_bcon_ldb == 1'b1)
                    begin
                    b_conn <= 1'b1 ;
                    end
                  else if (ta_bcon_sdb == 1'b1 &&
                           ta_bcon_sdb_win_tmout == 1'b0)
                    begin
                    if (forcebconn == 1'b1)
                      begin
                      b_conn <= 1'b1 ;
                      end
                    else if (prev_wait_vrise == 1'b0 &&
                             workaround_otg[2] == 1'b0)
                      begin
                      b_conn <= 1'b1 ;
                      end
                    end
                  end
                end

            A_SUSPEND :
                begin


                if (state_d == HIGH_SPEED && tbconn_tmout == 1'b1)
                  begin
                  if (tddis == 1'b1)
                    begin
                    b_conn <= 1'b0 ;
                    end
                  end
                else if (state_d == LOW_SPEED ||
                         state_d == FULL_SPEED)
                  begin
                  if (tddis == 1'b1)
                    begin
                    b_conn <= 1'b0 ;
                    end
                  end
                end

            A_VBUS_ERR ,
            A_WAIT_VFALL :
                begin
                b_conn <= 1'b0 ;
                end

            default :
                begin
                if (state_hr == NO_RES)
                  begin
                  if (state_d == HIGH_SPEED && hostdiscon == 1'b1)
                    begin
                    b_conn <= 1'b0 ;
                    end
                  else if ((state_d == LOW_SPEED ||
                            state_d == FULL_SPEED) && tddis == 1'b1)
                    begin
                    b_conn <= 1'b0 ;
                    end
                  end
                end
        endcase
        end
      end
    end







  assign a_bus_resume = (linestate_r == 2'b10) ? 1'b1 :
                                                 1'b0 ;









  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DEVCONNECTED_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      devconnected <= 1'b0 ;
      end
    else
      begin
      if (a_conn == 1'b1 ||
          b_conn == 1'b1)
        begin
        devconnected <= 1'b1 ;
        end
      else
        begin
        devconnected <= 1'b0 ;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DEVCONNECTED_FF_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      devconnected_ff <= 1'b0 ;
      end
    else
      begin
      devconnected_ff <= devconnected ;
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : BSE0SRP_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      bse0srp   <= 1'b0 ;
      bse0srp_r <= 1'b0 ;
      end
    else
      begin
      if ((state == B_IDLE || state == B_DISCHRG1) &&
           b_se0_srp == 1'b1)
        begin
        bse0srp <= 1'b1 ;
        end
      else
        begin
        bse0srp <= 1'b0 ;
        end
      bse0srp_r <= bse0srp;
      end
    end





  assign otgstatus =
                                        {a_srp_det_long,
                                         iddig,
                                         vbusvalid_s,
                                         sessend_s,
                                         avalid_s,
                                         bvalid_s,
                                         devconnected,
                                         bse0srp};



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : OTGSPEED_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      otgspeed <= 3'b000 ;
      end
    else
      begin
      if (state == A_PERIPHERAL ||
          state == B_PERIPHERAL)
        begin
        if (hsmode_s == 1'b0)
          begin
          otgspeed <= 3'b010 ;
          end
        else
          begin
          otgspeed <= 3'b100 ;
          end
        end
      else if (state != A_IDLE &&
               state != B_IDLE)
        begin
        if (speed_ff == 2'b01)
          begin
          otgspeed <= 3'b010 ;
          end
        else if (speed_ff == 2'b00)
          begin
          otgspeed <= 3'b100 ;
          end
        else if (speed_ff == 2'b10)
          begin
          otgspeed <= 3'b001 ;
          end
        end
      else
        begin
        otgspeed <= 3'b000 ;
        end
      end
    end








  assign idleirq = (state == B_DISCHRG1  ||
                    state == B_DISCHRG2  ||
                    state == B_SRP_INIT1 ||
                    state == B_SRP_INIT2)                    ? 1'b0 :
             ((next_state == A_IDLE ||
               next_state == B_IDLE) && next_state != state) ? 1'b1 :
                                                               1'b0 ;





  assign srpdetirq = (state == A_IDLE && a_srp_det   == 1'b1 &&
                                         a_srp_det_r == 1'b0) ? 1'b1 :
                                                                1'b0 ;















  assign locsofirq = (devconnected == devconnected_ff)                     ? 1'b0 :
                     (state == A_PERIPHERAL || next_state == A_PERIPHERAL) ? 1'b0 :
                     (state == A_IDLE       || next_state == A_IDLE)       ? 1'b0 :
                     (state == B_IDLE       || next_state == B_IDLE)       ? 1'b0 :
                     (state == A_SUSPEND && devconnected == 1'b1)          ? 1'b0 :
                                                                             1'b1 ;







  assign vbuserrirq = (     state != A_VBUS_ERR &&
                       next_state == A_VBUS_ERR) ? 1'b1 :
                                                   1'b0 ;







  assign periphirq = ((state != A_PERIPHERAL && next_state == A_PERIPHERAL) ||
                      (state != B_PERIPHERAL && next_state == B_PERIPHERAL)) ? 1'b1 :
                                                                               1'b0 ;






  assign idchangeirq = ((state == A_IDLE && next_state == B_IDLE) ||
                        (state == B_IDLE && next_state == A_IDLE)) ? 1'b1 :
                                                                     1'b0 ;






  assign hostdisconirq = (hostdiscon & ~hostdiscon_r) ;






  assign bse0srpirq = (bse0srp & ~bse0srp_r);




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SIGRSUM_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      sigrsum_r  <= 1'b0 ;
      sigrsum_r2 <= 1'b0 ;
      end
    else
      begin
      sigrsum_r  <= sigrsum ;
      sigrsum_r2 <= sigrsum_r ;
      end
    end





  assign sigrsumclr = sigrsum_r2 ;



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SUSPREQ_ACK_FIX_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      susp_req <= 1'b0 ;
      end
    else
      begin
      if (sigrsum_r == 1'b0 && sigrsum == 1'b1)
        begin
        susp_req <= 1'b1 ;
        end
      else
        begin
        if (enable_r == 1'b1)
          begin
          susp_req <= 1'b0 ;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SIGRSUM_LATCH_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      sigrsum_latch <= 1'b0 ;
      end
    else
      begin
      if (state_u == SLEEP     || state_u == SLEEP_RESUME ||
          state_u == SUSPENDED || state_u == DRIVE_RESUME ||
          state_d == LPM_SUSPEND)
        begin
        if (sigrsum == 1'b1 || usbrstsig == 1'b1)
          begin
          sigrsum_latch <= 1'b1 ;
          end
        end
      else if ((state == A_SUSPEND ||
                state == B_HOST_2) && tursm_tmout == 1'b1)
        begin
        if (bus_req == 1'b1 || usbrstsig == 1'b1)
          begin
          sigrsum_latch <= 1'b1 ;
          end
        end
      else
        begin
        sigrsum_latch <= 1'b0 ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SUSPENDM_REQ_FF_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      suspendm_req_rr <= 1'b0 ;
      suspendm_req_r  <= 1'b1 ;
      suspendm_req_r2 <= 1'b1 ;
      suspendm_req_r3 <= 1'b1 ;
      end
    else
      begin
      suspendm_req_rr <= suspendm_req ;
      if (suspendm_req == 1'b1 &&
               sigrsum == 1'b0 &&
             usbrstsig == 1'b0 &&
        ta_wait_opmode == 1'b1 &&
           (
             (state_u == SUSPENDED   && linestate_r2 == 2'b01) ||
             (state_u == SLEEP       && linestate_r2 == 2'b01 && tfilt12_latch == 1'b1) ||
             (state_d == LPM_SUSPEND && linestate_r2 == 2'b01 && host_do_suspend == 1'b0 && tfilt12_latch == 1'b1) ||
             (state_d == LPM_SUSPEND && linestate_r2 == 2'b01 && host_do_suspend == 1'b1) ||
             (state == A_SUSPEND && tursm_tmout == 1'b1 && bus_req == 1'b0) ||
             (state == A_IDLE || state == A_WAIT_BCON || state == B_IDLE)
           )
          )
        begin
        suspendm_req_r <= 1'b0 ;
        end
      else
        begin
        suspendm_req_r <= 1'b1 ;
        end
      suspendm_req_r2 <= suspendm_req_r ;
      suspendm_req_r3 <= suspendm_req_r2 ;
      end
    end






  assign wudetector =  (state != A_IDLE       &&
                        state != A_WAIT_BCON  && state != B_IDLE)     ? 1'b0 :
                         ((wuiden_r   == 1'b1 && wakeupid == 1'b1) ||
                          (wudpen_r   == 1'b1 && wakeupdp == 1'b1) ||
                          (wuvbusen_r == 1'b1 && wakeupvbus == 1'b1)) ? 1'b1 :
                                                                        1'b0 ;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : WUDETECTOR_FF_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      wudetector_ff <= 1'b1 ;
      end
    else
      begin
      if (wudetector == 1'b1)
        begin
        wudetector_ff <= 1'b1 ;
        end
      else if (suspendm_req_r == 1'b1)
        begin
        wudetector_ff <= 1'b0 ;
        end
      end
    end






  assign wudetector_hold = wudetector | wudetector_ff ;







  assign suspendm =
                  `ifdef CDNSUSBHS_ASYNCHRONOUS_RST
                  `else
                    (`CDNSUSBHS_RESET(usbrst)) ? 1'b1 :
                  `endif
                    (suspendm_req == 1'b0 ||
                     suspendm_req_r2 == 1'b1 ||
                     suspendm_req_r3 == 1'b1 ||
                     wakeup_a == 1'b1 ||
                     sigrsum_a == 1'b1 ||
                     sigrsum_latch == 1'b1 ||
                     usbrstsig_a == 1'b1 ||
                    (otgctrl_bus_req == 1'b1 && state == A_SUSPEND) ||
                     wudetector_hold == 1'b1 ||
                    (linestate_int != 2'b01 && (state != A_IDLE &&
                                                state != A_WAIT_BCON && state != B_IDLE))) ? 1'b1 :
                                                                                             1'b0 ;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SUSPENDM_EN_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      suspendm_en <= 1'b0 ;
      end
    else
      begin





















      if (wakeup == 1'b1 ||
          sigrsum_latch == 1'b1 ||
          wudetector_hold == 1'b1)
        begin
        suspendm_en <= 1'b0 ;
        end
      else if (state == A_IDLE ||

              (state == A_WAIT_BCON  && next_state == A_WAIT_BCON) ||
               state == A_SUSPEND ||
               state == B_IDLE ||
               state == B_HOST_2)
        begin
        suspendm_en <= 1'b1 ;
        end
      else if (state_u == SUSPENDED ||
               state_u == SLEEP ||
               state_u == WAIT_FILT || next_state_u == WAIT_FILT ||
               state_u == DETECT_SE0 ||
               state_d == LPM_SUSPEND)





        begin
        suspendm_en <= 1'b1 ;
        end
      else if (state == next_state)
        begin
        suspendm_en <= 1'b0 ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBRSTSIG_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usbrstsig_r  <= 1'b0 ;
      usbrstsig_r2 <= 1'b0 ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        usbrstsig_r  <= usbrstsig ;
        usbrstsig_r2 <= usbrstsig_r ;
        end
      end
    end





  assign usbrstsigclr = usbrstsig_r2 ;





  assign hrstsig = usbrstsig_r & ~(usbrstsig_r2);



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBRSTSIG16MS_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usbrstsig16ms_r <= 1'b0 ;
      end
    else
      begin
      if (usbrstsig == 1'b1 && usbrstsig_r == 1'b0)
        begin
        usbrstsig16ms_r <= usbrstsig16ms ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBRSTSIG55MS_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usbrstsig55ms_r  <= 1'b1 ;
      end
    else
      begin
      if (usbrstsig == 1'b1 && usbrstsig_r == 1'b0)
        begin
        usbrstsig55ms_r <= usbrstsig55ms ;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : WAKESRC_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      wakesrc <= 1'b0 ;
      end
    else
      begin
      if (state_d == LPM_SUSPEND ||
          state_u == SLEEP ||
          state_u == SUSPENDED)
        begin
        if (wakeup_r == 1'b1 || sigrsum_latch == 1'b1)
          begin
          wakesrc <= 1'b1 ;
          end
        else
          begin
          wakesrc <= 1'b0 ;
          end
        end
      else if ((state == A_SUSPEND ||
                state == B_HOST_2) && tursm_tmout == 1'b1)
        begin
        if (wakeup_r == 1'b1 || sigrsum_latch == 1'b1 || bus_req == 1'b1)
          begin
          wakesrc <= 1'b1 ;
          end
        else
          begin
          wakesrc <= 1'b0 ;
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : WAKEUP_REG_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      wakeup_r <= 1'b0 ;
      end
    else
      begin
      wakeup_r <= wakeup ;
      end
    end







  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : WAKEUPREQ_FF_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      wakeupreq_ff  <= 1'b0 ;
      wakeupreq_ff1 <= 1'b0 ;
      end
    else
      begin
      if ((state != A_PERIPHERAL   && state != B_PERIPHERAL &&
           state != B_HOST_1       && state != B_HOST_2 &&
           state != A_HOST         && state != A_SUSPEND) ||
          (state == A_SUSPEND && next_state == A_PERIPHERAL) ||
          (state == B_HOST_1  && next_state == B_PERIPHERAL) ||
          (state == B_HOST_2  && next_state == B_PERIPHERAL))
         begin
         wakeupreq_ff  <= 1'b0 ;
         wakeupreq_ff1 <= 1'b0 ;
         end
      else if ((state   == A_SUSPEND && tursm_tmout == 1'b1) ||
               (state   == B_HOST_2  && tursm_tmout == 1'b1) ||
                state_d == LPM_SUSPEND ||
                state_u == SLEEP       ||
                state_u == SUSPENDED)
        begin

        if (wakeup == 1'b0 && sigrsum_latch == 1'b0 && linestate_r2 == 2'b01)
          begin
          wakeupreq_ff  <= 1'b1;
          wakeupreq_ff1 <= 1'b1;
          end
        else if (wakeupreq_ff  == 1'b0 &&
                 wakeupreq_ff1 == 1'b0 && susp_set == 1'b1)
          begin
          wakeupreq_ff  <= 1'b0;
          wakeupreq_ff1 <= 1'b1;
          end
        else if ((state == A_SUSPEND ||
                  state == B_HOST_2) && linestate_r2 == 2'b10)
          begin
          wakeupreq_ff  <= 1'b0;
          wakeupreq_ff1 <= wakeupreq_ff;
          end
        else if (wakeup == 1'b1 || sigrsum_latch == 1'b1)
          begin
          wakeupreq_ff  <= 1'b0;
          wakeupreq_ff1 <= wakeupreq_ff;
          end
        end
      else if (state   == A_HOST ||
               state   == B_HOST_1 ||
               state_u == RESUME ||
               state_u == HANDSHAKE ||
               state_d == LPM_DRIVE_RESUME)
        begin

        wakeupreq_ff  <= 1'b0;
        wakeupreq_ff1 <= wakeupreq_ff;
        end




      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : WUINTREQ_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      wuintreq <= 1'b0 ;
      end
    else
      begin
      if (suspendm_req == 1'b1 && suspendm_req_rr == 1'b0)
        begin

        wuintreq <= 1'b0 ;
        end
      else if (state != A_PERIPHERAL && state != B_PERIPHERAL &&
               state != A_HOST       && state != A_SUSPEND &&
               state != B_HOST_1     && state != B_HOST_2)
        begin

        wuintreq <= 1'b0 ;
        end
      else if (state_u == TIMERRESET ||
               state_u == HIGH_SPEED_U)
        begin

        wuintreq <= 1'b0 ;
        end
      else if ((state_d == LOW_SPEED  ||
                state_d == FULL_SPEED ||
                state_d == HIGH_SPEED) && state_hr == NO_RES && state != A_SUSPEND &&
                                                                state != B_HOST_2 && usbrstsig == 1'b0)
        begin

        wuintreq <= 1'b0 ;
        end
      else if (state_u == RESUME && next_state_u == SLEEP)
        begin

        wuintreq <= 1'b0 ;
        end
      else if (wakeupreq_ff == 1'b0 && wakeupreq_ff1 == 1'b1)
        begin

        wuintreq <= 1'b1 ;
        end
      end
    end







  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DISPERRESET_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      disperreset <= 1'b0 ;
      end
    else
      begin
      if (state == A_SUSPEND ||
          state == B_IDLE ||
          state == B_HOST_1)
        begin
        disperreset <= 1'b1 ;
        end
      else if (state == A_PERIPHERAL ||
               state == B_PERIPHERAL)
        begin
        if (linestate_j == 1'b1)
          begin
          disperreset <= 1'b0 ;
          end
        end
      else
        begin
        disperreset <= 1'b0 ;
        end
      end
    end







  always @(state_u or linestate_r or count or susp_set or wakeup_set or
           status or tfiltse0 or tfilt or tstatej or twtrstfs_se0 or twtrstfs_j or
           tuch or twtfs or twtrev or twtrsths or tfilt12_latch or tdrsmup_5u or testmode or
           disperreset or lpm_sleep_req or sleepm_mode or tdevdrvresume_5u)
    begin : NEXT_STATE_COMB_PROC

    suspend_r    = 1'b0 ;
    inc          = 1'b0 ;
    count_rst    = 1'b0 ;
    count_tmr_t0 = 1'b0 ;

    case (state_u)



        DISABLED_U :
            begin
            next_state_u = TIMERRESET ;
            end
        HIGH_SPEED_U :
            begin
            if (linestate_r == 2'b00)
              begin
              next_state_u = HIGH_SPEED_SE0 ;
              end
            else
              begin
              next_state_u = HIGH_SPEED_U ;
              end
            end
        HIGH_SPEED_SE0 :
            begin
            if (testmode == 1'b1)
              begin
              next_state_u = HIGH_SPEED_U ;
              end
            else if (lpm_sleep_req == 1'b1)
              begin
              next_state_u = SLEEP;
              end
            else if (linestate_r == 2'b00)
              begin
              if (twtrev == 1'b1)
                begin
                next_state_u = REMOVE_HS ;
                end
              else
                begin
                next_state_u = HIGH_SPEED_SE0 ;
                end
              end
            else
              begin
              next_state_u = HIGH_SPEED_U ;
              end
            end
        REMOVE_HS :
            begin
            if (twtrsths == 1'b1)
              begin
              if (linestate_r == 2'b00)
                begin
                next_state_u = HANDSHAKE ;
                end
              else
                begin
                next_state_u = SUSPENDED ;
                end
              end
            else
              begin
              next_state_u = REMOVE_HS ;
              end
            end



        SUSPENDED :
            begin
            suspend_r = 1'b1 ;
            if (linestate_r == 2'b00)
              begin
              next_state_u = WAIT_FILT ;
              end
            else
              begin
              if (linestate_r == 2'b10)
                begin
                next_state_u = RESUME ;
                end
              else
                begin
                if (linestate_r == 2'b01 &&
                    susp_set == 1'b1 &&
                    wakeup_set == 1'b1)
                  begin
                  next_state_u = DRIVE_RESUME ;
                  end
                else
                  begin
                  next_state_u = SUSPENDED ;
                  end
                end
              end
            end
        WAIT_FILT :
            begin
            count_tmr_t0 = 1'b1 ;
            next_state_u = DETECT_SE0 ;
            end
        DETECT_SE0 :
            begin
            if (linestate_r != 2'b00)
              begin
              if (sleepm_mode == 1'b1)
                begin
                next_state_u = SLEEP ;
                end
              else
                begin
                next_state_u = SUSPENDED ;
                end
              end
            else if (tfiltse0 == 1'b1)
              begin
              next_state_u = HANDSHAKE ;
              end
            else
              begin
              next_state_u = DETECT_SE0 ;
              end
            end



        HANDSHAKE :
            begin
            count_rst = 1'b1 ;
            count_tmr_t0 = 1'b1 ;
            if (tuch == 1'b1)
              begin
              next_state_u = DETECT_HSK ;
              end
            else
              begin
              next_state_u = HANDSHAKE ;
              end
            end
        DETECT_HSK :
            begin
            count_tmr_t0 = 1'b1 ;
            if (twtfs == 1'b1)
              begin
              next_state_u = WAIT_END_RESET ;
              end
            else
              begin
              if (tfilt == 1'b1)
                begin
                next_state_u = DETECT_HSJ ;
                end
              else
                begin
                next_state_u = DETECT_HSK ;
                end
              end
            end
        DETECT_HSJ :
            begin
            count_tmr_t0 = 1'b1 ;
            if (twtfs == 1'b1)
              begin
              next_state_u = WAIT_END_RESET ;
              end
            else
              begin
              if (tfilt == 1'b1)
                begin
                if (count >= 2'b10)
                  begin
                  next_state_u = HIGH_SPEED_U ;
                  end
                else
                  begin
                  next_state_u = INCREASE ;
                  end
                end
              else
                begin
                next_state_u = DETECT_HSJ ;
                end
              end
            end
        INCREASE :
            begin
            inc = 1'b1 ;
            count_tmr_t0 = 1'b1 ;
            next_state_u = DETECT_HSK ;
            end
        WAIT_END_RESET :
            begin
            if (tstatej == 1'b1)
              begin
              next_state_u = TIMERRESET ;
              end
            else
              begin
              next_state_u = WAIT_END_RESET ;
              end
            end



        DRIVE_RESUME :
            begin
            if (tdrsmup_5u == 1'b1)
              begin
              next_state_u = RESUME ;
              end
            else
              begin
              next_state_u = DRIVE_RESUME ;
              end
            end



        RESUME :
            begin
            if (linestate_r == 2'b10)
              begin
              next_state_u = RESUME ;
              end
            else
              begin
              if (linestate_r == 2'b00)
                begin
                if (status == 1'b0)
                  begin
                  next_state_u = TIMERRESET ;
                  end
                else
                  begin
                  next_state_u = HIGH_SPEED_U ;
                  end
                end
              else
                begin

                if (sleepm_mode == 1'b1)
                  begin
                  next_state_u = SLEEP ;
                  end
                else
                  begin
                  if (twtrev == 1'b1)
                    begin
                    next_state_u = SUSPENDED ;
                    end
                  else
                    begin
                    next_state_u = RESUME ;
                    end
                  end
                end
              end
            end



        SE0_STATE :
            begin
            if (linestate_r == 2'b00)
              begin
              if (twtrstfs_se0 == 1'b1 &&
                  disperreset == 1'b0)
                begin
                next_state_u = HANDSHAKE ;
                end
              else
                begin
                next_state_u = SE0_STATE ;
                end
              end
            else
              begin
              if (linestate_r == 2'b01)
                begin
                next_state_u = J_STATE ;
                end
              else
                begin
                next_state_u = TIMERRESET ;
                end
              end
            end
        J_STATE :
            begin
            if (lpm_sleep_req == 1'b1)
              begin
              next_state_u = SLEEP;
              end
            else
              begin
              if (linestate_r == 2'b01)
                begin
                if (twtrstfs_j == 1'b1)
                  begin
                  next_state_u = SUSPENDED ;
                  end
                else
                  begin
                  next_state_u = J_STATE ;
                  end
                end
              else
                begin
                if (linestate_r == 2'b00)
                  begin
                  next_state_u = SE0_STATE ;
                  end
                else
                  begin
                  next_state_u = TIMERRESET ;
                  end
                end
              end
            end




        SLEEP :
            begin
            if (tfilt12_latch == 1'b0)
              begin
              next_state_u = SLEEP;
              end
            else if (linestate_r == 2'b00)
              begin
              next_state_u = WAIT_FILT;
              end
            else
              begin
              if (linestate_r == 2'b10)
                begin
                next_state_u = RESUME;
                end
              else
                begin
                if (linestate_r == 2'b01 &&
                    susp_set &&
                    wakeup_set)
                  begin
                  next_state_u = SLEEP_RESUME;
                  end
                else
                  begin
                  next_state_u = SLEEP;
                  end
                end
              end
            end




        SLEEP_RESUME :
            begin
            if (tdevdrvresume_5u == 1'b1)
              begin
              next_state_u = RESUME;
              end
            else
              begin
              next_state_u = SLEEP_RESUME;
              end
            end

        default :
            begin
            if (linestate_r == 2'b00)
              begin
              next_state_u = SE0_STATE ;
              end
            else
              begin

              if (linestate_r == 2'b01)
                begin
                next_state_u = J_STATE ;
                end
              else
                begin
                next_state_u = TIMERRESET ;
                end
              end
            end
    endcase
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : RESET_DETECTION_STATE_DIAGRAM_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      state_u <= DISABLED_U ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        if (upstr_en == 1'b0)
          begin
          state_u <= DISABLED_U ;
          end
        else
          begin
          state_u <= next_state_u ;
          end
        end
      end
    end

  `ifdef CDNSUSBHS_LPM_ENABLE


  assign lpm_enable_r = (state_u == SLEEP) ? 1'b1 :
                                             1'b0 ;
  `endif

  `ifdef CDNSUSBHS_LPM_ENABLE
  `else


  assign sleep_r = (state_u == SLEEP && tfilt12_latch == 1'b1) ? 1'b0 :
                                                                 1'b1 ;
  `endif

  `ifdef CDNSUSBHS_LPM_ENABLE


  assign lpm_enableh_r = (state_d == LPM_SUSPEND) ? 1'b1 :
                                                    1'b0 ;
  `endif

  `ifdef CDNSUSBHS_LPM_ENABLE
  `else


  assign sleeph_r = (state_d == LPM_SUSPEND && tfilt12_latch == 1'b1) ? 1'b0 :
                                                                        1'b1 ;
  `endif




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : REGISTER_SLEEPREQ_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      sleepreq <= 1'b0 ;
      end
    else
      begin
      if (state_u == SLEEP || state_d == LPM_SUSPEND)
        begin
        sleepreq <= 1'b1 ;
        end
      else
        begin
        sleepreq <= 1'b0 ;
        end
      end
    end

  `ifdef CDNSUSBHS_LPM_ENABLE
































  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LPM_ENABLE_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      lpm_enable <= 1'b0 ;
      end
    else
      begin
      if (host_do_suspend == 1'b1)
        begin
        lpm_enable <= 1'b0;
        end
      else
        begin
        if (lpm_auto_entry == 1'b1)
          begin
          lpm_enable <= lpm_enable_r | lpm_enableh_r;
          end
        else if (sleepm_req == 1'b1)
          begin
          lpm_enable <= lpm_enable_r | lpm_enableh_r;
          end
        else
          begin
          lpm_enable <= 1'b0;
          end
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_LPM_ENABLE
  `else



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SLEEP_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      sleep_ff <= 1'b1 ;
      end
    else
      begin
      if (host_do_suspend == 1'b1 ||
          wakeup == 1'b1 ||
          sigrsum_latch == 1'b1 ||
          linestate_int != 2'b01)
        begin
        sleep_ff <= 1'b1 ;
        end
      else
        begin
        if (lpm_auto_entry == 1'b1)
          begin
          sleep_ff <= sleep_r & sleeph_r;
          end
        else if (sleepm_req == 1'b1)
          begin
          sleep_ff <= sleep_r & sleeph_r;
          end
        else
          begin
          sleep_ff <= 1'b1;
          end
        end
      end
    end
  `endif




  `ifdef CDNSUSBHS_LPM_ENABLE
  assign sleepm = ~lpm_enable ;
  `else
  assign sleepm =
                `ifdef CDNSUSBHS_ASYNCHRONOUS_RST
                `else
                  (`CDNSUSBHS_RESET(usbrst))   ? 1'b1 :
                `endif
                  (wakeup_a == 1'b1 ||
                   sigrsum_a == 1'b1 ||
                   sigrsum_latch == 1'b1 ||
                   usbrstsig_a == 1'b1 ||
                   linestate_int != 2'b01)     ? 1'b1 :
                                                 sleep_ff ;
  `endif





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SLEEPM_EN_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      sleepm_en <= 1'b0 ;
      end
    else
      begin












    `ifdef CDNSUSBHS_LPM_ENABLE
      sleepm_en <= lpm_enable_r | lpm_enableh_r ;
    `else
      if (wakeup == 1'b1 ||
          sigrsum_latch == 1'b1)
        begin
        sleepm_en <= 1'b0 ;
        end
      else if (state_u == SLEEP ||
               state_u == WAIT_FILT ||
               state_u == DETECT_SE0 ||
              (state_d == LPM_SUSPEND && host_do_suspend == 1'b0))
        begin
        sleepm_en <= 1'b1 ;
        end
      else
        begin
        sleepm_en <= 1'b0 ;
        end
    `endif
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SLEEPM_MODE_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      sleepm_mode <= 1'b0 ;
      end
    else
      begin
      if (state_u == SLEEP)
        begin
        sleepm_mode <= 1'b1;
        end
      else if (state_u == SUSPENDED)
        begin
        sleepm_mode <= 1'b0;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LPMIRQ_RETRY_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      lpmirq_retry <= 1'b0 ;
      end
    else
      begin
      if (state_u == RESUME && next_state_u == SLEEP)
        begin
        lpmirq_retry <= 1'b1 ;
        end
      else
        begin
        lpmirq_retry <= 1'b0 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TFILT12_LATCH_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      tfilt12_latch <= 1'b0 ;
      end
    else
      begin
      if (host_do_suspend == 1'b1 || (downstr_en == 1'b1 && speed_ff != 2'b00))
        begin
        tfilt12_latch <= 1'b1;
        end

      else if (state_u != SLEEP &&
               state_u != WAIT_FILT &&
               state_u != DETECT_SE0 && state_d != LPM_SUSPEND)
        begin
        tfilt12_latch <= 1'b0;
        end
      else if (tfilt12 == 1'b1)
        begin
        tfilt12_latch <= 1'b1;
        end
      end
    end






  assign lpmstate_w = (state_d == PRE_SUSPEND ||
                       state_d == LPM_SUSPEND ||
                       state_d == LPM_DRIVE_RESUME) ? 1'b1 :
                                                      1'b0 ;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LPMSTATE_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      lpmstate <= 1'b0 ;
      end
    else
      begin
      lpmstate <= lpmstate_w;
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LPMSTATE_BESL_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      lpmstate_besl <= 1'b0 ;
      end
    else
      begin
      if (state_hr == RES3)
        begin
        lpmstate_besl <= 1'b1;
        end
      else
        begin
        lpmstate_besl <= 1'b0;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : REGISTER_SUSPREQ_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      suspreq <= 1'b0 ;
      end
    else
      begin
      if (b_bus_suspend == 1'b1 && state == A_PERIPHERAL)
        begin
        suspreq <= 1'b0 ;
        end
      else if (host_do_suspend == 1'b1)
        begin
        if (state_d == LPM_SUSPEND)
          begin
          suspreq <= 1'b1;
          end
        else
          begin
          suspreq <= 1'b0;
          end
        end
      else if (upstr_en == 1'b1)
        begin
        suspreq <= suspend_r;
        end
      else if (tursm_tmout == 1'b1)
        begin
        suspreq <= 1'b1;
        end
      else
        begin
        suspreq <= 1'b0;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : IDDIG_FILTERED_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      iddig_r  <= 1'b0 ;
      iddig_r2 <= 1'b0 ;
      iddig_r3 <= 1'b0 ;
      end
    else
      begin
      iddig_r  <= 1'b1 ;
      iddig_r2 <= iddig_r ;
      if (enable_r == 1'b1)
        begin
        iddig_r3 <= iddig_r2 ;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : OPMODE_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      opmode <= 2'b01 ;
      end
    else
      begin
      if (iddig_r3 == 1'b0)
        begin
        opmode <= 2'b01 ;
        end
      else if (state == B_IDLE)
        begin
        if (next_state == B_PERIPHERAL)
          begin
          opmode <= 2'b00 ;
          end
        else if (next_state == B_IDLE)
          begin
          opmode <= 2'b01 ;
          end
        else if (ta_wait_opmode == 1'b1)
          begin
          opmode <= 2'b10 ;
          end
        end
      else if (state == A_IDLE)
        begin
        if (ta_wait_opmode == 1'b1)
          begin
          opmode <= 2'b10 ;
          end
        end
      else if (state == A_WAIT_VRISE ||
               state == A_WAIT_BCON ||
              (state == A_WAIT_VFALL && iddig == 1'b1) ||
               state == B_WAIT_ACON)
        begin
        opmode <= 2'b10 ;
        end





      else if (state_d == DDRIVE_SE0 ||
               state_d == CLR_TIMER1 ||
               state_d == RUN_TIMER1 ||
               state_d == WAITD ||
               state_d == DR_CHIRP_J ||
               state_d == DR_CHIRP_K ||
               state_d == DRIVE_SE0_HS ||
               state_d == LPM_DRIVE_RESUME)
        begin
        opmode <= 2'b10 ;
        end
      else if (state_u == HANDSHAKE ||
               state_u == DRIVE_RESUME ||
               state_u == SLEEP_RESUME ||
               state_u == DETECT_HSJ ||
               state_u == DETECT_HSK ||
               state_u == INCREASE)
        begin
        opmode <= 2'b10 ;
        end
      else if (state_hr == RES1 ||
               state_hr == RES2)
        begin
        opmode <= 2'b10 ;
        end
      else if (testmode == 1'b1 &&
              (testmodesel == 2'b00 || testmodesel == 2'b01))
        begin
        opmode <= 2'b10 ;
        end
      else if (state_d == DISABLED &&
               state_u == DISABLED_U &&
               state != B_PERIPHERAL &&
               state != B_SRP_INIT1 &&
               state != B_HOST_2)
        begin
        opmode <= 2'b01 ;
        end
      else
        begin
        opmode <= 2'b00 ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : OPMODE_R_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      opmode_r <= 2'b01 ;
      end
    else
      begin
      opmode_r <= opmode ;
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TERMSELECT_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      termselect <= 1'b1 ;
      end
    else
      begin
      if (state_hr == RES1 ||
          state_hr == RES2)
        begin
        termselect <= 1'b1 ;
        end
      else if (state_d == DDRIVE_SE0 ||
               state_d == CLR_TIMER1 ||
               state_d == RUN_TIMER1 ||
               state_d == WAITD ||
               state_d == DR_CHIRP_J ||
               state_d == DR_CHIRP_K ||
               state_d == DRIVE_SE0_HS ||
              (downstr_en == 1'b1 &&
               state_d == HIGH_SPEED && state != A_SUSPEND && state != B_HOST_2) ||
               state_u == HIGH_SPEED_U ||
               state_u == HIGH_SPEED_SE0)
        begin
        termselect <= 1'b0 ;
        end
      else
        begin
        termselect <= 1'b1 ;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : XCVRSELECT_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      xcvrselect <= 2'b01 ;
      end
    else
      begin
      if ((state_hr == RES1 ||
           state_hr == RES2) && state_d != LOW_SPEED && speed_ff != 2'b10)
        begin
        xcvrselect <= 2'b01 ;
        end
      else if (state_u == HIGH_SPEED_U ||
               state_u == HIGH_SPEED_SE0 ||
               state_u == HANDSHAKE ||
               state_u == DETECT_HSK ||
               state_u == DETECT_HSJ ||
               state_u == INCREASE ||
               state_d == DDRIVE_SE0 ||
               state_d == CLR_TIMER1 ||
               state_d == RUN_TIMER1 ||
               state_d == WAITD ||
               state_d == DR_CHIRP_J ||
               state_d == DR_CHIRP_K ||
               state_d == DRIVE_SE0_HS ||
              (downstr_en == 1'b1 &&
               state_d == HIGH_SPEED && state != A_SUSPEND && state != B_HOST_2))
        begin
        xcvrselect <= 2'b00 ;
        end
      else if (state_d == LOW_SPEED || speed_ff == 2'b10)
        begin
        xcvrselect <= 2'b10 ;
        end
      else
        begin
        xcvrselect <= 2'b01 ;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DRIVECHIRPJ_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      drivechirpj <= 1'b0 ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin


        if (state_d == DR_CHIRP_J)
          begin
          drivechirpj <= 1'b1;
          end
        else
          begin
          drivechirpj <= 1'b0;
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DISDRIVECHIRPK_R_K_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      disdrivechirpk_r <= 1'b0 ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        if (state_u == SE0_STATE ||
            state_u == DETECT_SE0)
          begin
          disdrivechirpk_r <= 1'b1 ;
          end
        else if (state_u == HANDSHAKE && twaitchk == 1'b1)
          begin
          disdrivechirpk_r <= 1'b0 ;
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DRIVECHIRPK_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      drivechirpk <= 1'b0 ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        if (state_d  == DR_CHIRP_K ||
           (state_u  == HANDSHAKE && hsdisable_s == 1'b0 && disdrivechirpk_r == 1'b0) ||
            state_u  == DRIVE_RESUME ||
            state_u  == SLEEP_RESUME ||

            state_hr == RES1)
          begin
          drivechirpk <= 1'b1 ;
          end
        else
          begin
          drivechirpk <= 1'b0 ;
          end
        end
      end
    end













  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : REGISTER_RESUME_REQUEST_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      resumereq <= 1'b0 ;
      end
    else
      begin
      if ((next_state_u == DRIVE_RESUME && state_u != DRIVE_RESUME) ||
          (next_state_u == SLEEP_RESUME && state_u != SLEEP_RESUME) ||
          (next_state_u == HANDSHAKE    && state_u != HANDSHAKE))
        begin
        resumereq <= 1'b1 ;
        end
      else if ((next_state_d == DR_CHIRP_J && state_d != DR_CHIRP_J) ||
               (next_state_d == DR_CHIRP_K && state_d != DR_CHIRP_K))
        begin
        resumereq <= 1'b1 ;
        end
      else if (state_hr == RES1)
        begin
        resumereq <= 1'b1 ;
        end
      else if ((state_u == DRIVE_RESUME && tdrsmup == 1'b1) ||
               (state_u == SLEEP_RESUME && tdevdrvresume == 1'b1) ||
                 (state_u != DRIVE_RESUME &&
                  state_u != SLEEP_RESUME &&
                  state_u != HANDSHAKE    &&
                  state_d != DR_CHIRP_J   &&
                  state_d != DR_CHIRP_K))
        begin
        resumereq <= 1'b0 ;
        end
      end
    end





  assign usbreset_s = (state_d == DDRIVE_SE0 ||
                       state_d == CLR_TIMER1 ||
                       state_d == RUN_TIMER1 ||
                       state_d == WAITD ||
                       state_d == DEV_DET ||
                       state_d == DR_CHIRP_J ||
                       state_d == DR_CHIRP_K ||
                       state_d == DRIVE_SE0_HS ||
                       state_u == HANDSHAKE ||
                       state_u == DETECT_HSK ||
                       state_u == DETECT_HSJ ||
                       state_u == INCREASE) ? 1'b1 :
                                              1'b0 ;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBRESET_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usbreset <= 1'b0 ;
      end
    else
      begin
      usbreset <= usbreset_s ;
      end
    end



  assign usbresetirq = (upstr_en == 1'b1) ?

                                  ( usbreset_s & ~usbreset) :

                                  (~usbreset_s &  usbreset) ;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : COUNT_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      count <= {2{1'b0}} ;
      end
    else
      begin
      if (count_rst == 1'b1)
        begin
        count <= {2{1'b0}} ;
        end
      else
        begin
        if (inc == 1'b1)
          begin
          if (enable_r == 1'b1)
            begin
            count <= count + 1'b1 ;
            end
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : RESTORE_MODE_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      status <= 1'b0 ;
      end
    else
      begin
      if (((twtrsths == 1'b1 && linestate_r == 2'b01) ||
            lpm_sleep_req == 1'b1) && state_u == J_STATE)
        begin

        status <= 1'b0 ;
        end
      else
        begin
        if ((twtrsths == 1'b1 && linestate_r != 2'b00 && state_u == REMOVE_HS) ||
            (lpm_sleep_req == 1'b1 && state_u == HIGH_SPEED_SE0))
          begin


          status <= 1'b1 ;
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : BUSTIMEOUT_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      bustimeout <= 1'b0 ;
      end
    else
      begin
      if (((state_d == HIGH_SPEED ||
            state_u == HIGH_SPEED_U ||
            state_u == HIGH_SPEED_SE0) && linestate_r != 2'b00) ||
        ((~(state_d == HIGH_SPEED ||
            state_u == HIGH_SPEED_U ||
            state_u == HIGH_SPEED_SE0)) && linestate_r != 2'b01))
        begin
        bustimeout <= 1'b0 ;
        end


      else if ((state_u == HIGH_SPEED_SE0 && touths  == 1'b1) ||
               (state_u == J_STATE        && toutfs  == 1'b1))
        begin
        bustimeout <= 1'b1 ;
        end



      else if ((state_d == HIGH_SPEED     && touthhs == 1'b1) ||
               (state_d == FULL_SPEED     && touthfs == 1'b1) ||
               (state_d == LOW_SPEED      && touthls == 1'b1))
        begin
        bustimeout <= 1'b1 ;
        end
      end
    end





  assign timeout = bustimeout ;






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DETECT_WAKEUP_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      wakeup_set <= 1'b0 ;
      end
    else
      begin
      if ((state_u == RESUME && (linestate_r == 2'b00 ||
                                (linestate_r == 2'b01 && (sleepm_mode == 1'b1 || twtrev == 1'b1)) ||
                                 linestate_r == 2'b10)) ||
          (state_d != LPM_SUSPEND &&
           state_d != LPM_DRIVE_RESUME && downstr_en == 1'b1))
        begin
        wakeup_set <= 1'b0 ;
        end
      else
        if (
            ((sigrsum == 1'b1 && (state_u == SUSPENDED || state_u == SLEEP))) ||

            (sigrsum == 1'b1 && downstr_en == 1'b1))
        begin


        wakeup_set <= 1'b1 ;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DETECT_TIME_SUSPENDED_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      susp_set <= 1'b0 ;
      end
    else
      begin
      if (
          state_u == TIMERRESET   ||
          state_u == HIGH_SPEED_U ||

          state_d == FULL_SPEED   ||
          state_d == HIGH_SPEED   ||
          state_d == LOW_SPEED)
        begin
        susp_set <= 1'b0 ;
        end
      else
        begin
        if (
            (state_u == SUSPENDED   && twtrsm        == 1'b1) ||
            (state_u == SLEEP       && tdevdrvresume == 1'b1) ||

            (state_d == LPM_SUSPEND && twtrsm        == 1'b1))
          begin

          susp_set <= 1'b1 ;
          end
        end
      end
    end





  assign clr_tmr_t0 = (state_u == next_state_u) ? 1'b0 :
                                                  1'b1 ;





  assign tfiltse0 = timerp_t1[6] & timerp_t1[3] & timerp_t1[1] ;





  assign tfiltjk = timerp_t2[6] & timerp_t2[3] & timerp_t2[2];





  assign tfilt25 = timerp_t1[9] & timerp_t1[7] & timerp_t1[6] &
                   timerp_t1[5] & timerp_t1[4] & timerp_t1[3];





  assign tfilt12  = timerp_t1[8] & timerp_t0[6] & timerp_t0[5] &
                    timerp_t1[4] & timerp_t0[3] & timerp_t0[2];





  assign tfilt = timerp_t1[6] & timerp_t1[3] & timerp_t1[2] ;




  assign tstatej = timerp_t1[6] & timerp_t1[5] & timerp_t1[4] &
                   timerp_t1[3] & timerp_t1[2] & timerp_t1[1];





  assign twtrstfs_se0 = timerp_t0[6] & timerp_t0[3] & timerp_t0[0] ;





  assign twtrstfs_j =
                      (tsmode[1] == 1'b1) ?
                      timerp_t0[6]  & timerp_t0[5] & timerp_t0[2] :

                      timerp_t0[16] & timerp_t0[15] ;





  assign tuch =
                (tsmode[1] == 1'b1 ||
                 tsmode[0] == 1'b1) ?
                timerp_t0[6]  & timerp_t0[5]  & timerp_t0[2] :

                timerp_t0[15] & timerp_t0[11] & timerp_t0[9] &
                timerp_t0[8];




  assign twaitchk =
                    (tsmode[1] == 1'b1 ||
                     tsmode[0] == 1'b1) ?
                    timerp_t0[4]  & timerp_t0[3] & timerp_t0[2] &
                    timerp_t0[1] :

                    timerp_t0[11] & timerp_t0[8] & timerp_t0[6] &
                    timerp_t0[5] ;





  assign twtfs =
                 (tsmode[1] == 1'b1 ||
                  tsmode[0] == 1'b1) ?
                 timerp_t0[9]  & timerp_t0[8]  & timerp_t0[7] &
                 timerp_t0[6]  & timerp_t0[5]  & timerp_t0[3] :

                 timerp_t0[16] & timerp_t0[15] & timerp_t0[12] &
                 timerp_t0[11] & timerp_t0[9]  & timerp_t0[2]  &
                 timerp_t0[1] ;





  assign twtrev =
                  (tsmode[1] == 1'b1) ?
                  timerp_t0[6]  & timerp_t0[5]  & timerp_t0[2]  :

                  timerp_t0[16] & timerp_t0[14] & timerp_t0[13] ;





  assign twtrsths =
                    (tsmode[1] == 1'b1) ?
                    timerp_t0[6]  & timerp_t0[5]  & timerp_t0[2] :

                    timerp_t0[14] & timerp_t0[12] & timerp_t0[11] &
                    timerp_t0[10] ;





  assign touths = timerp_t0[5] & timerp_t0[4] ;





  assign toutfs = timerp_t0[5] & timerp_t0[3] ;





  assign touthhs = timerp_t0[5] & timerp_t0[4] ;





  assign touthfs = timerp_t0[5] & timerp_t0[4] ;





  assign touthls = timerp_t0[8] & timerp_t0[7] ;





  assign twtrsm =
                  (downstr_en == 1'b1) ?
                  timerp_t0[10] & timerp_t0[9] & timerp_t0[8] &
                  timerp_t0[3] :

                  (tsmode[1] == 1'b1)  ?
                  timerp_t0[6]  & timerp_t0[5]  & timerp_t0[2]  :

                  timerp_t0[17] & timerp_t0[14] & timerp_t0[11] &
                  timerp_t0[9] ;





  assign tdrsmup =
                   (tsmode[1] == 1'b1) ?
                   timerp_t0[6]  & timerp_t0[5] &
                   timerp_t0[2] :

                   timerp_t0[17] & timerp_t0[14] &
                   timerp_t0[11] & timerp_t0[9] ;





  assign tdrsmup_5u =
                      (tsmode[1] == 1'b1) ?
                      timerp_t0[7]  & timerp_t0[6] &
                      timerp_t0[5]  & timerp_t0[4] &
                      timerp_t0[2]  & timerp_t0[0] :

                      timerp_t0[17] & timerp_t0[14] &
                      timerp_t0[11] & timerp_t0[9]  &
                      timerp_t0[7]  & timerp_t0[4]  &
                      timerp_t0[2]  & timerp_t0[0] ;






  assign tdrst = (tdrst55 == 1'b1 ||
                 (tdrst16 == 1'b1 && usbrstsig16ms_r == 1'b1) ||
                 (tdrst10 == 1'b1 && usbrstsig55ms_r == 1'b0)) ? 1'b1 :
                                                                 1'b0 ;





  assign tdrstdchse0 = (tdrst55dchse0 == 1'b1 ||
                       (tdrst16dchse0 == 1'b1 && usbrstsig16ms_r == 1'b1) ||
                       (tdrst10dchse0 == 1'b1 && usbrstsig55ms_r == 1'b0)) ? 1'b1 :
                                                                             1'b0 ;



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TDRSTDCHSE0_LATCH_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      tdrstdchse0_latch <= 1'b0;
      end
    else
      begin
      if (state_d != DR_CHIRP_K && state_d != DR_CHIRP_J)
        begin
        tdrstdchse0_latch <= 1'b0;
        end
      else if (tdrstdchse0 == 1'b1)
        begin
        tdrstdchse0_latch <= 1'b1;
        end
      end
    end






  always @(state_d or linestate_r or tdrst or tuchend_tmout or
           tfilt or tdchbit or tdrstdchse0_latch or hsdisable_s or
           tfilt25 or tfiltjk or
           susp_set or wakeup_set or susp_req or tsuspreq or state_hr or
           hcsleep_ack_fix or tfilt12_latch or
           speed_ff)

    begin : NEXT_STATE_D_PROC

    case (state_d)
        DISABLED :
            begin
            next_state_d = DDRIVE_SE0 ;
            end
        DDRIVE_SE0 :
            begin
            next_state_d = CLR_TIMER1 ;
            end
        CLR_TIMER1 :
            begin
            `ifdef CDNSUSBHS_SMSC_PHY
            if ((linestate_r == 2'b10 || linestate_r == 2'b01) &&
                hsdisable_s == 1'b0)
            `else
            if (linestate_r == 2'b10 &&
                hsdisable_s == 1'b0)
            `endif
              begin
              next_state_d = RUN_TIMER1 ;
              end
            else if (tdrst == 1'b1)
              begin
              next_state_d = DEV_DET;
              end
            else
              begin
              next_state_d = CLR_TIMER1 ;
              end
            end
        RUN_TIMER1 :
            begin
            if (tuchend_tmout == 1'b1)
              begin
              next_state_d = WAITD ;
              end
            `ifdef CDNSUSBHS_SMSC_PHY
            else if (linestate_r != 2'b10 && linestate_r != 2'b01)
            `else
            else if (linestate_r != 2'b10)
            `endif
              begin
              if (tfilt == 1'b1)
                begin
                next_state_d = DR_CHIRP_K ;
                end
              else
                begin
                next_state_d = CLR_TIMER1 ;
                end
              end
            else
              begin
              next_state_d = RUN_TIMER1 ;
              end
            end
        WAITD :
            begin
            if (tdrst == 1'b1)
              begin
              next_state_d = DEV_DET ;
              end
            else
              begin
              next_state_d = WAITD ;
              end
            end
        DEV_DET :
            begin
            if (tfilt25 == 1'b1)
              begin
              next_state_d = FULL_SPEED;
              end
            else if (tfiltjk == 1'b1)
              begin
              if (linestate_r == 2'b10)
                begin
                next_state_d = LOW_SPEED;
                end
              else
                begin
                next_state_d = FULL_SPEED;
                end












              end
            else
              begin
              next_state_d = DEV_DET;
              end
            end
        DR_CHIRP_J :
            begin
            if (tdchbit == 1'b1)
              begin
              if (tdrstdchse0_latch == 1'b1)
                begin
                next_state_d = DRIVE_SE0_HS ;
                end
              else
                begin
                next_state_d = DR_CHIRP_K ;
                end
              end
            else
              begin
              next_state_d = DR_CHIRP_J ;
              end
            end
        DR_CHIRP_K :
            begin
            if (tdchbit == 1'b1)
              begin
              if (tdrstdchse0_latch == 1'b1)
                begin
                next_state_d = DRIVE_SE0_HS ;
                end
              else
                begin
                next_state_d = DR_CHIRP_J ;
                end
              end
            else
              begin
              next_state_d = DR_CHIRP_K ;
              end
            end
        DRIVE_SE0_HS :
            begin
            if (tdrst == 1'b1)
              begin
              next_state_d = HIGH_SPEED ;
              end
            else
              begin
              next_state_d = DRIVE_SE0_HS ;
              end
            end
        PRE_SUSPEND :
            begin
            if (susp_req == 1'b1)
              begin
              if (speed_ff == 2'b01)
                begin
                next_state_d = FULL_SPEED;
                end
              else if (speed_ff == 2'b00)
                begin
                next_state_d = HIGH_SPEED;
                end
              else
                begin
                next_state_d = LOW_SPEED;
                end
              end
            else
              begin
              if (tsuspreq == 1'b1)
                begin
                next_state_d = LPM_SUSPEND;
                end
              else
                begin
                next_state_d = PRE_SUSPEND;
                end
              end
            end
        LPM_SUSPEND :
            begin
            if (tfilt12_latch == 1'b0)
              begin
              next_state_d = LPM_SUSPEND;
              end
            else if (linestate_r == 2'b10)
              begin
              next_state_d = LPM_DRIVE_RESUME;
              end
            else if (linestate_r == 2'b01 &&
                     susp_set == 1'b1 &&
                     wakeup_set == 1'b1)
              begin
              next_state_d = LPM_DRIVE_RESUME;
              end
            else
              begin
              next_state_d = LPM_SUSPEND;
              end
            end
        LPM_DRIVE_RESUME :
            begin
            if (state_hr == RES1 ||
                state_hr == RES2)
              begin
              next_state_d = LPM_DRIVE_RESUME;
              end
            else
              begin
              if (speed_ff == 2'b01)
                begin
                next_state_d = FULL_SPEED;
                end
              else if (speed_ff == 2'b00)
                begin
                next_state_d = HIGH_SPEED;
                end
              else
                begin
                next_state_d = LOW_SPEED;
                end
              end
            end
        default :
            begin

            if (susp_req == 1'b1)
              begin
              next_state_d = PRE_SUSPEND ;
              end
            else if (hcsleep_ack_fix == 1'b1)
              begin
              next_state_d = LPM_SUSPEND;
              end
            else
              begin
              next_state_d = state_d;
              end
            end
    endcase
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : STATE_D_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      state_d <= DISABLED ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        if (downstr_en == 1'b0)
          begin
          state_d <= DISABLED ;
          end
        else if (testmode == 1'b1 ||
                 portctrltm == 1'b1)
          begin
          state_d <= HIGH_SPEED ;
          end
        else if (hrstsig == 1'b1)
          begin
          state_d <= DDRIVE_SE0 ;
          end
        else
          begin
          state_d <= next_state_d ;
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SPEED_FF_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      speed_ff <= 2'b01;
      end
    else
      begin
      if (usbreset_s == 1'b1 || state_d == DISABLED)
        begin
        speed_ff <= 2'b01;
        end
      else
        begin
        if (state_d == FULL_SPEED)
          begin
          speed_ff <= 2'b01;
          end
        else if (state_d == HIGH_SPEED)
          begin
          speed_ff <= 2'b00;
          end
        else if (state_d == LOW_SPEED)
          begin
          speed_ff <= 2'b10;
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : LSMODE_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      lsmode <= 1'b0 ;
      end
    else
      begin
      if (state_d == LOW_SPEED || speed_ff == 2'b10)
        begin
        lsmode <= 1'b1 ;
        end
      else
        begin
        lsmode <= 1'b0 ;
        end
      end
    end





  assign hsmode_s = (state_d == HIGH_SPEED   ||
                     state_u == HIGH_SPEED_U ||
                     state_u == HIGH_SPEED_SE0) ? 1'b1 :
                                                  1'b0 ;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HSMODE_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hsmode   <= 1'b0 ;
      hsmode_r <= 1'b0 ;
      end
    else
      begin
      hsmode   <= hsmode_s ;
      hsmode_r <= hsmode ;
      end
    end





  assign hsmodeirq = (upstren == 1'b1) ? (hsmode_s & ~hsmode) :
                                         (hsmode   & ~hsmode_r) ;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TIMERP_T0_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      timerp_t0 <= {TIMERP_T0_WIDTH{1'b0}} ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        if (downstr_en == 1'b1)
          begin

          if (hrstsig == 1'b1 || state_d == DISABLED)
            begin
            timerp_t0 <= {TIMERP_T0_WIDTH{1'b0}} ;
            end
          else if ((next_state_d == HIGH_SPEED && state_d != HIGH_SPEED) ||
                   (     state_d == HIGH_SPEED && linestate_r != 2'b00))
            begin
            timerp_t0 <= {TIMERP_T0_WIDTH{1'b0}} ;
            end
          else if ((next_state_d == FULL_SPEED && state_d != FULL_SPEED) ||
                   (     state_d == FULL_SPEED && linestate_r != 2'b01))
            begin
            timerp_t0 <= {TIMERP_T0_WIDTH{1'b0}} ;
            end
          else if ((next_state_d == LOW_SPEED && state_d != LOW_SPEED) ||
                   (     state_d == LOW_SPEED && linestate_r != 2'b01))
            begin
            timerp_t0 <= {TIMERP_T0_WIDTH{1'b0}} ;
            end
          else if ((state_d == FULL_SPEED ||
                    state_d == LOW_SPEED  ||
                    state_d == HIGH_SPEED) && hcsleep_ack_fix == 1'b1)
            begin
            timerp_t0 <= {TIMERP_T0_WIDTH{1'b0}} ;
            end
          else if ((next_state_d == LPM_SUSPEND      && state_d == PRE_SUSPEND) ||
                   (next_state_d == LPM_DRIVE_RESUME && state_d == LPM_SUSPEND))
            begin
            timerp_t0 <= {TIMERP_T0_WIDTH{1'b0}} ;
            end
          else if (next_state_hr != state_hr)
            begin
            timerp_t0 <= {TIMERP_T0_WIDTH{1'b0}} ;
            end
          else
            begin
            timerp_t0 <= timerp_t0 + 1'b1 ;
            end
          end
        else if (upstr_en == 1'b1)
          begin

          if (clr_tmr_t0 == 1'b1 &&
              count_tmr_t0 == 1'b0)
            begin
            timerp_t0 <= {TIMERP_T0_WIDTH{1'b0}} ;
            end
          else
            begin
            timerp_t0 <= timerp_t0 + 1'b1 ;
            end
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TIMERP_T1_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      timerp_t1 <= {20{1'b0}} ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        if (downstr_en == 1'b1)
          begin
          if (state_d == DDRIVE_SE0 ||
              state_d == CLR_TIMER1 ||
              state_d == WAITD ||
              ((state == A_SUSPEND ||
                state == B_HOST_2) && linestate_r != 2'b01) ||
              (state_hr == NO_RES && next_state_hr == RES1))
            begin

            timerp_t1 <= {20{1'b0}} ;
            end
          else if (state_d == DEV_DET ||
                   state_d == LPM_SUSPEND ||
                   state_hr == RES1 ||
                   state == B_HOST_2 ||
                   state == A_SUSPEND ||
                  (state_d == RUN_TIMER1 && tfilt == 1'b0))
            begin
            timerp_t1 <= timerp_t1 + 1'b1 ;
            end
          end
        else if (upstr_en == 1'b1)
          begin
          if (clr_tmr_t0 == 1'b1)
            begin

            timerp_t1 <= {20{1'b0}} ;
            end
          else
            begin
            if (state_u == SUSPENDED || state_u == SLEEP)
              begin
              timerp_t1 <= timerp_t1 + 1'b1 ;
              end
            else if (state_u == DETECT_SE0)
              begin
              timerp_t1 <= timerp_t1 + 1'b1 ;








              end
            else if (state_u == DETECT_HSJ)
              begin
              if (linestate_r == 2'b01)
                begin
                timerp_t1 <= timerp_t1 + 1'b1 ;
                end
              else
                begin
                timerp_t1 <= {20{1'b0}} ;
                end
              end
            else if (state_u == DETECT_HSK)
              begin
              if (linestate_r == 2'b10)
                begin
                timerp_t1 <= timerp_t1 + 1'b1 ;
                end
              else
                begin
                timerp_t1 <= {20{1'b0}} ;
                end
              end
            else if (state_u == WAIT_END_RESET)
              begin
              if (linestate_r == 2'b01)
                begin
                timerp_t1 <= timerp_t1 + 1'b1 ;
                end
              else
                begin
                timerp_t1 <= {20{1'b0}} ;
                end
              end
            else
              begin
              timerp_t1 <= {20{1'b0}} ;
              end
            end
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TIMERP_T2_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      timerp_t2 <= {11{1'b0}} ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        case (state_d)
            CLR_TIMER1 :
                begin
                timerp_t2 <= {11{1'b0}} ;
                end
            DEV_DET :
                begin
                if (linestate_r != linestate_r2 ||
                    linestate_r == 2'b00)
                  begin
                  timerp_t2 <= {11{1'b0}} ;
                  end
                else
                  begin
                  timerp_t2 <= timerp_t2 + 1'b1;
                  end
                end
            default :
                begin
                if ((next_state_d == DR_CHIRP_J && state_d != DR_CHIRP_J) ||
                    (next_state_d == DR_CHIRP_K && state_d != DR_CHIRP_K))
                  begin
                  timerp_t2 <= {11{1'b0}} ;
                  end
                else
                  begin
                  timerp_t2 <= timerp_t2 + 1'b1 ;
                  end
                end
        endcase
        end
      end
    end





  assign tdrst16dchse0 = timerp_t0[15] & timerp_t0[13] & timerp_t0[11] &
                         timerp_t0[10] ;





  assign tdrst16 = timerp_t0[15] & timerp_t0[13] & timerp_t0[12] &
                   timerp_t0[11] & timerp_t0[9]  & timerp_t0[8] &
                   timerp_t0[7] ;





  assign tdrst10dchse0 = timerp_t0[18] & timerp_t0[15] ;





  assign tdrst10 = timerp_t0[18] & timerp_t0[15] & timerp_t0[12] &
                   timerp_t0[10] ;







  assign tdrst55dchse0 = timerp_t0[20] & timerp_t0[19] & timerp_t0[16] &
                         timerp_t0[12] & timerp_t0[11] & timerp_t0[9] ;





  assign tdrst55 = timerp_t0[20] & timerp_t0[19] & timerp_t0[16] &
                   timerp_t0[13] & timerp_t0[11] & timerp_t0[10] ;





  assign tuchend = timerp_t0[17] & timerp_t0[16] & timerp_t0[14] ;





  assign tdchbit = timerp_t2[10] & timerp_t2[8] & timerp_t2[7] &
                   timerp_t2[6] ;





  assign tdrsmdn = timerp_t1[19] & timerp_t1[17] & timerp_t1[16] &
                   timerp_t1[14] & timerp_t1[13] & timerp_t1[12] &
                   timerp_t1[9] ;







  assign tbfsbdis = timerp_t1[15] ;







  assign tb_aidl_bdisx = timerp_t1[16] ;

  assign ta_bidl_adis = (forcebconn == 1'b0) ?

                         timerp_t0[22] & timerp_t0[18] & timerp_t0[17] &
                         timerp_t0[15] & timerp_t0[14] & timerp_t0[13] &
                         timerp_t0[12] & timerp_t0[10] & timerp_t0[4] :

                         timerp_t0[17] & timerp_t0[16] & timerp_t0[13] &
                         timerp_t0[12] & timerp_t0[10] & timerp_t0[6]  &
                         timerp_t0[4] ;






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TUCHEND_TMOUT_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      tuchend_tmout <= 1'b0 ;
      end
    else
      begin
      if (state_d == DDRIVE_SE0)
        begin
        tuchend_tmout <= 1'b0 ;
        end
      else if (tuchend == 1'b1)
        begin
        tuchend_tmout <= 1'b1 ;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TBFDBDIS_TMOUT_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      tbfsbdis_tmout <= 1'b0 ;
      end
    else
      begin
      if (state_u != SUSPENDED)
        begin
        tbfsbdis_tmout <= 1'b0 ;
        end
      else if (tbfsbdis == 1'b1)
        begin
        tbfsbdis_tmout <= 1'b1 ;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TB_AIDL_BDISX_TMOUT_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      tb_aidl_bdisx_tmout <= 1'b0 ;
      end
    else
      begin
      if (state_u != SUSPENDED)
        begin
        tb_aidl_bdisx_tmout <= 1'b0 ;
        end
      else if (tb_aidl_bdisx == 1'b1)
        begin
        tb_aidl_bdisx_tmout <= 1'b1 ;
        end
      end
    end






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TA_BIDL_ADIS_TMOUT_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      ta_bidl_adis_tmout <= 1'b0 ;
      end
    else
      begin
      if (state_u != SUSPENDED)
        begin
        ta_bidl_adis_tmout <= 1'b0 ;
        end
      else if (ta_bidl_adis == 1'b1)
        begin
        ta_bidl_adis_tmout <= 1'b1 ;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : FAILED_HNP_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      failed_hnp <= 1'b0 ;
      end
    else
      begin
      if (state == B_WAIT_ACON &&
          b_ase0_brst_tmout == 1'b1)
        begin


        failed_hnp <= 1'b1 ;
        end
      else if (state == B_IDLE ||
               state_u == RESUME)
        begin
        failed_hnp <= 1'b0 ;
        end
      end
    end





  always @(idlfsm_st or linestate_r or hsmode_s)
    begin : IDLFSM_NXT_COMB_PROC
    case (idlfsm_st)

        IDL_IDLE :
            begin


            if (hsmode_s == 1'b1)
              begin

              if (~(linestate_r == 2'b00))
                begin

                idlfsm_nxt = IDL_ACTIVE ;
                end
              else
                begin
                idlfsm_nxt = IDL_IDLE ;
                end
              end
            else
              begin

              if (~(linestate_r == 2'b01))
                begin

                idlfsm_nxt = IDL_ACTIVE ;
                end
              else
                begin
                idlfsm_nxt = IDL_IDLE ;
                end
              end
            end

      IDL_ACTIVE :
            begin
            if (hsmode_s == 1'b1)
              begin

              if (linestate_r == 2'b00)
                begin

                idlfsm_nxt = IDL_IDLE ;
                end
              else
                begin
                idlfsm_nxt = IDL_ACTIVE ;
                end
              end
            else
              begin


              if (linestate_r == 2'b00)
                begin

                idlfsm_nxt = IDL_EOP ;
                end
              else
                begin
                idlfsm_nxt = IDL_ACTIVE ;
                end
              end
            end

      IDL_EOP :
            begin


            if (linestate_r == 2'b00)
              begin
              idlfsm_nxt = IDL_EOP1 ;
              end
            else
              begin
              idlfsm_nxt = IDL_ACTIVE ;
              end
            end

      default :
            begin


            if (~(linestate_r == 2'b00))
              begin

              idlfsm_nxt = IDL_IDLE ;
              end
            else
              begin
              idlfsm_nxt = IDL_EOP1 ;
              end
            end
    endcase
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : IDLFSM_ST_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      idlfsm_st <= IDL_IDLE ;
      end
    else
      begin
      if (bustimeout == 1'b1 ||
          usbreset_s == 1'b1)
        begin
        idlfsm_st <= IDL_IDLE ;
        end
      else
        begin
        idlfsm_st <= idlfsm_nxt ;
        end
      end
    end





  assign busidle = (idlfsm_st == IDL_IDLE) ? 1'b1 :
                                             1'b0 ;






  assign downstrstate = state_d;





  assign upstrstate = state_u;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : BHOSTTIMER_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      bhosttimer <= {BHOSTTIMER_WIDTH{1'b0}} ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        if (state == B_HOST_2)
          begin
          bhosttimer <= bhosttimer + 1'b1 ;
          end
        else if (state == B_IDLE &&
                 bvalid_s == 1'b1)
          begin
          bhosttimer <= bhosttimer + 1'b1 ;
          end
        else
          begin
          bhosttimer <= {BHOSTTIMER_WIDTH{1'b0}} ;
          end
        end
      end
    end










   assign bhosttmout =
                       (otg2en == 1'b1 && forcebconn == 1'b0) ?



                        bhosttimer[22] & bhosttimer[20] & bhosttimer[19] &
                        bhosttimer[18] :


                        bhosttimer[17] & bhosttimer[15] & bhosttimer[13] &
                        bhosttimer[12] & bhosttimer[11] & bhosttimer[10] &
                        bhosttimer[9]  & bhosttimer[8]  & bhosttimer[5] ;



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HOST_DO_SUSPEND_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      host_do_suspend <= 1'b0 ;
      end
    else
      begin
      if (state_d == FULL_SPEED ||
          state_d == LOW_SPEED  ||
          state_d == HIGH_SPEED)
        begin
        host_do_suspend <= 1'b0 ;
        end
      else
        begin
        if (     state_d == PRE_SUSPEND &&
            next_state_d == LPM_SUSPEND)
          begin
          host_do_suspend <= 1'b1 ;
          end
        end
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCSLEEP_ACK_FIX_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcsleep_ack_ff <= 1'b0 ;
      end
    else
      begin
      if (enable_r == 1'b1)
        begin
        hcsleep_ack_ff <= 1'b0 ;
        end
      else
        begin
        if (hcsleep_ack == 1'b1)
          begin
          hcsleep_ack_ff <= 1'b1 ;
          end
        end
      end
    end



  assign hcsleep_ack_fix = hcsleep_ack | hcsleep_ack_ff;





  assign tdevdrvresume = timerp_t0[10] & timerp_t0[8] & timerp_t0[7] &
                         timerp_t0[6]  & timerp_t0[4] & timerp_t0[3] &
                         timerp_t0[2]  & timerp_t0[1] & timerp_t0[0];





  assign tdevdrvresume_5u = timerp_t0[10] & timerp_t0[9] &


                            timerp_t0[6]  & timerp_t0[1] & timerp_t0[0];





  assign thirdresume = (timerp_t0[19:0] == thirdtime) ? 1'b1 : 1'b0;





  assign tbeslresume = (timerp_t0[11:0] == tbesltime) ? 1'b1 : 1'b0;






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : RWDET_LPM_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      rwdet_lpm <= 1'b0 ;
      end
    else
      begin
      if (state_d != LPM_SUSPEND &&
          state_d != LPM_DRIVE_RESUME)
        begin
        rwdet_lpm <= 1'b0 ;
        end
      else
        begin
        if (tfilt12_latch == 1'b1 &&
            linestate_r == 2'b10 &&
            wakeup_set == 1'b0)
          begin
          rwdet_lpm <= 1'b1 ;
          end
        end
      end
    end



















  always @(rwdet_lpm or hclpmctrlb or hclpmctrl_hird)
    begin : THIRDTIME_PROC

    if (rwdet_lpm == 1'b1 &&
        hclpmctrlb == 1'b1)
      begin

      thirdtime = 20'h008CA;
      tbesltime = 12'h1C2;
      end
    else
      begin
      case (hclpmctrl_hird)
        4'b1111 : thirdtime = 20'h48E04;
        4'b1110 : thirdtime = 20'h418D4;
        4'b1101 : thirdtime = 20'h3A3A4;
        4'b1100 : thirdtime = 20'h32E74;
        4'b1011 : thirdtime = 20'h2B944;
        4'b1010 : thirdtime = 20'h24414;
        4'b1001 : thirdtime = 20'h1CEE4;
        4'b1000 : thirdtime = 20'h159B4;
        4'b0111 : thirdtime = 20'h0E484;
        4'b0110 : thirdtime = 20'h06F54;
        4'b0101 : thirdtime = 20'h034BC;
        4'b0100 : thirdtime = 20'h02904;
        4'b0011 : thirdtime = 20'h01D4C;
        4'b0010 : thirdtime = 20'h01194;
        4'b0001 : thirdtime = 20'h00BB8;
        default : thirdtime = 20'h008CA;
      endcase
      tbesltime = 12'h5DC;
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : ENABLE_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      enable_r <= 1'b0 ;
      end
    else
      begin
      enable_r <= ~enable ;
      end
    end



  assign enable = enable_r;

endmodule

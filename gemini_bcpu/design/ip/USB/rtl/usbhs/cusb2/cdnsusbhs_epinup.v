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
//   Filename:           cdnsusbhs_epinup.v
//   Module Name:        cdnsusbhs_epinup
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
//   IN endpoint - microprocessor clock domain
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_epinup
  (
  upclk,
  uprst,
  usbbusyclr,
  isoerr,
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
  upwr,
  upincbc,
  updataival_0,
  updataival_1,
  updataival_2,
  updataival_3,
  upinbc,
  upbusyset,
  inxcon,
  inbsyfall,
  upfifoptrwr,

  fifofull,
  fifoafull,

  inxmaxpck,
  usbresetup,
  discon,

  inxisoautoarm,
  isosofpulseup,

  hcerrtype,
  hcerrcount,
  hcdoping,
  upstren,
  enterhm,
  hcendpnr,
  hcresend,
  hcdopingset,
  hcnakidis,
  hcerrirq,

  hcsof_timer,
  hcsof_timer_start,
  hcsof_timer_stop,
  hcsof_timer_reload,
  hcsof_timer_end,

  updatao
  );

  parameter EPNUMBER    = 32'd1;
  parameter EPSIZE      = 32'd1024;
  parameter EPBUFFER    = 32'd4;
  parameter BCWIDTH     = 32'd11;

  `include "cdnsusbhs_cusb2_params.v"


  parameter EPBMASK     = (EPBUFFER == 32'd1) ? 2'b00 :
                          (EPBUFFER == 32'd2) ? 2'b01 :
                                                2'b11 ;
  parameter INXCON_RVM  = (EPBUFFER == 32'd3 && INXCON_RV[1:0] == 2'b11) ? {INXCON_RV[7:2], 2'b10} :
                                                                           {INXCON_RV[7:2], INXCON_RV[1:0] & EPBMASK} ;


  input                            upclk;
  input                            uprst;
  input  [EPBUFFER-1:0]            usbbusyclr;
  input                            isoerr;
  input                            fiforst;

  input  [3:0]                     fifoendpnr;
  input                            fifowr;
  input                            fifoend;
  input                            fifoacc;
  input  [3:0]                     fifodval;

  input  [7:0]                     upaddr;
  input                            upwr;
  input                            upincbc;
  input  [7:0]                     updatai_0;
  input  [7:0]                     updatai_1;
  input  [7:0]                     updatai_2;
  input  [7:0]                     updatai_3;
  input                            updataival_0;
  input                            updataival_1;
  input                            updataival_2;
  input                            updataival_3;
  output [4*BCWIDTH-1:0]           upinbc;
  wire   [4*BCWIDTH-1:0]           upinbc;
  output [EPBUFFER-1:0]            upbusyset;
  reg    [EPBUFFER-1:0]            upbusyset;
  output [7:0]                     inxcon;
  wire   [7:0]                     inxcon;
  output                           inbsyfall;
  wire                             inbsyfall;
  output [11:0]                    upfifoptrwr;
  reg    [11:0]                    upfifoptrwr;

  output                           fifofull;
  wire                             fifofull;
  output                           fifoafull;
  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  wire                             fifoafull;
  `else
  reg                              fifoafull;
  `endif

  input  [BCWIDTH-1:0]             inxmaxpck;
  input                            usbresetup;
  input                            discon;

  input                            inxisoautoarm;
  input                            isosofpulseup;

  input  [2:0]                     hcerrtype;
  input  [1:0]                     hcerrcount;
  input                            hcdoping;
  input                            upstren;
  input                            enterhm;

  output [3:0]                     hcendpnr;
  wire   [3:0]                     hcendpnr;
  output                           hcresend;
  reg                              hcresend;
  output                           hcdopingset;
  reg                              hcdopingset;
  output                           hcnakidis;
  reg                              hcnakidis;
  output                           hcerrirq;
  wire                             hcerrirq;

  output [15:0]                    hcsof_timer;
  reg    [15:0]                    hcsof_timer;
  output                           hcsof_timer_start;
  reg                              hcsof_timer_start;
  output                           hcsof_timer_stop;
  reg                              hcsof_timer_stop;
  output                           hcsof_timer_reload;
  reg                              hcsof_timer_reload;
  input                            hcsof_timer_end;

  output [31:0]                    updatao;
  reg    [31:0]                    updatao;

  reg    [7:0]                     inxcon_nxt;
  reg    [7:0]                     inxcon_reg;

  reg    [4:0]                     inxcs;

  reg    [BCWIDTH-1:0]             upinbc_a[3:0];
  `ifdef CDNSUSBHS_NO_UPINXBC_SYNCFF
  `else
  reg    [BCWIDTH-1:0]             upinbc_c[3:0];
  `endif
  reg    [BCWIDTH-1:0]             upinbc_nxt_s;
  wire   [BCWIDTH-1:0]             upinxbc;

  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  wire   [1:0]                     upbuffnr;
  reg    [1:0]                     upbuffnr_reg;
  `endif

  wire                             setbsy;
  reg                              setbsy_up;
  reg                              setbsy_max;
  reg                              setbsy_iso;
  reg                              setbsy_fifo;
  reg    [EPBUFFER-1:0]            upbusy;
  reg                              fifoautoin;
  reg                              fifocmit;
  reg    [3:0]                     upbusy_s;
  reg    [2:0]                     incr_s;
  reg    [2:0]                     incr_up_s;
  reg    [2:0]                     incr_fifo_s;

  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  reg    [11:0]                    epsize_s;
  `ifdef CDNSUSBHS_NO_NEW_POINTER
  reg    [1:0]                     sizemod_s;
  `endif
  `endif
  reg    [11:0]                    upinxbc_s;
  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  wire   [1:0]                     buffering;
  `ifdef CDNSUSBHS_NO_NEW_POINTER
  reg    [1:0]                     inxmaxpck_s;
  `endif
  `endif

  reg                              inxisoautoarmen;

  reg    [3:0]                     hcoutxctrl;

  wire   [4:0]                     hcoutxerr;
  wire                             hcoutxerrirq;
  reg                              hcoutxerrirq_r;

  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  wire   [1:0]                     isotoggle;
  `endif
  wire   [1:0]                     eptype;

  reg    [10:0]                    upinxbc_nxt_v;

  wire                             irq_set;
  reg    [1:0]                     irq_mode;

  reg                              upbusy_or;
  reg                              usbbusyclr_r;




  `ifdef CDNSUSBHS_NO_UPINXBC_SYNCFF
  assign upinbc  = {upinbc_a[3],
                    upinbc_a[2],
                    upinbc_a[1],
                    upinbc_a[0]};
  `else
  assign upinbc  = {upinbc_c[3],
                    upinbc_c[2],
                    upinbc_c[1],
                    upinbc_c[0]};
  `endif




  `ifdef CDNSUSBHS_NO_UPINXBC_SYNCFF
  `else
  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : UPINXBC_C_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      for(i = 3; i >= 0; i = i - 1)
        begin
        upinbc_c[i] <= {BCWIDTH{1'b0}} ;
        end
      end
    else
      begin


      for(i = 3; i >= EPBUFFER; i = i - 1)
        begin
        upinbc_c[i] <= {BCWIDTH{1'b0}} ;
        end

      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin
        if (fiforst == 1'b1)
          begin

          upinbc_c[i] <= {BCWIDTH{1'b0}} ;
          end
        else if (upbusy[i] == 1'b1 && usbbusyclr[i] == 1'b1)
          begin

          upinbc_c[i] <= {BCWIDTH{1'b0}} ;
          end
        else if (upbusyset[i] == 1'b1)
          begin
          upinbc_c[i] <= upinbc_a[i];
          end
        end
      end
    end
  `endif




  always @(updataival_0 or updataival_1 or
           updatai_0 or updatai_1 or
           upinxbc)
    begin : UPINXBC_V_NXT_COMB_PROC

    upinxbc_nxt_v              = {11{1'b0}};
    upinxbc_nxt_v[BCWIDTH-1:0] = upinxbc;


    if (updataival_1 == 1'b1)
      begin
      upinxbc_nxt_v[10:8] = updatai_1[2:0];
      end
    if (updataival_0 == 1'b1)
      begin
      upinxbc_nxt_v[7:0]  = updatai_0[7:0];
      end
    end




  always @(upaddr or
           upwr or
           upinxbc_nxt_v or
           incr_s or upinxbc)
    begin : UPINXBC_A_NXT_COMB_PROC




    if (upaddr == ({3'b000, EPNUMBER[3:0], 1'b1}) &&
        upwr == 1'b1)
      begin
      upinbc_nxt_s = upinxbc_nxt_v[BCWIDTH-1:0];
      end
    else
      begin
      upinbc_nxt_s = upinxbc + incr_s ;
      end
    end







`ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  always @(upbusy)
`else
  always @(upbusy or isotoggle)
`endif
    begin : INXISOAUTOARMEN_SYNC_PROC
      reg [3:0] upbusy_v;


    upbusy_v               = 4'h0;
    upbusy_v[EPBUFFER-1:0] = upbusy;

    case (upbusy_v)
        4'h0 :
            begin
            inxisoautoarmen = 1'b1;
            end

      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
        default :
            begin
            inxisoautoarmen = 1'b0;
            end
      `else
      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4
        4'h8,
        4'h4,
        4'h2,
        4'h1 :
      `else
      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_3
        4'h4,
        4'h2,
        4'h1 :
      `else
        4'h2,
        4'h1 :
      `endif
      `endif
            begin
            if (isotoggle == 2'b00)
              begin
              inxisoautoarmen = 1'b0;
              end
            else
              begin
              inxisoautoarmen = 1'b1;
              end
            end
      `endif

      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
      `else
      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4

        4'hC,
        4'h9,
        4'h6,
        4'h5,
        4'h3 :
            begin
            if (isotoggle == 2'b10)
              begin
              inxisoautoarmen = 1'b1;
              end
            else
              begin
              inxisoautoarmen = 1'b0;
              end
            end
      `else
      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_3
        4'h6,
        4'h5,
        4'h3 :
            begin
            if (isotoggle == 2'b10)
              begin
              inxisoautoarmen = 1'b1;
              end
            else
              begin
              inxisoautoarmen = 1'b0;
              end
            end
      `else
        default :
            begin
            inxisoautoarmen = 1'b0;
            end
      `endif
      `endif
      `endif

      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
      `else
      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4
        default :
            begin
            inxisoautoarmen = 1'b0;
            end
      `else
      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_3
        default :
            begin
            inxisoautoarmen = 1'b0;
            end
      `endif
      `endif
      `endif
    endcase
    end




  always @(upincbc or upaddr or updataival_3 or
           inxisoautoarm or eptype or upinxbc)
    begin : SETBSY_UP_COMB_PROC

    setbsy_up = 1'b0 ;


    if (upaddr == {3'b000, EPNUMBER[3:0], 1'b1} &&
        updataival_3 == 1'b1 &&
        upincbc == 1'b1 &&
        (eptype != EP_ISO ||
         inxisoautoarm == 1'b0 ||
         upinxbc != {BCWIDTH{1'b0}}))
      begin
      setbsy_up = 1'b1 ;
      end
    end




  always @(upincbc or upaddr or
           fifoautoin or upinbc_nxt_s or inxmaxpck or eptype)
    begin : SETBSY_MAX_COMB_PROC

    setbsy_max = 1'b0 ;


    if (fifoautoin == 1'b1 &&
        upincbc == 1'b1 &&
        upaddr == {4'b0010, EPNUMBER[3:0]} &&
        upinbc_nxt_s == inxmaxpck &&
        eptype == EP_ISO)
      begin
      setbsy_max = 1'b1 ;
      end
    end




  always @(inxisoautoarm or inxcs or
           upinxbc or isosofpulseup or inxisoautoarmen)
    begin : SETBSY_ISO_COMB_PROC

    setbsy_iso = 1'b0 ;


    if (inxisoautoarm == 1'b1 &&
        isosofpulseup == 1'b1 &&
        inxisoautoarmen == 1'b1 &&
        upinxbc != {BCWIDTH{1'b0}} &&
        inxcs[1] == 1'b0)
      begin
      setbsy_iso = 1'b1 ;
      end
    end




  always @(fifoend or fifoautoin or fifocmit or fifowr or fifoendpnr or
           upinbc_nxt_s or inxmaxpck)
    begin : SETBSY_FIFO_COMB_PROC

    setbsy_fifo = 1'b0 ;



    if ((fifoautoin == 1'b1 || fifocmit == 1'b1) &&
         fifoendpnr == EPNUMBER[3:0] &&
         (fifoend == 1'b1 ||
         (fifowr == 1'b1 && upinbc_nxt_s == inxmaxpck)))
      begin



      setbsy_fifo = 1'b1 ;
      end
    end




  assign setbsy =
                  setbsy_max  |
                  setbsy_iso  |
                  setbsy_fifo |
                  setbsy_up;




  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  assign upinxbc = upinbc_a[0] ;
  `else
  assign upinxbc = upinbc_a[upbuffnr] ;
  `endif

  `ifdef CDNSUSBHS_NO_NEW_POINTER
  `else



  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  always @(upbuffnr or inxmaxpck)
    begin : EPSIZE_S_COMB_PROC
      reg [11:0] inxmaxpck_v;

    inxmaxpck_v = 12'h000;
    case (inxmaxpck[1:0])
      2'b11   : inxmaxpck_v[BCWIDTH-1:0] = inxmaxpck + 1'b1;
      2'b10   : inxmaxpck_v[BCWIDTH-1:0] = inxmaxpck + 2'b10;
      2'b01   : inxmaxpck_v[BCWIDTH-1:0] = inxmaxpck + 2'b11;
      default : inxmaxpck_v[BCWIDTH-1:0] = inxmaxpck;
    endcase


    case (upbuffnr)
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



  always @(upinxbc)
    begin : UPINXBC_S_COMB_PROC

    upinxbc_s              = {12{1'b0}};
    upinxbc_s[BCWIDTH-1:0] = upinxbc;
    end




  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  always @(upinxbc_s)
    begin : UPFIFOPTRWR_COMB_PROC

    upfifoptrwr = upinxbc_s;
    end
  `else
  always @(upinxbc_s or epsize_s)
    begin : UPFIFOPTRWR_COMB_PROC

    upfifoptrwr = epsize_s + upinxbc_s;
    end
  `endif
  `endif

  `ifdef CDNSUSBHS_NO_NEW_POINTER



  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  always @(upinxbc or inxmaxpck)
  `else
  always @(upinxbc or upbuffnr or inxmaxpck)
  `endif
    begin : EPSIZE_S_COMB_PROC
      reg [11:0] upinxbc_v;
      reg [11:0] inxmaxpck_v;
    `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
    `else
    `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4
      reg [8:0]  inxmaxpcksum_v;
    `endif
    `endif


    upinxbc_v                = {12{1'b0}};
    upinxbc_v[BCWIDTH-1:0]   = upinxbc;

    inxmaxpck_v              = {12{1'b0}};
    inxmaxpck_v[BCWIDTH-1:0] = inxmaxpck;

    `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
    `else

    `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4
    inxmaxpcksum_v = {9{1'b0}};
    inxmaxpcksum_v = inxmaxpck_v[11:3] + inxmaxpck_v[10:2];
    `endif





    case (upbuffnr)
      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4
        2'b11 :
            begin
            epsize_s  = {inxmaxpcksum_v[8:0], inxmaxpck_v[2], 2'b00} ;
            sizemod_s =  2'b11 ;
            end
        2'b10 :
            begin
            epsize_s  = {inxmaxpck_v[10:2], 3'b000} ;
            sizemod_s =  2'b10;
            end
      `else

      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_3
        2'b10 :
            begin
            epsize_s  = {inxmaxpck_v[10:2], 3'b000} ;
            sizemod_s =  2'b10;
            end
      `endif
      `endif

        2'b01 :
            begin
            epsize_s  = {inxmaxpck_v[11:2], 2'b00} ;
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
    upinxbc_s   = upinxbc_v;
    end




  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  always @(upinxbc_s)
    begin : UPFIFOPTRWR_COMB_PROC

    upfifoptrwr = upinxbc_s;
    end

  `else
  always @(upinxbc_s or inxmaxpck_s or epsize_s or sizemod_s)
    begin : UPFIFOPTRWR_COMB_PROC
      reg [11:0] upfifoptrwr_v;

    upfifoptrwr_v = epsize_s + upinxbc_s;


    if (inxmaxpck_s[0] == 1'b1 ||
        inxmaxpck_s[1] == 1'b1)
      begin

      upfifoptrwr = upfifoptrwr_v + {8'h00, sizemod_s, 2'b00} ;
      end
    else
      begin

      upfifoptrwr = upfifoptrwr_v ;
      end
    end
  `endif
  `endif




  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  assign buffering = inxcon[1:0] ;
  `endif




  assign eptype = inxcon[3:2] ;




  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else
  assign isotoggle = inxcon[5:4] ;
  `endif





  assign fifofull = (fifoautoin == 1'b0 &&
                     fifocmit   == 1'b0) ? 1'b1 :
  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
                                        upbusy[0] ;
  `else
                                        upbusy[upbuffnr] ;
  `endif




  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  assign fifoafull = 1'b1 ;
  `else
  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFOAFULL_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoafull <= 1'b0 ;
      end
    else
      begin
      if (fifoautoin == 1'b0 && fifocmit == 1'b0)
        begin
        fifoafull <= 1'b1 ;
        end
      else if (buffering == 2'b00)
        begin
        fifoafull <= 1'b1 ;
        end
      else if (buffering <= upbuffnr)
        begin
        fifoafull <= upbusy[0];
        end
       else
        begin
        fifoafull <= upbusy[upbuffnr + 1'b1];
        end
      end
    end
  `endif



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : AUTOIN_BIT_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoautoin <= INXCS_RV[4] ;
      end
    else
      begin
      if (upaddr == FIFOCTRL_ID[9:2] &&
          upwr == 1'b1 &&
          updatai_0[4] == 1'b1 &&
          updataival_0 == 1'b1 &&
          (updatai_0[3:0] == EPNUMBER[3:0] || updatai_0[3:0] == 4'b0000))
        begin

        fifoautoin <= updatai_0[5];
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : COMMIT_BIT_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifocmit <= 1'b0 ;
      end
    else
      begin
      if (upaddr == FIFOCTRL_ID[9:2] &&
          upwr == 1'b1 &&
          updatai_0[4] == 1'b1 &&
          updataival_0 == 1'b1 &&
         (updatai_0[3:0] == EPNUMBER[3:0] || updatai_0[3:0] == 4'b0000))
        begin

        fifocmit <= updatai_0[6];
        end
      else
        begin

        if (setbsy == 1'b1)
          begin
          fifocmit <= 1'b0 ;
          end
        end
      end
    end




  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  always @(upbusy)
  `else
  always @(upbusy or buffering)
  `endif
    begin : UPBUSY_S_COMB_PROC
      reg [3:0] upbusy_v;




    upbusy_v               = 4'hF ;
    upbusy_v[EPBUFFER-1:0] = upbusy ;

    `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
            upbusy_s = {3'b111, upbusy_v[0]};
    `else
    case (buffering)
      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4
        2'b11 :
            begin
            upbusy_s = upbusy_v[3:0];
            end
        2'b10 :
            begin
            upbusy_s = {1'b1, upbusy_v[2:0]};
            end
      `else

      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_3
        2'b10 :
            begin
            upbusy_s = {1'b1, upbusy_v[2:0]};
            end
      `endif
      `endif

        2'b01 :
            begin
            upbusy_s = {2'b11, upbusy_v[1:0]};
            end

        default :
            begin
            upbusy_s = {3'b111, upbusy_v[0]};
            end
    endcase
    `endif
    end






  always @(upbusy_s or isoerr or fifoautoin)
    begin : INXCS_COMB_PROC





    inxcs[0] = isoerr ;


    inxcs[1] = &upbusy_s ;


    `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
            inxcs[3:2] = 2'b00 ;
    `else
    case (upbusy_s)
      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4
        4'h0 :
            begin
            inxcs[3:2] = 2'b11 ;
            end

        4'h8,
        4'h4,
        4'h2,
        4'h1:
            begin
            inxcs[3:2] = 2'b10 ;
            end


        4'hC,
        4'hA,
        4'h9,
        4'h6,
        4'h3:
            begin
            inxcs[3:2] = 2'b01 ;
            end
      `else

      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_3
        4'h8:
            begin
            inxcs[3:2] = 2'b10 ;
            end


        4'hC,
        4'hA,
        4'h9:
            begin
            inxcs[3:2] = 2'b01 ;
            end
      `else

        4'hC:
            begin
            inxcs[3:2] = 2'b01 ;
            end
      `endif
      `endif






        default :
            begin
            inxcs[3:2] = 2'b00 ;
            end
    endcase
    `endif


    inxcs[4] = fifoautoin ;
    end








  always @(upaddr or upwr or updatai_2 or updataival_2 or inxcon or
           usbresetup)
    begin : INXCON_NXT_COMB_PROC


    inxcon_nxt = inxcon ;

    if (upaddr == ({3'b000, EPNUMBER[3:0], 1'b1}) &&
        updataival_2 == 1'b1 &&
        upwr == 1'b1)
      begin
      inxcon_nxt = updatai_2;
      end
    else if (usbresetup == 1'b1)
      begin

      inxcon_nxt[6] = 1'b0 ;
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : INXCON_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      inxcon_reg <= INXCON_RVM ;
      end
    else
      begin
      inxcon_reg <= inxcon_nxt ;
      end
    end




  assign inxcon = (EPBUFFER == 32'd3 && inxcon_reg[1:0] == 2'b11) ? {inxcon_reg[7:2], 2'b10} :
                                                                    {inxcon_reg[7:2], (EPBMASK & inxcon_reg[1:0])} ;




  always @(updataival_3 or updataival_2 or updataival_1 or updataival_0 or
           upaddr or upincbc)
    begin : INCR_S_UP_COMB_PROC

    incr_up_s = 3'b000;


    if (upincbc == 1'b1 &&
        upaddr == {4'b0010, EPNUMBER[3:0]})
      begin

      case ({updataival_3, updataival_2, updataival_1, updataival_0})
        4'hF :
            begin

            incr_up_s = 3'b100;
            end

        4'h3 :
            begin

            incr_up_s = 3'b010;
            end
        default :
            begin

            incr_up_s = 3'b001;
            end
      endcase
      end
    end




  always @(fifodval or fifowr or fifoendpnr)
    begin : INCR_S_FIFO_COMB_PROC

    incr_fifo_s = 3'b000;


    if (fifowr == 1'b1 && fifoendpnr == EPNUMBER[3:0])
      begin

      case (fifodval)
        4'b1111 :
          begin
          incr_fifo_s = 3'b100;
          end
        4'b0111 :
          begin
          incr_fifo_s = 3'b011;
          end
        4'b0011 :
          begin
          incr_fifo_s = 3'b010;
          end


        default :
          begin
          incr_fifo_s = 3'b001;
          end
      endcase
      end
    end




  always @(fifoacc or incr_up_s or incr_fifo_s)
    begin : INCR_S_COMB_PROC




    if (fifoacc == 1'b1)
      begin
      incr_s = incr_up_s;
      end
    else
      begin
      incr_s = incr_fifo_s;
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : UPINXBC_A_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      for(i = 3; i >= 0; i = i - 1)
        begin
        upinbc_a[i] <= {BCWIDTH{1'b0}} ;
        end
      end
    else
      begin


      for(i = 3; i >= EPBUFFER; i = i - 1)
        begin
        upinbc_a[i] <= {BCWIDTH{1'b0}} ;
        end

      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin
        if (fiforst == 1'b1)
          begin

          upinbc_a[i] <= {BCWIDTH{1'b0}} ;
          end
        else if (upbusy[i] == 1'b1 && usbbusyclr[i] == 1'b1)
          begin

          upinbc_a[i] <= {BCWIDTH{1'b0}} ;
          end
      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
        else
      `else
        else if (i == upbuffnr)
      `endif
          begin
          upinbc_a[i] <= upinbc_nxt_s;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : UPBUSYSET_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      upbusyset <= {EPBUFFER{1'b0}} ;
      end
    else
      begin
      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin

      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
        if (setbsy == 1'b1)
      `else
        if (setbsy == 1'b1 && upbuffnr == i)
      `endif
          begin
          upbusyset[i] <= 1'b1 ;
          end
        else
          begin
          upbusyset[i] <= 1'b0 ;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : BUSY_UP_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      upbusy <= {EPBUFFER{INXCS_RV[1]}} ;
      end
    else
      begin
      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin

        if (fiforst == 1'b1)
          begin

          upbusy[i] <= 1'b0 ;
          end
        else if ((upbusy[i] == 1'b1 && usbbusyclr[i] == 1'b1) ||
                  enterhm == 1'b1 ||
                  usbresetup == 1'b1 ||
                 (discon == 1'b1 && upstren == 1'b1))
          begin


          upbusy[i] <= 1'b0 ;
          end

      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
        else if (setbsy == 1'b1)
      `else
        else if (setbsy == 1'b1 && upbuffnr == i)
      `endif
          begin
          upbusy[i] <= 1'b1 ;
          end
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBBUSYCLR_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      usbbusyclr_r <= 1'b0 ;
      end
    else
      begin
      usbbusyclr_r <= |usbbusyclr;
      end
    end



  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  always @(upbusy)
  `else
  always @(upbusy or buffering)
  `endif
    begin : UPBUSY_OR_COMB_PROC
      reg [3:0] upbusy_x;




    upbusy_x               = 4'h0 ;
    upbusy_x[EPBUFFER-1:0] = upbusy ;

    `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
            upbusy_or = ~(|upbusy_x[0]);
    `else
    case (buffering)
      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_4
        2'b11 :
            begin
            upbusy_or = ~(|upbusy_x[3:0]);
            end
        2'b10 :
            begin
            upbusy_or = ~(|upbusy_x[2:0]);
            end
      `else

      `ifdef CDNSUSBHS_EPIN_BUFFER_CC_3
        2'b10 :
            begin
            upbusy_or = ~(|upbusy_x[2:0]);
            end
      `endif
      `endif

        2'b01 :
            begin
            upbusy_or = ~(|upbusy_x[1:0]);
            end

        default :
            begin
            upbusy_or = ~(|upbusy_x[0]);
            end
    endcase
    `endif
    end



  assign irq_set = (irq_mode[1] == 1'b1) ? (upbusy_or &  usbbusyclr_r) :
                   (irq_mode[0] == 1'b1) ?             (|usbbusyclr) :
                                            (inxcs[1] & |usbbusyclr) ;




  assign inbsyfall = irq_set ;

  `ifdef CDNSUSBHS_EPIN_BUFFER_CC_1
  `else



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : UPBUFFNR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      upbuffnr_reg <= {2{1'b0}} ;
      end
    else
      begin
      if (fiforst == 1'b1)
        begin

        upbuffnr_reg <= {2{1'b0}} ;
        end
      else
        begin
        if (setbsy == 1'b1)
          begin
          if (buffering <= upbuffnr)
            begin
            upbuffnr_reg <= {2{1'b0}} ;
            end
          else
            begin
            upbuffnr_reg <= upbuffnr + 1'b1 ;
            end
          end
        end
      end
    end




  assign upbuffnr = (EPBMASK & upbuffnr_reg) ;
  `endif




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCOUTXCTRL_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcoutxctrl <= 4'h0 ;
      end
    else
      begin
      if (upaddr == ({4'b0011, EPNUMBER[3:0]}) &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1)
        begin
        hcoutxctrl <= updatai_0[3:0] ;
        end
      end
    end




  assign hcendpnr = hcoutxctrl ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCOUTXERR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcresend    <= 1'b0 ;
      hcdopingset <= 1'b0 ;
      end
    else
      begin
      if (upaddr == ({4'b0011, EPNUMBER[3:0]}) &&
          updataival_1 == 1'b1 &&
          upwr == 1'b1)
        begin
        hcresend    <= updatai_1[5] ;
        hcdopingset <= updatai_1[6] ;
        end
      else
        begin
        hcresend    <= 1'b0 ;
        hcdopingset <= 1'b0 ;
        end
      end
    end




  assign hcoutxerr = {hcerrtype, hcerrcount} ;



  assign hcoutxerrirq = &hcerrcount ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCOUTXERRIRQ_R_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcoutxerrirq_r <= 1'b0 ;
      end
    else
      begin
      hcoutxerrirq_r <= hcoutxerrirq ;
      end
    end




  assign hcerrirq = (hcoutxerrirq & ~hcoutxerrirq_r) ;




  always @(inxcon or inxcs or upinxbc or upaddr or
           hcdoping or hcoutxerr or hcoutxctrl or
           hcsof_timer_start or hcsof_timer_reload or hcsof_timer or
           hcnakidis or irq_mode)
    begin : UPDATAO_COMB_PROC
      reg [10:0] inxbc_v;


    inxbc_v              = {11{1'b0}};
    inxbc_v[BCWIDTH-1:0] = upinxbc;



    if (upaddr[7:0] == {3'b000, EPNUMBER[3:0], 1'b1})
      begin
      updatao = {3'b000, inxcs,
                 inxcon,
                 5'b00000, inxbc_v};
      end

    else if (upaddr[7:0] == {4'b0011, EPNUMBER[3:0]})
      begin
      updatao = {8'h00,
                 8'h00,
                 1'b0, hcdoping, 1'b0, hcoutxerr,
                 4'h0, hcoutxctrl};
      end

    else if (upaddr[7:0] == {4'b1001, EPNUMBER[3:0]})
      begin
      updatao = {hcsof_timer_start, 3'b000, 3'b000, hcsof_timer_reload,
                 8'h00,
                 hcsof_timer};
      end

    else if (upaddr[7:0] == {4'b1110, EPNUMBER[3:0]})
      begin
      updatao = {8'h00,
                 8'h00,
                 8'h00,
                 hcnakidis, 3'b000, 2'b00, irq_mode};
      end
    else
      begin
      updatao = {8'h00,
                 8'h00,
                 8'h00,
                 8'h00};
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCSOF_TIMER_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcsof_timer        <= 16'h0000 ;
      hcsof_timer_start  <= 1'b0 ;
      hcsof_timer_reload <= 1'b0 ;
      end
    else
      begin
      if (upstren == 1'b1 || fiforst == 1'b1)
        begin
        hcsof_timer        <= 16'h0000 ;
        hcsof_timer_start  <= 1'b0 ;
        hcsof_timer_reload <= 1'b0 ;
        end
      else if (hcsof_timer_start == 1'b1)
        begin
        if (hcsof_timer_end == 1'b1)
          begin
          hcsof_timer_start <= 1'b0 ;
          end
        end
      else if (upaddr == ({4'b1001, EPNUMBER[3:0]}) &&
               upwr == 1'b1)
        begin
        if (updataival_3 == 1'b1)
          begin
          hcsof_timer_start  <= updatai_3[7] ;
          hcsof_timer_reload <= updatai_3[0] ;
          end
        if (updataival_1 == 1'b1)
          begin
          hcsof_timer[15:8] <= updatai_1 ;
          end
        if (updataival_0 == 1'b1)
          begin
          hcsof_timer[7:0]  <= updatai_0 ;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCSOF_TIMER_STOP_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcsof_timer_stop <= 1'b0 ;
      end
    else
      begin
      if (upaddr == ({4'b1001, EPNUMBER[3:0]}) &&
          upwr == 1'b1)
        begin
        if (updataival_3 == 1'b1)
          begin
          hcsof_timer_stop <= updatai_3[6] ;
          end
        end
      else
        begin
        hcsof_timer_stop <= 1'b0;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IRQ_MODE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      irq_mode  <= 2'b00 ;
      hcnakidis <= 1'b0 ;
      end
    else
      begin
      if (upaddr == ({4'b1110, EPNUMBER[3:0]}) &&
          upwr == 1'b1)
        begin
        if (updataival_0 == 1'b1)
          begin
          irq_mode  <= updatai_0[1:0] ;
          hcnakidis <= updatai_0[7] ;
          end
        end
      end
    end

endmodule

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
//   Filename:           cdnsusbhs_epoutup.v
//   Module Name:        cdnsusbhs_epoutup
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
//   OUT endpoint - microprocessor clock domain
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_epoutup
  (
  upclk,
  uprst,
  usboutbc,
  usbbusyclr,
  isoerr,
  fiforst,

  fifoendpnr,
  fiford,

  upstren,
  buf_enable,
  buf_enable_auto,
  buf_enable_start,
  buf_enable_data,
  fifobc,

  upaddr,
  updatai_0,
  updatai_1,
  updatai_2,
  updatai_3,
  upwr,
  uprd,
  int_upbe_rd,
  int_upbe_wr,
  upbusyset,
  outxcon,
  outbsyfall,
  upfifoptrrd,

  fifoempty,

  outxmaxpck,

  hcerrtype,
  hcerrcount,
  enterhm,
  hcendpnr,
  hcresend,
  hcunderrien,
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
  parameter EPSIZE      = 32'd512;
  parameter EPBUFFER    = 32'd4;
  parameter BCWIDTH     = 32'd10;

  `include "cdnsusbhs_cusb2_params.v"


  parameter EPBMASK     = (EPBUFFER == 32'd1) ? 2'b00 :
                          (EPBUFFER == 32'd2) ? 2'b01 :
                                                2'b11 ;
  parameter OUTXCON_RVM = (EPBUFFER == 32'd3 && OUTXCON_RV[1:0] == 2'b11) ? {OUTXCON_RV[7:2], 2'b10} :
                                                                            {OUTXCON_RV[7:2], OUTXCON_RV[1:0] & EPBMASK} ;


  input                            upclk;
  input                            uprst;
  input  [4*BCWIDTH-1:0]           usboutbc;
  input  [EPBUFFER-1:0]            usbbusyclr;
  input                            isoerr;
  input                            fiforst;

  input  [3:0]                     fifoendpnr;
  input                            fiford;

  input                            upstren;
  input  [3:0]                     buf_enable;
  output                           buf_enable_auto;
  wire                             buf_enable_auto;
  output                           buf_enable_start;
  wire                             buf_enable_start;
  output [3:0]                     buf_enable_data;
  reg    [3:0]                     buf_enable_data;
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
  output [EPBUFFER-1:0]            upbusyset;
  reg    [EPBUFFER-1:0]            upbusyset;
  output [7:0]                     outxcon;
  wire   [7:0]                     outxcon;
  output                           outbsyfall;
  wire                             outbsyfall;
  output [11:0]                    upfifoptrrd;
  reg    [11:0]                    upfifoptrrd;

  output                           fifoempty;
  wire                             fifoempty;

  input  [BCWIDTH-1:0]             outxmaxpck;

  input  [2:0]                     hcerrtype;
  input  [1:0]                     hcerrcount;
  input                            enterhm;

  output [3:0]                     hcendpnr;
  wire   [3:0]                     hcendpnr;
  output                           hcresend;
  reg                              hcresend;
  output                           hcunderrien;
  reg                              hcunderrien;
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

  reg    [7:0]                     outxcon_nxt;
  reg    [7:0]                     outxcon_reg;

  reg    [4:0]                     outxcs;

  reg    [BCWIDTH-1:0]             upoutxbc;
  reg    [BCWIDTH-1:0]             upoutxbc_nxt;
  reg    [BCWIDTH-1:0]             usboutbc_a[3:0];
  reg    [BCWIDTH-1:0]             usboutbcreg_a[EPBUFFER-1:0];

  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else
  wire   [1:0]                     up_buffnr;
  reg    [1:0]                     up_buffnr_reg;
  `endif

  reg                              setbsy;
  reg    [EPBUFFER-1:0]            upbusy;

  reg                              fifoautoout;
  reg                              fifocmit;
  reg                              fifoempty_ff;
  reg    [EPBUFFER-1:0]            fifoempty_en;
  reg                              fifoempty_hm;

  wire   [BCWIDTH-1:0]             usboutbcreg;
  reg    [10:0]                    usboutbcreg_v;
  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else
  reg    [11:0]                    epsize_s;
  `ifdef CDNSUSBHS_NO_NEW_POINTER
  reg    [1:0]                     sizemod_s;
  `endif
  `endif
  reg    [11:0]                    upoutxbc_s;
  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else
  `ifdef CDNSUSBHS_NO_NEW_POINTER
  reg    [1:0]                     outxmaxpck_s;
  `endif
  `endif

  reg    [3:0]                     fifoendpnr_ff;

  reg    [3:0]                     hcinxctrl;

  wire   [4:0]                     hcinxerr;
  wire                             hcinxerrirq;
  reg                              hcinxerrirq_r;

  reg    [3:0]                     upbusy_s;

  reg    [3:0]                     buf_enable_data_r;

  wire                             epval;
  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else
  wire   [1:0]                     buffering;
  `endif

  wire                             irq_set;
  reg                              irq_set_r;
  reg                              irq_set_rr;
  reg    [1:0]                     irq_mode;

  reg                              upbusy_or;
  reg                              usbbusyclr_r;




  always @(usboutbc)
    begin : USBOUTBC_COMB_PROC
    usboutbc_a[3] = usboutbc[4*BCWIDTH-1 : BCWIDTH*(4-1)];
    usboutbc_a[2] = usboutbc[3*BCWIDTH-1 : BCWIDTH*(3-1)];
    usboutbc_a[1] = usboutbc[2*BCWIDTH-1 : BCWIDTH*(2-1)];
    usboutbc_a[0] = usboutbc[1*BCWIDTH-1 : BCWIDTH*(1-1)];
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBOUTBCREG_A_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin
        usboutbcreg_a[i] <= {BCWIDTH{1'b0}};
        end
      end
    else
      begin
      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin
        if (upbusy[i] == 1'b1 && usbbusyclr[i] == 1'b1)
          begin
          usboutbcreg_a[i] <= usboutbc_a[i];
          end
        end
      end
    end



  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  assign usboutbcreg = usboutbcreg_a[0] ;
  `else
  assign usboutbcreg = usboutbcreg_a[up_buffnr] ;
  `endif




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFOENDPNRFF_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoendpnr_ff <= 4'h0;
      end
    else
      begin
      fifoendpnr_ff <= fifoendpnr;
      end
    end




  always @(upwr or upaddr or int_upbe_wr or

           fifoautoout or fiford or fifocmit or fifoendpnr_ff or
           usboutbcreg or upoutxbc)
    begin : SETBSY_COMB_PROC
      reg [BCWIDTH+1:0] outxbc_v;

    outxbc_v = ({2'b10, usboutbcreg} -
                {2'b00, upoutxbc});



    setbsy   = 1'b0;

    if (upaddr == ({3'b000, EPNUMBER[3:0], 1'b0}) &&
        int_upbe_wr[3] == 1'b1 &&
        upwr == 1'b1)
      begin
      setbsy = 1'b1;
      end
    else if ((fifoautoout == 1'b1 || fifocmit == 1'b1) &&
              fifoendpnr_ff == EPNUMBER[3:0])
      begin






      if (fiford == 1'b1)
        begin


        if (|outxbc_v[BCWIDTH:3] == 1'b0 && (outxbc_v[2:0] == 3'b100 ||
                                             outxbc_v[2]   == 1'b0))
          begin
          setbsy = 1'b1;
          end
        end
      end
    end

  `ifdef CDNSUSBHS_NO_NEW_POINTER
  `else



  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else
  always @(up_buffnr or outxmaxpck)
    begin : UPFIFOPTRRD_COMB_PROC
      reg [11:0] outxmaxpck_v;

    outxmaxpck_v = 12'h000;
    case (outxmaxpck[1:0])
      2'b11   : outxmaxpck_v[BCWIDTH-1:0] = outxmaxpck[BCWIDTH-1:0] + 1'b1;
      2'b10   : outxmaxpck_v[BCWIDTH-1:0] = outxmaxpck[BCWIDTH-1:0] + 2'b10;
      2'b01   : outxmaxpck_v[BCWIDTH-1:0] = outxmaxpck[BCWIDTH-1:0] + 2'b11;
      default : outxmaxpck_v[BCWIDTH-1:0] = outxmaxpck[BCWIDTH-1:0];
    endcase


    case (up_buffnr)
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



  always @(upoutxbc_nxt)
    begin : UPOUTXBC_S_COMB_PROC

    upoutxbc_s              = {12{1'b0}};
    upoutxbc_s[BCWIDTH-1:0] = upoutxbc_nxt;
    end




  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  always @(upoutxbc_s)
    begin : UPFIFOPTRRD_WRITE_PROC

    upfifoptrrd = upoutxbc_s;
    end
  `else
  always @(upoutxbc_s or epsize_s)
    begin : UPFIFOPTRRD_WRITE_PROC

    upfifoptrrd = epsize_s + upoutxbc_s;
    end
  `endif
  `endif

  `ifdef CDNSUSBHS_NO_NEW_POINTER



  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  always @(upoutxbc_nxt or outxmaxpck)
  `else
  always @(upoutxbc_nxt or up_buffnr or outxmaxpck)
  `endif
    begin : UPFIFOPTRRD_COMB_PROC
      reg [11:0] upoutxbc_v;
      reg [11:0] outxmaxpck_v;
    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
    `else
    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_4
      reg [8:0]  outxmaxpcksum_v;
    `endif
    `endif


    upoutxbc_v                = {12{1'b0}};
    upoutxbc_v[BCWIDTH-1:0]   = upoutxbc_nxt;

    outxmaxpck_v              = 12'h000;
    outxmaxpck_v[BCWIDTH-1:0] = outxmaxpck;

    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
    `else

    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_4
    outxmaxpcksum_v = {9{1'b0}};
    outxmaxpcksum_v = outxmaxpck_v[11:3] +
                      outxmaxpck_v[10:2];
    `endif





    case (up_buffnr)
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
    upoutxbc_s   = upoutxbc_v;
    end




  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  always @(upoutxbc_s)
    begin : UPFIFOPTRRD_WRITE_PROC

    upfifoptrrd = upoutxbc_s;
    end

  `else
  always @(upoutxbc_s or outxmaxpck_s or epsize_s or sizemod_s)
    begin : UPFIFOPTRRD_WRITE_PROC
      reg [11:0] upfifoptrrd_v;

    upfifoptrrd_v = epsize_s + upoutxbc_s;


    if (outxmaxpck_s[0] == 1'b1 ||
        outxmaxpck_s[1] == 1'b1)
      begin
      upfifoptrrd = upfifoptrrd_v + {8'h00, sizemod_s, 2'b00};
      end
    else
      begin
      upfifoptrrd = upfifoptrrd_v;
      end
    end
   `endif
  `endif



  assign epval     = outxcon[7];
  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else
  assign buffering = outxcon[1:0];
  `endif




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFOEMPTY_FF_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoempty_ff <= 1'b1;
      end
    else
      begin
      if (setbsy == 1'b1)
        begin
        fifoempty_ff <= 1'b1;
        end
      else
        begin
        fifoempty_ff <= 1'b0;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFOEMPTY_HM_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoempty_hm <= 1'b1;
      end
    else
      begin
      if (setbsy == 1'b1 ||
         (fiforst == 1'b1 && upstren == 1'b1) ||
          usbbusyclr != {EPBUFFER{1'b0}})
        begin
        fifoempty_hm <= 1'b0;
        end
      else if (enterhm == 1'b1 || fiforst == 1'b1)
        begin
        fifoempty_hm <= 1'b1;
        end
      end
    end




  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  assign fifoempty = (fifoautoout == 1'b0 &&
                      fifocmit    == 1'b0) ? 1'b1 :
                                            (upbusy[0]         | fifoempty_ff | fifoempty_hm | setbsy);
  `else
  assign fifoempty = (fifoautoout == 1'b0 &&
                      fifocmit    == 1'b0) ? 1'b1 :
                                            (upbusy[up_buffnr] | fifoempty_ff | fifoempty_hm | setbsy);
  `endif



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : AUTOOUT_BIT_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoautoout <= OUTXCS_RV[4];
      end
    else
      begin
      if (upaddr == FIFOCTRL_ID[9:2] &&
          updatai_0[4] == 1'b0 &&
          int_upbe_wr[0] == 1'b1 &&
          upwr == 1'b1 &&
         (updatai_0[3:0] == EPNUMBER[3:0] || updatai_0[3:0] == 4'b0000))
        begin

        fifoautoout <= updatai_0[5];
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : COMMITOUT_BIT_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifocmit <= 1'b0;
      end
    else
      begin
      if (upaddr == FIFOCTRL_ID[9:2] &&
          updatai_0[4] == 1'b0 &&
          int_upbe_wr[0] == 1'b1 &&
          upwr == 1'b1 &&
         (updatai_0[3:0] == EPNUMBER[3:0] || updatai_0[3:0] == 4'b0000))
        begin

        fifocmit <= updatai_0[6];
        end
      else
        begin

        `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
        if (fifoempty_en[0] == 1'b1 && setbsy == 1'b1)
        `else
        if (fifoempty_en[up_buffnr] == 1'b1 && setbsy == 1'b1)
        `endif
          begin
          fifocmit <= 1'b0;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCINXCTRL_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcinxctrl <= 4'h0 ;
      end
    else
      begin
      if (upaddr == ({4'b0011, EPNUMBER[3:0]}) &&
          int_upbe_wr[2] == 1'b1 &&
          upwr == 1'b1)
        begin
        hcinxctrl <= updatai_2[3:0] ;
        end
      end
    end




  assign hcendpnr = hcinxctrl ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCINXERR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcresend    <= 1'b0 ;
      hcunderrien <= 1'b0 ;
      end
    else
      begin
      if (upaddr == {4'b0011, EPNUMBER[3:0]} &&
          int_upbe_wr[3] == 1'b1 &&
          upwr == 1'b1)
        begin
        hcresend    <= updatai_3[5] ;
        hcunderrien <= updatai_3[7] ;
        end
      else
        begin
        hcresend    <= 1'b0 ;
        end
      end
    end




  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  always @(upbusy)
  `else
  always @(upbusy or buffering)
  `endif
    begin : UPBUSY_S_COMB_PROC
      reg [3:0] upbusy_v;




    upbusy_v               = 4'hF ;
    upbusy_v[EPBUFFER-1:0] = upbusy ;

    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
          upbusy_s = {3'b111, upbusy_v[0]} ;
    `else

    case (buffering)
      `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_4
      2'b11 :
          begin
          upbusy_s = upbusy_v ;
          end
      2'b10 :
          begin
          upbusy_s = {1'b1,   upbusy_v[2:0]} ;
          end
      `else

      `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_3
      2'b10 :
          begin
          upbusy_s = {1'b1,   upbusy_v[2:0]} ;
          end
      `endif
      `endif

      2'b01 :
          begin
          upbusy_s = {2'b11,  upbusy_v[1:0]} ;
          end

      default :
          begin
          upbusy_s = {3'b111, upbusy_v[0]} ;
          end
    endcase
    `endif
    end






  always @(upbusy_s or isoerr or fifoautoout)
    begin : OUTXCS_COMB_PROC





    outxcs[0] = isoerr;


    outxcs[1] = &upbusy_s;


    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
            outxcs[3:2] = 2'b00;
    `else
    case (upbusy_s)
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


    outxcs[4] = fifoautoout;
    end









  always @(upaddr or upwr or updatai_2 or int_upbe_wr or outxcon)
    begin : OUTXCON_NXT_COMB_PROC


    outxcon_nxt = outxcon;


    if (upaddr == ({3'b000, EPNUMBER[3:0], 1'b0}) &&
        int_upbe_wr[2] == 1'b1 &&
        upwr == 1'b1)
      begin
      outxcon_nxt = updatai_2;
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUTXCON_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      outxcon_reg <= OUTXCON_RVM;
      end
    else
      begin
      outxcon_reg <= outxcon_nxt;
      end
    end




  assign outxcon = (EPBUFFER == 32'd3 && outxcon_reg[1:0] == 2'b11) ? {outxcon_reg[7:2], 2'b10} :
                                                                      {outxcon_reg[7:2], (EPBMASK & outxcon_reg[1:0])} ;




  always @(upoutxbc or fiforst or
           fiford or fifoendpnr_ff or
           uprd or int_upbe_rd or setbsy)
    begin : UPOUTXBC_NXT_COMB_PROC


    upoutxbc_nxt = upoutxbc;

    if (fiforst == 1'b1 || setbsy == 1'b1)
      begin


      upoutxbc_nxt = {BCWIDTH{1'b0}};
      end
    else
      begin

      if (uprd == 1'b1)
        begin
        case (int_upbe_rd)
            4'hF :
                begin

                upoutxbc_nxt = upoutxbc + 3'b100;
                end

            4'h3 :
                begin

                upoutxbc_nxt = upoutxbc + 3'b010;
                end
            default :
                begin

                upoutxbc_nxt = upoutxbc + 3'b001;
                end
        endcase
        end

      else if (fiford == 1'b1 && fifoendpnr_ff == EPNUMBER[3:0])
        begin

        upoutxbc_nxt = upoutxbc + 3'b100;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : UPOUTXBC_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      upoutxbc <= {BCWIDTH{1'b0}};
      end
    else
      begin
      upoutxbc <= upoutxbc_nxt;
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

        `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
        if (setbsy == 1'b1)
        `else
        if (setbsy == 1'b1 && up_buffnr == i)
        `endif
          begin
          upbusyset[i] <= 1'b1;
          end
        else
          begin
          upbusyset[i] <= 1'b0;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : BUSY_UP_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      upbusy <= {EPBUFFER{OUTXCS_RV[1]}};
      end
    else
      begin
      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin

        if (fiforst == 1'b1 && upstren == 1'b1)
          begin

          upbusy[i] <= 1'b1;
          end
        else if ((upbusy[i] == 1'b1 && usbbusyclr[i] == 1'b1) ||
                  enterhm == 1'b1 ||
                  fiforst == 1'b1)
          begin


          upbusy[i] <= 1'b0;
          end

        `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
        else if (setbsy == 1'b1)
        `else
        else if (setbsy == 1'b1 && up_buffnr == i)
        `endif
          begin
          upbusy[i] <= 1'b1;
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



  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  always @(upbusy)
  `else
  always @(upbusy or buffering)
  `endif
    begin : UPBUSY_OR_COMB_PROC
      reg [3:0] upbusy_x;




    upbusy_x               = 4'h0 ;
    upbusy_x[EPBUFFER-1:0] = upbusy ;

    `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
          upbusy_or = ~(|upbusy_x[0]) ;
    `else

    case (buffering)
      `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_4
      2'b11 :
          begin
          upbusy_or = ~(|upbusy_x[3:0]) ;
          end
      2'b10 :
          begin
          upbusy_or = ~(|upbusy_x[2:0]) ;
          end
      `else

      `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_3
      2'b10 :
          begin
          upbusy_or = ~(|upbusy_x[2:0]) ;
          end
      `endif
      `endif

      2'b01 :
          begin
          upbusy_or = ~(|upbusy_x[1:0]) ;
          end

      default :
          begin
          upbusy_or = ~(|upbusy_x[0]) ;
          end
    endcase
    `endif
    end



  assign irq_set = (irq_mode[1] == 1'b1) ? (upbusy_or &  usbbusyclr_r) :
                   (irq_mode[0] == 1'b1) ?             (|usbbusyclr) :
                                           (outxcs[1] & |usbbusyclr) ;



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCOUTBSYFALL_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      irq_set_r  <= 1'b0;
      irq_set_rr <= 1'b0;
      end
    else
      begin
      irq_set_r  <= irq_set;
      irq_set_rr <= irq_set_r;
      end
    end




  assign outbsyfall = (upstren == 1'b1) ? irq_set :
                                          irq_set_rr ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFOEMPTY_EN_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoempty_en <= {EPBUFFER{1'b0}};
      end
    else
      begin
      for(i = (EPBUFFER-1); i >= 0; i = i - 1)
        begin

        if (enterhm == 1'b1 ||
            fiforst == 1'b1)
          begin

          fifoempty_en[i] <= 1'b0;
          end
        else if (usbbusyclr[i] == 1'b1)
          begin

          fifoempty_en[i] <= 1'b1;
          end
        `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
        else if (setbsy == 1'b1)
        `else
        else if (setbsy == 1'b1 && up_buffnr == i)
        `endif
          begin
          fifoempty_en[i] <= 1'b0;
          end
        end
      end
    end

  `ifdef CDNSUSBHS_EPOUT_BUFFER_CC_1
  `else



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : UP_BUFFNR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      up_buffnr_reg <= 2'b00;
      end
    else
      begin
      if (fiforst == 1'b1)
        begin

        up_buffnr_reg <= 2'b00;
        end
      else
        begin
        if (setbsy == 1'b1)
          begin
          if (buffering <= up_buffnr)
            begin
            up_buffnr_reg <= 2'b00;
            end
          else
            begin
            up_buffnr_reg <= up_buffnr + 1'b1;
            end
          end
        end
      end
    end




  assign up_buffnr = (EPBMASK & up_buffnr_reg);
  `endif




  assign hcinxerr = {hcerrtype, hcerrcount};



  assign hcinxerrirq = &hcerrcount ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCINXERRIRQ_R_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcinxerrirq_r <= 1'b0 ;
      end
    else
      begin
      hcinxerrirq_r <= hcinxerrirq ;
      end
    end




  assign hcerrirq = (hcinxerrirq & ~hcinxerrirq_r) ;



  always @(usboutbcreg)
    begin : OUTXBC_COMB_PROC
    usboutbcreg_v              = {11{1'b0}};
    usboutbcreg_v[BCWIDTH-1:0] = usboutbcreg;
    end



  assign fifobc = usboutbcreg_v;




  always @(outxcon or outxcs or upaddr or usboutbcreg_v or
           hcinxerr or hcinxctrl or
           hcsof_timer_start or hcsof_timer_reload or hcsof_timer or
           hcnakidis or irq_mode)
    begin : UPDATAO_COMB_PROC





    if (upaddr[7:0] == {3'b000, EPNUMBER[3:0], 1'b0})
      begin
      updatao = {3'b000, outxcs,
                 outxcon,
                 5'b00000, usboutbcreg_v};
      end

    else if (upaddr[7:0] == {4'b0011, EPNUMBER[3:0]})
      begin
      updatao = {3'b000, hcinxerr,
                 4'h0, hcinxctrl,
                 8'h00,
                 8'h00};
      end

    else if (upaddr[7:0] == {4'b1000, EPNUMBER[3:0]})
      begin
      updatao = {hcsof_timer_start, 3'b000, 3'b000, hcsof_timer_reload,
                 8'h00,
                 hcsof_timer};
      end

    else if (upaddr[7:0] == {4'b1110, EPNUMBER[3:0]})
      begin
      updatao = {8'h00,
                 hcnakidis, 3'b000, 2'b00, irq_mode,
                 8'h00,
                 8'h00};
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
    begin : DMA_BUF_ENABLE_DATA_R_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      buf_enable_data_r <= 4'h0;
      end
    else
      begin
      buf_enable_data_r <= buf_enable;
      end
    end



  assign buf_enable_auto = fifoautoout ;



  assign buf_enable_start = (epval             == 1'b0) ?  1'b0 :

                            (fifoautoout       == 1'b0) ?  1'b0 :
                            (buf_enable_data_r == 4'h0) ? (buf_enable != 4'h0) :
                                                           1'b0 ;



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : BUF_ENABLE_REQ_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      buf_enable_data <= 4'h0;
      end
    else
      begin

      if (|upbusyset == 1'b1)
        begin
        buf_enable_data <= buf_enable;
        end
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
      else if (upaddr == ({4'b1000, EPNUMBER[3:0]}) &&
               upwr == 1'b1)
        begin
        if (int_upbe_wr[3] == 1'b1)
          begin
          hcsof_timer_start  <= updatai_3[7] ;
          hcsof_timer_reload <= updatai_3[0] ;
          end
        if (int_upbe_wr[1] == 1'b1)
          begin
          hcsof_timer[15:8] <= updatai_1 ;
          end
        if (int_upbe_wr[0] == 1'b1)
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
      if (upaddr == ({4'b1000, EPNUMBER[3:0]}) &&
          upwr == 1'b1)
        begin
        if (int_upbe_wr[3] == 1'b1)
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
        if (int_upbe_wr[2] == 1'b1)
          begin
          irq_mode  <= updatai_2[1:0] ;
          hcnakidis <= updatai_2[7] ;
          end
        end
      end
    end

endmodule

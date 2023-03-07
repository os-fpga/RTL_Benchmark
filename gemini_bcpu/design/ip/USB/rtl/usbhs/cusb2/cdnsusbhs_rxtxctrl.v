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
//   Filename:           cdnsusbhs_rxtxctrl.v
//   Module Name:        cdnsusbhs_rxtxctrl
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
//   Receiver and transmitter FSM
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_rxtxctrl
  (
  usbclk,
  usbrst,
  dvi,
  fifodatai,
  testmode,
  testmodesel,
  hsmode,
  sendpid,
  sendhshk,
  sendpckt,
  sendzeroiso,
  settoken,
  receive,
  drivechirpk,
  resumereq,
  busyff,
  tokenok,
  timeout,
  utmitxready,
  utmirxactive,
  utmirxerror,
  utmirxvalid,
  utmidataout,
  txfiford,
  rxfifowr,
  overflowwr,
  outwr,
  fifodatao,
  tfnaddr,
  tendp,
  tendpnxt,
  tfrmnr,
  tfrmnrm,
  pid,
  piderr,
  usberr,
  rcvfall,
  txfall,
  lpm_token,
  clrmfrmnrack,
  clrmfrmnr,
  sofirq,

  sendtok,
  hctoken,
  drivechirpj,
  hcepnr,
  upstren,
  lsmode,
  rxactiveff,
  rxtxidle,

  usbreset,

  linestate,
  opmode,
  xcvrselect,

  debug_rx_req,
  debug_rx,
  debug_tx_req,
  debug_tx,

  workaround_a_req,
  workaround_a_enable,
  workaround_b_enable,
  workaround_c_enable,
  workaround_d_enable,
  workaround_sfr_rst,
  workaround_a_value,
  workaround_rst,



  utmitxvalid,
  utmitxvalidl,
  utmidatain,
  ince
  );

  `include "cdnsusbhs_cusb2_params.v"

  input                            usbclk;
  input                            usbrst;
  input                            dvi;
  input  [7:0]                     fifodatai;
  input                            testmode;
  input  [1:0]                     testmodesel;
  input                            hsmode;
  input  [3:0]                     sendpid;
  input                            sendhshk;
  input                            sendpckt;
  input                            sendzeroiso;
  input                            settoken;
  input                            receive;
  input                            drivechirpk;
  input                            resumereq;
  input                            busyff;
  input                            tokenok;
  input                            timeout;
  input                            utmitxready;
  input                            utmirxactive;
  input                            utmirxerror;
  input                            utmirxvalid;
  input  [7:0]                     utmidataout;
  output                           txfiford;
  wire                             txfiford;
  output                           rxfifowr;
  wire                             rxfifowr;
  output                           overflowwr;
  wire                             overflowwr;
  output                           outwr;
  wire                             outwr;
  output [7:0]                     fifodatao;
  wire   [7:0]                     fifodatao;
  output [6:0]                     tfnaddr;
  wire   [6:0]                     tfnaddr;
  output [3:0]                     tendp;
  wire   [3:0]                     tendp;
  output [3:0]                     tendpnxt;
  wire   [3:0]                     tendpnxt;
  output [10:0]                    tfrmnr;
  wire   [10:0]                    tfrmnr;
  output [2:0]                     tfrmnrm;
  reg    [2:0]                     tfrmnrm;
  output [4:0]                     pid;
  wire   [4:0]                     pid;
  output                           piderr;
  wire                             piderr;
  output                           usberr;
  wire                             usberr;
  output                           rcvfall;
  wire                             rcvfall;
  output                           txfall;
  wire                             txfall;
  output [8:0]                     lpm_token;
  reg    [8:0]                     lpm_token;
  input                            clrmfrmnrack;
  output                           clrmfrmnr;
  reg                              clrmfrmnr;
  input                            sofirq;

  input                            sendtok;
  input  [10:0]                    hctoken;
  input                            drivechirpj;
  input  [3:0]                     hcepnr;
  input                            upstren;
  input                            lsmode;
  output                           rxactiveff;
  wire                             rxactiveff;
  output                           rxtxidle;
  wire                             rxtxidle;

  input                            usbreset;

  input  [1:0]                     linestate;
  input  [1:0]                     opmode;
  input  [1:0]                     xcvrselect;

  output                           debug_rx_req;
  reg                              debug_rx_req;
  output [18:0]                    debug_rx;
  reg    [18:0]                    debug_rx;
  output                           debug_tx_req;
  reg                              debug_tx_req;
  output [14:0]                    debug_tx;
  reg    [14:0]                    debug_tx;

  output                           workaround_a_req;
  wire                             workaround_a_req;
  input                            workaround_a_enable;
  input                            workaround_b_enable;
  input                            workaround_c_enable;
  input                            workaround_d_enable;
  input                            workaround_sfr_rst;
  input  [3:0]                     workaround_a_value;
  output                           workaround_rst;
  wire                             workaround_rst;



  output                           utmitxvalid;
  wire                             utmitxvalid;
  output                           utmitxvalidl;
  wire                             utmitxvalidl;
  output [7:0]                     utmidatain;
  reg    [7:0]                     utmidatain;
  output                           ince;
  wire                             ince;




  parameter RIDLE                  = 2'b00;
  parameter RPDAT                  = 2'b01;
  parameter RDDAT                  = 2'b10;
  parameter RERR                   = 2'b11;

  reg    [1:0]                     rxfsm_st;

  reg    [1:0]                     rxfsm_nxt;

  parameter TIDLE                  = 4'b0000;
  parameter TPCRC                  = 4'b0001;
  parameter THSHK                  = 4'b0010;
  parameter TDDAT                  = 4'b0011;
  parameter TDCRC                  = 4'b0100;
  parameter TCCRC                  = 4'b0101;
  parameter TCRC                   = 4'b0110;
  parameter TPTOK                  = 4'b0111;
  parameter TTOK                   = 4'b1000;
  parameter TTOKCRC                = 4'b1001;

  reg    [3:0]                     txfsm_st;

  reg    [3:0]                     txfsm_nxt;

  reg    [7:0]                     databuf8;
  reg    [7:0]                     dbuf0;
  reg    [15:0]                    crcreg;
  reg    [15:0]                    crcreg_nxt;
  reg    [15:0]                    crcregrcv;
  reg    [15:0]                    crcregrcv_nxt;
  wire                             rxhold;
  reg    [6:0]                     tfnaddr_s;
  reg    [4:0]                     packetid;
  reg                              pid_err;
  reg                              usb_err;
  reg                              rxactive_ff;
  reg                              rxfifowr_ff;
  reg                              rxactive;
  reg                              rxerror;
  reg                              rxvalid;
  reg                              rxvalid_ff;

  reg    [7:0]                     dataout;
  reg                              tx_fall;
  reg                              txvalid;
  wire                             rxfifo_wr;
  reg    [10:0]                    frmnr;
  reg                              rcvdisable_ff;
  reg                              rcvdisable_ff1;
  reg                              rcvdisable_ff2;
  wire                             rcvdisable;
  reg    [7:0]                     txdatai;

  wire   [10:0]                    din_s1;
  wire   [7:0]                     din_s2;
  reg                              crcsel_s1;
  reg                              crcsel_s2;
  reg                              crc_err_s;
  wire   [4:0]                     packetid_s;

  reg    [3:0]                     frmnr10_7;
  reg    [3:0]                     t_endp;
  reg    [6:0]                     tpcounter;
  reg    [7:0]                     testpack;
  reg    [7:0]                     testpack8_s;
  wire                             txfifo_rd;
  reg                              dvi_r;

  reg                              packetid_fix;

  wire   [7:0]                     hctoken_s;
  reg                              testmode_r;
  reg                              timeout_r;


  reg                              workaround_reset_r;
  wire                             workaround_reset;

  reg    [1:0]                     linestate_r1;
  reg    [1:0]                     linestate_r2;
  reg    [1:0]                     opmode_r1;
  reg    [1:0]                     opmode_r2;

  reg                              usbreset_r;
  reg                              usbreset_r2;
  reg                              usbreset_r3;
  reg                              usbreset_r4;

  reg                              utmitxvalid_r;
  wire                             utmitxvalid_fall;
  wire                             utmitxvalid_rise;

  reg                              hs_tx;
  reg                              hs_tx_r;

  reg                              hs_rx_start;
  reg     [3:0]                    hs_rx_counter;
  wire                             hs_rx_tmout;
  reg                              hs_rx_tmout_r;

  reg    [10:0]                    debug_tx_bytes;
  reg    [3:0]                     debug_tx_sendpid;

  reg    [10:0]                    debug_rx_bytes;
  wire   [3:0]                     debug_rx_error;
  reg                              debug_rx_rxerr;

  wire                             rcvfall_active;
  wire                             workaround_a;
  wire                             workaround_b;
  wire                             workaround_b_req;
  wire                             workaround_c;
  wire                             workaround_c_req;
  wire                             workaround_d;
  wire                             workaround_d_req;







  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : INPUTREGS_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      rxactive    <= 1'b0;
      rxerror     <= 1'b0;
      rxvalid     <= 1'b0;
      dataout     <= {8{1'b0}};
      rxactive_ff <= 1'b0;
      testmode_r  <= 1'b0;
      end
    else
      begin
      rxactive    <= utmirxactive;
      rxerror     <= utmirxerror;
      rxvalid     <= utmirxvalid;
      rxactive_ff <= rxactive;
      testmode_r  <= testmode;
      if (rcvdisable == 1'b0)
        begin
        dataout <= utmidataout;
        end
      end
    end




  assign rxactiveff = rxactive_ff ;




  assign txfifo_rd =   (utmitxready == 1'b1 && txfsm_st == TDDAT &&
                        tx_fall == 1'b0) ? 1'b1 :
                                           1'b0;




  assign txfiford = ((packetid == PID_IN &&
                      rxactive == 1'b0 && rxactive_ff == 1'b1 &&
                      busyff == 1'b1 &&
                      tokenok == 1'b1
                     ) ||
                     ((sendpid == PID_OUT[3:0] || sendpid == PID_SETUP[3:0]) &&
                      tx_fall == 1'b1
                     ) ||
                      txfifo_rd == 1'b1) ? 1'b1 :
                                           1'b0 ;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DVI_R_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      dvi_r <=  1'b0 ;
      end
    else
      begin
      if ((packetid == PID_IN &&
           rxactive == 1'b0 &&
           rxactive_ff == 1'b1 &&
           busyff == 1'b1
          ) || ((sendpid == PID_OUT[3:0] ||
                 sendpid == PID_SETUP[3:0]) && tx_fall == 1'b1

          ) || txfifo_rd == 1'b1)
        begin
        dvi_r <= dvi;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : RXVALID_FF_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      rxvalid_ff <= 1'b0;
      end
    else
      begin
      if (rxactive == 1'b1)
        begin
        if (rxvalid == 1'b1)
          begin
          rxvalid_ff <= 1'b1;
          end
        end
      else
        begin
        rxvalid_ff <= 1'b0;
        end
      end
    end




  assign rcvfall = rxactive_ff & ~rxactive & rxvalid_ff;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TX_FALL_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      tx_fall <= 1'b0;
      end
    else
      begin
      if (utmitxready == 1'b1 && (
                                    txfsm_st == TCRC    ||
                                  ((txfsm_st == TTOKCRC ||
                                    txfsm_st == THSHK) && upstren == 1'b0)
                                 ))
        begin
        tx_fall <= 1'b1;
        end
      else
        begin
        tx_fall <= 1'b0;
        end
      end
    end




  assign txfall = tx_fall;




  assign rxhold = (rxactive == 1'b1 &&
                   rxvalid  == 1'b0)  ? 1'b1 :
                                        1'b0;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : RXFIFOWR_FF_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      rxfifowr_ff <= 1'b0;
      end
    else
      begin
      if (rxfsm_st == RDDAT &&
          receive == 1'b1 &&
          rxhold == 1'b0)
        begin

        rxfifowr_ff <= 1'b1;
        end
      else if (receive == 1'b0)
        begin
        rxfifowr_ff <= 1'b0;
        end
      end
    end




  assign rxfifo_wr = (rxfifowr_ff == 1'b1 &&
                      rxactive == 1'b1 &&
                      rxfsm_st == RDDAT &&
                      receive == 1'b1 &&
                      rxhold == 1'b0) ? 1'b1 :
                                        1'b0 ;




  assign rxfifowr = rxfifo_wr;




  assign outwr = rxfifo_wr & ~settoken;




  assign overflowwr = (rxactive == 1'b1 &&
                       rxfsm_st == RDDAT &&
                       rxhold == 1'b0) ? 1'b1 :
                                         1'b0 ;








  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DBUF0_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      dbuf0 <= 8'h00;
      end
    else
      begin
      if ((rxfsm_st == RPDAT ||
           rxfsm_st == RDDAT) && rxhold == 1'b0)
        begin

        dbuf0 <= databuf8;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DATABUF8_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      databuf8 <= 8'h00;
      end
    else
      begin
      if (rxvalid    == 1'b1 &&
          rcvdisable == 1'b0 &&
          !(rxfsm_st == RDDAT && (packetid == PID_SOF ||
                                  packetid == SUBPID_LPM)))
        begin
        databuf8 <= dataout[7:0];
        end
      end
    end




  assign fifodatao = dbuf0;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : PACKETID_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      packetid <= 5'b00000;
      pid_err  <= 1'b1;
      end
    else
      begin
      if (usbreset == 1'b1)
        begin
        packetid <= 5'b00000;
        pid_err <= 1'b1;
        end
      else if (rxactive == 1'b0)
        begin
        pid_err <= 1'b1;
        end
      else if (rxfsm_st == RIDLE &&
               rxhold == 1'b0)
        begin

        packetid <= {packetid_fix, dataout[3:0]};

        if (dataout[3:0] == ~dataout[7:4])
          begin
          pid_err <= 1'b0;
          end
        else
          begin
          pid_err <= 1'b1;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : PIDEXT_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      packetid_fix <= 1'b0;
      end
    else
      begin
      if (upstren == 1'b0 || usbreset == 1'b1)
        begin
        packetid_fix <= 1'b0;
        end
      else
        begin
        if ((rxactive == 1'b1 && rxerror == 1'b1) ||
            (timeout == 1'b1 && timeout_r == 1'b0))
          begin
          packetid_fix <= 1'b0;
          end
        else
          begin
          if (rxfsm_st == RIDLE &&
              rxactive == 1'b1 &&
              rxhold   == 1'b0)
            begin

            if (dataout[3:0] == 4'b0000 &&
                dataout[7:4] == 4'b1111)
              begin
              packetid_fix <= 1'b1;
              end
            else
              begin
              packetid_fix <= 1'b0;
              end
            end
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TIME_OUT_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      timeout_r <= 1'b0;
      end
    else
      begin
      timeout_r <= timeout;
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : RCVDISABLE_FF_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      rcvdisable_ff <= 1'b0;
      end
    else
      begin
      if (rxfsm_st == RIDLE &&
          rxactive == 1'b1 &&
          rxhold == 1'b0)
        begin

        if ({1'b0, dataout[3:0]} == PID_SETUP ||
            {1'b0, dataout[3:0]} == PID_EXT   ||
            {1'b0, dataout[3:0]} == PID_IN    ||
            {1'b0, dataout[3:0]} == PID_OUT   ||
            {1'b0, dataout[3:0]} == PID_PING)
          begin
          rcvdisable_ff <= 1'b1;
          end
        end
      else if (rxactive_ff == 1'b1 &&
               rxactive == 1'b0)
        begin

        rcvdisable_ff <= 1'b0;
        end
      end
    end




  assign pid = packetid;




  assign piderr = pid_err;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : RCVDISABLE_FF1_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      rcvdisable_ff1 <= 1'b0;
      end
    else
      begin
      if (rxactive_ff == 1'b1 && rxactive == 1'b0)
        begin
        rcvdisable_ff1 <= 1'b0;
        end
      else if (rxhold == 1'b0)
        begin
        rcvdisable_ff1 <= rcvdisable_ff;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : RCVDISABLE_FF2_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      rcvdisable_ff2 <= 1'b0;
      end
    else
      begin
      if (rxactive_ff == 1'b1 && rxactive  == 1'b0)
        begin
        rcvdisable_ff2 <= 1'b0;
        end
      else if (rxhold  == 1'b0 && rcvdisable_ff1 == 1'b1)
        begin
        rcvdisable_ff2 <= 1'b1;
        end
      end
    end




  assign rcvdisable = (rcvdisable_ff1 & ~rxhold) | rcvdisable_ff2;




  always @(packetid or crcregrcv_nxt)
    begin : CRC_ERR_S_COMB_PROC



    case (packetid)
        PID_MDATA,
        PID_DATA0,
        PID_DATA1,
        PID_DATA2 :
            begin

            if (crcregrcv_nxt == 16'h800D)
              begin
              crc_err_s = 1'b0;
              end
            else
              begin
              crc_err_s = 1'b1;
              end
            end







        default :
            begin

            if (crcregrcv_nxt[4:0] == 5'b01100)
              begin
              crc_err_s = 1'b0;
              end
            else
              begin
              crc_err_s = 1'b1;
              end
            end
    endcase
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBERR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usb_err <= 1'b1;
      end
    else
      begin
      if ((rxactive_ff == 1'b1 && rxactive == 1'b0) ||
           rxfsm_st == RERR ||
           rxfsm_nxt == RERR ||
           tx_fall == 1'b1)
        begin
        usb_err <= 1'b1;
        end
      else if (rxvalid == 1'b1)
        begin
        usb_err <= crc_err_s;
        end
      end
    end




  assign usberr = usb_err;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TFNADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      tfnaddr_s <= {7{1'b0}};
      frmnr10_7 <= {4{1'b0}};
      end
    else
      begin
      if (pid_err == 1'b0 &&
          rxhold == 1'b0)
        begin
        if ((packetid == PID_OUT   ||
             packetid == PID_IN    ||
             packetid == PID_PING  ||
             packetid == PID_SETUP ||
             packetid == PID_EXT   ||
             packetid == PID_SOF)  && rxfsm_st == RDDAT && rxactive == 1'b1)
          begin
          tfnaddr_s   <= databuf8[6:0];
          frmnr10_7   <= {dataout[2:0], databuf8[7]};
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SUBPID_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      lpm_token <= {9{1'b0}};
      end
    else
      begin
      if (pid_err == 1'b0 && rxhold == 1'b0 && crc_err_s == 1'b0)
        begin
        if (packetid == SUBPID_LPM && rxfsm_st == RDDAT && rxactive == 1'b1)
          begin
          lpm_token <= {dataout[0], databuf8[7:0]};
          end
        end
      end
    end




  assign ince = ((packetid == PID_IN &&
                  rxactive == 1'b0 && rxactive_ff == 1'b1 &&
                  busyff == 1'b1 &&
                  tokenok == 1'b1) ||
                 ((sendpid == PID_OUT[3:0] ||
                   sendpid == PID_SETUP[3:0]) && tx_fall == 1'b1) ||
                 (txfifo_rd == 1'b1 && dvi == 1'b1)) ? 1'b1 :
                                                       1'b0;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : FRMNR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      frmnr <= {11{1'b0}};
      end
    else
      begin
      if (pid_err == 1'b0 &&
          rxhold == 1'b0 &&
          usb_err == 1'b0 &&
          rxactive_ff == 1'b1 &&
          rxactive == 1'b0)
        begin
        if (packetid == PID_SOF)
          begin
          frmnr <= {frmnr10_7, tfnaddr_s};
          end
        end
      end
    end




  assign tfnaddr = tfnaddr_s;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TENDPADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      t_endp <= 4'h0;
      end
    else
      begin
      if (upstren == 1'b0)
        begin
        if (txfsm_st == TIDLE &&
            sendtok == 1'b1)
          begin
          t_endp <= hcepnr;
          end
        end
      else
        begin
        if (pid_err == 1'b0 &&
            rxhold == 1'b0)
          begin
          if ((packetid == PID_OUT   ||
               packetid == PID_IN    ||
               packetid == PID_PING  ||
               packetid == PID_EXT   ||
               packetid == PID_SETUP) && rxfsm_st == RDDAT && rxactive == 1'b1)
            begin
            t_endp <= {dataout[2:0], databuf8[7]};
            end
          end
        end
      end
    end




  assign tfrmnr = frmnr;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TFRMNRM_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      tfrmnrm <= 3'b111;
      end
    else
      begin
      if (sofirq == 1'b1)
        begin
        if (clrmfrmnrack == 1'b1 || hsmode == 1'b0)
          begin
          tfrmnrm <= 3'b000;
          end








        else
          begin
          tfrmnrm <= tfrmnrm + 1'b1;
          end
        end
      end
    end




  assign tendp = t_endp;




  assign tendpnxt = {dataout[2:0], databuf8[7]};




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : CLRMFRMNR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      clrmfrmnr <= 1'b0;
      end
    else
      begin

      if (hsmode == 1'b0)
        begin
        clrmfrmnr <= 1'b0;
        end
      else
        begin
        if (rxfsm_st == RDDAT && rxhold == 1'b0 &&
                                 pid_err == 1'b0 && rxactive == 1'b1)
          begin
          if (packetid == PID_SOF)
            begin
            if (frmnr[7:0]  != databuf8[7:0] ||
                frmnr[10:8] != dataout[2:0])
              begin
              clrmfrmnr <= 1'b1;
              end
            else
              begin
              clrmfrmnr <= 1'b0;
              end
            end
          end
        end
      end
    end








  assign hctoken_s = (txfsm_st == TPTOK) ? hctoken[7:0] :
                                           {5'b00000, hctoken[10:8]};




  always @(fifodatai or
           t_endp or
           txfsm_nxt or txfsm_st or upstren or hctoken_s or
           testmode_r or testmodesel or testpack or hsmode)
    begin : TXDATAI_COMB_PROC



    if (testmode_r == 1'b1 &&
        testmodesel == 2'b11 &&
        hsmode == 1'b1)
      begin
      txdatai = testpack;
      end
    else if (t_endp == 4'h0 && upstren == 1'b1)
      begin
      txdatai = fifodatai;
      end
    else if (txfsm_nxt == TPTOK ||
             txfsm_st == TPTOK ||
             txfsm_st == TTOK)
      begin
      txdatai = hctoken_s;
      end
    else
      begin
      txdatai = fifodatai;
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TXVALID_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      txvalid <= 1'b0;
      end
    else
      begin
      case (txfsm_nxt)
          TPTOK,
          TTOK,
          TTOKCRC,
          THSHK,
          TDDAT,
          TCCRC,
          TCRC :
              begin
              txvalid <= 1'b1;
              end
          default :
              begin

              if (utmitxready == 1'b1 || txvalid == 1'b0)
                begin
                txvalid <= (drivechirpk | drivechirpj) & resumereq;
                end
              end
      endcase
      end
    end




  assign utmitxvalid  = txvalid;





  assign utmitxvalidl = txvalid;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : UTMIDATAIN_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      utmidatain <= {8{1'b0}};
      end
    else
      begin
      case (txfsm_nxt)
          THSHK :
              begin
              if (txfsm_st == TIDLE)
                begin
                if (testmode_r == 1'b1 &&
                    testmodesel == 2'b10 &&
                    hsmode == 1'b1)
                  begin

                  utmidatain <= {(~PID_NAK[3:0]), PID_NAK[3:0]};
                  end
                else
                  begin
                  utmidatain <= {(~sendpid), sendpid};
                  end
                end
              end
          TDDAT :
              begin
              if (testmode_r == 1'b1 &&
                  hsmode == 1'b1)
                begin
                if (testmodesel == 2'b11)
                  begin
                  if (txfsm_st == TIDLE ||
                      utmitxready == 1'b1)
                    begin
                    utmidatain <= txdatai;
                    end
                  end
                else if (testmodesel == 2'b01)
                  begin

                  utmidatain <= {8{1'b0}};
                  end
                else
                  begin
                  utmidatain <= {8{1'b1}};
                  end
                end
              else if (txfsm_st == TIDLE)
                begin
                utmidatain <= {(~sendpid), sendpid};
                end
              else if (utmitxready == 1'b1)
                begin
                utmidatain <= txdatai;
                end
              end
          TCCRC :
              begin
              utmidatain[7] <= ~crcreg[8];
              utmidatain[6] <= ~crcreg[9];
              utmidatain[5] <= ~crcreg[10];
              utmidatain[4] <= ~crcreg[11];
              utmidatain[3] <= ~crcreg[12];
              utmidatain[2] <= ~crcreg[13];
              utmidatain[1] <= ~crcreg[14];
              utmidatain[0] <= ~crcreg[15];
              end
          TCRC :
              begin
              utmidatain[7] <= ~crcreg[0];
              utmidatain[6] <= ~crcreg[1];
              utmidatain[5] <= ~crcreg[2];
              utmidatain[4] <= ~crcreg[3];
              utmidatain[3] <= ~crcreg[4];
              utmidatain[2] <= ~crcreg[5];
              utmidatain[1] <= ~crcreg[6];
              utmidatain[0] <= ~crcreg[7];
              end
          TPTOK :
              begin
              utmidatain <= {(~sendpid), sendpid};
              end
          TTOK :
              begin
              if (utmitxready == 1'b1)
                begin
                utmidatain <= txdatai;
                end
              end
          TTOKCRC :
              begin
              if (utmitxready == 1'b1)
                begin
                utmidatain[7] <= ~crcreg_nxt[0];
                utmidatain[6] <= ~crcreg_nxt[1];
                utmidatain[5] <= ~crcreg_nxt[2];
                utmidatain[4] <= ~crcreg_nxt[3];
                utmidatain[3] <= ~crcreg_nxt[4];
                utmidatain[2] <= txdatai[2];
                utmidatain[1] <= txdatai[1];
                utmidatain[0] <= txdatai[0];
                end
              end
          default :
              begin

              if (resumereq == 1'b1)
                begin
                if (drivechirpk == 1'b1)
                  begin

                  utmidatain <= {8{1'b0}};
                  end
                else
                  begin

                  utmidatain <= {8{1'b1}};
                  end
                end
              end
      endcase
      end
    end





  always @(rxfsm_st or rxerror)
    begin : RXFSM_COMB_PROC





    case (rxfsm_st)
        RIDLE :
            begin



              if (rxerror == 1'b1)
                begin
                rxfsm_nxt = RERR;
                end
              else
                begin
                rxfsm_nxt = RPDAT;
                end





            end
        RPDAT :
            begin

            if (rxerror == 1'b1)
              begin
              rxfsm_nxt = RERR;
              end
            else
              begin
              rxfsm_nxt = RDDAT;
              end
            end
        RDDAT :
            begin

            if (rxerror == 1'b1)
              begin
              rxfsm_nxt = RERR;
              end




            else
              begin
              rxfsm_nxt = RDDAT;
              end
            end

        default :
            begin
            rxfsm_nxt = RERR;








            end
    endcase
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : RXFSM_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      rxfsm_st <= RIDLE;
      end
    else
      begin
      if (rxactive == 1'b0)
        begin
        rxfsm_st <= RIDLE;
        end
      else if (rxhold == 1'b0 || rxerror == 1'b1)
        begin
        rxfsm_st <= rxfsm_nxt;
        end
      end
    end




  assign rxtxidle = (rxfsm_st == RIDLE &&
                     txfsm_st == TIDLE) ? 1'b1 :
                                          1'b0;




  always @(txfsm_st or sendhshk or sendpckt or utmitxready or
           tx_fall or dvi_r or
           testmode_r or testmodesel or tpcounter or
           rxactive_ff or rxactive or
           pid_err or usb_err or packetid or
           sendpid or sendtok or lsmode or
           hsmode or testpack or sendzeroiso)
    begin : TXFSM_COMB_PROC





    case (txfsm_st)
        TIDLE :
            begin







            if ((sendhshk == 1'b1 && tx_fall == 1'b0) ||
                (sendtok  == 1'b1 && tx_fall == 1'b0 && lsmode == 1'b1 &&
                                                        sendpid == PID_SOF[3:0]))
              begin
              txfsm_nxt = THSHK;
              end
            else if (testmode_r == 1'b1 &&
                     testmodesel == 2'b10 &&
                     hsmode == 1'b1 &&
                     rxactive_ff == 1'b1 &&
                     rxactive == 1'b0 &&
                     pid_err == 1'b0 &&
                     usb_err == 1'b0 && packetid == PID_IN)
              begin
              txfsm_nxt = THSHK;
              end
            else if (sendtok == 1'b1 && tx_fall == 1'b0)
              begin
              txfsm_nxt = TPTOK;
              end
            else if ((sendpckt == 1'b1 && tx_fall == 1'b0) ||
                     (sendzeroiso == 1'b1 && tx_fall == 1'b0) ||
                     (testmode_r == 1'b1 && hsmode == 1'b1 &&
                     (testmodesel == 2'b01 ||
                      testmodesel == 2'b00)))
              begin



              txfsm_nxt = TDDAT;
              end
            else if (testmode_r == 1'b1 &&
                     testmodesel == 2'b11 &&
                     hsmode == 1'b1)
              begin


              if (tpcounter == 7'b000_0000 &&
                  testpack[7:0] == 8'hC3)
                begin
                txfsm_nxt = TDDAT;
                end
              else
                begin
                txfsm_nxt = TIDLE;
                end
              end
            else
              begin
              txfsm_nxt = TIDLE;
              end
            end



        THSHK :
            begin

            if (utmitxready == 1'b1)
              begin
              txfsm_nxt = TIDLE;
              end
            else
              begin
              txfsm_nxt = THSHK;
              end
            end
        TDDAT :
            begin
            if (utmitxready == 1'b1)
              begin
              if (testmode_r == 1'b1 && hsmode == 1'b1)
                begin

                if (tpcounter == 7'b0110110)
                  begin
                  txfsm_nxt = TCCRC;
                  end
                else
                  begin
                  txfsm_nxt = TDDAT;
                  end
                end
              else
                begin
                if (sendzeroiso == 1'b1)
                  begin
                  txfsm_nxt = TCCRC;
                  end
                else if (dvi_r == 1'b1)
                  begin
                  txfsm_nxt = TDDAT;
                  end
                else
                  begin
                  txfsm_nxt = TCCRC;
                  end
                end
              end
            else
              begin
              txfsm_nxt = TDDAT;
              end
            end
        TCCRC :
            begin

            if (utmitxready == 1'b1)
              begin
              txfsm_nxt = TCRC;
              end
            else
              begin
              txfsm_nxt = TCCRC;
              end
            end
        TPTOK :
            begin
            if (utmitxready == 1'b1)
              begin
              txfsm_nxt = TTOK;
              end
            else
              begin
              txfsm_nxt = TPTOK;
              end
            end
        TTOK :
            begin
            if (utmitxready == 1'b1)
              begin
              txfsm_nxt = TTOKCRC;
              end
            else
              begin
              txfsm_nxt = TTOK;
              end
            end
        TTOKCRC :
            begin
            if (utmitxready == 1'b1)
              begin
              txfsm_nxt = TIDLE;
              end
            else
              begin
              txfsm_nxt = TTOKCRC;
              end
            end
        default :
            begin

            if (utmitxready == 1'b1)
              begin
              txfsm_nxt = TIDLE;
              end
            else
              begin
              txfsm_nxt = TCRC;
              end
            end
    endcase
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TXFSM_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      txfsm_st <= TIDLE;
      end
    else
      begin
      txfsm_st <= txfsm_nxt;
      end
    end




  assign din_s1 = (txfsm_st == TTOK) ? hctoken :
                                       {3'b000, txdatai};




  always @(txfsm_st)
    begin : CRCSEL_S_COMB_PROC





    if (txfsm_st == TTOK)
      begin

      crcsel_s1 = 1'b1;
      end
    else
      begin
      crcsel_s1 = 1'b0;
      end
    end




  always @(crcreg or din_s1 or crcsel_s1)
    begin : CRCREG_NXT_PROC





    case (crcsel_s1)
        1'b0 :
            begin

            crcreg_nxt[0]  = crcreg[8]  ^ crcreg[9]  ^ crcreg[10] ^
                             crcreg[11] ^ crcreg[12] ^ crcreg[13] ^
                             crcreg[14] ^ crcreg[15] ^
                             din_s1[1]  ^ din_s1[2]  ^ din_s1[3] ^
                             din_s1[4]  ^ din_s1[5]  ^ din_s1[6] ^
                             din_s1[7]  ^ din_s1[0];
            crcreg_nxt[1]  = crcreg[9]  ^ crcreg[10] ^ crcreg[11] ^
                             crcreg[12] ^ crcreg[13] ^ crcreg[14] ^
                             crcreg[15] ^
                             din_s1[1]  ^ din_s1[2]  ^ din_s1[3] ^
                             din_s1[4]  ^ din_s1[5]  ^ din_s1[6] ^
                             din_s1[0];
            crcreg_nxt[2]  = crcreg[8]  ^ crcreg[9]  ^
                             din_s1[6]  ^ din_s1[7];
            crcreg_nxt[3]  = crcreg[9]  ^ crcreg[10] ^
                             din_s1[5]  ^ din_s1[6];
            crcreg_nxt[4]  = crcreg[10] ^ crcreg[11] ^
                             din_s1[4]  ^ din_s1[5];
            crcreg_nxt[5]  = crcreg[11] ^ crcreg[12] ^
                             din_s1[3]  ^ din_s1[4];
            crcreg_nxt[6]  = crcreg[12] ^ crcreg[13] ^
                             din_s1[2]  ^ din_s1[3];
            crcreg_nxt[7]  = crcreg[13] ^ crcreg[14] ^
                             din_s1[1]  ^ din_s1[2];
            crcreg_nxt[8]  = crcreg[14] ^ crcreg[15] ^ crcreg[0] ^
                             din_s1[1]  ^ din_s1[0];
            crcreg_nxt[9]  = crcreg[1]  ^ crcreg[15] ^
                             din_s1[0];
            crcreg_nxt[10] = crcreg[2];
            crcreg_nxt[11] = crcreg[3];
            crcreg_nxt[12] = crcreg[4];
            crcreg_nxt[13] = crcreg[5];
            crcreg_nxt[14] = crcreg[6];
            crcreg_nxt[15] = crcreg[7]  ^ crcreg[8]  ^ crcreg[9]  ^
                             crcreg[10] ^ crcreg[11] ^ crcreg[12] ^
                             crcreg[13] ^ crcreg[14] ^ crcreg[15] ^
                             din_s1[1]  ^ din_s1[2]  ^ din_s1[3]  ^
                             din_s1[4]  ^ din_s1[5]  ^ din_s1[6]  ^
                             din_s1[7]  ^ din_s1[0];
            end
        default :
            begin

            crcreg_nxt[0]  = 1'b1 ^
                             din_s1[1] ^ din_s1[4] ^ din_s1[5] ^
                             din_s1[7] ^ din_s1[0] ^ din_s1[10];
            crcreg_nxt[1]  = 1'b1 ^
                             din_s1[3] ^ din_s1[4] ^ din_s1[6] ^
                             din_s1[0] ^ din_s1[9];
            crcreg_nxt[2]  = 1'b1 ^
                             din_s1[1] ^ din_s1[4] ^ din_s1[2] ^
                             din_s1[7] ^ din_s1[0] ^ din_s1[3] ^
                             din_s1[8] ^ din_s1[10];
            crcreg_nxt[3]  = din_s1[3] ^ din_s1[1] ^ din_s1[6] ^
                             din_s1[0] ^ din_s1[2] ^ din_s1[7] ^
                             din_s1[9];
            crcreg_nxt[4]  = 1'b1 ^
                             din_s1[1] ^ din_s1[2] ^ din_s1[6] ^
                             din_s1[0] ^ din_s1[5] ^ din_s1[8];
            crcreg_nxt[15:5] = crcreg[15:5];
            end
    endcase
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : CRCREG_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      crcreg <= {16{1'b1}};
      end
    else
      begin
      if (rxactive == 1'b0 && txfsm_nxt == TIDLE)
        begin
        crcreg <= {16{1'b1}};
        end
      else if (((rxfsm_st == RPDAT || rxfsm_st == RDDAT) && rxhold == 1'b0) ||
               (txfsm_nxt == TDDAT && utmitxready == 1'b1))
        begin



        crcreg <= crcreg_nxt;
        end
      end
    end




  assign packetid_s = (rxfsm_st == RIDLE) ? {packetid_fix, dataout[3:0]} :
                                             packetid[4:0];




  assign din_s2 = dataout;




  always @(packetid_s)
    begin : CRCSEL_S2_COMB_PROC




    case (packetid_s)
        PID_MDATA,
        PID_DATA0,
        PID_DATA1,
        PID_DATA2 :
            begin

            crcsel_s2 = 1'b1;
            end







        default :
            begin

            crcsel_s2 = 1'b0;
            end
    endcase
    end




  always @(crcregrcv or crcsel_s2 or din_s2)
    begin : CRCREGRCV_NXT_PROC





    if (crcsel_s2 == 1'b0)
      begin

      crcregrcv_nxt[0]  = crcregrcv[2] ^ crcregrcv[3] ^
                          crcregrcv[0] ^
                          din_s2[1]    ^ din_s2[2]    ^
                          din_s2[4]    ^ din_s2[7];
      crcregrcv_nxt[1]  = crcregrcv[1] ^ crcregrcv[3] ^
                          crcregrcv[4] ^
                          din_s2[1]    ^ din_s2[3]    ^
                          din_s2[6]    ^ din_s2[0];
      crcregrcv_nxt[2]  = crcregrcv[3] ^ crcregrcv[4] ^
                          crcregrcv[0] ^
                          din_s2[1]    ^ din_s2[4]    ^
                          din_s2[5]    ^ din_s2[7]    ^
                          din_s2[0];
      crcregrcv_nxt[3]  = crcregrcv[1] ^ crcregrcv[4] ^
                          crcregrcv[0] ^
                          din_s2[3]    ^ din_s2[4]    ^
                          din_s2[6]    ^ din_s2[0];
      crcregrcv_nxt[4]  = crcregrcv[1] ^ crcregrcv[2] ^
                          din_s2[2]    ^ din_s2[3]    ^
                          din_s2[5];
      crcregrcv_nxt[15:5] = crcregrcv[15:5];
      end
    else
      begin

      crcregrcv_nxt[0]  = crcregrcv[8]  ^ crcregrcv[9]  ^
                          crcregrcv[10] ^ crcregrcv[11] ^
                          crcregrcv[12] ^ crcregrcv[13] ^
                          crcregrcv[14] ^ crcregrcv[15] ^
                          din_s2[1]     ^ din_s2[2]     ^
                          din_s2[3]     ^ din_s2[4]     ^
                          din_s2[5]     ^ din_s2[6]     ^
                          din_s2[7]     ^ din_s2[0];
      crcregrcv_nxt[1]  = crcregrcv[9]  ^ crcregrcv[10] ^
                          crcregrcv[11] ^ crcregrcv[12] ^
                          crcregrcv[13] ^ crcregrcv[14] ^
                          crcregrcv[15] ^
                          din_s2[1]     ^ din_s2[2]     ^
                          din_s2[3]     ^ din_s2[4]     ^
                          din_s2[5]     ^ din_s2[6]     ^
                          din_s2[0];
      crcregrcv_nxt[2]  = crcregrcv[8]  ^ crcregrcv[9]  ^
                          din_s2[6]     ^ din_s2[7];
      crcregrcv_nxt[3]  = crcregrcv[9]  ^ crcregrcv[10] ^
                          din_s2[5]     ^ din_s2[6];
      crcregrcv_nxt[4]  = crcregrcv[10] ^ crcregrcv[11] ^
                          din_s2[4]     ^ din_s2[5];
      crcregrcv_nxt[5]  = crcregrcv[11] ^ crcregrcv[12] ^
                          din_s2[3]     ^ din_s2[4];
      crcregrcv_nxt[6]  = crcregrcv[12] ^ crcregrcv[13] ^
                          din_s2[2]     ^ din_s2[3];
      crcregrcv_nxt[7]  = crcregrcv[13] ^ crcregrcv[14] ^
                          din_s2[1]     ^ din_s2[2];
      crcregrcv_nxt[8]  = crcregrcv[14] ^ crcregrcv[15] ^
                          crcregrcv[0]  ^
                          din_s2[1]     ^ din_s2[0];
      crcregrcv_nxt[9]  = crcregrcv[1]  ^ crcregrcv[15] ^
                          din_s2[0];
      crcregrcv_nxt[10] = crcregrcv[2];
      crcregrcv_nxt[11] = crcregrcv[3];
      crcregrcv_nxt[12] = crcregrcv[4];
      crcregrcv_nxt[13] = crcregrcv[5];
      crcregrcv_nxt[14] = crcregrcv[6];
      crcregrcv_nxt[15] = crcregrcv[7]  ^ crcregrcv[8]  ^
                          crcregrcv[9]  ^ crcregrcv[10] ^
                          crcregrcv[11] ^ crcregrcv[12] ^
                          crcregrcv[13] ^ crcregrcv[14] ^
                          crcregrcv[15] ^
                          din_s2[1]     ^ din_s2[2]     ^
                          din_s2[3]     ^ din_s2[4]     ^
                          din_s2[5]     ^ din_s2[6]     ^
                          din_s2[7]     ^ din_s2[0];
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : CRCREGRCV_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      crcregrcv <= 16'hFFFF;
      end
    else
      begin
      if (rxactive == 1'b0)
        begin
        crcregrcv <= 16'hFFFF;
        end
      else if ((rxfsm_st == RPDAT ||
                rxfsm_st == RDDAT) && rxhold == 1'b0)
        begin

        crcregrcv <= crcregrcv_nxt;
        end
      end
    end







  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TPCOUNTER_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      tpcounter <= {7{1'b0}};
      end
    else
      begin
      if (testmode_r == 1'b1 &&
          testmodesel == 2'b11 &&
          hsmode == 1'b1)
        begin


        if ((txfsm_st == TIDLE && txfsm_nxt == TDDAT) ||
             utmitxready == 1'b1 ||
            (txfsm_st == TIDLE && tpcounter != 7'b0000000))
          begin



          if (tpcounter == 7'b1111111)
            begin
            tpcounter <= {7{1'b0}};
            end
          else
            begin
            tpcounter <= tpcounter + 1'b1;
            end
          end
        end
      else
        begin
        tpcounter <= {7{1'b0}};
        end
      end
    end




  always @(tpcounter)
    begin : TESTPACK8_S_COMB_PROC



    case (tpcounter)
        7'b000_1001,
        7'b000_1010,
        7'b000_1011,
        7'b000_1100,
        7'b000_1101,
        7'b000_1110,
        7'b000_1111,
        7'b001_0000 :
            begin
            testpack8_s = 8'hAA;
            end
        7'b001_0001,
        7'b001_0010,
        7'b001_0011,
        7'b001_0100,
        7'b001_0101,
        7'b001_0110,
        7'b001_0111,
        7'b001_1000 :
            begin
            testpack8_s = 8'hEE;
            end
        7'b001_1001 :
            begin
            testpack8_s = 8'hFE;
            end
        7'b001_1010,
        7'b001_1011,
        7'b001_1100,
        7'b001_1101,
        7'b001_1110,
        7'b001_1111,
        7'b010_0000,
        7'b010_0001,
        7'b010_0010,
        7'b010_0011,
        7'b010_0100 :
            begin
            testpack8_s = 8'hFF;
            end
        7'b010_0101 :
            begin
            testpack8_s = 8'h7F;
            end
        7'b010_0110 :
            begin
            testpack8_s = 8'hBF;
            end
        7'b010_0111 :
            begin
            testpack8_s = 8'hDF;
            end
        7'b010_1000 :
            begin
            testpack8_s = 8'hEF;
            end
        7'b010_1001 :
            begin
            testpack8_s = 8'hF7;
            end
        7'b010_1010 :
            begin
            testpack8_s = 8'hFB;
            end
        7'b010_1011 :
            begin
            testpack8_s = 8'hFD;
            end
        7'b010_1100 :
            begin
            testpack8_s = 8'hFC;
            end
        7'b010_1101 :
            begin
            testpack8_s = 8'h7E;
            end
        7'b010_1110 :
            begin
            testpack8_s = 8'hBF;
            end
        7'b010_1111 :
            begin
            testpack8_s = 8'hDF;
            end
        7'b011_0000 :
            begin
            testpack8_s = 8'hEF;
            end
        7'b011_0001 :
            begin
            testpack8_s = 8'hF7;
            end
        7'b011_0010 :
            begin
            testpack8_s = 8'hFB;
            end
        7'b011_0011 :
            begin
            testpack8_s = 8'hFD;
            end
        7'b011_0100 :
            begin
            testpack8_s = 8'h7E;
            end









        default :
            begin
            testpack8_s = 8'h00;
            end
    endcase
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TESTPACK_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      testpack <= {8{1'b0}};
      end
    else
      begin
      if (txfsm_st  == TIDLE &&
          txfsm_nxt == TIDLE)
        begin
        testpack <= 8'hC3;
        end
      else if (txfsm_st  == TIDLE &&
               txfsm_nxt == TDDAT)
        begin

        testpack <= 8'h00;
        end
      else if (utmitxready == 1'b1)
        begin

        testpack <= testpack8_s;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : UTMITXVALID_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      utmitxvalid_r <= 1'b0;
      end
    else
      begin
      utmitxvalid_r <= utmitxvalid;
      end
    end




  assign rcvfall_active = rxactive_ff & ~rxactive;




  assign utmitxvalid_fall = (utmitxvalid == 1'b0 &&
                             utmitxvalid_r == 1'b1) ? 1'b1 :
                                                      1'b0 ;
  assign utmitxvalid_rise = (utmitxvalid == 1'b1 &&
                             utmitxvalid_r == 1'b0) ? 1'b1 :
                                                      1'b0 ;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DEBUG_TX_COUNTER_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      debug_tx_bytes   <= {11{1'b0}};
      debug_tx         <= {15{1'b0}};
      debug_tx_sendpid <= 4'h0;
      debug_tx_req     <= 1'b0;
      end
    else
      begin

      if (opmode != 2'b00)
        begin
        debug_tx_bytes   <= {11{1'b0}};
        debug_tx         <= {15{1'b0}};
        debug_tx_sendpid <= 4'h0;
        end
      else
        begin
        debug_tx_req <= utmitxvalid_fall;

        if (utmitxvalid_rise == 1'b1)
          begin
          debug_tx_sendpid <= sendpid;
          end

        if (utmitxvalid_fall == 1'b1)
          begin
          debug_tx_bytes <= {11{1'b0}};

          debug_tx       <= {debug_tx_sendpid, debug_tx_bytes};
          end
        else if (utmitxready == 1'b1)
          begin
          if (utmitxvalid == 1'b1)
            begin
            debug_tx_bytes <= debug_tx_bytes + 1'b1;
            end
          end
        end
      end
    end



  assign debug_rx_error = {~rcvfall, usb_err, pid_err, debug_rx_rxerr} ;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DEBUG_RX_COUNTER_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      debug_rx_bytes <= {11{1'b0}};
      debug_rx_rxerr <= 1'b0;

      debug_rx       <= {18{1'b0}};
      debug_rx_req   <= 1'b0;
      end
    else
      begin

      if (opmode != 2'b00)
        begin
        debug_rx_bytes <= {11{1'b0}};
        debug_rx_rxerr <= 1'b0;

        debug_rx       <= {18{1'b0}};
        end
      else
        begin
        debug_rx_req <= rcvfall_active;

        if (rcvfall_active == 1'b1)
          begin
          debug_rx_bytes <= {11{1'b0}};
          debug_rx_rxerr <= 1'b0;

          debug_rx <= {debug_rx_error, packetid[3:0], debug_rx_bytes};
          end
        else if (utmirxactive == 1'b1)
          begin
          if (utmirxerror == 1'b1)
            begin
            debug_rx_rxerr <= 1'b1;
            end
          if (utmirxvalid == 1'b1)
            begin
            debug_rx_bytes <= debug_rx_bytes + 1'b1;
            end
          end
        end
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : REGISTERS_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      linestate_r1  <= 2'b00;
      linestate_r2  <= 2'b00;
      opmode_r1     <= 2'b01;
      opmode_r2     <= 2'b01;

      usbreset_r    <= 1'b0;
      usbreset_r2   <= 1'b0;
      usbreset_r3   <= 1'b0;
      usbreset_r4   <= 1'b0;
      end
    else
      begin
      linestate_r1  <= linestate;
      linestate_r2  <= linestate_r1;
      opmode_r1     <= opmode;
      opmode_r2     <= opmode_r1;

      usbreset_r    <= usbreset;
      usbreset_r2   <= usbreset_r;
      usbreset_r3   <= usbreset_r2;
      usbreset_r4   <= usbreset_r3;
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HS_RX_START_COUNTER_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hs_rx_start <= 1'b0;
      end
    else
      begin
      if (workaround_a_enable == 1'b0 || usbreset == 1'b1 || xcvrselect != 2'b00 || hs_tx == 1'b1)
        begin
        hs_rx_start <= 1'b0;
        end


      else if (utmirxactive == 1'b1 || hs_rx_tmout == 1'b1 || linestate == 2'b00)
        begin
        hs_rx_start <= 1'b0;
        end


      else if (linestate_r2 == 2'b00 &&
               linestate_r1 == 2'b01)
        begin
        hs_rx_start <= 1'b1;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HS_RX_COUNTER_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hs_rx_counter <= 4'hE;
      end
    else
      begin
      if (hs_rx_start == 1'b1)
        begin
        hs_rx_counter <= hs_rx_counter - 1'b1;
        end
      else
        begin
        hs_rx_counter <= workaround_a_value;
        end
      end
    end



  assign hs_rx_tmout = (hs_rx_counter == 4'b0000);



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HS_RX_TMOUT_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hs_rx_tmout_r <= 1'b0;
      end
    else
      begin
      hs_rx_tmout_r <= hs_rx_tmout & hs_rx_start;
      end
    end



  assign workaround_a     = (hs_rx_tmout_r == 1'b1);
  assign workaround_a_req = (workaround_a_enable & workaround_a);



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HS_TX_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hs_tx <= 1'b0;
      end
    else
      begin

      if ((workaround_a_enable == 1'b0 && workaround_b_enable == 1'b0) || xcvrselect != 2'b00 || usbreset == 1'b1)
        begin
        hs_tx <= 1'b0;
        end



      else if (linestate_r1 == 2'b01 && linestate == 2'b00 &&
               utmitxvalid == 1'b0)
        begin
        hs_tx <= 1'b0;
        end
      else if (utmitxvalid_rise == 1'b1)
        begin
        hs_tx <= 1'b1;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HS_TX_REG_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hs_tx_r <= 1'b0;
      end
    else
      begin
      hs_tx_r <= hs_tx;
      end
    end



  assign workaround_b     = (hs_tx == 1'b0 && hs_tx_r == 1'b1);
  assign workaround_b_req = (workaround_b_enable & workaround_b);



  assign workaround_c     = (opmode_r1 != opmode_r2 && opmode_r2 == 2'b01);
  assign workaround_c_req = (workaround_c_enable & workaround_c);



  assign workaround_d     = (usbreset_r3 == 1'b0 && usbreset_r4 == 1'b1 && xcvrselect == 2'b00);
  assign workaround_d_req = (workaround_d_enable & workaround_d);



  assign workaround_reset = workaround_a_req |
                            workaround_b_req |
                            workaround_c_req |
                            workaround_d_req |
                            workaround_sfr_rst ;



  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : WORKAROUND_RESET_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      workaround_reset_r <= 1'b0;
      end
    else
      begin
      workaround_reset_r <= workaround_reset;
      end
    end



  assign workaround_rst = workaround_reset_r;

endmodule

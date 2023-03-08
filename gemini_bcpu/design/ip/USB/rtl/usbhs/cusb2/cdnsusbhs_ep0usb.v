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
//   Filename:           cdnsusbhs_ep0usb.v
//   Module Name:        cdnsusbhs_ep0usb
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
//   Endpoint 0 - USB clock domain
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_ep0usb
  (
  usbclk,
  usbrst,
  setoutbsyreq,
  setinbsyreq,
  upin0bc,
  hsnak,
  stall,
  dstall,

  out0maxpck,

  usbreset,
  hsmode,
  endp,
  clroutbsy,
  clrinbsy,
  pid,
  tokrcvfall,
  settoken,
  discon,
  wr,
  overflowwr,
  rd,
  outdatawr,
  txfall,
  sendstall,
  sendpckt,
  usboutbsyclr,
  usbinbsyclr,
  setupack,
  setaddr,
  usbout0bc,
  fnaddrusb,
  testmodereq,
  testmodeerr,
  testmodenak,
  ep0bufffull,
  ep0busyin,
  ep0busyout,
  ep0nxtbusyout,
  ep0stall,
  ep0togglein,
  ep0toggleout,
  ep0datastage,
  setupbuff,
  dvi,
  testmode,
  testmodesel,

  tmodecustom,
  tmodeselcustom,
  clroutbsy_setup,

  fnaddrup,
  hcoutresend,
  hcinresend,
  hcdopingset,
  hcsettoggle,
  hcclrtoggle,
  hcsetlpm,
  hcset,
  hcerrtype,
  hcepnr,
  hcepdir,
  hcerrinc,
  hcerrclr,
  hcerrset,
  hcsendsof,
  hcepwaitclr,
  hcepwaitset,
  sendtok,
  hcdevdopingset,
  hcdevdopingclr,
  upstren,
  enterhm,
  portctrltm,
  hcouterrtypeusb,
  hcinerrtypeusb,
  hcouterrcountusb,
  hcinerrcountusb,
  chgsetup,
  hcout0maxpckusb,
  hcin0maxpckusb,
  hcoutepsuspend,
  hcinepsuspend,
  hcoutepwait,
  hcinepwait,
  hcdoping,
  hcdosetup,
  hcdolpm,

  fiforstin,
  fiforstout,

  usbfifoptrwr,
  usbfifoptrrd
  );

  `include "cdnsusbhs_cusb2_params.v"

  input                            usbclk;
  input                            usbrst;
  input                            setoutbsyreq;
  input                            setinbsyreq;
  input  [6:0]                     upin0bc;
  input                            hsnak;
  input                            stall;
  input                            dstall;

  input  [6:0]                     out0maxpck;

  input                            usbreset;
  input                            hsmode;
  input  [3:0]                     endp;
  input                            clroutbsy;
  input                            clrinbsy;
  input  [4:0]                     pid;
  input                            tokrcvfall;
  input                            settoken;
  input                            discon;
  input                            wr;
  input                            overflowwr;
  input                            rd;
  input  [7:0]                     outdatawr;
  input                            txfall;
  input                            sendstall;
  input                            sendpckt;
  output                           usboutbsyclr;
  wire                             usboutbsyclr;
  output                           usbinbsyclr;
  reg                              usbinbsyclr;
  output                           setupack;
  wire                             setupack;
  output                           setaddr;
  wire                             setaddr;
  output [6:0]                     usbout0bc;
  wire   [6:0]                     usbout0bc;
  output [6:0]                     fnaddrusb;
  reg    [6:0]                     fnaddrusb;
  output                           testmodereq;
  wire                             testmodereq;
  output                           testmodeerr;
  wire                             testmodeerr;
  output                           testmodenak;
  wire                             testmodenak;
  output                           ep0bufffull;
  wire                             ep0bufffull;
  output                           ep0busyin;
  wire                             ep0busyin;
  output                           ep0busyout;
  wire                             ep0busyout;
  output                           ep0nxtbusyout;
  wire                             ep0nxtbusyout;
  output                           ep0stall;
  wire                             ep0stall;
  output                           ep0togglein;
  wire                             ep0togglein;
  output                           ep0toggleout;
  wire                             ep0toggleout;
  output                           ep0datastage;
  wire                             ep0datastage;
  output [63:0]                    setupbuff;
  wire   [63:0]                    setupbuff;
  output                           dvi;
  reg                              dvi;
  output                           testmode;
  wire                             testmode;
  output [1:0]                     testmodesel;
  wire   [1:0]                     testmodesel;

  output                           tmodecustom;
  reg                              tmodecustom;
  output [7:0]                     tmodeselcustom;
  reg    [7:0]                     tmodeselcustom;

  output                           clroutbsy_setup;
  wire                             clroutbsy_setup;

  output [11:0]                    usbfifoptrwr;
  wire   [11:0]                    usbfifoptrwr;
  output [11:0]                    usbfifoptrrd;
  wire   [11:0]                    usbfifoptrrd;

  input  [6:0]                     fnaddrup;
  input                            hcoutresend;
  input                            hcinresend;
  input                            hcdopingset;
  input                            hcsettoggle;
  input                            hcclrtoggle;
  input                            hcsetlpm;
  input                            hcset;
  input  [2:0]                     hcerrtype;
  input  [3:0]                     hcepnr;
  input                            hcepdir;
  input                            hcerrinc;
  input                            hcerrclr;
  input                            hcerrset;
  input                            hcsendsof;
  input                            hcepwaitclr;
  input                            hcepwaitset;
  input                            sendtok;
  input                            hcdevdopingset;
  input                            hcdevdopingclr;
  input                            upstren;
  input                            enterhm;
  input  [3:0]                     portctrltm;
  output [2:0]                     hcouterrtypeusb;
  reg    [2:0]                     hcouterrtypeusb;
  output [2:0]                     hcinerrtypeusb;
  reg    [2:0]                     hcinerrtypeusb;
  output [1:0]                     hcouterrcountusb;
  reg    [1:0]                     hcouterrcountusb;
  output [1:0]                     hcinerrcountusb;
  reg    [1:0]                     hcinerrcountusb;
  output                           chgsetup;
  reg                              chgsetup;
  output [10:0]                    hcout0maxpckusb;
  wire   [10:0]                    hcout0maxpckusb;
  output [10:0]                    hcin0maxpckusb;
  wire   [10:0]                    hcin0maxpckusb;
  output                           hcoutepsuspend;
  reg                              hcoutepsuspend;
  output                           hcinepsuspend;
  reg                              hcinepsuspend;
  output                           hcoutepwait;
  reg                              hcoutepwait;
  output                           hcinepwait;
  reg                              hcinepwait;
  output                           hcdoping;
  reg                              hcdoping;
  output                           hcdosetup;
  wire                             hcdosetup;
  output                           hcdolpm;
  wire                             hcdolpm;

  input                            fiforstin;
  input                            fiforstout;

  reg    [7:0]                     setup_buff0;
  reg    [7:0]                     setup_buff1;
  reg    [7:0]                     setup_buff2;
  reg    [7:0]                     setup_buff3;
  reg    [7:0]                     setup_buff4;
  reg    [7:0]                     setup_buff5;
  reg    [7:0]                     setup_buff6;
  reg    [7:0]                     setup_buff7;
  reg                              toggleout_bit;
  reg                              togglein_bit;
  reg                              usb_outbsy;
  reg                              hsnak_ff;
  reg                              usb_inbsy;
  reg    [6:0]                     usbin0bc;
  reg    [6:0]                     usbin0bc_nxt;
  reg    [6:0]                     out0bc;
  reg    [6:0]                     out0bc_nxt;
  reg    [6:0]                     out0ovbc;
  reg    [6:0]                     out0ovbc_nxt;
  reg    [6:0]                     upin0bcreg;
  reg                              datastage;
  reg                              statusstage;
  wire                             changeoftrdir;
  reg                              ep0_dir;
  reg                              dvi_nxt;
  reg                              settoken_ff;
  reg                              set_addr;


  reg                              test_mode_req;
  reg                              test_mode_err;
  reg                              test_mode_nak;
  reg                              test_mode;
  reg    [1:0]                     test_mode_sel;

  reg                              hsnak_r;
  reg                              stall_r;
  wire                             ep0cs_upd;
  reg                              ep0stall_ff;



  reg                              hc_dosetup;
  reg                              hc_dolpm;

  wire                             fiforst;
  reg                              hcdopingrst;







  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SETTOKEN_FF_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      settoken_ff <= 1'b0 ;
      end
    else
      begin
      settoken_ff <= settoken ;
      end
    end























  assign usboutbsyclr = (clroutbsy == 1'b1 && endp == 4'h0 && settoken == 1'b0) ? 1'b1 :
                                                                                  1'b0 ;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USB_OUTBSY_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usb_outbsy <= 1'b0 ;
      end
    else
      begin

      if (fiforst == 1'b1 && upstren == 1'b1)
        begin
        usb_outbsy <= 1'b1 ;
        end
      else if ((usb_outbsy == 1'b1 && usboutbsyclr == 1'b1) ||
                clroutbsy_setup == 1'b1 ||
                enterhm == 1'b1 ||
                hcset == 1'b1 ||
                hcsetlpm == 1'b1 ||
                usbreset == 1'b1 ||
                fiforst == 1'b1 ||
               (upstren == 1'b1 && discon == 1'b1))
        begin



        usb_outbsy <= 1'b0 ;
        end
      else if (usb_outbsy == 1'b0 && setoutbsyreq == 1'b1)
        begin
        usb_outbsy <= 1'b1 ;
        end
      else if (settoken    == 1'b1 &&
               settoken_ff == 1'b0)
        begin

        usb_outbsy <= 1'b1 ;
        end
      end
    end




  assign ep0nxtbusyout = (changeoftrdir == 1'b1 ||
                          statusstage   == 1'b1) ? 1'b1 :
                                                   1'b0 ;




  assign usbfifoptrwr = {5'b0_0000, out0bc} ;











  assign ep0bufffull = (out0ovbc >= out0maxpck) ? 1'b1 :
                                                  1'b0 ;




  always @(pid or out0bc or tokrcvfall or endp or
           usb_outbsy or wr or settoken or settoken_ff or sendtok)
    begin : OUT0BC_NXT_COMB_PROC
      reg [6:0] out0bc_v;

    out0bc_v   = out0bc;
    out0bc_nxt = out0bc;


    if ((settoken == 1'b1 && settoken_ff == 1'b0) ||
       ((pid == PID_OUT || pid == PID_SETUP) &&
         tokrcvfall == 1'b1 && endp == 4'h0 && usb_outbsy == 1'b1) ||
        (sendtok == 1'b1 && endp == 4'h0 && usb_outbsy == 1'b1))
      begin


      out0bc_nxt = 7'b000_0000;
      end
    else
      begin

      if (endp == 4'h0 && wr == 1'b1)
        begin

        out0bc_nxt = out0bc_v + 2'b01 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : OUT0BC_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      out0bc <= 7'b000_0000;
      end
    else
      begin
      if (fiforst == 1'b1)
        begin

        out0bc <= 7'b000_0000;
        end
      else
        begin
        out0bc <= out0bc_nxt ;
        end
      end
    end




  assign changeoftrdir = (((pid == PID_OUT ||
                            pid == PID_PING) && ep0_dir == 1'b1) ||
                           (pid == PID_IN    && ep0_dir == 1'b0)) ? 1'b1 :
                                                                    1'b0 ;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HSNAK_R_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hsnak_r <= EP0CS_RV[1];
      end
    else
      begin
      hsnak_r <= hsnak;
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : STALL_R_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      stall_r <= EP0CS_RV[0];
      end
    else
      begin
      stall_r <= stall;
      end
    end






  assign ep0cs_upd = (stall_r == stall &&
                      hsnak_r == hsnak) ? 1'b0 :
                                          1'b1;






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HSNAK_FF_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hsnak_ff    <= EP0CS_RV[1];
      ep0stall_ff <= EP0CS_RV[0];
      end
    else
      begin
      if (ep0cs_upd == 1'b1)
        begin
        hsnak_ff    <= hsnak;
        ep0stall_ff <= stall;
        end
      else
        begin

        if (clroutbsy_setup == 1'b1)
          begin
          if (set_addr == 1'b1)
            begin
            hsnak_ff    <= 1'b0;
            ep0stall_ff <= 1'b0;
            end
          else if (test_mode_req == 1'b1)
            begin
            if (test_mode_err == 1'b1)
              begin
              hsnak_ff    <= 1'b1;
              ep0stall_ff <= 1'b1;
              end
            else if (test_mode_nak == 1'b1)
              begin
              hsnak_ff    <= 1'b1;
              ep0stall_ff <= 1'b0;
              end
            else
              begin
              hsnak_ff    <= 1'b0;
              ep0stall_ff <= 1'b0;
              end
            end
          else
            begin
            hsnak_ff    <= 1'b1;
            ep0stall_ff <= 1'b0;
            end
          end
        else if (datastage == 1'b1 && sendstall == 1'b1)
          begin
          hsnak_ff    <= 1'b1;
          ep0stall_ff <= dstall;
          end
        end
      end
    end




  assign ep0stall = (datastage & ~changeoftrdir) ?
                    (ep0stall_ff | dstall) :
                    (ep0stall_ff) ;




  assign ep0busyout = (changeoftrdir == 1'b0 ||
                       upstren       == 1'b0) ? usb_outbsy :
                                                ~hsnak_ff ;



















  assign usbout0bc = out0bc;




  always @(pid or out0ovbc or tokrcvfall or endp or
           overflowwr or settoken or settoken_ff or sendtok)
    begin : OUT0OVBC_NXT_COMB_PROC

    out0ovbc_nxt = out0ovbc ;


    if ((settoken == 1'b1 && settoken_ff == 1'b0) ||
       ((pid == PID_OUT || pid == PID_SETUP) &&
         tokrcvfall == 1'b1 && endp == 4'h0) ||
        (sendtok == 1'b1 && endp == 4'h0))
      begin

      out0ovbc_nxt = 7'b000_0000;
      end
    else
      begin

      if (endp == 4'h0 && overflowwr == 1'b1)
        begin

        out0ovbc_nxt = out0ovbc + 2'b01 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : OUT0OVBC_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      out0ovbc <= 7'b000_0000;
      end
    else
      begin
      out0ovbc <= out0ovbc_nxt ;
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SETUP_BUFF_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      setup_buff0 <= 8'h00 ;
      setup_buff1 <= 8'h00 ;
      setup_buff2 <= 8'h00 ;
      setup_buff3 <= 8'h00 ;
      setup_buff4 <= 8'h00 ;
      setup_buff5 <= 8'h00 ;
      setup_buff6 <= 8'h00 ;
      setup_buff7 <= 8'h00 ;
      end
    else
      begin
      if (endp == 4'h0 && wr == 1'b1 && settoken == 1'b1)
        begin
        case (out0bc[2:0])
          3'b000 :
            begin
            setup_buff0 <= outdatawr ;
            end
          3'b001 :
            begin
            setup_buff1 <= outdatawr ;
            end
          3'b010 :
            begin
            setup_buff2 <= outdatawr ;
            end
          3'b011 :
            begin
            setup_buff3 <= outdatawr ;
            end
          3'b100 :
            begin
            setup_buff4 <= outdatawr ;
            end
          3'b101 :
            begin
            setup_buff5 <= outdatawr ;
            end
          3'b110 :
            begin
            setup_buff6 <= outdatawr ;
            end

          default :
            begin
            setup_buff7 <= outdatawr ;
            end
        endcase
        end
      end
    end




  assign setupbuff = {setup_buff7,
                      setup_buff6,
                      setup_buff5,
                      setup_buff4,
                      setup_buff3,
                      setup_buff2,
                      setup_buff1,
                      setup_buff0} ;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : CHGSETUP_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      chgsetup <= 1'b0;
      end
    else
      begin
      if (upstren == 1'b0)
        begin
        chgsetup <= 1'b0;
        end
      else if (clroutbsy_setup == 1'b1)
        begin
        chgsetup <= 1'b1;
        end
      else
        begin
        chgsetup <= 1'b0;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TOGGLEOUT_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      toggleout_bit <= 1'b0 ;
      end
    else
      begin
      if (upstren == 1'b1)
        begin
        if (settoken == 1'b1 && settoken_ff == 1'b0)
          begin

          toggleout_bit <= 1'b0 ;
          end
        else if (clroutbsy == 1'b1 && endp == 4'h0)
          begin

          if (settoken == 1'b1)
            begin

            toggleout_bit <= 1'b1 ;
            end
          else
            begin

            if (datastage == 1'b1)
              begin
              toggleout_bit <= ~toggleout_bit ;
              end
            else
              begin
              toggleout_bit <= 1'b1 ;
              end
            end
          end
        end
      else
        begin

        if (hcclrtoggle == 1'b1)
          begin
          toggleout_bit <= 1'b0 ;
          end
        else if (hcsettoggle == 1'b1 ||
                 hcset == 1'b1)
          begin
          toggleout_bit <= 1'b1 ;
          end
        else if (endp == 4'h0 &&
                 clroutbsy == 1'b1)
          begin
          toggleout_bit <= ~toggleout_bit ;
          end
        end
      end
    end




  assign ep0toggleout = toggleout_bit ;








  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USB_INBSY_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usb_inbsy <= 1'b0 ;
      end
    else
      begin
      if (fiforst == 1'b1)
        begin
        usb_inbsy <= 1'b0 ;
        end
      else
        begin

        if ((usb_inbsy == 1'b1 && usbinbsyclr == 1'b1) ||
             clroutbsy_setup == 1'b1 ||
             enterhm == 1'b1 ||
             hcset == 1'b1 ||
             hcsetlpm == 1'b1 ||
             usbreset == 1'b1 ||
            (discon == 1'b1 && upstren == 1'b1))
          begin
          usb_inbsy <= 1'b0 ;
          end
        else if (usb_inbsy == 1'b0 && setinbsyreq == 1'b1)
          begin

          usb_inbsy <= 1'b1 ;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBINBSYCLR_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usbinbsyclr <= 1'b0 ;
      end
    else
      begin

      if (clrinbsy == 1'b1 && endp == 4'h0)
        begin
        usbinbsyclr <= 1'b1 ;
        end
      else
        begin
        usbinbsyclr <= 1'b0 ;
        end
      end
    end




  assign ep0busyin = (changeoftrdir == 1'b0 ||
                      upstren       == 1'b0) ? usb_inbsy :
                                               ~hsnak_ff ;




  always @(rd or usbin0bc)
    begin : USBIN0BC_NXT_COMB_PROC


    if (rd == 1'b1)
      begin

      usbin0bc_nxt = usbin0bc + 2'b01;
      end
    else
      begin
      usbin0bc_nxt = usbin0bc ;
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : USBIN0BC_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      usbin0bc <= 7'b000_0000 ;
      end
    else
      begin
      if (txfall == 1'b1 && rd == 1'b0 && endp == 4'h0)

        begin

        usbin0bc <= 7'b000_0000;
        end
      else
        begin

        if (endp == 4'h0)
          begin
          usbin0bc <= usbin0bc_nxt ;
          end
        end
      end
    end




  assign usbfifoptrrd = {5'b0_0000, usbin0bc} ;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : UPIN0BCREG_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      upin0bcreg <= 7'b000_0000;
      end
    else
      begin
      if (fiforst == 1'b1 ||
          usbinbsyclr == 1'b1)
        begin
        upin0bcreg <= 7'b000_0000;
        end
      else if (setinbsyreq == 1'b1)
        begin
        upin0bcreg <= upin0bc ;
        end
      end
    end




  always @(upin0bcreg or usbin0bc_nxt)
    begin : DVI_NXT_COMB_PROC
      reg [7:0] diff_v;


    diff_v   = ({1'b1, upin0bcreg}) -
               ({1'b0, usbin0bc_nxt});




    if (diff_v[7] == 1'b1)
      begin

      if (|diff_v[6:1] == 1'b1)
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
      if (changeoftrdir == 1'b0)
        begin
        dvi <= dvi_nxt;
        end
      else
        begin

        dvi <= 1'b0 ;
        end
      end
    end




  assign fiforst = fiforstin | fiforstout;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TOGGLEIN_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      togglein_bit <= 1'b0 ;
      end
    else
      begin

      if (upstren == 1'b1)
        begin

        if (statusstage == 1'b1 || settoken == 1'b1)
          begin
          togglein_bit <= 1'b1 ;
          end
        else if (clrinbsy == 1'b1 && endp == 4'h0)
          begin
          togglein_bit <= ~togglein_bit ;
          end
        end
      else
        begin

        if (hcclrtoggle == 1'b1 || hcset == 1'b1)
          begin
          togglein_bit <= 1'b0 ;
          end
        else if (hcsettoggle == 1'b1)
          begin
          togglein_bit <= 1'b1 ;
          end
        else if (clrinbsy == 1'b1 && endp == 4'h0)
          begin
          togglein_bit <= ~togglein_bit ;
          end
        end
      end
    end




  assign ep0togglein = togglein_bit ;








  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : SET_ADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      set_addr <= 1'b0 ;
      end
    else
      begin
      if (setup_buff0 == 8'h00 &&
          setup_buff1 == 8'h05)
        begin

        set_addr <= 1'b1 ;
        end
      else
        begin
        set_addr <= 1'b0 ;
        end
      end
    end




  assign setaddr = (clroutbsy_setup == 1'b1 && set_addr == 1'b1) ? 1'b1 :
                                                                   1'b0 ;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TEST_MODE_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      test_mode_req <= 1'b0 ;
      test_mode_err <= 1'b0 ;
      test_mode_nak <= 1'b0 ;
      end
    else
      begin
      if (setup_buff0 == 8'h00 &&
          setup_buff1 == 8'h03 &&
          setup_buff2 == 8'h02 &&
          setup_buff3 == 8'h00)
        begin
        case (setup_buff5)
          8'h01,
          8'h02,
          8'h03,
          8'h04 :
            begin
            if (hsmode == 1'b1)
              begin
              test_mode_req <= 1'b1 ;
              test_mode_err <= 1'b0 ;
              test_mode_nak <= 1'b0 ;
              end
            else
              begin
              test_mode_req <= 1'b1 ;
              test_mode_err <= 1'b1 ;
              test_mode_nak <= 1'b0 ;
              end
            end
          default :
            begin
            test_mode_req <= 1'b1 ;
            test_mode_err <= 1'b0 ;
            test_mode_nak <= 1'b1 ;
            end
        endcase
        end
      else
        begin
        test_mode_req <= 1'b0 ;
        test_mode_err <= 1'b0 ;
        test_mode_nak <= 1'b0 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TESTMODESEL_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      test_mode_sel <= 2'b00 ;
      test_mode     <= 1'b0 ;
      end
    else
      begin
      if (upstren == 1'b1)
        begin

        if (statusstage == 1'b1 &&
            clrinbsy == 1'b1 && endp == 4'h0 &&
            test_mode_req == 1'b1)
          begin




          case (setup_buff5)
            8'h01 :
              begin

              test_mode_sel <= 2'b00 ;
              test_mode     <= 1'b1 ;
              end
            8'h02 :
              begin

              test_mode_sel <= 2'b01 ;
              test_mode     <= 1'b1 ;
              end
            8'h03 :
              begin

              test_mode_sel <= 2'b10 ;
              test_mode     <= 1'b1 ;
              end
            8'h04 :
              begin

              test_mode_sel <= 2'b11 ;
              test_mode     <= 1'b1 ;
              end
            default :
              begin
              test_mode_sel <= 2'b00 ;
              test_mode     <= 1'b0 ;
              end
          endcase
          end
        end
      else
        begin

        if (portctrltm[0] == 1'b1)
          begin

          test_mode_sel <= 2'b00 ;
          test_mode     <= 1'b1 ;
          end
        else if (portctrltm[1] == 1'b1)
          begin

          test_mode_sel <= 2'b01 ;
          test_mode     <= 1'b1 ;
         end
        else if (portctrltm[2] == 1'b1)
          begin

          test_mode_sel <= 2'b10 ;
          test_mode     <= 1'b1 ;
          end
        else if (portctrltm[3] == 1'b1)
          begin

          test_mode_sel <= 2'b11 ;
          test_mode     <= 1'b1 ;
          end
        else
          begin

          test_mode_sel <= 2'b00 ;
          test_mode     <= 1'b0 ;
          end
        end
      end
    end




  assign testmodesel = test_mode_sel ;




  assign testmode = test_mode ;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : TESTMODECUSTOM_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      tmodecustom    <= 1'b0 ;
      tmodeselcustom <= {8{1'b0}} ;
      end
    else
      begin
      if (statusstage == 1'b1 &&
          clrinbsy == 1'b1 && endp == 4'h0 &&
          test_mode_req == 1'b1)
        begin




        if (setup_buff5 != 8'h01 &&
            setup_buff5 != 8'h02 &&
            setup_buff5 != 8'h03 &&
            setup_buff5 != 8'h04)
          begin
          tmodecustom <= 1'b1 ;
          tmodeselcustom <= setup_buff5 ;
          end
        end
      else
        begin
        tmodecustom <= 1'b0 ;
        end
      end
    end




  assign testmodereq = (clroutbsy_setup == 1'b1 && set_addr      == 1'b0 &&
                                                   test_mode_req == 1'b1 &&
                                                   test_mode_err == 1'b0 &&
                                                   test_mode_nak == 1'b0) ? 1'b1 :
                                                                            1'b0 ;




  assign testmodeerr = (clroutbsy_setup == 1'b1 && set_addr      == 1'b0 &&
                                                   test_mode_req == 1'b1 &&
                                                   test_mode_err == 1'b1) ? 1'b1 :
                                                                            1'b0 ;




  assign testmodenak = (clroutbsy_setup == 1'b1 && set_addr      == 1'b0 &&
                                                   test_mode_req == 1'b1 &&
                                                   test_mode_nak == 1'b1) ? 1'b1 :
                                                                            1'b0 ;




  assign setupack = (clroutbsy_setup == 1'b1 && set_addr      == 1'b0 &&
                                                test_mode_req == 1'b0) ? 1'b1 :
                                                                         1'b0 ;




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : FNADDRUSB_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      fnaddrusb <= 7'b000_0000;
      end
    else
      begin
      if (usbreset == 1'b1)
        begin
        fnaddrusb <= 7'b000_0000;
        end
      else
        begin
        if (upstren == 1'b1)
          begin
          if (discon == 1'b1)
            begin
            fnaddrusb <= 7'b000_0000;
            end
          else if (statusstage == 1'b1 &&
                   txfall == 1'b1 &&
                   sendpckt == 1'b1 &&
                   endp == 4'h0 &&
                   set_addr == 1'b1)
            begin


            fnaddrusb <= setup_buff2[6:0] ;
            end
          end
        else
          begin
          fnaddrusb <= fnaddrup ;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : DATASTAGE_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      datastage   <= 1'b0 ;
      statusstage <= 1'b0 ;
      ep0_dir     <= 1'b0 ;
      end
    else if (usbreset == 1'b1 || discon == 1'b1)
      begin
      datastage   <= 1'b0 ;
      statusstage <= 1'b0 ;
      ep0_dir     <= 1'b0 ;
      end
    else
      begin
      if (clroutbsy_setup == 1'b1)
        begin
        if (setup_buff6 == 8'h00 &&
            setup_buff7 == 8'h00)
          begin
          datastage   <= 1'b0 ;
          statusstage <= 1'b1 ;
          ep0_dir     <= 1'b0 ;
          end
        else
          begin
          datastage   <= 1'b1 ;
          statusstage <= 1'b0 ;
          ep0_dir     <= setup_buff0[7] ;
          end
        end
      else if ((tokrcvfall == 1'b1 &&
                endp == 4'h0 &&
             (((pid == PID_OUT ||
                pid == PID_PING) && ep0_dir == 1'b1) ||
               (pid == PID_IN    && ep0_dir == 1'b0))) &&
                datastage == 1'b1)
        begin



        datastage   <= 1'b0 ;
        statusstage <= 1'b1 ;
        end
      end
    end




  assign ep0datastage = datastage ;



  assign clroutbsy_setup = (clroutbsy == 1'b1 && endp == 4'h0 && settoken == 1'b1) ? 1'b1 :
                                                                                     1'b0 ;








  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HC_DOSETUP_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hc_dosetup <= 1'b0 ;
      end
    else
      begin
      if (enterhm == 1'b1)
        begin
        hc_dosetup <= 1'b0 ;
        end
      else if (hcset == 1'b1)
        begin
        hc_dosetup <= 1'b1 ;
        end
      else if (clrinbsy == 1'b1 && endp == 4'h0)
        begin

        hc_dosetup <= 1'b0 ;
        end
      end
    end





  assign hcdosetup = hc_dosetup ;





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDOLPM_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hc_dolpm <= 1'b0 ;
      end
    else
      begin
      if (enterhm == 1'b1 ||
          hcset == 1'b1)
        begin
        hc_dolpm <= 1'b0 ;
        end
      else if (hcsetlpm == 1'b1)
        begin
        hc_dolpm <= 1'b1 ;
        end
      else if (clrinbsy == 1'b1 && endp == 4'h0)
        begin
        hc_dolpm <= 1'b0 ;
        end
      end
    end





  assign hcdolpm = hc_dolpm ;







  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
  begin : HCOUTERRTYPE_R_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcouterrtypeusb  <= 3'b000 ;
      hcouterrcountusb <= 2'b00 ;
      end
    else
      begin
      if (fiforst == 1'b1 ||
          hcset == 1'b1 ||
          hcoutresend == 1'b1)
        begin


        hcouterrtypeusb  <= 3'b000 ;
        hcouterrcountusb <= 2'b00 ;
        end
      else if (hcepnr == 4'h0 && hcepdir == 1'b0)
        begin
        if (hcerrinc == 1'b1)
          begin
          hcouterrtypeusb  <= hcerrtype ;
          hcouterrcountusb <= hcouterrcountusb + 1'b1 ;
          end
        else if (hcerrset == 1'b1)
          begin
          hcouterrtypeusb  <= hcerrtype ;
          hcouterrcountusb <= 2'b11 ;
          end
        else if (hcerrclr == 1'b1)
          begin
          hcouterrtypeusb  <= 3'b000 ;
          hcouterrcountusb <= 2'b00 ;
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCOUTEPSUSPEND_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcoutepsuspend <= 1'b0 ;
      end
    else
      begin
      if (fiforst == 1'b1 ||
          hcset == 1'b1 ||
          hcoutresend == 1'b1)
        begin

        hcoutepsuspend <= 1'b0 ;
        end
      else if (hcouterrcountusb == 2'b11)
        begin
        hcoutepsuspend <= 1'b1 ;
        end
      end
    end







  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCOUTEPWAIT_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcoutepwait <= 1'b0 ;
      end
    else
      begin
      if (hcsendsof == 1'b1 ||
          hcepwaitclr == 1'b1)
        begin

        hcoutepwait <= 1'b0 ;
        end
      else if (hcepnr == 4'h0 && hcepdir == 1'b0 &&
               hcepwaitset == 1'b1)
        begin


        hcoutepwait <= 1'b1 ;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCDOPING_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcdoping <= 1'b0 ;
      end
    else
      begin
      if (hsmode == 1'b0 ||
          hcdopingrst == 1'b1 ||
          hc_dosetup == 1'b1)
        begin
        hcdoping <= 1'b0 ;
        end
      else if ((hcepnr == 4'h0 && hcepdir == 1'b0) ||
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





  assign hcout0maxpckusb = {4'h0, upin0bcreg} ;






  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCINERR_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcinerrtypeusb  <= 3'b000 ;
      hcinerrcountusb <= 2'b00 ;
      end
    else
      begin
      if (fiforst == 1'b1 ||
          hcset == 1'b1 ||
          hcinresend == 1'b1)
        begin


        hcinerrtypeusb  <= 3'b000 ;
        hcinerrcountusb <= 2'b00 ;
        end
      else if (hcepnr == 4'h0 && hcepdir == 1'b1)
        begin
        if (hcerrinc == 1'b1)
          begin
          hcinerrtypeusb  <= hcerrtype ;
          hcinerrcountusb <= hcinerrcountusb + 1'b1 ;
          end
        else if (hcerrset == 1'b1)
          begin
          hcinerrtypeusb  <= hcerrtype ;
          hcinerrcountusb <= 2'b11 ;
          end
        else if (hcerrclr == 1'b1)
          begin
          hcinerrtypeusb  <= 3'b000 ;
          hcinerrcountusb <= 2'b00 ;
          end
        end
      end
    end





  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCINEPSUSPEND_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcinepsuspend <= 1'b0 ;
      end
    else
      begin
      if (fiforst == 1'b1 ||
          hcset == 1'b1 ||
          hcinresend == 1'b1)
        begin

        hcinepsuspend <= 1'b0 ;
        end
      else if (hcinerrcountusb == 2'b11)
        begin
        hcinepsuspend <= 1'b1 ;
        end
      end
    end







  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : HCINEPWAIT_SYNC_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      hcinepwait <= 1'b0 ;
      end
    else
      begin
      if (hcsendsof == 1'b1 ||
          hcepwaitclr == 1'b1)
        begin

        hcinepwait <= 1'b0 ;
        end
      else if (hcepnr == 4'h0 && hcepdir == 1'b1 &&
               hcepwaitset == 1'b1)
        begin


        hcinepwait <= 1'b1 ;
        end
      end
    end





  assign hcin0maxpckusb = {4'h0, out0maxpck} ;




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

endmodule

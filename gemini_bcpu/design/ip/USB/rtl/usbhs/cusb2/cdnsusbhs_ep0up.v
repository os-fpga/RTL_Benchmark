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
//   Filename:           cdnsusbhs_ep0up.v
//   Module Name:        cdnsusbhs_ep0up
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
//   Endpoint 0 - microprocessor clock domain
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_ep0up
  (
  upclk,
  uprst,
  usbout0bc,
  usboutbsyclr,
  usbinbsyclr,
  fnaddrusb,
  setupack,
  setaddr,
  testmodereq,
  testmodeerr,
  testmodenak,
  usbresetup,
  discon,
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
  lpm_token,
  lpm_auto_entry,
  upin0bc,
  setoutbsyreq,
  setinbsyreq,
  hsnak,
  stall,
  dstall,
  fnaddrup,
  outbsyfall,
  inbsyfall,
  hcinerrtype,
  hcouterrtype,
  hcinerrcount,
  hcouterrcount,
  hcdoping,
  enterhm,
  upstren,
  chgsetup,
  hcendpnr,
  hcinresend,
  hcoutresend,
  hcdopingset,
  hcsettoggle,
  hcclrtoggle,
  hcsetlpm,
  hcset,
  hclpmctrl,
  hclpmctrlb,
  hcunderrien,
  hcinerrirq,
  hcouterrirq,
  setupbuff,
  clroutbsy_setup,

  fiforstin,
  fiforstout,

  fifoinendp,
  fifoend,
  fifowr,
  fifofull,


  fifooutendp,

  fiford,
  fifodval,
  fifoempty,

  out0maxpck,
  fifoacc,
  fifobc,
  upfifoptrwr,
  upfifoptrrd,

  buf_enable,
  val,

  hcnak_hshk,

  updatao
  );

  `include "cdnsusbhs_cusb2_params.v"

  input                            upclk;
  input                            uprst;
  input  [6:0]                     usbout0bc;
  input                            usboutbsyclr;
  input                            usbinbsyclr;
  input  [6:0]                     fnaddrusb;
  input                            setupack;
  input                            setaddr;
  input                            testmodereq;
  input                            testmodeerr;
  input                            testmodenak;
  input                            usbresetup;
  input                            discon;
  input  [7:0]                     upaddr;
  input  [7:0]                     updatai_0;
  input  [6:0]                     updatai_1;
  input  [7:0]                     updatai_2;
  input  [7:0]                     updatai_3;
  input                            updataival_0;
  input                            updataival_1;
  input                            updataival_2;
  input                            updataival_3;
  input                            upwr;
  input  [5:0]                     lpm_token;
  output                           lpm_auto_entry;
  reg                              lpm_auto_entry;
  output [6:0]                     upin0bc;
  wire   [6:0]                     upin0bc;
  output                           setoutbsyreq;
  reg                              setoutbsyreq;
  output                           setinbsyreq;
  wire                             setinbsyreq;
  output                           hsnak;
  wire                             hsnak;
  output                           stall;
  wire                             stall;
  output                           dstall;
  wire                             dstall;
  output                           outbsyfall;
  wire                             outbsyfall;
  output                           inbsyfall;
  wire                             inbsyfall;
  output [6:0]                     fnaddrup;
  reg    [6:0]                     fnaddrup;
  input  [2:0]                     hcinerrtype;
  input  [2:0]                     hcouterrtype;
  input  [1:0]                     hcinerrcount;
  input  [1:0]                     hcouterrcount;
  input                            hcdoping;
  input                            enterhm;
  input                            upstren;
  input                            chgsetup;
  output [3:0]                     hcendpnr;
  wire   [3:0]                     hcendpnr;
  output                           hcinresend;
  reg                              hcinresend;
  output                           hcoutresend;
  reg                              hcoutresend;
  output                           hcdopingset;
  reg                              hcdopingset;
  output                           hcsettoggle;
  reg                              hcsettoggle;
  output                           hcclrtoggle;
  reg                              hcclrtoggle;
  output                           hcsetlpm;
  reg                              hcsetlpm;
  output                           hcset;
  reg                              hcset;
  output                           hcunderrien;
  reg                              hcunderrien;
  output [7:0]                     hclpmctrl;
  reg    [7:0]                     hclpmctrl;
  output                           hclpmctrlb;
  reg                              hclpmctrlb;
  output                           hcinerrirq;
  wire                             hcinerrirq;
  output                           hcouterrirq;
  wire                             hcouterrirq;
  input  [63:0]                    setupbuff;
  input                            clroutbsy_setup;

  input                            fiforstout;
  input                            fiforstin;

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

  input  [6:0]                     out0maxpck;
  input                            fifoacc;
  output [10:0]                    fifobc;
  wire   [10:0]                    fifobc;
  output [11:0]                    upfifoptrwr;
  reg    [11:0]                    upfifoptrwr;
  output [11:0]                    upfifoptrrd;
  wire   [11:0]                    upfifoptrrd;

  input                            buf_enable;
  output                           val;
  reg                              val;

  output [5:0]                     hcnak_hshk;
  reg    [5:0]                     hcnak_hshk;

  output [31:0]                    updatao;
  reg    [31:0]                    updatao;


  wire   [4:0]                     ep0cs;
  reg    [6:0]                     out0bc;
  reg    [6:0]                     upout0bc;
  reg    [6:0]                     upout0bc_nxt;
  reg    [6:0]                     in0bc;
  reg    [6:0]                     in0bc_nxt;
  reg                              ep0hsnak;
  reg                              ep0stall;
  reg                              ep0dstall;
  reg                              setoutbsy;
  reg                              upoutbsy;
  reg                              setinbsy_up;
  reg                              setinbsy_fifo;
  wire                             setinbsy;
  reg                              upinbsy;

  reg                              fifoautoin;
  reg                              fifocmitin;
  reg    [2:0]                     incr_fifo_s;
  reg    [2:0]                     incr_s;

  reg    [3:0]                     hcep0ctrl;
  wire   [4:0]                     hcin0err;
  wire   [4:0]                     hcout0err;
  reg                              hcinerrirq_ff;
  reg                              hcouterrirq_ff;

  reg                              chgsetup_r;


  reg                              fifoautoout;
  reg                              fifocmitout;
  reg                              fifoempty_ff;
  reg                              fifoempty_hm;
  reg    [3:0]                     fifooutendp_ff;

  wire                             fiforst;

  reg                              hcoutbsyfall;
  reg                              hcoutbsyfall_r;



  assign fiforst = fiforstin | fiforstout;







  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT0BC_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out0bc <= 7'b000_0000;
      end
    else
      begin
      if (fiforst == 1'b1 || setoutbsy == 1'b1)
        begin

        out0bc <= 7'b000_0000;
        end
      else
        begin

        if (upoutbsy == 1'b1 && usboutbsyclr == 1'b1)
          begin
          out0bc <= usbout0bc ;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFOENDPNRFF_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifooutendp_ff <= 4'h0;
      end
    else
      begin
      fifooutendp_ff <= fifooutendp;
      end
    end




  always @(upwr or upaddr or updataival_0 or

           fifoautoout or fiford or fifocmitout or fifooutendp_ff or
           buf_enable or val or upoutbsy or
           out0bc or upout0bc)
    begin : SETOUTBSY_COMB_PROC

      reg [8:0] outxbc_v;
    outxbc_v = ({2'b10, out0bc} -
                {2'b00, upout0bc});



    setoutbsy = 1'b0 ;


    if (upaddr == 8'h00 &&
        updataival_0 == 1'b1 &&
        upwr == 1'b1)
      begin

      setoutbsy = 1'b1 ;
      end
    else if ((fifoautoout == 1'b1 || fifocmitout == 1'b1) &&
              fifooutendp_ff == 4'b0000)
      begin






      if (buf_enable == 1'b1 && val == 1'b0 && upoutbsy  == 1'b0)
        begin
        setoutbsy = 1'b1;
        end
      else if (fiford == 1'b1)
        begin


        if (|outxbc_v[7:3] == 1'b0 && (outxbc_v[2:0] == 3'b100 ||
                                       outxbc_v[2]   == 1'b0))
          begin
          setoutbsy = 1'b1;
          end
        end
      end
    end









































  always @(upout0bc or fiforst or
           fiford or fifooutendp_ff or
           setoutbsy)
    begin : UPOUT0BC_NXT_COMB_PROC


    upout0bc_nxt = upout0bc;

    if (fiforst == 1'b1 || setoutbsy == 1'b1)
      begin

      upout0bc_nxt = 7'b000_0000;
      end
    else
      begin

      if (fiford == 1'b1 && fifooutendp_ff == 4'b0000)
        begin

        upout0bc_nxt = upout0bc + 3'b100;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : UPOUT0BC_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      upout0bc <= 7'b000_0000;
      end
    else
      begin
      upout0bc <= upout0bc_nxt;
      end
    end




  assign upfifoptrrd = {5'b00000, upout0bc_nxt};



  assign fifobc = {4'b0000, out0bc};




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : SETOUTBSYREQ_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      setoutbsyreq <= 1'b0 ;
      end
    else
      begin
      setoutbsyreq <= setoutbsy ;
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : UPOUTBSY_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      upoutbsy <= 1'b0 ;
      end
    else
      begin
      if (fiforst == 1'b1 && upstren == 1'b1)
        begin

        upoutbsy <= 1'b1;
        end
      else
        begin

        if ((upoutbsy == 1'b1 && usboutbsyclr == 1'b1) ||
             clroutbsy_setup == 1'b1 ||
             enterhm == 1'b1 ||
             hcset == 1'b1 ||
             hcsetlpm == 1'b1 ||
             usbresetup == 1'b1 ||
             fiforst == 1'b1 ||
            (discon == 1'b1 && upstren == 1'b1))
          begin



          upoutbsy <= 1'b0 ;
          end
        else if (upoutbsy == 1'b0 && setoutbsy == 1'b1)
          begin
          upoutbsy <= 1'b1 ;
          end
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCOUTBSYFALL_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcoutbsyfall_r <= 1'b0;
      hcoutbsyfall   <= 1'b0;
      end
    else
      begin
      hcoutbsyfall_r <= (upoutbsy & usboutbsyclr);
      hcoutbsyfall   <=  hcoutbsyfall_r;
      end
    end




  assign outbsyfall = (upstren == 1'b1) ? (upoutbsy & usboutbsyclr) :
                                           hcoutbsyfall ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFOEMPTY_FF_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoempty_ff <= 1'b1;
      end
    else
      begin
      if (setoutbsy == 1'b1 ||
          enterhm == 1'b1)
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
      if (setoutbsy == 1'b1 ||
         (fiforst == 1'b1 && upstren == 1'b1))
        begin
        fifoempty_hm <= 1'b0;
        end
      else if (enterhm == 1'b1 || hcset == 1'b1 || fiforst == 1'b1)
        begin
        fifoempty_hm <= 1'b1;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : VAL_DMA_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      val <= 1'b0;
      end
    else
      begin
      if (upstren == 1'b1 || fifoautoout == 1'b0)
        begin
        val <= 1'b1;
        end
      else
        begin
        val <= buf_enable;
        end
      end
    end




  assign fifoempty = (fifoautoout == 1'b0 &&
                      fifocmitout == 1'b0) ? 1'b1 :
                                            (upoutbsy | fifoempty_ff | fifoempty_hm | setoutbsy);




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : EP0FIFO_OUT_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifocmitout <= 1'b0;
      fifoautoout <= OUTXCS_RV[4];
      end
    else
      begin
      if (upaddr == 8'h01 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1 &&
          updatai_3[4] == 1'b0)
        begin

        fifocmitout <= updatai_3[6];
        fifoautoout <= updatai_3[5];
        end
      else if (setoutbsy == 1'b1)
        begin
        fifocmitout <= 1'b0;
        end
      end
    end



























  assign upin0bc = in0bc_nxt;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN0BC_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in0bc <= 7'b000_0000;
      end
    else
      begin
      if (fiforst == 1'b1 ||
          (upinbsy == 1'b1 && usbinbsyclr == 1'b1))
        begin

        in0bc <= 7'b000_0000;
        end
      else
        begin
        in0bc <= in0bc_nxt;
        end
      end
    end




  always @(upwr or upaddr or updataival_1 or updatai_1 or
           in0bc or incr_s)
    begin : IN0BC_NXT_PROC

    if (upaddr == 8'h00 &&
        updataival_1 == 1'b1 &&
        upwr == 1'b1)
      begin
      in0bc_nxt = updatai_1[6:0] ;
      end
    else
      begin
      in0bc_nxt = in0bc + incr_s ;
      end
    end




  always @(fifodval or fifowr or fifoinendp)
    begin : INCR_S_FIFO_COMB_PROC

    incr_fifo_s = 3'b000;


    if (fifowr == 1'b1 && fifoinendp == 4'b0000)
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




  always @(fifoacc or  incr_fifo_s)
    begin : INCR_S_COMB_PROC




    if (fifoacc == 1'b1)
      begin
      incr_s = 3'b000;
      end
    else
      begin
      incr_s = incr_fifo_s;
      end
    end




  always @(in0bc)
    begin : UPFIFOPTRWR_COMB_PROC

    upfifoptrwr = {5'b00000, in0bc};
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : EP0FIFO_IN_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifocmitin <= 1'b0;
      fifoautoin <= INXCS_RV[4];
      end
    else
      begin
      if (upaddr == 8'h01 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1 &&
          updatai_3[4] == 1'b1)
        begin

        fifocmitin <= updatai_3[6];
        fifoautoin <= updatai_3[5];
        end
      else if (setinbsy == 1'b1)
        begin
        fifocmitin <= 1'b0;
        end
      end
    end




  always @(upwr or upaddr or updataival_1)
    begin : SETINBSY_COMB_PROC

    setinbsy_up = 1'b0;


    if (upaddr == 8'h00 &&
        updataival_1 == 1'b1 &&
        upwr == 1'b1)
      begin

      setinbsy_up = 1'b1;
      end
    end




  always @(fifoend or fifoautoin or fifocmitin or fifowr or fifoinendp or
           in0bc_nxt or out0maxpck)
    begin : SETBINSY_FIFO_COMB_PROC

    setinbsy_fifo = 1'b0 ;



    if ((fifoautoin == 1'b1 || fifocmitin == 1'b1) &&
         fifoinendp == 4'b0000 &&
         (fifoend == 1'b1 ||
         (fifowr == 1'b1 && in0bc_nxt == out0maxpck)))
      begin



      setinbsy_fifo = 1'b1 ;
      end
    end




  assign setinbsy =
                    setinbsy_fifo |
                    setinbsy_up;















  assign setinbsyreq = setinbsy ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : UPINBSY_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      upinbsy <= 1'b0 ;
      end
    else
      begin
      if (fiforst == 1'b1)
        begin
        upinbsy <= 1'b0 ;
        end
      else
        begin

        if ((upinbsy == 1'b1 && usbinbsyclr == 1'b1) ||
             clroutbsy_setup == 1'b1 ||
             enterhm == 1'b1 ||
             hcset == 1'b1 ||
             hcsetlpm == 1'b1 ||
             usbresetup == 1'b1 ||
            (discon == 1'b1 && upstren == 1'b1))
          begin



          upinbsy <= 1'b0 ;
          end
        else if (upinbsy == 1'b0 && setinbsy == 1'b1)
          begin
          upinbsy <= 1'b1 ;
          end
        end
      end
    end




  assign inbsyfall = (upinbsy & usbinbsyclr);
















  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : EP0CS_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin

      ep0dstall <= EP0CS_RV[4] ;
      ep0hsnak  <= EP0CS_RV[1] ;
      ep0stall  <= EP0CS_RV[0] ;
      end
    else
      begin




      if (setaddr == 1'b1)
        begin

        ep0dstall <= 1'b0 ;
        ep0hsnak  <= 1'b0 ;
        ep0stall  <= 1'b0 ;
        end

      else if (testmodeerr == 1'b1)
        begin
        ep0dstall <= 1'b1 ;
        ep0hsnak  <= 1'b1 ;
        ep0stall  <= 1'b1 ;
        end

      else if (testmodenak == 1'b1)
        begin
        ep0dstall <= 1'b0 ;
        ep0hsnak  <= 1'b1 ;
        ep0stall  <= 1'b0 ;
        end

      else if (testmodereq == 1'b1)
        begin

        ep0dstall <= 1'b0 ;
        ep0hsnak  <= 1'b0 ;
        ep0stall  <= 1'b0 ;
        end
      else if (setupack == 1'b1)
        begin
        ep0dstall <= 1'b0 ;
        ep0hsnak  <= 1'b1 ;
        ep0stall  <= 1'b0 ;
        end

      else if (upaddr == 8'h00 &&
               updataival_2 == 1'b1 &&
               upwr == 1'b1)
        begin
        if (upstren == 1'b1)
          begin
          ep0dstall <=             updatai_2[4] ;
          ep0hsnak  <= ep0hsnak & ~updatai_2[1] ;
          ep0stall  <=             updatai_2[0] ;
          end
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : EP0CS_CHGSETUP_R_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      chgsetup_r <= 1'b0;
      end
    else
      begin
      if (chgsetup == 1'b1)
        begin
        chgsetup_r <= 1'b1;
        end
      else if (upaddr == 8'h00 &&
               updataival_2 == 1'b1 &&
               upwr == 1'b1 && updatai_2[7] == 1'b1)
        begin
        chgsetup_r <= 1'b0;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCEP0CS_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcsetlpm    <= EP0CS_RV[7] ;
      hcsettoggle <= EP0CS_RV[6] ;
      hcclrtoggle <= EP0CS_RV[5] ;
      hcset       <= EP0CS_RV[4] ;
      end
    else
      begin
      if (upaddr == 8'h00 &&
          updataival_2 == 1'b1 &&
          upwr == 1'b1)
        begin
        if (upstren == 1'b0)
          begin
          hcsetlpm    <= updatai_2[7] ;
          hcsettoggle <= updatai_2[6] ;
          hcclrtoggle <= updatai_2[5] ;
          hcset       <= updatai_2[4] ;
          end
        end
      else
        begin
        hcsetlpm    <= 1'b0 ;
        hcsettoggle <= 1'b0 ;
        hcclrtoggle <= 1'b0 ;
        hcset       <= 1'b0 ;
        end
      end
    end




  assign ep0cs = {ep0dstall,
                  upoutbsy,
                  upinbsy,
                  ep0hsnak,
                  ep0stall} ;




  assign hsnak = ep0hsnak ;




  assign stall = ep0stall ;




  assign dstall = ep0dstall ;




  assign fifofull = (fifoautoin == 1'b0 &&
                     fifocmitin == 1'b0) ? 1'b1 :
                                           upinbsy;









  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FNADDRUP_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fnaddrup <= 7'b000_0000;
      end
    else
      begin
      if (usbresetup == 1'b1)
        begin
        fnaddrup <= 7'b000_0000;
        end
      else
        begin
        if (upstren == 1'b1)
          begin

          fnaddrup <= fnaddrusb ;
          end
        else
          begin

          if (upaddr == 8'h69 &&
              updataival_2 == 1'b1 &&
              upwr == 1'b1)
            begin

            fnaddrup <= updatai_2[6:0] ;
            end
          end
        end
      end
    end






  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCEP0CTRL_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcep0ctrl <= 4'h0 ;
      end
    else
      begin
      if (upaddr == 8'h30 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1)
        begin
        hcep0ctrl <= updatai_0[3:0] ;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCLPMCTRL_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hclpmctrl <= HCLPMCTRL_RV ;
      end
    else
      begin

      if (upaddr == 8'h01 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1)
        begin
        hclpmctrl <= updatai_0[7:0];
        end
      end
    end





  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCLPMCTRLB_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hclpmctrlb <= 1'b1 ;
      end
    else
      begin

      if (upaddr == 8'h01 &&
          updataival_1 == 1'b1 &&
          upwr == 1'b1)
        begin
        hclpmctrlb <= updatai_1[0];
        end
      end
    end




  assign hcendpnr = hcep0ctrl ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCOUT0ERR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcdopingset <= 1'b0 ;
      hcoutresend <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'h30 &&
          updataival_1 == 1'b1 &&
          upwr == 1'b1)
        begin
        hcdopingset <= updatai_1[6] ;
        hcoutresend <= updatai_1[5] ;
        end
      else
        begin
        hcdopingset <= 1'b0 ;
        hcoutresend <= 1'b0 ;
        end
      end
    end



  assign hcout0err = {hcouterrtype, hcouterrcount} ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCOUTERRIRQ_FF_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcouterrirq_ff <= 1'b0 ;
      end
    else
      begin
      hcouterrirq_ff <= hcout0err[1] & hcout0err[0] ;
      end
    end




  assign hcouterrirq = (hcout0err[1] & hcout0err[0] & ~hcouterrirq_ff) ;







  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCIN0ERR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcunderrien <= 1'b0 ;
      hcinresend  <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'h30 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1)
        begin
        hcunderrien <= updatai_3[7] ;
        hcinresend  <= updatai_3[5] ;
        end
      else
        begin
        hcinresend  <= 1'b0 ;
        end
      end
    end



  assign hcin0err = {hcinerrtype, hcinerrcount} ;





  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCINERRIRQ_FF_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcinerrirq_ff <= 1'b0 ;
      end
    else
      begin
      hcinerrirq_ff <= hcin0err[1] & hcin0err[0] ;
      end
    end





  assign hcinerrirq = (hcin0err[1] & hcin0err[0] & ~hcinerrirq_ff) ;



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCNAK_HSHK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcnak_hshk <= 6'b000000 ;
      end
    else
      begin
      if (upaddr == 8'h30 &&
          updataival_2 == 1'b1 &&
          upwr == 1'b1)
        begin
        hcnak_hshk <= {updatai_2[6:4], updatai_2[2:0]} ;
        end
      end
    end




  always @(out0bc or in0bc or ep0cs or upaddr or lpm_token or
           lpm_auto_entry or
           fifoautoin or fifoautoout or
           chgsetup_r or setupbuff or
           hcnak_hshk or
           hcin0err or hcdoping or hcout0err or hcep0ctrl or
           hclpmctrlb or hclpmctrl or
           upstren)
    begin : UPDATAO_COMB_PROC



    case (upaddr)

        8'h00 :
            begin
            updatao = {8'h00,
                       chgsetup_r, 2'b00, ep0cs,
                       1'b0, in0bc,
                       1'b0, out0bc};
            end

        8'h01 :
            begin
            if (upstren == 1'b1)
              begin
              updatao = {6'b0000_00, fifoautoin, fifoautoout,
                         lpm_auto_entry, 3'b000, 4'b0000,
                         lpm_token[5], 6'b000000, lpm_token[4],
                         lpm_token[3:0], 4'b0000};
              end
            else
              begin
              updatao = {6'b0000_00, fifoautoin, fifoautoout,
                         lpm_auto_entry, 3'b000, 4'b0000,
                         7'b0000000, hclpmctrlb,
                         hclpmctrl};
              end
            end

        8'h30 :
            begin
            updatao = {3'b000, hcin0err,
                       1'b0, hcnak_hshk[5:3], 1'b0, hcnak_hshk[2:0],
                       1'b0, hcdoping, 1'b0, hcout0err,
                       4'h0, hcep0ctrl};
            end

        8'h60 :
            begin
            updatao = setupbuff[8*4-1:0];
            end
        8'h61 :
            begin
            updatao = setupbuff[8*8-1:8*4];
            end
        default :
            begin
            updatao = {8'h00,
                       8'h00,
                       8'h00,
                       8'h00};
            end
    endcase
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : LPM_AUTO_ENTRY_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      lpm_auto_entry  <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'h01 &&
          updataival_2 == 1'b1 &&
          upwr == 1'b1)
        begin
        lpm_auto_entry  <= updatai_2[7] ;
        end
      end
    end

endmodule

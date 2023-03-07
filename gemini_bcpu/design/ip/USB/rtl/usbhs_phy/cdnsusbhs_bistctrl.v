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
//   Filename:           cdnsusbhs_bistctrl.v
//   Module Name:        cdnsusbhs_bistctrl
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
//   USBHS Top level with RAM - sample unit
//   T.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_bistctrl
  (
  `ifdef CDNSUSB2PHY_3RD
  `ifdef CDNSUSBHS_PHY_UTMI
  hs_bist_mode,
  hs_bist_ponrst,
  `endif
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  bistrst,
  bistclk,

  apb_pclk,
  apb_presetn,
  apb_pwrite,
  apb_penable,
  apb_pselx,
  apb_paddr,
  apb_pwdata,

  apb_prdata,
  apb_pready,
  apb_pslverr,

  tsfr_rstb,
  tsfr_addr_req,
  tsfr_addr,
  tsfr_rdata_req,
  tsfr_rdata,
  tsfr_wdata_req,
  tsfr_wdata,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `ifdef CDNSUSBHS_PHY_UTMI
  phy_utmi_reset_i,
  phy_ponrst_i,

  phy_utmi_reset_o,
  phy_ponrst_o,
  `endif
  `endif

  suspendm_low,
  `ifdef CDNSUSB2PHY_3RD
  `else
  sleepm_ref,
  sleepm_refclk,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  utmidppulldown_i,
  utmidmpulldown_i,

  utmidppulldown_o,
  utmidmpulldown_o,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  refsleepm_i,
  `endif
  utmisleepm_i,
  utmisuspendm_i,

  utmisleepm_o,
  utmisuspendm_o
  );

  `ifdef CDNSUSB2PHY_3RD
  `ifdef CDNSUSBHS_PHY_UTMI
  input                            hs_bist_mode;
  input                            hs_bist_ponrst;
  `endif
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  input                            bistrst;
  input                            bistclk;

  output                           apb_pclk;
  wire                             apb_pclk;
  output                           apb_presetn;
  wire                             apb_presetn;
  output                           apb_pwrite;
  reg                              apb_pwrite;
  output                           apb_penable;
  reg                              apb_penable;
  output                           apb_pselx;
  reg                              apb_pselx;
  output [7:0]                     apb_paddr;
  reg    [7:0]                     apb_paddr;
  output [7:0]                     apb_pwdata;
  reg    [7:0]                     apb_pwdata;

  input  [7:0]                     apb_prdata;
  input                            apb_pready;
  input                            apb_pslverr;

  input                            tsfr_rstb;
  input                            tsfr_addr_req;
  input  [7:0]                     tsfr_addr;
  output                           tsfr_rdata_req;
  reg                              tsfr_rdata_req;
  output [7:0]                     tsfr_rdata;
  reg    [7:0]                     tsfr_rdata;
  input                            tsfr_wdata_req;
  input  [7:0]                     tsfr_wdata;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `ifdef CDNSUSBHS_PHY_UTMI
  input                            phy_utmi_reset_i;
  input                            phy_ponrst_i;

  output                           phy_utmi_reset_o;
  wire                             phy_utmi_reset_o;
  output                           phy_ponrst_o;
  wire                             phy_ponrst_o;
  `endif
  `endif

  input                            suspendm_low;
  `ifdef CDNSUSB2PHY_3RD
  `else
  input                            sleepm_ref;
  input                            sleepm_refclk;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  input                            utmidppulldown_i;
  input                            utmidmpulldown_i;

  output                           utmidppulldown_o;
  wire                             utmidppulldown_o;
  output                           utmidmpulldown_o;
  wire                             utmidmpulldown_o;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  input                            refsleepm_i;
  `endif
  input                            utmisleepm_i;
  input                            utmisuspendm_i;

  output                           utmisleepm_o;
  wire                             utmisleepm_o;
  output                           utmisuspendm_o;
  wire                             utmisuspendm_o;

  `ifdef CDNSUSB2PHY_3RD
  `else
  wire                             refsleepm_cnt_low;
  reg    [5:0]                     refsleepm_cnt;
  reg                              refsleepm_i_r;
  reg                              refsleepm_i_r2;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  reg                              tsfr_addr_req_r1;
  reg                              tsfr_addr_req_r2;
  reg                              tsfr_addr_req_r3;
  reg                              tsfr_wdata_req_r1;
  reg                              tsfr_wdata_req_r2;
  reg                              tsfr_wdata_req_r3;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `ifdef CDNSUSBHS_PHY_UTMI


  assign phy_utmi_reset_o = (hs_bist_mode == 1'b1) ? 1'b0  :
                                                     phy_utmi_reset_i;



  assign phy_ponrst_o     = (hs_bist_mode == 1'b1) ? hs_bist_ponrst :
                                                     phy_ponrst_i;
  `endif
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else


  assign utmisuspendm_o   = (suspendm_low == 1'b1) ? 1'b0 :
                                                     utmisuspendm_i;



  assign utmisleepm_o     = (suspendm_low       == 1'b1) ? 1'b1 :
                            (sleepm_ref         == 1'b0) ? utmisleepm_i :
                            (refsleepm_cnt_low  == 1'b1) ? 1'b0 :
                            (refsleepm_i_r2     == 1'b1) ? 1'b1 :
                                                           utmisleepm_i;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else


  `CDNSUSBHS_ALWAYS(bistclk,bistrst)
    begin : REFSLEEPM_REGS_PROC
    if `CDNSUSBHS_RESET(bistrst)
      begin
      refsleepm_i_r  <= 1'b1;
      refsleepm_i_r2 <= 1'b1;
      end
    else
      begin
      refsleepm_i_r  <= refsleepm_i;
      refsleepm_i_r2 <= refsleepm_i_r;
      end
    end



  `CDNSUSBHS_ALWAYS(bistclk,bistrst)
    begin : SLEEPM_REFCLOCK_PROC
    if `CDNSUSBHS_RESET(bistrst)
      begin
      refsleepm_cnt <= 6'b00_0000;
      end
    else
      begin
      if (sleepm_refclk == 1'b0)
        begin
        refsleepm_cnt <= 6'b00_0000;
        end
      else
        begin
        if (refsleepm_i_r == 1'b1 && refsleepm_i == 1'b0)
          begin
          refsleepm_cnt <= 6'b11_0011;
          end
        else
          begin
          if (|refsleepm_cnt == 1'b1)
            begin
            refsleepm_cnt <= refsleepm_cnt - 1'b1;
            end
          end
        end
      end
    end



  assign refsleepm_cnt_low = (|refsleepm_cnt == 1'b1) ? 1'b1 :
                                                        1'b0 ;
  `endif

  `ifdef CDNSUSB2PHY_3RD


  `ifdef CDNSUSBHS_PHY_UTMI
  assign utmisuspendm_o   = (suspendm_low == 1'b1) ? 1'b0 :
                            (hs_bist_mode == 1'b1) ? 1'b1 :
                                                     utmisuspendm_i;
  `else
  assign utmisuspendm_o   = (suspendm_low == 1'b1) ? 1'b0 :
                                                     utmisuspendm_i;
  `endif



  `ifdef CDNSUSBHS_PHY_UTMI
  assign utmisleepm_o     = (suspendm_low == 1'b1) ? 1'b1 :
                            (hs_bist_mode == 1'b1) ? 1'b1 :
                                                     utmisleepm_i;
  `else
  assign utmisleepm_o     = (suspendm_low == 1'b1) ? 1'b1 :
                                                     utmisleepm_i;
  `endif



  `ifdef CDNSUSBHS_PHY_UTMI
  assign utmidppulldown_o = (hs_bist_mode == 1'b1) ? 1'b0 :
                                                     utmidppulldown_i;
  `else
  assign utmidppulldown_o =                          utmidppulldown_i;
  `endif



  `ifdef CDNSUSBHS_PHY_UTMI
  assign utmidmpulldown_o = (hs_bist_mode == 1'b1) ? 1'b0 :
                                                     utmidmpulldown_i;
  `else
  assign utmidmpulldown_o =                          utmidmpulldown_i;
  `endif
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else


  assign apb_presetn = tsfr_rstb;



  `CDNSUSBHS_ALWAYS(bistclk,bistrst)
    begin : TSFR_ADDR_REQ_PROC
    if `CDNSUSBHS_RESET(bistrst)
      begin
      tsfr_addr_req_r1 <= 1'b0;
      tsfr_addr_req_r2 <= 1'b0;
      tsfr_addr_req_r3 <= 1'b0;
      end
    else
      begin
      tsfr_addr_req_r1 <= tsfr_addr_req;
      tsfr_addr_req_r2 <= tsfr_addr_req_r1;
      if (apb_pready == 1'b1)
        begin
        tsfr_addr_req_r3 <= tsfr_addr_req_r2;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(bistclk,bistrst)
    begin : TIF_ADDR_PROC
    if `CDNSUSBHS_RESET(bistrst)
      begin
      apb_paddr   <= {8{1'b0}};
      apb_penable <= 1'b0;
      apb_pselx   <= 1'b0;
      end
    else
      begin
      if (tsfr_addr_req_r1  != tsfr_addr_req ||
          tsfr_wdata_req_r1 != tsfr_wdata_req)
        begin
        apb_paddr   <= tsfr_addr;
        end

      if (tsfr_addr_req_r2  != tsfr_addr_req_r1 ||
          tsfr_wdata_req_r2 != tsfr_wdata_req_r1)
        begin
        apb_penable <= 1'b1;
        end
      else if (apb_pready == 1'b1)
        begin
        apb_penable <= 1'b0;
        end

      if (tsfr_addr_req_r1  != tsfr_addr_req ||
          tsfr_wdata_req_r1 != tsfr_wdata_req)
        begin
        apb_pselx   <= 1'b1;
        end
      else if (apb_pready == 1'b1)
        begin
        apb_pselx   <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(bistclk,bistrst)
    begin : TSFR_WDATA_REQ_PROC
    if `CDNSUSBHS_RESET(bistrst)
      begin
      tsfr_wdata_req_r1 <= 1'b0;
      tsfr_wdata_req_r2 <= 1'b0;
      tsfr_wdata_req_r3 <= 1'b0;
      end
    else
      begin
      tsfr_wdata_req_r1 <= tsfr_wdata_req;
      tsfr_wdata_req_r2 <= tsfr_wdata_req_r1;
      if (apb_pready == 1'b1)
        begin
        tsfr_wdata_req_r3 <= tsfr_wdata_req_r2;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(bistclk,bistrst)
    begin : TIF_WDATA_PROC
    if `CDNSUSBHS_RESET(bistrst)
      begin
      apb_pwrite <=    1'b0;
      apb_pwdata <= {8{1'b0}};
      end
    else
      begin
      if (tsfr_wdata_req_r1 != tsfr_wdata_req)
        begin
        apb_pwdata <= tsfr_wdata;
        end
      if (tsfr_wdata_req_r2 != tsfr_wdata_req)
        begin
        apb_pwrite <= 1'b1;
        end
      else if (apb_pready == 1'b1)
        begin
        apb_pwrite <= 1'b0;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(bistclk,bistrst)
    begin : TSFR_RDATA_PROC
    if `CDNSUSBHS_RESET(bistrst)
      begin
      tsfr_rdata_req <=    1'b0;
      tsfr_rdata     <= {8{1'b0}};

      end
    else
      begin
      if (tsfr_addr_req_r3 != tsfr_addr_req_r2)
        begin
        if (apb_pready == 1'b1)
          begin
          tsfr_rdata_req <= ~tsfr_rdata_req;
          tsfr_rdata     <= apb_prdata;

          end
        end
      else if (tsfr_wdata_req_r3 != tsfr_wdata_req_r2)
        begin
        if (apb_pready == 1'b1)
          begin
          tsfr_rdata_req <= ~tsfr_rdata_req;
          tsfr_rdata     <=  {8{1'b0}};

          end
        end
      end
    end



  assign apb_pclk = bistclk;
  `endif

endmodule

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
//   Filename:           cdnsusbhs_reset_ctrl.v
//   Module Name:        cdnsusbhs_reset_ctrl
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
//   Reset controller
//   K.W.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_reset_ctrl
  (
  scan_mode,

  swrst,
  warst,

  uprst_o,
  upclk,

  utmiclk,
  utmirst_o,

  wakeup5kclk,
  wakeup5krst_o,

`ifdef CDNSUSB2PHY_3RD
`else
  tsfr_rstb,
  tsfr_rstb_o,
`endif

`ifdef CDNSUSB2PHY_3RD
  phy_coreclkin,
  phy_corerst,

  phy_utmi_reset,
  phy_utmi_reset_o,
  phy_ponrst,
  phy_ponrst_o,
`else
  phy_refclock,
  phy_refreset,

  phy_reset,
  phy_reset_o,
  phy_databus_reset,
  phy_databus_reset_o,
`endif

  uprst_i
  );

  input                            scan_mode;

  input                            swrst;
  input                            warst;

  output                           uprst_o;
  wire                             uprst_o;
  input                            upclk;

  input                            utmiclk;
  output                           utmirst_o;
  wire                             utmirst_o;

  input                            wakeup5kclk;
  output                           wakeup5krst_o;
  wire                             wakeup5krst_o;

`ifdef CDNSUSB2PHY_3RD
`else
  input                            tsfr_rstb;
  output                           tsfr_rstb_o;
  wire                             tsfr_rstb_o;
`endif

`ifdef CDNSUSB2PHY_3RD
  input                            phy_coreclkin;
  output                           phy_corerst;
  wire                             phy_corerst;

  input                            phy_utmi_reset;
  output                           phy_utmi_reset_o;
  wire                             phy_utmi_reset_o;
  input                            phy_ponrst;
  output                           phy_ponrst_o;
  wire                             phy_ponrst_o;
`else
  input                            phy_refclock;
  output                           phy_refreset;
  wire                             phy_refreset;

  input                            phy_reset;
  output                           phy_reset_o;
  wire                             phy_reset_o;
  input                            phy_databus_reset;
  output                           phy_databus_reset_o;
  wire                             phy_databus_reset_o;
`endif

  input                            uprst_i;

  wire                             swrst_i;

  wire                             reset;



  parameter UTMIRST_LENGHT = 32'd2;

  reg    [UTMIRST_LENGHT-1:0]      utmirst_ff;





  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  `ifdef CDNSUSBHS_HIGH_RST
  always @(posedge utmiclk or posedge reset)
  `else
  always @(posedge utmiclk or negedge reset)
  `endif
  `else
  `ifdef CDNSUSBHS_HIGH_RST
  always @(negedge utmiclk or posedge reset)
  `else
  always @(negedge utmiclk or negedge reset)
  `endif
  `endif
    begin : UTMIRST_FF_PROC
  `ifdef CDNSUSBHS_HIGH_RST
    if (reset == 1'b1)
  `else
    if (reset == 1'b0)
  `endif
      begin
      utmirst_ff <= {UTMIRST_LENGHT{`CDNSUSBHS_LEVEL}} ;
      end
    else
      begin
      utmirst_ff <= {utmirst_ff[UTMIRST_LENGHT-2:0], ~`CDNSUSBHS_LEVEL} ;
      end
    end



  assign utmirst_o = (scan_mode == 1'b1) ? reset :
                                           utmirst_ff[UTMIRST_LENGHT-1] ;


  parameter WAKEUP5KRST_LENGHT = 32'd2;

  reg    [WAKEUP5KRST_LENGHT-1:0]  wakeup5krst_ff;





  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  `ifdef CDNSUSBHS_HIGH_RST
  always @(posedge wakeup5kclk or posedge reset)
  `else
  always @(posedge wakeup5kclk or negedge reset)
  `endif
  `else
  `ifdef CDNSUSBHS_HIGH_RST
  always @(negedge wakeup5kclk or posedge reset)
  `else
  always @(negedge wakeup5kclk or negedge reset)
  `endif
  `endif
    begin : WAKEUP5KRST_FF_PROC
  `ifdef CDNSUSBHS_HIGH_RST
    if (reset == 1'b1)
  `else
    if (reset == 1'b0)
  `endif
      begin
      wakeup5krst_ff <= {WAKEUP5KRST_LENGHT{`CDNSUSBHS_LEVEL}} ;
      end
    else
      begin
      wakeup5krst_ff <= {wakeup5krst_ff[WAKEUP5KRST_LENGHT-2:0], ~`CDNSUSBHS_LEVEL} ;
      end
    end



  assign wakeup5krst_o = (scan_mode == 1'b1) ? reset :
                                               wakeup5krst_ff[WAKEUP5KRST_LENGHT-1];



  parameter UPRST_LENGHT = 32'd2;

  reg    [UPRST_LENGHT-1:0]        uprst_ff;





  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  `ifdef CDNSUSBHS_HIGH_RST
  always @(posedge upclk or posedge reset)
  `else
  always @(posedge upclk or negedge reset)
  `endif
  `else
  `ifdef CDNSUSBHS_HIGH_RST
  always @(negedge upclk or posedge reset)
  `else
  always @(negedge upclk or negedge reset)
  `endif
  `endif
    begin : UPRST_FF_SYNC_PROC
  `ifdef CDNSUSBHS_HIGH_RST
    if (reset == 1'b1)
  `else
    if (reset == 1'b0)
  `endif
      begin
      uprst_ff <= {UPRST_LENGHT{`CDNSUSBHS_LEVEL}} ;
      end
    else
      begin
      uprst_ff <= {uprst_ff[UPRST_LENGHT-2:0], ~`CDNSUSBHS_LEVEL} ;
      end
    end



  assign uprst_o = (scan_mode == 1'b1) ? reset :
                                         uprst_ff[UPRST_LENGHT-1] ;

`ifdef CDNSUSB2PHY_3RD


  parameter PHY_CORERST_LENGHT = 32'd2;

  reg    [PHY_CORERST_LENGHT-1:0]     phy_corerst_ff;



  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  `ifdef CDNSUSBHS_HIGH_RST
  always @(posedge phy_coreclkin or posedge reset)
  `else
  always @(posedge phy_coreclkin or negedge reset)
  `endif
  `else
  `ifdef CDNSUSBHS_HIGH_RST
  always @(negedge phy_coreclkin or posedge reset)
  `else
  always @(negedge phy_coreclkin or negedge reset)
  `endif
  `endif
    begin : PHY_CORERST_FF_PROC
  `ifdef CDNSUSBHS_HIGH_RST
    if (reset == 1'b1)
  `else
    if (reset == 1'b0)
  `endif
      begin
      phy_corerst_ff <= {PHY_CORERST_LENGHT{`CDNSUSBHS_LEVEL}} ;
      end
    else
      begin
      phy_corerst_ff <= {phy_corerst_ff[PHY_CORERST_LENGHT-2:0], ~`CDNSUSBHS_LEVEL} ;
      end
    end



  assign phy_corerst = (scan_mode == 1'b1) ? reset :
                                             phy_corerst_ff[PHY_CORERST_LENGHT-1];

`else


  parameter PHY_REFRESET_LENGHT = 32'd2;

  reg    [PHY_REFRESET_LENGHT-1:0]    phy_refreset_ff;



  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  `ifdef CDNSUSBHS_HIGH_RST
  always @(posedge phy_refclock or posedge reset)
  `else
  always @(posedge phy_refclock or negedge reset)
  `endif
  `else
  `ifdef CDNSUSBHS_HIGH_RST
  always @(negedge phy_refclock or posedge reset)
  `else
  always @(negedge phy_refclock or negedge reset)
  `endif
  `endif
    begin : PHY_REFRESET_FF_PROC
  `ifdef CDNSUSBHS_HIGH_RST
    if (reset == 1'b1)
  `else
    if (reset == 1'b0)
  `endif
      begin
      phy_refreset_ff <= {PHY_REFRESET_LENGHT{`CDNSUSBHS_LEVEL}} ;
      end
    else
      begin
      phy_refreset_ff <= {phy_refreset_ff[PHY_REFRESET_LENGHT-2:0], ~`CDNSUSBHS_LEVEL} ;
      end
    end



  assign phy_refreset = (scan_mode == 1'b1) ? reset :
                                              phy_refreset_ff[PHY_REFRESET_LENGHT-1];
`endif

`ifdef CDNSUSB2PHY_3RD


  parameter PHY_UTMI_RESET_LENGHT = 32'd2;

  reg    [PHY_UTMI_RESET_LENGHT-1:0] phy_reset_ff;



  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  `ifdef CDNSUSBHS_HIGH_RST
  always @(posedge phy_coreclkin or posedge reset)
  `else
  always @(posedge phy_coreclkin or negedge reset)
  `endif
  `else
  `ifdef CDNSUSBHS_HIGH_RST
  always @(negedge phy_coreclkin or posedge reset)
  `else
  always @(negedge phy_coreclkin or negedge reset)
  `endif
  `endif
    begin : PHY_RESET_FF_PROC
  `ifdef CDNSUSBHS_HIGH_RST
    if (reset == 1'b1)
  `else
    if (reset == 1'b0)
  `endif
      begin
      phy_reset_ff <= {PHY_UTMI_RESET_LENGHT{1'b1}} ;
      end
    else
      begin
      if (phy_utmi_reset == 1'b1)
        begin
        phy_reset_ff <= {PHY_UTMI_RESET_LENGHT{1'b1}} ;
        end
      else
        begin
        phy_reset_ff <= {phy_reset_ff[PHY_UTMI_RESET_LENGHT-2:0], 1'b0} ;
        end
      end
    end



  `ifdef CDNSUSBHS_HIGH_RST
  assign phy_utmi_reset_o = (scan_mode == 1'b1) ? reset :
                                                 (phy_reset_ff[PHY_UTMI_RESET_LENGHT-1] | warst);
  `else
  assign phy_utmi_reset_o = (scan_mode == 1'b1) ? ~reset :
                                                 (phy_reset_ff[PHY_UTMI_RESET_LENGHT-1] | warst);
  `endif

`else


  parameter PHY_RESET_LENGHT = 32'd2;

  reg    [PHY_RESET_LENGHT-1:0]    phy_reset_ff;



  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  `ifdef CDNSUSBHS_HIGH_RST
  always @(posedge phy_refclock or posedge reset)
  `else
  always @(posedge phy_refclock or negedge reset)
  `endif
  `else
  `ifdef CDNSUSBHS_HIGH_RST
  always @(negedge phy_refclock or posedge reset)
  `else
  always @(negedge phy_refclock or negedge reset)
  `endif
  `endif
    begin : PHY_RESET_FF_PROC
  `ifdef CDNSUSBHS_HIGH_RST
    if (reset == 1'b1)
  `else
    if (reset == 1'b0)
  `endif
      begin
      phy_reset_ff <= {PHY_RESET_LENGHT{1'b1}} ;
      end
    else
      begin
      if (phy_reset == 1'b1)
        begin
        phy_reset_ff <= {PHY_RESET_LENGHT{1'b1}} ;
        end
      else
        begin
        phy_reset_ff <= {phy_reset_ff[PHY_RESET_LENGHT-2:0], 1'b0} ;
        end
      end
    end



  `ifdef CDNSUSBHS_HIGH_RST
  assign phy_reset_o = (scan_mode == 1'b1) ? reset :
                                            (phy_reset_ff[PHY_RESET_LENGHT-1] | warst);
  `else
  assign phy_reset_o = (scan_mode == 1'b1) ? ~reset :
                                            (phy_reset_ff[PHY_RESET_LENGHT-1] | warst);
  `endif
`endif

`ifdef CDNSUSB2PHY_3RD


  parameter PHY_PONRST_LENGHT = 32'd2;

  reg    [PHY_PONRST_LENGHT-1:0] phy_ponrst_ff;



  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  `ifdef CDNSUSBHS_HIGH_RST
  always @(posedge phy_coreclkin or posedge reset)
  `else
  always @(posedge phy_coreclkin or negedge reset)
  `endif
  `else
  `ifdef CDNSUSBHS_HIGH_RST
  always @(negedge phy_coreclkin or posedge reset)
  `else
  always @(negedge phy_coreclkin or negedge reset)
  `endif
  `endif
    begin : PHY_PONRST_FF_PROC
  `ifdef CDNSUSBHS_HIGH_RST
    if (reset == 1'b1)
  `else
    if (reset == 1'b0)
  `endif
      begin
      phy_ponrst_ff <= {PHY_PONRST_LENGHT{1'b0}} ;
      end
    else
      begin
      if (phy_ponrst == 1'b1)
        begin
        phy_ponrst_ff <= {PHY_PONRST_LENGHT{1'b0}} ;
        end
      else
        begin
        phy_ponrst_ff <= {phy_ponrst_ff[PHY_PONRST_LENGHT-2:0], 1'b1} ;
        end
      end
    end



  `ifdef CDNSUSBHS_HIGH_RST
  assign phy_ponrst_o = (scan_mode == 1'b1) ? ~reset :
                                              phy_ponrst_ff[PHY_PONRST_LENGHT-1];
  `else
  assign phy_ponrst_o = (scan_mode == 1'b1) ? reset :
                                              phy_ponrst_ff[PHY_PONRST_LENGHT-1];
  `endif
`else


  parameter PHY_DATABUS_RESET_LENGHT = 32'd2;

  reg    [PHY_DATABUS_RESET_LENGHT-1:0] phy_databus_reset_ff;



  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  `ifdef CDNSUSBHS_HIGH_RST
  always @(posedge phy_refclock or posedge reset)
  `else
  always @(posedge phy_refclock or negedge reset)
  `endif
  `else
  `ifdef CDNSUSBHS_HIGH_RST
  always @(negedge phy_refclock or posedge reset)
  `else
  always @(negedge phy_refclock or negedge reset)
  `endif
  `endif
    begin : PHY_DATABUS_RESET_FF_PROC
  `ifdef CDNSUSBHS_HIGH_RST
    if (reset == 1'b1)
  `else
    if (reset == 1'b0)
  `endif
      begin
      phy_databus_reset_ff <= {PHY_DATABUS_RESET_LENGHT{1'b1}} ;
      end
    else
      begin
      if (phy_databus_reset == 1'b1)
        begin
        phy_databus_reset_ff <= {PHY_DATABUS_RESET_LENGHT{1'b1}} ;
        end
      else
        begin
        phy_databus_reset_ff <= {phy_databus_reset_ff[PHY_DATABUS_RESET_LENGHT-2:0], 1'b0} ;
        end
      end
    end



  `ifdef CDNSUSBHS_HIGH_RST
  assign phy_databus_reset_o = (scan_mode == 1'b1) ? reset :
                                                     phy_databus_reset_ff[PHY_DATABUS_RESET_LENGHT-1];
  `else
  assign phy_databus_reset_o = (scan_mode == 1'b1) ? ~reset :
                                                     phy_databus_reset_ff[PHY_DATABUS_RESET_LENGHT-1];
  `endif
`endif

`ifdef CDNSUSB2PHY_3RD
`else


  parameter TSFR_RESET_LENGHT = 32'd2;

  reg    [TSFR_RESET_LENGHT-1:0]   tsfr_rstb_ff;



  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  `ifdef CDNSUSBHS_HIGH_RST
  always @(posedge phy_refclock or posedge reset)
  `else
  always @(posedge phy_refclock or negedge reset)
  `endif
  `else
  `ifdef CDNSUSBHS_HIGH_RST
  always @(negedge phy_refclock or posedge reset)
  `else
  always @(negedge phy_refclock or negedge reset)
  `endif
  `endif
    begin : TSFR_RESET_FF_PROC
  `ifdef CDNSUSBHS_HIGH_RST
    if (reset == 1'b1)
  `else
    if (reset == 1'b0)
  `endif
      begin
      tsfr_rstb_ff <= {PHY_RESET_LENGHT{1'b0}} ;
      end
    else
      begin
      if (tsfr_rstb == 1'b1)
        begin
        tsfr_rstb_ff <= {PHY_RESET_LENGHT{1'b0}} ;
        end
      else
        begin
        tsfr_rstb_ff <= {tsfr_rstb_ff[PHY_RESET_LENGHT-2:0], 1'b1} ;
        end
      end
    end



  `ifdef CDNSUSBHS_HIGH_RST
  assign tsfr_rstb_o = (scan_mode == 1'b1) ? ~reset :
                                             tsfr_rstb_ff[PHY_RESET_LENGHT-1];
  `else
  assign tsfr_rstb_o = (scan_mode == 1'b1) ? reset :
                                             tsfr_rstb_ff[PHY_RESET_LENGHT-1];
  `endif
`endif



  parameter SWRST_LENGHT = 32'd2;

  reg    [SWRST_LENGHT-1:0]           swrst_ff;



  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  `ifdef CDNSUSBHS_HIGH_RST
  always @(posedge upclk or posedge uprst_i)
  `else
  always @(posedge upclk or negedge uprst_i)
  `endif
  `else
  `ifdef CDNSUSBHS_HIGH_RST
  always @(negedge upclk or posedge uprst_i)
  `else
  always @(negedge upclk or negedge uprst_i)
  `endif
  `endif
    begin : SOFTWARE_RESET_FF_SYNC_PROC
  `ifdef CDNSUSBHS_HIGH_RST
    if (uprst_i == 1'b1)
  `else
    if (uprst_i == 1'b0)
  `endif
      begin
      swrst_ff <= {SWRST_LENGHT{`CDNSUSBHS_LEVEL}} ;
      end
    else
      begin
      if (swrst == 1'b1)
        begin
        swrst_ff <= {SWRST_LENGHT{`CDNSUSBHS_LEVEL}} ;
        end
      else
        begin
        swrst_ff <= {swrst_ff[SWRST_LENGHT-2:0], ~`CDNSUSBHS_LEVEL};
        end
      end
    end



  assign swrst_i = swrst_ff[SWRST_LENGHT-1];



  `ifdef CDNSUSBHS_HIGH_RST
  assign reset = (scan_mode == 1'b1) ? uprst_i :
                                      (uprst_i | swrst_i);
  `else
  assign reset = (scan_mode == 1'b1) ? uprst_i :
                                      (uprst_i & swrst_i);
  `endif

endmodule


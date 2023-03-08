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
//   Filename:           cdnsusbhs_usb2_phy_wrapper.v
//   Module Name:        cdnsusbhs_usb2_phy_wrapper
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
//   USBHS Top level with UTMI PHY - sample unit
//   K.D.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_usb2_phy_wrapper (

  adp_en,
  adp_probe_en,
  adp_sense_en,
  adp_sink_current_en,
  adp_source_current_en,

  bc_en,
  dm_vdat_ref_comp_en,
  dm_vlgc_comp_en,
  dp_vdat_ref_comp_en,
  idm_sink_en,
  idp_sink_en,
  idp_src_en,
  vdm_src_en,
  vdp_src_en,
  rid_float_comp_en,
  rid_nonfloat_comp_en,

  adp_probe_ana,
  adp_sense_ana,
  dcd_comp_sts,
  dm_vdat_ref_comp_sts,
  dm_vlgc_comp_sts,
  dp_vdat_ref_comp_sts,
  rid_a_comp_sts,
  rid_b_comp_sts,
  rid_c_comp_sts,
  rid_float_comp_sts,
  rid_gnd_comp_sts,

  `ifdef CDNSUSB2PHY_3RD
  `else
  RTRIM,
  `endif

  DM,
  DP,
  `ifdef CDNSUSB2PHY_3RD


  `else
  ID,
  VBUS,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  hs_bist_mode,
  bist_ok,

  vcontrol,
  utmi_vcontrolloadm,
  `else
  biston,
  bistmodesel,
  bistmodeen,
  bistcomplete,
  bisterror,
  bisterrorcount,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  test_rst,
  test_se,
  test_clk,
  test_mode,
  external_test_mode,
  test_si1,
  test_si2,
  test_si3,
  test_si4,
  test_so1,
  test_so2,
  test_so3,
  test_so4,
  `else
  scan_clock,
  scan_en,
  scan_en_cg,
  scan_mode,
  scan_in,
  scan_out,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  scan_hsclock,
  scan_hssiclock,
  scan_sieclock,
  scan_ats_mode,
  scan_ats_hsclock,
  scan_ats_hssiclock,
  scan_ats_sieclock,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  ls_en,
  pll_en,
  oscouten,
  outclksel,
  xtlsel,
  clk48m,
  clk60sys,
  pllck120,
  pllck480,
  oscout,
  refclk,

  debug_sel,
  debug_out,

  xcfgi,
  xcfg_coarse_tune_num,
  xcfg_fine_tune_num,
  xcfg_lock_range_max,
  xcfg_lock_range_min,
  xcfgo,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
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
  `endif

  `ifdef CDNSUSB2PHY_3RD

  `else
  sessvld,
  `endif

  hostdisconnect,
  `ifdef CDNSUSB2PHY_3RD


  `else
  idpullup,
  iddig,
  `endif
  dmpulldown,
  dppulldown,
  `ifdef CDNSUSB2PHY_3RD

  `else
  vbusvalid,
  `endif

  databus16_8,

  `ifdef CDNSUSB2PHY_3RD
  `else
  vbus_sel,
  `endif
  `ifdef CDNSUSB2PHY_3RD
  coreclkin,
  utmi_clk,
  `else
  refclock,
  sieclock,
  `endif
  `ifdef CDNSUSB2PHY_3RD
  utmi_reset,
  ponrst,
  `else
  reset,
  databus_reset,
  `endif
  `ifdef CDNSUSB2PHY_3RD
  `else
  pllrefsel,
  lane_reverse,
  powerdown,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  pso_disable,
  pso_disable_sel,

  pll_clkon,
  pll_standalone,
  pll_clk_sel,
  pll_clockout,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  usb2_phy_arch,
  usb2_phy_spare_out,

  pll_bypass_mode,

  option_n,
  option_cv,

  iddq_mode,
  `endif

  sleepm,
  suspendm,
  linestate,
  rxactive,
  rxerror,
  rxvalid,
  rxvalidh,
  dataout,
  txready,
  txvalid,
  txvalidh,
  datain,
  opmode,
  termselect,
  xcvrselect
);

  input                    adp_en;
  input                    adp_probe_en;
  input                    adp_sense_en;
  input                    adp_sink_current_en;
  input                    adp_source_current_en;

  input                    bc_en;
  input                    dm_vdat_ref_comp_en;
  input                    dm_vlgc_comp_en;
  input                    dp_vdat_ref_comp_en;
  input                    idm_sink_en;
  input                    idp_sink_en;
  input                    idp_src_en;
  input                    vdm_src_en;
  input                    vdp_src_en;
  input                    rid_float_comp_en;
  input                    rid_nonfloat_comp_en;

  output                   adp_probe_ana;
  output                   adp_sense_ana;
  output                   dcd_comp_sts;
  output                   dm_vdat_ref_comp_sts;
  output                   dm_vlgc_comp_sts;
  output                   dp_vdat_ref_comp_sts;
  output                   rid_a_comp_sts;
  output                   rid_b_comp_sts;
  output                   rid_c_comp_sts;
  output                   rid_float_comp_sts;
  output                   rid_gnd_comp_sts;

  `ifdef CDNSUSB2PHY_3RD
  `else
  inout                    RTRIM;
  `endif

  inout                    DM;
  inout                    DP;
  `ifdef CDNSUSB2PHY_3RD


  `else
  inout                    ID;
  inout                    VBUS;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  input                    hs_bist_mode;
  output                   bist_ok;

  input  [3:0]             vcontrol;
  input                    utmi_vcontrolloadm;
  `else
  input                    biston;
  input  [3:0]             bistmodesel;
  input                    bistmodeen;
  output                   bistcomplete;
  output                   bisterror;
  output [7:0]             bisterrorcount;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  input                    test_rst;
  input                    test_se;
  input                    test_clk;
  input                    test_mode;
  input                    external_test_mode;
  input                    test_si1;
  input                    test_si2;
  input                    test_si3;
  input                    test_si4;
  output                   test_so1;
  output                   test_so2;
  output                   test_so3;
  output                   test_so4;
  `else
  input                    scan_clock;
  input                    scan_en;
  input                    scan_en_cg;
  input                    scan_mode;
  input  [34:0]            scan_in;
  output [34:0]            scan_out;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  input                    scan_hsclock;
  input                    scan_hssiclock;
  input                    scan_sieclock;
  input                    scan_ats_mode;
  output                   scan_ats_hsclock;
  output                   scan_ats_hssiclock;
  output                   scan_ats_sieclock;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  input                    ls_en;
  input                    pll_en;
  input                    oscouten;
  input                    outclksel;
  input  [1:0]             xtlsel;
  output                   clk48m;
  output                   clk60sys;
  output                   pllck120;
  output                   pllck480;
  output                   oscout;
  output                   refclk;

  input  [3:0]             debug_sel;
  output [15:0]            debug_out;

  input  [69:0]            xcfgi;
  input  [2:0]             xcfg_coarse_tune_num;
  input  [2:0]             xcfg_fine_tune_num;
  input  [2:0]             xcfg_lock_range_max;
  input  [2:0]             xcfg_lock_range_min;

  output [7:0]             xcfgo;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  input                    apb_pclk;
  input                    apb_presetn;
  input                    apb_pwrite;
  input                    apb_penable;
  input                    apb_pselx;
  input  [7:0]             apb_paddr;
  input  [7:0]             apb_pwdata;

  output [7:0]             apb_prdata;
  output                   apb_pready;
  output                   apb_pslverr;
  `endif

  `ifdef CDNSUSB2PHY_3RD

  `else
  output                   sessvld;
  `endif

  output                   hostdisconnect;
  `ifdef CDNSUSB2PHY_3RD


  `else
  input                    idpullup;
  output                   iddig;
  `endif
  input                    dmpulldown;
  input                    dppulldown;
  `ifdef CDNSUSB2PHY_3RD

  `else
  output                   vbusvalid;
  `endif

  input                    databus16_8;

  `ifdef CDNSUSB2PHY_3RD
  `else
  input  [1:0]             vbus_sel;
  `endif
  `ifdef CDNSUSB2PHY_3RD
  input                    coreclkin;
  output                   utmi_clk;
  `else
  input                    refclock;
  output                   sieclock;
  `endif
  `ifdef CDNSUSB2PHY_3RD
  input                    utmi_reset;
  input                    ponrst;
  `else
  input                    reset;
  input                    databus_reset;
  `endif
  `ifdef CDNSUSB2PHY_3RD
  `else
  input  [3:0]             pllrefsel;
  input                    lane_reverse;
  input  [1:0]             powerdown;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  input                    pso_disable;
  input  [1:0]             pso_disable_sel;

  input                    pll_clkon;
  input                    pll_standalone;
  input  [1:0]             pll_clk_sel;
  output                   pll_clockout;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  input  [1:0]             usb2_phy_arch;
  output [7:0]             usb2_phy_spare_out;

  input                    pll_bypass_mode;

  input                    option_n;
  input                    option_cv;

  input                    iddq_mode;
  `endif

  input                    sleepm;
  input                    suspendm;
  output [1:0]             linestate;
  output                   rxactive;
  output                   rxerror;
  output                   rxvalid;
  output                   rxvalidh;
  output [15:0]            dataout;
  output                   txready;
  input                    txvalid;
  input                    txvalidh;
  input  [15:0]            datain;
  input  [1:0]             opmode;
  input                    termselect;
  input  [1:0]             xcvrselect;

  `ifdef CDNSUSB2PHY_3RD
  `ifdef CDNSUSBHS_SIMULATE
  wire                     VCC33A;
  wire                     VCC18A;
  wire                     GND18A;
  wire                     VCC09D;
  wire                     GND09D;
  `endif
  `else
  `ifdef CDNSUSBHS_SIMULATE
  `ifdef CDNS_PHY_PWR_AWARE
  wire                     AVDD_CORE;
  wire                     AVDD_IO_HV;
  wire                     AVDD_IO;
  wire                     GND;

  wire                     DVDD_CORE;
  `endif
  `endif
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `ifdef CDNSUSBHS_SIMULATE
  assign VCC33A          = 1'b1;
  assign VCC18A          = 1'b1;
  assign GND18A          = 1'b0;
  assign VCC09D          = 1'b1;
  assign GND09D          = 1'b0;
  `endif
  `else
  `ifdef CDNSUSBHS_SIMULATE
  `ifdef CDNS_PHY_PWR_AWARE
  assign AVDD_CORE       = 1'b1;
  assign AVDD_IO_HV      = 1'b1;
  assign AVDD_IO         = 1'b1;
  assign GND             = 1'b0;

  assign DVDD_CORE       = 1'b1;
  `endif
  `endif
  `endif

  `ifdef CDNSUSB2PHY_3RD
  wire                     lpm_alive;
  `endif

  `ifdef CDNSUSB2PHY_3RD


  assign lpm_alive = ~sleepm;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  //---------------------------------------------------------------
  //---------------------------------------------------------------
  //assign adp_probe_ana        = 1'b0;
  //assign adp_sense_ana        = 1'b0;
  assign dcd_comp_sts         = 1'b0;
  assign dm_vdat_ref_comp_sts = 1'b0;
  assign dm_vlgc_comp_sts     = 1'b0;
  assign dp_vdat_ref_comp_sts = 1'b0;
  assign rid_a_comp_sts       = 1'b0;
  assign rid_b_comp_sts       = 1'b0;
  assign rid_c_comp_sts       = 1'b0;
  assign rid_float_comp_sts   = 1'b0;
  assign rid_gnd_comp_sts     = 1'b0;
  `else
  //---------------------------------------------------------------
  //---------------------------------------------------------------
  //assign adp_probe_ana        = 1'b0;
  //assign adp_sense_ana        = 1'b0;
  `endif



  `ifdef CDNSUSB2PHY_3RD
  `CDNSUSB2PHY_3RD_MODEL
  U_CDNSUSB2PHY_3RD_MODEL
  `else
  cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r
  U_CDN_SD1000_T16FFC_01_VC176_2XA1XD3XE2Y2R
  `endif
    (
    `ifdef CDNSUSB2PHY_3RD
    `else
    .bc_en                              (bc_en),
    .dm_vdat_ref_comp_en                (dm_vdat_ref_comp_en),
    .dm_vlgc_comp_en                    (dm_vlgc_comp_en),
    .dp_vdat_ref_comp_en                (dp_vdat_ref_comp_en),
    .idm_sink_en                        (idm_sink_en),
    .idp_sink_en                        (idp_sink_en),
    .idp_src_en                         (idp_src_en),
    .vdm_src_en                         (vdm_src_en),
    .vdp_src_en                         (vdp_src_en),
    .rid_float_comp_en                  (rid_float_comp_en),
    .rid_nonfloat_comp_en               (rid_nonfloat_comp_en),

    .dcd_comp_sts                       (dcd_comp_sts),
    .dm_vdat_ref_comp_sts               (dm_vdat_ref_comp_sts),
    .dm_vlgc_comp_sts                   (dm_vlgc_comp_sts),
    .dp_vdat_ref_comp_sts               (dp_vdat_ref_comp_sts),
    .rid_a_comp_sts                     (rid_a_comp_sts),
    .rid_b_comp_sts                     (rid_b_comp_sts),
    .rid_c_comp_sts                     (rid_c_comp_sts),
    .rid_float_comp_sts                 (rid_float_comp_sts),
    .rid_gnd_comp_sts                   (rid_gnd_comp_sts),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `ifdef CDNSUSBHS_SIMULATE
    .VCC33A                             (VCC33A),
    .VCC18A                             (VCC18A),
    .GND18A                             (GND18A),
    .VCC09D                             (VCC09D),
    .GND09D                             (GND09D),
    `endif
    `else
    `ifdef CDNSUSBHS_SIMULATE
    //`ifdef CDNS_PHY_PWR_AWARE
    //.AVDD_CORE                          (AVDD_CORE),
    //.AVDD_IO_HV                         (AVDD_IO_HV),
    //.AVDD_IO                            (AVDD_IO),
    //.gnd                                (GND),
    //`endif
    `endif
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .RTRIM                              (RTRIM),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    `ifdef CDNSUSBHS_SIMULATE
    //`ifdef CDNS_PHY_PWR_AWARE
    //.DVDD_CORE                          (DVDD_CORE),
    //`endif
    `endif
    `endif

    .DM                                 (DM),
    .DP                                 (DP),
    `ifdef CDNSUSB2PHY_3RD
    `else
    .ID                                 (ID),
    .VBUS                               (VBUS),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .HS_BIST_MODE                       (hs_bist_mode),
    .BIST_OK                            (bist_ok),

    .VCONTROL                           (vcontrol),
    .UTMI_VCONTROLLOADM                 (utmi_vcontrolloadm),
    `else
    .bist_on                            (biston),
    .bist_mode_sel                      (bistmodesel),
    .bist_mode_en                       (bistmodeen),
    .bist_complete                      (bistcomplete),
    .bist_error                         (bisterror),
    .bist_error_count                   (bisterrorcount),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .TEST_RST                           (test_rst),
    .TEST_SE                            (test_se),
    .TEST_CLK                           (test_clk),
    .TEST_MODE                          (test_mode),
    .EXTERNAL_TEST_MODE                 (external_test_mode),
    .TEST_SI1                           (test_si1),
    .TEST_SI2                           (test_si2),
    .TEST_SI3                           (test_si3),
    .TEST_SI4                           (test_si4),
    .TEST_SO1                           (test_so1),
    .TEST_SO2                           (test_so2),
    .TEST_SO3                           (test_so3),
    .TEST_SO4                           (test_so4),
    `else
    .scan_clock                         (scan_clock),
    .scan_en                            (scan_en),
    .scan_en_cg                         (scan_en_cg),
    .scan_mode                          (scan_mode),
    .scan_in                            (scan_in),
    .scan_out                           (scan_out),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .scan_hsclock                       (scan_hsclock),
    .scan_hssiclock                     (scan_hssiclock),
    .scan_sieclock                      (scan_sieclock),
    .scan_ats_mode                      (scan_ats_mode),
    .scan_ats_hsclock                   (scan_ats_hsclock),
    .scan_ats_hssiclock                 (scan_ats_hssiclock),
    .scan_ats_sieclock                  (scan_ats_sieclock),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .LS_EN                              (ls_en),
    .PLL_EN                             (pll_en),
    .OSCOUTEN                           (oscouten),
    .OUTCLKSEL                          (outclksel),
    .XTLSEL                             (xtlsel),
    .CLK48M                             (clk48m),
    .CLK60SYS                           (clk60sys),
    .PLLCK120                           (pllck120),
    .PLLCK480                           (pllck480),
    .OSCOUT                             (oscout),
    .REFCLK                             (refclk),

    .debug_sel                          (debug_sel),
    .debug_out                          (debug_out),

    .XCFGI                              (xcfgi),
    .XCfg_COARSE_TUNE_NUM               (xcfg_coarse_tune_num),
    .XCfg_FINE_TUNE_NUM                 (xcfg_fine_tune_num),
    .XCfg_LOCK_RANGE_MAX                (xcfg_lock_range_max),
    .XCfg_LOCK_RANGE_MIN                (xcfg_lock_range_min),

    .XCFGO                              (xcfgo),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .CC_EN                              (1'b0),
    .CC_HOST_EN                         (1'b0),
    .CC_RP_3D0_EN                       (1'b0),
    .CC_RP_1D5_EN                       (1'b0),
    .CC_RP_0D9_EN                       (1'b0),
    .CC_HOST_EN_A                       (),
    .CC_EN_A                            (),
    .CC_OPT_HYS_A                       (),
    .CC_REF_OPT2_A                      (),
    .CC_REF_OPT1_A                      (),
    .CC_REF_OPT0_A                      (),
    .CC_RP_0D9_EN_A                     (),
    .CC_RP_1D5_EN_A                     (),
    .CC_RP_3D0_EN_A                     (),
    .CRYIN                              (),
    .XTL0                               (),
    .XTL_ENB                            (),
    .ICC_10U_1                          (),
    .ICC_10U_0                          (),
    .ICC_90U_1                          (),
    .ICC_90U_0                          (),
    .IDPAD_EN                           (1'b0),
    .IDPAD_EN_A                         (),

    .DATA_OE                            (),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .apb_pclk                           (apb_pclk),
    .apb_presetn                        (apb_presetn),
    .apb_pwrite                         (apb_pwrite),
    .apb_penable                        (apb_penable),
    .apb_pselx                          (apb_pselx),
    .apb_paddr                          (apb_paddr),
    .apb_pwdata                         (apb_pwdata),

    .apb_prdata                         (apb_prdata),
    .apb_pready                         (apb_pready),
    .apb_pslverr                        (apb_pslverr),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .sessvld                            (sessvld),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .HOSTDISCONNECT                     (hostdisconnect),
    .DMPULLDOWN                         (dmpulldown),
    .DPPULLDOWN                         (dppulldown),
    `else
    .hostdisconnect                     (hostdisconnect),
    .idpullup                           (idpullup),
    .iddig                              (iddig),
    .dmpulldown                         (dmpulldown),
    .dppulldown                         (dppulldown),
    .vbusvalid                          (vbusvalid),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .UTMI_DATABUS16_8                   (databus16_8),
    `else
    .databus16_8                        (databus16_8),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .vbus_sel                           (vbus_sel),
    `endif
    `ifdef CDNSUSB2PHY_3RD
    .CORECLKIN                          (coreclkin),
    .UTMI_CLK                           (utmi_clk),
    `else
    .refclock                           (refclock),
    .sieclock                           (sieclock),
    `endif
    `ifdef CDNSUSB2PHY_3RD
    .UTMI_RESET                         (utmi_reset),
    .PONRST                             (ponrst),
    `else
    .reset                              (reset),
    .databus_reset                      (databus_reset),
    `endif
    `ifdef CDNSUSB2PHY_3RD
    `else
    .pllrefsel                          (pllrefsel),
    .lane_reverse                       (lane_reverse),
    .powerdown                          (powerdown),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .pso_disable                        (pso_disable),
    .pso_disable_sel                    (pso_disable_sel),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .LPM_ALIVE                          (lpm_alive),
    `else
    .sleepm                             (sleepm),
    `endif
    `ifdef CDNSUSB2PHY_3RD
    .UTMI_SUSPENDM                      (suspendm),
    `else
    .suspendm                           (suspendm),
    `endif
    `ifdef CDNSUSB2PHY_3RD
    .UTMI_LINESTATE                     (linestate),
    `else
    .linestate                          (linestate),
    `endif
    `ifdef CDNSUSB2PHY_3RD
    .UTMI_RXACTIVE                      (rxactive),
    .UTMI_RXERROR                       (rxerror),
    .UTMI_RXVALID                       (rxvalid),
    .UTMI_RXVALIDH                      (rxvalidh),
    .UTMI_DATA_OUT                      (dataout),
    `else
    .rxactive                           (rxactive),
    .rxerror                            (rxerror),
    .rxvalid                            (rxvalid),
    .rxvalidh                           (rxvalidh),
    .dataout                            (dataout),
    `endif
    `ifdef CDNSUSB2PHY_3RD
    .UTMI_TXREADY                       (txready),
    .UTMI_TXVALID                       (txvalid),
    .UTMI_TXVALIDH                      (txvalidh),
    .UTMI_DATA_IN                       (datain),
    `else
    .txready                            (txready),
    .txvalid                            (txvalid),
    .txvalidh                           (txvalidh),
    .datain                             (datain),
    `endif
    `ifdef CDNSUSB2PHY_3RD
    .UTMI_OPMODE                        (opmode),
    .UTMI_TERMSELECT                    (termselect),
    .UTMI_XCVRSELECT                    (xcvrselect),
    `else
    .opmode                             (opmode),
    .termselect                         (termselect),
    .xcvrselect                         (xcvrselect),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .usb2_phy_arch                      (usb2_phy_arch), 
    .usb2_phy_spare_out                 (usb2_phy_spare_out),

    .pll_clkon                          (pll_clkon),
    .pll_standalone                     (pll_standalone),
    .pll_clockout                       (pll_clockout),
    .pll_clk_sel                        (pll_clk_sel),
    .pll_bypass_mode                    (pll_bypass_mode),

    .option_n                           (option_n),
    .option_cv                          (option_cv),

    .iddq_mode                          (iddq_mode),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .hssi_mode                          (1'b0),
    .hssi_datain                        (2'b00),
    .hssi_txvalid                       (2'b00),
    .hssi_tx_enable                     (1'b0),
    .hssi_tx_clockin                    (1'b0),
    .hssi_ted_en                        (1'b0),

    .hssi_dataout                       (),
    .hssi_rxvalid                       (),
    .hssi_squelch                       (),
    .hssi_rxerror                       (),
    .hssi_ded_ana                       (),
    .hssi_chirp_data                    (),
    .hssi_tx_clockout                   (),
    .hssi_rx_clockout                   (),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .tap_tck                            (1'b0),
    .tap_trst_n                         (1'b0),
    .tap_tdi                            (1'b0),
    .tap_tms                            (1'b0),
    .tap_tdo                            (),
    .tap_tdoen                          (),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .psm_clock                          (1'b0),
    .psm_rstn                           (1'b0),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .FSLSSERIALMODE                     (1'b0),
    .TX_DAT                             (1'b0),
    .TX_ENABLE_N                        (1'b1),
    .TX_SE0                             (1'b0),
    .RX_DM                              (),
    .RX_DP                              (),
    .RX_RCV                             (),
    `else
    .idle_rpu_enable                    (1'b0),
    .fslsserialmode                     (1'b0),
    .tx_dat                             (1'b0),
    .tx_enable_n                        (1'b1),
    .tx_se0                             (1'b0),
    .rx_dm                              (),
    .rx_dp                              (),
    .rx_rcv                             (),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .loopback                           (2'b00),
    `endif
    `ifdef CDNSUSB2PHY_3RD
    .TXBITSTUFFENABLE                   (1'b0),
    .TXBITSTUFFENABLEH                  (1'b0)
    `else
    .txbitstuffenable                   (1'b0),
    .txbitstuffenableh                  (1'b0),
    `endif
    `ifdef CDNSUSB2PHY_3RD
    `else
     .adp_probe_en                      (adp_probe_en),
     .adp_en                            (adp_en),
     .adp_sense_en                      (adp_sense_en),
     .adp_sink_current_en               (adp_sink_current_en),
     .adp_source_current_en             (adp_source_current_en),
     .adp_probe_ana                     (adp_probe_ana),
     .adp_sense_ana                     (adp_sense_ana),
     .usb2_phy_spare_in                 (8'd0),
     .usb2_phy_irq                      ()
     `endif                
  );

endmodule

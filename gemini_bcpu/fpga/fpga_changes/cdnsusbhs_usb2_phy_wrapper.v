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

  assign /*output                   */adp_probe_ana='d0;
  assign /*output                   */adp_sense_ana='d0;
  assign /*output                   */dcd_comp_sts='d0;
  assign /*output                   */dm_vdat_ref_comp_sts='d0;
  assign /*output                   */dm_vlgc_comp_sts='d0;
  assign /*output                   */dp_vdat_ref_comp_sts='d0;
  assign /*output                   */rid_a_comp_sts='d0;
  assign /*output                   */rid_b_comp_sts='d0;
  assign /*output                   */rid_c_comp_sts='d0;
  assign /*output                   */rid_float_comp_sts='d0;
  assign /*output                   */rid_gnd_comp_sts='d0;
  assign /*output                   */bist_ok='d0;
  assign /*output                   */bistcomplete='d0;
  assign /*output                   */bisterror='d0;
  assign /*output [7:0]             */bisterrorcount='d0;
  assign /*output                   */test_so1='d0;
  assign /*output                   */test_so2='d0;
  assign /*output                   */test_so3='d0;
  assign /*output                   */test_so4='d0;
  assign /*output [34:0]            */scan_out='d0;
  assign /*output                   */scan_ats_hsclock='d0;
  assign /*output                   */scan_ats_hssiclock='d0;
  assign /*output                   */scan_ats_sieclock='d0;
  assign /*output                   */clk48m='d0;
  assign /*output                   */clk60sys='d0;
  assign /*output                   */pllck120='d0;
  assign /*output                   */pllck480='d0;
  assign /*output                   */oscout='d0;
  assign /*output                   */refclk='d0;
  assign /*output [15:0]            */debug_out='d0;
  assign /*output [7:0]             */xcfgo='d0;
  assign /*output [7:0]             */apb_prdata='d0;
  assign /*output                   */apb_pready='d0;
  assign /*output                   */apb_pslverr='d0;
  assign /*output                   */sessvld='d0;
  assign /*output                   */hostdisconnect='d0;
  assign /*output                   */iddig='d0;
  assign /*output                   */vbusvalid='d0;
  assign /*output                   */utmi_clk='d0;
  assign /*output                   */sieclock='d0;
  assign /*output                   */pll_clockout='d0;
  assign /*output [7:0]             */usb2_phy_spare_out='d0;
  assign /*output [1:0]             */linestate='d0;
  assign /*output                   */rxactive='d0;
  assign /*output                   */rxerror='d0;
  assign /*output                   */rxvalid='d0;
  assign /*output                   */rxvalidh='d0;
  assign /*output [15:0]            */dataout='d0;
  assign /*output                   */txready='d0;



endmodule

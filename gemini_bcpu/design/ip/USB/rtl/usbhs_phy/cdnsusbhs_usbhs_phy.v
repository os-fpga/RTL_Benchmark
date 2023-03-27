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
//   Filename:           cdnsusbhs_usbhs_phy.v
//   Module Name:        cdnsusbhs_usbhs_phy
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
//   USBHS PHY Top level architecture
//   D.K.
//------------------------------------------------------------------------------


`ifdef CDNSUSBHS_SIMULATE
`timescale 1 ns / 1 ps
`endif


`include "cdnsusbhs_cusb2_defines.v"
`include "cdnsusbhs_adma_defines.v"



`ifdef CDNSUSBHS_SIMULATE
`ifdef CDNSUSBHS_WUDET_DELAY
`else
`define CDNSUSBHS_WUDET_DELAY 16
`endif
`ifdef CDNSUSBHS_CPU_DELAY
`else
`define CDNSUSBHS_CPU_DELAY   16
`endif
`ifdef CDNSUSBHS_UTMI_DELAY
`else
`define CDNSUSBHS_UTMI_DELAY   4
`endif
`ifdef CDNSUSBHS_PHY_DELAY
`else
`define CDNSUSBHS_PHY_DELAY    4
`endif
`endif



module cdnsusbhs_usbhs_phy
  (
  areset,

  wakeup,

  scan_en,
  scan_mode,

  `ifdef CDNSUSB2PHY_3RD
  coreclkin,
  `else
  refclock,
  `endif

  wakeup5kclk,

  vbusfault,

  `ifdef CDNSUSBHS_PHY_UTMI
  utmiclk,
  utmidrvvbus,

  utmi_suspendm_i,
  utmi_suspendm,
  utmi_sleepm,

  `ifdef CDNSUSB2PHY_3RD
  utmisessvld,

  utmiiddig,
  utmivbusvalid,
  `endif


  `ifdef CDNSUSB2PHY_3RD
  phy_coreclkin,
  phy_utmi_clk,
  `else
  phy_refclock,
  phy_sieclock,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  phy_RTRIM,
  `endif

  usb_DM,
  usb_DP,
  `ifdef CDNSUSB2PHY_3RD


  `else
  usb_ID,
  usb_VBUS,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  phy_hs_bist_ponrst,
  phy_hs_bist_mode,
  phy_bist_ok,

  phy_vcontrol,
  phy_utmi_vcontrolloadm,
  phy_utmi_linestate,
  `else
  phy_biston,
  phy_bistmodesel,
  phy_bistmodeen,
  phy_bistcomplete,
  phy_bisterror,
  phy_bisterrorcount,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  phy_test_rst,
  phy_test_se,
  phy_test_clk,
  phy_test_mode,
  phy_external_test_mode,
  phy_test_si1,
  phy_test_si2,
  phy_test_si3,
  phy_test_si4,
  phy_test_so1,
  phy_test_so2,
  phy_test_so3,
  phy_test_so4,
  `else
  phy_scan_clock,
  phy_scan_en,
  phy_scan_en_cg,
  phy_scan_mode,
  phy_scan_in,
  phy_scan_out,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  phy_pll_clockout,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  phy_lane_reverse,
  phy_vbus_sel,
  phy_pllrefsel,

  phy_pso_disable,
  phy_pso_disable_sel,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  phy_usb2_phy_arch,
  phy_usb2_phy_spare_out,

  phy_pll_bypass_mode,

  phy_option_n,
  phy_option_cv,

  phy_iddq_mode,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  phy_scan_hsclock,
  phy_scan_hssiclock,
  phy_scan_sieclock,
  phy_scan_ats_mode,
  phy_scan_ats_hsclock,
  phy_scan_ats_hssiclock,
  phy_scan_ats_sieclock,
  `endif

  `ifdef CDNSUSB2PHY_3RD
  phy_ls_en,
  phy_pll_en,
  phy_oscouten,
  phy_outclksel,
  phy_xtlsel,
  phy_clk48m,
  phy_clk60sys,
  phy_pllck120,
  phy_pllck480,
  phy_oscout,
  phy_refclk,

  phy_debug_sel,
  phy_debug_out,

  phy_xcfgi,
  phy_xcfg_coarse_tune_num,
  phy_xcfg_fine_tune_num,
  phy_xcfg_lock_range_max,
  phy_xcfg_lock_range_min,
  phy_xcfgo,
  `endif
  `endif
  `ifdef CDNSUSBHS_PHY_UTMI
  `else

  utmiclk,
  utmitxready,
  utmirxactive,
  utmirxerror,
  utmirxvalid,
  utmidataout,
  utmilinestate,
  utmivbusvalid,
  utmiavalid,
  utmibvalid,
  utmisessend,
  utmiiddig,
  utmihostdiscon,


  utmitxvalid,
  utmidatain,
  utmisuspendm,
  utmisleepm,
  utmiopmode,
  utmitermselect,
  utmixcvrselect,
  utmiidpullup,
  utmidppulldown,
  utmidmpulldown,
  utmidrvvbus,
  utmichrgvbus,
  utmidischrgvbus,

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
  `endif

  aclk,


  sawid,
  sawaddr,
  sawsize,
  sawlen,
  sawburst,
  sawlock,
  sawcache,
  sawprot,
  sawvalid,
  sawready,


  `ifdef CDNSUSBHS_UP_AXI_4
  `else
  swid,
  `endif
  swdata,
  swstrb,
  swvalid,
  swlast,
  swready,


  sbid,
  sbready,
  sbresp,
  sbvalid,


  sarid,
  saraddr,
  sarsize,
  sarlen,
  sarburst,
  sarlock,
  sarcache,
  sarprot,
  sarvalid,
  sarready,


  srid,
  srready,
  srdata,
  srresp,
  srvalid,
  srlast,

  tsmode,
  tmodecustom,
  tmodeselcustom,


  mawid,
  mawaddr,
  mawsize,
  mawlen,
  mawburst,
  mawlock,
  mawcache,
  mawprot,
  mawvalid,
  mawready,


  mwid,
  mwdata,
  mwstrb,
  mwvalid,
  mwready,
  mwlast,


  mbid,
  mbready,
  mbresp,
  mbvalid,


  marid,
  maraddr,
  marsize,
  marlen,
  marburst,
  marlock,
  marcache,
  marprot,
  marvalid,
  marready,


  mrid,
  mrready,
  mrdata,
  mrresp,
  mrvalid,
  mrlast,

  wuintreq,
  usbintreq,
  usbivect,

  otgstate,
  downstrstate,
  upstrstate,

  `ifdef CDNSUSBHS_PHY_UTMI
  `else
  `ifdef CDNSUSB2PHY_3RD
  phy_suspendm_low,
  phy_utmi_reset,
  phy_ponrst,
  `else
  phy_suspendm_low,
  phy_sleepm_ref,
  phy_reset,
  phy_databus_reset,
  phy_powerdown,

  phy_pll_clkon,
  phy_pll_standalone,
  phy_pll_clk_sel,
  `endif
  `endif

`ifdef CDNSUSB2PHY_3RD
`else
  `ifdef CDNSUSBHS_PHY_UTMI
  `else
  phy_apb_pclk,
  phy_apb_presetn,
  phy_apb_pwrite,
  phy_apb_penable,
  phy_apb_pselx,
  phy_apb_paddr,
  phy_apb_pwdata,

  phy_apb_prdata,
  phy_apb_pready,
  phy_apb_pslverr,
  `endif
`endif

  dmabclk,
  dmabdatard,
  dmabdatawr,
  dmabwr,
  dmabaddr,
  dmabrd,


  out_rama_clk,
  out_rama_addr,
  out_rama_wr,
  out_rama_data,


  out_ramb_clk,
  out_ramb_addr,
  out_ramb_rd,
  out_ramb_data,


  in_rama_clk,
  in_rama_addr,
  in_rama_wr,
  in_rama_data,


  in_ramb_clk,
  in_ramb_addr,
  in_ramb_rd,
  in_ramb_data
  );

  input                                       areset;

  input                                       wakeup;

  input                                       scan_en;
  input                                       scan_mode;

  `ifdef CDNSUSB2PHY_3RD
  input                                       coreclkin;
  `else
  input                                       refclock;
  `endif

  input                                       wakeup5kclk;

  input                                       vbusfault;

  `ifdef CDNSUSBHS_PHY_UTMI
  input                                       utmiclk;
  output                                      utmidrvvbus;
  wire                                        utmidrvvbus;

  input                                       utmi_suspendm_i;
  output                                      utmi_suspendm;
  wire                                        utmi_suspendm;
  output                                      utmi_sleepm;
  wire                                        utmi_sleepm;

  `ifdef CDNSUSB2PHY_3RD
  input                                       utmisessvld;

  input                                       utmiiddig;
  input                                       utmivbusvalid;
  `endif


  `ifdef CDNSUSB2PHY_3RD
  input                                       phy_coreclkin;
  output                                      phy_utmi_clk;
  wire                                        phy_utmi_clk;
  `else
  input                                       phy_refclock;
  output                                      phy_sieclock;
  wire                                        phy_sieclock;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  inout                                       phy_RTRIM;
  `endif

  inout                                       usb_DM;
  inout                                       usb_DP;
  `ifdef CDNSUSB2PHY_3RD


  `else
  inout                                       usb_ID;
  inout                                       usb_VBUS;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  input                                       phy_hs_bist_ponrst;
  input                                       phy_hs_bist_mode;
  output                                      phy_bist_ok;

  input  [3:0]                                phy_vcontrol;
  input                                       phy_utmi_vcontrolloadm;
  output [1:0]                                phy_utmi_linestate;
  wire   [1:0]                                phy_utmi_linestate;
  `else
  input                                       phy_biston;
  input  [3:0]                                phy_bistmodesel;
  input                                       phy_bistmodeen;
  output                                      phy_bistcomplete;
  wire                                        phy_bistcomplete;
  output                                      phy_bisterror;
  wire                                        phy_bisterror;
  output [7:0]                                phy_bisterrorcount;
  wire   [7:0]                                phy_bisterrorcount;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  input                                       phy_test_rst;
  input                                       phy_test_se;
  input                                       phy_test_clk;
  input                                       phy_test_mode;
  input                                       phy_external_test_mode;
  input                                       phy_test_si1;
  input                                       phy_test_si2;
  input                                       phy_test_si3;
  input                                       phy_test_si4;
  output                                      phy_test_so1;
  wire                                        phy_test_so1;
  output                                      phy_test_so2;
  wire                                        phy_test_so2;
  output                                      phy_test_so3;
  wire                                        phy_test_so3;
  output                                      phy_test_so4;
  wire                                        phy_test_so4;
  `else
  input                                       phy_scan_clock;
  input                                       phy_scan_en;
  input                                       phy_scan_en_cg;
  input                                       phy_scan_mode;
  input  [34:0]                               phy_scan_in;
  output [34:0]                               phy_scan_out;
  wire   [34:0]                               phy_scan_out;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  output                                      phy_pll_clockout;
  wire                                        phy_pll_clockout;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  input                                       phy_lane_reverse;
  input  [1:0]                                phy_vbus_sel;
  input  [3:0]                                phy_pllrefsel;

  input                                       phy_pso_disable;
  input  [1:0]                                phy_pso_disable_sel;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  input  [1:0]                                phy_usb2_phy_arch;
  output [7:0]                                phy_usb2_phy_spare_out;
  wire   [7:0]                                phy_usb2_phy_spare_out;

  input                                       phy_pll_bypass_mode;

  input                                       phy_option_n;
  input                                       phy_option_cv;

  input                                       phy_iddq_mode;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  input                                       phy_scan_hsclock;
  input                                       phy_scan_hssiclock;
  input                                       phy_scan_sieclock;
  input                                       phy_scan_ats_mode;
  output                                      phy_scan_ats_hsclock;
  wire                                        phy_scan_ats_hsclock;
  output                                      phy_scan_ats_hssiclock;
  wire                                        phy_scan_ats_hssiclock;
  output                                      phy_scan_ats_sieclock;
  wire                                        phy_scan_ats_sieclock;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  input                                       phy_ls_en;
  input                                       phy_pll_en;
  input                                       phy_oscouten;
  input                                       phy_outclksel;
  input  [1:0]                                phy_xtlsel;
  output                                      phy_clk48m;
  wire                                        phy_clk48m;
  output                                      phy_clk60sys;
  wire                                        phy_clk60sys;
  output                                      phy_pllck120;
  wire                                        phy_pllck120;
  output                                      phy_pllck480;
  wire                                        phy_pllck480;
  output                                      phy_oscout;
  wire                                        phy_oscout;
  output                                      phy_refclk;
  wire                                        phy_refclk;

  input  [3:0]                                phy_debug_sel;
  output [15:0]                               phy_debug_out;
  wire   [15:0]                               phy_debug_out;

  input  [69:0]                               phy_xcfgi;
  input  [2:0]                                phy_xcfg_coarse_tune_num;
  input  [2:0]                                phy_xcfg_fine_tune_num;
  input  [2:0]                                phy_xcfg_lock_range_max;
  input  [2:0]                                phy_xcfg_lock_range_min;
  output [7:0]                                phy_xcfgo;
  wire   [7:0]                                phy_xcfgo;
  `endif
  `endif
  `ifdef CDNSUSBHS_PHY_UTMI
  `else

  input                                       utmiclk;
  input                                       utmitxready;
  input                                       utmirxactive;
  input                                       utmirxerror;
  input  [`CDNSUSBHS_USBDATAWIDTH/8-1:0]      utmirxvalid;
  input  [`CDNSUSBHS_USBDATAWIDTH-1:0]        utmidataout;
  input  [1:0]                                utmilinestate;
  input                                       utmivbusvalid;
  input                                       utmiavalid;
  input                                       utmibvalid;
  input                                       utmisessend;
  input                                       utmiiddig;
  input                                       utmihostdiscon;


  output [`CDNSUSBHS_USBDATAWIDTH/8-1:0]      utmitxvalid;
  wire   [`CDNSUSBHS_USBDATAWIDTH/8-1:0]      utmitxvalid;
  output [`CDNSUSBHS_USBDATAWIDTH-1:0]        utmidatain;
  wire   [`CDNSUSBHS_USBDATAWIDTH-1:0]        utmidatain;
  output                                      utmisuspendm;
  wire                                        utmisuspendm;
  output                                      utmisleepm;
  wire                                        utmisleepm;
  output [1:0]                                utmiopmode;
  wire   [1:0]                                utmiopmode;
  output                                      utmitermselect;
  wire                                        utmitermselect;
  output [1:0]                                utmixcvrselect;
  wire   [1:0]                                utmixcvrselect;
  output                                      utmiidpullup;
  wire                                        utmiidpullup;
  output                                      utmidppulldown;
  wire                                        utmidppulldown;
  output                                      utmidmpulldown;
  wire                                        utmidmpulldown;
  output                                      utmidrvvbus;
  wire                                        utmidrvvbus;
  output                                      utmichrgvbus;
  wire                                        utmichrgvbus;
  output                                      utmidischrgvbus;
  wire                                        utmidischrgvbus;

  output                                      adp_en;
  wire                                        adp_en;
  output                                      adp_probe_en;
  wire                                        adp_probe_en;
  output                                      adp_sense_en;
  wire                                        adp_sense_en;
  output                                      adp_sink_current_en;
  wire                                        adp_sink_current_en;
  output                                      adp_source_current_en;
  wire                                        adp_source_current_en;

  output                                      bc_en;
  wire                                        bc_en;
  output                                      dm_vdat_ref_comp_en;
  wire                                        dm_vdat_ref_comp_en;
  output                                      dm_vlgc_comp_en;
  wire                                        dm_vlgc_comp_en;
  output                                      dp_vdat_ref_comp_en;
  wire                                        dp_vdat_ref_comp_en;
  output                                      idm_sink_en;
  wire                                        idm_sink_en;
  output                                      idp_sink_en;
  wire                                        idp_sink_en;
  output                                      idp_src_en;
  wire                                        idp_src_en;
  output                                      vdm_src_en;
  wire                                        vdm_src_en;
  output                                      vdp_src_en;
  wire                                        vdp_src_en;
  output                                      rid_float_comp_en;
  wire                                        rid_float_comp_en;
  output                                      rid_nonfloat_comp_en;
  wire                                        rid_nonfloat_comp_en;

  input                                       adp_probe_ana;
  input                                       adp_sense_ana;
  input                                       dcd_comp_sts;
  input                                       dm_vdat_ref_comp_sts;
  input                                       dm_vlgc_comp_sts;
  input                                       dp_vdat_ref_comp_sts;
  input                                       rid_a_comp_sts;
  input                                       rid_b_comp_sts;
  input                                       rid_c_comp_sts;
  input                                       rid_float_comp_sts;
  input                                       rid_gnd_comp_sts;
  `endif

  input                                       aclk;


  input  [`CDNSUSBHS_SAXI_ID_WIDTH-1:0]       sawid;
  input  [`CDNSUSBHS_UPADDRWIDTH-1:0]         sawaddr;
  input  [2:0]                                sawsize;
  input  [`CDNSUSBHS_S_LEN_WIDTH-1:0]         sawlen;
  input  [1:0]                                sawburst;
  input  [1:0]                                sawlock;
  input  [`CDNSUSBHS_S_CACHE_WIDTH-1:0]       sawcache;
  input  [2:0]                                sawprot;
  input                                       sawvalid;
  output                                      sawready;
  wire                                        sawready;


  `ifdef CDNSUSBHS_UP_AXI_4
  `else
  input  [`CDNSUSBHS_SAXI_ID_WIDTH-1:0]       swid;
  `endif
  input  [31:0]                               swdata;
  input  [3:0]                                swstrb;
  input                                       swvalid;
  input                                       swlast;
  output                                      swready;
  wire                                        swready;


  output [`CDNSUSBHS_SAXI_ID_WIDTH-1:0]       sbid;
  wire   [`CDNSUSBHS_SAXI_ID_WIDTH-1:0]       sbid;
  input                                       sbready;
  output [1:0]                                sbresp;
  wire   [1:0]                                sbresp;
  output                                      sbvalid;
  wire                                        sbvalid;


  input  [`CDNSUSBHS_SAXI_ID_WIDTH-1:0]       sarid;
  input  [`CDNSUSBHS_UPADDRWIDTH-1:0]         saraddr;
  input  [2:0]                                sarsize;
  input  [`CDNSUSBHS_S_LEN_WIDTH-1:0]         sarlen;
  input  [1:0]                                sarburst;
  input  [1:0]                                sarlock;
  input  [`CDNSUSBHS_S_CACHE_WIDTH-1:0]       sarcache;
  input  [2:0]                                sarprot;
  input                                       sarvalid;
  output                                      sarready;
  wire                                        sarready;


  output [`CDNSUSBHS_SAXI_ID_WIDTH-1:0]       srid;
  wire   [`CDNSUSBHS_SAXI_ID_WIDTH-1:0]       srid;
  input                                       srready;
  output [31:0]                               srdata;
  wire   [31:0]                               srdata;
  output [1:0]                                srresp;
  wire   [1:0]                                srresp;
  output                                      srvalid;
  wire                                        srvalid;
  output                                      srlast;
  wire                                        srlast;

  input  [1:0]                                tsmode;
  output                                      tmodecustom;
  wire                                        tmodecustom;
  output [7:0]                                tmodeselcustom;
  wire   [7:0]                                tmodeselcustom;


  input                                       mawready;
  output [`CDNSUSBHS_MAXI_ID_WIDTH-1:0]       mawid;
  wire   [`CDNSUSBHS_MAXI_ID_WIDTH-1:0]       mawid;
  output [`CDNSUSBHS_M_ADDR_WIDTH-1:0]        mawaddr;
  wire   [`CDNSUSBHS_M_ADDR_WIDTH-1:0]        mawaddr;
  output [`CDNSUSBHS_M_LEN_WIDTH-1:0]         mawlen;
  wire   [`CDNSUSBHS_M_LEN_WIDTH-1:0]         mawlen;
  output [2:0]                                mawsize;
  wire   [2:0]                                mawsize;
  output [1:0]                                mawburst;
  wire   [1:0]                                mawburst;
  output [1:0]                                mawlock;
  wire   [1:0]                                mawlock;
  output [`CDNSUSBHS_M_CACHE_WIDTH-1:0]       mawcache;
  wire   [`CDNSUSBHS_M_CACHE_WIDTH-1:0]       mawcache;
  output [2:0]                                mawprot;
  wire   [2:0]                                mawprot;
  output                                      mawvalid;
  wire                                        mawvalid;


  input                                       mwready;
  output [`CDNSUSBHS_MAXI_ID_WIDTH-1:0]       mwid;
  wire   [`CDNSUSBHS_MAXI_ID_WIDTH-1:0]       mwid;
  output [`CDNSUSBHS_M_DATA_WIDTH-1:0]        mwdata;
  wire   [`CDNSUSBHS_M_DATA_WIDTH-1:0]        mwdata;
  output [`CDNSUSBHS_M_DATA_WIDTH/8-1:0]      mwstrb;
  wire   [`CDNSUSBHS_M_DATA_WIDTH/8-1:0]      mwstrb;
  output                                      mwlast;
  wire                                        mwlast;
  output                                      mwvalid;
  wire                                        mwvalid;


  input  [`CDNSUSBHS_MAXI_ID_WIDTH-1:0]       mbid;
  input  [1:0]                                mbresp;
  input                                       mbvalid;
  output                                      mbready;
  wire                                        mbready;


  input                                       marready;
  output [`CDNSUSBHS_MAXI_ID_WIDTH-1:0]       marid;
  wire   [`CDNSUSBHS_MAXI_ID_WIDTH-1:0]       marid;
  output [`CDNSUSBHS_M_ADDR_WIDTH-1:0]        maraddr;
  wire   [`CDNSUSBHS_M_ADDR_WIDTH-1:0]        maraddr;
  output [`CDNSUSBHS_M_LEN_WIDTH-1:0]         marlen;
  wire   [`CDNSUSBHS_M_LEN_WIDTH-1:0]         marlen;
  output [2:0]                                marsize;
  wire   [2:0]                                marsize;
  output [1:0]                                marburst;
  wire   [1:0]                                marburst;
  output [1:0]                                marlock;
  wire   [1:0]                                marlock;
  output [`CDNSUSBHS_M_CACHE_WIDTH-1:0]       marcache;
  wire   [`CDNSUSBHS_M_CACHE_WIDTH-1:0]       marcache;
  output [2:0]                                marprot;
  wire   [2:0]                                marprot;
  output                                      marvalid;
  wire                                        marvalid;


  input  [`CDNSUSBHS_MAXI_ID_WIDTH-1:0]       mrid;
  input  [`CDNSUSBHS_M_DATA_WIDTH-1:0]        mrdata;
  input  [1:0]                                mrresp;
  input                                       mrlast;
  input                                       mrvalid;
  output                                      mrready;
  wire                                        mrready;

  output                                      wuintreq;
  wire                                        wuintreq;
  output                                      usbintreq;
  wire                                        usbintreq;
  output [7:0]                                usbivect;
  wire   [7:0]                                usbivect;

  output [4:0]                                otgstate;
  wire   [4:0]                                otgstate;
  output [3:0]                                downstrstate;
  wire   [3:0]                                downstrstate;
  output [4:0]                                upstrstate;
  wire   [4:0]                                upstrstate;

  `ifdef CDNSUSBHS_PHY_UTMI
  `else
  `ifdef CDNSUSB2PHY_3RD

  output                                      phy_suspendm_low;
  wire                                        phy_suspendm_low;
  output                                      phy_utmi_reset;
  wire                                        phy_utmi_reset;
  output                                      phy_ponrst;
  wire                                        phy_ponrst;
  `else

  output                                      phy_suspendm_low;
  wire                                        phy_suspendm_low;
  output                                      phy_sleepm_ref;
  wire                                        phy_sleepm_ref;
  output                                      phy_reset;
  wire                                        phy_reset;
  output                                      phy_databus_reset;
  wire                                        phy_databus_reset;
  output [1:0]                                phy_powerdown;
  wire   [1:0]                                phy_powerdown;




  output                                      phy_pll_clkon;
  wire                                        phy_pll_clkon;
  output                                      phy_pll_standalone;
  wire                                        phy_pll_standalone;
  output [1:0]                                phy_pll_clk_sel;
  wire   [1:0]                                phy_pll_clk_sel;
  `endif
  `endif

`ifdef CDNSUSB2PHY_3RD
`else
  `ifdef CDNSUSBHS_PHY_UTMI
  `else
  output                                      phy_apb_pclk;
  wire                                        phy_apb_pclk;
  output                                      phy_apb_presetn;
  wire                                        phy_apb_presetn;
  output                                      phy_apb_pwrite;
  wire                                        phy_apb_pwrite;
  output                                      phy_apb_penable;
  wire                                        phy_apb_penable;
  output                                      phy_apb_pselx;
  wire                                        phy_apb_pselx;
  output [7:0]                                phy_apb_paddr;
  wire   [7:0]                                phy_apb_paddr;
  output [7:0]                                phy_apb_pwdata;
  wire   [7:0]                                phy_apb_pwdata;

  input  [7:0]                                phy_apb_prdata;
  input                                       phy_apb_pready;
  input                                       phy_apb_pslverr;
  `endif
`endif


  output                                      dmabclk;
  wire                                        dmabclk;
  input  [31:0]                               dmabdatard;
  output [31:0]                               dmabdatawr;
  wire   [31:0]                               dmabdatawr;
  output                                      dmabwr;
  wire                                        dmabwr;
  output [`CDNSUSBHS_ADMAMEMORY_WIDTH-1:0]    dmabaddr;
  wire   [`CDNSUSBHS_ADMAMEMORY_WIDTH-1:0]    dmabaddr;
  output                                      dmabrd;
  wire                                        dmabrd;


  output                                      out_rama_clk;
  wire                                        out_rama_clk;
  output [`CDNSUSBHS_OUTADD-1:0]              out_rama_addr;
  wire   [`CDNSUSBHS_OUTADD-1:0]              out_rama_addr;
  output [3:0]                                out_rama_wr;
  wire   [3:0]                                out_rama_wr;
  output [31:0]                               out_rama_data;
  wire   [31:0]                               out_rama_data;


  output                                      out_ramb_clk;
  wire                                        out_ramb_clk;
  output [`CDNSUSBHS_OUTADD-1:0]              out_ramb_addr;
  wire   [`CDNSUSBHS_OUTADD-1:0]              out_ramb_addr;
  output                                      out_ramb_rd;
  wire                                        out_ramb_rd;
  input  [31:0]                               out_ramb_data;


  output                                      in_rama_clk;
  wire                                        in_rama_clk;
  output [`CDNSUSBHS_INADD-1:0]               in_rama_addr;
  wire   [`CDNSUSBHS_INADD-1:0]               in_rama_addr;
  output [3:0]                                in_rama_wr;
  wire   [3:0]                                in_rama_wr;
  output [31:0]                               in_rama_data;
  wire   [31:0]                               in_rama_data;


  output                                      in_ramb_clk;
  wire                                        in_ramb_clk;
  output [`CDNSUSBHS_INADD-1:0]               in_ramb_addr;
  wire   [`CDNSUSBHS_INADD-1:0]               in_ramb_addr;
  output                                      in_ramb_rd;
  wire                                        in_ramb_rd;
  input  [31:0]                               in_ramb_data;

  wire   [31:0]                               out_ramb_data_scan;
  wire   [31:0]                               in_ramb_data_scan;
  wire   [31:0]                               dmabdatard_scan;

  `ifdef CDNSUSBHS_PHY_UTMI
  `ifdef CDNSUSBHS_SIMULATE
  wire                #(`CDNSUSBHS_PHY_DELAY) utmitxready;
  wire                #(`CDNSUSBHS_PHY_DELAY) utmirxactive;
  wire                #(`CDNSUSBHS_PHY_DELAY) utmirxerror;
  wire   [`CDNSUSBHS_USBDATAWIDTH/8-1:0]
                      #(`CDNSUSBHS_PHY_DELAY) utmirxvalid;
  wire   [`CDNSUSBHS_USBDATAWIDTH-1:0]
                      #(`CDNSUSBHS_PHY_DELAY) utmidataouth;
  wire   [`CDNSUSBHS_USBDATAWIDTH-1:0]
                      #(`CDNSUSBHS_PHY_DELAY) utmidataout;
  wire   [1:0]        #(`CDNSUSBHS_PHY_DELAY) utmilinestate;
  `else
  wire                                        utmitxready;
  wire                                        utmirxactive;
  wire                                        utmirxerror;
  wire   [`CDNSUSBHS_USBDATAWIDTH/8-1:0]      utmirxvalid;
  wire   [`CDNSUSBHS_USBDATAWIDTH-1:0]        utmidataouth;
  wire   [`CDNSUSBHS_USBDATAWIDTH-1:0]        utmidataout;
  wire   [1:0]                                utmilinestate;
  `endif
  `ifdef CDNSUSBHS_SIMULATE
  wire                #(`CDNSUSBHS_PHY_DELAY) utmivbusvalid;
  wire                #(`CDNSUSBHS_PHY_DELAY) utmiavalid;
  wire                #(`CDNSUSBHS_PHY_DELAY) utmibvalid;
  `else
  wire                                        utmivbusvalid;
  wire                                        utmiavalid;
  wire                                        utmibvalid;
  `endif
  `ifdef CDNSUSBHS_SIMULATE
  wire                #(`CDNSUSBHS_PHY_DELAY) utmisessend;
  `ifdef CDNSUSB2PHY_3RD

  `else
  wire                #(`CDNSUSBHS_PHY_DELAY) utmiiddig;
  `endif
  wire                #(`CDNSUSBHS_PHY_DELAY) utmihostdiscon;
  `else
  wire                                        utmisessend;
  `ifdef CDNSUSB2PHY_3RD

  `else
  wire                                        utmiiddig;
  `endif
  wire                                        utmihostdiscon;
  `endif
  `ifdef CDNSUSB2PHY_3RD

  `else
  wire                                        utmisessvld;
  `endif


  wire   [`CDNSUSBHS_USBDATAWIDTH/8-1:0]      utmitxvalid;
  wire   [`CDNSUSBHS_USBDATAWIDTH-1:0]        utmidatain;
  wire                                        utmisuspendm;
  wire                                        utmisleepm;
  wire   [1:0]                                utmiopmode;
  wire                                        utmitermselect;
  wire   [1:0]                                utmixcvrselect;
  wire                                        utmiidpullup;
  wire                                        utmidppulldown;
  wire                                        utmidmpulldown;
  wire                                        utmichrgvbus;
  wire                                        utmidischrgvbus;

  wire                                        adp_en;
  wire                                        adp_probe_en;
  wire                                        adp_sense_en;
  wire                                        adp_sink_current_en;
  wire                                        adp_source_current_en;

  wire                                        bc_en;
  wire                                        dm_vdat_ref_comp_en;
  wire                                        dm_vlgc_comp_en;
  wire                                        dp_vdat_ref_comp_en;
  wire                                        idm_sink_en;
  wire                                        idp_sink_en;
  wire                                        idp_src_en;
  wire                                        vdm_src_en;
  wire                                        vdp_src_en;
  wire                                        rid_float_comp_en;
  wire                                        rid_nonfloat_comp_en;

  wire                                        adp_probe_ana;
  wire                                        adp_sense_ana;
  wire                                        dcd_comp_sts;
  wire                                        dm_vdat_ref_comp_sts;
  wire                                        dm_vlgc_comp_sts;
  wire                                        dp_vdat_ref_comp_sts;
  wire                                        rid_a_comp_sts;
  wire                                        rid_b_comp_sts;
  wire                                        rid_c_comp_sts;
  wire                                        rid_float_comp_sts;
  wire                                        rid_gnd_comp_sts;

  `ifdef CDNSUSB2PHY_3RD
  `else
  wire                                        phy_apb_pclk;
  wire                                        phy_apb_presetn;
  wire                                        phy_apb_pwrite;
  wire                                        phy_apb_penable;
  wire                                        phy_apb_pselx;
  wire   [7:0]                                phy_apb_paddr;
  wire   [7:0]                                phy_apb_pwdata;

  wire   [7:0]                                phy_apb_prdata;
  wire                                        phy_apb_pready;
  wire                                        phy_apb_pslverr;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  wire                                        phy_suspendm_low;
  `else
  wire                                        phy_suspendm_low;
  wire                                        phy_sleepm_ref;
  wire   [1:0]                                phy_powerdown;

  wire                                        phy_pll_clkon;
  wire                                        phy_pll_standalone;
  wire   [1:0]                                phy_pll_clk_sel;
  `endif
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  wire                                        phy_sleepm_refclk;
  `endif
  `ifdef CDNSUSB2PHY_3RD
  `else
  wire                                        utmisleepm_bist_refclk;
  `endif
  wire                                        utmisleepm_bist;
  wire                                        utmisuspendm_bist;

  `ifdef CDNSUSB2PHY_3RD
  wire                                        utmidppulldown_bist;
  wire                                        utmidmpulldown_bist;
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else
  wire                                        tsfr_rstb;
  wire                                        tsfr_rstb_ref;
  wire                                        tsfr_rstb_req;
  wire                                        tsfr_addr_req;
  wire                                        tsfr_addr_req_ref;
  wire   [7:0]                                tsfr_addr;
  `ifdef CDNSUSBHS_SIMULATE
  wire                #(`CDNSUSBHS_PHY_DELAY) tsfr_rdata_req;
  wire   [7:0]        #(`CDNSUSBHS_PHY_DELAY) tsfr_rdata;
  `else
  wire                                        tsfr_rdata_req;
  wire   [7:0]                                tsfr_rdata;
  `endif
  wire                                        tsfr_wdata_req;
  wire                                        tsfr_wdata_req_ref;
  wire   [7:0]                                tsfr_wdata;
  `endif




  wire                                        aclk_en;
  wire                                        aclk_gated;

  wire                                        workaround_rst;



  wire                                        software_reset;

  `ifdef CDNSUSBHS_SIMULATE
  wire              #(`CDNSUSBHS_WUDET_DELAY) wakeup5krst;
  `else
  wire                                        wakeup5krst;
  `endif
  `ifdef CDNSUSBHS_SIMULATE
  wire                #(`CDNSUSBHS_CPU_DELAY) arst;
  `else
  wire                                        arst;
  `endif

  `ifdef CDNSUSBHS_SIMULATE
  wire               #(`CDNSUSBHS_UTMI_DELAY) utmirst;
  `else
  wire                                        utmirst;
  `endif

`ifdef CDNSUSB2PHY_3RD



  wire                                        corerst;

`else



  wire                                        refreset;

`endif

  `ifdef CDNSUSB2PHY_3RD
  wire                                        phy_utmi_reset_up;
  wire                                        phy_ponrst_up;
  wire                                        phy_utmi_reset_ref;
  wire                                        phy_ponrst_ref;
  `ifdef CDNSUSBHS_PHY_UTMI
  wire                                        phy_utmi_reset;
  wire                                        phy_ponrst;
  `ifdef CDNSUSBHS_SIMULATE
  wire                #(`CDNSUSBHS_PHY_DELAY) phy_utmi_reset_bist;
  wire                #(`CDNSUSBHS_PHY_DELAY) phy_ponrst_bist;
  `else
  wire                                        phy_utmi_reset_bist;
  wire                                        phy_ponrst_bist;
  `endif
  `endif
  `else
  wire                                        phy_reset_up;
  wire                                        phy_databus_reset_up;
  wire                                        phy_reset_ref;
  wire                                        phy_databus_reset_ref;
  `ifdef CDNSUSBHS_PHY_UTMI
  `ifdef CDNSUSBHS_SIMULATE
  wire                #(`CDNSUSBHS_PHY_DELAY) phy_reset;
  wire                #(`CDNSUSBHS_PHY_DELAY) phy_databus_reset;
  `else
  wire                                        phy_reset;
  wire                                        phy_databus_reset;
  `endif
  `endif
  `endif




  cdnsusbhs_usbhs
  U_CDNSUSBHS_USBHS
    (



    .wakeup                             (wakeup),

    .wakeup5kclk                        (wakeup5kclk),
    .wakeup5krst                        (wakeup5krst),

    .otgstate                           (otgstate),
    .downstrstate                       (downstrstate),
    .upstrstate                         (upstrstate),

    `ifdef CDNSUSB2PHY_3RD
    `else
    .tsfr_rstb                          (tsfr_rstb_req),
    .tsfr_addr_req                      (tsfr_addr_req),
    .tsfr_addr                          (tsfr_addr),
    .tsfr_rdata_req                     (tsfr_rdata_req),
    .tsfr_rdata                         (tsfr_rdata),
    .tsfr_wdata_req                     (tsfr_wdata_req),
    .tsfr_wdata                         (tsfr_wdata),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .phy_suspendm_low                   (phy_suspendm_low),
    .phy_utmi_reset                     (phy_utmi_reset_up),
    .phy_ponrst                         (phy_ponrst_up),
    `else
    .phy_suspendm_low                   (phy_suspendm_low),
    .phy_sleepm_ref                     (phy_sleepm_ref),
    .phy_reset                          (phy_reset_up),
    .phy_databus_reset                  (phy_databus_reset_up),
    .phy_powerdown                      (phy_powerdown),

    .phy_pll_clkon                      (phy_pll_clkon),
    .phy_pll_standalone                 (phy_pll_standalone),
    .phy_pll_clk_sel                    (phy_pll_clk_sel),
    `endif





    .utmiclk                            (utmiclk),
    .utmirst                            (utmirst),
    .utmitxready                        (utmitxready),
    .utmirxactive                       (utmirxactive),
    .utmirxerror                        (utmirxerror),
    .utmirxvalid                        (utmirxvalid),
    .utmidataout                        (utmidataout),
    .utmilinestate                      (utmilinestate),
    .utmivbusvalid                      (utmivbusvalid),
    .utmiavalid                         (utmiavalid),
    .utmibvalid                         (utmibvalid),
    .utmisessend                        (utmisessend),
    .utmiiddig                          (utmiiddig),
    .utmihostdiscon                     (utmihostdiscon),


    .utmitxvalid                        (utmitxvalid),
    .utmidatain                         (utmidatain),
    .utmisuspendm                       (utmisuspendm_bist),
    .utmisleepm                         (utmisleepm_bist),
    .utmiopmode                         (utmiopmode),
    .utmitermselect                     (utmitermselect),
    .utmixcvrselect                     (utmixcvrselect),

    .utmiidpullup                       (utmiidpullup),
    `ifdef CDNSUSB2PHY_3RD
    .utmidppulldown                     (utmidppulldown_bist),
    .utmidmpulldown                     (utmidmpulldown_bist),
    `else
    .utmidppulldown                     (utmidppulldown),
    .utmidmpulldown                     (utmidmpulldown),
    `endif
    .utmidrvvbus                        (utmidrvvbus),
    .utmichrgvbus                       (utmichrgvbus),
    .utmidischrgvbus                    (utmidischrgvbus),

    .adp_en                             (adp_en),
    .adp_probe_en                       (adp_probe_en),
    .adp_sense_en                       (adp_sense_en),
    .adp_sink_current_en                (adp_sink_current_en),
    .adp_source_current_en              (adp_source_current_en),

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

    .adp_probe_ana                      (adp_probe_ana),
    .adp_sense_ana                      (adp_sense_ana),
    .dcd_comp_sts                       (dcd_comp_sts),
    .dm_vdat_ref_comp_sts               (dm_vdat_ref_comp_sts),
    .dm_vlgc_comp_sts                   (dm_vlgc_comp_sts),
    .dp_vdat_ref_comp_sts               (dp_vdat_ref_comp_sts),
    .rid_a_comp_sts                     (rid_a_comp_sts),
    .rid_b_comp_sts                     (rid_b_comp_sts),
    .rid_c_comp_sts                     (rid_c_comp_sts),
    .rid_float_comp_sts                 (rid_float_comp_sts),
    .rid_gnd_comp_sts                   (rid_gnd_comp_sts),

    .workaround_rst                     (workaround_rst),

    .vbusfault                          (vbusfault),

    .software_reset                     (software_reset),

    .tsmode                             (tsmode),
    .tmodecustom                        (tmodecustom),
    .tmodeselcustom                     (tmodeselcustom),





    .arst                               (arst),
    .aclk                               (aclk_gated),
    .aclk_nogated                       (aclk),
    .aclk_en                            (aclk_en),


    .sawid                              (sawid),
    .sawaddr                            (sawaddr),
    .sawsize                            (sawsize),
    .sawlen                             (sawlen),
    .sawburst                           (sawburst),
    .sawlock                            (sawlock),
    .sawcache                           (sawcache),
    .sawprot                            (sawprot),
    .sawvalid                           (sawvalid),
    .sawready                           (sawready),


    `ifdef CDNSUSBHS_UP_AXI_4
    `else
    .swid                               (swid),
    `endif
    .swdata                             (swdata),
    .swstrb                             (swstrb),
    .swvalid                            (swvalid),
    .swlast                             (swlast),
    .swready                            (swready),


    .sbid                               (sbid),
    .sbready                            (sbready),
    .sbresp                             (sbresp),
    .sbvalid                            (sbvalid),


    .sarid                              (sarid),
    .saraddr                            (saraddr),
    .sarsize                            (sarsize),
    .sarlen                             (sarlen),
    .sarburst                           (sarburst),
    .sarlock                            (sarlock),
    .sarcache                           (sarcache),
    .sarprot                            (sarprot),
    .sarvalid                           (sarvalid),
    .sarready                           (sarready),


    .srid                               (srid),
    .srready                            (srready),
    .srdata                             (srdata),
    .srresp                             (srresp),
    .srvalid                            (srvalid),
    .srlast                             (srlast),






    .mawid                              (mawid),
    .mawaddr                            (mawaddr),
    .mawsize                            (mawsize),
    .mawlen                             (mawlen),
    .mawburst                           (mawburst),
    .mawlock                            (mawlock),
    .mawcache                           (mawcache),
    .mawprot                            (mawprot),
    .mawvalid                           (mawvalid),
    .mawready                           (mawready),


    .mwid                               (mwid),
    .mwdata                             (mwdata),
    .mwstrb                             (mwstrb),
    .mwvalid                            (mwvalid),
    .mwready                            (mwready),
    .mwlast                             (mwlast),


    .mbid                               (mbid),
    .mbready                            (mbready),
    .mbresp                             (mbresp),
    .mbvalid                            (mbvalid),


    .marid                              (marid),
    .maraddr                            (maraddr),
    .marsize                            (marsize),
    .marlen                             (marlen),
    .marburst                           (marburst),
    .marlock                            (marlock),
    .marcache                           (marcache),
    .marprot                            (marprot),
    .marvalid                           (marvalid),
    .marready                           (marready),


    .mrid                               (mrid),
    .mrready                            (mrready),
    .mrdata                             (mrdata),
    .mrresp                             (mrresp),
    .mrvalid                            (mrvalid),
    .mrlast                             (mrlast),




    .wuintreq                           (wuintreq),
    .usbintreq                          (usbintreq),
    .usbivect                           (usbivect),



    .dmabdatawr                         (dmabdatawr),
    .dmabwr                             (dmabwr),
    .dmabdatard                         (dmabdatard_scan),
    .dmabaddr                           (dmabaddr),
    .dmabrd                             (dmabrd),




    .out_rama_addr                      (out_rama_addr),
    .out_rama_data                      (out_rama_data),
    .out_rama_wr                        (out_rama_wr),
    .out_ramb_addr                      (out_ramb_addr),
    .out_ramb_rd                        (out_ramb_rd),
    .out_ramb_data                      (out_ramb_data_scan),

    .in_rama_addr                       (in_rama_addr),
    .in_rama_data                       (in_rama_data),
    .in_rama_wr                         (in_rama_wr),
    .in_ramb_addr                       (in_ramb_addr),
    .in_ramb_rd                         (in_ramb_rd),
    .in_ramb_data                       (in_ramb_data_scan)
    );

  `ifdef CDNSUSBHS_PHY_UTMI


  cdnsusbhs_usb2_phy_wrapper
  U_CDNSUSBHS_CORE_UTMI_PHY
    (
    .adp_en                             (adp_en),
    .adp_probe_en                       (adp_probe_en),
    .adp_sense_en                       (adp_sense_en),
    .adp_sink_current_en                (adp_sink_current_en),
    .adp_source_current_en              (adp_source_current_en),

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

    .adp_probe_ana                      (adp_probe_ana),
    .adp_sense_ana                      (adp_sense_ana),
    .dcd_comp_sts                       (dcd_comp_sts),
    .dm_vdat_ref_comp_sts               (dm_vdat_ref_comp_sts),
    .dm_vlgc_comp_sts                   (dm_vlgc_comp_sts),
    .dp_vdat_ref_comp_sts               (dp_vdat_ref_comp_sts),
    .rid_a_comp_sts                     (rid_a_comp_sts),
    .rid_b_comp_sts                     (rid_b_comp_sts),
    .rid_c_comp_sts                     (rid_c_comp_sts),
    .rid_float_comp_sts                 (rid_float_comp_sts),
    .rid_gnd_comp_sts                   (rid_gnd_comp_sts),

    `ifdef CDNSUSB2PHY_3RD
    `else
    .RTRIM                              (phy_RTRIM),
    `endif

    .DM                                 (usb_DM),
    .DP                                 (usb_DP),
    `ifdef CDNSUSB2PHY_3RD


    `else
    .ID                                 (usb_ID),
    .VBUS                               (usb_VBUS),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .biston                             (phy_biston),
    .bistmodesel                        (phy_bistmodesel),
    .bistmodeen                         (phy_bistmodeen),
    .bistcomplete                       (phy_bistcomplete),
    .bisterror                          (phy_bisterror),
    .bisterrorcount                     (phy_bisterrorcount),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .scan_clock                         (phy_scan_clock),
    .scan_en                            (phy_scan_en),
    .scan_en_cg                         (phy_scan_en_cg),
    .scan_mode                          (phy_scan_mode),
    .scan_in                            (phy_scan_in),
    .scan_out                           (phy_scan_out),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .scan_hsclock                       (phy_scan_hsclock),
    .scan_hssiclock                     (phy_scan_hssiclock),
    .scan_sieclock                      (phy_scan_sieclock),
    .scan_ats_mode                      (phy_scan_ats_mode),
    .scan_ats_hsclock                   (phy_scan_ats_hsclock),
    .scan_ats_hssiclock                 (phy_scan_ats_hssiclock),
    .scan_ats_sieclock                  (phy_scan_ats_sieclock),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .apb_pclk                           (phy_apb_pclk),
    .apb_presetn                        (phy_apb_presetn),
    .apb_pwrite                         (phy_apb_pwrite),
    .apb_penable                        (phy_apb_penable),
    .apb_pselx                          (phy_apb_pselx),
    .apb_paddr                          (phy_apb_paddr),
    .apb_pwdata                         (phy_apb_pwdata),

    .apb_prdata                         (phy_apb_prdata),
    .apb_pready                         (phy_apb_pready),
    .apb_pslverr                        (phy_apb_pslverr),
    `endif

    `ifdef CDNSUSB2PHY_3RD

    `else
    .sessvld                            (utmisessvld),
    `endif

    .hostdisconnect                     (utmihostdiscon),
    `ifdef CDNSUSB2PHY_3RD


    `else
    .idpullup                           (utmiidpullup),
    .iddig                              (utmiiddig),
    `endif
    .dmpulldown                         (utmidmpulldown),
    .dppulldown                         (utmidppulldown),
    `ifdef CDNSUSB2PHY_3RD

    `else
    .vbusvalid                          (utmivbusvalid),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .databus16_8                        (1'b0),
    `else
    .databus16_8                        (1'b0),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .vbus_sel                           (phy_vbus_sel),
    `endif
    `ifdef CDNSUSB2PHY_3RD
    .coreclkin                          (phy_coreclkin),
    .utmi_clk                           (phy_utmi_clk),
    `else
    .refclock                           (phy_refclock),
    .sieclock                           (phy_sieclock),
    `endif
    `ifdef CDNSUSB2PHY_3RD
    .utmi_reset                         (phy_utmi_reset_bist),
    `else
    .reset                              (phy_reset),
    `endif
    `ifdef CDNSUSB2PHY_3RD
    .ponrst                             (phy_ponrst_bist),
    `else
    .databus_reset                      (phy_databus_reset),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .pllrefsel                          (phy_pllrefsel),
    .lane_reverse                       (phy_lane_reverse),
    .powerdown                          (phy_powerdown),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .pso_disable                        (phy_pso_disable),
    .pso_disable_sel                    (phy_pso_disable_sel),

    .pll_clkon                          (phy_pll_clkon),
    .pll_standalone                     (phy_pll_standalone),
    .pll_clk_sel                        (phy_pll_clk_sel),
    .pll_clockout                       (phy_pll_clockout),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .usb2_phy_arch                      (phy_usb2_phy_arch),
    .usb2_phy_spare_out                 (phy_usb2_phy_spare_out),

    .pll_bypass_mode                    (phy_pll_bypass_mode),

    .option_n                           (phy_option_n),
    .option_cv                          (phy_option_cv),

    .iddq_mode                          (phy_iddq_mode),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .hs_bist_mode                       (phy_hs_bist_mode),
    .bist_ok                            (phy_bist_ok),

    .vcontrol                           (phy_vcontrol),
    .utmi_vcontrolloadm                 (phy_utmi_vcontrolloadm),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .test_rst                           (phy_test_rst),
    .test_se                            (phy_test_se),
    .test_clk                           (phy_test_clk),
    .test_mode                          (phy_test_mode),
    .external_test_mode                 (phy_external_test_mode),
    .test_si1                           (phy_test_si1),
    .test_si2                           (phy_test_si2),
    .test_si3                           (phy_test_si3),
    .test_si4                           (phy_test_si4),
    .test_so1                           (phy_test_so1),
    .test_so2                           (phy_test_so2),
    .test_so3                           (phy_test_so3),
    .test_so4                           (phy_test_so4),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .ls_en                              (phy_ls_en),
    .pll_en                             (phy_pll_en),
    .oscouten                           (phy_oscouten),
    .outclksel                          (phy_outclksel),
    .xtlsel                             (phy_xtlsel),
    .clk48m                             (phy_clk48m),
    .clk60sys                           (phy_clk60sys),
    .pllck120                           (phy_pllck120),
    .pllck480                           (phy_pllck480),
    .oscout                             (phy_oscout),
    .refclk                             (phy_refclk),

    .debug_sel                          (phy_debug_sel),
    .debug_out                          (phy_debug_out),

    .xcfgi                              (phy_xcfgi),
    .xcfg_coarse_tune_num               (phy_xcfg_coarse_tune_num),
    .xcfg_fine_tune_num                 (phy_xcfg_fine_tune_num),
    .xcfg_lock_range_max                (phy_xcfg_lock_range_max),
    .xcfg_lock_range_min                (phy_xcfg_lock_range_min),
    .xcfgo                              (phy_xcfgo),
    `endif

    .sleepm                             (utmisleepm),
    .suspendm                           (utmi_suspendm_i),
    .linestate                          (utmilinestate),
    .rxactive                           (utmirxactive),
    .rxerror                            (utmirxerror),
    .rxvalid                            (utmirxvalid),
    .rxvalidh                           (),
    .dataout                            ({utmidataouth, utmidataout}),
    .txready                            (utmitxready),
    .txvalid                            (utmitxvalid[0]),
    .txvalidh                           (1'b0),
    .datain                             ({8'h00, utmidatain}),
    .opmode                             (utmiopmode),
    .termselect                         (utmitermselect),
    .xcvrselect                         (utmixcvrselect)
    );
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `ifdef CDNSUSBHS_PHY_UTMI


  assign phy_utmi_linestate = utmilinestate;
  `endif
  `endif



  cdnsusbhs_bistctrl
  U_CDNSUSBHS_BISTCTRL
    (
    `ifdef CDNSUSB2PHY_3RD
    `ifdef CDNSUSBHS_PHY_UTMI
    .hs_bist_mode                       (phy_hs_bist_mode),
    .hs_bist_ponrst                     (phy_hs_bist_ponrst),
    `endif
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .bistrst                            (refreset),
    .bistclk                            (refclock),

    .apb_pclk                           (phy_apb_pclk),
    .apb_presetn                        (phy_apb_presetn),
    .apb_pwrite                         (phy_apb_pwrite),
    .apb_penable                        (phy_apb_penable),
    .apb_pselx                          (phy_apb_pselx),
    .apb_paddr                          (phy_apb_paddr),
    .apb_pwdata                         (phy_apb_pwdata),

    .apb_prdata                         (phy_apb_prdata),
    .apb_pready                         (phy_apb_pready),
    .apb_pslverr                        (phy_apb_pslverr),

    .tsfr_rstb                          (tsfr_rstb),
    .tsfr_addr_req                      (tsfr_addr_req_ref),
    .tsfr_addr                          (tsfr_addr),
    .tsfr_rdata_req                     (tsfr_rdata_req),
    .tsfr_rdata                         (tsfr_rdata),
    .tsfr_wdata_req                     (tsfr_wdata_req_ref),
    .tsfr_wdata                         (tsfr_wdata),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `ifdef CDNSUSBHS_PHY_UTMI
    .phy_utmi_reset_i                   (phy_utmi_reset),
    .phy_ponrst_i                       (phy_ponrst),

    .phy_utmi_reset_o                   (phy_utmi_reset_bist),
    .phy_ponrst_o                       (phy_ponrst_bist),
    `endif
    `endif

    .suspendm_low                       (phy_suspendm_low),
    `ifdef CDNSUSB2PHY_3RD
    `else
    .sleepm_ref                         (phy_sleepm_ref),
    .sleepm_refclk                      (phy_sleepm_refclk),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .utmidppulldown_i                   (utmidppulldown_bist),
    .utmidmpulldown_i                   (utmidmpulldown_bist),

    .utmidppulldown_o                   (utmidppulldown),
    .utmidmpulldown_o                   (utmidmpulldown),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .refsleepm_i                        (utmisleepm_bist_refclk),
    `endif
    .utmisleepm_i                       (utmisleepm_bist),
    .utmisuspendm_i                     (utmisuspendm_bist),

    .utmisleepm_o                       (utmisleepm),
    .utmisuspendm_o                     (utmisuspendm)
    );

  `ifdef CDNSUSBHS_PHY_UTMI


  assign utmi_suspendm = utmisuspendm;



  assign utmi_sleepm   = utmisleepm;
  `endif

  `ifdef CDNSUSBHS_PHY_UTMI


  assign utmiavalid  =  utmisessvld;
  assign utmibvalid  =  utmisessvld;
  assign utmisessend = ~utmisessvld;
  `endif




  cdnsusbhs_reset_ctrl
  U_CDNSUSBHS_RESET_CTRL
    (
    .scan_mode                          (scan_mode),

    .swrst                              (software_reset),
    .warst                              (workaround_rst),




    .uprst_o                            (arst),
    .upclk                              (aclk_gated),





    .utmiclk                            (utmiclk),
    .utmirst_o                          (utmirst),




    .wakeup5kclk                        (wakeup5kclk),
    .wakeup5krst_o                      (wakeup5krst),



    `ifdef CDNSUSB2PHY_3RD
    .phy_coreclkin                      (coreclkin),
    .phy_corerst                        (corerst),
    `else
    .phy_refclock                       (refclock),
    .phy_refreset                       (refreset),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .tsfr_rstb                          (tsfr_rstb_ref),
    .tsfr_rstb_o                        (tsfr_rstb),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .phy_utmi_reset                     (phy_utmi_reset_ref),
    .phy_utmi_reset_o                   (phy_utmi_reset),
    .phy_ponrst                         (phy_ponrst_ref),
    .phy_ponrst_o                       (phy_ponrst),
    `else
    .phy_reset                          (phy_reset_ref),
    .phy_reset_o                        (phy_reset),
    .phy_databus_reset                  (phy_databus_reset_ref),
    .phy_databus_reset_o                (phy_databus_reset),
    `endif



    .uprst_i                            (areset)
    );




  cdnsusbhs_clock_ctrl
  U_CDNSUSBHS_CLOCK_CTRL
    (
    .scan_en                            (scan_en),


    .aclk                               (aclk),
    .aclk_en                            (aclk_en),

    .aclk_gated                         (aclk_gated)
    );



  assign out_rama_clk = utmiclk;
  assign out_ramb_clk = aclk_gated;



  assign in_rama_clk = aclk_gated;
  assign in_ramb_clk = utmiclk;



  assign dmabclk = aclk_gated;



  assign out_ramb_data_scan = (scan_mode == 1'b1) ? out_rama_data :
                                                    out_ramb_data;



  assign in_ramb_data_scan  = (scan_mode == 1'b1) ? in_rama_data :
                                                    in_ramb_data;



  assign dmabdatard_scan    = (scan_mode == 1'b1) ? dmabdatawr :
                                                    dmabdatard;



  `ifdef CDNSUSB2PHY_3RD
  cdnsusbhs_dff_sync
  U_CDNSUSBHS_PHY_UTMI_RESET
    (

    .txsignal                           (phy_utmi_reset_up),


    .rxclk                              (coreclkin),
    .rxrst                              (corerst),
    .rxsignal                           (phy_utmi_reset_ref)
    );
  `else
  cdnsusbhs_dff_sync
  U_CDNSUSBHS_PHY_RESET
    (

    .txsignal                           (phy_reset_up),


    .rxclk                              (refclock),
    .rxrst                              (refreset),
    .rxsignal                           (phy_reset_ref)
    );
  `endif



  `ifdef CDNSUSB2PHY_3RD
  cdnsusbhs_dff_sync
  U_CDNSUSBHS_PHY_PONRST
    (

    .txsignal                           (phy_ponrst_up),


    .rxclk                              (coreclkin),
    .rxrst                              (corerst),
    .rxsignal                           (phy_ponrst_ref)
    );
  `else
  cdnsusbhs_dff_sync
  U_CDNSUSBHS_PHY_DATABUS_RESET
    (

    .txsignal                           (phy_databus_reset_up),


    .rxclk                              (refclock),
    .rxrst                              (refreset),
    .rxsignal                           (phy_databus_reset_ref)
    );
  `endif

`ifdef CDNSUSB2PHY_3RD
`else


  cdnsusbhs_dff_sync
  U_CDNSUSBHS_TSFR_ADDR_REQ_REF
    (

    .txsignal                           (tsfr_addr_req),


    .rxclk                              (refclock),
    .rxrst                              (refreset),
    .rxsignal                           (tsfr_addr_req_ref)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_TSFR_WDATA_REQ_REF
    (

    .txsignal                           (tsfr_wdata_req),


    .rxclk                              (refclock),
    .rxrst                              (refreset),
    .rxsignal                           (tsfr_wdata_req_ref)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_TSFR_RSTB_REF
    (

    .txsignal                           (tsfr_rstb_req),


    .rxclk                              (refclock),
    .rxrst                              (refreset),
    .rxsignal                           (tsfr_rstb_ref)
    );
`endif

  `ifdef CDNSUSB2PHY_3RD
  `else


  cdnsusbhs_dffn_sync
  U_CDNSUSBHS_UTMISLEEPM_BIST_REF
    (

    .txsignal                           (utmisleepm_bist),


    .rxclk                              (refclock),
    .rxrst                              (refreset),
    .rxsignal                           (utmisleepm_bist_refclk)
    );
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else


  cdnsusbhs_dffn_sync
  U_CDNSUSBHS_PHY_SLEEPM_REFCLK
    (

    .txsignal                           (phy_sleepm_ref),


    .rxclk                              (refclock),
    .rxrst                              (refreset),
    .rxsignal                           (phy_sleepm_refclk)
    );
  `endif






endmodule

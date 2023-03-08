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
//   Filename:           cdnsusbhs_chip_usbhs.v
//   Module Name:        cdnsusbhs_chip_usbhs
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
//   USBHS Chip Top level - sample unit
//   S.G.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"
`include "cdnsusbhs_adma_defines.v"



module cdnsusbhs_chip_usbhs
  (
  areset,

  wakeup,

  `ifdef CDNSUSBHS_PHY_UTMI
  `else
  scan_en,
  scan_mode,
  scan_clock,
  `endif

  `ifdef CDNSUSBHS_PHY_UTMI
  `else
  `ifdef CDNSUSB2PHY_3RD
  coreclkin,
  `else
  refclock,
  `endif
  `endif

  wakeup5kclk,

  otgstate,
  downstrstate,
  upstrstate,

  `ifdef CDNSUSBHS_PHY_UTMI
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
  `else
  phy_refclock,
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
  `ifdef CDNSUSBHS_UTMI_UNI_DIRECTION
  utmirxvalid,
  utmidataout,
  `else
  utmirxvalidl,
  `endif
  utmilinestate,
  utmivbusvalid,
  utmiavalid,
  utmibvalid,
  utmisessend,
  utmiiddig,
  utmihostdiscon,


  `ifdef CDNSUSBHS_UTMI_UNI_DIRECTION
  utmitxvalid,
  utmidatain,
  `else
  utmitxvalidl,
  `endif
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

  `ifdef CDNSUSBHS_UTMI_UNI_DIRECTION
  `else

  utmivalidh,
  utmidata,
  `endif
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

  vbusfault,

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

  wuintreq,
  usbintreq,
  usbivect
  );

  input                                       areset;

  input                                       wakeup;

  `ifdef CDNSUSBHS_PHY_UTMI
  `else
  input                                       scan_en;
  input                                       scan_mode;
  input                                       scan_clock;
  `endif

  `ifdef CDNSUSBHS_PHY_UTMI
  `else
  `ifdef CDNSUSB2PHY_3RD
  input                                       coreclkin;
  `else
  input                                       refclock;
  `endif
  `endif

  input                                       wakeup5kclk;

  output [4:0]                                otgstate;
  wire   [4:0]                                otgstate;
  output [3:0]                                downstrstate;
  wire   [3:0]                                downstrstate;
  output [4:0]                                upstrstate;
  wire   [4:0]                                upstrstate;

  `ifdef CDNSUSBHS_PHY_UTMI
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
  `else
  input                                       phy_refclock;
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
  `ifdef CDNSUSBHS_UTMI_UNI_DIRECTION
  input  [`CDNSUSBHS_USBDATAWIDTH/8-1:0]      utmirxvalid;
  input  [`CDNSUSBHS_USBDATAWIDTH-1:0]        utmidataout;
  `else
  input                                       utmirxvalidl;
  `endif
  input  [1:0]                                utmilinestate;
  input                                       utmivbusvalid;
  input                                       utmiavalid;
  input                                       utmibvalid;
  input                                       utmisessend;
  input                                       utmiiddig;
  input                                       utmihostdiscon;


  `ifdef CDNSUSBHS_UTMI_UNI_DIRECTION
  output [`CDNSUSBHS_USBDATAWIDTH/8-1:0]      utmitxvalid;
  wire   [`CDNSUSBHS_USBDATAWIDTH/8-1:0]      utmitxvalid;
  output [`CDNSUSBHS_USBDATAWIDTH-1:0]        utmidatain;
  wire   [`CDNSUSBHS_USBDATAWIDTH-1:0]        utmidatain;
  `else
  output                                      utmitxvalidl;
  wire                                        utmitxvalidl;
  `endif
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

  `ifdef CDNSUSBHS_UTMI_UNI_DIRECTION
  `else

  inout                                       utmivalidh;
  wire                                        utmivalidh;
  inout  [`CDNSUSBHS_USBDATAWIDTH-1:0]        utmidata;
  wire   [`CDNSUSBHS_USBDATAWIDTH-1:0]        utmidata;
  `endif
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

  input                                       vbusfault;

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

  output                                      wuintreq;
  wire                                        wuintreq;
  output                                      usbintreq;
  wire                                        usbintreq;
  output [7:0]                                usbivect;
  wire   [7:0]                                usbivect;




  `ifdef CDNSUSBHS_PHY_UTMI
  wire                                        utmiclk;
  `ifdef CDNSUSB2PHY_3RD
  wire                                        phy_utmi_clk;
  `else
  wire                                        phy_sieclock;
  `endif
  `endif

  `ifdef CDNSUSBHS_PHY_UTMI
  `else
  `ifdef CDNSUSB2PHY_3RD
  wire                                        coreclkin_bufg;
  `else
  wire                                        refclock_bufg;
  `endif
  `endif
  `ifdef CDNSUSBHS_PHY_UTMI
  `ifdef CDNSUSB2PHY_3RD
  wire                                        phy_coreclkin_bufg;
  `else
  wire                                        phy_refclock_bufg;
  `endif
  `endif

  wire                                        wakeup5kclk_bufg;
  wire                                        aclk_bufg;
  wire                                        utmiclk_bufg;

  `ifdef CDNSUSB2PHY_3RD
  wire                                        coreclkin_scan;
  `else
  wire                                        refclock_scan;
  `endif

  `ifdef CDNSUSBHS_PHY_UTMI
  `else


  `ifdef CDNSUSBHS_UTMI_UNI_DIRECTION
  `else

  wire   [`CDNSUSBHS_USBDATAWIDTH/8-1:0]      utmitxvalid;
  wire   [`CDNSUSBHS_USBDATAWIDTH-1:0]        utmidatain;


  wire   [`CDNSUSBHS_USBDATAWIDTH/8-1:0]      utmirxvalid;
  wire   [`CDNSUSBHS_USBDATAWIDTH-1:0]        utmidataout;
  `endif
  `endif

  `ifdef CDNSUSBHS_PHY_UTMI


  `ifdef CDNSUSB2PHY_3RD

  cdnsusbhs_clocks_mux
  U_CDNSUSBHS_UTMICLK
    (
    .clk_a                              (phy_utmi_clk),
    .clk_b                              (phy_test_clk),
    .sel                                (phy_test_mode),
    .clk_o                              (utmiclk)
    );
  `else
  assign utmiclk = phy_sieclock;
  `endif
  `endif

  `ifdef CDNSUSBHS_PHY_UTMI
  `else


  `ifdef CDNSUSB2PHY_3RD
  cdnsusbhs_bufg
  U_CDNSUSBHS_BUFG_CORECLKIN
    (
    .I                                  (coreclkin),
    .O                                  (coreclkin_bufg)
   );
  `else
  cdnsusbhs_bufg
  U_CDNSUSBHS_BUFG_REFCLOCK
    (
    .I                                  (refclock),
    .O                                  (refclock_bufg)
   );
  `endif
  `endif

  `ifdef CDNSUSBHS_PHY_UTMI


  `ifdef CDNSUSB2PHY_3RD
  cdnsusbhs_bufg
  U_CDNSUSBHS_BUFG_PHY_CORECLKIN
    (
    .I                                  (phy_coreclkin),
    .O                                  (phy_coreclkin_bufg)
   );
  `else
  cdnsusbhs_bufg
  U_CDNSUSBHS_BUFG_PHY_REFCLOCK
    (
    .I                                  (phy_refclock),
    .O                                  (phy_refclock_bufg)
   );
  `endif
  `endif



  cdnsusbhs_bufg
  U_CDNSUSBHS_BUFG_WAKEUP5KCLK
    (
    .I                                  (wakeup5kclk),
    .O                                  (wakeup5kclk_bufg)
   );



  cdnsusbhs_bufg
  U_CDNSUSBHS_BUFG_ACLK
    (
    .I                                  (aclk),
    .O                                  (aclk_bufg)
   );



  cdnsusbhs_bufg
  U_CDNSUSBHS_BUFG_UTMICLK
    (
    .I                                  (utmiclk),
    .O                                  (utmiclk_bufg)
   );

  `ifdef CDNSUSBHS_PHY_UTMI
  `else
  `ifdef CDNSUSBHS_UTMI_UNI_DIRECTION
  `else


  cdnsusbhs_utmi_glu
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .USBDATAWIDTH                       (`CDNSUSBHS_USBDATAWIDTH)
  `else
    `CDNSUSBHS_USBDATAWIDTH
  `endif
    )
  U_CDNSUSBHS_UTMI_GLU
    (

    .utmitxvalid                        (utmitxvalid),
    .utmidatain                         (utmidatain),


    .utmirxvalid                        (utmirxvalid),
    .utmidataout                        (utmidataout),


    .utmirxvalidl                       (utmirxvalidl),


    .utmitxvalidl                       (utmitxvalidl),


    .utmivalidh                         (utmivalidh),
    .utmidata                           (utmidata)
    );
  `endif
  `endif




  cdnsusbhs_usbhs_ram
  U_CDNSUSBHS_USBHS_RAM
    (



    .areset                             (areset),

    .wakeup                             (wakeup),

    `ifdef CDNSUSBHS_PHY_UTMI
    `else
    .scan_en                            (scan_en),
    .scan_mode                          (scan_mode),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .coreclkin                          (coreclkin_scan),
    `else
    .refclock                           (refclock_scan),
    `endif

    .wakeup5kclk                        (wakeup5kclk_bufg),

    .vbusfault                          (vbusfault),

    .otgstate                           (otgstate),
    .downstrstate                       (downstrstate),
    .upstrstate                         (upstrstate),




    `ifdef CDNSUSBHS_PHY_UTMI
    .utmiclk                            (utmiclk_bufg),
    .utmidrvvbus                        (utmidrvvbus),

    .utmi_suspendm_i                    (utmi_suspendm_i),
    .utmi_suspendm                      (utmi_suspendm),
    .utmi_sleepm                        (utmi_sleepm),

    `ifdef CDNSUSB2PHY_3RD
    .utmisessvld                        (utmisessvld),

    .utmiiddig                          (utmiiddig),
    .utmivbusvalid                      (utmivbusvalid),
    `endif


    `ifdef CDNSUSB2PHY_3RD
    .phy_coreclkin                      (phy_coreclkin_bufg),
    .phy_utmi_clk                       (phy_utmi_clk),
    `else
    .phy_refclock                       (phy_refclock_bufg),
    .phy_sieclock                       (phy_sieclock),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .phy_RTRIM                          (phy_RTRIM),
    `endif

    .usb_DM                             (usb_DM),
    .usb_DP                             (usb_DP),
    `ifdef CDNSUSB2PHY_3RD


    `else
    .usb_ID                             (usb_ID),
    .usb_VBUS                           (usb_VBUS),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .phy_hs_bist_ponrst                 (phy_hs_bist_ponrst),
    .phy_hs_bist_mode                   (phy_hs_bist_mode),
    .phy_bist_ok                        (phy_bist_ok),

    .phy_vcontrol                       (phy_vcontrol),
    .phy_utmi_vcontrolloadm             (phy_utmi_vcontrolloadm),
    .phy_utmi_linestate                 (phy_utmi_linestate),
    `else
    .phy_biston                         (phy_biston),
    .phy_bistmodesel                    (phy_bistmodesel),
    .phy_bistmodeen                     (phy_bistmodeen),
    .phy_bistcomplete                   (phy_bistcomplete),
    .phy_bisterror                      (phy_bisterror),
    .phy_bisterrorcount                 (phy_bisterrorcount),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .phy_test_rst                       (phy_test_rst),
    .phy_test_se                        (phy_test_se),
    .phy_test_clk                       (phy_test_clk),
    .phy_test_mode                      (phy_test_mode),
    .phy_external_test_mode             (phy_external_test_mode),
    .phy_test_si1                       (phy_test_si1),
    .phy_test_si2                       (phy_test_si2),
    .phy_test_si3                       (phy_test_si3),
    .phy_test_si4                       (phy_test_si4),
    .phy_test_so1                       (phy_test_so1),
    .phy_test_so2                       (phy_test_so2),
    .phy_test_so3                       (phy_test_so3),
    .phy_test_so4                       (phy_test_so4),
    `else
    .phy_scan_clock                     (phy_scan_clock),
    .phy_scan_en                        (phy_scan_en),
    .phy_scan_en_cg                     (phy_scan_en_cg),
    .phy_scan_mode                      (phy_scan_mode),
    .phy_scan_in                        (phy_scan_in),
    .phy_scan_out                       (phy_scan_out),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .phy_pll_clockout                   (phy_pll_clockout),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .phy_lane_reverse                   (phy_lane_reverse),
    .phy_vbus_sel                       (phy_vbus_sel),
    .phy_pllrefsel                      (phy_pllrefsel),

    .phy_pso_disable                    (phy_pso_disable),
    .phy_pso_disable_sel                (phy_pso_disable_sel),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .phy_usb2_phy_arch                  (phy_usb2_phy_arch),
    .phy_usb2_phy_spare_out             (phy_usb2_phy_spare_out),

    .phy_pll_bypass_mode                (phy_pll_bypass_mode),

    .phy_option_n                       (phy_option_n),
    .phy_option_cv                      (phy_option_cv),

    .phy_iddq_mode                      (phy_iddq_mode),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    .phy_scan_hsclock                   (phy_scan_hsclock),
    .phy_scan_hssiclock                 (phy_scan_hssiclock),
    .phy_scan_sieclock                  (phy_scan_sieclock),
    .phy_scan_ats_mode                  (phy_scan_ats_mode),
    .phy_scan_ats_hsclock               (phy_scan_ats_hsclock),
    .phy_scan_ats_hssiclock             (phy_scan_ats_hssiclock),
    .phy_scan_ats_sieclock              (phy_scan_ats_sieclock),
    `endif

    `ifdef CDNSUSB2PHY_3RD
    .phy_ls_en                          (phy_ls_en),
    .phy_pll_en                         (phy_pll_en),
    .phy_oscouten                       (phy_oscouten),
    .phy_outclksel                      (phy_outclksel),
    .phy_xtlsel                         (phy_xtlsel),
    .phy_clk48m                         (phy_clk48m),
    .phy_clk60sys                       (phy_clk60sys),
    .phy_pllck120                       (phy_pllck120),
    .phy_pllck480                       (phy_pllck480),
    .phy_oscout                         (phy_oscout),
    .phy_refclk                         (phy_refclk),

    .phy_debug_sel                      (phy_debug_sel),
    .phy_debug_out                      (phy_debug_out),

    .phy_xcfgi                          (phy_xcfgi),
    .phy_xcfg_coarse_tune_num           (phy_xcfg_coarse_tune_num),
    .phy_xcfg_fine_tune_num             (phy_xcfg_fine_tune_num),
    .phy_xcfg_lock_range_max            (phy_xcfg_lock_range_max),
    .phy_xcfg_lock_range_min            (phy_xcfg_lock_range_min),
    .phy_xcfgo                          (phy_xcfgo),
    `endif
    `endif
    `ifdef CDNSUSBHS_PHY_UTMI
    `else

    .utmiclk                            (utmiclk_bufg),
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
    .utmisuspendm                       (utmisuspendm),
    .utmisleepm                         (utmisleepm),
    .utmiopmode                         (utmiopmode),
    .utmitermselect                     (utmitermselect),
    .utmixcvrselect                     (utmixcvrselect),
    .utmiidpullup                       (utmiidpullup),
    .utmidppulldown                     (utmidppulldown),
    .utmidmpulldown                     (utmidmpulldown),
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
    `endif

    .tsmode                             (tsmode),

    .tmodecustom                        (tmodecustom),
    .tmodeselcustom                     (tmodeselcustom),





    .aclk                               (aclk_bufg),


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




    `ifdef CDNSUSBHS_PHY_UTMI
    `else
    `ifdef CDNSUSB2PHY_3RD

    .phy_suspendm_low                   (phy_suspendm_low),
    .phy_utmi_reset                     (phy_utmi_reset),
    .phy_ponrst                         (phy_ponrst),
    `else

    .phy_suspendm_low                   (phy_suspendm_low),
    .phy_sleepm_ref                     (phy_sleepm_ref),
    .phy_reset                          (phy_reset),
    .phy_databus_reset                  (phy_databus_reset),
    .phy_powerdown                      (phy_powerdown),




    .phy_pll_clkon                      (phy_pll_clkon),
    .phy_pll_standalone                 (phy_pll_standalone),
    .phy_pll_clk_sel                    (phy_pll_clk_sel),
    `endif
    `endif

    `ifdef CDNSUSB2PHY_3RD
    `else
    `ifdef CDNSUSBHS_PHY_UTMI
    `else



    .phy_apb_pclk                       (phy_apb_pclk),
    .phy_apb_presetn                    (phy_apb_presetn),
    .phy_apb_pwrite                     (phy_apb_pwrite),
    .phy_apb_penable                    (phy_apb_penable),
    .phy_apb_pselx                      (phy_apb_pselx),
    .phy_apb_paddr                      (phy_apb_paddr),
    .phy_apb_pwdata                     (phy_apb_pwdata),

    .phy_apb_prdata                     (phy_apb_prdata),
    .phy_apb_pready                     (phy_apb_pready),
    .phy_apb_pslverr                    (phy_apb_pslverr),
    `endif
    `endif




    .wuintreq                           (wuintreq),
    .usbintreq                          (usbintreq),
    .usbivect                           (usbivect)
    );






`ifdef CDNSUSBHS_PHY_UTMI


  `ifdef CDNSUSB2PHY_3RD
  cdnsusbhs_clocks_mux
  U_CDNSUSBHS_BISTCLK_SCAN
    (
    .clk_a                              (phy_coreclkin_bufg),
    .clk_b                              (phy_test_clk),
    .sel                                (phy_test_mode),
    .clk_o                              (coreclkin_scan)
    );
  `else
  cdnsusbhs_clocks_mux
  U_CDNSUSBHS_BISTCLK_SCAN
    (
    .clk_a                              (phy_refclock_bufg),
    .clk_b                              (phy_scan_clock),
    .sel                                (phy_scan_mode),
    .clk_o                              (refclock_scan)
    );
  `endif
`else


  `ifdef CDNSUSB2PHY_3RD
  cdnsusbhs_clocks_mux
  U_CDNSUSBHS_BISTCLK_SCAN
    (
    .clk_a                              (coreclkin_bufg),
    .clk_b                              (scan_clock),
    .sel                                (scan_mode),
    .clk_o                              (coreclkin_scan)
    );
  `else
  cdnsusbhs_clocks_mux
  U_CDNSUSBHS_BISTCLK_SCAN
    (
    .clk_a                              (refclock_bufg),
    .clk_b                              (scan_clock),
    .sel                                (scan_mode),
    .clk_o                              (refclock_scan)
    );
  `endif
`endif

endmodule

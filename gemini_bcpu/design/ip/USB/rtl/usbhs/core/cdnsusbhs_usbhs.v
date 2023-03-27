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
//   Filename:           cdnsusbhs_usbhs.v
//   Module Name:        cdnsusbhs_usbhs
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
//   USBHS Top level architecture
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"
`include "cdnsusbhs_adma_defines.v"



module cdnsusbhs_usbhs
  (
  wakeup,

  wakeup5kclk,
  wakeup5krst,


  utmiclk,
  utmirst,
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

  arst,
  aclk,
  aclk_nogated,
  aclk_en,


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
  swready,
  swlast,


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

  workaround_rst,

  vbusfault,

  software_reset,

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

  `ifdef CDNSUSB2PHY_3RD
  `else
  tsfr_rstb,
  tsfr_addr_req,
  tsfr_addr,
  tsfr_rdata_req,
  tsfr_rdata,
  tsfr_wdata_req,
  tsfr_wdata,
  `endif

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

  dmabdatard,
  dmabdatawr,
  dmabwr,
  dmabaddr,
  dmabrd,


  out_rama_addr,
  out_rama_wr,
  out_rama_data,


  out_ramb_addr,
  out_ramb_rd,
  out_ramb_data,


  in_rama_addr,
  in_rama_wr,
  in_rama_data,


  in_ramb_addr,
  in_ramb_rd,
  in_ramb_data
  );

  input                                       wakeup;

  input                                       wakeup5kclk;
  input                                       wakeup5krst;


  input                                       utmiclk;
  input                                       utmirst;
  input                                       utmitxready;
  input                                       utmirxactive;
  input                                       utmirxerror;
  input                                       utmirxvalid;
  input  [7:0]                                utmidataout;
  input  [1:0]                                utmilinestate;
  input                                       utmivbusvalid;
  input                                       utmiavalid;
  input                                       utmibvalid;
  input                                       utmisessend;
  input                                       utmiiddig;
  input                                       utmihostdiscon;


  output                                      utmitxvalid;
  wire                                        utmitxvalid;
  output [7:0]                                utmidatain;
  wire   [7:0]                                utmidatain;
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

  input                                       arst;
  input                                       aclk;
  input                                       aclk_nogated;
  output                                      aclk_en;
  wire                                        aclk_en;


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

  output                                      workaround_rst;
  wire                                        workaround_rst;

  input                                       vbusfault;

  output                                      software_reset;
  wire                                        software_reset;

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

  `ifdef CDNSUSB2PHY_3RD
  `else
  output                                      tsfr_rstb;
  wire                                        tsfr_rstb;
  output                                      tsfr_addr_req;
  wire                                        tsfr_addr_req;
  output [7:0]                                tsfr_addr;
  wire   [7:0]                                tsfr_addr;
  input                                       tsfr_rdata_req;
  input  [7:0]                                tsfr_rdata;
  output                                      tsfr_wdata_req;
  wire                                        tsfr_wdata_req;
  output [7:0]                                tsfr_wdata;
  wire   [7:0]                                tsfr_wdata;
  `endif

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


  input  [31:0]                               dmabdatard;
  output [31:0]                               dmabdatawr;
  wire   [31:0]                               dmabdatawr;
  output                                      dmabwr;
  wire                                        dmabwr;
  output [`CDNSUSBHS_ADMAMEMORY_WIDTH-1:0]    dmabaddr;
  wire   [`CDNSUSBHS_ADMAMEMORY_WIDTH-1:0]    dmabaddr;
  output                                      dmabrd;
  wire                                        dmabrd;


  output [`CDNSUSBHS_OUTADD-1:0]              out_rama_addr;
  wire   [`CDNSUSBHS_OUTADD-1:0]              out_rama_addr;
  output [3:0]                                out_rama_wr;
  wire   [3:0]                                out_rama_wr;
  output [31:0]                               out_rama_data;
  wire   [31:0]                               out_rama_data;


  output [`CDNSUSBHS_OUTADD-1:0]              out_ramb_addr;
  wire   [`CDNSUSBHS_OUTADD-1:0]              out_ramb_addr;
  output                                      out_ramb_rd;
  wire                                        out_ramb_rd;
  input  [31:0]                               out_ramb_data;


  output [`CDNSUSBHS_INADD-1:0]               in_rama_addr;
  wire   [`CDNSUSBHS_INADD-1:0]               in_rama_addr;
  output [3:0]                                in_rama_wr;
  wire   [3:0]                                in_rama_wr;
  output [31:0]                               in_rama_data;
  wire   [31:0]                               in_rama_data;


  output [`CDNSUSBHS_INADD-1:0]               in_ramb_addr;
  wire   [`CDNSUSBHS_INADD-1:0]               in_ramb_addr;
  output                                      in_ramb_rd;
  wire                                        in_ramb_rd;
  input  [31:0]                               in_ramb_data;

  wire   [7:0]                                cusb2_upaddr;
  wire                                        cusb2_uprd;
  wire                                        cusb2_upwr;
  wire   [3:0]                                cusb2_upbe_rd;
  wire   [3:0]                                cusb2_upbe_wr;
  wire   [31:0]                               cusb2_upwdata;
  wire                                        cusb2_upendian;
  wire   [31:0]                               cusb2_uprdata;

  wire   [`CDNSUSBHS_UPADDRWIDTH-1:0]         ocps_maddr;
  wire   [`CDNSUSBHS_UPDATAWIDTH-1:0]         ocps_mdata;
  wire   [2:0]                                ocps_mcmd;
  wire   [3:0]                                ocps_mbyteen;
  wire                                        ocps_scmdaccept;
  wire   [1:0]                                ocps_sresp;
  wire   [`CDNSUSBHS_UPDATAWIDTH-1:0]         ocps_sdata;

  wire   [4:0]                                dma_upaddr;
  wire                                        dma_uprd;
  wire                                        dma_upwr;
  wire   [3:0]                                dma_upbe_rd;
  wire   [3:0]                                dma_upbe_wr;
  wire   [31:0]                               dma_upwdata;
  wire   [31:0]                               dma_uprdata;


  wire                                        scmdaccept_m;
  wire   [`CDNSUSBHS_DATA_WIDTH-1:0]          sdata_m;
  wire   [`CDNSUSBHS_OCP_RESP_WIDTH-1:0]      sresp_m;

  wire   [`CDNSUSBHS_OCP_CMD_WIDTH-1:0]       mcmd_m;
  wire   [`CDNSUSBHS_OCP_ADDR_WIDTH-1:0]      maddr_m;
  wire   [`CDNSUSBHS_OCP_BURSTLENGTH_WIDTH-1:0]
                                              mburstlength_m;
  wire   [`CDNSUSBHS_DATA_WIDTH/8-1:0]        mbyteen_m;
  wire   [`CDNSUSBHS_OCP_BURSTSEQ_WIDTH-1:0]  mburstseq_m;
  wire                                        mburstprecise_m;
  wire   [`CDNSUSBHS_DATA_WIDTH-1:0]          mdata_m;
  wire                                        mreqlast_m;




  wire   [8:0]                                mux_upaddr;
  wire                                        mux_uprd;
  wire                                        mux_upwr;
  wire   [3:0]                                mux_upbe_rd;
  wire   [3:0]                                mux_upbe_wr;
  wire   [31:0]                               mux_upwdata;
  wire   [31:0]                               mux_uprdata;

  wire                                        wakeupid;
  wire                                        wakeupdp;
  wire                                        wakeupvbus;


  wire                                        cusb2_utmitxready;
  wire                                        cusb2_utmirxactive;
  wire                                        cusb2_utmirxerror;
  wire                                        cusb2_utmirxvalid;
  wire   [7:0]                                cusb2_utmidataout;
  wire   [1:0]                                cusb2_utmilinestate;
  wire                                        cusb2_utmivbusvalid;
  wire                                        cusb2_utmiavalid;
  wire                                        cusb2_utmibvalid;
  wire                                        cusb2_utmisessend;
  wire                                        cusb2_utmiiddig;
  wire                                        cusb2_utmihostdiscon;


  wire                                        cusb2_utmitxvalid;
  wire   [7:0]                                cusb2_utmidatain;
  wire                                        cusb2_utmisuspendm;
  wire                                        cusb2_utmisleepm;
  wire   [1:0]                                cusb2_utmiopmode;
  wire                                        cusb2_utmitermselect;
  wire   [1:0]                                cusb2_utmixcvrselect;
  wire                                        cusb2_utmiidpullup;
  wire                                        cusb2_utmidppulldown;
  wire                                        cusb2_utmidmpulldown;
  wire                                        cusb2_utmidrvvbus;
  wire                                        cusb2_utmichrgvbus;
  wire                                        cusb2_utmidischrgvbus;

  wire                                        cusb2_adp_en;
  wire                                        cusb2_adp_probe_en;
  wire                                        cusb2_adp_sense_en;
  wire                                        cusb2_adp_sink_current_en;
  wire                                        cusb2_adp_source_current_en;

  wire                                        cusb2_bc_en;
  wire                                        cusb2_dm_vdat_ref_comp_en;
  wire                                        cusb2_dm_vlgc_comp_en;
  wire                                        cusb2_dp_vdat_ref_comp_en;
  wire                                        cusb2_idm_sink_en;
  wire                                        cusb2_idp_sink_en;
  wire                                        cusb2_idp_src_en;
  wire                                        cusb2_vdm_src_en;
  wire                                        cusb2_vdp_src_en;
  wire                                        cusb2_rid_float_comp_en;
  wire                                        cusb2_rid_nonfloat_comp_en;

  wire                                        cusb2_adp_probe_ana;
  wire                                        cusb2_adp_sense_ana;
  wire                                        cusb2_dcd_comp_sts;
  wire                                        cusb2_dm_vdat_ref_comp_sts;
  wire                                        cusb2_dm_vlgc_comp_sts;
  wire                                        cusb2_dp_vdat_ref_comp_sts;
  wire                                        cusb2_rid_a_comp_sts;
  wire                                        cusb2_rid_b_comp_sts;
  wire                                        cusb2_rid_c_comp_sts;
  wire                                        cusb2_rid_float_comp_sts;
  wire                                        cusb2_rid_gnd_comp_sts;

  wire                                        wuintreq_up;


  wire   [`CDNSUSBHS_MAXI_ID_WIDTH-1:0]       axi_id_wr;
  wire   [`CDNSUSBHS_MAXI_ID_WIDTH-1:0]       axi_id_rd;
  wire   [1:0]                                axi_lock_wr;
  wire   [`CDNSUSBHS_M_CACHE_WIDTH-1:0]       axi_cache_wr;
  wire   [2:0]                                axi_prot_wr;
  wire   [1:0]                                axi_lock_rd;
  wire   [`CDNSUSBHS_M_CACHE_WIDTH-1:0]       axi_cache_rd;
  wire   [2:0]                                axi_prot_rd;

  wire                                        axi_idle;
  wire                                        axi_serror;
  wire                                        axi_derror;

  `ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  wire   [`CDNSUSBHS_M_LEN_WIDTH-1:0]         axi_b_max;
  wire   [`CDNSUSBHS_AXI_OT_W-1:0]            axi_wot;
  wire   [`CDNSUSBHS_AXI_OT_W-1:0]            axi_rot;
  `endif

  wire                                        cusb2_utmiclk;
  wire                                        cusb2_utmirst;



  assign cusb2_utmiclk = utmiclk;



  assign cusb2_utmirst = utmirst;




  cdnsusbhs_cusb2_adma
  U_CDNSUSBHS_CUSB2_ADMA
    (
    .cusb2_upclk                        (aclk),
    .cusb2_uprst                        (arst),

    .wakeup                             (wakeup),

    .wakeupid                           (wakeupid),
    .wakeupdp                           (wakeupdp),
    .wakeupvbus                         (wakeupvbus),


    .cusb2_utmiclk                      (cusb2_utmiclk),
    .cusb2_utmirst                      (cusb2_utmirst),
    .cusb2_utmitxready                  (cusb2_utmitxready),
    .cusb2_utmirxactive                 (cusb2_utmirxactive),
    .cusb2_utmirxerror                  (cusb2_utmirxerror),
    .cusb2_utmirxvalid                  (cusb2_utmirxvalid),
    .cusb2_utmidataout                  (cusb2_utmidataout),
    .cusb2_utmilinestate                (cusb2_utmilinestate),
    .cusb2_utmivbusvalid                (cusb2_utmivbusvalid),
    .cusb2_utmiavalid                   (cusb2_utmiavalid),
    .cusb2_utmibvalid                   (cusb2_utmibvalid),
    .cusb2_utmisessend                  (cusb2_utmisessend),
    .cusb2_utmiiddig                    (cusb2_utmiiddig),
    .cusb2_utmihostdiscon               (cusb2_utmihostdiscon),


    .cusb2_utmitxvalid                  (cusb2_utmitxvalid),
    .cusb2_utmidatain                   (cusb2_utmidatain),
    .cusb2_utmisuspendm                 (cusb2_utmisuspendm),
    .cusb2_utmisleepm                   (cusb2_utmisleepm),
    .cusb2_utmiopmode                   (cusb2_utmiopmode),
    .cusb2_utmitermselect               (cusb2_utmitermselect),
    .cusb2_utmixcvrselect               (cusb2_utmixcvrselect),
    .cusb2_utmiidpullup                 (cusb2_utmiidpullup),
    .cusb2_utmidppulldown               (cusb2_utmidppulldown),
    .cusb2_utmidmpulldown               (cusb2_utmidmpulldown),
    .cusb2_utmidrvvbus                  (cusb2_utmidrvvbus),
    .cusb2_utmichrgvbus                 (cusb2_utmichrgvbus),
    .cusb2_utmidischrgvbus              (cusb2_utmidischrgvbus),

    .cusb2_adp_en                       (cusb2_adp_en),
    .cusb2_adp_probe_en                 (cusb2_adp_probe_en),
    .cusb2_adp_sense_en                 (cusb2_adp_sense_en),
    .cusb2_adp_sink_current_en          (cusb2_adp_sink_current_en),
    .cusb2_adp_source_current_en        (cusb2_adp_source_current_en),

    .cusb2_bc_en                        (cusb2_bc_en),
    .cusb2_dm_vdat_ref_comp_en          (cusb2_dm_vdat_ref_comp_en),
    .cusb2_dm_vlgc_comp_en              (cusb2_dm_vlgc_comp_en),
    .cusb2_dp_vdat_ref_comp_en          (cusb2_dp_vdat_ref_comp_en),
    .cusb2_idm_sink_en                  (cusb2_idm_sink_en),
    .cusb2_idp_sink_en                  (cusb2_idp_sink_en),
    .cusb2_idp_src_en                   (cusb2_idp_src_en),
    .cusb2_vdm_src_en                   (cusb2_vdm_src_en),
    .cusb2_vdp_src_en                   (cusb2_vdp_src_en),
    .cusb2_rid_float_comp_en            (cusb2_rid_float_comp_en),
    .cusb2_rid_nonfloat_comp_en         (cusb2_rid_nonfloat_comp_en),

    .cusb2_adp_probe_ana                (cusb2_adp_probe_ana),
    .cusb2_adp_sense_ana                (cusb2_adp_sense_ana),
    .cusb2_dcd_comp_sts                 (cusb2_dcd_comp_sts),
    .cusb2_dm_vdat_ref_comp_sts         (cusb2_dm_vdat_ref_comp_sts),
    .cusb2_dm_vlgc_comp_sts             (cusb2_dm_vlgc_comp_sts),
    .cusb2_dp_vdat_ref_comp_sts         (cusb2_dp_vdat_ref_comp_sts),
    .cusb2_rid_a_comp_sts               (cusb2_rid_a_comp_sts),
    .cusb2_rid_b_comp_sts               (cusb2_rid_b_comp_sts),
    .cusb2_rid_c_comp_sts               (cusb2_rid_c_comp_sts),
    .cusb2_rid_float_comp_sts           (cusb2_rid_float_comp_sts),
    .cusb2_rid_gnd_comp_sts             (cusb2_rid_gnd_comp_sts),

    .workaround_rst                     (workaround_rst),

    .vbusfault                          (vbusfault),

    .tsmode                             (tsmode),
    .tmodecustom                        (tmodecustom),
    .tmodeselcustom                     (tmodeselcustom),

    .cusb2_upaddr                       (cusb2_upaddr),
    .cusb2_uprd                         (cusb2_uprd),
    .cusb2_upwr                         (cusb2_upwr),
    .cusb2_upbe_rd                      (cusb2_upbe_rd),
    .cusb2_upbe_wr                      (cusb2_upbe_wr),
    .cusb2_upwdata                      (cusb2_upwdata),
    .cusb2_upendian                     (cusb2_upendian),
    .cusb2_uprdata                      (cusb2_uprdata),

    .dma_upaddr                         (dma_upaddr[`CDNSUSBHS_SFR_ADDR_WIDTH-3:0]),
    .dma_uprd                           (dma_uprd),
    .dma_upwr                           (dma_upwr),
    .dma_upbe_wr                        (dma_upbe_wr),
    .dma_upbe_rd                        (dma_upbe_rd),
    .dma_upwdata                        (dma_upwdata),
    .dma_uprdata                        (dma_uprdata),


    .scmdaccept_m                       (scmdaccept_m),
    .sdata_m                            (sdata_m),
    .sresp_m                            (sresp_m),
    .mcmd_m                             (mcmd_m),
    .maddr_m                            (maddr_m),
    .mburstlength_m                     (mburstlength_m),
    .mbyteen_m                          (mbyteen_m),
    .mburstseq_m                        (mburstseq_m),
    .mburstprecise_m                    (mburstprecise_m),
    .mdata_m                            (mdata_m),
    .mreqlast_m                         (mreqlast_m),

    .wuintreq                           (wuintreq),
    .usbintreq                          (usbintreq),
    .usbivect                           (usbivect),

    .otgstate                           (otgstate),
    .downstrstate                       (downstrstate),
    .upstrstate                         (upstrstate),

    `ifdef CDNSUSB2PHY_3RD
    `else
    .tsfr_rstb                          (tsfr_rstb),
    .tsfr_addr_req                      (tsfr_addr_req),
    .tsfr_addr                          (tsfr_addr),
    .tsfr_rdata_req                     (tsfr_rdata_req),
    .tsfr_rdata                         (tsfr_rdata),
    .tsfr_wdata_req                     (tsfr_wdata_req),
    .tsfr_wdata                         (tsfr_wdata),
    `endif

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

    .axi_idle                           (axi_idle),
    .axi_serror                         (axi_serror),
    .axi_derror                         (axi_derror),
    .axi_id_wr                          (axi_id_wr),
    .axi_id_rd                          (axi_id_rd),
    .axi_lock_wr                        (axi_lock_wr),
    .axi_cache_wr                       (axi_cache_wr),
    .axi_prot_wr                        (axi_prot_wr),
    .axi_lock_rd                        (axi_lock_rd),
    .axi_cache_rd                       (axi_cache_rd),
    .axi_prot_rd                        (axi_prot_rd),

    `ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
    .axi_b_max                          (axi_b_max),
    .axi_wot                            (axi_wot),
    .axi_rot                            (axi_rot),
    `endif

    .dmabdatawr                         (dmabdatawr),
    .dmabwr                             (dmabwr),
    .dmabdatard                         (dmabdatard),
    .dmabaddr                           (dmabaddr),
    .dmabrd                             (dmabrd),

    .out_rama_addr                      (out_rama_addr),
    .out_rama_data                      (out_rama_data),
    .out_rama_wr                        (out_rama_wr),
    .out_ramb_addr                      (out_ramb_addr),
    .out_ramb_rd                        (out_ramb_rd),
    .out_ramb_data                      (out_ramb_data),

    .in_rama_addr                       (in_rama_addr),
    .in_rama_data                       (in_rama_data),
    .in_rama_wr                         (in_rama_wr),
    .in_ramb_addr                       (in_ramb_addr),
    .in_ramb_rd                         (in_ramb_rd),
    .in_ramb_data                       (in_ramb_data)
    );




  cdnsusbhs_upwrap
  U_CDNSUSBHS_UPWRAP
    (
    .ocp_clk                            (aclk),
    .ocp_rst                            (arst),

    .ocps_maddr                         (ocps_maddr),
    .ocps_mdata                         (ocps_mdata),
    .ocps_mcmd                          (ocps_mcmd),
    .ocps_mbyteen                       (ocps_mbyteen),
    .ocps_scmdaccept                    (ocps_scmdaccept),
    .ocps_sresp                         (ocps_sresp),
    .ocps_sdata                         (ocps_sdata),

    .int_upaddr                         (mux_upaddr),
    .int_uprd                           (mux_uprd),
    .int_upwr                           (mux_upwr),
    .int_upbe_rd                        (mux_upbe_rd),
    .int_upbe_wr                        (mux_upbe_wr),
    .int_upwdata                        (mux_upwdata),
    .int_uprdata                        (mux_uprdata)
    );




  cdnsusbhs_ocp2axi_sl
  U_CDNSUSBHS_OCP2AXI_SL
    (

    .aclk                               (aclk),
    .areset                             (arst),


    .awid                               (sawid),
    .awaddr                             (sawaddr),
    .awsize                             (sawsize),
    .awlen                              (sawlen),
    .awburst                            (sawburst),
    .awlock                             (sawlock),
    .awcache                            (sawcache),
    .awprot                             (sawprot),
    .awvalid                            (sawvalid),
    .awready                            (sawready),


    `ifdef CDNSUSBHS_UP_AXI_4
    `else
    .wid                                (swid),
    `endif
    .wdata                              (swdata),
    .wstrb                              (swstrb),
    .wvalid                             (swvalid),
    .wready                             (swready),
    .wlast                              (swlast),


    .bid                                (sbid),
    .bready                             (sbready),
    .bresp                              (sbresp),
    .bvalid                             (sbvalid),


    .arid                               (sarid),
    .araddr                             (saraddr),
    .arsize                             (sarsize),
    .arlen                              (sarlen),
    .arburst                            (sarburst),
    .arlock                             (sarlock),
    .arcache                            (sarcache),
    .arprot                             (sarprot),
    .arvalid                            (sarvalid),
    .arready                            (sarready),


    .rid                                (srid),
    .rready                             (srready),
    .rdata                              (srdata),
    .rresp                              (srresp),
    .rvalid                             (srvalid),
    .rlast                              (srlast),


    .scmdaccept                         (ocps_scmdaccept),
    .sresp                              (ocps_sresp),
    .sdata                              (ocps_sdata),
    .mcmd                               (ocps_mcmd),
    .maddr                              (ocps_maddr),
    .mbyteen                            (ocps_mbyteen),
    .mdata                              (ocps_mdata),

    .endian                             (cusb2_upendian)
    );




  cdnsusbhs_upmux
  U_CDNSUSBHS_UPMUX
    (
    .upclk                              (aclk),
    .uprst                              (arst),

    .upaddr                             (mux_upaddr),
    .uprd                               (mux_uprd),
    .upwr                               (mux_upwr),
    .upbe_rd                            (mux_upbe_rd),
    .upbe_wr                            (mux_upbe_wr),
    .upwdata                            (mux_upwdata),
    .uprdata                            (mux_uprdata),

    .dma_upaddr                         (dma_upaddr),
    .dma_uprd                           (dma_uprd),
    .dma_upwr                           (dma_upwr),
    .dma_upbe_rd                        (dma_upbe_rd),
    .dma_upbe_wr                        (dma_upbe_wr),
    .dma_upwdata                        (dma_upwdata),
    .dma_uprdata                        (dma_uprdata),

    .cusb2_upaddr                       (cusb2_upaddr),
    .cusb2_uprd                         (cusb2_uprd),
    .cusb2_upwr                         (cusb2_upwr),
    .cusb2_upbe_rd                      (cusb2_upbe_rd),
    .cusb2_upbe_wr                      (cusb2_upbe_wr),
    .cusb2_upwdata                      (cusb2_upwdata),
    .cusb2_upendian                     (cusb2_upendian),
    .cusb2_uprdata                      (cusb2_uprdata)
    );




  cdnsusbhs_ocp2axi_ms
  U_CDNSUSBHS_OCP2AXI_MS
    (

    .aclk                               (aclk),
    .areset                             (arst),


    .awid                               (mawid),
    .awaddr                             (mawaddr),
    .awsize                             (mawsize),
    .awlen                              (mawlen),
    .awburst                            (mawburst),
    .awlock                             (mawlock),
    .awcache                            (mawcache),
    .awprot                             (mawprot),
    .awvalid                            (mawvalid),
    .awready                            (mawready),


    .wid                                (mwid),
    .wdata                              (mwdata),
    .wstrb                              (mwstrb),
    .wvalid                             (mwvalid),
    .wready                             (mwready),
    .wlast                              (mwlast),


    .bid                                (mbid),
    .bready                             (mbready),
    .bresp                              (mbresp),
    .bvalid                             (mbvalid),


    .arid                               (marid),
    .araddr                             (maraddr),
    .arsize                             (marsize),
    .arlen                              (marlen),
    .arburst                            (marburst),
    .arlock                             (marlock),
    .arcache                            (marcache),
    .arprot                             (marprot),
    .arvalid                            (marvalid),
    .arready                            (marready),


    .rid                                (mrid),
    .rready                             (mrready),
    .rdata                              (mrdata),
    .rresp                              (mrresp),
    .rvalid                             (mrvalid),
    .rlast                              (mrlast),


    .mcmd                               (mcmd_m),
    .maddr                              (maddr_m),
    .mbyteen                            (mbyteen_m),
    .mburstseq                          (mburstseq_m),
    .mburstlength                       (mburstlength_m[7:0]),
    .mburstprecise                      (mburstprecise_m),
    .mreqlast                           (mreqlast_m),
    .mdata                              (mdata_m),
    .scmdaccept                         (scmdaccept_m),
    .sresp                              (sresp_m),
    .sdata                              (sdata_m),


    `ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
    .b_max                              (axi_b_max),
    .wot                                (axi_wot),
    .rot                                (axi_rot),
    `endif

    .axi_idle                           (axi_idle),
    .axi_serror                         (axi_serror),
    .axi_derror                         (axi_derror),
    .axi_id_wr                          (axi_id_wr),
    .axi_id_rd                          (axi_id_rd),
    .axi_lock_wr                        (axi_lock_wr),
    .axi_cache_wr                       (axi_cache_wr),
    .axi_prot_wr                        (axi_prot_wr),
    .axi_lock_rd                        (axi_lock_rd),
    .axi_cache_rd                       (axi_cache_rd),
    .axi_prot_rd                        (axi_prot_rd)
    );




  cdnsusbhs_usbwrap
  U_CDNSUSBHS_USBWRAP
    (


    .cusb2_utmitxvalid                  (cusb2_utmitxvalid),
    .cusb2_utmidatain                   (cusb2_utmidatain),
    .cusb2_utmisuspendm                 (cusb2_utmisuspendm),
    .cusb2_utmisleepm                   (cusb2_utmisleepm),
    .cusb2_utmiopmode                   (cusb2_utmiopmode),
    .cusb2_utmitermselect               (cusb2_utmitermselect),
    .cusb2_utmixcvrselect               (cusb2_utmixcvrselect),
    .cusb2_utmiidpullup                 (cusb2_utmiidpullup),
    .cusb2_utmidppulldown               (cusb2_utmidppulldown),
    .cusb2_utmidmpulldown               (cusb2_utmidmpulldown),
    .cusb2_utmidrvvbus                  (cusb2_utmidrvvbus),
    .cusb2_utmichrgvbus                 (cusb2_utmichrgvbus),
    .cusb2_utmidischrgvbus              (cusb2_utmidischrgvbus),

    .cusb2_adp_en                       (cusb2_adp_en),
    .cusb2_adp_probe_en                 (cusb2_adp_probe_en),
    .cusb2_adp_sense_en                 (cusb2_adp_sense_en),
    .cusb2_adp_sink_current_en          (cusb2_adp_sink_current_en),
    .cusb2_adp_source_current_en        (cusb2_adp_source_current_en),

    .cusb2_bc_en                        (cusb2_bc_en),
    .cusb2_dm_vdat_ref_comp_en          (cusb2_dm_vdat_ref_comp_en),
    .cusb2_dm_vlgc_comp_en              (cusb2_dm_vlgc_comp_en),
    .cusb2_dp_vdat_ref_comp_en          (cusb2_dp_vdat_ref_comp_en),
    .cusb2_idm_sink_en                  (cusb2_idm_sink_en),
    .cusb2_idp_sink_en                  (cusb2_idp_sink_en),
    .cusb2_idp_src_en                   (cusb2_idp_src_en),
    .cusb2_vdm_src_en                   (cusb2_vdm_src_en),
    .cusb2_vdp_src_en                   (cusb2_vdp_src_en),
    .cusb2_rid_float_comp_en            (cusb2_rid_float_comp_en),
    .cusb2_rid_nonfloat_comp_en         (cusb2_rid_nonfloat_comp_en),

    .cusb2_adp_probe_ana                (cusb2_adp_probe_ana),
    .cusb2_adp_sense_ana                (cusb2_adp_sense_ana),
    .cusb2_dcd_comp_sts                 (cusb2_dcd_comp_sts),
    .cusb2_dm_vdat_ref_comp_sts         (cusb2_dm_vdat_ref_comp_sts),
    .cusb2_dm_vlgc_comp_sts             (cusb2_dm_vlgc_comp_sts),
    .cusb2_dp_vdat_ref_comp_sts         (cusb2_dp_vdat_ref_comp_sts),
    .cusb2_rid_a_comp_sts               (cusb2_rid_a_comp_sts),
    .cusb2_rid_b_comp_sts               (cusb2_rid_b_comp_sts),
    .cusb2_rid_c_comp_sts               (cusb2_rid_c_comp_sts),
    .cusb2_rid_float_comp_sts           (cusb2_rid_float_comp_sts),
    .cusb2_rid_gnd_comp_sts             (cusb2_rid_gnd_comp_sts),


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

    .wakeup5kclk                        (wakeup5kclk),
    .wakeup5krst                        (wakeup5krst),

    .wakeupid                           (wakeupid),
    .wakeupdp                           (wakeupdp),
    .wakeupvbus                         (wakeupvbus),


    .cusb2_utmivbusvalid                (cusb2_utmivbusvalid),
    .cusb2_utmiavalid                   (cusb2_utmiavalid),
    .cusb2_utmibvalid                   (cusb2_utmibvalid),
    .cusb2_utmisessend                  (cusb2_utmisessend),
    .cusb2_utmiiddig                    (cusb2_utmiiddig),
    .cusb2_utmihostdiscon               (cusb2_utmihostdiscon),
    .cusb2_utmitxready                  (cusb2_utmitxready),
    .cusb2_utmirxactive                 (cusb2_utmirxactive),
    .cusb2_utmirxerror                  (cusb2_utmirxerror),
    .cusb2_utmirxvalid                  (cusb2_utmirxvalid),
    .cusb2_utmidataout                  (cusb2_utmidataout),
    .cusb2_utmilinestate                (cusb2_utmilinestate)
    );




  cdnsusbhs_clkgate
  U_CDNSUSBHS_CLKGATE
    (
    .aclk                               (aclk_nogated),
    .areset                             (arst),


    .awid                               (sawid),
    .awaddr                             (sawaddr[9:0]),
    .awsize                             (sawsize),
    .awvalid                            (sawvalid),


    `ifdef CDNSUSBHS_UP_AXI_4
    `else
    .wid                                (swid),
    `endif

    .wdata_0                            (swdata[7:0]),
    .wdata_3                            (swdata[31:24]),
    .wstrb_0                            (swstrb[0]),
    .wstrb_3                            (swstrb[3]),
    .wvalid                             (swvalid),


    .bready                             (sbready),
    .bvalid                             (sbvalid),

    .endian                             (cusb2_upendian),

    .wuintreq                           (wuintreq_up),

    .software_reset                     (software_reset),

    .aclk_en                            (aclk_en)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_WUINTREQ_UP
    (

    .txsignal                           (wuintreq),


    .rxclk                              (aclk_nogated),
    .rxrst                              (arst),
    .rxsignal                           (wuintreq_up)
    );

endmodule

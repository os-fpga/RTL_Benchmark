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
//   Filename:           cdnsusbhs_cusb2_adma.v
//   Module Name:        cdnsusbhs_cusb2_adma
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
//   CUSB2 and ADMA Top level architecture
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"
`include "cdnsusbhs_adma_defines.v"



module cdnsusbhs_cusb2_adma
  (
  cusb2_upclk,
  cusb2_uprst,
  cusb2_upaddr,
  cusb2_uprd,
  cusb2_upwr,
  cusb2_upbe_wr,
  cusb2_upbe_rd,
  cusb2_upwdata,
  cusb2_upendian,
  cusb2_uprdata,

  wuintreq,
  usbintreq,
  usbivect,

  dma_upaddr,
  dma_uprd,
  dma_upwr,
  dma_upbe_wr,
  dma_upbe_rd,
  dma_upwdata,
  dma_uprdata,


  scmdaccept_m,
  sdata_m,
  sresp_m,
  mcmd_m,
  maddr_m,
  mbyteen_m,
  mburstlength_m,
  mburstseq_m,
  mburstprecise_m,
  mdata_m,
  mreqlast_m,

  wakeup,
  wakeupid,
  wakeupdp,
  wakeupvbus,

  cusb2_utmiclk,
  cusb2_utmirst,
  cusb2_utmitxready,
  cusb2_utmirxactive,
  cusb2_utmirxerror,
  cusb2_utmirxvalid,
  cusb2_utmidataout,
  cusb2_utmilinestate,

  cusb2_utmivbusvalid,
  cusb2_utmiavalid,
  cusb2_utmibvalid,
  cusb2_utmisessend,
  cusb2_utmiiddig,
  cusb2_utmihostdiscon,

  cusb2_utmitxvalid,
  cusb2_utmidatain,
  cusb2_utmisuspendm,
  cusb2_utmisleepm,
  cusb2_utmiopmode,
  cusb2_utmitermselect,
  cusb2_utmixcvrselect,

  cusb2_utmiidpullup,
  cusb2_utmidppulldown,
  cusb2_utmidmpulldown,
  cusb2_utmidrvvbus,
  cusb2_utmichrgvbus,
  cusb2_utmidischrgvbus,

  cusb2_adp_en,
  cusb2_adp_probe_en,
  cusb2_adp_sense_en,
  cusb2_adp_sink_current_en,
  cusb2_adp_source_current_en,

  cusb2_bc_en,
  cusb2_dm_vdat_ref_comp_en,
  cusb2_dm_vlgc_comp_en,
  cusb2_dp_vdat_ref_comp_en,
  cusb2_idm_sink_en,
  cusb2_idp_sink_en,
  cusb2_idp_src_en,
  cusb2_vdm_src_en,
  cusb2_vdp_src_en,
  cusb2_rid_float_comp_en,
  cusb2_rid_nonfloat_comp_en,

  cusb2_adp_probe_ana,
  cusb2_adp_sense_ana,
  cusb2_dcd_comp_sts,
  cusb2_dm_vdat_ref_comp_sts,
  cusb2_dm_vlgc_comp_sts,
  cusb2_dp_vdat_ref_comp_sts,
  cusb2_rid_a_comp_sts,
  cusb2_rid_b_comp_sts,
  cusb2_rid_c_comp_sts,
  cusb2_rid_float_comp_sts,
  cusb2_rid_gnd_comp_sts,

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

  workaround_rst,

  vbusfault,

  tsmode,
  tmodecustom,
  tmodeselcustom,

  axi_idle,
  axi_serror,
  axi_derror,
  axi_id_wr,
  axi_id_rd,
  axi_lock_wr,
  axi_cache_wr,
  axi_prot_wr,
  axi_lock_rd,
  axi_cache_rd,
  axi_prot_rd,

  `ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  axi_b_max,
  axi_wot,
  axi_rot,
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





  `include "cdnsusbhs_adma_params.v"






  input                            cusb2_upclk;
  input                            cusb2_uprst;
  input  [7:0]                     cusb2_upaddr;
  input                            cusb2_uprd;
  input                            cusb2_upwr;
  input  [3:0]                     cusb2_upbe_rd;
  input  [3:0]                     cusb2_upbe_wr;
  input  [31:0]                    cusb2_upwdata;
  output                           cusb2_upendian;
  wire                             cusb2_upendian;
  output [31:0]                    cusb2_uprdata;
  wire   [31:0]                    cusb2_uprdata;

  output                           wuintreq;
  wire                             wuintreq;
  output                           usbintreq;
  wire                             usbintreq;
  output [7:0]                     usbivect;
  wire   [7:0]                     usbivect;


  input  [SFR_ADDR_WIDTH-3:0]      dma_upaddr;
  input                            dma_uprd;
  input                            dma_upwr;
  input  [3:0]                     dma_upbe_rd;
  input  [3:0]                     dma_upbe_wr;
  input  [31:0]                    dma_upwdata;
  output [31:0]                    dma_uprdata;
  wire   [31:0]                    dma_uprdata;



  input                            scmdaccept_m;
  input  [DATA_WIDTH-1:0]          sdata_m;
  input  [OCP_RESP_WIDTH-1:0]      sresp_m;

  output [OCP_CMD_WIDTH-1:0]       mcmd_m;
  wire   [OCP_CMD_WIDTH-1:0]       mcmd_m;
  output [OCP_ADDR_WIDTH-1:0]      maddr_m;
  wire   [OCP_ADDR_WIDTH-1:0]      maddr_m;
  output [(DATA_WIDTH/8)-1:0]      mbyteen_m;
  wire   [(DATA_WIDTH/8)-1:0]      mbyteen_m;
  output [OCP_BURSTLENGTH_WIDTH-1:0] mburstlength_m;
  wire   [OCP_BURSTLENGTH_WIDTH-1:0] mburstlength_m;
  output [OCP_BURSTSEQ_WIDTH-1:0]  mburstseq_m;
  wire   [OCP_BURSTSEQ_WIDTH-1:0]  mburstseq_m;
  output                           mburstprecise_m;
  wire                             mburstprecise_m;
  output [DATA_WIDTH-1:0]          mdata_m;
  wire   [DATA_WIDTH-1:0]          mdata_m;
  output                           mreqlast_m;
  wire                             mreqlast_m;

  input                            wakeup;
  input                            wakeupid;
  input                            wakeupdp;
  input                            wakeupvbus;

  input                            cusb2_utmiclk;
  input                            cusb2_utmirst;
  input                            cusb2_utmitxready;
  input                            cusb2_utmirxactive;
  input                            cusb2_utmirxerror;
  input                            cusb2_utmirxvalid;
  input  [7:0]                     cusb2_utmidataout;
  input  [1:0]                     cusb2_utmilinestate;
  input                            cusb2_utmivbusvalid;
  input                            cusb2_utmiavalid;
  input                            cusb2_utmibvalid;
  input                            cusb2_utmisessend;
  input                            cusb2_utmiiddig;
  input                            cusb2_utmihostdiscon;

  output                           cusb2_utmitxvalid;
  wire                             cusb2_utmitxvalid;
  output [7:0]                     cusb2_utmidatain;
  wire   [7:0]                     cusb2_utmidatain;
  output                           cusb2_utmisuspendm;
  wire                             cusb2_utmisuspendm;
  output                           cusb2_utmisleepm;
  wire                             cusb2_utmisleepm;
  output [1:0]                     cusb2_utmiopmode;
  wire   [1:0]                     cusb2_utmiopmode;
  output                           cusb2_utmitermselect;
  wire                             cusb2_utmitermselect;
  output [1:0]                     cusb2_utmixcvrselect;
  wire   [1:0]                     cusb2_utmixcvrselect;
  output                           cusb2_utmiidpullup;
  wire                             cusb2_utmiidpullup;
  output                           cusb2_utmidppulldown;
  wire                             cusb2_utmidppulldown;
  output                           cusb2_utmidmpulldown;
  wire                             cusb2_utmidmpulldown;
  output                           cusb2_utmidrvvbus;
  wire                             cusb2_utmidrvvbus;
  output                           cusb2_utmichrgvbus;
  wire                             cusb2_utmichrgvbus;
  output                           cusb2_utmidischrgvbus;
  wire                             cusb2_utmidischrgvbus;

  output                           cusb2_adp_en;
  wire                             cusb2_adp_en;
  output                           cusb2_adp_probe_en;
  wire                             cusb2_adp_probe_en;
  output                           cusb2_adp_sense_en;
  wire                             cusb2_adp_sense_en;
  output                           cusb2_adp_sink_current_en;
  wire                             cusb2_adp_sink_current_en;
  output                           cusb2_adp_source_current_en;
  wire                             cusb2_adp_source_current_en;

  output                           cusb2_bc_en;
  wire                             cusb2_bc_en;
  output                           cusb2_dm_vdat_ref_comp_en;
  wire                             cusb2_dm_vdat_ref_comp_en;
  output                           cusb2_dm_vlgc_comp_en;
  wire                             cusb2_dm_vlgc_comp_en;
  output                           cusb2_dp_vdat_ref_comp_en;
  wire                             cusb2_dp_vdat_ref_comp_en;
  output                           cusb2_idm_sink_en;
  wire                             cusb2_idm_sink_en;
  output                           cusb2_idp_sink_en;
  wire                             cusb2_idp_sink_en;
  output                           cusb2_idp_src_en;
  wire                             cusb2_idp_src_en;
  output                           cusb2_vdm_src_en;
  wire                             cusb2_vdm_src_en;
  output                           cusb2_vdp_src_en;
  wire                             cusb2_vdp_src_en;
  output                           cusb2_rid_float_comp_en;
  wire                             cusb2_rid_float_comp_en;
  output                           cusb2_rid_nonfloat_comp_en;
  wire                             cusb2_rid_nonfloat_comp_en;

  input                            cusb2_adp_probe_ana;
  input                            cusb2_adp_sense_ana;
  input                            cusb2_dcd_comp_sts;
  input                            cusb2_dm_vdat_ref_comp_sts;
  input                            cusb2_dm_vlgc_comp_sts;
  input                            cusb2_dp_vdat_ref_comp_sts;
  input                            cusb2_rid_a_comp_sts;
  input                            cusb2_rid_b_comp_sts;
  input                            cusb2_rid_c_comp_sts;
  input                            cusb2_rid_float_comp_sts;
  input                            cusb2_rid_gnd_comp_sts;

  output [4:0]                     otgstate;
  wire   [4:0]                     otgstate;
  output [3:0]                     downstrstate;
  wire   [3:0]                     downstrstate;
  output [4:0]                     upstrstate;
  wire   [4:0]                     upstrstate;

  `ifdef CDNSUSB2PHY_3RD
  `else
  output                           tsfr_rstb;
  wire                             tsfr_rstb;
  output                           tsfr_addr_req;
  wire                             tsfr_addr_req;
  output [7:0]                     tsfr_addr;
  wire   [7:0]                     tsfr_addr;
  input                            tsfr_rdata_req;
  input  [7:0]                     tsfr_rdata;
  output                           tsfr_wdata_req;
  wire                             tsfr_wdata_req;
  output [7:0]                     tsfr_wdata;
  wire   [7:0]                     tsfr_wdata;
  `endif

  `ifdef CDNSUSB2PHY_3RD

  output                           phy_suspendm_low;
  wire                             phy_suspendm_low;
  output                           phy_utmi_reset;
  wire                             phy_utmi_reset;
  output                           phy_ponrst;
  wire                             phy_ponrst;
  `else

  output                           phy_suspendm_low;
  wire                             phy_suspendm_low;
  output                           phy_sleepm_ref;
  wire                             phy_sleepm_ref;
  output                           phy_reset;
  wire                             phy_reset;
  output                           phy_databus_reset;
  wire                             phy_databus_reset;
  output [1:0]                     phy_powerdown;
  wire   [1:0]                     phy_powerdown;




  output                           phy_pll_clkon;
  wire                             phy_pll_clkon;
  output                           phy_pll_standalone;
  wire                             phy_pll_standalone;
  output [1:0]                     phy_pll_clk_sel;
  wire   [1:0]                     phy_pll_clk_sel;
  `endif


  input                            axi_idle;
  input                            axi_serror;
  input                            axi_derror;
  output [MAXI_ID_WIDTH-1:0]       axi_id_wr;
  wire   [MAXI_ID_WIDTH-1:0]       axi_id_wr;
  output [MAXI_ID_WIDTH-1:0]       axi_id_rd;
  wire   [MAXI_ID_WIDTH-1:0]       axi_id_rd;

  output [1:0]                     axi_lock_wr;
  wire   [1:0]                     axi_lock_wr;
  output [M_CACHE_WIDTH-1:0]       axi_cache_wr;
  wire   [M_CACHE_WIDTH-1:0]       axi_cache_wr;
  output [2:0]                     axi_prot_wr;
  wire   [2:0]                     axi_prot_wr;
  output [1:0]                     axi_lock_rd;
  wire   [1:0]                     axi_lock_rd;
  output [M_CACHE_WIDTH-1:0]       axi_cache_rd;
  wire   [M_CACHE_WIDTH-1:0]       axi_cache_rd;
  output [2:0]                     axi_prot_rd;
  wire   [2:0]                     axi_prot_rd;

  `ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  output [M_LEN_WIDTH-1:0]         axi_b_max;
  wire   [M_LEN_WIDTH-1:0]         axi_b_max;
  output [AXI_OT_W-1:0]            axi_wot;
  wire   [AXI_OT_W-1:0]            axi_wot;
  output [AXI_OT_W-1:0]            axi_rot;
  wire   [AXI_OT_W-1:0]            axi_rot;
  `endif


  input  [31:0]                    dmabdatard;
  output [31:0]                    dmabdatawr;
  wire   [31:0]                    dmabdatawr;
  output                           dmabwr;
  wire                             dmabwr;
  output [MEMADDRWIDTH-1:0]        dmabaddr;
  wire   [MEMADDRWIDTH-1:0]        dmabaddr;
  output                           dmabrd;
  wire                             dmabrd;


  output [`CDNSUSBHS_OUTADD-1:0]   out_rama_addr;
  wire   [`CDNSUSBHS_OUTADD-1:0]   out_rama_addr;
  output [3:0]                     out_rama_wr;
  wire   [3:0]                     out_rama_wr;
  output [31:0]                    out_rama_data;
  wire   [31:0]                    out_rama_data;


  output [`CDNSUSBHS_OUTADD-1:0]   out_ramb_addr;
  wire   [`CDNSUSBHS_OUTADD-1:0]   out_ramb_addr;
  output                           out_ramb_rd;
  wire                             out_ramb_rd;
  input  [31:0]                    out_ramb_data;


  output [`CDNSUSBHS_INADD-1:0]    in_rama_addr;
  wire   [`CDNSUSBHS_INADD-1:0]    in_rama_addr;
  output [3:0]                     in_rama_wr;
  wire   [3:0]                     in_rama_wr;
  output [31:0]                    in_rama_data;
  wire   [31:0]                    in_rama_data;


  output [`CDNSUSBHS_INADD-1:0]    in_ramb_addr;
  wire   [`CDNSUSBHS_INADD-1:0]    in_ramb_addr;
  output                           in_ramb_rd;
  wire                             in_ramb_rd;
  input  [31:0]                    in_ramb_data;

  output                           workaround_rst;
  wire                             workaround_rst;

  input                            vbusfault;

  input  [1:0]                     tsmode;
  output                           tmodecustom;
  wire                             tmodecustom;
  output [7:0]                     tmodeselcustom;
  wire   [7:0]                     tmodeselcustom;




  wire   [3:0]                     fifoaddr;

  wire                             fifoinwait;
  wire                             fifoinend;
  wire   [15:0]                    fifoinfull;
  wire   [15:0]                    fifoinafull;
  wire   [DMADATAWIDTH/8-1:0]      fifoindvi;
  wire   [DMADATAWIDTH-1:0]        fifoindatai;
  wire                             fifoinwr;

  wire                             fifooutwait;
  wire   [10:0]                    fifooutbc;
  wire   [DMADATAWIDTH-1:0]        fifooutdatao;
  wire   [15:0]                    fifooutempty;

  wire                             fifooutrd;







  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  wire     [3:0]                   buf_enable_15;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  wire     [3:0]                   buf_enable_14;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  wire     [3:0]                   buf_enable_13;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  wire     [3:0]                   buf_enable_12;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  wire     [3:0]                   buf_enable_11;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  wire     [3:0]                   buf_enable_10;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  wire     [3:0]                   buf_enable_9;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  wire     [3:0]                   buf_enable_8;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  wire     [3:0]                   buf_enable_7;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  wire     [3:0]                   buf_enable_6;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  wire     [3:0]                   buf_enable_5;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  wire     [3:0]                   buf_enable_4;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  wire     [3:0]                   buf_enable_3;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  wire     [3:0]                   buf_enable_2;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  wire     [3:0]                   buf_enable_1;
  `endif
  wire                             buf_enable_0;
  wire   [16*11-1:0]               fifooutmaxpck;
  wire   [16*11-1:0]               fifoinmaxpck;
  wire   [15:0]                    episoout;
  wire   [15:0]                    episoin;
  wire                             upstrenup;
  wire   [31:0]                    dmasof;
  wire                             innak;
  wire   [3:0]                     innak_no;
  wire   [16*2-1:0]                fiforst;


  wire                             dmaintreq;




  cdnsusbhs_cusb2
  U_CDNSUSBHS_CUSB2
    (
    .cusb2_upclk                        (cusb2_upclk),
    .cusb2_utmiclk                      (cusb2_utmiclk),

    .cusb2_uprst                        (cusb2_uprst),
    .cusb2_utmirst                      (cusb2_utmirst),

    .cusb2_upaddr                       (cusb2_upaddr),
    .cusb2_uprd                         (cusb2_uprd),
    .cusb2_upwr                         (cusb2_upwr),
    .cusb2_upbe_rd                      (cusb2_upbe_rd),
    .cusb2_upbe_wr                      (cusb2_upbe_wr),
    .cusb2_upwdata                      (cusb2_upwdata),
    .cusb2_upendian                     (cusb2_upendian),
    .cusb2_uprdata                      (cusb2_uprdata),

    .wuintreq                           (wuintreq),
    .usbintreq                          (usbintreq),
    .usbivect                           (usbivect),
    .dmaintreq                          (dmaintreq),

    .fifoinaddr                         (fifoaddr),
    .fifoinend                          (fifoinend),
    .fifoindvi                          (fifoindvi),
    .fifoindatai                        (fifoindatai),
    .fifoinwr                           (fifoinwr),
    .fifoinfull                         (fifoinfull),
    .fifoinafull                        (fifoinafull),
    .fifoinwait                         (fifoinwait),

    .fifooutaddr                        (fifoaddr),

    .fifooutrd                          (fifooutrd),
    .fifooutdatao                       (fifooutdatao),
    .fifooutempty                       (fifooutempty),
    .fifooutwait                        (fifooutwait),
    .fifooutbc                          (fifooutbc),

    .wakeup                             (wakeup),
    .wakeupid                           (wakeupid),
    .wakeupdp                           (wakeupdp),
    .wakeupvbus                         (wakeupvbus),


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

    .workaround_rst                     (workaround_rst),

    .vbusfault                          (vbusfault),

    .tsmode                             (tsmode),
    .tmodecustom                        (tmodecustom),
    .tmodeselcustom                     (tmodeselcustom),




    .fifooutmaxpck                      (fifooutmaxpck),
    .episoout                           (episoout),
    .episoin                            (episoin),
    .upstrenup                          (upstrenup),
    .fifoinmaxpck                       (fifoinmaxpck),

    `ifdef CDNSUSBHS_EPOUT_EXIST_15
    .buf_enable_15                      (buf_enable_15),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_14
    .buf_enable_14                      (buf_enable_14),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_13
    .buf_enable_13                      (buf_enable_13),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_12
    .buf_enable_12                      (buf_enable_12),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_11
    .buf_enable_11                      (buf_enable_11),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_10
    .buf_enable_10                      (buf_enable_10),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_9
    .buf_enable_9                       (buf_enable_9),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_8
    .buf_enable_8                       (buf_enable_8),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_7
    .buf_enable_7                       (buf_enable_7),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_6
    .buf_enable_6                       (buf_enable_6),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_5
    .buf_enable_5                       (buf_enable_5),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_4
    .buf_enable_4                       (buf_enable_4),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_3
    .buf_enable_3                       (buf_enable_3),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_2
    .buf_enable_2                       (buf_enable_2),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_1
    .buf_enable_1                       (buf_enable_1),
    `endif
    .buf_enable_0                       (buf_enable_0),
    .dmasof                             (dmasof),
    .innak                              (innak),
    .innak_no                           (innak_no),
    .fiforst                            (fiforst),

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




  cdnsusbhs_adma_top
  U_CDNSUSBHS_ADMA_TOP
    (
    .upclk                              (cusb2_upclk),
    .uprst                              (cusb2_uprst),

    .intreq                             (dmaintreq),



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


    .fifoaddr                           (fifoaddr),

    .fifoinwait                         (fifoinwait),
    .fifoinfull                         (fifoinfull),
    .fifoinafull                        (fifoinafull),
    .fifoinend                          (fifoinend),
    .fifoindvi                          (fifoindvi),
    .fifoindatai                        (fifoindatai),
    .fifoinwr                           (fifoinwr),

    .fifooutwait                        (fifooutwait),
    .fifooutbc                          (fifooutbc),
    .fifooutdatao                       (fifooutdatao),
    .fifooutempty                       (fifooutempty),

    .fifooutrd                          (fifooutrd),




    .fifooutmaxpck                      (fifooutmaxpck),
    .fifoinmaxpck                       (fifoinmaxpck),
    .episoout                           (episoout),
    .episoin                            (episoin),
    .upstrenup                          (upstrenup),
    .dmasof                             (dmasof),

    `ifdef CDNSUSBHS_EPOUT_EXIST_15
    .buf_enable_15                      (buf_enable_15),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_14
    .buf_enable_14                      (buf_enable_14),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_13
    .buf_enable_13                      (buf_enable_13),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_12
    .buf_enable_12                      (buf_enable_12),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_11
    .buf_enable_11                      (buf_enable_11),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_10
    .buf_enable_10                      (buf_enable_10),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_9
    .buf_enable_9                       (buf_enable_9),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_8
    .buf_enable_8                       (buf_enable_8),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_7
    .buf_enable_7                       (buf_enable_7),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_6
    .buf_enable_6                       (buf_enable_6),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_5
    .buf_enable_5                       (buf_enable_5),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_4
    .buf_enable_4                       (buf_enable_4),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_3
    .buf_enable_3                       (buf_enable_3),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_2
    .buf_enable_2                       (buf_enable_2),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_1
    .buf_enable_1                       (buf_enable_1),
    `endif
    .buf_enable_0                       (buf_enable_0),
    .innak                              (innak),
    .innak_no                           (innak_no),
    .fiforst                            (fiforst),

    .dma_upaddr                         (dma_upaddr),
    .dma_uprd                           (dma_uprd),
    .dma_upwr                           (dma_upwr),
    .dma_upbe_wr                        (dma_upbe_wr),
    .dma_upbe_rd                        (dma_upbe_rd),
    .dma_upwdata                        (dma_upwdata),
    .dma_uprdata                        (dma_uprdata),


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
    .dmabrd                             (dmabrd)
    );

endmodule

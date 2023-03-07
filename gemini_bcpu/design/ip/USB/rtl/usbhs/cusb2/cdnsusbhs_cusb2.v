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
//   Filename:           cdnsusbhs_cusb2.v
//   Module Name:        cdnsusbhs_cusb2
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
//   CUSB2 Top level architecture
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_cusb2
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
  dmaintreq,

  fifoinaddr,
  fifoinend,
  fifoindvi,
  fifoindatai,
  fifoinwr,
  fifoinfull,
  fifoinafull,
  fifoinwait,

  fifooutaddr,

  fifooutrd,
  fifooutbc,
  fifooutdatao,
  fifooutempty,
  fifooutwait,

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
  in_ramb_data,

  fifooutmaxpck,

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  buf_enable_15,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  buf_enable_14,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  buf_enable_13,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  buf_enable_12,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  buf_enable_11,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  buf_enable_10,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  buf_enable_9,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  buf_enable_8,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  buf_enable_7,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  buf_enable_6,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  buf_enable_5,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  buf_enable_4,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  buf_enable_3,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  buf_enable_2,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  buf_enable_1,
  `endif
  buf_enable_0,

  fifoinmaxpck,
  episoout,
  episoin,
  upstrenup,
  dmasof,
  innak,
  innak_no,
  fiforst,

  workaround_rst,

  vbusfault,

  tsmode,
  tmodecustom,
  tmodeselcustom
  );

  parameter OUTADDRWIDTH = 32'd`CDNSUSBHS_OUTADDRWIDTH;
  parameter INADDRWIDTH  = 32'd`CDNSUSBHS_INADDRWIDTH;




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
  input                            dmaintreq;


  input  [3:0]                     fifoinaddr;
  input                            fifoinend;
  input  [3:0]                     fifoindvi;
  input  [31:0]                    fifoindatai;
  input                            fifoinwr;
  output [15:0]                    fifoinfull;
  wire   [15:0]                    fifoinfull;
  output [15:0]                    fifoinafull;
  wire   [15:0]                    fifoinafull;
  output                           fifoinwait;
  wire                             fifoinwait;


  input  [3:0]                     fifooutaddr;

  input                            fifooutrd;
  output [10:0]                    fifooutbc;
  wire   [10:0]                    fifooutbc;
  output [31:0]                    fifooutdatao;
  wire   [31:0]                    fifooutdatao;
  output [15:0]                    fifooutempty;
  wire   [15:0]                    fifooutempty;
  output                           fifooutwait;
  wire                             fifooutwait;

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

  output [16*11-1:0]               fifooutmaxpck;
  wire   [16*11-1:0]               fifooutmaxpck;


  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  input    [3:0]                   buf_enable_15;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  input    [3:0]                   buf_enable_14;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  input    [3:0]                   buf_enable_13;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  input    [3:0]                   buf_enable_12;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  input    [3:0]                   buf_enable_11;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  input    [3:0]                   buf_enable_10;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  input    [3:0]                   buf_enable_9;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  input    [3:0]                   buf_enable_8;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  input    [3:0]                   buf_enable_7;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  input    [3:0]                   buf_enable_6;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  input    [3:0]                   buf_enable_5;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  input    [3:0]                   buf_enable_4;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  input    [3:0]                   buf_enable_3;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  input    [3:0]                   buf_enable_2;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  input    [3:0]                   buf_enable_1;
  `endif
  input                            buf_enable_0;

  output [16*11-1:0]               fifoinmaxpck;
  wire   [16*11-1:0]               fifoinmaxpck;
  output [15:0]                    episoout;
  wire   [15:0]                    episoout;
  output [15:0]                    episoin;
  wire   [15:0]                    episoin;
  output                           upstrenup;
  wire                             upstrenup;
  output [31:0]                    dmasof;
  wire   [31:0]                    dmasof;
  output                           innak;
  wire                             innak;
  output [3:0]                     innak_no;
  wire   [3:0]                     innak_no;
  input  [16*2-1:0]                fiforst;

  output                           workaround_rst;
  wire                             workaround_rst;

  input                            vbusfault;

  input  [1:0]                     tsmode;
  output                           tmodecustom;
  wire                             tmodecustom;
  output [7:0]                     tmodeselcustom;
  wire   [7:0]                     tmodeselcustom;

  wire   [15:0]                    bufffullout;

  wire   [16*2-1:1*2]              eptype_out;
  wire   [1:0]                     eptype_out15;
  wire   [1:0]                     eptype_out14;
  wire   [1:0]                     eptype_out13;
  wire   [1:0]                     eptype_out12;
  wire   [1:0]                     eptype_out11;
  wire   [1:0]                     eptype_out10;
  wire   [1:0]                     eptype_out9;
  wire   [1:0]                     eptype_out8;
  wire   [1:0]                     eptype_out7;
  wire   [1:0]                     eptype_out6;
  wire   [1:0]                     eptype_out5;
  wire   [1:0]                     eptype_out4;
  wire   [1:0]                     eptype_out3;
  wire   [1:0]                     eptype_out2;
  wire   [1:0]                     eptype_out1;

  wire                             episoout15;
  wire                             episoout14;
  wire                             episoout13;
  wire                             episoout12;
  wire                             episoout11;
  wire                             episoout10;
  wire                             episoout9;
  wire                             episoout8;
  wire                             episoout7;
  wire                             episoout6;
  wire                             episoout5;
  wire                             episoout4;
  wire                             episoout3;
  wire                             episoout2;
  wire                             episoout1;

  wire   [15:0]                    stallout;
  wire   [15:0]                    busyout;
  wire   [15:0]                    nxtbusyout;
  wire   [15:0]                    epvalout;

  wire   [16*2-1:1*2]              toggle_out;
  wire   [1:0]                     toggle_out15;
  wire   [1:0]                     toggle_out14;
  wire   [1:0]                     toggle_out13;
  wire   [1:0]                     toggle_out12;
  wire   [1:0]                     toggle_out11;
  wire   [1:0]                     toggle_out10;
  wire   [1:0]                     toggle_out9;
  wire   [1:0]                     toggle_out8;
  wire   [1:0]                     toggle_out7;
  wire   [1:0]                     toggle_out6;
  wire   [1:0]                     toggle_out5;
  wire   [1:0]                     toggle_out4;
  wire   [1:0]                     toggle_out3;
  wire   [1:0]                     toggle_out2;
  wire   [1:0]                     toggle_out1;

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  wire   [11:0]                    usbfifoptrwr15;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  wire   [11:0]                    usbfifoptrwr14;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  wire   [11:0]                    usbfifoptrwr13;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  wire   [11:0]                    usbfifoptrwr12;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  wire   [11:0]                    usbfifoptrwr11;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  wire   [11:0]                    usbfifoptrwr10;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  wire   [11:0]                    usbfifoptrwr9;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  wire   [11:0]                    usbfifoptrwr8;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  wire   [11:0]                    usbfifoptrwr7;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  wire   [11:0]                    usbfifoptrwr6;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  wire   [11:0]                    usbfifoptrwr5;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  wire   [11:0]                    usbfifoptrwr4;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  wire   [11:0]                    usbfifoptrwr3;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  wire   [11:0]                    usbfifoptrwr2;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  wire   [11:0]                    usbfifoptrwr1;
  `endif
  wire   [11:0]                    usbfifoptrwr0;

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  wire   [11:0]                    usbfifoptrrd15;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  wire   [11:0]                    usbfifoptrrd14;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  wire   [11:0]                    usbfifoptrrd13;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  wire   [11:0]                    usbfifoptrrd12;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  wire   [11:0]                    usbfifoptrrd11;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  wire   [11:0]                    usbfifoptrrd10;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  wire   [11:0]                    usbfifoptrrd9;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  wire   [11:0]                    usbfifoptrrd8;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  wire   [11:0]                    usbfifoptrrd7;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  wire   [11:0]                    usbfifoptrrd6;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  wire   [11:0]                    usbfifoptrrd5;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  wire   [11:0]                    usbfifoptrrd4;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  wire   [11:0]                    usbfifoptrrd3;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  wire   [11:0]                    usbfifoptrrd2;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  wire   [11:0]                    usbfifoptrrd1;
  `endif
  wire   [11:0]                    usbfifoptrrd0;

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  wire   [11:0]                    upfifoptrwr15;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  wire   [11:0]                    upfifoptrwr14;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  wire   [11:0]                    upfifoptrwr13;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  wire   [11:0]                    upfifoptrwr12;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  wire   [11:0]                    upfifoptrwr11;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  wire   [11:0]                    upfifoptrwr10;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  wire   [11:0]                    upfifoptrwr9;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  wire   [11:0]                    upfifoptrwr8;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  wire   [11:0]                    upfifoptrwr7;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  wire   [11:0]                    upfifoptrwr6;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  wire   [11:0]                    upfifoptrwr5;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  wire   [11:0]                    upfifoptrwr4;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  wire   [11:0]                    upfifoptrwr3;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  wire   [11:0]                    upfifoptrwr2;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  wire   [11:0]                    upfifoptrwr1;
  `endif
  wire   [11:0]                    upfifoptrwr0;

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  wire   [11:0]                    upfifoptrrd15;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  wire   [11:0]                    upfifoptrrd14;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  wire   [11:0]                    upfifoptrrd13;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  wire   [11:0]                    upfifoptrrd12;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  wire   [11:0]                    upfifoptrrd11;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  wire   [11:0]                    upfifoptrrd10;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  wire   [11:0]                    upfifoptrrd9;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  wire   [11:0]                    upfifoptrrd8;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  wire   [11:0]                    upfifoptrrd7;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  wire   [11:0]                    upfifoptrrd6;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  wire   [11:0]                    upfifoptrrd5;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  wire   [11:0]                    upfifoptrrd4;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  wire   [11:0]                    upfifoptrrd3;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  wire   [11:0]                    upfifoptrrd2;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  wire   [11:0]                    upfifoptrrd1;
  `endif
  wire   [11:0]                    upfifoptrrd0;

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  wire   [31:0]                    epoutdata15;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  wire   [31:0]                    epoutdata14;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  wire   [31:0]                    epoutdata13;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  wire   [31:0]                    epoutdata12;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  wire   [31:0]                    epoutdata11;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  wire   [31:0]                    epoutdata10;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  wire   [31:0]                    epoutdata9;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  wire   [31:0]                    epoutdata8;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  wire   [31:0]                    epoutdata7;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  wire   [31:0]                    epoutdata6;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  wire   [31:0]                    epoutdata5;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  wire   [31:0]                    epoutdata4;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  wire   [31:0]                    epoutdata3;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  wire   [31:0]                    epoutdata2;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  wire   [31:0]                    epoutdata1;
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  wire   [10:0]                    fifobc_int15;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  wire   [10:0]                    fifobc_int14;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  wire   [10:0]                    fifobc_int13;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  wire   [10:0]                    fifobc_int12;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  wire   [10:0]                    fifobc_int11;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  wire   [10:0]                    fifobc_int10;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  wire   [10:0]                    fifobc_int9;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  wire   [10:0]                    fifobc_int8;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  wire   [10:0]                    fifobc_int7;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  wire   [10:0]                    fifobc_int6;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  wire   [10:0]                    fifobc_int5;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  wire   [10:0]                    fifobc_int4;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  wire   [10:0]                    fifobc_int3;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  wire   [10:0]                    fifobc_int2;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  wire   [10:0]                    fifobc_int1;
  `endif
  wire   [10:0]                    fifobc_int0;

  wire   [15:0]                    fifoempty_int;
  wire   [15:0]                    outbsyfall;

  wire   [15:1]                    hcdoisoin;
  wire   [15:0]                    hcepsuspendin;

  wire   [16*4-1:0]                hcendpnrusbin;
  wire   [3:0]                     hcendpnrusbin15;
  wire   [3:0]                     hcendpnrusbin14;
  wire   [3:0]                     hcendpnrusbin13;
  wire   [3:0]                     hcendpnrusbin12;
  wire   [3:0]                     hcendpnrusbin11;
  wire   [3:0]                     hcendpnrusbin10;
  wire   [3:0]                     hcendpnrusbin9;
  wire   [3:0]                     hcendpnrusbin8;
  wire   [3:0]                     hcendpnrusbin7;
  wire   [3:0]                     hcendpnrusbin6;
  wire   [3:0]                     hcendpnrusbin5;
  wire   [3:0]                     hcendpnrusbin4;
  wire   [3:0]                     hcendpnrusbin3;
  wire   [3:0]                     hcendpnrusbin2;
  wire   [3:0]                     hcendpnrusbin1;
  wire   [3:0]                     hcendpnrusbin0;

  wire   [15:0]                    hcunderrien;
  wire   [15:0]                    hcnakidisin;
  wire   [15:0]                    hcerrirqin;

  wire   [15:0]                    hcepwaitin;
  wire   [7:0]                     hclpmctrl;
  wire                             hclpmctrlb;
  wire                             hcdolpm;

  wire   [15:1]                    epvalin;

  wire   [16*2-1:1*2]              eptype_in;
  wire   [1:0]                     eptype_in15;
  wire   [1:0]                     eptype_in14;
  wire   [1:0]                     eptype_in13;
  wire   [1:0]                     eptype_in12;
  wire   [1:0]                     eptype_in11;
  wire   [1:0]                     eptype_in10;
  wire   [1:0]                     eptype_in9;
  wire   [1:0]                     eptype_in8;
  wire   [1:0]                     eptype_in7;
  wire   [1:0]                     eptype_in6;
  wire   [1:0]                     eptype_in5;
  wire   [1:0]                     eptype_in4;
  wire   [1:0]                     eptype_in3;
  wire   [1:0]                     eptype_in2;
  wire   [1:0]                     eptype_in1;

  wire                             episoin15;
  wire                             episoin14;
  wire                             episoin13;
  wire                             episoin12;
  wire                             episoin11;
  wire                             episoin10;
  wire                             episoin9;
  wire                             episoin8;
  wire                             episoin7;
  wire                             episoin6;
  wire                             episoin5;
  wire                             episoin4;
  wire                             episoin3;
  wire                             episoin2;
  wire                             episoin1;

  wire   [15:0]                    stallin;
  wire   [15:0]                    busyin;

  wire   [16*2-1:1*2]              toggle_in;
  wire   [1:0]                     toggle_in15;
  wire   [1:0]                     toggle_in14;
  wire   [1:0]                     toggle_in13;
  wire   [1:0]                     toggle_in12;
  wire   [1:0]                     toggle_in11;
  wire   [1:0]                     toggle_in10;
  wire   [1:0]                     toggle_in9;
  wire   [1:0]                     toggle_in8;
  wire   [1:0]                     toggle_in7;
  wire   [1:0]                     toggle_in6;
  wire   [1:0]                     toggle_in5;
  wire   [1:0]                     toggle_in4;
  wire   [1:0]                     toggle_in3;
  wire   [1:0]                     toggle_in2;
  wire   [1:0]                     toggle_in1;

  wire   [16*1-1:0]                dvi_in;
  wire                             dvi_in15;
  wire                             dvi_in14;
  wire                             dvi_in13;
  wire                             dvi_in12;
  wire                             dvi_in11;
  wire                             dvi_in10;
  wire                             dvi_in9;
  wire                             dvi_in8;
  wire                             dvi_in7;
  wire                             dvi_in6;
  wire                             dvi_in5;
  wire                             dvi_in4;
  wire                             dvi_in3;
  wire                             dvi_in2;
  wire                             dvi_in1;
  wire                             dvi_in0;

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  wire   [31:0]                    epindata15;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  wire   [31:0]                    epindata14;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  wire   [31:0]                    epindata13;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  wire   [31:0]                    epindata12;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  wire   [31:0]                    epindata11;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  wire   [31:0]                    epindata10;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  wire   [31:0]                    epindata9;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  wire   [31:0]                    epindata8;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  wire   [31:0]                    epindata7;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  wire   [31:0]                    epindata6;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  wire   [31:0]                    epindata5;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  wire   [31:0]                    epindata4;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  wire   [31:0]                    epindata3;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  wire   [31:0]                    epindata2;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  wire   [31:0]                    epindata1;
  `endif

  wire   [15:0]                    fifofull_int;
  wire   [15:1]                    fifoafull_int;
  wire   [15:0]                    inbsyfall;
  wire   [15:0]                    hcepsuspendout;

  wire   [16*2-1:1*2]              isotogglein;
  wire   [1:0]                     isotogglein15;
  wire   [1:0]                     isotogglein14;
  wire   [1:0]                     isotogglein13;
  wire   [1:0]                     isotogglein12;
  wire   [1:0]                     isotogglein11;
  wire   [1:0]                     isotogglein10;
  wire   [1:0]                     isotogglein9;
  wire   [1:0]                     isotogglein8;
  wire   [1:0]                     isotogglein7;
  wire   [1:0]                     isotogglein6;
  wire   [1:0]                     isotogglein5;
  wire   [1:0]                     isotogglein4;
  wire   [1:0]                     isotogglein3;
  wire   [1:0]                     isotogglein2;
  wire   [1:0]                     isotogglein1;

  wire   [15:0]                    hcdopingout;
  wire   [15:1]                    hcdoisoout;

  wire   [16*4-1:0]                hcendpnrusbout;
  wire   [3:0]                     hcendpnrusbout15;
  wire   [3:0]                     hcendpnrusbout14;
  wire   [3:0]                     hcendpnrusbout13;
  wire   [3:0]                     hcendpnrusbout12;
  wire   [3:0]                     hcendpnrusbout11;
  wire   [3:0]                     hcendpnrusbout10;
  wire   [3:0]                     hcendpnrusbout9;
  wire   [3:0]                     hcendpnrusbout8;
  wire   [3:0]                     hcendpnrusbout7;
  wire   [3:0]                     hcendpnrusbout6;
  wire   [3:0]                     hcendpnrusbout5;
  wire   [3:0]                     hcendpnrusbout4;
  wire   [3:0]                     hcendpnrusbout3;
  wire   [3:0]                     hcendpnrusbout2;
  wire   [3:0]                     hcendpnrusbout1;
  wire   [3:0]                     hcendpnrusbout0;

  wire   [16*11-1:0]               hcinmaxpckusb;
  wire   [10:0]                    hcinmaxpckusb15;
  wire   [10:0]                    hcinmaxpckusb14;
  wire   [10:0]                    hcinmaxpckusb13;
  wire   [10:0]                    hcinmaxpckusb12;
  wire   [10:0]                    hcinmaxpckusb11;
  wire   [10:0]                    hcinmaxpckusb10;
  wire   [10:0]                    hcinmaxpckusb9;
  wire   [10:0]                    hcinmaxpckusb8;
  wire   [10:0]                    hcinmaxpckusb7;
  wire   [10:0]                    hcinmaxpckusb6;
  wire   [10:0]                    hcinmaxpckusb5;
  wire   [10:0]                    hcinmaxpckusb4;
  wire   [10:0]                    hcinmaxpckusb3;
  wire   [10:0]                    hcinmaxpckusb2;
  wire   [10:0]                    hcinmaxpckusb1;
  wire   [10:0]                    hcinmaxpckusb0;

  wire   [16*11-1:0]               hcoutmaxpckusb;
  wire   [10:0]                    hcoutmaxpckusb15;
  wire   [10:0]                    hcoutmaxpckusb14;
  wire   [10:0]                    hcoutmaxpckusb13;
  wire   [10:0]                    hcoutmaxpckusb12;
  wire   [10:0]                    hcoutmaxpckusb11;
  wire   [10:0]                    hcoutmaxpckusb10;
  wire   [10:0]                    hcoutmaxpckusb9;
  wire   [10:0]                    hcoutmaxpckusb8;
  wire   [10:0]                    hcoutmaxpckusb7;
  wire   [10:0]                    hcoutmaxpckusb6;
  wire   [10:0]                    hcoutmaxpckusb5;
  wire   [10:0]                    hcoutmaxpckusb4;
  wire   [10:0]                    hcoutmaxpckusb3;
  wire   [10:0]                    hcoutmaxpckusb2;
  wire   [10:0]                    hcoutmaxpckusb1;
  wire   [10:0]                    hcoutmaxpckusb0;

  wire   [15:0]                    hcnakidisout;
  wire   [15:0]                    hcerrirqout;
  wire   [15:0]                    hcepwaitout;


  wire                             sendzeroiso;
  wire                             clroutbsy;
  wire                             clrinbsy;
  wire                             sendhshk;
  wire                             sendpckt;
  wire                             sendtok;
  wire   [10:0]                    hctoken;
  wire                             receive;
  wire   [3:0]                     sendpid;
  wire                             dvi;
  wire                             settoken;
  wire                             settoken_irq;
  wire   [5:0]                     lpm_token_84;
  wire                             sigrsumclr;
  wire                             sigrsumclr_up;
  wire                             outpngirq;
  wire                             outpngirq_up;
  wire   [3:0]                     outpngirq_no;
  wire   [3:0]                     outpngirq_no_up;
  wire                             sofirq;
  wire                             sofirq_up;
  wire                             tokrcvfall;
  wire                             sudav;

  wire   [3:0]                     hcepnr;
  wire                             hcepdir;
  wire                             hcerrinc;
  wire                             hcerrclr;
  wire                             hcerrset;
  wire   [2:0]                     hcerrtype;
  wire                             hcepwaitclr;
  wire                             hcepwaitset;
  wire                             hcdevdopingset;
  wire                             hcdevdopingclr;
  wire                             enterhm;
  wire                             enterhmup;
  wire                             hcisostop;
  wire   [10:0]                    hcfrmcount;
  wire   [10:0]                    hcfrmcount_up;
  wire   [15:0]                    hcfrmnr;
  wire   [15:0]                    hcfrmnr_up;

  wire                             isosofpulse;
  wire                             isodump2k;
  wire                             isodump1k;
  wire                             isosofpulsereq;
  wire                             isosofpulserequp;
  wire                             isosofpulseup;

  wire                             sofpulse;
  wire                             hcsendsof;
  wire                             hcsendsof_up;

  wire                             enable;
  wire                             timeout;
  wire                             hsmode;
  wire                             hsmodeirq;
  wire                             hsmodeirq_up;


  wire                             txfiford;
  wire                             rxfifowr;
  wire                             overflowwr;
  wire   [6:0]                     tfnaddr;
  wire   [10:0]                    tfrmnr;
  wire   [10:0]                    tfrmnr_up;
  wire   [2:0]                     tfrmnrm;
  wire   [2:0]                     tfrmnrm_up;
  wire                             piderr;
  wire                             usberr;
  wire                             txfall;
  wire   [3:0]                     tendp;
  wire   [3:0]                     tendpnxt;
  wire   [4:0]                     pid;
  wire                             rcvfall;
  wire                             rxactiveff;
  wire                             rxtxidle;
  wire                             clrmfrmnr;
  wire                             hcsleep_ack;
  wire                             lpm_sleep_req;
  wire                             lpmirq_retry;

  wire                             busyff;
  wire                             tokenok;
  wire                             ince;
  wire   [8:0]                     lpm_token;
  wire                             utmitxvalidl;


  wire   [6:0]                     fnaddrusb;
  wire   [6:0]                     fnaddrup;
  wire                             ep0stall;
  wire   [31:0]                    ep0datao;
  wire                             ep0toggleout;
  wire                             ep0togglein;
  wire                             ep0datastage;
  wire                             hcdosetup;
  wire                             testmode;
  wire   [1:0]                     testmodesel;
  wire                             lpm_auto_entry;
  wire                             lpm_auto_entry_usb;


  wire                             lpm_nyet;
  wire                             lpm_nyet_usb;
  wire                             lpm_usbirq;
  wire                             lpm_usbirq_usb;
  wire   [15:1]                    inxisoautodump;
  wire   [15:1]                    inxisoautoarm;
  wire   [15:1]                    inxisodctrl;
  wire                             clrmfrmnrack;

  wire                             discon;
  wire                             discon_usb;
  wire                             sigrsum;
  wire                             sigrsum_usb;
  wire                             fifoaccrd;
  wire                             fifoaccwr;
  wire   [15:1]                    togglerstin;
  wire   [15:1]                    togglesetin;
  wire   [15:1]                    togglerstout;
  wire   [15:1]                    togglesetout;
  wire   [15:0]                    fiforstin;
  wire   [15:0]                    fiforstout;
  wire   [31:0]                    sfrdatao;

  wire                             suspendm_req;
  wire                             suspendm_req_usb;
  wire                             sleepm_req;
  wire                             sleepm_req_usb;

  wire   [15:0]                    sfrstoggleout;
  wire   [15:0]                    sfrstogglein;
  wire   [6:0]                     otgctrl;
  wire   [6:0]                     otgctrl_usb;
  wire   [7:0]                     otgforce;
  wire   [7:0]                     otgforce_usb;
  wire   [1:0]                     otg2ctrl;
  wire   [1:0]                     otg2ctrl_usb;
  wire   [7:0]                     tbvbuspls;
  wire   [7:0]                     tbvbuspls_usb;
  wire   [7:0]                     tbvbusdispls;
  wire   [7:0]                     tbvbusdispls_usb;
  wire   [7:0]                     tawaitbcon;
  wire   [7:0]                     tawaitbcon_usb;
  wire   [7:0]                     taaidlbdis;
  wire   [7:0]                     taaidlbdis_usb;

  wire                             usbrstsig;
  wire                             usbrstsig_usb;
  wire                             usbrstsig16ms;
  wire                             usbrstsig55ms;
  wire                             suspendm_en;
  wire                             suspendm_en_up;
  wire                             sleepm_en;
  wire                             sleepm_en_up;
  wire   [4:0]                     portctrltm;
  wire   [4:0]                     portctrltm_usb;

  wire   [1:0]                     linestate_up;

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  wire   [OUTADDRWIDTH-1:2]        out15startaddr;
  wire   [OUTADDRWIDTH-1:2]        out15startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  wire   [OUTADDRWIDTH-1:2]        out14startaddr;
  wire   [OUTADDRWIDTH-1:2]        out14startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  wire   [OUTADDRWIDTH-1:2]        out13startaddr;
  wire   [OUTADDRWIDTH-1:2]        out13startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  wire   [OUTADDRWIDTH-1:2]        out12startaddr;
  wire   [OUTADDRWIDTH-1:2]        out12startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  wire   [OUTADDRWIDTH-1:2]        out11startaddr;
  wire   [OUTADDRWIDTH-1:2]        out11startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  wire   [OUTADDRWIDTH-1:2]        out10startaddr;
  wire   [OUTADDRWIDTH-1:2]        out10startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  wire   [OUTADDRWIDTH-1:2]        out9startaddr;
  wire   [OUTADDRWIDTH-1:2]        out9startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  wire   [OUTADDRWIDTH-1:2]        out8startaddr;
  wire   [OUTADDRWIDTH-1:2]        out8startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  wire   [OUTADDRWIDTH-1:2]        out7startaddr;
  wire   [OUTADDRWIDTH-1:2]        out7startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  wire   [OUTADDRWIDTH-1:2]        out6startaddr;
  wire   [OUTADDRWIDTH-1:2]        out6startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  wire   [OUTADDRWIDTH-1:2]        out5startaddr;
  wire   [OUTADDRWIDTH-1:2]        out5startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  wire   [OUTADDRWIDTH-1:2]        out4startaddr;
  wire   [OUTADDRWIDTH-1:2]        out4startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  wire   [OUTADDRWIDTH-1:2]        out3startaddr;
  wire   [OUTADDRWIDTH-1:2]        out3startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  wire   [OUTADDRWIDTH-1:2]        out2startaddr;
  wire   [OUTADDRWIDTH-1:2]        out2startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  wire   [OUTADDRWIDTH-1:2]        out1startaddr;
  wire   [OUTADDRWIDTH-1:2]        out1startaddr_usb;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  wire   [INADDRWIDTH-1:2]         in15startaddr;
  wire   [INADDRWIDTH-1:2]         in15startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  wire   [INADDRWIDTH-1:2]         in14startaddr;
  wire   [INADDRWIDTH-1:2]         in14startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  wire   [INADDRWIDTH-1:2]         in13startaddr;
  wire   [INADDRWIDTH-1:2]         in13startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  wire   [INADDRWIDTH-1:2]         in12startaddr;
  wire   [INADDRWIDTH-1:2]         in12startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  wire   [INADDRWIDTH-1:2]         in11startaddr;
  wire   [INADDRWIDTH-1:2]         in11startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  wire   [INADDRWIDTH-1:2]         in10startaddr;
  wire   [INADDRWIDTH-1:2]         in10startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  wire   [INADDRWIDTH-1:2]         in9startaddr;
  wire   [INADDRWIDTH-1:2]         in9startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  wire   [INADDRWIDTH-1:2]         in8startaddr;
  wire   [INADDRWIDTH-1:2]         in8startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  wire   [INADDRWIDTH-1:2]         in7startaddr;
  wire   [INADDRWIDTH-1:2]         in7startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  wire   [INADDRWIDTH-1:2]         in6startaddr;
  wire   [INADDRWIDTH-1:2]         in6startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  wire   [INADDRWIDTH-1:2]         in5startaddr;
  wire   [INADDRWIDTH-1:2]         in5startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  wire   [INADDRWIDTH-1:2]         in4startaddr;
  wire   [INADDRWIDTH-1:2]         in4startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  wire   [INADDRWIDTH-1:2]         in3startaddr;
  wire   [INADDRWIDTH-1:2]         in3startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  wire   [INADDRWIDTH-1:2]         in2startaddr;
  wire   [INADDRWIDTH-1:2]         in2startaddr_usb;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  wire   [INADDRWIDTH-1:2]         in1startaddr;
  wire   [INADDRWIDTH-1:2]         in1startaddr_usb;
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  wire   [10:0]                    out15maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  wire   [10:0]                    out14maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  wire   [10:0]                    out13maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  wire   [10:0]                    out12maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  wire   [10:0]                    out11maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  wire   [10:0]                    out10maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  wire   [10:0]                    out9maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  wire   [10:0]                    out8maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  wire   [10:0]                    out7maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  wire   [10:0]                    out6maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  wire   [10:0]                    out5maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  wire   [10:0]                    out4maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  wire   [10:0]                    out3maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  wire   [10:0]                    out2maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  wire   [10:0]                    out1maxpck;
  `endif
  wire   [6:0]                     out0maxpck;

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  wire   [10:0]                    in15maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  wire   [10:0]                    in14maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  wire   [10:0]                    in13maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  wire   [10:0]                    in12maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  wire   [10:0]                    in11maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  wire   [10:0]                    in10maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  wire   [10:0]                    in9maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  wire   [10:0]                    in8maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  wire   [10:0]                    in7maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  wire   [10:0]                    in6maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  wire   [10:0]                    in5maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  wire   [10:0]                    in4maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  wire   [10:0]                    in3maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  wire   [10:0]                    in2maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  wire   [10:0]                    in1maxpck;
  `endif
  wire   [6:0]                     in0maxpck;


  wire   [15:1]                    outptrinc;
  wire                             fifooutrdff;


  wire                             lsmode;
  wire                             lsmode_up;
  wire                             drivechirpj;
  wire                             drivechirpk;
  wire                             downstren;
  wire                             upstren;
  wire                             usbreset;
  wire                             usbreset_up;
  wire                             usbresetirq;
  wire                             usbresetirq_up;
  wire                             resumereq;
  wire                             wakesrc;
  wire                             wakesrc_up;
  wire                             lpmirq;
  wire                             lpmirq_up;
  wire                             lpmstate;
  wire                             lpmstate_besl;
  wire                             sleepreq;
  wire                             suspreq;
  wire                             suspreq_up;
  wire                             wuiden;
  wire                             wudpen;
  wire                             wuvbusen;
  wire                             usbrstsigclr;
  wire                             usbrstsigclr_up;
  wire   [4:0]                     otgstate_usb;
  wire   [4:0]                     otgstate_up;
  wire   [7:0]                     otgstatus;
  wire   [7:0]                     otgstatus_up;
  wire                             idleirq;
  wire                             idleirq_up;
  wire                             srpdetirq;
  wire                             srpdetirq_up;
  wire                             locsofirq;
  wire                             locsofirq_up;
  wire                             vbuserrirq;
  wire                             vbuserrirq_up;
  wire                             periphirq;
  wire                             periphirq_up;
  wire                             idchangeirq;
  wire                             idchangeirq_up;
  wire                             hostdisconirq;
  wire                             hostdisconirq_up;
  wire                             bse0srpirq;
  wire                             bse0srpirq_up;
  wire                             clrbhnpen;
  wire                             clrbhnpen_up;
  wire                             hclocsof;
  wire                             busidle;
  wire                             bc_dmpulldown;
  wire                             bc_dmpulldown_usb;
  wire                             bc_dppulldown;
  wire                             bc_dppulldown_usb;
  wire                             bc_pulldownctrl;
  wire                             bc_pulldownctrl_usb;
  wire                       [4:0] adpbc_ctrl_0;
  wire                       [5:0] adpbc_ctrl_1;
  wire                       [7:0] adpbc_ctrl_2;

  wire                       [7:0] adpbc_status_0;
  wire                       [7:0] adpbc_status_1;
  wire                       [4:0] adpbc_status_2;
  wire                             adpbc_rid_float_fall;
  wire                             adpbc_rid_float_rise;
  wire                             adpbc_rid_gnd_rise;
  wire                             adpbc_rid_c_rise;
  wire                             adpbc_rid_b_rise;
  wire                             adpbc_rid_a_rise;
  wire                             adpbc_sessend_rise;
  wire                             adpbc_otgsessvalid_rise;
  wire                             adpbc_sense_rise;
  wire                             adpbc_probe_rise;
  wire                             dm_vdat_ref_rise;
  wire                             dp_vdat_ref_rise;
  wire                             dcd_comp_rise;
  wire                             dcd_comp_fall;
  wire                             dm_vlgc_comp_rise;

  wire                             adp_change_ack;
  wire                             adp_change_ack_up;

  wire                             cusb2_utmibvalid_up;
  wire                             cusb2_utmisessend_up;
  wire                       [1:0] cusb2_utmilinestate_up;

  wire                             cusb2_adp_probe_ana_up;
  wire                             cusb2_adp_sense_ana_up;
  wire                             cusb2_dcd_comp_sts_up;
  wire                             cusb2_dm_vdat_ref_comp_sts_up;
  wire                             cusb2_dm_vlgc_comp_sts_up;
  wire                             cusb2_dp_vdat_ref_comp_sts_up;
  wire                             cusb2_rid_a_comp_sts_up;
  wire                             cusb2_rid_b_comp_sts_up;
  wire                             cusb2_rid_c_comp_sts_up;
  wire                             cusb2_rid_float_comp_sts_up;
  wire                             cusb2_rid_gnd_comp_sts_up;

  wire                             sendstall;

  wire                             fifoctrl_7;

  wire                             utmihostdiscon;
  wire                             utmiiddig;
  wire                             utmivbusvalid;
  wire                             utmiavalid;
  wire                             utmibvalid;
  wire                             utmisessend;

  wire   [2:0]                     otgspeed;
  wire   [2:0]                     otgspeed_up;

  wire                             innak_usb;
  wire   [3:0]                     innak_no_usb;

  wire                             hsdisable;
  wire                             hsdisable_usb;
  wire                             wakeup_usb;

  wire                             sof_rcv_disable;
  wire                             sof_rcv_disable_usb;

  wire                             debug_rx_req;
  wire                             debug_rx_req_up;
  wire   [18:0]                    debug_rx;
  wire                             debug_tx_req;
  wire                             debug_tx_req_up;
  wire   [14:0]                    debug_tx;

  wire                             workaround_a_req;
  wire                             workaround_a_req_up;
  wire                             workaround_a_enable;
  wire                             workaround_a_enable_usb;
  wire                             workaround_b_enable;
  wire                             workaround_b_enable_usb;
  wire                             workaround_c_enable;
  wire                             workaround_c_enable_usb;
  wire                             workaround_d_enable;
  wire                             workaround_d_enable_usb;
  wire                             workaround_sfr_rst;
  wire                             workaround_sfr_rst_usb;
  wire   [3:0]                     workaround_a_value;
  wire   [3:0]                     workaround_a_value_usb;

  wire   [2:0]                     workaround_otg;
  wire   [2:0]                     workaround_otg_usb;

  wire                             wuintreq_up;
  wire                             vbusfault_up;

  wire                             outwr;
  wire   [7:0]                     outdatawr;

  wire                             inrd;
  wire   [7:0]                     indatard;

  wire   [15:1]                    dmasof_out;
  wire   [15:1]                    dmasof_in;

  wire   [5:0]                     hcnak_hshk;
  wire   [5:0]                     hcnak_hshk_usb;

  `ifdef CDNSUSB2PHY_3RD
  `else
  wire                             tsfr_rdata_req_up;
  `endif



  assign fifoinwait = fifoaccwr ;



  assign fifooutwait = fifoaccrd ;




  assign toggle_out = {toggle_out15, toggle_out14, toggle_out13,
                       toggle_out12, toggle_out11, toggle_out10,
                       toggle_out9,  toggle_out8,  toggle_out7,
                       toggle_out6,  toggle_out5,  toggle_out4,
                       toggle_out3,  toggle_out2,  toggle_out1} ;




  assign toggle_in  = {toggle_in15, toggle_in14, toggle_in13,
                       toggle_in12, toggle_in11, toggle_in10,
                       toggle_in9,  toggle_in8,  toggle_in7,
                       toggle_in6,  toggle_in5,  toggle_in4,
                       toggle_in3,  toggle_in2,  toggle_in1} ;




  assign eptype_out = {eptype_out15, eptype_out14, eptype_out13,
                       eptype_out12, eptype_out11, eptype_out10,
                       eptype_out9,  eptype_out8,  eptype_out7,
                       eptype_out6,  eptype_out5,  eptype_out4,
                       eptype_out3,  eptype_out2,  eptype_out1} ;




  assign episoout = {episoout15, episoout14, episoout13,
                     episoout12, episoout11, episoout10,
                     episoout9,  episoout8,  episoout7,
                     episoout6,  episoout5,  episoout4,
                     episoout3,  episoout2,  episoout1,
                     1'b0};




  assign eptype_in  = {eptype_in15, eptype_in14, eptype_in13,
                       eptype_in12, eptype_in11, eptype_in10,
                       eptype_in9,  eptype_in8,  eptype_in7,
                       eptype_in6,  eptype_in5,  eptype_in4,
                       eptype_in3,  eptype_in2,  eptype_in1} ;




  assign episoin = {episoin15, episoin14, episoin13,
                    episoin12, episoin11, episoin10,
                    episoin9,  episoin8,  episoin7,
                    episoin6,  episoin5,  episoin4,
                    episoin3,  episoin2,  episoin1,
                    1'b0};




  assign dvi_in  = {dvi_in15, dvi_in14, dvi_in13,
                    dvi_in12, dvi_in11, dvi_in10,
                    dvi_in9,  dvi_in8,  dvi_in7,
                    dvi_in6,  dvi_in5,  dvi_in4,
                    dvi_in3,  dvi_in2,  dvi_in1,
                    dvi_in0} ;



  assign fifooutmaxpck = {
                      `ifdef CDNSUSBHS_EPOUT_EXIST_15
                        out15maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_14
                        out14maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_13
                        out13maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_12
                        out12maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_11
                        out11maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_10
                        out10maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_9
                        out9maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_8
                        out8maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_7
                        out7maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_6
                        out6maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_5
                        out5maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_4
                        out4maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_3
                        out3maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_2
                        out2maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_1
                        out1maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                        4'h0, out0maxpck};



  assign fifoinmaxpck = {
                      `ifdef CDNSUSBHS_EPIN_EXIST_15
                        in15maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_14
                        in14maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_13
                        in13maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_12
                        in12maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_11
                        in11maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_10
                        in10maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_9
                        in9maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_8
                        in8maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_7
                        in7maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_6
                        in6maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_5
                        in5maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_4
                        in4maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_3
                        in3maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_2
                        in2maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_1
                        in1maxpck,
                      `else
                        11'b000_0000_0000,
                      `endif
                        4'h0, in0maxpck};



  assign isotogglein = {isotogglein15, isotogglein14, isotogglein13,
                        isotogglein12, isotogglein11, isotogglein10,
                        isotogglein9,  isotogglein8,  isotogglein7,
                        isotogglein6,  isotogglein5,  isotogglein4,
                        isotogglein3,  isotogglein2,  isotogglein1} ;



  assign hcendpnrusbout = {hcendpnrusbout15, hcendpnrusbout14, hcendpnrusbout13,
                           hcendpnrusbout12, hcendpnrusbout11, hcendpnrusbout10,
                           hcendpnrusbout9,  hcendpnrusbout8,  hcendpnrusbout7,
                           hcendpnrusbout6,  hcendpnrusbout5,  hcendpnrusbout4,
                           hcendpnrusbout3,  hcendpnrusbout2,  hcendpnrusbout1,
                           hcendpnrusbout0} ;



  assign hcendpnrusbin = {hcendpnrusbin15, hcendpnrusbin14, hcendpnrusbin13,
                          hcendpnrusbin12, hcendpnrusbin11, hcendpnrusbin10,
                          hcendpnrusbin9,  hcendpnrusbin8,  hcendpnrusbin7,
                          hcendpnrusbin6,  hcendpnrusbin5,  hcendpnrusbin4,
                          hcendpnrusbin3,  hcendpnrusbin2,  hcendpnrusbin1,
                          hcendpnrusbin0} ;



  assign hcinmaxpckusb = {hcinmaxpckusb15, hcinmaxpckusb14, hcinmaxpckusb13,
                          hcinmaxpckusb12, hcinmaxpckusb11, hcinmaxpckusb10,
                          hcinmaxpckusb9,  hcinmaxpckusb8,  hcinmaxpckusb7,
                          hcinmaxpckusb6,  hcinmaxpckusb5,  hcinmaxpckusb4,
                          hcinmaxpckusb3,  hcinmaxpckusb2,  hcinmaxpckusb1,
                          hcinmaxpckusb0} ;



  assign hcoutmaxpckusb = {hcoutmaxpckusb15, hcoutmaxpckusb14, hcoutmaxpckusb13,
                           hcoutmaxpckusb12, hcoutmaxpckusb11, hcoutmaxpckusb10,
                           hcoutmaxpckusb9,  hcoutmaxpckusb8,  hcoutmaxpckusb7,
                           hcoutmaxpckusb6,  hcoutmaxpckusb5,  hcoutmaxpckusb4,
                           hcoutmaxpckusb3,  hcoutmaxpckusb2,  hcoutmaxpckusb1,
                           hcoutmaxpckusb0} ;




  assign stallout[0] = ep0stall ;
  assign stallin[0]  = ep0stall ;




  assign inrd      = ince;




  assign hcendpnrusbout0 = hcendpnrusbin0 ;




  assign otgstate = otgstate_usb ;



  assign dmasof = {dmasof_in, 1'b0, dmasof_out, 1'b0};




  cdnsusbhs_ep0
  U_CDNSUSBHS_EP0
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .usbreset                           (usbreset),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clroutbsy                          (clroutbsy),
    .clrinbsy                           (clrinbsy),
    .pid                                (pid),
    .tokrcvfall                         (tokrcvfall),
    .settoken                           (settoken),
    .sudav                              (sudav),
    .lpm_token_84                       (lpm_token_84),
    .lpm_auto_entry                     (lpm_auto_entry),
    .fnaddrusb                          (fnaddrusb),
    .ep0stall                           (ep0stall),
    .ep0bufffull                        (bufffullout[0]),
    .ep0busyin                          (busyin[0]),
    .ep0busyout                         (busyout[0]),
    .ep0nxtbusyout                      (nxtbusyout[0]),
    .ep0togglein                        (ep0togglein),
    .ep0toggleout                       (ep0toggleout),
    .sfrep0togglein                     (sfrstogglein[0]),
    .sfrep0toggleout                    (sfrstoggleout[0]),
    .ep0datastage                       (ep0datastage),
    .usbresetup                         (usbreset_up),
    .disconusb                          (discon_usb),
    .discon                             (discon),
    .fnaddrup                           (fnaddrup),
    .outbsyfall                         (outbsyfall[0]),
    .inbsyfall                          (inbsyfall[0]),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .rd                                 (txfiford),
    .outdatawr                          (outdatawr),
    .txfall                             (txfall),
    .dvi                                (dvi_in0),
    .testmode                           (testmode),
    .testmodesel                        (testmodesel),
    .usbfifoptrwr                       (usbfifoptrwr0),
    .usbfifoptrrd                       (usbfifoptrrd0),
    .sendpckt                           (sendpckt),
    .sendstall                          (sendstall),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcsendsof                          (hcsendsof),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hclpmctrl                          (hclpmctrl),
    .hclpmctrlb                         (hclpmctrlb),
    .hcdolpm                            (hcdolpm),
    .sendtok                            (sendtok),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),
    .hcinepsuspend                      (hcepsuspendin[0]),
    .hcoutepsuspend                     (hcepsuspendout[0]),
    .hcendpnrusb                        (hcendpnrusbin0),
    .hcin0maxpckusb                     (hcinmaxpckusb0),
    .hcout0maxpckusb                    (hcoutmaxpckusb0),
    .hcinepwait                         (hcepwaitin[0]),
    .hcoutepwait                        (hcepwaitout[0]),
    .hcdoping                           (hcdopingout[0]),
    .hcdosetup                          (hcdosetup),
    .hcunderrien                        (hcunderrien[0]),
    .portctrltm                         (portctrltm_usb[3:0]),
    .hcinerrirq                         (hcerrirqin[0]),
    .hcouterrirq                        (hcerrirqout[0]),

    .out0maxpck                         (out0maxpck),

    .buf_enable                         (buf_enable_0),
    .epval                              (epvalout[0]),

    .fiforstin                          (fiforstin[0]),
    .fiforstout                         (fiforstout[0]),

    .fifoinendp                         (fifoinaddr),
    .fifoend                            (fifoinend),
    .fifowr                             (fifoinwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[0]),


    .fifooutendp                        (fifooutaddr),

    .fiford                             (fifooutrdff),
    .fifoempty                          (fifoempty_int[0]),

    .fifoacc                            (fifoaccwr),
    .fifobc                             (fifobc_int0),
    .upfifoptrwr                        (upfifoptrwr0),
    .upfifoptrrd                        (upfifoptrrd0),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .updatao                            (ep0datao),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[14:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3]),

    .hcnak_hshk                         (hcnak_hshk),

    .tmodecustom                        (tmodecustom),
    .tmodeselcustom                     (tmodeselcustom)
    );



  assign hcnakidisin[0]  = 1'b0 ;
  assign hcnakidisout[0] = 1'b0 ;









  `ifdef CDNSUSBHS_EPOUT_EXIST_15



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_15),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_15),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_15),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_15)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_15,
    `CDNSUSBHS_EPOUT_SIZE_15,
    `CDNSUSBHS_EPOUT_BUFFER_15,
    `CDNSUSBHS_EPOUT_BC_15
  `endif
    )
  U_CDNSUSBHS_EPOUT_15
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[15]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[15]),
    .eptype                             (eptype_out15),
    .episo                              (episoout15),
    .stall                              (stallout[15]),
    .busy                               (busyout[15]),
    .nxtbusy                            (nxtbusyout[15]),
    .epval                              (epvalout[15]),
    .sfrtoggle                          (sfrstoggleout[15]),
    .toggle                             (toggle_out15),
    .togglerst                          (togglerstout[15]),
    .toggleset                          (togglesetout[15]),
    .fiforst                            (fiforstout[15]),
    .hcunderrien                        (hcunderrien[15]),
    .hcnakidis                          (hcnakidisin[15]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[15]),
    .usbfifoptrwr                       (usbfifoptrwr15),
    .upfifoptrrd                        (upfifoptrrd15),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[15]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int15),
    .buf_enable                         (buf_enable_15),
    .hcepsuspend                        (hcepsuspendin[15]),
    .hcendpnrusb                        (hcendpnrusbin15),
    .hcinxmaxpckusb                     (hcinmaxpckusb15),
    .hcdoiso                            (hcdoisoin[15]),
    .hcepwait                           (hcepwaitin[15]),
    .hcerrirq                           (hcerrirqin[15]),

    .outxmaxpck                         (out15maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[15]),
    .updatao                            (epoutdata15),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[15]      = 1'b0 ;



  assign bufffullout[15]     = 1'b0 ;
  assign eptype_out15        = 2'b10 ;
  assign episoout15          = 1'b0 ;
  assign stallout[15]        = 1'b0 ;
  assign busyout[15]         = 1'b0 ;
  assign nxtbusyout[15]      = 1'b0 ;
  assign epvalout[15]        = 1'b0 ;
  assign hcunderrien[15]     = 1'b0 ;
  assign hcnakidisin[15]     = 1'b0 ;
  assign toggle_out15        = 2'b00 ;
  assign sfrstoggleout[15]   = 1'b0 ;



  assign outbsyfall[15]      = 1'b0 ;



  assign fifoempty_int[15]   = 1'b1 ;



  assign hcepsuspendin[15]   = 1'b0 ;
  assign hcendpnrusbin15     = {4{1'b0}} ;
  assign hcinmaxpckusb15     = {11{1'b0}} ;
  assign hcdoisoin[15]       = 1'b0 ;
  assign hcepwaitin[15]      = 1'b0 ;
  assign hcerrirqin[15]      = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPOUT_EXIST_14



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_14),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_14),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_14),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_14)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_14,
    `CDNSUSBHS_EPOUT_SIZE_14,
    `CDNSUSBHS_EPOUT_BUFFER_14,
    `CDNSUSBHS_EPOUT_BC_14
  `endif
    )
  U_CDNSUSBHS_EPOUT_14
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[14]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[14]),
    .eptype                             (eptype_out14),
    .episo                              (episoout14),
    .stall                              (stallout[14]),
    .busy                               (busyout[14]),
    .nxtbusy                            (nxtbusyout[14]),
    .epval                              (epvalout[14]),
    .sfrtoggle                          (sfrstoggleout[14]),
    .toggle                             (toggle_out14),
    .togglerst                          (togglerstout[14]),
    .toggleset                          (togglesetout[14]),
    .fiforst                            (fiforstout[14]),
    .hcunderrien                        (hcunderrien[14]),
    .hcnakidis                          (hcnakidisin[14]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[14]),
    .usbfifoptrwr                       (usbfifoptrwr14),
    .upfifoptrrd                        (upfifoptrrd14),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[14]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int14),
    .buf_enable                         (buf_enable_14),
    .hcepsuspend                        (hcepsuspendin[14]),
    .hcendpnrusb                        (hcendpnrusbin14),
    .hcinxmaxpckusb                     (hcinmaxpckusb14),
    .hcdoiso                            (hcdoisoin[14]),
    .hcepwait                           (hcepwaitin[14]),
    .hcerrirq                           (hcerrirqin[14]),

    .outxmaxpck                         (out14maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[14]),
    .updatao                            (epoutdata14),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[14]      = 1'b0 ;



  assign bufffullout[14]     = 1'b0 ;
  assign eptype_out14        = 2'b10 ;
  assign episoout14          = 1'b0 ;
  assign stallout[14]        = 1'b0 ;
  assign busyout[14]         = 1'b0 ;
  assign nxtbusyout[14]      = 1'b0 ;
  assign epvalout[14]        = 1'b0 ;
  assign hcunderrien[14]     = 1'b0 ;
  assign hcnakidisin[14]     = 1'b0 ;
  assign toggle_out14        = 2'b00 ;
  assign sfrstoggleout[14]   = 1'b0 ;



  assign outbsyfall[14]      = 1'b0 ;



  assign fifoempty_int[14]   = 1'b1 ;



  assign hcepsuspendin[14]   = 1'b0 ;
  assign hcendpnrusbin14     = {4{1'b0}} ;
  assign hcinmaxpckusb14     = {11{1'b0}} ;
  assign hcdoisoin[14]       = 1'b0 ;
  assign hcepwaitin[14]      = 1'b0 ;
  assign hcerrirqin[14]      = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPOUT_EXIST_13



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_13),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_13),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_13),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_13)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_13,
    `CDNSUSBHS_EPOUT_SIZE_13,
    `CDNSUSBHS_EPOUT_BUFFER_13,
    `CDNSUSBHS_EPOUT_BC_13
  `endif
    )
  U_CDNSUSBHS_EPOUT_13
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[13]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[13]),
    .eptype                             (eptype_out13),
    .episo                              (episoout13),
    .stall                              (stallout[13]),
    .busy                               (busyout[13]),
    .nxtbusy                            (nxtbusyout[13]),
    .epval                              (epvalout[13]),
    .sfrtoggle                          (sfrstoggleout[13]),
    .toggle                             (toggle_out13),
    .togglerst                          (togglerstout[13]),
    .toggleset                          (togglesetout[13]),
    .fiforst                            (fiforstout[13]),
    .hcunderrien                        (hcunderrien[13]),
    .hcnakidis                          (hcnakidisin[13]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[13]),
    .usbfifoptrwr                       (usbfifoptrwr13),
    .upfifoptrrd                        (upfifoptrrd13),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[13]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int13),
    .buf_enable                         (buf_enable_13),
    .hcepsuspend                        (hcepsuspendin[13]),
    .hcendpnrusb                        (hcendpnrusbin13),
    .hcinxmaxpckusb                     (hcinmaxpckusb13),
    .hcdoiso                            (hcdoisoin[13]),
    .hcepwait                           (hcepwaitin[13]),
    .hcerrirq                           (hcerrirqin[13]),

    .outxmaxpck                         (out13maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[13]),
    .updatao                            (epoutdata13),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[13]      = 1'b0 ;



  assign bufffullout[13]     = 1'b0 ;
  assign eptype_out13        = 2'b10 ;
  assign episoout13          = 1'b0 ;
  assign stallout[13]        = 1'b0 ;
  assign busyout[13]         = 1'b0 ;
  assign nxtbusyout[13]      = 1'b0 ;
  assign epvalout[13]        = 1'b0 ;
  assign hcunderrien[13]     = 1'b0 ;
  assign hcnakidisin[13]     = 1'b0 ;
  assign toggle_out13        = 2'b00 ;
  assign sfrstoggleout[13]   = 1'b0 ;



  assign outbsyfall[13]      = 1'b0 ;



  assign fifoempty_int[13]   = 1'b1 ;



  assign hcepsuspendin[13]   = 1'b0 ;
  assign hcendpnrusbin13     = {4{1'b0}} ;
  assign hcinmaxpckusb13     = {11{1'b0}} ;
  assign hcdoisoin[13]       = 1'b0 ;
  assign hcepwaitin[13]      = 1'b0 ;
  assign hcerrirqin[13]      = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPOUT_EXIST_12



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_12),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_12),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_12),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_12)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_12,
    `CDNSUSBHS_EPOUT_SIZE_12,
    `CDNSUSBHS_EPOUT_BUFFER_12,
    `CDNSUSBHS_EPOUT_BC_12
  `endif
    )
  U_CDNSUSBHS_EPOUT_12
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[12]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[12]),
    .eptype                             (eptype_out12),
    .episo                              (episoout12),
    .stall                              (stallout[12]),
    .busy                               (busyout[12]),
    .nxtbusy                            (nxtbusyout[12]),
    .epval                              (epvalout[12]),
    .sfrtoggle                          (sfrstoggleout[12]),
    .toggle                             (toggle_out12),
    .togglerst                          (togglerstout[12]),
    .toggleset                          (togglesetout[12]),
    .fiforst                            (fiforstout[12]),
    .hcunderrien                        (hcunderrien[12]),
    .hcnakidis                          (hcnakidisin[12]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[12]),
    .usbfifoptrwr                       (usbfifoptrwr12),
    .upfifoptrrd                        (upfifoptrrd12),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[12]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int12),
    .buf_enable                         (buf_enable_12),
    .hcepsuspend                        (hcepsuspendin[12]),
    .hcendpnrusb                        (hcendpnrusbin12),
    .hcinxmaxpckusb                     (hcinmaxpckusb12),
    .hcdoiso                            (hcdoisoin[12]),
    .hcepwait                           (hcepwaitin[12]),
    .hcerrirq                           (hcerrirqin[12]),

    .outxmaxpck                         (out12maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[12]),
    .updatao                            (epoutdata12),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[12]      = 1'b0 ;



  assign bufffullout[12]     = 1'b0 ;
  assign eptype_out12        = 2'b10 ;
  assign episoout12          = 1'b0 ;
  assign stallout[12]        = 1'b0 ;
  assign busyout[12]         = 1'b0 ;
  assign nxtbusyout[12]      = 1'b0 ;
  assign epvalout[12]        = 1'b0 ;
  assign hcunderrien[12]     = 1'b0 ;
  assign hcnakidisin[12]     = 1'b0 ;
  assign toggle_out12        = 2'b00 ;
  assign sfrstoggleout[12]   = 1'b0 ;



  assign outbsyfall[12]      = 1'b0 ;



  assign fifoempty_int[12]   = 1'b1 ;



  assign hcepsuspendin[12]   = 1'b0 ;
  assign hcendpnrusbin12     = {4{1'b0}} ;
  assign hcinmaxpckusb12     = {11{1'b0}} ;
  assign hcdoisoin[12]       = 1'b0 ;
  assign hcepwaitin[12]      = 1'b0 ;
  assign hcerrirqin[12]      = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPOUT_EXIST_11



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_11),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_11),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_11),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_11)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_11,
    `CDNSUSBHS_EPOUT_SIZE_11,
    `CDNSUSBHS_EPOUT_BUFFER_11,
    `CDNSUSBHS_EPOUT_BC_11
  `endif
    )
  U_CDNSUSBHS_EPOUT_11
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[11]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[11]),
    .eptype                             (eptype_out11),
    .episo                              (episoout11),
    .stall                              (stallout[11]),
    .busy                               (busyout[11]),
    .nxtbusy                            (nxtbusyout[11]),
    .epval                              (epvalout[11]),
    .sfrtoggle                          (sfrstoggleout[11]),
    .toggle                             (toggle_out11),
    .togglerst                          (togglerstout[11]),
    .toggleset                          (togglesetout[11]),
    .fiforst                            (fiforstout[11]),
    .hcunderrien                        (hcunderrien[11]),
    .hcnakidis                          (hcnakidisin[11]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[11]),
    .usbfifoptrwr                       (usbfifoptrwr11),
    .upfifoptrrd                        (upfifoptrrd11),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[11]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int11),
    .buf_enable                         (buf_enable_11),
    .hcepsuspend                        (hcepsuspendin[11]),
    .hcendpnrusb                        (hcendpnrusbin11),
    .hcinxmaxpckusb                     (hcinmaxpckusb11),
    .hcdoiso                            (hcdoisoin[11]),
    .hcepwait                           (hcepwaitin[11]),
    .hcerrirq                           (hcerrirqin[11]),

    .outxmaxpck                         (out11maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[11]),
    .updatao                            (epoutdata11),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[11]      = 1'b0 ;



  assign bufffullout[11]     = 1'b0 ;
  assign eptype_out11        = 2'b10 ;
  assign episoout11          = 1'b0 ;
  assign stallout[11]        = 1'b0 ;
  assign busyout[11]         = 1'b0 ;
  assign nxtbusyout[11]      = 1'b0 ;
  assign epvalout[11]        = 1'b0 ;
  assign hcunderrien[11]     = 1'b0 ;
  assign hcnakidisin[11]     = 1'b0 ;
  assign toggle_out11        = 2'b00 ;
  assign sfrstoggleout[11]   = 1'b0 ;



  assign outbsyfall[11]      = 1'b0 ;



  assign fifoempty_int[11]   = 1'b1 ;



  assign hcepsuspendin[11]   = 1'b0 ;
  assign hcendpnrusbin11     = {4{1'b0}} ;
  assign hcinmaxpckusb11     = {11{1'b0}} ;
  assign hcdoisoin[11]       = 1'b0 ;
  assign hcepwaitin[11]      = 1'b0 ;
  assign hcerrirqin[11]      = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPOUT_EXIST_10



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_10),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_10),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_10),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_10)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_10,
    `CDNSUSBHS_EPOUT_SIZE_10,
    `CDNSUSBHS_EPOUT_BUFFER_10,
    `CDNSUSBHS_EPOUT_BC_10
  `endif
    )
  U_CDNSUSBHS_EPOUT_10
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[10]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[10]),
    .eptype                             (eptype_out10),
    .episo                              (episoout10),
    .stall                              (stallout[10]),
    .busy                               (busyout[10]),
    .nxtbusy                            (nxtbusyout[10]),
    .epval                              (epvalout[10]),
    .sfrtoggle                          (sfrstoggleout[10]),
    .toggle                             (toggle_out10),
    .togglerst                          (togglerstout[10]),
    .toggleset                          (togglesetout[10]),
    .fiforst                            (fiforstout[10]),
    .hcunderrien                        (hcunderrien[10]),
    .hcnakidis                          (hcnakidisin[10]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[10]),
    .usbfifoptrwr                       (usbfifoptrwr10),
    .upfifoptrrd                        (upfifoptrrd10),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[10]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int10),
    .buf_enable                         (buf_enable_10),
    .hcepsuspend                        (hcepsuspendin[10]),
    .hcendpnrusb                        (hcendpnrusbin10),
    .hcinxmaxpckusb                     (hcinmaxpckusb10),
    .hcdoiso                            (hcdoisoin[10]),
    .hcepwait                           (hcepwaitin[10]),
    .hcerrirq                           (hcerrirqin[10]),

    .outxmaxpck                         (out10maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[10]),
    .updatao                            (epoutdata10),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[10]      = 1'b0 ;



  assign bufffullout[10]     = 1'b0 ;
  assign eptype_out10        = 2'b10 ;
  assign episoout10          = 1'b0 ;
  assign stallout[10]        = 1'b0 ;
  assign busyout[10]         = 1'b0 ;
  assign nxtbusyout[10]      = 1'b0 ;
  assign epvalout[10]        = 1'b0 ;
  assign hcunderrien[10]     = 1'b0 ;
  assign hcnakidisin[10]     = 1'b0 ;
  assign toggle_out10        = 2'b00 ;
  assign sfrstoggleout[10]   = 1'b0 ;



  assign outbsyfall[10]      = 1'b0 ;



  assign fifoempty_int[10]   = 1'b1 ;



  assign hcepsuspendin[10]   = 1'b0 ;
  assign hcendpnrusbin10     = {4{1'b0}} ;
  assign hcinmaxpckusb10     = {11{1'b0}} ;
  assign hcdoisoin[10]       = 1'b0 ;
  assign hcepwaitin[10]      = 1'b0 ;
  assign hcerrirqin[10]      = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPOUT_EXIST_9



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_9),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_9),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_9),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_9)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_9,
    `CDNSUSBHS_EPOUT_SIZE_9,
    `CDNSUSBHS_EPOUT_BUFFER_9,
    `CDNSUSBHS_EPOUT_BC_9
  `endif
    )
  U_CDNSUSBHS_EPOUT_9
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[9]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[9]),
    .eptype                             (eptype_out9),
    .episo                              (episoout9),
    .stall                              (stallout[9]),
    .busy                               (busyout[9]),
    .nxtbusy                            (nxtbusyout[9]),
    .epval                              (epvalout[9]),
    .sfrtoggle                          (sfrstoggleout[9]),
    .toggle                             (toggle_out9),
    .togglerst                          (togglerstout[9]),
    .toggleset                          (togglesetout[9]),
    .fiforst                            (fiforstout[9]),
    .hcunderrien                        (hcunderrien[9]),
    .hcnakidis                          (hcnakidisin[9]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[9]),
    .usbfifoptrwr                       (usbfifoptrwr9),
    .upfifoptrrd                        (upfifoptrrd9),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[9]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int9),
    .buf_enable                         (buf_enable_9),
    .hcepsuspend                        (hcepsuspendin[9]),
    .hcendpnrusb                        (hcendpnrusbin9),
    .hcinxmaxpckusb                     (hcinmaxpckusb9),
    .hcdoiso                            (hcdoisoin[9]),
    .hcepwait                           (hcepwaitin[9]),
    .hcerrirq                           (hcerrirqin[9]),

    .outxmaxpck                         (out9maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[9]),
    .updatao                            (epoutdata9),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[9]       = 1'b0 ;



  assign bufffullout[9]      = 1'b0 ;
  assign eptype_out9         = 2'b10 ;
  assign episoout9           = 1'b0 ;
  assign stallout[9]         = 1'b0 ;
  assign busyout[9]          = 1'b0 ;
  assign nxtbusyout[9]       = 1'b0 ;
  assign epvalout[9]         = 1'b0 ;
  assign hcunderrien[9]      = 1'b0 ;
  assign hcnakidisin[9]      = 1'b0 ;
  assign toggle_out9         = 2'b00 ;
  assign sfrstoggleout[9]    = 1'b0 ;



  assign outbsyfall[9]       = 1'b0 ;



  assign fifoempty_int[9]    = 1'b1 ;



  assign hcepsuspendin[9]    = 1'b0 ;
  assign hcendpnrusbin9      = {4{1'b0}} ;
  assign hcinmaxpckusb9      = {11{1'b0}} ;
  assign hcdoisoin[9]        = 1'b0 ;
  assign hcepwaitin[9]       = 1'b0 ;
  assign hcerrirqin[9]       = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPOUT_EXIST_8



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_8),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_8),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_8),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_8)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_8,
    `CDNSUSBHS_EPOUT_SIZE_8,
    `CDNSUSBHS_EPOUT_BUFFER_8,
    `CDNSUSBHS_EPOUT_BC_8
  `endif
    )
  U_CDNSUSBHS_EPOUT_8
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[8]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[8]),
    .eptype                             (eptype_out8),
    .episo                              (episoout8),
    .stall                              (stallout[8]),
    .busy                               (busyout[8]),
    .nxtbusy                            (nxtbusyout[8]),
    .epval                              (epvalout[8]),
    .sfrtoggle                          (sfrstoggleout[8]),
    .toggle                             (toggle_out8),
    .togglerst                          (togglerstout[8]),
    .toggleset                          (togglesetout[8]),
    .fiforst                            (fiforstout[8]),
    .hcunderrien                        (hcunderrien[8]),
    .hcnakidis                          (hcnakidisin[8]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[8]),
    .usbfifoptrwr                       (usbfifoptrwr8),
    .upfifoptrrd                        (upfifoptrrd8),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[8]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int8),
    .buf_enable                         (buf_enable_8),
    .hcepsuspend                        (hcepsuspendin[8]),
    .hcendpnrusb                        (hcendpnrusbin8),
    .hcinxmaxpckusb                     (hcinmaxpckusb8),
    .hcdoiso                            (hcdoisoin[8]),
    .hcepwait                           (hcepwaitin[8]),
    .hcerrirq                           (hcerrirqin[8]),

    .outxmaxpck                         (out8maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[8]),
    .updatao                            (epoutdata8),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[8]       = 1'b0 ;



  assign bufffullout[8]      = 1'b0 ;
  assign eptype_out8         = 2'b10 ;
  assign episoout8           = 1'b0 ;
  assign stallout[8]         = 1'b0 ;
  assign busyout[8]          = 1'b0 ;
  assign nxtbusyout[8]       = 1'b0 ;
  assign epvalout[8]         = 1'b0 ;
  assign hcunderrien[8]      = 1'b0 ;
  assign hcnakidisin[8]      = 1'b0 ;
  assign toggle_out8         = 2'b00 ;
  assign sfrstoggleout[8]    = 1'b0 ;



  assign outbsyfall[8]       = 1'b0 ;



  assign fifoempty_int[8]    = 1'b1 ;



  assign hcepsuspendin[8]    = 1'b0 ;
  assign hcendpnrusbin8      = {4{1'b0}} ;
  assign hcinmaxpckusb8      = {11{1'b0}} ;
  assign hcdoisoin[8]        = 1'b0 ;
  assign hcepwaitin[8]       = 1'b0 ;
  assign hcerrirqin[8]       = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPOUT_EXIST_7



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_7),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_7),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_7),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_7)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_7,
    `CDNSUSBHS_EPOUT_SIZE_7,
    `CDNSUSBHS_EPOUT_BUFFER_7,
    `CDNSUSBHS_EPOUT_BC_7
  `endif
    )
  U_CDNSUSBHS_EPOUT_7
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[7]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[7]),
    .eptype                             (eptype_out7),
    .episo                              (episoout7),
    .stall                              (stallout[7]),
    .busy                               (busyout[7]),
    .nxtbusy                            (nxtbusyout[7]),
    .epval                              (epvalout[7]),
    .sfrtoggle                          (sfrstoggleout[7]),
    .toggle                             (toggle_out7),
    .togglerst                          (togglerstout[7]),
    .toggleset                          (togglesetout[7]),
    .fiforst                            (fiforstout[7]),
    .hcunderrien                        (hcunderrien[7]),
    .hcnakidis                          (hcnakidisin[7]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[7]),
    .usbfifoptrwr                       (usbfifoptrwr7),
    .upfifoptrrd                        (upfifoptrrd7),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[7]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int7),
    .buf_enable                         (buf_enable_7),
    .hcepsuspend                        (hcepsuspendin[7]),
    .hcendpnrusb                        (hcendpnrusbin7),
    .hcinxmaxpckusb                     (hcinmaxpckusb7),
    .hcdoiso                            (hcdoisoin[7]),
    .hcepwait                           (hcepwaitin[7]),
    .hcerrirq                           (hcerrirqin[7]),

    .outxmaxpck                         (out7maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[7]),
    .updatao                            (epoutdata7),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[7]       = 1'b0 ;



  assign bufffullout[7]      = 1'b0 ;
  assign eptype_out7         = 2'b10 ;
  assign episoout7           = 1'b0 ;
  assign stallout[7]         = 1'b0 ;
  assign busyout[7]          = 1'b0 ;
  assign nxtbusyout[7]       = 1'b0 ;
  assign epvalout[7]         = 1'b0 ;
  assign hcunderrien[7]      = 1'b0 ;
  assign hcnakidisin[7]      = 1'b0 ;
  assign toggle_out7         = 2'b00 ;
  assign sfrstoggleout[7]    = 1'b0 ;



  assign outbsyfall[7]       = 1'b0 ;



  assign fifoempty_int[7]    = 1'b1 ;



  assign hcepsuspendin[7]    = 1'b0 ;
  assign hcendpnrusbin7      = {4{1'b0}} ;
  assign hcinmaxpckusb7      = {11{1'b0}} ;
  assign hcdoisoin[7]        = 1'b0 ;
  assign hcepwaitin[7]       = 1'b0 ;
  assign hcerrirqin[7]       = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPOUT_EXIST_6



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_6),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_6),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_6),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_6)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_6,
    `CDNSUSBHS_EPOUT_SIZE_6,
    `CDNSUSBHS_EPOUT_BUFFER_6,
    `CDNSUSBHS_EPOUT_BC_6
  `endif
    )
  U_CDNSUSBHS_EPOUT_6
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[6]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[6]),
    .eptype                             (eptype_out6),
    .episo                              (episoout6),
    .stall                              (stallout[6]),
    .busy                               (busyout[6]),
    .nxtbusy                            (nxtbusyout[6]),
    .epval                              (epvalout[6]),
    .sfrtoggle                          (sfrstoggleout[6]),
    .toggle                             (toggle_out6),
    .togglerst                          (togglerstout[6]),
    .toggleset                          (togglesetout[6]),
    .fiforst                            (fiforstout[6]),
    .hcunderrien                        (hcunderrien[6]),
    .hcnakidis                          (hcnakidisin[6]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[6]),
    .usbfifoptrwr                       (usbfifoptrwr6),
    .upfifoptrrd                        (upfifoptrrd6),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[6]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int6),
    .buf_enable                         (buf_enable_6),
    .hcepsuspend                        (hcepsuspendin[6]),
    .hcendpnrusb                        (hcendpnrusbin6),
    .hcinxmaxpckusb                     (hcinmaxpckusb6),
    .hcdoiso                            (hcdoisoin[6]),
    .hcepwait                           (hcepwaitin[6]),
    .hcerrirq                           (hcerrirqin[6]),

    .outxmaxpck                         (out6maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[6]),
    .updatao                            (epoutdata6),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[6]       = 1'b0 ;



  assign bufffullout[6]      = 1'b0 ;
  assign eptype_out6         = 2'b10 ;
  assign episoout6           = 1'b0 ;
  assign stallout[6]         = 1'b0 ;
  assign busyout[6]          = 1'b0 ;
  assign nxtbusyout[6]       = 1'b0 ;
  assign epvalout[6]         = 1'b0 ;
  assign hcunderrien[6]      = 1'b0 ;
  assign hcnakidisin[6]      = 1'b0 ;
  assign toggle_out6         = 2'b00 ;
  assign sfrstoggleout[6]    = 1'b0 ;



  assign outbsyfall[6]       = 1'b0 ;



  assign fifoempty_int[6]    = 1'b1 ;



  assign hcepsuspendin[6]    = 1'b0 ;
  assign hcendpnrusbin6      = {4{1'b0}} ;
  assign hcinmaxpckusb6      = {11{1'b0}} ;
  assign hcdoisoin[6]        = 1'b0 ;
  assign hcepwaitin[6]       = 1'b0 ;
  assign hcerrirqin[6]       = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPOUT_EXIST_5



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_5),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_5),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_5),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_5)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_5,
    `CDNSUSBHS_EPOUT_SIZE_5,
    `CDNSUSBHS_EPOUT_BUFFER_5,
    `CDNSUSBHS_EPOUT_BC_5
  `endif
    )
  U_CDNSUSBHS_EPOUT_5
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[5]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[5]),
    .eptype                             (eptype_out5),
    .episo                              (episoout5),
    .stall                              (stallout[5]),
    .busy                               (busyout[5]),
    .nxtbusy                            (nxtbusyout[5]),
    .epval                              (epvalout[5]),
    .sfrtoggle                          (sfrstoggleout[5]),
    .toggle                             (toggle_out5),
    .togglerst                          (togglerstout[5]),
    .toggleset                          (togglesetout[5]),
    .fiforst                            (fiforstout[5]),
    .hcunderrien                        (hcunderrien[5]),
    .hcnakidis                          (hcnakidisin[5]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[5]),
    .usbfifoptrwr                       (usbfifoptrwr5),
    .upfifoptrrd                        (upfifoptrrd5),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[5]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int5),
    .buf_enable                         (buf_enable_5),
    .hcepsuspend                        (hcepsuspendin[5]),
    .hcendpnrusb                        (hcendpnrusbin5),
    .hcinxmaxpckusb                     (hcinmaxpckusb5),
    .hcdoiso                            (hcdoisoin[5]),
    .hcepwait                           (hcepwaitin[5]),
    .hcerrirq                           (hcerrirqin[5]),

    .outxmaxpck                         (out5maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[5]),
    .updatao                            (epoutdata5),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[5]       = 1'b0 ;



  assign bufffullout[5]      = 1'b0 ;
  assign eptype_out5         = 2'b10 ;
  assign episoout5           = 1'b0 ;
  assign stallout[5]         = 1'b0 ;
  assign busyout[5]          = 1'b0 ;
  assign nxtbusyout[5]       = 1'b0 ;
  assign epvalout[5]         = 1'b0 ;
  assign hcunderrien[5]      = 1'b0 ;
  assign hcnakidisin[5]      = 1'b0 ;
  assign toggle_out5         = 2'b00 ;
  assign sfrstoggleout[5]    = 1'b0 ;



  assign outbsyfall[5]       = 1'b0 ;



  assign fifoempty_int[5]    = 1'b1 ;



  assign hcepsuspendin[5]    = 1'b0 ;
  assign hcendpnrusbin5      = {4{1'b0}} ;
  assign hcinmaxpckusb5      = {11{1'b0}} ;
  assign hcdoisoin[5]        = 1'b0 ;
  assign hcepwaitin[5]       = 1'b0 ;
  assign hcerrirqin[5]       = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPOUT_EXIST_4



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_4),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_4),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_4),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_4)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_4,
    `CDNSUSBHS_EPOUT_SIZE_4,
    `CDNSUSBHS_EPOUT_BUFFER_4,
    `CDNSUSBHS_EPOUT_BC_4
  `endif
    )
  U_CDNSUSBHS_EPOUT_4
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[4]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[4]),
    .eptype                             (eptype_out4),
    .episo                              (episoout4),
    .stall                              (stallout[4]),
    .busy                               (busyout[4]),
    .nxtbusy                            (nxtbusyout[4]),
    .epval                              (epvalout[4]),
    .sfrtoggle                          (sfrstoggleout[4]),
    .toggle                             (toggle_out4),
    .togglerst                          (togglerstout[4]),
    .toggleset                          (togglesetout[4]),
    .fiforst                            (fiforstout[4]),
    .hcunderrien                        (hcunderrien[4]),
    .hcnakidis                          (hcnakidisin[4]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[4]),
    .usbfifoptrwr                       (usbfifoptrwr4),
    .upfifoptrrd                        (upfifoptrrd4),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[4]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int4),
    .buf_enable                         (buf_enable_4),
    .hcepsuspend                        (hcepsuspendin[4]),
    .hcendpnrusb                        (hcendpnrusbin4),
    .hcinxmaxpckusb                     (hcinmaxpckusb4),
    .hcdoiso                            (hcdoisoin[4]),
    .hcepwait                           (hcepwaitin[4]),
    .hcerrirq                           (hcerrirqin[4]),

    .outxmaxpck                         (out4maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[4]),
    .updatao                            (epoutdata4),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[4]       = 1'b0 ;



  assign bufffullout[4]      = 1'b0 ;
  assign eptype_out4         = 2'b10 ;
  assign episoout4           = 1'b0 ;
  assign stallout[4]         = 1'b0 ;
  assign busyout[4]          = 1'b0 ;
  assign nxtbusyout[4]       = 1'b0 ;
  assign epvalout[4]         = 1'b0 ;
  assign hcunderrien[4]      = 1'b0 ;
  assign hcnakidisin[4]      = 1'b0 ;
  assign toggle_out4         = 2'b00 ;
  assign sfrstoggleout[4]    = 1'b0 ;



  assign outbsyfall[4]       = 1'b0 ;



  assign fifoempty_int[4]    = 1'b1 ;



  assign hcepsuspendin[4]    = 1'b0 ;
  assign hcendpnrusbin4      = {4{1'b0}} ;
  assign hcinmaxpckusb4      = {11{1'b0}} ;
  assign hcdoisoin[4]        = 1'b0 ;
  assign hcepwaitin[4]       = 1'b0 ;
  assign hcerrirqin[4]       = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPOUT_EXIST_3



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_3),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_3),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_3),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_3)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_3,
    `CDNSUSBHS_EPOUT_SIZE_3,
    `CDNSUSBHS_EPOUT_BUFFER_3,
    `CDNSUSBHS_EPOUT_BC_3
  `endif
    )
  U_CDNSUSBHS_EPOUT_3
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[3]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[3]),
    .eptype                             (eptype_out3),
    .episo                              (episoout3),
    .stall                              (stallout[3]),
    .busy                               (busyout[3]),
    .nxtbusy                            (nxtbusyout[3]),
    .epval                              (epvalout[3]),
    .sfrtoggle                          (sfrstoggleout[3]),
    .toggle                             (toggle_out3),
    .togglerst                          (togglerstout[3]),
    .toggleset                          (togglesetout[3]),
    .fiforst                            (fiforstout[3]),
    .hcunderrien                        (hcunderrien[3]),
    .hcnakidis                          (hcnakidisin[3]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[3]),
    .usbfifoptrwr                       (usbfifoptrwr3),
    .upfifoptrrd                        (upfifoptrrd3),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[3]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int3),
    .buf_enable                         (buf_enable_3),
    .hcepsuspend                        (hcepsuspendin[3]),
    .hcendpnrusb                        (hcendpnrusbin3),
    .hcinxmaxpckusb                     (hcinmaxpckusb3),
    .hcdoiso                            (hcdoisoin[3]),
    .hcepwait                           (hcepwaitin[3]),
    .hcerrirq                           (hcerrirqin[3]),

    .outxmaxpck                         (out3maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[3]),
    .updatao                            (epoutdata3),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[3]       = 1'b0 ;



  assign bufffullout[3]      = 1'b0 ;
  assign eptype_out3         = 2'b10 ;
  assign episoout3           = 1'b0 ;
  assign stallout[3]         = 1'b0 ;
  assign busyout[3]          = 1'b0 ;
  assign nxtbusyout[3]       = 1'b0 ;
  assign epvalout[3]         = 1'b0 ;
  assign hcunderrien[3]      = 1'b0 ;
  assign hcnakidisin[3]      = 1'b0 ;
  assign toggle_out3         = 2'b00 ;
  assign sfrstoggleout[3]    = 1'b0 ;



  assign outbsyfall[3]       = 1'b0 ;



  assign fifoempty_int[3]    = 1'b1 ;



  assign hcepsuspendin[3]    = 1'b0 ;
  assign hcendpnrusbin3      = {4{1'b0}} ;
  assign hcinmaxpckusb3      = {11{1'b0}} ;
  assign hcdoisoin[3]        = 1'b0 ;
  assign hcepwaitin[3]       = 1'b0 ;
  assign hcerrirqin[3]       = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPOUT_EXIST_2



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_2),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_2),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_2),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_2)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_2,
    `CDNSUSBHS_EPOUT_SIZE_2,
    `CDNSUSBHS_EPOUT_BUFFER_2,
    `CDNSUSBHS_EPOUT_BC_2
  `endif
    )
  U_CDNSUSBHS_EPOUT_2
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[2]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[2]),
    .eptype                             (eptype_out2),
    .episo                              (episoout2),
    .stall                              (stallout[2]),
    .busy                               (busyout[2]),
    .nxtbusy                            (nxtbusyout[2]),
    .epval                              (epvalout[2]),
    .sfrtoggle                          (sfrstoggleout[2]),
    .toggle                             (toggle_out2),
    .togglerst                          (togglerstout[2]),
    .toggleset                          (togglesetout[2]),
    .fiforst                            (fiforstout[2]),
    .hcunderrien                        (hcunderrien[2]),
    .hcnakidis                          (hcnakidisin[2]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[2]),
    .usbfifoptrwr                       (usbfifoptrwr2),
    .upfifoptrrd                        (upfifoptrrd2),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[2]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int2),
    .buf_enable                         (buf_enable_2),
    .hcepsuspend                        (hcepsuspendin[2]),
    .hcendpnrusb                        (hcendpnrusbin2),
    .hcinxmaxpckusb                     (hcinmaxpckusb2),
    .hcdoiso                            (hcdoisoin[2]),
    .hcepwait                           (hcepwaitin[2]),
    .hcerrirq                           (hcerrirqin[2]),

    .outxmaxpck                         (out2maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[2]),
    .updatao                            (epoutdata2),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[2]       = 1'b0 ;



  assign bufffullout[2]      = 1'b0 ;
  assign eptype_out2         = 2'b10 ;
  assign episoout2           = 1'b0 ;
  assign stallout[2]         = 1'b0 ;
  assign busyout[2]          = 1'b0 ;
  assign nxtbusyout[2]       = 1'b0 ;
  assign epvalout[2]         = 1'b0 ;
  assign hcunderrien[2]      = 1'b0 ;
  assign hcnakidisin[2]      = 1'b0 ;
  assign toggle_out2         = 2'b00 ;
  assign sfrstoggleout[2]    = 1'b0 ;



  assign outbsyfall[2]       = 1'b0 ;



  assign fifoempty_int[2]    = 1'b1 ;



  assign hcepsuspendin[2]    = 1'b0 ;
  assign hcendpnrusbin2      = {4{1'b0}} ;
  assign hcinmaxpckusb2      = {11{1'b0}} ;
  assign hcdoisoin[2]        = 1'b0 ;
  assign hcepwaitin[2]       = 1'b0 ;
  assign hcerrirqin[2]       = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPOUT_EXIST_1



  cdnsusbhs_epout
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPOUT_NUMBER_1),
    .EPSIZE                             (`CDNSUSBHS_EPOUT_SIZE_1),
    .EPBUFFER                           (`CDNSUSBHS_EPOUT_BUFFER_1),
    .BCWIDTH                            (`CDNSUSBHS_EPOUT_BC_1)
  `else
    `CDNSUSBHS_EPOUT_NUMBER_1,
    `CDNSUSBHS_EPOUT_SIZE_1,
    `CDNSUSBHS_EPOUT_BUFFER_1,
    `CDNSUSBHS_EPOUT_BC_1
  `endif
    )
  U_CDNSUSBHS_EPOUT_1
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .pid                                (pid),
    .clroutbsy                          (clroutbsy),
    .wr                                 (rxfifowr),
    .overflowwr                         (overflowwr),
    .tokrcvfall                         (tokrcvfall),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_out[1]),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .sendtok                            (sendtok),
    .hcisostop                          (hcisostop),
    .upstren                            (upstren),
    .enterhm                            (enterhm),
    .bufffull                           (bufffullout[1]),
    .eptype                             (eptype_out1),
    .episo                              (episoout1),
    .stall                              (stallout[1]),
    .busy                               (busyout[1]),
    .nxtbusy                            (nxtbusyout[1]),
    .epval                              (epvalout[1]),
    .sfrtoggle                          (sfrstoggleout[1]),
    .toggle                             (toggle_out1),
    .togglerst                          (togglerstout[1]),
    .toggleset                          (togglesetout[1]),
    .fiforst                            (fiforstout[1]),
    .hcunderrien                        (hcunderrien[1]),
    .hcnakidis                          (hcnakidisin[1]),
    .enterhmup                          (enterhmup),
    .outbsyfall                         (outbsyfall[1]),
    .usbfifoptrwr                       (usbfifoptrwr1),
    .upfifoptrrd                        (upfifoptrrd1),
    .fifoendpnr                         (fifooutaddr),
    .fiford                             (fifooutrdff),

    .fifoempty                          (fifoempty_int[1]),
    .upstrenup                          (upstrenup),
    .fifobc                             (fifobc_int1),
    .buf_enable                         (buf_enable_1),
    .hcepsuspend                        (hcepsuspendin[1]),
    .hcendpnrusb                        (hcendpnrusbin1),
    .hcinxmaxpckusb                     (hcinmaxpckusb1),
    .hcdoiso                            (hcdoisoin[1]),
    .hcepwait                           (hcepwaitin[1]),
    .hcerrirq                           (hcerrirqin[1]),

    .outxmaxpck                         (out1maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .uprd                               (outptrinc[1]),
    .updatao                            (epoutdata1),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .int_upbe_rd                        (cusb2_upbe_rd),
    .int_upbe_wr                        (cusb2_upbe_wr)
    );

  `else




  assign dmasof_out[1]       = 1'b0 ;



  assign bufffullout[1]      = 1'b0 ;
  assign eptype_out1         = 2'b10 ;
  assign episoout1           = 1'b0 ;
  assign stallout[1]         = 1'b0 ;
  assign busyout[1]          = 1'b0 ;
  assign nxtbusyout[1]       = 1'b0 ;
  assign epvalout[1]         = 1'b0 ;
  assign hcunderrien[1]      = 1'b0 ;
  assign hcnakidisin[1]      = 1'b0 ;
  assign toggle_out1         = 2'b00 ;
  assign sfrstoggleout[1]    = 1'b0 ;



  assign outbsyfall[1]       = 1'b0 ;



  assign fifoempty_int[1]    = 1'b1 ;



  assign hcepsuspendin[1]    = 1'b0 ;
  assign hcendpnrusbin1      = {4{1'b0}} ;
  assign hcinmaxpckusb1      = {11{1'b0}} ;
  assign hcdoisoin[1]        = 1'b0 ;
  assign hcepwaitin[1]       = 1'b0 ;
  assign hcerrirqin[1]       = 1'b0 ;
  `endif









  `ifdef CDNSUSBHS_EPIN_EXIST_15



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_15),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_15),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_15),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_15)
  `else
    `CDNSUSBHS_EPIN_NUMBER_15,
    `CDNSUSBHS_EPIN_SIZE_15,
    `CDNSUSBHS_EPIN_BUFFER_15,
    `CDNSUSBHS_EPIN_BC_15
  `endif
    )
  U_CDNSUSBHS_EPIN_15
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[15]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in15),
    .eptype                             (eptype_in15),
    .episo                              (episoin15),
    .stall                              (stallin[15]),
    .busy                               (busyin[15]),
    .epval                              (epvalin[15]),
    .sfrtoggle                          (sfrstogglein[15]),
    .toggle                             (toggle_in15),
    .isotoggleusb                       (isotogglein15),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb15),
    .hcepsuspend                        (hcepsuspendout[15]),
    .hcendpnrusb                        (hcendpnrusbout15),
    .hcdoiso                            (hcdoisoout[15]),
    .hcepwait                           (hcepwaitout[15]),
    .hcdoping                           (hcdopingout[15]),
    .hcnakidis                          (hcnakidisout[15]),
    .hcerrirq                           (hcerrirqout[15]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[15]),
    .toggleset                          (togglesetin[15]),
    .fiforst                            (fiforstin[15]),
    .inxisodctrl                        (inxisodctrl[15]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[15]),
    .inxisoautodump                     (inxisoautodump[15]),
    .inbsyfall                          (inbsyfall[15]),
    .usbfifoptrrd                       (usbfifoptrrd15),
    .upfifoptrwr                        (upfifoptrwr15),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[15]),
    .fifoafull                          (fifoafull_int[15]),

    .inxmaxpck                          (in15maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata15),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[15]       = 1'b0 ;



  assign dvi_in15            = 1'b0 ;
  assign eptype_in15         = 2'b10 ;
  assign episoin15           = 1'b0 ;
  assign stallin[15]         = 1'b0 ;
  assign busyin[15]          = 1'b0 ;
  assign epvalin[15]         = 1'b0 ;
  assign toggle_in15         = 2'b00 ;
  assign sfrstogglein[15]    = 1'b0 ;



  assign inbsyfall[15]       = 1'b0 ;



  assign fifofull_int[15]    = 1'b1 ;
  assign fifoafull_int[15]   = 1'b1 ;



  assign isotogglein15       = {2{1'b0}} ;
  assign hcoutmaxpckusb15    = {11{1'b0}} ;
  assign hcepsuspendout[15]  = 1'b0 ;
  assign hcendpnrusbout15    = {4{1'b0}} ;
  assign hcdoisoout[15]      = 1'b0 ;
  assign hcepwaitout[15]     = 1'b0 ;
  assign hcdopingout[15]     = 1'b0 ;
  assign hcnakidisout[15]    = 1'b0 ;
  assign hcerrirqout[15]     = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPIN_EXIST_14



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_14),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_14),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_14),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_14)
  `else
    `CDNSUSBHS_EPIN_NUMBER_14,
    `CDNSUSBHS_EPIN_SIZE_14,
    `CDNSUSBHS_EPIN_BUFFER_14,
    `CDNSUSBHS_EPIN_BC_14
  `endif
    )
  U_CDNSUSBHS_EPIN_14
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[14]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in14),
    .eptype                             (eptype_in14),
    .episo                              (episoin14),
    .stall                              (stallin[14]),
    .busy                               (busyin[14]),
    .epval                              (epvalin[14]),
    .sfrtoggle                          (sfrstogglein[14]),
    .toggle                             (toggle_in14),
    .isotoggleusb                       (isotogglein14),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb14),
    .hcepsuspend                        (hcepsuspendout[14]),
    .hcendpnrusb                        (hcendpnrusbout14),
    .hcdoiso                            (hcdoisoout[14]),
    .hcepwait                           (hcepwaitout[14]),
    .hcdoping                           (hcdopingout[14]),
    .hcnakidis                          (hcnakidisout[14]),
    .hcerrirq                           (hcerrirqout[14]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[14]),
    .toggleset                          (togglesetin[14]),
    .fiforst                            (fiforstin[14]),
    .inxisodctrl                        (inxisodctrl[14]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[14]),
    .inxisoautodump                     (inxisoautodump[14]),
    .inbsyfall                          (inbsyfall[14]),
    .usbfifoptrrd                       (usbfifoptrrd14),
    .upfifoptrwr                        (upfifoptrwr14),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[14]),
    .fifoafull                          (fifoafull_int[14]),

    .inxmaxpck                          (in14maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata14),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[14]       = 1'b0 ;



  assign dvi_in14            = 1'b0 ;
  assign eptype_in14         = 2'b10 ;
  assign episoin14           = 1'b0 ;
  assign stallin[14]         = 1'b0 ;
  assign busyin[14]          = 1'b0 ;
  assign epvalin[14]         = 1'b0 ;
  assign toggle_in14         = 2'b00 ;
  assign sfrstogglein[14]    = 1'b0 ;



  assign inbsyfall[14]       = 1'b0 ;



  assign fifofull_int[14]    = 1'b1 ;
  assign fifoafull_int[14]   = 1'b1 ;



  assign isotogglein14       = {2{1'b0}} ;
  assign hcoutmaxpckusb14    = {11{1'b0}} ;
  assign hcepsuspendout[14]  = 1'b0 ;
  assign hcendpnrusbout14    = {4{1'b0}} ;
  assign hcdoisoout[14]      = 1'b0 ;
  assign hcepwaitout[14]     = 1'b0 ;
  assign hcdopingout[14]     = 1'b0 ;
  assign hcnakidisout[14]    = 1'b0 ;
  assign hcerrirqout[14]     = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPIN_EXIST_13



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_13),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_13),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_13),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_13)
  `else
    `CDNSUSBHS_EPIN_NUMBER_13,
    `CDNSUSBHS_EPIN_SIZE_13,
    `CDNSUSBHS_EPIN_BUFFER_13,
    `CDNSUSBHS_EPIN_BC_13
  `endif
    )
  U_CDNSUSBHS_EPIN_13
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[13]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in13),
    .eptype                             (eptype_in13),
    .episo                              (episoin13),
    .stall                              (stallin[13]),
    .busy                               (busyin[13]),
    .epval                              (epvalin[13]),
    .sfrtoggle                          (sfrstogglein[13]),
    .toggle                             (toggle_in13),
    .isotoggleusb                       (isotogglein13),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb13),
    .hcepsuspend                        (hcepsuspendout[13]),
    .hcendpnrusb                        (hcendpnrusbout13),
    .hcdoiso                            (hcdoisoout[13]),
    .hcepwait                           (hcepwaitout[13]),
    .hcdoping                           (hcdopingout[13]),
    .hcnakidis                          (hcnakidisout[13]),
    .hcerrirq                           (hcerrirqout[13]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[13]),
    .toggleset                          (togglesetin[13]),
    .fiforst                            (fiforstin[13]),
    .inxisodctrl                        (inxisodctrl[13]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[13]),
    .inxisoautodump                     (inxisoautodump[13]),
    .inbsyfall                          (inbsyfall[13]),
    .usbfifoptrrd                       (usbfifoptrrd13),
    .upfifoptrwr                        (upfifoptrwr13),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[13]),
    .fifoafull                          (fifoafull_int[13]),

    .inxmaxpck                          (in13maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata13),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[13]       = 1'b0 ;



  assign dvi_in13            = 1'b0 ;
  assign eptype_in13         = 2'b10 ;
  assign episoin13           = 1'b0 ;
  assign stallin[13]         = 1'b0 ;
  assign busyin[13]          = 1'b0 ;
  assign epvalin[13]         = 1'b0 ;
  assign toggle_in13         = 2'b00 ;
  assign sfrstogglein[13]    = 1'b0 ;



  assign inbsyfall[13]       = 1'b0 ;



  assign fifofull_int[13]    = 1'b1 ;
  assign fifoafull_int[13]   = 1'b1 ;



  assign isotogglein13       = {2{1'b0}} ;
  assign hcoutmaxpckusb13    = {11{1'b0}} ;
  assign hcepsuspendout[13]  = 1'b0 ;
  assign hcendpnrusbout13    = {4{1'b0}} ;
  assign hcdoisoout[13]      = 1'b0 ;
  assign hcepwaitout[13]     = 1'b0 ;
  assign hcdopingout[13]     = 1'b0 ;
  assign hcnakidisout[13]    = 1'b0 ;
  assign hcerrirqout[13]     = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPIN_EXIST_12



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_12),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_12),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_12),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_12)
  `else
    `CDNSUSBHS_EPIN_NUMBER_12,
    `CDNSUSBHS_EPIN_SIZE_12,
    `CDNSUSBHS_EPIN_BUFFER_12,
    `CDNSUSBHS_EPIN_BC_12
  `endif
    )
  U_CDNSUSBHS_EPIN_12
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[12]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in12),
    .eptype                             (eptype_in12),
    .episo                              (episoin12),
    .stall                              (stallin[12]),
    .busy                               (busyin[12]),
    .epval                              (epvalin[12]),
    .sfrtoggle                          (sfrstogglein[12]),
    .toggle                             (toggle_in12),
    .isotoggleusb                       (isotogglein12),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb12),
    .hcepsuspend                        (hcepsuspendout[12]),
    .hcendpnrusb                        (hcendpnrusbout12),
    .hcdoiso                            (hcdoisoout[12]),
    .hcepwait                           (hcepwaitout[12]),
    .hcdoping                           (hcdopingout[12]),
    .hcnakidis                          (hcnakidisout[12]),
    .hcerrirq                           (hcerrirqout[12]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[12]),
    .toggleset                          (togglesetin[12]),
    .fiforst                            (fiforstin[12]),
    .inxisodctrl                        (inxisodctrl[12]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[12]),
    .inxisoautodump                     (inxisoautodump[12]),
    .inbsyfall                          (inbsyfall[12]),
    .usbfifoptrrd                       (usbfifoptrrd12),
    .upfifoptrwr                        (upfifoptrwr12),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[12]),
    .fifoafull                          (fifoafull_int[12]),

    .inxmaxpck                          (in12maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata12),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[12]       = 1'b0 ;



  assign dvi_in12            = 1'b0 ;
  assign eptype_in12         = 2'b10 ;
  assign episoin12           = 1'b0 ;
  assign stallin[12]         = 1'b0 ;
  assign busyin[12]          = 1'b0 ;
  assign epvalin[12]         = 1'b0 ;
  assign toggle_in12         = 2'b00 ;
  assign sfrstogglein[12]    = 1'b0 ;



  assign inbsyfall[12]       = 1'b0 ;



  assign fifofull_int[12]    = 1'b1 ;
  assign fifoafull_int[12]   = 1'b1 ;



  assign isotogglein12       = {2{1'b0}} ;
  assign hcoutmaxpckusb12    = {11{1'b0}} ;
  assign hcepsuspendout[12]  = 1'b0 ;
  assign hcendpnrusbout12    = {4{1'b0}} ;
  assign hcdoisoout[12]      = 1'b0 ;
  assign hcepwaitout[12]     = 1'b0 ;
  assign hcdopingout[12]     = 1'b0 ;
  assign hcnakidisout[12]    = 1'b0 ;
  assign hcerrirqout[12]     = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPIN_EXIST_11



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_11),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_11),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_11),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_11)
  `else
    `CDNSUSBHS_EPIN_NUMBER_11,
    `CDNSUSBHS_EPIN_SIZE_11,
    `CDNSUSBHS_EPIN_BUFFER_11,
    `CDNSUSBHS_EPIN_BC_11
  `endif
    )
  U_CDNSUSBHS_EPIN_11
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[11]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in11),
    .eptype                             (eptype_in11),
    .episo                              (episoin11),
    .stall                              (stallin[11]),
    .busy                               (busyin[11]),
    .epval                              (epvalin[11]),
    .sfrtoggle                          (sfrstogglein[11]),
    .toggle                             (toggle_in11),
    .isotoggleusb                       (isotogglein11),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb11),
    .hcepsuspend                        (hcepsuspendout[11]),
    .hcendpnrusb                        (hcendpnrusbout11),
    .hcdoiso                            (hcdoisoout[11]),
    .hcepwait                           (hcepwaitout[11]),
    .hcdoping                           (hcdopingout[11]),
    .hcnakidis                          (hcnakidisout[11]),
    .hcerrirq                           (hcerrirqout[11]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[11]),
    .toggleset                          (togglesetin[11]),
    .fiforst                            (fiforstin[11]),
    .inxisodctrl                        (inxisodctrl[11]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[11]),
    .inxisoautodump                     (inxisoautodump[11]),
    .inbsyfall                          (inbsyfall[11]),
    .usbfifoptrrd                       (usbfifoptrrd11),
    .upfifoptrwr                        (upfifoptrwr11),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[11]),
    .fifoafull                          (fifoafull_int[11]),

    .inxmaxpck                          (in11maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata11),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[11]       = 1'b0 ;



  assign dvi_in11            = 1'b0 ;
  assign eptype_in11         = 2'b10 ;
  assign episoin11           = 1'b0 ;
  assign stallin[11]         = 1'b0 ;
  assign busyin[11]          = 1'b0 ;
  assign epvalin[11]         = 1'b0 ;
  assign toggle_in11         = 2'b00 ;
  assign sfrstogglein[11]    = 1'b0 ;



  assign inbsyfall[11]       = 1'b0 ;



  assign fifofull_int[11]    = 1'b1 ;
  assign fifoafull_int[11]   = 1'b1 ;



  assign isotogglein11       = {2{1'b0}} ;
  assign hcoutmaxpckusb11    = {11{1'b0}} ;
  assign hcepsuspendout[11]  = 1'b0 ;
  assign hcendpnrusbout11    = {4{1'b0}} ;
  assign hcdoisoout[11]      = 1'b0 ;
  assign hcepwaitout[11]     = 1'b0 ;
  assign hcdopingout[11]     = 1'b0 ;
  assign hcnakidisout[11]    = 1'b0 ;
  assign hcerrirqout[11]     = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPIN_EXIST_10



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_10),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_10),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_10),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_10)
  `else
    `CDNSUSBHS_EPIN_NUMBER_10,
    `CDNSUSBHS_EPIN_SIZE_10,
    `CDNSUSBHS_EPIN_BUFFER_10,
    `CDNSUSBHS_EPIN_BC_10
  `endif
    )
  U_CDNSUSBHS_EPIN_10
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[10]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in10),
    .eptype                             (eptype_in10),
    .episo                              (episoin10),
    .stall                              (stallin[10]),
    .busy                               (busyin[10]),
    .epval                              (epvalin[10]),
    .sfrtoggle                          (sfrstogglein[10]),
    .toggle                             (toggle_in10),
    .isotoggleusb                       (isotogglein10),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb10),
    .hcepsuspend                        (hcepsuspendout[10]),
    .hcendpnrusb                        (hcendpnrusbout10),
    .hcdoiso                            (hcdoisoout[10]),
    .hcepwait                           (hcepwaitout[10]),
    .hcdoping                           (hcdopingout[10]),
    .hcnakidis                          (hcnakidisout[10]),
    .hcerrirq                           (hcerrirqout[10]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[10]),
    .toggleset                          (togglesetin[10]),
    .fiforst                            (fiforstin[10]),
    .inxisodctrl                        (inxisodctrl[10]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[10]),
    .inxisoautodump                     (inxisoautodump[10]),
    .inbsyfall                          (inbsyfall[10]),
    .usbfifoptrrd                       (usbfifoptrrd10),
    .upfifoptrwr                        (upfifoptrwr10),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[10]),
    .fifoafull                          (fifoafull_int[10]),

    .inxmaxpck                          (in10maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata10),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[10]       = 1'b0 ;



  assign dvi_in10            = 1'b0 ;
  assign eptype_in10         = 2'b10 ;
  assign episoin10           = 1'b0 ;
  assign stallin[10]         = 1'b0 ;
  assign busyin[10]          = 1'b0 ;
  assign epvalin[10]         = 1'b0 ;
  assign toggle_in10         = 2'b00 ;
  assign sfrstogglein[10]    = 1'b0 ;



  assign inbsyfall[10]       = 1'b0 ;



  assign fifofull_int[10]    = 1'b1 ;
  assign fifoafull_int[10]   = 1'b1 ;



  assign isotogglein10       = {2{1'b0}} ;
  assign hcoutmaxpckusb10    = {11{1'b0}} ;
  assign hcepsuspendout[10]  = 1'b0 ;
  assign hcendpnrusbout10    = {4{1'b0}} ;
  assign hcdoisoout[10]      = 1'b0 ;
  assign hcepwaitout[10]     = 1'b0 ;
  assign hcdopingout[10]     = 1'b0 ;
  assign hcnakidisout[10]    = 1'b0 ;
  assign hcerrirqout[10]     = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPIN_EXIST_9



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_9),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_9),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_9),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_9)
  `else
    `CDNSUSBHS_EPIN_NUMBER_9,
    `CDNSUSBHS_EPIN_SIZE_9,
    `CDNSUSBHS_EPIN_BUFFER_9,
    `CDNSUSBHS_EPIN_BC_9
  `endif
    )
  U_CDNSUSBHS_EPIN_9
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[9]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in9),
    .eptype                             (eptype_in9),
    .episo                              (episoin9),
    .stall                              (stallin[9]),
    .busy                               (busyin[9]),
    .epval                              (epvalin[9]),
    .sfrtoggle                          (sfrstogglein[9]),
    .toggle                             (toggle_in9),
    .isotoggleusb                       (isotogglein9),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb9),
    .hcepsuspend                        (hcepsuspendout[9]),
    .hcendpnrusb                        (hcendpnrusbout9),
    .hcdoiso                            (hcdoisoout[9]),
    .hcepwait                           (hcepwaitout[9]),
    .hcdoping                           (hcdopingout[9]),
    .hcnakidis                          (hcnakidisout[9]),
    .hcerrirq                           (hcerrirqout[9]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[9]),
    .toggleset                          (togglesetin[9]),
    .fiforst                            (fiforstin[9]),
    .inxisodctrl                        (inxisodctrl[9]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[9]),
    .inxisoautodump                     (inxisoautodump[9]),
    .inbsyfall                          (inbsyfall[9]),
    .usbfifoptrrd                       (usbfifoptrrd9),
    .upfifoptrwr                        (upfifoptrwr9),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[9]),
    .fifoafull                          (fifoafull_int[9]),

    .inxmaxpck                          (in9maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata9),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[9]        = 1'b0 ;



  assign dvi_in9             = 1'b0 ;
  assign eptype_in9          = 2'b10 ;
  assign episoin9            = 1'b0 ;
  assign stallin[9]          = 1'b0 ;
  assign busyin[9]           = 1'b0 ;
  assign epvalin[9]          = 1'b0 ;
  assign toggle_in9          = 2'b00 ;
  assign sfrstogglein[9]     = 1'b0 ;



  assign inbsyfall[9]        = 1'b0 ;



  assign fifofull_int[9]     = 1'b1 ;
  assign fifoafull_int[9]    = 1'b1 ;



  assign isotogglein9        = {2{1'b0}} ;
  assign hcoutmaxpckusb9     = {11{1'b0}} ;
  assign hcepsuspendout[9]   = 1'b0 ;
  assign hcendpnrusbout9     = {4{1'b0}} ;
  assign hcdoisoout[9]       = 1'b0 ;
  assign hcepwaitout[9]      = 1'b0 ;
  assign hcdopingout[9]      = 1'b0 ;
  assign hcnakidisout[9]     = 1'b0 ;
  assign hcerrirqout[9]      = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPIN_EXIST_8



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_8),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_8),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_8),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_8)
  `else
    `CDNSUSBHS_EPIN_NUMBER_8,
    `CDNSUSBHS_EPIN_SIZE_8,
    `CDNSUSBHS_EPIN_BUFFER_8,
    `CDNSUSBHS_EPIN_BC_8
  `endif
    )
  U_CDNSUSBHS_EPIN_8
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[8]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in8),
    .eptype                             (eptype_in8),
    .episo                              (episoin8),
    .stall                              (stallin[8]),
    .busy                               (busyin[8]),
    .epval                              (epvalin[8]),
    .sfrtoggle                          (sfrstogglein[8]),
    .toggle                             (toggle_in8),
    .isotoggleusb                       (isotogglein8),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb8),
    .hcepsuspend                        (hcepsuspendout[8]),
    .hcendpnrusb                        (hcendpnrusbout8),
    .hcdoiso                            (hcdoisoout[8]),
    .hcepwait                           (hcepwaitout[8]),
    .hcdoping                           (hcdopingout[8]),
    .hcnakidis                          (hcnakidisout[8]),
    .hcerrirq                           (hcerrirqout[8]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[8]),
    .toggleset                          (togglesetin[8]),
    .fiforst                            (fiforstin[8]),
    .inxisodctrl                        (inxisodctrl[8]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[8]),
    .inxisoautodump                     (inxisoautodump[8]),
    .inbsyfall                          (inbsyfall[8]),
    .usbfifoptrrd                       (usbfifoptrrd8),
    .upfifoptrwr                        (upfifoptrwr8),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[8]),
    .fifoafull                          (fifoafull_int[8]),

    .inxmaxpck                          (in8maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata8),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[8]        = 1'b0 ;



  assign dvi_in8             = 1'b0 ;
  assign eptype_in8          = 2'b10 ;
  assign episoin8            = 1'b0 ;
  assign stallin[8]          = 1'b0 ;
  assign busyin[8]           = 1'b0 ;
  assign epvalin[8]          = 1'b0 ;
  assign toggle_in8          = 2'b00 ;
  assign sfrstogglein[8]     = 1'b0 ;



  assign inbsyfall[8]        = 1'b0 ;



  assign fifofull_int[8]     = 1'b1 ;
  assign fifoafull_int[8]    = 1'b1 ;



  assign isotogglein8        = {2{1'b0}} ;
  assign hcoutmaxpckusb8     = {11{1'b0}} ;
  assign hcepsuspendout[8]   = 1'b0 ;
  assign hcendpnrusbout8     = {4{1'b0}} ;
  assign hcdoisoout[8]       = 1'b0 ;
  assign hcepwaitout[8]      = 1'b0 ;
  assign hcdopingout[8]      = 1'b0 ;
  assign hcnakidisout[8]     = 1'b0 ;
  assign hcerrirqout[8]      = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPIN_EXIST_7



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_7),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_7),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_7),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_7)
  `else
    `CDNSUSBHS_EPIN_NUMBER_7,
    `CDNSUSBHS_EPIN_SIZE_7,
    `CDNSUSBHS_EPIN_BUFFER_7,
    `CDNSUSBHS_EPIN_BC_7
  `endif
    )
  U_CDNSUSBHS_EPIN_7
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[7]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in7),
    .eptype                             (eptype_in7),
    .episo                              (episoin7),
    .stall                              (stallin[7]),
    .busy                               (busyin[7]),
    .epval                              (epvalin[7]),
    .sfrtoggle                          (sfrstogglein[7]),
    .toggle                             (toggle_in7),
    .isotoggleusb                       (isotogglein7),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb7),
    .hcepsuspend                        (hcepsuspendout[7]),
    .hcendpnrusb                        (hcendpnrusbout7),
    .hcdoiso                            (hcdoisoout[7]),
    .hcepwait                           (hcepwaitout[7]),
    .hcdoping                           (hcdopingout[7]),
    .hcnakidis                          (hcnakidisout[7]),
    .hcerrirq                           (hcerrirqout[7]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[7]),
    .toggleset                          (togglesetin[7]),
    .fiforst                            (fiforstin[7]),
    .inxisodctrl                        (inxisodctrl[7]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[7]),
    .inxisoautodump                     (inxisoautodump[7]),
    .inbsyfall                          (inbsyfall[7]),
    .usbfifoptrrd                       (usbfifoptrrd7),
    .upfifoptrwr                        (upfifoptrwr7),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[7]),
    .fifoafull                          (fifoafull_int[7]),

    .inxmaxpck                          (in7maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata7),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[7]        = 1'b0 ;



  assign dvi_in7             = 1'b0 ;
  assign eptype_in7          = 2'b10 ;
  assign episoin7            = 1'b0 ;
  assign stallin[7]          = 1'b0 ;
  assign busyin[7]           = 1'b0 ;
  assign epvalin[7]          = 1'b0 ;
  assign toggle_in7          = 2'b00 ;
  assign sfrstogglein[7]     = 1'b0 ;



  assign inbsyfall[7]        = 1'b0 ;



  assign fifofull_int[7]     = 1'b1 ;
  assign fifoafull_int[7]    = 1'b1 ;



  assign isotogglein7        = {2{1'b0}} ;
  assign hcoutmaxpckusb7     = {11{1'b0}} ;
  assign hcepsuspendout[7]   = 1'b0 ;
  assign hcendpnrusbout7     = {4{1'b0}} ;
  assign hcdoisoout[7]       = 1'b0 ;
  assign hcepwaitout[7]      = 1'b0 ;
  assign hcdopingout[7]      = 1'b0 ;
  assign hcnakidisout[7]     = 1'b0 ;
  assign hcerrirqout[7]      = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPIN_EXIST_6



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_6),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_6),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_6),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_6)
  `else
    `CDNSUSBHS_EPIN_NUMBER_6,
    `CDNSUSBHS_EPIN_SIZE_6,
    `CDNSUSBHS_EPIN_BUFFER_6,
    `CDNSUSBHS_EPIN_BC_6
  `endif
    )
  U_CDNSUSBHS_EPIN_6
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[6]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in6),
    .eptype                             (eptype_in6),
    .episo                              (episoin6),
    .stall                              (stallin[6]),
    .busy                               (busyin[6]),
    .epval                              (epvalin[6]),
    .sfrtoggle                          (sfrstogglein[6]),
    .toggle                             (toggle_in6),
    .isotoggleusb                       (isotogglein6),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb6),
    .hcepsuspend                        (hcepsuspendout[6]),
    .hcendpnrusb                        (hcendpnrusbout6),
    .hcdoiso                            (hcdoisoout[6]),
    .hcepwait                           (hcepwaitout[6]),
    .hcdoping                           (hcdopingout[6]),
    .hcnakidis                          (hcnakidisout[6]),
    .hcerrirq                           (hcerrirqout[6]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[6]),
    .toggleset                          (togglesetin[6]),
    .fiforst                            (fiforstin[6]),
    .inxisodctrl                        (inxisodctrl[6]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[6]),
    .inxisoautodump                     (inxisoautodump[6]),
    .inbsyfall                          (inbsyfall[6]),
    .usbfifoptrrd                       (usbfifoptrrd6),
    .upfifoptrwr                        (upfifoptrwr6),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[6]),
    .fifoafull                          (fifoafull_int[6]),

    .inxmaxpck                          (in6maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata6),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[6]        = 1'b0 ;



  assign dvi_in6             = 1'b0 ;
  assign eptype_in6          = 2'b10 ;
  assign episoin6            = 1'b0 ;
  assign stallin[6]          = 1'b0 ;
  assign busyin[6]           = 1'b0 ;
  assign epvalin[6]          = 1'b0 ;
  assign toggle_in6          = 2'b00 ;
  assign sfrstogglein[6]     = 1'b0 ;



  assign inbsyfall[6]        = 1'b0 ;



  assign fifofull_int[6]     = 1'b1 ;
  assign fifoafull_int[6]    = 1'b1 ;



  assign isotogglein6        = {2{1'b0}} ;
  assign hcoutmaxpckusb6     = {11{1'b0}} ;
  assign hcepsuspendout[6]   = 1'b0 ;
  assign hcendpnrusbout6     = {4{1'b0}} ;
  assign hcdoisoout[6]       = 1'b0 ;
  assign hcepwaitout[6]      = 1'b0 ;
  assign hcdopingout[6]      = 1'b0 ;
  assign hcnakidisout[6]     = 1'b0 ;
  assign hcerrirqout[6]      = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPIN_EXIST_5



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_5),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_5),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_5),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_5)
  `else
    `CDNSUSBHS_EPIN_NUMBER_5,
    `CDNSUSBHS_EPIN_SIZE_5,
    `CDNSUSBHS_EPIN_BUFFER_5,
    `CDNSUSBHS_EPIN_BC_5
  `endif
    )
  U_CDNSUSBHS_EPIN_5
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[5]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in5),
    .eptype                             (eptype_in5),
    .episo                              (episoin5),
    .stall                              (stallin[5]),
    .busy                               (busyin[5]),
    .epval                              (epvalin[5]),
    .sfrtoggle                          (sfrstogglein[5]),
    .toggle                             (toggle_in5),
    .isotoggleusb                       (isotogglein5),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb5),
    .hcepsuspend                        (hcepsuspendout[5]),
    .hcendpnrusb                        (hcendpnrusbout5),
    .hcdoiso                            (hcdoisoout[5]),
    .hcepwait                           (hcepwaitout[5]),
    .hcdoping                           (hcdopingout[5]),
    .hcnakidis                          (hcnakidisout[5]),
    .hcerrirq                           (hcerrirqout[5]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[5]),
    .toggleset                          (togglesetin[5]),
    .fiforst                            (fiforstin[5]),
    .inxisodctrl                        (inxisodctrl[5]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[5]),
    .inxisoautodump                     (inxisoautodump[5]),
    .inbsyfall                          (inbsyfall[5]),
    .usbfifoptrrd                       (usbfifoptrrd5),
    .upfifoptrwr                        (upfifoptrwr5),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[5]),
    .fifoafull                          (fifoafull_int[5]),

    .inxmaxpck                          (in5maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata5),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[5]        = 1'b0 ;



  assign dvi_in5             = 1'b0 ;
  assign eptype_in5          = 2'b10 ;
  assign episoin5            = 1'b0 ;
  assign stallin[5]          = 1'b0 ;
  assign busyin[5]           = 1'b0 ;
  assign epvalin[5]          = 1'b0 ;
  assign toggle_in5          = 2'b00 ;
  assign sfrstogglein[5]     = 1'b0 ;



  assign inbsyfall[5]        = 1'b0 ;



  assign fifofull_int[5]     = 1'b1 ;
  assign fifoafull_int[5]    = 1'b1 ;



  assign isotogglein5        = {2{1'b0}} ;
  assign hcoutmaxpckusb5     = {11{1'b0}} ;
  assign hcepsuspendout[5]   = 1'b0 ;
  assign hcendpnrusbout5     = {4{1'b0}} ;
  assign hcdoisoout[5]       = 1'b0 ;
  assign hcepwaitout[5]      = 1'b0 ;
  assign hcdopingout[5]      = 1'b0 ;
  assign hcnakidisout[5]     = 1'b0 ;
  assign hcerrirqout[5]      = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPIN_EXIST_4



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_4),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_4),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_4),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_4)
  `else
    `CDNSUSBHS_EPIN_NUMBER_4,
    `CDNSUSBHS_EPIN_SIZE_4,
    `CDNSUSBHS_EPIN_BUFFER_4,
    `CDNSUSBHS_EPIN_BC_4
  `endif
    )
  U_CDNSUSBHS_EPIN_4
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[4]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in4),
    .eptype                             (eptype_in4),
    .episo                              (episoin4),
    .stall                              (stallin[4]),
    .busy                               (busyin[4]),
    .epval                              (epvalin[4]),
    .sfrtoggle                          (sfrstogglein[4]),
    .toggle                             (toggle_in4),
    .isotoggleusb                       (isotogglein4),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb4),
    .hcepsuspend                        (hcepsuspendout[4]),
    .hcendpnrusb                        (hcendpnrusbout4),
    .hcdoiso                            (hcdoisoout[4]),
    .hcepwait                           (hcepwaitout[4]),
    .hcdoping                           (hcdopingout[4]),
    .hcnakidis                          (hcnakidisout[4]),
    .hcerrirq                           (hcerrirqout[4]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[4]),
    .toggleset                          (togglesetin[4]),
    .fiforst                            (fiforstin[4]),
    .inxisodctrl                        (inxisodctrl[4]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[4]),
    .inxisoautodump                     (inxisoautodump[4]),
    .inbsyfall                          (inbsyfall[4]),
    .usbfifoptrrd                       (usbfifoptrrd4),
    .upfifoptrwr                        (upfifoptrwr4),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[4]),
    .fifoafull                          (fifoafull_int[4]),

    .inxmaxpck                          (in4maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata4),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[4]        = 1'b0 ;



  assign dvi_in4             = 1'b0 ;
  assign eptype_in4          = 2'b10 ;
  assign episoin4            = 1'b0 ;
  assign stallin[4]          = 1'b0 ;
  assign busyin[4]           = 1'b0 ;
  assign epvalin[4]          = 1'b0 ;
  assign toggle_in4          = 2'b00 ;
  assign sfrstogglein[4]     = 1'b0 ;



  assign inbsyfall[4]        = 1'b0 ;



  assign fifofull_int[4]     = 1'b1 ;
  assign fifoafull_int[4]    = 1'b1 ;



  assign isotogglein4        = {2{1'b0}} ;
  assign hcoutmaxpckusb4     = {11{1'b0}} ;
  assign hcepsuspendout[4]   = 1'b0 ;
  assign hcendpnrusbout4     = {4{1'b0}} ;
  assign hcdoisoout[4]       = 1'b0 ;
  assign hcepwaitout[4]      = 1'b0 ;
  assign hcdopingout[4]      = 1'b0 ;
  assign hcnakidisout[4]     = 1'b0 ;
  assign hcerrirqout[4]      = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPIN_EXIST_3



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_3),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_3),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_3),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_3)
  `else
    `CDNSUSBHS_EPIN_NUMBER_3,
    `CDNSUSBHS_EPIN_SIZE_3,
    `CDNSUSBHS_EPIN_BUFFER_3,
    `CDNSUSBHS_EPIN_BC_3
  `endif
    )
  U_CDNSUSBHS_EPIN_3
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[3]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in3),
    .eptype                             (eptype_in3),
    .episo                              (episoin3),
    .stall                              (stallin[3]),
    .busy                               (busyin[3]),
    .epval                              (epvalin[3]),
    .sfrtoggle                          (sfrstogglein[3]),
    .toggle                             (toggle_in3),
    .isotoggleusb                       (isotogglein3),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb3),
    .hcepsuspend                        (hcepsuspendout[3]),
    .hcendpnrusb                        (hcendpnrusbout3),
    .hcdoiso                            (hcdoisoout[3]),
    .hcepwait                           (hcepwaitout[3]),
    .hcdoping                           (hcdopingout[3]),
    .hcnakidis                          (hcnakidisout[3]),
    .hcerrirq                           (hcerrirqout[3]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[3]),
    .toggleset                          (togglesetin[3]),
    .fiforst                            (fiforstin[3]),
    .inxisodctrl                        (inxisodctrl[3]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[3]),
    .inxisoautodump                     (inxisoautodump[3]),
    .inbsyfall                          (inbsyfall[3]),
    .usbfifoptrrd                       (usbfifoptrrd3),
    .upfifoptrwr                        (upfifoptrwr3),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[3]),
    .fifoafull                          (fifoafull_int[3]),

    .inxmaxpck                          (in3maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata3),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[3]        = 1'b0 ;



  assign dvi_in3             = 1'b0 ;
  assign eptype_in3          = 2'b10 ;
  assign episoin3            = 1'b0 ;
  assign stallin[3]          = 1'b0 ;
  assign busyin[3]           = 1'b0 ;
  assign epvalin[3]          = 1'b0 ;
  assign toggle_in3          = 2'b00 ;
  assign sfrstogglein[3]     = 1'b0 ;



  assign inbsyfall[3]        = 1'b0 ;



  assign fifofull_int[3]     = 1'b1 ;
  assign fifoafull_int[3]    = 1'b1 ;



  assign isotogglein3        = {2{1'b0}} ;
  assign hcoutmaxpckusb3     = {11{1'b0}} ;
  assign hcepsuspendout[3]   = 1'b0 ;
  assign hcendpnrusbout3     = {4{1'b0}} ;
  assign hcdoisoout[3]       = 1'b0 ;
  assign hcepwaitout[3]      = 1'b0 ;
  assign hcdopingout[3]      = 1'b0 ;
  assign hcnakidisout[3]     = 1'b0 ;
  assign hcerrirqout[3]      = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPIN_EXIST_2



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_2),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_2),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_2),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_2)
  `else
    `CDNSUSBHS_EPIN_NUMBER_2,
    `CDNSUSBHS_EPIN_SIZE_2,
    `CDNSUSBHS_EPIN_BUFFER_2,
    `CDNSUSBHS_EPIN_BC_2
  `endif
    )
  U_CDNSUSBHS_EPIN_2
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[2]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in2),
    .eptype                             (eptype_in2),
    .episo                              (episoin2),
    .stall                              (stallin[2]),
    .busy                               (busyin[2]),
    .epval                              (epvalin[2]),
    .sfrtoggle                          (sfrstogglein[2]),
    .toggle                             (toggle_in2),
    .isotoggleusb                       (isotogglein2),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb2),
    .hcepsuspend                        (hcepsuspendout[2]),
    .hcendpnrusb                        (hcendpnrusbout2),
    .hcdoiso                            (hcdoisoout[2]),
    .hcepwait                           (hcepwaitout[2]),
    .hcdoping                           (hcdopingout[2]),
    .hcnakidis                          (hcnakidisout[2]),
    .hcerrirq                           (hcerrirqout[2]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[2]),
    .toggleset                          (togglesetin[2]),
    .fiforst                            (fiforstin[2]),
    .inxisodctrl                        (inxisodctrl[2]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[2]),
    .inxisoautodump                     (inxisoautodump[2]),
    .inbsyfall                          (inbsyfall[2]),
    .usbfifoptrrd                       (usbfifoptrrd2),
    .upfifoptrwr                        (upfifoptrwr2),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[2]),
    .fifoafull                          (fifoafull_int[2]),

    .inxmaxpck                          (in2maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata2),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[2]        = 1'b0 ;



  assign dvi_in2             = 1'b0 ;
  assign eptype_in2          = 2'b10 ;
  assign episoin2            = 1'b0 ;
  assign stallin[2]          = 1'b0 ;
  assign busyin[2]           = 1'b0 ;
  assign epvalin[2]          = 1'b0 ;
  assign toggle_in2          = 2'b00 ;
  assign sfrstogglein[2]     = 1'b0 ;



  assign inbsyfall[2]        = 1'b0 ;



  assign fifofull_int[2]     = 1'b1 ;
  assign fifoafull_int[2]    = 1'b1 ;



  assign isotogglein2        = {2{1'b0}} ;
  assign hcoutmaxpckusb2     = {11{1'b0}} ;
  assign hcepsuspendout[2]   = 1'b0 ;
  assign hcendpnrusbout2     = {4{1'b0}} ;
  assign hcdoisoout[2]       = 1'b0 ;
  assign hcepwaitout[2]      = 1'b0 ;
  assign hcdopingout[2]      = 1'b0 ;
  assign hcnakidisout[2]     = 1'b0 ;
  assign hcerrirqout[2]      = 1'b0 ;
  `endif





  `ifdef CDNSUSBHS_EPIN_EXIST_1



  cdnsusbhs_epin
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .EPNUMBER                           (`CDNSUSBHS_EPIN_NUMBER_1),
    .EPSIZE                             (`CDNSUSBHS_EPIN_SIZE_1),
    .EPBUFFER                           (`CDNSUSBHS_EPIN_BUFFER_1),
    .BCWIDTH                            (`CDNSUSBHS_EPIN_BC_1)
  `else
    `CDNSUSBHS_EPIN_NUMBER_1,
    `CDNSUSBHS_EPIN_SIZE_1,
    `CDNSUSBHS_EPIN_BUFFER_1,
    `CDNSUSBHS_EPIN_BC_1
  `endif
    )
  U_CDNSUSBHS_EPIN_1
    (
    .upclk                              (cusb2_upclk),
    .usbclk                             (cusb2_utmiclk),
    .uprst                              (cusb2_uprst),
    .usbrst                             (cusb2_utmirst),
    .hsmode                             (hsmode),
    .endp                               (tendp),
    .clrinbsy                           (clrinbsy),
    .usbreset                           (usbreset),
    .disconusb                          (discon_usb),

    .hcepnr                             (hcepnr),
    .hcepdir                            (hcepdir),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcerrtype                          (hcerrtype),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .upstren                            (upstren),
    .upstrenup                          (upstrenup),
    .enterhm                            (enterhm),
    .enterhmup                          (enterhmup),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),
    .dmasof                             (dmasof_in[1]),

    .isosofpulse                        (isosofpulse),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .dvi                                (dvi_in1),
    .eptype                             (eptype_in1),
    .episo                              (episoin1),
    .stall                              (stallin[1]),
    .busy                               (busyin[1]),
    .epval                              (epvalin[1]),
    .sfrtoggle                          (sfrstogglein[1]),
    .toggle                             (toggle_in1),
    .isotoggleusb                       (isotogglein1),
    .hcoutxmaxpckusb                    (hcoutmaxpckusb1),
    .hcepsuspend                        (hcepsuspendout[1]),
    .hcendpnrusb                        (hcendpnrusbout1),
    .hcdoiso                            (hcdoisoout[1]),
    .hcepwait                           (hcepwaitout[1]),
    .hcdoping                           (hcdopingout[1]),
    .hcnakidis                          (hcnakidisout[1]),
    .hcerrirq                           (hcerrirqout[1]),
    .rd                                 (txfiford),
    .txfall                             (txfall),
    .togglerst                          (togglerstin[1]),
    .toggleset                          (togglesetin[1]),
    .fiforst                            (fiforstin[1]),
    .inxisodctrl                        (inxisodctrl[1]),
    .isosofpulseup                      (isosofpulseup),
    .inxisoautoarm                      (inxisoautoarm[1]),
    .inxisoautodump                     (inxisoautodump[1]),
    .inbsyfall                          (inbsyfall[1]),
    .usbfifoptrrd                       (usbfifoptrrd1),
    .upfifoptrwr                        (upfifoptrwr1),
    .usbresetup                         (usbreset_up),
    .discon                             (discon),
    .fifoendpnr                         (fifoinaddr),
    .fifowr                             (fifoinwr),
    .fifoend                            (fifoinend),
    .fifoacc                            (fifoaccwr),
    .fifodval                           (fifoindvi),
    .fifofull                           (fifofull_int[1]),
    .fifoafull                          (fifoafull_int[1]),

    .inxmaxpck                          (in1maxpck),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .upincbc                            (cusb2_upwr),
    .updatao                            (epindata1),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3])
    );

  `else




  assign dmasof_in[1]        = 1'b0 ;



  assign dvi_in1             = 1'b0 ;
  assign eptype_in1          = 2'b10 ;
  assign episoin1            = 1'b0 ;
  assign stallin[1]          = 1'b0 ;
  assign busyin[1]           = 1'b0 ;
  assign epvalin[1]          = 1'b0 ;
  assign toggle_in1          = 2'b00 ;
  assign sfrstogglein[1]     = 1'b0 ;



  assign inbsyfall[1]        = 1'b0 ;



  assign fifofull_int[1]     = 1'b1 ;
  assign fifoafull_int[1]    = 1'b1 ;



  assign isotogglein1        = {2{1'b0}} ;
  assign hcoutmaxpckusb1     = {11{1'b0}} ;
  assign hcepsuspendout[1]   = 1'b0 ;
  assign hcendpnrusbout1     = {4{1'b0}} ;
  assign hcdoisoout[1]       = 1'b0 ;
  assign hcepwaitout[1]      = 1'b0 ;
  assign hcdopingout[1]      = 1'b0 ;
  assign hcnakidisout[1]     = 1'b0 ;
  assign hcerrirqout[1]      = 1'b0 ;
  `endif




  cdnsusbhs_devfsm
  U_CDNSUSBHS_DEVFSM
    (
    .usbclk                             (cusb2_utmiclk),
    .usbrst                             (cusb2_utmirst),
    .fnaddr                             (fnaddrusb),
    .ep0toggleout                       (ep0toggleout),
    .ep0togglein                        (ep0togglein),
    .ep0datastage                       (ep0datastage),
    .epvalin                            (epvalin),
    .eptypein                           (eptype_in),
    .stallin                            (stallin),
    .busyin                             (busyin),
    .togglein                           (toggle_in),
    .dviin                              (dvi_in),
    .epvalout                           (epvalout),
    .eptypeout                          (eptype_out),
    .stallout                           (stallout),
    .busyout                            (busyout),
    .nxtbusyout                         (nxtbusyout),
    .bufffullout                        (bufffullout),
    .toggleout                          (toggle_out),
    .isotogglein                        (isotogglein),
    .hcinmaxpckusb                      (hcinmaxpckusb),
    .hcoutmaxpckusb                     (hcoutmaxpckusb),
    .hcepwaitout                        (hcepwaitout),
    .hcendpnrusbout                     (hcendpnrusbout),
    .testmode                           (testmode),
    .clroutbsy                          (clroutbsy),
    .clrinbsy                           (clrinbsy),
    .tokrcvfall                         (tokrcvfall),
    .settoken                           (settoken),

    .hcerrtype                          (hcerrtype),
    .hcerrinc                           (hcerrinc),
    .hcerrclr                           (hcerrclr),
    .hcerrset                           (hcerrset),
    .hcepdir                            (hcepdir),
    .hcepwaitclr                        (hcepwaitclr),
    .hcepwaitset                        (hcepwaitset),
    .hcdevdopingset                     (hcdevdopingset),
    .hcdevdopingclr                     (hcdevdopingclr),
    .enterhm                            (enterhm),
    .hcisostop                          (hcisostop),

    .sofpulse                           (sofpulse),
    .hcsendsof                          (hcsendsof),

    .innak                              (innak_usb),
    .innak_no                           (innak_no_usb),

    .isosofpulse                        (isosofpulse),
    .isosofpulsereq                     (isosofpulsereq),
    .isodump2k                          (isodump2k),
    .isodump1k                          (isodump1k),
    .clrmfrmnr                          (clrmfrmnr),
    .clrmfrmnrack                       (clrmfrmnrack),
    .sleepm                             (sleepreq),
    .suspendm                           (suspreq),
    .tfnaddr                            (tfnaddr),
    .tendp                              (tendp),
    .tendpnxt                           (tendpnxt),
    .pid                                (pid),
    .piderr                             (piderr),
    .usberr                             (usberr),
    .rcvfall                            (rcvfall),
    .txfall                             (txfall),
    .rxactiveff                         (rxactiveff),
    .rxtxidle                           (rxtxidle),
    .overflowwr                         (overflowwr),
    .sendhshk                           (sendhshk),
    .sendzeroiso                        (sendzeroiso),
    .sendpckt                           (sendpckt),
    .receive                            (receive),
    .dvi                                (dvi),
    .sendpid                            (sendpid),
    .outpngirq                          (outpngirq),
    .outpngirq_no                       (outpngirq_no),
    .sofirq                             (sofirq),

    .sendtok                            (sendtok),
    .hctoken                            (hctoken),
    .hcepnr                             (hcepnr),
    .upstren                            (upstren),
    .downstren                          (downstren),
    .hclocsof                           (hclocsof),
    .busidle                            (busidle),
    .lsmode                             (lsmode),
    .hcsleep_ack                        (hcsleep_ack),
    .hcfrmcount                         (hcfrmcount),
    .hcfrmnr                            (hcfrmnr),
    .hcdosetup                          (hcdosetup),
    .hclpmctrl                          (hclpmctrl),
    .hclpmctrlb                         (hclpmctrlb),
    .hcdolpm                            (hcdolpm),
    .lpmstate                           (lpmstate),
    .lpmstate_besl                      (lpmstate_besl),
    .hcdoisoin                          (hcdoisoin),
    .hcepsuspendin                      (hcepsuspendin),
    .hcepwaitin                         (hcepwaitin),
    .hcendpnrusbin                      (hcendpnrusbin),
    .hcunderrien                        (hcunderrien),
    .hcnakidisin                        (hcnakidisin),
    .hcdopingout                        (hcdopingout),
    .hcnakidisout                       (hcnakidisout),
    .hcdoisoout                         (hcdoisoout),
    .hcepsuspendout                     (hcepsuspendout),

    .busyff                             (busyff),
    .tokenok                            (tokenok),
    .sendstall                          (sendstall),

    .lpm_nyet                           (lpm_nyet_usb),
    .lpm_usbirq                         (lpm_usbirq_usb),
    .lpm_token                          (lpm_token),
    .lpm_token_84                       (lpm_token_84),
    .lpm_sleep_req                      (lpm_sleep_req),
    .lpmirq                             (lpmirq),
    .lpmirq_retry                       (lpmirq_retry),

    .sof_rcv_disable                    (sof_rcv_disable_usb),

    .hcnak_hshk                         (hcnak_hshk_usb),

    .enable                             (enable),
    .hsmode                             (hsmode),
    .usbreset                           (usbreset),
    .timeout                            (timeout)
    );




  cdnsusbhs_rxtxctrl
  U_CDNSUSBHS_RXTXCTRL
    (
    .usbclk                             (cusb2_utmiclk),
    .usbrst                             (cusb2_utmirst),
    .dvi                                (dvi),
    .fifodatai                          (indatard),
    .testmode                           (testmode),
    .testmodesel                        (testmodesel),
    .txfiford                           (txfiford),
    .rxfifowr                           (rxfifowr),
    .overflowwr                         (overflowwr),
    .outwr                              (outwr),
    .fifodatao                          (outdatawr),
    .hsmode                             (hsmode),
    .sendpid                            (sendpid),
    .sendzeroiso                        (sendzeroiso),
    .sendhshk                           (sendhshk),
    .sendpckt                           (sendpckt),
    .sendtok                            (sendtok),
    .hctoken                            (hctoken),
    .settoken                           (settoken),
    .receive                            (receive),
    .drivechirpk                        (drivechirpk),
    .drivechirpj                        (drivechirpj),
    .resumereq                          (resumereq),
    .hcepnr                             (hcepnr),
    .upstren                            (upstren),
    .lsmode                             (lsmode),
    .tfnaddr                            (tfnaddr),
    .tendp                              (tendp),
    .tendpnxt                           (tendpnxt),
    .tfrmnr                             (tfrmnr),
    .tfrmnrm                            (tfrmnrm),
    .pid                                (pid),
    .piderr                             (piderr),
    .usberr                             (usberr),
    .rcvfall                            (rcvfall),
    .txfall                             (txfall),
    .rxactiveff                         (rxactiveff),
    .rxtxidle                           (rxtxidle),
    .clrmfrmnr                          (clrmfrmnr),
    .clrmfrmnrack                       (clrmfrmnrack),
    .sofirq                             (sofirq),

    .utmitxready                        (cusb2_utmitxready),
    .utmitxvalid                        (cusb2_utmitxvalid),
    .utmidatain                         (cusb2_utmidatain),
    .utmirxactive                       (cusb2_utmirxactive),
    .utmirxerror                        (cusb2_utmirxerror),
    .utmirxvalid                        (cusb2_utmirxvalid),
    .utmidataout                        (cusb2_utmidataout),
    .utmitxvalidl                       (utmitxvalidl),

    .usbreset                           (usbreset),

    .linestate                          (cusb2_utmilinestate),
    .opmode                             (cusb2_utmiopmode),
    .xcvrselect                         (cusb2_utmixcvrselect),

    .debug_rx_req                       (debug_rx_req),
    .debug_rx                           (debug_rx),
    .debug_tx_req                       (debug_tx_req),
    .debug_tx                           (debug_tx),

    .workaround_a_req                   (workaround_a_req),
    .workaround_a_enable                (workaround_a_enable_usb),
    .workaround_b_enable                (workaround_b_enable_usb),
    .workaround_c_enable                (workaround_c_enable_usb),
    .workaround_d_enable                (workaround_d_enable_usb),
    .workaround_sfr_rst                 (workaround_sfr_rst_usb),
    .workaround_a_value                 (workaround_a_value_usb),
    .workaround_rst                     (workaround_rst),



    .lpm_token                          (lpm_token),
    .ince                               (ince),
    .busyff                             (busyff),
    .tokenok                            (tokenok),
    .timeout                            (timeout)
    );




  cdnsusbhs_ifctrlusb
  U_CDNSUSBHS_IFCTRLUSB
    (
    .usbclk                             (cusb2_utmiclk),
    .usbrst                             (cusb2_utmirst),

    .tendp                              (tendp),

    `ifdef CDNSUSBHS_EPIN_EXIST_15
    .usbfifoptrrd15                     (usbfifoptrrd15),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_14
    .usbfifoptrrd14                     (usbfifoptrrd14),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_13
    .usbfifoptrrd13                     (usbfifoptrrd13),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_12
    .usbfifoptrrd12                     (usbfifoptrrd12),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_11
    .usbfifoptrrd11                     (usbfifoptrrd11),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_10
    .usbfifoptrrd10                     (usbfifoptrrd10),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_9
    .usbfifoptrrd9                      (usbfifoptrrd9),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_8
    .usbfifoptrrd8                      (usbfifoptrrd8),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_7
    .usbfifoptrrd7                      (usbfifoptrrd7),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_6
    .usbfifoptrrd6                      (usbfifoptrrd6),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_5
    .usbfifoptrrd5                      (usbfifoptrrd5),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_4
    .usbfifoptrrd4                      (usbfifoptrrd4),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_3
    .usbfifoptrrd3                      (usbfifoptrrd3),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_2
    .usbfifoptrrd2                      (usbfifoptrrd2),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_1
    .usbfifoptrrd1                      (usbfifoptrrd1),
    `endif
    .usbfifoptrrd0                      (usbfifoptrrd0),

    `ifdef CDNSUSBHS_EPOUT_EXIST_15
    .usbfifoptrwr15                     (usbfifoptrwr15),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_14
    .usbfifoptrwr14                     (usbfifoptrwr14),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_13
    .usbfifoptrwr13                     (usbfifoptrwr13),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_12
    .usbfifoptrwr12                     (usbfifoptrwr12),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_11
    .usbfifoptrwr11                     (usbfifoptrwr11),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_10
    .usbfifoptrwr10                     (usbfifoptrwr10),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_9
    .usbfifoptrwr9                      (usbfifoptrwr9),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_8
    .usbfifoptrwr8                      (usbfifoptrwr8),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_7
    .usbfifoptrwr7                      (usbfifoptrwr7),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_6
    .usbfifoptrwr6                      (usbfifoptrwr6),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_5
    .usbfifoptrwr5                      (usbfifoptrwr5),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_4
    .usbfifoptrwr4                      (usbfifoptrwr4),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_3
    .usbfifoptrwr3                      (usbfifoptrwr3),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_2
    .usbfifoptrwr2                      (usbfifoptrwr2),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_1
    .usbfifoptrwr1                      (usbfifoptrwr1),
    `endif
    .usbfifoptrwr0                      (usbfifoptrwr0),

    `ifdef CDNSUSBHS_EPOUT_EXIST_15
    .out15startaddr                     (out15startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_14
    .out14startaddr                     (out14startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_13
    .out13startaddr                     (out13startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_12
    .out12startaddr                     (out12startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_11
    .out11startaddr                     (out11startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_10
    .out10startaddr                     (out10startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_9
    .out9startaddr                      (out9startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_8
    .out8startaddr                      (out8startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_7
    .out7startaddr                      (out7startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_6
    .out6startaddr                      (out6startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_5
    .out5startaddr                      (out5startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_4
    .out4startaddr                      (out4startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_3
    .out3startaddr                      (out3startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_2
    .out2startaddr                      (out2startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_1
    .out1startaddr                      (out1startaddr_usb),
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_15
    .in15startaddr                      (in15startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_14
    .in14startaddr                      (in14startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_13
    .in13startaddr                      (in13startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_12
    .in12startaddr                      (in12startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_11
    .in11startaddr                      (in11startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_10
    .in10startaddr                      (in10startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_9
    .in9startaddr                       (in9startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_8
    .in8startaddr                       (in8startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_7
    .in7startaddr                       (in7startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_6
    .in6startaddr                       (in6startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_5
    .in5startaddr                       (in5startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_4
    .in4startaddr                       (in4startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_3
    .in3startaddr                       (in3startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_2
    .in2startaddr                       (in2startaddr_usb),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_1
    .in1startaddr                       (in1startaddr_usb),
    `endif

    .outwr                              (outwr),
    .outdatawr                          (outdatawr),

    .inrd                               (inrd),
    .indatard                           (indatard),

    .out_rama_addr                      (out_rama_addr),
    .out_rama_wr                        (out_rama_wr),
    .out_rama_data                      (out_rama_data),

    .in_ramb_addr                       (in_ramb_addr),
    .in_ramb_rd                         (in_ramb_rd),
    .in_ramb_data                       (in_ramb_data)
    );




  cdnsusbhs_ifctrlup
  U_CDNSUSBHS_IFCTRLUP
    (
    .upclk                              (cusb2_upclk),
    .uprst                              (cusb2_uprst),

    .fifoaccrd                          (fifoaccrd),
    .fifoaccwr                          (fifoaccwr),

    `ifdef CDNSUSBHS_EPOUT_EXIST_15
    .upfifoptrrd15                      (upfifoptrrd15),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_14
    .upfifoptrrd14                      (upfifoptrrd14),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_13
    .upfifoptrrd13                      (upfifoptrrd13),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_12
    .upfifoptrrd12                      (upfifoptrrd12),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_11
    .upfifoptrrd11                      (upfifoptrrd11),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_10
    .upfifoptrrd10                      (upfifoptrrd10),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_9
    .upfifoptrrd9                       (upfifoptrrd9),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_8
    .upfifoptrrd8                       (upfifoptrrd8),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_7
    .upfifoptrrd7                       (upfifoptrrd7),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_6
    .upfifoptrrd6                       (upfifoptrrd6),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_5
    .upfifoptrrd5                       (upfifoptrrd5),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_4
    .upfifoptrrd4                       (upfifoptrrd4),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_3
    .upfifoptrrd3                       (upfifoptrrd3),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_2
    .upfifoptrrd2                       (upfifoptrrd2),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_1
    .upfifoptrrd1                       (upfifoptrrd1),
    `endif
    .upfifoptrrd0                       (upfifoptrrd0),

    `ifdef CDNSUSBHS_EPIN_EXIST_15
    .upfifoptrwr15                      (upfifoptrwr15),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_14
    .upfifoptrwr14                      (upfifoptrwr14),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_13
    .upfifoptrwr13                      (upfifoptrwr13),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_12
    .upfifoptrwr12                      (upfifoptrwr12),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_11
    .upfifoptrwr11                      (upfifoptrwr11),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_10
    .upfifoptrwr10                      (upfifoptrwr10),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_9
    .upfifoptrwr9                       (upfifoptrwr9),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_8
    .upfifoptrwr8                       (upfifoptrwr8),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_7
    .upfifoptrwr7                       (upfifoptrwr7),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_6
    .upfifoptrwr6                       (upfifoptrwr6),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_5
    .upfifoptrwr5                       (upfifoptrwr5),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_4
    .upfifoptrwr4                       (upfifoptrwr4),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_3
    .upfifoptrwr3                       (upfifoptrwr3),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_2
    .upfifoptrwr2                       (upfifoptrwr2),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_1
    .upfifoptrwr1                       (upfifoptrwr1),
    `endif
    .upfifoptrwr0                       (upfifoptrwr0),

    .fifoinfull                         (fifofull_int),
    .fifoinafull                        (fifoafull_int),
    .fifooutempty                       (fifoempty_int),

    `ifdef CDNSUSBHS_EPOUT_EXIST_15
    .fifooutbc15                        (fifobc_int15),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_14
    .fifooutbc14                        (fifobc_int14),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_13
    .fifooutbc13                        (fifobc_int13),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_12
    .fifooutbc12                        (fifobc_int12),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_11
    .fifooutbc11                        (fifobc_int11),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_10
    .fifooutbc10                        (fifobc_int10),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_9
    .fifooutbc9                         (fifobc_int9),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_8
    .fifooutbc8                         (fifobc_int8),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_7
    .fifooutbc7                         (fifobc_int7),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_6
    .fifooutbc6                         (fifobc_int6),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_5
    .fifooutbc5                         (fifobc_int5),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_4
    .fifooutbc4                         (fifobc_int4),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_3
    .fifooutbc3                         (fifobc_int3),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_2
    .fifooutbc2                         (fifobc_int2),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_1
    .fifooutbc1                         (fifobc_int1),
    `endif
    .fifooutbc0                         (fifobc_int0),

    `ifdef CDNSUSBHS_EPOUT_EXIST_15
    .out15startaddr                     (out15startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_14
    .out14startaddr                     (out14startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_13
    .out13startaddr                     (out13startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_12
    .out12startaddr                     (out12startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_11
    .out11startaddr                     (out11startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_10
    .out10startaddr                     (out10startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_9
    .out9startaddr                      (out9startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_8
    .out8startaddr                      (out8startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_7
    .out7startaddr                      (out7startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_6
    .out6startaddr                      (out6startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_5
    .out5startaddr                      (out5startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_4
    .out4startaddr                      (out4startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_3
    .out3startaddr                      (out3startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_2
    .out2startaddr                      (out2startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_1
    .out1startaddr                      (out1startaddr),
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_15
    .in15startaddr                      (in15startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_14
    .in14startaddr                      (in14startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_13
    .in13startaddr                      (in13startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_12
    .in12startaddr                      (in12startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_11
    .in11startaddr                      (in11startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_10
    .in10startaddr                      (in10startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_9
    .in9startaddr                       (in9startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_8
    .in8startaddr                       (in8startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_7
    .in7startaddr                       (in7startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_6
    .in6startaddr                       (in6startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_5
    .in5startaddr                       (in5startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_4
    .in4startaddr                       (in4startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_3
    .in3startaddr                       (in3startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_2
    .in2startaddr                       (in2startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_1
    .in1startaddr                       (in1startaddr),
    `endif

    .outptrinc                          (outptrinc),
    .fifooutaddr                        (fifooutaddr),
    .fifoinaddr                         (fifoinaddr),
    .fifodatai                          (fifoindatai),
    .fiford                             (fifooutrd),
    .fifowr                             (fifoinwr),
    .fifodatao                          (fifooutdatao),
    .fifofull                           (fifoinfull),
    .fifoafull                          (fifoinafull),
    .fifoempty                          (fifooutempty),
    .fifobc                             (fifooutbc),
    .fifooutrdff                        (fifooutrdff),
    .fifoctrl_7                         (fifoctrl_7),
    .upaddr                             (cusb2_upaddr),
    .updatai                            (cusb2_upwdata),
    .upwr                               (cusb2_upwr),
    .uprd                               (cusb2_uprd),
    .upbe_wr                            (cusb2_upbe_wr),
    .upbe_rd                            (cusb2_upbe_rd),
    .updatao                            (cusb2_uprdata),
    .sfrdata                            (sfrdatao),
    .ep0data                            (ep0datao),

    `ifdef CDNSUSBHS_EPOUT_EXIST_15
    .epoutdata15                        (epoutdata15),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_14
    .epoutdata14                        (epoutdata14),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_13
    .epoutdata13                        (epoutdata13),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_12
    .epoutdata12                        (epoutdata12),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_11
    .epoutdata11                        (epoutdata11),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_10
    .epoutdata10                        (epoutdata10),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_9
    .epoutdata9                         (epoutdata9),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_8
    .epoutdata8                         (epoutdata8),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_7
    .epoutdata7                         (epoutdata7),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_6
    .epoutdata6                         (epoutdata6),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_5
    .epoutdata5                         (epoutdata5),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_4
    .epoutdata4                         (epoutdata4),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_3
    .epoutdata3                         (epoutdata3),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_2
    .epoutdata2                         (epoutdata2),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_1
    .epoutdata1                         (epoutdata1),
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_15
    .epindata15                         (epindata15),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_14
    .epindata14                         (epindata14),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_13
    .epindata13                         (epindata13),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_12
    .epindata12                         (epindata12),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_11
    .epindata11                         (epindata11),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_10
    .epindata10                         (epindata10),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_9
    .epindata9                          (epindata9),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_8
    .epindata8                          (epindata8),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_7
    .epindata7                          (epindata7),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_6
    .epindata6                          (epindata6),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_5
    .epindata5                          (epindata5),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_4
    .epindata4                          (epindata4),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_3
    .epindata3                          (epindata3),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_2
    .epindata2                          (epindata2),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_1
    .epindata1                          (epindata1),
    `endif

    .out_ramb_addr                      (out_ramb_addr),
    .out_ramb_rd                        (out_ramb_rd),
    .out_ramb_data                      (out_ramb_data),

    .in_rama_addr                       (in_rama_addr),
    .in_rama_wr                         (in_rama_wr),
    .in_rama_data                       (in_rama_data)
    );




  cdnsusbhs_sfrs
  U_CDNSUSBHS_SFRS
    (
    .upclk                              (cusb2_upclk),
    .uprst                              (cusb2_uprst),
    .usbresetirq                        (usbresetirq_up),
    .hsmodeirq                          (hsmodeirq_up),
    .fnaddr                             (fnaddrup),
    .outbsyfall                         (outbsyfall),
    .inbsyfall                          (inbsyfall),
    .outpngirq                          (outpngirq_up),
    .outpngirq_no                       (outpngirq_no_up),
    .tfrmnr                             (tfrmnr_up),
    .tfrmnrm                            (tfrmnrm_up),
    .sofirq                             (sofirq_up),

    .sudav                              (sudav),
    .settoken                           (settoken_irq),
    .sigrsumclr                         (sigrsumclr_up),
    .toggleout                          (sfrstoggleout),
    .togglein                           (sfrstogglein),
    .suspreq                            (suspreq_up),
    .wakesrc                            (wakesrc_up),
    .lpmirq                             (lpmirq_up),
    .hcerrirqin                         (hcerrirqin),
    .hcerrirqout                        (hcerrirqout),
    .upstren                            (upstrenup),
    .suspendm_req                       (suspendm_req),
    .sleepm_req                         (sleepm_req),
    .fiforstin                          (fiforstin),
    .fiforstout                         (fiforstout),
    .togglerstin                        (togglerstin),
    .togglesetin                        (togglesetin),
    .togglerstout                       (togglerstout),
    .togglesetout                       (togglesetout),
    .usbintreq                          (usbintreq),
    .usbivect                           (usbivect),
    .dmaintreq                          (dmaintreq),
    .wuintreq                           (wuintreq_up),
    .sigrsum                            (sigrsum),
    .discon                             (discon),
    .lpm_nyet                           (lpm_nyet),
    .lpm_usbirq                         (lpm_usbirq),
    .suspendm_en                        (suspendm_en_up),
    .sleepm_en                          (sleepm_en_up),
    .portctrltm                         (portctrltm),
    .idleirq                            (idleirq_up),
    .srpdetirq                          (srpdetirq_up),
    .locsofirq                          (locsofirq_up),
    .vbuserrirq                         (vbuserrirq_up),
    .periphirq                          (periphirq_up),
    .idchangeirq                        (idchangeirq_up),
    .hostdisconirq                      (hostdisconirq_up),
    .bse0srpirq                         (bse0srpirq_up),
    .otgstate                           (otgstate_up),
    .otgstatus                          (otgstatus_up),
    .otgspeed                           (otgspeed_up),
    .usbrstsigclr                       (usbrstsigclr_up),
    .clrbhnpen                          (clrbhnpen_up),
    .lsmode                             (lsmode_up),
    .hcfrmcount                         (hcfrmcount_up),
    .hcfrmnr                            (hcfrmnr_up),
    .hcsendsof                          (hcsendsof_up),
    .otgctrl                            (otgctrl),
    .otgforce                           (otgforce),
    .otg2ctrl                           (otg2ctrl),
    .adpbc_ctrl_0                       (adpbc_ctrl_0),
    .adpbc_ctrl_1                       (adpbc_ctrl_1),
    .adpbc_ctrl_2                       (adpbc_ctrl_2),
    .adpbc_status_0                     (adpbc_status_0),
    .adpbc_status_1                     (adpbc_status_1),
    .adpbc_status_2                     (adpbc_status_2),
    .adpbc_rid_float_fall               (adpbc_rid_float_fall),
    .adpbc_rid_float_rise               (adpbc_rid_float_rise),
    .adpbc_rid_gnd_rise                 (adpbc_rid_gnd_rise),
    .adpbc_rid_c_rise                   (adpbc_rid_c_rise),
    .adpbc_rid_b_rise                   (adpbc_rid_b_rise),
    .adpbc_rid_a_rise                   (adpbc_rid_a_rise),
    .adpbc_sessend_rise                 (adpbc_sessend_rise),
    .adpbc_otgsessvalid_rise            (adpbc_otgsessvalid_rise),
    .adpbc_sense_rise                   (adpbc_sense_rise),
    .adpbc_probe_rise                   (adpbc_probe_rise),
    .dm_vdat_ref_rise                   (dm_vdat_ref_rise),
    .dp_vdat_ref_rise                   (dp_vdat_ref_rise),
    .dcd_comp_rise                      (dcd_comp_rise),
    .dcd_comp_fall                      (dcd_comp_fall),
    .dm_vlgc_comp_rise                  (dm_vlgc_comp_rise),
    .adp_change_ack                     (adp_change_ack_up),
    .tbvbuspls                          (tbvbuspls),
    .tbvbusdispls                       (tbvbusdispls),
    .tawaitbcon                         (tawaitbcon),
    .taaidlbdis                         (taaidlbdis),
    .usbrstsig                          (usbrstsig),
    .usbrstsig16ms                      (usbrstsig16ms),
    .usbrstsig55ms                      (usbrstsig55ms),
    .wuiden                             (wuiden),
    .wudpen                             (wudpen),
    .wuvbusen                           (wuvbusen),

    .upaddr                             (cusb2_upaddr),
    .upwr                               (cusb2_upwr),
    .updatai_0                          (cusb2_upwdata[7:0]),
    .updatai_1                          (cusb2_upwdata[15:8]),
    .updatai_2                          (cusb2_upwdata[23:16]),
    .updatai_3                          (cusb2_upwdata[31:24]),
    .updataival_0                       (cusb2_upbe_wr[0]),
    .updataival_1                       (cusb2_upbe_wr[1]),
    .updataival_2                       (cusb2_upbe_wr[2]),
    .updataival_3                       (cusb2_upbe_wr[3]),

    `ifdef CDNSUSBHS_EPOUT_EXIST_15
    .out15startaddr                     (out15startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_14
    .out14startaddr                     (out14startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_13
    .out13startaddr                     (out13startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_12
    .out12startaddr                     (out12startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_11
    .out11startaddr                     (out11startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_10
    .out10startaddr                     (out10startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_9
    .out9startaddr                      (out9startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_8
    .out8startaddr                      (out8startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_7
    .out7startaddr                      (out7startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_6
    .out6startaddr                      (out6startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_5
    .out5startaddr                      (out5startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_4
    .out4startaddr                      (out4startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_3
    .out3startaddr                      (out3startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_2
    .out2startaddr                      (out2startaddr),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_1
    .out1startaddr                      (out1startaddr),
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_15
    .in15startaddr                      (in15startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_14
    .in14startaddr                      (in14startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_13
    .in13startaddr                      (in13startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_12
    .in12startaddr                      (in12startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_11
    .in11startaddr                      (in11startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_10
    .in10startaddr                      (in10startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_9
    .in9startaddr                       (in9startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_8
    .in8startaddr                       (in8startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_7
    .in7startaddr                       (in7startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_6
    .in6startaddr                       (in6startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_5
    .in5startaddr                       (in5startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_4
    .in4startaddr                       (in4startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_3
    .in3startaddr                       (in3startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_2
    .in2startaddr                       (in2startaddr),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_1
    .in1startaddr                       (in1startaddr),
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_15
    .out15maxpck                        (out15maxpck),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_14
    .out14maxpck                        (out14maxpck),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_13
    .out13maxpck                        (out13maxpck),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_12
    .out12maxpck                        (out12maxpck),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_11
    .out11maxpck                        (out11maxpck),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_10
    .out10maxpck                        (out10maxpck),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_9
    .out9maxpck                         (out9maxpck),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_8
    .out8maxpck                         (out8maxpck),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_7
    .out7maxpck                         (out7maxpck),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_6
    .out6maxpck                         (out6maxpck),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_5
    .out5maxpck                         (out5maxpck),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_4
    .out4maxpck                         (out4maxpck),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_3
    .out3maxpck                         (out3maxpck),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_2
    .out2maxpck                         (out2maxpck),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_1
    .out1maxpck                         (out1maxpck),
    `endif
    .out0maxpck                         (out0maxpck),

    `ifdef CDNSUSBHS_EPIN_EXIST_15
    .in15maxpck                         (in15maxpck),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_14
    .in14maxpck                         (in14maxpck),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_13
    .in13maxpck                         (in13maxpck),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_12
    .in12maxpck                         (in12maxpck),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_11
    .in11maxpck                         (in11maxpck),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_10
    .in10maxpck                         (in10maxpck),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_9
    .in9maxpck                          (in9maxpck),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_8
    .in8maxpck                          (in8maxpck),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_7
    .in7maxpck                          (in7maxpck),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_6
    .in6maxpck                          (in6maxpck),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_5
    .in5maxpck                          (in5maxpck),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_4
    .in4maxpck                          (in4maxpck),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_3
    .in3maxpck                          (in3maxpck),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_2
    .in2maxpck                          (in2maxpck),
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_1
    .in1maxpck                          (in1maxpck),
    `endif
    .in0maxpck                          (in0maxpck),

    .inxisoautodump                     (inxisoautodump),
    .inxisoautoarm                      (inxisoautoarm),
    .inxisodctrl                        (inxisodctrl),

    .fifoctrl_7                         (fifoctrl_7),
    .hsdisable                          (hsdisable),

    .sof_rcv_disable                    (sof_rcv_disable),

    .fiforst                            (fiforst),

   `ifdef CDNSUSB2PHY_3RD
   `else
    .tsfr_rstb                          (tsfr_rstb),
    .tsfr_addr_req                      (tsfr_addr_req),
    .tsfr_addr                          (tsfr_addr),
    .tsfr_rdata_req                     (tsfr_rdata_req_up),
    .tsfr_rdata                         (tsfr_rdata),
    .tsfr_wdata_req                     (tsfr_wdata_req),
    .tsfr_wdata                         (tsfr_wdata),
    `endif

    .vbusfault                          (vbusfault_up),

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

    .debug_rx_req                       (debug_rx_req_up),
    .debug_rx                           (debug_rx),
    .debug_tx_req                       (debug_tx_req_up),
    .debug_tx                           (debug_tx),

    .workaround_a_req                   (workaround_a_req_up),
    .workaround_a_enable                (workaround_a_enable),
    .workaround_b_enable                (workaround_b_enable),
    .workaround_c_enable                (workaround_c_enable),
    .workaround_d_enable                (workaround_d_enable),
    .workaround_a_value                 (workaround_a_value),
    .workaround_sfr_rst                 (workaround_sfr_rst),

    .workaround_otg                     (workaround_otg),

    .isosofpulserequp                   (isosofpulserequp),
    .isosofpulseup                      (isosofpulseup),

    .upendian                           (cusb2_upendian),
    .updatao                            (sfrdatao)
    );




  cdnsusbhs_portctrl
  U_CDNSUSBHS_PORTCTRL
    (
    .usbclk                             (cusb2_utmiclk),
    .usbrst                             (cusb2_utmirst),
    .wakeup                             (wakeup_usb),
    .wakeup_a                           (wakeup),
    .wakeupid                           (wakeupid),
    .wakeupdp                           (wakeupdp),
    .wakeupvbus                         (wakeupvbus),
    .resumereq                          (resumereq),
    .wuintreq                           (wuintreq),
    .testmode                           (testmode),
    .testmodesel                        (testmodesel),
    .hsmode                             (hsmode),
    .hsmodeirq                          (hsmodeirq),
    .utmitxvalidl                       (utmitxvalidl),
    .lsmode                             (lsmode),
    .usbreset                           (usbreset),
    .usbresetirq                        (usbresetirq),

    .suspendm_req                       (suspendm_req_usb),
    .sleepm_req                         (sleepm_req_usb),
    .sigrsum_a                          (sigrsum),
    .sigrsum                            (sigrsum_usb),
    .discon                             (discon_usb),
    .sleepreq                           (sleepreq),
    .suspreq                            (suspreq),
    .sigrsumclr                         (sigrsumclr),
    .wakesrc                            (wakesrc),

    .hostdiscon                         (utmihostdiscon),
    .iddig                              (utmiiddig),
    .vbusvalid                          (utmivbusvalid),
    .avalid                             (utmiavalid),
    .bvalid                             (utmibvalid),
    .sessend                            (utmisessend),

    .linestate                          (cusb2_utmilinestate),
    .suspendm                           (cusb2_utmisuspendm),
    .sleepm                             (cusb2_utmisleepm),
    .lpmirq_retry                       (lpmirq_retry),
    .opmode                             (cusb2_utmiopmode),
    .termselect                         (cusb2_utmitermselect),
    .xcvrselect                         (cusb2_utmixcvrselect),

    .chrgvbus                           (cusb2_utmichrgvbus),
    .dischrgvbus                        (cusb2_utmidischrgvbus),
    .drvvbus                            (cusb2_utmidrvvbus),
    .locpulldndp                        (cusb2_utmidppulldown),
    .locpulldndm                        (cusb2_utmidmpulldown),
    .idpullup                           (cusb2_utmiidpullup),

    .bc_dmpulldown                      (bc_dmpulldown_usb),
    .bc_dppulldown                      (bc_dppulldown_usb),
    .bc_pulldownctrl                    (bc_pulldownctrl_usb),

    .drivechirpk                        (drivechirpk),
    .drivechirpj                        (drivechirpj),
    .tsmode                             (tsmode),
    .enable                             (enable),

    .lpm_sleep_req                      (lpm_sleep_req),
    .lpm_auto_entry                     (lpm_auto_entry_usb),
    .hsdisable                          (hsdisable_usb),

    .suspendm_en                        (suspendm_en),
    .sleepm_en                          (sleepm_en),
    .usbrstsig_a                        (usbrstsig),
    .usbrstsig                          (usbrstsig_usb),
    .usbrstsig16ms                      (usbrstsig16ms),
    .usbrstsig55ms                      (usbrstsig55ms),
    .hcsleep_ack                        (hcsleep_ack),
    .hclpmctrl_hird                     (hclpmctrl[7:4]),
    .hclpmctrlb                         (hclpmctrlb),
    .otgctrl_bus_req                    (otgctrl[0]),
    .otgctrl                            (otgctrl_usb),
    .otgforce                           (otgforce_usb),

    .otg2ctrl                           (otg2ctrl_usb),
    .tbvbuspls                          (tbvbuspls_usb),
    .tawaitbcon                         (tawaitbcon_usb),
    .taaidlbdis                         (taaidlbdis_usb),
    .wuiden                             (wuiden),
    .wudpen                             (wudpen),
    .wuvbusen                           (wuvbusen),
    .tbvbusdispls                       (tbvbusdispls_usb),
    .portctrltm                         (portctrltm_usb[4]),
    .busidle                            (busidle),
    .usbrstsigclr                       (usbrstsigclr),
    .lpmstate                           (lpmstate),
    .lpmstate_besl                      (lpmstate_besl),
    .hclocsof                           (hclocsof),
    .downstren                          (downstren),
    .upstren                            (upstren),
    .clrbhnpen                          (clrbhnpen),
    .otgstate                           (otgstate_usb),
    .downstrstate                       (downstrstate),
    .otgstatus                          (otgstatus),
    .otgspeed                           (otgspeed),
    .idleirq                            (idleirq),
    .srpdetirq                          (srpdetirq),
    .locsofirq                          (locsofirq),
    .vbuserrirq                         (vbuserrirq),
    .periphirq                          (periphirq),
    .idchangeirq                        (idchangeirq),
    .hostdisconirq                      (hostdisconirq),
    .bse0srpirq                         (bse0srpirq),
    .adp_change_ack                     (adp_change_ack),
    .upstrstate                         (upstrstate),

    .workaround_otg                     (workaround_otg_usb),

    .linestate_up                       (linestate_up),

    .timeout                            (timeout)
    );




  cdnsusbhs_adpctrl
  U_CDNSUSBHS_ADPCTRL
    (
    .upclk                              (cusb2_upclk),
    .uprst                              (cusb2_uprst),

    .adpbc_ctrl_0                       (adpbc_ctrl_0),
    .adpbc_ctrl_1                       (adpbc_ctrl_1),
    .adpbc_ctrl_2                       (adpbc_ctrl_2),

    .adpbc_status_0                     (adpbc_status_0),
    .adpbc_status_1                     (adpbc_status_1),
    .adpbc_status_2                     (adpbc_status_2),

    .adpbc_rid_float_fall               (adpbc_rid_float_fall),
    .adpbc_rid_float_rise               (adpbc_rid_float_rise),
    .adpbc_rid_gnd_rise                 (adpbc_rid_gnd_rise),
    .adpbc_rid_c_rise                   (adpbc_rid_c_rise),
    .adpbc_rid_b_rise                   (adpbc_rid_b_rise),
    .adpbc_rid_a_rise                   (adpbc_rid_a_rise),
    .adpbc_sessend_rise                 (adpbc_sessend_rise),
    .adpbc_otgsessvalid_rise            (adpbc_otgsessvalid_rise),
    .adpbc_sense_rise                   (adpbc_sense_rise),
    .adpbc_probe_rise                   (adpbc_probe_rise),
    .dm_vdat_ref_rise                   (dm_vdat_ref_rise),
    .dp_vdat_ref_rise                   (dp_vdat_ref_rise),
    .dcd_comp_rise                      (dcd_comp_rise),
    .dcd_comp_fall                      (dcd_comp_fall),
    .dm_vlgc_comp_rise                  (dm_vlgc_comp_rise),

    .bc_dmpulldown                      (bc_dmpulldown),
    .bc_dppulldown                      (bc_dppulldown),
    .bc_pulldownctrl                    (bc_pulldownctrl),

    .sessend                            (cusb2_utmisessend_up),
    .otgsessvalid                       (cusb2_utmibvalid_up),
    .linestate                          (cusb2_utmilinestate_up),



    .adp_en                             (cusb2_adp_en),
    .adp_probe_en                       (cusb2_adp_probe_en),
    .adp_sense_en                       (cusb2_adp_sense_en),
    .adp_sink_current_en                (cusb2_adp_sink_current_en),
    .adp_source_current_en              (cusb2_adp_source_current_en),

    .bc_en                              (cusb2_bc_en),
    .dm_vdat_ref_comp_en                (cusb2_dm_vdat_ref_comp_en),
    .dm_vlgc_comp_en                    (cusb2_dm_vlgc_comp_en),
    .dp_vdat_ref_comp_en                (cusb2_dp_vdat_ref_comp_en),
    .idm_sink_en                        (cusb2_idm_sink_en),
    .idp_sink_en                        (cusb2_idp_sink_en),
    .idp_src_en                         (cusb2_idp_src_en),
    .vdm_src_en                         (cusb2_vdm_src_en),
    .vdp_src_en                         (cusb2_vdp_src_en),
    .rid_float_comp_en                  (cusb2_rid_float_comp_en),
    .rid_nonfloat_comp_en               (cusb2_rid_nonfloat_comp_en),

    .adp_probe_ana                      (cusb2_adp_probe_ana_up),
    .adp_sense_ana                      (cusb2_adp_sense_ana_up),
    .dcd_comp_sts                       (cusb2_dcd_comp_sts_up),
    .dm_vdat_ref_comp_sts               (cusb2_dm_vdat_ref_comp_sts_up),
    .dm_vlgc_comp_sts                   (cusb2_dm_vlgc_comp_sts_up),
    .dp_vdat_ref_comp_sts               (cusb2_dp_vdat_ref_comp_sts_up),
    .rid_a_comp_sts                     (cusb2_rid_a_comp_sts_up),
    .rid_b_comp_sts                     (cusb2_rid_b_comp_sts_up),
    .rid_c_comp_sts                     (cusb2_rid_c_comp_sts_up),
    .rid_float_comp_sts                 (cusb2_rid_float_comp_sts_up),
    .rid_gnd_comp_sts                   (cusb2_rid_gnd_comp_sts_up)
    );



  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out15startaddr_usb = out15startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT15STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out15startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out15startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out14startaddr_usb = out14startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT14STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out14startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out14startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out13startaddr_usb = out13startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT13STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out13startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out13startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out12startaddr_usb = out12startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT12STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out12startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out12startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out11startaddr_usb = out11startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT11STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out11startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out11startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out10startaddr_usb = out10startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT10STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out10startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out10startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out9startaddr_usb = out9startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT9STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out9startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out9startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out8startaddr_usb = out8startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT8STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out8startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out8startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out7startaddr_usb = out7startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT7STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out7startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out7startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out6startaddr_usb = out6startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT6STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out6startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out6startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out5startaddr_usb = out5startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT5STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out5startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out5startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out4startaddr_usb = out4startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT4STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out4startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out4startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out3startaddr_usb = out3startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT3STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out3startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out3startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out2startaddr_usb = out2startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT2STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out2startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out2startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  `ifdef CDNSUSBHS_NO_OUTXSTARTADDR_SYNCFF
  assign out1startaddr_usb = out1startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (OUTADDRWIDTH-2)
  `else
    OUTADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_OUT1STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (out1startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (out1startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_15
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in15startaddr_usb = in15startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN15STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in15startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in15startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_14
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in14startaddr_usb = in14startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN14STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in14startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in14startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_13
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in13startaddr_usb = in13startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN13STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in13startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in13startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_12
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in12startaddr_usb = in12startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN12STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in12startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in12startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_11
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in11startaddr_usb = in11startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN11STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in11startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in11startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_10
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in10startaddr_usb = in10startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN10STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in10startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in10startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_9
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in9startaddr_usb = in9startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN9STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in9startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in9startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_8
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in8startaddr_usb = in8startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN8STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in8startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in8startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_7
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in7startaddr_usb = in7startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN7STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in7startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in7startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_6
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in6startaddr_usb = in6startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN6STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in6startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in6startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_5
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in5startaddr_usb = in5startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN5STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in5startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in5startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_4
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in4startaddr_usb = in4startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN4STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in4startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in4startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_3
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in3startaddr_usb = in3startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN3STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in3startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in3startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_2
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in2startaddr_usb = in2startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN2STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in2startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in2startaddr_usb)
    );
  `endif
  `endif



  `ifdef CDNSUSBHS_EPIN_EXIST_1
  `ifdef CDNSUSBHS_NO_INXSTARTADDR_SYNCFF
  assign in1startaddr_usb = in1startaddr;
  `else
  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (INADDRWIDTH-2)
  `else
    INADDRWIDTH-2
  `endif
    )
  U_CDNSUSBHS_IN1STARTADDR_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (in1startaddr),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (in1startaddr_usb)
    );
  `endif
  `endif



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd8)
  `else
    8
  `endif
    )
  U_CDNSUSBHS_TBVBUSPLS_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (tbvbuspls),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (tbvbuspls_usb)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd8)
  `else
    8
  `endif
    )
  U_CDNSUSBHS_TBVBUSDISPLS_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (tbvbusdispls),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (tbvbusdispls_usb)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd8)
  `else
    8
  `endif
    )
  U_CDNSUSBHS_TAWAITBCON_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (tawaitbcon),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (tawaitbcon_usb)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd8)
  `else
    8
  `endif
    )
  U_CDNSUSBHS_TAAIDLBDIS_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (taaidlbdis),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (taaidlbdis_usb)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd8)
  `else
    8
  `endif
    )
  U_CDNSUSBHS_OTGSTATUS_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txdata                             (otgstatus),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (otgstatus_up)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd5)
  `else
    5
  `endif
    )
  U_CDNSUSBHS_OTGSTATE_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txdata                             (otgstate_usb),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (otgstate_up)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd3)
  `else
    3
  `endif
    )
  U_CDNSUSBHS_OTGSPEED_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txdata                             (otgspeed),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (otgspeed_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_IDLEIRQ
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (idleirq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (idleirq_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_SRPDETIRQ
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (srpdetirq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (srpdetirq_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_LOCSOFIRQ
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (locsofirq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (locsofirq_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_VBUSERRIRQ
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (vbuserrirq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (vbuserrirq_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_PERIPHIRQ
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (periphirq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (periphirq_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_IDCHANGEIRQ
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (idchangeirq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (idchangeirq_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_HOSTDISCONIRQ
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (hostdisconirq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (hostdisconirq_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_BSE0SRPIRQ
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (bse0srpirq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (bse0srpirq_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_USBRESETIRQ
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (usbresetirq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (usbresetirq_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_HSMODEIRQ
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (hsmodeirq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (hsmodeirq_up)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd11)
  `else
    11
  `endif
    )
  U_CDNSUSBHS_HCFRMCOUNT_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txdata                             (hcfrmcount),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (hcfrmcount_up)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd16)
  `else
    16
  `endif
    )
  U_CDNSUSBHS_HCFRMNR_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txdata                             (hcfrmnr),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (hcfrmnr_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_ENTERHM_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (enterhm),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (enterhmup)
    );



  cdnsusbhs_load_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd4)
  `else
    4
  `endif
    )
  U_CDNSUSBHS_OUTPNGIRQ_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txload                             (outpngirq),
    .txdata                             (outpngirq_no),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxstrobe                           (outpngirq_up),
    .rxdata                             (outpngirq_no_up)
    );



  cdnsusbhs_load_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd4)
  `else
    4
  `endif
    )
  U_CDNSUSBHS_INNAK_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txload                             (innak_usb),
    .txdata                             (innak_no_usb),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxstrobe                           (innak),
    .rxdata                             (innak_no)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_UTMIHOSTDISCON_USB
    (

    .txsignal                           (cusb2_utmihostdiscon),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxsignal                           (utmihostdiscon)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_UTMIIDDIG_USB
    (

    .txsignal                           (cusb2_utmiiddig),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxsignal                           (utmiiddig)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_UTMIVBUSVALID_USB
    (

    .txsignal                           (cusb2_utmivbusvalid),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxsignal                           (utmivbusvalid)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_UTMIAVALID_USB
    (

    .txsignal                           (cusb2_utmiavalid),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxsignal                           (utmiavalid)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_UTMIBVALID_USB
    (

    .txsignal                           (cusb2_utmibvalid),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxsignal                           (utmibvalid)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_UTMISESSEND_USB
    (

    .txsignal                           (cusb2_utmisessend),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxsignal                           (utmisessend)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_SOFIRQ_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (sofirq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (sofirq_up)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd11)
  `else
    11
  `endif
    )
  U_CDNSUSBHS_TFRMNR_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txdata                             (tfrmnr),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (tfrmnr_up)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd3)
  `else
    3
  `endif
    )
  U_CDNSUSBHS_TFRMNRM_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txdata                             (tfrmnrm),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (tfrmnrm_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_HCSENDSOF_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (hcsendsof),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (hcsendsof_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_SETTOKEN_IRQ_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (settoken),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (settoken_irq)
    );



















  cdnsusbhs_signal_sync
  U_CDNSUSBHS_ISOSOFPULSEREQUP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (isosofpulsereq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (isosofpulserequp)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_LPMIRQ_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (lpmirq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (lpmirq_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_SUSPREQ_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (suspreq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (suspreq_up)
    );



  cdnsusbhs_dffn_sync
  U_CDNSUSBHS_DISCON_USB
    (

    .txsignal                           (discon),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxsignal                           (discon_usb)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_USBRESET_UP
    (

    .txdata                             (usbreset),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (usbreset_up)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_UPSTREN_UP
    (

    .txdata                             (upstren),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (upstrenup)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd7)
  `else
    7
  `endif
    )
  U_CDNSUSBHS_OTGCTRL_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (otgctrl),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (otgctrl_usb)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd8)
  `else
    8
  `endif
    )
  U_CDNSUSBHS_OTGFORCE_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (otgforce),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (otgforce_usb)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd2)
  `else
    2
  `endif
    )
  U_CDNSUSBHS_OTG2CTRL_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (otg2ctrl),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (otg2ctrl_usb)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_CLRBHNPEN_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (clrbhnpen),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (clrbhnpen_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_ADP_CHANGE_ACK_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (adp_change_ack),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (adp_change_ack_up)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_SLEEPM_EN_UP
    (

    .txdata                             (sleepm_en),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (sleepm_en_up)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_SUSPENDM_EN_UP
    (

    .txdata                             (suspendm_en),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (suspendm_en_up)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_WAKESRC_UP
    (

    .txdata                             (wakesrc),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (wakesrc_up)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_HSDISABLE_USB
    (

    .txdata                             (hsdisable),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (hsdisable_usb)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_SIGRSUM_USB
    (

    .txdata                             (sigrsum),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (sigrsum_usb)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_SIGRSUMCLR_UP
    (

    .txdata                             (sigrsumclr),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (sigrsumclr_up)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_USBRSTSIG_USB
    (

    .txdata                             (usbrstsig),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (usbrstsig_usb)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_USBRSTSIGCLR_UP
    (

    .txdata                             (usbrstsigclr),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (usbrstsigclr_up)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_WAKEUP_USB
    (

    .txsignal                           (wakeup),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxsignal                           (wakeup_usb)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_LPM_NYET_USB
    (

    .txdata                             (lpm_nyet),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (lpm_nyet_usb)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_LPM_USBIRQ_USB
    (

    .txdata                             (lpm_usbirq),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (lpm_usbirq_usb)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_LPM_AUTO_ENTRY_USB
    (

    .txdata                             (lpm_auto_entry),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (lpm_auto_entry_usb)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_SUSPENDM_REQ_USB
    (

    .txdata                             (suspendm_req),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (suspendm_req_usb)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_SLEEPM_REQ_USB
    (

    .txdata                             (sleepm_req),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (sleepm_req_usb)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_LSMODE_UP
    (

    .txdata                             (lsmode),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxdata                             (lsmode_up)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd5)
  `else
    5
  `endif
    )
  U_CDNSUSBHS_PORTCTRLTM_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (portctrltm),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (portctrltm_usb)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_UTMIBVALID_UP
    (

    .txsignal                           (cusb2_utmibvalid),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_utmibvalid_up)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_ADP_PROBE_ANA_UP
    (

    .txsignal                           (cusb2_adp_probe_ana),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_adp_probe_ana_up)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_ADP_SENSE_ANA_UP
    (

    .txsignal                           (cusb2_adp_sense_ana),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_adp_sense_ana_up)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_DCD_COMP_STS_UP
    (

    .txsignal                           (cusb2_dcd_comp_sts),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_dcd_comp_sts_up)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_DM_VDAT_REF_COMP_STS_UP
    (

    .txsignal                           (cusb2_dm_vdat_ref_comp_sts),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_dm_vdat_ref_comp_sts_up)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_DM_VLGC_COMP_STS_UP
    (

    .txsignal                           (cusb2_dm_vlgc_comp_sts),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_dm_vlgc_comp_sts_up)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_DP_VDAT_REF_COMP_STS_UP
    (

    .txsignal                           (cusb2_dp_vdat_ref_comp_sts),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_dp_vdat_ref_comp_sts_up)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_RID_A_COMP_STS_UP
    (

    .txsignal                           (cusb2_rid_a_comp_sts),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_rid_a_comp_sts_up)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_RID_B_COMP_STS_UP
    (

    .txsignal                           (cusb2_rid_b_comp_sts),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_rid_b_comp_sts_up)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_RID_C_COMP_STS_UP
    (

    .txsignal                           (cusb2_rid_c_comp_sts),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_rid_c_comp_sts_up)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_UTMISESSEND_UP
    (

    .txsignal                           (cusb2_utmisessend),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_utmisessend_up)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_RID_FLOAT_COMP_STS_UP
    (

    .txsignal                           (cusb2_rid_float_comp_sts),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_rid_float_comp_sts_up)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_RID_GND_COMP_STS_UP
    (

    .txsignal                           (cusb2_rid_gnd_comp_sts),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_rid_gnd_comp_sts_up)
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_UTMILINESTATE1_UP
    (

    .txsignal                           (linestate_up[1]),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_utmilinestate_up[1])
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_CUSB2_UTMILINESTATE0_UP
    (

    .txsignal                           (linestate_up[0]),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (cusb2_utmilinestate_up[0])
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_WUINTREQ_UP
    (

    .txsignal                           (wuintreq),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (wuintreq_up)
    );



  cdnsusbhs_dffn_sync
  U_CDNSUSBHS_VBUSFAULT_UP
    (

    .txsignal                           (vbusfault),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (vbusfault_up)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd3)
  `else
    3
  `endif
    )
  U_CDNSUSBHS_BC_PULLDOWN_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             ({bc_dmpulldown, bc_dppulldown, bc_pulldownctrl}),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             ({bc_dmpulldown_usb, bc_dppulldown_usb, bc_pulldownctrl_usb})
    );

  `ifdef CDNSUSB2PHY_3RD
  `else


  cdnsusbhs_dff_sync
  U_TSFR_RDATA_REQ_UP
    (

    .txsignal                           (tsfr_rdata_req),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (tsfr_rdata_req_up)
    );
  `endif



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_DEBUG_RX_REQ_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (debug_rx_req),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (debug_rx_req_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_DEBUG_TX_REQ_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (debug_tx_req),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (debug_tx_req_up)
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_WORKAROUND_A_REQ_UP
    (

    .txclk                              (cusb2_utmiclk),
    .txrst                              (cusb2_utmirst),
    .txsignal                           (workaround_a_req),


    .rxclk                              (cusb2_upclk),
    .rxrst                              (cusb2_uprst),
    .rxsignal                           (workaround_a_req_up)
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd4)
  `else
    4
  `endif
    )
  U_CDNSUSBHS_WORKAROUND_ENABLE_USB
    (

    .txdata                             ({workaround_d_enable,
                                          workaround_c_enable,
                                          workaround_b_enable,
                                          workaround_a_enable}),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             ({workaround_d_enable_usb,
                                          workaround_c_enable_usb,
                                          workaround_b_enable_usb,
                                          workaround_a_enable_usb})
    );



  cdnsusbhs_signal_sync
  U_CDNSUSBHS_WORKAROUND_SFRS_RST_UP
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txsignal                           (workaround_sfr_rst),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxsignal                           (workaround_sfr_rst_usb)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd4)
  `else
    4
  `endif
    )
  U_CDNSUSBHS_WORKAROUND_A_VALUE_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (workaround_a_value),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (workaround_a_value_usb)
    );



  cdnsusbhs_dffn_sync
  U_CDNSUSBHS_WORKAROUND_OTG_USB_0
    (

    .txsignal                           (workaround_otg[0]),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxsignal                           (workaround_otg_usb[0])
    );



  cdnsusbhs_dffn_sync
  U_CDNSUSBHS_WORKAROUND_OTG_USB_1
    (

    .txsignal                           (workaround_otg[1]),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxsignal                           (workaround_otg_usb[1])
    );



  cdnsusbhs_dff_sync
  U_CDNSUSBHS_WORKAROUND_OTG_USB_2
    (

    .txsignal                           (workaround_otg[2]),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxsignal                           (workaround_otg_usb[2])
    );



  cdnsusbhs_bit_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd1)
  `else
    1
  `endif
    )
  U_CDNSUSBHS_SOF_RCV_DISABLE_USB
    (

    .txdata                             (sof_rcv_disable),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (sof_rcv_disable_usb)
    );



  cdnsusbhs_data_sync
    #(
  `ifdef CDNSUSBHS_VERILOG_2001
    .DATA_SYNC_WIDTH                    (32'd6)
  `else
    6
  `endif
    )
  U_CDNSUSBHS_HCNAK_HSHK_USB
    (

    .txclk                              (cusb2_upclk),
    .txrst                              (cusb2_uprst),
    .txdata                             (hcnak_hshk),


    .rxclk                              (cusb2_utmiclk),
    .rxrst                              (cusb2_utmirst),
    .rxdata                             (hcnak_hshk_usb)
    );

endmodule

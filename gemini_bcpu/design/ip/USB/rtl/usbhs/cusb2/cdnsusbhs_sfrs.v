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
//   Filename:           cdnsusbhs_sfrs.v
//   Module Name:        cdnsusbhs_sfrs
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
//   Special Function Registers
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"





module cdnsusbhs_sfrs
  (
  upclk,
  uprst,
  usbresetirq,
  hsmodeirq,
  fnaddr,
  outbsyfall,
  inbsyfall,
  outpngirq,
  outpngirq_no,
  lpmirq,
  tfrmnr,
  tfrmnrm,
  sofirq,
  sudav,
  settoken,
  sigrsumclr,
  toggleout,
  togglein,
  suspreq,
  wakesrc,

  upaddr,
  upwr,
  updatai_0,
  updatai_1,
  updatai_2,
  updatai_3,
  updataival_0,
  updataival_1,
  updataival_2,
  updataival_3,

  suspendm_req,
  sleepm_req,
  fiforstin,
  fiforstout,
  togglerstin,
  togglesetin,
  togglerstout,
  togglesetout,
  usbintreq,
  usbivect,
  dmaintreq,
  wuintreq,
  sigrsum,
  discon,
  lpm_nyet,
  lpm_usbirq,

  inxisoautodump,
  inxisoautoarm,
  inxisodctrl,

  suspendm_en,
  sleepm_en,

  hcerrirqin,
  hcerrirqout,
  upstren,
  idleirq,
  srpdetirq,
  locsofirq,
  vbuserrirq,
  periphirq,
  idchangeirq,
  hostdisconirq,
  bse0srpirq,
  otgstate,
  otgstatus,
  usbrstsigclr,
  clrbhnpen,
  lsmode,
  hcfrmcount,
  hcfrmnr,
  hcsendsof,
  portctrltm,
  otgctrl,
  otgforce,
  otg2ctrl,
  adpbc_ctrl_0,
  adpbc_ctrl_1,
  adpbc_ctrl_2,
  adpbc_status_0,
  adpbc_status_1,
  adpbc_status_2,
  adpbc_rid_float_fall,
  adpbc_rid_float_rise,
  adpbc_rid_gnd_rise,
  adpbc_rid_c_rise,
  adpbc_rid_b_rise,
  adpbc_rid_a_rise,
  adpbc_sessend_rise,
  adpbc_otgsessvalid_rise,
  adpbc_sense_rise,
  adpbc_probe_rise,
  dm_vdat_ref_rise,
  dp_vdat_ref_rise,
  dcd_comp_rise,
  dcd_comp_fall,
  dm_vlgc_comp_rise,
  adp_change_ack,
  tbvbuspls,
  tbvbusdispls,
  tawaitbcon,
  taaidlbdis,
  usbrstsig,
  usbrstsig55ms,
  usbrstsig16ms,
  wuiden,
  wudpen,
  wuvbusen,

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  out15startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  out14startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  out13startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  out12startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  out11startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  out10startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  out9startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  out8startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  out7startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  out6startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  out5startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  out4startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  out3startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  out2startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  out1startaddr,
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  in15startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  in14startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  in13startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  in12startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  in11startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  in10startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  in9startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  in8startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  in7startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  in6startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  in5startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  in4startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  in3startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  in2startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  in1startaddr,
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  out15maxpck,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  out14maxpck,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  out13maxpck,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  out12maxpck,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  out11maxpck,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  out10maxpck,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  out9maxpck,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  out8maxpck,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  out7maxpck,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  out6maxpck,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  out5maxpck,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  out4maxpck,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  out3maxpck,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  out2maxpck,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  out1maxpck,
  `endif
  out0maxpck,

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  in15maxpck,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  in14maxpck,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  in13maxpck,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  in12maxpck,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  in11maxpck,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  in10maxpck,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  in9maxpck,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  in8maxpck,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  in7maxpck,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  in6maxpck,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  in5maxpck,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  in4maxpck,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  in3maxpck,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  in2maxpck,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  in1maxpck,
  `endif
  in0maxpck,

  fifoctrl_7,
  hsdisable,

  fiforst,

  otgspeed,

  vbusfault,

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

  debug_rx_req,
  debug_rx,
  debug_tx_req,
  debug_tx,

  workaround_a_req,
  workaround_a_enable,
  workaround_b_enable,
  workaround_c_enable,
  workaround_d_enable,
  workaround_a_value,
  workaround_sfr_rst,

  workaround_otg,

  isosofpulserequp,
  isosofpulseup,

  sof_rcv_disable,

  upendian,
  updatao
  );

  parameter OUTADDRWIDTH = 32'd`CDNSUSBHS_OUTADDRWIDTH;
  parameter INADDRWIDTH  = 32'd`CDNSUSBHS_INADDRWIDTH;

  parameter EPINEXIST    = `CDNSUSBHS_EPINEXIST;
  parameter EPOUTEXIST   = `CDNSUSBHS_EPOUTEXIST;

  `include "cdnsusbhs_cusb2_params.v"

  input                         upclk;
  input                         uprst;
  input                         usbresetirq;
  input                         hsmodeirq;
  input  [6:0]                  fnaddr;
  input  [15:0]                 outbsyfall;
  input  [15:0]                 inbsyfall;
  input                         outpngirq;
  input  [3:0]                  outpngirq_no;
  input                         lpmirq;
  input  [10:0]                 tfrmnr;
  input  [2:0]                  tfrmnrm;
  input                         sofirq;
  input                         sudav;
  input                         settoken;
  input                         sigrsumclr;
  input  [15:0]                 toggleout;
  input  [15:0]                 togglein;
  input                         suspreq;
  input                         wakesrc;

  input  [7:0]                  upaddr;
  input                         upwr;
  input  [7:0]                  updatai_0;
  input  [7:0]                  updatai_1;
  input  [7:0]                  updatai_2;
  input  [7:0]                  updatai_3;
  input                         updataival_0;
  input                         updataival_1;
  input                         updataival_2;
  input                         updataival_3;

  output                        suspendm_req;
  reg                           suspendm_req;
  output                        sleepm_req;
  reg                           sleepm_req;
  output [15:0]                 fiforstin;
  wire   [15:0]                 fiforstin;
  output [15:0]                 fiforstout;
  wire   [15:0]                 fiforstout;
  output [15:1]                 togglerstin;
  wire   [15:1]                 togglerstin;
  output [15:1]                 togglesetin;
  wire   [15:1]                 togglesetin;
  output [15:1]                 togglerstout;
  wire   [15:1]                 togglerstout;
  output [15:1]                 togglesetout;
  wire   [15:1]                 togglesetout;
  output                        usbintreq;
  reg                           usbintreq;
  output [7:0]                  usbivect;
  wire   [7:0]                  usbivect;
  input                         dmaintreq;
  input                         wuintreq;
  output                        sigrsum;
  wire                          sigrsum;
  output                        discon;
  wire                          discon;
  output                        lpm_nyet;
  wire                          lpm_nyet;
  output                        lpm_usbirq;
  wire                          lpm_usbirq;

  output [15:1]                 inxisoautodump;
  wire   [15:1]                 inxisoautodump;
  output [15:1]                 inxisoautoarm;
  wire   [15:1]                 inxisoautoarm;
  output [15:1]                 inxisodctrl;
  wire   [15:1]                 inxisodctrl;

  input                         suspendm_en;
  input                         sleepm_en;

  input  [15:0]                 hcerrirqin;
  input  [15:0]                 hcerrirqout;
  input                         upstren;
  input                         idleirq;
  input                         srpdetirq;
  input                         locsofirq;
  input                         vbuserrirq;
  input                         periphirq;
  input                         idchangeirq;
  input                         hostdisconirq;
  input                         bse0srpirq;
  input  [4:0]                  otgstate;
  input  [7:0]                  otgstatus;
  input                         usbrstsigclr;
  input                         clrbhnpen;
  input                         lsmode;
  input  [10:0]                 hcfrmcount;
  input  [15:0]                 hcfrmnr;
  input                         hcsendsof;

  output [4:0]                  portctrltm;
  wire   [4:0]                  portctrltm;
  output [6:0]                  otgctrl;
  reg    [6:0]                  otgctrl;
  output [7:0]                  otgforce;
  reg    [7:0]                  otgforce;
  output [1:0]                  otg2ctrl;
  reg    [1:0]                  otg2ctrl;
  output [4:0]                  adpbc_ctrl_0;
  reg    [4:0]                  adpbc_ctrl_0;
  output [5:0]                  adpbc_ctrl_1;
  reg    [5:0]                  adpbc_ctrl_1;
  output [7:0]                  adpbc_ctrl_2;
  reg    [7:0]                  adpbc_ctrl_2;
  input  [7:0]                  adpbc_status_0;
  input  [7:0]                  adpbc_status_1;
  input  [4:0]                  adpbc_status_2;

  input                         adpbc_rid_float_fall;
  input                         adpbc_rid_float_rise;
  input                         adpbc_rid_gnd_rise;
  input                         adpbc_rid_c_rise;
  input                         adpbc_rid_b_rise;
  input                         adpbc_rid_a_rise;
  input                         adpbc_sessend_rise;
  input                         adpbc_otgsessvalid_rise;
  input                         adpbc_sense_rise;
  input                         adpbc_probe_rise;
  input                         dm_vdat_ref_rise;
  input                         dp_vdat_ref_rise;
  input                         dcd_comp_rise;
  input                         dcd_comp_fall;
  input                         dm_vlgc_comp_rise;
  input                         adp_change_ack;

  output [7:0]                  tbvbuspls;
  reg    [7:0]                  tbvbuspls;
  output [7:0]                  tbvbusdispls;
  reg    [7:0]                  tbvbusdispls;
  output [7:0]                  tawaitbcon;
  reg    [7:0]                  tawaitbcon;
  output [7:0]                  taaidlbdis;
  reg    [7:0]                  taaidlbdis;
  output                        usbrstsig;
  wire                          usbrstsig;
  output                        usbrstsig55ms;
  wire                          usbrstsig55ms;
  output                        usbrstsig16ms;
  wire                          usbrstsig16ms;
  output                        wuiden;
  reg                           wuiden;
  output                        wudpen;
  reg                           wudpen;
  output                        wuvbusen;
  reg                           wuvbusen;

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  output [OUTADDRWIDTH-1:2]     out15startaddr;
  reg    [OUTADDRWIDTH-1:2]     out15startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  output [OUTADDRWIDTH-1:2]     out14startaddr;
  reg    [OUTADDRWIDTH-1:2]     out14startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  output [OUTADDRWIDTH-1:2]     out13startaddr;
  reg    [OUTADDRWIDTH-1:2]     out13startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  output [OUTADDRWIDTH-1:2]     out12startaddr;
  reg    [OUTADDRWIDTH-1:2]     out12startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  output [OUTADDRWIDTH-1:2]     out11startaddr;
  reg    [OUTADDRWIDTH-1:2]     out11startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  output [OUTADDRWIDTH-1:2]     out10startaddr;
  reg    [OUTADDRWIDTH-1:2]     out10startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  output [OUTADDRWIDTH-1:2]     out9startaddr;
  reg    [OUTADDRWIDTH-1:2]     out9startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  output [OUTADDRWIDTH-1:2]     out8startaddr;
  reg    [OUTADDRWIDTH-1:2]     out8startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  output [OUTADDRWIDTH-1:2]     out7startaddr;
  reg    [OUTADDRWIDTH-1:2]     out7startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  output [OUTADDRWIDTH-1:2]     out6startaddr;
  reg    [OUTADDRWIDTH-1:2]     out6startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  output [OUTADDRWIDTH-1:2]     out5startaddr;
  reg    [OUTADDRWIDTH-1:2]     out5startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  output [OUTADDRWIDTH-1:2]     out4startaddr;
  reg    [OUTADDRWIDTH-1:2]     out4startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  output [OUTADDRWIDTH-1:2]     out3startaddr;
  reg    [OUTADDRWIDTH-1:2]     out3startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  output [OUTADDRWIDTH-1:2]     out2startaddr;
  reg    [OUTADDRWIDTH-1:2]     out2startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  output [OUTADDRWIDTH-1:2]     out1startaddr;
  reg    [OUTADDRWIDTH-1:2]     out1startaddr;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  output [INADDRWIDTH-1:2]      in15startaddr;
  reg    [INADDRWIDTH-1:2]      in15startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  output [INADDRWIDTH-1:2]      in14startaddr;
  reg    [INADDRWIDTH-1:2]      in14startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  output [INADDRWIDTH-1:2]      in13startaddr;
  reg    [INADDRWIDTH-1:2]      in13startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  output [INADDRWIDTH-1:2]      in12startaddr;
  reg    [INADDRWIDTH-1:2]      in12startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  output [INADDRWIDTH-1:2]      in11startaddr;
  reg    [INADDRWIDTH-1:2]      in11startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  output [INADDRWIDTH-1:2]      in10startaddr;
  reg    [INADDRWIDTH-1:2]      in10startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  output [INADDRWIDTH-1:2]      in9startaddr;
  reg    [INADDRWIDTH-1:2]      in9startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  output [INADDRWIDTH-1:2]      in8startaddr;
  reg    [INADDRWIDTH-1:2]      in8startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  output [INADDRWIDTH-1:2]      in7startaddr;
  reg    [INADDRWIDTH-1:2]      in7startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  output [INADDRWIDTH-1:2]      in6startaddr;
  reg    [INADDRWIDTH-1:2]      in6startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  output [INADDRWIDTH-1:2]      in5startaddr;
  reg    [INADDRWIDTH-1:2]      in5startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  output [INADDRWIDTH-1:2]      in4startaddr;
  reg    [INADDRWIDTH-1:2]      in4startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  output [INADDRWIDTH-1:2]      in3startaddr;
  reg    [INADDRWIDTH-1:2]      in3startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  output [INADDRWIDTH-1:2]      in2startaddr;
  reg    [INADDRWIDTH-1:2]      in2startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  output [INADDRWIDTH-1:2]      in1startaddr;
  reg    [INADDRWIDTH-1:2]      in1startaddr;
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  output [10:0]                 out15maxpck;
  reg    [10:0]                 out15maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  output [10:0]                 out14maxpck;
  reg    [10:0]                 out14maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  output [10:0]                 out13maxpck;
  reg    [10:0]                 out13maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  output [10:0]                 out12maxpck;
  reg    [10:0]                 out12maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  output [10:0]                 out11maxpck;
  reg    [10:0]                 out11maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  output [10:0]                 out10maxpck;
  reg    [10:0]                 out10maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  output [10:0]                 out9maxpck;
  reg    [10:0]                 out9maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  output [10:0]                 out8maxpck;
  reg    [10:0]                 out8maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  output [10:0]                 out7maxpck;
  reg    [10:0]                 out7maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  output [10:0]                 out6maxpck;
  reg    [10:0]                 out6maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  output [10:0]                 out5maxpck;
  reg    [10:0]                 out5maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  output [10:0]                 out4maxpck;
  reg    [10:0]                 out4maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  output [10:0]                 out3maxpck;
  reg    [10:0]                 out3maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  output [10:0]                 out2maxpck;
  reg    [10:0]                 out2maxpck;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  output [10:0]                 out1maxpck;
  reg    [10:0]                 out1maxpck;
  `endif
  output [6:0]                  out0maxpck;
  reg    [6:0]                  out0maxpck;

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  output [10:0]                 in15maxpck;
  reg    [10:0]                 in15maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  output [10:0]                 in14maxpck;
  reg    [10:0]                 in14maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  output [10:0]                 in13maxpck;
  reg    [10:0]                 in13maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  output [10:0]                 in12maxpck;
  reg    [10:0]                 in12maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  output [10:0]                 in11maxpck;
  reg    [10:0]                 in11maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  output [10:0]                 in10maxpck;
  reg    [10:0]                 in10maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  output [10:0]                 in9maxpck;
  reg    [10:0]                 in9maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  output [10:0]                 in8maxpck;
  reg    [10:0]                 in8maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  output [10:0]                 in7maxpck;
  reg    [10:0]                 in7maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  output [10:0]                 in6maxpck;
  reg    [10:0]                 in6maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  output [10:0]                 in5maxpck;
  reg    [10:0]                 in5maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  output [10:0]                 in4maxpck;
  reg    [10:0]                 in4maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  output [10:0]                 in3maxpck;
  reg    [10:0]                 in3maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  output [10:0]                 in2maxpck;
  reg    [10:0]                 in2maxpck;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  output [10:0]                 in1maxpck;
  reg    [10:0]                 in1maxpck;
  `endif
  output [6:0]                  in0maxpck;
  wire   [6:0]                  in0maxpck;

  output                        fifoctrl_7;
  wire                          fifoctrl_7;
  output                        hsdisable;
  reg                           hsdisable;

  input  [16*2-1:0]             fiforst;

  input  [2:0]                  otgspeed;

  input                         vbusfault;

  `ifdef CDNSUSB2PHY_3RD
  `else
  output                        tsfr_rstb;
  reg                           tsfr_rstb;
  output                        tsfr_addr_req;
  reg                           tsfr_addr_req;
  output [7:0]                  tsfr_addr;
  reg    [7:0]                  tsfr_addr;
  input                         tsfr_rdata_req;
  input  [7:0]                  tsfr_rdata;
  output                        tsfr_wdata_req;
  reg                           tsfr_wdata_req;
  output [7:0]                  tsfr_wdata;
  reg    [7:0]                  tsfr_wdata;
  `endif

  `ifdef CDNSUSB2PHY_3RD

  output                        phy_suspendm_low;
  reg                           phy_suspendm_low;
  output                        phy_utmi_reset;
  reg                           phy_utmi_reset;
  output                        phy_ponrst;
  reg                           phy_ponrst;
  `else

  output                        phy_suspendm_low;
  reg                           phy_suspendm_low;
  output                        phy_sleepm_ref;
  reg                           phy_sleepm_ref;
  `ifdef CDNSUSBHS_SLEEPM_50REF
  reg                           phy_sleepm_ref_;
  `endif
  output                        phy_reset;
  reg                           phy_reset;
  output                        phy_databus_reset;
  reg                           phy_databus_reset;
  output [1:0]                  phy_powerdown;
  reg    [1:0]                  phy_powerdown;




  output                        phy_pll_clkon;
  reg                           phy_pll_clkon;
  output                        phy_pll_standalone;
  reg                           phy_pll_standalone;
  output [1:0]                  phy_pll_clk_sel;
  reg    [1:0]                  phy_pll_clk_sel;
  `endif

  input                         debug_rx_req;
  input  [18:0]                 debug_rx;
  input                         debug_tx_req;
  input  [14:0]                 debug_tx;

  input                         workaround_a_req;
  output                        workaround_a_enable;
  reg                           workaround_a_enable;
  output                        workaround_b_enable;
  reg                           workaround_b_enable;
  output                        workaround_c_enable;
  reg                           workaround_c_enable;
  output                        workaround_d_enable;
  reg                           workaround_d_enable;
  output [3:0]                  workaround_a_value;
  reg    [3:0]                  workaround_a_value;
  output                        workaround_sfr_rst;
  reg                           workaround_sfr_rst;

  output [2:0]                  workaround_otg;
  reg    [2:0]                  workaround_otg;

  input                         isosofpulserequp;
  output                        isosofpulseup;
  reg                           isosofpulseup;

  output                        sof_rcv_disable;
  reg                           sof_rcv_disable;

  output                        upendian;
  reg                           upendian;
  output [31:0]                 updatao;
  reg    [31:0]                 updatao;




  parameter SUDAV_IRQ           = 8'h00;
  parameter SOF_IRQ             = 8'h04;
  parameter SUTOK_IRQ           = 8'h08;
  parameter SUSP_IRQ            = 8'h0C;
  parameter URES_IRQ            = 8'h10;
  parameter HSPEED_IRQ          = 8'h14;

  parameter HCOUT0ERR_IRQ       = 8'h16;
  parameter IN0_IRQ             = 8'h18;
  parameter HCIN0ERR_IRQ        = 8'h1A;
  parameter OUT0_IRQ            = 8'h1C;
  parameter OUT0PING_IRQ        = 8'h20;

  `ifdef CDNSUSBHS_EPIN_EXIST_1
  parameter HCOUT1ERR_IRQ       = 8'h22;
  parameter IN1_IRQ             = 8'h24;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  parameter HCIN1ERR_IRQ        = 8'h26;
  parameter OUT1_IRQ            = 8'h28;
  parameter OUT1PING_IRQ        = 8'h2C;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_2
  parameter HCOUT2ERR_IRQ       = 8'h2E;
  parameter IN2_IRQ             = 8'h30;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  parameter HCIN2ERR_IRQ        = 8'h32;
  parameter OUT2_IRQ            = 8'h34;
  parameter OUT2PING_IRQ        = 8'h38;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_3
  parameter HCOUT3ERR_IRQ       = 8'h3A;
  parameter IN3_IRQ             = 8'h3C;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  parameter HCIN3ERR_IRQ        = 8'h3E;
  parameter OUT3_IRQ            = 8'h40;
  parameter OUT3PING_IRQ        = 8'h44;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_4
  parameter HCOUT4ERR_IRQ       = 8'h46;
  parameter IN4_IRQ             = 8'h48;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  parameter HCIN4ERR_IRQ        = 8'h4A;
  parameter OUT4_IRQ            = 8'h4C;
  parameter OUT4PING_IRQ        = 8'h50;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_5
  parameter HCOUT5ERR_IRQ       = 8'h52;
  parameter IN5_IRQ             = 8'h54;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  parameter HCIN5ERR_IRQ        = 8'h56;
  parameter OUT5_IRQ            = 8'h58;
  parameter OUT5PING_IRQ        = 8'h5C;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_6
  parameter HCOUT6ERR_IRQ       = 8'h5E;
  parameter IN6_IRQ             = 8'h60;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  parameter HCIN6ERR_IRQ        = 8'h62;
  parameter OUT6_IRQ            = 8'h64;
  parameter OUT6PING_IRQ        = 8'h68;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_7
  parameter HCOUT7ERR_IRQ       = 8'h6A;
  parameter IN7_IRQ             = 8'h6C;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  parameter HCIN7ERR_IRQ        = 8'h6E;
  parameter OUT7_IRQ            = 8'h70;
  parameter OUT7PING_IRQ        = 8'h74;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_8
  parameter HCOUT8ERR_IRQ       = 8'h76;
  parameter IN8_IRQ             = 8'h78;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  parameter HCIN8ERR_IRQ        = 8'h7A;
  parameter OUT8_IRQ            = 8'h7C;
  parameter OUT8PING_IRQ        = 8'h80;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_9
  parameter HCOUT9ERR_IRQ       = 8'h82;
  parameter IN9_IRQ             = 8'h84;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  parameter HCIN9ERR_IRQ        = 8'h86;
  parameter OUT9_IRQ            = 8'h88;
  parameter OUT9PING_IRQ        = 8'h8C;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_10
  parameter HCOUT10ERR_IRQ      = 8'h8E;
  parameter IN10_IRQ            = 8'h90;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  parameter HCIN10ERR_IRQ       = 8'h92;
  parameter OUT10_IRQ           = 8'h94;
  parameter OUT10PING_IRQ       = 8'h98;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_11
  parameter HCOUT11ERR_IRQ      = 8'h9A;
  parameter IN11_IRQ            = 8'h9C;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  parameter HCIN11ERR_IRQ       = 8'h9E;
  parameter OUT11_IRQ           = 8'hA0;
  parameter OUT11PING_IRQ       = 8'hA4;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_12
  parameter HCOUT12ERR_IRQ      = 8'hA6;
  parameter IN12_IRQ            = 8'hA8;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  parameter HCIN12ERR_IRQ       = 8'hAA;
  parameter OUT12_IRQ           = 8'hAC;
  parameter OUT12PING_IRQ       = 8'hB0;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_13
  parameter HCOUT13ERR_IRQ      = 8'hB2;
  parameter IN13_IRQ            = 8'hB4;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  parameter HCIN13ERR_IRQ       = 8'hB6;
  parameter OUT13_IRQ           = 8'hB8;
  parameter OUT13PING_IRQ       = 8'hBC;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_14
  parameter HCOUT14ERR_IRQ      = 8'hBE;
  parameter IN14_IRQ            = 8'hC0;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  parameter HCIN14ERR_IRQ       = 8'hC2;
  parameter OUT14_IRQ           = 8'hC4;
  parameter OUT14PING_IRQ       = 8'hC8;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  parameter HCOUT15ERR_IRQ      = 8'hCA;
  parameter IN15_IRQ            = 8'hCC;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  parameter HCIN15ERR_IRQ       = 8'hCE;
  parameter OUT15_IRQ           = 8'hD0;
  parameter OUT15PING_IRQ       = 8'hD4;
  `endif

  parameter OTG_IRQ             = 8'hD8;
  parameter ADPBC1_IRQ          = 8'hD9;
  parameter ADPBC2_IRQ          = 8'hDA;
  parameter LPM_IRQ             = 8'hDC;

  parameter DMA_IRQ             = 8'hF0;
  parameter WAKEUP_IRQ          = 8'hF1;
  parameter VBUSFAULT_RISE_IRQ  = 8'hF2;
  parameter VBUSFAULT_FALL_IRQ  = 8'hF3;

  parameter DEBUG_TX_IRQ        = 8'hE0;
  parameter DEBUG_RX_IRQ        = 8'hE1;
  parameter WORKA_A_IRQ         = 8'hE2;





  wire   [15:0]                outxirq;
  reg    [15:0]                outxirq_r;
  wire   [15:0]                inxirq;
  reg    [15:0]                inxirq_r;
  wire   [15:0]                outxpngirq;
  reg    [15:0]                outxpngirq_r;
  reg    [6:0]                 usbirq;
  wire   [15:0]                hcinxerrirq;
  reg    [15:0]                hcinxerrirq_r;
  wire   [15:0]                hcoutxerrirq;
  reg    [15:0]                hcoutxerrirq_r;

  wire   [15:0]                outxien;
  reg    [15:0]                outxien_r;
  wire   [15:0]                inxien;
  reg    [15:0]                inxien_r;
  wire   [15:0]                outxpngien;
  reg    [15:0]                outxpngien_r;
  reg    [6:0]                 usbien;
  wire   [15:0]                hcinxerrien;
  reg    [15:0]                hcinxerrien_r;
  wire   [15:0]                hcoutxerrien;
  reg    [15:0]                hcoutxerrien_r;







  reg    [7:5]                 usbcs_75;
  reg                          usbcs_1;
  wire   [7:0]                 usbcs;




  reg    [5:0]                 endprst;

  reg    [7:0]                 ivec;





  reg                          fifoctrl;




  wire   [15:0]                outxirq_m;
  wire   [15:0]                inxirq_m;
  wire   [15:0]                outxpngirq_m;
  wire   [6:0]                 usbirq_m;
  wire   [15:0]                hcoutxerrirq_m;
  wire   [15:0]                hcinxerrirq_m;

  reg                          int_req_clr;

  `ifdef CDNSUSBHS_OTHERS_EPOUT_DO_NOT_EXIST
  `else
  reg    [15:2]                outxstartaddr;
  reg    [15:2]                outxstartaddr_rd;
  `endif
  `ifdef CDNSUSBHS_OTHERS_EPIN_DO_NOT_EXIST
  `else
  reg    [15:2]                inxstartaddr;
  reg    [15:2]                inxstartaddr_rd;
  `endif

  `ifdef CDNSUSBHS_OTHERS_EPOUT_DO_NOT_EXIST
  `else
  reg    [10:0]                outxmaxpck_1;
  reg    [10:0]                outxmaxpck_1_rd;
  reg    [10:0]                outxmaxpck_0;
  reg    [10:0]                outxmaxpck_0_rd;
  `endif

  `ifdef CDNSUSBHS_OTHERS_EPIN_DO_NOT_EXIST
  `else
  reg    [10:0]                inxmaxpck_1;
  reg    [10:0]                inxmaxpck_1_rd;
  reg    [10:0]                inxmaxpck_0;
  reg    [10:0]                inxmaxpck_0_rd;
  `endif

  reg    [15:1]                inxisoautoarm_r;
  reg    [15:1]                inxisodctrl_r;
  reg    [15:1]                inxisoautodump_r;

  reg    [7:0]                 otgirq;
  reg    [7:0]                 otgien;
  wire   [7:0]                 otgirq_m;

  reg    [7:0]                 adpbc1irq;
  reg    [7:0]                 adpbc1ien;
  wire   [7:0]                 adpbc1irq_m;
  reg    [6:0]                 adpbc2irq;
  reg    [6:0]                 adpbc2ien;
  wire   [6:0]                 adpbc2irq_m;

  reg                          dmaintreq_r;
  reg                          wuintreq_r;
  reg                          vbusfault_r;

  reg                          wakeupirq;
  reg                          wakeupien;
  wire                         wakeupirq_m;

  reg    [1:0]                 vbusfaultirq;
  reg    [1:0]                 vbusfaultien;
  wire   [1:0]                 vbusfaultirq_m;

  reg    [7:0]                 hcportctrl;

  wire                         int_req_v;

  reg                          isosofpulse;

  reg    [15:0]                fiforstin_r;
  reg    [15:0]                fiforstout_r;
  reg    [15:1]                togglerstin_r;
  reg    [15:1]                togglesetin_r;
  reg    [15:1]                togglerstout_r;
  reg    [15:1]                togglesetout_r;

  wire   [15:0]                updatai_1_0;
  wire   [15:0]                updatai_3_2;
  wire   [15:0]                updataival_1_0;
  wire   [15:0]                updataival_3_2;

  `ifdef CDNSUSB2PHY_3RD
  `else
  reg                          tsfr_busy;
  reg                          tsfr_wr16;
  wire                         tsfr_wr32;
  reg                          tsfr_rdata_req_r;
  reg   [7:0]                  tsfr_rdata_r;

  reg   [1:0]                  access_size;
  `endif

  reg   [3:0]                  debug_rx_pid;
  reg   [3:0]                  debug_rx_status;
  reg   [10:0]                 debug_rx_databyte;
  reg   [3:0]                  debug_tx_pid;
  reg   [10:0]                 debug_tx_databyte;

  reg                          debug_tx_irq;
  reg                          debug_rx_irq;
  reg                          workaround_a_irq;
  reg                          debug_tx_ien;
  reg                          debug_rx_ien;
  reg                          workaround_a_ien;
  wire  [2:0]                  debug_irq_m;



  assign updatai_1_0 = {updatai_1, updatai_0};
  assign updatai_3_2 = {updatai_3, updatai_2};



  assign updataival_1_0 = {{8{updataival_1}}, {8{updataival_0}}};
  assign updataival_3_2 = {{8{updataival_3}}, {8{updataival_2}}};








  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBCS_Q7_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      usbcs_75[7] <= 1'b0 ;
      end
    else
      begin

      usbcs_75[7] <= wakesrc;
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBCS_Q6_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      usbcs_75[6] <= 1'b1 ;
      end
    else
      begin
      if (upaddr == 8'h68 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1)
        begin
        usbcs_75[6] <= updatai_3[6] ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBCS_Q5_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      usbcs_75[5] <= 1'b0 ;
      end
    else
      begin

      if (sigrsumclr == 1'b1)
        begin

        usbcs_75[5] <= 1'b0 ;
        end
      else if (upaddr == 8'h68 &&
               updataival_3 == 1'b1 &&
               upwr == 1'b1 && usbcs_75[5] == 1'b0)
        begin
        usbcs_75[5] <= updatai_3[5] ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBCS_Q1_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      usbcs_1 <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'h68 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1)
        begin
        usbcs_1 <= updatai_3[1] ;
        end
      end
    end




  assign discon = usbcs_75[6];




  assign sigrsum = usbcs_75[5];




  assign lpm_nyet = usbcs_1;




  assign usbcs = {usbcs_75,
                  3'b000,
                  usbcs_1,
                  lsmode
                 };




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : SUSPENDM_REQ_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      suspendm_req <= 1'b0;
      end
    else
      begin
      if (suspendm_en == 1'b0)
        begin
        suspendm_req <= 1'b0;
        end
      else if (upaddr == 8'h69 &&
               updataival_3 == 1'b1 &&
               upwr == 1'b1 && suspendm_req == 1'b0)
        begin

        suspendm_req <= 1'b1;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : SLEEPM_REQ_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      sleepm_req <= 1'b0;
      end
    else
      begin
      if (sleepm_en == 1'b0)
        begin
        sleepm_req <= 1'b0;
        end
      else if (upaddr == 8'h6A &&
               updataival_2 == 1'b1 &&
               upwr == 1'b1 && sleepm_req == 1'b0)
        begin

        sleepm_req <= 1'b1;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : WU_EN_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      wuiden   <= 1'b0 ;
      wudpen   <= 1'b0 ;
      wuvbusen <= 1'b0 ;
      end
    else
      begin
      if (suspendm_en == 1'b0)
        begin
        wuiden   <= 1'b0 ;
        wudpen   <= 1'b0 ;
        wuvbusen <= 1'b0 ;
        end
      else if (upaddr == 8'h69 &&
               updataival_3 == 1'b1 &&
               upwr == 1'b1 && suspendm_req == 1'b0)
        begin

        wuiden   <= updatai_3[0] ;
        wudpen   <= updatai_3[1] ;
        wuvbusen <= updatai_3[2] ;
        end
      end
    end







  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBIRQ_Q7_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      usbirq[6] <= 1'b0;
      end
    else
      begin
      if (upaddr == 8'h63 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1 &&
          updatai_0[7] == 1'b1)
        begin
        usbirq[6] <= 1'b0 ;
        end
      else if (lpmirq == 1'b1)
        begin

        usbirq[6] <= 1'b1 ;
        end
      end
    end




  assign lpm_usbirq = usbirq[6];



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBIRQ_Q5_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      usbirq[5] <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'h63 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1 &&
          updatai_0[5] == 1'b1)
        begin
        usbirq[5] <= 1'b0 ;
        end

      else if (hsmodeirq == 1'b1)
        begin

        usbirq[5] <= 1'b1 ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBIRQ_Q4_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      usbirq[4] <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'h63 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1 &&
          updatai_0[4] == 1'b1)
        begin
        usbirq[4] <= 1'b0 ;
        end



      else if (usbresetirq == 1'b1)
        begin
        usbirq[4] <= 1'b1;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBIRQ_Q3_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      usbirq[3] <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'h63 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1 &&
          updatai_0[3] == 1'b1)
        begin
        usbirq[3] <= 1'b0 ;
        end

      else if (suspreq == 1'b1)
        begin

        usbirq[3] <= 1'b1 ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBIRQ_Q2_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      usbirq[2] <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'h63 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1 &&
          updatai_0[2] == 1'b1)
        begin
        usbirq[2] <= 1'b0 ;
        end

      else if (settoken == 1'b1)
        begin

        usbirq[2] <= 1'b1 ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBIRQ_Q1_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      usbirq[1] <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'h63 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1 &&
          updatai_0[1] == 1'b1)
        begin
        usbirq[1] <= 1'b0 ;
        end
      else
        begin

        if (upstren == 1'b1)
          begin

          if (sofirq == 1'b1)
            begin

            usbirq[1] <= 1'b1 ;
            end
          end
        else
          begin

          if (hcsendsof == 1'b1)
            begin

            usbirq[1] <= 1'b1 ;
            end
          end
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBIRQ_Q0_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      usbirq[0] <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'h63 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1 &&
          updatai_0[0] == 1'b1)
        begin
        usbirq[0] <= 1'b0 ;
        end

      else if (sudav == 1'b1)
        begin

        usbirq[0] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUTXIRQ_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      outxirq_r <= {16{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 0; i = i - 1)
        begin
        if (upaddr == 8'h62 &&
            updatai_3_2[i] == 1'b1 &&
            updataival_3_2[i] == 1'b1 &&
            upwr == 1'b1)
          begin
          outxirq_r[i] <= 1'b0 ;
          end
        else if (outbsyfall[i] == 1'b1)
          begin
          outxirq_r[i] <= 1'b1 ;
          end
        end
      end
    end



  assign outxirq = outxirq_r & EPOUTEXIST[15:0];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : INXIRQ_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      inxirq_r <= {16{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 0; i = i - 1)
        begin
        if (upaddr == 8'h62 &&
            updatai_1_0[i] == 1'b1 &&
            updataival_1_0[i] == 1'b1 &&
            upwr == 1'b1)
          begin
          inxirq_r[i] <= 1'b0 ;
          end
        else if (inbsyfall[i] == 1'b1)
          begin
          inxirq_r[i] <= 1'b1 ;
          end
        end
      end
    end



  assign inxirq = inxirq_r & EPINEXIST[15:0];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUTXPNGIRQ_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      outxpngirq_r <= {16{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 0; i = i - 1)
        begin
        if (upaddr == 8'h63 &&
            updatai_3_2[i] == 1'b1 &&
            updataival_3_2[i] == 1'b1 &&
            upwr == 1'b1)
          begin
          outxpngirq_r[i] <= 1'b0 ;
          end
        else if (outpngirq_no == i && outpngirq == 1'b1)
          begin
          outxpngirq_r[i] <= 1'b1 ;
          end
        end
      end
    end



  assign outxpngirq = outxpngirq_r & EPOUTEXIST[15:0];








  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCINXERRIRQ_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcinxerrirq_r <= {16{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 0; i = i - 1)
        begin
        if (upaddr == 8'h6D &&
            updatai_1_0[i] == 1'b1 &&
            updataival_1_0[i] == 1'b1 &&
            upwr == 1'b1)
          begin

          hcinxerrirq_r[i] <= 1'b0 ;
          end
        else if (hcerrirqin[i] == 1'b1)
          begin
          hcinxerrirq_r[i] <= 1'b1 ;
          end
        end
      end
    end



  assign hcinxerrirq = hcinxerrirq_r & EPOUTEXIST[15:0];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCOUTXERRIRQ_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcoutxerrirq_r <= {16{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 0; i = i - 1)
        begin
        if (upaddr == 8'h6D &&
            updatai_3_2[i] == 1'b1 &&
            updataival_3_2[i] == 1'b1 &&
            upwr == 1'b1)
          begin

          hcoutxerrirq_r[i] <= 1'b0 ;
          end
        else if (hcerrirqout[i] == 1'b1)
          begin
          hcoutxerrirq_r[i] <= 1'b1 ;
          end
        end
      end
    end



  assign hcoutxerrirq = hcoutxerrirq_r & EPINEXIST[15:0];








  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBIEN_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      usbien <= {7{1'b0}};
      end
    else
      begin
      if (upaddr == 8'h66 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1)
        begin
        usbien <= {updatai_0[7], updatai_0[5:0]};
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUTXIEN_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      outxien_r <= {16{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 0; i = i - 1)
        begin
        if (upaddr == 8'h65 &&
            updataival_3_2[i] == 1'b1 &&
            upwr == 1'b1)
          begin
          outxien_r[i] <= updatai_3_2[i] ;
          end
        end
      end
    end



  assign outxien = outxien_r & EPOUTEXIST[15:0];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : INXIEN_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      inxien_r <= {16{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 0; i = i - 1)
        begin
        if (upaddr == 8'h65 &&
            updataival_1_0[i] == 1'b1 &&
            upwr == 1'b1)
          begin
          inxien_r[i] <= updatai_1_0[i] ;
          end
        end
      end
    end



  assign inxien = inxien_r & EPINEXIST[15:0];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUTXPNGIEN_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      outxpngien_r <= {16{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 0; i = i - 1)
        begin
        if (upaddr == 8'h66 &&
            updataival_3_2[i] == 1'b1 &&
            upwr == 1'b1)
          begin
          outxpngien_r[i] <= updatai_3_2[i] ;
          end
        end
      end
    end



  assign outxpngien = outxpngien_r & EPOUTEXIST[15:0];








  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCINXERRIEN_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcinxerrien_r <= {16{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 0; i = i - 1)
        begin
        if (upaddr == 8'h6E &&
            updataival_1_0[i] == 1'b1 &&
            upwr == 1'b1)
          begin

          hcinxerrien_r[i] <= updatai_1_0[i] ;
          end
        end
      end
    end



  assign hcinxerrien = hcinxerrien_r & EPOUTEXIST[15:0];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCOUTXERRIEN_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcoutxerrien_r <= {16{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 0; i = i - 1)
        begin
        if (upaddr == 8'h6E &&
            updataival_3_2[i] == 1'b1 &&
            upwr == 1'b1)
          begin

          hcoutxerrien_r[i] <= updatai_3_2[i] ;
          end
        end
      end
    end



  assign hcoutxerrien = hcoutxerrien_r & EPINEXIST[15:0];








  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFORSTIN_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      fiforstin_r <= {16{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 0; i = i - 1)
        begin
        if (upaddr == 8'h68 &&
            updatai_2[6] == 1'b1 &&
            endprst[4] == 1'b1 &&
            updataival_2 == 1'b1 &&
            upwr == 1'b1 && (i == endprst[3:0] || endprst[3:0] == 4'h0) && i != 0)
          begin




          fiforstin_r[i] <= 1'b1 ;
          end
        else if (upaddr == 8'h01 &&
                 updatai_3[2] == 1'b1 &&
                 updataival_3 == 1'b1 &&
                 upwr == 1'b1 && i == 0)
          begin
          fiforstin_r[i] <= 1'b1 ;
          end
        else if (fiforst[i+16]==1'b1)
          begin
          fiforstin_r[i] <= 1'b1 ;
          end
        else
          begin
          fiforstin_r[i] <= 1'b0 ;
          end
        end
      end
    end



  assign fiforstin = fiforstin_r & EPINEXIST;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : TOGGLERSTIN_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      togglerstin_r <= {15{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 1; i = i - 1)
        begin
        if (upaddr == 8'h68 &&
            updatai_2[5] == 1'b1 &&
            endprst[4] == 1'b1 &&
            updataival_2 == 1'b1 &&
            upwr == 1'b1 && (i == endprst[3:0] || endprst[3:0] == 4'h0))
          begin




          togglerstin_r[i] <= 1'b1 ;
          end
        else
          begin
          togglerstin_r[i] <= 1'b0 ;
          end
        end
      end
    end



  assign togglerstin = togglerstin_r & EPINEXIST[15:1];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : TOGGLESETIN_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      togglesetin_r <= {15{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 1; i = i - 1)
        begin
        if (upaddr == 8'h68 &&
            updatai_2[7] == 1'b1 &&
            endprst[4] == 1'b1 &&
            updataival_2 == 1'b1 &&
            upwr == 1'b1 && (i == endprst[3:0] || endprst[3:0] == 4'h0))
          begin




          togglesetin_r[i] <= 1'b1 ;
          end
        else
          begin
          togglesetin_r[i] <= 1'b0 ;
          end
        end
      end
    end



  assign togglesetin = togglesetin_r & EPINEXIST[15:1];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFORSTOUT_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      fiforstout_r <= {16{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 0; i = i - 1)
        begin
        if (upaddr == 8'h68 &&
            updatai_2[6] == 1'b1 &&
            endprst[4] == 1'b0 &&
            updataival_2 == 1'b1 &&
            upwr == 1'b1 && (i == endprst[3:0] || endprst[3:0] == 4'h0) && i != 0)
          begin




          fiforstout_r[i] <= 1'b1 ;
          end
        else if (upaddr == 8'h01 &&
                 updatai_3[2] == 1'b1 &&
                 updataival_3 == 1'b1 &&
                 upwr == 1'b1 && i == 0)
          begin
          fiforstout_r[i] <= 1'b1 ;
          end
        else if (fiforst[i]==1'b1)
          begin
          fiforstout_r[i] <= 1'b1 ;
          end
        else
          begin
          fiforstout_r[i] <= 1'b0 ;
          end
        end
      end
    end



  assign fiforstout = fiforstout_r & EPOUTEXIST;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : TOGGLERSTOUT_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      togglerstout_r <= {15{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 1; i = i - 1)
        begin
        if (upaddr == 8'h68 &&
            updatai_2[5] == 1'b1 &&
            endprst[4] == 1'b0 &&
            updataival_2 == 1'b1 &&
            upwr == 1'b1 && (i == endprst[3:0] || endprst[3:0] == 4'h0))
          begin




          togglerstout_r[i] <= 1'b1 ;
          end
        else
          begin
          togglerstout_r[i] <= 1'b0 ;
          end
        end
      end
    end



  assign togglerstout = togglerstout_r & EPOUTEXIST[15:1];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : TOGGLESETOUT_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      togglesetout_r <= {15{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 1; i = i - 1)
        begin
        if (upaddr == 8'h68 &&
            updatai_2[7] == 1'b1 &&
            endprst[4] == 1'b0 &&
            updataival_2 == 1'b1 &&
            upwr == 1'b1 && (i == endprst[3:0] || endprst[3:0] == 4'h0))
          begin




          togglesetout_r[i] <= 1'b1 ;
          end
        else
          begin
          togglesetout_r[i] <= 1'b0 ;
          end
        end
      end
    end



  assign togglesetout = togglesetout_r & EPOUTEXIST[15:1];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ENDPRST_Q5_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      endprst[5] <= 1'b0;
      end
    else
      begin
      if (endprst[4] == 1'b1)
        begin

        endprst[5] <= togglein[endprst[3:0]];
        end
      else
        begin

        endprst[5] <= toggleout[endprst[3:0]];
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ENDPRST_Q40_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      endprst[4:0] <= {5{1'b0}};
      end
    else
      begin
      if (upaddr == 8'h68 &&
          updataival_2 == 1'b1 &&
          upwr == 1'b1)
        begin

        endprst[4:0] <= updatai_2[4:0];
        end
      end
    end








  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IVECT_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      ivec <= {8{1'b0}};
      end
    else
      begin
      if (usbirq[0] == 1'b1 && usbien[0] == 1'b1)
        begin

        ivec <= SUDAV_IRQ;
        end
      else if (usbirq[1] == 1'b1 && usbien[1] == 1'b1)
        begin
        ivec <= SOF_IRQ;
        end
      else if (usbirq[2] == 1'b1 && usbien[2] == 1'b1)
        begin
        ivec <= SUTOK_IRQ;
        end
      else if (usbirq[3] == 1'b1 && usbien[3] == 1'b1)
        begin
        ivec <= SUSP_IRQ;
        end
      else if (usbirq[4] == 1'b1 && usbien[4] == 1'b1)
        begin
        ivec <= URES_IRQ;
        end
      else if (usbirq[5] == 1'b1 && usbien[5] == 1'b1)
        begin
        ivec <= HSPEED_IRQ;
        end
      else if (usbirq[6] == 1'b1 && usbien[6] == 1'b1)
        begin
        ivec <= LPM_IRQ;
        end

      else if (hcoutxerrirq[0] == 1'b1 && hcoutxerrien[0] == 1'b1)
        begin
        ivec <= HCOUT0ERR_IRQ;
        end
      else if (inxirq[0] == 1'b1 && inxien[0] == 1'b1)
        begin
        ivec <= IN0_IRQ;
        end

      else if (hcinxerrirq[0] == 1'b1 && hcinxerrien[0] == 1'b1)
        begin
        ivec <= HCIN0ERR_IRQ;
        end
      else if (outxirq[0] == 1'b1 && outxien[0] == 1'b1)
        begin
        ivec <= OUT0_IRQ;
        end
      else if (outxpngirq[0] == 1'b1 && outxpngien[0] == 1'b1)
        begin
        ivec <= OUT0PING_IRQ;
        end

    `ifdef CDNSUSBHS_EPIN_EXIST_1
      else if (hcoutxerrirq[1] == 1'b1 && hcoutxerrien[1] == 1'b1)
        begin
        ivec <= HCOUT1ERR_IRQ;
        end
      else if (inxirq[1] == 1'b1 && inxien[1] == 1'b1)
        begin
        ivec <= IN1_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_1
      else if (hcinxerrirq[1] == 1'b1 && hcinxerrien[1] == 1'b1)
        begin
        ivec <= HCIN1ERR_IRQ;
        end
      else if (outxirq[1] == 1'b1 && outxien[1] == 1'b1)
        begin
        ivec <= OUT1_IRQ;
        end
      else if (outxpngirq[1] == 1'b1 && outxpngien[1] == 1'b1)
        begin
        ivec <= OUT1PING_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_2
      else if (hcoutxerrirq[2] == 1'b1 && hcoutxerrien[2] == 1'b1)
        begin
        ivec <= HCOUT2ERR_IRQ;
        end
      else if (inxirq[2] == 1'b1 && inxien[2] == 1'b1)
        begin
        ivec <= IN2_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_2
      else if (hcinxerrirq[2] == 1'b1 && hcinxerrien[2] == 1'b1)
        begin
        ivec <= HCIN2ERR_IRQ;
        end
      else if (outxirq[2] == 1'b1 && outxien[2] == 1'b1)
        begin
        ivec <= OUT2_IRQ;
        end
      else if (outxpngirq[2] == 1'b1 && outxpngien[2] == 1'b1)
        begin
        ivec <= OUT2PING_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_3
      else if (hcoutxerrirq[3] == 1'b1 && hcoutxerrien[3] == 1'b1)
        begin
        ivec <= HCOUT3ERR_IRQ;
        end
      else if (inxirq[3] == 1'b1 && inxien[3] == 1'b1)
        begin
        ivec <= IN3_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_3
      else if (hcinxerrirq[3] == 1'b1 && hcinxerrien[3] == 1'b1)
        begin
        ivec <= HCIN3ERR_IRQ;
        end
      else if (outxirq[3] == 1'b1 && outxien[3] == 1'b1)
        begin
        ivec <= OUT3_IRQ;
        end
      else if (outxpngirq[3] == 1'b1 && outxpngien[3] == 1'b1)
        begin
        ivec <= OUT3PING_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_4
      else if (hcoutxerrirq[4] == 1'b1 && hcoutxerrien[4] == 1'b1)
        begin
        ivec <= HCOUT4ERR_IRQ;
        end
      else if (inxirq[4] == 1'b1 && inxien[4] == 1'b1)
        begin
        ivec <= IN4_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_4
      else if (hcinxerrirq[4] == 1'b1 && hcinxerrien[4] == 1'b1)
        begin
        ivec <= HCIN4ERR_IRQ;
        end
      else if (outxirq[4] == 1'b1 && outxien[4] == 1'b1)
        begin
        ivec <= OUT4_IRQ;
        end
      else if (outxpngirq[4] == 1'b1 && outxpngien[4] == 1'b1)
        begin
        ivec <= OUT4PING_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_5
      else if (hcoutxerrirq[5] == 1'b1 && hcoutxerrien[5] == 1'b1)
        begin
        ivec <= HCOUT5ERR_IRQ;
        end
      else if (inxirq[5] == 1'b1 && inxien[5] == 1'b1)
        begin
        ivec <= IN5_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_5
      else if (hcinxerrirq[5] == 1'b1 && hcinxerrien[5] == 1'b1)
        begin
        ivec <= HCIN5ERR_IRQ;
        end
      else if (outxirq[5] == 1'b1 && outxien[5] == 1'b1)
        begin
        ivec <= OUT5_IRQ;
        end
      else if (outxpngirq[5] == 1'b1 && outxpngien[5] == 1'b1)
        begin
        ivec <= OUT5PING_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_6
      else if (hcoutxerrirq[6] == 1'b1 && hcoutxerrien[6] == 1'b1)
        begin
        ivec <= HCOUT6ERR_IRQ;
        end
      else if (inxirq[6] == 1'b1 && inxien[6] == 1'b1)
        begin
        ivec <= IN6_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_6
      else if (hcinxerrirq[6] == 1'b1 && hcinxerrien[6] == 1'b1)
        begin
        ivec <= HCIN6ERR_IRQ;
        end
      else if (outxirq[6] == 1'b1 && outxien[6] == 1'b1)
        begin
        ivec <= OUT6_IRQ;
        end
      else if (outxpngirq[6] == 1'b1 && outxpngien[6] == 1'b1)
        begin
        ivec <= OUT6PING_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_7
      else if (hcoutxerrirq[7] == 1'b1 && hcoutxerrien[7] == 1'b1)
        begin
        ivec <= HCOUT7ERR_IRQ;
        end
      else if (inxirq[7] == 1'b1 && inxien[7] == 1'b1)
        begin
        ivec <= IN7_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_7
      else if (hcinxerrirq[7] == 1'b1 && hcinxerrien[7] == 1'b1)
        begin
        ivec <= HCIN7ERR_IRQ;
        end
      else if (outxirq[7] == 1'b1 && outxien[7] == 1'b1)
        begin
        ivec <= OUT7_IRQ;
        end
      else if (outxpngirq[7] == 1'b1 && outxpngien[7] == 1'b1)
        begin
        ivec <= OUT7PING_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_8
      else if (hcoutxerrirq[8] == 1'b1 && hcoutxerrien[8] == 1'b1)
        begin
        ivec <= HCOUT8ERR_IRQ;
        end
      else if (inxirq[8] == 1'b1 && inxien[8] == 1'b1)
        begin
        ivec <= IN8_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_8
      else if (hcinxerrirq[8] == 1'b1 && hcinxerrien[8] == 1'b1)
        begin
        ivec <= HCIN8ERR_IRQ;
        end
      else if (outxirq[8] == 1'b1 && outxien[8] == 1'b1)
        begin
        ivec <= OUT8_IRQ;
        end
      else if (outxpngirq[8] == 1'b1 && outxpngien[8] == 1'b1)
        begin
        ivec <= OUT8PING_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_9
      else if (hcoutxerrirq[9] == 1'b1 && hcoutxerrien[9] == 1'b1)
        begin
        ivec <= HCOUT9ERR_IRQ;
        end
      else if (inxirq[9] == 1'b1 && inxien[9] == 1'b1)
        begin
        ivec <= IN9_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_9
      else if (hcinxerrirq[9] == 1'b1 && hcinxerrien[9] == 1'b1)
        begin
        ivec <= HCIN9ERR_IRQ;
        end
      else if (outxirq[9] == 1'b1 && outxien[9] == 1'b1)
        begin
        ivec <= OUT9_IRQ;
        end
      else if (outxpngirq[9] == 1'b1 && outxpngien[9] == 1'b1)
        begin
        ivec <= OUT9PING_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_10
      else if (hcoutxerrirq[10] == 1'b1 && hcoutxerrien[10] == 1'b1)
        begin
        ivec <= HCOUT10ERR_IRQ;
        end
      else if (inxirq[10] == 1'b1 && inxien[10] == 1'b1)
        begin
        ivec <= IN10_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_10
      else if (hcinxerrirq[10] == 1'b1 && hcinxerrien[10] == 1'b1)
        begin
        ivec <= HCIN10ERR_IRQ;
        end
      else if (outxirq[10] == 1'b1 && outxien[10] == 1'b1)
        begin
        ivec <= OUT10_IRQ;
        end
      else if (outxpngirq[10] == 1'b1 && outxpngien[10] == 1'b1)
        begin
        ivec <= OUT10PING_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_11
      else if (hcoutxerrirq[11] == 1'b1 && hcoutxerrien[11] == 1'b1)
        begin
        ivec <= HCOUT11ERR_IRQ;
        end
      else if (inxirq[11] == 1'b1 && inxien[11] == 1'b1)
        begin
        ivec <= IN11_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_11
      else if (hcinxerrirq[11] == 1'b1 && hcinxerrien[11] == 1'b1)
        begin
        ivec <= HCIN11ERR_IRQ;
        end
      else if (outxirq[11] == 1'b1 && outxien[11] == 1'b1)
        begin
        ivec <= OUT11_IRQ;
        end
      else if (outxpngirq[11] == 1'b1 && outxpngien[11] == 1'b1)
        begin
        ivec <= OUT11PING_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_12
      else if (hcoutxerrirq[12] == 1'b1 && hcoutxerrien[12] == 1'b1)
        begin
        ivec <= HCOUT12ERR_IRQ;
        end
      else if (inxirq[12] == 1'b1 && inxien[12] == 1'b1)
        begin
        ivec <= IN12_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_12
      else if (hcinxerrirq[12] == 1'b1 && hcinxerrien[12] == 1'b1)
        begin
        ivec <= HCIN12ERR_IRQ;
        end
      else if (outxirq[12] == 1'b1 && outxien[12] == 1'b1)
        begin
        ivec <= OUT12_IRQ;
        end
      else if (outxpngirq[12] == 1'b1 && outxpngien[12] == 1'b1)
        begin
        ivec <= OUT12PING_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_13
      else if (hcoutxerrirq[13] == 1'b1 && hcoutxerrien[13] == 1'b1)
        begin
        ivec <= HCOUT13ERR_IRQ;
        end
      else if (inxirq[13] == 1'b1 && inxien[13] == 1'b1)
        begin
        ivec <= IN13_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_13
      else if (hcinxerrirq[13] == 1'b1 && hcinxerrien[13] == 1'b1)
        begin
        ivec <= HCIN13ERR_IRQ;
        end
      else if (outxirq[13] == 1'b1 && outxien[13] == 1'b1)
        begin
        ivec <= OUT13_IRQ;
        end
      else if (outxpngirq[13] == 1'b1 && outxpngien[13] == 1'b1)
        begin
        ivec <= OUT13PING_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_14
      else if (hcoutxerrirq[14] == 1'b1 && hcoutxerrien[14] == 1'b1)
        begin
        ivec <= HCOUT14ERR_IRQ;
        end
      else if (inxirq[14] == 1'b1 && inxien[14] == 1'b1)
        begin
        ivec <= IN14_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_14
      else if (hcinxerrirq[14] == 1'b1 && hcinxerrien[14] == 1'b1)
        begin
        ivec <= HCIN14ERR_IRQ;
        end
      else if (outxirq[14] == 1'b1 && outxien[14] == 1'b1)
        begin
        ivec <= OUT14_IRQ;
        end
      else if (outxpngirq[14] == 1'b1 && outxpngien[14] == 1'b1)
        begin
        ivec <= OUT14PING_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPIN_EXIST_15
      else if (hcoutxerrirq[15] == 1'b1 && hcoutxerrien[15] == 1'b1)
        begin
        ivec <= HCOUT15ERR_IRQ;
        end
      else if (inxirq[15] == 1'b1 && inxien[15] == 1'b1)
        begin
        ivec <= IN15_IRQ;
        end
    `endif

    `ifdef CDNSUSBHS_EPOUT_EXIST_15
      else if (hcinxerrirq[15] == 1'b1 && hcinxerrien[15] == 1'b1)
        begin
        ivec <= HCIN15ERR_IRQ;
        end
      else if (outxirq[15] == 1'b1 && outxien[15] == 1'b1)
        begin
        ivec <= OUT15_IRQ;
        end
      else if (outxpngirq[15] == 1'b1 && outxpngien[15] == 1'b1)
        begin
        ivec <= OUT15PING_IRQ;
        end
    `endif

      else if (|otgirq_m == 1'b1)
        begin
        ivec <= OTG_IRQ;
        end

      else if (|adpbc1irq_m == 1'b1)
        begin
        ivec <= ADPBC1_IRQ;
        end

      else if (|adpbc2irq_m == 1'b1)
        begin
        ivec <= ADPBC2_IRQ;
        end

      else if (dmaintreq == 1'b1)
        begin
        ivec <= DMA_IRQ;
        end
      else if (wakeupirq_m == 1'b1)
        begin
        ivec <= WAKEUP_IRQ;
        end

      else if (debug_tx_irq == 1'b1 && debug_tx_ien == 1'b1)
        begin
        ivec <= DEBUG_TX_IRQ;
        end
      else if (debug_rx_irq == 1'b1 && debug_rx_ien == 1'b1)
        begin
        ivec <= DEBUG_RX_IRQ;
        end
      else if (workaround_a_irq == 1'b1 && workaround_a_ien == 1'b1)
        begin
        ivec <= WORKA_A_IRQ;
        end

      else if (vbusfaultirq_m[1] == 1'b1)
        begin
        ivec <= VBUSFAULT_RISE_IRQ;
        end
      else if (vbusfaultirq_m[0] == 1'b1)
        begin
        ivec <= VBUSFAULT_FALL_IRQ;
        end

      end
    end




  assign usbivect = ivec;




  assign outxirq_m      = outxirq      & outxien;


  assign inxirq_m       = inxirq       & inxien;


  assign outxpngirq_m   = outxpngirq   & outxpngien;


  assign usbirq_m       = usbirq       & usbien;


  assign hcoutxerrirq_m = hcoutxerrirq & hcoutxerrien;


  assign hcinxerrirq_m  = hcinxerrirq  & hcinxerrien;




  assign int_req_v = (|outxirq_m)      |
                     (|inxirq_m)       |
                     (|outxpngirq_m)   |
                     (|hcoutxerrirq_m) |
                     (|hcinxerrirq_m)  |
                     (|debug_irq_m)    |
                     (|otgirq_m)       |
                     (|adpbc1irq_m)    |
                     (|adpbc2irq_m)    |
                      (wakeupirq_m)    |
                     (|vbusfaultirq_m) |
                     (|usbirq_m);





  `ifdef CDNSUSBHS_INTERRUPT_CLEAR_COMB
  always @(upaddr or upwr or
           updataival_3 or updataival_2 or
           updataival_1 or updataival_0)
    begin : INT_REQ_CLR_COMB_PROC

    int_req_clr = 1'b0;

    if ((
         (upaddr == 8'hF4 && (updataival_3 == 1'b1)) ||
         (upaddr == 8'h75 && (updataival_3 == 1'b1)) ||
         (upaddr == 8'h74 && (updataival_3 == 1'b1)) ||
         (upaddr == 8'h6F && (updataival_0 == 1'b1)) ||
         (upaddr == 8'h6D && (updataival_3 == 1'b1   ||
                              updataival_2 == 1'b1   ||
                              updataival_1 == 1'b1   ||
                              updataival_0 == 1'b1)) ||
         (upaddr == 8'h63 && (updataival_3 == 1'b1   ||
                              updataival_2 == 1'b1   ||
                              updataival_1 == 1'b1   ||
                              updataival_0 == 1'b1)) ||
         (upaddr == 8'h62 && (updataival_3 == 1'b1   ||
                              updataival_2 == 1'b1   ||
                              updataival_1 == 1'b1   ||
                              updataival_0 == 1'b1))
                                                    ) && upwr == 1'b1)
      begin

      int_req_clr = 1'b1;
      end
    else
      begin
      int_req_clr = 1'b0;
      end
    end
  `else
  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : INT_REQ_CLR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      int_req_clr <= 1'b0;
      end
    else
      begin
      if ((
           (upaddr == 8'hF4 && (updataival_3 == 1'b1)) ||
           (upaddr == 8'h75 && (updataival_3 == 1'b1)) ||
           (upaddr == 8'h74 && (updataival_3 == 1'b1)) ||
           (upaddr == 8'h6F && (updataival_0 == 1'b1)) ||
           (upaddr == 8'h6D && (updataival_3 == 1'b1   ||
                                updataival_2 == 1'b1   ||
                                updataival_1 == 1'b1   ||
                                updataival_0 == 1'b1)) ||
           (upaddr == 8'h63 && (updataival_3 == 1'b1   ||
                                updataival_2 == 1'b1   ||
                                updataival_1 == 1'b1   ||
                                updataival_0 == 1'b1)) ||
           (upaddr == 8'h62 && (updataival_3 == 1'b1   ||
                                updataival_2 == 1'b1   ||
                                updataival_1 == 1'b1   ||
                                updataival_0 == 1'b1))
                                                      ) && upwr == 1'b1)
        begin

        int_req_clr <= 1'b1;
        end
      else
        begin
        int_req_clr <= 1'b0;
        end
      end
    end
  `endif




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : DMAINTREQ_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      dmaintreq_r <= 1'b0;
      end
    else
      begin
      dmaintreq_r <= dmaintreq;
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : USBINTREQ_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      usbintreq <= 1'b0;
      end
    else
      begin
      if (int_req_clr == 1'b1)
        begin
        usbintreq <= 1'b0;
        end
      else if (dmaintreq == 1'b0 && dmaintreq_r == 1'b1)
        begin
        usbintreq <= 1'b0;
        end
      else if (dmaintreq == 1'b1)
        begin
        usbintreq <= 1'b1;
        end
      else if (int_req_v == 1'b1)
        begin
        usbintreq <= 1'b1;
        end
      end
    end








  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OTGIRQ_Q0_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      otgirq[0] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h6F &&
          updataival_0 == 1'b1 &&
          updatai_0[0] == 1'b1 &&
          upwr == 1'b1)
        begin

        otgirq[0] <= 1'b0 ;
        end
      else if (idleirq == 1'b1)
        begin
        otgirq[0] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OTGIRQ_Q1_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      otgirq[1] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h6F &&
          updataival_0 == 1'b1 &&
          updatai_0[1] == 1'b1 &&
          upwr == 1'b1)
        begin

        otgirq[1] <= 1'b0 ;
        end
      else if (srpdetirq == 1'b1)
        begin
        otgirq[1] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OTGIRQ_Q2_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      otgirq[2] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h6F &&
          updataival_0 == 1'b1 &&
          updatai_0[2] == 1'b1 &&
          upwr == 1'b1)
        begin

        otgirq[2] <= 1'b0 ;
        end
      else if (locsofirq == 1'b1)
        begin
        otgirq[2] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OTGIRQ_Q3_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      otgirq[3] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h6F &&
          updataival_0 == 1'b1 &&
          updatai_0[3] == 1'b1 &&
          upwr == 1'b1)
        begin

        otgirq[3] <= 1'b0 ;
        end
      else if (vbuserrirq == 1'b1)
        begin
        otgirq[3] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OTGIRQ_Q4_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      otgirq[4] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h6F &&
          updataival_0 == 1'b1 &&
          updatai_0[4] == 1'b1 &&
          upwr == 1'b1)
        begin

        otgirq[4] <= 1'b0 ;
        end
      else if (periphirq == 1'b1)
        begin
        otgirq[4] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OTGIRQ_Q5_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      otgirq[5] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h6F &&
          updataival_0 == 1'b1 &&
          updatai_0[5] == 1'b1 &&
          upwr == 1'b1)
        begin

        otgirq[5] <= 1'b0 ;
        end
      else if (idchangeirq == 1'b1)
        begin
        otgirq[5] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OTGIRQ_Q6_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      otgirq[6] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h6F &&
          updataival_0 == 1'b1 &&
          updatai_0[6] == 1'b1 &&
          upwr == 1'b1)
        begin

        otgirq[6] <= 1'b0 ;
        end
      else if (hostdisconirq == 1'b1)
        begin
        otgirq[6] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OTGIRQ_Q7_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      otgirq[7] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h6F &&
          updataival_0 == 1'b1 &&
          updatai_0[7] == 1'b1 &&
          upwr == 1'b1)
        begin

        otgirq[7] <= 1'b0 ;
        end
      else if (bse0srpirq == 1'b1)
        begin
        otgirq[7] <= 1'b1 ;
        end
      end
    end




  assign otgirq_m = (otgirq & otgien);




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OTGIEN_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      otgien <= {8{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h70 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1)
        begin

        otgien <= updatai_0[7:0] ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : TBVBUSPLS_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      tbvbuspls <= 8'h0A ;
      end
    else
      begin
      if (upaddr == 8'h70 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1)
        begin

        tbvbuspls <= updatai_3 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : TBVBUSDISPLS_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      tbvbusdispls <= 8'h00 ;
      end
    else
      begin
      if (upaddr == 8'h71 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1)
        begin

        tbvbusdispls <= updatai_3 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : TAWAITBCON_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      tawaitbcon <= 8'h20 ;
      end
    else
      begin
      if (upaddr == 8'h70 &&
          updataival_2 == 1'b1 &&
          upwr == 1'b1)
        begin

        tawaitbcon <= updatai_2 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : TAAIDLBDIS_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      taaidlbdis <= 8'h19 ;
      end
    else
      begin
      if (upaddr == 8'h70 &&
          updataival_1 == 1'b1 &&
          upwr == 1'b1)
        begin

        taaidlbdis <= updatai_1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OTGCTRL_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      otgctrl <= 7'b000_0000 ;
      end
    else
      begin
      if (upaddr == 8'h6F &&
          updataival_2 == 1'b1 &&
          upwr == 1'b1)
        begin


        if (clrbhnpen == 1'b1)
          begin
          otgctrl <= {updatai_2[7], updatai_2[5:4], 2'b00, updatai_2[1:0]} ;
          end
        else
          begin
          otgctrl <= {updatai_2[7], updatai_2[5:0]} ;
          end
        end
      else if (clrbhnpen == 1'b1)
        begin
        otgctrl[3:2] <= 2'b00 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OTGFORCE_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      otgforce <= 8'b0000_0000 ;
      end
    else
      begin
      if (upaddr == 8'h71 &&
          updataival_1 == 1'b1 &&
          upwr == 1'b1)
        begin
        otgforce <= updatai_1;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OTG2CTRL_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      otg2ctrl <= DOTG2CTRL_RV[1:0];
      end
    else
      begin
      if (upaddr == 8'h71 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1)
        begin
        otg2ctrl <= updatai_0[1:0];
        end
      else if (adp_change_ack == 1'b1)
        begin
        otg2ctrl[1] <= 1'b0;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_CTRL_0_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc_ctrl_0 <= 5'b0_0000;
      end
    else
      begin
      if (upaddr == 8'h74 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1)
        begin


        adpbc_ctrl_0 <= updatai_0[4:0];
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_CTRL_1_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc_ctrl_1 <= 6'b00_0000;
      end
    else
      begin
      if (upaddr == 8'h74 &&
          updataival_1 == 1'b1 &&
          upwr == 1'b1)
        begin


        adpbc_ctrl_1 <= updatai_1[5:0];
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_CTRL_2_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc_ctrl_2 <= 8'h00;
      end
    else
      begin
      if (upaddr == 8'h74 &&
          updataival_2 == 1'b1 &&
          upwr == 1'b1)
        begin


        adpbc_ctrl_2 <= updatai_2[7:0];
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBCIEN_1_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc1ien <= 8'h00;
      end
    else
      begin
      if (upaddr == 8'h73 &&
          updataival_2 == 1'b1 &&
          upwr == 1'b1)
        begin


        adpbc1ien <= updatai_2[7:0];
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBCIEN_2_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc2ien <= 7'b000_0000;
      end
    else
      begin
      if (upaddr == 8'h73 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1)
        begin


        adpbc2ien <= updatai_3[6:0];
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_1_Q0_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc1irq[0] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h74 &&
          updataival_3 == 1'b1 &&
          updatai_3[0] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc1irq[0] <= 1'b0 ;
        end
      else if (adpbc_probe_rise == 1'b1)
        begin
        adpbc1irq[0] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_1_Q1_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc1irq[1] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h74 &&
          updataival_3 == 1'b1 &&
          updatai_3[1] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc1irq[1] <= 1'b0 ;
        end
      else if (adpbc_sense_rise == 1'b1)
        begin
        adpbc1irq[1] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_1_Q2_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc1irq[2] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h74 &&
          updataival_3 == 1'b1 &&
          updatai_3[2] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc1irq[2] <= 1'b0 ;
        end
      else if (adpbc_otgsessvalid_rise == 1'b1)
        begin
        adpbc1irq[2] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_1_Q3_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc1irq[3] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h74 &&
          updataival_3 == 1'b1 &&
          updatai_3[3] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc1irq[3] <= 1'b0 ;
        end
      else if (adpbc_sessend_rise == 1'b1)
        begin
        adpbc1irq[3] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_1_Q4_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc1irq[4] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h74 &&
          updataival_3 == 1'b1 &&
          updatai_3[4] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc1irq[4] <= 1'b0 ;
        end
      else if (dm_vdat_ref_rise == 1'b1)
        begin
        adpbc1irq[4] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_1_Q5_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc1irq[5] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h74 &&
          updataival_3 == 1'b1 &&
          updatai_3[5] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc1irq[5] <= 1'b0 ;
        end
      else if (dp_vdat_ref_rise == 1'b1)
        begin
        adpbc1irq[5] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_1_Q6_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc1irq[6] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h74 &&
          updataival_3 == 1'b1 &&
          updatai_3[6] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc1irq[6] <= 1'b0 ;
        end
      else if (dcd_comp_rise == 1'b1)
        begin
        adpbc1irq[6] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_1_Q7_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc1irq[7] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h74 &&
          updataival_3 == 1'b1 &&
          updatai_3[7] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc1irq[7] <= 1'b0 ;
        end
      else if (dcd_comp_fall == 1'b1)
        begin
        adpbc1irq[7] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_2_Q0_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc2irq[0] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h75 &&
          updataival_3 == 1'b1 &&
          updatai_3[0] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc2irq[0] <= 1'b0 ;
        end
      else if (adpbc_rid_a_rise == 1'b1)
        begin
        adpbc2irq[0] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_2_Q1_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc2irq[1] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h75 &&
          updataival_3 == 1'b1 &&
          updatai_3[1] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc2irq[1] <= 1'b0 ;
        end
      else if (adpbc_rid_b_rise == 1'b1)
        begin
        adpbc2irq[1] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_2_Q2_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc2irq[2] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h75 &&
          updataival_3 == 1'b1 &&
          updatai_3[2] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc2irq[2] <= 1'b0 ;
        end
      else if (adpbc_rid_c_rise == 1'b1)
        begin
        adpbc2irq[2] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_2_Q3_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc2irq[3] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h75 &&
          updataival_3 == 1'b1 &&
          updatai_3[3] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc2irq[3] <= 1'b0 ;
        end
      else if (adpbc_rid_gnd_rise == 1'b1)
        begin
        adpbc2irq[3] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_2_Q4_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc2irq[4] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h75 &&
          updataival_3 == 1'b1 &&
          updatai_3[4] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc2irq[4] <= 1'b0 ;
        end
      else if (adpbc_rid_float_rise == 1'b1)
        begin
        adpbc2irq[4] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_2_Q5_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc2irq[5] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h75 &&
          updataival_3 == 1'b1 &&
          updatai_3[5] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc2irq[5] <= 1'b0 ;
        end
      else if (adpbc_rid_float_fall == 1'b1)
        begin
        adpbc2irq[5] <= 1'b1 ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_IRQ_2_Q6_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc2irq[6] <= 1'b0 ;
      end
    else
      begin

      if (upaddr == 8'h75 &&
          updataival_3 == 1'b1 &&
          updatai_3[6] == 1'b1 &&
          upwr == 1'b1)
        begin

        adpbc2irq[6] <= 1'b0 ;
        end
      else if (dm_vlgc_comp_rise == 1'b1)
        begin
        adpbc2irq[6] <= 1'b1 ;
        end
      end
    end




  assign adpbc1irq_m = (adpbc1irq & adpbc1ien);




  assign adpbc2irq_m = (adpbc2irq & adpbc2ien);




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : WAKEUPIEN_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      wakeupien <= 1'b0;
      end
    else
      begin
      if (upaddr == 8'h66 &&
          updataival_1 == 1'b1 &&
          upwr == 1'b1)
        begin


        wakeupien <= updatai_1[7];
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : WUINTREQ_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      wuintreq_r <= 1'b0;
      end
    else
      begin
      wuintreq_r <= wuintreq;
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : EXTERNAL_IRQ_Q7_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      wakeupirq <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'h63 &&
          updataival_1 == 1'b1 &&
          updatai_1[7] == 1'b1 &&
          upwr == 1'b1)
        begin

        wakeupirq <= 1'b0 ;
        end
      else if (wuintreq == 1'b1 && wuintreq_r == 1'b0)
        begin
        wakeupirq <= 1'b1 ;
        end
      end
    end




  assign wakeupirq_m = (wakeupirq & wakeupien);




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : VBUSFAULTIEN_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      vbusfaultien <= 2'b00;
      end
    else
      begin
      if (upaddr == 8'h66 &&
          updataival_1 == 1'b1 &&
          upwr == 1'b1)
        begin


        vbusfaultien <= updatai_1[1:0];
        end
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : VBUSFAULT_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      vbusfault_r <= 1'b1;
      end
    else
      begin
      vbusfault_r <= vbusfault;
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : EXTERNAL_IRQ_Q10_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      vbusfaultirq <= 2'b00 ;
      end
    else
      begin
      if (upaddr == 8'h63 &&
          updataival_1 == 1'b1 &&
          updatai_1[1] == 1'b1 &&
          upwr == 1'b1)
        begin

        vbusfaultirq[1] <= 1'b0 ;
        end
      else if (vbusfault == 1'b1 && vbusfault_r == 1'b0)
        begin
        vbusfaultirq[1] <= 1'b1 ;
        end

      if (upaddr == 8'h63 &&
          updataival_1 == 1'b1 &&
          updatai_1[0] == 1'b1 &&
          upwr == 1'b1)
        begin

        vbusfaultirq[0] <= 1'b0 ;
        end
      else if (vbusfault == 1'b0 && vbusfault_r == 1'b1)
        begin
        vbusfaultirq[0] <= 1'b1 ;
        end
      end
    end




  assign vbusfaultirq_m = (vbusfaultirq & vbusfaultien);




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCPORTCTRL_USBRSTSIG_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcportctrl[7:6] <= 2'b01 ;
      hcportctrl[5]   <= 1'b0 ;
      end
    else
      begin
      if (usbrstsigclr == 1'b1)
        begin
        hcportctrl[5] <= 1'b0 ;
        end

      else if (upaddr == 8'h6A &&
               updataival_3 == 1'b1 &&
               upwr == 1'b1 && hcportctrl[5] == 1'b0)
        begin

        hcportctrl[7:6] <= updatai_3[7:6] ;
        hcportctrl[5]   <= updatai_3[5] ;
        end
      end
    end




  assign usbrstsig16ms = hcportctrl[7] ;




  assign usbrstsig55ms = hcportctrl[6] ;




  assign usbrstsig = hcportctrl[5] ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HCPORTCTRL_Q40_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hcportctrl[4:0] <= {5{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h6A &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1)
        begin

        hcportctrl[4:0] <= updatai_3[4:0] ;
        end
      end
    end




  assign portctrltm = hcportctrl[4:0] ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFOCTRL_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoctrl <= FIFOCTRL_RV[7];
      end
    else
      begin
      if (upwr == 1'b1)
        begin
        if (upaddr == FIFOCTRL_ID[9:2] &&
            updataival_0 == 1'b1)
          begin

          fifoctrl <= updatai_0[7];
          end
        else if (upaddr == 8'h01 &&
                 updataival_3 == 1'b1 && updatai_3[3:0] == 4'h0)
          begin

          fifoctrl <= updatai_3[7];
          end
        end
      end
    end





  assign fifoctrl_7 = fifoctrl ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : UPENDIAN_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      upendian <= ENDIAN_RV[7];
      end
    else
      begin
      if (upaddr == 8'hF7 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1 && (updatai_0[1] ^ updatai_0[0]) == 1'b1)
        begin
        upendian <= updatai_0[1];
        end
      end
    end




  always @(usbirq or usbien or usbcs or endprst or
           ivec or
           fnaddr or
           fifoctrl or
           tfrmnr or tfrmnrm or
           outxpngirq or outxirq or inxirq or
           outxpngien or outxien or inxien or
           tbvbuspls or tawaitbcon or taaidlbdis or
           otgien or otgctrl or otgstate or otgirq or otgforce or
           otgstatus or
           otg2ctrl or
           adpbc_ctrl_0 or adpbc_ctrl_1 or adpbc_ctrl_2 or
           adpbc_status_2 or adpbc_status_1 or adpbc_status_0 or
           adpbc2ien or adpbc1ien or
           adpbc1irq or adpbc2irq or
           vbusfaultirq or vbusfaultien or
           hcoutxerrirq or hcinxerrirq or
           hcoutxerrien or hcinxerrien or
           hcfrmcount or hcfrmnr or
           hcportctrl or
           tbvbusdispls or
           otgspeed or
           wakeupirq or wakeupien or
           inxisoautoarm or inxisodctrl or inxisoautodump or
        `ifdef CDNSUSBHS_OTHERS_EPOUT_DO_NOT_EXIST
        `else
           outxstartaddr_rd or
        `endif
        `ifdef CDNSUSBHS_OTHERS_EPIN_DO_NOT_EXIST
        `else
           inxstartaddr_rd or
        `endif
        `ifdef CDNSUSBHS_OTHERS_EPOUT_DO_NOT_EXIST
          out0maxpck or
        `else
          outxmaxpck_0_rd or outxmaxpck_1_rd or
        `endif
        `ifdef CDNSUSBHS_OTHERS_EPIN_DO_NOT_EXIST
        `else
           inxmaxpck_0_rd or inxmaxpck_1_rd or
        `endif
           debug_tx_irq or debug_rx_irq or workaround_a_irq or
           debug_tx_ien or debug_rx_ien or workaround_a_ien or
           debug_rx_status or debug_rx_pid or debug_rx_databyte or
           debug_tx_pid or debug_tx_databyte or
           workaround_a_value or workaround_d_enable or workaround_c_enable or workaround_b_enable or workaround_a_enable or
           workaround_otg or
           hsdisable or
           sof_rcv_disable or
           upendian or
  `ifdef CDNSUSB2PHY_3RD
           phy_suspendm_low or phy_utmi_reset or phy_ponrst or
  `else
        `ifdef CDNSUSBHS_SLEEPM_50REF
           phy_suspendm_low or phy_sleepm_ref_ or phy_reset or phy_databus_reset or phy_powerdown or
        `else
           phy_suspendm_low or phy_sleepm_ref or phy_reset or phy_databus_reset or phy_powerdown or
        `endif
           phy_pll_clkon or phy_pll_standalone or phy_pll_clk_sel or
  `endif
  `ifdef CDNSUSB2PHY_3RD
  `else
           tsfr_rstb or tsfr_wr16 or tsfr_busy or tsfr_rdata_r or tsfr_wdata or tsfr_addr or
  `endif
           upaddr)
    begin : UPDATAO_COMB_PROC
      reg [7:0]  upaddr92_v;
      reg [31:0] dataout_v;


    dataout_v  = {32{1'b0}};
    updatao    = {32{1'b0}};
    upaddr92_v = upaddr;


    case (upaddr92_v)
        8'h62 :
            begin
            dataout_v = {outxirq,
                         inxirq};
            end
        8'h63 :
            begin
            dataout_v = {outxpngirq,
                         wakeupirq, 3'b000, 2'b00, vbusfaultirq,
                         usbirq[6], 1'b0, usbirq[5:0]};
            end
        8'h65 :
            begin
            dataout_v = {outxien,
                         inxien};
            end
        8'h66 :
            begin
            dataout_v = {outxpngien,
                         wakeupien, 3'b000, 2'b00, vbusfaultien,
                         usbien[6], 1'b0, usbien[5:0]};
            end
        8'h68 :
            begin
            dataout_v = {usbcs,
                         endprst[5], 2'b00, endprst[4:0],
                         8'h00,
                         ivec};
            end
        8'h69 :
            begin
            dataout_v = {8'h00,
                         1'b0, fnaddr,
                         2'b00, tfrmnr, tfrmnrm};
            end
        8'h6A :
            begin
            dataout_v = {hcportctrl,
                         8'h00,
                         hsdisable, 3'b000, 1'b0, otgspeed,
                         fifoctrl,
                         7'b0000000};
            end
        8'h6B :
            begin

            dataout_v = {3'b000, hcfrmcount, 2'b00,
                         hcfrmnr};
            end
        8'h6D :
            begin

            dataout_v = {hcoutxerrirq,
                         hcinxerrirq};
            end
        8'h6E :
            begin

            dataout_v = {hcoutxerrien,
                         hcinxerrien};
            end
        8'h6F :
            begin

            dataout_v = {otgstatus,
                         otgctrl[6], 1'b0, otgctrl[5:0],
                         3'b000, otgstate,
                         otgirq};
            end
        8'h70 :
            begin

            dataout_v = {tbvbuspls,
                         tawaitbcon,
                         taaidlbdis,
                         otgien};
            end
        8'h71 :
            begin
            dataout_v = {tbvbusdispls,
                         8'h00,
                         otgforce,
                         4'b0000, 2'b00, otg2ctrl};
            end
        `ifdef CDNSUSB2PHY_3RD
        `else
        8'h72 :
            begin
            dataout_v = {tsfr_rstb, 2'b00, tsfr_wr16, 3'b000, tsfr_busy,
                         tsfr_rdata_r,
                         tsfr_wdata,
                         tsfr_addr};
            end
        `endif
        8'h73 :
            begin
            dataout_v = {1'b0, adpbc2ien,
                         adpbc1ien,
                         inxisoautoarm, 1'b0};
            end
        8'h74 :
            begin
            dataout_v = {adpbc1irq,
                         adpbc_ctrl_2,
                         2'b00, adpbc_ctrl_1,
                         3'b000, adpbc_ctrl_0};
            end
        8'h75 :
            begin
            dataout_v = {1'b0, adpbc2irq,
                         3'b000, adpbc_status_2,
                         adpbc_status_1,
                         adpbc_status_0};
            end
        8'h76 :
            begin
          `ifdef CDNSUSB2PHY_3RD
            dataout_v = {8'h00,
                         8'h00,
                         inxisodctrl, 1'b0};
          `else
            dataout_v = {phy_pll_clkon, phy_pll_standalone, phy_pll_clk_sel, 4'h0,
                         8'h00,
                         inxisodctrl, 1'b0};
          `endif
            end
        8'h77 :
            begin
          `ifdef CDNSUSB2PHY_3RD
            dataout_v = {phy_suspendm_low, 3'b000, phy_utmi_reset, phy_ponrst, 2'b00,
                         8'h00,
                         inxisoautodump, 1'b0};
          `else
          `ifdef CDNSUSBHS_SLEEPM_50REF
            dataout_v = {phy_suspendm_low, phy_sleepm_ref_, 2'b00, phy_reset, phy_databus_reset, phy_powerdown,
                         8'h00,
                         inxisoautodump, 1'b0};
          `else
            dataout_v = {phy_suspendm_low, phy_sleepm_ref, 2'b00, phy_reset, phy_databus_reset, phy_powerdown,
                         8'h00,
                         inxisoautodump, 1'b0};
          `endif
          `endif
            end
      `ifdef CDNSUSBHS_OTHERS_EPOUT_DO_NOT_EXIST
        8'h78 :
            begin
            dataout_v = {8'h00,
                         8'h00,
                         8'h00,
                         4'h0, out0maxpck};
            end
      `else
        8'h78, 8'h79,
        8'h7A, 8'h7B,
        8'h7C, 8'h7D,
        8'h7E, 8'h7F :
            begin
            dataout_v = {5'b00000, outxmaxpck_1_rd,
                         5'b00000, outxmaxpck_0_rd};
            end
      `endif
      `ifdef CDNSUSBHS_OTHERS_EPOUT_DO_NOT_EXIST
      `else
        8'hC1, 8'hC2, 8'hC3,
        8'hC4, 8'hC5, 8'hC6,
        8'hC7, 8'hC8, 8'hC9,
        8'hCA, 8'hCB, 8'hCC,
        8'hCD, 8'hCE, 8'hCF :
            begin
            dataout_v[15:2] = outxstartaddr_rd;
           end
      `endif
      `ifdef CDNSUSBHS_OTHERS_EPIN_DO_NOT_EXIST
      `else
        8'hD1, 8'hD2, 8'hD3,
        8'hD4, 8'hD5, 8'hD6,
        8'hD7, 8'hD8, 8'hD9,
        8'hDA, 8'hDB, 8'hDC,
        8'hDD, 8'hDE, 8'hDF :
            begin
            dataout_v[15:2] = inxstartaddr_rd;
            end
      `endif
        8'hF4 :
            begin
            dataout_v = {debug_tx_irq, debug_rx_irq, 2'b00, 3'b000, workaround_a_irq,
                         debug_rx_status, debug_rx_pid,
                         5'b0_0000, debug_rx_databyte} ;
            end
        8'hF5 :
            begin
            dataout_v = {debug_tx_ien, debug_rx_ien, 2'b00, 3'b000, workaround_a_ien,
                         4'b0000, debug_tx_pid,
                         5'b0_0000, debug_tx_databyte} ;
            end
        8'hF6 :
            begin
            dataout_v = {sof_rcv_disable, 2'b00, workaround_otg[2], 2'b00, workaround_otg[1:0],
                         8'h00,
                         4'h0, workaround_a_value,
                         4'h0, workaround_d_enable, workaround_c_enable, workaround_b_enable, workaround_a_enable};
            end
        8'hF7 :
            begin
            dataout_v = {upendian, 7'b000_0000,
                         8'h00,
                         8'h00,
                         upendian, 7'b000_0000};
            end
      `ifdef CDNSUSBHS_OTHERS_EPIN_DO_NOT_EXIST
      `else
        8'hF8, 8'hF9,
        8'hFA, 8'hFB,
        8'hFC, 8'hFD,
        8'hFE, 8'hFF :
            begin
            dataout_v = {5'b00000, inxmaxpck_1_rd,
                         5'b00000, inxmaxpck_0_rd};
            end
      `endif
        default :
            begin
            dataout_v = {32{1'b0}};
            end
    endcase

    updatao = dataout_v;
    end








  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : INXISOAUTOARM_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      inxisoautoarm_r <= {15{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 1; i = i - 1)
        begin
        if (upaddr == 8'h73 &&
            updataival_1_0[i] == 1'b1 &&
            upwr == 1'b1)
          begin
          inxisoautoarm_r[i] <= updatai_1_0[i] ;
          end
        end
      end
    end



  assign inxisoautoarm = inxisoautoarm_r & EPINEXIST[15:1];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : INXISODCTRL_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      inxisodctrl_r <= {15{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 1; i = i - 1)
        begin
        if (upaddr == 8'h76 &&
            updataival_1_0[i] == 1'b1 &&
            upwr == 1'b1)
          begin
          inxisodctrl_r[i] <= updatai_1_0[i] ;
          end
        end
      end
    end



  assign inxisodctrl = inxisodctrl_r & EPINEXIST[15:1];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : INXISOAUTODUMP_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      inxisoautodump_r <= {15{1'b0}} ;
      end
    else
      begin
      for(i = 15; i >= 1; i = i - 1)
        begin
        if (upaddr == 8'h77 &&
            updataival_1_0[i] == 1'b1 &&
            upwr == 1'b1)
          begin
          inxisoautodump_r[i] <= updatai_1_0[i] ;
          end
        end
      end
    end



  assign inxisoautodump = inxisoautodump_r & EPINEXIST[15:1];













  `ifdef CDNSUSBHS_OTHERS_EPOUT_DO_NOT_EXIST
  `else
  always @(
           updataival_1 or updataival_0 or

           updatai_1 or updatai_0 or
        `ifdef CDNSUSBHS_EPOUT_EXIST_15
           out15startaddr or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_14
           out14startaddr or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_13
           out13startaddr or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_12
           out12startaddr or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_11
           out11startaddr or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_10
           out10startaddr or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_9
           out9startaddr or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_8
           out8startaddr or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_7
           out7startaddr or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_6
           out6startaddr or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_5
           out5startaddr or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_4
           out4startaddr or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_3
           out3startaddr or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_2
           out2startaddr or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_1
           out1startaddr or
        `endif
           upaddr)
    begin : OUTXSTARTADDR_COMB_PROC


    outxstartaddr    = {14{1'b0}};


    case (upaddr)
    `ifdef CDNSUSBHS_EPOUT_EXIST_15
      8'hCF   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out15startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_14
      8'hCE   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out14startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_13
      8'hCD   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out13startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_12
      8'hCC   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out12startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_11
      8'hCB   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out11startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_10
      8'hCA   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out10startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_9
      8'hC9   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out9startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_8
      8'hC8   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out8startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_7
      8'hC7   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out7startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_6
      8'hC6   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out6startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_5
      8'hC5   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out5startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_4
      8'hC4   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out4startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_3
      8'hC3   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out3startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_2
      8'hC2   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out2startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_1
      8'hC1   : begin
                outxstartaddr[OUTADDRWIDTH-1:2] = out1startaddr;
                end
    `endif
      default : begin
                outxstartaddr                   = {14{1'b0}};
                end
    endcase

    outxstartaddr_rd = outxstartaddr;









    if (updataival_1 == 1'b1)
      begin
      outxstartaddr[15:8]  = updatai_1;
      end
    if (updataival_0 == 1'b1)
      begin
      outxstartaddr[7:2]   = updatai_0[7:2];
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_15



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT15STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out15startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hCF &&
          upwr == 1'b1)
        begin
        out15startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_14



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT14STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out14startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hCE &&
          upwr == 1'b1)
        begin
        out14startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_13



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT13STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out13startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hCD &&
          upwr == 1'b1)
        begin
        out13startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_12



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT12STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out12startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hCC &&
          upwr == 1'b1)
        begin
        out12startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_11



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT11STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out11startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hCB &&
          upwr == 1'b1)
        begin
        out11startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_10



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT10STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out10startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hCA &&
          upwr == 1'b1)
        begin
        out10startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_9



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT9STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out9startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hC9 &&
          upwr == 1'b1)
        begin
        out9startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_8



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT8STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out8startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hC8 &&
          upwr == 1'b1)
        begin
        out8startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_7



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT7STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out7startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hC7 &&
          upwr == 1'b1)
        begin
        out7startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_6



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT6STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out6startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hC6 &&
          upwr == 1'b1)
        begin
        out6startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_5



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT5STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out5startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hC5 &&
          upwr == 1'b1)
        begin
        out5startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_4



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT4STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out4startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hC4 &&
          upwr == 1'b1)
        begin
        out4startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_3



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT3STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out3startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hC3 &&
          upwr == 1'b1)
        begin
        out3startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_2



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT2STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out2startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hC2 &&
          upwr == 1'b1)
        begin
        out2startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_1



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT1STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out1startaddr <= {OUTADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hC1 &&
          upwr == 1'b1)
        begin
        out1startaddr <= outxstartaddr[OUTADDRWIDTH-1:2] ;
        end
      end
    end
  `endif







  `ifdef CDNSUSBHS_OTHERS_EPIN_DO_NOT_EXIST
  `else
  always @(
           updataival_1 or updataival_0 or

           updatai_1 or updatai_0 or
        `ifdef CDNSUSBHS_EPIN_EXIST_15
           in15startaddr or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_14
           in14startaddr or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_13
           in13startaddr or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_12
           in12startaddr or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_11
           in11startaddr or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_10
           in10startaddr or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_9
           in9startaddr or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_8
           in8startaddr or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_7
           in7startaddr or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_6
           in6startaddr or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_5
           in5startaddr or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_4
           in4startaddr or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_3
           in3startaddr or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_2
           in2startaddr or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_1
           in1startaddr or
        `endif
           upaddr)
    begin : INXSTARTADDR_COMB_PROC


    inxstartaddr    = {14{1'b0}};


    case (upaddr)
    `ifdef CDNSUSBHS_EPIN_EXIST_15
      8'hDF   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in15startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_14
      8'hDE   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in14startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_13
      8'hDD   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in13startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_12
      8'hDC   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in12startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_11
      8'hDB   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in11startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_10
      8'hDA   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in10startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_9
      8'hD9   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in9startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_8
      8'hD8   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in8startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_7
      8'hD7   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in7startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_6
      8'hD6   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in6startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_5
      8'hD5   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in5startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_4
      8'hD4   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in4startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_3
      8'hD3   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in3startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_2
      8'hD2   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in2startaddr;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_1
      8'hD1   : begin
                inxstartaddr[INADDRWIDTH-1:2] = in1startaddr;
                end
    `endif
      default : begin
                inxstartaddr                  = {14{1'b0}};
                end
    endcase

    inxstartaddr_rd = inxstartaddr;









    if (updataival_1 == 1'b1)
      begin
      inxstartaddr[15:8]  = updatai_1;
      end
    if (updataival_0 == 1'b1)
      begin
      inxstartaddr[7:2]   = updatai_0[7:2];
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_15



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN15STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in15startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hDF &&
          upwr == 1'b1)
        begin
        in15startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_14



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN14STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in14startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hDE &&
          upwr == 1'b1)
        begin
        in14startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_13



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN13STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in13startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hDD &&
          upwr == 1'b1)
        begin
        in13startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_12



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN12STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in12startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hDC &&
          upwr == 1'b1)
        begin
        in12startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_11



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN11STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in11startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hDB &&
          upwr == 1'b1)
        begin
        in11startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_10



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN10STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in10startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hDA &&
          upwr == 1'b1)
        begin
        in10startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_9



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN9STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in9startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hD9 &&
          upwr == 1'b1)
        begin
        in9startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_8



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN8STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in8startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hD8 &&
          upwr == 1'b1)
        begin
        in8startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_7



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN7STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in7startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hD7 &&
          upwr == 1'b1)
        begin
        in7startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_6



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN6STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in6startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hD6 &&
          upwr == 1'b1)
        begin
        in6startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_5



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN5STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in5startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hD5 &&
          upwr == 1'b1)
        begin
        in5startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_4



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN4STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in4startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hD4 &&
          upwr == 1'b1)
        begin
        in4startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_3



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN3STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in3startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hD3 &&
          upwr == 1'b1)
        begin
        in3startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_2



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN2STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in2startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hD2 &&
          upwr == 1'b1)
        begin
        in2startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_1



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN1STARTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in1startaddr <= {INADDRWIDTH-2{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hD1 &&
          upwr == 1'b1)
        begin
        in1startaddr <= inxstartaddr[INADDRWIDTH-1:2] ;
        end
      end
    end
  `endif





  `ifdef CDNSUSBHS_OTHERS_EPOUT_DO_NOT_EXIST
  `else


  always @(updataival_3 or updataival_2 or
           updataival_1 or updataival_0 or
           updatai_3 or updatai_2 or
           updatai_1 or updatai_0 or
        `ifdef CDNSUSBHS_EPOUT_EXIST_15
           out15maxpck or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_14
           out14maxpck or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_13
           out13maxpck or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_12
           out12maxpck or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_11
           out11maxpck or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_10
           out10maxpck or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_9
           out9maxpck or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_8
           out8maxpck or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_7
           out7maxpck or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_6
           out6maxpck or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_5
           out5maxpck or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_4
           out4maxpck or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_3
           out3maxpck or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_2
           out2maxpck or
        `endif
        `ifdef CDNSUSBHS_EPOUT_EXIST_1
           out1maxpck or
        `endif
           out0maxpck or
           upaddr)
    begin : OUTMAXPCK_COMB_PROC





    case (upaddr)
    `ifdef CDNSUSBHS_EPOUT_EXIST_15
      8'h7F   : begin
                outxmaxpck_1 = out15maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_13
      8'h7E   : begin
                outxmaxpck_1 = out13maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_11
      8'h7D   : begin
                outxmaxpck_1 = out11maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_9
      8'h7C   : begin
                outxmaxpck_1 = out9maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_7
      8'h7B   : begin
                outxmaxpck_1 = out7maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_5
      8'h7A   : begin
                outxmaxpck_1 = out5maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_3
      8'h79   : begin
                outxmaxpck_1 = out3maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_1
      8'h78   : begin
                outxmaxpck_1 = out1maxpck;
                end
    `endif
      default : begin
                outxmaxpck_1 = {11{1'b0}};
                end
    endcase

    case (upaddr)
    `ifdef CDNSUSBHS_EPOUT_EXIST_14
      8'h7F   : begin
                outxmaxpck_0 = out14maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_12
      8'h7E   : begin
                outxmaxpck_0 = out12maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_10
      8'h7D   : begin
                outxmaxpck_0 = out10maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_8
      8'h7C   : begin
                outxmaxpck_0 = out8maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_6
      8'h7B   : begin
                outxmaxpck_0 = out6maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_4
      8'h7A   : begin
                outxmaxpck_0 = out4maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_2
      8'h79   : begin
                outxmaxpck_0 = out2maxpck;
                end
    `endif
      8'h78   : begin
                outxmaxpck_0 = {4'h0, out0maxpck};
                end
      default : begin
                outxmaxpck_0 = {11{1'b0}};
                end
    endcase

    outxmaxpck_1_rd = outxmaxpck_1;
    outxmaxpck_0_rd = outxmaxpck_0;

    if (updataival_3 == 1'b1)
      begin
      outxmaxpck_1[10:8] = updatai_3[2:0];
      end
    if (updataival_2 == 1'b1)
      begin
      outxmaxpck_1[7:0]  = updatai_2;
      end
    if (updataival_1 == 1'b1)
      begin
      outxmaxpck_0[10:8] = updatai_1[2:0];
      end
    if (updataival_0 == 1'b1)
      begin
      outxmaxpck_0[7:0]  = updatai_0;
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_15


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT15MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out15maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h7F &&
          upwr == 1'b1)
        begin
        out15maxpck <= outxmaxpck_1;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_14


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT14MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out14maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h7F &&
          upwr == 1'b1)
        begin
        out14maxpck <= outxmaxpck_0;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_13


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT13MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out13maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h7E &&
          upwr == 1'b1)
        begin
        out13maxpck <= outxmaxpck_1;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_12


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT12MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out12maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h7E &&
          upwr == 1'b1)
        begin
        out12maxpck <= outxmaxpck_0;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_11


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT11MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out11maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h7D &&
          upwr == 1'b1)
        begin
        out11maxpck <= outxmaxpck_1;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_10


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT10MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out10maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h7D &&
          upwr == 1'b1)
        begin
        out10maxpck <= outxmaxpck_0;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_9


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT9MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out9maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h7C &&
          upwr == 1'b1)
        begin
        out9maxpck <= outxmaxpck_1;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_8


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT8MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out8maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h7C &&
          upwr == 1'b1)
        begin
        out8maxpck <= outxmaxpck_0;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_7


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT7MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out7maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h7B &&
          upwr == 1'b1)
        begin
        out7maxpck <= outxmaxpck_1;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_6


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT6MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out6maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h7B &&
          upwr == 1'b1)
        begin
        out6maxpck <= outxmaxpck_0;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_5


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT5MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out5maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h7A &&
          upwr == 1'b1)
        begin
        out5maxpck <= outxmaxpck_1;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_4


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT4MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out4maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h7A &&
          upwr == 1'b1)
        begin
        out4maxpck <= outxmaxpck_0;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_3


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT3MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out3maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h79 &&
          upwr == 1'b1)
        begin
        out3maxpck <= outxmaxpck_1;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_2


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT2MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out2maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h79 &&
          upwr == 1'b1)
        begin
        out2maxpck <= outxmaxpck_0;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPOUT_EXIST_1


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT1MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out1maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h78 &&
          upwr == 1'b1)
        begin
        out1maxpck <= outxmaxpck_1;
        end
      end
    end
  `endif



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT0MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out0maxpck <= {7{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'h78 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1)
        begin
        out0maxpck <= updatai_0[6:0];
        end
      end
    end





  `ifdef CDNSUSBHS_OTHERS_EPIN_DO_NOT_EXIST
  `else


  always @(updataival_3 or updataival_2 or
           updataival_1 or updataival_0 or
           updatai_3 or updatai_2 or
           updatai_1 or updatai_0 or
        `ifdef CDNSUSBHS_EPIN_EXIST_15
           in15maxpck or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_14
           in14maxpck or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_13
           in13maxpck or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_12
           in12maxpck or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_11
           in11maxpck or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_10
           in10maxpck or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_9
           in9maxpck or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_8
           in8maxpck or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_7
           in7maxpck or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_6
           in6maxpck or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_5
           in5maxpck or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_4
           in4maxpck or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_3
           in3maxpck or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_2
           in2maxpck or
        `endif
        `ifdef CDNSUSBHS_EPIN_EXIST_1
           in1maxpck or
        `endif
           upaddr)
    begin : INMAXPCK_COMB_PROC





    case (upaddr)
    `ifdef CDNSUSBHS_EPIN_EXIST_15
      8'hFF   : begin
                inxmaxpck_1 = in15maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_13
      8'hFE   : begin
                inxmaxpck_1 = in13maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_11
      8'hFD   : begin
                inxmaxpck_1 = in11maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_9
      8'hFC   : begin
                inxmaxpck_1 = in9maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_7
      8'hFB   : begin
                inxmaxpck_1 = in7maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_5
      8'hFA   : begin
                inxmaxpck_1 = in5maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_3
      8'hF9   : begin
                inxmaxpck_1 = in3maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_1
      8'hF8   : begin
                inxmaxpck_1 = in1maxpck;
                end
    `endif
      default : begin
                inxmaxpck_1 = {11{1'b0}};
                end
    endcase

    case (upaddr)
    `ifdef CDNSUSBHS_EPIN_EXIST_14
      8'hFF   : begin
                inxmaxpck_0 = in14maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_12
      8'hFE   : begin
                inxmaxpck_0 = in12maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_10
      8'hFD   : begin
                inxmaxpck_0 = in10maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_8
      8'hFC   : begin
                inxmaxpck_0 = in8maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_6
      8'hFB   : begin
                inxmaxpck_0 = in6maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_4
      8'hFA   : begin
                inxmaxpck_0 = in4maxpck;
                end
    `endif
    `ifdef CDNSUSBHS_EPIN_EXIST_2
      8'hF9   : begin
                inxmaxpck_0 = in2maxpck;
                end
    `endif
      default : begin
                inxmaxpck_0 = {11{1'b0}};
                end
    endcase

    inxmaxpck_1_rd = inxmaxpck_1;
    inxmaxpck_0_rd = inxmaxpck_0;

    if (updataival_3 == 1'b1)
      begin
      inxmaxpck_1[10:8] = updatai_3[2:0];
      end
    if (updataival_2 == 1'b1)
      begin
      inxmaxpck_1[7:0]  = updatai_2;
      end
    if (updataival_1 == 1'b1)
      begin
      inxmaxpck_0[10:8] = updatai_1[2:0];
      end
    if (updataival_0 == 1'b1)
      begin
      inxmaxpck_0[7:0]  = updatai_0;
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_15


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN15MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in15maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hFF &&
          upwr == 1'b1)
        begin
        in15maxpck <= inxmaxpck_1;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_14


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN14MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in14maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hFF &&
          upwr == 1'b1)
        begin
        in14maxpck <= inxmaxpck_0;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_13


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN13MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in13maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hFE &&
          upwr == 1'b1)
        begin
        in13maxpck <= inxmaxpck_1;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_12


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN12MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in12maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hFE &&
          upwr == 1'b1)
        begin
        in12maxpck <= inxmaxpck_0;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_11


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN11MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in11maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hFD &&
          upwr == 1'b1)
        begin
        in11maxpck <= inxmaxpck_1;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_10


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN10MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in10maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hFD &&
          upwr == 1'b1)
        begin
        in10maxpck <= inxmaxpck_0;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_9


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN9MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in9maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hFC &&
          upwr == 1'b1)
        begin
        in9maxpck <= inxmaxpck_1;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_8


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN8MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in8maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hFC &&
          upwr == 1'b1)
        begin
        in8maxpck <= inxmaxpck_0;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_7


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN7MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in7maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hFB &&
          upwr == 1'b1)
        begin
        in7maxpck <= inxmaxpck_1;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_6


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN6MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in6maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hFB &&
          upwr == 1'b1)
        begin
        in6maxpck <= inxmaxpck_0;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_5


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN5MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in5maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hFA &&
          upwr == 1'b1)
        begin
        in5maxpck <= inxmaxpck_1;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_4


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN4MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in4maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hFA &&
          upwr == 1'b1)
        begin
        in4maxpck <= inxmaxpck_0;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_3


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN3MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in3maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hF9 &&
          upwr == 1'b1)
        begin
        in3maxpck <= inxmaxpck_1;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_2


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN2MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in2maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hF9 &&
          upwr == 1'b1)
        begin
        in2maxpck <= inxmaxpck_0;
        end
      end
    end
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_1


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : IN1MAXPCK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      in1maxpck <= {11{1'b0}} ;
      end
    else
      begin
      if (upaddr == 8'hF8 &&
          upwr == 1'b1)
        begin
        in1maxpck <= inxmaxpck_1;
        end
      end
    end
  `endif



  assign in0maxpck = out0maxpck;

  `ifdef CDNSUSB2PHY_3RD
  `else


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : TSFR_RESET_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      tsfr_rstb <= 1'b0;
      tsfr_wr16 <= 1'b0;
      end
    else
      begin
      if (upaddr == 8'h72 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1)
        begin
        tsfr_rstb <= updatai_3[7];
        tsfr_wr16 <= updatai_3[4];
        end
      end
    end



  assign tsfr_wr32 = updatai_3[5];



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : TSFR_ADDR_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      tsfr_addr_req <=    1'b0;
      tsfr_addr     <= {8{1'b0}};
      end
    else
      begin
      if (upaddr == 8'h72 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1)
        begin
        if (access_size == 2'b00 ||
           (access_size == 2'b01 && tsfr_wr16 == 1'b0) ||
           (access_size == 2'b10 && tsfr_wr32 == 1'b0))
          begin
          tsfr_addr_req <= ~tsfr_addr_req;
          end
        tsfr_addr     <=  updatai_0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : TSFR_WRITE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      tsfr_wdata_req  <=    1'b0;
      tsfr_wdata      <= {8{1'b0}};
      end
    else
      begin
      if (upaddr == 8'h72 &&
          updataival_1 == 1'b1 &&
          upwr == 1'b1)
        begin
        if (access_size == 2'b00 ||
           (access_size == 2'b01 && tsfr_wr16 == 1'b1) ||
           (access_size == 2'b10 && tsfr_wr32 == 1'b1))
          begin
          tsfr_wdata_req <= ~tsfr_wdata_req;
          tsfr_wdata     <=  updatai_1;
          end
        else
          begin
          tsfr_wdata     <=  {8{1'b0}};
          end
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : TSFR_VALID_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      tsfr_busy <= 1'b0;
      end
    else
      begin
      if (tsfr_rdata_req_r != tsfr_rdata_req)
        begin
        tsfr_busy <= 1'b0;
        end
      else if (upaddr == 8'h72 &&
              (updataival_0 == 1'b1 || (updataival_1 == 1'b1 && access_size == 2'b00)) &&
               upwr == 1'b1)
        begin
        tsfr_busy <= 1'b1;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : TSFR_RDATA_REQ_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      tsfr_rdata_req_r <= 1'b0;
      end
    else
      begin
      tsfr_rdata_req_r <= tsfr_rdata_req;
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : TSFR_RDATA_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      tsfr_rdata_r <= 8'h00;
      end
    else
      begin
      if (tsfr_rdata_req_r != tsfr_rdata_req)
        begin
        tsfr_rdata_r <= tsfr_rdata;
        end
      end
    end



  always @(updataival_3 or
           updataival_2 or
           updataival_1 or
           updataival_0)
    begin : ACCESS_SIZE_PROC

    case ({updataival_3,updataival_2,updataival_1,updataival_0})
      4'b1111 : begin
                access_size = 2'b10;
                end
      4'b1100,
      4'b0011 : begin
                access_size = 2'b01;
                end
      default : begin
                access_size = 2'b00;
                end
    endcase
    end
  `endif

  `ifdef CDNSUSB2PHY_3RD


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : PHYCTRL_0_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      phy_suspendm_low  <= 1'b0;
      phy_utmi_reset    <= 1'b0;
      phy_ponrst        <= 1'b0;
      end
    else
      begin
      if (upaddr == 8'h77 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1)
        begin
        phy_suspendm_low  <= updatai_3[7];
        phy_utmi_reset    <= updatai_3[3];
        phy_ponrst        <= updatai_3[2];
        end
      end
    end
  `else


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : PHYCTRL_0_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      phy_suspendm_low  <= 1'b0;
    `ifdef CDNSUSBHS_SLEEPM_50REF
      phy_sleepm_ref    <= 1'b1;
      phy_sleepm_ref_   <= 1'b0;
    `else
      phy_sleepm_ref    <= 1'b0;
    `endif
      phy_reset         <= 1'b0;
      phy_databus_reset <= 1'b0;
      phy_powerdown     <= {2{1'b0}};
      end
    else
      begin
      if (upaddr == 8'h77 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1)
        begin
        phy_suspendm_low  <= updatai_3[7];
      `ifdef CDNSUSBHS_SLEEPM_50REF
        phy_sleepm_ref_   <= updatai_3[6];
      `else
        phy_sleepm_ref    <= updatai_3[6];
      `endif
        phy_reset         <= updatai_3[3];
        phy_databus_reset <= updatai_3[2];
        phy_powerdown     <= updatai_3[1:0];
        end
      end
    end
  `endif

  `ifdef CDNSUSB2PHY_3RD
  `else


  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : PHYCTRL_2_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      phy_pll_clkon       <= 1'b0;
      phy_pll_standalone  <= 1'b0;
      phy_pll_clk_sel     <= 2'b00;
      end
    else
      begin
      if (upaddr == 8'h76 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1)
        begin
        phy_pll_clkon       <= updatai_3[7];
        phy_pll_standalone  <= updatai_3[6];
        phy_pll_clk_sel     <= updatai_3[5:4];
        end
      end
    end
  `endif



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : HSDISABLE_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      hsdisable <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'h6A &&
          updataival_1 == 1'b1 &&
          upwr == 1'b1)
        begin

        hsdisable <= updatai_1[7] ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ISOSOFPULSE_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      isosofpulse   <= 1'b0 ;
      isosofpulseup <= 1'b0 ;
      end
    else
      begin
      isosofpulse   <= isosofpulserequp ;
      isosofpulseup <= isosofpulse ;
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : DEBUG_RX_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      debug_rx_status   <= {4{1'b0}} ;
      debug_rx_pid      <= {4{1'b0}} ;
      debug_rx_databyte <= {11{1'b0}} ;
      end
    else
      begin
      if (debug_rx_req == 1'b1)
        begin
        debug_rx_status   <= debug_rx[18:15] ;
        debug_rx_pid      <= debug_rx[14:11] ;
        debug_rx_databyte <= debug_rx[10:0] ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : DEBUG_TX_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      debug_tx_pid      <= {4{1'b0}} ;
      debug_tx_databyte <= {11{1'b0}} ;
      end
    else
      begin
      if (debug_tx_req == 1'b1)
        begin
        debug_tx_pid      <= debug_tx[14:11] ;
        debug_tx_databyte <= debug_tx[10:0] ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : DEBUG_TX_IRQ_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      debug_tx_irq <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'hF4 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1 && updatai_3[7] == 1'b1)
        begin
        debug_tx_irq <= 1'b0;
        end
      else if (debug_tx_req == 1'b1)
        begin
        debug_tx_irq <= 1'b1;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : DEBUG_RX_IRQ_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      debug_rx_irq <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'hF4 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1 && updatai_3[6] == 1'b1)
        begin
        debug_rx_irq <= 1'b0;
        end
      else if (debug_rx_req == 1'b1)
        begin
        debug_rx_irq <= 1'b1;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : WORKAROUND_A_IRQ_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      workaround_a_irq <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'hF4 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1 && updatai_3[0] == 1'b1)
        begin
        workaround_a_irq <= 1'b0;
        end
      else if (workaround_a_req == 1'b1)
        begin
        workaround_a_irq <= 1'b1;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : DEBUG_IEN_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      debug_tx_ien     <= 1'b0 ;
      debug_rx_ien     <= 1'b0 ;
      workaround_a_ien <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'hF5 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1)
        begin
        debug_tx_ien     <= updatai_3[7] ;
        debug_rx_ien     <= updatai_3[6] ;
        workaround_a_ien <= updatai_3[0] ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : WORKAROUND_ENABLE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
    `ifdef CDNSUSBHS_WORKAROUND_X_ENABLE
      workaround_a_enable <= 1'b1 ;
      workaround_b_enable <= 1'b1 ;
      workaround_c_enable <= 1'b1 ;
      workaround_d_enable <= 1'b1 ;
    `else
      workaround_a_enable <= 1'b0 ;
      workaround_b_enable <= 1'b0 ;
      workaround_c_enable <= 1'b0 ;
      workaround_d_enable <= 1'b0 ;
    `endif

      workaround_sfr_rst  <= 1'b0 ;
      end
    else
      begin
      if (upaddr == 8'hF6 &&
          updataival_0 == 1'b1 &&
          upwr == 1'b1)
        begin
        workaround_a_enable <= updatai_0[0] ;
        workaround_b_enable <= updatai_0[1] ;
        workaround_c_enable <= updatai_0[2] ;
        workaround_d_enable <= updatai_0[3] ;

        workaround_sfr_rst  <= updatai_0[7] ;
        end
      else
        begin
        workaround_sfr_rst  <= 1'b0 ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : WORKAROUND_A_VALUE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      workaround_a_value <= 4'hE;
      end
    else
      begin
      if (upaddr == 8'hF6 &&
          updataival_1 == 1'b1 &&
          upwr == 1'b1)
        begin
        workaround_a_value <= updatai_1[3:0] ;
        end
      end
    end



  assign debug_irq_m = ({debug_tx_irq, debug_rx_irq, workaround_a_irq} &
                        {debug_tx_ien, debug_rx_ien, workaround_a_ien});



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : WORKAROUND_OTG_ENABLE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      workaround_otg <= 3'b011 ;
      end
    else
      begin
      if (upaddr == 8'hF6 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1)
        begin
        workaround_otg <= {updatai_3[4], updatai_3[1:0]} ;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : SOF_RCV_DISABLE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
    `ifdef CDNSUSBHS_SOF_RCV_DISABLE
      sof_rcv_disable <= 1'b1;
    `else
      sof_rcv_disable <= 1'b0;
    `endif
      end
    else
      begin
      if (upaddr == 8'hF6 &&
          updataival_3 == 1'b1 &&
          upwr == 1'b1)
        begin
        sof_rcv_disable <= updatai_3[7] ;
        end
      end
    end

endmodule

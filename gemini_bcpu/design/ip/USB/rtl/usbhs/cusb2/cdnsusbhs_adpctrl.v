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
//   Filename:           cdnsusbhs_adpctrl.v
//   Module Name:        cdnsusbhs_adpctrl
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
//   Attach Detection Protocol controller
//   T.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_adpctrl
  (
  upclk,
  uprst,

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
  bc_dmpulldown,
  bc_dppulldown,
  bc_pulldownctrl,

  sessend,
  otgsessvalid,
  linestate,

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
  rid_gnd_comp_sts

  );



  input                        upclk;
  input                        uprst;



  input  [4:0]                 adpbc_ctrl_0;
  input  [5:0]                 adpbc_ctrl_1;
  input  [7:0]                 adpbc_ctrl_2;

  output [7:0]                 adpbc_status_0;
  wire   [7:0]                 adpbc_status_0;
  output [7:0]                 adpbc_status_1;
  wire   [7:0]                 adpbc_status_1;
  output [4:0]                 adpbc_status_2;
  wire   [4:0]                 adpbc_status_2;

  output                       adpbc_rid_float_fall;
  reg                          adpbc_rid_float_fall;
  output                       adpbc_rid_float_rise;
  reg                          adpbc_rid_float_rise;
  output                       adpbc_rid_gnd_rise;
  reg                          adpbc_rid_gnd_rise;
  output                       adpbc_rid_c_rise;
  reg                          adpbc_rid_c_rise;
  output                       adpbc_rid_b_rise;
  reg                          adpbc_rid_b_rise;
  output                       adpbc_rid_a_rise;
  reg                          adpbc_rid_a_rise;
  output                       adpbc_sessend_rise;
  reg                          adpbc_sessend_rise;
  output                       adpbc_otgsessvalid_rise;
  reg                          adpbc_otgsessvalid_rise;
  output                       adpbc_sense_rise;
  reg                          adpbc_sense_rise;
  output                       adpbc_probe_rise;
  reg                          adpbc_probe_rise;

  output                       dm_vdat_ref_rise;
  reg                          dm_vdat_ref_rise;
  output                       dp_vdat_ref_rise;
  reg                          dp_vdat_ref_rise;

  output                       dcd_comp_rise;
  reg                          dcd_comp_rise;
  output                       dcd_comp_fall;
  reg                          dcd_comp_fall;
  output                       dm_vlgc_comp_rise;
  reg                          dm_vlgc_comp_rise;


  output                       adp_en;
  wire                         adp_en;
  output                       adp_probe_en;
  wire                         adp_probe_en;
  output                       adp_sense_en;
  wire                         adp_sense_en;
  output                       adp_sink_current_en;
  wire                         adp_sink_current_en;
  output                       adp_source_current_en;
  wire                         adp_source_current_en;

  output                       bc_en;
  wire                         bc_en;
  output                       dm_vdat_ref_comp_en;
  wire                         dm_vdat_ref_comp_en;
  output                       dm_vlgc_comp_en;
  wire                         dm_vlgc_comp_en;
  output                       dp_vdat_ref_comp_en;
  wire                         dp_vdat_ref_comp_en;
  output                       idm_sink_en;
  wire                         idm_sink_en;
  output                       idp_sink_en;
  wire                         idp_sink_en;
  output                       idp_src_en;
  wire                         idp_src_en;
  output                       vdm_src_en;
  wire                         vdm_src_en;
  output                       vdp_src_en;
  wire                         vdp_src_en;
  output                       rid_float_comp_en;
  wire                         rid_float_comp_en;
  output                       rid_nonfloat_comp_en;
  wire                         rid_nonfloat_comp_en;
  output                       bc_dmpulldown;
  wire                         bc_dmpulldown;
  output                       bc_dppulldown;
  wire                         bc_dppulldown;
  output                       bc_pulldownctrl;
  wire                         bc_pulldownctrl;

  input                        sessend;
  input                        otgsessvalid;
  input  [1:0]                 linestate;
  input                        adp_probe_ana;
  input                        adp_sense_ana;
  input                        dcd_comp_sts;
  input                        dm_vdat_ref_comp_sts;
  input                        dm_vlgc_comp_sts;
  input                        dp_vdat_ref_comp_sts;
  input                        rid_a_comp_sts;
  input                        rid_b_comp_sts;
  input                        rid_c_comp_sts;
  input                        rid_float_comp_sts;
  input                        rid_gnd_comp_sts;


  reg                           rid_a;
  reg                           rid_b;
  reg                           rid_c;
  reg                           rid_float;
  reg                           rid_gnd;

  reg                           rid_a_comp_sts_r;
  reg                           rid_b_comp_sts_r;
  reg                           rid_c_comp_sts_r;
  reg                           rid_float_comp_sts_r;
  reg                           rid_gnd_comp_sts_r;
  reg                           sessend_r;
  reg                           otgsessvalid_r;
  reg                           adp_probe_ana_r;
  reg                           adp_sense_ana_r;
  reg                           dm_vdat_ref_comp_sts_r;
  reg                           dp_vdat_ref_comp_sts_r;
  reg                           dcd_comp_sts_r;
  reg                           dm_vlgc_comp_sts_r;



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : COMP_STATUS_FF_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      rid_a_comp_sts_r        <= 1'b0;
      rid_b_comp_sts_r        <= 1'b0;
      rid_c_comp_sts_r        <= 1'b0;
      rid_float_comp_sts_r    <= 1'b0;
      rid_gnd_comp_sts_r      <= 1'b0;
      sessend_r               <= 1'b0;
      otgsessvalid_r          <= 1'b0;
      adp_probe_ana_r         <= 1'b0;
      adp_sense_ana_r         <= 1'b0;
      dm_vdat_ref_comp_sts_r  <= 1'b0;
      dp_vdat_ref_comp_sts_r  <= 1'b0;
      dcd_comp_sts_r          <= 1'b0;
      dm_vlgc_comp_sts_r      <= 1'b0;
      end
    else
      begin
      rid_a_comp_sts_r        <= rid_a_comp_sts;
      rid_b_comp_sts_r        <= rid_b_comp_sts;
      rid_c_comp_sts_r        <= rid_c_comp_sts;
      rid_float_comp_sts_r    <= rid_float_comp_sts;
      rid_gnd_comp_sts_r      <= rid_gnd_comp_sts;
      sessend_r               <= sessend;
      otgsessvalid_r          <= otgsessvalid;
      adp_probe_ana_r         <= adp_probe_ana;
      adp_sense_ana_r         <= adp_sense_ana;
      dm_vdat_ref_comp_sts_r  <= dm_vdat_ref_comp_sts;
      dp_vdat_ref_comp_sts_r  <= dp_vdat_ref_comp_sts;
      dcd_comp_sts_r          <= dcd_comp_sts;
      dm_vlgc_comp_sts_r      <= dm_vlgc_comp_sts;
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : DM_VLGC_COMP_RISE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      dm_vlgc_comp_rise <= 1'b0;
      end
    else
      begin
      if (dm_vlgc_comp_sts_r == 1'b0 && dm_vlgc_comp_sts == 1'b1)
        begin
        dm_vlgc_comp_rise <= 1'b1;
        end
      else
        begin
        dm_vlgc_comp_rise <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : DCD_COMP_RISE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      dcd_comp_rise <= 1'b0;
      end
    else
      begin
      if (dcd_comp_sts_r == 1'b0 && dcd_comp_sts == 1'b1)
        begin
        dcd_comp_rise <= 1'b1;
        end
      else
        begin
        dcd_comp_rise <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : DCD_COMP_FALL_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      dcd_comp_fall <= 1'b0;
      end
    else
      begin
      if (dcd_comp_sts_r == 1'b1 && dcd_comp_sts == 1'b0)
        begin
        dcd_comp_fall <= 1'b1;
        end
      else
        begin
        dcd_comp_fall <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : DM_VDAT_REF_RISE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      dm_vdat_ref_rise <= 1'b0;
      end
    else
      begin
      if (dm_vdat_ref_comp_sts_r == 1'b0 && dm_vdat_ref_comp_sts == 1'b1)
        begin
        dm_vdat_ref_rise <= 1'b1;
        end
      else
        begin
        dm_vdat_ref_rise <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : DP_VDAT_REF_RISE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      dp_vdat_ref_rise <= 1'b0;
      end
    else
      begin
      if (dp_vdat_ref_comp_sts_r == 1'b0 && dp_vdat_ref_comp_sts == 1'b1)
        begin
        dp_vdat_ref_rise <= 1'b1;
        end
      else
        begin
        dp_vdat_ref_rise <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_PROBE_RISE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc_probe_rise <= 1'b0;
      end
    else
      begin
      if (adp_probe_ana_r == 1'b0 && adp_probe_ana == 1'b1)
        begin
        adpbc_probe_rise <= 1'b1;
        end
      else
        begin
        adpbc_probe_rise <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_SENSE_RISE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc_sense_rise <= 1'b0;
      end
    else
      begin
      if (adp_sense_ana_r == 1'b0 && adp_sense_ana == 1'b1)
        begin
        adpbc_sense_rise <= 1'b1;
        end
      else
        begin
        adpbc_sense_rise <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_OTGSESSVALID_RISE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc_otgsessvalid_rise <= 1'b0;
      end
    else
      begin
      if (otgsessvalid_r == 1'b0 && otgsessvalid == 1'b1)
        begin
        adpbc_otgsessvalid_rise <= 1'b1;
        end
      else
        begin
        adpbc_otgsessvalid_rise <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_SESSEND_RISE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc_sessend_rise <= 1'b0;
      end
    else
      begin
      if (sessend_r == 1'b0 && sessend == 1'b1)
        begin
        adpbc_sessend_rise <= 1'b1;
        end
      else
        begin
        adpbc_sessend_rise <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_RID_A_RISE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc_rid_a_rise <= 1'b0;
      end
    else
      begin
      if (rid_a_comp_sts_r == 1'b0 && rid_a_comp_sts == 1'b1 &&
          rid_nonfloat_comp_en == 1'b1)
        begin
        adpbc_rid_a_rise <= 1'b1;
        end
      else
        begin
        adpbc_rid_a_rise <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_RID_B_RISE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc_rid_b_rise <= 1'b0;
      end
    else
      begin
      if (rid_b_comp_sts_r == 1'b0 && rid_b_comp_sts == 1'b1 &&
          rid_nonfloat_comp_en == 1'b1)
        begin
        adpbc_rid_b_rise <= 1'b1;
        end
      else
        begin
        adpbc_rid_b_rise <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_RID_C_RISE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc_rid_c_rise <= 1'b0;
      end
    else
      begin
      if (rid_c_comp_sts_r == 1'b0 && rid_c_comp_sts == 1'b1 &&
          rid_nonfloat_comp_en == 1'b1)
        begin
        adpbc_rid_c_rise <= 1'b1;
        end
      else
        begin
        adpbc_rid_c_rise <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_RID_GND_RISE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc_rid_gnd_rise <= 1'b0;
      end
    else
      begin
      if (rid_gnd_comp_sts_r == 1'b0 && rid_gnd_comp_sts == 1'b1 &&
          rid_nonfloat_comp_en == 1'b1)
        begin
        adpbc_rid_gnd_rise <= 1'b1;
        end
      else
        begin
        adpbc_rid_gnd_rise <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_RID_FLOAT_RISE_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc_rid_float_rise <= 1'b0;
      end
    else
      begin
      if (rid_float_comp_sts_r == 1'b0 && rid_float_comp_sts == 1'b1 &&
          rid_float_comp_en == 1'b1)
        begin
        adpbc_rid_float_rise <= 1'b1;
        end
      else
        begin
        adpbc_rid_float_rise <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : ADPBC_RID_FLOAT_FALL_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      adpbc_rid_float_fall <= 1'b0;
      end
    else
      begin
      if (rid_float_comp_sts_r == 1'b1 && rid_float_comp_sts == 1'b0 &&
          rid_float_comp_en == 1'b1)
        begin
        adpbc_rid_float_fall <= 1'b1;
        end
      else
        begin
        adpbc_rid_float_fall <= 1'b0;
        end
      end
    end



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : RID_STATUS_FIXED_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      rid_a     <= 1'b0;
      rid_b     <= 1'b0;
      rid_c     <= 1'b0;
      rid_gnd   <= 1'b0;
      rid_float <= 1'b0;
      end
    else
      begin
      if (rid_float_comp_en == 1'b1 &&
          rid_nonfloat_comp_en == 1'b0 &&
          rid_float_comp_sts == 1'b1)
        begin
        rid_a     <= 1'b0;
        rid_b     <= 1'b0;
        rid_c     <= 1'b0;
        rid_gnd   <= 1'b0;
        rid_float <= 1'b1;
        end
      else if (rid_nonfloat_comp_en == 1'b1)
        begin
        rid_float <= 1'b0;
        if (rid_a_comp_sts_r == 1'b0 && rid_a_comp_sts == 1'b1)
          begin
          rid_a     <= 1'b1;
          rid_b     <= 1'b0;
          rid_c     <= 1'b0;
          rid_gnd   <= 1'b0;
          end
        else if (rid_b_comp_sts_r == 1'b0 && rid_b_comp_sts == 1'b1)
          begin
          rid_a     <= 1'b0;
          rid_b     <= 1'b1;
          rid_c     <= 1'b0;
          rid_gnd   <= 1'b0;
          end
        else if (rid_c_comp_sts_r == 1'b0 && rid_c_comp_sts == 1'b1)
          begin
          rid_a     <= 1'b0;
          rid_b     <= 1'b0;
          rid_c     <= 1'b1;
          rid_gnd   <= 1'b0;
          end
        else if (rid_gnd_comp_sts_r == 1'b0 && rid_gnd_comp_sts == 1'b1)
          begin
          rid_a     <= 1'b0;
          rid_b     <= 1'b0;
          rid_c     <= 1'b0;
          rid_gnd   <= 1'b1;
          end
        end
      end
    end



  assign adpbc_status_0 = {sessend,
                           adp_sense_ana,
                           adp_probe_ana,
                           otgsessvalid,
                           dcd_comp_sts,
                           dm_vdat_ref_comp_sts,
                           dm_vlgc_comp_sts,
                           dp_vdat_ref_comp_sts
                           };



  assign adpbc_status_1 = {linestate[1],
                           linestate[0],
                           1'b0,
                           rid_a_comp_sts,
                           rid_b_comp_sts,
                           rid_c_comp_sts,
                           rid_gnd_comp_sts,
                           rid_float_comp_sts
                           };



  assign adpbc_status_2 = {


                           rid_a,
                           rid_b,
                           rid_c,
                           rid_gnd,
                           rid_float
                           };



  assign adp_en                = adpbc_ctrl_0[0];
  assign adp_probe_en          = adpbc_ctrl_0[1];
  assign adp_sense_en          = adpbc_ctrl_0[2];
  assign adp_sink_current_en   = adpbc_ctrl_0[3];
  assign adp_source_current_en = adpbc_ctrl_0[4];



  assign bc_en                 = adpbc_ctrl_1[0];
  assign idm_sink_en           = adpbc_ctrl_1[1];
  assign idp_sink_en           = adpbc_ctrl_1[2];
  assign idp_src_en            = adpbc_ctrl_1[3];
  assign vdm_src_en            = adpbc_ctrl_1[4];
  assign vdp_src_en            = adpbc_ctrl_1[5];



  assign dm_vdat_ref_comp_en   = adpbc_ctrl_2[0];
  assign dm_vlgc_comp_en       = adpbc_ctrl_2[1];
  assign dp_vdat_ref_comp_en   = adpbc_ctrl_2[2];
  assign rid_float_comp_en     = adpbc_ctrl_2[3];
  assign rid_nonfloat_comp_en  = adpbc_ctrl_2[4];
  assign bc_dmpulldown         = adpbc_ctrl_2[5];
  assign bc_dppulldown         = adpbc_ctrl_2[6];
  assign bc_pulldownctrl       = adpbc_ctrl_2[7];

endmodule

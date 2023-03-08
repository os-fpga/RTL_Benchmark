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
//   Filename:           cdnsusbhs_usbwrap.v
//   Module Name:        cdnsusbhs_usbwrap
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
//   UTMI Signals multiplexer
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_usbwrap
  (


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

  wakeup5kclk,
  wakeup5krst,

  wakeupid,
  wakeupdp,
  wakeupvbus,


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

  cusb2_utmitxvalid,
  cusb2_utmidatain,
  cusb2_utmisuspendm,
  cusb2_utmisleepm,
  cusb2_utmiopmode,
  cusb2_utmitermselect,
  cusb2_utmixcvrselect
  );


  input                            utmiclk;
  input                            utmirst;
  input                            utmitxready;
  input                            utmirxactive;
  input                            utmirxerror;
  input                            utmirxvalid;
  input  [7:0]                     utmidataout;
  input  [1:0]                     utmilinestate;
  input                            utmivbusvalid;
  input                            utmiavalid;
  input                            utmibvalid;
  input                            utmisessend;
  input                            utmiiddig;
  input                            utmihostdiscon;


  output                           utmitxvalid;
  wire                             utmitxvalid;
  output [7:0]                     utmidatain;
  wire   [7:0]                     utmidatain;
  output                           utmisuspendm;
  wire                             utmisuspendm;
  output                           utmisleepm;
  wire                             utmisleepm;
  output [1:0]                     utmiopmode;
  wire   [1:0]                     utmiopmode;
  output                           utmitermselect;
  wire                             utmitermselect;
  output [1:0]                     utmixcvrselect;
  wire   [1:0]                     utmixcvrselect;
  output                           utmiidpullup;
  wire                             utmiidpullup;
  output                           utmidppulldown;
  wire                             utmidppulldown;
  output                           utmidmpulldown;
  wire                             utmidmpulldown;
  output                           utmidrvvbus;
  wire                             utmidrvvbus;
  output                           utmichrgvbus;
  wire                             utmichrgvbus;
  output                           utmidischrgvbus;
  wire                             utmidischrgvbus;

  output                           adp_en;
  wire                             adp_en;
  output                           adp_probe_en;
  wire                             adp_probe_en;
  output                           adp_sense_en;
  wire                             adp_sense_en;
  output                           adp_sink_current_en;
  wire                             adp_sink_current_en;
  output                           adp_source_current_en;
  wire                             adp_source_current_en;

  output                           bc_en;
  wire                             bc_en;
  output                           dm_vdat_ref_comp_en;
  wire                             dm_vdat_ref_comp_en;
  output                           dm_vlgc_comp_en;
  wire                             dm_vlgc_comp_en;
  output                           dp_vdat_ref_comp_en;
  wire                             dp_vdat_ref_comp_en;
  output                           idm_sink_en;
  wire                             idm_sink_en;
  output                           idp_sink_en;
  wire                             idp_sink_en;
  output                           idp_src_en;
  wire                             idp_src_en;
  output                           vdm_src_en;
  wire                             vdm_src_en;
  output                           vdp_src_en;
  wire                             vdp_src_en;
  output                           rid_float_comp_en;
  wire                             rid_float_comp_en;
  output                           rid_nonfloat_comp_en;
  wire                             rid_nonfloat_comp_en;

  input                            adp_probe_ana;
  input                            adp_sense_ana;
  input                            dcd_comp_sts;
  input                            dm_vdat_ref_comp_sts;
  input                            dm_vlgc_comp_sts;
  input                            dp_vdat_ref_comp_sts;
  input                            rid_a_comp_sts;
  input                            rid_b_comp_sts;
  input                            rid_c_comp_sts;
  input                            rid_float_comp_sts;
  input                            rid_gnd_comp_sts;

  input                            wakeup5kclk;
  input                            wakeup5krst;

  output                           wakeupid;
  wire                             wakeupid;
  output                           wakeupdp;
  wire                             wakeupdp;
  output                           wakeupvbus;
  wire                             wakeupvbus;


  input                            cusb2_utmitxvalid;
  input  [7:0]                     cusb2_utmidatain;
  input                            cusb2_utmisuspendm;
  input                            cusb2_utmisleepm;
  input  [1:0]                     cusb2_utmiopmode;
  input                            cusb2_utmitermselect;
  input  [1:0]                     cusb2_utmixcvrselect;
  input                            cusb2_utmiidpullup;
  input                            cusb2_utmidppulldown;
  input                            cusb2_utmidmpulldown;
  input                            cusb2_utmidrvvbus;
  input                            cusb2_utmichrgvbus;
  input                            cusb2_utmidischrgvbus;

  input                            cusb2_adp_en;
  input                            cusb2_adp_probe_en;
  input                            cusb2_adp_sense_en;
  input                            cusb2_adp_sink_current_en;
  input                            cusb2_adp_source_current_en;

  input                            cusb2_bc_en;
  input                            cusb2_dm_vdat_ref_comp_en;
  input                            cusb2_dm_vlgc_comp_en;
  input                            cusb2_dp_vdat_ref_comp_en;
  input                            cusb2_idm_sink_en;
  input                            cusb2_idp_sink_en;
  input                            cusb2_idp_src_en;
  input                            cusb2_vdm_src_en;
  input                            cusb2_vdp_src_en;
  input                            cusb2_rid_float_comp_en;
  input                            cusb2_rid_nonfloat_comp_en;

  output                           cusb2_adp_probe_ana;
  wire                             cusb2_adp_probe_ana;
  output                           cusb2_adp_sense_ana;
  wire                             cusb2_adp_sense_ana;
  output                           cusb2_dcd_comp_sts;
  wire                             cusb2_dcd_comp_sts;
  output                           cusb2_dm_vdat_ref_comp_sts;
  wire                             cusb2_dm_vdat_ref_comp_sts;
  output                           cusb2_dm_vlgc_comp_sts;
  wire                             cusb2_dm_vlgc_comp_sts;
  output                           cusb2_dp_vdat_ref_comp_sts;
  wire                             cusb2_dp_vdat_ref_comp_sts;
  output                           cusb2_rid_a_comp_sts;
  wire                             cusb2_rid_a_comp_sts;
  output                           cusb2_rid_b_comp_sts;
  wire                             cusb2_rid_b_comp_sts;
  output                           cusb2_rid_c_comp_sts;
  wire                             cusb2_rid_c_comp_sts;
  output                           cusb2_rid_float_comp_sts;
  wire                             cusb2_rid_float_comp_sts;
  output                           cusb2_rid_gnd_comp_sts;
  wire                             cusb2_rid_gnd_comp_sts;


  output                           cusb2_utmitxready;
  wire                             cusb2_utmitxready;
  output                           cusb2_utmirxactive;
  wire                             cusb2_utmirxactive;
  output                           cusb2_utmirxerror;
  wire                             cusb2_utmirxerror;
  output                           cusb2_utmirxvalid;
  wire                             cusb2_utmirxvalid;
  output [7:0]                     cusb2_utmidataout;
  wire   [7:0]                     cusb2_utmidataout;
  output [1:0]                     cusb2_utmilinestate;
  wire   [1:0]                     cusb2_utmilinestate;

  output                           cusb2_utmivbusvalid;
  wire                             cusb2_utmivbusvalid;
  output                           cusb2_utmiavalid;
  wire                             cusb2_utmiavalid;
  output                           cusb2_utmibvalid;
  wire                             cusb2_utmibvalid;
  output                           cusb2_utmisessend;
  wire                             cusb2_utmisessend;
  output                           cusb2_utmiiddig;
  wire                             cusb2_utmiiddig;
  output                           cusb2_utmihostdiscon;
  wire                             cusb2_utmihostdiscon;





  wire [
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      8 +
                      1 +
                      1 +
                      2 +
                      1 +
                      2
                        - 1:0] utmi_inputs_from_cusb2;


  assign utmi_inputs_from_cusb2 = {
                                   cusb2_utmiidpullup,
                                   cusb2_utmidppulldown,
                                   cusb2_utmidmpulldown,
                                   cusb2_utmidrvvbus,
                                   cusb2_utmichrgvbus,
                                   cusb2_utmidischrgvbus,
                                   cusb2_utmitxvalid,
                                   cusb2_utmidatain,
                                   cusb2_utmisuspendm,
                                   cusb2_utmisleepm,
                                   cusb2_utmiopmode,
                                   cusb2_utmitermselect,
                                   cusb2_utmixcvrselect
                                  };

  wire [
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1
                        - 1:0] adpbc_inputs_from_cusb2;


  assign adpbc_inputs_from_cusb2 = {
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
                                    cusb2_rid_nonfloat_comp_en
                                   };





  wire [
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      8 +
                      2
                        - 1:0] utmi_outputs_to_cusb2;


  assign {
          cusb2_utmivbusvalid,
          cusb2_utmiavalid,
          cusb2_utmibvalid,
          cusb2_utmisessend,
          cusb2_utmiiddig,
          cusb2_utmihostdiscon,
          cusb2_utmitxready,
          cusb2_utmirxactive,
          cusb2_utmirxerror,
          cusb2_utmirxvalid,
          cusb2_utmidataout,
          cusb2_utmilinestate} = utmi_outputs_to_cusb2;

  wire [
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1
                        - 1:0] adpbc_outputs_to_cusb2;


  assign {
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
          cusb2_rid_gnd_comp_sts} = adpbc_outputs_to_cusb2;





  wire [
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      8 +
                      2
                        - 1:0] utmi_inputs;

  assign utmi_inputs = {
                        utmivbusvalid,
                        utmiavalid,
                        utmibvalid,
                        utmisessend,
                        utmiiddig,
                        utmihostdiscon,
                        utmitxready,
                        utmirxactive,
                        utmirxerror,
                        utmirxvalid,
                        utmidataout,
                        utmilinestate
                        };

  wire [
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1
                        - 1:0] adpbc_inputs;

  assign adpbc_inputs = {
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
                         };





  wire [
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      8 +
                      1 +
                      1 +
                      2 +
                      1 +
                      2
                        - 1:0] utmi_outputs;

  assign {
          utmiidpullup,
          utmidppulldown,
          utmidmpulldown,
          utmidrvvbus,
          utmichrgvbus,
          utmidischrgvbus,
          utmitxvalid,
          utmidatain,
          utmisuspendm,
          utmisleepm,
          utmiopmode,
          utmitermselect,
          utmixcvrselect} = utmi_outputs;

  wire [
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1 +
                      1
                        - 1:0] adpbc_outputs;

  assign {
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
          rid_nonfloat_comp_en} = adpbc_outputs;

  wire                             utmiwakeupid;
  wire                             utmiwakeupdp;
  wire                             utmiwakeupvbus;





  cdnsusbhs_wudet
  U_CDNSUSBHS_WUDET_UTMI
    (
    .utmiclk                            (utmiclk),
    .utmirst                            (utmirst),
    .wakeup5kclk                        (wakeup5kclk),
    .wakeup5krst                        (wakeup5krst),
    .utmiiddig                          (utmiiddig),
    .utmilinestate                      (utmilinestate),
    .utmivbusvalid                      (utmivbusvalid),
    .utmiavalid                         (utmiavalid),

    .wakeupid                           (utmiwakeupid),
    .wakeupdp                           (utmiwakeupdp),
    .wakeupvbus                         (utmiwakeupvbus)
    );





  assign utmi_outputs_to_cusb2 =                      utmi_inputs ;





  assign {wakeupid,
          wakeupdp,
          wakeupvbus} =                      { utmiwakeupid,  utmiwakeupdp,  utmiwakeupvbus} ;




  assign adpbc_outputs_to_cusb2 =                      adpbc_inputs ;




  assign utmi_outputs =                      utmi_inputs_from_cusb2 ;




  assign adpbc_outputs =                      adpbc_inputs_from_cusb2 ;

endmodule
